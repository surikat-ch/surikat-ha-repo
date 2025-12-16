package main

import (
	"crypto/sha256"
	"encoding/hex"
	"os"
	"path/filepath"

	"github.com/gofiber/fiber/v2"
	"gopkg.in/yaml.v3"
)

const configDir = "/config"

func main() {
	app := fiber.New()

	app.Get("/health", func(c *fiber.Ctx) error {
		return c.SendString("ok")
	})

	app.Get("/config/:file", readConfig)
	app.Post("/config/validate", validateYAML)
	app.Post("/config/save", saveConfig)

	app.Listen(":8129")
}

func readConfig(c *fiber.Ctx) error {
	file := c.Params("file")

	path := filepath.Join(configDir, file)
	data, err := os.ReadFile(path)
	if err != nil {
		return fiber.ErrNotFound
	}

	hash := sha256.Sum256(data)

	return c.JSON(fiber.Map{
		"content": string(data),
		"sha256":  hex.EncodeToString(hash[:]),
	})
}

func validateYAML(c *fiber.Ctx) error {
	var body struct {
		Content string `json:"content"`
	}

	if err := c.BodyParser(&body); err != nil {
		return fiber.ErrBadRequest
	}

	var parsed any
	if err := yaml.Unmarshal([]byte(body.Content), &parsed); err != nil {
		return c.Status(400).JSON(fiber.Map{
			"valid": false,
			"error": err.Error(),
		})
	}

	return c.JSON(fiber.Map{
		"valid": true,
	})
}

func saveConfig(c *fiber.Ctx) error {
	var body struct {
		File    string `json:"file"`
		Content string `json:"content"`
	}

	if err := c.BodyParser(&body); err != nil {
		return fiber.ErrBadRequest
	}

	path := filepath.Join(configDir, body.File)

	// Backup
	if old, err := os.ReadFile(path); err == nil {
		os.WriteFile(path+".bak", old, 0644)
	}

	// Validation YAML
	var parsed any
	if err := yaml.Unmarshal([]byte(body.Content), &parsed); err != nil {
		return c.Status(400).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	if err := os.WriteFile(path, []byte(body.Content), 0644); err != nil {
		return fiber.ErrInternalServerError
	}

	return c.JSON(fiber.Map{
		"status": "saved",
	})
}

package config

import (
	"fmt"
	"testing"
)

func TestNew(t *testing.T) {
	wantPort := 80
	t.Setenv("PORT", fmt.Sprint(wantPort))

	got, err := New()

	if err != nil {
		t.Fatalf("failed to create config: %v", err)
	}
	if got.Port != wantPort {
		t.Errorf("got %d, want %d", got.Port, wantPort)
	}

	wantEnv := "dev"
	if got.Env != wantEnv {
		t.Errorf("got %q, want %q", got.Env, wantEnv)
	}
}

/*
================================================================
  FILE    : 01_setup_database.sql
  PURPOSE : Creates the BellaBeat database if it does not exist
            and sets it as the active context for all subsequent
            scripts.
  RUN     : Execute once before all other scripts.
================================================================
*/

IF DB_ID('BellaBeat') IS NULL
    CREATE DATABASE BellaBeat;
GO

USE BellaBeat;
GO

# fintonic-challenge

## Descripción General

Aplicación iOS desarrollada en Swift que procesa órdenes militares/tácticas en formato JSON para calcular coordenadas objetivo basadas en diferentes protocolos de combate. La app permite tanto ingresar órdenes manualmente en formato JSON como crearlas visualmente mediante una interfaz gráfica.

## Arquitectura

El proyecto sigue una arquitectura modular organizada en tres capas principales siguiendo la estructura de clean architecture, pero prescindiendo de la capa de data ya que no hay conexiones con bases de datos locales ni llamadas a red.

#### Domain (Dominio)
- **Entities**: Definen los modelos de datos inmutables
  - `Order`: Estructura de una orden con protocolos y escaneos
  - `Protocols`: Enumeración de protocolos de combate disponibles
  - `Target`: Coordenadas X,Y del objetivo calculado
  
- **Logic**: Contiene la lógica de negocio
  - `Processor`: Calcula coordenadas objetivo según protocolos activos
  - `OrderBuilder`: Construye objetos Order y genera JSON
  - `ScanData`: Modelo mutable para construcción de escaneos

#### Presentation (Presentación)
- **MainView**: Pantalla de entrada manual de órdenes JSON
- **CreateOrderView**: Interfaz gráfica para crear órdenes visualmente
- **ViewModels**: Gestionan el estado y orquestan la lógica de negocio

## Funcionalidades

### 1. Entrada Manual de Órdenes (MainView)
- Campo de texto para ingresar JSON de órdenes
- Botón "Send order" para procesar y mostrar resultado
- Botón "Create order" para navegar a la vista de creación visual

### 2. Creación Visual de Órdenes (CreateOrderView)
- **Selección de Protocolos**: Toggles nativos para activar/desactivar protocolos
- **Gestión de Scans**: 
  - Botón "+" para añadir puntos de escaneo
  - Configuración de coordenadas X,Y
  - Selección de tipo de enemigo (Soldier/Mech)
  - Control de número de enemigos
  - Toggle para indicar presencia de aliados
- **Ejecución**: Genera el JSON y calcula coordenadas objetivo

### 3. Protocolos de Combate Disponibles

- **Closest Enemies**: Selecciona el enemigo más cercano
- **Furthest Enemies**: Selecciona el enemigo más lejano 
- **Assist Allies**: Filtra solo puntos con aliados
- **Avoid Crossfire**: Filtra puntos sin aliados
- **Prioritize Mech**: Filtra solo enemigos tipo Mech, de no haber fijara otro tipo
- **Avoid Mech**: Filtra solo enemigos tipo Soldier

Para crear nuevos protocolos de combate tan solo habría que definir un nuevo caso en el enumerado de Protocols y en Orders definir la lógica de este ya sea de filtrado o de distancia.


## Tecnologías Utilizadas

- **Swift 6.0**
- **SwiftUI**: Framework de UI declarativo
- **Codable**: Serialización/deserialización JSON
- **ObservableObject**: Gestión de estado reactivo en objetos

## Requisitos

- iOS 16.0+
- Xcode 15.0+
- Swift Playgrounds (para .swiftpm)

## Ejecución

1. Abrir `test.swiftpm` en Xcode o Swift Playgrounds
2. Seleccionar simulador o dispositivo iOS
3. Ejecutar (Cmd + R)

## Autoría

Jose J Escudero Gómez (JJ)

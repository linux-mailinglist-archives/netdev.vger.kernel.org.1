Return-Path: <netdev+bounces-181116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8A1A83B4A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8780F9E311A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEEE204582;
	Thu, 10 Apr 2025 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALJX1Ds/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586DA1EFFA4;
	Thu, 10 Apr 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270170; cv=none; b=nqk4xQmDwVI8hPUT5//N/phaWcJi9e5a+XhBfj0blwtsTtII07MTIUM/TvcRExLtw409J0goZVDANr0QPrfD85SSb0t00KYL7wgbECEs20wJATkQ8C2vi7W5lSb/fiS3O0Cp9txWOuYwIRAIVbmrqBQfBxgr4ftlik/4opS9m6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270170; c=relaxed/simple;
	bh=9wI4FzW4dvPTJaaSaTVoIrjJlrBAMIwR0zeIruLJujo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxIlB9X0lK2+VcGqR/927m7WEa9hHgGBptJ3oIu9HOodmq1AQaKqMZwtzBFfTETZFv57OZ47LBIEaAoY5IzG7CFsiMj/h5iwIooY8v0UaHrJHmil9lhnFHVQaiMHCYt4l5W98g0FXe4+RP0TI7o+cS+PxHkRdCckYmCaB3OGIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALJX1Ds/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3C6C4CEDD;
	Thu, 10 Apr 2025 07:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744270169;
	bh=9wI4FzW4dvPTJaaSaTVoIrjJlrBAMIwR0zeIruLJujo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALJX1Ds/AVuStx7ClGgLEJ6F++y+T5sz8o+jketTwnYuvE8wZDAEquKUcpYFYS/3J
	 RZJNmKU6gn9GitNPbdU0pgQUvVZwQpUwBWVVRC+9xgv4FNPqKjXSWn2Iu9T5gtkiPN
	 OFvQBQD7ExUj7rf6WIYwYeEopzCoaNFnITLd3HPt/Fv7GiBjCS4FSXiErDDgkRWXDM
	 /CZDqvEGwthnwDhvCltO9K/GSJYpeFLvJw5T6Tp83LhAOD8hxFCcKkNdjLO2Q0RomM
	 B70r9oIT0YFruQ3GLP7uSVw62QiPGziYTTawRNV/QeWKMsoqtlWCSd/eiZwQSehrc/
	 IQ9jHAp5wAOnA==
Date: Thu, 10 Apr 2025 08:29:23 +0100
From: Lee Jones <lee@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Add Microchip ZL3073x support (part 1)
Message-ID: <20250410072923.GK372032@google.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409144250.206590-1-ivecera@redhat.com>

On Wed, 09 Apr 2025, Ivan Vecera wrote:

> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
> provides DPLL and PTP functionality. This series bring first part
> that adds the common MFD driver that provides an access to the bus
> that can be either I2C or SPI.
> 
> The next series will bring the DPLL driver that will covers DPLL
> functionality. And another ones will bring PTP driver and flashing
> capability via devlink.
> 
> Testing was done by myself and by Prathosh Satish on Microchip EDS2
> development board with ZL30732 DPLL chip connected over I2C bus.
> 
> Patch breakdown
> ===============
> Patch 1 - Common DT schema for DPLL device and pin
> Patch 3 - Basic support for I2C, SPI and regmap
> Patch 4 - Devlink registration
> Patches 5-6 - Helpers for accessing device registers
> Patches 7-8 - Component versions reporting via devlink dev info
> Patches 9-10 - Helpers for accessing register mailboxes
> Patch 11 - Clock ID generation for DPLL driver
> Patch 12 - Export strnchrnul function for modules
>            (used by next patch)
> Patch 13 - Support for MFG config initialization file
> Patch 14 - Fetch invariant register values used by DPLL and later by
>            PTP driver
> 
> Ivan Vecera (14):
>   dt-bindings: dpll: Add device tree bindings for DPLL device and pin
>   dt-bindings: dpll: Add support for Microchip Azurite chip family
>   mfd: Add Microchip ZL3073x support
>   mfd: zl3073x: Register itself as devlink device
>   mfd: zl3073x: Add register access helpers
>   mfd: zl3073x: Add macros for device registers access
>   mfd: zl3073x: Add components versions register defs
>   mfd: zl3073x: Implement devlink device info
>   mfd: zl3073x: Add macro to wait for register value bits to be cleared
>   mfd: zl3073x: Add functions to work with register mailboxes
>   mfd: zl3073x: Add clock_id field
>   lib: Allow modules to use strnchrnul
>   mfd: zl3073x: Load mfg file into HW if it is present
>   mfd: zl3073x: Fetch invariants during probe
> 
>  .../devicetree/bindings/dpll/dpll-device.yaml |  76 ++
>  .../devicetree/bindings/dpll/dpll-pin.yaml    |  44 +
>  .../bindings/dpll/microchip,zl3073x-i2c.yaml  |  74 ++
>  .../bindings/dpll/microchip,zl3073x-spi.yaml  |  77 ++
>  MAINTAINERS                                   |  11 +
>  drivers/mfd/Kconfig                           |  32 +
>  drivers/mfd/Makefile                          |   5 +
>  drivers/mfd/zl3073x-core.c                    | 883 ++++++++++++++++++
>  drivers/mfd/zl3073x-i2c.c                     |  59 ++
>  drivers/mfd/zl3073x-spi.c                     |  59 ++
>  drivers/mfd/zl3073x.h                         |  14 +
>  include/linux/mfd/zl3073x.h                   | 363 +++++++
>  lib/string.c                                  |   1 +
>  13 files changed, 1698 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
>  create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
>  create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
>  create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml
>  create mode 100644 drivers/mfd/zl3073x-core.c
>  create mode 100644 drivers/mfd/zl3073x-i2c.c
>  create mode 100644 drivers/mfd/zl3073x-spi.c
>  create mode 100644 drivers/mfd/zl3073x.h
>  create mode 100644 include/linux/mfd/zl3073x.h

FWIW, I'm not planning to even look at this until Andy and Krzysztof are
satisfied.  What I will say is that all of those horrible macros will
have to be removed and no abstractions will be accepted unless they are
accompanied with very good reasons as to why they are required.

-- 
Lee Jones [李琼斯]


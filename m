Return-Path: <netdev+bounces-181526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB304A85562
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22DB4454AE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 07:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100CD2857ED;
	Fri, 11 Apr 2025 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGFCGQyC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FD27E1BA;
	Fri, 11 Apr 2025 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744356382; cv=none; b=kNQqR2cxQRm2czEnw5z0kzVwazTHXXEq55V7BWJMSIVuMeO/QZ5ge9knbNr9QR0jxWtujUeVTMKqvZFL6LuaC53GOEfI5U5AWiL4lkVDBZqATOB9o2ditEfoZ1EQVtVM9Pcd5RGJmcXPjQzrt6pyX4ctBkUaQz3w6zhmC9DUtxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744356382; c=relaxed/simple;
	bh=5Rg6L5vCgyyzAuifngdzvR71Cxvlb+0w2mCfgATmgcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFm7u2xkVBxroql5WnWTrRxrYKBIomTrJ0mzn6AYYYawZCoBTPl/o6gJ3nn3OBr3RGBFcekPWp7MfO7iVVQqznbcG8IhkHAqGl4hN17ntHsFt60KSAZHKRR76VBM7fDVQKny0bgvSUCvJswHnogdQbfu8LOG8dvuwLULlnARQL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGFCGQyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24432C4CEE2;
	Fri, 11 Apr 2025 07:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744356382;
	bh=5Rg6L5vCgyyzAuifngdzvR71Cxvlb+0w2mCfgATmgcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGFCGQyCjTxLmWdaiiMoMRvSSsATBuLX+9GFCwSFmWkr4kDyoLU7cBPWlkzLl2vRN
	 sOBxcLkTJJj1uEJW8qiZnKNBJeq/8KaIGUdVolR6m/b2TaSmKeh+3cTdfr+GYvjJFv
	 pSwNR7A4iNHJ5LX0pe3LdKUyV0k8GfXzS7mcRJfyqtR5VkGVE9h9ZLaIXGzmIJ7gm1
	 VIbnr5yEHWBICw1Dcs5ffHL6ssMpRp25Wuyqbc4SPfeQbmnU3n+Qs2tzqlT65bMDAq
	 LxfrSgnxU2YTskh88+4BJA1TFOwNKLPes8yZwgU8WsnSUbhAdhqJLzI19iXpj4L/B9
	 lbVqGWE74AmyQ==
Date: Fri, 11 Apr 2025 08:26:16 +0100
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
Message-ID: <20250411072616.GU372032@google.com>
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

Not only are all of the added abstractions and ugly MACROs hard to read
and troublesome to maintain, they're also completely unnecessary at this
(driver) level.  Nicely authored, easy to read / maintain code wins over
clever code 95% of the time.  Exporting functions to pass around
pointers to private structures is also a non-starter.

After looking at the code, there doesn't appear to be any inclusion of
the MFD core header.  How can this be an MFD if you do not use the MFD
API?  MFD is not a dumping area for common code and call-backs.  It's a
subsystem used to neatly separate out and share resources between
functionality that just happens to share the same hardware chip.

-- 
Lee Jones [李琼斯]


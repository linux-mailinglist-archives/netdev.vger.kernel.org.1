Return-Path: <netdev+bounces-183673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E68A917F7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16AD460D08
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC29224AFA;
	Thu, 17 Apr 2025 09:33:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66274224AED
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744882391; cv=none; b=H7S802czG2indIe122IP2y+oeCrdCKnaE3jJsAl7RsYy3I3Z8fiLJ892P+NPzCzF/y6xrJKWYvocWOHh+Nbrxq9pSdh1+45Go1ETNalKRIlwaiAPQP1NLw4i5m5fRpJHyzBqfGFQIJzBR4fHnhdyjx/F+Wu+WyoPOMDEcaPV+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744882391; c=relaxed/simple;
	bh=5HxR8csm8fyNJrtqHHIIMUwA5KzfJLvNOgVPXyjfE2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw8qZGBB6KWLEk+ZwtdgjCYI+rbNBwb32uaob1KLkbcs+cvDIpkW8LSnekanjyrzwcTFVyYUdhz2lTmF5/3aBGEnCb2sHqwmJGIX/qtohcTcKukSWz2k+SpbQzLd2DJjaFDucT7CWlHq+GPzd5Ot0Zq6EmKdw3YXxUGLFdrfun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u5Lc8-0001sN-Hw; Thu, 17 Apr 2025 11:32:56 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u5Lc7-000j6u-3B;
	Thu, 17 Apr 2025 11:32:56 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u5Lc7-005taT-2m;
	Thu, 17 Apr 2025 11:32:55 +0200
Date: Thu, 17 Apr 2025 11:32:55 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] net: pse-pd: Add Si3474 PSE controller driver
Message-ID: <aADKx3sAiWO_2KG3@pengutronix.de>
References: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
 <93d3bbf0-742c-41d4-83c6-6d94a0dd779c@adtran.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93d3bbf0-742c-41d4-83c6-6d94a0dd779c@adtran.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Piotr,

Thanks again for the patch! Looking a bit deeper into the Si3474
architecture based on the datasheet and thinking about future
extensions, there's a challenge with how the chip mixes shared resources
with its two-quad/two-address I2C setup that we should probably tackle
architecturally.

The current approach, common for multi-address devices, is to treat each
I2C address (and thus each quad) as a separate i2c_client handled by
potentially independent driver instances. This works for the basic port
access implemented here, but might get complicated quickly for the
Si3474.

The Si3474 has several key resources that are inherently shared across
the whole chip package, not just per-quad:

- Single RESETb pin
- Single INTb pin
- Firmware Update
- Global Status (Temperature, VDD/VPWR UVLO)
- OSS Pin
- ... and likely others.

Trying to manage these shared aspects across two potentially independent
driver instances would a bit challenging :)

Proposed Architectural Change:

It seems much more robust to treat the entire Si3474 package as one
logical device within the driver. A possible approach could be:

1. The driver instance probed for the primary address (Quad 0)
takes ownership.
2. It finds/acquires the i2c_client for the secondary address (Quad
1).
3. The primary instance handles all shared resources (IRQ, global
state, etc.).
4. PSE controller registration (devm_pse_controller_register) happens
only once for all 8 logical PIs.
5. Internal functions use the "correct" i2c_client based on the target
channel/PI.

Search for i2c_new_ancillary_device()

Naming Conventions:

- Regarding naming, the goal is to align with IEEE 802.3 terminology where
  possible. Exzeption are register and bit names.

Regarding naming: Could you please rename `priv->port` (and similar variables
representing the logical PSE port/`id`) to `priv->pi`? This aligns better with
the IEEE 802.3 term 'PI' (Power Interface) for the logical port, avoiding the
datasheet's overloaded use of 'port'. We can stick with 'channel' internally
for the physical Si3474 control paths (0-7) ('ports'). Adding the introductory
comment explaining this would still be great too.

Regarding the current patch:
- The `PB_POWER_ENABLE_REG` seems to be 8-bit register, but the driver
  is using i2c_smbus_write_word_data(). Please use i2c_smbus_write_byte_data()
  or add a comment explaining why 'word' version is used.

A comment like this on the top of this driver would be helpful:

/*
 * Driver for the Skyworks Si3474 PoE PSE Controller
 *
 * Chip Architecture & Terminology:
 *
 * The Si3474 is a single-chip PoE PSE controller managing 8 physical power
 * delivery channels. Internally, it's structured into two logical "Quads".
 *
 * Quad 0: Manages physical channels ('ports' in datasheet) 0, 1, 2, 3
 * Quad 1: Manages physical channels ('ports' in datasheet) 4, 5, 6, 7
 *
 * Each Quad is accessed via a separate I2C address. The base address range is
 * set by hardware pins A1-A4, and the specific address selects Quad 0 (usually
 * the lower/even address) or Quad 1 (usually the higher/odd address).
 * See datasheet Table 2.2 for the address mapping.
 *
 * While the Quads manage channel-specific operations, the Si3474 package has
 * several resources shared across the entire chip:
 * - Single RESETb input pin.
 * - Single INTb output pin (signals interrupts from *either* Quad).
 * - Single OSS input pin (Emergency Shutdown).
 * - Global I2C Address (0x7F) used for firmware updates.
 * - Global status monitoring (Temperature, VDD/VPWR Undervoltage Lockout).
 *
 * Driver Architecture:
 *
 * To handle the mix of per-Quad access and shared resources correctly, this
 * driver treats the entire Si3474 package as one logical device. The driver
 * instance associated with the primary I2C address (Quad 0) takes ownership.
 * It discovers and manages the I2C client for the secondary address (Quad 1).
 * This primary instance handles shared resources like IRQ management and
 * registers a single PSE controller device representing all logical PIs.
 * Internal functions route I2C commands to the appropriate Quad's i2c_client
 * based on the target channel or PI.
 *
 * Terminology Mapping:
 *
 * - "PI" (Power Interface): Refers to the logical PSE port as defined by
 * IEEE 802.3 (typically corresponds to an RJ45 connector). This is the
 * `id` (0-7) used in the pse_controller_ops.
 * - "Channel": Refers to one of the 8 physical power control paths within
 * the Si3474 chip itself (hardware channels 0-7). This terminology is
 * used internally within the driver to avoid confusion with 'ports'.
 * - "Quad": One of the two internal 4-channel management units within the
 * Si3474, each accessed via its own I2C address.
 *
 * Relationship:
 * - A 2-Pair PoE PI uses 1 Channel.
 * - A 4-Pair PoE PI uses 2 Channels.
 *
 * ASCII Schematic:
 *
 * +-----------------------------------------------------+
 * |                    Si3474 Chip                      |
 * |                                                     |
 * | +---------------------+     +---------------------+ |
 * | |      Quad 0         |     |      Quad 1         | |
 * | | Channels 0, 1, 2, 3 |     | Channels 4, 5, 6, 7 | |
 * | +----------^----------+     +-------^-------------+ |
 * | I2C Addr 0 |                        | I2C Addr 1    |
 * |            +------------------------+               |
 * | (Primary Driver Instance) (Managed by Primary)      |
 * |                                                     |
 * | Shared Resources (affect whole chip):               |
 * |  - Single INTb Output -> Handled by Primary         |
 * |  - Single RESETb Input                              |
 * |  - Single OSS Input   -> Handled by Primary         |
 * |  - Global I2C Addr (0x7F) for Firmware Update       |
 * |  - Global Status (Temp, VDD/VPWR UVLO)              |
 * +-----------------------------------------------------+
 *        |   |   |   |        |   |   |   |
 *        Ch0 Ch1 Ch2 Ch3      Ch4 Ch5 Ch6 Ch7  (Physical Channels)
 *
 * Example Mapping (Logical PI to Physical Channel(s)):
 * * 2-Pair Mode (8 PIs):
 * PI 0 -> Ch 0
 * PI 1 -> Ch 1
 * ...
 * PI 7 -> Ch 7
 * * 4-Pair Mode (4 PIs):
 * PI 0 -> Ch 0 + Ch 1  (Managed via Quad 0 Addr)
 * PI 1 -> Ch 2 + Ch 3  (Managed via Quad 0 Addr)
 * PI 2 -> Ch 4 + Ch 5  (Managed via Quad 1 Addr)
 * PI 3 -> Ch 6 + Ch 7  (Managed via Quad 1 Addr)
 * (Note: Actual mapping depends on Device Tree and PORT_REMAP config)
 */

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


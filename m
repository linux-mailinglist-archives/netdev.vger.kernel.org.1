Return-Path: <netdev+bounces-195039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9CFACDA06
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 10:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D4A16F80B
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02A828A1C0;
	Wed,  4 Jun 2025 08:39:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92C2638A3
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026378; cv=none; b=uAvZ2k/VY+qjDq0rBrRGUlwCvJHIa3tMQ7VetxLlznlGJY7RxhCrME4uE7pNe2YXpSQCTGXWwti38llP3y7m8p997O0aOZ1t7L2KrrWxA1Xtvm71Lu24580a5P0rWh7Bxqt6WATz/CUz4dNXl0TFB2u/hQPjv3NzQqx2jaOxH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026378; c=relaxed/simple;
	bh=DW8EbKW23z9pr9dZdpNS8Qp/tMSOdDb2I+W+BCVu2Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldIsdL0Np3GH1MHVN0DvmUovhRlPNYHf6aKxx6McdP+hpZgEouz1Ipl4yvsHrw6GDPNSgDeihPkFuDqX4l16vPM0Jj5hzndkZa2XibWg6NFd9ye9VWeMX1BxI6+XwLJGJRT/9cCe7woIePu5002P9jOuBEzerdvT8gnl4C9XfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uMjeY-0007RH-Ps; Wed, 04 Jun 2025 10:39:18 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uMjeX-001lJT-0v;
	Wed, 04 Jun 2025 10:39:17 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uMjeX-00AWuz-0Y;
	Wed, 04 Jun 2025 10:39:17 +0200
Date: Wed, 4 Jun 2025 10:39:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 2/2] net: pse-pd: Add LTC4266 PSE controller
 driver
Message-ID: <aEAGNa38EUIVgByn@pengutronix.de>
References: <20250603230422.2553046-1-kyle.swenson@est.tech>
 <20250603230422.2553046-3-kyle.swenson@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603230422.2553046-3-kyle.swenson@est.tech>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Kyle,

thank you for your work!

Are there any way to get manual with register description? I would like
to make a deeper review :)

On Tue, Jun 03, 2025 at 11:04:39PM +0000, Kyle Swenson wrote:
> Add a new driver for the Linear Technology LTC4266 I2C Power Sourcing
> Equipment controller.  This driver integrates with the current PSE
> controller core, implementing IEEE802.3af and IEEE802.3at PSE standards.
> ---
>  drivers/net/pse-pd/Kconfig   |  10 +
>  drivers/net/pse-pd/Makefile  |   1 +
>  drivers/net/pse-pd/ltc4266.c | 919 +++++++++++++++++++++++++++++++++++
>  3 files changed, 930 insertions(+)
>  create mode 100644 drivers/net/pse-pd/ltc4266.c
> 
> diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
> index 7fab916a7f46..a0f2eaadb4fb 100644
> --- a/drivers/net/pse-pd/Kconfig
> +++ b/drivers/net/pse-pd/Kconfig
> @@ -18,10 +18,20 @@ config PSE_REGULATOR
>  	help
>  	  This module provides support for simple regulator based Ethernet Power
>  	  Sourcing Equipment without automatic classification support. For
>  	  example for basic implementation of PoDL (802.3bu) specification.
>  
> +config PSE_LTC4266
> +	tristate "LTC4266 PSE controller"
> +	depends on I2C
> +	help
> +	  This module provides support the LTC4266 regulator based Ethernet
> +	  Power Sourcing Equipment.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ltc4266.
> +
>  config PSE_PD692X0
>  	tristate "PD692X0 PSE controller"
>  	depends on I2C
>  	select FW_LOADER
>  	select FW_UPLOAD
> diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
> index 9d2898b36737..a17e16467ae2 100644
> --- a/drivers/net/pse-pd/Makefile
> +++ b/drivers/net/pse-pd/Makefile
> @@ -1,8 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  # Makefile for Linux PSE drivers
>  
>  obj-$(CONFIG_PSE_CONTROLLER) += pse_core.o
>  
> +obj-$(CONFIG_PSE_LTC4266) += ltc4266.o
>  obj-$(CONFIG_PSE_REGULATOR) += pse_regulator.o
>  obj-$(CONFIG_PSE_PD692X0) += pd692x0.o
>  obj-$(CONFIG_PSE_TPS23881) += tps23881.o
> diff --git a/drivers/net/pse-pd/ltc4266.c b/drivers/net/pse-pd/ltc4266.c
> new file mode 100644
> index 000000000000..858889c9ab75
> --- /dev/null
> +++ b/drivers/net/pse-pd/ltc4266.c
> @@ -0,0 +1,919 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Linear LTC4266 PoE PSE Controller
> + *
> + * Original work:
> + *    Copyright 2019 Cradlepoint Technology, Inc.
> + *    Cradlepoint Technology, Inc.  <source@cradlepoint.com>
> + *
> + * Re-written in 2025:
> + *    Copyright 2025 Ericsson Software Technology
> + *    Kyle Swenson <kyle.swenson@est.tech>
> + *
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/ethtool.h>
> +#include <linux/gpio.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pse-pd/pse.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +#define LTC4266_REG_ID				0x1B
> +#define LTC4266_ID				0x64
> +
> +#define TWO_BIT_WORD_OFFSET(_v, _pid)		((_v) << ((_pid) * 2))
> +#define TWO_BIT_WORD_MASK(_pid)			TWO_BIT_WORD_OFFSET(0x03, (_pid))
> +
> +#define LTC4266_IPLSB_REG(_p)			(0x30 | ((_p) << 2))
> +#define LTC4266_VPLSB_REG(_p)			(LTC4266_IPLSB_REG(_p) + 2)
> +
> +#define LTC4266_RSTPB_INTCLR			BIT(7)
> +#define LTC4266_RSTPB_PINCLR			BIT(6)
> +#define LTC4266_RSTPB_RSTALL			BIT(5)
> +
> +/* Register definitions */
> +#define LTC4266_REG_INTSTAT			0x00
> +#define LTC4266_REG_INTMASK			0x01
> +#define LTC4266_REG_PWREVN_COR			0x03
> +#define LTC4266_REG_DETEVN_COR			0x05
> +#define LTC4266_REG_FLTEVN_COR			0x07
> +#define LTC4266_REG_TSEVN_COR			0x09
> +#define LTC4266_REG_SUPEVN_COR			0x0B
> +#define LTC4266_REG_STAT(n)			(0x0C + (n))
> +#define LTC4266_REG_STATPWR			0x10
> +#define LTC4266_REG_OPMD			0x12
> +#define LTC4266_REG_DISENA			0x13 /* Disconnect detect enable */
> +#define LTC4266_REG_MCONF			0x17
> +#define LTC4266_REG_DETPB			0x18
> +#define LTC4266_REG_PWRPB			0x19
> +#define LTC4266_REG_RSTPB			0x1A
> +#define LTC4266_REG_HPEN			0x44
> +#define LTC4266_REG_HPMD(_p)			(0x46 + (5 * (_p)))
> +#define LTC4266_REG_ILIM(_p)			(LTC4266_REG_HPMD(_p) + 2)
> +#define LTC4266_REG_TLIM12			0x1E
> +#define LTC4266_REG_TLIM34			0x1F
> +
> +/* Register field definitions */
> +#define LTC4266_HPMD_PONGEN			0x01
> +
> +/* For LTC4266_REG_TLIM* */
> +#define LTC4266_TLIM_VALUE			0x01
> +
> +/* LTC4266_REG_HPEN, enable "High Power" mode (i.e. Type 2, 25.4W PDs) */

Type 2 Class 4? Probably not, datasheet claims:
"Supports Proprietary Power Levels Above 25W"

> +#define LTC4266_HPEN(_p)			BIT(_p)
> +
> +/* LTC4266_REG_MCONF */
> +#define LTC4266_MCONF_INTERRUPT_ENABLE		BIT(7)
> +
> +/* LTC4266_REG_STATPWR */
> +#define LTC4266_STATPWR_PG(_p)			BIT((_p) + 4)
> +#define LTC4266_STATPWR_PE(_p)			BIT(_p)
> +#define LTC4266_PORT_CLASS(_stat)		FIELD_GET(GENMASK(6, 4), (_stat))
> +
> +#define LTC4266_REG_ICUT_HP(_p)			(LTC4266_REG_HPMD(_p) + 1)
> +
> +/* if R_sense = 0.25 Ohm, this should be set otherwise 0 */
> +#define LTC4266_ICUT_RSENSE			BIT(7)

LTC4266_ICUT_RSENSE_025_OHM

> +/* if set, halve the range and double the precision */
> +#define LTC4266_ICUT_RANGE			BIT(6)
> +
> +#define LTC4266_ILIM_AF_RSENSE_025		0x80
> +#define LTC4266_ILIM_AF_RSENSE_050		0x00
> +#define LTC4266_ILIM_AT_RSENSE_025		0xC0
> +#define LTC4266_ILIM_AT_RSENSE_050		0x40

Consider renaming constants AF/AT mentions.

Replace _AF_ with _TYPE1_ (e.g., LTC4266_ILIM_TYPE1_RSENSE_025)
Replace _AT_ with _TYPE2_ (e.g., LTC4266_ILIM_TYPE2_RSENSE_025)

The terms "Type 1" and "Type 2" are how the official IEEE 802.3 standard refers
to the PoE capabilities and power levels that were introduced by the 802.3af
and 802.3at amendments, respectively. Using "Type1" and "Type2" in your code
will make it clearer and more aligned with the current, consolidated IEEE
terminology, which is helpful since direct access to the original "af" and "at"
amendment documents can be challenging for the open-source community.

Do you have access to this amendments?

> +/* LTC4266_REG_INTSTAT and LTC4266_REG_INTMASK */
> +#define LTC4266_INT_SUPPLY			BIT(7)
> +#define LTC4266_INT_TSTART			BIT(6)
> +#define LTC4266_INT_TCUT			BIT(5)
> +#define LTC4266_INT_CLASS			BIT(4)
> +#define LTC4266_INT_DET				BIT(3)
> +#define LTC4266_INT_DIS				BIT(2)
> +#define LTC4266_INT_PWRGD			BIT(1)
> +#define LTC4266_INT_PWRENA			BIT(0)
> +
> +#define LTC4266_MAX_PORTS 4
> +
> +/* Maximum and minimum power limits for a single port */
> +#define LTC4266_PW_LIMIT_MAX 25400
> +#define LTC4266_PW_LIMIT_MIN 1
> +
> +enum {
> +	READ_CURRENT = 0,
> +	READ_VOLTAGE = 2
> +};
> +
> +enum {
> +	LTC4266_OPMD_SHUTDOWN = 0,
> +	LTC4266_OPMD_MANUAL,
> +	LTC4266_OPMD_SEMI,
> +	LTC4266_OPMD_AUTO

Please add explanations to this port modes

> +};
> +
> +/* Map LTC4266 Classification result to PD class */
> +static int ltc4266_class_map[] = {
> +	0, /* Treat as class 3 */
> +	1,
> +	2,
> +	3,
> +	4,
> +	-EINVAL,
> +	3, /* Treat as class 3 */
> +	-ERANGE
> +};
> +
> +/* Convert a class 0-4 to icut register value */
> +static int ltc4266_class_to_icut[] = {
> +	375,

missing comment, index 0 is class 3.

> +	112,
> +	206,
> +	375,
> +	638
> +};

May be we should have a generic function in the framework providing conversion
from class to min/max Icut and Ilim, otherwise it makes additional work
validation this values.

> +
> +enum sense_resistor {
> +	LTC4266_RSENSE_500, /* Rsense 0.5 Ohm */
> +	LTC4266_RSENSE_250 /* Rsense 0.25 Ohm */
> +};
> +
> +struct ltc4266_port {
> +	enum sense_resistor rsense;
> +	struct device_node *node;
> +	int current_limit;
> +};
> +
> +struct ltc4266 {
> +	struct i2c_client *client;
> +	struct mutex lock; /* Protect Read-Modify-Write Sequences */
> +	struct ltc4266_port *ports[LTC4266_MAX_PORTS];
> +	struct device *dev;
> +	struct device_node *np;
> +	struct pse_controller_dev pcdev;
> +};
> +
> +/* Read-modify-write sequence with value and mask.  Mask is expected to be
> + * shifted to the correct spot.
> + */
> +static int ltc4266_write_reg(struct ltc4266 *ltc4266, u8 reg, u8 value, u8 mask)

If it is Read-modify-write type of function, it would be better to name
it ltc4266_rmw_reg(). Or use regmap instead, you will get some extra
functionality: register dump over sysfs interface, range validation,
caching if enabled, locking, etc.

> +{
> +	int ret;
> +	u8 new;
> +
> +	mutex_lock(&ltc4266->lock);
> +	ret = i2c_smbus_read_byte_data(ltc4266->client, reg);
> +	if (ret < 0) {
> +		dev_warn(ltc4266->dev, "Failed to read register 0x%02x, err=%d\n", reg, ret);
> +		mutex_unlock(&ltc4266->lock);
> +		return ret;
> +	}
> +	new = (u8)ret;
> +	new &= ~mask;
> +	new |= value & mask;
> +	ret = i2c_smbus_write_byte_data(ltc4266->client, reg, new);
> +	mutex_unlock(&ltc4266->lock);
> +
> +	return ret;
> +}
> +
> +static int ltc4266_read_iv(struct ltc4266 *ltc4266, int port, u8 iv)
> +{
> +	int lsb;
> +	int msb;
> +	int result;
> +	int lsb_reg;
> +	u64 ivbits = 0;
> +
> +	if (iv == READ_CURRENT)
> +		lsb_reg = LTC4266_IPLSB_REG(port);
> +	else if (iv == READ_VOLTAGE)
> +		lsb_reg = LTC4266_VPLSB_REG(port);
> +	else
> +		return -EINVAL;
> +
> +	result = i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_STATPWR);
> +	if (result < 0)
> +		return result;
> +
> +	/*  LTC4266 IV readings are only valid if the port is powered. */
> +	if (!(result & LTC4266_STATPWR_PG(port)))
> +		return -EINVAL;

We have two states:
- admin enabled: admin enabled state
- delivering power: PSE is actually delivering power

Please use this words to clarify what is actually happening.

> +	/* LTC4266 expects the MSB register to be read immediately following the LSB
> +	 * register, so we need to ensure other parts aren't reading other registers in
> +	 * this chip while we read the current/voltage regulators.
> +	 */
> +	mutex_lock(&ltc4266->lock);

please use guard* variants for locking.

> +
> +	lsb = i2c_smbus_read_byte_data(ltc4266->client, lsb_reg);
> +	msb = i2c_smbus_read_byte_data(ltc4266->client, lsb_reg + 1);
> +
> +	mutex_unlock(&ltc4266->lock);
> +
> +	if (lsb < 0)
> +		return lsb;
> +
> +	if (msb < 0)
> +		return msb;
> +
> +	ivbits = 0;
> +	ivbits |= ((u8)msb) << 8 | ((u8)lsb);
> +
> +	if (iv == READ_CURRENT)
> +		if (ltc4266->ports[port]->rsense == LTC4266_RSENSE_250) /* 122.07 uA/LSB */
> +			result = DIV_ROUND_CLOSEST_ULL((ivbits * 122070), 1000);
> +		else /* 61.035 uA/LSB */
> +			result = DIV_ROUND_CLOSEST_ULL((ivbits * 61035), 1000);
> +	else /* 5.835 mV/LSB == 5835 uV/LSB */
> +		result = ivbits * 5835;
> +
> +	return result;
> +}
> +i

> +static int ltc4266_port_set_ilim(struct ltc4266 *ltc4266, int port, int class)
> +{
> +	if (class > 4 || class < 0)
> +		return -EINVAL;
> +
> +	/* We want to set 425 mA for class 3 and lower; 850 mA otherwise for IEEE compliance */
> +	if (class < 4) {
> +		/* Write 0x80 for 0.25 Ohm sense otherwise 0 */
> +		if (ltc4266->ports[port]->rsense == LTC4266_RSENSE_250)
> +			return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(port), LTC4266_ILIM_AF_RSENSE_025);
> +		return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(port), LTC4266_ILIM_AF_RSENSE_050);
> +	}
> +
> +	/* Class == 4 */
> +	if (ltc4266->ports[port]->rsense == LTC4266_RSENSE_250)
> +		return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(port), LTC4266_ILIM_AT_RSENSE_025);
> +	/* Class == 4 and the sense resistor is 0.5 */
> +	return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(port), LTC4266_ILIM_AT_RSENSE_050);

May be something like this:
/*
 * ltc4266_port_set_ilim - Set the active current limit (ILIM) for a port.
 * @ltc4266: Pointer to the LTC4266 device structure.
 * @port: The port number (0-3).
 * @class: The detected PD class (0-4).
 *
 * This function configures the ILIM register (0x48, 0x4D, 0x52, 0x57)
 * of the LTC4266. The ILIM value determines the threshold at which the
 * PSE actively limits current to the PD. The chosen values are based on
 * IEEE Std 802.3-2022 requirements and typical operational values for the
 * LTC4266 controller.
 *
 * IEEE Std 802.3-2022, Table 33-11 specifies ILIM parameter ranges:
 * - For Type 1 PSE operation (typically PD Classes 0-3):
 * The minimum ILIM is 0.400A. This driver uses 425mA. This value fits
 * within typical Type 1 ILIM specifications (e.g., 0.400A min to
 * around 0.440A-0.500A max for the programmed steady-state limit).
 *
 * - For Type 2 PSE operation (typically PD Class 4):
 * The minimum ILIM is 1.14 * ICable (or ~1.05 * IPort_max from other
 * interpretations, e.g., ~0.630A to ~0.684A). This driver uses 850mA.
 * This value meets the minimum requirement and is a supported operational
 * current limit for high power modes in the LTC4266.
 *
 * The overall PSE current output must not exceed the time-dependent PSE
 * upperbound template, IPSEUT(t), described in IEEE Std 802.3-2022,
 * Equation (33-6). The programmed ILIM values (425mA/850mA) serve as the
 * long-term current limit (Ilimmin segment of IPSEUT(t)) and are well
 * within the higher short-term current allowances of that template (e.g., 1.75A).
 *
 * The specific register values written depend on the sense resistor
 * (0.25 Ohm or 0.50 Ohm) as detailed in the LTC4266 datasheet (Table 5).
 *
 * Returns: ...
 */
static int ltc4266_port_set_ilim(struct ltc4266 *ltc4266, int port, int class)
{
	u8 ilim_reg_val;

	if (class > 4 || class < 0)
		return -EINVAL;

	if (class < 4) {
		/* PD Class is 0, 1, 2, or 3 (Type 1 PSE operation).
		 * Set ILIM to 425mA.
		 */
		if (ltc4266->ports[port]->rsense == LTC4266_RSENSE_250) {
			/* Using 0.25 Ohm sense resistor. */
			ilim_reg_val = LTC4266_ILIM_TYPE1_RSENSE_025;
		} else {
			/* Using 0.50 Ohm sense resistor. */
			ilim_reg_val = LTC4266_ILIM_TYPE1_RSENSE_050;
		}
	} else {
		/* PD Class is 4 (Type 2 PSE operation).
		 * Set ILIM to 850mA.
		 */
		if (ltc4266->ports[port]->rsense == LTC4266_RSENSE_250) {
			/* Using 0.25 Ohm sense resistor. */
			ilim_reg_val = LTC4266_ILIM_TYPE2_RSENSE_025;
		} else {
			/* Using 0.50 Ohm sense resistor. */
			ilim_reg_val = LTC4266_ILIM_TYPE2_RSENSE_050;
		}
	}

	/* Write the determined ILIM value to the appropriate port's ILIM register.
	 * The LTC4266_REG_ILIM(port) macro resolves to the correct register
	 * address for the given port (e.g., 0x48 for port 0, 0x4D for port 1, etc.).
	 */
	return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(port), ilim_reg_val);
}

> +static int ltc4266_port_set_icut(struct ltc4266 *ltc4266, int port, int icut)
> +{
> +	u8 val;
> +
> +	if (icut > 850)

It looks like board specific limit:
From the LTC4266 datasheet:
"Non-standard applications that provide more current
than the 850mA IEEE maximum may require heat sinking and other MOSFET design
considerations."

> +		return -ERANGE;
> +
> +	val = (u8)(DIV_ROUND_CLOSEST((icut * 1000), 18750) & 0x3F);

I assume 18750 micro Amp, per step in the register value and 0x3f is the max
mask for the bit field. In this case this register supports
0x3f * 18750 / 1000 = 1181mA

Please use defines to make it readable.

> +
> +	if (ltc4266->ports[port]->rsense == LTC4266_RSENSE_250)
> +		val |= LTC4266_ICUT_RSENSE | LTC4266_ICUT_RANGE;
> +
> +	return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ICUT_HP(port), val);
> +}
> +
> +static int ltc4266_port_mode(struct ltc4266 *ltc4266, int port, u8 opmd)
> +{
> +	if (opmd >= LTC4266_OPMD_AUTO)
> +		return -EINVAL;
> +
> +	return ltc4266_write_reg(ltc4266, LTC4266_REG_OPMD, TWO_BIT_WORD_OFFSET(opmd, port),
> +				TWO_BIT_WORD_MASK(port));
> +}
> +
> +static int ltc4266_port_powered(struct ltc4266 *ltc4266, int port)

delivering or enabled?

> +{
> +	int result = i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_STATPWR);
> +
> +	if (result < 0)
> +		return result;
> +
> +	return !!((result & LTC4266_STATPWR_PG(port)) && (result & LTC4266_STATPWR_PE(port)));
> +}
> +
> +static int ltc4266_port_init(struct ltc4266 *ltc4266, int port)
> +{
> +	int ret;
> +	u8 tlim_reg;
> +	u8 tlim_mask;
> +
> +	/* Reset the port */
> +	ret = i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_RSTPB, BIT(port));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ltc4266_port_mode(ltc4266, port, LTC4266_OPMD_SEMI);

Should we have disabled mode before all current limits configured?

> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable high power mode on the port (802.3at+) */

802.3at+? "Proprietary Power Levels Above 25W"?. Here we will need a discussion
how to reflect a Proprietary Power levels in the UAPI.

> +	ret = ltc4266_write_reg(ltc4266, LTC4266_REG_HPEN,
> +				LTC4266_HPEN(port), LTC4266_HPEN(port));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable Ping-Pong Classification */

This is probably "2-event classification" described in Clause 33 of the
IEEE Std 802.3-2022.

> +	ret = ltc4266_write_reg(ltc4266, LTC4266_REG_HPMD(port),
> +				LTC4266_HPMD_PONGEN, LTC4266_HPMD_PONGEN);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ltc4266->ports[port]->rsense == LTC4266_RSENSE_250)
> +		ret = ltc4266_write_reg(ltc4266, LTC4266_REG_ICUT_HP(port),
> +					LTC4266_ICUT_RSENSE, LTC4266_ICUT_RSENSE);
> +	else
> +		ret = ltc4266_write_reg(ltc4266, LTC4266_REG_ICUT_HP(port),
> +					0, LTC4266_ICUT_RSENSE);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (port <= 1)
> +		tlim_reg = LTC4266_REG_TLIM12;
> +	else
> +		tlim_reg = LTC4266_REG_TLIM34;
> +
> +	if (port & BIT(0))
> +		tlim_mask = GENMASK(7, 4);
> +	else
> +		tlim_mask = GENMASK(3, 0);
> +
> +	ret = ltc4266_write_reg(ltc4266, tlim_reg, LTC4266_TLIM_VALUE, tlim_mask);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable disconnect detect. */
> +	ret = ltc4266_write_reg(ltc4266, LTC4266_REG_DISENA, BIT(port), BIT(port));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable detection (low nibble), classification (high nibble) on the port */

This seems to correspond to ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED 

> +	ret = i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_DETPB,
> +					BIT(port + 4) | BIT(port));
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(ltc4266->dev, "Port %d has been initialized\n", port);
> +	return 0;
> +}
> +
> +static int ltc4266_get_opmode(struct ltc4266 *ltc4266, int port)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_OPMD);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (port) {
> +	case 0:
> +		return FIELD_GET(GENMASK(1, 0), ret);
> +	case 1:
> +		return FIELD_GET(GENMASK(3, 2), ret);
> +	case 2:
> +		return FIELD_GET(GENMASK(5, 4), ret);
> +	case 3:
> +		return FIELD_GET(GENMASK(7, 6), ret);
> +	}
> +	return -EINVAL;
> +}
> +
> +static int ltc4266_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
> +{
> +	int ret;
> +	struct ltc4266 *ltc4266 = container_of(pcdev, struct ltc4266, pcdev);
> +
> +	ret = ltc4266_get_opmode(ltc4266, id);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret == LTC4266_OPMD_SEMI)
> +		return 1; /*  If a port is in OPMODE SEMI, we'll just assume admin has it enabled */

From HW perspective, every mode except of LTC4266_OPMD_SHUTDOWN can be seen as
admin state enabled. LTC4266_OPMD_MANUAL - is forced mode controlling
power delivery manually.

I need to make stop here, i'll try to review the rest later.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


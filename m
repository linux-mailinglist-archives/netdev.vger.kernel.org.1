Return-Path: <netdev+bounces-232421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABA4C05AAC
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2972919A8662
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4233112C0;
	Fri, 24 Oct 2025 10:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900381D6AA
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303018; cv=none; b=U6CFhHp6WM1PdFFndw9B4aZITXMq8obZ22WI6/AR/15HUnKssZiDLnm8lhicBelX0Z8DCOFKnpJePGezZ2iyaHyS5dQqMlnVm1iPr44gBmihQWon22S2qNp+NdlrmpRoVQQ/M+Ru+6jzhG+cE/+tHaVmjNw5+BfbXttDdxCqtjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303018; c=relaxed/simple;
	bh=F+nCjJssW4CR8kA9MUHSPRtTAf96FpG587l8Oyq7/aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYyH/1PlOHlYdcaVYxVlETFhJYvAmKWjnIkmwMBGpBnyLnnYylMN33bTicwi4Wo7SPtTLNLaBBwlL6y3U/nwQfZ5Oi1waIhMs7EqWHLesyBwX7gCMMs5kN+i8HhhsgvA2YcODPY+jD4J5XYXUPLFxl64SxY9ckxEfJiyLDCElOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vCFMu-0008RJ-AJ; Fri, 24 Oct 2025 12:50:00 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vCFMs-005D9G-1s;
	Fri, 24 Oct 2025 12:49:58 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vCFMs-00F8sL-1V;
	Fri, 24 Oct 2025 12:49:58 +0200
Date: Fri, 24 Oct 2025 12:49:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: pse-pd: tps23881: Add support for
 TPS23881B
Message-ID: <aPtZ1jE7D7JI2wic@pengutronix.de>
References: <20251022220519.11252-2-thomas@wismer.xyz>
 <20251022220519.11252-4-thomas@wismer.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022220519.11252-4-thomas@wismer.xyz>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Thomas,

Thank you for your work.

Looks good, here are some nits:

On Thu, Oct 23, 2025 at 12:05:18AM +0200, Thomas Wismer wrote:
> From: Thomas Wismer <thomas.wismer@scs.ch>
> 
> The TPS23881B uses different firmware than the TPS23881. Trying to load the
> TPS23881 firmware on a TPS23881B device fails and must be omitted.
> 
> The TPS23881B ships with a more recent ROM firmware. Moreover, no updated
> firmware has been released yet and so the firmware loading step must be
> skipped. As of today, the TPS23881B is intended to use its ROM firmware.
> 
> Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
> ---
>  drivers/net/pse-pd/tps23881.c | 65 +++++++++++++++++++++++++++--------
>  1 file changed, 51 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
> index b724b222ab44..f45c08759082 100644
> --- a/drivers/net/pse-pd/tps23881.c
> +++ b/drivers/net/pse-pd/tps23881.c
> @@ -55,8 +55,6 @@
>  #define TPS23881_REG_TPON	BIT(0)
>  #define TPS23881_REG_FWREV	0x41
>  #define TPS23881_REG_DEVID	0x43
> -#define TPS23881_REG_DEVID_MASK	0xF0
> -#define TPS23881_DEVICE_ID	0x02
>  #define TPS23881_REG_CHAN1_CLASS	0x4c
>  #define TPS23881_REG_SRAM_CTRL	0x60
>  #define TPS23881_REG_SRAM_DATA	0x61
> @@ -1012,8 +1010,28 @@ static const struct pse_controller_ops tps23881_ops = {
>  	.pi_get_pw_req = tps23881_pi_get_pw_req,
>  };
>  
> -static const char fw_parity_name[] = "ti/tps23881/tps23881-parity-14.bin";
> -static const char fw_sram_name[] = "ti/tps23881/tps23881-sram-14.bin";
> +struct tps23881_info {
> +	u8 dev_id;	/* device ID and silicon revision */
> +	const char *fw_parity_name;	/* parity code firmware file name */
> +	const char *fw_sram_name;	/* SRAM code firmware file name */
> +};
> +
> +enum tps23881_model {
> +	TPS23881,
> +	TPS23881B,
> +};
> +
> +static const struct tps23881_info tps23881_info[] = {
> +	[TPS23881] = {
> +		.dev_id = 0x22,
> +		.fw_parity_name = "ti/tps23881/tps23881-parity-14.bin",
> +		.fw_sram_name = "ti/tps23881/tps23881-sram-14.bin",
> +	},
> +	[TPS23881B] = {
> +		.dev_id = 0x24,
> +		/* skip SRAM load, ROM firmware already IEEE802.3bt compliant */

TL;DR:

A more accurate comment would be:
/* skip SRAM load, ROM provides Clause 145 hardware-level support */

Longer version:

Please reference IEEE 802.3-2022 (Clause 145) instead of the "IEEE
802.3bt" amendment:
- The IEEE 802.3-2022 standard is free for everyone with the IEEE Xplore
  program.
- The "bt" amendment costs money.
- Using the free standard helps all community members review this driver.

The chip (hardware) alone cannot be "compliant." Full compliance for
Type 3 or Type 4 needs the whole system to work correctly:
- The Linux system must handle the DLL (LLDP) classification in software.
  The chip's ROM does not do this.
- The board must supply the correct voltage (e.g., 52V to 57V for Type
  4). This chip's minimum 44V is not compliant with Clause 145.
- The final power supply and board must be designed to handle the high
  power (like 90W).

[...]
> @@ -1422,6 +1442,10 @@ static int tps23881_i2c_probe(struct i2c_client *client)
[...]
>  
> -	dev_info(&client->dev, "Firmware revision 0x%x\n", ret);
> +	if (ret == 0xFF)
> +		dev_warn(&client->dev, "Device entered safe mode\n");

                return -ENODEV; /* Or another appropriate error */

The datasheet states this happens on an "un-recoverable firmware fault."
According to the datasheet, when in "Safe Mode," all ports are shut
down. The device is not in a functional state to act as a PSE
controller.


> +	else
> +		dev_info(&client->dev, "Firmware revision 0x%x%s\n", ret,
> +			 ret == 0x00 ? " (ROM firmware)" : "");
>  
>  	/* Set configuration B, 16 bit access on a single device address */
>  	ret = i2c_smbus_read_byte_data(client, TPS23881_REG_GEN_MASK);
> @@ -1504,7 +1534,14 @@ static const struct i2c_device_id tps23881_id[] = {
>  MODULE_DEVICE_TABLE(i2c, tps23881_id);

I guess tps23881_id should be updated too.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


Return-Path: <netdev+bounces-290520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM74BlckD2rPGAYAu9opvQ
	(envelope-from <netdev+bounces-290520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:27:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2415A84F7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9975533041F7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5E339D6DB;
	Thu, 21 May 2026 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nB7dqaCb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5139E167
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375065; cv=none; b=OslAGn72y+MxDJyxilXy683TcNVHZ58vQGfqXgmtQHxq/Me2tGguCvtQjt8/x/U4MaCm+Y4uEGTGxGkEZOqtbgCvaV528kpFgOzn9mVPaB26wLwqiHpezWpVzcWg5v8LM8C6K3Mqr+yzmbWo9nMYb2xN8PX4+oEwMpM3MgfImsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375065; c=relaxed/simple;
	bh=a52OfR4iIxB7NR4aDT4cxoCuDzhHBrR+NfXk0hq4l9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nip+Jm2njBKA/LTXNkQIrrjvmED4ZRxf0pHI/seIu0Mqzoa9712CRldYzloXOj2gwGygktGMJB/awuwxPv9wqiNM/BQvNz7bh/pegOHEAwGeCbwErJnodm/tTJ/UKRiChtWxnfvR4WITDs17PsF5LQJHWvwPcx+Ti4ZljSHlWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nB7dqaCb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 53E484E42D0D;
	Thu, 21 May 2026 14:50:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 044E760495;
	Thu, 21 May 2026 14:50:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E841107E89AF;
	Thu, 21 May 2026 16:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779375055; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fTteTqIzCkDDRfgTUqBszUa4Ju7v0nJjWKenJsd6KUA=;
	b=nB7dqaCbGmYNQpadDDIPmQoye+tBE1lUNZvnmsMHr5H8yJL6gZlt6Z1KK1CsY6pxBD7CV7
	0lg+Pcu0jDpSIlvZubgvSTe1r49CPtRBhdzx8oBEATZSE7hhmFjpp0VEIbWyr9UWVHTqsV
	lG9cBJf2qbTkdmqxNydPfcP+ePMw9Utsrqf7SnHTGCuL1dZHqtjCyOmzIufrWaW8CNMxP+
	YQAZteWlPklCBBlLPXLKMb0e6qeHAfFMpSWxn94l0h17LbH+RxTn3Q/b4oglUYEL0tZWUt
	fpA6iLiaCGy1JFmy+U0dOPw3+OyGY95GLWgebbtNiJvNsPZPm7Qam6gkoJDq2A==
Message-ID: <a02f6a76-add7-446a-9f92-304fee0ef594@bootlin.com>
Date: Thu, 21 May 2026 16:50:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6] net: phy: sfp: probe for RollBall I2C-to-MDIO
 bridge in mdio-i2c
To: Petr Wozniak <petr.wozniak@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bjorn@mork.no,
 linux-phy@lists.infradead.org, jan@3e8.eu
References: <20260521025755.24649-1-petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260521025755.24649-1-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290520-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,mork.no,lists.infradead.org,3e8.eu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 8B2415A84F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/21/26 04:57, Petr Wozniak wrote:
> The "OEM"/"SFP-10G-T" quirk entry in sfp_fixup_rollball_cc()
> unconditionally forces MDIO_I2C_ROLLBALL for all modules matching that
> vendor/part-number combination.  This works for modules that genuinely
> implement a RollBall I2C-to-MDIO bridge, but silently breaks modules
> that share the same EEPROM strings without having such a bridge.
> 
> The Realtek RTL8261BE-CG is one such module: a pure copper 10G SFP+
> media converter with no I2C-to-MDIO bridge.  Its EEPROM reports
> vendor="OEM", part="SFP-10G-T-I", and -- critically -- Vendor OUI
> 00:00:00, making OUI-based differentiation impossible.  With
> MDIO_I2C_ROLLBALL forced, the module silently ACKs the unlock password
> write, the MDIO bus is created, but no PHY responds; the SFP state
> machine cycles through the RollBall PHY-probe retry window before
> reporting no PHY.
> 
> Move the probe into i2c_mii_init_rollball() in mdio-i2c.c, where the
> RollBall protocol constants are already defined.  After sending the
> unlock password, issue a CMD_READ and poll for CMD_DONE up to 200 ms
> (10 x 20 ms, matching the existing rollball poll tolerance).  A genuine
> RollBall bridge asserts CMD_DONE within that window; modules without a
> bridge never do, so i2c_mii_init_rollball() returns -ENODEV.
> mdio_i2c_alloc() propagates -ENODEV to the caller to signal that no
> bridge is present and PHY probing should be skipped.
> sfp_sm_add_mdio_bus() catches -ENODEV and transitions
> sfp->mdio_protocol to MDIO_I2C_NONE so the rest of the state machine
> skips PHY probing for this module.
> 
> Any I2C-level error (NACK, timeout) during the probe is also treated as
> -ENODEV: if the module does not respond at I2C address 0x51 at all,
> there is certainly no RollBall bridge there, and SFP initialization
> should not abort.
> 
> The probe writes are safe with respect to SFP EEPROM integrity: only
> modules explicitly listed in the quirk table enter this path, and the
> RollBall password unlock write to 0x51 was already issued by
> i2c_mii_init_rollball() before the probe for all such modules.  Any
> module without a device at 0x51 NACKs the transfer and is treated as
> -ENODEV.
> 
> Add "OEM"/"SFP-10G-T-I" to the quirk table so RTL8261BE modules enter
> the probe path; genuine RollBall modules continue to work as before.
> 
> Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> 
> Changes since v5 (Sashiko AI review):
>    - Treat I2C NACK/errors in i2c_mii_init_rollball() as -ENODEV so
>      modules without a 0x51 EEPROM do not abort SFP initialization
>    - Replace fixed 70 ms wait with 10 x 20 ms poll (total 200 ms),
>      matching the existing i2c_rollball_mii_poll() tolerance and
>      preventing false -ENODEV on slow RollBall bridges
> 
> Changes since v4 (feedback from Maxime Chevallier):
>    - Fix commit message: replace "stalls" with accurate description of
>      the RollBall PHY-probe retry window
>    - Fix variable declaration order in i2c_mii_probe_rollball() to
>      follow reverse-xmas tree (descending line length)
>    - Remove spurious alignment space on "SFP-10G-T" quirk entry
>    - Document that -ENODEV from mdio_i2c_alloc() means no bridge present,
>      PHY probing should be skipped
> 
> Changes since v3 (feedback from Jakub Kicinski):
>    - Drop spurious Tested-by: tag -- author and tester are the same person
>    - Use PATCH net-next subject prefix
>    - Move -ENODEV handling from sfp_i2c_mdiobus_create() into
>      sfp_sm_add_mdio_bus() so bus-creation code does not mutate
>      sfp->mdio_protocol; the state machine is the correct place for
>      protocol-state transitions
>    - Split combined variable declaration for clarity
> 
> Changes since v2:
>    - Compile-tested and hardware-tested on BPI-R4 (MT7988A, 6.12.87)
>    - RTL8261BE (OEM/SFP-10G-T-I): probes MDIO_I2C_NONE, link Up 10Gbps
>    - Genuine RollBall (OEM/SFP-10G-T): bridge detected, link Up 10Gbps
> 
>   drivers/net/mdio/mdio-i2c.c | 65 ++++++++++++++++++++++++++++++------
>   drivers/net/phy/sfp.c       | 16 ++++++++--
>   2 files changed, 68 insertions(+), 13 deletions(-)
> --- a/drivers/net/mdio/mdio-i2c.c
> +++ b/drivers/net/mdio/mdio-i2c.c
> @@ -352,6 +352,54 @@
>   	return 0;
>   }
>   
> +static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
> +{
> +	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
> +	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
> +	u8 cmd_addr   = ROLLBALL_CMD_ADDR;
> +	struct i2c_msg msgs[2];
> +	u8 result;
> +	int ret;
> +	int i;
> +
> +	msgs[0].addr  = ROLLBALL_PHY_I2C_ADDR;
> +	msgs[0].flags = 0;
> +	msgs[0].len   = sizeof(data_buf);
> +	msgs[0].buf   = data_buf;
> +	msgs[1].addr  = ROLLBALL_PHY_I2C_ADDR;
> +	msgs[1].flags = 0;
> +	msgs[1].len   = sizeof(cmd_buf);
> +	msgs[1].buf   = cmd_buf;
> +
> +	ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
> +	if (ret < 0)
> +		return -ENODEV;
> +	if (ret)
> +		return ret;
> +
> +	msgs[0].addr  = ROLLBALL_PHY_I2C_ADDR;
> +	msgs[0].flags = 0;
> +	msgs[0].len   = 1;
> +	msgs[0].buf   = &cmd_addr;
> +	msgs[1].addr  = ROLLBALL_PHY_I2C_ADDR;
> +	msgs[1].flags = I2C_M_RD;
> +	msgs[1].len   = 1;
> +	msgs[1].buf   = &result;
> +
> +	for (i = 0; i < 10; i++) {
> +		msleep(20);
> +		ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
> +		if (ret < 0)
> +			return -ENODEV;
> +		if (ret)
> +			return ret;

I think this check is not needed, it seems to me that 
i2c_transfer_rollball() always returns either a negative number, or 
zero. All the calls in i2c_transfer_rollball() end-up returning the 
return value from __i2c_transfer_err(), which is always either negative 
or 0.

There's a similar check below that can be simplified as well

Maxime




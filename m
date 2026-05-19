Return-Path: <netdev+bounces-289214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAW8FoCqC2oGKwUAu9opvQ
	(envelope-from <netdev+bounces-289214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:10:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A8B57569D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 452D33032391
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCCA3AC00;
	Tue, 19 May 2026 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwIuIXcb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E418050
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149427; cv=none; b=cHkq9kwdbGBSxL8xmSqhLK0J+hZrNHDWoaPW0dGIf+/NSqPkvIppsE9Vk3S7PYthXxCsUodKlXgCceuLzr17k8cMMh9g0MzsaS3I97TkQ65LMZYccvDFuJXcGxDBcI9IHcXXqt4IW2mLOVHBu/zRR9hvTWS8DIrZqjDS+VhWX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149427; c=relaxed/simple;
	bh=Mo8/CGWGkJilXODGTqxfB+W+dru73o1aZU1xef0d8hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZU1fSLKlHVrsBlSxBnywpc9d7i05mykBabseSEW2L4aLdKkXnI7jnw+wXtVQrMQVM/zpnYgNf79QoXoB4Eo7BtzpTLFttZCnlQ1NxsnUVNOIFaxOj3KhPkH/iWoJvyR0h3alBWKfRCmOZ1Q/HhLSdBviMCFhZLuq/jp4Pv//VRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwIuIXcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341B4C2BCB7;
	Tue, 19 May 2026 00:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779149427;
	bh=Mo8/CGWGkJilXODGTqxfB+W+dru73o1aZU1xef0d8hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gwIuIXcb74AJ5fI/6XVQK6aDNHTNxTEvY6mpoQutBCADafg2/AE91KazXEQZbUG27
	 1oVmtPmfhitUcwJ7cyjQ9b4rRwB6a9Rmu9wZvBiVrdRNQR3v6BIBUap0jDSDBlBKfS
	 BTpdeTkKeD9JCxMblNxqbkWhAP3XgkjYksK1JFNvHMSuVKFpO0U7SgmRaokk9pM/g8
	 apKx2bp0j/8jGJcQKFHjnw8wMEVdXWiHZdKxxZBG66644EG3nCs/brWyCiP9tZ2eIy
	 Qh96egYE16JSqQ3gcc7NFEtEdewS4RgBNZG0bdaR646W1Ji4mIGa6rJ6w8W4BT59xO
	 8dQo23Yx25tXg==
Date: Mon, 18 May 2026 17:10:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Wozniak <petr.wozniak@gmail.com>
Cc: netdev@vger.kernel.org, bjorn@mork.no, andrew@lunn.ch,
 linux-phy@lists.infradead.org
Subject: Re: [PATCH v3] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge
 in mdio-i2c
Message-ID: <20260518171026.4f2f0c20@kernel.org>
In-Reply-To: <20260515174044.26036-1-petr.wozniak@gmail.com>
References: <20260515174044.26036-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289214-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 18A8B57569D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 15 May 2026 19:40:44 +0200 Petr Wozniak wrote:
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
> MDIO_I2C_ROLLBALL the kernel stalls waiting for a PHY that never
> appears:
> 
>   sfp sfp2: probing phy device through the [MDIO_I2C_ROLLBALL] protocol
> 
> Move the probe into i2c_mii_init_rollball() in mdio-i2c.c, where the
> RollBall protocol constants are already defined.  After sending the
> unlock password, issue a CMD_READ and wait ~70 ms for CMD_DONE.  A
> genuine RollBall bridge asserts CMD_DONE within that window; modules
> without a bridge never do, so i2c_mii_init_rollball() returns -ENODEV.
> sfp_i2c_mdiobus_create() treats -ENODEV as no PHY and falls back to
> MDIO_I2C_NONE without creating an MDIO bus.
> 
> Add "OEM"/"SFP-10G-T-I" to the quirk table so RTL8261BE modules enter
> the probe path; genuine RollBall modules continue to work as before.
> 
> Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
> Tested-by: Petr Wozniak <petr.wozniak@gmail.com>

Tested-by tag is for when the person testing is different than the
author of the patch. Please drop.

> Targeting: net-next

This usually means --subject-prefix="PATCH net-next vN"

But more importantly, this patch does not apply to netdev/net-next

> Changes since v2:
>   - Compile-tested and hardware-tested on BPI-R4 (MT7988A, 6.12.87)
>   - RTL8261BE (OEM/SFP-10G-T-I): probes MDIO_I2C_NONE, link Up 10Gbps
>   - Genuine RollBall (OEM/SFP-10G-T): bridge detected, link Up 10Gbps
> 
>  drivers/net/mdio/mdio-i2c.c | 59 +++++++++++++++++++++++++++++++++----
>  drivers/net/phy/sfp.c       |  8 ++++-
>  2 files changed, 60 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
> index da2001e..1973fda 100644
> --- a/drivers/net/mdio/mdio-i2c.c
> +++ b/drivers/net/mdio/mdio-i2c.c
> @@ -352,6 +352,52 @@ static int i2c_mii_write_rollball(struct mii_bus *bus, int phy_id, int devad,
>  	return 0;
>  }
>  
> +/*
> + * Probe for a RollBall I2C-to-MDIO bridge by issuing CMD_READ and waiting
> + * ~70 ms for CMD_DONE.  Genuine RollBall bridges respond within that window.
> + * Modules that share the same EEPROM vendor/part strings but have no bridge
> + * (e.g. RTL8261BE pure copper media converter) never assert CMD_DONE, so
> + * -ENODEV is returned for them.
> + */
> +static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
> +{
> +	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
> +	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
> +	u8 cmd_addr   = ROLLBALL_CMD_ADDR, result;

Is this code doing some magic or you're assigning to values to one
integer?

> +	struct i2c_msg msgs[2];
> +	int ret;
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
> +	if (ret)
> +		return ret;
> +
> +	msleep(70);
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
> +	ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
> +	if (ret)
> +		return ret;
> +
> +	return result == ROLLBALL_CMD_DONE ? 0 : -ENODEV;
> +}
> +
>  static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
>  {
>  	struct i2c_msg msg;
> @@ -372,10 +418,10 @@ static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
>  	ret = i2c_transfer(i2c, &msg, 1);
>  	if (ret < 0)
>  		return ret;
> -	else if (ret != 1)
> +	if (ret != 1)
>  		return -EIO;
> -	else
> -		return 0;
> +
> +	return i2c_mii_probe_rollball(i2c);
>  }
>  
>  struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
> @@ -399,9 +445,10 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
>  	case MDIO_I2C_ROLLBALL:
>  		ret = i2c_mii_init_rollball(i2c);
>  		if (ret < 0) {
> -			dev_err(parent,
> -				"Cannot initialize RollBall MDIO I2C protocol: %d\n",
> -				ret);
> +			if (ret != -ENODEV)
> +				dev_err(parent,
> +					"Cannot initialize RollBall MDIO I2C protocol: %d\n",
> +					ret);
>  			mdiobus_free(mii);
>  			return ERR_PTR(ret);
>  		}
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 218c775..ce745b6 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -599,7 +599,8 @@ static const struct sfp_quirk sfp_quirks[] = {
>  	SFP_QUIRK_S("TP-LINK", "TL-SM410U", sfp_quirk_oem_2_5g),
>  
>  	SFP_QUIRK_F("ETU", "ESP-T5-R", sfp_fixup_rollball_cc),
> -	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
> +	SFP_QUIRK_F("OEM", "SFP-10G-T-I", sfp_fixup_rollball),
> +	SFP_QUIRK_F("OEM", "SFP-10G-T",   sfp_fixup_rollball_cc),
>  	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
>  	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
>  	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
> @@ -802,6 +803,11 @@ static int sfp_i2c_mdiobus_create(struct sfp *sfp)
>  	int ret;
>  
>  	i2c_mii = mdio_i2c_alloc(sfp->dev, sfp->i2c, sfp->mdio_protocol);
> +	if (PTR_ERR_OR_ZERO(i2c_mii) == -ENODEV) {
> +		/* RollBall probe found no bridge: no PHY on this module */
> +		sfp->mdio_protocol = MDIO_I2C_NONE;

Uh, oh. Hope someone with SFP expertise will review v4.

> +		return 0;
> +	}
>  	if (IS_ERR(i2c_mii))
>  		return PTR_ERR(i2c_mii);
>  
-- 
pw-bot: cr


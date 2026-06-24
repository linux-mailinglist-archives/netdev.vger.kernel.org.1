Return-Path: <netdev+bounces-301779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JBGeKkhRPGpLmggAu9opvQ
	(envelope-from <netdev+bounces-301779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 072126C19AC
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:51:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b=UZGFAiFO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301779-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301779-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=wp.pl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8B9230747A6
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EE739DBF5;
	Wed, 24 Jun 2026 21:44:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE8373C1E
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:44:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337471; cv=none; b=DJ/4C7U4prExiqe/6aHDQ+WhFzhYi53vwkb/AACgNkS2l51TvEjGU0GAGZVj6AF5mPgwvNihCWeYmf7HHiYc1brE/ZJvvj06TBmtstyjF+HS/dusWJqfd82Hs3SQBjm9tU8moI741iQZ+4xNX3Yjbp9HXN+6S1rY+Fsp80x2T2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337471; c=relaxed/simple;
	bh=Pb2I+YUP7w2A3n/gc/jOjBejGatqsRTgVdBLJR12jyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vv9G5/7Xmmgkh3gYw4OGplYXmLqZGAc3YiAETs6yAnJz0Yn+dSYcef3b8LN9qcvlYlfQXtn753OPFCnJv+4rOWIbH+qb97YfzpePERuG8UDbyevkGLO572QBdPddLaQsz3YH4KnZxrr9HlvYHhc41oMmrji4Q8Bo2SMm2uxa3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=UZGFAiFO; arc=none smtp.client-ip=212.77.101.10
Received: (wp-smtpd smtp.wp.pl 19134 invoked from network); 24 Jun 2026 23:44:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1782337459; bh=MgAlixvu3YcH3zOlq8JQgllLgIIuI4eXbt5EM5vzO1o=;
          h=Subject:To:Cc:From;
          b=UZGFAiFODRg+qZTm7ZsWfQOQ3I3zqRNME1mDlfs2IJF+JHPnoVczpIH/ddRTBf/SR
           LGjYyoueClC6TgIGszv9QbuHlXHrV91dNBngmASpCGnjfZkj2/1+FYe0ZVlEiDjp7G
           OXQrzpbmd7Qm03ymKRc6b23tN42551xfKvsWRaQy0tAn6xq6v6O5EkqXPJ++5tDrOl
           8yLMt+D3VD0x/VVsXmVcnXdUmxV1hTs5Q/9uAvqTqerL4S/kYQnC8uFFw0Q6VYP/ea
           FwAqwsWu0kI3izP/979whaUPOYvXroXcHxN7b9dnhAUFbVDj5PB9J0mx4//yuU70ft
           5S+FkUQn/uQxw==
Received: from 83.5.235.152.ipv4.supernova.orange.pl (HELO [192.168.3.224]) (olek2@wp.pl@[83.5.235.152])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <petr.wozniak@gmail.com>; 24 Jun 2026 23:44:19 +0200
Message-ID: <9f813a8e-8b9a-4708-b3b6-db4972adac35@wp.pl>
Date: Wed, 24 Jun 2026 23:44:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] net: phy: mdio-i2c: defer RollBall bridge
 probe to PHY discovery
To: Petr Wozniak <petr.wozniak@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Bjorn Mork
 <bjorn@mork.no>, Marek Behun <kabel@kernel.org>
References: <20260624084814.20972-1-petr.wozniak@gmail.com>
 <20260624084814.20972-3-petr.wozniak@gmail.com>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20260624084814.20972-3-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 8ca0a447c3ef9a6b35f174f9fa01b2c8
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [EbIs]                               
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:petr.wozniak@gmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:maxime.chevallier@bootlin.com,m:bjorn@mork.no,m:kabel@kernel.org,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[wp.pl:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301779-lists,netdev=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,wp.pl:dkim,wp.pl:email,wp.pl:mid,wp.pl:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 072126C19AC

Hi Petr,

W dniu 24.06.2026 o 10:48, Petr Wozniak pisze:
> commit 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO
> bridge in mdio-i2c") introduced a regression: the RollBall I2C-to-MDIO
> bridge is not yet ready to respond to CMD_READ/CMD_DONE cycles when
> sfp_sm_add_mdio_bus() runs in SFP_S_INIT.  The 200 ms probe times out,
> i2c_mii_probe_rollball() returns -ENODEV, and sfp_sm_add_mdio_bus()
> sets mdio_protocol = MDIO_I2C_NONE.  By the time sfp_sm_probe_for_phy()
> runs (up to ~17 s later on affected hardware), the bridge is fully
> initialized but PHY probing is skipped because the protocol has already
> been changed to NONE.
>
> This affects both modules inserted before boot and hotplugged modules on
> hardware where bridge initialization exceeds the 200 ms probe window
> (confirmed: FLYPRO SFP-10GT-CS-30M with Aquantia AQR113C, hotplugged).
>
> Move the probe from i2c_mii_init_rollball(), called at bus-creation time,
> to sfp_sm_probe_for_phy() in sfp.c, where it runs after the SFP state
> machine module initialization delays.  Export the probe function as
> mdio_i2c_probe_rollball() so sfp.c can call it.
>
> For RTL8261BE-based modules the probe correctly returns -ENODEV at PHY
> discovery time, causing sfp_sm_probe_for_phy() to destroy the MDIO bus
> and set MDIO_I2C_NONE, eliminating the 5+ minute PHY probe retry loop.
>
> For genuine RollBall modules (e.g. FLYPRO SFP-10GT-CS-30M with Aquantia
> AQR113C) the probe now runs after initialization is complete and
> correctly returns 0, so PHY detection proceeds normally.
The FLPRO SFP module still fails to detect the PHY. It is necessary to
increase `module_t_wait` to 20 seconds. Most likely, during this time
the module loads the PHY firmware from SPI memory or from the
microcontroller (rollball bridge) via MDIO. Same probably applies to
most SFP modules with a PHY that load firmware at start-up (AQR113,
RTL8261C etc.).
>
> Reported-by: Aleksander Bajkowski <olek2@wp.pl>
> Fixes: 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c")
> Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
> ---
>   drivers/net/mdio/mdio-i2c.c   | 15 +++++++++------
>   drivers/net/phy/sfp.c         | 22 ++++++++++++++--------
>   include/linux/mdio/mdio-i2c.h |  1 +
>   3 files changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
> index b88f63234b4e..2a3a418c1369 100644
> --- a/drivers/net/mdio/mdio-i2c.c
> +++ b/drivers/net/mdio/mdio-i2c.c
> @@ -419,7 +419,7 @@ static int i2c_mii_write_rollball(struct mii_bus *bus, int phy_id, int devad,
>   	return 0;
>   }
>   
> -static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
> +int mdio_i2c_probe_rollball(struct i2c_adapter *i2c)
>   {
>   	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
>   	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
> @@ -462,9 +462,13 @@ static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
>   
>   	return -ENODEV;
>   }
> +EXPORT_SYMBOL_GPL(mdio_i2c_probe_rollball);
>   
>   static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
>   {
> +	/* Send the RollBall unlock password; bridge presence is verified
> +	 * later, in sfp_sm_probe_for_phy(), after module initialization.
> +	 */
>   	struct i2c_msg msg;
>   	u8 pw[5];
>   	int ret;
> @@ -486,7 +490,7 @@ static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
>   	if (ret != 1)
>   		return -EIO;
>   
> -	return i2c_mii_probe_rollball(i2c);
> +	return 0;
>   }
>   
>   static bool mdio_i2c_check_functionality(struct i2c_adapter *i2c,
> @@ -531,10 +535,9 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
>   	case MDIO_I2C_ROLLBALL:
>   		ret = i2c_mii_init_rollball(i2c);
>   		if (ret < 0) {
> -			if (ret != -ENODEV)
> -				dev_err(parent,
> -					"Cannot initialize RollBall MDIO I2C protocol: %d\n",
> -					ret);
> +			dev_err(parent,
> +				"Cannot initialize RollBall MDIO I2C protocol: %d\n",
> +				ret);
>   			mdiobus_free(mii);
>   			return ERR_PTR(ret);
>   		}
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index c4d274ab651e..01b941a38eed 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -2174,17 +2174,10 @@ static void sfp_sm_fault(struct sfp *sfp, unsigned int next_state, bool warn)
>   
>   static int sfp_sm_add_mdio_bus(struct sfp *sfp)
>   {
> -	int ret;
> -
>   	if (sfp->mdio_protocol == MDIO_I2C_NONE)
>   		return 0;
>   
> -	ret = sfp_i2c_mdiobus_create(sfp);
> -	if (ret == -ENODEV) {
> -		sfp->mdio_protocol = MDIO_I2C_NONE;
> -		return 0;
> -	}
> -	return ret;
> +	return sfp_i2c_mdiobus_create(sfp);
>   }
>   
>   /* Probe a SFP for a PHY device if the module supports copper - the PHY
> @@ -2215,6 +2208,19 @@ static int sfp_sm_probe_for_phy(struct sfp *sfp)
>   		break;
>   
>   	case MDIO_I2C_ROLLBALL:
> +		/* Probe here, after module initialization delays, so that
> +		 * genuine RollBall bridges have had time to start up.
> +		 * Modules without a bridge (e.g. RTL8261BE) return -ENODEV.
> +		 */
> +		err = mdio_i2c_probe_rollball(sfp->i2c);
> +		if (err == -ENODEV) {
> +			sfp_i2c_mdiobus_destroy(sfp);
> +			sfp->mdio_protocol = MDIO_I2C_NONE;
> +			err = 0;
> +			break;
> +		}
> +		if (err)
> +			break;
>   		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL, true);
>   		break;
>   	}
> diff --git a/include/linux/mdio/mdio-i2c.h b/include/linux/mdio/mdio-i2c.h
> index 65b550a6fc32..5cf14f45c94b 100644
> --- a/include/linux/mdio/mdio-i2c.h
> +++ b/include/linux/mdio/mdio-i2c.h
> @@ -20,5 +20,6 @@ enum mdio_i2c_proto {
>   
>   struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
>   			       enum mdio_i2c_proto protocol);
> +int mdio_i2c_probe_rollball(struct i2c_adapter *i2c);
>   
>   #endif

Best regards,
Aleksander



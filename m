Return-Path: <netdev+bounces-301407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J5FMADm0OmqLEQgAu9opvQ
	(envelope-from <netdev+bounces-301407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:28:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 653376B8B62
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:28:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=uqZoB4WI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301407-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301407-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 729FA3056AB8
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA90C3168E6;
	Tue, 23 Jun 2026 16:28:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF430DEA6
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 16:28:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232118; cv=none; b=VawYyVAYSmuzvCT1XUO/uzuGLJH2DIUscoCloewRmtgzv4ucFjoLOCy/Ia0omKzPEkXzjLqlpALMuEa5kxsaNN812nNMKpvpeJK+NjhMaT7EM+8zbW8O4++inC7x6Ne0N7GHsfd9A8b5+7NU3b9zHOsLI7B8j63h4gxEl92TOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232118; c=relaxed/simple;
	bh=JYwpcIX47nddD2774DvC+V55qVO1G31b/w+bMTcMW4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtcQ87yMHp5t59lppGQrtgYUi/ZjEzXagt2PjAiu975LLK2SuCPimSB0J3z25HPEZRKpd974AmqgzaJvJ4lhogAo0MQz+Tn9yIs1lqsgkQXX4mZKdTn/ta/a3abc4C6dk/qNHB+xp4J46hwHi5dKPZwH1NC71WhM2J/hMCXT63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uqZoB4WI; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 015F74E40773;
	Tue, 23 Jun 2026 16:28:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C00D8601C2;
	Tue, 23 Jun 2026 16:28:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFBF4106C8382;
	Tue, 23 Jun 2026 18:28:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782232112; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IchOvVpTDS/Xyh/l6otbYjeAJuO/oG+X0cJodck+dQI=;
	b=uqZoB4WI32tFj4icHZ/IixSLhTiwXInH5IYr2+lG5Tm1Z6YsFIZ2JJMOyyBbKIJjf6Satm
	0B1yo9iKHjozGgiy69arYJUg5GRrJ0NlbJq+5zPrwKuqgx7HSGdUbAe16+JJ5Sp10FP9w8
	uktPnudkhr2Jsvzz6adfI5/eU+FkF4f/pV9n5NfoA/9oIApT1ah8iDhO+6Iul0GJF9eFCu
	vhyEkjbIn2MkiNXk8YB6wCrBYFLdIByyCmXp6okzE+zMn1HP82Iy79M/HcpF1QQ3q8nEfy
	CntVKTErfEnuvixDAE6fzhv0GiVlVh69li2Qi5mEvEJ17LEr5gzysuJ0mrJt1g==
Message-ID: <b43cbdf9-3be4-45dc-ab5a-de85888ab347@bootlin.com>
Date: Tue, 23 Jun 2026 18:28:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: phy: mdio-i2c: defer RollBall bridge
 probe to PHY discovery
To: Petr Wozniak <petr.wozniak@gmail.com>, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, bjorn@mork.no, olek2@wp.pl, kabel@kernel.org
References: <20260623080538.7646-1-petr.wozniak@gmail.com>
 <20260623080538.7646-3-petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260623080538.7646-3-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301407-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:petr.wozniak@gmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:bjorn@mork.no,m:olek2@wp.pl,m:kabel@kernel.org,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,mork.no,wp.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wp.pl:email,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 653376B8B62

Hi Petr,

On 6/23/26 10:05, Petr Wozniak wrote:
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
> 
> Reported-by: Aleksander Bajkowski <olek2@wp.pl>
> Fixes: 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c")
> Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>

I'm not currently at home so I can't test that on my side, but as you'll
have to resend to the net tree, can you CC me for the next round so that
I can test with the few odd-ball modules I have ?

I expect to be able to test this on friday :(

Maxime

> ---
> v3: regenerated against net-next (v2 failed to apply due to transit
>     corruption); fixed block comment style (checkpatch); no functional
>     change.
> v2: commit message only - generalized scope (Aleksander Bajkowski);
>     corrected SM description (Jan Hoffmann); no code change from v1.
> v1: initial.
>  drivers/net/mdio/mdio-i2c.c   | 15 +++++++++------
>  drivers/net/phy/sfp.c         | 22 +++++++++++++---------
>  include/linux/mdio/mdio-i2c.h |  1 +
>  3 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
> index b88f63234b4e..2a3a418c1369 100644
> --- a/drivers/net/mdio/mdio-i2c.c
> +++ b/drivers/net/mdio/mdio-i2c.c
> @@ -419,7 +419,7 @@ static int i2c_mii_write_rollball(struct mii_bus *bus, int phy_id, int devad,
>  	return 0;
>  }
>  
> -static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
> +int mdio_i2c_probe_rollball(struct i2c_adapter *i2c)
>  {
>  	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
>  	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
> @@ -462,9 +462,13 @@ static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
>  
>  	return -ENODEV;
>  }
> +EXPORT_SYMBOL_GPL(mdio_i2c_probe_rollball);
>  
>  static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
>  {
> +	/* Send the RollBall unlock password; bridge presence is verified
> +	 * later, in sfp_sm_probe_for_phy(), after module initialization.
> +	 */
>  	struct i2c_msg msg;
>  	u8 pw[5];
>  	int ret;
> @@ -486,7 +490,7 @@ static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
>  	if (ret != 1)
>  		return -EIO;
>  
> -	return i2c_mii_probe_rollball(i2c);
> +	return 0;
>  }
>  
>  static bool mdio_i2c_check_functionality(struct i2c_adapter *i2c,
> @@ -531,10 +535,9 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
>  	case MDIO_I2C_ROLLBALL:
>  		ret = i2c_mii_init_rollball(i2c);
>  		if (ret < 0) {
> -			if (ret != -ENODEV)
> -				dev_err(parent,
> -					"Cannot initialize RollBall MDIO I2C protocol: %d\n",
> -					ret);
> +			dev_err(parent,
> +				"Cannot initialize RollBall MDIO I2C protocol: %d\n",
> +				ret);
>  			mdiobus_free(mii);
>  			return ERR_PTR(ret);
>  		}
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index c4d274ab651e..bbfaa0450798 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -2174,17 +2174,10 @@ static void sfp_sm_fault(struct sfp *sfp, unsigned int next_state, bool warn)
>  
>  static int sfp_sm_add_mdio_bus(struct sfp *sfp)
>  {
> -	int ret;
> -
>  	if (sfp->mdio_protocol == MDIO_I2C_NONE)
>  		return 0;
>  
> -	ret = sfp_i2c_mdiobus_create(sfp);
> -	if (ret == -ENODEV) {
> -		sfp->mdio_protocol = MDIO_I2C_NONE;
> -		return 0;
> -	}
> -	return ret;
> +	return sfp_i2c_mdiobus_create(sfp);
>  }
>  
>  /* Probe a SFP for a PHY device if the module supports copper - the PHY
> @@ -2215,7 +2208,18 @@ static int sfp_sm_probe_for_phy(struct sfp *sfp)
>  		break;
>  
>  	case MDIO_I2C_ROLLBALL:
> -		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL, true);
> +		/* Probe here, after module initialization delays, so that
> +		 * genuine RollBall bridges have had time to start up.
> +		 * Modules without a bridge (e.g. RTL8261BE) return -ENODEV.
> +		 */
> +		err = mdio_i2c_probe_rollball(sfp->i2c);
> +		if (err == -ENODEV) {
> +			sfp_i2c_mdiobus_destroy(sfp);
> +			sfp->mdio_protocol = MDIO_I2C_NONE;
> +			break;
> +		}
> +		if (!err)
> +			err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL, true);
>  		break;
>  	}
>  
> diff --git a/include/linux/mdio/mdio-i2c.h b/include/linux/mdio/mdio-i2c.h
> index 65b550a6fc32..5cf14f45c94b 100644
> --- a/include/linux/mdio/mdio-i2c.h
> +++ b/include/linux/mdio/mdio-i2c.h
> @@ -20,5 +20,6 @@ enum mdio_i2c_proto {
>  
>  struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
>  			       enum mdio_i2c_proto protocol);
> +int mdio_i2c_probe_rollball(struct i2c_adapter *i2c);
>  
>  #endif



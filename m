Return-Path: <netdev+bounces-264868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ9yE7L5qmmcZAEAu9opvQ
	(envelope-from <netdev+bounces-264868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:58:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2519224679
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EE1E30C2FA2
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A33431E7;
	Fri,  6 Mar 2026 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LOtcXmiL"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E74346FAB;
	Fri,  6 Mar 2026 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812231; cv=none; b=IFB/mzTIe1jAzPiQJb+F2OsWAOXGNhgvbrlyGXKRoOuYnLv8sheRRKoGBryQPfXDKRNypqgM8ovp9aPrI6zzqoWdzoXAXpttUQXdFsHlm1g/GxTXPa/+G5dMDYk90lzsIlKHJYO00vClsDO2g2Wyy9d5IqCvhZIt6hMogOM6M9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812231; c=relaxed/simple;
	bh=alRCj6fDuW+OL9t+QVU6Z5nc9qIcrj71oLsVA9Kotkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nptQeit7/eDVS9Pp2WSV6gy/KAQzNxNWrqzYIgV2z+a7FHlsvkqL9lNFkLJT0mcxMB29r4G6lmzakfvDJ3AwuOv8Tg+63SwJJlwajtRZmNh0puy7q6dJxXoBgS875eBiJ1WdOML3tVBSLCLcfOJeEBSLqMVPCBiEebJ75DRwZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LOtcXmiL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 801871A2D51;
	Fri,  6 Mar 2026 15:50:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4ACFE5FF92;
	Fri,  6 Mar 2026 15:50:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71EEC10369A3B;
	Fri,  6 Mar 2026 16:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772812226; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/KblCSFOD8tgbcK6ZAClucRb3T6o10oivIx0OjFPVbw=;
	b=LOtcXmiLRZxMoBaPnnOuwh4TznP25z20nol63tLpmi8ebZ5qxeWG1tMvElXrPopf5avXFR
	Q93Fx/pGfFhg10NbpzviGjqrUQEnmAYbFjcx8hyrp5YzYxErVFNBb0LB6ZwHbgmBhOjeW9
	SqMWL4BiQzPVIPvg52q5NTnGtgV/LAVBvUxKUBQi/RfRyV1IpbBXGw0QxiskAwLuoq46vk
	6Dj1Xh5O388T+hTDjboUwUU7W0LAMTH9XazaySrLeqCg5pqYEwzItmKA3LNdheNa27riRY
	ktN8arkhSADdi5TRXKdaSrTLkFFmPULLctd7R4zMnNeQYVyG5lGoN6yPpwDSSw==
Message-ID: <86a4cfac-75df-46f7-bd7d-b251df76fb5b@bootlin.com>
Date: Fri, 6 Mar 2026 16:50:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v6,07/10] net: phy: phy_port: Store information about a
 MII port's vacant state
To: Simon Horman <horms@kernel.org>
Cc: kory.maincent@bootlin.com, dimitri.fedrau@liebherr.com,
 netdev@vger.kernel.org, mwojtas@chromium.org, vladimir.oltean@nxp.com,
 andrew@lunn.ch, edumazet@google.com, nicveronese@gmail.com,
 thomas.petazzoni@bootlin.com, f.fainelli@gmail.com,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, kuba@kernel.org,
 daniel@makrotopia.org, o.rempel@pengutronix.de, romain.gantois@bootlin.com,
 herve.codina@bootlin.com, pabeni@redhat.com, davem@davemloft.net,
 christophe.leroy@csgroup.eu, kabel@kernel.org, hkallweit1@gmail.com
References: <20260304145444.442334-8-maxime.chevallier@bootlin.com>
 <20260306140315.493557-1-horms@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260306140315.493557-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: A2519224679
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264868-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,liebherr.com,vger.kernel.org,chromium.org,nxp.com,lunn.ch,google.com,gmail.com,armlinux.org.uk,kernel.org,makrotopia.org,pengutronix.de,redhat.com,davemloft.net,csgroup.eu];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Action: no action

Hi

On 06/03/2026 15:03, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: phy: phy_port: Store information about a MII port's vacant state
> 
> This patch adds a 'vacant' flag to phy_port to track whether an MII port
> currently has an SFP module installed. The flag is set to true when the
> port is created or when a module is removed, and set to false when a
> module is successfully inserted.
> 
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 8bff64040540..5d26d75b5f6b 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -1550,6 +1550,7 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
>>  	struct phy_device *phydev = upstream;
>>  	const struct sfp_module_caps *caps;
>>  	struct phy_port *port;
>> +	int ret = 0;
>>
>>  	phy_interface_t iface;
>>
>> @@ -1578,9 +1579,12 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
>>  		phydev->port = caps->port;
>>
>>  	if (port->ops && port->ops->configure_mii)
>> -		return port->ops->configure_mii(port, true, iface);
>> +		ret = port->ops->configure_mii(port, true, iface);
>>
>> -	return 0;
>> +	if (!ret)
>> +		port->vacant = false;
>> +
>> +	return ret;
>>  }
> 
> [ ... ]
> 
>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>> index 79f7811dec22..b575f5db9ed6 100644
>> --- a/drivers/net/phy/phylink.c
>> +++ b/drivers/net/phy/phylink.c
> 
> [ ... ]
> 
>> @@ -3917,6 +3918,9 @@ static int phylink_sfp_module_insert(void *upstream,
>>  	pl->sfp_may_have_phy = caps->may_have_phy;
>>  	pl->sfp_port = caps->port;
>>
>> +	if (pl->sfp_bus_port)
>> +		pl->sfp_bus_port->vacant = false;
>> +
>>  	/* If this module may have a PHY connecting later, defer until later */
>>  	if (pl->sfp_may_have_phy)
>>  		return 0;
> 
> Can the 'vacant' flag remain incorrectly set to false when the module is
> removed?
> 
> In phylink_sfp_module_insert(), the vacant flag is set to false before
> phylink_sfp_config_optical() is called. If phylink_sfp_config_optical()
> returns an error (for example, no common interface between MAC and SFP
> module), the error propagates back to sfp_sm_module(), which transitions
> the state machine to SFP_MOD_ERROR (enum value 1).
> 
> When the module is later physically removed, sfp_sm_mod_remove() checks
> 'sfp->sm_mod_state > SFP_MOD_WAITDEV' (enum value 3). Since SFP_MOD_ERROR
> is 1, which is less than 3, sfp_module_remove() is NOT called. This means
> phylink_sfp_module_remove() never executes and 'vacant' remains false even
> though the module was physically removed.
> 
> The PHY-side function phy_sfp_module_insert() in phy_device.c avoids this
> by gating the assignment:
> 
>     if (!ret)
>         port->vacant = false;
> 
> Should phylink_sfp_module_insert() use the same pattern, setting vacant to
> false only after phylink_sfp_config_optical() succeeds?

I'll rather reset-it upon failure, but that's correct and I tested this
error case to be indeed showing-up.

I'll address for the next revision

Maxime


Return-Path: <netdev+bounces-258237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LJjLy5OjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:38:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0508122D07
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6363B3004D30
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE673570DA;
	Wed, 11 Feb 2026 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM9D4jor"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA0B318EDB;
	Wed, 11 Feb 2026 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802729; cv=none; b=jvUWwVODi1aKaGXf+k/yeNNqVHLV4dTAMJxPROcsfj88Fpw+JmGNfWsfm6VWQc6MvRe554ZqSsIh+A6mhGojOxnclUdJczEUlPF8vmLfWl8loplf1bT//AoGdJ9wlcFyinjobtHNQ87LaRIjAZ31836jUQDpwEbL9bMAVYS6jKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802729; c=relaxed/simple;
	bh=TcIXjJVAwo0wUxg9/13yDcRkD00qe4LB4KLTTW0dogM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dg3cNDgSEKeEcLwSgThXvlUf+VnxllQOBtTSeBAjGNnkW6GlJ6JXL642bNTZtUM2DEuuVf+PetHB/CqD/8xYr2tyBshcNlukmlJjwPXEykWK/K5prfuSDT+jNEU/+333KPASExXvmnhiClwxUXX/xnmxreZCs0PVranZ5D3/h9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM9D4jor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927D6C4CEF7;
	Wed, 11 Feb 2026 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770802728;
	bh=TcIXjJVAwo0wUxg9/13yDcRkD00qe4LB4KLTTW0dogM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aM9D4jorgDgk4mAc2LWNZ5qCkNdZ28idtUQ8lNPFEJqHD9N0hzJzS4owm2xCvDrg7
	 wnJs6Yp6Xc3KmpwoxddK9GndZUTJ+ZTsfun6yD6kM7aGThPoOPKDmECmPX5MWJqu3h
	 GLb/hYZ5QUjldW37Lt8aTdjdnpqUfUfQDpbQl3tqr8GdU7bEDX29ysoNNRA9PpcNEh
	 nYY2beeoGgXehCtqmVsCt82vKlAGUoRJZCqJuP7rdgntJ2gP1cOtDfY5xZFxN9uYZx
	 Nu60/61mFZCs7/ph5lj+h7Hu/aMMr9nOG48HBuCic8Jpe0srMOxEU2jMWbe1VGcKmp
	 97WcbEh/UEN2A==
Message-ID: <daa8c723-1800-4c79-8fa1-b7d47f80c4d4@kernel.org>
Date: Wed, 11 Feb 2026 10:38:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 02/13] net: phy: phy_port: Cleanup the
 of-parsing logic for phy_port
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
 <20260205092317.755906-3-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260205092317.755906-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258237-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E0508122D07
X-Rspamd-Action: no action



Le 05/02/2026 à 10:23, Maxime Chevallier a écrit :
> We don't need to maintain a mediums bitfield, let's drop it and drop a
> bogus check for empty mediums, as we already check it above.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/phy/phy_port.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
> index ec93c8ca051e..a269e9ea12c4 100644
> --- a/drivers/net/phy/phy_port.c
> +++ b/drivers/net/phy/phy_port.c
> @@ -53,7 +53,7 @@ struct phy_port *phy_of_parse_port(struct device_node *dn)
>   	enum ethtool_link_medium medium;
>   	struct phy_port *port;
>   	const char *med_str;
> -	u32 pairs = 0, mediums = 0;
> +	u32 pairs = 0;
>   	int ret;
>   
>   	ret = fwnode_property_read_string(fwnode, "media", &med_str);
> @@ -85,17 +85,12 @@ struct phy_port *phy_of_parse_port(struct device_node *dn)
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> -	mediums |= BIT(medium);
> -
> -	if (!mediums)
> -		return ERR_PTR(-EINVAL);
> -
>   	port = phy_port_alloc();
>   	if (!port)
>   		return ERR_PTR(-ENOMEM);
>   
>   	port->pairs = pairs;
> -	port->mediums = mediums;
> +	port->mediums = BIT(medium);
>   
>   	return port;
>   }



Return-Path: <netdev+bounces-264809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L9eHofhqmkJYAEAu9opvQ
	(envelope-from <netdev+bounces-264809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:15:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA02226B7
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFC3831AB09B
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF83ACA4B;
	Fri,  6 Mar 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IszWeeh2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275493A9DAB;
	Fri,  6 Mar 2026 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805820; cv=none; b=hTCO9nVZQ0Br22TlNCTo+PvhEd9hSNMANIJ1nhY9FKiBJ/BHS8yYnhVllPUARSjE4xa47icmFnI2TaSncuHzWiQyoT44Knx2KZrG2ljfHIIb5Eg1pwDn0W/uDOlQ6cO+m8fZ3qrux6hAbA16QxGkwFucMpLcPDx2G1ea3u6ZuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805820; c=relaxed/simple;
	bh=z8s7JFWTNdEXx4zB69ahDzwoaCEGMttxHcIPxME2DS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OijYQrZbh/5HnD0OcLdo9NGj3OBYC879LvfBowoJj+p5d4g3v2+rAMCOPU1gjfW72A1N9PnXblF+M2HIeir6sPo5ORbh9iaQ5tP1BMJh1fE7IWO9osYtsoeAcJWuEehknmH2fYbftwPDj/F3l4/zBo5dDiw2AIBlIWx67kA8/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IszWeeh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22234C2BC86;
	Fri,  6 Mar 2026 14:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772805819;
	bh=z8s7JFWTNdEXx4zB69ahDzwoaCEGMttxHcIPxME2DS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IszWeeh2AaR1IhVmAWyc0F41rLpYHYW/PjMiWagVifvjpGDnqR8c5GLqzCnA7/Buu
	 ugd28i2S+yZRV+8egCSVpuHiE9arFdjRho0BBHnNwTHfCe8g58B8IIxcfpvyN35gCM
	 4K16E8+q6h55CINSUCOeuIsAsF9pEp/UwWXvaxNNi2J0KML4sp0k7QDjHkusfEWTf7
	 biZXFlpe/tUYpbb/AQ7n5h0stg4nV6UGqtFOT9eiAEs1lKEqZsjRUXV5k9bDB8B6p9
	 QQbKg+U7xATFFZcekZyP13ZnSBQsS3xAOUR5eW8771VfA3x50z5zA2XMKrM33d8UYs
	 Xle2gOwoSURFw==
From: Simon Horman <horms@kernel.org>
To: maxime.chevallier@bootlin.com
Cc: Simon Horman <horms@kernel.org>,
	kory.maincent@bootlin.com,
	dimitri.fedrau@liebherr.com,
	netdev@vger.kernel.org,
	mwojtas@chromium.org,
	vladimir.oltean@nxp.com,
	andrew@lunn.ch,
	edumazet@google.com,
	nicveronese@gmail.com,
	thomas.petazzoni@bootlin.com,
	f.fainelli@gmail.com,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	daniel@makrotopia.org,
	o.rempel@pengutronix.de,
	romain.gantois@bootlin.com,
	herve.codina@bootlin.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	christophe.leroy@csgroup.eu,
	kabel@kernel.org,
	hkallweit1@gmail.com
Subject: Re: [net-next,v6,07/10] net: phy: phy_port: Store information about a MII port's vacant state
Date: Fri,  6 Mar 2026 14:03:15 +0000
Message-ID: <20260306140315.493557-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304145444.442334-8-maxime.chevallier@bootlin.com>
References: <20260304145444.442334-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03EA02226B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,bootlin.com,liebherr.com,vger.kernel.org,chromium.org,nxp.com,lunn.ch,google.com,gmail.com,armlinux.org.uk,makrotopia.org,pengutronix.de,redhat.com,davemloft.net,csgroup.eu];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-264809-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: phy_port: Store information about a MII port's vacant state

This patch adds a 'vacant' flag to phy_port to track whether an MII port
currently has an SFP module installed. The flag is set to true when the
port is created or when a module is removed, and set to false when a
module is successfully inserted.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 8bff64040540..5d26d75b5f6b 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1550,6 +1550,7 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
>  	struct phy_device *phydev = upstream;
>  	const struct sfp_module_caps *caps;
>  	struct phy_port *port;
> +	int ret = 0;
>
>  	phy_interface_t iface;
>
> @@ -1578,9 +1579,12 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
>  		phydev->port = caps->port;
>
>  	if (port->ops && port->ops->configure_mii)
> -		return port->ops->configure_mii(port, true, iface);
> +		ret = port->ops->configure_mii(port, true, iface);
>
> -	return 0;
> +	if (!ret)
> +		port->vacant = false;
> +
> +	return ret;
>  }

[ ... ]

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 79f7811dec22..b575f5db9ed6 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c

[ ... ]

> @@ -3917,6 +3918,9 @@ static int phylink_sfp_module_insert(void *upstream,
>  	pl->sfp_may_have_phy = caps->may_have_phy;
>  	pl->sfp_port = caps->port;
>
> +	if (pl->sfp_bus_port)
> +		pl->sfp_bus_port->vacant = false;
> +
>  	/* If this module may have a PHY connecting later, defer until later */
>  	if (pl->sfp_may_have_phy)
>  		return 0;

Can the 'vacant' flag remain incorrectly set to false when the module is
removed?

In phylink_sfp_module_insert(), the vacant flag is set to false before
phylink_sfp_config_optical() is called. If phylink_sfp_config_optical()
returns an error (for example, no common interface between MAC and SFP
module), the error propagates back to sfp_sm_module(), which transitions
the state machine to SFP_MOD_ERROR (enum value 1).

When the module is later physically removed, sfp_sm_mod_remove() checks
'sfp->sm_mod_state > SFP_MOD_WAITDEV' (enum value 3). Since SFP_MOD_ERROR
is 1, which is less than 3, sfp_module_remove() is NOT called. This means
phylink_sfp_module_remove() never executes and 'vacant' remains false even
though the module was physically removed.

The PHY-side function phy_sfp_module_insert() in phy_device.c avoids this
by gating the assignment:

    if (!ret)
        port->vacant = false;

Should phylink_sfp_module_insert() use the same pattern, setting vacant to
false only after phylink_sfp_config_optical() succeeds?


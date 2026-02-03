Return-Path: <netdev+bounces-256412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKOzD3Y4gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:03:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ADCDD44E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD5EE30B90BE
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733EF267B89;
	Tue,  3 Feb 2026 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5YMJMHJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C21FE47C;
	Tue,  3 Feb 2026 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141782; cv=none; b=DA2DkqSRs7RIwpDG9UeQ8WKVbeOpdQm9pH4bhDNgwSf+4muLeJp8oVS/cVHW/S7QKQiw4ls2YEUOYYKM1GQKPBwMMpQBp/zuvcXhoKC0rFf5B2SvhttFXLvyqraGFJ+0a+K/05x6u4O9JZ2VxpZO2xn/T31hhC1MufJD28gmOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141782; c=relaxed/simple;
	bh=Vi4JL2QtndqoWDCwMafhnQtzuyfnYj8ixHUpbx0J7tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSFBXBDkSEw4X4eI5begAD/suXRjAuqMfioKN9deYkJURlyy4yovni0E/Z61En+oli/O6+o6t2uhPMCvw9tTC2pz9+nBIAawPsX14Ge5kpW9HcdYUum1kN+eEzdxUO+akqC98UT7XIP6dNjXxV8Y/wyj5LjlQILjCrLQG4JevV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5YMJMHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2BEC16AAE;
	Tue,  3 Feb 2026 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770141781;
	bh=Vi4JL2QtndqoWDCwMafhnQtzuyfnYj8ixHUpbx0J7tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5YMJMHJlm9pumA6TVGCeCKPkBF5m9y7g0BxTh+wpyEnyTzFd9W1GHalX82hhNNbO
	 +jfEIa4t/rG5AUWiveeiEQDWaOJuWZGt/HWFEHqQNMeVYcEda0HK8MTI1naEL7be+B
	 5uql7U1dU4VJl3uzlF9JwC2H7qzbgcnHC/aVS3NpxSux01Q4KPuUsjkUuo7KWoeRoV
	 vTbcyJjPKNHFDfZyMAv6Cy0eNmDpo372UsApEP5nCBm5D+gGSxm4J+fiJo436DsGC+
	 0rf3m9BaWl5XP3h9zOinTPZn8qU+kS5U/rKj0EYj4MXgTXnW2lemvzxQOzh4ndgc9l
	 YoxRmEuCE3tmA==
From: Simon Horman <horms@kernel.org>
To: maxime.chevallier@bootlin.com
Cc: Simon Horman <horms@kernel.org>,
	hkallweit1@gmail.com,
	nicveronese@gmail.com,
	f.fainelli@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	dimitri.fedrau@liebherr.com,
	thomas.petazzoni@bootlin.com,
	kabel@kernel.org,
	kuba@kernel.org,
	vladimir.oltean@nxp.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	romain.gantois@bootlin.com,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	linux@armlinux.org.uk,
	kory.maincent@bootlin.com,
	mwojtas@chromium.org,
	christophe.leroy@csgroup.eu,
	herve.codina@bootlin.com,
	netdev@vger.kernel.org,
	daniel@makrotopia.org
Subject: Re: [net-next,v3,03/11] net: phy: phy_link_topology: Track ports in phy_link_topology
Date: Tue,  3 Feb 2026 18:02:50 +0000
Message-ID: <20260203180250.2175436-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201151249.642015-4-maxime.chevallier@bootlin.com>
References: <20260201151249.642015-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com,google.com,liebherr.com,bootlin.com,nxp.com,lunn.ch,davemloft.net,vger.kernel.org,pengutronix.de,armlinux.org.uk,chromium.org,csgroup.eu,makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-256412-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: A4ADCDD44E
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: phy_link_topology: Track ports in phy_link_topology

This commit adds port tracking to phy_link_topology, keeping track of all
ports connected to a netdev. Ports are added when a PHY is attached and
removed when it is detached.

> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 7dc2ff10c74a..456f1144e83e 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c

[ ... ]

> +int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port)
> +{
> +	struct phy_link_topology *topo;
> +	int ret;
> +
> +	topo = phy_link_topo_get_or_alloc(dev);
> +	if (IS_ERR(topo))
> +		return PTR_ERR(topo);
> +
> +	/* Attempt to re-use a previously allocated port_id */
> +	if (port->id)
> +		ret = xa_insert(&topo->ports, port->id, port, GFP_KERNEL);
> +	else
> +		ret = xa_alloc_cyclic(&topo->ports, &port->id, port,
> +				      xa_limit_32b, &topo->next_port_index,
> +				      GFP_KERNEL);
> +
> +	return ret;
> +}

[ ... ]

> @@ -89,8 +126,20 @@ int phy_link_topo_add_phy(struct net_device *dev,
>  	if (ret < 0)
>  		goto err;
> +
> +	/* Add all the PHY's ports to the topology */
> +	list_for_each_entry(port, &phy->ports, head) {
> +		ret = phy_link_topo_add_port(dev, port);
> +		if (ret)
> +			goto del_ports;
                   ^^^

xa_alloc_cyclic() returns 1 when ID allocation wraps around, which is still a
successful allocation. The check at line 126 above correctly uses `if (ret < 0)`
for the phyindex allocation:

    ret = xa_alloc_cyclic(&topo->phys, &phy->phyindex, pdn, ...);
    if (ret < 0)
        goto err;

Should this use `if (ret < 0)` as well for consistency? With the current code,
when the port ID wraps around, the PHY attachment will fail and trigger rollback
of all successfully added ports even though the allocation succeeded.


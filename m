Return-Path: <netdev+bounces-299062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ap04IkvULWqAkwQAu9opvQ
	(envelope-from <netdev+bounces-299062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:06:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4267FD9A
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:06:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lO4zedIv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299062-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299062-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9F49300DA45
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898703358B9;
	Sat, 13 Jun 2026 22:06:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041C30DED5;
	Sat, 13 Jun 2026 22:05:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388360; cv=none; b=AJuMrB0rPXWehn6EEwA1cEZ5RHBL3oIHLH15kAkJhd7lIxPiKbopr9nQOrus1fW5rpNmfkXUe3PtZgcLPU2GY5w6WbfXDuJaQjMg2hPf8z+KDy6s2C1N3/0cf56DrjIez2uil9xuwaIbUIYGN9HQ+BwBkK/ClfYoUnoWuDhIOec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388360; c=relaxed/simple;
	bh=sHeMVUuCSd4K7SEBAUJeFEQVfiZQImCaAuHgnkpTaNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPLqO/L7QBdK7/GpTx8hcaKMNtZE8L2KRpRcD4iyG4B/zW9UgolMYxx8481gKt3c49SRF+Ywj0CdoDvYa6YYDXJEmbZvbI8upKqvv8aNTNZ0PEgj5YcxruK/K3x9olm1xG/mnJv52F47QpKPHjHvamjYcvpvIrqqYir/RPRdBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO4zedIv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7291F000E9;
	Sat, 13 Jun 2026 22:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388359;
	bh=siC0/PmhcyZls+NjWW5qI6UPxpnq2ntQtriOMSz0A/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lO4zedIvli8iRcvDwC1SRkgRodkTwFbtXy22SkerB8dg0RdkBcgT6auM7Sj6vh1AJ
	 0mL6Rdc5WVQgaMZSG9fYxo4YQTdC73wiwH9vU/4XE5iPqILzofIHzxZJCn+1+yn81+
	 d+4LS9DDnXMUcOcDCFI76CN6IlaOKj1UO34HU6yGRY8MZ4KTh3hYJuDCPxwqbXDRD0
	 ZBQMix62QXSbuTbSuy6Kb2dx8at+tThy3mhGIWJ3ddlQdpFJqrwA08/9kt4oQcdYWw
	 XWAX9OIFP1DGeOYOMbFR3fuaTEa1g/wkFnEsmnbYTGZ6V70A0fP6f/oObdjOQD2EBK
	 SHMqW0AnUATiw==
From: Jakub Kicinski <kuba@kernel.org>
To: javen_xu@realsil.com.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] r8169: create a virtual interrupt for linkchg
Date: Sat, 13 Jun 2026 15:05:56 -0700
Message-ID: <20260613220556.219558-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611094345.880-3-javen_xu@realsil.com.cn>
References: <20260611094345.880-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299062-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:kuba@kernel.org,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,bootlin.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0F4267FD9A

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8169: create a virtual interrupt for linkchg

Creates a virtual interrupt for linkchg. To support phylink, we should try
to decouple most of tp->phydev, so we add virtual interrupt for mac
interrupt to inform the change of link status.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index c60710f9bd21f..560f987437b63 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
[ ... ]
> @@ -4869,7 +4872,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  	}
>  
>  	if (status & LinkChg)
> -		phy_mac_interrupt(tp->phydev);
> +		generic_handle_domain_irq(tp->phy_irq_domain, 0);

[Severity: High]
Does this actually work as intended without the PHY driver implementing the
interrupt callbacks?

Because the Realtek PHY drivers don't implement .config_intr and
.handle_interrupt, phy_drv_supports_irq() will return false, causing
phy_probe() to force phydev->irq to PHY_POLL.

Will this cause the virtual interrupt to be unhandled by phylib, meaning
link state detection degrades from an immediate event-driven notification to
1-second polling?

>  	rtl_irq_disable(tp);
>  	napi_schedule(&tp->napi);
[ ... ]
> @@ -5458,6 +5488,21 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
[ ... ]
> +	virq = irq_create_mapping(tp->phy_irq_domain, 0);
> +	if (!virq)
> +		ret = -EINVAL;
> +
> +	new_bus->irq[0] = virq;
> +
>  	ret = devm_mdiobus_register(&pdev->dev, new_bus);

[Severity: Medium]
If irq_create_mapping() fails, ret is set to -EINVAL, but does this
assignment get immediately overwritten by the return value of
devm_mdiobus_register()?

This would cause the IRQ mapping failure to be silently ignored, leaving
the bus with an invalid IRQ of 0 without aborting the driver initialization.

>  	if (ret)
>  		return ret;


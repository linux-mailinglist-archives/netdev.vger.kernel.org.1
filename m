Return-Path: <netdev+bounces-295156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xYNWA2ZUIWrsDgEAu9opvQ
	(envelope-from <netdev+bounces-295156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:33:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB73B63F113
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:33:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=Ntyc6x3l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295156-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295156-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2794A308A647
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4CF3DB33A;
	Thu,  4 Jun 2026 10:14:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3D2DECCC;
	Thu,  4 Jun 2026 10:14:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568081; cv=none; b=Fk85EzNJgIW0jyeNc+DRA367HoSwVyzElkcNbVL2/RYrP/w/PgwQSl0WsWRMejk32IQ3awW+Dt7Pi/6Zlnt0JBjcPHAtizjCVDca8S6pmHYHcUCAnKSI9IcUabLGMnjuKP0rdLgPV7mhPW2lxmKEqczUX2PEyKqO0LEsWAJF190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568081; c=relaxed/simple;
	bh=/+CJJgRHEyIIeHG5j3aiknNYDnxeautieeBV+Z34z38=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LFAdWBjX4UhmZE8/pg9yIeNt9glKiStmjVRI/ehRuqPjj9tAQCSMubhvh/QgEb0Vc1mKZi+KWK5UHMECZyBy7/MiiYHEFNmDYu2/VkKRAvjJmldqOBFPJF6qnlHo3P2pDWxEjKZ7c7SSdoROTNdyqOe1wrK7YVmvJu0lyUfLWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Ntyc6x3l; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 61FD4A4C3B;
	Thu,  4 Jun 2026 12:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780568074; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zemI8c9e1s9E7UmnLp+2NAD5n/JjJXwZd+gMxu4JH7k=;
	b=Ntyc6x3lhqB4xDkFJkHLiSGXeuqM45oO/ZDtM92IDCgx1wqXA5I4zcVGxrmB4jSnbTKTU3
	XaVEY7ZaFjfJv+aXopYUEKWifpK6NLmlyMMweL70ttE0Rdl819CNRvk3xVJLGjkBaKYIjE
	tDnO5ulISBJBsxyTcJJgHzTZk+nJJd10CxqLx9uQfqCs1NJlmIuSost0x8l2Ll9j0sSndV
	O0Sj5GwmqigECwoc8mrPQm2XDAVHDOBKuWVum/hywiBK15yJQ6FqREbBqCYS0nf5ZeOH60
	EmiRDdXhf9Dj7u3CQEFPv7gES8DhMHv5XEbMR1nSsCwC0K8pRyHaQi+jXCl9rg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 12:14:32 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net v3 3/4] net: phy: Clean the phy_ports after
 unregistering the downstream SFP bus
In-Reply-To: <20260604092819.723505-4-maxime.chevallier@bootlin.com>
References: <20260604092819.723505-1-maxime.chevallier@bootlin.com>
 <20260604092819.723505-4-maxime.chevallier@bootlin.com>
Message-ID: <4cafbb0aef07e1a41d3ee784062c7da6@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295156-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB73B63F113

HI Maxime

On 4.6.2026 11:28, Maxime Chevallier wrote:
> As reported by sashiko when looking a other patches, we need to ensure
> that the downstream SFP bus gets unregistered prior to destroying the
> phy_ports attached to a phy_device, as the SFP code may reference these
> ports. Let's make sure we follow that ordering in phy_remove().
> 
> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phy_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c 
> b/drivers/net/phy/phy_device.c
> index 4ba880446896..b48722589f40 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3806,11 +3806,11 @@ static int phy_remove(struct device *dev)
> 
>  	phydev->state = PHY_DOWN;
> 
> -	phy_cleanup_ports(phydev);
> -
>  	sfp_bus_del_upstream(phydev->sfp_bus);
>  	phydev->sfp_bus = NULL;
> 
> +	phy_cleanup_ports(phydev);
> +
>  	if (phydev->drv && phydev->drv->remove)
>  		phydev->drv->remove(phydev);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai


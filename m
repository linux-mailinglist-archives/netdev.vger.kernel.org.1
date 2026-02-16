Return-Path: <netdev+bounces-258856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM5hBbLykmlA0QEAu9opvQ
	(envelope-from <netdev+bounces-258856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:34:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B1142628
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F28A2300F123
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D00E2FFDD6;
	Mon, 16 Feb 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RI7NKw8P"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8FC1DC1AB;
	Mon, 16 Feb 2026 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771238063; cv=none; b=FtJNqREhdz7hS5MtjLZKaFGHYEwuRfGzYZFTofIKMrRgcAFrhzBlTxELdF9zmCKRFdFc/QK3cy+HDmJgGGxek7yhwPEAFpo+mUREURPGKF3G0av8586SgUSTvDzKURE0D2XOnexMBHP1XLlXNRgEcXsUbHwoRalMDQViN2t5pAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771238063; c=relaxed/simple;
	bh=ZgFvXqB7OIIq3cqHaAayaKmI3aY/GQrJ1CCVyI+LHOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdoOGMrIfuav155NG3aWsyURwTG02FHwr5VjyXoYjP+fiFj+VNykMXKmz/NyYKnA4yDB76kNPlSdDBexRqw7XDDEOS6V/w4FHdksUmyVLtuvZ1j3AuuU6fFzkWWHNwXaN01+3eEj+63QpjnHecow+1TVpQ+3cll5ydxpVoIU9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RI7NKw8P; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AF2514E40E5C;
	Mon, 16 Feb 2026 10:34:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7FBB6606CF;
	Mon, 16 Feb 2026 10:34:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CF2B10369103;
	Mon, 16 Feb 2026 11:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771238057; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=j0JfYH/N+5qnt8WjrKjK2dQuFGoBJxtP7j0yVksQMnw=;
	b=RI7NKw8PlHoVYWB/13lxZPb2BAikDJPH7BvjDeucaA3sjv+PVCgRcBEV7lv3lB92KiB+D8
	gRBOpc+L+1sFaScDaSve7hyWUXnZWDxi9K0DTkg6Gf8fEpMTqQm84WSsXeIgojulJE1cYF
	ozGmWPmSV0j0QqCfzK1Izuz6wHH6B2H0ePI3ijqMzNRcUDQrjuZRpCy/FOhHnb/Hy6HmM8
	rnRfavAc8lrcMmY/4yFE3uR/JDIMhdGCNWuoAXfF5bBfdfdgr1s5ay4dlEJdB3T67QQjFj
	3c7YW8yHawYCUJlDaZqHaRIQrkaxrSO+g6CJ8ksxpB52u90YPeYqwg9yZU1iIg==
Message-ID: <b598aad8-5151-47b2-949f-321b87baa638@bootlin.com>
Date: Mon, 16 Feb 2026 11:34:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: usb: lan78xx: scan all MDIO addresses on LAN7801
To: =?UTF-8?Q?Martin_P=C3=A5lsson?= <martin@poleshift.se>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0110019c64da3c2a-d4a4adbe-c78b-4051-a95b-e7ed5db247a1-000000@eu-north-1.amazonses.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <0110019c64da3c2a-d4a4adbe-c78b-4051-a95b-e7ed5db247a1-000000@eu-north-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258856-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,poleshift.se:email]
X-Rspamd-Queue-Id: 6A5B1142628
X-Rspamd-Action: no action

Hi Martin,

On 16/02/2026 06:09, Martin Pålsson wrote:
> The LAN7801 is designed exclusively for external PHYs (unlike the
> LAN7800/LAN7850 which have internal PHYs), but lan78xx_mdio_init()
> restricts PHY scanning to MDIO addresses 0-7 by setting phy_mask to
> ~(0xFF). This prevents discovery of external PHYs wired to addresses
> outside that range.
> 
> One such case is the DP83TC814 100BASE-T1 PHY, which is typically
> configured at MDIO address 10 via PHYAD bootstrap pins and goes
> undetected with the current mask.
> 
> Set phy_mask to 0 for the LAN7801 so that all 32 MDIO addresses are
> scanned during bus registration, allowing any external PHY to be
> discovered regardless of its address.
> 
> Fixes: 02dc1f3d613d ("lan78xx: add LAN7801 MAC only support")
> 
> Signed-off-by: Martin Pålsson <martin@poleshift.se>
> ---
> Changes in v2:
> - Added Fixes: tag
> - Link to v1: https://lore.kernel.org/r/20260214-lan78xx-phy-mask-fix-v1-1-3baa100861e4@poleshift.se
> ---
>  drivers/net/usb/lan78xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 00397a807393..9d8f1ff7028d 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2094,8 +2094,8 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
>  		dev->mdiobus->phy_mask = ~(1 << 1);
>  		break;
>  	case ID_REV_CHIP_ID_7801_:
> -		/* scan thru PHYAD[2..0] */
> -		dev->mdiobus->phy_mask = ~(0xFF);
> +		/* scan all 32 MDIO addresses for external PHYs */
> +		dev->mdiobus->phy_mask = 0;

As this is the default behaviour for mdio bus controllers, and the
default value for the mask is 0, I think you can simply discard that
assignment.

I don't even think we need a comment, as the other cases for 7800/7850
already have a comment explaining why they are special cases.

Maxime



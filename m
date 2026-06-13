Return-Path: <netdev+bounces-299020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yvS4MzemLWruiAQAu9opvQ
	(envelope-from <netdev+bounces-299020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:49:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF167F59E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:49:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299020-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299020-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D087A30041DB
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD322F7EFD;
	Sat, 13 Jun 2026 18:49:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D552DA74A;
	Sat, 13 Jun 2026 18:49:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781376563; cv=none; b=QNzQ159pw93+EBIEYsiZdOPL3hiIJlA+UkUFi36ZxCCbeBY6AzA2OLI5KP7dT5dKjYIe4E4C0YDx91MZdwG/Q4wmqwhl0q/PpHGefnhsKcwCbmn6aFXLE8ghZ4CEQZFcv6167q+gsuEHzQZFX75CBvd3SofUFKylayWd9eJi/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781376563; c=relaxed/simple;
	bh=WcxGAQyg4LKogBzDFjtFhUITqdkwauGV7XDxQWjr/w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1XFcZGkTBddvklCru2UHVXm8DCEi9rEUiCd8N3zheztoxq/02xHsyksfQBh7DTIYSkBjyMvAvFehiNMZEgS7o0iI6gXQ7pF/MHbDqE49QUnSONiZJpvcFml5ejuls9RqGjHwMEB2hiX85cs4kwaf6TWjtSGKU4EwwgCox+YoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYTPw-000000002WZ-1lbr;
	Sat, 13 Jun 2026 18:49:16 +0000
Date: Sat, 13 Jun 2026 19:49:13 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH net-next v5 2/4] net: phy: mediatek: add phy driver for
 MT7628 built-in Fast Ethernet PHYs
Message-ID: <ai2mKe-fC2D_6pc8@makrotopia.org>
References: <20260613181845.111877-1-joey@tinyisr.com>
 <20260613181845.111877-3-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613181845.111877-3-joey@tinyisr.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299020-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:joey@tinyisr.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:olteanv@gmail.com,m:andrew@lunn.ch,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:arinc.unal@arinc9.com,m:Landen.Chao@mediatek.com,m:dqfext@gmail.com,m:sean.wang@mediatek.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,arinc9.com,mediatek.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,tinyisr.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CEF167F59E

On Sat, Jun 13, 2026 at 09:18:43PM +0300, Joris Vaisvila wrote:
> The Fast Ethernet PHYs present in the MT7628 SoCs require an
> undocumented bit to be set before they can establish 100mbps links.
> 
> This commit adds the Kconfig option MEDIATEK_FE_SOC_PHY and the
> corresponding driver mtk-fe-soc.c.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> [...]
> diff --git a/drivers/net/phy/mediatek/mtk-fe-soc.c b/drivers/net/phy/mediatek/mtk-fe-soc.c
> new file mode 100644
> index 000000000000..9eb4960bcaad
> --- /dev/null
> +++ b/drivers/net/phy/mediatek/mtk-fe-soc.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for MT7628 Embedded Switch internal Fast Ethernet PHYs
> + */
> +#include <linux/module.h>
> +#include <linux/phy.h>
> +
> +#define MTK_FPHY_ID_MT7628	0x03a29410
> +#define MTK_EXT_PAGE_ACCESS	0x1f
> +
> +static int mt7628_phy_read_page(struct phy_device *phydev)
> +{
> +	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
> +}
> +
> +static int mt7628_phy_write_page(struct phy_device *phydev, int page)
> +{
> +	return __phy_write(phydev, MTK_EXT_PAGE_ACCESS, page);
> +}
> +
> +static int mt7628_phy_config_init(struct phy_device *phydev)
> +{
> +	/*
> +	 * This undocumented bit is required for the PHYs to be able to
> +	 * establish 100mbps links.
> +	 */
> +	return phy_modify_paged(phydev, 0x8000, 30, BIT(13), BIT(13));

As there is only that single use I don't think it justifies introducing
a phy_set_bits_paged helper just for that, but that's my opinion...


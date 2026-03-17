Return-Path: <netdev+bounces-268700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C3jI6+ZuWn5KwIAu9opvQ
	(envelope-from <netdev+bounces-268700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:13:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7D22B0B4E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906223096B37
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768C5379975;
	Tue, 17 Mar 2026 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eE4QLkcg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D737E2F7
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770589; cv=none; b=YYAR7mcB+kOpOCxdRjSjpRPXlbZNk49t5HMpUGuzX2VXeIHpGnxkTd6HY8Rjcxa+kol3d+BSaeMiXJKAn061ITlXxPrKhMd60ibGdhNhG4+8fHQt5cQmiTtZ6Q3N4V2eG56zxW0nydXBcr00Kt142qOpwFxKx+I/whVQs0jv7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770589; c=relaxed/simple;
	bh=LKgnZhEKLLgJyTF4Ipy0Nbe9kPWmHx/xDtdnduO2vFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUdv9Tgoh8XYlhB77sjhNjaEb2TAJUTeDp94S9GuBGF3s2Goacz5bceu0UxOT4dOZdvrJvPcMaWl0aXyc9gTDW1m75tf+tEggQW4lqf4ZUFjlhL6YXwhNcyK5dHwXiDjsAEc7G13kZIuphtSESVwNFwGhUZcd6rJeawEldButBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eE4QLkcg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IA7MYu1j8NySO2NFe2taV88GPKGLWI/AjsCKClL4jWs=; b=eE4QLkcgb3M+A5Z3qKs8DOJxQ7
	RmRrM2IkUowpO0L/LlP+Dqs2qBnekMJEis5zVrf0CjYwNFzOLrm1XmmjWwqEw3ldKTq6Z5YEjvIvJ
	hLKzsWDWIjnxxzeF1afEVuygeht2+q76O+smBp2XeEhrG/wRfT66FKaHCXYEWBzEcgwA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w2Ykx-00C3xy-CK; Tue, 17 Mar 2026 19:03:03 +0100
Date: Tue, 17 Mar 2026 19:03:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com
Subject: Re: [RFC v2 1/3] net: phy: mediatek: add phy driver for MT7628
 built-in Fast Ethernet PHYs
Message-ID: <6e1ef5b2-b380-47d9-99ab-5fcbe4a68ccf@lunn.ch>
References: <20260314150845.653866-1-joey@tinyisr.com>
 <20260314150845.653866-2-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314150845.653866-2-joey@tinyisr.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-268700-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DF7D22B0B4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
> index bb7dc876271e..62355d46cb1e 100644
> --- a/drivers/net/phy/mediatek/Kconfig
> +++ b/drivers/net/phy/mediatek/Kconfig
> @@ -36,5 +36,11 @@ config MEDIATEK_GE_SOC_PHY
>  	  present in the SoCs efuse and will dynamically calibrate VCM
>  	  (common-mode voltage) during startup.
>  
> +config MEDIATEK_FE_SOC_PHY
> +	tristate "MediaTek MT7628 SoC Ethernet PHYs"
> +	select PHY_PACKAGE
> +	help
> +	  Support for MediaTek MT7628 built-in Fast Ethernet PHYs.
> +

This file is sorted by tristate string.

It might be best to change:

config MEDIATEK_GE_SOC_PHY
-        tristate "MediaTek SoC Ethernet PHYs"
+        tristate "MediaTek SoC Gigabit Ethernet PHYs"

And then you can add

> +config MEDIATEK_FE_SOC_PHY
> +	tristate "MediaTek SoC Fast Ethernet PHYs"

before?

Also, why do you have `select PHY_PACKAGE`?

>  obj-$(CONFIG_MEDIATEK_2P5GE_PHY)	+= mtk-2p5ge.o
>  obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
>  obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
> +obj-$(CONFIG_MEDIATEK_FE_SOC_PHY)	+= mtk-fe-soc.o
>  obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o

Please sort alphabetically. 

> +static struct phy_driver mtk_soc_fe_phy_driver[] = {
> +	{
> +		PHY_ID_MATCH_EXACT(MTK_FPHY_ID_MT7628),
> +		.name = "MediaTek MT7628 PHY",
> +		.config_init = mt7628_phy_config_init,
> +		.config_intr = genphy_no_config_intr,
> +		.handle_interrupt = genphy_handle_interrupt_no_ack,

How do interrupts work in this device? Has this been simply
cut/pasted, or have interrupts been tested using these functions?

	Andrew


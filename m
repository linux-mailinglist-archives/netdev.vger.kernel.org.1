Return-Path: <netdev+bounces-296094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CJkQAIP0I2oE0gEAu9opvQ
	(envelope-from <netdev+bounces-296094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 12:20:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9AF64D13B
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 12:20:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=mI3DoV5i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296094-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296094-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 172453009E1A
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E0538238A;
	Sat,  6 Jun 2026 10:20:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52D382365;
	Sat,  6 Jun 2026 10:20:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780741243; cv=none; b=FE1UnBIXAefUxTvWY9s8Wn1n99uS0vflyOcwAehfZz3tXu+PWo+f1TksllUjNF/Hhn4hgeHwCx2QNLlDLshoDEK1v/2j8TparH67vX80rGj1lT7XdNn6uvNZ7ANVn9M92zN3VumhXAGUcOFjnWdIGpvBrsr9QzIvzOBV7cInwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780741243; c=relaxed/simple;
	bh=7moLwkmuBSLzFdER631tQSJhT4GB3vvBNVyT0NB4sN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAZM8EYw032yoJ5XIC3YEMoMDro+qwN8PPVXoOI/hrvBTChAJs6ss75OjAxkdA1m5BWALymnEGFBVSihj14zz6vrKDaOEyioU3izDxSE8ZgdfAIZ0s3twcTdVlDSNEkjCybDqw1lUNMs53yWwKEhsHGLJ4umGZ5bdj5RxtBv7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mI3DoV5i; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E8EAw2qCyPWBjOmAUb2be8YSvnQQjaObHTetjy2Jv8w=; b=mI3DoV5ijlwSFTRWupkcgMhCy2
	AZAi4Dfo2yMBDrj2pGCeegIDQvkg+KgIVkzrzNFH06c4JmcHB9GjwgKRtD4R47W05bE+MQGQ6lX9b
	w2XVZ3RDfm8Qg+gwetI960YOXKO9KlqEh2UebLe/paXJuhzGjadpDZDJAtHZwrwaUMV0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVo8h-006MU2-GX; Sat, 06 Jun 2026 12:20:27 +0200
Date: Sat, 6 Jun 2026 12:20:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 4/6] r8169: add support for RTL8116af
Message-ID: <5005c1c3-d807-456d-a9a0-c77bde9f437e@lunn.ch>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-5-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605103906.1445-5-javen_xu@realsil.com.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296094-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB9AF64D13B

> +static bool rtl_is_8116af(struct rtl8169_private *tp)
> +{
> +	return tp->mac_version == RTL_GIGA_MAC_VER_52 &&
> +		(r8168_mac_ocp_read(tp, 0xdc00) & 0x0078) == 0x0030 &&
> +		(r8168_mac_ocp_read(tp, 0xd006) & 0x00ff) == 0x0000;

Do we know what these magic numbers mean?

>  static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  {
>  	switch (tp->mac_version) {
> @@ -2397,7 +2431,7 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
>  	int duplex = cmd->base.duplex;
>  	int speed = cmd->base.speed;
>  
> -	if (!tp->sfp_mode)
> +	if (tp->sfp_mode != RTL_SFP_8127_ATF)
>  		return phylink_ethtool_ksettings_set(tp->phylink, cmd);

Is this even needed? phylink should be able to handle sfp and copper
in the same way.

> @@ -2509,9 +2543,10 @@ void r8169_apply_firmware(struct rtl8169_private *tp)
>  		tp->ocp_base = OCP_STD_PHY_BASE;
>  
>  		/* PHY soft reset may still be in progress */
> -		phy_read_poll_timeout(tp->phydev, MII_BMCR, val,
> -				      !(val & BMCR_RESET),
> -				      50000, 600000, true);
> +		if (tp->phydev)
> +			phy_read_poll_timeout(tp->phydev, MII_BMCR, val,
> +					      !(val & BMCR_RESET),
> +					      50000, 600000, true);

Maybe this all needs to move into the PHY driver?

> -	rg_saw_cnt = phy_read_paged(tp->phydev, 0x0c42, 0x13) & 0x3fff;
> -	if (rg_saw_cnt > 0) {
> -		u16 sw_cnt_1ms_ini;
> +	if (tp->phydev) {
> +		rg_saw_cnt = phy_read_paged(tp->phydev, 0x0c42, 0x13) & 0x3fff;
> +		if (rg_saw_cnt > 0) {
> +			u16 sw_cnt_1ms_ini;
>  
> -		sw_cnt_1ms_ini = (16000000 / rg_saw_cnt) & 0x0fff;
> -		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
> +			sw_cnt_1ms_ini = (16000000 / rg_saw_cnt) & 0x0fff;
> +			r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
> +		}

Can this move into the PHY driver?

> @@ -5017,9 +5054,11 @@ static void rtl8169_up(struct rtl8169_private *tp)
>  		rtl8168_driver_start(tp);
>  
>  	pci_set_master(tp->pci_dev);
> -	phy_init_hw(tp->phydev);
> -	phy_resume(tp->phydev);
> -	rtl8169_init_phy(tp);
> +	if (tp->phydev) {
> +		phy_init_hw(tp->phydev);
> +		phy_resume(tp->phydev);
> +		rtl8169_init_phy(tp);
> +	}

Why is this needed?

	Andrew


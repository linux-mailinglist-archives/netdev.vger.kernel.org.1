Return-Path: <netdev+bounces-304665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +dVpB54dSGr8mQAAu9opvQ
	(envelope-from <netdev+bounces-304665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 22:37:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 123D4705897
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 22:37:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=kDtPeHY8;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304665-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304665-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29C07300BD65
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0047E352C28;
	Fri,  3 Jul 2026 20:37:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2F348C4B;
	Fri,  3 Jul 2026 20:37:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111064; cv=none; b=jfeWUybPNCxxswrgQysLrBSZXgeiuHI5ybrutj1QCCOvzKkRDoVWH1wVUznju+pxagdwUgwdui8EzB95NxzzIag3H+djV2TERyGhdJ3DSgaCQxLIrMEEtkEX7pBZn/UVibDaWj8/Z9uMN0Pb8XsUkB8g6LZ+qqby+ovvw+SyzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111064; c=relaxed/simple;
	bh=Gu/0HMyu/VRKn+7s9pXyNtz7xFiVrICskxvLGDADA4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huKVvWxZT9tiHpYiWGB9bz9bvfKxfOE7HOB4rdMBpB4du9SSFN2cKXOkl0lrmHTAVkSfZQaolfW9PbNXOIZ2yNsvI9juJ45pX5Nif2PaPWhUAQbM4jUY2VJ7N4j6vjcRJl6oD6G4u82WGzuYWrVmrsm171n7h1ilcEoPOekzSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kDtPeHY8; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XRM9uENndVb9k8FDKtQxbN4i2xsVS7kwtcnJa3qVais=; b=kDtPeHY8J/uTFtszkVtL01Knah
	g5VSNO5X+1KNoDB+WgXIRri+0noH6dBNaO+UXcQ+LY4UiZqPSa7mRQxy9TjWdPs5NQ7lIQztkNzGO
	10UnuIxvz0IQk/fF517RGoXOBv3blU1xF2tgn11z1fA5mS7v/voSubZhS71Mj+4oU7sc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfkde-00AbYr-9b; Fri, 03 Jul 2026 22:37:30 +0200
Date: Fri, 3 Jul 2026 22:37:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/6] r8169: add support for phylink
Message-ID: <e9cadf1a-94f3-45e8-9b59-22082ee5c2da@lunn.ch>
References: <20260703092459.1124-1-javen_xu@realsil.com.cn>
 <20260703092459.1124-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703092459.1124-3-javen_xu@realsil.com.cn>
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
	TAGGED_FROM(0.00)[bounces-304665-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 123D4705897

> +	if (jumbo) {
> +		if (!tp->jumbo_pause_saved) {
> +			struct ethtool_link_ksettings cmd = {};
> +			bool adv_pause, adv_asym;
> +
> +			phylink_ethtool_get_pauseparam(tp->phylink, &tp->saved_pause);
> +			if (tp->saved_pause.autoneg) {
> +				phylink_ethtool_ksettings_get(tp->phylink, &cmd);
> +				adv_pause = ethtool_link_ksettings_test_link_mode(&cmd,
> +										  advertising,
> +										  Pause);
> +				adv_asym  = ethtool_link_ksettings_test_link_mode(&cmd,
> +										  advertising,
> +										  Asym_Pause);
> +				if (adv_pause && !adv_asym) {
> +					tp->saved_pause.rx_pause = 1;
> +					tp->saved_pause.tx_pause = 1;

This does not look correct. Pause is negotiated. In order to determine
how to program the MAC you need to look at what the local side is
advertising, and what the link peer is advertising. I don't see
anything here about lp_.

I forget what the issues is. Is it something like, if you are using a
normal MTU, pause is supported? But with jumbo MTU it is not?

For this to work correctly, i would expect a change of MTU to trigger
a new autoneg, with the local advertisement changed. That might
require changes in phylink, since it does not expect this sort of
thing.

> @@ -5288,6 +5326,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
>  		r8169_remove_leds(tp->leds);
>  
>  	unregister_netdev(tp->dev);
> +	if (tp->phylink)
> +		phylink_destroy(tp->phylink);


I've not looked in detail, but is tp->phylink optional? I would expect
the probe to fail if it could not create it.

> +static int rtl_mac_enable_tx_lpi(struct phylink_config *config, u32 timer, bool tx_clk_stop)
> +{
> +	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
> +
> +	if (!rtl_supports_eee(tp))
> +		return -EOPNOTSUPP;

Can that happen? You should only be telling phylink EEE is supported
if EEE is actually supported.

> +static int rtl_init_phylink(struct rtl8169_private *tp)
> +{
> +	struct phylink *pl;
> +	phy_interface_t phy_mode;
> +
> +	tp->phylink_config.dev = &tp->dev->dev;
> +	tp->phylink_config.type = PHYLINK_NETDEV;
> +	tp->phylink_config.mac_managed_pm = true;
> +	tp->phylink_config.lpi_capabilities = rtl8169_get_lpi_caps(tp);
> +	tp->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
> +
> +	if (tp->sfp_mode) {
> +		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
> +		tp->phylink_config.mac_capabilities |= MAC_10000FD;

Only 10G? Is it not possible to slow down to 1G for a 1G SFP?

	Andrew


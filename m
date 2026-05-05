Return-Path: <netdev+bounces-284263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPqJHo6s+Wky+wIAu9opvQ
	(envelope-from <netdev+bounces-284263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:38:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C681A4C8C2F
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E897E30330A8
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995D2F9D89;
	Tue,  5 May 2026 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ecDVrcwI"
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DE30C37A;
	Tue,  5 May 2026 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970166; cv=none; b=ecKwQeLQGPvxT/lgPhvfhgu1+9axjyCTNg4TFU30jVyxVIkwjwgdcaoYO7U6X+wnmiNfMu5ozFJAqNwDA4MBGnpBvxLdGig7Ra3XUVViQQWKNB68NuKrWJSg169D1aDSIdHTvZvr3DgX7PZBkG5/7ubIcF7kPOMsxKA4BH1T2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970166; c=relaxed/simple;
	bh=CWaeVcm00SPOZ3SYrZTELMqqVT5hEgks1+ooT6SplRw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fOEKQFY8bjiFZ+dmRjgLTdSHznhl/d5sy0k4Vrk3zkRYzNtKGL0dy/ltOavSL0vOpw4ficIT5KjyW4pEIk/nFZA0iAmOUERne2OpyHwaDKZTwOZ1LDdnaf498Le90TQweTcYeBCYvMJqcg2NAu5zEa5KB0vl0ESokxZQGDb9GnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ecDVrcwI; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4g8s6l03Xlz84gm;
	Tue,  5 May 2026 10:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1777969583;
	bh=CWaeVcm00SPOZ3SYrZTELMqqVT5hEgks1+ooT6SplRw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ecDVrcwI/NsVgH94jp9G5ZpdTyRQiWodi0k6kneErLedsBZNU+DO9EcpFdG28vLcv
	 nOBZGqgQUlGzN60MI71ZvhNBgMt0Hkvl6W3FDQ/MNcReC7kNbbdC1bvD6wz9GVxygk
	 TAouICfeOWo9Zakgms8+eQ2as9PMOtccOKyTCNURbGQzdznwE3J/z5Us2AOfjQcJar
	 Nbdq0R8qCuSLwA6oFxMjr2nZyPDX38+iOLt9cr2X38FqaSCBDmpywfwaari3VpCufs
	 h98iihPlb6Uwg3MscQqJcxlxEnGdEdoLaCyaHUILl2fDjhCI106xQk4DHHJerPVdb5
	 1mK8XN8PIiU3g==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4g8s6k6SX0z4xBP;
	Tue,  5 May 2026 10:26:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4g8s6j2GKxz8tcZ;
	Tue,  5 May 2026 10:26:21 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 0D705632E7;
	Tue,  5 May 2026 10:26:20 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <198e2ce4-07e1-46c0-818d-1eb18645aca0@leemhuis.info>
Date: Tue, 5 May 2026 10:26:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [REGRESSION] stmmac: Random DMA reset failure on RK3399 since
 v6.18
To: Jensen Huang <jensenhuang@friendlyarm.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 regressions@lists.linux.dev, netdev@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: 
 <CAMpZ1qEwNOqR-KQD4kEqd93aB-TpHnG6WdQc2tXUF0aXMmw_SA@mail.gmail.com>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAMpZ1qEwNOqR-KQD4kEqd93aB-TpHnG6WdQc2tXUF0aXMmw_SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177796958042.440629.6346085614767550390@mxe9fb.netcup.net>
X-NC-CID: X0X9YM9AO5JfeE2JIDWZSK0of2cFrXJQgrXnbgYhGbZq4CaBI28=
X-Rspamd-Queue-Id: C681A4C8C2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284263-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leemhuis.info:dkim,leemhuis.info:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[leemhuis.info];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

[Jumping in here, as there are no replies yet]

BTW, Russel, just in case you missed this: looks like this regressions
caused by a change of yours.

On 4/29/26 14:53, Jensen Huang wrote:
> 
> I'm reporting a regression on RK3399 (stmmac) observed in v6.18.24.
> When a network cable is connected during boot, the DMA reset
> occasionally fails with the error message: "Failed to reset the dma".
> 
> This appears to be a timing issue related to the EEE RX clock-stop
> logic. Based on my investigation with the RTL8211E PHY, I monitored
> the PHY register PS1R (MMD device 3, address 0x01) and observed a
> value of 0x0f40. This indicates that the PHY is in LPI mode and the RX
> clock may have already stopped.
> 
> While commit dd557266cf5f ("net: stmmac: block PHY RXC clock-stop")

Just wondering: have you tried if mainline (e.g. 7.1-rc1) is still
affected? This is something that is always a good advisable (some people
would call it required). In this case even more, as it since a while
contains a fix for the change you mentioned, that wasn't backported:
c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop when VLAN is
enabled"). But this is not my area of expertise (and in different area
of the code), so that fix might be unrelated to your issue.

Ciao, Thorsten

> ensures the clock is running before the DMA reset, my tests suggest
> that the phylink_rx_clk_stop_block() call might not provide a
> sufficiently stable RX clock in time for the immediate DMA reset that
> follows.
> 
> Since stmmac already sets mac_requires_rxc = true, I modified
> phylink_bringup_phy() to honor this flag. This avoids toggling the
> PHY's clk_stop_enable during the initialization sequence, ensuring the
> RX clock remains active and stable throughout.
> With the change below, I achieved 200/200 successful reboots with the
> cable connected (previously ~50% failure rate).
> 
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -2171,7 +2171,7 @@ static int phylink_bringup_phy(struct phylink
> *pl, struct phy_device *phy,
>      /* Allow the MAC to stop its clock if the PHY has the capability */
>      pl->mac_tx_clk_stop = phy_eee_tx_clock_stop_capable(phy) > 0;
> 
> -    if (pl->mac_supports_eee_ops) {
> +    if (pl->mac_supports_eee_ops && !pl->config->mac_requires_rxc) {
>          /* Explicitly configure whether the PHY is allowed to stop it's
>           * receive clock.
>           */
> 
> Any feedback/testing on this would be appreciated.
> 
> Best regards,
> Jensen Huang
> 



Return-Path: <netdev+bounces-278199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIIrA1hZ3WnYcwkAu9opvQ
	(envelope-from <netdev+bounces-278199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:00:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F23F3542
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76B95303A90C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF3738551A;
	Mon, 13 Apr 2026 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vLWsNw4y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1231D371
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113616; cv=none; b=FKCeXI6mfEqQ3tde4ZnEWxHTyKl/1iMyfVxAPkS4otv6vsF5K7ccWSn2vw0g1VS97Uio0ySCptfjaBX0wyLlS8stUN/WBGQzHNmvfKZwucuE8/qglDLhdAATjGR1b4C8mvn4R9Ywt5eoCmOJwakkmGRAgh97Is0P2uIiE3C9tuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113616; c=relaxed/simple;
	bh=mrnp5U+qkgS6IeTytFeIArR9p9jIXNB8qozKiNEM8ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+xmFfMcNeXdJxMeFk0Z2pVLG09OpGw9s9hgm4TDMwQU0szHchlQIXmgByAq8abcRAwzvfe+4iiC3eGee2E7nol3HfRVSF7/am/+p4C1MlV+oR+gOkkoAGtPB/WrIZjF66m3AydkVEa4WxlFUVC0KA2HHtXlA0ZEHfPEhmT2rI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vLWsNw4y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=febWsFLvFO+nAC4i5QRuslLmXizl8UntFXY3PRXCccU=; b=vLWsNw4yrSnVL1MyPNtoLBeJFR
	dNR1laIW1YaEn2WBnyNmf050CEl866x6FEXs64r4omokFKkPqFSLhS9XApeQqB+CXZSCs4QMbVOyv
	6YDi5enkOTlVv4lXcbKJlJv3DaVER7PRFLmXYwm/LDi/APsSJESZPwiwNEHo45HKMVwqjFuFTaoWw
	oN6ujWepqt3v+uu+iWXv9BdWI6SdCqdnRx8oSll0jQC9XYbjIY8QQLnik+1jh0+PLJdzQWCHafwV/
	x6YRZ1oiQiNIx9YPyrQ5k8bCpUvzgnE15mXP/mGL5+WvmrvMJxGzXGlCIkuLpylrIFB0XlDVyXoT4
	kJmu9mFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47442)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wCOHe-000000000Hi-3rdM;
	Mon, 13 Apr 2026 21:53:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wCOHc-000000000XQ-0jdz;
	Mon, 13 Apr 2026 21:53:24 +0100
Date: Mon, 13 Apr 2026 21:53:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sam Edwards <cfsworks@gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Message-ID: <ad1XwxZ5WxbG1IL0@shell.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <20260413110222.49fc3759@kernel.org>
 <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
 <20260413135018.59fbd3a1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413135018.59fbd3a1@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,foss.st.com,davemloft.net,google.com,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-278199-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.057];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 5F1F23F3542
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 01:50:18PM -0700, Jakub Kicinski wrote:
> On Mon, 13 Apr 2026 19:49:46 +0100 Russell King (Oracle) wrote:
> > > Firing interrupts when Rx fill ring runs dry (which IIUC this patches
> > > dies?) is not a good idea.  
> > 
> > Well, I'm thinking that at least on some platforms, such as the Jetson
> > Xavier NX, unless a different solution can be found, we need the RBU
> > interrupt to fire off a reset of the stmmac IP when this happens to
> > reduce the PAUSE frame flood on the network.
> > 
> > If we can't do that, then I think stmmac on these platforms needs to be
> > marked with CONFIG_BROKEN because right now there doesn't seem to be any
> > other viable solution.
> > 
> > My intention with this patch is merely to start collecting the already
> > existing statistics so other users can start seeing whether they are
> > hitting the same or similar problem. If we're not prepared to do that,
> > then we should delete the useless statistics from ethtool -S, but I
> > suspect they're now part of the UAPI, even though without this patch
> > they will remain stedfastly stuck at zero.
> 
> Understood, thanks for the extra context. And the statistic we are
> talking about is rx_buf_unav_irq ?

Yes, correct.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


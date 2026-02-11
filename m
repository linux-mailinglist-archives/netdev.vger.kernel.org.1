Return-Path: <netdev+bounces-258279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB98ECB8jGkcpgAAu9opvQ
	(envelope-from <netdev+bounces-258279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:54:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4E312491B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0825B3011BE7
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65210357707;
	Wed, 11 Feb 2026 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ORW8Igia"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D2315D5B
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814450; cv=none; b=huYzUlBWLfvVCzr0qXHUzbitIvBfZ+T0ddpETWcmrSxOSYISqQCDF9WI/BTgcg+l4yqKc3cWSYc//vGEPc0siVoyTBRXdx69phNlmLg6dtD9iwxm2Ec43gYe5eZcOOLUgf3PQvIiYx/CV0bNQNmQKHjJZ38P0MV/12yYanX6uLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814450; c=relaxed/simple;
	bh=71alNqPQhjkDxyzZP2X+P+wm37/l9hxA7WGUZeFgi1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI0sSGqaiYkCWExWwqUz9JFxSEJcE8HEUwmz4PHLxalJBWPpPTL7kSJv8iY4FpON8xuC35ouhsVQCBNzgc54byVlgM2gzbeWf1xnFbr4Pq8BlyoYQgC1xSOznhLH6cS8H2IZ0wIbxCBrTmnLRr/zTG8tsRnLJ9cyZhUUlo27izk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ORW8Igia; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U/Neu0hfsRUexXQo24Z6HShCyIt/OEPA5N5gMOQo0YA=; b=ORW8IgiayHO4HEXJA0qBnHnOZC
	H1uTsTLK2U03+XH/wmxxTPF7soTPcmBREWW3gcYx8XO6gzS0l+GE/cSYHMchXPFytVtouF07Ht8A0
	EoAup+kG8IPNoAAPjkWejjVqD5O9fSVau2kmDHCGiBfcI4HI6H7Yaeky+6GGC0x5Hz06XQpcUq3UQ
	ydRQFPSzfx8TCBopbDrB/L+ysEJD/9X9ZqH2V/2vFcMvgv/iNBHKCRHxRPd8a8mDIXLw5gJZZW9iT
	qg0lM1yLAny43dx3WCBrwzvuXA3FwccwSrRPCqbjM0rxTceQ2afmHfNf17T8RT8/yXAQF08bqhIOA
	hVNuKRbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52936)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vq9jA-000000003QW-2HU1;
	Wed, 11 Feb 2026 12:53:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vq9j6-000000003ma-0e94;
	Wed, 11 Feb 2026 12:53:52 +0000
Date: Wed, 11 Feb 2026 12:53:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: netdev@vger.kernel.org, imx@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@denx.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Heiko Schocher <hs@denx.de>,
	Jakub Kicinski <kuba@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Martyn Welch <martyn.welch@collabora.com>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Richard Hu <richard.hu@technexion.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Wei Fang <wei.fang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] net: stmmac: imx: Disable EEE
Message-ID: <aYx73z0VTAGFAjlp@shell.armlinux.org.uk>
References: <20260209202155.2388099-1-laurent.pinchart@ideasonboard.com>
 <aYsj5IayQd3NRflL@shell.armlinux.org.uk>
 <20260210143157.GM2405149@killaraus.ideasonboard.com>
 <20260210163310.GO2405149@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210163310.GO2405149@killaraus.ideasonboard.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258279-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lunn.ch,nxp.com,davemloft.net,google.com,denx.de,gmail.com,toradex.com,kernel.org,ideasonboard.com,pengutronix.de,collabora.com,gnu.org,redhat.com,technexion.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 9D4E312491B
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 06:33:10PM +0200, Laurent Pinchart wrote:
> > I'm happy to submit a series with both, rebased on top of net-next to
> > handle the conflict you pointed out. Is that fine with you ?
> 
> If you would like me to submit a series with both patches, should I
> resolve the conflict with "net: stmmac: dwmac-imx: keep preamble before
> sfd on i.MX8MP" by inserting the STMMAC_FLAG_EEE_DISABLE flag as BIT(10)
> and change the value of subsequent flags as you did, or add it at the
> end (BIT(15)) ?

I would prefer to keep similar flags together rather than just appending
to the end of the list.

> I'm also happy if you take my patch and submit a series with both.

I think it would make sense if you submit it once net-next reopens after
the merge window.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


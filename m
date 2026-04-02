Return-Path: <netdev+bounces-274590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H4wMsOCzmmDoAYAu9opvQ
	(envelope-from <netdev+bounces-274590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:52:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E00338AD88
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DC423021E51
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452DE3E9F80;
	Thu,  2 Apr 2026 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rMHvxoWl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA263E2748;
	Thu,  2 Apr 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141331; cv=none; b=LZF8yBW4Ver0w59RVxXkJQzV/nD79XeRSTREAc2qwrer6fuPPL1AqhFSogEdqtdg9wMlVUO1iQa+kMF6Kw37pQzhiZlKaFft9vqUweE+d0h8R/oalKZ/V4gmepslFo19hpyTxf5L3BMi7+B2xpZKEvW5LsPzZGHsyZEGncZ2utA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141331; c=relaxed/simple;
	bh=nOiyZw3jMhVlyVBU+cyVLWGJ8zLo2fpAiGkzLoLiOrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzkTFg3Z1kw921XvoxtAUC+vp3c5zj6dyV9w2p13C2eZ2uNwC26nu+rJ2fpT5fpgYHms3yK5KIyNmXutNHgeqHH6PW/4LTPaqwhOBLlIITjH0Vi0vAExb6fB0ddBWp5nD8C1rkmwwz1EwY5TZzLDpZ2o0zKz9n/vEyuKiWITBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rMHvxoWl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N1SNxA2IdJIAQvNBrAHaZTbGLncC78QjdN2K/PuVhRE=; b=rMHvxoWlM+uejA3NiqMqiuF1t6
	dH1qT0uo1/cR6Dz9GPprsbtC9TfoS+6pl44lH3+gwrFr1/R1W2cORlZDXXbtz2pGCCcC2SX1g+muo
	mqRxTLJh7jAhYkPalAFwnSSmU5YXQUVFWVGF+SZHnES4qjy+ayFAVAE+r9IhvAaZurgdtQcbuysLM
	JrTqZEWFo2xdkFLupjvO8x0ot3AVrRgNO00IucaBzti7qDbtE566rSVyHqQz1vaslsBYM9bcKRpOV
	4kGCME+4w91t5U2NFARLx647e+ftRl4A5WlKLg9u2uuJbTHut0ojQCjo3qQo+WjpziwtAGJzEAb6r
	GbuYxOVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57336)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w8JLh-000000004bC-1f0M;
	Thu, 02 Apr 2026 15:48:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w8JLf-000000005qE-3QcM;
	Thu, 02 Apr 2026 15:48:43 +0100
Date: Thu, 2 Apr 2026 15:48:43 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Julian Braha <julianbraha@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, manabian@gmail.com,
	davem@davemloft.net, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stmmac: cleanup dead dependencies on STMMAC_PLATFORM and
 STMMAC_ETH in Kconfig
Message-ID: <ac6By0rLzTm7R5HC@shell.armlinux.org.uk>
References: <20260331125817.117091-1-julianbraha@gmail.com>
 <20260401185814.45dfc444@kernel.org>
 <cec5001d-7ac7-4b21-a3d6-6052e1d8fc87@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec5001d-7ac7-4b21-a3d6-6052e1d8fc87@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,st.com,foss.st.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274590-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.937];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 2E00338AD88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 03:47:24PM +0100, Julian Braha wrote:
> Whoops! You're right, good catch. Looks like I've been staring at too
> many 'depends on' lately...
> 
> I'll send out a v2 - thanks for reviewing Jakub!

Feel free to keep my r-b.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


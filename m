Return-Path: <netdev+bounces-275656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKTFNBXp02n/ngcAu9opvQ
	(envelope-from <netdev+bounces-275656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:10:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 357733A5967
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B6B930180AF
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA6738F936;
	Mon,  6 Apr 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a7byPEq4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D4A390208;
	Mon,  6 Apr 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495431; cv=none; b=VIOcB1VXauJbY8ujNiRqYHV9pEPEhsPf0rQOEKppBIaYTlUgHVvvRS4sPAUzqgL9F3TFK/CMcZlTPby4uZhZ54DQuICL5rVes87D49tfMtu9G9A/SEqsJ7ERMU64+JwNmXz+FtFcb1QTDLUzx8aWrqrXcjNR03Pu3R1gbccyHBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495431; c=relaxed/simple;
	bh=3UsoyWHJ3l8dOHlC/7y1+W7wDzvVarAuqx2aN4bB41s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9+slXUDyX1OhYfqZaBkMAGIaV2kiSUu1gx8U1atJuXR5zYjTK0Ew/aT+R5oek4Z+OHXMTgmQZDE/Gpi31C/GXFS4ADPk9upzU5f5HhH0bu+IcWOol2SdoZS2OztEXF+GuT5ZTAfo2Lo1D5gH1Kxonjc37gGK/0M9kLOAN5c6ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a7byPEq4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jk4XmXFhA0LiPh1kFrp9UbsWbmp8+y5XTKBKpbs56n8=; b=a7byPEq4/Tlq4ytrzg6vMwewrS
	YqoKtZmbbti8/gA7P3dqwnMVDQvOQZ+aHBe76Nk76r/JEBAw+yWQf0t/S9iks/7W/FJbL8LpJyC4i
	73coDfWdWgro/FiSE6Q5u9uftrwdyLUwYTcsI/G8vdMMH/uyVzMiU333HQrgHrF2meUXmWKA+deq5
	wXeEGMhFCBE+MXgH6CUeyqLDT7vwZuVADw/tlsr4XgBMq/oYuaH6qQ1imX/pzdWSjQOfkzIPBf7QB
	4g9c3xRZ+kaeBiUCuJFGkM0Bq3F7hesLgMKIAgZ3wZs3iCPWYM8aQuv4DSUdwNYOA85hSFwvSbG+b
	ZlExhGLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44910)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w9nSu-000000008LI-3Z9N;
	Mon, 06 Apr 2026 18:10:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w9nSs-000000001Sf-2gmD;
	Mon, 06 Apr 2026 18:10:18 +0100
Date: Mon, 6 Apr 2026 18:10:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Nicolai Buchwitz <nb@tipi-net.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: phy: add support for disabling
 autonomous EEE
Message-ID: <adPo-o9DtxIZGDvg@shell.armlinux.org.uk>
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
 <a1cf8f6a-b338-4dd7-aced-7e19e4d0fdb7@lunn.ch>
 <9272c5dd653039b3def8caaea3e631c5@tipi-net.de>
 <5298959c-12de-4992-a896-3d1371cba111@lunn.ch>
 <cdef227e-9dfe-4860-aca3-5ce1f60cb838@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdef227e-9dfe-4860-aca3-5ce1f60cb838@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-275656-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,tipi-net.de,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.816];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 357733A5967
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 09:43:55AM -0700, Florian Fainelli wrote:
> That is almost a guarantee given, there will be a broken MAC

Well, it already exists. modern i.MX platforms use stmmac, and some
bright spark wired lpi_intr_o together with the main stmmac interrupt
which causes interrupt storms when the receive path exits LPI. This
makes stmmac LPI unusable on this platform.

So, if i.MX is paired with a PHY that can do its own EEE, then we
have this exact scenaro.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


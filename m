Return-Path: <netdev+bounces-168416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07988A3EEE8
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAC31896356
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C5E201028;
	Fri, 21 Feb 2025 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="y+BqoiQN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB061B0406;
	Fri, 21 Feb 2025 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127431; cv=none; b=fNNgRLWWPjR1NiFjy9oZp96ZFPrIN5AyVhtViSEtduoi6pTexUG+bMhZ5Yjmg/qIEbAjzLIVuayaOUxOFWqOHXL1JIUGWzRnuiaRf/JJVDPibOq4q6gdxhfjwgMCILZ2aAUMqvXiiX1JDJuyOr1yuudD0XMacnt+2xs+MXuCsRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127431; c=relaxed/simple;
	bh=0M+WT7F9uCqc+pyI4vg/MufuhXOb4oKidEj0ba8e3Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw0rwl0Imw5i/r7h2nrqAx6AUsSw8PHStMcVy8OkpCPprBJXCPFNGwLTf60Y2JYcs2u/MddZNIVDNtmPDkIu0ma4m3SvrLaTUPGleky3Es6Wr8l6sDLZ4UV1BioV3rVjRjNJ3zFXua2Zl/UYs6/CvmEx6CpQrj5yitb82U23oLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=y+BqoiQN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SO6UWzoc/zbS6DMMh8zzJ8wnANdSqb4FNiwFHAzJYB8=; b=y+BqoiQNhSi013U7h+X21U0GZk
	kUhZl7J4G5qbsRwinzXjc8UmLPKJvmXz387NFenlUJSgk2twL8r+lD7ye07FSRiOo/9Ks343KnlHh
	y05yeZDoICigBBma5dE0KEUOPe4XmRJ78fCCphqhNVYU/n2Kar9eBksJk5mzhfBy//GKBfhc3h+Yb
	KDfNeXqI4BiEcOQBhkiSuPxIKzWaGbcjKPYWFqBmNItTTSE3DYN9L1oHV7o+6Gh27QSe96K9Ciham
	vy2kEO1MBaFieDtSaADCzuc8wL4Ojzl3DDT0+mIXkNrp/4aKCtbTZwYt01rmpUP4wU6dskUdOmpjD
	VkAJekJg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46216)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tlOdM-0003tZ-0l;
	Fri, 21 Feb 2025 08:43:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tlOdK-0001s5-2k;
	Fri, 21 Feb 2025 08:43:42 +0000
Date: Fri, 21 Feb 2025 08:43:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fix DWMAC S32 entry
Message-ID: <Z7g8vk-MrDQ271Dz@shell.armlinux.org.uk>
References: <E1tkJow-004Nfn-Cs@rmk-PC.armlinux.org.uk>
 <20250220152248.3c05878a@kernel.org>
 <Z7fHNEFo7Aa4jfUO@shell.armlinux.org.uk>
 <20250220164819.044b509f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220164819.044b509f@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 20, 2025 at 04:48:19PM -0800, Jakub Kicinski wrote:
> On Fri, 21 Feb 2025 00:22:12 +0000 Russell King (Oracle) wrote:
> > Right now, the situation is:
> > 
> > $ grep s32@nxp.com MAINTAINERS
> > R:      NXP S32 Linux Team <s32@nxp.com>
> > L:      NXP S32 Linux Team <s32@nxp.com>
> > R:      NXP S32 Linux Team <s32@nxp.com>
> > L:      s32@nxp.com
> > 
> > and the approach that has been taken in the past is:
> > 
> > -L:     NXP S32 Linux Team <s32@nxp.com>
> > +R:     NXP S32 Linux Team <s32@nxp.com>
> > 
> > in commit bb2de9b04942 ("MAINTAINERS: fix list entries with display names")
> > 
> > However, commit 98dcb872779f ("ARM: s32c: update MAINTAINERS entry") did
> > the reverse for the "ARM/NXP S32G ARCHITECTURE" entry breaking that and
> > adding a new instance of this breakage elsewhere.
> > 
> > It seems these are just going to flip back and forth, so I don't think
> > I can be bothered to try to fix it, and will modify my own scripts to
> > eliminate the blank entry in get_maintainers output because of this.
> > (In other words, s32@nxp.com will *not* be Cc'd for any patches I send.)
> 
> Literally would have taken you less time to fix it how I asked than
> type this email :/

My point is that "fixing" it will only get unfixed later - as can be
seen from the history of the s32 entries already present. They flip-flop
between R: and L: as people's ideas about what is correct change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


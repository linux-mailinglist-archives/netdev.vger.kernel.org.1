Return-Path: <netdev+bounces-237553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D74FC4CFF8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA29189B120
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B434B1BB;
	Tue, 11 Nov 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="f+QfO1KV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676B34B18E;
	Tue, 11 Nov 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856674; cv=none; b=OKCl80Xch+DG6NzjMjAGaA/Dbm8wrSlLNOoB+/RIvWIY7pnsvzuDGtf2tQf2isDx4L0vbEniuNcrq69v9K0YWKdISmPllhL7XEtAfNlvC7pnLD/QLTADv5NTdHMhNMWVCW+aMUfa+7eDiMW+0ZZODB4EbZf5s8AYyTJrgmqCQF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856674; c=relaxed/simple;
	bh=5lvERQUwkAFewg5j1w8Mq5Uf65UbJV0Y5Nb+rikpsAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaelMD31tfMpwpKOZ+OaxQHZffErZase+g4w16DSGZQEJt+8UaDWeMHWdQKnTwUN4IV0s5j2rZynMCmnOq7iXKTB7f2cHSgx6hQn/B8afsoTysWhlzBscwvMRSklPExqLDtb9MXJSUqPbWYWYpGTf27VlRH1wXd1T2PEUztNAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=f+QfO1KV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sSWsTV2MWHdFpbg92RaIo64oTNlss8KmTcHhZBdwoqg=; b=f+QfO1KVsbwwBD6lq33HpFeyGN
	g43lbRrOrHI2F5OGueNwqDdvoOYCBCZKVo9FSZ6Me6FOxR9I7qbgATkceumO+aTbNrGouB1GJC/VU
	Hd/41Xc0vP29sfUz0xBwe/h+7Cx/o/Dtds4OeylTazIx3vdZUOLmpTyrNK4t2jVpVa4/eJ3uKomFa
	gKNqIhOWNsTTan6zIU+mUZnvxB3yBtVcxAKOh/f7G5advnGNMOzmPuFAipT7M2H/bnOAQJhPnJcqF
	s5MpVD9jrVjiS60p8+uNgGwTmxc9MaA40qaAz5JlXfOBSLyAZBmQeUAh9oPX5w4oQ5BYMHLOqwocd
	eKeoK3yw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46638)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vIlXt-000000002OB-3VAV;
	Tue, 11 Nov 2025 10:24:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vIlXs-000000002ru-1bdW;
	Tue, 11 Nov 2025 10:24:16 +0000
Date: Tue, 11 Nov 2025 10:24:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: stmmac: pci: Use generic PCI
 suspend/resume routines
Message-ID: <aRMO0E66MOGy-reS@shell.armlinux.org.uk>
References: <20251111100727.15560-2-ziyao@disroot.org>
 <20251111101158.15630-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111101158.15630-1-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 11, 2025 at 10:11:58AM +0000, Yao Zi wrote:
> Convert STMMAC PCI glue driver to use the generic platform
> suspend/resume routines for PCI controllers, instead of implementing its
> own one.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


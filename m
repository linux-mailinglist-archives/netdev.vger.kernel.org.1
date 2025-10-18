Return-Path: <netdev+bounces-230699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4ADBEDBD2
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 22:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482E7189B3FE
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 20:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A3B25C6F1;
	Sat, 18 Oct 2025 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S8RVQB9g"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005F9354AD4;
	Sat, 18 Oct 2025 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760820629; cv=none; b=gRl0+lhNiMQO9ZuU8758a030e2bVB1faaG3+HWXXUIN237/tJxO0N4CRDxsUJzYI6PxL1V8aguLlSJvzoER1sLBSSizMTj1be94hEw1s17YQNFmXm0GW4MkqBqUG8ATBVd3GjsRONZsH7/dSgql9cafgQOQWeHdGHu/kPRLlL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760820629; c=relaxed/simple;
	bh=C20+hjWvZwhIHkR+40TDuko+jAUIyKW54m5q3JcgMqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvOZV0RyJOlqQMw6Rm0bD03v19MYNJ5WM28p6MGDxCb1jyjYlOrMdn6XrTW39T5d/Xi4FGz7Qf7O9yb6cCUzk3rgopxqCRLK8GJkRK6sja3J98K654Lv0Ws6keivRNvgS1BXgSCXk5rsWYgtjHFor+YRVX2UmwRX9HZqXGHVdYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S8RVQB9g; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HZVFyQFH/N6BlbXZw7Nya2jm1NlFu/aT9k9hJeAWYd0=; b=S8RVQB9gc5V85YTnJ25mLHH2Vs
	jYcPLDoDMEB7wJ3GereehfiJA/tHV9Qc71uSKDF4TlPs8FyhXlcyaUoJeUPZvlz6Y5JdQoX+Zhr+r
	RVmVRq0wk05pUUXtc+J/P39mOXEN0XPmRT7ibqUkCTOk9rcM3BewqOYeBBrylj6u7A9uoowpHa5o3
	Azqt2pju1pTzqbWHNYythB3qFjEh+M+rzQSEuX++nmhDN1RnCdfXLybWNYJSJuJow+KFvo+9qSYcY
	kUew1Zpz4oNZttZXiC3p1WzmZjUcNMjGH72MEDReMLkZnFqKZTiKDlJUd8ZcMACGg5XA+as8/OW/K
	ukzTLkjw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50152)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vADsJ-000000000i9-1B5b;
	Sat, 18 Oct 2025 21:50:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vADsA-000000005aS-0gvN;
	Sat, 18 Oct 2025 21:49:54 +0100
Date: Sat, 18 Oct 2025 21:49:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org, sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-sophgo: Add phy interface filter
Message-ID: <aPP9cjzwihca-h6C@shell.armlinux.org.uk>
References: <20251017011802.523140-1-inochiama@gmail.com>
 <34fcc4cd-cd3d-418a-8d06-7426d2514dee@lunn.ch>
 <i5prc7y4fxt3krghgvs7buyfkwwulxnsc2oagbwdjx4tbqjqls@fx4nkkyz6tdt>
 <c16e53f9-f506-41e8-b3c6-cc3bdb1843e1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c16e53f9-f506-41e8-b3c6-cc3bdb1843e1@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Oct 18, 2025 at 10:38:17PM +0200, Andrew Lunn wrote:
> On Sat, Oct 18, 2025 at 08:42:07AM +0800, Inochi Amaoto wrote:
> > On Fri, Oct 17, 2025 at 08:16:17PM +0200, Andrew Lunn wrote:
> > > On Fri, Oct 17, 2025 at 09:18:01AM +0800, Inochi Amaoto wrote:
> > > > As the SG2042 has an internal rx delay, the delay should be remove
> > > > when init the mac, otherwise the phy will be misconfigurated.
> > > 
> > > Are there any in tree DT blobs using invalid phy-modes? In theory,
> > > they should not work, but sometimes there is other magic going on. I
> > > just want to make sure this is not going to cause a regression.
> > > 
> > 
> > I see no SG2042 board using invalid phy-modes. Only rgmii-id is used,
> > which is vaild.
> 
> Great, thanks for checking.

Hang on. Is this right?

The commit says that SG2042 has an internal receive delay. This is
presumably the MAC side.

To work around that, you map rgmii-id to rgmii-txid for the PHY, to
prevent the PHY from enabling its receive-side clock delay.

It seems to me that you're saying that rgmii-rxid and rgmii-id
should not be used with these MACs, and you're fixing up to remove
the receive-side delay.

"rgmii-id" doesn't mean "there is a delay _somewhere_ in the system".
It's supposed to mean that the PHY should add delays on both tx and
rx paths.

Confused.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-230759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D7BEED0C
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 23:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3343B8F9D
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 21:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B515521B9DA;
	Sun, 19 Oct 2025 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DDWPScIP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CFC1EC01B;
	Sun, 19 Oct 2025 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760908406; cv=none; b=NCIYlJJQYiqSQnKAjlTePiVmEOfGylwngAq6qD8q1t3g84vFQHcHpgb0MJB0l/jWAbFOnBf2oOyYsVVI/dEDenQsrhzsdaZ/2QKpM4rjLSiIBJ/54SIUh7v4re3P9e56+SZiB9L66NNOxGw3lkz/+f0j3+6FQDg6UJQX8c0Tw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760908406; c=relaxed/simple;
	bh=rKU3wfp00zH31DRNz1Mh0mNwIR482llTBRDZfGJqW2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk+cPkXnOMuGfECp9BD+5lewMrg7AExSxTKk8a3foMB8hmiK8Fuqj3ZVcDuU/0R5eGbghYJoic2sl5SMw7LbxBITA/OLJZmKQOHe2TZmMqQBxmanlRdvxgFT3A/zN5iyU11/n69jYLq0timLCcLSoOglmIUAvJBcdyFfY/moC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DDWPScIP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eenAxMjIeldA+zxHFfckTsl9LnonghykutSollA6fAQ=; b=DDWPScIPLCw0DfEas9sSnrqwnl
	924rKv9Y9u9qfoZfas7/Qr6FGRpBUxS8BnyqKUFxCoUBMOkOonczyDrjqwiCB5Pb7araz8LK81dnf
	FI3wZOhObn3NQBuReVlAfSSLuXoFgeOHOjX1wBwyc4YWhT5G5oJeGESzQq8EDq1kC/CERg0rqqSXd
	Dc8MmjXY7lztAYxEDIWIEXa+ydtzMt0vpvDF+Aq3m4EYZPcyTuyZrcHxDMg1JdOaUqhrcWWLPMc28
	CY4e5PkiqYHcPvlnGh5LhOcNRkETqSFJUF9tFEhdVZlakgKKv8mP6TLEhRwycx/zLuxhvhUZMy5Og
	teXOzw5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38750)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vAahy-000000001Ws-1Xwg;
	Sun, 19 Oct 2025 22:12:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vAPeu-0000000068f-3P1z;
	Sun, 19 Oct 2025 10:25:00 +0100
Date: Sun, 19 Oct 2025 10:25:00 +0100
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
Message-ID: <aPSubO4tJjN_ns-t@shell.armlinux.org.uk>
References: <20251017011802.523140-1-inochiama@gmail.com>
 <34fcc4cd-cd3d-418a-8d06-7426d2514dee@lunn.ch>
 <i5prc7y4fxt3krghgvs7buyfkwwulxnsc2oagbwdjx4tbqjqls@fx4nkkyz6tdt>
 <c16e53f9-f506-41e8-b3c6-cc3bdb1843e1@lunn.ch>
 <aPP9cjzwihca-h6C@shell.armlinux.org.uk>
 <370d13b7-bba8-449d-9050-e0719d20b57c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <370d13b7-bba8-449d-9050-e0719d20b57c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Oct 19, 2025 at 02:04:02AM +0200, Andrew Lunn wrote:
> > "rgmii-id" doesn't mean "there is a delay _somewhere_ in the system".
> > It's supposed to mean that the PHY should add delays on both tx and
> > rx paths.
> 
> When passed to the PHY it means that.
> 
> However, DT describes the hardware, the PCB. "rgmii-id" means the PCB
> does not provide the delays. So the MAC/PHY combination needs to add
> the delays. We normally have the PHY provide the delays, so the
> phy-mode is normally passed straight to the PHY. However, if the MAC
> is adding a delay, which it is in this case, in one direction and
> cannot be turned off, the value passed to the PHY needs to reflect
> this, to avoid double delays.
> 
> And because the MAC delay cannot be turned off, it means there are PCB
> designs which don't work, double delays. So it would be nice not to
> list them in the binding.

Well, I find this confusing. I'd suggest there needs to be common code
to deal with it so we can stop thinking about it, and just push everyone
towards using the common code.

phy_interface_t phy_fix_phy_mode_for_mac_delays(phy_interface_t interface,
						bool mac_txid, bool mac_rxid)
{
	if (!phy_interface_mode_is_rgmii(interface))
		return interface;

	if (mac_txid && mac_rxid) {
		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
			return PHY_INTERFACE_MODE_RGMII;
		return PHY_INTERFACE_MODE_NA;
	}

	if (mac_txid) {
		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
			return PHY_INTERFACE_MODE_RGMII_RXID;
		if (interface == PHY_INTERFACE_MODE_RGMII_TXID)
			return PHY_INTERFACE_MODE_RGMII;
		return PHY_INTERFACE_MODE_NA;
	}

	if (mac_rxid) {
		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
			return PHY_INTERFACE_MODE_RGMII_TXID;
		if (interface == PHY_INTERFACE_MODE_RGMII_RXID)
			return PHY_INTERFACE_MODE_RGMII;
		return PHY_INTERFACE_MODE_NA;
	}

	return interface;
}

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


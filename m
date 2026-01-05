Return-Path: <netdev+bounces-247138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8016ACF4D99
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFE59300A3C2
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDE03090CA;
	Mon,  5 Jan 2026 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Xev7ILke"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AFF30C635;
	Mon,  5 Jan 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632303; cv=none; b=KwaOe4rVWP/C6AkouM1zGVEpZrd4SWoGJKaTBxaAlI6d4T2c3A3Xtx1evze6VdUcA6S+/JiqfLIzh3BMX6lX+EjJZbMXX3PO6VGT3Mq8qRVzVr/JATFVW8m9rkLHDXzNFjtFzr5dn+GTV1FedWNTFCGokvV33kbl95blBzySXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632303; c=relaxed/simple;
	bh=TQp/K1PGkW8CRpOUzpx2nolN8CBKaCfWZyilzfL8CPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZk96TlL6RaWlDoxEvxVK9D6MFxplGVhlGJJrqm8pd+xGXy+1NI2zAK8J4UVgwCjgtfCLeIgBeQHVaePonK/Lw2K8ciHAaZqH2AT0JHKVw2WlJyZpJ/m3Yhx38yzMYKPFxLiytsYituL7rmdD5lSjGHCCemm77mvdoz4CPYtHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Xev7ILke; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jwmmjMlwtKTz9wNn6U+u+7OkJ4Xum60RLntr2M97O7A=; b=Xev7ILkepnItEEOm0F1r/T86mS
	dd2ED4SEUye7nbPaSbYOnJrH1aQ/PwXMy3Q7GmeTJoNS/SI9AP4y/mMfPF0dQmOyzRSZc9DBhoC1T
	MnH5222ByLtBYWhPx87LFE/QytI2hAhY/0R6iSHD/hTAKMiDcDAM1v2zvnKI+0iJw8+6nPvn53T7O
	2a/pLasxwcf/E/g1Os8ebXVGH/9ILGTpfhKd0KX1A5BhgKOz48YK/zDbTzvszH6wE7zncEJwjCZbQ
	dodNuRvrl4kZBEoOUgn0YCQeyOG7xv4QgtjrBrr5HmyyctuNR6LC18dW3T2ye6niEILAYzrPbwNgY
	kQkvjMIQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57890)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vcnuA-0000000088d-1Yt0;
	Mon, 05 Jan 2026 16:58:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vcnu8-0000000080z-2mVO;
	Mon, 05 Jan 2026 16:58:04 +0000
Date: Mon, 5 Jan 2026 16:58:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <me@ziyao.cc>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [RFC PATCH net-next v5 0/3] Add DWMAC glue driver for Motorcomm
 YT6801
Message-ID: <aVvtnBVdBms8McY5@shell.armlinux.org.uk>
References: <20251225071914.1903-1-me@ziyao.cc>
 <aVvnsuklPxbFna20@pie>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVvnsuklPxbFna20@pie>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 05, 2026 at 04:32:50PM +0000, Yao Zi wrote:
> On Thu, Dec 25, 2025 at 07:19:11AM +0000, Yao Zi wrote:
> > This series adds glue driver for Motorcomm YT6801 PCIe ethernet
> > controller, which is considered mostly compatible with DWMAC-4 IP by
> > inspecting the register layout[1]. It integrates a Motorcomm YT8531S PHY
> > (confirmed by reading PHY ID) and GMII is used to connect the PHY to
> > MAC[2].
> > 
> > The initialization logic of the MAC is mostly based on previous upstream
> > effort for the controller[3] and the Deepin-maintained downstream Linux
> > driver[4] licensed under GPL-2.0 according to its SPDX headers. However,
> > this series is a completely re-write of the previous patch series,
> > utilizing the existing DWMAC4 driver and introducing a glue driver only.
> > 
> > This series only aims to add basic networking functions for the
> > controller, features like WoL, RSS and LED control are omitted for now.
> > Testing is done on i3-4170, it reaches 939Mbps (TX)/932Mbps (RX) on
> > average,
> 
> Should I send v6 as non-RFC with the tag collected, since net-next is
> open now? Thanks for your answer.

Bear in mind that some folk (me included) have been on vacation over
the holiday period, and we're now in catch up mode with all the email
that arrived during the period we've been away. In my case, that
covers 11th December to 2nd January.

I've just reviewed your dwmac patch and sent comments, which are
minor but would still be an improvement.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


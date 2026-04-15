Return-Path: <netdev+bounces-278609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA04DMXn3mmOMQAAu9opvQ
	(envelope-from <netdev+bounces-278609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 03:20:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECC73FF780
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 03:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56DE2300A12D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8288267B89;
	Wed, 15 Apr 2026 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iPpV8nFr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F244369A
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776215999; cv=none; b=RieBcb/Y3HZlLdR+1NiCuOPwVI8KIhAtDIv1j4UbABFGA9FjhK5R3zTI7qdhW11sw++Tgy3hB3+3zW2aO8t+4aD0gpV5QKPjT4WqDKdZgRYa2CxxmC3MeId+S4xXVrWFg1MiloPZPi4jTKqDoZH2ZcKgD1ltjhnKgs2GECU3sYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776215999; c=relaxed/simple;
	bh=9DClcYz8j9nhTSC+SuTh0Gp+w7y89UTR3dD/miaI3/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMMdtVUFkyWI1je62Q3JIZnToI+uqMMPK7hActa3rGZ7hjWTe7+FVIpRil5geoN4CSBKLG/c/VZPSAyPdccQFg4nPDZAM03qMP5bC4LCKcrLCAmYwKnd2DXj0Ei3bDuUNfnNzQzyH8KaQplEXYneH2XB6SBqKy69/HrLjsfl4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iPpV8nFr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I9gjWrpCbTtEVvg30V7StRQdyDT0ZMhIUqhmyfKt3EI=; b=iPpV8nFrKYUIIkc1YpLGD3Xeu2
	hPUHegJCV3EK6tA9b21oLvfkMtwAVWPF7+ZGS/p6oDd3uqXe0jH+gGtmaO2aJaFwBMx5ENlCY0p0N
	OfFPnOX/tlgkcU9FdtUQryr65LZiVeRz8z45uHH9Hp2cz197A9X/Dz0NGJvRKs3CpfZsUdv7NJPLf
	PenW88HFESBGqVHxH9ZY0eHMtmTRudd27RfqU9fV5TXGno9gK3vMAnhm5WGfNR5LnMOf396w56d33
	zm8lcFwAPW3B+UOvrHAsG6+4427rVYRq2lCUWRWYkxoiFOijoxsC7Jf/U3U23UzT5k7gMMLfWigzi
	c9nUk4PA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49420)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wCouz-000000001Ym-2IHP;
	Wed, 15 Apr 2026 02:19:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wCouw-000000001jJ-0Fav;
	Wed, 15 Apr 2026 02:19:46 +0100
Date: Wed, 15 Apr 2026 02:19:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Message-ID: <ad7nsUQvksJF7JFK@shell.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <20260413110222.49fc3759@kernel.org>
 <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
 <CAH5Ym4i7VV53hQGY3AjAUW3B8g_ffgmw69kPhPrk2CmcRbguuQ@mail.gmail.com>
 <ad5LlXzeQ8j14Mjg@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5LlXzeQ8j14Mjg@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278609-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.775];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 7ECC73FF780
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Okay, just a quick note to say that nvidia's 5.10.216-tegra kernel
survives iperf3 -c -R to the imx6.

Dumping the registers and comparing, and then forcing the RQS and TQS
values to 0x23 (+1 = 36, *256 = 9216 bytes) and 0x8f (+1 = 144,
*256 = 36864 ytes) respectively seems to solve the problem. Under
net-next, these both end up being 0xff (+1 = 256, *256 = 65536 bytes.)
Suspiciously, 36 * 4 = 144, and I also see that this kernel programs
all four of the MTL receive operation mode registers, but only the
first MTL transmit operation mode register. However, DMA channels 1-3
aren't initialised.

net-next derives them from:

        unsigned int tqs = fifosz / 256 - 1;

where fifosz is passed in to dwmac4_dma_tx_chan_op_mode() and

        unsigned int rqs = fifosz / 256 - 1;

where fifosz is passed in to dwmac4_dma_rx_chan_op_mode().

Now, according to the DMA capabilities:

        Number of Additional RX channel: 4
        Number of Additional TX channel: 4
        Number of Additional RX queues: 4
        Number of Additional TX queues: 4
        TX Fifo Size: 65536
        RX Fifo Size: 65536

However:

# ethtool -l eth0
Channel parameters for eth0:
Pre-set maximums:
RX:             4
TX:             4
Other:          0
Combined:       0
Current hardware settings:
RX:             1
TX:             1
Other:          0
Combined:       0

So, we end up allocating the entire 64K of the tx and rx FIFO to one
queue in net-next.

Looking back at 5.10, I don't see any code that would account for these
values being programmed for TQS and RQS, it looks like the calculations
are basically the same as we have today.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


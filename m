Return-Path: <netdev+bounces-251170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E7AD3AF63
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28EE83001FC5
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB1038B9A7;
	Mon, 19 Jan 2026 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HmJkkmpm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516238B9B1;
	Mon, 19 Jan 2026 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837452; cv=none; b=fXq5AikIDKlEfVxWYIXvng5XaeEwf3HDdF8YbQoUZU68w1tKGftL0dNzt3CVFoD2ZGZRWrtIOl6iE68OIVo4JrvG4ZEsCGqj5tPXnMjePmP6UICrpfDFrL5rP7n+RlYWKX+KfcqhEqL9/IGGg4Id4sdiX97danlZMvbEvh56/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837452; c=relaxed/simple;
	bh=hoaRJky72TDMbUW4ehDh/qVmWU/lQsORlAtpr/L7ZUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9eWGpte9NKDiwN5icBI4Z0rQnlIJqi/rHYIgA7V7oAYBN4Q2e5gDvpuJAGOWk95Utn9XV4QJSJ8kSRUFXKwalcd+cg5s4w1KWpk+FizAFYeIKBrXxhSf1J7raWWPZ2OK9Th1IO4pkOsLEMlgtTPLAlAgxVV3+83ak4+OE3QdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HmJkkmpm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OdUaoSCio5puaeEe+IXYRT66N1Ls4wbMpbo4oPDQLsE=; b=HmJkkmpmk2E6djd/Aucm1PAm+P
	oa9Y9tr5QEVJ3waQyLIHcEzb+EoTSGXotpvVcxeoykh7MgPN4P3oDy11d8ER9qgj16YKgx5/teuK4
	f/fkGuhS/ykGSKUEjo1Zh6pUAnyu7vFNDWt1zLK26HYqPYgv8YkyBwjKnprlYnMg1NN+FcQFVZ3Ok
	BDhZxZdHe4qzYAVSSNPe3/5BWtQM6sFmzVs4DpchChJSrFbGm3PoagncOyLGGxWTbCjducqEHZpEO
	7IrTlf+BpD0a2Dp0gGfAfMKW+oTMCqA4GSO/Fjl7wZuLXxZfMiHc6zwr1K+wSbo9AVpHtqwBCmTrA
	4crlQW0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36966)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vhrQ1-000000005N0-0Asu;
	Mon, 19 Jan 2026 15:43:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vhrPs-000000006gH-2ofS;
	Mon, 19 Jan 2026 15:43:44 +0000
Date: Mon, 19 Jan 2026 15:43:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: Yao Zi <me@ziyao.cc>, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	vladimir.oltean@nxp.com, wens@csie.org, jszhang@kernel.org,
	0x1207@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, jeffbai@aosc.io, kexybiscuit@aosc.io
Subject: Re: [PATCH RESEND net-next v6 0/3] Add DWMAC glue driver for
 Motorcomm YT6801
Message-ID: <aW5RMKqwpYTZ9uFH@shell.armlinux.org.uk>
References: <20260109093445.46791-2-me@ziyao.cc>
 <176827502141.1659151.5259885987231026081.git-patchwork-notify@kernel.org>
 <147b700c-cae2-4286-b532-ec408e00b004@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147b700c-cae2-4286-b532-ec408e00b004@tuxedocomputers.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 19, 2026 at 04:33:17PM +0100, Georg Gottleuber wrote:
> Hi,
> 
> I tested this driver with our TUXEDO InfinityBook Pro AMD Gen9. Iperf
> revealed that tx is only 100Mbit/s:
> 
> ## YT6801 TX
> 
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  8.75 MBytes  73.3 Mbits/sec    0    164 KBytes
> 
> [  5]   1.00-2.00   sec  8.62 MBytes  72.4 Mbits/sec    0    164 KBytes
> 
> [  5]   2.00-3.00   sec  8.62 MBytes  72.4 Mbits/sec    0    164 KBytes
> 
> [  5]   3.00-4.00   sec  8.12 MBytes  68.2 Mbits/sec    0    164 KBytes
> 
> [  5]   4.00-5.00   sec  8.62 MBytes  72.3 Mbits/sec    0    164 KBytes
> 
> [  5]   5.00-6.00   sec  8.50 MBytes  71.3 Mbits/sec    0    164 KBytes
> 
> [  5]   6.00-7.00   sec  8.25 MBytes  69.2 Mbits/sec    0    164 KBytes
> 
> [  5]   7.00-8.00   sec  8.62 MBytes  72.4 Mbits/sec    0    164 KBytes
> 
> [  5]   8.00-9.00   sec  8.50 MBytes  71.3 Mbits/sec    0    164 KBytes
> 
> [  5]   9.00-10.00  sec  8.62 MBytes  72.3 Mbits/sec    0    164 KBytes
> 
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  85.2 MBytes  71.5 Mbits/sec    0             sender
> [  5]   0.00-10.05  sec  84.4 MBytes  70.5 Mbits/sec
> receiver
> 
> 
> ## YT6801 RX
> 
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec   112 MBytes   939 Mbits/sec
> [  5]   1.00-2.00   sec   112 MBytes   941 Mbits/sec
> [  5]   2.00-3.00   sec   112 MBytes   941 Mbits/sec
> [  5]   3.00-4.00   sec   112 MBytes   942 Mbits/sec
> [  5]   4.00-5.00   sec   112 MBytes   942 Mbits/sec
> [  5]   5.00-6.00   sec   112 MBytes   943 Mbits/sec
> [  5]   6.00-7.00   sec   112 MBytes   941 Mbits/sec
> [  5]   7.00-8.00   sec   112 MBytes   942 Mbits/sec
> [  5]   8.00-9.00   sec   112 MBytes   942 Mbits/sec
> [  5]   9.00-10.00  sec   112 MBytes   941 Mbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.04  sec  1.10 GBytes   941 Mbits/sec   88             sender
> [  5]   0.00-10.00  sec  1.10 GBytes   941 Mbits/sec
> receiver
> 
> With our normally used DKMS module, Ethernet works with full-duplex and
> gigabit. Attached are some logs from lspci and dmesg. Do you have any
> idea how I can debug this further?

My suggestion would be:

- Look at the statistics, e.g.

   ip -s li sh dev enp2s0

- apply
  https://lore.kernel.org/r/E1vgtBc-00000005D6v-040n@rmk-PC.armlinux.org.uk
  to enable more statistics to work, and check the network driver
  statistics:

   ethtool --statistics enp2s0

to see if there's any clues for what is going on.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


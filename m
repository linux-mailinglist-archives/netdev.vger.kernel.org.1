Return-Path: <netdev+bounces-250321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8589D2899B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54DDC3018974
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52D0318B91;
	Thu, 15 Jan 2026 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f8WpFE8i"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4032D73AE;
	Thu, 15 Jan 2026 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511092; cv=none; b=hNnSh5uyWMKocz66W1Ixvd1WbFYPhJL0ZWDdtK3xWeGKSLcMw+du5PsJIg9Z1RNCqsKhKnPVCXuGe63JkHT5MixRznWMbwKmC+PhWOh4aCy+VVwW7w692kNX/0tixkI4D9AEOhrkX33t2CyUVW5v0EAOE/WRVBRzBiip++cHq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511092; c=relaxed/simple;
	bh=AYHLoc/Y2a3Oc8SetQdtjZn1ydfuv1EbAG5cW9mD4NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evVDRIF99ajPJHCrN9l97jM4cwJbysat0pTBEiKqbzunUoggMLRhpa4mbGqjytgPfQ1/3ojtAdPJyFD1E25I44f/ARrhbmGOo6NmQUqTfc1VYX7Tvz7rG0aL+gwgfoiKzY0PLENlwBX8Us/WHmUgVgecXr8PiSB0FUbsOxf8dYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f8WpFE8i; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A14CAC1F1EC;
	Thu, 15 Jan 2026 21:04:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 52997606E0;
	Thu, 15 Jan 2026 21:04:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A47010B68776;
	Thu, 15 Jan 2026 22:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768511087; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QM84L6BDmnNvpmXB2IMVQ5YKheiCYEXuqbuqdqVkiBU=;
	b=f8WpFE8ieo1Z3zbeR7s7OoIIYBTW/vM1F2Ut5KZEKBkm0Ct/AFR29d4WQFPgdBBJLg4pyN
	9bKI1JlZeOPUmw3jjcohZSeYopyPUtcZ4eVkPztzHbnjV9oWntgVr/ofoxBxlYsVWV4opi
	7ZdJ7y089Siu8Z/dw5bwxBHDX5ilbS8nSdqw/5PrLWxrLFD48OgWsvoRqT37j9LhkCIWmh
	RCO1gPyojaX2efruFmlf6SWiq/KQYqPQbPSqZuUKDzLW/Ydi6jpL2vc+QV/GwnYXpvM0By
	MVATfEcHYAHItW0TSLsKofY+o7hEHa6dnCp095n30exm2d5yyz4TTTLpgsQYzw==
Message-ID: <6a946edc-297e-469a-8d91-80430d88f3e5@bootlin.com>
Date: Thu, 15 Jan 2026 22:04:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after
 resume
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Tao Wang <tao03.wang@horizon.auto>
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kuba@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
References: <aWd9WUUGhSU5tWcn@shell.armlinux.org.uk>
 <20260115070853.116260-1-tao03.wang@horizon.auto>
 <aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
 <aWlCs5lksxfgL6Gi@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aWlCs5lksxfgL6Gi@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

> 
> I've just run iperf3 in both directions with the kernel I had on the
> board (based on 6.18.0-rc7-net-next+), and stmmac really isn't looking
> particularly great - by that I mean, iperf3 *failed* spectacularly.
> 
> First, running in normal mode (stmmac transmitting, x86 receiving)
> it's only capable of 210Mbps, which is nowhere near line rate.
> 
> However, when running iperf3 in reverse mode, it filled the stmmac's
> receive queue, which then started spewing PAUSE frames at a rate of
> knots, flooding the network, and causing the entire network to stop.
> It never recovered without rebooting.
> 
> Trying again on 6.19.0-rc4-net-next+,
> 
> stmmac transmitting shows the same dire performance:
> 
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  24.2 MBytes   203 Mbits/sec    0    230 KBytes
> [  5]   1.00-2.00   sec  25.5 MBytes   214 Mbits/sec    0    230 KBytes
> [  5]   2.00-3.00   sec  25.0 MBytes   210 Mbits/sec    0    230 KBytes
> [  5]   3.00-4.00   sec  25.5 MBytes   214 Mbits/sec    0    230 KBytes
> [  5]   4.00-5.00   sec  25.1 MBytes   211 Mbits/sec    0    230 KBytes
> [  5]   5.00-6.00   sec  25.1 MBytes   211 Mbits/sec    0    230 KBytes
> [  5]   6.00-7.00   sec  25.7 MBytes   215 Mbits/sec    0    230 KBytes
> [  5]   7.00-8.00   sec  25.2 MBytes   212 Mbits/sec    0    230 KBytes
> [  5]   8.00-9.00   sec  25.3 MBytes   212 Mbits/sec    0    346 KBytes
> [  5]   9.00-10.00  sec  25.4 MBytes   213 Mbits/sec    0    346 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec   252 MBytes   211 Mbits/sec    0             sender
> [  5]   0.00-10.02  sec   250 MBytes   210 Mbits/sec                  receiver
> 
> stmmac receiving shows the same problem:
> 
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  64.1 MBytes   537 Mbits/sec
> [  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec
> ^C[  5]   9.00-9.43   sec  0.00 Bytes  0.00 bits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-9.43   sec  0.00 Bytes  0.00 bits/sec                  sender
> [  5]   0.00-9.43   sec  64.1 MBytes  57.0 Mbits/sec                  receiver
> iperf3: interrupt - the client has terminated

Heh, I was able to reproduce something similar on imx8mp, that has an
imx-dwmac (dwmac 4/5 according to dmesg) :

DUT to x86

Connecting to host 192.168.2.1, port 5201
[  5] local 192.168.2.13 port 54744 connected to 192.168.2.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  0.00 Bytes  0.00 bits/sec    2   1.41 KBytes
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes

x86 to DUT :

Reverse mode, remote host 192.168.2.1 is sending
[  5] local 192.168.2.13 port 47050 connected to 192.168.2.1 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   112 MBytes   935 Mbits/sec
[  5]   1.00-2.00   sec   112 MBytes   936 Mbits/sec
[  5]   2.00-3.00   sec   112 MBytes   936 Mbits/sec

Nothing as bas as what you face, but there's defintely something going
on there. "good" news is that it worked in v6.19-rc1, I have a bisect
ongoing.

I'll update once I have homed-in on something.

Maxime


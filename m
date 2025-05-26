Return-Path: <netdev+bounces-193499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD98DAC440E
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91747174423
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325181C5F35;
	Mon, 26 May 2025 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="T331D0Gi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXn6DBLY"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEA72607
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748288068; cv=none; b=IXyRQQvmJ9gWjVkmTD/ljGfRMxmoT9PokMaDXyM5LnxGnqylkmtnINETLBgOD15NPV0RR3oRy4exB84wtf0V8qf7MGHwf4b0SARA7QsFK1KgUMBAe6cb/5REYoTPgmfXbt8Gf/N1mld9imUCAIzNQ6PogOcNsIfW9u0z2+3AQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748288068; c=relaxed/simple;
	bh=xOG7jVk3eE4KoqBeKf8f9rNzo6JI315vn64chOK+lgo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DJgPXuFX+aeP/i+oIOvVbnK675YgiS+sWvF3XkUIPuSf3uNf3fcNt4qBjEAIIRul5APPsUYi156MNufxFVGBlVG6kKx8IxLmOi8GVIQxxDSUqyoK5DjYrTnhBoJNjIvmB+9xYr3TOb85xzyt3Mo9USvBt7y2fQvn+zTmSP2nBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=T331D0Gi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXn6DBLY; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A0531140103;
	Mon, 26 May 2025 15:34:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 26 May 2025 15:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748288064;
	 x=1748374464; bh=oE7nOZ59Rfe2c4vrEGDSd+i3PMXWC4EHjajr5mzUyus=; b=
	T331D0Gi9aWqyCVMqvJWHzaHD9rtth4V94PB8NKbJ3l/rbvhbwPb9dGjAaPCfUic
	Gt3Znq6H9f0mwe0FVy7jDPjHLadj3GZKAT3SQspx57YyXQ5kCql2KXV/Om/5bJQB
	uPwSngHG8spRb+dMVyZrKg7hRm8RYyXHHdCARDSVsSMWa72S4u6np/WfgWhYq5OV
	Cljc14229EhkrzHH1wg/tcdOjfxW9ddo50+uRK3YA5QPhflwWWQ0i/JuWoqTAdz/
	QQjJM90kzChMsi+ZFdbryMoKFskHVflUuLpYeTEp01kR2kCF5WRbW5wgHzNFlSWR
	dFqa1TTcAbokniRpW3YuNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748288064; x=
	1748374464; bh=oE7nOZ59Rfe2c4vrEGDSd+i3PMXWC4EHjajr5mzUyus=; b=M
	Xn6DBLYX9fwCXTG1K5ksxo4k+u5NLLDulta2wRdYkMx17BSnmEraZmFh9rsYlTd7
	tabZ+NCyXJC7p6bGjAhnNkcvrse7aR6Bb5rliOVA6o7E1+0RGHCtNay1F5j/RwVO
	IicntZ5A+4IrdmvdjUT2c6F+j3r25HMp6crDRIcs1Oqce8TkspPEv8v9fgsZcV18
	tJr6hRYmUeJFeodohrAd/ApWgaoyeVLLZ5Dyw7So2GMme8+7jSoOZoXf6RzuSWix
	IOBxdQLdurIyZ8uD+VCLaeo59nX+Ku+FlmHBn7y0Y2EV1OoQs15x7GU8gOGyU137
	/eO1DY1MkPjowNgPCBspQ==
X-ME-Sender: <xms:P8I0aJky0Oh_ygx_VVFGsAbwEVROvlse0AYIoc-KHYZnDTMBv9oJPA>
    <xme:P8I0aE0dHcmDnGZ-lZ9EyhXQ7icPbnLqkvVBg0LSYcPMURLlr_NZpiNrjMw52Qagg
    dOMzfsRDFjHYSDNIfs>
X-ME-Received: <xmr:P8I0aPr_FIq5T9oFTrESaI3oZfZVaop0-22C-OKticds6iKENYvykCsQNHXujnP7PK7044wuJ6mEp5NuzSeplzXxEB9Wk8Sdg4i_cmQ379r4IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddukeefjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfuhfgjffev
    gffkfhfvofesthhqmhdthhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnoh
    cuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnheptefh
    leekteffhedtgeekudeivefhgfevtedvgedtjefhffejteelgeethfevhfdunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhitggrrhgusegs
    vghjrghrrghnohdrihhopdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepmhhikhgr
    rdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgr
    vghlrdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpthhtohephigvhhgviihkvghlsh
    hhsgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehl
    uhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprh
    gtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:P8I0aJkFR7S2rpV7xQrYfjXrzwjrqHrveQ7nWQ72Uq01wpg4t2cDrw>
    <xmx:P8I0aH2clKRFOtW6meWzTaTpCxbfjbbWKwOP2uTe1p4c2Bc61ml8jg>
    <xmx:P8I0aIuLAcJTSw9BTqnDuyAgFzHbwMK2anh6gqjIp2q1TZgDyguFXA>
    <xmx:P8I0aLXdyJ52pCx0MQD1ssbgwHma7kegFzn0xDyZupq-Gu4gHfsSAQ>
    <xmx:QMI0aAP4ih7wqcPYS3xWCsCjdPI-QZ4f9jFRvhM9ITEf-dV03fKY88os>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 15:34:21 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Poor thunderbolt-net interface performance when bridged
From: Ricard Bejarano <ricard@bejarano.io>
In-Reply-To: <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
Date: Mon, 26 May 2025 21:34:19 +0200
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hey Andrew, thanks for chiming in.

> Do the interfaces provide statistics? ethtool -S. Where is the packet
> loss happening?

root@blue:~# ethtool -S tb0
no stats available
root@blue:~# ip -s link show tb0
6: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master =
br0 state UP mode DEFAULT group default qlen 1000
    link/ether 02:70:19:dc:92:96 brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
      11209729   71010      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
     624522843  268941      0       0       0       0
root@blue:~#

root@red:~# ethtool -S tb0
no stats available
root@red:~# ip -s link show tb0
8: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master =
br0 state UP mode DEFAULT group default qlen 1000
    link/ether 02:5f:d6:57:71:93 brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
     624522843  320623      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
      11209729   71007      0       0       0       0
root@red:~#

It seems like everything is fine, but I noticed iperf3 red->blue does =
show a lot
of TCP retries, at least relative to red->blue->purple:

root@red:~# iperf3 -c 10.0.0.2  # blue
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 34858 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  1016 MBytes  8.52 Gbits/sec   10   1.41 MBytes
[  5]   1.00-2.00   sec  1.06 GBytes  9.07 Gbits/sec    0   1.89 MBytes
[  5]   2.00-3.00   sec  1.06 GBytes  9.12 Gbits/sec    0   2.15 MBytes
[  5]   3.00-4.00   sec  1.07 GBytes  9.22 Gbits/sec    0   2.18 MBytes
[  5]   4.00-5.00   sec  1.08 GBytes  9.27 Gbits/sec    0   2.22 MBytes
[  5]   5.00-6.00   sec  1.08 GBytes  9.24 Gbits/sec    0   2.24 MBytes
[  5]   6.00-7.00   sec  1.08 GBytes  9.25 Gbits/sec    0   2.25 MBytes
[  5]   7.00-8.00   sec  1.09 GBytes  9.32 Gbits/sec    0   2.26 MBytes
[  5]   8.00-9.00   sec  1.09 GBytes  9.36 Gbits/sec    0   2.27 MBytes
[  5]   9.00-10.00  sec  1.08 GBytes  9.29 Gbits/sec    0   2.27 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  10.7 GBytes  9.17 Gbits/sec   10             =
sender
[  5]   0.00-10.00  sec  10.7 GBytes  9.16 Gbits/sec                  =
receiver
root@red:~# iperf3 -c 10.0.0.3  # purple
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.1 port 38894 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   384 KBytes  3.14 Mbits/sec   53   2.83 KBytes
[  5]   1.00-2.00   sec   640 KBytes  5.24 Mbits/sec   42   4.24 KBytes
[  5]   2.00-3.00   sec   640 KBytes  5.24 Mbits/sec   48   2.83 KBytes
[  5]   3.00-4.00   sec   768 KBytes  6.29 Mbits/sec   56   2.83 KBytes
[  5]   4.00-5.00   sec   512 KBytes  4.19 Mbits/sec   62   2.83 KBytes
[  5]   5.00-6.00   sec   640 KBytes  5.24 Mbits/sec   50   2.83 KBytes
[  5]   6.00-7.00   sec   640 KBytes  5.24 Mbits/sec   56   2.83 KBytes
[  5]   7.00-8.00   sec   768 KBytes  6.29 Mbits/sec   48   2.83 KBytes
[  5]   8.00-9.00   sec   512 KBytes  4.19 Mbits/sec   52   4.24 KBytes
[  5]   9.00-10.00  sec   640 KBytes  5.24 Mbits/sec   48   2.83 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  6.00 MBytes  5.03 Mbits/sec  515             =
sender
[  5]   0.00-10.00  sec  6.00 MBytes  5.03 Mbits/sec                  =
receiver
root@red:~#

Now, where do those retries happen? I've made PCAPs of the two iperf3 =
tests
above, I'll be looking into those and share once I've stripped their =
payloads,
otherwise they're too large for email.

> Is your iperf testing with TCP or UDP?  A small amount of packet loss
> will cause TCP to back off a lot. Also, if the reverse direction is
> getting messed up, ACKs are getting lost, TCP will also stall.
>
> Maybe try a UDP stream, say 500Mbs. What is the packet loss? Try the
> reverse direction, what is the packet loss. Then try --bidir, so you
> get both directions at the same time.

I was using TCP (default). The UDP results are very interesting indeed:

1. red to blue, 110Mbps
-----------------------

root@red:~# iperf3 -c 10.0.0.2 -u -t 5 -b 110M  # blue
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 33079 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  13.1 MBytes   110 Mbits/sec  9488
[  5]   1.00-2.00   sec  13.1 MBytes   110 Mbits/sec  9496
[  5]   2.00-3.00   sec  13.1 MBytes   110 Mbits/sec  9496
[  5]   3.00-4.00   sec  13.1 MBytes   110 Mbits/sec  9495
[  5]   4.00-5.00   sec  13.1 MBytes   110 Mbits/sec  9496
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    =
Lost/Total Datagrams
[  5]   0.00-5.00   sec  65.6 MBytes   110 Mbits/sec  0.000 ms  0/47471 =
(0%)  sender
[  5]   0.00-5.00   sec  65.6 MBytes   110 Mbits/sec  0.026 ms  0/47471 =
(0%)  receiver

Good, as expected.

2. red to blue, 1.1Gbps
-----------------------

root@red:~# iperf3 -c 10.0.0.2 -u -t 5 -b 1100M  # blue
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 35966 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   131 MBytes  1.10 Gbits/sec  94891
[  5]   1.00-2.00   sec   131 MBytes  1.10 Gbits/sec  94957
[  5]   2.00-3.00   sec   131 MBytes  1.10 Gbits/sec  94961
[  5]   3.00-4.00   sec   131 MBytes  1.10 Gbits/sec  94960
[  5]   4.00-5.00   sec   131 MBytes  1.10 Gbits/sec  94951
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    =
Lost/Total Datagrams
[  5]   0.00-5.00   sec   656 MBytes  1.10 Gbits/sec  0.000 ms  0/474720 =
(0%)  sender
[  5]   0.00-5.00   sec   567 MBytes   950 Mbits/sec  0.003 ms  =
64437/474720 (14%)  receiver

Interesting. Rerunning it leads similar results. Why do we have ~12-14% =
loss?

3. red to blue, 910Mbps
-----------------------

root@red:~# iperf3 -c 10.0.0.2 -u -t 5 -b 910M  # blue
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 35073 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   108 MBytes   909 Mbits/sec  78498
[  5]   1.00-2.00   sec   108 MBytes   910 Mbits/sec  78557
[  5]   2.00-3.00   sec   108 MBytes   910 Mbits/sec  78556
[  5]   3.00-4.00   sec   108 MBytes   910 Mbits/sec  78557
[  5]   4.00-5.00   sec   108 MBytes   910 Mbits/sec  78556
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    =
Lost/Total Datagrams
[  5]   0.00-5.00   sec   542 MBytes   910 Mbits/sec  0.000 ms  0/392724 =
(0%)  sender
[  5]   0.00-5.00   sec   349 MBytes   585 Mbits/sec  0.002 ms  =
140008/392724 (36%)  receiver
root@red:~# iperf3 -c 10.0.0.2 -u -t 5 -b 910M  # blue
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 46225 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   108 MBytes   909 Mbits/sec  78500
[  5]   1.00-2.00   sec   108 MBytes   910 Mbits/sec  78555
[  5]   2.00-3.00   sec   108 MBytes   910 Mbits/sec  78557
[  5]   3.00-4.00   sec   108 MBytes   910 Mbits/sec  78557
[  5]   4.00-5.00   sec   108 MBytes   910 Mbits/sec  78556
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    =
Lost/Total Datagrams
[  5]   0.00-5.00   sec   542 MBytes   910 Mbits/sec  0.000 ms  0/392725 =
(0%)  sender
[  5]   0.00-5.00   sec   486 MBytes   816 Mbits/sec  0.005 ms  =
40598/392725 (10%)  receiver
root@red:~# iperf3 -c 10.0.0.2 -u -t 5 -b 910M  # blue
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 33329 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   108 MBytes   909 Mbits/sec  78504
[  5]   1.00-2.00   sec   108 MBytes   910 Mbits/sec  78549
[  5]   2.00-3.00   sec   108 MBytes   910 Mbits/sec  78563
[  5]   3.00-4.00   sec   108 MBytes   910 Mbits/sec  78557
[  5]   4.00-5.00   sec   108 MBytes   910 Mbits/sec  78554
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    =
Lost/Total Datagrams
[  5]   0.00-5.00   sec   542 MBytes   910 Mbits/sec  0.000 ms  0/392727 =
(0%)  sender
[  5]   0.00-5.00   sec   538 MBytes   902 Mbits/sec  0.003 ms  =
3144/392727 (0.8%)  receiver
root@red:~#

These three tests at 910Mbps show major loss variance in red->blue =
traffic.
We know this loss doesn't appear at 110Mbps (test #1, after several =
reruns),
and some rough binary search for the inflection point leads to =
~250-300Mbps.

Where does this loss come from though?

4. red to blue, 10.1Gbps
------------------------

root@red:~# iperf3 -c 10.0.0.2 -u -t 5 -b 11000M  # blue
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 59115 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   555 MBytes  4.65 Gbits/sec  401782
[  5]   1.00-2.00   sec   558 MBytes  4.68 Gbits/sec  404136
[  5]   2.00-3.00   sec   556 MBytes  4.66 Gbits/sec  402648
[  5]   3.00-4.00   sec   556 MBytes  4.66 Gbits/sec  402634
[  5]   4.00-5.00   sec   556 MBytes  4.66 Gbits/sec  402374
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    =
Lost/Total Datagrams
[  5]   0.00-5.00   sec  2.72 GBytes  4.66 Gbits/sec  0.000 ms  =
0/2013574 (0%)  sender
[  5]   0.00-5.00   sec  2.51 GBytes  4.31 Gbits/sec  0.002 ms  =
154525/2013574 (7.7%)  receiver

First, sender bitrate doesn't go beyond ~4.68Gbps, okay.

Second, since receiver bitrate goes up from test #2's ~950Mbps to =
~4.31Gbps, we
know that the loss we saw there is not because the receiver can't take =
it, so
maybe the Thunderbolt link is to blame for the loss?

5. red to purple, 110Mbps
-------------------------

root@red:~# iperf3 -c 10.0.0.3 -u -t 5 -b 110M  # purple
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.1 port 48081 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  13.1 MBytes   110 Mbits/sec  9488
[  5]   1.00-2.00   sec  13.1 MBytes   110 Mbits/sec  9496
[  5]   2.00-3.00   sec  13.1 MBytes   110 Mbits/sec  9496
[  5]   3.00-4.00   sec  13.1 MBytes   110 Mbits/sec  9496
[  5]   4.00-5.00   sec  13.1 MBytes   110 Mbits/sec  9495
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    =
Lost/Total Datagrams
[  5]   0.00-5.00   sec  65.6 MBytes   110 Mbits/sec  0.000 ms  0/47471 =
(0%)  sender
[  5]   0.00-5.00   sec  65.6 MBytes   110 Mbits/sec  0.029 ms  0/47471 =
(0%)  receiver

INTERESTING!

This is the first time we're going beyond ~5Mbps in the blue->purple =
direction,
meaning, there is something up with TCP.

And, if we put this together with test #4, it would make sense that:
  1. (unusual) Thunderbolt interface loss causes TCP retries;
  2. TCP retries cause TCP backoff;
  3. TCP bandwidth drops to ~5Mbps.

6. red to purple, 950Mbps & 990Mbps
-----------------------------------

root@red:~# iperf3 -c 10.0.0.3 -u -t 5 -b 950M  # purple
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.1 port 57640 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   113 MBytes   949 Mbits/sec  81956
[  5]   1.00-2.00   sec   113 MBytes   950 Mbits/sec  82010
[  5]   2.00-3.00   sec   113 MBytes   950 Mbits/sec  82010
[  5]   3.00-4.00   sec   113 MBytes   950 Mbits/sec  82006
[  5]   4.00-5.00   sec   113 MBytes   950 Mbits/sec  82010
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    =
Lost/Total Datagrams
[  5]   0.00-5.00   sec   566 MBytes   950 Mbits/sec  0.000 ms  0/409992 =
(0%)  sender
[  5]   0.00-5.00   sec   566 MBytes   949 Mbits/sec  0.009 ms  0/409643 =
(0%)  receiver
root@red:~# iperf3 -c 10.0.0.3 -u -t 5 -b 990M  # purple
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.1 port 49666 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   118 MBytes   989 Mbits/sec  85407
[  5]   1.00-2.00   sec   118 MBytes   990 Mbits/sec  85459
[  5]   2.00-3.00   sec   118 MBytes   990 Mbits/sec  85467
[  5]   3.00-4.00   sec   118 MBytes   990 Mbits/sec  85458
[  5]   4.00-5.00   sec   118 MBytes   990 Mbits/sec  85466
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    =
Lost/Total Datagrams
[  5]   0.00-5.00   sec   590 MBytes   990 Mbits/sec  0.000 ms  0/427257 =
(0%)  sender
[  5]   0.00-5.00   sec   566 MBytes   949 Mbits/sec  0.022 ms  =
13640/423358 (3.2%)  receiver
root@red:~#

INTERESTING!

First, we're reaching line speed in the red->blue->purple direction for =
the
first time.

Second, we're doing so without any loss, which is weird given the 12-14% =
loss we
saw in tests #2, #3 and #4.


What's your reading of all of this?


Thank you all again,
Ricard Bejarano



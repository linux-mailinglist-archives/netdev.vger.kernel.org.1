Return-Path: <netdev+bounces-41345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936727CAAA4
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B343B20A4B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7D12869F;
	Mon, 16 Oct 2023 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fQtQeJHJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9AF286A3
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:59:05 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D310F139
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:59:03 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B47D40004;
	Mon, 16 Oct 2023 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697464742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGRlGvPdP0ypwgMFAnNEItlq7wdADfcgNHu9SYzi1pM=;
	b=fQtQeJHJhHAJH+kRcb16Yj/p1aaCunPTpxflqD1pQpsL6ovPevMGlp1PNofUblzp7iFQaa
	Et5sH4D8ZQz/h2dwzQIulEr9y/YVHPWn5bSo6ltgkHXyQxbHEa2uIuwcQu1kls/KJQMn/f
	BPT4u7p2nn7DszzuLkdkilDRcniziDJW4sXCAymTDlnMeECTa0r7dJcZ1SaW5ztEc8vOWP
	HHyvQ+bRPTtuu+K+cwfA6sQrqBFiGWtgSAfjb+rb/WCD7lHkXIQo1tF14OMzHksWmACTJ9
	HBiWdDWOQ1xtI3nUvZZFY4+HjEwVC5PwKLaJ3R4tPTzKQL9uL1QTFct7e0QIxA==
Date: Mon, 16 Oct 2023 15:58:58 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Wei Fang
 <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux-imx@nxp.com, netdev@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Stephen
 Hemminger <stephen@networkplumber.org>
Subject: Re: Ethernet issue on imx6
Message-ID: <20231016155858.7af3490b@xps-13>
In-Reply-To: <CANn89iKC9apkRG80eBPqsdKEkdawKzGt9EsBRLm61H=4Nn4jQQ@mail.gmail.com>
References: <20231012193410.3d1812cf@xps-13>
	<ZShLX/ghL/b1Gbyz@shell.armlinux.org.uk>
	<20231013104003.260cc2f1@xps-13>
	<CANn89iKC9apkRG80eBPqsdKEkdawKzGt9EsBRLm61H=4Nn4jQQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

edumazet@google.com wrote on Mon, 16 Oct 2023 13:49:25 +0200:

> On Fri, Oct 13, 2023 at 10:40=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Russell,
> >
> > linux@armlinux.org.uk wrote on Thu, 12 Oct 2023 20:39:11 +0100:
> > =20
> > > On Thu, Oct 12, 2023 at 07:34:10PM +0200, Miquel Raynal wrote: =20
> > > > Hello,
> > > >
> > > > I've been scratching my foreheads for weeks on a strange imx6
> > > > network issue, I need help to go further, as I feel a bit clueless =
now.
> > > >
> > > > Here is my setup :
> > > > - Custom imx6q board
> > > > - Bootloader: U-Boot 2017.11 (also tried with a 2016.03)
> > > > - Kernel : 4.14(.69,.146,.322), v5.10 and v6.5 with the same behavi=
or
> > > > - The MAC (fec driver) is connected to a Micrel 9031 PHY
> > > > - The PHY is connected to the link partner through an industrial ca=
ble =20
> > >
> > > "industrial cable" ? =20
> >
> > It is a "unique" hardware cable, the four Ethernet pairs are foiled
> > twisted pair each and the whole cable is shielded. Additionally there
> > is the 24V power supply coming from this cable. The connector is from
> > ODU S22LOC-P16MCD0-920S. The structure of the cable should be similar
> > to a CAT7 cable with the additional power supply line.
> > =20
> > > > - Testing 100BASE-T (link is stable) =20
> > >
> > > Would that be full or half duplex? =20
> >
> > Ah, yeah, sorry for forgetting this detail, it's full duplex.
> > =20
> > > > The RGMII-ID timings are probably not totally optimal but offer
> > > > rather good performance. In UDP with iperf3:
> > > > * Downlink (host to the board) runs at full speed with 0% drop
> > > > * Uplink (board to host) runs at full speed with <1% drop
> > > >
> > > > However, if I ever try to limit the bandwidth in uplink (only), the
> > > > drop rate rises significantly, up to 30%:
> > > >
> > > > //192.168.1.1 is my host, so the below lines are from the board:
> > > > # iperf3 -c 192.168.1.1 -u -b100M
> > > > [  5]   0.00-10.05  sec   113 MBytes  94.6 Mbits/sec  0.044 ms
> > > > 467/82603 (0.57%)  receiver # iperf3 -c 192.168.1.1 -u -b90M
> > > > [  5]   0.00-10.04  sec  90.5 MBytes  75.6 Mbits/sec  0.146 ms
> > > > 12163/77688 (16%)  receiver # iperf3 -c 192.168.1.1 -u -b80M
> > > > [  5]   0.00-10.05  sec  66.4 MBytes  55.5 Mbits/sec  0.162 ms
> > > > 20937/69055 (30%)  receiver =20
> > >
> > > My setup:
> > >
> > > i.MX6DL silicon rev 1.3
> > > Atheros AR8035 PHY
> > > 6.3.0+ (no significant changes to fec_main.c)
> > > Link, being BASE-T, is standard RJ45.
> > >
> > > Connectivity is via a bridge device (sorry, can't change that as it
> > > would be too disruptive, as this is my Internet router!)
> > >
> > > Running at 1000BASE-T (FD):
> > > [ ID] Interval           Transfer     Bitrate         Jitter
> > > Lost/Total Datagrams [  5]   0.00-10.01  sec   114 MBytes  95.4
> > > Mbits/sec  0.030 ms  0/82363 (0%)  receiver [  5]   0.00-10.00  sec
> > > 107 MBytes  90.0 Mbits/sec  0.103 ms  0/77691 (0%)  receiver [  5]
> > > 0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.101 ms  0/69060 (0%)
> > > receiver
> > >
> > > Running at 100BASE-Tx (FD):
> > > [ ID] Interval           Transfer     Bitrate         Jitter
> > > Lost/Total Datagrams [  5]   0.00-10.01  sec   114 MBytes  95.4
> > > Mbits/sec  0.008 ms  0/82436 (0%)  receiver [  5]   0.00-10.00  sec
> > > 107 MBytes  90.0 Mbits/sec  0.088 ms  0/77692 (0%)  receiver [  5]
> > > 0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.108 ms  0/69058 (0%)
> > > receiver
> > >
> > > Running at 100bASE-Tx (HD):
> > > [ ID] Interval           Transfer     Bitrate         Jitter
> > > Lost/Total Datagrams [  5]   0.00-10.01  sec   114 MBytes  95.3
> > > Mbits/sec  0.056 ms  0/82304 (0%)  receiver [  5]   0.00-10.00  sec
> > > 107 MBytes  90.0 Mbits/sec  0.101 ms  1/77691 (0.0013%)  receiver [
> > > 5]   0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.105 ms  0/69058
> > > (0%)  receiver
> > >
> > > So I'm afraid I don't see your issue. =20
> >
> > I believe the issue cannot be at an higher level than the MAC. I also
> > do not think the MAC driver and PHY driver are specifically buggy. I
> > ruled out the hardware issue given the fact that under certain
> > conditions (high load) the network works rather well... But I certainly
> > see this issue, and when switching to TCP the results are dramatic:
> >
> > # iperf3 -c 192.168.1.1
> > Connecting to host 192.168.1.1, port 5201
> > [  5] local 192.168.1.2 port 37948 connected to 192.168.1.1 port 5201
> > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > [  5]   0.00-1.00   sec  11.3 MBytes  94.5 Mbits/sec   43   32.5 KBytes
> > [  5]   1.00-2.00   sec  3.29 MBytes  27.6 Mbits/sec   26   1.41 KBytes
> > [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> > [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> > [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    5   1.41 KBytes
> > [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> > [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> > [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> > [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> > [  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> >
> > Thanks,
> > Miqu=C3=A8l =20
>=20
> Can you experiment with :
>=20
> - Disabling TSO on your NIC (ethtool -K eth0 tso off)
> - Reducing max GSO size (ip link set dev eth0 gso_max_size 16384)
>=20
> I suspect some kind of issues with fec TX completion, vs TSO emulation.

Wow, appears to have a significant effect. I am using Busybox's iproute
implementation which does not know gso_max_size, but I hacked directly
into netdevice.h just to see if it would have an effect. I'm adding
iproute2 to the image for further testing.

Here is the diff:

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2364,7 +2364,7 @@ struct net_device {
 /* TCP minimal MSS is 8 (TCP_MIN_GSO_SIZE),
  * and shinfo->gso_segs is a 16bit field.
  */
-#define GSO_MAX_SIZE           (8 * GSO_MAX_SEGS)
+#define GSO_MAX_SIZE           16384u
=20
        unsigned int            gso_max_size;
 #define TSO_LEGACY_MAX_SIZE    65536

And here are the results:

# ethtool -K eth0 tso off
# iperf3 -c 192.168.1.1 -u -b1M
Connecting to host 192.168.1.1, port 5201
[  5] local 192.168.1.2 port 50490 connected to 192.168.1.1 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   123 KBytes  1.01 Mbits/sec  87 =20
[  5]   1.00-2.00   sec   122 KBytes   996 Kbits/sec  86 =20
[  5]   2.00-3.00   sec   122 KBytes   996 Kbits/sec  86 =20
[  5]   3.00-4.00   sec   123 KBytes  1.01 Mbits/sec  87 =20
[  5]   4.00-5.00   sec   122 KBytes   996 Kbits/sec  86 =20
[  5]   5.00-6.00   sec   122 KBytes   996 Kbits/sec  86 =20
[  5]   6.00-7.00   sec   123 KBytes  1.01 Mbits/sec  87 =20
[  5]   7.00-8.00   sec   122 KBytes   996 Kbits/sec  86 =20
[  5]   8.00-9.00   sec   122 KBytes   996 Kbits/sec  86 =20
[  5]   9.00-10.00  sec   123 KBytes  1.01 Mbits/sec  87 =20
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total =
Datagrams
[  5]   0.00-10.00  sec  1.19 MBytes  1.00 Mbits/sec  0.000 ms  0/864 (0%) =
 sender
[  5]   0.00-10.05  sec  1.11 MBytes   925 Kbits/sec  0.045 ms  62/864 (7.2=
%)  receiver
iperf Done.
# iperf3 -c 192.168.1.1
Connecting to host 192.168.1.1, port 5201
[  5] local 192.168.1.2 port 34792 connected to 192.168.1.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  1.63 MBytes  13.7 Mbits/sec   30   1.41 KBytes    =
  =20
[  5]   1.00-2.00   sec  7.40 MBytes  62.1 Mbits/sec   65   14.1 KBytes    =
  =20
[  5]   2.00-3.00   sec  7.83 MBytes  65.7 Mbits/sec  109   2.83 KBytes    =
  =20
[  5]   3.00-4.00   sec  2.49 MBytes  20.9 Mbits/sec   46   19.8 KBytes    =
  =20
[  5]   4.00-5.00   sec  7.89 MBytes  66.2 Mbits/sec  109   2.83 KBytes    =
  =20
[  5]   5.00-6.00   sec   255 KBytes  2.09 Mbits/sec   22   2.83 KBytes    =
  =20
[  5]   6.00-7.00   sec  4.35 MBytes  36.5 Mbits/sec   74   41.0 KBytes    =
  =20
[  5]   7.00-8.00   sec  10.9 MBytes  91.8 Mbits/sec   34   45.2 KBytes    =
  =20
[  5]   8.00-9.00   sec  5.35 MBytes  44.9 Mbits/sec   82   1.41 KBytes    =
  =20
[  5]   9.00-10.00  sec  1.37 MBytes  11.5 Mbits/sec   73   1.41 KBytes    =
  =20
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  49.5 MBytes  41.5 Mbits/sec  644             sender
[  5]   0.00-10.05  sec  49.3 MBytes  41.1 Mbits/sec                  recei=
ver
iperf Done.

There is still a noticeable amount of drop/retries, but overall the
results are significantly better. What is the rationale behind the
choice of 16384 in particular? Could this be further improved?

Thanks a lot,
Miqu=C3=A8l


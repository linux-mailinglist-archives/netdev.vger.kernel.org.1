Return-Path: <netdev+bounces-40629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8377C8089
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 10:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA33B2096B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 08:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB156D39;
	Fri, 13 Oct 2023 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R/uy6OS1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224463D4
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:40:13 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43243A9
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 01:40:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98BC820003;
	Fri, 13 Oct 2023 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697186409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn2Z5Nanm/0OktASMhvg5G8nkxqS8SaiYkly/r1Cgy4=;
	b=R/uy6OS1g2HNmu8LLMmEZBijrbSJUk7+yauFBvxUwKYmQosAM8ydYiWsRpsMbV33NGAot+
	juZWKpr1tc7nG1R+9QgpTiMqcSblD9wcVlj+pj9hVvSwKlD5Qz1M+uSzgruTzOOAtoUBuc
	JkbKV83UdE+RCZ/dGZ6WkKNJkqadEd0/o1SOUrS28FeWVUQmHPohjoVmrFSamFtizS8cH8
	l8lQ4hQObHxpCIP1hAut7jUHW6Hk4qe5UwhDEIY5vYThPihCXLiVfPplNg+eF8KX238nhn
	UXpiyznr7PsAxnDDASAuCynS6M/0jnQXBKBwdh3829XcuPY88ASFwXFEywWq7w==
Date: Fri, 13 Oct 2023 10:40:03 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-imx@nxp.com,
 netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Stephen
 Hemminger <stephen@networkplumber.org>
Subject: Re: Ethernet issue on imx6
Message-ID: <20231013104003.260cc2f1@xps-13>
In-Reply-To: <ZShLX/ghL/b1Gbyz@shell.armlinux.org.uk>
References: <20231012193410.3d1812cf@xps-13>
	<ZShLX/ghL/b1Gbyz@shell.armlinux.org.uk>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell,

linux@armlinux.org.uk wrote on Thu, 12 Oct 2023 20:39:11 +0100:

> On Thu, Oct 12, 2023 at 07:34:10PM +0200, Miquel Raynal wrote:
> > Hello,
> >=20
> > I've been scratching my foreheads for weeks on a strange imx6
> > network issue, I need help to go further, as I feel a bit clueless now.
> >=20
> > Here is my setup :
> > - Custom imx6q board
> > - Bootloader: U-Boot 2017.11 (also tried with a 2016.03)
> > - Kernel : 4.14(.69,.146,.322), v5.10 and v6.5 with the same behavior
> > - The MAC (fec driver) is connected to a Micrel 9031 PHY
> > - The PHY is connected to the link partner through an industrial cable =
=20
>=20
> "industrial cable" ?

It is a "unique" hardware cable, the four Ethernet pairs are foiled
twisted pair each and the whole cable is shielded. Additionally there
is the 24V power supply coming from this cable. The connector is from
ODU S22LOC-P16MCD0-920S. The structure of the cable should be similar
to a CAT7 cable with the additional power supply line.

> > - Testing 100BASE-T (link is stable) =20
>=20
> Would that be full or half duplex?

Ah, yeah, sorry for forgetting this detail, it's full duplex.

> > The RGMII-ID timings are probably not totally optimal but offer
> > rather good performance. In UDP with iperf3:
> > * Downlink (host to the board) runs at full speed with 0% drop
> > * Uplink (board to host) runs at full speed with <1% drop
> >=20
> > However, if I ever try to limit the bandwidth in uplink (only), the
> > drop rate rises significantly, up to 30%:
> >=20
> > //192.168.1.1 is my host, so the below lines are from the board:
> > # iperf3 -c 192.168.1.1 -u -b100M
> > [  5]   0.00-10.05  sec   113 MBytes  94.6 Mbits/sec  0.044 ms
> > 467/82603 (0.57%)  receiver # iperf3 -c 192.168.1.1 -u -b90M
> > [  5]   0.00-10.04  sec  90.5 MBytes  75.6 Mbits/sec  0.146 ms
> > 12163/77688 (16%)  receiver # iperf3 -c 192.168.1.1 -u -b80M
> > [  5]   0.00-10.05  sec  66.4 MBytes  55.5 Mbits/sec  0.162 ms
> > 20937/69055 (30%)  receiver =20
>=20
> My setup:
>=20
> i.MX6DL silicon rev 1.3
> Atheros AR8035 PHY
> 6.3.0+ (no significant changes to fec_main.c)
> Link, being BASE-T, is standard RJ45.
>=20
> Connectivity is via a bridge device (sorry, can't change that as it
> would be too disruptive, as this is my Internet router!)
>=20
> Running at 1000BASE-T (FD):
> [ ID] Interval           Transfer     Bitrate         Jitter
> Lost/Total Datagrams [  5]   0.00-10.01  sec   114 MBytes  95.4
> Mbits/sec  0.030 ms  0/82363 (0%)  receiver [  5]   0.00-10.00  sec
> 107 MBytes  90.0 Mbits/sec  0.103 ms  0/77691 (0%)  receiver [  5]
> 0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.101 ms  0/69060 (0%)
> receiver
>=20
> Running at 100BASE-Tx (FD):
> [ ID] Interval           Transfer     Bitrate         Jitter
> Lost/Total Datagrams [  5]   0.00-10.01  sec   114 MBytes  95.4
> Mbits/sec  0.008 ms  0/82436 (0%)  receiver [  5]   0.00-10.00  sec
> 107 MBytes  90.0 Mbits/sec  0.088 ms  0/77692 (0%)  receiver [  5]
> 0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.108 ms  0/69058 (0%)
> receiver
>=20
> Running at 100bASE-Tx (HD):
> [ ID] Interval           Transfer     Bitrate         Jitter
> Lost/Total Datagrams [  5]   0.00-10.01  sec   114 MBytes  95.3
> Mbits/sec  0.056 ms  0/82304 (0%)  receiver [  5]   0.00-10.00  sec
> 107 MBytes  90.0 Mbits/sec  0.101 ms  1/77691 (0.0013%)  receiver [
> 5]   0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.105 ms  0/69058
> (0%)  receiver
>=20
> So I'm afraid I don't see your issue.

I believe the issue cannot be at an higher level than the MAC. I also
do not think the MAC driver and PHY driver are specifically buggy. I
ruled out the hardware issue given the fact that under certain
conditions (high load) the network works rather well... But I certainly
see this issue, and when switching to TCP the results are dramatic:

# iperf3 -c 192.168.1.1
Connecting to host 192.168.1.1, port 5201
[  5] local 192.168.1.2 port 37948 connected to 192.168.1.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  11.3 MBytes  94.5 Mbits/sec   43   32.5 KBytes    =
  =20
[  5]   1.00-2.00   sec  3.29 MBytes  27.6 Mbits/sec   26   1.41 KBytes    =
  =20
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes      =
=20
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes      =
=20
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    5   1.41 KBytes      =
=20
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes      =
=20
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes      =
=20
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes      =
=20
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes      =
=20
[  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes =20

Thanks,
Miqu=C3=A8l


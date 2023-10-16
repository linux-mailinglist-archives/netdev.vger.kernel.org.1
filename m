Return-Path: <netdev+bounces-41393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF127CADAC
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CC02813CE
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488CE2943E;
	Mon, 16 Oct 2023 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JK+CR0UO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B528E2D
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 15:37:02 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D3EAB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 08:36:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5488E0006;
	Mon, 16 Oct 2023 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697470618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMOXgp4o1PrUZjkbvvxCGPoyCYh+0YWJORDBlMtyX5o=;
	b=JK+CR0UOqwEs6LP27DAUH+yNSfdC0yhXKVKmctPoBJ6mtoOxLH2wA5tDr6l07nusOhBaDG
	40Bk3JHqIzAtpe2a/cY1sNCpINSY1jIOPn1QH7albLqBCF06Ostnh6wWJStxR5JXUofTsa
	uqyXGd5IoJkJuhiwhGCpZQbmUc/WqtPjhfRuWW7V8mc4M1reFzUKb6sEt2hwAYwMTcz9gP
	Du3zPOcie9B67TZSxQIOzwFu1NmQXENb2gVjdOXapC+vkrq9aQrPanb+yiiZtV6tMcYqF7
	zz3t4Qsyy6QCU6SHVdf9mcdFjH3HjzZoXZU09eo9TT2gSi4PwCRpkLBXjJK5Eg==
Date: Mon, 16 Oct 2023 17:36:52 +0200
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
Message-ID: <20231016173652.364997ae@xps-13>
In-Reply-To: <20231016155858.7af3490b@xps-13>
References: <20231012193410.3d1812cf@xps-13>
	<ZShLX/ghL/b1Gbyz@shell.armlinux.org.uk>
	<20231013104003.260cc2f1@xps-13>
	<CANn89iKC9apkRG80eBPqsdKEkdawKzGt9EsBRLm61H=4Nn4jQQ@mail.gmail.com>
	<20231016155858.7af3490b@xps-13>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello again,

> > > # iperf3 -c 192.168.1.1
> > > Connecting to host 192.168.1.1, port 5201
> > > [  5] local 192.168.1.2 port 37948 connected to 192.168.1.1 port 5201
> > > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > > [  5]   0.00-1.00   sec  11.3 MBytes  94.5 Mbits/sec   43   32.5 KByt=
es
> > > [  5]   1.00-2.00   sec  3.29 MBytes  27.6 Mbits/sec   26   1.41 KByt=
es
> > > [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> > > [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> > > [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    5   1.41 KBytes
> > > [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> > > [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> > > [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> > > [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> > > [  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> > >
> > > Thanks,
> > > Miqu=C3=A8l   =20
> >=20
> > Can you experiment with :
> >=20
> > - Disabling TSO on your NIC (ethtool -K eth0 tso off)
> > - Reducing max GSO size (ip link set dev eth0 gso_max_size 16384)
> >=20
> > I suspect some kind of issues with fec TX completion, vs TSO emulation.=
 =20
>=20
> Wow, appears to have a significant effect. I am using Busybox's iproute
> implementation which does not know gso_max_size, but I hacked directly
> into netdevice.h just to see if it would have an effect. I'm adding
> iproute2 to the image for further testing.
>=20
> Here is the diff:
>=20
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2364,7 +2364,7 @@ struct net_device {
>  /* TCP minimal MSS is 8 (TCP_MIN_GSO_SIZE),
>   * and shinfo->gso_segs is a 16bit field.
>   */
> -#define GSO_MAX_SIZE           (8 * GSO_MAX_SEGS)
> +#define GSO_MAX_SIZE           16384u
> =20
>         unsigned int            gso_max_size;
>  #define TSO_LEGACY_MAX_SIZE    65536
>=20
> And here are the results:
>=20
> # ethtool -K eth0 tso off
> # iperf3 -c 192.168.1.1 -u -b1M
> Connecting to host 192.168.1.1, port 5201
> [  5] local 192.168.1.2 port 50490 connected to 192.168.1.1 port 5201
> [ ID] Interval           Transfer     Bitrate         Total Datagrams
> [  5]   0.00-1.00   sec   123 KBytes  1.01 Mbits/sec  87 =20
> [  5]   1.00-2.00   sec   122 KBytes   996 Kbits/sec  86 =20
> [  5]   2.00-3.00   sec   122 KBytes   996 Kbits/sec  86 =20
> [  5]   3.00-4.00   sec   123 KBytes  1.01 Mbits/sec  87 =20
> [  5]   4.00-5.00   sec   122 KBytes   996 Kbits/sec  86 =20
> [  5]   5.00-6.00   sec   122 KBytes   996 Kbits/sec  86 =20
> [  5]   6.00-7.00   sec   123 KBytes  1.01 Mbits/sec  87 =20
> [  5]   7.00-8.00   sec   122 KBytes   996 Kbits/sec  86 =20
> [  5]   8.00-9.00   sec   122 KBytes   996 Kbits/sec  86 =20
> [  5]   9.00-10.00  sec   123 KBytes  1.01 Mbits/sec  87 =20
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Tota=
l Datagrams
> [  5]   0.00-10.00  sec  1.19 MBytes  1.00 Mbits/sec  0.000 ms  0/864 (0%=
)  sender
> [  5]   0.00-10.05  sec  1.11 MBytes   925 Kbits/sec  0.045 ms  62/864 (7=
.2%)  receiver
> iperf Done.
> # iperf3 -c 192.168.1.1
> Connecting to host 192.168.1.1, port 5201
> [  5] local 192.168.1.2 port 34792 connected to 192.168.1.1 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  1.63 MBytes  13.7 Mbits/sec   30   1.41 KBytes  =
    =20
> [  5]   1.00-2.00   sec  7.40 MBytes  62.1 Mbits/sec   65   14.1 KBytes  =
    =20
> [  5]   2.00-3.00   sec  7.83 MBytes  65.7 Mbits/sec  109   2.83 KBytes  =
    =20
> [  5]   3.00-4.00   sec  2.49 MBytes  20.9 Mbits/sec   46   19.8 KBytes  =
    =20
> [  5]   4.00-5.00   sec  7.89 MBytes  66.2 Mbits/sec  109   2.83 KBytes  =
    =20
> [  5]   5.00-6.00   sec   255 KBytes  2.09 Mbits/sec   22   2.83 KBytes  =
    =20
> [  5]   6.00-7.00   sec  4.35 MBytes  36.5 Mbits/sec   74   41.0 KBytes  =
    =20
> [  5]   7.00-8.00   sec  10.9 MBytes  91.8 Mbits/sec   34   45.2 KBytes  =
    =20
> [  5]   8.00-9.00   sec  5.35 MBytes  44.9 Mbits/sec   82   1.41 KBytes  =
    =20
> [  5]   9.00-10.00  sec  1.37 MBytes  11.5 Mbits/sec   73   1.41 KBytes  =
    =20
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  49.5 MBytes  41.5 Mbits/sec  644             sen=
der
> [  5]   0.00-10.05  sec  49.3 MBytes  41.1 Mbits/sec                  rec=
eiver
> iperf Done.
>=20
> There is still a noticeable amount of drop/retries, but overall the
> results are significantly better. What is the rationale behind the
> choice of 16384 in particular? Could this be further improved?

Apparently I've been too enthusiastic. After sending this e-mail I've
re-generated an image with iproute2 and dd'ed the whole image into an
SD card, while until now I was just updating the kernel/DT manually and
got the same performances as above without the gro size trick. I need
to clarify this further.

Thanks,
Miqu=C3=A8l


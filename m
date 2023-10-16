Return-Path: <netdev+bounces-41270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A957CA6F0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE2D1C20921
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0CC26289;
	Mon, 16 Oct 2023 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uv3le9s9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC22374B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:49:39 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532A38E
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:49:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso11445a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697456977; x=1698061777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEX5zrpyMdwRIdbfwotTwx8XZX2avSRBXqOChiuPkBw=;
        b=uv3le9s9WOsS/Gxhyf9PqYtXflJNz6C1XGnTJkTRSXuaTmg6I2Mio6oslGnuM2gm8i
         EB5H9qIsGQ2JVq9BAyEeobMJnPUMoZpV1xacf1O/N1sgmc4DFwYy1krLCbYS+2we3y4o
         LvxbuHygNMWcPLzE2HYJWEEJK1iRPwzw9DrtuPkkTIQzSnyWMRSPzbktEBmuqrFfBwNh
         Ol1kzsB9ohkgItE82eg2avAsDAGA+s61MAqvnCRTqgPkx2xhw9/a6tCWESroZS5eMidy
         /U1yp5JqgMztFhiupMQUPp5XkJHTXGDpcaQaufceE6RzpdUPzBIki16F0ZZJLnmizo0W
         V6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697456977; x=1698061777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEX5zrpyMdwRIdbfwotTwx8XZX2avSRBXqOChiuPkBw=;
        b=L1FEw/sXKC/CAPcV7/W6C26xc3qCoWI+XRd0HKcBtZ1tsMN+laceMIb/1S/GKr2fHo
         2I706kxoHh8tHMHV1WZh7uEhaXCCtj55/qlZkVQXPasWMaT4cWIGArirMU/iwrSKk/vr
         aJPkFpv8zGuyZV10b9kZbmf0xg4lZ+MJWllu25j7hFXh9UPnESi5kyKE/c7jcUBol7D7
         /7I+S4hPgQUPT7vYkVtg/MY25BQ0ef0qCifuzhXYhRa+idHpF1xE/gzGAzMa0bdeRjwf
         cx8aU1tGT38IA/jQ4T9lNxE8VDYLQ3FUtCm7j9hi2vsQJaMjskqQU67vrqU0EELEBFAO
         RO8A==
X-Gm-Message-State: AOJu0Yx+EeL8c8O04cni2xWcdyA7gaRa78Ktf3jumxQ0DV/lSFD3Tkrx
	JVmDLG1Tdo+m6HlUAt8fl8osPneJGrHRcIXKHdsJIA==
X-Google-Smtp-Source: AGHT+IE8p9x+IaRlBRGwTOleiI7YtoJoSXnsgGQNoJO3f+adTjyplVTxhAzUAiJiH5gTm4ojgX/8hzyWo6tniQaPc9g=
X-Received: by 2002:a50:fa99:0:b0:53e:7ad7:6d47 with SMTP id
 w25-20020a50fa99000000b0053e7ad76d47mr147913edr.5.1697456976528; Mon, 16 Oct
 2023 04:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012193410.3d1812cf@xps-13> <ZShLX/ghL/b1Gbyz@shell.armlinux.org.uk>
 <20231013104003.260cc2f1@xps-13>
In-Reply-To: <20231013104003.260cc2f1@xps-13>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 13:49:25 +0200
Message-ID: <CANn89iKC9apkRG80eBPqsdKEkdawKzGt9EsBRLm61H=4Nn4jQQ@mail.gmail.com>
Subject: Re: Ethernet issue on imx6
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, linux-imx@nxp.com, netdev@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 10:40=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Russell,
>
> linux@armlinux.org.uk wrote on Thu, 12 Oct 2023 20:39:11 +0100:
>
> > On Thu, Oct 12, 2023 at 07:34:10PM +0200, Miquel Raynal wrote:
> > > Hello,
> > >
> > > I've been scratching my foreheads for weeks on a strange imx6
> > > network issue, I need help to go further, as I feel a bit clueless no=
w.
> > >
> > > Here is my setup :
> > > - Custom imx6q board
> > > - Bootloader: U-Boot 2017.11 (also tried with a 2016.03)
> > > - Kernel : 4.14(.69,.146,.322), v5.10 and v6.5 with the same behavior
> > > - The MAC (fec driver) is connected to a Micrel 9031 PHY
> > > - The PHY is connected to the link partner through an industrial cabl=
e
> >
> > "industrial cable" ?
>
> It is a "unique" hardware cable, the four Ethernet pairs are foiled
> twisted pair each and the whole cable is shielded. Additionally there
> is the 24V power supply coming from this cable. The connector is from
> ODU S22LOC-P16MCD0-920S. The structure of the cable should be similar
> to a CAT7 cable with the additional power supply line.
>
> > > - Testing 100BASE-T (link is stable)
> >
> > Would that be full or half duplex?
>
> Ah, yeah, sorry for forgetting this detail, it's full duplex.
>
> > > The RGMII-ID timings are probably not totally optimal but offer
> > > rather good performance. In UDP with iperf3:
> > > * Downlink (host to the board) runs at full speed with 0% drop
> > > * Uplink (board to host) runs at full speed with <1% drop
> > >
> > > However, if I ever try to limit the bandwidth in uplink (only), the
> > > drop rate rises significantly, up to 30%:
> > >
> > > //192.168.1.1 is my host, so the below lines are from the board:
> > > # iperf3 -c 192.168.1.1 -u -b100M
> > > [  5]   0.00-10.05  sec   113 MBytes  94.6 Mbits/sec  0.044 ms
> > > 467/82603 (0.57%)  receiver # iperf3 -c 192.168.1.1 -u -b90M
> > > [  5]   0.00-10.04  sec  90.5 MBytes  75.6 Mbits/sec  0.146 ms
> > > 12163/77688 (16%)  receiver # iperf3 -c 192.168.1.1 -u -b80M
> > > [  5]   0.00-10.05  sec  66.4 MBytes  55.5 Mbits/sec  0.162 ms
> > > 20937/69055 (30%)  receiver
> >
> > My setup:
> >
> > i.MX6DL silicon rev 1.3
> > Atheros AR8035 PHY
> > 6.3.0+ (no significant changes to fec_main.c)
> > Link, being BASE-T, is standard RJ45.
> >
> > Connectivity is via a bridge device (sorry, can't change that as it
> > would be too disruptive, as this is my Internet router!)
> >
> > Running at 1000BASE-T (FD):
> > [ ID] Interval           Transfer     Bitrate         Jitter
> > Lost/Total Datagrams [  5]   0.00-10.01  sec   114 MBytes  95.4
> > Mbits/sec  0.030 ms  0/82363 (0%)  receiver [  5]   0.00-10.00  sec
> > 107 MBytes  90.0 Mbits/sec  0.103 ms  0/77691 (0%)  receiver [  5]
> > 0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.101 ms  0/69060 (0%)
> > receiver
> >
> > Running at 100BASE-Tx (FD):
> > [ ID] Interval           Transfer     Bitrate         Jitter
> > Lost/Total Datagrams [  5]   0.00-10.01  sec   114 MBytes  95.4
> > Mbits/sec  0.008 ms  0/82436 (0%)  receiver [  5]   0.00-10.00  sec
> > 107 MBytes  90.0 Mbits/sec  0.088 ms  0/77692 (0%)  receiver [  5]
> > 0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.108 ms  0/69058 (0%)
> > receiver
> >
> > Running at 100bASE-Tx (HD):
> > [ ID] Interval           Transfer     Bitrate         Jitter
> > Lost/Total Datagrams [  5]   0.00-10.01  sec   114 MBytes  95.3
> > Mbits/sec  0.056 ms  0/82304 (0%)  receiver [  5]   0.00-10.00  sec
> > 107 MBytes  90.0 Mbits/sec  0.101 ms  1/77691 (0.0013%)  receiver [
> > 5]   0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  0.105 ms  0/69058
> > (0%)  receiver
> >
> > So I'm afraid I don't see your issue.
>
> I believe the issue cannot be at an higher level than the MAC. I also
> do not think the MAC driver and PHY driver are specifically buggy. I
> ruled out the hardware issue given the fact that under certain
> conditions (high load) the network works rather well... But I certainly
> see this issue, and when switching to TCP the results are dramatic:
>
> # iperf3 -c 192.168.1.1
> Connecting to host 192.168.1.1, port 5201
> [  5] local 192.168.1.2 port 37948 connected to 192.168.1.1 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  11.3 MBytes  94.5 Mbits/sec   43   32.5 KBytes
> [  5]   1.00-2.00   sec  3.29 MBytes  27.6 Mbits/sec   26   1.41 KBytes
> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    5   1.41 KBytes
> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>
> Thanks,
> Miqu=C3=A8l

Can you experiment with :

- Disabling TSO on your NIC (ethtool -K eth0 tso off)
- Reducing max GSO size (ip link set dev eth0 gso_max_size 16384)

I suspect some kind of issues with fec TX completion, vs TSO emulation.


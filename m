Return-Path: <netdev+bounces-41888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F33A7CC1AF
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD05FB20F25
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6441A9A;
	Tue, 17 Oct 2023 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KROFIqFB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5838FA7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:19:09 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9AB0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:19:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A73711C0007;
	Tue, 17 Oct 2023 11:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697541545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKYjGjM0JAEPXJEzCVicRh6vAQJ2fXUoOnm9PQno80w=;
	b=KROFIqFBCtxxx2kzUmfQq0dSQQv/TlsHi2jDcdMqhePQBUXgLn0UuLONYJwvGcxIGgM2Tt
	5+oKgwPXjiOuhY43J+nh1VuBI0u+ROjAmyA0dOPE6Be415SueG+wsnQEVASElWP22J282t
	jhjIliKKJvEoM+i91FYZJ42UcaTXXRz+EDcx2S99U3Gq2LHbHl8I0h9Q/UKRW0SFA3K2+2
	ddcskhrHpngBFytvOubWtmehMO0Z8KkqyGwsYFySiWtlUHK37ZvjENwnzlGsfOi3t57nWw
	1Ry8s1pR3XXQr+4YO1GK/cDIdD1vSbeZSwTmt+B6dT7AKpRbiW+hh3JLyRAevQ==
Date: Tue, 17 Oct 2023 13:19:01 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Wei Fang
 <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux-imx@nxp.com, netdev@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Stephen
 Hemminger <stephen@networkplumber.org>, Alexander Stein
 <alexander.stein@ew.tq-group.com>
Subject: Re: Ethernet issue on imx6
Message-ID: <20231017131901.5ae65e4d@xps-13>
In-Reply-To: <CANn89iLxKQOY5ZA5o3d1y=v4MEAsAQnzmVDjmLY0_bJPG93tKQ@mail.gmail.com>
References: <20231012193410.3d1812cf@xps-13>
	<ZShLX/ghL/b1Gbyz@shell.armlinux.org.uk>
	<20231013104003.260cc2f1@xps-13>
	<CANn89iKC9apkRG80eBPqsdKEkdawKzGt9EsBRLm61H=4Nn4jQQ@mail.gmail.com>
	<20231016155858.7af3490b@xps-13>
	<20231016173652.364997ae@xps-13>
	<CANn89iLxKQOY5ZA5o3d1y=v4MEAsAQnzmVDjmLY0_bJPG93tKQ@mail.gmail.com>
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
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

edumazet@google.com wrote on Mon, 16 Oct 2023 21:37:58 +0200:

> On Mon, Oct 16, 2023 at 5:37=E2=80=AFPM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Hello again,
> > =20
> > > > > # iperf3 -c 192.168.1.1
> > > > > Connecting to host 192.168.1.1, port 5201
> > > > > [  5] local 192.168.1.2 port 37948 connected to 192.168.1.1 port =
5201
> > > > > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > > > > [  5]   0.00-1.00   sec  11.3 MBytes  94.5 Mbits/sec   43   32.5 =
KBytes
> > > > > [  5]   1.00-2.00   sec  3.29 MBytes  27.6 Mbits/sec   26   1.41 =
KBytes
> > > > > [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KB=
ytes
> > > > > [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KB=
ytes
> > > > > [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    5   1.41 KB=
ytes
> > > > > [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KB=
ytes
> > > > > [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KB=
ytes
> > > > > [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KB=
ytes
> > > > > [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KB=
ytes
> > > > > [  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    0   1.41 KB=
ytes
> > > > >
> > > > > Thanks,
> > > > > Miqu=C3=A8l =20
> > > >
> > > > Can you experiment with :
> > > >
> > > > - Disabling TSO on your NIC (ethtool -K eth0 tso off)
> > > > - Reducing max GSO size (ip link set dev eth0 gso_max_size 16384)
> > > >
> > > > I suspect some kind of issues with fec TX completion, vs TSO emulat=
ion. =20
> > >
> > > Wow, appears to have a significant effect. I am using Busybox's iprou=
te
> > > implementation which does not know gso_max_size, but I hacked directly
> > > into netdevice.h just to see if it would have an effect. I'm adding
> > > iproute2 to the image for further testing.
> > >
> > > Here is the diff:
> > >
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -2364,7 +2364,7 @@ struct net_device {
> > >  /* TCP minimal MSS is 8 (TCP_MIN_GSO_SIZE),
> > >   * and shinfo->gso_segs is a 16bit field.
> > >   */
> > > -#define GSO_MAX_SIZE           (8 * GSO_MAX_SEGS)
> > > +#define GSO_MAX_SIZE           16384u
> > >
> > >         unsigned int            gso_max_size;
> > >  #define TSO_LEGACY_MAX_SIZE    65536
> > >
> > > And here are the results:
> > >
> > > # ethtool -K eth0 tso off
> > > # iperf3 -c 192.168.1.1 -u -b1M
> > > Connecting to host 192.168.1.1, port 5201
> > > [  5] local 192.168.1.2 port 50490 connected to 192.168.1.1 port 5201
> > > [ ID] Interval           Transfer     Bitrate         Total Datagrams
> > > [  5]   0.00-1.00   sec   123 KBytes  1.01 Mbits/sec  87
> > > [  5]   1.00-2.00   sec   122 KBytes   996 Kbits/sec  86
> > > [  5]   2.00-3.00   sec   122 KBytes   996 Kbits/sec  86
> > > [  5]   3.00-4.00   sec   123 KBytes  1.01 Mbits/sec  87
> > > [  5]   4.00-5.00   sec   122 KBytes   996 Kbits/sec  86
> > > [  5]   5.00-6.00   sec   122 KBytes   996 Kbits/sec  86
> > > [  5]   6.00-7.00   sec   123 KBytes  1.01 Mbits/sec  87
> > > [  5]   7.00-8.00   sec   122 KBytes   996 Kbits/sec  86
> > > [  5]   8.00-9.00   sec   122 KBytes   996 Kbits/sec  86
> > > [  5]   9.00-10.00  sec   123 KBytes  1.01 Mbits/sec  87
> > > - - - - - - - - - - - - - - - - - - - - - - - - -
> > > [ ID] Interval           Transfer     Bitrate         Jitter    Lost/=
Total Datagrams
> > > [  5]   0.00-10.00  sec  1.19 MBytes  1.00 Mbits/sec  0.000 ms  0/864=
 (0%)  sender
> > > [  5]   0.00-10.05  sec  1.11 MBytes   925 Kbits/sec  0.045 ms  62/86=
4 (7.2%)  receiver
> > > iperf Done.
> > > # iperf3 -c 192.168.1.1
> > > Connecting to host 192.168.1.1, port 5201
> > > [  5] local 192.168.1.2 port 34792 connected to 192.168.1.1 port 5201
> > > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > > [  5]   0.00-1.00   sec  1.63 MBytes  13.7 Mbits/sec   30   1.41 KByt=
es
> > > [  5]   1.00-2.00   sec  7.40 MBytes  62.1 Mbits/sec   65   14.1 KByt=
es
> > > [  5]   2.00-3.00   sec  7.83 MBytes  65.7 Mbits/sec  109   2.83 KByt=
es
> > > [  5]   3.00-4.00   sec  2.49 MBytes  20.9 Mbits/sec   46   19.8 KByt=
es
> > > [  5]   4.00-5.00   sec  7.89 MBytes  66.2 Mbits/sec  109   2.83 KByt=
es
> > > [  5]   5.00-6.00   sec   255 KBytes  2.09 Mbits/sec   22   2.83 KByt=
es
> > > [  5]   6.00-7.00   sec  4.35 MBytes  36.5 Mbits/sec   74   41.0 KByt=
es
> > > [  5]   7.00-8.00   sec  10.9 MBytes  91.8 Mbits/sec   34   45.2 KByt=
es
> > > [  5]   8.00-9.00   sec  5.35 MBytes  44.9 Mbits/sec   82   1.41 KByt=
es
> > > [  5]   9.00-10.00  sec  1.37 MBytes  11.5 Mbits/sec   73   1.41 KByt=
es
> > > - - - - - - - - - - - - - - - - - - - - - - - - -
> > > [ ID] Interval           Transfer     Bitrate         Retr
> > > [  5]   0.00-10.00  sec  49.5 MBytes  41.5 Mbits/sec  644            =
 sender
> > > [  5]   0.00-10.05  sec  49.3 MBytes  41.1 Mbits/sec                 =
 receiver
> > > iperf Done.
> > >
> > > There is still a noticeable amount of drop/retries, but overall the
> > > results are significantly better. What is the rationale behind the
> > > choice of 16384 in particular? Could this be further improved? =20
> >
> > Apparently I've been too enthusiastic. After sending this e-mail I've
> > re-generated an image with iproute2 and dd'ed the whole image into an
> > SD card, while until now I was just updating the kernel/DT manually and
> > got the same performances as above without the gro size trick. I need
> > to clarify this further.
> > =20
>=20
> Looking a bit at fec, I think fec_enet_txq_put_hdr_tso() is  bogus...
>=20
> txq->tso_hdrs should be properly aligned by definition.
>=20
> If FEC_QUIRK_SWAP_FRAME is requested, better copy the right thing, not
> original skb->data ???

I've clarified the situation after looking at the build artifacts and
going through (way) longer testing sessions, as successive 10-second
tests can lead to really different results.

On a 4.14.322 kernel (still maintained) I really get extremely crappy
throughput.

On a mainline 6.5 kernel I thought I had a similar issue but this was
due to wrong RGMII-ID timings being used (I ported the board from 4.14
to 6.5 and made a mistake). So with the right timings, I get
much better throughput but still significantly low compared to what I
would expect.

So I tested Eric's fixes:
- TCP fix:
https://lore.kernel.org/netdev/CANn89iJUBujG2AOBYsr0V7qyC5WTgzx0GucO=3D2ES6=
9tTDJRziw@mail.gmail.com/
- FEC fix:
https://lore.kernel.org/netdev/CANn89iLxKQOY5ZA5o3d1y=3Dv4MEAsAQnzmVDjmLY0_=
bJPG93tKQ@mail.gmail.com/
As well as different CPUfreq/CPUidle parameters, as pointed out by
Alexander:
https://lore.kernel.org/netdev/2245614.iZASKD2KPV@steina-w/

Here are the results of 100 seconds iperf uplink TCP tests, as reported
by the receiver. First value is the mean, the raw results are in the '(' ')=
'.
Unit: Mbps

Default setup:
CPUidle yes, CPUfreq yes, TCP fix no, FEC fix no: 30.2 (23.8, 28.4, 38.4)

CPU power management tests (with TCP fix and FEC fix):
CPUidle yes, CPUfreq yes: 26.5 (24.5, 28.5)
CPUidle  no, CPUfreq yes: 50.3 (44.8, 55.7)
CPUidle yes, CPUfreq  no: 80.2 (75.8, 79.5, 80.8, 81.8, 83.1)
CPUidle  no, CPUfreq  no: 85.4 (80.6, 81.1, 86.2, 87.5, 91.8)

Eric's fixes tests (No CPUidle, no CPUfreq):
TCP fix yes, FEC fix yes: 85.4 (80.6, 81.1, 86.2, 87.5, 91.8) (same as abov=
e)
TCP fix  no, FEC fix yes: 82.0 (74.5, 75.9, 82.2, 87.5, 90.2)
TCP fix yes, FEC fix  no: 81.4 (77.5, 77.7, 82.8, 83.7, 85.4)
TCP fix  no, FEC fix  no: 79.6 (68.2, 77.6, 78.9, 86.4, 87.1)

So indeed the TCP and FEC patches don't seem to have a real impact (or
a small one, I don't know given how scattered are the results). However
there is definitely something wrong with the low power settings and I
believe the Errata pointed by Alexander may have a real impact there
(ERR006687 ENET: Only the ENET wake-up interrupt request can wake the
system from Wait mode [i.MX 6Dual/6Quad Only]), probably that my
hardware lacks the hardware workaround.

I believe the remaining fluctuations are due to the RGMII-ID timings
not being totally optimal, I think I would need to extend them slightly
more in the Tx path but they are already set to the maximum value.
Anyhow, I no longer see any difference in the drop rate between -b1M
and -b0 (<1%) so I believe it is acceptable like that.

Now I might try to track what is missing in 4.14.322 and perhaps ask
for a backport if it's relevant.

Thanks a lot for all your feedback,
Miqu=C3=A8l


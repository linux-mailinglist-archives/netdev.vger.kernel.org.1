Return-Path: <netdev+bounces-41534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264477CB363
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C111C2092A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1536347CA;
	Mon, 16 Oct 2023 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edfZ3XHB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C331A93
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:38:16 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70F83
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:38:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so2744a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697485092; x=1698089892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcz5h378Gwpkyz9TNE0/XViSOWaW+r6S1HYKj0gevJA=;
        b=edfZ3XHBUDVdxabRTGc0pSlSIoCP33v7d+cfmE35gnzsvXbE5+ZAsEhP6rDa0E2lUj
         ot8d45FxM7trPaFVDcz9Ar0KlAUGsRU1J/CYx2/15aFG+766heq5k7SJj4jDFgQJrCed
         Bes6U6QgshgPgI1axWNYAE204akPmg9aGBgiyLW3VdV5s+BIBN+nEMC5dn8YgOcpoh98
         Xjxf0A0UhbEiPFshy+tGwqUuM+lGucLWvtW2rnfjXESN90gd8KTJ62brUX5I/NUtNMNX
         OC6wivV3ZG3FwPoW4xmSUITZWUP50k3iL+R1J+5LQ++K6HCN51C8Tb5wDdDsccNXpvpD
         /ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697485092; x=1698089892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcz5h378Gwpkyz9TNE0/XViSOWaW+r6S1HYKj0gevJA=;
        b=j6bwmO3DzQ0Xvgi0UjIueSzMQUUkEU9sgPaa+XZEEtqgStuGu+msdMjoEiqPpjqPLw
         nNnFQrrLGRHhtOX2dtOKBJB9m7dZXyT3DA7Dgi/uHPubFHtHegNFc8Gq4vw4Dt6vz1g0
         3/A8eEL/YwQ/00cJbeqEUejH4z40BrryKdc4DWj1mPD7o223T6ikrTbUJ3RxPHfofTXa
         oNKeYRHn97V73ANYqetOodc+LdJfqIKLdxb+xVFOvfv9b4IN58qNRapR556ONXRjH38X
         AAPWqKqaSAVUN4cocLCTIwaNHWp7GB4BsSceXbC8STMrLHQUPEI00HtNvmjpwqHegE03
         2RJQ==
X-Gm-Message-State: AOJu0YwyfW2GnFbTcFvVlSQZWnCpm+n9Rg/hRqSOfOU0j0zA6Prre7QE
	gUJOCRrHITUYjZIlVGbym21nOG3z7H+TfUBw/MdwOA==
X-Google-Smtp-Source: AGHT+IFAs2HujH7i9wikB4uGIGEulACqBA79jXBajRNZqhsDnOeALkPYdApVbOxcsnU0DKvIyb4nKMuUVYoAlRiIdno=
X-Received: by 2002:a50:8ad6:0:b0:522:4741:d992 with SMTP id
 k22-20020a508ad6000000b005224741d992mr20837edk.4.1697485092339; Mon, 16 Oct
 2023 12:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012193410.3d1812cf@xps-13> <ZShLX/ghL/b1Gbyz@shell.armlinux.org.uk>
 <20231013104003.260cc2f1@xps-13> <CANn89iKC9apkRG80eBPqsdKEkdawKzGt9EsBRLm61H=4Nn4jQQ@mail.gmail.com>
 <20231016155858.7af3490b@xps-13> <20231016173652.364997ae@xps-13>
In-Reply-To: <20231016173652.364997ae@xps-13>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 21:37:58 +0200
Message-ID: <CANn89iLxKQOY5ZA5o3d1y=v4MEAsAQnzmVDjmLY0_bJPG93tKQ@mail.gmail.com>
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 5:37=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hello again,
>
> > > > # iperf3 -c 192.168.1.1
> > > > Connecting to host 192.168.1.1, port 5201
> > > > [  5] local 192.168.1.2 port 37948 connected to 192.168.1.1 port 52=
01
> > > > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > > > [  5]   0.00-1.00   sec  11.3 MBytes  94.5 Mbits/sec   43   32.5 KB=
ytes
> > > > [  5]   1.00-2.00   sec  3.29 MBytes  27.6 Mbits/sec   26   1.41 KB=
ytes
> > > > [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KByt=
es
> > > > [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KByt=
es
> > > > [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    5   1.41 KByt=
es
> > > > [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KByt=
es
> > > > [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KByt=
es
> > > > [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KByt=
es
> > > > [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KByt=
es
> > > > [  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    0   1.41 KByt=
es
> > > >
> > > > Thanks,
> > > > Miqu=C3=A8l
> > >
> > > Can you experiment with :
> > >
> > > - Disabling TSO on your NIC (ethtool -K eth0 tso off)
> > > - Reducing max GSO size (ip link set dev eth0 gso_max_size 16384)
> > >
> > > I suspect some kind of issues with fec TX completion, vs TSO emulatio=
n.
> >
> > Wow, appears to have a significant effect. I am using Busybox's iproute
> > implementation which does not know gso_max_size, but I hacked directly
> > into netdevice.h just to see if it would have an effect. I'm adding
> > iproute2 to the image for further testing.
> >
> > Here is the diff:
> >
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2364,7 +2364,7 @@ struct net_device {
> >  /* TCP minimal MSS is 8 (TCP_MIN_GSO_SIZE),
> >   * and shinfo->gso_segs is a 16bit field.
> >   */
> > -#define GSO_MAX_SIZE           (8 * GSO_MAX_SEGS)
> > +#define GSO_MAX_SIZE           16384u
> >
> >         unsigned int            gso_max_size;
> >  #define TSO_LEGACY_MAX_SIZE    65536
> >
> > And here are the results:
> >
> > # ethtool -K eth0 tso off
> > # iperf3 -c 192.168.1.1 -u -b1M
> > Connecting to host 192.168.1.1, port 5201
> > [  5] local 192.168.1.2 port 50490 connected to 192.168.1.1 port 5201
> > [ ID] Interval           Transfer     Bitrate         Total Datagrams
> > [  5]   0.00-1.00   sec   123 KBytes  1.01 Mbits/sec  87
> > [  5]   1.00-2.00   sec   122 KBytes   996 Kbits/sec  86
> > [  5]   2.00-3.00   sec   122 KBytes   996 Kbits/sec  86
> > [  5]   3.00-4.00   sec   123 KBytes  1.01 Mbits/sec  87
> > [  5]   4.00-5.00   sec   122 KBytes   996 Kbits/sec  86
> > [  5]   5.00-6.00   sec   122 KBytes   996 Kbits/sec  86
> > [  5]   6.00-7.00   sec   123 KBytes  1.01 Mbits/sec  87
> > [  5]   7.00-8.00   sec   122 KBytes   996 Kbits/sec  86
> > [  5]   8.00-9.00   sec   122 KBytes   996 Kbits/sec  86
> > [  5]   9.00-10.00  sec   123 KBytes  1.01 Mbits/sec  87
> > - - - - - - - - - - - - - - - - - - - - - - - - -
> > [ ID] Interval           Transfer     Bitrate         Jitter    Lost/To=
tal Datagrams
> > [  5]   0.00-10.00  sec  1.19 MBytes  1.00 Mbits/sec  0.000 ms  0/864 (=
0%)  sender
> > [  5]   0.00-10.05  sec  1.11 MBytes   925 Kbits/sec  0.045 ms  62/864 =
(7.2%)  receiver
> > iperf Done.
> > # iperf3 -c 192.168.1.1
> > Connecting to host 192.168.1.1, port 5201
> > [  5] local 192.168.1.2 port 34792 connected to 192.168.1.1 port 5201
> > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > [  5]   0.00-1.00   sec  1.63 MBytes  13.7 Mbits/sec   30   1.41 KBytes
> > [  5]   1.00-2.00   sec  7.40 MBytes  62.1 Mbits/sec   65   14.1 KBytes
> > [  5]   2.00-3.00   sec  7.83 MBytes  65.7 Mbits/sec  109   2.83 KBytes
> > [  5]   3.00-4.00   sec  2.49 MBytes  20.9 Mbits/sec   46   19.8 KBytes
> > [  5]   4.00-5.00   sec  7.89 MBytes  66.2 Mbits/sec  109   2.83 KBytes
> > [  5]   5.00-6.00   sec   255 KBytes  2.09 Mbits/sec   22   2.83 KBytes
> > [  5]   6.00-7.00   sec  4.35 MBytes  36.5 Mbits/sec   74   41.0 KBytes
> > [  5]   7.00-8.00   sec  10.9 MBytes  91.8 Mbits/sec   34   45.2 KBytes
> > [  5]   8.00-9.00   sec  5.35 MBytes  44.9 Mbits/sec   82   1.41 KBytes
> > [  5]   9.00-10.00  sec  1.37 MBytes  11.5 Mbits/sec   73   1.41 KBytes
> > - - - - - - - - - - - - - - - - - - - - - - - - -
> > [ ID] Interval           Transfer     Bitrate         Retr
> > [  5]   0.00-10.00  sec  49.5 MBytes  41.5 Mbits/sec  644             s=
ender
> > [  5]   0.00-10.05  sec  49.3 MBytes  41.1 Mbits/sec                  r=
eceiver
> > iperf Done.
> >
> > There is still a noticeable amount of drop/retries, but overall the
> > results are significantly better. What is the rationale behind the
> > choice of 16384 in particular? Could this be further improved?
>
> Apparently I've been too enthusiastic. After sending this e-mail I've
> re-generated an image with iproute2 and dd'ed the whole image into an
> SD card, while until now I was just updating the kernel/DT manually and
> got the same performances as above without the gro size trick. I need
> to clarify this further.
>

Looking a bit at fec, I think fec_enet_txq_put_hdr_tso() is  bogus...

txq->tso_hdrs should be properly aligned by definition.

If FEC_QUIRK_SWAP_FRAME is requested, better copy the right thing, not
original skb->data ???

diff --git a/drivers/net/ethernet/freescale/fec_main.c
b/drivers/net/ethernet/freescale/fec_main.c
index 77c8e9cfb44562e73bfa89d06c5d4b179d755502..520436d579d66cc3263527373d7=
54a206cb5bcd6
100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -753,7 +753,6 @@ fec_enet_txq_put_hdr_tso(struct fec_enet_priv_tx_q *txq=
,
        struct fec_enet_private *fep =3D netdev_priv(ndev);
        int hdr_len =3D skb_tcp_all_headers(skb);
        struct bufdesc_ex *ebdp =3D container_of(bdp, struct bufdesc_ex, de=
sc);
-       void *bufaddr;
        unsigned long dmabuf;
        unsigned short status;
        unsigned int estatus =3D 0;
@@ -762,11 +761,11 @@ fec_enet_txq_put_hdr_tso(struct fec_enet_priv_tx_q *t=
xq,
        status &=3D ~BD_ENET_TX_STATS;
        status |=3D (BD_ENET_TX_TC | BD_ENET_TX_READY);

-       bufaddr =3D txq->tso_hdrs + index * TSO_HEADER_SIZE;
        dmabuf =3D txq->tso_hdrs_dma + index * TSO_HEADER_SIZE;
-       if (((unsigned long)bufaddr) & fep->tx_align ||
-               fep->quirks & FEC_QUIRK_SWAP_FRAME) {
-               memcpy(txq->tx_bounce[index], skb->data, hdr_len);
+       if (fep->quirks & FEC_QUIRK_SWAP_FRAME) {
+               void *bufaddr =3D txq->tso_hdrs + index * TSO_HEADER_SIZE;
+
+               memcpy(txq->tx_bounce[index], bufaddr, hdr_len);
                bufaddr =3D txq->tx_bounce[index];

                if (fep->quirks & FEC_QUIRK_SWAP_FRAME)


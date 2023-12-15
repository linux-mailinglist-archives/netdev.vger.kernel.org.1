Return-Path: <netdev+bounces-57889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A188146A8
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A535BB23B8E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FFC208BD;
	Fri, 15 Dec 2023 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qP5QN/fE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB55250E8
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-552d1a24ce7so3879a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702639091; x=1703243891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5JzWASf9jMPLO1Q1A977u9mQNMOjvxdwjqETtYKs/I=;
        b=qP5QN/fE9jxpjYNCjGGJ5hAyLrFbcb8dRSLTM1gHLtzKzu+mzKIgN/jOOR8p/LzZhX
         PM6iusuF9X7ymtkzO+UaNij72PvOAnLfff2Qt3qWmrDd+TnwBHR4/PI2uF4yJGOX4iqC
         +bNt5OQAudEohoD5+Ng//Gp+5N/YVDZyRB2LTjQGmF+3+NazybK+xJfy+2hxno7oazOy
         xpgxrtrnSPJockUWskOl3RZOn2qzZa+nwUSDq+slUgFHWgvUAvVLAl3bq2IRgjdVyauu
         G2jD80aSKe5ThpOf0WAy4G20/sBsT7K4FAsLiXD+Wj2/ZDNJtLOvcJl6JgK38AP+sK8H
         wbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702639091; x=1703243891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5JzWASf9jMPLO1Q1A977u9mQNMOjvxdwjqETtYKs/I=;
        b=fWloEXIt9Wh5JP5l8RoGDezTp6kbkZyHmRsVKZrXCroJRDFcPXjCAZY5W60DDJMnQz
         lVZDtNrB5FgdeV71x5yEs+0uQWSgORC5HNv3Xf1G58G8IV6p3ThC9f9trBW5iNAAKhrZ
         Xgrq1oNZZf5QPtg4dGplLoLQ/fo55fMLR4eemYn39EgWomkBMDryziDf7owvC2ZmBWty
         h+Ca4lp4TG/VFSmC5aTmb3Sx+SZGPrMUCwitRwIIThtQ5B63ab+H3JIZalTI0bAZB5nX
         tQSVwuuZa7I6/OU2XmZyPZTP6oGtrxwCqsX6DdlpOUGWyYph5X4+1yF5plzsEpS1w5h8
         o45A==
X-Gm-Message-State: AOJu0YwXa9tCP4yN+JKIafLzNG+U/VyJd+qpf744Bi6C4Tw3WIDoq9eF
	t0G+qLCzImaBhI287nOlLdE0vW+CflekccXJM6FHGuGa50bWU243gW4=
X-Google-Smtp-Source: AGHT+IHHasFIcofykcXZNC3k8hP4LOgW+AsG+H1e7XkVB6vk0e0BfwVn9L//6/qEmTAiSTFYsFy6QYTlCSze9MtmBsE=
X-Received: by 2002:a50:c192:0:b0:54c:f4fd:3427 with SMTP id
 m18-20020a50c192000000b0054cf4fd3427mr772015edf.7.1702639090701; Fri, 15 Dec
 2023 03:18:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org>
 <20231215-new-gemini-ethernet-regression-v1-1-93033544be23@linaro.org> <CANn89iJo8ER1kZYB7La1jx5p00FrHxzSLnSsWcMNdj8-iG9_Rw@mail.gmail.com>
In-Reply-To: <CANn89iJo8ER1kZYB7La1jx5p00FrHxzSLnSsWcMNdj8-iG9_Rw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Dec 2023 12:17:57 +0100
Message-ID: <CANn89iJLfxng1sYL5Zk0mknXpyYQPCp83m3KgD2KJ2_hKCpEUg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: ethernet: cortina: Drop software checksumming
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 10:32=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Dec 15, 2023 at 9:49=E2=80=AFAM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
> >
> > The recent change to allow large frames without hardware checksumming
> > slotted in software checksumming in the driver if hardware could not
> > do it.
> >
> > This will however upset TSO (TCP Segment Offloading). Typical
> > error dumps includes this:
> >
> > skb len=3D2961 headroom=3D222 headlen=3D66 tailroom=3D0
> > (...)
> > WARNING: CPU: 0 PID: 956 at net/core/dev.c:3259 skb_warn_bad_offload+0x=
7c/0x108
> > gemini-ethernet-port: caps=3D(0x0000010000154813, 0x00002007ffdd7889)
> >
> > And the packets do not go through.
> >
> > After investigating I drilled it down to the introduction of the
> > software checksumming in the driver.
> >
> > Since the segmenting of packets will be done by the hardware this
> > makes a bit of sense since in that case the hardware also needs to
> > be keeping track of the checksumming.
> >
> > That begs the question why large TCP or UDP packets also have to
> > bypass the checksumming (like e.g. ICMP does). If the hardware is
> > splitting it into smaller packets per-MTU setting, and checksumming
> > them, why is this happening then? I don't know. I know it is needed,
> > from tests: the OpenWrt webserver uhttpd starts sending big skb:s (up
> > to 2047 bytes, the max MTU) and above 1514 bytes it starts to fail
> > and hang unless the bypass bit is set: the frames are not getting
> > through.
> >
> > Keeping the size check but removing the software checksum makes things
> > work again. This was probably dubious to introduce in the first place.
> >
> > Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/net/ethernet/cortina/gemini.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethern=
et/cortina/gemini.c
> > index 78287cfcbf63..255fcffc1579 100644
> > --- a/drivers/net/ethernet/cortina/gemini.c
> > +++ b/drivers/net/ethernet/cortina/gemini.c
> > @@ -1145,7 +1145,6 @@ static int gmac_map_tx_bufs(struct net_device *ne=
tdev, struct sk_buff *skb,
> >         dma_addr_t mapping;
> >         unsigned short mtu;
> >         void *buffer;
> > -       int ret;
> >
> >         mtu  =3D ETH_HLEN;
> >         mtu +=3D netdev->mtu;
> > @@ -1166,14 +1165,7 @@ static int gmac_map_tx_bufs(struct net_device *n=
etdev, struct sk_buff *skb,
> >                  * checksum buffer is only 1518 bytes, so when the fram=
es get
> >                  * bigger they get truncated, or the last few bytes get
> >                  * overwritten by the FCS.
> > -                *
> > -                * Just use software checksumming and bypass on bigger =
frames.
> >                  */
> > -               if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > -                       ret =3D skb_checksum_help(skb);
> > -                       if (ret)
> > -                               return ret;
> > -               }
>
> If the hardware does not support checksumming for frames bigger than
> ETH_FRAME_LEN,
> then an appropriate mitigation would be to have an ndo_features_check() ?
>
> Depending on packet being gso or not, you would have to check skb->len
> or shinfo->gso_size
>
> The ndo_features_check could then take a more appropriate action
> (forcing GSO, and/or forcing software checksumming)
>
> This driver claims to support TSO, but I do not see it using
> shinfo->gso_size, something must be very wrong...
>
> I would simply remove this TSO part, before the driver really supports
> TSO properly.
>
> diff --git a/drivers/net/ethernet/cortina/gemini.c
> b/drivers/net/ethernet/cortina/gemini.c
> index 78287cfcbf6388f01bfab417c264f41f3a1a16f2..829cb69982fe1caf99b56363e=
9e0565fbaecc82e
> 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -79,8 +79,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=3Dnone,...,16=
=3Dall)");
>  #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)
>
>  #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
> -               NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
> -               NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
> +               NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM )
>
>  /**
>   * struct gmac_queue_page - page buffer per-page info


I do not have the datasheet for this NIC, but my naive attempt would
be something like:

diff --git a/drivers/net/ethernet/cortina/gemini.c
b/drivers/net/ethernet/cortina/gemini.c
index 78287cfcbf6388f01bfab417c264f41f3a1a16f2..3c902dac16f7d539349178ebc4a=
49c7e48edced5
100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1143,39 +1143,18 @@ static int gmac_map_tx_bufs(struct net_device
*netdev, struct sk_buff *skb,
        struct gmac_txdesc *txd;
        skb_frag_t *skb_frag;
        dma_addr_t mapping;
-       unsigned short mtu;
        void *buffer;
        int ret;

-       mtu  =3D ETH_HLEN;
-       mtu +=3D netdev->mtu;
-       if (skb->protocol =3D=3D htons(ETH_P_8021Q))
-               mtu +=3D VLAN_HLEN;
-
        word1 =3D skb->len;
        word3 =3D SOF_BIT;

-       if (word1 > mtu) {
+       if (skb_is_gso(skb)) {
                word1 |=3D TSS_MTU_ENABLE_BIT;
-               word3 |=3D mtu;
+               word3 |=3D skb_shinfo(skb)->gso_size;
        }

-       if (skb->len >=3D ETH_FRAME_LEN) {
-               /* Hardware offloaded checksumming isn't working on frames
-                * bigger than 1514 bytes. A hypothesis about this is that =
the
-                * checksum buffer is only 1518 bytes, so when the frames g=
et
-                * bigger they get truncated, or the last few bytes get
-                * overwritten by the FCS.
-                *
-                * Just use software checksumming and bypass on bigger fram=
es.
-                */
-               if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
-                       ret =3D skb_checksum_help(skb);
-                       if (ret)
-                               return ret;
-               }
-               word1 |=3D TSS_BYPASS_BIT;
-       } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
+       if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
                int tcp =3D 0;

                /* We do not switch off the checksumming on non TCP/UDP


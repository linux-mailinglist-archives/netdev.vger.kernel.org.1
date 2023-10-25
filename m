Return-Path: <netdev+bounces-44099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C47D6220
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5FC1C209C8
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 07:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5080156F5;
	Wed, 25 Oct 2023 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2bZchTL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A9F9EB
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:09:24 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768A412F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:09:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so5921a12.1
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698217759; x=1698822559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oKcZkCJZ3vMadyJwkx+VZZRIou4kmWYrhQe/5pf4UY=;
        b=U2bZchTLxi+zGeoiXgUeNTfoYj0F+gRp20igzT6HBYYWGSquDzvLyAJsqawiwEUHo/
         fg5DVQWLgIZRN5fSX0fc5/Q0UmiqgIyJEWlLM83KA5t4FO+csb0fBb4EE66vEYalWGfV
         MCT1l7sqjPKeNr0nqel2MQdWysTN0QB1a1PBmODfa9ynl6jvXTjC8rcz/8az/zxoKeJ9
         qeLICexttIcxHht+G89nCoCPU+X55srVLD5vSvJC+YVFUT8pTq3Dqjd60YFQrni3an3j
         RscuSpLHPUl6QEcIq2oYXuLZWlEyJ9xO3tSQbtCkUlPbJagriuSkfnzq17N+A6/qky25
         CFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698217759; x=1698822559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oKcZkCJZ3vMadyJwkx+VZZRIou4kmWYrhQe/5pf4UY=;
        b=c9xmGIaCoBGGwjNHkURXDNiUutyLupePL724/oPS3m/KPrXvuRs48duKpz3LrOsfRU
         Pk5BptGd+k+Qqq4pgBPhFMx9qytdozsV0AM+lOS3+Pyfg11XLHvloJzlJkhuW1UWDy4Z
         G21S9jYNnGe0W6P1oBxfD8lT+Wu3q3MGOHt1jiZXkBxvFm+ZH31Iayed0AcChGFeQNWi
         roL+ZXf/CgzX9H/bcNCCJvfgwL+CEoNO9jOb3j5cC8tynB/yXw/H9dZDgMAmV3WXQLtS
         NZfBmQX8muhOZ+WzuG8e1c8sFQwHf9VDbDgk8AmXqKMbY6aX8xAjApg2848+/Jk5xtkw
         2nng==
X-Gm-Message-State: AOJu0Yza08+WXgXK7zLDa6QoAbYxUVKklXrPr2/ihOFxYoLgyRmLSDCO
	cL8y9r4pa+t0eid/hSEP1w3pSX4e91c4dE5ClvHzj4eL3F6h+uClUQA=
X-Google-Smtp-Source: AGHT+IEp90Kr4wpSKXwvcAKIOY0G2IyNOZHugIkBVe3IhRAsAauCRBSuKXAxbsUV6LxohDUrGmTk32/RPc7DrBxlKwo=
X-Received: by 2002:aa7:df94:0:b0:540:e4c3:430 with SMTP id
 b20-20020aa7df94000000b00540e4c30430mr35625edy.6.1698217758653; Wed, 25 Oct
 2023 00:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024194958.3522281-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231024194958.3522281-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Oct 2023 09:09:06 +0200
Message-ID: <CANn89iKr52cVenLBYcOAdOKQiN+J1-gtwfnwuRuauJC0fJgFLQ@mail.gmail.com>
Subject: Re: [PATCH net] llc: verify mac len before reading mac header
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, Willem de Bruijn <willemb@google.com>, 
	syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:50=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> LLC reads the mac header with eth_hdr without verifying that the skb
> has an Ethernet header.
>
> Syzbot was able to enter llc_rcv on a tun device. Tun can insert
> packets without mac len and with user configurable skb->protocol
> (passing a tun_pi header when not configuring IFF_NO_PI).
>
>     BUG: KMSAN: uninit-value in llc_station_ac_send_test_r net/llc/llc_st=
ation.c:81 [inline]
>     BUG: KMSAN: uninit-value in llc_station_rcv+0x6fb/0x1290 net/llc/llc_=
station.c:111
>     llc_station_ac_send_test_r net/llc/llc_station.c:81 [inline]
>     llc_station_rcv+0x6fb/0x1290 net/llc/llc_station.c:111
>     llc_rcv+0xc5d/0x14a0 net/llc/llc_input.c:218
>     __netif_receive_skb_one_core net/core/dev.c:5523 [inline]
>     __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5637
>     netif_receive_skb_internal net/core/dev.c:5723 [inline]
>     netif_receive_skb+0x58/0x660 net/core/dev.c:5782
>     tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
>     tun_get_user+0x54c5/0x69c0 drivers/net/tun.c:2002
>
> Add a mac_len test before all three eth_hdr(skb) calls under net/llc.
>
> There are further uses in include/net/llc_pdu.h. All these are
> protected by a test skb->protocol =3D=3D ETH_P_802_2. Which does not
> protect against this tun scenario.
>
> But the mac_len test added in this patch in llc_fixup_skb will
> indirectly protect those too. That is called from llc_rcv before any
> other LLC code.
>
> It is tempting to just add a blanket mac_len check in llc_rcv, but
> not sure whether that could break valid LLC paths that do not assume
> an Ethernet header. 802.2 LLC may be used on top of non-802.3
> protocols in principle.
>
> Reported-by: syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com

Note that the syzbot report is still private in syzbot infra.

Reviewed-by: Eric Dumazet <edumazet@google.com>

> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>  net/llc/llc_input.c   | 10 ++++++++--
>  net/llc/llc_s_ac.c    |  3 +++
>  net/llc/llc_station.c |  3 +++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
> index 7cac441862e21..51bccfb00a9cd 100644
> --- a/net/llc/llc_input.c
> +++ b/net/llc/llc_input.c
> @@ -127,8 +127,14 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
>         skb->transport_header +=3D llc_len;
>         skb_pull(skb, llc_len);
>         if (skb->protocol =3D=3D htons(ETH_P_802_2)) {
> -               __be16 pdulen =3D eth_hdr(skb)->h_proto;
> -               s32 data_size =3D ntohs(pdulen) - llc_len;
> +               __be16 pdulen;
> +               s32 data_size;
> +
> +               if (skb->mac_len < ETH_HLEN)
> +                       return 0;
> +
> +               pdulen =3D eth_hdr(skb)->h_proto;
> +               data_size =3D ntohs(pdulen) - llc_len;
>
>                 if (data_size < 0 ||
>                     !pskb_may_pull(skb, data_size))
> diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
> index 79d1cef8f15a9..7923c064773cc 100644
> --- a/net/llc/llc_s_ac.c
> +++ b/net/llc/llc_s_ac.c
> @@ -153,6 +153,9 @@ int llc_sap_action_send_test_r(struct llc_sap *sap, s=
truct sk_buff *skb)
>         int rc =3D 1;
>         u32 data_size;
>
> +       if (skb->mac_len < ETH_HLEN)
> +               return 0;
> +
>         llc_pdu_decode_sa(skb, mac_da);
>         llc_pdu_decode_da(skb, mac_sa);
>         llc_pdu_decode_ssap(skb, &dsap);
> diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
> index 05c6ae0920534..f506542925109 100644
> --- a/net/llc/llc_station.c
> +++ b/net/llc/llc_station.c
> @@ -76,6 +76,9 @@ static int llc_station_ac_send_test_r(struct sk_buff *s=
kb)
>         u32 data_size;
>         struct sk_buff *nskb;
>
> +       if (skb->mac_len < ETH_HLEN)
> +               goto out;
> +
>         /* The test request command is type U (llc_len =3D 3) */
>         data_size =3D ntohs(eth_hdr(skb)->h_proto) - 3;
>         nskb =3D llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, data_siz=
e);
> --
> 2.42.0.758.gaed0368e0e-goog
>


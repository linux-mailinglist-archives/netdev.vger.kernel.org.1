Return-Path: <netdev+bounces-26994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A83779C79
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 04:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E84B281E19
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 02:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C3F10EF;
	Sat, 12 Aug 2023 02:02:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1563EDD
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:02:55 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE7530F8
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 19:02:54 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso38824661fa.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 19:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691805772; x=1692410572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLoaied3BYFl8wTjvc4TX17jjmPshfRNJOFScTJD0xU=;
        b=g6jQBNh3eon6X37aK/7/3xDnCHcm4gNU9BlBQqZs3F7S2JDxvU21I5nWjCmEP4iPWs
         DefEoe1AEMQSlp4irIik5UUT4MPz7le0staktJ5q8p0XRYjhg+5UbuMB714c4S51zzQQ
         RhJ32V7nHLnRLhtHgSf5yHMD5s+oA1LTB0gaVPpPHKtxiwrcDIhgH+QEaclIbjHct1IH
         scC1JessSPMtzh5ZMlr+70m9jQ854XuFX03jFOtqf0IwKQL0v9VcRr9YGwfuMtVx4zsA
         MV0LwBkYfjABpe69uL/ZPY06j4qL+qRa1yQ7MR0EZHSn1eZENqgib6r/KWgibxHZL6uD
         0v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691805772; x=1692410572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLoaied3BYFl8wTjvc4TX17jjmPshfRNJOFScTJD0xU=;
        b=hOjwFAyD04Fhyvrcs3HNokVQT6arzsSgNekzFH4TIsOGtDY29md5cGD0hWpEoconY1
         PWv4stc0epsudyTu6G76RZ/evyZPZjzLvrl7RY6dzktHU7E0iVNWpBvzIeCDKVX4sM0A
         bKOqZ7JXBYIoFkYKjTUiHaZr5PCu3iExwQz/e2FYwn/sw3q9FE4Ruqkg+QlAlUKyBM90
         e9d7p0EgFD/isB3ylAJ59nt+38Yj8e5+IY+rJJblRTxYmHu/gT0KnowY/ZpidK0uyAUR
         nR1rRLc/G4Jjc0dwqSIIlHc+pXg9hO1ldcuRbRNVPcXqRfkeVf2imdCs0nQCALFU2xcz
         bl/A==
X-Gm-Message-State: AOJu0Yz0sF+EDdKDGi3K2Q8h52e2MdUVVF1FuAzmr4Z3+JASaeoMOWaQ
	eK2zLHZ+m+Gtz3qKTLyd0w8ZMeWXTEp1lZBF1R8=
X-Google-Smtp-Source: AGHT+IGheOXEdOe2p+QGVaodAgTo+hLdVTqsK7E83uRRHg5U02r8Hkp2DLyY1G450Ir+N3HAWoPCYJNbR/dj/UQDmao=
X-Received: by 2002:a2e:3c11:0:b0:2b6:ded8:6fc1 with SMTP id
 j17-20020a2e3c11000000b002b6ded86fc1mr2749793lja.25.1691805772159; Fri, 11
 Aug 2023 19:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
 <20230801061932.10335-2-liangchen.linux@gmail.com> <b5b9df4f-35d8-f20d-6507-3c6c3fafb386@redhat.com>
In-Reply-To: <b5b9df4f-35d8-f20d-6507-3c6c3fafb386@redhat.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Sat, 12 Aug 2023 10:02:39 +0800
Message-ID: <CAKhg4tL+77169qQa6rZL6oLz9CFPUMA5uF+JBj+rcBSePUNQpg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 2/2] net: veth: Improving page pool pages recycling
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linyunsheng@huawei.com, brouer@redhat.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, daniel@iogearbox.net, ast@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 2:16=E2=80=AFAM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
> On 01/08/2023 08.19, Liang Chen wrote:
> [...]
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 509e901da41d..ea1b344e5db4 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> [...]
> > @@ -848,6 +850,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth=
_rq *rq,
> >               goto out;
> >       }
> >
> > +     skb_orig =3D skb;
> >       __skb_push(skb, skb->data - skb_mac_header(skb));
> >       if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
> >               goto drop;
> > @@ -862,9 +865,18 @@ static struct sk_buff *veth_xdp_rcv_skb(struct vet=
h_rq *rq,
> >       case XDP_PASS:
> >               break;
> >       case XDP_TX:
> > -             veth_xdp_get(xdp);
> > -             consume_skb(skb);
> > -             xdp->rxq->mem =3D rq->xdp_mem;
> > +             if (skb !=3D skb_orig) {
> > +                     xdp->rxq->mem =3D rq->xdp_mem_pp;
> > +                     kfree_skb_partial(skb, true);
> > +             } else if (!skb->pp_recycle) {
> > +                     xdp->rxq->mem =3D rq->xdp_mem;
> > +                     kfree_skb_partial(skb, true);
> > +             } else {
> > +                     veth_xdp_get(xdp);
> > +                     consume_skb(skb);
> > +                     xdp->rxq->mem =3D rq->xdp_mem;
> > +             }
> > +
>
> Above code section, and below section looks the same.
> It begs for a common function.
>
> >               if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
> >                       trace_xdp_exception(rq->dev, xdp_prog, act);
> >                       stats->rx_drops++;
> > @@ -874,9 +886,18 @@ static struct sk_buff *veth_xdp_rcv_skb(struct vet=
h_rq *rq,
> >               rcu_read_unlock();
> >               goto xdp_xmit;
> >       case XDP_REDIRECT:
> > -             veth_xdp_get(xdp);
> > -             consume_skb(skb);
> > -             xdp->rxq->mem =3D rq->xdp_mem;
> > +             if (skb !=3D skb_orig) {
> > +                     xdp->rxq->mem =3D rq->xdp_mem_pp;
> > +                     kfree_skb_partial(skb, true);
> > +             } else if (!skb->pp_recycle) {
> > +                     xdp->rxq->mem =3D rq->xdp_mem;
> > +                     kfree_skb_partial(skb, true);
> > +             } else {
> > +                     veth_xdp_get(xdp);
> > +                     consume_skb(skb);
> > +                     xdp->rxq->mem =3D rq->xdp_mem;
> > +             }
> > +
>
> The common function can be named to reflect what the purpose of this
> code section is.  According to my understanding, the code steals the
> (packet) data section from the SKB and free the SKB.  And
> prepare/associate the correct memory type in xdp_buff->rxq.
>
> Function name proposals:
>   __skb_steal_data
>   __free_skb_and_steal_data
>   __free_skb_and_steal_data_for_xdp
>   __free_skb_and_xdp_steal_data
>   __skb2xdp_steal_data
>
> When doing this in a function, it will also allow us to add some
> comments explaining the different cases and assumptions.  These
> assumptions can get broken as a result of (future) changes in
> surrounding the code, thus we need to explain our assumptions/intent (to
> help our future selves).
>
> For code readability, I think we should convert (skb !=3D skb_orig) into =
a
> boolean that says what this case captures, e.g. local_pp_alloc.
>
> Func prototype:
>   __skb2xdp_steal_data(skb, xdp, rq, bool local_pp_alloc)
>
>
> Always feel free to challenge my view,
> --Jesper
>

Thank you for the detailed suggestion! We will move the code into a
function as you pointed out and comment on each of the different cases
to explain our assumption and intent.

Thanks,
Liang


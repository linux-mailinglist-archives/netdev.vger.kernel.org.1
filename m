Return-Path: <netdev+bounces-24940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028707723B9
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C1E1C20B44
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739A6101C9;
	Mon,  7 Aug 2023 12:21:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830D4436
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:21:02 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB951BCA
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 05:20:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso68059951fa.2
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691410838; x=1692015638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT71Bt3CcaHVO0Y0Bbw4A3QQDJujvHYx8qrj7X8JE/s=;
        b=TRQdyUIkvSG74lcpYJre2wsJ4of+w1z21qBdksh0D+8K9fdMW2Zo2eowTriH0yp8On
         KrrW9u17Yw1tEdAacWmDAtDfSOaLBROt9T871XCfZWBPnpUeznpJcxbwOOfCs3oc8T3c
         CUZyTmBGXicuaP9Ps4sVddF0RxqGqz2279RLyQtQCH8wIDX8kRBayI3uoLm8PtmO2zil
         PVAckSPTFJ2ViQXm1RTbIZcA/+R9n1oGKdxweH0xou1uU9TeZd76U8OM/ISLErJM9MMp
         8IQhfQUgVfObz+0i8mGH3BWmNyS0SP4rG/cVRBGRsqsAWJecbUZPnhq0Efc1IrF6BRYY
         NATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410838; x=1692015638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT71Bt3CcaHVO0Y0Bbw4A3QQDJujvHYx8qrj7X8JE/s=;
        b=d9bJxGQmylBjiy28kQrjVDOE95MT2i/UxX1+tWcWJNlAsfBcmnL3UNf4LUoS1yaGtJ
         UlWYWg4evInM6BJ+CyWYE0tNnuzoaSfY8YZy1cCs/Sfzfwn8vIjs3EdYMoHdUtru41wJ
         fm6Rw+61kY/TTPpT/wJX3z5Op1aIzNqrdFTBRLsHS6kwudpU9HsSArY4G6Auwdc9+l1N
         89HfV2nEPKI5+O1/iKF0mMw+ZbDoEVIuLevfBH6ouB/8zXTgAV4a10J7YaiLxm8QSh6Y
         ezZgnTnpRqnA0Xt5GA7IpEZmnMn6Pnia9gRRAFd771Cr56caklqmcaaMDR2bh38/Zl25
         iwgQ==
X-Gm-Message-State: AOJu0YxrOnoU7rlAoA5fXeQheYGeFUbKb/LlIQGx2eBvomCXZapklpWo
	EnrwXze6lodTPkgtjvEamfVXbNcyWMa3SgMnBqiovDU8XvG8mQmapy0=
X-Google-Smtp-Source: AGHT+IFuybIJOzyBDtOG8U1yEUZccmcBnpMeDUDzxENfcbvfFZvQrWZs1KlGNVuOKIQIYS7loJGonWKlFdL7qxg2j6I=
X-Received: by 2002:a2e:8195:0:b0:2b9:40c7:f5ed with SMTP id
 e21-20020a2e8195000000b002b940c7f5edmr5958385ljg.17.1691410837791; Mon, 07
 Aug 2023 05:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
 <20230801061932.10335-2-liangchen.linux@gmail.com> <dd263b2b-4030-f274-7fe8-7ba751f04ab6@huawei.com>
In-Reply-To: <dd263b2b-4030-f274-7fe8-7ba751f04ab6@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 7 Aug 2023 20:20:25 +0800
Message-ID: <CAKhg4tKg7AjADOqpPMcdyu89pa3wox7t5VrTcj84ks-NGLhyXw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 2/2] net: veth: Improving page pool pages recycling
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 8:32=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/8/1 14:19, Liang Chen wrote:
>
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
>
> For this case, I suppose that we can safely call kfree_skb_partial()
> as we allocate the skb in the veth_convert_skb_to_xdp_buff(), but
> I am not sure about the !skb->pp_recycle case.
>
> > +             } else if (!skb->pp_recycle) {
> > +                     xdp->rxq->mem =3D rq->xdp_mem;
> > +                     kfree_skb_partial(skb, true);
>
> For consume_skb(), there is skb_unref() checking and other checking/opera=
tion.
> Can we really assume that we can call kfree_skb_partial() with head_stole=
n
> being true? Is it possible that skb->users is bigger than 1? If it is pos=
sible,
> don't we free the 'skb' back to skbuff_cache when other may still be usin=
g
> it?
>

Thanks for raising the concern. If there are multiple references to
the skb (skb->users is greater than 1), the skb will be reallocated in
veth_convert_skb_to_xdp_buff(). So it should enter the skb !=3D skb_orig
case.

In fact, entering the !skb->pp_recycle case implies that the skb meets
the following conditions:
1. It is neither shared nor cloned.
2. It is not allocated using kmalloc.
3. It does not have fragment data.
4. The headroom of the skb is greater than XDP_PACKET_HEADROOM.


Thanks,
Liang

> > +             } else {
> > +                     veth_xdp_get(xdp);
> > +                     consume_skb(skb);
> > +                     xdp->rxq->mem =3D rq->xdp_mem;
> > +             }
> > +
>


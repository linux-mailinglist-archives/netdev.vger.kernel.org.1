Return-Path: <netdev+bounces-25772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D484B7756C8
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C19B1C21189
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4991914F7E;
	Wed,  9 Aug 2023 10:01:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB2053B7
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 10:01:52 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AEB1BFA
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 03:01:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so8807331fa.0
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691575309; x=1692180109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTsDUhPKDRlGtoY4iWoTvo+qgH6dkBQ2m6X/HVIGIEo=;
        b=bdElV8j2yZZX0Hn+sNRDXwuCU7Wu7pbeu+1+sufMuF88Ko5aiimVp9G8IZm3532IpH
         HKjAMhtf9LFnumkEWKpEUFxR+S3AekGOTxtic63BhKCyx1ryrY8KPf1xKKEd77QuEQxO
         XmFtLWqsS1pa1YhhCQV7+/808P6CoOh5jupEgHEk3NDkc4AE3PR77M9k2VR+ExfGaTXV
         CcILjpZW3Hh6R9sLJaq4O2T/OeND4Yc8IZRmf3Ybo0+/e9LbwwV5jgXCNFzLFc1l1NZw
         rk6R8uAyyqXkgJuuRiItL090U52q0rSKL9odW8U3puZs23oDpCf3ngStU7V4NnHqOpng
         VL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691575309; x=1692180109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTsDUhPKDRlGtoY4iWoTvo+qgH6dkBQ2m6X/HVIGIEo=;
        b=PKNj01zd04NGWcxnOi7+aIntZhVkMkvHm8lT54EAYv0g6+pxhNTu02RHRyTLc2ZeoU
         T9TA+3yTnWq2KWMZi1Ks/7ejcQzyCvhq1Dp5hcw0yp76Z/ls5ADsEu9uIAZn1bGpEX/i
         psSmh3erL7NLJTPtHpqPR2M8DppA8XLT+WOxonmsMn4jZ4QVQgjN+DxRRMNfHZWriLT6
         l4zyCf/1/QLkeV04UHhrD3JPwdwGPSDCAOCj1eoniiRBblK3LCnZJC0tLOuKzd9ZL5wn
         8emqxGcD+hyhHtrxRzrHImxubbeZbfYJbrLOQWH+OGlP1ILe5nKCUCzQ6u6oSqMqzEda
         MD2g==
X-Gm-Message-State: AOJu0Yzbnf4jmG/QhMyU6/IewEbbdYcQTbwHvRU+LEUYQ00jdJ2Iso3S
	n0zj4U6nRLRiTdfkjtY0u+/foHEHgEEeBG8VCqg=
X-Google-Smtp-Source: AGHT+IEqCK8mQ+jEIe7pGtQjlSJ+2xsrVLx287XGs5X19DGnJHEXrl7aE4CcSbcmGmAiH1ZznkinvlxuLQJYX111whQ=
X-Received: by 2002:a2e:91d9:0:b0:2b6:d03a:5d8d with SMTP id
 u25-20020a2e91d9000000b002b6d03a5d8dmr821663ljg.6.1691575309019; Wed, 09 Aug
 2023 03:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
 <20230801061932.10335-2-liangchen.linux@gmail.com> <dd263b2b-4030-f274-7fe8-7ba751f04ab6@huawei.com>
 <CAKhg4tKg7AjADOqpPMcdyu89pa3wox7t5VrTcj84ks-NGLhyXw@mail.gmail.com> <11eb970b-31e5-2330-65a6-7b9e33556489@huawei.com>
In-Reply-To: <11eb970b-31e5-2330-65a6-7b9e33556489@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 9 Aug 2023 18:01:37 +0800
Message-ID: <CAKhg4tLBcY_-wdVAS1eQHG-YmecUVcGKFi-54xhvR1-7uWjYXA@mail.gmail.com>
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

On Tue, Aug 8, 2023 at 7:16=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/8/7 20:20, Liang Chen wrote:
> > On Wed, Aug 2, 2023 at 8:32=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> On 2023/8/1 14:19, Liang Chen wrote:
> >>
> >>> @@ -862,9 +865,18 @@ static struct sk_buff *veth_xdp_rcv_skb(struct v=
eth_rq *rq,
> >>>       case XDP_PASS:
> >>>               break;
> >>>       case XDP_TX:
> >>> -             veth_xdp_get(xdp);
> >>> -             consume_skb(skb);
> >>> -             xdp->rxq->mem =3D rq->xdp_mem;
> >>> +             if (skb !=3D skb_orig) {
> >>> +                     xdp->rxq->mem =3D rq->xdp_mem_pp;
> >>> +                     kfree_skb_partial(skb, true);
> >>
> >> For this case, I suppose that we can safely call kfree_skb_partial()
> >> as we allocate the skb in the veth_convert_skb_to_xdp_buff(), but
> >> I am not sure about the !skb->pp_recycle case.
> >>
> >>> +             } else if (!skb->pp_recycle) {
> >>> +                     xdp->rxq->mem =3D rq->xdp_mem;
> >>> +                     kfree_skb_partial(skb, true);
> >>
> >> For consume_skb(), there is skb_unref() checking and other checking/op=
eration.
> >> Can we really assume that we can call kfree_skb_partial() with head_st=
olen
> >> being true? Is it possible that skb->users is bigger than 1? If it is =
possible,
> >> don't we free the 'skb' back to skbuff_cache when other may still be u=
sing
> >> it?
> >>
> >
> > Thanks for raising the concern. If there are multiple references to
> > the skb (skb->users is greater than 1), the skb will be reallocated in
> > veth_convert_skb_to_xdp_buff(). So it should enter the skb !=3D skb_ori=
g
> > case.
> >
> > In fact, entering the !skb->pp_recycle case implies that the skb meets
> > the following conditions:
> > 1. It is neither shared nor cloned.
> > 2. It is not allocated using kmalloc.
> > 3. It does not have fragment data.
> > 4. The headroom of the skb is greater than XDP_PACKET_HEADROOM.
> >
>
> You are right, I missed the checking in veth_convert_skb_to_xdp_buff(),
> it seems the xdp is pretty strict about the buffer owner, it need to
> have exclusive access to all the buffer.
>
> And it seems there is only one difference left then, with
> kfree_skb_partial() calling 'kmem_cache_free(skbuff_cache, skb)' and
> consume_skb() calling 'kfree_skbmem(skb)'. If we are true about
> 'skb' only allocated from 'skbuff_cache', this patch looks good to me
> then.
>

The difference between kmem_cache_free and kfree_skbmem lies in the
fact that kfree_skbmem checks whether the skb is an fclone (fast
clone) skb. If it is, it should be returned to the
skbuff_fclone_cache. Currently, fclone skbs can only be allocated
through __alloc_skb, and their head buffer is allocated by
kmalloc_reserve, which does not meet the condition mentioned above -
"2. It is not allocated using kmalloc.". Therefore, the fclone skb
will still be reallocated by veth_convert_skb_to_xdp_buff, leading to
the skb !=3D skb_orig case. In other words, entering the
!skb->pp_recycle case indicates that the skb was allocated from
skbuff_cache.

Thanks for the review,
Liang

> >


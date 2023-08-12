Return-Path: <netdev+bounces-26993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22555779C67
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 03:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0481C20C98
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF44EDD;
	Sat, 12 Aug 2023 01:52:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4010EE
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 01:52:55 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A1130DB
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 18:52:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso38774491fa.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 18:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691805172; x=1692409972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf6uggKlNYqPdXG87q7y4LVMkFSH+J2Z27y19ZCdSUI=;
        b=PzADFf4G13LSwXTF2Wpxu1CC6z4YOjsPK7R1nmWcUVXMZT2ySYb8/SUxL2Y2ARPwkM
         3SMBk80EKYS2jFM9UqVEjPWBcgTBe08eBznxui6ONDQzZfgs4Zp9dw19conQxOyJOdhk
         ieeoZNbk9gBQ+6AAC2km5Yt1L4XNTK+ntSPFd0D3O74ARcgSZSpWtu/ya726RmzpvXUs
         UjbD2yhaF6Smh/G4iVGd27nMbsJm3Nc9zn3BsXQ5vPBQmYm3049uEnJsB1VEVoBbiAnY
         3356jrxWOYaDtVt9h/rJpOMhmXwigEz6Pi5mVAXw4kdKXn1KadXDXP24wnrJUJcrQRl+
         rfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691805172; x=1692409972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cf6uggKlNYqPdXG87q7y4LVMkFSH+J2Z27y19ZCdSUI=;
        b=Juuw+cB+l14bwscYwkH26Y/0qyPotWpU+xhEG4mU2kvMdlimBnF7jhdOCijtavRL9+
         RncasNpmTK4FSwZCDVzG5twbkonRyi50sNSNwrgzdoKo8yrEdLFeI+0v4QNpGHlLe+pf
         wNEI9lozzBWrgh/JERtP18eITEQ3a4RDxuJOWQbSJjU5mrIA3g+k/1LRdU1BXiyw2QT+
         bNRHG1Io3Hu+NLUGLIXbvZCQkhJ0zvHuEB0tggGoJClLgZAEzIvDFA1VyA7jj3YscJA5
         JtpjPuv3pylD5QnFgwcFJK5chDlTawUKLYVIrGdvKj0xY4d9fauGXui9TPY46r90cjnj
         Fpkg==
X-Gm-Message-State: AOJu0YySNEmVAoCm8UK3jr8l4b+f2zIeldOuewl2XuKMVNWiEiuL/GUX
	jcKa4xWdUoxme1nh1hT8b+xPfb5KAjRLiPSq8cw=
X-Google-Smtp-Source: AGHT+IGr83rwTfbTaQyrR8DgFJJ+mzE9useCsT3m5Kp0zmsjgKWBKx6ZIbOrjcQn6iTK3RTH1u36DSkw+J//buMNtfo=
X-Received: by 2002:a2e:8910:0:b0:2b6:cff1:cd1c with SMTP id
 d16-20020a2e8910000000b002b6cff1cd1cmr2693245lji.34.1691805171658; Fri, 11
 Aug 2023 18:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
 <20230801061932.10335-2-liangchen.linux@gmail.com> <dd263b2b-4030-f274-7fe8-7ba751f04ab6@huawei.com>
 <CAKhg4tKg7AjADOqpPMcdyu89pa3wox7t5VrTcj84ks-NGLhyXw@mail.gmail.com>
 <11eb970b-31e5-2330-65a6-7b9e33556489@huawei.com> <CAKhg4tLBcY_-wdVAS1eQHG-YmecUVcGKFi-54xhvR1-7uWjYXA@mail.gmail.com>
 <85c64263-238e-7036-2574-efd0f5d4848b@huawei.com>
In-Reply-To: <85c64263-238e-7036-2574-efd0f5d4848b@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Sat, 12 Aug 2023 09:52:39 +0800
Message-ID: <CAKhg4tKE3gZAL81qfdkyqWCTdPAzvFu1pZkRkPrk6B5bTn1VrQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 2/2] net: veth: Improving page pool pages recycling
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 8:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/8/9 18:01, Liang Chen wrote:
> > On Tue, Aug 8, 2023 at 7:16=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> On 2023/8/7 20:20, Liang Chen wrote:
> >>> On Wed, Aug 2, 2023 at 8:32=E2=80=AFPM Yunsheng Lin <linyunsheng@huaw=
ei.com> wrote:
> >>>>
> >>>> On 2023/8/1 14:19, Liang Chen wrote:
> >>>>
> >>>>> @@ -862,9 +865,18 @@ static struct sk_buff *veth_xdp_rcv_skb(struct=
 veth_rq *rq,
> >>>>>       case XDP_PASS:
> >>>>>               break;
> >>>>>       case XDP_TX:
> >>>>> -             veth_xdp_get(xdp);
> >>>>> -             consume_skb(skb);
> >>>>> -             xdp->rxq->mem =3D rq->xdp_mem;
> >>>>> +             if (skb !=3D skb_orig) {
> >>>>> +                     xdp->rxq->mem =3D rq->xdp_mem_pp;
> >>>>> +                     kfree_skb_partial(skb, true);
> >>>>
> >>>> For this case, I suppose that we can safely call kfree_skb_partial()
> >>>> as we allocate the skb in the veth_convert_skb_to_xdp_buff(), but
> >>>> I am not sure about the !skb->pp_recycle case.
> >>>>
> >>>>> +             } else if (!skb->pp_recycle) {
> >>>>> +                     xdp->rxq->mem =3D rq->xdp_mem;
> >>>>> +                     kfree_skb_partial(skb, true);
> >>>>
> >>>> For consume_skb(), there is skb_unref() checking and other checking/=
operation.
> >>>> Can we really assume that we can call kfree_skb_partial() with head_=
stolen
> >>>> being true? Is it possible that skb->users is bigger than 1? If it i=
s possible,
> >>>> don't we free the 'skb' back to skbuff_cache when other may still be=
 using
> >>>> it?
> >>>>
> >>>
> >>> Thanks for raising the concern. If there are multiple references to
> >>> the skb (skb->users is greater than 1), the skb will be reallocated i=
n
> >>> veth_convert_skb_to_xdp_buff(). So it should enter the skb !=3D skb_o=
rig
> >>> case.
> >>>
> >>> In fact, entering the !skb->pp_recycle case implies that the skb meet=
s
> >>> the following conditions:
> >>> 1. It is neither shared nor cloned.
> >>> 2. It is not allocated using kmalloc.
> >>> 3. It does not have fragment data.
> >>> 4. The headroom of the skb is greater than XDP_PACKET_HEADROOM.
> >>>
> >>
> >> You are right, I missed the checking in veth_convert_skb_to_xdp_buff()=
,
> >> it seems the xdp is pretty strict about the buffer owner, it need to
> >> have exclusive access to all the buffer.
> >>
> >> And it seems there is only one difference left then, with
> >> kfree_skb_partial() calling 'kmem_cache_free(skbuff_cache, skb)' and
> >> consume_skb() calling 'kfree_skbmem(skb)'. If we are true about
> >> 'skb' only allocated from 'skbuff_cache', this patch looks good to me
> >> then.
> >>
> >
> > The difference between kmem_cache_free and kfree_skbmem lies in the
> > fact that kfree_skbmem checks whether the skb is an fclone (fast
> > clone) skb. If it is, it should be returned to the
> > skbuff_fclone_cache. Currently, fclone skbs can only be allocated
> > through __alloc_skb, and their head buffer is allocated by
> > kmalloc_reserve, which does not meet the condition mentioned above -
> > "2. It is not allocated using kmalloc.". Therefore, the fclone skb
> > will still be reallocated by veth_convert_skb_to_xdp_buff, leading to
> > the skb !=3D skb_orig case. In other words, entering the
> > !skb->pp_recycle case indicates that the skb was allocated from
> > skbuff_cache.
>
> It might need some comment to make it clear or add some compile testing
> such as BUILD_BUG_ON() to ensure that, as it is not so obvious if
> someone change it to allocate a fclone skb with a frag head data in
> the future.
>

Sure. We will add a comment to explain that like below
/*
 * We can safely use kfree_skb_partial here because this cannot be an
fclone skb.
 * Fclone skbs are exclusively allocated via __alloc_skb, with their head b=
uffer
 * allocated by kmalloc_reserve (so, skb->head_frag =3D 0), satisfying the
 * skb_head_is_locked condition in veth_convert_skb_to_xdp_buff, leading to=
 skb
 * being reallocated.
 */

> Also I suppose the veth_xdp_rcv_skb() is called in NAPI context, and
> we might be able to reuse the 'skb' if we can use something like
> napi_skb_free_stolen_head().

Sure. Using napi_skb_free_stolen_head seems to be a good idea, it
further accelerates the skb !=3D skb_orig case in our primitive test.
However, it's not suitable for the !skb->pp_recycle case, as the skb
isn't allocated in the current NAPI context.

Thanks,
Liang


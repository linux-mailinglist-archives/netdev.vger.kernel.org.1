Return-Path: <netdev+bounces-20291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD21875EF62
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E21281294
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4B6FD3;
	Mon, 24 Jul 2023 09:45:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E937460
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:45:06 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE2B1AA
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:45:05 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b8392076c9so57180401fa.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690191903; x=1690796703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fEZuAxm9ukJ8RyoYTz0B7DS30KM3dgUvF+5N2NgT4g=;
        b=Wk2qhYUS3xtl6PeTVcMOQJMt/S2CS3kvvaMhmcdjhKAoh/YyQhGhCQk+z3Y1SFoUY+
         jVk4AQcKIeEWEFvRhpXuDGGWihxv5QB/intTsgkDEtwHLQcV28rOjwAUsX/c3zq76Wrg
         FebF6uJgdIoy/UfOFeXutDJsMJ9OPuC12lzNMXo+05+brAVNgbVlCUOdDQdWYxaKsCzv
         V3LMM2OOJ98xtv/g/CW8l89bPPGKCzt+svwXx+pfTRSNcFxnIdQ8pivXj/0TOQNxJ6e4
         zqpkWhB3BQPvDq1NT6EBYQjVAWlgZIbbjrJDlfodhKPzJTKnxv9UBKwvR4SdHvXrykCh
         1L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690191903; x=1690796703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fEZuAxm9ukJ8RyoYTz0B7DS30KM3dgUvF+5N2NgT4g=;
        b=EJlDLKtN25rblbIR1Y7TfcnPpvCo2lGVS3C6poB/w4Ze1/ywOVHRqPADUZxIuM6Llh
         SNWpg3gwB/yEst01cpEimWSOPZzTlB1p5q1W90HFZFTjA96u4JW20TbIcut5vxPIfkNX
         +rQfj5CG551X4grNCLdXykbUft10JzNbnRKiGvpPytRCrGGC9VLMrdmBaJVKlbi47pgI
         UfmtE0o/g2uv3FQZHkqeLfWypqzfmri6XM3/PxpGRpDGxpjpEn0haNNOH+nmn6cAW6Q9
         vVprUDpyf6No5mfLaNm+eaRIb/0vG0lxcPc7M8SbBc9mIQMj3ctKoGJZQ29JauSNYMUi
         5W7g==
X-Gm-Message-State: ABy/qLYcrFeMaChrJ6aadAe8LVGQk7q8jrBmbYCJXZTZ3jw8/59KASg4
	TXuonQftM+cGkBS3Gv4gENJ3jVWeBgGtMRTyXMU=
X-Google-Smtp-Source: APBJJlGVk00Lg2JKeDyPN5dCCttXap5Huzgw7MES39FdRYxoh2SDSkNgesi4EaZAeZzmYqBYH4GoTom19z9b1EVRpmA=
X-Received: by 2002:a2e:3a14:0:b0:2b6:bc30:7254 with SMTP id
 h20-20020a2e3a14000000b002b6bc307254mr5142543lja.13.1690191903321; Mon, 24
 Jul 2023 02:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719072907.100948-1-liangchen.linux@gmail.com>
 <20230719072907.100948-2-liangchen.linux@gmail.com> <d38e4df7-3a7c-d3b3-53ee-77db8d5f8d94@huawei.com>
In-Reply-To: <d38e4df7-3a7c-d3b3-53ee-77db8d5f8d94@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 24 Jul 2023 17:44:50 +0800
Message-ID: <CAKhg4tKMZEP2uu0Dh6+BRB2OqPH8_YsTm-2SgGKyWeHeU7W3gg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 2/2] net: veth: Improving page pool recycling
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 8:18=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/7/19 15:29, Liang Chen wrote:
>
> ...
>
> >
> > The reason behind is some skbs received from the veth peer are not page
> > pool pages, and remain so after conversion to xdp frame. In order to no=
t
> > confusing __xdp_return with mixed regular pages and page pool pages, th=
ey
> > are all converted to regular pages. So registering xdp memory model as
> > MEM_TYPE_PAGE_SHARED is sufficient.
> >
> > If we replace the above code with kfree_skb_partial, directly releasing
> > the skb data structure, we can retain the original page pool page behav=
ior.
> > However, directly changing the xdp memory model to MEM_TYPE_PAGE_POOL i=
s
> > not a solution as explained above. Therefore, we introduced an addition=
ally
> > MEM_TYPE_PAGE_POOL model for each rq.
> >
>
> ...
>
> > @@ -874,9 +862,9 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth=
_rq *rq,
> >               rcu_read_unlock();
> >               goto xdp_xmit;
> >       case XDP_REDIRECT:
> > -             veth_xdp_get(xdp);
> > -             consume_skb(skb);
> > -             xdp->rxq->mem =3D rq->xdp_mem;
> > +             xdp->rxq->mem =3D skb->pp_recycle ? rq->xdp_mem_pp : rq->=
xdp_mem;
>
> I am not really familiar with the veth here, so some question here:
> Is it possible that skbs received from the veth peer are also page pool p=
ages?
> Does using the local rq->xdp_mem_pp for page allocated from veth peer cau=
se
> some problem here? As there is type and id for a specific page_pool insta=
nce,
> type may be the same, but I suppose id is not the same for veth and it's =
veth
> peer.
>

Yeah, I understand your concern. If a skb uses a page pool page whose
pool has previously been registered with a xdp memory model, this will
lead to a situation where veth compose a xdp frame indicating its
buffer coming from the local xdp_mem_pp pool from its xdp_mem_info.id
field, and the page structure itself refers to another pool from where
it was originally allocated. This may cause problems for things like
xdp_return_frame_bulk. We will address it in V2. Thank you for
bringing up this issue.


Thanks,
Liang

> > +             kfree_skb_partial(skb, true);
> > +


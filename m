Return-Path: <netdev+bounces-20000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590AC75D541
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A3F28231E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F422EEC;
	Fri, 21 Jul 2023 19:55:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC220FA0
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:55:29 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A998730C1
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:55:26 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-577412111f0so26127117b3.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689969325; x=1690574125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJT4+RmfBWynVHG/cOw859g5gbEQQADfK1s8za4QoqA=;
        b=m7JF5qApOuejxguy7MBKszUVaXZg7d/fGMn+szyy6ldC1yJUvp9djPC1F4VLGvNZHF
         Rxe6gLNR8Tf8s55KCOnO8Z/U77ud3T0S+00Q+5popDspKjLFY+RRmrJ5KihY/UBo7HaW
         iQXezd6DCpO5UvcLKV354a1wtvurXKcmXdEJMawDpoTi077bHPYX9/1PfF3zwCX5oXdR
         culzECBzEvI+jSD3xKPO0+1GdH5nMfweTcPDEayAzbjio/F7Ie5rFKqPvXdv0D+ItNTY
         0KxcfNllFdnTvnWsG+1q+XZ9fAyBedTYR94NFX9dmscoWo+HPTM+scKRl9tcGrn56MLK
         pMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689969325; x=1690574125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJT4+RmfBWynVHG/cOw859g5gbEQQADfK1s8za4QoqA=;
        b=ARJMyDuIkLSCCs7uKS/piLmfUPjrvqILOUjR5BL/NPcsrAZwywRkPlUMxf9uansOw6
         62Tu4ffopSKQIDwizThbwArLSLsYu+9Oyl4OaznkTHUuUXJptAImAioKMtlDYt2JzSWQ
         kAVMFSOsk0bGMdPbqolZbk2eh31RuLF83M1gfs0RKJve2ki+fYJfGpKZU9ME5+lWl1zW
         mUAD5Dw0soiwl7h8hFgDFLk1OMaDcfcVuk3U+iV79IdO5BOu5Fzxru+pIvHuLEIO8hvj
         A3rbrZCor8QKUziU8ZqqY/MShmjwvI9LU415hTXkdFJ4OUlBnt9m24xXYKzfjG353ReB
         VTuQ==
X-Gm-Message-State: ABy/qLaj+YkuIAbQU5EX4QnGpCjNEGt2DD8urtzhiWRCW/tUTQK7GVSO
	Gd94tGWIQbSMqmSDbuAGHQlMSvy25bCwfVnL5MDlSw==
X-Google-Smtp-Source: APBJJlH+D1uKyDrlAzBuErJ8adONh/OhCWW0bs1kiL/LSuHzlPsrVPMo2ofhzqreejzYRYSnP4F7p9+MfLHP3yrMRxA=
X-Received: by 2002:a0d:c8c1:0:b0:56d:9b15:72a with SMTP id
 k184-20020a0dc8c1000000b0056d9b15072amr1005344ywd.33.1689969325719; Fri, 21
 Jul 2023 12:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721174856.3045-1-sec@valis.email> <20230721174856.3045-2-sec@valis.email>
 <CACSEBQQdOJAX1yqDMLb_yQMpU2yoUShhS_pCSDndWepxfw3Rsw@mail.gmail.com>
In-Reply-To: <CACSEBQQdOJAX1yqDMLb_yQMpU2yoUShhS_pCSDndWepxfw3Rsw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 21 Jul 2023 15:55:14 -0400
Message-ID: <CAM0EoM==XCDWdj7n955uRkeJeyLrOgW_0k+d1qpPVjgz4ax4KQ@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net/sched: cls_u32: No longer copy tcf_result on
 update to avoid use-after-free
To: M A Ramdhan <ramdhan@starlabs.sg>
Cc: valis <sec@valis.email>, netdev@vger.kernel.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pctammela@mojatatu.com, victor@mojatatu.com, 
	billy@starlabs.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 2:05=E2=80=AFPM M A Ramdhan <ramdhan@starlabs.sg> w=
rote:
>
> On Sat, Jul 22, 2023 at 12:51=E2=80=AFAM valis <sec@valis.email> wrote:
> >
> > When u32_change() is called on an existing filter, the whole
> > tcf_result struct is always copied into the new instance of the filter.
> >
> > This causes a problem when updating a filter bound to a class,
> > as tcf_unbind_filter() is always called on the old instance in the
> > success path, decreasing filter_cnt of the still referenced class
> > and allowing it to be deleted, leading to a use-after-free.
> >
> > Fix this by no longer copying the tcf_result struct from the old filter=
.
> >
> > Fixes: de5df63228fc ("net: sched: cls_u32 changes to knode must appear =
atomic to readers")
> > Reported-by: valis <sec@valis.email>
> > Reported-by: M A Ramdhan <ramdhan@starlabs.sg>
> > Signed-off-by: valis <sec@valis.email>
> > Cc: stable@vger.kernel.org
> > ---
> >  net/sched/cls_u32.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> > index 5abf31e432ca..19aa60d1eea7 100644
> > --- a/net/sched/cls_u32.c
> > +++ b/net/sched/cls_u32.c
> > @@ -826,7 +826,6 @@ static struct tc_u_knode *u32_init_knode(struct net=
 *net, struct tcf_proto *tp,
> >
> >         new->ifindex =3D n->ifindex;
> >         new->fshift =3D n->fshift;
> > -       new->res =3D n->res;
> >         new->flags =3D n->flags;
> >         RCU_INIT_POINTER(new->ht_down, ht);
> >
> > --
> > 2.30.2
> >
> Hi,
>
> We also thought it's also the correct fixes,
> but we're not sure because it will always remove the already bound
> qdisc class when we change the filter, even tho we never specify
> the new TCA_U32_CLASSID in the new filter.

I am assuming you are referring to the u32 classifier here and from
what you are describing you first create a filter with reference to an
existing class and then you replace it to not reference the class - am
i correct? If yes, then please provide an example policy setup? We
tested this scenario on u32 extensively and it should be fine.

cheers,
jamal

> I also look at the implementation of cls_tcindex and cls_rsvp which still=
 copy
> the old tcf_result, but don't call the tcf_unbind_filter when changing
> the filter.
>
> If it's the intended behaviour, then I'm good with this patch.
>
> Thanks & Regards,
> M A Ramdhan


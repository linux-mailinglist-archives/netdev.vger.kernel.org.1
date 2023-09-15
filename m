Return-Path: <netdev+bounces-34106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7043F7A21E9
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC009282B10
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5BC1097D;
	Fri, 15 Sep 2023 15:07:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A4D30CE0
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:07:36 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B282728
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:06:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41513d2cca7so353621cf.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694790381; x=1695395181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PZMXRUic8jLDKg5Qn/0jsFYvtSW5SyhezA9EAWtnpI=;
        b=ZvRTjhnHpR/jBbprd6N9AnrsZ83tbGR5ScCBYxZDA7fxVI3kmd8BR1yZ4y6PpPbQqU
         5qlQf8Il/Koafw0ROIG5O88sCo9YwwroIe49FeOvsxsiv2WzsggzP+TaT6wOlDPM6eCH
         dhKZ+457BJch+bjRGXdmxC4NCgP48rRst6kH1eY9WXqEVnXPg7hSZQ7NxGvop25dTaNY
         taGExLpBCel3k81o7mvRurkER8woBVhQuMxQvC6mRlwKeRfBSgb+0BRXtPzexrsBDUpD
         g4AR1pOlqVussRnUbVdskWhdHJtc2BWf/FAknuoYG2jNjyx9aDUwZA7RsVV8PcL/xxSD
         xPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790381; x=1695395181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PZMXRUic8jLDKg5Qn/0jsFYvtSW5SyhezA9EAWtnpI=;
        b=TbzV02k9UfmcvZ57Jdipk12G3AZOg+GZgr0npz5R0gF7xK5utd0zYNMmqjGHkk+lpU
         PRarWgvjcHKx5UGo2nTyJa9ZKu0xI+j2bpu3R5Ql4mUYk2Rbt5UNtF2DOMGYuFyGRz48
         7FGWTOeiWGQdw8IzlgpRwBcoK2HuTXl+vzTe6TQ/SiRMKuAi+zDrYvmbB7uEdilBW1dN
         1BoNS3xD6mnAy4ph4bN+QDQf+68egxvwFzifChsjClyGb1EGXCCuBjuEo+9CY6pjpo3i
         upnVdzwkYoUSZ6XcRHytGrikAtCW+Uz48177eGRQr7d5s2KI0FPbjhESvTUaTVhFDIb7
         VrTA==
X-Gm-Message-State: AOJu0YxOPIzLwoP6r6GN2TXR/4asICPQnWMzwpdsV8yEPvAuj0qsmY8/
	WtTqpQCKsFINY3vfEV+OU7wXL+WSfr/XydT+Ykia9A==
X-Google-Smtp-Source: AGHT+IF/qfW1nt3T0UFrmUbSo4vb+e1sURQZHaIker3s5qm0jRWjN4KBqSDmjuLTbiFygljtMDlxozq2UI6JbGY6UY0=
X-Received: by 2002:a05:622a:50a:b0:40f:c60d:1c79 with SMTP id
 l10-20020a05622a050a00b0040fc60d1c79mr284661qtx.28.1694790381039; Fri, 15 Sep
 2023 08:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915104156.3406380-1-make_ruc2021@163.com>
 <CANn89iJyktWcztc76Pw16MP-k-DfSjstW+WFgRxwUat7p25CGw@mail.gmail.com> <16461255-c2c0-2ffd-f031-5b7a1f67bf7e@mojatatu.com>
In-Reply-To: <16461255-c2c0-2ffd-f031-5b7a1f67bf7e@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Sep 2023 17:06:09 +0200
Message-ID: <CANn89i++j0-QJ1WE=RO4_ucN9k-DgqK52jLSTcz_s_DmFiAnFw@mail.gmail.com>
Subject: Re: [PATCH] net: sched: drr: dont intepret cls results when asked to drop
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: Ma Ke <make_ruc2021@163.com>, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 5:03=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> On 15/09/2023 09:55, Eric Dumazet wrote:
> > On Fri, Sep 15, 2023 at 12:42=E2=80=AFPM Ma Ke <make_ruc2021@163.com> w=
rote:
> >>
> >> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> >> assume res.class contains a valid pointer.
> >>
> >> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> >> ---
> >>   net/sched/sch_drr.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> >> index 19901e77cd3b..2b854cb6edf9 100644
> >> --- a/net/sched/sch_drr.c
> >> +++ b/net/sched/sch_drr.c
> >> @@ -309,6 +309,8 @@ static struct drr_class *drr_classify(struct sk_bu=
ff *skb, struct Qdisc *sch,
> >>          *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> >>          fl =3D rcu_dereference_bh(q->filter_list);
> >>          result =3D tcf_classify(skb, NULL, fl, &res, false);
> >> +       if (result =3D=3D TC_ACT_SHOT)
> >> +               return NULL;
> >>          if (result >=3D 0) {
> >>   #ifdef CONFIG_NET_CLS_ACT
> >>                  switch (result) {
> >> --
> >> 2.37.2
> >>
> >
> >   I do not see a bug, TC_ACT_SHOT is handled in the switch (result) jus=
t fine
> > at line 320 ?
>
> Following the code path (with CONFIG_NET_CLS_ACT=3Dn in mind), it looks
> like there are a couple of places which return TC_ACT_SHOT before
> calling any classifiers, which then would cause some qdiscs to look into
> a uninitialized 'struct tcf_result res'.
> I could be misreading it... But if it's the problem the author is trying
> to fix, the obvious way to do it would be:
>         struct tcf_result res =3D {};

CONFIG_NET_CLS_ACT=3Dn, how come TC_ACT_SHOT could be used ?

Can we get rid of CONFIG_NET_CLS_ACT, this seems obfuscation to me at
this point.


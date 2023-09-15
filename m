Return-Path: <netdev+bounces-34200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB3C7A2AC5
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 00:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EEE1C20948
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 22:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6101B277;
	Fri, 15 Sep 2023 22:55:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096818E1B
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 22:55:19 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F12483
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:55:17 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d81d09d883dso1052020276.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694818516; x=1695423316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJMWKG5nVw0rOZdlDWduF6hIwAWfXWswjHwiBK07s/o=;
        b=VjQxiWjXnsngN09wdDGilt/VL7IE8eyAvBXFTzWS0Q7IBnZJ6j3oe8ccihpmXlAYIR
         QkBhnWWPqRsDUHGQ5S44ywKPLmhGehUYMKMnYvI2tBD9AkcTp+7b8P3+ljisKDqy95vw
         iE5Og1VQj4C7asn9ggtaImmovkDNSSIR/qhRQSA7rksqYfnpAPvIC9PRGmOoC6IxXv5d
         eiOrA2sWpPSBvqjWSfKi4pn4KNAw8+huzofQ9ubkz0ocmKf+fQ/yNO96Vu5Cx1qE08k+
         XcQ9XUWsiUdDWA7UilZs3l2LeCUBrfNDPGzXisY8xZIeyDI72hzA/JtryL6TmLJ3ti8J
         J39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694818516; x=1695423316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJMWKG5nVw0rOZdlDWduF6hIwAWfXWswjHwiBK07s/o=;
        b=jmVJD7Ye9+aY2Nondku8y8QGHdNyp3WZHD0z0i8PIQeCDks9EkPR0RaPjXUIcRvnu1
         e7W2nHks98zuRY8X+nM2v5ps+E+BtC+shrK5ECoRFlW+xqnz1ae9hpTbgSoXW5dpg0Mo
         WFu0p+nKSbI4QF8mgn5dr3PsfecHY0TQRY3wlGPebw3TQLpCzj887jJlt81KsHjc7fWy
         8mj2qNjcfRRKWCF8iuYlRACiNhvDEfptcUvJhkq0A35wnKvVT//7fAgEpifVYU5Z+bEl
         4c1ntStmDIyB7cVbLbeUZr5PjEjX6+1a0a+ymNHTBwCJmVnTF4I2LN6nOpMqgTTAMJ+H
         IhEw==
X-Gm-Message-State: AOJu0YykVNbtOmxQBePmx3/sZB9E7QBwF0WdWJv6CbK8qF+S9Jt0ZPah
	xB1Gt/ySiGoUgXEm1pEm5vMuWXDjhN9PvTz4mjribg==
X-Google-Smtp-Source: AGHT+IHtS7/vSnKkVuM1+wOIKRx1XD0T1ov0FPjAHpgYaaUxP43WAoM8/wSXwENNga+F+hJovHOt/7Q8fkE/jn6qZmQ=
X-Received: by 2002:a81:918c:0:b0:58c:b845:e4d6 with SMTP id
 i134-20020a81918c000000b0058cb845e4d6mr3269532ywg.4.1694818516624; Fri, 15
 Sep 2023 15:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915104156.3406380-1-make_ruc2021@163.com>
 <CANn89iJyktWcztc76Pw16MP-k-DfSjstW+WFgRxwUat7p25CGw@mail.gmail.com>
 <16461255-c2c0-2ffd-f031-5b7a1f67bf7e@mojatatu.com> <CANn89i++j0-QJ1WE=RO4_ucN9k-DgqK52jLSTcz_s_DmFiAnFw@mail.gmail.com>
In-Reply-To: <CANn89i++j0-QJ1WE=RO4_ucN9k-DgqK52jLSTcz_s_DmFiAnFw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 15 Sep 2023 18:55:05 -0400
Message-ID: <CAM0EoMmzCBewv4hfWQrNb+gaO_+aR7jnMbsQScN+FEchTdWXmw@mail.gmail.com>
Subject: Re: [PATCH] net: sched: drr: dont intepret cls results when asked to drop
To: Eric Dumazet <edumazet@google.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>, Ma Ke <make_ruc2021@163.com>, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 11:06=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Sep 15, 2023 at 5:03=E2=80=AFPM Pedro Tammela <pctammela@mojatatu=
.com> wrote:
> >
> > On 15/09/2023 09:55, Eric Dumazet wrote:
> > > On Fri, Sep 15, 2023 at 12:42=E2=80=AFPM Ma Ke <make_ruc2021@163.com>=
 wrote:
> > >>
> > >> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> > >> assume res.class contains a valid pointer.
> > >>
> > >> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> > >> ---
> > >>   net/sched/sch_drr.c | 2 ++
> > >>   1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> > >> index 19901e77cd3b..2b854cb6edf9 100644
> > >> --- a/net/sched/sch_drr.c
> > >> +++ b/net/sched/sch_drr.c
> > >> @@ -309,6 +309,8 @@ static struct drr_class *drr_classify(struct sk_=
buff *skb, struct Qdisc *sch,
> > >>          *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> > >>          fl =3D rcu_dereference_bh(q->filter_list);
> > >>          result =3D tcf_classify(skb, NULL, fl, &res, false);
> > >> +       if (result =3D=3D TC_ACT_SHOT)
> > >> +               return NULL;
> > >>          if (result >=3D 0) {
> > >>   #ifdef CONFIG_NET_CLS_ACT
> > >>                  switch (result) {
> > >> --
> > >> 2.37.2
> > >>
> > >
> > >   I do not see a bug, TC_ACT_SHOT is handled in the switch (result) j=
ust fine
> > > at line 320 ?
> >
> > Following the code path (with CONFIG_NET_CLS_ACT=3Dn in mind), it looks
> > like there are a couple of places which return TC_ACT_SHOT before
> > calling any classifiers, which then would cause some qdiscs to look int=
o
> > a uninitialized 'struct tcf_result res'.
> > I could be misreading it... But if it's the problem the author is tryin=
g
> > to fix, the obvious way to do it would be:
> >         struct tcf_result res =3D {};
>
> CONFIG_NET_CLS_ACT=3Dn, how come TC_ACT_SHOT could be used ?
>
> Can we get rid of CONFIG_NET_CLS_ACT, this seems obfuscation to me at
> this point.

The problem is the verdict vs return code are intermixed - not saying
this was fixing anything useful.
We discussed this in the past after/during commit
caa4b35b4317d5147b3ab0fbdc9c075c7d2e9c12
Victor worked on a patch to resolve that. Victor, maybe revive that
patch and post as RFC?


cheers,
jamal


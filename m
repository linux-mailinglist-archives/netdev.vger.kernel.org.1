Return-Path: <netdev+bounces-28020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A677DFFF
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 13:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0C41C20EC3
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCA8101C8;
	Wed, 16 Aug 2023 11:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10ECFC18
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 11:06:45 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E01B5
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 04:06:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58c4dce9db8so24775107b3.1
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692184003; x=1692788803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HQ3vb7p1Y+89nxvrpe8Nd48SfLU44xJqDvjx3PJ2M0=;
        b=oXisJD4IeStriAKnRFObUNzR3i3rmXRuC0hzBbC1bN3wSfTfuRk60Ez5IdU8SyQ6d6
         uYxBsAmYZA/ChfLSAqvVYXRnVu0IOTpxQnKoo1o+/sx+ae/UDkVokIn9ib0qJH2VQNVC
         K0hBxuqyaDiHbQtulu8IMnwQBzOLcHJGdKRTupzU8TGgHwX/RiDtfEL02Vt5u1L7yPA+
         1GdNnHWWDJaLKFUa/UBK5gWB9VXdo5RqF+qnA/bMByRSA1PZsop+U1rSewg4IVLwI6a1
         TZzwA2cYzIJqJ74x6eBkRMlNlUiep//h4jcmAF4jZYbo9n6rgNKMeJ7r0SbppCAzkfmB
         0SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692184003; x=1692788803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HQ3vb7p1Y+89nxvrpe8Nd48SfLU44xJqDvjx3PJ2M0=;
        b=iMt97tbiElTmRrLsb9/zT3kIcEngkfEvH5qVlkO9qhTXmHR2Mu/VluICzWOGDQYmEk
         oDyGWEVMCGMWX0Q4gzNlq7OLwoMj/Jg0CuDZXgEYnF4EesIyJZnJG6VXRKK4RmAMIJ97
         TMCJMSpCjgmvw3QJ8uWNSFOTGTW4IOCzQQgylUNlrbpVvCDBhAY4YbrdljCIOTTrcgbm
         hfWj6Wmm/2kLrX0nLzz/DMjZ1OZR2ELqq645XFNM6Lm1IuXe43X+5v05pkVlfI9j12sD
         TmEH2f5ZAbj1GvOOxZfrt2r4QMS4XryqfEnk9HZZHWiGv6SSCOGUd0BKcbVsbkIqahFp
         iNDw==
X-Gm-Message-State: AOJu0YxG5eXS3k+3Xbh/hucVIV/xNIbFzJzWiMeL8VyzsCIgKw1GtLeS
	ZnVbYNVx9dW7AMhYB9qmYrr0h8kw28vstJXXYBpPiA==
X-Google-Smtp-Source: AGHT+IFxIhJCku02BfaMm94+JoNJU6LDIFXB5bl2ebVMx0rwaKUhDY/WWbca1P1xtLt0Va64vLGCqCndHBUas8r/0d4=
X-Received: by 2002:a81:a195:0:b0:57a:75b8:b790 with SMTP id
 y143-20020a81a195000000b0057a75b8b790mr1372150ywg.29.1692184003161; Wed, 16
 Aug 2023 04:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230815162530.150994-1-jhs@mojatatu.com> <20230815162530.150994-3-jhs@mojatatu.com>
 <20230815105246.0a623664@hermes.local>
In-Reply-To: <20230815105246.0a623664@hermes.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 16 Aug 2023 07:06:31 -0400
Message-ID: <CAM0EoMnd7N42kmQXA7WZuhj4=spgp71QjfNR5RWigyrKmJCU5w@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/3] Expose tc block ports to the datapath
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	vladbu@nvidia.com, mleitner@redhat.com, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 1:52=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 15 Aug 2023 12:25:29 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > +struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
> >  {
> >       struct tcf_net *tn =3D net_generic(net, tcf_net_id);
> >
> >       return idr_find(&tn->idr, block_index);
> >  }
> > +EXPORT_SYMBOL(tcf_block_lookup)
>
> Use EXPORT_SYMBOL_GPL?

Sure.

On Wed, Aug 16, 2023 at 5:04=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
On Wed, Aug 16, 2023 at 5:04=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Aug 15, 2023 at 12:25:29PM -0400, Jamal Hadi Salim wrote:
> > The datapath can now find the block of the port in which the packet arr=
ived at.
> > It can then use it for various activities.
> >
> > In the next patch we show a simple action that multicast to all ports e=
xcept for
> > the port in which the packet arrived on.
> >
> > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> ...
>
> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index a976792ef02f..be4555714519 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
>
> ...
>
> > @@ -1737,9 +1738,12 @@ int tcf_classify(struct sk_buff *skb,
> >                const struct tcf_proto *tp,
> >                struct tcf_result *res, bool compat_mode)
> >  {
> > +     struct qdisc_skb_cb *qdisc_cb =3D qdisc_skb_cb(skb);
>
> Hi Jamal,
>
> Does the line above belong inside the condition immediately below?
> It seems potentially unused otherwise.

Indeed.
The Intel bot also complained about this. I guess we'll need an
additional patch and move up "last_executed_chain" variable which is
repeated twice. Then i can add the assignment on top of this.
Something like:
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4af48f76f..5d9959381 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1736,13 +1736,12 @@ int tcf_classify(struct sk_buff *skb,
                 const struct tcf_proto *tp,
                 struct tcf_result *res, bool compat_mode)
 {
-#if !IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
        u32 last_executed_chain =3D 0;
-
+#if !IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
        return __tcf_classify(skb, tp, tp, res, compat_mode, NULL, 0,
                              &last_executed_chain);
 #else
-       u32 last_executed_chain =3D tp ? tp->chain->index : 0;
+       last_executed_chain =3D tp ? tp->chain->index : 0;
        struct tcf_exts_miss_cookie_node *n =3D NULL;
        const struct tcf_proto *orig_tp =3D tp;
        struct tc_skb_ext *ext;

cheers,
jamal


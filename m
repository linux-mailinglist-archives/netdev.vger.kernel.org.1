Return-Path: <netdev+bounces-16204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F4374BCC5
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 10:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2149E1C21144
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8E51FD0;
	Sat,  8 Jul 2023 08:10:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4931FA1
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 08:10:12 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C71FEC
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 01:10:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-401f4408955so72461cf.1
        for <netdev@vger.kernel.org>; Sat, 08 Jul 2023 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688803810; x=1691395810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R5OHE2Pj5QFma/bZRlsHFlvV/PIKSgmhFXgTYCpZJA=;
        b=NBhjU0INhfllVxiFlH2/14S8EfhLJDUL75/xmjB+54rCDViFH5JbFzXzLdgBMN11yi
         9ldgxYMlCrQlwVXTMjoEHZeEqtTgD7a3Ui8tF2NkKpYh5rxvH6h8G6Qe1t/IVwQIbwor
         byEvaTSYL4IkonyAJYPmAb3q4LGuaP2Jk2N8Lk1jQaBCBf0nXbedjpa9D8Cv9b+wT+83
         eCFfSyS5PMrujaUjSuIOCVrW7EO4272DhpGbJIAGuBqgOdbiBXl1T6Y8WztrXyCyVflZ
         9z8ddNsI/1xE20VZ6kuDir9dprFwbnpZKFPklwfY3XMwjplo59qrCjydmDOz+sBPdNcy
         R2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688803810; x=1691395810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R5OHE2Pj5QFma/bZRlsHFlvV/PIKSgmhFXgTYCpZJA=;
        b=C6amXJMfSSw7s2Rsf6T9ef9EN1ESW5g99yT+ZlVqJbpoCAyWSsMTgfCPp4Ll/XY6aj
         tG3fFtMWMmfGgYlOvmMu5MXPJAuFWHGnJb4mxKTUhifM38pyyjPbZ3yW3CKGvT0g8kwt
         pv7Ubw7zws9YAX0KTf9NAYsy9ezd13cGXZOr/F8rPAmcWJGZRtHiLIc7TzcMgxUP/ZLs
         IxBDnIGOI7QtmEduAoS5Sixt+8cjViPLstsepEAatth+RIjYNrDLwBk9haZ+3zw2YKDU
         7dy6RwB8uD6mp2+8WsmLcbk+DZ+Yvymmg/q7Gys0cCdVxBIB95zZ3ZfYcFQe9tqIO8cl
         r/CQ==
X-Gm-Message-State: ABy/qLbLWLpju4jtVvdOev24h4SahWuxTJDPJCstyVfSMqO1RHaNYB84
	zBVyjJNVv6Y+gogDU8w0g5qaoHnZLk4SPArifaDK6Q==
X-Google-Smtp-Source: APBJJlG7sK5ypM7d/hL6hWAya4DxaATro6/s7nZAWIOXFEZ5mlG4wMw7T3g3UODhgPY1YwrHX+qY3GpIVbxgxJhyR6w=
X-Received: by 2002:ac8:5b09:0:b0:3f8:8c06:c53b with SMTP id
 m9-20020ac85b09000000b003f88c06c53bmr126030qtw.0.1688803809412; Sat, 08 Jul
 2023 01:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707220000.461410-1-pctammela@mojatatu.com> <20230707220000.461410-4-pctammela@mojatatu.com>
In-Reply-To: <20230707220000.461410-4-pctammela@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 8 Jul 2023 10:09:58 +0200
Message-ID: <CANn89i+fBupepzT1=-BRNVqX+iciiTmg5CZL8CZYbqk8188MUA@mail.gmail.com>
Subject: Re: [PATCH net v2 3/4] net/sched: sch_qfq: account for stab overhead
 in qfq_enqueue
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, shaozhengchao@huawei.com, victor@mojatatu.com, 
	simon.horman@corigine.com, paolo.valente@unimore.it, Lion <nnamrec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 8, 2023 at 12:01=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Lion says:
> -------
> In the QFQ scheduler a similar issue to CVE-2023-31436
> persists.
>
> Consider the following code in net/sched/sch_qfq.c:
>
> static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>                 struct sk_buff **to_free)
> {
>      unsigned int len =3D qdisc_pkt_len(skb), gso_segs;
>
>     // ...
>
>      if (unlikely(cl->agg->lmax < len)) {
>          pr_debug("qfq: increasing maxpkt from %u to %u for class %u",
>               cl->agg->lmax, len, cl->common.classid);
>          err =3D qfq_change_agg(sch, cl, cl->agg->class_weight, len);
>          if (err) {
>              cl->qstats.drops++;
>              return qdisc_drop(skb, sch, to_free);
>          }
>
>     // ...
>
>      }
>

> This is caused by incorrectly assuming that qdisc_pkt_len() returns a
> length within the QFQ_MIN_LMAX < len < QFQ_MAX_LMAX.
>
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR c=
ost")
> Reported-by: Lion <nnamrec@gmail.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  net/sched/sch_qfq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index 63a5b277c117..befaf74b33ca 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -381,8 +381,13 @@ static int qfq_change_agg(struct Qdisc *sch, struct =
qfq_class *cl, u32 weight,
>                            u32 lmax)
>  {
>         struct qfq_sched *q =3D qdisc_priv(sch);
> -       struct qfq_aggregate *new_agg =3D qfq_find_agg(q, lmax, weight);
> +       struct qfq_aggregate *new_agg;
>
> +       /* 'lmax' can range from [QFQ_MIN_LMAX, pktlen + stab overhead] *=
/
> +       if (lmax > QFQ_MAX_LMAX)
> +               return -EINVAL;
> +
> +       new_agg =3D qfq_find_agg(q, lmax, weight);

Reviewed-by: Eric Dumazet <edumazet@google.com>


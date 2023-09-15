Return-Path: <netdev+bounces-34097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8809C7A2136
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F921C21A40
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3254930D01;
	Fri, 15 Sep 2023 14:40:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C330CFF
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:40:32 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A51FD2
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 07:40:30 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-415155b2796so281021cf.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694788829; x=1695393629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ian4KdZXmKFMo5ATT66+8ryOQHatJUEavAax22/9xtM=;
        b=L3qVWDW1dbmk8GpWmRPl0hqNX2AGqrzf4fsv7AvEWCnSyfdgcrgiCZz/fUEERA40ay
         Hqu0RFaz1cNIyejGluY2McxJXGiHtnw7tFMDsA6GthLJudivDlvopP6aY+6G156T2T6U
         v+F6HaKLtO6KOxbXl/XLmi81WQb3gBm07u5iUyeu33pU6RByqShfAEd90POP/p/lv47A
         kDLZ+1BHyVkoL0zk4oLXXo1DrKw8lPxoMqaAwH0+l7c7o/Q+JAIFaOPXRvwET3MbNuZX
         TFtw0iXWAJf2rHPyfJ4mtGP8rOns5PgLcTbtrqCwrvrRCeHtn2uWNtsZoGUqV/qmEB+2
         s+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694788829; x=1695393629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ian4KdZXmKFMo5ATT66+8ryOQHatJUEavAax22/9xtM=;
        b=KB7z/M4KlEN7QdbLDxBeuc87VYEtAD62KjLB/nKOIYjYkqNlfQU9ar+yFouIp2dUAM
         is5ljgekaEeqFPR2KVo7Kph5KfjPwKbH0WKYCtK9IqGQSEZaLckeKyKf6yJM+LjCrPuw
         35l/GOs1YO/K9K1ZRAfF8jw4/vVqlreKQUztn2XpN8eQBeXsihLKChfWOoQvNtVjxLi+
         9Dn8FmurMNHVeO7rS6S0EYpdKcrf0USa8tojRYWNxvTlfjt8xkUI8kaksULiu0XitEJp
         TzEENfe8sog7pQ2dYtv6hsfrNrzB3rB1ydH9isE+n1HQX9jtPElo/XU8Ma9KMiSrO23E
         8dtw==
X-Gm-Message-State: AOJu0YwvYKt9kA/YhYgHR5Jy6S55719ht6FDjAdMJLDRXtUYqcjzbClt
	6Qhm0Goj5MP62Qvro1ZmY5s1uFvpuqUr0zpFRSJrYQ==
X-Google-Smtp-Source: AGHT+IEvTGUFvnjnnBA1AteMbyFSqSQVTo/tJ9sREckup1RnXB1Q25mSsTPQKnY1pjk3jEb1DZA3eESSv+sSMHy9O6w=
X-Received: by 2002:ac8:598e:0:b0:40f:d1f4:aa58 with SMTP id
 e14-20020ac8598e000000b0040fd1f4aa58mr247843qte.8.1694788828644; Fri, 15 Sep
 2023 07:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915142719.3411733-1-make_ruc2021@163.com>
In-Reply-To: <20230915142719.3411733-1-make_ruc2021@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Sep 2023 16:40:17 +0200
Message-ID: <CANn89iJVM4J8DG4V3MdPcyimuKsbiko_vB=wYRyxnwzp_SiMTA@mail.gmail.com>
Subject: Re: [PATCH] net: sched: htb: dont intepret cls results when asked to drop
To: Ma Ke <make_ruc2021@163.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 4:27=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote:
>
> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> assume that res.class contains a valid pointer.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  net/sched/sch_htb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> index 0d947414e616..7b2e5037b713 100644
> --- a/net/sched/sch_htb.c
> +++ b/net/sched/sch_htb.c
> @@ -243,6 +243,8 @@ static struct htb_class *htb_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         while (tcf && (result =3D tcf_classify(skb, NULL, tcf, &res, fals=
e)) >=3D 0) {
> +               if (result =3D=3D TC_ACT_SHOT)
> +                       return NULL;
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
>                 case TC_ACT_QUEUED:
> @@ -250,8 +252,6 @@ static struct htb_class *htb_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>                 case TC_ACT_TRAP:
>                         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
>                         fallthrough;
> -               case TC_ACT_SHOT:
> -                       return NULL;
>                 }
>  #endif
>                 cl =3D (void *)res.class;

Can you please stop sending patches that are not needed,
as already pointed out ?


Return-Path: <netdev+bounces-34070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE017A1F58
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3855C2829BD
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0A5107B3;
	Fri, 15 Sep 2023 12:57:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC17107A3
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:57:48 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432E910E
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:57:47 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-414ba610766so307381cf.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694782666; x=1695387466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcuMOBJNB817DaLLKwvFYiTctCwx4E0hPvxhRSMQXLw=;
        b=Sd4ylr/w4b27Y4Jud2xK80qzK/420nsiKmEpXDe/X62IHlKuvOjUaVycOrk7bq2StU
         h/CNAZHA8PjLBDvMnZYFbXrlU6C83iCqs5td7kszQYMW8if8MqKOZx+5QpDexG+RKVgl
         aHlgTcLyzUTEEmMSw7ed80hN9vi4UXg7FguwegeOTh0u5KqJSekqLKezOoNQ95TiZHjf
         x1Z+aFxfw0mB0/6jBWB8rHHbhPxsFF33DqueinyzbBBf0HTD/j4NaQ8pciep0MsZX0rT
         M9FhwG7gxWPImfXAJSPfYooOvOM7NvbVvb7o4HyeAmHxvKLApOXUjF/r/dS0iTmforvF
         sX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694782666; x=1695387466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcuMOBJNB817DaLLKwvFYiTctCwx4E0hPvxhRSMQXLw=;
        b=iWuJr4/H7XSSjvFxIQlw019sQU1NLNFDDjnXSOzYikTWslsdTHyovhHCtUDffq8r1T
         MmGflSXeXpKXwf8ZgevhQespFZuz14jXL6WXJW4GJ0VyEWcW3g1aP2+q3tYCg0p4m0UR
         qFpTZoV6NDdoLL5H4n9Ky/8aCwZ73M68J0EaCY5tTfcWStHND8QprUj2GOoYNaUKDc+B
         IY8ovdHuOujiOa64eP6fORlqq2poU1UmHsJBSVx62ATNIY8zJ9bE37ZdsniCKvr2Ww0q
         ZGv+oPP3tvBQQPC4hQACq6MA2wNu+1kePTlVkYub5glWNPvYz7E3NvvWKXhhMzGenHFZ
         cTpg==
X-Gm-Message-State: AOJu0YwUcH9XtWY0ILeUiLQf6o9Mz8C31EtZyrO+TWGCqOxTNuLdMZ5v
	apzrSclaHjaNwwwnJvl/rPJb0jZph7Mmv2bXLQFa0Q==
X-Google-Smtp-Source: AGHT+IFDWurUxsATW6ZkJU2jWTzRExmBqyruiH6PNf63aYT6X5hSh71/C44VxTzWd/Ia1G+b29WsfByZ8Hi35ZJminE=
X-Received: by 2002:a05:622a:60c:b0:405:47aa:7ffd with SMTP id
 z12-20020a05622a060c00b0040547aa7ffdmr174104qta.19.1694782666113; Fri, 15 Sep
 2023 05:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915121841.3408778-1-make_ruc2021@163.com>
In-Reply-To: <20230915121841.3408778-1-make_ruc2021@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Sep 2023 14:57:35 +0200
Message-ID: <CANn89i+hM_eHSPUNwPCQZdtkk7O31GhaQ4AmhfBuZ=wQ3psb7w@mail.gmail.com>
Subject: Re: [PATCH] net: sched: hfsc: dont intepret cls results when asked to drop
To: Ma Ke <make_ruc2021@163.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
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

On Fri, Sep 15, 2023 at 2:37=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote:
>
> If asked to drop a packet via TC_ACT_SHOT it is unsafe to assume
> res.class contains a valid pointer.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  net/sched/sch_hfsc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index 3554085bc2be..2a76027b14e6 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -1135,6 +1135,8 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sc=
h, int *qerr)
>         head =3D &q->root;
>         tcf =3D rcu_dereference_bh(q->root.filter_list);
>         while (tcf && (result =3D tcf_classify(skb, NULL, tcf, &res, fals=
e)) >=3D 0) {
> +               if (result =3D=3D TC_ACT_SHOT)
> +                       return NULL;
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
>                 case TC_ACT_QUEUED:
> --
> 2.37.2
>

Same comment, already handled at iine 1145


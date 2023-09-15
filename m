Return-Path: <netdev+bounces-34069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F737A1F51
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9D28175D
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B4310942;
	Fri, 15 Sep 2023 12:56:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C99101D4
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:56:28 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521041713
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:56:26 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41761e9181eso241431cf.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694782585; x=1695387385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POzX7W8BdLozOP6jMEbD1FJiIlYH4jYiXUDV3kPwj2A=;
        b=4oUuiIgBJX8CCHZaLRQsCQnKf1CUrHMxySXrBX29xfOr2vDsvR9D6ECmEhb7qsYVBs
         +QnQpF3yJcJJ1Tn6JE6BvyFR8TS9U7jlKglu7sCJUGvnfJhSaQz7kKYefvuHEYsu7meT
         8kmDge9EWosB3+3SWqsHLZZ/WUXAjmHla50dmu6fNeaQTHZpXun9ZG8R0uwrqqOGwi5J
         yjQaNrPlO5bjQktWx9ReWUxj6m1f5iydLCQb35fmaxclso9OhYRIJpJSeAkw+vK9Rqa3
         88tDEk6vUS871y4t1G08zP1w0QKnr6OvC0cAeZ2uOD7HO1idd1CRcj2j0+FDCgvMxknp
         7ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694782585; x=1695387385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POzX7W8BdLozOP6jMEbD1FJiIlYH4jYiXUDV3kPwj2A=;
        b=rVcBEXKOkMDhnsHZ/AlqOehRo5BJxN9641rIAYqtQkxNJWnHQ3MunrHgIbGfONBxX3
         7MfUGoHDdL6Voto7FwYMF/CwAH8Byg/AOsh1fl1IbIQR+YVSszpMLQRvXcYXNfsN9Mhw
         yhTOnu6/TEpxf/fsOWjhOIJHthtLe42IaFJlX/3o8Xrres7ptcLI8c3RxCfH8GtdvzHz
         nDc/UzDoSk6BxgbzpkpsA9xLpQP+bMkIvO/deuxsHAux7P3t4dOuX2frNyKSyawZh3oO
         KgPVR0+wyLSedMvXCgYaW28TceGGlDTYbvxqwWUUP7q/Y9OrwbaWq/osaQk/fiS0c99F
         sjlg==
X-Gm-Message-State: AOJu0YynlSFx2ESuy1KVi91mxz+ry/MWvJaAPrcwFa8NPFOmnXj/Cso8
	wqmlgJ80qA85F7iv2mrSYuBBtv6Yuv3Mtrmz0v9lX3eO9rpVtzOQKU4=
X-Google-Smtp-Source: AGHT+IEBO2PWMF56UV0o0XFzzvl3p5wa/2hiGnEufkAATdc1riorwCp2tXZ4FHLdUicqUGrNwtSr8L7GdgG/ywhe4Bo=
X-Received: by 2002:ac8:5b53:0:b0:410:653f:90ea with SMTP id
 n19-20020ac85b53000000b00410653f90eamr165544qtw.1.1694782585290; Fri, 15 Sep
 2023 05:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915105036.3406718-1-make_ruc2021@163.com>
In-Reply-To: <20230915105036.3406718-1-make_ruc2021@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Sep 2023 14:56:14 +0200
Message-ID: <CANn89i+On15D1y92SusrAbMZB9qrNCXZE-PwjzDaF3zpQb7d2g@mail.gmail.com>
Subject: Re: [PATCH] net: sched: qfq: dont intepret cls results when asked to drop
To: Ma Ke <make_ruc2021@163.com>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 1:08=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote:
>
> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> assume that res.class contains a valid pointer.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  net/sched/sch_qfq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index 546c10adcacd..20d52dc484b6 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -695,6 +695,8 @@ static struct qfq_class *qfq_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         fl =3D rcu_dereference_bh(q->filter_list);
>         result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       if (result =3D=3D TC_ACT_SHOT)
> +               return NULL;
>         if (result >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> --
> 2.37.2
>

Same comment, it seems already handled at line 706


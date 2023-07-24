Return-Path: <netdev+bounces-20507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAD275FC4E
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD1E1C20BF7
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20E5D526;
	Mon, 24 Jul 2023 16:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3331C2D3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 16:38:38 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3595AE42
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:38:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40631c5b9e9so373841cf.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690216716; x=1690821516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXL5+O18EgBsFGMS49HNrL/MdpPJHrdtkfkoHCeMwmw=;
        b=InxI4E0ygBYoQ5Kg5HifjhJGph4TCvf0vLud+E/W0pnOT2HqKOveBF/nHwgCCebXy+
         qfLqbBNMFXJe5BWsGR0t8aArHgqbEHuwJ7DxC0KJtO6crmVpz7A6QHgsoNEDlXbO87oI
         r2D1ZflgnfR9kwiyXwbMLjM0Malbm9t6Xt+smlREGvT9qYTCJ0DQwZxjUKMviKDB1IQ0
         yw81rOguuf5ppFK1WLK8xsw/GEqu2OvLCN9Biv/+87HL7b5cGARPozlDLF4Kji4sjrlX
         JgUoRGz5sVvIx1YEToHUC9UxOqjrnxXbFMnJKwtqMQevfheJPWQhTm1nK0E+JrjSH2N+
         EmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216716; x=1690821516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXL5+O18EgBsFGMS49HNrL/MdpPJHrdtkfkoHCeMwmw=;
        b=Z0tMARngq9B84TMsGAvmb9SBm4OW6wXvTKdbBDsRe8gDa/HBP1otjd4OcurHHL44ZR
         CHN3DR0VM3+XI/ECj5S5ZBRFMj3ooCJw6NyILQ2Ag83hFAo+rJ4I1rvlHeNkl0vqZVVD
         2CYPgBeH6sllQu+r/WtA2pC/Z8NCZ6a/n2AdThs4NCOt9QAo6SnScCfaQxzVV+C2VuOl
         yj5vp49UsxR6MaazHn+M/vgVdJkDzzIijk9wp/sA9Hq1RFM19LnJKlc/q2h66OVGQRuS
         QJ6KsAksz4jkgnlOG5wIxd+jx3nhBEoY9AjI4zY7yTLwOscp109EU344iZ7CB1/HbToU
         ZA9Q==
X-Gm-Message-State: ABy/qLbFoTeC9rAtvOkyi7zNNQV70ZI3gLft9Re/D8wmhym0YPxnoF9s
	uu0lTalEEgC5Fr1cI4ZBPuUog7RzHVL6IPf0TQia09PZlNoot/KNFkYj8Q==
X-Google-Smtp-Source: APBJJlGCkv69nqWBViuTKaxFHpfvyEjAD754Fvxs9ZMYck4vewaGi1ScReSyb7PjMaGSICNN/nujEh6v15Qaa7BMtI8=
X-Received: by 2002:a05:622a:1981:b0:3fa:3c8f:3435 with SMTP id
 u1-20020a05622a198100b003fa3c8f3435mr483674qtc.27.1690216716190; Mon, 24 Jul
 2023 09:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724163254.106178-1-edumazet@google.com>
In-Reply-To: <20230724163254.106178-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Jul 2023 18:38:25 +0200
Message-ID: <CANn89iLb1gumSBimUMsfToY1-3ra3EOuNZV7h=Te27AjYexAXA@mail.gmail.com>
Subject: Re: [PATCH net] net: flower: fix stack-out-of-bounds in fl_set_key_cfm()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Zahari Doychev <zdoychev@maxlinear.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Simon Horman <simon.horman@corigine.com>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 6:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Typical misuse of
>
>         nla_parse_nested(array, XXX_MAX, ...);
>
> array must be declared as
>
>         struct nlattr *array[XXX_MAX + 1];
>
> Fixes: 7cfffd5fed3e ("net: flower: add support for matching cfm fields")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Simon Horman <simon.horman@corigine.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/sched/cls_flower.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 8da9d039d964ea417700a2f59ad95a9ce52f5eab..3c7a272bf7c7cf7d4ae21b537=
0cbc428086d6979 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -1709,7 +1709,7 @@ static int fl_set_key_cfm(struct nlattr **tb,
>                           struct fl_flow_key *mask,
>                           struct netlink_ext_ack *extack)
>  {
> -       struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX];
> +       struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX + 1];
>         int err;
>
>         if (!tb[TCA_FLOWER_KEY_CFM])
> --
> 2.41.0.487.g6d72f3e995-goog
>

Cc Zahari Doychev <zdoychev@maxlinear.com>


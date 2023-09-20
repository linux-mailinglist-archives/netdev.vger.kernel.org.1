Return-Path: <netdev+bounces-35326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CD37A8DF6
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 22:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914101C20BC2
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 20:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9811E41ABE;
	Wed, 20 Sep 2023 20:45:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9141ABB
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:45:32 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACA4C6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:45:31 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-579de633419so3148997b3.3
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1695242730; x=1695847530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0nggM3LfJz61T7R/AyTboB9YdjRNQU9tNAoglNVeFI=;
        b=YZTizqc3XhqRT8rXCxOBgSLOugOL2fj0/2mgjpP0siXWEcMDuS7d/O8Fz7lstgtqlY
         S2sOmilYJlTn3Q9fO6/tvjCnh1F+HkzosvoHvDMbLcmGaxv9sEQssRh3LwRMVI52tV+K
         3DV8C1hIy8cQfRNtSN+Q+5VIziv/Ee2PAhlASRt8Hlnk8tgC9ZWMVJ3z6Nuk1F/qXVVW
         EruwvPLGVGwidJADZAgGm2pEeKyqKSI3zjCrVGhsO+NhaUmEhUgwvqjdENWezbCKzjsU
         IRxu7tyOAiGSDKsGCYORx8VfBMY9MbYE3+Wfo0qP1RmrfNzehQRjXw7dmqLdBUHEIjDW
         pS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695242730; x=1695847530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0nggM3LfJz61T7R/AyTboB9YdjRNQU9tNAoglNVeFI=;
        b=X96zgAtTIY8bYvGYkknnT4avvxoPOSPQccvxD/bdllx9pK8TbXukcuVpFJGsRtaGsB
         My22fgkVGJ+wvwxB6t4QpSGTL/ODz3fgsQjrSI+DdHywZNiOg7uM0Lqams0Et4c0WGyX
         C7fnxd0NBtdH6/be3Ntry0LDQPbjd8NxakHy1RbJrP/uo1DSOlBd/R+T/NCEgRK0LbLn
         CByWlOXqlYjjxoHekMg2gaveu9vdHyCz+fqSwNB8cXO7YRp7xNItu/R7eO6TxFk7l+Gi
         t9e3VUzNe2KZfEcg24KlDrmdYvjFvldTR869fR2J5tyV3VMUA7z0MG2aWlPwYu8WFcBq
         0W0Q==
X-Gm-Message-State: AOJu0Yyp6s7rOlcr7oytYzv4isafKTLphlXgpmdD/S7ZrJMnudVKtsJq
	lOCuLyDLIBmdJA51hI+hWO7nWPNVM7xlYQQHmEvn/A==
X-Google-Smtp-Source: AGHT+IFIHxAAwqoPJE74ybOJ0LeeE+9rtlhIClnUVaqetnT8GAc7bH/FwDlFLRKAe5527rg2Vs1cpFnKkuV1vrFRlpA=
X-Received: by 2002:a0d:d801:0:b0:59b:518a:639c with SMTP id
 a1-20020a0dd801000000b0059b518a639cmr3647015ywe.36.1695242730706; Wed, 20 Sep
 2023 13:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920201715.418491-1-edumazet@google.com> <20230920201715.418491-2-edumazet@google.com>
In-Reply-To: <20230920201715.418491-2-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 Sep 2023 16:45:19 -0400
Message-ID: <CAM0EoMmKrUwMBqKeBSDCe-pa=7ouMYhCtpv7tRR6uzxkn_hGfA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/5] net_sched: constify qdisc_priv()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 4:17=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In order to propagate const qualifiers, we change qdisc_priv()
> to accept a possibly const argument.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/pkt_sched.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index 15960564e0c364ef430f1e3fcdd0e835c2f94a77..9fa1d0794dfa5241705f9a39c=
896ed44519a9f13 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -20,10 +20,10 @@ struct qdisc_walker {
>         int     (*fn)(struct Qdisc *, unsigned long cl, struct qdisc_walk=
er *);
>  };
>
> -static inline void *qdisc_priv(struct Qdisc *q)
> -{
> -       return &q->privdata;
> -}
> +#define qdisc_priv(q)                                                  \
> +       _Generic(q,                                                     \
> +                const struct Qdisc * : (const void *)&q->privdata,     \
> +                struct Qdisc * : (void *)&q->privdata)

Didnt know you could do this - C11? Would old compilers work here or
do we have some standardization version around compiler versions?

cheers,
jamal


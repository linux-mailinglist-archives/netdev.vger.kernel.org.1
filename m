Return-Path: <netdev+bounces-14755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D207439DA
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 12:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD2A280FEA
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3DC125AD;
	Fri, 30 Jun 2023 10:49:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FD79E6
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 10:49:29 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69622D56
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 03:49:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-401f4408955so177411cf.1
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688122167; x=1690714167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV42IHjel97h5PDq9+W8YKTELSJ6vcAkTp1PI9W0jpQ=;
        b=tqP5hkP6e1lRwBtlA42daEmMp/ha1qZj4p6v9MiRw3FRfXo73hSEXoO61Bz9QHGBMJ
         XO/1ykxNd6heG1Cruqv0G5wVOAFrmcPQkxGLeSLxxwBgCTapu7GIpNoYKHyo6GFB9baX
         uxMe1GZBSs5UdGXi3tAnWnO4A4jCwv216Tc5lYN5KiqZdvlO3MgqT0jMOYvQzlxOM0iC
         2OpNLVwDbZLqlKn7f9VexEA37avg8dWXYAQ7NKjCfcKOGggAYMGxr0Y/g174resZO+Yl
         Cl74oG6JDDq3tK0day7BanQ8CI/HiqSrRhOpOR/eZS9WMkWTX3qP1Unw6kTL4SxqjA7l
         e1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688122167; x=1690714167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CV42IHjel97h5PDq9+W8YKTELSJ6vcAkTp1PI9W0jpQ=;
        b=QZnwa9hfsWl+ZARXibvqQDmZKYoIlqKMi2vPfvBv5ngdEqqMM2/CRWjZ5covDXqvrh
         eQzox71sTS+L0eSGs/OENfGMqxfNillKXw0G8OQTWX9EOX/pjOKEGkcUIC9/NjM0VK90
         8pFqOTytX5WFsj2L0Dozgmy77PAp37FiF0JiKG+XrqhvcBwQPfQoeJ3V5VXU5pfZVmw1
         sRmj37ST1JTLi1p3CWwFvX3ukMIIHH2z/RVigLxXdG5xGX7cNlRD3Fix6iLjjm+qilaD
         3zOm2bIft3S3WVEBBYAwB/8R/u+wrI0CQAMa9fafr2NLnM2zAZmF7dBrKwPlPfJ/cZpt
         9f5w==
X-Gm-Message-State: AC+VfDznO8bP7QIey9zT6uwsMDZIYIyikHgCjdKVpnVup1Fz/mcCefLz
	idJtx9D+ap6vpMsbBee5GR6gy12XR4sb9Hq+QtlKgA==
X-Google-Smtp-Source: ACHHUZ5OiuTHhvE7jIk96REi9a3aWtgwSJQT2Q26uLdF5GrNEEVpx7LShuroF/Qvz07/yd8Kkd3g1uErSEdGPvAvSeE=
X-Received: by 2002:ac8:5843:0:b0:3ef:404a:b291 with SMTP id
 h3-20020ac85843000000b003ef404ab291mr755024qth.7.1688122166824; Fri, 30 Jun
 2023 03:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630071827.2078604-1-wenjian1@xiaomi.com>
In-Reply-To: <20230630071827.2078604-1-wenjian1@xiaomi.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jun 2023 12:49:15 +0200
Message-ID: <CANn89iKZ7LE6y-c=E5uQRtMuf2vg2h479SoxEwN5jNFJ+FgGtA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add a scheduling point in established_get_first()
To: Jian Wen <wenjianhn@gmail.com>
Cc: davem@davemloft.net, Jian Wen <wenjian1@xiaomi.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 9:18=E2=80=AFAM Jian Wen <wenjianhn@gmail.com> wrot=
e:
>
> Kubernetes[1] is going to stick with /proc/net/tcp for a while.
>
> This commit reduces the scheduling latency introduced by established_get_=
first(),
> similar to commit acffb584cda7 ("net: diag: add a scheduling point in ine=
t_diag_dump_icsk()").
>
> In our environment, the scheduling latency affects:
> 1. the performance of latency-sensitive services like Redis
> 2. the delay of synchronize_net() that is called with RTNL is locked
>    12 times when Dockerd is deleting a container
>
> [1] https://github.com/google/cadvisor/blob/v0.47.2/container/libcontaine=
r/handler.go#L130
>
> Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
> ---
>  net/ipv4/tcp_ipv4.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fd365de4d5ff..3271848e9c9a 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -57,6 +57,7 @@
>  #include <linux/init.h>
>  #include <linux/times.h>
>  #include <linux/slab.h>
> +#include <linux/sched.h>
>
>  #include <net/net_namespace.h>
>  #include <net/icmp.h>
> @@ -2456,6 +2457,7 @@ static void *established_get_first(struct seq_file =
*seq)
>                                 return sk;
>                 }
>                 spin_unlock_bh(lock);
> +               cond_resched();
>         }
>
>         return NULL;
> --
> 2.25.1
>
Hi Jian, thanks for your patch.

Few points:

- Note that net-next is currently closed (merge window)

- Also, /proc interface does not hold RTNL, not sure why you mention
RTNL in the changelog,
and not other mutexes in the kernel that also would be impacted by the
long duration of established_get_first() ?

- The cond_resched() should be done even if all buckets are empty ?

- Using inet_diag, Kubernetes could list both IPv4/IPv6 sockets in one dump=
,
and benefit from more modern interface (with cond_resched() already there)


Return-Path: <netdev+bounces-35569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4436C7A9B93
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DA71F21214
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF2218B14;
	Thu, 21 Sep 2023 19:02:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6EF8BEA
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:02:03 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF5F7F37E
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:02:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81841ef79bso1953506276.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695322919; x=1695927719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5idGDJHajfRBbMuSzPd4i5/t54vfHNdbr48RChRWzqM=;
        b=2BooiXDRdGdVMAlVcBWQCNkTEkbZrHYrWY31LpUZEk3fc9eDkThZx1AwQUhKMDHkf5
         UEyShVv3rLaiV+P0txfMCu8MFamgMEoSeykzTzRYfhJiK7l3FTwudW7TF2GY6cMIItPu
         mapw67pjL/Xp6/6FZWKO4aDatRspS7w3PvHw5jx+fYJzj3jiq7O10CBFxYbRTpZvkvKO
         C2UAyiwt4K87AE6oq/qeak2O6pgrFVjeVTPo7Sbv1PJyk5ia01xFsOHhPoGnk6TJRTWW
         uj4QSq4wDmgUk9K61I2I/5B6GmcisxUc0apclpo1nVwVDm0qZVujLDa51jAfqqcswzI2
         UNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322919; x=1695927719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5idGDJHajfRBbMuSzPd4i5/t54vfHNdbr48RChRWzqM=;
        b=kPaa2lE08HVaA4gVVVCaEYgrAYP97g0+w94x4DhJtQzEk2tF0MC29056KnZfvN+B5j
         I061r4B/cSvH6JLZIRoMXG1a97FXvhfWlbJdtwG6MVMUt91+upO6psoqY8jhZ5A3UWUu
         /UaOw8arYUj1F7lgnYnavZbTN5ZVv5fMIr50vp89vcM5CYsPC1zKWEAa3MYVB2xBnZsz
         vMzKeKcr1VOdxgBMoIj2NuQaY7kTUXbvrD7u7QZsTY6C57BtpoH/6oVECL1/uLA7DWtN
         AxgXelYRpTxqyvpD4q6PSNW49HIKCHd0YdE64SaIWJB9Wa5cxExdgBs2Out5VuTxU6Xn
         tkKQ==
X-Gm-Message-State: AOJu0YyWLx7P2SkON5E7bdLMoUIhYyhTDGfcp38duMJAi/3/lKO8Q4bW
	SXmgMt4YO1RuvncagLgO4glMlhkRDL9jnA==
X-Google-Smtp-Source: AGHT+IGiWhkZQI2qsIIIWvhihaksfZHxJa3nw+xhY08FFXLOqY3cnBSLU1oGhU9kfs+YQ6I22pIVz3FchgxXQA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6902:a84:b0:d7b:94f5:1301 with SMTP
 id cd4-20020a0569020a8400b00d7b94f51301mr93080ybb.9.1695322919028; Thu, 21
 Sep 2023 12:01:59 -0700 (PDT)
Date: Thu, 21 Sep 2023 19:01:56 +0000
In-Reply-To: <20230920132545.56834-2-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920132545.56834-1-wuyun.abel@bytedance.com> <20230920132545.56834-2-wuyun.abel@bytedance.com>
Message-ID: <20230921190156.s4oygohw4hud42tx@google.com>
Subject: Re: [PATCH net-next 2/2] sock: Fix improper heuristic on raising memory
From: Shakeel Butt <shakeelb@google.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Breno Leitao <leitao@debian.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, David Howells <dhowells@redhat.com>, 
	Jason Xing <kernelxing@tencent.com>, Xin Long <lucien.xin@gmail.com>, 
	Glauber Costa <glommer@parallels.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtsu.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 09:25:41PM +0800, Abel Wu wrote:
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
> 
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> Fix this by skipping this heuristic when under memcg pressure.
> 
> Fixes: e1aab161e013 ("socket: initial cgroup code.")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  net/core/sock.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 379eb8b65562..ef5cf6250f17 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3093,8 +3093,16 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>  	if (sk_has_memory_pressure(sk)) {
>  		u64 alloc;
>  
> -		if (!sk_under_memory_pressure(sk))
> +		if (memcg && mem_cgroup_under_socket_pressure(memcg))
> +			goto suppress_allocation;
> +
> +		if (!sk_under_global_memory_pressure(sk))
>  			return 1;

I am onboard with replacing sk_under_memory_pressure() with
sk_under_global_memory_pressure(). However suppressing on memcg pressure
is a behavior change from status quo and need more thought and testing.

I think there are three options for this hunk:

1. proposed patch
2. Consider memcg pressure only for !in_softirq().
3. Don't consider memcg pressure at all.

All three options are behavior change from the status quo but with
different risk levels. (1) may reintroduce the regression fixed by
720ca52bcef22 ("net-memcg: avoid stalls when under memory pressure").
(2) is more inlined with 720ca52bcef22. (3) has the risk to making memcg
limits ineffective.

IMHO we should go with (2) as there is already a precedence in
720ca52bcef22.

thanks,
Shakeel


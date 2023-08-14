Return-Path: <netdev+bounces-27465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E477C165
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1648F1C20B6D
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04AD528;
	Mon, 14 Aug 2023 20:18:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6DDCA4B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 20:18:38 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8482FE5B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 13:18:37 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-407db3e9669so17851cf.1
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692044316; x=1692649116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFWKye89AohEqYgCuqyO0wjrP9O8bS1Mmve3otWwOUQ=;
        b=updUYgXLDGG4jlzZd5VTLcn4ck7IV7JsmtsFDKY3gGoK8cHcDcVAF65Px8wrcx4Rpw
         5aeohd2TIc+lBdHaUcKOLojjvG5i1Sjtomi5Efvu9HKhrYtbkVsFBJQDc/gXDZXhrqDd
         BTw7bVAxF4h6WbITliiLtT4buweGCJUSmaTwZQspzLmIKsmCe14t6a9HVIWT6YKlLvDV
         mNs74AwJ0zU0/tetCBfCfSp0XcnRJ1m3IpOmybV/upnND0Ytv7jyrvl1TXrF9NGHKWnc
         ExRJysByXqm0J8czAGmplNNLUBdHGyai37qngjYtFkqBvNbS/eLxW99NXQ+KREqbFOkq
         +u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044316; x=1692649116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFWKye89AohEqYgCuqyO0wjrP9O8bS1Mmve3otWwOUQ=;
        b=fLEMoFhTN65+W2EBWgsdrSRVYt1asxx76qi6vWcdhmrJf6+A9n5pCWVeWtGnQ/ZiW0
         MyzEymQnXWQwBsX9Pu/mpbaMs9/OeZvq+QnDoh77KTunCoccejzjOq7Eo4UrKbGa63GC
         eukiRT7SvYA+4wuADov3pMPB+qNUI+jHP8xoXQE1I6h/JiqvNvojGNS1bhcl3OLagJ8t
         NlURZouxmHSiEWS1kfra1FtRZE6uH7Kb/NuZ1SVYpPrDRTfcOKUh9fNnS/qQUHFhaL1J
         acG0qV71HnbHMAkLv4cbN4jWk/5q6pbAiro5IeYSq99BSjioDk4/XvdfoPpMLfS0vdOT
         l7cQ==
X-Gm-Message-State: AOJu0Yzp7CmlaC5aY/uh6VB2ze/1uENlPUJ1gG1OYfHcfIHFthS4+c5w
	GbwBV4kbZ5iFKyCuUFV3ZAbBzZrJHNqPKBC3zZTSnQ==
X-Google-Smtp-Source: AGHT+IEFdGrDQ4Nwqtzcf6NqnLR2GAMh5mfN76hFiLoqG57pskcDNdbraJUTBqKQzWqKSGAdkPmPVqBGYqsl0XuRfHo=
X-Received: by 2002:ac8:7c50:0:b0:40f:db89:5246 with SMTP id
 o16-20020ac87c50000000b0040fdb895246mr696564qtv.21.1692044316493; Mon, 14 Aug
 2023 13:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814070923.35769-1-wuyun.abel@bytedance.com>
In-Reply-To: <20230814070923.35769-1-wuyun.abel@bytedance.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 14 Aug 2023 13:18:23 -0700
Message-ID: <CALvZod5C3yWdgWr83EAdVUCH5PEK8ew7Q+FOt_zGOFOE9HVyQQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net-memcg: Fix scope of sockmem pressure indicators
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Ahern <dsahern@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	David Howells <dhowells@redhat.com>, Jason Xing <kernelxing@tencent.com>, 
	Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 12:09=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com>=
 wrote:
>
> Now there are two indicators of socket memory pressure sit inside
> struct mem_cgroup, socket_pressure and tcpmem_pressure, indicating
> memory reclaim pressure in memcg->memory and ->tcpmem respectively.
>
> When in legacy mode (cgroupv1), the socket memory is charged into
> ->tcpmem which is independent of ->memory, so socket_pressure has
> nothing to do with socket's pressure at all. Things could be worse
> by taking socket_pressure into consideration in legacy mode, as a
> pressure in ->memory can lead to premature reclamation/throttling
> in socket.
>
> While for the default mode (cgroupv2), the socket memory is charged
> into ->memory, and ->tcpmem/->tcpmem_pressure are simply not used.
>
> So {socket,tcpmem}_pressure are only used in default/legacy mode
> respectively for indicating socket memory pressure. This patch fixes
> the pieces of code that make mixed use of both.
>
> Fixes: 8e8ae645249b ("mm: memcontrol: hook up vmpressure to socket pressu=
re")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

So, this is undoing the unintended exposure of v2 functionality for
the v1. I wonder if someone might have started depending upon that
behavior but I am more convinced that no one is using v1's tcpmem
accounting due to performance impact. So, this looks good to me.

Acked-by: Shakeel Butt <shakeelb@google.com>

I do think we should start the deprecation process of v1's tcpmem accountin=
g.


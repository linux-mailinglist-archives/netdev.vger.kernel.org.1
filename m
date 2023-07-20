Return-Path: <netdev+bounces-19429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C5675AA60
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E06281D1D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D7199FE;
	Thu, 20 Jul 2023 09:10:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F7361
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:10:58 +0000 (UTC)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED2B49C3
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:10:57 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3460770afe2so95985ab.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689844257; x=1690449057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0Q8HK8TX799KwlVsueVU2Vn6pAZBPxCHZbkBqMog0w=;
        b=KGu3G60TOGRLcruEhisXUXiUEndw3y1bTGZ4+JTPqa0pzslDfSMX3gX1Jm0bStvtzd
         ueQB4VaVMfLwWkZ0o3xRSyKgJgX2gCERAiHeen4kiauOhWaNRwpPdtUI8Yt0kWaC6Q4H
         1MdbPw+eicIbg/P5qR6n31Evi2ldNs4huycbeN6iOba422XZaY7UamtXtYMC1ycWr33A
         2YRyRIV7dKnlfMavYxqhbREbHPzrDULVQaKzfIzskU+GrBChxJ+UyGEnSw3XRt440GMv
         rxdPhVPraVgaRKx2SZYZ+ZF8vjOadxDfBzndSjnRL/CB5izuZ2T33E7tJaMrYjEZIPoI
         aHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689844257; x=1690449057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0Q8HK8TX799KwlVsueVU2Vn6pAZBPxCHZbkBqMog0w=;
        b=V/FXHg9FMM8mg/iVx5iCizsq/O04OkpHjCUsWq/AG0AoGn06dPTB8EDwSlYThryzna
         66T17raFiALMM+85NP6HMjNfrUeTLyqGlEc3bFrC4Xp7faiZRIJEfoge07u8uCQHpcdo
         xJcurgR/ZK15T19WC1qAmaedPn2NMkpMol3YfkfZxA4PwRASv7uIg9AbZovGRp9V0rwP
         DF1n7qA7bk+ud8konknvShHxZBzI8u7PSZCERsEcdzUmrNGJx36tTEVxG5UgaG0i2oFm
         zYpSc3TZVpXcY7+rjObE0AnAK3Dz5RE+uhA5O3skx/TM39NYGVl9h7N+CzJF4UFhDFsb
         DTzQ==
X-Gm-Message-State: ABy/qLZZ+mqNl5tyfU+F3ISiYYKQvRzNwHJ2CwEKPDpcHizsTwD0H5hZ
	IazGtr4VhWlkmCTvgLrxLRUju+n3nLBsgcwisJcVIRH5t2fxkvVy21A=
X-Google-Smtp-Source: APBJJlFqutZVzbsA3NqN/Ssn0odGnTV/YCAAziUPG0pJHG9pnasjigUhJvUq9CLPLsN4fxxZHp1mY/y9L0R6loLApxY=
X-Received: by 2002:a05:622a:1a12:b0:404:8218:83da with SMTP id
 f18-20020a05622a1a1200b00404821883damr159489qtb.1.1689843455136; Thu, 20 Jul
 2023 01:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711124157.97169-1-wuyun.abel@bytedance.com> <d114834c-2336-673f-f200-87fc6efb411f@bytedance.com>
In-Reply-To: <d114834c-2336-673f-f200-87fc6efb411f@bytedance.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jul 2023 10:57:23 +0200
Message-ID: <CANn89iLBLBO0CK-9r-eZiQL+h2bwTHL2nR6az5Az6W_-pBierw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators of
 sockmem pressure
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Ahern <dsahern@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Breno Leitao <leitao@debian.org>, 
	David Howells <dhowells@redhat.com>, Jason Xing <kernelxing@tencent.com>, 
	Xin Long <lucien.xin@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 9:59=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> Gentle ping :)

I was hoping for some feedback from memcg experts.

You claim to fix a bug, please provide a Fixes: tag so that we can
involve original patch author.

Thanks.

>
> On 7/11/23 8:41 PM, Abel Wu wrote:
> > Now there are two indicators of socket memory pressure sit inside
> > struct mem_cgroup, socket_pressure and tcpmem_pressure.
> >
> > When in legacy mode aka. cgroupv1, the socket memory is charged
> > into a separate counter memcg->tcpmem rather than ->memory, so
> > the reclaim pressure of the memcg has nothing to do with socket's
> > pressure at all. While for default mode, the ->tcpmem is simply
> > not used.
> >
> > So {socket,tcpmem}_pressure are only used in default/legacy mode
> > respectively. This patch fixes the pieces of code that make mixed
> > use of both.
> >
> > Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> > ---
> >   include/linux/memcontrol.h | 4 ++--
> >   mm/vmpressure.c            | 8 ++++++++
> >   2 files changed, 10 insertions(+), 2 deletions(-)
> >


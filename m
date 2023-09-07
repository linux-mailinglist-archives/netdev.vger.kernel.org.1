Return-Path: <netdev+bounces-32412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7357975CB
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0428F280CE0
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E40F12B95;
	Thu,  7 Sep 2023 15:57:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FF125D3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:57:05 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5670F352BC
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 08:56:45 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-44ee1123667so1349217137.0
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694102082; x=1694706882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxNPWZQ/i/84FnRp6iBGShEREP/w3s4F4gHGjNX0pAo=;
        b=Gm+Ydpaa+ivkkrvyGTJjbQP5GM5tLSpssrJWIteb9Qx1lYVfQbg1AfnKm5qNLPE7Q7
         qYn40bjx+GPS9Rm/A25zyEJwB8QluZ1jfFdmkeH162t+oustVQW08lg3w0xsrWIqw1XX
         Tlhgijq8iYyoz9u5Loco2nsx923OSomS3B6ymB13Q4FTeMnmqMaoCR5/EQng3WKn/M5y
         ISE2mDM6Dv6RHGNwSrKRABfgeEtImdz4ZwdpmFBpGCs9eDlT8RG7ods7houWnI4vhqeJ
         sm6qOQyAJoKheaTdlvStiOdg4HpdOA1iFAK4xcO0zY9skWNuW+g9LSGbIJDmI1aJxhYo
         NQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102082; x=1694706882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxNPWZQ/i/84FnRp6iBGShEREP/w3s4F4gHGjNX0pAo=;
        b=MElfjUTPcLYxSYuiXJUQ5iP+jLRh941z6qXEQQGGk6rUeSEddtb9mvNQkgiBEzX8+K
         vkarqylDhotfVi2JDj8GE7wHpE3sP67PSQocgHiGk8lUN7/Nq/ItKt3cwV0HDCKCD9yP
         QZmFqlQciUp+OUMCCRrhfxoje6XX16O/P3HL2o0VKLhlgtX5uiN11P0PbVod3e8DgZnf
         fj1WY26iGcfhmeSYhAzvlTBBbye23Xv2GQOpqL9eNvGPzAknBvdVbywMB30+ZNBNWkIm
         Bd9sq7zotLqZJaa8pcakG+BUCVTE+qDOfCbvzjDTUuN+GsW1kfz6KyGiVCiCdQpiTLmD
         OjOQ==
X-Gm-Message-State: AOJu0Yz76ZTqQS1Bm0IVTy+o3P3462HXEI4Ap4nbIfwQkDmDSKS2zOjF
	vrLjnz2ViJcSuyaZ8fTyVtaXj0wm7F3IVdfUvPm3TWpxon4WqgGBMkru4R1a
X-Google-Smtp-Source: AGHT+IEOg5LfKX0C02pb1gSk+RC2vBPCNYo9PG1r8P93iC1VL2JsLi9eHqUv3mMy4GYd7vop+qI0RUCV3JFdRm/Nwwc=
X-Received: by 2002:a05:6102:2921:b0:450:77bf:3c18 with SMTP id
 cz33-20020a056102292100b0045077bf3c18mr2086861vsb.3.1694095696027; Thu, 07
 Sep 2023 07:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906201046.463236-1-edumazet@google.com> <20230906201046.463236-5-edumazet@google.com>
In-Reply-To: <20230906201046.463236-5-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 7 Sep 2023 10:07:59 -0400
Message-ID: <CADVnQynzDw6JK7CTtyTrNWiYENmOi12i9XXpEQ-+eB-dEg3fvQ@mail.gmail.com>
Subject: Re: [RFC net-next 4/4] tcp: defer regular ACK while processing socket backlog
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Soheil Hassas Yeganeh <soheil@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 6, 2023 at 4:10=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> This idea came after a particular workload requested
> the quickack attribute set on routes, and a performance
> drop was noticed for large bulk transfers.
>
> For high throughput flows, it is best to use one cpu
> running the user thread issuing socket system calls,
> and a separate cpu to process incoming packets from BH context.
> (With TSO/GRO, bottleneck is usually the 'user' cpu)
>
> Problem is the user thread can spend a lot of time while holding
> the socket lock, forcing BH handler to queue most of incoming
> packets in the socket backlog.
>
> Whenever the user thread releases the socket lock, it must first
> process all accumulated packets in the backlog, potentially
> adding latency spikes. Due to flood mitigation, having too many
> packets in the backlog increases chance of unexpected drops.
>
> Backlog processing unfortunately shifts a fair amount of cpu cycles
> from the BH cpu to the 'user' cpu, thus reducing max throughput.
>
> This patch takes advantage of the backlog processing,
> and the fact that ACK are mostly cumulative.
>
> The idea is to detect we are in the backlog processing
> and defer all eligible ACK into a single one,
> sent from tcp_release_cb().
>
> This saves cpu cycles on both sides, and network resources.
>
> Performance of a single TCP flow on a 200Gbit NIC:
>
> - Throughput is increased by 20% (100Gbit -> 120Gbit).
> - Number of generated ACK per second shrinks from 240,000 to 40,000.
> - Number of backlog drops per second shrinks from 230 to 0.
>
> Benchmark context:
>  - Regular netperf TCP_STREAM (no zerocopy)
>  - Intel(R) Xeon(R) Platinum 8481C (Saphire Rapids)
>  - MAX_SKB_FRAGS =3D 17 (~60KB per GRO packet)
>
> This feature is guarded by a new sysctl, and enabled by default:
>  /proc/sys/net/ipv4/tcp_backlog_ack_defer
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Neal Cardwell <ncardwell@google.com>

Yet another fantastic optimization. Thanks, Eric!

neal


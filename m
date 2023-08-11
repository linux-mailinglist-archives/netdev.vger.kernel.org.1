Return-Path: <netdev+bounces-26625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B523D778627
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 05:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601B0281EB6
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 03:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD6D10E2;
	Fri, 11 Aug 2023 03:44:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA3EA5
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 03:44:14 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16102D44
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 20:44:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f14865fcc0so1352e87.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 20:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691725452; x=1692330252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf2sysDYKA/7QZA+e13rp979FmH4xLq69U2IkRQ3KlI=;
        b=4o0GNZpVHrAMJvtWfJF1DtgXBeIhW0mOUUL9d/sIqXucXmNGcZhSlwpuuAeWAW7Mw/
         vtL2hD2Bo2tk+yYQjf42zw8CPoVebRjlBPih+7ZhV+pu3NRrIu5su2NylV7btJYQ1tCw
         kIo78Ws+2cuvutZge6zVllsHnjl3PDeQ4TfsxRzwr1etpbI+39LcDT/TsujoJkbsey9p
         8925U4lCF7GgTc/6Efd7ylb146/0DZft+jbAo8IFm2F4evFutAUVbC0G1NSBmTlcJ8CC
         IjQZ6r600XS6taKExVFJBDB4yyT9vIMya2Co3/1VWAdWaC1L0uZb/+OzJfQZyHeZRu8k
         oTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691725452; x=1692330252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tf2sysDYKA/7QZA+e13rp979FmH4xLq69U2IkRQ3KlI=;
        b=cP8myE/u4meUSmFypUv50BZH/rfpqZn906mm3UMprg7HTzkFOOcZdaWZkjK74BWvFe
         JifxYQbUl1TSJfD40YIlzY8aXKNsjHvnWWqGlV+5Gp03uVZlk2cfTZ/YrDp6v0chEERM
         2Nby8BCpuZHAaSEGpnpbHsAAwElUcBZ7ce+CMi+zAoUAFkZylazUlxE5M4wBj8un+5gp
         kgG9oK3DTChBYglIDf29Y1Mu15z4qiG+w36gVTQ7UFPPyJ82KVmMlKS2J5o+j29/Z6t+
         LZGKsd9+lT8SMPFmLmHznG/tzLgswIxZt3XT+xMgeCz+HlD401vAqLkiRN9NZGWQkshL
         pKuQ==
X-Gm-Message-State: AOJu0YwsQXx/3+dQLml6bmNvR/mTreV3+pWi+16V70PDfn0VuOV+pZRy
	gi+ovUkhGp6WNS50WGUHBQ0sKA+eKRpNETeDhJ1n9Voof9lVKT+zzTo=
X-Google-Smtp-Source: AGHT+IEh3EEBdNpBgyMz+1/dKWsFBvPcNtjDJFkOCbV0mom3IadYFnGpHpCNFI/xSc3BC3dHP+m9xkTtMVAscV4LOk0=
X-Received: by 2002:ac2:593a:0:b0:4fe:3fb3:902d with SMTP id
 v26-20020ac2593a000000b004fe3fb3902dmr31170lfi.5.1691725451566; Thu, 10 Aug
 2023 20:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810103927.1705940-1-edumazet@google.com>
In-Reply-To: <20230810103927.1705940-1-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Thu, 10 Aug 2023 23:43:35 -0400
Message-ID: <CACSApvaWomz6GERnrVbNEG2ycpKJqMGAhsqLwMvYxPQpW2a+pg@mail.gmail.com>
Subject: Re: [PATCH net-next 00/15] inet: socket lock and data-races avoidance
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 6:39=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In this series, I converted 20 bits in "struct inet_sock" and made
> them truly atomic.
>
> This allows to implement many IP_ socket options in a lockless
> fashion (no need to acquire socket lock), and fixes data-races
> that were showing up in various KCSAN reports.
>
> I also took care of IP_TTL/IP_MINTTL, but left few other options
> for another series.

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

They all look great. Thank you!

> Eric Dumazet (15):
>   inet: introduce inet->inet_flags
>   inet: set/get simple options locklessly
>   inet: move inet->recverr to inet->inet_flags
>   inet: move inet->recverr_rfc4884 to inet->inet_flags
>   inet: move inet->freebind to inet->inet_flags
>   inet: move inet->hdrincl to inet->inet_flags
>   inet: move inet->mc_loop to inet->inet_frags
>   inet: move inet->mc_all to inet->inet_frags
>   inet: move inet->transparent to inet->inet_flags
>   inet: move inet->is_icsk to inet->inet_flags
>   inet: move inet->nodefrag to inet->inet_flags
>   inet: move inet->bind_address_no_port to inet->inet_flags
>   inet: move inet->defer_connect to inet->inet_flags
>   inet: implement lockless IP_TTL
>   inet: implement lockless IP_MINTTL
>
>  include/net/inet_connection_sock.h  |   4 +-
>  include/net/inet_sock.h             |  92 ++++---
>  include/net/ipv6.h                  |   3 +-
>  include/net/route.h                 |   2 +-
>  include/net/tcp.h                   |   2 +-
>  net/core/sock.c                     |   2 +-
>  net/dccp/ipv4.c                     |   4 +-
>  net/ipv4/af_inet.c                  |  16 +-
>  net/ipv4/cipso_ipv4.c               |   4 +-
>  net/ipv4/igmp.c                     |   2 +-
>  net/ipv4/inet_diag.c                |  22 +-
>  net/ipv4/inet_timewait_sock.c       |   2 +-
>  net/ipv4/ip_output.c                |   7 +-
>  net/ipv4/ip_sockglue.c              | 405 +++++++++++++---------------
>  net/ipv4/netfilter/nf_defrag_ipv4.c |   2 +-
>  net/ipv4/ping.c                     |   7 +-
>  net/ipv4/raw.c                      |  26 +-
>  net/ipv4/route.c                    |   8 +-
>  net/ipv4/tcp.c                      |  12 +-
>  net/ipv4/tcp_fastopen.c             |   2 +-
>  net/ipv4/tcp_input.c                |   2 +-
>  net/ipv4/tcp_ipv4.c                 |   5 +-
>  net/ipv4/tcp_minisocks.c            |   3 +-
>  net/ipv4/udp.c                      |   7 +-
>  net/ipv4/udp_tunnel_core.c          |   2 +-
>  net/ipv6/af_inet6.c                 |   8 +-
>  net/ipv6/datagram.c                 |   2 +-
>  net/ipv6/ip6_output.c               |   5 +-
>  net/ipv6/ipv6_sockglue.c            |  12 +-
>  net/ipv6/raw.c                      |  16 +-
>  net/ipv6/udp.c                      |   2 +-
>  net/l2tp/l2tp_ip.c                  |   2 +-
>  net/mptcp/protocol.c                |  12 +-
>  net/mptcp/sockopt.c                 |  16 +-
>  net/netfilter/ipvs/ip_vs_core.c     |   4 +-
>  net/sctp/input.c                    |   2 +-
>  net/sctp/protocol.c                 |   2 +-
>  net/sctp/socket.c                   |   2 +-
>  38 files changed, 364 insertions(+), 364 deletions(-)
>
> --
> 2.41.0.640.ga95def55d0-goog
>


Return-Path: <netdev+bounces-27018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F56779E91
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 11:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7FE2805FD
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D761CCD4;
	Sat, 12 Aug 2023 09:33:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158EA1CCC6
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 09:33:49 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CE5DA
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:33:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-586a5cd0ea9so33349287b3.2
        for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691832826; x=1692437626;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4rS4CCxfpoiukbOIxgBFGUKKJf7qqCnJZN5NzTeoFLk=;
        b=ets8+9LnJH81VPhXNGqv2p1mRixHbIdCVhyY8e219U6tyEIrQnW+fyDhVHmDDUcpl+
         Tm0HYppRHuKMg15hP5gkuQY/VwcGjyBbkK3vDrS4SoL3zMZelqS3NuIN6fLFhUXAWvxR
         VvvqZ8FgJgj1cyfROtDzw6NhGHt15/KSks/7fqTz8slVZnOtq+MhmEZciSn7VU1n32Ch
         cl75RP6KjA+wTlw8x5i1KkUkos8tXRtKVK/Je1t7Bl3J1cNY4uQpLalI2JjVmCeq6XLQ
         UuM6xqN0YD40o3ayFJVFkKTYEzbw4mUpjwY56Vc2HCphW7SbrFXXrAZD8q18JN2o62QL
         70LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691832826; x=1692437626;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rS4CCxfpoiukbOIxgBFGUKKJf7qqCnJZN5NzTeoFLk=;
        b=OlnlEUevm262hx2X8f1plr4ckpdbuEprSXsw/6uKSwsC1OO1NLgqDE2OxHbFUptEkq
         mHVAV4ieCVexs9/tS+OEuF/a8h4UQ2DF4UER04lGqY81eoQQcH7NUEtXmWwZ7LOOl9HF
         bkI4EIP0Ma6jmZpAfQ4Azrl69H5ehgNdKnKTVrk7N6ZRozE81ZDfJsGiG5i5D/fA+yZ7
         F3oLRa/G8ZC/4qVWWuPms4G7c5clEAK/sLFZxtoee+guITYhsX3Jb4i+QsgZMGHX2x13
         cENKhpsVf22zYNvWjUY2lHnEtqVmpYSUSgZL+9gIw2jDKsUNFGriUOEy/htElwmrJ2E/
         DZ9Q==
X-Gm-Message-State: AOJu0YwoS+aYWIBksNnRrly8k3q17AioZDEjrhGfHZnkMvaWV4LBp7ML
	G3MjReHtRbi1DeGaceKCODX5BpVOWjM0uQ==
X-Google-Smtp-Source: AGHT+IGaTiMZ+w9dxSllC1PYi/mdz8Sx5YB0eB8g8kdQ+ifBtc24D9tGpseEYbdzsH2GPaNXeIJuKiu3phXvEw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1820:b0:cb6:6c22:d0f8 with SMTP
 id cf32-20020a056902182000b00cb66c22d0f8mr65487ybb.4.1691832826029; Sat, 12
 Aug 2023 02:33:46 -0700 (PDT)
Date: Sat, 12 Aug 2023 09:33:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230812093344.3561556-1-edumazet@google.com>
Subject: [PATCH v3 net-next 00/15] inet: socket lock and data-races avoidance
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In this series, I converted 20 bits in "struct inet_sock" and made
them truly atomic.

This allows to implement many IP_ socket options in a lockless
fashion (no need to acquire socket lock), and fixes data-races
that were showing up in various KCSAN reports.

I also took care of IP_TTL/IP_MINTTL, but left few other options
for another series.

v3: fixed patch 7, feedback from build bot about ipvs set_mcast_loop()

v2: addressed a feedback from a build bot in patch 9 by removing
 unused issk variable in mptcp_setsockopt_sol_ip_set_transparent()
 Added Acked-by: tags from Soheil (thanks!)

Eric Dumazet (15):
  inet: introduce inet->inet_flags
  inet: set/get simple options locklessly
  inet: move inet->recverr to inet->inet_flags
  inet: move inet->recverr_rfc4884 to inet->inet_flags
  inet: move inet->freebind to inet->inet_flags
  inet: move inet->hdrincl to inet->inet_flags
  inet: move inet->mc_loop to inet->inet_frags
  inet: move inet->mc_all to inet->inet_frags
  inet: move inet->transparent to inet->inet_flags
  inet: move inet->is_icsk to inet->inet_flags
  inet: move inet->nodefrag to inet->inet_flags
  inet: move inet->bind_address_no_port to inet->inet_flags
  inet: move inet->defer_connect to inet->inet_flags
  inet: implement lockless IP_TTL
  inet: implement lockless IP_MINTTL

 include/net/inet_connection_sock.h  |   4 +-
 include/net/inet_sock.h             |  92 ++++---
 include/net/ipv6.h                  |   3 +-
 include/net/route.h                 |   2 +-
 include/net/tcp.h                   |   2 +-
 net/core/sock.c                     |   2 +-
 net/dccp/ipv4.c                     |   4 +-
 net/ipv4/af_inet.c                  |  16 +-
 net/ipv4/cipso_ipv4.c               |   4 +-
 net/ipv4/igmp.c                     |   2 +-
 net/ipv4/inet_diag.c                |  22 +-
 net/ipv4/inet_timewait_sock.c       |   2 +-
 net/ipv4/ip_output.c                |   7 +-
 net/ipv4/ip_sockglue.c              | 405 +++++++++++++---------------
 net/ipv4/netfilter/nf_defrag_ipv4.c |   2 +-
 net/ipv4/ping.c                     |   7 +-
 net/ipv4/raw.c                      |  26 +-
 net/ipv4/route.c                    |   8 +-
 net/ipv4/tcp.c                      |  12 +-
 net/ipv4/tcp_fastopen.c             |   2 +-
 net/ipv4/tcp_input.c                |   2 +-
 net/ipv4/tcp_ipv4.c                 |   5 +-
 net/ipv4/tcp_minisocks.c            |   3 +-
 net/ipv4/udp.c                      |   7 +-
 net/ipv4/udp_tunnel_core.c          |   2 +-
 net/ipv6/af_inet6.c                 |   8 +-
 net/ipv6/datagram.c                 |   2 +-
 net/ipv6/ip6_output.c               |   5 +-
 net/ipv6/ipv6_sockglue.c            |  12 +-
 net/ipv6/raw.c                      |  16 +-
 net/ipv6/udp.c                      |   2 +-
 net/l2tp/l2tp_ip.c                  |   2 +-
 net/mptcp/protocol.c                |  12 +-
 net/mptcp/sockopt.c                 |  19 +-
 net/netfilter/ipvs/ip_vs_core.c     |   4 +-
 net/netfilter/ipvs/ip_vs_sync.c     |   4 +-
 net/sctp/input.c                    |   2 +-
 net/sctp/protocol.c                 |   2 +-
 net/sctp/socket.c                   |   2 +-
 39 files changed, 365 insertions(+), 370 deletions(-)

-- 
2.41.0.640.ga95def55d0-goog



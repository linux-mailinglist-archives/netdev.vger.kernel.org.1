Return-Path: <netdev+bounces-26278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F960777618
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C61280F40
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1E11F18F;
	Thu, 10 Aug 2023 10:39:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B791E52A
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:39:35 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C271F2D7F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58667d06607so10829387b3.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691663969; x=1692268769;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e+hDhSHb/FecrAvhey9eS90lS0qohgtOWZrXgClfO5o=;
        b=Izwicvm4QJPg3OmbMft1XdDwv/5Ng7XJK+L1Kgb/BfX8UkbE5V8tIfsgeNjDFBdesK
         ZWkWmJqJHfNxWaylpl7OdyuPF7lMTQu8Ttd6GMgQl0agL7UfGD2c/qlClC1BYifYq4/B
         8G+BoHO34PpoDuVIft2OdQ3OKPbZ0zjiOBpoTC+WzBHf1nTB6Hmgp0H12HHjopIy36Fc
         wJLN8F8V/j5UxnM1BQgr0kjpnrDRSx26GqRPQKVP2KZ82AhI+m1vPvyhh6Fx+FOFiS8q
         ohYj+ijyqGhJgoDOcnogdQZF3QOlQEY+A+H71xBIx0p3lhmSbOw1tMfhhmPtVDRZ6qwm
         jn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663969; x=1692268769;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+hDhSHb/FecrAvhey9eS90lS0qohgtOWZrXgClfO5o=;
        b=YU4G7HmR2wL6ppqBbvPxqwDr4gw0NsHV3uI0+FJkURAuqhP5LPRGNoizNF0LYr+Nz7
         WDrRLZ5WqSA17cYWR/rIAOS9ABh5DP4crxZhZNFRDJLWeeGaW960jkb8/lmkaAV2FRMl
         XLp+s80MHqiMOKz8D6kFWer/ToRQVtNb3/JBWS+wb6aqV6IfwBfcYkA2Yphk79lctGww
         dXPBjF+IjEZC8Ot7luPMWxzBsD5dUKa+ej2tyQsgTZz+pYjgEpZUokJ8Sljacmi33jY6
         2srDAMiLwCCt2+8zIGnJhZ5/p7DKmwlIYMHlpO8F2NEEy+Yk92dDtPICEEuokiXB59b+
         JQjA==
X-Gm-Message-State: AOJu0YypSKzhfbpYcizbUQgJogXc4ZWmWoDW2/2qMtiTjFwbdrXEi8MY
	F60FRnFswysYlfl8uYuKNw7Abogoz7DeFQ==
X-Google-Smtp-Source: AGHT+IEbQhyGxqXeyfjT8zWURFrKIwfJZGW1WovF0JOaI9o/3Y+/gUlv61fSjTXMREylh918HDKD+YcG8vY7EA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:aa06:0:b0:d08:8cf5:c5d8 with SMTP id
 s6-20020a25aa06000000b00d088cf5c5d8mr29663ybi.5.1691663968998; Thu, 10 Aug
 2023 03:39:28 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:39:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810103927.1705940-1-edumazet@google.com>
Subject: [PATCH net-next 00/15] inet: socket lock and data-races avoidance
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
 net/mptcp/sockopt.c                 |  16 +-
 net/netfilter/ipvs/ip_vs_core.c     |   4 +-
 net/sctp/input.c                    |   2 +-
 net/sctp/protocol.c                 |   2 +-
 net/sctp/socket.c                   |   2 +-
 38 files changed, 364 insertions(+), 364 deletions(-)

-- 
2.41.0.640.ga95def55d0-goog



Return-Path: <netdev+bounces-26653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2FD77884B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A72F1C21128
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1971A4406;
	Fri, 11 Aug 2023 07:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44B1117
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:36:24 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C51BE73
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d66af3c8ac7so566169276.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739383; x=1692344183;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f9QZOsVC9WvAjcXR31lR0yTnNmgGYv/UqiIn7h8suB4=;
        b=du5+2mZZroPu1ofNqVuNcg704DrlwSBoY0eBDaIwWi/G9YaAsXL8Yh02Mw1m3NnLSo
         HdudxUxjYF9cEVOzdYF3wpLU17mMgFPO7GFxwytYGtyyC+4M7Av5NKX2O5/lQBfPAagC
         dIrnO15OMGYz2ldzlMPwfQFP3cvBjP20QBOknKK70yaG3Kbbi2NCgLNFa2eTW//ePPLF
         Nj2euvGQrfVvegcamZsOmN7kvK8E99cUP3vALSTvTW1RNoO7NYAHKbU8gsRDTss367hV
         u+hcswiZ9m1TyS1LTd3p0yv/W+aMEo5vYZytfYp0n1sJsNvqARyMFkqjtHNlIV2dKpvd
         ZJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739383; x=1692344183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9QZOsVC9WvAjcXR31lR0yTnNmgGYv/UqiIn7h8suB4=;
        b=X1/VnqpuNuS2vT6RVo7NVXjotdbG60RLqHJStoezuWd1DB9rSswt+CHPCpvVlGCtjf
         Y2DB52HouXsYvSALZKL6pb0BT4Hy3HI3SxfufrxZrdO8tjKam1Dq/GZSsKx6vlVI6bBh
         49RCELpd018Jz/IQSM8S1sTInAG8Ld03np+Mqq7qQrscQW3YGG6HQr4W+0Fca/fPFMwo
         P1atOGyzhPteNcJWfZN3nYzwOu9Nu54gQrsZPXEuBca1SzDVzp4OHHCAPO8Ewb0528zU
         dJ0mdtc+03uVRnpen29shXoRN4ke82f050epk7uSSHkq87Wzcwxb1tzdprz4UsWElXcw
         dDxw==
X-Gm-Message-State: AOJu0YygRWQtKZlQZUxZxpRJTOkZIEPVYZk0n7wHlG5Xw4/3U8QRBk7l
	hqcvv1q4rGeFz/HLpecAfr9IZzwWU4BavQ==
X-Google-Smtp-Source: AGHT+IHpJtpQN2/wY15pIiffKfrjzwImlW9z7e++rmsFYtfUOwjZCDJuIaFHZ1/y3kpL82sSFvYoZLAjNiIf+g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:4c:0:b0:d14:6868:16a3 with SMTP id
 e12-20020a5b004c000000b00d14686816a3mr13509ybp.5.1691739382889; Fri, 11 Aug
 2023 00:36:22 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:36:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811073621.2874702-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/15] inet: socket lock and data-races avoidance
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
 net/sctp/input.c                    |   2 +-
 net/sctp/protocol.c                 |   2 +-
 net/sctp/socket.c                   |   2 +-
 38 files changed, 364 insertions(+), 367 deletions(-)

-- 
2.41.0.640.ga95def55d0-goog



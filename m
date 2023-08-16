Return-Path: <netdev+bounces-27945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C47F77DBE5
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E522817E8
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C67D2EA;
	Wed, 16 Aug 2023 08:15:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4746C8E2
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:15:53 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A52EE
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:15:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d664f9c5b92so5876519276.3
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692173751; x=1692778551;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=92nooN2gcciXN7ScC2kwKQiiuhAuAa9h51MEX5py7cY=;
        b=LbaG3nQcylIp7uEIBD3p51RPfve/ZQMFzPTTpVvEkHxrE+Q59DuDuyKsCfZu+dXY+v
         NznKL42aNG4QgRbaKfpRf3CeX6LN0f/hhMPS9GAmUgBKRzQBiekDAK6oTP1gQG+mOjK2
         6BKIp5fdp96KA0LjDMA7XSPsJdGkkjo+ExcEucMUvYQKDDg9Gq7gZ011VYDvTiKmyfxQ
         TofGKBe2AecukD9R31Ip3L9FqxoJ5tKnwLfJkBSxpnaxFBQ8k9dIiEDX1rDnCac/LRu8
         Y07xeC3n3j7kKsomeFlBpaPIxX/XYQzAGebIKafniVbhIbLZ6sCphav2w4mCXRxG8dF3
         3oMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173751; x=1692778551;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=92nooN2gcciXN7ScC2kwKQiiuhAuAa9h51MEX5py7cY=;
        b=O1VQ9XICVdr+8qmT3Dregkm8S4EdLnffbahfa0ew5yA/eEwNpcUKokpFH+FD99+OPw
         TFQEC6pxxBmLXCHNXcTQpwTj+jb70AfSzaR05Q63g/u3FAyjjqEv91Uj0v73rDIQf2su
         +FZQdCJ/M6/F5DpXfxrynu6iiXZn/ZT0411GHMaGEOclBmUll0e5IYPSjCUqjYBZHV3S
         Tcx0ScpcNZeSeNfqKqIxZV0oUn1kyBJ29vnV4Pf231s05Kr/WCnW3yernR+gxyyiRsaF
         DtxDIDisE7ck4Ci/t1sbXH9Pk36jUlbtauco0UO6DBmY9QK01s7c3EMcBtT6D++MJVGU
         DAjQ==
X-Gm-Message-State: AOJu0Yyy1L3nOHWaslqM/hV+vPvCirr2wGlHwKY/3R25Th39ghuLxPIL
	WJq7PGe6GgUuK0pilnHmmMDXt7EWPhrStQ==
X-Google-Smtp-Source: AGHT+IGJ5iGaqZK/x+jLiSFVQn7w4u+YI2oO7y4SI4lZIYERGy7lUBLErI+T1YE8RHdXACetPCDQ0mTH899nzQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ada7:0:b0:d18:73fc:40af with SMTP id
 z39-20020a25ada7000000b00d1873fc40afmr12757ybi.5.1692173751469; Wed, 16 Aug
 2023 01:15:51 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:15:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816081547.1272409-1-edumazet@google.com>
Subject: [PATCH v4 net-next 00/15] inet: socket lock and data-races avoidance
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In this series, I converted 20 bits in "struct inet_sock" and made
them truly atomic.

This allows to implement many IP_ socket options in a lockless
fashion (no need to acquire socket lock), and fixes data-races
that were showing up in various KCSAN reports.

I also took care of IP_TTL/IP_MINTTL, but left few other options
for another series.

v4: Rebased after recent mptcp changes.
  Added Reviewed-by: tags from Simon (thanks !)

v3: fixed patch 7, feedback from build bot about ipvs set_mcast_loop()

v2: addressed a feedback from a build bot in patch 9 by removing
 unused issk variable in mptcp_setsockopt_sol_ip_set_transparent()
 Added Acked-by: tags from Soheil (thanks !)

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
 net/mptcp/protocol.c                |  10 +-
 net/mptcp/sockopt.c                 |  18 +-
 net/netfilter/ipvs/ip_vs_core.c     |   4 +-
 net/netfilter/ipvs/ip_vs_sync.c     |   4 +-
 net/sctp/input.c                    |   2 +-
 net/sctp/protocol.c                 |   2 +-
 net/sctp/socket.c                   |   2 +-
 39 files changed, 362 insertions(+), 370 deletions(-)

-- 
2.41.0.694.ge786442a9b-goog



Return-Path: <netdev+bounces-33298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E9879D599
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0350C281AA5
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231D218C2F;
	Tue, 12 Sep 2023 16:02:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCC18C2C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:15 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77472170F
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b6083fa00so44906627b3.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534534; x=1695139334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S9AnJUNYbnVUaMI57dfep9DWypATAvpAdqw2b9QesX4=;
        b=yRLwZU3xEg41wqDqKJiGbCVgnNNmLiQ7JwAsS6n/2UUU96SSR5iI6pWCMjlJzIWSs/
         CY0o9oKfxRN+wFG9Eq9Owaixdlf707ekxFn7N5og3pCwyphtw6usew/vT8DUJVrdL0gY
         19wokOWsL1oPZSSHYUf9SiLmMjvFR0X0SwE+lSb+uCXaU1GOssyg0h0eUOVsWin+hSQh
         Hk4LKQACr0e5M8bQ8HwCjyfwG+z/OxT1NKLiHqwwLk2hqevsy8Pgmq64qpm/N3y+SxEx
         U76tRJfQBo3GE5gUwyxkueC2th5VJYPpj6nBPp9VRNSaLVxhHzFqIZurToA/d7NtAN1Y
         seIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534534; x=1695139334;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9AnJUNYbnVUaMI57dfep9DWypATAvpAdqw2b9QesX4=;
        b=ifWUw7iHNFAEYkH+Wx6SuLJs8NBn0slhpeASrCJpx2e8eIYT2KpMGjOT6q3bpfFzbG
         92xeyXHdd7w3UtvqVFvSzmQ1cfozHqjpS3PgFsRLVH6WwSLfbXEgpIftnL5e411No0hC
         T63HJGVL+fCIq14EeIlc7Vqa+3wU71ogek7hiZ2DUvYn9zdg03miR/gCiwBZ1kOaNgnL
         Ia8p4YiinfhIzDngdX3YTZ74XiMh7duzQrhcN25NlzhRkb3s+o/lKNq04sPkMXLVVio4
         v3i/OkuXUmkp1/MbrlxeVgC09A16ioIZ6pBjRbZ9rQj1e3YKgaYuK1c3DAoNqkcCNwn0
         s3Ng==
X-Gm-Message-State: AOJu0Yx67im1SLpo5gYviAO+SFEbVsWQzB6168uKTLiMK630rZhZ44zt
	/WvSC+/y3rrBwSMUnGm+7z1VSQxqbJcFMw==
X-Google-Smtp-Source: AGHT+IGH9tMEtsQPrXjm+5MqMMR6+P94nVmEZN6MqSU/Q9MMhkuteIrNUa+GoHgTnAYLCYjmWnGsS/eSA61LCQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:aa73:0:b0:d72:8661:ee25 with SMTP id
 s106-20020a25aa73000000b00d728661ee25mr277951ybi.2.1694534534637; Tue, 12 Sep
 2023 09:02:14 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:01:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-1-edumazet@google.com>
Subject: [PATCH net-next 00/14] ipv6: round of data-races fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is inspired by one related syzbot report.

Many inet6_sk(sk) fields reads or writes are racy.

Move 1-bit fields to inet->inet_flags to provide
atomic safety. inet6_{test|set|clear|assign}_bit() helpers
could be changed later if we need to make room in inet_flags.

Also add missing READ_ONCE()/WRITE_ONCE() when
lockless readers need access to specific fields.

np->srcprefs will be handled separately to avoid merge conflicts
because a prior patch was posted for net tree.

Eric Dumazet (14):
  ipv6: lockless IPV6_UNICAST_HOPS implementation
  ipv6: lockless IPV6_MULTICAST_LOOP implementation
  ipv6: lockless IPV6_MULTICAST_HOPS implementation
  ipv6: lockless IPV6_MTU implementation
  ipv6: lockless IPV6_MINHOPCOUNT implementation
  ipv6: lockless IPV6_RECVERR_RFC4884 implementation
  ipv6: lockless IPV6_MULTICAST_ALL implementation
  ipv6: lockless IPV6_AUTOFLOWLABEL implementation
  ipv6: lockless IPV6_DONTFRAG implementation
  ipv6: lockless IPV6_RECVERR implemetation
  ipv6: move np->repflow to atomic flags
  ipv6: lockless IPV6_ROUTER_ALERT_ISOLATE implementation
  ipv6: lockless IPV6_MTU_DISCOVER implementation
  ipv6: lockless IPV6_FLOWINFO_SEND implementation

 include/linux/ipv6.h            |  49 +++----
 include/net/inet_sock.h         |  10 ++
 include/net/ip6_route.h         |  14 +-
 include/net/ipv6.h              |  16 +--
 include/net/sock.h              |   2 +-
 include/net/xfrm.h              |   2 +-
 net/core/sock.c                 |   4 +-
 net/dccp/ipv6.c                 |   8 +-
 net/ipv4/ping.c                 |   5 +-
 net/ipv6/af_inet6.c             |   9 +-
 net/ipv6/datagram.c             |  15 +--
 net/ipv6/icmp.c                 |   4 +-
 net/ipv6/ip6_flowlabel.c        |   8 +-
 net/ipv6/ip6_output.c           |  42 +++---
 net/ipv6/ipv6_sockglue.c        | 223 +++++++++++++++-----------------
 net/ipv6/mcast.c                |   4 +-
 net/ipv6/ndisc.c                |   4 +-
 net/ipv6/ping.c                 |   4 +-
 net/ipv6/raw.c                  |  16 +--
 net/ipv6/tcp_ipv6.c             |  21 ++-
 net/ipv6/udp.c                  |  12 +-
 net/l2tp/l2tp_ip6.c             |   6 +-
 net/netfilter/ipvs/ip_vs_sync.c |  12 +-
 net/sctp/ipv6.c                 |   7 +-
 24 files changed, 238 insertions(+), 259 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog



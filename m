Return-Path: <netdev+bounces-35646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B113E7AA75A
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 05:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CCA82281EB6
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D9A34;
	Fri, 22 Sep 2023 03:42:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CA81E
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:42:25 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DCCCC
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59ee66806d7so22315847b3.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695354143; x=1695958943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=anjdTXiUPM12rmg4moVUIWc6A1ZQw3U2q++ioHc0ON8=;
        b=eMwM9MnM2RWTQZILfQsnn2CJyXf9I9Lpwx1nPxgUENPTHsZe+YVOKHN97QYJyHy6I4
         /H6YY4mNmtRf/aJIaSDajjIksx/dCwzwNiZT9VbI48VGAR96Ci/3rsK7DeQtFP7sy0yd
         LcTjUB9SMfaayZY1If0uJhgcJ9nRGlmQdbUx68vehPikD3YvfuozyXAHcXSsqPB9aYbF
         Nakoi/hH+eApNFyg9C4CuSDKCqvBkGmdreCCLMVZjoDlhl1t/YZGvySIl8tqiq+uLpU7
         la7+5QaN7S/7H2AGr5HKOAVvywaMy/TjzXlo8Pbk4yq9N11gBieG0PZHIoDG2f/l7U4x
         J3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695354143; x=1695958943;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=anjdTXiUPM12rmg4moVUIWc6A1ZQw3U2q++ioHc0ON8=;
        b=aQB5RrVGinlhtPz7SJiIHRJeHYO0opaDjK7EJfk5CIw9hoKN1II7STRuGiAFeLBFwd
         /XmkgqPY0gZyXHTPXBO3CPPD5kTyJyAoCuddITy9E/csbBTDHjvx5S4Hjgk2KV29jnUT
         gs/7/3vpwxE1SjZzDfnqtMw17FAAwbKDziZpqfgAcEQfGFJg66oLshnKsiqA8zm5SCna
         Xw+GOs3Ddn9Zdat9Wd7cNZ9rkv7qgTXihZvJDgo3+woiOjEX5/ZVNF303xTWafhJRhTN
         unBn6bIuoapC+KzdQcXkT2xNlj4vL4rIkQKC6E2Vc/k/fCIY7T4E/0Ay2h3nswthvkoV
         Zv7w==
X-Gm-Message-State: AOJu0YxPzt2VHS50JRVIB/vw6NiPhPRCvIe+COXyIUTy+4zIDBXn1jvZ
	Sdi1s2n+n6obi/dqFVlG4gndZRs9vSj5Kg==
X-Google-Smtp-Source: AGHT+IFBmlrlF/LN77UrpNUXA0gaKqsX0HU4nInSyrav1pK5IuMfrnUpN33kbjWUuS+1ZCkINnfsR2ZNGPoh+Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4526:0:b0:59b:c6bb:babb with SMTP id
 s38-20020a814526000000b0059bc6bbbabbmr129550ywa.6.1695354143359; Thu, 21 Sep
 2023 20:42:23 -0700 (PDT)
Date: Fri, 22 Sep 2023 03:42:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922034221.2471544-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/8] inet: more data-race fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series fixes some existing data-races on inet fields:

inet->mc_ttl, inet->pmtudisc, inet->tos, inet->uc_index,
inet->mc_index and inet->mc_addr.

While fixing them, we convert eight socket options
to lockless implementation.

v2: addressed David Ahern feedback on ("inet: implement lockless IP_TOS")
    Added David Reviewed-by: tag on other patches.

Eric Dumazet (8):
  inet: implement lockless IP_MULTICAST_TTL
  inet: implement lockless IP_MTU_DISCOVER
  inet: implement lockless IP_TOS
  inet: lockless getsockopt(IP_OPTIONS)
  inet: lockless getsockopt(IP_MTU)
  inet: implement lockless getsockopt(IP_UNICAST_IF)
  inet: lockless IP_PKTOPTIONS implementation
  inet: implement lockless getsockopt(IP_MULTICAST_IF)

 include/net/ip.h                              |  16 +-
 include/net/route.h                           |   4 +-
 net/dccp/ipv4.c                               |   2 +-
 net/ipv4/datagram.c                           |   6 +-
 net/ipv4/inet_diag.c                          |   2 +-
 net/ipv4/ip_output.c                          |  13 +-
 net/ipv4/ip_sockglue.c                        | 192 ++++++++----------
 net/ipv4/ping.c                               |   8 +-
 net/ipv4/raw.c                                |  19 +-
 net/ipv4/tcp_ipv4.c                           |   9 +-
 net/ipv4/udp.c                                |  18 +-
 net/mptcp/sockopt.c                           |   8 +-
 net/netfilter/ipvs/ip_vs_sync.c               |   4 +-
 net/sctp/protocol.c                           |   4 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |   2 +-
 15 files changed, 150 insertions(+), 157 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog



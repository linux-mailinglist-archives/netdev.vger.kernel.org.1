Return-Path: <netdev+bounces-22305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0AB767011
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9040F1C2192C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8697F13FEF;
	Fri, 28 Jul 2023 15:03:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A9213FEA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:23 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A83AAC
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1bcb99b518so2042512276.2
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556601; x=1691161401;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kpoWeFy/uPhxOfGBdf+GpE2eoImza0e02FiHUh5gE9c=;
        b=7dVHdDLJ7oLHr3+xSSya1i2eItIatQ7uMRfCgckxOXbCrbhQGsA5jliNZri9M4qJjT
         RgPOoQ05nAlk4XjhkpRk4WevESM+3gTALS3nGHiWQGhG7YHkqMuIuZbjMUBGIHSY4eb3
         lUEshldze4VQEGj2JwLu7FcN66PxU8Jghtq57GasJccXGjuNWmeTPhqaJbetkyequQX3
         SscHBDHQl+k85l70FWf1VSXsMoFeubIR0R6hWEscef7FM8YMVFi5A7kjfMZoHRaCNsQO
         PJDr4h6g88MtyN8uSy/MBkOnFnZv/JyZ/ITjsd5ePP74YyXRtUnzhy64O5dr+PGS+hMf
         ZGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556601; x=1691161401;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpoWeFy/uPhxOfGBdf+GpE2eoImza0e02FiHUh5gE9c=;
        b=KCKdDHrTzcb8uBQqZryFrBjCqP4NwxO7+8DEQmZhwCloFh1OvrZ5xOechRDaa5wHnf
         iHZs5YYsq21f2bDcW/GKgLjKlgf+Yi28HvqJ/q5ROirr0WKqLho0wlRtDG8NsNCDCEUm
         t63S5lVW/LzWAtAFt2x3+rPzSQVHhaGwnE7g7H5Iak3kQKR9zj7WRcV+LualqlEtg+9s
         nBzSm9kA1I4+Vfji0DFCe/NZgbpjLo0BnFIU+r2j5a6iuAnRzVKdpR7rAwJra0IXmR3t
         /61Ov7MalIedgCbyFbou/gx3ZXnQg+kCiz78o4mIj2ZCwW8UNbIuwZD4zfoevnKi2tOh
         1y5A==
X-Gm-Message-State: ABy/qLbOAlWIhUfwyF3xWTC+0sEnWJv4WWYEG2gXeZv89LmtTynjxc2z
	pGTw+XES1T2hA4Nmej4DMy/n5hMuk35ntg==
X-Google-Smtp-Source: APBJJlHhelP+B9B0I3VALGBjoWgAW85A3Kp7ueM7q3pL3R6eVMmOsQUBxBb9zshGNvuHMsCMBZa3doUej9Irkg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:41c8:0:b0:cef:90e7:3b36 with SMTP id
 o191-20020a2541c8000000b00cef90e73b36mr10376yba.12.1690556601157; Fri, 28 Jul
 2023 08:03:21 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-1-edumazet@google.com>
Subject: [PATCH net 00/11] net: annotate data-races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series was inspired by a syzbot/KCSAN report.

This will later also permit some optimizations,
like not having to lock the socket while reading/writing
some of its fields.

Eric Dumazet (11):
  net: annotate data-races around sk->sk_reserved_mem
  net: annotate data-race around sk->sk_txrehash
  net: annotate data-races around sk->sk_max_pacing_rate
  net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
  net: annotate data-races around sk->sk_{rcv|snd}timeo
  net: add missing READ_ONCE(sk->sk_sndbuf) annotation
  net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
  net: annotate data-races around sk->sk_mark
  net: add missing data-race annotations around sk->sk_peek_off
  net: add missing data-race annotation for sk_ll_usec
  net: annotate data-races around sk->sk_priority

 include/net/inet_sock.h    |  7 ++--
 include/net/ip.h           |  2 +-
 include/net/route.h        |  4 +--
 net/can/raw.c              |  2 +-
 net/core/sock.c            | 69 ++++++++++++++++++++++----------------
 net/dccp/ipv6.c            |  4 +--
 net/ipv4/inet_diag.c       |  4 +--
 net/ipv4/ip_output.c       |  8 ++---
 net/ipv4/ip_sockglue.c     |  2 +-
 net/ipv4/raw.c             |  2 +-
 net/ipv4/route.c           |  4 +--
 net/ipv4/tcp_ipv4.c        |  4 +--
 net/ipv6/ping.c            |  2 +-
 net/ipv6/raw.c             |  6 ++--
 net/ipv6/route.c           |  7 ++--
 net/ipv6/tcp_ipv6.c        |  9 ++---
 net/ipv6/udp.c             |  4 +--
 net/l2tp/l2tp_ip6.c        |  2 +-
 net/mptcp/sockopt.c        |  2 +-
 net/netfilter/nft_socket.c |  2 +-
 net/netfilter/xt_socket.c  |  4 +--
 net/packet/af_packet.c     | 12 +++----
 net/sched/em_meta.c        |  4 +--
 net/smc/af_smc.c           |  2 +-
 net/unix/af_unix.c         |  2 +-
 net/xdp/xsk.c              |  2 +-
 net/xfrm/xfrm_policy.c     |  2 +-
 27 files changed, 94 insertions(+), 80 deletions(-)

-- 
2.41.0.585.gd2178a4bd4-goog



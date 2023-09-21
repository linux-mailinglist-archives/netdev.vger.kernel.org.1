Return-Path: <netdev+bounces-35481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE4E7A9AB1
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8762822BF
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8CB18048;
	Thu, 21 Sep 2023 17:49:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A918B01
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:49:17 +0000 (UTC)
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C328D225
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:43:11 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id ca18e2360f4ac-797f764a6faso81896439f.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695318191; x=1695922991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pzl6G1Eyv/Q2LUGxc5AwBBdY5Bj1hB+8H+ASF74zNG8=;
        b=bYFQysRVnSZAx4o3DptGEMckxQy5iU3cw3mgZ+EdyOrvbvz5t9B/edPIjNxrJhmpWw
         n8axsWrkNm7w+1pHBQECu/7YCgg2rsUz6+ic+kG24ksx1hcWDFKLp+FwGtz0IVp+N1Xx
         yue0iy90DxWyt3l253RH8BJgHrFqQeIoI8JugPp0JbtWg4NqncS0pKiwTaawVwkw1NGh
         rkzLNYFr+wmM80w8caSCUKtos+PG9Ocqiark5vjzlBEp/v/iOJm7hQHUSsff/rWkmkws
         zByU0T6OLzEnBtVWPVzGEtMQwBreHM/7IdrmYkfrEpQJhAPRR9Bq6AVJCpRYmHiF7bzB
         994g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318191; x=1695922991;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pzl6G1Eyv/Q2LUGxc5AwBBdY5Bj1hB+8H+ASF74zNG8=;
        b=HccetdHpJqkZOLV8dZrt62/7wbKOhQOHgR9iW6J2wW4p2+R9WCn/23ZgY8iiowoS2N
         5Q+55SPi0RGt3CJhPPxVxu2W4s1+BJFedQsl9K7uShU7XlmZrJCSRxJ+7rlmCZ/ryz/1
         3kmj36qYip+Mh8sf0nw16jNXayzS2R/up2y47L7u4jLj3ooWgvdSZpIuVZyoZ1CcKVZ0
         IFO5eveUaG76Dx0x9/Naj/2i0Z2dU6x1BCx+l5g+R5nUSCQ37Mz/86xej0/SqZ/VhrrF
         1lmyCgxFSb2NnNoQMMvUeqRHGyxRCoEec8ueoSxscVXT46qHfRItLxfagQOMSTgvhQq9
         yPew==
X-Gm-Message-State: AOJu0YxDUUYnU4hOQZqS+ZOcx7mxDLoJ/gMU2TZdvxCqzixLHHa2dWFX
	I3f83DWH29cI+VJza/zNxKiKKl1JHPu+hg==
X-Google-Smtp-Source: AGHT+IFPW6EnCS5+xCgiVQnmTRAgML3UQWJk+NxZuWM0+kComdmNISsfHGZR5RLzC/GyYtCIRVLul4xbVzaJUg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:258d:0:b0:d81:5c03:df95 with SMTP id
 l135-20020a25258d000000b00d815c03df95mr70830ybl.12.1695303025363; Thu, 21 Sep
 2023 06:30:25 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:30:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921133021.1995349-1-edumazet@google.com>
Subject: [PATCH net-next 0/8] inet: more data-race fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series fixes some existing data-races on inet fields:

inet->mc_ttl, inet->pmtudisc, inet->tos, inet->uc_index,
inet->mc_index and inet->mc_addr.

While fixing them, we convert eight socket options
to lockless implementation.

Eric Dumazet (8):
  inet: implement lockless IP_MULTICAST_TTL
  inet: implement lockless IP_MTU_DISCOVER
  inet: implement lockless IP_TOS
  inet: lockless getsockopt(IP_OPTIONS)
  inet: lockless getsockopt(IP_MTU)
  inet: implement lockless getsockopt(IP_UNICAST_IF)
  inet: lockless IP_PKTOPTIONS implementation
  inet: implement lockless getsockopt(IP_MULTICAST_IF)

 include/net/ip.h                              |  14 +-
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
 14 files changed, 147 insertions(+), 154 deletions(-)

-- 
2.42.0.459.ge4e396fd5e-goog



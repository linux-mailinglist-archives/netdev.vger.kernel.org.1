Return-Path: <netdev+bounces-33303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D3C79D5B3
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC50281E92
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12219BBE;
	Tue, 12 Sep 2023 16:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8118C19
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:29 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E0310F2
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d9e327d3aso63261957b3.3
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534542; x=1695139342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDes+Bk4LKjEHHjysfWgEC+LX8CP4xuvdivMCxFNOIg=;
        b=fk9KYEhbY1GD99jIcIddPG0oneP4c+ycGiuHuh7OhW1n+15iK/ySzcqS3cAe3A4IN4
         K5cPTXdUbOCpbZk9aSzXW+fshH2kkZB+m/GAFnHADK8gAGt5rnyJPsLJ2EY7mZvWb+AP
         tOFejmnGBDdyDHnqA22VaOU1WaHLU+w6HVpbDdauNoaXuwmKJzlOVgao/tTVp8DOoViV
         ehOq21C5zKQmXvSI8AzAfXThHpr2lrPm/rRLam9MQEbDP96taX0unwSXlVdPzfg0LMWL
         tjbkiSSB8aBlRXBt6g8YvQEBpNApcD+OkibpiSF0DEDr84bpCEjYk2zM0SleY+OMXmb1
         ePpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534542; x=1695139342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDes+Bk4LKjEHHjysfWgEC+LX8CP4xuvdivMCxFNOIg=;
        b=XEupDWDm4edhQsN316dJ9Q3YSaLgAPXLqED9HqG4Ux6jpFZdjokvs44Nxvqu/NAy+2
         ZOtODQMNryAtf2Fg9vY/wBOMdiD5n5qI23nL6+o7nO8SRofNnm2QgytiOKg23M5JvZVX
         jrH8FJnN8ghp3xljvW/5znA43KJQaamwSaHN4osNG5/OhiCbM1A5vo3VzciNJ0oefWwr
         xV/L7T5C0peDtNWLEuxxjIruvxe0b+J3fKfinGO4x+X53Pj9YJprpEjzdbPRXhj82zeQ
         Lz1V8nVuQZ/nEwGRGNjM5FavStbzXXrMokkPpU8i+pIREdSUt4PqwtA+/DW4HHuKRi3l
         ZXzw==
X-Gm-Message-State: AOJu0Yza8x6nxk3hgDIG/ozzpbIV8Nvkf5VG2KNAMfZrxHzJuyWsPRMC
	T1kYIQ2LiCDzOxPSzEOXu8I6qUqPR+RiJA==
X-Google-Smtp-Source: AGHT+IEIj5Mu2noySVjMZAZz3zZmhzym9eBcMWP9afdmLnduAWWHus2Hr70dq2VlnN1GYojUmywxlfpnIH2tYQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:e447:0:b0:565:9e73:f937 with SMTP id
 t7-20020a81e447000000b005659e73f937mr294055ywl.4.1694534542422; Tue, 12 Sep
 2023 09:02:22 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:03 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-6-edumazet@google.com>
Subject: [PATCH net-next 05/14] ipv6: lockless IPV6_MINHOPCOUNT implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add one missing READ_ONCE() annotation in do_ipv6_getsockopt()
and make IPV6_MINHOPCOUNT setsockopt() lockless.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ipv6_sockglue.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 3b2a34828daab5c666d7b429afa961279739c70b..bbc8a009e05d3de49868e1ccf469a12bc31b8e22 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -448,6 +448,20 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		WRITE_ONCE(np->frag_size, val);
 		return 0;
+	case IPV6_MINHOPCOUNT:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (val < 0 || val > 255)
+			return -EINVAL;
+
+		if (val)
+			static_branch_enable(&ip6_min_hopcount);
+
+		/* tcp_v6_err() and tcp_v6_rcv() might read min_hopcount
+		 * while we are changing it.
+		 */
+		WRITE_ONCE(np->min_hopcount, val);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -947,21 +961,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		retv = __ip6_sock_set_addr_preferences(sk, val);
 		break;
-	case IPV6_MINHOPCOUNT:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		if (val < 0 || val > 255)
-			goto e_inval;
-
-		if (val)
-			static_branch_enable(&ip6_min_hopcount);
-
-		/* tcp_v6_err() and tcp_v6_rcv() might read min_hopcount
-		 * while we are changing it.
-		 */
-		WRITE_ONCE(np->min_hopcount, val);
-		retv = 0;
-		break;
 	case IPV6_DONTFRAG:
 		np->dontfrag = valbool;
 		retv = 0;
@@ -1443,7 +1442,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_MINHOPCOUNT:
-		val = np->min_hopcount;
+		val = READ_ONCE(np->min_hopcount);
 		break;
 
 	case IPV6_DONTFRAG:
-- 
2.42.0.283.g2d96d420d3-goog



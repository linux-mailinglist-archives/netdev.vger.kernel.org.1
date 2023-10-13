Return-Path: <netdev+bounces-40684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2C77C8564
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3670EB20AD2
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF8A14A81;
	Fri, 13 Oct 2023 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZOb4ytdo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4114005
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:10:37 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A27BBF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1732918f8f.0
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697199033; x=1697803833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3LNEM/3RYbYoGteRoHDoFeUwZb7H2Soc5dB4GPyq1k=;
        b=ZOb4ytdowAuTJzhuqjFMKmiaPTCLOSb4VhR3PSJd8DDuuUxxf0PosiUcfO1xjfzFID
         ++qjhwVTiCgecvLEhOcaMlMkUbmPaAVFZbjX4X6C57scf/6qgPsSGH6J6jfeKRGEsz9R
         ctnyzopI5EByS8d1O1r6B8zSuTycMox/scZAqviIyo9puSBwN4d817JUXUO1DazoJHWd
         nneSRYxuydOEkDk2nlysRFfY5HoSq4ZwcrAAjgaU2IcxkzQGP2Q0m46UfOXuYUlTgykP
         BRqSaAp19nA7INkVxJ1JCLoXPGAXXRd/2G3Mo4IgQKBxMlfH8P/EXX282rxCuBrFP7W3
         Skew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199033; x=1697803833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3LNEM/3RYbYoGteRoHDoFeUwZb7H2Soc5dB4GPyq1k=;
        b=A0Lfrnw+7Mu8fuVVMgjETURX/0Yczm0J3slITxfcT6hYyID2njcnaOJAdULgb3Hke6
         K5+ZRjI1CSRmiE0I/kWdgOs+a5Gm+8qoZchfmqDm+qDpU7uZK8unz2XbIY9Mw0islgO2
         7i1tmsRxxAF4ZkhAgpdxqNWMRzRxA+HccfZRppLGV2j1aWqVSRQWUZPkvJwKiKX/PcvX
         IQHQx7wt39NA7+YGnnz1K6y7VjxuVtE+n4s+9DKkTtXV1HCvXSvjxgDjNKmG0DQS/P5p
         S84SL4rroSctM3yeAJcLy21+O9muo3CKlrdGsy0el82tU0RAL3q4KdPxjnZtHGFnqlxw
         3uaw==
X-Gm-Message-State: AOJu0Yy0nerQv8JsPNTxST8tHCsVntGScQB2/xrevWKQm4TaxvXHZZKf
	hsPkywqzj7yYCzw5pAo4GKAWgg24YBD9ReIKTIo=
X-Google-Smtp-Source: AGHT+IGPX5UJmeqqviS9XPXOsJbLD+qhdF6XyoPay2/k5S6dy7WBXopwrdo9ksAMqTJjmSfJdb47Rw==
X-Received: by 2002:adf:e383:0:b0:323:39d2:5803 with SMTP id e3-20020adfe383000000b0032339d25803mr23050167wrm.3.1697199033450;
        Fri, 13 Oct 2023 05:10:33 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k7-20020adfb347000000b0032d8913f3dasm6502286wrd.97.2023.10.13.05.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:10:32 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v3 1/7] net: treat possible_net_t net pointer as an RCU one and add read_pnet_rcu()
Date: Fri, 13 Oct 2023 14:10:23 +0200
Message-ID: <20231013121029.353351-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013121029.353351-1-jiri@resnulli.us>
References: <20231013121029.353351-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Make the net pointer stored in possible_net_t structure annotated as
an RCU pointer. Change the access helpers to treat it as such.
Introduce read_pnet_rcu() helper to allow caller to dereference
the net pointer under RCU read lock.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 include/net/net_namespace.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index eb6cd43b1746..13b3a4e29fdb 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -368,21 +368,30 @@ static inline void put_net_track(struct net *net, netns_tracker *tracker)
 
 typedef struct {
 #ifdef CONFIG_NET_NS
-	struct net *net;
+	struct net __rcu *net;
 #endif
 } possible_net_t;
 
 static inline void write_pnet(possible_net_t *pnet, struct net *net)
 {
 #ifdef CONFIG_NET_NS
-	pnet->net = net;
+	rcu_assign_pointer(pnet->net, net);
 #endif
 }
 
 static inline struct net *read_pnet(const possible_net_t *pnet)
 {
 #ifdef CONFIG_NET_NS
-	return pnet->net;
+	return rcu_dereference_protected(pnet->net, true);
+#else
+	return &init_net;
+#endif
+}
+
+static inline struct net *read_pnet_rcu(possible_net_t *pnet)
+{
+#ifdef CONFIG_NET_NS
+	return rcu_dereference(pnet->net);
 #else
 	return &init_net;
 #endif
-- 
2.41.0



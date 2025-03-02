Return-Path: <netdev+bounces-170977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9648AA4AE87
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 01:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4103B3CC7
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 00:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE5C13B;
	Sun,  2 Mar 2025 00:09:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCA2AD5A
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874151; cv=none; b=NSVyRbmfcxHOLvnPDEWu8QwYlk4iZog+/H4EB/iT7NENi6r8GQoRQmPYCrBt/N5JZZ4VXxq3uG9B8epWdGDAwF9eAxtusCgWlPvH5vQo1Uir7JqyKWYTsoNVnHqZA8zLBvytQU1+Xvi6M1ZYxiLcru0s8GGyKen1z130GPcEUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874151; c=relaxed/simple;
	bh=WrpxMD1Hv+NXnyJ2A4ddZOCyZlloIDFofE8/mxwDtMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2h9jkG0xj8uF1J4N9ZAb2raF861V13MWvx8vrqnPUSyZBuj/cImFqCJJ68amGx/ej3LJcTTfpY/rnIdr2NT22ESLiAsXddyUEbhvqnbztXDwkSiQH5+UzZLNKMlelw91L7rZxDByFOA+LtUYSSr7yP2k1UVUia9HfFiN1iwZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2feae68f835so4399711a91.2
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 16:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740874148; x=1741478948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wJ0D1i+xy+sRR6WBKybKVoamN6RSIynZoNB/dIGbVs=;
        b=JMibPgyKWU1nm8GSqotMAHXU0FSJqyWUEf9vxhLW4P1OiA0sepJe7CDqaPLo6CYx4/
         mZkKG7QXklzXdF4nwSqSWWU/b/HUx60KHGsPymx8StF2seFEmWzrbpsUWlMUqQmBU62S
         4NYMPBrTv8C1loytFr3YIEFxCb5ZnyRVSEhPy2Mp/E3PO1PozTYNEnwWGG7KffmT4oiN
         IK/zN4gBIiLEQDSSlfoIxVdXXMeFkku5Jsqnf394hhsjtDxAqI+iOqN9bp9+RqTZxcMl
         AfoKdVYWppObkAiZA8ZoUUpnBP07sDYjUl/+9rqOSRAoeEAPOkhIOS2jDGA86pmCnFvg
         Ql5g==
X-Gm-Message-State: AOJu0YxZtyjs0hZLZ+1LGYKTTxmjws9qXO0EoJP9jESofzDU1SLu2E9H
	YnTmjTvqV2HO3pzUZZXe/JEf4HQ8CwqONW7UgvxQSJFxysrmmSgYXLi/
X-Gm-Gg: ASbGncuZo7w5iGbKghzQzygbcqI4zymKRxT7oUC+bu+bzKL9clRKsepFg8J4QqXSSEf
	kAbd+NLmiB/djqA/DL56gUE2XbVXTNoIuaPbABaKH8aIXLmfnD6cQPT4kY3NmDjinL7mhts2sMk
	S5+izIw5+03+a69xej3A3RWYriTp7JNkfpHeFXVjX+jraWjCyFW+KMjYcniQde7Gv6Zejbc/iv9
	ZNAtTXrG9+VVhnE3myNu2pQbXu9KyEAFu5CI8DYWtXvCm8prhCOP8A0vHUzkSJ19aRNi8x4quda
	oBhIb5p48rTeTfd35K4IXV00723ysMqrT1khSO1Dk+sr
X-Google-Smtp-Source: AGHT+IGsZKbQ/8I7aShdb9tTqNgWvrrm97RnsNB+63SdPDOyiEs65SreLCDZVjN/hUJBQjN1keXuJw==
X-Received: by 2002:a17:90b:52cc:b0:2fe:861b:1ae3 with SMTP id 98e67ed59e1d1-2febab40385mr13778948a91.8.1740874148485;
        Sat, 01 Mar 2025 16:09:08 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe8284f076sm8235211a91.42.2025.03.01.16.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 16:09:07 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 04/14] net: hold netdev instance lock during qdisc ndo_setup_tc
Date: Sat,  1 Mar 2025 16:08:51 -0800
Message-ID: <20250302000901.2729164-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302000901.2729164-1-sdf@fomichev.me>
References: <20250302000901.2729164-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qdisc operations that can lead to ndo_setup_tc might need
to have an instance lock. Add netdev_lock_ops/netdev_unlock_ops
invocations for all psched_rtnl_msg_handlers operations.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/sched/sch_api.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e0be3af4daa9..78c03da7007c 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1279,9 +1279,11 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 			 * We replay the request because the device may
 			 * go away in the mean time.
 			 */
+			netdev_unlock_ops(dev);
 			rtnl_unlock();
 			request_module(NET_SCH_ALIAS_PREFIX "%s", name);
 			rtnl_lock();
+			netdev_lock_ops(dev);
 			ops = qdisc_lookup_ops(kind);
 			if (ops != NULL) {
 				/* We will try again qdisc_lookup_ops,
@@ -1591,7 +1593,11 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	if (!dev)
 		return -ENODEV;
 
-	return __tc_get_qdisc(skb, n, extack, dev, tca, tcm);
+	netdev_lock_ops(dev);
+	err = __tc_get_qdisc(skb, n, extack, dev, tca, tcm);
+	netdev_unlock_ops(dev);
+
+	return err;
 }
 
 static bool req_create_or_replace(struct nlmsghdr *n)
@@ -1827,7 +1833,9 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		return -ENODEV;
 
 	replay = false;
+	netdev_lock_ops(dev);
 	err = __tc_modify_qdisc(skb, n, extack, dev, tca, tcm, &replay);
+	netdev_unlock_ops(dev);
 	if (replay)
 		goto replay;
 
@@ -1918,17 +1926,23 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 			s_q_idx = 0;
 		q_idx = 0;
 
+		netdev_lock_ops(dev);
 		if (tc_dump_qdisc_root(rtnl_dereference(dev->qdisc),
 				       skb, cb, &q_idx, s_q_idx,
-				       true, tca[TCA_DUMP_INVISIBLE]) < 0)
+				       true, tca[TCA_DUMP_INVISIBLE]) < 0) {
+			netdev_unlock_ops(dev);
 			goto done;
+		}
 
 		dev_queue = dev_ingress_queue(dev);
 		if (dev_queue &&
 		    tc_dump_qdisc_root(rtnl_dereference(dev_queue->qdisc_sleeping),
 				       skb, cb, &q_idx, s_q_idx, false,
-				       tca[TCA_DUMP_INVISIBLE]) < 0)
+				       tca[TCA_DUMP_INVISIBLE]) < 0) {
+			netdev_unlock_ops(dev);
 			goto done;
+		}
+		netdev_unlock_ops(dev);
 
 cont:
 		idx++;
@@ -2307,7 +2321,11 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 	if (!dev)
 		return -ENODEV;
 
-	return __tc_ctl_tclass(skb, n, extack, dev, tca, tcm);
+	netdev_lock_ops(dev);
+	err = __tc_ctl_tclass(skb, n, extack, dev, tca, tcm);
+	netdev_unlock_ops(dev);
+
+	return err;
 }
 
 struct qdisc_dump_args {
@@ -2425,7 +2443,9 @@ static int tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!dev)
 		return 0;
 
+	netdev_lock_ops(dev);
 	err = __tc_dump_tclass(skb, cb, tcm, dev);
+	netdev_unlock_ops(dev);
 
 	dev_put(dev);
 
-- 
2.48.1



Return-Path: <netdev+bounces-112116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110AB9351DB
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 20:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9922280DF2
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09507145B2D;
	Thu, 18 Jul 2024 18:43:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E9145B24;
	Thu, 18 Jul 2024 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721328216; cv=none; b=Po8bJ6KLAMit5f1cX5XAaytfujWp0RjRT2no0B4ztBMjr1VEmMbfbrxS7ozHBU6GKk2OwzwrMVWVnZ2N8Bl1QD+J9VJL7mRwODOzPmcheGOr2Rfa25+EbVN6zXbFuDCQpbVscyoCdV76ht9JTl7PF7+SBVK5SkICIVa6gi2Y0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721328216; c=relaxed/simple;
	bh=SFUdWWInwtuiBpj1g9M+LnbLUdUW5EYRgDvbx6lA7pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRIbpZWxOCGLt2Wh3oFec4PQGOdceFpg7qcGsDh8SFCsDXoFe91V3Z1tAaHbDFQpFmwlI8PmA1fIq7RUGjMDAgkOi6410iV8rZRe/NQVH1k8E5JhAv1tRWNjMScUgN23BH2ftFCBB1noj6V/LuSw23gWX0kVQZW63EnXwV0hA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ed741fe46so1042643e87.0;
        Thu, 18 Jul 2024 11:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721328209; x=1721933009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XeMe11OUYPV7XqgVENrFs5LHpWOFIgoau8MLc6vOHU=;
        b=ZEaDaP873iI83fu2EiKITBRUEsCm6FU1PQtDSPrBdxWEwrvEnniI1y2LW+cOYr7eJL
         6VicnSriMW3yYAYAY/OjuqFvsN790DMuEULYL46xmw/WAqRL9xBJqGgv7a+VEku7hLR4
         GEnNgeFBhExpnX99Ayo8sLvAuH0z5VO+SEV3aIcAYex1F54snt9Biq77dDLEJKaLuo0J
         FnjtCeHjddZAC1bG6+j3SL3WKORGVEX7+V/S3BQlnYMqjqVKuJ0+5j1LoDJnq7WM/p2/
         c19WbWJ/GXKVjfwV7F2x9aN4FD+08WsK8YwgkkdZOymORds+F55eCT/TS+2na8ELEQxb
         ofpg==
X-Forwarded-Encrypted: i=1; AJvYcCVDm9BYZBSH9z+7oAKH+JV1rfHfF8olhMbHIlCmusoHC5JlRLwbmq91md4DgsrV9x4EOLtjhRfsnsi0v2UJNttjseE5hALT2nYphXb0RoC2Z+i/qdaKt0ggar6v4BZbHEqqPu5q
X-Gm-Message-State: AOJu0YxYeMzwtCP1pV84QA6yxmo+LeiaRIXaF4zAAYTWsHMta5VPSQPB
	eiImIy7OzECJvX+3eaZmOMaHojwJCI1GJC4mPAzW4PjUDC5/qwSj
X-Google-Smtp-Source: AGHT+IEECp55Densx2ZVEqhSwgt/Yl9a60qu1BgwaRkG5ATPZKQ4kpwCgXfcLjtO1kjzGjas+ozq1w==
X-Received: by 2002:a05:6512:3d27:b0:52d:b150:b9b3 with SMTP id 2adb3069b0e04-52ee53dbcf3mr4550621e87.32.1721328208976;
        Thu, 18 Jul 2024 11:43:28 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc800f5asm599003666b.178.2024.07.18.11.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 11:43:28 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	davej@codemonkey.org.uk
Subject: [RFC PATCH 2/2] netconsole: Defer netpoll cleanup to avoid lock release during list traversal
Date: Thu, 18 Jul 2024 11:43:06 -0700
Message-ID: <20240718184311.3950526-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718184311.3950526-1-leitao@debian.org>
References: <20240718184311.3950526-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current issue:
- The `target_list_lock` spinlock is held while iterating over
  target_list() entries.
- Mid-loop, the lock is released to call __netpoll_cleanup(), then
  reacquired.
- This practice compromises the protection provided by
  `target_list_lock`.

Reason for current design:
1. __netpoll_cleanup() may sleep, incompatible with holding a spinlock.
2. target_list_lock must be a spinlock because write_msg() cannot sleep.
   (See commit b5427c27173e ("[NET] netconsole: Support multiple logging targets"))

Defer the cleanup of the netpoll structure to outside the
target_list_lock() protected area. Create another list
(target_cleanup_list) to hold the entries that need to be cleaned up,
and clean them using a mutex (target_cleanup_list_lock).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 77 +++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9c09293b5258..0515fee5a2d1 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -37,6 +37,7 @@
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
 #include <linux/utsname.h>
+#include <linux/rtnetlink.h>
 
 MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
@@ -72,9 +73,16 @@ __setup("netconsole=", option_setup);
 
 /* Linked list of all configured targets */
 static LIST_HEAD(target_list);
+/* target_cleanup_list is used to track targets that need to be cleaned outside
+ * of target_list_lock. It should be cleaned in the same function it is
+ * populated.
+ */
+static LIST_HEAD(target_cleanup_list);
 
 /* This needs to be a spinlock because write_msg() cannot sleep */
 static DEFINE_SPINLOCK(target_list_lock);
+/* This needs to be a mutex because netpoll_cleanup might sleep */
+static DEFINE_MUTEX(target_cleanup_list_lock);
 
 /*
  * Console driver for extended netconsoles.  Registered on the first use to
@@ -323,6 +331,39 @@ static ssize_t remote_mac_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%pM\n", to_target(item)->np.remote_mac);
 }
 
+/* Clean up every target in the cleanup_list and move the clean targets back to the
+ * main target_list.
+ */
+static void netconsole_process_cleanups_core(void)
+{
+	struct netconsole_target *nt, *tmp;
+	unsigned long flags;
+
+	/* The cleanup needs RTNL locked */
+	ASSERT_RTNL();
+
+	mutex_lock(&target_cleanup_list_lock);
+	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list) {
+		/* all entries in the cleanup_list needs to be disabled */
+		WARN_ON_ONCE(nt->enabled);
+		do_netpoll_cleanup(&nt->np);
+		/* moved the cleaned target to target_list. Need to hold both locks */
+		spin_lock_irqsave(&target_list_lock, flags);
+		list_move(&nt->list, &target_list);
+		spin_unlock_irqrestore(&target_list_lock, flags);
+	}
+	WARN_ON_ONCE(!list_empty(&target_cleanup_list));
+	mutex_unlock(&target_cleanup_list_lock);
+}
+
+/* Do the list cleanup with the rtnl lock hold */
+static void netconsole_process_cleanups(void)
+{
+	rtnl_lock();
+	netconsole_process_cleanups_core();
+	rtnl_unlock();
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -376,12 +417,20 @@ static ssize_t enabled_store(struct config_item *item,
 		 * otherwise we might end up in write_msg() with
 		 * nt->np.dev == NULL and nt->enabled == true
 		 */
+		mutex_lock(&target_cleanup_list_lock);
 		spin_lock_irqsave(&target_list_lock, flags);
 		nt->enabled = false;
+		/* Remove the target from the list, while holding
+		 * target_list_lock
+		 */
+		list_move(&nt->list, &target_cleanup_list);
 		spin_unlock_irqrestore(&target_list_lock, flags);
-		netpoll_cleanup(&nt->np);
+		mutex_unlock(&target_cleanup_list_lock);
 	}
 
+	/* Deferred cleanup */
+	netconsole_process_cleanups();
+
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return strnlen(buf, count);
 out_unlock:
@@ -950,7 +999,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				   unsigned long event, void *ptr)
 {
 	unsigned long flags;
-	struct netconsole_target *nt;
+	struct netconsole_target *nt, *tmp;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	bool stopped = false;
 
@@ -958,9 +1007,9 @@ static int netconsole_netdev_event(struct notifier_block *this,
 	      event == NETDEV_RELEASE || event == NETDEV_JOIN))
 		goto done;
 
+	mutex_lock(&target_cleanup_list_lock);
 	spin_lock_irqsave(&target_list_lock, flags);
-restart:
-	list_for_each_entry(nt, &target_list, list) {
+	list_for_each_entry_safe(nt, tmp, &target_list, list) {
 		netconsole_target_get(nt);
 		if (nt->np.dev == dev) {
 			switch (event) {
@@ -970,25 +1019,16 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
 			case NETDEV_UNREGISTER:
-				/* rtnl_lock already held
-				 * we might sleep in __netpoll_cleanup()
-				 */
 				nt->enabled = false;
-				spin_unlock_irqrestore(&target_list_lock, flags);
-
-				__netpoll_cleanup(&nt->np);
-
-				spin_lock_irqsave(&target_list_lock, flags);
-				netdev_put(nt->np.dev, &nt->np.dev_tracker);
-				nt->np.dev = NULL;
+				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
-				netconsole_target_put(nt);
-				goto restart;
 			}
 		}
 		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
+	mutex_unlock(&target_cleanup_list_lock);
+
 	if (stopped) {
 		const char *msg = "had an event";
 
@@ -1007,6 +1047,11 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			dev->name, msg);
 	}
 
+	/* Process target_cleanup_list entries. By the end, target_cleanup_list
+	 * should be empty
+	 */
+	netconsole_process_cleanups_core();
+
 done:
 	return NOTIFY_DONE;
 }
-- 
2.43.0



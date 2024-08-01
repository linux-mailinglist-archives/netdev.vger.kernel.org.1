Return-Path: <netdev+bounces-115069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21A945053
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48950B228CD
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552391B4C2B;
	Thu,  1 Aug 2024 16:14:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D51BA89F;
	Thu,  1 Aug 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528851; cv=none; b=ELcA2ifPWUhpY27B5SlrhHnnXshVzEgfcjQ0+5kD69vDdUQnkPgZVMcTgiyB5AoQScnsisb0NMNr78SP6m1ZY0dJhKlMJlgeK6ktbA/l+wcs319n/XyImUlMR5xngvJs9jlXhonsOwe6z8uoWhNfoJRTr0xxHMB9OFNlQPDnBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528851; c=relaxed/simple;
	bh=7e3efhcv9TBwyQynz9QMmq8QAaAjHIGnXvuyE+brDnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TM1xgYNCX5H8FT5wgzxzXKOPLWe1EEcFuvc/occaeFAPya/QwGn+uSaMKfURwm8Ml8fjNXMkbX4RxmMvC825aorkgjEK3aBo05neKLpy+8xI32jKATmDZHquGm1EdYqiU8AdnHN8tDlnrc0Bsz5BiKGo6io21LwN6Bm7TYKdP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so3807186a12.1;
        Thu, 01 Aug 2024 09:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528844; x=1723133644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fwJ9sjtEm+K2Uygni9ol7IUWm5RqiSMgqK4WJO8Gac=;
        b=UuwDzSxR9llqTx84X9BGJ70J0PlC3geXJC3gM452fWtxJcmQF/J3YKi3MoCMAuoCYh
         y2IKrZPeTylxteZKFAWetRKXvX3FYzgJSOjtkYhnZjjVlLuROqLW1wAZAu3HEfChIc8Y
         DYcLEgam0eOJrMpy5M63LTnA4yu7nVwdu3c0R+XNwt5FKleADNZ1Hm6/kcjda/6tDM01
         i4C6ziOw/FIrA3FtgKqsXaGBYbz/t4KVESfOQ+6VLvvmKwQCBQpA/fEJWVHhQ3+8sRez
         +uxt4snid+qFJs4n9iV4n/+bJW1Y91PAKi+pMs1kHC3GV+L+psCMErJWy3w4TD32sbKB
         xuFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNTp+m0+anPCHzkjVAJ1HTkHF2z+ct5SqZmfXRbdseY42no11jLTL0Omo7osISYy6HKPfWvfhASzBTH78uATD5qZTtApLq8liu/dq8lDEgQZf0AL4s7RPkhWWh1QE64r/UfV35
X-Gm-Message-State: AOJu0YyDs3SpkEfKwzhBD0mjW+bSLqNKFQvrQvuu0O6AAjirJZdxgxnR
	SXlMqC6Jl31sCCLOkoJe7PJLLphnNm2cJOpPJ601euU8HsQ8DF0A
X-Google-Smtp-Source: AGHT+IF7er/XmpWbI0le/WS2rWWF6sCS6psERpQnYNgAPU5ZQUrM+3Dj4MSYUnTmN6FyQp5+PkeJ4A==
X-Received: by 2002:a05:6402:1a42:b0:5a1:5c0c:cbd6 with SMTP id 4fb4d7f45d1cf-5b80acb9ba2mr479182a12.8.1722528843964;
        Thu, 01 Aug 2024 09:14:03 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590d81sm10482172a12.23.2024.08.01.09.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:14:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thevlad@fb.com,
	thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	davej@codemonkey.org.uk
Subject: [PATCH net-next 6/6] net: netconsole: Defer netpoll cleanup to avoid lock release during list traversal
Date: Thu,  1 Aug 2024 09:12:03 -0700
Message-ID: <20240801161213.2707132-7-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801161213.2707132-1-leitao@debian.org>
References: <20240801161213.2707132-1-leitao@debian.org>
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
   (See commit b5427c27173e ("[NET] netconsole: Support multiple logging
    targets"))

Defer the cleanup of the netpoll structure to outside the
target_list_lock() protected area. Create another list
(target_cleanup_list) to hold the entries that need to be cleaned up,
and clean them using a mutex (target_cleanup_list_lock).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 83 ++++++++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index eb9799edb95b..dd984ee4a564 100644
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
@@ -210,6 +218,46 @@ static struct netconsole_target *alloc_and_init(void)
 	return nt;
 }
 
+/* Clean up every target in the cleanup_list and move the clean targets back to
+ * the main target_list.
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
+		/* moved the cleaned target to target_list. Need to hold both
+		 * locks
+		 */
+		spin_lock_irqsave(&target_list_lock, flags);
+		list_move(&nt->list, &target_list);
+		spin_unlock_irqrestore(&target_list_lock, flags);
+	}
+	WARN_ON_ONCE(!list_empty(&target_cleanup_list));
+	mutex_unlock(&target_cleanup_list_lock);
+}
+
+/* Do the list cleanup with the rtnl lock hold.  rtnl lock is necessary because
+ * netdev might be cleaned-up by calling __netpoll_cleanup(),
+ */
+static void netconsole_process_cleanups(void)
+{
+	/* rtnl lock is called here, because it has precedence over
+	 * target_cleanup_list_lock mutex and target_cleanup_list
+	 */
+	rtnl_lock();
+	netconsole_process_cleanups_core();
+	rtnl_unlock();
+}
+
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 /*
@@ -376,13 +424,20 @@ static ssize_t enabled_store(struct config_item *item,
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
 
 	ret = strnlen(buf, count);
+	/* Deferred cleanup */
+	netconsole_process_cleanups();
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return ret;
@@ -942,7 +997,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				   unsigned long event, void *ptr)
 {
 	unsigned long flags;
-	struct netconsole_target *nt;
+	struct netconsole_target *nt, *tmp;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	bool stopped = false;
 
@@ -950,9 +1005,9 @@ static int netconsole_netdev_event(struct notifier_block *this,
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
@@ -962,25 +1017,16 @@ static int netconsole_netdev_event(struct notifier_block *this,
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
 
@@ -999,6 +1045,11 @@ static int netconsole_netdev_event(struct notifier_block *this,
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



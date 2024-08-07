Return-Path: <netdev+bounces-116383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B605894A40E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437761F2147E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9A61D3630;
	Wed,  7 Aug 2024 09:17:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5E1D278E;
	Wed,  7 Aug 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022249; cv=none; b=RKj6mYSAtJnhlGPFnNl3OEnjsvisbKa/9JTIz/KsiUgMLd2mQz5DXI5HFDfvAOffej+gmVLT+pNhkjUlcFgKeepelNtWnwm/bur257oGSIPcgRaZt0/47UXDuI6BYwCt8PdaNnZSXvNEtC/DD7Ai2xAhM2JcgSjdGWHFNTtpBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022249; c=relaxed/simple;
	bh=DjV5baq+7emiAISHcO2h0Kq+q/DrmV9u/Jbl/R+3iow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FINMRp9sflDxzEaeSvJk8+BHCoV/QuURR7dOouvArTDkEs+Pa24tZj5jw97wkO0FChXA4LLRYTes8UvLjbB+lbKCKFYSzbD/Ai9X9IbU/keav6OLwopoKGt8iZA0LsfOaHMkyrp9lvE7o8bV4hg1fRZs/KPBH3NNIJ+wlWRWqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso2159308a12.1;
        Wed, 07 Aug 2024 02:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022244; x=1723627044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Xn0gxmB3HHe9Nvo5kpK9WFXqf56bqn8ETol42PpP3k=;
        b=IzcFXJoZE9IcOscF65C5O7uFWLuspHqIDE3LU22TMSexNaUQU9sxv3Uam3sJ2YtuTK
         ZtOn7/bK1/7z7nPr1vcSewuxNKwVN32m0N/SIITtb5tyv1o2aucBNypGm4ykiUKjqnz/
         7a+BcJ0d4e66iNJdGfpEKoaPUXMFVzqDzI2/Q8dssgno6YDwbfr4JI0xGrZBlQBf1tkH
         v5PovFmRUMWh6r08w9vZi+OlgtcUyDitNIisgq6COBwRwR9oqRypzQhBj/c99eD3yEAW
         692NYfeAS6pIuP1A6vHGVkq3/oqx7eXl95rPskn3EyFdyMioM2GUO3LLM8PgRMezRm1d
         8l4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf6bMSUFmNSaJ3I9nFRGcBb3btYwCzN+r7KdZAz7I2JbdI5wsoWiEdsObixBd9c3yBULMIqYEdkuBPaAWyRMSBKC06La0DGlEopM6OQUXzdAg1D2j+8Mxo/f0nhI/0RQVxFjRd
X-Gm-Message-State: AOJu0YxpTFV322I+bBT++vhQceJy+LmardnMgzKXdGLpwQnH/u92m5JZ
	QFTNNIy9ryrbn9utnYMCt6FbRfoRYLbT25C9jXrjxpsPNR19Oj3C
X-Google-Smtp-Source: AGHT+IHzdDAFb8v0s0v7I8cBUsIbYqlqHNziXDCUKd32gALUFrd9ILKr+uu4L9hrm7Dn7LT39dOKlQ==
X-Received: by 2002:a50:8ad0:0:b0:5b9:1009:f42d with SMTP id 4fb4d7f45d1cf-5b91009f9femr9791270a12.32.1723022243846;
        Wed, 07 Aug 2024 02:17:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839b2b556sm6794533a12.25.2024.08.07.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:17:23 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/5] net: netconsole: Defer netpoll cleanup to avoid lock release during list traversal
Date: Wed,  7 Aug 2024 02:16:51 -0700
Message-ID: <20240807091657.4191542-6-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240807091657.4191542-1-leitao@debian.org>
References: <20240807091657.4191542-1-leitao@debian.org>
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
index 69eeab4a1e26..70e85b1a4ee8 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -37,6 +37,7 @@
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
 #include <linux/utsname.h>
+#include <linux/rtnetlink.h>
 
 MODULE_AUTHOR("Matt Mackall <mpm@selenic.com>");
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
2.43.5



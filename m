Return-Path: <netdev+bounces-116835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83EF94BD73
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F941C20C18
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46DB18EFE2;
	Thu,  8 Aug 2024 12:25:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB518EFD7;
	Thu,  8 Aug 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119942; cv=none; b=u0DgOUsj70J2kyHULAG8hdh88+uASmSDOBdX2cHWbY8zJrVvwxZGQHh2vZZ47uISbIoEPHoCexkKnGUiKSxXNg52qMFozykqnr5pp+QwZcyLU4MB3vjd/mu6EZC4l0wJtqpGW5Oy1cpKsrtpG1P/Sm4i0FKGmfz25mD8hkdoShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119942; c=relaxed/simple;
	bh=5TqD4p19NXHKwsgMgVySYj01lP7UhZYaAEdv8KqjG/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3pe5IG99XF0RASHzDdWvMix5FgWAvqx6fZWKiPOj+5r3tG8ck+XMYeTn5BmM5hMiuisTz0xo4y8MfFDyh+fN66x4eBS/KCFpJaozstXziNzfaYSqaQK/BW2awsB7lsbdz11N4LCufqwHO8SRb221HghZZyzaGppg5ifqSH7X+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-530e22878cfso803410e87.2;
        Thu, 08 Aug 2024 05:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119937; x=1723724737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDfb+QvqWWfg/YQQb8fsjsoxliIhml6FJcmS7F0nZsY=;
        b=JwjaudSWSmQcWv2ktKX4P49fcvaGBSkfjCas6N/RGOEbS3tm/J9btSWw2VQs6PzXty
         +pPW2vWE5aLM5rnF2t5jaLdTZT59Muw40MXPpg1eVFVDZzUC+e/0r4faxPdkTOJzZRku
         e0XFisNpoax++XyfEoJCbMs6QzbaKy/XUlUjiJjLORyl3Z8SwRaRkZlxiT7H5bN2m+sI
         qqxgW0SzIlP6p7H2M7XgkreRaNl7ydzHGUMDxKtfk4nIFRmsd9aKpoWVQ8KBVuw2BxFj
         s9z0HdzXE/mk0GRhigrvvAMGTKXsoVEkpPpp8U7glxexPAMl11IxZL5cLcl0U6tKkkD2
         YBoA==
X-Forwarded-Encrypted: i=1; AJvYcCV2nWaZ+vc+bgzoM0HLrOO94/PI4brpCQmZ5LWymvyJ1qkqwikp+ngOeGqa8QJ2ywa1DtqqFI0hI9DZD7Dpb7u2hl7Fy478BFQlYx/TnbGhCxc9LL+Pe8F/Hu/1ySxGw8aSat4i
X-Gm-Message-State: AOJu0Yz4y0jOYvbZ+ZA+5bKLTs4x2vUi9WpGD/TrnZCr9LwzdSoOkv/7
	NEubaYtMUD/q2nlLiRUbrVsLaK8JUDZ5Mr5ysylb8F/OmdSjM3DK
X-Google-Smtp-Source: AGHT+IHy8re8Bt/FC5pXPBNCLsUbzJ727eyE+CC9KA19wp3XS0Rh/A4SEdATD7QcVdAdgmDbVQhHfA==
X-Received: by 2002:a05:6512:398a:b0:52e:f2a6:8e1a with SMTP id 2adb3069b0e04-530e5843ed7mr1183042e87.29.1723119937033;
        Thu, 08 Aug 2024 05:25:37 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d3518dsm609239a12.78.2024.08.08.05.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:25:36 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/5] net: netconsole: Defer netpoll cleanup to avoid lock release during list traversal
Date: Thu,  8 Aug 2024 05:25:11 -0700
Message-ID: <20240808122518.498166-6-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808122518.498166-1-leitao@debian.org>
References: <20240808122518.498166-1-leitao@debian.org>
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
index 69eeab4a1e26..43c29b15adbf 100644
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
@@ -210,6 +218,33 @@ static struct netconsole_target *alloc_and_init(void)
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
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 /*
@@ -246,6 +281,19 @@ static struct netconsole_target *to_target(struct config_item *item)
 			    struct netconsole_target, group);
 }
 
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
 /* Get rid of possible trailing newline, returning the new length */
 static void trim_newline(char *s, size_t maxlen)
 {
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



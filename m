Return-Path: <netdev+bounces-274727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDGzOT/0zmmzsAYAu9opvQ
	(envelope-from <netdev+bounces-274727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:57:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CF838EEA8
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA00303F07B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C863D647B;
	Thu,  2 Apr 2026 22:55:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC233D5256
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170544; cv=none; b=epZbTwBmU0Deicl7Ie0+o8fFxYaXptdLbPs+X0qQCHCsCq+GFF2jQg2eUSDnX8+UaLzuf9ec6DoYPX8caoktEtvAWx2qhy0qBzlSlEI/1nUk8dQmxt1IOvzvdEsZvQWre0/RSozZ0BS8/WAfjhFyhrLh5y1Qq2GNNiwWjvRGx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170544; c=relaxed/simple;
	bh=jY3xDzVrZrx2EK7o9Ml//mUNS/FtB1OhaPgZp2/HgSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCHxJ9MznLiVPHw0Muqf5xXQApI5Werc2mZnZlbGZYK6E98iT3hle6PifoDyhKJ/mUHWKcXykzGPCimONbtO4+HWVeZ+mC400HY8yY87EZ4iTE9EEZlRyX94Xm2HA7lBsVzMqrO3s5SQzVZMfH+igzzHfigterlqWsd3YJ/XTX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-127380532eeso4038205c88.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170541; x=1775775341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lMAu2VpkB3gbduVj7tSlQBEQEVilJAiAM4PAqqC9Vl0=;
        b=aeSMDITPmEbGVmcKgd2GYmUCqQt94Q60qsFQ25oiOPz8+QmHACQ8iJ/ioONKcAXBt/
         OAhl7g/ikIbHhhF6aoVxp4IBrytXMVqcP8FMx9hm39ymP2B34dh3G6xN1+VJ248xqZQt
         cJFqsHGl9XbJm8n5n71UjdzfO4oMaeFg9V+7fxfYXBvAOF486I0fsqWsl4JN3MDsFmeg
         jf4yY9ayWn9fo17jBStGSKWgQ7HjxBG3qJqD0hdROLFd6whQHZBhc5C1zGF3301En48/
         EyYb22cWRE3N251NcwlDgAopWlTlcKwJuKCMdhr1Uve1ElF25fH6usPLG4hwqJZem0um
         784Q==
X-Gm-Message-State: AOJu0Yy514mETkYOSoRW15EUFD1GEDOdYN0OdbxJprFB8H8Kr3m5LCAJ
	R0maOciWFcL0daHyii/9nc5OiQaHux/g4vW4asZ4A80NQ9dpnkQv1aGT3F/d
X-Gm-Gg: ATEYQzx9P1UJVxMYSPOAvGUIVNWcwq42ZiJ6IlIWy0kZ/j73pmrOV/bD5aLUj8slw8q
	UOlGYBnnmz5G3qENqhklCFzJ5QPXPMCyPuwo/CMCt/N9Slq23asmRtuggt3IhdWQnPRLR+siHzA
	ViMvfnQFvipgJCRaUxZHwNGiSsHVXUZZcQ9L+Lk34UBiAqMhLGwRjnNVmImYMZGZ7cnVXdqHYs6
	Nxn5CD6C6GT0zmyi5CJodG8iKVsFcu7R7EzOimDf0DhD9qh93xbxNW3NdpqIS2scLkWNxyXWkVJ
	i6wubRZMM/qIbx8MS0F61xqASfiR1YXugzng/oPbKHF0HzNWgzsxkbdn54Q6Ejg07FvNcmAxs7n
	wmC4AjHi8DwLt1myzCNP7dUwsTCqO3cxqooG0hkt+tRLSw26cAQW8AXmHhoGBbP90E0YCF5yDix
	HzhrjfnX7zdjut+MhWsmZj7zO6+/qehBT5heHWSrrDcX7Yhn4I7PshWWvNUL48hpzU0NjHMQ5f5
	3X3JuBqUgDPyNDyFmkUd1UWL4Kv
X-Received: by 2002:a05:7022:4a4:b0:128:cf86:d1e8 with SMTP id a92af1059eb24-12bfb7653f1mr462715c88.29.1775170540838;
        Thu, 02 Apr 2026 15:55:40 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedea9807sm3133662c88.15.2026.04.02.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:55:40 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 04/14] net: cache snapshot entries for ndo_set_rx_mode_async
Date: Thu,  2 Apr 2026 15:55:25 -0700
Message-ID: <20260402225535.4124525-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-1-sdf@fomichev.me>
References: <20260402225535.4124525-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-274727-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 43CF838EEA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a per-device netdev_hw_addr_list cache (rx_mode_addr_cache) that
allows __hw_addr_list_snapshot() and __hw_addr_list_reconcile() to
reuse previously allocated entries instead of hitting GFP_ATOMIC on
every snapshot cycle.

snapshot pops entries from the cache when available, falling back to
__hw_addr_create(). reconcile splices both snapshot lists back into
the cache via __hw_addr_splice(). The cache is flushed in
free_netdev().

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h      |  7 ++--
 net/core/dev.c                 |  2 ++
 net/core/dev_addr_lists.c      | 66 ++++++++++++++++++++++++----------
 net/core/dev_addr_lists_test.c | 60 +++++++++++++++++++++----------
 4 files changed, 96 insertions(+), 39 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf3dd3f1eb0f..8f8fa72c2c64 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1918,6 +1918,7 @@ enum netdev_reg_state {
  *				additional unicast addresses in a device that
  *				does not implement ndo_set_rx_mode()
  *	@rx_mode_node:		List entry for rx_mode work processing
+ *	@rx_mode_addr_cache:	Recycled snapshot entries for rx_mode work
  *	@uc:			unicast mac addresses
  *	@mc:			multicast mac addresses
  *	@dev_addrs:		list of device hw addresses
@@ -2310,6 +2311,7 @@ struct net_device {
 	unsigned int		allmulti;
 	bool			uc_promisc;
 	struct list_head	rx_mode_node;
+	struct netdev_hw_addr_list	rx_mode_addr_cache;
 #ifdef CONFIG_LOCKDEP
 	unsigned char		nested_level;
 #endif
@@ -5014,10 +5016,11 @@ void __hw_addr_init(struct netdev_hw_addr_list *list);
 void __hw_addr_flush(struct netdev_hw_addr_list *list);
 int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
 			    const struct netdev_hw_addr_list *list,
-			    int addr_len);
+			    int addr_len, struct netdev_hw_addr_list *cache);
 void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
 			      struct netdev_hw_addr_list *work,
-			      struct netdev_hw_addr_list *ref, int addr_len);
+			      struct netdev_hw_addr_list *ref, int addr_len,
+			      struct netdev_hw_addr_list *cache);
 
 /* Functions used for device addresses handling */
 void dev_addr_mod(struct net_device *dev, unsigned int offset,
diff --git a/net/core/dev.c b/net/core/dev.c
index ae1fd30d1ef9..3ddf347dcdd7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12061,6 +12061,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	mutex_init(&dev->lock);
 	INIT_LIST_HEAD(&dev->rx_mode_node);
+	__hw_addr_init(&dev->rx_mode_addr_cache);
 
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
@@ -12167,6 +12168,7 @@ void free_netdev(struct net_device *dev)
 
 	if (netif_rx_mode_clean(dev))
 		dev_put(dev);
+	__hw_addr_flush(&dev->rx_mode_addr_cache);
 
 	/* Flush device addresses */
 	dev_addr_flush(dev);
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 61589537b2d3..2cff791ce374 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -511,30 +511,50 @@ void __hw_addr_init(struct netdev_hw_addr_list *list)
 }
 EXPORT_SYMBOL(__hw_addr_init);
 
+static void __hw_addr_splice(struct netdev_hw_addr_list *dst,
+			     struct netdev_hw_addr_list *src)
+{
+	src->tree = RB_ROOT;
+	list_splice_init(&src->list, &dst->list);
+	dst->count += src->count;
+	src->count = 0;
+}
+
 /**
  *  __hw_addr_list_snapshot - create a snapshot copy of an address list
  *  @snap: destination snapshot list (needs to be __hw_addr_init-initialized)
  *  @list: source address list to snapshot
  *  @addr_len: length of addresses
+ *  @cache: entry cache to reuse entries from; falls back to GFP_ATOMIC
  *
- *  Creates a copy of @list with individually allocated entries suitable
- *  for use with __hw_addr_sync_dev() and other list manipulation helpers.
- *  Each entry is allocated with GFP_ATOMIC; must be called under a spinlock.
+ *  Creates a copy of @list reusing entries from @cache when available.
+ *  Must be called under a spinlock.
  *
  *  Return: 0 on success, -errno on failure.
  */
 int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
 			    const struct netdev_hw_addr_list *list,
-			    int addr_len)
+			    int addr_len, struct netdev_hw_addr_list *cache)
 {
 	struct netdev_hw_addr *ha, *entry;
 
 	list_for_each_entry(ha, &list->list, list) {
-		entry = __hw_addr_create(ha->addr, addr_len, ha->type,
-					 false, false);
-		if (!entry) {
-			__hw_addr_flush(snap);
-			return -ENOMEM;
+		if (cache->count) {
+			entry = list_first_entry(&cache->list,
+						 struct netdev_hw_addr, list);
+			list_del(&entry->list);
+			cache->count--;
+			memcpy(entry->addr, ha->addr, addr_len);
+			entry->type = ha->type;
+			entry->global_use = false;
+			entry->synced = 0;
+		} else {
+			entry = __hw_addr_create(ha->addr, addr_len, ha->type,
+						 false, false);
+			if (!entry) {
+				__hw_addr_flush(snap);
+				return -ENOMEM;
+			}
 		}
 		entry->sync_cnt = ha->sync_cnt;
 		entry->refcount = ha->refcount;
@@ -554,15 +574,17 @@ EXPORT_SYMBOL_IF_KUNIT(__hw_addr_list_snapshot);
  *  @work: the working snapshot (modified by driver via __hw_addr_sync_dev)
  *  @ref: the reference snapshot (untouched copy of original state)
  *  @addr_len: length of addresses
+ *  @cache: entry cache to return snapshot entries to for reuse
  *
  *  Walks the reference snapshot and compares each entry against the work
  *  snapshot to compute sync_cnt deltas. Applies those deltas to @real_list.
- *  Frees both snapshots when done.
+ *  Returns snapshot entries to @cache for reuse; frees both snapshots.
  *  Caller must hold netif_addr_lock_bh.
  */
 void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
 			      struct netdev_hw_addr_list *work,
-			      struct netdev_hw_addr_list *ref, int addr_len)
+			      struct netdev_hw_addr_list *ref, int addr_len,
+			      struct netdev_hw_addr_list *cache)
 {
 	struct netdev_hw_addr *ref_ha, *work_ha, *real_ha;
 	int delta;
@@ -614,8 +636,8 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
 		}
 	}
 
-	__hw_addr_flush(work);
-	__hw_addr_flush(ref);
+	__hw_addr_splice(cache, work);
+	__hw_addr_splice(cache, ref);
 }
 EXPORT_SYMBOL_IF_KUNIT(__hw_addr_list_reconcile);
 
@@ -1176,14 +1198,18 @@ static int netif_addr_lists_snapshot(struct net_device *dev,
 {
 	int err;
 
-	err = __hw_addr_list_snapshot(uc_snap, &dev->uc, dev->addr_len);
+	err = __hw_addr_list_snapshot(uc_snap, &dev->uc, dev->addr_len,
+				      &dev->rx_mode_addr_cache);
 	if (!err)
-		err = __hw_addr_list_snapshot(uc_ref, &dev->uc, dev->addr_len);
+		err = __hw_addr_list_snapshot(uc_ref, &dev->uc, dev->addr_len,
+					      &dev->rx_mode_addr_cache);
 	if (!err)
 		err = __hw_addr_list_snapshot(mc_snap, &dev->mc,
-					      dev->addr_len);
+					      dev->addr_len,
+					      &dev->rx_mode_addr_cache);
 	if (!err)
-		err = __hw_addr_list_snapshot(mc_ref, &dev->mc, dev->addr_len);
+		err = __hw_addr_list_snapshot(mc_ref, &dev->mc, dev->addr_len,
+					      &dev->rx_mode_addr_cache);
 
 	if (err) {
 		__hw_addr_flush(uc_snap);
@@ -1200,8 +1226,10 @@ static void netif_addr_lists_reconcile(struct net_device *dev,
 				       struct netdev_hw_addr_list *uc_ref,
 				       struct netdev_hw_addr_list *mc_ref)
 {
-	__hw_addr_list_reconcile(&dev->uc, uc_snap, uc_ref, dev->addr_len);
-	__hw_addr_list_reconcile(&dev->mc, mc_snap, mc_ref, dev->addr_len);
+	__hw_addr_list_reconcile(&dev->uc, uc_snap, uc_ref, dev->addr_len,
+				 &dev->rx_mode_addr_cache);
+	__hw_addr_list_reconcile(&dev->mc, mc_snap, mc_ref, dev->addr_len,
+				 &dev->rx_mode_addr_cache);
 }
 
 /**
diff --git a/net/core/dev_addr_lists_test.c b/net/core/dev_addr_lists_test.c
index ba8578e7845a..0ccb7a7de894 100644
--- a/net/core/dev_addr_lists_test.c
+++ b/net/core/dev_addr_lists_test.c
@@ -251,8 +251,8 @@ static void dev_addr_test_add_excl(struct kunit *test)
  */
 static void dev_addr_test_snapshot_sync(struct kunit *test)
 {
+	struct netdev_hw_addr_list snap, ref, cache;
 	struct net_device *netdev = test->priv;
-	struct netdev_hw_addr_list snap, ref;
 	struct dev_addr_test_priv *datp;
 	struct netdev_hw_addr *ha;
 	u8 addr[ETH_ALEN];
@@ -268,10 +268,13 @@ static void dev_addr_test_snapshot_sync(struct kunit *test)
 	netif_addr_lock_bh(netdev);
 	__hw_addr_init(&snap);
 	__hw_addr_init(&ref);
+	__hw_addr_init(&cache);
 	KUNIT_ASSERT_EQ(test, 0,
-			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN,
+						&cache));
 	KUNIT_ASSERT_EQ(test, 0,
-			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN,
+						&cache));
 	netif_addr_unlock_bh(netdev);
 
 	/* Driver syncs ADDR_A to hardware */
@@ -283,7 +286,8 @@ static void dev_addr_test_snapshot_sync(struct kunit *test)
 
 	/* Reconcile: delta=+1 applied to real entry */
 	netif_addr_lock_bh(netdev);
-	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN,
+				 &cache);
 	netif_addr_unlock_bh(netdev);
 
 	/* Real entry should now reflect the sync: sync_cnt=1, refcount=2 */
@@ -301,6 +305,7 @@ static void dev_addr_test_snapshot_sync(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
 	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
 
+	__hw_addr_flush(&cache);
 	rtnl_unlock();
 }
 
@@ -310,8 +315,8 @@ static void dev_addr_test_snapshot_sync(struct kunit *test)
  */
 static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
 {
+	struct netdev_hw_addr_list snap, ref, cache;
 	struct net_device *netdev = test->priv;
-	struct netdev_hw_addr_list snap, ref;
 	struct dev_addr_test_priv *datp;
 	struct netdev_hw_addr *ha;
 	u8 addr[ETH_ALEN];
@@ -327,10 +332,13 @@ static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
 	netif_addr_lock_bh(netdev);
 	__hw_addr_init(&snap);
 	__hw_addr_init(&ref);
+	__hw_addr_init(&cache);
 	KUNIT_ASSERT_EQ(test, 0,
-			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN,
+						&cache));
 	KUNIT_ASSERT_EQ(test, 0,
-			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN,
+						&cache));
 	netif_addr_unlock_bh(netdev);
 
 	/* Driver syncs ADDR_A to hardware */
@@ -349,7 +357,8 @@ static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
 	 * so it gets re-inserted as stale (sync_cnt=1, refcount=1).
 	 */
 	netif_addr_lock_bh(netdev);
-	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN,
+				 &cache);
 	netif_addr_unlock_bh(netdev);
 
 	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
@@ -366,6 +375,7 @@ static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_unsynced);
 	KUNIT_EXPECT_EQ(test, 0, netdev->uc.count);
 
+	__hw_addr_flush(&cache);
 	rtnl_unlock();
 }
 
@@ -376,8 +386,8 @@ static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
  */
 static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
 {
+	struct netdev_hw_addr_list snap, ref, cache;
 	struct net_device *netdev = test->priv;
-	struct netdev_hw_addr_list snap, ref;
 	struct dev_addr_test_priv *datp;
 	struct netdev_hw_addr *ha;
 	u8 addr[ETH_ALEN];
@@ -403,10 +413,13 @@ static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
 	netif_addr_lock_bh(netdev);
 	__hw_addr_init(&snap);
 	__hw_addr_init(&ref);
+	__hw_addr_init(&cache);
 	KUNIT_ASSERT_EQ(test, 0,
-			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN,
+						&cache));
 	KUNIT_ASSERT_EQ(test, 0,
-			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN,
+						&cache));
 	netif_addr_unlock_bh(netdev);
 
 	/* Driver unsyncs stale ADDR_A from hardware */
@@ -426,7 +439,8 @@ static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
 	 * applied. Result: sync_cnt=0, refcount=1 (fresh).
 	 */
 	netif_addr_lock_bh(netdev);
-	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN,
+				 &cache);
 	netif_addr_unlock_bh(netdev);
 
 	/* Entry survives as fresh: needs re-sync to HW */
@@ -443,6 +457,7 @@ static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_synced);
 	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
 
+	__hw_addr_flush(&cache);
 	rtnl_unlock();
 }
 
@@ -452,8 +467,8 @@ static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
  */
 static void dev_addr_test_snapshot_add_and_remove(struct kunit *test)
 {
+	struct netdev_hw_addr_list snap, ref, cache;
 	struct net_device *netdev = test->priv;
-	struct netdev_hw_addr_list snap, ref;
 	struct dev_addr_test_priv *datp;
 	struct netdev_hw_addr *ha;
 	u8 addr[ETH_ALEN];
@@ -480,10 +495,13 @@ static void dev_addr_test_snapshot_add_and_remove(struct kunit *test)
 	netif_addr_lock_bh(netdev);
 	__hw_addr_init(&snap);
 	__hw_addr_init(&ref);
+	__hw_addr_init(&cache);
 	KUNIT_ASSERT_EQ(test, 0,
-			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN,
+						&cache));
 	KUNIT_ASSERT_EQ(test, 0,
-			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN,
+						&cache));
 	netif_addr_unlock_bh(netdev);
 
 	/* Driver syncs snapshot: ADDR_C is new -> synced; A,B already synced */
@@ -502,7 +520,8 @@ static void dev_addr_test_snapshot_add_and_remove(struct kunit *test)
 	 * so nothing to apply to ADDR_B.
 	 */
 	netif_addr_lock_bh(netdev);
-	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN,
+				 &cache);
 	netif_addr_unlock_bh(netdev);
 
 	/* ADDR_A: unchanged (sync_cnt=1, refcount=2)
@@ -536,13 +555,14 @@ static void dev_addr_test_snapshot_add_and_remove(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 << ADDR_B, datp->addr_unsynced);
 	KUNIT_EXPECT_EQ(test, 2, netdev->uc.count);
 
+	__hw_addr_flush(&cache);
 	rtnl_unlock();
 }
 
 static void dev_addr_test_snapshot_benchmark(struct kunit *test)
 {
 	struct net_device *netdev = test->priv;
-	struct netdev_hw_addr_list snap;
+	struct netdev_hw_addr_list snap, cache;
 	s64 duration = 0;
 	ktime_t start;
 	u8 addr[ETH_ALEN];
@@ -557,6 +577,8 @@ static void dev_addr_test_snapshot_benchmark(struct kunit *test)
 		KUNIT_ASSERT_EQ(test, 0, dev_uc_add(netdev, addr));
 	}
 
+	__hw_addr_init(&cache);
+
 	for (iter = 0; iter < 1000; iter++) {
 		netif_addr_lock_bh(netdev);
 		__hw_addr_init(&snap);
@@ -564,13 +586,15 @@ static void dev_addr_test_snapshot_benchmark(struct kunit *test)
 		start = ktime_get();
 		KUNIT_ASSERT_EQ(test, 0,
 				__hw_addr_list_snapshot(&snap, &netdev->uc,
-							ETH_ALEN));
+							ETH_ALEN, &cache));
 		duration += ktime_to_ns(ktime_sub(ktime_get(), start));
 
 		netif_addr_unlock_bh(netdev);
 		__hw_addr_flush(&snap);
 	}
 
+	__hw_addr_flush(&cache);
+
 	kunit_info(test,
 		   "1024 addrs x 1000 snapshots: %lld ns total, %lld ns/iter",
 		   duration, div_s64(duration, 1000));
-- 
2.53.0



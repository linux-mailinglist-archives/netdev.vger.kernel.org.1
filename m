Return-Path: <netdev+bounces-269739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGXVKUCivGns1gIAu9opvQ
	(envelope-from <netdev+bounces-269739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:26:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC9A2D4B1F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92BDF312585B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DD72D6E62;
	Fri, 20 Mar 2026 01:25:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879DD2C21F2
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969908; cv=none; b=PW+blwU1ZQCliY6huRkH3FA1NL8YzCtg7b06blTvsGyoUZA1kpoRompryIfQi0Y5Cpupesim9Vwi3v5sgUlstYcLhPftUT+SuoJYngu7ALNWr6t0pUpsOpARmx0+AMPSzuAvvKgN4puIg4dhmqHcDI2jWHjXIt11wc7fiihhUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969908; c=relaxed/simple;
	bh=uhR2cakGptm0ZmW+/GIUCGLgF1VWhUBI079qUN2e4V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv0wG8hOlOccuoW40MmysVCvnL9uSpjRNmb+qwMum9W0RA+Ggme8dPCgAZ9seUjOPP/uOtdQbPSsg+6XphscL9S3vIccFXgRVTYH8ouRe4Rjqm4Jbp/QdTEHhH7WjkiTujzWXoca3QGcoEWLS2AMa5WmkoYmpDXegtsMuIv+z+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1273349c56bso213125c88.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969905; x=1774574705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yf/HVmFfOm5ohkPNhRXNKW0xl30aRPHieitiLoYoy70=;
        b=Fntl0vuLpuYRMRcxTpaLtiCIEwtIsErVQ4rwr8Crqa5mAWA1flImzfIq7a7h6q0Fj0
         z9wvumUsiO3rUhTqlSP3d1I1yVyJ7B66DA522KhEH2pJBvhd3qPiwTYq8ytNQNAD6e/+
         01CykW/Iq/2Mo2ofueW2A/PO0KmOLIkBttnLfCafK46mpEtzL1KKpcHUWRKsEeJC0NBP
         d8HYbONx6qgtgBzEC8ugMT71Cro3CE4no8OFgQSh6B8ATafBTB5ClOB9mmaqaGo0/3xy
         +teM1eW3N5pF3khEOGUH3MW6wObGO7sqwU4TBNl24wYRX0r6gR1eXksDz34P696Pch23
         MTCA==
X-Gm-Message-State: AOJu0YzzB+H5gXSu59701qM4WoBI7WD+EOFweIURdp32HkhHe1gcRgjm
	8uCu3EJLuvwVDFQY5UknQk2alDVwGpHQ3XPEFLEya+VxycLs+MgnuqQKAwWz
X-Gm-Gg: ATEYQzyXAgKoSQHydlwoOUSPiirUanwYgdDO2aILntfIkpYsy0mfOM+QeAyeLZdQBqT
	WA80Nhlqu0u54CWM76J5EcEhy2Wo3VgV5WOBUiksAMccaYK0WmJmBeYohGXcbIQrYxym0f0vjQk
	QoIPC8OpQIabIxRpE9leTdFcF4Wkr8pABc9DfQFEEPLQD6AnP67Fgq6/SI+hCYtOqfmYqfm44ae
	frX1x7p2md4bM2k8t3vqP68flp0piweZ5x5DrQxNWrJpBsi7majoNZojAggN6nv/ToqtVvGiHZr
	NVoy6EjFFVIdxInSsZLD0WoU75H/3+D4B1kebMV8Z0mL1ZgYXfgYqSWvyjRt3/cH56Cu5zXyIOI
	mtC2XSi4tEzxDJdJNNBUYS2JE6aGmWiAZsDk3lSu47QUNt990Wn7RYJm0SR06JTFhLnm2FzTb1j
	Se2VWoRoaMkrrXmgGQtR7cey8t0FrIQ8dQv4uMQ1Do+nw3JiqXC7gQ8ugNwnKCdMcNEI7EzUmyU
	ez6s/79mTiV4ztzgw==
X-Received: by 2002:a05:7022:3d11:b0:128:d7a7:526f with SMTP id a92af1059eb24-12a7264eb64mr555030c88.4.1773969904175;
        Thu, 19 Mar 2026 18:25:04 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a734bbbc5sm746699c88.11.2026.03.19.18.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:03 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	aleksandr.loktionov@intel.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 01/13] net: add address list snapshot and reconciliation infrastructure
Date: Thu, 19 Mar 2026 18:24:49 -0700
Message-ID: <20260320012501.2033548-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269739-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.182];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid,intel.com:email]
X-Rspamd-Queue-Id: 0CC9A2D4B1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce __hw_addr_list_snapshot() and __hw_addr_list_reconcile()
for use by the upcoming ndo_set_rx_mode_async callback.

The async rx_mode path needs to snapshot the device's unicast and
multicast address lists under the addr_lock, hand those snapshots
to the driver (which may sleep), and then propagate any sync_cnt
changes back to the real lists. Two identical snapshots are taken:
a work copy for the driver to pass to __hw_addr_sync_dev() and a
reference copy to compute deltas against.

__hw_addr_list_reconcile() walks the reference snapshot comparing
each entry against the work snapshot to determine what the driver
synced or unsynced. It then applies those deltas to the real list,
handling concurrent modifications:

  - If the real entry was concurrently removed but the driver synced
    it to hardware (delta > 0), re-insert a stale entry so the next
    work run properly unsyncs it from hardware.
  - If the entry still exists, apply the delta normally. An entry
    whose refcount drops to zero is removed.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h      |   6 +
 net/core/dev.h                 |   1 +
 net/core/dev_addr_lists.c      | 110 ++++++++++-
 net/core/dev_addr_lists_test.c | 321 ++++++++++++++++++++++++++++++++-
 4 files changed, 435 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ae269a2e7f4d..469b7cdb3237 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4985,6 +4985,12 @@ void __hw_addr_unsync_dev(struct netdev_hw_addr_list *list,
 			  int (*unsync)(struct net_device *,
 					const unsigned char *));
 void __hw_addr_init(struct netdev_hw_addr_list *list);
+int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
+			    const struct netdev_hw_addr_list *list,
+			    int addr_len);
+void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
+			      struct netdev_hw_addr_list *work,
+			      struct netdev_hw_addr_list *ref, int addr_len);
 
 /* Functions used for device addresses handling */
 void dev_addr_mod(struct net_device *dev, unsigned int offset,
diff --git a/net/core/dev.h b/net/core/dev.h
index 781619e76b3e..acc925b7b337 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -69,6 +69,7 @@ void linkwatch_run_queue(void);
 void dev_addr_flush(struct net_device *dev);
 int dev_addr_init(struct net_device *dev);
 void dev_addr_check(struct net_device *dev);
+void __hw_addr_flush(struct netdev_hw_addr_list *list);
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 void net_shaper_flush_netdev(struct net_device *dev);
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 76c91f224886..754f5ea4c3db 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -481,7 +481,7 @@ void __hw_addr_unsync_dev(struct netdev_hw_addr_list *list,
 }
 EXPORT_SYMBOL(__hw_addr_unsync_dev);
 
-static void __hw_addr_flush(struct netdev_hw_addr_list *list)
+void __hw_addr_flush(struct netdev_hw_addr_list *list)
 {
 	struct netdev_hw_addr *ha, *tmp;
 
@@ -501,6 +501,114 @@ void __hw_addr_init(struct netdev_hw_addr_list *list)
 }
 EXPORT_SYMBOL(__hw_addr_init);
 
+/**
+ *  __hw_addr_list_snapshot - create a snapshot copy of an address list
+ *  @snap: destination snapshot list (needs to be __hw_addr_init-initialized)
+ *  @list: source address list to snapshot
+ *  @addr_len: length of addresses
+ *
+ *  Creates a copy of @list with individually allocated entries suitable
+ *  for use with __hw_addr_sync_dev() and other list manipulation helpers.
+ *  Each entry is allocated with GFP_ATOMIC; must be called under a spinlock.
+ *
+ *  Return: 0 on success, -errno on failure.
+ */
+int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
+			    const struct netdev_hw_addr_list *list,
+			    int addr_len)
+{
+	struct netdev_hw_addr *ha, *entry;
+
+	list_for_each_entry(ha, &list->list, list) {
+		entry = __hw_addr_create(ha->addr, addr_len, ha->type,
+					 false, false);
+		if (!entry) {
+			__hw_addr_flush(snap);
+			return -ENOMEM;
+		}
+		entry->sync_cnt = ha->sync_cnt;
+		entry->refcount = ha->refcount;
+
+		list_add_tail(&entry->list, &snap->list);
+		__hw_addr_insert(snap, entry, addr_len);
+		snap->count++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(__hw_addr_list_snapshot);
+
+/**
+ *  __hw_addr_list_reconcile - sync snapshot changes back and free snapshots
+ *  @real_list: the real address list to update
+ *  @work: the working snapshot (modified by driver via __hw_addr_sync_dev)
+ *  @ref: the reference snapshot (untouched copy of original state)
+ *  @addr_len: length of addresses
+ *
+ *  Walks the reference snapshot and compares each entry against the work
+ *  snapshot to compute sync_cnt deltas. Applies those deltas to @real_list.
+ *  Frees both snapshots when done.
+ *  Caller must hold netif_addr_lock_bh.
+ */
+void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
+			      struct netdev_hw_addr_list *work,
+			      struct netdev_hw_addr_list *ref, int addr_len)
+{
+	struct netdev_hw_addr *ref_ha, *work_ha, *real_ha;
+	int delta;
+
+	list_for_each_entry(ref_ha, &ref->list, list) {
+		work_ha = __hw_addr_lookup(work, ref_ha->addr, addr_len,
+					   ref_ha->type);
+		if (work_ha)
+			delta = work_ha->sync_cnt - ref_ha->sync_cnt;
+		else
+			delta = -1;
+
+		if (delta == 0)
+			continue;
+
+		real_ha = __hw_addr_lookup(real_list, ref_ha->addr, addr_len,
+					   ref_ha->type);
+		if (!real_ha) {
+			/* The real entry was concurrently removed. If the
+			 * driver synced this addr to hardware (delta > 0),
+			 * re-insert it as a stale entry so the next work
+			 * run unsyncs it from hardware.
+			 */
+			if (delta > 0) {
+				real_ha = __hw_addr_create(ref_ha->addr,
+							   addr_len,
+							   ref_ha->type, false,
+							   false);
+				if (real_ha) {
+					real_ha->sync_cnt = 1;
+					real_ha->refcount = 1;
+					list_add_tail_rcu(&real_ha->list,
+							  &real_list->list);
+					__hw_addr_insert(real_list, real_ha,
+							 addr_len);
+					real_list->count++;
+				}
+			}
+			continue;
+		}
+
+		real_ha->sync_cnt += delta;
+		real_ha->refcount += delta;
+		if (!real_ha->refcount) {
+			rb_erase(&real_ha->node, &real_list->tree);
+			list_del_rcu(&real_ha->list);
+			kfree_rcu(real_ha, rcu_head);
+			real_list->count--;
+		}
+	}
+
+	__hw_addr_flush(work);
+	__hw_addr_flush(ref);
+}
+EXPORT_SYMBOL(__hw_addr_list_reconcile);
+
 /*
  * Device addresses handling functions
  */
diff --git a/net/core/dev_addr_lists_test.c b/net/core/dev_addr_lists_test.c
index 8e1dba825e94..c62ce06fc4d5 100644
--- a/net/core/dev_addr_lists_test.c
+++ b/net/core/dev_addr_lists_test.c
@@ -8,16 +8,24 @@
 static const struct net_device_ops dummy_netdev_ops = {
 };
 
+#define ADDR_A	1
+#define ADDR_B	2
+#define ADDR_C	3
+
 struct dev_addr_test_priv {
 	u32 addr_seen;
+	u32 addr_synced;
+	u32 addr_unsynced;
 };
 
 static int dev_addr_test_sync(struct net_device *netdev, const unsigned char *a)
 {
 	struct dev_addr_test_priv *datp = netdev_priv(netdev);
 
-	if (a[0] < 31 && !memchr_inv(a, a[0], ETH_ALEN))
+	if (a[0] < 31 && !memchr_inv(a, a[0], ETH_ALEN)) {
 		datp->addr_seen |= 1 << a[0];
+		datp->addr_synced |= 1 << a[0];
+	}
 	return 0;
 }
 
@@ -26,11 +34,22 @@ static int dev_addr_test_unsync(struct net_device *netdev,
 {
 	struct dev_addr_test_priv *datp = netdev_priv(netdev);
 
-	if (a[0] < 31 && !memchr_inv(a, a[0], ETH_ALEN))
+	if (a[0] < 31 && !memchr_inv(a, a[0], ETH_ALEN)) {
 		datp->addr_seen &= ~(1 << a[0]);
+		datp->addr_unsynced |= 1 << a[0];
+	}
 	return 0;
 }
 
+static void dev_addr_test_reset(struct net_device *netdev)
+{
+	struct dev_addr_test_priv *datp = netdev_priv(netdev);
+
+	datp->addr_seen = 0;
+	datp->addr_synced = 0;
+	datp->addr_unsynced = 0;
+}
+
 static int dev_addr_test_init(struct kunit *test)
 {
 	struct dev_addr_test_priv *datp;
@@ -225,6 +244,300 @@ static void dev_addr_test_add_excl(struct kunit *test)
 	rtnl_unlock();
 }
 
+/* Snapshot test: basic sync with no concurrent modifications.
+ * Add one address, snapshot, driver syncs it, reconcile propagates
+ * sync_cnt delta back to real list.
+ */
+static void dev_addr_test_snapshot_sync(struct kunit *test)
+{
+	struct net_device *netdev = test->priv;
+	struct netdev_hw_addr_list snap, ref;
+	struct dev_addr_test_priv *datp;
+	struct netdev_hw_addr *ha;
+	u8 addr[ETH_ALEN];
+
+	datp = netdev_priv(netdev);
+
+	rtnl_lock();
+
+	memset(addr, ADDR_A, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+
+	/* Snapshot: ADDR_A has sync_cnt=0, refcount=1 (new) */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_init(&snap);
+	__hw_addr_init(&ref);
+	KUNIT_ASSERT_EQ(test, 0,
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+	KUNIT_ASSERT_EQ(test, 0,
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+	netif_addr_unlock_bh(netdev);
+
+	/* Driver syncs ADDR_A to hardware */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&snap, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+
+	/* Reconcile: delta=+1 applied to real entry */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	netif_addr_unlock_bh(netdev);
+
+	/* Real entry should now reflect the sync: sync_cnt=1, refcount=2 */
+	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
+	ha = list_first_entry(&netdev->uc.list, struct netdev_hw_addr, list);
+	KUNIT_EXPECT_MEMEQ(test, ha->addr, addr, ETH_ALEN);
+	KUNIT_EXPECT_EQ(test, 1, ha->sync_cnt);
+	KUNIT_EXPECT_EQ(test, 2, ha->refcount);
+
+	/* Second work run: already synced, nothing to do */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
+
+	rtnl_unlock();
+}
+
+/* Snapshot test: ADDR_A synced to hardware, then concurrently removed
+ * from the real list before reconcile runs. Reconcile re-inserts ADDR_A as
+ * a stale entry so the next work run unsyncs it from hardware.
+ */
+static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
+{
+	struct net_device *netdev = test->priv;
+	struct netdev_hw_addr_list snap, ref;
+	struct dev_addr_test_priv *datp;
+	struct netdev_hw_addr *ha;
+	u8 addr[ETH_ALEN];
+
+	datp = netdev_priv(netdev);
+
+	rtnl_lock();
+
+	memset(addr, ADDR_A, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+
+	/* Snapshot: ADDR_A is new (sync_cnt=0, refcount=1) */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_init(&snap);
+	__hw_addr_init(&ref);
+	KUNIT_ASSERT_EQ(test, 0,
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+	KUNIT_ASSERT_EQ(test, 0,
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+	netif_addr_unlock_bh(netdev);
+
+	/* Driver syncs ADDR_A to hardware */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&snap, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+
+	/* Concurrent removal: user deletes ADDR_A while driver was working */
+	memset(addr, ADDR_A, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_del(netdev, addr));
+	KUNIT_EXPECT_EQ(test, 0, netdev->uc.count);
+
+	/* Reconcile: ADDR_A gone from real list but driver synced it,
+	 * so it gets re-inserted as stale (sync_cnt=1, refcount=1).
+	 */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	netif_addr_unlock_bh(netdev);
+
+	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
+	ha = list_first_entry(&netdev->uc.list, struct netdev_hw_addr, list);
+	KUNIT_EXPECT_MEMEQ(test, ha->addr, addr, ETH_ALEN);
+	KUNIT_EXPECT_EQ(test, 1, ha->sync_cnt);
+	KUNIT_EXPECT_EQ(test, 1, ha->refcount);
+
+	/* Second work run: stale entry gets unsynced from HW and removed */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_unsynced);
+	KUNIT_EXPECT_EQ(test, 0, netdev->uc.count);
+
+	rtnl_unlock();
+}
+
+/* Snapshot test: ADDR_A was stale (unsynced from hardware by driver),
+ * but concurrently re-added by the user. The re-add bumps refcount of
+ * the existing stale entry. Reconcile applies delta=-1, leaving ADDR_A
+ * as a fresh entry (sync_cnt=0, refcount=1) for the next work run.
+ */
+static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
+{
+	struct net_device *netdev = test->priv;
+	struct netdev_hw_addr_list snap, ref;
+	struct dev_addr_test_priv *datp;
+	struct netdev_hw_addr *ha;
+	u8 addr[ETH_ALEN];
+
+	datp = netdev_priv(netdev);
+
+	rtnl_lock();
+
+	memset(addr, ADDR_A, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+
+	/* Sync ADDR_A to hardware: sync_cnt=1, refcount=2 */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+
+	/* User removes ADDR_A: refcount=1, sync_cnt=1 -> stale */
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_del(netdev, addr));
+
+	/* Snapshot: ADDR_A is stale (sync_cnt=1, refcount=1) */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_init(&snap);
+	__hw_addr_init(&ref);
+	KUNIT_ASSERT_EQ(test, 0,
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+	KUNIT_ASSERT_EQ(test, 0,
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+	netif_addr_unlock_bh(netdev);
+
+	/* Driver unsyncs stale ADDR_A from hardware */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&snap, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_unsynced);
+
+	/* Concurrent: user re-adds ADDR_A.  dev_uc_add finds the existing
+	 * stale entry and bumps refcount from 1 -> 2.  sync_cnt stays 1.
+	 */
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
+
+	/* Reconcile: ref sync_cnt=1 matches real sync_cnt=1, delta=-1
+	 * applied. Result: sync_cnt=0, refcount=1 (fresh).
+	 */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	netif_addr_unlock_bh(netdev);
+
+	/* Entry survives as fresh: needs re-sync to HW */
+	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
+	ha = list_first_entry(&netdev->uc.list, struct netdev_hw_addr, list);
+	KUNIT_EXPECT_MEMEQ(test, ha->addr, addr, ETH_ALEN);
+	KUNIT_EXPECT_EQ(test, 0, ha->sync_cnt);
+	KUNIT_EXPECT_EQ(test, 1, ha->refcount);
+
+	/* Second work run: fresh entry gets synced to HW */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+
+	rtnl_unlock();
+}
+
+/* Snapshot test: ADDR_A is new (synced by driver), and independent ADDR_B
+ * is concurrently removed from the real list. A's sync delta propagates
+ * normally; B's absence doesn't interfere.
+ */
+static void dev_addr_test_snapshot_add_and_remove(struct kunit *test)
+{
+	struct net_device *netdev = test->priv;
+	struct netdev_hw_addr_list snap, ref;
+	struct dev_addr_test_priv *datp;
+	struct netdev_hw_addr *ha;
+	u8 addr[ETH_ALEN];
+
+	datp = netdev_priv(netdev);
+
+	rtnl_lock();
+
+	/* Add ADDR_A and ADDR_B (will be synced then removed) */
+	memset(addr, ADDR_A, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+	memset(addr, ADDR_B, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+
+	/* Sync both to hardware: sync_cnt=1, refcount=2 */
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+
+	/* Add ADDR_C (new, will be synced by snapshot) */
+	memset(addr, ADDR_C, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+
+	/* Snapshot: A,B synced (sync_cnt=1,refcount=2); C new (0,1) */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_init(&snap);
+	__hw_addr_init(&ref);
+	KUNIT_ASSERT_EQ(test, 0,
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+	KUNIT_ASSERT_EQ(test, 0,
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+	netif_addr_unlock_bh(netdev);
+
+	/* Driver syncs snapshot: ADDR_C is new -> synced; A,B already synced */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&snap, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_C, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+
+	/* Concurrent: user removes addr B while driver was working */
+	memset(addr, ADDR_B, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_del(netdev, addr));
+
+	/* Reconcile: ADDR_C's delta=+1 applied to real list.
+	 * ADDR_B's delta=0 (unchanged in snapshot),
+	 * so nothing to apply to ADDR_B.
+	 */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	netif_addr_unlock_bh(netdev);
+
+	/* ADDR_A: unchanged (sync_cnt=1, refcount=2)
+	 * ADDR_B: refcount went from 2->1 via dev_uc_del (still present, stale)
+	 * ADDR_C: sync propagated (sync_cnt=1, refcount=2)
+	 */
+	KUNIT_EXPECT_EQ(test, 3, netdev->uc.count);
+	netdev_hw_addr_list_for_each(ha, &netdev->uc) {
+		u8 id = ha->addr[0];
+
+		if (!memchr_inv(ha->addr, id, ETH_ALEN)) {
+			if (id == ADDR_A) {
+				KUNIT_EXPECT_EQ(test, 1, ha->sync_cnt);
+				KUNIT_EXPECT_EQ(test, 2, ha->refcount);
+			} else if (id == ADDR_B) {
+				/* B: still present but now stale */
+				KUNIT_EXPECT_EQ(test, 1, ha->sync_cnt);
+				KUNIT_EXPECT_EQ(test, 1, ha->refcount);
+			} else if (id == ADDR_C) {
+				KUNIT_EXPECT_EQ(test, 1, ha->sync_cnt);
+				KUNIT_EXPECT_EQ(test, 2, ha->refcount);
+			}
+		}
+	}
+
+	/* Second work run: ADDR_B is stale, gets unsynced and removed */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_B, datp->addr_unsynced);
+	KUNIT_EXPECT_EQ(test, 2, netdev->uc.count);
+
+	rtnl_unlock();
+}
+
 static struct kunit_case dev_addr_test_cases[] = {
 	KUNIT_CASE(dev_addr_test_basic),
 	KUNIT_CASE(dev_addr_test_sync_one),
@@ -232,6 +545,10 @@ static struct kunit_case dev_addr_test_cases[] = {
 	KUNIT_CASE(dev_addr_test_del_main),
 	KUNIT_CASE(dev_addr_test_add_set),
 	KUNIT_CASE(dev_addr_test_add_excl),
+	KUNIT_CASE(dev_addr_test_snapshot_sync),
+	KUNIT_CASE(dev_addr_test_snapshot_remove_during_sync),
+	KUNIT_CASE(dev_addr_test_snapshot_readd_during_unsync),
+	KUNIT_CASE(dev_addr_test_snapshot_add_and_remove),
 	{}
 };
 
-- 
2.53.0



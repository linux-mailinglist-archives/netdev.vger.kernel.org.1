Return-Path: <netdev+bounces-153933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8099FA1E8
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 19:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD9E1675C1
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 18:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA9E1865EA;
	Sat, 21 Dec 2024 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="BjVUyv30"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4816DEA9;
	Sat, 21 Dec 2024 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734806586; cv=none; b=q68vZ2rEpeZSiIo12lfYGGaJOXKlXw+4LbD6TEuFWDSkOGHZVtQMVMFun8XoAVAWRVrR7f3cwWqmdbpcFmSNNM1w7/gZSAEfJeOV09TzFUF7o3WHWQX4DEtggeEL6dIbHwuIuLl+pd61W6gX6HOwL8MVWXKTo7O2tGBYoI7nz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734806586; c=relaxed/simple;
	bh=y5nsRiUgPYgh8AAUFzUWMtxYlBmmeazEtoG6wRvTtg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpDU3ovctAUpYIEcUeOIh1PZqYJ9RX3fpR4AnspOMx/ZC0WANTuWH/VZEFYdYwOkB03pbITXoXkV6UUQTBe75D3LDSkTWe+hSjnj4qTHHba0/SQ6OwzCxqNM94zWjfK0RlY8yGgRji2Vq7lguKf5MQ7YnxbwcSJjNuVhOOG8amg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=BjVUyv30; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=garTpmgVCRsiT24Y9HEp7HK8vg0zYHqQEomkjWoz8/w=; b=BjVUyv30k10NKb4V
	BD/soBvi+aNB0pLq2CxbwiFFVrt/qrxTsUAa8VQGWOMzNlR35rI4HL401F6bmmKHsHSXKWuj7ecar
	e6ve3xi17zgbPK0aTzDcOjlXfl1aGAWhGMEgqf45x8fhPt684jXbxgcUXsS8jUrbk2qEU9k3KpoR4
	6raYUIWtyXRg0Q3lFkXO8RFoHi+OgXAd5vZSPZYLfW7QlxKri0TDHRLWtZU1FHnxrsFl95XLX3LTW
	8ppX04UEx7WjddB+mLzkMCj+yPzPJMs5/NHgWKRbd4Mc92nwwrt0Uj+MparB5IsoslFPs/79VyWhp
	OIr/8FBpUiSVBBRH4g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tP4RA-006hEJ-05;
	Sat, 21 Dec 2024 18:42:52 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [RFC net-next 6/9] i40e: Remove unused i40e_del_filter
Date: Sat, 21 Dec 2024 18:42:44 +0000
Message-ID: <20241221184247.118752-7-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221184247.118752-1-linux@treblig.org>
References: <20241221184247.118752-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of i40e_del_filter() was removed in 2016 by
commit 9569a9a4547d ("i40e: when adding or removing MAC filters, correctly
handle VLANs")

Remove it.

Fix up a comment that referenced it.

Note: The __ version of this function is still used.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c | 28 ++-------------------
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 5d9738b746f4..399a5dbf3506 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1196,7 +1196,6 @@ void i40e_set_ethtool_ops(struct net_device *netdev);
 struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 					const u8 *macaddr, s16 vlan);
 void __i40e_del_filter(struct i40e_vsi *vsi, struct i40e_mac_filter *f);
-void i40e_del_filter(struct i40e_vsi *vsi, const u8 *macaddr, s16 vlan);
 int i40e_sync_vsi_filters(struct i40e_vsi *vsi);
 struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 				u16 uplink, u32 param1);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 83ba1effe8ba..276dde0bc1d4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1666,9 +1666,8 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
  * @vsi: VSI to remove from
  * @f: the filter to remove from the list
  *
- * This function should be called instead of i40e_del_filter only if you know
- * the exact filter you will remove already, such as via i40e_find_filter or
- * i40e_find_mac.
+ * This function requires you've found * the exact filter you will remove
+ * already, such as via i40e_find_filter or i40e_find_mac.
  *
  * NOTE: This function is expected to be called with mac_filter_hash_lock
  * being held.
@@ -1697,29 +1696,6 @@ void __i40e_del_filter(struct i40e_vsi *vsi, struct i40e_mac_filter *f)
 	set_bit(__I40E_MACVLAN_SYNC_PENDING, vsi->back->state);
 }
 
-/**
- * i40e_del_filter - Remove a MAC/VLAN filter from the VSI
- * @vsi: the VSI to be searched
- * @macaddr: the MAC address
- * @vlan: the VLAN
- *
- * NOTE: This function is expected to be called with mac_filter_hash_lock
- * being held.
- * ANOTHER NOTE: This function MUST be called from within the context of
- * the "safe" variants of any list iterators, e.g. list_for_each_entry_safe()
- * instead of list_for_each_entry().
- **/
-void i40e_del_filter(struct i40e_vsi *vsi, const u8 *macaddr, s16 vlan)
-{
-	struct i40e_mac_filter *f;
-
-	if (!vsi || !macaddr)
-		return;
-
-	f = i40e_find_filter(vsi, macaddr, vlan);
-	__i40e_del_filter(vsi, f);
-}
-
 /**
  * i40e_add_mac_filter - Add a MAC filter for all active VLANs
  * @vsi: the VSI to be searched
-- 
2.47.1



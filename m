Return-Path: <netdev+bounces-154788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAA39FFCD3
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FD03A2F42
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399F1865F0;
	Thu,  2 Jan 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="LJvD+N+c"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB14165EFC;
	Thu,  2 Jan 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839462; cv=none; b=cylGw2jrl59huiA9Em3W3B/LBXi+c+D4jsl0OrbnwrNAGS16mglm8s5um86EwVZQRAFakQ7WTQMZy17aBf4Ik+xkUrSuJ1Hq96rN1LC6ei6rPBh/QaFe6Tod+pn3uPMiZmx/VCIDniML+uE5XEoU4UDDw1Mv1dIN7AVyIfrcm7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839462; c=relaxed/simple;
	bh=y5nsRiUgPYgh8AAUFzUWMtxYlBmmeazEtoG6wRvTtg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0X47T5Ga0iqWWVOKDDMGvvo7EKa564pzPRSOb3LRmyCu45NWvvdOHSY/0EiWkJyFKmEIJE+966q9f2VGNeJ1YB1sh7Cag3w5F53XKeN6jlIltdvxyx2lRLCb7uUS5zAbIu0fx4UBO1a80LiLZjH86NoXKHLhOioCZ4AevPD7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=LJvD+N+c; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=garTpmgVCRsiT24Y9HEp7HK8vg0zYHqQEomkjWoz8/w=; b=LJvD+N+cGlGEHL10
	dpF6XU9k2B6ugTVwkhcwdtvS+eVCYztU5plVhwTWat3NsshQRfahvkDMCtVqqL5ISr4FT5q1yw5YW
	KpdIt6KugsQMSHXQqn8HVEldeRJvoa5jcndNuSwXWw0vKdIibs3tO4Z+vHoX+gzkaN3r0FiB4oXuf
	sYb4u1K/1JxBSygbdKoE85zLD/ReyP7W5bQ2ImyB5lmR0uE2DP3rhYNshis5sbEeJt6SMg9ZrVGiP
	FzOJanMeAU8XlYa4ntJbT8LjkEtIr2f4vHxW80LY5e0m+4LkuuIR472eE/xN6WJ2t2W2LSPF6H5aw
	3hS8jzbWb8o/DIdsxg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTP8N-007tod-31;
	Thu, 02 Jan 2025 17:37:24 +0000
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
Subject: [PATCH net-next 6/9] i40e: Remove unused i40e_del_filter
Date: Thu,  2 Jan 2025 17:37:14 +0000
Message-ID: <20250102173717.200359-7-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102173717.200359-1-linux@treblig.org>
References: <20250102173717.200359-1-linux@treblig.org>
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



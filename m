Return-Path: <netdev+bounces-195745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66649AD2251
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C37D164E27
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF61A2C0B;
	Mon,  9 Jun 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Z4VW/vvC"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA401DA5F;
	Mon,  9 Jun 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482630; cv=none; b=FgMI42nNoKJzUWRfuhwCauisHWErLfRLETaYyLSqq/7DlGwY3Z9OSbSqvWjSFA9bLj8JV+ske4h4cVmr1HIyFpUVrzrP3gCv6bXjZ+ZH0keFoxc8oUTxHPf3HZaVHeJgYjTANKbqgrq7L9SpmHaQ34G5TTszL2gp3FK2WHXGaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482630; c=relaxed/simple;
	bh=BdUcjRRvSLLWka5U57jJO0G2e7/tVuCHFhZgA60z8WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kU1+vo9mlIhQjnSrNxKKyyfVe7q4XW3Sypf5rI3h7jEGhPybTBa0FZ8qwdvS0f62VR8MZfaMEBg3z6BddoSNkGcfOpWP59plCEuDLAbPKG5fk031MqCByubgAgWCSqjTEZ+JXPN4RAWwO5IObDeQuhBPvK32WlQQFqVcqZor1tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Z4VW/vvC; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=+I81mYkss4iXVd4qqii/+SHPD2opsMDFxEhS0MTaCiU=; b=Z4VW/vvC7ZkXwX5g
	ZtTn5VRZoVgaTjx/22DfXa1xQKyC6oFuilWqYVFgubtXN+cRloARdhpibFD4ptewCF/P0aVTnQVMb
	iGugiQmA8lzVL/onD14CiPqwLFkSPWKbUo2DBMDwIv04xNUcPeoFmFbpLpFSvKGw/y6bsFafhEl9+
	muzYccoDuWLX6kXRJkGO62Aot2N6lAJ5mR4FX1Lq4UaWVfK6EtDmgBm5Z1Jtpk5rBNAv/pYiT1NGw
	jg0fF4WE9bPWutuIXQVAC65cTKfUSSoG2FUeYpKXNNHzXs3qisR2ldNElv0Qlj/EmccM46SPaK2Bb
	0paOPIHA+FYVM6NM9g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uOeLT-008QN5-0J;
	Mon, 09 Jun 2025 15:23:31 +0000
From: linux@treblig.org
To: bharat@chelsio.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] cxgb3/l2t: Remove unused t3_l2t_send_event
Date: Mon,  9 Jun 2025 16:23:30 +0100
Message-ID: <20250609152330.24027-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of t3_l2t_send_event() was removed in 2019 by
commit 30e0f6cf5acb ("RDMA/iw_cxgb3: Remove the iw_cxgb3 module from
kernel")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/chelsio/cxgb3/l2t.c | 37 ------------------------
 drivers/net/ethernet/chelsio/cxgb3/l2t.h |  1 -
 2 files changed, 38 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/l2t.c b/drivers/net/ethernet/chelsio/cxgb3/l2t.c
index 9749d1239f58..5d5f3380ecca 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/l2t.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/l2t.c
@@ -176,43 +176,6 @@ int t3_l2t_send_slow(struct t3cdev *dev, struct sk_buff *skb,
 
 EXPORT_SYMBOL(t3_l2t_send_slow);
 
-void t3_l2t_send_event(struct t3cdev *dev, struct l2t_entry *e)
-{
-again:
-	switch (e->state) {
-	case L2T_STATE_STALE:	/* entry is stale, kick off revalidation */
-		neigh_event_send(e->neigh, NULL);
-		spin_lock_bh(&e->lock);
-		if (e->state == L2T_STATE_STALE) {
-			e->state = L2T_STATE_VALID;
-		}
-		spin_unlock_bh(&e->lock);
-		return;
-	case L2T_STATE_VALID:	/* fast-path, send the packet on */
-		return;
-	case L2T_STATE_RESOLVING:
-		spin_lock_bh(&e->lock);
-		if (e->state != L2T_STATE_RESOLVING) {
-			/* ARP already completed */
-			spin_unlock_bh(&e->lock);
-			goto again;
-		}
-		spin_unlock_bh(&e->lock);
-
-		/*
-		 * Only the first packet added to the arpq should kick off
-		 * resolution.  However, because the alloc_skb below can fail,
-		 * we allow each packet added to the arpq to retry resolution
-		 * as a way of recovering from transient memory exhaustion.
-		 * A better way would be to use a work request to retry L2T
-		 * entries when there's no memory.
-		 */
-		neigh_event_send(e->neigh, NULL);
-	}
-}
-
-EXPORT_SYMBOL(t3_l2t_send_event);
-
 /*
  * Allocate a free L2T entry.  Must be called with l2t_data.lock held.
  */
diff --git a/drivers/net/ethernet/chelsio/cxgb3/l2t.h b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
index 646ca0bc25bd..33558f177497 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/l2t.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
@@ -113,7 +113,6 @@ struct l2t_entry *t3_l2t_get(struct t3cdev *cdev, struct dst_entry *dst,
 			     struct net_device *dev, const void *daddr);
 int t3_l2t_send_slow(struct t3cdev *dev, struct sk_buff *skb,
 		     struct l2t_entry *e);
-void t3_l2t_send_event(struct t3cdev *dev, struct l2t_entry *e);
 struct l2t_data *t3_init_l2t(unsigned int l2t_capacity);
 
 int cxgb3_ofld_send(struct t3cdev *dev, struct sk_buff *skb);
-- 
2.49.0



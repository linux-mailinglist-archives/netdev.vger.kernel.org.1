Return-Path: <netdev+bounces-134986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC499BBB7
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5783A1C20DF0
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5AA14F9D6;
	Sun, 13 Oct 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RcLot5Up"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041D9460;
	Sun, 13 Oct 2024 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851927; cv=none; b=R/RR1lRG9BBzzvFAacqs1hIPR88saunw/l+RdfZ5SVGagO79Ver5YRIMv4J2x3H9IEjmoRwr8gpF5VR+7r8/MUnPU5yGGT1WY+LMRZoGfwIFQ6sf2GFlLGxPe5Pf78pyzbWX9+jlKHkfSgM1S/sJ9D9VVJV4n32FC34pLKKtXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851927; c=relaxed/simple;
	bh=/KWfG0hC7nX68cpRN5YtNXS0NTAEIxSykdwSKnDzgoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZuK3fCM3RMY5A4dSot34nmGu6WmhUWALPUMWKU49uPz0lQnleKY/bDBZNSy1cOD8RPGkpCz0mI+tNN9ixwjMZIQPhBHtweSBlWgIc0SFUN6nX0+dsmzwR7dwFF70Rlq0r7AF8bfJvR2GpnMxB2zQzIAHL4/4btzA8YXv8TnlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RcLot5Up; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=w+h03ZN2MorMRtu2NK0FxCln95Xj/ArcNug/uX/vzdk=; b=RcLot5Up/iMnhZg6
	r/iLELPcFrFe0hQ0tv6Lxuo8nTlXOxMtKow6l3bwjzZqKGfbZmLhQp9zJaObjDZ548P6hAMN6rcDA
	TVl9LkCRkXa4M7nB/1OjRzpwdRe3sPEAnCtMVyxYP2LE9u6hypDB3dBe+M8fqreVJG9nK2PGtIAqS
	D1FnePxup310C6MSRfLs4L8sR89L42+DISvaduFKwy07k6gntSo18m/KH7rw3BGEtHJfrLPfJOtf2
	QntOWQspjbjEm8gqeXzpS4Nr7szSzAm4JPXyKrWno2oJV2EiwcFZqDPondkoE4GyRUWxt8sjbQcG2
	CpqjncaDL5YbclUV3g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t05MM-00AnUX-0x;
	Sun, 13 Oct 2024 20:38:38 +0000
From: linux@treblig.org
To: bharat@chelsio.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 2/6] cxgb4: Remove unused cxgb4_alloc/free_raw_mac_filt
Date: Sun, 13 Oct 2024 21:38:27 +0100
Message-ID: <20241013203831.88051-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241013203831.88051-1-linux@treblig.org>
References: <20241013203831.88051-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cxgb4_alloc_raw_mac_filt() and cxgb4_free_raw_mac_filt() have been
unused since they were added in 2019 commit
5fab51581f62 ("cxgb4: Add MPS TCAM refcounting for raw mac filters")

Remove them.

This was also the last use of cxgb4_mps_ref_dec().
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    | 16 -----
 .../net/ethernet/chelsio/cxgb4/cxgb4_mps.c    | 68 -------------------
 2 files changed, 84 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 1efb0a73ce0e..1c302dfd6503 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -2141,22 +2141,6 @@ int cxgb4_free_mac_filt(struct adapter *adap, unsigned int viid,
 			unsigned int naddr, const u8 **addr, bool sleep_ok);
 int cxgb4_init_mps_ref_entries(struct adapter *adap);
 void cxgb4_free_mps_ref_entries(struct adapter *adap);
-int cxgb4_free_raw_mac_filt(struct adapter *adap,
-			    unsigned int viid,
-			    const u8 *addr,
-			    const u8 *mask,
-			    unsigned int idx,
-			    u8 lookup_type,
-			    u8 port_id,
-			    bool sleep_ok);
-int cxgb4_alloc_raw_mac_filt(struct adapter *adap,
-			     unsigned int viid,
-			     const u8 *addr,
-			     const u8 *mask,
-			     unsigned int idx,
-			     u8 lookup_type,
-			     u8 port_id,
-			     bool sleep_ok);
 int cxgb4_update_mac_filt(struct port_info *pi, unsigned int viid,
 			  int *tcam_idx, const u8 *addr,
 			  bool persistent, u8 *smt_idx);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c
index 0e5663d19fcf..60f4d5b5eb3a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c
@@ -28,28 +28,6 @@ static int cxgb4_mps_ref_dec_by_mac(struct adapter *adap,
 	return ret;
 }
 
-static int cxgb4_mps_ref_dec(struct adapter *adap, u16 idx)
-{
-	struct mps_entries_ref *mps_entry, *tmp;
-	int ret = -EINVAL;
-
-	spin_lock(&adap->mps_ref_lock);
-	list_for_each_entry_safe(mps_entry, tmp, &adap->mps_ref, list) {
-		if (mps_entry->idx == idx) {
-			if (!refcount_dec_and_test(&mps_entry->refcnt)) {
-				spin_unlock(&adap->mps_ref_lock);
-				return -EBUSY;
-			}
-			list_del(&mps_entry->list);
-			kfree(mps_entry);
-			ret = 0;
-			break;
-		}
-	}
-	spin_unlock(&adap->mps_ref_lock);
-	return ret;
-}
-
 static int cxgb4_mps_ref_inc(struct adapter *adap, const u8 *mac_addr,
 			     u16 idx, const u8 *mask)
 {
@@ -141,52 +119,6 @@ int cxgb4_update_mac_filt(struct port_info *pi, unsigned int viid,
 	return ret;
 }
 
-int cxgb4_free_raw_mac_filt(struct adapter *adap,
-			    unsigned int viid,
-			    const u8 *addr,
-			    const u8 *mask,
-			    unsigned int idx,
-			    u8 lookup_type,
-			    u8 port_id,
-			    bool sleep_ok)
-{
-	int ret = 0;
-
-	if (!cxgb4_mps_ref_dec(adap, idx))
-		ret = t4_free_raw_mac_filt(adap, viid, addr,
-					   mask, idx, lookup_type,
-					   port_id, sleep_ok);
-
-	return ret;
-}
-
-int cxgb4_alloc_raw_mac_filt(struct adapter *adap,
-			     unsigned int viid,
-			     const u8 *addr,
-			     const u8 *mask,
-			     unsigned int idx,
-			     u8 lookup_type,
-			     u8 port_id,
-			     bool sleep_ok)
-{
-	int ret;
-
-	ret = t4_alloc_raw_mac_filt(adap, viid, addr,
-				    mask, idx, lookup_type,
-				    port_id, sleep_ok);
-	if (ret < 0)
-		return ret;
-
-	if (cxgb4_mps_ref_inc(adap, addr, ret, mask)) {
-		ret = -ENOMEM;
-		t4_free_raw_mac_filt(adap, viid, addr,
-				     mask, idx, lookup_type,
-				     port_id, sleep_ok);
-	}
-
-	return ret;
-}
-
 int cxgb4_init_mps_ref_entries(struct adapter *adap)
 {
 	spin_lock_init(&adap->mps_ref_lock);
-- 
2.47.0



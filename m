Return-Path: <netdev+bounces-134991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3117C99BBC2
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83351F2149C
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA62814E2C0;
	Sun, 13 Oct 2024 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="fBg0dGvr"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CDD15CD64;
	Sun, 13 Oct 2024 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851934; cv=none; b=lXKN7EJ/W1KAddDphCCJzdUW/mgvztY3u6IPmMk9DMfLosXOTozonGh6LOj5t1Ha7b1vvqEOcQkDggp+bYfCh5jjCRRxjLPCclfDXwXTykUuCEs60izCDOrnq3JBwa1ZnXWraFAjAMh2qjX7B+j/mgYdSFI8kW/Ov0zxVI33+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851934; c=relaxed/simple;
	bh=MBwMZ4xiO0sumWJtTHTe6GkRXUXySlWfbs3PmjCuG78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3Y92DNpf0QmuORRvmhH2NpG60/bM2vdTsV3HyQTHhKePSWT9G1WW22ISalHR6EiWbvBL6upsIGNZVNnwVQYv5MTrtzfNPeDm2LFOx+Jp+8fJ5cJ7G2vqyP1xwNRPf8Uxt8MtYBnvrqdszoiH2ix2HX47XbZBNXWsTqXfgfkRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=fBg0dGvr; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=IczDtGTS4Z5CULUm4z191Tp3qUncfTs57+PPNdjNah8=; b=fBg0dGvrShDBM1NT
	7mxAz6mbR8FJbIf+ZQ0TZaSLO2xWtoPtmfxWoak+VsKHfYF1dYdKYmrDUu6gwu+y58QoD8fNXRSY+
	oBWT+p4ABTY9NQ5cEw6arClzaclIVIY1VzwnpAVukNGeTn6cZkGd+7I0qjrf4o8Z2OD2ac1FSzdd5
	JP/KlmjkrwAI7JN3aAx5CA6Tq2e4pyxX0aY1b8Tp33s2CegmaFSufG3Jg0R4yl5zlCmGXto3VuZ1Z
	aeVf7HZVBIThOL8cKuWvYyCyBu2ZMNzAqiut+0H7BuT/7XsxOQqo4rb4JUYGd1AjL7qUIvkCXlzSr
	QFng5HnOMj4VnwTnaw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t05ML-00AnUX-1m;
	Sun, 13 Oct 2024 20:38:37 +0000
From: linux@treblig.org
To: bharat@chelsio.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 1/6] cxgb4: Remove unused cxgb4_alloc/free_encap_mac_filt
Date: Sun, 13 Oct 2024 21:38:26 +0100
Message-ID: <20241013203831.88051-2-linux@treblig.org>
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

cxgb4_alloc_encap_mac_filt() and cxgb4_free_encap_mac_filt() have been
unused since
commit 28b3870578ef ("cxgb4: Re-work the logic for mps refcounting")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  6 ----
 .../net/ethernet/chelsio/cxgb4/cxgb4_mps.c    | 30 -------------------
 2 files changed, 36 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index bbf7641a0fc7..1efb0a73ce0e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -2141,12 +2141,6 @@ int cxgb4_free_mac_filt(struct adapter *adap, unsigned int viid,
 			unsigned int naddr, const u8 **addr, bool sleep_ok);
 int cxgb4_init_mps_ref_entries(struct adapter *adap);
 void cxgb4_free_mps_ref_entries(struct adapter *adap);
-int cxgb4_alloc_encap_mac_filt(struct adapter *adap, unsigned int viid,
-			       const u8 *addr, const u8 *mask,
-			       unsigned int vni, unsigned int vni_mask,
-			       u8 dip_hit, u8 lookup_type, bool sleep_ok);
-int cxgb4_free_encap_mac_filt(struct adapter *adap, unsigned int viid,
-			      int idx, bool sleep_ok);
 int cxgb4_free_raw_mac_filt(struct adapter *adap,
 			    unsigned int viid,
 			    const u8 *addr,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c
index a020e8490681..0e5663d19fcf 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c
@@ -187,36 +187,6 @@ int cxgb4_alloc_raw_mac_filt(struct adapter *adap,
 	return ret;
 }
 
-int cxgb4_free_encap_mac_filt(struct adapter *adap, unsigned int viid,
-			      int idx, bool sleep_ok)
-{
-	int ret = 0;
-
-	if (!cxgb4_mps_ref_dec(adap, idx))
-		ret = t4_free_encap_mac_filt(adap, viid, idx, sleep_ok);
-
-	return ret;
-}
-
-int cxgb4_alloc_encap_mac_filt(struct adapter *adap, unsigned int viid,
-			       const u8 *addr, const u8 *mask,
-			       unsigned int vni, unsigned int vni_mask,
-			       u8 dip_hit, u8 lookup_type, bool sleep_ok)
-{
-	int ret;
-
-	ret = t4_alloc_encap_mac_filt(adap, viid, addr, mask, vni, vni_mask,
-				      dip_hit, lookup_type, sleep_ok);
-	if (ret < 0)
-		return ret;
-
-	if (cxgb4_mps_ref_inc(adap, addr, ret, mask)) {
-		ret = -ENOMEM;
-		t4_free_encap_mac_filt(adap, viid, ret, sleep_ok);
-	}
-	return ret;
-}
-
 int cxgb4_init_mps_ref_entries(struct adapter *adap)
 {
 	spin_lock_init(&adap->mps_ref_lock);
-- 
2.47.0



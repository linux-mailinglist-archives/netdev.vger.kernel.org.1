Return-Path: <netdev+bounces-134988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B4199BBBB
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729A41C20EAE
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445731547C5;
	Sun, 13 Oct 2024 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VeuLUwR7"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69E14A639;
	Sun, 13 Oct 2024 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851928; cv=none; b=Kq1wrFp3zF7yMx0qQ8Y/ZUH6MfviqjNLo4lPqwfhMM1NI4EOFGjW/3DGcD5fpDJC6Bd6BUCYpn+uapJAu874JTUrGKNbVI2n12sOIHEbRhulT4LwYGi1G0NhkOgErEiqFD0SU/8bKFUbp/riEo4u4pHg8Hc1nnB8NpJ0/3HqVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851928; c=relaxed/simple;
	bh=Kz7biNrSLf2Tfv9++g6KvtSgrfeiTXUxSW0BPUXiJvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpSJOEgMXdoM8+LB0to28Qq2RljXinJUhlT/Bv4TMbi8vcyylYXHtFnSPTLQaKeldM55CFQr2IQN0daG32LupoEoDzOroRYBG8DuR5iSuOSqGNfpHalDc4fac7yUMUKHiKoAnHSWb1XVW6EtJINQBJKAst4RGrRQVWLmdst857U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VeuLUwR7; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=qjDH0t9U3Or+NZWFu+ofizReGJXC+/gny6H8OGMVhTw=; b=VeuLUwR7v9RerKGg
	csCuIXP1bIRILhC+IpOCwywsNz+1AAqCilXoLT1j+z7jMLGX45DAqGwRJjtQaV1Td6obME6cJBTGU
	1XZocwIAmM86c8AVvzQlqQhOpIAori1MlgLhYqMM9yfkoROlxyV2fqSmGmagESm7Dq68YHz8avq90
	s+Vr9z8J+PWULJftuLju8unhbRqmoIOpuqeT/gtf0i4vvDlbNrx5U85xQSkcfj0eqfXQXZh3HaRBe
	PG6EIW0E7jJXl06aVdKf3T+2YbkPu0XA3dx6wZ+f3AiD4KXKyQubppHhXFu8Y/ktGT+NQjZI2782O
	KeOTrN7m+fcx/FLJ0w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t05MN-00AnUX-05;
	Sun, 13 Oct 2024 20:38:39 +0000
From: linux@treblig.org
To: bharat@chelsio.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 3/6] cxgb4: Remove unused cxgb4_get_srq_entry
Date: Sun, 13 Oct 2024 21:38:28 +0100
Message-ID: <20241013203831.88051-4-linux@treblig.org>
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

cxgb4_get_srq_entry() has been unused since 2018's commit
e47094751ddc ("cxgb4: Add support to initialise/read SRQ entries")
which added it.

Remove it.

Note: I'm a bit suspicious whether any of the srq code in there
actually does anything useful;  without this get I can't see anything
that reads the data, so perhaps the whole thing should go?
But that however would remove one of the opcode handlers, and I have
no way to test that.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/chelsio/cxgb4/srq.c | 58 ------------------------
 drivers/net/ethernet/chelsio/cxgb4/srq.h |  2 -
 2 files changed, 60 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/srq.c b/drivers/net/ethernet/chelsio/cxgb4/srq.c
index 9a54302bb046..a77d6ac1ee8c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/srq.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/srq.c
@@ -51,64 +51,6 @@ struct srq_data *t4_init_srq(int srq_size)
 	return s;
 }
 
-/* cxgb4_get_srq_entry: read the SRQ table entry
- * @dev: Pointer to the net_device
- * @idx: Index to the srq
- * @entryp: pointer to the srq entry
- *
- * Sends CPL_SRQ_TABLE_REQ message for the given index.
- * Contents will be returned in CPL_SRQ_TABLE_RPL message.
- *
- * Returns zero if the read is successful, else a error
- * number will be returned. Caller should not use the srq
- * entry if the return value is non-zero.
- *
- *
- */
-int cxgb4_get_srq_entry(struct net_device *dev,
-			int srq_idx, struct srq_entry *entryp)
-{
-	struct cpl_srq_table_req *req;
-	struct adapter *adap;
-	struct sk_buff *skb;
-	struct srq_data *s;
-	int rc = -ENODEV;
-
-	adap = netdev2adap(dev);
-	s = adap->srq;
-
-	if (!(adap->flags & CXGB4_FULL_INIT_DONE) || !s)
-		goto out;
-
-	skb = alloc_skb(sizeof(*req), GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
-	req = (struct cpl_srq_table_req *)
-		__skb_put_zero(skb, sizeof(*req));
-	INIT_TP_WR(req, 0);
-	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SRQ_TABLE_REQ,
-					      TID_TID_V(srq_idx) |
-				TID_QID_V(adap->sge.fw_evtq.abs_id)));
-	req->idx = srq_idx;
-
-	mutex_lock(&s->lock);
-
-	s->entryp = entryp;
-	t4_mgmt_tx(adap, skb);
-
-	rc = wait_for_completion_timeout(&s->comp, SRQ_WAIT_TO);
-	if (rc)
-		rc = 0;
-	else /* !rc means we timed out */
-		rc = -ETIMEDOUT;
-
-	WARN_ON_ONCE(entryp->idx != srq_idx);
-	mutex_unlock(&s->lock);
-out:
-	return rc;
-}
-EXPORT_SYMBOL(cxgb4_get_srq_entry);
-
 void do_srq_table_rpl(struct adapter *adap,
 		      const struct cpl_srq_table_rpl *rpl)
 {
diff --git a/drivers/net/ethernet/chelsio/cxgb4/srq.h b/drivers/net/ethernet/chelsio/cxgb4/srq.h
index ec85cf93865a..d9f04bd5ffa3 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/srq.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/srq.h
@@ -58,8 +58,6 @@ struct srq_data {
 };
 
 struct srq_data *t4_init_srq(int srq_size);
-int cxgb4_get_srq_entry(struct net_device *dev,
-			int srq_idx, struct srq_entry *entryp);
 void do_srq_table_rpl(struct adapter *adap,
 		      const struct cpl_srq_table_rpl *rpl);
 #endif  /* __CXGB4_SRQ_H */
-- 
2.47.0



Return-Path: <netdev+bounces-285459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPiQAYrc/GnqUgAAu9opvQ
	(envelope-from <netdev+bounces-285459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 20:40:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E054ED8C0
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 20:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A79EF302BE15
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19354611C4;
	Thu,  7 May 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="dCqt+h8M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A731E84F
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179175; cv=none; b=PpAhtTjabPU2RlUZJ6SGCuUPkA0NIUAjWxwIz46Ju+04fquQDRcJ6g8CLYhWpzZepfg7jxV38Lq2MJ24wxEs08YQ1FDQ66YxInvCeACdEWbwsgsmjN4Rp7Sb2BousFrQmQGNAYlpK4nrY4Nvc0AoKJGqQtJaoVkmDekINhYOzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179175; c=relaxed/simple;
	bh=0keX8Rib2M0LVysEgEmwfygEi6g47NPnZe2hGTRoE6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9yr8XIrzr8zu5EZa3uYwsPRi9utxHCE7ail3UL8RDBUvUBqz7H/UhSqnrhTaHXOOPPkHa5E2HvZfvXspZB8rMCVcv07XPI55VpXVtl11g5XUZoAiTpyRKjxnM8dMIi9DjJH1APQqXt1HT8GVNcGa/SVNc+XjDbJYY6fobbuXY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=dCqt+h8M; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P55pzkwiy0A9H3D7tbqLFDnUSO+K24Ompedf4SSCp/o=; t=1778179174; x=1779043174; 
	b=dCqt+h8MvDGeLizvFfNjiLPUtFuMRHt01ww943OYjnPRRGg4Qm62NK+/AYq4FEG2yfAZ6xJAlXk
	hjlSBlVf10RpywTFG9DYpQFJPR5VLOT/2J1hz36XM0NgskN9+aJTU2NGaD/d+cMkTqumpJH0sC0M1
	w90VeOzIPH7swRmhdzmO/8G9aQ0wQxFPcUhf1a6fXO3iAEdJsEI+RVDZjqpLCuK4pQljm6+QKCOeZ
	ETNttpj6utyAzrgGsw7Pde8f1nrkuSASYpuyXBB4EJqyw6yHOpeVCQXk8+0c02em1PF5FLrDrmi+o
	9WfSc/EM8CTLesxHYWRnlHkm8aj4HSGnS/jg==;
Received: from [70.228.78.207] (port=50044 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wL3dF-0005rO-4r; Thu, 07 May 2026 11:39:33 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: anthony.l.nguyen@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com,
	netdev@vger.kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net v2] ice: fix packet corruption due to extraneous page flip
Date: Thu,  7 May 2026 11:38:43 -0700
Message-ID: <20260507183843.1457-1-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.1
X-Scan-Signature: 143d975f4418483bad6282b216f6b212
X-Rspamd-Queue-Id: 57E054ED8C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285459-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cs.stanford.edu:mid,stanford.edu:email]
X-Rspamd-Action: no action

Consider the following sequence of events:
* The bottom half of a buffer page is filled with data from
  packet A. The page has a net reference count (reference count
  - bias) of 1. The page is returned to the NIC, flipped to
  use the top half.
* Before the reference on the page is released, the NIC returns
  the page with no data in it ('size' is zero in ice_clean_rx_irq).
  In this case the bias does not get decremented. The page still
  has a net reference count of 1, so it gets returned to the NIC.
  However, ice_put_rx_mbuf flipped the page so that the bottom
  half is active.
* If the NIC stores another packet in the page before packet A
  has released its reference, the data in packet A will be
  overwritten with data from the new packet.
The fix is for ice_put_rx_mbuf not to flip pages that have a
size of 0.

Note: major revisions to the ice driver make this patch irrelevant
for recent versions. It applies to longterm stable versions
6.18.27 and 6.12.86; it also seems relevant for 6.6.137, but would
need modifications for that version. I have not examined earlier
versions

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 51c459a3e722..081c7a7392b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1215,6 +1215,13 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		xdp_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
 
 	while (idx != ntc) {
+		union ice_32b_rx_flex_desc *rx_desc;
+		unsigned int size;
+
+		rx_desc = ICE_RX_DESC(rx_ring, idx);
+		size = le16_to_cpu(rx_desc->wb.pkt_len) &
+		       ICE_RX_FLX_DESC_PKT_LEN_M;
+
 		buf = &rx_ring->rx_buf[idx];
 		if (++idx == cnt)
 			idx = 0;
@@ -1224,10 +1231,20 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		 * To do this, only adjust pagecnt_bias for fragments up to
 		 * the total remaining after the XDP program has run.
 		 */
-		if (verdict != ICE_XDP_CONSUMED)
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-		else if (i++ <= xdp_frags)
+		if (verdict != ICE_XDP_CONSUMED) {
+			/* Don't "flip" the page if size is 0: in this case
+			 * the data in the current half will not be used so
+			 * it's OK to reuse that half. And, since the bias
+			 * didn't get decremented for this half, the page can
+			 * be returned to the NIC even if the other half is
+			 * still in use, so flipping the page could cause
+			 * live packet data to be overwritten.
+			 */
+			if (size != 0)
+				ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
+		} else if (i++ <= xdp_frags) {
 			buf->pagecnt_bias++;
+		}
 
 		ice_put_rx_buf(rx_ring, buf);
 	}
-- 
2.43.0



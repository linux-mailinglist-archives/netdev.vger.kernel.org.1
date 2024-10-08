Return-Path: <netdev+bounces-133199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3CB995493
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D051C23016
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28AC1E0DE4;
	Tue,  8 Oct 2024 16:37:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx2.qrator.net (mx2.qrator.net [178.248.233.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951781EA73;
	Tue,  8 Oct 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.248.233.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405453; cv=none; b=hYzF/tlTRPvjuhlMr9yW42iE+1Jd1Sb7AOBT4xtKeFmsIYH3LMNxEyT9V6NOn25vt/OLAxA1eG7WTLkbJwwIishx2BahgbCkqE3qkBYpPSaycCOIqO3UOwnv8jJGX7P5TsLpPCdesQUSKyWu9Q0zqRfD2GYWfDHhUxAbwWc3VLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405453; c=relaxed/simple;
	bh=ZM8tgqo57AOggPQwWEmlAFE7qFEUdZe0KUF0xOef7uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVGF5YfV/Lclg1sMhqjtOl0eA7sngfbKwfTPFkrkbuOfAhq0eQfFQmnbp/oVrUn8DvaiKiGgyZTkuF2Gmxurq3xb/SZQ3rbciIjFryDm6nuUTOg8K09oDhC16KGP5MFNEOMi+u4ONRRD5cDHV2CvYu1CMAngBqbONHpHLPWF9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; arc=none smtp.client-ip=178.248.233.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Received: from localhost.localdomain (unknown [10.127.0.1])
	by mx2.qrator.net (Postfix) with ESMTP id 8090724A0853;
	Tue,  8 Oct 2024 19:28:59 +0300 (MSK)
From: Alexander Zubkov <green@qrator.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	green@qrator.net,
	horms@kernel.org,
	linux@treblig.org
Subject: [PATCH net-next] Fix misspelling of "accept*" in net
Date: Tue,  8 Oct 2024 18:27:57 +0200
Message-ID: <20241008162756.22618-2-green@qrator.net>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several files have "accept*" misspelled as "accpet*" in the comments.
Fix all such occurrences.

Signed-off-by: Alexander Zubkov <green@qrator.net>
---
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c | 4 ++--
 drivers/net/ethernet/natsemi/ns83820.c                        | 2 +-
 include/uapi/linux/udp.h                                      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
index 455a54708be4..96fd31d75dfd 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
@@ -342,8 +342,8 @@ static struct sk_buff *copy_gl_to_skb_pkt(const struct pkt_gl *gl,
 {
 	struct sk_buff *skb;
 
-	/* Allocate space for cpl_pass_accpet_req which will be synthesized by
-	 * driver. Once driver synthesizes cpl_pass_accpet_req the skb will go
+	/* Allocate space for cpl_pass_accept_req which will be synthesized by
+	 * driver. Once driver synthesizes cpl_pass_accept_req the skb will go
 	 * through the regular cpl_pass_accept_req processing in TOM.
 	 */
 	skb = alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req)
diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index 998586872599..bea969dfa536 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -2090,7 +2090,7 @@ static int ns83820_init_one(struct pci_dev *pci_dev,
 	 */
 	/* Ramit : 1024 DMA is not a good idea, it ends up banging
 	 * some DELL and COMPAQ SMP systems
-	 * Turn on ALP, only we are accpeting Jumbo Packets */
+	 * Turn on ALP, only we are accepting Jumbo Packets */
 	writel(RXCFG_AEP | RXCFG_ARP | RXCFG_AIRL | RXCFG_RX_FD
 		| RXCFG_STRIPCRC
 		//| RXCFG_ALP
diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 1a0fe8b151fb..d85d671deed3 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -31,7 +31,7 @@ struct udphdr {
 #define UDP_CORK	1	/* Never send partially complete segments */
 #define UDP_ENCAP	100	/* Set the socket to accept encapsulated packets */
 #define UDP_NO_CHECK6_TX 101	/* Disable sending checksum for UDP6X */
-#define UDP_NO_CHECK6_RX 102	/* Disable accpeting checksum for UDP6 */
+#define UDP_NO_CHECK6_RX 102	/* Disable accepting checksum for UDP6 */
 #define UDP_SEGMENT	103	/* Set GSO segmentation size */
 #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
 
-- 
2.46.0



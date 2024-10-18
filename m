Return-Path: <netdev+bounces-136827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54029A32CF
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87C61C24766
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D805C15532E;
	Fri, 18 Oct 2024 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YF1aWB9S"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774F1552E3;
	Fri, 18 Oct 2024 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218208; cv=none; b=MCp4sH3EaUKmtmTFkJL8AsaxBLSFSYlBGGCPPuema8STrUqpff3NRCkhs9oySTwdnJ/y8g+4Xium8kbNn/CzCL4scpxCnEjVjyFBtirlnyC9OWqYrw0O8pL5R91scdISQgPrB6lxqnQb6A+bFRzXyb2jvW+xxl1K0PwGeFGcDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218208; c=relaxed/simple;
	bh=O4uT707Tv/lIfQv6cblxhA6wLHdiMJE58k2jil6dDIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRh/xkR+qdx+GvXlem2qaWTe/rrMcQz2HRaQa8cFx59ZPzhwucu9ygf4lhDqQbJ6LO+qjIe9ITqi5PU32HmNAzrW5fmgf3fYw1ixfpBNBc8N+tckEuXhCGN8eZMTgU3DCCbP+uTH2ua2axYOX9QpYAAANqBIZm2D5qDWXQgaSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YF1aWB9S; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729217974;
	bh=Ki0z6CTdVTpppMdLs2s6QNtb9P/mdMmiW9dRytEzdzM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=YF1aWB9SNHjxY9ILwki4UVo60mCmQDZnvJ7BXARAX8pOJtrDUnllbmJxWjB2Ov+WP
	 vdXy54qGGt7kvSnbMR8CfceWpGbeBAb1rC0d4EfoGmaIe+R1WwN0oRB8E7VFhNO+4b
	 U4L4sQapyJY/1L1GVwV+ke/tKypEQV5kMieEqR00=
X-QQ-mid: bizesmtpsz3t1729217955tkprubm
X-QQ-Originating-IP: 428xufKTZI5Xo6kHFcuyAGYJM5mAD4lY95RzwD1mDpc=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Oct 2024 10:19:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3988907893277172996
From: WangYuli <wangyuli@uniontech.com>
To: michael.chan@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	mchan@broadcom.com,
	jdmason@kudzu.us,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcarlson@broadcom.com,
	benli@broadcom.com,
	sbaddipa@broadcom.com,
	linas@austin.ibm.com,
	Ramkrishna.Vepa@neterion.com,
	raghavendra.koushik@neterion.com,
	wenxiong@us.ibm.com,
	jeff@garzik.org,
	vasundhara-v.volam@broadcom.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] eth: Fix typo 'accelaration'. 'exprienced' and 'rewritting'
Date: Fri, 18 Oct 2024 10:19:10 +0800
Message-ID: <90D42CB167CA0842+20241018021910.31359-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M4+GqYRlc6iCCZMTMoiAff7mKh2ed6eK76kNLXe/7ZObDRtwylQAsDgI
	ye3sef2HhqTdOPG0BFF7a96y8ZdDxKDn3QQQOJ3ZeyPVGjGj/mWk5ad1rpB0JyGvtTFuVpg
	KVMJzO5OWMqyGL9KUNSFETk0I8ojEZNeiwFOdT1BU9ZuoWxm8Fu0r12M8ds/qJaandk+wR4
	tkjEzIxPMlGya+p17j5vgHLyYHHTX2VjacDY0swklsrdLmUh+20Fo8pr3fT3E/Eh9ePSSj6
	cuZ51NrFDBsnTZCb7hMWcTFPnDf9l00W1lLUnD+HR9Qbnt8FCziroWHK6RBq7lc6HNd+H6c
	VqPBoD1pu2YJPKEB3+hcLh+HTM+6krrqNmBYRdQK/NL1PDuA/5om6TC5kr879YXM5x/3LR0
	3Ia/qQH7res4VECnpXg+EpWo5YpoU5HocEubgKn0JhUgJwg4fpjSieEnb77vlIFSAR/Hv+n
	6smW66ieBrzIzdJIrAaN9zITgz5g1GMv5ugxPtnMEJRM0Za5huif1zzChcvCeL6EoKm+Fy3
	ekZ1t9J1DGjPB4PhAB5yNYsaBVR4jMOZYcTuArPnjAHGq3rByse3tOfxJIPRz+HB8BB+8C8
	1RB3+Pg1rrdE/YhqkqoGal0EGoSr4MmnH8Hazo1YL9G+f/tcqnSj952wzdmUOdpLaLcC0jG
	7DmvNV3o1F3rsVJp1TNQVFJdThfHBOdWDAFmS6CIyMxYx+b4eHObnGd9dh00t5He+Z9GUr7
	QIk1KHTkZxmgRwaywVMZbJfsIbUOJiVyZAnySNrEoy9w738VuowihvuXMUJOOQLZpEpiBGp
	musGcitUg97AXrTFPNMyOV03q1l6IS3VsGDzpLcZ4Ki7iOXGAdMeS8a5FQxaLmBN6m9LIuA
	TpzBXAOTBbS0dkiVpH41mYp/jZvyrYcavUx2nA0YFVVTB8kFZINlzaA1e9EpIHZ8ie4w/i/
	LG1IVGFMtpPkDslKV3GEjhMP8JKobOQmE+3cYKdUIRGNDoQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

There are some spelling mistakes of 'accelaration', 'exprienced' and
'rewritting' in comments which should be 'acceleration', 'experienced'
and 'rewriting'.

Suggested-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20241017162846.GA51712@kernel.org/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++---
 drivers/net/ethernet/broadcom/tg3.c       | 2 +-
 drivers/net/ethernet/neterion/s2io.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f5da2dace982..bda3742d4e32 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12881,7 +12881,7 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	if (features & NETIF_F_GRO_HW)
 		features &= ~NETIF_F_LRO;
 
-	/* Both CTAG and STAG VLAN accelaration on the RX side have to be
+	/* Both CTAG and STAG VLAN acceleration on the RX side have to be
 	 * turned on or off together.
 	 */
 	vlan_features = features & BNXT_HW_FEATURE_VLAN_ALL_RX;
@@ -16131,7 +16131,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
  * @pdev: Pointer to PCI device
  *
  * Restart the card from scratch, as if from a cold-boot.
- * At this point, the card has exprienced a hard reset,
+ * At this point, the card has experienced a hard reset,
  * followed by fixups by BIOS, and has its config space
  * set up identically to what it was at cold boot.
  */
@@ -16159,7 +16159,7 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 		pci_set_master(pdev);
 		/* Upon fatal error, our device internal logic that latches to
 		 * BAR value is getting reset and will restore only upon
-		 * rewritting the BARs.
+		 * rewriting the BARs.
 		 *
 		 * As pci_restore_state() does not re-write the BARs if the
 		 * value is same as saved value earlier, driver needs to
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index d5916bbc1b3a..08d2ba3c758e 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18276,7 +18276,7 @@ static pci_ers_result_t tg3_io_error_detected(struct pci_dev *pdev,
  * @pdev: Pointer to PCI device
  *
  * Restart the card from scratch, as if from a cold-boot.
- * At this point, the card has exprienced a hard reset,
+ * At this point, the card has experienced a hard reset,
  * followed by fixups by BIOS, and has its config space
  * set up identically to what it was at cold boot.
  */
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index f235e76e4ce9..f8016dc25e0a 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -8523,7 +8523,7 @@ static pci_ers_result_t s2io_io_error_detected(struct pci_dev *pdev,
  * @pdev: Pointer to PCI device
  *
  * Restart the card from scratch, as if from a cold-boot.
- * At this point, the card has exprienced a hard reset,
+ * At this point, the card has experienced a hard reset,
  * followed by fixups by BIOS, and has its config space
  * set up identically to what it was at cold boot.
  */
-- 
2.45.2



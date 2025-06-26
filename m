Return-Path: <netdev+bounces-201495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82830AE98F1
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAC41645D3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52036298982;
	Thu, 26 Jun 2025 08:49:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25262293C69
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927765; cv=none; b=GixdCW3RvSA4buLTgCthvbLp4ot8tFxR81bWI5AqPFe7xfUGwmMMjZU6vHFAchusk47dsgPZZA7NX3uyhvX6kO6aiRW90YYtB4TNIzkj36nLKNfhMvw9JaWryTJUMuoV7kQoFqUzTtmPSbKtHUPe2SLw2l6l0yoZnrg7C1bF+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927765; c=relaxed/simple;
	bh=+wTL4f/08G7GYd3wN3GgvWAuEeuwdpqG53Kh2KNvawM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ShZlhxywsBrjqouQSd/LAxmInFwRsbvrACJ7wFscWkG+wu3AoPwRNSxTT8NZeb0wXN7SFUlljbPg7zB/Zn2Bso0x+y/0jxiXmtdyTar5YpOoAgMsCCG1cPGqAON0524YdTDNcp6oO2AmOTTlKKpnEKkXcPXI0HlZaDfGNoTlIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1750927708tca3f8b95
X-QQ-Originating-IP: teajctoCwIUTwbLzJD0H3Mbus1YOZ4WzvbCM9RAfJTg=
Received: from lap-jiawenwu.trustnetic.com ( [36.27.0.255])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 16:48:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12974716066767308989
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 3/3] net: ngbe: specify IRQ vector when the number of VFs is 7
Date: Thu, 26 Jun 2025 16:48:04 +0800
Message-Id: <20250626084804.21044-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250626084804.21044-1-jiawenwu@trustnetic.com>
References: <20250626084804.21044-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MWUTOgANNX2v1n9zFeusHkuoCf+Ij3myb80fvOuHBtzCJoeW8Sp+DHqF
	sq3HBNFKc4lxigJoIJSKpTh6TOTXF2ywGW4nM7W2E6YJK/+X5n5PiutCnKW7Y8lwPdFAcOu
	9pDU7Am5WkbGkDNQVla+PwMLwRKaMpAHsczW60gFXpKc/2UW2wX3qUrnezEiDCsCQHbYMdr
	//2iM7jWLPRUPoFRxad8/4A55fqDHJFqQQmxesntBzSQ/OHWVRb4Ob9g0yzq7ZNgxAog+J2
	Z05+M9UMgE/npRU896aGWZ83Zy2Ak0F7FGiTIYVlXOr9Up0NWEU1f+wo5Jf7/Wly8+nd7Jh
	MF5+nIF5yOVoJfKvwUPvPyqsYvXVy7IUzSioV8fpl4vpgCTMD8JEgnF/qHwvcXXx52qLGDg
	stUveaVRgX5Gv9DGjktP6sY2l96tKm6bbu7pBpzqiYEmGWotM3IdPnjV5g5IAZ9q70xS+cM
	m4ws3wKkOuZ6bjR824rCXElvHlzHyWTY8sn7j4fnM0aMnK5ulus4mGevkKzjrpLeDD2kb62
	+7hZN5zoBt2oTAVRcvkdDqRJp9TQsGSdJrep6ZIkhqxkTjJ4HLZl68Qan9zMAnD6VnwS2r2
	apr654Lc2HncYC0S0HSNSO27FaCDCSLjt2r40LSusGUb8n+0UY0zZvpwjBbqbBExH/vSDnE
	dlf+EUqGeCT4z5CPiUJE4dOZK5ongOdujxXGUDFlgY6ibcedI543IE5eTm9tfpy6DBxaiUa
	gz3hZuklqO5O3o0nc8ATGesN6JYwEpmXL6gj6K+XVFD0gWS9MISL0PXbeaJzxEgaeIBS8mG
	s2oNv2AayNTcR5oHtJIAqQsTQcQmi4vNGGfPYdZHpa63BBji4evUrwnTEBIUW36cUk9Ek+x
	MgIl51Bw1W5DIdbwhZWDJoaL3XhSObGd14BpqRRcLqjqoxpKg4r2+G7NyXQK8GWKughQG6/
	Y8jox/Pncr29nZ0/ofazdadptUcFPvKmqgu0fO/KQxMNw1nzBCNbxPulBqYrZRAHq+G0t0I
	nnYswFPmEZEq8C4vbqbTux6TU2hmPsjE15u9IKREYLOmf1ch/KCmFAO5okgG3sZGIhuMP3y
	A==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

For NGBE devices, the queue number is limited to be 1 when SRIOV is
enabled. In this case, IRQ vector[0] is used for MISC and vector[1] is
used for queue, based on the previous patches. But for the hardware
design, the IRQ vector[1] must be allocated for use by the VF[6] when
the number of VFs is 7. So the IRQ vector[0] should be shared for PF
MISC and QUEUE interrupts.

+-----------+----------------------+
| Vector    | Assigned To          |
+-----------+----------------------+
| Vector 0  | PF MISC and QUEUE    |
| Vector 1  | VF 6                 |
| Vector 2  | VF 5                 |
| Vector 3  | VF 4                 |
| Vector 4  | VF 3                 |
| Vector 5  | VF 2                 |
| Vector 6  | VF 1                 |
| Vector 7  | VF 0                 |
+-----------+----------------------+

Minimize code modifications, only adjust the IRQ vector number for this
case.

Fixes: 877253d2cbf2 ("net: ngbe: add sriov function support")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 9 +++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 4 ++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 2 +-
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 66eaf5446115..7b53169cd216 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1794,6 +1794,13 @@ static int wx_acquire_msix_vectors(struct wx *wx)
 	wx->msix_entry->entry = nvecs;
 	wx->msix_entry->vector = pci_irq_vector(wx->pdev, nvecs);
 
+	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags)) {
+		wx->msix_entry->entry = 0;
+		wx->msix_entry->vector = pci_irq_vector(wx->pdev, 0);
+		wx->msix_q_entries[0].entry = 0;
+		wx->msix_q_entries[0].vector = pci_irq_vector(wx->pdev, 1);
+	}
+
 	return 0;
 }
 
@@ -2292,6 +2299,8 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
 
 	if (direction == -1) {
 		/* other causes */
+		if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
+			msix_vector = 0;
 		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
 		index = 0;
 		ivar = rd32(wx, WX_PX_MISC_IVAR);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index e8656d9d733b..c82ae137756c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -64,6 +64,7 @@ static void wx_sriov_clear_data(struct wx *wx)
 	wr32m(wx, WX_PSR_VM_CTL, WX_PSR_VM_CTL_POOL_MASK, 0);
 	wx->ring_feature[RING_F_VMDQ].offset = 0;
 
+	clear_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags);
 	clear_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
 	/* Disable VMDq flag so device will be set in NM mode */
 	if (wx->ring_feature[RING_F_VMDQ].limit == 1)
@@ -78,6 +79,9 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
 	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
 	dev_info(&wx->pdev->dev, "SR-IOV enabled with %d VFs\n", num_vfs);
 
+	if (num_vfs == 7 && wx->mac.type == wx_mac_em)
+		set_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags);
+
 	/* Enable VMDq flag so device will be set in VM mode */
 	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
 	if (!wx->ring_feature[RING_F_VMDQ].limit)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index d392394791b3..c363379126c0 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1191,6 +1191,7 @@ enum wx_pf_flags {
 	WX_FLAG_VMDQ_ENABLED,
 	WX_FLAG_VLAN_PROMISC,
 	WX_FLAG_SRIOV_ENABLED,
+	WX_FLAG_IRQ_VECTOR_SHARED,
 	WX_FLAG_FDIR_CAPABLE,
 	WX_FLAG_FDIR_HASH,
 	WX_FLAG_FDIR_PERFECT,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 68415a7ef12f..e0fc897b0a58 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -286,7 +286,7 @@ static int ngbe_request_msix_irqs(struct wx *wx)
 	 * for queue. But when num_vfs == 7, vector[1] is assigned to vf6.
 	 * Misc and queue should reuse interrupt vector[0].
 	 */
-	if (wx->num_vfs == 7)
+	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
 		err = request_irq(wx->msix_entry->vector,
 				  ngbe_misc_and_queue, 0, netdev->name, wx);
 	else
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 6eca6de475f7..44ff62af7ae0 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -87,7 +87,7 @@
 #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
 
 #define NGBE_INTR_ALL				0x1FF
-#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
+#define NGBE_INTR_MISC(A)			BIT((A)->msix_entry->vector)
 
 #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
 #define NGBE_CFG_LAN_SPEED			0x14440
-- 
2.48.1




Return-Path: <netdev+bounces-200541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BFCAE600F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA6216CB15
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A82E279DB6;
	Tue, 24 Jun 2025 08:58:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F012798EC
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755480; cv=none; b=YEQ9jRPGw66rvneipdI1slRbGWFdF1wfPfK742ENeV/wa/wZvPGwHGQ2cMMH0MfpecKy2UfZu3jKxJMH72GgQc333lPVOW5WK4xglQiG6FHeEDiShFoxUcM7UAY02X/Ldn8eBxSpSIAIdWhFWuPL/cqO/WP47Zb/bqs5I4FWxs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755480; c=relaxed/simple;
	bh=UzhMS9I9RERkXTYCeGY8+EvihGM+6DC1rmlp4HN3+rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+h8p2fyzaSCPqkpl66aOGTIEud+KOyF7jTEZLzsoo4aePiXv27v1KloYVk0wWUUDLIxR8fB/repE9Xt86+fTXQ3bJDJk/cxkfhs30TNrPuRb3QskiBEfqJF54OoI9KofQg4G6MFF1qfC5LvKoNf544vWEYzUkb8GbxJnH4+BHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1750755416t5017ec5b
X-QQ-Originating-IP: cYCwD7fst4qcRuFkIVXi29T1BDdNsWGMj+048sGRoe8=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Jun 2025 16:56:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13156048008192078316
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 3/3] net: ngbe: specify IRQ vector when the number of VFs is 7
Date: Tue, 24 Jun 2025 16:56:34 +0800
Message-Id: <20250624085634.14372-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250624085634.14372-1-jiawenwu@trustnetic.com>
References: <20250624085634.14372-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NzOYezMElYUYaVJrlnFQ0QCF0mL207iXe6MPv2X8EsHsuMnITYDt0JFP
	JcJIT1+Qd/xLDwLEzku0fgBvDob2kTCJs5M0cxHk8QcgdYDo/CNCM8rpDfoMjPFrPds4ZCG
	Uv+syMF1kmB74twHSHLjfObSOPkJcO1BuDPP7Xst9DIMD9QVofGvfBYzfxbYTUP6wU/GDHy
	qXGI3zkiVvDPQPYcoKfoKJivDSR6KHxX9TOy8yU5FvUzdkhlETeKMAv0c8B2zBd7EihZ5iw
	66WvxlCqlKQ5E8QRbJvmHdnuQkT6zS38GcfH0FuKCTXFrk9FjdjG5yG8yxDDxONKchwpMmX
	RDvUIiR0gzwjU4FIyfvimGGyPTElZ8XiltT4uO2XAZAo2Tw+Xu7ETvjnImtEtSExZnZvpkJ
	rd20AJSOq8yqs7J4kPShvxYuKJs0NV2PoJ5dpdsz8QDWgnq81m4rT/TVWPQHT4CG66x2mfK
	mhq0kCN6FmJ4B3IaJxups6QFfA4m4rAP6/HqbTnhg398MaeLZ0HxHlQkvrsc3s7gy+DECnz
	LXRTG/iOxpUXF+ljWFlxZN7lNk8vGR3qNks/hmb0OB+F0DgOyB3nxyuD/B4MEPdOzP9QPGY
	yXJML9SubMcbsftn04ZD7aLLSeu8OH9ddq4mfGOKSTodiUPLnhwrPsiUlVP5y1kQ6RiPKid
	VGLjNFO1ou+t1a3hm132Nc7PJDF8DZmRoLFA+CDefHMTxHjysKFzl5ntTcAsWq0lD86bJK1
	qOOSmBTaNCLZLM6E6G19ImB+/VPItMl1jP7E0/PgT3MYyyoXROLGM48/8FWs/81TGHBppU7
	sMR/eaXklU8nNWO+tGe0VsrkOdZX3+73kxR1SrXJDWvPRvQWWjb+LiZTHnViXCOCbiuTG+N
	plYq9dTd69GG6gU3Z4yE1Z5duyhouJCOpKix88rk0sLBAvffAm7Sw0ZSauNZ++5SqQ38+e+
	gAFwSSqZmuVd6DtXDhWN2/r39PAvy3IB4YdLq18FMklw43/QvBkpoiZ/0//hxTk453YFbWv
	89UvG9n2PyS48yErFIm6oy9FYV3eXoxLPAm2h15DhG1TiSNYMahVPsWTOE1/MACnoltutTL
	WdzwYMFyAmk
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 3 ++-
 5 files changed, 17 insertions(+), 2 deletions(-)

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
index 6eca6de475f7..b6252b272364 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -87,7 +87,8 @@
 #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
 
 #define NGBE_INTR_ALL				0x1FF
-#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
+#define NGBE_INTR_MISC(A)			((A)->num_vfs == 7 ? \
+						 BIT(0) : BIT((A)->num_q_vectors))
 
 #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
 #define NGBE_CFG_LAN_SPEED			0x14440
-- 
2.48.1



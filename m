Return-Path: <netdev+bounces-202766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ECDAEEECB
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6211A3E110B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2B71E5B6D;
	Tue,  1 Jul 2025 06:32:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAEE190477
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351575; cv=none; b=Xp3NLi9xfzFyvUn5G5tUkzhwtIvP+ETb8id7pRs10hijfo3XzoHZBYVeEYMMR+pSxM8kUClVOj1nAuImfLVc2Qditj+viHvS6aldN0ooKdqANmOGhJxpD8lI3Bm3N9dkINMvJjyTz8LioW1sCsFmSnnclt3og2fCvFlgMs9qv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351575; c=relaxed/simple;
	bh=huv7EyBAbRLClZXipGCNggqV1/llwO0Qn/TW+uVAcTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0BXLjua8dMsqP6cJqBaB2artjHdgdUpeIKD50Wln+PTjecwy6Jv/USsQd1lNoT4p0C0EnpEdo7GnYcT341kHzqAOxbrL3ZITuFkaHUHfA93yXi7MtnAP3YdPBpqdKtJ5y9pc01TJ4EU0IoZLngkIV4Qu0z7dLzxzGhl8UH6CwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1751351489t7ab4a541
X-QQ-Originating-IP: /XJtDk+ruDBwNgcSWFg/4uWhr9U3HyJY9/KOEoS2iRY=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.151.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Jul 2025 14:31:27 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5692066625932100706
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com,
	larysa.zaremba@intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v4 3/3] net: ngbe: specify IRQ vector when the number of VFs is 7
Date: Tue,  1 Jul 2025 14:30:30 +0800
Message-Id: <20250701063030.59340-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250701063030.59340-1-jiawenwu@trustnetic.com>
References: <20250701063030.59340-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: McJfg7Aee/FZC/RsbfmcWhbtmS5VJWFaxmPxPTukpfHeogt0/ujcTqD1
	ECBr7ElRQRGZkubPserj1QRxqEpg1vLKUpVKQ/fwU9YmTHYj6RFztsK9kYPsDeebmskQjal
	Jq9j36O3z8j0VrHktoKRNc5G7zBRzkaPCOcvR/0oxrAtBP5nS/oyWFtNYXVhhK7uU29+61A
	kZ6D2A6dc57cUHxDPs/nn9VvQpXWetJ0mNk9aHWLXmc7KIq3Kw1Amy0x9WskEuuiwJ7+sZi
	UgMTEoQa4BsyJ/xPeD21WJDmKTJ2bSSNJVwplG8aV4nCeIUWI0Zrb1SB6wgDicTZ2jeE6nA
	ExK1J59yZBHrwKdXS3Pg7rDd6doaJD5Z0dal9NAMwTSuGq7kRPtPxJoZZCT0swelulyaaOO
	PIVT0j+wUl4e5cGcaOZ6bfacaI+MVKohtYCXiVvTLU1SSlIs89T3b4l3erhR6QZ+TsExyUZ
	yyQn7YAOt8mFrnut5FZfnSIxHtMuJdOBD5twHnOVtimAmIGloWjhU0AyfFjn5X0rFAL+c7c
	3TBq6LyQjhITc8q1tmB9RBTsV0PDH7vUNYszLJNshDhpKgNzc7IYenoYsTCJL7QPKruPsx8
	qW2kEildvFqZ5jl8uZ9kMMzUwamplfnj3eFhirHr5A+3sQnDtFDOASqG/1luAYebYqfVOPD
	2HCSdFUcmNg1yyY8uHrHRO0FY+u+PdKDayVgXIEPoflhATEd4HSiS1SwLwNzAl24WVcqyW6
	9Pc4Dy/g1DSJn394cOJX0+1oC3u7gWqo9xaPt079Ob3HRj4uTbxMJgqnw6HevTBpPB4XMdr
	IknxZm4NsMwWbXOYULqf47wg9n51EF0HRIZmjbVwETOxfWFBQyL6rQ50Ti2NHtSlOSepo7i
	qlzHKITkNCf7+8/hm3rA2LhTqFaIzo+KFF8vcndERvXp60uCml1+yuOfLZOOYVhpbcGvQbI
	RB/DQWFTD3wOdQqYgJ9yOXEaIsGCOPiDHjE+6grgSNVLyvxg540TSWy24iX/V443vwDIhvt
	DiiSsbt8prxWdseuYMryJoN7AeueCgb3BXo1+Vrg+A9lQ7YtVQF/x65Stv7SqzjauFUKxtG
	A79iHbrs97f
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
index 6eca6de475f7..3b2ca7f47e33 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -87,7 +87,7 @@
 #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
 
 #define NGBE_INTR_ALL				0x1FF
-#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
+#define NGBE_INTR_MISC(A)			BIT((A)->msix_entry->entry)
 
 #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
 #define NGBE_CFG_LAN_SPEED			0x14440
-- 
2.48.1




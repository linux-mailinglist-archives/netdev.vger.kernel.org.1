Return-Path: <netdev+bounces-212896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3158B22708
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCF118957DC
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC206239E67;
	Tue, 12 Aug 2025 12:33:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9020CCDC;
	Tue, 12 Aug 2025 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002028; cv=none; b=bNLvu+RYJEUuBII+rhGjsyjy8EATBHmFu8gM9HG8Qb8IuDsvmtwanh+L0ERxy1Epc6Vt9jLR2siDyncBUPdQLRrqPgn4VfbPfeK43gDhwW766l7/XN0D1urjD6YaX2XyuY85/+LGZ9cNroXux3mFuQApPZbpxwUHhea3oFlPpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002028; c=relaxed/simple;
	bh=j7Kv7iA76lmEKS5qGjA8beE+9qq+TtaTujAQ/G+CcvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIjxOaepmKlVZ7I7ysaErzBo/zJ0xdoFZ8E7pLvW6hPpnZzlJATKGMJxN/PxSifrCKogfuJ6XwMAxY2wgFKWeb1B/xiZG98Vtfk823Ihk3+N4hMLdGLYWrlSD8xqBxr1sEexleILxA0TUeNR5M8SKtzNAUSi9u3ChenFMfEuP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c1W5n2bF0zdbwl;
	Tue, 12 Aug 2025 20:29:17 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C028F18048F;
	Tue, 12 Aug 2025 20:33:36 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 20:33:35 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Fu Guiming <fuguiming@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v12 2/8] hinic3: Complete Event Queue interfaces
Date: Tue, 12 Aug 2025 20:33:20 +0800
Message-ID: <ed1dec3bbb993892ea5d878449d9ff7b3702ad5f.1754998409.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1754998409.git.zhuyikai1@h-partners.com>
References: <cover.1754998409.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add complete event queue interfaces initialization.
It informs that driver should handle the messages from HW.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |  16 +-
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   | 382 +++++++++++++++---
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   |  32 ++
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  36 ++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 122 +++++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  11 +
 6 files changed, 544 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
index 39e15fbf0ed7..e7417e8efa99 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
@@ -41,11 +41,14 @@
 
 /* EQ registers */
 #define HINIC3_AEQ_INDIR_IDX_ADDR      (HINIC3_CFG_REGS_FLAG + 0x210)
+#define HINIC3_CEQ_INDIR_IDX_ADDR      (HINIC3_CFG_REGS_FLAG + 0x290)
 
 #define HINIC3_EQ_INDIR_IDX_ADDR(type)  \
-	HINIC3_AEQ_INDIR_IDX_ADDR
+	((type == HINIC3_AEQ) ? HINIC3_AEQ_INDIR_IDX_ADDR :  \
+	 HINIC3_CEQ_INDIR_IDX_ADDR)
 
 #define HINIC3_AEQ_MTT_OFF_BASE_ADDR   (HINIC3_CFG_REGS_FLAG + 0x240)
+#define HINIC3_CEQ_MTT_OFF_BASE_ADDR   (HINIC3_CFG_REGS_FLAG + 0x2C0)
 
 #define HINIC3_CSR_EQ_PAGE_OFF_STRIDE  8
 
@@ -57,9 +60,20 @@
 	(HINIC3_AEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
 	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
 
+#define HINIC3_CEQ_HI_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_CEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
+	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE)
+
+#define HINIC3_CEQ_LO_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_CEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
+	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
+
 #define HINIC3_CSR_AEQ_CTRL_0_ADDR           (HINIC3_CFG_REGS_FLAG + 0x200)
 #define HINIC3_CSR_AEQ_CTRL_1_ADDR           (HINIC3_CFG_REGS_FLAG + 0x204)
 #define HINIC3_CSR_AEQ_PROD_IDX_ADDR         (HINIC3_CFG_REGS_FLAG + 0x20C)
 #define HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR  (HINIC3_CFG_REGS_FLAG + 0x50)
 
+#define HINIC3_CSR_CEQ_PROD_IDX_ADDR         (HINIC3_CFG_REGS_FLAG + 0x28c)
+#define HINIC3_CSR_CEQ_CI_SIMPLE_INDIR_ADDR  (HINIC3_CFG_REGS_FLAG + 0x54)
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
index 60385c242fb3..7a403fe8d63a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
@@ -22,6 +22,25 @@
 #define AEQ_CTRL_1_SET(val, member)  \
 	FIELD_PREP(AEQ_CTRL_1_##member##_MASK, val)
 
+#define CEQ_CTRL_0_INTR_IDX_MASK      GENMASK(9, 0)
+#define CEQ_CTRL_0_DMA_ATTR_MASK      GENMASK(17, 12)
+#define CEQ_CTRL_0_LIMIT_KICK_MASK    GENMASK(23, 20)
+#define CEQ_CTRL_0_PCI_INTF_IDX_MASK  GENMASK(25, 24)
+#define CEQ_CTRL_0_PAGE_SIZE_MASK     GENMASK(30, 27)
+#define CEQ_CTRL_0_INTR_MODE_MASK     BIT(31)
+#define CEQ_CTRL_0_SET(val, member)  \
+	FIELD_PREP(CEQ_CTRL_0_##member##_MASK, val)
+
+#define CEQ_CTRL_1_LEN_MASK           GENMASK(19, 0)
+#define CEQ_CTRL_1_SET(val, member)  \
+	FIELD_PREP(CEQ_CTRL_1_##member##_MASK, val)
+
+#define CEQE_TYPE_MASK                GENMASK(25, 23)
+#define CEQE_TYPE(type)               FIELD_GET(CEQE_TYPE_MASK, type)
+
+#define CEQE_DATA_MASK                GENMASK(25, 0)
+#define CEQE_DATA(data)               ((data) & CEQE_DATA_MASK)
+
 #define EQ_ELEM_DESC_TYPE_MASK        GENMASK(6, 0)
 #define EQ_ELEM_DESC_SRC_MASK         BIT(7)
 #define EQ_ELEM_DESC_SIZE_MASK        GENMASK(15, 8)
@@ -32,25 +51,34 @@
 #define EQ_CI_SIMPLE_INDIR_CI_MASK       GENMASK(20, 0)
 #define EQ_CI_SIMPLE_INDIR_ARMED_MASK    BIT(21)
 #define EQ_CI_SIMPLE_INDIR_AEQ_IDX_MASK  GENMASK(31, 30)
+#define EQ_CI_SIMPLE_INDIR_CEQ_IDX_MASK  GENMASK(31, 24)
 #define EQ_CI_SIMPLE_INDIR_SET(val, member)  \
 	FIELD_PREP(EQ_CI_SIMPLE_INDIR_##member##_MASK, val)
 
-#define EQ_CI_SIMPLE_INDIR_REG_ADDR  \
-	HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR
+#define EQ_CI_SIMPLE_INDIR_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR :  \
+	 HINIC3_CSR_CEQ_CI_SIMPLE_INDIR_ADDR)
 
-#define EQ_PROD_IDX_REG_ADDR  \
-	HINIC3_CSR_AEQ_PROD_IDX_ADDR
+#define EQ_PROD_IDX_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_PROD_IDX_ADDR : HINIC3_CSR_CEQ_PROD_IDX_ADDR)
 
 #define EQ_HI_PHYS_ADDR_REG(type, pg_num)  \
-	HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num)
+	(((type) == HINIC3_AEQ) ?  \
+	       HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num) :  \
+	       HINIC3_CEQ_HI_PHYS_ADDR_REG(pg_num))
 
 #define EQ_LO_PHYS_ADDR_REG(type, pg_num)  \
-	HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num)
+	(((type) == HINIC3_AEQ) ?  \
+	       HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num) :  \
+	       HINIC3_CEQ_LO_PHYS_ADDR_REG(pg_num))
 
 #define EQ_MSIX_RESEND_TIMER_CLEAR  1
 
-#define HINIC3_EQ_MAX_PAGES  \
-	HINIC3_AEQ_MAX_PAGES
+#define HINIC3_EQ_MAX_PAGES(eq)  \
+	((eq)->type == HINIC3_AEQ ?  \
+	 HINIC3_AEQ_MAX_PAGES : HINIC3_CEQ_MAX_PAGES)
 
 #define HINIC3_TASK_PROCESS_EQE_LIMIT  1024
 #define HINIC3_EQ_UPDATE_CI_STEP       64
@@ -69,6 +97,11 @@ static const struct hinic3_aeq_elem *get_curr_aeq_elem(const struct hinic3_eq *e
 	return get_q_element(&eq->qpages, eq->cons_idx, NULL);
 }
 
+static const __be32 *get_curr_ceq_elem(const struct hinic3_eq *eq)
+{
+	return get_q_element(&eq->qpages, eq->cons_idx, NULL);
+}
+
 int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
 			   enum hinic3_aeq_type event,
 			   hinic3_aeq_event_cb hwe_cb)
@@ -94,20 +127,76 @@ void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
 	spin_unlock_bh(&aeqs->aeq_lock);
 }
 
+int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_ceq_event event,
+			   hinic3_ceq_event_cb callback)
+{
+	struct hinic3_ceqs *ceqs;
+
+	ceqs = hwdev->ceqs;
+	ceqs->ceq_cb[event] = callback;
+	spin_lock_init(&ceqs->ceq_lock);
+
+	return 0;
+}
+
+void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_ceq_event event)
+{
+	struct hinic3_ceqs *ceqs;
+
+	ceqs = hwdev->ceqs;
+
+	spin_lock_bh(&ceqs->ceq_lock);
+	ceqs->ceq_cb[event] = NULL;
+	spin_unlock_bh(&ceqs->ceq_lock);
+}
+
 /* Set consumer index in the hw. */
 static void set_eq_cons_idx(struct hinic3_eq *eq, u32 arm_state)
 {
-	u32 addr = EQ_CI_SIMPLE_INDIR_REG_ADDR;
+	u32 addr = EQ_CI_SIMPLE_INDIR_REG_ADDR(eq);
 	u32 eq_wrap_ci, val;
 
 	eq_wrap_ci = HINIC3_EQ_CONS_IDX(eq);
-	val = EQ_CI_SIMPLE_INDIR_SET(arm_state, ARMED) |
-		EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
-		EQ_CI_SIMPLE_INDIR_SET(eq->q_id, AEQ_IDX);
+	val = EQ_CI_SIMPLE_INDIR_SET(arm_state, ARMED);
+	if (eq->type == HINIC3_AEQ) {
+		val = val |
+			EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
+			EQ_CI_SIMPLE_INDIR_SET(eq->q_id, AEQ_IDX);
+	} else {
+		val = val |
+			EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
+			EQ_CI_SIMPLE_INDIR_SET(eq->q_id, CEQ_IDX);
+	}
 
 	hinic3_hwif_write_reg(eq->hwdev->hwif, addr, val);
 }
 
+static struct hinic3_ceqs *ceq_to_ceqs(const struct hinic3_eq *eq)
+{
+	return container_of(eq, struct hinic3_ceqs, ceq[eq->q_id]);
+}
+
+static void ceq_event_handler(struct hinic3_ceqs *ceqs, __le32 ceqe)
+{
+	enum hinic3_ceq_event event = CEQE_TYPE(ceqe);
+	struct hinic3_hwdev *hwdev = ceqs->hwdev;
+	__le32 ceqe_data = CEQE_DATA(ceqe);
+
+	if (event >= HINIC3_MAX_CEQ_EVENTS) {
+		dev_warn(hwdev->dev, "Ceq unknown event:%d, ceqe data: 0x%x\n",
+			 event, ceqe_data);
+		return;
+	}
+
+	spin_lock_bh(&ceqs->ceq_lock);
+	if (ceqs->ceq_cb[event])
+		ceqs->ceq_cb[event](hwdev, ceqe_data);
+
+	spin_unlock_bh(&ceqs->ceq_lock);
+}
+
 static struct hinic3_aeqs *aeq_to_aeqs(const struct hinic3_eq *eq)
 {
 	return container_of(eq, struct hinic3_aeqs, aeq[eq->q_id]);
@@ -174,7 +263,40 @@ static int aeq_irq_handler(struct hinic3_eq *eq)
 	return -EAGAIN;
 }
 
-static void reschedule_eq_handler(struct hinic3_eq *eq)
+static int ceq_irq_handler(struct hinic3_eq *eq)
+{
+	struct hinic3_ceqs *ceqs;
+	u32 eqe_cnt = 0;
+	__be32 ceqe_raw;
+	__le32 ceqe;
+	u32 i;
+
+	ceqs = ceq_to_ceqs(eq);
+	for (i = 0; i < HINIC3_TASK_PROCESS_EQE_LIMIT; i++) {
+		ceqe_raw = *get_curr_ceq_elem(eq);
+		ceqe = swab32(ceqe_raw);
+
+		/* HW updates wrapped bit, when it adds eq element event */
+		if (EQ_ELEM_DESC_GET(ceqe, WRAPPED) == eq->wrapped)
+			return 0;
+
+		ceq_event_handler(ceqs, ceqe);
+		eq->cons_idx++;
+		if (eq->cons_idx == eq->eq_len) {
+			eq->cons_idx = 0;
+			eq->wrapped = !eq->wrapped;
+		}
+
+		if (++eqe_cnt >= HINIC3_EQ_UPDATE_CI_STEP) {
+			eqe_cnt = 0;
+			set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
+		}
+	}
+
+	return -EAGAIN;
+}
+
+static void reschedule_aeq_handler(struct hinic3_eq *eq)
 {
 	struct hinic3_aeqs *aeqs = aeq_to_aeqs(eq);
 
@@ -185,7 +307,10 @@ static int eq_irq_handler(struct hinic3_eq *eq)
 {
 	int err;
 
-	err = aeq_irq_handler(eq);
+	if (eq->type == HINIC3_AEQ)
+		err = aeq_irq_handler(eq);
+	else
+		err = ceq_irq_handler(eq);
 
 	set_eq_cons_idx(eq, err ? HINIC3_EQ_NOT_ARMED :
 			HINIC3_EQ_ARMED);
@@ -193,14 +318,14 @@ static int eq_irq_handler(struct hinic3_eq *eq)
 	return err;
 }
 
-static void eq_irq_work(struct work_struct *work)
+static void aeq_irq_work(struct work_struct *work)
 {
 	struct hinic3_eq *eq = container_of(work, struct hinic3_eq, aeq_work);
 	int err;
 
 	err = eq_irq_handler(eq);
 	if (err)
-		reschedule_eq_handler(eq);
+		reschedule_aeq_handler(eq);
 }
 
 static irqreturn_t aeq_interrupt(int irq, void *data)
@@ -222,6 +347,46 @@ static irqreturn_t aeq_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t ceq_interrupt(int irq, void *data)
+{
+	struct hinic3_eq *ceq = data;
+	int err;
+
+	/* clear resend timer counters */
+	hinic3_msix_intr_clear_resend_bit(ceq->hwdev, ceq->msix_entry_idx,
+					  EQ_MSIX_RESEND_TIMER_CLEAR);
+	err = eq_irq_handler(ceq);
+	if (err)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static int hinic3_set_ceq_ctrl_reg(struct hinic3_hwdev *hwdev, u16 q_id,
+				   u32 ctrl0, u32 ctrl1)
+{
+	struct comm_cmd_set_ceq_ctrl_reg ceq_ctrl = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	ceq_ctrl.func_id = hinic3_global_func_id(hwdev);
+	ceq_ctrl.q_id = q_id;
+	ceq_ctrl.ctrl0 = ctrl0;
+	ceq_ctrl.ctrl1 = ctrl1;
+
+	mgmt_msg_params_init_default(&msg_params, &ceq_ctrl, sizeof(ceq_ctrl));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_SET_CEQ_CTRL_REG, &msg_params);
+	if (err || ceq_ctrl.head.status) {
+		dev_err(hwdev->dev, "Failed to set ceq %u ctrl reg, err: %d status: 0x%x\n",
+			q_id, err, ceq_ctrl.head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int set_eq_ctrls(struct hinic3_eq *eq)
 {
 	struct hinic3_hwif *hwif = eq->hwdev->hwif;
@@ -229,34 +394,65 @@ static int set_eq_ctrls(struct hinic3_eq *eq)
 	u8 pci_intf_idx, elem_size;
 	u32 mask, ctrl0, ctrl1;
 	u32 page_size_val;
+	int err;
 
 	qpages = &eq->qpages;
 	page_size_val = ilog2(qpages->page_size / HINIC3_MIN_PAGE_SIZE);
 	pci_intf_idx = hwif->attr.pci_intf_idx;
 
-	/* set ctrl0 using read-modify-write */
-	mask = AEQ_CTRL_0_INTR_IDX_MASK |
-	       AEQ_CTRL_0_DMA_ATTR_MASK |
-	       AEQ_CTRL_0_PCI_INTF_IDX_MASK |
-	       AEQ_CTRL_0_INTR_MODE_MASK;
-	ctrl0 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR);
-	ctrl0 = (ctrl0 & ~mask) |
-		AEQ_CTRL_0_SET(eq->msix_entry_idx, INTR_IDX) |
-		AEQ_CTRL_0_SET(0, DMA_ATTR) |
-		AEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |
-		AEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);
-	hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR, ctrl0);
-
-	/* HW expects log2(number of 32 byte units). */
-	elem_size = qpages->elem_size_shift - 5;
-	ctrl1 = AEQ_CTRL_1_SET(eq->eq_len, LEN) |
-		AEQ_CTRL_1_SET(elem_size, ELEM_SIZE) |
-		AEQ_CTRL_1_SET(page_size_val, PAGE_SIZE);
-	hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_1_ADDR, ctrl1);
+	if (eq->type == HINIC3_AEQ) {
+		/* set ctrl0 using read-modify-write */
+		mask = AEQ_CTRL_0_INTR_IDX_MASK |
+		       AEQ_CTRL_0_DMA_ATTR_MASK |
+		       AEQ_CTRL_0_PCI_INTF_IDX_MASK |
+		       AEQ_CTRL_0_INTR_MODE_MASK;
+		ctrl0 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR);
+		ctrl0 = (ctrl0 & ~mask) |
+			AEQ_CTRL_0_SET(eq->msix_entry_idx, INTR_IDX) |
+			AEQ_CTRL_0_SET(0, DMA_ATTR) |
+			AEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |
+			AEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);
+		hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR, ctrl0);
+
+		/* HW expects log2(number of 32 byte units). */
+		elem_size = qpages->elem_size_shift - 5;
+		ctrl1 = AEQ_CTRL_1_SET(eq->eq_len, LEN) |
+			AEQ_CTRL_1_SET(elem_size, ELEM_SIZE) |
+			AEQ_CTRL_1_SET(page_size_val, PAGE_SIZE);
+		hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_1_ADDR, ctrl1);
+	} else {
+		ctrl0 = CEQ_CTRL_0_SET(eq->msix_entry_idx, INTR_IDX) |
+			CEQ_CTRL_0_SET(0, DMA_ATTR) |
+			CEQ_CTRL_0_SET(0, LIMIT_KICK) |
+			CEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |
+			CEQ_CTRL_0_SET(page_size_val, PAGE_SIZE) |
+			CEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);
+
+		ctrl1 = CEQ_CTRL_1_SET(eq->eq_len, LEN);
+
+		/* set ceq ctrl reg through mgmt cpu */
+		err = hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, ctrl0,
+					      ctrl1);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
 
+static void ceq_elements_init(struct hinic3_eq *eq, u32 init_val)
+{
+	__be32 *ceqe;
+	u32 i;
+
+	for (i = 0; i < eq->eq_len; i++) {
+		ceqe = get_q_element(&eq->qpages, i, NULL);
+		*ceqe = cpu_to_be32(init_val);
+	}
+
+	wmb();    /* Clear ceq elements bit */
+}
+
 static void aeq_elements_init(struct hinic3_eq *eq, u32 init_val)
 {
 	struct hinic3_aeq_elem *aeqe;
@@ -272,7 +468,10 @@ static void aeq_elements_init(struct hinic3_eq *eq, u32 init_val)
 
 static void eq_elements_init(struct hinic3_eq *eq, u32 init_val)
 {
-	aeq_elements_init(eq, init_val);
+	if (eq->type == HINIC3_AEQ)
+		aeq_elements_init(eq, init_val);
+	else
+		ceq_elements_init(eq, init_val);
 }
 
 static int alloc_eq_pages(struct hinic3_eq *eq)
@@ -311,7 +510,7 @@ static void eq_calc_page_size_and_num(struct hinic3_eq *eq, u32 elem_size)
 	 * Multiplications give power of 2 and divisions give power of 2 without
 	 * remainder.
 	 */
-	max_pages = HINIC3_EQ_MAX_PAGES;
+	max_pages = HINIC3_EQ_MAX_PAGES(eq);
 	min_page_size = HINIC3_MIN_PAGE_SIZE;
 	total_size = eq->eq_len * elem_size;
 
@@ -325,22 +524,36 @@ static void eq_calc_page_size_and_num(struct hinic3_eq *eq, u32 elem_size)
 
 static int request_eq_irq(struct hinic3_eq *eq)
 {
-	INIT_WORK(&eq->aeq_work, eq_irq_work);
-	snprintf(eq->irq_name, sizeof(eq->irq_name),
-		 "hinic3_aeq%u@pci:%s", eq->q_id,
-		 pci_name(eq->hwdev->pdev));
+	int err;
+
+	if (eq->type == HINIC3_AEQ) {
+		INIT_WORK(&eq->aeq_work, aeq_irq_work);
+		snprintf(eq->irq_name, sizeof(eq->irq_name),
+			 "hinic3_aeq%u@pci:%s", eq->q_id,
+			 pci_name(eq->hwdev->pdev));
+		err = request_irq(eq->irq_id, aeq_interrupt, 0,
+				  eq->irq_name, eq);
+	} else {
+		snprintf(eq->irq_name, sizeof(eq->irq_name),
+			 "hinic3_ceq%u@pci:%s", eq->q_id,
+			 pci_name(eq->hwdev->pdev));
+		err = request_threaded_irq(eq->irq_id, NULL, ceq_interrupt,
+					   IRQF_ONESHOT, eq->irq_name, eq);
+	}
 
-	return request_irq(eq->irq_id, aeq_interrupt, 0,
-			  eq->irq_name, eq);
+	return err;
 }
 
 static void reset_eq(struct hinic3_eq *eq)
 {
 	/* clear eq_len to force eqe drop in hardware */
-	hinic3_hwif_write_reg(eq->hwdev->hwif,
-			      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	if (eq->type == HINIC3_AEQ)
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	else
+		hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, 0, 0);
 
-	hinic3_hwif_write_reg(eq->hwdev->hwif, EQ_PROD_IDX_REG_ADDR, 0);
+	hinic3_hwif_write_reg(eq->hwdev->hwif, EQ_PROD_IDX_REG_ADDR(eq), 0);
 }
 
 static int init_eq(struct hinic3_eq *eq, struct hinic3_hwdev *hwdev, u16 q_id,
@@ -364,7 +577,7 @@ static int init_eq(struct hinic3_eq *eq, struct hinic3_hwdev *hwdev, u16 q_id,
 	eq->cons_idx = 0;
 	eq->wrapped = 0;
 
-	elem_size = HINIC3_AEQE_SIZE;
+	elem_size = (type == HINIC3_AEQ) ? HINIC3_AEQE_SIZE : HINIC3_CEQE_SIZE;
 	eq_calc_page_size_and_num(eq, elem_size);
 
 	err = alloc_eq_pages(eq);
@@ -411,14 +624,18 @@ static void remove_eq(struct hinic3_eq *eq)
 			      HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
 			      eq->q_id);
 
-	cancel_work_sync(&eq->aeq_work);
-	/* clear eq_len to avoid hw access host memory */
-	hinic3_hwif_write_reg(eq->hwdev->hwif,
-			      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	if (eq->type == HINIC3_AEQ) {
+		cancel_work_sync(&eq->aeq_work);
+		/* clear eq_len to avoid hw access host memory */
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	} else {
+		hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, 0, 0);
+	}
 
 	/* update consumer index to avoid invalid interrupt */
 	eq->cons_idx = hinic3_hwif_read_reg(eq->hwdev->hwif,
-					    EQ_PROD_IDX_REG_ADDR);
+					    EQ_PROD_IDX_REG_ADDR(eq));
 	set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
 	hinic3_queue_pages_free(eq->hwdev, &eq->qpages);
 }
@@ -495,3 +712,64 @@ void hinic3_aeqs_free(struct hinic3_hwdev *hwdev)
 
 	kfree(aeqs);
 }
+
+int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
+		     struct msix_entry *msix_entries)
+{
+	struct hinic3_ceqs *ceqs;
+	u16 q_id;
+	int err;
+
+	ceqs = kzalloc(sizeof(*ceqs), GFP_KERNEL);
+	if (!ceqs)
+		return -ENOMEM;
+
+	hwdev->ceqs = ceqs;
+	ceqs->hwdev = hwdev;
+	ceqs->num_ceqs = num_ceqs;
+
+	for (q_id = 0; q_id < num_ceqs; q_id++) {
+		err = init_eq(&ceqs->ceq[q_id], hwdev, q_id,
+			      HINIC3_DEFAULT_CEQ_LEN, HINIC3_CEQ,
+			      &msix_entries[q_id]);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to init ceq %u\n",
+				q_id);
+			goto err_free_ceqs;
+		}
+	}
+	for (q_id = 0; q_id < num_ceqs; q_id++)
+		hinic3_set_msix_state(hwdev, ceqs->ceq[q_id].msix_entry_idx,
+				      HINIC3_MSIX_ENABLE);
+
+	return 0;
+
+err_free_ceqs:
+	while (q_id > 0) {
+		q_id--;
+		remove_eq(&ceqs->ceq[q_id]);
+	}
+
+	kfree(ceqs);
+
+	return err;
+}
+
+void hinic3_ceqs_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_ceqs *ceqs = hwdev->ceqs;
+	enum hinic3_ceq_event ceq_event;
+	struct hinic3_eq *eq;
+	u16 q_id;
+
+	for (q_id = 0; q_id < ceqs->num_ceqs; q_id++) {
+		eq = ceqs->ceq + q_id;
+		remove_eq(eq);
+		hinic3_free_irq(hwdev, eq->irq_id);
+	}
+
+	for (ceq_event = 0; ceq_event < HINIC3_MAX_CEQ_EVENTS; ceq_event++)
+		hinic3_ceq_unregister_cb(hwdev, ceq_event);
+
+	kfree(ceqs);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
index 74f40dac474a..005a6e0745b3 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
@@ -10,15 +10,19 @@
 #include "hinic3_queue_common.h"
 
 #define HINIC3_MAX_AEQS              4
+#define HINIC3_MAX_CEQS              32
 
 #define HINIC3_AEQ_MAX_PAGES         4
+#define HINIC3_CEQ_MAX_PAGES         8
 
 #define HINIC3_AEQE_SIZE             64
+#define HINIC3_CEQE_SIZE             4
 
 #define HINIC3_AEQE_DESC_SIZE        4
 #define HINIC3_AEQE_DATA_SIZE        (HINIC3_AEQE_SIZE - HINIC3_AEQE_DESC_SIZE)
 
 #define HINIC3_DEFAULT_AEQ_LEN       0x10000
+#define HINIC3_DEFAULT_CEQ_LEN       0x10000
 
 #define HINIC3_EQ_IRQ_NAME_LEN       64
 
@@ -27,6 +31,7 @@
 
 enum hinic3_eq_type {
 	HINIC3_AEQ = 0,
+	HINIC3_CEQ = 1,
 };
 
 enum hinic3_eq_intr_mode {
@@ -78,6 +83,25 @@ struct hinic3_aeqs {
 	spinlock_t              aeq_lock;
 };
 
+enum hinic3_ceq_event {
+	HINIC3_CMDQ           = 3,
+	HINIC3_MAX_CEQ_EVENTS = 6,
+};
+
+typedef void (*hinic3_ceq_event_cb)(struct hinic3_hwdev *hwdev,
+				    __le32 ceqe_data);
+
+struct hinic3_ceqs {
+	struct hinic3_hwdev *hwdev;
+
+	hinic3_ceq_event_cb ceq_cb[HINIC3_MAX_CEQ_EVENTS];
+
+	struct hinic3_eq    ceq[HINIC3_MAX_CEQS];
+	u16                 num_ceqs;
+	/* lock for ceq event flag */
+	spinlock_t          ceq_lock;
+};
+
 int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
 		     struct msix_entry *msix_entries);
 void hinic3_aeqs_free(struct hinic3_hwdev *hwdev);
@@ -86,5 +110,13 @@ int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
 			   hinic3_aeq_event_cb hwe_cb);
 void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
 			      enum hinic3_aeq_type event);
+int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
+		     struct msix_entry *msix_entries);
+void hinic3_ceqs_free(struct hinic3_hwdev *hwdev);
+int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_ceq_event event,
+			   hinic3_ceq_event_cb callback);
+void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_ceq_event event);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index 22c84093efa2..379ba4cb042c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -70,6 +70,20 @@ enum comm_cmd {
 	COMM_CMD_SET_DMA_ATTR            = 25,
 };
 
+struct comm_cmd_cfg_msix_ctrl_reg {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u8                   opcode;
+	u8                   rsvd1;
+	u16                  msix_index;
+	u8                   pending_cnt;
+	u8                   coalesce_timer_cnt;
+	u8                   resend_timer_cnt;
+	u8                   lli_timer_cnt;
+	u8                   lli_credit_cnt;
+	u8                   rsvd2[5];
+};
+
 enum comm_func_reset_bits {
 	COMM_FUNC_RESET_BIT_FLUSH        = BIT(0),
 	COMM_FUNC_RESET_BIT_MQM          = BIT(1),
@@ -100,6 +114,28 @@ struct comm_cmd_feature_nego {
 	u64                  s_feature[COMM_MAX_FEATURE_QWORD];
 };
 
+struct comm_cmd_set_ceq_ctrl_reg {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  q_id;
+	u32                  ctrl0;
+	u32                  ctrl1;
+	u32                  rsvd1;
+};
+
+struct comm_cmdq_ctxt_info {
+	__le64 curr_wqe_page_pfn;
+	__le64 wq_block_pfn;
+};
+
+struct comm_cmd_set_cmdq_ctxt {
+	struct mgmt_msg_head       head;
+	u16                        func_id;
+	u8                         cmdq_id;
+	u8                         rsvd1[5];
+	struct comm_cmdq_ctxt_info ctxt;
+};
+
 /* Services supported by HW. HW uses these values when delivering events.
  * HW supports multiple services that are not yet supported by driver
  * (e.g. RoCE).
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index 27baa9693d20..d4af376b7f35 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -10,6 +10,14 @@
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
 
+/* config BAR4/5 4MB, DB & DWQE both 2MB */
+#define HINIC3_DB_DWQE_SIZE    0x00400000
+
+/* db/dwqe page size: 4K */
+#define HINIC3_DB_PAGE_SIZE    0x00001000
+#define HINIC3_DWQE_OFFSET     0x00000800
+#define HINIC3_DB_MAX_AREAS    (HINIC3_DB_DWQE_SIZE / HINIC3_DB_PAGE_SIZE)
+
 #define HINIC3_GET_REG_ADDR(reg)  ((reg) & (HINIC3_REGS_FLAG_MASK))
 
 static void __iomem *hinic3_reg_addr(struct hinic3_hwif *hwif, u32 reg)
@@ -31,16 +39,126 @@ void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val)
 	iowrite32be(val, addr);
 }
 
+static int get_db_idx(struct hinic3_hwif *hwif, u32 *idx)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+	u32 pg_idx;
+
+	spin_lock(&db_area->idx_lock);
+	pg_idx = find_first_zero_bit(db_area->db_bitmap_array,
+				     db_area->db_max_areas);
+	if (pg_idx == db_area->db_max_areas) {
+		spin_unlock(&db_area->idx_lock);
+		return -ENOMEM;
+	}
+	set_bit(pg_idx, db_area->db_bitmap_array);
+	spin_unlock(&db_area->idx_lock);
+
+	*idx = pg_idx;
+
+	return 0;
+}
+
+static void free_db_idx(struct hinic3_hwif *hwif, u32 idx)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+
+	spin_lock(&db_area->idx_lock);
+	clear_bit(idx, db_area->db_bitmap_array);
+	spin_unlock(&db_area->idx_lock);
+}
+
+void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base)
+{
+	struct hinic3_hwif *hwif;
+	uintptr_t distance;
+	u32 idx;
+
+	hwif = hwdev->hwif;
+	distance = db_base - hwif->db_base;
+	idx = distance / HINIC3_DB_PAGE_SIZE;
+
+	free_db_idx(hwif, idx);
+}
+
+int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
+			 void __iomem **dwqe_base)
+{
+	struct hinic3_hwif *hwif;
+	u8 __iomem *addr;
+	u32 idx;
+	int err;
+
+	hwif = hwdev->hwif;
+
+	err = get_db_idx(hwif, &idx);
+	if (err)
+		return err;
+
+	addr = hwif->db_base + idx * HINIC3_DB_PAGE_SIZE;
+	*db_base = addr;
+
+	if (dwqe_base)
+		*dwqe_base = addr + HINIC3_DWQE_OFFSET;
+
+	return 0;
+}
+
 void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 			   enum hinic3_msix_state flag)
 {
-	/* Completed by later submission due to LoC limit. */
+	struct hinic3_hwif *hwif;
+	u8 int_msk = 1;
+	u32 mask_bits;
+	u32 addr;
+
+	hwif = hwdev->hwif;
+
+	if (flag)
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_SET);
+	else
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_CLR);
+	mask_bits = mask_bits |
+		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, mask_bits);
 }
 
 void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
 				       u8 clear_resend_en)
 {
-	/* Completed by later submission due to LoC limit. */
+	struct hinic3_hwif *hwif;
+	u32 msix_ctrl, addr;
+
+	hwif = hwdev->hwif;
+
+	msix_ctrl = HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX) |
+		    HINIC3_MSI_CLR_INDIR_SET(clear_resend_en, RESEND_TIMER_CLR);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, msix_ctrl);
+}
+
+void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				     enum hinic3_msix_auto_mask flag)
+{
+	struct hinic3_hwif *hwif;
+	u32 mask_bits;
+	u32 addr;
+
+	hwif = hwdev->hwif;
+
+	if (flag)
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_SET);
+	else
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_CLR);
+
+	mask_bits = mask_bits |
+		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, mask_bits);
 }
 
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
index 2e300fb0ba25..29dd86eb458a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
@@ -50,13 +50,24 @@ enum hinic3_msix_state {
 	HINIC3_MSIX_DISABLE,
 };
 
+enum hinic3_msix_auto_mask {
+	HINIC3_CLR_MSIX_AUTO_MASK,
+	HINIC3_SET_MSIX_AUTO_MASK,
+};
+
 u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg);
 void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val);
 
+int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
+			 void __iomem **dwqe_base);
+void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base);
+
 void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 			   enum hinic3_msix_state flag);
 void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
 				       u8 clear_resend_en);
+void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				     enum hinic3_msix_auto_mask flag);
 
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev);
 
-- 
2.43.0



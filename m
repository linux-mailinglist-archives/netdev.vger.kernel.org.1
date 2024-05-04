Return-Path: <netdev+bounces-93454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6701B8BBDA5
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 20:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8649F1C208BF
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231CD3BBD5;
	Sat,  4 May 2024 18:31:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AA182D2;
	Sat,  4 May 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714847475; cv=none; b=JJ5WmzN9EyQEonOaTJe/7yMLUbuIA1wGBy55JCGBQEoMZ2nPf7U0Xy0YMJw+Pbk1IyaNGormhuFHBknHjGMLTZpIvS0QD0XePkOsQMqiJ5zIIvv14jJ7jjD95/+RCDt+ryb+90Dhx8zFHrQNUYRaxS+4RJp32819LjdY0jRxaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714847475; c=relaxed/simple;
	bh=IWMybl5BdDmwu/tOALp2s7wkjCfbpj86rBwZPmSDzWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kRTfo9yJdTwQtPKwz4IuHc3nS0R9k2R3AOxn0S6UStGoytH+Ncq4kMxey+L+QLr9lUe5L1EcSgrijzmdH9becjVOnkptKnFkHyhY3nUfIgMK+TF3F8D8pRoYIpNTbaZ95KAv9WMPflMGT1hrn4fs4NwO2UzS82RvXksjX5fnH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de60d05adafso732892276.2;
        Sat, 04 May 2024 11:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714847472; x=1715452272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6awG/tnY0fKh5OGlby3ZnlUbYw3ULR5XtNkIBFs72s=;
        b=dTuczD1I+k3VbFk+ytFFgAetba3jOBiYSjjvGxFD2QS5ClBWnkWX6qf8T6jnMb1C8u
         0AjexBlXZ4Kwdi8DJLBxaUxZyh/sFsZqyrtn6BFeij7tFz1reHY7XVTYIeIXnzJABfDi
         onGcswd5LJTMLGn937YHulh7x0D49A+qaJs8Z/dzJZwvdTuDOzRoe/yhM8T6wcNVx/+Z
         DU4sUF9SEZ2ylSlWTl3zex3S1uIbIxtGXbQulEIZbARC62avCi3mR3LSwZDj3IXnAZbm
         j2JJ2nWO3O/0Fhn44jvfTYhrVPmNSuY1EkTHj6c6mbiu1he27px7dbvp+ZDoneNu1mfr
         u7RA==
X-Forwarded-Encrypted: i=1; AJvYcCXjdQdYbBAcDhzZMT/wGLUF7q8z1yO05cG09KP1960ML96ksx0rrNK4LVeQNwzDdrR4lwY0Zm4uZDWTSWuR3Fhg5GcpYWG4SBmcep72YiowHnj6UqZPed/QxgiQ1L8eIlz/tTvEpJQfqpUV5fEwLTf4liQ4HVnTXDEZ0BGPNA9wWVERoCQn
X-Gm-Message-State: AOJu0YyzLIBvxpAFVTz5LT3wOPProtsujlN+GB9McHdPb+FH4NkG2RDr
	hdRbHVH462BPBBZj7EXL7GGdOqSqkIYUCuqDG+9xA+BW44TlHxzl
X-Google-Smtp-Source: AGHT+IG+YGjOFzAxrK6On4cUyT785/ezRDqxUC58DfjiiNmON0ShZFy0Q3OieDu/vyf/cGixon+xsg==
X-Received: by 2002:a25:5505:0:b0:de6:fe6:68b4 with SMTP id j5-20020a255505000000b00de60fe668b4mr5899692ybb.33.1714847471650;
        Sat, 04 May 2024 11:31:11 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id eh11-20020a05622a578b00b00439aa792ec0sm3119353qtb.37.2024.05.04.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 11:31:11 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: luiz.dentz@gmail.com
Cc: daveti@purdue.edu,
	benquike@gmail.com,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
Date: Sat,  4 May 2024 14:28:32 -0400
Message-Id: <20240504182831.296757-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_le_flowctl_init() can cause both div-by-zero and an integer
overflow since hdev->le_mtu may not fall in the valid range in the
specification.

Move MTU from hci_dev to hci_conn to validate MTU and stop the connection
process earlier if MTU is invalid.
Also, add a missing validation in read_buffer_size() and make it return
an error value if the validation fails.
Now hci_conn_add() returns ERR_PTR() as it can fail due to the both a
kzalloc failure and invalid MTU value.

divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 67 Comm: kworker/u5:0 Tainted: G        W          6.9.0-rc5+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci0 hci_rx_work
RIP: 0010:l2cap_le_flowctl_init+0x19e/0x3f0 net/bluetooth/l2cap_core.c:547
Code: e8 17 17 0c 00 66 41 89 9f 84 00 00 00 bf 01 00 00 00 41 b8 02 00 00 00 4c 89 fe 4c 89 e2 89 d9 e8 27 17 0c 00 44 89 f0 31 d2 <66> f7 f3 89 c3 ff c3 4d 8d b7 88 00 00 00 4c 89 f0 48 c1 e8 03 42
RSP: 0018:ffff88810bc0f858 EFLAGS: 00010246
RAX: 00000000000002a0 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffff88810bc0f7c0 RDI: ffffc90002dcb66f
RBP: ffff88810bc0f880 R08: aa69db2dda70ff01 R09: 0000ffaaaaaaaaaa
R10: 0084000000ffaaaa R11: 0000000000000000 R12: ffff88810d65a084
R13: dffffc0000000000 R14: 00000000000002a0 R15: ffff88810d65a000
FS:  0000000000000000(0000) GS:ffff88811ac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 0000000103268003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 l2cap_le_connect_req net/bluetooth/l2cap_core.c:4902 [inline]
 l2cap_le_sig_cmd net/bluetooth/l2cap_core.c:5420 [inline]
 l2cap_le_sig_channel net/bluetooth/l2cap_core.c:5486 [inline]
 l2cap_recv_frame+0xe59d/0x11710 net/bluetooth/l2cap_core.c:6809
 l2cap_recv_acldata+0x544/0x10a0 net/bluetooth/l2cap_core.c:7506
 hci_acldata_packet net/bluetooth/hci_core.c:3939 [inline]
 hci_rx_work+0x5e5/0xb20 net/bluetooth/hci_core.c:4176
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0x90f/0x1530 kernel/workqueue.c:3335
 worker_thread+0x926/0xe70 kernel/workqueue.c:3416
 kthread+0x2e3/0x380 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---

Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
v1 -> v2:
- Reply with an error code if a given MTU is not valid.
- Refuse hcon allocation if MTU is not still valid.
v2 -> v3:
- Move mtu to hcon.
- Make SCO, ISO, and L2CAP use hcon->mtu.

 include/net/bluetooth/hci.h      |  9 ++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 75 ++++++++++++++++++++++----------
 net/bluetooth/hci_event.c        | 35 ++++++++++-----
 net/bluetooth/iso.c              |  2 +-
 net/bluetooth/l2cap_core.c       | 17 ++------
 net/bluetooth/sco.c              |  6 +--
 7 files changed, 91 insertions(+), 54 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5c12761cb..07198beb3 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1666,6 +1666,15 @@ struct hci_cp_le_set_event_mask {
 	__u8     mask[8];
 } __packed;
 
+/* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E
+ * 7.8.2 LE Read Buffer Size command
+ * MAX_LE_MTU is 0xffff.
+ * 0 is also valid. It means that no dedicated LE Buffer exists.
+ * It should use the HCI_Read_Buffer_Size command and mtu is shared
+ * between BR/EDR and LE.
+ */
+#define HCI_MIN_LE_MTU 0x001b
+
 #define HCI_OP_LE_READ_BUFFER_SIZE	0x2002
 struct hci_rp_le_read_buffer_size {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e8f581f3f..b1c8489ff 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -706,6 +706,7 @@ struct hci_conn {
 	__u16		handle;
 	__u16		sync_handle;
 	__u16		state;
+	__u16		mtu;
 	__u8		mode;
 	__u8		type;
 	__u8		role;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 05346250f..6ab404dda 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -909,11 +909,37 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 {
 	struct hci_conn *conn;
 
+	switch (type) {
+	case ACL_LINK:
+		if (!hdev->acl_mtu)
+			return ERR_PTR(-ECONNREFUSED);
+		break;
+	case ISO_LINK:
+		if (hdev->iso_mtu)
+			/* Dedicated ISO Buffer exists */
+			break;
+		fallthrough;
+	case LE_LINK:
+		if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
+			return ERR_PTR(-ECONNREFUSED);
+		if (!hdev->le_mtu && hdev->acl_mtu < HCI_MIN_LE_MTU)
+			return ERR_PTR(-ECONNREFUSED);
+		break;
+	case SCO_LINK:
+	case ESCO_LINK:
+		if (!hdev->sco_pkts)
+			/* Controller does not support SCO or eSCO over HCI */
+			return ERR_PTR(-ECONNREFUSED);
+		break;
+	default:
+		return ERR_PTR(-ECONNREFUSED);
+	}
+
 	bt_dev_dbg(hdev, "dst %pMR handle 0x%4.4x", dst, handle);
 
 	conn = kzalloc(sizeof(*conn), GFP_KERNEL);
 	if (!conn)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	bacpy(&conn->dst, dst);
 	bacpy(&conn->src, &hdev->bdaddr);
@@ -944,10 +970,12 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	switch (type) {
 	case ACL_LINK:
 		conn->pkt_type = hdev->pkt_type & ACL_PTYPE_MASK;
+		conn->mtu = hdev->acl_mtu;
 		break;
 	case LE_LINK:
 		/* conn->src should reflect the local identity address */
 		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
+		conn->mtu = hdev->le_mtu ? hdev->le_mtu : hdev->acl_mtu;
 		break;
 	case ISO_LINK:
 		/* conn->src should reflect the local identity address */
@@ -959,6 +987,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		else if (conn->role == HCI_ROLE_MASTER)
 			conn->cleanup = cis_cleanup;
 
+		conn->mtu = hdev->iso_mtu ? hdev->iso_mtu :
+			    hdev->le_mtu ? hdev->le_mtu : hdev->acl_mtu;
 		break;
 	case SCO_LINK:
 		if (lmp_esco_capable(hdev))
@@ -966,9 +996,12 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 					(hdev->esco_type & EDR_ESCO_MASK);
 		else
 			conn->pkt_type = hdev->pkt_type & SCO_PTYPE_MASK;
+
+		conn->mtu = hdev->sco_mtu;
 		break;
 	case ESCO_LINK:
 		conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
+		conn->mtu = hdev->sco_mtu;
 		break;
 	}
 
@@ -1011,7 +1044,7 @@ struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
 
 	handle = hci_conn_hash_alloc_unset(hdev);
 	if (unlikely(handle < 0))
-		return NULL;
+		return ERR_PTR(-ECONNREFUSED);
 
 	return hci_conn_add(hdev, type, dst, role, handle);
 }
@@ -1317,8 +1350,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		bacpy(&conn->dst, dst);
 	} else {
 		conn = hci_conn_add_unset(hdev, LE_LINK, dst, role);
-		if (!conn)
-			return ERR_PTR(-ENOMEM);
+		if (IS_ERR(conn))
+			return conn;
 		hci_conn_hold(conn);
 		conn->pending_sec_level = sec_level;
 	}
@@ -1494,8 +1527,8 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EADDRINUSE);
 
 	conn = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
-	if (!conn)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(conn))
+		return conn;
 
 	conn->state = BT_CONNECT;
 
@@ -1538,8 +1571,8 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	BT_DBG("requesting refresh of dst_addr");
 
 	conn = hci_conn_add_unset(hdev, LE_LINK, dst, HCI_ROLE_MASTER);
-	if (!conn)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(conn))
+		return conn;
 
 	if (hci_explicit_conn_params_set(hdev, dst, dst_type) < 0) {
 		hci_conn_del(conn);
@@ -1586,8 +1619,8 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
 		acl = hci_conn_add_unset(hdev, ACL_LINK, dst, HCI_ROLE_MASTER);
-		if (!acl)
-			return ERR_PTR(-ENOMEM);
+		if (IS_ERR(acl))
+			return acl;
 	}
 
 	hci_conn_hold(acl);
@@ -1655,9 +1688,9 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	sco = hci_conn_hash_lookup_ba(hdev, type, dst);
 	if (!sco) {
 		sco = hci_conn_add_unset(hdev, type, dst, HCI_ROLE_MASTER);
-		if (!sco) {
+		if (IS_ERR(sco)) {
 			hci_conn_drop(acl);
-			return ERR_PTR(-ENOMEM);
+			return sco;
 		}
 	}
 
@@ -1847,8 +1880,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 				       qos->ucast.cis);
 	if (!cis) {
 		cis = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
-		if (!cis)
-			return ERR_PTR(-ENOMEM);
+		if (IS_ERR(cis))
+			return cis;
 		cis->cleanup = cis_cleanup;
 		cis->dst_type = dst_type;
 		cis->iso_qos.ucast.cig = BT_ISO_QOS_CIG_UNSET;
@@ -1983,14 +2016,8 @@ static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
 			      struct bt_iso_io_qos *qos, __u8 phy)
 {
 	/* Only set MTU if PHY is enabled */
-	if (!qos->sdu && qos->phy) {
-		if (hdev->iso_mtu > 0)
-			qos->sdu = hdev->iso_mtu;
-		else if (hdev->le_mtu > 0)
-			qos->sdu = hdev->le_mtu;
-		else
-			qos->sdu = hdev->acl_mtu;
-	}
+	if (!qos->sdu && qos->phy)
+		qos->sdu = conn->mtu;
 
 	/* Use the same PHY as ACL if set to any */
 	if (qos->phy == BT_ISO_PHY_ANY)
@@ -2071,8 +2098,8 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EBUSY);
 
 	conn = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_SLAVE);
-	if (!conn)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(conn))
+		return conn;
 
 	conn->iso_qos = *qos;
 	conn->state = BT_LISTEN;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4a27e4a17..4ad4a365c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -954,6 +954,9 @@ static u8 hci_cc_read_buffer_size(struct hci_dev *hdev, void *data,
 	BT_DBG("%s acl mtu %d:%d sco mtu %d:%d", hdev->name, hdev->acl_mtu,
 	       hdev->acl_pkts, hdev->sco_mtu, hdev->sco_pkts);
 
+	if (!hdev->acl_mtu || !hdev->acl_pkts)
+		return HCI_ERROR_INVALID_PARAMETERS;
+
 	return rp->status;
 }
 
@@ -1263,6 +1266,9 @@ static u8 hci_cc_le_read_buffer_size(struct hci_dev *hdev, void *data,
 
 	BT_DBG("%s le mtu %d:%d", hdev->name, hdev->le_mtu, hdev->le_pkts);
 
+	if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
+		return HCI_ERROR_INVALID_PARAMETERS;
+
 	return rp->status;
 }
 
@@ -2342,8 +2348,8 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 		if (!conn) {
 			conn = hci_conn_add_unset(hdev, ACL_LINK, &cp->bdaddr,
 						  HCI_ROLE_MASTER);
-			if (!conn)
-				bt_dev_err(hdev, "no memory for new connection");
+			if (IS_ERR(conn))
+				bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 		}
 	}
 
@@ -3154,8 +3160,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 						      BDADDR_BREDR)) {
 			conn = hci_conn_add_unset(hdev, ev->link_type,
 						  &ev->bdaddr, HCI_ROLE_SLAVE);
-			if (!conn) {
-				bt_dev_err(hdev, "no memory for new conn");
+			if (IS_ERR(conn)) {
+				bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 				goto unlock;
 			}
 		} else {
@@ -3343,8 +3349,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	if (!conn) {
 		conn = hci_conn_add_unset(hdev, ev->link_type, &ev->bdaddr,
 					  HCI_ROLE_SLAVE);
-		if (!conn) {
-			bt_dev_err(hdev, "no memory for new connection");
+		if (IS_ERR(conn)) {
+			bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 			goto unlock;
 		}
 	}
@@ -3821,6 +3827,9 @@ static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
 	BT_DBG("%s acl mtu %d:%d iso mtu %d:%d", hdev->name, hdev->acl_mtu,
 	       hdev->acl_pkts, hdev->iso_mtu, hdev->iso_pkts);
 
+	if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
+		return HCI_ERROR_INVALID_PARAMETERS;
+
 	return rp->status;
 }
 
@@ -5768,8 +5777,8 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 			goto unlock;
 
 		conn = hci_conn_add_unset(hdev, LE_LINK, bdaddr, role);
-		if (!conn) {
-			bt_dev_err(hdev, "no memory for new connection");
+		if (IS_ERR(conn)) {
+			bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 			goto unlock;
 		}
 
@@ -6498,7 +6507,7 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 		pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
 					     HCI_ROLE_SLAVE);
 
-		if (!pa_sync)
+		if (IS_ERR(pa_sync))
 			goto unlock;
 
 		set_bit(HCI_CONN_PA_SYNC_FAILED, &pa_sync->flags);
@@ -6898,7 +6907,7 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev, void *data,
 	if (!cis) {
 		cis = hci_conn_add(hdev, ISO_LINK, &acl->dst, HCI_ROLE_SLAVE,
 				   cis_handle);
-		if (!cis) {
+		if (IS_ERR(cis)) {
 			hci_le_reject_cis(hdev, ev->cis_handle);
 			goto unlock;
 		}
@@ -7007,7 +7016,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		if (!bis) {
 			bis = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
 					   HCI_ROLE_SLAVE, handle);
-			if (!bis)
+			if (IS_ERR(bis))
 				continue;
 		}
 
@@ -7037,6 +7046,8 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 			u16 handle = le16_to_cpu(ev->bis[i]);
 
 			bis = hci_conn_hash_lookup_handle(hdev, handle);
+			if (!bis)
+				continue;
 
 			set_bit(HCI_CONN_BIG_SYNC_FAILED, &bis->flags);
 			hci_connect_cfm(bis, ev->status);
@@ -7077,7 +7088,7 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
 				     HCI_ROLE_SLAVE);
 
-	if (!pa_sync)
+	if (IS_ERR(pa_sync))
 		goto unlock;
 
 	pa_sync->sync_handle = le16_to_cpu(ev->sync_handle);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index ef0cc80b4..6bed4aa82 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1285,7 +1285,7 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		return -ENOTCONN;
 	}
 
-	mtu = iso_pi(sk)->conn->hcon->hdev->iso_mtu;
+	mtu = iso_pi(sk)->conn->hcon->mtu;
 
 	release_sock(sk);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 84fc70862..d2a0bc09f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6239,7 +6239,7 @@ static int l2cap_finish_move(struct l2cap_chan *chan)
 	BT_DBG("chan %p", chan);
 
 	chan->rx_state = L2CAP_RX_STATE_RECV;
-	chan->conn->mtu = chan->conn->hcon->hdev->acl_mtu;
+	chan->conn->mtu = chan->conn->hcon->mtu;
 
 	return l2cap_resegment(chan);
 }
@@ -6306,7 +6306,7 @@ static int l2cap_rx_state_wait_f(struct l2cap_chan *chan,
 	 */
 	chan->next_tx_seq = control->reqseq;
 	chan->unacked_frames = 0;
-	chan->conn->mtu = chan->conn->hcon->hdev->acl_mtu;
+	chan->conn->mtu = chan->conn->hcon->mtu;
 
 	err = l2cap_resegment(chan);
 
@@ -6846,18 +6846,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 
 	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
 
-	switch (hcon->type) {
-	case LE_LINK:
-		if (hcon->hdev->le_mtu) {
-			conn->mtu = hcon->hdev->le_mtu;
-			break;
-		}
-		fallthrough;
-	default:
-		conn->mtu = hcon->hdev->acl_mtu;
-		break;
-	}
-
+	conn->mtu = hcon->mtu;
 	conn->feat_mask = 0;
 
 	conn->local_fixed_chan = L2CAP_FC_SIG_BREDR | L2CAP_FC_CONNLESS;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 5d03c5440..8718652ee 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -122,7 +122,6 @@ static void sco_sock_clear_timer(struct sock *sk)
 /* ---- SCO connections ---- */
 static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 {
-	struct hci_dev *hdev = hcon->hdev;
 	struct sco_conn *conn = hcon->sco_data;
 
 	if (conn) {
@@ -140,9 +139,10 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 
 	hcon->sco_data = conn;
 	conn->hcon = hcon;
+	conn->mtu = hcon->mtu;
 
-	if (hdev->sco_mtu > 0)
-		conn->mtu = hdev->sco_mtu;
+	if (hcon->mtu > 0)
+		conn->mtu = hcon->mtu;
 	else
 		conn->mtu = 60;
 
-- 
2.34.1



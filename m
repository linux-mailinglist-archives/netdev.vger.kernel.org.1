Return-Path: <netdev+bounces-276123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PZ8IlpD1Wk73gcAu9opvQ
	(envelope-from <netdev+bounces-276123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:48:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2B3B28F0
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B141301514B
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DB825CC57;
	Tue,  7 Apr 2026 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV+5KLmy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B08633985A;
	Tue,  7 Apr 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583988; cv=none; b=GKuG3H4UZNfy1KMs3TXPb3TVav2kh4mztS9o9cbDXCTB8rq8Y+GW6812o5SMdQoD023TO7egHjbZANrrgvC/NwbP/GruTW4KQnXewZpynYT0SJ06vc7vCXVEzSZeh6LiXgye5rSyRMq4zqCrGOZ3CNorK+OX+gN8VJbfm3H2M04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583988; c=relaxed/simple;
	bh=1dkwqyztiU7HeRjxKxgdNP+gjpHxz6XCpL94VbMhU9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UbVOQzdzWcFhm8fNuEikJUkP9hb1PUC1cvhAwtu//axzcaLLmQzQ32pPBDARBjiXDe/MEPrQTXAmUR9YWDheMp24Lwcq23i8PKvU4R4G8UZwm0wg6i12Dbb/SmqwJQfsNC19kPOF92Ci83L4v5IIl5haO4ksYisoTQl9b7wE3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV+5KLmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9870FC116C6;
	Tue,  7 Apr 2026 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775583987;
	bh=1dkwqyztiU7HeRjxKxgdNP+gjpHxz6XCpL94VbMhU9w=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=bV+5KLmyKf7ybyozOQlrS+JcZTe3HUIDxedvNgyhBukKmZDPQakcypLZ/0EFLQsOu
	 8LVmYjNR7kewbACRqd6bIYOU0Anut3KIRGtlI1AAgbcLLSqIJutwGFD/MAbgcabGKC
	 V5afTuXuFydjNqL/+mUo7SMfVJby+QuEex7UqtXx3cWy5ek8M5BQgZ917+UOakKft8
	 9PHpGRx1Z/c75Vn2rTr+IidP5aM4Arq7M59oKYuIf5e2N0/hICNzSY2sYf8zkjnuLN
	 4TtCOTpBGUNjP8NUhNEdXeNQoniUCRioXXoA1FrZxL6RlvqiA92BCSij4ER+Rp6MOX
	 WN/L3GMKqDL0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B083FF510E;
	Tue,  7 Apr 2026 17:46:27 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Tue, 07 Apr 2026 19:46:14 +0200
Subject: [PATCH v2] Bluetooth: Add Broadcom channel priority commands
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MSwrDIBSF4a2EO67FFxo66j5CBtHeJBdqDFqkJ
 bj32ow7/A+H74CMiTDDrTsgYaFMcWshLx34ddoWZPRoDZJLwzW3zCUf2J4oMmcUR+O96pWG9t8
 TzvQ+rWFsvVJ+xfQ56SJ+6z+lCCbYrHonrLLGaH5fwkTPq48BxlrrFyzGQSiiAAAA
X-Change-ID: 20260407-brcm-prio-b630e6cc3834
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775583986; l=8463;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=ls38bBpKAzE6VJeZlPaL4RS7NLNaYj9Gp3ptEsws8lk=;
 b=uMRcQfcUPw0ShEzztUFYphNKYfhemS+7LMJ2Jk/0l7gL21q7bi6R3RY0f4dvehrk8qozMEnAd
 bPkAqe4uBPWBaRLZuuGGL6/2emM5mN/m+GtabPIQnaoXPXDwvx/o6KG
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276123-lists,netdev=lfdr.de,fnkl.kernel.gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,jannau.net,gompa.dev,holtmann.org,gmail.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	HAS_REPLYTO(0.00)[fnkl.kernel@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FC2B3B28F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Certain Broadcom bluetooth chips (bcm4377/bcm4378/bcm438) need ACL
streams carrying audio to be set as "high priority" using a vendor
specific command to prevent 10-ish second-long dropouts whenever
something does a device scan. This patch sends the command when the
socket priority is set to TC_PRIO_INTERACTIVE, as BlueZ does for audio.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
Changes in v2:
- new ioctl got nack-ed, so let's use sk_priority as the trigger
- Link to v1: https://lore.kernel.org/r/20260407-brcm-prio-v1-1-f38b17376640@gmail.com
---
 MAINTAINERS                       |  2 ++
 drivers/bluetooth/hci_bcm4377.c   |  2 ++
 include/net/bluetooth/bluetooth.h |  4 ++++
 include/net/bluetooth/hci_core.h  | 11 +++++++++++
 net/bluetooth/Kconfig             |  7 +++++++
 net/bluetooth/Makefile            |  1 +
 net/bluetooth/brcm.c              | 29 +++++++++++++++++++++++++++++
 net/bluetooth/brcm.h              | 17 +++++++++++++++++
 net/bluetooth/hci_conn.c          | 28 ++++++++++++++++++++++++++++
 net/bluetooth/l2cap_sock.c        | 13 +++++++++++++
 10 files changed, 114 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..81be021367ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2562,6 +2562,8 @@ F:	include/dt-bindings/pinctrl/apple.h
 F:	include/linux/mfd/macsmc.h
 F:	include/linux/soc/apple/*
 F:	include/uapi/drm/asahi_drm.h
+F:	net/bluetooth/brcm.c
+F:	net/bluetooth/brcm.h
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 925d0a635945..5f79920c0306 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2397,6 +2397,8 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (bcm4377->hw->broken_le_ext_adv_report_phy)
 		hci_set_quirk(hdev, HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY);
 
+	hci_set_brcm_capable(hdev);
+
 	pci_set_drvdata(pdev, bcm4377);
 	hci_set_drvdata(hdev, bcm4377);
 	SET_HCIDEV_DEV(hdev, &pdev->dev);
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 69eed69f7f26..07a250673950 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -457,6 +457,7 @@ struct l2cap_ctrl {
 };
 
 struct hci_dev;
+struct hci_conn;
 
 typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
 typedef void (*hci_req_complete_skb_t)(struct hci_dev *hdev, u8 status,
@@ -469,6 +470,9 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 int hci_ethtool_ts_info(unsigned int index, int sk_proto,
 			struct kernel_ethtool_ts_info *ts_info);
 
+int hci_conn_setsockopt(struct hci_conn *conn, struct sock *sk, int level,
+			int optname, sockptr_t optval, unsigned int optlen);
+
 #define HCI_REQ_START	BIT(0)
 #define HCI_REQ_SKB	BIT(1)
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a7bffb908c1e..947e7c2b08dd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -642,6 +642,10 @@ struct hci_dev {
 	bool			aosp_quality_report;
 #endif
 
+#if IS_ENABLED(CONFIG_BT_BRCMEXT)
+	bool			brcm_capable;
+#endif
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
@@ -1791,6 +1795,13 @@ static inline void hci_set_aosp_capable(struct hci_dev *hdev)
 #endif
 }
 
+static inline void hci_set_brcm_capable(struct hci_dev *hdev)
+{
+#if IS_ENABLED(CONFIG_BT_BRCMEXT)
+	hdev->brcm_capable = true;
+#endif
+}
+
 static inline void hci_devcd_setup(struct hci_dev *hdev)
 {
 #ifdef CONFIG_DEV_COREDUMP
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 6b2b65a66700..0f2a5fbcafc5 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -110,6 +110,13 @@ config BT_AOSPEXT
 	  This options enables support for the Android Open Source
 	  Project defined HCI vendor extensions.
 
+config BT_BRCMEXT
+	bool "Enable Broadcom extensions"
+	depends on BT
+	help
+	  This option enables support for the Broadcom defined HCI
+	  vendor extensions.
+
 config BT_DEBUGFS
 	bool "Export Bluetooth internals in debugfs"
 	depends on BT && DEBUG_FS
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index a7eede7616d8..b4c9013a46ce 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -24,5 +24,6 @@ bluetooth-$(CONFIG_BT_LE) += iso.o
 bluetooth-$(CONFIG_BT_LEDS) += leds.o
 bluetooth-$(CONFIG_BT_MSFTEXT) += msft.o
 bluetooth-$(CONFIG_BT_AOSPEXT) += aosp.o
+bluetooth-$(CONFIG_BT_BRCMEXT) += brcm.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
diff --git a/net/bluetooth/brcm.c b/net/bluetooth/brcm.c
new file mode 100644
index 000000000000..9aa0a265ab3d
--- /dev/null
+++ b/net/bluetooth/brcm.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 The Asahi Linux Contributors
+ */
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "brcm.h"
+
+int brcm_set_high_priority(struct hci_dev *hdev, u16 handle, bool enable)
+{
+	struct sk_buff *skb;
+	u8 cmd[3];
+
+	if (!hdev->brcm_capable)
+		return 0;
+
+	cmd[0] = handle;
+	cmd[1] = handle >> 8;
+	cmd[2] = !!enable;
+
+	skb = hci_cmd_sync(hdev, 0xfc57, sizeof(cmd), cmd, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+	return 0;
+}
diff --git a/net/bluetooth/brcm.h b/net/bluetooth/brcm.h
new file mode 100644
index 000000000000..fdaee63bd1d2
--- /dev/null
+++ b/net/bluetooth/brcm.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 The Asahi Linux Contributors
+ */
+
+#if IS_ENABLED(CONFIG_BT_BRCMEXT)
+
+int brcm_set_high_priority(struct hci_dev *hdev, u16 handle, bool enable);
+
+#else
+
+static inline int brcm_set_high_priority(struct hci_dev *hdev, u16 handle, bool enable)
+{
+	return 0;
+}
+
+#endif
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11d3ad8d2551..096163840f62 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -35,6 +35,7 @@
 #include <net/bluetooth/iso.h>
 #include <net/bluetooth/mgmt.h>
 
+#include "brcm.h"
 #include "smp.h"
 #include "eir.h"
 
@@ -3070,6 +3071,33 @@ int hci_conn_set_phy(struct hci_conn *conn, u32 phys)
 	}
 }
 
+int hci_conn_setsockopt(struct hci_conn *conn, struct sock *sk, int level,
+			int optname, sockptr_t optval, unsigned int optlen)
+{
+	int val;
+	bool old_high, new_high, changed;
+
+	if (level != SOL_SOCKET)
+		return 0;
+
+	if (optname != SO_PRIORITY)
+		return 0;
+
+	if (optlen < sizeof(int))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&val, optval, sizeof(val)))
+		return -EFAULT;
+
+	old_high = sk->sk_priority >= TC_PRIO_INTERACTIVE;
+	new_high = val >= TC_PRIO_INTERACTIVE;
+	changed = old_high != new_high;
+	if (!changed)
+		return 0;
+
+	return brcm_set_high_priority(conn->hdev, conn->handle, new_high);
+}
+
 static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn = data;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45bce..d5eef87accc4 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -891,6 +891,16 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 	BT_DBG("sk %p", sk);
 
+	if (level == SOL_SOCKET) {
+		conn = chan->conn;
+		if (conn)
+			err = hci_conn_setsockopt(conn->hcon, sock->sk, level,
+						  optname, optval, optlen);
+		if (err)
+			return err;
+		return sock_setsockopt(sock, level, optname, optval, optlen);
+	}
+
 	if (level == SOL_L2CAP)
 		return l2cap_sock_setsockopt_old(sock, optname, optval, optlen);
 
@@ -1931,6 +1941,9 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
 
+	if (sock)
+		set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
+
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);

---
base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
change-id: 20260407-brcm-prio-b630e6cc3834

Best regards,
-- 
Sasha Finkelstein <fnkl.kernel@gmail.com>




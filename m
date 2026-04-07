Return-Path: <netdev+bounces-275980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPeyGAH01GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 14:09:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C9D3AE250
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 14:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BACE3024A0E
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 12:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856FF3AB28C;
	Tue,  7 Apr 2026 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+ZnMjH9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69639BFE7;
	Tue,  7 Apr 2026 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563772; cv=none; b=F1bYyQb61cJ/1veaki8W9naSFnRBoqDDUMoczCnLtpC9ZLfctbywptTyW98cAR+qbT9SlEBR8FSvtCldk9zEnlzEvnstwEZbWuzE0m7HSSSdhk1vF+RSMGCpzEO9p8lb3vlAKHL9/zoBKRlDGF59wFujC4bOFHZtU5Npm4UxPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563772; c=relaxed/simple;
	bh=MA/16xgPpr6e24Jp3Irwq/t17AycVTq4l79wFF2Amw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GBP3UmA/cvXEe2vZ7rSQadWdwxSnCL3nu7xsxZAOhXfhF3QRepZ2QRF7gHMpGdc4cw+Ba1bBM/rjtS5Z+Pk2zbK0MrsftOzcTKoxqTW97eEngrYoGVzPgvcSoSmIUyFLaGnVUt5fkDb4xj3hfNLvNZ37kJIxbfeLuNtJ/DgxOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+ZnMjH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC931C116C6;
	Tue,  7 Apr 2026 12:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775563772;
	bh=MA/16xgPpr6e24Jp3Irwq/t17AycVTq4l79wFF2Amw4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=f+ZnMjH9u95W+KecgH1M5djCLLZnJ2HGZ7KjMf3gVFzXfg4lq3jCo+mxR/E9egmnh
	 kXHaO5RLfZs70qR1kR+ZFxDvck468UjNzYFmkXVbvcIDzf6b1nYV1LByIVsJPqZ1wA
	 EMWm0IjAuL6xPC8bbCOa4WtknGR1GqgmdRkdK9YIqLxMS921b6lvGNUCSqQB8Owk0m
	 0e1QTOckyMRkmXbedowUvPjEMDHRePabm4d0WGawZsN5H4MJ2emhZu3KlbGx9SI4jG
	 tKLj9tu4uQonVasdEfh4FNoilbjgCiwzzvpjvdTz2w60DecGM+MQJR2wWT0I/w7ujF
	 tDaRgL20q7bkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74E4FEEF29;
	Tue,  7 Apr 2026 12:09:31 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Tue, 07 Apr 2026 14:09:14 +0200
Subject: [PATCH] Bluetooth: Add Broadcom channel priority commands
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-brcm-prio-v1-1-f38b17376640@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNz3aSi5FzdgqLMfN0kM2ODVLPkZGMLYxMloPqCotS0zAqwWdGxtbU
 AfbxXPlsAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775563770; l=7872;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=gg4x5lEmIqKFrASgP0xO22e+G2K7V8H9TMkHZhq7+QY=;
 b=vbmIOo8yojBRUh3vdplseWSQTA6tBL5Ublusuh3CS9xPiTabxvXlO4ioFtSCo6ffq9mj/H1I+
 flNVNUJaGSeBgHsyPMZP7NVDSsx61c3wUNqJn5Pu53GVlZW04KseeMm
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275980-lists,netdev=lfdr.de,fnkl.kernel.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,jannau.net,gompa.dev,holtmann.org,gmail.com,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[fnkl.kernel@gmail.com]
X-Rspamd-Queue-Id: D0C9D3AE250
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Certain Broadcom bluetooth chips (bcm4377/bcm4378/bcm438) need ACL
streams carrying audio to be set as "high priority" using a vendor
specific command to prevent 10-ish second-long dropouts whenever
something does a device scan. This series adds an ioctl to control
the priorities and hooks it up for the relevant chips.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS                      |  2 ++
 drivers/bluetooth/hci_bcm4377.c  |  2 ++
 include/net/bluetooth/hci_core.h | 12 ++++++++++++
 include/net/bluetooth/hci_sock.h |  7 +++++++
 net/bluetooth/Kconfig            |  7 +++++++
 net/bluetooth/Makefile           |  1 +
 net/bluetooth/brcm.c             | 29 +++++++++++++++++++++++++++++
 net/bluetooth/brcm.h             | 17 +++++++++++++++++
 net/bluetooth/hci_conn.c         | 11 +++++++++++
 net/bluetooth/hci_sock.c         |  4 ++++
 10 files changed, 92 insertions(+)

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
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a7bffb908c1e..ef3b5433203c 100644
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
@@ -1812,6 +1823,7 @@ int hci_get_conn_list(void __user *arg);
 int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
 int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
 int hci_inquiry(void __user *arg);
+int hci_set_acl_prio(struct hci_dev *hdev, void __user *arg);
 
 struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *list,
 					   bdaddr_t *bdaddr, u8 type);
diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
index 13e8cd4414a1..95d156ac4cae 100644
--- a/include/net/bluetooth/hci_sock.h
+++ b/include/net/bluetooth/hci_sock.h
@@ -91,6 +91,8 @@ struct hci_ufilter {
 
 #define HCIINQUIRY	_IOR('H', 240, int)
 
+#define HCISETACLPRIO	_IOW('H', 250, int)
+
 /* Ioctl requests structures */
 struct hci_dev_stats {
 	__u32 err_rx;
@@ -171,6 +173,11 @@ struct hci_inquiry_req {
 	__u8  length;
 	__u8  num_rsp;
 };
+
+struct hci_acl_prio_req {
+	__u16 handle;
+	__u8  high_prio;
+};
 #define IREQ_CACHE_FLUSH 0x0001
 
 #endif /* __HCI_SOCK_H */
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
index 000000000000..d03d2af5dc7e
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
+		return -EOPNOTSUPP;
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
index 000000000000..a501f2988a96
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
+	return -EOPNOTSUPP;
+}
+
+#endif
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11d3ad8d2551..b2c7414a9c5b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -35,6 +35,7 @@
 #include <net/bluetooth/iso.h>
 #include <net/bluetooth/mgmt.h>
 
+#include "brcm.h"
 #include "smp.h"
 #include "eir.h"
 
@@ -2775,6 +2776,16 @@ int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
 	return copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
 }
 
+int hci_set_acl_prio(struct hci_dev *hdev, void __user *arg)
+{
+	struct hci_acl_prio_req req;
+
+	if (copy_from_user(&req, arg, sizeof(req)))
+		return -EFAULT;
+
+	return brcm_set_high_priority(hdev, req.handle, req.high_prio);
+}
+
 struct hci_chan *hci_chan_create(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 0290dea081f6..4be6aeeb6bad 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1035,6 +1035,9 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 		return hci_sock_reject_list_del(hdev, (void __user *)arg);
+
+	case HCISETACLPRIO:
+		return hci_set_acl_prio(hdev, (void __user *)arg);
 	}
 
 	return -ENOIOCTLCMD;
@@ -1072,6 +1075,7 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 	case HCIGETAUTHINFO:
 	case HCIBLOCKADDR:
 	case HCIUNBLOCKADDR:
+	case HCISETACLPRIO:
 		break;
 	default:
 		return -ENOIOCTLCMD;

---
base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
change-id: 20260407-brcm-prio-b630e6cc3834

Best regards,
-- 
Sasha Finkelstein <fnkl.kernel@gmail.com>




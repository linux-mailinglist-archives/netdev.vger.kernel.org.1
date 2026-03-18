Return-Path: <netdev+bounces-268997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOPWDmKZumnnZQIAu9opvQ
	(envelope-from <netdev+bounces-268997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:24:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C72BB66A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F43630071DD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BF03A784E;
	Wed, 18 Mar 2026 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KEBs/iGe"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639F239446D;
	Wed, 18 Mar 2026 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836639; cv=none; b=kbFiltVVjv0BcVfCDBBzTOiHFT7zLkC12b5ew3hHlc0Yo8jJvrpUlhFBFcsx+UHeGnSxy1azpX983TxEBDVxk0yfF/9zzkpmpzDU28v6BiFjnFrB3UCHeRIav+g2d6uzbVny+7AnXhMK+sk9+uo46yJUcwB66+MLBacaqnwIz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836639; c=relaxed/simple;
	bh=wU0skl/viLQI6V1uQIzAJMIF+9Y+DMn2UuYs0Ltd4ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d6GfSMwoKnq2QqEUw2tksiYnR/QElhl+++nPyF0/eyrDV/KrggddIgzURY6s2lJ+BPjAB2qMIVu503N+0/T6dGjB9BFjTDjVGknkDu0FCRahequL0cnGF/t96R3RndeUdulk7VhoybefErOIEkEEwodxVSvlw22mMA2yOVERWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KEBs/iGe; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=XjlvBEu0V6dqbEXmSCJmn1xibQQzdnbmsdur6fckXIs=; b=KEBs/iGedUxEapemWggXE3VSn+
	wKh4v/NTGWFgSXa9ChWhU4W1ZsToJmE6LSt/R2djp5tH5q3Y1l5mo7wiNXkNSAQm8ZmnwhnUqaMgA
	OhwWYrwyl/P3TKNjuzgoH/t2twYWxWwg62SUzVRErXRgSfVFJcJNovCCXDxGMVtTxQ3LU1xlvfPGw
	eRLiIs6U/SZLQHZygdKc9vwAxq4r6vJB9kRkrmBdwDeAiKRsp9Cob6by/aqIztoaT8czQQfwpl/d9
	xoG/xVxE7uVdbc8WN1Y7nSlYIJ6rTjRXf3Ak8UfUFli+9N89h1LZ6y8OThMcufOtrOuZ77iDrTiKI
	p8OylBYQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w2pwA-003ebX-V0; Wed, 18 Mar 2026 12:23:46 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 18 Mar 2026 05:22:48 -0700
Subject: [PATCH net-next v2] bonding: remove bonding_priv.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-bond_uts-v2-1-033fe0d4e903@debian.org>
X-B4-Tracking: v=1; b=H4sIABeZumkC/2WNwQ6DIBAFf4XsWRqhFZVT/6MxjcKq2wM0gMTG+
 O+N9tjzmzezQcRAGEGzDQJmiuQdaCYLBmbu3YScLGgGspSqvArFB+/sc0mRl3U9om2swUpBweA
 dcKT1VD3AYeIO1wTdb4nL8EKTDtPBzhSTD5+zmsX5+A9kwQW/yUa1Cvu6tdXd4kC9u/gwQbfv+
 xfxyos/vQAAAA==
X-Change-ID: 20260316-bond_uts-077fed8dce56
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4998; i=leitao@debian.org;
 h=from:subject:message-id; bh=wU0skl/viLQI6V1uQIzAJMIF+9Y+DMn2UuYs0Ltd4ME=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpuplN6MoAAYBhJAzC2PSK/Aw5TpUbvAUC5NjIf
 Xm6B5H68aqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCabqZTQAKCRA1o5Of/Hh3
 bY4bD/9W5XGOYhPl6GBHpnPJSVBClSvecRC1fzOqfm627Gd88AbhKBvn3zaEvY/RIxPYl2vQjuC
 xRkjOtH1avumMkDWZeuGKzy97oBMqxIILF+sX/lOcOPShgAQLfEh6pujUKFRWF9vWPSX3C41ELQ
 rH0aGCzRe8rJ8gZm8+uvapJ6ZaVFD8/ZA/WZVZC75AX5fZjaKDalUSsN+DZZMYOJOHae9pGCo1n
 mjg3mthnXAVvKdF7LwpW3QiWd+JfW8xxOjqD+gSoZqUscor3fnfGwTtDuN7gsjRSnk/P0kygaDI
 9XTmr8WqeiWzOTJEVLs9XrvqoPJ9Lll8GWShyTJ3lSipjPZeI8Bsga0rA0lEAqLulG/1rvGjDVn
 vlYcXSjW8XWdldySZl3/8TDduyKY7gqJvOnaBTmtZ1pZkf97ZKzbnTRg+aKftf++FO0vch2Ty5T
 bSSyhoGySQc8hhpseF5DZzvyKt9BffTn8YToSA6edIHHRTVT2Y63JeTDCHCL0XHGaCzrWDPr9Ix
 uoSaqee0doeDJbnNwPNxC5qy6e2R1u4SctfYplpt91ptU5ljZomjtpNK4EhLLpbrQebLspk5JDB
 GGRpoX/0K95lFJr9NI3p9h8UfdHn5Du0G8BOySViOe3veajS9OfB/GQpfxzCHzEdl6A0WT3r1Qr
 92bA9JR7ruKByeg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268997-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lbl.gov:email]
X-Rspamd-Queue-Id: D58C72BB66A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bonding_priv.h only defined DRV_NAME and DRV_DESCRIPTION, but caused
unnecessary recompilation: it included <generated/utsrelease.h> to
define bond_version, which is used solely in bond_procfs.c. With
CONFIG_LOCALVERSION_AUTO=y, utsrelease.h is regenerated on every git
commit, so any git operation triggered recompilation of bond_main.c
which also included bonding_priv.h.

Remove the header entirely, as suggested by Jakub, given the macros on
this file can be integrated into the C files directly.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Remove drivers/net/bonding/bonding_priv.h completly (Jakub)
- Link to v1: https://patch.msgid.link/20260316-bond_uts-v1-1-428696ea79d5@debian.org
---
 drivers/net/bonding/bond_main.c    |  6 ++----
 drivers/net/bonding/bond_procfs.c  | 11 ++++++-----
 drivers/net/bonding/bonding_priv.h | 22 ----------------------
 3 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 90b71bd530401..d93d61ce6a08d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -93,8 +93,6 @@
 #include <net/netdev_lock.h>
 #include <net/xdp.h>
 
-#include "bonding_priv.h"
-
 /*---------------------------- Module parameters ----------------------------*/
 
 /* monitor all links that often (in milliseconds). <=0 disables monitoring */
@@ -5874,7 +5872,7 @@ static int bond_ethtool_get_link_ksettings(struct net_device *bond_dev,
 static void bond_ethtool_get_drvinfo(struct net_device *bond_dev,
 				     struct ethtool_drvinfo *drvinfo)
 {
-	strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
+	strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
 	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version), "%d",
 		 BOND_ABI_VERSION);
 }
@@ -6654,6 +6652,6 @@ static void __exit bonding_exit(void)
 module_init(bonding_init);
 module_exit(bonding_exit);
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_DESCRIPTION("Ethernet Channel Bonding Driver");
 MODULE_AUTHOR("Thomas Davis, tadavis@lbl.gov and many others");
 MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 7edf72ec816ab..e34f803051913 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <generated/utsrelease.h>
 #include <linux/proc_fs.h>
 #include <linux/ethtool.h>
 #include <linux/export.h>
@@ -6,7 +7,7 @@
 #include <net/netns/generic.h>
 #include <net/bonding.h>
 
-#include "bonding_priv.h"
+#define bond_version "Ethernet Channel Bonding Driver: v" UTS_RELEASE "\n"
 
 static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
@@ -290,7 +291,7 @@ void bond_create_proc_entry(struct bonding *bond)
 				bn->proc_dir, &bond_info_seq_ops, bond);
 		if (bond->proc_entry == NULL)
 			netdev_warn(bond_dev, "Cannot create /proc/net/%s/%s\n",
-				    DRV_NAME, bond_dev->name);
+				    KBUILD_MODNAME, bond_dev->name);
 		else
 			memcpy(bond->proc_file_name, bond_dev->name, IFNAMSIZ);
 	}
@@ -314,10 +315,10 @@ void bond_remove_proc_entry(struct bonding *bond)
 void __net_init bond_create_proc_dir(struct bond_net *bn)
 {
 	if (!bn->proc_dir) {
-		bn->proc_dir = proc_mkdir(DRV_NAME, bn->net->proc_net);
+		bn->proc_dir = proc_mkdir(KBUILD_MODNAME, bn->net->proc_net);
 		if (!bn->proc_dir)
 			pr_warn("Warning: Cannot create /proc/net/%s\n",
-				DRV_NAME);
+				KBUILD_MODNAME);
 	}
 }
 
@@ -326,7 +327,7 @@ void __net_init bond_create_proc_dir(struct bond_net *bn)
 void __net_exit bond_destroy_proc_dir(struct bond_net *bn)
 {
 	if (bn->proc_dir) {
-		remove_proc_entry(DRV_NAME, bn->net->proc_net);
+		remove_proc_entry(KBUILD_MODNAME, bn->net->proc_net);
 		bn->proc_dir = NULL;
 	}
 }
diff --git a/drivers/net/bonding/bonding_priv.h b/drivers/net/bonding/bonding_priv.h
deleted file mode 100644
index fef6288c6944f..0000000000000
--- a/drivers/net/bonding/bonding_priv.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-1.0+ */
-/*
- * Bond several ethernet interfaces into a Cisco, running 'Etherchannel'.
- *
- * Portions are (c) Copyright 1995 Simon "Guru Aleph-Null" Janes
- * NCM: Network and Communications Management, Inc.
- *
- * BUT, I'm the one who modified it for ethernet, so:
- * (c) Copyright 1999, Thomas Davis, tadavis@lbl.gov
- *
- */
-
-#ifndef _BONDING_PRIV_H
-#define _BONDING_PRIV_H
-#include <generated/utsrelease.h>
-
-#define DRV_NAME	"bonding"
-#define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"
-
-#define bond_version DRV_DESCRIPTION ": v" UTS_RELEASE "\n"
-
-#endif

---
base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
change-id: 20260316-bond_uts-077fed8dce56

Best regards,
--  
Breno Leitao <leitao@debian.org>



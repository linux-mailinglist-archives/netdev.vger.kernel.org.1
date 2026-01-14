Return-Path: <netdev+bounces-249840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC90D1F084
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE2BC300549C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370339B4A0;
	Wed, 14 Jan 2026 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fivFvMKh"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847D396B92;
	Wed, 14 Jan 2026 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396550; cv=none; b=A8t9PhQ85OG23Xdz6YWT3+6y8W5RhC0p8EufO5saxHw051fQNqOv8gV2v++lWWs0G/6jRQuQcPGDeVuSHSG2KPs/65FshSCtGJ4yECgTnXKcSrruejZA8UUYV08NEra94qpfXdViFpSVlGnh6Sz1XXZm1R0V3Im3AuabqzVhztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396550; c=relaxed/simple;
	bh=seSfhC8ogzDXxa89Np+o3MnqCHwdka1m3oqnUfoi4pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNfpS27CoY2DepX92J8fE4LMlvuSUbpQU6khSwkrT7XK3QaAfCRHhiSM4cLsi+3Q0mEp1PvoHra1YihQlfR/8ylRLUWrIROHDzgbKO+tN+f44OuDb02/2EB/QeZdDW59ew8KSxDJsNHwrwdkfGGwA0LulhBxfOLHDOMrBWC/c5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fivFvMKh; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OM
	Ei+QX/R46zrUv7SSZ7MEYUT7umCGMDz2EhK2yZNWE=; b=fivFvMKh6Stfbtyewk
	R+eL/cId7s02KUpg7dtfWWtCZ0qEQl5gxyTm6bpbH7FBI6W4Viaa8lgq8jhTo9yp
	uY9gPF2d4zsI7Yq1w6yC7/H7xT5VBcctsKxEbcyvPDPxmRyyeSHZrrC38gW8rxGY
	20qqzDYkS0/o+G/mgpSOOTu9I=
Received: from GHT-5854251031.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHuEKylmdpj+NjFg--.9247S2;
	Wed, 14 Jan 2026 21:14:28 +0800 (CST)
From: "wanquan.zhong" <zwq2226404116@163.com>
To: loic.poulain@oss.qualcomm.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com
Cc: netdev@vger.kernel.org,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	ryazanov.s.a@gmail.com,
	wanquan.zhong@fibocom.com
Subject: [PATCH] net: wwan: t7xx: Add CONFIG_WWAN_ADB_PORT for ADB port control
Date: Wed, 14 Jan 2026 21:14:23 +0800
Message-ID: <20260114131423.202777-1-zwq2226404116@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <599905d9-19ac-4027-85d1-9b185603051c@gmail.com>
References: <599905d9-19ac-4027-85d1-9b185603051c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHuEKylmdpj+NjFg--.9247S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWfuFyDZw1UJrWkJrykuFg_yoW5CrW7pa
	1DGFyYkrWDAFnxJw4DZayI9Fy5C3ZrCFW3Kr17t345uFyYyFy5CrZ2va4ayF15JFsrZrWx
	ArWaqF1Y93Z8Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBWl9UUUUU=
X-CM-SenderInfo: h2ztjjaswuikqrrwqiywtou0bp/xtbC0RQHXmlnlrQ-OQAA32

From: "wanquan.zhong" <wanquan.zhong@fibocom.com>

Changes from v2:
  1) Add missing 'net:' subsystem prefix to commit subject for compliance
  2) Remove redundant "to config" suffix and refine commit wording
  3) Split overlong Kconfig help text lines to meet 72-char limit
  4) Align EXPERT dependency desc with WWAN subsystem conventions

Add a new Kconfig option CONFIG_WWAN_ADB_PORT to control the ADB debug port
functionality for MediaTek T7xx WWAN modem. This option depends on MTK_T7XX
and EXPERT, defaults to 'y' to avoid breaking existing debugging workflows
while mitigating potential security concerns on specific target systems.

This change addresses security risks on systems such as Google Chrome OS,
where unauthorized root access could lead to malicious ADB configuration
of the WWAN device. The ADB port is restricted via this config only; the
MIPC port remains unrestricted as it is MTK's internal protocol port with
no associated security risks.

While introducing a kernel config option for a single array element may
appear to introduce minor resource overhead, this is the most
straightforward and maintainable implementation approach for this use case.
Alternativeimplementation suggestions from reviewers are welcome.

Signed-off-by: wanquan.zhong <wanquan.zhong@fibocom.com>
---
 drivers/net/wwan/Kconfig                | 11 +++++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
index 410b0245114e..3d49dc8491a3 100644
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -27,6 +27,17 @@ config WWAN_DEBUGFS
 	  elements for each WWAN device in a directory that is corresponding to
 	  the device name: debugfs/wwan/wwanX.
 
+config WWAN_ADB_PORT
+	bool "MediaTek T7xx ADB port support" if EXPERT
+	depends on MTK_T7XX
+	default y
+	help
+	  Enables ADB (Android Debug Bridge) debug port support for MediaTek T7xx WWAN devices.
+
+	  This option enables the ADB debug port functionality in the MediaTek T7xx driver,
+	  allowing Android Debug Bridge connections through T7xx modems that support
+	  this feature. It is primarily used for debugging and development purposes.
+
 config WWAN_HWSIM
 	tristate "Simulated WWAN device"
 	help
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 4fc131f9632f..9f3b7b1dd4e2 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -102,6 +102,7 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 		.ops = &ctl_port_ops,
 		.name = "t7xx_ap_ctrl",
 	}, {
+#ifdef CONFIG_WWAN_ADB_PORT
 		.tx_ch = PORT_CH_AP_ADB_TX,
 		.rx_ch = PORT_CH_AP_ADB_RX,
 		.txq_index = Q_IDX_ADB,
@@ -112,6 +113,7 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 		.port_type = WWAN_PORT_ADB,
 		.debug = true,
 	}, {
+#endif
 		.tx_ch = PORT_CH_MIPC_TX,
 		.rx_ch = PORT_CH_MIPC_RX,
 		.txq_index = Q_IDX_MBIM_MIPC,
-- 
2.43.0



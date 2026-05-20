Return-Path: <netdev+bounces-289838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEfVOqhyDWp0xgUAu9opvQ
	(envelope-from <netdev+bounces-289838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:36:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDE1589E63
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6536D31737F5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302F3AEF33;
	Wed, 20 May 2026 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="D/R199VC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8183AE6F5;
	Wed, 20 May 2026 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264870; cv=none; b=oZbb/8QOvptkELRdt337T57RYJeMByyX929Q3ApyNSrIC6ICU7B03io6laQtSQBqqvyj9yIEy0tCBtEA/58/fJ6AUlcfHkQGVzT7MArtMA13pLNlbvqzpCi8+wfLattXQwWrdbb6XrX8dkPqzkhG5DFxlq492dechBtjxJj2U20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264870; c=relaxed/simple;
	bh=NJDfmAfqw3n6d4pJcVQDITUcbf6QdswO5EpixbFY75A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=edlK9UF+tfWkXxoo2myVOKn/RwHxI5uwHQt11EhzwEs5EdrjVdSVOPQbtApqbZGEWTwAqVPkJxcRg038FETvb/5GI6S8k+2larB2/KR9lBHyb8E/0tU24oRUQ0RgS4QRbDyuYB8epNXIgDsY53bYCN2Tcrwo8ovmDrMnRrtEUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=D/R199VC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779264868; x=1810800868;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NJDfmAfqw3n6d4pJcVQDITUcbf6QdswO5EpixbFY75A=;
  b=D/R199VCFv694ji7XBQFymqSD6Jen+wWLF11kYdIn6gfsV1pfkvU5yY+
   OwFIrl9Z60yzdUuXusD1mXPRslweMwIRvMoXjCChx1NF+x3yN1Hdl7sD4
   0V6ar2oXdGPYQJZkMC7R5GtWWmmI4+LvYrE+5pDn298BcgftEhZ6cEZET
   T0kvEz8DeJc2HH8RPr05csNqpFHGnP/o3hcG2O4AB80t7ra36XLKYPEvB
   LdvFrvJmt5vgfnWojj8Ib84IKjLFktMhP92aaD4at8z7OW6V8znt1GLEi
   7oQK6VQPgvwdtMkPX2nGzsBPYdFbHDZFGY07FSvcvPlhQgNRUHOvHkNJN
   w==;
X-CSE-ConnectionGUID: XtmOLuCwRNeVDuasmYYRNQ==
X-CSE-MsgGUID: 9V/zyjXiRaiIIXIrfZ1Ogg==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; 
   d="scan'208";a="66575344"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2026 01:14:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 20 May 2026 01:14:27 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 20 May 2026 01:14:20 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 20 May 2026 10:12:20 +0200
Subject: [PATCH net-next v5 08/13] net: lan966x: add shutdown callback to
 stop FDMA on reboot
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260520-lan966x-pci-fdma-v5-8-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
In-Reply-To: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289838-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5DDE1589E63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When lan966x is used as a PCIe endpoint, the FDMA engine runs on the
card and survives a host reboot. Without a shutdown callback, channels
stay active and interrupt sources stay armed across the reset, causing
the shared PCIe INTx to assert before the driver has re-probed.

Add a shutdown callback, shared by the platform and PCI paths, that
masks FDMA interrupts (FDMA_INTR_ENA and FDMA_INTR_DB_ENA) and disables
the RX and TX channels.

FDMA_INTR_ENA persists on the card across a warm reboot, so also
restore the full enable in lan966x_fdma_rx_start() to re-arm interrupts
after a previous shutdown(). rx_start() runs after both the RX and TX
rings are allocated, so the same single-site re-arm works for both the
platform and PCIe backends.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c |  4 ++++
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 18 ++++++++++++++++++
 drivers/net/ethernet/microchip/lan966x/lan966x_regs.h | 15 +++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 9bb40383aa56..493aef5ba8d1 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -146,6 +146,10 @@ void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 	struct fdma *fdma = &rx->fdma;
 	u32 mask;
 
+	lan_wr(FDMA_INTR_ENA_INTR_PORT_ENA_SET(GENMASK(1, 0)) |
+	       FDMA_INTR_ENA_INTR_CH_ENA_SET(GENMASK(7, 0)),
+	       lan966x, FDMA_INTR_ENA);
+
 	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
 	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
 	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index f6d64323d06c..cc3c7b6c65ae 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1313,9 +1313,27 @@ static void lan966x_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(lan966x->debugfs_root);
 }
 
+static void lan966x_shutdown(struct platform_device *pdev)
+{
+	struct lan966x *lan966x = platform_get_drvdata(pdev);
+
+	if (!lan966x->fdma)
+		return;
+
+	lan966x_fdma_rx_disable(&lan966x->rx);
+	lan966x_fdma_tx_disable(&lan966x->tx);
+
+	napi_synchronize(&lan966x->napi);
+	napi_disable(&lan966x->napi);
+
+	lan_wr(0, lan966x, FDMA_INTR_ENA);
+	lan_wr(0, lan966x, FDMA_INTR_DB_ENA);
+}
+
 static struct platform_driver lan966x_driver = {
 	.probe = lan966x_probe,
 	.remove = lan966x_remove,
+	.shutdown = lan966x_shutdown,
 	.driver = {
 		.name = "lan966x-switch",
 		.of_match_table = lan966x_match,
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
index 4b553927d2e0..aba0d36ae6b5 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
@@ -1039,6 +1039,21 @@ enum lan966x_target {
 /*      FDMA:FDMA:FDMA_INTR_ERR */
 #define FDMA_INTR_ERR             __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 400, 0, 1, 4)
 
+/*      FDMA:FDMA:FDMA_INTR_ENA */
+#define FDMA_INTR_ENA             __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 404, 0, 1, 4)
+
+#define FDMA_INTR_ENA_INTR_PORT_ENA              GENMASK(9, 8)
+#define FDMA_INTR_ENA_INTR_PORT_ENA_SET(x)\
+	FIELD_PREP(FDMA_INTR_ENA_INTR_PORT_ENA, x)
+#define FDMA_INTR_ENA_INTR_PORT_ENA_GET(x)\
+	FIELD_GET(FDMA_INTR_ENA_INTR_PORT_ENA, x)
+
+#define FDMA_INTR_ENA_INTR_CH_ENA                GENMASK(7, 0)
+#define FDMA_INTR_ENA_INTR_CH_ENA_SET(x)\
+	FIELD_PREP(FDMA_INTR_ENA_INTR_CH_ENA, x)
+#define FDMA_INTR_ENA_INTR_CH_ENA_GET(x)\
+	FIELD_GET(FDMA_INTR_ENA_INTR_CH_ENA, x)
+
 /*      FDMA:FDMA:FDMA_ERRORS */
 #define FDMA_ERRORS               __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 412, 0, 1, 4)
 

-- 
2.34.1



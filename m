Return-Path: <netdev+bounces-96308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58EF8C4E82
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D754A1C2153F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66FF3D3BF;
	Tue, 14 May 2024 09:13:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F2286A6;
	Tue, 14 May 2024 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678015; cv=none; b=knYhzkaLfuX5Kztkfak50dEAkhcczDpxzFNLxhesDIlgCdP/qCzf4cqQlDLgA6Dg4S+TuJK07hEUwu+r2PSB7UEt9DaPiUV5yMYH6xl9gJluK5RBUpY+q2c/z4z9KAHqkiDejJ0rulmj0cELlTjBhMtiOCSR3FGkP2g/DwyEef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678015; c=relaxed/simple;
	bh=dHqEPBaw5nSQKZiDPjBfxGzkUWeHJx2AEu+zXPtpOlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4s90O3wtveoq1SflXHfVEx2x1LOTAN2y1EGSdcPwkPDAfEPEwPNW44HP/Sr8kpwnFpuiZ4pJtG7ScLmfFHwQTnj7714CVuw7UMgYYNXkV922F2Z1ZlzbGnJya4pGbPepVtfEi2U8RTLbZmMDsjhhdsEL6/zqhk4XIHGOPCpXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 764B2201C85;
	Tue, 14 May 2024 11:13:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E65A201C78;
	Tue, 14 May 2024 11:13:32 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 17F1F180226C;
	Tue, 14 May 2024 17:13:30 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v3 2/2] Bluetooth: btnxpuart: Update firmware names
Date: Tue, 14 May 2024 14:43:20 +0530
Message-Id: <20240514091320.1508015-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514091320.1508015-1-neeraj.sanjaykale@nxp.com>
References: <20240514091320.1508015-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This updates the firmware names of 3 chipsets: w8987, w8997, w9098.
These changes are been done to standardize chip specific firmware
file names.
To allow user to use older firmware file names, a new device tree
property has been introduced called firmware-name, which will override
the hardcoded firmware names in the driver.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Remove "nxp/" from all firmware name definitions to be inline with
firware file name read from device tree file. (Krzysztof)
---
 drivers/bluetooth/btnxpuart.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0b93c2ff29e4..4442d911eba8 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -33,16 +33,16 @@
 /* NXP HW err codes */
 #define BTNXPUART_IR_HW_ERR		0xb0
 
-#define FIRMWARE_W8987		"nxp/uartuart8987_bt.bin"
-#define FIRMWARE_W8997		"nxp/uartuart8997_bt_v4.bin"
-#define FIRMWARE_W9098		"nxp/uartuart9098_bt_v1.bin"
-#define FIRMWARE_IW416		"nxp/uartiw416_bt_v0.bin"
-#define FIRMWARE_IW612		"nxp/uartspi_n61x_v1.bin.se"
-#define FIRMWARE_IW624		"nxp/uartiw624_bt.bin"
-#define FIRMWARE_SECURE_IW624	"nxp/uartiw624_bt.bin.se"
-#define FIRMWARE_AW693		"nxp/uartaw693_bt.bin"
-#define FIRMWARE_SECURE_AW693	"nxp/uartaw693_bt.bin.se"
-#define FIRMWARE_HELPER		"nxp/helper_uart_3000000.bin"
+#define FIRMWARE_W8987		"uart8987_bt_v0.bin"
+#define FIRMWARE_W8997		"uart8997_bt_v4.bin"
+#define FIRMWARE_W9098		"uart9098_bt_v1.bin"
+#define FIRMWARE_IW416		"uartiw416_bt_v0.bin"
+#define FIRMWARE_IW612		"uartspi_n61x_v1.bin.se"
+#define FIRMWARE_IW624		"uartiw624_bt.bin"
+#define FIRMWARE_SECURE_IW624	"uartiw624_bt.bin.se"
+#define FIRMWARE_AW693		"uartaw693_bt.bin"
+#define FIRMWARE_SECURE_AW693	"uartaw693_bt.bin.se"
+#define FIRMWARE_HELPER		"helper_uart_3000000.bin"
 
 #define CHIP_ID_W9098		0x5c03
 #define CHIP_ID_IW416		0x7201
@@ -685,13 +685,19 @@ static bool process_boot_signature(struct btnxpuart_dev *nxpdev)
 static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	const char *fw_name_dt;
 	int err = 0;
 
 	if (!fw_name)
 		return -ENOENT;
 
 	if (!strlen(nxpdev->fw_name)) {
-		snprintf(nxpdev->fw_name, MAX_FW_FILE_NAME_LEN, "%s", fw_name);
+		if (strcmp(fw_name, FIRMWARE_HELPER) &&
+		    !device_property_read_string(&nxpdev->serdev->dev,
+						 "firmware-name",
+						 &fw_name_dt))
+			fw_name = fw_name_dt;
+		snprintf(nxpdev->fw_name, MAX_FW_FILE_NAME_LEN, "nxp/%s", fw_name);
 
 		bt_dev_dbg(hdev, "Request Firmware: %s", nxpdev->fw_name);
 		err = request_firmware(&nxpdev->fw, nxpdev->fw_name, &hdev->dev);
-- 
2.34.1



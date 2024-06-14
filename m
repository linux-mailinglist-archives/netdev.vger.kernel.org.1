Return-Path: <netdev+bounces-103525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886E49086CA
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1290B285825
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD81192B94;
	Fri, 14 Jun 2024 08:52:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095D1922EE;
	Fri, 14 Jun 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355121; cv=none; b=A0qtm9uMe12jzouAuy9Niucl6f6/vJ29zQAMHrOd21kNLvSoeYfKpttA3u6hQaLxUErpkJUW2vA3RQUAedmV7SDVXBKc2iQO3maaImP50LC8PyLPGuIH4z5JWbOpKfD8ep7Fc5HLTo4DWaoqYTuYFdieYa0ebR0bjXucAGvKNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355121; c=relaxed/simple;
	bh=UdGhpwC++BuA+TWiaIDRyd5nmS4nLUXGnT+sJOJE0xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/SvRTmX7f8RJT1wCadcTGQ8LKb0kW8yOEiL1VB7ocZWd01waMn8oQuPfyJAWvo2TWApDylZBjm3dPt32EXcgFe4Og+EWo+1H34auTXHJZIaKkvZvyggvnTiv76JdM0xEtbWTcC5LOtpT1RyFwMjFES+PEqIPPnBJaXwtQgtqKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 28B4E20175F;
	Fri, 14 Jun 2024 10:51:58 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 57369201776;
	Fri, 14 Jun 2024 10:51:57 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F2811820F59;
	Fri, 14 Jun 2024 16:51:54 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
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
Subject: [PATCH v4 2/2] Bluetooth: btnxpuart: Update firmware names
Date: Fri, 14 Jun 2024 14:19:41 +0530
Message-Id: <20240614084941.6832-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614084941.6832-1-neeraj.sanjaykale@nxp.com>
References: <20240614084941.6832-1-neeraj.sanjaykale@nxp.com>
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
file names to be in sync with firmware names of newer chipsets.

The naming convention for BT-only files would be as follows:
For dual-radio WiFi+BT chipsets:
- <protocol-BT><chip-name>_bt_v<HW-version>.bin
For tri-radio WiFi+BT+15.4 chipsets:
- <protocol-BT><protocol-15.4><chip-name>_bt_v<HW-version>.bin

To maintain backward compatibility, this commit adds a provision to
request older firmware file name, if new firmware file name not found in
/lib/firmware/nxp/.

A new device tree property has been introduced called firmware-name, to
override the hardcoded firmware names (old and new) in the driver.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Remove "nxp/" from all firmware name definitions to be inline with
firmware file name read from device tree file. (Krzysztof)
v4: Request old firmware file name if new firmware file not found, to
avoid regressions. Added new naming schema in commit message. (Paul Menzel)
---
 drivers/bluetooth/btnxpuart.c | 67 ++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index ac4408e16369..ab471f1807cb 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -34,16 +34,19 @@
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
+#define FIRMWARE_W8987_OLD	"uartuart8987_bt.bin"
+#define FIRMWARE_W8997		"uart8997_bt_v4.bin"
+#define FIRMWARE_W8997_OLD	"uartuart8997_bt_v4.bin"
+#define FIRMWARE_W9098		"uart9098_bt_v1.bin"
+#define FIRMWARE_W9098_OLD	"uartuart9098_bt_v1.bin"
+#define FIRMWARE_IW416		"uartiw416_bt_v0.bin"
+#define FIRMWARE_IW612		"uartspi_n61x_v1.bin.se"
+#define FIRMWARE_IW624		"uartiw624_bt.bin"
+#define FIRMWARE_SECURE_IW624	"uartiw624_bt.bin.se"
+#define FIRMWARE_AW693		"uartaw693_bt.bin"
+#define FIRMWARE_SECURE_AW693	"uartaw693_bt.bin.se"
+#define FIRMWARE_HELPER		"helper_uart_3000000.bin"
 
 #define CHIP_ID_W9098		0x5c03
 #define CHIP_ID_IW416		0x7201
@@ -145,6 +148,7 @@ struct psmode_cmd_payload {
 struct btnxpuart_data {
 	const char *helper_fw_name;
 	const char *fw_name;
+	const char *fw_name_old;
 };
 
 struct btnxpuart_dev {
@@ -694,19 +698,30 @@ static bool process_boot_signature(struct btnxpuart_dev *nxpdev)
 	return is_fw_downloading(nxpdev);
 }
 
-static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name)
+static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name,
+				const char *fw_name_old)
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
+		err = request_firmware_direct(&nxpdev->fw, nxpdev->fw_name, &hdev->dev);
+		if (err < 0 && fw_name_old) {
+			snprintf(nxpdev->fw_name, MAX_FW_FILE_NAME_LEN, "nxp/%s", fw_name_old);
+			err = request_firmware_direct(&nxpdev->fw, nxpdev->fw_name, &hdev->dev);
+		}
 
 		bt_dev_info(hdev, "Request Firmware: %s", nxpdev->fw_name);
-		err = request_firmware(&nxpdev->fw, nxpdev->fw_name, &hdev->dev);
 		if (err < 0) {
 			bt_dev_err(hdev, "Firmware file %s not found", nxpdev->fw_name);
 			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
@@ -785,10 +800,10 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (!nxp_data->helper_fw_name || nxpdev->helper_downloaded) {
-		if (nxp_request_firmware(hdev, nxp_data->fw_name))
+		if (nxp_request_firmware(hdev, nxp_data->fw_name, nxp_data->fw_name_old))
 			goto free_skb;
 	} else if (nxp_data->helper_fw_name && !nxpdev->helper_downloaded) {
-		if (nxp_request_firmware(hdev, nxp_data->helper_fw_name))
+		if (nxp_request_firmware(hdev, nxp_data->helper_fw_name, NULL))
 			goto free_skb;
 	}
 
@@ -890,10 +905,25 @@ static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
 	return fw_name;
 }
 
+static char *nxp_get_old_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
+					 u8 loader_ver)
+{
+	char *fw_name_old = NULL;
+
+	switch (chipid) {
+	case CHIP_ID_W9098:
+		fw_name_old = FIRMWARE_W9098_OLD;
+		break;
+	}
+	return fw_name_old;
+}
+
 static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct v3_start_ind *req = skb_pull_data(skb, sizeof(*req));
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	const char *fw_name;
+	const char *fw_name_old;
 	u16 chip_id;
 	u8 loader_ver;
 
@@ -903,8 +933,9 @@ static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	chip_id = le16_to_cpu(req->chip_id);
 	loader_ver = req->loader_ver;
 	bt_dev_info(hdev, "ChipID: %04x, Version: %d", chip_id, loader_ver);
-	if (!nxp_request_firmware(hdev, nxp_get_fw_name_from_chipid(hdev,
-								    chip_id, loader_ver)))
+	fw_name = nxp_get_fw_name_from_chipid(hdev, chip_id, loader_ver);
+	fw_name_old = nxp_get_old_fw_name_from_chipid(hdev, chip_id, loader_ver);
+	if (!nxp_request_firmware(hdev, fw_name, fw_name_old))
 		nxp_send_ack(NXP_ACK_V3, hdev);
 
 free_skb:
@@ -1426,11 +1457,13 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 static struct btnxpuart_data w8987_data __maybe_unused = {
 	.helper_fw_name = NULL,
 	.fw_name = FIRMWARE_W8987,
+	.fw_name_old = FIRMWARE_W8987_OLD,
 };
 
 static struct btnxpuart_data w8997_data __maybe_unused = {
 	.helper_fw_name = FIRMWARE_HELPER,
 	.fw_name = FIRMWARE_W8997,
+	.fw_name_old = FIRMWARE_W8997_OLD,
 };
 
 static const struct of_device_id nxpuart_of_match_table[] __maybe_unused = {
-- 
2.34.1



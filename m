Return-Path: <netdev+bounces-41841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACF17CC001
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9771C209D0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F2F41212;
	Tue, 17 Oct 2023 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB976405E7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:57:43 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE953B0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:57:40 -0700 (PDT)
X-QQ-mid: bizesmtp63t1697536487tk7khk9b
Received: from wxdbg.localdomain.com ( [125.119.254.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Oct 2023 17:54:14 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: RrZlkntZBflFAKWG05XYuhzhjh6LoYQ7bz+vdLVLR6H45AQ7VxeqLeNltfp6u
	jaSWSDOdXL4/OQji9cu/MBi6ZNnI1C4WsvtP7cJxb2WjbtJf0BumR0sdyQRmLjySvF8g5Ck
	f3oifcmQvKdmes5VXPoyNfMXw6/2c3y8n/tl9SCfVmYEIJ2oJpjOAU2W+sWgJbx1fvGTzUK
	+M71wB8Stb0WialHEiTJrYb1dSAeE+x6b2QbO/675ygLoI2byZIedgn0+Kh7FVKI4J3aWEH
	VeSOxeKWJn0VW5+bjuYthLVDHqFKbGHJBs9AKl8EfeGQ3KptpAkzZcObx2pcS0oyAwJ6A37
	TmTRJklJfQQSMTLTiwwWMIGx6pW5xfFlwONMOKboeGePlInqRagGiytJHxamw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11092576257633501927
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH] net: wangxun: remove redundant kernel log
Date: Tue, 17 Oct 2023 18:06:35 +0800
Message-Id: <20231017100635.154967-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since PBA info can be read from lspci, delete txgbe_read_pba_string()
and the prints. In addition, delete the redundant MAC address printing.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   5 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c | 108 ------------------
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h |   1 -
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   8 --
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   6 -
 5 files changed, 128 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 652e6576e36a..3d43f808c86b 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -679,11 +679,6 @@ static int ngbe_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, wx);
 
-	netif_info(wx, probe, netdev,
-		   "PHY: %s, PBA No: Wang Xun GbE Family Controller\n",
-		   wx->mac_type == em_mac_type_mdi ? "Internal" : "External");
-	netif_info(wx, probe, netdev, "%pM\n", netdev->dev_addr);
-
 	return 0;
 
 err_register:
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index 474d55524e82..d6b2b3c781b6 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -70,114 +70,6 @@ static void txgbe_init_thermal_sensor_thresh(struct wx *wx)
 	wr32(wx, WX_TS_DALARM_THRE, 614);
 }
 
-/**
- *  txgbe_read_pba_string - Reads part number string from EEPROM
- *  @wx: pointer to hardware structure
- *  @pba_num: stores the part number string from the EEPROM
- *  @pba_num_size: part number string buffer length
- *
- *  Reads the part number string from the EEPROM.
- **/
-int txgbe_read_pba_string(struct wx *wx, u8 *pba_num, u32 pba_num_size)
-{
-	u16 pba_ptr, offset, length, data;
-	int ret_val;
-
-	if (!pba_num) {
-		wx_err(wx, "PBA string buffer was null\n");
-		return -EINVAL;
-	}
-
-	ret_val = wx_read_ee_hostif(wx,
-				    wx->eeprom.sw_region_offset + TXGBE_PBANUM0_PTR,
-				    &data);
-	if (ret_val != 0) {
-		wx_err(wx, "NVM Read Error\n");
-		return ret_val;
-	}
-
-	ret_val = wx_read_ee_hostif(wx,
-				    wx->eeprom.sw_region_offset + TXGBE_PBANUM1_PTR,
-				    &pba_ptr);
-	if (ret_val != 0) {
-		wx_err(wx, "NVM Read Error\n");
-		return ret_val;
-	}
-
-	/* if data is not ptr guard the PBA must be in legacy format which
-	 * means pba_ptr is actually our second data word for the PBA number
-	 * and we can decode it into an ascii string
-	 */
-	if (data != TXGBE_PBANUM_PTR_GUARD) {
-		wx_err(wx, "NVM PBA number is not stored as string\n");
-
-		/* we will need 11 characters to store the PBA */
-		if (pba_num_size < 11) {
-			wx_err(wx, "PBA string buffer too small\n");
-			return -ENOMEM;
-		}
-
-		/* extract hex string from data and pba_ptr */
-		pba_num[0] = (data >> 12) & 0xF;
-		pba_num[1] = (data >> 8) & 0xF;
-		pba_num[2] = (data >> 4) & 0xF;
-		pba_num[3] = data & 0xF;
-		pba_num[4] = (pba_ptr >> 12) & 0xF;
-		pba_num[5] = (pba_ptr >> 8) & 0xF;
-		pba_num[6] = '-';
-		pba_num[7] = 0;
-		pba_num[8] = (pba_ptr >> 4) & 0xF;
-		pba_num[9] = pba_ptr & 0xF;
-
-		/* put a null character on the end of our string */
-		pba_num[10] = '\0';
-
-		/* switch all the data but the '-' to hex char */
-		for (offset = 0; offset < 10; offset++) {
-			if (pba_num[offset] < 0xA)
-				pba_num[offset] += '0';
-			else if (pba_num[offset] < 0x10)
-				pba_num[offset] += 'A' - 0xA;
-		}
-
-		return 0;
-	}
-
-	ret_val = wx_read_ee_hostif(wx, pba_ptr, &length);
-	if (ret_val != 0) {
-		wx_err(wx, "NVM Read Error\n");
-		return ret_val;
-	}
-
-	if (length == 0xFFFF || length == 0) {
-		wx_err(wx, "NVM PBA number section invalid length\n");
-		return -EINVAL;
-	}
-
-	/* check if pba_num buffer is big enough */
-	if (pba_num_size  < (((u32)length * 2) - 1)) {
-		wx_err(wx, "PBA string buffer too small\n");
-		return -ENOMEM;
-	}
-
-	/* trim pba length from start of string */
-	pba_ptr++;
-	length--;
-
-	for (offset = 0; offset < length; offset++) {
-		ret_val = wx_read_ee_hostif(wx, pba_ptr + offset, &data);
-		if (ret_val != 0) {
-			wx_err(wx, "NVM Read Error\n");
-			return ret_val;
-		}
-		pba_num[offset * 2] = (u8)(data >> 8);
-		pba_num[(offset * 2) + 1] = (u8)(data & 0xFF);
-	}
-	pba_num[offset * 2] = '\0';
-
-	return 0;
-}
-
 /**
  *  txgbe_calc_eeprom_checksum - Calculates and returns the checksum
  *  @wx: pointer to hardware structure
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h
index abc729eb187a..1f3ecf60e3c4 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h
@@ -6,7 +6,6 @@
 
 int txgbe_disable_sec_tx_path(struct wx *wx);
 void txgbe_enable_sec_tx_path(struct wx *wx);
-int txgbe_read_pba_string(struct wx *wx, u8 *pba_num, u32 pba_num_size);
 int txgbe_validate_eeprom_checksum(struct wx *wx, u16 *checksum_val);
 int txgbe_reset_hw(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 394f699c51da..70f0b5c01dac 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -540,7 +540,6 @@ static int txgbe_probe(struct pci_dev *pdev,
 	u16 eeprom_verh = 0, eeprom_verl = 0, offset = 0;
 	u16 eeprom_cfg_blkh = 0, eeprom_cfg_blkl = 0;
 	u16 build = 0, major = 0, patch = 0;
-	u8 part_str[TXGBE_PBANUM_LENGTH];
 	u32 etrack_id = 0;
 
 	err = pci_enable_device_mem(pdev);
@@ -738,13 +737,6 @@ static int txgbe_probe(struct pci_dev *pdev,
 	else
 		dev_warn(&pdev->dev, "Failed to enumerate PF devices.\n");
 
-	/* First try to read PBA as a string */
-	err = txgbe_read_pba_string(wx, part_str, TXGBE_PBANUM_LENGTH);
-	if (err)
-		strncpy(part_str, "Unknown", TXGBE_PBANUM_LENGTH);
-
-	netif_info(wx, probe, netdev, "%pM\n", netdev->dev_addr);
-
 	return 0;
 
 err_remove_phy:
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 51199c355f95..3ba9ce43f394 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -88,9 +88,6 @@
 #define TXGBE_XPCS_IDA_ADDR                     0x13000
 #define TXGBE_XPCS_IDA_DATA                     0x13004
 
-/* Part Number String Length */
-#define TXGBE_PBANUM_LENGTH                     32
-
 /* Checksum and EEPROM pointers */
 #define TXGBE_EEPROM_LAST_WORD                  0x800
 #define TXGBE_EEPROM_CHECKSUM                   0x2F
@@ -98,9 +95,6 @@
 #define TXGBE_EEPROM_VERSION_L                  0x1D
 #define TXGBE_EEPROM_VERSION_H                  0x1E
 #define TXGBE_ISCSI_BOOT_CONFIG                 0x07
-#define TXGBE_PBANUM0_PTR                       0x05
-#define TXGBE_PBANUM1_PTR                       0x06
-#define TXGBE_PBANUM_PTR_GUARD                  0xFAFA
 
 #define TXGBE_MAX_MSIX_VECTORS          64
 #define TXGBE_MAX_FDIR_INDICES          63
-- 
2.27.0



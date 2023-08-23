Return-Path: <netdev+bounces-30021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD804785A57
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B8B1C20CD0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897D7C2E7;
	Wed, 23 Aug 2023 14:22:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436BC2C3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:22:41 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2159.outbound.protection.outlook.com [40.92.62.159])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00BBE50
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UheIhYEEBs7EzRyjZCPVUXtrjeNoC3WzTyX1bAVhhO/6bdyJtHdbG5g0A6AvWUg+cHKBcVKkSmpC06i3fY58W9nfPtypqibA1Cu/U8UGXLzVbgD43OYwz82AgHLHdxHCy9ZKK+MopOgSYf62c9BHetW1AgVexF7TFwyvmqj5t9iywgZPVbtEnQcJy5VQSKvVd0sAChGCd2mTcFMVzLFNy8XGvBzAabPI+E4eLhdaB6EK1kvbIUTTaU521vQC5HMhOuCGVHEu1++mzp04h4sc6PIwxzlWMSeUjNSp+eAWm5hs/hthXjFI+fCuxmDSLtsLO8+KSjbEAQPecJWm5iUPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjMj94HL561mF/0YfuHeT5t60VbYlCwtJ+n5xnE6Oso=;
 b=HoBHAU2OyZkcYr+r3YZ/p/+aNzXfriOEKUZkXvqEsUsKuDfCo6SWZppKQLRGGa06Mix6tzRPucYjq+TMmuhuaWwBgc5rFMIP7q918Gil/OD3okxsUZzXwd28oNiI4JlKuzSklX/fGWPUR6FvnZXPWJjGe8D0Oq7KxclHQXq8FgKPiArsu5P0MPnfakxRE3UM95vRYIEPtIC4TEaevmdM+NjEZFt8iPyiYmZmP5WNzc+agtxKTCd7q+piNqNmWoBQJ9k8k4xQZgKdVfQUc0svWyvq8sgLdtlR6js4PgA6Uo0p6JPpSkyHNH1jQVfZIeC6095nbzfVZbzMF6+nTenaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjMj94HL561mF/0YfuHeT5t60VbYlCwtJ+n5xnE6Oso=;
 b=aKG1d62vQBDPau7peWgBOzjnBUUxtbunHxYSl59GhE0Yy99L03H7flz2n2PJ3ZQ8wqupFjzrnwdh3i2lSvHC17DCE0e+fpm5K2AnpBCo618YeTcRhWlpZeJSRXd4WU/aozrjKURhW7D6f6CBzH39ugukBaipsol9C6WMFyLJbcVZZThawA+eqEN6F5Sgmz4opdsXNXpGpTeRwEA8ObFLhCRq4KGWL2bNZErbi7Izg1ypbz4YrivVQVFs9a7uXN0EyYh0JvTKmKHOPNVvG/THuZA3YIqq+8XPhEr7Oud4bHQp7tnNN0UwsR1Kbljv3Nw0l1mC79Jisf7SirIqYpWMJg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY6P282MB3375.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 14:22:32 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:22:32 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	ilpo.jarvinen@linux.intel.com,
	jesse.brandeburg@intel.com,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linuxwwan@intel.com,
	linuxwwan_5g@intel.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	soumya.prakash.mishra@intel.com,
	nmarupaka@google.com,
	vsankar@lenovo.com
Subject: [net-next v2 3/5] net: wwan: t7xx: Creates region & snapshot for coredump log collection
Date: Wed, 23 Aug 2023 22:21:27 +0800
Message-ID:
 <MEYP282MB26976673518A7A87C5AD9564BB1CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823142129.20566-1-songjinjian@hotmail.com>
References: <20230823142129.20566-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0oHY/R3ya40zgnFMPmpmuUVlW12VDoO9]
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230823142129.20566-4-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY6P282MB3375:EE_
X-MS-Office365-Filtering-Correlation-Id: 234390e2-8c00-4363-aae0-08dba3e463a8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Feo7sRE8Q1HhZFtqfYWbONj40p+2njToYUnXSy+Y++E+Zg1AtHEYocqJ8wTCYqA5YFwIHMqHznUMSjIkYJN7IbBz2mmI7aQ2vuR43GJkDsePL/RBTlAiTFuJiOA/ofX/eVgZLYD6Ly6FMe2Db/BXjQcDQo+IqBGzAvuW8i2AgBjrPGy/0u5ioeSIKhpViLWOwTduv/pa/PwNaqrCXf4d7k8TuCmYm1o0XIBpJPc1N4hp0szkEqtFqmscBnf5bem84+ZpxU2jcBpLi9oldBnbp/XOctsQJrKP1N60s9J+K7dgOHV7a4xPQQo2rlhFLYzTb225KUC39Y853NnTOXf0Pk6CwBpyEhYXuOzNvHxszDjkbSB+iT7+vBOqEtdjnB8mSPnksvoinif3CakPU0fAEohtaW3pKmpeZ736tdDa4I791PmaG1/Df+aP3+8s7/C1dLZfBK2lhpPukS6kG3l5LKP6cY+bBE8dJ0FN4M9UbXIwD4p59tPxvuZ+7BkCzLxGoKl/GdrUppuNVDLhxXS6rn8ni1Bv2qtAtgx5SOfmVROWSg1m3N+27WMl/c13nzpN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DUXQvvzyavSwdbNYcthuTRsoVFD2ZA/51F8tC/+MWfcLb64oJGAN0ADu9fdk?=
 =?us-ascii?Q?P6r379absiXUBzaQ5EYwpGLhzZA7DEjTqN8Um+Mk8KTEkeLFPYcLe5dje9ab?=
 =?us-ascii?Q?yI6t8sWOObq3Gp0YN6qXdCNuSYnwo4FilPLbnq9SNwgea9W6044MZhhk0xLj?=
 =?us-ascii?Q?MAVYgwy8HbIT21K/7/ryk0nr1j8bWnvPeH/3Er1I8ZByNw7j7x0/aG2VwKVP?=
 =?us-ascii?Q?yVWdGvEsEXT8NA/rKI4EHjWR3pGmtg6wnjCNZp0Kz95twEV4fBFpS4t6HXwD?=
 =?us-ascii?Q?7qh3mhwvpAOgyKaQCK6MI0JmmmGonwELEcEyn5weGkjRA940e9UUZY8mAfER?=
 =?us-ascii?Q?ZnLwpSeqtd+PhiISlhewGgzKOYxT5EBJRUm22FgvFHQvx1UVRyVbqlJBWa15?=
 =?us-ascii?Q?x9cVFyF2CYd6U5TTtlqOlkURA4E2w4NhvE7sqFfqAjN01hNobMq4LzsQYb5h?=
 =?us-ascii?Q?f2/u+GSw+MQTKmG9Qtn0iDKmS8Uc7VTYPkjXesBonqT36xWXKiWnEukwB23t?=
 =?us-ascii?Q?6cGfmPYRUcP3R2dDFPAdOfUrPAgNBluK0m2QTkK2skJdf7SKKk1gdnj59qM6?=
 =?us-ascii?Q?rewCtS8Udg7CKlscbkGIBo7omR984ItOret/e9XVhOJokaOIFfpnhgziSAi5?=
 =?us-ascii?Q?fd82+lhn+9DfJLFwYRPaIUd9CdR/w3TfNEBXGW1DM9xcjn5J6E06qeg4atgL?=
 =?us-ascii?Q?yl4NBJsYL2XYZp86dzVvFc3w6bxHCTPD2LU0FPXGdbu/aiXOULUYE1bFZcLN?=
 =?us-ascii?Q?VJ+vnmWG2ARPgLlCOqMdMweMlLzkh+ST7tiAzMBLWxWVZBL6RsiMQM3Z2IDr?=
 =?us-ascii?Q?eXVwEAZd89tPAnwsKVCels8HhffZp34YIADG+drvGBndpTYUpK8GZnZlcI1z?=
 =?us-ascii?Q?zSCRIIyFW+2iyoLANFIzL0DU/OQ7anRl5C364T20UmujnoP8VF/PmhIEWrgY?=
 =?us-ascii?Q?5uBlVOX830Fi3aXkKZQtmsjNDIrTGv49wAMcj3oBNBtqyULhkDZm/yMGWWfA?=
 =?us-ascii?Q?AoiPXJZkG6pOLcxJVvWk8ToLwobozUT1oDSqMgK+Z1cpc70nNq8fpboDw5a7?=
 =?us-ascii?Q?B83sXSMGn/rbzxaMyUVFvZZjhr/iiulIHc0CPygkwgmb6bZEwmvR5uGcW3Xy?=
 =?us-ascii?Q?OI1CDAwPimJs36mby2mNkWVQi1QKa6K4sKpX/8hUtzOjiUYNT1t8+8XUnhjh?=
 =?us-ascii?Q?dfyVMzFemHrZpZltD0oRW0BjDNM3lxZcpB4X+WnLjAKxfANdc+r225h5n5Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 234390e2-8c00-4363-aae0-08dba3e463a8
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:22:32.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3375
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jinjian Song <jinjian.song@fibocom.com>

Adds support for t7xx wwan device coredump collection using devlink.

In case of coredump collection when wwan device encounters an exception
it reboots & stays in fastboot mode for coredump collection by host driver.
On detecting exception state driver collects the core dump, creates the
devlink region & reports an event to user space application for dump
collection. The user space application invokes devlink region read command
for dump collection.

Below are the devlink commands used for coredump collection.

devlink region new pci/$BDF/mr_dump
devlink region read pci/$BDF/mr_dump snapshot $ID address $ADD length $LEN
devlink region del pci/$BDF/mr_dump snapshot $ID

Base on the v5 patch version of follown series:
'net: wwan: t7xx: fw flashing & coredump support'
(https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v2:
 * rename function name from devlink to flash_dump 
---
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c | 256 ++++++++++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h |  39 +++
 drivers/net/wwan/t7xx/t7xx_state_monitor.c   |   2 +
 3 files changed, 296 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
index 1129ef793798..b8ef3b7d7430 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
@@ -9,6 +9,11 @@
 #include "t7xx_port_ap_msg.h"
 #include "t7xx_port_flash_dump.h"
 
+static struct t7xx_dump_region_info t7xx_dump_region_infos[] = {
+	[T7XX_MRDUMP_INDEX] = {"mr_dump", T7XX_MRDUMP_SIZE},
+	[T7XX_LKDUMP_INDEX] = {"lk_dump", T7XX_LKDUMP_SIZE},
+};
+
 static int t7xx_flash_dump_port_read(struct t7xx_port *port, char *buf, size_t count)
 {
 	struct sk_buff *skb;
@@ -130,6 +135,151 @@ static int t7xx_flash_dump_fb_raw_command(char *cmd, struct t7xx_port *port, cha
 	return ret;
 }
 
+static int t7xx_flash_dump_fb_cmd_send(struct t7xx_port *port, char *cmd)
+{
+	int len = strlen(cmd);
+	int ret;
+
+	ret = t7xx_flash_dump_port_write(port, cmd, len);
+	if (ret == len)
+		return 0;
+
+	return ret;
+}
+
+static int t7xx_flash_dump_fb_get_core(struct t7xx_port *port)
+{
+	u32 mrd_mb = T7XX_MRDUMP_SIZE / (1024 * 1024);
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+	char mcmd[T7XX_FB_MCMD_SIZE + 1];
+	size_t offset_dlen = 0;
+	int clen, dlen, ret;
+
+	flash_dump->regions[T7XX_MRDUMP_INDEX].buf =
+		vmalloc(flash_dump->regions[T7XX_MRDUMP_INDEX].info->size);
+	if (!flash_dump->regions[T7XX_MRDUMP_INDEX].buf)
+		return -ENOMEM;
+
+	set_bit(T7XX_MRDUMP_STATUS, &flash_dump->status);
+	ret = t7xx_flash_dump_fb_raw_command(T7XX_FB_CMD_OEM_MRDUMP, port, NULL);
+	if (ret) {
+		dev_err(port->dev, "%s command failed\n", T7XX_FB_CMD_OEM_MRDUMP);
+		goto free_mem;
+	}
+
+	while (flash_dump->regions[T7XX_MRDUMP_INDEX].info->size > offset_dlen) {
+		clen = t7xx_flash_dump_port_read(port, mcmd, sizeof(mcmd) - 1);
+		if (clen <= 0)
+			goto free_mem;
+
+		mcmd[clen] = '\0';
+		if (!strcmp(mcmd, T7XX_FB_CMD_RTS)) {
+			memset(mcmd, 0, sizeof(mcmd));
+			ret = t7xx_flash_dump_fb_cmd_send(port, T7XX_FB_CMD_CTS);
+			if (ret < 0) {
+				dev_err(port->dev, "write for _CTS failed:%zu\n",
+					strlen(T7XX_FB_CMD_CTS));
+				goto free_mem;
+			}
+
+			dlen = t7xx_flash_dump_port_read(port,
+							 flash_dump->regions[T7XX_MRDUMP_INDEX].buf
+							 + offset_dlen, T7XX_FB_MDATA_SIZE);
+			if (dlen <= 0) {
+				dev_err(port->dev, "read data error(%d)\n", dlen);
+				ret = dlen;
+				goto free_mem;
+			}
+			offset_dlen += dlen;
+
+			ret = t7xx_flash_dump_fb_cmd_send(port, T7XX_FB_CMD_FIN);
+			if (ret < 0) {
+				dev_err(port->dev, "_FIN failed, (Read %05zu:%05zu)\n",
+					strlen(T7XX_FB_CMD_FIN), offset_dlen);
+				goto free_mem;
+			}
+			continue;
+		} else if (!strcmp(mcmd, T7XX_FB_RESP_MRDUMP_DONE)) {
+			dev_dbg(port->dev, "%s! size:%zd\n", T7XX_FB_RESP_MRDUMP_DONE, offset_dlen);
+			clear_bit(T7XX_MRDUMP_STATUS, &flash_dump->status);
+			return 0;
+		}
+		dev_err(port->dev, "getcore protocol error (read len %05d, response %s)\n",
+			clen, mcmd);
+		ret = -EPROTO;
+		goto free_mem;
+	}
+
+	dev_err(port->dev, "mrdump exceeds %uMB size. Discarded!\n", mrd_mb);
+
+free_mem:
+	vfree(flash_dump->regions[T7XX_MRDUMP_INDEX].buf);
+	clear_bit(T7XX_MRDUMP_STATUS, &flash_dump->status);
+	return ret;
+}
+
+static int t7xx_flash_dump_fb_dump_log(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+	struct t7xx_dump_region *lkdump_region;
+	char rsp[T7XX_FB_RESPONSE_SIZE];
+	int datasize = 0, ret;
+	size_t offset = 0;
+
+	if (flash_dump->status != T7XX_DEVLINK_IDLE) {
+		dev_err(&flash_dump->t7xx_dev->pdev->dev, "Modem is busy!\n");
+		return -EBUSY;
+	}
+
+	set_bit(T7XX_LKDUMP_STATUS, &flash_dump->status);
+	ret = t7xx_flash_dump_fb_raw_command(T7XX_FB_CMD_OEM_LKDUMP, port, rsp);
+	if (ret) {
+		dev_err(port->dev, "%s command returns failure\n", T7XX_FB_CMD_OEM_LKDUMP);
+		goto err_clear_bit;
+	}
+
+	ret = kstrtoint(rsp, 16, &datasize);
+	if (ret) {
+		dev_err(port->dev, "bad value\n");
+		goto err_clear_bit;
+	}
+
+	lkdump_region = &flash_dump->regions[T7XX_LKDUMP_INDEX];
+	if (datasize > lkdump_region->info->size) {
+		dev_err(port->dev, "lkdump size is more than %dKB. Discarded!\n",
+			T7XX_LKDUMP_SIZE / 1024);
+		ret = -EFBIG;
+		goto err_clear_bit;
+	}
+
+	lkdump_region->buf = vmalloc(lkdump_region->info->size);
+	if (!lkdump_region->buf) {
+		ret = -ENOMEM;
+		goto err_clear_bit;
+	}
+
+	while (datasize > 0) {
+		int dlen = t7xx_flash_dump_port_read(port, lkdump_region->buf + offset, datasize);
+
+		if (dlen <= 0) {
+			dev_err(port->dev, "lkdump read error ret = %d\n", dlen);
+			ret = dlen;
+			goto err_clear_bit;
+		}
+
+		datasize -= dlen;
+		offset += dlen;
+	}
+
+	dev_dbg(port->dev, "LKDUMP DONE! size:%zd\n", offset);
+	clear_bit(T7XX_LKDUMP_STATUS, &flash_dump->status);
+	return t7xx_flash_dump_fb_handle_response(port, NULL);
+
+err_clear_bit:
+	clear_bit(T7XX_LKDUMP_STATUS, &flash_dump->status);
+	return ret;
+}
+
 static int t7xx_flash_dump_fb_download_command(struct t7xx_port *port, size_t size)
 {
 	char download_command[T7XX_FB_COMMAND_SIZE];
@@ -355,6 +505,67 @@ static const struct devlink_ops devlink_flash_ops = {
 	.reload_up = t7xx_devlink_reload_up,
 };
 
+static int t7xx_flash_dump_region_snapshot(struct devlink *dl, const struct devlink_region_ops *ops,
+					   struct netlink_ext_ack *extack, u8 **data)
+{
+	struct t7xx_flash_dump *flash_dump = devlink_priv(dl);
+	struct t7xx_dump_region *region = ops->priv;
+	struct t7xx_port *port = flash_dump->port;
+	u8 *snapshot_mem;
+
+	if (flash_dump->status != T7XX_DEVLINK_IDLE)
+		return -EBUSY;
+
+	if (!strncmp(ops->name, "mr_dump", strlen("mr_dump"))) {
+		snapshot_mem = vmalloc(region->info->size);
+		memcpy(snapshot_mem, region->buf, region->info->size);
+		*data = snapshot_mem;
+	} else if (!strncmp(ops->name, "lk_dump", strlen("lk_dump"))) {
+		int ret;
+
+		ret = t7xx_flash_dump_fb_dump_log(port);
+		if (ret)
+			return ret;
+
+		*data = region->buf;
+	}
+
+	return 0;
+}
+
+static_assert(ARRAY_SIZE(t7xx_dump_region_infos) ==
+	      ARRAY_SIZE(((struct t7xx_flash_dump *)NULL)->regions));
+
+/* To create regions for dump files */
+static int t7xx_flash_dump_create_regions(struct t7xx_flash_dump *flash_dump)
+{
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(t7xx_dump_region_infos); i++) {
+		flash_dump->regions[i].info = &t7xx_dump_region_infos[i];
+		flash_dump->regions[i].ops.name = flash_dump->regions[i].info->name;
+		flash_dump->regions[i].ops.snapshot = t7xx_flash_dump_region_snapshot;
+		flash_dump->regions[i].ops.destructor = vfree;
+		flash_dump->regions[i].dlreg = devlink_region_create(flash_dump->ctx,
+								     &flash_dump->regions[i].ops,
+								     T7XX_MAX_SNAPSHOTS,
+								     t7xx_dump_region_infos[i].size
+								     );
+		if (IS_ERR(flash_dump->regions[i].dlreg)) {
+			ret = PTR_ERR(flash_dump->regions[i].dlreg);
+			dev_err(flash_dump->port->dev, "create region failed, err %d\n", ret);
+			while (i >= 0)
+				devlink_region_destroy(flash_dump->regions[i--].dlreg);
+
+			return ret;
+		}
+
+		flash_dump->regions[i].ops.priv = &flash_dump->regions[i];
+	}
+
+	return 0;
+}
+
 int t7xx_devlink_register(struct t7xx_pci_dev *t7xx_dev)
 {
 	union devlink_param_value value;
@@ -379,6 +590,14 @@ int t7xx_devlink_register(struct t7xx_pci_dev *t7xx_dev)
 	return 0;
 }
 
+static void t7xx_flash_dump_work(struct work_struct *work)
+{
+	struct t7xx_flash_dump *flash_dump;
+
+	flash_dump = container_of(work, struct t7xx_flash_dump, ws);
+	t7xx_flash_dump_fb_get_core(flash_dump->port);
+}
+
 void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev)
 {
 	struct devlink *dl_ctx = t7xx_dev->flash_dump->ctx;
@@ -399,29 +618,64 @@ void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev)
 static int t7xx_port_flash_dump_init(struct t7xx_port *port)
 {
 	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+	struct workqueue_struct *flash_dump_wq;
+	int rc;
+
+	flash_dump_wq = create_workqueue("t7xx_flash_dump");
+	if (!flash_dump_wq) {
+		dev_err(port->dev, "create_workqueue failed\n");
+		return -ENODATA;
+	}
 
+	INIT_WORK(&flash_dump->ws, t7xx_flash_dump_work);
 	port->rx_length_th = T7XX_MAX_QUEUE_LENGTH;
 
 	flash_dump->mode = T7XX_NORMAL_MODE;
 	flash_dump->status = T7XX_DEVLINK_IDLE;
+	flash_dump->wq = flash_dump_wq;
 	flash_dump->port = port;
 
+	rc = t7xx_flash_dump_create_regions(flash_dump);
+	if (rc) {
+		destroy_workqueue(flash_dump->wq);
+		dev_err(port->dev, "devlink region creation failed, rc %d\n", rc);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
 static void t7xx_port_flash_dump_uninit(struct t7xx_port *port)
 {
 	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+	int i;
+
+	vfree(flash_dump->regions[T7XX_MRDUMP_INDEX].buf);
 
 	flash_dump->mode = T7XX_NORMAL_MODE;
+	destroy_workqueue(flash_dump->wq);
+
+	for (i = 0; i < ARRAY_SIZE(t7xx_dump_region_infos); ++i)
+		devlink_region_destroy(flash_dump->regions[i].dlreg);
 
 	skb_queue_purge(&port->rx_skb_list);
 }
 
+static int t7xx_flash_dump_enable_chl(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+
+	t7xx_port_enable_chl(port);
+	if (flash_dump->mode == T7XX_FB_DUMP_MODE)
+		queue_work(flash_dump->wq, &flash_dump->ws);
+
+	return 0;
+}
+
 struct port_ops flash_dump_port_ops = {
 	.init = &t7xx_port_flash_dump_init,
 	.recv_skb = &t7xx_port_enqueue_skb,
 	.uninit = &t7xx_port_flash_dump_uninit,
-	.enable_chl = &t7xx_port_enable_chl,
+	.enable_chl = &t7xx_flash_dump_enable_chl,
 	.disable_chl = &t7xx_port_disable_chl,
 };
diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
index 7614c01dcb2c..90758baa7854 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
@@ -12,28 +12,67 @@
 #define T7XX_MAX_QUEUE_LENGTH 32
 #define T7XX_FB_COMMAND_SIZE  64
 #define T7XX_FB_RESPONSE_SIZE 512
+#define T7XX_FB_MCMD_SIZE     64
+#define T7XX_FB_MDATA_SIZE    1024
 #define T7XX_FB_RESP_COUNT    30
 
+#define T7XX_FB_EVENT_SIZE      50
+
+#define T7XX_MAX_SNAPSHOTS  1
+#define T7XX_MRDUMP_SIZE    (160 * 1024 * 1024)
+#define T7XX_LKDUMP_SIZE    (256 * 1024)
+#define T7XX_TOTAL_REGIONS  2
+
 #define T7XX_FLASH_STATUS   0
+#define T7XX_MRDUMP_STATUS  1
+#define T7XX_LKDUMP_STATUS  2
 #define T7XX_GET_INFO       3
 
 #define T7XX_DEVLINK_IDLE   0
 #define T7XX_NORMAL_MODE    0
 #define T7XX_FB_DL_MODE     1
+#define T7XX_FB_DUMP_MODE   2
 
+#define T7XX_FB_CMD_RTS          "_RTS"
+#define T7XX_FB_CMD_CTS          "_CTS"
+#define T7XX_FB_CMD_FIN          "_FIN"
+#define T7XX_FB_CMD_OEM_MRDUMP   "oem mrdump"
+#define T7XX_FB_CMD_OEM_LKDUMP   "oem dump_pllk_log"
 #define T7XX_FB_CMD_DOWNLOAD     "download"
 #define T7XX_FB_CMD_FLASH        "flash"
 #define T7XX_FB_CMD_REBOOT       "reboot"
+#define T7XX_FB_RESP_MRDUMP_DONE "MRDUMP08_DONE"
 #define T7XX_FB_RESP_OKAY        "OKAY"
 #define T7XX_FB_RESP_FAIL        "FAIL"
 #define T7XX_FB_RESP_DATA        "DATA"
 #define T7XX_FB_RESP_INFO        "INFO"
 #define T7XX_FB_CMD_GET_VER      "get_version"
 
+/* Internal region indexes */
+enum t7xx_regions {
+	T7XX_MRDUMP_INDEX,
+	T7XX_LKDUMP_INDEX,
+};
+
+struct t7xx_dump_region_info {
+	const char *name;
+	size_t size;
+};
+
+struct t7xx_dump_region {
+	struct t7xx_dump_region_info *info;
+	struct devlink_region_ops ops;
+	struct devlink_region *dlreg;
+	void *buf;
+};
+
 struct t7xx_flash_dump {
 	struct t7xx_pci_dev *t7xx_dev;
 	struct t7xx_port *port;
 	struct devlink *ctx;
+	struct t7xx_dump_region regions[T7XX_TOTAL_REGIONS];
+	struct workqueue_struct *wq;
+	struct work_struct ws;
 	unsigned long status;
 	u8 mode;
 };
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 24f79e981fd9..86cdb0d572d4 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -244,6 +244,8 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 
 		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
 			md->t7xx_dev->flash_dump->mode = T7XX_FB_DL_MODE;
+		else
+			md->t7xx_dev->flash_dump->mode = T7XX_FB_DUMP_MODE;
 
 		port->port_conf->ops->enable_chl(port);
 		t7xx_cldma_start(md_ctrl);
-- 
2.34.1



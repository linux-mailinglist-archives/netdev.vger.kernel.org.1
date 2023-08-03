Return-Path: <netdev+bounces-23865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6347576DE5E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE141C2142E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199546A7;
	Thu,  3 Aug 2023 02:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67A187B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:40:28 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2188.outbound.protection.outlook.com [40.92.62.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446B8E43
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+RDnUGf83cn8bw1OeGt8hxFZG8maMSMDJg86AHkBgZKn/nf/48lKJM+AHdKOHVBODQIWlA/R/kcdbL02ru+GChUqTgwEUBG6fYxnuDwkcGXOJrsnNt5UGiNyTUJz2WFNCDxaXjfwXm0ofO7T4uqfneSqvzv1f38xUAq16CU9gtqTlkD+Vz1gcWE6yOEwK08uXui0j2KlVMO9bolDKc032ihk04GqshaVjwzvz24RLz0kQQWozoNkvRYrIiXzRj/V8GuNkpIgWtD9x538Zv6UiSa/sqnicGr3PTul2xYzelThaSBmdQlv2TgpzXG86woC7uaqmRm5dh72VzEgpVDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrapQZ9Ih4OGdoFEKKqr/woU2Sun4sNecZ7ducLsbWk=;
 b=Xi7qts4SCOyu3uOKX909wmOK3NksDvmDfILs94TTJiZ9+tpZ4lzq1kcZ+rfCDyR/JnZaEw7PBrcvWPjR71aKX1zy3/110NTDiUirzE40X5omLgtmZfIr1Apg7SKjAdBKyry1mcwWNbduxPS/XDboNxhFcJtGQOaaX5TRo3K94bkyVZODypGYPJJaCiqQqpvKgpotMbmS1pXhhwItfiYEs9XBqEvWypiEpaYsO6HgXYxRx/7NS+lzb6U9Wsqm+uJQg4RUlXeMbRuwRErTkrqsD/AtevM5654c+9jX8teoUrRXHAOxNOEl2oDEL1mcZTqnCGYEEZ7MMTMjBwBJ1iFVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrapQZ9Ih4OGdoFEKKqr/woU2Sun4sNecZ7ducLsbWk=;
 b=ul9or5HPbcJwMPpuIYJxOyDADqRmCq1/nd82Cm1G8hYzLKK3MaCwpfcoQMmt9cdwmS2w7vOryGRjhU/2xKDTGQcpJpGqwG4BRmdYnjSmcF9Ina+WgiXs9aeLauyK1prRidXdBQCct7TBlC0uv74spDAHWBVA3ZxoG/zLG4rP1rn/VKvMBPVThRQzfDk+1bHfILZcJUruj927sajmgbDLvUgFv/S5WjE8pV4ECP1+tlFkwOjfETX6HCrlCYo5y/WqI8USI+lLchzcy8i2be7hHv/EDRQv+Xo735jOoGtNmIhahukJbhK7sTuxjKQyxhXvPZBNyGgIAI/25YoIN4VoPw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB3585.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:186::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 02:40:19 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 02:40:19 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	johannes@sipsolutions.net,
	ryazanov.s.a@gmail.com,
	loic.poulain@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	edumazet@google.com,
	pabeni@redhat.com,
	chandrashekar.devegowda@intel.com,
	m.chetan.kumar@linux.intel.com,
	linuxwwan@intel.com,
	linuxwwan_5g@intel.com,
	soumya.prakash.mishra@intel.com,
	jesse.brandeburg@intel.com,
	danielwinkler@google.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next 4/6] net: wwan: t7xx: Creates region & snapshot for coredump log collection
Date: Thu,  3 Aug 2023 10:39:56 +0800
Message-ID:
 <MEYP282MB26974C67AA4F60DB387DE19ABB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [koObQfEkmSzVqDXScuwsE632XlzfOcoO]
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230803023956.3448-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB3585:EE_
X-MS-Office365-Filtering-Correlation-Id: bc986b7c-15ee-4076-08dc-08db93caf966
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ftFNnG/wtUC92DYtHM5geaQXLY/2gTztx3KLE047rVn5adSeRDEEvExgCHBzMFuv3Ls34ezB4oEuYBN2sjzPGlpxQLNC9rKglWoabSZeYHj8G3KK+xftjLESQVQxkILB23i6uGL/xY8UcK//Jc8qURELPS/Cgj5uiCybJwOLSNyl+StWkov+iogtHS4b/tUjiljO1zL1QL3bi+PlgDVu/HWowIZRrfBLrAEAQ1cjttL/MxRWhkF49GFgBn9FqsPTvgvfvdvK1XBRJqdJ/TkLiziUDIjL6VK85tUkGrzDMAh+ljmJxbVuyx1tRsTKusdcddkYFYdF5fL5adkWf9vL6wEEuSnjoGlxRh9p6XRb+Wip0o/ur6gUNNUp4TAsRMPgwdCz65o1kb+uyV8brTq6sq47mKM65OZToQD3Xoc3CKJVcjMBiPPWfBl9B95wJzokY+8e8tOu29erKrhyxWJqp7cIAVpQZSn5ZEig8r+nws+D5atP++MWn5NXQLQYQXboBwBF/4Mf+fRZOlYSjshI0ttOD8HRBwDNOxsqlnY3W08=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6djbs7T/Zt/2rkp2seBvWi7RW2+86H15CPPoqEOXFCejzL+7dnxHq82uTO0P?=
 =?us-ascii?Q?NKdjKiVY5DRw9EZKqvY+Fkf7GztkZ7KGbHqlM14pLbYUq+JG/1nIEWCf16tW?=
 =?us-ascii?Q?RoUPmdFYzKrk+0mHsb4ZeY6IjZXC0NJ4f6RRBAk8BL5NAvEnBmG05xcc4sYl?=
 =?us-ascii?Q?opMo6ZMlYcOggba/HeiFze3YJqsFxL5YK6Ow3QADmsVtEUpBl3WeSxVL0KgM?=
 =?us-ascii?Q?IfzyJmQdR3oTnHXKSiZWIXClOCzlq4g8iRL7pKnqpCJ/xSzwqyvCsFjUppxV?=
 =?us-ascii?Q?KKunxus3rq93GCLK9fZSBLZXAfub5OM2j8lACwYlsiDiDTNYHJdviIrxth6r?=
 =?us-ascii?Q?JbfWIEzN08tz5WYakCZ50dgvRTMswdcWTT/j72vpaTY6+n+1YJYXp6m0u8pP?=
 =?us-ascii?Q?ctDfbbIKuYk1hUwTwoUAIW5XAITmNSM99spLnKCEirNT6u3fpoO15oV2/EJI?=
 =?us-ascii?Q?mJIX9ft5Y/KE9imICs0i4KauipDSvWKC2+zfTc65oRL4rPso7lr5IzHlSLa/?=
 =?us-ascii?Q?zJresFWSIqesKRW1ilWBq6xJRNq3nYNxbGstYhPNCnxzUWfIGn03I/WGh+2g?=
 =?us-ascii?Q?ggYVGPV97nhdsLl+vrGCY1uDlmrkyHXaw5wXudGG8cS17slqUAxuZgRv5fFU?=
 =?us-ascii?Q?EqOnqXLAuhyi1oFpcvkk3+Zl6jDpLA1MwW2UVOro87o2wUVpyVaO448u5amh?=
 =?us-ascii?Q?V6a5MgEOpq6AkAYEfByGyFL1KJjK3R+fATbMBkOB241TrJOyWZ1rGdvCB5Uu?=
 =?us-ascii?Q?jhPOoPOHLnrAsXC7WdKH7UJ7akGASL/yTAlBqDjN5Ceu1yFBc09K1h37iGm3?=
 =?us-ascii?Q?XFaQntl40YJkSngNuiImpTmdjTLQN02tScaUmeiAKOQMKdQfDjszsmOjwk7l?=
 =?us-ascii?Q?RIyii3avFvPGA941n0QHdlrHc9cXa/MBmmUbEG9uyd9WT+t+uTFHwFVEjSin?=
 =?us-ascii?Q?ANBAa3XG9F1Nw46tvTxM12UM3TJd3t2hzQe2CkfcSmF6Y6mxKmUWN0USjMyK?=
 =?us-ascii?Q?pTV5tWxxfBe1fu7WzkMAG0Mfx0/lKMq0wCgAUESaDZDnlVue4LeCcic+6O3K?=
 =?us-ascii?Q?czoJ4yVnxzGkImN/u2NDuxtBJ42GTVOX122OCkledY0ax8XDv2hsEg6kz42N?=
 =?us-ascii?Q?B1DKZuEnn2cRag5lKKd+uw2c1UHuTB2fPlRHqEcK1eSQ7WKezzM9qKUvRgCP?=
 =?us-ascii?Q?3k9MnyldTZMuwxbAXtN44repAwXf68QFy066Pbt3l3r1S2+bMtAnyKmTf50?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bc986b7c-15ee-4076-08dc-08db93caf966
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:40:19.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/net/wwan/t7xx/t7xx_port_devlink.c  | 243 +++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_devlink.h  |  41 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c |   2 +
 3 files changed, 285 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.c b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
index f10804a2c0d7..0949809aa219 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_devlink.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
@@ -9,6 +9,11 @@
 #include "t7xx_port_ap_msg.h"
 #include "t7xx_port_devlink.h"
 
+static struct t7xx_devlink_region_info t7xx_devlink_region_infos[] = {
+	[T7XX_MRDUMP_INDEX] = {"mr_dump", T7XX_MRDUMP_SIZE},
+	[T7XX_LKDUMP_INDEX] = {"lk_dump", T7XX_LKDUMP_SIZE},
+};
+
 static int t7xx_devlink_port_read(struct t7xx_port *port, char *buf, size_t count)
 {
 	struct sk_buff *skb;
@@ -177,6 +182,149 @@ static int t7xx_devlink_fb_flash_partition(struct t7xx_port *port, const char *p
 	return t7xx_devlink_fb_flash(port, partition);
 }
 
+static int t7xx_devlink_fb_cmd_send(struct t7xx_port *port, char *cmd)
+{
+	int len = strlen(cmd);
+	int ret;
+
+	ret = t7xx_devlink_port_write(port, cmd, len);
+	if (ret == len)
+		return 0;
+
+	return ret;
+}
+
+static int t7xx_devlink_fb_get_core(struct t7xx_port *port)
+{
+	u32 mrd_mb = T7XX_MRDUMP_SIZE / (1024 * 1024);
+	struct t7xx_devlink *dl = port->t7xx_dev->dl;
+	char mcmd[T7XX_FB_MCMD_SIZE + 1];
+	size_t offset_dlen = 0;
+	int clen, dlen, ret;
+
+	dl->regions[T7XX_MRDUMP_INDEX].buf = vmalloc(dl->regions[T7XX_MRDUMP_INDEX].info->size);
+	if (!dl->regions[T7XX_MRDUMP_INDEX].buf)
+		return -ENOMEM;
+
+	set_bit(T7XX_MRDUMP_STATUS, &dl->status);
+	ret = t7xx_devlink_fb_raw_command(T7XX_FB_CMD_OEM_MRDUMP, port, NULL);
+	if (ret) {
+		dev_err(port->dev, "%s command failed\n", T7XX_FB_CMD_OEM_MRDUMP);
+		goto free_mem;
+	}
+
+	while (dl->regions[T7XX_MRDUMP_INDEX].info->size > offset_dlen) {
+		clen = t7xx_devlink_port_read(port, mcmd, sizeof(mcmd) - 1);
+		if (clen <= 0)
+			goto free_mem;
+
+		mcmd[clen] = '\0';
+		if (!strcmp(mcmd, T7XX_FB_CMD_RTS)) {
+			memset(mcmd, 0, sizeof(mcmd));
+			ret = t7xx_devlink_fb_cmd_send(port, T7XX_FB_CMD_CTS);
+			if (ret < 0) {
+				dev_err(port->dev, "write for _CTS failed:%zu\n",
+					strlen(T7XX_FB_CMD_CTS));
+				goto free_mem;
+			}
+
+			dlen = t7xx_devlink_port_read(port, dl->regions[T7XX_MRDUMP_INDEX].buf +
+						      offset_dlen, T7XX_FB_MDATA_SIZE);
+			if (dlen <= 0) {
+				dev_err(port->dev, "read data error(%d)\n", dlen);
+				ret = dlen;
+				goto free_mem;
+			}
+			offset_dlen += dlen;
+
+			ret = t7xx_devlink_fb_cmd_send(port, T7XX_FB_CMD_FIN);
+			if (ret < 0) {
+				dev_err(port->dev, "_FIN failed, (Read %05zu:%05zu)\n",
+					strlen(T7XX_FB_CMD_FIN), offset_dlen);
+				goto free_mem;
+			}
+			continue;
+		} else if (!strcmp(mcmd, T7XX_FB_RESP_MRDUMP_DONE)) {
+			dev_dbg(port->dev, "%s! size:%zd\n", T7XX_FB_RESP_MRDUMP_DONE, offset_dlen);
+			clear_bit(T7XX_MRDUMP_STATUS, &dl->status);
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
+	vfree(dl->regions[T7XX_MRDUMP_INDEX].buf);
+	clear_bit(T7XX_MRDUMP_STATUS, &dl->status);
+	return ret;
+}
+
+static int t7xx_devlink_fb_dump_log(struct t7xx_port *port)
+{
+	struct t7xx_devlink *dl = port->t7xx_dev->dl;
+	struct t7xx_devlink_region *lkdump_region;
+	char rsp[T7XX_FB_RESPONSE_SIZE];
+	int datasize = 0, ret;
+	size_t offset = 0;
+
+	if (dl->status != T7XX_DEVLINK_IDLE) {
+		dev_err(&dl->t7xx_dev->pdev->dev, "Modem is busy!\n");
+		return -EBUSY;
+	}
+
+	set_bit(T7XX_LKDUMP_STATUS, &dl->status);
+	ret = t7xx_devlink_fb_raw_command(T7XX_FB_CMD_OEM_LKDUMP, port, rsp);
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
+	lkdump_region = &dl->regions[T7XX_LKDUMP_INDEX];
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
+		int dlen = t7xx_devlink_port_read(port, lkdump_region->buf + offset, datasize);
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
+	clear_bit(T7XX_LKDUMP_STATUS, &dl->status);
+	return t7xx_devlink_fb_handle_response(port, NULL);
+
+err_clear_bit:
+	clear_bit(T7XX_LKDUMP_STATUS, &dl->status);
+	return ret;
+}
+
 static int t7xx_devlink_flash_update(struct devlink *devlink,
 				     struct devlink_flash_update_params *params,
 				     struct netlink_ext_ack *extack)
@@ -387,6 +535,65 @@ static const struct devlink_ops devlink_flash_ops = {
 	.reload_up = t7xx_devlink_reload_up,
 };
 
+static int t7xx_devlink_region_snapshot(struct devlink *dl, const struct devlink_region_ops *ops,
+					struct netlink_ext_ack *extack, u8 **data)
+{
+	struct t7xx_devlink *t7xx_dl = devlink_priv(dl);
+	struct t7xx_devlink_region *region = ops->priv;
+	struct t7xx_port *port = t7xx_dl->port;
+	u8 *snapshot_mem;
+
+	if (t7xx_dl->status != T7XX_DEVLINK_IDLE)
+		return -EBUSY;
+
+	if (!strncmp(ops->name, "mr_dump", strlen("mr_dump"))) {
+		snapshot_mem = vmalloc(region->info->size);
+		memcpy(snapshot_mem, region->buf, region->info->size);
+		*data = snapshot_mem;
+	} else if (!strncmp(ops->name, "lk_dump", strlen("lk_dump"))) {
+		int ret;
+
+		ret = t7xx_devlink_fb_dump_log(port);
+		if (ret)
+			return ret;
+
+		*data = region->buf;
+	}
+
+	return 0;
+}
+
+static_assert(ARRAY_SIZE(t7xx_devlink_region_infos) ==
+	      ARRAY_SIZE(((struct t7xx_devlink *)NULL)->regions));
+
+/* To create regions for dump files */
+static int t7xx_devlink_create_regions(struct t7xx_devlink *dl)
+{
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(t7xx_devlink_region_infos); i++) {
+		dl->regions[i].info = &t7xx_devlink_region_infos[i];
+		dl->regions[i].ops.name = dl->regions[i].info->name;
+		dl->regions[i].ops.snapshot = t7xx_devlink_region_snapshot;
+		dl->regions[i].ops.destructor = vfree;
+		dl->regions[i].dlreg = devlink_region_create(dl->ctx, &dl->regions[i].ops,
+							     T7XX_MAX_SNAPSHOTS,
+							     t7xx_devlink_region_infos[i].size);
+		if (IS_ERR(dl->regions[i].dlreg)) {
+			ret = PTR_ERR(dl->regions[i].dlreg);
+			dev_err(dl->port->dev, "create devlink region failed, err %d\n", ret);
+			while (i >= 0)
+				devlink_region_destroy(dl->regions[i--].dlreg);
+
+			return ret;
+		}
+
+		dl->regions[i].ops.priv = &dl->regions[i];
+	}
+
+	return 0;
+}
+
 int t7xx_devlink_register(struct t7xx_pci_dev *t7xx_dev)
 {
 	union devlink_param_value value;
@@ -422,6 +629,14 @@ void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev)
 	devlink_free(dl_ctx);
 }
 
+static void t7xx_devlink_work(struct work_struct *work)
+{
+	struct t7xx_devlink *dl;
+
+	dl = container_of(work, struct t7xx_devlink, ws);
+	t7xx_devlink_fb_get_core(dl->port);
+}
+
 /**
  * t7xx_devlink_init - Initialize devlink to t7xx driver
  * @port: Pointer to port structure
@@ -431,28 +646,56 @@ void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev)
 static int t7xx_devlink_init(struct t7xx_port *port)
 {
 	struct t7xx_devlink *dl = port->t7xx_dev->dl;
+	struct workqueue_struct *dl_wq;
+	int rc;
+
+	dl_wq = create_workqueue("t7xx_devlink");
+	if (!dl_wq) {
+		dev_err(port->dev, "create_workqueue failed\n");
+		return -ENODATA;
+	}
 
+	INIT_WORK(&dl->ws, t7xx_devlink_work);
 	port->rx_length_th = T7XX_MAX_QUEUE_LENGTH;
 
 	dl->mode = T7XX_NORMAL_MODE;
 	dl->status = T7XX_DEVLINK_IDLE;
+	dl->wq = dl_wq;
 	dl->port = port;
 
+	rc = t7xx_devlink_create_regions(dl);
+	if (rc) {
+		destroy_workqueue(dl->wq);
+		dev_err(port->dev, "devlink region creation failed, rc %d\n", rc);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
 static void t7xx_devlink_uninit(struct t7xx_port *port)
 {
 	struct t7xx_devlink *dl = port->t7xx_dev->dl;
+	int i;
+
+	vfree(dl->regions[T7XX_MRDUMP_INDEX].buf);
 
 	dl->mode = T7XX_NORMAL_MODE;
+	destroy_workqueue(dl->wq);
+
+	for (i = 0; i < ARRAY_SIZE(t7xx_devlink_region_infos); ++i)
+		devlink_region_destroy(dl->regions[i].dlreg);
 
 	skb_queue_purge(&port->rx_skb_list);
 }
 
 static int t7xx_devlink_enable_chl(struct t7xx_port *port)
 {
+	struct t7xx_devlink *dl = port->t7xx_dev->dl;
+
 	t7xx_port_enable_chl(port);
+	if (dl->mode == T7XX_FB_DUMP_MODE)
+		queue_work(dl->wq, &dl->ws);
 
 	return 0;
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.h b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
index 92f0993e7205..e01845b4f2aa 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_devlink.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
@@ -12,27 +12,66 @@
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
-
 #define T7XX_DEVLINK_IDLE   0
+
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
+struct t7xx_devlink_region_info {
+	const char *name;
+	size_t size;
+};
+
+struct t7xx_devlink_region {
+	struct t7xx_devlink_region_info *info;
+	struct devlink_region_ops ops;
+	struct devlink_region *dlreg;
+	void *buf;
+};
+
 struct t7xx_devlink {
+	struct t7xx_devlink_region regions[T7XX_TOTAL_REGIONS];
 	struct t7xx_pci_dev *t7xx_dev;
+	struct workqueue_struct *wq;
 	struct t7xx_port *port;
+	struct work_struct ws;
 	struct devlink *ctx;
 	unsigned long status;
 	u8 mode;
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index a6147f2324a6..500dadaddb30 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -244,6 +244,8 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 
 		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
 			md->t7xx_dev->dl->mode = T7XX_FB_DL_MODE;
+		else
+			md->t7xx_dev->dl->mode = T7XX_FB_DUMP_MODE;
 
 		port->port_conf->ops->enable_chl(port);
 		t7xx_cldma_start(md_ctrl);
-- 
2.34.1



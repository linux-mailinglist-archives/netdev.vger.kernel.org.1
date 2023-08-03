Return-Path: <netdev+bounces-23870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8293476DEA0
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432971C213B7
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07996FDF;
	Thu,  3 Aug 2023 02:58:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB07460
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:58:49 +0000 (UTC)
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2171.outbound.protection.outlook.com [40.92.63.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126EE10A
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F20/KWC06ddCgj3hfiBUr3XLR2MJJClyCEj4fl4ro0pQqmy5Td8XQBTPGfAavPjmgD8J1vXUc7gQzXS+QHgHj/5Pcxb+tSp2MwEH4YTqmrH4hyg9FC7d9xb7vQQJJpZmuIrP+l8NxUPnrAtz9BMnYJuvbh+uwxKTC2XsRKzauzK5x+1PcBS2ZLoE65wzXPZHyS5gmu+6ghI8e3Ik6IKd28Brg5mz1qMYlM69Qb5g4k0TS8LI5kDdBwGXzZle/Wd1amFJfopiJGqmajt8l0V6TjrUIdWWHtFTxeU8+9jiVnTYNwMze0gT/OzIrzym5G5lNpiZNiKAZeYxnP1As02sgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrapQZ9Ih4OGdoFEKKqr/woU2Sun4sNecZ7ducLsbWk=;
 b=ZWIOWc87Eaa7JGNWM/h/+6o4XHwwLojtyefKQjp9d+uaSVdt6gOIdmtnse3hFPDQhDsOgGXrcu8q27/63EGuaZHG3cuHg0WPlQQm99/xuURIG9ZONv0doRN1vgRQ5z0pjL6IJqG9BJmjr2N/yFo6R3CUOHj6qkYf6WVxY/V7JPZm+sqLBajyz1DvsN1lXBpM0Le6I6KljCoCJoCTNAm0NSqfP8tFuOFSnUIyDYEiYvOQ4Y3srditg1fneIxcNW6aFEUSHgRylkakqW9fd4EKoEvQWPZHmRKSdw8USASRwNOF74sP4tlykjZarXCLdy2OWx6t5dM2p7doRiHlnDemuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrapQZ9Ih4OGdoFEKKqr/woU2Sun4sNecZ7ducLsbWk=;
 b=M9erqaiMs139moUXrkkk/zbgWMp58K0Tk5FfqIZ1hkH8cbEcaqU1hsokpwwngg9f2b703wfhwQsH0clAzhSRo7ceokMiI2hpU1le7R7PubU3KskFaI562XhtAnEdYkVMmBfnhvEPp8vK25lMAxru7kqKSC+411hlTpusqqjgeuAtEwOlS7FFEAaylVqUBw9tqpwJEtETpxmUq9Hrljr1Sk8iigDqvrTUXgnL1BYJIbrLg792YIxyuBXiVQnwrra9vVD3nVo7klmCscnF9BVYgdsnH3LyYgXLCliGWjkMkmxUMe05Gbmw7FPtv9m0r8vUCpVfaiot3j0McvADT0AjBA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:156::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 02:58:40 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 02:58:40 +0000
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
Date: Thu,  3 Aug 2023 10:58:00 +0800
Message-ID:
 <MEYP282MB2697F01D8438D2455E8A7DEBBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803025802.3534-1-songjinjian@hotmail.com>
References: <20230803025802.3534-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [AX8AcyoJe/JAHiSPOGe+wuvxT8ox+uT9]
X-ClientProxiedBy: TYAPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404::23)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230803025802.3534-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SYBP282MB2963:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ed30d7-d5d7-4b80-f33d-08db93cd8a0b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O4/JEu/3c/MsH3rfesdYYogS7EVtau1z87ZwHavXG3pIpGiZUzB1cDkgGz4KlxYRBSUXCDYO2NBgN8TRoYfPlkafSNiLilu2HC0CVjlYdlmGVxy6FVigH+XkBTudNYJmpFzG1f4W7h7CAlRVuDzw+9tC1V5WnKNE0O5yUmiq4nki+vYCaU5s5Y/YrkW6N7L1Trsd06CwbDkGiQsPEMUhOPSY/hxRaFDXV0yf5vLT6LAX5CRMJqEjFSCPLILyOYreAIq5Zw3Ba98qoeHdCpn+H/olgaqHcm9dyLKvTRipK5RJ/cclgR789qZlawleeoy1J/k1C5RH4ytH5Pahgeayu0gocNGK0ldpd6J9yqzzMjaVqsF7i+IWZ0Ojmqv7peGq5ML4QaZOnHLJ7u4Kj+LBpu/0RGRQATVxdo0U+XLuDds81ci1iuUXC3kw/Q9Y/+oQqkvWdj3GgLo7zR0EG0DjlggJM0qo2Bz7Y5autjSLIvAvusTFfmJZhPhrYZAgnLkWwYXIYtJnMg7b4+FIy5Ji8Qvd0phNJ/ZDpKqdMZPukqA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sv1QHPMZwCaIJQvKHvZbUlCbPGBgKOUsFKrOYrvdguHKjIB2GUWHO02315Nq?=
 =?us-ascii?Q?Ww85Fh12njSi4ZuDPpOnY5mzXg6z8bYL7JqmAD/qdDo1VFLC9qtRaRnKdjaw?=
 =?us-ascii?Q?q2er93kripwDakvRZAv0gB801jOtqOnIxZy55gEB6sUIvCoZVrIK/INI3GsC?=
 =?us-ascii?Q?xICXwwPNkVtpPhrYpTsYvRZIlqK+AJzPkJxVnVX7KkVTzTA+LK2neR5X1qgV?=
 =?us-ascii?Q?LQowmzyzBLZVM+zlWxpkrfAlNt7C1ipURIJbEA0t0f+g6iZ3yJik8y7TqzHp?=
 =?us-ascii?Q?hNzIRQMXG8FftywKFnFKmqjtOkLiOqEyM9T4606TAal6N4Gadz9r5yzU9ZMG?=
 =?us-ascii?Q?WTpOfJ1DtGs6moXduniYt1qkGlgx/WykdlY5dhLWhtnDUuT6E2hbZX17CJj0?=
 =?us-ascii?Q?H6r1qOH5GvtIVFAuAJBFASFeMl+av9KRiSkYstOUqHKWCakUHhhlTZXwrHiQ?=
 =?us-ascii?Q?CaNgN39yJkllQysFNsIq7O9sncyHTJGRNY0QFMAdwSOHr/1YZAMszaTzwryz?=
 =?us-ascii?Q?NBs7D4Nj/GhOpXBxXAoC9igvKqXXKI2SQ+UO8ZsnCARGhjzBhFTOPjhr0qt6?=
 =?us-ascii?Q?7A8eSf4q8xKao0n19Hfw4+TtyixPQQDNXFdhMhekG2yO7ph17TNRbvv6yLgJ?=
 =?us-ascii?Q?XEZ/XCzGeCV9SNykBFaZ1SGpBLR8D1RWA7F/AJVbZU9POxy8C6FB3a4H7k6R?=
 =?us-ascii?Q?XuJc8FnaU7BVvDy40GbFUDE2XR7/SOiQ0NnHP87Ih+yVYha8BkTh6cyjZBnk?=
 =?us-ascii?Q?bUzBnoAgWH47IqzwtYUcowYKxeCNZK2i3MVrh6iIZooQqA9f3vS6z2U/VpN8?=
 =?us-ascii?Q?zHNkhyc5O0y8JGpdwLf/i/xfvJt49HVCG2MG+ih/n/Q5WyubkNGUB73vJf9P?=
 =?us-ascii?Q?10Vunm3NVdxZiBUgJQAbUt26ZjtN0+RgDL5pYisoaegDNJMm1Rt8dGvG2M0I?=
 =?us-ascii?Q?zSrh/Y5buRWX6o03o85C6puMI2NS5oAsWj2ZN7hSy7q8UKK7864dNExbZZxW?=
 =?us-ascii?Q?HIv8iogiTQrxg6dHdCK0jiKfeo0AQhJLcNcDMKO9qDtxB8w3VIKj9mibhgra?=
 =?us-ascii?Q?66XmHCEfUuKKHGAPPrMVkbHRVCrxdow5GSrqKsJXDNKKFijZjuID6f+CBd7s?=
 =?us-ascii?Q?RgMK14q1euLPyDWVyQCd4q7dKncAqBUQakq5dNHEUsfFLeZyqn+EoBc6+vjM?=
 =?us-ascii?Q?pXr3TT3id6Ck6ebxWyGk0YPLMLDcUAtv7CblRmSfm1I09AtS5QPRVhkW+cA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ed30d7-d5d7-4b80-f33d-08db93cd8a0b
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:58:40.1123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB2963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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



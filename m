Return-Path: <netdev+bounces-38061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6C17B8DB8
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 81395B2047D
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6448F224C2;
	Wed,  4 Oct 2023 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q9wl8KHA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435B224C0
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 19:55:12 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDC7E4
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 12:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhtpBHs3T377txvhPPMcJ8Exd0hJJ+GUdlikM7r32cngNFXZd9kRHonbfVJMU3biS/6r5JTY3Kkzlc7VuUC0im/7dJ7u1mEkkm+fnQOdp8NjD9F8t/jeex7QwYfGdojdqCAvuRUI8mxu704u8qP82Q77R1ofWAeT4KaZaQHUGo4YM1TcR60v1gdpKpeD77EsMtViM0XFS7RAcnKx3IOXWNQ98vlnUbdcieaFnhTRBiKsZa9uRipT74tkIXd3LHRQI4yI2LMATacBRjPzLmNNEmHVln4hC50Ef8j5m+bGZAVtVhcoeKBegdZ3f+9LbWlPlmdsyVKHsoFTa/SERfkd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1URsWvGChyd1WJuUyEE9pd0O0npw4hIbvFI4BwkEAjk=;
 b=Fw+p3KJAgsk1gzP4zAJxIisK4FgZ4o1owQxuLEUsC1PCS2zcuPSPkIyaUK0pXTj4hxmfQbrMH74jRuI45U/L+wPF9cTB6lJLFPUz0T5ibA+vrHCDDdIacZ5gI+Qg7vMWVpmX7VEoZx2GMKgpqrYieLZQAKRNBINczTa1rGfJy/iC5+boyNk0XOqylFCk09DmWErqxLbNDE6Z4KEzzFYlGeeeuwWVhxmQXLq5/pHRJRhsDRE4N3e9GeEDJ5Lr247HL7iYy1KFO/oXVk+4+XQAkGv1s3Lobzdip4f8oO/tENS0eM8bXGvGnA+imGWb4LfGBbaLzryVqwy9NmiMUHJtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1URsWvGChyd1WJuUyEE9pd0O0npw4hIbvFI4BwkEAjk=;
 b=q9wl8KHAhLEN4S/6EVo7ubv9+wm0oMLw+08Gb23Yojh6UfKXj9q7I7Bk6ww9Hm5Q9UfvJZrInnO/XQPBM1eXdDb/ugp1ffsdt+7gsNSRNDlDEYkMAVVKg5Hg9XX16fTUzP7qvByf4/sJkHZlXOJz2yueAKehqbR67JDu4ux/zfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBAPR04MB7238.eurprd04.prod.outlook.com (2603:10a6:10:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 19:55:07 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::6f63:8268:88c3:2ea]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::6f63:8268:88c3:2ea%7]) with mapi id 15.20.6838.029; Wed, 4 Oct 2023
 19:55:07 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	imx@lists.linux.dev,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Mario Castaneda <mario.ignacio.castaneda.lopez@nxp.com>
Subject: [PATCH net] net: stmmac: dwmac-imx: request high frequency mode
Date: Wed,  4 Oct 2023 14:54:42 -0500
Message-Id: <20231004195442.414766-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DBAPR04MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 9232489a-497a-4990-5a35-08dbc513cf03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ucFObtZ68oavqQycXM+QH4M9uln+DtW9XwG8nbvSUprMDgKT9Cv4cIagHnV0zWxu9YRCFe58uNEcpBi/n+aDQXXCG/+f9Cj9RJz0k0W4yjQsr2v+X01hV7u6B+BAS7JpJaRRWwWduOVgABY2eA3kih4EOkuxKfCeFXmkNA68LDojBhMHYvt+mrRQTwk7OHAwDldb2XJUFZrvOfWL3YoEa4lzZ/0uQsWggZqHO4n8ZFXakwY8xyT2DtvZz3lqZt5NJj7xOwosD114Gme2TtoumApbqs+z8aDOjEV7rSn2o9td9+QViDhnY2wdtSN2DpEaKrZprbmBu9loWHXBDa/fXDqRYbmB4SxflPIHIk+jkaGXDXwSf92xZMz656F0N9j7DslHDjWBltWyVdwNIKZs5yB3HUCUmkpEht9/BCPaEFPEQQTkeoQn4YJbuK8t1CcRjFH+eVN9M2TUKl8IPaVnNI86xKRrREPxwqPYnVYDMWq7WubGgZuwHMhnX0aIStrMyvzxAzO4eyBan9bf48/VdsrU+n/Wf8q9wIQnvcwOL0mO1itrLE8oroEr+xWdYIksIeCDU6NgMuRhiCD3f16oz/eilgYb/6gFFO9/gRJjK58MGuNx0CfWtrBewL2mDlXF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(1076003)(2616005)(83380400001)(110136005)(4326008)(66946007)(54906003)(66476007)(66556008)(7416002)(2906002)(8936002)(316002)(6666004)(44832011)(8676002)(6512007)(6506007)(5660300002)(6486002)(41300700001)(52116002)(36756003)(86362001)(478600001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TJDalEUHYf5V30JfIlHFA5874m5Tys1EdxYYTLvINw8BhISfIZ0RrIRA9KyE?=
 =?us-ascii?Q?DoJ5JqrU9bY7BtG2Mio5l3iAeG5POnM1d5Khs++s4ZPepBxy0yLXftbyd5OF?=
 =?us-ascii?Q?gGmFg0pfqv6sEXIR9bt5pbVFq4HOLqmrm/pjfj/2AI1DDS75FOjG04ETCljt?=
 =?us-ascii?Q?cb9Fv4DSffWROUJZjriOj1xSw1F54AoUj0exjKzQR0kgYUWBTW1WPaUGMhen?=
 =?us-ascii?Q?sOAhFlrTYNowXWi219380e+qoz7/TDPrLWoQYrKuLyDQUkDypL7slTlLVY1d?=
 =?us-ascii?Q?1656avx5eIoyBFuJedBtwMwA3Prkhhz4Pmft1YlnAFB7zsZLnD5gYYL/IwNz?=
 =?us-ascii?Q?mXXItIpuFOf3+XQ8PYZnoKAvmGwmDHKRmr6hdkEG/hna5bkIWlbIbe50iIqk?=
 =?us-ascii?Q?+a2tpcqE8LCHIGBZIhZG7z354xlRtdp6gDszgjxyP7nZrghIAaykSY2IsO7U?=
 =?us-ascii?Q?BTazhFRZLbHt+WFW9hdbC8KYMyYYIY6dKWIzV4gn0Ysd15GhuPc2/23L60SZ?=
 =?us-ascii?Q?8ZRfc1cLQPDntC05GwXJxQdEij6FT4p0nJeIRPidhcR53hVi9bjSTCtB06ke?=
 =?us-ascii?Q?1riNLai6YfSmTL9/XVsY23n2Wv6OS4UkQQAbh/Leo5ZTK+yQtEPZRKaT6v14?=
 =?us-ascii?Q?MfDTR8rlIfsjqS0ggpQhpv1LpZ+uJcPLwiOivqIzbiOXseWxA+b/upBAzCdS?=
 =?us-ascii?Q?PiUxl085NZehm647olKuPCJ5aUFwFflL7pqDDvdnkFgi94XmTGaZEAL5+KYl?=
 =?us-ascii?Q?BT++dfTXe9dkh71BdhAjnT2knlyi2aUWL+qrHXoqb/QUYCdBKUdshIqr72Rt?=
 =?us-ascii?Q?OPdxi63ax8LBJfXEc50yPMsB09VbX2HnNw4Brtk6gTRKMXCe/rf7zikNfSuZ?=
 =?us-ascii?Q?iVNawenYB2oNP19e7FXG2rLhNlx+r68gEB5E5h2lxhlLbb3Uf9VQm0vZW+0k?=
 =?us-ascii?Q?IDTcMPCWSPUXtkwBsmCR1x3HFfbanJF8wCa20NuWUtyrb1gpwTbvmfYQ/yEw?=
 =?us-ascii?Q?J/vFQyhVhJS/wRCaa1W7kfhmeJVo+IV9zsnDpUIzSgVWAuPZv9A9WHKXOe2g?=
 =?us-ascii?Q?B4AowIxG/WW/0oCbWgIO1MxmHxrMndTTBN76/38BRQVrnJhl9aTSYDVDMwTI?=
 =?us-ascii?Q?/YVMm9t1geci07p7jQNewTsxjFXWeNkJDL5AbpQ6FI7m5wOPZ81VAZ6qJ3xb?=
 =?us-ascii?Q?e944WsFWUB4c1lIskmzae5KKy4CLBiwPHophP+CLDRhNVMb0HUruKczX11st?=
 =?us-ascii?Q?G1HWZGwTABsToZWu16sRYHOYEfbUACJQrG8ehIGyzOgeIy88E2/SGqFtqtGz?=
 =?us-ascii?Q?EL3ruPB1Qk4Io/YfSgQgviG9nFuzbdh+20Uv6pAwzMpLuLf9PS/40d7VQUfI?=
 =?us-ascii?Q?GtDdJiigpkR95cnDj5G8xHl056+z+/QlNGgYbzlA8yjX7P449KUHXAzeexPU?=
 =?us-ascii?Q?dT/gTntAxJ71M6HXFelc7P8yThU5P9usiwxEt8bTMLO1PxGFsa1UK7IAgkfq?=
 =?us-ascii?Q?8zH/TmLz13nAElyqYRK98M9iZPWcftVj8PkvKEj4WpEiIxJQx9iuxEHrp0O2?=
 =?us-ascii?Q?fNCG1ZIqHtYDM1rF4AjLpnOgdewzBUsRz9EV+d8+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9232489a-497a-4990-5a35-08dbc513cf03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 19:55:07.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiI6061+aFGNLNoyt/v2JjK3RQPrMpvPGuoCa99ugBkjySdU5OCFGnvYUkVS2czQ9W5bNblUNR4HTAIKFJAfSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7238
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some i.MX SoCs like the i.mx8mq support adjusting the frequency of the
DDR, AHB, and AXI buses based on system loading. If the dwmac interface
in the driver does not request a HIGH frequency, it can significantly
degrade performance when the system switches to a lower frequency to
conserve power.

For example, on an i.MX8MQ EVK board, the throughput dropped to around
100Mbit/s on a 1Gbit connection:

    [ ID] Interval           Transfer     Bitrate
    [  5]   0.00-10.00  sec   117 MBytes  97.9 Mbits/sec

However, throughput can return to expected levels after its driver requests
the high frequency mode. Requesting high frequency in the dwmac driver is
essential to maintain full throughput when the i.MX SoC adjusts bus speeds
for power savings.

Signed-off-by: Mario Castaneda <mario.ignacio.castaneda.lopez@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Tested-by: Mario Castaneda <mario.ignacio.castaneda.lopez@nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 8f730ada71f91..ba6ae0465ecaa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <linux/busfreq-imx.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
@@ -152,7 +153,9 @@ static int imx_dwmac_clks_config(void *priv, bool enabled)
 			clk_disable_unprepare(dwmac->clk_mem);
 			return ret;
 		}
+		request_bus_freq(BUS_FREQ_HIGH);
 	} else {
+		release_bus_freq(BUS_FREQ_HIGH);
 		clk_disable_unprepare(dwmac->clk_tx);
 		clk_disable_unprepare(dwmac->clk_mem);
 	}
-- 
2.34.1



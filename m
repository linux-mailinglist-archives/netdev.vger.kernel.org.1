Return-Path: <netdev+bounces-117242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 186D394D3E8
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A44B235F9
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2519884D;
	Fri,  9 Aug 2024 15:46:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A86198A21;
	Fri,  9 Aug 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218386; cv=fail; b=BDKAXTuj8FncCbgQ0ZYXcU2F3E4ILhAGXQhEOLF2sGL+2O9EQNADY3DnP+CoCNZyX8ETfmUKmRhBIf1LAekg/XJvPmHZljfTjM8q/yOq21KWPuERaqY1WuOh1CbH6dmvH+bNj9TKgB+eOTd1gp4VrvZIpt46fNE0ssLIEeWSAK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218386; c=relaxed/simple;
	bh=TZgAdr2/8RfK84fkzV2p6cTM6mJwZJJqZlXcBXACchc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jEv0V+hl8nog05VNZ5EK2peskffzBoFov+88QQU8si7GO1kINhkOz0wti363nruzJNH1vjCbkbG49uBf2ENHkcxd4uOXuNG0Z5fwW6kLCsWFN6yuTTazOW1dbsptWcz97FhGC3X/ZsoUtJqN3G/BB+7V+XbvCKzU8VxwItd3K6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpkSdvCxdveyYE6wXhPbcc8kjYgM+h87OU0ihdCrvAUbdu8uTqsF6E9TnyuNlHa3WpEp6K2UwphvNMc2odZm5hVnhU49cC26JL2fYI3wpNgSUWxWlibPAWiClk3TQOfgV3RhMJVnPOLYFTkSMq528tpmIEp5t1LNxwHtMsDu2eu2Vk70WsEaaAwv/UWAT31fbCBUD2gAHwFOwYK+i2YiY7VJnColOs/KXeaSrDMEy4Ez5LEcJ4rDJPQdKqhnwpBD4u50l+Vn2jBP0jUc/uwQr4cAgseHnUbEAB3dI380GLAUM6PDhF/erDpShIWUNcOPYKdLUkg4IUeFCYVLMqMoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xos3TNetvez8csegtAGRtpgwVKCb9oCrbneAZFhgC1Y=;
 b=WVdGwmW+G8/Mq8lpJ1lyQaLtXMLBX+ZiqT8FRe8ZQy2W/5MznTY8SlhtJiLWEt+KeJEssW0XpTRyE6C0JufHMcq22cngwMOALHbYzLPcIhjm+T7kF5aVEMl81Zqhtl8s4O8hSQE92pEiOAoYGVf9fPOr2QSJ/a6gSxVloVrFEV6V95hLIr3jDF4aJcV8ef7Bm4ZfSUlChEgkE3h7e/+FSJDROqU5raDBeR4My5xmRVIC6MefGd3QeQ/OlP/lQie01xoM+2+TNbqAsa0mb+kgMEHNLse6DC76G60spQpLgjl+WhQ4NYXwhhtDyaNspTlDaCi8JNV4duc3YRACcXlQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1002.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.18; Fri, 9 Aug
 2024 15:31:53 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%4]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 15:31:53 +0000
From: ende.tan@starfivetech.com
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	leyfoon.tan@starfivetech.com,
	minda.chen@starfivetech.com,
	Tan En De <ende.tan@starfivetech.com>
Subject: [net-next,1/1] net: stmmac: Set OWN bit last in dwmac4_set_rx_owner()
Date: Fri,  9 Aug 2024 23:31:38 +0800
Message-Id: <20240809153138.1865681-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::9) To NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB1018:EE_|NTZPR01MB1002:EE_
X-MS-Office365-Filtering-Correlation-Id: ca123216-defd-472f-3f68-08dcb888655a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	aveJs6xOgnL3HgdfisX9LXwpTtehSyPsMhe3VkX6Wt9++ta5CYNg15gFR5B4DAAzeczYeIVkjMddLoddcceMdmgvzDB2w+vGbSU01sZbW2yLGEpDfN0z0WrvN5G9g0YzWBfD4buYKfbeqWVsoTkd7ox7rCfwomDf/E5TVuMdHabLeXnwnQyxQ2RzmclKOjOxlHWKYkg8xUTECQeEn7J08Oyvm5d7V0Xg+yv4TZ8pLBagGML5pkQHpTTxAORCLIcZKeacENK1Mtq942vRMEKUtdso+uu6qQ3h3j3qEPfNmXi3UVWBl0sh7whOC9pqZ1uwn+l0Ffxn/CjnW9XzWHBabVek9OouSNnnGktgZak75ueQf8eFWi+H41dnwkn2jW3aK4uc27P9Mj6RL3S8eyvpoY1dNzNkPn4iwklEKXgwMnQx26UePuCghxz39PCgZQFbLUqOfI75nFwR0Wc8pYyHNtJRok7BPyQ/pCMUujDWuVVsuKte8HUAURJXml26sCPJsLS8KsdJkyZpGIcN1EOxVWRoIl4iELqZGHx4f4nM9SwKoEgqyz42HrYvvBaPQ+z7GPYo0yyIR3a7elpC1pRN1t8qjd1A9X5r2rOyYwNGk6LnZvrpElPNwSA2fCp5DU44
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XLR/8Kp+/lpF4f2q1ljVyRy91Y4Hu2RY6SxKrKztjV4tE9/DZlqmM+hEdQwV?=
 =?us-ascii?Q?FQTBfUNnG8jvavbvIxeMlbnl2Lm2RhSn6zUgrak6tJMu4NRI/89U/RZHyAat?=
 =?us-ascii?Q?ZAnNUolDKZMScnJDGgUw3/c4rXkuQENe5vJ98vbjMuxPfn/gyZakjhOjMB9m?=
 =?us-ascii?Q?XKTCjx0U/TqXk3AzIGHAhlgFBeantyCRixRI42jh5/IO/shP6uVo4UOv+Fm/?=
 =?us-ascii?Q?OeI7S1Aak5E3gObJIeF9xJ5aWZH1R5m0gbLEdlDqjTdZSqqHOgfASQiSDh0n?=
 =?us-ascii?Q?UCfHfUEgl6zgEQZg5fOSc0lhE68Xokn+rz1GLOpBdbQPL9b/PhCBORqbIcZ/?=
 =?us-ascii?Q?rJCTyUldPMZxJhu2yJ6IXpZ9VSBrXSoBv2LGNlPHWmkqFS/PEzn8lupRogVt?=
 =?us-ascii?Q?x3w2WxUVzNOBTZlPhcrL6OhgWg4mR8lPFmwy3zi/ms/3XGy5srQwN9swYykG?=
 =?us-ascii?Q?2WcnmFqCgq/SAVxRo3Hk7MP/dnp4ILNjTpnt1DOznk6bs6PcNRcr2hDy58TY?=
 =?us-ascii?Q?1dZ+Zk8hMsOnw3viqWcSafu5XX42OGp54JY6Ynit3eG2Qjz1QqTN5Nj1/08z?=
 =?us-ascii?Q?FX/V/dGEI1Pnoggqr5X/oJD4y3b3uQvUznKKsfGX1WEgo8ssHWjlJGC2b9Vj?=
 =?us-ascii?Q?v/ub74dJndWTHPPuCYyFvmuibhYgsgOWGNlzFfgaGcs23TvOoBweUCJITCl1?=
 =?us-ascii?Q?05NEIamHFPze2xk/0yp5/SXTbRk+iRWYbn5XlHxb1QmT1WkZMBwWekFjI+v+?=
 =?us-ascii?Q?pzxrzMWnwxluAeDzNqUKVztpsR2ZjkfZ9gyxizprpkUGAwMR6vIcUyZ7ar6v?=
 =?us-ascii?Q?r8o1XwyGamcP7VmtNyhZ6+gk3CxWwnRBx+xgzP5rmYdjIlL9jHB5i8LIv5Gn?=
 =?us-ascii?Q?qphjttNRQ1y0zMnka+ouDyofvxOoN0w2pOsma6mB9gy0oT/7UJceVQMxAbyA?=
 =?us-ascii?Q?EYA8QFt6RRkpNz+S+L6BmrquDYQ6kYOL6mYVGeUTzI081vh71MVDZ9InXnkq?=
 =?us-ascii?Q?/arBtn1LB1vRGuTLi6nbSNgGNHa9oazy6SJyefdOpPJW5Hi/D2kw30NuK++w?=
 =?us-ascii?Q?ViyN9AAsLRDryPQW5l476HM74aV0KNjcJtkrbVF7ZFIgBJJnvMjvSc8+ppN9?=
 =?us-ascii?Q?Fbzdp6pIVgCgHMywLgb7QPpC7/dkLljhAqKycS1wzUrx6no/qSkxIt6E8RAw?=
 =?us-ascii?Q?hwXKClnYgAK7baJjpPhZBQIoKcoeDMkBw746bdRC5R7GXGblDqirOP9ZXI0y?=
 =?us-ascii?Q?1HU4SPVJ1+A7Rq+1RY1QwPnawww7GcZkQrnqJtaOD2uKUjl0fDlw+Ez9TGzo?=
 =?us-ascii?Q?nzmBnQCcZ+iAEj7wf8ZuwX/33qANve3pb0YGExHEPakt2WdjJ7LXROlcQHfK?=
 =?us-ascii?Q?dehysWLEB5kJjnx6Kja/gIWSZmzD9kyTiCobd2DwtH1RBNUTjGmXc17DZYjt?=
 =?us-ascii?Q?rfzrLh0v5XoMUXb58Tv9EEZm7TUkphmOZYA3u9HkLjzlk2ImyqmdYANIRBly?=
 =?us-ascii?Q?Y6VaXELb68jzHxrK+vSDS3UgsA4aBWfzU9l+iNc1gWgomOmA80hzebzylKAS?=
 =?us-ascii?Q?XlBQTvZzANJCsGgNiuuvj+9s4YOyqm+mGBGVBNSIutHOfDdWBi7g89Yzjg6K?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca123216-defd-472f-3f68-08dcb888655a
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 15:31:53.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yM09VLrnXLXVh83aADoNqeLG1TA6RAcWwPcmqqSToFN66fgcj4h9dg9VvSHk2lo2cqr2lNjiWNcz4JSiGROUVD/0yYDuE+BAGnhNZIcYj2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1002

From: Tan En De <ende.tan@starfivetech.com>

Ensure that all other bits in the RDES3 descriptor are configured before
transferring ownership of the descriptor to DMA via the OWN bit.

Signed-off-by: Tan En De <ende.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 1c5802e0d7f4..95aea6ad485b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -186,10 +186,13 @@ static void dwmac4_set_tx_owner(struct dma_desc *p)
 
 static void dwmac4_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 {
-	p->des3 |= cpu_to_le32(RDES3_OWN | RDES3_BUFFER1_VALID_ADDR);
+	p->des3 |= cpu_to_le32(RDES3_BUFFER1_VALID_ADDR);
 
 	if (!disable_rx_ic)
 		p->des3 |= cpu_to_le32(RDES3_INT_ON_COMPLETION_EN);
+
+	dma_wmb();
+	p->des3 |= cpu_to_le32(RDES3_OWN);
 }
 
 static int dwmac4_get_tx_ls(struct dma_desc *p)
-- 
2.34.1



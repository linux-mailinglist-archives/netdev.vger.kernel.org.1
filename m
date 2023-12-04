Return-Path: <netdev+bounces-53549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8713803A6E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B3B281248
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E121728DC4;
	Mon,  4 Dec 2023 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q785ubS3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58081CD
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:36:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckk3KLd3yYSZLQ8Y8XLoagI/dysYopJppJmXaHIIj/me5kXo/Q0b2tAurGTyslmJC/eNnZZQAnOZv0OWUdiV7VSit6MFYDViBxg+JVXWgqKU3xNnDvVU2/O25RA64bzwLM/BYkHxyntF+ISwrjBNm7CH3EHPKDVqAZre4LldqcAZOy6lYdSIy7H0EmqANR4E0MNzvlQi9seta8M6Zaw9RaKCT38sRJ5bLr9jk1UJ2Yc4YtZ38ZwNQCwsnCRppmrz6yT4UuuYMwaGXC+AaAyqLB7CO66uH4/kf2p6/ddvdhRAWfw5zo8i2rLcCc2CcWE6xy5RFgWjuic4LRJ62PiFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIZ4cHOTZxFG39i+ojGcFcTf1WaKuU0eGJDOEcMb+FI=;
 b=YRiAykk+iRAIEDE7nlq1VYdZOtHzYO0BKHPyGgkjX2zDb2jphNkLb/s7Pat6zjA4Q0iHjaTivtpoKO74q4ynxI8Fv2iD1cnOvsxW9rcPy2Xj0SoLmlJ77sOoLJhzuixi6a2zvL88u9nrQMs1D0+uLlYae9x2wNbJZHpZYEdEns/ccR+UNCcUM1QA9qAjsq5rg3GwOs8PHGi0mhsaAts8VieD+xvGcfsBe2DIkZXza+cefHNpuonMI8ZP2Myp8klZmR+bsG0tzB9pmmgIE6pxqD2JdKQMmy9Oct0WXd8FDAxXIfZXt1A55TnQhci5Jytb0rLmfq+Lnjejk678loBU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIZ4cHOTZxFG39i+ojGcFcTf1WaKuU0eGJDOEcMb+FI=;
 b=Q785ubS3Kk0XNfBzgQq6Lp6kqJ5f5MByHK4MeXYYhUb1MYXb/6nELzDRJnrcI2tnD+b3ZqaGJ36tGwIpj4/H4/9ER6o+JP3skk7vVMysO1gtWeu5HjKlNjKxXpBgzdt9YKoZDyA1+4pXVajUANE0wYlFKI/cpjuF78CNkqXAzDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 16:36:04 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:36:04 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 5/8] dpaa2-switch: do not clear any interrupts automatically
Date: Mon,  4 Dec 2023 18:35:25 +0200
Message-Id: <20231204163528.1797565-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::14) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 461de506-e405-438d-ce2a-08dbf4e71bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Kh0JT7anvxKnlFzfs1ug4J30oMZTMz5c33idSpgJ+YMojE8WqWjh7sovshJsPeD3cKv5FwFNElvci1z1JSvPmEqSwi1oms5Byr7oXB031ojtwd+bVLg/eW8QVQqa7Qp77NlnbNZ4+BmF9iS4PBloTMqJAYE/CUp6hw52DYiuoCIp+ZDSNduuC9Y4JPxy3RRSYpYBjRKQX+9Y48gvM2MWXcmimWNz94Iptj2Y1PZS90S3QWkKaq7AJSVlqB6l5kpF/WFFlqW9pgBNIMgBdscgwGEzex4MP3I5p3fEqKUr0UQErf63MoK+5GJ6ZJg54ypQajZbeER3a62M0u5k7RFWTojzIQf/70WLw4HEB1yQkxngZ9EnNedd2utuMEfK/PkD7sXmjCEM0eePibFRQ/2scWMlGyH1KMsOIyUy7D9v5bz7M9kX+gdnjWOwMuStDlAFV43r/GoSjmR4iQHbfbL7ZB2uMTXZ2OUftGvtsLtgpvDfRwMfwfkwzRIfka9+r/OuoYEwG9BpY1cqVQ3bff0OIMLbaQi0BzOW0rUaHG6+UKKNp1+xBhX3VWYhCnDrXj9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(44832011)(316002)(66946007)(5660300002)(4326008)(8936002)(8676002)(6486002)(38100700002)(83380400001)(86362001)(478600001)(2906002)(6666004)(26005)(2616005)(6506007)(6512007)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Zn11VgpkxPg6233qpJPmBWgU10skp0b06zbHGGb9hP3baGZgpAtfDBF0K71?=
 =?us-ascii?Q?y8zfq9IU9X1hO1aiI0C7u1izRFsunIjypY6XAfcgbwspwGOMGkt02J9oxU1c?=
 =?us-ascii?Q?R8O8ROH1NevKJVQm3VJS5tOEIxhyAYs4Zk/wbYVHT69EO4RznrxGv0DNnyqi?=
 =?us-ascii?Q?Z6eSTd1BlCAN3ejZAtU0QgAJ7dF50modt9xs3TLZv6YeCMhimg0Bxw0bX8c9?=
 =?us-ascii?Q?kXV4bn+SsJJProTlvr4fFslbZTG3xWrl6xSvJdCMkRYF6Hr+UF9xJrGeuJ5d?=
 =?us-ascii?Q?hgC5UL49wjwRdXPe3PjkeXXfViE02Ml3zG1JiqzY5wg5Z9Sy7vAGZQpNUonI?=
 =?us-ascii?Q?6P4dHRxdQDy/hElkwuk9s4spPIVdhYLlLzSKpcUC5bM0d6vx5ENZs6S0EfE6?=
 =?us-ascii?Q?usd+lFt8KH7lfBHF1cvuxmaBnBtJo3Il8bdDgfHQgZ2KzowT1G2kUQUBc+ga?=
 =?us-ascii?Q?aFMmNfpZ/VtL2wCYxLNs8bKrIa/EplezSWcjQCirt61No5uE/O0yywcHOjcz?=
 =?us-ascii?Q?Xnm8YwDxN7EUjEdm5c8kNEksNMAiqtcqFmnu9pU6xRHrQlLCYtHbl1bTuD6X?=
 =?us-ascii?Q?NEZCs1pY54jt9bkoR7+mTuP9/WmlLztGCAkAzUPw4PYJ7T38DyCmJltzJTgd?=
 =?us-ascii?Q?dy/QcIBQ4nMziYI+kPeV7pg/8egnfUnpTRrKoI6cksl9xUYFaMNTcLceDo2e?=
 =?us-ascii?Q?j7uLISTjc5FeYbmYBZAmkYOzx3Br7X8+dEcr5BEU4/sA40jnQfvH1Uuy4KRF?=
 =?us-ascii?Q?73XHZMo1qu1kkGYNW9e1CmNoroaQu+p/I2+NagoThPzhBDQFGtfsHz+Y5xTn?=
 =?us-ascii?Q?OI4dQaqRicLwJXzafyxwE0aCzi1B0p7DJKagyD0ojYqanCKDTVRZsKeRUZcI?=
 =?us-ascii?Q?57fdxkcMDzNRUQME9oUhGkqya6ndQui/o3ztGYUBoIvwvKGZCPcW8BUJk2iF?=
 =?us-ascii?Q?cUnlcUhpQD7Z8emDFPpSPQbebMGB4rYVPboE1kna4ESTx6uHKBo1zcTMebmj?=
 =?us-ascii?Q?1BMJjzbMh07s9awDdeLgqmhGCqeqaqJYd5LqmiHZvsJdnd+tfG8UxyTcml4Z?=
 =?us-ascii?Q?evXhcBspSForH0aXPFnMgPjZoJj9rtPYsr8Rng0Ti+aGGSb7IsKl8bBrtsdO?=
 =?us-ascii?Q?2xZjKcjLdz6XGw6X+yADWNJk4mTLhmBO1K3yPP/zzyNKOYOf6OqwAueB00MO?=
 =?us-ascii?Q?lHdvPNAHapvKrGuMZigAVv9KA2louvlyplI+1QR9laUYCbirUITANhxHA9RC?=
 =?us-ascii?Q?pjuw2JDZ2NtXCclVwGswJ2hX5NFWOpK9l8tImIGuhjwvMsZUqyBXzUEbDvB9?=
 =?us-ascii?Q?6lhtIXvWixJ8NrBIGv4BuUXEHX+4uJaJAEwRfTyP4zmbe5ihnpsjWkRTENtC?=
 =?us-ascii?Q?wFDClN3z4iTClBWYAcR3tSRWSydfEtyc8JJIFgGsb7pjjBeqlzyo3421NJ9h?=
 =?us-ascii?Q?an5tKLyc68nhj7OrdOJkQ9QQ/oJKHuv6tY2Y+LZ0iwcd/TgMdyugoDGj04D7?=
 =?us-ascii?Q?J4bdkk++9yoBD8rzacS3B+5pWyt1HlpdcNub3ZmjdmsV51puRM26+IaWRnIK?=
 =?us-ascii?Q?WCN8sV8DQ9Wb05fcOY3R+36Xo1+E7V1WMQOBXP09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461de506-e405-438d-ce2a-08dbf4e71bc8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:36:04.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkiYIxZBoWqxuQTsDmvZMy4ro8wlg9Nx4dm+LK6zsqT7f40Hj6wkXZLUEf4FxF8tz1ANdjtYrPZetXRRFA6XRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

The dpsw_get_irq_status() can clear interrupts automatically based on
the value stored in the 'status' variable passed to it. We don't want
that to happen because we could get into a situation when we are
clearing more interrupts that we actually handled.

Just resort to manually clearing interrupts after we received them using
the dpsw_clear_irq_status().

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index e91ade7c7c93..d9906573f71f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1509,7 +1509,7 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 	struct device *dev = (struct device *)arg;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
 	struct ethsw_port_priv *port_priv;
-	u32 status = ~0;
+	u32 status = 0;
 	int err, if_id;
 	bool had_mac;
 
@@ -1539,12 +1539,12 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 			dpaa2_switch_port_connect_mac(port_priv);
 	}
 
-out:
 	err = dpsw_clear_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				    DPSW_IRQ_INDEX_IF, status);
 	if (err)
 		dev_err(dev, "Can't clear irq status (err %d)\n", err);
 
+out:
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1



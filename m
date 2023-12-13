Return-Path: <netdev+bounces-56871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB408110D8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913CE281687
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A9028E25;
	Wed, 13 Dec 2023 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S5OSZqyV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B730E4
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il3azfVh5iLE0067vX6Ieaz+lSoHg7ETsthXp+JBBz3XOr/ny2Gb/rKXpM3PtQfWBRGc8R8ksCSBQDaoTuXf+hC4rBO3pUEQDeSuDapKEHSB1YYIh14jK3rWw2CvcsEbru1d/Pkxm8AbBIV420AwPaa4F9spwbGsYm89FH1JnzMYH9aprzz5pOLIRMRQZhFf9QhuJFZqcwmNIz+5m6QkcB7Birm2sPkd+ohUw2DjG1JLAguPg8jf632FIvS3sQ8kKUFpSMN3SJNZmwInNGqGCu9m55UPA2Jn095n+6Oeaz2qfQIjEfimRNtz3xfLKFpr8dfEfmiQ0txIj3ZSCvJfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIaQeGPHLwzaYEZJGYi+dVI3sJkW9Kc7OESVkhJw8ig=;
 b=YkbgUntt1YyYvA+xMB5T+gBcWRdVpKR4x2RQdEkP2wFsTOmse222aERF2nmM43u9zKAWP5hcgn8qp4iZIULiXDy8bnPbdWFWD3dEed8YqNHmyRUkxD3aFri3Fkt350tH+RnuuNne0PKX3uZgfFhgU3Bf9359fh+pjbby4lXHO1mtTV8oB0oIgx6vJO8+AJCDyyM7gDXo2aJ+7cqGm3dCX/rOwRedCHZlaYUjhdEpA62c44lwnYarvY2i6Vqseh1y9A/mmqeLKq58icZRTkBYagve2YV/EOEt0e83QAGYg8nlANZJd76/6/ykrVk8SWP+K3mUNWh21WQygbHiDU+uUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIaQeGPHLwzaYEZJGYi+dVI3sJkW9Kc7OESVkhJw8ig=;
 b=S5OSZqyVsrDz3QrJ/AXzD5R2g7dlHFrERs7cq80uxU3mbpSvmlmOVTkIj4EQ1QF+69tCE9ejmuO4zpLx6IHVlSSlDaYLF6gY5eyQXwRhVFuq/UsTiLFFc2vdkWrpRB1QKBA4VUrKjsgNHJWIro0hSQ1W7HpgpbKInAEF3NgYcZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:15:47 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 12:15:46 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v2 4/8] dpaa2-switch: add ENDPOINT_CHANGED to the irq_mask
Date: Wed, 13 Dec 2023 14:14:07 +0200
Message-Id: <20231213121411.3091597-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 089cb692-b215-404e-1325-08dbfbd53c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o3Fo6syAcs1JOiG+2ryvCXvNLsu0Hs7FYyYldiMqiTizUEEKOZ/0bNVBZFCWd5mAbVTHiHzCbFnF6PCFsI7gbuASZslBM+aXaNqXHhZk0J3ndDv7vY5KfVYLOv0/N0D45ShoBJdV8z+Cx9jsL8df5FGc9dzfX2BANkBeL07upZK+Cn18wh4IfwfZy5gZYQA6m1+tWYmc11aAd6mU+0+3e+WEnOfrNTK47f+HEnY/FQMprNRPe0v+g3J9wv7RryqyT47bkzsMvSbQsTet3gXgtJzhG9scZ+cynI04MYBaMzo5kGk4D4hhT+hyirJzln3mJg25lTccnpUj4KflJdPbotosDyZVE7KqeQJGCPQ43elPZv2xkuJXKfopQfj8MaPyfzwW1UI3NConN710BcvKQYlV6lv72ni2mxtG3AujjF/8MQK9aOsyAegBXIcir4oNqWLq/trYHcbGrnE9EynZXopwwbgyKrvXjQOgRoGoOtOP2w7JVGpja9Q5Rr4G87DiKQaSqtaIQpR6Yjag7EWx9IBV3obD/vbhdcAvXljRFvobzGMgDlRxy0hrbNCjpqib
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(2616005)(1076003)(86362001)(83380400001)(6666004)(6506007)(6512007)(66946007)(6486002)(44832011)(478600001)(4326008)(8936002)(8676002)(36756003)(5660300002)(41300700001)(2906002)(38100700002)(66476007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yvzWMRTCzWFSo1qbZ6PtOCy7ZeL4iLuaLdpvM/Sa2n42P8PeQttTLeT3eFQU?=
 =?us-ascii?Q?R3Cx/fPeBmSvUwg7i1btl6qL5GbsamLVJ4afLdOq21Wja5H0xlE99dbMlFVM?=
 =?us-ascii?Q?aDmG9Es5Akn2HKru7Wj0MlTzk4CiYb577uY+GhYiQaVmAPVxt8HLSsBWFwhY?=
 =?us-ascii?Q?H9gX6Z4QaiXjn/+nly0v2MbnDySGwYWgbQtDttDxqbg0+BhoEfAP7UzxFjKr?=
 =?us-ascii?Q?6m7wfVNjalmoqjgOSOox8ddtsSOkKMD8L1WuS4Mrx766OIxlo6SFExGz/VLU?=
 =?us-ascii?Q?fn1tCpm5dsPO11TG9AMVJsj3Gv5C7NI9UThXRP3elkTlr3pkE9Uo0kNKLLA7?=
 =?us-ascii?Q?FVipFPKJsSVX4eSpucGNVap1Pefwh8aZiWGEtz1R072/jA9oHN9FHBFrYNdY?=
 =?us-ascii?Q?Ct2amAFExD5N/FVkEcKlUil60D08PbJE4BC2NzQDeGbRE/YzPr+FLfENNCNp?=
 =?us-ascii?Q?xsRSpfaPDRmTbsRB3Nzy3c25P7NqGUKxZ3mVk+D/n42ckMp8uM+avBrAkN6H?=
 =?us-ascii?Q?2g7RLtky71NcOMMMoc2z10U9npzUo+6FV+fytq/Jg2zFBH282J8dJl8OkJhE?=
 =?us-ascii?Q?Nrxrhao8ETkLzpHuwRqRGkTxA80hNzC+mVaGFLTzOhfwT6/I5FoVxHcBxiqd?=
 =?us-ascii?Q?fkpV0erhoepEjUJe4kvOnp7A90spJFB4F7eo9TViTgHJBKHZEoZjWpJDsEko?=
 =?us-ascii?Q?2oc9KXfYbsX15DMuLN6gyagGtST7Hi0wxXLd6qDetFIrhhjg8P+3JfiBkqZ+?=
 =?us-ascii?Q?6KYlXfEWTeRk8MTe/LFFIDbluYP5PY1+kA/JQ+YEdBqAjlJuwgsxjpRzmkaS?=
 =?us-ascii?Q?+T/a9IxyPCHgqbe0JDmaVhyE1/kKKwKSSdDXbE+bLIy6NbHNdFf1LEXoX900?=
 =?us-ascii?Q?rVIp7svnpZoIQdBBAml+xKOZUqDQVBzXCVAeGEJJPZ+/4UiUpfMahgNBRFJC?=
 =?us-ascii?Q?F+S5suImNbHC7wVeGdjMqi+YDRbaK5NO2rx2OMezPossdAJjIJbyKE8uzkvL?=
 =?us-ascii?Q?3y/X8WPex/MQLjBzBhz52oVzwNi61vnfhNDPWnipzOakSl6EcTYg+R0z1tYX?=
 =?us-ascii?Q?3eOqtlFt+8JhGCN+YE9anl/6nhEhcfbXxTX6fQ2wpRbQQUYQ5eh0r4GImJJ8?=
 =?us-ascii?Q?OJEBY7ajBwbZmMRar52KD0S9pGASNJESNUfttmtM1S+zZ/6bAA26VCXZHvLl?=
 =?us-ascii?Q?3KsYQY9BiRFD1EyK+b0HirF9qPcvbAg23BaLP2rrLsPP3PtBCdpb87oyahp9?=
 =?us-ascii?Q?gimgEdB/1usdSaqHrOM0j4YyrfUkGlSkmmfYDokoiFvDNybHUUGTIqk1+Poe?=
 =?us-ascii?Q?eIxIQhseKecv9Ho/uHvo5WsvIem5R9XuOqT9HWtZ1clE3GNRnKJlXYylFF/M?=
 =?us-ascii?Q?9+hA4ObyjjKHJJw3cxK3M7tcRi84J5sHDj+f+Re2V+er2kUfZaluyG6d8D1L?=
 =?us-ascii?Q?ZFZhHQu5+zLoZJdZX4fP6IUfISmCQkKlaX0tyxjtnTGFAoEGFn1Qw6F75Lib?=
 =?us-ascii?Q?8Psd8EOR0ZS1erIvFJghq+gHQX17ovk+cVxb+qKPk6FDIbEvZhqzv4XTaVWZ?=
 =?us-ascii?Q?lYWEi7L4j3sgQcctvRx3NIeBMNGp18LYsslOFZbM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089cb692-b215-404e-1325-08dbfbd53c98
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:15:46.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSxuuVyn9IWOkyVDMSdNziqRwLpjx9L+OPIZHkJz0SVHjlCdv3nO6FxU9AZj3jMHr/OtG0ebuw9DeEx70FSl+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

The blamed commit added support for MAC endpoints in the dpaa2-switch
driver but omitted to add the ENDPOINT_CHANGED irq to the list of
interrupt sources. Fix this by extending the list of events which can
raise an interrupt by extending the mask passed to the
dpsw_set_irq_mask() firmware API.

There is no user visible impact even without this patch since whenever a
switch interface is connected/disconnected from an endpoint both events
are set (LINK_CHANGED and ENDPOINT_CHANGED) and, luckily, the
LINK_CHANGED event could actually raise the interrupt and thus get the
MAC/PHY SW configuration started.

Even with this, it's better to just not rely on undocumented firmware
behavior which can change.

Fixes: 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- add a bit more info in the commit message

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 654dd10df307..e91ade7c7c93 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1550,9 +1550,9 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 
 static int dpaa2_switch_setup_irqs(struct fsl_mc_device *sw_dev)
 {
+	u32 mask = DPSW_IRQ_EVENT_LINK_CHANGED | DPSW_IRQ_EVENT_ENDPOINT_CHANGED;
 	struct device *dev = &sw_dev->dev;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
-	u32 mask = DPSW_IRQ_EVENT_LINK_CHANGED;
 	struct fsl_mc_device_irq *irq;
 	int err;
 
-- 
2.34.1



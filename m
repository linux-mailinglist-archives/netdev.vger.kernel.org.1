Return-Path: <netdev+bounces-56867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24748110D4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236411C20BD1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6735428DD8;
	Wed, 13 Dec 2023 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F9URjYNR"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42823F3
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAs9hYqLG2jnDK5uw6wleZW02a4k/Ye62Pc9inhxKTDWpaTGG0erER1WnegFigriXGkzUa/b1FrEzWFW1MbZZmYGztXWPGNyeQo2Zb8Sb4+LeHY3VlDtRY7J/ULHuQmuyBq5SNB7s2Jby5K2vpf4cuVVr6HTT77vvKl2XyZfTsY60QnnMPhy/CYBpPC/982MLZ+Mtel96zmDe+GfVTVDAVlHmOodOOK4pE8xXbPo0kDFWbn5jLcK4aFb1+MkhGSrWqG74sg/wt2pZTaGYh6LH3oAg6CKi1trkWjeC3Gq/EJ1OQ3WuVmFSOKme2YNxzO7mbJUDt0W64QHOB/IBUvP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2a+BKbvM2a8rDveUbGjqIcAUcgfGpl6/suDWgsL69s=;
 b=PEIQKlgos0xhakD3mEh9skJ+PrRthEEwWRqhQKvJc/AvfP8WVA/W4dEX5xJ1OGCq0twKx3ldDL/46PNFRjbNozZKZcYwy2mO3KAk4AZ8vhRckByOc25kOTv5LxMhPHQn45b0qh6siTHsXduYjNGcHTuV/6NaeUkjbAfqVYB23z4Onl56xL2U89fZtDAEhS1NqD0pCUakUxOfHZagEDlh13PBQboapF5LXAczGkiPpZqY7qHF0MKeDmwV+rq0L4hpBV3F+w1/bNfknDoW77f8nLLsRlMp7onlghx5k6hFOG7h/BCoaD4DLRibMHflsDO9smGO5WSl0xxpwRgjTlB8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2a+BKbvM2a8rDveUbGjqIcAUcgfGpl6/suDWgsL69s=;
 b=F9URjYNRm4kY5GujjXj/ma0+lMCXY9jNZfV8+jShIx8bX/6IzXRaH2qzXHSajc8CURxINnpFBa5gnRjFjSf2BG0Yhxnk337IAwie6wkrD7a+aA4HZuvCsEd6NTMSdMWGYysaLUmGqVQI5Hxe8njP+9HBmMv79lqph7tBCP9Rh5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:15:39 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 12:15:38 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v2 0/8] dpaa2-switch: small improvements
Date: Wed, 13 Dec 2023 14:14:03 +0200
Message-Id: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0094.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::35) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: e91fef2a-c12d-4721-d384-08dbfbd537c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WVcJalgC5Ah90UIYRiBthyde0cRTk5KFJ7qkRKz03uCvpYIzsEPoIrLbpp4rVjKQQ+YRTN8on2RYqYm8S6hgczvnDs+83tL6ObDSSxUKo6dU4Yv24lx2fvIj/GRgXjSvgliq2nLbIMzoFUn8uD1J7SAL8l/0NDNUcdZHPZFmM0QaIXYp1Sq8vk24rnsVS1MAMsx1MGF/REo/oGS4DyWFiNZzfHUUT4vf6DAkKmbdtXgeAO+nlc3MjQc5jrj+dfCfB5jpqqn1iqgn3McVwI8yvkImv45GplMejuSizjZfQgHEQNrTSieA6210kd0Zpb6MewKdCNznrvXFLHuwSiNpWIMpSXnSqvtSGPKKOE5wtx7eg3TSXCuzEMnhXrD3gka568abgub2X89mH3ikZjuXc3mCVHqLlpl/GI/w7731Q8Lntobx1wkb/ALMtZHxH0yxZx5yCliMG31VNuYyJtijTtdgr3IVk+18VPxD4orHm5bfiad+DeTOg7E3Ay/9biXo63OIMtwW4+xZzVVrFz6f5QjtGQbKHVKEyLHgB4xh3b8u7eKxbwkKTBoC07csxDXm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(2616005)(1076003)(86362001)(83380400001)(6666004)(6506007)(6512007)(66946007)(6486002)(44832011)(478600001)(4326008)(8936002)(8676002)(36756003)(5660300002)(41300700001)(4744005)(2906002)(38100700002)(66476007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yA84UMR/Q2R8sx2atZFetWrJJlzRy/OgTNQr4hf8l9x+y4PeSualJEs1s3YA?=
 =?us-ascii?Q?b2Zi2Mx7mPsQtL5nHiv85kiPCMa9P6ng6C6lplTIoXYDjc4PmvxLEin0dRae?=
 =?us-ascii?Q?OyJ1H5LWM23s5oEnNkNKjhNRppb7QLz1JsgSMnvCGdH5Fh20cuJ38eQLhY28?=
 =?us-ascii?Q?a+eE5C37V+RDOa7GBMBCtY615EVK5YREtjeaXLJR/pIsBKieTiJnAb6PCAxU?=
 =?us-ascii?Q?Jp5CTZO1SDenjHlbTzhzeEDTlLJ8n6icJb/30Gx6R6YpS1ZWj48psZSsuHKy?=
 =?us-ascii?Q?MfSamw9STpWUD9LjdqrAqgbGiM+LIzfppIvABVXF6so+JfIecQ035r3sRu/L?=
 =?us-ascii?Q?LnAjwdXa/emUF51RiOvfI+igXos7WZrOVAQIZUkn68IJImOTFm4nvOU1tSpn?=
 =?us-ascii?Q?Rue2ws5Zp99NAU7bGc4wAZ9pv4qBU3eyUFAkgFU4LD+1iLbJsEjIbRGwIhSc?=
 =?us-ascii?Q?bhr1mUqEPIj7kBwyktpAF8puP3Yh/JibyADSAddaadsMJiWWH2wtUilKCseO?=
 =?us-ascii?Q?zhSQxFQR+WBSi1o1Nt9JG+GGlpKcoyXrgur9WqBcZToFZINXUt70UGIYt1Kz?=
 =?us-ascii?Q?6nx4jC1LYPLgGE3YRx8yXaR3cvPHnQheNKjPtTl2gTR61SAlsKt4rueCkg3W?=
 =?us-ascii?Q?ICs8B8hUS6Q/f7lLF40k2F8Yn3pUc7fBRB44nAte7lvlYvOkA91KmQ87zy8W?=
 =?us-ascii?Q?MMP3AmcgGfJwql9y72IWv1Qy+3xCQG7FOUeA+XQ2TdfIgmQSgNHw/tDwq27m?=
 =?us-ascii?Q?ihCqbAjVfSveSObQQexTzK6Ql3SPkhg5Xh0VW01rzxlCDIy98iRnPixcyE78?=
 =?us-ascii?Q?8wEA9MGuNbh2GtaBZLT8f6aYlWGb2LRMJ4rzlYJG32t4IQsJ9L4haN3CwSY2?=
 =?us-ascii?Q?0srnf3iD+iatXaNt9IIdUQABH31RstRqljCpmwdp/O+YSTsLv6mpBRaguq2c?=
 =?us-ascii?Q?0/U2K7F8wjaIMC59JALiTOptKUXwiVg393rMipBGIU99JATDAiJ4Xys98yxq?=
 =?us-ascii?Q?kpSn6E6oMy4O/azs3Q232orb1GihCQSBQNf4HLLLPKLmEcAXkClESB/VkblI?=
 =?us-ascii?Q?Xc+/N0/h0P03uxx9GvACy4XblcsVgfj7PJkbrhQXReIZLjpaupYNZJWtiMfM?=
 =?us-ascii?Q?fUKodxmekFLbr7EMCNmtF/l6d7JiC18JUtoWiX8pCUQgHUJB4/mXeR04Hbfz?=
 =?us-ascii?Q?uGc3bCzHjPCtHrDY+nAf2OSJlkgt+1YwK8AHeoJXaGjNnc90BELHFCGgItJt?=
 =?us-ascii?Q?UbDJq/cfhnrFRNi9DX4LgfOym+yGBo6eWUxRp+8ms4MXGVkhNXfMUEcWIOm6?=
 =?us-ascii?Q?CaNoLG3FzKNuCIB9vUoTLVAYubp0z5tvR1STBngcGYAPMyFk2t9uOwvhXb4C?=
 =?us-ascii?Q?k7Im8GpCPbnsfLFAEZXgZ+9ZyUcWhSbqVvkYL5aQ204+QKEvGllkQrDYpupA?=
 =?us-ascii?Q?FhTTt4E6lONorEcSk1zqqRK4om9fFlKwUejMsyq3rx1VxlcgiyefQOsmb3Q8?=
 =?us-ascii?Q?MPzWy07VGKOe7MzZkHkxdmwgAQ4FTJfLlxe8weMBIdeblqKiR/o1/4SGN5Al?=
 =?us-ascii?Q?DL2hyVXjziBEbcmxCu84ugjHGdfJTVgNbiOIDbiT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91fef2a-c12d-4721-d384-08dbfbd537c9
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:15:38.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gvvhZFjl1glOQNS/csYeIAjfAjNHyz3MKjvpPuu0PHlmNVpFo89es136BHCaLSaeqGXTVN04nNiHfa/IJy9Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

This patch set consists of a series of small improvements on the
dpaa2-switch driver ranging from adding some more verbosity when
encountering errors to reorganizing code to be easily extensible.

Changes in v2:
- No changes to the actual diff, only rephrased some commit messages and
  added more information.

Ioana Ciornei (8):
  dpaa2-switch: set interface MAC address only on endpoint change
  dpaa2-switch: declare the netdev as IFF_LIVE_ADDR_CHANGE capable
  dpaa2-switch: print an error when the vlan is already configured
  dpaa2-switch: add ENDPOINT_CHANGED to the irq_mask
  dpaa2-switch: do not clear any interrupts automatically
  dpaa2-switch: reorganize the [pre]changeupper events
  dpaa2-switch: move a check to the prechangeupper stage
  dpaa2-switch: cleanup the egress flood of an unused FDB

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 131 +++++++++++-------
 1 file changed, 84 insertions(+), 47 deletions(-)

-- 
2.34.1



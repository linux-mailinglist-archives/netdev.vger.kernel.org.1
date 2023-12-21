Return-Path: <netdev+bounces-59608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682D681B805
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 14:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C605BB26584
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439D983531;
	Thu, 21 Dec 2023 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sw7P2kj2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423481E5B
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A15dl39TnQbJ4WDsSW34IgxyKKkz46waIZVggzLgxeoPFbfjsvE8qruKbyO3ZCgz+39pu1e2U53wbz+2JopdNvj3KGinmHwLe5/7T/un5HllngnaCSJgci1cMEO/GX9Yh8ROkx1Q3hqYIbEQX6CtzKZUvRHvB78i9jfGWO/6FimV5AiHD4rrmisUciFlICN2UJHf22IuYmhQzKHxUFFfVnmOWPyA9gDZi+WQZA0IxOllOZWk3P6z7oOdc2V4GPChR2FFxiJeZgpe4xkpZsbue/i5JWDzv7DmCZ5TngKiMfsPttoHJQpM8H7e+1HML04fAE42967W4uaVAQpezENjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7xEK84mq0HDYTKz3BXvp6q2T4uqDaQZ3InL7tfzt/s=;
 b=lPCaaGZGu5WRiCSEuQ7jor/PyAUAY+dy3InKBKysRSqoO7QDmx+TdFxOPflYm06IKBtWUwiLXOI9Un9RPXhXcDg7OoWc+UrEE3n8AziEBqiFLsamrKa0z7835QmsA4JOTJK4LUY39cjc+CdRuQk+CNKlsfKigRtNKsDoLTjJiKQz7XnbjML92rc/eJTzD/jFpeemEKPu1yu6ZIJPsYE/A/Da9nEWbxRtwHCZQysajr4uedUIidhWdz86QTgyo4lXtanVf+LDoQnMNrENRZRiz9CQy8q4pjccVZc1uqhp6RHbZZcqKMNkj7VnNmPbaBORra1zd+Q3SD+KsfYolmXnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7xEK84mq0HDYTKz3BXvp6q2T4uqDaQZ3InL7tfzt/s=;
 b=Sw7P2kj2WCWF32PjaQ4f8uIyh6+boIcU8oKrcDKXSeuAYfgONbGH4iSXyRdZ1u/k7m5a313GWOofasceyU7KhwUoOTRuBU3Pum2STAH3x45oYnK8AmaadE2p27+qDiwvH3fUwV+LBcdkqAK4rQ2nss3MdO23XVJ/YXUj4rtZx1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 13:25:38 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 13:25:38 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Subject: [RFC PATCH for-faizal 0/4] tc-taprio selftests
Date: Thu, 21 Dec 2023 15:25:17 +0200
Message-Id: <20231221132521.2314811-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0013.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 5680bbc7-3dad-4de1-8d0f-08dc02285258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ohbz8LfgVk6zzXgbroy+e7FVB1cRiy2G6fRP/bAh/sPf5WvFAQerkHO2Ye1cvvoScMSa0eN4Xfvd3IfW714HW3ZJae1FPgmugHy5EtxPI3JRV85TwQC/ghWpbIR07J5QjvRCh1Q1ffL9/QAcVWulC9wB3JtFTJRKJ0F8a6R4b4ebekTNQXES8Xi1/VSBlvz5i9AYzzfwga1Jch/Cp0x9NWVW6HlOIAQUIe5hm7DTNmc9C5mZvNeFTNQPfkantDPWFNsbFjOax01UyOkmPa46XDDla83oiSlOERpmb/lkq+0qz5vicB3UQZkcbbUQthQMsv7ozs6bs94MKqfIloR+K0M+6xkwXaH8/0cJxgTli3hSH3yiGvTOXKUV+wJeOVmZRjkuHAj7dc+eOgsXBHSY43Bb2eEns7/ZW1Kqc1Yqnh5IaXTix9pZGxH2BrNOe9G2GLTclV0K/3nynOZ2gY9nvPZ2XbCg4z8cZM4iH6U1TpDzpSXyJZGfrvDWP97+Ifiy0+fmyiVE/hTuf2LKSkAeHbWhotyCR+5j9yi71LNKnJR+0pAlxvfkCRLDZsNgu8n7Unn0YfuI5mVBOAGwp9gVoggQ95w1P/qDd/mXZ58zgTs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(6512007)(86362001)(6506007)(52116002)(1076003)(6666004)(26005)(478600001)(66556008)(6916009)(316002)(66946007)(44832011)(66476007)(83380400001)(6486002)(966005)(38100700002)(8936002)(8676002)(4326008)(38350700005)(5660300002)(2906002)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NAp3nEOzCV0C/UtQMqxyUy0plCh8AU22VqKKL3SX/slCTYUQxThOad9REfvn?=
 =?us-ascii?Q?duOyuSSPbwIkvNiMNw1u4uckNkYBRYfSAlvQwGBJZtcNmGO4eErI0VauwdKR?=
 =?us-ascii?Q?EEUZhJIJH/R1Cf5nNBlFsI2DsuMukk6YPxKzkKADr5j+zliyn9R4ZDFwyOfT?=
 =?us-ascii?Q?HKIeeIKAKKIhZp6cK9UaVdB7osuUcwqPPvmiOUPrqMJt//952vObZYktYT1y?=
 =?us-ascii?Q?+Y2yMdPDrcsbI/2OE0X5s4cbtkUOujpM1ufOyl3lrlgmsYsHeq1e6jidIFuU?=
 =?us-ascii?Q?Cgcx1fgs81sIq2JjiJRoGa4e1eF1wnGfZMxOCk597lc4GwZBzYXrQfLgM+LA?=
 =?us-ascii?Q?bL10uGKRZIkJUECp6RaJZ2tcuuGU+MjSHBnufITxa0ciA/0B6zKlZTvoX5gF?=
 =?us-ascii?Q?uPC2BS03SoxX4brfnW6ZIZSbA9tj6d93fGNxiB0ZIZzW1OD1d+eAn2zAu9ez?=
 =?us-ascii?Q?CaS8Kceuczt7T1xGB3NO1+3H5fFf33hn8LRLFylaNdSaoF3Nf4vexuk0p/FP?=
 =?us-ascii?Q?7g5WhFlor8gltjUQNn7Z5oyQqkytbzjk03nVKZM2kW0Ur1lf1NXG6FxK6kx0?=
 =?us-ascii?Q?MpV7xx5vXL2gaolRG3qSZ2jCWlEr+mcXp38GPCMRhu8Wp2zv+T01fXSSyLB+?=
 =?us-ascii?Q?OnUvPtvXd7WS2HSykd9MS5P2KL6OyTjnlNdCos6/81zGsHbtWm6E7awwP6+t?=
 =?us-ascii?Q?bc+OwQOhuLQ7B5NaWQEV7U0D/Nfr72uwHY52cgjTZvg7FiWCV+uXmTlem5Ip?=
 =?us-ascii?Q?8rQUwuCMQNW2XIN4VoMS2zSc4KIniAaki9v/IXMeEok6z7wWsQDyaYyzkgfI?=
 =?us-ascii?Q?EuAAHzcTxh+OmECg/uppn8JLKCNl1Q2CAM4RR8m3AavbhNk+8BOKdmDyb6bY?=
 =?us-ascii?Q?iZEaYZ2S06JDSTc8x7nYn4HfIFKILGOKDVV8130EGAdLSgsKzRWvQP3rwE0+?=
 =?us-ascii?Q?AlVMs7fqcKE3GZBrigEq4sXlODk1oVw5Abcs51S6vmpT8fNcpJ6L6W51jTvP?=
 =?us-ascii?Q?SsB8+GqMYOzhuu9sgIYIpZwSRd69J1nHVTgzGzCWyl1AfGWlUARXbtpxZNpI?=
 =?us-ascii?Q?kFgZTYLhpXVgPEGWmApdeD6rDZ37zVom+VC1J4HL5QQ1/zUUfrSGx5LDL+FC?=
 =?us-ascii?Q?zl4DF3aa/eWv7JiUumjdsk2gijmhukxEOoXpFqtLM5gDpbb3raRcVeXqL4PV?=
 =?us-ascii?Q?4ZP+7dSShjTnpWJYIQT+lcLBrIhOUkm3pb+t25wG7dCB6FoF3x7ltxysAyiU?=
 =?us-ascii?Q?UfbVCMhJr/QknL6dR5oKChlm9nz71LPWk9U3ecPlBFYwNvSy2YXvUSinMjAO?=
 =?us-ascii?Q?qpSfDdWIoXKGTKleNauQNRv3JhHXxHainy1SUgvk5c7OdeuXVa/ZytmkfyGV?=
 =?us-ascii?Q?X2mb8Ic7lf0pOtn9kARLfSF8Enh2klQ8u59DQg77RWt66/Wy6AiaxHIfMc1v?=
 =?us-ascii?Q?8MDiCyLHezmIwYwkyWJ88POR2WO8uvTofPdPkBgoE8PBE2/xIJX6dK9wL4QI?=
 =?us-ascii?Q?wwmXtxiRPDeCAmzSKDuEFo2/nxRSK3i47F3lqdI4IYH1E/bGBtiNQoawREsS?=
 =?us-ascii?Q?uOFAij+H7LqTF3Bbg0da6jpZikoZSHIGADWBMM7eLskcuqU+H37JYxwOtEqZ?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5680bbc7-3dad-4de1-8d0f-08dc02285258
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 13:25:38.5084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MD0yUEvHfgaKmTWlRiBTZdo3xSC/BbM6sxXj0Xswk37/nrpfADabYFsZwc3K9LAyOUa45uyGu0H9PLG8yq+Quw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058

Unfortunately the isochron version from debian will not work on veth
pairs, I had to make some changes and add the --omit-hwts option to
the sender and receiver programs. The modified version is on this branch
here, I will merge the changes to 'master' once I have enough confidence
in them.
https://github.com/vladimiroltean/isochron/tree/omit-hwts

For testing the tc-taprio software scheduling path, we don't need PTP
synchronization or hardware timestamps anyway.

This is just a skeleton that I'm hoping Faizal can pick up and extend
with more test cases for dynamic schedule changes. It should run
primarily on the veth driver, but should behave the same on any network
driver as well, including those who also have tc-taprio offload.

Vladimir Oltean (4):
  selftests: net: forwarding: allow veth pairs to be created with
    multiple queues
  selftests: net: tsn: push --txtime out of isochron_do()
  selftests: net: tsn: allow isochron_do() to skip sync monitoring on
    sender too
  selftests: net: tsn: add tc-taprio test cases (WIP)

 .../selftests/drivers/net/ocelot/psfp.sh      |   1 +
 .../testing/selftests/net/forwarding/Makefile |   1 +
 tools/testing/selftests/net/forwarding/lib.sh |   3 +-
 .../selftests/net/forwarding/tc_taprio.sh     | 143 ++++++++++++++++++
 .../selftests/net/forwarding/tsn_lib.sh       |  70 +++++++--
 5 files changed, 205 insertions(+), 13 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/tc_taprio.sh

-- 
2.34.1



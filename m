Return-Path: <netdev+bounces-59609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62B481B80F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 14:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638A91F23C5D
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8584D60;
	Thu, 21 Dec 2023 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z3HaiBle"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6F83537
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrHKO+8xWxUX7IDLeQphWgRVW4HjK8BYQCpnu5I2jXCzfDOWSYqVSZ1JtOeN80edeFS1KvCXqrnFHsbObdLe0R5f4r8uv6aHVA5KonnNot/Sx7bKPchb5g3c1l88Bf5OjGYy0l0C9+cAgFk60Qsf7EKElNNbLPTBDqBX34X9ide4I0laxdj4HHYMFRR628k/q8fcrrO2TVunm3nEOjX+EDJmKz7Wb3MeVCggzh5NvElvJd2AyGKs0IO1qinuMpZq2KMO3BDVQEm6sPJJ5lo46QhHJ1kgK7+wfeBCF4yiA9aggr0k7g9gMSp7op7j65esBA2WgI3kuv2/wrIk3KIeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdzN0M0wlAI+u+KRKJ0OYulOiSDNPCGNv8lJgQweFpM=;
 b=fUxmkbsXdIAhEWcwo7Sjs7+3nuvsJnXIajsLCWjZ2vzPduIIL2osjaH3qoVBVyprAtGJuGRrlBaHg1MQywxaiOZdJ5LP8rChbHyTGi6wRODP3a5RAdsJVXQe49lJ6qYRaRPpvbo0O6GuOK6swEDrBm6q6pPQfUNXdicjpl7nyuWGJGR6iERPNXL+olzogK4TyfWZSg+4qRpmeGqVl+BGd5Vg0L8FaiE+6lbSKqRUa734tIW7/641Z3u8zoX/lZlJyBODiupU+ldT7V9FpXvFDZDlbZ7e/zI758FrprynPLlwIFTHMqDg5ko5iqKgg1K6m28QqV/Pf7A7tAvibZ/mkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdzN0M0wlAI+u+KRKJ0OYulOiSDNPCGNv8lJgQweFpM=;
 b=Z3HaiBledo2vgH0G1LrZdcp5dsX025H36VQBaFxgKQ5h8Rg4Q0TP+8JaFLbqJgahxj6UEsv7tW7A4wEwL1kGwEz6Cz5IfKCtuamM/iPWD6DXCNhrWn6Y/PkYOfI6WUTnQjDRq9e1JtXnDPvs/IASKJe67cRlyVR3jmQBPNZQVuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 13:25:41 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 13:25:41 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Subject: [RFC PATCH for-faizal 1/4] selftests: net: forwarding: allow veth pairs to be created with multiple queues
Date: Thu, 21 Dec 2023 15:25:18 +0200
Message-Id: <20231221132521.2314811-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221132521.2314811-1-vladimir.oltean@nxp.com>
References: <20231221132521.2314811-1-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 758afa58-c765-42fe-64f4-08dc02285454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xCkxIk5kkJwt8Nq5HJt6KAtP2m5EBzT7XzArDxJ55pvvulO8jqZKv+nItWZ02/iEP/ZXY4ZaTvDwXseKH0b/kapgihWAHIxZRS9WumYWOoNtrz4tF00h4vcQyF4lPB7Bd3Nw+4hVLLhjrOQuI2pa+IXl3PUpQ6Z0oKNyOVt8u4+AyITTs6cFM0OkWc/BC0hWTPAQw+bhagNkC1HsfvhG2EstjKIAvx//9HZIbZ0BQ71T8OIRa+SXlFc/a6NYw5fyB23tz93S71AosKn6BjxZSct6RHwV18fsbEUytsp7hIJhEHdJ8Ji0Zp9L+/8ErKDb6I05VYnkrHPCpZeoeBhtig0ST63Dyn9R1V1jU9aUqqaaBOhpZ3DnNGnlCl2Hopk0KfTSyRH+aRfDaTeoSF5K7EXawAGFZRtOHhzpgww1FJGbDH2OL/HxDdNVwRG0EmxvfhTXeeNXVwLHDO7gWJvOZt3RxbBjDINGd22h/PsqMlQK/59EW7wOiD6f3n22qZZ2WZfHYtAGcPS5SrUicvaflPoGefIcYOI5O3LkFyS6VvOxQl/5U50RT9uLGGLHV+VrZrP9pcnYSMStJz89wbIohapqZZlfakonVLvDjJdJSb3hFGwzW08QiV63FhE5jR/U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(6512007)(86362001)(6506007)(52116002)(1076003)(6666004)(26005)(478600001)(66556008)(6916009)(316002)(66946007)(44832011)(66476007)(83380400001)(6486002)(38100700002)(8936002)(8676002)(4326008)(38350700005)(5660300002)(2906002)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ga4yG3ty+Dt6BR0gOks0R2pKyVeD6h61M8RpkrXKXJicbcOYqx4FaXJpGNmi?=
 =?us-ascii?Q?yvCzUVy1y+g0jCqRbmd2k+XYBSut/5JeiMg93rSTUCReXidi1o+bKB7nl7rK?=
 =?us-ascii?Q?ctq6Ygu2B04KXRQRifWk5BZWIcX7U9qR/HcIR/I6Hg4LV6h6SFTWFtWOZrN0?=
 =?us-ascii?Q?ZijP0gT8wdZ1ye9A2Mdna3SuUPSr+D33aR5XcCytisgHAK/WmjtTQcrUmSOl?=
 =?us-ascii?Q?A6Oyr+LIJrtKA0fS72vTPb+/6qlM+fwX/PzW9c5vy5EExI29PUL6sforjnQH?=
 =?us-ascii?Q?3j4EscI8cs7a49UVbQasgfYilIVZU3LtVFldXDxJ3D/vCCLEKKSaK8f97JKK?=
 =?us-ascii?Q?HkEMhRuLcP0aYtYNN9TU60APjLrqjzB0US1H0bfKZ0njpVProOrKfBKJ+lWg?=
 =?us-ascii?Q?txl416gyW6AbGc6ANDmTzi7fiIhVcapEqSRvfAuB741KevN/+ny4nkWtR+62?=
 =?us-ascii?Q?6z6zCod5MefFrOmZ8h0mvM+TqflrznnaeVl7fd14jm9aL4v3R7mP4O8+3YMn?=
 =?us-ascii?Q?kmpJirRmpmHhVe0leqA2o7X0ExiIaLOFc0n4dtPvnSVs+zwhu6BHFMwrzBoS?=
 =?us-ascii?Q?99BsdP1P1PJU1Sn0Bm6fXqOyCGxr2ybbjJ2crmkTjcgVHXIhtYlyA7iSXQGv?=
 =?us-ascii?Q?i2obaZ26IxUbA95PHTzNzc8GDSBGOnQqHW8y489JdFCTLkcastBxg9wtqzcA?=
 =?us-ascii?Q?mplSrUUh3E/jwn2w2sIQkEPP27RJW5mGxK1Sq/9RskUPaYcUT594cCFzb9rj?=
 =?us-ascii?Q?LjDpWHc5iJJH6gPlJbzt2UEujE/hgDaGSd73GH7D6r4v483qRNUd2w3b5bMU?=
 =?us-ascii?Q?zy8X/bykzW91oG+NG8sa7afdsz6BFCowhDIzreWtr4XKpPloEibC3sDGtfZu?=
 =?us-ascii?Q?KkbbfK+0dprsVyNeo+A8g88ZBXKepnJUGLr2KG0Dug4opYRbccdatLugM17r?=
 =?us-ascii?Q?r5BxOPkUKgjv8xwk2/SI/mfu7+ukuWjZiSGkGWbvxlasqk1pteBn55R/hZ9l?=
 =?us-ascii?Q?i+Zrb+2z1MQwGKVnnbniC3lXq0JZpARaRJfDslkVV03qAeIkdYwtoNZMfCsX?=
 =?us-ascii?Q?jzFBqWo+avgaPoM5buJ4dC/zZN3M0FIbEeHofpSq67tRGmCYhCjwFheMIZNf?=
 =?us-ascii?Q?8U+ENBLa+ONwFLg+ZBqNX7Ep8USjMKMRTgpgVu/291I5SaQCSTG3dRCtDL2r?=
 =?us-ascii?Q?njnxavZoIsevGIB15V2P5tT1X2SRGwkyh42SEWI30qX+IB5NF/karvI0saBJ?=
 =?us-ascii?Q?EFsbBLfUmV030d00kXzL0Wzi5X1nWO0eUeJISL6cUQM5/GcWaRSyKDgXdO5D?=
 =?us-ascii?Q?s800GWzQ5hPv1vBGbSJo4teBBmgW9+iVCUOVUEs+/wthIPzxgfAVp3HktMEw?=
 =?us-ascii?Q?iiPkt+CH28txDY+hdwYtR27r6VSBB33h1NNu1htT2yGw0OSGkCheER6Av/VL?=
 =?us-ascii?Q?JclijmlJ6kMNPyh64hjo71amSHxwl6xNHAHZ6+FSKGpNYbqh1moTeftSbn5y?=
 =?us-ascii?Q?zX3iR8QPWyRiUlUr9CovmTGo+1zUEI58Dchhe0lqeXKZifFfQnBx6M20Tif4?=
 =?us-ascii?Q?iOVViU4Fieoy4WqP8DrXjV/mpAQ8YSXPO8Z0C84aEbB68MmrxAcmeLNbRwW/?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758afa58-c765-42fe-64f4-08dc02285454
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 13:25:41.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8/AaMmEWVrq2pf+krq/F7meraNZYxK9i8o1HBOMlUlseZICq5UXBiqsxPl4Js3pnfjc0QVMJcL4QY32OjnkhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058

For tc-taprio testing on veth, the veth pairs must have multiple TX
queues. Allow certain tests to provide VETH_OPTS="numtxqueues 8 numrxqueues 8",
while keeping the default unchanged.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 69ef2a40df21..c0736a591ca0 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -28,6 +28,7 @@ REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
 STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
 TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
 TROUTE6=${TROUTE6:=traceroute6}
+VETH_OPTS=${VETH_OPTS:=}
 
 relative_path="${BASH_SOURCE%/*}"
 if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
@@ -260,7 +261,7 @@ create_netif_veth()
 
 		ip link show dev ${NETIFS[p$i]} &> /dev/null
 		if [[ $? -ne 0 ]]; then
-			ip link add ${NETIFS[p$i]} type veth \
+			ip link add ${NETIFS[p$i]} ${VETH_OPTS} type veth \
 				peer name ${NETIFS[p$j]}
 			if [[ $? -ne 0 ]]; then
 				echo "Failed to create netif"
-- 
2.34.1



Return-Path: <netdev+bounces-273251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIwoDGGZymmg+QUAu9opvQ
	(envelope-from <netdev+bounces-273251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:40:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6146D35E0B4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7090A3007A4E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EE8368276;
	Mon, 30 Mar 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k0Sv9IFB"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC2366065;
	Mon, 30 Mar 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884648; cv=fail; b=ApaG7fD2fOMQ56fRC61zi5kKEjrsMmSZ4wCAL6ybrJ6lyMp4UugQiuLzpYnhvU5b3/UMYLZIF4UpAn3v1jfCIok4Cgc9OYpmmqsYy8c09IYqU6HIYSU73U4KVEKU1jZAs6WgS7BqNHsPC1ZC+LwJ8CzCnHMhFxpqKNvznpEkMLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884648; c=relaxed/simple;
	bh=Jpv7Gq8ll6shbnOZYdrFst1pdW4ArKTreRLu/XrHeSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UhWydMjirwND+ei8Ll11yb6eOa2T1r7CwpMIT3/dIbvqDsAoM4yOGlKjEsK+FlFTjxd5Wqy8KWGRyaL+ZuJuE5sykmOetB/53SMZ2HjKU23nD5ov0CWb/eWjO8+Hus0VapN47JzL9/0X2XSQgw6plDCY/sfRNOnbfiuBdFXjE+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k0Sv9IFB; arc=fail smtp.client-ip=52.101.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIOO+zrHkYVjeFPcqtEAl5D4ztTd83MUbXbi9mhviMvUTmqp+UaMBMGlNawOToR6AYp1bnxk+B6k2zRwis1QUVIDS2NR//HOyOOjsC0iABm3t3QFtWpCsaJfkMjLi6Vk62HH9RAgcI/1ZZG+7oEG5dhmny/87q2FLbKW6gPjj2jTa0JQ6yAum58j5fvHKM+tyabMp+76lW+/ROd905qcGIdhbpO9Ow2XNIiODR7OURBbSzoRO+6rjJPWwDnth5ClzBLVg8oOe2uI79MnMCOtJOT3WPqIaBmclACi5Pi61wBf56FbO+T56jFfmKwR3pMG1+pE7S9urieIeNli0f5Mig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdYqkzjnZPX3l4LrsA1HiLWXnGkw3HGGGWBtoVMQAbk=;
 b=yg4gEkDOa8dYZ2glpq65V6rFER1E5cpMfwTZMimigYw9wfs5Vwi9yOstXWFNZUtmg6MExeVUUQLzNcpfHPC+Wb86/v51txoV7dr/+kGf3jhBn8vG8UGkPtEt0rSWpbq15EDUyo35PO3OKDY4/v4Ef6iv+gJpC7EBvMvxkOv9ZdqomOExZJoKBqr7yOt5WT4XImGRF1DZIS2zK7YQpgRGryvsJ3eOfuARtDZhb7a0W01YM7/kCZxijnNksHZOUAZPM42pVux8xTSObDMiYWIdiQmev7bwW6F4717mtyH+5CxcUqiqhZOLfBDYs5YNekavBd9ibG3cucAVla1bjz9cXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdYqkzjnZPX3l4LrsA1HiLWXnGkw3HGGGWBtoVMQAbk=;
 b=k0Sv9IFBRXW86ksxz/jKGYnrxjQPccSDNU6/rXB5dLVGgtIPce+plsJazJBPxP6EG6mjf7Cenb2SFkiKb/ELYrHMdDDQ/ss9Xdip3MbP5O9RaAT+NZ/yDb12NQfmFJBLtZaV0b8kCa5u8yPG1BqSAeY2Dott26Vbn84UBIP54rEvjUNlQHSCUMgT4tj30LIvMt+FBWYeM9WtHy9ACJsHuJu1NMt185pvNze4rHjrYdmKnjQ5soz96C40pmTYm9phCmwx+3eJ6Sqoihtyp2e3qxjm48Y25sgiR8thfKYgk01yxHfeyV+glgoWo1/IwFl8jk74k4uCmSxQ/+90VdD5bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:30:43 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:30:43 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v5 4/9] selftests: drivers: hw: cleanup shellcheck warnings in the rmon test
Date: Mon, 30 Mar 2026 18:29:28 +0300
Message-Id: <20260330152933.2195885-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DU0PR04MB9372:EE_
X-MS-Office365-Filtering-Correlation-Id: f33f82a1-e3fc-4bc1-fe11-08de8e714ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	awDvHoRlz9Fa4CKXNVK6RNzgdJIus6W1kBDBw5TcZx1cMojjDggjo+Ippa8wC3lWodwFSmfUpQjSKh23JiQLa9zOmEwQ6r+/aBUEvr54Sd0rjuIGbBs3jrJPnn+tpVfYD9341MzCxx61X/ydUzFiz591kwnQ9nefq8o7hSTFBH1zf3X0g80wioYmEC+5U7Mvxu5kDnTY6Cy+hkLZSF4CMiBpPHoWn2Rq4WXGyiiAZYXSihmK3DNlOtLwKXSkESZ377Kc0YarFbFafXzlgdrfX5IuDriuBwJJjCiy/vUHpzXHzwFUKOh3UeJSgPSDa1MTwlexNUeHAvQXN5AoUAiUpcdsUf5AWG8+jQARobDPjkQUja/C0ZXRuSj/X9sYbURTIYEIcDTJ8nsAiXEjF5QVPqsSroulMdUKvTHtg2aKGvdM4jXEqwuLDJGQAdJ/sgOVx4fyB8Wz0gHpCExrDx46DIQhf07W4cRWmP/lNNKEV+lyeUpk3ZGpttgEKcOApmGjK2ZYs/rxt+PuoS6c1hW9UrqYgdbD+1Apy73+VUYTTwsw85HCBwfGweZh0u1ze0qfwi8BpMxqVCneMvPoe9Q9P60uBT/dAQw9ToDcVl/b9y0dxf6KAKCvDIGBcvvY+nUmjH7FdN7OMGYmiC/RSDvEcJDiLI0iFcc3SrLcGFskYZkuSbDuBc87hH+PbViXl6ONjxID1jLfNWRnMmUI5PmGI3eKKr+EPicuLBHWjrbfAgo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v/ZxoDP6dZZE4dyKhTHQJm+9aM7ewDokYJctyI3gMHVbqQKPSxn4G6aDR31a?=
 =?us-ascii?Q?b02ZeH82mxkLYw+3vgwphNwZvTYLyYabbvm8aIiW9xnSVo8GRr4Buj1NKCkp?=
 =?us-ascii?Q?bQCh5hJPzPGsjFTBtfoKFNx58IwDiGpEIycVVyVlI4XRDUSOG10y45ovBtaY?=
 =?us-ascii?Q?8WWTMSieWLOAjtG66Xo7Jz/oDZ1hoCf1QLg/26+441P6xxWevA7jajtz5/X0?=
 =?us-ascii?Q?9BN6c05pmh6M169553P8u/XJCjtgxDK6Xgj7+3+uldHwv3uMQa5c0FZqfzoT?=
 =?us-ascii?Q?bmLHo5vNtSOX/FwroRyVtBnxlHtEY0h+eNbZ2ikZFYZHHUCDn4uzMh1PGKIe?=
 =?us-ascii?Q?wkqK4bBXwxzOhdlZv7LEUDyjelgWInXfpdztBGAHOSNCvDN6aHORHPRA8qGI?=
 =?us-ascii?Q?2wLWxXGYDU1SRroMnFRybi9qWnUCJLh7VIMXwjPIpx7Z73m9mwv5lG13BD8+?=
 =?us-ascii?Q?6koa9OdkAy0RPE9M6TpHMj9qZhkJT09s9SvRaXaKvLzpCSyIdD19NhznD+7T?=
 =?us-ascii?Q?rvWj6VDMQVTxpMNofV09c+tPZS2Tqvf6dNvj8rFHqSZ3Yny5qX6rdGrUQnDe?=
 =?us-ascii?Q?jiM2teZhbumSCZ136O34I8q0Z2R2QS8/a9fqTsnuY5xxvuQQjzsQxs5k9j2d?=
 =?us-ascii?Q?DofqHbUwIZpZ/uFGUBQGZB5sRWbskD6cUgmrElgONn9oogoJif86ihilnceW?=
 =?us-ascii?Q?pGXEM7ibDT7bxk1FMacyezT0A5Tm3O7SylgYTq55qCBE0n6ZoR/jmm7MeRto?=
 =?us-ascii?Q?CxTwNM2kJXzx7aFbsyh74gK0xA0UBxEL9xWwtJb+LXHjnBglftfPlLn7q1fN?=
 =?us-ascii?Q?5X3Je1JogVehICpP9/3UhswjQcZy4F1h5fxkcHM99Lrl4fMD5yR+NVkdK6LQ?=
 =?us-ascii?Q?bOvwl2/9576fOo9j7zZ0X3ZpBonNWgvMi0xi5KmyluKKmGFLgk68Fe9xYC60?=
 =?us-ascii?Q?gmhJB4KMAaZ4uWsdzyKS7BNqvM/f1rSGI3TYsNFrOfagHDncPHMbxXv0t6DP?=
 =?us-ascii?Q?7yDbpGNHzMIXqpwfdWBfiAXtjJ7E7uh5gDszsCkzNVpOmcMZc2UELU1rZ5xG?=
 =?us-ascii?Q?kv4waExAxqyzGS6F7Gd4WDIUsTUZMi43kIpBvyGdPf4k0/40qxxmGpip4eDq?=
 =?us-ascii?Q?s8/VW6HVG0KeA/QGdTwkyRhljWfjcX+rhXIrAP10D8vHPoD2Wb8yixYhgs1Z?=
 =?us-ascii?Q?ClxQRlfe488peUdIWWQtoZwl4iGjQ2Mk1pycvaL59iSW6iPv8VjmePRQ2GT8?=
 =?us-ascii?Q?hvdCGazT0/F0Pu4wj87ug9npV84cK/Iq2/oQX4NkYuo+kZcD5ga/ui+lNXOW?=
 =?us-ascii?Q?pDX+MMfpLIT47GcGc2ljmrAU+Kz8SOddf89K+lZqrWjPTxd6dBmss93XsK3s?=
 =?us-ascii?Q?/y4J3z1wDdVUIF6rMlenw4Pla6GGPX02xLBfp+YuZ0FJew8lRTj8Sj73UnLX?=
 =?us-ascii?Q?meD0emUxMFJsQFnalRYNrJYTwJMvaE+r7MsC8PL+SlGPm1VyMi7OA4nxVaNn?=
 =?us-ascii?Q?j0BglKSDoxvbU95wCfyKe2gam6r16YsvRP7rTTCdPrkWd9WJqIU+3yalZz5s?=
 =?us-ascii?Q?NVVAQ18LrvyV0bWcsLjhksLaQR0HX4Un4C4tWOp0QozptqB50UCImJDEzAFQ?=
 =?us-ascii?Q?OI+7tjPag5oTI87YhKnF/RRnNby6DKeOiLjW3XxvCXgyOyO4uk8y7X9Fx27g?=
 =?us-ascii?Q?lAWJtGPV+szZ3sysZQa0D+RGQWFPji4aSiv7EXUIGJr5fWaeRlZaIRIZJ5R4?=
 =?us-ascii?Q?J+HS1hHNmQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33f82a1-e3fc-4bc1-fe11-08de8e714ea5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:30:43.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uVyWTRSJj9NVylzWkQ21TitGE+jMRW/YmXWpE6O8+uv4XwS0R3HUOsdaT25PkutAkBDsq8xGzd+A5WLNFHeDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9372
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273251-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,ethtool_rmon.sh:url,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6146D35E0B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If run on the ethtool_rmon.sh script, shellcheck generates a bunch of
false positive errors. Suppress those checks that generate them.

Also cleanup the remaining warnings by using double quoting around the
used variables.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
Changes in v5:
- none
Changes in v4:
- split one line to 80 chars
Changes in v3:
- none
Changes in v2:
- patch is new

 .../selftests/drivers/net/hw/ethtool_rmon.sh  | 54 ++++++++++---------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 8f60c1685ad4..13b3760e3a40 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -1,5 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
+#shellcheck disable=SC2034 # SC does not see the global variables
+#shellcheck disable=SC2317,SC2329 # unused functions
 
 ALL_TESTS="
 	rmon_rx_histogram
@@ -19,11 +21,12 @@ ensure_mtu()
 {
 	local iface=$1; shift
 	local len=$1; shift
-	local current=$(ip -j link show dev $iface | jq -r '.[0].mtu')
 	local required=$((len - ETH_HLEN - ETH_FCS_LEN))
+	local current
 
-	if [ $current -lt $required ]; then
-		ip link set dev $iface mtu $required || return 1
+	current=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
+	if [ "$current" -lt "$required" ]; then
+		ip link set dev "$iface" mtu "$required" || return 1
 	fi
 }
 
@@ -46,23 +49,23 @@ bucket_test()
 	len=$((len - ETH_FCS_LEN))
 	len=$((len > 0 ? len : 0))
 
-	before=$(ethtool --json -S $iface --groups rmon | \
+	before=$(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	# Send 10k one way and 20k in the other, to detect counters
 	# mapped to the wrong direction
-	$MZ $neigh -q -c $num_rx -p $len -a own -b bcast -d 10us
-	$MZ $iface -q -c $num_tx -p $len -a own -b bcast -d 10us
+	"$MZ" "$neigh" -q -c "$num_rx" -p "$len" -a own -b bcast -d 10us
+	"$MZ" "$iface" -q -c "$num_tx" -p "$len" -a own -b bcast -d 10us
 
-	after=$(ethtool --json -S $iface --groups rmon | \
+	after=$(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	delta=$((after - before))
 
-	expected=$([ $set = rx ] && echo $num_rx || echo $num_tx)
+	expected=$([ "$set" = rx ] && echo "$num_rx" || echo "$num_tx")
 
 	# Allow some extra tolerance for other packets sent by the stack
-	[ $delta -ge $expected ] && [ $delta -le $((expected + 100)) ]
+	[ "$delta" -ge "$expected" ] && [ "$delta" -le $((expected + 100)) ]
 }
 
 rmon_histogram()
@@ -78,23 +81,23 @@ rmon_histogram()
 	while read -r -a bucket; do
 		step="$set-pkts${bucket[0]}to${bucket[1]} on $iface"
 
-		for if in $iface $neigh; do
-			if ! ensure_mtu $if ${bucket[0]}; then
+		for if in "$iface" "$neigh"; do
+			if ! ensure_mtu "$if" "${bucket[0]}"; then
 				log_test_xfail "$if does not support the required MTU for $step"
 				return
 			fi
 		done
 
-		if ! bucket_test $iface $neigh $set $nbuckets ${bucket[0]}; then
+		if ! bucket_test "$iface" "$neigh" "$set" "$nbuckets" "${bucket[0]}"; then
 			check_err 1 "$step failed"
 			return 1
 		fi
 		log_test "$step"
 		nbuckets=$((nbuckets + 1))
-	done < <(ethtool --json -S $iface --groups rmon | \
+	done < <(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
 
-	if [ $nbuckets -eq 0 ]; then
+	if [ "$nbuckets" -eq 0 ]; then
 		log_test_xfail "$iface does not support $set histogram counters"
 		return
 	fi
@@ -102,14 +105,14 @@ rmon_histogram()
 
 rmon_rx_histogram()
 {
-	rmon_histogram $h1 $h2 rx
-	rmon_histogram $h2 $h1 rx
+	rmon_histogram "$h1" "$h2" rx
+	rmon_histogram "$h2" "$h1" rx
 }
 
 rmon_tx_histogram()
 {
-	rmon_histogram $h1 $h2 tx
-	rmon_histogram $h2 $h1 tx
+	rmon_histogram "$h1" "$h2" tx
+	rmon_histogram "$h2" "$h1" tx
 }
 
 setup_prepare()
@@ -117,9 +120,10 @@ setup_prepare()
 	h1=${NETIFS[p1]}
 	h2=${NETIFS[p2]}
 
-	for iface in $h1 $h2; do
-		netif_mtu[$iface]=$(ip -j link show dev $iface | jq -r '.[0].mtu')
-		ip link set dev $iface up
+	for iface in "$h1" "$h2"; do
+		netif_mtu["$iface"]=$(ip -j link show dev "$iface" | \
+			jq -r '.[0].mtu')
+		ip link set dev "$iface" up
 	done
 }
 
@@ -127,9 +131,9 @@ cleanup()
 {
 	pre_cleanup
 
-	for iface in $h2 $h1; do
-		ip link set dev $iface \
-			mtu ${netif_mtu[$iface]} \
+	for iface in "$h2" "$h1"; do
+		ip link set dev "$iface" \
+			mtu "${netif_mtu[$iface]}" \
 			down
 	done
 }
@@ -142,4 +146,4 @@ setup_wait
 
 tests_run
 
-exit $EXIT_STATUS
+exit "$EXIT_STATUS"
-- 
2.25.1



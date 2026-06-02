Return-Path: <netdev+bounces-294061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADygN9iFHmqhkQkAu9opvQ
	(envelope-from <netdev+bounces-294061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:27:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A118629ACC
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54E85306B535
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02630357D05;
	Tue,  2 Jun 2026 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OU1eDUTk"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40459357CF5;
	Tue,  2 Jun 2026 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384842; cv=fail; b=gOjqqdsBNvoEFSy3dnbHi8bNAO82IrqX/EL5TNdvof7IrkmUpIk9JwrkHx3xiDNawlXFe0gZfUM2xIH7VsNiRKWhVNo0S6MPo+tOHvFWZX7VWD6W18IOkZPuRhv2aZX3y8ucgwkDEoEIHopQx+03daqjisIGKwZ9O6P3TCNHQps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384842; c=relaxed/simple;
	bh=M3K4V1HByJAGVPevslYWbYlpxHI0lNdx6G1GX4HukyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7s5gfwbtWYY0ex9J+xtbDiarjPQGlRjRVxZg/u6WfLSahjZ07c7oGUfNma4NOsVXs0QosqcAuB6WDs10T5z/vpfpprH93xpXKeKGBJbFGm/J42WPTXdn7e3W/+4sojQjud5e1fabcfh7W+hqfVjtpJJw4rYxs+yPm+yFnYXxQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OU1eDUTk; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aO6EYB1at28euDZuueX0nHQL2unseg0vs2txf1m4uUv1g1CzLw/kk/caSsgWqEKyhqwIWSRq4X4FWlZWyTK2A9AV29bO2nx9h8ewJxRJbuO9zOBDO23Q5oKEOue+SzLGJhVZjzQLGD23DeLWSAkY4Yfc81QF/dj8lD7DmJPEDNyDUmK24UtiuGoIrkaNWZbFdx9EXdKfkxObbwmpa6W2ihyAL/9CVfx/X1hsHhlQ/4BQp3Yl767ikOjseG5yo4Hx0tQl79pRVvrUW94+0co6RmfZ4t9vBKr5QKQjjOmN7iC0EhM6rVDxN+Y3HGhsy3YCv8mtBqrA0BchdCh5Bt7cvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taswxPa9d+iHf1Hf5hGOtAK4UVZt+Snw2Ic8ZBaB3aM=;
 b=Ej+cSGSW+5sgyrdhJuTKOCKMPCJTBOTbhHRDrrOooZBWa8OJB9zLxVOWwRukl6Ce95SNQGCgWTqWm0NYE2mR4v/tNTkIdMjE1tjYjjnUb2NXwGa6YcQhKoYZGm/V8yBdvr8FbewywMU32iICOL7S0aAAuEi8RtJPja41RfHZkVqPW7xVTyK7NclhaZqrkSlZ/5L3qxmg7H1ai202JlbPL1cEA5SWoFWt5YosEfzZ6Ysi4LtFwOMH6daAuLDdbL0+DggTSGcEJozcTDOKJlV9pIvz1eazLpDXNAJD4j5s9Ev88KbX36NrDx2MDflRYT9kFqX3FsG0mZJfqUuPzHNKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taswxPa9d+iHf1Hf5hGOtAK4UVZt+Snw2Ic8ZBaB3aM=;
 b=OU1eDUTks51WmJUK2NZm0KUpQdPpEj6uWL4f8S1Pb7KRY1k8RoIut8RzI2DDhmR+0zVZtXTFWBgAuhQnI+a7sbV0DSyJzH6uwz8CG+G1ayl8MhvCDsRmyBTk0WB177o821o+5Irr8bX9Y3Kndb1EpWLzpdN2cve55zT7JIEQb1INnRj9yfds6rSFEQXoeHwV2WoQqGN9yu3zH63iB7+oG8f/gEg6wHfMPvnaCJ/awEX4ZB8t6ipsfImpRCrxtKa/K1XI/a/ZaIGc9GxG7Y/PoKauEzYKhgJrLdqPdMT9VbNwPhaiTamQ8/oRHwXih4PfwItKIqxFqOIGGPwZ2q0lNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 07:20:38 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 07:20:38 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 4/9] net: enetc: add "Update" operation to the egress count table
Date: Tue,  2 Jun 2026 15:23:08 +0800
Message-Id: <20260602072313.3162120-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
References: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM9PR04MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 91223132-5079-461a-3574-08dec077723e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|376014|921020|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P66eBUy4KtC8Pt1Kh00YhvPlEFB5wwKJVexVwskb7Y1L6jQCAOI3qzCbYFtjwjymwuj2IcOfzCPoegy36HO+r1/fz70O+AcdOBHe6SJXAYsKXdX4QUEslp1NLSG/WIb/a+BLnYKcax2M2bOxIN310RhpSHyc4bo3a/M5gyYTuCVMkAGUK/HyE8RE3pgiOtvOOaVLSx4TF2RtBekECH0rVcQL80KgStq4rwBlxAevaG1auTZbd01ZINg/t6QWm7r4cd3B88VJjLpeXFoOdwf1n/r6q/oOZ4HW9j+TLVPFEkC3P/3QZilqezLMV6F5ykUPoPja4TrJGA5wy/CBNLx87R/dVo8lyB/l8ScV+152N94jSTwCnDNFxy6qKX7kwm8W59nfjj4j80D0wbrtdEpRLFX0EOM7RxW+2y3prQY7viI42PiDkif2Nxix45Jp92p1Z5dycbPmOVr5M2Ima4pVjPGNaE0oVmv8vdHnCACk0/fm6CoPrt9SXqouosAwnFnR5l73cg6+7ABjCeuzg39XXCEaVHAO9tEGlab6tZMwfEnOOU3M8gEqvbWX2sVc0i7gp9jHJk1Ziz3hH3c7DwBtFvzw1lmvtOsReoZy8GocAY+bjCa6EWV8tmX6oKhWo4DBCDw8lMk7dM39P81FEIub20T2RXLeaWcroEZn53iz6D3PR52x6ymriVfNQVBApJLnEqPH0guUYn6yVaCQX9QNcrU4ARGCnrzB8KScKyfw1Nw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(376014)(921020)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mbEiLonFhMOVAfNZs98SFVseAy2EVM7rJfUFpN4aN8ufimQKRHz1b0lT/wxC?=
 =?us-ascii?Q?AzboX1rPqOzo5DW10fPXJuctGDNS4Bt1yhbzcdVf2sYXZvYUHccp/QU11qHx?=
 =?us-ascii?Q?m/mtOpgKmokmLeGJna9skAZESv1xoU6TjsaavO0c1xY8Svh3effZPE/O3obj?=
 =?us-ascii?Q?krli3L3MLj05TrSitaVqg+b5kjmN9QXGVwTPU8FmhCEUEyo8NM59lO8MxSXe?=
 =?us-ascii?Q?4tgo6iA8gyoin2LJDehW72a3yMv39bc7wvO8mM2ycNaWBn3k+QIqqE1Q8dT2?=
 =?us-ascii?Q?KRCtxY6EHD8XRR8pOtbUKhF+Zte09tk60ySC0WDIgcH37ad48L97i1cVkMHp?=
 =?us-ascii?Q?+bADNmQCZM/gskm4xV8IBQz/8AJ+GngTjuIDmP64eSIj8fzs3AdoLstPfp16?=
 =?us-ascii?Q?JIBuIiYTsOXiU7vWGoI5vqcw/7I1E+66h7tVDlmPvSlhmn+SwYLzuTl5L8VL?=
 =?us-ascii?Q?Jf0OYC8EKhU27EUdm1N1aG7etYL5LHKmvwGTg3AP7vK31Dk9xK7izKrSUKnf?=
 =?us-ascii?Q?KskyYzuVCBXf3smihhiTOBmIriT4EF+TolH8r//5p1hTus90hqgqQ3JNEIW8?=
 =?us-ascii?Q?eiFX1w6RSCDUnWfuDBw5kTxq/OD0dGguffpJ1fvd76GsmhteoGVkZqFZqd9K?=
 =?us-ascii?Q?/ZSV+Ow6CLPYHo10aX1OieoQk8hNe6PPGCCkLRV7/GTEukTTpwHrdIsifZ+X?=
 =?us-ascii?Q?Zlt5k/YbzGDoNGn7lSH5QZmuJ2WtEAQ6zHa/3jBCFcdufd08nuGzmA3Fk9/O?=
 =?us-ascii?Q?bK3O6em9FyYXMAt/fGP+s9s8h6tI2VzogC5s8NGFihYnFUsV/y9+MkKpdwZD?=
 =?us-ascii?Q?gwp+JK6BvyvL5pG3FmN3cPn9+VYAXhpJu88tpSkcR8H7YGi7wo55mxJpz5tM?=
 =?us-ascii?Q?GOBvKzPIzTgJLONAY7LH4dntsy35dtN9u8bUEejWez8mxtz/0YPGE8DKNukI?=
 =?us-ascii?Q?hhE/Yb/bwy3/q9gvWkwcqlGYBlXaMLyhybsZgcQ0hzAZkECT5qo+aMQ2VnkT?=
 =?us-ascii?Q?VvytP4ug/lvUtT1K4z4RFAGb1JnpVQIvp2vJi+n+a6jS9eB0Z+EAyf99K02w?=
 =?us-ascii?Q?M7Nu5mIU3v6zSqj+Isae61p/v7En+NiLQYTjw7Wtwez031j1ZqdzPU/CfnYk?=
 =?us-ascii?Q?TwN24iRr2MElxLkffMdZAI11xKFgJJPD2fiaEcUKTuLSFwZcR+nIG7Q67BGX?=
 =?us-ascii?Q?0GH/tOVYDUsDLPTmkVG9jQGbjP+ZwHRI40AIQ3ouEbPM9Bme9scgFof4Al65?=
 =?us-ascii?Q?q3m7EcWq+AFTLl86IyXw4hN62ch91SmBzLPURBCNOGVxLAlOAHNITtKxV10H?=
 =?us-ascii?Q?Z09q+e+0h0U3NTMS1SWkHTb5QLIUIdqa0uiYSFWOwFlLOdX3s6KCYtP8v0QA?=
 =?us-ascii?Q?jCu302um0clEGMCZhbT84BzRJYothQPLbCAs9a8OHCWnSBtGVOI/gQS0ph9s?=
 =?us-ascii?Q?KyHDt/cT2UPYMJQC4z8rDkEHyjV6bbhzB3u2hNCYa7C1EIVFNKkisypcGtCg?=
 =?us-ascii?Q?Dvsms0o7SaJJgy0rQiYz7FE9gAThnsP4sFzaaOXaHE7qATAiueXtgfesZDgr?=
 =?us-ascii?Q?ZqeHHLYxbamwiItPj36uN6TCIC6NQUYFxkzqEQCHYw8MKBw/60iRwDpZkpr+?=
 =?us-ascii?Q?i/pbgX2uQIpnHrvMinr5he8fA2H4G1J3kWJGuqRkgxWYXvivNChbLctbbF2S?=
 =?us-ascii?Q?/HTcufJ4BP+tgeBffHk4alhTKN+Xp3E6JN8Wt0zBzWjZnQBbWIXbJKe9g0ag?=
 =?us-ascii?Q?sgL/9EQnkZyXaLgh9anipTaHOoHvp+shK1Q19Qj9KFjqltE46OWr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91223132-5079-461a-3574-08dec077723e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:20:38.4778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCzL8bBHKPiQfFJsOAb0gWEWz+6+XqfPJuc7rKSDPtkrVJzP69XEwX1pzuD38y+MJ1c1iQCWdfinUJ6JrS+yUDkCGyrvZYDD/22Yq2O9LpdypKMVkjPLllCQj2uyP7Vh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294061-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 5A118629ACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wei Fang <wei.fang@nxp.com>

The egress count table is a static bounded index table, egress related
statistics are maintained in this table. The table is implemented as a
linear array of entries accessed using an index (0, 1, 2, ..., n) that
uniquely identifies an entry within the array. Egress Counter Entry ID
(EC_EID) is used as an index to an entry in this table. The EC_EID is
specified in the egress treatment table.

Egress count table entries are always present and enabled. The table
only supports access via entry ID, which is assigned by the software.
And it supports Update, Query and Query followed by Update operations.
Currently, only Update operation is supported.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 45 +++++++++++++++++++++
 include/linux/fsl/ntmp.h                    |  7 ++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index e2f439cb1942..03a4ac6af56e 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -25,6 +25,7 @@
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
 #define NTMP_ETT_ID			33
+#define NTMP_ECT_ID			39
 #define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
@@ -33,6 +34,7 @@
 
 /* Specific Update Actions for some tables */
 #define FDBT_UA_ACTEU			BIT(1)
+#define ECT_UA_STSEU			BIT(0)
 #define BPT_UA_BPSEU			BIT(1)
 
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
@@ -287,6 +289,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "VLAN Filter Table";
 	case NTMP_ETT_ID:
 		return "Egress Treatment Table";
+	case NTMP_ECT_ID:
+		return "Egress Count Table";
 	case NTMP_BPT_ID:
 		return "Buffer Pool Table";
 	default:
@@ -1197,6 +1201,47 @@ int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id)
 }
 EXPORT_SYMBOL_GPL(ntmp_ett_delete_entry);
 
+/**
+ * ntmp_ect_update_entry - reset the statistics element data of the
+ * specified egress counter table entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ect_update_entry(struct ntmp_user *user, u32 entry_id)
+{
+	struct ntmp_req_by_eid *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd_eid(req, user->tbl.ect_ver, 0, ECT_UA_STSEU, entry_id);
+
+	/* Request header */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_ECT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ECT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ect_update_entry);
+
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
 {
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 0c951e1c763d..1123d060713c 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -37,6 +37,7 @@ struct netc_tbl_vers {
 	u8 bpt_ver;
 	u8 ipft_ver;
 	u8 ett_ver;
+	u8 ect_ver;
 };
 
 struct netc_swcbd {
@@ -232,6 +233,11 @@ struct ett_cfge_data {
 	__le32 esqa_tgt_eid;
 };
 
+struct ect_stse_data {
+	__le64 enq_frm_cnt;
+	__le64 rej_frm_cnt;
+};
+
 struct bpt_bpse_data {
 	__le32 amount_used;
 	__le32 amount_used_hwm;
@@ -294,6 +300,7 @@ int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
 int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct ett_cfge_data *cfge);
 int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_ect_update_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1



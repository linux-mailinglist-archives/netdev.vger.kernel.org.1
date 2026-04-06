Return-Path: <netdev+bounces-275744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK9hMzYk1GlxrgcAu9opvQ
	(envelope-from <netdev+bounces-275744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:23:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D505B3A7843
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AB5C3017790
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 21:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C99438F22F;
	Mon,  6 Apr 2026 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L12DkHc+"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D838C433
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775510538; cv=fail; b=U1OG031ogRnux4/npT7zrYClYl15BNdn7Bt3n9nXz2QGkHdvXyKApFyALNpTIMtoDU4+i/h+fo0aCeN24I8LJQ0hFBSqZ3tNrHn+ln6Ukml3dfhfPfMF9eUPoNnNXSByXAs6ngSQNAY6PmoNX4fHSNGUHPjORxvK4jaMzJxHJBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775510538; c=relaxed/simple;
	bh=s6Hf1nBjt98C9IziCQJVOnkDJ4KOqAbpQnUieUELpjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qd/ZNseunqSE8bo0R0kUqCjRGT4N9C79D4Wh5QPuqFsifXqVHUKGKDdPMq5B5cyumBAmwjtUYg7YzBDY9x/9OaEqChu3YS/Q6Sx6IpDrwzUV0emQdPVkk/7KAo4WuEHnJiE0B7ruC2I9S/yctnkq6pFRadqrglNh9+LHvWuULF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L12DkHc+; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGwrUGRGjfRrxbAeuuWR+oMr0kbWYOJbscH0U9T+V48T7bXMWPIVCTjNBTrb0Zs7nVQHmyIscgfElr7b5cn+nilc8p96J7d5I4yh45ZFQIu3G9U1s9+ZSoJZ59NdgneC+tTEuEoumBNc4qcUG6SN3H6MqZacNY24eOrW2FUhegVxq8sIWX8JlujOAnmQx+e4G7WivH3MU2bYFDH2Nfb6/B26nv4zsUw1jqnLh+bqFh3x5WW2WENLeSv25tWTUKzMWaWJ0j5zBhaEJFEwNStibD6XuKb49jFyiWf8G1M75TPNAPl58LCNlAlTC0K4+dOmue94hIBR4HATcVRItTr+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuDIZ2ut68r4J6nqF8WYYn2EXkRwvA4DGQME6wyUijI=;
 b=XD1pQ9E7s56UJvhZ65imJsYvv6rsnMSz5Y53RXncY7ucd7+eb4/7EkxsOgIDTmL/wxGAHtAieVYF5vP4YS2mc07sHLei2gdIYChHyZzBa2A4s8I9Fd0LXSCWbk3M6Gs/zBmdLFQlTLKWdciQATP4fFPcG6M2J/vNT+inNambHpjP4D11vYknt92kQVMUOgsmuBUVEWzKZusJRIQCodB4cVfsL/+7YTWgyM3d6rNublzLywloCoJNqhQ5ilkdO0gntFoTTVJS5nXE46VFVEHabsLWCCK7BHVwvCslcDYza8PBfoNsLShIVlSL2dRa4xl91RIk4Ad2CG4Cn4NvRNHLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuDIZ2ut68r4J6nqF8WYYn2EXkRwvA4DGQME6wyUijI=;
 b=L12DkHc+gVu5zglc6Bjm4gaQB7Z9uBksKHLThrko1jzAP3x/3m7EttN3phRCdvZR09/kPJfNdFcYa57udIK7WtLsbfK6WAHCtIgW6JVmu7EZCDCXBmzYTjS//mmkXT+U+RIv79G5gCfG5MWTC68BQfLDtqei0rFg+8OR/5wRgbLwwDK/RBYe17l6CaK1ELePTfGGHrKneNni+RR09Lm5iiZMC60Am0zfuN2Hq4JFJIWTi6r8HEENknD0XGyOLlWldCtagk7wG70JPz7pV3JXbqLg/oDldnufhZ7a2Eb2NPbzkLNa/0fQ7hBHqAR/hyCEytUbNSslPuXNWENHG4p5vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Mon, 6 Apr
 2026 21:22:13 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 21:22:13 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next 2/4] net: dsa: clean up struct dsa_chip_data
Date: Tue,  7 Apr 2026 00:21:56 +0300
Message-ID: <20260406212158.721806-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406212158.721806-1-vladimir.oltean@nxp.com>
References: <20260406212158.721806-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::28) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS1PR04MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a139fe2-fa73-415f-0732-08de9422924f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jzg2CrOLZ5sQvTb+WIqHYzceSXohSA8S5wsRNwZZ0TONf8jqadnutORqzNWi75qgo9l2UrEbRepeGPPmhspPE1kjjYT/VgkyFa/ybCh6P4dPON7prWv2/nvXSgl4N6yzT9udbeUqik8oA0JIRwEyZ7Urk0ELSPPC1fC7D/9PB/DnTcGq5NBe+CVXjUp1YzQZi73eyUkf9L1msIMtLJ7BFnrGCFk1zFZGciEU0RT/fyMSUT1D6rYTi06w7T5y41UlwT6bOCSm8FgXpQCXiXSkW4vWwEy+V1SxAAzR08v3w7eWC674h93KpWR9Tm9/24wRHnCnZY5d/KAoM8dCz1ZLoP7TizW8+fBPTuzyR1srok/T/VBQnjDOn2lJBbnwmYFtJ6kOCWTH5OTMfuT6vT6zs9d/Zg9SI1gK0RD7fOWZe+UarR9oxEUldbSYVnuZpEPjSwPOhLg1cEeZaXwASSroLDxsXGxf/W9wqkhIx9ytKPMDEI4X+emgnrtUcVhZVwx9W+NcWK93gn/OsB8IQvyx2Desn217ksdZM/6bttxTkg5rViJf8VQahCfCHVWm9bsdZDOua6Te+C64WwqBQJKpMhMYvvLvDmvXlWF6v5STHLG+C/0AFfbzu7f+Qhxm6LFOcSCBeh/BTDoqZF47VidUfxdXKKHNJ43WPJPnDKK/YyA9IKCuW9+dUH2JHyL0KP8BhnongdJaLmoOzAoAaAiGy49Oli91eCpn23Q4HQzJnS0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9EMQ8JkWVOqjwWkRIuiT8UtS8IyPujumtI8Udq3p4en9EHOnUivJOnSFSSGB?=
 =?us-ascii?Q?e1AI1qQ6+KoxmrJiCDliw8BXvYwIjPfMixkgjLy1ZrRnqGxGg/Cw0rTizoNm?=
 =?us-ascii?Q?8IwalAn5QbB6RAm3PNg2VZCdJ9rbchQSMlwMW5o+ogboxrItXLK8DP5gpOtM?=
 =?us-ascii?Q?S2LHqQE/GxAxELXVxDvYoOe6QNjmA8FkgZ2KkGPNjTZqK1CE6xm1tlOH6Dcc?=
 =?us-ascii?Q?Y2Ym3I5oP/iNHHQ/xUG25soxxEXQxw6SFgcJ5u2gjS05PV/wXe83LUvGyv6D?=
 =?us-ascii?Q?DMav6hthhEGcnE0bBmB0U9ML5MyeMmM05dnXRCiSnjO21+JVFk9dzTdxxPQ5?=
 =?us-ascii?Q?/Ck/SWHGu/G92Hxhh79Y0ubpPd1GnWQ8iqdF2M/WsL2nt7+87A8ShMLfVmlm?=
 =?us-ascii?Q?114qs4DeLwD+YJLIoVNLOyrc9ZLdshgQIknxmlXAbuZO2Ewl2HZek+l9g1Ky?=
 =?us-ascii?Q?BWWhINcyZhjBCzM81AeHT9SIKAyhoPi8ger5sOLjwuhtR2Jrt6ogzUpbbtyO?=
 =?us-ascii?Q?ofP4WcXb0dayV/n14WjfgGpNrFyeb5Eng+X7g5Qpubv6CyaZwQQ6m6dReYkE?=
 =?us-ascii?Q?s2Bhg/B9zoLfgVG9gxM+ceFVD83kSqMmWdLO/t8cpqXMiaO15CTHOCcnOj5I?=
 =?us-ascii?Q?pOLNGVvdvOiChvzquiBUII5r4kDbNbq08xCpPoYdPRT22ddFfUQ7bhY17Zo4?=
 =?us-ascii?Q?K5AurvFoV5g5v5vJPfZwJEa59Uyy832b4PXWxococ4g1pB6JcHytJnSqnQKW?=
 =?us-ascii?Q?JYwzuGD+tVxXOkg0Zc8jbCSdcHOkzs2WEFT2qL8iYGMhqwItkNQ8xDqP8Gm8?=
 =?us-ascii?Q?D3BeMhrX2VVS86QCB49yqHuBIXfs5ndZRUybyxl56w1uyQ3LS/V6HUR6YYen?=
 =?us-ascii?Q?Tt7yBW6fOJ5KmFvkj7k+nmPgENMcTeBKqgvecVDYbEnv+pry3bc8MstwOEvw?=
 =?us-ascii?Q?Ft16mJ1XtlbuDq8fljQo6tVA+l0uh2eXjZ7AaFy4+YYekB5mkBXIhG7w+trT?=
 =?us-ascii?Q?+4v2pbwLQyLMScC34EL4nFTFEUniaed1JXBmRqGrGKbzYDie8dHwvT4lAN8u?=
 =?us-ascii?Q?Nfjzy4igOgyu2bcW/9XWlmahbfXyu3pX5hsSKpdYwmZT9wOi3vWI5WLfU16W?=
 =?us-ascii?Q?z+8WaNY2CkBTChGizNSW7lDKE75SUBtYKbxaxw0ns3Sdl4Ed9/Wx1OPeWU9t?=
 =?us-ascii?Q?soEppAyK9VqTYBZthfLjQKwYUMwiImd+ZGXd2t165Gh9EAU4HVbSXeP2kMRE?=
 =?us-ascii?Q?pT0GXDAiwjM9FvF1rjKMKvLlv2pMgN50eVORdjn2iRj4/Ssn7HkK8XnkJWhS?=
 =?us-ascii?Q?H5Tr6G4/MaJ7DOExjH9x3DF50WTPeoKnMYIcJASKmUfYSEiE/+zemhJLZ9vN?=
 =?us-ascii?Q?wHkMKiIiU99DiqQ7CD6lTtU6wlc+gDuWz60B5UTCpntLCAocfYUk7ngIw8y9?=
 =?us-ascii?Q?HopP4dxonEDglVg6Gm7u9Oy4CJCSfP+9G5tLpIRyVwuPulss7CX9WmRToe1f?=
 =?us-ascii?Q?ja/xzcPhpzefBt0G+9OQKVs1deCHwdM3vs78EVPkWhpT41Ij29R0164XJXqa?=
 =?us-ascii?Q?PJ+1O/I+jqPudR641nqzACZKq4XiI9hIAATAcowWqsubmbklQ8AvOAccdSN0?=
 =?us-ascii?Q?l+o+jmGNd4pdWZmygkApyItZ66B/PzkTeFT4h0c6PmXNPTeQJvADVJXO/YYM?=
 =?us-ascii?Q?E5+v6lQHQu+mz3u7xpQjBtlKb1KeCkR1pZj9ZEsEC7cj4GHnmqpw0vEhs72c?=
 =?us-ascii?Q?c6jCDt12uX8Dmj0o4td/2mUK/TicGeqpbzRIC1RYdncZpKLuVLBCr0gPLBAm?=
X-MS-Exchange-AntiSpam-MessageData-1: qkSEyrMqLxTazN/Ge49U2TgCbGSRZElHnyQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a139fe2-fa73-415f-0732-08de9422924f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 21:22:13.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o1ta2E9mAUsFcCkAx7O4GQ8th59z1rd+avUP6Zx3BK1a+OEOMNhzZlfb/FAQEgBa3VoDjBs8H2whrxIERNhPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275744-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D505B3A7843
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This has accumulated some fields which are no longer parsed by the core
or set by any driver. Remove them.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/platform_data/dsa.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/linux/platform_data/dsa.h b/include/linux/platform_data/dsa.h
index fec1ae5bddb9..031f4cf83ae2 100644
--- a/include/linux/platform_data/dsa.h
+++ b/include/linux/platform_data/dsa.h
@@ -10,12 +10,6 @@ struct net_device;
 #define DSA_RTABLE_NONE		-1
 
 struct dsa_chip_data {
-	/*
-	 * How to access the switch configuration registers.
-	 */
-	struct device	*host_dev;
-	int		sw_addr;
-
 	/*
 	 * Reference to network devices
 	 */
@@ -24,12 +18,6 @@ struct dsa_chip_data {
 	/* set to size of eeprom if supported by the switch */
 	int		eeprom_len;
 
-	/* Device tree node pointer for this specific switch chip
-	 * used during switch setup in case additional properties
-	 * and resources needs to be used
-	 */
-	struct device_node *of_node;
-
 	/*
 	 * The names of the switch's ports.  Use "cpu" to
 	 * designate the switch port that the cpu is connected to,
@@ -38,14 +26,6 @@ struct dsa_chip_data {
 	 * or any other string to indicate this is a physical port.
 	 */
 	char		*port_names[DSA_MAX_PORTS];
-	struct device_node *port_dn[DSA_MAX_PORTS];
-
-	/*
-	 * An array of which element [a] indicates which port on this
-	 * switch should be used to send packets to that are destined
-	 * for switch a. Can be NULL if there is only one switch chip.
-	 */
-	s8		rtable[DSA_MAX_SWITCHES];
 };
 
 #endif /* __DSA_PDATA_H */
-- 
2.43.0



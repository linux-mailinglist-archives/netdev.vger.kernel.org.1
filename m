Return-Path: <netdev+bounces-251752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDmnDTBKcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:38:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB80C507AC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5953F806C68
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF6937A4AA;
	Wed, 21 Jan 2026 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SlpkeiF/"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4833793C5;
	Wed, 21 Jan 2026 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966492; cv=fail; b=G7kTYkDd7+6AOCpIwi5p3jf0RvMA1UlmXt7+XpaiU5pVAC/suI9ewAYrVF+LhcRv4FPQpwluM5q6MR3gdRaPCWL8zChYiAwfmVUQORF1zU1U/4uFPlzMCvJ4ZUujAmu5X7IfdDycdlICAy37uoHI0HIYt0BzrOH90/2lTiTsPBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966492; c=relaxed/simple;
	bh=xYz1sFsdu0olCRgAKr/ByP69H8K9fVtA4KdG2fZV0NA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nfa/CCaVCtZitv8PxN/VHIRkZ9hFheECy7TF99HD8h2OeAFWZ+9Q8qolI1jimyTYAl3YKtsmO0ct3lYg0y2Lan3ujwjvux/iru36IN1V7whmNgbyXn27Cx6pCEzZrkpwxzSXXULzAaLzK5Ke9z2gHGYVk6gsXjAgylRa+Zdlg9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SlpkeiF/; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USWG7UmUUo7hPLYPf0rv0NB3u556eyrmSBhonYIfioQSB9fK5GtRGcbbaElh9s0xwxZzbqKQjQ2Q9kuqWWxXIrWO8PTpzIEb04ZLpFMOVpn2u6VyOS4GRy1Pz1FLu4H7g4nh4uHrW8efx/WTLTW3DNXtc5VNOPd6PwHApVvzZvXwMPcPOTDMSzfF8aTzHTPH3u7rsul+hJ2nURyuYryag6wa942WSuwulE4zlvDJiE8MLSWru8j4yvWDvhvSadmNWRaXVP6UmrX5EJHhYih0oRb04UOvnUqw3es81fJeneOM3cy2GxHuAHjXLbf/U4D7XwUn7/ExK/tlXTSIsuFRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95h6F/7FVVkL2vmRhn8X0v4AHM/PT7tYFczJWtOZx64=;
 b=qQpxfRKMmvjQ0+7BGDt1IMWXOH3ZhA7fJ1eqdUazCi6FcmA+MVDn+bSLvYtvlrnwxDMa1+TcF2iDOVQXb0ByvX91UA5Detufw9XJwzqulaNS9egCa3gJb8yWvfMgEBsgCzQ4QdI/WnHrFHTzGWe9BoRZIU1NDXndnvMGPxOpnc7EgYZ2VY1wUDsB+MLc0XZk6hPamMNu1xRO7bL+eUCWgYjz54illHdBaQhUlsbQdS2a8S2HnnJygnf29Z/u9HGor3O6XV0f/vWURBb7RLFeqxxHacb/bO9dPO3/uXfykUs1tIACyfgOor9b9XlYDV4oY/hjFo+h8XFXxuy600NLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95h6F/7FVVkL2vmRhn8X0v4AHM/PT7tYFczJWtOZx64=;
 b=SlpkeiF/sUzNXUn7aM/1vO+cenBwxS23xHtBQ8za7CjPDrI6qpKDatPPeTWzf1bzLx8nyKTZCcG5EZubeIewxlZpjeR/XritZS+ERBKCxry6OgdOjUwqnDBv7qGYPDOaFH7NkfFbginbUKQAKai1K2qi2dXymrLQNYrjMe5gI4zNsz9SsaX2UBP6vQv/ksQT3NoSaqdEwtL951D3o074pdA/mWLYpiMoPKfTJ7rmuUuHxVGVQ9VCOk6KSvMmhnj8J7AA7uATOSwjHcCcvyJJxUY8OxAQ13DmXI31Tc93+o0AbNjAXvGCqu3qeghLHiHHvYGiPULxtmRQbzjk2rUp5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:34:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:34:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v3 net-next 06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP path
Date: Wed, 21 Jan 2026 11:33:48 +0800
Message-Id: <20260121033357.3261464-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121033357.3261464-1-wei.fang@nxp.com>
References: <20260121033357.3261464-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f61f239-4e17-4779-2364-08de589e062c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2o9+QKhqBWQTB68DDqQSlyd23/mzeS5GB/AKRHlzPblOgHhlGx01L6L7kE0e?=
 =?us-ascii?Q?z4JJfOKNxy4BscCRfPR3Y4tsufw5p1HQ3o7JLHrDlm1koIRMPxbO2A4ueDGg?=
 =?us-ascii?Q?YdMFakDdg50Jfpl8IVmc+VTXpnuL0iBj7XniqwidpumAHRd7TYEDhzOfQOZw?=
 =?us-ascii?Q?GUYL5aTGbpCUcSIUvEDO71SnChodANDrdbxLZkU+aTh01lrpQwKhFCztocZI?=
 =?us-ascii?Q?529Rbq/kS/e4Kr1FBusJzyxGXYRY7b+G/kJc1mNyNDBEH+fPjRkhMqA0o9bz?=
 =?us-ascii?Q?1aw8Kbo1NRzBbmC+mLN4DUL3jfal8HZ2WDsnHYVchtzNrjP59fwv7l4GOeFc?=
 =?us-ascii?Q?+e0/1qTkCI/0U2uW9NN8s+DW62zntTxXfpwMpRzwd/zEHrk6Esr5mWjZIFXA?=
 =?us-ascii?Q?3JoeYSEKjI7XXNmSRHCM7Si7cuomPcbRnlFO0/HDxZeGY8TFrgByefVEJB/y?=
 =?us-ascii?Q?Jasz9xDFEdgBUxHRL8BCitWTTD2rtM2OeYl9oSk+Vzqp7Q/Uz0VNRRFA1mRs?=
 =?us-ascii?Q?ZjWh1gFm6B5XCFyPIb/aOhYWxGlwEHxVfrJ9Fc3biH55dnAHIKLLqE6Jlr0U?=
 =?us-ascii?Q?YCfk6L7MnQaTFVjMyR86AV0hfZgFsNJZJozZpn0sZKn8spZRayj3DJgrAp7A?=
 =?us-ascii?Q?LyALNjIH5ghvvZBl34NrRe8Bq7iqb6mPIy8mVJFaya8nJFkVlgC9FXYU6qt8?=
 =?us-ascii?Q?Sl1ySrDHCLCV7zTEl+TWFP8OmIudPskEVM+DB2tfk5wDnn/u4AV8vvbNiC0z?=
 =?us-ascii?Q?RnYNSnHg8scrowoLSojI6pDaAaOSs/XVWeCi7ysag+rOopubhdRESMVjEIUc?=
 =?us-ascii?Q?vNZLLyEu10RT1xb+JbWcUrJ53ihyc3p9qwxWfJe/oQg9OYFg7Tt6nn4h13L8?=
 =?us-ascii?Q?gKQf9cvoX0XvbuW52/4i85EXzQAuTsQCmizHKozPa3f21KES8pGJVzrsbsyY?=
 =?us-ascii?Q?8MWin/+uuRM1Nb4V2FQfErmTvLUjZrFVejzVRCQZTUORlD4lpswpvO6Mj5Dn?=
 =?us-ascii?Q?SUHFUa3sDr9qKaJaos0I7ZPczzM4t6dM9mTJ211VDAup3zXrRsaqyTCZiJLS?=
 =?us-ascii?Q?6hjtkoksRcM4DouVoI4D3mYzK2g9BglPQrT1MMhY/Jn4v/5fcJR3OSsPsrS9?=
 =?us-ascii?Q?SmQM9IuN6mYFaiOvkmtSARdKpF+Y2HgBurEAwl2xwqYfqaw/le+O6rHb5ZiH?=
 =?us-ascii?Q?D+ZTRwZrR8I7JoyXyMfi8DJbfvHqzjnMuUW6B9Ok/EgbBssd9kstbOvUeVxf?=
 =?us-ascii?Q?ld7/W/Ra8V61o+nzkXVxVKPDQdmMBsVZm82sqftvcumWbycvIE/vw+iN7E7J?=
 =?us-ascii?Q?smbaR/XzgTLRqSerx1/gXr/O35aQtLL4LO+gHjDHINCq6iMApp3Vt+mimxjB?=
 =?us-ascii?Q?jnL44qeAfJJa9tglJUs6PBQA7Ah70q7/Z4dxv+NCsAfZcbYLRah0pRE9gnht?=
 =?us-ascii?Q?W3stUlMtmOa0ZwzFSiTQsgfSwT47QYasNhBY0+y+VLeZEVm+/vvwNOP/EHyr?=
 =?us-ascii?Q?Qo2GX06wA7h2XjRoM9qT19Jb+ZLN9D15DM5aXc7WW9toaaopbV3C/y0XROb+?=
 =?us-ascii?Q?rIDDsyrw3BNyC0PPGGLnrUEzscqcYOP6v/nD6kVQgWAjpaLkaK6GdlVeg27X?=
 =?us-ascii?Q?TC0IqH8BEg8qRHqb6rCKZoid4kjJbFsw7cWgzYq19cX5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5EL8rQepRL2wzbYW6Ybtmoznrcx9QKOYnMgyz7+RFlwWWV5rb+F6zRBXu+W8?=
 =?us-ascii?Q?qKTSKm+oo1xM4Pb5tNS+JAAoDrQuEP8+V3iVJIEU+FHKDXREZU2oB+4ozkga?=
 =?us-ascii?Q?Wdp3VFaZTJdjnE/4pLueQf8A/+o9opM5+KHIXbyDRciw37haRI5FcMw/2eU6?=
 =?us-ascii?Q?lX4wudJpnGS4b9RuDB6Ur15LNY+sN2YyAX+BpaljMP4UYaksL9WPPWzc/9gJ?=
 =?us-ascii?Q?qRdj+dvOiWZ5woZf5K3t8/gdgxQPkXCpvynUusWiUs0rM8O+jKPeYvAWd/Xl?=
 =?us-ascii?Q?0Q7UouTYxhnCgOJBgRkeEEx1a4MKjwVRcduDJKmnWxLbw9154RruCDafMjSW?=
 =?us-ascii?Q?3NgJHenakZrHYqh4lpIdEzW6UocAAO1RKY1h0Z7aoaPf/T/G8q0RmsZbCgPV?=
 =?us-ascii?Q?59FRvqNyQPijDu+J87vY2E1aH/5Q1M9LV4V7TXd8xUS0gsu+iisaGzDBlvvO?=
 =?us-ascii?Q?PGwFcXooTl4pzZUiXq1M+jaWmaqJ/ojT6wCai0LkFf2sldTcM82KrMAltS/N?=
 =?us-ascii?Q?fSEedUoO7G8Q8cS7R3a9Rbg1xFpx6AZD553CC0qzGaLuw3wNAZABcW1JJd4R?=
 =?us-ascii?Q?z0ZW35D+gG2n7IE9fvEkjL5YKibPJdOFN9HGkXBTEmVMEugPORcqBoDJDcQj?=
 =?us-ascii?Q?fQloxZc47barTNboCRLZy/uBudI7xoFeMYEcaVCXEynzTjQ8UhCWWh1V7DER?=
 =?us-ascii?Q?C4GJMB33eYR4sBhuxVSPzDZU82knyY8WyN8bwxZRn7SiAkNE4LQXIQgcy0Vc?=
 =?us-ascii?Q?X13sVNTwqVAM4SoKITxl/aJDwztuH4XKglmLlHOkNaUEl8whm7wbF8rWCHao?=
 =?us-ascii?Q?SR6ErepXNzwlHWIl9Gr5DOjaUFzgVJ1LLB4NKwxqW5720vDZb/MT5qtC44zt?=
 =?us-ascii?Q?S8Y5Qer69y8p0l/OkZ80dprfaKcMZYShoGEpUunOE+jsZsLhzON4hr18r1in?=
 =?us-ascii?Q?KmzphPWFGq9BLTLC9GertERBcf+03nLFd9bqGHmFVnEWtf9fkNCBVxGJ5sst?=
 =?us-ascii?Q?0B5YUeoXyH03EYh7CDIltdTTxDGY7r98rBNAGJbH1Sb1Fe8YM4D//JXYeM3a?=
 =?us-ascii?Q?ay+OZE0dWFytNQKIXHY5eM4WRnBVtixgzBDZrjw4WVtEDdVpCzTlzxzuGiW6?=
 =?us-ascii?Q?uphR+1QZV/TBg+DskY/ghUMZeIV13Ult7iE+dUFsK1ekJeiR2ugm5n6VJrCB?=
 =?us-ascii?Q?rtLDzEvjrA9ixE+UTzi/2116rZ0/xCR7W1cSPWFKUjPQMf53O2KkLWpvvTkD?=
 =?us-ascii?Q?yd8bBYuOGiZfanFo0/WWReWt+v8BEu8EcsT1T+UdevholXLsavCWCsDKSWPO?=
 =?us-ascii?Q?ooJlvJAxe+gjvbntD9rylavvy7CWtdqnjn6k9iMyMtsx0C6VZwzvGB9nlqBL?=
 =?us-ascii?Q?Qr62v9Ae7x/+gCKMUsUG03C5Hfd7Z6JV/JDSXZZy5hLqDJImQKKgRIB7Zowg?=
 =?us-ascii?Q?joorGSKxF7RWkE/R5gJjmCF0bDLv0Fy84Wf5wsYc7+41GAdthAJh208QB5D3?=
 =?us-ascii?Q?y1lVz6jHGowU1ccJaKu43L32X59wfJ2OJ64coDEhFpxSvXam5pfuSBoWt3Yq?=
 =?us-ascii?Q?98btRGynic/jXzMI04ArRTRyZsg9M1hRn77REmAje56wG5IyEqKmP6j/V7Zq?=
 =?us-ascii?Q?UPIcqGPcaPXKzWuo1hkGjHRowpflD7h+0gQAdpQEXJo27S9HzDYs5UB1P9NI?=
 =?us-ascii?Q?UyFlx33Q/GAU8ONSkHkkNJRUYqyWPDMGkNlHUARwEpwQ8qtN0WSa2XVG+1J0?=
 =?us-ascii?Q?/rveQDciiw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f61f239-4e17-4779-2364-08de589e062c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:34:46.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYdkofg7SzR4T2p+9CHe32gHG1oxCkX4TiM773aST6ieBjOyDUUfEem/AzjOgyRdkI7Y6QDW2aITTe0dcLW5MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251752-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: DB80C507AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the processing of XDP path packets and protocol stack packets
are both mixed in fec_enet_rx_queue(), which makes the logic somewhat
confusing and debugging more difficult. Furthermore, some logic is not
needed by each other. For example, the kernel path does not need to call
xdp_init_buff(), and XDP path does not support swap_buffer(), etc. This
prevents XDP from achieving its maximum performance. Therefore, XDP path
packets processing has been separated from fec_enet_rx_queue() by adding
the fec_enet_rx_queue_xdp() function to optimize XDP path logic and
improve XDP performance.

The XDP performance on the iMX93 platform was compared before and after
applying this patch. Detailed results are as follows and we can see the
performance has been improved.

Env: i.MX93, packet size 64 bytes including FCS, only single core and RX
BD ring are used to receive packets, flow-control is off.

Before the patch is applied:
xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After the patch is applied:
xdp-bench tx eth0
Summary                   409,975 rx/s                  0 err,drop/s
Summary                   411,073 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   700,681 rx/s                  0 err/s
Summary                   698,102 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   211,356 rx/s                  0 err,drop/s
Summary                   210,629 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                320,351 rx/s                  0 err,drop/s      320,348 xmit/s
eth0->eth0                318,988 rx/s                  0 err,drop/s      318,988 xmit/s

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 256 ++++++++++++++--------
 1 file changed, 170 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0529dc91c981..86447a7cb963 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1665,71 +1665,6 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	return 0;
 }
 
-static u32
-fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
-		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
-{
-	unsigned int sync, len = xdp->data_end - xdp->data;
-	u32 ret = FEC_ENET_XDP_PASS;
-	struct page *page;
-	int err;
-	u32 act;
-
-	act = bpf_prog_run_xdp(prog, xdp);
-
-	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
-	 * max len CPU touch
-	 */
-	sync = xdp->data_end - xdp->data;
-	sync = max(sync, len);
-
-	switch (act) {
-	case XDP_PASS:
-		rxq->stats[RX_XDP_PASS]++;
-		ret = FEC_ENET_XDP_PASS;
-		break;
-
-	case XDP_REDIRECT:
-		rxq->stats[RX_XDP_REDIRECT]++;
-		err = xdp_do_redirect(fep->netdev, xdp, prog);
-		if (unlikely(err))
-			goto xdp_err;
-
-		ret = FEC_ENET_XDP_REDIR;
-		break;
-
-	case XDP_TX:
-		rxq->stats[RX_XDP_TX]++;
-		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
-		if (unlikely(err)) {
-			rxq->stats[RX_XDP_TX_ERRORS]++;
-			goto xdp_err;
-		}
-
-		ret = FEC_ENET_XDP_TX;
-		break;
-
-	default:
-		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
-		fallthrough;
-
-	case XDP_ABORTED:
-		fallthrough;    /* handle aborts by dropping packet */
-
-	case XDP_DROP:
-		rxq->stats[RX_XDP_DROP]++;
-xdp_err:
-		ret = FEC_ENET_XDP_CONSUMED;
-		page = virt_to_head_page(xdp->data);
-		page_pool_put_page(rxq->page_pool, page, sync, true);
-		if (act != XDP_DROP)
-			trace_xdp_exception(fep->netdev, prog, act);
-		break;
-	}
-
-	return ret;
-}
-
 static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 {
 	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
@@ -1842,19 +1777,14 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
 static int fec_enet_rx_queue(struct fec_enet_private *fep,
 			     u16 queue, int budget)
 {
-	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
 	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
-	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
-	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
 	struct net_device *ndev = fep->netdev;
 	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
-	int cpu = smp_processor_id();
 	int pkt_received = 0;
 	u16 status, pkt_len;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
 	struct page *page;
 	dma_addr_t dma;
 	int index;
@@ -1870,8 +1800,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
-
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
 		if (pkt_received >= budget)
@@ -1902,17 +1830,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
-		if (xdp_prog) {
-			xdp_buff_clear_frags_flag(&xdp);
-			/* subtract 16bit shift and FCS */
-			xdp_prepare_buff(&xdp, page_address(page),
-					 data_start, pkt_len - sub_len, false);
-			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, cpu);
-			xdp_result |= ret;
-			if (ret != FEC_ENET_XDP_PASS)
-				goto rx_processing_done;
-		}
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1961,7 +1878,168 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	}
 	rxq->bd.cur = bdp;
 
-	if (xdp_result & FEC_ENET_XDP_REDIR)
+	return pkt_received;
+}
+
+static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
+			 struct xdp_buff *xdp, u32 sync)
+{
+	struct page *page = virt_to_head_page(xdp->data);
+
+	page_pool_put_page(rxq->page_pool, page, sync, true);
+}
+
+static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
+				 int budget, struct bpf_prog *prog)
+{
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
+	u32 sub_len = 4 + fep->rx_shift;
+	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	u16 status, pkt_len;
+	struct xdp_buff xdp;
+	struct page *page;
+	u32 xdp_res = 0;
+	dma_addr_t dma;
+	int index, err;
+	u32 act, sync;
+
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
+	flush_cache_all();
+#endif
+
+	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (unlikely(fec_rx_error_check(ndev, status)))
+			goto rx_processing_done;
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		page = rxq->rx_buf[index];
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
+
+		if (fec_enet_update_cbd(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
+					DMA_FROM_DEVICE);
+		prefetch(page_address(page));
+
+		xdp_buff_clear_frags_flag(&xdp);
+		/* subtract 16bit shift and FCS */
+		pkt_len -= sub_len;
+		xdp_prepare_buff(&xdp, page_address(page), data_start,
+				 pkt_len, false);
+
+		act = bpf_prog_run_xdp(prog, &xdp);
+		/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync
+		 * for_device cover max len CPU touch.
+		 */
+		sync = xdp.data_end - xdp.data;
+		sync = max(sync, pkt_len);
+
+		switch (act) {
+		case XDP_PASS:
+			rxq->stats[RX_XDP_PASS]++;
+			/* The packet length includes FCS, but we don't want to
+			 * include that when passing upstream as it messes up
+			 * bridging applications.
+			 */
+			skb = fec_build_skb(fep, rxq, bdp, page, pkt_len);
+			if (!skb) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_PASS);
+			} else {
+				napi_gro_receive(&fep->napi, skb);
+			}
+			break;
+		case XDP_REDIRECT:
+			rxq->stats[RX_XDP_REDIRECT]++;
+			err = xdp_do_redirect(ndev, &xdp, prog);
+			if (unlikely(err)) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_REDIRECT);
+			} else {
+				xdp_res |= FEC_ENET_XDP_REDIR;
+			}
+			break;
+		case XDP_TX:
+			rxq->stats[RX_XDP_TX]++;
+			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync);
+			if (unlikely(err)) {
+				rxq->stats[RX_XDP_TX_ERRORS]++;
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_TX);
+			}
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(ndev, prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			/* handle aborts by dropping packet */
+			fallthrough;
+		case XDP_DROP:
+			rxq->stats[RX_XDP_DROP]++;
+			fec_xdp_drop(rxq, &xdp, sync);
+			break;
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		dma_wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames. On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+
+	rxq->bd.cur = bdp;
+
+	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
 	return pkt_received;
@@ -1970,11 +2048,17 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 static int fec_enet_rx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct bpf_prog *prog = READ_ONCE(fep->xdp_prog);
 	int i, done = 0;
 
 	/* Make sure that AVB queues are processed first. */
-	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(fep, i, budget - done);
+	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
+		if (prog)
+			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
+						      prog);
+		else
+			done += fec_enet_rx_queue(fep, i, budget - done);
+	}
 
 	return done;
 }
-- 
2.34.1



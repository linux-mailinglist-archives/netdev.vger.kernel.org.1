Return-Path: <netdev+bounces-253423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLn/LstFd2mMdQEAu9opvQ
	(envelope-from <netdev+bounces-253423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:45:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22254872AB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64FB3301FAB0
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79326331A71;
	Mon, 26 Jan 2026 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dx/bLkE6"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22130171C;
	Mon, 26 Jan 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424272; cv=fail; b=ZogmzPpRbpT6OttPeT4j5PXmj/khWmMHswkk9OB/+a6fSe2zC9OBEnCOGa04yOdCfjxcuXsVhSumqwavriagO8N17LccXpPBuvC579E9Arv4XasqJmnwbYjDOaSxM+ibZ82zuCGn2NxkfknlDVkqPiB1zF8SsjO/prdPch78Xt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424272; c=relaxed/simple;
	bh=VW2YTpwSm9T0dHT4VhaZ+JoCuC1k+H8ykVWR0k6XtoU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u/nA0pj5SfnId6pghbjWMKt5BE+rrZbZ3fVsdkAgcfjcjo3IPE9lsAobwk9+dLjoxMnZV3+ZqARqlKbFcsqCtP81rYfbiMXVik7XEIl+m2sRh80ZEt7mgiQTfH/hTCedETG9EhaUWjcf6eotGE9GsYMitvqWDqcb6q4JWameRAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dx/bLkE6; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUQcNtuYFnqwf9HD4s5IxyANWF1Gp4FwG9NJ4sIY0pybRA8nknlADQu1+FO32for5tUzzLtQ0b+INW3ugLAnu2DdNuBcdJYPRARBYZx1oDXuRtw/k71Vswz/asDa1NTHkFVVeCkSkaXNF2mzm5jIeA9dKllW0rhrdzUH32wv6WAlR8/4XqhaGsmKWig212pGSc6RhWGAavSC/JS+tsvscW8LixAgv/b7oJwcZyKmmTMmeOTvo/5pI4POihURy08NLAUpr/kPCHDqjBDME2E5HMGhQVY4HP4eRjkfUhLIeSTmtIfTW35kcWyoAFP9MuaVCqiWvqAhJjmlfpDYW87bXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yotWFwVWW//JYJPv/bTJNwe9C/H2dGKY5l3crG14zd0=;
 b=k2F+XGTZ5Q0W/urT55f0OySdVNQVWnlZUvoswl+Z0v5WfC5ZcOSJc66Kd93UY5mZcp8YZnxb+gIZx0hQxrgR+fWsLZuII2PrirZOwFa/tizcOB6tH+soUzOZk584qCeVIM8t+YsExfhnY5wHmgvaV2Y11kGez0d1eGP8maPirp1MrVCCqns+Xg5OJDvXB4Lbs11ZHemykCT/DuxBIEu1ospMFBRiT6zqrFLKX3MODUjZadsDUMyaCQj46h0Vf3NatU2Ycml0AVlurndZi7d/NG1870WacRrMSyzvv9r1YZ0A+Zge/7mT1LaTfqa7eoggc0Ae5Pr7nBJTwJstTDiQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yotWFwVWW//JYJPv/bTJNwe9C/H2dGKY5l3crG14zd0=;
 b=dx/bLkE69b7k29oR1VRCXxVHgpbF81Un+/0YefJSUFDZx/TAcUGc56X8GZB68y80pKBZZL0nxAU1GyS5TGByKZlIITixhy5ZlzZg1rvqAUdIfxodkpHiH5PdxnwKDrOCjzofUzCCO9nVXmW8WT5ceytq1k/m85fbddGfdpxTgYEtup5EAHC3r/2yZKvFPXxtqpYAuetez9jK+ouCgwAo5wwJR7zquQKxowRPlXNXpL0jrmjYEeeAiJXwIkcTE2YJfvNwlZMDAQSMNMQAgjX4joGQ6dWZ3WsgL1idqNQTLRDP+8WzhYWqfOu+yiC19K3ynKZpL1gr742zTAKxWnkJyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:44:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Mon, 26 Jan 2026
 10:44:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	florian.fainelli@broadcom.com,
	xiaolei.wang@windriver.com,
	maxime.chevallier@bootlin.com,
	quic_abchauha@quicinc.com,
	quic_sarohasa@quicinc.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: add device link between MAC device and MDIO device
Date: Mon, 26 Jan 2026 18:44:09 +0800
Message-Id: <20260126104409.1070403-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0193.apcprd06.prod.outlook.com (2603:1096:4:1::25)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a11b52e-f029-4ab0-fffc-08de5cc7df12
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?GJIZB7gpEvTSV7ZbclVDjmyaXuGupM9e7526qpf0pGLITB4AhN6u19EFI5B9?=
 =?us-ascii?Q?Tl/UA8uWF0eckl9oCp+OGwfxs4diG2jH8fH8aobif0PGkG6ZAjNLsPo4AvXq?=
 =?us-ascii?Q?EehuEl2Lsok14qdAFViIcHRCCodlnRelkT2AvK2WC1t5arpzgFFkJzc+mKBz?=
 =?us-ascii?Q?EHi85KTDQ9ogTWoA+SHL0dvQ7Xpo5xDfZMBqJvUnXeYhHq5IskKQhvCqN72z?=
 =?us-ascii?Q?9clXKhAGjbbT1e6N+bUI4xCBqrW8KDQj+FVMvZPw6q2b+EReE0W7zmHuvAxB?=
 =?us-ascii?Q?lsKZJyKyobybxM58PMwByREAlTI2b4ReEo0hd6QVMPbiFwKSU3D5SxgaenD1?=
 =?us-ascii?Q?Y+Vi61grieaKG2ZUmZumbqsjQtgqQk6i2NvoK4VDBu4feTR7BFoRJUgqrwsP?=
 =?us-ascii?Q?ZcRPThpZrBGd1Rb08Mz3681Spq6zVfCw3jBDyY5HQGw9BuBIX1LQJrWqEAqj?=
 =?us-ascii?Q?yE7+Le5A4qFsWmgB4iYjDtIsS8LyP+cWuzwf2aKAw7h2JXxRkSO9eozhibmA?=
 =?us-ascii?Q?WmnWxSIRY6bocYeSfwgyfQS/Ahz8GIEDxOS+E1haqT4kHvQQNoe/5hCMqG8i?=
 =?us-ascii?Q?Wmj/FN2BuPyOkTETK0qKLqMU8mrJJLYrLvDl+07wVBNACx7oTIvsfo2E8CtZ?=
 =?us-ascii?Q?QHIXoKocnbL+VfxgI3WLDU2NtleNfTgmK5fZyjO+MoWS0oFUTp/7pTqK4/Vd?=
 =?us-ascii?Q?g0Gf8jpliWOwdsRO9Urr/QvSZ2EJOg9+NnhPS44dubYFoPOdWbdNn+Ak7OrD?=
 =?us-ascii?Q?VxJqNTbOsEOrKUGSBpeh4EI5OFlVvzEWd7y935JmStDJ4e+D4RTM1gbWaXzy?=
 =?us-ascii?Q?omXFojnJl4itFKRTlR5quQs4H4NZUT10TxB5bT9wL5Ec2VtW67vqH+Jx+yBm?=
 =?us-ascii?Q?XMdOwdVPMJh10/aXLUesRCHXrYzfSC1MpR6sEE0YwRSX40ROYqhQuiERLoqM?=
 =?us-ascii?Q?icPO66RPlWiKkHksZ499OG6rnDQOpFLMJzuwj5N2pS1M3nbBqDm3qilGwv/a?=
 =?us-ascii?Q?kwIOCgchBz/Tq/x1bbkO18/iQRiBu95yrZvo2vq6omUceOPusO6QBF0HGAWP?=
 =?us-ascii?Q?FemHU4YZVsu292tH9KE1pVFbYdpPI5Pokbq1k8PzaoFI52+aAIltwMf6/aa6?=
 =?us-ascii?Q?gNgrPiOJQZHb5Z6ePBKCD+736CLOqykcUnaHk4kp2hRX487xxzEzD5SElOek?=
 =?us-ascii?Q?N1A+FBvytpsbiRvToqIHs8WclCq0E3+/OpFtG31K5xJxT20ODEx+Uviuy3bx?=
 =?us-ascii?Q?xIiFHrZN4sb4lQpPDHn570LH78aexWVkrDgYUKCYtRMuIguU+GTFzD3hpOGt?=
 =?us-ascii?Q?kv3yfkVtvFof48PqT1lrVo/HMZeHaX0nqCshammbxo7O1tNzTI/Kzb3J4lj2?=
 =?us-ascii?Q?YoWYZ6DbDxcQsl/IROuCPf3Z6htp7p3jJQW4BG7E8kLPdmODzYc1cRDiSCHt?=
 =?us-ascii?Q?cJZuopN9487mu0uxcFWh2btqZuMhy7VrydA175QKMtQPE65NeNj/eE2n0VZo?=
 =?us-ascii?Q?16NqaKqYEhRbkEitq85bFDrHzSFcIb6ZENS1CSL9AW39ctFSZ+ZLldrNBdbu?=
 =?us-ascii?Q?YNOksK3YcyBv3iTm7KlKYGUsUU1Mixjl/VcDT/h98TIpEIYQ/fBvE6whC0Ax?=
 =?us-ascii?Q?putbUUG1DuvkvO6Ofm9f0/DKfqQbYAQMQgwtGYrp+gkL?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?8texZdPbmzx0+InznwzgU9f6gKBKXiDT8xBL/Y6VDYMHBg3qEPmGVOsEV0+A?=
 =?us-ascii?Q?eQEQHm0oK8fCC2bRwAcWCVvdL6kdFQblhEmjqAa9t7gptIB4iB4tChsDSdVW?=
 =?us-ascii?Q?csuFWvML7/j7Q84BVY5jtuKqZ4O6Jdc0tsKgOn1h7vy+7vgAJ32a0MLZ1hSo?=
 =?us-ascii?Q?MwfiBNV0GCJH+a9QSzPpvLbJ/0CTe95jBsq29aTQWfebm4zqchywDDQQ8K53?=
 =?us-ascii?Q?p10JcEE7lhZh9ANXkj7YG2uSG6VxLfgK2n+d54xreRsCoRr9UySYbGFsG49U?=
 =?us-ascii?Q?IyTcaxkWIVXBwW4T6juKkvkiVBjjp+6j84P/sFtTAvzuyV/mlLNuQiCcL2za?=
 =?us-ascii?Q?bEG54enokyyK2xcYp3QPkwV3qmWi7nvtiYEoheVIv81Gdsgp1R7qL+osjkdc?=
 =?us-ascii?Q?vr2WkPGMaIsJgEDKigaCPiww4FGdl06ouoednIkQ/Gulb80/tY1o1sMoEiYY?=
 =?us-ascii?Q?jbfPVxaLcrkpTjgRIXniMdkzi6bAkgOzxghuaNWP0HVILJ9DqbKZ9MTdI7K9?=
 =?us-ascii?Q?h/SYJxOYEqITpJZ+qpIjakc+yhIWFQqA6DNsZmjT/HwoJIikTRtVbMKpZ+rv?=
 =?us-ascii?Q?WIRgQyTLsdyEPGIXPoaqWwzxgFxlWTG0wY5AOaaGGVnFIWUY0rjKw7XnwXzL?=
 =?us-ascii?Q?845t+F3uIEFQhfpqcdK5ScWS1SPaNmDG0kwdByzsKXd1pJmh8cEwQe12frUW?=
 =?us-ascii?Q?XQ1DnjPk2+LpSNM+5nb8Py38qI71+9AN2L+M5GUW7xLJNgkaBCuAx7OjAOJp?=
 =?us-ascii?Q?+3yFxk9NV2a2tPw1FLFnk02X0Dxr5LZJ7KSqHKXFrGCSRwXks0pyTVLEvH6i?=
 =?us-ascii?Q?8+z8lhk9I7YGirt9dsnWTSeKgjqr6vG+vm4IK+wtRcMnJveFQS9hSk2KprTZ?=
 =?us-ascii?Q?wcD+ErNPQ9N4d1b9ZQGOn6IzPwqWRyCFyN532IFo8Ra3XGX1SU1O/MX4SMSl?=
 =?us-ascii?Q?+/IJ7e0W8GjNEN0Zs503ICG4sTXycKKZ0WB35hi1FMHuUhclq1KnsD763FuH?=
 =?us-ascii?Q?EFexA2UsxA+JYrRYo99QC0DDGYYbxLVWWczxtWbcDEJWnWCTrHBuX6KjTkFW?=
 =?us-ascii?Q?AZeCtFTRtXb28x3HKwF+JZpILRZGcXxJWOB/XR1k/byyPaudSylsYwMirKgt?=
 =?us-ascii?Q?M6XD+WIm9GrVNs25GbQJ//2dcrEz/0HSwAqeaxLRytXpQi4SFRf35dE8u7g7?=
 =?us-ascii?Q?621hGWeHC/JrRlw517qCrWRNUPE5E7dYBKgjqZaGUliNh+J5pgmRya32YqOk?=
 =?us-ascii?Q?9JJ3na9RgsefMszidpQk616lms0MNisP/HvrDV7wtZobiTNf34nTxBb8dVA4?=
 =?us-ascii?Q?hDYaN2BTBJoypCr1u09szbUnVs+kcjV+fnKx7Tfz+VNbyceX+D/mjQ2h/8yC?=
 =?us-ascii?Q?nekH/G5kHZtSjlgtokBGc963TzIe7NchZuiOnnTXUCMp02FP3vYU5Tw9NeFw?=
 =?us-ascii?Q?VHN5lE59Be2XCxb4Z0K01r2ARyHWoEcIw/uXX0XoJ7MRR/xRE67f26JBB2nj?=
 =?us-ascii?Q?vAG3y1+4R7dNcvdpJkwLvwRjP5TOQiIFfirurHLbAQrFTTetP21m0dOBCjdI?=
 =?us-ascii?Q?D+ybQo01QwpvLNLJA10B5yrYbJ54nPgY9zmlbNGjSNENZoBQgGB4S3i2x5N9?=
 =?us-ascii?Q?sUPdjNEwWNlC+2NqeTJaUfCocodLb3lGntaqa6IgVBhrcH7b4fPDR63gIHoz?=
 =?us-ascii?Q?0c754Sgb8RDcPegn/Cm5iFlWhdyf+kFJNjKjA4LUhJSC0gAS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a11b52e-f029-4ab0-fffc-08de5cc7df12
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:44:24.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLufMdcMZpEVIwM7lJHu8eRJBu4WIPrg7cQsOXzsnzh8bWYANtRXKqn0uvzxrxulxUzR3gNIaLGhs65/RGQ4Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253423-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,windriver.com,bootlin.com,quicinc.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 22254872AB
X-Rspamd-Action: no action

For the shared MDIO bus use case, multiple MACs will share the same MDIO
bus. Therefore, these MACs all depend on this MDIO bus, however, current
PHY driver does not create this dependency relationship between the MACs
and the shared MDIO devices. If this shared MDIO bus is removed, it could
potentially cause a crash. For example, the i.MX6ULL platform has two FEC
ports (fec1 and fec2) and uses phylib interfaces to manage the external
PHY. And fec1 uses the MDIO bus shared by fec2. When the fec2 driver is
removed, users can see the following warning log.

$ echo 20b4000.ethernet > /sys/bus/platform/drivers/fec/unbind
WARNING: drivers/net/phy/phy.c:1352 at _phy_state_machine+0xe8/0x38c, CPU#0: kworker/0:6/35
phy_check_link_status+0x0/0xf8: returned: -13
Call trace:
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x54/0x68
 dump_stack_lvl from __warn+0x84/0xf4
 __warn from warn_slowpath_fmt+0x1a8/0x1bc
 warn_slowpath_fmt from _phy_state_machine+0xe8/0x38c
 _phy_state_machine from phy_state_machine+0x20/0x50
 phy_state_machine from process_one_work+0x168/0x2f4

Another example is the i.MX95-15x15 platform which has two ENETC ports
and uses the phylink interfaces to manage the exteranl PHY. All the
external PHYs can be accessed the EMDIO, it is a different device from
ENETC. When the EMDIO driver is removed, users can see the below crash
log and the console is hanged.

$ echo 0002:01:00.0 > /sys/bus/pci/drivers/fsl_enetc_mdio/unbind
$ ifconfig eth0 down
Unable to handle kernel NULL pointer dereference at virtual address 00000000000001b8
pc : _phy_state_machine+0x230/0x36c
lr : _phy_state_machine+0x2b4/0x36c
Call trace:
 _phy_state_machine+0x230/0x36c (P)
 phy_stop+0x74/0x190
 phylink_stop+0x28/0xb8
 enetc_close+0x28/0x8c
 netif_change_flags+0x24/0x6c
 dev_change_flags+0x48/0x7c
 devinet_ioctl+0x328/0x604
 inet_ioctl+0x204/0x220

The commit bc66fa87d4fd ("net: phy: Add link between phy dev and mac
dev") has created a device link between the MAC and the PHY if the MAC
uses a shared MDIO bus (The MDIO and the MAC are two separate devices).
Sarosh Hasan tried to change the DL_FLAG_STATELESS flag to
DL_FLAG_AUTOREMOVE_SUPPLIER to fix the issue [1]. However, the solution
does not take into account the hot-swappable PHY devices (such as SFP).
so when the PHY device is unplugged, the MAC driver will automatically
be removed, which is not the expected behavior.

Therefore, to solve this issue of the shared MDIO bus, we create the
device link between the MAC device and the MDIO device, rather than
between the MAC device and the PHY device. And when the shared MDIO bus
is removed, all MAC drivers that depend on it will also be removed.

Reported-by: Abhishek Chauhan (ABC) <quic_abchauha@quicinc.com>
Closes: https://lore.kernel.org/all/d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com/
Link: https://lore.kernel.org/imx/20250703090041.23137-1-quic_sarohasa@quicinc.com/ # [1]
Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/phy/phy_device.c | 24 ++++++++++++++----------
 include/linux/phy.h          |  4 ----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 81984d4ebb7c..d5ac7506fe39 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1768,12 +1768,21 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	/**
 	 * If the external phy used by current mac interface is managed by
-	 * another mac interface, so we should create a device link between
-	 * phy dev and mac dev.
+	 * another MDIO controller, which means that the MAC and MDIO are
+	 * separated devices, then we should create a device link between
+	 * the MAC device and the MDIO device.
 	 */
-	if (dev && phydev->mdio.bus->parent && dev->dev.parent != phydev->mdio.bus->parent)
-		phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
-						  DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+	if (dev && phydev->mdio.bus->parent &&
+	    dev->dev.parent != phydev->mdio.bus->parent) {
+		if (!device_link_add(dev->dev.parent, phydev->mdio.bus->parent,
+				     DL_FLAG_PM_RUNTIME |
+				     DL_FLAG_AUTOREMOVE_SUPPLIER)) {
+			phydev_err(phydev,
+				   "Failed to add devlink between MAC and MDIO\n");
+			err = -EINVAL;
+			goto error;
+		}
+	}
 
 	return err;
 
@@ -1845,11 +1854,6 @@ void phy_detach(struct phy_device *phydev)
 	struct module *ndev_owner = NULL;
 	struct mii_bus *bus;
 
-	if (phydev->devlink) {
-		device_link_del(phydev->devlink);
-		phydev->devlink = NULL;
-	}
-
 	if (phydev->sysfs_links) {
 		if (dev)
 			sysfs_remove_link(&dev->dev.kobj, "phydev");
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fbbe028cc4b7..d6f2039a63d3 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -559,8 +559,6 @@ struct phy_oatc14_sqi_capability {
  *
  * @mdio: MDIO bus this PHY is on
  * @drv: Pointer to the driver for this PHY instance
- * @devlink: Create a link between phy dev and mac dev, if the external phy
- *           used by current mac interface is managed by another mac interface.
  * @phyindex: Unique id across the phy's parent tree of phys to address the PHY
  *	      from userspace, similar to ifindex. A zero index means the PHY
  *	      wasn't assigned an id yet.
@@ -666,8 +664,6 @@ struct phy_device {
 	/* And management functions */
 	const struct phy_driver *drv;
 
-	struct device_link *devlink;
-
 	u32 phyindex;
 	u32 phy_id;
 
-- 
2.34.1



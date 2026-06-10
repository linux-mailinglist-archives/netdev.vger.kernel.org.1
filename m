Return-Path: <netdev+bounces-297716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ozkECHF9KWo4XwMAu9opvQ
	(envelope-from <netdev+bounces-297716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:06:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F9466A8DD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:06:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=WEqV66bX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297716-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297716-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89E783058FBF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA1425CF0;
	Wed, 10 Jun 2026 15:05:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF120425CF9;
	Wed, 10 Jun 2026 15:05:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103950; cv=fail; b=tIhkN/ettIBSb8VbHozUECxBaf/48J1cReny+5+ohWgSb8m5P2xP5uWtjnkJBvaZsdTChUlat9/DPilvE5S5IsjS3vG5Fw5Fgz8oRd48BEdkdrvbT0x51GTKWxdI88R1xkrZkLPYqUHx5Zsv2ReeMaYRVBejesfj0hhDzIDtBPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103950; c=relaxed/simple;
	bh=z2aN2kRKYKdzr2FWF4KcKVeCb9tSruR6iQy4QKK6VEc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mHqKIxpJqbjGGoosHQV0I3N7poh2TXgtxMXCEBoC35ZElUcsck2kbH3a8ffF7VtOF3SlJoDJni4Ap/WOdiKk5n39HtNYqXYjQdb5iaVRHv3CTgZ2Ti9287ycSjRgdFM37+oVMy1KEM0wb8RDQZHIUa0b3cqTQFugVS5wzgyAvmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WEqV66bX; arc=fail smtp.client-ip=52.101.72.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBdrHquxR+xh5U4sVYMXVHJWTG+Taf4KzlDnT41PYQUpunywJG6jEGXUDJz+NjgAeYHS3XpPwjpR4e0P6IgHEjEGDXPTDGxB67Ay1M2FJnzP5aTcJWAHj7tlgfeFWtinA0+nlY3G5BdMbtev1WRFCNeNaMR/nQ75jLepzbcVsd4P0+Apci7cPaZlBzGfLV+mskZIJM2+UUAsO74yPE51Zf76f79EyiCjGYNwqQdef+QZCNhK+T1VjozHJsJGyaHMGlyrG2bmKJttqbNJmhrC3DXg+m3CnVXAGqpXvntEXGisWBDo5EWIRzpc6LusPIWBFYes7s98EyKVHz/+g7Oy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvB1JoeapBL2HFP3cyAjR7epTFjPVBPbgr7I6Wx9xwk=;
 b=w1MMfyP01+rtmQE+QGrmNm20NuEOBXu0UsIaPmKTBZ7FSPWBgh3HtSUXxVRyFb7o6h868xBmI+6UPCbTV6TkOTA0J1uGUccU2qqkEyOtqZWo0FiVuL86O59LXpt1qelYD9TwUfhRVTDZrizMii5xLTiTf74l7f/f7CZN170QtCwLkTwFfvKD2tagh+BoKKuCr4NUhV3umP9AXoscgiKVpIYBUJ10K7mm4B5zPBLMxWonmqB9d/Gz6GxAxfDGgO+bj/B44ehb4XoXm6d4/dgBJtDzRRO0WAeV/QGyyQm5GZmXdFykzDnkSBzJoior5LMOXGO7tSEAUitrTGftmWRYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvB1JoeapBL2HFP3cyAjR7epTFjPVBPbgr7I6Wx9xwk=;
 b=WEqV66bXSGAXqsNz8qyx/BhDG8W1f1xe10TWxX0tyjnFtEhapk8wYotTEeDVKA/dHV7L1sBzZjwnm0PNKwz+JbrQcXFixDHQeUYy7DAHtM6TpQ06hi3XhdEtT4Z+60xoCchK5tX+DNB1S9lIm8HxtKmyS3CDjofoelBR1V10jwbMG1yJLpyF+xgwi2aV2wEnVS8hL98+HQdxiI2wNidfnEgJlj9uXS7o6Sg9qjmGFc59KrKYKSvdVnSkNVOAScJdsJDDU89M7qNGYYlqwjfuGEP5REwJaDBKEIST5G93TxC8g+uFNNy6aunFLbVbF37HS2j9SDnKbg1f/icNKAnU9Q==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 15:05:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:05:44 +0000
From: Frank.Li@oss.nxp.com
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 net-next 1/1] dt-bindings: net: dsa: Convert lan9303.txt to yaml format
Date: Wed, 10 Jun 2026 11:05:30 -0400
Message-ID: <20260610150533.515914-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH3PEPF000040B0.namprd05.prod.outlook.com
 (2603:10b6:518:1::5c) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b90cde9-fd0f-4a0d-5831-08dec701bec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|19092799006|6133799003|18002099003|921020|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8YCacFG2UMGhOfV48n11/G1SAw7tibLH3wmboA3kCZnV7rcmiFlHad5BvTCpllAknB1FP5tffHRhuDLy7otRQZGN5JPbZTCGmqydGM6Q5bZjIPWtw6YCliX2nKjlHuIWa+7UhkS1pNvmp3vIsZiPaTe4QIKnOLEDfqykXPUFp0IOIv6v3WDRmGMSAc4TYD8kD5mONufdaUSITXpKUIlpBkPU0iqpW+ilgWEEEkXgyi7gy7A/NwRQWXsbF5HGXdD3WmIfiHSmOhpJEoOHM0onh/tlX0TEGLWfxr2IcKisCA1ITJ6RHtwAcyWhIUt3WXoU5giGorpEzf2WOnzX2KtI1nDASg4yvGW+9oPRxvW3QkHCHH0GiJHB0h3Y1PR8YgjEqnVsrzyViA7aqPX58RgVm8yPHGyz28VzwKKIum9gq2PmgEpG6lMZKrGvEHh6ATsTUMnGfHGAWfOT45J2DdlXPFC/L8k6wlcBY+jIyuH99ejCiaSfSE/JxX3gn15s56FXj5dyWlsPjtN90CNNyHGgc9jMAwBGfay44c/OZxCLOXDGXMiZcpIxy/3eph+rZoxUUEUgVRL8J1FROXtO7fRsajy9D6ybHgOFXWOENdJDPTSX0yQiBDx7+OQu6O+TpTEDPHwH0b9iw/z2n+I7xJXiQtNylU5hVOl5nlr5yO0PQDzuInfLOvwzluSWTPiXXicp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(19092799006)(6133799003)(18002099003)(921020)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofZwtwIGilW4GGj+BLZ8ZZtznt3Ddc37w2Mu1DrVrib+Uc9blUO0ajv7jHOt?=
 =?us-ascii?Q?csfRgi8d9M+aUT+zg2Qw+IGt3ZfBcNeplKnlXhGEJttxrUPFxQMWrBjOABg4?=
 =?us-ascii?Q?10TTKahGyTxbsuvsTxZ2lVmS4T809NmtDPut4ikLMPB76E6bB+zLIpLsbH2t?=
 =?us-ascii?Q?hsb1XcemvzZq8zh2UTVKC5m4SbAgVQfgH8BvmpeTXbONMG/Xatf3npMONeSB?=
 =?us-ascii?Q?PnEXfj5e+7SiouOp8QKzEAeZnclaR0J+/ThgYCX3fhZpPsToL49bOlhuBYmi?=
 =?us-ascii?Q?vCmECoiWDVSsEJTZZMliUCFi2U0NJjCZv+ATqCIfL+2CTZKVi/0SkGbamdxt?=
 =?us-ascii?Q?FgAvkwYkVB0A/oL0rUnhI6RHtn8Zh7Ui3QbjPb1GJvxhibtSCIRi2kdo/PtI?=
 =?us-ascii?Q?Mz4bBeEcsoEhsmHQaJ3PaFOLbeVGgrZeSN57Qu4uVByRB0EKbVcpgWZ6sPfG?=
 =?us-ascii?Q?k6+X1UyKVJ5j0zZ0FS1YCmtHAPZ+KY7wnZQKz0NsbD/YDpc16hN+Q3XjlzZM?=
 =?us-ascii?Q?ldN4Rr8X3q74zXDgvX6o4nTMJpA6oxkXfLQwbe7MPJPZmyXcqri4gzJe20m/?=
 =?us-ascii?Q?IGz3OKAXTfBHnf8tPytn1HzLMKMkIbk8T1JqHPAmy9XkG8ep/Ckd6V2aIL7m?=
 =?us-ascii?Q?jU3NA0HaGmJkbv3t0LWHspiBGNtU+/t8NW2a0nVJ685M5stcMOtoFUvnBJ78?=
 =?us-ascii?Q?KaFHx6Sdo8zvDn+dvtrG7/bseXBZc5Wh36fv8wP/Bu0EoW27WDYKODpP6ZT1?=
 =?us-ascii?Q?YOyR1jpfpHa3eZkkyYPm/7vm52yrHDXI2iF4MFx7Q0n7R0zK+9liNxHmufkw?=
 =?us-ascii?Q?h2y12OzoqRoRfx6O/4qNOqxTl/a0r8cJXNop+X3fsCIv0JMmpRfxSHdQVuJK?=
 =?us-ascii?Q?taN8yZTrVn3A0SPHLW7IOslt60Svkusn40xqDrPf5Dn9oN+6vzh7cK4vxCZi?=
 =?us-ascii?Q?Tw0AYALuy6oBVcLhPtPiuThyt6TbTsqCAjviUGvFXDU1TMau1qntgm/5769i?=
 =?us-ascii?Q?haeZo7Iq3BAlex9qbfQccwi0aQ13MGFvHPRjeuH/zgv3fmV66+JTepZbwl/U?=
 =?us-ascii?Q?rzRpp5DTll//sbltprgzOEij3gJ3gLN3+Rgnp6eyjqprotvF+Kud3vmDpae8?=
 =?us-ascii?Q?iojL6wO0Lxxlhqbzi8+BO3CNIv+V5WN6Ix7wtcPBVosAcu7xLgpfjj4tfTaS?=
 =?us-ascii?Q?EVYn9D/NaaVZ2CW4j1GRoXl1dLA6UjdePwsFi4GgHJF/AGBv7f8IcW5h476w?=
 =?us-ascii?Q?nFBrDOCNN33EUF+mr2axD+sOVlktDfuy2idPmKSaF7KXSjPljo892UTJzSVj?=
 =?us-ascii?Q?AqjRSv2SQuq9/A0InwalHhcJXZDqqh6lIsVHW2fzYoxbT3HdJhw7JTFaA4rl?=
 =?us-ascii?Q?iHP1q1DwlEiGpvqr5pTObNMZGsPLEsutHW9AZmbx+oFP8hBBvly1BFCVOl3G?=
 =?us-ascii?Q?olhucz+ym2+29Cbhy9Nj70k4TF9PAqDlfCwqCgCNWAb7mSWdwxLxQzQLxI18?=
 =?us-ascii?Q?lcGeoxgkLi3gxz+52LJCDd38N84rB/lXA3ust+7fy0saSYCRyoocttjSfE6T?=
 =?us-ascii?Q?doW4EBmeczVu+tWYmYBr4GqIf1GAWewMlZpfOF3/g/AOvVjfGeR3sUldp8nI?=
 =?us-ascii?Q?sDxSYeZyNmk9TXsZfHFiUOrWXT1s6y2BMRgO2aMi+KQS2I5/kJs18mfjn5Br?=
 =?us-ascii?Q?5CglweB4XAKntzG+C6P5gQ0FPTZBnSKwIqI9p6q0/VDuwkJsZSpCZMdCAILZ?=
 =?us-ascii?Q?lCrn242bcqJTvGjEn9rWw4Qa8gcKA2ciBxXalZq4o+r4qrf+7GmD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b90cde9-fd0f-4a0d-5831-08dec701bec2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:05:44.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0VACQnZtFDJUsWk0MWKoDS0AKHSZpxdSA4q3QTCzguc5fAozy3riTaZkNo7mK65S4ojZDhXMRn8+pdY7xVfgW33zcdYa968iH5lKXCsNe8G4l4vZw6/LfaeA2edB13G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9423
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-297716-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:Frank.Li@nxp.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:imx@lists.linux.dev,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,nxp.com,vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devicetree.org:url,NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7F9466A8DD

From: Frank Li <Frank.Li@nxp.com>

Convert lan9303.txt to yaml format to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx53-kp-hsc.dtb: /soc/bus@50000000/i2c@53fec000/switch@a: failed to match any schema with compatible: ['smsc,lan9303-i2c']

Additional changes:
  - rename switch-phy to switch in example.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- rebase to net-next
change in v2:
- fix typo Additional in commit message
- add rob's reviewed-by tags
- fix doc ref problem
---
 .../devicetree/bindings/net/dsa/lan9303.txt   | 100 --------------
 .../bindings/net/dsa/smsc,lan9303.yaml        | 123 ++++++++++++++++++
 Documentation/networking/dsa/lan9303.rst      |   2 +-
 3 files changed, 124 insertions(+), 101 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/lan9303.txt
 create mode 100644 Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/lan9303.txt b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
deleted file mode 100644
index 0337c2ccfa9a7..0000000000000
--- a/Documentation/devicetree/bindings/net/dsa/lan9303.txt
+++ /dev/null
@@ -1,100 +0,0 @@
-SMSC/MicroChip LAN9303 three port ethernet switch
--------------------------------------------------
-
-Required properties:
-
-- compatible: should be
-  - "smsc,lan9303-i2c" for I2C managed mode
-    or
-  - "smsc,lan9303-mdio" for mdio managed mode
-
-Optional properties:
-
-- reset-gpios: GPIO to be used to reset the whole device
-- reset-duration: reset duration in milliseconds, defaults to 200 ms
-
-Subnodes:
-
-The integrated switch subnode should be specified according to the binding
-described in dsa/dsa.yaml. The CPU port of this switch is always port 0.
-
-Note: always use 'reg = <0/1/2>;' for the three DSA ports, even if the device is
-configured to use 1/2/3 instead. This hardware configuration will be
-auto-detected and mapped accordingly.
-
-Example:
-
-I2C managed mode:
-
-	master: masterdevice@X {
-
-		fixed-link { /* RMII fixed link to LAN9303 */
-			speed = <100>;
-			full-duplex;
-		};
-	};
-
-	switch: switch@a {
-		compatible = "smsc,lan9303-i2c";
-		reg = <0xa>;
-		reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
-		reset-duration = <200>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 { /* RMII fixed link to master */
-				reg = <0>;
-				ethernet = <&master>;
-			};
-
-			port@1 { /* external port 1 */
-				reg = <1>;
-				label = "lan1";
-			};
-
-			port@2 { /* external port 2 */
-				reg = <2>;
-				label = "lan2";
-			};
-		};
-	};
-
-MDIO managed mode:
-
-	master: masterdevice@X {
-		phy-handle = <&switch>;
-
-		mdio {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			switch: switch-phy@0 {
-				compatible = "smsc,lan9303-mdio";
-				reg = <0>;
-				reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
-				reset-duration = <100>;
-
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0>;
-						ethernet = <&master>;
-					};
-
-					port@1 { /* external port 1 */
-						reg = <1>;
-						label = "lan1";
-					};
-
-					port@2 { /* external port 2 */
-						reg = <2>;
-						label = "lan2";
-					};
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml b/Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml
new file mode 100644
index 0000000000000..42f8473538a07
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/smsc,lan9303.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SMSC/MicroChip LAN9303 three port ethernet switch
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  The LAN9303 is a three port ethernet switch with integrated PHYs for the
+  two external ports. The third port is an RMII/MII interface to a host
+  processor. The device can be managed via I2C or MDIO.
+
+  Note - always use 'reg = <0/1/2>;' for the three DSA ports, even if the
+  device is configured to use 1/2/3 instead. This hardware configuration
+  will be auto-detected and mapped accordingly.
+
+properties:
+  compatible:
+    enum:
+      - smsc,lan9303-i2c
+      - smsc,lan9303-mdio
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      GPIO to be used to reset the whole device
+    maxItems: 1
+
+  reset-duration:
+    description:
+      Reset duration in milliseconds
+    default: 200
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: dsa.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* I2C managed mode */
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@a {
+            compatible = "smsc,lan9303-i2c";
+            reg = <0xa>;
+            reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+            reset-duration = <200>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "cpu";
+                    ethernet = <&master>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan1";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan2";
+                };
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* MDIO managed mode */
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@0 {
+            compatible = "smsc,lan9303-mdio";
+            reg = <0>;
+            reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+            reset-duration = <100>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "cpu";
+                    ethernet = <&master>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan1";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan2";
+                };
+            };
+        };
+    };
diff --git a/Documentation/networking/dsa/lan9303.rst b/Documentation/networking/dsa/lan9303.rst
index ab81b4e0139e3..776572be265e1 100644
--- a/Documentation/networking/dsa/lan9303.rst
+++ b/Documentation/networking/dsa/lan9303.rst
@@ -12,7 +12,7 @@ Driver details

 The driver is implemented as a DSA driver, see ``Documentation/networking/dsa/dsa.rst``.

-See ``Documentation/devicetree/bindings/net/dsa/lan9303.txt`` for device tree
+See ``Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml`` for device tree
 binding.

 The LAN9303 can be managed both via MDIO and I2C, both supported by this driver.
--
2.43.0



Return-Path: <netdev+bounces-269461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLmELWAIvGkArgIAu9opvQ
	(envelope-from <netdev+bounces-269461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:29:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8F72CCD52
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13C183027363
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3A363C48;
	Thu, 19 Mar 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y+xTnYVB"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF735AC19;
	Thu, 19 Mar 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930242; cv=fail; b=WpkwiL8nU08h991EZlz0xizGY094WvU7BURLD7UuD7GSPkyzMAJ7kycxF/U/fr84sTfDF4xY9rkEDsx6bauoM9jyL0Pk03gks8/QAhnuhM5s2HLhKXiiG9iJi6iwZJocUlS8t7/OxFBFz6s8Ty19UoHFS4vMmRTIORH1f0/xMw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930242; c=relaxed/simple;
	bh=BicHpiB7Yq3LjdLyMW7Epr7LbcNcTYRWm5IfBZavsVM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d99ei19sdrFqvgzdLNrv3uT2Ho7lvwKdIAY3UfQg/R4cZyWMDPt5YzRw/yRch+xiL+snfNYPEFf/HJNth/RiZF/PqhdlGzLBTKGaJYT6Zlsluj2cRcAr8yFtezxfkUnvSueE78LzKOjbu6GVm4hLk7mn2q7fAYNqAoib1aDta4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y+xTnYVB; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWiD6Z1WQMEdZ80nIdy1StbAC8GgVGuTfQ4dg0cFNRenAgmyLSDbhBXW/M0FNMdQy/OaCw+nSQnrQhooya+G7oPU2f7VzC6EcM0yUv7ku1xqJP0Wz0VoM7Xs5bUN4BjonumasbK6EjzxGczsfqwp5vanKQecs0vi3Qe6VRacLB7tfpfP/cZHsbJrBx6gkmj4KZqNE/cnXg02TS7/bfvNJjAvqkVY1RWPrCfXRPGvgfxpSX2y69PUSKlXnxqOy2hEFsuRvQFS8MP568QsjYhsITcN+/lyOC5jOEzVCFA6i/aR0Ec+m2TfxTSmaDsVMhcTA+rt9wkZY4zaPn+diVwSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXtYztgt2hSHjpwE7Fc6Im3hSAR7tThcKyR4QhCAgvw=;
 b=WHyOcNDp7j1oP9U2OX56pAbSzvBnn1sWCduhkYxHS2o0EY4PecycNMudoWOn3rOIfacJ7FTYIOWrI9TtwzZonfGvGzNSJKEm1TUl6e9JWt2nyqvhYKVJRrFiiHqzD15qtSpiZpJSiseyi+PO1plcGWwtakJ6k8jANDyeRe4MQRkkogkPeRmt4H1W5pkn9cCbAHgCGpTr3GZ3qUgjIa0/hN0tUifJNtA3yTJOKZ97hyEPtXEyRTaizMiOaPIPsQiZPogGQ7zYt/nnO9mUcmkf28ADuHU0jptSUUU2B6JeGfEAm+LhfRVoppJH9QRwmy1ykokulgdEyGgjx/kldLEY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXtYztgt2hSHjpwE7Fc6Im3hSAR7tThcKyR4QhCAgvw=;
 b=Y+xTnYVBvLSg3b7hAwleW8I+wK+qXKTdRi16nwx+y75Ks28ZgxJEJheyRBAqhHKAr1IniVqNrwbr4kSPvwIKeEHQ8xfxMZM2K6Njals7KVDtrOumEqsrw3fXJtVHE33srybLykTPLao/iEZSSTyCSSOe2TYS9cYKaHxRYIqTDTbuoIGf5n1JHos840rNo/DdiCR0aTf1BryRZ5uz3xT8J+UUJy6Tt03x0embk/qVX1jkW9MZANCnuPfeVzgd1uTpZ2dIRsCJ73Pf9JTDp4xhMrei/Ve71exZKhzswBFhjTCvYQOcEMwfvNAuzznW3pi1aGmd9EvXtbJ/hA8QrKEHRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 14:23:49 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 14:23:54 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/3] net: dpaa2-mac: export standard statistics
Date: Thu, 19 Mar 2026 16:23:43 +0200
Message-Id: <20260319142346.2483232-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::29) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 478ae2cb-6317-4b88-7651-08de85c326b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	K/+/SLdObYU7S64Q79k+Gbp+lEfO2JRCIu371QKjeEC2sUeYegCHChFme5qtgnxxRI+YUaHbc9N8CWSVx7O5IarbXiuyh8DyXpk+mHOoAD6up8WPBuRh/JNnBda+GFSgdo7fJoOijfaJwuxC56qM9EF39hupWuyUW6g5TH7CUMXq+pcrDX4ovy5Go/0n+k57FUmwp2WNE5jcJGxgtfH6JpoqqL5fQEK3nggcgHEd9IpxVx40ZDTSU1MTHfQcgv6ACfxJKRXVbND3bvGouTxJ5jmmPI2+ER28sg/HxC24iPi3F8YGwyHa+ZmqP6ediHrFChGFjYe6SbjST8FBomRKqvLEa3fp61lDquxCSDwAjhZExgx2X3RyJ0sjjCO0fRkHmaiY/Jp9FHo6Rom0joMoAj9w+Rz44WpIUOtbCiRynXYzRxR5BMd1snoh8HiEn68FtPdTR1YFVQL444ah5KScZDXz/vR9sBAuqfyFHk5OLPWkoOoiruR7DN3IhqXt5dhj09W2RPmbXIx9ZMRULpXAK1MYTtNxtFYxQv9yrXps3dklT8eXYu7Fkpz7WrGJ3oINL3s3FvhKqCia5spBjdt+HBDIJs0n0I2EcXR4T8orFpM6+2XymBQQNJ47lF1II2YRyy2SAgzlzd1fB6kLD3k70TpJcUDqYMDJSo6xA15soUcDeL5DsgCKUkTuzDKtNWTh2fTHJ4jTnRy3KcW7OJL3RW58JAfpDqwgNoT2fcUKyeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bYO08qwFuGRakV6VRJv2eNIghbmOgHT/GGC2sWvj+80Rh9h8G1wANv/4DoqH?=
 =?us-ascii?Q?yzMN84IWFkLI77JM424fMsXMJbCgndeY+I0yIIPdxi+x0SK/hq5MuvbYD2Cj?=
 =?us-ascii?Q?mOY0o3Zii6+tgYWJaA3NO5ptRvxpAshnlqdioNZRMFL4d8ByaIVZhmKlZPA2?=
 =?us-ascii?Q?EGonHh0DiXv3RnYf9cs+mX+fplea5tyjH5o1pNKQK4ualIZ9LhCtnfcE4RiF?=
 =?us-ascii?Q?USph78RJU2R69EkcwWPHZtSwjjPNYyVCx5XX18zCprW0nu73zYwOZpGo58D7?=
 =?us-ascii?Q?H6pVAis5Rnqamz1U9oQz45EW4WumleKygsDO2VLqvxRh090ghmJvvecSJhbg?=
 =?us-ascii?Q?sGhfT6A29qLbIEF3Mctmt8+DloPUhRAtXtRs3Vpg5wKY+0740yFVr9uCq43A?=
 =?us-ascii?Q?RDPxzqg1fCVN0R+OlW5GF6m/24TTz4qVir6ucWBfHFZqANC4bRVFDkje3UT3?=
 =?us-ascii?Q?O9NJNHBtMY/dXs7zqH/7tIglMv2TiucxlZx2c9p+uhxmMpR4NX2u6BQwaK9v?=
 =?us-ascii?Q?luSODGN7U1KhpqulUbempoNhaQPNdvtr0ZtVsK7IFLnahPGgM4GXAg80IRWR?=
 =?us-ascii?Q?dEUPMZkd4PYesMCa8BSxwnRVr409aouHGRiczjY71rs3tIi4kM+i5aqwadBz?=
 =?us-ascii?Q?OvWzYhslAZ5L0HZQRdGhUFZuiziNVmXANprpv5hBG66DBPdRyxcIgLkN/+qp?=
 =?us-ascii?Q?6J+ibW0XtLKsV5TXLFeO+CHnMt4VGmPCQG+NpSSPpb+H77Rp6Agi+XI2zQcb?=
 =?us-ascii?Q?55vIr0NrmpYGrNAm88g65AcsXRGtNlgymSJJESp5bDnUBLoMzAMNkw939pNs?=
 =?us-ascii?Q?0JBLc9ze5awkT17/lJ+IfIWxRfJJfYsvG1QoxChOCqohbME7UxgDZpw5WjsE?=
 =?us-ascii?Q?uYm3tEEnL0xmXKS2ltq5R16iAsEGlj1gVFtqy4CHBoonZMTKuvOB79pt+BwJ?=
 =?us-ascii?Q?6wAlmzUNP35wRLMt96X54ygKJb0J5BNr3jD6tgK8s8l1c54weyJa2/+VJvDk?=
 =?us-ascii?Q?pMe8dCa1r2ZSraenulgNGNH+dCQk9EMXnvIyu7i7Wh9WXvCA5ulsOQeB7J+n?=
 =?us-ascii?Q?/937IIc8YmKnhPucxxVZ9rR3Xqw/ZM+8rCig8anN5bO8KeX+9EokCbjr/eOr?=
 =?us-ascii?Q?KSuA56FgYkrIjksont44quZplGlaZhJwGwbtMw6cPaviuGmDQaPpscaiNkcP?=
 =?us-ascii?Q?cj96QbA3azSmsftOXV5F6exJP/a/sb0nmwQcRoIdjXcfpP5bcRCeq5eS66BB?=
 =?us-ascii?Q?nwnnaltzmYlnSxY6nWtQzPqVBw/DW4uDa0lun/egbQG6bWpQSQPjwyN779+A?=
 =?us-ascii?Q?qmUfIM2gGRSwGHOiyLrl+Pb+tXzJJj4p9bQxAgmDsMxEz5CMmFAxD7pRO2ai?=
 =?us-ascii?Q?SvfE9zV6ePd+kWDMsD3wLtwwE/Ah9OPflpdgMHsprxYkAX7kQprKrx75Nqdg?=
 =?us-ascii?Q?gxD016TGWTGP8uc4D8okHuASz3vhjg4fDq3LRh5TM+QT3uaLWXQ/q3SGjLU1?=
 =?us-ascii?Q?/q8Eq+a0iWvEkclb7/UquRvIWw3IXXjPK5fsvfa7JOJxnvbpjDviJ64ZKBSY?=
 =?us-ascii?Q?RPQchvJ6aRm8h2MFtlja4sCmkCXWx/RfeSv0XP3zQmcjifCk32HtTekx2UpR?=
 =?us-ascii?Q?7oAQrYBVBwjazez7rYSQJNdE7zfZ20siYym5c45qwotLBR5rXN/8b8xcZ/aR?=
 =?us-ascii?Q?o71twtF7nDbZJUt0r9FKJ7zbM9jk3hdUR8aNK77sfastrbM9tm+cqcAi3Mf4?=
 =?us-ascii?Q?RsfX9jADTQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478ae2cb-6317-4b88-7651-08de85c326b4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:23:54.9229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym/sWZobo8D6AkeZyDnn7WKF0kY/fuEeakT+ykVVe7Nk5/MSVi8SVOuTwgooAAabH1+G9wDcox7hGce8Re0Zig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269461-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E8F72CCD52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set adds support for standard ethtool statistics - rmon,
eth-ctrl, eth-mac and pause - to dpaa2-mac and its users dpaa2-eth and
dpaa2-switch.

The first patch extends the firmware APIs related to MAC counters and
adds dpmac_get_statistics() which can be used to retrieve multiple counter
values through a single firmware call.

This new API is put in use in the second patch by gathering all
previously exported ethtool statistics through a single MC firmware
call. In this patch we are also adding the setup and cleanup
infrastructure which will be also used for the standard ethtool
counters.

The third patch adds the actual suppord for rmon, eth-ctrl, eth-mac and
pause statistics in dpaa2-mac and its users.

Changes in v4:
- 2/3: fix dma_sync call and memory leak in the cleanup
- 3/3: add dma_sync_single_for_device before calling the MC API

Changes in v3:
- 1/3: limit the documentation entries to 80 chars
- 2/3: use dma_alloc_noncoherent() instead of kcalloc + dma_map_single
- 2/3, 3/3: reduce the number of lines that have more than 80 chars

Changes in v2:
- 2/3: fix fallback usecase by using dpaa2_mac_ethtool_stats[i].id
- 2/3: use the __le32/__le64 types for cnt_idx, cnt_values etc


Ioana Ciornei (3):
  net: dpaa2-mac: extend APIs related to statistics
  net: dpaa2-mac: retrieve MAC statistics in one firmware command
  net: dpaa2-mac: export standard statistics

 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  |  61 ++-
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 409 ++++++++++++++++--
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  27 +-
 .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  48 +-
 .../net/ethernet/freescale/dpaa2/dpmac-cmd.h  |  11 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.c  |  31 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.h  |  94 +++-
 7 files changed, 638 insertions(+), 43 deletions(-)

-- 
2.25.1



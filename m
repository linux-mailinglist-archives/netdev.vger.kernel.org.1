Return-Path: <netdev+bounces-269530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KObmMuMhvGnQswIAu9opvQ
	(envelope-from <netdev+bounces-269530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:18:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 509CD2CE9D0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B4D325A4C3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEE73E92A6;
	Thu, 19 Mar 2026 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WR0WycIg"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908343EF0B3;
	Thu, 19 Mar 2026 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936290; cv=fail; b=FreK+xmaqsrsdl8tfA/BS5xYm+0pE8chAXWY+vx6/BPlQbAqfhdfKCapmn+jwVHGuuPX5pO6dALfiwMOFgwoHztgn8qRVkkwlBdvGA/2ObrZK7wd7P27mks+60wpgNaabrSFw7KCi+gJAipi2f4e3YWWrZOSUl9W5cP19TnmZkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936290; c=relaxed/simple;
	bh=ckDwvOeLVWTaFS+fhEdJiJEutCOnatYEL/5RyMD90K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7xF6aGQkfASkooOavHpVMdiSiW4zUOtnV4VQsIjlHJRjXm4/qSZ1q+bAhgAdeuCab4gJCnleUtHMNWZApbTOpwNOft/mYVQYvNkgi0Ih4R7QWWj2th9aU/g1kiinwrVT9qbuJHotAEPGlIWXqDf9Um4UlqH3DbVm9sdVTphOQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WR0WycIg; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o270Q8DjfPyZ3TWUwsmkf73j8IkCL0xh2kc/WNTL5kHzcUepYZHKKowXTshbUR1J9nPifeJmRXXqgalq2GSAq4Y4liFpEeE8L+eSVfKxlnUMGoc8XbxyBYdpI226zJfBPAalcHQkrXzu5BVE6Ub8Ibuyx10QWGjgXuaQHXVeFgzu4xbx/TM0xe+XpqTYvM/z5D5CuHycs8/mejGV1y7nG4wSrX/0Y/ebr0mz+7ImQOe1SyUZVXdZKlAqOBiD/VN6W6+XYMuhdGmJKOx69p6d/o+oYMKgAZfEGGKaDPI6DzZtSbWxpaND0ZCRKAjbE/hhwY0WV+/S3xKpOZBaSTXZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqzII8FSe2bsAUkbpCCdwg2EN+e23Ob2KjHRvZAsGzQ=;
 b=fToB/u5sZ//E99TLbD32RekExXnhbdLNrEGdsUgyYJHfE4ceAb0o0nQywg6f7wadL+eiPvT9YYdj7MYXMQvjn+ukp59o6VYCwlHn3/0AnlMNGBn60hYzc3EFvDsbjHPO82V4vXFKhSDlPV/Nfa8dv6Zy9XTpwPyPgyWwKV+LYs9iM+klHxUm5ugb1IXtj9N4m8zSR1gSLav6TXd/o4xt1KPGQqU6wlNjT28QvrcHyqfTCA80kbFNBZmF8iAQKfjt2Iq/Jm4LbBaHF+KEyse/xGDn6CZrXhXNO5NePE5S/i+fERGg+kq95f1zhrcTgG8Aj5c+RdBjAf9mFflMm3viqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqzII8FSe2bsAUkbpCCdwg2EN+e23Ob2KjHRvZAsGzQ=;
 b=WR0WycIgweabHXDmZtJGub1oG9B41JUAJPbf2ED4x+AR4bvv+HMTQ64QQrsAOau9QDnSNjWkaYZCWFR23qkIot6HAFSAw3zRjJJ/L0e8TQUA/FKAyxhFMmqKp20ZzSyDIdqhRHeBJV4Bt4OFa/U7MgB09NX8uQrWOs77HYQ+E4oaIg8VEaA5jazUklrLaAFHTW6NqW7SZXcr2VpbkIpJ2cPm5R/xW3GbJlIFjf9ibYbfYwI3hcZEo0zGjhp+xAPc/CMnhmb8CN0ViGGQfh4mXyu5dfYoOvDg6vZOc/mQsJxdryw8aJw5/m560kJ2Tvwh+phzyaB8ktpTnxxzbx6b1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11451.eurprd04.prod.outlook.com (2603:10a6:150:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:04:31 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:04:41 +0000
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
	willemb@google.com
Subject: [PATCH net-next v3 9/9] selftests: drivers: hw: add test for the ethtool standard counters
Date: Thu, 19 Mar 2026 18:04:10 +0200
Message-Id: <20260319160410.2515105-10-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::6) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11451:EE_
X-MS-Office365-Filtering-Correlation-Id: 51600856-7138-4158-1b7e-08de85d13af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ns32dxiG91v6KNSZkwDd2yFiSX+khN+Tw8XUs3Z14YOh/1mruoXV+DzuNQ4B0+wr6f01AWME5vGqErO+FDMiknpis883Lnp4ux7mvAdch12J2nqalDmWS3sMFKsUmDr5cB23QFl94OLFheYKPp66xqMmxZOhL1yxLuIgEJTwofENMXOUnKFZQrc6vVH+TupmNRg510vkZX7IYXA4r1fcinn2wWGNEBLcOFE9wK+/ByJdzwyAerbBqB7F8JdMt0hk+DA7RTv1+CHCbq1+qR+SGOoabPaZOME+acVIEAlnDhD+VDhbE/UIxt161j4HiWxHPxulGo4gywkB8pDgiMm8n8IXkqTi6fjWjSLzmFmtRMSQuZzbJ7O/uHztWhPP3E3jr2zzD7F7aONpqm+0rADBlAXhmB3Fu0ZgtLny0qX3JLGa8HlBhDjKomw3/1+n3OrsJdaoW86pUCiTFSC5KY7rBL6X0oymU41dqq+N0OEks5RLST/Uenif+ZL697fQmnZZzb9eaxTjGQ9TAgeMq8SrPyfTPeR2Lt3EbA/cHFn3Vt63+/fXa9FageB8IhPXG4lg39OHG/nnxfDcxB464gNG/TetibuAQ4/YKmFqhBYb3FYOO3jeTaH+Cu23uNF/e2NmxXGDvm7/9odefnBapWNrF14GIsPEznZU8JwzkZBNkA051g3NGu7H6T0SYOHGIJDe3aQ6eoe+lyAaI+5aEU1Nqoi+RFyCezAEDDBdY/RUwFk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/axlh3lPcrxNtPzhUy4cBxEnPSJoLTaxh2FQFDDWwJFoWC2RKuDQ8WEKXh9b?=
 =?us-ascii?Q?bAsD15D1+Gg/SkhDmD3GUCrzr6k9rum+QTszzJucosQvgRMMm8Q6Rf3bbb/C?=
 =?us-ascii?Q?zXzbm0TYbDVd77IgCqWNBCd7h3XgUjNXCB3kpsQX7PM5HM/oifw3jIW7Rz6j?=
 =?us-ascii?Q?tC+yvygxN1RoegJxStWYkGMcygdChzz/0gpWfOpk8fnX4Xn1WEAnoQkRvA69?=
 =?us-ascii?Q?8z9OsRH01s5OTA8EfFFBKU/OoCGdcgdJhSAOouzajLjOlFgy7S30mdpFwLKn?=
 =?us-ascii?Q?gKSNW91SasONnV5b5HCe7SpxBXol5ZyGJQqaI62WpOaFTkABuQNvdrAGZVzF?=
 =?us-ascii?Q?WJ1oe02KNjzObGAYGR9f+XfoFJ3Z8mL+sQPX6Xfm2a213/d9PPqVAWKd1LU4?=
 =?us-ascii?Q?0VuOZuzDuxyFgF1Vjsjv3tyjDp4RMSg/Zm4E/CKYx8wnFspm4pKJYDyC7fIm?=
 =?us-ascii?Q?hT1W5ALMktqA0p307hDdeLT7EDd/UQyl7tzdoAGiswj+2v3Hebjy6qXn1v9B?=
 =?us-ascii?Q?Dq/3ya7DAKsvazFJTld35GFzKcVOo9LvGuyPQzyqKWrDzNdWuww5juj3lLiN?=
 =?us-ascii?Q?lL4RQZwCyTa2klAkPifPRWMyCtG39xXSQmV9o77tAFpum5qynEt5yM+BFWfM?=
 =?us-ascii?Q?A4ZkCV4DJfIY4wwOiNe5yG6nDDcj3FPRm31tsm9BQPrc0pVV22x25E+VmTmv?=
 =?us-ascii?Q?F0zzhLqwNquiTouncVEh+PiZ8brrZ1Tz7IqtBzq25Ev8DyAh1NF+dn+GYxRX?=
 =?us-ascii?Q?iBr9b2/McusauCrfAEpdzwf6uZEPWQYELc5E8rYkJfJ1OAwt9kp8w1ngDBDp?=
 =?us-ascii?Q?zeABRafip9BUiWfh+mJtMlchq5DTLMk8IApcsDWLpxMYAEZPkYy8xmw7+Rfh?=
 =?us-ascii?Q?3cfx48iOcKaZqSpkUjNcTY9NCuSUDITKeNC6QchaeFUcVYpTTGAgAdfxsa4C?=
 =?us-ascii?Q?1dNzsfFIriP2mqCvZ9mN2tt8lSbiTJlko4EZwyWCbbsA4okPzaXw8oxDFUfB?=
 =?us-ascii?Q?pGfo2H2qOR+ymh+phZekNt7Hhh4v0RpZDJTqsGwwXskdEVjc9g1b6vTKNmDr?=
 =?us-ascii?Q?Z3t6PL5vGeUNcboKrc4+TD5MJiSuAsJdN/u7zWl4UA3WW002puO2M0Fhr192?=
 =?us-ascii?Q?G2G0gMPsx+/ovyJRoDGFq8VbOWQFIedSpO/ZTDkRIkfZiJSHoNmVs3cTh56S?=
 =?us-ascii?Q?mUaZT5DGj+/6vs6nH9+lqowI8BA9ZKxymly7Gmdk8jlHAu4C8O4pSP/EqNSa?=
 =?us-ascii?Q?6PhTkhp6xbKgtyTHJEVl7XGvf1dfCfmd5h1Wdcip5/co8tbZlpaAXcVAj5tk?=
 =?us-ascii?Q?fhXSFNKZb8er7R47h6dbxn4gGM6SmXt6tEaO2B+XHdPFYksNEl1veM4E3sog?=
 =?us-ascii?Q?pc3Kd39lZwfDeTjzD729uXqTzuwnDwHHepX7pADk10ZXW9mkK6dt/pQnTdwp?=
 =?us-ascii?Q?HqyILKPyV+xXRhFaALTluLCE4v0AfVjtloy5TZBMaM2BWv+ZaMJLKvqctXeJ?=
 =?us-ascii?Q?E4lxPX0aleLJEfwvPnFsAxch5tB9tasw90Bl9D2bDfJiaaUJyNizTcMAnb93?=
 =?us-ascii?Q?UQF1ZlFNrtoKeZ7pZXy7wY5L1SP/zj3w+VmOrKOR9Joni4UV2ysy18lI7EZf?=
 =?us-ascii?Q?fkQewhc8PEH4xm9uB8n6SSZOj9IO6q+IO+eKRF3QYwuEoDit8mUYHp+ApmV8?=
 =?us-ascii?Q?gafQDj67syNm93YQeJ24MACOKueVG4opjJE3tGzlTaHn4VDL3bLDtvMdZCZP?=
 =?us-ascii?Q?dXSdQsBr3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51600856-7138-4158-1b7e-08de85d13af5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:04:41.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ks/QSsUNQ0j5jUnv7E+voeNAY0o3YjNbqElUA4mLpjcf1UwE+htv/qwQBIFrVH6uK3weH66yNWGyHG+CCza/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11451
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269530-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool_std_stats.sh:url,nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 509CD2CE9D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new selftest - ethtool_std_stats.sh - which validates the
eth-ctrl, eth-mac and pause standard statistics exported by an
interface. Collision related eth-mac counters as well as the error ones
will be checked against zero since that is the most likely correct
scenario.

The central part of this patch is the traffic_test() function which
gathers the 'before' counter values, sends a batch of traffic and then
interrogates again the same counters in order to determine if the delta
is on target. The function receives an array through which the caller
can request what counters to be interrogated and, for each of them, what
is their target delta value.

The output from this selftest looks as follows on a LX2160ARDB board:

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: ethtool_std_stats.sh
 # TEST: eth-ctrl-MACControlFramesTransmitted on endpmac17             [ OK ]
 # TEST: eth-ctrl-MACControlFramesReceived on endpmac17                [ OK ]
 # TEST: eth-mac-FrameCheckSequenceErrors on endpmac17                 [ OK ]
 # TEST: eth-mac-AlignmentErrors on endpmac17                          [ OK ]
 # TEST: eth-mac-FramesLostDueToIntMACXmitError on endpmac17           [ OK ]
 # TEST: eth-mac-CarrierSenseErrors on endpmac17 (not supported)       [SKIP]
 # TEST: eth-mac-FramesLostDueToIntMACRcvError on endpmac17            [ OK ]
 # TEST: eth-mac-InRangeLengthErrors on endpmac17 (not supported)      [SKIP]
 # TEST: eth-mac-OutOfRangeLengthField on endpmac17 (not supported)    [SKIP]
 # TEST: eth-mac-FrameTooLongErrors on endpmac17 (not supported)       [SKIP]
 # TEST: eth-mac-FramesAbortedDueToXSColls on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-SingleCollisionFrames on endpmac17 (not supported)    [SKIP]
 # TEST: eth-mac-MultipleCollisionFrames on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-FramesWithDeferredXmissions on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-LateCollisions on endpmac17 (not supported)           [SKIP]
 # TEST: eth-mac-FramesWithExcessiveDeferral on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-BroadcastFramesXmittedOK on endpmac17                 [ OK ]
 # TEST: eth-mac-OctetsTransmittedOK on endpmac17                      [ OK ]
 # TEST: eth-mac-BroadcastFramesReceivedOK on endpmac17                [ OK ]
 # TEST: eth-mac-OctetsReceivedOK on endpmac17                         [ OK ]
 # TEST: eth-mac-FramesTransmittedOK on endpmac17                      [ OK ]
 # TEST: eth-mac-MulticastFramesXmittedOK on endpmac17                 [ OK ]
 # TEST: eth-mac-FramesReceivedOK on endpmac17                         [ OK ]
 # TEST: eth-mac-MulticastFramesReceivedOK on endpmac17                [ OK ]
 # TEST: pause-tx_pause_frames on endpmac17                            [ OK ]
 # TEST: pause-rx_pause_frames on endpmac17                            [ OK ]
 ok 1 selftests: drivers/net/hw: ethtool_std_stats.sh # SKIP

Please note that not all MACs are counting the software injected pause
frames as real Tx pause. For example, on a LS1028ARDB the selftest
output will reflect the fact that neither the ENETC MAC, nor the Felix
switch MAC are able to detect Tx pause frames injected by software.

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
 (...)
 # TEST: pause-tx_pause_frames on eno0 (software sent pause frames not detected)  [XFAIL]
 # TEST: pause-rx_pause_frames on eno0                                 [ OK ]

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none
Changes in v2:
- Use the new run_on helper
- No longer checking that each counter has a 1% tolerance against the
  target. The only upper limit is UINT32_MAX.
- Check that both the error counters and the collision related ones are
  zero since this is the most probable scenario (we don't expect errors
  with the traffic that we are sending).
- Removed any checks performed on the remot interface counters since
  that is being used only as a traffic generator.

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/ethtool_std_stats.sh       | 187 ++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 91df028abfc0..2b185d2fa32e 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -26,6 +26,7 @@ TEST_PROGS = \
 	ethtool_extended_state.sh \
 	ethtool_mm.sh \
 	ethtool_rmon.sh \
+	ethtool_std_stats.sh \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
 	iou-zcrx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
new file mode 100755
index 000000000000..b411a0c80bde
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
@@ -0,0 +1,187 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#shellcheck disable=SC2034 # SC does not see the global variables
+#shellcheck disable=SC2317,SC2329 # unused functions
+
+ALL_TESTS="
+	test_eth_ctrl_stats
+	test_eth_mac_stats
+	test_pause_stats
+"
+STABLE_MAC_ADDRS=yes
+NUM_NETIFS=2
+lib_dir=$(dirname "$0")
+# shellcheck source=./../../../net/forwarding/lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
+
+UINT32_MAX=$((2**32 - 1))
+
+traffic_test()
+{
+	local iface=$1; shift
+	local neigh=$1; shift
+	local num_tx=$1; shift
+	local pkt_format="$1"; shift
+	local -a counters=("$@")
+	local int grp counter target exact_check
+	local before after delta
+	local num_rx=$((num_tx * 2))
+	local xfail_message
+	local src="aggregate"
+	local i
+
+	for i in "${!counters[@]}"; do
+		read -r int grp counter target exact_check xfail_message <<< "${counters[$i]}"
+
+		before[i]=$(ethtool_std_stats_get "$int" "$grp" "$counter" "$src")
+	done
+
+	# shellcheck disable=SC2086 # needs split options
+	run_on "$iface" "$MZ" "$iface" -q -c "$num_tx" $pkt_format
+
+	# shellcheck disable=SC2086 # needs split options
+	run_on "$neigh" "$MZ" "$neigh" -q -c "$num_rx" $pkt_format
+
+	for i in "${!counters[@]}"; do
+		read -r int grp counter target exact_check xfail_message <<< "${counters[$i]}"
+
+		after[i]=$(ethtool_std_stats_get "$int" "$grp" "$counter" "$src")
+		if [[ "${after[$i]}" == "null" ]]; then
+			log_test_skip "$grp-$counter on $int" "not supported"
+			continue;
+		fi
+
+		delta=$((after[i] - before[i]))
+
+		RET=0
+		if [ "$exact_check" -ne 0 ]; then
+			[ "$delta" -eq "$target" ]
+		else
+			[ "$delta" -ge "$target" ] && [ "$delta" -le "$UINT32_MAX" ]
+		fi
+		err="$?"
+
+		if [[ $err != 0  ]] && [[ -n $xfail_message ]]; then
+			log_test_xfail "$grp-$counter on $int" "$xfail_message"
+			continue;
+		fi
+		check_err "$err" "$grp-$counter is not valid on $int (expected $target, got $delta)"
+		log_test "$grp-$counter on $int"
+	done
+}
+
+test_eth_ctrl_stats()
+{
+	local pkt_format="-a own -b bcast 88:08 -p 64"
+	local num_pkts=1000
+	local -a counters
+
+	counters=("$h1 eth-ctrl MACControlFramesTransmitted $num_pkts 0")
+	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-ctrl MACControlFramesReceived $num_pkts 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+}
+
+test_eth_mac_stats()
+{
+	local pkt_size=100
+	local pkt_size_fcs=$((pkt_size + 4))
+	local bcast_pkt_format="-a own -b bcast -p $pkt_size"
+	local mcast_pkt_format="-a own -b 01:00:5E:00:00:01 -p $pkt_size"
+	local ucast_pkt_format="-a own -b $h2_mac -p $pkt_size"
+	local num_pkts=2000
+	local octets=$((pkt_size_fcs * num_pkts))
+	local -a counters error_cnt collision_cnt
+
+	# Error counters should be exactly zero
+	counters=("$h1 eth-mac FrameCheckSequenceErrors 0 1"
+		  "$h1 eth-mac AlignmentErrors 0 1"
+		  "$h1 eth-mac FramesLostDueToIntMACXmitError 0 1"
+		  "$h1 eth-mac CarrierSenseErrors 0 1"
+		  "$h1 eth-mac FramesLostDueToIntMACRcvError 0 1"
+		  "$h1 eth-mac InRangeLengthErrors 0 1"
+		  "$h1 eth-mac OutOfRangeLengthField 0 1"
+		  "$h1 eth-mac FrameTooLongErrors 0 1"
+		  "$h1 eth-mac FramesAbortedDueToXSColls 0 1")
+	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	# Collision related counters should also be zero
+	counters=("$h1 eth-mac SingleCollisionFrames 0 1"
+		  "$h1 eth-mac MultipleCollisionFrames 0 1"
+		  "$h1 eth-mac FramesWithDeferredXmissions 0 1"
+		  "$h1 eth-mac LateCollisions 0 1"
+		  "$h1 eth-mac FramesWithExcessiveDeferral 0 1")
+	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac BroadcastFramesXmittedOK $num_pkts 0"
+		  "$h1 eth-mac OctetsTransmittedOK $octets 0")
+	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac BroadcastFramesReceivedOK $num_pkts 0"
+		  "$h1 eth-mac OctetsReceivedOK $octets 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac FramesTransmittedOK $num_pkts 0"
+		  "$h1 eth-mac MulticastFramesXmittedOK $num_pkts 0")
+	traffic_test "$h1" "$h2" "$num_pkts" "$mcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac FramesReceivedOK $num_pkts 0"
+		  "$h1 eth-mac MulticastFramesReceivedOK $num_pkts 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$mcast_pkt_format" \
+		"${counters[@]}"
+}
+
+test_pause_stats()
+{
+	local pkt_format="-a own -b 01:80:c2:00:00:01 88:08:00:01:00:01"
+	local xfail_message="software sent pause frames not detected"
+	local num_pkts=2000
+	local -a counters
+	local int
+	local i
+
+	# Check that there is pause frame support
+	for ((i = 1; i <= NUM_NETIFS; ++i)); do
+		int="${NETIFS[p$i]}"
+		if ! run_on "$int" ethtool -I --json -a "$int" > /dev/null 2>&1; then
+			log_test_skip "No support for pause frames, skip tests"
+			exit
+		fi
+	done
+
+	counters=("$h1 pause tx_pause_frames $num_pkts 0 $xfail_message")
+	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 pause rx_pause_frames $num_pkts 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+}
+
+setup_prepare()
+{
+	local iface
+
+	h1=${NETIFS[p1]}
+	h2=${NETIFS[p2]}
+
+	h2_mac=$(mac_get "$h2")
+}
+
+check_ethtool_counter_group_support
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.25.1



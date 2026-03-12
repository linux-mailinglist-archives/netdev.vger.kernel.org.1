Return-Path: <netdev+bounces-267090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHZPOevLsmlTPwAAu9opvQ
	(envelope-from <netdev+bounces-267090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:21:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D8C27339D
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AC3D308412A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54036DA1C;
	Thu, 12 Mar 2026 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KKzAykek"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44636C9F6;
	Thu, 12 Mar 2026 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325145; cv=fail; b=MU4WPsstPtF9bNLRbaB8uiSBlvg/VSwHjMNdk213D8mzIBBna6XX3IVKneYGyLLn+NnHADQXzN56UYfgeWRzRaIMC5vkqE5kN/FhSxKfjexaHF7VsNscHEMiUpM/gcdLrUXq6Bd/LHgl0oSFCSXzCTNRK8NLz2+UPh7DGdTZ9uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325145; c=relaxed/simple;
	bh=Zr/TmL0Jt2usJi9vaBnbmU1uEzPk+39kgOPRcwUBtNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fn6bJHEnRyNVJWs7NEfAdI1YTzItTHpyA48M/Hqo0dSs5d+j4xHr9GSuVHY+9dMrdSisXhJ66F0vntin7feMf4roYnuDbATqxQl96UYXn+ZUNB/6jbE4nsJNgt15WhoHrBLnNeV91fIKTFd4QqbUufTfsfCpFFSpH1wwn0XnLac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KKzAykek; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzfE+/DzVNNpZH+SDceJRzFCgj0TfdCD+6CGP8W+wIT8a9AOXsHG+6JskjMmJSZOqk62ZCDLvdzSX/Cn8/RbxbHLD1ABMWyn+7OsGSCyFZqH5G6oy+MXQQNnohKR0LKaK10MXSfixX5ml1xEPx6E5CvKTb1sp7zWXmOUgXuyu2PwmFBQjtBvEqXuqBYvBU7eGXh8yJKBUjRX/tjz3P8JSFN5jkKO8BHIyufdln7zR/v1UFOJhr6pqGY0ImcTae3j6YGk1WBL/5a+IbbRXOf/avt+WmYZKuQx0jE2oF57OIWo0jDcNtq5BzC3WCCqVRsN5fYyeKd5cdEx2kiZXMOmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys5ufl4l2x2aYrwe0hiQBz8Ts/bip/fOzE47G6hJxDo=;
 b=T5hNYJ0i4lBiEjrqY9Qe3/5Lo6Mk74HnbL3wJRNyMxD6NOibDPAcEyk7OOBtAjzbF6F/5PadtvQdyIYhRDjzztf09tH6uzQgTpAmf33ho9l2mGzWg2YCykECiFkgZmMXxJ8gEbjrMeoAZkjspWaEEISgwXPI3tUEkhrShXwAjcbVwLRr0SY4OSGifmzTx2Knc61qZQZcQNVti77KzbG8agqsnJBqffVbb3wgDPJTwQ9v79wVwkBG1ThNbnE3UDg7tBFHkbpoUzvsDlxTWbtWUQCeJACz8TABZ9usZ3WXP2P/vLFnntYvFyQGS0RUy8d7eyTeC1nswG/EU7+HR81akw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys5ufl4l2x2aYrwe0hiQBz8Ts/bip/fOzE47G6hJxDo=;
 b=KKzAykekZUXlMEACcjYLxw5j62lUoeDG5PKKng7Oqb/oxxro3rdajQJ3wCn9WuZlvQ4eQjqVrr90I4KW4EUe4lqEtdfsYDVhcS8hevD+IML3GuIRSxeBFgeNKN3k8e+wt9ul90ILM9L+AJsfupU+qZszoAEhrqoblqXAGtJl9VdcvGYew7qicO5c3mAv/RVreoBlghlOtTwSOTf7yALl/UrRAON+XqiWNQdKDppsj1tDjdBoGl4JR57JqDdiuJDvy9XS3Gq8sNVqnZzH82a7+N3gDOW5esDxAMhe6ZgUX17twqvKkXGwSqn7RzAkw1dVsozh4zZh3MN0xcF426AJtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DUZPR04MB9968.eurprd04.prod.outlook.com (2603:10a6:10:4d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 14:18:48 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:18:48 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 9/9] selftests: drivers: hw: add test for the ethtool standard counters
Date: Thu, 12 Mar 2026 16:17:40 +0200
Message-Id: <20260312141740.295353-10-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312141740.295353-1-ioana.ciornei@nxp.com>
References: <20260312141740.295353-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::15) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DUZPR04MB9968:EE_
X-MS-Office365-Filtering-Correlation-Id: 82efd869-9e24-4ccd-f0e2-08de804246f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LlaSES0ywKqPtTkERWM+f765mWaKRMlVWHMzZ+G1rUigimIUH4PbBH3GUwX/J24/UNAdFJz/UfiNI6ZS5Wiqe/VhwL+ZoN4EOL2XBPLxgRK733O87pZsxyLbetKp0rk9hxWOyTQRQMmEdejinGMkIlIOclU0aBh7HuSC+2jW9KTjIgAM7i+G3eLCBvjmrKXaZTtFrgXVxaY3fKEHb6xrLAlNx50U2Qqm1lEKKs/79mGc0QdN539P7ab6bz7cHwTCIC7oNpBaRPrJwreOAE4Cdzlcpio7vPHC1RGePqX3djqPVA42ibPBUDt4UXxzw2W7BrbJOVVxE8pKyN27LoMp0Ix0PieSRYxjW6VugMX/LmlHLbHoU2pniLInoVmYIFRsF/yW8oDiZa2JmVNmKQVLKGeMhaajhBpkSCvMwYxUJVLCh6iqsEIdYfZj4aoo8Xk9qLisyQlTJpiy7r7ewWfzMRD+7H3mUnJ5uL+QBJGjZJhYU+8RyiMLAN8tPe869aPQWUTtpca0kB2cKFY7hvpBvffzeTEd7B8+Ge16U3DuF68cHcrcH+TBPT1ovpkX0YNy19wUM1PQ0ej304+Nc+RySnkH7La40IxrIZyRJ+KzSNJ0POhMv1eVKbnqL+TLXaheVr/d1J/6W3UMYSoZQCXsVccwKnEPeZAw9NXuOf5Q0wAxS8K71VC9LFtZfXmR+4C06ScmP36lh1HSxnjTa1iCeP9Rt7VvuiTTKRToFaP5NcY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v/0w8102seEEcLrbhUV9/IR0V/pmvbh1Mc3A6G/zHtcaYpb6vrr98uqdCGm3?=
 =?us-ascii?Q?Km7zBUFkeDTZkY2g9dui7X3KqlYD3dmrr/6I1jpzycm6xThmrJu9713NNBtc?=
 =?us-ascii?Q?W66TPmaJEQqil9FVEpTVOSWEdoUUa2XKeBVfsQKnQw89MK9uVoGZRKAwtxAo?=
 =?us-ascii?Q?hh9A0vU2MVx6mUkvQi4qtr6hBqktYgXV9CEg0xCgvtfRpVdl57rvJz0XtXxv?=
 =?us-ascii?Q?phFmLWBe5oWsPwNt08WPWwfY1yc+KuE9X7ZXl1bJS0+HmMGR9YAkNXV2n8v5?=
 =?us-ascii?Q?jxr1e4a1dZQi2JeqSC1TuN1VRqsPvMKfxLc82vrX9vOcKbwDRV9j7Eke6ST1?=
 =?us-ascii?Q?EBDZZc8IhqmqmaQdU3DB3fI6qCOiXf7YH6+7PotCV0s4bjV+gY1NsMH++b9w?=
 =?us-ascii?Q?imvIV64UlV60Fi5qeArTRD7HInA6/GpFHGzNMKC+7dMYRPwo3rbJYJIdv55C?=
 =?us-ascii?Q?zJ2SaX31RxJNDtKtXAlXjsZIYoBMJXyQIyHqRUf7AuTPX6/brzTNeHJpvIdX?=
 =?us-ascii?Q?LKoqn+rJApNvgWKWgqR1PoycGpah0y0+VqD1MWhMOZg1yIQOxnEpLqZuMq07?=
 =?us-ascii?Q?+ONlnyCEalr8zIQttQNuOkkdeIXhCezZU5n3uPyLfK++cjgXVZgC53tsHwiQ?=
 =?us-ascii?Q?n4ad/CzVUJObnqaZyDsZAJ+72IzKe5CxXpHXwnG9sgSoAKmNUQYjcxUNJZDN?=
 =?us-ascii?Q?fzPOIX4q8ZloEEYAVGmsc2b//VHB5zvzfEKDiWInwywefIe9UwHvKFGPXWG9?=
 =?us-ascii?Q?z4kTOaGdAcOHkZGS66GafC2/3nnNYNMsxoOrmSeQB/IeUW4fBG+az8eUYFYj?=
 =?us-ascii?Q?amy0+97OV8X2j1bH4CRQsl38izEmXvIgNmGjPAbgLYC7dqK9UxNFF1Sncppj?=
 =?us-ascii?Q?HhwjO/kS31HVKGssVhPdRz3IUctQmqoo9SYV9LXItHscG/bAT65I3dMQsxcS?=
 =?us-ascii?Q?WQ1I3Yb9ARUA0NUVYEEVkZ/DxKfzUpLUIC85oOsmZRM2Yldjc66PS+aS5ufW?=
 =?us-ascii?Q?wI2YlbiPpeWRX7tptPajjYwPuhmfWbnxGnoI21B+ab1cMrrB300GrQ3WFP2u?=
 =?us-ascii?Q?H1pg//iDJCS4kFbkhk47lsAijZ7FaCd/Ej24YjYZRFSGxEK6EQ91q+qCTTFo?=
 =?us-ascii?Q?AasmxIVfDLtorwM5iK7CtHtcDutb0mIu+BkQVUliY/Ymd+BnmbIyT8MK4Y2O?=
 =?us-ascii?Q?DyFLXczpt7GC2CS1nosvmyf33cn0VTbpkVNJG10WkN337jbrnvqGUFxp6SU4?=
 =?us-ascii?Q?bnAgHG6WZ7BPUaD2ZNpz7HzoGHrkTTdwIKO4IeobyqePi1hHQGZA6iphgSA+?=
 =?us-ascii?Q?3hTEnaSO80R4pabEspKvCMea528d6V0lgiM7Xxk7DUn0X5LmRzBDG4uPOVf0?=
 =?us-ascii?Q?83Zdv2GT9vvHh6A4Iti8Hq4J1iNenbryh9PG7o/9JvtVO8apchKggzCJmeY6?=
 =?us-ascii?Q?zI+09Nqu6hq65s0NjmCtVKwD4V0lZcn35/eg5V5cZr0i8+Ehv1N7HOgDOxCT?=
 =?us-ascii?Q?5uVyW1hBc6oTBlJFraqyu5z6EUpaaIufTxQajMIHWK4BzcqSuhNF/xdBRHRR?=
 =?us-ascii?Q?M10tdIzWJzPocCCrxdUOTP97NrJrkLAouJkEIc1P/i537yTp0kh+LVIOJ8+D?=
 =?us-ascii?Q?dw2kPmY+GsY+ppax2hZOMXs4P7KNq1H4JOB/vMYMCvTsOf0LnB4l8vGupDeA?=
 =?us-ascii?Q?R7Ku0m0OYYFbSZfXMNQUrwIKWpdGxpVKhShZlFi+elP71OWtq6eEEjNnIaGF?=
 =?us-ascii?Q?Pnd6pAfe4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82efd869-9e24-4ccd-f0e2-08de804246f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:18:48.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQXLTdxtgFpLsunDfPHH6eHB0S3EI67VULYqr8PO10mx7Wjy/EnPNrRx08PRAgSbODSVLpimiQ9e7bCesAs9yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9968
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267090-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,ethtool_std_stats.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60D8C27339D
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



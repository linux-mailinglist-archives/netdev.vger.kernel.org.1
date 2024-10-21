Return-Path: <netdev+bounces-137418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5949A62B3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95931F225F2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216F1E5020;
	Mon, 21 Oct 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="iRpMCWrG"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6291E376D
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506285; cv=fail; b=DWuCAQ0HHWWyEFNtQ9Dp+238V+nVrm4ambthexirscshbzi8gbMW2l08FwFsLA27lut94rsKRdeVO2kJpSTzySB6ymYbgRxU9vsAcVRdqd+T0K1nw6f63jc2wo4dvMRexW1IkEg1dHBQJ5qqhMGzUAIa2cmn+QAzprn8D3kMNVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506285; c=relaxed/simple;
	bh=3R3Y9NdEOqtW5nZrMNTGClJCrALUqZ+TDHsDb8lDYSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hXjl5rnNekSv5LnUHUT8uLT660+Dhx9jds7oeTXcrm2HLNslHrA0pnLMptDXEWqBKBUK5db+8t0ffz4f28Bo+btAz1y+sdmyAQ4KnwEsnDABjOZMCEBQ2LDtaCQyfVf4eLDV1x1IcO3AkiFyjA9kcNADYsjfKKeQLGkGth9ijYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=iRpMCWrG; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02lp2105.outbound.protection.outlook.com [104.47.11.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 16BE0C0061;
	Mon, 21 Oct 2024 10:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdNBdIOgRMtgGehH5DdgaJ21cYAUn1Jt/T06G+/Q4seKol2pJ4N/kjB9DCTsuYvU0MfBU1Ks9GNXQFmh0n1qId35G1Ne1v7iM3731xkoFNCdM6lCuqMEiEQCPx7LQJ/1Mxrj47+od/iubyPKFvoYeYPO3WcLB+SJ5aW3sV374fUPCEnjxYdK0kLaGjFX2GR7H+yEsJkImHS4/iBwXUOmGttl2sP+RnvZk6u10P+mIBKAgAfQFml6nUmfPcrVN9yZo3NiRK6R2cyfIclTr6DPFteFTRpWYbRj2YfpbcrCaaFAjpCWkHhnUvgoGuJ3M1glS13FlKtRUV0x4BADh8VwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vaIc93buxMZWlnuWFwbsZHQkrBZeYShSWJoJaAvaxg=;
 b=uxr0lP23UyBjqSZyJoXyMX0XFkxCAqi972jgqDK9JZV2brJK/H3ShV5uWgyn2pWRm6o6L8i1AsfyZkQ4N//sXfn/X/khlqqAM9Y+/SWwz0eIOTpsT7za2rm2mnN/14UevgxFl1pJFIOlDJYsgXksNvXPCxXmjqe1tdrvsyvqM3ysZmbbh1BQi0Z29E+UesK1FbslxeBt12s21+KuhdWppAVElXVKH+RE9IYYd0cmmt+fVApEhBQJFjzaFLUGnw5zniL5NfdIUfv9FwdUV5mYvqDYaOIqiW35+ECtWuEELdFkLoJrLlSRN0eh4umKdzSZw3ZDUvQK4wfBbsXJnd6NvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vaIc93buxMZWlnuWFwbsZHQkrBZeYShSWJoJaAvaxg=;
 b=iRpMCWrGt4bGnn4sKy2yUDB5HMR5cca7dIJqstdvvhA01RO52jAN2evuDXTgDdUjP+XCmmiBZ8mAMxof7PHA12DDtXxiaa2te0vxtXp/nmD+gVE0k2kVUvWDGgPauSu7DuYBV1dpEFz38ChF8xIRK3jVHmxMiWAP/45CO/1UF2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by GV1PR08MB7707.eurprd08.prod.outlook.com (2603:10a6:150:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Mon, 21 Oct
 2024 10:24:36 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:24:36 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v6 5/6] neighbour: Remove bare neighbour::next pointer
Date: Mon, 21 Oct 2024 10:20:57 +0000
Message-ID: <20241021102102.2560279-6-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021102102.2560279-1-gnaaman@drivenets.com>
References: <20241021102102.2560279-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0010.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::18) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|GV1PR08MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6c973d-d5ea-4419-a568-08dcf1ba8fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YGhLw8yeGEM8rSS3R5x1UUeyYohrdoehmlUhF/oOfj62GsBzQmTwgkyhUC3q?=
 =?us-ascii?Q?/3kgzsxo3GuruZYe6GAPdKyMRjEgqt+lNMFcAgg/XoeI2wfGMhASnx3Nc6xX?=
 =?us-ascii?Q?+Y/wppIVDNcv8BuG5Bv7IHNMjNPHFe18Qhnq8+KWxszZGAyBs+BP+R6sssds?=
 =?us-ascii?Q?eSdFG/aF4Qg4Vyc/gttrPR/H4Ym5mKI3a0gTUZ6Rj67Sy0wfYBRVGe4UicPZ?=
 =?us-ascii?Q?hcwh1XeE5xHzPnaPsCFZFLsI4F3rA4+MnS6A89gFSlGYvbSBa+LvDKSzUU3v?=
 =?us-ascii?Q?tzhI3jbeYK04vUVge7Xj0b+Wz/M5pE2HYitfC4sGIQEsHclRL53koDy07uR0?=
 =?us-ascii?Q?xjriTaTPr0KqU3RxhBvRBPruZ0uDmfKRAHwFnNdFeKJ+UNv2TUzCE/AY89cG?=
 =?us-ascii?Q?rNbAc+LB2SA80N0p//ZVtMtoANuXnC2W9x3avVSeO4FNd6o96jQeJfbaesq0?=
 =?us-ascii?Q?HJHRMwy6ZBFaancgCuqb5EnJxsxQt/+gNVNhBhfgjtt+eRz1GaGE9JTV5p1c?=
 =?us-ascii?Q?gY4kpdfLYxsjK0idFWY/IkTrmSx3yJdmYrlRNN2FsCVveeDKWryn5Y9oX8bJ?=
 =?us-ascii?Q?t3XhF5yrI2veR8ZWgy2Wnva8zSlh+B3LXev9tfk7nimoD2K5EvXu217k1EZG?=
 =?us-ascii?Q?J9nTrfEHNces9wi1eJoI7Ma4LAOGHKXlyT14ExRXx3dfGvDYDJom5591Y1cC?=
 =?us-ascii?Q?Jq+SdMNOyos2grnDZ4TBKpWgERACKSgB5W/mxBOfSCV/YiZ1pyy9XwUOQIiQ?=
 =?us-ascii?Q?xrElbD3RIVxnMrcLbh53ySe3td/DdDhN7YWcoQMbJbw4hknRzPXNLVTTrtMv?=
 =?us-ascii?Q?eo2kSMl/AkzpaZe3CAvpHMSWJ/LQLtIcqn5TFPeEFlW1e72QLuHgcLBLpSTb?=
 =?us-ascii?Q?KAf6sr1JWvajtWtk2gqv+EDj5SBvQw21irM1jn0C6RMmFSDhJn8gHAmSP5R+?=
 =?us-ascii?Q?MXXVIrMWrHgHOhKwiILdtrGnu74MURfq4j5Vdtm+ZeLuiU2QpSBm+pSosUsV?=
 =?us-ascii?Q?NN+gWJD5GyDQasftsBgQyowLzq3Nh4kBsYgcbXFKNqa7mZmqJIGnDqSx+7Ds?=
 =?us-ascii?Q?ntRtTIKeFAVCK8p0rn93+oNtT2GyYZYN2N9OMahgNLkDTTHidWSjQgqX9h7G?=
 =?us-ascii?Q?kVSJrRQA5kyV82HKfK1bNQjJn33JrVa7luzGHLyRaCKxk5PL9Yx3GggMFe4M?=
 =?us-ascii?Q?s4VTph6nexeVHxTCfg8gCdjNvKQ5reyPyi+7eVGtLdf5IAjgoQS/V6gikhsL?=
 =?us-ascii?Q?GjtkwnbxX8EqvudYWVOqgcxIQT2qmNc9fWENRrQZLrsCswa3Cqjk2A68lChm?=
 =?us-ascii?Q?p7PDggChvD0WDgg4ekPubQvLMcSO+4f0zPA6opCHiG72Z4vgF1Vgc6vLsS9B?=
 =?us-ascii?Q?ABeu8as=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ESqPrcwJzCA9gMSmUBI3ZXHyFfaEFrLlenuTbx0lpNiP578j3katU5UmfHQZ?=
 =?us-ascii?Q?u6Z+74ilDRHeXy2fcI/GguxzhfL1m98VVMGmVrUI0ikbsuTaqEjZu4EqOv/g?=
 =?us-ascii?Q?e0oDgWyUOsMO2SJZu2PQ5yCYquTnvSJQqhJz96/GPzP0XleQFb5k/kjbq/x9?=
 =?us-ascii?Q?4FcIaia4sz/Jo2A5mj99xxPNcCxesjbrN3XEgSU3kV3rU+vDeV1kZNlqbm3Z?=
 =?us-ascii?Q?EP3tH8PYwqDjAjognJkqMWYC8xw8kWRNauIy0LxpIx9Rw09bB3mt6rrXzVu9?=
 =?us-ascii?Q?ajdCJ8m47MOHmSaMTVawetx+qpZ5ByU4bRwHTfXNvozlm/KAMkcKqmMcwz7b?=
 =?us-ascii?Q?bmBkAboQN14Rg9zWOgu0LIWUdiSZH2qNyxT7QDjPRRwzk8vZdeS0M29jsIXF?=
 =?us-ascii?Q?FFC/uDydvYwY1sO7TTypd1nsw5CPqETWgkBOk6Y82O8y8VgRaSNDFAFH53bh?=
 =?us-ascii?Q?07bphs2t2sWUnK899oH1U8kWu86YXmFk0WrJkJjg2PHR92c1k4XPJ4yrwyRR?=
 =?us-ascii?Q?Mxf55k5u43J2pq/vLBOCINda9wz6KMqdUSszfBWpZPjKJ/OerpRrWj+ZZOUI?=
 =?us-ascii?Q?D+6aff1JMd8qhCNLsJC7AsWCNji4Fe3qQBOGb1XLDaNWlhOE1ws3t33j7XTR?=
 =?us-ascii?Q?GqEpetXv4jP1+/malB4eAuIpCsaU49RTHi2eXdMatXmfbU4loA/g/TodNnFa?=
 =?us-ascii?Q?+AhD6qXKi0Fo8nna2VsflP+NNRLSkwZuF/ZMuOfocf+o5uyqUFCWU29sJqA1?=
 =?us-ascii?Q?LhpF82gpIs7yWcBP1q2mkCQ+0uci8vDoddDOGkug+kMy++72R5mQlQNE34EP?=
 =?us-ascii?Q?MqbPa3M/jkX8wjSAXD693sqC4ccT4nM09NzVoqJnpbWjz9TWH4cVfplB/rPy?=
 =?us-ascii?Q?Bp8ngtfva0Wzn49ic9OYNrnSplf/7konKldmP6/wDZucBEQCTIKlMooE+KEN?=
 =?us-ascii?Q?paK3Npr0aORKfHByMqpzNNHtJYRydeUfjW2HMEgS0NANBUn6gty9X0yyo5R2?=
 =?us-ascii?Q?ib/hMa16oYcx9KaWCWcmnShqqrgatTwVPYD2bWES59Y9cJMDpqyvrxR0NVFf?=
 =?us-ascii?Q?VaG+p6y0jSrCqxL75lD6E0Nekg9O2K0HQaHQZHFZVQ79xm47L2KorAt3tgnK?=
 =?us-ascii?Q?omnLqT+MKdw8g1mKePcGbaHk4lDjRZ3h78uQNg9FieVbDbw5BDIm3ATDC9xU?=
 =?us-ascii?Q?pbPLppG1mZBpQibhWgiHg1kpc1D70NQNXHnz0mMQo/JmxZgWMOQbVAfTkGLH?=
 =?us-ascii?Q?4vxl54dH/8gPTrlb5fFEU98v6LvMaEqVDRCBrMZIZXY3LY+hixl6HBPNU1lc?=
 =?us-ascii?Q?UvtG+gI8KR8FIZE5Dn+hstsYTyoqhJIFvmyHhAj1BG6BbZifhS3OORkDP0Ny?=
 =?us-ascii?Q?pAOYUSd9TDFpC2/jKOolMrpQiSuZNXav2HKoH/3QWE1Oh8mpINZ0DYQvpAy1?=
 =?us-ascii?Q?H5Qr+LhNMnct41auRGgcAD+9Bn84iTlxrRfQzqJZ+ZCPgf1qVGjXEdrC/+mA?=
 =?us-ascii?Q?AH4VATTa+Xi2IcD+NOIj/o+vD7ghCncxjFOHq17sQNzzKG5wGqKSyj7o+WsA?=
 =?us-ascii?Q?Kv2ebJM/tUTyfHrU+FCv2LFE9Xq2i9tY2HXii/5no4T02IWXwb7jsHOCJnV9?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bDZQ9UAkChqx2scmb7+IORCgi7KRjMjaByDMSpY7uo2G9YaLxzOVFuOeS7wMXNd9plet97JsKKA4cCujUBmSL5YIHG+79Uu0LPVfr4eWFTrhzy8XqaQpN4SBdoTVsXwL1E6pz4L2WIrj1LUAFf7wnmjh+G7AA1TMnUcyJbDJFt4DbXeBFUcmaDgrTf9iQG8Agg5su4ILs8ENd9H6ESmOKKvNwJJ5/qoQ3fTlF8hAwaSAcsiphzNVgC7OKq3dYUVfRgh2ATta1O7JftAotv8rGkw/anhIvFNFoC/wqhyUM2nV+vpoYEStr7vK5r40eyTq+bTvGUCmSCwtilhIt/1Yg04FQr8kMTnsBYWHtmSPeFntPEKXBnPXpuoLJt/crokTGOdacmmzAMgBgCKpZaLqetv3a4ECMHA9jWUjxPD9VPWSa4lX8/Em+T61VyylRKKyx4fK/H/lNpGAfr/NA6cYL5l/ZiZeA75mt8IcDVL0J/VDYjuWSyfZrZD7bWyeagVgz5rlsfuJCMBHmzBvhcY/27C2pCjBkIkxGW/381MJnp2lBL2YcJVXBg3EnwDadXda7Df/xJ8gPU1QWPmNYOSXPYXIlCCaGWVNEQiAy9+sbyQJgoa/z2yRGEA7w6lVwPY9
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6c973d-d5ea-4419-a568-08dcf1ba8fc6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:24:35.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGhvGBigTtpYNsd2Vk1nUAo6QzDTXMCC0NH9vDw03YZb5AH/DathDdI9brv6FgW7wQJrLGp4qaoO4ZfoJjqJvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7707
X-MDID: 1729506280-EG50qw8tYK7f
X-MDID-O:
 eu1;fra;1729506280;EG50qw8tYK7f;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove the now-unused neighbour::next pointer, leaving struct neighbour
solely with the hlist_node implementation.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |   4 +-
 net/core/neighbour.c    | 118 ++++++----------------------------------
 net/ipv4/arp.c          |   2 +-
 3 files changed, 18 insertions(+), 106 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 68b1970d9045..0244fbd22a1f 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -135,7 +135,6 @@ struct neigh_statistics {
 #define NEIGH_CACHE_STAT_INC(tbl, field) this_cpu_inc((tbl)->stats->field)
 
 struct neighbour {
-	struct neighbour __rcu	*next;
 	struct hlist_node	hash;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
@@ -191,7 +190,6 @@ struct pneigh_entry {
 #define NEIGH_NUM_HASH_RND	4
 
 struct neigh_hash_table {
-	struct neighbour __rcu	**hash_buckets;
 	struct hlist_head	*hash_heads;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
@@ -352,7 +350,7 @@ int __neigh_event_send(struct neighbour *neigh, struct sk_buff *skb,
 int neigh_update(struct neighbour *neigh, const u8 *lladdr, u8 new, u32 flags,
 		 u32 nlmsg_pid);
 void __neigh_set_probe_once(struct neighbour *neigh);
-bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl);
+bool neigh_remove_one(struct neighbour *ndel);
 void neigh_changeaddr(struct neigh_table *tbl, struct net_device *dev);
 int neigh_ifdown(struct neigh_table *tbl, struct net_device *dev);
 int neigh_carrier_down(struct neigh_table *tbl, struct net_device *dev);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 395078d8b226..47eadf1b2881 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -205,18 +205,12 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 	}
 }
 
-static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
-		      struct neigh_table *tbl)
+bool neigh_remove_one(struct neighbour *n)
 {
 	bool retval = false;
 
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
-		struct neighbour *neigh;
-
-		neigh = rcu_dereference_protected(n->next,
-						  lockdep_is_held(&tbl->lock));
-		rcu_assign_pointer(*np, neigh);
 		hlist_del_rcu(&n->hash);
 		neigh_mark_dead(n);
 		retval = true;
@@ -227,29 +221,6 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 	return retval;
 }
 
-bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
-{
-	struct neigh_hash_table *nht;
-	void *pkey = ndel->primary_key;
-	u32 hash_val;
-	struct neighbour *n;
-	struct neighbour __rcu **np;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
-	hash_val = tbl->hash(pkey, ndel->dev, nht->hash_rnd);
-	hash_val = hash_val >> (32 - nht->hash_shift);
-
-	np = &nht->hash_buckets[hash_val];
-	while ((n = rcu_dereference_protected(*np,
-					      lockdep_is_held(&tbl->lock)))) {
-		if (n == ndel)
-			return neigh_del(n, np, tbl);
-		np = &n->next;
-	}
-	return false;
-}
-
 static int neigh_forced_gc(struct neigh_table *tbl)
 {
 	int max_clean = atomic_read(&tbl->gc_entries) -
@@ -277,7 +248,7 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 				remove = true;
 			write_unlock(&n->lock);
 
-			if (remove && neigh_remove_one(n, tbl))
+			if (remove && neigh_remove_one(n))
 				shrunk++;
 			if (shrunk >= max_clean)
 				break;
@@ -388,22 +359,15 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 					lockdep_is_held(&tbl->lock));
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct neighbour __rcu **np = &nht->hash_buckets[i];
 		struct hlist_node *tmp;
 		struct neighbour *n;
 
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev) {
-				np = &n->next;
+			if (dev && n->dev != dev)
 				continue;
-			}
-			if (skip_perm && n->nud_state & NUD_PERMANENT) {
-				np = &n->next;
+			if (skip_perm && n->nud_state & NUD_PERMANENT)
 				continue;
-			}
-			rcu_assign_pointer(*np,
-				   rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+
 			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
@@ -532,9 +496,7 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
-	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
-	size_t size = (1 << shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets;
+	size_t size = (1 << shift) * sizeof(struct hlist_head);
 	struct hlist_head *hash_heads;
 	struct neigh_hash_table *ret;
 	int i;
@@ -545,33 +507,17 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 	if (!ret)
 		return NULL;
 	if (size <= PAGE_SIZE) {
-		buckets = kzalloc(size, GFP_ATOMIC);
-
-		if (buckets) {
-			hash_heads = kzalloc(hash_heads_size, GFP_ATOMIC);
-			if (!hash_heads)
-				kfree(buckets);
-		}
+		hash_heads = kzalloc(size, GFP_ATOMIC);
 	} else {
-		buckets = (struct neighbour __rcu **)
+		hash_heads = (struct hlist_head *)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
-		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
-
-		if (buckets) {
-			hash_heads = (struct hlist_head *)
-				__get_free_pages(GFP_ATOMIC | __GFP_ZERO,
-						 get_order(hash_heads_size));
-			kmemleak_alloc(hash_heads, hash_heads_size, 1, GFP_ATOMIC);
-			if (!hash_heads)
-				free_pages((unsigned long)buckets, get_order(size));
-		}
+		kmemleak_alloc(hash_heads, size, 1, GFP_ATOMIC);
 	}
-	if (!buckets || !hash_heads) {
+	if (!hash_heads) {
 		kfree(ret);
 		return NULL;
 	}
-	ret->hash_buckets = buckets;
 	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
@@ -584,23 +530,14 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 	struct neigh_hash_table *nht = container_of(head,
 						    struct neigh_hash_table,
 						    rcu);
-	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets = nht->hash_buckets;
-	size_t hash_heads_size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
+	size_t size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
 	struct hlist_head *hash_heads = nht->hash_heads;
 
-	if (size <= PAGE_SIZE) {
-		kfree(buckets);
-	} else {
-		kmemleak_free(buckets);
-		free_pages((unsigned long)buckets, get_order(size));
-	}
-
-	if (hash_heads_size < PAGE_SIZE) {
+	if (size < PAGE_SIZE) {
 		kfree(hash_heads);
 	} else {
 		kmemleak_free(hash_heads);
-		free_pages((unsigned long)hash_heads, get_order(hash_heads_size));
+		free_pages((unsigned long)hash_heads, get_order(size));
 	}
 	kfree(nht);
 }
@@ -629,11 +566,6 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 
 			hash >>= (32 - new_nht->hash_shift);
 
-			rcu_assign_pointer(n->next,
-					   rcu_dereference_protected(
-						new_nht->hash_buckets[hash],
-						lockdep_is_held(&tbl->lock)));
-			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
 			hlist_del_rcu(&n->hash);
 			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
@@ -738,10 +670,6 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		list_add_tail(&n->managed_list, &n->tbl->managed_list);
 	if (want_ref)
 		neigh_hold(n);
-	rcu_assign_pointer(n->next,
-			   rcu_dereference_protected(nht->hash_buckets[hash_val],
-						     lockdep_is_held(&tbl->lock)));
-	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
@@ -975,7 +903,6 @@ static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
 	struct neigh_hash_table *nht;
-	struct neighbour __rcu **np;
 	struct hlist_node *tmp;
 	struct neighbour *n;
 	unsigned int i;
@@ -1003,7 +930,6 @@ static void neigh_periodic_work(struct work_struct *work)
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
-		np = &nht->hash_buckets[i];
 
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
@@ -1014,7 +940,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			if ((state & (NUD_PERMANENT | NUD_IN_TIMER)) ||
 			    (n->flags & NTF_EXT_LEARNED)) {
 				write_unlock(&n->lock);
-				goto next_elt;
+				continue;
 			}
 
 			if (time_before(n->used, n->confirmed) &&
@@ -1025,9 +951,6 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
@@ -1035,9 +958,6 @@ static void neigh_periodic_work(struct work_struct *work)
 				continue;
 			}
 			write_unlock(&n->lock);
-
-next_elt:
-			np = &n->next;
 		}
 		/*
 		 * It's fine to release lock here, even if hash table
@@ -1984,7 +1904,7 @@ static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     NETLINK_CB(skb).portid, extack);
 	write_lock_bh(&tbl->lock);
 	neigh_release(neigh);
-	neigh_remove_one(neigh, tbl);
+	neigh_remove_one(neigh);
 	write_unlock_bh(&tbl->lock);
 
 out:
@@ -3143,22 +3063,16 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
 		struct hlist_node *tmp;
-		struct neighbour __rcu **np;
 
-		np = &nht->hash_buckets[chain];
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
 			release = cb(n);
 			if (release) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
-			} else
-				np = &n->next;
+			}
 			write_unlock(&n->lock);
 			if (release)
 				neigh_cleanup_and_release(n);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 11c1519b3699..cb9a7ed8abd3 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1215,7 +1215,7 @@ int arp_invalidate(struct net_device *dev, __be32 ip, bool force)
 					   NEIGH_UPDATE_F_ADMIN, 0);
 		write_lock_bh(&tbl->lock);
 		neigh_release(neigh);
-		neigh_remove_one(neigh, tbl);
+		neigh_remove_one(neigh);
 		write_unlock_bh(&tbl->lock);
 	}
 
-- 
2.46.0



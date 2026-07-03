Return-Path: <netdev+bounces-304501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uNkrAXKVR2pqbgAAu9opvQ
	(envelope-from <netdev+bounces-304501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:56:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A20D7017FB
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:56:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=qzN8nyqJ;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304501-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304501-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A34B30E52A3
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87243D75A6;
	Fri,  3 Jul 2026 10:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013019.outbound.protection.outlook.com [52.101.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC303BED74;
	Fri,  3 Jul 2026 10:43:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075396; cv=fail; b=a24ckuG72fUEl9S4FC+aALlUGtCOkFZ06Ut4dCpjS47Ac4uXtvxK985DfISeCmggrE+yYAsHvPfFOhXWyNMeXaR2X21KRbRVLam2vftVf4+rsXy6NeZEKW9l2H0OF3PaGEWt4LnbFuYdtVSOPEaDtt+1oS7F+hzWCG8vZLhn6Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075396; c=relaxed/simple;
	bh=os8nZpvyegweKdzlt7uHgGZFuYjZulTjLz3jdb2MYHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FP6IjkexOD5VAoQ+bm5wKIWd/Ogt8MjbhfZh7+28aKUWNHnaWqadRc3yOAb87zVr+WqrYuLqxZR6mRXZAbiU8BpXMabujSKMLKq7wi47L+cj9C1DDBGwjzAZnK0eu/m2PACMA8fbs+RWMIOc/teDuxGQP7d59GOijFIiyHzbEBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qzN8nyqJ; arc=fail smtp.client-ip=52.101.72.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhLOG40FjvEm+IbslLnYuemcYE8/Bdq7N4bsb9mwXmqqBJ79hTf/7o5zDCfCgay+GwZCYFO4ht99kKcLwyPDuiepyOJV360MpvnaLIsifQeG6XEJvAR3gn3PWg793USFe6ZHrxbOTlSE043d07ciWLvrToM8zF080+62uQjPW8SnsGdls37GUcW1MElHYBhIEwnuI2wjaan1FvtxxEMBlEwrcFldNIa7WpgE1u5ZpBtLcIDYDpjROpKXrku62tcjey0vngBQGjUnUzTgIlHjB63cFQzM5+a8xb1ut+CvM+fmefcREAqCU5NtaLpjQsRDYd1y0PzYobIq8fsT7Q0Vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+y78fiqMkApwkZWG4to5BCfnVS+OQEVvEE68nctz6g=;
 b=yy/73Uj7XmzmRkz8ZGAj8ridEc/2KlFmvFwGLoVZZZPs7EyJ6dev8OerHrPYjKu8LjaHicR3Xip77NBhtVan2VsBcQeoFgbA3iLtBMnxc2NT1lvZugnpEeL2oAFbklWrYhbIWICupCIE8WGcMthS86FN8JRLur3aQ1SU0h9U9HmUA1Zq6dLFwBrYQE95eXtdDoOO9xIEd5bd35Ti3wqkq/0ykpLqfz/xsq7P+VhyGIjUuINHzhq45qHHckIwtfCLqYeyeV2vp3N+vQ+pMlvKbNrAnEQoEPven7eKpD5IJ5fWzi2gHxjHM+kEcikmiczpUSlqsM7Zv8seDwykDiOrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+y78fiqMkApwkZWG4to5BCfnVS+OQEVvEE68nctz6g=;
 b=qzN8nyqJhXHxHy3JdbvFLqWXDiSgYMhfe3pYKULiGPyfCkxJ8ONyKBEtnmoTCKY8/LCqKsem+AXFNf/cG6S83x2gwxlYWHZZ+cBtwO8vLPHS649HPqHf0imG3dzhMf+w2lwzbL0o8zrU8KJ+17wGISqa10WOm1j8T8/YNLUaUcVe3r5gNpX57ed8PDC9QRtKVe+rFUAkky4oof3FHzoM88ftbNuepU1TVeDQgADw1fLkCSdYpgdF6y47HQHWWStBOAjxyvCX+DgDkpeGMYQhxnQQ2FScvx4C3OWl16LgIgV0Oe4lJGnGcfE2iqvwcLyA6dZMevkS9fngv4k8DzlLJg==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA1PR04MB10867.eurprd04.prod.outlook.com (2603:10a6:102:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:43:12 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:43:12 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 11/14] net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
Date: Fri,  3 Jul 2026 18:13:25 +0800
Message-Id: <20260703101328.550714-12-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PA1PR04MB10867:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fc947b-6cc0-408f-e37e-08ded8efe17f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6cPpIne4xLIQUO3bqnM+/t/3C0c4rK+waCB7KKdM4NaFpo2DevaziYuJGdZ4vjG9QSCkwlnEyMMkQk/nW9+vIcRDpgnvrCm+KFYULd/hJkz5wC/+Ti9qp5cGc6kP6BkcabxOqsToWfhK8HFgl6fr41aqUmV/p9YfJ7hn1KK8ySvDr/zUwQxHhA2oStlmDhBsrBfSNvFkugAgtNEdbKLJnpaF9BLi6XU8qYBucVrLbLI1T+GWJI6qhOAIc9lf2THk5IVXpmvvMeAwbRzlmuQD0HyxTKBxVZc8Ni1MG/1bWaBUg4Im4nSWClupdH16uUnURhMaWMw5rF7hcygftORp/zhyuOwylr9XfRNVKuQk7+tDMZoFh1RhH7ij8sDBa4qoCK5ca8Qs1w9ecnGs3S4w8CUUxdjeS3PgoGjpYQKVqkq91d7VfMNZbhOBWU7jXaagEOux/Ukiza4am5gogrD3jGyV6HnsAuvbUV0H6L1OGhO6P28Sq5JL4V6r3D4xEgKSwloF9G7mVa2IUqF/nhi3C26LJc8rqt6eJZ8vevRRPin32cufWVGVQ10Y5LUFVREpccklLYpPm4UWcaZJD1F00raqsqJYopJKNWLjrVobjNwMzurEIxvCC+7Yh0fR/0Ita9U/qm2caM6t/m+cr8xv8D3YhXms+2rGoBiDA6qYrCmtwR/HdCiwWl76nIRc9CjBU8+l9nRCoxUfzlTqspCl4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N+NnS0tohAyFCQ4QtDvEuJWm/oGQc9renDR66I5Ichxd09OlAgeMIH0RdRnr?=
 =?us-ascii?Q?jDmqQtMtHRAHRm8xmAsa25BgC1g8gsbx54JpTn6KZmd4XWY0Fg0xbmCjBy9n?=
 =?us-ascii?Q?xCKq5kMVwsZqDBCpsOSMSiq35WgfK+Hjsr4jdUtLILRcZyJ4jT4NevpWXBy9?=
 =?us-ascii?Q?F9ERSE6OA4Qx1hFiNz8Qkl2O+7DoYrESWwPR9iwinLfbNyva6KbGe35/+KL/?=
 =?us-ascii?Q?OgTamR5RLDdtyd9bsMD4lMpHoBPaSVWcnDRZBidjnHSRfA53e2xHqqQBxndz?=
 =?us-ascii?Q?XLwGe2bHqccMVw9VGeo/S5GcPUE4C7IlcarfqGm2rdqhmlTcCgc4RRebDHst?=
 =?us-ascii?Q?QDlFt6bPHrFE+GhqtjPkbq5Zyo9x63d4GU0qP4arid0Lzw2yah7SckOeQbgf?=
 =?us-ascii?Q?zkQYIkNRNxCnLssznWrWLMZdtGP+SAX3SkD/4MQkHANsLcaQ6OLMCvSDxMt5?=
 =?us-ascii?Q?7vIhhKN4zQOEBW7wBvZrH0FwnVMXjZYqa0w8anv6upRESViHoXJqxqgBqszM?=
 =?us-ascii?Q?HXAHqUvN2eY/ue51vm/X62OoBJ20HD6PuZ4T3vqv0PXmAd4cTmaco1TRUo0a?=
 =?us-ascii?Q?JoXX7enCva6sUuN/joSQmgWzSIXKyEILGzv20XmpCWWNKbOLryUTQKn3Q24M?=
 =?us-ascii?Q?/SN6vWxtoujV0ye2oO6EhAFoypvIOg26uVbBKdpKFzVgF4CfBQgb5Acd/cmL?=
 =?us-ascii?Q?n2pfW0/8TWgsOAslQocwXWuEoY/aiA98emrWX9j/dQiYtmQ1a5JWos82AAS4?=
 =?us-ascii?Q?anfScLMusO7egIrct/MyHmTmy1cUymrxhqENuklRvIUmlYg6iQxnZyokqEx8?=
 =?us-ascii?Q?fMQUzyjv8JvR/TCg7hJCeFFWoCAaDjHAZu5sknmossY+Mxy7rzzSM5LB6wjp?=
 =?us-ascii?Q?5Q0S8PjL/nlcgvD2onksAfCA5GBPVuQRzY4HEZj3zX8AWqGeWnFrYgfCwym3?=
 =?us-ascii?Q?/TB0P1fVf+jXpYjtAYz18NMecctO7/YAwxSGsMkBsTb9otbrx+5YaD23L/DC?=
 =?us-ascii?Q?f9yw6FWW8ZTtcTzFy6vV/C7Ar6dvmcZ6eCNKz5UJvHLIdLSNOK9UGpp8Y4wZ?=
 =?us-ascii?Q?guiV00GtTuJT5sFqFbgQ5LHntcmZfL+HTOyu7CXg58vu0CvyCgQT3v8rpgaT?=
 =?us-ascii?Q?OR9uHW1idBVNZqmxV4qpKdam5fJDfd0P3nTf+Kip4cjfHST9JPl9izUF5BzI?=
 =?us-ascii?Q?zExoNTjxmR/ILctaieGdHB9D14kV+ZKtyGT5+IBxOCCOHj1xx8wNr8UrDVNh?=
 =?us-ascii?Q?Q0FDUu6/KjtlTWZ83iNlaLMVFGqsPAlxjJRtfQARoMeafDSLMqdziM6TIbzz?=
 =?us-ascii?Q?DhUTjYRyfPUpz3hQ2zb2Uu04kf6ftdnvg/dMCDY8xQ905Vxx0I02XGrDEO5z?=
 =?us-ascii?Q?NqJUYeE6OTiZ8VDQs2cnwp5SqNt7tEzvm6QmIXacMr/xVVdYTtEwb2eFHTqb?=
 =?us-ascii?Q?v4rCtWJPdyN2SpfpxUf0YnUakcHUD0OFhOldX0iDV6liX9IHmkybT8opeHbv?=
 =?us-ascii?Q?9sx/YIeGx+8GRcbqxnofoEoiYpOLxkQzDchVzDxbzpZCxAR5Oo5LJXtEp9i+?=
 =?us-ascii?Q?h68PMcsjMf/FnsH/44IbNhYF+Aigm+VXAzLgDErlX+BQO0BTM3aSlpeMS43m?=
 =?us-ascii?Q?vA7Pl6c+3ZfUc+Q/Ko/qlrAnIIJU19b2pjH23B1bx3gp2kqKGQyqi8PB/45r?=
 =?us-ascii?Q?cSs3shsY22RPJeOj0LQihlJvrPUgBEycYPvv4tOXj2cCGG925L2r1Qr/JbQc?=
 =?us-ascii?Q?z7pWd5YT6O+QbbFcnu8dpj6vznKPK1DytqSeEqCpZUz/tdPg/ArJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fc947b-6cc0-408f-e37e-08ded8efe17f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:43:12.6390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+j1saq92dIhL/TPFt7tvltkgD+q+w2nQcB1eGT9zbmOvF8I4BjbBF0NHWpLK6hlTRGG+1FLp5nZENaKqJk6uhvp+wmlOidvSHFe5bseII/LSslubyaTp4pnVSBLxNlz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10867
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304501-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:maxime.chevallier@bootlin.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A20D7017FB

From: Wei Fang <wei.fang@nxp.com>

The PSIPVMR in ENETC v4 has the same bit layout and functionality as the
PSIPVMR register in ENETC v1: bit n (n <= 15) controls VLAN promiscuous
mode for SI n. The only difference between the two hardware generations
is the register address offset.

Since the register functionality is identical, the VLAN promiscuous mode
setting code can be shared between ENETC v1 and v4 drivers.

Move enetc_set_si_vlan_promisc() from enetc_pf.c to enetc_pf_common.c
and export it so that it can be shared between the two drivers. Add a
revision check using is_enetc_rev1() to select the correct register
offset (ENETC_PSIPVMR for v1 and ENETC4_PSIPVMR for v4) while keeping
the same logic.

Remove the v4-specific enetc4_pf_set_si_vlan_promisc() from enetc4_pf.c
and replace its call site with the new common enetc_set_si_vlan_promisc()
to eliminate code duplication.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 17 ++------------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 16 --------------
 .../freescale/enetc/enetc_pf_common.c         | 22 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 4 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 505e4abf6c37..cab79f81d6fe 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -295,18 +295,6 @@ static void enetc4_allocate_si_rings(struct enetc_pf *pf)
 	enetc4_default_rings_allocation(pf);
 }
 
-static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
-{
-	u32 val = enetc_port_rd(hw, ENETC4_PSIPVMR);
-
-	if (en)
-		val |= BIT(si);
-	else
-		val &= ~BIT(si);
-
-	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
-}
-
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
@@ -352,7 +340,7 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
 
 	/* Enforce VLAN promiscuous mode for all SIs */
 	for (int i = 0; i < pf->caps.num_vsi + 1; i++)
-		enetc4_pf_set_si_vlan_promisc(hw, i, true);
+		enetc_set_si_vlan_promisc(pf->si, i, true);
 
 	/* Disable SI MAC multicast & unicast promiscuous */
 	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);
@@ -518,12 +506,11 @@ static int enetc4_pf_set_features(struct net_device *ndev,
 {
 	netdev_features_t changed = ndev->features ^ features;
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
 		bool promisc_en = !(features & NETIF_F_HW_VLAN_CTAG_FILTER);
 
-		enetc4_pf_set_si_vlan_promisc(hw, 0, promisc_en);
+		enetc_set_si_vlan_promisc(priv->si, 0, promisc_en);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index afc02ed62c77..a509929f89f2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -42,22 +42,6 @@ static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
 	lynx_pcs_destroy(pcs);
 }
 
-static void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id,
-				      bool promisc)
-{
-	struct enetc_hw *hw = &si->hw;
-	u32 val;
-
-	val = enetc_port_rd(hw, ENETC_PSIPVMR);
-
-	if (promisc)
-		val |= PSIPVMR_SI_VLAN_P(si_id);
-	else
-		val &= ~PSIPVMR_SI_VLAN_P(si_id);
-
-	enetc_port_wr(hw, ENETC_PSIPVMR, val);
-}
-
 static void enetc_set_isol_vlan(struct enetc_hw *hw, int si, u16 vlan, u8 qos)
 {
 	u32 val = 0;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 781b22198ca8..d32a195a04c9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -171,6 +171,28 @@ void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_mc_hash_filter);
 
+void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipvmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipvmr_off = ENETC_PSIPVMR;
+	else
+		psipvmr_off = ENETC4_PSIPVMR;
+
+	val = enetc_port_rd(hw, psipvmr_off);
+
+	if (promisc)
+		val |= PSIPVMR_SI_VLAN_P(si_id);
+	else
+		val &= ~PSIPVMR_SI_VLAN_P(si_id);
+
+	enetc_port_wr(hw, psipvmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_vlan_promisc);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index bf9029b0a017..8243ce0de57f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -21,6 +21,7 @@ void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
+void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1



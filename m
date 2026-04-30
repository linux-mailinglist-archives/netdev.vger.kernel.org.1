Return-Path: <netdev+bounces-282802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA8oEc8/82kGywEAu9opvQ
	(envelope-from <netdev+bounces-282802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:41:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1E4A2474
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A828307BD64
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86339402B9A;
	Thu, 30 Apr 2026 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P72qoOLm"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05DA401A30;
	Thu, 30 Apr 2026 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547973; cv=fail; b=S/3tazEMWZmpEnxyt0O83IHBlCn/bF98SfXCaifXAs0CACdjzQWJxhWQbHaamV14oHWnmJPSG9s+bEZ8pWCU7pogRKv74JpEV+i5AR30DWtGX3rfpF0NLnY8ac8jfDV7jkiS5r8HMWqHxt4GFvjIh6DhpUQiRHzm8qZASRr5m0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547973; c=relaxed/simple;
	bh=p4oetpivSU8TFesMmt4mcTKkF0YdHmWk0xP0DolE32c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mzCAAkHsYY8+vzRMp4Q3l/FnXvnnwpL+Z6TTnHD/Jhv7D4YbyDC3pA7Tbgx1RjmEFqnmrIU6fe2Kzt9SMIuV/nyU8F+LLvXy78XO6LTXCYxpX2VP2B8J+nXY3A2ZYd5gecLlnQq51RsaAxXaDHEs/SFOMjnngCudfqDK7PP9Wqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P72qoOLm; arc=fail smtp.client-ip=52.101.72.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gw/tsB5QO2o6VfIKiwRvvfNMGzn+x74xcCgpys4UCf12nWqwtXICssWLWpL5WKQZXmJtU4tgxh2BjITAm7ci0I/gjrL/4+9lFw7dpVt4pgOaJ56Qof+zmcUtnIHnES9CRFS+c1UGAE0tW57ct7ciTJ4kjh2SsdmxmvETQ7BQZHLHXSbCnF9TNdGhHJo3ppoiiMtx9Qip7kG00cGo365R8cqtrSeX0ZDI6ikNptVRlMVdTwkuDk1ehdI/O4sDUhzXYsZOrXnxPaedyMO464r+td1jBhjqbmeXivFiV1q3gkA/0kSgeBiQtoBmorxW+YNiDE0IhridvL9P00ckkeSD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apK7UX6l79lzN72AArU17HmOQf6f3iXw7HUYyag3hAI=;
 b=stlIpANrawU7ymJJlz9SMKuhhHS/U3eORJ7P4wBqGHnLoQJMwLdbNUI7+eB0sTVeomP2NChMPBPpInjKIz6dwukumofd5UYwllji+U2lHBJ5RaWtS7OGCfF3oriQGrzY8JLPHlsXGOjHQ/LQzz1KJUC0dSxvIU/SZStOv/Hlaquo96MbfExq21WvU8+n+6xKjrWoPGtR3dOo3IHBNv27HI93AvN+k6Hygq4TmFSsQK77ZPqm4pup67xT3cyYUeE8o0ai7drjzE3Vy0VWqNPDm0Fc3HfD0VSC7Bb8LRbIXfh38g9lhLbphO88XmG6ym14C7HuaqcYpb1aaGq66JmoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apK7UX6l79lzN72AArU17HmOQf6f3iXw7HUYyag3hAI=;
 b=P72qoOLmCVw0VtmxwrBQSEEN9cfXrNH4pmpN2o+G+Kl2kiHMjSRESlCaDGesZ3FnamK+RXDgCZJqsYqNjsjuf8kS1f1ECJK4y2XpDqJWczzQ/KTG7GXlqNIpKtjYKxnG1GH6JuXODr8btCfF4dzzN9V/Gakseu2nwQ5N49GnunmoGCrOabVASCJofz+G0sYVx05fCUHGwoq6eoar932gPhgrvcIVdjbcpsX6aPSv7NUotqlpfDwyftSOLYI3eHyneKIUGmJ/aV/zNWC4DvohMLtHknITu+oQ+HbGACq/HJ0Ry9JAASKJsq4M2ChC5Guz+5LAOM/DpTpmIQj4Z3OS4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7916.eurprd04.prod.outlook.com (2603:10a6:10:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:19:28 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:19:28 +0000
Date: Thu, 30 Apr 2026 14:19:24 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Alexander Dahl <ada@thorsis.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Message-ID: <20260430111924.nvwohy4nexzyiyyl@skbuf>
References: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
 <20260409-imx8dxl-sr-som-v2-3-83ff20629ba0@solid-run.com>
 <8efbafe3-0a8a-4005-960c-e8fe62cee719@lunn.ch>
 <bd2e73c5-2e61-4ea1-ab3b-42a6573b31f8@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd2e73c5-2e61-4ea1-ab3b-42a6573b31f8@solid-run.com>
X-ClientProxiedBy: WA2P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::29) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e8f276-640c-451e-2f27-08dea6aa57f0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|19092799006|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 u+GuFMzHkjJm30/AdCLKlTQOb+05N/BibDUcGd5sIoS9M+yubZnetZzBQVGAON4nA7WVxS8UAB4zLOZXXXTubZ5RLdOkELWh5y88zlJ/snP+frNbmD28eFfKWH62r+FWRCNfW/eYGpzES6b8A8FX9XhRooiM9WFwiJWJLeAGVzd0go4sYCmG7Z1Kfw5TKaZwBpzlPXHTIcClX1MN5JCYZIMaVI5P3q28hUowLz3i8vCF4NO2FDQQvfOBwIVIJjWshIPwPK3burXV1MAT4ufn4LBgu+P3nO8k5tmKJPg7acLsw1LbXekRrKHZDP+aXngUynCh1tekNQrZZgoV8x/fhjjGNurYU3obg5W1IIS/HSWmk55byGLTKX29yNz63nLQuAq1u+H7p8D2XK5OT5DdSvEXa7QsHGaUD9jr/cwmvxoI7L40M7UP1j7ess2E1XJL9SAcQ25aGqUaofdd/E6NQJkTlRr6GJ/01qwsptPhcvvaA04Ht9oXGI5LrDa07ILj2R6hlnF1Jwrp2Ny0CUYJTjPtI3akmDq/2p0DazujpVjICmldYDxTXuzSa8QGLmLpdqSrFbUNG7bwl29iN0zhSSHObrLQT1dQEjMhpQR2UcJvMMGsv8jPNxPdRuCW+O8EHqKrk648u6TDT9ukCphaF/qZ6iFfvw+RIv8ltNVfOaxDKM0eehhE0KBMVh9VODJYywCQ3DOuR4kRT80BKPbSVmA38umoKe/1AU/w9OTc4Yg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?URAK47KHRKeQehpdKvuLDTtXrEjb8JcbxJITNvGKMJuqe+190R1MUyI5H8no?=
 =?us-ascii?Q?89suzVd8fPDHkRvMOQZESBn/EQu0y7VrXkpYDgJRI2RXqGW74GxIuB1S9KAX?=
 =?us-ascii?Q?d2qS+OBXf9paInqIH3if5MhspfhxdnN6UvrhenWaPsBcNeD2MaeuWuq5U2VZ?=
 =?us-ascii?Q?IqAl+jl0PqPLuBiH1tOakrGOkeK9UxwI4sYRb2wBfaSZqpN7p16U17THLnpi?=
 =?us-ascii?Q?VLuV3CvUv9ALuHdpdAV+cwXIb3btecna5EjwDKOaVqSwqxmDwGQNoixpxSD1?=
 =?us-ascii?Q?k/c6vs6/kxsmHH26b+Bpp4f+4aphRTKHCGWLjvqXvbR3lT9SqQpaHxJOcyU0?=
 =?us-ascii?Q?4eBSmwoeQnqr7ylyzKqTpnHS6e7VJTmNT4+rS6/5pBGIvOnC+o8ln86c6E2a?=
 =?us-ascii?Q?0xYYzwjq71P2XmM/X+DI93nKR77VEO0JlV3mxWQ5aFRpqT+rIr8NJAW6QJUd?=
 =?us-ascii?Q?oaBFAYNR2W1O9XamTzGJ1fInB2YedWODjZkAMg6LyaN0+QtM9S1a3mgCWa0A?=
 =?us-ascii?Q?oeNr2R5FnKFJWz8F6lpJAGSDSM7SFS1Nj3v5MwLa1Cj7vR5VoTGiNYl11JWx?=
 =?us-ascii?Q?EWNg1MeiuYKUjBds0rpK3BBT9vQeL9wiKEsP7THHGPRrjVyBwzvrQzdtVTWQ?=
 =?us-ascii?Q?RrrJ9KDcZarDZ6XM3Th7m4hl1p+pWIkEb8yksdKGDVjSmHZoGQCHgZxD0Zy9?=
 =?us-ascii?Q?Fv+R1IRcr4Jxj1hqLoUhW4VSKljr/0sez6KEHWgm4slh6gzitm8QHF6atFp7?=
 =?us-ascii?Q?oej8ynHwHF2O5YVp2stRR4FlgNuEshdinpxv3PfTBIOO7FmvaI7heMrfNN8C?=
 =?us-ascii?Q?7fdju0/equRoCbuZih+0Fm4aIiWIynkNFNQj1iKkrp5LbNeew09tlAWcmFv2?=
 =?us-ascii?Q?V9dKKFUZpuEukhnEBQJAQNh5yqOdJy5ffVhbt91b8rOuQ6PuobmNioaKGmvN?=
 =?us-ascii?Q?SB7GGIzP/HMuNS+84QXv5N+McRzkq18ovBsv4vDod7SBUGZ//B/1K2LtGKx5?=
 =?us-ascii?Q?S2rovOIlEa0QdRzmrlYk/hI6Evcboou5FyzHOd0FwUsX5VvcU0f4tO+IaToL?=
 =?us-ascii?Q?mEj1+PW8vSL9FfbwWvmmML1o7TDfaLi+Cg7V4dbagOq972pYRO4LlyceEelx?=
 =?us-ascii?Q?VwmYliqzAebd0kW+h7Ji8y1nj4cLL/hsEqVQABUxmskXtW+3+UUy6EPRcFN2?=
 =?us-ascii?Q?2JsBGgngTFsBjsKYNDbhyJnN+HKgnnm1Za8tykk5tfsI5UzIkykUiJ2+KUNB?=
 =?us-ascii?Q?GT2SLGJ4CmlsO8+/cPIPtMP3+VJoFNrtuVA57l0t8k1NWYsTP0XUzVa+y6+G?=
 =?us-ascii?Q?RbhQoagSMpMPBOWLWJUevTsClVOlUmzXNEldT5AZpUA+uR5JvwoMrxHJXQR1?=
 =?us-ascii?Q?NCuKqY46RRziTEvvw03N0sxTZMLwfk7R8fzK9/nxJfZCNRmamEPmSYccveFO?=
 =?us-ascii?Q?3kgA9n21XkymfIAXxZ7/Dk64XpFpSTLehPjR89Mjw2VzZpjA6kJCJ0syvFMM?=
 =?us-ascii?Q?3w3jtU9F8TI1qUdGTaq8ux+9WereUPuu6Pve0edli9gIDdVKHRiZ9ulSImr7?=
 =?us-ascii?Q?Aj2Pjd81eh39crgnYP37GKJbm0+Iwn6i1sOFyT4sJ1PFR1o4Si5IlJU/o1jm?=
 =?us-ascii?Q?B63PY2IXchoxLcku9BaiH1Zin8DDZzh30uAe2X8Vj9xcH2QkJK0uxXskVSro?=
 =?us-ascii?Q?i65wnatksJGS8Ii2unVjI4Zwf04k/2km9dpiQAZtegjD/ru5UWPYbI7w3Z7P?=
 =?us-ascii?Q?coMzSKXgeoa0JUy9Lq5Qac46Z/BIBf7B+pQc3U2NA92aPmup+sBm/rUMfIYa?=
X-MS-Exchange-AntiSpam-MessageData-1: xTxXjSkYnivSPolO+GZ2+4/DpPgCJJS3kss=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e8f276-640c-451e-2f27-08dea6aa57f0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:19:28.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGzIubVC0qg5L2YRi4NRBNYXS+490ATa4bU2MDsobnXIt0PdEYfmrzIleb+xUXJ/fOHjfuhkcJyAQJubpxj5Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7916
X-Rspamd-Queue-Id: 8CE1E4A2474
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282802-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[25];
	R_DKIM_ALLOW(0.00)[nxp.com:s=selector1];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,nxp.com,pengutronix.de,gmail.com,davemloft.net,google.com,redhat.com,solid-run.com,thorsis.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	NEURAL_HAM(-0.00)[-0.903];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Spam: Yes

On Thu, Apr 30, 2026 at 11:17:36AM +0000, Josua Mayer wrote:
> Am 09.04.26 um 14:46 schrieb Andrew Lunn:
> >> +&eqos {
> >> +	/* delays are added by connected ethernet-switch cpu port */
> >> +	phy-mode = "rgmii";
> >> +	pinctrl-0 = <&eqos_pins>;
> >> +	pinctrl-names = "default";
> >> +	status = "okay";
> >> +
> >> +	fixed-link {
> >> +		full-duplex;
> >> +		speed = <1000>;
> >> +	};
> >> +};
> >
> >> +	ethernet-switch@0 {
> >> +		compatible = "nxp,sja1110a";
> >> +		reg = <0>;
> >> +		reset-gpios = <&lsio_gpio4 3 GPIO_ACTIVE_LOW>;
> >> +		spi-max-frequency = <4000000>;
> >> +
> >> +		ethernet-ports {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <0>;
> >> +
> >> +			/* 100Base-TX on connector J26 */
> >> +			port@1 {
> >> +				reg = <0x1>;
> >> +				label = "lan1";
> >> +				phy-handle = <&switch_port1_base_tx_phy>;
> >> +				phy-mode = "internal";
> >> +				status = "okay";
> dropping unnecessary status okay for v3
> >> +			};
> >> +
> >> +			/* CPU */
> >> +			port@2 {
> >> +				reg = <0x2>;
> >> +				ethernet = <&eqos>;
> >> +				label = "cpu";

Please drop unused label = "cpu". Also, can you use udev for user
interface naming?

> >> +				phy-mode = "rgmii-id";
> >> +				rx-internal-delay-ps = <2000>;
> >> +				tx-internal-delay-ps = <2000>;
> >> +				status = "okay";
> dropping unnecessary status okay for v3
> >> +
> >> +				fixed-link {
> >> +					full-duplex;
> >> +					speed = <1000>;
> >> +				};
> >> +			};
> >> +
> >> +			/* sgmii on addon board connector J21 */
> >> +			port@3 {
> >> +				reg = <0x3>;
> >> +				label = "lan3";
> >> +				status = "disabled";
> >> +			};
> >> +
> >> +			/* sgmii on addon board connector J21 */
> >> +			port@4 {
> >> +				reg = <0x4>;
> >> +				label = "lan4";
> >> +				status = "disabled";
> >> +			};
> >> +
> >> +			/* 100base-t1 on addon board connector J21 */
> >> +			port@5 {
> >> +				reg = <0x5>;
> >> +				label = "trx1";
> >> +				phy-handle = <&switch_port5_base_t1_phy>;
> >> +				phy-mode = "internal";
> >> +				status = "disabled";
> >> +			};
> >> +
> >> +			/* 100base-t1 on addon board connector J21 */
> >> +			port@6 {
> >> +				reg = <0x6>;
> >> +				label = "trx2";
> >> +				phy-handle = <&switch_port6_base_t1_phy>;
> >> +				phy-mode = "internal";
> >> +				status = "disabled";
> >> +			};
> >> +
> >> +			/* 100base-t1 on addon board connector J21 */
> >> +			port@7 {
> >> +				reg = <0x7>;
> >> +				label = "trx3";
> >> +				phy-handle = <&switch_port7_base_t1_phy>;
> >> +				phy-mode = "internal";
> >> +				status = "disabled";
> >> +			};
> >> +
> >> +			/* 100base-t1 on addon board connector J21 */
> >> +			port@8 {
> >> +				reg = <0x8>;
> >> +				label = "trx4";
> >> +				phy-handle = <&switch_port8_base_t1_phy>;
> >> +				phy-mode = "internal";
> >> +				status = "disabled";
> >> +			};
> >> +
> >> +			/* 100base-t1 on addon board connector J21 */
> >> +			port@9 {
> >> +				reg = <0x9>;
> >> +				label = "trx5";
> >> +				phy-handle = <&switch_port9_base_t1_phy>;
> >> +				phy-mode = "internal";
> >> +				status = "disabled";
> >> +			};
> >> +
> >> +			/* 100Base-T1 on connector J26 */
> >> +			port@a {
> >> +				reg = <0xa>;
> >> +				label = "trx6";
> >> +				phy-handle = <&switch_port10_base_t1_phy>;
> >> +				phy-mode = "internal";
> >> +				status = "okay";
> dropping unnecessary status okay for v3
> >> +			};
> >> +		};
> >> +
> >> +		mdios {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <0>;
> >> +
> >> +			mdio@0 {
> >> +				compatible = "nxp,sja1110-base-t1-mdio";
> >> +				reg = <0>;
> >> +				#address-cells = <1>;
> >> +				#size-cells = <0>;
> >> +
> >> +				/* 100base-t1 on addon board connector J21 */
> >> +				switch_port5_base_t1_phy: ethernet-phy@1 {
> >> +					compatible = "ethernet-phy-ieee802.3-c45";
> >> +					reg = <0x1>;
> >> +					status = "disabled";
> >> +				};
> >> +
> >> +				/* 100base-t1 on addon board connector J21 */
> >> +				switch_port6_base_t1_phy: ethernet-phy@2 {
> >> +					compatible = "ethernet-phy-ieee802.3-c45";
> >> +					reg = <0x2>;
> >> +					status = "disabled";
> >> +				};
> >> +
> >> +				/* 100base-t1 on addon board connector J21 */
> >> +				switch_port7_base_t1_phy: ethernet-phy@3 {
> >> +					compatible = "ethernet-phy-ieee802.3-c45";
> >> +					reg = <0x3>;
> >> +					status = "disabled";
> >> +				};
> >> +
> >> +				/* 100base-t1 on addon board connector J21 */
> >> +				switch_port8_base_t1_phy: ethernet-phy@4 {
> >> +					compatible = "ethernet-phy-ieee802.3-c45";
> >> +					reg = <0x4>;
> >> +					status = "disabled";
> >> +				};
> >> +
> >> +				/* 100base-t1 on addon board connector J21 */
> >> +				switch_port9_base_t1_phy: ethernet-phy@5 {
> >> +					compatible = "ethernet-phy-ieee802.3-c45";
> >> +					reg = <0x5>;
> >> +					status = "disabled";
> >> +				};
> >> +
> >> +				/* 100Base-T1 on connector J26 */
> >> +				switch_port10_base_t1_phy: ethernet-phy@6 {
> >> +					compatible = "ethernet-phy-ieee802.3-c45";
> >> +					reg = <0x6>;
> >> +				};
> >> +			};
> >> +
> >> +			mdio@1 {
> >> +				compatible = "nxp,sja1110-base-tx-mdio";
> >> +				reg = <1>;
> >> +				#address-cells = <1>;
> >> +				#size-cells = <0>;
> >> +
> >> +				/* 100Base-TX on connector J26 */
> >> +				switch_port1_base_tx_phy: ethernet-phy@1 {
> >> +					reg = <0x1>;
> >> +				};
> >> +			};
> > For these nodes only:
> >
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >
> >     Andrew
> 
> Thanks!
> 
> I don't know how to keep this partial review for v3, so I will send it without.


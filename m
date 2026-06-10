Return-Path: <netdev+bounces-297575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id btw+Jb81KWqOSQMAu9opvQ
	(envelope-from <netdev+bounces-297575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:00:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CB3668116
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:00:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=RDBdBeRQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297575-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297575-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CCF83094312
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FDB3E274C;
	Wed, 10 Jun 2026 09:46:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD03E1D19;
	Wed, 10 Jun 2026 09:46:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084813; cv=fail; b=HfMhLrZWCfnv1W3Gf1RKE1WQPRz61wmDIomq9Xs1QnOauusYmzpBn01bLLAuE37LkiV/fGj7OefxyY/XjOIUmfbanUT2L2Ey2v8XrK7ABauXlvXjMLJzCk50nc9pd0Y5hOi/M1vcpQqY9PbEgg6WiX2RXkqPwDHcPMimd8Qinsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084813; c=relaxed/simple;
	bh=WUQ6ObN9t055yqNj1Rcsly4+BFYRaHp9PxuRm/D0JbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DCVqt5q+9YEeRe19sF6FWJeKtJNVZ+3tDtDMPGv544lV5JpOfucOxFHh98x+Y1hPt9AMZj/D2nZnPcK3JVt3hITpOWjCgp/obsQBinYQua7kWd+Xj6RwpqadpcpWQBfKcLPPxNeb9BTVp57tntilGoPptyG6yWzQq83tJClLMHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RDBdBeRQ; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ns2Rz3b7oK7st8RZvY2OGrIX6M4oFT1pB/kCb3GoqBPf1TEJhoVJXa6joU2CX2ayMQm/bryuxAf1y6QfYnnXHM5aM+yuHu/PUhe9m0CPbNb0HelVPuMD/KraUjbfbxNzC1QYWqKjMLM6wpt7satC/JoghzaHvv62N1EuFVlTYksyKy0Gu/PeHq9iLD65MRrxybQQJQ2otUXqL2RpTDQDCFJrR3UbNspjwtiaYBJhgh28faGkgpQ8iietaGezoAySmNPAoRbAY9RpH4hxOHkoEeFiUDWhZEoAaUK29QgoSGYXbn/jgwI0g5f3Ik2UyuzDTtKh6mSxHzcbVqvsiPgPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag74uVJAc18XCws6ZoE0hwdO5TOdMOm1Ss9NaDrOUCI=;
 b=OP5oF34ORfigHG0azZGTwfSCOq+Q26w1xjLcTYU74Sj4hFZh2kkI3309k2GouJXVRmAZ2PbYfSExsig/1PhBLXl63/POE16ZP5GhCWgwgNvmyqL2GmHbFNKKXcoTx9DcZRhuQRZrOtPtakTY98+gDsOBZ49lm77hbOpH57uxS43AiqzfU8yhdWAzkuEHZ+zz17MhP+Smso5lx7lXO+iDhyYxWf1hfwTeh3AYjQQYsFcnKtPTRbgkpY1DhV/hYjtaPv3pFykq5GRyyNHOk4VvexeSoxydNfs7m+L7hhG+owOVAqqh2T5nb6BnEE/9Zy+S12DQQo0fBb5DTjGKeUEn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag74uVJAc18XCws6ZoE0hwdO5TOdMOm1Ss9NaDrOUCI=;
 b=RDBdBeRQ8+UzHcJ8Pa3iiGdf21EUJqto8wckL1hS/m9CYM/Iyg+M1xMjM9CMelxeE3qW+2HyeQ+sRGWy0RBiHd8iGK6YK5Dmg+b9zDB0cdE6LqfkN1/wRLB6SoC3eY+bhS2VHxuAb/uQW1H/ZMNJgVltKTZcACSz3aZfhdtpHXcvub60Th+LbbvdYO6sAB/RNZAc9Hq79gWrU3kN0qjUSQMp3gI5U5n2fbdcyIuS5zNX+c9hy04vSMrBZuBxQABPhAzkw0lIogcEpxhpE+7GrzW8J02cnwqYxl0umsiqS+tEprNQ9PzAhIPxlqTIC+UTYuGLuUF6WXvhnJmeMNnRCg==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:46:47 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:46:47 +0000
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
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 08/15] net: enetc: move mac_filter from struct enetc_pf to struct enetc_si
Date: Wed, 10 Jun 2026 17:18:37 +0800
Message-Id: <20260610091844.3423693-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 646baafb-14e8-473c-a116-08dec6d53065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	jXtat+bW/xAaA9aNlPac/0a2txSDzHCnH9YUlsU8LmTH4FtqN9oyeCCKhh6y+hwQTwVMG2mFh+Rq/IhedpbLsqX25ntDrl4UG/xlUZ4IrCi2Mf674JEXgvGgbrUwR9DxvtOkJpjrpC7ndUp+DhOB5zmzh/GVevDDC7dVuqpyd5pa/VjDzhwL0Mm/Q2V4YPJuWIvsUGWNakMdu1WB30YaWydKJWPtNUHLzj1/fSs/QkbG6VprqeZgGyHgcxsCL1OHQPn/w+wIt2BF8kMwk24L4GkLNU9oFH8NKOMS527nFS4Z29k9zqjhA2Kdab9VGtnnw2fBNx0hP6hjvY7QySTz66l3bzNY9diVzCKhzKF7vMNisxr/bWJbwLxf6fnfzK6urAsD/pruMPHFpSg13I68AH+yVZ2DqJbQtB25l1LhQ+/GZ9FFTJumwUOPTY2shymybLG8T37EFCw/S28CT61uizxDt8IBFIpILX5Q3NT/o0E/JAnYNLzJakFAg8w9CMuLdnt0BLX8kddAcjBSiFJjl5x6XLYodcPGxjWnEtfsUsThXvlObGU/UMIvmoIUC/wuozJaQIOsfeo9lk7XSioShyBcUYSHE3F7zK0+XUlQcE2yXB5IsRBxqd9uqO0pRO5nwctE/VbJ8Rgqwt97OfCPCCStC+4VCYnLPFHmWB88FDLk630Z7Ii60VHcLzozTwPOiGwnwGaFOSUkICkB7jap64H//MdADhEB5C9QTzORomM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AtfSxfL6MLg5QdWHyUWnMdoMurqBJRhrsGV8AQq+e1jxvtM8iW/Ia9GOwvnw?=
 =?us-ascii?Q?GCweR1Pw7sA2hTuPgHI10EwKPH7+OEt9Pecu6rK3QVBAWNcWo4lSpGGJBJTV?=
 =?us-ascii?Q?DoeDDgjXJ/HHqhwUA6dZa66ouYHG7n6jKxFb2nN0ngWyeX+vOQQYTTRz636l?=
 =?us-ascii?Q?NWJVeLCUQy15XeOYKxSpC7AHT0Ba6DLyVPmkWBI4BAe7nw61V0QhupDBJ8Q7?=
 =?us-ascii?Q?eraFRBfI7Bbt6dHSOc04jPSxtGxSqDQPHfqD0dJmivJN1xyv2duGHOTc0t6B?=
 =?us-ascii?Q?GL3nwLv1vNM0Ow4AbYxJc2fCuIYKDgnyIp2hS+u5wlqsMkr2/vRFVd6F/7T7?=
 =?us-ascii?Q?W/0B6mhtEybD1zmIf8HROwat6qlCSnVbb12xZDE54SyuzQcroX4PXD3B+OoK?=
 =?us-ascii?Q?kSXyTjymvMB+vnICJDY2azHf565lSBEjFINjhaoHzZt/9ajdPUC8Qvv0/l39?=
 =?us-ascii?Q?IaVGrrUqOefKPVIf+3/ZztiBU4s7LwnZfLSjUQKKxfqdX8h/UPuLdS7fLGpr?=
 =?us-ascii?Q?BhotX0lsH5ifjwgvB1KA0Eo29rEQ8OmiWBYOC13IYZ1zlMWwjkAbK43okjGf?=
 =?us-ascii?Q?yFGXWk0xa+I4Ps6okBMTNCxxgjR0NO73IkOjaokf6L6wm5DICbbEfF0gQBUE?=
 =?us-ascii?Q?yH8D1IgZCDsAJaxkB3cRE0TSDE9Wi784oaWVc0Y9DfFdBt/4Ds4OBBaJ6rPL?=
 =?us-ascii?Q?zNmu8tNtrgJDRtc2ptD+pmBoqtWnWtknqRkTG3d23zKf4a1M7cC9SDDtQCA/?=
 =?us-ascii?Q?8YB6jvviSl2aHiguhMSO1WBasb5ouy78+zPKCqZmnEQCcZEW2GsZa/FvWX5Q?=
 =?us-ascii?Q?IqfStmmSzWTLK0JrKWLXk7WYF0zeJ++wBQ2Q/ccsJdOjVWV1ixZ1NRcxWXkw?=
 =?us-ascii?Q?JznGvBS35qqIc81uhiPCeOvYADLxT7hW0DDbf+JK2uuETUsI27wZJY1cZqQ/?=
 =?us-ascii?Q?F2tiExrCQdIKO/cwuH2At5x3rQWCov2rNC+0caLDTaFhucmreC1mVBFU/zeS?=
 =?us-ascii?Q?+DESRXg2+z/L6avK2hdOlCyjY2Oyd+p2zDVded0JNCGFaMawqAUxUdPwlmJg?=
 =?us-ascii?Q?ahCYrV4ExpLAnwwJJwwXcnKE+5VAe3tpQfIvtF1JRWahHr5PYLlQM0xXwkky?=
 =?us-ascii?Q?qa7gl/LInlptB9PNVMQLiR9JN6YXqf72/JVcYDzMkXoR2zZZ8vwoo0O9NrSn?=
 =?us-ascii?Q?n3KPRKHAmEIwtCjWc9hanjIx+WXVrSaa107cit4wRLAuaym29OS88qsr+WCy?=
 =?us-ascii?Q?sqg9JLoZAjUQeZvxFBwXHUBSCipl6IfuPu4Z/R9bBKSD63MAditJzT2mYVhD?=
 =?us-ascii?Q?lUcHfdXIleulf0zCa/HnPE25PaO6DXICX6qdENyIFJ3TlMB24DAvgi2tzhOT?=
 =?us-ascii?Q?zfp4MbJrG1b+AnbXYwiCqnAMaHI+LTHLBjDPiBJKo0Zk4TmfP+go8Q1upszS?=
 =?us-ascii?Q?PexVymhLlbVeW6e/WUXKvlgSwXBmWU78kyqgyH1x8srcEJH1qP23P+icuVEP?=
 =?us-ascii?Q?03XZWfLWnmmy2W2ygILQ02AecplfUt7n7Pi0cM9kQVTSHHC6FuY2wb8hvqTE?=
 =?us-ascii?Q?5DYA3ql2tDg3zUPD7Cz0sD0dy1T9THAC/gOI6redJiMk5CnvHLLGxOdryctW?=
 =?us-ascii?Q?drUkSol/UPoLhmKjTZ37ylDAqxT1zMW9HH6g6QrXozCfhSvq/CQfXfgm3Tuo?=
 =?us-ascii?Q?pXwiq0OMtZFX8dqovQPQBM9uLKaqE21ZrlPd3hbx6D7XllDfKxJHQkc+g9ZT?=
 =?us-ascii?Q?Z61eXAkXfvZkfBb6gbEnEUX2kCkbirW0DNe1khQhbgtplS1uI5an?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646baafb-14e8-473c-a116-08dec6d53065
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:46:47.7271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ow8IL4jYwpEWZYVjdZ3CgItNt7oDrI3vGZhCcSOdgYXJJdotWa6vNWZl7kZ64Ix/+Cubn6JWX9z/ZOHFmTPVZlCgT/FwPevXRmRccqQPMqy/THfhypIz23JQhB+OV4Yf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297575-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42CB3668116

From: Wei Fang <wei.fang@nxp.com>

The mac_filter array currently resides in struct enetc_pf and is used to
track unicast and multicast MAC address filters for the PF. Since struct
enetc_si is the common structure shared between the PF and VF drivers,
move mac_filter into struct enetc_si to prepare for MAC filter support
in the VF driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h     |  1 +
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c |  5 +++--
 drivers/net/ethernet/freescale/enetc/enetc_pf.c  | 15 +++++++--------
 drivers/net/ethernet/freescale/enetc/enetc_pf.h  |  2 --
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 2cd035773aca..24d9f89aee73 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -332,6 +332,7 @@ struct enetc_si {
 
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
+	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 };
 
 #define ENETC_SI_ALIGN	32
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index d310506a6fd4..77043fa01782 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -225,11 +225,12 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 	struct net_device *ndev = pf->si->ndev;
 	struct enetc_mac_filter *mac_filter;
 	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
 
 	netif_addr_lock_bh(ndev);
 	if (type & ENETC_MAC_FILTER_TYPE_UC) {
-		mac_filter = &pf->mac_filter[UC];
+		mac_filter = &si->mac_filter[UC];
 		enetc_reset_mac_addr_filter(mac_filter);
 		netdev_for_each_uc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
@@ -239,7 +240,7 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC) {
-		mac_filter = &pf->mac_filter[MC];
+		mac_filter = &si->mac_filter[MC];
 		enetc_reset_mac_addr_filter(mac_filter);
 		netdev_for_each_mc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 38fcc7b5fc6d..209a3503609f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -111,10 +111,9 @@ static void enetc_set_mac_ht_flt(struct enetc_si *si, int si_idx, int type,
 	}
 }
 
-static void enetc_sync_mac_filters(struct enetc_pf *pf)
+static void enetc_sync_mac_filters(struct enetc_si *si)
 {
-	struct enetc_mac_filter *f = pf->mac_filter;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *f = si->mac_filter;
 	int i, pos;
 
 	pos = EMETC_MAC_ADDR_FILT_RES;
@@ -158,10 +157,10 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 static void enetc_pf_set_rx_mode(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct enetc_hw *hw = &priv->si->hw;
 	bool uprom = false, mprom = false;
 	struct enetc_mac_filter *filter;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
 	struct netdev_hw_addr *ha;
 	u32 psipmr = 0;
 	bool em;
@@ -180,7 +179,7 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 	/* first 2 filter entries belong to PF */
 	if (!uprom) {
 		/* Update unicast filters */
-		filter = &pf->mac_filter[UC];
+		filter = &si->mac_filter[UC];
 		enetc_reset_mac_addr_filter(filter);
 
 		em = (netdev_uc_count(ndev) == 1);
@@ -196,7 +195,7 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 
 	if (!mprom) {
 		/* Update multicast filters */
-		filter = &pf->mac_filter[MC];
+		filter = &si->mac_filter[MC];
 		enetc_reset_mac_addr_filter(filter);
 
 		netdev_for_each_mc_addr(ha, ndev) {
@@ -209,7 +208,7 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 
 	if (!uprom || !mprom)
 		/* update PF entries */
-		enetc_sync_mac_filters(pf);
+		enetc_sync_mac_filters(si);
 
 	psipmr |= enetc_port_rd(hw, ENETC_PSIPMR) &
 		  ~(ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0));
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index a5c13a4cc197..22b98e89e393 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -41,8 +41,6 @@ struct enetc_pf {
 	int num_vfs; /* number of active VFs, after sriov_init */
 	int total_vfs; /* max number of VFs, set for PF at probe */
 	struct enetc_vf_state *vf_state;
-
-	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 	struct enetc_msg_swbd *rxmsg;
 
 	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
-- 
2.34.1



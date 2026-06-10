Return-Path: <netdev+bounces-297580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AEPoJcU1KWqRSQMAu9opvQ
	(envelope-from <netdev+bounces-297580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:00:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D41B66811B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:00:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=scTlc0n0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297580-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297580-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC8F332D63DD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0603E3EDAA2;
	Wed, 10 Jun 2026 09:47:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F263ED3CD;
	Wed, 10 Jun 2026 09:47:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084836; cv=fail; b=psj2COdNaWo5ljeZci9b9iSVIHNoDIanS3F2MYSeid+7YM7ZJIXfWYcWv7FDqxVbp6i9DgBYj1irqoJxaSUESg5i1UqjlTih8kZl2QqEIi3F5sta2AzjMrkWIJ4rnc6SJqrampsZ9+VzUiHK8Ufez0nRLhhUEskTj8qOx+/fjYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084836; c=relaxed/simple;
	bh=1V/Ebx6121Z024iPy0kF3WWVxgDPa//q4J2p6TVThkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yx8g8qVbF/epy624pzNwOck6fzVCW0rjcLXBTglOoDShX8UDC3er7waEFrFOaJ8z3w8tP6HWyl/iInEOsNJV2B0XYJ3U5ceTyyrXXguEn6f0Ktidhiy4HtM7rKXApxU0nAPZHJ+jllMEVeII76/2UiYyqn+/Q2T9cZflR8SWuDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=scTlc0n0; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rd9aH9+Sy9ONKipexzEZKmUV85ttXBigCrjgav+PvlRShLBg5FSMp05SMR0XPfpADO4464UUp5jQB/XNVimimQ2Tz1ZvyTM5xhLbCMgbKVjMlhpUPaCPEyt45zv1aAyViZuvSvhE/vGzjkddfOKOpEO8Jt/IMJ3m8P5D+0BjMYlj++7Z6801udSjYSkLzB+advnhsQWoNH16gvtA6lEbk9H/K/pwQVknTajhAjRneXIFyq/bpLbBgK10Za7Fu5PCgIj7u3FMUH+nkUN6oKgKRsCQFgOUG6DvVV6mxccmkz9Rqke0Ukp91HkOn3Bs3XUYUltnPVAr0NZBBePlJmn0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBc/zctHqIXEQTIyoYdDcSm03+fqMqj7w9xQEKszck8=;
 b=PwOe2b5PnstNNPjKJfRkZUmXgJmAciqvqlFpFgIL4ITrlqVCGhlSbfQxD3PsSp6waVyu1sLNhsh493xMWBeuzAGAPgQqKeAMtT5Kqm8kqztnfI2QgfZCemhwJdEme/lmULRukdCEm77BzHIqwR2K1JaMLAM6Iy0xPAESsxsI+ISa09qylNesh9Rmjl2kYQQ9h9zk4sNCY6CeKmtS6ZlMXGZzBQWGn2vgQxqyhXoFqROOYoZ802Kw6VG8ypkJw2dZHhEe/HRyVZT9aTRdjz0goSfCYl26we5t1kqFMrVRYPqtCUIKoRz2u2Uw3fSo0LjAQz/inpieS+3b4QyzfpcaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBc/zctHqIXEQTIyoYdDcSm03+fqMqj7w9xQEKszck8=;
 b=scTlc0n0mmamTlYyLiDIwmgR7NpDbwwJTtfr+WE73aOBy9CvanNQYpcojtOGVKqkm6t9d/8TOxAe4gaaYsAscjzC0MYoSBKhRD0wcXAY+Vta47iukMraH4NnaTugltDZ3dWfHDWExV0OoUuj99/jGKzfdy2mf/ml9oaRsLl3U9zA6loZKZeLtB2PGrhX4qcQmF7EhpUBj8xcP0iqPtUHvcA1s0/suMgALxF8hat0I/ksZ9ZV5ilqsyWu2NjQ66QL1rO2eTX/AUcyLDpxPz9IXxFHvGY37J6c3uGotHGfwzso3ozMvxnLE/MNtLlOGiS7cSnDYwv/GkDrjUdUwdG0Xw==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by DU4PR04MB12129.eurprd04.prod.outlook.com (2603:10a6:10:643::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:47:10 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:47:10 +0000
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
Subject: [PATCH v2 net-next 12/15] net: enetc: add VF support for i.MX94 and i.MX95
Date: Wed, 10 Jun 2026 17:18:41 +0800
Message-Id: <20260610091844.3423693-13-wei.fang@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|DU4PR04MB12129:EE_
X-MS-Office365-Filtering-Correlation-Id: 072e3878-4099-4742-84df-08dec6d53e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|19092799006|921020|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H5OzjzALxAAwodQS+FqwHNYI1g4WNIQUvvL3+dnaWXI3xM4FssB6P3HRNG0oaqNiqVCGQ/OEU8gPUTdjj1e0ktyWbl8Nx9ObBtMwBcGCY3omnxn3x4RK9r+9GdAjFAj3n4FkJyNoBjuXcG7f9RcGlCtvGjavRolZYYztYUYkrI5fPWLdGwriP2buCHZJC9u4cbD+9c4rpPx2B5KiMWb+Vc8Qgqq0GGiY/muf5zJpmCWjuAJxBhJ4hyjl3ShVExpJ3wGvH7QPQGNjkVTAhj1W72i9IYE6prypogwlAD6H9bxYMBnMyi3RXFfWZ4KlYn6PECtfVinbBLdi+VPpQRI7Pi+nK2UDX5CwhQHwdMQPwL3iik9kL2HYIE2clqqM97G99YzodCyZXYgVKP7Xwu/4UupDeMIbWlJdvh7Wmg8unVtC/vzEYavvjLWsQ6iqWhi9CpFF4mXnXzL6Cqfr41gnSfbrf9ARzANY5x0BA+Prgql86Rp7Cq6co9RlhHa7c2SW35dBnel14jpFj8iNBtmXHtz/ehmY0n4lhlEwyebIYck2ICDUuiuOWRvazS+6OWNMYPmdyUF99lmC9VZi6EqOi+rXrHzPMddgcVZrAndu1JK0ApUCyU+bG4wHI1IutvabCYCvtqueKfCD/GVq5DyTMuc/mztpxo8jy7AenPK3lyeOHw96fR8qQx2DXuOg/wrdzU0DRat7Zi2oV/tDVUcQJxEsTaRaHXits5xm1Dmc57E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(921020)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SiivG6vUNugGoQdkwc3VTLoUvlUnxEJOC+QqvOQIzIJc1fKHLb81LqNAmUvc?=
 =?us-ascii?Q?/D04aIK180FjYd8CGCTfjOeFU0CmWZXsQ5pOuV+G0l23Rc5t5iFO9ozOgjsA?=
 =?us-ascii?Q?9dL9o2y7lanrOsBb9Fb9/VlMpPoDh1vn1pdB2dYJY0kf2lNLA6o6RDi8neSF?=
 =?us-ascii?Q?Uk5MMNbwQ+iO8VSpErC9aOaK6nbCPGG9YcVs2m6hwPqkZNxf+RFgI56hYGMn?=
 =?us-ascii?Q?68Ta03VzPu8EEiRAiFrig9CaP7yoOOLFwkWMA/MNaWBMy6x6VeKdM/TmFjwv?=
 =?us-ascii?Q?70i9Cq7t0FJfZ1/NREq6FnqxNJ4k3MOC92me8qh6ecpDQHPc0DauXr/aDcVQ?=
 =?us-ascii?Q?DtbxNSNJQZHGClWWh1IwU3YkiPMZiTeU0nmyAW9Va6in6+wffEtKI1w9JuwR?=
 =?us-ascii?Q?iuw6fE7WyZjpvOIN8cq23Mo9kbTywKVBd2XlUJuiseGHfRSz0XfUS22b5wOm?=
 =?us-ascii?Q?fB9xbR9ALL6mCSsvZB78OsJr/TwLJxoGhlMBJie/oIAuWUU5SrLTlYYdorQ/?=
 =?us-ascii?Q?Z2lSQXLJqqW7xojAS7qlTMY6fv0/KmXcguKx3i/vOAUW+xhIvKwjv0VjnS9B?=
 =?us-ascii?Q?XA9Xa/CeNDbqbycG+6dN/LNd+l6JESVOYFzwifQN6mGQnTLYC9ceBMAnQ/Pq?=
 =?us-ascii?Q?dnyQLsdkVtM3olsZWo4jT6+GS7qr6t1Cytc84oLCZKbGPtorhs5JpNr4nCnw?=
 =?us-ascii?Q?z89CVw/f3/IAFNEEQNOMhR/M5xHIKaZSgQR3EMR4WUHCVNKmrR+oDKNZDGCf?=
 =?us-ascii?Q?2YaK8DrcNE3CYCh8G7nHZ/HAOY+m29EZLLaIOB48qXGBGO4IfZzOLP0xJ9pt?=
 =?us-ascii?Q?Ygmu/cJpRo1bLuvSVzSBKHYBSFRxWwKDgue8bYlnzBC6wnjrpi5BMC/Fs8S9?=
 =?us-ascii?Q?ARfyp+A4zXuAP+A5rW3BlExLm/oFUwWxKfuyt/DbMTFLvdjBwHpefQeW1uln?=
 =?us-ascii?Q?lfxMJTK0LHkJCfH8da1KZGivzsVDA8zt83xp51kMocntra1G8j7EQrBGoL0K?=
 =?us-ascii?Q?wOx0DBI5rFECBmMICXm77Qy5kE4fHAv8rOaysaLA9jl2XHP5pVD3ZZ0ll589?=
 =?us-ascii?Q?Np/B9SiqnpRMx7insl4YrauShjFHJ2Qi4tRhLwBBpMDq+Ml0/z90lxbDhPav?=
 =?us-ascii?Q?xTbn4CqFcyEOUGkm4Vsk3Eq3VfgSRxkh6Z1HrsmTtOn1h3+UxDEPafmJ2oKe?=
 =?us-ascii?Q?P+kaX/b8rVBsnhKSIDmzo+oElucHpQBNZZtd/MlBKGtErbb8gccNDntduoBt?=
 =?us-ascii?Q?8Y3IBoHWGJlyErj0WaxvPXktrKI5X41W9Wa18qas3hJm+8vmX/qFUXvkbALv?=
 =?us-ascii?Q?Yn2FmACf7twXiXXYK9eyAzKKxCmlM7jsj9HwHrsvtuFwY2z9iKB62c3mIDz7?=
 =?us-ascii?Q?JQdt1tiYelFVLap1HXCd6/GnYRTstqGqt+nA/l39rZ1Igt9KErTgWq4bjDwK?=
 =?us-ascii?Q?1N7Uo4nx9zhs/RqOwK6Qz/rK0wT0/jR67MLiMWPzz8yPNAuNdB4Ak2j+zRtE?=
 =?us-ascii?Q?KnfZGLYRetrqwdSBfelZvHxY9ZpnPpgRQhFT3yWWRXzlIXoLNSIkZgOdEFep?=
 =?us-ascii?Q?AuXvdJqSggj80E1jpQZJM4KhLmARjmkNLwFPRnxyc1jGOKC5Q1P1QONyOJ+k?=
 =?us-ascii?Q?1ctic+pos6ah0AW0jbE2NG1atAjCjo91LhmTOhUGBp4RHR20l1ef3dfa8XuE?=
 =?us-ascii?Q?UH5U705RRHTUaqYP2svCPEBnI5DRYo1yf73s369QJguTcaffC+HphHhXl4qQ?=
 =?us-ascii?Q?xS8O7q84gjj7rQjWiVPzH+HxEzSg3bbI7o526Q3ivz0Xn+DXIxh0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072e3878-4099-4742-84df-08dec6d53e08
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:47:10.5462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzV+iAdsrDU5B9bblU3crArSPardvAG63NWrV6NqAj5HleLv61MNQMDypmhnkRYEiHZF1Ju43rL6THqc+mN0aQEnQcS9QD1OlJjMgW6skPC4vzmss9XS7jc+StzTFVak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12129
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297580-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D41B66811B

From: Wei Fang <wei.fang@nxp.com>

This patch adds VF support for i.MX94 and i.MX95 platforms.  Compared to
the LS1028A ENETC, the VF device ID has been updated to 0xef00.

On i.MX95 (v4.1), each ENETC instance supports 2 VFs.

The i.MX94 (v4.3) has two types of ENETC with different VF capabilities:
 - standalone ENETC (same as i.MX95): does not support VFs
 - internal ENETC connected to the CPU port of NETC switch: supports 3
   VFs

The driver is updated to recognize these SoC-specific VF capabilities
and handle each ENETC instance accordingly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 15 ++++++++++++++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  4 ++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  6 ++++++
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 20 ++++++++++++++++++-
 6 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index db5c17a44613..f425f82a6213 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -69,6 +69,7 @@ config FSL_ENETC_VF
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
+	select NXP_NTMP
 	select PHYLINK
 	select DIMLIB
 	select CRC_ITU_T
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index aa8a87124b10..fdceaf36daa7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3745,6 +3745,13 @@ static const struct enetc_drvdata enetc_vf_data = {
 	.eth_ops = &enetc_vf_ethtool_ops,
 };
 
+static const struct enetc_drvdata enetc4_vf_data = {
+	.sysclk_freq = ENETC_CLK_333M,
+	.tx_csum = true,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
+	.eth_ops = &enetc_vf_ethtool_ops,
+};
+
 static const struct enetc_platform_info enetc_info[] = {
 	{ .revision = ENETC_REV_1_0,
 	  .dev_id = ENETC_DEV_ID_PF,
@@ -3758,6 +3765,10 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = ENETC_DEV_ID_VF,
 	  .data = &enetc_vf_data,
 	},
+	{ .revision = ENETC_REV_4_1,
+	  .dev_id = NXP_ENETC_VF_DEV_ID,
+	  .data = &enetc4_vf_data,
+	},
 	{
 	  .revision = ENETC_REV_4_3,
 	  .dev_id = NXP_ENETC_PPM_DEV_ID,
@@ -3767,6 +3778,10 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = NXP_ENETC_PF_DEV_ID,
 	  .data = &enetc4_pf_data,
 	},
+	{ .revision = ENETC_REV_4_3,
+	  .dev_id = NXP_ENETC_VF_DEV_ID,
+	  .data = &enetc4_vf_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index f18437556a0e..7595c7d80d0d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -12,6 +12,7 @@
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
 #define NXP_ENETC_PPM_DEV_ID		0xe110
+#define NXP_ENETC_VF_DEV_ID		0xef00
 
 /**********************Station interface registers************************/
 /* Station interface LSO segmentation flag mask register 0/1 */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 6f7b4f4927e3..c8059c67119c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -1211,6 +1211,9 @@ static void enetc4_pf_remove(struct pci_dev *pdev)
 	struct enetc_si *si = pci_get_drvdata(pdev);
 	struct enetc_pf *pf = enetc_si_priv(si);
 
+	if (pf->num_vfs)
+		enetc_sriov_configure(pdev, 0);
+
 	enetc_remove_debugfs(si);
 	enetc4_pf_netdev_destroy(si);
 	enetc4_pf_free(pf);
@@ -1228,6 +1231,7 @@ static struct pci_driver enetc4_pf_driver = {
 	.id_table = enetc4_pf_id_table,
 	.probe = enetc4_pf_probe,
 	.remove = enetc4_pf_remove,
+	.sriov_configure = enetc_sriov_configure,
 };
 module_pci_driver(enetc4_pf_driver);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 71f376ef1be1..246852e453a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -859,6 +859,9 @@ static int enetc_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int i, j;
 
+	if (!is_enetc_rev1(priv->si))
+		return -EOPNOTSUPP;
+
 	switch (rxnfc->cmd) {
 	case ETHTOOL_GRXCLSRLCNT:
 		/* total number of entries */
@@ -903,6 +906,9 @@ static int enetc_set_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err;
 
+	if (!is_enetc_rev1(priv->si))
+		return -EOPNOTSUPP;
+
 	switch (rxnfc->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
 		if (rxnfc->fs.location >= priv->si->num_fs_entries)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index e4d0e6c1a2e5..4bc48a5f6869 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -285,6 +285,12 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 		ndev->features |= NETIF_F_RXHASH;
 	}
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
+	if (si->hw_features & ENETC_SI_F_LSO)
+		priv->active_offloads |= ENETC_F_LSO;
+
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
@@ -296,6 +302,13 @@ static const struct enetc_si_ops enetc_vsi_ops = {
 	.teardown_cbdr = enetc_teardown_cbdr,
 };
 
+static const struct enetc_si_ops enetc4_vsi_ops = {
+	.get_rss_table = enetc4_get_rss_table,
+	.set_rss_table = enetc4_set_rss_table,
+	.setup_cbdr = enetc4_setup_cbdr,
+	.teardown_cbdr = enetc4_teardown_cbdr,
+};
+
 static int enetc_vf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -311,7 +324,11 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	si = pci_get_drvdata(pdev);
 	enetc_vf_get_revision(si);
-	si->ops = &enetc_vsi_ops;
+	if (is_enetc_rev1(si))
+		si->ops = &enetc_vsi_ops;
+	else
+		si->ops = &enetc4_vsi_ops;
+
 	err = enetc_get_driver_data(si);
 	if (err) {
 		dev_err_probe(&pdev->dev, err,
@@ -406,6 +423,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_vf_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_VF) },
+	{ PCI_DEVICE(NXP_ENETC_VENDOR_ID, NXP_ENETC_VF_DEV_ID) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_vf_id_table);
-- 
2.34.1



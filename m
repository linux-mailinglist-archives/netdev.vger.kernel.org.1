Return-Path: <netdev+bounces-307335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +IqHIfubVWqtqwAAu9opvQ
	(envelope-from <netdev+bounces-307335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:16:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D801375053C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:16:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=rW9nqRYp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307335-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307335-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A13CA3034576
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2855037B003;
	Tue, 14 Jul 2026 02:13:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB26304972;
	Tue, 14 Jul 2026 02:13:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995208; cv=fail; b=a7M9xKYr8940sahUfpqicoweRPyAg/kxBagJuyif3rQXypr2uV8aaRz6GbplvCnBZDsHBOVP8r2gnuwcCYi1ygVDnF7xJX8Gh2QOpo0bNn89HWyYjdAYXE7qo7ywOQTPpThic2D3a+1bwR25QnZDPbmj/lNvQ9aErNs+EYmhhd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995208; c=relaxed/simple;
	bh=zoATPTFWPgQjr7GfL93bhXxyNZ1BMvhO6C9VH2gL4Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MzIhOWJq9sVsutcQNSrefVnvOxor/gmNYiKJIwOU10HIYNmpXDtTxM7Eni5SNHX7nh3Zwn7dQpKaZBTLeXE14o8kxXCDZh1bvHSxidJkQn8ojxqeSRgUOCTHa5s0miZ64QdFWbFDSwvcrd9+a0bqzLDedPFsUj114KMetSxz0HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=rW9nqRYp; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxvHtz4Jl2Q/7hiXAM4elsjMTDVMwbfJB5FhcFV+i5VgrJgysLRHh+QKE3caAsNbxGbaTrOg76i3gFzgQnGqKX0tr9fShYuUdT+xRzBRJ/2JwrtHMiqp+nXsxsEl4kr6ooBRQurIRqS9xjPU0yJSrXoe7vcy9VMdYTmlq1pm+7FAt1flsPd+fEgiFqA2Aj8pIKFCxYE+VtVP76crHL3CaJqqhqLZzFt5BEH5QT8nHXYBLdVkp8MVtTndq7IcEnwd1fJHVr5cUKs2ensgC0GpPWkXjz/FjxSWpi7pLvHfXOsV8rIjCJVSPESamRGmZ83phXY6jtw+gPhagL8Iwzesaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuJv9ilGHg8QxStt4JeJdMXFPiIFEvvvG5DTMUsz5xk=;
 b=XeuGqM+L5g9FUswE+berIJ0slFwIPSOpsx/AkGtEv719TEhQdf+i9M2Sp295ljsSuJIBXszfcwO6VxFua5Zzzhcj+uTQ10eBUtf7pTQxY+EaQB1CXuJy7bu/79Cj68mS9KRC83mLifham9jb3HnCNhiC7QlDME2L84cwLhmTJcCeTTDZqyrBDlg+yNJsBB3lLVUURHjW2+0yVHsPwQ04DYWBa2dzRGDhma2ZUA6xsEPPuh79B/l8EMPD4Uc4wlsVIF8Z6yRPIpp1XPgxzRKJDhgIH82jWDQJu+7cjv1VbrA91yU77LcAwcoBZAB/yjXUZ4rm5pQOLfkqtVbmdZFxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuJv9ilGHg8QxStt4JeJdMXFPiIFEvvvG5DTMUsz5xk=;
 b=rW9nqRYpWIHw9nSAcQrJPSG/VFn9B145Zuy4/J1hNii60CU4GyHd22rG1C4HwKzH+sijwxMKmXR/LyiUaQE7hREFFCOEV0Uyg2A2+CqPPHSg31OTP9xvyCPBTABZB61Sdyks/fmtO18isISfCZn6kzTHQcsS4deU3oiv7LekEjYDjaM6ngjpR2cNDW3N/4peQ13l4EcjyHO0PUfyA4V+HpyIDwDgmPYyGa4h+P35XG93OQs4Fsc86SUVK6CrVAhqgB8fiZByDYd42ptKd9uSiCdJEWk5qpx8fr/U/YIDTXF05fcV7Gjjf+clR4rjEbRxHVFNvDdnJMFF6mfT+uQzpQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BLAPR03MB5410.namprd03.prod.outlook.com (2603:10b6:208:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 02:13:07 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:13:07 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/4] net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA converter
Date: Mon, 13 Jul 2026 19:13:03 -0700
Message-ID: <20260714021303.30042-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260714021303.30042-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260714021303.30042-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BLAPR03MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad941e6-067f-40d2-7853-08dee14d719b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|3023799007|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O5sf+0OWBZHK0lKcdKNozUceE6PrrBSEbewzUCPiej8d5lTxprwxvS7fri/Je9o67Q6woEOBMkgaGlQMLIO9iIcZ2bXgvCPbqI3exA3TOShp8/NAdKlbR2Xrtl3bpsVAIn1u+S/Nb4h0l7o/pQ3CJ8ZnlIuEPgcRf+Z+xbSWAG+aYXu0QAdohNcyy/FroEtCLy5doumdBO32MJDaUthLDB1EWyi1ZOmvRm4Hf4y3RHlQDhqIKF6Zf/R7OcGF0WxIMA0Z8uP/Ht5lxPcpUflOpBqPFqG0AJ6B8vyRcO1i2s8tH53qSHGCyo2UXDPt8Vc38cXolZdLP7AonJo9BSn/LrUUzzoXeEwJ66aEYCD6WwNnFVICWlwnGV89hZb0FzWb81MRPsPZDUz5yDSwTAkboNP3fcBMZeWUy8ud5rx8uv+ZdQX5FDHaYW54fXWQ9maJ3kx5Wllb1ByW9F+7cNtXGyJYkuOdy1CprGm5y/QDI4oRsqjaxm7lU79TeSiFBEhro+QEG+5mNrUXxNGMGB7ToXrTdD6ccvWVWyVc9PXdqj64xpTe3o4WkzugHDkklQM4nLC7jhDU84UwlC6kn9YGi4/kI/EcnzVpAug2E8bvjZg5T/oyNaxBClHuAVwfryJ1/P/1i7+BaOZxo7LuBDkZrLU/1mlHWbkymDpx//Itah0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(3023799007)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?txKBGNaOswc+lDJNt/KP5bNqn4VppgRd0nKgs4sL8gSdBE6zOSzPjaPZoo3f?=
 =?us-ascii?Q?oOa97syHLr3FyjCXUcUO3clV6Xotad/w1zv93reL+a4/FvycQ6rvjTp0c3L1?=
 =?us-ascii?Q?5ypeLmIUTuSEbSmj0yVbMeuZhIArdbU5y6USIvQ6be0R6/pDVnR6PaPI8onu?=
 =?us-ascii?Q?sryj5SdzSKA8FIzMsHCeXh+kyMSBuH1m7wyb7223qBO/IVUWQNHt0zkykh5G?=
 =?us-ascii?Q?teOgd9ozz2KjAUo9L3nrHrxnJwg4CHzropzOwXfMkbQbLSemYoWtmn5gknCg?=
 =?us-ascii?Q?eq2KOQYDuSKAH7h/S1NGq+q/LREbelKP/TRbhDPoEur8D/7gvKxjBgbXHVBW?=
 =?us-ascii?Q?YR8Ckb4NB+/I4bA5jMkGl7iLuqP51SjLaTzYu6JjJMq7HAtg/exOXLD/nbia?=
 =?us-ascii?Q?mZJFex4U5dpEKqx02curCkuQuOF32uvOvvaO6EhaHwX/ARnrjSOMmyiCvmnq?=
 =?us-ascii?Q?WwyeFH+S8+o6xZRLL2EcFoi86omi2YlMCo2S4yJiAhRiExSPiqjtwxmbqqdz?=
 =?us-ascii?Q?277CnWV5erTzFVuWPdFL9AT5yCWySRELWolI8JqO+6e3QcxoxzO4Zkgn50z7?=
 =?us-ascii?Q?x7WAFJrPsFT1EmD7ORRN/bp1yBtvVj++oK+lnZDuV3qtlvM8TP3dEvmbHJSi?=
 =?us-ascii?Q?E7HC1xJ7vYUV2N5YirYuyWzCWhhClAdtIyAQRaRi3Pc1PBiGcsr9o/WpHChT?=
 =?us-ascii?Q?wKoM5OF49mSIN6l/PwR/I3ua4iHXvwdlsNMBu5IbV7S+L93l1s+2c4+RndVy?=
 =?us-ascii?Q?TsS/L4EVg/pzFYg7DE8+QeNP2zyHRm0b0zxRyfQDvPWSegzemngqF36WK05p?=
 =?us-ascii?Q?Z9RBp33DL/KcIv+I+Icy+cF28Um8SQR/tzt7tLhd0avOgnFY8Pj35LScO8YZ?=
 =?us-ascii?Q?A3MEX4jy+uHYWKSz7KEM8e9pvtPBKHm7U13I4YLRM0aNxJqCoih2DR2SfoFP?=
 =?us-ascii?Q?Ho9xLu/lYxmAd2ZdMwCWepxv1/ZZfH7gSNUO/zSAczBxzGd4GKhs/c9S9QP5?=
 =?us-ascii?Q?7JjpQ0hagE0vIFLJBYQ7hagg9a9yTrSujXL3uXhQfeEJECWlQY8BWXE0DEbp?=
 =?us-ascii?Q?32ewX7x3dMOLwwwzs4E9Q/WZLJEfrhdEtW44vouytHeyacCKcHAZg6EhBO5k?=
 =?us-ascii?Q?uS1FMiNtewnUWmgkYxM4CciQqIXAjnVNjJkq0LV8/CPKaYKnmDi/9CObAw/K?=
 =?us-ascii?Q?9WdM7rzdC/i9+lbMqyoM/UwmfWfifiGm2otHD2zQfgAo8nXxLpXupN8AP9Rh?=
 =?us-ascii?Q?P6RBlyJxjd4OaFCXZ/LhUSH6Jk9XLkuf6T+0NLdSQwTE/EqgB2KtUa0zhf3X?=
 =?us-ascii?Q?X3dYHh0Ls8fq8ILMZ2NJ6AaXG3QXvJooXeFH6cssUmWBGXREjvWwj3zkQruF?=
 =?us-ascii?Q?wRDqy393eEFU6TCZfC6T5FSCr4jr46Zb3ySzcHpwziX12anNX166VKGzApha?=
 =?us-ascii?Q?0T4Bxl0zDcJNI20ChvNYEs/tmEvt+46cf2jlqgWfrDLXeudPYrWoWZp+YbdD?=
 =?us-ascii?Q?sSA/iHow+zgNeMTDTM2m4Wbjetl0jGRkdL1mx+RgNR6O0hTRpM1IMzpwZsyZ?=
 =?us-ascii?Q?Tn0QLCQgd3NX4tHLTlngZ7J1O06iPqJ2IzmhUgkGejxpGz9/z6aB+UiSDHKl?=
 =?us-ascii?Q?viwR5v2S3/CtydBLT57JVb7++6OkF59ENehBZB+Xf3q0+t5zMuVWEyeUsDI2?=
 =?us-ascii?Q?8RNN/cxuayHCtrGwDZz3M017H1q/YealgfJniTHdX3p521XoEI2qZIUw9Hec?=
 =?us-ascii?Q?tvt1R4CWlY20BSNIXUbzu6l1ko6q0aYdVgmR12a0HH9kK7nE6/YutqcdSYM8?=
X-MS-Exchange-AntiSpam-MessageData-1: MuMw48serbK/xg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad941e6-067f-40d2-7853-08dee14d719b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:13:06.9205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVAMavcs1Td/7KZQMFQJZBqy4NozKZfiZFuise/hjQHmaC2hx3QqvaZckxYMW0AxSuIbzC62CRUfA0qhLxF0UcyhapVqIhbpFPvSCR5J5C6DVZ3kA+AzLHgsb4EBL9NgKGCGyZMWUEOzN/H8yoa9+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5410
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307335-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:from_mime,altera.com:mid,altera.com:email,altera.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D801375053C

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
implemented as FPGA soft IP between gmac1 and its PHY. This converter
provides the RGMII TX/RX clock delays, so the MAC interface selector
must be configured for GMII while the PHY is configured without delays.

Add the "altr,socfpga-stmmac-agilex5-tsn" compatible to the match table
and detect it in probe to force GMII for the MAC interface selector and
strip the delay bits from phy_interface so the PHY is not configured to
add delays already provided by the FPGA converter.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
v3: No changes from v2.

 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 1d7f0a57d288..bf591a68502f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -69,12 +69,13 @@ struct socfpga_dwmac {
 	void __iomem *tse_pcs_base;
 	void __iomem *sgmii_adapter_base;
 	bool f2h_ptp_ref_clk;
+	phy_interface_t mac_interface;
 	const struct socfpga_dwmac_ops *ops;
 };
 
 static phy_interface_t socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
 {
-	return dwmac->plat_dat->phy_interface;
+	return dwmac->mac_interface;
 }
 
 static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
@@ -650,6 +651,15 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
 
+	dwmac->mac_interface = plat_dat->phy_interface;
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "altr,socfpga-stmmac-agilex5-tsn")) {
+		dwmac->mac_interface = PHY_INTERFACE_MODE_GMII;
+		if (phy_interface_mode_is_rgmii(plat_dat->phy_interface))
+			plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
+	}
+
 	ops->setup_plat_dat(dwmac);
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
@@ -674,6 +684,7 @@ static const struct of_device_id socfpga_dwmac_match[] = {
 	{ .compatible = "altr,socfpga-stmmac", .data = &socfpga_gen5_ops },
 	{ .compatible = "altr,socfpga-stmmac-a10-s10", .data = &socfpga_gen10_ops },
 	{ .compatible = "altr,socfpga-stmmac-agilex5", .data = &socfpga_agilex5_ops },
+	{ .compatible = "altr,socfpga-stmmac-agilex5-tsn", .data = &socfpga_agilex5_ops },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);
-- 
2.43.7



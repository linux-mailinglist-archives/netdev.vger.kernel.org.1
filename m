Return-Path: <netdev+bounces-297582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xtV5FuczKWpKSQMAu9opvQ
	(envelope-from <netdev+bounces-297582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:52:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A8E668066
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:52:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=SiB7s0Uv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297582-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297582-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D074A30C05C0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3937D3EFD07;
	Wed, 10 Jun 2026 09:47:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DA3EDAB5;
	Wed, 10 Jun 2026 09:47:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084845; cv=fail; b=Z4l4gkmF4uz9ZxwquPHFe4YbhK2WWsN0vzDaEbVooaVlk8SS6YO1ZNFlq+NwLGu5kr/kwxjEBbVS7k126NFdnmOn+zL/DqI4+zK1FGxsoYwamHcf7QflLNjiMZJ+1KhB+OLsMq6gRcuFQV6s1+DZ0mIFlocOa1ki5lJQGRI3QkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084845; c=relaxed/simple;
	bh=tOwsb2Nh9CSj7S/wEXol6kvSjFsvg3ZGeQhsPOMNOYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DJEXZREAImapHpbdRKrhy7BY0Lps27f8F1Qz+wtAYcrARyjuwMn+XhJBIpC9sZU7dbr0EvOV3BrCWgAHAKABl3k4e8EbISUrh+h7mnfjZhNEbXEyk3f5+FEoJxQ2xA8I1998Giy1DZI8JXZRARcRhh+hqz+sqVCVECC0ltMmARc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SiB7s0Uv; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNrfEID4pX5MYxyhBpbYAELIgP4DpL1XatG4UVyfoTQVFcrFlBCr65gk4oGogeOTRKn7ikvOAUDIByRaqRdqsc/Nta6ELBcJhmj9WbhObYraWRyLRyqCjuY5hOiV+4ZdQmmUKs5E7QP6zxTrA3z4K+sFdAULtDtz+B1baiE3uHs3HYT4ZnOvMseWePYCVlTuTb6wxouIz3PaZLiEwJAa9V9+4UDjuxutWbXW/SJuH00fAmtvdylsDi+DgDqrSTLAOOoB+D453dxb1nUmGKIvwJvKEDOceefeSmILpEtGjNe2pHATVJjPuk6zIYbU7qgua4pY/zNRTEzU6wfHQ3HWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bt7lETK/bQ7P6hzCDV01ibxYKh07U5a/qt4A4N3ytM=;
 b=bhjQAfWQVeTyijTaA2v/tQ2m7rwnliTg6HfA+swQifRyPPtJtKXbyJWLf9Q/VdvUltmG3zjTIV2fhaTj1ApiEjr0RhYbqFYSlFxMiHTRNDo/GsVnxuyN510yrM1geuVLgTWwW/ZNYrjjE31BX5jE5QbcFM0yDskWEMLolsrVMGk8f4gusBPezMTNr6tOp5h/EhaVA2ybh62GOG2P9TOC4hhm0d8Qh76prXqoq9iUWlKEYsT0m1UORRk8ukvHV8cUb6ExXGEqFwPZsRXfg3MQrfeGh0+vsSMBusjFrXWXbiVibB9Nn16nDW/QiOJ6y1yw6ZIE+bDQ02HeWrwYMiIjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bt7lETK/bQ7P6hzCDV01ibxYKh07U5a/qt4A4N3ytM=;
 b=SiB7s0UvWf5pU9G81YExQlP0JXEw29L3nNAg5OQvpBoxpftvVxSU8tWqNaeeooomUbR90qa+kl/lC0mbBrSA7+BE33CIVphaBfTOJzJYqyaxGpdYRYEm/Z0z2vfU0UdXUSturRq10r7qFE+A0buW1n3umblYDGx4YB0rrG3jVVLYOi7LskuTGdCIoblpypNM/494eWF3VflAYDtCIrc6NyxFqGnuZ1og1xSgf20ILwXSrtTbmU0Pj9rmC8gmGc6HYoPcbfZKNI/xHpGL3muJ7z4aDo0Xp4Qlnkm3exUU54SGZibD9mK+imc3S7xptzENf8ZsIIyXEniZcjRDjfgHfQ==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by AS5PR04MB9875.eurprd04.prod.outlook.com (2603:10a6:20b:652::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 09:47:21 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:47:21 +0000
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
Subject: [PATCH v2 net-next 14/15] net: enetc: add PSI-to-VSI link status notification support for VF
Date: Wed, 10 Jun 2026 17:18:43 +0800
Message-Id: <20260610091844.3423693-15-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|AS5PR04MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f28e89-ff54-4d6c-6387-08dec6d544a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|366016|22082099003|18002099003|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	djhzdIr8qxzmDgreW+C0XKZ5sr2jFAsbBiwEFO8n3nYjhXOoiida/dGf6F1F9BWdKH3bIOmUlKLuW7fuiwckf6gNCwWVRW1IqfW13WCLOB89Vb2sgzSjeQgmL1l9cg+e87wNPnX8tdDs6fuhJWKkmfMgpdJ3S1zAAELIZFaT9XUfhm6E889HcCGyEnOovuyGPUTmOE4RMXk/X14y7WLReMgk8XyyyVV8u9pQfA7r1sm11OsrjkB3C4njvc8Xi4o34nkiNvmVp2km6NnMC36famjwmelvWGjj/aPdNyzy+nl+Ecl/rQ4b0KkRUBN4lm2jCJGrY7H9ZpT+WgAQKUUp/YwopEG4ucGikpO6q9u4OEABtuRuGb8+koaTwyimskaFUqj1FHxBiKQ8WOej6jSyNEnxszSK/MoxAOUpFhl9qlLfR5bParCIjsooS2Hk4DT4jLd/0rfr0I7p7D0AEKKdbzsbaMLXABu1qnuIKsaGLH1iCNnY+9XvN9brV79y5hiIxVV5BDfR+T4+i42EifPNdwchVVews0pra5g4Xh9FqCaBQYUtBxYSR0RqQmrMyBnyCX88Heg7scTpVdQxn/d4gpyuwcZyJf3ne4NP/yrygjrT8R3/o17y5rN1zxLbgaFSvDdoS3OioJee0kunWN1BJhaGculXk6vwcSgdoBlbKsUY4gRG974VAjOUOmyrydVT5JV4wibsPKSn4d1dEqwdbkLb8YdDX0D2EqLE639tBxU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(22082099003)(18002099003)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vHyoX2eUiRolEvjcqms/3/uxfQw/IYy2SrqQvJG7USiVbyfzIIjzuA3luT5i?=
 =?us-ascii?Q?NhMmKjd4RauqvbFZh849fjq2+sLrQgl0PgueSQNEAA2bRVqnKrzTXHPRwo2n?=
 =?us-ascii?Q?z+3UzKZZBJ5sE6Z1cqTPe6/B7SMcEAHKfeFqPJnYw6Q2/EEczzSG8MsPAc+L?=
 =?us-ascii?Q?w3RYkLJscVZp61+q09I4ufNQbr47iGbYq8k/+Z3qqki/iEEV5pMar1ieBAQi?=
 =?us-ascii?Q?Py/JFH+4Tl3eiTOEdSk4u4zCO4VF5g8pIN+s8AQIG6Hs6jtuyMnWmLc9NL5j?=
 =?us-ascii?Q?oz7ekdxri5t7cKySZjFJgVY74itmC9aZEWp5Xx86T+k+gGgmVHR/Ll5x7i4n?=
 =?us-ascii?Q?Wk2/+63PXWZelqA9cQOg8+U3NrO9ibyL8eTEgboJN5vA7hImYexeKNMvHIjr?=
 =?us-ascii?Q?FhvXpouZZf9EuRyrLgw0JlJUnFliUPuybpUdA1Ju0GeILLw6QqLRAQtFUy2L?=
 =?us-ascii?Q?oCku8zdLwqLeqHztXHDiDlpjZyTAe2+TPq+/OQNvk4bFt0YrzumJhfAPbTgq?=
 =?us-ascii?Q?eKTsDj1p+V9fNhlzCQB/zP52+EyNDlBsWa3rX6G3uATr2yBnwp+z1decFYji?=
 =?us-ascii?Q?4DkQByEIb5cNFFHU7q6FYeTfBssQTQ6cDcONPvsXk+WgGIJw4zuZJyYoTeED?=
 =?us-ascii?Q?UN78mngwJtnn8WXXPd/ojDBpVvwk4H2Nir0A1sbGQhjU6ZUb8RGd7PH5XSCF?=
 =?us-ascii?Q?ec/poaSwyU+9M3szgrTwFgVxqoTRjDkaVS+qZFZM8+h2W+1t9OikEYMvnZX0?=
 =?us-ascii?Q?IJ3U04sjbixmC4GWS9U8eVaVd6Ibymgsr8VAJ+srPUlVunH8Zi2wO/mB2LKN?=
 =?us-ascii?Q?ExVhik2gCacLNUlEx1kXEewDHnRrVk+aUy0kEAAejGkCOXoSpYPRoeEXQDrL?=
 =?us-ascii?Q?gV7pdIL9KrZO3/fniXvfJRIxVLGmOhlnDwq5H0Y0zNgk0U4HWsGkFlGfXdjo?=
 =?us-ascii?Q?5fRqztP15bkTttlYcNaOKgA865bjcplak9dNKHw1EN9pIDj7goY2tpN4jYfE?=
 =?us-ascii?Q?yj8Vj/SI+SBf8IDSPXQKv02KQbXkvF77PHhLpE+2n7B5i4785sKIkncHpHlT?=
 =?us-ascii?Q?MZ3Q7ivpvdsjALblm5FA9kP1JvhENzJBq1oon/QaulfimHuduB6XlNgplYw0?=
 =?us-ascii?Q?BOwVW3hwdf+snmR73WdiS03vPM5O5KNxs2M559yFRQZfCC17tBlrDaMSdqzG?=
 =?us-ascii?Q?Tdcjvb8FvBtqsWzfyQFm/qbDHUhq/r8uCWXEHUot5f7BOrvLSxrO3M6Y7UBW?=
 =?us-ascii?Q?k1McwMPHH+K6080hZIb89VGv3c3MyT/Sw7yjsafQMNhOFS/EUMS1nELQJiYU?=
 =?us-ascii?Q?z0LVd6/5ANofqgBXxpRNjwnsNUubMf48evy79sSnB5bzM1ZbANmbJGHwYYlw?=
 =?us-ascii?Q?qnH2TjCyLYP0tXh+WKGAe5bpE6t5n2mJ2k6dFnx+6JiMI54IfBuIkWZgVvS2?=
 =?us-ascii?Q?Ldt0QPWzPIP+B1GUy/E1MAJNTUM99Zz+umlKdX7tiTfFb3iW+zMcpKRAtVxl?=
 =?us-ascii?Q?xrEP91fJng4eHJU6ZGA/xjaBuCl7neQhvyOC4bDd6Mqp3sYVqiW7vvPzNFiO?=
 =?us-ascii?Q?JELuMus3m3q60wA7wQFfsFiZqbZYRL7zXbV0mIZOShxTAOl94mis6CinTB0e?=
 =?us-ascii?Q?hAj+e2LoTrBzUfcHU3zscVrZF0S1Uvd3R0gyv9LPG+LRYbhPQuh/a6ChDz4M?=
 =?us-ascii?Q?IxRhcEpMgfKam+xw6pzgo52B0WpklIx7/Pj2swvBWk9Wyumb5+3F6fQfPYVz?=
 =?us-ascii?Q?dt/qmQfArfTUPW12hvkaG4Og/d1K3HfeKbcIWAxTCktfo8I4Rm+d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f28e89-ff54-4d6c-6387-08dec6d544a9
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:47:21.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxBRMO8hbSU0/vdQJ0W59qbaNE2QlSSsKqrtKx0RcCO6RuBJQLrhgnwDZq2SSFr9iwRVzDgZWvmlYMNMX5kTtonkn3BLi7m5f/tsQfTdr5kK6wgNkmWbAJOMuEfmkbby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9875
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297582-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30A8E668066

From: Wei Fang <wei.fang@nxp.com>

Add infrastructure for ENETC v4 VFs to track PF link status changes via
the PSI-to-VSI messaging channel. Two new ops,
vf_reg_link_status_notifier and vf_unreg_link_status_notifier, are added
to enetc_si_ops and wired into enetc_phylink_connect() and enetc_close()
for the phy-less path. The feature is populated only in enetc4_vsi_ops;
rev1 hardware is not affected.

On enetc_open(), the VF sends a REGISTER_LINK_CHANGE_NOTIFIER message to
the PF through the VSI-to-PSI messaging channel. The PF records the VF
in link_status_ms_mask, and immediately sends the current link status so
that the VF carrier quickly reflects the link status as soon as the
interface comes up. On every subsequent PF link transition the PF
broadcasts a 16-bit notification to all registered VFs.

On the VF side, a dedicated MSI-X vector handles incoming PSI-to-VSI
messages. The interrupt handler schedules a work item which parses the
notification and updates the carrier state via netif_carrier_on() or
netif_carrier_off() accordingly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  |  28 ++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |   5 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   9 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 209 +++++++++++++++++-
 4 files changed, 249 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index fdceaf36daa7..fd5885b0fa81 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2892,11 +2892,20 @@ static void enetc_clear_interrupts(struct enetc_ndev_priv *priv)
 static int enetc_phylink_connect(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
 	struct ethtool_keee edata;
 	int err;
 
 	if (!priv->phylink) {
 		/* phy-less mode */
+		if (si->ops->vf_reg_link_status_notifier) {
+			if (!si->ops->vf_reg_link_status_notifier(si))
+				return 0;
+
+			dev_warn(&ndev->dev,
+				 "Link status notifier registration failed\n");
+		}
+
 		netif_carrier_on(ndev);
 		return 0;
 	}
@@ -2968,6 +2977,7 @@ int enetc_open(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr_resource *tx_res, *rx_res;
+	struct enetc_si *si = priv->si;
 	bool extended;
 	int err;
 
@@ -3008,8 +3018,15 @@ int enetc_open(struct net_device *ndev)
 err_alloc_rx:
 	enetc_free_tx_resources(tx_res, priv->num_tx_rings);
 err_alloc_tx:
-	if (priv->phylink)
+	if (priv->phylink) {
 		phylink_disconnect_phy(priv->phylink);
+	} else if (si->ops->vf_unreg_link_status_notifier &&
+		   test_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED,
+			    &priv->flags)) {
+		if (si->ops->vf_unreg_link_status_notifier(si))
+			dev_warn(&ndev->dev,
+				 "Link status notifier unregistration failed\n");
+	}
 err_phy_connect:
 	enetc_free_irqs(priv);
 err_setup_irqs:
@@ -3050,6 +3067,7 @@ EXPORT_SYMBOL_GPL(enetc_stop);
 int enetc_close(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
 
 	enetc_stop(ndev);
 
@@ -3057,6 +3075,14 @@ int enetc_close(struct net_device *ndev)
 		phylink_stop(priv->phylink);
 		phylink_disconnect_phy(priv->phylink);
 	} else {
+		if (si->ops->vf_unreg_link_status_notifier &&
+		    test_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED,
+			     &priv->flags)) {
+			if (si->ops->vf_unreg_link_status_notifier(si))
+				dev_warn(&ndev->dev,
+					 "Link status notifier unregistration failed\n");
+		}
+
 		netif_carrier_off(ndev);
 	}
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 24d9f89aee73..a8c845e5f863 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -300,6 +300,10 @@ struct enetc_si_ops {
 	int (*set_rss_table)(struct enetc_si *si, const u32 *table, int count);
 	int (*setup_cbdr)(struct enetc_si *si);
 	void (*teardown_cbdr)(struct enetc_si *si);
+
+	/* VSI-specific hooks */
+	int (*vf_reg_link_status_notifier)(struct enetc_si *si);
+	int (*vf_unreg_link_status_notifier)(struct enetc_si *si);
 };
 
 /* PCI IEP device data */
@@ -423,6 +427,7 @@ enum enetc_active_offloads {
 enum enetc_flags_bit {
 	ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS = 0,
 	ENETC_TX_DOWN,
+	ENETC_LINK_STATUS_NOTIFIER_REGISTERED,
 };
 
 /* interrupt coalescing modes */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 47de179e17c8..78282dbbcfa3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -85,6 +85,9 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define  PSIMSGSR_MS(n)		BIT((n) + 1)
 #define  PSIMSGSR_MC		GENMASK(31, 16)
 
+#define ENETC_VSIMSGRR		0x208
+#define  VSIMSGRR_MC		GENMASK(31, 16)
+
 /* SI statistics */
 #define ENETC_SIROCT	0x300
 #define ENETC_SIRFRM	0x308
@@ -108,6 +111,12 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define ENETC_SICAPR0	0x900
 #define ENETC_SICAPR1	0x904
 
+#define ENETC_VSIIER	0xa00
+#define  VSIIER_MRIE	BIT(9)
+
+#define ENETC_VSIIDR	0xa08
+#define  VSIIDR_MR	BIT(9)
+
 #define ENETC_PSIIER	0xa00
 #define ENETC_PSIIDR	0xa08
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index dc9a0f74a2e3..ba7686fb32ce 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -135,6 +135,52 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 	return err;
 }
 
+static int enetc_msg_link_status_notifier(struct enetc_si *si, bool reg)
+{
+	struct device *dev = &si->pdev->dev;
+	struct enetc_msg_swbd msg_swbd;
+	u8 cmd_id;
+
+	msg_swbd.size = ALIGN(sizeof(struct enetc_msg_generic),
+			      ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
+		return -ENOMEM;
+
+	cmd_id = reg ? ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER :
+		       ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER;
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_LINK_STATUS,
+				  cmd_id, 0, 0);
+
+	return enetc_msg_vsi_send(si, &msg_swbd);
+}
+
+static int enetc_vf_reg_link_status_notifier(struct enetc_si *si)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(si->ndev);
+	int err;
+
+	err = enetc_msg_link_status_notifier(si, true);
+	if (!err)
+		set_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED, &priv->flags);
+
+	return err;
+}
+
+static int enetc_vf_unreg_link_status_notifier(struct enetc_si *si)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(si->ndev);
+	int err;
+
+	err = enetc_msg_link_status_notifier(si, false);
+	if (!err)
+		clear_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED,
+			  &priv->flags);
+
+	return err;
+}
+
 static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 					      struct sockaddr *saddr)
 {
@@ -415,6 +461,122 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
 
+static void enetc_vf_enable_mr_int(struct enetc_hw *hw)
+{
+	u32 val = enetc_rd(hw, ENETC_VSIIER) | VSIIER_MRIE;
+
+	enetc_wr(hw, ENETC_VSIIER, val);
+}
+
+static void enetc_vf_disable_mr_int(struct enetc_hw *hw)
+{
+	u32 val = enetc_rd(hw, ENETC_VSIIER) & (~VSIIER_MRIE);
+
+	enetc_wr(hw, ENETC_VSIIER, val);
+}
+
+static void enetc_vf_msg_handle_link_status(struct enetc_si *si, u8 class_code)
+{
+	struct net_device *ndev = si->ndev;
+
+	switch (class_code) {
+	case ENETC_LINK_STATUS_CLASS_CODE_UP:
+		if (netif_running(ndev) && !netif_carrier_ok(ndev)) {
+			netif_carrier_on(ndev);
+			netdev_info(ndev, "Link is Up\n");
+		}
+		break;
+	case ENETC_LINK_STATUS_CLASS_CODE_DOWN:
+		if (netif_carrier_ok(ndev)) {
+			netif_carrier_off(ndev);
+			netdev_info(ndev, "Link is Down\n");
+		}
+		break;
+	}
+}
+
+static void enetc_vf_msg_task(struct work_struct *work)
+{
+	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
+	struct net_device *ndev = si->ndev;
+	struct enetc_hw *hw = &si->hw;
+	u8 class_id, class_code;
+	u16 pf_msg;
+
+	pf_msg = FIELD_GET(VSIMSGRR_MC, enetc_rd(hw, ENETC_VSIMSGRR));
+	/* W1C to clear the message received interrupt event */
+	enetc_wr(hw, ENETC_VSIIDR, VSIIDR_MR);
+
+	/* If ndev is in the NETREG_UNREGISTERED state, return directly
+	 * without processing the message or enabling MR interrupt. Any
+	 * future caller that reuses this work item after the device
+	 * returns to a registered state should enable MR interrupt again.
+	 */
+	if (ndev->reg_state == NETREG_UNREGISTERED)
+		return;
+
+	class_id = FIELD_GET(ENETC_PF_MSG_CLASS_ID, pf_msg);
+	class_code = FIELD_GET(ENETC_PF_MSG_CLASS_CODE, pf_msg);
+
+	switch (class_id) {
+	case ENETC_MSG_CLASS_ID_LINK_STATUS:
+		enetc_vf_msg_handle_link_status(si, class_code);
+		break;
+	default:
+		dev_err(&si->pdev->dev,
+			"Unsupported Message Class ID (0x%02x) from PF\n",
+			class_id);
+	}
+
+	enetc_vf_enable_mr_int(hw);
+}
+
+static irqreturn_t enetc_vf_msg_msix_handler(int irq, void *data)
+{
+	struct enetc_si *si = (struct enetc_si *)data;
+
+	enetc_vf_disable_mr_int(&si->hw);
+	queue_work(si->workqueue, &si->msg_task);
+
+	return IRQ_HANDLED;
+}
+
+static int enetc_vf_register_msg_msix(struct enetc_si *si)
+{
+	int irq, err;
+
+	if (is_enetc_rev1(si))
+		return 0;
+
+	snprintf(si->msg_int_name, sizeof(si->msg_int_name), "%s-pfmsg",
+		 pci_name(si->pdev));
+	irq = pci_irq_vector(si->pdev, ENETC_SI_INT_IDX);
+	err = request_irq(irq, enetc_vf_msg_msix_handler, 0,
+			  si->msg_int_name, si);
+	if (err) {
+		dev_err(&si->pdev->dev,
+			"VF messaging: request_irq() failed!\n");
+		return err;
+	}
+
+	/* set one IRQ entry for PSI-to-VSI messaging */
+	enetc_wr(&si->hw, ENETC_SIMSIVR, ENETC_SI_INT_IDX);
+
+	/* Enable message received interrupt */
+	enetc_vf_enable_mr_int(&si->hw);
+
+	return 0;
+}
+
+static void enetc_vf_free_msg_msix(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return;
+
+	enetc_vf_disable_mr_int(&si->hw);
+	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
+}
+
 static const struct enetc_si_ops enetc_vsi_ops = {
 	.get_rss_table = enetc_get_rss_table,
 	.set_rss_table = enetc_set_rss_table,
@@ -427,8 +589,36 @@ static const struct enetc_si_ops enetc4_vsi_ops = {
 	.set_rss_table = enetc4_set_rss_table,
 	.setup_cbdr = enetc4_setup_cbdr,
 	.teardown_cbdr = enetc4_teardown_cbdr,
+	.vf_reg_link_status_notifier = enetc_vf_reg_link_status_notifier,
+	.vf_unreg_link_status_notifier = enetc_vf_unreg_link_status_notifier,
 };
 
+static int enetc_vf_wq_task_init(struct enetc_si *si)
+{
+	char wq_name[24];
+
+	if (is_enetc_rev1(si))
+		return 0;
+
+	snprintf(wq_name, sizeof(wq_name), "enetc-%s", pci_name(si->pdev));
+	si->workqueue = create_singlethread_workqueue(wq_name);
+	if (!si->workqueue)
+		return -ENOMEM;
+
+	INIT_WORK(&si->msg_task, enetc_vf_msg_task);
+
+	return 0;
+}
+
+static void enetc_vf_wq_task_destroy(struct enetc_si *si)
+{
+	if (!si->workqueue)
+		return;
+
+	disable_work_sync(&si->msg_task);
+	destroy_workqueue(si->workqueue);
+}
+
 static int enetc_vf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -493,6 +683,18 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 		goto err_alloc_msix;
 	}
 
+	err = enetc_vf_wq_task_init(si);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to init workqueue\n");
+		goto err_wq_init;
+	}
+
+	err = enetc_vf_register_msg_msix(si);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register msg irq\n");
+		goto err_register_msg_msix;
+	}
+
 	err = register_netdev(ndev);
 	if (err)
 		goto err_reg_netdev;
@@ -502,6 +704,10 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 	return 0;
 
 err_reg_netdev:
+	enetc_vf_free_msg_msix(si);
+err_register_msg_msix:
+	enetc_vf_wq_task_destroy(si);
+err_wq_init:
 	enetc_free_msix(priv);
 err_config_si:
 err_alloc_msix:
@@ -528,7 +734,8 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 
 	priv = netdev_priv(si->ndev);
 	unregister_netdev(si->ndev);
-
+	enetc_vf_free_msg_msix(si);
+	enetc_vf_wq_task_destroy(si);
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-- 
2.34.1



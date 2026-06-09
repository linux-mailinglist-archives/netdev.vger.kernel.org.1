Return-Path: <netdev+bounces-296882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RAgkDISIJ2qHygIAu9opvQ
	(envelope-from <netdev+bounces-296882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 05:29:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C213A65C0BC
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 05:29:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=UQSgiPcV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296882-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296882-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E6DD3055B95
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 03:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB01367F2F;
	Tue,  9 Jun 2026 03:27:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B858368D66;
	Tue,  9 Jun 2026 03:27:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780975651; cv=fail; b=EgHXEnAbSPbTAKYBgND8EjWI1GJWAuirDYL+dHmhxRmPNwdLNtdxcscMpUOio/fVyAkrR6kDiKDGtwOjkVi9gQY0ZlYCwxVrQr3NfuaXem4Jb485ZJaKBo6ai0qMfZiPCPunpE66U9hl2KEEfgkHH9ANhGqqau6DpkJqlxQCZU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780975651; c=relaxed/simple;
	bh=N3i6t5j74sGKT6Yn7d3hPIZsBeCPCBQN5y9c16oa5C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8lpMbT6yhz0/44VswQ6E9xokr0dGM+MVVxRPpToMonIFQFvpd6YOBwyTXX0LZwRW3Sq3EF5njVg2Lj99YoN08TCZuBPYKGmSewDt0CwlVzYSC0B1ZiTmvmPY2R1KuLP8JPGYjXUGUk4ykUmA/8XZTl5d/G21e4v89CXKIeJFfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UQSgiPcV; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEta5ewh+XzTVB6+h00Qz+zg8tEO5NMlvb7yRi59B6R0FmU8To/12MvpHpA3YL5UuSocFD1RUkT92Lt8nK4+UNvwWKQL7HZsDyR5qCZFlFuNwZp41KdKXfRnUU0TnOR0wGz3dkCkxCCOqtkZvUunPfmsI+vCfJtg2C9SbXC/5HMRL/gXxuAhowHzXIYOuXMDyOTYGY8K9FBB1G73EVgPJtmxkYqaewCU7Ddk0Nw5UXgzkMuPjptPFcDxttwHNQE+QIokphpkGs+9B8YnCv4tObqy+oKcNHKgt3eHBz1jUJi5iXAZpguJvvahkfbFl+8vno8+ySWynb9lpObHC2ZmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izhzbpCs4dZ++AWfRc/YrENezh0oAOUxeEIHzzS8pBA=;
 b=r2RFQl5asIYDS4Wk0ewUr3Ni0+U/hQwW2lWco8RqdA/KfGbgiPUrAtDdp3WLDnWmVErVznfCgYrcc9Gsoe8ICvzv0c2SxGuQ+GE6Dn4YSD++ax+EzturQmwrjgVa8gq/lGdb8sdG372xKp3qTiJZSKOMfTEL0eFqxVmg+dSUKbNnbga7BjHr9ztWAmWxuoT8uG8Nq/t3cZmaB/wS01Hs8RPiyPELflV28zi/8lfT4Kf+PnkXp5tYSeuXW45fPk4t+QOYzEnfwM03/mR+TxZPPVWvrG56FDq25oWRcU+r/JU6TkJyp7xBeZll1RA6/IVhHDH5Y3a9TW0SySI6odaezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izhzbpCs4dZ++AWfRc/YrENezh0oAOUxeEIHzzS8pBA=;
 b=UQSgiPcVBE7bXE6FCBKQXeYZd6N7BjHVrVDqTOuU6RUQSdDBrultUoOuz4e5Du80zAZS4FA3ACVrBB9NxXUMVqLbor7knXuEKJh6oxzDxaHcFWVgks6BCHP4Isjx4qWQblrDAOD2+bb6hAsEmya8nMGTlASMN7D3nVLLOZHrQzctmJcPTFsW+SO6qQH48p/P4/CTjBxjvwKnw5Uxwja16myq1y7iapXdxKQJWmL7fRrGwc6y43o4S/4sh6JmCUpBoE5pEUSCmL5EYDbcJBJRhp6o8+imfI7p4zp35AIrRyAUYCjY2qQnBcsHsOp9rcfxUKF4Ga7I11TaA79DfC/nQw==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 9 Jun
 2026 03:27:27 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:27:27 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 5/9] net: dsa: netc: initialize the group bitmap of ETT and ECT
Date: Tue,  9 Jun 2026 11:29:51 +0800
Message-Id: <20260609032955.2066089-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
References: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0333.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::18) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe19823-c649-43ac-3485-08dec5d707e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|22082099003|18002099003|921020|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	7bNRPBLKZkwimPY5sjP/Yvc5CSld6lHJ3ACCLH+jnft3CbmkP1LElHheEUnFuD7SeuP3h7WXbdKZIIVwQ+yD8hyaPjn5VFIdwr2ujlEt7snHuXuG8jQYMyVa8ui0DScKwXCHl410PV8/VyrkwRu6TkCrdXhyRrXb22nKh2WCdsev43X8Q9chEB1M3ATvusJA/KHHCh0yxSFg/QMjAppjWa/0UZJnR6QKcTkinc1U0HsBcqcrogztOZhcgmj49w4fbBgf2uTSK6PgHSDcKu6zvccSjMGchc9x1mvCngXPhzjtLEfD69OYpn0UjZ0hg1xfF4QwwbGhzD8GNf0Y7u1zPCHMXMyIL50COQjbVULKNW5sXNLeIF9YmFRTSoR8GU45I5LBamAlOShY+1kgAtMZF0pC5XypUFXkwS6hxlk0XYWRJhbJkH/WUpwMEl9w5n+NmnFo73jdT0uRfheF6IPFDXsSE4ocScA9W4pxNywmJXcOYAi7MxKf1mslpQiqv24Pb11x/Hv2KD9rPVjFSXa8g2PoCoNmv4f8RNG3JeU/dlNBST4RJD4br1swkPQ+CFC20DjnxI0Rt8wJPS60calQWf7uKM8/fSp/mS05uHKYCc/kMzrCbQ7reaY6G1BAIDUwz8LvIMBVaW6qGsgd+HN4dUnwvTTg8ObP5peibhKTGjIDv26o4nln4lIPlmJNdiDLxwyV86ZPzwPKGkr5QZEnf10++Qzk0YYCNc4NOWnGSew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uiwNrpdu+WsTfyq/YCE6ZA4wf1Vyd8N+6fOkUFX6rI6xuxJrsl9QV1bckJrM?=
 =?us-ascii?Q?bOKvXkOFPf/BvbOfiwes6muvU1ha7fbQl4KiP1G/dDFHUarzZasq0Gc/Pgr6?=
 =?us-ascii?Q?KfxUS0gysKvXhqLL3YtB1HlQ0sppfetgGDdQGPWG0l5uZl2z+Vflbod5ri8i?=
 =?us-ascii?Q?z1lcLrTqlS5E69CG4BcL19OOTihUNXJ+aGEnFsoWslL/3GP3eHoNeKxfHIcc?=
 =?us-ascii?Q?/NJzyyEOFCTtxB8pbBgFc3nZ3Ng/M4YxfbLEUbxRsh8wId2Df1XpS6J60iKR?=
 =?us-ascii?Q?ZbloEUaUxBycbFfBoBKb4MxHQ2niJyhf/3SpxbRqD+xkSiSwg132dJh5eJp4?=
 =?us-ascii?Q?uBCgOsoVq1uNeWB0FF2H34tEzfGvrHGp3PyI6OzT3CYH3W22jESO3DCn99BR?=
 =?us-ascii?Q?qRCEbrPiaw7TZ8OL6mzpeMUl+eB1awbBQY0VmCnd5t7+YbOw9nT3+bgbCkHN?=
 =?us-ascii?Q?PKcm/Lfa4mLz0D/RVJ9YUtjfLMTRD3CeXGiPSGsh6ui2sQZh2X/mwsqiaaGT?=
 =?us-ascii?Q?uJB/xH/VbOHh6eoI4sqB4Lf0pgl/I62kJpYjG0mIJxwBbBlu7UfyQoJ9jYre?=
 =?us-ascii?Q?y9K0Xjuvze7AfwzsmlAVMI/rSWcmVlY3+KGGAL9Mw/I8FSy16Ejb9ItJL9Ln?=
 =?us-ascii?Q?in/Z/I0fuvx2DxaVlkhG04pYTKZj6ifJXfWbwgrPkdjgAtkLMT0LoLdE4tao?=
 =?us-ascii?Q?H2Pkj+J7iIkh5n1tErXnwi5h/VQpf2M6mvV/9oTIJLVb8fjJXhjE2GkSfcxj?=
 =?us-ascii?Q?QwCWtfpyYizfheesKkLDjrOOMag9LO3kbMEt3roEyA95ouM5rMRwyEowU+zm?=
 =?us-ascii?Q?XIxoljagcOdSUHET7BVc9SeKVlEY6WQez1otIyhdX3E8+QqWwCA1LqJzHGIb?=
 =?us-ascii?Q?pOnoP5hPnFXGhieE7dKUWmruh1bbGENNEnwnOvP9WSqyF9jys1gOky6r+g0E?=
 =?us-ascii?Q?3J68liLWXwcPL+Qj4MhpN/TlOqYoymNL5PB25XjOM+TRimbyxrqBVNlge+pk?=
 =?us-ascii?Q?9OmN0lA+0rBCRiZiFC8bwEYlxfT7sAyHDF5ELMywtB+XUFuvNw0z6A0icmpO?=
 =?us-ascii?Q?G3/E1QXUdYipzSJsxSo5FYKEnuPwWxztUDbVNJBqJeRrjVeQnHq3MTy9hmJQ?=
 =?us-ascii?Q?ucpIcoQm4vcJ6dpOMlsu5iDHUktmwH0N8vs/zJlgTVjQ8Ge0fPRBJ2rY0+/M?=
 =?us-ascii?Q?8QGaL+PiwDJykaQfzbuExfWm+6CVg+7FrbN1Cy0bsDCzYXedd+xNkJspFAHW?=
 =?us-ascii?Q?oJl29rswfAVtNird5sNu8QqYP5IVlMQgDo/B4zAMLVeTK89wDGMiLNH/rae3?=
 =?us-ascii?Q?iinOafUAUBlvLRcqz/9s7vvtDOT4XX7Ojtstoq+rNOlvkyPtM4S4ywQr8Rfy?=
 =?us-ascii?Q?Dzg0wEBeyucREoXpajdisxet6Nq4IF3ADw2jC39775wXEaR7tLMZM/xQ3dVY?=
 =?us-ascii?Q?3CUxf/Lx+ojXRK93uJGtw9/DP7jjNWSiUP2HwdiEB+EJVeB6LoJ+/JFgdlO1?=
 =?us-ascii?Q?Gfaj/tw9s9ShMNxkNkxvxaomk6bJZ2JOSUdkLFT4pBCvYNhRlmB1KIIWbbG+?=
 =?us-ascii?Q?Qs9z/hfrJ8ZrFHu82Ji/J/Uf18ZdFv8zaB9z+XQwJgI0kLljhPYuXKEuH0V7?=
 =?us-ascii?Q?SfstLElwBu+n9y21yKzIzpxQLN/eLMOuxhERRC8FGxx/Jn78PZMq504Nair6?=
 =?us-ascii?Q?OXtsRYdRhmUrnfdMUdVnV1x9zzlsOytPwtKXw5S6eLhyCp8Dx+dhZqzQKQgt?=
 =?us-ascii?Q?333qG0dLfOLwEU90iEShYEXGQ4rsHafKLmmJcmVwwRQnyeXVIblw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe19823-c649-43ac-3485-08dec5d707e3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:27:27.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fn5XGPxRD58dpymuxEvBffTRHHDzK7sbCQUNeI0Mm8qzDy5qu5yJLNBKekN7tjRnDaOXaRn2RxJMBxypMTTQc/ntcEUzWKENXH7A2IFI4OrlggNnh10LBIsMo69gP94N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296882-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C213A65C0BC

From: Wei Fang <wei.fang@nxp.com>

The Egress Treatment Table (ETT) and Egress Count Table (ECT) are both
index tables whose entry IDs are allocated by software. Every num_ports
entries form a group, where each entry in the group corresponds to one
port. To facilitate group allocation and management, initialize the group
index bitmaps for both tables based on hardware capabilities reported by
ETTCAPR and ECTCAPR registers.

The bitmap size per table is calculated as the total number of hardware
entries divided by the number of available ports, which gives the number
of groups available for software allocation. A set bit in the bitmap
represents a group index that has been allocated.

These bitmaps will be used by subsequent patches that add VLAN support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 90 ++++++++++++++++++++++++++-
 drivers/net/dsa/netc/netc_switch_hw.h |  6 ++
 include/linux/fsl/ntmp.h              |  7 +++
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index fa7dd307ce13..d4475ad7ed6c 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -323,16 +323,104 @@ static void netc_remove_all_cbdrs(struct netc_switch *priv)
 		ntmp_free_cbdr(&ntmp->ring[i]);
 }
 
+static u32 netc_num_available_ports(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+	u32 num_ports = 0;
+
+	dsa_switch_for_each_available_port(dp, priv->ds)
+		num_ports++;
+
+	return num_ports;
+}
+
+static int netc_init_ntmp_bitmap_sizes(struct netc_switch *priv)
+{
+	u32 num_ports = netc_num_available_ports(priv);
+	struct netc_switch_regs *regs = &priv->regs;
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 val;
+
+	if (!num_ports)
+		return -EINVAL;
+
+	val = netc_base_rd(regs, NETC_ETTCAPR);
+	ntmp->ett_bitmap_size = NETC_GET_NUM_ENTRIES(val) / num_ports;
+	if (!ntmp->ett_bitmap_size)
+		return -EINVAL;
+
+	val = netc_base_rd(regs, NETC_ECTCAPR);
+	ntmp->ect_bitmap_size = NETC_GET_NUM_ENTRIES(val) / num_ports;
+	if (!ntmp->ect_bitmap_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int netc_init_ntmp_bitmaps(struct netc_switch *priv)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+
+	ntmp->ett_gid_bitmap = bitmap_zalloc(ntmp->ett_bitmap_size,
+					     GFP_KERNEL);
+	if (!ntmp->ett_gid_bitmap)
+		return -ENOMEM;
+
+	ntmp->ect_gid_bitmap = bitmap_zalloc(ntmp->ect_bitmap_size,
+					     GFP_KERNEL);
+	if (!ntmp->ect_gid_bitmap)
+		goto free_ett_gid_bitmap;
+
+	return 0;
+
+free_ett_gid_bitmap:
+	bitmap_free(ntmp->ett_gid_bitmap);
+	ntmp->ett_gid_bitmap = NULL;
+
+	return -ENOMEM;
+}
+
+static void netc_free_ntmp_bitmaps(struct netc_switch *priv)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+
+	bitmap_free(ntmp->ect_gid_bitmap);
+	ntmp->ect_gid_bitmap = NULL;
+
+	bitmap_free(ntmp->ett_gid_bitmap);
+	ntmp->ett_gid_bitmap = NULL;
+}
+
 static int netc_init_ntmp_user(struct netc_switch *priv)
 {
+	int err;
+
 	netc_init_ntmp_tbl_versions(priv);
 
-	return netc_init_all_cbdrs(priv);
+	err = netc_init_ntmp_bitmap_sizes(priv);
+	if (err)
+		return err;
+
+	err = netc_init_ntmp_bitmaps(priv);
+	if (err)
+		return err;
+
+	err = netc_init_all_cbdrs(priv);
+	if (err)
+		goto free_ntmp_bitmaps;
+
+	return 0;
+
+free_ntmp_bitmaps:
+	netc_free_ntmp_bitmaps(priv);
+
+	return err;
 }
 
 static void netc_free_ntmp_user(struct netc_switch *priv)
 {
 	netc_remove_all_cbdrs(priv);
+	netc_free_ntmp_bitmaps(priv);
 }
 
 static void netc_switch_dos_default_config(struct netc_switch *priv)
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 1d976882a6cc..1404ae41c7bc 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -36,6 +36,12 @@
 #define  DOSL3CR_SAMEADDR		BIT(0)
 #define  DOSL3CR_IPSAMCC		BIT(1)
 
+#define NETC_ETTCAPR			0x18c4
+#define NETC_ECTCAPR			0x18ec
+/* Index table NUM_ENTRIES mask */
+#define NETC_NUM_ENTRIES		GENMASK(15, 0)
+#define NETC_GET_NUM_ENTRIES(v)		FIELD_GET(NETC_NUM_ENTRIES, (v))
+
 /* Hash table memory capability register, the memory is shared by
  * the following tables:
  *
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 1222901f48a7..e8b1bd802f19 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -3,6 +3,7 @@
 #ifndef __NETC_NTMP_H
 #define __NETC_NTMP_H
 
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
 
@@ -70,6 +71,12 @@ struct ntmp_user {
 	struct device *dev;
 	struct netc_cbdr *ring;
 	struct netc_tbl_vers tbl;
+
+	/* NTMP table bitmaps for resource management */
+	u32 ett_bitmap_size;
+	u32 ect_bitmap_size;
+	unsigned long *ett_gid_bitmap; /* only valid for switch */
+	unsigned long *ect_gid_bitmap; /* only valid for switch */
 };
 
 struct maft_entry_data {
-- 
2.34.1



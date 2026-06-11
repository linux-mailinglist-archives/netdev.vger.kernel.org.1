Return-Path: <netdev+bounces-297886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zGUYADcaKmpAiwMAu9opvQ
	(envelope-from <netdev+bounces-297886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:15:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A00D66DC87
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:15:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=SnTPcrZb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297886-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297886-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D9D730D68D1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B77F28C87C;
	Thu, 11 Jun 2026 02:12:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B02C0294;
	Thu, 11 Jun 2026 02:12:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143952; cv=fail; b=pO5sgDZp5AgjUTFo15WtX7Qfsw9znq2oFX7afCf/nXtvAvtm0zVuMwjICWt7r3A/Z5yQuJIYAZy342eM+KwTKLjTLiijA4nzMktxhqyh57xbRmORoxbY24dJtVHlIo3/4CjC+Ruab9WGsLIsCzOoHNTiy+K5hgGBrlkn2vR1VHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143952; c=relaxed/simple;
	bh=N3i6t5j74sGKT6Yn7d3hPIZsBeCPCBQN5y9c16oa5C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sp2DW/qspu8ozY64fAd5UlR3zHu4h1SjB7MHo0YvIRjW5zpmvvJib0nd/QTEufCtTh1tic/qIg0ZS1uCek641s6gdA3S4qghQV6Mr/2AtgSHYqM7bHy8PFalCjv9/TLLgbDiUK4BSbQM2KwFt3ey0K+pfQdsH4neEy0DRsPTX54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SnTPcrZb; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clAS8zmsxdpX/fRYwtSk8Vn850v59NAGijfqXMZTx4u09ByoW581m9oHMGGItU4NBVh4Ll+z/c7tx21I4/flEpihqQXldYcsfXx9rPVMrn+8WvqutGhLOM05yIpRpgco2iOFAUkCqeHJzsHPp1bJQr09+3LIpa+hUed8ek7EPrbv0rj+8RWLLBZiOWV3k+eT8QC2jqGdu+9bA3ZYa3+L8L53qB8g4OLwRBnk4tPXgiGKMIEdruxkN+9IAbVBFvZcjIf8sWfwm8FPl1rRims3dAyr63OvVFn8z//dlALmkDlB+7d/XIGrLT9Cc+1Z5ONWwAHxoPAr6bOqO93as4zsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izhzbpCs4dZ++AWfRc/YrENezh0oAOUxeEIHzzS8pBA=;
 b=TYUD7oJqJocMMdlrDyFCzS5ZXf3rgCVEh6V/X0smuApACZ0PCIpl/GRGQ41JiNFJcfNHabENK0QEf9nQdnQwUINWWtSLIY4EoM5Gi6tiLY5jilgLMf8l321bi6tdmgPhdZRBydGv5WRAhhBQ/dsc3U+nBuk5OoCR9c0o3udqlY/BBeYPbOWIf1kSVGnA2TwLWSwlY4bbWDqKvdpI8SfsPp5EbktEu2od/ezWa2DOWeCNtbsGWzF2EWePDYACgrBHqjQ8piwJt/1D+qjhqg98N3o416uw8NNo2jzi1shUXpzc7pBa9z6iJdWpnvD56mfCgyZ4UUDl/wFGht3cb7WUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izhzbpCs4dZ++AWfRc/YrENezh0oAOUxeEIHzzS8pBA=;
 b=SnTPcrZbHMJg6nQsZ1b87D/6B9Hxp2NnNLIHv/Nqnys+Iq9viQsw43rCFdCwBuX+zj+JiGXmb+iDUmIgKxBrrWuACMowNXAH+KAo6D5UBs7yhLyy9FYDXgCwe7FtBw4lWbeR1Jnd/Idbz/ma3MDvJJ7RfAsL3QJr0/fR1uv6JPfy1oq7FBwvwgpnwIc37wLX449PToac230/Ao70ZtjM8ejaLt8hYc36O2ieeeJVYkB96uznQoH3M7+ViNaYjDyynzMZo6j8X05YFI9kfUfJmSCvyalp2pmpxbGKYIbdsAsqGRQlLkdYFl5zf/8F/OogUezYg095GTpMCeKIC5UsJA==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10824.eurprd04.prod.outlook.com (2603:10a6:150:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:12:22 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 02:12:22 +0000
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
Subject: [PATCH v5 net-next 5/9] net: dsa: netc: initialize the group bitmap of ETT and ECT
Date: Thu, 11 Jun 2026 10:14:54 +0800
Message-Id: <20260611021458.2629145-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
References: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10824:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d109bc-a624-49b8-7977-08dec75edfaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|19092799006|6133799003|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	FYZa+JG/KNJPfG30bcP2EAypciovccM2haESvrMDQxI27exCbagDLKLi5KZAboo9IBLaNBQHkF87EI70WqL0E2kNpdxLNfmxEfTZBmI1H2TuOihihmrDjG34iOh4tW/J+XgpY2JNhaEmanJcJgw7mV/saPkCNhqZraKlMoOr6k34dQBydR++8+c3b9+WXKY6ohU6fnSUhsFBLKC84zehehe/tEnVujRbAY+jSXTI1ZWofwLD25qTiviiteck/C/CKDHtke4AntrLtpH2B+9FryDAimTQBvBJzjptPwHSbOptp6cQhtEVgSddg+Lv2Rjtbx88sfZQwm197A8BMrL6BefAMHHPSk8huMFANMW9azgiwCrfi3eCJiImRciyBp9aUADAgKzU8bgnU07FqN+zXkfbDQ1zAamC7Ay8y4TFThVBy+iUcNGQAan1KXgioLyYbf48FPOOIxUPPyzo+4fu54IDI1GSSU0qzlM2k36VNeQD/9s2ivGUfICKvukmg22ql4Kfo/tz3RwG/2Cp3uJbdIupBd1MFSfidGxnQNI142eMw2FGvF99yindLV+SURcxmazFhXdxWixoPUlDCmk8kVyMcashPP2kovyFh+dq5Z1hhhyjmHa3XewwfYD9INGBtsSstLF1FsfG/jKyIi1qJVc73246Phigl4aB8sKP/DZa62Ah0lKU3xdnsw09wF9mG+NhMXN72YcYmmpZpVFSB6qG20GUI2monuEaJwkWvfY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(19092799006)(6133799003)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dOGdBQYXB8cVTEmLehzq8JUlJUB5gP8ol2kVS+NkSH0A575tfPjkVf1kCbIU?=
 =?us-ascii?Q?JkJgX36N9l8T9xL4bs+qg1dnJd7Kr1B2hDxy0WEtju1VqReaL3boHtjXgqCM?=
 =?us-ascii?Q?EmhTIR7stY46AxLRdm+IKbqcV/oD3wQ+VnXCfZXPDwLwl3gtnrHaU3xl8VTG?=
 =?us-ascii?Q?dH50x/sujtDPjqu48YXukrCvlZg9i9SZCRurdVTzpJZAWTXQFAk15RnXG6Xc?=
 =?us-ascii?Q?n1BZvs1bhF6eoRf8/Y7ZzqloWEvDsHwcDkKvv/iC+FjGF3BY5eSOuOioCTvs?=
 =?us-ascii?Q?DXvqB29tBlLwlc8ujT09jCz4cNSxpO2xsL7xExz2gRjOS2FjqNg62w+e2nPi?=
 =?us-ascii?Q?u0RfQz1xc000qE1WMB+qUqSZIbt0JNAaN4udC6as9jyig+I6UQB2R9U6SBUV?=
 =?us-ascii?Q?j4MeP1isUtPI17XCCWsw7AD+YiPE2C7nskP6qIScRpIfTtlacbr1nBpXlJuA?=
 =?us-ascii?Q?D1xof+fQ+ulycjLRefgH38vZgjrVl6SxNOehIpb6W6wKqeyaD13JEtMMQ9kI?=
 =?us-ascii?Q?NsBNDR0IfkHRwaD91F/v+zh8UrqlIJ1SPnGLAZXrj5XtQlCrT4N+1DI/lip6?=
 =?us-ascii?Q?83txfaHcK4rwdDBHo8GyOz6CrG5xeALBIlmm74xPWD+MpDA1SHCBm1XoO6W9?=
 =?us-ascii?Q?Z8ZniI06CAwcaUJ2iQJRhEg5CKs0pEjlQH0UndkzpWb41pBZPcHSbSgJz4hM?=
 =?us-ascii?Q?rnsHAUt4g2hhzCsGLGPihw8bFVydol9qnFc9O4aqCw7IuVoNrI/+1sy0II9B?=
 =?us-ascii?Q?uEIhDSPW8h+YOq+urYKyAXN+Df/K+NWMpnyKtF3iIlo40H6qQBrwETEAO/TM?=
 =?us-ascii?Q?12gcmGREN3fdvu2NM8Bl119kF1YrpCH+xhchsf9OU4ny0SbxqBRzqVXHX2Uc?=
 =?us-ascii?Q?wV0Q03XqwdRQhd3hoMnGdhZHlyoaI7DsLFdcnZ3AT9m+iI3Mm7u/+Luv2kT4?=
 =?us-ascii?Q?Z0ElRjQv2EeEf2Otp6Lffq6RyQSWhtIAPkS38sNcKCYXN1pFk1Q/FuWDnOs1?=
 =?us-ascii?Q?Ugit9UmoLOhGLt9pbsKTcZVSvDH8WVsU4guHefTRL9tNqcsfTudPYgndbOtz?=
 =?us-ascii?Q?h8+DD+dlXM2YC8vKD5nv9iq7V9fN8bS314Nj6e5XS41KrGgkg+V3UGcfoMRN?=
 =?us-ascii?Q?BJmJWdWQ4YY7JHd6YbGalVKt85GJAShXUakVCGrMNDzc/D7iC3IUKLbrNi9F?=
 =?us-ascii?Q?4Weenv7V735DidyxqhTGIzlL99MkPoUhQuyYPDLFARZ+638uWicyU9eC+MRH?=
 =?us-ascii?Q?BOdXAnJ50YRQuigbBKDpu0KHZcDqcQ2tiflrn/TiCF3+gJkKJv/IzpZVlNc9?=
 =?us-ascii?Q?WaulEX8TIm0+PNWl+/2918nS2pWVrGt/UeSSS8f4WhDWcjHMoUyk8+MtyyH7?=
 =?us-ascii?Q?uSxViZi1sWMNQ5EDqiraFmAamGT+aHuFSCG9wzry38zQh7vHWVAqLhSha4TK?=
 =?us-ascii?Q?hgRD+2aIB2/zZma4CSpnYsTQVMKnPlq+YY9zmgFUuwRc3RyximrmfotqXJpR?=
 =?us-ascii?Q?fGVwG7Sw/HtIEkFnmCHnKDH7/tzi+YRrjxxVAYLLZRHCSvxIShBJKGzNMKlv?=
 =?us-ascii?Q?dJzeSPMwSA9FcBdfCTNm0P63bFV8iuJpiQ+6tPOOmYeUIC8NhhJM9Tct7KlN?=
 =?us-ascii?Q?bL4hQQf+Lwt3r6BcvFHXT1IwSo6EQZmK5xh7yFnGDWXPYJtLq6kcKMdnDGYS?=
 =?us-ascii?Q?D3OUakr6I2J0F+FVJm2USzEVmAw80/Je+7dqdK7XMZF2RLH93hEvFnXz0DxW?=
 =?us-ascii?Q?VPetlkL4x1DMM/lsb0WAx1r1gK4yNTyyYUu8DBANGE9LgSiA1g89?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d109bc-a624-49b8-7977-08dec75edfaa
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 02:12:22.7684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoTmnObQ65Bp2BzabfVvjEX9jtD/BHWsbpzdIFWx8hT2eOBxdOhpjTuD6KDzQ93FwV/f74BQagiPhx/KDE9Z45FQGoeG/UshVsAYm2EQtbCtqo/s0FpNvUHPL3ZdOPum
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10824
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297886-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A00D66DC87

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



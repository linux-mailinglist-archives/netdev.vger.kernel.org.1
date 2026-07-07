Return-Path: <netdev+bounces-305283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FYBGBN6ZTGqdmwEAu9opvQ
	(envelope-from <netdev+bounces-305283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:17:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD764717DD2
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:17:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=cKN2YUYh;
	dmarc=pass (policy=reject) header.from=altera.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305283-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305283-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D12F306EF26
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717F23A05C2;
	Tue,  7 Jul 2026 06:13:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF37739A07C;
	Tue,  7 Jul 2026 06:13:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404801; cv=fail; b=K+VRyzkq2U+3mMFNWkCeekIDb4Wm6aw0czI314Dq8xEgvnzMXWRXYbwDOFJWQtq0Gfkb1DhwCfWPzbBl8z/s6tBbAK4dIQZfTnci4VX7ktdtOLjOHNsXUwY5lLHPIjvoekyY/2oOb8l2qCnaI1YiO8AXdXgkR7zGUqhlhZ4xyrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404801; c=relaxed/simple;
	bh=zNS8lsZ9n+L6P5YcqE2cZiMOzjcWIfpgUS1My1ZiI4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nViUOi7CDhTaPt63bp3WJSi3rRCcZgmOS79eTRdp/XNpZ+2RDEjDQfQhJw5pK2q40rj6rJ+kLe1ZMhMK7c+z2vNfseJVfhUie4SYErLlDI/DwEDtwDZ2krls6JsvhWXT/r6cxT8eTi9y47VhgvmQaiGUyv1eV+yQISP3j8KjYsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cKN2YUYh; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfmKjx1cBESd5OpsVgcRRZraqC46z3UKvmF9hGKMfbBy9LPOtlxVJf5LbCmYDKnHuPXPvoG6t16/0XkPDM18HDWhhGdkrk74MU6xqNkNAehHPQLMPg8ETqMVwn4tYssLEfZqtzdoFNPBr+ilk/EzdxiPKxXXar2PqJM4Kr51ls4U6Qu/QvGvEfSgzAGxXqSAAY86eScBgWrBXMfz2E7lBvqq1MJaX5xKqDLEP8nlxarOwyjxaMPHVMg/UvCZ009GBwJzEnAzmRsti8EIfKc44KDqCpoNuK2CZm+lbGVcru9u7DAIMD/eA2kDFn8pqPThw1zvzzzXPOG66YZ3JPnTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+fq76Iai5HrJ1Y5CXL9YqHwUhtsXRPvK3GwRn7wZJw=;
 b=uRl7v2iEfXFtuDB0u5J3qZYuummoljfRNoyY5nkOtl8SCPpv/VThZJMh8I79Z9z9RYmecLSxP9+HVlOY//Sr6hZursFVZ13aNB2TH3XHQjTsQSzc7jl6PSHrMEAh4K8EhWCJODEU2E8gS4Eg/TKLke4it9B39whYKl2HjwUwMO9Uk5lGpaPbREHX+DoS/dbiVKrn9MBiy/zlBUTG9x/mU15hSamTRkKOBtgtkk1k3kmDfR6ZmglcXz8WUAjOefigYz9SEj8ZOf5W7xHR6yZb+f66wE65qpNH/dwZ6n/LLWfkdFv4M9/BaiDdvW2Mp4Rx1hgrmyWUdpaylHqAgkoBAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+fq76Iai5HrJ1Y5CXL9YqHwUhtsXRPvK3GwRn7wZJw=;
 b=cKN2YUYhqhlxoqiXzhWuOujxR8G/0K1rPKkohD0zXZLaQlPeGKq6SJ8e7UjGMnXSQf/kiAqeNeor3VX4v23Z7035OMl4Ily9nNLLkMUrU4MFm2UQJljpivjGmjhTfcQWgKlwnJHVDMv4tFseo0DMjqmvF/XXxDspV7D2Y+F7nedupNl5Dui1QaOJhDXpF1uRtkEnBmdd63ocQNd7DefK1y6gq7xHdx8e0XXPDqE2FGkRnoPR9QKwQi3PRQUkUn5CzdsPsB1i1BBknoOsvo3FLWcoX0+MJ8MAq63MRP7QfYlYmbBN6007b/DoQ2+Vn2IqeV3g+ziiz0sXtqniEDWnfw==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB6598.namprd03.prod.outlook.com (2603:10b6:a03:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 06:13:09 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 06:13:09 +0000
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
Subject: [PATCH v2 3/4] dt-bindings: net: altr,socfpga-stmmac: Add altr,socfpga-stmmac-agilex5-tsn compatible
Date: Mon,  6 Jul 2026 23:13:04 -0700
Message-ID: <20260707061305.27580-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260707061305.27580-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260707061305.27580-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SJ0PR03MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d1e211-c0ce-4d1f-c44b-08dedbeed0eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	thJT1wqczeagNHHjU3iR1aouIsSsx5sQdhqf5+OmwuyOHVFF6yvT5MtKTplDy9clbA7iqZBjCIeWR/VFFihHZGj6QQ6aC/BT/peMswhscG0AXvLfRUy6geTmj8CE78jAg+GZXNpR847XJmGnVKBA2LCiCSCB9NK9Z6LGlFocabDVelGXLzp16K8wVT8qniSfX+rByc+cNCUtNr789HCTRGDcQWZ+aATKZSvTJccWWDyKhtKZ0uWTmoRFZ92IczUpmLEfx55LsL1nmTBM14+E1ZUTf8WM+DpjfAO6AW6cnLP7xmbvvjsdu3DN1/Qfk3ot4Tlp9wGD77Ai1Lq0cAwBNVbZPoAQ6NFIuwlNfN9J90PYH8XJqOGx/zrirCD4CZtMsO3E7FDTRsj5dl84bgTcH539qIs0/2yOKWNDHMK8HeZ9hBV094BZ/7FO4S3S/4C9PSauuCiCpP+Jik6XXLPIyJ0WfgWt67xihVpxVf+augcW32ghD/SIy6j1S/PqhEjwAVDmNhxULXAbdYlbrABautepd3VNuXhweVeMFrg5Cun84JUszmlNplo4+OFwqvhQYVkmukxmXuOhVaBFkAFBaTufgOV7yu05a8T5Oc8zpo2gkegeQctRjEWl28TJ3EQU2FZKUqnPrUdlE4y7yBZx2D0NYiBsZDRYGUwr2c5trwE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J4M3uN0hUziAfkg9VZSb3cICXyIxGvTcyTThhSiUW5bGzp3HH8bxiVg4+UW5?=
 =?us-ascii?Q?Iheb+XDbm01lJ+GPgW/BCHNCx5Fgh9w8mMXuNkVn08K/KiJZFM86IuHHOxKH?=
 =?us-ascii?Q?KH3ONdwCm3WR/ZimnVyEdt9T73RZ5cRP3ZAYTD8YFDkSUpprf8bbZ7PUTv0p?=
 =?us-ascii?Q?3MrMzlFbw6GiPSGP8ySX88bQTq6iCyXhUY4uYPOjbcVK+qPXxA2XtANeReMV?=
 =?us-ascii?Q?BiEGc6InZ0M4OtAazbtSy/W82zQEpcCVTNKty07qbfzhwH9qmxagOYLSdzWm?=
 =?us-ascii?Q?yj+QeVlVfT/oF1qWX249tDCePKgDqwv7I3u3SbJOPTGVSWRYRk/0PBxJT796?=
 =?us-ascii?Q?ftAr2RsObJ55xIT5IscXLdOhMvdYh4Z8+s/NIQElnvsFQuY9Nm2VIxBLhx40?=
 =?us-ascii?Q?leg4dL9bfOWf6ct+/8HxArtFMnk4FhxBPowdP0wj4kBtMLImwc7U/JGZCqX5?=
 =?us-ascii?Q?1j6GmtMcm+g0Rnc5fgs7fJDE6bmtKYsdQYYnHgAu1Aon8plMqhx1Z6od7uUZ?=
 =?us-ascii?Q?IJxGxA2E5cO0+OeZ7N2HLwyKdRKnK806tohIBCjKgwCeHO224Cy476ISL11w?=
 =?us-ascii?Q?6jvXoC6b+qxxwrYvQCnugVp1cMwyxBCENx+XHExtDeDQ+xUTE5IsRUpA/F41?=
 =?us-ascii?Q?fgydCQMOKpIJe9iKRS7yAZYS3fWJJPZI2mO7MnUAG8J95F/YK7ON701Wgsmv?=
 =?us-ascii?Q?Flz168oCnpKLzIYyb5rUggAqDRKOpYLOITorW01xYErxdrVZ0pqe0yPJPlXt?=
 =?us-ascii?Q?WEwU5QGeCMaHHOnhP4uSkoLmg4B/jtqiG8U3zoJI1I/wvSVKY/pZ/Fxio+vN?=
 =?us-ascii?Q?+tGlOheHUDEUIVOu9vCnw9Zc5POSAWsHqo0c35VC1JiyW1oySRBLGHI9iqdi?=
 =?us-ascii?Q?Ppfx682KOQP9hOLBjX6dKrbxlusCdMGPOvWxBYgVFLDojI3e9jQjhygVsw3I?=
 =?us-ascii?Q?sOtKrybTjg8fzK2OMOtH4bjXs8a/D4O2AY91NfEZOpV4tRkzhkaWzMzdLH2B?=
 =?us-ascii?Q?H0Huq5ti3KgWocAHAu245jJaDcc5Q8/sCQWgDImOl8+XfW3yStp4QhScUyFv?=
 =?us-ascii?Q?BDnuoVeNnWoPTsW1T6f/kmsc8qy7Cr9H5IOmQJfWaUsh//ntwU0Y2+JKb0uz?=
 =?us-ascii?Q?IC1s6WOW2Z0ujMmnEvw4VKLnu0YBXm5GbFBKdcHUBB6ayagQxaqXf25E/q4T?=
 =?us-ascii?Q?HgJWgvK0JrRMIF2uUEp9dsK/gB/4jBmRY+mJEhrWkyjdK72+IjkqNAKuM7zd?=
 =?us-ascii?Q?eX/93LctMKdJFb2bz48v6YbksDziSB61OE+QPZw4skwN0OsGfb14wZ8zV9od?=
 =?us-ascii?Q?53txB84iWd2EgHO59SvG4rc+6HeJasemvG3pVO25X/LdyeRInhcKViWSS1Op?=
 =?us-ascii?Q?60bQNa91c/k52CXpaeMe0ktiHvePSRf0SEqKiNSKPwQk8pAOLHvPMrmmyO8x?=
 =?us-ascii?Q?lKJLICYKLu0VXwylmo1v+3X6oVvXMC1fBYqq056AkfhkdqPhCdQEKPvVdKEA?=
 =?us-ascii?Q?okHrj1QHZAVEW/Ff8OXq3zvfk8BPmXXeD87/ZZ8j04CTLtVdq5gADTlr4wj8?=
 =?us-ascii?Q?7HXa8/0F6vl4xB2hDCSAegrpIbVosyHEoKbV3lwz6xPDn1+0hVxHycNQIVBf?=
 =?us-ascii?Q?CnuLuCITZNQXqAGNjt2uVsSGf4aUVRz+/xOhqiFCYEGQBvIATo3/e2eJPAEy?=
 =?us-ascii?Q?sZO77Tnp0B2gqfLq6MXlknkHD7lW342g5jKj1IYwLHRrBwOVNo3X/E4AwEke?=
 =?us-ascii?Q?CqE2phQ6z0MQ6CAjqfENRbx6XrypZ9LfnC+ap69vLLjtPF/8QDGIjhgQdsqq?=
X-MS-Exchange-AntiSpam-MessageData-1: 54FHJXscU38aNA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d1e211-c0ce-4d1f-c44b-08dedbeed0eb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:13:08.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmwDZlBhMmSRolNluyv9Ld5R6VGKtbD3CX+s74xYJMyalJYO4XJSk9AUCjN86nxUbAaPQiLzuiZTcpPklEKMLZw7hcS5+dKX8iRaN2ZXqiWdAH0lwuSkClN1DU+FKE37fbWWmZldOdYM+AxGkxWVKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6598
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305283-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:from_mime,altera.com:email,altera.com:mid,altera.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD764717DD2

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
implemented as FPGA soft IP between gmac1 and its PHY. This converter
provides the RGMII TX/RX clock delays. Document a new compatible string
for this MAC variant so the driver can detect it and configure the
interface accordingly.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index 63084f762373..81f030986fa3 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -24,6 +24,7 @@ select:
           - altr,socfpga-stmmac
           - altr,socfpga-stmmac-a10-s10
           - altr,socfpga-stmmac-agilex5
+          - altr,socfpga-stmmac-agilex5-tsn
 
   required:
     - compatible
@@ -46,6 +47,10 @@ properties:
       - items:
           - const: altr,socfpga-stmmac-agilex5
           - const: snps,dwxgmac-2.10
+      - items:
+          - const: altr,socfpga-stmmac-agilex5-tsn
+          - const: altr,socfpga-stmmac-agilex5
+          - const: snps,dwxgmac-2.10
 
   clocks:
     minItems: 1
-- 
2.43.7



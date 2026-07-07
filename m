Return-Path: <netdev+bounces-305280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YyHRMYWZTGqMmwEAu9opvQ
	(envelope-from <netdev+bounces-305280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:15:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB023717DA4
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:15:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=WIpqWRrx;
	dmarc=pass (policy=reject) header.from=altera.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305280-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305280-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E32D3024E2B
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1E38AC68;
	Tue,  7 Jul 2026 06:13:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3828538837B;
	Tue,  7 Jul 2026 06:13:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404794; cv=fail; b=pAGxi5fe5RGH8UTI9+Yr466MJTH8jDoUGWPzLD6aJhP2dZqTa9rgpTPavC2vrAIPRZrvbL1HDXGlToItt0Mmk0fBMgylhgqoP9Vat28+12bl70qvkkubA9P2eWk4qRF8plJA/pWJNNN5HhE2bOxKwvuHQt/B237k4P/1TSmAAg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404794; c=relaxed/simple;
	bh=IdcL+iceRsJua7mYODOLgYQLx11hQeo5Zgr/8/AEzY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBzOIpozzOWHehCt6Vl943GgjXfjEKguaM1x6tPox+hPqpZqW1fYo0V8HrBmYFJDZxVEoikci6puopaebY/EJt0RUSgrOZwqO/HFVVeZeq7D1MkW5h+jh1BKceMnFLM7arFLnhJvqy8xNk2fArThdulGqJO3VMndZanup/jv9jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=WIpqWRrx; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnBFLCcRU2DbrYgtEhGhiPDUMGGMEvrYCYMbqcfNfjAcp0qfQbgNPVjRXb4V2qk1zO9YIKQqxJLjoSVqbvpEanZceHM+PL1saG+t7Un8SpLkpa3vuoE8s6tFyOfvmra5tU82PMr3UMpxhD0p7yHfXxGy99oFslX0hhNxI6bo0mRIGChV+NGfU0ym6X0eIk6IOmgIpdB6Y1XOu3QyD3hVWd9ftkj7WG3dmcf5L/B7c8sIwVnMHfbjWyGXw343lIRJgXaCoU4ApTZdtlvlNz0svDXtyub+wNZJmJ6tlo6CplAgUQs0g5kocjnU/evpTsUA44/ATaEunz+4ZaprnYxY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYCGM4IpynHhM/kGRQbb1p+L78b3QMluTlulBWLt01g=;
 b=oDuNCoNx9oIk5HucplZYEBgeR3rTMHKWaW+Zst8rZG0HtvLCaFlIyrQtdTWfhwXm119dpsB4y7gZGQC0hCcldaKk0Ij2qpm8Or27GZTa9J7ZqFyuH/yE3lE36hCPl74awwR1IfRATUrcdmjaJcNsLy4nYz6icFukREtCcU6fYSZ6bpUDpWG4t5VCwyn/eagyc+VUFSexbA3Dr0P3yQl/0cjdWRIwovDiss+D7p/0f//TJmly3WJIFBEfBeaOwEDSfFslo55/bvufmnOdxIzs1YnWLqVGW87GITLp3sSnpIWikUQ3FHSzlHcZizNAjgS9UOlQIbBQb/Lj+yirZyub3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYCGM4IpynHhM/kGRQbb1p+L78b3QMluTlulBWLt01g=;
 b=WIpqWRrxoTAzGREhT9ANaW5xBLgLYG0El/PlPpHmFTwN5lYvTRZoFjkCSuHyVjGpQPLXlXfAvNPwWBR5ac5sO2vvBPzN5KaRSQFZYhAvDh/uB36YfDMHF2KsCBmTLZDO6NC7yYyVu3ZqS4Y08RtpLkoK1EWKx90JRxbVYexhvRy+6fSPMEU9y2zyyknOSqweQndDvsulw8U/0cZ25IuCVvbNdZuCK4/EgVrmwdSPoFqaUlxXrNycnbCnZe6da4bJDFQbz+Qc0KEk+iEj5qFFAHBMkSv0Unyoa2CMTs8yjr1Y3wmAJ4Zn0Lovs0tX3csukvdh2rPyw/gIOsnTBq/i3Q==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB6598.namprd03.prod.outlook.com (2603:10b6:a03:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 06:13:08 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 06:13:08 +0000
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
Subject: [PATCH v2 1/4] dt-bindings: arm: altera: Add Agilex5 SoCDK TSN Config2 board
Date: Mon,  6 Jul 2026 23:13:02 -0700
Message-ID: <20260707061305.27580-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6356f519-116c-48b9-3ff1-08dedbeed05f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	+bYzDCW0V4Wf/KTOsiRpeqr+Me6wbw5H5DJqrLXJxL4uBn/GG5tiYPazPDe3k7ThZ+YIo8XP3ng1rjr19+beWvBQAWzoQSwg4tJQ4wOsUjaTHwpiC7e1JZw9sFajR7QOX6Zcrczmvs5AThc4eCGBn3YVgcGUGm3GkjU+ZJksGQ8WzMUP1H2YdbSyN4M1HGeYTODhIwK5N5huHxI87h1oO1vKDlcxJQ7cQcQzy8uTCx/ip+0lxPpTgRLP+ncbJUgSQuAbb4JhSxf03DSCJ0a+elTWe+GyK+DP8xKhGLuPEhGWroylz6sAc3tok5K0/UZCr1/uHWJcyHbD+JRzxQPJDIHPYMHEJaRFuDbdT9NubnucvF++k06qt3PaBKK6h+NRXZHFsX30BfytoArxNz1IKQIaBnEIzSXqNjc6uYutDgAUoAvBRPpgT9Cu8YK4LxIhi3eNaBoRm8NnP4JGBhFpcmGXobL9nUq34VdPdepD931Z3iGdtaAOhRafPXcSN3XMGhF1R35gudsgk4qXwu1A+Zr4LCY7EJWKa05EdgbPWga+qDJCHbL7gGUHv8B46rVGI2fLEtpITFgmZEanbsDd+2tHs7KwMl71fx9Oj60EUrMDoDlpzbyjQbASMvVgYpEQ9hcBwVhhr53AD/AebuM/I5/tlVsIR5gafeXPUb/Fr8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AHAdGSKwd8bSWYA75k7RmgI6oDaxFNnD+jOyypjsJekHH4XH3AYCfSSwtb6n?=
 =?us-ascii?Q?TksNdHHN3PST2QUsjN05+BTX81xEApS//wd20ZGVDk0tVVlB7epLSgHiUhRc?=
 =?us-ascii?Q?LfRoX5PVBjcC3Ur2JKcy+Lj0zSa34MIGRAxdQIQH/Sxt4Rk9eumFeh23iBf9?=
 =?us-ascii?Q?ah2wLpS0nbZTTqQb7wv+cS9HYEHvr+l+BGFh3NClK8gJyFlG5nhlKlmDPogH?=
 =?us-ascii?Q?CqGG3i+tZKyZzsV/ni3fTHS2WMs2v3Lq9bpN+Puoweq88Miuu1+1ALsw1ynd?=
 =?us-ascii?Q?IJc5pnBe5/iOiqVGvoIqJWNZZr+S3kseDOV3q4nNnoMlOrkWUldOMBmTzh9c?=
 =?us-ascii?Q?AMOTgxr5Ons7L6hjDFm0denQp3uBRzQzfIMC5CpAAXdASuJacrf6b/Dx1rTZ?=
 =?us-ascii?Q?Hh0MuUzkR6U8XHQWJ5MHdN3rSJlgPVVzfEoARD18nQVlOj/1H7LTLoo3X49m?=
 =?us-ascii?Q?8a9MxIGBIgThjNLccBugt7NdgxVmT0x6Muoi8QMDtaBDLchccKP87Hl2hnJI?=
 =?us-ascii?Q?R6XS5d8dmcB+8g89449cbFaHSOOLPLJeBF5N38RDczy3mFnqR/WozjKKdRpm?=
 =?us-ascii?Q?v2fOZQbn6iz9ow9PjKGHG/DKQjqwhp/JpghtKL7hR0cguNgWW3hOWFnTQfEA?=
 =?us-ascii?Q?Axbcgj4U9qTuqDI4heuaFAfVwSuuZev5n7bPkMc/FRLCt0HCQ0hHvq5rD9c5?=
 =?us-ascii?Q?vSKznp6MCNBeNmwBgiX6p+Uhc8wlvq4/xSdwLqPByVb28znSRu4vjtySymuD?=
 =?us-ascii?Q?gmzHEIDMl6PnIMBLFbl2yghdgQbHPzot+H3fjeAeXTwR7Z1fqdO0Ouv899Jm?=
 =?us-ascii?Q?8M1i8W8WHh9+MViHQiVlTxjlti9sECoKNYvXP7LfBFsWNeFTOoXFIvm2z6sr?=
 =?us-ascii?Q?POdDbGFPD4Pn2nPrfSWPMI46l2AVLOiQBGGLDACgUSV7M+To+F2Jmtr8IzeP?=
 =?us-ascii?Q?1C0d6YaYFQebU6O/uK3PHyb5BE3g0j8FcKS8Qac9Q9IJAzSUa7u+FgKfzHfA?=
 =?us-ascii?Q?UAiw4CGhY6Mi4SiWBWfJHTqKxOr+w07iRvY5Nvm58WsDvL/GUybQ5XlbQG0Q?=
 =?us-ascii?Q?9Mycay7Ec5dqbNG0Zx5UKQAT5R6MR52il+AMS6kK9sdJF3CYwWdHlgfZBqkM?=
 =?us-ascii?Q?bCPwSzApzEkS58r8i3XzMApr7SLDNiK32tkfDQEdCGu8IpDWTRwEasFpd/P0?=
 =?us-ascii?Q?TL30vi1n1NX7i9T1N/0i31tOkE4lXsBQf09nPA0ZnLoww7jnk47XNOT/+HPI?=
 =?us-ascii?Q?zuZgKh2b9zsNboXZsIs9uh7KULu5r1BIbxDoeVnzIdolAkjTF7MDCWaSonFx?=
 =?us-ascii?Q?RcJJ+nrUhsGZJMYbRQ+K1z+ZVmE6HjjLDZQgshukcyxFuC4ybFONGdzNxm+f?=
 =?us-ascii?Q?qbYcFGjpMlW0i+v4AcGTTCgFgiHgatgvTo8w9otmbcwrJHXyDTPalUVJTuka?=
 =?us-ascii?Q?rdUJ7bQSVK8T0W0fSsVFicXKEja5xPv3jiMhHpy567UAYQy+zCEAd6ctqhF9?=
 =?us-ascii?Q?F6qIwlkNLJ4kxOpVf0cqFhX1FRw9ZcXWbOnDti8Z3yBB1QYmPXWmRXPMKbmY?=
 =?us-ascii?Q?xeGXMHfO1ZKVKI767vNF3IzhsinfhJFIN9meeYy+Iz4xqULdwkOGn9HjLC8m?=
 =?us-ascii?Q?Yj+gekidKWJGPf4lfVKQKyT4dfpLvI2A5/HF/mgPUrP7w+mSVORmrREx14sl?=
 =?us-ascii?Q?Gtwk3fP2CwonhH1JROfN4p7MUpkr9JsdmGmxylXwpEtAKUbrcXzGHjYrNL+0?=
 =?us-ascii?Q?sz6iWv+rtmwnWmAi+be1bNYAtZssw85MdqM0u1zwjhQ3HdrHskk5xNmDkSJX?=
X-MS-Exchange-AntiSpam-MessageData-1: A9LEETj7C0p6ew==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6356f519-116c-48b9-3ff1-08dedbeed05f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:13:07.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvGTwNCMpCyd+d/muU8IpqzYNL8C7LJ1AFEJ5/7oXlWzorIeHZeBh8RYRoMB+wN2gLMSJD4fLD9meWU9e32rnAVQE7eKNcC4sJWBjgB6N3FfEtq+ZAg03k2octbgOGB44z3/PCUqPVJzvz5Ps2dA6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6598
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305280-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:from_mime,altera.com:email,altera.com:mid,altera.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB023717DA4

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Add compatible string for the Intel SoCFPGA Agilex5 SoCDK TSN Config2
board variant. This board enables gmac1 as a TSN port with an FPGA
GMII-to-RGMII converter providing the RGMII clock delays.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 3030cf46fe74..e431469a7175 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -114,6 +114,7 @@ properties:
               - intel,socfpga-agilex5-socdk-debug
               - intel,socfpga-agilex5-socdk-modular
               - intel,socfpga-agilex5-socdk-nand
+              - intel,socfpga-agilex5-socdk-tsn-cfg2
           - const: intel,socfpga-agilex5
 
       - description: Agilex72 boards
-- 
2.43.7



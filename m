Return-Path: <netdev+bounces-282800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCxvOBA982kGywEAu9opvQ
	(envelope-from <netdev+bounces-282800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:29:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 653904A2245
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17A463087C45
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900C73FFAA5;
	Thu, 30 Apr 2026 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="Dr40klQI";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="Dr40klQI"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023103.outbound.protection.outlook.com [52.101.72.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEEC3FE640;
	Thu, 30 Apr 2026 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.103
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547876; cv=fail; b=C9SrSF8NyraQr2SqkF1vzBPjxmWcKRoIzA1ph+/Jm+Bt3pquV6gevl98/y3Z+DaL7AdRXqMEkbUhZ3mEodNcgVDc4aQh4t1YpwLwNzSZw8cH0USuAU669ik04MGvqbckkyXSnIOwYs8dFIf9yb9XspebGEmDZ6ntmHUEzkfCgxI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547876; c=relaxed/simple;
	bh=eqtTyZi7axFq4BRkihtrQdjuk6Ocf90arkERygX30AY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOS3OQM+kXxcR5EU/Y+33hp2fpR9x2AsiljEGZJnKXk4BBdUYoYNyLHiwLGHQs/3hZimwzb4wd+m69z22xWrhYyzvX31iEsqok6zy1C3zQ56BhCTFYE0bxI7u5PoNjMxie2ZjVVQPqFWuyeaCQvoxgeON6RgOxZiqrhpYT2sdXk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=Dr40klQI; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=Dr40klQI; arc=fail smtp.client-ip=52.101.72.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OG56vtALCmQYPbVesvrpdGgcq9+Jb8T1g+hWC/EcID6c78uSZCME12iI5HMCgWYmMA8WHXETsCa/nk1oFE4K4kG3qa7MBGG7zr7OfZsO69mwygdWREZVj6WlDODxBnWH4fmMGJSGSJDBkb3YWyOSqdZcGGDzizQCra+b9ep3gaGaGTv4BGRLArj/k7Bj5tDsGclSNivg0+hoxNW0WZgM1r0IAnEMRBX1k7qq+FXYRAE1kwg2OIVGbTPDDlr9NfcqUoYTIyRB4zMKF/uSSAXFeEkGEyt4iSudjrhXbOVtY/5zmYZOhuBNWYeQdL+HsqWEE8afshL+1eFS1ugr2bnxQA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqtTyZi7axFq4BRkihtrQdjuk6Ocf90arkERygX30AY=;
 b=xeDEH0V0fwRIsqkXtaquh52T709VqR5/yF/KtmGd+HfPDNT6yK2c659dSFM2/KglfzXPHENCa1r9ViWSdXSa2j/V1L/M+6kdJIFCfNjEalgR+fcZ1kjIQVWeLP6j2I+LSmprsyPNK7GrjZCo1+ZWibXXEpX1o02HsqIQa5Zj7D6kJbtLWUr94VD/zmupToJi3MgIeamrlaaT/c2uhSXpzDbMziiwQDlFWXZLb9epmEr6ng71JPRB4L4x2sZNCFWkOvcFcJebJ6iUy5QxQ8BB3lYuaUOka7UKNxLZvwWQrp0hjANyUOdmlXASvmKQmZ+aG9UdhigPtPUddv8pLvFxyg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=davemloft.net smtp.mailfrom=solid-run.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=solid-run.com] dkim=[1,1,header.d=solid-run.com]
 dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqtTyZi7axFq4BRkihtrQdjuk6Ocf90arkERygX30AY=;
 b=Dr40klQIJyX5QZ6p5/H1q+HyYBc1cCDvV5TMctKOlU/qSTB2GYnCEm/gM3s0qKyamXvWC7+w40a7oJQ2I4Yn3AtpOSITUp2476LAsW7xJr0tIbuJ2Vy1BpvqPql0yDOgK3/bIhgRgL7zO/EdlfHqSNaHTU612eVVY9E6MtfgLI6S2V6kzhkOR0/LQW9vJhumRemeR/tfXeIXvh5YNGCyGFE+69MegOW9fbMPTKa3u/8+tQMPy56yHjvCFESGvpULzTvxsiYgv9NhB6f6OQpi5z5Ua7NB+qnEUhgQpmw354YjYxarVHgsLTXD20NQw6+W/YLN8phh/gTx7BGCbkdAWQ==
Received: from AS4P190CA0043.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::14)
 by DB8PR04MB6793.eurprd04.prod.outlook.com (2603:10a6:10:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:17:47 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::34) by AS4P190CA0043.outlook.office365.com
 (2603:10a6:20b:5d1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 11:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 11:17:45 +0000
Received: from emails-9989122-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-243.eu-west-1.compute.internal [10.20.5.243])
	by mta-outgoing-dlp-291-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 508D0806FA;
	Thu, 30 Apr 2026 11:17:45 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Apr 30 11:17:38 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rF/W3cgFLRIQZIILM7w8lhEg3X217mWutxeJZcU74XUcQb6WR2GCAPen0oRDPIJ/pSbCQKChTCoJiO7pKSHrAh8sMS4yZr6tBhQyI8KchZzObBNXeB8vznqDuualR2e/ffgGRCBEPytA5EDCJVBegs1SUgJtTMFLGkhy4FvzJUTeb+gDg0c3I5UfizKtLJwN05muyj5m3PhWkrM8PuOttZkR7bLiEJdj8nEhLL5kFnDY4NBFgHvsj/tuTCC3WogLdlwrt32OiQQT/zVWKfGwLwBWYtmqZARCQT403H/FK6INYUsAwS+CiL3j86JLJuAmsU8H4J1Tj5UldzjsddAHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqtTyZi7axFq4BRkihtrQdjuk6Ocf90arkERygX30AY=;
 b=PEEgRy1p3TFok7ccQbaqe/iWa+zID8GmztdgpUDjuPauaKIx2NAd5mZGOQrd/cmzI8hkgxDt1eBw1fSvOqI8euGvzmwFGqkkaO3phSImDKQL7pbGRuCdOFXV3CLsq//e9gLQH4qdy0WbT08Q1u0McOpsGzO54J+XlCCVHyLwRAfBQnpNWsh6Xe1EW4uRG4o/fFK6xj6cPc2gLmdPepOhREHYu6z2KsoLZfc9ZcwGTS1Wj7yLa61057QHwGpovLnIM61PV7XOokXJDJPWWpui9tA2kYwkQHBaV31FggkUouDQcrgJizsM5+15JLXaXWR0sx1G8mggPwNnTh9W4SEecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqtTyZi7axFq4BRkihtrQdjuk6Ocf90arkERygX30AY=;
 b=Dr40klQIJyX5QZ6p5/H1q+HyYBc1cCDvV5TMctKOlU/qSTB2GYnCEm/gM3s0qKyamXvWC7+w40a7oJQ2I4Yn3AtpOSITUp2476LAsW7xJr0tIbuJ2Vy1BpvqPql0yDOgK3/bIhgRgL7zO/EdlfHqSNaHTU612eVVY9E6MtfgLI6S2V6kzhkOR0/LQW9vJhumRemeR/tfXeIXvh5YNGCyGFE+69MegOW9fbMPTKa3u/8+tQMPy56yHjvCFESGvpULzTvxsiYgv9NhB6f6OQpi5z5Ua7NB+qnEUhgQpmw354YjYxarVHgsLTXD20NQw6+W/YLN8phh/gTx7BGCbkdAWQ==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by PA4PR04MB9391.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:17:36 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%2]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 11:17:36 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Frank Li
	<Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Yazan Shhady <yazan.shhady@solid-run.com>, Mikhail
 Anikin <mikhail.anikin@solid-run.com>, Alexander Dahl <ada@thorsis.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Thread-Index: AQHcyB1El0M7TqUrrEi06prfauJkr7XWrZoAgCDoD4A=
Date: Thu, 30 Apr 2026 11:17:36 +0000
Message-ID: <bd2e73c5-2e61-4ea1-ab3b-42a6573b31f8@solid-run.com>
References: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
 <20260409-imx8dxl-sr-som-v2-3-83ff20629ba0@solid-run.com>
 <8efbafe3-0a8a-4005-960c-e8fe62cee719@lunn.ch>
In-Reply-To: <8efbafe3-0a8a-4005-960c-e8fe62cee719@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|PA4PR04MB9391:EE_|AMS0EPF000001AA:EE_|DB8PR04MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: b49b4027-27b2-478c-77b0-08dea6aa1ad0
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|22082099003|56012099003|18002099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 kwOHh2ES9/r4vvtEP1l97NDXz76VZZCjeFucTH4dMuALzn/wwwVSBvzAmBn0WOlXKTuwz5eXjfYZty18xd6Kg8soi4M7nbSwGaRiD3bF32gnm+W8fkkz5u+zzkL4PYW7Xfs2yIxJ09oCOTp47WoO4DUuCGNhcDOlfiRDEQTC++rC7iNPJCETpAM46c3LvGl5+PmrtaWYtbvGsMbYPxS1feSnbdWwma7vWlIc3K9l3h/PCn/W81meliVQJNs/nHm8acTVORPzPEa/4ueaseYo6ql2AdCttY3yRkKQRHmjLwYiibL+0A4cyMGuhXYfsAJznVYmTIi8wMh1UHDEFZXvx53lJvWfqvKjPFDm/vRg/zn6nYWyiua+6phAtRs1Kh5kvgOPkdDo1hl++eIABEjY2JMuvJZ6DzNv1ViAW4MboaAIwNZl+U9/eDLRm3F/syNTfL+TcG3+wh1nWrwtIXxArPVOiT5ErDQyDQj4HJQxNMtn5vrM4wX59puN0Vom1y8JO93oT0DDuKUsA96kaLTtIEUEa8nzwCCw3vFge5Ltql8NAY6QUjyRfmF0g7EWMtzZ0Xzy0DopSNdrj5Y/Ks2aXZSX/aGR8Z+71ndTSIVDRpGe+RM6UzQNrrVafP1QgCmNhcB1HGbWE0DKU4oKYWnPczTMyWFK1uB27NO+L95HbLXTMKwr9HVaGaNx8GC5coNb6/5/Wxa/gYN9I1hp2X/Gkp4ZG+SOHoMpx33p1fAcZZhnJiAO73tZrp9fNTgpgg6LtwXqEv359jQznfGoEy/aTSCJrSZxrL19BBJx4vP2Slw=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9146AD6B2CF9D4B9A4002F390EEB222@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 PuLsGFZ9reHz5eyVa1PUJSSrNjpaoC/q8pV++uhGhrE/CLMJ3FFMUj9LkrkToFNfehQdOG3RBtyUG9jDbmoPLcGspar7ivMfQvXh6i/6arhzY5kHymjY4UMdP8jqauX0/pVY4sfWDG35wJ0yAf5t79rmN2X0iXTb4YR+dFNSOEPMFLrNjqBd11rjAu83BzUOmCgKDWJA1oDyTw4ZN8irauNVwwOZ8zXYphpDJxCNgGFKAfTNXfzHKUT/ppqd7v1b75o27ZjiR3z+5FHgYtMRvNx0kxHd+tFuuugYcyLO45aa3xWyA1yMMMsX0vT24y+Ay2MDXjuoICVrMR+Ex7AiPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-6.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: da73c6a5a8674d58b33638a1fafcbbb4:solidrun,office365_emails,sent,inline:799b5ba2f54d29e9ffdb0c663810b71a
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	51c5e303-ecac-49d9-c6d9-08dea6aa152d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|36860700016|82310400026|14060799003|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	COxV99e3F7mZjm23M/IuVrnRPaaOmNGirrRXRbCNOIHw0N5V5CX13jAIDsMTkwiTM/NOlW9sw0naAa07tycEdR+3K4oAN6GKuEE9ybKetwOav2JZTtcPQpE+qD9Mn1AlA5gFaLiYW+qhnMBbv6w0Pap89tPex80WZ2IL7lP/jUrqZWVq0tAtXnH0ww4c9AjMd7gd0P1qPqdHUCgTFS7QKI9mOP1viqjGmVgrcACYBm81W6oGczWFwhtRbmMIuwefhnzR7Iu4zGAlFclUsvSlUNp10CVvAaSmvXNZxNToyLPTRaIhFwd/SLRm+6k13AUyYqvYU6ic9XL4XDVhW/i/sadBKfVpVASmoDGRjJLuAZt5tw0r50K4ZvDz2nUDBQapCQJJl7/ofxs+UJfU6qQ6chkqTLXUTG3xraQkUHpQ52r0juT6WqVwCAKsSlrGySWswSscmP/M7Vt+80OL7IgcjGXhAjyxmAKuSqWHvzCMOrlQ2+jvOFXoZPNJw250HXSAUZsfCI/AIIC+fVOCZhtUpe0s37coRQJ2qsiS0DMp9oKLTYYOULHU4ey356qD1xGDJGLv/jOykWmsLF5UgwdRCEH7H2bnnnLybbrCnW0e3oStAFEbSOBNISj3lzYnEbAQWrLcm25cMlhd7+gWhvodoT5PWqbdeFCeSgxY4caGqyw4DmOD9GLC2ixzuVUN6l+xtT16ORaTSy4n8dgA/UMCSO+nRzJClkAIKPMydh80fxYQWSOk9TFE6bYO0K+2wanF3FKjxGTEFzrsFWBx4CwTsA==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(36860700016)(82310400026)(14060799003)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0VbpNxDJEE3U/cUInpADJ6Fmh+LdqrPRzW0tHR95j2QcDnTGk8IJsvUVYUxq4OMjqfxRlC8Ku7HcoSe/MlD6U3u46jynEeZU1knIk3j3ZDMTLzRGfKKFKQrwgi3Quf5twskOF3bL52aex6T2dXLJBGGJ5tJjzdwdQtfP9Fdv416ECUAeowRjGNgb9INqE3Vp4sZguyWUo9UPsEyqvjogODoLR+wGHWGPEx8nz/h/Oz3G1z/mALNaV4iQI/YKB/Mb/Tve+vvsqtu9fpGzfgPWK2RXmZEuRdeJL5NgwZ0UJ/Esjt8Gql3pRLNPRqFEEmlGtgqCcmucYEyXWpLX4ZDZaRye6CKhO5cDXNDg0oejo59Vt8xTM2Y67kG4hkljLpHtCVzGgza+JIJrn7WVPrGRFtmiykogbcIybrsw/Zg9yiDU4k5KV5H3a1MG1ASm+QdG
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:17:45.6791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b49b4027-27b2-478c-77b0-08dea6aa1ad0
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6793
X-Rspamd-Queue-Id: 653904A2245
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.94 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282800-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[25];
	R_DKIM_ALLOW(0.00)[solid-run.com:s=selector1];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,davemloft.net,google.com,redhat.com,solid-run.com,thorsis.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com];
	DKIM_TRACE(0.00)[solid-run.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.509];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[solid-run.com,reject];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Spam: Yes

QW0gMDkuMDQuMjYgdW0gMTQ6NDYgc2NocmllYiBBbmRyZXcgTHVubjoNCj4+ICsmZXFvcyB7DQo+
PiArCS8qIGRlbGF5cyBhcmUgYWRkZWQgYnkgY29ubmVjdGVkIGV0aGVybmV0LXN3aXRjaCBjcHUg
cG9ydCAqLw0KPj4gKwlwaHktbW9kZSA9ICJyZ21paSI7DQo+PiArCXBpbmN0cmwtMCA9IDwmZXFv
c19waW5zPjsNCj4+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+ICsJc3RhdHVzID0g
Im9rYXkiOw0KPj4gKw0KPj4gKwlmaXhlZC1saW5rIHsNCj4+ICsJCWZ1bGwtZHVwbGV4Ow0KPj4g
KwkJc3BlZWQgPSA8MTAwMD47DQo+PiArCX07DQo+PiArfTsNCj4NCj4+ICsJZXRoZXJuZXQtc3dp
dGNoQDAgew0KPj4gKwkJY29tcGF0aWJsZSA9ICJueHAsc2phMTExMGEiOw0KPj4gKwkJcmVnID0g
PDA+Ow0KPj4gKwkJcmVzZXQtZ3Bpb3MgPSA8JmxzaW9fZ3BpbzQgMyBHUElPX0FDVElWRV9MT1c+
Ow0KPj4gKwkJc3BpLW1heC1mcmVxdWVuY3kgPSA8NDAwMDAwMD47DQo+PiArDQo+PiArCQlldGhl
cm5ldC1wb3J0cyB7DQo+PiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiArCQkJI3NpemUt
Y2VsbHMgPSA8MD47DQo+PiArDQo+PiArCQkJLyogMTAwQmFzZS1UWCBvbiBjb25uZWN0b3IgSjI2
ICovDQo+PiArCQkJcG9ydEAxIHsNCj4+ICsJCQkJcmVnID0gPDB4MT47DQo+PiArCQkJCWxhYmVs
ID0gImxhbjEiOw0KPj4gKwkJCQlwaHktaGFuZGxlID0gPCZzd2l0Y2hfcG9ydDFfYmFzZV90eF9w
aHk+Ow0KPj4gKwkJCQlwaHktbW9kZSA9ICJpbnRlcm5hbCI7DQo+PiArCQkJCXN0YXR1cyA9ICJv
a2F5IjsNCmRyb3BwaW5nIHVubmVjZXNzYXJ5IHN0YXR1cyBva2F5IGZvciB2Mw0KPj4gKwkJCX07
DQo+PiArDQo+PiArCQkJLyogQ1BVICovDQo+PiArCQkJcG9ydEAyIHsNCj4+ICsJCQkJcmVnID0g
PDB4Mj47DQo+PiArCQkJCWV0aGVybmV0ID0gPCZlcW9zPjsNCj4+ICsJCQkJbGFiZWwgPSAiY3B1
IjsNCj4+ICsJCQkJcGh5LW1vZGUgPSAicmdtaWktaWQiOw0KPj4gKwkJCQlyeC1pbnRlcm5hbC1k
ZWxheS1wcyA9IDwyMDAwPjsNCj4+ICsJCQkJdHgtaW50ZXJuYWwtZGVsYXktcHMgPSA8MjAwMD47
DQo+PiArCQkJCXN0YXR1cyA9ICJva2F5IjsNCmRyb3BwaW5nIHVubmVjZXNzYXJ5IHN0YXR1cyBv
a2F5IGZvciB2Mw0KPj4gKw0KPj4gKwkJCQlmaXhlZC1saW5rIHsNCj4+ICsJCQkJCWZ1bGwtZHVw
bGV4Ow0KPj4gKwkJCQkJc3BlZWQgPSA8MTAwMD47DQo+PiArCQkJCX07DQo+PiArCQkJfTsNCj4+
ICsNCj4+ICsJCQkvKiBzZ21paSBvbiBhZGRvbiBib2FyZCBjb25uZWN0b3IgSjIxICovDQo+PiAr
CQkJcG9ydEAzIHsNCj4+ICsJCQkJcmVnID0gPDB4Mz47DQo+PiArCQkJCWxhYmVsID0gImxhbjMi
Ow0KPj4gKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4gKwkJCX07DQo+PiArDQo+PiArCQkJ
Lyogc2dtaWkgb24gYWRkb24gYm9hcmQgY29ubmVjdG9yIEoyMSAqLw0KPj4gKwkJCXBvcnRANCB7
DQo+PiArCQkJCXJlZyA9IDwweDQ+Ow0KPj4gKwkJCQlsYWJlbCA9ICJsYW40IjsNCj4+ICsJCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCj4+ICsJCQl9Ow0KPj4gKw0KPj4gKwkJCS8qIDEwMGJhc2Ut
dDEgb24gYWRkb24gYm9hcmQgY29ubmVjdG9yIEoyMSAqLw0KPj4gKwkJCXBvcnRANSB7DQo+PiAr
CQkJCXJlZyA9IDwweDU+Ow0KPj4gKwkJCQlsYWJlbCA9ICJ0cngxIjsNCj4+ICsJCQkJcGh5LWhh
bmRsZSA9IDwmc3dpdGNoX3BvcnQ1X2Jhc2VfdDFfcGh5PjsNCj4+ICsJCQkJcGh5LW1vZGUgPSAi
aW50ZXJuYWwiOw0KPj4gKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4gKwkJCX07DQo+PiAr
DQo+PiArCQkJLyogMTAwYmFzZS10MSBvbiBhZGRvbiBib2FyZCBjb25uZWN0b3IgSjIxICovDQo+
PiArCQkJcG9ydEA2IHsNCj4+ICsJCQkJcmVnID0gPDB4Nj47DQo+PiArCQkJCWxhYmVsID0gInRy
eDIiOw0KPj4gKwkJCQlwaHktaGFuZGxlID0gPCZzd2l0Y2hfcG9ydDZfYmFzZV90MV9waHk+Ow0K
Pj4gKwkJCQlwaHktbW9kZSA9ICJpbnRlcm5hbCI7DQo+PiArCQkJCXN0YXR1cyA9ICJkaXNhYmxl
ZCI7DQo+PiArCQkJfTsNCj4+ICsNCj4+ICsJCQkvKiAxMDBiYXNlLXQxIG9uIGFkZG9uIGJvYXJk
IGNvbm5lY3RvciBKMjEgKi8NCj4+ICsJCQlwb3J0QDcgew0KPj4gKwkJCQlyZWcgPSA8MHg3PjsN
Cj4+ICsJCQkJbGFiZWwgPSAidHJ4MyI7DQo+PiArCQkJCXBoeS1oYW5kbGUgPSA8JnN3aXRjaF9w
b3J0N19iYXNlX3QxX3BoeT47DQo+PiArCQkJCXBoeS1tb2RlID0gImludGVybmFsIjsNCj4+ICsJ
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+ICsJCQl9Ow0KPj4gKw0KPj4gKwkJCS8qIDEwMGJh
c2UtdDEgb24gYWRkb24gYm9hcmQgY29ubmVjdG9yIEoyMSAqLw0KPj4gKwkJCXBvcnRAOCB7DQo+
PiArCQkJCXJlZyA9IDwweDg+Ow0KPj4gKwkJCQlsYWJlbCA9ICJ0cng0IjsNCj4+ICsJCQkJcGh5
LWhhbmRsZSA9IDwmc3dpdGNoX3BvcnQ4X2Jhc2VfdDFfcGh5PjsNCj4+ICsJCQkJcGh5LW1vZGUg
PSAiaW50ZXJuYWwiOw0KPj4gKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4gKwkJCX07DQo+
PiArDQo+PiArCQkJLyogMTAwYmFzZS10MSBvbiBhZGRvbiBib2FyZCBjb25uZWN0b3IgSjIxICov
DQo+PiArCQkJcG9ydEA5IHsNCj4+ICsJCQkJcmVnID0gPDB4OT47DQo+PiArCQkJCWxhYmVsID0g
InRyeDUiOw0KPj4gKwkJCQlwaHktaGFuZGxlID0gPCZzd2l0Y2hfcG9ydDlfYmFzZV90MV9waHk+
Ow0KPj4gKwkJCQlwaHktbW9kZSA9ICJpbnRlcm5hbCI7DQo+PiArCQkJCXN0YXR1cyA9ICJkaXNh
YmxlZCI7DQo+PiArCQkJfTsNCj4+ICsNCj4+ICsJCQkvKiAxMDBCYXNlLVQxIG9uIGNvbm5lY3Rv
ciBKMjYgKi8NCj4+ICsJCQlwb3J0QGEgew0KPj4gKwkJCQlyZWcgPSA8MHhhPjsNCj4+ICsJCQkJ
bGFiZWwgPSAidHJ4NiI7DQo+PiArCQkJCXBoeS1oYW5kbGUgPSA8JnN3aXRjaF9wb3J0MTBfYmFz
ZV90MV9waHk+Ow0KPj4gKwkJCQlwaHktbW9kZSA9ICJpbnRlcm5hbCI7DQo+PiArCQkJCXN0YXR1
cyA9ICJva2F5IjsNCmRyb3BwaW5nIHVubmVjZXNzYXJ5IHN0YXR1cyBva2F5IGZvciB2Mw0KPj4g
KwkJCX07DQo+PiArCQl9Ow0KPj4gKw0KPj4gKwkJbWRpb3Mgew0KPj4gKwkJCSNhZGRyZXNzLWNl
bGxzID0gPDE+Ow0KPj4gKwkJCSNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKw0KPj4gKwkJCW1kaW9A
MCB7DQo+PiArCQkJCWNvbXBhdGlibGUgPSAibnhwLHNqYTExMTAtYmFzZS10MS1tZGlvIjsNCj4+
ICsJCQkJcmVnID0gPDA+Ow0KPj4gKwkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsJCQkJ
I3NpemUtY2VsbHMgPSA8MD47DQo+PiArDQo+PiArCQkJCS8qIDEwMGJhc2UtdDEgb24gYWRkb24g
Ym9hcmQgY29ubmVjdG9yIEoyMSAqLw0KPj4gKwkJCQlzd2l0Y2hfcG9ydDVfYmFzZV90MV9waHk6
IGV0aGVybmV0LXBoeUAxIHsNCj4+ICsJCQkJCWNvbXBhdGlibGUgPSAiZXRoZXJuZXQtcGh5LWll
ZWU4MDIuMy1jNDUiOw0KPj4gKwkJCQkJcmVnID0gPDB4MT47DQo+PiArCQkJCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KPj4gKwkJCQl9Ow0KPj4gKw0KPj4gKwkJCQkvKiAxMDBiYXNlLXQxIG9uIGFk
ZG9uIGJvYXJkIGNvbm5lY3RvciBKMjEgKi8NCj4+ICsJCQkJc3dpdGNoX3BvcnQ2X2Jhc2VfdDFf
cGh5OiBldGhlcm5ldC1waHlAMiB7DQo+PiArCQkJCQljb21wYXRpYmxlID0gImV0aGVybmV0LXBo
eS1pZWVlODAyLjMtYzQ1IjsNCj4+ICsJCQkJCXJlZyA9IDwweDI+Ow0KPj4gKwkJCQkJc3RhdHVz
ID0gImRpc2FibGVkIjsNCj4+ICsJCQkJfTsNCj4+ICsNCj4+ICsJCQkJLyogMTAwYmFzZS10MSBv
biBhZGRvbiBib2FyZCBjb25uZWN0b3IgSjIxICovDQo+PiArCQkJCXN3aXRjaF9wb3J0N19iYXNl
X3QxX3BoeTogZXRoZXJuZXQtcGh5QDMgew0KPj4gKwkJCQkJY29tcGF0aWJsZSA9ICJldGhlcm5l
dC1waHktaWVlZTgwMi4zLWM0NSI7DQo+PiArCQkJCQlyZWcgPSA8MHgzPjsNCj4+ICsJCQkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiArCQkJCX07DQo+PiArDQo+PiArCQkJCS8qIDEwMGJhc2Ut
dDEgb24gYWRkb24gYm9hcmQgY29ubmVjdG9yIEoyMSAqLw0KPj4gKwkJCQlzd2l0Y2hfcG9ydDhf
YmFzZV90MV9waHk6IGV0aGVybmV0LXBoeUA0IHsNCj4+ICsJCQkJCWNvbXBhdGlibGUgPSAiZXRo
ZXJuZXQtcGh5LWllZWU4MDIuMy1jNDUiOw0KPj4gKwkJCQkJcmVnID0gPDB4ND47DQo+PiArCQkJ
CQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4gKwkJCQl9Ow0KPj4gKw0KPj4gKwkJCQkvKiAxMDBi
YXNlLXQxIG9uIGFkZG9uIGJvYXJkIGNvbm5lY3RvciBKMjEgKi8NCj4+ICsJCQkJc3dpdGNoX3Bv
cnQ5X2Jhc2VfdDFfcGh5OiBldGhlcm5ldC1waHlANSB7DQo+PiArCQkJCQljb21wYXRpYmxlID0g
ImV0aGVybmV0LXBoeS1pZWVlODAyLjMtYzQ1IjsNCj4+ICsJCQkJCXJlZyA9IDwweDU+Ow0KPj4g
KwkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+ICsJCQkJfTsNCj4+ICsNCj4+ICsJCQkJLyog
MTAwQmFzZS1UMSBvbiBjb25uZWN0b3IgSjI2ICovDQo+PiArCQkJCXN3aXRjaF9wb3J0MTBfYmFz
ZV90MV9waHk6IGV0aGVybmV0LXBoeUA2IHsNCj4+ICsJCQkJCWNvbXBhdGlibGUgPSAiZXRoZXJu
ZXQtcGh5LWllZWU4MDIuMy1jNDUiOw0KPj4gKwkJCQkJcmVnID0gPDB4Nj47DQo+PiArCQkJCX07
DQo+PiArCQkJfTsNCj4+ICsNCj4+ICsJCQltZGlvQDEgew0KPj4gKwkJCQljb21wYXRpYmxlID0g
Im54cCxzamExMTEwLWJhc2UtdHgtbWRpbyI7DQo+PiArCQkJCXJlZyA9IDwxPjsNCj4+ICsJCQkJ
I2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiArCQkJCSNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKw0K
Pj4gKwkJCQkvKiAxMDBCYXNlLVRYIG9uIGNvbm5lY3RvciBKMjYgKi8NCj4+ICsJCQkJc3dpdGNo
X3BvcnQxX2Jhc2VfdHhfcGh5OiBldGhlcm5ldC1waHlAMSB7DQo+PiArCQkJCQlyZWcgPSA8MHgx
PjsNCj4+ICsJCQkJfTsNCj4+ICsJCQl9Ow0KPiBGb3IgdGhlc2Ugbm9kZXMgb25seToNCj4NCj4g
UmV2aWV3ZWQtYnk6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4NCj4gICAgIEFuZHJl
dw0KDQpUaGFua3MhDQoNCkkgZG9uJ3Qga25vdyBob3cgdG8ga2VlcCB0aGlzIHBhcnRpYWwgcmV2
aWV3IGZvciB2Mywgc28gSSB3aWxsIHNlbmQgaXQgd2l0aG91dC4=


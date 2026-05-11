Return-Path: <netdev+bounces-286589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFK8JqasAWoMhwEAu9opvQ
	(envelope-from <netdev+bounces-286589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:17:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A486050BC1B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB0D3300E684
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA103C8738;
	Mon, 11 May 2026 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="vH5Bd0PP";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="vH5Bd0PP"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022074.outbound.protection.outlook.com [52.101.66.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E53C9EED;
	Mon, 11 May 2026 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.74
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494338; cv=fail; b=fo/P4gx4HLcaXUOehhN0ME+543FiP93lWvsZmVfZGkiCW250e+gqluh61j0f723B6bh/w+M7Nf1mC8anHbOZQR/AHLqF+MesRPyw681RGVzhJzpCLiw2c6s02edZDrk60wiaJh0OINCYOBYlPMzJO3o0f9g024YePOcWYrJdd2E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494338; c=relaxed/simple;
	bh=TAFgxe8nZBqVq7IL1QqWPUf7B09MCb00qLcnQm+SU3Y=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=J4uPNp/EvYMN/JQcKxQTxqvwb+nKjOJS+A8NTTpzPTViFQqQyHxNkexfR24jeFulQyMInsJ58+IIRt4gt5lyk21pcw3Ay2GIM9rvpW4YByPh5ZZfdVOaeRm4jqMl7Q2HAgcH9aOZO5iz22+7C2iRoVP4bVraPAgvcrvqS+wJJNI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=vH5Bd0PP; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=vH5Bd0PP; arc=fail smtp.client-ip=52.101.66.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fEyelF1uebhZ5lXmisLvWw7+2OQUcq67W3BcqktoOC4sZRoxUYNPtnh0jQBwpneJCptmhWQk9QGDxIs4WMbjQJCGtsr4XIGj2+Jq2oROj5Rhf35z99i8c0nZc40/YQOwcS1QygVFplTrmOYUgQsmYOD03GT77d2xuniZxYFnByCgMLgxFBU12U2IfB2PQPvdwu8/hZJird3eXbfi8SfwoHf6KHVfaDvwtTCjHz/1KX1RAXqZoWAQCYZH2gudYTx3E/k5EqFtDw1soQ2CtkldPC9jMAyZFr9PYhnrF7JMkjcUHTKERPPCwDuceLxsuJOZdNdmUO5rzrI4aCyRPqlyWA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6oVtzUpFTJ9H513E/OM5oIICgmAsjgrYdUZVKaWjJY=;
 b=v64lU66X0yzCgYD04oFOskwbZqOtpfYj+QnoG4pt1+yfV9HoYuYtI+k21u/tqxHXdAim7jeWoaHKIs4lEeK7H5Qv1WrRzVBnt+AqlZJDCtxLs6Edkah6e2q9KrrC1sVL3YnKa8nrn2Odjf4zzBLzbjtBRrX1jmN9BR+QUtIG62EgLh00yKF+k30eSkaMAw+rYMPjf4eOfFqRjtmlYY5MlcW4Zjbaov8TN/WaCdejVMqxavGRxVeYi9bGpMoUNdykSM0i6FUpm+KkSOmF2ytfXnjZPpXec4aD/h+Ta4l+el43cK3uMSarVvaGQ1R/kprzVsApkJcyeLvYV9esnyaPDw==
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
 bh=y6oVtzUpFTJ9H513E/OM5oIICgmAsjgrYdUZVKaWjJY=;
 b=vH5Bd0PPpQP5Yp+tyqHEb8zd8FwBJl5gxFS03JNvhzC+VbpIS8xGwK3Puxe7WwG4PZrl/357a3MKvBtvfkrUe91gGamQBMs5yJ3wc52uJ7E7mihsfUDVg4+SSUwOaBV30sJrpE2ESQgkvSxdQ+fzCCx9Jveq0ngHk4qTGKEPLahMMU4nXyIOVJyZNPHlJ2eOGJxS+LqtdZjdDxlsq7KlYgBJOKJZidez5y23u4GbdJNuVb6fLIrTe1RhukKpUXnxAjwaJaPZwsI+3VOROYTwcPShdAdjzTYUq9Jgfu/NRjwwhVfI/XxmFRs+anuGyfjNsHgTNonSDeMjTC35z3pJ5g==
Received: from AM5PR1001CA0043.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::20) by PA6PR04MB11806.eurprd04.prod.outlook.com
 (2603:10a6:102:526::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Mon, 11 May
 2026 10:12:12 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:206:15:cafe::f3) by AM5PR1001CA0043.outlook.office365.com
 (2603:10a6:206:15::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 10:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Mon, 11 May 2026 10:12:10 +0000
Received: from emails-7918590-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-143.eu-west-1.compute.internal [10.20.6.143])
	by mta-outgoing-dlp-305-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 4C2B87FD43;
	Mon, 11 May 2026 10:12:10 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Mon May 11 10:11:42 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhVjkqHzELVnkjlwbeDRFym17tj/s18u/TKwGQRuQXXbWu7VfURLTeuiBJc5rdaZAYVgm4XoDPmYHjSFQ5fQqBfx0e503aBx0eITpfETjsqNmeAlN+6uEwhxBehcUEZ84hAIkEnot+N7nQYSwAi0Ue/yvU2EV8cgBMs2h/hgRRJVLZYFOuzyCES/5Xvtuw7VcidPHVOx96OKwED0GGRP1hRdYmaI9iMFCbExYpp8tWvR1ilKuNvmwGvhJJT9s6xYIb4733A42uukfyEhcr+EzFyevNz5MwA5SdKBhc3R6NSoNud2gatQZpuPlq2L8KxO/23iT1RMWd3hUkSevUyANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6oVtzUpFTJ9H513E/OM5oIICgmAsjgrYdUZVKaWjJY=;
 b=jowo5cMnYPoQpkzr6I6HKY8cu0uz3JPIA3mu6IL0dd0njQE8+x62jFSzFae43LSUmBWH80qPZG7JwNWSw27+s2gB1LgjoJ3caqLNygGfzlchNhUOMT3o2yKcf9BqbYC98RAkNYpM2QD4jy55e5D3j2xZa4WmYVhn8CgMc3O71d0WUKTPTwpBFRgrCaMkfgkKCyae7/WaZfyi6o1KYQ1vMlPSvumTf0y1UpW/A9vuIAUsjzADJDKI6a7bUsOitpwcx6bpZCuJcqbDMW4pLEoTdINEckfI6zDgIsxTSqPgmZGFK0b/PzVZ1wAUO5T8N4vlSvggkgRqlgOY5CMEOZNy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6oVtzUpFTJ9H513E/OM5oIICgmAsjgrYdUZVKaWjJY=;
 b=vH5Bd0PPpQP5Yp+tyqHEb8zd8FwBJl5gxFS03JNvhzC+VbpIS8xGwK3Puxe7WwG4PZrl/357a3MKvBtvfkrUe91gGamQBMs5yJ3wc52uJ7E7mihsfUDVg4+SSUwOaBV30sJrpE2ESQgkvSxdQ+fzCCx9Jveq0ngHk4qTGKEPLahMMU4nXyIOVJyZNPHlJ2eOGJxS+LqtdZjdDxlsq7KlYgBJOKJZidez5y23u4GbdJNuVb6fLIrTe1RhukKpUXnxAjwaJaPZwsI+3VOROYTwcPShdAdjzTYUq9Jgfu/NRjwwhVfI/XxmFRs+anuGyfjNsHgTNonSDeMjTC35z3pJ5g==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by PA4PR04MB7789.eurprd04.prod.outlook.com
 (2603:10a6:102:c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:11:35 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 10:11:35 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v4 0/2] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Date: Mon, 11 May 2026 12:11:29 +0200
Message-Id: <20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFGrAWoC/3XOTQ6CMBCG4auQrq1pOwWKK+9hXJT+SBOhptUGQ
 7i7hRURXb5fMk9mQtEEZyI6FRMKJrno/JCDHwqkOjncDHY6N2KEVYQTgV0/Cj3ecQw4+h5byql
 RwIHWgPLRIxjrxhW8XHN3Lj59eK9+osv6l0oUE6xMKaGRStcUztHfncbhNRyV79HCJbYlmh3BM
 iHAWkYq1rSS/CJgQwDZEbB+wVpRKVuXrfom5nn+AKI8nR02AQAA
X-Change-ID: 20260408-imx8dxl-sr-som-f141ec343173
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Alexander Dahl <ada@thorsis.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR04MB12057:EE_|PA4PR04MB7789:EE_|AMS0EPF000001A0:EE_|PA6PR04MB11806:EE_
X-MS-Office365-Filtering-Correlation-Id: caa8b46d-c8c8-4e95-afaf-08deaf45c3ec
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|56012099003|38350700014|921020|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 z7diYlbOXBtSjcxOw8YVFzfpSD+KJhRJD+rnRRRqbr03O6Us+6yQesqV8u4uZBxnCax+CAUtk1c/SA3qdCrIkfA7UIRWIcD6uLRcSpV81cgMNjkhK347WjMQmQVaEKlV9sFIG3rQFyQoIUU/6dN75dSzq7YiKS0D3rYFuSG8a0DszSTx5k/0oJ2NSv7zAgs0efZA7lnDxheK15OPCOOe6gNB9p/gtPTsACl93gOShQ/HihRc9ETfTmfMJUmDDQlKGWpo1HTertdILeOJ4lp02OYp3BpDEXcevE2r7iQKoRH2+FlPgadgNLvYfXWTQqb2kyB3V4sSOgfZYnHtJ+8DGxh6pt6Kgu18+M6YiiTMg4R2z4gUgcKd3FL1toC8VsBICt7+s21w0CpNs0HUVc9tFgzGW0buhGPXW1/RWH7bi4Hd6v6wtLDvazcYzWHLwB+otsdhJLVCWBXbW3WGuYS1XPNWE/VVl2Aez7kVT8/uIcgj2nVq50/mFBI2JOmCem174iSiVA0FpSMR4Nw2gKHk5FjjSJ9U4T0z+ZfYs4hgOXckxP3j8K1NWFti/kjyQkN0pebAeyRSQRH0yrmTk20XHd2ai92+rOxX6QvGZuAIuL/CfmlPDha5fXjh5CLEhUc+my+pC3QhNEbb7BSX+jXOlAJ2zAWh08ysejcH1a7CURL7TDN1h2aq4grCsV6yAzcJcKj6Katr7DSl4iQpoC9aKX/Rf/6zuH7GvcXjY/p47dx9ND/yjVr3uQ20Zf4Jhc4GcQWh0BpUitNL7eRd9odn9A==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(56012099003)(38350700014)(921020)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 d9KbJzDu8hXqZ+OeNnI4uaggSVvOW6HFkDf9FEnz1WDw7YQgw6Zbv5ffFM5MiFWnIIm7IeC4LuHCh9QYo7K/8D6QuG7JIM+PLtCdVZpZ34VVWX+euD48kiVa7SRyUOneOLfB6RzsMy661yKfsvxgkISUUoJ58rR4B7Gsq0q8ahsfKkkFo4uQ9kjdKJP+tO7e033ImXsGSEHiT/07dmX+kbSbXW2oGwb+B2RtzUPAGSa72TjeU1uSwFn0QfVoLFu9wXUGTv27rckD/4rnhgXNExKYhPq/BIHgmlAKc9mJnlGV6+dzF6G+TP9ur8SSM76r0a5SS24aH4wmZV9P7IRLtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7789
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 9e8f6d17eab14bd18e6bd937d64e0d24:solidrun,office365_emails,sent,inline:9e1ded0381d41971f98a1151147016f1
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	46ed282a-fb6d-4604-dbda-08deaf45aeb3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|82310400026|36860700016|7416014|1800799024|376014|18002099003|56012099003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	nBij6DlbHYekAcySBPXE2VlaC0S7rS36ARB1b+cvkOtQIUeffozFzh2V5Fk6B9ORf9oaqNbAfOOQNb87ZjaXYB3glxaQ+GiQ7fpBCLTL82zKqsXZJYQPHFA5O2C5nWO4mmfOHCwznPqV5jh+2W+mKdV7ozlxkHSyI9OogUyZ6I26pBVjXaSatiM8LOaeXsMrZY9iuAPyn86vMzh67JkcHn4XAVi4778FYAgd/ZuooGjNSqeP5cMcd9QT1vVsUPe8UpD8FcxWMobZjJkHNSaN/3/Uz4imrMmQmKWyTWkaXvA3tUrwIeBMqrhMqOWgAj31gDYicqOzwISBss4o+iP7jXuQSz6VrypFm344IMxh57LSl19+FWmKr8dxes18jRlitIGaXvGMUDUQLfImW1AdV1u8O86cBId++zbAvZhpGjzxrCGGlbDHTLXKh49VEcIdp1pWOmxgaVlAUkpiG2uhgkvi0sCN+QBaIpvNWHYdvql4N00gOBdYqKPKlDE4duyf/TpgsSJmkUm16e9OMIUSx6keSrsGGiDM9hbDBgULS9r9iH5hfn7gJHeEUjC9+lgqHiQqGJ3cM1k1XHLbscsIaT/1llLvrWikEdIzqkhSrhFnEFaC/Ux7WKRvODJDp9VTA9zNtD4u9m77Nfkej4WrirlXVA2F91gifN7jI+p0hTAnlgvkExLvXDeplb225hAnIAPuWeSI4RXmVfRbMMSsb9givT/zWvlcAXjxQrWbwSoXhsc8x9mTP/SwmcTbuObgGb3LDi0lyrnVxyw/j4uYLdIVjOr3OflNdNDPbWXHA9w=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(82310400026)(36860700016)(7416014)(1800799024)(376014)(18002099003)(56012099003)(921020)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eggonTqUjzL76/xhXp8JfaEtVYoQBKRrDeKKIHdaSiaIILodCq0GaS79Sh+1U30VMdfozSg0CzrcP5XipFLtVnLJ9Z+5RiL6WaZYJaAdI7PmUEoHbaxeM74UhHG266t5fsYAnnTSV/vezWw0cBug3dvj12JNaGVhGx8C1VjYvt2KeThmhRnYX4/P3weKgkqjvIf2VDgXwc31YmJlElBwUOx8QdthV06EQHIkK8WZ9kd0YWMqKy0N7b5wA6kjDC8bNftUq2LmzsAgXtITd0000QcXD8AaZe3o9UG1ToRtIaFqsH15VYRv3iR4lsosfPh7kyiLAKcTCJ8pRUTYJdnSbgwZY6ZetLSUHj2zZWojOGoI6Hc4KLHotc7L1CazRqrRSo/C5VkZAObMrZbbqrm/ionsj51h12kpK5wZ+ycpSroKMl7FMIH9zA1X//5fWXMn
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:12:10.7145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa8b46d-c8c8-4e95-afaf-08deaf45c3ec
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11806
X-Rspamd-Queue-Id: A486050BC1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286589-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:email,solid-run.com:mid,solid-run.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Add bindings and description for SolidRUn i.MX8DXL based SoM and
HummingBoard Telematics.

Modify SJA1110 Ethernet Switch bindings to allow SPI Mode 0.

This patch-set is based on v7.0-rc2, because rc1 was experiencing
deadlocks with imx8qxp clock driver.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v4:
- picked up acked-by adnrew lunn
- Link to v3: https://lore.kernel.org/r/20260430-imx8dxl-sr-som-v3-0-ce2b86cf75bc@solid-run.com

Changes in v3:
- rebased on v7.1-rc1.
- dropped dsa swtch port labels, should be handled by udev rules if
  required.
- Fixed spelling error in alias comment.
- Dropped superfluous status okay properties from switch sub-nodes.
- Link to v2: https://lore.kernel.org/r/20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com

Changes in v2:
- Dropped accidental change to unrelated imx8mp-sr-som.dtsi file.
- Fixed phy-mode on fixed link between cpu and ethernet switch.
  (Reported-by: Andrew Lunn <andrew@lunn.ch>)
- Removed spi-cpol property from ethernet-switch on spi bus, fixing
  sja1110a driver probe.
- Changed SJA1110 bindings to allow removing spi-cpol property.
- Aligned comments on all ethernet switch port nodes to be consistent.
- Dropped regulator-always-on from dsrc radio power-supplies.
- Link to v1: https://lore.kernel.org/r/20260408-imx8dxl-sr-som-v1-0-ce5a39acd713@solid-run.com

---
Josua Mayer (2):
      dt-bindings: arm: fsl: Add SolidRun i.MX8DXL SoM and HummingBoard
      arm64: dts: imx8dxl: Add SolidRun SoM and HummingBoard

 Documentation/devicetree/bindings/arm/fsl.yaml     |   7 +
 arch/arm64/boot/dts/freescale/Makefile             |   2 +
 .../freescale/imx8dxl-hummingboard-telematics.dts  | 523 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi  | 458 ++++++++++++++++++
 4 files changed, 990 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260408-imx8dxl-sr-som-f141ec343173

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



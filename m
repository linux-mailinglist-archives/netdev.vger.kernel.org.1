Return-Path: <netdev+bounces-287070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KApaCsoAA2rdzQEAu9opvQ
	(envelope-from <netdev+bounces-287070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:28:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB851E8B9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A35C301177A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A52349CC9;
	Tue, 12 May 2026 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="q0DBjqf4";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="q0DBjqf4"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022125.outbound.protection.outlook.com [52.101.66.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B37255F2C;
	Tue, 12 May 2026 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.125
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581646; cv=fail; b=sMb/3383jqtONlDaDF0qc1K1wTivRVSeOmKMquaTzwyni4QKfXlRmAwsLtyMa3LEyBlS9QjJEUh7uZ9D0V8AeFztgFk5wuRVpAG4S3Xzq94CMoC1uwP22Jrgyo8UC8dkRs3GIki+bly3ONp6i0v6qygi3qqw4/Ki09H+CJlEZmw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581646; c=relaxed/simple;
	bh=AQnsKNhNXTVBwVhbx5Jsv/rmlTd+CekkurepoSyw9KI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TNu73POLgyC9jCOK4dsa3aBoPRqi0j/ABP4icqEoEofyEMx+vHEi5Ae16t+tb5MpPk4tdImFaqc17lgSmwdJbcG+IToF5vgc5Cq6U6QJqN0r2RT/KN6me0Dmv5Pzp/14xw0WvHOQOAB7qvN1J02ejc04ne7mjOa84tZFjm29oI8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=q0DBjqf4; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=q0DBjqf4; arc=fail smtp.client-ip=52.101.66.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cLI763SZwYf3nr+cHCWRbMRZgue+krhSSLowZD8hBOCNLMcBPGMRWN+uVSY40AoGw5dR8Aa62CwhH7SuZi+IxOgfpomsRbOF+KHrJsEntaIqvwWsRLwEAslyCfHVnKZg/tFInTKb02DiPBtdi/GPC85uTYtZFXx24wkGRBm0i87LyM97x6TccTUxhDBQNk03EUh2Bxxo0Or2AUxl0Gk8wN1Ov6L9/xKhkGIKIIEs7HvhCBHL2oJjaFPaVorjX+RyXWfFQABBMtZO2R5LJVqQVvKDli9FFq5MMA6HuwUpu0ARUHgmflhEZsqmZwCNyGb47z9f+d8YFOl7sdtaNS7LoA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQnsKNhNXTVBwVhbx5Jsv/rmlTd+CekkurepoSyw9KI=;
 b=UFnoRxQlv6eOl5lt4Bos3ecK9shILCbKvLW3GBtyIgcujVhJX0Om/XoWp02K6xOm8Dj6AWhlg5s9YxT4gsyqzBI43JjRVnPxgMAu332MoW1sdqSuR18R5YKZ3YekWhAvEKbwk6tujcTHvDhvqoP+sxIYveJlGf3or7YguE2bWejp24bWvYHrcRfhJgOFQtORbRRYbfJRHB4v2RfhceGO4wijt6Ri1h7oD28IBj968RWeFbHb4+PM+nNU+AeT4ricWcfmhp/8BmUwkg8koF3hm55UZ+OIfkO77r7gk6RihPQHSunRYXHIH1oOOpc46fPoQokCM2lhz5JSjCebGsK1GA==
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
 bh=AQnsKNhNXTVBwVhbx5Jsv/rmlTd+CekkurepoSyw9KI=;
 b=q0DBjqf4m9J0nRIpcGOzWWw8rfxoggQ372JmoCaVvTtQmj4c/UrrK9lOYT4g398WXddp5AkL29JmAueu+8G7wsxWjyjjLr0yG3UY2IB6Z0Q2exXHlh7BXuZ7ixMxN7z38chuuGUSKUoIlIIDyu0gwqxTNQbkSwjxtYsFnZnlOKOk88ZhjOjmhB3j0ETveCaqeSVZJ6l7hXELF+kQYmJ0KO6LZttsd3jQRhatBWyn4Xfzy4jCyL+ueqSkh2x/DohYgD2OHgOUpRuLcKMX4/pyNIiUh26pVKVwSzUUz0eZhMopsGiVdQOsIOxGpiMDBlTMgGGekLdz3K9GqisD/1BFcg==
Received: from DU2P251CA0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::12)
 by PA1PR04MB10986.eurprd04.prod.outlook.com (2603:10a6:102:489::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 10:27:20 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::b0) by DU2P251CA0001.outlook.office365.com
 (2603:10a6:10:230::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 10:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13 via
 Frontend Transport; Tue, 12 May 2026 10:27:18 +0000
Received: from emails-4282437-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-103.eu-west-1.compute.internal [10.20.6.103])
	by mta-outgoing-dlp-588-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id D806F8046A;
	Tue, 12 May 2026 10:27:18 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Tue May 12 10:27:05 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoGgcmRcpVoWomsvLAilCmozJ/IN9ZtrEEqnJKF4xNnl9JGO2X4zveec1s3Bpi6mGOpnBoG8Nk9nMNL6pqfWTOmqHzFJRIiYGYpHYfaG4K/xZ2py9njT8X8ldUO5+zVV8DdtCj2qBXDkEZoArtQgGWIAIGBjFgZbb1+ykLoRq5k6az02e/PxBvEE67VuIkhn9/vYZSuBPFHSlxpREtHPeOm/FzkMjqhXaZmYy/Zi0fFpgw7uUvkJwQx1kzE/PRPX4qTdPeIMhpz3IN6fjmPwO8SuqwP0kCS9kT5kGYf64DpMCF+MGQrm3rdYuZn92QAczSE2B62Wy9ByOOhNHkMMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQnsKNhNXTVBwVhbx5Jsv/rmlTd+CekkurepoSyw9KI=;
 b=G1N7xyzpwPPPCdN63ICLpCYSj2XN/fpYBqJFVxoaUhMsP32XRnR+ShGNaiV/NqCm5e5tVcDjGkiIBjmjjv3Y4/GsYaE83GP8ZYYmSGJJur73JG4WVOKzqMjcwNjyOim3ANUyxECvlsJTt4M/PbxuHmSC7ei51gaon1C37dcvpOyyvzW5vfrot0++XIpoknf6uu8SJEn5yQhLc9yAOj9DH4/FuFQtTV36m6X5icfq8hKFWxiF2ktuU3LLMFJDPXYVarie1DQsETLaNY/m4KKcEF9sZPxE+wK/COY+uZwtR5i/miNZRLrUm8EQ7ltg7KBfhW5v9tBw+2P90z/iJTsz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQnsKNhNXTVBwVhbx5Jsv/rmlTd+CekkurepoSyw9KI=;
 b=q0DBjqf4m9J0nRIpcGOzWWw8rfxoggQ372JmoCaVvTtQmj4c/UrrK9lOYT4g398WXddp5AkL29JmAueu+8G7wsxWjyjjLr0yG3UY2IB6Z0Q2exXHlh7BXuZ7ixMxN7z38chuuGUSKUoIlIIDyu0gwqxTNQbkSwjxtYsFnZnlOKOk88ZhjOjmhB3j0ETveCaqeSVZJ6l7hXELF+kQYmJ0KO6LZttsd3jQRhatBWyn4Xfzy4jCyL+ueqSkh2x/DohYgD2OHgOUpRuLcKMX4/pyNIiUh26pVKVwSzUUz0eZhMopsGiVdQOsIOxGpiMDBlTMgGGekLdz3K9GqisD/1BFcg==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by AS8PR04MB8309.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fe::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 10:27:02 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 10:27:02 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>
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
	<linux-arm-kernel@lists.infradead.org>, Conor Dooley
	<conor.dooley@microchip.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Thread-Topic: [PATCH v4 2/2] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Thread-Index: AQHc4S6NPDp3cRKl10uFQFLEqUD7b7YIr0xYgAAisQCAAV9igA==
Date: Tue, 12 May 2026 10:27:02 +0000
Message-ID: <25e8c090-aaea-4898-b3bb-14c71bcab41e@solid-run.com>
References: <20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-2-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-2-64381b3bf80d@solid-run.com>
 <20260511112438.4fxvhelf242emzft@skbuf>
 <557f7332-42b4-49eb-85ea-76d141a2150f@lunn.ch>
In-Reply-To: <557f7332-42b4-49eb-85ea-76d141a2150f@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|AS8PR04MB8309:EE_|DU6PEPF0000A7DD:EE_|PA1PR04MB10986:EE_
X-MS-Office365-Filtering-Correlation-Id: ef66ccf3-e019-4665-59b1-08deb0110bb2
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 T/+1dKBelOBbI6xoIkLCfM8vwQYPdZa3rbLJVykW/qUMz9HR/vczevdTEQAG8GTIDiUnoJQMLsKYkPVjfMpHeShvVr6xRbbcVtD83HkFIlY0fprYPspwaitv5cViNxdbQMokUMvQFIc9i8CsCqaeYEOuiaQsLLEFznrqZ4BaF+G+NQVQKbmjrsJr+lDowkXtk3RGK1wus9YY1c1Do8Bt6XE9MIFU5tMWHgc0XMxLCqRUZ3zOAqv4u18hoWGuUXhRqPe8PKGT1uN9ee3sMn9oBi6NjV2rAng0eA4Qa4pSLmDklL4kmzFcSfAbdXvsCC+ApxXJS90T3dteRZoGyF71+Qpe1H44uaGCx/99FSV6Vli0ISiZmCwI5DKzl3UzMkgDX+1DqD/dlL5KdApU4Gvg23T8IpGv1G2vehtuGXlwXNmXsvGUFlbiXeRjwUFaEZ3iptrbYP3GOnyqOR4+wL1OjOzxvvgOONIkCTdd77AwvEuK25nHLYQ/W2GtjGoixAzDWuVOpmlAE6NMKF4FRIWHAX5K3REpyczwq3jVsW1xBXfypWiCA53XHBUIrVX2ufxZABqXShtKgtZlAJ8Jn3NLdcv6whB9e4azJGTj2Q1ey0lSitRvB3NA5zV7tDMNyshKBAqN71rf2CCeittf3uReXDQhB1ZvhB0OrCT1jaImp1VbRF+LCw1TjsWtGuHbGU4yqjzfmej2Pf9/EqnslnRx0VzEHMLDe95hhm9QiuSqzi9AJZXg+1jzSOS6AuZjwc56
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C06E89CAC83C245B818AA6DBC466F8B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 U9pmuek0yYjZjRMKtpLgmexvcqddKspnGLIM4BE03dt4IJ9AgNTLZ3PNDGAfeiDv5De28j5m/4jc8JxIKYY1o+d68rprt/nzr4I9369JcCiTH/JaQVIR47SAMfmTMzhXVa3gnijhbvhxcOL9qn15ghrFP+TmTwOrCsFbVfwa4O7Z+LkUy1097YeJbRYepMrEs+wkDrjqs2HKhlpgIDlGOTk8e4JpNa4CLb6t5lRZzrnCrBRCKWtb4HOhXh2HTBeTb3EpukEraXamTfunTG/5o8jPbC0nliiIN91sglWkK8DeyVlxeQnqorexMALC1bs3/uGYDETjfg+lvChGG5XF7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8309
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: eba8b737d1af42f4958b5d4547eef157:solidrun,office365_emails,sent,inline:51c2f25af5c28c995c24baa31bf88b29
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	45a50b5d-903f-4c1f-7c1e-08deb01101a6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|35042699022|14060799003|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ojiH+cqVJz0KA8QaVHGCwzCP/YOe1MRsgVhaMyxgbqXvfO6SIS33XEowrBVY0j1/J/C6ctgEXCEf4vPwROtWKkL6/NJAP810G2mjHnLB8I0YMGYOoaR8hbrIoLtqWRRa76t+KkedEAlwKxW6aJ/ze069mWjK8/d/LSYiYMgmPVgwZx2wn2tbnjKXhr1ngJNL1hoEebjDLUtZJhH4SmSyD+4moEduUn/EryfQR4Ugtcio6mECrcgq9cdT0y0ly4g7QCu22E0cj7/lcvTURk+Uuz2+l4vPJWaAek7hlKI0BDCrpKX7mcVcpzUasB0+VHruURCaROgQeI0Tml0mxWt6kj4gTiHsOCB8HXOyVMnunIyUEvsvq7IMRQpJUr0PCvhvmhYpW16/GKRmmBwky6tQzW+QaZZW84HUUUFp5384fXPVM5x/3aSF/9CPksVR13uBu/nzmc7erckCvHMw3y3smFriY3unRahOSYp7MriFMgtz81JkjEEHhpJ1P0rsXgcv1U5rQ7agZ45Nja708BBiydkApCkcQ/GowxST0/RhCdQ7fxy3TPXNfAK6nwmr4kc6lhdbmHcWpLc0+1Mm6z2pFKumiukkmTPmJfpqyZptJSBZlVDLb9I11H2aiZUjRWzn9PU+ri0XQsZ375gWpswTrP7eXXAjqmQ1pBDfiTJc04V5SRIkU6WiJFWxaAZxP4Bz9IO5qj7Fc4d5P1H66y8JyW4lGQij+tsTUFmvkETNcgs=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(35042699022)(14060799003)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+FCR159PkOTB90SrMYGbVQ94fpFR2KJGdM7vb8wpf4e+2HUqDEBcXhuU4goAJBKdSCcAHhRuWLbSfG7zxu92C/mZuaqhkQzct+KvKkyXL4S8L4UJH64QbvkAq1Lc3aND3uEHdpm3LtY53X0mV0hkqHuI9U0mxI9aCzBpJP2dPf7UlBUit0hqNjJ5AcxhxtR+7GQD6bUGhlKSRKpkCfFC/Y+qjc8eg1Nm9oWlEua/pTY2OW8ZAhazt/EpsqYNco0CJFz4wHcRyzGRZpTXJ5vDY5r+SyPO0F9C7Xy2AQG5WmSwL1A7NLXEO7Ikc72x2SMySa99Rrd5jM/eY4lfv67hrn/aleMU9ZuTCrG8Yd3ZhDXLosvaGxSjQS1MDFAoEX2URzkDpdwo1XvDnXWrNNTbSFx+dSdT44zXY70SnNoZMzwQCe0+4kWanGag5c49i7DV
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 10:27:18.9927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef66ccf3-e019-4665-59b1-08deb0110bb2
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10986
X-Rspamd-Queue-Id: 9FDB851E8B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,davemloft.net,google.com,redhat.com,solid-run.com,thorsis.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com];
	TAGGED_FROM(0.00)[bounces-287070-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

SGkgQW5kcmV3LA0KDQpBbSAxMS4wNS4yNiB1bSAxNToyOSBzY2hyaWViIEFuZHJldyBMdW5uOg0K
PiBPbiBNb24sIE1heSAxMSwgMjAyNiBhdCAwMjoyNDozOFBNICswMzAwLCBWbGFkaW1pciBPbHRl
YW4gd3JvdGU6DQo+PiBPbiBNb24sIE1heSAxMSwgMjAyNiBhdCAxMjoxMTozMVBNICswMjAwLCBK
b3N1YSBNYXllciB3cm90ZToNCj4+PiArJmVxb3Mgew0KPj4+ICsJLyogZGVsYXlzIGFyZSBhZGRl
ZCBieSBjb25uZWN0ZWQgZXRoZXJuZXQtc3dpdGNoIGNwdSBwb3J0ICovDQo+Pj4gKwlwaHktbW9k
ZSA9ICJyZ21paSI7DQo+IEZvciBldGhlcm5ldC1waHkgY29tYmluYXRpb25zIGknbSBwcmV0dHkg
c3RyaWN0LCBidXQgaSdtIG1vcmUNCj4gZm9yZ2l2aW5nIHdoZW4gc3dpdGNoZXMgYXJlIGludm9s
dmVkLg0KPg0KPiBJZiByeC90eC1pbnRlcm5hbC1kZWxheXMtcHMgd29yaywgdGhhdCB3b3VsZCBi
ZSBiZXR0ZXIsIGJ1dCBpJ20NCj4gd2lsbGluZyB0byBhY2NlcHQgdGhpcywgd2l0aCB0aGUgY29t
bWVudCBpbiBwbGFjZS4NCk9ubHkgc29tZSBzdG1tYWMgZHJpdmVyIHZhcmlhbnRzIGhhbmRsZSBk
ZWxheXMsIGR3bWFjLWlteCBpcyBub3Qgb25lDQpvZiB0aGVtLiBpdCBjYXJlcyBuZWl0aGVyIGZv
ciBwaHktbW9kZSBub3IgcngvdHgtaW50ZXJuYWwtZGVsYXktcHMuDQoNClNvIEkgd291bGRuJ3Qg
bWluZCBwdXR0aW5nIGluc3RlYWQNCg0KcGh5LW1vZGUgPSAicmdtaWktaWQiOw0KcngtaW50ZXJu
YWwtZGVsYXktcHMgPSA8MD47DQp0eC1pbnRlcm5hbC1kZWxheS1wcyA9IDwwPjsNCg0Kd2l0aCB0
aGUgc2FtZSBjb21tZW50LCBhcyBsb25nIGFzIGl0IGlzIG1vcmUgY29ycmVjdC4NCg==


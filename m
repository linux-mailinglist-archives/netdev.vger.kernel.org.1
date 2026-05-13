Return-Path: <netdev+bounces-287518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GfeGeBTBGp/HAIAu9opvQ
	(envelope-from <netdev+bounces-287518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:35:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C91695315CC
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB3E30CF6DA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D29D3E5A15;
	Wed, 13 May 2026 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="laP/+dcJ";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="laP/+dcJ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020119.outbound.protection.outlook.com [52.101.69.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCEC3C6A56;
	Wed, 13 May 2026 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.119
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668397; cv=fail; b=d0XG4h9ORoBnxJYDJYupIbJKnepoRaJpeX6wlGBD708aHuyCKN/KFeu9ohveKiqSL51egNiXe0ovMGRnBGP9dhZek5HKzQilaKGiHqacSsK0n8SNXGOIjkwXJWhBFNkVxL/IrUYejZn/SpEhpOaC6snbyY2cuZwUXPdWSRF0v9U=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668397; c=relaxed/simple;
	bh=pPaDnuEiTfGeLHrG5i6/a4I1Cig4ioBmz0lJ7CRk1/0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=gYcLWYQ7wFPZ01Bg9YxB1Tz1Kvno9/xACYaq9s9OQAQmJ2op7zFXmmIubDdikUkMcjp1qpHYIWf1RZruJ27ulu7pQ2tUkW2g6K1lmJD3slJ+Zf7TXDgzUHYMHpKQ2pk4P/qUz4/j30/4C8cpHKtFVm+gEpaLsjvB95dDyZtnKWY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=laP/+dcJ; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=laP/+dcJ; arc=fail smtp.client-ip=52.101.69.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cutOkbuqN8rfavyONrm+cgXL3YIqTY474rrqW4eHInZSJi0QNIElL6QRi9cfkfgVYob/sCa+BGAaexwHLvz4AmY9vvJMXP1sJovBfmuZFQdHV1Bu6BGh1PSnuVq98rcnhtg7nIio6HFm4Wjn2GGFzi4vZZp6hvVNo1TVabfgRTkg0/NJeJtVtm0fRZOEZ0yva9z9Q7EXYB+IYyOcnSuQMwqUFql7IuygVK7QdpeIuioFeKQePGNwuaHKD3t7DkHfFTPC7N5HjzGUO13AJBKb7ogFpZMLMsWcRX/ZWFNsGdGa3swA+j2ssh1cSiAuzBRPVE8ThWUdXsRD/IlH23XUxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ+zj71/YNH4j55OLbywI780kbju00ugzhWkkawyP88=;
 b=qYCFf7iP8+gjQWhonAFMw8RwugVyWw9vrwFgErwk25n14GA0BM6b1eW5SDJX7lVNAJnBCRJ2KJqyDo2IGobBBjmBg2lQJQ8OCVRJ0J7soF844lacLDQcvbYY4ogdN4UhMCebAP3X1q0RXJUg+fb8b+9DeEU1ZzPHZhqtovAocE7rAAo70UISl/htSxtfDguOJXhOFthPY65mXh3BVAUVwANjyKnLE31QOb3EfBsVuR4jLeq9R0jo2Os6TPVqaWYM3Px2efohSJR/P01UtLxMsnAiK592mUTwGLxl77D437TrUGon7/DyXkfLjG1Da6+6YZOSvgnLH/LxCJgI2b76QA==
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
 bh=QZ+zj71/YNH4j55OLbywI780kbju00ugzhWkkawyP88=;
 b=laP/+dcJ7hnPWsLQwXF82IN34AuIrN+/EN6V59gw70K0+OpfDcdR1NxScPtjIqvk5K6r5xp2eGwavax+s6pCyi3YuKHbMglsAVYI25oU8K/niehBCwDrDQ1yjBKnH2XsiwV/c48WiIBA78DsC/zuhIaSpC/XzysDN5rT9bndZbV5LWCIy8zZqFGhc2aUjvXlZyHMcd/UF8ZJAXS/RhhlCojx/RTX25QIyFo4pAXA1RCdMitHG7p5NbhZINhxCy+8II2pp+t39acf3yWYmW8q1BKdo4HfomrKN53dUl4uInsZxL+LBI6tgA15KkxyLUn1UDaXoR+1/FVFYEdyrxbePg==
Received: from DB7PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:10:36::27)
 by DB9PR04MB9555.eurprd04.prod.outlook.com (2603:10a6:10:303::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:33:03 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:36:cafe::32) by DB7PR05CA0014.outlook.office365.com
 (2603:10a6:10:36::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 10:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.8 via
 Frontend Transport; Wed, 13 May 2026 10:33:01 +0000
Received: from emails-4184520-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-220.eu-west-1.compute.internal [10.20.5.220])
	by mta-outgoing-dlp-305-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 73AD27FFD0;
	Wed, 13 May 2026 10:33:01 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed May 13 10:32:47 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roIFh9XGks5C4FJmoufRysIceQqfIB0PqyBiwv6NyFFGRM1RhOXDl0wiOFwj7Ovcgc0ot1G5gZ+Kr7oQye7M3CHwkCv8a2I1dUQpgRgHmCT0jO/Z0I/RaULCPJCz525VL0uBeakX02DeOWUIMKY5gXM1JAWQhVrAu0C2VOro6TEU87S/g1QwVs2T9D8sMgHna7O3WSfeSiXdloaVrYVRmjIohu5STVX4Ea4lqq4GVGU8Bs0bbhj790Ive129HmIaLOm0VOzqtrVauytcJgQpLkf9dZDlK/tgkAn60RlHdNkJQ50KM7Ll5W2iORMYJVlhnfqkc9h44mlXjuNCiYnTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ+zj71/YNH4j55OLbywI780kbju00ugzhWkkawyP88=;
 b=L3n0no6H0nOy3tEj8Z8vLPP0LKXJkCVdqwBloKejeOSE8IDg72NWC01/4Z2Cg4h5BxABZBU8jfJDoafqzYkzUKSJ0MJvClV18wqLkf4LS1otPrAYxct3V4v9zFgf/QvvBQLw8DL1Lqb+FrwPKfBDzdobbnb+eq1gWCogoyH/Xkr0gov8H/8qbzM0qfZVPf7YSGYpOHce1jCI6R0+GrZ3yxDlI4CqGcpAoN9dfdIRWroAk3Jrv3trgYt+qRS5YDfdjf0RnmedgR4XgHmdEzzbbxKSTNjHgVAskjaWEsTd71sYWOZ4H28u0k8Ht1LFbZrGuZxY0KIKZZta70PUBhkInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ+zj71/YNH4j55OLbywI780kbju00ugzhWkkawyP88=;
 b=laP/+dcJ7hnPWsLQwXF82IN34AuIrN+/EN6V59gw70K0+OpfDcdR1NxScPtjIqvk5K6r5xp2eGwavax+s6pCyi3YuKHbMglsAVYI25oU8K/niehBCwDrDQ1yjBKnH2XsiwV/c48WiIBA78DsC/zuhIaSpC/XzysDN5rT9bndZbV5LWCIy8zZqFGhc2aUjvXlZyHMcd/UF8ZJAXS/RhhlCojx/RTX25QIyFo4pAXA1RCdMitHG7p5NbhZINhxCy+8II2pp+t39acf3yWYmW8q1BKdo4HfomrKN53dUl4uInsZxL+LBI6tgA15KkxyLUn1UDaXoR+1/FVFYEdyrxbePg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by GVXPR04MB9802.eurprd04.prod.outlook.com
 (2603:10a6:150:110::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 10:32:43 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:32:42 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v5 0/2] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Date: Wed, 13 May 2026 12:32:29 +0200
Message-Id: <20260513-imx8dxl-sr-som-v5-0-d0899b371c38@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1TBGoC/3XOTQ6CMBCG4auYrq3pdAoUV97DuKB/2kSoaZVgD
 He3spEILt8vmSfzIslGbxPZb14k2t4nH7ocxXZD9KXpzpZ6k5twxksmmKS+HaQZrjRFmkJLHQi
 wGgVChSQf3aJ1fpjA4yn3xad7iM/J7+Gz/qV6oIxqWzRYN9pUgIcUrt7Q+Oh2OrTkw/V8TtQLg
 mdConOclbxWDVsjcEYgWxA4fcGVLLWrCqXXCPElCoAFITJRCpSgUDnJzC8xjuMbH9EN23kBAAA
 =
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
X-ClientProxiedBy: FR0P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::12) To GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR04MB12057:EE_|GVXPR04MB9802:EE_|DU2PEPF0001E9C2:EE_|DB9PR04MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5799cd-6395-4623-c397-08deb0db0245
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|18002099003|921020|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 hRRm91c6LC+fprN8Z9ph3zF0B2bes3KMiNSZiLAHay/Aydvc31huChVMArZJC3b5tqwJHWC3pmESaRM3JVQ06LzMfDuazTp7i5DkQ28ZnMPomABTN2UjPq4rGIXKHPxZ5wI88dOkPqd9CDKFoXkVZK4uFnxFgqaJDSBJGBJzfTMjEpKcy3awJWIfZTZRdYC9hTBlQzTeQm7hc58rRx7atRkKwblzom7WNDmiYLugxj0IH8i3HuHthnQ0kPSyKDhaq3yA0uWlq/TFvmoJOdPUDZ/LS40OT5eEgtcctn1ee1+ScHq53zRRq6RBVKF18o44I4pmARfDOVL9iCYksEi5CIbs4/OZ53oo5V8Kvlibq+wNbeLFc+yC+4oHgfWXebvJCWNiokp/z1vpagiO+l0/xKfO/NpJ6V/fH4HtzFfrbf8+vHUInkFkRdTkG6frgGe4niOwUcsKKfFkaAZFOpdKgCTiVrVBwxnAjVP0KX+v9ddSPSWuqSfOF4r9CdhrgduM7maNPgv+76mDODDt3XBHhFzeWg3+ls9i5cD+PTsWUoK2rWrWotdNKk+Y+4oi9DuXWSbxH6sU9XW0jA0OND5J49soJw6rj4/uBX0D64rwFS5G2TEqW8AUkmOmJ4sQf8DTbU6w7lawMVB8A6nGSoktZT1rIDcVQ6dxE0G2WKSyV/8oRWvbvLOjA+tIQmV2LZ27ypcR7/UTGJ0r2jTnXMDw897UnI2hvsXazAvXzOjq9VC4bh3+5QJXf5vt0BjkcJELb7ntJ/m27izGPAP6AD1mLg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(18002099003)(921020)(38350700014)(56012099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 noK/1Wt2ZE2aN0HiR4eoYZSAYiaQ9ymjSzgYK8dM0KEF+wAWToejycgqtW8lpoc1Baeewl/nuZN05xCh3866EDhXeDJlR5GtTsa53f1CsSz2VlA82PFrpxMxilnXgYMbRnKaAP1qiWdmO6NEWZXOErX2taQ0r9dSzHP7IabsjeQYkkkb2dVa3FVTSKibHIcS0dHGcsosNLGqOYuAyVE5p5p/IEVB89POoK3Lzct4mdJb31s33m6pQwAMLP+wxbevBbGQEYJ92RkjBv+jwbm9mbAEo5QPCGNCrt4y9LxmY9Dlcnk/DT74ZIb277o7YJ5enTjAmOuvdK4pe6+YkiJlMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9802
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 9364bee21a374a8e9819b3b0d55fba60:solidrun,office365_emails,sent,inline:932655bd921d1a8df2b3aed684bc64d7
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	56dbbeb3-8135-44d7-1c94-08deb0daf6da
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|14060799003|35042699022|36860700016|82310400026|1800799024|13003099007|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IINjZmW8XcTInxcV/f7euE/wxocMq3bG9ApoybRN/U+hOHV7tpi/n/q0IhN7YrJfMRWljeb4AeRxn3AXY6/DtVCryFwSUGOETDtLCRgE3Wy5Kmicy10PopgkRC7t24JNRp/XtWPTjwpl5C5UOjrtb2kA4uu0btzv1ME0JYRdh88TtZMZ+r++/Z1Fvb785CiNEcYi6E71Lxz2TUKcBGonGAHZCHVdDccu4uEOsfiboUsNO1FGTp9XZesuUE05eepgZQ49EAg/fGFch1eVpCVulqzdjRIQ9x9pSndOWYv/TqJJAb0TtnZ3yhUDuL6381cu71C69o3Nui5IfvvCSF0aY6qPmTJ97iPJhNQJiDinAsY8gtVK03CyAg2IIv3R5L3RZdPNCZEFbXP7PUDONlEKfK4AD8q6gWEJtiiMB7j4bh4mIfHFZpjsBLtQL2cV8OEuvNkpZcJkPW7WQo1SlNhYleA6vZTEO/uOhp7SXw23hfZx2BbykQB5HKZaZ1t8nUWcodZs9FCP7cDvD1btumZo2U20hPzKzLC7+TEk4M5bhqKsdugxn3pTkC7y0kFy5LRn9MWW9dJ9s4iDxHfk/efcmsv17Vf1inAX28jnDxwrPxfyrrCe5s1x36gEfX8mFDRj7+eBdsZyFaTN96psPR2bVYi/+3lyXzzFgf8Cmn5WvhrbwUIPg/CuqY7+St4vT0d4QPGlA/RvlLE5BPWLY53UAlSSFLz1P8WfjLHcCDHs+mZBws1UFJ874C5fdzeMG8kwKK4p4b02Ka6CI/+Kaai12w==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(14060799003)(35042699022)(36860700016)(82310400026)(1800799024)(13003099007)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F92Ai06/JVyR+/5xZccGoXuFP05Y3sZOpWBXwqEeJf+xys8x9wKcCxf1mW8DZNH+IfXyDaMlMitNoqYDsXvC8/TIdmfIIdn1wGQeQIxzRoNxG82eBlcXNYfVQyty2tpu3UcjtzHCQIeLnYG+XZCPTb5+L3JmznThUX3lNqZMRAKTVzMu2+zWGhYcgrlYPVJlPBaZTnHYy/CNuYEkUkG/qB+qT+UuSLeHUdS5TtRCe8DwEeoELtW8Mt2ifC45Dsi5N9kAABWaqVZ8tdyQSOAOM9craVFKnpg5uXVAGRurnKBI3LiLXNRzmAbe8741U5HZZZvLieoWGw72noyC7Jt/cw+fW5yv3Kxw9UNDr5G1ID+r6BlMcwHh5U6TkP1NqdtghBqLNhfTluefrDHBn0QI4pEE2vSZ/FMReoDuWhnQq2BGtw2rCsBIdzynqokQP1AE
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:33:01.5203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5799cd-6395-4623-c397-08deb0db0245
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9555
X-Rspamd-Queue-Id: C91695315CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287518-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:email,solid-run.com:mid,solid-run.com:dkim,lunn.ch:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Add bindings and description for SolidRUn i.MX8DXL based SoM and
HummingBoard Telematics.

Modify SJA1110 Ethernet Switch bindings to allow SPI Mode 0.

This patch-set is based on v7.0-rc2, because rc1 was experiencing
deadlocks with imx8qxp clock driver.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v5:
- Change cpu port phy-mode to rgmii-id, and set zero delays. Delays are
  added by connected ethernet switch port.
- Added ethernet aliases for all switch ports.
- Removed undocumented reset-duration-us property from usb modem node.
- Fix T1 interface count in commit message.
- Change USB-A Port dr_mode to host.
- Add cap-sdio-irq for wifi.
- Link to v4: https://lore.kernel.org/r/20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com

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
 .../freescale/imx8dxl-hummingboard-telematics.dts  | 536 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi  | 458 ++++++++++++++++++
 4 files changed, 1003 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260408-imx8dxl-sr-som-f141ec343173

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



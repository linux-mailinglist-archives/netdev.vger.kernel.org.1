Return-Path: <netdev+bounces-282826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEIgKYxI82kMzAEAu9opvQ
	(envelope-from <netdev+bounces-282826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:18:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC784A2AB7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1491230028E7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F540244A;
	Thu, 30 Apr 2026 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="rzmo9lsq";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="rzmo9lsq"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021086.outbound.protection.outlook.com [52.101.65.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C1258CE5;
	Thu, 30 Apr 2026 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.86
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551494; cv=fail; b=YagLTUZCXDA4ih6shiuyrPs8lJNRnx7AdXUN809emJ/fRe931HtZTe1wqA2nTVWUVKhjpOXPzzNUMLLs3SLWA6QP/lliCGBsCeY/pI/E1uTQ3QgnqVs2kzjAoTdoyuynyQ17GB9iLw30WjYcXRHjM9CR6PNxIG2jvp0E0DiJ4hY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551494; c=relaxed/simple;
	bh=pPy2cIWoTmGIz+Y1/FeNVME9oqkbocOhVZWwlGx+6Jw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qgrc987vQA1qspz6pcvGUAYYu6HT4/C3qusJaM2P6g6faTewWGeesdUaaCnxAARkt7JvN3ZSL9XbF1X6hKWSfiISdIt3Av6TsV451QWtw7K4swHpkD4JYlbQs4r/IqvlJBXyHuwhoCyhxMU6Idx1iJ+p7a//7XmYknk4DBrQ9yo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=rzmo9lsq; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=rzmo9lsq; arc=fail smtp.client-ip=52.101.65.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ApSomFFQEXHwDnKV3Y+8N+mWwUMnrvsgW7Z0JF/el905bBkzgd6YV8dN7u29XmPFuupy84Qna11y3XAnW3/BYZb0Iy4WO2CltR2YNvqTXwkQRF6j789B1ijG9c6sDE+l8HhJH2tp5u8lfMsWZPAfyWroUS1QG8viBTIxqHQh1iz4oFTOYbe0ZGQ/zFu9KEBNhH/0A9GOVbps1ZaSLRT9iBdcKVN9FF1fg5stcI+DQWbnSJwJ0Flb7eyatUpGt3xNjo+QJlKBJqVFpR4KA20EPcJV3ZsF5gV0z0n06lnccOXUNSz6tc501936FUEoPVb4e3GwJjV+q8b62SePpvhPrg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=jHODqaq6/uumGe8AxmzK6KnyXHI2BjPXnbDY1nqa6Noau4z2nHDVAYqBWRLULzJ7AJ9gM65uo8KHmGLMWKbuep71/CMlF7ubEu2Q9toJaGug9FjGeXALY2VTTrIM7Tl3uevBBl1sQDh4fWPKlmFz0kF2qokcTSai4TZFvnJ2hyCssdGYmkumYEMk+bXjgdLxC9UUhZ6Pqwxn8TcM6F8uTDPBoALwKgKWmgi/egoX29Dm+49ZZ+5zUAk/5IZkt/aS+atu4n5aa2dSaB7kLBz+wRFaMaJXg6UPExhjkCDMco9LfF5sTV0xHOMcQKaVQz2ddxm26DN9bIJKptPHFVPZVQ==
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
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=rzmo9lsqy9obwcd61UHghqVepS3Z6S9M78JsNBYGYe+IX8JSMx9092PgZHHFMnXfA6L8UU/gM/VBM1UY6NMfX5mJnPGEtGBKeaeOgnGnQ0PIIfSlAY84SBkauF9KoE/H4s9Wz9ABQ70RmjuTlJeJ1ICCREgEtw6qWluM3WAiaHWoBxvScIFxRrnTfbM5CTBZDBN64/I+EOPCkWuGYqehSgxxBa+x10FSVDLNJoWGxnGEmzBYy+xkyhiOVXXya3RMDDUhTPMlKdTwv2Mq0WN2cyBGXfERTT2b0Dh8xvScK781WuouA1o6mJqKiK5tl30kzU6AnfpMCwptPcJQcT/5Iw==
Received: from AM8P251CA0002.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::7)
 by DU4PR04MB12328.eurprd04.prod.outlook.com (2603:10a6:10:629::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:18:11 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::13) by AM8P251CA0002.outlook.office365.com
 (2603:10a6:20b:21b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.22 via Frontend Transport; Thu,
 30 Apr 2026 12:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 12:18:07 +0000
Received: from emails-2787664-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-243.eu-west-1.compute.internal [10.20.5.243])
	by mta-outgoing-dlp-291-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 1FE7D8071C;
	Thu, 30 Apr 2026 12:18:07 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Apr 30 12:17:58 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrfQIURpcolDj8g2a8gvqPeozqfj5yGaVwwW81S4m7gviw24nI00ac8SJIdv/oeDcL0IbBVjoDCtPpUxTF3a84KcnHDpXhjR+tqjvqP6OwmpVSw0yvQSSiXdHKsxm13dHC5wkzxgGk0zo6Iui6vkJ++RSXeqVTa7HbT1bOEJt4hIJhdzaIh7AHz+HXpMfNugbZExtOzMjTZFtXFQp3oZNMXae3HA8FWWetP6KA+yEKASXQjO6H9pYZGHH74wNqVzQQY6kuzFLfpMpAr7vOcNKlr4H53IcLpzWzhY6JMh7c30PKP+4BM5AMD8JVCCtHMaj5XS/BfC54hkKOSYWc49Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=SleED68t4TJzlLtnLZWgJATsvr1sUfF0e6ZdFMd8Q2pSud6k/q6DDe3FQJ3MN3URLojbPmJH3k2LWDo1IsdmkbgOW9gtvBh8mueqyzXTUrp4N0dvpMDL6pQa2YwuWU4HZzASs7ZHK49H76VJUxxoDiu169m0GGpx1BD6fj713W362YlHubojZm22baWgIIS7lEpakd7eYHUbH5sMolH9imaiwfRmoYQLkFXcm/r8OwsFRIjpxFbndgVc4u15SQx11vVOfR4IHhMaiiD1aRyELOD9J9etDP3qyr6TZC6iIqyF0tKlQdn/45Nq5bpVHeJPFt9ElY2n58nFrdXD52TIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=rzmo9lsqy9obwcd61UHghqVepS3Z6S9M78JsNBYGYe+IX8JSMx9092PgZHHFMnXfA6L8UU/gM/VBM1UY6NMfX5mJnPGEtGBKeaeOgnGnQ0PIIfSlAY84SBkauF9KoE/H4s9Wz9ABQ70RmjuTlJeJ1ICCREgEtw6qWluM3WAiaHWoBxvScIFxRrnTfbM5CTBZDBN64/I+EOPCkWuGYqehSgxxBa+x10FSVDLNJoWGxnGEmzBYy+xkyhiOVXXya3RMDDUhTPMlKdTwv2Mq0WN2cyBGXfERTT2b0Dh8xvScK781WuouA1o6mJqKiK5tl30kzU6AnfpMCwptPcJQcT/5Iw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by DU2PR04MB9177.eurprd04.prod.outlook.com
 (2603:10a6:10:2f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 12:17:52 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%2]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 12:17:52 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 30 Apr 2026 14:17:39 +0200
Subject: [PATCH v3 1/2] dt-bindings: arm: fsl: Add SolidRun i.MX8DXL SoM
 and HummingBoard
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-imx8dxl-sr-som-v3-1-ce2b86cf75bc@solid-run.com>
References: <20260430-imx8dxl-sr-som-v3-0-ce2b86cf75bc@solid-run.com>
In-Reply-To: <20260430-imx8dxl-sr-som-v3-0-ce2b86cf75bc@solid-run.com>
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
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR04MB12057:EE_|DU2PR04MB9177:EE_|AMS0EPF000001A9:EE_|DU4PR04MB12328:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b9f386-203b-4c00-ef21-08dea6b28981
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 E11bka30/SiC1A2e0X0luxx1D+rfJxcY9x+MVndGhSAk8OYsiWHIUPU/OyxJJrrH/I0BWk9F5fjaBPNjX18NEQlBJifIH8OhZj3dnKd8s25dMbCK7Dovs4Dlox1hrStX9MHWdYdGVSV+yb3Zt1MNFibuLD+GaOrczUhSL0mwhLEXfhbHyMCrr5kI/OBlJoaSKhzWT/v2COaOb/A4RiemKToR9KTjuwIcQebSF1744880P54NhTXDoDXIjx5vseijo5WDIfzu8czby2WQcpDg+nCppDNrOHe9PeMoH+YDutOMMKIAr61Hy4JhctgK+dSj1ZeAwcr6MywtsGRZ5FlvJcIxcPXmWRdUxhDXI2UkyHtl+aCtLKWj00xS6ZFIDZSsSfPHCP/Ytmvqccrqii1dCnMB2CsvIG0ySe+XFDIiq1IpGDqQyOfkwkgoNexwS/dpn2RF13L2C4dEeS5J6qNFtcDCwGMTbWGoBqPWMn7a0y2J4i0RAzbRsRVAYKadQF1jgQT65Q2137n0LT1AfsjYeJPbVhr8Kn73fSkftPLS1e63xiRZodoq7xvT8WJDB8d9gFkr2JlrL7oayAaZdrZqZGKuhm9Xdj3nOz5sOebloFrCFtmOlEdylpGkSEqn7QOtFRdpK22KQAtfOI4R3LwgHiD39ouSKw4wkxaXlN+mZjTk+P9W1lSxUtQ0GMrn8v1l4snAdWSe03NOsSXypVvUXI95+ZW/Pqm5pe8+84px8HqAi5keYA4frN9Ho4WFDEQjLrU9XemN7a4/i85izM7/S4Onn1W9FqoJsB1VCVZtq+/WJTQsOgKKmEdRQbTz/cN9
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 ChgA9D0iynFFb4mKEySSlYxqaumcyVhUee7SpIGLpWGtaxhjvISHEjvi7GhulzthbuyWyKgXIvTK33C7jMAPoE43Lvg7pWJNHgsAaKr0hxDi3vsrWhTc4scRZyRF76ZT7eP/2x0FRZu0J40aeMi1JDBht8HyzZHRL+1v7a/pQ8Hr+wYGOaTvlw5FsEHjip0mUXUcLzBKbL5fqf6Wi2P7s1NeQXgD0hGul7R6ww474UMGPyq4hV8EG6BLYd6xGDx4YmgLN1ltbcjpzFHLAO04T5Zm9W0Itfeho/F4r2FiDabBwthvtpV7Qy5wpMLBKkrUF4K0KMR2q0ru/apI1rqHdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9177
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-6.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 726d87dd4004405895d822adbb65218d:solidrun,office365_emails,sent,inline:65e85c2bd07fbd1b22859550c7174672
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d35535c9-f01e-44ca-3f8d-08dea6b280b6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|376014|14060799003|36860700016|82310400026|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kgEZbopOlGfCfHIlavLxiubl1aOt7cmB1qWqGhV6RkKIuuVC+YpNSyKuSk9WZUMwp/ts+iEgs5mOuWguNVUxmpB1R/YIZVdQw0vUFgIjZaYl+WxP09gFWsdDMbhxrXIpc2an03kjCLfQWloWdY6n0rRLNU8wXaQHPqg9v6py3X6Ke08gEwlnFpFy9pJsZLzVtsVJzx+lw736exq8GmluYfzvgvR2WpFcVC4r0Q5iaTBfq/FUbz5XumAaaULKMww8RIaRZRRweVta/snn7ocSjoGbnAE+iyb815+Dp68Z3/VxnKqy2UXwbfkPycTbTGj4j/Uhc0gSEZoFAqEIvJcUF/cdJYcyc4wkj8PSesY/GZkMxZ1zchq0r6ReI9fazAZ+CPtymcDPBkdag/ApGVMVH12iwzWJIPgmvBdy1lRK/bOvrbLilf0fQX/1iMhnjPYGhniKEO+idXn684BYDjfa5BM/nOUpu2BtkpCE10Iu8PsPt1oM0w7w7eO9j+NGav07YRSU+8lOP/kEbFK7eqCZbG4/aFtPViscPSp6RamZMu8QNwAGOzRrFAnlX9xtn2e+avgzhuK5by/xEhGOH+lR2a72Hwzp2mJQoFsI6IRj0Od3Q8tk0vn30O1a7zM2Ediz1iskNiHMMUeLjottKZ2tA7/B7uo/EB3RX2Drlqloe9F0m71DKQP1Y/884rXV6IdBJPnaQ5Zb5yUxx6nZFt8dj3zxGS2aXvzjFX+Dy5rzjoGwxC40cC1F4dB3VRc3FFo/viuCHwg7xTCvSIxyNdM+p0wucoGzadnKs72UUBTwD/rgkvZ7PRO3ry46lmAbU13s
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(376014)(14060799003)(36860700016)(82310400026)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H9SJwiN9GYEGY/vaDWIoxUGS8PZQ+ZqASUIs87B4IyCjOkQlQ80XngJfyHC5xcs4oQMXUxN5OIEak5W86cummXKxVfwPE7bTQmNuYjamzxNmeZPxnCPfvyySJVqQ0t2MpWo/ffNIzcDDOiByw1bhc4/X2hWtzZJdfVS+nGqpKnT0sv1rrPxG3MAOwn3i5YHYSTRunrk6/XX8k+8R5H7z7Sp+SfvF7HGyt6B0nx3wxA+zNqIGuFVcA5U8zpTF3Jme8VhlLpYOkWUih4aJlJoud97KzoAin+3gbw3+8HOpbP9ARg/qqTHvFha364aHDMx3eR+xRLCNjop9J8XJX3kMWfo0d4kCPm5NAqqXQ2MHBwYGra2a0zO/+zM0hVROuMlUXx5Dz4koUjeVFk0RWdiGnCS5OxFDB9nOPJ/4oXAMfx/fVaTeyFWamZsvepCTrXkW
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:18:07.3661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b9f386-203b-4c00-ef21-08dea6b28981
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12328
X-Rspamd-Queue-Id: 9CC784A2AB7
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-282826-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,solid-run.com:email,solid-run.com:dkim,solid-run.com:mid,qualcomm.com:email];
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

Add binding for the SolidRun i.MX8DXL based System on Module, and the
reference HummingBoard Telematics.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0023cd1268075..17cd47e8efce8 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1394,6 +1394,13 @@ properties:
               - fsl,imx8dxl-evk           # i.MX8DXL EVK Board
           - const: fsl,imx8dxl
 
+      - description: SolidRun i.MX8DXL SoM based boards
+        items:
+          - enum:
+              - solidrun,imx8dxl-hummingboard-telematics # SolidRun i.MX8DXL SoM EVK Board
+          - const: solidrun,imx8dxl-sr-som
+          - const: fsl,imx8dxl
+
       - description: i.MX8QXP/i.MX8DX Boards with Toradex Colibri iMX8X Modules
         items:
           - enum:

-- 
2.51.0



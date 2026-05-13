Return-Path: <netdev+bounces-287516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGyQBWZTBGp3HAIAu9opvQ
	(envelope-from <netdev+bounces-287516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:33:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 556E053154C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672B03023DFF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E556939A063;
	Wed, 13 May 2026 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="kukLNyG2";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="kukLNyG2"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023095.outbound.protection.outlook.com [40.107.162.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0139021C;
	Wed, 13 May 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.95
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668386; cv=fail; b=MW4aIlbuIZ4wPH1k3/1Uc8pz7HNPJ7Y/9COzRy/fwMx/Mlhh7kDCQXF0EzVuWQ/RxxV2kf4aolVhakNAElQRh0s5pKa8xe5UZy3gQhSvHqEwpfkzoFJaPGzmuStsESli0CDpIPjL3dZKb7UN63h0HJLnEV15efOGZy4dU7ytsNQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668386; c=relaxed/simple;
	bh=pPy2cIWoTmGIz+Y1/FeNVME9oqkbocOhVZWwlGx+6Jw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cmCro4prU/O07wEleiksyyCxLqy65IuCQY93uvgqw51eKnjXHs3ATh3wqDg87bQYimlB8AqGMcs8Tayf+QwOkB6JCVmDJ9nfF619McquZXrYrNuVoJoFVf4lYCXE8Gl+OBhMyOTSQibYuDBMyqJlcoijqQEFcj7VUrkOzwai+sU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=kukLNyG2; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=kukLNyG2; arc=fail smtp.client-ip=40.107.162.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vNOEHejp76f2vx1TDqM49SaZnMbvpkpvtUB2pOYTZGdO0bgoPlTqlVcJxAKVAWTbvmGdLJ96XklrC9YdTImHeKjkTbbz5GycOL6AJcZWoCMBTBhqZFAY33jA4e9X0nSmy2pT7Y0A8TjragHKbS3s9TxpjKO6SuCl+8EkfLhdC+3/EJ6kuoxaoQIly5X/ls5Pgi6UHdwp3PITqSSDF+vHbGm/3offdRPgtd9udwgW+1lHkEYI4zsJwq8PRHgFY9BJ75P3Tcs0MfV7vjilAGvNnh1upkTsuL38FhqW/EK8+KGOK8A3Dh9RmYoNsoktDWpsRL0m+za3ZIw2hEPWK0B/1g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=wafIcb757RCeB0K5jao3u92toR5z+ELJ+NbzOsqmae9yYWRU4KozGD5KuTRV0tplvkAwLpCEc/WO6NFO1X9hPgoNf8Afj5bSbU7K6DTk7GCMq8Ou42egKP604uKj1YaiMQv4e/pV/1XO6kjxSFMgJKW4kiNAa5FCrXUg8BK6xvhImaEO0M2a5vgkm8PSoEZ1aWu5Lr82Dx54UpDQvuumoIHFZ/7XAE/nCWTumk4BDL2Ksk5KVdrd366100AnJDNIC7IZbsFYO0JwdUSytJM5jum4Wk0V16fOFeSWl3+ZaFZt645zwuo7MzZL5OghsVSCPeZ8O7J+iNl+mCOD5xTlhw==
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
 b=kukLNyG2/kjyikYlni6NztFtZAPy8HitRVY0DSYueJLS8LXGvOb6NxVSlUK+b6+DHyGLMPNHPStwaUaRQGoViHIcc0OkhGo6SIyqL9rJ3mMyJL8ZpHm1TvCgdippyaGFpgf0TqH5OUUA3nJghGH/FZUcAw0qVLlvVmTN+fQWZ3oSALuh+C/xwmbU/RGp2odFkAM9MzGPU7bnsYfnRVYJlS2ncQ6cv6pQ9/XOuD/MXToqlbgj2NMQxCngPSynEVYbeZgbRT8XWvCg6J9RWaRNzrG8gVNgYUNiPwQbicOw4PqXKpz1lOQA/bHu9NWRwW6BqvXXQ7ScVkksdO/KDf7M7w==
Received: from AS9PR05CA0288.eurprd05.prod.outlook.com (2603:10a6:20b:492::12)
 by PAXPR04MB9187.eurprd04.prod.outlook.com (2603:10a6:102:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:32:59 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:20b:492:cafe::c3) by AS9PR05CA0288.outlook.office365.com
 (2603:10a6:20b:492::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 10:32:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Wed, 13 May 2026 10:32:58 +0000
Received: from emails-4116900-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-103.eu-west-1.compute.internal [10.20.6.103])
	by mta-outgoing-dlp-588-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id E31637FD7A;
	Wed, 13 May 2026 10:32:57 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed May 13 10:32:47 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOZ+t2MXRtTF5kuMiZMhozZEn2rllNvLwPAjqfY8OVMJQNeqIS3K4yQlRx2CaGAIEk8qvC0nG8BwnCX0YeeV3kFuSOEx5+N8PWNicD5Zyj9H095l3YuSHlixsP4/Emob28F6f5j9b3H2VvV8NNYbPXfEYOOIwEvZwUO6C+gtil/xxR8hgidy7AyOJYqGI/rXrNOFuICYtps+Y65jdMrywOlV4SNby4T01kRu+uQx62ks1UbepweUX6Q5toUTxlfJjXNo/zA2jabbB2zehesYZ8D9FFU48cIlXo24wq+uRkVt61/ptX2dr+/EJ9BnQALOR2Qx/qdU99hG85yxTKhbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=pU6D3OfjoLWUmZxsunVYmpvN5gFQq2I8CnQM584WkRYvSNjYJuFfZ2AFcZlXL9PipQmdvikTSXi2mwvoxYmZuD8xeUfVODlAiHQfvyosQYyLF720EKRCCE5GMJeCcbcuEiOdsb+Po3D2lr5/5tYYfwmqsyhjLIagyAOHUMnUJr2+coXmMaj1tzYQ3XCGKLeMhgiRl9j1Sk1fhX9KPiAphk5Aij4a7wGU8dJybNQwl801s+jPdAlWEYL//T+6YSCyEpdlLwUX9NRFwBKerxH8OgguXkmnT5N/F0HfFWk0/BY9BAgL5KuamAJtdcnkrDxQNW10zMtwGTgOqLLq5V//Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=kukLNyG2/kjyikYlni6NztFtZAPy8HitRVY0DSYueJLS8LXGvOb6NxVSlUK+b6+DHyGLMPNHPStwaUaRQGoViHIcc0OkhGo6SIyqL9rJ3mMyJL8ZpHm1TvCgdippyaGFpgf0TqH5OUUA3nJghGH/FZUcAw0qVLlvVmTN+fQWZ3oSALuh+C/xwmbU/RGp2odFkAM9MzGPU7bnsYfnRVYJlS2ncQ6cv6pQ9/XOuD/MXToqlbgj2NMQxCngPSynEVYbeZgbRT8XWvCg6J9RWaRNzrG8gVNgYUNiPwQbicOw4PqXKpz1lOQA/bHu9NWRwW6BqvXXQ7ScVkksdO/KDf7M7w==
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
 10:32:43 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 13 May 2026 12:32:30 +0200
Subject: [PATCH v5 1/2] dt-bindings: arm: fsl: Add SolidRun i.MX8DXL SoM
 and HummingBoard
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-imx8dxl-sr-som-v5-1-d0899b371c38@solid-run.com>
References: <20260513-imx8dxl-sr-som-v5-0-d0899b371c38@solid-run.com>
In-Reply-To: <20260513-imx8dxl-sr-som-v5-0-d0899b371c38@solid-run.com>
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
	GVXPR04MB12057:EE_|GVXPR04MB9802:EE_|AMS0EPF00000196:EE_|PAXPR04MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c487779-60ec-4b1f-149f-08deb0db004f
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|18002099003|22082099003|921020|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 3Gksg7m+WUKvIBPTEyU/TcL7bw3GUyc/cOq8cEWXHJtFjAKorLWvWP5cU86jAD164/Qpwvzwu133cSAiL0Flrsuv7zQ+5nrniWlUSMTEviNt/wQukyWktFF7LeI40p7A35Qvb9wqeio3vsfUZeFiMuL9dzziCLgIZUuocEALzP0xfzrpO+6ePtNi75OJJAxtoQz6wiVOYg0b988bwkxX19o8LOSfRB3QeQTUBpUyx5FPa0aB3v9HV1DuUiIQcxHfkLY1JpbE3IiOQM7EHCB8tb53nvuE/6SdIT8o5tRS3Pmqc8uU3BmGZ6+SZw61iTmtQK0cw9gB56ZFY3jRuyi3vyxHJM2iwMOiUb/01c8Pba4LSxWVK6x69gJhedx2pVwEQ4qfHusetVZtxFQe1YWZlx7LOhYKMuj7IXVYmNSTgniN9DWG3kpoM0D3pCuK2LEIAS3Oa10TXbYEuCP0abkWktCLnBrCMmnfBJbLaSD2jsqBlA8dsQaJM7GRuZdizMw3b2hj0C/ReBBRLjGhgPl8vp1fTvakhG/+pBzt50QUk9RX7+zzcztEvQwZ59dTRibbUhmginTWLBdBqQ2HoOWxOmyweZiNSFvIb06kEKDlV5cwp+daKGvRVkyUw6MJIspBJozjcOKFqcOgzBRD9iEEcC+Ols0ahmzNt35/2y1+fDwj78X69FF+XCwKHfdS/4eRsWH2HWbRQeUaO5JhbpX+rmNZteSI35D6RMozFXZIq/lGZ/XmY+YQt5b0ImR09L79kdIfOO9bgiy6LgXdzZ+WGg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(18002099003)(22082099003)(921020)(38350700014)(56012099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 aL8gIdX3uhdC4t/K95kdI0wT7fVIACRpp+wcIlXPo9o0OnKTUGmxr7mJPo0bV8+oxkpTJdTV5Ju4ATcw4nrqkd5U6wd1k3FoG2MKNnwWye1VRSb+o0ySrGE/AVLGQ2CfXFNh3FijKrn0sXdqlgOalebW1d4GUtBaTJACHevXKL0FYonpHgOn+gvtohsCr3Lv+vv3lpzxHZJqgcHLz/bDma7IBZ6SZqmu38KE943oEmSAOjgtyAovz3wG/1fYRfO/JlqotG/SGnPZxPxJNXB5EXXCCXsRCijA+X8LT/R6OLoxa/wzUd8s6LvDcO9YcalxstmxmnbZTG1BeiWvB36Lrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9802
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: f0f7d7f0815c40b7b8899c1b7000dae6:solidrun,office365_emails,sent,inline:932655bd921d1a8df2b3aed684bc64d7
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	adf746e5-61bf-430e-f040-08deb0daf79c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|14060799003|82310400026|35042699022|36860700016|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	HGI1skIFqATWdNH6LlgteT1bJ7Cq2K22XYVNL7nwhyMdgRhCueJ1q8ek9ZJThDDEIY36GHUqpUP13ZHnBMMN46g0G+pz7dvaSFzV0bdtpS8kRM50Y7frBXSAs76FxRoVWOGfrJx+KTvdr9VwB/WXfRzVCC/P7BY2N/jyFxUsTsTf30camkcSWvM6EgVyNEvch73/yrArRnzugR/GnSZMTXgV/aSRWZfzH/rB1ml1OvtP+7kg9hRpF4g5FGQKthXYp/DFjSAhT+zbfFSeLzmh2lC93vHbYYKwT+B+kkqWhmY+gAhtoWosl6gqM6r4wccYSph67led0rUqni2teiZO8oiS70k3MyZaX+5r0lLo07aiAZDqZUIanckxV3lGnS6QjsqPq5QdNC4ysfQVb1afuQYK5qiE5TyCE9/cL0cVkDaIYpUxYc5vF227KhYoX79QmlNhsChj208ib3BORSXyVydQGy+N7rAhYEfSv3bfXmrsV/yvcHg9wJT7tzNN5JmrtjAgY22LLJkhPbwSmdBRL93yOB+RU7uc27t+rJRI3B2d9ztyCRy9pqyK1WiDuOGKsX7vxHpofQFoJFCWcnRuCSaCW5RZCb4joKOeCNrohDqYd11M53pRZGXAAGiuDwsvvsQkvPGS7bA2gWq/2qvKoysubgMv7QeqCJ8Z0DLKsNQLyepNP494o+G5G6YvkrUV4F1v9XKZ+a2dXMpV9zEu9n4Awius5HeNFuDGcM/BBRygybImJ+ULB4owgaRY5vT4oE0/M2Bg+h8JWDPDV7m8kg==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(14060799003)(82310400026)(35042699022)(36860700016)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jilBPggwqMTw9lDKgrzg4iY2K7CscwAxOtOJXiUHXZs8Rpw1PjahbL97y+0lln/j/i6C+sccoaMXxBwkVxECtjsH+25PTWy1eGSbGgJHQSKAZrnk38ofvC1LHYs/wmeHyiZXdvDq1mSdj3KqIwnAfspS+KMtV9xMpgWtgPzm5FUVLLJ5Ns4jP8jSm4a//tTEWWUytdQHOILQebLmwHlOlzm34IlcLZmr5r37ab8faUtrqYnVyAGkUn98Mq8GGs3SC4QNFomW2R65lX4TsT8QZn6DnEzvDa3PSKi4ZjdA7xrALkirYR/jeQqpQXwJ/fjjwIGR6uR8EGwyxB5paQbyEeECEsvTm3uAnxT14cgIKTp0WNQ84rBBAqQoGe8OjAV1TX5mVfSm3pMiqk2pgHvkpIN/9to4g8TrfrCCQH5Bpyrwg4dt6FBfTlGlY9yJuKnY
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:32:58.1660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c487779-60ec-4b1f-149f-08deb0db004f
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9187
X-Rspamd-Queue-Id: 556E053154C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287516-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,solid-run.com:email,solid-run.com:mid,solid-run.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

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



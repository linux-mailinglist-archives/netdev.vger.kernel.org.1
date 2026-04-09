Return-Path: <netdev+bounces-276980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKXVJ1Od12kUQQgAu9opvQ
	(envelope-from <netdev+bounces-276980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:36:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C191E3CA7F4
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D36A5303661C
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A349F3CF663;
	Thu,  9 Apr 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="vYFqLJnX";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="vYFqLJnX"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023106.outbound.protection.outlook.com [40.107.159.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C03B9DAD;
	Thu,  9 Apr 2026 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.106
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738125; cv=fail; b=D/5o7ZDWFmPVyAd4xXDWt/sC4vRaybpjEuSa+ZwLlyZOwKcIhO8QS79uA7eUQwzfBvtGvLeX9u6vqSKr27Jtafp0BXBdK2z4KlfEcMwvbnl01vSIFKjcZ6rBRlSp2b7q5v84RkYDSJycGwcrtmjU6ePRX3dNMy2Fa0qQyzRnvwc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738125; c=relaxed/simple;
	bh=5JwttqJOZvpUtnlaR2GphObwiyimznC+aw69qt92Ebg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YNHQpYPqtmIZFlTUFCXGLO0gxuuYWgoAB+jo+d8+MuCNmdyvHoFlEPzYVu54BlFsB6azpJX54GtnStvITWHKLvzV86fJVLhhktLzBSfgqrM0zRR9AhLrIOLqaPvm/nwm8UwKPjUP/SNr2uXuuROO2JVa6vtGdjB7q1KVERUZD4Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=vYFqLJnX; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=vYFqLJnX; arc=fail smtp.client-ip=40.107.159.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HcE6WQmNyDQEYJiVxmkOtQ2jE7mRtUKNOgqyz6w0juMWreB7344SyFvWAKEKvQK4gm+Ptu3p8xF95fzG78JCUed4JtNp/TLK6iJzvOGq9wC/ZDp9h4eShw4YYoNXUe8EHG4Y6lLFR9i+ER4IYdHemAWw89VWVq3Eu0mJwHqCvJwkFtpF2MIRtPwZKMk7DwomHX6t6yCFnURBIXZC/sEXaeX50ECgYK5cuceH8/r+iIiSm+RE1AiIQBrB8/6jGT381IOuuG+vqIRIQnZQUpbL3bfLRjpi4DJQQRCCXrowvw74Wts/RiLPh+4YrVllgM70WhJ1UPE1powzQo+TthDW7g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcSOfSYYb1Em+zE8kgnmaY21z3xm9kZOPwIdlmlcvaM=;
 b=xoB4Q02B/oHy0sW+WH+DSYztAAYal8suEoqePd0NKUygUw68m/2qDgdOa7RHalCY4bd9c8+fvOVSeT35QW1roSvk0lFfrhCaoSFx4S+wY96K3Ep7HAMqHpilM2547Ec+WbrhDcB70G5DG4WwKGYwYOqMjr/ihMOv85NbrAFfpyBVVgMjk23lK4TqAqqgE4MEq9EKEYqm4XmEGt1/3sjdbES2jUpC/OljuSdpHQteysuO2MjmP93T1+n83rVT6PkM8W6qryekQoK3wxIRSkoqQI4zgcaEJ7NRo3Bq8IwUihgQR4BDHnGWw/N8Q7wMrnyoztRTrvPR/hcCZYXBhdb5Fw==
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
 bh=AcSOfSYYb1Em+zE8kgnmaY21z3xm9kZOPwIdlmlcvaM=;
 b=vYFqLJnXTTWehx3ugFpQ3rfsHLhscYnuYBJ1uZ65InpjOr3VrUR948eoZxBT7AcJZ8mtVa4tXp5bWbF5KAyFjGcNwp33XtCV/Z705AP4mlFfbR7/9x+vD6hePGi3YwIsx9hUYvnQ9O4F3Vleosf/65BwVS9e9oixlebUGJOlrk/mJzFmU6vjQfFROhJ7ABRDPm53lo79vVF4cFAQdVkFPshKsLR56b06jU4Vz342UIKdiSxxzA6EDSdc4GgbLM/qHGMscuxM2Ze9Rt8P4knZNxps3/ApUsZCxFL6eNll/hGJhSxZ7mEKHXHnCzPiehyV76zENPzHS+AGphH4piOy5A==
Received: from DU2PR04CA0293.eurprd04.prod.outlook.com (2603:10a6:10:28c::28)
 by PA1PR04MB10793.eurprd04.prod.outlook.com (2603:10a6:102:485::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 12:35:09 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::61) by DU2PR04CA0293.outlook.office365.com
 (2603:10a6:10:28c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 12:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Thu, 9 Apr 2026 12:35:05 +0000
Received: from emails-7121667-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-125.eu-west-1.compute.internal [10.20.6.125])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 59B1380EA2;
	Thu,  9 Apr 2026 12:35:05 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Apr  9 12:34:59 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXDInmS8S2AGa+QhiosTiCO3lfo23UPCbgKI8SldVzoQd9JsnDin2F7l8v+spda/wUocSHpCirr4N3r8+p1GQhMku1xva2IX2eMztwjBo4elarvY4C+7SnbZs/AEILPCUmFD95FoA2AWtPuAf+peO+yUn8ZmQud9TEvu4cLt2WJ9I3QXaj21m6XM8c8isQUPuMoB00JmEgiE9B9zRiPTyDrUtFaTGTVHGlEUaNEvXFtGsMa04pyMErJnXLqj6RJ7eJ2KgvCwMXgRTI5VF0lBpPMwQh37k7zi5g4otB3mbpXuy99myCspVLkhU/3quOqOlPIWJZQp9zwosL/Mhl4pFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcSOfSYYb1Em+zE8kgnmaY21z3xm9kZOPwIdlmlcvaM=;
 b=Qi22KGDIyxgdASB0CPDsQfIaMvG6gfXPaGDNf+Kvma+MM0fOHczm/cjYf+QBQjmswqTAMkGEje1bBak97QpE7IQ5d7qiVEyhPmA6T1eJ6VuICp9QLD65ImojuG57dBtjChAgEvhBw1jBcSW1J59Y2MkJfEPK/VFUG0koxjARYmyffx88OAuksUOYxUyXwtwq+h6cqX7hzscJWvikwl5xKkafmoWHUiKrbm323Ui9gsDFEnNNzTSY5qXSM8/9FJdFs6Ci0EjeX9p9wFeYtU/ubGJv9lDRUkIq3luUbizEr0yVKSUNg6Q46Gpk2MBqIhJmWDTD2mW9cooSRPhQOYpVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcSOfSYYb1Em+zE8kgnmaY21z3xm9kZOPwIdlmlcvaM=;
 b=vYFqLJnXTTWehx3ugFpQ3rfsHLhscYnuYBJ1uZ65InpjOr3VrUR948eoZxBT7AcJZ8mtVa4tXp5bWbF5KAyFjGcNwp33XtCV/Z705AP4mlFfbR7/9x+vD6hePGi3YwIsx9hUYvnQ9O4F3Vleosf/65BwVS9e9oixlebUGJOlrk/mJzFmU6vjQfFROhJ7ABRDPm53lo79vVF4cFAQdVkFPshKsLR56b06jU4Vz342UIKdiSxxzA6EDSdc4GgbLM/qHGMscuxM2Ze9Rt8P4knZNxps3/ApUsZCxFL6eNll/hGJhSxZ7mEKHXHnCzPiehyV76zENPzHS+AGphH4piOy5A==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by GV4PR04MB11773.eurprd04.prod.outlook.com
 (2603:10a6:150:2d9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 12:34:54 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%6]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 12:34:54 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 09 Apr 2026 14:34:35 +0200
Subject: [PATCH v2 3/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-imx8dxl-sr-som-v2-3-83ff20629ba0@solid-run.com>
References: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
In-Reply-To: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
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
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR4P281CA0378.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::16) To GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR04MB12057:EE_|GV4PR04MB11773:EE_|DU2PEPF00028D05:EE_|PA1PR04MB10793:EE_
X-MS-Office365-Filtering-Correlation-Id: 0341f54e-a077-4b42-4d27-08de96346d9d
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|22082099003|921020|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 gKA/bL/fBry6/vHO2PeuuasculMwUB2zG3K+rIsWDmFOZdre1hkeKkE5h02Y20eSV3UQXEGM+Mb9WGbmcqH80y3bciZHwQ8jXwqm1JFlkX7bHQCQJfKGAXo2EFNZNEvxJ7Cq+KLOYaTmtKLNECsEEkcHFtmByo1wc4yB1e36abLc9RFNWfKpt5l4QQXCAw8+TLpd36neYsC066rp+PVtGFzmJdqwqLfSTmA+ik5T/yT31z756drq5Pyz+Eu0P7PMgvMXnEeevgyQIXvT1stNXgaE1/AnAbNrUsqcWaYD6PTdlZJinIiS6+FysVjcKSrfj8Sf7Y7aqs9XH2q2c5WzRoFQG44yteUpdPpYQ+BvDyWhE07m9OvuQBpIgwN41wDzmMTcNysshtP38uR0LdDZV7PnbznALcJTEtqF4zHYZtZESduOxl7nEgS6sziARNivWjJzdWww/l6nCsJORIeFcpgGiCMUb1mEIB5M6NMcnD3iGBDbCnrrH66j5JUliQ3n3HhxlQzouHtW9ytc2WvLcO9Ai/il8jCEN83DE2g7edXj81s0R8EbKfJLVeoxVv+TAwYWM0zozXtGU9KK9SR0tWjc/yjTMRrwzQPWMACLbc1k/n3DU1GHJdJQPNZRkUH5L3m1G210Zp5IGv6dOmMuFiZJAng8KAJ264No0DNu6aoAC0wHdxzPEZbiUGxuPZMp8qjbaslpO4wtfKckSy0m0I9QWX/8IS263bGK5Q2tHfcUfT9AXfzW5uSHos/BxtfxBsh97esgBrBc5YOY6MAJq+TSeJSoGUOTJMhqZV5j+ccRfCHs/BkRlfv+kPDvrpMm
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(22082099003)(921020)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 gr7Zb9pMcLsdZ0KT2EMzfEG5YpXCTbIsWznuxtzc3j5A5eI29bkl5E6HzvHknysSLNx9tgovkI+id8+PD7o3ABfhzlWKU81BXC4P2IhIW7+nc2+UFwzuHG7ateVW8XqBfnH6lI8orkIDglxUhpX80ws9jo8qSxZD5q9J4M8ajD7yAdgiNDDbIgaxG1UmjjcdLHSZ/bbwA+wKjoi2laxhW30+CTGaqnVpbbVvp/n44Ry+F95hIQJTcpSobknKkE5gUUeVJ40DO4UqB1+a0mwqY0R9RAUoREzogH3Wg3S/ftA96Qk+m50TFITXqO/ZX2WhM6SwbqKdWbgqvBysdxJsJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11773
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 787c7a132e4f4ca29a00075c254bba23:solidrun,office365_emails,sent,inline:1f4bc7b051329ca38413c84d0c3cf464
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a0cfa729-6932-4ea7-7a89-08de96346710
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|14060799003|82310400026|7416014|36860700016|35042699022|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Guk7PApZKVen8/6h5N2nPs5Fku0qDJtTDBwDzPwapsAbWVLB6tD7m54J/3zuB6YcIJyXkHORk+yGj1+zdw1zv8lY16+dJBlO/aclpdHXCYjDO2GByx3R4FvsQmiayDRRRndoRzG3mHSw+NIZQTwR+uXNAzq+snBtXCH1QAkuNSZecTP7Kcr/ddg6ST4xbVucy6STqE8Sn4fcqqLJKZjcjr5t9B5IkexMX+ayfFjIcsVmxdcAVvU+ACLrd2m4Tb4j5KHvDXE67ixNZlaNgqXAY8FCk5+gGpsOwhnbkBFKqpuNyepcf8WsVeh6V9EqtceEUG3x+JDEdi0lb03+PtxFLW49gzFZteWGz0ueJhCKikFcRXWpeF9BOfJx/N/+f5MWsCxdmESaVdVy/aBLhnmmYx2VxEuWHPsjBel7Q+joANu1vN5iVpFIXGE2L0rDSKehSLfYiEGWAATMUckwWxHvX2aEwu7JnHsyriamm7WsPdPhtkoFVgofLa9urJqcQ1iPn1CPNJPtK2i2u6vET4LZqSE+h8+USjkYhtEExVFMMzGqRJXl5HkdQC1VEWFNj7uhyvPH0xwSIkiDpWmGT1jOwyjkSTuNetbLGFoclQLmJ9JjPNSWPKUAE65fimVmJ86j0Srv8P2ZhOHEYLZSQ2CfdEpzuDkUQwtAfnR0Rdythj4CipHPmdbhQqdLoB9ScJFeTtSMepR8A2ybu1aDuwWlo5tqquZs4D77UKEje71qUoDEQDQyAa5kigvFsPBrH0YOk5hnpFM7nMOq/lEYVrbdMx+erp9mJq3Tq33vu7NLjqm38+bngJ90fpogeFysmkgj
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(14060799003)(82310400026)(7416014)(36860700016)(35042699022)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dpz/ISbuUWwb4ctlynS6TbJ+y7sIK3gK4YwE76w212idrLo9qiW7wP96xJg/ECVWzG6NwXK8gF6SeXFIuh6Mi70UTGkSO0w/qmGaBvcfAFp5AFhMc6ItCEQyIxvELphLEHN0zH+0vveCGdK9CzEgPIRx9xKFdXVGI3Y/bsJRotOvVaH1rvMNqIouHgs3OGsYjbFVH+xFWt2V1QRD3rG5Qoqc1c6OvT44ntPpR07f8FXYXOOI/RtuysxZq6glWldGo3ot0Zf43ktjN7kZLtucr3RjYw8Z9rOev2D8a8Lk/q85SRFD+KeklPOP/P3X3Tr4P6CPJs0DvdiG97s20qr6awlawlPyhXY6q9Tzt7DqJzYRmOZtJozukCakf3IDQieQabBdb4kmUZhCh5j84D9gKEmgVomVMaLGjZCXZrseoxQXZ6zQx5ZjsH61nHeoIUVz
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:35:05.4243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0341f54e-a077-4b42-4d27-08de96346d9d
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10793
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276980-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: C191E3CA7F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the SolidRun i.MX8DXL System-on-Module (revision 2.1)
and its corresponding evaluation carrier board, the HummingBoard
Telematics (revision 2.0).

The SoM features:
- eMMC
- GNSS with 1PPS
- V2X DSRC Radio
- Secure Element for V2X Applications
- Inertial Sensor
- Pressure Sensor
- Compass

The HummingBoard Telematics carrier board features:
- Cellular Modem
- WiFi & Bluetooth
- RTC with backup battery
- CAN
- 100Base-TX Ethernet
- 100Base-T1 Ethernet
- Multi-interface I/O connector
- Multi-interface add-on board connector

The multi-interface I/O connector supplies power and provides basic I/O
(Console UART, 100Base-TX, 100Base-T1, CAN, and power-supply logic level
GPIOs). The SolidRun Evaluation Kit includes a suitable cable and
adapter board that breaks these out into RJ45, USB Type-A, microUSB
Console, and Terminal Block connectors.

The multi-interface add-on board connector provides additional
interfaces (4x 100Base-T1, 2x SGMII, USB 2.0 shared with the cellular
modem, CAN, MDIO, SPI, UART, PCIe, I2C, and GPIO). These add-on
interfaces are disabled by default in the base device tree and are
intended to be enabled and extended via device tree overlays.

Note that a few components physically present on the SoM were omitted
from this description due to a lack of upstream bindings and drivers:
- Pressure Sensor
- V2X DSRC Radio
- Secure Element

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |   2 +
 .../freescale/imx8dxl-hummingboard-telematics.dts  | 536 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi  | 458 ++++++++++++++++++
 3 files changed, 996 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 700bab4d3e600..12b946c08400b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -111,6 +111,8 @@ dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
 
 imx8dxl-evk-pcie-ep-dtbs += imx8dxl-evk.dtb imx-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-pcie-ep.dtb
+DTC_FLAGS_imx8dxl-hummingboard-telematics := -@
+dtb-$(CONFIG_ARCH_MXC) += imx8dxl-hummingboard-telematics.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8dxp-tqma8xdp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dxp-tqma8xdps-mb-smarc-2.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-hummingboard-telematics.dts b/arch/arm64/boot/dts/freescale/imx8dxl-hummingboard-telematics.dts
new file mode 100644
index 0000000000000..ae23eade64244
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-hummingboard-telematics.dts
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022-2026 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include "imx8dxl-sr-som.dtsi"
+
+/ {
+	compatible = "solidrun,imx8dxl-hummingboard-telematics",
+		     "solidrun,imx8dxl-sr-som", "fsl,imx8dxl";
+	model = "SolidRun i.MX8DXL HummingBoard Telematics";
+
+	aliases {
+		/* override ethernat aliases from imx8dxl.dtsi */
+		ethernet0 = &eqos;
+		/delete-property/ ethernet1;
+		gpio8 = &tca6408_u2;
+		mmc2 = &usdhc3;
+		rtc0 = &carrier_rtc;
+		rtc1 = &rtc;
+		serial1 = &lpuart1;
+	};
+
+	v_1_1: regulator-1-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v1";
+		pinctrl-0 = <&regulator_1v1_pins>;
+		pinctrl-names = "default";
+		regulator-always-on;
+		regulator-max-microvolt = <1100000>;
+		regulator-min-microvolt = <1100000>;
+		vin-supply = <&v_5_0>;
+		gpio = <&lsio_gpio4 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	v_5_0: regulator-5-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5v0";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+	};
+
+	/* can transceiver builtin regulator (STBN1 pin) */
+	reg_flexcan1_stby: regulator-flexcan1-standby {
+		compatible = "regulator-fixed";
+		regulator-name = "flexcan1-standby";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		gpio = <&tca6408_u2 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	/* can transceiver builtin regulator (STBN2 pin) */
+	reg_flexcan2_stby: regulator-flexcan2-standby {
+		compatible = "regulator-fixed";
+		regulator-name = "flexcan2-standby";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		gpio = <&tca6408_u2 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	modem_vbat: regulator-modem-vbat {
+		compatible = "regulator-fixed";
+		regulator-name = "vbat";
+		pinctrl-0 = <&regulator_modem_vbat_pins>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3600000>;
+		regulator-min-microvolt = <3600000>;
+		vin-supply = <&v_5_0>;
+		gpio = <&lsio_gpio0 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vbus1: regulator-vbus-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus1";
+		pinctrl-0 = <&regulator_usb1_vbus_pins>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		gpio = <&lsio_gpio0 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usdhc3_pwrseq: usdhc3-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&lsio_gpio0 15 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&dma_apbh {
+	status = "disabled";
+};
+
+&eqos {
+	/* delays are added by connected ethernet-switch cpu port */
+	phy-mode = "rgmii";
+	pinctrl-0 = <&eqos_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	fixed-link {
+		full-duplex;
+		speed = <1000>;
+	};
+};
+
+&flexcan1 {
+	pinctrl-0 = <&flexcan1_pins>;
+	pinctrl-names = "default";
+	xceiver-supply = <&reg_flexcan1_stby>;
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
+
+&flexcan2 {
+	pinctrl-0 = <&flexcan2_pins>;
+	pinctrl-names = "default";
+	xceiver-supply = <&reg_flexcan2_stby>;
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
+
+&i2c2 {
+	/* routed to J14: SDA(51), SCL(53) */
+
+	/* regulator@18 */
+
+	tca6408_u2: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names = "DIG_IN1", "DIG_IN2", "CAN_STNB1", "CAN_STNB2",
+				  "DIG_OUT1", "DIG_OUT2", "", "";
+		interrupts-extended = <&lsio_gpio0 20 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-0 = <&tca6408_u2_int_pins>;
+		pinctrl-names = "default";
+	};
+
+	carrier_rtc: rtc@32 {
+		compatible = "epson,rx8111";
+		reg = <0x32>;
+	};
+};
+
+&iomuxc {
+	bluetooth_pins: pinctrl-bluetooth-grp {
+		fsl,pins = <
+			/* BT_REG_ON: io without pull (module integrates pd) */
+			IMX8DXL_SPI3_SCK_LSIO_GPIO0_IO13			0x0000061
+		>;
+	};
+
+	eqos_pins: pinctrl-eqos-grp {
+		fsl,pins = <
+			/* MDIO to Switch */
+			/* enet0 mdio pads supplied with 3.3v */
+			/* IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIOCT */
+			IMX8DXL_ENET0_MDC_CONN_EQOS_MDC				0x06000020
+			IMX8DXL_ENET0_MDIO_CONN_EQOS_MDIO			0x06000020
+			/* RGMII to Switch */
+			IMX8DXL_ENET1_RGMII_TX_CTL_CONN_EQOS_RGMII_TX_CTL	0x06000020
+			IMX8DXL_ENET1_RGMII_TXC_CONN_EQOS_RGMII_TXC		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD0_CONN_EQOS_RGMII_TXD0		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD1_CONN_EQOS_RGMII_TXD1		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD2_CONN_EQOS_RGMII_TXD2		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD3_CONN_EQOS_RGMII_TXD3		0x06000020
+			IMX8DXL_ENET1_RGMII_RXC_CONN_EQOS_RGMII_RXC		0x06000020
+			IMX8DXL_ENET1_RGMII_RX_CTL_CONN_EQOS_RGMII_RX_CTL	0x06000020
+			IMX8DXL_ENET1_RGMII_RXD0_CONN_EQOS_RGMII_RXD0		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD1_CONN_EQOS_RGMII_RXD1		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD2_CONN_EQOS_RGMII_RXD2		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD3_CONN_EQOS_RGMII_RXD3		0x06000020
+		>;
+	};
+
+	flexcan1_pins: pinctrl-flexcan1-grp {
+		fsl,pins = <
+			IMX8DXL_FLEXCAN0_TX_ADMA_FLEXCAN0_TX			0x00000021
+			IMX8DXL_FLEXCAN0_RX_ADMA_FLEXCAN0_RX			0x00000021
+		>;
+	};
+
+	flexcan2_pins: pinctrl-flexcan2-grp {
+		fsl,pins = <
+			IMX8DXL_FLEXCAN1_TX_ADMA_FLEXCAN1_TX			0x00000021
+			IMX8DXL_FLEXCAN1_RX_ADMA_FLEXCAN1_RX			0x00000021
+		>;
+	};
+
+	lpspi0_pins: pinctrl-lpspi0-grp {
+		fsl,pins = <
+			IMX8DXL_SPI0_SCK_ADMA_SPI0_SCK				0x600004c
+			IMX8DXL_SPI0_SDO_ADMA_SPI0_SDO				0x600004c
+			IMX8DXL_SPI0_SDI_ADMA_SPI0_SDI				0x600004c
+			IMX8DXL_SPI0_CS0_LSIO_GPIO1_IO08			0x0000021
+			IMX8DXL_SPI0_CS1_LSIO_GPIO1_IO07			0x0000021
+		>;
+	};
+
+	lpuart1_pins: pinctrl-lpuart1-grp {
+		fsl,pins = <
+			IMX8DXL_UART1_RX_ADMA_UART1_RX				0x06000020
+			IMX8DXL_UART1_TX_ADMA_UART1_TX				0x06000020
+			IMX8DXL_UART1_CTS_B_ADMA_UART1_CTS_B			0x06000020
+			IMX8DXL_UART1_RTS_B_ADMA_UART1_RTS_B			0x06000020
+		>;
+	};
+
+	modem_pins: pinctrl-lte-grp {
+		fsl,pins = <
+			/* modem RESET_N: io open drain drive 2mA */
+			IMX8DXL_ADC_IN3_LSIO_GPIO1_IO11	0x2000061
+
+			/* modem PWRKEY: io open drain with pull-up, drive 2mA */
+			IMX8DXL_ADC_IN2_LSIO_GPIO1_IO12	0x2000021
+		>;
+	};
+
+	regulator_1v1_pins: pinctrl-regulator-1-1-grp {
+		fsl,pins = <
+			/* SW_PE: io without pull-up */
+			IMX8DXL_USB_SS3_TC2_LSIO_GPIO4_IO05			0x0000061
+		>;
+	};
+
+	regulator_modem_vbat_pins: pinctrl-regulator-modem-vbat-grp {
+		fsl,pins = <
+			/*
+			 * RF_PWR: io without pull-up,
+			 * has either external pull-up (R1117) or pull-down (R1118).
+			 * With pull-up Modem will boot at system power-up,
+			 * with pull-down modem will enter power-down mode once
+			 * vbat is enabled -> toggle pwrkey to boot modem.
+			 * Hence pull-up (R1117) is preferred.
+			 */
+			IMX8DXL_SPI3_SDO_LSIO_GPIO0_IO14			0x0000061
+		>;
+	};
+
+	regulator_usb1_vbus_pins: pinctrl-regulator-usb1-vbus-grp {
+		fsl,pins = <
+			/* regulator enable: open-drain with pull-up & low drive strength */
+			IMX8DXL_SPI3_CS0_LSIO_GPIO0_IO16			0x2000021
+		>;
+	};
+
+	switch_pins: pinctrl-switch-grp {
+		fsl,pins = <
+			/* SW_RSTn: io without pull-up */
+			IMX8DXL_USB_SS3_TC0_LSIO_GPIO4_IO03			0x0000021
+
+			/* SW_CORE_RSTn: io without pull-up */
+			IMX8DXL_USB_SS3_TC1_LSIO_GPIO4_IO04			0x0000021
+
+			/* INT_N: io without pull-up */
+			IMX8DXL_USB_SS3_TC3_LSIO_GPIO4_IO06			0x0000021
+		>;
+	};
+
+	tca6408_u2_int_pins: pinctrl-tca6408-u2-int-grp {
+		fsl,pins = <
+			/* gpio-expander interrupt: io with pull-up */
+			IMX8DXL_MCLK_OUT0_LSIO_GPIO0_IO20			0x0000021
+		>;
+	};
+
+	usdhc3_pins: pinctrl-usdhc3-grp {
+		fsl,pins = <
+			IMX8DXL_ENET0_RGMII_TXC_CONN_USDHC2_CLK			0x06000040
+			IMX8DXL_ENET0_RGMII_TX_CTL_CONN_USDHC2_CMD		0x00000021
+			IMX8DXL_ENET0_RGMII_TXD0_CONN_USDHC2_DATA0		0x00000021
+			IMX8DXL_ENET0_RGMII_TXD1_CONN_USDHC2_DATA1		0x00000021
+			IMX8DXL_ENET0_RGMII_TXD2_CONN_USDHC2_DATA2		0x00000021
+			IMX8DXL_ENET0_RGMII_TXD3_CONN_USDHC2_DATA3		0x00000021
+		>;
+	};
+
+	wifi_pins: pinctrl-wifi-grp {
+		fsl,pins = <
+			/* WL_REG_ON: io without pull (module integrates pd) */
+			IMX8DXL_SPI3_SDI_LSIO_GPIO0_IO15			0x0000061
+		>;
+	};
+};
+
+&lpspi0 {
+	cs-gpios = <&lsio_gpio1 8 GPIO_ACTIVE_LOW>, <&lsio_gpio1 7 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&lpspi0_pins>, <&switch_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ethernet-switch@0 {
+		compatible = "nxp,sja1110a";
+		reg = <0>;
+		reset-gpios = <&lsio_gpio4 3 GPIO_ACTIVE_LOW>;
+		spi-max-frequency = <4000000>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* 100Base-TX on connector J26 */
+			port@1 {
+				reg = <0x1>;
+				label = "lan1";
+				phy-handle = <&switch_port1_base_tx_phy>;
+				phy-mode = "internal";
+				status = "okay";
+			};
+
+			/* CPU */
+			port@2 {
+				reg = <0x2>;
+				ethernet = <&eqos>;
+				label = "cpu";
+				phy-mode = "rgmii-id";
+				rx-internal-delay-ps = <2000>;
+				tx-internal-delay-ps = <2000>;
+				status = "okay";
+
+				fixed-link {
+					full-duplex;
+					speed = <1000>;
+				};
+			};
+
+			/* sgmii on addon board connector J21 */
+			port@3 {
+				reg = <0x3>;
+				label = "lan3";
+				status = "disabled";
+			};
+
+			/* sgmii on addon board connector J21 */
+			port@4 {
+				reg = <0x4>;
+				label = "lan4";
+				status = "disabled";
+			};
+
+			/* 100base-t1 on addon board connector J21 */
+			port@5 {
+				reg = <0x5>;
+				label = "trx1";
+				phy-handle = <&switch_port5_base_t1_phy>;
+				phy-mode = "internal";
+				status = "disabled";
+			};
+
+			/* 100base-t1 on addon board connector J21 */
+			port@6 {
+				reg = <0x6>;
+				label = "trx2";
+				phy-handle = <&switch_port6_base_t1_phy>;
+				phy-mode = "internal";
+				status = "disabled";
+			};
+
+			/* 100base-t1 on addon board connector J21 */
+			port@7 {
+				reg = <0x7>;
+				label = "trx3";
+				phy-handle = <&switch_port7_base_t1_phy>;
+				phy-mode = "internal";
+				status = "disabled";
+			};
+
+			/* 100base-t1 on addon board connector J21 */
+			port@8 {
+				reg = <0x8>;
+				label = "trx4";
+				phy-handle = <&switch_port8_base_t1_phy>;
+				phy-mode = "internal";
+				status = "disabled";
+			};
+
+			/* 100base-t1 on addon board connector J21 */
+			port@9 {
+				reg = <0x9>;
+				label = "trx5";
+				phy-handle = <&switch_port9_base_t1_phy>;
+				phy-mode = "internal";
+				status = "disabled";
+			};
+
+			/* 100Base-T1 on connector J26 */
+			port@a {
+				reg = <0xa>;
+				label = "trx6";
+				phy-handle = <&switch_port10_base_t1_phy>;
+				phy-mode = "internal";
+				status = "okay";
+			};
+		};
+
+		mdios {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mdio@0 {
+				compatible = "nxp,sja1110-base-t1-mdio";
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* 100base-t1 on addon board connector J21 */
+				switch_port5_base_t1_phy: ethernet-phy@1 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x1>;
+					status = "disabled";
+				};
+
+				/* 100base-t1 on addon board connector J21 */
+				switch_port6_base_t1_phy: ethernet-phy@2 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x2>;
+					status = "disabled";
+				};
+
+				/* 100base-t1 on addon board connector J21 */
+				switch_port7_base_t1_phy: ethernet-phy@3 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x3>;
+					status = "disabled";
+				};
+
+				/* 100base-t1 on addon board connector J21 */
+				switch_port8_base_t1_phy: ethernet-phy@4 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x4>;
+					status = "disabled";
+				};
+
+				/* 100base-t1 on addon board connector J21 */
+				switch_port9_base_t1_phy: ethernet-phy@5 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x5>;
+					status = "disabled";
+				};
+
+				/* 100Base-T1 on connector J26 */
+				switch_port10_base_t1_phy: ethernet-phy@6 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x6>;
+				};
+			};
+
+			mdio@1 {
+				compatible = "nxp,sja1110-base-tx-mdio";
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* 100Base-TX on connector J26 */
+				switch_port1_base_tx_phy: ethernet-phy@1 {
+					reg = <0x1>;
+				};
+			};
+		};
+	};
+};
+
+/* bluetooth */
+&lpuart1 {
+	pinctrl-0 = <&lpuart1_pins>, <&bluetooth_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		/* Murata 1MW module supports max. 3M baud */
+		max-speed = <3000000>;
+		shutdown-gpios = <&lsio_gpio0 13 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&usbotg1 {
+	vbus-supply = <&vbus1>;
+};
+
+/* cellular modem */
+&usbotg2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	adp-disable;
+	disable-over-current;
+	dr_mode = "host";
+	hnp-disable;
+	pinctrl-0 = <&modem_pins>;
+	pinctrl-names = "default";
+	power-active-high;
+	srp-disable;
+	vbus-supply = <&v_5_0>;
+	status = "okay";
+
+	usb-device@1 {
+		compatible = "usb2c7c,125";
+		reg = <1>;
+		reset-duration-us = <150000>;
+		reset-gpios = <&lsio_gpio1 11 GPIO_ACTIVE_LOW>;
+		vbus-supply = <&v_3_3>;
+		vdd-supply = <&modem_vbat>;
+	};
+};
+
+&usbphy2 {
+	status = "okay";
+};
+
+/* WiFi */
+&usdhc3 {
+	bus-width = <4>;
+	mmc-pwrseq = <&usdhc3_pwrseq>;
+	non-removable;
+	no-sd;
+	pinctrl-0 = <&usdhc3_pins>, <&wifi_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&v_3_3>;
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi
new file mode 100644
index 0000000000000..93a0eb4d7f770
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022-2026 Josua Mayer <josua@solid-run.com>
+ */
+
+#include "imx8dxl.dtsi"
+/ {
+	compatible = "solidrun,imx8dxl-sr-som", "fsl,imx8dxl";
+	model = "SolidRun i.MX8DXL SoM";
+
+	aliases {
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart0;
+		serial2 = &lpuart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	imx8dxl-cm4 {
+		compatible = "fsl,imx8qxp-cm4";
+		clocks = <&clk_dummy>;
+		mboxes = <&lsio_mu5 0 1 &lsio_mu5 1 1 &lsio_mu5 3 1>;
+		mbox-names = "tx", "rx", "rxdb";
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+		power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;
+		fsl,entry-address = <0x34fe0000>;
+		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
+	};
+
+	pps {
+		compatible = "pps-gpio";
+		gpios = <&lsio_gpio2 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&gnss_pps_pins>;
+		pinctrl-names = "default";
+	};
+
+	v_1_2: regulator-1-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v2";
+		pinctrl-0 = <&regulator_1_2_pins>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <1200000>;
+		regulator-min-microvolt = <1200000>;
+		gpio = <&lsio_gpio1 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	v_1_6: regulator-1-6 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v6";
+		pinctrl-0 = <&regulator_1_6_pins>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <1600000>;
+		regulator-min-microvolt = <1600000>;
+		vin-supply = <&v_1_8>;
+		gpio = <&lsio_gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	v_1_8: regulator-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+	};
+
+	v_1_8_se: regulator-1-8-secure-element {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8-se";
+		pinctrl-0 = <&regulator_1_8_se_pins>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		vin-supply = <&v_1_8>;
+		gpio = <&lsio_gpio3 18 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	v_3_3: regulator-3-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		/* global autoconfigured region for contiguous allocations */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x98000000 0 0x14000000>;
+			reusable;
+			size = <0 0x14000000>;
+			linux,cma-default;
+		};
+
+		vdev0vring0: memory0@90000000 {
+			reg = <0 0x90000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: memory@90008000 {
+			reg = <0 0x90008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: memory@90010000 {
+			reg = <0 0x90010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: memory@90018000 {
+			reg = <0 0x90018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: memory-rsc-table@900ff000 {
+			reg = <0 0x900ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: memory-vdevbuffer@90400000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90400000 0 0x100000>;
+			no-map;
+		};
+
+		/*
+		 * Memory reserved for optee usage. Please do not use.
+		 * This will be automatically added to dtb if OP-TEE is installed.
+		 * optee@96000000 {
+		 *     reg = <0 0x96000000 0 0x2000000>;
+		 *     no-map;
+		 * };
+		 */
+	};
+
+	memory@80000000 {
+		reg = <0x00000000 0x80000000 0 0x40000000>;
+		device_type = "memory";
+	};
+};
+
+&i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-1 = <&i2c2_gpio_pins>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&lsio_gpio3 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&lsio_gpio3 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-1 = <&i2c3_gpio_pins>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&lsio_gpio3 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&lsio_gpio3 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	magnetometer@1e {
+		compatible = "st,iis2mdc";
+		reg = <0x1e>;
+		interrupt-parent = <&lsio_gpio2>;
+		interrupts = <10 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-0 = <&magnetometer_pins>;
+		pinctrl-names = "default";
+		st,drdy-int-pin = <1>;
+	};
+
+	/* pressure-sensor@5c */
+
+	inertial-sensor@6b {
+		compatible = "st,ism330dhcx";
+		reg = <0x6b>;
+		interrupt-parent = <&lsio_gpio2>;
+		interrupts = <11 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-0 = <&imu_pins>;
+		pinctrl-names = "default";
+		st,drdy-int-pin = <1>;
+	};
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_hog>;
+	pinctrl-names = "default";
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD	0x000514a0
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHK_PAD	0x000014a0
+		>;
+	};
+
+	dsrc_pins: pinctrl-dsrc-grp {
+		fsl,pins = <
+			/* reset: io without pull */
+			IMX8DXL_ADC_IN0_LSIO_GPIO1_IO10			0x0000060
+
+			/*
+			 * boot0: io without pull
+			 * After reset, this pin selects radio boot media:
+			 * - 0: flash spi
+			 * - 1: slave sdio
+			 * Once the firmware boots however, the radio controls
+			 * this pin for flow-control to signal readiness.
+			 */
+			IMX8DXL_ADC_IN1_LSIO_GPIO1_IO09			0x0000060
+		>;
+	};
+
+	gnss_pins: pinctrl-gnss-grp {
+		fsl,pins = <
+			/* gps reset: input with pull-up */
+			IMX8DXL_SNVS_TAMPER_OUT4_LSIO_GPIO2_IO08_IN	0x0000021
+			/* gps interrupt: io without pull-up */
+			IMX8DXL_SNVS_TAMPER_IN0_LSIO_GPIO2_IO09_IN	0x0000061
+		>;
+	};
+
+	gnss_pps_pins: pinctrl-gnss-pps-grp {
+		fsl,pins = <
+			/* gps timepulse: input without pull-up */
+			IMX8DXL_SNVS_TAMPER_OUT2_LSIO_GPIO2_IO06_IN	0x0000061
+		>;
+	};
+
+	i2c2_gpio_pins: pinctrl-i2c2-gpio-grp {
+		fsl,pins = <
+			/* io with pull-up and weak drive */
+			IMX8DXL_SPI1_SCK_LSIO_GPIO3_IO00		0x00000021
+			/* io with pull-up, weak drive, open-drain */
+			IMX8DXL_SPI1_SDO_LSIO_GPIO3_IO01		0x02000021
+		>;
+	};
+
+	i2c2_pins: pinctrl-i2c2-grp {
+		fsl,pins = <
+			/* io with pull-up and weak drive */
+			IMX8DXL_SPI1_SCK_ADMA_I2C2_SDA			0x06000021
+			IMX8DXL_SPI1_SDO_ADMA_I2C2_SCL			0x06000021
+		>;
+	};
+
+	i2c3_gpio_pins: pinctrl-i2c3-gpio-grp {
+		fsl,pins = <
+			/* io with pull-up and weak drive */
+			IMX8DXL_SPI1_CS0_LSIO_GPIO3_IO03		0x00000021
+			/* io with pull-up, weak drive, open-drain */
+			IMX8DXL_SPI1_SDI_LSIO_GPIO3_IO02		0x02000021
+		>;
+	};
+
+	i2c3_pins: pinctrl-i2c3-grp {
+		fsl,pins = <
+			/* io with pull-up and weak drive */
+			IMX8DXL_SPI1_CS0_ADMA_I2C3_SDA			0x06000021
+			IMX8DXL_SPI1_SDI_ADMA_I2C3_SCL			0x06000021
+		>;
+	};
+
+	imu_pins: pinctrl-imu-grp {
+		fsl,pins = <
+			/* interrupt: io with pull-down */
+			IMX8DXL_SNVS_TAMPER_IN2_LSIO_GPIO2_IO11_IN	0x0000041
+		>;
+	};
+
+	lpspi2_pins: pinctrl-lpspi2-grp {
+		fsl,pins = <
+			IMX8DXL_USDHC1_RESET_B_ADMA_SPI2_SCK		0x600004c
+			IMX8DXL_USDHC1_VSELECT_ADMA_SPI2_SDO		0x600004c
+			IMX8DXL_USDHC1_WP_ADMA_SPI2_SDI			0x600004c
+			IMX8DXL_USDHC1_CD_B_LSIO_GPIO4_IO22		0x6000021
+		>;
+	};
+
+	lpuart0_pins: pinctrl-lpuart0-grp {
+		fsl,pins = <
+			IMX8DXL_UART0_RX_ADMA_UART0_RX			0x06000020
+			IMX8DXL_UART0_TX_ADMA_UART0_TX			0x06000020
+		>;
+	};
+
+	lpuart2_pins: pinctrl-lpuart2-grp {
+		fsl,pins = <
+			IMX8DXL_UART2_TX_ADMA_UART2_TX			0x06000020
+			IMX8DXL_UART2_RX_ADMA_UART2_RX			0x06000020
+		>;
+	};
+
+	magnetometer_pins: pinctrl-magnetometer-grp {
+		fsl,pins = <
+			/* interrupt: io with pull-down */
+			IMX8DXL_SNVS_TAMPER_IN1_LSIO_GPIO2_IO10_IN	0x0000041
+		>;
+	};
+
+	regulator_1_2_pins: pinctrl-regulator-1-2-grp {
+		fsl,pins = <
+			/* io without pull-up */
+			/* has etxernal pull-down */
+			IMX8DXL_ADC_IN5_LSIO_GPIO1_IO13			0x0000061
+		>;
+	};
+
+	regulator_1_6_pins: pinctrl-regulator-1-6-grp {
+		fsl,pins = <
+			/* io without pull-up */
+			/* has etxernal pull-down */
+			IMX8DXL_ADC_IN4_LSIO_GPIO1_IO14			0x0000061
+		>;
+	};
+
+	regulator_1_8_se_pins: pinctrl-regulator-1-8-secure-element-grp {
+		fsl,pins = <
+			/* v2x-secure-element power switch: io with pull-down */
+			IMX8DXL_QSPI0B_DATA0_LSIO_GPIO3_IO18		0x0000041
+		>;
+	};
+
+	se_pins: pinctrl-secure-element-grp {
+		fsl,pins = <
+			/* v2x-secure-element reset: io with pull-up */
+			IMX8DXL_QSPI0B_DATA1_LSIO_GPIO3_IO19		0x0000021
+
+			/*
+			 * v2x-secure-element gpio0: io with pull-up
+			 * pulled low by sxf after boot indicating ready for commands
+			 */
+			IMX8DXL_QSPI0B_DATA2_LSIO_GPIO3_IO20		0x0000021
+
+			/* v2x-secure-element gpio1: io with pull-up */
+			IMX8DXL_QSPI0B_DATA3_LSIO_GPIO3_IO21		0x0000021
+		>;
+	};
+
+	usdhc1_pins: pinctrl-usdhc1-grp {
+		fsl,pins = <
+			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK		0x06000041
+			IMX8DXL_EMMC0_CMD_CONN_EMMC0_CMD		0x00000021
+			IMX8DXL_EMMC0_DATA0_CONN_EMMC0_DATA0		0x00000021
+			IMX8DXL_EMMC0_DATA1_CONN_EMMC0_DATA1		0x00000021
+			IMX8DXL_EMMC0_DATA2_CONN_EMMC0_DATA2		0x00000021
+			IMX8DXL_EMMC0_DATA3_CONN_EMMC0_DATA3		0x00000021
+			IMX8DXL_EMMC0_DATA4_CONN_EMMC0_DATA4		0x00000021
+			IMX8DXL_EMMC0_DATA5_CONN_EMMC0_DATA5		0x00000021
+			IMX8DXL_EMMC0_DATA6_CONN_EMMC0_DATA6		0x00000021
+			IMX8DXL_EMMC0_DATA7_CONN_EMMC0_DATA7		0x00000021
+			IMX8DXL_EMMC0_STROBE_CONN_EMMC0_STROBE		0x00000041
+			IMX8DXL_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x00000061
+		>;
+	};
+
+	usdhc2_pins: pinctrl-usdhc2-grp {
+		fsl,pins = <
+			IMX8DXL_ENET0_RGMII_RXC_CONN_USDHC1_CLK		0x06000040
+			IMX8DXL_ENET0_RGMII_RX_CTL_CONN_USDHC1_CMD	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD0_CONN_USDHC1_DATA0	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD1_CONN_USDHC1_DATA1	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD2_CONN_USDHC1_DATA2	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD3_CONN_USDHC1_DATA3	0x00000021
+		>;
+	};
+};
+
+&lpspi2 {
+	cs-gpios = <&lsio_gpio4 22 GPIO_ACTIVE_LOW>;
+	num-cs = <1>;
+	pinctrl-0 = <&lpspi2_pins>, <&se_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* console */
+&lpuart0 {
+	pinctrl-0 = <&lpuart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* gnss */
+&lpuart2 {
+	pinctrl-0 = <&lpuart2_pins>, <&gnss_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&lsio_gpio3 {
+	gpio-line-names = "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "",
+			  "", "", "", "SXF_RST", "SXF_GPIO0", "SXF_GPIO1", "", "",
+			  "", "", "", "", "", "", "", "";
+};
+
+&lsio_mu5 {
+	status = "okay";
+};
+
+/* OTG port for boot */
+&usbotg1 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "peripheral";
+	hnp-disable;
+	power-active-high;
+	srp-disable;
+	status = "okay";
+};
+
+&usbphy1 {
+	status = "okay";
+};
+
+/* eMMC */
+&usdhc1 {
+	bus-width = <8>;
+	cap-mmc-hw-reset;
+	non-removable;
+	no-sd;
+	no-sdio;
+	pinctrl-0 = <&usdhc1_pins>;
+	pinctrl-1 = <&usdhc1_pins>;
+	pinctrl-2 = <&usdhc1_pins>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	vmmc-supply = <&v_3_3>;
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};
+
+/* DSRC Radio */
+&usdhc2 {
+	bus-width = <4>;
+	keep-power-in-suspend;
+	max-frequency = <40000000>;
+	non-removable;
+	no-sd;
+	pinctrl-0 = <&usdhc2_pins>, <&dsrc_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&v_3_3>;
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};

-- 
2.51.0



Return-Path: <netdev+bounces-291167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I8EDhnpEmo25QYAu9opvQ
	(envelope-from <netdev+bounces-291167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:03:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC675C243A
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 636DC3008D1D
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0123932C8;
	Sun, 24 May 2026 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="m2JCmEo/";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="m2JCmEo/"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023115.outbound.protection.outlook.com [52.101.83.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C6299AAB;
	Sun, 24 May 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.115
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624212; cv=fail; b=ruq7PLzmhnaCFgD+L+oUSCD2kiFg8Ussv8HwE09KftrUi9HJnuSnUDkUOu8Hqi9tM74i9qe/XeVwH3Mro86N1LhjrBWb9qmiDv6nmlP6Pty73/1H5cNbiGeEQzsWqIfjmp5C64KgYGlMM1bnRcCYS19oOw5BI3wzwKv8mPaFa1k=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624212; c=relaxed/simple;
	bh=pPy2cIWoTmGIz+Y1/FeNVME9oqkbocOhVZWwlGx+6Jw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=I49MSUpAPgQAMrwcO1hIi1aftUZ2Ywuk1l1DGn0c55V4+sX3BoxirPMYrBiGB26ApwKndrPzzn2swgmO+63icgOpHQIkKStAOMmR5LzUeJjl1pWK9haqvX8M901jh3W+UcJ5SDDqyktH08FNe5+bM9h8s0Z8XJxUyKxdhdFHUoM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=m2JCmEo/; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=m2JCmEo/; arc=fail smtp.client-ip=52.101.83.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VmeVNjNqviWRn8tbZnFYYfGrpHxp1fhDaQDm/wTFeTLmSl8jsPd/1EreDMyRjybk4jU+WW0LqbXQWdIzzMqyZA/xerG4InR+lKMnjss0L4WS6j2AtLDubeQ5OSktStuRbkzyvm/P2FYXnqAJqUNC7FjdPXYrD9KITigeI+aRkTX8SMit/4Gk0ruE8yWnFS7KlUKRZKgb7R2aphxn9vDHLBTq0JNdu9m8kF5TT4u8dcXf8pa+m6YMCxDmvyg36Rk1kX8PcJyKdg/72z9E8Az2tWRmWQryOaFwvsGQMaIddhzatGBzX6PoTx9J93atqfuZzgPlFyOMHdrcF8x8IevIiA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=WwTVLUjSfw1TZl9mgLqTTBctOCCZN6y5Gm5r5MVghmWGDxp3/Rts8YWCUcGiBZhfKb010gCKgROjL+DWDHHlxO+azkv2rNLz1jhKmVZbjJZwN5q81cbHZn4G+8Ea+6tw/nFRccjUCwUnPSPz0V60V1hJ0zGhBlFU+m1Q0vX08mTUzkb3BMpNuqCc4mjMat1WAtI0hMXB0LSTjt8aD7j594OXg/U9gzMPHPTvSCHM5SUPDXWlL0+Epls7dQrsbVhwg9LiYK9YlorL2KskxQa4jteqIrGkW0PihQpEdx27FzSDxxhCpBCZpq/s1qe69i2LE0SN3m16SwHeqeljCc3mHg==
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
 b=m2JCmEo/zGaT1nT+fQ6snOAMwStNFOzgyOsh+EupGokRB0JwwF5qkAfa7rLM44QfDzrvM/hvqjNf2v28t9/yB8OZCb37f0kmqYI0hGtxKRSd8gR8sOFs0Fm9EsNxICnldnGwfa4c28gh7x4IOuS/K862iU096esdKLhavPUwoHfx/OubxfxM0I1cmnARtE7sSF7XwCz0iV+XhlD096iG6DgPBFgiyKcDB0igZC+H5YpPQvbjr0dSmvC0SmTWe1IUOdz1e8wsH8MJmfEP9mropmF0epZueD9e5l8dFNkM/tns2SLYNYCIBxt33MvwuQQugk0JXT62hvSbnUZ7sNQlKw==
Received: from DUZPR01CA0259.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::7) by AM7PR04MB7048.eurprd04.prod.outlook.com
 (2603:10a6:20b:11a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:03:27 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::9c) by DUZPR01CA0259.outlook.office365.com
 (2603:10a6:10:4b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 12:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Sun, 24 May 2026 12:03:26 +0000
Received: from emails-3038119-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-217.eu-west-1.compute.internal [10.20.5.217])
	by mta-outgoing-dlp-305-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 49F927FE27;
	Sun, 24 May 2026 12:03:26 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Sun May 24 12:03:17 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8A2J+5jdJt0ffoAs8d4xg99naMWt849tb6VsaXt3oeUKS6mZX66XC55xVnx1mKYtR5ynbIwFijmGlcq7TrHcNhXYYHr1/Z/ZCBvCB18AKsqPTScwcHJpht2tk52R/wswB1yofW9VhXUxo+ss4wqvFtzcuxTYmpFzDb7epXsTmNL68Wgwex12tClXaXtCHX+pplAhjlzEsQ6cMo1yATggpDjcm17N7EoRDP+uJmJl65TknTJUmJwcGPS3u1WjPZbQIE1pyhQ/HDosbDnjISOKLFXMC/kZ4SzrELxJ8aLCRFHSCvxABjcCgGC4Nc1WAsz0NQx7KNBl1WyW/mIk+2FUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=JvSipqFBT7E8oOhsYZ0YpRBOQh6i3cpvXCFKUFsTFPDvFJvGMPbgDJCIXVhJjJ4uv+QQ9MiZl/fSx1bvvTq9fS7+TFJyXdcdwVmJYdC+yNH+oYRJiscswHRaQfaFU70LCBWdz5ZpGuVop2s5Re8SXeADjK8Fz6rJ3JjHhNLY/awtfaicI6qEvdaLUxZUlRGH/2CTBEk0DISrKUu8eg3rTrrmbhWBBJsmK66lhsHhSZJuBASMOJx0+clR4MhUVc6mgUTrTRRWp6VyZjIH1GUaSZ6XvRR7V3hTh9WbHkqpI9seKMZJGZchbCC3sgXbPu94aCtQO0O76frHSj2r2pwpJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=m2JCmEo/zGaT1nT+fQ6snOAMwStNFOzgyOsh+EupGokRB0JwwF5qkAfa7rLM44QfDzrvM/hvqjNf2v28t9/yB8OZCb37f0kmqYI0hGtxKRSd8gR8sOFs0Fm9EsNxICnldnGwfa4c28gh7x4IOuS/K862iU096esdKLhavPUwoHfx/OubxfxM0I1cmnARtE7sSF7XwCz0iV+XhlD096iG6DgPBFgiyKcDB0igZC+H5YpPQvbjr0dSmvC0SmTWe1IUOdz1e8wsH8MJmfEP9mropmF0epZueD9e5l8dFNkM/tns2SLYNYCIBxt33MvwuQQugk0JXT62hvSbnUZ7sNQlKw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from DB8PR04MB6859.eurprd04.prod.outlook.com (2603:10a6:10:119::14)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sun, 24 May
 2026 12:03:14 +0000
Received: from DB8PR04MB6859.eurprd04.prod.outlook.com
 ([fe80::65f7:a733:64c6:60f9]) by DB8PR04MB6859.eurprd04.prod.outlook.com
 ([fe80::65f7:a733:64c6:60f9%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:03:14 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 24 May 2026 14:03:09 +0200
Subject: [PATCH v6 1/2] dt-bindings: arm: fsl: Add SolidRun i.MX8DXL SoM
 and HummingBoard
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-imx8dxl-sr-som-v6-1-37932c6eb7e4@solid-run.com>
References: <20260524-imx8dxl-sr-som-v6-0-37932c6eb7e4@solid-run.com>
In-Reply-To: <20260524-imx8dxl-sr-som-v6-0-37932c6eb7e4@solid-run.com>
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
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To DB8PR04MB6859.eurprd04.prod.outlook.com
 (2603:10a6:10:119::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB8PR04MB6859:EE_|AM8PR04MB7361:EE_|DB5PEPF00014B9B:EE_|AM7PR04MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 9219e8b1-f8a2-4fcc-2d83-08deb98c764d
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 Ev4zvbLUgU53+v/t24udu68DCXCBSIpqtL/EoeruPQ83i4pulR9qqtkeZdWDRWPVUgtRcj9j4fd/xp7xX1c/zCJH5BC4qrMb1Ky+StH9G9tOxehebL1kHQ07uPWfEaPKE4Nr2Cwmp8Afi+Ads0vWs6c7siO029gZUpKtP0WDAfe7WOB9GRLRQArVTqfG8WPfvFWKt3yQe4QQK/wLj1+lSWX7pr4l8nUlgKi4LfX7CjEppv3NN1K2Hp2T+QVyjvwLXjCNWAz+G3aE8wr/uTb3jZHUvy1VGnCm2GW4kaR+vo93pVL2czXa73W2l4q56MYdMZidKJiK5aSxn8betwp5Ziq6p7veBKolUMkNLSjTPMfv+kMA16rbsOv9+4bWl0h9CIpjA0iXj7YI/J0ZvoWMb6VwsXqiEivQocNnOB1IT7b2jd2dOn/gFM/ryxUy1MbTZaxVjSBkz5ejhVPx3S0LraCWAnMy6FG7XQYr1zWSn+foqPXSfqNevUMZ67kdeDYaTG8wno5FuJpY5yETzcwVG+QVxBcaJ2WnEkekixyxRIbi8YO/P0EhQ+JpF3C63+CSOFc94LJg+6qMvR0tE3ISMMN7rZJRR+haryy1CZ0dtZ7+McHQ+m+FXZ+IQq0aUVSqX0zfvrGRCSFRKs0VwII4W9YkniPhtOMzSvUobhT3fMyg/0XWMaq5jzVPlOD81eD6BnVfxPfEpMoDi8dyk1MwaH5mjXbt8thmG5CFcLv7rwTBYbkc1XZrSIBg3AOsNxLrPXopRvtFu0ANTW1Y7zd3YQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6859.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 f/a8ojE6WvcPLXtWckRDmxqILlgG18ABh+9qkZP4+63PhklJ8looNK4lCBb4wvj7SG/y0rZl3K77E+54hfLp92XrExO8MXOneHXWZA99DhU6rxnMjQAX25R5rd9xyd1kXSOizpKrpiXbOUH82fGWG+ClXT1We/HghtP11gMIHS3gOLyOCFMoGErlimeN4Dctwv/v1N5xdXElPhD1fg+mR6EYlEiEikCE3xl+0C+LgGghJ9TTSYe5PyStc6JuNENU6CALnaYRwAaieQ2goSg4bthD283aEunh5EuoeSlk5xt09Jv1KzffWwkRo/Mj+y75EbXlJ3BnftWe7SGonvElig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 57bff77374f74143a2c69e41304c0d6f:solidrun,office365_emails,sent,inline:a04dbab98c0c01cb9f79639d82f8e896
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	03766d91-c807-452e-60bb-08deb98c6ed7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700016|82310400026|376014|7416014|35042699022|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	e7DdfhufwzPsP+0bG5EUPuoowVqztKEQOe1m0jvH81XIw31DWxKjSumO2NGE7lapj8bVA4Q+Dzb+5N4GzGWu8JgZHtAHuPSERp2iOgd3YoQRy9pA3o3eppLTEfajbPcAnkrJSZZgpwnOFW8i9tlx/yLUPEy+N5vH68Zh/wUlclMk60vpMWTTRXvZYXj3JEhOHuiotuD36EPvycZzuXuYnWo/8o+qamsCt9LU61A7lSRGsYIhk1ROQFv58rKV8WqrCfx2Dop837YegmqQcR0MkkBh+aQ4DiUAu/9uG7Kwl/5Zs01ZSkASRHBkcmKAT3A7zXHFwEaUaCdOZPoWfzuqg/DquWJPO+W/mYBntd9fuHKVHwt4gnDCT0jmQnRW6PSNCkoVZla9luMilHLu0oObY8Hd1MN3lFqu8zgV9nzXfh1NUKRQnt81aHTlHhD+6oa3oOt7UbYIk0yEBeppSdSPSph0GF90QihOKg/CeghzU5C0B701qhAlB/6M4Rxmm3u48N7+sXSxPyCYHuiMm/oeN3flZvJPZvfT/MNw25BlMqULzRmOsU9KeD0GhcGyLeSLXtVhA7zQEJiNHx+54Z/b+bbiViCoilg7HXX1aIdkkxNBnPm5y8JMLNn2PnsBjk8HdqqvZA7SLwlllCsjwCV04bvkqvyXmMMk5x5Mv88anW+7xjBJZVaga+e4KD6kipFppOaFWmPjUb0TNTwaU44bJAh+px7G2dmpniMHhkWovoR7zDuTgoHyo6JCmRqwxRSgWuB86NF8TrFJq0nBKSulHw==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700016)(82310400026)(376014)(7416014)(35042699022)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GUK1HmwQAbTGvzxChEKvQGejWUoy+F3qpKn9Jg3CRBVmwGNuRJq40NB53Hh4V3UjeykMnCkBNXIbdVDdfCwgbZN5aQ7yZ4X1MoG1fh0nRrPxHhm5hv2HSSeTqolqna6yV920XkTSB1z3oK5EwekQCui/IC/Xq2o2pljX7SXUTh7arMtOYbxRhbZQmNBET7ktaX5wsC7t7yIdnmY4sSnqEQoP0QVsW3Y/NpDGqgvPRGCPRpub3dYRPZiLsFbW9WuTILhIC6cx+V//S+imYyIn+q1qh2F0hDMeX7ZfM0fXOny5XjI1VH0uUKEs7Q1vMWrY2ZNscpiobf2MUdhfpTA0QnfUx9Qz+Cr17Q5FKonDjjD4wM12IttiF/rEnRkiWFULj3yZ++CvGCtZYLh/bnI2M6gyDJ5iwsu48ZixLnoJ352KO2lAF+w2p8L+iLvM3CXw
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:03:26.4070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9219e8b1-f8a2-4fcc-2d83-08deb98c764d
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7048
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291167-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7AC675C243A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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



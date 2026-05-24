Return-Path: <netdev+bounces-291168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKPsKBzpEmo25QYAu9opvQ
	(envelope-from <netdev+bounces-291168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:03:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5185C244D
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4E03300BD92
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FC23939A3;
	Sun, 24 May 2026 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="EbBusdL/";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="EbBusdL/"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021111.outbound.protection.outlook.com [40.107.130.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF233EF;
	Sun, 24 May 2026 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.111
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624212; cv=fail; b=COvfKQNIGy6WfyjxBRUu/ta8EmE+SR3AhimFEiPl+7hvsFIy18yToY+rUgxVBunGk23dUdsxoUp3uRWoChgaGXKOTldqDnUvDT7SCu13dUkltDRJl7WqpA6iWHDzGvvD/lvZ6LFkpiwRDdD8Sep6hPhJXl7ppoMC62wHfqFO1D8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624212; c=relaxed/simple;
	bh=K/kgf2bNkH3SIpjmXVIH/+2K5sr79ZdyIoXDmKwaIMk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=eUgGcZrPup2uk/J7ojN4AERPCnW7Ms8NyVtzWCDBH9jAvWrFUQqOfmrm9t5WyJ1usEDB95s4KUtEfGDM7qEaL2Y0jAV36q7i2JvhsSX+GdJhpwgDmfZTtFDpGsQNAYPr5FbLFxLplpLJxgdwE9kyxfTuDfYXQBHwkJTn791CKSs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=EbBusdL/; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=EbBusdL/; arc=fail smtp.client-ip=40.107.130.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kSUW3J9tcsOieAm3uK96kkWnShrDv7AY87eiBTthtKrEkRiHMSOU4KhbudjNsl34g7ZEtc1FvUN3qwcIhnYM6LX6qDT5vke7rGZV3V8aBfoNQNhbPUBHqNyct5gOKTL50t3KnADzDMVfiuz/xQHR0ytLb5f7qUXtUn9kBSqET/Cmg13v35bHQ3otDS5jLHrfyMp7pTDsTHifKnkD+rSVelYOowRMBoBbOS6JZrY5kypqNQQqRj3WXy1imX6ou6xNH0u2y6hR/+DTLuaX04CbHKzuQcVngZlnc3Iz+9vMhnM5f+1WcUJ06YZ76a7CcKeQPwvopmZTBwpsqJxE7MQYBg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1exELD0Styd5OD4kX/Pg2aiRCTLcpA9MYMdu9gOtIY=;
 b=DR+G5lFZV/DmBWgDxYAQm+pTNJ6hzRnlRIRj7MJukvbYpG8UwpB9qsP0T2UAz5jzCa6vsdgpbr28HqRZca3lNwKF1GqUxktnMDU50Yi5WhrY4bd3XntZYxDt9RfK/G6dqK0zaem9RzZzblXWRAYgjXUJw8Z1Bw8hSgDVxFGSFayXOrvFY2YvXrZPW2GBMdsD0K3m+z3MUbme60SuJOjB1tJKMNTr9QJICJbAY3Lz7qaHVixfXDQHkUzlH9WczHs58v2f/HYmGAafFh7d2SRsxDw5fyiGO0FMnEfjLtzVNnAseqIi39eaXDBgzm9PMpW1jvzK2i0K3m36/3pTjGmDFQ==
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
 bh=Y1exELD0Styd5OD4kX/Pg2aiRCTLcpA9MYMdu9gOtIY=;
 b=EbBusdL/VjX9xi96ROEt9vXK2IKnilfGmKhz0gTWeAwQfKVs1UmoGgInUWTRh/hM9pZG+Ekpda6L3DKVJDn7sKhIDZmMpRqnumBfPnkQAzYjdopIZh0aiCYdj2rPo4YBPG8ZU8/VgKs+CcGHamXP7SLmq1dpsUiLBhx30WQ/Wn7FYKUgbraf9QserzwMwburVQVbCqer/Hsgucbt1zMTpamz/KJcppRH/NAlCQHY6ZNib2HOQTHCkJA2S0ApTUBgBsw50HLqpLlqoS0RwsFcwqqsi/N79CTnpAV0S6VPTBdfBSDpK2eYpVsSKh3HTD7m844X+eFrCOt3OVnSqN6TsQ==
Received: from DUZPR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::11) by AM8PR04MB7427.eurprd04.prod.outlook.com
 (2603:10a6:20b:1d4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:03:25 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::91) by DUZPR01CA0032.outlook.office365.com
 (2603:10a6:10:468::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 12:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Sun, 24 May 2026 12:03:23 +0000
Received: from emails-104111-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-81.eu-west-1.compute.internal [10.20.6.81])
	by mta-outgoing-dlp-588-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id A1AE07FD61;
	Sun, 24 May 2026 12:03:23 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Sun May 24 12:03:16 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhX6Xhj/AOG1oYxLbyHnKWNYH7K/z/P/9kWk/7Qcp4fXeAGPaFn4z7keXYYR7p5fW23/U/eQPXYJ3CIXS5adehnOcpQI4LIA2hdcvfJxadffGkGp/TIH9qykcbYVs9Qsx9bS1V8nEFPW93/qIRL05ceEUf5Ykn3RHIq/LoF2eEA5KUeG0s986X1thrO4Nvj0U6XY+snoyC0juT6mNhG+PJZKnAlcPS41zR76Ns/Sv+cl4Ut97S2ajiQQFSqbAnV8UVKQWUdJkSPnHwkDnguHxzDLbd2CUe1OrnHbk6CVIxv/wZMrqN0Wbeec+/ZfwZkHlD+yTeNjNYThmqYgZ+BIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1exELD0Styd5OD4kX/Pg2aiRCTLcpA9MYMdu9gOtIY=;
 b=R9rlqRUMFZXL7IR0spxN7ExNMOPazYjmLMdyjING3pZxnHR2DmkUdFwQfYvMYSDJGZMsbNxIUc5AMpE4DS1KDgJW+9gLQYnYLa/fCNlhBPaTT3neBbAH/HrknuTr4fTvSSjq7rvgKeCTOFrCsGzPatae5Fy3ehJLK+20AcDZJuNodaVGjSk4qigKNCixyFgLQ3ApFk7K21CnHh+bEMswqV5Na1nA+lXrWu7Yyc55It/Gu0K0AisURHm5cQeiyMsWJNqkeAcrhc4ZYDjA+4uhKrkyrYJorYwu4Ut2wv4UB6JCkGmDAQKFMo7dCavsDwZNFcbe393kkucmx0GP0RQowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1exELD0Styd5OD4kX/Pg2aiRCTLcpA9MYMdu9gOtIY=;
 b=EbBusdL/VjX9xi96ROEt9vXK2IKnilfGmKhz0gTWeAwQfKVs1UmoGgInUWTRh/hM9pZG+Ekpda6L3DKVJDn7sKhIDZmMpRqnumBfPnkQAzYjdopIZh0aiCYdj2rPo4YBPG8ZU8/VgKs+CcGHamXP7SLmq1dpsUiLBhx30WQ/Wn7FYKUgbraf9QserzwMwburVQVbCqer/Hsgucbt1zMTpamz/KJcppRH/NAlCQHY6ZNib2HOQTHCkJA2S0ApTUBgBsw50HLqpLlqoS0RwsFcwqqsi/N79CTnpAV0S6VPTBdfBSDpK2eYpVsSKh3HTD7m844X+eFrCOt3OVnSqN6TsQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from DB8PR04MB6859.eurprd04.prod.outlook.com (2603:10a6:10:119::14)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sun, 24 May
 2026 12:03:13 +0000
Received: from DB8PR04MB6859.eurprd04.prod.outlook.com
 ([fe80::65f7:a733:64c6:60f9]) by DB8PR04MB6859.eurprd04.prod.outlook.com
 ([fe80::65f7:a733:64c6:60f9%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:03:12 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v6 0/2] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Date: Sun, 24 May 2026 14:03:08 +0200
Message-Id: <20260524-imx8dxl-sr-som-v6-0-37932c6eb7e4@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPzoEmoC/3XOTW7DIBCG4atErEvFMIChq94jysL8NUixiaC1X
 EW+e4k3tWp3+X7SPJoHqaGkUMnb6UFKmFJNeWyhXk7EXfvxI9DkWxPOuGKCaZqGWfv5RmuhNQ8
 0goDgUCB0SNrRvYSY5hU8X1pfU/3M5Xv1J3iu/1ITUEZdkD2a3vkO8L3mW/K0fI2vLg/kyU18S
 5gdwRuhMUbOFDe2Z0cEbghkOwLXL7jVysVOWndEiF9CAuwI0QglUINFGzXzR4TcErgjZCM808Z
 Y7MCh/kssy/IDQu4XkbwBAAA=
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
	DB8PR04MB6859:EE_|AM8PR04MB7361:EE_|DU6PEPF0000A7E4:EE_|AM8PR04MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: eb393b0e-031e-497e-cbf9-08deb98c74b4
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 cRgcsi2MWGO15Ivr7qoKXNn+DV3eumffCSeMEB+SFkDSXbIKEtDX445VER6EwvC9gUE4sO+dBKKxH+jtRFz5EBs6JfjhJn5IilUqIGPWvN0Vv1tHy/BzcER8fef9mdUJbA12AKpLwXpnZgaJIUDHPhYEQI7S+LzjA5xvEK+P4yxxQMTBKGlTigiBZzIhVcvglm8h5+9+4w+0ue+qVudgrZMOliLiqJbo9mLk2VFFXAvESCiEitOT2PxtKnsSiYR3440GJOP/Fjgd08lKBpIgRl6ysaVcRd51Ena6+0pfwM2x141SOHaXfp1YETTB5OMOkk0+ZZhOgKxymFt+Ht1LANXmceSRlMYA2mWaK5RwJFT+ZXa52TOaZ5kfEAER1QlNa3A7T3TpcGen2/vQf8W5BcNX0bBrMn3YNBwYyifEjTBNOesOvM7lrgi6qq96ULgb+qwbWSAtKfh49mZO2S6YiQqOnpO5oFGsNoGrm6CtMhse4PSNcSKEx/8SQdlNgD1yVioVQXXpxMglKZmrqJq453hyC/FqOxdd9ZCmSgrWdDCSGDGIWKSV4LQX/ou5SPW81ZuArHvSA+TNdirsFyhh8vBPBuhwdwVSsNrwdzcFBNvamQjU8DeRj7hOyzP6yJJg4m/xd2/YWjln+C4qPhkGszCgxVvFrS0qr+6wc2DnngtqQzVqr1u5zcHBuAAPXY+NfrmCbJD93dRyYsSdRLr+vNRFFUqciu66EF2yayO6SUNJjZ5cp65h5ZD6DQ1xyVezBvhoG40ToIDuU1zn3j/TCA==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6859.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 Pl6tCNPpDu9snaR3dqudsD/TxWuKWk5Ibaatj+YRwqZwruHijBjQEcy2ZfGfHY7clexJnv+qwztFXWzfzFxXqsj58HpshsUzovi2HKfqE2j1G21sMh5tUclVV4x8wLFY5w/g8/gkv51heou82CVG7xUQo8WOhWFu2p1Yo6cWurLViehRTMQgcNNRmxWMSYoUp0Gn3+TBUcuDao1qhUmHR66LsB5WxxhPoD/0nL686SiZM9GTXzfmcIVm8xYX7HzEb1zgZjwhtBYqfFOo12TWLgL81lI2dHgsApm5Vik4v8uy6RTtQLMGvQ/+1nC7V9LXLYBImwqFIZzpYuMg2xS7/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: b43cc0f6bc994093b4e0739a362653ea:solidrun,office365_emails,sent,inline:a04dbab98c0c01cb9f79639d82f8e896
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	49e55256-c2d6-4dd8-3da8-08deb98c6e22
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700016|82310400026|376014|7416014|35042699022|13003099007|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	6MssMwXTCjFqFaJoO9xDjfhOIZ6R1f50Ne9+tV4HfV94K8FgiBP+NGcL+ThNfNlqHvC0T7iR5GLSsD52ln5F0XQ1p6PdYmo3SKnSmwAPzhrPHZAn9zGVviZIfqgSQILZ880zonaFkKrNs+EFLavdXvI/cs4f8ZZDcVQUTaU+n46EeqssFT9C2QCQHLpzAktYLxuC9cPxyiUEFk28TmV9knJZmb89v/wunb0ell1LDjkZGG7m/jQLOj70d/LR4ZA0f4cjPk4M7Ask2wzmvx3aT1Nfucdncbogcqm8b8oGlFtvokVNsMnTUMLpO85760X2vOuESyLISjZhzOU5xHIBpqGQG5r0lwoFt3OhIUqO2NMmTzhrtntJmU6cJJXYzHsW47Wk6n249K9nDaLqqRYnzwxGWp6ilQlyxUdTGIcIj/T6fzHSY62tpWUnEtC0DOnF8OjXTCoEnQlR73kTBMKynsj9QZ0+TV3R7lABlBHosWMGK6tUPxDbLfmlmnD6JZQQHxTR6SncIcRtTQDdNYc3e/0YjVcZU/w6nWUUYqCmmWZY1Xz6vZUGQoj7Oejy1dm9ZaaWpYz8jrTa+IVzQV0X4mEgjMIkZgB7gEWh7akSoZB9t0SO8MbL2eXGNHVE8jvqvmeYsw6WyPeMzvnztmCWb21W0KZ1QBpXY3PTeTBnzzi7EFveOKJXo7k6cM7KyD3iSMfab2iK4JroEDEWrrKTmEvam3IIriXoXA9oQATjVdXnhprjDr/rTSkRzr0kAN68gCDYXbrTiViNkJctdF7O0dluKCf+mC7Eb1KtddnLdK4=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700016)(82310400026)(376014)(7416014)(35042699022)(13003099007)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WX5cSIroxvwCiTTF921qSwBwUW9/C9xh2G3zo7nj7UOeSLCmsi2plQmsaNbq/PCRRTIypdDI/ql33aujGrREwAYCAHMBP70ckiA0sdYwWEQzskwIp6YB65914aJZf7v1upolmvRYRaOSjIeAjf9KWrhIuqAxB6TTdUcqd2kqRS1N9S5vMdUTM7F4BqXDUkigW5ztIC24oNPyhYYrVUYTDJNFroH3ZebVk18PONvsY0ott+nfTsjeX+DJfoqwB5a81knqFTEtvZosUtkBJhsMcJ56PAM3CRKxdNET7rC1SdV/Kd80dNXO/1s693rQWC4X/FZtkcSuv5kv31mHHw6S9YrnzCr5Q7y37XqxDI6guGd7AgLTIC95jmIPWazjxa7VL2+gk0sijUWwI3Pha6Jv4pQ3m6kE/e1ZPXKK94Dphjxvr/42wv6FMs//lfIJXG4n
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:03:23.7327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb393b0e-031e-497e-cbf9-08deb98c74b4
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7427
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291168-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1B5185C244D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings and description for SolidRUn i.MX8DXL based SoM and
HummingBoard Telematics.

Modify SJA1110 Ethernet Switch bindings to allow SPI Mode 0.

This patch-set is based on v7.0-rc2, because rc1 was experiencing
deadlocks with imx8qxp clock driver.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v6:
- Remove stray /delete-property/ from aliases.
- Fix name collision for bluetooth "vbat" regulator.
- Kernel can't power-sequence cellular modem, ensure userspace can:
  Drop reset-gpios, set vbat always-on, define gpio line-name for
  powerkey and reset.
- Link to v5: https://lore.kernel.org/r/20260513-imx8dxl-sr-som-v5-0-d0899b371c38@solid-run.com

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
 .../freescale/imx8dxl-hummingboard-telematics.dts  | 560 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi  | 458 +++++++++++++++++
 4 files changed, 1027 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260408-imx8dxl-sr-som-f141ec343173

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



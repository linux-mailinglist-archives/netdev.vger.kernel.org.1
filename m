Return-Path: <netdev+bounces-282828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKzQIqBI82kMzAEAu9opvQ
	(envelope-from <netdev+bounces-282828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:18:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B544E4A2AC9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA313300291F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922B8402B80;
	Thu, 30 Apr 2026 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="vy+4t2Kq";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="vy+4t2Kq"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023119.outbound.protection.outlook.com [40.107.162.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8332868B5;
	Thu, 30 Apr 2026 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.119
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551513; cv=fail; b=eqsp95XuuF1V7Cfy/kdm+8KlVsbnSfHndVPGYertb89XJql0vnYJbjIHQ6QpdaKsipul5zpR6El9owX0QqmRIA9FQg6Q0iitpdCLR7vcsb5lUMMMINn8JiswL1yr7lNS/phXzDgbgbeM7pyEyajDqsIPpiTi34nAXIRaS6AQVAE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551513; c=relaxed/simple;
	bh=EKVllgav3vF2BJ5Op4NQgTXj1f3fdA2xyaQEchTQGlI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=G2aTLXaZVoLxbZnFc2YZAPJ6LRBaZqRy/K8d4AlhUJw/lMPtV+ZufNzFwBisj21156tzNMOsVTqQlcpEtnvMYtT3QYHLLrEY4say8RHCO0+QhXDsBktYyKUYoORdPxDABdAJsHzrWlLyuya40uIf2r9KujLx9pMxBIFqegMWAsQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=vy+4t2Kq; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=vy+4t2Kq; arc=fail smtp.client-ip=40.107.162.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=L/aPWbJEU6iu3hhPKtv6OqWJVJUHPM+hbMwiVDWQzfltA2UCMN/VVVdT2yputgkf7K43Le0vlqiVhIengozzEcMq6kgVS3H/sFUDlyTSSuHAj79Wp9yyXWeSZ0v9rJsA6mzDdp2I58niNYABoaNRxUUig060xcUJ6D5U7vStRMTDq0jmzZF5jtkU6e+cVXPwgfLY/QKaA24chBsPoXoKlHu1xiO2e9IcaieRTmzxxvKjHevz6mJoYsPsYKd0vLiwpXRV63uD7Nq/tou0gXUVdBIkcYq6usXUKmYcFPg3q2hAtuzUZUr2Lb7lXmtc/UZbPtmKjHmmCRr7peMDf7/+lw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgNM+zt0ouFVl+UD0ZdZZ1v5AvFgUW9r0T47qojGllw=;
 b=juq0Wi5rA5fBpLfTyVJ930W+jJrbfYJk0s7KMe64EGevXYo9hfBcFJDvKgZHr5wP6KhlcCdkozP/zp1PcY7wt7dmtsNbcC3RbrVm8XlQDLuj0dbEwH1OQTD8NcmBhvfub4nV5Fku4zxHyhNHnGk5AflXjDWUihMI/DI4vIte5hlujZAplWkiAGsFG6edS4LToL8zIYUMRudQ+xXpo9wzoCKc3YIXyFXK2BT7ckR+dgLwlr009B2jxRwz87UBxaXugmpR3yPSphXCmk+UNWz89moREANy/A5MatG05OE/sufF2QqEJTdxNqyI69/bh1jWNN7TCN00BboLNR8LXCfY2w==
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
 bh=UgNM+zt0ouFVl+UD0ZdZZ1v5AvFgUW9r0T47qojGllw=;
 b=vy+4t2KqResm9Ymy6PhTa7nO6IEU1clvi8pip7c/jHVnWgJF36aeQ4CjoqaA7M0JqfnpHDE84lwyvOOc03qHz5G6eIMl54kor084q4GuiV8zBi3aP4efvmHx6VYrVkUejjI0BmisrPndixpHqtVallSi8RnUtlwDp2ghj+b6a+OIGnq/TzrOd+5cMv4D7InBbXEQ4JLVhIBtssAp9Bd3CNvLESZHiktArSohfOXi4+MKWQdtS+PDLYn/owhC2DCx1SnOAbBsPDZXtTcS8NQciZ5Kuv1qbPGk9cqJKBPsMbQk6ygJySDB81CUsqS0gSgRkNRVxmWH1s5rsl4NAfuxQg==
Received: from DU7P194CA0001.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::16)
 by AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:18:27 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::b0) by DU7P194CA0001.outlook.office365.com
 (2603:10a6:10:553::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 12:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 12:18:26 +0000
Received: from emails-6369118-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-105.eu-west-1.compute.internal [10.20.6.105])
	by mta-outgoing-dlp-291-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 5BDB580713;
	Thu, 30 Apr 2026 12:18:26 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Apr 30 12:17:55 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgmwS3+DfPp97gz1C/yVNhBbd4zA2a+5I/JYbGqO6m23759tdFNd/42w1dqcL+iHBY6TG1HrQ8GJZqYNAm15r/GWSQ3JboQeoJi+8Jmj9X0y0OZzj2scKQ5BVi9K+q6e66Y7x927rhbyA/Jit2pYqDL3HwYpmEtRtEHQDOBH8+cZOcxhaRiY9l5mRxGYBNYn8xeedx66wK9I69DdWSqY+D4ALt31s2jWC1hE0UVdnheaMrBRUqzrHNinvWuNpeNKR6gKxviI2cxW0gnBNo81TdrJwuuJMVTaGXaTdHJCrS2QFjRcZBVAvB1T5p4LrnawBh9dklt2Q2No0p3O/fY7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgNM+zt0ouFVl+UD0ZdZZ1v5AvFgUW9r0T47qojGllw=;
 b=VP1KtGSu3h2PXEOUNlS+AK7ApUeq+L4CsFeKwvrcsZc4Ios2WN/DBPHaDK5c3l5DeAS16P9ZYzPu6l0NBRvNPBptBYMn7DFdkjqx4Hn5SSwM5Q1uXhHJzZNbfst6sYBhR/N0ShSN0rW9Afu52et6fpb4igQQdHP+eBYJSzuKnN0ySnNQtPafV5CvZMImuMHb9Da8jrhSwZArL87I1rAmUCgI0FJO6WH3OUa5uuxSecRgIymsRRY3zXhGnwyQuCzyzHwfi/5LUL8XvhjlYH8KWif7sENDRDPSpswD948J6/Ur87L4YY0rLDea1OulTF7zhRtBR1NqWXuqvGKo2zxPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgNM+zt0ouFVl+UD0ZdZZ1v5AvFgUW9r0T47qojGllw=;
 b=vy+4t2KqResm9Ymy6PhTa7nO6IEU1clvi8pip7c/jHVnWgJF36aeQ4CjoqaA7M0JqfnpHDE84lwyvOOc03qHz5G6eIMl54kor084q4GuiV8zBi3aP4efvmHx6VYrVkUejjI0BmisrPndixpHqtVallSi8RnUtlwDp2ghj+b6a+OIGnq/TzrOd+5cMv4D7InBbXEQ4JLVhIBtssAp9Bd3CNvLESZHiktArSohfOXi4+MKWQdtS+PDLYn/owhC2DCx1SnOAbBsPDZXtTcS8NQciZ5Kuv1qbPGk9cqJKBPsMbQk6ygJySDB81CUsqS0gSgRkNRVxmWH1s5rsl4NAfuxQg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by AM7PR04MB6789.eurprd04.prod.outlook.com
 (2603:10a6:20b:107::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:17:51 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%2]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 12:17:51 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v3 0/2] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Date: Thu, 30 Apr 2026 14:17:38 +0200
Message-Id: <20260430-imx8dxl-sr-som-v3-0-ce2b86cf75bc@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGJI82kC/3XMyQrCMBSF4VcpWXslQ+3gyvcQFzGDvdA2kquhU
 vrupl2J4vI/cL6ZkYvoiB2LmUWXkDCMOdSuYKbT480B2txMclnxkjeAw9TYqQeKQGEAL0rhjCq
 VqBXLp3t0HqcNPF9yd0iPEF+bn8S6/qWSAA7GHbRqtbG1UCcKPVqIz3FvwsBWLslPov0hZCYa5
 b3klWyvmn8Ty7K8AZQb5nXzAAAA
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
	GVXPR04MB12057:EE_|AM7PR04MB6789:EE_|DB3PEPF00008860:EE_|AS8PR04MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 72bf35a0-9d69-4520-6b18-08dea6b294e4
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 pUgltQK9Ca3wy/8ulv850m9B0Qq3dMi8VN0UPAB1TJQsKnnaZtQztHcFpeijQ4n7TMmgNo34GoiQ4JxWuZwlPs3MtuKELwb1GRqfwZAbKEQvKDPLpKvfnDwoQtVUeE//0R3RJbebA4cSzI6KUJefr8CnkratYRL+yvSyGc/pJQb2oz4A7L3MngLUhzBPOatoqbSst3WE8bV/uD1TAVMHSOk8iuLuJEmJN0KIwZjrlurnJvyZcwm0VMNTudqDs4NVEZqkD8WyPrF4FVFtdJVNdiYcCw3XF651at1qx/mcf9gk0L3B6b7xYJt9jroE+cWRUH5QJTtkLwVC/rFHEv1i7JxtIllQcQzj2xfY5QUL14UYP7wsT2ZXpn7RjyCOT/DvREh7WLDc5qw6ISRcq8fqcsOud8rjevNqvxCC/2LQ94nXAhWu9AKWursgFpnVCkyO54ON/9WJpZ063heP+7j4fhe6mEhNxP+ztGX+UjwERv2KSfL26b8qHc/q1wdL5/PKGErvxlQv1HZrA09T21tp6dgrieX32cfsxbsk4QEDzCHYMOcQFjnFgRKwSAK1/bbgbTQO5ZBJBf3Y8wniREntgDUza41+UlGvg+NkBCvNyRDGmTblAH5qvhlph4EOFB7IDkgdGtUtzxt1yO3LjwHBCHWbB6ZrAPJAalqX2t2RfPsnRPtbX3dekCOO0hNXayUG4yk7txkf6nwEEHphIJ8WOYtGp8AN7JjB3RbvD1XkJyKJrA2W2kE8HkgKllyE3i1FDEbbJcEODoD8Okr0qadb9NRPb7zQUwO9wsfzSDm9vr2pAI+vNM3lkken+SN+QuYN
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 ksj2uzymneIG7Ow1tNhGkomAmyZWmi/DNarZKqlGNLDm72swBHzf0DiV76jEZS3jVOGPp1/qLxFlPF0A5tFyEBjxcVcDReO+mGqOjnZ+gKUn7N/luAp/fkYgepnRw61qmD4Yw2crB/hysC0CPFj8vlm6v6VX9JRZerMe6kSCtejz7oUlhdWE4nE51Xur4ekcQBAkfG52h3OpVrCbK8laysCdI3sdIu2ICrwAfSusU9+3NB1rjqBWMV1nC629lI8AohKoaf50nsDaceqVdgdsqFJtcMAuEJepkGXMUVMqQj9pSQgFnGpYtAehnIhMx7nhpityb8x/3i5P5c4Vol8fXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-6.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: d754fe5ced5445b98d6e4d4d7ac84056:solidrun,office365_emails,sent,inline:65e85c2bd07fbd1b22859550c7174672
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	215979d3-d458-45e3-b7fc-08dea6b28009
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|35042699022|1800799024|7416014|376014|14060799003|921020|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tB7l4Lm9EjCAIAmvT/Z0J1izQqsq6454nFOachvt9E2V/kOloXIMF3BX7+APYRB94WWlxkXHEQK0wgT+cHcVPmiidrsGrD0HTy2jTXYk5SX8FFU+gRVRwM7bw06jxXwypIsfU4MnJL2/NuYbYps0APUb8tF0pRTZNMZ8JrLsUOhgh6lhyaWWI/WDfGIYdoks6PkCnu2P11ClQeBlFuYFvVkRSupQHGHz9htWBu7qfy6ka4r+ZPodXudfhtrcGQrRptgqS+IlH4hRE/sPlAv1L1DA9nqu8ftsnhbaVDRmWSGmsAKBb+BQR/KX7Q9jG1DedHNRAk5PmGKFT1r1QEsyLU1Av02ph/XOvknYfdwWLYyXyIkqpFHvVaVzOMgZ9sE+/CtuJB8d84r0IOIxnZeaTqBn9p6Fm0EQ3pXZBcZdaUL55JGRSS0B2nUkKd2KNO7SGU7AL6XioENgYxSbMZmj5XD5VnONw1qKXtz9XcNusGvKK3Oys7y7AjxN8omOlhHINtBySEwANmKM7rq88syC8UQSLC1/w4kPt2/DU5IXSBnjX/5zT2bXgiXiM2sZSVx/zcflvg6pTQWx/hnaf5LO+DQaGrdYZ0YsD6SBPFgT7ZxkE5AcVf3Ac5QlKajZ71AHvEOzr9r2rlmpm/wPIDZXm6N6y5bpoyuKp/cXmnpS/dV6egl7FbUORnML22/p3QJ7gtx8OCakuKyqJCAFXbFrTD2tyBXLz4bHqQLfWc7Vfcj4nOgttfXCcEXJZqaH37PngxXWuwEIIkVuNFh6VTDeFd+esgUVZ5IZa/YbuY1djkpvZSCR+DjyLoLGzeLvVevZ
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(35042699022)(1800799024)(7416014)(376014)(14060799003)(921020)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u9N9SuDLxsOo2jiLrhn/iUFuNVmk+eeIQ5PfZdd04UK+lY9knopJdKc1QzZ0QTaIkv0g+PewLpknILW275vejWESyMNo47kJ7K3IWh5vqvqZ8HGSnjma0uxVSQ9Jsklm9vYOMp0EDjypvtZl5kE2K5KqIF1zyIDmDbA/CIwDZb29xXywa/JJo58X8FYZXhp3MpQpA4zDoCHpH61s/5msrha5ZDbQK5pEret5VqU5JbLRGVe9yZKkO4wsORrfBxy7u/UE7J22NmhSmDRqv+mkrUhFrix8JtnELkY41Q8tK10DSie6l5cCq9PB3WSqf5H5K5LJ3qkqABlX3NFHW1kaNETy2Y47sfwjR8FghRA7BK9bqANxtfex3z/YTMJZ5nqcCzEothPqMUX1b5YxjA7Gl3zThbC5/+MO6++Rwq/nWtLXUIsWvnCSK6LhWgQyJ+TW
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:18:26.5161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bf35a0-9d69-4520-6b18-08dea6b294e4
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8293
X-Rspamd-Queue-Id: B544E4A2AC9
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
	TAGGED_FROM(0.00)[bounces-282828-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,solid-run.com:email,solid-run.com:dkim,solid-run.com:mid,lunn.ch:email];
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

Add bindings and description for SolidRUn i.MX8DXL based SoM and
HummingBoard Telematics.

Modify SJA1110 Ethernet Switch bindings to allow SPI Mode 0.

This patch-set is based on v7.0-rc2, because rc1 was experiencing
deadlocks with imx8qxp clock driver.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
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



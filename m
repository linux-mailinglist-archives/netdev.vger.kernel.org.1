Return-Path: <netdev+bounces-276979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLLHDBid12kUQQgAu9opvQ
	(envelope-from <netdev+bounces-276979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:35:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D833CA7BE
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3F7A3016CB1
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80583CE48B;
	Thu,  9 Apr 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="ZjdB/kON";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="ZjdB/kON"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023117.outbound.protection.outlook.com [40.107.162.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5F3BBA1E;
	Thu,  9 Apr 2026 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738118; cv=fail; b=mP6p5rk6358Azu6R5aNP0eoFs9eSls8rsw7Si5ioD16dvWCEkn66Z9twaWsQRp33MDjPcGSG0VB0HW5Tt5+L88m8alI50KTwKoSXyhxMvXkDLqlLbOs4k+IeEB6+7DuLnK7BBMjmb9zU/JUG7ncpx2ZLLyN6ux2WqJYVLzN9ajo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738118; c=relaxed/simple;
	bh=0/3evzFQLfnOH6wmnttn8vz0qQ0rGBcSoztZ1+UCwOc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=aXYeilIsmTIMuqvuddB93p3iqR1LKvMTuDdSWZJbI+WPb3kLUjVDQs/XkELQirUXlIB6eb2OO6Q+oqz9lfKqUYIQuVaswCi+VMVCtBat6xcF5bsrwUSNM+63SlQgrId9aa3s728mISTZoaxtPKGeDziKAb51XVjBnwi3xWCUrr4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=ZjdB/kON; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=ZjdB/kON; arc=fail smtp.client-ip=40.107.162.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rYNuVe7/ukYctCVZfxQn5p1Nda9HrJajziMFEBq/pd33HVdLf9oKT3LMMnGUrAEmm5sr8EQnCy9TgrpwuplrTAH6oL606Kq9d4XPtqb0ZiMvxYndmvSgFPfzTjhsTxYK0FvY+ZfE4EiHhfRm7uUSc8uoBepgMopdSQ9OYXE5kaXx/ByVBUc4C/hih2Ld9a2h4KDkh9tcq+MFE6XidJZWfXUbKGci3c2usW8hbreaveOFGPyH6kysTEVCtVwp2yJA9pcYbBJTYSwQ2m25Uj9lTfuZR2PV+KX4K3l6U9UuV+bnZhzAxxGJY9SUtfxs3rdJCzd6jI5px5HOxKtGWdAShw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4jZ2/a3ztwUEmxAgRAXDgwcJROz6x5TpIvaypSoZKQ=;
 b=FVfEGzBk2m+jMx2Bu8EO0LL9q8ZyfiDIiZNpd0A/W419S83wFJ4UL6lHJijQhP6HwnQholIjR3XQqAiR1UfgfYBfOO0ZDS/368WAg5Yf81SIaTvfs5t7hRtW2lhHyE0JCtfvBpbfyqdq3TNozFat2fI8lhVUlUasTx5zL6w/ybKcimh+LAWofybRNHez0Z3ujUNv4JhGZ+qBCnCHa7npN3Kz3i1IhFSrTWkTtikad5kwLFbfzOUjnO2e2MoZUqcj256nXLFkQmXEzrpsQoOvgqyEHXe+xl5HAnPLdvUq+bR4HeATM4Xp3D5PkMKmo0PvrebPczCWc/rC3HN4c/yi4g==
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
 bh=k4jZ2/a3ztwUEmxAgRAXDgwcJROz6x5TpIvaypSoZKQ=;
 b=ZjdB/kONubus7dWQFt2a18WQt/sbzafeOMHLyB1OvOqann58Yc54CL5LAZcVt7Him3J4s5XormeoaNd5FVur8KKx1aZGaRODFlP3aXSP6vhEC9QP9xIqcvQcBuvApuwp4/uBB6fmKz9VrOk0si1JGxLHUzcuyG9BopBiHOAmOW/6sX7ny2k3vRE880hiMLygAVB6/nfARMW2XjW/DttZuXHxs+F90PvYNq3DxTdx/ddlBKL58IVSd9J/4rGOLHUNOCXkGKXY/m041VE3XV8QJSecSkWKTnNmSnoRzSoC1jImV6cohTf1KYr0NXK3s5Gh8NASAIuhT6+2G0z3j6fxJA==
Received: from DU2PR04CA0251.eurprd04.prod.outlook.com (2603:10a6:10:28e::16)
 by GV1PR04MB10704.eurprd04.prod.outlook.com (2603:10a6:150:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 12:35:05 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::4b) by DU2PR04CA0251.outlook.office365.com
 (2603:10a6:10:28e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 12:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Thu, 9 Apr 2026 12:35:04 +0000
Received: from emails-5200643-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-125.eu-west-1.compute.internal [10.20.6.125])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 2ABC680ED8;
	Thu,  9 Apr 2026 12:35:04 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Apr  9 12:34:54 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMlVs4mdpNvMRkgScAS+twGPL1o3f639jfwpH/UDFJGG5jQqi+0m5PgxguGtTs8Vh2rIbIP8PaqHelhKSeAuPWZvvlhdu2b23jOTmM+MnBhvRqJd44HGtqc05+Rek68NCw4YKaza+8Zcq9Viun86cWmO55S3qs7V0iv393jK7Newb4t7UHMTYvYLaF4S2SgcomwMm8MBfEeqv8+XzOkESSMGxM1m1sphkQvwUzkpDmWLHR2bOxa1jut8791mhhbP4hjKa2el1bHultp5hdHuOx+3OFpg3h/wkQlZNw8imqiD0tEW3daXGeLVUJAApd8cCo/+6HJ0obPUoJGw/+0wlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4jZ2/a3ztwUEmxAgRAXDgwcJROz6x5TpIvaypSoZKQ=;
 b=GXNTen6vb1d05xg8EJF7Qf5iGTbd2+lG7h37jS288ij3qu/uPS/OZakvhL8HaX+hKmswf3i98rZHvGNTqbZ0mTSYYEU+YsXCsU/r59WyTICgBmcFGc4cBGZZEVtPnyNmvbd88iMssZDF9Y8r5DERFtKzH4rK5qIbAW1XIwObC91diHAYg4SI07/KONLiP3KOxPPKflHuDSoXd2DnPFV/z89gs7CMxPJGnGwNbxAmeQS2/Z/D1BkNxZVAPNYTvkKQNX63QrozVO5BbGQCEPV0ltzOhiCTQaoYM7du9LYUJCtuBlA3XlhCAK05eyWNMSj7iOVayXTCzAI3lT6zVsfSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4jZ2/a3ztwUEmxAgRAXDgwcJROz6x5TpIvaypSoZKQ=;
 b=ZjdB/kONubus7dWQFt2a18WQt/sbzafeOMHLyB1OvOqann58Yc54CL5LAZcVt7Him3J4s5XormeoaNd5FVur8KKx1aZGaRODFlP3aXSP6vhEC9QP9xIqcvQcBuvApuwp4/uBB6fmKz9VrOk0si1JGxLHUzcuyG9BopBiHOAmOW/6sX7ny2k3vRE880hiMLygAVB6/nfARMW2XjW/DttZuXHxs+F90PvYNq3DxTdx/ddlBKL58IVSd9J/4rGOLHUNOCXkGKXY/m041VE3XV8QJSecSkWKTnNmSnoRzSoC1jImV6cohTf1KYr0NXK3s5Gh8NASAIuhT6+2G0z3j6fxJA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by DB8PR04MB6908.eurprd04.prod.outlook.com
 (2603:10a6:10:116::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 12:34:51 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%6]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 12:34:51 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v2 0/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Date: Thu, 09 Apr 2026 14:34:32 +0200
Message-Id: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANic12kC/3XMQQ6CMBCF4auQWTumpVXQlfcwLJp2kEmAmo4SD
 Ondrexd/i953wZCiUngWm2QaGHhOJeoDxX4wc0PQg6loVb1WVnVIk9rG9YRJaHECXttNXljjW4
 MlNMzUc/rDt670gPLK6bP7i/6t/6lFo0KPZ2cuTgfGm1uEkcOmN7z0ccJupzzF8bRZAewAAAA
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
	GVXPR04MB12057:EE_|DB8PR04MB6908:EE_|DB1PEPF000509FD:EE_|GV1PR04MB10704:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a569fd2-ee7f-4db7-301c-08de96346ced
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 9rAtgMpmDoF7s4hgBtm49m0PUnEF2KvGOe23I0yoefQvQje3lPj5RRmZtyuE6ou8jAVslpDBML9y9bVug2cX0TK2bFpEBpuTieBenCf7Tbfo5vZbezMt2UDJrICsmsiRMdtTtnqmkCRrWORvm138Yq+rwU6sOoU2A6ASSoGTiiEyZgLgkLjKftn7+pX612xNsoTJ2uV1LbabrYHFaugVF9TCFg9MYvigAFrl8fCJzu8W+7NsWEEvzda7cvPK8jh4FF40exsxH1XxrFZk+Khmu9DAOvZqq2BPOnFzLZt+tN3R1YN0GP6mkzzrMXQuQ1thZzAlWTI4LWihHcu+Flz0Z90iSpFnEtqjHr3Hg0QxBNTmiV86SX8ZQgsoSK+F8I6/Iq+EJFzBXX1DVvWHW/5CotMIfLQC4hbkjrSa0YLsoo7gG/w4txCU5b56n6LkCPNtKHIL/Y6dFKfUXIfhTwrcPmwae82NqBI4s1fxkgLB6Ax+WwlDjukjlb/cBPG3PwrRFnsnNiUjUkRSfFw/1Oi945kBgNO1nZSRMdzy8zizkRpoAqiVdE6fwTL0hO/AF9ys1mn0eXDViggj/Qafw/RnWKVGPmdLLP5q2czBrGPVrOL0oWrTI+5MSmaXFHb/V5U+yv7n7OjAJR5CKgMlYpdB2303HfOUYWsMf/8h5TwcS5n6cyHmqRvD2pMqD4L2qqAq718Wbwo5ZgXU91CdyLPePzdxB1VuEnx3RkX5fhZAc/mYqktVslMTLQnu4nYGrLqLXTJXC6CqoCUC7qFS21R2MNqCS4G+l8OWN4PcJeyyhsnJrZpUW6KourU1M4fU0Rg1
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 WL5lCBe41JpBMJUtQ6jy9e0VYBQ8OXFuiTwW6cxkNMxOsMJ/xNSAn4HN23ZVysBiyx7NSrUk5CXW+kM9Pey2OCvdA0d9vQjXyxSEgqfjILeA1ioKUC7r3GYq6y2Jl84H5+cQI+oKPHULViZJE0kagpHZtASe2yHR5vmiq5Gve7oISE6g3yGY3i5a5TgZlOrzDSCGhIIVr/bzgpRu2x27KsyEtEI5r2v4tNA5d4TTgOmzW1h7wZsgE7Yhf7X4ibqEyqj4SVLHUHaq/gKg0ZkMwPzTmoEyNDzM+PcKaGY1NF6KAJnqY3wjVuXBCJzr0+KbpJGHJTm2Dg1z8rwpoO7EKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6908
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: c88f013bfbaf4791849fc66ddaca6151:solidrun,office365_emails,sent,inline:5c2637788cb1ea3bc6e1f3198e4b9941
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7770bfa0-d611-45db-1a86-08de963464ea
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|82310400026|36860700016|1800799024|376014|7416014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CwpkpVi7lRiybCyN6FZGWYoCRz4nVtVMdj+fTTGf3kVt6qm69G9x4JC1ICXCXm5IQS7GFby7Bp6/ozPN4zryPC8w7XBD7ZJhV8lX3RLjB171jfIJy0SP8gUzZp5A5uOe7pMybx5xc530XX/LoJfdCFzIk1KNgfSZIA0RFwjV+CHisFmOqTCLomWpcYtXJ7rZIpxjFEUFYm9ZX5agDzoLSy5fmQN6pOj8ALGTLnLZsaAzXCAoxSQVVJrfVjpc/+MFtJF0VxzJx+R7pRWe3Ww17liBGjJqQrnky9XMh72hs8MB85tG9a5XwBqAnvs4txJBLsSpchmSbQRETaCATpkfCKEHASt5jSI9GIWOcrDld1gftGnMd/rZyNTRpiGiW0XbVHyQnvzPOiMY4ADJhyL7L3Tq1hQajBQ5R9O9leZ++RH4IxuHEE3X2lT71esB1suqARQvxU/Xj67XmFbeN3N8Ywqs1VT3vlOhP39XoNsCfOhz9a0XtmXdASI6cgp1Ft6jLpZ9UO2dZswpOYRScTfTTO8f9v4cCtMa5arb2ZID1qCFN864aeG7N4KPXt8q8zNUZoEZRV4u8UpymvUNwypyiRAaqUQebnxsIy58SSTCidILYXITHea/rbkKebBiH2UACzSzDv8Ja8OW4LpIfDVR46c0OyVlqUHOLyVfSNwfkkC9r7EHd9Lfw4jehbJeAHV9tioaAH8KfEXFV75QV+nFikPxu9K8BqM0SLXSyocS3dI+5dZDimIot8DN1XY9l1AIsdYjpaPiI2Rf1TKoJruRQv9kiF+noIyhR+DxuvfcDAGs/bsUKWnNKcThKiQnhlVe
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(82310400026)(36860700016)(1800799024)(376014)(7416014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rw3GPobwAbGrNp4AbtAmoZVUtO1WIf0eUSQcVck53IdV69qR8SYozSpeTAdx1fm/HqMBgxvUZF4931vvHoZ/TIZlYNFrcdZpF7aagrvJUALNr44Fxmg5lw505xWfsNHNcfsa7zpHfCoyKUdgk3/fHCSOt4A7q3GYHHVJjgixdMhHnaS/7aZR2rjbU0SMW6Eok77kqsf0RplEhLUjvKLBQtcf6I3hF0opnacLsZKOuvw2hR7hnDa+lFQfjWUZF6gcM0XWt5ywL9hsGRGTqCLaTxct6CvlMVjMjH3Cp10OcKVq5QrUrYLaRZbEk23ZnJj9fdLyiGsLy4P/RKMKgzQKMxzEJQjhWRa77kj9wWxUorLyTIU1yIUvpoLyDL3+EWpusBz8O3OLv3YMmv7+zGZUjwn5OgBQ4YUEPpr2x2akYZMykbz6RWt+qdejofdutJh1
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:35:04.2703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a569fd2-ee7f-4db7-301c-08de96346ced
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10704
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276979-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:dkim,solid-run.com:email,solid-run.com:mid,lunn.ch:email];
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
X-Rspamd-Queue-Id: B4D833CA7BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings and description for SolidRUn i.MX8DXL based SoM and
HummingBoard Telematics.

Modify SJA1110 Ethernet Switch bindings to allow SPI Mode 0.

This patch-set is based on v7.0-rc2, because rc1 was experiencing
deadlocks with imx8qxp clock driver.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
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
Josua Mayer (3):
      dt-bindings: net: dsa: nxp,sja1105: make spi-cpol optional for sja1110
      dt-bindings: arm: fsl: Add SolidRun i.MX8DXL SoM and HummingBoard
      arm64: dts: imx8dxl: Add SolidRun SoM and HummingBoard

 Documentation/devicetree/bindings/arm/fsl.yaml     |   7 +
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |   2 -
 arch/arm64/boot/dts/freescale/Makefile             |   2 +
 .../freescale/imx8dxl-hummingboard-telematics.dts  | 536 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi  | 458 ++++++++++++++++++
 5 files changed, 1003 insertions(+), 2 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260408-imx8dxl-sr-som-f141ec343173

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



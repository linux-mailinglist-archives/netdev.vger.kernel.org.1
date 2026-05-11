Return-Path: <netdev+bounces-286639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCLuLV7QAWryjwEAu9opvQ
	(envelope-from <netdev+bounces-286639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:49:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B62350E340
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A94D30C8168
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B863EB810;
	Mon, 11 May 2026 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="X3djhNUZ";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="X3djhNUZ"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023142.outbound.protection.outlook.com [52.101.83.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0740C2727F3;
	Mon, 11 May 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.142
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502657; cv=fail; b=NzJk7dp2QoqOCiQ32Vls6R25Mtu7F1I6jA8ePZXl7a2j1P8qJIxQY9vb7t/4ya2rwvkSBPkgHIf6/XzsZBcGB3WK0sB4jWGR11zRCa0IxFt9qT7y3sjlVKY/2z9J4Tkwrw8wlxBhtkWVZFTTY0YN+FOERuVBgrZJZKS+EFxNIn4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502657; c=relaxed/simple;
	bh=4rRSlrZNPqDYtOYXD9YEQUs7w+F2ALr0SIXSPHKkZJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mug43XPAFtW1eTXw8xpoE7fepmN/flTPJOXb+yMABlD6N7zb4oJvFNAc7uD6L7wVi8vBElI4ldvdoXFqEoFOFWLXQkThjFV97UR5kuysL1LU8cehfvxkqm0tS74v0Dhc4M89vIJ2Bz8u64e4GV/VCULtCzsXxRtvL/RVGTmsYtI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=X3djhNUZ; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=X3djhNUZ; arc=fail smtp.client-ip=52.101.83.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OIsS3RPIPcOokpaZxaZhjnO2Hf9qiCFZtHen0kfTDnJUV1o7LL/X+zAMmqO2FvCJ26ekYZENvMuaWnQ2KGf8E4h3BcB0kTXHd3FAY/pwN7oiFnXhct8zsuxRN8NB8bUQiLL8vGgoA5uaLdSn7gkOkvWFO3raNPErfQqngTN7Ij3w/Loq4gyGHZJelDPGnZqLrNWz79FmqAYX/ezM8wB7g56qEUnMrArkHiD4Y4FFAT3UqpAal7n3mBQXCyA24LsnMC8DE0BCLvfCeDITuheXyD/BzNivgCCptd8NFMiB4QmUl/QDOFMQyL1pGvTdmPXBJXV8Lt/13+xNcFyiHd3kWA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rRSlrZNPqDYtOYXD9YEQUs7w+F2ALr0SIXSPHKkZJM=;
 b=UNRcUteQ0B6n7unEtNZU/nTbrFiBLaxntVA0qS7JFjvYxXqiSk+vsh2Ge/t3RDwjixA3sRujMJcGNOAdd9dznDr5zpcAMnDgzd/UdsKfd7NXWNeYeR4ND5x0Zu8p4zEbFDAfksTSqJxOJYgklNSjlF1DhrX/lNoNvLdfraZ2EraXd5XfUos7rAr4v+/dCqcROkEftVCv6t9vA/8hRqdhraIjeRHOauwrmqyrXm2acGv18XlNz3BA171F0mUUclhtnOSvE+EzdJsWfHy3fNMbOvuOPDPYPnbIWvx8cBWrbyR5ln1qryf/qF1yIM55jIoVr86NtABuLcRcEDBK04YcaQ==
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
 bh=4rRSlrZNPqDYtOYXD9YEQUs7w+F2ALr0SIXSPHKkZJM=;
 b=X3djhNUZBZxYNsujd46kZD7u+aik2TQxoX0ar1iAr5rLuFoLxgO2dEyB2PVOp5QLlTZ5dGXV8qblNjfd7KSZiyzGsJ8BcYSpJ/oD5dzBNNBppZu3ogYxaTOp/dEWZN0+gt8oHlXXWA9QDL0MSYYJjslS/DztliDY10ilIzcqmvez2L/jor+o/3qeSW/2kalVYspsIF5XWix6888riwKioTbFHJ4G7PlSEU4P9Q2XN+3X3L84v8n0JvroZ0MmISpSwr/jSvbV9KbwHbNtu1xVb/Vv7cDHLaRcalnw7IG1ycQFlp1HxV65mjq2N6HNHqR0OCZ5DKV/b7y5b5En8ZPXtg==
Received: from DUZPR01CA0323.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::24) by GV2PR04MB11302.eurprd04.prod.outlook.com
 (2603:10a6:150:2ae::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 12:30:50 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::ab) by DUZPR01CA0323.outlook.office365.com
 (2603:10a6:10:4ba::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 12:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Mon, 11 May 2026 12:30:49 +0000
Received: from emails-2708590-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-143.eu-west-1.compute.internal [10.20.6.143])
	by mta-outgoing-dlp-588-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 30EE680091;
	Mon, 11 May 2026 12:30:49 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Mon May 11 12:30:39 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDOfUTSmtBiDUDDAY+EDOl+XvdjPOJ/gSnUTQvnD0UkC8S/uSgYZpAubKvvXLsuX4b3qpLFMSTGkXFU9pfMsmZ1myNkbBAwB4xXavCH98EUjBgRaEAquTFkbOByzgmLP1PPU62fDPomvrqf64Wwm0687Q1lzWr7aBneLPg4SZ3reeOu2y+Auptjm+znVyvI1KQ5zgkAn/FVcGlAEuvmj7+jdErTqFvxhBYG6unGDcu/tIrragZVjdupoNqRf3Lcj6RfLFWXaU30mwcaVK4K6hO0eIz0c/eyP5l7WCvoU0RYtPQn3iv0YPs0KWCUWJ64sjVc5Y5zS8TdrkOWLKpCUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rRSlrZNPqDYtOYXD9YEQUs7w+F2ALr0SIXSPHKkZJM=;
 b=YxbyGhAsJtly1TNAtNC+DK4GqYMlPIKAoHRTTLz/CEhzE/saahRKC+1hz0drG/oEzH4f6qajJtLutEmu44OtTIOi/xV2VKUfd8jEN55LpOfUbrpdATJL7b+7C2n4Gm5Nk4LAdosmmqqLw0Enr+gRb4oTDbJmUEJCyxonM+n04s1ZDIuMFfmFMVrXCotZ41y0K5HeuGOb53sDW/qx7ZpDUepup+o4nGLVg/Yzp61If6FVv0JElPqw9+rKqF4/MFKlLo86mWMuEVEYraZf/Y6mBixGTTWQ8+uFQGkg3XQQ4hzT0dYnSRNJCM/fVxn2rL7yIeAam3ozMQYAdIx2Ai4dJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rRSlrZNPqDYtOYXD9YEQUs7w+F2ALr0SIXSPHKkZJM=;
 b=X3djhNUZBZxYNsujd46kZD7u+aik2TQxoX0ar1iAr5rLuFoLxgO2dEyB2PVOp5QLlTZ5dGXV8qblNjfd7KSZiyzGsJ8BcYSpJ/oD5dzBNNBppZu3ogYxaTOp/dEWZN0+gt8oHlXXWA9QDL0MSYYJjslS/DztliDY10ilIzcqmvez2L/jor+o/3qeSW/2kalVYspsIF5XWix6888riwKioTbFHJ4G7PlSEU4P9Q2XN+3X3L84v8n0JvroZ0MmISpSwr/jSvbV9KbwHbNtu1xVb/Vv7cDHLaRcalnw7IG1ycQFlp1HxV65mjq2N6HNHqR0OCZ5DKV/b7y5b5En8ZPXtg==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by VI0PR04MB11782.eurprd04.prod.outlook.com
 (2603:10a6:800:2ed::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 12:30:35 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 12:30:35 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Frank Li
	<Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Andrew Lunn
	<andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Alexander Dahl <ada@thorsis.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Conor Dooley
	<conor.dooley@microchip.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Thread-Topic: [PATCH v4 2/2] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Thread-Index: AQHc4S6NPDp3cRKl10uFQFLEqUD7b7YIr0xYgAASRAA=
Date: Mon, 11 May 2026 12:30:35 +0000
Message-ID: <f0fdea25-6b2d-4b64-b925-a3f30c8e044c@solid-run.com>
References: <20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-2-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-2-64381b3bf80d@solid-run.com>
 <20260511112438.4fxvhelf242emzft@skbuf>
In-Reply-To: <20260511112438.4fxvhelf242emzft@skbuf>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|VI0PR04MB11782:EE_|DB1PEPF0003922F:EE_|GV2PR04MB11302:EE_
X-MS-Office365-Filtering-Correlation-Id: 488457c7-eb10-4508-f08a-08deaf592228
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|3023799003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 vlWsNs+2Q7U+VxCMcX/q135iCGJ0YY5cxknF/psipqZ9j6x1OWTdU1dIoy0kuqg02eGO0+v4wTQmp0KMt0uRIdspd2aO7huH5zUV3yQSDL16UDk9EVq0fFTJaXcgkjykX5kPkRPnxP1Fowb1j33tjSecZdQvX2ZGehyqe34O8zKxuCg0TN/RGi1IovOPEOvf6xnqMZ814NA6142izRWPSUIYvg2bQoNARvB7fjiSwWJTGSYf8kLSQP+2xtKjPv5puWIqrALPk6h1KNUtGIYemwr/luSKXAz27zuKeeY9avOq4bGKPskGHnIJ5kbuJnrLCdqSo+z0ELw4Mw4f8xzxZJkLid29qwZUKufisETWRsZvDN1/t/rObq8/PlOu4E94y80W4fQmTwA+s7aTVz2uCd/vFTtK29TBIMCvgrdk+SAbThy8wUpAC2H2R+2MCa1CHBeJvC1vIYFlyRLmizYYlu4B7HWi5gKoqHVtsXN0CD6ubKzNXuixWUsTaeUU56i7eF2zqViBCeRAwTdFFj5HD26b8s7NmJxOf91YyxJjqv69oJspQAmnlf3mMqNJ+8DBk0uV6rD8UIdIO39nTlpNnO0+/OAEvXOApUntbvGnNvRjaVmQtgeOArezdo/7xl+KmhyV1o44yEXN5qwdPxy3Vdk7ZiqtqCVghPDvXOmno6D6rS6RlbqBhIvCGDdNkz/YVDMFIhGsQet1GdbVtO3g0d/vC+3ZlAyddrsUpG/sLxQyeDxwXXNHmE2unu180mx3
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <7853B97F5FD89B4A91FE09233CF383B3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 am6bLlCsd1RhtyHlAan7L42KiiXhxJ8QjN13fNpsDxNnnFlEM7Gh3EZ2bJyO7Yf0YnXwEnVFF4SvPQNz3sNBjY36i0sxTmjTGgm2p+HVbw0l4TnQnpiPUxUq8WKn8DdFBe98cKifowI5zQhlL86FD2rzz8ziJNx9wUiCnGTlOsbgyA5enKhonrYe3t6BBAbmPhZ86nOGRMkNP9rqDFOWU5CPfc0xDsD6DlpHrj7EKwHkQ0NnZv6bmBqzgwPDSs5YJIgB+MUo9jdFQQtXM5aRVTtI2u7W/osDCY2zdMpbxIgV3IB/qMrqLmqVQ4cN0ePB3cd/CPbplhgn+apxBlG1aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11782
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: a159194249c04bf492efbacc1815cdc4:solidrun,office365_emails,sent,inline:4998141c306cb2f5ce0fc0908fdc295a
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d9541ada-75ad-4ef9-0511-08deaf5919e2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|36860700016|82310400026|35042699022|7416014|376014|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iUVn6VvUjeLaBTGjBH5MSPWgWLbE+ghjuSsH+KVg8BMk3sB7PjVvHN+UvjLvnle31IY8349nLbcTWGTvg5U/BfpVCt623//S75is9SE/Kongz+yT2tXDB5DqGTqAstK+Oc5qhsdg/31R9LtOLgwo7WQqOK7lEGJwLzctEFbKKfmyxiNzymGzmIanV7rDEwIy1RCLIkuP1CBTlTTg7gTRPz17zOPLkXs+dw8Hudm2TE+mllDWbyUoR+efLhLVorBgFslt5T4wNCn/VXbhhZb1ADK0iBB6XLbsS7LI1meKONJ+wz+WIXBrSN0fABdV5K9PIWir+tGkGiL1G01FzlEy6yo+Ccj/vyFbkRR99ne8hYrm8tIo8WZriy35+U2o2N4ZU61+Jve42oWnIPeCeUozn5B/8ePzxKEnFTyISdOLwtxBHTZI8wdKArTGOOA9VGeRadruKq5ESMrO6BWRKEtZTRqNe6v+EIASkbRoP6i4/8Mc3EDrp6WF45TiS6aTOwGqD7xdvSEuuzLE0JgcJ8bK8zuf9NTwRlmUHjKwkO6nSB/Fyuh0xnw+gTghmnkefo0HxF9UuSMEtxAMNeF6lO/ustuawWOKwRZWGHdBLdlkm8q6sScjjku4KAwn+kQMocmalo9Fz+73aFfAToCgi3/iO0CwD2GnzACM/dpjf2LsppUE0sOOLFprrwvP8nTZZIP73ymZwVBT/9r8zIGONi/N6/XJZy0GEqJJdGzG1jktlyE=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(36860700016)(82310400026)(35042699022)(7416014)(376014)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NvlA5mxDIjqsS46wWxihdWskuzRAMpp14j//Cgf3WyATxn7yCwLud07u2OXzMR2n6JM2f7CdKtNpdoG9oJx9UU4JLsSTmzZi3sxZZtR4yAtnGwODKIX+k1aXSLo8VyxUbui+/nphDmQ1n9P3K7/3Q1mLNSg4adTbPuqaE5ASlPRpiREsedKIyOxD9KTa3PTAVa7D6UW9rAcZvc0fMwLDUQOTDBL0FxOOJFO/gaHYn+tHU4IB8dzUSzvHNJThqTHIrUsxMzxkyignrUOwz1piuUDhUmmWbYZiVAUGH0uT1tRIxB7D4c3N2DNamJtboRgYLzJO1R5gbVh7b70SSgPJt3YPIWcqMxBtGqUTV1mh6Hb/UYthLyZKMLZVEb+SgBWR7rSzSYES3J5/SYWcU0BRCoyNv7sYv7n5grmZ9GXQ+LRxfWrUXSd1PFORmqoEHT5o
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:30:49.2824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 488457c7-eb10-4508-f08a-08deaf592228
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11302
X-Rspamd-Queue-Id: 2B62350E340
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,solid-run.com,thorsis.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com];
	TAGGED_FROM(0.00)[bounces-286639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:dkim,0.0.0.1:email,n:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

SGkgVmxhZGltaXIsDQoNCkFtIDExLjA1LjI2IHVtIDEzOjI0IHNjaHJpZWIgVmxhZGltaXIgT2x0
ZWFuOg0KPiBPbiBNb24sIE1heSAxMSwgMjAyNiBhdCAxMjoxMTozMVBNICswMjAwLCBKb3N1YSBN
YXllciB3cm90ZToNCj4+ICsmZXFvcyB7DQo+PiArCS8qIGRlbGF5cyBhcmUgYWRkZWQgYnkgY29u
bmVjdGVkIGV0aGVybmV0LXN3aXRjaCBjcHUgcG9ydCAqLw0KPj4gKwlwaHktbW9kZSA9ICJyZ21p
aSI7DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZXRoZXJuZXQtY29u
dHJvbGxlci55YW1sIHNheXM6DQo+DQo+ICMgSW5mb3JtYXRpdmUNCj4gIyA9PT09PT09PT09PQ0K
PiAjDQo+ICMgJ3BoeS1tb2RlcycgJiAncGh5LWNvbm5lY3Rpb24tdHlwZScgcHJvcGVydGllcyAn
cmdtaWknLCAncmdtaWktaWQnLA0KPiAjICdyZ21paS1yeGlkJywgYW5kICdyZ21paS10eGlkJyBh
cmUgZnJlcXVlbnRseSB1c2VkIHdyb25nbHkgYnkNCj4gIyBkZXZlbG9wZXJzLiBUaGlzIGluZm9y
bWF0aXZlIHNlY3Rpb24gY2xhcmlmaWVzIHRoZWlyIHVzYWdlLg0KPiAjDQo+ICMgVGhlIFJHTUlJ
IHNwZWNpZmljYXRpb24gcmVxdWlyZXMgYSAybnMgZGVsYXkgYmV0d2VlbiB0aGUgZGF0YSBhbmQN
Cj4gIyBjbG9jayBzaWduYWxzIG9uIHRoZSBSR01JSSBidXMuIEhvdyB0aGlzIGRlbGF5IGlzIGlt
cGxlbWVudGVkIGlzIG5vdA0KPiAjIHNwZWNpZmllZC4NCj4gIw0KPiAjIE9uZSBvcHRpb24gaXMg
dG8gbWFrZSB0aGUgY2xvY2sgdHJhY2VzIG9uIHRoZSBQQ0IgbG9uZ2VyIHRoYW4gdGhlDQo+ICMg
ZGF0YSB0cmFjZXMuIEEgc3VmZmljaWVudCBkaWZmZXJlbmNlIGluIGxlbmd0aCBjYW4gcHJvdmlk
ZSB0aGUgMm5zDQo+ICMgZGVsYXkuIElmIGJvdGggdGhlIFJYIGFuZCBUWCBkZWxheXMgYXJlIGlt
cGxlbWVudGVkIGluIHRoaXMgbWFubmVyLA0KPiAjICdyZ21paScgc2hvdWxkIGJlIHVzZWQsIHNv
IGluZGljYXRpbmcgdGhlIFBDQiBhZGRzIHRoZSBkZWxheXMuDQo+ICMNCj4gIyBJZiB0aGUgUENC
IGRvZXMgbm90IGFkZCB0aGVzZSBkZWxheXMgdmlhIGV4dHJhIGxvbmcgdHJhY2VzLA0KPiAjICdy
Z21paS1pZCcgc2hvdWxkIGJlIHVzZWQuIEhlcmUsICdpZCcgcmVmZXJzIHRvICdpbnRlcm5hbCBk
ZWxheScsDQo+ICMgd2hlcmUgZWl0aGVyIHRoZSBNQUMgb3IgUEhZIGFkZHMgdGhlIGRlbGF5Lg0K
PiAjDQo+ICMgSWYgb25seSBvbmUgb2YgdGhlIHR3byBkZWxheXMgYXJlIGltcGxlbWVudGVkIHZp
YSBleHRyYSBsb25nIGNsb2NrDQo+ICMgbGluZXMsIGVpdGhlciAncmdtaWktcnhpZCcgb3IgJ3Jn
bWlpLXR4aWQnIHNob3VsZCBiZSB1c2VkLA0KPiAjIGluZGljYXRpbmcgdGhlIE1BQyBvciBQSFkg
c2hvdWxkIGltcGxlbWVudCBvbmUgb2YgdGhlIGRlbGF5cw0KPiAjIGludGVybmFsbHksIHdoaWxl
IHRoZSBQQ0IgaW1wbGVtZW50cyB0aGUgb3RoZXIgZGVsYXkuDQo+ICMNCj4gIyBEZXZpY2UgVHJl
ZSBkZXNjcmliZXMgaGFyZHdhcmUsIGFuZCBpbiB0aGlzIGNhc2UsIGl0IGRlc2NyaWJlcyB0aGUN
Cj4gIyBQQ0IgYmV0d2VlbiB0aGUgTUFDIGFuZCB0aGUgUEhZLCBpZiB0aGUgUENCIGltcGxlbWVu
dHMgZGVsYXlzIG9yDQo+ICMgbm90Lg0KPiAjDQo+ICMgSW4gcHJhY3RpY2UsIHZlcnkgZmV3IFBD
QnMgbWFrZSB1c2Ugb2YgZXh0cmEgbG9uZyBjbG9jayBsaW5lcy4gSGVuY2UNCj4gIyBhbnkgUkdN
SUkgcGh5IG1vZGUgb3RoZXIgdGhhbiAncmdtaWktaWQnIGlzIHByb2JhYmx5IHdyb25nLCBhbmQg
aXMNCj4gIyB1bmxpa2VseSB0byBiZSBhY2NlcHRlZCBkdXJpbmcgcmV2aWV3IHdpdGhvdXQgZGV0
YWlscyBwcm92aWRlZCBpbg0KPiAjIHRoZSBjb21taXQgZGVzY3JpcHRpb24gYW5kIGNvbW1lbnRz
IGluIHRoZSAuZHRzIGZpbGUuDQo+DQo+IE15IHVuZGVyc3RhbmRpbmcgZnJvbSB0aGUgYWJvdmUg
aXMgdGhhdCB3aGVuIHRoZSBSR01JSSBkZWxheXMgYXJlDQo+IHByb3ZpZGVkIGJ5IHRoZSBzd2l0
Y2gsIHRoZSBlcW9zIHNob3VsZCBoYXZlIHBoeS1tb2RlID0gInJnbWlpLWlkIi4NCkkgaGFkIHRo
ZSByZXZlcnNlIHVuZGVyc3RhbmRpbmcsIHRoZSBzd2l0Y2ggcG9ydCBzcGVjaWZpZXMgcmdtaWkt
aWQsDQphbmQgdGhlIGNwdSBwb3J0IHNwZWNpZmllcyAicmdtaWkiLg0KDQpUaGUgc3dpdGNoIHBv
cnQgaGFzIG1vZGUgcmdtaWktaWQsIGluZGljYXRpbmcgdGhhdCBzb21lb25lIHNob3VsZCBhZGQg
ZGVsYXlzLg0KSXQgaXMgYSBmaXhlZCBsaW5rIHdpdGhvdXQgUEhZLCBzbyBzd2l0Y2ggbXVzdCBh
ZGQgdGhlIGRlbGF5cy4NCg0KRnJvbSB0aGUgY3B1IChlcW9zKSBwZXJzcGNldGl2ZSBpdCBpcyBh
bHNvIGEgZml4ZWQgbGluayB3aXRob3V0IHBoeSwNCnNvIEkgc3BlY2lmeSByZ21paSBpbmRpY2F0
aW5nIG5vYm9keSBzaG91bGQgYWRkIGRlbGF5cy4NCg0KSXMgdGhpcyBjb3JyZWN0Pw0KDQo+DQo+
PiArCXBpbmN0cmwtMCA9IDwmZXFvc19waW5zPjsNCj4+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IjsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gKw0KPj4gKwlmaXhlZC1saW5rIHsNCj4+
ICsJCWZ1bGwtZHVwbGV4Ow0KPj4gKwkJc3BlZWQgPSA8MTAwMD47DQo+PiArCX07DQo+PiArfTsN
Cj4+ICsNCj4+ICsmbHBzcGkwIHsNCj4+ICsJY3MtZ3Bpb3MgPSA8JmxzaW9fZ3BpbzEgOCBHUElP
X0FDVElWRV9MT1c+LCA8JmxzaW9fZ3BpbzEgNyBHUElPX0FDVElWRV9MT1c+Ow0KPj4gKwlwaW5j
dHJsLTAgPSA8Jmxwc3BpMF9waW5zPiwgPCZzd2l0Y2hfcGlucz47DQo+PiArCXBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCI7DQo+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+ICsNCj4+ICsJZXRoZXJu
ZXQtc3dpdGNoQDAgew0KPj4gKwkJY29tcGF0aWJsZSA9ICJueHAsc2phMTExMGEiOw0KPj4gKwkJ
cmVnID0gPDA+Ow0KPj4gKwkJcmVzZXQtZ3Bpb3MgPSA8JmxzaW9fZ3BpbzQgMyBHUElPX0FDVElW
RV9MT1c+Ow0KPj4gKwkJc3BpLW1heC1mcmVxdWVuY3kgPSA8NDAwMDAwMD47DQo+PiArDQo+PiAr
CQlldGhlcm5ldC1wb3J0cyB7DQo+PiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiArCQkJ
I3NpemUtY2VsbHMgPSA8MD47DQo+PiArDQo+PiArCQkJLyogMTAwQmFzZS1UWCBvbiBjb25uZWN0
b3IgSjI2ICovDQo+PiArCQkJcG9ydEAxIHsNCj4gU29tZSBwZW9wbGUgbWlnaHQgcHJlZmVyIHNl
ZWluZyBldGhlcm5ldC1wb3J0QE4gaW5zdGVhZCBvZiBwb3J0QE4sIHRvDQo+IGZ1bGx5IGF2b2lk
IGNvbmZ1c2lvbiB3aXRoIGR0c2NoZW1hL3NjaGVtYXMvZ3JhcGgueWFtbCAoYWx0aG91Z2gsIHRo
ZQ0KPiBjb250YWluZXIgbm9kZSBiZWluZyBldGhlcm5ldC1wb3J0cyBub3csIHRoZSBjb25mdXNp
b24gc2hvdWxkIGJlDQo+IGF2b2lkYWJsZSkuDQo+DQo+IEFsc28sIGlmIHlvdSBldmVyIHBlcmZv
cm0gZGV2aWNlIHRyZWUgZml4dXBzIGZyb20gdGhlIGJvb3Rsb2FkZXIgKGxpa2UNCj4gZm9yIHNl
dHRpbmcgc3RhdHVzID0gImRpc2FibGVkIiB0byBzdGF0dXMgPSAib2theSIgZm9yIHRoZSBwb3J0
cyB0aGF0IGdvDQo+IHRvIGFkZG9uIGJvYXJkcyksIHBsZWFzZSBuZXZlciBoYXJkY29kZSBmaXh1
cCBwYXRocywNCkkgd2FzIGV4cGVjdGluZyBkZXZpY2UtdHJlZSBvdmVybGF5cyB0byBiZSB1c2Vk
LCBpbiB3aGljaCBjYXNlIGFsaWFzZXMNCmFyZSBub3QgbmVlZGVkLg0KPiBidXQgYWx3YXlzIHVz
ZSBldGgNCj4gYWxpYXNlcyB0byBnZXQgdG8gdGhlbS4NCkhvd2V2ZXIgaWYgaXQgaXMgb2theSB0
byBhZGQgZXRoWzAtOV0rIGFsaWFzZXMgYWxzbyBmb3Igc3dpdGNoIHBvcnRzLCBJJ2xsIGFkZCB0
aGVtLg0KPiBUaGlzIGlzIGluIGNhc2UgdGhlIHBvcnQgbm9kZSBuYW1lcyBldmVyIGNoYW5nZSwN
Cj4gdG8gYXZvaWQgYm9vdGxvYWRlciByZWdyZXNzaW9ucy4NCkdvb2QgcG9pbnQhDQo+DQo+PiAr
CQkJCXJlZyA9IDwweDE+Ow0KPj4gKwkJCQlwaHktaGFuZGxlID0gPCZzd2l0Y2hfcG9ydDFfYmFz
ZV90eF9waHk+Ow0KPj4gKwkJCQlwaHktbW9kZSA9ICJpbnRlcm5hbCI7DQo+PiArCQkJfTs=


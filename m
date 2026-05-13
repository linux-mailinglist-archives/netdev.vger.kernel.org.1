Return-Path: <netdev+bounces-287631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN+TADWbBGqILwIAu9opvQ
	(envelope-from <netdev+bounces-287631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:39:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7012D5364E6
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14F3E310B85C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9838BF9A;
	Wed, 13 May 2026 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="OwDEMkS7";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="OwDEMkS7"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020089.outbound.protection.outlook.com [52.101.84.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223938D001;
	Wed, 13 May 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683873; cv=fail; b=kcf0NwAhOawZoF1e4EG4TcRHVyDeOc+Oi9uXR3a8e52wdAxY3wbKf3I8tl1PAKdoe7ma4D97iCNCxtbMB7Z7N7RVjNM0TvpLvxkztyUW2yQvqyOaWIkR1PAsJojQoFfiZmnXzCI4igTdedjLNfQildeuICZbm74VQtSRGh/kBk4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683873; c=relaxed/simple;
	bh=nzKhAKA08GNQLzE/2f+9StCubMT8vkfXfdWlanXG8rQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dBhyyZK/2ofwt+X4iz49ILiQRRgVjofAe3H9RcEB+25h36r+2PstS1ztWes1U4lSFs9KC9NZWHKIupZX8pkkVDv3alAyXqot6zw0UsBmU+/TaFgIZxO9QfsAeapWe25+T6J6tvp0azBiGKNvShB8kwRoqcHU2twqxTtYqZU1u2A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=OwDEMkS7; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=OwDEMkS7; arc=fail smtp.client-ip=52.101.84.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Q7vlxXR9H51fpibN1pWUkd2kvaLF7g9nuE2kYbPU2bJsbhcu3dKIb6VLvHca37BLKmLx69A/ZVeBHX6ER+vZQuxbZ5zNhjiuH/jQK0AhmBeH9vZzPv22N+wUeHRRr1nH5UkKlmxPUrH+qr5eH8NsTOToH+7SzzFVzD+V1dGwCK/u5VRN7yxdYshIohTeQ1b/xKF8HOMdQP/4ldP3CCd/WPZ+OvBwgFR2M/brr+FjXCQ8JwXsojxQius6QsP04fmFQkmLkoPmQnir/6Xfp/zLhDHfPdVj5iQIXXh4PA3ifd9eJGS4ZlWuu77DIGoaWw022eKU06JqMqOneqDolmlV2w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzKhAKA08GNQLzE/2f+9StCubMT8vkfXfdWlanXG8rQ=;
 b=B+Wgcsdz9cq/YZVH2GER71ZKiGjJ5BtEN5ebmgwLVSOgxQbvPSwTSJvDzlvvnGQRdYs4+znKO8wt583u6hbNPkRZDXpEb0Ncy5TRO93hdF7Y07Dq6iWDQx4AnQlgijlpN+aS30vBaU6i5uL1U9XaEZOF1W0JvRyM/LP9kZlKAGOQxzJSWc8HJSXpXkDIq/Vfu3Wg4SgeHsNVXKRCO0JVD1YX0VQ2Is26lp3EaiyXN3I+5ZIQSwP5i7B1VVCbmHT437aoYWdTTulDNBXAXCrwxShml6S6x330goCPQNpfTUM5FtnGtoY9jO2K2aeyLqQn7n170u1kkFSmSkmwsAN6GQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=solid-run.com] dkim=[1,1,header.d=solid-run.com]
 dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzKhAKA08GNQLzE/2f+9StCubMT8vkfXfdWlanXG8rQ=;
 b=OwDEMkS72kKqnXM23XlzAI4mQT48jNvFTwGKQKchUZPAUN6k6/WBrky3OLV5yKDOmCPwCx76UoOMBGNLOG/EpiXFMoHQiy4m3yhfNkLc6dqN/X24UwOw40GfrbXmzW9c51PZxeP464T7E6LERnnURymwH9e5FB7M3UtTqDSksgNUw8FSh0h20LOU0tu40pcSb6JqV9Axu4kBEue0pYDYTX+wK+7Y3xb0xUCtY+oNrcRnnDdLnK0mYx3aI2N2RKawynQpUQI6B/hV312oq9jeD016q9f41Cz2Y1nom67GEjEGntj0HjW6BYGCXBqehjGDYlfX+PA5l+IfdfCLEDgeNQ==
Received: from DU2P251CA0003.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::13)
 by AM9PR04MB8424.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:50:57 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::15) by DU2P251CA0003.outlook.office365.com
 (2603:10a6:10:230::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Wed, 13 May 2026 14:50:57 +0000
Received: from emails-4576692-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-220.eu-west-1.compute.internal [10.20.5.220])
	by mta-outgoing-dlp-305-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id ECC9680075;
	Wed, 13 May 2026 14:50:56 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed May 13 14:50:43 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCyIrE3tUxMoDeGZxqdyJr+O+MwlThSn7q8pb+vCLlZfe1b9RodCP54LweuBosVrMrnmpJsnAtv+PmjsS6FM2gbgbt2T5VZIugjw4r6kVoJTUwYL2ttzndpt6JZTIKrllvNMXsq6CTJHISyGQnrDvgCyugFwBv9PukrxuQWOhZcwC7BCnK+LLrixUptIzy8G4v8q6F5puy614Oy3Nr9WBEvxKwZHnmSEIDHWH1C70U9EMk/UrEeGdIWAPoVLpLN66HOvvocRN6kJYG34Obl1+6G+dbb+QTETxsVnA9XkN0nJiJrEEHRtqBTqIhGJcXIZOMF4So4feTdMm1h8AsonwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzKhAKA08GNQLzE/2f+9StCubMT8vkfXfdWlanXG8rQ=;
 b=eiVJtY0SLGTRMD9rulV+lEMekReRskhNaAEZVE79gYl/BaUbALTNoMyjQVmeV+2V3sELmbqOZ7ZiYXUGaqzU6iadtQBJWhCtm5YNGfJ30KIKDPJyR01kGRYOKW1I5RO8HtfKDy1HgDoNqnoCoAwy5GdXyRtZabH/qhvWEqQh7vGHH3HEOmHV3LL6bjcZYwBpR76I7+Ixo4TVc8AVAE4+urjD5JYhd2qAoOyjGHKHCmd0++YdsLfhU05crg1WydsrlaiptBZ3PRRntiFqOWHudZCcDnhrgqSYREMCSih0xXjkSpWFZZPa/SIA6P6f7zcrqMRPNrqzXqc5BNotchXOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzKhAKA08GNQLzE/2f+9StCubMT8vkfXfdWlanXG8rQ=;
 b=OwDEMkS72kKqnXM23XlzAI4mQT48jNvFTwGKQKchUZPAUN6k6/WBrky3OLV5yKDOmCPwCx76UoOMBGNLOG/EpiXFMoHQiy4m3yhfNkLc6dqN/X24UwOw40GfrbXmzW9c51PZxeP464T7E6LERnnURymwH9e5FB7M3UtTqDSksgNUw8FSh0h20LOU0tu40pcSb6JqV9Axu4kBEue0pYDYTX+wK+7Y3xb0xUCtY+oNrcRnnDdLnK0mYx3aI2N2RKawynQpUQI6B/hV312oq9jeD016q9f41Cz2Y1nom67GEjEGntj0HjW6BYGCXBqehjGDYlfX+PA5l+IfdfCLEDgeNQ==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:50:38 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:50:38 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rabeeh Khoury <rabeeh@solid-run.com>, Yazan
 Shhady <yazan.shhady@solid-run.com>
Subject: Re: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Thread-Topic: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Thread-Index: AQHc4VcBNwfvvLflf0GuY4D0POuBgbYL1wIAgAAhj4CAABR4gA==
Date: Wed, 13 May 2026 14:50:38 +0000
Message-ID: <5cc008f1-d2c4-4a56-a1b4-6fd9bd470049@solid-run.com>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-6-vladimir.oltean@nxp.com>
 <1ba1f688-9f68-4749-a18f-20ae91738ae0@solid-run.com>
 <20260513133721.huu4j3wksxykizz4@skbuf>
In-Reply-To: <20260513133721.huu4j3wksxykizz4@skbuf>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|GV1PR04MB9071:EE_|DB1PEPF000509F5:EE_|AM9PR04MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8ea22d-a8ee-4b21-1631-08deb0ff0a6c
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info-Original:
 lEIY/8a0hSzbHanddBX15sQw9hqkc5VsmKi1g5umRSLXhsc3Fn2cXHLiiyV7n1s+DVzXzIs9k0wFdxpUcBF+K0hzlvX87STwyTIuUugRK6sVdWAj9zUMv0/av13X3bw9fK6nhPxChT5VOx4RZf3LWNGdWTz0pB2oCaXlhAh77L3ri0/Ljr7/rwTgd2pv7h828739+hl8C0sl/e8V+NfhuA/C3T6y7FlpwKS9wl8gybzEr8VTfe8kZo8U4KSUb7arD2SupeKoB9ASuAdk4U+9SG/ulqRHT3cTEbMm5gl4MXwa09O2kAcReVGv3+3CHP4oeFvWUSuGeKKdg7OmonusT1FjrYN1AFOb6UAXZRuHvNWxC/1TVbyc8tQGevv5u00LuZ7hWRZ1z5v5/TqUnWSHXC56xBU61Y1Zc/+Sw9voCvkyOj1fzXCSDLoflwe3YBfGu4nk/+qMQx6yd679xE0lpb7gc8HAJz852ITwlA7YREZRwreFPY6Yonz9EbE+Tr9rFwEO9p5T46/x1WKSSqPe0fkXV5Mat/vy+RZbhmldqJh70Ya63hGeGB+krPS/YeVen37gnVVdkUnd6uMs0UrkAUaBZzWbTB7PndK5zW+nciukFSUp4fsS/0NNaJh8XD7Q0U6u2eQwgqtwtnAoe+xANiuGdE4FwibiwXoN4OjYrD6y0hyyu55dkut1E6E26SH4F56hqs2cZDwUnIfUSvBjaVstnPyeAX/TR7gaa7WSoKBctHOL2B5ro80L5TUE7CL9
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7708C2720B7C64FB05E9646AC188BCF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 LcNpSiVoCjI7lOjIC/DCVH+KqMgXmDrBXczTOtjn/cLeboPVU0ip0YdYBg4F8TxsRRUxDX6BBgv+QtN5tud+wKq92PcGLRN0cO/VWmIVhMHfdbJMWdLJW+NVT3wsMbvKvizGTDp8P0cuhrk+Zi0DhHMJMfKojerUGxuLseGwCUNcnpg8wpcDDn/TL3hqOmF831TF07pbJfzLPWRAbtXGQAfAsclOCNbuWDWlbUWfHeQRGsz8RmZyoVgfUQ9/kv4QG38UQ+mVQmK/KEQc5qoaPHQLCm2x9cOJTEF4fqoaYhjgy2GD0sl7LYDoPyZagKXNZS2bBp+k1Sa8PCcknLzBQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9071
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: ed7cd9958d424b1eacd4fdaf83a7866f:solidrun,office365_emails,sent,inline:1412bcce9e7a9c86e8f6ce96ca54cbf1
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a74c3f78-c7b5-443a-24cf-08deb0feff2f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|14060799003|376014|35042699022|36860700016|3023799003|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0b/P0o/6/XE4U0uY1+VqKqDr9oyfyoam/5xqyEVkXKQSnYBdPiu9dypnZjvEfghnD7wH4rrwUXOdqpM55SYI5LINUrfIt4yBfTIfc1OUWuhYpCb4QXH2W5UFz7zcxQ3B7PBVXm6j7pvPwuczaPs/R3kQWjbTGnfej0prPXrGH4OZ2Us1Byi1SLmjqV9qJdgX03uTJCbe8NgnXYtKhi6owSBcgNO/e0VlptGh7BPAvNDpgeDaxy0H5YbGZHVZrqm7wdruZDmwAfwR3kDvMjISNd2c56Q51EIcN4YPyGvJaUVS2SnXi56qZI5K316n2nuoRMDdBUH0vUjszVilQpJaqiVL1KL0ITSDNxQKb9vT8/v05gcthrz8if6m3IyLlEM9oiNsko5/dCczAkX9qT0wRxtrtYMfTZ6UElcqCE0Umz2rdxCv2y1t6ZmkzEm6hK/NjY/U6hesf3UYiXVOeQIFwNRcsDJzyovJ4h0D3D3V5ynvmGmCb5QEQJGHUaAW3gBrvpvNNPX+VFCePSbSP/j16J866vZUuPwAV9R0pbJ5zaONJJcMdKoIkbGEvqmMYTeRC1cRih55J0iXHoGwZAF8N8UTGeiJpCTl900lc46A/EqyUU8OA76eB9dKQwpXxMhm7u1dDyUacLoe8SykLDfiIAFhqZJ0AaTAEi+/JGAj47WKTocvo9z44ZgJJcWEKCVgxkXi0w+YcfvjNj1cL8W3EXvzV8JMSXcyOfdHmM6kfJE=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(376014)(35042699022)(36860700016)(3023799003)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r/Sy7rKeEGT+3Zdr7NgRIbUtLq3aleXzN9GkQ0W7XPSwT2MRD4PTWqeBLRjPFUdVRIW8apjeeKx+Lpjpg86BVVYLVPOMG3u+deHW9EKutF7T1TVq9iV+X6uastC5fqdn6OoS/KeCSEIY0vCOlxVof6ikQIM80dFrcbp5cr9Z9wSYA1ZGYE0MdzP2/RZz6sFndOQaV+kxZGXrawZf6HCR6GFEugSwH3Hp2WqRFo3QemDG/HiTHWQ2yzhZavojEZToCatjXhPMB5ExgQmJSOfHs5vvsXQFvythZiqhsZCFsryIGMnoq+z67Uhq6YTmdedvqEZRap1uaiwUJNSzJan3YrBm9z9z15lToUi88Adi+jbxjpd/Hl7PZ7AAUBvjxqtmKDzYSIPXebPHyvOSEFCpwE8PxXMoKd+amEGhrZfHX13JaoGKB7JKpvCS9egkkc/l
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:50:57.0783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8ea22d-a8ee-4b21-1631-08deb0ff0a6c
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8424
X-Rspamd-Queue-Id: 7012D5364E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287631-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

QW0gMTMuMDUuMjYgdW0gMTU6Mzcgc2NocmllYiBWbGFkaW1pciBPbHRlYW46DQoNCj4gT24gV2Vk
LCBNYXkgMTMsIDIwMjYgYXQgMTE6Mzc6MTRBTSArMDAwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+
PiBJbiBvcmRlciB0byB0ZXN0IHRoaXMgcGF0Y2ggd2l0aCAyNUdicHMgbGluaywgYWRkaXRpb25h
bCBjaGFuZ2VzIG9uIG90aGVyIGRyaXZlcnMgYXJlIG5lZWRlZC4NCj4+IFRoaXMgaXMgbm90IGEg
c2hvcnQtY29taW5nIG9mIHRoaXMgcGF0Y2guDQo+Pg0KPj4gMS4gSSB0ZXN0ZWQgdGhpcyBwYXRj
aC1zZXQgYWxvbmUgb24gTFgyMTYyIENsZWFyZm9nIHdpdGggU0QxIFByb3RvY2wgMTggKGkuZS4g
MnggMTBHIFNGUCwgMnggMjVHIFNGUCk6DQo+Pg0KPj4gMTBHYnBzIHBvcnRzIGFyZSB3b3JraW5n
IGZpbmUhDQo+Pg0KPj4gMjVHYnBzIGZhaWwgdG8gcHJvYmUgKGJ1dCB0aGlzIGlzIHBhcnRseSBl
eHBlY3RlZCk6DQo+Pg0KPj4gW8KgIMKgIDguMzczMDQ4XSBmc2xfZHBhYTJfZXRoIGRwbmkuOSAo
dW5uYW1lZCBuZXRfZGV2aWNlKSAodW5pbml0aWFsaXplZCk6IE1BQyByZXR1cm5lZCBQQ1Mgd2hp
Y2ggZG9lcyBub3Qgc3VwcG9ydCAyNWdiYXNlLXINCj4+IFvCoCDCoCA4LjM3MzA2NV0gZnNsX2Rw
YWEyX2V0aCBkcG5pLjkgKHVubmFtZWQgbmV0X2RldmljZSkgKHVuaW5pdGlhbGl6ZWQpOiBNQUMg
cmV0dXJuZWQgUENTIHdoaWNoIGRvZXMgbm90IHN1cHBvcnQgMjVnYmFzZS1yDQo+PiBbwqAgwqAg
OC4zNzMwNzRdIGZzbF9kcGFhMl9ldGggZHBuaS45ICh1bm5hbWVkIG5ldF9kZXZpY2UpICh1bmlu
aXRpYWxpemVkKTogZmFpbGVkIHRvIHZhbGlkYXRlIGxpbmsgY29uZmlndXJhdGlvbiBmb3IgaW4t
YmFuZCBzdGF0dXMNCj4+IFvCoCDCoCA4LjM3MzA3OF0gZnNsX2RwYWEyX2V0aCBkcG5pLjkgKHVu
bmFtZWQgbmV0X2RldmljZSkgKHVuaW5pdGlhbGl6ZWQpOiBFcnJvciBjb25uZWN0aW5nIHRvIHRo
ZSBNQUMgZW5kcG9pbnQ6IC1FSU5WQUwNCj4+IFvCoCDCoCA4LjcyNTAwNF0gZnNsX2RwYWEyX2V0
aCBkcG5pLjk6IHByb2JlIHdpdGggZHJpdmVyIGZzbF9kcGFhMl9ldGggZmFpbGVkIHdpdGggZXJy
b3IgLTIyDQo+PiBbwqAgwqAgOC45MjA3NjZdIGZzbF9kcGFhMl9ldGggZHBuaS44ICh1bm5hbWVk
IG5ldF9kZXZpY2UpICh1bmluaXRpYWxpemVkKTogTUFDIHJldHVybmVkIFBDUyB3aGljaCBkb2Vz
IG5vdCBzdXBwb3J0IDI1Z2Jhc2Utcg0KPj4gW8KgIMKgIDguOTIwNzgzXSBmc2xfZHBhYTJfZXRo
IGRwbmkuOCAodW5uYW1lZCBuZXRfZGV2aWNlKSAodW5pbml0aWFsaXplZCk6IE1BQyByZXR1cm5l
ZCBQQ1Mgd2hpY2ggZG9lcyBub3Qgc3VwcG9ydCAyNWdiYXNlLXINCj4+IFvCoCDCoCA4LjkyMDc5
MV0gZnNsX2RwYWEyX2V0aCBkcG5pLjggKHVubmFtZWQgbmV0X2RldmljZSkgKHVuaW5pdGlhbGl6
ZWQpOiBmYWlsZWQgdG8gdmFsaWRhdGUgbGluayBjb25maWd1cmF0aW9uIGZvciBpbi1iYW5kIHN0
YXR1cw0KPj4gW8KgIMKgIDguOTIwNzk1XSBmc2xfZHBhYTJfZXRoIGRwbmkuOCAodW5uYW1lZCBu
ZXRfZGV2aWNlKSAodW5pbml0aWFsaXplZCk6IEVycm9yIGNvbm5lY3RpbmcgdG8gdGhlIE1BQyBl
bmRwb2ludDogLUVJTlZBTA0KPj4gW8KgIMKgIDkuMjkwMDA1XSBmc2xfZHBhYTJfZXRoIGRwbmku
ODogcHJvYmUgd2l0aCBkcml2ZXIgZnNsX2RwYWEyX2V0aCBmYWlsZWQgd2l0aCBlcnJvciAtMjIN
Cj4+DQo+PiBQZXJoYXBzIGRyaXZlciBjb3VsZCBzd2l0Y2ggdG8gMTBHIGluc3RlYWQ/IEhvd2V2
ZXIgbm90IGltcG9ydGFudCBpbiBteSBvcGluaW9uLg0KPj4NCj4+IDIuIFRlc3RlZCB3aXRoIGFk
ZGl0aW9uYWwgb3V0IG9mIHRyZWUgcGF0Y2hlczoNCj4+DQo+PiBuZXQ6IHBoeWxpbms6IGV4dGVu
ZCBwaHlsaW5rX21paV9jNDVfcGNzX2dldF9zdGF0ZSBhbHNvIGZvciBQSFlfSU5URVJGQUNFX01P
REVfMjVHQkFTRVINCj4+IG5ldDogcGNzOiBseW54OiBleHRlbmQgc3VwcG9ydCB0byBhbHNvIGhh
bmRsZSBQSFlfSU5URVJGQUNFX01PREVfMjVHQkFTRVINCj4+DQo+PiBUaGVuIGluc2VydCAxMEdi
cHMgU0ZQIG1vZHVsZSBhbmQgbGluay11cCArIFRYL1JYIHdvcmtpbmcgZmluZSENCj4+IEkuZS4g
ZHJpdmVyIHN3aXRjaGVkIHN1Y2Nlc3NmdWxseSBmcm9tIDI1R2JwcyBjb25maWd1cmF0aW9uIHRv
IDEwR2Jwcy4NCj4+DQo+PiBUaGVuIGluc2VydCAyNUdicHMgU0ZQIG1vZHVsZS4gRXJyb3JzIHN0
YXJ0IG9jY3VyaW5nOg0KPj4NCj4+IFvCoCAzNTcuMDQzODk0XSBmc2xfZHBhYTJfZXRoIGRwbmku
OSBldGgyOiBMaW5rIGlzIERvd24NCj4+IFvCoCAzNTcuOTQxMDM2XSBzZnAgc2ZwLWJ0OiBtb2R1
bGUgcmVtb3ZlZA0KPj4gW8KgIDM2NC4yNjk1ODBdIHNmcCBzZnAtYnQ6IG1vZHVsZSBGU8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgU0ZQLTI1R1NMLTg1wqAgwqAgwqByZXYgMUHCoCDCoHNuIEMyNTAx
MzMwMTI3wqAgwqAgwqAgZGMgMjUwMjAzwqDCoA0KPj4gW8KgIDM2NC4yNjk2MjVdIGZzbF9kcGFh
Ml9ldGggZHBuaS45IGV0aDI6IHN3aXRjaGVkIHRvIGluYmFuZC8yNWdiYXNlLXIgbGluayBtb2Rl
DQo+PiBbwqAgMzY0LjI3MTY3NF0gZnNsX2RwYWEyX2V0aCBkcG5pLjkgZXRoMjogcGh5X3NldF9t
b2RlX2V4dCgpID0gLTk1DQo+IC05NSBpcyAtRU9QTk9UU1VQUC4gSXMgaXQgY29taW5nIGZyb20g
bHlueF8yOGdfc2V0X21vZGUoKT8gSWYgaXQgaXMsDQo+IEkgc3VwcG9zZSBpdCBpcyBmcm9tIGx5
bnhfMjhnX3N1cHBvcnRzX2xhbmVfbW9kZSgpIHJldHVybmluZyBmYWxzZS4NCj4NCj4gQXNzdW1p
bmcgeW91ciBsaXN0IG9mIGFkZGl0aW9uYWwgcGF0Y2hlcyBpcyBleGhhdXN0aXZlLCBJIHRoaW5r
IHlvdQ0KPiBtaXNzZWQgZnJvbSBwYXRjaCA0LzU6DQo+DQo+ICBGb3Igb2xkIGRldmljZSB0cmVl
cyB3aXRoIGp1c3QgImZzbCxseW54LTI4ZyIsIHRoZSBvbmx5IHRoaW5ncyB0aGF0DQo+ICBjaGFu
Z2UgYXJlOg0KPiAgKC4uLikNCj4NCj4gIC0gdGhlIGZlYXR1cmUgc2V0IGlzIGZyb3plbiBpbiB0
aW1lIChlLmcuIG5vIDI1R2JFKS4gU2luY2Ugd2UgY2Fubm90DQo+ICAgIGd1YXJhbnRlZSB0aGF0
IHRoaXMgcHJvdG9jb2wgd2lsbCB3b3JrIG9uIGEgbGFuZSwganVzdCBlcnIgb24gdGhlIHNhZmUN
Cj4gICAgc2lkZSBhbmQgZG9uJ3Qgb2ZmZXIgaXQgKGFuZCByZXF1aXJlIGEgZGV2aWNlIHRyZWUg
dXBkYXRlIHRvIGdldCBpdCkuDQoNClllcyBJIG1pc3NlZCB0aGF0Lg0KDQpXaXRoIHVwZGF0ZWQg
Y29tcGF0aWJsZSBzdHJpbmcgaXQgaXMgd29ya2luZyBwZXJmZWN0bHkhDQoNCkknbGwgc2VuZCBt
eSB0ZXN0ZWQtYnkgb24gdGhlIHNlcmllcywgdGhhbmtzIQ0KDQo+DQo+IFlvdSBjYW4gbG9vayBh
dCBteSBicmFuY2gNCj4gaHR0cHM6Ly9naXRodWIuY29tL3ZsYWRpbWlyb2x0ZWFuL2xpbnV4L2Nv
bW1pdHMvbmV0LXBoeS11cHN0cmVhbWluZywNCj4gc3BlY2lmaWNhbGx5IGNvbW1pdCAiYXJtNjQ6
IGR0czogbHgyMTYwYTogdHJhbnNpdGlvbiB0byBkZXZpY2Utc3BlY2lmaWMNCj4gU2VyRGVzIGNv
bXBhdGlibGUgc3RyaW5ncyIuDQoNClRoYW5rcyENCg0KSSB3aWxsIHByb2JhYmx5IGhhdmUgcmV0
aW1lciBjb21tZW50cyBpLmUuIG9uZSBwaHkgb2JqZWN0IGVoYWNoIGZvciByeCwgYW5kIHR4LA0K
aW5zdGVhZCBvZiBjb21iaW5lZCAtIGFzIHdlIGNhbiBub3QgcmVseSBvbiBoYXJkd2FyZSBkZXNp
Z25lcnMgbWFraW5nIGNsZWFuIGNob2ljZXMuDQpFLmcuIGltYWdpbmUgdHdvIHJldGltZXIgY2hp
cHMsIG9uZSBoYW5kbGluZyByeCBkaXJlY3Rpb24gb2YgMiBwb3J0cyBhbmQgb25lIHR4IG9mIDIg
cG9ydHMuDQoNCnBoeXMgPSA8JnNlcmRlc18xIDAsICZyZXRpbWVyX3J4IDA+LCA8JnJldGltZXJf
dHggMD47DQoNCk5vdCByZWxldmFudCB0byB0aGlzIHBhdGNoLg0K


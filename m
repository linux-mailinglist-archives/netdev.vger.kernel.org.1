Return-Path: <netdev+bounces-276978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DPaBA2d12kUQQgAu9opvQ
	(envelope-from <netdev+bounces-276978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:35:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 720893CA7A9
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 512C93009B00
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 12:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7E93CD8CE;
	Thu,  9 Apr 2026 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="HF9UTTob";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="HF9UTTob"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023113.outbound.protection.outlook.com [52.101.72.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545FC3CCFC2;
	Thu,  9 Apr 2026 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.113
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738116; cv=fail; b=U5b89C/e6yNLtUujgUHELQmLkd/5s7ckSTN/wkyz2ol4ypVVrVxg2ylaDCCUHBxglmjkhY+LdhiEOJvcuS8YSW+nhNcGeM7lw15fLrVeC6X/QGK9hijcLZwKudQIQr6/FmSmQSeAx5BECHbTMduvfr/s/Kc4SHuAP50But5PrZQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738116; c=relaxed/simple;
	bh=rYPc5+RphONz8Ju0nS0fX4EZ2DKXPiScpy5mlT4twZY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cTkD0+HL6wY7FsJlBLHmaU4Z5lojI0Ihy8lkk/bCrk4G2QwoBqYoGEmJCqdPWGd8QamlyLpqjhrIMmNEbc33LHLlMl3nkBTO8F23ixZECcOPUsgF7HLpsZHptXXUUwUNZrZPFSKzgA53T5fTeTjB++PwR50eDb8VPX+G3RM6OC4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=HF9UTTob; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=HF9UTTob; arc=fail smtp.client-ip=52.101.72.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ya8PymNMoA+siThRZqrs9vtzcCv+Q7D7GDoK89s9R/HAl0DPTlmEfhGOESt8Ow9Oj4vMmGREa5JNHJwrjJzE3VY44yxlfV3f6/vzITlpH9JDegZQELVYAbDv5B41d/kiYkiqI511g9W7H/b7Dgr2bluQXpUmHOiZH0VoPmJF6vWHACUJV7TwWh3XBTy9Rhcb8UYJ0k09KJVv1Zp9yTnooi0aGR0xJYZxIjBChnwNu4VbBpAl75VFfyntYEIsJ0sVHArG0sifTKmi8HvzK558TeUmDQxLS2y8abBwXOeyIdEDT/6KJ3elQ6ZgheW8oHR7ogZy04RCaNz97dC2obIvBg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqo7Sc1LvSEmURLvUZRa9PHsC+1zGSYeKgkqivbKIuc=;
 b=OOzLGgUNitpuinRKmrohmIIh+wVKItdCnRLoLzNP4QPwG2ItLWjqb8fIBV1nG3LjmbJQjLNI0CEYDesYNrmwc54RRadHs15QUJLDKzGg9xpQHoRQ0UILlWLMFt6g+PB8UJYvZCzJzfHTTKZOuUaojYHAknDWAyrIj412iVml/lJP0nctrpM2w8Q31QaX3hjSNJAM5ukOxCZiVGEtb6V1UfJ4ZXU1ktarozWpWRCoL+2CtvDbE90u9LvB3E8I8jxTLZ0Mb5iDkpoTciucmPWqEmQBfL3qBb5ylkRGBPJqk5PXAcxnFimHIVcLyU+l0qJZPLigRlcSQUfL2Sx03TlY4g==
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
 bh=vqo7Sc1LvSEmURLvUZRa9PHsC+1zGSYeKgkqivbKIuc=;
 b=HF9UTTobmk6URJxWakIdA9HwjmIZizXsHYqI23171EJAWgGv3TjBvF0EoDB+YKp6yyQUCcp6xp0eQWB2flE/KitprbJIpD6oX8rb42ULfBQmeUBwQJ/kn5PoEZB0Dc4BZTlJApJp4XgjsljbZqk0p9r82Ovrx68NiSdmgesub/auQJ2cDvxFLaF1x6FudgqjRyz7uTkgt9SAtD0clq6rBv8uU2c6MmfVcGKkxK/rpjzuo1XeyazkSMtEJdvsOv9YCwAAAlpmEYmX1VEEYnf5kbm5wP7UOcbT/IVjXL8hpM7EMmDbYvZZL9CJaQ30m5TjDGO3aJ5ohLKy6B/EZ840Uw==
Received: from DU6P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::8) by
 DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.21; Thu, 9 Apr 2026 12:35:05 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::a8) by DU6P191CA0006.outlook.office365.com
 (2603:10a6:10:540::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Thu,
 9 Apr 2026 12:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Thu, 9 Apr 2026 12:35:04 +0000
Received: from emails-3869420-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-125.eu-west-1.compute.internal [10.20.6.125])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 1D93E80EA3;
	Thu,  9 Apr 2026 12:35:04 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Apr  9 12:34:56 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGeOeKGLIcx+5m4u6qzJhrkVqHZbrXHSMhq0TiCLBu6CgK2CNQNKcZQ8xC2j9woc7bJnyOlNM+CCFz2H5j3eCrMWjjLm3Nk/utrXQsBunQXLuUfwRirc7rZR1YyANNnmXPL3gqzMkLc6ufk5sKwIT8KxqWa0jPEUtV/qvBXFLD5Fnq8L01Dp6gf+RzbzqL96TjSRffuTTZn/BK6T0jyMmiS8j1oUSBHg75wijDPyj1NbJvFcyr9BM8a5No+RW7DdD7MbLT+VdMrkMdi0Zmz7x4Wr7O5eVoypJ5bMRg4zkx0kKnqGv8+CHY+Hbg1raf9xJ7C+lUP6C1yQdkkhjSd9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqo7Sc1LvSEmURLvUZRa9PHsC+1zGSYeKgkqivbKIuc=;
 b=pMB4RFGwNSJG3QYYvRyn5N/coSXr4+JpZDXEwZTHExekN2sye5N5z8tFod6uiKPSH97z6YfLhO0QUIZXX5j8nukoS89UJBgSjxZvmS2JQ4iCvHi2BWnHYhkLAR8HEBf1cUD+FdCH9/jqJEZqMPy7dLmtAr5W9VJX2PzB3djApZnIYgxoah9jWPna/YdF5vBB/8+kNBS7OeDxS5XbT7J6t90NEmpAFnNKLoBHkayVUKZm+2kFpcNk2etvUThRkqZJtGJlpdxLcx0/r+pYCEopILO+qgzUBh1PibcS3WcIqcwy3Mb0JmrFpbEPFCO/SoBKvEnkHtElBNEztW/vKs7QzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqo7Sc1LvSEmURLvUZRa9PHsC+1zGSYeKgkqivbKIuc=;
 b=HF9UTTobmk6URJxWakIdA9HwjmIZizXsHYqI23171EJAWgGv3TjBvF0EoDB+YKp6yyQUCcp6xp0eQWB2flE/KitprbJIpD6oX8rb42ULfBQmeUBwQJ/kn5PoEZB0Dc4BZTlJApJp4XgjsljbZqk0p9r82Ovrx68NiSdmgesub/auQJ2cDvxFLaF1x6FudgqjRyz7uTkgt9SAtD0clq6rBv8uU2c6MmfVcGKkxK/rpjzuo1XeyazkSMtEJdvsOv9YCwAAAlpmEYmX1VEEYnf5kbm5wP7UOcbT/IVjXL8hpM7EMmDbYvZZL9CJaQ30m5TjDGO3aJ5ohLKy6B/EZ840Uw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by GV4PR04MB11773.eurprd04.prod.outlook.com
 (2603:10a6:150:2d9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 12:34:52 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%6]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 12:34:52 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 09 Apr 2026 14:34:33 +0200
Subject: [PATCH v2 1/3] dt-bindings: net: dsa: nxp,sja1105: make spi-cpol
 optional for sja1110
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-imx8dxl-sr-som-v2-1-83ff20629ba0@solid-run.com>
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
	GVXPR04MB12057:EE_|GV4PR04MB11773:EE_|DU2PEPF00028D08:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1bde47-bc28-48ce-b67e-08de96346ce0
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|22082099003|921020|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 hgGeA6uFVSungCwHfKyPnV8gThOXkITWymdUnp6eNllTQWE9JjUQdaRi1k6DP582dbKUka0lhjcWMgezQK/0XVPxUsQhBwMl8lG1WZ57s/zmVXwRN7U886HwSHCwcdLQAitM5cjv5WNUERpLGP3GPQGdqTCi3+TdPTrR77aw8TIyni8pwCK5jGBBqc0YG+FF0f4+VQBaRbz46FOK/osbryzw46Ghn3kGHlwpJlD7TFREzf/0RkWiPd6LIthAGH2Y071y+w38k3IMhLy33c3QH+ntdN2oW92KbM+3Mwc7AuzJ+SrZIxgiQTzKIw60Z1HX9G4HDVga7NFQJXk8NzRf4zf8lUeYE55lU4beDiOYvnG/YxjyEvMtqPZLbcVatyh/GyVhCfll9MpGGAucI9ICpPyi7uPG6RjLyavNr80ZdU31x0X6PDxRdnJ7r7T7ETmlVYPCPLbuU2VyAMOCYcTrTy0aC0YtpF7ZC1eqxivbX6z5MUiKmk/bTRksA+0HYP4Nh9z7DSfBkim7FVBveHAi0NTXHEBSj31xB7BGd0Yg+TiXlSFuFIh6QpnXfiKw+jvOwoM7xggCvB42u1TleLsXEId5sz0mihnwNAZSSkaBY2HIRNKdMQm/cA5uqTYXqE8rAyfzPO2/5nOWUl+3BmMtjtc2ICr55WGGenl9kt0CMEzLEAMgmck9XB/49BaQYDgW4j7tnJMXJ8LYZZoecPkKzg15TvZpwHMkw8c2BaKqqAhXjFfmCYTuE+kx6GOEz3yxyAotg6GleZvRSxP8rLAZLYxx6WBdLRtLCTOhtTaI4B7ICbnULsIMJapkJK+IHtae
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(22082099003)(921020)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 LupJ78p0utx0Blg3djEermVC7+3Gk4zbIizGj/uFcL8yfZiAAOtR5wzrJDCf6bkZJV+hJ/x3fAMjdgyeR8H446EeeG0QdMKE9Qn6HUoJwn9p9Ohig8GmERutOt0IwNzPgLvK+HIpMPIbW+gDdiuHslb36TafFuX4RGNVE7+nkvv0J1mfwT7xjFYVUaX5uuePD22wjtWV+UHfMM+3ZsUJGY4BtqhygHccMgI8o8nHQS1p/t52DzafABx8cDcmkwsR0TFZWOLDwNXpaJ7nxmbS/XwJ892yLEgsMv71Fg57Ga/Or7T4RRZIsYX907RkuSAC6tQtrI5epGSpv3VyJskcqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11773
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: a277676082cf47c2b9d5dca367d908e1:solidrun,office365_emails,sent,inline:1f4bc7b051329ca38413c84d0c3cf464
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1015c349-9f7d-4d3a-7af4-08de963465a1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|7416014|376014|82310400026|36860700016|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Re75OHaqh2Pvr0KCKZhzeWAoh196lyKtXO5phbWLWVNCnvrWnpqUADmExAZErvaIS1kVVwIXvYauTfIP6jCgn3l9YfL35hcw3carbJ0neKIdLvYmdz7sBkflDkNV7Sj/LsujgfXfwp1K9cdLxjoP12SMWIyU5ESW8VU0VpKjq5XLs8tepXgw1rymgqlcKGdzaW6bwncGL6as+xJ9UrWl/ZwvD0wRH9SHcHucQPAMnswrLeI9Rqtm7KeEmc9SzUPzj45jNZNd8SIyReVxjTW5BulQPOlqEiTTpiq/Qpk8+ny+dkjWE8MbYPeu67DwotQmTlUVBmiRsPgxjtQPsLRmUcp9MkVWnO0Ewn9Zb629MPYTM5Ri9kMn1652Ws5pvjXPlOWiYVQ8NDAQQHeW85n3pJnlTaQ4XnU+Rjj6mvq5A8NcUDEtWKMq9LRUupB4hqNqUpThk/ItgV5z+toyCZxHL/+OaQVVTMn+ks8oq9DcXf6zZhTwVbecwMkrBFDi9mVNZMso7aFOk7IRvE5cwwC9zzlOYoCeIXuYwy1rdBYPaXD0Vs0IcxXQvd07ggHCsMtVU6tLlEQr9CUz0WnNdeG/M8oiu6+ATVI1o+nLGXg3rUnPz9niCmFTjq8Mqvryh8lWgIRk1IAKs7xchL5rY77xi2d+aUFeKT5Svr4Ssu1Us69oFfBBRv695lsw678iZzPVT5t/wpDuK8zXGp2diiBSJHfwEuH+gWjEi62a1Ma+STfnhCQk7UljbrhQSupuDl/3vOww4TOfhVl99FkJmMw1w6jiuh/C4OkVL1QagBFN+pGQ4OTGViakeCiBMIgd54q0
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(7416014)(376014)(82310400026)(36860700016)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8hc0TnwdVpfQtvH2axonQeSJZM4v0h0VscaQUI6rkOnc6dVAqT93byeSvD4Aes6DbQKLyTs63naEPcN0Z07YH1S8oM4pVs5RYNi/SgLFUyKo9NV6zChlEEyLsGvJWcbFTL6zfUmDf1zf13AeCQHv43izSrhuTc8/egstxnKxSMv2W6+UXykCYo7RmWzlpC2Qbkii4nBz4BtVIbENFlAMpkgzVBdx2uUDhHbghEv0z3DboGYNxCKvkeOtVywLUPPzWGM4ZZAy/MDow43CVa2VpL4t0K5ElaI11EWxHBdAYZqS3aK1TKqw3DG3pFfaAgIXr3eus4xW+79bejZZM3fM3HdasU3s5+A4UyiKHeo/Lh8F004uAfhvkAj04K8EbIKUVcDoQF18W2XWbVY18TJML/A9MLZf7GQ8pktMuidRfQ5InxF3Gj5SDIdStJfZ2C1f
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:35:04.1867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1bde47-bc28-48ce-b67e-08de96346ce0
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276978-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solid-run.com:dkim,solid-run.com:email,solid-run.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 720893CA7A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the binding requires 'spi-cpha' for SJA1105 and 'spi-cpol'
for SJA1110.

However, the SJA1110 supports both SPI modes 0 and 2. Mode 2
(cpha=0, cpol=1) is used by the NXP LX2160 Bluebox 3.

On the SolidRun i.MX8DXL HummingBoard Telematics, mode 0 is stable,
while forcing mode 2 introduces CRC errors especially during bursts.

Drop the requirement on spi-cpol for SJA1110.

Fixes: af2eab1a8243 ("dt-bindings: net: nxp,sja1105: document spi-cpol/cpha")
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index 607b7fe8d28ee..0486489114cd8 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -143,8 +143,6 @@ allOf:
     else:
       properties:
         spi-cpha: false
-      required:
-        - spi-cpol
 
 unevaluatedProperties: false
 

-- 
2.51.0



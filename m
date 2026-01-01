Return-Path: <netdev+bounces-246492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC6CCED259
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 17:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD447300C5F4
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE872E2EF2;
	Thu,  1 Jan 2026 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="H2+n7DhI";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="H2+n7DhI"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023110.outbound.protection.outlook.com [52.101.72.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB6245014;
	Thu,  1 Jan 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.110
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767283564; cv=fail; b=uxxwdBdLz/F3hQMO/mr4b+53zjZKp+Stz2RAZ50lSruGJur8Zd0S5KUSGfBU5t55WNMbAfAiYlPTZ/oyQGHC2iNaaYFYX+y9tF9QYPe6HmYZUyz0nJ/Z/ahVVHPhD0K4APSRMCnk2HZxma37jz+m6dUGbp2WIRkFB7DN5NCWoak=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767283564; c=relaxed/simple;
	bh=MXJb2Y1bIMty23DyH3LJMMkaoWrz4n1AYAZTJR5v2/Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Vgb3D1C/m0kDO3X+CJicbSznISFIKM3K55ONGMUQ+tWUwnFVnWEpmfLLUNcWpEdzhFzQQtXix6AHCzyS1+QwXRZ4+iSn84uWfBDmbZYs3Zfd3gEcnMazEEQevySrJLUoOL0INR7Oj0xwEqZRFqsLBNmNd6wgru4cftgCmkbHtVk=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=H2+n7DhI; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=H2+n7DhI; arc=fail smtp.client-ip=52.101.72.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OU84Pp0bbOLgLzpsN+z/0uPdcELMR9iDHTF35azvV7i3shetjKI/P97RQ4FXidCPrTf+gveUkMyWASWxIzd7UzIoslAOoH/5lI/Pl94Mc9XByGGdSxRSUPRibs51bBbWU43prvM8OIblg52UA08JITAjZYd7w1EhNQJJHS1fdRQhFSXg631HzRyW/ZztfPniLc4AgRgPZd/2/StMtS3hZMAAHwr+Vs+rFO8uuSXd/2Doy2ZM+syTkXywUPVIcpjJLfEc5EmegU4UWUAMuYNoHNb+YmLyeGtHtjwdLg7+vFYqy9oJu13/ejFJSB7KGt8ARnizKp3irNjYBHiC8hs9CQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUucukM3fk3GQPAIp3nwELtxyKHnr1UQwxx7Sy1j7Ws=;
 b=DSjFa+QuQCWyPUKeFcvoho9jDd4PT/c3ngzWVKG0TIJHfIVmSF6pmeQ9WARP1z+KI+9v4SA80WVLGHUrsiki4kOIBWAENpBUDqzLrB3LV/ih4ySn6jJyOHXKORC9Jb6c95C/YgTnuY/9jnBB+kMPFBhqlSb7VTVXDK45EUni4sLSY5jN71r0xz5tBTd6ph4MdesvO+rhTlSLx/Tq+GsIDtf1N8HPaD9OaeXseua3E6u9T7W5YFYCQKV9zCTPu7zbYrvHNddcSWGlCw2weeJ+SAdiBRBnZ8bOLWCGc8AKn2SoJzehqS2ssbmxogXr+HES+4aEQ+zOUQHxPr/Lhos+MA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUucukM3fk3GQPAIp3nwELtxyKHnr1UQwxx7Sy1j7Ws=;
 b=H2+n7DhIFVjwLRrcbyj1VlvIjY38dy5vIqOfRvIKZ8FTUVKXEHpn3u49hWUtvbc3uDik+mzvBAthR0dT0aNIFU5sz2SKV3BPlapno38vaL57K8LonefKmB4yIWftL9q7jWoVKYq3hKspf6jEdeuSqJqZfS3B7B3zq9/GHwbA0vg=
Received: from DUZPR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::12) by AS5PR04MB9800.eurprd04.prod.outlook.com
 (2603:10a6:20b:677::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:05:59 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::5b) by DUZPR01CA0038.outlook.office365.com
 (2603:10a6:10:468::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Thu, 1
 Jan 2026 16:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4
 via Frontend Transport; Thu, 1 Jan 2026 16:05:58 +0000
Received: from emails-39759-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-24.eu-west-1.compute.internal [10.20.5.24])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 99AE8809E9;
	Thu,  1 Jan 2026 16:05:58 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1767283558; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=jUucukM3fk3GQPAIp3nwELtxyKHnr1UQwxx7Sy1j7Ws=;
 b=M4HBdnRFBBkHuUHMkzU3kBIJhWJ5nOCfR+en8nlrWAok8JNGFFoMzRqnpbB97BCB+hqrR
 nKT/tLgH7qFJef60qS2Nfek/0/mDRpIYZ7JIEWWOCDgo2V0RkF8sW+JXEKmjuHYQJ9fI1MV
 15MvtqGlWHLvlEKFwWnw13BdMSuz56E=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1767283558;
 b=qlIDjagWnK2CQUtRP1gDXc6p2sMM9Vneb2YLApRuESgr2KVWatSQI6BOdV2TFikK1BO/0
 UnQpOrcWNLuLn0e1mWK9sakOPAHbkdoxbqi2iT7a8ps8F2IjD2TpcNoDyR/YDNG+1a7rBy+
 xLaO4UvQV2GFGhSLG5LXKncAn4SNS8w=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KATlgisNKzA7/v+KZcNKV32++W1IDmwd2ZJJthHLQZ+SdXbHo+BZl98aGkDkNfDFZzaY5ucOv3V6cqbxA6QIAHbXbiymYFwzxH/iEHGR+EG2m1Pdl2eOPftsTDguMMdmmJ07NXrB66kNokD4U7oZPnUn9Cyk6b9Dl7RrRSObtxF2wtfZ5IKa9qOzQweKMdP9h2Frmk3VmrYSp4ST3g2UZEDfnH6kdsOYp/kzUsH0cKogFJWtUbUsbF/PJth6S51jNFtrsP+bA5SG9h0XDr45j7P/TSHh4cE90hAo+/cw+mYdnFUUq2HWj/SEMkiTrQRTpHpHMYohMF9MpFlE+3Vibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUucukM3fk3GQPAIp3nwELtxyKHnr1UQwxx7Sy1j7Ws=;
 b=yDUstrQzzny1AHj4ioUkB7gTMFkm1djET9xoABoR4MaVzDaitp7kvljci1lRP0vqI65No+GEEV62BQM0LXey3WqPbiCVHsAouJycvR2lRjAY0WH2Ir0aN8J635lOUpj+XlSO7UPPX+ysDQz5m5ZBIHSLEiJMkFnDLpxtUplfu02BV6LTX9DZeyOCcJg7NBHs/pjgoyzF2DxJ58BQ+Fa0TCFp72dN6GIqNzH1qJkdFv3pnZyWNBA2n464IDUuFJepsqAoXKE+2LxoP/bUlhYWQC219DEY2AsiyDTWcCaHirQ9bDqEIw8JmfE/YVLoIPl7//B0Psm3czVrMJ/N1LQPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUucukM3fk3GQPAIp3nwELtxyKHnr1UQwxx7Sy1j7Ws=;
 b=H2+n7DhIFVjwLRrcbyj1VlvIjY38dy5vIqOfRvIKZ8FTUVKXEHpn3u49hWUtvbc3uDik+mzvBAthR0dT0aNIFU5sz2SKV3BPlapno38vaL57K8LonefKmB4yIWftL9q7jWoVKYq3hKspf6jEdeuSqJqZfS3B7B3zq9/GHwbA0vg=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:05:48 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9456.013; Thu, 1 Jan 2026
 16:05:48 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 01 Jan 2026 18:05:39 +0200
Subject: [PATCH RFC net-next v2 2/2] net: sfp: support 25G long-range
 modules (extended compliance code 0x3)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-cisco-1g-sfp-phy-features-v2-2-47781d9e7747@solid-run.com>
References: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
In-Reply-To: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PAXPR04MB8286:EE_|DU2PEPF00028D01:EE_|AS5PR04MB9800:EE_
X-MS-Office365-Filtering-Correlation-Id: 13319ec1-85a5-402c-50e8-08de494fa718
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZjVES1hKV2MwRDFMWjl4TWQ3SEhUQys5aFF1Nngzc1dJYnpDaWJNRjhSV291?=
 =?utf-8?B?eksyc0dhTHpLSC96cnZHWVJlQ1JWV3dhOTFMUkNLK01NMVY0VHVPMTBWSE91?=
 =?utf-8?B?UjE0Y0crcUMwSVllM0trQnl4MFM2M2g4OWltVW5LREw0dHBMY3c4eGZSaW1Y?=
 =?utf-8?B?Qlh3Zlplb3hTajJHQWJMYW9id0dtcmtIcUgvVS90am9yTVpKczFTK3ZsRjRM?=
 =?utf-8?B?OEUvQ2o5ckk5U09Yd0UrVG92YWFrRENFdzhmQTRUcXFSTzY3c1RYZjdzbDZT?=
 =?utf-8?B?UG40Z2VnZW4vZFl6akNsK094RXk1YjY2TWdnMHJCZUR2enVFRkpWd1RuQllq?=
 =?utf-8?B?K0tZOGRPaUlZaFIwT3liR2dlR1NSd2ZBa0VYcDlCT1VJVGNzaS9CM3VuQzY1?=
 =?utf-8?B?TEpKUEdkUURzc3cyNno4Nm9nbnhmUUFxYnR2ZHdMK1d3bld4RmdhZGhGTGhV?=
 =?utf-8?B?UTFtK25TVC96UnJEVkRrcC9aY25pU2hQem4zb0E3USt1alF2MUtPS1hRemc2?=
 =?utf-8?B?WTRzR3pvUjN5ci9rdGZlSHU5dlB6WnBQenBQZWd6UmpDWFc4QmZ6UWY3UmJ2?=
 =?utf-8?B?K25VeU9ucmNVRzI4TUtROThoSHhTZzhUT0xpQ3ptNk9kaWpUeEEzREFRbmt0?=
 =?utf-8?B?dEFKL0xnamNnZlNDVStrVVE3ZkJseStiWXQ2VU5UMjNYSGw0QkdRTytMZVFw?=
 =?utf-8?B?V01DOHFlY1JPK2NzWmFFRlhjeVdhWE5OQklqbVpWZ0ttckIxSi9GSVpHMVlP?=
 =?utf-8?B?bG45Z0dybDk5N0V2MzJQQzhUTkVEb05JcG91RkV5aG1yK0xFMmhVaG5rRW9C?=
 =?utf-8?B?OUxkWUpBaHpZSUp1a0JuRWUrZmFGS3BabExtMDFMUkdZZXJieVpibXg1emJn?=
 =?utf-8?B?Snp4dDM0NlBYeUhkdnJhNThVSWZaa1g2TTFrSXdUd3dObnU2SmpXWUpWbXBP?=
 =?utf-8?B?R3hXQjZ1ZmcrWTdJaTM1M1FuSGtoSXA2a2NuL255K05KcmRlUHVXUkRzOWlk?=
 =?utf-8?B?ZHowTUY4MERHNlJVK3hVUWlSTGxsVERWWUtxMWFrRGtpOUN6c3RGa0JBSUR4?=
 =?utf-8?B?NDl6OTUxdFROUnN5YWJZdmNCb0RuWGpORkhudkFXZFVTNW1leENwYmM4MW9j?=
 =?utf-8?B?Y3kwQ2lhRFY4MjVLV1YyVEkvWk56cktDNlNZVGdXRjM1YjlFSCtOUGZHYUNz?=
 =?utf-8?B?RzJmWVl2UVgwcWJmWU9jYUJaRXNjUkUzY3VRS3ZiVUJiMmtQTDQ0WDduRHBL?=
 =?utf-8?B?S1VoU3p6YVZFWE5Wenc4d2JHMkpvSkI5cUl4aFE2VnlpcGYyTWUydHIzYTE1?=
 =?utf-8?B?U3lwcUxkT2RaSC9tVDEzOHlUWklrQmlQd2FlTXBIaDczcFRNRWtRckpMd2xV?=
 =?utf-8?B?bWtta2xMTVFKK1lKSExmdS9Wb20xdXh2eWR3Rnd5Q3pHcUUvZWNaMFZKOEd5?=
 =?utf-8?B?U3pYaXlRT1lOcjdVZ3J3Rk5ab25OdE84Nk9tN3dEUkVGKzlTaEF1c1dvWDMv?=
 =?utf-8?B?LytNUFg4REQyVXhKODk0MENQa0N0VDdSSmNMQ0xRQlVwbHErNTNWMzJQZ1BS?=
 =?utf-8?B?S01KQVBVU3g1blg1Um53RzU4Y09uMkhCMHpmVVZDQzN6V21SUzgzOVIxK0lw?=
 =?utf-8?B?LzZ2V2lTZVloVmVNQ3A2MXI3bnFpOG5na0pQQUJYZFV0TTltQkhoN1Qyd3dL?=
 =?utf-8?B?dVdWL09HZ0V3dWhkMitsblY5bXpNc1pBMndUbFRzcEp6aG16YThIdE9xbTQw?=
 =?utf-8?B?M2tyenpTVmxMT2NTQm53VUkwSjJCbnJPeDB2UXVVVGpRVDlnS1RSWXpHaHNm?=
 =?utf-8?B?b1ZZMFMzY3hEZWlOdDBHUVFwRTBybGhuTkdoNytTMzArTlB4YTQ1UXcranBk?=
 =?utf-8?B?SFNwV2pYVFduRzZFRGdzM1V4RWc1YVFBQmJRNlhvMDFNbXl4MnBtdXB0TFR2?=
 =?utf-8?B?MCtzL2VhTmk3UkdHaFAvbnFubko2YmNwMmt3N1R2NU5DVCtDaldkb1BhNzkx?=
 =?utf-8?B?YnJSd2JiMnRlWk9JUXI0SWR4cVhXSTZLY3FxRTRWRkNFeFdkeFYrSjZoZXht?=
 =?utf-8?Q?Q/+MA+?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 9cd4cc6a43e9458eafe0a10a95a94765:solidrun,office365_emails,sent,inline:1e8613b28efbd653c3d4699ad377df03
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ec0eeb9e-ade1-490d-d2d8-08de494fa0e9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|82310400026|376014|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dThWbndRSlhpdXpkb1Irbm91S1lUam1YTThLWGMxQmNXYmpQbkFwQ1daMXFJ?=
 =?utf-8?B?STFxS2VlekZkbUk1SVA2aHZkcTMyc2VxUFVoYjNmOTluMVlEbEJuY0M1MFZx?=
 =?utf-8?B?RzZDM2RKemdnY3oydFBpVjNSbWxteXZEQXRydVQrM3ltM0trUGlqWEFIczIv?=
 =?utf-8?B?RXMrZThOTmJoMjVrdkNTTk1BbzJVbHRqZDdob2NvUy9sUGVWZWw1OGp3NkZW?=
 =?utf-8?B?NUNGS3hLOEh3MjViSjhNcW0yN3dQdlhqQ2EzRk1QSXZEMmdxdUJENkQwck90?=
 =?utf-8?B?TncrUVZKNGNBc3l5cWgzemUyUmxETXJwalpFSmRBczhUU1V5ZkJycFRvMjVT?=
 =?utf-8?B?T0tLZWxnOEl4Ymx3enFJSjcyUmFvOVFRelUyb3UyTDRQUEFiTUJvVkQvbXhv?=
 =?utf-8?B?cUVFUG5wLytpakU3MW5Db1hNRkl5TGRDV1FDWTZRZG5hazB1Ykl1SFk2b25l?=
 =?utf-8?B?eUVvWlA5QnkrMStHNERyckZCVkMwemVCcHFWVlFwclFuczFnUWZYdmUwblNF?=
 =?utf-8?B?Rmh5S1phZ3h0a3htRzA2dWZZRERDcE5HSnBxdEFodmlNa3Z4cUhjejRTblFj?=
 =?utf-8?B?Ui9pMHBpZzFLTGF6azhlZU5xSG5yRE1ZVWo5c1VVVU1PaHlnM3c2d2VPN2N2?=
 =?utf-8?B?dldQV0JpWmJVWkUrOU8vUm15TWZWa2phT0ozQjZ0QkVibHU2dytzT0txd28y?=
 =?utf-8?B?Z2U5aEZqYzNUeWkrbS8xbTJZaWtEM2ZIWi9TVHNpM05ad0NMNVFET2VsNFJl?=
 =?utf-8?B?N2lvalJSaVJzRkRsbFZCdG5TREptUzVUL2dSWE9PK201S050RDh4MUxtQ3E0?=
 =?utf-8?B?Qy93NEx1WXV4V3RISnZlWmZ1NEtsdVdrYmF2R2xkRk16YjJOcXlRSjg0aVR1?=
 =?utf-8?B?VGJJU3B3cXdBSlcvWWc5MU5CWndmczcwUE53ZEVrb3hXbFhwR2N0S1l1OHU0?=
 =?utf-8?B?cTdPVlFMKzVqZTlzckZ3cjNhVjhQQ01GNkhwYXNRZ1JCQ3lqQUY5S3JMR3NB?=
 =?utf-8?B?NEtvRGtOalBmUlpYRkJlcDlzWUtVeGRPSFp4QnVpMlRJRlVsY0wycmtMK2lj?=
 =?utf-8?B?UWlvU242VlpXbTBOWER6MU5nVzhlYVRzZjhGb2IzcEZjMTl1cGo4cHlyNVZw?=
 =?utf-8?B?bFhuTFUrdFJPYnFtMWpQUjdoZk10L3YzOWtucXR5a3RmWVpUdTVOUEN3VjlS?=
 =?utf-8?B?TXZoc3RhSWt4anlyR1hqVXI0eGprd2FCa1lUcUZidzdvMEQ1aEJnZDZKaXl6?=
 =?utf-8?B?SStJZ1FFc1dvMjJQKzhGeVUvczhlWG0zT2VKb1Y3Qk1NSG41L3BkblpPeHM0?=
 =?utf-8?B?RXVoMWxocTgzQ0kyd3JHZDdwbW1HOUwrenhUWS9nT1RDaHFtQUdROFMwM0JF?=
 =?utf-8?B?cmRacjd1OHJvbDIwV1gxMHBQRzFuem1EaDVvdXVUODAvVGhGeTI3ZVpueFg5?=
 =?utf-8?B?TGtsb2l3OEM2ODFKZ0NkMzBSR053VkplZ0xOTE5RT2Zqd1VEZkFvbHRkUm5E?=
 =?utf-8?B?eVQvNzlFdGxRcWpYMHo5Nkp3cUNURVcvdnRuUDNJSmVmbmRBTHlpc0ROVVZy?=
 =?utf-8?B?bU5WeGRnVmZtd3JuWGpFYzZrVGVQMmxWQUdpQSs4T1c2NUFJUUhkd29LY0V0?=
 =?utf-8?B?UXA4dHlPdEh5MmtwRzRyYjRSZmJOUlJ4cnVsU1dsampGK0FocmRKM2J3MStS?=
 =?utf-8?B?QkNmZG91dkVjbE9BSTM3SjFiaFdlZHZIdjJrVU51dklWTnJkWGtvdmNBRjJX?=
 =?utf-8?B?NUNrY0pEb0xmWTJ4dWdvdllta3RnbjJDS2FTd0hPWXlMdy9oa0trUTZYc3N5?=
 =?utf-8?B?c25reWo4M1ptc09yMDRkTGliS2ZoVllUOTludXFNWWppaHZpYUxwanR5Ylhv?=
 =?utf-8?B?S0w5WmcwV3luWlZHUzR4QmFGUVY5T0JYK005QTd1aWo3R2NVbk1xbVhxK0kw?=
 =?utf-8?B?OXo5cWFDa2NpOStKUngxcHYyajZ2QmRwY2JLRTNsTHZPa3JGbGw5cXRTTmNh?=
 =?utf-8?B?YXhrMENRb0w3ck53dFBVbSt1NkhQMnRVNUxZeVlDZ0lNZHlCdFFGUjF5RXlV?=
 =?utf-8?B?TEY4Nm5DL0hSbGx5LzRLMGRHbWpqSlIyZjRwTE4wcGtibUE2K2ZSRVRSQlZa?=
 =?utf-8?Q?lK2g=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(82310400026)(376014)(36860700013)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:05:58.7391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13319ec1-85a5-402c-50e8-08de494fa718
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9800

The extended compliance code value SFF8024_ECC_100GBASE_ER4_25GBASE_ER
(0x3) means either 4-lane 100G or single lane 25G.

Set 25000baseSR_Full mode supported in addition to the already set
100000baseLR4_ER4_Full.

This is slightly wrong considering 25000baseSR_Full is short-range but
the compliance code means long range.

Unfortunately ethtool.h does not (currently) provide a bit for 25G
long-range modules.
Should it be added?
Are there any reasons to not have long-range variants?

This fixes detection of 25G capability for two SFP fiber modules:

- GigaLight GSS-SPO250-LRT
- FS SFP-25G23-BX20-I

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/net/phy/sfp-bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index b945d75966d5..5bb3fa6e9b4f 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -247,6 +247,8 @@ static void sfp_module_parse_support(struct sfp_bus *bus,
 	case SFF8024_ECC_100GBASE_LR4_25GBASE_LR:
 	case SFF8024_ECC_100GBASE_ER4_25GBASE_ER:
 		phylink_set(modes, 100000baseLR4_ER4_Full);
+		/* should be 25000baseLR_Full (not defined in ethtool.h) */
+		phylink_set(modes, 25000baseSR_Full);
 		break;
 	case SFF8024_ECC_100GBASE_CR4:
 		phylink_set(modes, 100000baseCR4_Full);

-- 
2.43.0




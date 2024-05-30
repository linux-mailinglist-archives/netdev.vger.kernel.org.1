Return-Path: <netdev+bounces-99369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3258D4A9F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A277281F9C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1855A174ED7;
	Thu, 30 May 2024 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="vqmtXC85"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66D33991;
	Thu, 30 May 2024 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068225; cv=fail; b=OtDQbB8pkUGYt9VPF7LjW+nBBK1RfRkKXbUXfEyFfkCtIjEKhtrx2OO1QE7H0qC2fcWzqFpKD2kM7oL/nEIFtFCpfe9zao2NoVkIZ2Nb2ZzzPHGmCcrV/JjFAM2vAAe3Hsw97wcApCt0KWP552FwYMQAtfLEAKVEXyV1C32TZU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068225; c=relaxed/simple;
	bh=Ymv9/8JyVD7O2EWI2auHB5knlII+kDsx1gmuShilFE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k1cUhxuHtu8Rkwi3Pp5KxiLPE3GJW0ybs8n0EXItsCqQL3Q89GIexhVXWUi76AMt3TQd7QQpwY1JJzZXiFeT6k0FhLs/VZ9ZnBURDstWn0bx7nMPOS2In20444tqQdywAy01FdD94lAQrC2FKicM49IGy7x6H2tpT9khvEKZUK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=vqmtXC85; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U9a1RJ025821;
	Thu, 30 May 2024 04:23:12 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yegkn1gn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 04:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmrS6gAax2vcT6c71sBUB9izUPhfXBymGnzGkZQ8zOa+zizdjfg8Yz6aEI4JRmTeFbbgox5byrO0IZPsElBDLpuVHlKCTbp4HNn4v4KyTF3N3qWT8CO7nEEtbLCNUeWxfl41Zvq3/FQp6rmXx+Sd5PWWt0stlw4IRK7J5jCJckSM1nPHkqLPusTL1FZNmMbPMf5d7tEUyShOhuSpEFImrzJtjHj8M/v7ZH4io4NvFCKL7qxLGiFXHKf5MSXWd6atEkNZd0jDaPH2tzp1r1H6F2Xo1/64XyF0xXTnAKkRdFOW5nhg8E/BgkelCYzTy38vJ/LUgu5Cp+5UWNkjU5sNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymv9/8JyVD7O2EWI2auHB5knlII+kDsx1gmuShilFE8=;
 b=asF5YRNTPhw2cR/Ho27l1UU/74MbnmjJMFc7ZfJl/g7z5vOCokajC3DjXprl/WJUdeICvqv4bxTqly1ubylafRlAcnqqI3KUwuX0DRLT8QVx42BA5L700tvtI+wjOOpYsTU1hFrPzlGDaLrgIt4/yaRzauv+Ou1It4+RfVkDH9z97uTZnjfkW24PzFIftWRVP+vteqEvDXAlSl0mMYMCKjyq6EGh+2jNEhFoJ6T0sPIHK86jM9Xyhd6gQc2PSODpHswmQL480vxxBQ1DTy/RL704zY9xGQjhaqCc0ASFxmdIhOlguPUycORuv1IDgn/NMMbc0jQlGgM4dA7VZ2Pdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymv9/8JyVD7O2EWI2auHB5knlII+kDsx1gmuShilFE8=;
 b=vqmtXC85fiKKM9As6o8sTRUp/iAoujEqUOcC5GFckNJIrezY3dE+yEyfiFoElb8P2Qn+fFBNPioBLOzCBJew1q7k+zPrFv/QJ878oqEvru+YBzJMhjRDhZ76vWzY5D4IR4TrsqQh4kWyGmxm/nOJ1VVxonZZH4EnorgQBOWUnOo=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by MN6PR18MB5466.namprd18.prod.outlook.com (2603:10b6:208:470::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 11:23:10 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%4]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 11:23:10 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Kory Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay
 Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea
	<claudiu.beznea@tuxon.dev>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu
 Vultur <horatiu.vultur@microchip.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        Simon Horman <horms@kernel.org>,
        Vladimir
 Oltean <vladimir.oltean@nxp.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        Maxime Chevallier
	<maxime.chevallier@bootlin.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: RE:  [PATCH net-next v13 12/14] net: ptp: Move ptp_clock_index() to
 builtin symbol
Thread-Topic: [PATCH net-next v13 12/14] net: ptp: Move ptp_clock_index() to
 builtin symbol
Thread-Index: AQHasoPA+avjuvo0LUSGs8B6bWvcAg==
Date: Thu, 30 May 2024 11:23:10 +0000
Message-ID: 
 <BY3PR18MB47074528CBB38F55A3F58A19A0F32@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240529-feature_ptp_netnext-v13-0-6eda4d40fa4f@bootlin.com>
 <20240529-feature_ptp_netnext-v13-12-6eda4d40fa4f@bootlin.com>
In-Reply-To: <20240529-feature_ptp_netnext-v13-12-6eda4d40fa4f@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|MN6PR18MB5466:EE_
x-ms-office365-filtering-correlation-id: d3a69422-9109-45bf-89d5-08dc809ae2f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009|921011;
x-microsoft-antispam-message-info: 
 =?utf-8?B?M2p0M2dSWUdvbi9Ucmg3cjdwS1h1YU4xN3FsMmovcVZRQzNvTVV3ajZQeGEz?=
 =?utf-8?B?Mjd3THJiMVVmbkN3OEdKenR6dUxnUTZ5RHVKMHg2QkpNVDhKbTNOL1ZjLytU?=
 =?utf-8?B?d2dWMmtMUFZRdzFxMG9hMjI4S0ozS1BpaWJFbXM4amtnQ1NqWjJQS1ZZOHlq?=
 =?utf-8?B?SktKOEg4ckZaRHNneUpMc1B4Yk5lTmRGMHdPYmZ1Y21WemlqV3g4Z09Ncnhi?=
 =?utf-8?B?QTdEeU93TVRJWGNQSE9adTZEWktCZXgzZUc4czVqZVkvU05nd1N1U2xuZi9N?=
 =?utf-8?B?enlIR29QRzVHenJLZmtmVFJRN1h5Tk9qSEtScS9mdjI5Z0xxck9OVVA4S0gv?=
 =?utf-8?B?S29HWWprcUc5dzR3aHdQemxLeExLS0d1S1krL01ieXZ5Z0VqWkJRTlZ0d0xm?=
 =?utf-8?B?OFdkQ0MrQWF6UG9kbVNhZ3NsRTk5Vjc1WVh3T1A2ZWRUamxTdEE5RXd4aS9C?=
 =?utf-8?B?Q1RUT2xYKytJKzgzOVZmUVh5ejZrVENHKzQxMC9wKzh1TS9NK2VuZk05blRF?=
 =?utf-8?B?TG12anZXQzRKendOZUdYZ1gwY2xKbGtPN0ZaZTBldTBnVVZUdXh6eHBWV25u?=
 =?utf-8?B?YThzVGNWaCtZZWpIcVJrR0VQT1ZrMVB3czgyZ2xDQVpWZm9YNEVFcTB5M0Qx?=
 =?utf-8?B?NU5JU0tVZmhxZmkyZ1pMRVl0N0orUUVJY0pCVlVrWDJrWkVKRElPR2lKWjla?=
 =?utf-8?B?eVQvRDY2Z3EwODQvZllMWDRMa1UxaEJVTXFrZGttS0dIR3EzdjNKSzhBRDRj?=
 =?utf-8?B?ck5VNEhUZWlKb2hub3dqbm1sWVJpU1dNOTJUVVZKTVYyNFpCZnVERnRSVndG?=
 =?utf-8?B?Vkx6VE0xUUt1enYvWVdJUWR3WExFTFFUdVpUT0RrWEZXblA1a3ZIK3dLQ2hX?=
 =?utf-8?B?RzFjWlUxNU05azRTTGtDaDNXZ3V5U2RlOUw5Mkk4cTAwbC84U29nZmZtVHBn?=
 =?utf-8?B?a0RCdkFqekIvWkhLNW5NcEsvZWk5blZ0YlU1SG5NVmx2S0R2dTJhUzR3U2FQ?=
 =?utf-8?B?RkMrN0poTjJsWTA1b2RlY3p5UFplYnM2WWxjZWJzTkN1cVJpNjRsdVdlUUFX?=
 =?utf-8?B?UkxueGFMemdsTFcrdVVQUlRGQ003ZGtibDJOMXVUM3paVmU1TklQMFErZDFl?=
 =?utf-8?B?bVpBdWlSUmFVaDEvRkVUVWQrYmU1TC9YeXZhYU5qOXJISUk5dHMrVVIzTG51?=
 =?utf-8?B?cjZUYnJVNWxuRVdEaWFCY0JUTnA1ZkRNeDFLUVEwcU0vY1dpbm9SbGRHTW8r?=
 =?utf-8?B?NklzeE04N2NYeklFSjZqVFRYdnUrSDBqWkphamIzYmVZWHNDMjFZbEhBMDJh?=
 =?utf-8?B?ejZRdDBLS3ZEZmowSkZCWlAvdkxQZk5XQ01GcDZUK1VzSndsNmx1M2h1Z0cy?=
 =?utf-8?B?WC9mNWs0OHAvakEza1p2MEJNNFphYThzdk9SWnQwMmlHbHRUWTI4aXdpejhw?=
 =?utf-8?B?b1laMG1vOVRZNDkvWWY4djN5QURUSjhQQ2NDcTU2Nm1zYmQ3RHhYWXN3bE04?=
 =?utf-8?B?U2EveHlUOWEyenhaWkp5aUQremcrT2RPVURubzZpVFg0UnZUMC9maXZITlVQ?=
 =?utf-8?B?U2kxV1R0U0Iwb0poa1NIbWlJM2JmcUJDdjRUeXFySHRTSWJEaGJCTXRHU2lm?=
 =?utf-8?B?S1JhazNVWkVscy9zM21MTndqNURoZHNsaklkYk11YTF6Snc0T042ekZMM2Vr?=
 =?utf-8?B?MTFVOUdsOXBpWlZDUExLaXRjSDkvZzdpZHZrb2ZHb0ZuWVRSNXdxcmdjRC9U?=
 =?utf-8?B?bWY1QzZhQmxkc1hudVhDdk03aVVqdm5peGR6MENEbHpWZ3BWeERMYUkzUHF3?=
 =?utf-8?Q?D0H1Lb3nYFPLXUPJz0oGVGOiU+jOYxk2DXEj0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NkN6QzFna3JaNERod1ZGU0M0VjZkUCtIdi9pVmd6eXA0UUZBY0k0K3MxLzRM?=
 =?utf-8?B?UVB0MFpCVjF6VkE2TWdXTE1vaWlWSXl3L3g0ajJ3Y3M3ZndOSWZuMlVTWjRI?=
 =?utf-8?B?aHhiNzBBTE1vQXlxQkROam81NSs2OHBBVnRGcFJTQ0dxV1dJTEF0TjlWblha?=
 =?utf-8?B?SlM2T25XcXVGUmpqdXlzQytHS1RVQ1BwT2tPN0ZSTjlPODgwVU9iVTJ6THgy?=
 =?utf-8?B?VENNYkRSM3JEOThXcUFzTVAwcEFaWWVoczdjRVZzUjdZclJhOXVhUnllLytj?=
 =?utf-8?B?d0Z4YTdLZlVBQStRUGw5VGk4citwUFNjSGRNdFFSR1lGcHU5OFpVNWZQbTN6?=
 =?utf-8?B?Z0tRWnlqaFdHaXV0cHlRcGNsbmYrblJHTmJGa2Q4MHBzOVp6K3lxRGl6LzV6?=
 =?utf-8?B?dW9LZXJZbitqbUZHdm4rTVl0N0RNS2Nwc3o1TlBJLzZCWG5VL0NFd3hUU040?=
 =?utf-8?B?QTZTTVpZSkN0aXVzcSs4SGtJcUR2dlFJYTRPcFFQMjdiaWk3WVE1Y25kQnpG?=
 =?utf-8?B?d2ExSmRQSGFiWXp6b0p1cG1ZT1BsbWVESHQ3UVM3QmxZY1MxbXk4ck0yRHZO?=
 =?utf-8?B?VXlQR3VvMExCOStKR0Y5NkhHUnI4ZlRIUnJPYmNGQ1lSMjczekN4dEVOVGwy?=
 =?utf-8?B?VkxGaWVJK1ZBMk5WcTFOcDRwS2dkSUI5VGRILzc2QndJcnhYMmhrc2tUdTNP?=
 =?utf-8?B?Uk1NcGQwUzZtSXEyelV3UnJaZ2RWRzRMSWdRNnZUZTF0Y25UNWZ0NUgzd2Vu?=
 =?utf-8?B?aENmalNkdEp1ME5HYnA1dUFyOEVWWVAxMmVBNlJJMkUzOTgwU3NCallMcUVo?=
 =?utf-8?B?YkhnQWt0OU14Y3MzV3ZYSis2OHRXcVozb0htd0UvU0dzUzFRM2Uxc2pTZ0U2?=
 =?utf-8?B?cXNDZjgrU0RlUFVGcEhGS0F6QjA3ZnZJbHRaR0s0T0lqbjlENE1DbjluYmVR?=
 =?utf-8?B?NjhIMWxhVE1oTlJvY3VpYmpqelppbTVLTWNQVGcrZVBkK2laa2l2VnkyKzZi?=
 =?utf-8?B?UGp2d3ZvYllFa2J2RFJ4T1RqR2tqYWZWMVdJTGVvU2N4SWhxL0Z5R1NIcWY3?=
 =?utf-8?B?c1ZLUGxnSGtITnRmaWJ4bmJ2aWFCWFdreHJoS1lvT1VrenNRUEtUWTZ6VnVr?=
 =?utf-8?B?bXNBUVdYc1kzTC85dWFrR204dnp0SE1qRVlyZ3pxZGp2ZXhCUzlYU1F4bmpP?=
 =?utf-8?B?L1hmWU5lRzk0OU1jNm9LcnRnUlBtQ3FWdlloQ09YS1gvYlhjVjZPMWdTbXFC?=
 =?utf-8?B?bllEMnlXTUxvNmZDTDc1OXFVK1ViM3dZeEtISTQvc0puNS9McWRlMDhNZzhF?=
 =?utf-8?B?aFFoS2NjV0tJdktnRXRXM2lrbWhYSmM2L3RabjcxNThyemErQWhSWXpSbFRX?=
 =?utf-8?B?N1h4dUQ3Ym5MaW1DVEVwWU1NZmJzNFFER1pvRXpxMU9ydGQ2TFRobzZRR3Jj?=
 =?utf-8?B?SXo0OUJ3MzNTMGZPd0Rpb0FzOW9CSFd4dkhFdU10YkJaenkwNDZBUDg0bzN4?=
 =?utf-8?B?TTdtZkF2eDhSeU96WDNwcUhXM0RkcXJVM3FsRXpxc09nWW1qTXJveTMwOWY5?=
 =?utf-8?B?SDVKa3hSRTJHdlh6TnIvRHk2QysxaGxoQ2VicS9qNHRwUFRIRFgrWEFEaXQy?=
 =?utf-8?B?YmxBSjFZU3M3YTRWRm90WlUvaFlxVFMzOWxtVXB2WE91eU1temViOTBaenZB?=
 =?utf-8?B?TEd0LytpMC9sN2NWYy9nY2hvQmIybVlDalhEd0RVWTFCTG9XTmwwMUVNRU9H?=
 =?utf-8?B?bmVZTEdvZHpLMXlHOGJnMGxZcERlVGtqRFZaMWxpQzRRSlltcUFZOHcxS2lS?=
 =?utf-8?B?TkZHbHdaOE1yK3lGcVJZYXlISHMrbkdVdGdRdFprcUNNdXBpcG1Oa0UreGNX?=
 =?utf-8?B?S1lZUXFYSkp5K1dNWEwwVy9IbVJzUmF6bkZjT3dwSmVCb0g3M21RU2s0L3Z0?=
 =?utf-8?B?U1YrTmY2VWpHMmp3aGJEdzc0UmpsT2VNVGZjMjVidlpCWlJqcWgwUGxjcExp?=
 =?utf-8?B?QU9DYzRqTDNOQmxSUEJteTZKRXdMem81K0h0dDNBV3JtWC8xS1QvbVdMbXl2?=
 =?utf-8?B?Q0tnQmw3M2Vrd2lpdERVdzE4bjI1SWppVE9WRkpIbis1Uis4b3lvbTNvWTY0?=
 =?utf-8?Q?bSof5aecahy39i0GE5c9O9MUr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a69422-9109-45bf-89d5-08dc809ae2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 11:23:10.0560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2QSC2a2BRle9YqP7ted3yrelu9px29QOA9hsuADoCCQXOXE/X00YJLkoitCUOQvM8wvkxyyz9NJIYhbmHjJNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR18MB5466
X-Proofpoint-ORIG-GUID: uPu1o7VjyMI5-DG9gZgJ84Zy4PISxqj5
X-Proofpoint-GUID: uPu1o7VjyMI5-DG9gZgJ84Zy4PISxqj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_08,2024-05-28_01,2024-05-17_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtvcnkgTWFpbmNlbnQgPGtv
cnkubWFpbmNlbnRAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDI5LCAyMDI0
IDM6MTAgUE0NCj4gVG86IEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRj
b20uY29tPjsgQnJvYWRjb20gaW50ZXJuYWwga2VybmVsDQo+IHJldmlldyBsaXN0IDxiY20ta2Vy
bmVsLWZlZWRiYWNrLWxpc3RAYnJvYWRjb20uY29tPjsgQW5kcmV3IEx1bm4NCj4gPGFuZHJld0Bs
dW5uLmNoPjsgSGVpbmVyIEthbGx3ZWl0IDxoa2FsbHdlaXQxQGdtYWlsLmNvbT47IFJ1c3NlbGwg
S2luZw0KPiA8bGludXhAYXJtbGludXgub3JnLnVrPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBk
YXZlbWxvZnQubmV0PjsgRXJpYw0KPiBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFr
dWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvDQo+IEFiZW5pIDxwYWJlbmlAcmVk
aGF0LmNvbT47IFJpY2hhcmQgQ29jaHJhbiA8cmljaGFyZGNvY2hyYW5AZ21haWwuY29tPjsNCj4g
UmFkdSBQaXJlYSA8cmFkdS1uaWNvbGFlLnBpcmVhQG9zcy5ueHAuY29tPjsgSmF5IFZvc2J1cmdo
DQo+IDxqLnZvc2J1cmdoQGdtYWlsLmNvbT47IEFuZHkgR29zcG9kYXJlayA8YW5keUBncmV5aG91
c2UubmV0PjsgTmljb2xhcw0KPiBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPjsg
Q2xhdWRpdSBCZXpuZWENCj4gPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj47IFdpbGxlbSBkZSBC
cnVpam4NCj4gPHdpbGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20+OyBKb25hdGhhbiBDb3Ji
ZXQgPGNvcmJldEBsd24ubmV0PjsNCj4gSG9yYXRpdSBWdWx0dXIgPGhvcmF0aXUudnVsdHVyQG1p
Y3JvY2hpcC5jb20+Ow0KPiBVTkdMaW51eERyaXZlckBtaWNyb2NoaXAuY29tOyBTaW1vbiBIb3Jt
YW4gPGhvcm1zQGtlcm5lbC5vcmc+Ow0KPiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVh
bkBueHAuY29tPg0KPiBDYzogVGhvbWFzIFBldGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290
bGluLmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJuZWwub3JnOyBNYXhpbWUgQ2hldmFsbGll
ciA8bWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb20+Ow0KPiBSYWh1bCBSYW1lc2hiYWJ1IDxy
cmFtZXNoYmFidUBudmlkaWEuY29tPjsgS29yeSBNYWluY2VudA0KPiA8a29yeS5tYWluY2VudEBi
b290bGluLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIG5ldC1uZXh0IHYxMyAxMi8xNF0gbmV0OiBw
dHA6IE1vdmUNCj4gcHRwX2Nsb2NrX2luZGV4KCkgdG8gYnVpbHRpbiBzeW1ib2wNCj4gDQo+IE1v
dmUgcHRwX2Nsb2NrX2luZGV4KCkgdG8gYnVpbHRpbiBzeW1ib2xzIHRvIHByZXBhcmUgZm9yIHN1
cHBvcnRpbmcgZ2V0IGFuZA0KPiBzZXQgaGFyZHdhcmUgdGltZXN0YW1wcyBmcm9tIGV0aHRvb2ws
IHdoaWNoIGlzIGJ1aWx0aW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLb3J5IE1haW5jZW50IDxr
b3J5Lm1haW5jZW50QGJvb3RsaW4uY29tPg0KPiAtLS0NCj4gDQo+IENoYW5nZSBpbiB2MTM6DQo+
IC0gTmV3IHBhdGNoDQo+IC0tLQ0KPiAgZHJpdmVycy9wdHAvcHRwX2Nsb2NrLmMgICAgICAgICAg
fCA2IC0tLS0tLQ0KPiAgZHJpdmVycy9wdHAvcHRwX2Nsb2NrX2NvbnN1bWVyLmMgfCA2ICsrKysr
Kw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wdHAvcHRwX2Nsb2NrLmMgYi9kcml2ZXJzL3B0cC9w
dHBfY2xvY2suYyBpbmRleA0KPiA1OTNiNWM5MDYzMTQuLmZjNGIyNjZhYmUxZCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9wdHAvcHRwX2Nsb2NrLmMNCj4gKysrIGIvZHJpdmVycy9wdHAvcHRwX2Ns
b2NrLmMNCj4gQEAgLTQ2MCwxMiArNDYwLDYgQEAgdm9pZCBwdHBfY2xvY2tfZXZlbnQoc3RydWN0
IHB0cF9jbG9jayAqcHRwLCBzdHJ1Y3QNCj4gcHRwX2Nsb2NrX2V2ZW50ICpldmVudCkgIH0gIEVY
UE9SVF9TWU1CT0wocHRwX2Nsb2NrX2V2ZW50KTsNCj4gDQo+IC1pbnQgcHRwX2Nsb2NrX2luZGV4
KHN0cnVjdCBwdHBfY2xvY2sgKnB0cCkgLXsNCj4gLQlyZXR1cm4gcHRwLT5pbmRleDsNCj4gLX0N
Cj4gLUVYUE9SVF9TWU1CT0wocHRwX2Nsb2NrX2luZGV4KTsNCj4gLQ0KPiAgaW50IHB0cF9maW5k
X3BpbihzdHJ1Y3QgcHRwX2Nsb2NrICpwdHAsDQo+ICAJCSBlbnVtIHB0cF9waW5fZnVuY3Rpb24g
ZnVuYywgdW5zaWduZWQgaW50IGNoYW4pICB7IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL3B0cC9w
dHBfY2xvY2tfY29uc3VtZXIuYyBiL2RyaXZlcnMvcHRwL3B0cF9jbG9ja19jb25zdW1lci5jDQo+
IGluZGV4IDc1OWRkNmY2MzQwNS4uMjMyMmZhNjUwNzVlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3B0cC9wdHBfY2xvY2tfY29uc3VtZXIuYw0KPiArKysgYi9kcml2ZXJzL3B0cC9wdHBfY2xvY2tf
Y29uc3VtZXIuYw0KPiBAQCAtOTcsMyArOTcsOSBAQCB2b2lkIHB0cF9jbG9ja19wdXQoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgcHRwX2Nsb2NrDQo+ICpwdHApDQo+ICAJcHV0X2RldmljZSgm
cHRwLT5kZXYpOw0KPiAgCW1vZHVsZV9wdXQocHRwLT5pbmZvLT5vd25lcik7DQo+ICB9DQo+ICsN
Cj4gK2ludCBwdHBfY2xvY2tfaW5kZXgoc3RydWN0IHB0cF9jbG9jayAqcHRwKSB7DQo+ICsJcmV0
dXJuIHB0cC0+aW5kZXg7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKHB0cF9jbG9ja19pbmRleCk7
DQo+IA0KUGxlYXNlIGNoZWNrIHRoZSAiYnVpbGRfY2xhbmcgLSBGQUlMRUQiLCAiYnVpbGRfMzJi
aXQgLSBGQUlMRUQiIGJ1aWxkIGVycm9ycy4NCj4gLS0NCj4gMi4zNC4xDQo+IA0KDQo=


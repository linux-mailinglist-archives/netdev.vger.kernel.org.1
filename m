Return-Path: <netdev+bounces-109981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4888C92A8FE
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51F61F21014
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A011A149C7E;
	Mon,  8 Jul 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zz8aFfU8";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kbeUNyPD"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C37146A63;
	Mon,  8 Jul 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463631; cv=fail; b=EmPSt9bwI2my6aBSQtHolbZmOXIOQa2TwuPxgRNaP4TVeK/JPBG1w59xx31BweFNlVFvCrpxfUgVC+uu21hc4c/HGJcf51glkIZTTu4yeUY823IIDxWoTNl3K4QI3PAW4DiHLMWe9POat9SU4rvBQLQzW1qdjU292iSVQ4KnNtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463631; c=relaxed/simple;
	bh=P/o9qpaIeWS6PSsOhXnZzQSKFaSKJP2IIe/NR0WWGpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VkM+IrjGtcmkYG8xPr/qrpAYAESZb+AUv/4X0q715FqhC688EuO5v5X4sXtpNn6EMoHFgG7QlpD3ifx3e+13dpNo91fG+ew6VAu/rV66p/RKmwNp0k7C3dP3X0IyUAzAO04xW2utmZjkFmtm9s/ZxLAfogjJVbiHRBJ4mdgZ0Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zz8aFfU8; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kbeUNyPD; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720463627; x=1751999627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P/o9qpaIeWS6PSsOhXnZzQSKFaSKJP2IIe/NR0WWGpk=;
  b=zz8aFfU8H0mYseIoQbNVfQySNyaHBV0hsa0rI3JyFe1A118dwJvP/B0f
   /tTWpNTw7eFubAZd8k3cBKum3NXUNicJqVfLWxJPjTNmXYEc9SgKHrrD2
   nlUWx3F915pkGllFbIoC+Z+1xH+4c3DWmLjsUSobMz7nqqumQvAAqz8cw
   7Dmxj3NQIXfd12NBRwuWFkBJqF3DV3RAdvron+R3SpU/OVNyl0K0zp6Dh
   SbblpEgzAd6SepTHCkO/y349qafmyyOUoKpP6aBYN+XMWDQdF2BBkh2UC
   r85L4goIG+BCkjJ/CcB+DMekR9GqGk+PICDhRSxadO7Xq4uMnbc90i/y0
   Q==;
X-CSE-ConnectionGUID: 3jIUv/57RZCSHu2zF8apVQ==
X-CSE-MsgGUID: qzJgxVFhS1uw3n0vzQrWFw==
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="28944632"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2024 11:33:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jul 2024 11:33:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jul 2024 11:33:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv1rBYsr3OYLnYoKZtJkVGIkUc99jD0RHV29yDwW9rtueo6Wdektfx0NVbS2mF9zHAk/f1qZb6+ggU8HYGkIF01Yc7nfyJu0NXpiu6gnpmb37akR2Ksm9Khm8JnEPwUa7UU6F1amCun+M4bTXejvxuXyVVCOpwW10Ng0VuVxMfmYEddcpJdoxks6ZDmKMmFEHol3dO23QSSpWaIz9fAjtdMr773ckmsJMcC8SghZeDNaiKDWhhTmXhKrnuf/sZWqt9RWQHcWONmKB2khy8Mq6XZydguSc1fYhpOBFLHQIpxezP4HWXKnL71nPMG18BX17ah57bG1sTMxqymn9hAF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/o9qpaIeWS6PSsOhXnZzQSKFaSKJP2IIe/NR0WWGpk=;
 b=XBrb/Bjt9VpLYWFZnQpAscIoyh9bqVORTDYGE03lZXmRiCbjnk88xoJJKIeI3EeRt8NGWgdtPpwwFmUicD7ql2iqt/RXAxJOpMH4PNuh1SWEA1Nzk644eXZtCSJQZuD1hdnm8zTlvDpyWJkK65AroH3HY/wY4quVOX/enfcWxq0ex9jY0GprRTOiUp0idsPaS6iypEcDk5vtHhcY1IxoBwhHRBfU81o52ui0xBPnJkbFeoijiTejGlgn+FTDhESYz74upNRglKvIX/GxFz2V/2SNrmKMtFRJ6Ad0m66H+3DQBwYiiyu72nfTEOAMTF8PnNUhs/sai1zN6j84eW2bwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/o9qpaIeWS6PSsOhXnZzQSKFaSKJP2IIe/NR0WWGpk=;
 b=kbeUNyPD02/+/t1HpkYCeRqWSDalEl/XY9zYW0eQVj4CSQrlSZkqJFWDzFBs970K+3QA00WKDJakQitMJXZDlGaXK2lpQ4Fd4tH5uj/i6s3E5Rb54K67GSyrWCwNtONZ6PEjEXNF3bSSEd5APHU9z7hX74vi5FbmMx8y4/UdHgfq+CCF85qdkeO8C35Qw9OwVrJHjPvNTLJL2MdtqcGXx9cCE7ybHKWmP7K7kiOS8aZkqPuFGOI4iIQDQTaFDQoVWBENEq18+xI4jbB3Ul0m60ctSGdis/VatNzLSGkiUBM7ennuoPPqp5kzQdeIPBY3jZQ0SQr8ddGj54zIkLuvXQ==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by SN7PR11MB8068.namprd11.prod.outlook.com (2603:10b6:806:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 18:33:18 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%3]) with mapi id 15.20.7698.025; Mon, 8 Jul 2024
 18:33:18 +0000
From: <Woojung.Huh@microchip.com>
To: <o.rempel@pengutronix.de>
CC: <davem@davemloft.net>, <andrew@lunn.ch>, <edumazet@google.com>,
	<f.fainelli@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<Arun.Ramadoss@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <Yuiko.Oshino@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>,
	<kernel@pengutronix.de>, <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v1 1/1] net: phy: microchip: lan937x: add support
 for 100BaseTX PHY
Thread-Topic: [PATCH net-next v1 1/1] net: phy: microchip: lan937x: add
 support for 100BaseTX PHY
Thread-Index: AQHazhpnRTNboJbIQE2PiY5dbV/LyrHmtZQOgAA4RgCAAA9RUIAAr+cAgAWAobA=
Date: Mon, 8 Jul 2024 18:33:17 +0000
Message-ID: <BL0PR11MB291354A0FED61B521DF1FDEFE7DA2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240704135850.3939342-1-o.rempel@pengutronix.de>
 <BL0PR11MB29132F1C667E478728BCE4ECE7DE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <ZobyTGbbzXlhTBbz@pengutronix.de>
 <BL0PR11MB2913A0855BCD3EFF290F8018E7DE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <ZoeStBG6aGu9WmHu@pengutronix.de>
In-Reply-To: <ZoeStBG6aGu9WmHu@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|SN7PR11MB8068:EE_
x-ms-office365-filtering-correlation-id: 303f11f3-2c9a-4143-b51b-08dc9f7c6fca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dlEwaTZ5U2poNXIrZWhPS0FUSjgrRmNzbEVYY2IzZnZxeS83RFk3QmVVamp2?=
 =?utf-8?B?Z3o2SEN2SXROeW1pak94YnhaY1lNYVVybjJSbE9mbzVYNnFxekZUaGM5MHlT?=
 =?utf-8?B?R0lDZ3FNVEl3RmkzZ2dBbW95OVpFbWUwQ1hoaGthL3VPRU5kRDV6MTQ0NDhl?=
 =?utf-8?B?cXJQUFVyRkdyWjVNUkNGUUwzVWhINXJoVUh2NldGYmJUTm5RNmlNWGMrbXFm?=
 =?utf-8?B?QVZnOVA3VzVKNlpaSHM3NEw1MnFHS1R2UEQrbERmUjlYL3RyeHRkZnJnR0dk?=
 =?utf-8?B?aWc3OVBqQllwdURHeFpGek91ZkxqaWlVRGQzSEx6QjZ6NnJCZDNjeXZrZ2ZL?=
 =?utf-8?B?dklGd1NXejJuZi9iT0U5cVUxM2Y3OTF5YVY2bm5SeFA1cmd4c2RyblhPN21w?=
 =?utf-8?B?OFp6eGllcWNJNVJINXg4WDdsTUh0b1lReE9KaWJpcy9qMUtKckE2cWVTOUsx?=
 =?utf-8?B?TmVNeXFQYkcxNUxqQ2ZwK3ZYeCtaeG4rMXVpZUt0bWVRTU1rNFlvQlJjcTc0?=
 =?utf-8?B?Q0M5YTg1RVFvY21BVmdwTWFtL25KaThqVEI5VlhJSy9ZOEgvN252azlTUFEw?=
 =?utf-8?B?WENFOSs5U2FLVVdwQVRoZ3V5K2pXUmIzL0k5cWNpeHFqT1BzWE9XZmJTN3FD?=
 =?utf-8?B?NzZVSTlGTXJaSktVdVJqQ0Q4cFlONjFoWEVnVnExencvcXRmazB5Njd1VHNZ?=
 =?utf-8?B?cGxuekZ6NVk4OW5sakhUVURwTUVvQzJvajFYSGZ5bXVrbm9NQy9rTUs4eW9u?=
 =?utf-8?B?bEJTT0szMXBtSzV2T25EakRCeGI3NjIxOXQzamNwOEZ1WlpWcDZZZDBzV29J?=
 =?utf-8?B?a2NxNmNVQWJIZ0VheWtKTUIzbWcwSkJJMTkxTy9YbkFKZmZqN0EvY1RDQ3Ra?=
 =?utf-8?B?NkxObjBZWTZQUzU4aWVQWmpYWE5sdk1scHBvRDBxTys3TXJqejBBUlc2MG1H?=
 =?utf-8?B?a3RBcE9kNFF1Zk16N0M2K0Q2SGZFcldDWlkwZUJzNWJzMyt4bkVyZlhnRVpq?=
 =?utf-8?B?UE40MUFMT2R3TGRPK0JKdFJ2VVA1b0dYY0xZb0NJWkpUYm1YMkVSM3VmblBm?=
 =?utf-8?B?ekYzY1NaR0dYNzhMSm8yQ3ZGUVpzNmtVWjArNEpQWXBQVkluT3dNZ1BPRVJF?=
 =?utf-8?B?VnJsWHR3cTF3dUo3N1FPYVB1ZDVlcGJWc0pqaXlBbVJlbElyL0c3TzVHODZJ?=
 =?utf-8?B?dnRxQWhCbENVSjlDbkNOcmNYNjV4bEJXcm5EaXZDak1keFArNVZYeTVhMDRC?=
 =?utf-8?B?d1FzTm9IKzdjOVBBenc5VmVQVE9HdHZZTnhURjZFd0YwVlJUWXgwUjJ2TDNY?=
 =?utf-8?B?bU93L0tPRzgvSlpDTzlvMDBObTQ0NGVKM0RublBMSWZhVVQzN3V2bk03NS80?=
 =?utf-8?B?UDZJVmFBL29FZHFFa2gxRlNpWEMvN2hiSHZnQ1NlMTMrS3dlQTB1Qmt4WHN0?=
 =?utf-8?B?L3NxS291QlJYb0hGamcyV1pXZ3ZsZTEyQlRMelp6ZkljUThVa3lrU2x1VXBZ?=
 =?utf-8?B?VnJ3RFF2ZzFXbHN5MUxpN1FUUG8wY2ZHUVhsNEFYejlNYVBnMGNIOUtON2R1?=
 =?utf-8?B?S3FGMVJ0dWgzYS9kazdYQndOenN6M2dYZG0zc3NzWnUwZGNLU0lxS2FLdU5k?=
 =?utf-8?B?YmdFQ0k2Rlh0aFJjSXpNRVR3VHlRTHlGZXpBc3IzY0xsWjRCRkQzeG4vSGtT?=
 =?utf-8?B?eVJ1bGZVTW16R1Q2VmxQREVMTmdYaXJ0ZkJXNUNDTEc3bFdUaWVkaUhFRWQ2?=
 =?utf-8?B?akVuS01KcXQvV08vRllxWDVTd3B6anp5K2NhODVSV3FmWUZpVFg3dzNIWGRp?=
 =?utf-8?B?QkxYTjhYbFowdzY5RTQra0c1NXVqNW5uWmQyeEZiWGZIaGVaOVpTS3FSTUE0?=
 =?utf-8?B?OW1hQ2twUkxFRnNXVFc3RHBQaFIycVpLdG5hQWVyNE9Bb1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1JNZmtuZEIrcVBRTFVReGJoQndDL2ZyTm1WRVVGSnpZMTBWR3dFUStTTStX?=
 =?utf-8?B?cW5mMVE3OG1IUG91OHhrZi9jSTc3YzluR0duTERuVnAvYVlYZlhvUkpzQVRk?=
 =?utf-8?B?V0UybXAyVWpSR3dXdjhUaVpoanhNN1MxMzVFR0ZzSlVpSC8zN0FSbm1DWUxD?=
 =?utf-8?B?cU90d3BaWlZNRGpZMDBkSUwvNE50dzFPSnY5eDd5YTJFbkdqdHNJSnJUbVVy?=
 =?utf-8?B?VEMwdmxZWnFpVmkvcmwvbUNoV1RZcEJKWWVZbVpmS2hQdmNMTU8vaWdYckV4?=
 =?utf-8?B?SWhvQjc3QTZrbVJ5S2pocSt4Y2FVNlg3UDFmZTVNUzJweHFPaTkwamZTV05h?=
 =?utf-8?B?THU1NTVMUmJQb01SRXpXNDU0WWRXYnZTcmNoQ3cxL1FjL2x6T0dmN2E4OVhW?=
 =?utf-8?B?cyt3OUpNaEp4Y3BUeXZWRHdBSlMyc1IrcGJkZ0ZETVJOUlZqTnV5bnZpOVRW?=
 =?utf-8?B?b09YaWYyQXpweXZSRmhYMkM1TzA3YkxGS1F1dGNmbzhrNy9hSTRJWDF4ZHNC?=
 =?utf-8?B?aHBOSlJUSGR6Qm9tTDRCWHZHcW5DZGVRUUFMQnd6VmRqYW1VWkZuYURCZ1Vq?=
 =?utf-8?B?MnhpRm84NHQrYkdKMkJPMXhOMXRCbXFZZW83ZGVPWUN3ZnhpRFZWdG1GclI5?=
 =?utf-8?B?aG8zdHZFQXpwVHE4NDc0RTFtZjhRSXhKTEVUSDRBdnkreFhLTXZnRHhUN2h4?=
 =?utf-8?B?ZGN3MmV2Y0MxeUVYaWNLbEhRUGJlVHNqQlFSdXgrSThiM2p5S1JKOTRBUm1u?=
 =?utf-8?B?Vmt0UzhkSmpiL3Y2MjVKbDdLcEZLeFExK3hyRFRDdW8reG5RKzFCM29DN2sz?=
 =?utf-8?B?OGRyVmo5NW1wVlBRLzZkZWYrMS9tRGljZ3BqNy9IT2VTVzJjb1g1V3ROMU1w?=
 =?utf-8?B?YVFSNHUwNU84UVFja3p1YXhrb1FSZkdaemhUWlUwVHhaRGtEYmJBcUg2U05y?=
 =?utf-8?B?d1hWVDIzTmM4MEtnSFRpNi9aUEN0UWhkbnU2UUpOUEJQaHFpbTJxUGtqVUxI?=
 =?utf-8?B?ZWs5Zlgyb3JPeHU1OXdlVHRCZzRFMjB2b3FIZGFjV2hQUDgxSkxpaElsOTM4?=
 =?utf-8?B?L0QwVisxWXRCSVJzNVlnL0d5WWhmMUllWVBMcHNnMUFsWk40NnJhYmlJZFd1?=
 =?utf-8?B?SkhhN2NjK1ozWUx2Umw0U2xhNkdYNjZ4cDZpOCtzbytYZnVCc1hObmVHRGxH?=
 =?utf-8?B?QzBueHY2RWhqTHJDdWR5UUxoSHU3Yll4elFjYjJhV0lHK3g3dHNtbDQ3bTRo?=
 =?utf-8?B?SjhnWmxSUWhFMXVlTHNsd3NBLzRRRWhOM1ZId1drUURvQzZsS3k4TjdrcUNX?=
 =?utf-8?B?WkdoR3M3MkRSMHZFQjZ1b0x0U3lKNkljQkJhWWZDZlRxRndHZUdLQ1JiaGly?=
 =?utf-8?B?dTVrV2dzLzNVcno4SXdNR2tENTRUK1VtYllDVVJadXhCRmNnRHZlM2MxVnFM?=
 =?utf-8?B?QTl3cDZpWXNLTWQwV2V3TEk0bDNTd1hvRVhjS3hCK3JwMXhjNTFHdnZnbkxm?=
 =?utf-8?B?UC9rdGxrc1o0R3pXT1hhRWpSbDFsdzhWNGhMVXIvTnNKK05zcXEvRVN6Nkd2?=
 =?utf-8?B?NGVkYkxncGpCeFdTdDk2bVlxTjh3VFlUeVpJSjdwdGNBYk1QL3F3VFpNSkV5?=
 =?utf-8?B?a2hSQUl5Z05lZHBaUkEwRU9YTnJDbHlDc3J6UStqSVRlYVhOMjhVcUsrTDZE?=
 =?utf-8?B?TForREdQeVhrYUt3NHNobFlLc1NBOG5aSXVKMzVCVTF0b1diWi8xbUNVSjZr?=
 =?utf-8?B?VzRHeE0yTjdrY3dkRGZqd0RKU2tZTk1xTm5WZDJ0eUd2TTFwaklSQnZYYksx?=
 =?utf-8?B?cDRCU0hHSi9BVlJscy9UMDdRb2l4OU9MVEJuOFRPOWFUVDBBd3djL0ZPK1Bt?=
 =?utf-8?B?ck1xbTdqQVkvNW5iajM3ejBGS25NR1JiWndLczhFWHJPRDRzOVM1TmNzVVEz?=
 =?utf-8?B?cGNFd0xKekk2b1ZTb2ZqWU91QXY5OWoycVJjZGV4czcvaUUxaVQrRkNCV3Ir?=
 =?utf-8?B?N1QrcDRPTkV5MnF3UVpEQk0wQ3JId2xtMlZqbEQ2Ukpma29GYjlkT3gvK2Nj?=
 =?utf-8?B?TlRRam9OY3psY3RoYlJUelhTLzlTczUxbEl3cWJzNTE5cHpJaWF1U2RCTmw3?=
 =?utf-8?Q?QiFbqcVanCRAGmwbCE3l8bXE/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303f11f3-2c9a-4143-b51b-08dc9f7c6fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 18:33:18.0069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0i+5d+Abj3PU9FJ6pirxzKVHsCAGV7VIQe6BOOdDVrTIeah2LTDwRzrx7UbjaW3Q8UYo30518cAzhV89xwoUz86ygqxViS5sUMm0JjwGZy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8068

SGkgT2xla3NpaiwNCg0KU29ycnkgZm9yIGRlbGF5ZWQgcmVwbHkuIEkgd2FzIG91dCBvZiBvZmZp
Y2UgZnJvbSA3LzQuIA0KU2VlaW5nIG1vcmUgdmVyc2lvbiBpbiB0aGlzLg0KDQo+IGFueXRoaW5n
IGluIHRoZSByZWdpc3RlciBtYW51YWwsIE1ESVggc3RhdHVzLCBubyBjYWJsZSB0ZXN0aW5nIG9y
DQo+IGNvdW50ZXJzLiBEbyBJIGhvbGQgaXQgd3Jvbmc/IEhvdyBhYm91dCB0aGUgVDEgUEhZPyBB
cmUgdGhlcmUgYW55dGhpbmcNCj4gYmVzaWRlIGNhYmxlIHRlc3RpbmcgYW5kIFNRST8NCj4gDQoN
CkkgYXNrZWQgbXkgY29sbGVhZ3VlIHRvIGNoZWNrIG9uIHlvdXIgcXVlc3Rpb24uIFBsZWFzZSB3
YWl0IGZldyBkYXlzIGZvciByZXBseSBpZiB5b3UgYXJlIG9rLg0KDQpUaGFua3MuDQpXb29qdW5n
DQo=


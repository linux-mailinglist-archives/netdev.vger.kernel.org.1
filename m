Return-Path: <netdev+bounces-111546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90416931808
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA6FB223D9
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A490B134DE;
	Mon, 15 Jul 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="JX/iFYTN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A7FE556;
	Mon, 15 Jul 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059374; cv=fail; b=VGAdhQZZm4SXfJ0P85t10khGs6eNPJB2hfeWSMqRInyMbfWzAHcXXt0/9Un0qq0C+uYojMdgcbpOHtHNq5iM/hmLIq+mtoC3QINm4hh4T+nxZF5+HfBzWvuvPU2IMyriPL2uzNWO3hahOpjrYq42JL04F97jMwR+htfrAU0Np+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059374; c=relaxed/simple;
	bh=KXX6JCN6rmRoZrZQbDKPe1Pzei4PXaMXdst0pSzs7d0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uY4NTPV4EA67v1f+lCljIFm//XB/Xrvurb0IUOplFanMXHPVHuuLgO40VOpGmHTAoKNtTNlRBEPTPH4K6jf6B/FKsAs2u6p8/v2OdBmdm/n5XKKEA0V3nL/Lw/uoS4bi6pW85Css6TybXYnodM4csFAl/RyE0wAuyEGADrB44cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=JX/iFYTN; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46F94ok0031360;
	Mon, 15 Jul 2024 09:02:27 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40c9p5uwpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 09:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJ1Lp+oYCvBjDXOpEQ9K4591IuI+XI7iuLyxE+kFOmZfPjbPS2ejeySiGCLTok2m5rUqBPE58a+8IxrCoeoOaNZTN9E0b5hmbDTRtSElyvehhbM4dylKNhKg4aHs+/Nm4g/nWhJC1ljdUlsY2JuqS6iLkVrQPey0deCzjKpwcDNW9GgYXGsH5nTAXdziNUn6aDBW94Dd/L1jFMxIDB/MrJ8qaS0CYmEQp6WrWUYIRashrNmHitu+FHUqj5Yezh8tngJYP4MMKHGvC+YjshFtkqeVixqJ3+rJDwP0g/tVTlJyctS96aJ2Eo3gA3wYgkmt6J+4RzCazV4CWVw+zKcMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXX6JCN6rmRoZrZQbDKPe1Pzei4PXaMXdst0pSzs7d0=;
 b=nwmGVWvMXpdR6yc3oQYV9BXcvLXA2nWEGqE0hAIP6cIvwXgRxhiP2Je6moDAGGEWCQFEoPxN4Qr+tp53u8rovRzgriO0ixbgyfyN4sB1vr9jqdIuiubXOS/Vblmvg/thKuRWZ1rhbcBBT+7iZIzUszU9HElsbkYr6zJyoTtF1ZmeFRtHYsam1f+T/KgsiQXEyebxYoanmB9Q+Bj0/sDsfX4C5uyN3sAbGFrEvZjbLxIfY4Clm2zlAnywOrNq3RNnMIyEUHlSiCxdJCB1HwT0m3BRLRv23jWFRaYATi9b31we0KLEs1FqoH4Vgijfttk5MLXSTlUOttizELhqhnvCaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXX6JCN6rmRoZrZQbDKPe1Pzei4PXaMXdst0pSzs7d0=;
 b=JX/iFYTNoE6rz+JnlXW56N06+yt+f1EshMD0WzyHC/bIlfS8lo2B94CGG2DEuRlS+5L5ft+GN04nyHEDPS1oWuXVkN5in3LkpuSPswmsRgT7+asZyy1rci7PgiPGxI/O0Y/9Tta7io6HAZT3YCA6dss26gAvzXBCbnGxv4b9ceA=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by CO6PR18MB4403.namprd18.prod.outlook.com (2603:10b6:5:35d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 16:02:24 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 16:02:24 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: "nikita.shubin@maquefel.me" <nikita.shubin@maquefel.me>,
        Hartley Sweeten
	<hsweeten@visionengravers.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn
	<andrew@lunn.ch>
Subject: RE: [PATCH v11 17/38] net: cirrus: add DT support for Cirrus EP93xx
Thread-Topic: [PATCH v11 17/38] net: cirrus: add DT support for Cirrus EP93xx
Thread-Index: AQHa1tBhqcrYnL86OEOoC/iw79eWpQ==
Date: Mon, 15 Jul 2024 16:02:24 +0000
Message-ID: 
 <BY3PR18MB4707D450930467656DDFA58DA0A12@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
 <20240715-ep93xx-v11-17-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-17-4e924efda795@maquefel.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|CO6PR18MB4403:EE_
x-ms-office365-filtering-correlation-id: 6964970d-733d-4bf5-563d-08dca4e78481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TEJXdnhveHRGZHhjVDF2M2tZNzBZR1NweXFWeElHTTQzbmhGSU1LWUNJQytn?=
 =?utf-8?B?RFN0VzU4b0FDb09TU0ozckhub0hIRWhqMWhsNGlUMTRaNU8rNy9YVVlpeTdm?=
 =?utf-8?B?Skc0bFVIM1lqWU1ZQnFrL3h2WVdEYjE1b3ZEaUJEQzBXTWh2bjdPQWxJcUVP?=
 =?utf-8?B?QkdvcXNpSGRkOStqUjF4cUFLWXBxWDRteUNiUUpPbUNQMm9SalpxK0pJNGty?=
 =?utf-8?B?YklUdFVQTTFDdC9iMFA5VnhKbWNFaVo2NWVZTnBDbEdlWlZFcmlsK21OUkdE?=
 =?utf-8?B?SVBPVWxBeER3WjhVSlZhcEthRUNJSHZTVGU1eXBkOWpId2hxMU5yL0h6dFJ2?=
 =?utf-8?B?WmtQUjNXZVFyNlVZVUpqSmlaQVVGOU51ejlRaWgxOWVmWm50YzFkS3RsWjF0?=
 =?utf-8?B?dHpsUkVCQVNqMFB2N2ZVb2hSQ3BVcEpUL3BVeG5NSXNrb2NzK1RPUjN3ZWtW?=
 =?utf-8?B?NUpZWnVhdDFEcnVhL0grV09Hc1p6dVU0bzc3Wmh0ODVabnc3UllMaGZJOUJP?=
 =?utf-8?B?UFAvdUtVbWsxU0pQbHJLRk5UNWtBdTVZOFR6L1d2cThnSFZObXIyRzRzb2ZL?=
 =?utf-8?B?Ujg2elI5ZGdoTk1ycWkyRGMzK1RnYllrN1h6K1MxSFRBNkVtWVlJMnFVUnBW?=
 =?utf-8?B?MVFYSDAzZnlOWE9OaHNsQ1ZKNHRlUWtodnVLYms4NzNyZjYweTRoZHRNQjA3?=
 =?utf-8?B?YkNtdDVHcithSlJZZm5rWU5yV1FIZ2JGd0NHT2hIdW5heGtEaWg0aE5BdnpG?=
 =?utf-8?B?NEtlUVlzTE5lUnlPc0QzeE8xTys5blBzZHZUVmtTNWpmM2xSRnlDZjk2ejQw?=
 =?utf-8?B?Q3EyOExIVTFDbkl5VTRYMWEvWnU0YTJGKytCTEFlK3VKNEVxRHVSbXcwM3M2?=
 =?utf-8?B?UnVOMkZEQmZMd1pCdWN4WjlXTjZENDRmTlpTbzZMd0dZWjhubDU5VzZLZjAx?=
 =?utf-8?B?Mnp2eVpPVEdZejNCQUZuRlVoSGtBSmRGNDlmK0NzejdmMnNUNE95SzAxZWxL?=
 =?utf-8?B?Q1V3V2ppdERPV0R2MVFYbEk0dGNoenpWVE84L1o3Zmt3RHR3ekJHQ3hqQkNJ?=
 =?utf-8?B?SGFlVDR6eWF1b2JFQXVDcjNjSE03UDZRTWlPK0NvWEQ0MjFPbVhxNmJoZ2xy?=
 =?utf-8?B?bXc1d0pkbDlzRk0vSU9naG9DTjRCTnp5Q3FNV0t3RGh5MjVZaVZzdW1teFRE?=
 =?utf-8?B?Qy9zWUJKUWc5VjkzUHRSaUVlYjhCZmx1aHJkOTNrUUdJZDFIZm0rbGZZQzRs?=
 =?utf-8?B?OFZPL2svTjAzSHBOVzBIaWJRb2htdDM1emhuWWRteEQ4Tnc1aFg4dm9FcWlZ?=
 =?utf-8?B?YVZJVjE5aWdQRXh2b2hxZUdBZGpyVXVsS3dFMGhrOCsrUFFibUVpWnh3K21m?=
 =?utf-8?B?ZDJYdHFnV2xOeXJZc1lUN1dFRXNYaURIK08zN0ZmM2RyMXc4VkpaQ0hWWDBw?=
 =?utf-8?B?ZENiLzlzQkNDaFFsTXFCTTdBYmIyQzFza0ZpUkJkWW5zNVI3cEF4OUppVENN?=
 =?utf-8?B?VkwvT09SVkhjdTV1a0tkQ0VrSVNNU3U3QzZFb21SQmQ5TkZuTFVDL1V2WkI0?=
 =?utf-8?B?N0p5cGxvTk91UU9mMnlmWXBTNjlybWVqcS9Mc0ppVDBQR2xycThmVzNrdWhh?=
 =?utf-8?B?dkJadThMdDRWeitNS1hxbFAzQzhOcUV1VFVSOW1rY2VXZE9qN3dES2kyUXMx?=
 =?utf-8?B?RUVwTUdMTW8zS2VZeW85eitvOStmUlM5dzYzMGYvdDBUKzV2MW43MVQ1NHlo?=
 =?utf-8?B?TmpQMy9MWGFnYjFNb0lmWHE4Mk9QclBxcElhVDJaNUR1NzN6VWNXZlgzUmhG?=
 =?utf-8?B?SnQ5V1owcnljc2hSS256N2EzSUxEK2x2NFRUeEt6UVBvK1NuMVJjaTFYM3hN?=
 =?utf-8?B?L2RxMCtYa01yTTBYNE9GUHQxS3UxV2Y0MDAxSjNqQVJNbkE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?enVUSzZWNUVXcUhyb3FwY05zZzhxa0lvNmZCb3IyZlZDeUtUdGRROGp3a0Rh?=
 =?utf-8?B?Z3pCTHNEb2NoR3dURkZHbit4VVRINDBWYnVLNmQ1WWY3OXR3TFRxR1lPMEJj?=
 =?utf-8?B?dlYxS1pIYnpxZkxRbEtDRTc1UFcxTnYxM2d0KzF3MzVhUzhlOVNIRklYcC9k?=
 =?utf-8?B?TzNEdlRmbzNEWmszZVFPMkNycUc5R3BYL3BDMmVvTGJMWTRyeVhUcUJOYm1J?=
 =?utf-8?B?aGZWeGJBNHkzUlRRaW5INnU0TVhQWWVsVlI1TE0yOFVHbVlONGU3WjVzZm5J?=
 =?utf-8?B?MUc2NWJMQTNpRU9SYVBxcXVJUm1taU8wcjlGSVMvMXZtekRlR3dRQnYrZ1cw?=
 =?utf-8?B?ejhuSHdrekg3eFFNb3JVRWdxbENWdUFJTmErcTEyekhtSUNYQ29XcEVrRVNB?=
 =?utf-8?B?cHZNUkp0Q1BiNitUOFIyTEVJODhTanNEaEszMUhzamJOdzl5UFB3bHNWeWs1?=
 =?utf-8?B?WEtNbnJIZDllSXo3WE9WNVY2Yll0b2FReGtWbWE2NWxvQmMzaG5YOFlEZTZo?=
 =?utf-8?B?eU41Z2U4cmdtMnlXZkM4RmtDZE1aU094cnhZZDZBemUyT3RRNW5HNWJCNWNt?=
 =?utf-8?B?K3llc0luV21odWI3RXAyTDd0Vm9kbDYwYjQ1cWdMQmQwd0d1L3B2eVNFU2xT?=
 =?utf-8?B?V2xubHBPOCtDL1R1YkMvamNobGlzOGFrbmxEYU1aYlBSaFEwS1FsaXBTdFV4?=
 =?utf-8?B?VGxOUDMrZW84QjZYZzZmVWhwazk1K0R5N2E3RzErN0Z1K1NZRCtOQ2dhb0Zt?=
 =?utf-8?B?SEJ3OGlwZm9QUXZJcjJwUWwrMisrZWF0OWNWcVllY29UZW9QVk01UzdEVHRt?=
 =?utf-8?B?RHhBQnhMVUFsTUxXdkhZNlNvdGxITnZnYldjSU9WZDRuU0VQdmltcGVKb3FL?=
 =?utf-8?B?dzZCbWt4WFRheFBFdWVsYk5YK3lSQm9lWjNTK1VqRHFFN1JuU2FxbXZlNENl?=
 =?utf-8?B?YkhEbmtaU3ovdm9tMDhYVVpWRWZUSXVZaVp4R1hRK21uMFlsNkw3T3FVK0Uz?=
 =?utf-8?B?bHo0VGtScDdGMlNwWjhENVhMeGFMb1k4V3dMekhYRllXcWJiRkhyNms1TEIy?=
 =?utf-8?B?akZDUkh3TUR0d09uMllMeDBBMmk4amNNUVNuM21sQml6cGY0SUVuOWJLK1dk?=
 =?utf-8?B?MmJPeVpnams1WkxhTUZ3N1FQSWVnWWd6NUxsbjZLM25nd0cydXR1YnVTVEUw?=
 =?utf-8?B?cksxN2Z0VTM2S2pQTHN5cW5ocHp6WWRPUk0vNktwd3VyQU9aWDdkVUJCRlEv?=
 =?utf-8?B?K1d2RWFZaEFTWUNreWtzRFpacmczWmlmelZhN0c2elpHTzlsa1BnbVZZY3U2?=
 =?utf-8?B?cUVHWnhManM0YnA1L0JQT2M1Ym50Rmc3b21TQjUwL1ZhTS8yaVNERVdMYXps?=
 =?utf-8?B?VjFIajV2M2lTb2pFSTJjTFRBblczQ2hjbTFOeFVmYlNMZENSN3gvVHRHS2Yw?=
 =?utf-8?B?ZzhVOWZJenJ5VjlVNDJiUEF0dURlenUvYkpWaW5vVXRoWG85S3NnWmtLL3ZZ?=
 =?utf-8?B?V2h4MHNkNU1sanREQU82YWNMczVtZklnU3dIZ0lDSDV2Qm9wb0ZrV2twUXNB?=
 =?utf-8?B?L1phaTZKVzBGWVBaZTBqQWhaMW4reEEyVHpQejUzekJWNFFPalFOcGxYY25x?=
 =?utf-8?B?bzU1Q2RZS2dDOE1malVZekRnYjUzd2xRRnQzVTJkNjI2dk5LZXhFL0xaMFhp?=
 =?utf-8?B?Ynl1dkpFOGVrVk1DM0ZNLzBod1dUaVBWZ3Jqd0oyZlE4SlpoL3Jaa282M1dR?=
 =?utf-8?B?TTczaUU3NitDZjUycy8rQ3kwdFpLZllIMy81WGRHQm4yTi9IOHc3aXg3c20w?=
 =?utf-8?B?STNTdC9meVZLeVR3L1R3ak43M3FmTEUvbDF5TkZ2dU9JZU5rZVBtMjVjSTY0?=
 =?utf-8?B?Y1VHMHZiTkdvbEdDM2N4M1IraVRJY3BQc3pVNnRvOFhiVUt1dkJKcm4vaU45?=
 =?utf-8?B?djRIU214YmdjU0plM01IaXByUzY0UzI1YmVCckM2MnhtVDYrd0xIUXRzMm9y?=
 =?utf-8?B?L3dRZ0Y2WGdRcFlkMFpGT0V4YklVY2cxZk4zNGpEc2dPOTZFNHBNM1lXRDJz?=
 =?utf-8?B?ZWJzQmRsZDhLMUtsVVNyQ2o4dU51QjhzcCs0QmVRVmtjbE5pWlJQQ2IvRERy?=
 =?utf-8?Q?EypdlWnv/Cze9eypOqg/13mJ+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6964970d-733d-4bf5-563d-08dca4e78481
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 16:02:24.7060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MnMMR8ToVYhrZBApLrtp/oDiuxmJmxWUlLqmFcC84VoCt7SHJVhytQHUbsCpHrlLrVWve7ruxEQihBR4NSxaPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4403
X-Proofpoint-GUID: HUvMHXP7Y4c1iBNaa3lDrMU39mVupnWw
X-Proofpoint-ORIG-GUID: HUvMHXP7Y4c1iBNaa3lDrMU39mVupnWw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_10,2024-07-11_01,2024-05-17_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5pa2l0YSBTaHViaW4gdmlh
IEI0IFJlbGF5DQo+IDxkZXZudWxsK25pa2l0YS5zaHViaW4ubWFxdWVmZWwubWVAa2VybmVsLm9y
Zz4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDE1LCAyMDI0IDI6MDggUE0NCj4gVG86IEhhcnRsZXkg
U3dlZXRlbiA8aHN3ZWV0ZW5AdmlzaW9uZW5ncmF2ZXJzLmNvbT47IERhdmlkIFMuIE1pbGxlcg0K
PiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNv
bT47IEpha3ViDQo+IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFi
ZW5pQHJlZGhhdC5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBBbmRyZXcgTHVubg0KPiA8YW5kcmV3QGx1bm4uY2g+DQo+IFN1
YmplY3Q6ICBbUEFUQ0ggdjExIDE3LzM4XSBuZXQ6IGNpcnJ1czogYWRkIERUIHN1cHBvcnQgZm9y
IENpcnJ1cw0KPiBFUDkzeHgNCj4gDQo+IEZyb206IE5pa2l0YSBTaHViaW4gPG5pa2l0YS7igIpz
aHViaW5A4oCKbWFxdWVmZWwu4oCKbWU+IC0gYWRkIE9GIElEIG1hdGNoIHRhYmxlIC0NCj4gZ2V0
IHBoeV9pZCBmcm9tIHRoZSBkZXZpY2UgdHJlZSwgYXMgcGFydCBvZiBtZGlvIC0gY29weV9hZGRy
IGlzIG5vdyBhbHdheXMNCj4gdXNlZCwgYXMgdGhlcmUgaXMgbm8gU29DL2JvYXJkIHRoYXQgYXJl
bid0IC0gZHJvcHBlZCBwbGF0Zm9ybSBoZWFkZXIgU2lnbmVkLQ0KPiBvZmYtYnk6IE5pa2l0YSAN
Cj4gRnJvbTogTmlraXRhIFNodWJpbiA8bmlraXRhLnNodWJpbkBtYXF1ZWZlbC5tZT4NCj4gDQo+
IC0gYWRkIE9GIElEIG1hdGNoIHRhYmxlDQo+IC0gZ2V0IHBoeV9pZCBmcm9tIHRoZSBkZXZpY2Ug
dHJlZSwgYXMgcGFydCBvZiBtZGlvDQo+IC0gY29weV9hZGRyIGlzIG5vdyBhbHdheXMgdXNlZCwg
YXMgdGhlcmUgaXMgbm8gU29DL2JvYXJkIHRoYXQgYXJlbid0DQo+IC0gZHJvcHBlZCBwbGF0Zm9y
bSBoZWFkZXINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5pa2l0YSBTaHViaW4gPG5pa2l0YS5zaHVi
aW5AbWFxdWVmZWwubWU+DQo+IFRlc3RlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5k
ZXIuc3ZlcmRsaW5AZ21haWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQW5kcmV3IEx1bm4gPGFuZHJl
d0BsdW5uLmNoPg0KPiBSZXZpZXdlZC1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBs
aW5hcm8ub3JnPg0KDQpUaGlzIHBhdGNoIHNlZW1lZCB0byBiZSBmb3IgbmV0LW5leHQsIGluIGNh
c2UgTkVULCBGaXhlcyB0YWcgaXMgcmVxdWlyZWQuIFBsZWFzZSBjaGVjay4NCg0KPiAtLS0NCj4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2NpcnJ1cy9lcDkzeHhfZXRoLmMgfCA2MyArKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0NCj4gLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRp
b25zKCspLCAzMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9jaXJydXMvZXA5M3h4X2V0aC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2ly
cnVzL2VwOTN4eF9ldGguYw0KPiBpbmRleCAxZjQ5NWNmZDc5NTkuLjI1MjNkOWM5ZDFiOCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2lycnVzL2VwOTN4eF9ldGguYw0KPiAr
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jaXJydXMvZXA5M3h4X2V0aC5jDQo+IEBAIC0xNiwx
MyArMTYsMTIgQEANCj4gICNpbmNsdWRlIDxsaW51eC9ldGh0b29sLmg+DQo+ICAjaW5jbHVkZSA8
bGludXgvaW50ZXJydXB0Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlcGFyYW0uaD4NCj4g
KyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rldmlj
ZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaW8u
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+IA0KPiAtI2luY2x1ZGUgPGxpbnV4L3Bs
YXRmb3JtX2RhdGEvZXRoLWVwOTN4eC5oPg0KPiAtDQo+ICAjZGVmaW5lIERSVl9NT0RVTEVfTkFN
RQkJImVwOTN4eC1ldGgiDQo+IA0KPiAgI2RlZmluZSBSWF9RVUVVRV9FTlRSSUVTCTY0DQo+IEBA
IC03MzgsMjUgKzczNyw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbmV0X2RldmljZV9vcHMNCj4g
ZXA5M3h4X25ldGRldl9vcHMgPSB7DQo+ICAJLm5kb19zZXRfbWFjX2FkZHJlc3MJPSBldGhfbWFj
X2FkZHIsDQo+ICB9Ow0KPiANCj4gLXN0YXRpYyBzdHJ1Y3QgbmV0X2RldmljZSAqZXA5M3h4X2Rl
dl9hbGxvYyhzdHJ1Y3QgZXA5M3h4X2V0aF9kYXRhICpkYXRhKSAtew0KPiAtCXN0cnVjdCBuZXRf
ZGV2aWNlICpkZXY7DQo+IC0NCj4gLQlkZXYgPSBhbGxvY19ldGhlcmRldihzaXplb2Yoc3RydWN0
IGVwOTN4eF9wcml2KSk7DQo+IC0JaWYgKGRldiA9PSBOVUxMKQ0KPiAtCQlyZXR1cm4gTlVMTDsN
Cj4gLQ0KPiAtCWV0aF9od19hZGRyX3NldChkZXYsIGRhdGEtPmRldl9hZGRyKTsNCj4gLQ0KPiAt
CWRldi0+ZXRodG9vbF9vcHMgPSAmZXA5M3h4X2V0aHRvb2xfb3BzOw0KPiAtCWRldi0+bmV0ZGV2
X29wcyA9ICZlcDkzeHhfbmV0ZGV2X29wczsNCj4gLQ0KPiAtCWRldi0+ZmVhdHVyZXMgfD0gTkVU
SUZfRl9TRyB8IE5FVElGX0ZfSFdfQ1NVTTsNCj4gLQ0KPiAtCXJldHVybiBkZXY7DQo+IC19DQo+
IC0NCj4gLQ0KPiAgc3RhdGljIHZvaWQgZXA5M3h4X2V0aF9yZW1vdmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikgIHsNCj4gIAlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2Ow0KPiBAQCAtNzg2
LDI3ICs3NjYsNDcgQEAgc3RhdGljIHZvaWQgZXA5M3h4X2V0aF9yZW1vdmUoc3RydWN0DQo+IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICBzdGF0aWMgaW50IGVwOTN4eF9ldGhfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgIHsNCj4gLQlzdHJ1Y3QgZXA5M3h4X2V0aF9k
YXRhICpkYXRhOw0KPiAgCXN0cnVjdCBuZXRfZGV2aWNlICpkZXY7DQo+ICAJc3RydWN0IGVwOTN4
eF9wcml2ICplcDsNCj4gIAlzdHJ1Y3QgcmVzb3VyY2UgKm1lbTsNCj4gKwl2b2lkIF9faW9tZW0g
KmJhc2VfYWRkcjsNCj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KDQpTbWFsbCBuaXQsIHBs
ZWFzZSBjaGVjayBpZiByZXZlcnNlIHgtbWFzIHRyZWUgb3JkZXIgbmVlZCB0byBiZSBmb2xsb3cg
aGVyZS4NCg0KPiArCXUzMiBwaHlfaWQ7DQo+ICAJaW50IGlycTsNCj4gIAlpbnQgZXJyOw0KPiAN
Cg0KLi4uDQoNCj4gIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGVwOTN4eF9ldGhfZHJp
dmVyID0gew0KPiAgCS5wcm9iZQkJPSBlcDkzeHhfZXRoX3Byb2JlLA0KPiAgCS5yZW1vdmVfbmV3
CT0gZXA5M3h4X2V0aF9yZW1vdmUsDQo+ICAJLmRyaXZlcgkJPSB7DQo+ICAJCS5uYW1lCT0gImVw
OTN4eC1ldGgiLA0KPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBlcDkzeHhfZXRoX29mX2lkcywNCj4g
IAl9LA0KPiAgfTsNCj4gDQo+IA0KPiAtLQ0KPiAyLjQzLjINCj4gDQo+IA0KDQo=


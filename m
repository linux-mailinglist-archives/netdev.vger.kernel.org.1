Return-Path: <netdev+bounces-156286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD414A05DDF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EC13A5A25
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F452D613;
	Wed,  8 Jan 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="hX5MAB8H"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82037DA6A;
	Wed,  8 Jan 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344990; cv=fail; b=F/zvULfEGsocdm1bTGcXs4D1qgN+Rf2hH+kRaCafTVJQ2ebn+0dbwx/5SwzmFzT11y6QtffRVIhL9EY+nLzXEgiXgrz9ZRfBirt4aYu9H5l410Q5i6MqR8qQ0OsApfRuJv1JIHHO7cnj9zSpGYW6tqQ6+vEEXm5xiNuMwcdA26w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344990; c=relaxed/simple;
	bh=1WwDUfa1S0ZbgOcmxZWLlygPtl++ZyuqQf4QrCqCbP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDyzrm3InYyommz23iEM/iHFtf66lLHjhjM2qAoCQDY4YrVfmxgRptOPxYz8zFJ9zpal9mdoFUnWuag7ub9HZnE34a6kJeteMIe+szaYmXAjfRxuAcLaTLLCv2cxTKKvoLki37pMuDdl0KDR3SspDY6nk6NAQ3q4vQVLrH3f+no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=hX5MAB8H; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508CclQa027891;
	Wed, 8 Jan 2025 06:02:49 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 441shqg4fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 06:02:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vi+mB6XP9A1ajmk1S3dO09om60N8sFzcKRZ48j180NkLnG9St964o/1S6hATNCDxi8s9kos+YYDO0Pf5U1/MYA4zPaew+6qnpEoFYAVSvnxPF35chyyNQS+WPKXO+0DErZEysia23OleAXLr1wKixXSoXWZzYsoTkMPLBnUB9tBIun/X+mXa1DP79UeIqGIwD9KDmoh4LmZWCOPbE5RxPW7aDp8xPIcBupm7Bhj7qY7mQIS5JL4ZZu9Mqvj6BLgHTh6bcb+W3t34wVuqnH8Vq+kTkC249kYZaoR+sqLXT7h8yKIJkleGOzVy7zO2hduT4ZY+R5ekXkHaL43Cg3rmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WwDUfa1S0ZbgOcmxZWLlygPtl++ZyuqQf4QrCqCbP4=;
 b=E2QefT+9Rt/UMOXXALCLfoHy0ZERRJTQntzF33K71oJOP8J+OZPpX3ZgBp2X8gqyrRXa7YpjllitJi6RGrK5XLJ11tz/NrNTY4SWyCTilhyzwRQzJXthEtcOz0F14/fp9i5xH5MRGBip7+a3ak9LiGicpPCul5shcWP+h5pPbLbQQw9H1+FRp/dnvgV8PX+9ZAoFJ5Xeq/Vzg6O9vK6zGVEYWKgwvyoh08t6eJgUR9q3iCLIj6LVi1jXKAuBGHXLayf9dWuoMsCtOkD9vb5gX67cf5329FISeSI/PIRrYfIX+I80lUpG3gJROFwPF3ffR7UqJauKaDFnT98p1ESdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WwDUfa1S0ZbgOcmxZWLlygPtl++ZyuqQf4QrCqCbP4=;
 b=hX5MAB8HPrdrlyzOgQBwdl3WvBDfpvFJLD8Ts5V9bsXJ7a2H10hMRdozuBBuUjodfTvVom5zVtflTFN6XbEVVQMlXtozW83QMsldbXwidoXTh45jAITHZTStDW6XXa6YVVRUBV4MgH1Kiaix0vDds2iZcA0Hzf4iGIi4Y0eN5ew=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by PH7PR18MB5354.namprd18.prod.outlook.com (2603:10b6:510:24d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 14:02:44 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 14:02:44 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH 2/6] octeontx2-pf: AF_XDP zero
 copy receive support
Thread-Topic: [EXTERNAL] Re: [net-next PATCH 2/6] octeontx2-pf: AF_XDP zero
 copy receive support
Thread-Index: AQHbYPF34G4ehvpqPESleVPQAVv3ELMLYIoAgAF3xXA=
Date: Wed, 8 Jan 2025 14:02:44 +0000
Message-ID:
 <SJ0PR18MB5216FB752575EE9CD64225ECDB122@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250107104628.2035267-1-sumang@marvell.com>
 <20250107104628.2035267-3-sumang@marvell.com>
 <20250107143410.GA5872@kernel.org>
In-Reply-To: <20250107143410.GA5872@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|PH7PR18MB5354:EE_
x-ms-office365-filtering-correlation-id: 8d2b9ff9-a371-4c77-eedb-08dd2fed1ff8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0h0YzlzMnN2QUwrNDZpRUY3SjNEMmR1VXRNeXVYZDByZEFNQUZOTEFMTGNs?=
 =?utf-8?B?SVRBTUUrdkpvL1pxdXpGRG5JcWxpRGRSdkMyZms3bkxkZC9JMU1wc2wvOUlu?=
 =?utf-8?B?VXZjdTVMNTRvSTc4Nk1POFJNd3M4K1A0bVZwQkpRTGdBMGZFc242elI4dU9v?=
 =?utf-8?B?RUZSVEd4MTVHVC9PbDY5d05ZbnRtUVdSRU9sYkZseUhqdUtGN2Zlb0xSWnZq?=
 =?utf-8?B?V2twYWpZcFNMYlMyR3ZXbStucnZOc3ZoSXdiTWxrTUxZS1hSb0phcU1xODRX?=
 =?utf-8?B?aUljV1FUOU95aTN6NTNZMkZESkd6UnM1eXhoU1drYUk3MitJaXpVbVZSRC91?=
 =?utf-8?B?WkZDU1BoTXhobVJFZHV2bUQ1WStxTmRkYlRoeUlKZ3hLM3pndDZqZTF2VXcw?=
 =?utf-8?B?ak1XS21zWk9FOW5ZOFoyTThOb0JDNmpYNzhXdGRneXdpcFVJMTVGU2gxUGlw?=
 =?utf-8?B?NHVMKzVxQ1Q1TGo4aW1FZVdoOW1WK1pBQ0JKVTNCeHdHUnh4WmpvaGRBaTFq?=
 =?utf-8?B?aW84a3BQamVDMkZBSXhidlRyQU0zWHZOMER0akNNbGpJNlhmZmJ6cWtjS3Mr?=
 =?utf-8?B?WTAyZllvc2wwZHYrelhBYmpKRGVIS3FyRll5WlhMbmJYdzU4RktnZzRCQytJ?=
 =?utf-8?B?VmF0dDN1K0NLMlRVTkRuMGEwc05NN2VSYkViWkNZNEx3UHBWZkZTWlJpcEpD?=
 =?utf-8?B?SXU4bk9RdkNxZDdrcWJtNjdrNWlla29aZXoyK1hscld1V0g1Ui9YUXVNRU4z?=
 =?utf-8?B?R1VJT2pIV01YMEtnVFBGdHJlTFh5MEJPS2Q4aXNON3IzbjRSeWFKb2hsTGZL?=
 =?utf-8?B?eXdZTHdMM3BLL0NTMWlPWUpQYnI0M29qZUtvcE9wWXVFU1JTZldrd1IwUGFl?=
 =?utf-8?B?SHp5eEpua0crY3lZTkZTWmhwd0VwVkpxdTFCQVRRVUVPL29yRmFLVWpFb21H?=
 =?utf-8?B?bG53RlRqSlQ5RmlTbktNQVdTMUhuRjk5MzFlVUtmMFkzK2Y4UVIzTmR5aWJK?=
 =?utf-8?B?V0R5TmIxYStUb3FIbEJvd3JFVlVvUTFScHYzVFdBTjA0QlhLTWtJZG4zbHJh?=
 =?utf-8?B?RkRybjNVYmI0elBqTkZ5dkZ1V3RaWWN1NldSTTEydVA0R3NYT2dJUTJ3ZWI2?=
 =?utf-8?B?ZVNQbXNlTy92cEV6UVlLOXVIMCtVdGhrSVQ2NUlDMkxROVE3MW4xVmovblU1?=
 =?utf-8?B?SkhWT2tacFV2M09FSW5PZHdZaC9oYVY2R0g0Zlhnc2g2VVhaenVHVFVIbFpk?=
 =?utf-8?B?Q1hLV0N6ZWJ2VnlPdFlFYk1KTXR2a1Y3YWNYVTQxWFFZTFJXa2NpTDRMbFJx?=
 =?utf-8?B?bUNUMG5mSWhKa0ticWhBaEJ6cldTWnVMczRONVhoaFNmV1dyZkh5L3hsTHlK?=
 =?utf-8?B?R2VTUFVTdGtxQlFKeTViZTQyRkdoQytkaThQZTVPZHVHNTF4d0RNQ1dybG5Z?=
 =?utf-8?B?emo5Q1pCdGgxWlgwazFtUk1oZWpwV2FTM0ZDZGtKK2d3R2pabUQxVk5CVlFo?=
 =?utf-8?B?WlJDYU5HN0FIQzVLSVZvUFJXc0c5eXlWNDNPT3hVOXBiRnRpSDQxcGIrclZ4?=
 =?utf-8?B?OG1XZy9sKzFucVNOQ2pxOUMxY1I2RnBrN3JRWThDWENwUWoxOUtpbm5oZU5N?=
 =?utf-8?B?NDBnTG04S1h2amxiUGlhOUFLTWhhUldGNjZveVVkZ1BpdWVlUnJIRWhvY1Fn?=
 =?utf-8?B?VDhMc05BaGpIWjRRMjFMd2d2UjV2Tml6ZlFzY1FBZDRtZHN3V2U3azBVZDBD?=
 =?utf-8?B?Wld0ZjBJcElxSkhFKzNVZ0swY0tWa3oxWER5V2c2dDRNb09TSU9sK25tY0VI?=
 =?utf-8?B?ZjF5cnpuSjFjT0lpaXlLTHVNdG5pSUxaUjF6OERsWG91RjBJN1NJT1VHZjhq?=
 =?utf-8?B?dmN6b2o4RHIxOFF1QXdMcldqUE9IRWpiZmlDSUZnYXVReTZuaE5zLzRwOTJE?=
 =?utf-8?Q?sb+iaWkYZZmVlWdYlPw5uvIJI8acC4SZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2Q5NmlySHFidmo4MllrUmdzbmNrS3llcmZXVGIvK3lnM2RKUmdmZWtseC9D?=
 =?utf-8?B?blZiRFoxcjJxSXEyK1BYdFh3amJtYVlGZHFhNDUvSEl0Q25ZWTJkQmNack41?=
 =?utf-8?B?V285Zi9OV3liL0J2ZW9MUi9UVnVlb0liMzRITEJxSTJSMlg0RFVpWTd5L1Z6?=
 =?utf-8?B?c1pFWEsxOXlaRnZYeDY3TnNOMUFnRXo2VnNJYXlZQlMwSHVCdXEwK0JLNUJr?=
 =?utf-8?B?QzhBRFk5eGNNcTRBVWNmcVRNSkVvZWF6Z2ZKcmE1Z3cvQ2FVcGk4MzNZeGhR?=
 =?utf-8?B?dkdlRVVtVmJrOXdNaUpmZ01Icys2TmZrRmpCa014eERGVlhxQldBbytESG9D?=
 =?utf-8?B?ZUFhY3Y3a0hlc291QlZ2clhha2UzSm1xRmNNMVkwSmFhaC81bmwxalZDRTk3?=
 =?utf-8?B?VmgrZVBrVUNUYzNuZjdZTVE5YlpxVmVPcEMyRE1qM0RVWE5HTGVxdWNST2pH?=
 =?utf-8?B?ZXVYRGwwZVdnNjJUc2Q5YlZMSjVCckp6TGl4Zk5JbjJ3clJBZUNBKzdXYUti?=
 =?utf-8?B?RFROaEdEZ0dWb1NqZGhNU3hvSmJSb25iLzZ5SzhSV3liVlQ2YktXTUtyY0RZ?=
 =?utf-8?B?b051MzB0R05GelZndS9ENjhQS3ZoTW45KzFycXFiS05aeFNsTkRsYVY4a1V4?=
 =?utf-8?B?Vks1MGsrbnJBTXErVFFzMzVCS0ZGaGFMK2FlSlFQYW14VHFKR01ydVV2dGdR?=
 =?utf-8?B?NExBNXlXSnJUb0hJNnR5MTVvT1J4RXZ4LytOc3BlNGZ0cXZkbXlIMXN6MXEy?=
 =?utf-8?B?QWhHS0F2TGJzUjlFMU5UbWFIT3ZrbzBOakxYVjBPMG4xc1E5UWtFaGpWTDYy?=
 =?utf-8?B?ajN4aTRFcWd0Y0QwTXgxaDNoaVRjTnFaaXhwb2h4K0RIdTRHZ1Fpa0hSbmQx?=
 =?utf-8?B?RU5uQW9VTGt2V080T09vdkNuU0ppVW1RbFZiQnc1YVNWM1ZJOXgyMkRDSVQx?=
 =?utf-8?B?M0tkdXpqWjlWOVFEMzVhK1FRRit2ZnFWT2pzOFBuc0pZTVpRS3F2TmxobEwr?=
 =?utf-8?B?enVaUnlZRXZ2WlpzRDNYazdLNkxla1lBKzZwOEg4MFl1cG9JVWJZVGl6OGRp?=
 =?utf-8?B?aHp4Y0tJU1ZGdzR2RVZiaVM0emEycjZZa2FhNU5GUmQrVUxPL2dYbXlLWFZJ?=
 =?utf-8?B?QmpJUHVkVXdoaEtXRzVFNUp0SXc5Zy9uSTM4cm9HRGFZcU1KUTA2UTdSbTA4?=
 =?utf-8?B?QkViVldqRlZ3QTUrR09URGF2MEtLMnZhWHkxN3p0Q1dmb0xSMGx4MUIvQ0tC?=
 =?utf-8?B?RWRGQUphaFpzTTVOU2F5ZUdtR1JtV0U0Vy85dTZvWlArMVNpUThsQmpsK0N4?=
 =?utf-8?B?L0pUdVdpdVE3YVlUQnAxNFJWMmFFeXcwUGNwQWtRaCtibGJJVFpTYWd0R3pC?=
 =?utf-8?B?TWVlTzRFcGc3Vm1mZzl6RHpLdVYyRnZoaWx4NUdFT3Q5bWxmUklreUFmWjVy?=
 =?utf-8?B?ZHBXcEViaVJBL2YwNG9paUxQaGpIWGx4OUNqTm5tMElTUTVmbkFHNkVCUkFz?=
 =?utf-8?B?NXZtcFVEYSs3dFdDN1NIQTNjT1pkTDhoU1ArQUVmQkpDazNwTkRBZmtnMVpW?=
 =?utf-8?B?cGFVUnhlMTl2N1lLd2hlS2dXQnhxYkZQNXNFZ2hzN3RXSTNWNm9WdzU0bHNC?=
 =?utf-8?B?VWtqM2t2SDNWMjRFVldwL2pvMEthdGl5YnpsczJKbnFTQitZL001UHRoUmVG?=
 =?utf-8?B?cGpBRVhXOGtXdng2OXNpRzlKbGROc0ZTT0FqTFV5YWRBdDhxRXk4SHhnV3c5?=
 =?utf-8?B?SVl1SU9aWnBFL1FZZEtscXAxRVFWbS9LanlIbWRwMlFhUm8yeStJSG1GZW5H?=
 =?utf-8?B?Q1pFNGxkVHpHekdNM0ZVcXJEamVHR1hMTVExSnNyZlRvZjd1dXdkV1YvbVNY?=
 =?utf-8?B?Q25YQXVQVk9ORVBDYitpRW83RmVGNWxMOGhRR3YzOHJtblArb1BWZTFIV09l?=
 =?utf-8?B?NU4yd0RJK0FhNlRwL0VxUkRuSjRuUmNUZFd0dVR6SEhNRGw4b3hDeUVYV3Qw?=
 =?utf-8?B?SnJqWXQ3Ni9NUmxFNDhsUGdBUXE0N04xQXVtdko4SVkvNytrTUozRFJ2cDZW?=
 =?utf-8?B?dUxyRHRnOW02eTY4UkNYbHlMZXIzb2w5WGZyMVJhUXRWMjhqcXJGODh0UHdT?=
 =?utf-8?Q?oN95bT80GkmDu9d28NKQMo4vd?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2b9ff9-a371-4c77-eedb-08dd2fed1ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 14:02:44.6060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMR8MitZwlIvhXAE+U2QVSKgJ1vCB6947EISK8MzRSRcG2O+6LcKnrL7L/f8HFYNn5CSafiET8KohsV7zeQPbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5354
X-Proofpoint-ORIG-GUID: gSqCUUPmQpp-57GCsozk2zwvW_C4CnhS
X-Proofpoint-GUID: gSqCUUPmQpp-57GCsozk2zwvW_C4CnhS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

SGkgU2ltb24sDQoNCg0KPj4gQEAgdm9pZCBvdHgyX2ZyZWVfYXVyYV9wdHIoc3RydWN0IG90eDJf
bmljICpwZnZmLCBpbnQgdHlwZSkNCj4+DQo+PiAgCS8qIEZyZWUgU1FCIGFuZCBSUUIgcG9pbnRl
cnMgZnJvbSB0aGUgYXVyYSBwb29sICovDQo+PiAgCWZvciAocG9vbF9pZCA9IHBvb2xfc3RhcnQ7
IHBvb2xfaWQgPCBwb29sX2VuZDsgcG9vbF9pZCsrKSB7DQo+PiAtCQlpb3ZhID0gb3R4Ml9hdXJh
X2FsbG9jcHRyKHBmdmYsIHBvb2xfaWQpOw0KPj4gIAkJcG9vbCA9ICZwZnZmLT5xc2V0LnBvb2xb
cG9vbF9pZF07DQo+PiArCQlpb3ZhID0gb3R4Ml9hdXJhX2FsbG9jcHRyKHBmdmYsIHBvb2xfaWQp
Ow0KPj4gIAkJd2hpbGUgKGlvdmEpIHsNCj4+ICAJCQlpZiAodHlwZSA9PSBBVVJBX05JWF9SUSkN
Cj4+ICAJCQkJaW92YSAtPSBPVFgyX0hFQURfUk9PTTsNCj4+IEBAIC0xMzIzLDYgKzEzMzcsMTMg
QEAgdm9pZCBvdHgyX2ZyZWVfYXVyYV9wdHIoc3RydWN0IG90eDJfbmljICpwZnZmLA0KPmludCB0
eXBlKQ0KPj4gIAkJCWlvdmEgPSBvdHgyX2F1cmFfYWxsb2NwdHIocGZ2ZiwgcG9vbF9pZCk7DQo+
PiAgCQl9DQo+PiAgCX0NCj4+ICsNCj4+ICsJZm9yIChpZHggPSAwIDsgaWR4IDwgcG9vbC0+eGRw
X2NudDsgaWR4KyspIHsNCj4+ICsJCWlmICghcG9vbC0+eGRwW2lkeF0pDQo+PiArCQkJY29udGlu
dWU7DQo+PiArDQo+PiArCQl4c2tfYnVmZl9mcmVlKHBvb2wtPnhkcFtpZHhdKTsNCj4+ICsJfQ0K
Pg0KPkxvb2tpbmcgb3ZlciBvdHgyX3Bvb2xfaW5pdCgpLCBJIGFtIHdvbmRlcmluZyBpZiB0aGUg
bG9vcCBhYm92ZSBydW4NCj5zaG91bGQgb3ZlciBhbGwgKG5vbiBBVVJBX05JWF9SUSkgcG9vbHMs
IHJhdGhlciB0aGFuIHRoZSBsYXN0IHBvb2wNCj5jb3ZlcmVkIGJ5IHRoZSBwcmVjZWRpbmcgbG9v
cC4NCltTdW1hbl0gWWVzLCB5b3UgYXJlIHJpZ2h0LiBUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMs
IHdpbGwgdXBkYXRlIGluIHYyLg0KPg0KPlRoaXMgd2FzIGZsYWdnZWQgYnkgU21hdGNoLCBiZWNh
dXNlIGl0IGlzIGNvbmNlcm5lZCB0aGF0IHBvb2wgbWF5IGJlDQo+dXNlZCB1bnNldCBhYm92ZSwg
cHJlc3VtYWJseSBpZiB0aGUgcHJlY2VkaW5nIGxvb3AgaXRlcmF0ZXMgemVybyB0aW1lcw0KPihJ
J20gdW5zdXJlIGlmIHRoYXQgY2FuIGhhcHBlbiBpbiBwcmFjdGljZSkuDQpbU3VtYW5dIFdpbGwg
dXBkYXRlIHRoZSBsb2dpYyBpbiB2Mi4NCj4NCj4uLi4NCj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5jDQo+PiBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3BmLmMNCj4NCj4u
Li4NCj4NCj4+IEBAIC0zMjA0LDYgKzMxOTksMTAgQEAgc3RhdGljIGludCBvdHgyX3Byb2JlKHN0
cnVjdCBwY2lfZGV2ICpwZGV2LA0KPmNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkNCj4+
ICAJLyogRW5hYmxlIGxpbmsgbm90aWZpY2F0aW9ucyAqLw0KPj4gIAlvdHgyX2NneF9jb25maWdf
bGlua2V2ZW50cyhwZiwgdHJ1ZSk7DQo+Pg0KPj4gKwlwZi0+YWZfeGRwX3pjX3FpZHggPSBiaXRt
YXBfemFsbG9jKHFjb3VudCwgR0ZQX0tFUk5FTCk7DQo+PiArCWlmICghcGYtPmFmX3hkcF96Y19x
aWR4KQ0KPj4gKwkJZ290byBlcnJfcGZfc3Jpb3ZfaW5pdDsNCj4+ICsNCj4NCj5UaGlzIGdvdG8g
d2lsbCByZXN1bHQgaW4gdGhlIGZ1bmN0aW9uIHJldHVybmluZyBlcnIuDQo+SG93ZXZlciwgaGVy
ZSBlcnIgaXMgMC4gU2hvdWxkIGl0IGJlIHNldCB0byBhIG5lZ2F0aXZlIGVycm9yIHZhbHVlDQo+
aW5zdGVhZD8NCltTdW1hbl0gWWVzLCB3aWxsIHVwZGF0ZSBpbiB2Mg0KPg0KPj4gICNpZmRlZiBD
T05GSUdfRENCDQo+PiAgCWVyciA9IG90eDJfZGNibmxfc2V0X29wcyhuZXRkZXYpOw0KPj4gIAlp
ZiAoZXJyKQ0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0
ZW9udHgyL25pYy9vdHgyX3R4cnguYw0KPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxs
L29jdGVvbnR4Mi9uaWMvb3R4Ml90eHJ4LmMNCj4NCj4uLi4NCj4NCj4+IEBAIC01NzEsNiArNTc0
LDcgQEAgaW50IG90eDJfbmFwaV9oYW5kbGVyKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwNCj5p
bnQgYnVkZ2V0KQ0KPj4gIAkJaWYgKHBmdmYtPmZsYWdzICYgT1RYMl9GTEFHX0FEUFRWX0lOVF9D
T0FMX0VOQUJMRUQpDQo+PiAgCQkJb3R4Ml9hZGp1c3RfYWRhcHRpdmVfY29hbGVzZShwZnZmLCBj
cV9wb2xsKTsNCj4+DQo+PiArCQlwb29sID0gJnBmdmYtPnFzZXQucG9vbFtjcS0+Y3FfaWR4XTsN
Cj4NCj5JIGFtIGFsc28gdW5zdXJlIGlmIHRoaXMgY2FuIGhhcHBlbiBpbiBwcmFjdGljZSwgYnV0
IFNtYXRjaCBpcyBjb25jZXJuZWQNCj50aGF0IGNxIG1heSBiZSB1c2VkIHVuaW5pdGlhbGlzZWQg
aGVyZS4gSXQgZG9lcyBzZWVtIHRoYXQgY291bGQNCj50aGVvcmV0aWNhbGx5IGJlIHRoZSBjYXNl
IGlmLCBpbiB0aGUgZm9yIGxvb3AgdG93YXJkcyB0aGUgdG9wIG9mIHRoaXMNCj5mdW5jdGlvbiwg
Y3FfcG9sbC0+Y3FfaWRzW2ldIGlzIGFsd2F5cyBDSU5UX0lOVkFMSURfQ1EuDQo+DQo+PiAgCQlp
ZiAodW5saWtlbHkoIWZpbGxlZF9jbnQpKSB7DQo+PiAgCQkJc3RydWN0IHJlZmlsbF93b3JrICp3
b3JrOw0KPj4gIAkJCXN0cnVjdCBkZWxheWVkX3dvcmsgKmR3b3JrOw0KPg0KPi4uLg0KPg0KPj4g
QEAgLTE0MjYsMTMgKzE0NDAsMjQgQEAgc3RhdGljIGJvb2wgb3R4Ml94ZHBfcmN2X3BrdF9oYW5k
bGVyKHN0cnVjdA0KPm90eDJfbmljICpwZnZmLA0KPj4gIAl1bnNpZ25lZCBjaGFyICpoYXJkX3N0
YXJ0Ow0KPj4gIAlzdHJ1Y3Qgb3R4Ml9wb29sICpwb29sOw0KPj4gIAlpbnQgcWlkeCA9IGNxLT5j
cV9pZHg7DQo+PiAtCXN0cnVjdCB4ZHBfYnVmZiB4ZHA7DQo+PiArCXN0cnVjdCB4ZHBfYnVmZiB4
ZHAsICp4c2tfYnVmZiA9IE5VTEw7DQo+PiAgCXN0cnVjdCBwYWdlICpwYWdlOw0KPj4gIAl1NjQg
aW92YSwgcGE7DQo+PiAgCXUzMiBhY3Q7DQo+PiAgCWludCBlcnI7DQo+Pg0KPj4gIAlwb29sID0g
JnBmdmYtPnFzZXQucG9vbFtxaWR4XTsNCj4+ICsNCj4+ICsJaWYgKHBvb2wtPnhza19wb29sKSB7
DQo+PiArCQl4c2tfYnVmZiA9IHBvb2wtPnhkcFstLWNxLT5yYnBvb2wtPnhkcF90b3BdOw0KPj4g
KwkJaWYgKCF4c2tfYnVmZikNCj4+ICsJCQlyZXR1cm4gZmFsc2U7DQo+PiArDQo+PiArCQl4c2tf
YnVmZi0+ZGF0YV9lbmQgPSB4c2tfYnVmZi0+ZGF0YSArIGNxZS0+c2cuc2VnX3NpemU7DQo+PiAr
CQlhY3QgPSBicGZfcHJvZ19ydW5feGRwKHByb2csIHhza19idWZmKTsNCj4+ICsJCWdvdG8gaGFu
ZGxlX3hkcF92ZXJkaWN0Ow0KPg0KPmlvdmEgaXMgbm90IGluaXRpYWxpc2VkIHVudGlsIGEgZmV3
IGxpbmVzIGZ1cnRoZXIgZG93biwgd2hpY2ggZG9lcyBub3QNCj5vY2N1ciBpbiB0aGUgY2FzZSBv
ZiB0aGlzIGNvbmRpdGlvbi4JDQpbU3VtYW5dIEkgdGhpbmsgdGhlIHBhdGNoIG9yZGVyaW5nIGlz
IHdyb25nLiANCiJwYXRjaCM0OiBvY3Rlb250eDItcGY6IERvbid0IHVubWFwIHBhZ2UgcG9vbCBi
dWZmZXIgdXNlZCBieSBYRFAiIGlzIGZpeGluZyB0aGlzLiBJIHdpbGwgdXBkYXRlIHRoZSBwYXRj
aCBvcmRlci4NCj4NCj4+ICsJfQ0KPj4gKw0KPj4gIAlpb3ZhID0gY3FlLT5zZy5zZWdfYWRkciAt
IE9UWDJfSEVBRF9ST09NOw0KPj4gIAlwYSA9IG90eDJfaW92YV90b19waHlzKHBmdmYtPmlvbW11
X2RvbWFpbiwgaW92YSk7DQo+PiAgCXBhZ2UgPSB2aXJ0X3RvX3BhZ2UocGh5c190b192aXJ0KHBh
KSk7IEBAIC0xNDQ1LDYgKzE0NzAsNyBAQCBzdGF0aWMNCj4+IGJvb2wgb3R4Ml94ZHBfcmN2X3Br
dF9oYW5kbGVyKHN0cnVjdCBvdHgyX25pYyAqcGZ2ZiwNCj4+DQo+PiAgCWFjdCA9IGJwZl9wcm9n
X3J1bl94ZHAocHJvZywgJnhkcCk7DQo+Pg0KPj4gK2hhbmRsZV94ZHBfdmVyZGljdDoNCj4+ICAJ
c3dpdGNoIChhY3QpIHsNCj4+ICAJY2FzZSBYRFBfUEFTUzoNCj4+ICAJCWJyZWFrOw0KPg0KPlRo
ZSBsaW5lcyBsaW5lcyBvZiB0aGlzIGZ1bmN0aW9uLCBiZXR3ZWVuIHRoZSBodW5rIGFib3ZlIGFu
ZCB0aGUgb25lDQo+YmVsb3cgbG9va3MgbGlrZSB0aGlzOg0KW1N1bWFuXSByZXBsaWVkIGFib3Zl
Lg0KPg0KPgljYXNlIFhEUF9UWDoNCj4JCXFpZHggKz0gcGZ2Zi0+aHcudHhfcXVldWVzOw0KPgkJ
Y3EtPnBvb2xfcHRycysrOw0KPgkJcmV0dXJuIG90eDJfeGRwX3NxX2FwcGVuZF9wa3QocGZ2Ziwg
aW92YSwNCj4NCj5UaGUgYWJvdmUgdXNlcyBpb3ZhLCBidXQgaW4gdGhlIGNhc2UgdGhhdCB3ZSBn
b3QgaGVyZSB2aWEgZ290bw0KPmhhbmRsZV94ZHBfdmVyZGljdCBpdCBpcyB1bmluaXRpYWxpc2Vk
Lg0KW1N1bWFuXSBzYW1lIGFzIGFib3ZlLg0KPg0KPi4uLg0KPg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3ZmLmMNCj4+IGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdmYuYw0KPj4g
aW5kZXggZTkyNmM2Y2U5NmNmLi45YmI3ZTVjM2UyMjcgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml92Zi5jDQo+PiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml92Zi5jDQo+PiBA
QCAtNzIyLDYgKzcyMiwxMCBAQCBzdGF0aWMgaW50IG90eDJ2Zl9wcm9iZShzdHJ1Y3QgcGNpX2Rl
diAqcGRldiwNCj5jb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpDQo+PiAgCWlmIChlcnIp
DQo+PiAgCQlnb3RvIGVycl9zaHV0ZG93bl90YzsNCj4+DQo+PiArCXZmLT5hZl94ZHBfemNfcWlk
eCA9IGJpdG1hcF96YWxsb2MocWNvdW50LCBHRlBfS0VSTkVMKTsNCj4+ICsJaWYgKCF2Zi0+YWZf
eGRwX3pjX3FpZHgpDQo+PiArCQlnb3RvIGVycl9zaHV0ZG93bl90YzsNCj4NCj5BbG9uZyB0aGUg
c2FtZSBsaW5lcyBvZiBteSBjb21tZW50IG9uIG90eDJfcHJvYmUoKToNCj5zaG91bGQgZXJyIGJl
IHNldCB0byBhIG5lZ2F0aXZlIGVycm9yIHZhbHVlIGhlcmU/DQpbU3VtYW5dIHllcywgd2lsbCB1
cGRhdGUgaW4gdjINCj4NCj4uLi4NCj4NCj4tLQ0KPnB3LWJvdDogY2hhbmdlcy1yZXF1ZXN0ZWQN
Cg==


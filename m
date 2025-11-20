Return-Path: <netdev+bounces-240301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE4DC724D8
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 07:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C836B4E1FB8
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 06:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC7288514;
	Thu, 20 Nov 2025 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="VoZ9O7g9";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="JqNnFJdD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F623212550;
	Thu, 20 Nov 2025 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763619109; cv=fail; b=tm/uglJJs3lqf9eGab+0MJlToN0cld34RPYjEbbrTHcpjNCTyp0iUZsEY27D/cF29bBr1gnNXQhv/95hyOjfoTmsRyNMSR2wX+lnDDsxR+xp6GsG3WozLUCn90lKccu4h0GtHGgEPBLOqbRjS8IrJIi2eLvsDxRBc2H84EXonRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763619109; c=relaxed/simple;
	bh=6wFJZCf6YETk6J0lbSjPjFCgG2/uZcPZLtVW/QIvmQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N6q21DUyZ4XRsO7DQYtCRRvxAHI8i1kWEnb3B6uqQwZPum9jy2J+nVKNYni0dR0XjLam0+DBML7wlKRQyC8R3Eifx50UOv+CnsxTPedjXeeGBhurP8izsFhgnAtsLqRazlE+qfjQxuJMG03IvLHp/XP4f3vfjvoaNRswhlnj6ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=VoZ9O7g9; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=JqNnFJdD; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJMV4l62508179;
	Wed, 19 Nov 2025 22:11:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=6wFJZCf6YETk6J0lbSjPjFCgG2/uZcPZLtVW/QIvm
	Qk=; b=VoZ9O7g9FR4IQDuJI5QRufbZDq60JQACmm9BSwBVxHniXjixmJTkWRX/r
	cRrdZA60S8/6fmaAikjwXn2mp+4g+/PfhsxXcKvJ0AXT06F/CTekiDIW+mnVYV/s
	sDYZNf7D5rpQi6/Vw3Rn7FtAukQo0qp7U3ezc9PwWYxhRkIbRlXOHUL6fQ/p4jQ6
	lHw/3/R5HGXFb7iuP7yGwjIpPnd55V8lkSklt7C/DjaJusos3EeCK2suSnthQ5tr
	nDROjU/zp78YPDDQF6o8hHzQX7T7rVQ3oPEJ1oHw7FDKZizwYMEdO/re1olkBDeR
	nJbHX5rbN+sO3Q54L4zIZkkXKPP0g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023124.outbound.protection.outlook.com [40.107.201.124])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ah3x53byu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 22:11:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqR5Uhez287+YIybP85RIsj5eKbbLO2ElUnMVQECbOzcqpxzb3KsVq/M89OfFS93rcg54nY+Jzx4uW1lkF2zOfUqN4CP2jgt/5Co0fNXEU4EyiCUwVmY4hRpz8+0dWQcd/xojzODK65KNVRjE7YgfQ3OGTLcq6Z381gm9C9fyZ0TCQIDHNbJQa0m+jrKnOLr2prLhsr5to3jOSxWv0Nnru8K7jKQpVhhVknKXZT6fBncABwhQDbiLTrmGISG06YK8lUVx6vs5NWvH7StUPdx+P/rq5HYfjgAlshdmMbsMvn2zhWL0Ag/S7EIubwi/bgOqd8KSc4sfPmgJL9cSyKguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wFJZCf6YETk6J0lbSjPjFCgG2/uZcPZLtVW/QIvmQk=;
 b=kcUni5k9YyeOTa2O4miKHfg+Et4V5irOUA3yzmVgflS15GxplNAIpWdOCyPf0xzbuNbPnir7xtkAommyAx71kJq3httXoaKp5bv5+AvdVUDgj9phxCcRCseMLijtb2I1baBSu9eozAjBweNuKWCg7Da1P3u0HatiB8V6rrSdr7CKDkaTkfqzW74AtDYiCsh2Ei4njilVyAnYGRO2wJIokH3e4xREPQ7JaeutGoQ4pZn6WtaiMjF6WhInyM9hNba/4vHuOMEi295zxTTydBDMErub2BOp9xFnUn3gRB8U0ZS4AbHie7c99Oaqln8gjH/DUg2qSwlHRbXP0kYRoFBjbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wFJZCf6YETk6J0lbSjPjFCgG2/uZcPZLtVW/QIvmQk=;
 b=JqNnFJdDYzkI/WAI881adyF2A9QWD6JC5UQdmFA4huC0IOKoM8gg8QdriD8Fge9C6w1k0NAccSDNg38CBKKFugW1pZ21+0f9MQi6w96m4+xWJkh4pk+4pE14m/SI/gCsBhflMzCwY/oCbBP15R5BePWX8nwtyKOSTh1tOyAde8Ui4ZOe2cG8CIF0Kafp1z9sslLhg1chaLSlc6JTOk1L9U5E48dBKuNNlZYTu7JpHwaW7ho0ficFHtA+jXzfOoORyhXAthfoW9ajvLoQGdeQ9UKtSunpQgInlniazIeZb7cLt/NnQ02JinCDTpPF8laSnkkARHdWoUihWTssvEw6+A==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by LV3PR02MB10235.namprd02.prod.outlook.com
 (2603:10b6:408:21e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 06:11:10 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 06:11:10 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jon Kohler <jonmkohler@icloud.com>
CC: Eric Dumazet <edumazet@google.com>, "Hudson, Nick" <nhudson@akamai.com>,
        Jason Wang <jasowang@redhat.com>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
Thread-Topic: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
Thread-Index: AQHcWcFhUQqtBOkli0a3kVsOu9uBaLT7FV8A
Date: Thu, 20 Nov 2025 06:11:10 +0000
Message-ID: <56FA5DD5-B2AD-4C3C-916E-6E703010DA9C@nutanix.com>
References: <20251106155008.879042-1-nhudson@akamai.com>
 <CACGkMEt1xybppvu2W42qWfabbsvRdH=1iycoQBOxJ3-+frFW6Q@mail.gmail.com>
 <5DBF230C-4383-4066-A4FB-56B80B42954E@akamai.com>
 <CANn89iK_v3CWvf7=QakbB3dwvJEOxuVjEn14rjmONaa1rKVWKw@mail.gmail.com>
 <7D7750CA-4637-4D4A-970C-CB1260E3ADBC@akamai.com>
 <CANn89iKr4LUSaXk_5p-cot6rxDngLJ8G6_F1eouF3mGRXdHhUg@mail.gmail.com>
 <AD5D3F27-9E32-4B18-97D8-762F0C3A9285@icloud.com>
 <CB96779A-3AFF-4374-B354-0420123D368E@nutanix.com>
In-Reply-To: <CB96779A-3AFF-4374-B354-0420123D368E@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|LV3PR02MB10235:EE_
x-ms-office365-filtering-correlation-id: 5b6d8ed4-724e-4e99-e0c1-08de27fb9a02
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2s3SVZlZ01nU3pXTU1wSEx2Qjk5V1U4SkJ2NXJsZXlEMHAwTzg0bXk4U2lN?=
 =?utf-8?B?b1NWOWp3cFpCWHI1UU9ESlkzRkgwam5UUVJLUCtveitJZUJIUDhheEF1REpJ?=
 =?utf-8?B?WVVQOVE4NXNJZFl6QVJodlFobjVHbUVWeG11YW9WRXlNc1lGWS8yUGowVTRz?=
 =?utf-8?B?VlE3R3lONm1tNndwUWsvanFJWVBsNWVNcmNITE84SFpOR2dKNGNOUHhZTFZU?=
 =?utf-8?B?cUlYeUlKYStWbDRFb1FJbmxlcG52S0JEY2psWnVVQ29XZklaU1ZjQWV3TXNu?=
 =?utf-8?B?aFFyYU14QnJwbGJ6L2hZdXpYNGhUb05JZXRibnVjb1grN2k1YllvRTh3Z0gr?=
 =?utf-8?B?cHhRRGZFZXZCUEpHS1U1MzJaR3c4MVBOMXFqWmhGcXprSE4xSXJrMkxJdGxt?=
 =?utf-8?B?eFNJT3U2SHRleTUvT08rdHFPemJRblVWN0FwQTlnZ3pncWpGMmFBcEMrMTBV?=
 =?utf-8?B?dHFzbHBOWGFXM21yV0loMEJZNmFudmFBallUNHBnNjNPYTdZYmIwalRWT1Iv?=
 =?utf-8?B?L2JoRHdnY0piZkFQWWR1Sjd3Z21ieFk5NFpaTXN3TWU1WXlCL3ZvUVRnejhG?=
 =?utf-8?B?VExqQW02Q0NRNU9vRlZxOGhrWHdBZDdKOUlhenRPYVlGcjlXM003SGxxallT?=
 =?utf-8?B?Q29OaVo1Q1dTbzFYTDlCSVVoNnd2V29QMGZDNHNQZlEyV1d1SHlkZ3VRYm02?=
 =?utf-8?B?RlErZE1oT0E2YUc5SmlyL2xQb0huOHRVb1BtZzVkZ1ZRdlRBN3NkV0dzODNC?=
 =?utf-8?B?Z05HU1MrMEhTdDdMWU9QbXBRNmYxMHBYcFpNcmF2N0tKWWtGRm1uOEMwc2Yv?=
 =?utf-8?B?UzhFSGhqSjZyWm9zaGFwcmNtcE1OaytYSmdhSTNjdy9sWnlrTGIyV2ZBZXZC?=
 =?utf-8?B?YTQxWGM1c1JBNWlkY1BLU2l5dXpNOTRoaktjT2N0NWVIU0xyYXVQK1lVK2NU?=
 =?utf-8?B?K2RWK1VGS2lEMmtpTWp3QlBHNkVJd3hZWjZxcndlYnp5VGs0OXZZajlVSVRu?=
 =?utf-8?B?TVhScEhDVHI4VElEcnNyTDdXWEV2NHBFWU1pc0RIdEJSZFQwQzYxeEZCTVJS?=
 =?utf-8?B?bFR2bXd6OEszU3VLNzMzeWx0ZFYxU1NGb1hzbldDdm96RUNKMURzQXRWeHhu?=
 =?utf-8?B?R3FvNTNxMDhxcjFTMVh3cG8wVnIrSit5TGtJaHRqTC9BZitRMmVOSzZmTXFW?=
 =?utf-8?B?aWc5dGlNUWtXeVIvMkU0dE5zdmxFQjJlZmhqdjJzR0c4anpUQVB5dktZN3FK?=
 =?utf-8?B?cG01Rko2dTlRVmV5MUlKdytNdGgrOUliVms0cWMwOStEUlVqeU9od0x5R1pH?=
 =?utf-8?B?VlV3NUUrOHZ1aUJESzFHK0NXS3F4S2x5WitnSnhNR0VWbmlQajIzWmtTMVZZ?=
 =?utf-8?B?cjhBd0crd0tZRlI1UkpqaWI0Zm9BaFAwR050NGJoZUhzcGpYT1JYSWpaYTRy?=
 =?utf-8?B?Nm9HSmdVSGI4cm02RS9LSFVPSjI3UE5ZdTB1YXFIUlU3WW5OazhVTjkrczBI?=
 =?utf-8?B?Wm5lWXNLWThmYmR5UzhTc0tOYVNrWjRIZjhwRSs0VG84Kzk1VHdlR1ZPbUQr?=
 =?utf-8?B?dURpV202clFPUjlYTzNyeDNCUGJSdm92SXpVOExvVWZSNEIraUhwbE5TNlZ1?=
 =?utf-8?B?R1lsVE95NDF6MjQ0ZmEzaloreEhjT1JOd05VbmszN0svUFRDZUs0Y1E5WGtF?=
 =?utf-8?B?UFBKSW9XTlkrbHR1T1l5RzhSYkE2b2c0VjY5anBKdW1LNG1DenU3S2VWaDJx?=
 =?utf-8?B?dlkvbytDL2VBRW16RHNlajlQa25NQ3g4dzM3N2NpNFlvbjlDa2RVUlBYb0Fa?=
 =?utf-8?B?Q1dYSWRaSDZuT1dZWG1jTUV0WjlybUxiZHlnSk9xQjdNZkVZYzZRb3lySXc5?=
 =?utf-8?B?Z05jQVBscXV5d3pQVGFHTmpaR3c1T2NTQzZBaU5HaWliNzJqNDRLNW5TN0ti?=
 =?utf-8?B?L2k0c2NwcEdsQWtHdVdTOXlmdW5nT296ZTd4MVBWc1pUZTdsQ08vekQzbDd6?=
 =?utf-8?B?QTVXWmROZUtFT2Y1b0Z4cEErNXdzcStPU2ZXTUZWbFU3VmJqdUJGSGdaUHZK?=
 =?utf-8?Q?+T/dAn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SERNOWJyamZ3VWlLcFRJNTdmeTBoYW0zZ21GbjR1aGpia2xZd1BDYU5xQjZr?=
 =?utf-8?B?Y01aTVNITXd1VndzTVhKdnZDNzVaZjVVb2VWTVp3WHJvem96OEJKMDgwMW5Q?=
 =?utf-8?B?cStSMVVtaEVuaWVyZjd3QjR2VVpXMUtEczhibFVqUEEvNWp2VjR4NmowQkhX?=
 =?utf-8?B?QThHaThsRnVHbjRETDJSVFhoQW5iNDh4SVo1eU9CRHd6VzNyN2VNV3JucGla?=
 =?utf-8?B?SHZnRk9OeVhhOTZqRTFhR2VnNENSWEcxU0g0RWZMemgvVGtyQUFvUnVFR3F1?=
 =?utf-8?B?MGxBWDU3THBHam1QOFZUZUNyQjdrS3E1cWg2aDVhcjdLcTkvN2VBNG1PR0pV?=
 =?utf-8?B?RzNvMnFQMytxZW40RjFNUnhUbnVWc2RqTTZhRkxoTy9kYUcxeEp6V0hseFJi?=
 =?utf-8?B?azRDRVdMN0ZESEJzV09YMVRieWpqU29nUkdlYUdtTHgrdXZ1MFR3Z0ZwSkJm?=
 =?utf-8?B?TTM5bDZ5NjZKZFJmRE5YekpqWEJ5aW5CZkVmTG5PSzRXTGpaeUR4dzU3NW9O?=
 =?utf-8?B?MWQ2a1ZsMWc2SGI4WU1IZUg1eXNPdlNESEhQOGludDFiaWIxYWNYeTcvWVFS?=
 =?utf-8?B?Qi9acUI5TEk4LzNYT1Fjd2NOREhSeEhOZDM4NDMyenpybFVuVEZ3TUIwUkxU?=
 =?utf-8?B?Ky8yMEF6cllXbTRXRnVDenphMWFZdGNKWjVxVEVLNkRObUs1Yk5yS21CeFpl?=
 =?utf-8?B?TmEvM3ViM1BCRVo4eHdsNVhQL0FMOHFZUW5xMVJuT2o2bTlXRGxYMEVidHpD?=
 =?utf-8?B?MmF5MnRCM0c3NVlPOXRJaThjb3pWMlRnUi91S2xnVFhGakhIVmIyRTgxWThq?=
 =?utf-8?B?Z21VeUNSbVBaZEJ2WHNlVmZwL2lxbWlSTlp6bVRGeStaMFdwa21wZUwrV0I0?=
 =?utf-8?B?RjhWdXhwOElHQ01NTUxqR0cyZzVYbStGZVJwK3JFaFBsNmxBTWJGaFN0RnJB?=
 =?utf-8?B?Q2dQVWVFbVY5MHdqZGZTUitkSHFRem5OZnJBVmNZR0RBdDkyMDNXZS9WOXhH?=
 =?utf-8?B?U0F3OHFmSHhrYzdJQno0clJLUHpieWdoVEV5R0R3d3oyUDVMdWtGNHkzSnNm?=
 =?utf-8?B?YlFvU1VncDNYSDQ5OEpkQnF3WUQ3a2MwaXV6YXNhOTZqVzBkaHoxVWZFbWRk?=
 =?utf-8?B?V2F6UzBhdXVEZXdlNGRpSG1rTnV0RkxmT20rR25uS3dwVGpyRGl4MUR6c2t2?=
 =?utf-8?B?emJKK1hOVmkzcS9YdjZDU29KRVdkYXc4SHhZdXdLVi9nM1VSM2oyYWZ1a0NL?=
 =?utf-8?B?bjRzN0xIcHFTN0s0Si85M0pIYS96R2hjMVZ0NW1LY3J4RTJyZENQYWx1a2x6?=
 =?utf-8?B?NHJiRDBQYmljRjBWRUZncUhKVExXZFZmeVJWSHFxZE5uQ24zS21RanBvNUh1?=
 =?utf-8?B?aThCdEE1cmxWVzhJZzFlblRESEJiOHZad2RYeFVReEttZWtNUWl6YXVNY1BB?=
 =?utf-8?B?bHRKOWdMNlBOSFExTmdmZ3NBeVE5VENPaFJBTzZyTDI5bXBRTDVzUjJFS2Ru?=
 =?utf-8?B?TzBtTTl5bjZkSFNkWlNMTk5xdXNST3h0UEc2emNKK0h5MHdmajVZKzlRNXZG?=
 =?utf-8?B?c2JySjhzZUhMb3RRcWpTa3l3dXRINEZaVUtXdHZWUDh1UGhTdmFieFNQRUxp?=
 =?utf-8?B?QXhHQTVGcTVHeFlmbkNPbDc2T2V0Wm90VTdFNnBTNXk5SWRkb3NCc0wvWnJz?=
 =?utf-8?B?MmVGMWEzanl3NUQvc25qbzJCRzhNTzFQVGNJZGRla0tTMnJNcVZOSXNOVjd2?=
 =?utf-8?B?WlY5MXlKRkl0ZWpEaklwQml5VUhzT3o3K0QzNmtoeXMrY3VYVjJaaExuWXVS?=
 =?utf-8?B?N2pkWjlDK1ZnZFlpKzlzQnRaM3NkM3JqTGd5Um9aWXVzOUgrbVNOb1RzZGR6?=
 =?utf-8?B?eHVDOXdiUmlVVXl2UWI0aTdsVUZDdnJqYlV3NnpkaGw3SXF4c2c3ckQyaERE?=
 =?utf-8?B?c2ZkQ2hkRnVqck85MWRpTEJaU3R3MC9BTVh5bVNlUXdVU1Y5ZUlhWGpTREVx?=
 =?utf-8?B?dFVCYVFaSXY3cldjR2ZsUmlUbjRJTk1ScW1ndC9MdXZRdVNNZE9BbVg2MW4r?=
 =?utf-8?B?bjhzQWRORjlFUEZ0N01lMTlvS3BCbTZlZVc1VDFXMzBTYzcwR01ITm01WXFY?=
 =?utf-8?B?cTRwZm5qNjkwdVJTdkloaXJPY1BycGNLdTBaNFk4Z1dOUDRuY25FMGVTNFNn?=
 =?utf-8?B?cXQyRHNxajMwOHlxUmcxWkF6c0tJaTEwbVBPeURqV2V3UXBqeUJpS1U4WnNk?=
 =?utf-8?B?WFA0eCtBdmJiOVZuVmZFRnJqWFZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69BB56670E22F74698DB92B9E448C214@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6d8ed4-724e-4e99-e0c1-08de27fb9a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 06:11:10.6825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7725szIKw4ujvT0Jtu+8G8txD94vHlqiDS9xH9ycHth93WKcxXG7jJjrDE5zVFFjeWV0kzfurHhzEJtKXO5QF305L80E9A+6GJFTZayJD0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10235
X-Proofpoint-ORIG-GUID: ERnUcv1BzHbLkBTgiJG6X2cpZASoLAAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDAzNCBTYWx0ZWRfX5x1/7crrAil4
 2W1iKNCDY/iUE6y4xufOjd82DgkMHGVJEkuxlUCxlKEbYnQHi6efi2EYsYd4KsGO8aoDbSGohAY
 tStk1v/+J4jBRDTl2o+gQ1dKRwdrX8C26Hn34nmXrKcoJ9UsngfTKYRy+SorreZMqvTShaZInDF
 nUiyTdhCjsNeHx9VTQpM74tLMEoTX6Zc29fdIv+dCuGynmPueEaNZB/XZ93+V0nETP+8c5maB49
 8tbyV+oiUd6SMY/TXw5ZT7jf0J2oR876M9ulZbW6Hkscvj6VodwJfYCEE7jtO1dGsSMll7EQVxe
 AIygpTti3Lei/rxv/dlczFHLZqBc6KLcCeQ2czQQYOmOA8dVTJoWR1p0EuqU+BFGSCnzPl1DR22
 SxhXGmq8PTdWDqeSO2pGiyyIzg6tDA==
X-Proofpoint-GUID: ERnUcv1BzHbLkBTgiJG6X2cpZASoLAAE
X-Authority-Analysis: v=2.4 cv=evbSD4pX c=1 sm=1 tr=0 ts=691eb104 cx=c_pps
 a=6mrLUOsRrbGUgCFc9Veheg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=v3ZZPjhaAAAA:8 a=1XWaLZrsAAAA:8
 a=X7Ea-ya5AAAA:8 a=20KFwNOVAAAA:8 a=NJXD3nuI0OvRqX3CYiAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDE5LCAyMDI1LCBhdCA5OjAw4oCvUE0sIEpvbiBLb2hsZXIgPGpvbkBudXRh
bml4LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBOb3YgMTksIDIwMjUsIGF0IDg6NDni
gK9QTSwgSm9uIEtvaGxlciA8am9ubWtvaGxlckBpY2xvdWQuY29tPiB3cm90ZToNCj4+IA0KPj4g
DQo+Pj4gT24gTm92IDcsIDIwMjUsIGF0IDQ6MTnigK9BTSwgRXJpYyBEdW1hemV0IDxlZHVtYXpl
dEBnb29nbGUuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiBGcmksIE5vdiA3LCAyMDI1IGF0IDE6
MTbigK9BTSBIdWRzb24sIE5pY2sgPG5odWRzb25AYWthbWFpLmNvbT4gd3JvdGU6DQo+Pj4+IA0K
Pj4+PiANCj4+Pj4gDQo+Pj4+PiBPbiA3IE5vdiAyMDI1LCBhdCAwOToxMSwgRXJpYyBEdW1hemV0
IDxlZHVtYXpldEBnb29nbGUuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gIS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18
DQo+Pj4+PiBUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXINCj4+Pj4+IFRo
aXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4NCj4+Pj4+IHwt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tIQ0KPj4+Pj4gDQo+Pj4+PiBPbiBGcmksIE5vdiA3LCAyMDI1IGF0IDEyOjQx4oCv
QU0gSHVkc29uLCBOaWNrIDxuaHVkc29uQGFrYW1haS5jb20+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+
Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+PiBPbiA3IE5vdiAyMDI1LCBhdCAwMjoyMSwgSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+Pj4+IA0KPj4+Pj4+PiAhLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLXwNCj4+Pj4+Pj4gVGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+
Pj4+Pj4+IFRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4N
Cj4+Pj4+Pj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBPbiBUaHUsIE5vdiA2LCAy
MDI1IGF0IDExOjUx4oCvUE0gTmljayBIdWRzb24gPG5odWRzb25AYWthbWFpLmNvbT4gd3JvdGU6
DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IE9uIGEgNjQwIENQVSBzeXN0ZW0gcnVubmluZyB2aXJ0aW8t
bmV0IFZNcyB3aXRoIHRoZSB2aG9zdC1uZXQgZHJpdmVyLCBhbmQNCj4+Pj4+Pj4+IG11bHRpcXVl
dWUgKDY0KSB0YXAgZGV2aWNlcyB0ZXN0aW5nIGhhcyBzaG93biBjb250ZW50aW9uIG9uIHRoZSB6
b25lIGxvY2sNCj4+Pj4+Pj4+IG9mIHRoZSBwYWdlIGFsbG9jYXRvci4NCj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4gQSAncGVyZiByZWNvcmQgLUY5OSAtZyBzbGVlcCA1JyBvZiB0aGUgQ1BVcyB3aGVyZSB0
aGUgdmhvc3Qgd29ya2VyIHRocmVhZHMgcnVuIHNob3dzDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+ICMg
cGVyZiByZXBvcnQgLWkgcGVyZi5kYXRhLnZob3N0IC0tc3RkaW8gLS1zb3J0IG92ZXJoZWFkICAt
LW5vLWNoaWxkcmVuIHwgaGVhZCAtMjINCj4+Pj4+Pj4+IC4uLg0KPj4+Pj4+Pj4gIw0KPj4+Pj4+
Pj4gICAxMDAuMDAlDQo+Pj4+Pj4+PiAgICAgICAgICAgIHwNCj4+Pj4+Pj4+ICAgICAgICAgICAg
fC0tOS40NyUtLXF1ZXVlZF9zcGluX2xvY2tfc2xvd3BhdGgNCj4+Pj4+Pj4+ICAgICAgICAgICAg
fCAgICAgICAgICB8DQo+Pj4+Pj4+PiAgICAgICAgICAgIHwgICAgICAgICAgIC0tOS4zNyUtLV9y
YXdfc3Bpbl9sb2NrX2lycXNhdmUNCj4+Pj4+Pj4+ICAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgIHwNCj4+Pj4+Pj4+ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgIHwtLTUu
MDAlLS1fX3JtcXVldWVfcGNwbGlzdA0KPj4+Pj4+Pj4gICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICAgICBnZXRfcGFnZV9mcm9tX2ZyZWVsaXN0DQo+Pj4+Pj4+PiAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgIF9fYWxsb2NfcGFnZXNfbm9w
cm9mDQo+Pj4+Pj4+PiAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAg
IHwNCj4+Pj4+Pj4+ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAg
fC0tMy4zNCUtLW5hcGlfYWxsb2Nfc2tiDQo+Pj4+Pj4+PiAjDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+
IFRoYXQgaXMsIGZvciBSeCBwYWNrZXRzDQo+Pj4+Pj4+PiAtIGtzb2Z0aXJxZCB0aHJlYWRzIHBp
bm5lZCAxOjEgdG8gQ1BVcyBkbyBTS0IgYWxsb2NhdGlvbi4NCj4+Pj4+Pj4+IC0gdmhvc3QtbmV0
IHRocmVhZHMgZmxvYXQgYWNyb3NzIENQVXMgZG8gU0tCIGZyZWUuDQo+Pj4+Pj4+PiANCj4+Pj4+
Pj4+IE9uZSBtZXRob2QgdG8gYXZvaWQgdGhpcyBjb250ZW50aW9uIGlzIHRvIGZyZWUgU0tCIGFs
bG9jYXRpb25zIG9uIHRoZSBzYW1lDQo+Pj4+Pj4+PiBDUFUgYXMgdGhleSB3ZXJlIGFsbG9jYXRl
ZCBvbi4gVGhpcyBhbGxvd3MgZnJlZWQgcGFnZXMgdG8gYmUgcGxhY2VkIG9uIHRoZQ0KPj4+Pj4+
Pj4gcGVyLWNwdSBwYWdlIChQQ1ApIGxpc3RzIHNvIHRoYXQgYW55IG5ldyBhbGxvY2F0aW9ucyBj
YW4gYmUgdGFrZW4gZGlyZWN0bHkNCj4+Pj4+Pj4+IGZyb20gdGhlIFBDUCBsaXN0IHJhdGhlciB0
aGFuIGhhdmluZyB0byByZXF1ZXN0IG5ldyBwYWdlcyBmcm9tIHRoZSBwYWdlDQo+Pj4+Pj4+PiBh
bGxvY2F0b3IgKGFuZCB0YWtpbmcgdGhlIHpvbmUgbG9jaykuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+
IEZvcnR1bmF0ZWx5LCBwcmV2aW91cyB3b3JrIGhhcyBwcm92aWRlZCBhbGwgdGhlIGluZnJhc3Ry
dWN0dXJlIHRvIGRvIHRoaXMNCj4+Pj4+Pj4+IHZpYSB0aGUgc2tiX2F0dGVtcHRfZGVmZXJfZnJl
ZSBjYWxsIHdoaWNoIHRoaXMgY2hhbmdlIHVzZXMgaW5zdGVhZCBvZg0KPj4+Pj4+Pj4gY29uc3Vt
ZV9za2IgaW4gdHVuX2RvX3JlYWQuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IFRlc3RpbmcgZG9uZSB3
aXRoIGEgNi4xMiBiYXNlZCBrZXJuZWwgYW5kIHRoZSBwYXRjaCBwb3J0ZWQgZm9yd2FyZC4NCj4+
Pj4+Pj4+IA0KPj4+Pj4+Pj4gU2VydmVyIGlzIER1YWwgU29ja2V0IEFNRCBTUDUgLSAyeCBBTUQg
U1A1IDk4NDUgKFR1cmluKSB3aXRoIDIgVk1zDQo+Pj4+Pj4+PiBMb2FkIGdlbmVyYXRvcjogaVBl
cmYyIHggMTIwMCBjbGllbnRzIE1TUz00MDANCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gQmVmb3JlOg0K
Pj4+Pj4+Pj4gTWF4aW11bSB0cmFmZmljIHJhdGU6IDU1R2Jwcw0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+
PiBBZnRlcjoNCj4+Pj4+Pj4+IE1heGltdW0gdHJhZmZpYyByYXRlIDExMEdicHMNCj4+Pj4+Pj4+
IC0tLQ0KPj4+Pj4+Pj4gZHJpdmVycy9uZXQvdHVuLmMgfCAyICstDQo+Pj4+Pj4+PiBuZXQvY29y
ZS9za2J1ZmYuYyB8IDIgKysNCj4+Pj4+Pj4+IDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jDQo+Pj4+Pj4+PiBpbmRleCA4MTkyNzQw
MzU3YTAuLjM4OGYzZmZjNjY1NyAxMDA2NDQNCj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3R1
bi5jDQo+Pj4+Pj4+PiArKysgYi9kcml2ZXJzL25ldC90dW4uYw0KPj4+Pj4+Pj4gQEAgLTIxODUs
NyArMjE4NSw3IEBAIHN0YXRpYyBzc2l6ZV90IHR1bl9kb19yZWFkKHN0cnVjdCB0dW5fc3RydWN0
ICp0dW4sIHN0cnVjdCB0dW5fZmlsZSAqdGZpbGUsDQo+Pj4+Pj4+PiAgICAgICAgICAgIGlmICh1
bmxpa2VseShyZXQgPCAwKSkNCj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICBrZnJlZV9za2Io
c2tiKTsNCj4+Pj4+Pj4+ICAgICAgICAgICAgZWxzZQ0KPj4+Pj4+Pj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgY29uc3VtZV9za2Ioc2tiKTsNCj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHNrYl9hdHRlbXB0X2RlZmVyX2ZyZWUoc2tiKTsNCj4+Pj4+Pj4+ICAgIH0NCj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4gICAgcmV0dXJuIHJldDsNCj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9uZXQvY29y
ZS9za2J1ZmYuYyBiL25ldC9jb3JlL3NrYnVmZi5jDQo+Pj4+Pj4+PiBpbmRleCA2YmUwMTQ1NGYy
NjIuLjg5MjE3YzQzYzYzOSAxMDA2NDQNCj4+Pj4+Pj4+IC0tLSBhL25ldC9jb3JlL3NrYnVmZi5j
DQo+Pj4+Pj4+PiArKysgYi9uZXQvY29yZS9za2J1ZmYuYw0KPj4+Pj4+Pj4gQEAgLTcyMDEsNiAr
NzIwMSw3IEBAIG5vZGVmZXI6ICBrZnJlZV9za2JfbmFwaV9jYWNoZShza2IpOw0KPj4+Pj4+Pj4g
ICAgREVCVUdfTkVUX1dBUk5fT05fT05DRShza2JfZHN0KHNrYikpOw0KPj4+Pj4+Pj4gICAgREVC
VUdfTkVUX1dBUk5fT05fT05DRShza2ItPmRlc3RydWN0b3IpOw0KPj4+Pj4+Pj4gICAgREVCVUdf
TkVUX1dBUk5fT05fT05DRShza2JfbmZjdChza2IpKTsNCj4+Pj4+Pj4+ICsgICAgICAgREVCVUdf
TkVUX1dBUk5fT05fT05DRShza2Jfc2hhcmVkKHNrYikpOw0KPj4+Pj4+PiANCj4+Pj4+Pj4gSSBt
YXkgbWlzcyBzb21ldGhpbmcgYnV0IGl0IGxvb2tzIHRoZXJlJ3Mgbm8gZ3VhcmFudGVlIHRoYXQg
dGhlIHBhY2tldA0KPj4+Pj4+PiBzZW50IHRvIFRBUCBpcyBub3Qgc2hhcmVkLg0KPj4+Pj4+IA0K
Pj4+Pj4+IFllcywgSSBkaWQgd29uZGVyLg0KPj4+Pj4+IA0KPj4+Pj4+IEhvdyBhYm91dCBzb21l
dGhpbmcgbGlrZQ0KPj4+Pj4+IA0KPj4+Pj4+IC8qKg0KPj4+Pj4+ICogY29uc3VtZV9za2JfYXR0
ZW1wdF9kZWZlciAtIGZyZWUgYW4gc2tidWZmDQo+Pj4+Pj4gKiBAc2tiOiBidWZmZXIgdG8gZnJl
ZQ0KPj4+Pj4+ICoNCj4+Pj4+PiAqIERyb3AgYSByZWYgdG8gdGhlIGJ1ZmZlciBhbmQgYXR0ZW1w
dCB0byBkZWZlciBmcmVlIGl0IGlmIHRoZSB1c2FnZSBjb3VudA0KPj4+Pj4+ICogaGFzIGhpdCB6
ZXJvLg0KPj4+Pj4+ICovDQo+Pj4+Pj4gdm9pZCBjb25zdW1lX3NrYl9hdHRlbXB0X2RlZmVyKHN0
cnVjdCBza19idWZmICpza2IpDQo+Pj4+Pj4gew0KPj4+Pj4+IGlmICghc2tiX3VucmVmKHNrYikp
DQo+Pj4+Pj4gcmV0dXJuOw0KPj4+Pj4+IA0KPj4+Pj4+IHRyYWNlX2NvbnN1bWVfc2tiKHNrYiwg
X19idWlsdGluX3JldHVybl9hZGRyZXNzKDApKTsNCj4+Pj4+PiANCj4+Pj4+PiBza2JfYXR0ZW1w
dF9kZWZlcl9mcmVlKHNrYik7DQo+Pj4+Pj4gfQ0KPj4+Pj4+IEVYUE9SVF9TWU1CT0woY29uc3Vt
ZV9za2JfYXR0ZW1wdF9kZWZlcik7DQo+Pj4+Pj4gDQo+Pj4+Pj4gYW5kIGFuIGlubGluZSB2ZXJz
aW9uIGZvciB0aGUgIUNPTkZJR19UUkFDRVBPSU5UUyBjYXNlDQo+Pj4+PiANCj4+Pj4+IEkgd2ls
bCB0YWtlIGNhcmUgb2YgdGhlIGNoYW5nZXMsIGhhdmUgeW91IHNlZW4gbXkgcmVjZW50IHNlcmll
cyA/DQo+Pj4+IA0KPj4+PiBHcmVhdCwgdGhhbmtzLiBJIGRpZCBzZWUgeW91ciBzZXJpZXMgYW5k
IHdpbGwgZXZhbHVhdGUgdGhlIGltcHJvdmVtZW50IGluIG91ciB0ZXN0IHNldHVwLg0KPj4+PiAN
Cj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBJIHRoaW5rIHlvdSBhcmUgbWlzc2luZyBhIGZldyBwb2lu
dHPigKYuDQo+Pj4+IA0KPj4+PiBTdXJlLCBzdGlsbCBsZWFybmluZy4NCj4+PiANCj4+PiBTdXJl
ICENCj4+PiANCj4+PiBNYWtlIHN1cmUgdG8gYWRkIGluIHlvdXIgZGV2IC5jb25maWcgOiBDT05G
SUdfREVCVUdfTkVUPXkNCj4+PiANCj4+IA0KPj4gSGV5IE5pY2ssDQo+PiBUaGFua3MgZm9yIHNl
bmRpbmcgdGhpcyBvdXQsIGFuZCBmdW5ueSBlbm91Z2gsIEkgaGFkIGFsbW9zdCB0aGlzDQo+PiBl
eGFjdCBzYW1lIHNlcmllcyBvZiB0aG91Z2h0cyBiYWNrIGluIE1heSwgYnV0IGVuZGVkIHVwIGdl
dHRpbmcNCj4+IHN1Y2tlZCBpbnRvIGEgcmFiYml0IGhvbGUgdGhlIHNpemUgb2YgVGV4YXMgYW5k
IG5ldmVyIGNpcmNsZWQNCj4+IGJhY2sgdG8gZmluaXNoIHVwIHRoZSBzZXJpZXMuDQo+PiANCj4+
IENoZWNrIG91dCBteSBzZXJpZXMgaGVyZTogDQo+PiBodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvbmV0ZGV2YnBmL3BhdGNoLzIwMjUwNTA2MTQ1NTMwLjI4NzcyMjktNS1qb25A
bnV0YW5peC5jb20vDQo+PiANCj4+IEkgd2FzIGFsc28gbW9ua2V5aW5nIGFyb3VuZCB3aXRoIGRl
ZmVyIGZyZWUgaW4gdGhpcyBleGFjdCBzcG90LA0KPj4gYnV0IGl0IHRvbyBnb3QgbG9zdCBpbiB0
aGUgcmFiYml0IGhvbGUsIHNvIEnigJltIGdsYWQgSSBzdHVtYmxlZA0KPj4gdXBvbiB0aGlzIGFn
YWluIHRvbmlnaHQuDQo+PiANCj4+IExldCBtZSBkdXN0IHRoaXMgYmFieSBvZmYgYW5kIHNlbmQg
YSB2MiBvbiB0b3Agb2YgRXJpY+KAmXMNCj4+IG5hcGlfY29uc3VtZV9za2IoKSBzZXJpZXMsIGFz
IHRoZSBjb21iaW5hdGlvbiBvZiB0aGUgdHdvDQo+PiBvZiB0aGVtIHNob3VsZCBuZXQgb3V0IHBv
c2l0aXZlbHkgZm9yIHlvdQ0KPj4gDQo+PiBKb24NCj4+IA0KDQpEaWQgc29tZSB0ZXN0aW5nIG9u
IHRoaXMsIGl0IGRvZXMgd29yayB3ZWxsLiBUaGUgb25seSBkb3duc2lkZSBpcyB0aGF0DQp3aGVu
IHRlc3RpbmcgYSB2ZXJ5IGhlYXZ5IFVEUCBUWCB3b3JrbG9hZCwgdGhlIFRYIHZob3N0IHRocmVh
ZA0KZ2V0cyBJUEnigJlkIGhlYXZpbHkgdG8gcHJvY2VzcyB0aGUgZGVmZXJyZWQgbGlzdC4gSeKA
mW0gZ29pbmcgdG8gdHJ5IHRvDQpzZWUgaWYgdGFjdGljYWxseSBjYWxsaW5nIHNrYl9kZWZlcl9m
cmVlX2ZsdXNoIGltbWVkaWF0ZWx5IGJlZm9yZSANCm5hcGlfc2tiX2NhY2hlX2dldF9idWxrIGlu
IG15IHBhdGNoIHNldCBoZWxwcyByZXNvbHZlIHRoYXQuIFdpbGwgY2hlY2sNCnRoYXQgb3V0IHRv
bW9ycm93IGFuZCByZXBvcnQgYmFjay4NCg0K


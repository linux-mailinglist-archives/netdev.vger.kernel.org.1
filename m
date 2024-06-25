Return-Path: <netdev+bounces-106453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F02709166BA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732EE1F2171B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9C514B96D;
	Tue, 25 Jun 2024 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="lQzYh613"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FF14B96A;
	Tue, 25 Jun 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316723; cv=fail; b=nLOiqUEHKGE/tiX+qcfWYVuNCuBuWS1+LgOzyv1XC4otOm+3QJ4HTS7fx1bR3L4AZ0ThGLw/DNV9VOIdWmdAW1oL4DdJTFJGBI0ag/x+HSLr+n2EJBiuVnguUPNdx5sfWPoZosgn6pXNdenH5tqQKkc6F73/e9gIA+5fGbREMvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316723; c=relaxed/simple;
	bh=Prt/Feq+A52i6Xx96ARZazy6iIfKhKAMfihE5DOi/yM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gyL5Pxy7g0D8002If3fPQxw1N7IyGQqAkaDRHSqUl66XXZuJLCqLK6NjfYFH/j+l7l6nAxU/7iF5+89t1hIVuCUTlqLpcywLHfDYDvbxGh0trH2xZLztfsTBCQJVaxGDVMNzBpDCielOQjKLkhsVoKJ10OqVfZDtYhfDjInKrDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=lQzYh613; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P8sTAd006242;
	Tue, 25 Jun 2024 04:58:22 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yytt08mdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 04:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHkvFhE5OVWo/ClqRkJbF6jy7mUZc78A2iCwqGtLGQEI3aAJosd9LLXmelTZ80KDDSkwBu+9igV1sizu7/xWjFDLk2/wjwqh9o5/LQOf+E4s36D+OFcklY/jiMBNOLDUE7oA/YqFzwkABbUZO1OhSjmdkTsk019LX7zabGAB8zJkvq2ApcsRkdXY6h2KDvmK6Hl80eohhWiyjZCuZ1ypCagPeOFyTC2oLclGBPleH0notsSqwisTQbDdc3GrRluSP+kNdo8yblF2LRHq55JQzrcwKsyNWoB6uuGzBHmy3iSR+FX8IE7mMcjxKKB1mfDCgqrZJBHm8vHnpxE42mBifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Prt/Feq+A52i6Xx96ARZazy6iIfKhKAMfihE5DOi/yM=;
 b=ETFwAjKhLuzJnYOkbCjHXVXLAKTo7/a01BF7jm6Lj2hAPvplqSGoDCN84icrhQ9EIJi6+9+Q4YTPvIZZoeaBCPnlkZ/iJI0uMiicI2NmbpJqmN5D/3ldlDgr0GnmsW/lLogNnRiRM2tr46vkfZ0XfYDHi3yQH/xHL3rln/K25ctSV3pKhd64Ye++1X5dJ13sfFW1HBlpaNt6LWVLGepY+jBBL0KxhJCuh/Rd46BKrRN8rozpKeq2py9yesSNT0aDaal+QH41eYh4lv8YpGrMZ3nNZ9nPJwmQOmB7Tn5uWxL0FIEhTSbKh90GZxSMMozpjhH2H9XxSUv7Mz1698Vbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Prt/Feq+A52i6Xx96ARZazy6iIfKhKAMfihE5DOi/yM=;
 b=lQzYh613zAYo/f2T3IMnJ/CL300VoFCBKrEMjVrYAyifVN5F1oIG6TDkNX9JsQ1WVlTqNP9wyf9TYgGeym2PcmrnjLxwpoBQJgDqpG173kQsyW918ZvwD0DI9lJVZLzmYqWcd06FSqVHiY+0ODonQnho6rWa2fL3NxlHizdW1fA=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by BL1PR18MB4133.namprd18.prod.outlook.com (2603:10b6:208:310::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 11:58:19 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 11:58:19 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Markus Elfring <Markus.Elfring@web.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v5 02/10] octeontx2-pf: RVU
 representor driver
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v5 02/10] octeontx2-pf: RVU
 representor driver
Thread-Index: AQHavBuNJ9JlozPAg02gBOC4U58P87HI9H6AgA9/bnA=
Date: Tue, 25 Jun 2024 11:58:18 +0000
Message-ID: 
 <CH0PR18MB4339483C0C3EEEC72F1AF068CDD52@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240611162213.22213-3-gakula@marvell.com>
 <ac47a370-99ca-4fb9-8fb0-800894d04c57@web.de>
In-Reply-To: <ac47a370-99ca-4fb9-8fb0-800894d04c57@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|BL1PR18MB4133:EE_
x-ms-office365-filtering-correlation-id: a753ae3c-e92c-45d5-0eda-08dc950e1aa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VTRXa0xRZFlnQjM0cTEvRkpmL2c3VnlBSXFFSlVSRnZkMjY1YTZFbVZZQU1N?=
 =?utf-8?B?T0FCbHZyUE9jdUY0TXlXMVVVYlN6Qi8wTDNCRWNQdmRsK1M2cmRCN2V6dGR3?=
 =?utf-8?B?Mm5kNTVhaDBSR095STZGeHl2VHdZc0lGdHh2UmNOMjRYeUd3UFc3a0EvdnVG?=
 =?utf-8?B?R0srZEMzNFV2Y2kzSCs3OWs1KzhGZjJCZDVjVjlERmg2TzlOM0NaYUgvNGJz?=
 =?utf-8?B?Qm55aENzU2JjeWh3SVhoUVRvUDduTUhxV1NBL0dtd3ZJRTJGd3p2R0xwN0I3?=
 =?utf-8?B?UUtCQ093YXpqeXJHb2UydzVHbWNQYzZ1RzIzVDBhZ0ZkZGtncklSdHY0d1pQ?=
 =?utf-8?B?SHhwem9kalhObkxlQXk2eDV0WmhsRHZHQ284Tyt1bHVOdnJlTG5YcnRuVGZH?=
 =?utf-8?B?cDhTUXgyemc0SUcvOG9JTlRUcTZJQUJ0eEZrOGM4WXhXeDBhRzg0RnBSUnRo?=
 =?utf-8?B?ZW9YbnFLZXE3d1BmbVdvbWQ1bmlqMWRENVFPTzBmMGMwY3VGcWtva3RLYW43?=
 =?utf-8?B?N082dlFoTDNnRE05VC91SGpzMkg1czVzV3lhbS9mcDMyRnhLODYzOVZMNzNk?=
 =?utf-8?B?WFg3OHlIeGFxRzlWQTMzK3dZNjA1OUVGMXdnZzU3b3lseUFoWm93b3dYa3lV?=
 =?utf-8?B?dVNKK1hyZXAzVFlveFFHMHNLWjBvdGVDVmd6OHNidzMvUnB2Yk8wcUZrVjBl?=
 =?utf-8?B?T0luUk40Wld4dkl6bkYrQWYyd1lZSWxVbk1zeG15ZUlaOEhCL0N1MXMvSU4w?=
 =?utf-8?B?SE51aHVpNmZXdlR1MVluWmc3NVdjWHJ5WXF4ZGhQN3dJUlV4UWVkMkIyaThN?=
 =?utf-8?B?cXRNbUlWUzJ0dHdvYnBNbGowK3lPZmNGYndSV05qNTEzcWJoeU8rRi9UekNa?=
 =?utf-8?B?cGY0U0plUjdxWnlCcjNjckxVbS8xeUdLRjIvOStWbUNvMkROVmNWTGppeXYy?=
 =?utf-8?B?MG5ObzFMeUNPbittLzhXT1lPaUxVNm55TGIxNERScFpQWUpmRmRZSlBsa0Qz?=
 =?utf-8?B?bit0cWgxSytwRXlnWlZxVk1lQWVxVjF2NFBzVzNNVklsWHhxYnlFM1V4WUlu?=
 =?utf-8?B?M0c1NFNqRUM1UVhVdzY2WjBERlZrTkVpYi9GdTV2U3FVZnlwb3NlRHlxVGVN?=
 =?utf-8?B?MjlWUlBkL0QydDc4Tm9sNElyL3hlc0YvdFdjWmJlMlh6cFNOdHZyNUxMbGF5?=
 =?utf-8?B?ekI4QXV1M3NTOG1jdDdUcFdteWlyaG02aitYWjNvYmw2cmVnNDNHaTlIQWhB?=
 =?utf-8?B?L0FFKzV1eUVZSVpCU09JRllQTWhESWtqVnlrKzBFTnVnM0xVSVJGNFp3MFQ5?=
 =?utf-8?B?UUFYc0lCR29ZaithNkJ3V1hzdjVuRmwxU3NsWkFadFVYWlc1cFI0Zmt4cDJh?=
 =?utf-8?B?MmNKbHZ1UFZPYlZWa3YyQlVLY0Iybi9CM1RyUndCeTM3aDhzMW5JU3kxQnI4?=
 =?utf-8?B?SlE0MmxWeHdFTE93Vm4rMHpxNVJGVmZzLzN1U3BYbVdmeVRPQlNpUW1BeDB5?=
 =?utf-8?B?SDhrQkp6eGEyaytCbVpDand1WmlGOUZqUlF2VHBvc2Mydy9hM0NXR3p6dm9h?=
 =?utf-8?B?N0lnOFZPcjUrZXpQV2RhUWljNnZVU2R4b2QwQS82QWNMMXVHcUFQQy83QXNR?=
 =?utf-8?B?Q042Ym5va0p2SkV6am0vZ2R3NXpLZ3pvTnErcHZIM3ZQWDNjQVQ3c1MweFc5?=
 =?utf-8?B?VmRTOHQxMWZMd3J0UFc5aWVHOWZwNkJ4N0NRcHFreWVyeWsrcXJENWczU0x4?=
 =?utf-8?Q?cGzZKmmZ97YjXTA4RPTC+NLFSIkEwJcrXfDBtpZ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aHpya1QxUjB5cDlZM3VqVFE5dlBLTmpnL1RMSDN3SWVSanBPZVN5bDFUVkZH?=
 =?utf-8?B?OEgxT2w0TG5Fd201Rkk2eUVoNlBGK0dJc0xaWmVENFo1czZSeTY3QUlFVkI5?=
 =?utf-8?B?RDhCTmF6THZCbHAxU2ZJRHdmMnFnOEMvdG9hdWduV0N2ZkJES0FWQUtkRzFK?=
 =?utf-8?B?a1lsSTE1dnRrSHlMWlNBM0pCWE9zektJQ3k5OGxZV01wYU95cUpZUm9USXpC?=
 =?utf-8?B?bGlJdFJCL1A1UlRjU0dRSWczaFIzdW1HaGVTZ2tOaEZWcGFnbjVIeStiOVM5?=
 =?utf-8?B?WThzUzNObWlpYmE3T2FSWlBpekZXOTJ5Z0lINXdyTEdaa0JoWHl3Si9EaW0y?=
 =?utf-8?B?dU5FWXhidE9SR3JNbGVRUWNUUFAzaDRkcHhZWmZSS1ZRRzlRRGhGUzZLY0hi?=
 =?utf-8?B?b3huTkFIM3ZSd1ZWVlkwVldsb3ZJUVZnRjNmelhoOFdobndHb1dKU3dqRDFZ?=
 =?utf-8?B?VGI5T014OXdmaS9RbWxHZHZkSC9iclRxSS9pWjZYKy9acUp0OVVOT1JJZTg4?=
 =?utf-8?B?bUw1U1BIYzFYT0w4WHFMT0NKZG9uTEFrYUxDRGVyaXo4OWVOK2NTQmxsUHJZ?=
 =?utf-8?B?OGlLT3NtUmlaWWNRMjdvNjdoUERMcVd1TmQxNm1zcUtUQnd3Wkxwc3Z6VEg2?=
 =?utf-8?B?d1dDQWdmLzVVUFpTS3BrSTlSdGNpRG5QZnA3ZllETG44ZVBLSVNBQkFnU0J2?=
 =?utf-8?B?ZmtZbDVqOU1WL0RnaHlKOEFTOGFTZzdLWUpIaWZTbTZUOEhFWGVFOW1Zbk9h?=
 =?utf-8?B?WTExQUNQaCtJdjd5cVZHdTd2bGdxS2VWOFNLNEhWcVRqcVZoc3NUclY1NnQ2?=
 =?utf-8?B?Tjg2a2RaRWROd0RxZVV4WWpseTBLZEhCRmdVTVBLeTgwdzhPV1d6aFNXWHBB?=
 =?utf-8?B?VXFZbytHUEJzcHRveW9peThLdjhWYWZkTDVKbnB5WlBQT3hNZUNneURDdmV3?=
 =?utf-8?B?UExEU0ExYTY5UlloZkoxWWtUOHd5VmpJL1puYlRXUk5jeEozUWhvYkhHUUND?=
 =?utf-8?B?N0NERjNiSml3VGN3ZVBXSUwyMktQNFh0SkNBbTlPWUdpNWhGSzdDK3BBV21U?=
 =?utf-8?B?blA5SmdpWGFmQnF5QzhRYVFjT05YSXF4M1RaSmlvYlRFTGRCVmM3Y0tqVXJo?=
 =?utf-8?B?aktJdm9rUGp6b0VEYVVVbGVhWGlWM1UrSkd3TjBzekRDaDkrbktjRHhUV3NC?=
 =?utf-8?B?N3M2OXRwTWd6eUtWZDNyN2dKYW1uc25hQUJhOTFZenIxbTREWW5RYjk3cFhC?=
 =?utf-8?B?d0drSExOTnRIRDJTTlYyTFJHbTNWdDdkVWVQdGl2cHBTQy9rV2FGM1c5SmNI?=
 =?utf-8?B?MHRkUVNWTTMwMGoyV3dQVGJiQzBDV1hXbXpYMk16YTFON0RyRG1pNXNYeHFs?=
 =?utf-8?B?aFhURGFvaVR3NmJackk3Qm1mdnd0VUZxNFVLdHVmcjlya3Axd0xaajhvRmd5?=
 =?utf-8?B?bE5QV3hqaUZUVjkvMDJIM1VYZlM1dXNlcmtCTmdkb2NlWjVXQys0ZGpUSGVB?=
 =?utf-8?B?NlFFcU9hdDkwNVpvVTM3RmVOaGg0UnZkTDFER3lkMmRyVlNvUi8yVy9qYTRv?=
 =?utf-8?B?UW9veTBhdTlZQjBjV21kRzRWWFZrc3Vncnp6Y3RVTUVmL2lrdWJyTHNLaWJD?=
 =?utf-8?B?Wkt6U2RJQUNUYmRObGxWdCtuUitZQTFXRzlxNHlqY3RNaDdvYW12K1FWUTdD?=
 =?utf-8?B?K0dwTFp5cVVjQnJZYkZJU3JheVJCa0FiTVpUWGpmck5RbkxLZ3JXaGJrTGxZ?=
 =?utf-8?B?c0JoMzhDNlBrYWhxdXRyOERKT0Y2WDIrRTByaUYrV2ZwVkdsMjY5ZUlEOFR5?=
 =?utf-8?B?WGhOMU0vcXNyVlRaRDlpV0hpTWp4b2lRQVB4amw5cmZXOHYxWlVNdDA5Nkla?=
 =?utf-8?B?Vkwyb1hkRXJQZUlyUEplRG9PMWFhOWpXVFZMNUZ0dk1UNDNTcTJxdkdJY05R?=
 =?utf-8?B?d1BQU1d5Z2IxOG5qcy82R3RNQjVRbnhhT3YrcGQyWUlUbkdSbksxRlg4bmNo?=
 =?utf-8?B?Z085YXJ0anNrMzlzR3Mvei9rRjVSZjNoUUlqbjdhVFRaUG5YVTVsM1NYUHRF?=
 =?utf-8?B?cTZ5TEd6QmtBSmVKRjZHOU81TjcrenBDSTlUSHpVbUlYWC85dmJEM3NFUVQw?=
 =?utf-8?Q?prWM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a753ae3c-e92c-45d5-0eda-08dc950e1aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 11:58:18.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dnwZDEod6vvorOvs5KgMBDKjW+akBWzpmeOZmb1S2WVGU/GiTAPYGIABRQJ/gpF/DuwqNBh+YO8OB3O9Ttk7Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4133
X-Proofpoint-ORIG-GUID: _XzwydBzkwmb719qeKtzu9vbLrseEYOL
X-Proofpoint-GUID: _XzwydBzkwmb719qeKtzu9vbLrseEYOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_07,2024-06-25_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hcmt1cyBFbGZyaW5nIDxN
YXJrdXMuRWxmcmluZ0B3ZWIuZGU+DQo+U2VudDogU2F0dXJkYXksIEp1bmUgMTUsIDIwMjQgODo0
MiBQTQ0KPlRvOiBHZWV0aGFzb3dqYW55YSBBa3VsYSA8Z2FrdWxhQG1hcnZlbGwuY29tPjsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsNCj5EYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5u
ZXQ+OyBFcmljIER1bWF6ZXQNCj48ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tp
IDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPjxwYWJlbmlAcmVkaGF0LmNvbT4NCj5D
YzogTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IEhhcmlwcmFzYWQgS2VsYW0N
Cj48aGtlbGFtQG1hcnZlbGwuY29tPjsgU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRhIDxzYmhhdHRh
QG1hcnZlbGwuY29tPjsNCj5TdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwu
Y29tPg0KPlN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtuZXQtbmV4dCBQQVRDSCB2NSAwMi8xMF0g
b2N0ZW9udHgyLXBmOiBSVlUNCj5yZXByZXNlbnRvciBkcml2ZXINCj4NCj4+IFRoaXMgcGF0Y2gg
YWRkcyBiYXNpYyBkcml2ZXIgZm9yIHRoZSBSVlUgcmVwcmVzZW50b3IuDQo+4oCmDQo+DQo+UGxl
YXNlIGltcHJvdmUgc3VjaCBhIGNoYW5nZSBkZXNjcmlwdGlvbiB3aXRoIGltcGVyYXRpdmUgd29y
ZGluZ3MuDQo+aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LQ0KPjNBX19naXQua2VybmVsLm9yZ19wdWJfc2NtX2xpbnV4X2tlcm5lbF9naXRfdG9ydmFsZHNf
bGludXguZ2l0X3RyZWVfRG9jdW0NCj5lbnRhdGlvbl9wcm9jZXNzX3N1Ym1pdHRpbmctMkRwYXRj
aGVzLnJzdC0zRmgtM0R2Ni4xMC0yRHJjMy0NCj4yM245NCZkPUR3SUZhUSZjPW5LaldlYzJiNlIw
bU95UGF6N3h0ZlEmcj1VaUV0X25VZVlGY3R1N0pWTFhWbFhEDQo+aFRtcV9FQWZvb2FaRVlJbmZH
dUVRJm09eFFXbTRjMXhabUtobHJvY21EQ0c0d0N0ZG91M2ltWU5xT3E2DQo+Z2MwenRWTFNfeG9y
Zm9rMnlObEp2R3oxVlozSCZzPVFqRk44azBDb3VCcG9HeUJyazZlVm9JVUU3ZWhsQ2FKRFNLVA0K
Pm5JT3ZHZXcmZT0NCj4NCj5DYW4gYW4gYWRqdXN0ZWQgc3VtbWFyeSBwaHJhc2UgYmVjb21lIGFs
c28gYSBiaXQgbW9yZSBoZWxwZnVsPw0KPmh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNv
bS92Mi91cmw/dT1odHRwcy0NCj4zQV9fZWxpeGlyLmJvb3RsaW4uY29tX2xpbnV4X3Y2LjEwLQ0K
PjJEcmMzX3NvdXJjZV9Eb2N1bWVudGF0aW9uX3Byb2Nlc3NfbWFpbnRhaW5lci0yRHRpcC5yc3Qt
DQo+MjNMMTI0JmQ9RHdJRmFRJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRmUSZyPVVpRXRfblVlWUZj
dHU3SlZMWFZsWEQNCj5oVG1xX0VBZm9vYVpFWUluZkd1RVEmbT14UVdtNGMxeFptS2hscm9jbURD
RzR3Q3Rkb3UzaW1ZTnFPcTYNCj5nYzB6dFZMU194b3Jmb2syeU5sSnZHejFWWjNIJnM9M3B5ZVVp
YWh3OFc0Tlc0Ym80SUU3ODVmQ0lkMUhub1pjZA0KPmhhdlBsRjJaSSZlPQ0KPg0KPg0KPuKApg0K
Pj4gK3N0YXRpYyBpbnQgcnZ1X2dldF9yZXBfY250KHN0cnVjdCBvdHgyX25pYyAqcHJpdikgew0K
PuKApg0KPj4gKwltdXRleF9sb2NrKCZwcml2LT5tYm94LmxvY2spOw0KPj4gKwlyZXEgPSBvdHgy
X21ib3hfYWxsb2NfbXNnX2dldF9yZXBfY250KCZwcml2LT5tYm94KTsNCj7igKYNCj4+ICtleGl0
Og0KPj4gKwltdXRleF91bmxvY2soJnByaXYtPm1ib3gubG9jayk7DQo+PiArCXJldHVybiBlcnI7
DQo+PiArfQ0KPuKApg0KPg0KPldvdWxkIHlvdSBiZWNvbWUgaW50ZXJlc3RlZCB0byBhcHBseSBh
IHN0YXRlbWVudCBsaWtlIOKAnGd1YXJkKG11dGV4KSgmcHJpdi0NCj4+bWJveC5sb2NrKTvigJ0/
DQo+aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPjNB
X19lbGl4aXIuYm9vdGxpbi5jb21fbGludXhfdjYuMTAtMkRyYzNfc291cmNlX2luY2x1ZGVfbGlu
dXhfbXV0ZXguaC0NCj4yM0wxOTYmZD1Ed0lGYVEmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9
VWlFdF9uVWVZRmN0dTdKVkxYVmxYRA0KPmhUbXFfRUFmb29hWkVZSW5mR3VFUSZtPXhRV200YzF4
Wm1LaGxyb2NtRENHNHdDdGRvdTNpbVlOcU9xNg0KPmdjMHp0VkxTX3hvcmZvazJ5TmxKdkd6MVZa
M0gmcz1fRmN0QVdRUWN6R0JMMkpXdV9pTG80djU2NTAzNTV3NlhkDQo+TWpwdkpiaGprJmU9DQo+
DQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbnMuIFdpbGwgc3VibWl0IHNlcGFyYXRlIHBhdGNo
IGZvciBlbnRpcmUgZHJpdmVyLg0KPg0KPuKApg0KPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL3JlcC5oDQo+PiBAQCAtMCwwICsxLDMxIEBADQo+4oCm
DQo+PiArI2lmbmRlZiBSRVBfSA0KPj4gKyNkZWZpbmUgUkVQX0gNCj7igKYNCj4NCj5DYW4gdW5p
cXVlIGluY2x1ZGUgZ3VhcmRzIGJlIG1vcmUgZGVzaXJhYmxlIGFsc28gZm9yIHRoaXMgc29mdHdh
cmU/DQo+DQo+UmVnYXJkcywNCj5NYXJrdXMNCg==


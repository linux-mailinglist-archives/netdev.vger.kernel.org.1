Return-Path: <netdev+bounces-210158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99183B12329
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518A63A822B
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255B3245006;
	Fri, 25 Jul 2025 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i7cbgust";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mKJYbTzI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855F1DE3AC;
	Fri, 25 Jul 2025 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465608; cv=fail; b=tjZgs8zSiyIhknTrdht41DE2MaYbXx8K9WwCWQZR7WwJ8AxEKyXczg1epGQe/SaoRo+OwymdNw26z8QEYck+82DBC4Omuual7oCcHLCG6kVinmH4pJzcPT/90aQdmO2QerAE0OiFmft0liIzP+ZAiDiQ1GvKxRzAzqXRm6lBGvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465608; c=relaxed/simple;
	bh=FnwDZA4y7XoaygkdE2o7nL4ysuXOpvNsujJiilythQk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=na8kP/a3LMsmROz8EQwePxxt2y92BoXlZaTqtsH3t8KdFL14XBsQT79ftRlaMZnZbsNiYXyUhogQSoxQ1DcGlUxaR1RxqyCA0HY06xBnjlvYBqoM73wodEDeMBjn2xogjASzuVwahGV6mhsHKMi3OoPUa4XLuQ7J6Wcw53cdFe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i7cbgust; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mKJYbTzI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGC7bE007405;
	Fri, 25 Jul 2025 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yNvDvWVehNJyngPccWyBqvuXFetVYBFb5XP4YoPr9Wk=; b=
	i7cbgust3w+aZvbf6uQyGoPTUURe77POj0rN/oeoACXmr8+qgbSS3PX4Dkf7EBuN
	PxwFU7WLpgljuWLBFldDZKdfIXx5m4CtQV9UCi6VZI9RNpTIhuy+RmPeU0HXkpjm
	mzUUMOy9r58ahQiUA86umwVxALkXurTgAfo2ex056+09pNDyko+rd+8McquJtNkn
	LASei/BBNrUERfXihRvYPu68auZwG7pyWf/sKa16qNzXUd0igqj3kGUaPRb+Xu7E
	jc1XeBgrahWz8gtqK4jXXKEnYB3sr5A1p+ot1orU+tYZDREsEzJdoNziu1BjrOe5
	o8+b/0gOdZDxBMFaow7QYw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k9jd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:44:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGCfpx031484;
	Fri, 25 Jul 2025 17:44:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tkpm1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxWxfj/8BSdLADtmRMTkEKp/4P0KJ1ygz+RYvcs+SIZKKqHjvtepC+hyF/AG4frBWTKnOTv8PJlMeoRDEFZYH3LjKICdOs5go6teGFy+s8yLYJ/z52z3ZMmFB03gmdGhRvTk6huCYau/FGIcuHoFklfRzesSB4BYqlfc6xPdBg1IQ/YZZZrx00KKljuqU4JckKXkWW8ccnNtFz3Nwq7YupreGQHOMk2esNV5ToBMIPAlhe9ZQHPNQhf4jWIum4l6VJ5PV4z0dmpcXWr8BoRosPmIfuOQHR4/4h+KIz9MCa9VEe6J/H5KGAWr8HtCNNz3CgJ30y4LuU7UYHynIEWfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNvDvWVehNJyngPccWyBqvuXFetVYBFb5XP4YoPr9Wk=;
 b=vvOxz2+0ACapLFF8RK6APOk13A26TwE+hnqv7xYb3K8P+dvKR3TaMnlviZItnZGp7hyOAezeOhFMEh2btJ8ZALa3hQ+KMZhAf1rFmXLkNrxZLiJ6QD81Bmdry5yUhFFdAsiRRLjwrkmLsidLnO0nvJK3jdmDnEjcxpixRxQKxtObKT9tOV2Mr8oRXM43mGBE/cY9Dyv8QXLFnUD/FZWERUMSjkBGPEeGZcIuGmkZ4iJPxs1N1DChOioDWKeVixCyhVMMVwsXNpCrnnGLeboYZjGUrujsfXA44GiLW6Z0QRSSmPceBGgiYL4MP8bbmdxKfdF65aS9Y3/R7m0jV/ZnBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNvDvWVehNJyngPccWyBqvuXFetVYBFb5XP4YoPr9Wk=;
 b=mKJYbTzI+RyE7COX4oVCka1ihzc46a5txa5mTUSBNnq4AEWeDzlcVBfnM+iv1T4++3+UGEqoJNDKQYNiFAPh9PNIU6WBMwkqun0QX6irXUU3QE7U+obICT4MFXfKlIWEht2/pM4ewox7N/vMLNlYmxBwmqWsyCQREffsAa2VB1E=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CO1PR10MB4481.namprd10.prod.outlook.com (2603:10b6:303:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 17:44:01 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 17:44:01 +0000
Message-ID: <743eddd9-1f63-4c6c-8ba3-5007bd897ae1@oracle.com>
Date: Fri, 25 Jul 2025 23:13:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 3/5] net: ti: prueth: Adds PRUETH HW and SW
 configuration
To: Parvathi Pudi <parvathi@couthit.com>, danishanwar@ti.com,
        rogerq@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ssantosh@kernel.org, richardcochran@gmail.com, s.hauer@pengutronix.de,
        m-karicheri2@ti.com, glaroque@baylibre.com, afd@ti.com,
        saikrishnag@marvell.com, m-malladi@ti.com, jacob.e.keller@intel.com,
        kory.maincent@bootlin.com, diogo.ivo@siemens.com,
        javier.carrasco.cruz@gmail.com, horms@kernel.org, s-anna@ti.com,
        basharath@couthit.com
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vadim.fedorenko@linux.dev, pratheesh@ti.com, prajith@ti.com,
        vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
        krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
References: <20250724072535.3062604-1-parvathi@couthit.com>
 <20250724072535.3062604-4-parvathi@couthit.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250724072535.3062604-4-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::27) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CO1PR10MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: e21619b4-2af0-4124-157b-08ddcba2d6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RS83N2JMRVBGbzJTS2hRcUJqS1oybi9FWmFGeDBZM3prd3VUVGlibklBdXNG?=
 =?utf-8?B?dkw2WmJxSy9xRXNEeUVRRFJwVG1icXJnWVYxR2VScnNWemhpdUFsdmJRbjlO?=
 =?utf-8?B?b2sra0MvYXJDYUdFZlpHVHBWNUpVVjBBMXVDdzhKYmIyNnhYQXlqNEJqazFY?=
 =?utf-8?B?MTVoRmdLeHd1T3FFU2dMbitDd1BWZHNQbEZQQ1Q2ZGFKTG1ZOE1rODZhSTEx?=
 =?utf-8?B?ZzQwc3BBTU9PUUZlOGJRUHdDaHkwMlNMZlMzMnRpVXFOaUkwVjF2a3hSS1RQ?=
 =?utf-8?B?QU1vT21CYmZPaXpTOUthcGpxdi80d1JIWm1nZEcyaHdHTkdrQkI5OU8rYktL?=
 =?utf-8?B?eUtmeWF2SjFsWVJ2T3NoZTVJVWZmS3kzNzVBMzcwMUlRVHZhNEY1L1Ric2Ir?=
 =?utf-8?B?bkFUWW90L29FZjVHcm9lUTdVbTMwMjF6RmsxNmxqQUV5aDdnMkswMHZJM29m?=
 =?utf-8?B?b3F3MVZBTjBpWTFIL0xQZisybW1lQ3ZjSTI1TEQzY1puVnpJVUQzZ1E0RWxy?=
 =?utf-8?B?R0dXcmxhMmdBMnhyV2xUK0lrQjJUNHhBMEIzNUUwSkttLzZLZy9Iak9GMnA4?=
 =?utf-8?B?Q2Nubm5MaVhGNjFMOHhPZUduQ0hERlI5T21VRkxsd0JaeTY0YUtzNjFxbTVp?=
 =?utf-8?B?QklFK3Z3dUZycHZuMDIvK2I0Tzk3QTQxcFJrY2ZTSmFHVzF3UXEyL1Rvd3Mv?=
 =?utf-8?B?VWRLQ3dCN0o4NTgzUGRVU3BDRGRyMDJZcC9EMXR2UEJCNi9UMHpseFo3cEtJ?=
 =?utf-8?B?d0ZvOEtydlJMYW9jTXQwZTVnRGkrZ0VPa21LU2lyT2VFSEZ1R2Z6ZE5tTFFq?=
 =?utf-8?B?Q0x2MW14bzVsdStkVzJDMHRiVE42Ri9ad29sOHNiNHp5Z3ljczFaZFRaV0NZ?=
 =?utf-8?B?VXFaczdNZzlzR0ZHRHF6K3JENHRZTWJScm9Zc3hwQ3c1NjlsMlRhYmR1WVB5?=
 =?utf-8?B?bFlUUVEvQ1NYNE1wU3hpeVhkazJReDBVTUM0NnFtanRjb1kxcmM1WFlOOC9s?=
 =?utf-8?B?UnE5M05wNXh1Qi9aNk96L1VxeHRQb3FIZlk2Ull5UEMrNVMyYzFjcGNFVXQz?=
 =?utf-8?B?bVdHS3R5UVQ1M1hxY25pR29KRjZOVW1leEdvTmpYK1RkdnNtMEIrcWEwMFNz?=
 =?utf-8?B?K20zcmo0bklTeWJRSloyRUh0MHRnOTBiaVlIN05hZDUzZWtvL0x1UHJ5WEFW?=
 =?utf-8?B?blRyaU94L2RTUGozZ0NhS3k0bms2WXoybWVRS244dE5yOUZTZnZmdFRrYjcz?=
 =?utf-8?B?ZHM0ekI1MWZqWmdrZ3ErRVhYeWZyL056RDNYL1UxOE5kNWlqSCtIRk92dUcw?=
 =?utf-8?B?NThNVEVxQllJdFp4WmtMNTA3OUt6d3R5WGRyTytvREo5bm5raUp6RkZYT0Jp?=
 =?utf-8?B?QWlzQnZVM21zZ0IxYjdSbWU5cGZJSWh6LzZud21IWXBybEVNSzZzOTluZ3ZJ?=
 =?utf-8?B?QTBhN3JGanIySTZTUlFaaVNJa2RjVlZXOU5MbW9lem9paGViQUY0eWxFL2w4?=
 =?utf-8?B?cmJvRHpMS1IrOU5IZ3BvT3Q2REVsaWkramNYVkJ0NEY5eVRFUklzUUFFNUM4?=
 =?utf-8?B?U2dBMGxrSStadWZsNTA2OENKSFFYRTR3SERYNE1haHlveTdNMXl1R2Izb1Zu?=
 =?utf-8?B?R1lISnJyVW1UNmZxYmRVMnRYTGJsOUMybHZsQ2RGRmVQdGdVRmxWWC9TWlht?=
 =?utf-8?B?SDdDTGo2OUkyakxnbGMvb2hKKzMwUTI2d2ozQXhkSTBiMUpDUVdHTTlNa1FQ?=
 =?utf-8?B?bHVyWjVaalhqdURjSVVsZGJJb1VOaTZ6YUFuOTllTXNhRkwxNzR3TXgzMDdV?=
 =?utf-8?B?bSs4NkxIYTFJR1VtQ1hTcG1oUFJsQ2thSmprbjhmSmpwSkhBQUdvNnVKK0pw?=
 =?utf-8?B?WEhpZVI2OTdtcmJ5bWtTWW5seU5MVmVzMjN1Z1RMN1hlTG5ZcWgzUkE1VUhN?=
 =?utf-8?B?R0t2cGJoVnRmcTB6TTM3b2N3MW56dlViTjdvWmFYSmV4aDBjNjliN1hKOFlr?=
 =?utf-8?B?VHNNczJYeDhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWlST2pUYnBIYitESGo0T3F5M1ZGNmVHZXM1LytKZk5QT2lyYTI1NG9yM29o?=
 =?utf-8?B?aktlaXQyMmw0eFNpWUtPZDN5K25RSEdJRHhrYUtNc3UvOWN0YnMwcVZzdG15?=
 =?utf-8?B?MWhvL3FsQ2toaFdhSWdLTkdDbGNKUExhelRxTFZRZVNFSWhGQWhrOWNqdnhC?=
 =?utf-8?B?Z2NVenJWbmRwa1JOV05jREF2bWNZUXNZdDRYanFSMGRnamNPK2x0YzlyckpN?=
 =?utf-8?B?cmJIYXBncVhZMjRnZ1RlaFhwc1UwQ1B4cEIweWt3endVenJ2N1dTd1lVdnpo?=
 =?utf-8?B?dkpIQlBCUG15aVIveHp6d0dlYXZwWEd4WDdXMk9RMTVNR3FxcHAyWVE4emcw?=
 =?utf-8?B?dEFYYmZMY1k5NisyTXB4UkdyUkJUSjJRSHFRNzNiM2V1YXZWT1FSOTBTL2Zv?=
 =?utf-8?B?YjlYUTMyc0RxUTliUTQ0Mk03VjBOdmw1UENaeld3KytOc3czMzAwQU8vNVlW?=
 =?utf-8?B?NGtDbkdlc1NRb01vRlFjT05neXc1MjcwYS9JQ3lqdFF6NGF3Qi90aTFGOHd4?=
 =?utf-8?B?SHZaKzI5ZW94cVBEc2grRVdnUy9Vc3dxbGhHMEl0UVZRVFdOWnRvWWZLYllE?=
 =?utf-8?B?eXBqd3J2aDJST0tpdyt1T3hOQ0NsUmVTcmZheGVXUlJOTnNlM205NFo1QTR3?=
 =?utf-8?B?LzVNWXBpMXpPQWlsMWk4NFpFWXF0ZUlibkQwV2R5bDFFbkhHWjM1VTVCMHh4?=
 =?utf-8?B?TWJmUDJuZ2xzNjJMYmI0Q2RTTkRtc2xOcjFBZllhbHZyWmxwdlF5YVdRZW50?=
 =?utf-8?B?blExM2kzTGpoUFBQektsdElVMVAvajd4Vzd6d2o4SGhtaHZkc3JmcDZqcTRp?=
 =?utf-8?B?VXFhT2ljVC9UaDBMSkI4N0lNSWExMmNpc0FzeEUwVmY0MlpvaENDOC9UdlJD?=
 =?utf-8?B?aGFoQUNLd2UrU29iWVVERG51NERocTdSY2JoU0xQeDBkWHBzclozd2JNYUdX?=
 =?utf-8?B?MW9CdkkwNzhHTHdQc1d2TlRFbFVWU012NGNNajJGdmpNd3JVYklOeUpzS1VT?=
 =?utf-8?B?V1RaamVjaWpvL0NBUXFvRWtmc3p4RDFuTjVNRmlwV2FvODc1SUtBNkN5ZWJC?=
 =?utf-8?B?Z08zSXZVeUc1M3NCKzRQcU5iRGE2S1NKRU12alNDUGFEbzlPWVlHRDFwY0tF?=
 =?utf-8?B?WHJ2TW1GT2M0T2p4NE90U3ArWmJKUGQveWdEQ3FYeVVBUEJvZWs4bVhLaTNs?=
 =?utf-8?B?d21mY0hUQzIyWjBGL1Y4QTVMbHdGYjVRZms3NmFzZVA1RHBId3BpcmVTRFgv?=
 =?utf-8?B?OGNLYVgySnJIVlY3aEE1c0hpWlJIQ2xKOFkyKzNaaFYxckpkOG5adjNkZENF?=
 =?utf-8?B?RGRMZ29KZGVsYWRGSDdaWW9KeUZUZTMrRDFyUW1kc2xlTEdQZXVSWGNsUXZ0?=
 =?utf-8?B?ZExUUjB0SFJRQ3o2Rll6N29YTnBVWDhwVkVhejA3WGlGNkE0QWM2NDY4ZkdQ?=
 =?utf-8?B?eUhZRmtwdTN4N2M3RE5nQUxHQUVrOGN1K3poVGtreVo5cmdCVUJkZUhiU1I2?=
 =?utf-8?B?Rlo2eXY0MTBZNEllRDRIbmo4L0VUYzhKR21mYmFaZjZmTGFXdzljT1hIR0xa?=
 =?utf-8?B?aGNJZmtQYjFiWGxmU2hPVmVXRDR6aUpQM1V6aTQwbGYrdTE4RXFScWVQUlYx?=
 =?utf-8?B?aEJkNGxSQTAvS1BSZ3pISDNNRzZCVCtaRWRkbk05Uk5nTlhoOVlMTDhaYVRI?=
 =?utf-8?B?WVFwNjR3MUtPQ3pBMjNBV1JvZFlzZU1IMzM3ZWJsUmh2WEROb2FTZWtoQU0w?=
 =?utf-8?B?aFk4eE9NczV0WlNlcFJWVGVXNzBJcFh2b0xXcllNQk1qejhYVDAvNFJJRVFu?=
 =?utf-8?B?R2lYNGhHV1NnSHh1STByY1NBZlZwOHpYa3VERTdXbFRhY3hObS9WK2QyMU9N?=
 =?utf-8?B?UU5uTTlZdWVnbzZ1c3JJTStyNm5YRENmL2M3b2RWeVdaK09PQTRPSm4yWEFv?=
 =?utf-8?B?YjZFRDBLMzlDM1FRRFBNeUVXS25iaE1RSmowSjMzaE5rRjV5N0RxMUdiQndT?=
 =?utf-8?B?dWE5MTl6bkxsN0JseGVWbmtVYkdPOForWkxydlpOMHVvNUJXREpHTzNOYldh?=
 =?utf-8?B?d1g4dTgreUNPUHRtY1RGT2ZkajVtTTdmdU42ZkVJYStFNGhuTkh1cHJEMWhz?=
 =?utf-8?Q?5n6noIKOLZK6QHi0RE5pYYwMR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PCdJxKNrl6ugcCLUG4R0+YyrT4n8i2T5M70oxr5L/mNiyodHHOvfopqEKoRDn8ibBQGpH6E/PrKN20XfPlWQf1jdnI2p3+hhtF6jUdZsV2ukd92+x2orJXAwjfoUmvyWqJaS3gutOI/hkhrA+rJIJGdqk5U1C7X0f9RgWrCRgKiTim/9j6vdKo59veNtmuzqyXXncXqpHqjHFj/i+ei8DamyBiaBdAKcfzch+jZUrrwDTgasBG3ZrrD1SXfpDngSEqsIp/eCAtVwZFMc1BjVvFnQujunw/aLkzUQte7Ysh4dd/uB6wyd5ptnSPYQjKNsLTo9t2vq9bGCR8tn8KNb77ev0JDxr8poFNbS0d2aNt8yCACLNSd7mHGa9deGCrCBR0YkwB5jYBK2WpEyQUMDrV0dpL6fgDUguDMPVf+ByUI4t537d8QE46mnxGLiYL8ceORg5dml/ZTijVEQ7k3OkUj2KqY506+7bg11Wky9VjHW3uLmm2g3ajb1Nbr7GZQ5b6/FgyFmK3GjF/LjRK/hx7iIkY9+xb0jaNoHEXW5Re6BHELpggwVLU8fQ+QfBAUZTrCXOeV//FDaowGEqTyNObm9qtuvH+du1O/11UCQmD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21619b4-2af0-4124-157b-08ddcba2d6eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 17:44:01.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ev7rFegbtqgdYpto1QAIAcyY6MBeqNc5Oja8g1DjnVI5HQ38b3iE7bhSN9AVSqizw3duYeMJcjTIqu7rJf/P2o0fhO+ASbjscQm7cnQJADQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250152
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE1MCBTYWx0ZWRfX0J2Y46UUFoan
 PXrIoAXo6MP2uXLY2DkX3bYBRj2JehbBxlq98QsFlpKRkk0ltJznrCmO0kDxK0pwMWzbGpZxoLg
 svykwpmk+CDOZhJAFtCXqheO+TD5580msh9Vd48+gI6LSZUJ4xVn8CAk+WBYVwHOsX52lD/8DjP
 uqq9d5/U+Fo54T3wJEaGUsFjVhR50oncNjHJ9jGHbrO5jZN5ttFOFCC1gqQe4qhrk0wBLQbEeuQ
 HENUjXXCI71SSvSXFhUqNYHTZ8ybpTjaT5Yj9ByORMZQZxpk66vten1sTnIdm5sMTXvT6lyF/eg
 4TASkd1+c3OIpIv+yQmkmtGC9ZhXtO10Mv/K6Jol4fvjfRmB5I13sEYrFm0JenSivSxrzPlk0sE
 f2kQjaM5t0vecrsvBZg/BN/pfJlq9S1Q3oFfAOWFW2ptu1khppHlXILvdHPBkPGcG1q8pPNs
X-Proofpoint-ORIG-GUID: hK-MFq9u-vYoKLxrQUPUw5lCPDb52VKN
X-Proofpoint-GUID: hK-MFq9u-vYoKLxrQUPUw5lCPDb52VKN
X-Authority-Analysis: v=2.4 cv=JIQ7s9Kb c=1 sm=1 tr=0 ts=6883c26e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=KDiKAEBMLgBjqfuocVMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600


> +/* NRT Buffer descriptor definition
> + * Each buffer descriptor points to a max 32 byte block and has 32 bit in size
> + * to have atomic operation.
> + * PRU can address bytewise into memory.
> + * Definition of 32 bit descriptor is as follows
> + *
> + * Bits		Name			Meaning
> + * =============================================================================
> + * 0..7		Index		points to index in buffer queue, max 256 x 32
> + *				byte blocks can be addressed
> + * 6		LookupSuccess	For switch, FDB lookup was successful (source
> + *				MAC address found in FDB).
> + *				For RED, NodeTable lookup was successful.
> + * 7		Flood		Packet should be flooded (destination MAC
> + *				address found in FDB). For switch only.
> + * 8..12	Block_length	number of valid bytes in this specific block.
> + *				Will be <=32 bytes on last block of packet
> + * 13		More		"More" bit indicating that there are more blocks
> + * 14		Shadow		indicates that "index" is pointing into shadow
> + *				buffer
> + * 15		TimeStamp	indicates that this packet has time stamp in
> + *				separate buffer - only needed of PTCP runs on

only needed if PTCP runs on host

> + *				host
> + * 16..17	Port		different meaning for ingress and egress,
> + *				Ingress: Port = 0 indicates phy port 1 and
> + *				Port = 1 indicates phy port 2.
> + *				Egress: 0 sends on phy port 1 and 1 sends on
> + *				phy port 2. Port = 2 goes over MAC table
> + *				look-up
> + * 18..28	Length		11 bit of total packet length which is put into
> + *				first BD only so that host access only one BD
> + * 29		VlanTag		indicates that packet has Length/Type field of
> + *				0x08100 with VLAN tag in following byte
> + * 30		Broadcast	indicates that packet goes out on both physical
> + *				ports,	there will be two bd but only one buffer
> + * 31		Error		indicates there was an error in the packet
> + */
> +#define PRUETH_BD_START_FLAG_MASK	BIT(0)
> +#define PRUETH_BD_START_FLAG_SHIFT	0
> +
> +#define PRUETH_BD_HSR_FRAME_MASK	BIT(4)
> +#define PRUETH_BD_HSR_FRAME_SHIFT	4
> +
> +#define PRUETH_BD_SUP_HSR_FRAME_MASK	BIT(5)
> +#define PRUETH_BD_SUP_HSR_FRAME_SHIFT	5
> +
> +#define PRUETH_BD_LOOKUP_SUCCESS_MASK	BIT(6)
> +#define PRUETH_BD_LOOKUP_SUCCESS_SHIFT	6
> +
> +#define PRUETH_BD_SW_FLOOD_MASK		BIT(7)
> +#define PRUETH_BD_SW_FLOOD_SHIFT	7
> +
> +#define	PRUETH_BD_SHADOW_MASK		BIT(14)
> +#define	PRUETH_BD_SHADOW_SHIFT		14
> +
> +#define PRUETH_BD_TIMESTAMP_MASK	BIT(15)
> +#define PRUETH_BD_TIMESTAMP_SHIT	15

typo PRUETH_BD_TIMESTAMP_SHIT -> PRUETH_BD_TIMESTAMP_SHIFT

> +
> +#define PRUETH_BD_PORT_MASK		GENMASK(17, 16)
> +#define PRUETH_BD_PORT_SHIFT		16
> +
> +#define PRUETH_BD_LENGTH_MASK		GENMASK(28, 18)
> +#define PRUETH_BD_LENGTH_SHIFT		18
> +
> +#define PRUETH_BD_BROADCAST_MASK	BIT(30)
> +#define PRUETH_BD_BROADCAST_SHIFT	30
> +
> +#define PRUETH_BD_ERROR_MASK		BIT(31)
> +#define PRUETH_BD_ERROR_SHIFT		31
> +

Thanks,
Alok


Return-Path: <netdev+bounces-111227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04C1930489
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 10:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149481F21B96
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 08:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4E3AC36;
	Sat, 13 Jul 2024 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="r4W2PWK9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842984501E;
	Sat, 13 Jul 2024 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720859663; cv=fail; b=Wwy9iFVHlhPEdcWnBQ4EI54z53/czGJJ1m1WUpvbOgkaUgawf1ubHcqxJxvL3WGhmPEX3RcHHWQeogS/tOCcd1ivvvD1AyfNEHGLAmHqiEVSVcRkUKN8loYrLOyCCzfLkdLE9Oe+PZH0CJxQgJeKKCR7lzq0yKVGbgfhT4IkpXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720859663; c=relaxed/simple;
	bh=n14HGyjqpYaKCcy6Vkc3xeEBlzvnOqc61n3irsEdkCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FsYWhoSfIFYUamVEMRkUoH2wDEtTrEuMVSYyUQ9MncjtUzpWccBlM5dQ6ERsKc+V9pUZ+4O+kueVIiq3JQ02RsFBGz7QG+MfPhZ/96TldV2DuqvlfajI94F2WDnZiXDrSfqrfVUFHriqRbaIkhV/WEoVuf7tVvbNYEVxlziLOzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=r4W2PWK9 reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46D6YA2G001532;
	Sat, 13 Jul 2024 01:33:48 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40b5m6ap4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 01:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V17iIwxz9byatS3STH3QS7mfysmXh/pZOobrSnMn00ziAqXgkOtEmMp+3s2Yr53n2S6YraFvR+U6bUmbOWtmR+qm6Bjze1J39WGjOUb+eDXteNapo+vpEdoWPLpDHRKSRFdftgYTmn+f+UI4DA3QGSmsYdBGzLv4NV2crD9T7/ErvfakPAmraTBF+Ryp0A9gh7WIJl7E165LWJEDlZ1/LQZt5Pe39xpmCqukk/ruGseK+BvzwTyP9BUKgbNEZOIe1tf4jb4FK88IS3MeEaKAezQj6gxiJQi4VEZRxIMOPkDU8e+HgxfHhAfEqkAAUyJKLs15KdMCRB0pRHTTmuNFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6goTdx1ARaQd1Oqnt6zbk7Y9/EShGkEkYwNQuzG4bCQ=;
 b=V8VeyuQV3oIRsHYQzVPxwCcHBj1tV9d5YWBzOpM1tfHfRy7BmA1oNxx27LR2Z3/UVCBJbAVADlpV3w9+reOdqs4/V1koH+7BxEqjpL70zZo0Nd8GK0Aqfg71g5e7Ddfso8/kNJaDDkMnlOEEW3UAsCx0HTjF16N/Qkt/cDxgQO7S+axPO5ftinZGpwFDO0OMxPQ9KEc5BO4xKQETCp1Wj8yp4cuWGq3L53xci0f3+J7USg+5cFQZbP2tZtoy7SKYzyvefkCvKH16PMjKaRzeseNlGjHfAa9e39w72ixCp9wvuStdByjnzAAaQTEhSA++YbnJt3dJnzvwQ0EgRF5YWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6goTdx1ARaQd1Oqnt6zbk7Y9/EShGkEkYwNQuzG4bCQ=;
 b=r4W2PWK96B1ce+tEmQ0xOCzxtcGvOYBoMXNaE4CSUMfM8FKrgyU4iIBSo5jbwedgEcwWyuLOCGPX/Dne1pR5LQXez8P3vwyD4YbNk3cFHJ5HMOxOnOGlrvhIcYTlMZTfVD+c4wqnS0FLx6+2AGcsqrFkVPK4jnuzW7XE75eNTm4=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SN7PR18MB3839.namprd18.prod.outlook.com (2603:10b6:806:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.41; Sat, 13 Jul
 2024 08:33:43 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%4]) with mapi id 15.20.7762.020; Sat, 13 Jul 2024
 08:33:42 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: MD Danish Anwar <danishanwar@ti.com>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Andrew
 Lunn <andrew@lunn.ch>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "srk@ti.com" <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: RE: [EXTERNAL] [PATCH net-next v3] net: ti: icssg-prueth: Split out
 common object into module
Thread-Topic: [EXTERNAL] [PATCH net-next v3] net: ti: icssg-prueth: Split out
 common object into module
Thread-Index: AQHa1FQURN+agENc/kaUevnfzJpFObH0VPpA
Date: Sat, 13 Jul 2024 08:33:42 +0000
Message-ID: 
 <BY3PR18MB4707DE9F8280CE67EDF3D146A0A72@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240712120636.814564-1-danishanwar@ti.com>
In-Reply-To: <20240712120636.814564-1-danishanwar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SN7PR18MB3839:EE_
x-ms-office365-filtering-correlation-id: 1a2961f0-b67c-4fbf-f696-08dca31680ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SkxrUTJzcVN4QTBPU3RTcGFoVFk4Z1JnSkNEUFV4Si83YXVRYTN4LytteWUz?=
 =?utf-8?B?M0hULy9sbnpCYXZheXFvWVdsT3pvUHhvUEVLMG9WWVVUV1lYK25CRHBiRzd3?=
 =?utf-8?B?TTg3eXk4V012bFVvNjRhRVN1QlByeTRuR1RyQ3pOQVl4VkFRdFNVUzl5UjdM?=
 =?utf-8?B?bXFSMDY2dFQvTmtDMVlvOGIyZiszS2kvLzZpczhSZWpaa2dPbDI3bjVRcHpu?=
 =?utf-8?B?QWs0YW13QmVaaWVNMnMxTlpudHUrSUIxR0dpQUdQM1MzV3BJQ2x1d2Z3bnAx?=
 =?utf-8?B?V0ZEVGxaQTNuQ0V5UG9QMGt2czJFUTJ4U082dFhBU3RYc0JUWm5YVHFIcDYw?=
 =?utf-8?B?TVlWQmZIQ3BBaFB5STB2TjdlWEJ0ZjNXRmpYTEVxS2sxemlLdFhIZDdyNTFO?=
 =?utf-8?B?UkJtNkZrL3hoVmovd2U1RXJCcFNYVVYrQWtOS1ozMG1FdUZqbEQ2UzI5WGg2?=
 =?utf-8?B?Y25NUkU2dnY3Q05ObkVVSFRMSCs4alFpc0RjRm5HZEF2Z3lQRXVMNEJQSUVq?=
 =?utf-8?B?OWhiNTlJRnJ5ZFovU21rMEJyYSsvNG1nd0lNNzYxVHdrVlFlbDJEM3JBUHFN?=
 =?utf-8?B?dnJWVm1KOTlHTUZFeHQrR0FYVXF2YU9heDFmb0FhMjNmL3I4R3ZYV0J1SUxu?=
 =?utf-8?B?OE9FU0JDc0g1OUlaOGFWeklsL2hScGpTTFY4Q1ljTCtvM2xodDlCRnVZYmVq?=
 =?utf-8?B?K1BrSlg2eFNJSk41Q2k2ZzdZcWlKRVcxeXoyOEFvejJ1dlJkUVZibUhxYStQ?=
 =?utf-8?B?bnY1bjZLWFB2SzQyS0owVi9vektaYnd0ZWcrTXorNlVUdXR5TUJwbG1OZmtL?=
 =?utf-8?B?dDEvMEwrV3ZKQ0RzLzJxbGtxdkJxZXpZR2NLVmhUdlBkN3JrWS9GL1FHOEI0?=
 =?utf-8?B?R3NYc3dQMW1WZWV1VTJMbWdjMDlXcFBkYWdmbGV3UmVobVlmQmpmUXh0V1Nu?=
 =?utf-8?B?bFh2Z3BFS3R2QkhUc0xUeDN1NjZscXBQSXhtU1ZUM1hvYVh6ZVhaS3ZwVWJF?=
 =?utf-8?B?TytnZE0vUGpBQ1pkempYRUlNWFBvYUR1TW9aUTloSGJDeklJYjZ4RHR2V3lr?=
 =?utf-8?B?ZXlpMWhoUzFta1FuYlI0SzdlYU5iVkxlMTdaTGtKZ0tteWtLVzFUL3NaOGl4?=
 =?utf-8?B?OExiTzIxbWZ5Y0h2Q2MycHMrU0NGWXErMEVIeUhGZE5LREE4SVRJa1hMNGh6?=
 =?utf-8?B?R3BJN1lYUzZ0MUVMMkMzZklCenE0OWEvYjhKS0VlTnJxMHNBc3J5M0RvQllW?=
 =?utf-8?B?YmxMOGxCVFg5UlF0RjByZWhpWENXSUE4MmJsOHU2TGtiZXR4ak45SW1tZGti?=
 =?utf-8?B?KzhteWZ0N0hZRW00RUNkRG8ySGpjZmVUVUMxYWpOemdmbjkyUHBnckdzbVdN?=
 =?utf-8?B?MXBOT25tb1BUdWZoSVZFclkveTZrUXpuSmkzWmoxREMvMlFGdnJva1NaQ2Vo?=
 =?utf-8?B?elMrQmFCb0ZrTWsrNlN4MFVmbFN1R1hTNHR5UUpzc2tDYlU0UTRua0RXT0RW?=
 =?utf-8?B?MnNRdEJDUGdPOWJDSlpLQmRyTGhNUzh2VjBiR2RFRVNzRzZCS045bTR5WkdN?=
 =?utf-8?B?ZlFiaFFzMzlmZ09aMFIvY3VtRnBtajZYUkRUWW9yMWJ4TGdBcDBwL1NndHh4?=
 =?utf-8?B?elc3djN1Y2tORWVndEwyaTZ0TVlKYlRMQW9iZkVwVitaWlJ2SnJMOXJOQTBa?=
 =?utf-8?B?QjlJU1RzM1Q5eHJQMHpTRUtubHJUVTF3K21ETVRrbFV2bWlsS1oydVpqV09F?=
 =?utf-8?B?eGZXM2g0cVhhYkRDYmdzWnYwYno3emVENHpiYnMwTkprQ1dGY0pBMVVrejlx?=
 =?utf-8?B?dFU1eFFlY01CSjhQb3ZMbmZKaGtuT20reFBNbGxFaUsvNk5NSUFTckZhN2ky?=
 =?utf-8?Q?zdxtSkJd7LWiV?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Lzd6ZWg3OEszQjJpbS9FVW8xVTRIUENXNWwycVhoSmFRRlcwY2hRTFd0V3Bm?=
 =?utf-8?B?NWV6YkNYOU1PcmxacnEyN2tzQ0lhNW5MSGZjVlE3RUVDbU13WXFjajZqeitn?=
 =?utf-8?B?VHpwdTBjd21qOXFNV3M1QnJBblVoSW5nOUpDSkhwZU0rSThKM2VHUG5seHd4?=
 =?utf-8?B?dEJwelpOU0c3WUIzeWFVVEpKOVE4WnZlbmNCZjFVbGRnUlRjNXh5MzdNa1Zq?=
 =?utf-8?B?TDVLS1FCK3ZKNUxtZ1paU2FQMDhkV1I2M1dwL2o1cEhadE1Kb2s1VnRpTjVR?=
 =?utf-8?B?cWIvZXJQTTUzNkR2R09RVzBuT1lkWGhZd2JsMkhDMnpRVmhiR0YzS3NYZnZH?=
 =?utf-8?B?Q3JzVG1rTlJVRThoL3FTaWRuSS9FU0IxVnc5a0xRT0VJbUVMRGRib1VEeFpY?=
 =?utf-8?B?ZmNBcUc0a0xrYUtsT0svb1c4ajhEc2oyU0FrNDJma3N0TUNyYXl2Q05ROER0?=
 =?utf-8?B?S1VGUXpMTHZnaGhRTDFjVXM5d2psbENrM1J4WEQxUHM1ZmlaeHNUV240WWdU?=
 =?utf-8?B?OHlKNWpHV1FoaE1HUENYcDE3YjNEZ29ZQnc4cVlBR2VrWVlUQ1lwcUs1VFRI?=
 =?utf-8?B?NXIwUUx4WmRBTlAvZ2UrdENwQWhBS0o3c0RhOGx3bE5tSjBSUEJCTnJaUXoz?=
 =?utf-8?B?NFM1ZFBIc05RR1QzSXlDZG5sR3lNRnY0VXpRc3MwbXVGRXBkZVRyRXZsWSs3?=
 =?utf-8?B?Njh1TmtyTDVlb2kzLzUyeml4MW1YU2Qwdy9tbXhNcHdZaXpzNGZjUFFqQXBv?=
 =?utf-8?B?dms1UWdLL0xDVWlORlpFdUlwL0dVWU1PdUM5UGZsMGhpVTVmdjhKYmkyU2t6?=
 =?utf-8?B?N3ZpSy9Kb0Q0aEFkR2dTQVlKcVJFMHhwUmR3RG9jYmJNSTgxMW9VUlVQOUJD?=
 =?utf-8?B?RmJrY3pqTVAvUDlOVGFFSXpyem5mb2ZHNm5MV2d6T0VsZldHbUd4WmVhNVUv?=
 =?utf-8?B?cll3Tk1uVFlxNUR4Mkl4c3RadG9wNHM3aFBsOVR1YnFiUzBOUWN4ZDI3VmJL?=
 =?utf-8?B?dGRiMFluQ2lTVHdDQ0RxY3hxSTE1TDFYamZNRlpzL3Qya1g2cndJYVpMTFNF?=
 =?utf-8?B?OUNBMGxMTWN6T3ZKbVlvTWEweTMzSTFCOE5LdWhsRHlRbUVBMFI4NHBUVk1Y?=
 =?utf-8?B?N28raEtUb0JlSGJYK1pXR3ZiS0w4cDN4Y2VaeWRwMDZGK0tZQ1JlOE9nSVFh?=
 =?utf-8?B?YXlpNHpxYisyanJ0dVh5OHRqK0REQ0RZR3paSVVxSG5zR0hNalM2V2pPRHVj?=
 =?utf-8?B?RXFpdjRJVG1IN1NWRkZrdE5XN3lnTUptMzRxVUlqWEVBekgrYmd2bnNCZ0J3?=
 =?utf-8?B?RDZ1cG4zeDZOaWNLUm9aNUhycm4vbFVpYWdwcmFqZVNzSDcvc3g1NGR1ZGJC?=
 =?utf-8?B?bksvcytDNXk0ZWZOQ09mNytmVFZIclhmckVMVlNtaXA2enFRdW9xSlJlOGlv?=
 =?utf-8?B?OG9BdFBaUGg4MnZYUEFsWjNadFdpSER6dWVuZUFhUllST2RPdHNEYnhKdXhI?=
 =?utf-8?B?VkFIeUZUSzQrM3p0T0s1SjNCQkxsdVgzekd2bUE3S3pLRnk5NTFxTHJTcHhG?=
 =?utf-8?B?TWt0WkxJVzdVYXNUaVpIY3B3blpQVHkxb3oyRUgveWJMajFZZ3Rub0hXb2pP?=
 =?utf-8?B?LytlUmRqc1hJTHduZ0hPeDlDZTRyV3NIaHVoUnNCWERJQVl4QlhaaTVWb3Zy?=
 =?utf-8?B?ck93WUcvR0JrRm1YUlJVQ3J5cTdpUTRGeWJDSmVMaElTWUM0UVJJcjRRYXc3?=
 =?utf-8?B?V2dnamN4cEVrM1FJQ0NldUN3NjJleUsyMExXckhPNXlCTzkyNWZseEVTU25a?=
 =?utf-8?B?a1JGU3czdjZpSjRwM3VYL2JWZ2xwd0NOTHZZUHU4MVF3ajJlZkxvS2pqc2R4?=
 =?utf-8?B?TmNKTkxzZStUMkhYOWtQYml6SlQ0ZDFnd1hrSWpnM1FuaGJIYlo2M2NsaWZ6?=
 =?utf-8?B?eEVFTzBNbSs2TWxnYVZTYzFTYi9MSk93eFhIZ3FGL3dXdlFpN1YzZWU1Kzc5?=
 =?utf-8?B?bEMzTUNFRzFoVGIwT0VncUNuUWFDQlJWenhQYmZ2QmNOKzR5VW9ZS2doTzc2?=
 =?utf-8?B?Q0N5WHgvZ29iNlJ2RHFIVnVtY2RINThHeVpCUEdxeGJ0eVFmQlRHL1Q4ZFpt?=
 =?utf-8?Q?Qvp7kFAxijGgO+LH2F9c+Oq0N?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2961f0-b67c-4fbf-f696-08dca31680ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2024 08:33:42.2791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odCRdM8wPqG3ha6DUa1njkFihSV2Ouo8En+o4/KlxOZvS3Dx6k/saIIAi7aenyNoKR9QEzdgxOBqvYU0WQRNvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3839
X-Proofpoint-GUID: hqDYe8iM4qqQ9n3cnTlfc6krfMFiDOZB
X-Proofpoint-ORIG-GUID: hqDYe8iM4qqQ9n3cnTlfc6krfMFiDOZB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_04,2024-07-11_01,2024-05-17_01

> -----Original Message-----
> From: MD Danish Anwar <danishanwar@ti.com>
> Sent: Friday, July 12, 2024 5:37 PM
> To: Heiner Kallweit <hkallweit1@gmail.com>; Simon Horman
> <horms@kernel.org>; Dan Carpenter <dan.carpenter@linaro.org>; Jan Kiszka
> <jan.kiszka@siemens.com>; Wolfram Sang <wsa+renesas@sang-
> engineering.com>; Diogo Ivo <diogo.ivo@siemens.com>; Andrew Lunn
> <andrew@lunn.ch>; Roger Quadros <rogerq@kernel.org>; MD Danish Anwar
> <danishanwar@ti.com>; Paolo Abeni <pabeni@redhat.com>; Jakub Kicinski
> <kuba@kernel.org>; Eric Dumazet <edumazet@google.com>; David S. Miller
> <davem@davemloft.net>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; srk@ti.com; Vignesh Raghavendra
> <vigneshr@ti.com>; Thorsten Leemhuis <linux@leemhuis.info>
> Subject: [EXTERNAL] [PATCH net-next v3] net: ti: icssg-prueth: Split out
> common object into module
>=20
> icssg_prueth.=E2=80=8Ac and icssg_prueth_sr1.=E2=80=8Ac drivers use multi=
ple common .c files.
> These common objects are getting added to multiple modules. As a result
> when both drivers are enabled in .config, below warning is seen.
> drivers/net/ethernet/ti/Makefile:=20
> icssg_prueth.c and icssg_prueth_sr1.c drivers use multiple common .c file=
s.
> These common objects are getting added to multiple modules. As a result
> when both drivers are enabled in .config, below warning is seen.
>=20
> drivers/net/ethernet/ti/Makefile: icssg/icssg_common.o is added to multip=
le
> modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_classifier.o is added to mu=
ltiple
> modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_config.o is added to multip=
le
> modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_mii_cfg.o is added to multi=
ple
> modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_stats.o is added to multiple
> modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_ethtool.o is added to multi=
ple
> modules: icssg-prueth icssg-prueth-sr1
>=20
> Fix this by building a new module (icssg.o) for all the common objects.
> Both the driver can then depend on this common module.
>=20
> Some APIs being exported have emac_ as the prefix which may result into
> confusion with other existing APIs with emac_ prefix, to avoid confusion,
> rename the APIs being exported with emac_ to icssg_ prefix.
>=20
> This also fixes below error seen when both drivers are built.
> ERROR: modpost: "icssg_queue_pop"
> [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> ERROR: modpost: "icssg_queue_push"
> [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
>=20
> Reported-and-tested-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_oe-2Dkbuild-2Dall_202405182038.ncf1mL7Z-2Dlkp-
> 40intel.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3Dc3MsgrR-U-
> HFhmFd6R4MWRZG-8QeikJn5PkjqMTpBSg&m=3DnS910f-bVPllINeciu3zcX-
> RmmuaN-hU--Y3YDvgknBD5A8sRk6hE3pZSocV-
> 37f&s=3DsIjxhBrYXEW3mtC1p8o5MaV-xpJ3n16Ct0mRhE52PCQ&e=3D
> Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to conf=
igure
> FDB")
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
>=20
> NOTE: This is only applicable on net-next but not on net as the patch that
> introduced this dependency is part of net-next.
>=20
> v2 -> v3:
> *) Renamed APIs being exported with emac_ prefix to icssg_ prefix as
> suggested
>    by Andrew Lunn <andrew@lunn.ch> to avoid confusion with
> arc/emac_rockchip.c,
>    allwinner/sun4i-emac.c, ibm/emac/, and qualcomm/emac/
> *) Modified commit message to describe renaming APIs as part of this
> commit as well.
> *) Rebased on latest net-next/main.
> *) Added RB tag of Roger Quadros <rogerq@kernel.org>
> *) Added Reported-and-tested-by tag of Thorsten Leemhuis
> <linux@leemhuis.info>
>=20
> v1 -> v2:
> *) Instead of just adding the missing module to icssg-prueth-sr1, the
>    patch also splits the common objects into new module as suggested by
>    Andrew Lunn <andrew@lunn.ch>
> *) Not carrying Tested-by tag of Thorsten Leemhuis <linux@leemhuis.info>
>    as this patch has significant diff over v1. I would like him to test
>    this patch again.
>=20
> v1 https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_all_20240605035617.2189393-2D1-2Ddanishanwar-
> 40ti.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3Dc3MsgrR-U-
> HFhmFd6R4MWRZG-8QeikJn5PkjqMTpBSg&m=3DnS910f-bVPllINeciu3zcX-
> RmmuaN-hU--Y3YDvgknBD5A8sRk6hE3pZSocV-
> 37f&s=3D4oHpIW_5r75GXMLEQgIGHxzDsdm7kfhtPGzhDC8__pk&e=3D
> v2 https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_all_20240606073639.3299252-2D1-2Ddanishanwar-
> 40ti.com_-23t&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3Dc3MsgrR-U-
> HFhmFd6R4MWRZG-8QeikJn5PkjqMTpBSg&m=3DnS910f-bVPllINeciu3zcX-
> RmmuaN-hU--Y3YDvgknBD5A8sRk6hE3pZSocV-
> 37f&s=3DUqJ0NW10QJdFPoyOUHFVAMtBHx7ltjQI2PEhJk91M4E&e=3D
>=20
>  drivers/net/ethernet/ti/Makefile              | 32 ++++++------
>  .../net/ethernet/ti/icssg/icssg_classifier.c  |  6 +++
> drivers/net/ethernet/ti/icssg/icssg_common.c  | 50 +++++++++++++++----
> drivers/net/ethernet/ti/icssg/icssg_config.c  | 15 +++++-
> drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  1 +
> drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c |  4 ++
> drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 38 +++++++-------
> drivers/net/ethernet/ti/icssg/icssg_prueth.h  | 22 ++++----
> .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  | 14 +++---
> drivers/net/ethernet/ti/icssg/icssg_queues.c  |  2 +
>  drivers/net/ethernet/ti/icssg/icssg_stats.c   |  3 +-
>  .../net/ethernet/ti/icssg/icssg_switchdev.c   |  4 +-
>  12 files changed, 122 insertions(+), 69 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ti/Makefile
> b/drivers/net/ethernet/ti/Makefile
> index 59cd20a38267..cbcf44806924 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -31,22 +31,18 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_AM65_CPSW_QOS)
> +=3D am65-cpsw-qos.o
>  ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) +=3D am65-
> cpsw-switchdev.o
>  obj-$(CONFIG_TI_K3_AM65_CPTS) +=3D am65-cpts.o
>=20
> -obj-$(CONFIG_TI_ICSSG_PRUETH) +=3D icssg-prueth.o -icssg-prueth-y :=3D
> icssg/icssg_prueth.o \
> -		  icssg/icssg_common.o \
> -		  icssg/icssg_classifier.o \
> -		  icssg/icssg_queues.o \
> -		  icssg/icssg_config.o \
> -		  icssg/icssg_mii_cfg.o \
> -		  icssg/icssg_stats.o \
> -		  icssg/icssg_ethtool.o \
> -		  icssg/icssg_switchdev.o
> -obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) +=3D icssg-prueth-sr1.o -icssg-prueth-
> sr1-y :=3D icssg/icssg_prueth_sr1.o \
> -		      icssg/icssg_common.o \
> -		      icssg/icssg_classifier.o \
> -		      icssg/icssg_config.o \
> -		      icssg/icssg_mii_cfg.o \
> -		      icssg/icssg_stats.o \
> -		      icssg/icssg_ethtool.o
> +obj-$(CONFIG_TI_ICSSG_PRUETH) +=3D icssg-prueth.o icssg.o icssg-prueth-y
> +:=3D icssg/icssg_prueth.o icssg/icssg_switchdev.o
> +
> +obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) +=3D icssg-prueth-sr1.o icssg.o
> +icssg-prueth-sr1-y :=3D icssg/icssg_prueth_sr1.o
> +
> +icssg-y :=3D icssg/icssg_common.o \
> +	   icssg/icssg_classifier.o \
> +	   icssg/icssg_queues.o \
> +	   icssg/icssg_config.o \
> +	   icssg/icssg_mii_cfg.o \
> +	   icssg/icssg_stats.o \
> +	   icssg/icssg_ethtool.o
> +
>  obj-$(CONFIG_TI_ICSS_IEP) +=3D icssg/icss_iep.o diff --git
> a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> index f7d21da1a0fb..9ec504d976d6 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> @@ -297,6 +297,7 @@ void icssg_class_set_mac_addr(struct regmap
> *miig_rt, int slice, u8 *mac)
>  		     mac[2] << 16 | mac[3] << 24));
>  	regmap_write(miig_rt, offs[slice].mac1, (u32)(mac[4] | mac[5] << 8));
> }
> +EXPORT_SYMBOL_GPL(icssg_class_set_mac_addr);
>=20
>  static void icssg_class_ft1_add_mcast(struct regmap *miig_rt, int slice,
>  				      int slot, const u8 *addr, const u8 *mask)
> @@ -360,6 +361,7 @@ void icssg_class_disable(struct regmap *miig_rt, int
> slice)
>  	/* clear CFG2 */
>  	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);  }
> +EXPORT_SYMBOL_GPL(icssg_class_disable);
>=20
>  void icssg_class_default(struct regmap *miig_rt, int slice, bool allmult=
i,
>  			 bool is_sr1)
> @@ -390,6 +392,7 @@ void icssg_class_default(struct regmap *miig_rt, int
> slice, bool allmulti,
>  	/* clear CFG2 */
>  	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);  }
> +EXPORT_SYMBOL_GPL(icssg_class_default);
>=20
>  void icssg_class_promiscuous_sr1(struct regmap *miig_rt, int slice)  { @=
@ -
> 408,6 +411,7 @@ void icssg_class_promiscuous_sr1(struct regmap *miig_rt,
> int slice)
>  		regmap_write(miig_rt, offset, data);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(icssg_class_promiscuous_sr1);
>=20
>  void icssg_class_add_mcast_sr1(struct regmap *miig_rt, int slice,
>  			       struct net_device *ndev)
> @@ -449,6 +453,7 @@ void icssg_class_add_mcast_sr1(struct regmap
> *miig_rt, int slice,
>  		slot++;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(icssg_class_add_mcast_sr1);
>=20
>  /* required for SAV check */
>  void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_a=
ddr)
> @@ -460,3 +465,4 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt,
> int slice, u8 *mac_addr)
>  	rx_class_ft1_set_da_mask(miig_rt, slice, 0, mask_addr);
>  	rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);  }
> +EXPORT_SYMBOL_GPL(icssg_ft1_set_mac_addr);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c
> b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 2f716c0d7060..b9d8a93d1680 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -51,6 +51,7 @@ void prueth_cleanup_rx_chns(struct prueth_emac
> *emac,
>  	if (rx_chn->rx_chn)
>  		k3_udma_glue_release_rx_chn(rx_chn->rx_chn);
>  }
> +EXPORT_SYMBOL_GPL(prueth_cleanup_rx_chns);
>=20
>  void prueth_cleanup_tx_chns(struct prueth_emac *emac)  { @@ -71,6 +72,7
> @@ void prueth_cleanup_tx_chns(struct prueth_emac *emac)
>  		memset(tx_chn, 0, sizeof(*tx_chn));
>  	}
>  }
> +EXPORT_SYMBOL_GPL(prueth_cleanup_tx_chns);
>=20
>  void prueth_ndev_del_tx_napi(struct prueth_emac *emac, int num)  { @@ -
> 84,6 +86,7 @@ void prueth_ndev_del_tx_napi(struct prueth_emac *emac, int
> num)
>  		netif_napi_del(&tx_chn->napi_tx);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(prueth_ndev_del_tx_napi);
>=20
>  void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
>  		      struct cppi5_host_desc_t *desc) @@ -120,6 +123,7 @@
> void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
>=20
>  	k3_cppi_desc_pool_free(tx_chn->desc_pool, first_desc);  }
> +EXPORT_SYMBOL_GPL(prueth_xmit_free);
>=20
>  int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  			     int budget, bool *tdown)
> @@ -264,6 +268,7 @@ int prueth_ndev_add_tx_napi(struct prueth_emac
> *emac)
>  	prueth_ndev_del_tx_napi(emac, i);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(prueth_ndev_add_tx_napi);
>=20
>  int prueth_init_tx_chns(struct prueth_emac *emac)  { @@ -344,6 +349,7
> @@ int prueth_init_tx_chns(struct prueth_emac *emac)
>  	prueth_cleanup_tx_chns(emac);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(prueth_init_tx_chns);
>=20
>  int prueth_init_rx_chns(struct prueth_emac *emac,
>  			struct prueth_rx_chn *rx_chn,
> @@ -453,6 +459,7 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>  	prueth_cleanup_rx_chns(emac, rx_chn, max_rflows);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(prueth_init_rx_chns);
>=20
>  int prueth_dma_rx_push(struct prueth_emac *emac,
>  		       struct sk_buff *skb,
> @@ -490,6 +497,7 @@ int prueth_dma_rx_push(struct prueth_emac *emac,
>  	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, 0,
>  					desc_rx, desc_dma);
>  }
> +EXPORT_SYMBOL_GPL(prueth_dma_rx_push);
>=20
>  u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns)  { @@ -
> 505,6 +513,7 @@ u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32
> cycle_time_ns)
>=20
>  	return ns;
>  }
> +EXPORT_SYMBOL_GPL(icssg_ts_to_ns);
>=20
>  void emac_rx_timestamp(struct prueth_emac *emac,
>  		       struct sk_buff *skb, u32 *psdata) @@ -636,7 +645,7 @@
> static int prueth_tx_ts_cookie_get(struct prueth_emac *emac)  }
>=20
>  /**
> - * emac_ndo_start_xmit - EMAC Transmit function
> + * icssg_ndo_start_xmit - EMAC Transmit function
>   * @skb: SKB pointer
>   * @ndev: EMAC network adapter
>   *
> @@ -647,7 +656,7 @@ static int prueth_tx_ts_cookie_get(struct
> prueth_emac *emac)
>   *
>   * Return: enum netdev_tx
>   */
> -enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device
> *ndev)
> +enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct
> +net_device *ndev)
>  {
>  	struct cppi5_host_desc_t *first_desc, *next_desc, *cur_desc;
>  	struct prueth_emac *emac =3D netdev_priv(ndev); @@ -806,6 +815,7
> @@ enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct
> net_device *ndev)
>  	netif_tx_stop_queue(netif_txq);
>  	return NETDEV_TX_BUSY;
>  }
> +EXPORT_SYMBOL_GPL(icssg_ndo_start_xmit);
>=20
>  static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)  { @@ -
> 831,6 +841,7 @@ irqreturn_t prueth_rx_irq(int irq, void *dev_id)
>=20
>  	return IRQ_HANDLED;
>  }
> +EXPORT_SYMBOL_GPL(prueth_rx_irq);
>=20
>  void prueth_emac_stop(struct prueth_emac *emac)  { @@ -855,6 +866,7
> @@ void prueth_emac_stop(struct prueth_emac *emac)
>  	rproc_shutdown(prueth->rtu[slice]);
>  	rproc_shutdown(prueth->pru[slice]);
>  }
> +EXPORT_SYMBOL_GPL(prueth_emac_stop);
>=20
>  void prueth_cleanup_tx_ts(struct prueth_emac *emac)  { @@ -867,8 +879,9
> @@ void prueth_cleanup_tx_ts(struct prueth_emac *emac)
>  		}
>  	}
>  }
> +EXPORT_SYMBOL_GPL(prueth_cleanup_tx_ts);
>=20
> -int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
> +int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>  {
>  	struct prueth_emac *emac =3D prueth_napi_to_emac(napi_rx);
>  	int rx_flow =3D emac->is_sr1 ?
> @@ -905,6 +918,7 @@ int emac_napi_rx_poll(struct napi_struct *napi_rx, int
> budget)
>=20
>  	return num_rx;
>  }
> +EXPORT_SYMBOL_GPL(icssg_napi_rx_poll);
>=20
>  int prueth_prepare_rx_chan(struct prueth_emac *emac,
>  			   struct prueth_rx_chn *chn,
> @@ -930,6 +944,7 @@ int prueth_prepare_rx_chan(struct prueth_emac
> *emac,
>=20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(prueth_prepare_rx_chan);
>=20
>  void prueth_reset_tx_chan(struct prueth_emac *emac, int ch_num,
>  			  bool free_skb)
> @@ -944,6 +959,7 @@ void prueth_reset_tx_chan(struct prueth_emac
> *emac, int ch_num,
>  		k3_udma_glue_disable_tx_chn(emac->tx_chns[i].tx_chn);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(prueth_reset_tx_chan);
>=20
>  void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
>  			  int num_flows, bool disable)
> @@ -956,11 +972,13 @@ void prueth_reset_rx_chan(struct prueth_rx_chn
> *chn,
>  	if (disable)
>  		k3_udma_glue_disable_rx_chn(chn->rx_chn);
>  }
> +EXPORT_SYMBOL_GPL(prueth_reset_rx_chan);
>=20
> -void emac_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue)
> +void icssg_ndo_tx_timeout(struct net_device *ndev, unsigned int
> +txqueue)
>  {
>  	ndev->stats.tx_errors++;
>  }
> +EXPORT_SYMBOL_GPL(icssg_ndo_tx_timeout);
>=20
>  static int emac_set_ts_config(struct net_device *ndev, struct ifreq *ifr=
)  { @@
> -1024,7 +1042,7 @@ static int emac_get_ts_config(struct net_device *ndev,
> struct ifreq *ifr)
>  			    -EFAULT : 0;
>  }
>=20
> -int emac_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
> +int icssg_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int
> +cmd)
>  {
>  	switch (cmd) {
>  	case SIOCGHWTSTAMP:
> @@ -1037,9 +1055,10 @@ int emac_ndo_ioctl(struct net_device *ndev, struct
> ifreq *ifr, int cmd)
>=20
>  	return phy_do_ioctl(ndev, ifr, cmd);
>  }
> +EXPORT_SYMBOL_GPL(icssg_ndo_ioctl);
>=20
> -void emac_ndo_get_stats64(struct net_device *ndev,
> -			  struct rtnl_link_stats64 *stats)
> +void icssg_ndo_get_stats64(struct net_device *ndev,
> +			   struct rtnl_link_stats64 *stats)
>  {
>  	struct prueth_emac *emac =3D netdev_priv(ndev);
>=20
> @@ -1058,9 +1077,10 @@ void emac_ndo_get_stats64(struct net_device
> *ndev,
>  	stats->tx_errors  =3D ndev->stats.tx_errors;
>  	stats->tx_dropped =3D ndev->stats.tx_dropped;  }
> +EXPORT_SYMBOL_GPL(icssg_ndo_get_stats64);
>=20
> -int emac_ndo_get_phys_port_name(struct net_device *ndev, char *name,
> -				size_t len)
> +int icssg_ndo_get_phys_port_name(struct net_device *ndev, char *name,
> +				 size_t len)
>  {
>  	struct prueth_emac *emac =3D netdev_priv(ndev);
>  	int ret;
> @@ -1071,6 +1091,7 @@ int emac_ndo_get_phys_port_name(struct
> net_device *ndev, char *name,
>=20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(icssg_ndo_get_phys_port_name);
>=20
>  /* get emac_port corresponding to eth_node name */  int
> prueth_node_port(struct device_node *eth_node) @@ -1089,6 +1110,7 @@
> int prueth_node_port(struct device_node *eth_node)
>  	else
>  		return PRUETH_PORT_INVALID;
>  }
> +EXPORT_SYMBOL_GPL(prueth_node_port);
>=20
>  /* get MAC instance corresponding to eth_node name */  int
> prueth_node_mac(struct device_node *eth_node) @@ -1107,6 +1129,7 @@
> int prueth_node_mac(struct device_node *eth_node)
>  	else
>  		return PRUETH_MAC_INVALID;
>  }
> +EXPORT_SYMBOL_GPL(prueth_node_mac);
>=20
>  void prueth_netdev_exit(struct prueth *prueth,
>  			struct device_node *eth_node)
> @@ -1132,6 +1155,7 @@ void prueth_netdev_exit(struct prueth *prueth,
>  	free_netdev(emac->ndev);
>  	prueth->emac[mac] =3D NULL;
>  }
> +EXPORT_SYMBOL_GPL(prueth_netdev_exit);
>=20
>  int prueth_get_cores(struct prueth *prueth, int slice, bool is_sr1)  { @=
@ -
> 1182,6 +1206,7 @@ int prueth_get_cores(struct prueth *prueth, int slice, =
bool
> is_sr1)
>=20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(prueth_get_cores);
>=20
>  void prueth_put_cores(struct prueth *prueth, int slice)  { @@ -1194,6
> +1219,7 @@ void prueth_put_cores(struct prueth *prueth, int slice)
>  	if (prueth->pru[slice])
>  		pru_rproc_put(prueth->pru[slice]);
>  }
> +EXPORT_SYMBOL_GPL(prueth_put_cores);
>=20
>  #ifdef CONFIG_PM_SLEEP
>  static int prueth_suspend(struct device *dev) @@ -1250,3 +1276,9 @@ stat=
ic
> int prueth_resume(struct device *dev)  const struct dev_pm_ops
> prueth_dev_pm_ops =3D {
>  	SET_SYSTEM_SLEEP_PM_OPS(prueth_suspend, prueth_resume)  };
> +EXPORT_SYMBOL_GPL(prueth_dev_pm_ops);
> +
> +MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
> MODULE_AUTHOR("Md
> +Danish Anwar <danishanwar@ti.com>"); MODULE_DESCRIPTION("PRUSS
> ICSSG
> +Ethernet Driver Common Module"); MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c
> b/drivers/net/ethernet/ti/icssg/icssg_config.c
> index 9444e56b7672..dae52a83a378 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -248,6 +248,7 @@ void icssg_config_ipg(struct prueth_emac *emac)
>=20
>  	icssg_mii_update_ipg(prueth->mii_rt, slice, ipg);  }
> +EXPORT_SYMBOL_GPL(icssg_config_ipg);
>=20
>  static void emac_r30_cmd_init(struct prueth_emac *emac)  { @@ -508,6
> +509,7 @@ int icssg_config(struct prueth *prueth, struct prueth_emac
> *emac, int slice)
>=20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(icssg_config);
>=20
>  /* Bitmask for ICSSG r30 commands */
>  static const struct icssg_r30_cmd emac_r32_bitmask[] =3D { @@ -532,8 +53=
4,8
> @@ static const struct icssg_r30_cmd emac_r32_bitmask[] =3D {
>  	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}}	/* VLAN
> UNWARE*/
>  };
>=20
> -int emac_set_port_state(struct prueth_emac *emac,
> -			enum icssg_port_state_cmd cmd)
> +int icssg_set_port_state(struct prueth_emac *emac,
> +			 enum icssg_port_state_cmd cmd)
>  {
>  	struct icssg_r30_cmd __iomem *p;
>  	int ret =3D -ETIMEDOUT;
> @@ -564,6 +566,7 @@ int emac_set_port_state(struct prueth_emac *emac,
>=20
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(icssg_set_port_state);
>=20
>  void icssg_config_half_duplex(struct prueth_emac *emac)  { @@ -575,6
> +578,7 @@ void icssg_config_half_duplex(struct prueth_emac *emac)
>  	val =3D get_random_u32();
>  	writel(val, emac->dram.va + HD_RAND_SEED_OFFSET);  }
> +EXPORT_SYMBOL_GPL(icssg_config_half_duplex);
>=20
>  void icssg_config_set_speed(struct prueth_emac *emac)  { @@ -601,6 +605,7
> @@ void icssg_config_set_speed(struct prueth_emac *emac)
>=20
>  	writeb(fw_speed, emac->dram.va + PORT_LINK_SPEED_OFFSET);  }
> +EXPORT_SYMBOL_GPL(icssg_config_set_speed);
>=20
>  int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
>  		       struct mgmt_cmd_rsp *rsp)
> @@ -635,6 +640,7 @@ int icssg_send_fdb_msg(struct prueth_emac *emac,
> struct mgmt_cmd *cmd,
>=20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(icssg_send_fdb_msg);
>=20
>  static void icssg_fdb_setup(struct prueth_emac *emac, struct mgmt_cmd
> *fdb_cmd,
>  			    const unsigned char *addr, u8 fid, int cmd) @@ -
> 687,6 +693,7 @@ int icssg_fdb_add_del(struct prueth_emac *emac, const
> unsigned char *addr,
>=20
>  	return -EINVAL;
>  }
> +EXPORT_SYMBOL_GPL(icssg_fdb_add_del);
>=20
>  int icssg_fdb_lookup(struct prueth_emac *emac, const unsigned char *addr,
>  		     u8 vid)
> @@ -716,6 +723,7 @@ int icssg_fdb_lookup(struct prueth_emac *emac,
> const unsigned char *addr,
>=20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(icssg_fdb_lookup);
>=20
>  void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
>  		       u8 untag_mask, bool add)
> @@ -741,6 +749,7 @@ void icssg_vtbl_modify(struct prueth_emac *emac, u8
> vid, u8 port_mask,
>=20
>  	tbl[vid].fid_c1 =3D fid_c1;
>  }
> +EXPORT_SYMBOL_GPL(icssg_vtbl_modify);
>=20
>  u16 icssg_get_pvid(struct prueth_emac *emac)  { @@ -756,6 +765,7 @@ u16
> icssg_get_pvid(struct prueth_emac *emac)
>=20
>  	return pvid;
>  }
> +EXPORT_SYMBOL_GPL(icssg_get_pvid);
>=20
>  void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port)  { @@ -771,3
> +781,4 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port)
>  	else
>  		writel(pvid, prueth->shram.va +
> EMAC_ICSSG_SWITCH_PORT0_DEFAULT_VLAN_OFFSET);
>  }
> +EXPORT_SYMBOL_GPL(icssg_set_pvid);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index c8d0f45cc5b1..131eb4cae1c3 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> @@ -312,3 +312,4 @@ const struct ethtool_ops icssg_ethtool_ops =3D {
>  	.nway_reset =3D emac_nway_reset,
>  	.get_rmon_stats =3D emac_get_rmon_stats,  };
> +EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
> b/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
> index 92718ae40d7e..b64955438bb2 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
> @@ -40,6 +40,7 @@ void icssg_mii_update_mtu(struct regmap *mii_rt, int
> mii, int mtu)
>  				   (mtu - 1) <<
> PRUSS_MII_RT_RX_FRMS_MAX_FRM_SHIFT);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(icssg_mii_update_mtu);
>=20
>  void icssg_update_rgmii_cfg(struct regmap *miig_rt, struct prueth_emac
> *emac)  { @@ -66,6 +67,7 @@ void icssg_update_rgmii_cfg(struct regmap
> *miig_rt, struct prueth_emac *emac)
>  	regmap_update_bits(miig_rt, RGMII_CFG_OFFSET, full_duplex_mask,
>  			   full_duplex_val);
>  }
> +EXPORT_SYMBOL_GPL(icssg_update_rgmii_cfg);
>=20
>  void icssg_miig_set_interface_mode(struct regmap *miig_rt, int mii,
> phy_interface_t phy_if)  { @@ -105,6 +107,7 @@ u32
> icssg_rgmii_get_speed(struct regmap *miig_rt, int mii)
>=20
>  	return icssg_rgmii_cfg_get_bitfield(miig_rt, mask, shift);  }
> +EXPORT_SYMBOL_GPL(icssg_rgmii_get_speed);
>=20
>  u32 icssg_rgmii_get_fullduplex(struct regmap *miig_rt, int mii)  { @@ -1=
18,3
> +121,4 @@ u32 icssg_rgmii_get_fullduplex(struct regmap *miig_rt, int mii)
>=20
>  	return icssg_rgmii_cfg_get_bitfield(miig_rt, mask, shift);  }
> +EXPORT_SYMBOL_GPL(icssg_rgmii_get_fullduplex);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index e13835100754..3e51b3a9b0a5 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -249,10 +249,10 @@ static void emac_adjust_link(struct net_device
> *ndev)
>  			icssg_config_ipg(emac);
>  			spin_unlock_irqrestore(&emac->lock, flags);
>  			icssg_config_set_speed(emac);
> -			emac_set_port_state(emac,
> ICSSG_EMAC_PORT_FORWARD);
> +			icssg_set_port_state(emac,
> ICSSG_EMAC_PORT_FORWARD);
>=20
>  		} else {
> -			emac_set_port_state(emac,
> ICSSG_EMAC_PORT_DISABLE);
> +			icssg_set_port_state(emac,
> ICSSG_EMAC_PORT_DISABLE);
>  		}
>  	}
>=20
> @@ -694,17 +694,17 @@ static void emac_ndo_set_rx_mode_work(struct
> work_struct *work)
>=20
>  	promisc =3D ndev->flags & IFF_PROMISC;
>  	allmulti =3D ndev->flags & IFF_ALLMULTI;
> -	emac_set_port_state(emac,
> ICSSG_EMAC_PORT_UC_FLOODING_DISABLE);
> -	emac_set_port_state(emac,
> ICSSG_EMAC_PORT_MC_FLOODING_DISABLE);
> +	icssg_set_port_state(emac,
> ICSSG_EMAC_PORT_UC_FLOODING_DISABLE);
> +	icssg_set_port_state(emac,
> ICSSG_EMAC_PORT_MC_FLOODING_DISABLE);
>=20
>  	if (promisc) {
> -		emac_set_port_state(emac,
> ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
> -		emac_set_port_state(emac,
> ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
> +		icssg_set_port_state(emac,
> ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
> +		icssg_set_port_state(emac,
> ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
>  		return;
>  	}
>=20
>  	if (allmulti) {
> -		emac_set_port_state(emac,
> ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
> +		icssg_set_port_state(emac,
> ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
>  		return;
>  	}
>=20
> @@ -728,14 +728,14 @@ static void emac_ndo_set_rx_mode(struct
> net_device *ndev)  static const struct net_device_ops emac_netdev_ops =3D=
 {
>  	.ndo_open =3D emac_ndo_open,
>  	.ndo_stop =3D emac_ndo_stop,
> -	.ndo_start_xmit =3D emac_ndo_start_xmit,
> +	.ndo_start_xmit =3D icssg_ndo_start_xmit,
>  	.ndo_set_mac_address =3D eth_mac_addr,
>  	.ndo_validate_addr =3D eth_validate_addr,
> -	.ndo_tx_timeout =3D emac_ndo_tx_timeout,
> +	.ndo_tx_timeout =3D icssg_ndo_tx_timeout,
>  	.ndo_set_rx_mode =3D emac_ndo_set_rx_mode,
> -	.ndo_eth_ioctl =3D emac_ndo_ioctl,
> -	.ndo_get_stats64 =3D emac_ndo_get_stats64,
> -	.ndo_get_phys_port_name =3D emac_ndo_get_phys_port_name,
> +	.ndo_eth_ioctl =3D icssg_ndo_ioctl,
> +	.ndo_get_stats64 =3D icssg_ndo_get_stats64,
> +	.ndo_get_phys_port_name =3D icssg_ndo_get_phys_port_name,
>  };
>=20
>  static int prueth_netdev_init(struct prueth *prueth, @@ -771,7 +771,7 @@
> static int prueth_netdev_init(struct prueth *prueth,
>  	}
>  	INIT_WORK(&emac->rx_mode_work,
> emac_ndo_set_rx_mode_work);
>=20
> -	INIT_DELAYED_WORK(&emac->stats_work,
> emac_stats_work_handler);
> +	INIT_DELAYED_WORK(&emac->stats_work,
> icssg_stats_work_handler);
>=20
>  	ret =3D pruss_request_mem_region(prueth->pruss,
>  				       port =3D=3D PRUETH_PORT_MII0 ?
> @@ -864,7 +864,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>  	ndev->hw_features =3D NETIF_F_SG;
>  	ndev->features =3D ndev->hw_features;
>=20
> -	netif_napi_add(ndev, &emac->napi_rx, emac_napi_rx_poll);
> +	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
>  	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
>  		     HRTIMER_MODE_REL_PINNED);
>  	emac->rx_hrtimer.function =3D &emac_rx_timer_callback; @@ -927,8
> +927,8 @@ static void prueth_emac_restart(struct prueth *prueth)
>  		netif_device_detach(emac1->ndev);
>=20
>  	/* Disable both PRUeth ports */
> -	emac_set_port_state(emac0, ICSSG_EMAC_PORT_DISABLE);
> -	emac_set_port_state(emac1, ICSSG_EMAC_PORT_DISABLE);
> +	icssg_set_port_state(emac0, ICSSG_EMAC_PORT_DISABLE);
> +	icssg_set_port_state(emac1, ICSSG_EMAC_PORT_DISABLE);
>=20
>  	/* Stop both pru cores for both PRUeth ports*/
>  	prueth_emac_stop(emac0);
> @@ -943,8 +943,8 @@ static void prueth_emac_restart(struct prueth
> *prueth)
>  	prueth->emacs_initialized++;
>=20
>  	/* Enable forwarding for both PRUeth ports */
> -	emac_set_port_state(emac0, ICSSG_EMAC_PORT_FORWARD);
> -	emac_set_port_state(emac1, ICSSG_EMAC_PORT_FORWARD);
> +	icssg_set_port_state(emac0, ICSSG_EMAC_PORT_FORWARD);
> +	icssg_set_port_state(emac1, ICSSG_EMAC_PORT_FORWARD);
>=20
>  	/* Attache net_device for both PRUeth ports */
>  	netif_device_attach(emac0->ndev);
> @@ -972,7 +972,7 @@ static void icssg_enable_switch_mode(struct prueth
> *prueth)
>  					  BIT(emac->port_id) |
> DEFAULT_UNTAG_MASK,
>  					  true);
>  			icssg_set_pvid(prueth, emac->port_vlan, emac-
> >port_id);
> -			emac_set_port_state(emac,
> ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
> +			icssg_set_port_state(emac,
> ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
>  		}
>  	}
>  }
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 5eeeccb73665..f678d656a3ed 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -329,8 +329,8 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt,
> int slice, u8 *mac_addr);  void icssg_config_ipg(struct prueth_emac *emac=
);
> int icssg_config(struct prueth *prueth, struct prueth_emac *emac,
>  		 int slice);
> -int emac_set_port_state(struct prueth_emac *emac,
> -			enum icssg_port_state_cmd state);
> +int icssg_set_port_state(struct prueth_emac *emac,
> +			 enum icssg_port_state_cmd state);
>  void icssg_config_set_speed(struct prueth_emac *emac);  void
> icssg_config_half_duplex(struct prueth_emac *emac);
>=20
> @@ -352,7 +352,7 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8
> port);  #define prueth_napi_to_tx_chn(pnapi) \
>  	container_of(pnapi, struct prueth_tx_chn, napi_tx)
>=20
> -void emac_stats_work_handler(struct work_struct *work);
> +void icssg_stats_work_handler(struct work_struct *work);
>  void emac_update_hardware_stats(struct prueth_emac *emac);  int
> emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
>=20
> @@ -377,11 +377,11 @@ int prueth_dma_rx_push(struct prueth_emac
> *emac,
>  		       struct prueth_rx_chn *rx_chn);  void
> emac_rx_timestamp(struct prueth_emac *emac,
>  		       struct sk_buff *skb, u32 *psdata); -enum netdev_tx
> emac_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev);
> +enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct
> +net_device *ndev);
>  irqreturn_t prueth_rx_irq(int irq, void *dev_id);  void
> prueth_emac_stop(struct prueth_emac *emac);  void
> prueth_cleanup_tx_ts(struct prueth_emac *emac); -int
> emac_napi_rx_poll(struct napi_struct *napi_rx, int budget);
> +int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget);
>  int prueth_prepare_rx_chan(struct prueth_emac *emac,
>  			   struct prueth_rx_chn *chn,
>  			   int buf_size);
> @@ -389,12 +389,12 @@ void prueth_reset_tx_chan(struct prueth_emac
> *emac, int ch_num,
>  			  bool free_skb);
>  void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
>  			  int num_flows, bool disable);
> -void emac_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue);=
 -
> int emac_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd); =
-void
> emac_ndo_get_stats64(struct net_device *ndev,
> -			  struct rtnl_link_stats64 *stats);
> -int emac_ndo_get_phys_port_name(struct net_device *ndev, char *name,
> -				size_t len);
> +void icssg_ndo_tx_timeout(struct net_device *ndev, unsigned int
> +txqueue); int icssg_ndo_ioctl(struct net_device *ndev, struct ifreq
> +*ifr, int cmd); void icssg_ndo_get_stats64(struct net_device *ndev,
> +			   struct rtnl_link_stats64 *stats); int
> +icssg_ndo_get_phys_port_name(struct net_device *ndev, char *name,
> +				 size_t len);
>  int prueth_node_port(struct device_node *eth_node);  int
> prueth_node_mac(struct device_node *eth_node);  void
> prueth_netdev_exit(struct prueth *prueth, diff --git
> a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> index fa98bdb11ece..e180c1166170 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -722,14 +722,14 @@ static void emac_ndo_set_rx_mode_sr1(struct
> net_device *ndev)  static const struct net_device_ops emac_netdev_ops =3D=
 {
>  	.ndo_open =3D emac_ndo_open,
>  	.ndo_stop =3D emac_ndo_stop,
> -	.ndo_start_xmit =3D emac_ndo_start_xmit,
> +	.ndo_start_xmit =3D icssg_ndo_start_xmit,
>  	.ndo_set_mac_address =3D eth_mac_addr,
>  	.ndo_validate_addr =3D eth_validate_addr,
> -	.ndo_tx_timeout =3D emac_ndo_tx_timeout,
> +	.ndo_tx_timeout =3D icssg_ndo_tx_timeout,
>  	.ndo_set_rx_mode =3D emac_ndo_set_rx_mode_sr1,
> -	.ndo_eth_ioctl =3D emac_ndo_ioctl,
> -	.ndo_get_stats64 =3D emac_ndo_get_stats64,
> -	.ndo_get_phys_port_name =3D emac_ndo_get_phys_port_name,
> +	.ndo_eth_ioctl =3D icssg_ndo_ioctl,
> +	.ndo_get_stats64 =3D icssg_ndo_get_stats64,
> +	.ndo_get_phys_port_name =3D icssg_ndo_get_phys_port_name,
>  };
>=20
>  static int prueth_netdev_init(struct prueth *prueth, @@ -767,7 +767,7 @@
> static int prueth_netdev_init(struct prueth *prueth,
>  		goto free_ndev;
>  	}
>=20
> -	INIT_DELAYED_WORK(&emac->stats_work,
> emac_stats_work_handler);
> +	INIT_DELAYED_WORK(&emac->stats_work,
> icssg_stats_work_handler);
>=20
>  	ret =3D pruss_request_mem_region(prueth->pruss,
>  				       port =3D=3D PRUETH_PORT_MII0 ?
> @@ -854,7 +854,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>  	ndev->hw_features =3D NETIF_F_SG;
>  	ndev->features =3D ndev->hw_features;
>=20
> -	netif_napi_add(ndev, &emac->napi_rx, emac_napi_rx_poll);
> +	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
>  	prueth->emac[mac] =3D emac;
>=20
>  	return 0;
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_queues.c
> b/drivers/net/ethernet/ti/icssg/icssg_queues.c
> index 3c34f61ad40b..e5052d9e7807 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_queues.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_queues.c
> @@ -28,6 +28,7 @@ int icssg_queue_pop(struct prueth *prueth, u8 queue)
>=20
>  	return val;
>  }
> +EXPORT_SYMBOL_GPL(icssg_queue_pop);
>=20
>  void icssg_queue_push(struct prueth *prueth, int queue, u16 addr)  { @@ -
> 36,6 +37,7 @@ void icssg_queue_push(struct prueth *prueth, int queue, u16
> addr)
>=20
>  	regmap_write(prueth->miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue,
> addr);  }
> +EXPORT_SYMBOL_GPL(icssg_queue_push);
>=20
>  u32 icssg_queue_level(struct prueth *prueth, int queue)  { diff --git
> a/drivers/net/ethernet/ti/icssg/icssg_stats.c
> b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> index 3dbadddd7e35..2fb150c13078 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> @@ -42,7 +42,7 @@ void emac_update_hardware_stats(struct prueth_emac
> *emac)
>  	}
>  }
>=20
> -void emac_stats_work_handler(struct work_struct *work)
> +void icssg_stats_work_handler(struct work_struct *work)
>  {
>  	struct prueth_emac *emac =3D container_of(work, struct prueth_emac,
>  						stats_work.work);
> @@ -51,6 +51,7 @@ void emac_stats_work_handler(struct work_struct
> *work)
>  	queue_delayed_work(system_long_wq, &emac->stats_work,
>  			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS *
> 1000) / emac->speed));  }
> +EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
>=20
>  int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)  {
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
> b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
> index fceb8bb7d34e..67e2927e176d 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
> @@ -44,7 +44,7 @@ static int prueth_switchdev_stp_state_set(struct
> prueth_emac *emac,
>  		return -EOPNOTSUPP;
>  	}
>=20
> -	emac_set_port_state(emac, emac_state);
> +	icssg_set_port_state(emac, emac_state);
>  	netdev_dbg(emac->ndev, "STP state: %u\n", emac_state);
>=20
>  	return ret;
> @@ -64,7 +64,7 @@ static int prueth_switchdev_attr_br_flags_set(struct
> prueth_emac *emac,
>  	netdev_dbg(emac->ndev, "BR_MCAST_FLOOD: %d port %u\n",
>  		   emac_state, emac->port_id);
>=20
> -	emac_set_port_state(emac, emac_state);
> +	icssg_set_port_state(emac, emac_state);
>=20
>  	return 0;
>  }
>=20
> base-commit: 2146b7dd354c2a1384381ca3cd5751bfff6137d6
> --
> 2.34.1
>=20
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>


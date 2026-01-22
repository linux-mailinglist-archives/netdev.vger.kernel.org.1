Return-Path: <netdev+bounces-252217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH9xLca3cWmcLgAAu9opvQ
	(envelope-from <netdev+bounces-252217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:38:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7C62064
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73D504E0662
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D73344020;
	Thu, 22 Jan 2026 05:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="S7dkMZsx"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022134.outbound.protection.outlook.com [52.101.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6847278B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769060288; cv=fail; b=piHM8aAuTXEYuy7n2wIEnnyXhrd7mwbU/EU6qBhfA3pUri/q3xN13frUhbxsS0XqqGqQcDDbDQNYtzdjKjQKml8qsxRnymcvfhWbsuxyJ6qQyiBsBfaTohzjX7O93fxAY2aQaoy/6kC1N6mNd9yowg11u66fUH1pvurB2g/pXx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769060288; c=relaxed/simple;
	bh=TIardqhhjaRI9zgWer/SnuZL8KnLix59ow6BA+etqrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EHvMMY4s7MVKyvBQD9oXt5UOcvQWjfN4tYJ0HAmS9VpRf3s0H6ssn0UBHsfEZietxLAVsUCoROoGLEBv8e+Qav1X6s2UZp5BeJc1rVRUBCAD+pMXLFn+VP4WeOmTwMO49kcHhvl0a+oUGrMdwNwkLeSs26xMJp3rJxjDkHFflJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=S7dkMZsx; arc=fail smtp.client-ip=52.101.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBtG/TIQXNSwIFo6ePb5hwVM3iqytAiDfIYI++9jO48K/r0lIxwnoqGGmOIWx4CjWEzK9KB8j8z2jQexEw1pz+TnYCnpV8cEPR0kJUmsB7qGsPzhM0HZmg1dTi/M07ZYwsjZKk3vfioG1s29cITxDbEbOScGnPkAqw5I+4j9dBc8Cmvsa9EUKgjL6yaHoQjzXEAQliM67BjtDTU2fDH75m1VRvCpDpMv2jdqGIQyMfkuUovrAtCddI9L3YM+RHuAGxdO+kqkFIQpCBeUUh8We+MvCxjcfB9ahlz8LdaXeUD5jAr9VLjI3giCSR3InRuneA4Utx+TwRk9vOawL13rog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIardqhhjaRI9zgWer/SnuZL8KnLix59ow6BA+etqrI=;
 b=CYO94rqPByQWH94MaigivSY08nAmiAXuk0IEtZdQp7zhQr9bS24TnYWLCtoq7vLJ2Y7sW6dPAmlkgm5u4NUIJBWX66rN8fUi6x7Ai/3bRSA9Hwf6gCocgDRLOrSJPSpPenmRSKn3362/qDdJz/6HwGUcBrFiWPNnul0v22GuYNHcIviw1WNEtwT/ay83RQlW4XHYofTdVdjmNQLvE0urMvw7LDL/8qCVcRW7Q18eLEf0Yem2MMHXJTlwmt8fADFmQsFGh3YDN4Y+LzSAubvS3R2rFUmEQYlDgQ6GZAsx2IjGMDTkQSDeN2JUt7GtBkxIQGiQF9QLERMcaCp80oX7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIardqhhjaRI9zgWer/SnuZL8KnLix59ow6BA+etqrI=;
 b=S7dkMZsxLb+SYLPrkcn8hLJ+ase2VFU4w+7wjajtKlNzyUWhS5TJxBKwe7H0Kz/ginRkZpuW9El4ofpc+BNyTt/GFyNmXl9meZubzVpCq5hAgbmqYfQPVvNVsKFHJux5YSWWoI58ImF3uAZQWIOtG/gHbPqWTZGU99xjVckZhYptagfoKrYYnGzM87P8GOZoQFiwijGUvJfaYe8WbXOLE9/JDqTf2QtGuixM6AJZJMP9dYmsKJprVD01FXY05vKwyUQTQPJjw19nBFsKKWzmks6gZYVpY0Jm3cDqoRFLkr8Xl10eUiKe2a11Bmku3+O3vkpfDWe/q3DZGPovpI9BQQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB8311.apcprd06.prod.outlook.com (2603:1096:101:301::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 05:38:01 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 05:38:00 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [net-next,v2,06/15] net: ftgmac100: Use devm_clk_get_enabled
Thread-Topic: [net-next,v2,06/15] net: ftgmac100: Use devm_clk_get_enabled
Thread-Index: AQHcigcafEHEdCH3i0mZY0oaJJCbl7VdrcqA
Date: Thu, 22 Jan 2026 05:37:59 +0000
Message-ID:
 <SEYPR06MB51340AC0AF94D5DD315658AA9D97A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260116-ftgmac-cleanup-v2-6-81f41f01f2a8@aspeedtech.com>
 <20260120121939.795771-1-horms@kernel.org>
In-Reply-To: <20260120121939.795771-1-horms@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB8311:EE_
x-ms-office365-filtering-correlation-id: aa8a1c20-e1aa-4d8d-3ce3-08de597867a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?big5?B?b3JQWjRIcVR5Q2ZmMEpqZFVWek93T09XSDJPWkZvMVp4VkFYL29CNlVHVTZhcmxY?=
 =?big5?B?QUVxNy9EZ2ZNaFp4TGVMclRMV05HMWRaNXZsUkhvSUQzV2g0bkNPdDk2Vlp0cW9Y?=
 =?big5?B?THpTWkNUZytIbVdlMmlmUWk5NFNLRExIZkduSWpMRm5CM1VwKytVVWtYUXpRTXpp?=
 =?big5?B?NjJQUzN0THJGL0NkcnE4VjJuQXVOK3BBZ0dSbVJFS0x6RWFjcGlEenJES1BKM0lU?=
 =?big5?B?VDhienlCVHoyR3dLTmhnOTJaZmdodXhiRFY0ZTRQOWM3R2xodWJYMGxyUVZnbkwy?=
 =?big5?B?R2hBR3NNd201Q3prZHcvK2ppZXJyU0txallzVDFNNGd6KzN2Nk1LYU1FRjJKdXd0?=
 =?big5?B?L2Z4Yk1vekpBNTVRRnBmd3ZralNLS21pdnpPN1VTTks1TkVLdjltc1RCdHZobGdM?=
 =?big5?B?aFdnYW9QZHJIOU5JT1BRQnM0TEJjZ0IwV1JpejE0R2E3S1hWTW9WbVhuQlFabG5r?=
 =?big5?B?bVhTcHMvY3FjQTA5WTE4Z251SXduRklRR1pNYnlsbVJrV0dVVXlrZG1MUDZLS2pL?=
 =?big5?B?R3B5NXo4d1BrNzlHRzB3TjdmU1NxQUROSFZEbE5nVGNSNnUxRjVoNnRHOU4xN1hY?=
 =?big5?B?Yit1czMxUWx3eE9BM1lVMDBBMXF1VW1NTDVhQ3ZwRm5ueXhVK0NpUkUzN0V5cWx3?=
 =?big5?B?YThteEt3RTlMZlNjdW40N0I1OWNVRnhWMkdBbTZVQ1EyMWVrVjlZblhzNk9Za2hH?=
 =?big5?B?ejdFVmY4dGJZWFd2cUc5QzJUaFVIWjZOUm8rMmx5SXlMaDZVdkFueVp5K0ZuT0NU?=
 =?big5?B?dURsdk5XLzNudXdraVR0TlJqbmlzWU5zOVNiNHJTVUx5cEgwS2E4MTBzK0JXTDRQ?=
 =?big5?B?MjVWWFlkZXFxWVl2UlBOeDE2SVZJeXJLOVdKenhWZDgvN0Q0N3FsV1dNMGQ4MVY2?=
 =?big5?B?Rm1UbHR0blduR1NvZlZ1Wk12VmQxSXhySFN4M09MTnV4dmE5cktEcitmZGdmTUps?=
 =?big5?B?KzZCSS9CcFJ2OEdYVGkyVkQ5czlFNFJ5cnhCRWNaZ3hucU5aeDlzMHloeHVpVnNF?=
 =?big5?B?d1NTaE5ialprZ2xEcFcwbVNDbDZKaC8xSlhVTUtudUxZOWFyN1EvL0RnWW1qemFP?=
 =?big5?B?dTd1cWxQbzBnTHFKYVJiRkhQVmpwcVFjMk5mZkNVUllkWW93WFRtdHNEZnF2OGtY?=
 =?big5?B?ZkZ6MjJsdWRTYWpXcnNjVVJiUjdXRFhTa3pXazdNZ24wRjRJT1VySHFHemtBcTV2?=
 =?big5?B?U2dqcWlnQXNHWGl4V3FCaklRZTd1ZzEvMklnMGNnODE1bDNIL3hWaFY3WFVCQ0NM?=
 =?big5?B?czhvaTlnVjloaVF4NWNkVHRRR0JTQ0p6bFhlaWtkQi8zd3FxZGo4NDBqMVBVaUZU?=
 =?big5?B?VGRYdTRjSHFya1ZNZlp0akZVbjB2TU5BQ2R4Y1JIOElia21pWmFScFJFb090NUl0?=
 =?big5?B?OWRyOTZUYVc4cFJEemxtVC9wNmtmRG1KSWk4YjRjSmRvSlZNU3prT2xqZmVBRWlV?=
 =?big5?B?eGJqbHRVbTRYSmVNUHNlRkYzNE85aWdwSjBvM1k0MG1GNHJkQXI3Sis4dCtuR3gz?=
 =?big5?B?YmNqcS9NeGU2QUd0anllTVhkc0xmcDMwYkNmMStBRkcvU283c0FvWDdaeFRCMnYx?=
 =?big5?B?UVR5b2tWVG92NUkveTlmVyttM3F5ZHZHREFpK3NXelo3bFlieTdDdVpHWFJnOFZh?=
 =?big5?B?TXYzRHZJWFp4aTJ4eUkyL1JjYi8rL2FGUEVWMGIzcnZXczY5N0Q3NndvVU41Y0xw?=
 =?big5?B?Nko4d29HNjVLeTl3Z3ROTm1IOTFSYUVKczdYbTRrTW1YUlQzWlVKSlFwZFViNFZM?=
 =?big5?B?d2FVay9DMlhNREdHMUxZaC8vQitST3p6ODNJUzRXTmNsZkNQTlFOQ3FhbWRuRnk0?=
 =?big5?B?aVFTRW90bHpnLzA3NDU5OVM4dXFJSTdjOEdnM2NQZFprUDR4ZEJLVjd4L1h4b0Mr?=
 =?big5?B?Nk9ZcUxDRGxxN21qRVlXTThhMEpPWDJJSXRIZ3EyQnAvbWUrM2pwVFN5bkFOWVUw?=
 =?big5?B?aEVUeUkzaFVOZzFDS3V5cUlGbEVDckxWd0R0RVZ3UkxueEFjVVp1VmtFWEZReEZq?=
 =?big5?B?VUozeStmN21SVkIzdjJXTytRN083NzdYdmUwK1BWWnZkeTBaUWFyekVUVjZHYWo0?=
 =?big5?Q?AmUtgKx9jPg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?T3BoUCt6ejJDQ0FILzVWMWdrOU5rUisyb2wra1B0MjdHRUcvQTJKaWNQdTZvMVpy?=
 =?big5?B?aHBrYzZNMnl2NEpMLzFBeGhROENKS2hqUTNXdUhtcFl6NHc0akF4eE5JeFAzWTdv?=
 =?big5?B?WjhpMk4vZkhVaDgwSGE4OW9yeG9PMjJBRU9lbEZOZjAvaDhmcmJHL21CRE1jNUF2?=
 =?big5?B?Z1Qvd1kzZWFRK21CdWVzb0lXcHdlOEFtMUF5YUIya0k4SnVCL1FlN1JvdVZDRGUx?=
 =?big5?B?bDFwSFVnZ2FZTkRQTjdBWnFNaW9BdUhoUHA1RngyU3pMVnFjamNCS2twUkFXTzFI?=
 =?big5?B?L3dHaUtPQVhhY1RxT1l2TkwvVHRSOG9LRHRoRGp0c0RZaVhkN2hJZzlIUkdtVlNu?=
 =?big5?B?emlxUGpwMGZVdkdRRGtLNkVPRTdKeUg0UUVBR3VDMitvRXpJQ3ZuaFZTM0ZzMGZ3?=
 =?big5?B?RXVXTFE0cVlNUzVmYUxUNmxMMmxhTmN6MGRZa3FwMUducWxyUjVaTGduaW5BV2RP?=
 =?big5?B?Wm5DV1laWStTWHZnL0JzMGo0cklrcFFPbU5jZVorbUlSSkpWWXY1amdQVmlwN243?=
 =?big5?B?OU1QWHd1ZXVDRzB3NlIvODdvbGZLKzN2c1RFcXVFTGVxMWc3OUR5bnR6R1JTcmhR?=
 =?big5?B?dVBhYnNnVHFrVDdReWdHSU1oUVIzMzhpVmZQNENxRlR5ZnZCd0h4T016K2lscU91?=
 =?big5?B?citsditEUmpXTkxoL0tTUGQwNTlFKytHa0M2TFZSZXR5MHZ6bFI5bkJIa1duc0d4?=
 =?big5?B?RWUxakdNd3BzeHRtVTQxYVJ2WHM0bGxzdW85NHV1VXVnQ0NGcVZpU25OYkJJWHdk?=
 =?big5?B?S2ZTc0Y3WEhRRHpaNjZzUndFYjRrOGZWSVlob0xyT012TE1pekdKenhqR2YrZ1h4?=
 =?big5?B?cDFwNEttb0J4RzFJSk11L0xCWTRsV1BEZ2F6bzZya3R4akJSSEMxekRTTzBLTDFm?=
 =?big5?B?SjIxR2MvcEMrMTFsVTlxcSt6UW9hSnp1TE9zcHM2RFlCZmxJWnJlTUhhU2JtZGg0?=
 =?big5?B?a05mdzZQcmU2czh0OCtaZmNaUnVCc2xZVldlMlZUcWlrekp1aDVJMWZHMzJWZUZC?=
 =?big5?B?OVI1eDE2dS9ScDQzOHpWOHJ3L3dDR3pjTHpiZHZiL0ZGdWVYUWpFU1ZxbnBLK2dW?=
 =?big5?B?UVBZbEE5TWd6dmhZR2FIaVFmaVRSN0srK3greEFkeHNEN25aUGVxMkpPM1pPY3Ry?=
 =?big5?B?VEJqQVptUEIxS05vVEN0RVBHSDE3SGthSVNqVDhxelNuaGRKZUpDOFdNRFhUMDNZ?=
 =?big5?B?M0Z2S1YrV1FOdXVaVmZ2aFRDQmxCWTZ1eTFTaDZMWFkyTW0wT2ZTcEh6VXpsSGxs?=
 =?big5?B?VGFDRWFDVWJFQWRHYUJYNkFvNmZLTGtsbnhSVzR5YktTVDlrRm1abW0wUzhwdzRz?=
 =?big5?B?bWtoT3NEb2R1bGhhajJXdi9Vb2dRT1B5M0F4MFZ0dWJJaDFPb0JPRTd3QXkyZXZz?=
 =?big5?B?ZzE5UHhSOEJ6WkFCL2pTdWxoYndYZ21FcW1qSzkrVFQrYyt6ODd5VEpQRlNoQlg4?=
 =?big5?B?UFVBb25ETUNWVkRtZUpOeHV2ZVVCUzhIUHcvVmhvWSthZExWdXhPbDFBV3VhclNa?=
 =?big5?B?R3J1TUxuMCtvMGhSZFNpRmFsZExBSGszV25DNWk0dVoyVXc3RFBTek54UC9WU1VL?=
 =?big5?B?REY1K1UyWmZHbDBaUEZOQVhqNDlvMmVWOS82TUEyd2VPRDY1NU1NSGxHMkE4dE4r?=
 =?big5?B?UVplTmJJdnNHa3Q0eTQrOWdoOFRJTi9qUlRYWWJHcmlRZE5HU0lNQmJnZm1ROCt0?=
 =?big5?B?ZE1jcSt4cXNKME1sTTU1RDB4WTNpRkNhN1pndFJVWDZDSTdvdVhPekJZYXptQjhT?=
 =?big5?B?YkxETnhlMmtEYXFxbjFrMHBVdXFXblF0UlJscWFVeDRMdi9xQUdDMjdwVmQ2ZmZ0?=
 =?big5?B?VHZJYWpTV3cxSWREbjhRYzBQSVRjQVBLYUJ4WFRLNlVEMFIwSHBtRkJCSSsvR28v?=
 =?big5?B?WjArUGdpd3UzaVZzR3A1NmJiamdnSXY0dEg3NXNJUENWak9ZNUN6WG1kVDBpV3pi?=
 =?big5?B?ZVptN0ROUWxsOWU0S05rRXVKNnZLZ1RaYzZFcUtnUThmWjdUTjVCYlBDOGhiQVRW?=
 =?big5?B?ckdJYWdGQ2pTck1RUDVXazR5bDhGd1YzeUxDZjUxSENHeUNxVVFwcHA5YVhhS2ww?=
 =?big5?B?QnpCS2lUZEU0ODBxdmxYd2JWRHhnaW9TVzVsalMwT0pRWklBTndya3U1bVRUZHpI?=
 =?big5?B?UjJKRlF5VFFkcDdWbWlaSDFKUitNMEVvWXptMU1EQjlYSUVsZE1tbysyRUpMZnJs?=
 =?big5?B?WjhjZkxwbWpCMVRlWmpTY1lKaEg5dz09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8a1c20-e1aa-4d8d-3ce3-08de597867a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 05:38:00.1058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wMg6mFxPGVn3BCto2IO2SzLx+yrJtehjicRAikxLC0DFl0gpKbaKk6+Wst6IS6hfhVd279Q9MK9zymOcDcb1HiFYWHTc/qezaQu1epX8xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8311
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[aspeedtech.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252217-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[aspeedtech.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[aspeedtech.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: D7A7C62064
X-Rspamd-Action: no action

PiCxSKXzqsw6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gsUil86TptME6IFR1
ZXNkYXksIEphbnVhcnkgMjAsIDIwMjYgODoyMCBQTQ0KPiCmrKXzqsw6IEphY2t5IENob3UgPGph
Y2t5X2Nob3VAYXNwZWVkdGVjaC5jb20+DQo+ILDGpbs6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5p
QHJlZGhhdC5jb207IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IGFuZHJldytuZXRkZXZAbHVubi5j
aDsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiClRKauOiBSZTogW25ldC1uZXh0LHYyLDA2LzE1
XSBuZXQ6IGZ0Z21hYzEwMDogVXNlIGRldm1fY2xrX2dldF9lbmFibGVkDQo+IA0KPiBUaGlzIGlz
IGFuIEFJLWdlbmVyYXRlZCByZXZpZXcgb2YgeW91ciBwYXRjaC4gVGhlIGh1bWFuIHNlbmRpbmcg
dGhpcyBlbWFpbCBoYXMNCj4gY29uc2lkZXJlZCB0aGUgQUkgcmV2aWV3IHZhbGlkLCBvciBhdCBs
ZWFzdCBwbGF1c2libGUuDQo+IA0KPiBGb3IgbG9jYWwgcmVwcm9kdWN0aW9uIHN0ZXBzIHNlZSBo
dHRwczovL25ldGRldi1haS5ib3RzLmxpbnV4LmRldi9haS1sb2NhbC5odG1sDQo+IC0tLQ0KPiBu
ZXQ6IGZ0Z21hYzEwMDogVXNlIGRldm1fY2xrX2dldF9lbmFibGVkDQo+IA0KPiBUaGlzIHBhdGNo
IGNvbnZlcnRzIHRoZSBmdGdtYWMxMDAgZHJpdmVyIHRvIHVzZSBkZXZtX2Nsa19nZXRfZW5hYmxl
ZCgpIGFuZA0KPiBkZXZtX2Nsa19nZXRfb3B0aW9uYWxfZW5hYmxlZCgpIHRvIHNpbXBsaWZ5IGNs
b2NrIG1hbmFnZW1lbnQgYW5kIGNsZWFudXANCj4gcGF0aHMuDQo+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mYXJhZGF5L2Z0Z21hYzEwMC5jDQo+ID4gYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9mYXJhZGF5L2Z0Z21hYzEwMC5jDQo+ID4gaW5kZXggZWMyZTdlYzIzZGRm
Li5mZmQ4NjY1NWJjYzggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFy
YWRheS9mdGdtYWMxMDAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZhcmFkYXkv
ZnRnbWFjMTAwLmMNCj4gPiBAQCAtMTgwMSwxMyArMTgwMSwxMCBAQCBzdGF0aWMgaW50IGZ0Z21h
YzEwMF9zZXR1cF9jbGsoc3RydWN0DQo+IGZ0Z21hYzEwMCAqcHJpdikNCj4gPiAgCXN0cnVjdCBj
bGsgKmNsazsNCj4gPiAgCWludCByYzsNCj4gPg0KPiA+IC0JY2xrID0gZGV2bV9jbGtfZ2V0KHBy
aXYtPmRldiwgTlVMTCAvKiBNQUNDTEsgKi8pOw0KPiA+ICsJY2xrID0gZGV2bV9jbGtfZ2V0X2Vu
YWJsZWQocHJpdi0+ZGV2LCBOVUxMIC8qIE1BQ0NMSyAqLyk7DQo+ID4gIAlpZiAoSVNfRVJSKGNs
aykpDQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIoY2xrKTsNCj4gPiAgCXByaXYtPmNsayA9IGNsazsN
Cj4gPiAtCXJjID0gY2xrX3ByZXBhcmVfZW5hYmxlKHByaXYtPmNsayk7DQo+ID4gLQlpZiAocmMp
DQo+ID4gLQkJcmV0dXJuIHJjOw0KPiA+DQo+ID4gIAkvKiBBc3BlZWQgc3BlY2lmaWVzIGEgMTAw
TUh6IGNsb2NrIGlzIHJlcXVpcmVkIGZvciB1cCB0bw0KPiA+ICAJICogMTAwME1iaXQgbGluayBz
cGVlZHMuIEFzIE5DU0kgaXMgbGltaXRlZCB0byAxMDBNYml0LCAyNU1IeiBAQA0KPiA+IC0xODE2
LDIxICsxODEzLDE1IEBAIHN0YXRpYyBpbnQgZnRnbWFjMTAwX3NldHVwX2NsayhzdHJ1Y3QgZnRn
bWFjMTAwDQo+ICpwcml2KQ0KPiA+ICAJcmMgPSBjbGtfc2V0X3JhdGUocHJpdi0+Y2xrLCBwcml2
LT51c2VfbmNzaSA/IEZUR01BQ18yNU1IWiA6DQo+ID4gIAkJCSAgRlRHTUFDXzEwME1IWik7DQo+
ID4gIAlpZiAocmMpDQo+ID4gLQkJZ290byBjbGVhbnVwX2NsazsNCj4gPiArCQlyZXR1cm4gcmM7
DQo+ID4NCj4gPiAgCS8qIFJDTEsgaXMgZm9yIFJNSUksIHR5cGljYWxseSB1c2VkIGZvciBOQ1NJ
LiBPcHRpb25hbCBiZWNhdXNlIGl0J3Mgbm90DQo+ID4gIAkgKiBuZWNlc3NhcnkgaWYgaXQncyB0
aGUgQVNUMjQwMCBNQUMsIG9yIHRoZSBNQUMgaXMgY29uZmlndXJlZCBmb3INCj4gPiAgCSAqIFJH
TUlJLCBvciB0aGUgY29udHJvbGxlciBpcyBub3QgYW4gQVNQRUVELWJhc2VkIGNvbnRyb2xsZXIu
DQo+ID4gIAkgKi8NCj4gPiAtCXByaXYtPnJjbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwocHJp
di0+ZGV2LCAiUkNMSyIpOw0KPiA+IC0JcmMgPSBjbGtfcHJlcGFyZV9lbmFibGUocHJpdi0+cmNs
ayk7DQo+ID4gLQlpZiAoIXJjKQ0KPiA+IC0JCXJldHVybiAwOw0KPiA+ICsJcHJpdi0+cmNsayA9
IGRldm1fY2xrX2dldF9vcHRpb25hbF9lbmFibGVkKHByaXYtPmRldiwgIlJDTEsiKTsNCj4gPg0K
PiA+IC1jbGVhbnVwX2NsazoNCj4gPiAtCWNsa19kaXNhYmxlX3VucHJlcGFyZShwcml2LT5jbGsp
Ow0KPiA+IC0NCj4gPiAtCXJldHVybiByYzsNCj4gPiArCXJldHVybiAwOw0KPiA+ICB9DQo+IA0K
PiBTaG91bGQgdGhlIHJldHVybiB2YWx1ZSBvZiBkZXZtX2Nsa19nZXRfb3B0aW9uYWxfZW5hYmxl
ZCgpIGJlIGNoZWNrZWQgaGVyZT8NCj4gVGhlIG9sZCBjb2RlIHdvdWxkIGZhaWwgcHJvYmUgaWYg
UkNMSyBleGlzdGVkIGJ1dA0KPiBjbGtfcHJlcGFyZV9lbmFibGUoKSBmYWlsZWQuIFRoZSBuZXcg
Y29kZSB1bmNvbmRpdGlvbmFsbHkgcmV0dXJucyAwLCBpZ25vcmluZw0KPiBhbnkgcG90ZW50aWFs
IGVycm9yIGZyb20gZGV2bV9jbGtfZ2V0X29wdGlvbmFsX2VuYWJsZWQoKS4NCj4gDQo+IExvb2tp
bmcgYXQgb3RoZXIgZHJpdmVycyB1c2luZyB0aGlzIEFQSSwgbW9zdCBjaGVjayBmb3IgSVNfRVJS
KCkuIEZvciBleGFtcGxlLA0KPiBjY3RybmdfcHJvYmUoKSBpbiBkcml2ZXJzL2NoYXIvaHdfcmFu
ZG9tL2NjdHJuZy5jIGRvZXM6DQo+IA0KPiAgICAgZHJ2ZGF0YS0+Y2xrID0gZGV2bV9jbGtfZ2V0
X29wdGlvbmFsX2VuYWJsZWQoZGV2LCBOVUxMKTsNCj4gICAgIGlmIChJU19FUlIoZHJ2ZGF0YS0+
Y2xrKSkNCj4gICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZSguLi4pOw0KPiANCj4gV2hpbGUg
dGhlIGNsb2NrIGlzIG9wdGlvbmFsIChtYXkgbm90IGV4aXN0KSwgaWYgaXQgZG9lcyBleGlzdCBi
dXQgZmFpbHMgdG8gZW5hYmxlLA0KPiB0aGlzIHNlZW1zIGxpa2UgYSBjb25kaXRpb24gdGhhdCBz
aG91bGQgY2F1c2UgcHJvYmUgdG8gZmFpbCByYXRoZXIgdGhhbiBzdWNjZWVkDQo+IHNpbGVudGx5
Pw0KDQpBZ3JlZWQgZm9yIEFJIHJldmlldy4NCldlIG1pc3NlZCBjaGVja2luZyB0aGUgcmV0dXJu
IHZhbHVlIGZyb20gZGV2bV9jbGtfZ2V0X29wdGlvbmFsX2VuYWJsZWQoKS4NCkkgd2lsbCBmaXgg
dGhpcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpKYWNreQ0KDQo=


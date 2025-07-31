Return-Path: <netdev+bounces-211223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3160B17399
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20161580098
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E51B4242;
	Thu, 31 Jul 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="c5ywO/EA";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="vR7Dg7D5"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29C18DB03;
	Thu, 31 Jul 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973992; cv=fail; b=OwjQOUq745hN3hXouLXXxRBZHwIiEjX5iVmxRojjd4rVs2nqZTIHkD2wtiE5V0myv0u8+xpuGzvJRjgI4ThcSiGLl9P2vAW0pNx7FdElwLgt0qgfSloYvI7mr2zgFrOfSNLxjPg47SCwv3p7G22N0b3flbQcV3RGAaIPsMMLomk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973992; c=relaxed/simple;
	bh=ewrhw6mCpzzUlouLadsWgxFZlT7/xFnfuSgvgmhCxRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=D8k40DVwoBBm+HsOsshVY13bICe+NT0fl1ESWink59uDaTJMWSP+1Ro82rgALYRc6CK8KN909Rsr1ivPIXcYERPTuWI61oNSa83HK3jtgqJcu68paTB5tHd0STvVJedGsHx3sUn4XthupcvYNU2SD8U8/cAF1P7+AiTl9VJWBJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=c5ywO/EA; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=vR7Dg7D5; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56VEr1Ds1187692;
	Thu, 31 Jul 2025 16:59:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=ewrhw6mCpzzUlouLadsWgx
	FZlT7/xFnfuSgvgmhCxRQ=; b=c5ywO/EAYszQpy+YI8k5fYnEg7kTb5nKMKJZkw
	gPov6FHmNSAuDUMwIxmVQKlVQHRheOrCJ/GzJB9sva9/3rTTUntyg0TeIpCh1ECU
	NPA4gO2FcMyz2tXv3ciITui8bzBb7gG/CQfxultTPEOIY/USd5O11WH/gE8x0X8L
	YOlxZfZgQ8X76ANI/4nram34wnRjpBpnf3PLvqN2MJjsc6E6pIg3iuc3O63t6LgX
	MkdJg9GYVKmh1wBx68jtg/VzTZ+ckQtYWEGd4R46DW0/fW7bMADgB7ubAR/QQU2y
	1eLZznLUz47hkdj0EFR+uN6ag2QPUoCqfJc6v8SYTu7EyRsg==
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05on2090.outbound.protection.outlook.com [40.107.21.90])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4887du04xm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 16:59:19 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLqjbslu+c1nvhba7ODXmB6OUFXgJNVXCVNZstQg3CfQJmG4gkeM3oAfUINSVg4b+cGCqRN+goz3YV+XSA8mTBb07zIXZOOT7MNd2ES2clXcvOSxt2bx9PhTTWbqhZer2ugG3XwpmLLbz+jPUIA5eGhYA0Swnaxn8nvs//ApusyF10jW2s3n+/IDvBN3bToyBFbtqCkzub1Hv64XMV/pIOdXaM7M9CkwIswcAucC6XyjxUk6JdwzvlruFsH4g0cCsgZqweJEgJP21iTKC8nH2PVYuRm0g8RKATwYId4j9n+x/xpVj929UEBWdGVwEln3CSCZIwNm0j8ct3hysiSUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewrhw6mCpzzUlouLadsWgxFZlT7/xFnfuSgvgmhCxRQ=;
 b=N4MTFKFNvQBk3dhKVzPB2yF+zDBHoDs1m8WlwX8wVvV78rmCpNsOPSwhMln1vsaGcImFHAWBBrRX0ZFEX3EOmAosApE06bhW/LbKJG3WrygSVO1WIYgQ40JYHpB2oN+EBHHC0VK/x1MU8VAzNm0QfgjkeZoqGHPKS34iE5mbT71R6arwhbwnKsp9yuP71iaA32dm1T8IQzcB5lFGGzQTC+MkK9U/qIsHWl55dvxUrY+ni2ASjQUxcXjv8fLISPCbBR/c2mIU37jfgsyO3Y2Tw4vRR6Zy3EZwA8aR2xZVBvWlOQStGUHIxG/sL9Ntm10E7k66zYYgXTEeo4Bh+HxGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewrhw6mCpzzUlouLadsWgxFZlT7/xFnfuSgvgmhCxRQ=;
 b=vR7Dg7D5hY1pji6IGx+hyklP3/WG3RFinHCMwiYXLxFt7U5drdYm5t/iSBLgJ2UkAJztaQ0f604q+iiDvTKD6nE8rDJFoJfS7P3XBxiiSQD18X997qRqf/OsVop8/qRI0MmIwiYM8lNYNl2yQ5NsJoTcYftYdPu8rmDACfvmV9Q=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by OSMP192MB2492.EURP192.PROD.OUTLOOK.COM (2603:10a6:e10:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 14:59:15 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 14:59:15 +0000
Date: Thu, 31 Jul 2025 16:59:09 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Aquantia PHY in OCSGMII mode?
Message-ID: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::16) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|OSMP192MB2492:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9c79fa-dd6b-4e49-9ec5-08ddd042d129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmJLSTZDbGovR2hTd0FUUnFnMkdxREg4Mk9tTk9vdVVVMVNtYjVKMEZDNHNp?=
 =?utf-8?B?MFN3N3NNTVE2b0dMd0dyVTRkRzNtK05qa1k2MXZjSnU5ZXk2UFRVQXk5M3h5?=
 =?utf-8?B?Q01RZFhNMzZPTUM3N2ZhUFVOQ2RKeHNoZDN1RmpkT2FMVnpOUWNMbzhmc2xj?=
 =?utf-8?B?dTNmV0JtZEtKSlIxVVBWVjY1NDU4dmVPQ1dHWjZ1STNZMTErT3V4NUlMYVRM?=
 =?utf-8?B?WFZaUEtKSXdubmszYzNPL3FZZWwyTDY0aTFiT0dmMnAvejlGT0ZzS1lVNklD?=
 =?utf-8?B?U1JIaUhaWm9SbFM1UlNjVkxIb01qUFRwdENFa1A0Rk8wdmo1clJ2VVBNU0FK?=
 =?utf-8?B?T0p1R2xpL0N5SVB4UmhIU1l4WHVsUjV5RkJsbWlESnlxeGo5c3h3TXpQRHht?=
 =?utf-8?B?TU5JSGE4WWQ1SnBiWmwzVUQ1ektaMXArRG50MmhYUUVaK2NyTGFxY0UrUnUw?=
 =?utf-8?B?L3IwY0Z6TENmd0tXVGFtYVEyaEdPU2RDdCtVUmVQRHFUS2lBdVJYTjFicGN1?=
 =?utf-8?B?TlR1eUtHTkVQanZMTVlrelpFSXZMTlJ6Ri9VaUxaRHJhUy9pZnhub1FnN1Uv?=
 =?utf-8?B?SWJhNitqOVdVNkw4Y05aajBlcXQzOHBXRXRRWGNvdTk2S2N3ZjlHVEFHVVE1?=
 =?utf-8?B?MlZoTHB2cXVZRklvejVXTFZHeDJiaWpLS2JpdXlwT1dWOW5EY0VON25WeTJR?=
 =?utf-8?B?TGZjSVhLbXJiN1hMUVFGbjBPeXhxOFo5UGtjZFhyY0pBNlhDcU1MaENXcE1j?=
 =?utf-8?B?WWJVN1FTckE5MXBnRDBTQjBHemZXMEhCZDQ3QTMzZXBod3lLajBJaTduNm8v?=
 =?utf-8?B?QzlXeVFrWWVSSVc4b2owK3JpRXEzNG5oUFRlcGF3L2JucWZjQXJ4ajgwVDFn?=
 =?utf-8?B?dW9Nc2NYM2c5cno1S3VTd2g4K3FYNUw2N1R2RU9ZdEc0NXZBSWNqU3h1VmNP?=
 =?utf-8?B?NTUwNVNSaVh1V0dBTGpsbnN5RHFIQmtWamt6aU9Pcmc0YWhIZHhVK1V4N2Nn?=
 =?utf-8?B?eVdXOCtVRzJ5NlE0dVRrY0prWFp0L2NxNVpTY2N6MkpnalN5VDlGOEErMXQ5?=
 =?utf-8?B?SFpuRm1ibDFKUW1ZRy9ydDFlNmFrWHd0Vnhwd0lSMCtJS1VzbGhHb3lrNFNK?=
 =?utf-8?B?UXdEazZsOGo5QUFXV2t0M0JzRk1oSzEyaG1OaFNjRWdBREJZSWJzNmN4WDds?=
 =?utf-8?B?dnAvMm8xZkNDNzByWjlQUFF4eFk3KzZkMlFpK2w0amlVWndQWUxqNW1hZlE0?=
 =?utf-8?B?NjdiOEVxK1lNZEdaVW1NU3l2TmxBTnFoOERSeWVVNVlEK3VvT0FlQmtNd2dl?=
 =?utf-8?B?a0FMN29kSzJNUUtpVHlLSkxIczJDQjVLRk9MRXJWVFJCSXl2a0V3Z3M5Mngy?=
 =?utf-8?B?T1ZXcXVFdHREZEFzVkhsUEpoYTBNZEFTREZERmE5VmJZUENCay9uR1NCM0Ny?=
 =?utf-8?B?MXRUaU5pS05WckhDWkh4K0FtNzVDRmIrQ1pnMWMzMVVTc0FFUjh5MEhWOWY3?=
 =?utf-8?B?R2tGS2FVTUd1d2lCZFU0cG5zekh4SHdkTWUxeHkxV3ZEZldPQnhHOFpBMlpC?=
 =?utf-8?B?T0lmK1dOVW16dXdJcWFKbytZOXUyTXArc3luWGVMVHhDak1tQks1UGRMNE1Y?=
 =?utf-8?B?aWMySkZwRmNhdUQvVnRQWitDNGFXeEI5THVVUDdhYTExQnpNWk0wM3ZuRERh?=
 =?utf-8?B?U0E4MHhPVjF5ODgzMmswaFJmKzF5M21jaWRrSWpoM0xqVnpKNlNlK3VYMmlo?=
 =?utf-8?B?N2RXTFNKVHdMSWdjQ1NtMTltbGd0bHZWVGxzK0FsZzlxaFlyRDRmN1pRd1Fr?=
 =?utf-8?B?V0JvbDJQVytuWlpiUlNKcndZQmNUS0lxc3p5ZWk5TTc5VG8rT1lDS2UwTklK?=
 =?utf-8?B?eDRLckF6Uy9ROFZUcWljdUx5ZlpmbVIzV1ZFU3BTNFJVbURQalM5RVpnRm9x?=
 =?utf-8?Q?XzNWNZ1KEX0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFJHaHhJU1dYWXZkUXJYZDBSWnRTSlE2Q1lZMHNvQkQrN3VGZkJPUU0zbkpW?=
 =?utf-8?B?dzdCZWVCQzh1ZDJOcXBDWGFOUDlZQm8ydmV4R05Ndlh2d2VDWkQrYVEwazBJ?=
 =?utf-8?B?UGFydGoxMzBhZCtQUE9iQzNHU2lvd204WXlDM2NoL1lIRTdlV3JXYjNhTEND?=
 =?utf-8?B?amRBVk1hMkFMVi9iRjRpSmcvQUxyWWJTSVIxclRHMTBGU2hRdFVxLzJVRjV3?=
 =?utf-8?B?RU85WGRZMFBLMm14bmpDcGVoT0ZVY21XZGFhNEJxUkVVUllrTm90ejhoVlNF?=
 =?utf-8?B?M05pVGtzSDVwdHFVV043b0YvdHZGajdqUm9HM3ZXK2NMZzNVN2hLWmVJNnEy?=
 =?utf-8?B?cUx1ZnB4UUNKbGtna2x1ZWFVUDA1cjl4TGY0cC9sYVpvZHMvV0dtSHcvOS8w?=
 =?utf-8?B?bUlSZUs5KzFpRmVKcG52QmRlRzhOTG9pZWdkc3YvcktUVHJFUDYrc1NPWnJt?=
 =?utf-8?B?b1ZobUozcERpRnJzQVJta0o2WWFPcWZERlJsZDF0Mk5hVTBjeDdXMmVSNUJh?=
 =?utf-8?B?MkgyVUhOcytjWU56bXE0a2pxUmFnZ291T0plejJVZHZxc09qL1o1eTVQdlNx?=
 =?utf-8?B?OWFWNDBTUkE0emw3TXNCTzFSZENOQ3N2dW9JUVJoZkVaM2RjbFZsdkhDbU5w?=
 =?utf-8?B?UitzNmVkektuV1Fla3YwZFRSNlN2ekMvWk02VVQxZHBqeVc4c0NpSnJLQndl?=
 =?utf-8?B?bU05cllFMjg5emdPM3FHRDVTTFh0TTJHOHZ5U21ObmJCRlR2RUxnZ3Z0MFJP?=
 =?utf-8?B?UFBodkcxb3k0NkROUlluNnduYk83dUE0OWNFRmhTbDFaSVdVcEF4cW1RM0dn?=
 =?utf-8?B?S2Q5SHJJek1uN2E4R3cxaWo5ZmZGdmc1cFVWV2J1ek1QMHRpZ3kwdUNwWlVm?=
 =?utf-8?B?dEcyNmtROHJTdTU4TzNLekV5ZUh0VFZSamE4VThxWm5yWFkvY1NCbDdoUzN0?=
 =?utf-8?B?cWt6U3daY2x1ZnJ2aXZlN2NjM1VyUG42V3AwalVZQkZ1bzltVkp0d3k5bzVM?=
 =?utf-8?B?YmxsclhpM0NVY0RZUitwdXVRTzZMNXNiMW1jZUViL0Q5d3Vmc0c3RmlyUzFi?=
 =?utf-8?B?M1BXOUY1UlRQeU5zVWVCSi83SDJENjRVNmcwb1kzOHRFSWp5WkhaV25OWDFh?=
 =?utf-8?B?aFpNSWV1N01sdjI5eVRoSG1VTFUrVXJsVTdXR3NueDNlMUc5bmlGMlNSR0Fr?=
 =?utf-8?B?TnNMN3JTOWdVSkxRR2dIaTdMNS8zaXVMbnEyQng4Qko1emllNWhVNEVTNnVi?=
 =?utf-8?B?SUVrU1hGdnh1c2RCcklUYitTYk52aWVBQmJnTXBUSkVTWGcyUnlKem5JWHdr?=
 =?utf-8?B?MWZYa1lUM3dINDkyTXZ0Umgxc0QxSHJIYkU0WEhidHZSTDFFcElCcStNZXEz?=
 =?utf-8?B?MEMxbGdHTE05b0QvVnJFUTFoS3VBZVVpRHY1TzQ1emdXZEg4UnpFNVhFNFBV?=
 =?utf-8?B?MmxoZnN3Zk5wVnlVL0hDTTZabFR6UDZYdGpkYWZaVlNYNG1aTG8zdTgxNkJF?=
 =?utf-8?B?R2lSV1NiNURvbnpHa2tSeEROdStJR3ZheGZKeUhYbm5DMnFEWDMzYkJkMHNw?=
 =?utf-8?B?QjM1VHFUb0VFSitnQ2RIRFVzQzZ4a3V6WGhhOWE5M3U4SDZlVHpiL0NZTHpU?=
 =?utf-8?B?TXRUaHdrTXh3UXg1T3ZTcXViTWpUWDZSbStpUkd5VEx3RElKMGxQNWgwNzlW?=
 =?utf-8?B?N3ZsWWRGMEpWc3pWc29KcDB0eXo5aDhDazNUMEtQYTIrc01sSkM4RUp0VHpX?=
 =?utf-8?B?YVZVMXg1QTkwaC9aSjloNy8rbkx3NnZLWFAvQUc3TGVtNWNIT2J6V1hhSmxT?=
 =?utf-8?B?dHFLQXJlaGxRWGhWQXNyeklFbFBjWG9WekRYaHV3eFpuL1ZwbUxqS3h1anI5?=
 =?utf-8?B?NG0vbW01SGVwSmVNQ1dwdGNwZFhCRFpMMi9NblNlQlFjK2NQWFp3R3hMeGRm?=
 =?utf-8?B?SGdoQ1Bsd1dNME82MU5Ga1ZvenYxVVpLUkNCNnl3QUh6RjVsWVpPdkRWSFFG?=
 =?utf-8?B?M1RUV2NCd3JtMDViZjd2LzdoUHhGVXRHQXRlWUZYVk1YTHVBODB4MzI1MEda?=
 =?utf-8?B?UEN1bFZJM2hVSXp5ck5RU1BtSi9JYTFlczdGZHEwWXJSTytIOVBoNDFpVXVY?=
 =?utf-8?Q?MgINGntVpWAERpYGVcQZlnmZI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HwxASKVA8AgJUFp9mppyguump4NOuqk4eJV/oga0EwCiTZkHtYjlldz+NLern9svWwOL4+BL+eXZDutl6Ilg8NramVbUhYi90B3iBJ61FeaXbqTV+PHscIuqTGOAIl4d7zsxxCqQptLGu44Kv6UPstoMWEyjX+pe3nvS/zboEw0co2Ll6+tGHirVtb9EWDACB6kYHDN8keYWFSN3ACk49EaPZpBF0SPF7aXu+wHch5KYf9Qd9vzfKMIs5LVxm+BV0M91SWtwV4J+zWnISqy2QaAa0R+RhYBH6Dd/oXZTzqZNxSwDucLKokZjSrWENMN4hChBq4U4bhMYckydVAe/kH+ebMpiF30kFbiDSg1kaxwwy79SUsTXOOMppE4T2xKO7lvadOuX7sgw3K0H5lSECk8vNd+GfmAo8RSCf37O7tJAEDA+9+COtk2ycAPFW4k/3Np4e94w25BCKkNwrGLaAePvb9LWFSxWxXe96AuHMq2lYJNfxOMzJ0NJ0crlY3Ffjr86gOJIXSuRL2v3HCG1QhddD/23ss69UbyQtyu95jWHJ3aRFJQ38E82pPam0QK19LVpe1Nri81so0m2HhAEczdH9gGv6QGy8bxto603Cisx/4OMjTYK6blpRUvg6cbx
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9c79fa-dd6b-4e49-9ec5-08ddd042d129
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 14:59:15.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cj/Q1vkyFeXE8BsJc94r6Pxd/28ElygipmnK699n99JPc6KZ9OPPUWYkTPg4KyJEHt0Siu1+XnhR2xNv7UbWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSMP192MB2492
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: OSMP192MB2492.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: fv1qzQ4ZwHgpEiSf8R6Ot2VACLRUS5W_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX93prtzRxU6YW
 wuZpq0qTZ6vd+TNsvUdC/2XaE3LyYQy9WYF7HcTT747q7T22AI2fsRhiyJQ6husIGVZg2bJLZ+u
 oq5mbeZUWYaz3xYEhSGVHHYL8mjPYezH2f2WlPqF1a12EsbQ2O79mkwNc1RI0M5IkdaOFbsmZsi
 wjf/bbF/dFTbktjUWAQ1qpwcjWy3clG1Z6/iJFPKspfeHVGavLaXBkHZ3ZFZHn5fVwvkvuJapV+
 4BDuq1gv9X6Wju+9+tIbwerXn/zu6/ypUKkjZppqmjrcoAo3shJ1hj5ZMWZss7BxkNhLZ3BA7eG
 QQzPEGsmdQ63J4G/GE+4jTRmd+30x1ZFZ4UkfemIi/sXHlPR+qG8PW+4SX4qhBYmZJvdLhVxT8P
 +2+onfVR
X-Authority-Analysis: v=2.4 cv=GLsIEvNK c=1 sm=1 tr=0 ts=688b84c7 cx=c_pps
 a=+BykxaWcsiOs4qVXBTLOtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=8gLI3H-aZtYA:10
 a=soq6hOjjNVpKfmhtaSYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fv1qzQ4ZwHgpEiSf8R6Ot2VACLRUS5W_

Hello devs,

I'm fairly new to Ethernet PHY drivers and would appreciate your help. I'm
working with the Aquantia AQR115 PHY. The existing driver already supports the
AQR115C, so I reused that code for the AQR115, assuming minimal differences. My
goal is to enable 2.5G link speed. The PHY supports OCSGMII mode, which seems to
be non-standard.

* Is it possible to use this mode with the current driver?
* If yes, what would be the correct DTS entry?
* If not, I’d be willing to implement support. Could you suggest a good starting point?

Any hints or guidance would be greatly appreciated.


Best regards
Alexander Wilhelm


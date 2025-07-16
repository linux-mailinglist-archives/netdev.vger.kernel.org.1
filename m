Return-Path: <netdev+bounces-207404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E406B07047
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E87AC60A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC1291C25;
	Wed, 16 Jul 2025 08:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464B28DF3F;
	Wed, 16 Jul 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654036; cv=fail; b=O4f/xNQYNM/evXIkpp5sDBEGApbCepzcR+mq8FwPEJ/NRgNGx1EBISJ6+DjVRSyBypeAy9QQQxBrWEHwp4+5nn2u0RjjIOirY3Gsgo2qD9Kn3MsMvHFUZJNJDAnvssVBRuvRPv3MeQS2DMI15i5aMe1bRowcB+g1y/JNry5oM0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654036; c=relaxed/simple;
	bh=NN2sF41vWB9xoKjACCftVc1Q2Old7v18Bf1zNaolM6w=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=EdPBu+thlZPfSHLTgzhKVwDPfctBnALwW9vfw+KlgHQaEEleN2SJn5PYw45CwEXRVTZsplh9E9qc/9QiSb8++yJevyIUM0yMW+PzQJnLG4L+u8VFGNmT5/Ic/LuTyjG5yJjuYx+toenoNynt45Rr1Tw5JmI+/Q3E1r3WZGHejYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G4i7x31306136;
	Wed, 16 Jul 2025 07:55:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47wdva1kv0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 07:55:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+RMub9fMfCPcb1PMTO+uvyF7QmA75rZBbTPr0mYZHLQwDtJIkvKbMUbNM9i9jpuZEkLYRlwWPrrh6wRFbBPQmvSteqXY/QQ1W1WUy9CwtJFNkJRHsL+Iw9w5TTldXRZAxD5SM6dZXjUCsnm63dhIGAkCMYQ8VPFsyPOeG7OvXXhwz2Vzb1eOOFtYP21uFLji8iOooCruRBRfX12ZS2JNT1Gdb+bxXc/U8+yTpYDOYdXRejYg8fLdc9h4y23PkWjIVH2NPhoEBLqot7EnAV/iHtg+rb1YrRIsNQBf43yhR5DiBOdbgmRwGico1p0iVuvDtCW1KUv0CYGOK2sOJqcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8n/BoaUgu37vmN30vphNTNedGOhPm1oyhgCML/vr4oM=;
 b=CiaIZwkojJ3Lku263B08EXktU6+bUpUcKADoQPSDXWcTgKj1M7sQpkdhDc29Q0kVL74aFpLx1knCfqae3AqG8K2Dej81jdS8R60dZS1Sh7gn7dslwyy8Vf8dNS/0Tvn2hJE3dTzCI1XSjT3iONqBxSTJick6W75vTqPmWKTfYGSinSvaOPA3XeCQq0eGspUokQ7xJFHsSBdpchw/f+8YzpXlS2+93YGAEIkU6fJ2DmUK5f9HVBJBeAG0HhjRX/8a2UsjedDUEeB9tVeLqWhiFMjQrC3GWmP6nkRiGQDD2YB/gPTynjWFrw4e+Tkb1yQrA+nIKZ4KCi6hqHdFh8aAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by DM3PPF213267FEE.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 07:55:37 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::18de:be50:513:1a84]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::18de:be50:513:1a84%2]) with mapi id 15.20.8880.027; Wed, 16 Jul 2025
 07:55:37 +0000
Message-ID: <ab95299d-d986-4e2b-9464-44e3467556e3@windriver.com>
Date: Wed, 16 Jul 2025 15:55:30 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
From: Xiaolei Wang <xiaolei.wang@windriver.com>
Subject: Phy with reset-gpio fails to read phy id during kexec -e
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0225.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::8) To DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFD667CEBB6:EE_|DM3PPF213267FEE:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa85781-f4df-4272-5aab-08ddc43e2674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vnk5ZmtJRFFmVjNhMHRLVURVTnlnNUp2RHVPaUFUTHpIa1VSbG9WdEtnY3Iv?=
 =?utf-8?B?dkJrejRhWjE0NXdCUjVyd0xON0xYWE0yRjdWWEtZZE1UdE1LcHQvcTFnVUNK?=
 =?utf-8?B?M3liNVZnNy9CRzN1NTRhSkpZWUhUN1VvT0JNdFpkNFJETW9DNVlydkFYTjJi?=
 =?utf-8?B?NHZCTUlWTHRldE9YSWh5TXBqYzVRdnF2QlRRbmxuQVU0MUJlNm9KRldpNG4x?=
 =?utf-8?B?K0RhMEs3QmVEM2VXTEU3S2twK1U4Uk5lcGU0TjFBL0ZmS2srVjJhWTNGQ1JV?=
 =?utf-8?B?SmkxTEtRU1J1ai9MTlM3eWw2eUl1QWNTSFQ5TVc4Y3BRazlLVkZQY3V4b0lv?=
 =?utf-8?B?ZWF5akNFNG95QkUrOTZ4WkVNWEpobk8vekJSQTBaYk55YmFkb2JyNHNla2Zw?=
 =?utf-8?B?akhubm1kVDBtZXVSRjNWV1dhWEdIZERQSXdQekdxWnRFVXo5aHNHSXhCSTZ4?=
 =?utf-8?B?MGovcW9rclFubXFIUUZZSjRCZjFRSFZwYmlZM3hxRGlYNE5DZnNJc0Q1RUE0?=
 =?utf-8?B?c3ViemhGY0RuZk4yK3IxOVlFamxRcjRMY2E0MU95MEh1Z1Y0VXFOY2V5NkN4?=
 =?utf-8?B?MUpQc25pT0EvQUhnS1Yyekc3TGNlZjEyb1pVT1FnTzJXamd3b1pwL0ZDclJv?=
 =?utf-8?B?YUVBTkRQbW1KN2tQa2ZYaWFWQTJKRzh6dXlCTVh2RHZ4bUFFMmVYajk5RUFv?=
 =?utf-8?B?aDFRTExPeXAzT0lQZFp4OHhyamt4VzFTQVVBNUNUTzdvM0luOFVNVHY2cXpo?=
 =?utf-8?B?YkZLUkloUEtONHUxeWlna1BxV1NWN1pEWGpESjcybFFzZkhpR1pDeTlDRDRj?=
 =?utf-8?B?YzhzQzZ6SEtKcTFzM1J2aTdodU9QOHBMamFoRURyVXJicU85cFpKMFhoekEy?=
 =?utf-8?B?T1hzYTYrZVdPY0NxdTE3OWxKZmh5dTltek1tNGVWWmwzVmJ2bUdSVGtVbkRt?=
 =?utf-8?B?cmxoa0N0VXJMdG9qaUExN1hOalo3M0VEWEgwTWZ2N1JnQ0tuN3kxUHorNVZh?=
 =?utf-8?B?R25QYUllaUEzVkM1V0lENWFFN0NnK0NqbUkrbC93ejMxYXJOWkJqZlBqeHY3?=
 =?utf-8?B?bjVUT3dpV2IwZTczbkFKejhQNzl2ZW8vMVNXTDFGcnc5aVBYNE5EUkhZdE9m?=
 =?utf-8?B?NHBQT1NKYzM0U01mUitCakVINGFHTXpSM3M4MGVyM29JM1ZRRlNVU2g3MXQz?=
 =?utf-8?B?Zk9GRzd1OGp3TTd6K0J3OVpVN2xFeXJqRDVTZFRqV21KYU5ycGdMemp2bGVL?=
 =?utf-8?B?eWFtTjdYWTlzakRzK3N4S3lpbURTbm41UzVhY3NVN2lTa1VFQklJTWpHdWN2?=
 =?utf-8?B?ZzFXTXRqM3U0eDMxWUxIUElxZ0ZKUUQzMmpjRnVXR0xpZ3I2ZWdrNkNmK1Yz?=
 =?utf-8?B?V1hIaWJIMjI0UC9CaVE5MWdwd3FvTjZjYW5RcU9SL25FSFVMUUJSQ05ueW1K?=
 =?utf-8?B?YWFQRXBxOUVPSE8wd21JTG9SVG5rdWpLSHRkZHpoaWk3bkdoQ3dDWGh5UjRU?=
 =?utf-8?B?dnRQQmppMWNDQ2NCNm8zNTZrem1JOGk2bzVmT2o1cHN5bWRtYlVEQ01QN0FF?=
 =?utf-8?B?MmwwbzlGemJuOTZSQ2REVW9HaVgrbHRxUWJQbDJRMXRQc1NyRzZuS1BHRU1a?=
 =?utf-8?B?NDNUOXRORWNVNjFGRTdST1E5ZC9mZGpOTFlDdHhZYU51WGp5K0REU3Y5Q2Q2?=
 =?utf-8?B?VW5qa3hjQUpSZE5zbFRrd1E2b2QxeXVaM1NUbVh2azdlQksrY1JYRzFLRmR4?=
 =?utf-8?B?UTdQRzBybFJZVjVuS29JR3FXSU5QR3FFMExTOExOU1B5SENMdDh5aHE0ejZs?=
 =?utf-8?B?ZU84U29MWGthblNaRlZPWU1lZ1M3ckFPTW9NUXhnbjQwMnNONENNR3YrOTA2?=
 =?utf-8?B?NFZPMlROMUNXZ3pLRUhuSWVXNkJIUGZ0TmxFYjJIVm5oeFhKQ3NvdTBCcmxr?=
 =?utf-8?Q?BKxYCuK0qpk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD667CEBB6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjV2d0VhalZvYjd5T2JXYnB4YVhFSFJIMkRYS3orc2c5bk1ESTlkZjlSME5Z?=
 =?utf-8?B?SExXRnZPSUdrYVNUMEN3U0ZzNHpQaU9sTVRpVFk2cmdxU200K0IvbzJVbXFT?=
 =?utf-8?B?V0lNQUd4aGw5SkljdHpONDlZeFhiVThDbDRDM3hPODdnM3RUbG5LbU5GMTBQ?=
 =?utf-8?B?WktXa0liUkdlcU5LNmNqemM1WkR6M29iOFJ0NURvVy9mcGVHeEUwZUJmS0px?=
 =?utf-8?B?QnhZYkg2RWZldFNLbnlFc2tDUlFaa0RBcTRYcU00Mm1ueGsrRzFKTE5WdndP?=
 =?utf-8?B?MVphNVM1cjBONFVoNHRpWUs5NTdqVncwTDNTZEEzV21PUjQzTi81bjBDSDdB?=
 =?utf-8?B?RkEvb0YwdVdiM0RDdDZLOFVmUkdhV1BUSWpJTHdjeXo2ems3M1JVYmhHWmZx?=
 =?utf-8?B?eThaTkFJc3llVDFtb0dkMlRHWVBZUVhHOGhMQXJNNG1zak45b29EVlZjTU0w?=
 =?utf-8?B?Um9MejFRSFlQenJLam11bW1rNkRlZkNGbnJ2ZFgvRkYxdmE5ZXEzVXk3NVpH?=
 =?utf-8?B?NDJ3aTVVaTRiUlRid1I0TFdjNERqbHE1Y0ovU3BNRVdYZDhCQ2ozWnlGVXZ1?=
 =?utf-8?B?SUk5bnpHQk5rZjZxaFdBdkhsWk1aU2FsMmRiTU1icTFTRVB2ejlGZHVYMnRw?=
 =?utf-8?B?Vko4OThodDlUam5BOEpuazY0WXNiRFg0QVl0aHcrUWNkYXJLKzFOU1JHVTMz?=
 =?utf-8?B?aGQ3WkFyZFFnK0Y0S2YvYXVOSGNQT1U0dndnd3ZrWktGVUpGSHhqcDlKbDVI?=
 =?utf-8?B?N0NxNnRsSm9LajdYZGNmS1Q0Z1JxNElMQktIcFBFbWxyc0JxUFpHOFdiQTV3?=
 =?utf-8?B?emFWVXFRVUQ0NWNqZFk2Tll0L1lpUjdnUVFTdHpmSW8yK3ROUTlIaFpVSmZB?=
 =?utf-8?B?Yjd6bll4V0dDMkZIbkF2ajltQ3RaSm9nbloxSHJRRlVVZFdZMGthNTc4TS9D?=
 =?utf-8?B?QUZDKy9UbGlITUxVMEJ4bTlibUl5amlzUWs1RCtTSlNDTG1LejZvWEVMbUpG?=
 =?utf-8?B?akhPZ2d2SUxhanVadGxGVHZScTV5U0tnK3hxdWRTeHFaekFiY1NSM1NUbytr?=
 =?utf-8?B?dStmSTFMdGNMaXhNYUJWOVJRQVJvM1FKS29Lc2VDRmFRUUFPWFdqMjh6aU5E?=
 =?utf-8?B?cmhPVTVzdUlDalZaYVFLd1R2dEM5OThHT2ZGMWF3RWxselFIQkUxQVdJd1ln?=
 =?utf-8?B?ckxSbkVBRmt1aEplR2QyUmxVaEV4M0h3dWhmeXB1SG9zS3VrQURFQ290WXF3?=
 =?utf-8?B?ODh6T1k1eEVBNldoQVJWMG1HL3VJeGFCWExJZ0ZGcmM1ZGVJVldHWUdEMFVE?=
 =?utf-8?B?a21rKytXUW1wNkFYaGpjSkJra2FYNW5lQVAwZ3g3dTV4QkxoQWhXdkJDWFF1?=
 =?utf-8?B?WU01cWVwZ1ZUVDdnVnh2WnJrTHBvMDlGV21ZUU9WNEUyOU5taUJZd1o2dkZl?=
 =?utf-8?B?Zncwejd1RW8zZ2FFTExhR3JmZ3RqSkRrNEpiMHBpZThMT1k4VzNWY24vK0lj?=
 =?utf-8?B?UzQ3amIxTTYxZ09Td1E0aHFwTHdzUGh5MlRSbjhZbUx3K0g3NlpJWDkrVlVI?=
 =?utf-8?B?S0hzKzRUckZhSlZuc0c3L1VqQU5McFc3OFV1UlJwUHB1VWVlT0xEQXVFcWhR?=
 =?utf-8?B?enZCVDZINFVVc05pamZoUDlwK1lvdHhWSnRvdlk3cDBwSENVcFFUbXFuTDdo?=
 =?utf-8?B?NUlsYnlnVUdXV3c1WExiMEJLcGpOb2wra0lTTEJEazF3clpheUtGa1FGa2hz?=
 =?utf-8?B?V3A2S0xHVHlXS0VWN1NLN0J1RVp6NFZsSFV0eVdvUS9KMmlGd0d3bTRPQ0Vy?=
 =?utf-8?B?ZEhVMGp3T29HMk1SOSt2eHZqeUh3K2F1S1RsY3lvekEvVmFKRFBlaFNmQ1NY?=
 =?utf-8?B?TDM5ZGYxR0JVTHVyT09NR2cxUTBLend1Y3BML3lSVlJjOGNPbWF4ZGQ3cWF3?=
 =?utf-8?B?R2FBbFZVd1dUeXlreDBtVmVNSEQ5QVNPRW5KSVRSMHR1L3ZVM0Zrc2s4S2c3?=
 =?utf-8?B?NmN3N0NEbjdYSDBZUEhNVzRuQnpZc2VQbmh2UWxyYjZIaUdXQ25sWkphOEJO?=
 =?utf-8?B?LzhOUmdueURETnJ0aFhXdFdEYytTZ2VzNEJVUDdtVVFxdUFyK3gyVWoweklN?=
 =?utf-8?B?YWNuSnd6Z2lEN2tnUjhTM2NYZ2N5T1hIV0s5aDVjRUVCNk5xbGhuOVd6aCtu?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa85781-f4df-4272-5aab-08ddc43e2674
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:55:37.7418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMWxuQZT9mCGy+n87l/QsBPMjfOpl9p+BN5fCwrNGoAaK88cjcVFd447QCxxLQrxmOD3E42MmIS84Ag1JW5GZ5m9Dhx8YMnYh7HI4mr8Yfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF213267FEE
X-Authority-Analysis: v=2.4 cv=AbaxH2XG c=1 sm=1 tr=0 ts=68775afb cx=c_pps
 a=dCenUo7epVW39DLakCvRnw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=19fqWMbrdotwZWxj5f8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aKsXLUg2eqMX00SIBoyuUIVrRqPHDf8q
X-Proofpoint-ORIG-GUID: aKsXLUg2eqMX00SIBoyuUIVrRqPHDf8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAxNyBTYWx0ZWRfXx5UHA/9O7gXr
 chxfmN4HtWCBpQJetLj9/Ik80NmWjFjOduNEx+2tSCk76tswUWvuZReDIBS4885a5yg3mekKrVa
 TeSxE2Ki2l4MxnS39pClsDiT4aysDh9y5P0wwQQzT5p3TqhQT1cW6JpJwxk/Hiym1Ksd5efgQ9y
 HELSu6XL5a81LrMaXoDxlJ3MZQNmt6nJfEN7GHibqcCBGKgwyojRLO20/3if/0oNdO7TyYeE3GN
 AQ4Vd5YdH6fsEoBHD2FADtZ29MCCW1PuxbScGu9ZrEjZ6A/IZzZOpDo35bUZb3Sjxp8u68ciWq4
 10B81QVCHd/+vVx7LmUHAwWczxkSFAedqYl5SMhUGCjF6b8VIoIa3IojDv36/NoSOdVB+QwNXqo
 VHT/WmX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507150017

Hi

During kexec -e, I found that the network card did not work when loading 
the kernel.

I found that some phys used reset-gpios. When kexec -e is running,

the network port will do_ifdown, and phy_detach() will be called at

this time, which will call phy_device_reset(phydev, 1); to keep phy in

reset state.

After loading the kernel, since phy is always in reset state, the mdio

controller fails to access phy id. Therefore, if phy uses reset-gpios

during kexec -e, the network port will not work. However, I have not

found a better solution. Can anyone give some suggestions?


kexec -e:

phy is always in reset state

   pca953x_gpio_set_value+0x8c/0xf8
   gpiochip_set+0x60/0x12c
   gpiod_set_raw_value_commit+0xe8/0x1e4
   gpiod_set_value_nocheck+0x58/0xe4
   gpiod_set_value_cansleep+0x4c/0xa8
   mdio_device_reset+0x48/0x158
   phy_detach+0x144/0x258
   phy_disconnect+0x54/0x74
   fec_enet_close+0x58/0x218

After loading kernel, reading phy id will report an error:

      mdio_bus 42890000.ethernet-1: MDIO device at address 2 is missing

   __of_mdiobus_parse_phys+0x260/0x338
   __of_mdiobus_register+0x118/0x28c
   fec_probe+0x173c/0x199c


thanks

xiaolei




Return-Path: <netdev+bounces-218682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEE8B3DEA9
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE0A162F56
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926362FF150;
	Mon,  1 Sep 2025 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AY2N7tnr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qh75pmta"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C936522301
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719329; cv=fail; b=XVfREvmOnv9sFWzMllYwFeG4IN98KXvBj3Px2J8qUPbtdkKfBrufrVV53fxaPqP5MTWf/rnBRp8Ril1RaKWc0ohgHpJH2T1BVK5XiAtWi1uCdRTuzuY7ENNZYfweIuxT1qBhc/7zBUX55jywdfo8BiQk43IV9r/sfmCYJ8TPfhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719329; c=relaxed/simple;
	bh=qdxmTbA+R5Bd96kC+KnbGZ27cyrp84wJ3DGgHu+OQ30=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r27i+YP1ZLlnctzIz2x51h8QNwIjO2FjdP1E+2NHB8m9beNiScaVZMZXHhsf+VWCPFMgrHuEtTafqi2wOedCkXagoAtdfqq/zEKUAuAnINLbuJ3omRYBZk4DM8iMRiEF//xOJYsJ5lNjrBhtSUnx9siAH1ruS5IPWbddUFQfcgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AY2N7tnr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qh75pmta; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gp0r001212;
	Mon, 1 Sep 2025 09:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tAOoo5ZlqX7+A6o/SPjjYxn3f0oGZN1WzX6QKN32h8c=; b=
	AY2N7tnrufwEJ4aUhq7oI8sV6KEjz/xUuGuuTyIihy2QJu1H/1/E3Imco3TgP2jW
	4OhvOF6mKMTdN7zaWER7DRCi1xPsK04vkLhKPl9VrqKUjoqRGni5GZP6SJfQG8Xu
	jLrxzwfO0f0t+/znwnaGHfm1N2hCubUoGd8E78sbp2ZjbrIG9HQSLKwy0HtjLVJ9
	uZyqWaEXBqN1OKiN628ldhAKlc5Bxz6VOmErLTFMSuSEllYi7iELYEVIJ6gaMe5L
	9m6vYVSHmV0o93c4vcpcXKMScAtVLaZ6IePoZ8CrfvTfsfmtEo2Ox94vpt+PEezF
	GVFcano2eGM5NSUwjYuj/Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmba3r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 09:35:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5819MJpC011716;
	Mon, 1 Sep 2025 09:35:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrdyq36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 09:35:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4gfwMFHoWYeOEEYJMvDMn0Jv4MemwJrH+l22pAM634EEyJGdDQGuFzq8YvoACCtv0G8FEkkzqfUBf7RpsGiVbiaNBnNw1O/7G4Puxq8a/1AdcJpsJB3emaUfI3g2KS4pt2ViBZcObVyft+0asnSPVj5Z0iPb9ipFflawNei2Q5fspPGZhenOgeZ1wbFwn2za0ITQ4hktoqBXL+1WjctQjffFm9JSB0C1GGri3KslSO7j/GjgwUees0v9/PoEyCYQNAoArOGXkQmqZYtQvyuZB9+/5/L/4RlqbGbzUWtk0LLyT6Q6Q9PJ5MGT/P3oQVBWCdRbLuDlGYdJhth9h5YJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAOoo5ZlqX7+A6o/SPjjYxn3f0oGZN1WzX6QKN32h8c=;
 b=l6dZ0F3x5S/b94J6aK295PCd8AhorhF/eK21ZXlVFFy22MW7hQCT8LBakLTb4ZLBaDiXp5zxfbwNJTwnEV3TfrBmC8M25LgB3VFcMVgv5QokffLRaxsAXZndaSQZNeGazZ+qi4EmlKm/rVlSjJxKIoaWzPFSyrr1aHTZumLIOh61RFkrSnKyASqwhqAuHBUniWRsHIr4nMtPj7CBfLXHAePpRB0uJ6tIJ06okrndAqpd4MmBg1MuYbY4j3acI4zcO2mykkeUNJlG20hTfce72OvOuZlRLrvKMyHS1ranLtwoVMmW2qkPKxsuVJfoi+FCT6/9VZqByPzg1zrNz9Kr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAOoo5ZlqX7+A6o/SPjjYxn3f0oGZN1WzX6QKN32h8c=;
 b=qh75pmta5Ok9yqIoRu6+XmaO+w4QqONM6Nl8UOZGMJaAuHO4jD+AMvJAHwT46wb6ZuGkm7VNGWxgIG4rU4dSQefJhpXJgCJ7oUkabajtNqIG6WC/Mfzgo3ecatYyZZlTMileMzebe5KDJ8urnVBuhUh3UESOu3GSmckIMKg32Eo=
Received: from BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8)
 by IA0PR10MB7352.namprd10.prod.outlook.com (2603:10b6:208:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 09:35:05 +0000
Received: from BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::7056:2e10:874:f3aa]) by BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::7056:2e10:874:f3aa%3]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 09:35:05 +0000
Message-ID: <8190d77e-5183-465e-bfc8-9c1a9690bdf0@oracle.com>
Date: Mon, 1 Sep 2025 15:04:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH net] genetlink: fix genl_bind() invoking bind() after
 -EPERM
To: Andrew Lunn <andrew@lunn.ch>
Cc: jiri@nvidia.com, stanislaw.gruszka@linux.intel.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
References: <20250831190315.1280502-1-alok.a.tiwari@oracle.com>
 <7bb4e094-fa20-42d6-89d5-c25cc0584309@lunn.ch>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <7bb4e094-fa20-42d6-89d5-c25cc0584309@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::14) To BLAPR10MB5315.namprd10.prod.outlook.com
 (2603:10b6:208:324::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5315:EE_|IA0PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d58c2e-cbd6-4ad5-f552-08dde93ad53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlV6dHZwSjhmUWFISkxxQ0VKOVcwb0pkUWZPdmRmazFSVnBkVFRWRUlNRUZx?=
 =?utf-8?B?U2FLMWZJUmtpbmxYL1pRWnU3UkNxMHlkUmxyS0JNbzJCa1pJMGlNa2I2Wlpk?=
 =?utf-8?B?aFEwbjhGK2JHdndoMTBIVXFEM3I4dUNQKzljWEgzUGlPMURxelpnSVJneXEv?=
 =?utf-8?B?MmFSOVovT2hNL0NmdWdaNjlZNWI4SUFTTXFlMGlpUXF1aVMrMW80dFk1RWYz?=
 =?utf-8?B?WVpzOXFhditxV0pteTJyUWlIV3FJRUMvTFphYk92ODFwb2R6UUxvL2gvQ3Fr?=
 =?utf-8?B?VENtS3ZndmVpM3BleU5SV3hyOEM5ZUsvQnlqQWJUMThhWU9YWjhkM1dPcmxk?=
 =?utf-8?B?NERKR1Z1WlowOUc4ZWFXb2JtbS91eFluQlg3U2lCUGFna2dzVE1adUdXbTA5?=
 =?utf-8?B?bDBVREREU1d3SGhhL2puYkVEeHJtMVZoeW1WakxidDhJeHAxa2VjY0hxVVVP?=
 =?utf-8?B?b0k5c21xbHFNMDU1RUFvSElXUk1XN3JRMmxRM2RXanNkdTlZZWpKbHZjZjZI?=
 =?utf-8?B?STJmcWh1SWpXSkp2OTM5SVh6REJTRjJtSTlzMFlHNGFyV0U2dVRCdVJKcnlt?=
 =?utf-8?B?TjVtb21wZ0JVVUpNMmNNQ0trdlZVci9PMDVOSWFNd3hQQW5wOUFWUThLakNz?=
 =?utf-8?B?YS9PZzBKMy9xWlh1SmplUUtVYjNZOGh0VWJKYnpHaXlQN29xbWRUaXE5ZjAz?=
 =?utf-8?B?dzFwd0szbzVsMkpoSmk0cFdVUVg3YlQrdmVIK0ZCRnF3RlBMYmtxYytyd2Rl?=
 =?utf-8?B?UDJ3RVlWZlZxSmhTRDBHSmZua2R0OFFCeXRoVTQ4dTlnR2ZRZ1k0R2YzN29w?=
 =?utf-8?B?a2VoUVlETnNPQkgzaHFta01sR1RFdEtOZEcrNlVBWlJaa1JwdFVBWlNVUUtF?=
 =?utf-8?B?UUgrdlk0N2RiQm1hRHhKN0czN3Z2Qlp3ZW5oVERSVnFZTWhtZTNqZGxiVEFa?=
 =?utf-8?B?NmJXOUQreWFPeWpLV0dqRnI0TFU0NzVJcEdRa2NzYXNvSWwrQ1NUMFN0cUNw?=
 =?utf-8?B?K0d6dEYzOWJ6MTB5eU5sUDluakhYdm9xbEhBazNvYmp0Z095Y1gvSmg1Y1kx?=
 =?utf-8?B?Rk9GNVk3cm5Ld25PZXBTdXpLL1JvR0tPUjZ1SFRhbUJLNnhZQzVlQ0VNTzFB?=
 =?utf-8?B?VjlrdGhKc3ZUZUE5TnZSZk9MZ1YwV0twMThYU2VIRWM1WG5wTFlwODRBQ2lS?=
 =?utf-8?B?c3MwK2ZWb2ttY0VPcjlTWGQzVnRGWHE3TUJJbEV2aVU4dklrTElLREdxTUtW?=
 =?utf-8?B?TzdPbkI1UXdxWU42WUdhcEtBYlZxNVFjSml5TU5zUlh0QVJMWHVxY25Ja3pa?=
 =?utf-8?B?SmlCNFJNQmltSEZRY2tuS0l0VWZHMHBGNE5xTUZzWDd1cDRaSHFHV1E0MzN2?=
 =?utf-8?B?RWZsbWt4Y3FrRnpDcXkxUGszK1VJN05QS0NjWkNLS3RKR09vSTIwbWFSMUl1?=
 =?utf-8?B?MTJ4bE9qZit5MW42M1E0d1JGNVBhSVR2VkZmaCtFajRoZUxiYjFpVVZ0VlFr?=
 =?utf-8?B?a0ZaKzBodHBOMGMxS09mdkJTTzFDYU1zUHBzOXRBenQ2MmQrMXpQSGUxTktT?=
 =?utf-8?B?Vk5rWWZLdHhBUWVzS1ZTRFh3ZlV6Y3RuMFRaODAvTG1FRERXT0lucXZNSzFX?=
 =?utf-8?B?U2NYUDlxU1kvc1BKczhZWG5LVHpJK0ZLbzRsUFhadC9HZmI0RTIzT0Q2ZDNH?=
 =?utf-8?B?VFF4QXN2b0pGMXRVMTFyU1pTVjBFK091Y1VKLzZRMTJZRXU5Y0xsV3FlT05G?=
 =?utf-8?B?RE9NSk5QL3hkSU5ZczBES29lNVl1K3JXc3MrMU93bkZYVGVvNzNjdzlvVE12?=
 =?utf-8?B?THFJVzVCRncreE9EbjRkVE1FQ0kreVNXdHM5ZUFQdVF4MHgwRmxrc09MZitB?=
 =?utf-8?B?bmthR3RPc1o3TytMaHRxNlQ1T3VBZ2pkc2dLd1pERWlKRDU0aTNVa2VtSFJ5?=
 =?utf-8?Q?FBzPvtGzcSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5315.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFplYUx5azlySmVXT2FGVjN6Tk56VUdINWdCZTFRVGZxUHdSbnBmcjNPbXNQ?=
 =?utf-8?B?aGFySXB2YWJvMURENC9jaC93cmpCcWdxakRhYmd3dGE3cWN4VVJEVkFkZjNj?=
 =?utf-8?B?L1lVQW1LZmRpMmFUWDJCSWgzb3d5N1dxUm51Qko3ZEZqZHY5SysvRXozNlhh?=
 =?utf-8?B?UEZyUGU2bllVSktQYlBwN2Rud0hacWxiQUx1akwvZzBvbVVJbWVDOGF5Rnd4?=
 =?utf-8?B?OUI0eFlQcXVLSkswcVpvM0VxWGoyTU1iVUdxN1piekxabWJqK0JPTkg3VjRy?=
 =?utf-8?B?cmZ2b1ZvdnA3QnVnNENINGRKMnZUbXd0RHhneDZ5dkhFeHhGSjFYUUpWY0Nn?=
 =?utf-8?B?dFlWT2JHa3ZWUnpXSEpqVXBsckxEYUFWRnZYT2FpSmJyelo3TXB0UjYzdkxn?=
 =?utf-8?B?S1c2SWQ2YVg5RFRZTlRaS2VsUDBUclp6djd5ZFhydmM4Y3RnUXBPTDk5d0J4?=
 =?utf-8?B?dTNlcjhpVTNsYy9LUnNyVFpYR1pxaTRHa2l1V3NYZUdBOGVXNUFVY1JEZ0d4?=
 =?utf-8?B?dGZ3ZHJEbldJZVhvTVo5Mm9DYVVYUkhhamJMNUp1YUNncXYvcW83dDdMMGxP?=
 =?utf-8?B?TjlWNDZNdGRmbWVpV0dEbm45MUFwc2JzOURYS25mSTFKN3VKSEhJYWFwd09G?=
 =?utf-8?B?ZGttR1lsaTFzNjZPeDRnQkUzR0h2YzJuNDBwRXRWSmFUaWw0a0x6bFZzUUFG?=
 =?utf-8?B?ZERBdWZZMnFVYlkzSmJ1K0RoUlJkZGduNFdRd2JsMFpIbzU0OVhpRmRnbEZF?=
 =?utf-8?B?NDE3L1E0T2xjb3JFU3B4dDNaRUl1YjNXRUZ1SHVLMzU2Qy9UdWEvOWxPbWxw?=
 =?utf-8?B?TG83enh3YXovMmh2S0hqQVhpWERDZlBuT0pUSUVUbWRsMWhxeWZ1K2Zncnp5?=
 =?utf-8?B?cEM4Nm5iWFdsMFZjYmR1N2NJR1BMcUp0YnNrUmtYb1o4eTU0WUlqOUhzaGJC?=
 =?utf-8?B?WEI4T3FnbXdTL3h5RmhtNzRHcjdPUVNjL1FOZW8zcTdzdHNmeFFBN1pkay9T?=
 =?utf-8?B?aGszMklXRHFJOW8vRXRzWHBQdVU3Y1k2cWczak9sdURuTG5vZERIZzNVcXpu?=
 =?utf-8?B?M2wwKzlQaFBmclFKRXlvUDZDRHYrZWFCSEJFamFYQUlSZjdrQ0pwTEFuY1kx?=
 =?utf-8?B?aEhhdEsyaHlrelZlTEdqVDczWlpCQ2tSdUs1d0tBTEhQbmlWOVhjNHg3K0Rr?=
 =?utf-8?B?MmFHUnVGQ2liSUw4WXo3cnFmK290Rnl0MDQvejdIajRabFBncHQvNWdnZEly?=
 =?utf-8?B?K3FuTnBHbHpBc0l0NlV5WVh0eGI1UG8xK0x4RTB4V2dpa1R6TUgrV1J1ejZX?=
 =?utf-8?B?ZEZ4ck9kdnFlT3ZhTFlnZCtrS0dDNmJvK2VNWmRwSm9xb0FNTUFxZk5ZaEhI?=
 =?utf-8?B?dGNtbVdYNmRKam1QSFh5RTlON0JVOWZjUWRjdWNieDViUXZFMTRoQVlYcVF1?=
 =?utf-8?B?bisyMUY4RlZIQVdRQ1YrdXpTNGVLVDN6YXlFMUhzZDh2TWgxOXBMdUpsbVcr?=
 =?utf-8?B?T2pYSFQxdzNTQWhZbzc0U0RXQ0crMEU5bXV6RmxqWVdzYWJaUFhLaEQxbmpH?=
 =?utf-8?B?djlDMUZUZ2dhSXN4MzFHcllzanVSYkt3Qy8vNnVsOHVKWmNZeEg5dzVPYVBu?=
 =?utf-8?B?a2FiS1hsa0NwSkp1b0w2NytwZHlGeDk1czNWemtOYTBjeVFGMjBuNmJWaDZ4?=
 =?utf-8?B?ZDdHL01BeUZ5Mm1pdzdHTU1hdzZmMkl0cVg4OFpDVW5Dbm9DajdOMzl5VXE0?=
 =?utf-8?B?citZWVJYZkV1TG95eHZDd2sxSkVXcXF1eGNsNjdpZTc2MWJ2eDB1Qng5ak1H?=
 =?utf-8?B?WFpZeFVEQWh0OG9iQzkyTXNab1lDR2wyRXpxWkdPcHJ2MzF4QXhhNmNMNzZM?=
 =?utf-8?B?VWY3QW0vNUt2bmxCd25uSE1qQTlhZzk1UmNoQTJTb2Vvc0czbElMRVhQeGw3?=
 =?utf-8?B?RFk5ei9HWnovaWZjMENYSnNRM0FISXI2QXg0ZW1WSEJNalNEMmxZQkw1dkd1?=
 =?utf-8?B?V294U1pqdHR5MEF4TFEwcmx2SGZJWjNhTHVwZGhQZ3pzWkljcitoNEFXWUl0?=
 =?utf-8?B?R1M4OHVTVFFNVk9GZHVDOWRjbkI4T2pFREc3WE9vSUNlY0JXUHI4U3Q1aEg1?=
 =?utf-8?B?WU5RZlY5bXcxWjZ0ZzB4NTVHTFovRFRUUjVBNkFzVXREdHU0Vkdyd0pNN1Nw?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HTCogZyj5USp38ek8ptrs0prB0oFseAGZL1INucqF6gAZ6ZoKfw7OLaDYr0drKePHRx9L+Kriel+CVr6mqLxqWqadNGGvLivGr2IBcJVF/reTWtXmbN5hTCy0mWPWMhnhe0+RvIHOE9CvbZKKJ7jQbY5NKQZ6jhoYSZE2RzkBvwtYPotGabkua0R4bAXo+rmCZcSj2gbQEasmeMAv/XjTi1X013nrEkyy1FkrumcK+HR9ROvp9HxgCPoLUO4QgbkPcC21b5ZQB2Q+6HQJWvpgHZ1gwBxn4ZEESsLUt2/DgwdLJyReaNE4RI+WEoGPwY4+QM9c4m2TvTW/yl1aRYJeoPLaUKiTrnjGIbSJImwirnn19HTh4JYrzVXzt+OwU1ZCM1uIBxKVVtmRsXnFPcPVJeotHGBzAauRJKnG92FCHaBQwHYQ7TkF+PkAgcIhiCt7RieKvg+36nRgp0qYuPYZ6950BrYbKBoZvguXDgYdPd7ejBzzGoINwNk88VEqkXrQPjqS4+ik3oye1m1rly8u2euwoFCej5MGIDU69sPDIkqVVSTqnLZYXxoCLZF/JCjlTDAuQSW+ZCKcg/Tr///Ys6mRQBc9S/KaQTmBKPz1yw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d58c2e-cbd6-4ad5-f552-08dde93ad53e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5315.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:35:05.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcaRfY8NzBTQALZ4E+j63M+5KXewkJMZWt9SrQsPKH6uqsS4JmicjYt/moHQpEeLyL+JyGzHSyQS3MK7qenBNEILvrwlPry45pjlsATl1Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010102
X-Proofpoint-ORIG-GUID: WbAU45ffl6k5aBEtt_uYLW_TZGQxrrWD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX+OyVKm4HRHy5
 xteU3DQkvm3x+ATEo+uw7uMjreZy3It5cR8wH+kkYHVdLQMCVaen92fmw6QyvE0+ULQGBsteSfR
 afrWLkJVwa+kgV0a3yEWtXm+N66j+JlYzDOWovoxxGHTHdBqk64yiyfPk826hz9WRjmPHvKYH+t
 v1ECGphdCvh1HORm7HARi8oJrs8iIPDDReqEQaJ+ZZvHm5eHf7njG5txnoVRVRHoIkdgvs4dM2U
 ZSo4W0O9wzR7GtQyxM5TTpDNrHzfbUmacNilKqWLW/W+eS7Td8MoZUOdTQuXS/SA1ovFQlh51Bk
 qbkrqSmQLUqHaSW+j0gpTw051NDsbd+v257os0COOuyfuDspQAuZN65iyWMxFz9EOA/ygOQU8Nr
 LuMvTJTLcn1ac+ye3W24DUHCz9J5Lg==
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b568d3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jIjimf2fayRygYSeZeoA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-GUID: WbAU45ffl6k5aBEtt_uYLW_TZGQxrrWD



On 9/1/2025 6:53 AM, Andrew Lunn wrote:
>> Fixes: 3de21a8990d3 ("genetlink: Add per family bind/unbind callbacks")
>> Signed-off-by: Alok Tiwari<alok.a.tiwari@oracle.com>
>> ---
>>   net/netlink/genetlink.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
>> index 104732d34543..3b51fbd068ac 100644
>> --- a/net/netlink/genetlink.c
>> +++ b/net/netlink/genetlink.c
>> @@ -1836,7 +1836,7 @@ static int genl_bind(struct net *net, int group)
>>   		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
>>   			ret = -EPERM;
>>   
>> -		if (family->bind)
>> +		if (!ret && family->bind)
>>   			family->bind(i);
> I agree, this fixes the issue you point out. But i think it would be
> more robust if after each EPERM there was a continue.
> 
> Also, i don't understand how this ret value is used. It looks like the
> bind() op could be called a number of times, and yet genl_bind()
> returns -EPERM?
> 
> Also, struct genl_family defines bind() as returning an int. It does
> not say so, but i assume the return value is 0 on success, negative
> error code on failure. Should we be throwing this return value away?
> Should genl_bind() return an error code if the bind failed?
> 
> And if genl_bind() does return an error, should it first cleanup and
> unbind any which were successful bound?
> 
> As i said, i don't know this code, so all i can do is ask questions in
> the hope somebody does know what is supposed to happen here.
> 
>         Andrew


Thanks Andrew.

I am still pretty new to netdev and trying to understand these details.
I also had a similar feeling, returning -EPERM directly looks a bit
odd without a continue and I was also wondering how the ret value is 
actually used.

I am positive other maintainers will offer their valuable
suggestions and help clarify these doubts.


Thanks,
Alok


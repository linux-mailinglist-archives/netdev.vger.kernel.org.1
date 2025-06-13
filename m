Return-Path: <netdev+bounces-197344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FD9AD82EA
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A7C3B3953
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997B255F26;
	Fri, 13 Jun 2025 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cJ5Uweh9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r2lxzCNI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD7183CA6;
	Fri, 13 Jun 2025 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749794866; cv=fail; b=BQ1ZnobcoBCAhWcjO5rNaxndF+B8ScGXfPrq9uG4CLOFnnj36zY/aDrIrzFS5SnR0dV9I/0WFgofgXIxpigpNt5uJZCTq8MZpgJQ+T6m+1Q6f3HHYVnztWc+J1iMRlEaw9fBRDqIqEdU6k2vVhOYfW9ypDdbo2EZIWnp7h90fS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749794866; c=relaxed/simple;
	bh=u2jpVSwPDLfzspSSSTMFf5guC0sE6rqojZYhOZy4E8U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R/E9vfEhlTpl8+E/1xa65FOLFhTMEHtIF5EB4mIVSVxjsU4Bbftl1wQ35N4iQtSsID/q7syq6ds1Yh2wv0OXjjEZn0ii/pNarACUl1G0cB6aZGnYENxoDozalDRZK5OYvQLtqfBW+PjxJ1zOa2lfzV328Nvs47GBwKfqyjCB26Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cJ5Uweh9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r2lxzCNI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CMBdem020056;
	Fri, 13 Jun 2025 06:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=w9CtPr5OYNXCCGBOVU5uHe6a2FxDOzHqv0I67fFZlOw=; b=
	cJ5Uweh9BMwhiXcrhnjPkyUIox51vjPdFTAnkGuyzkNPWexPHYOYPAUoCXqK29Bj
	mFwA+jsaO1TyktMDzadrNJfIT5jK8i6FqYNEKTPB5r/QNI4cq4sJy9AF+7IVQOA+
	mp4M2vnxroX6FOfS5glIFt4MOWT+JY6IRPKVCGuJTlJqp7pMiwIKyzTe3nNASf7n
	LFXedEP4OBtznilXzz2JOhno032oKPOPmbirWG8Aos91P3zkP3ck2FuHFzbkn6oM
	Z418titbR6olir6i9vQyBFkNBIFiXsH4z8Lp6o4AW+Bk8hkn9s/Dcop8ICbwgMGd
	EZzBPpWNdxwdhmXDEUsr4A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474bufax1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 06:07:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55D4EiCa016910;
	Fri, 13 Jun 2025 06:07:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvchauc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 06:07:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mB9xJ4B/NDIQsj8Ql9WKhhBsDNJ91nqSjNkbiZAsd5c5V1ThtLFuUjVMtuIDZsWTgthIhsPFON8+bJreUWHrMRa07LMiVkN1nEVv7gKbSNSseuJUd7tT0oiC6Zyhpwt2B06NqCrTYh6hZHXi9jUjG3lo3y0EIqXLEE+FbWnhJXi+7Hy7Iev3sfYzHEoyi45sRCmsCcbMnW4sD3vpYCFycWT/iiKnm6c+t41rP6O3CsAbWID0dRL8ER10YLcj7q41i7aUu0KWtk+ZjXc6DP/2MJ7+l5Oxbryx9MFnrd7zWjNOkDeZFmLB1HTuUmUNvDv2NH5mAE7j8EI5qFgzS6wXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9CtPr5OYNXCCGBOVU5uHe6a2FxDOzHqv0I67fFZlOw=;
 b=NQ7+04H2xaPm1lgxc8SPzoaMp9ZNNlKONBcnoiwHnGu2Eya4GCR4dTpVk/7AHAoYnOVVxlFBz18U30CdY/MkgvVhwd17T8eiJbXH1+neLGQtQ8U3MhGZXgDiEhtfEGf2ZXDzseVzc9ZLMPu5y64zLZS7a4qzJ9ndHJ4xja3F1gpj7RLb5W1nhfsoz3N0ZLMY25O99s2SUbgm0X3L9RPwBM/BFwP0WdHN0fmFjyR9J4CrP6KHbuEwJqYQTWgzYK6Qvfkwwlb//SSgvB+hLRMBqCSlIULAE5tWC4snF2Hh7+yxvhscEPRTVOhzSyuoNiAsykXb+v7NVC/M8xKEokZhGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9CtPr5OYNXCCGBOVU5uHe6a2FxDOzHqv0I67fFZlOw=;
 b=r2lxzCNIM+7i48Ou0B6JIWu05+tVqPyt7OvFbhHqzqATz5SdZg/G3OxCCHTZFC3ade7bgGnbKgaxNARglbTT9oIHPKqLI8fgl3fJzpROmWkZIUFel8ari2gTYi4ihcJFe4lUyN4SHHN6bM1TpZNWRlkDRX5dVkiaSr3tx8zkTvo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 06:07:29 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 06:07:29 +0000
Message-ID: <1c39a436-438d-455a-a926-860d00d8f85f@oracle.com>
Date: Fri, 13 Jun 2025 11:37:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: net: sysctl documentation cleanup
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.com,
        linux-kernel-mentees@lists.linux.dev
References: <20250612162954.55843-1-abdelrahmanfekry375@gmail.com>
 <20250612162954.55843-2-abdelrahmanfekry375@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250612162954.55843-2-abdelrahmanfekry375@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: a000e79d-d2e4-417c-aa74-08ddaa408fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3FoMTd6TU5yZStIVG1UU0FGcnVDNUk4NEpHb3NJb2N2eUlEQnVzM0plbjVI?=
 =?utf-8?B?SDFOd0YzUVBQTmJFWlFMQ0RNMGlLOHdCMWp4a3Z3eklqWW5jaXN4aXlrdXlq?=
 =?utf-8?B?NDZJQ1p2bEtlZDN2Z3A2cTVLbVB5a3BvTEFkRmJDNzJqdlBKVlEzRGQxeWRX?=
 =?utf-8?B?RU45RjJlUElucjMvMitoNDdqVnNuVk81YUpqaTRmL1k1aFRFY1FlT05hQkYx?=
 =?utf-8?B?bkhJU1JncEwyMEN1Q1lOcTRISjR2UkZnRG1xc0pGR1cwQzE5K1ZnNWpGeHBR?=
 =?utf-8?B?UzBuUTZXMmY0NWY4bEVFSjJzV2xrblFEMUcxMmVsRURTdkN0UHF4MmdzM3ND?=
 =?utf-8?B?OXNoeDVRZndHSmNHdXhxeUhTQmJzYk9XdHpGY3dtaHNldUkvbHJZb0FlZFlh?=
 =?utf-8?B?eHBZY2RpMGRvT0kwTHBOc25ONFQwQzJHdTJ0OTd6OEdETkFJWm1ZRjZVd0l5?=
 =?utf-8?B?RVduMnBTdm1seXVVN05kS2ovOStjL2c1RVVkMWFTQnREbEQ1eWlydkZ0c2FH?=
 =?utf-8?B?bGV4bzBpYXFwTm5ncnBxazF5cnFHVFlSK0Y2QzNjZlNQaWpDVnFKUDBzTURo?=
 =?utf-8?B?Z2t2dzB6WFhsTXNIZ0wwcUVaaTltck1VUG1xQTIrQzZtcDJ0SHptWVc2aER0?=
 =?utf-8?B?bkxsYUcvT3V3ZXN5bnBYRHluUGczOTBBYnFlYkdLdHVTNHNtb3hmRnVabGhj?=
 =?utf-8?B?WVMrNDRUTjV4VXlmdXE2R0t2MFFwdWZubWF4cUp5bkVJTE5iWDRVVlJyemJI?=
 =?utf-8?B?WkdmUTNxYTMvK29mYzlDb1pVVXY1Wkd3SW4wczBqSEZzTkd4QVorRWF1a2ha?=
 =?utf-8?B?N2hCMjNBQWtQcUdjWEU5b2VNMEVsdWEwQ21SU0RaZ01raDJ4K1VmdGs4L2Zq?=
 =?utf-8?B?blVSenZyOTRoK0Zrc3U1SWl4RDEzdGJsNFQ4OVZlUG9jZlBHL2xVNEdUN0Fj?=
 =?utf-8?B?eGxBQ1dBbEFMM1g4bHBMR1RsM3NWbHdwdWN5WVFxSDNUa1ZEL0dOVzFpNU5Y?=
 =?utf-8?B?aU9BbS9mNDRsT0FudGNJb3ZxTUFpWVQvZVBnOW9mZGhxdUl5bzJEVCtpWUp0?=
 =?utf-8?B?Mm5EVzVQaXJjdnExQS9sQ3JTVEtVczU2a25WRlBmY3dkK3ZjMm9DMFBrakxM?=
 =?utf-8?B?Rmlvd0pvdHVHMEdab0NrMjluNzY0dFdMZm4zRmg2aWJHMXV4Rm5qQnpud2J2?=
 =?utf-8?B?WVhUbHZlYWRSTFA2a2RMaCtSbW5XK01ReHRiOElKcElqTzI5VktxaE5GUjJT?=
 =?utf-8?B?ZVhCTVNpOEUvY1FNSGozOEFUUm5FdWlac1E4TzN2RlhxdjMzM2V1MmlxNDly?=
 =?utf-8?B?R1JEdkExZzBQRytiR3M5Y3YwT3lpS1BJQmozaFIrZWIzQ0IrTCt0Zy9NczZY?=
 =?utf-8?B?d2d6dHlGY0RxTmlXQ2V1RHNOWUlhM285dlM1clVsVFQ3TzAwODdrQlBUNUNN?=
 =?utf-8?B?Y0pVVml4SzRWSks5cEt4b200aGtpcHF0MXp0WnkwRDVzdWRKMWZZbzBuWXh3?=
 =?utf-8?B?MTJhSndIUExJT2x5ejcreCtOSFd5T3daOVJQcklaek5yN0dvTHJIVlJxZERq?=
 =?utf-8?B?TWpxS1JTV3BLZUxqTTJiR1Z4d0NwQUJQRFZPT0p3SGdENTRVTms1YUsvR2dK?=
 =?utf-8?B?QjJpa2ZsZnYzTUhYUjdHK1A2WnpBNWkvcWdmek9lemEvOG9HNDRiM2pwVzlP?=
 =?utf-8?B?Y3dGTFpZWjFKaGltUVl2MnV5RllBbG56OW80bDNxOC9FNkExSHcxOEx1TlNa?=
 =?utf-8?B?WGY2L1ZRUFFUbFp3ODBXWXo4VDBKdm40NzZGYTBqNkdpT3B6S1pPMTlRL1Rv?=
 =?utf-8?B?NFFHSjZMRXQxbGZ3aTRvcnMwWmo3ZEVEZEN0SUNhOHRvckc2a1laVnlzRzVD?=
 =?utf-8?B?ZnBZZnRlOXVHWW0zeklOUnBKQWROOWFsWDJqcDZjOWxWY1JwcHg0OW5WVDRs?=
 =?utf-8?Q?Ge/rANtQspo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUhldXhOUkdqb1Z6NnBVcHJqM0I2ZGFybWZIdUE1QlQxSXVCMDlnaXRwK2w1?=
 =?utf-8?B?ZUlqOFhvWVpBS09vbitmTFBYVHNUTDh1ZWN2Zm53OUV4Z0ErS1RpNmVrUDFk?=
 =?utf-8?B?cFNONC92Kzh2M1Y3bUloTTFrT3JyQThLNEJoemRMM3V2bUprSlVIc0JGSTlw?=
 =?utf-8?B?Q2pzQ1kveU5tWGZiQmdzdUJDRFZ4TEFyMDFvU3lSTFRhZi9mY28yVlNDMGI3?=
 =?utf-8?B?ZDNQSDJ5OFpMYmdIU0crQjl6YS83cHhyNXhRQ0FZV3E0ZTArYUlaK1hvNnIw?=
 =?utf-8?B?RlBvY2dwZGVRS1VHWmxxSlh1NzlCMXFuVDNuNDlZYlNuMG4ybUVCNG4vVHpI?=
 =?utf-8?B?TllIbXNZaU13WnpwNDF4cG5YUzU2RVQ4VXlESXBIMXVFenZmeFQwUkpZRlVX?=
 =?utf-8?B?cjZrUENUdkZwMVNSdlJKZEQ1K3IvRE9CQW8yMkJrTXRtaVB2YzhMV1FYZ2or?=
 =?utf-8?B?cXJzcktPWnI5OTJOWXNYaXh0QTFsdUZUakNBR1g2ZWRrdGtQUEsrdDc4Zys5?=
 =?utf-8?B?aWZObXk0RjZQazhuMTJHRndRUEFjbHhjMWEyV3Ezdm5QNEhmVVdPYmlYZGwx?=
 =?utf-8?B?SWhFZnFoSnN2M3RDek1lK2dLUkUvN2g5OVh5Nm5pVDBzeVR3Y01tRm9TWGUy?=
 =?utf-8?B?dDZTNkZEa0dOYSt1ekFEUDUzaThZTUVwZVNtWTl1SEM4VG5FWTliTXFiNFh4?=
 =?utf-8?B?SS9CdjNmc3ZSQWxlY2lHQ1RORm84aWtLVFVGSDBMd1ZQb0JpSkJnUWNwT29D?=
 =?utf-8?B?UUVGMks0WVlLeHlvb2FGWmNWcG9xcUV5cFFPa1RsRHdDTlFkU0N2QW1DWTBP?=
 =?utf-8?B?MXZadTdHS0ZpaDZjbVRjZm9iUzljcE16ak8xMFBlOUwrREM5TlhNbUliOFc5?=
 =?utf-8?B?TFdHNC9vOFowSE1YV3gxKzRlbDBaSWVmWjEvTVVkcjNpRGZXalVNd3gvc3kz?=
 =?utf-8?B?SFZZaVF5Yk15cU5IMjhGSzc1UW90MzdTTDJvVGdvUTlrZW9mTHlDZHphSzZr?=
 =?utf-8?B?Z2kzbnYwSnNRVmFkc2VQTnZheXNJbGpUUzBsbVNQaThOWktoK1RrbE9ZV0ZI?=
 =?utf-8?B?SjRmTmNSc05oME5ZYi9JYWowclNFN0JRRWFhQjJUWXpNVVgvNVZId3JRUHpH?=
 =?utf-8?B?OUdYNnhiZmRVS2g0SzA5YjYyY2NlZ0RYajBYVFpDLy9DTGlJTHU5NEVvTGJC?=
 =?utf-8?B?cmpyK3pwb0dUaDAzSm1aT0I5QUFFV1NlYTBTazVuc2xkMWpvdER2YTIwakFt?=
 =?utf-8?B?ajFrS3k1elNwRFllL3dZTC9EREluZjAzYnBmUmkwTUNjU0hoTFJGdUE4RGNx?=
 =?utf-8?B?UnkvTjVhc3l2QS9HM0tRRHNYVS9FdSsrYmJxMVRSbW9MYndtOEx6R2tJUWVy?=
 =?utf-8?B?V1A0UU11Wmp2RVJ5RGUxTDZscURZdU9WVHBFREdwVFVqZSt2TU1TOEdzUW04?=
 =?utf-8?B?V2dRU0FndHpIR0tWMkpPWExTVkJ1VDV0ZFpoOXVUNVFGbHg4d2xlR0xETHRy?=
 =?utf-8?B?amlBL0dhZCtKeTloa21zSW8xVnJvVFVxU2RjRnA2ajRrUk5xd0ZOVkVhK3Fn?=
 =?utf-8?B?OHc5TFZpRWE0RE9jaERUeUMxeVZHRDhTYi9jNHltbkoyNE9ZVFkxTkJ6V2pp?=
 =?utf-8?B?Rm55TmN5cmVxR2g2UmtQcFdWcldzTXorbUlaVjRRQ3AwYUI3T09YTWVNYSt6?=
 =?utf-8?B?M01EM0VVNjUxaXYxdUY4dmVvcDZoYld4NzJEODI0VmE0c1lrU3BJVXZzYy9G?=
 =?utf-8?B?ZzRwbjA5RS9tNERuVkg5THlNNkdkcWdOYS9oUHBwTUV5VkFkRjZWbUxpVStU?=
 =?utf-8?B?OG4zTDBocytkVVFwRXZYVURjOEVXVDJtczZtZTRrbWdWTGp2RVlDSjB0eTVS?=
 =?utf-8?B?ckwvTDNGbm5ubkNqdFQwUFZocHI5eW0rbEtpZGxhbndMWm5PSWdlbjJ0UXda?=
 =?utf-8?B?eFkxNG1qZ2JMZXRmdGhwNUxQYTBYZEl3dlVyR04rbjZwTGFUZDM2WTZpVW1r?=
 =?utf-8?B?bi8rRHFmZ3owRDh0ZFd0NzgxNXB6d1JsY1BYZ1hiNFFDaWZ4MEc0VWVDV2oz?=
 =?utf-8?B?MVVUOWNqTWJEbjIybHNCV3hWMWJLQ1ZIMFVTclpyaVY2b1ZZdVVWRDN6djJi?=
 =?utf-8?B?NjFTbklDRHVVdW42UlhQdDBoNTJKL2xIaUk5M1gycEI2bkxMQWZiR3JvM0dQ?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7Gne2s5xifPKobs7v/NSTwPvyPjROCoSRBFUrLlEesMpMBHHXmGh8/a6ZJx2wGXrSimsDcGZHa2/f2AvHcqijEKGfB030bTLkdJ7mVSVbTsED7NqAAm5nbO3Utyg+2dplnOP6hOTpQadNOMwPxee6KROjPXu46YhnuXi1pJdwdM/zJSbpVQbOWbg9DqqLh+W78uJcE5mUrwU2VQhRquEkc6a2JUceLNHEO7w0aIrUpDiiqWfKpA6Z8h1QAjFe/1n5kOJD7Igf8iN5Db1k1piX+3q1/JsmZbvAffX6+UZw6TUt5S+zfnf85zsp9osS+wlCTAGrpPJYgD4mS2V/S8rZL0SFFQOtxtFHsfDp+2Lr8bTABc8haho+uWOSpAafTWH0adbV3sBG1IwNrBBK/+QtkFa6Q8+QbtH3QhQDEooZRui+EkTPbpRGn4jI+2J7DgTcHlBxeghpq2FVkmYUD6I1ilgXKm6hJCAlhOGqTRrhHUW+7SMEdMMK5zTbV0rjn/5SeHUSgofYY7/F3uipviz44aeURctCczPkJ7czRbwyFm+Z7oLag6AcbNYxI6Hd/JsTVzn2TlVqhzFwPC51JqRXNDgid77ZdacqGUqbhPD0C8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a000e79d-d2e4-417c-aa74-08ddaa408fdd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 06:07:29.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aF2sFLG8LKbuTN6KmDpFwOkCj9Xk3rR8FpI+0bIprcQyaxj/BMh0MIkaKPkzr5Fg7cl4K1XoR0xnoj8gcJgoWgFJJaSslVTNPjo3XaA5hs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130044
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=684bc024 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=n9yd4Lan3pRFpMIqzmcA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: WIeDxWq3a2KNqEHcfjruKndCEHl8-cqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA0MyBTYWx0ZWRfXwGlgtuBYjSFW U7q0fV6DLMjUcAdZQB11tlc5tvyiMwl5qiGXXgwL3Ai2razz42AAdav6odhhRgKYV03YSR5robJ ZS5QutCXJvmqg+X/AvRFLQN4srjy8hnLfIKbV/H5UpIYGLT2U/4YCAODdBPexE7mkkVL94bDivP
 6azCQCQp0trP143O6CI/167THQtclJ63uzmGTsygCnpf9UuEkX6lFImry2AkFb4sxy2JiBCaXlu A6PIUjFCLn2yOJ8qzxGcgBSn00IKIBywPw45uK0I2kSGyhk9+kz9Tp+WncWxQnZrBRo5GfnQmU7 28SADznmp8AC5Jv6AOSaa+Ytg3ZeNPoT4vjRr4xWJY39z/WVmA1zVKuEtXA27ULpL1gPisTv1T1
 ml5YMgtBdrlJnaJm26YPkQPLkoY9vMfO8Z9G7Y3p2bAOn8pN5d/n/lxVzcmFXW7gRPkiX4IG
X-Proofpoint-ORIG-GUID: WIeDxWq3a2KNqEHcfjruKndCEHl8-cqG



On 12-06-2025 21:59, Abdelrahman Fekry wrote:
> I noticed that some boolean parameters have missing default values
> (enabled/disabled) in the documentation so i checked the initialization
> functions to get their default values, also there was some inconsistency
> in the representation. During the process , i stumbled upon a typo in
> cipso_rbm_struct_valid instead of cipso_rbm_struct_valid.
> 
> - Fixed typo in cipso_rbm_struct_valid
> - Added missing default value declarations
> - Standardized boolean representation (0/1 with enabled/disabled)
> 
> Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> ---
>   Documentation/networking/ip-sysctl.rst | 37 +++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 0f1251cce314..f7ff8c53f412 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -75,7 +75,7 @@ fwmark_reflect - BOOLEAN
>   	If unset, these packets have a fwmark of zero. If set, they have the
>   	fwmark of the packet they are replying to.
>   
> -	Default: 0
> +	Default: 0 (disabled)
>   
>   fib_multipath_use_neigh - BOOLEAN
>   	Use status of existing neighbor entry when determining nexthop for
> @@ -368,7 +368,7 @@ tcp_autocorking - BOOLEAN
>   	queue. Applications can still use TCP_CORK for optimal behavior
>   	when they know how/when to uncork their sockets.
>   
> -	Default : 1
> +	Default : 1 (enabled)

for consistency
remove extra space before colon
Default: 1 (enabled)

>   
>   tcp_available_congestion_control - STRING
>   	Shows the available congestion control choices that are registered.
> @@ -407,6 +407,12 @@ tcp_congestion_control - STRING
>   
>   tcp_dsack - BOOLEAN
>   	Allows TCP to send "duplicate" SACKs.
> +	Possible values:
> +		- 0 disabled
> +		- 1 enabled
> +
> +	Default: 1 (enabled)
>   
>   tcp_early_retrans - INTEGER
>   	Tail loss probe (TLP) converts RTOs occurring due to tail
> @@ -623,6 +629,8 @@ tcp_no_metrics_save - BOOLEAN
>   	increases overall performance, but may sometimes cause performance
>   	degradation.  If set, TCP will not cache metrics on closing
>   	connections.
> +
> +	Default: 0 (disabled)
>   
>   tcp_no_ssthresh_metrics_save - BOOLEAN
>   	Controls whether TCP saves ssthresh metrics in the route cache.
> @@ -684,6 +692,8 @@ tcp_retrans_collapse - BOOLEAN
>   	Bug-to-bug compatibility with some broken printers.
>   	On retransmit try to send bigger packets to work around bugs in
>   	certain TCP stacks.
> +
> +	Default: 1 (enabled)
>   
>   tcp_retries1 - INTEGER
>   	This value influences the time, after which TCP decides, that
> @@ -739,6 +749,8 @@ tcp_rmem - vector of 3 INTEGERs: min, default, max
>   
>   tcp_sack - BOOLEAN
>   	Enable select acknowledgments (SACKS).
> +
> +	Default: 1 (enabled)
>   
>   tcp_comp_sack_delay_ns - LONG INTEGER
>   	TCP tries to reduce number of SACK sent, using a timer
> @@ -766,7 +778,7 @@ tcp_backlog_ack_defer - BOOLEAN
>   	one ACK for the whole queue. This helps to avoid potential
>   	long latencies at end of a TCP socket syscall.
>   
> -	Default : true
> +	Default : 1 (enabled)

Default: 1 (enabled)

>   
>   tcp_slow_start_after_idle - BOOLEAN
>   	If set, provide RFC2861 behavior and time out the congestion
> @@ -781,7 +793,7 @@ tcp_stdurg - BOOLEAN
>   	Most hosts use the older BSD interpretation, so if you turn this on
>   	Linux might not communicate correctly with them.


Thanks,
Alok



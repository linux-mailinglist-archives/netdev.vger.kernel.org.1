Return-Path: <netdev+bounces-159895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA16A17553
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1653D1889BB1
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 00:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A13DDAD;
	Tue, 21 Jan 2025 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ix3Y0NWg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XUAQvZsL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1C1BC2A;
	Tue, 21 Jan 2025 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737420823; cv=fail; b=pJysPyuUoAGwMfl1KeWocehrk1ScreD4D+1M8r8yTpekURnoEVEQQ32EGFhy4Gy5D1SqrgfEIq+zg0Xk3ld5a6Q1/6HyjyGrHw8IJOrcK6IMvptap0IzCaTvst/nC98iJYV7ODgKojdhYXH0MrVZFLdVQ8g03KGNuYeInQACPs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737420823; c=relaxed/simple;
	bh=Cy3aca9OgerXaonWTupUvUo42/Xb3CKvVA3qUDxcy3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sEB+VXBJw5h4d7ma6sDANa1u/6REUDcWI7O1drL9Q3jU0V6SN3hXPIRelvTIOvGQBpk6xjU4y7oOcvh3C63W4Q7KVSmVq90DN2zFYVaszDaIwxOpa8rXsKqtFSpY347+wwJOiyoum0Rrxymz8dnp5L+lQtZoayh1rH1LluriF8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ix3Y0NWg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XUAQvZsL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KGMvDg024921;
	Tue, 21 Jan 2025 00:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hTpZ6UtCj9LEAUXHq8oChNwcQZxo8mdXes1uwLCsGF8=; b=
	Ix3Y0NWgQ+0YzM4kRrBPMUfq+zrlHtZ9A4hRfvzQNDwKhXujzx98ORFd76/ebBoa
	Oz+hJVUyiu4ZaGmf6QzoxFJS2Ls7achI182T0UDx21i8+Mutz1AHh/ek+OKWmKeY
	BW6Ahk+i4JWP1kJKPGSgg1LFSf0SBQL0KMN6NgMxjlXcuy6qUGvVWOKwWG8ulgWk
	ozHIfBsPUGa5JwgiS6bgCWU3VDQjKAwUoFzAKPYvb7924dwNWxCIJMUtdrzGjWn/
	7hvjECTc3S/K48EQSyjDTyKGPKkr3Iyb+thpMRxf2pyvjL53bd/sXGwi6Vulxonv
	/aGI8lJwElQaxIsy/CcApw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nscbnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 00:53:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50KNtSUd038242;
	Tue, 21 Jan 2025 00:53:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44919ycdu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 00:53:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wasa0h+sdn99RPPaMRbyh1lUVBXimCSCobW0wvZ4zJpM0cv+XLNJAO2oSuoMkdXKea7O5SkDemr3GhNTlxueTmidVRr/socuDO9jMal/idKGpzW6s2a9tSJ07tAUaOBIYnPwFmhg7Dzs3rRcpkinW8+ZaySYUq/6smu0pRVbkkTDC44IJrefpU0fUiaB3kE9BAXz8pXPPXMWM4fO1ab/wNvdoMNWkpj2YLa/IDA4+nZlrqJTR7P5T4SL8GT0Ycg2bIzWPBi1yxLK+n4D8yZjLFqrFIndEaop7cWYpvCzWT+RkSnZk10XNlUe03bTkv9lguSsHzbrp/Cw7hjTuyrP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTpZ6UtCj9LEAUXHq8oChNwcQZxo8mdXes1uwLCsGF8=;
 b=uTOOzXzx+AGX9i6ESzXueRkXET7kOjPsQtKjRCqPwFxJpl2MS0YqNbqBGEnSQWgaDmLdOUrR6yc2CD6A5SjRDeFMajGGVnJXHEiswcwZYs7xlSxnWKRJVEGd35/9f00Eg6XhTdJp7od+h5P8xue6qbSWJJU+j0cxIqCS3MFZ+xKJ5pouhOwUxjsx2kFqG8ssUIjaKSea3sjkZF0O5+wuxBqEeljogcLb6rumJN5y91/D8rlGJ9rvdYBE/bWwfYH+TfECPp6Y3Is22S/n9v3qYJL8ECAL4XomqkN9dyp2ojVx234sTjsrhxgyXe4tdBMvblwopfggtXrBFpg0LGMW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTpZ6UtCj9LEAUXHq8oChNwcQZxo8mdXes1uwLCsGF8=;
 b=XUAQvZsLIltY416ONyh5swHayIqH6qVTqBQjJczvAPzQQYu9fK0cGY78NsGZiwpLXpNl5zQKT1EyWRBNjTfYiOOgI+WQJnczPdlBNN4Kg1C6OG+pMK8W3ZR3xTaNj3cK+x8M18XfKFKqyvJoxXXiR9C/Ros9vXoB8lXsoMjNmkI=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by CH0PR10MB4859.namprd10.prod.outlook.com (2603:10b6:610:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 00:53:26 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 00:53:26 +0000
Message-ID: <8abc7eed-028e-4fe3-a319-e0936c6bf9e7@oracle.com>
Date: Tue, 21 Jan 2025 06:23:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mvneta: fix locking in mvneta_cpu_online()
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Francois Romieu <romieu@fr.zoreil.com>,
        Kuniyuki Iwashima
 <kuniyu@amazon.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20250121005002.3938236-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250121005002.3938236-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:4:7c::13) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|CH0PR10MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8bd079-16ea-40a2-4d4e-08dd39b60389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T00xUHgxTlh3Njl5R3ptL2RMQVFHWXNzdnJmY2ZWZFNuYitOTVU4dk1nbnI1?=
 =?utf-8?B?NUJwb1luQWdkQW1ndUxZdjhnT3FWRVVZRWxYRFJWVWR4Y2IxSVBtTStadjVv?=
 =?utf-8?B?L2tWcjZZVWZTcHZrWUphM3h0YXdSbDNRaFFnWG94QTNQVjRxazBVbnBqcDg1?=
 =?utf-8?B?bGdyU3FHSWNaN3BSSlQrSkkweXJOSjZyd0xCVmw3Z0FGQnA1US9QeVByZlBC?=
 =?utf-8?B?ZmZLdEtmVTdjY0JvODB1RVNTNlVxMkU2NTNDeVdHbHUzZ1dPT2pYSU00TDdt?=
 =?utf-8?B?bkx6NWtQbXRYbEo1R0xBYUZFaE9lZHRSb3R0NmR0aWxiOWllMXIzM1Fubzdp?=
 =?utf-8?B?SHNGQjM2ei9GODJIMmlRblQxN2N5d1BEaGU0d05NSTNwL0ppTEVKNzNqcGo2?=
 =?utf-8?B?ekNhZG95R2JPVGZNdS9qMFJaSkRtOVAxcys1anBhOVNXeUdSVDlCTzRWYS80?=
 =?utf-8?B?QlZwekxhM1FBK3E0OUpsbWQyMkxRaVp5aFJTbWJVTmpMeVlEN1cwaTA3alBZ?=
 =?utf-8?B?WXl1cEFwY1RPcUlKTTFkM3RGRTZ6OTczS0xEOERtNVZSSHZTdU52elRZMWY0?=
 =?utf-8?B?OFFleXYxWVZ2TWpTeWZWaTR6ZWxtMnMzcVhVU2x2bmJFMXZmSERaU3RCTC94?=
 =?utf-8?B?SmxKSFNTMWNUR08vR0FQUm5zTU9XRUVweUY2eWJSM0NkZWVpUEpGQm5qUzRk?=
 =?utf-8?B?QWRpSUJyOEFYUTFFaUtHN2ppTjQyVU5DaGNjSmVJdUtuNUlNeThFc2EyUXVk?=
 =?utf-8?B?cG9HK3RYR0o4ZUdsOFFhd0psRkpZVVI5V2dBK1JRdFZFMmk5Yk5vc3Exdzky?=
 =?utf-8?B?NEJtcHpXREwrenBIVFRCejhhTlhoTzZxbEsyeUNjVjlseXp3MklCK25xQktX?=
 =?utf-8?B?NDQ5V2h6anJXSHNPV2FqWWlrM3RiOXZaKzNNUVNaU2RwdFg4Rk9ZWkdGeW95?=
 =?utf-8?B?TkF1K2M3dzlnUG1hSWRIOGRyRHdMN2R2UDR5cmpUZEJqcHk3ODNFOE5lbUJS?=
 =?utf-8?B?V2F1cGp4UUpRQWVRU2UwbHhPc1UzMEFCWTFzd21XUEwyZ3Jac1RtRFdYK1o5?=
 =?utf-8?B?anJRR1cwTzZJWjdkVXJycVEyQjBIOUxhWkVyNkViT0xNVDJSeURWRTl4UGUy?=
 =?utf-8?B?cWtqdzY5ZndEUmdpbmFFNkhpR25wajZSYzFKTzBNQmtselVNRWVMSlNwNSt5?=
 =?utf-8?B?WFo1UmtnZ09iQUI3bGt2a0tWQ2JZTXl4Mk5jQjZpL1FEcTNiTStLTHJxZFZB?=
 =?utf-8?B?Vk5DRlFiVGd2Q0lVZGhlUHZxV2pKQUpsZWRaUjlTNHF4amRsRXZqdjQyZ01h?=
 =?utf-8?B?Ny9vRFBHTVlleGY1bzJoa055Z3YvcGEvb0ljRkdMVS9JYUs0Q1NwYnZQdXlr?=
 =?utf-8?B?UEhzckZONDVmcm9TUjBlOTY5N21lbDgxcFdESGNYa2cwdDNYS3R3WHgxZnBQ?=
 =?utf-8?B?QndZM3VVdXU1U2JOSWl0dW01WWtaSm40VXdGY2xqL1ZoWSsxSFJMWnhWVEls?=
 =?utf-8?B?bGhLUUNYRnFMcGVxWVEyYm1hV0psUGhnT05GMmIyWmp5eEU0VkoyOENoNkp2?=
 =?utf-8?B?VGtQTW40UmZWUTZPZ2ZSU0FzcXYycnJTeDVPTmkrbnFZVGFVSHRUcXJQMmVV?=
 =?utf-8?B?NTdRZ2dKcS9UYjBsQ0NqbFJVOHdVRzVCUHU2UDNaM2k3dTQzOEsyb3cxWEww?=
 =?utf-8?B?ZVN5SXFkOUdncEl3WW1FNmt1S2s5VXpwWU54VGlDK0E4THJwRWtzS09pTHZp?=
 =?utf-8?B?MUdLVXRVT0IwaUZZMW5Mc3dvZC9HY3V3akZ3dGtDRjdpRUVpdTlJT1p6Sm9L?=
 =?utf-8?B?WU94ODJxdUVYSjhtT2lMQjFBL3o4U09zWUN3UWdZdXBvMzdkakN2d3hOWENT?=
 =?utf-8?B?K3I0MzU3OTRuNmdLNDJyVTltdE41Zll4M2xmVnJsR2pvUHE5cmJ1SUZ4MWVs?=
 =?utf-8?Q?/XLYsb1P44Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1FtcVlEWUs3d2tLUGdvWWJXYWV6UUhVclBTODREVHYyRVVKVnFoNW5XRnhS?=
 =?utf-8?B?VndtZ1Vvc05KWmpiKzgzZndFL1hZdnVyKzBpOEc2ZXdHR2JianMxbkYzQ25r?=
 =?utf-8?B?VU8yYi9MMmExOWNQRURlZ3NTc05UZkRLeG5NNjkxc3ZsWC9uM0hTR3NTdFVj?=
 =?utf-8?B?WCtDODU1emRGcUsxbkJkVWtiNGZBQ3BmUnBZRjloNWFkeDdUbHhNWVlsOW00?=
 =?utf-8?B?NUhrYWM1RHZUMkhHclk0VWFsdDJleS9TeXBqSWk1VGFmSEpxM3RqSWRnWTFU?=
 =?utf-8?B?dERiMUdxYS9xQ0ppL2RjTGZESlRya09ocEtySUVZa00zOG9NNms4eC9XRzh1?=
 =?utf-8?B?aDExcXduRmN3SnhCK3NZUEZnaFdJVjFwZm0vT3ltOVhkOHIxaFZPcDdVeGJU?=
 =?utf-8?B?cVE2aDAvb0tBTStIUjJWSWVqRDJTNVNtZGNqQnl4cHlzTUp2MVRsRlY4Nmp4?=
 =?utf-8?B?ZGw3U01vZTF4aUJpZ0ZXdElMQ0lRdmM1SHAvNTF4WGdhKzN0MUNRWnZFaVNN?=
 =?utf-8?B?RllZRDZHNGFPN1gwNWhtS1Z1U3RZQ0k1dDBleVVwSnlMUDNXN1dVTjlJY1d3?=
 =?utf-8?B?YkkwMjA0ck4yYzlmOEllUWVwZXVkd3d1VU5iSXRxMXBLdW9ycGR3UE1rVFhZ?=
 =?utf-8?B?SHVZUE5PZkxNcjZ5Sm1ZK3Y4U2dHdUdNcWJPZzBCdGN1elJJb1dOZXl0aGhB?=
 =?utf-8?B?UlhjeHZsbzBPNkNyMS83LzkySEk4a3FIbE01UWlsS2E3UlVXWnJUVnppRUtW?=
 =?utf-8?B?bC9qQVJDeVhiVElnRllSdlhUSUlpVHd6TDBHR3pnR204bDI0VUtVL1FRMEZH?=
 =?utf-8?B?Z0dYQjkrSytpMWZJbU9OdDc5T0U0Q1R6bnR2b1JPaExVN2RlRUJtMnRGOG84?=
 =?utf-8?B?OUJDYTVrVHQ2SEEvZkdaWmIrTmRySnJ1ZVZkUnhCMEZEa1d4Q3hhdGtDOSsr?=
 =?utf-8?B?a2RHaklvRHNuMVRBbWNINWxxaXNRamR4T0xudUhydEZQaUFLM0lkR3JvUG5q?=
 =?utf-8?B?TkMxSkZUWWRyY1BrdmhhN1hhUWUwcHVRZnF6d3V1ZzZJOWNuYmhnM2p0cG5z?=
 =?utf-8?B?K3JmcFNnVHhyZmNMOHJTbjBMdHk1eW1YdllXNy9XeXNLOVdIa3BOSUpDbElL?=
 =?utf-8?B?NjdjVWxJRUlNeExQRVZEMGpHS3ZSUkJTeTA5blA5SXFsYTdKOTVnRWYyVzho?=
 =?utf-8?B?SFpRMmE4ZFdyNzlPdlc1N3B1YW9SNExqTHhERmNsaWl6QVNHUnRISmhpTmtW?=
 =?utf-8?B?NzhaQjYvOE12aDJnd2J6a1FGOEc2WFNiUmFUVEJydVVkdGt0VUxLeHJFWkE3?=
 =?utf-8?B?VW1kSG9oTVpkeS96K0QvNUpucXl4MVM3YmIxQlJyZzNtUGRxRVFqT3B5bWds?=
 =?utf-8?B?VVJXYnNHTU1VemUrTTF0ajB6MXB1czdVVjJmeWRuUlNQYkhoVHBVYis4a0RL?=
 =?utf-8?B?WW1SNjR1Uk45OVJvS1RBU3dxSVpQUS8rYVQ5bTh2WkZ4bitrbm5zTmRGTWJ2?=
 =?utf-8?B?VVFkQTM4STUxRjQ3c05OSGZDMkxHOENaeWM4ZTBvUXJoeUlVcUhxbDNNUGE1?=
 =?utf-8?B?V05UMFpkdTJtWmRZcmtDZEFQZ014RTNCdnBKNUFnT2loL3lXaWdjQ0V0bVlr?=
 =?utf-8?B?Z2dmclJLR2x5SnlZRkZUVWNSb2hONUhNVndUME4xNC9HeUJYSk5WdTNNMUVt?=
 =?utf-8?B?SEd2Q1YwSzBld21PVFdJV2JGVk02OEdJbitkTDVsSzZQVU9PTzVTL2pwdWlu?=
 =?utf-8?B?M2NubWUway9YS2NUYm45aWxxQWZRMFI1NU9DMEdKaVB1RzN6YVRiaUVlRGkr?=
 =?utf-8?B?RWk0UFd0RGNtOW80VWozRE5NNDQ3b29oem02TEVzYzBMMG9aamFCQUJWNFN0?=
 =?utf-8?B?blpWM08wSzh5RS9NMEUvQkVYYmlUQXNwNlYvYnZNeGpvcXpMaXVrUThYZUhG?=
 =?utf-8?B?bjMrMW1VdmYyaXZyTlM1RXBnK2VSendkRXdldCtkMDJKZXpPZ2FoSGJmbzk3?=
 =?utf-8?B?YmRtaEZVeHpmWXRUNmFwakVVVThRQUdZa2VKQnVNVzFFVGFhZFJNSzArRGs3?=
 =?utf-8?B?QXpybWtvbzhMOVZCUENRN09oVFh0Q3NyNk1HYU5vdHRVTDViN1BjQXNwczda?=
 =?utf-8?B?VG5YL20wM0p2Z1hMdlA2aEF5d1FUWGRPV0hQa3ZrMG5NS0NLVDRDajl5clFz?=
 =?utf-8?Q?Mh/mCSxdYyGIQZ+6AWKkGFQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PW5zKq9hnXc1QMveSRDwd3lxqyTbpwwTL5wl4OziVpWtg3v8MKEhKZKGS3/fgODRJl2tT4dUQfEbOQFr4yIfBzUK0B6yIsQsY8VJOJ7o5UHUXP0VHRK4z+NrQvfq4HbirEi3YgTSTEL33pyru9l1Pj2JOnEGXlOOh4XqoI8bGKo0vZ1j+FaL8X1phfN/zCa9uqQtwJCBvsL9NEoL4wBfbDBFoJlUXrQw6u0LP222meit/NIXSxdXDdPYD0/BOCPycn0tOdcrXAWKNUqinUAkSYu7dejZzpGaWEuTKwQlpvWDJaptaIcllf4MnX9ZmFqast52WtysMnXBhJ/5zQyRIh0xNcr5vFFDRZ4HdwxVKdd2hjzb9AyCVEXQiMIj6UQUG54P+RtNeIYLLiFfFVp7E+CBfH4yrba9u2AUQi4svU3hPIPEeSjtqfJRAYahcg2yH1p+wZATamNRxHBW8MPp9I2SE0emSibaqEHjjMP/cJMHXbxwW1UQegtJkVMz683PXfKpxu7worQmfaGzFuaO17OZwFoyfB388skmRu5qCqImzEygr2Z1pOIO9ea4WvqcufMrKCx6Dmp1qDwOdXX/ZVZqTUMRWlbtXi+sM7xdCDA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8bd079-16ea-40a2-4d4e-08dd39b60389
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 00:53:26.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3WcaPutWS8VdoH/x9la4OzHXjkd2UtmRyRUP4XRlUtzL+pq65gByIeROJvbwS5rNogbc13PEu4EIxfb+0/ioH30oZrX+wC/DXRUz2Wsi0PI6B/iHkm9VbZdzXnqJJOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_07,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501210004
X-Proofpoint-GUID: uQtkASb4vnuXyjcJ2vPdAELCPE8MPHHP
X-Proofpoint-ORIG-GUID: uQtkASb4vnuXyjcJ2vPdAELCPE8MPHHP

Hi,

On 21/01/25 06:20, Harshit Mogalapalli wrote:
> When port is stopped, unlock before returning
> 
Missed adding a period at the end of sentence. Should I send a V2 ?

Thanks,
Harshit
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis, only compile tested
> ---
>   drivers/net/ethernet/marvell/mvneta.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 82f4333fb426..4fe121b9f94b 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4432,6 +4432,7 @@ static int mvneta_cpu_online(unsigned int cpu, struct hlist_node *node)
>   	 */
>   	if (pp->is_stopped) {
>   		spin_unlock(&pp->lock);
> +		netdev_unlock(port->napi.dev);
>   		return 0;
>   	}
>   	netif_tx_stop_all_queues(pp->dev);



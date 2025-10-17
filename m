Return-Path: <netdev+bounces-230431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC07BE8038
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCD0F568E1D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C83230F804;
	Fri, 17 Oct 2025 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CCf73WwN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bOCkRQVd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFDB26FA50;
	Fri, 17 Oct 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695965; cv=fail; b=Gk41H6Hq9XQVDunxHgRg6dJsHXglJXspZ+YNM5dZWHV+/HvK9fEu+H3XVI61VJ0NOCuLx2kKhKrn3Ga6SNh07uIjWky8xaNKoEncfLzEcXPR/My7W7GYCNeqaznbowmB/EKXM7LM15/gWzKgcJ30UUuJOND7LCIaw/m2+kjS4qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695965; c=relaxed/simple;
	bh=K2CZhnghvMLZPADptEN7qpRE+8IdNgPSgFnWkxLe3ec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTFwHo+lB+Z8YyR1GEo7BPusVBkWAr3zjuyxd3JPAQHD9bWtYreLsl6bq/SB2EkhtiYUL0dx6es6CfRgrD18h4bg940dNjc0mD3XxMYCkD1SXCjQ3427SO0Oz79Gckp8J6sPFHYW+5ly7Z3odzLuYJA7MZLej6Bf5q6fJfZ76GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CCf73WwN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bOCkRQVd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7uD6t008770;
	Fri, 17 Oct 2025 10:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3L/LMPg18Ni6rLrilPBX55zIFRNSXat4iCFZzFZ7F9g=; b=
	CCf73WwN/V/c7CnOL6EDRDLfHm2m/LsoiENQ5fHwZg3c0k/4oA35k5MbLe1UFue/
	5kDf3qNma63DVf8GL5lsxM//MqqzeQeyjSTl0RxpHl8w2N8S595x+wNRKZ2CmlCD
	Z0x356HsoEqOz8FLAFkRsHhVphj+9WsJwUSB2DtU4/3kIC6+4ENCQaMUwGMA4KG+
	+uS4WyYgGlgBA1S5AL5Ts+E+vSqX6eOUIePdZa/wp29WATrhpNFYtc5DCTZzBA8C
	GJFOj0s0hgCzORD0oeDw2wK1d3z95BIzQmStrAjIZ9rz9NDFZfnKFppZzdhVm8gQ
	jTTn5S39yszG+TKP9SVFOg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47tjh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 10:12:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9CC6S000668;
	Fri, 17 Oct 2025 10:12:20 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcvr64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 10:12:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLaWXJYXR0ZcZJGq8vc5ldecmm6ULxToLJb+fMhc6E8SS4UC0D+tzzu8V7KkOB9XV9DSNRqf/BosSglbN2P7UHfULrC6uaEoTIPPDqyMXn0HWq8FJFAo4Q1fohxKxYQ8xNa/JC3ldx/H8aCMB69ZEnBi8XqBshtw9mTfBUADEoAlV8q/H1eMZ2SQbkZ76krxL9XBH+LWwTGxAMwSlWUfNC/Ej+GNlz0+kJD8iK2953ZAj4vKqkxPkzp4DwTvMAgZUxJsjjnoQst8zPRCK14WSPlLDKIsp906HJdSYa5QjPw3g88e6g7wgpJQhqQCcN1iDa1EqDUH6oWHc/13L3NXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3L/LMPg18Ni6rLrilPBX55zIFRNSXat4iCFZzFZ7F9g=;
 b=ihSy2ME36gO3bRf2ZWwv9Y2/9TTNistXHW3+ejMmhCX8yS3REvc+ziHtIs+gW1H0xmmuP13rizsG7uonEwdhryczC/dNw+B0XtYvGgKwVVdpGI7IiwUP1AVhR1WWFG77sCfXWSCrGfLWeotJdSVBOhDYT5NjNWVVQlXGf+IV0W+lLy9DzrH8Jeot5hQuaGJft7asemR0Szlw6D/jufeSbjMxaf1DOYWG5jZ2rEUw0KLuuTxNSjoOS/buq8W6pMLDxUbTM/lFulGRtOSDxRRzKEYSjz/Vd8bcDnMxyKgG5kDTVb7ySCAJe4dJNrM3kDI4718hUDMqqM9v3imXmLRpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L/LMPg18Ni6rLrilPBX55zIFRNSXat4iCFZzFZ7F9g=;
 b=bOCkRQVd8TOhFOqLqOVTWbQw0ixNmnVUD1ACMqnFtBWq5G8TrTHz1Y+tW1uQn+g8qiY1tn5sbLTjEdLgq5hKg6eVTHgCWlkwHCMhDggW3axGJww9MQNMPjllYQLuFzIEpj0tkJfAF1KmPudsGHXtD7dPd4tfJ85I2kvbUg7z05Y=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 10:12:18 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 10:12:18 +0000
Message-ID: <7afc6cc0-44b6-43f0-bfe3-98901094b34d@oracle.com>
Date: Fri, 17 Oct 2025 15:42:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v30 2/3] mailbox: pcc: functions for reading
 and writing PCC extended data
To: Adam Young <admiyo@os.amperecomputing.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Huisong Li <lihuisong@huawei.com>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
 <20251016210225.612639-3-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251016210225.612639-3-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::12) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: d34b6244-6930-46fb-9f3a-08de0d65a6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjEvMFNXVmZOUzdiQjQyTE1xUlZLNFU2ZC92UXo3WWYwRmFsVlhPSmdDd1Z0?=
 =?utf-8?B?UFlVR014OXdJYXJONk5vY1ZJZlhtekFiWjJNbWVPdXlPWTlCU0VRZFY0MDlx?=
 =?utf-8?B?NzVLcnM5eWxmc1F5eGhjWncvYUlQMS9BOWlqRndmc1RYUWU1eUdCS21iUU1I?=
 =?utf-8?B?aGoxOTFScGFIUzBibURqTzBXWG9wbnc1YXh3eDkyb3NtTEhta1ZPU205NlIv?=
 =?utf-8?B?YTN0djhXTzJvbGZISEJOTjdVS0pQZUU1UnZVR0xtUE1CSG93N2NORlJHNE5X?=
 =?utf-8?B?bFU0ZnVyck9DZEg1d29YNlpCN1lBZUhCd2RLT045VCtIblRldDl2QnV2UTZ1?=
 =?utf-8?B?WWpBcCtDd3JXdG56TjRtZ2hrdVFjclVBUndhZXRQMksyTEtmMmp6VlphVG5i?=
 =?utf-8?B?aE4zVWFpU1VaT3BYb3JQR1F2V3MyUytaaWZ3SGVqR3dnMHFjZUtlbGhiVHhG?=
 =?utf-8?B?YXJ0NnYvOVVrbzdxRmhSbmVqUUtKWW5QaUx4NnZyTmhXN2FhUkZ6RXhIckVU?=
 =?utf-8?B?QWQ5NDFnU3dOaS9yd3dzQ1JVZVo2dlNOTmlXV29Wb2NmLzlra25nQy9vbXBu?=
 =?utf-8?B?M1d0Q2tZRy90MnFzVExtODZYQmNGSlJlQ1RlR0tTa01GejZIakFYVlN4bFlJ?=
 =?utf-8?B?Vlhjajc0UDVkQmhWay91ZFpEdGNiRzRRWDF4c0xzRTBxTXNGS3pZTkVYM0hV?=
 =?utf-8?B?c3J5T29GYlZEVkhyS3d4ZlBFdFhmbElaNXZxNUFrSEJEdUN0NVRUa2M2VWNZ?=
 =?utf-8?B?SHQrVWFkM2VJS2w2MUpSbEtlRno1eHNGeEtUVlkxZWY0aVFDemxHWTZjeDEr?=
 =?utf-8?B?STBCY2plQkZYVHBHQWx4Y25RN3dKeTU2STU5TW1BN1RycHppT05pTXdDRmxv?=
 =?utf-8?B?Y3p4L01ocUQ3dm51Um1mNjFSWVh6RjhHdHNrVzEzTjR1blRRblBSV1dwdk0r?=
 =?utf-8?B?NkgvY2RFcFVOOWxhQnZQVW95QWU0SC9yalJqVTRWQW1jbk95N2hiRHFIQldF?=
 =?utf-8?B?L1h4ZzRCY0xVZFlFRktRNUhEaDlnbmx0T0pLbjhmTmduWHNtQ1N1dDlsWXBx?=
 =?utf-8?B?NlV3RHMxL1lyYkltVjZwYVMrNi94WUNvekZMRXZWa2hqc3BQZUR6Smt6b1M5?=
 =?utf-8?B?YzlnRnRqcHdCQ21USDJueVZjZE5oL3pPZTlJN282OS9BV2xjclNRa3RuSExD?=
 =?utf-8?B?aHliOXV4T2hsWUVDVHNIQXRxd2RVTlgwM1FWampXMVR2bHBxOSs3TStaVUk1?=
 =?utf-8?B?cFY5eHRxeTgwamh4V1ljWWJPTXhKSTN5RGtoMURaVGtGRE1UTTlkSWZIM2J3?=
 =?utf-8?B?TTY3bTRIRmQ1cTRPKytKY1VqQU8xcTNWZ3p0b2F0VUk2d2RYQ0g3bTdWMVRD?=
 =?utf-8?B?aDJ0MHJ2Q1UwSXUxN0JqRW9JMnppT3VsenFXOFNKbWIxS3V0K3NnUnNnT3FH?=
 =?utf-8?B?RG1wM3RJckZGNWRYTHp6RDM0aGRDa3lVYTdNUEtoSk1YMHBwQVpxSkZUMU5B?=
 =?utf-8?B?bndrcE1IVnk0TFVlcXVYTklrbDFCck9tTlJOVTdoQm90eFR4RFVFd2N3WjVJ?=
 =?utf-8?B?dWQ4MzFwOWw3SGhOalBpb0d3c09icXg1c0RDa3hQWGpMaUh3Nlg3SFd5SUEx?=
 =?utf-8?B?dFh5NDZMWWRLUm04OXc4QVBNQVMwcktPTy9hSE0zeDlsZGU5Smw1ejR5SUYr?=
 =?utf-8?B?Rk4rckNEV2oyM05oM0szbjBYU0lFaFpXTWNzN25zU2Qxd1VwV1N0SnhQallR?=
 =?utf-8?B?QjlJWVFBMUQ3VytzaDJrYXA5Ri9yUDJMYW54WmZiRis1NGRzWHdxcTVuWksr?=
 =?utf-8?B?QUdhUWdqWmFESTkzZ1pjNDhtZTJwa0thenFDdHdhYXl4TWJUSGRpQVA3Q2dP?=
 =?utf-8?B?dWpRbGdhYSt3UTc5cWs4TEptTzMxMytWUVlhWGo4b0dUcmRiS3A1ZHlFa3J6?=
 =?utf-8?Q?SPuJqfUWj/NWZ5JvRHtElkOGDGO/kX+x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnRVN0wxMlFJWGhCNDdlb0tnUUF4eUR6S0VHQmtNMzcvOWVTbGhIeVo4QnI0?=
 =?utf-8?B?dWxzTVc4NGpCNFRxY1RWM3NLd2NGTjkveEppWHpPakZ2bmF2S0VQdlYxWjdm?=
 =?utf-8?B?aHArL0hqY3laaCszOExaY3dPNkltY1lnci9JTTNPejUrT3MyZjd4Snh5YlRM?=
 =?utf-8?B?WjFSMFRJVmZQMElLaUVXZ1BRY3d5L0V4Qkc2MTRzOHY5RFFoUmRyMktUOHlH?=
 =?utf-8?B?TDNScG93RDlnME83c0twb0dTVTN1bjk0M05kVkU4VVhkVldnMVpGVTE5ZEJ5?=
 =?utf-8?B?bFRqc3FqNUM4dXlVSjZRdVE2RkVvRm55aDk2ZFlIQTZVTVpDd2VMZWhsSldS?=
 =?utf-8?B?SDBpZDhiZStQOXRYNU5hcHhhS01ZUk9CSHV5ZFRoSlFVOWVWRkIxUGV1Ymd2?=
 =?utf-8?B?R2pOMTBLc3ZBNWJFKzc1ZGJRcEU3dEFlcExOeFMxUlFrQ3dvaTRtaWVNeWhm?=
 =?utf-8?B?SmRWZklHS1Y5Z3p0S0FYWFNoak1nbTEyN0dPa3dZejVnS20zN1ovRW1maTBi?=
 =?utf-8?B?Y3VWN3NjTVBkQ2ZScHR6Zkp0L3B2NDUydnU0SEprVnVTZG10WnYrbnh2WFdw?=
 =?utf-8?B?bVJ6TWhHSHp2cXZ5NXVLcWpTVHFNM2YwU245Ny8xQ2hVU0ZLYkNJYjRVWGIz?=
 =?utf-8?B?c2xpTjNLRzdjNVYxRC8rMVpwYmZlQjFSNmY4V1g5L0pMNnd5VDE1Z0dyeTc3?=
 =?utf-8?B?bUM4bTdQVXhWLzJGbjhBZnd6SGlNRWpuVEVqejhkZENaTWRrVkpURGdaakN0?=
 =?utf-8?B?UmR1K1pPclN6UXVFZnBTbVJJRlZGeUJjakFUUzByV3ZtV1o1aHcxT3BvMFBF?=
 =?utf-8?B?Ym15RVNYaFlheFViWDIydk1UR0hrcm9oWENMc1NmZmZKQzFBbU5MWEtCeEJR?=
 =?utf-8?B?aWNpU1ltRTBqc0lVRVkxbE9xMmZ4ZStOTHltclJXRmdxQmxuN0lYREZ5Ukow?=
 =?utf-8?B?ODJRN1BqbmJJS0tnZmdQM216OEZLdi9TYXBaSGl0YkZvbTVPaU1oTjRpekxH?=
 =?utf-8?B?SEE2eS94YXV5eFdaMzdOeTBnZkZUcDN6dXhYT0VwUklsUmt3dEVWM0d4N1JE?=
 =?utf-8?B?RWpFNExBQzdDSjVOcUhFSFZoZ1VyamMyWGpiS0NBQVZCQUlyUTVyUHovelRy?=
 =?utf-8?B?a2I5Q3BZUUh2L1VOZVlNcDdLNENNUWZmdXJsV0lUMFQxWkZyOXM2MG5hMWMr?=
 =?utf-8?B?cUthQWNxTCsySmkzUHlEOWJCczVnWmlrb2NWNENCVVkraGIzTkMrQUw4bXBP?=
 =?utf-8?B?bS9nblF5NDA3aXNGbVIzWStrclo3NE1tamZYcmxSLzRKZ2pGQ1Nka2J2Y2lF?=
 =?utf-8?B?di8yWFkzUGR5dHdzVFVpck5ndW0yNGRPOTMxQkNmUC9NWGpkWVh2TGpJa2kz?=
 =?utf-8?B?cVhZcFNQWkQxTGs0SDQ5U1FjeG5scVM5NU9zVXNuQ3J3NUJuMVJDWVllMjJ1?=
 =?utf-8?B?bG16TGMvUEIrM1F2bWRnVjdzRmhLYitVcnl6V0dtNkt2OVBCUmVGZEJDWXpa?=
 =?utf-8?B?cFRHZXJvSzM3ZTBLdndpL2J1NXAwSlJvcm1SZlRrVDVmcjBmK2JBOFp5ZWU5?=
 =?utf-8?B?N29jOElScFhwRytEUG14QmE4ckZrL1dJVHF1M3JEQmNnclFicDIvaFZuTzlQ?=
 =?utf-8?B?RDZzSGxwSnJGdmdGNXpNbkYrZmkxcWE1WkM3MitFMjZPRVM3am5EZC9KcHcx?=
 =?utf-8?B?dnphU05wZnhNTHU3U2VDemd3YkZKcG5FNDRWSnJJcXVOM3NUcTl4Sk9saVFi?=
 =?utf-8?B?VVJsaFFPM04yN3ZHbER0UGcyR09CbUZNQjZad21ZcngzREVpNkpNQWRzK05U?=
 =?utf-8?B?RS9sZWxhRWRQbTFRekxaY0NwWUJWanFFL0F4MlI0TFhVYzNSenpOZUxFZUZM?=
 =?utf-8?B?ajh3WjhKbXVrMDkxQ2FyYjU0d1lCYnJodU5INGhGaHdxQTZrSU5qOHBqR1R1?=
 =?utf-8?B?NURKcDJFbHFGUFZnZXBlellqYkRTYVVWWENlOEpDejREdGY5cHFGbUlaZEJu?=
 =?utf-8?B?QWRjOC9Hbjl6TGUwSzhrYXA5bFNqVkliTDQ3VHNJY0RZWjRuWmlQV0puNzZN?=
 =?utf-8?B?VmtSQW8ydW90Y0ppWmxTdSs1VWU0SDFRMnZVVUdnaUNleGFTZXZ4UEpCdjFp?=
 =?utf-8?B?TTNhVm5uYXQ0MG94ajRxTzlTSjMzbzJPN09Ob1h2RlBSa1IrU21Pdi9RaUZJ?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/mBtJitrC0km9oCiVLZIepjl+c4u+byHp+LYvqDPswrFFcC+90OTCoqNpItNqBnANZhiu+xymDo77X0Co7Ug+ivuRSsYB3429FDpj6K99Iu4FPcE7BRacuOBXvGuY8zXwFr3/eRlCCTvKKZ082+SJi/+VRaY1qBQ+svm36mbBaMDrlFemI+aRF6xn1JdtySZDGah4qgkTJ1R6C/4XkMoYZ2XQgBMzeKGICJ1Z5pI5RTyVULTs+gvAkbq4jYlJuKx/LsvEZGEMzZVGFU/0GivZYGv6L9/HmxzP6tD8yR4LhTKlTII4Qxb0u9W1gA2WaIC/YYp4ZWBD2EkZqsIAjjjiIYjkvasNp+Ee8qtj2QuWLjEwYn0Ik/INGjcWkSU+6bapffPepP61sJ/M0W3jYQcJmzRs07KLDDH6OBM47gOQbp7QjvR/XpLeCxx1LOEaNrWKRYUrSgBSy7p8S+HIyyEzTyB3/4e1UgIfeDAj2dx4plwlVDO2xyXkX4Et4vIWgf5XSvX6MuPI9OCr2zju3vyxEQbvt6Zso9dp+BTkZzQeL9ikuGPisjxmN8PpGO2/sxp7YGY8WwDxF8XBNaZU5JnfEKTErT/4GlgI8PRXUavA88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34b6244-6930-46fb-9f3a-08de0d65a6e1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 10:12:17.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4Bx7u0ozXORDn4PiYvXixUYwHqBDqi2zQfWR4a/bJzZFW1XEAt9yN0t5yXknzM68EAOhhEHPVlyaaiFyYVcIfHwhJL8m02LBnISLP2u9eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170075
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68f21685 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vzhER2c_AAAA:8 a=9CR8wRflWRixLVYG1TIA:9 a=QEXdDO2ut3YA:10
 a=0YTRHmU2iG2pZC6F1fw2:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: GM_4lyxfbEzocExFLgWchcb53y7vztIL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfXwrENiHWH3S2J
 giMrp328/pXm9mmjotobx2c8RTaB+u3P/vLnUj/ofUgOPUDf5RYwzvCK5Db6jfmzTYvzV4oScrF
 HmsnnaAgRfeTyD4oxXUzwIcrPDGdwT85q3t12VbYykoRqMHlTjwdKRxOlov39OBjRKIBG/aK+uU
 ab00Oua9uXaj+fDUDM4Apn1inLlPNmQFYYiG0YZOEkKfBYgiUgdWvnMiskQfrHWGwmajyUw4Q8z
 r5sqEk366lfwxhwElDV9YWA2SnPCCv9zW3QCOokMu+OX3xRjyMwuCFzZmA6FdkSgcTE8x66aKHE
 POyAm45PDCfnX/iih3BjlVPX0l2uRqV83MfezgxNGBYKcV3FeZIyGeNKCzpEhBeN91J4sH8RmW1
 LBsJhZzM42TA1cTGe+ABcC2dk2Qj+w==
X-Proofpoint-ORIG-GUID: GM_4lyxfbEzocExFLgWchcb53y7vztIL



On 10/17/2025 2:32 AM, Adam Young wrote:
> Adds functions that aid in compliance with the PCC protocol by
> checking the command complete flag status.
> 
> Adds a function that exposes the size of the shared buffer without
> activating the channel.
> 
> Adds a function that allows a client to query the number of bytes
> avaialbel to read in order to preallocate buffers for reading.

/s available

> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>   drivers/mailbox/pcc.c | 129 ++++++++++++++++++++++++++++++++++++++++++
>   include/acpi/pcc.h    |  38 +++++++++++++
>   2 files changed, 167 insertions(+)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 978a7b674946..653897d61db5 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -367,6 +367,46 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	return IRQ_HANDLED;
>   }
>   
> +static
> +struct pcc_chan_info *lookup_channel_info(int subspace_id)
> +{
> +	struct pcc_chan_info *pchan;
> +	struct mbox_chan *chan;
> +
> +	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
> +		return ERR_PTR(-ENOENT);
> +
> +	pchan = chan_info + subspace_id;
> +	chan = pchan->chan.mchan;
> +	if (IS_ERR(chan) || chan->cl) {
> +		pr_err("Channel not found for idx: %d\n", subspace_id);
> +		return ERR_PTR(-EBUSY);
> +	}
> +	return pchan;
> +}
> +
> +/**
> + * pcc_mbox_buffer_size - PCC clients call this function to
> + *		request the size of the shared buffer in cases
> + *              where requesting the channel would prematurely
> + *              trigger channel activation and message delivery.
> + * @subspace_id: The PCC Subspace index as parsed in the PCC client
> + *		ACPI package. This is used to lookup the array of PCC
> + *		subspaces as parsed by the PCC Mailbox controller.
> + *
> + * Return: The size of the shared buffer.
> + */
> +int pcc_mbox_buffer_size(int index)

use subspace_id for consistent name and use in header

> +{
> +	struct pcc_chan_info *pchan = lookup_channel_info(index);
> +
> +	if (IS_ERR(pchan))
> +		return -1;
> +	return pchan->chan.shmem_size;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_buffer_size);
> +
> +
>   /**
>    * pcc_mbox_request_channel - PCC clients call this function to
>    *		request a pointer to their PCC subspace, from which they
> @@ -437,6 +477,95 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>   
> +/**
> + * pcc_mbox_query_bytes_available
> + *
> + * @pchan pointer to channel associated with buffer
> + * Return: the number of bytes available to read from the shared buffer
> + */
> +int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan)
> +{
> +	struct pcc_extended_header pcc_header;
> +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
> +	int data_len;
> +	u64 val;
> +
> +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
> +	if (val) {
> +		pr_info("%s Buffer not enabled for reading", __func__);
> +		return -1;
> +	}
> +	memcpy_fromio(&pcc_header, pchan->shmem,
> +		      sizeof(pcc_header));
> +	data_len = pcc_header.length - sizeof(u32) + sizeof(pcc_header);
> +	return data_len;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_query_bytes_available);
> +
> +/**
> + * pcc_mbox_read_from_buffer - Copy bytes from shared buffer into data
> + *
> + * @pchan - channel associated with the shared buffer
> + * @len - number of bytes to read
> + * @data - pointer to memory in which to write the data from the
> + *         shared buffer
> + *
> + * Return: number of bytes read and written into daa

typo daa -> data

> + */
> +int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> +{
> +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
> +	int data_len;
> +	u64 val;
> +
> +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
> +	if (val) {
> +		pr_info("%s buffer not enabled for reading", __func__);
> +		return -1;
> +	}
> +	data_len  = pcc_mbox_query_bytes_available(pchan);
> +	if (len < data_len)
> +		data_len = len;
> +	memcpy_fromio(data, pchan->shmem, len);
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_read_from_buffer);
> +
> +/**
> + * pcc_mbox_write_to_buffer, copy the contents of the data
> + * pointer to the shared buffer.  Confirms that the command
> + * flag has been set prior to writing.  Data should be a
> + * properly formatted extended data buffer.
> + * pcc_mbox_write_to_buffer
> + * @pchan: channel
> + * @len: Length of the overall buffer passed in, including the
> + *       Entire header. The length value in the shared buffer header
> + *       Will be calculated from len.
> + * @data: Client specific data to be written to the shared buffer.
> + * Return: number of bytes written to the buffer.
> + */
> +int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> +{
> +	struct pcc_extended_header *pcc_header = data;
> +	struct mbox_chan *mbox_chan = pchan->mchan;
> +
> +	/*
> +	 * The PCC header length includes the command field
> +	 * but not the other values from the header.
> +	 */
> +	pcc_header->length = len - sizeof(struct pcc_extended_header) + sizeof(u32);
> +
> +	if (!pcc_last_tx_done(mbox_chan)) {
> +		pr_info("%s pchan->cmd_complete not set.", __func__);
> +		return 0;
> +	}
> +	memcpy_toio(pchan->shmem,  data, len);
> +
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_write_to_buffer);
> +
> +
>   /**
>    * pcc_send_data - Called from Mailbox Controller code. Used
>    *		here only to ring the channel doorbell. The PCC client
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 840bfc95bae3..96a6f85fc1ba 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -19,6 +19,13 @@ struct pcc_mbox_chan {
>   	u16 min_turnaround_time;
>   };
>   
> +struct pcc_extended_header {
> +	u32 signature;
> +	u32 flags;
> +	u32 length;
> +	u32 command;
> +};
> +
>   /* Generic Communications Channel Shared Memory Region */
>   #define PCC_SIGNATURE			0x50434300
>   /* Generic Communications Channel Command Field */
> @@ -37,6 +44,17 @@ struct pcc_mbox_chan {
>   extern struct pcc_mbox_chan *
>   pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
>   extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
> +extern
> +int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data);
> +extern
> +int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan);
> +extern
> +int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len,
> +			      void *data);
> +extern
> +int pcc_mbox_buffer_size(int index);
> +
> +
>   #else
>   static inline struct pcc_mbox_chan *
>   pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
> @@ -44,6 +62,26 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	return ERR_PTR(-ENODEV);
>   }
>   static inline void pcc_mbox_free_channel(struct pcc_mbox_chan *chan) { }
> +static inline
> +int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> +{
> +	return 0;
> +}
> +static inline int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan);

remove ;

> +{
> +	return 0;
> +}
> +static inline
> +int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> +{
> +	return 0;
> +}
> +static inline
> +int pcc_mbox_buffer_size(int index)
> +{
> +	return -1;
> +}
> +
>   #endif
>   
>   #endif /* _PCC_H */


Thanks,
Alok



Return-Path: <netdev+bounces-255063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOaqBLRufGkSMgIAu9opvQ
	(envelope-from <netdev+bounces-255063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:41:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1FCB883C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C389300A13C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940FC32A3C5;
	Fri, 30 Jan 2026 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VyyzP7gT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uvJBbgbA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93533126B4
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762480; cv=fail; b=g9vVb3UfRcXw4KHb5oFlf2b8KAC1gDXpXxgcjdlYvu/EcYW1xB+K0MXIE3NB9hKsXvc9o9uGb88chl+D7kS2BcFxAcQtT/QjCMqx1cy7dEdJDTOOak7kaSRN+yvTpbJMQO5luJK/ThjwFbEtBqnjvgDahFkvQ+paT4CMy5bsSkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762480; c=relaxed/simple;
	bh=xu5qKMLwT4xWYOiYGVn54MgEs/iVIYmg2lXwXSv/p3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U++xQa05qN6Rjp/hm6P0W1XEQNUWfFeSu4hHGTr72VOBLdciAN/4ZjvAYAKrc3Z3N5loDQ50U+uK110ksltvbSNUpHQIKhZuX3IIAsIvn5fTsoV9ypw1FPhW/Zpla5AHiDUsMCTul0wLvcaBPOSt7Zhx0GmVNkGCrgfiM3bRRjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VyyzP7gT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uvJBbgbA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TLTgA8682573;
	Fri, 30 Jan 2026 08:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jN38NZqM7lAwj0Qy/ppnubsRII/XyMMtDLMS4jBCywk=; b=
	VyyzP7gTX5LVBz2YWLJCK70GLzrwrSD2t9xPFX4+ZIZuC0qi0CBEtOze7iWwmcPd
	fjsm4qfP9hNie13H2ZSYosziDvchRNbiWqdekIDTS2Hl/3t/jNJN9D1FB/FuzbWe
	jEn9+ZBpuxa3HgcRoT+RnKya0jBIH6G+oR2Z9FAc0RgGdlB29V0DNOCWLxJr7ndp
	Y30tr2dBcV7BQ2IwxwdYrDFDsc1RhDTxwepx4leQ4Z78QCpcg0NpoWrl75OC/0w7
	6V/ce8HNtEE+Ye/+mJHb5oBxU3b+oL2gsCwf6ym3lu3jrJHRHfPag5egKF0EHx3V
	zUHLTkOHcL4n6QRJxx/puA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5t6cfyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 08:41:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60U6bUVl001768;
	Fri, 30 Jan 2026 08:41:00 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhhyh4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 08:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhG6tIVv1FoYMOp+j5gx3AxHm6X4rQjC9TCa0EEruNh02k4vq9UGhKWoEavOsasoXyY8V3eLBwx2k5gP+q1TE7goyjNCRn8px/IddrSCT74NgXYa0eoh4m3Ibi1jQbiH69Tm42iPZIUiJEkv+D/wO1qADxr3dAxyYMhp0m29yTuoUSwktAbWH/ONcVuqbG1tq6yzv/3beIndKmaJJGxo8liQBxCwYEa+fHwjl8/ps1dfD0on79ofQPt3WoHtvsd3tt7OPfDupBj8xF9dBvjmj4X999TbJrwWXz/lN5aU2iXxSpd0b06FS2DKyhArgEdVwGNkDIuPunOasp0FJpvApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN38NZqM7lAwj0Qy/ppnubsRII/XyMMtDLMS4jBCywk=;
 b=tlwU0xK9ug/HkFoU2QQ1qD/ynZVbbqosMyn1pIF8hWLL93k4mSMIfO9e8oeNqQGeVlu1oepw9pknIRF/iB/lMp83hj0ZOcinuWmGawCmGznTet5Fqef8xYlTBq9o4R4iWgJR3Z42H+Nz8YaBPi4XVJvKkRosa5wFuVvJg22jVmRbJ7jGIK0ZohqpfVdydYFHSZwpYr0iGpHxszdMuAmz4UrYiqZhOcFbo3Nb7xnFbLU+CoSa9c9y3OPyLfmcSy/qRthAwVM12HDkazTom38C6kxQPaWetsHqKEpnndyUX71q0V0Cb7IqGJn0c94D5/UYY1nle0/Hy4rBAJyLwMMClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN38NZqM7lAwj0Qy/ppnubsRII/XyMMtDLMS4jBCywk=;
 b=uvJBbgbA22JkrVRJiTJ8s7RbhzTURzXijALt52+ITgPCvAedjlJe+dn11PW/K7Yt2f+IqmGOvcpkMJwq/vh78xECY2ynD/0pHkP2XoQoSKP8raU7QtTCOjjngc/FeLGsz6OsLigk5lHsMxJ4/Z+5Gr8Z27ey/WLcyYavJTgZ7Pk=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA1PR10MB997654.namprd10.prod.outlook.com (2603:10b6:806:4b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:40:58 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 08:40:58 +0000
Message-ID: <c102db6f-c676-4bb9-a1ee-3a43b35e6290@oracle.com>
Date: Fri, 30 Jan 2026 14:10:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bng_en: fix misleading error message for generic
 firmware version
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: bhargava.marreddy@broadcom.com, rajashekar.hudumula@broadcom.com,
        netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20260130073055.1609162-1-alok.a.tiwari@oracle.com>
 <CAHLZf_vxzcOpavJ-rNUsmi3XQ-NAqmWBvy2MRgGb2A3iWFHFHw@mail.gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <CAHLZf_vxzcOpavJ-rNUsmi3XQ-NAqmWBvy2MRgGb2A3iWFHFHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::10) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA1PR10MB997654:EE_
X-MS-Office365-Filtering-Correlation-Id: 05137738-0359-4adc-2244-08de5fdb49e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1lJQ3JKZEE0WHROb1RpVHc1MGhVQjhzTFZuYUdTTUtPa0M0eFM3WkZHQThC?=
 =?utf-8?B?RkI4QUJSdXdzRko4K2E3eXg4MjNJRXlVS2Rzc0piUHZhMmZONTNjTkI3cUpB?=
 =?utf-8?B?MGJyc1VYa3BOZzlvN1p3eE4yanhSbGlXalMyMW84eFJwUTFkbVVFM0l6RXg4?=
 =?utf-8?B?YmxwUlhWVzdiNkVUWVBoTE5Ea2Y4RU9LSmdwYWR4SVNxYzNSMlYvUkM2aS84?=
 =?utf-8?B?cENraEdYYTFhMStnY0VrNjljT243ZS9WK0pEcTdhNjZOZmZ6QWh3V0pEWWR5?=
 =?utf-8?B?M3p0aUVwbklYZFg1d293R0Q1bnExc05kNUhnR25nNDBqNEhGRXA5Vk1Kd2tu?=
 =?utf-8?B?WU8ySGNrVjgwNVhGclNzLzZjSnA2dkZsWVAxdXd3SFRKdUI5d1lDbjZ3NHdN?=
 =?utf-8?B?NzlOY09CWURHM2Q2aFduQVgxMG5lbnlGNGpYMzdWRUxJVHEyQTNxb29zeHhG?=
 =?utf-8?B?ZytRZ2RNYVY5Z0d2Qm9QSVlDMHV2UEdyM0NEeE1ZWHJ4d0FPVXJGdW52WGhZ?=
 =?utf-8?B?emJtN1VnOWdXeXJ5UW1IY3VIZEo1dWtRL1BmU05mZk5saVExYlpTMHo2VFhx?=
 =?utf-8?B?R2FudjlEeTA4MEtVTHNxbTZtU2RPOUFpUWlDY0wwSWpaZitzZWJtQlZ0Vm9O?=
 =?utf-8?B?RmpvOWdZSVYwdXZLWTdFYzVjUzdoWTJiQzB2WGoyNjU5aU5LRFNIckVsdHJ0?=
 =?utf-8?B?NHFoMW1mTFI4dXUyc2NrOTlMY0c1ZnZnS1dqRnJjNUZlY2RNZ1UxL21vNzdY?=
 =?utf-8?B?QUptcDBWcUhtb3B5QVZJVXVTZEVwbFdCRW1sN29jN2lkQXFBUkxIT2o1M0Ru?=
 =?utf-8?B?SU1iVklPSnFKYmwxcjQ5NjllZWZBWkYrMU5UNGt1cFJVNnJFUWR0M1ludnJO?=
 =?utf-8?B?MEovTzJBM2tOM3FaWDNURVNiV2RBTFpIS3ZyOVdqZ3hHQWhnbS9LTi9xZEN5?=
 =?utf-8?B?VHJUcnBlRFpKVnh1Q3RoRi9PMVpCbml2R2Z0d013c0xlZlZVUno1N296NGNL?=
 =?utf-8?B?NUxmdkpUM0IvdVBVcksyNW5laTVUdkZ0MER5Snc2OSs4RlBCaFlqRkxGL2No?=
 =?utf-8?B?ZUQ0VXlxa1JxWk5wakdVeDJKOSttMFlIbFlsMFIvNGFPL0lncTE3Ry9LY2hl?=
 =?utf-8?B?QWQyQjZmMlZhVmV1R1hrc2xTQ1lCdW5jcURYd1Q2a3I1OXFNcmRsWmd2aDd3?=
 =?utf-8?B?N01EbkFNa3lkejlRdE4xS2lIRDhTajB1eVQwaWE5WnpJWDJBclduc1ZMUGxI?=
 =?utf-8?B?RlcvcUUxc0ZPcWtDamdSK1p1aStvYk5HN0h1UkpOTGJwODkzeFIyb2VySGRn?=
 =?utf-8?B?ZXIrSVNadk0xcktsR0dlVTl3SzVUZTdOSklxY3NYMGpUOHRORTZsKy9WNWdk?=
 =?utf-8?B?cnVrNGlyMzRMeFJrU1k1ZVNNVTNUWWhZQlZETEtzT3NwS0I2eGlvKzRRR1ZO?=
 =?utf-8?B?VXNoTnpFQzY1am5EQmc1QkVvWEZaNFREL2lxRDdBZnE5Q1VMV3BMRHJPeWhL?=
 =?utf-8?B?aC9qS2pPeVpWZE1NUnV6SHZKcFpYZ1ZBOE9oUnE3cDdDOWZzNyt4aUxETW8w?=
 =?utf-8?B?dHU0Y0JMTHlrWFR5S1VYTkhTd0F6RWlSMnlJZi9GVFdXLzl2WUFSaVkwMWM2?=
 =?utf-8?B?SDRnTzhqOE1XVi83UnlhM2FSTm1TUE9hOWpuUmJZSThuUHY0RnlxSUVFZnBJ?=
 =?utf-8?B?TCtxTzZLUDVUb0tSeWVBcXBCTnZZOFY1cjNVMW9xN3hEWHMrZG8zQ1dlSnJs?=
 =?utf-8?B?OTRPZ1A1WU1Da25Qd213QXVxTDdwR1Njb3VLMjhlT2xEM2xsVS9vMVRYRWhj?=
 =?utf-8?B?a2ZXOXQrUUx3VUI0RnE5dWU0eHM1ZEFkWjcwV0lmdm5ZWFJPRlJkWHZCM1RX?=
 =?utf-8?B?aHZrbDE1bUNzbmZnbnZKN0Vyak9BT1RrZUE0WXNid2I0TGZTTldFVEsrOHBk?=
 =?utf-8?B?QktlNXBkREJWTTBCQ2hCR2VxVHc5MG1tYlJtUUt3R0VDY3NnZ2thalJZVHJs?=
 =?utf-8?B?SnJOVExoa09CS3ljT0t3YzlwKy9nUXg2VzdLMEVGR3h0bFl1cE8zczNITlhZ?=
 =?utf-8?B?VkVqTkpRTGNGOE9JdXdCU1h5MDJNWTFjM1NlRnVkL3A3WVBYOCtOaWFNa3JE?=
 =?utf-8?Q?h4FU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzR0RmUvU1ZYdTVaT0ozRm1halNnSUpZTDEwNTFKMVhQaTBBYVppQUIwc3lh?=
 =?utf-8?B?RDlrWVRsanFjV2tQVndQYTRaZmFIVVNBU3YydjBXL0JOT3NhVEZnTTM2Mkd6?=
 =?utf-8?B?U3Z3dHVER1VJRkNoMkRvUXkra1A0R3RUa044eENNemlMQ0haYnJmaUIrRmdS?=
 =?utf-8?B?OVBocWo1ejdVUTB6bDJpRUZhZS96eVY3Mm9FYWxDUk92QVV0bWdrUlZqSTFr?=
 =?utf-8?B?aXJueFlMV0cxUm16SlVGeFR2WUQvUTQxT2oxMXN4ZjhLSCtBQ2kwY3djNktq?=
 =?utf-8?B?K1lmaWt1dTFETTJ6ekhWZG42WXptQ3Y3MUxmR1RLWEFYS1QrdGtJRjIvRjZI?=
 =?utf-8?B?bWFBS2kvajRzQ1h4UFFjY0kyRDRzZjVtSkNrOGhhQnZxTVNMTXZabU1wbkNG?=
 =?utf-8?B?Rjk1SHZJbkVNNUFkRzlGYUlDWVJ5aC85TlVTdEVtNys5cSsyaUpZTWZRczB2?=
 =?utf-8?B?bGFKVHdGSUgwUFAzNk1YZEJ0WmE3Z01KdmRkVzg5N0NTNE9MK292Tms4MlVu?=
 =?utf-8?B?SkVlSWdIVjR1S1lpcGtvbUZlZlF6WVhydzdkc3BwYWt1LzdMdGRsL0ZGeGhk?=
 =?utf-8?B?UUFoQU9sUm0rdTVrNTh6UEhuWHZhRnBVY3pHVjVmeEJySTM1SjBPWmw5bUR6?=
 =?utf-8?B?SjJZemlqVys5RG51ZDBSSWxja1hJeHlLVGk0VDRrZ1diTUdCUkkzMHNxT2tT?=
 =?utf-8?B?a09hMWpSb3VSdE1nQUkvNW15V21vbmRQY2NMNis1ZjFOdytMRVZzRDFQaUVR?=
 =?utf-8?B?Zm1lZXo2Mk93WVNrNERrc0pHZVp2M0kwYy9pQnQwQVliZk5yOFNwOFZyNTA3?=
 =?utf-8?B?cmdya2hReno0SDBqZmpzUXF4emVMSmxQWU9oWmdVOTRLSm5BdDFyemZoU3lr?=
 =?utf-8?B?WUszbklORGE0cFZzb1lXaGpJQURXckZIWDZxZjNrTW9UajNhL2ZwQ21vYk1T?=
 =?utf-8?B?bHowZjlpVW04RDNYMGhYbUN2OUk4NXNXRmJPTGRRSzVYbGUwbHNNc2kxYUg2?=
 =?utf-8?B?eUNUYUtraWRMMGM4MzdJMmx5QW5NV0FzV1lMY2NTUVg2UGtYUFFjUjZ3dG5T?=
 =?utf-8?B?T0JjTzhzYnBSUEpWNE5ibFVpVW9BUTZGdnBJVzVNT01hbmNBdVpKdmk3bG9Q?=
 =?utf-8?B?eHlRVmhMUDNYajFxWVlGOUF3WThveVBmY1Ztak01RlRWNE56bGZDbUdhaVFy?=
 =?utf-8?B?cGhJN1lpMFZ4cXA1QmRweG5tRzF5WTVhRU9KT2ppRkVRN1JKazY1NDdxeTZI?=
 =?utf-8?B?ZUo4bjh2QlNJekt1RHVtZHB3enhHMi83YnRMYTBOMGgzbG56QmFlL2lDTEpB?=
 =?utf-8?B?b09LV3Job21NVVdxM3pUcmszaGZwUHpnZjBmU3RrbjZULzRDZjhOSWR1QmRo?=
 =?utf-8?B?VnZZcENESzB2c28wQjNYdWw2cERrbmcrYVl5ckhWVUVPbURvWmFhd3VUWWI5?=
 =?utf-8?B?U2RuZnFKMWZJdzRPbU82eGx5RVIyYmk1YzhkbDZmZTNkTVlNckFhQThUdmdH?=
 =?utf-8?B?b1FTTzFWYnpybFNTSGxXN3RBOERaYjlBbVhFM2xkc295VnVFaWxDT3FPNVZW?=
 =?utf-8?B?RmRiaTFqQkNqMWZGbUVDQWZ3bitIR3pOWWNmQU1ZQzRFWFZpS3FqdEtzc05O?=
 =?utf-8?B?NzA4QmpPUGZzT296RE9qaWNFUHlFbW5ValFWajd3ZW5ZY1U0RFIrdG50S1B2?=
 =?utf-8?B?RVV2MFJUNU9JdEdManEvRFF1dUtoaVhVOEJ1a1phcGFnaGdxeE9WblVLY0NX?=
 =?utf-8?B?anlLUTgvTGlVUlZIaVE1N3gzd08wdVJScDk0emdoTGgzRVBYdFFWbjRRMWtt?=
 =?utf-8?B?MmplYnY0SnpCVGFoTTRjV2lsaXFKOEY0REZDdVN3YXNXWUtkTElkczBoc2VR?=
 =?utf-8?B?UzdTNVU3cGFGcnVEVTV3bXQ1anFESnp2VHJia1orTXFmVy85RXkvNnJzNzYy?=
 =?utf-8?B?dkZXN0Q0S2QwS3NDYmlOMHUybm54NUM3Zi80WTZvZWpnaW1IS0s5MWFqUi90?=
 =?utf-8?B?aEEwMGFwK0pSeHU5Y1VFaUVEWXYrQnVHS3NIYXFXMlJKaUdoMDlVZXA2NG9E?=
 =?utf-8?B?MFlzZHdQL1dxOWtBYjhDejlYbnlVY3NkK05idHRnK3ExeXBPbUpBTHMvU0tK?=
 =?utf-8?B?M3J1QlZVZDRDSnUwOE02SnhGZXhiYWVUVStnMTMrNFlBNFplbHFwQ3g3ME9r?=
 =?utf-8?B?dDduK0ExcmpVdGxuN0VSdEkzeXU5Ykh0TlRRelNqRnIzM1RpUXFyNWZWNVBt?=
 =?utf-8?B?Mm5EcWgwQmJtMEY2cHVSTmpaTEVPd0FhWjkwQllHenkvNExuRnlTNlJLeldT?=
 =?utf-8?B?RVh2Q1dJcEVCeWVVd2N3NE96eW1nQ3YzNkQxblJVU015SDJQdUJiRGJRUzNU?=
 =?utf-8?Q?FZvDo8ca7G0jOTzQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nq1IlbCOe5KRXngDMGzr60Oc8CrbdNWCStMkexyWtpy7nRkLLRiO0TU7g9tllZBlFqFjLEoMIIzl0zErlxpH6DTPQButUrqphjofp7dpPTDZSZOf7QuNem/93a5/Cqx5OcCfU6qbO1FwQEitQHYIcyG0Cu050HLqDAPaqyIxMReE5Y8aSsif+k8Cs6eNzl55ZFTMm1ZKiqnaHlGq2ag1TJJ7jtHvwMKS9Df8NIy07q0hHnpqqZ1CpiSQgEmaT8WE+bSpFk88SIcpCD0ljkc8BcSPnRHoG6yXxyeexL3SNeimDiCTEuRvyYt91ZaEN3a7cLvvHsZ8g9n7N5EZnokoFHXRCMuflJW7TJGb3yAQuV3Mt9sUoVtcLm1kHoe4jXPgyCvHt/U1I4BnUybb4L7zSaIp9MLJLdVdqVdJRv0OxlJp8y4xD16xdJBYnrMSs0M7Lh354MqvcVrdAdsPaDfC19RU3dW5R62Kim+fWZGpLS6st/Fi2j9C1isVg3MIp1Mdc8HwlMji5ezthF/oIaapF0eDKWXWheDHBvH8tC9aaZISKT6SZUIY1ejZpNayX2q8aj4u9zwDMCPiYV+nSks12fbh2pB+6ZNq7Eh90KroHjM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05137738-0359-4adc-2244-08de5fdb49e0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:40:58.2735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nHGnihf1ONuUcb6hg4JX0dMBbGxoqytJhol97aJ/G76B9F7OF6GhyXENt2z9RFH0hwKVLUZhnQY3v3gaoz9cGsko0BUHbjpilwKRfSsSLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601300068
X-Proofpoint-ORIG-GUID: dq-2kk2X-D1Qv7z_DjebKA2qJZdsyzpK
X-Proofpoint-GUID: dq-2kk2X-D1Qv7z_DjebKA2qJZdsyzpK
X-Authority-Analysis: v=2.4 cv=IIcPywvG c=1 sm=1 tr=0 ts=697c6e9d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JHiWTemmuvCGNp9YPdsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA2OCBTYWx0ZWRfX2MKiH3hxGsOR
 PY5Ou+AKrASzxsdcmaTXZAi08iE/9LlXmmGcuVHou9rVlBv06V/JyuK1OFWq3+33QInBM/8cInO
 YCBFBw3fv/P/XRGlezUhITApqi3SLCr9X2WUolcURl8+d0aGSkABQ3hx0FPuP+CIwDsMi0QciMY
 Lfd+3lGwXsckoK3V+ubDLmLf8XgqFnR+y2cG8K8A4jOKNCSKgGRLjvV8u7ATtHeQmMBNXJSaE1R
 LYXsOPdAJ1jBqvqgBMRnjJ6zCnxC22ky4QYwTi3vxcOzwCDb5cjSQemKcQN7uVbjOVhL/eOrA/C
 fX2g3nNuiRYetOXdjE3wqfwACfWVunQlfCcS+lfC6x82VzheLsiIsT7BqsyVaqeYqzpWD0Po7DN
 IURGnJHBaIOlHw4w22PJwJkYvLC1hrtnmyVjnkgpgIc0LZAoLc+GKtNBvxayA7UvRxpkyc7pHR0
 0PYdfPA8o8AZOaKCzYMRBSE1J7V+k/fzkSlgxBzs=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255063-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6C1FCB883C
X-Rspamd-Action: no action



On 1/30/2026 2:05 PM, Vikas Gupta wrote:
>>   drivers/net/ethernet/broadcom/bnge/bnge_devlink.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
>> index a987afebd64d..57db3caabcfb 100644
>> --- a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
>> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
>> @@ -221,7 +221,7 @@ static int bnge_devlink_info_get(struct devlink *devlink,
>>                                DEVLINK_INFO_VERSION_GENERIC_FW, buf);
>>          if (rc) {
>>                  NL_SET_ERR_MSG_MOD(extack,
>> -                                  "Failed to set roce firmware version");
>> +                                  "Failed to set generic firmware version");
> Thanks for fixing. I believe instead of generic, "Failed to set
> firmware version"  is enough.

ACK. will send v2.

> 
>>                  return rc;
>>          }
>>
>> --

Thanks,
Alok


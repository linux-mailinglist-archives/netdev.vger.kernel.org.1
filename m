Return-Path: <netdev+bounces-242225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5835C8DC22
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96CA034C8A1
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B28328B5C;
	Thu, 27 Nov 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CdTlXQ6C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hGsSfT8j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0685C2C15A9;
	Thu, 27 Nov 2025 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239400; cv=fail; b=pwjiPMSGqQ7rv+vf2u/inL8sthC6wMw+9Z7flpNxop7q3SvHwqYZVHokgk1ipp6FRi1rjvRQ8YtmHwFex92N9/CSzUWpP3R81h6t5PF0IjEf4uzHwQqJO7Y30Mi6GAIlOzBzWngpVZR6qbbYyHiFl9brhvYgHjoId4pijlOUTMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239400; c=relaxed/simple;
	bh=7MwPm/w+2hGZoBxyHszb2F2CJJP6TMtk64YuOFM3YhA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xg03zBENlF8R2mSTv6GnlOcmRBjS2hdzeEl6Ikup9yBtGerz8IOKUTCf/bnPryv2yWU2XVRlO0YByAzv6GVk/KzbDLYIbFJt2oDcdm8S+OC7dkM/M4utalhwD4RNvxkc5q3Ic462Uj2yFE01fMs5etUIbxBeWzKbpDrP2bk17q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CdTlXQ6C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hGsSfT8j; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR7Jotd4134166;
	Thu, 27 Nov 2025 10:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=31VD3/DcjC5YV5ILc2ObdFMxEwLdQXOBBsTyTLW7P1Y=; b=
	CdTlXQ6Cz6XABKj+MR0X4My9vgby9Oz+yeHPFLFiAP8631xtgpgZOAelPlUYC2WS
	mjrI/7SBYnXa0l/goqmGxeMtmCOFdyERTX52/MFzBlcJ2xiM85oFV+nz0ENSJYKB
	GZTSTBH57/WcUbRvDGFMclmXrQDY6E5ce790U3VBaTbexZ+ifUudYV6PFpfs1Q7Q
	w/xBFhY2wQWs/Qi/6VKTREdBlMnUTlglmo0rP0mOjdfTQ6m/DXI+1U+fKzjwrG9v
	syRcKLb6WpO1XOEpAbQyeNm3kA49tEeLRjVY5flKSyL8fV1uCRAsyGR8j7oJ9+8e
	t9cAtsKSQJcIsgYUN9Gn1g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7ycqsje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 10:29:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR8cc9T022160;
	Thu, 27 Nov 2025 10:29:43 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mfw7v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 10:29:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSFcIEfvZgC5BHyYgxlldbBuxOq3agGUAyltrqVascMtJhMILaWtCOfpSsBc3keaIrrRV6/ansz6T2pjQSFk6Djs0AOTJtigYXVx3cDRxaKWdtVBsqUR8gEURl0REe8cNraGJGPAIKdK63vPrrv9RVbCK8cdzy7bWcsQTooJgzVb5E7xTWK2Wf/jK8d/Cwss8KDSvXdaS31DlJI0VchnTi16zeoqPUOzAmnHp6gZgTW4wkmV1i33nTvadCl+EQisL+lF86lPaP2npj0D4Da7w0c220+4yrFmvo/8JLOEkBYjsdwm6OMQaRslOyOt1pH2HW9Iy5WTP0P8O6z1jRyQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31VD3/DcjC5YV5ILc2ObdFMxEwLdQXOBBsTyTLW7P1Y=;
 b=irazt7fcBwShBAxo5zzZleiRndp9cUgpqgoAl6egkC6fdceMboy2+hZ82i4Yr1Cr9Tz9bQ0gRW65JsrLScnHQaqkc/TJzheBa04BIotH/28vXPeTzq3+WKkTwbo3vzNe8iZI4vR4s75zGH+hHf7xhS0K5A5dV/S1T5Q1npNfCxXlba/kFmuqncLkn2W5e+mDBprjL0zI+HAuL6nrVrnwaBsQGzy3YdjyhRatoK3xxzoge95KUWU8C84R12RzxajtznFpZzfEAwMw2FkKeCpnPyhGaBXtQ9GCNtOBDerL4F/3T3lInTglh+IyppqMuf1fqc/oWoFG/TyQUUhiKrwEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31VD3/DcjC5YV5ILc2ObdFMxEwLdQXOBBsTyTLW7P1Y=;
 b=hGsSfT8jDcAhz8Il1ckw4j6Cx0c6BMjfJhMMi+InCS60cw0RKAQtsXG8RTpYBd8UvARVx52tuIC5HinijwrPcnIRN5JG0vSHePzDhpzx+wbISanjeLAaSYDcCYUggZxoEZZBT3ajE/S59Xj9XAux0JyeZNIHykYuZACAD/BQeYE=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MN6PR10MB7423.namprd10.prod.outlook.com (2603:10b6:208:46c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 10:29:37 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 10:29:37 +0000
Message-ID: <291580c9-d68a-4910-8f28-58852055d7ee@oracle.com>
Date: Thu, 27 Nov 2025 15:59:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [v3, net-next 08/12] bng_en: Add support for TPA
 events
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
 <20251126194931.455830-9-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251126194931.455830-9-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MN6PR10MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e69ed3-af4b-444c-f830-08de2d9fdd31
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SkZOcEtHbUZBWlY3OHlLeHZxNVRwbFBpRnlncDRUcHdGd3F1ekVJWWhGM0c3?=
 =?utf-8?B?TjhTSHhBaXZiYURGTkp5bVBuR3RBZDVLcUlqZHNMS2FyNmt2UWVWNERHd0h1?=
 =?utf-8?B?dDU1a1krTWVZZ2dram5XWUZ3WlA5QlVXL0xYY2lLRlE4M1BESVFybzAzOGo5?=
 =?utf-8?B?UTRVVlZiOGlkSHNZVlhwRElocHcxZTJBZktGRVVOSXFjUkRFSHNqdVhxUUl4?=
 =?utf-8?B?T0hkNTRSdmdLelF0VUk4S083dmFIVmdoQjlHOFRwcXN2RXlReXlCK3lqTUYw?=
 =?utf-8?B?MkZHRER4bnZXV1pqQ2dvcHByRVd5OUloMmxna2M5MFgzMnY3aDcvbzh4b0tE?=
 =?utf-8?B?NzJ4MHRaUDJONXp3UnVVWkRUcWVKcDkrRUdnaTk0bzlrcUc2eENuMEk5a1Y2?=
 =?utf-8?B?cWZHSHRXQmI5d2htNktmbURjR0VodndiRlBpUldnc1dxL2pCRVJFWWJpNk1L?=
 =?utf-8?B?NFFGZkRUMjNBSGFCcnZEY0hkTmdTcDAwUzdnOC9BcEQwQngvSWlnQUZHei9V?=
 =?utf-8?B?bTlmazhzblhLN1UrczFPd0tOVWlxcG41cjJRaE1WbStvOUhMbzJvcFM2QTl6?=
 =?utf-8?B?NVFISS9RRHRkL1pSYU1tUExsdTR0ejNNZGJxTnQxcWRNZVJKSVFxTFNVWEl6?=
 =?utf-8?B?b2pZMWhYa05rcUQ3NkJGdnZwSWtLVG03Y3JlYld6UWZYYzNGSlY2R2wxdkhK?=
 =?utf-8?B?bW96azVVdjdwSDhyeHpUMm9FaFlZTGJoRUdIWjhNQzN0c1VTQ1RQUTZjc2o2?=
 =?utf-8?B?MDM4b3g1SjB2WEJIRWtONWVZbFdIR3QyblIwYnpJVEt3Qk5zcVJLYjNKUXhN?=
 =?utf-8?B?K2ZvSVREWlVXNjVJRHA5bFpTSGFmY0prbTVlZnN2czdnaWtaMFZ3b2g0MXlI?=
 =?utf-8?B?SEEwSmNCeDBkM2N1VDVoTjNGUnZpRFYwUTg5c1pKREJnSUwyTHFCZFN6WFE0?=
 =?utf-8?B?L2dITWdaZnQyOTU5d0VNMjR6eWNZZ1JCZU1hZkhXRSsyZUEyc1lvQ2NWcmdV?=
 =?utf-8?B?dWRlWkJJNFFqMFgwWU1ORnk0Yzk2MTY1VHYrMFhZank2Q1VNb1JHVUJHaFp5?=
 =?utf-8?B?WWhsZCtFd0Q2RXNhOENUenpQVno5K3dMUy95RTFGTnRRWWpOQkVQRFRFZ3E0?=
 =?utf-8?B?ZVBLdW1KQURzdlRKbnhkMC9mS1pQZ1hiUVhNVFFrdHdUaVFGSU1mV0pmY0Y0?=
 =?utf-8?B?UFEwbHlNVkpKaUNybFFpUCtGb2Y4MlltQ1V6MkV0Rmo2WmIyck5aZWdOLzFl?=
 =?utf-8?B?S0p2eDJjbGZJcWM1UGRKY1FnMG9xSHBvRnhRSmJjbGsrdHB4bWk0OHB4Um5S?=
 =?utf-8?B?d1ZKOUJ0V2xGN0Z3VCsza3JxbC9JV2xFR0RKMitnUGpGaTZncWtscVdCWnZv?=
 =?utf-8?B?RzBWUGt4WDBmNXlIZVJlVXplSnNlYk9Tb1pqbEtGeEpjM3JIOEZOb2V2Y1Rp?=
 =?utf-8?B?K3A3REJLTG92Y0tNTlB4SS9JcWZLd3FqdGVXbGhGUzZVd0VQODhmTmk1S2tv?=
 =?utf-8?B?WkFkS0hJbkVJMnp1cEtHUTVIMWltK29CTm9zYkV3TkFNWGdnT0YyQ0Q0azVw?=
 =?utf-8?B?bEM2N2ovblpTTnNHN2VQNzRZSDBkb2t5OTZTa0RUNUtHUHJMdTJiU2g4eEZw?=
 =?utf-8?B?ZnRPWWFiOUJjb05uYkU0ejZod2ZlTTlkRHhVU2NaREtkczlZRG8vK2x5bXBS?=
 =?utf-8?B?QmFZcWpEa3JnaHlZdEpIalJ5a3ZqUDE1NnFNVTFIQVo0Z216Z0xHUXVMd2dh?=
 =?utf-8?B?REFKaVZrS0wrL3B3a1l6Vnd6ODdrdndLRWo1SjhLaEkxKyt1c3IrMERqdVM0?=
 =?utf-8?B?cW5TTTRkRkNXNFA2M1JvM1dsZnFRVkFvRjdvYkhtYk9OaEJqZkJoMHp1b09i?=
 =?utf-8?B?MFNEVzlIaGZNTWEvUlhZaXdXbTlBRmpnZVVkdUNaSEV6bkJvN2lXV0E2cllz?=
 =?utf-8?Q?VqrvNAIsvu/MoXY2nBmshMkr0g46OJ0j?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?M3JuRUNVOVdscmI4RWhkd3RjMGNWRnUvbUFDUXRaaHNBc3N4aklMRXAyVjN6?=
 =?utf-8?B?UUQ1bTBsaGxRa0c3c3ZFWnF1aDF3Qno5SnJvSWJmZGV6V2RzR2JWUU82VjNO?=
 =?utf-8?B?N0g1K0EvRnh4WDc4cXUxV3pEOXk2UlNjVks3RVY4Smw2OTRBQmNFL1c1QWk1?=
 =?utf-8?B?TExxMXZabkpyMlpnVE1GOHZUbkRobnhrQ3UyRGkxMHdsQ2d2cCtwQUpjT1BW?=
 =?utf-8?B?QXBQNGJjN01PYUdLeGxlZXo3U2I5NTRBcCs1ZzNOTE5UbTdmRzVZMGFXWXNS?=
 =?utf-8?B?RjFTSjM2N0Eya1dLR2gxWUhmRG5CZjBBN3pOUDNSblFoR0E1N3dHRk5hdDY2?=
 =?utf-8?B?bzBwcmkwRFdFalNydUFtZzZob2hEdzRQdkVTYTk1VDlQNXlNQzdQNVRlaFNv?=
 =?utf-8?B?SVdrTjBOekdKaXZ3eHN3cWNndVpwZUUyelllY2wyUnBONWdCVXpVZmViYjNh?=
 =?utf-8?B?UVJnaURkU3U2MkhKTVhhUkt4YnU3YmMwZjF0R2w1cDRreTV1TWM2Wmc4VE5t?=
 =?utf-8?B?UThRYkYzemhwK3U2MHBQaE1oNEora2tvUFNhdzNsdk1OZ1J2dWRBK2VwZDBR?=
 =?utf-8?B?em5FV09Ua2NLZnEraisydUFLMzhMbURIVUl6dExoYkxqOEtOdVFWNmJzb0Zh?=
 =?utf-8?B?Z1lQeGN2bm9QeUVGMmcrT0lrZGVrMWJLcjNhYzZPWTRnVXJYSVc1cHNSUHFR?=
 =?utf-8?B?c08yZEVWRGkxNjlYa0Q2VWZCUUw3NTd0ZlRFWVNsUUlnTUVlNmhmYWFkaWti?=
 =?utf-8?B?TEQ4NXJMa3p6SnB1cmFxZitYMS9RMDNQaEFsS1BRMUFOaGp3TWdCaXhENjJD?=
 =?utf-8?B?eUNtaHo4eENGZlRQc1lTRTh5UjZMWXFPbGk5bm9PQ2JXeW8xUmtXQXZFUk01?=
 =?utf-8?B?Nno5ZmF5dVowUjdNRFhuVFlqR3ZqY0dmbGkrQ2R1Q0Evc2FzaCtRTWdhcmZj?=
 =?utf-8?B?dGIrZXJHN1RVQzFmOFA2N3hIeXJ3U2RJaWtUMkxYcUVFRWhBRFRCRkRQZkZJ?=
 =?utf-8?B?aVp2cDVrbjRSOXdLZy9OZnJDZkF2T1paWHVBakQybTBZbVJzS0V4QWVsZWYz?=
 =?utf-8?B?VUFydHN6RFRjNjBseGZtZEt6bElUK2VRVmppa0crek5XR0ZTSGJSU3lQVmdN?=
 =?utf-8?B?bWcrK1RBQUtXcElqdzk2bVFXQTBxbE85U3c5b3ZVV3RKMnJYejR5UG1ORUNO?=
 =?utf-8?B?ZmNMa01PT0pNTEFObTh5ZWMxRzRvRXJkRDdwSFlpbUp5QXdGcmgwZHJlc2FS?=
 =?utf-8?B?RW5jbDlqYnMwNWJnQUdXQXVVZWw3ZWdMcEpGRmdqdllKUDY1N29lUEFxME9S?=
 =?utf-8?B?eEtBVVVuZDk3SXVqYmxUT2Zpc3cvT3orSGlBWko5WEdZTjVRWUdoZW1vM0g4?=
 =?utf-8?B?aTZQdno4Q0xhb3hMVVUzQnhHVWVSbHcvMkd1TGhjczlmMUtoQ3BiSFNYSStQ?=
 =?utf-8?B?eWRlMGJoR1ovdE81SHBlQndOTDZ4SnNhUERxY21wRkpMV2ZVQjRJYUlGekt2?=
 =?utf-8?B?bmVlN3lodndUQmdIWDQvOFJ2cVZLMzVwN242Qk9sOFJWQkhBQ3JJbERIN3VZ?=
 =?utf-8?B?Mm9GU0RKRE5ETzhLZnpTS01EMlJ2MHRGNS95TUhiVkY5Mzc1elB5ZWNnNXBC?=
 =?utf-8?B?U2dEdVA4eWgwd1B3bGM3Yzc2ck5kcGNHUVF0MUFwV3h1Qi9UZDBKalYybmxP?=
 =?utf-8?B?Qm5yTWRlcVdZR0s0RGh3U05NSWtsanFmaTM0dFZ5YWxYNHA3TmJaUkxQc3V5?=
 =?utf-8?B?SkVDVEpmOGlyWS9FcW15QU8zcVgzNEM4ZWRwTHRQV1lGWm9sYzNLQzZzMGc1?=
 =?utf-8?B?WDVYS0JyTURPckxtaHRmN1JLQVhFUmlqL01IQUk5MCtONXJWK200N1VGMk0r?=
 =?utf-8?B?b3FzcWZxNFBWZHZQSjdseTNrUGx2aTVIWXhSSGlVMGk3SVVQWjBNak9BN3Nz?=
 =?utf-8?B?L2oyRjBHWmhZaTdIY0p3bmxkcVdoR3pNQlpRa3dOZ3U1aXRZNEZtWWoybm1B?=
 =?utf-8?B?QlRUYzZGR2s1bHQxWEYwaVBsOCttUmNpSVVENndNQUpSRHVnaDF0TXVEM21o?=
 =?utf-8?B?bXJRNld3eFhobEtBNW54Y0xNV2xNRHppRjJFTytndFQrZ0lPRlVTTzUwNzJi?=
 =?utf-8?B?ZC9ZZmxFYndVSi95NW9WVlNRTytTbDViUGduZVZJclRVNTNORFlUcUc1NDJK?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GV2/Xq6w7pQovWeRby8VxLYZejlIpWRXfbkT/HgtZY8py3y9DksFw5UqqDvlmTY8EsAprAPiRr4nF+gG+8W3O5D+sB45sB5cw6LQLPOfQaoIg1aO67poWWWKfpWihIQWN+XXVoFlfpMxZT5nv0TlKYT+JfSnDp/h9FB5ZAPY8VGMzRMXBAV7BNOi0AWUOm3itdjw2pyQSYXkIqZN3ikHk/TuzH+N8KfDl/DSrqOSIY94ofZK5DMObRrEs4E6qByO2rFOaYHWh39POxXVX8l35HCZcl9QV24+/t0bymHluncKAPsaprxlfv/0xUlJMGLNGgqOj5bAj+0jzcz6r1QmE6K/dX8EY7PZMSZ12yaYhUKEpKxaDnGTIt6K5ITXl9zWmPCsz2NmLoMaa2RzCtOt6+WvqyxS6p4wLmwWK+qwNF8oMm4hinb0HIx2nnldGSjjnpra8I6H6/cKPxQXJFIySDZsaS+VvbVPq0I+G8azIWCBVH3LnASymWCiIVntyJduxkaFgxA/E0OfnuEKi86iGtyoXgKrgfNgCzL46WlSNIO+ThbrcMCSvMjhoU0z1a+HLKyCYZl41XBw/J43HwNp7DT6isKQIOO54ule2aOAVso=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e69ed3-af4b-444c-f830-08de2d9fdd31
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 10:29:37.0630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBZT9dCOcCiUKvNm8jVzqr9xni/oV6cEfES4KIGlCGF86y2/nxAJ0/deyYkhbDsqA8DiDglCw89hOCqJAX0WwWdPjEFfJ94WU1/ha1Mndio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511270076
X-Proofpoint-GUID: -Nyd0F016LKrivRAsA_ac1SiM4yIiB0a
X-Proofpoint-ORIG-GUID: -Nyd0F016LKrivRAsA_ac1SiM4yIiB0a
X-Authority-Analysis: v=2.4 cv=RofI7SmK c=1 sm=1 tr=0 ts=69282818 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=5982OBc320K5flDJv-AA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA3NiBTYWx0ZWRfX6hBrUS6cAncL
 VwYuuxCLmnZm4QRKX0gd0lJTw6Yh8O/dzTMznjjvW1d0YJt7+FnRYZuA+TVXg3lo3G/ufYoLzW/
 lkAmsqNUIAR0euBfemkM6MqO0Wkk8t18c5nt/OnTd//KQtE45k7ppo1VJKPXKX8sQCVDfD915dV
 x6P0btTK0FOvsmahdWZiG2dEhGQTb55Z+Owb0QeTTq8TJErdNiO3YW6n0Qvo6LuVEwIS6cCkXEm
 5/HoBf0aGjYaLL9cxHsXz5HwSuF0anPsZQ7b4S5yrVb6O+4cNPuxs+R8lnx27f2vhovbWu2rr03
 ijTtUKX8HxD7nFy8smSOTZBKJ4aoNW0BdyN58380Lwcz0hpOfaNXLib+LadBeponZlxuom8XKIt
 dI420VcN5Pp3ZJDiqyNEeU8Vc4kpv5oXZ5xuuYAc7LYYOMIOsRY=

> +static inline struct sk_buff *bnge_gro_skb(struct bnge_net *bn,
> +					   struct bnge_tpa_info *tpa_info,
> +					   struct rx_tpa_end_cmp *tpa_end,
> +					   struct rx_tpa_end_cmp_ext *tpa_end1,
> +					   struct sk_buff *skb)
> +{
> +	int payload_off;
> +	u16 segs;
> +
> +	segs = TPA_END_TPA_SEGS(tpa_end);
> +	if (segs == 1)
> +		return skb;
> +
> +	NAPI_GRO_CB(skb)->count = segs;
> +	skb_shinfo(skb)->gso_size =
> +		le32_to_cpu(tpa_end1->rx_tpa_end_cmp_seg_len);
> +	skb_shinfo(skb)->gso_type = tpa_info->gso_type;
> +	payload_off = TPA_END_PAYLOAD_OFF(tpa_end1);
> +	skb = bnge_gro_func(tpa_info, payload_off,
> +			    TPA_END_GRO_TS(tpa_end), skb);
> +	if (likely(skb))
> +		tcp_gro_complete(skb);
> +
> +	return skb;
> +}
> +#endif
> +
> +static inline struct sk_buff *bnge_tpa_end(struct bnge_net *bn,
> +					   struct bnge_cp_ring_info *cpr,
> +					   u32 *raw_cons,
> +					   struct rx_tpa_end_cmp *tpa_end,
> +					   struct rx_tpa_end_cmp_ext *tpa_end1,
> +					   u8 *event)
> +{
> +	struct bnge_napi *bnapi = cpr->bnapi;
> +	struct net_device *dev = bn->netdev;
> +	struct bnge_tpa_info *tpa_info;
> +	struct bnge_rx_ring_info *rxr;
> +	u8 *data_ptr, agg_bufs;
> +	struct sk_buff *skb;
> +	u16 idx = 0, agg_id;
> +	dma_addr_t mapping;
> +	unsigned int len;
> +	void *data;
> +
> +	rxr = bnapi->rx_ring;
> +	agg_id = TPA_END_AGG_ID(tpa_end);
> +	agg_id = bnge_lookup_agg_idx(rxr, agg_id);
> +	agg_bufs = TPA_END_AGG_BUFS(tpa_end1);
> +	tpa_info = &rxr->rx_tpa[agg_id];
> +	if (unlikely(agg_bufs != tpa_info->agg_count)) {
> +		netdev_warn(bn->netdev, "TPA end agg_buf %d != expected agg_bufs %d\n",
> +			    agg_bufs, tpa_info->agg_count);
> +		agg_bufs = tpa_info->agg_count;
> +	}
> +	tpa_info->agg_count = 0;
> +	*event |= BNGE_AGG_EVENT;
> +	bnge_free_agg_idx(rxr, agg_id);
> +	idx = agg_id;
> +	data = tpa_info->data;
> +	data_ptr = tpa_info->data_ptr;
> +	prefetch(data_ptr);
> +	len = tpa_info->len;
> +	mapping = tpa_info->mapping;
> +
> +	if (unlikely(agg_bufs > MAX_SKB_FRAGS || TPA_END_ERRORS(tpa_end1))) {
> +		bnge_abort_tpa(cpr, idx, agg_bufs);
> +		if (agg_bufs > MAX_SKB_FRAGS)
> +			netdev_warn(bn->netdev, "TPA frags %d exceeded MAX_SKB_FRAGS %d\n",
> +				    agg_bufs, (int)MAX_SKB_FRAGS);
> +		return NULL;
> +	}
> +
> +	if (len <= bn->rx_copybreak) {
> +		skb = bnge_copy_skb(bnapi, data_ptr, len, mapping);
> +		if (!skb) {
> +			bnge_abort_tpa(cpr, idx, agg_bufs);
> +			return NULL;
> +		}
> +	} else {
> +		u8 *new_data;
> +		dma_addr_t new_mapping;
> +
> +		new_data = __bnge_alloc_rx_frag(bn, &new_mapping, rxr,
> +						GFP_ATOMIC);
> +		if (!new_data) {
> +			bnge_abort_tpa(cpr, idx, agg_bufs);
> +			return NULL;
> +		}
> +
> +		tpa_info->data = new_data;
> +		tpa_info->data_ptr = new_data + bn->rx_offset;
> +		tpa_info->mapping = new_mapping;
> +
> +		skb = napi_build_skb(data, bn->rx_buf_size);
> +		dma_sync_single_for_cpu(bn->bd->dev, mapping,
> +					bn->rx_buf_use_size, bn->rx_dir);
> +
> +		if (!skb) {
> +			page_pool_free_va(rxr->head_pool, data, true);
> +			bnge_abort_tpa(cpr, idx, agg_bufs);
> +			return NULL;
> +		}
> +		skb_mark_for_recycle(skb);
> +		skb_reserve(skb, bn->rx_offset);
> +		skb_put(skb, len);
> +	}
> +
> +	if (agg_bufs) {
> +		skb = bnge_rx_agg_netmems_skb(bn, cpr, skb, idx, agg_bufs,
> +					      true);
> +		/* Page reuse already handled by bnge_rx_agg_netmems_skb(). */
> +		if (!skb)
> +			return NULL;
> +	}
> +
> +	skb->protocol = eth_type_trans(skb, dev);
> +
> +	if (tpa_info->hash_type != PKT_HASH_TYPE_NONE)
> +		skb_set_hash(skb, tpa_info->rss_hash, tpa_info->hash_type);
> +
> +	if (tpa_info->vlan_valid &&
> +	    (dev->features & BNGE_HW_FEATURE_VLAN_ALL_RX)) {
> +		__be16 vlan_proto = htons(tpa_info->metadata >>
> +					  RX_CMP_FLAGS2_METADATA_TPID_SFT);
> +		u16 vtag = tpa_info->metadata & RX_CMP_FLAGS2_METADATA_TCI_MASK;
> +
> +		if (eth_type_vlan(vlan_proto)) {
> +			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
> +		} else {
> +			dev_kfree_skb(skb);
> +			return NULL;
> +		}
> +	}
> +
> +	skb_checksum_none_assert(skb);
> +	if (likely(tpa_info->flags2 & RX_TPA_START_CMP_FLAGS2_L4_CS_CALC)) {
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		skb->csum_level =
> +			(tpa_info->flags2 & RX_CMP_FLAGS2_T_L4_CS_CALC) >> 3;
> +	}
> +
> +#ifdef CONFIG_INET
> +	if (bn->priv_flags & BNGE_NET_EN_GRO)
> +		skb = bnge_gro_skb(bn, tpa_info, tpa_end, tpa_end1, skb);
> +#endif
> +
> +	return skb;
> +}
> +
>   static enum pkt_hash_types bnge_rss_ext_op(struct bnge_net *bn,
>   					   struct rx_cmp *rxcmp)
>   {
> @@ -380,6 +751,7 @@ static struct sk_buff *bnge_rx_skb(struct bnge_net *bn,
>   
>   /* returns the following:
>    * 1       - 1 packet successfully received
> + * 0       - successful TPA_START, packet not completed yet
>    * -EBUSY  - completion ring does not have all the agg buffers yet
>    * -ENOMEM - packet aborted due to out of memory
>    * -EIO    - packet aborted due to hw error indicated in BD
> @@ -413,6 +785,11 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
>   
>   	cmp_type = RX_CMP_TYPE(rxcmp);
>   
> +	if (cmp_type == CMP_TYPE_RX_TPA_AGG_CMP) {
> +		bnge_tpa_agg(bn, rxr, (struct rx_agg_cmp *)rxcmp);
> +		goto next_rx_no_prod_no_len;
> +	}
> +
>   	tmp_raw_cons = NEXT_RAW_CMP(tmp_raw_cons);
>   	cp_cons = RING_CMP(bn, tmp_raw_cons);
>   	rxcmp1 = (struct rx_cmp_ext *)
> @@ -427,6 +804,32 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
>   	dma_rmb();
>   	prod = rxr->rx_prod;
>   
> +	if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP ||
> +	    cmp_type == CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
> +		bnge_tpa_start(bn, rxr, cmp_type,
> +			       (struct rx_tpa_start_cmp *)rxcmp,
> +			       (struct rx_tpa_start_cmp_ext *)rxcmp1);
> +
> +		*event |= BNGE_RX_EVENT;
> +		goto next_rx_no_prod_no_len;
> +
> +	} else if (cmp_type == CMP_TYPE_RX_L2_TPA_END_CMP) {
> +		skb = bnge_tpa_end(bn, cpr, &tmp_raw_cons,
> +				   (struct rx_tpa_end_cmp *)rxcmp,
> +				   (struct rx_tpa_end_cmp_ext *)rxcmp1, event);

bnge_tpa_end never return an ERR_PTR
why use IS_ERR, not if (!skb) ?

> +
> +		if (IS_ERR(skb))
> +			return -EBUSY;
> +
> +		rc = -ENOMEM;
> +		if (likely(skb)) {
> +			bnge_deliver_skb(bn, bnapi, skb);
> +			rc = 1;
> +		}
> +		*event |= BNGE_RX_EVENT;
> +		goto next_rx_no_prod_no_len;
> +	}
> +
>   	cons = rxcmp->rx_cmp_opaque;
>   	if (unlikely(cons != rxr->rx_next_cons)) {
>   		int rc1 = bnge_discard_rx(bn, cpr, &tmp_raw_cons, rxcmp);
> @@ -461,7 +864,8 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
>   	if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
>   		bnge_reuse_rx_data(rxr, cons, data);
>   		if (agg_bufs)
> -			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs);
> +			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs,
> +					       false);
>   		rc = -EIO;
>   		goto next_rx_no_len;

Thanks,
Alok


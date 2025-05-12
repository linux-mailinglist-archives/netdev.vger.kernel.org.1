Return-Path: <netdev+bounces-189721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB51AB3588
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D302178648
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D977A277027;
	Mon, 12 May 2025 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mnIhi/mJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bk8YGU+v"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA3275851;
	Mon, 12 May 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047638; cv=fail; b=bO98hrOyLo4jS0Ycw/tAdOZsuEuUioguyVB65xYB71YfpzKknpqnMLbe+UsRZCn0dvoJ/KYTq9D06zbCxRy+ALsKhg1AF0tEeMnWa+DMmKsfoZNO6wvC0Z742Sy1gRbB73ciCzYWNC8yr3uqLxjtHK2Dn0RNKStruWZt04GCyJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047638; c=relaxed/simple;
	bh=NNQWnf3c21RZY4ZEM5L+gFGoIj2sNkaEJSVKAG9G+1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PeB3L+imIYgoD4x6csB5/ROOj5r789drKYHvgOMfUhXS/P4uJsJSs6WvBjgI3ICLqBGb0RJ8rmcopzpuTrUNQgfOHJ/TMsfn/FlvYaCUn0oUE/JPHThn8H0hNbwGAcb6h8V+QOBcwqITjtw67OnY5B1reHaVEzlZTxSOe1gwtec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mnIhi/mJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bk8YGU+v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C7g2ms011633;
	Mon, 12 May 2025 11:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZbOoBouD4ZjpnfBKsRI4ONC4fcvOw/0nraatEBhgRNY=; b=
	mnIhi/mJTqs4ZaRPhODIWWr7ekfNEwIMLjYFF1RxrHaQSWI5Gui8Qg5kR5/lGFon
	kgHmGpy6dD3w74fawHwvnaqYT5mL0sxB9zOpkSYX7rrWOtlUUF9J8NDoXJ94f9vL
	lWJU5o/oThLmJNJA/cnyMG4Nrrb3rCZ34SczE5X/dz+Hu2qcuieb6u/pcbKV/r4c
	XUl6d3g31CkvPUXVUeVGh9dN29PaCprOFEl3QZreHycOvH1KSSLT4b8Uz4WhCyCq
	u9Emtn1VViaY95QIdV6v5dfsBDPGs/xvLzo1qvrYrGgs4gx9eCamAwsGiOno+tyZ
	pRQ5xF1Nm5/SXN8dEyLlvA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2a56v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 11:00:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54C9he5c022248;
	Mon, 12 May 2025 11:00:14 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011027.outbound.protection.outlook.com [40.93.13.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw887ud5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 11:00:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ+JMjt+8120t3cNQ6tOdqazcdDM4ZEt6Dj8wIlq1DLG4i3ms9yqLItbhD8PutGdkjkeS5/TnKetXK4tsW/xFKHCAu7Afe9uhz5QIjcQanMXRJD5KFn0BNXMPDfsGkayzSSGmYICj2Qa1OowOsAAZxzE+PpsfCDkQ/C4Eo80FGYsV3GVpqNJ7Q/MRS0KKZN1CHbvgK1Yu5n6Hb+rlvICWQKLl836ONeVBUrIlSgNrE5dF8461aKzN1A2rG6vnDHNjWQzFAKjdkhBElUQCgfiLsQNMj2hRiSjj482rw4LdA5ovKyf6D00iYHx0V62aRbZIFkZD6jt5nRHJvpLconoyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbOoBouD4ZjpnfBKsRI4ONC4fcvOw/0nraatEBhgRNY=;
 b=ez4ZjhVOfQELSXrgewule5eXUh52lPdTefKgtJo+MNS+zyAq7WX0R6fzptA/Sq967B5n8ATVWEn5Whm5mStkVoZrkaIuGE8J8sunl9gDgvrC8ZvYdZT9ivD8j2Mt++6NWv+N50jixc7uZb3RbqayL+1A5gHIiiVkqxsSCWJQwFy8n6KkH3ODG7rw+BiTmaHvAPIpo6SsDPJ0XXWIXdTGEBI/Yifij1glgoNdK9vc2mEHHsOXxy616cXoAKTMAhWU9OEof7YULeX37DRGir9sw8XGsE1YWjNGeIc1dcfOTUs7I3qbQEyme4vpC/tdb9O3vY31EmRkLDnJe+/SZj8ZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbOoBouD4ZjpnfBKsRI4ONC4fcvOw/0nraatEBhgRNY=;
 b=Bk8YGU+vPQD95EMk47JpTaI7UyCjbnAUl8fz6WU13YW/HDwqX9ks0wjdyVAKi+y4IFvjjjyCFA1xEXJNmiSXLOlH3X50mEJGGji1izn/7vu19PhhgZUwDD9RiX3+VUxUUn64MuKhagoe5e7qdeI+yo7Xf+uKwToJoAbQaqEYwMs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7310.namprd10.prod.outlook.com (2603:10b6:208:3ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 11:00:11 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8722.021; Mon, 12 May 2025
 11:00:11 +0000
Date: Mon, 12 May 2025 20:00:03 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        Vlad Buslov <vladbu@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the
 percpu allocator scalability problem
Message-ID: <aCHUs55069p91eD7@harry>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
 <lr2nridih62djx5ccdijiyacdz2hrubsh52tj6bivr6yfgajsj@mgziscqwlmtp>
 <aAtf8t4lNG2DhWMy@harry>
 <vd3k2bljkzow6ozzan2hkeiyytcqe2g6gavroej23457erucza@fknlr6cmzvo7>
 <CAGudoHF4Tj+LcMSEZK3H3TF0Xc2xzf_NWro3ghXddOwVHNRTuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHF4Tj+LcMSEZK3H3TF0Xc2xzf_NWro3ghXddOwVHNRTuw@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0073.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::6)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e49960-00bf-401e-00ad-08dd91442a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUlscFBWdXh3VFM0ZnI5UGExOWFCclo4dHNkNTNWWVZabEtFSjhvZE1aNmdW?=
 =?utf-8?B?c0dLd09RRUY2dE12bVhEdDFpSURCNFViZ0E5UUR0WVBaK01QRG9QL2hSUWdF?=
 =?utf-8?B?QTZWaGdmRUdHbmVLWUV5bmFmMnI0ditadVhQaDRHc0xYa2ZnRFVWVUFRdFlE?=
 =?utf-8?B?Sk1KSGYzcDN2eTFhRUdqN2FPNm05RUxLczlpaXpQWS9WTGtGeHY0dE1wNkZL?=
 =?utf-8?B?WFRKSG1KT2RucGUrU1NQaTdvWU9ueU90WGtYNE5QeHNVYmV3eGtmRVFBT20w?=
 =?utf-8?B?YWFOYnc2Z0RlbitqN2tKN1VkN25BT0ROemRYMW94YURwenN4OCt4RDk1dDhw?=
 =?utf-8?B?ZFRra3pidVNpVHRnUXVmK0g2ZlJpUWowYUZNSFdIcGFnQ00rZExBQTl0TWgw?=
 =?utf-8?B?cHBvWG16WEsrTk40ZnFwY0tUenlKdUpLVzRTZUF3Ukx6bElFMnc0UUUxYXZ4?=
 =?utf-8?B?cldzQkFxa2hRS1VrVWVxVlNGaDJYMEpzVCtham1TV1llWlpNWG1RYUthUEF6?=
 =?utf-8?B?dlAzMGlNOVJzdTBQQ0V6N3U3QXpCSWVRUWNBTnFoRW1uRWluMUptV1R5RFEz?=
 =?utf-8?B?VW10azdtQ0Q2ZU0zdTBXbjJWQW04K2RyOUVLcXZpUE5saTFXY0lOaFRKL1Qx?=
 =?utf-8?B?Q2Zya25zNktPc2o0VUpqd0g1R09Qd0dwdTdXVVF5ME1CVEdTZUYxTzg5bi9G?=
 =?utf-8?B?aFVCSkowYkFYdlB1Y0RnaCt4QVBOZHp0V3FaUW85TnJlZjlackVrdkkzUkFj?=
 =?utf-8?B?Y2tuNDdnU0tidkR4RWcxb1pJVGlMNUZBa2FhaGZZZkxhalpuU1lVckdvZEhE?=
 =?utf-8?B?L3FlREhweE9qZXd6eGlZU3JhN2IxaWU4MmNUQ3YxQTNmLzRsMFd5M3JDc1k0?=
 =?utf-8?B?RFpGaFZYcE5wV0ZhSEczMnptQ1VlMjkrNjZFMm1VK0w4MkthZmk2bjNoT3hS?=
 =?utf-8?B?MURhcmZYQUI4ZEJKT2VPeGM5ZGFOMjFMR2YwZ1ZGMmI4UGY1VDc3N09Zdkoy?=
 =?utf-8?B?REdJRlpmK3NBZ1NnVEo0a1BTa1F2TTdBSUVMbGQvaUdOU0tOblBXVzBoRWtn?=
 =?utf-8?B?dEl4TFRBWWg5SDYyTGVrN05CeE9zdGlxMy9NbjJvNTFsT3gvK05RSllVUVE3?=
 =?utf-8?B?S2FFcHgvUkcrdmFwMmFpTXoyZjhCYmtXY2RIRlFVaWFpVnZUMnk1eWx5SVo4?=
 =?utf-8?B?by9xQ3pXQjJibm56Y3EyVFBsTEFCbDVoNGtjcTJuY3B3SHArR3JGWTZTWlVS?=
 =?utf-8?B?MXlKeGVPYnRhNm5iSDlxbFJzd1NXM3l0N05YM0VTSXpXTEpLZW81S3MrWnVG?=
 =?utf-8?B?WU5uWU1jZXJ0TFBLRXZMdDVUTEdHMW9RZklIaTV6NEVkanE2alVUWUY5Zzc2?=
 =?utf-8?B?cFF1TmdhMlJyWTdTdjJoZnowK1VjdGQ1dHg0NERKcjFtUzVDcEFFVm13ek51?=
 =?utf-8?B?UU8vNTJacmVuTEhYRmM3UGRSK25OTDlIcUgrUk0zYldabDZjVFhwN21yQjZN?=
 =?utf-8?B?ZXJQR01abFgvRXR6M2dBL2dJekpYNWJ2M1JnclpCTDZYUjBTV1I1ZElTaVJ6?=
 =?utf-8?B?dWRYWkJFeFZjQjg0TUQ5bDNudTY2dUVTZFlpWFFjbTN4OUJwajlnTjZidEpG?=
 =?utf-8?B?TkptNGVWU28xcVhYWkVNbERWbGR6d3YvSGNrc0Fqa2FXenB5TXMvUVJXOTBs?=
 =?utf-8?B?aG9tNDRraVpkV3FmV0lzVmlpeHZZWnJUaldxQUdkOWFYNUZQOUtZdVp3aDdQ?=
 =?utf-8?B?eVpCRnFJczlydjY3UXdhaWFsTDRPVFdDUFJsYy9KUXdYQ2RsVEh3MkJrTWZN?=
 =?utf-8?B?a1F3UGI5R01ZaW9HZTFmb3hpYnIvcUdqM0tCZm15YzhxVXp6SFFrN1VTblNr?=
 =?utf-8?B?NktiSlA2ekFwNnoyTmhrOEpoaU5QMTJTaTVaU25kSUNmUjdndFNHZzRZNWVo?=
 =?utf-8?Q?WceseFXMXb4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTlJRmxnNG54Mi9nVGc3eXE5cmw2eVpoRklUOUpRUllPMWdCWDQ3cXkrOVNi?=
 =?utf-8?B?YXZNRmZVRVprNDhQdStaNkt3TzhYMmp0VlpCNVd2L1VpSCs0M0lmUVF0a1pY?=
 =?utf-8?B?RlRyQkpDSjl1ODUyd3VaS1Q3dTM1TGhRQ2NBbG8zaE1ZNjU5Sk9RTUplWFI1?=
 =?utf-8?B?SmpOTXhxNTduWXh4cituWjBzVmpVc1pGQ05BMTl3QllCZWNwakxXQTl3MWVk?=
 =?utf-8?B?K1h1NEkrMFZsMjc1Y3JtWkdUbmV6RFhsbjVSQThNeGFuTnByYzB3NUV4c3o1?=
 =?utf-8?B?bEQ0RVpxdFBjQll4eGVRQzRMdVJBcXRFbnNqMHRVeHRQUnZDdjVvTnE3eXE4?=
 =?utf-8?B?OHFMY0JTY3k4UXhObGFudlhiWWpxTUVSSktrR3pzRkJnYmZVMDdFRFR4ZGR3?=
 =?utf-8?B?ZzA1RktJRmNKMkp2cTdhQnBoSHAwMFEyckhmWXNSNmo3L1dmanFuR0NkbDVu?=
 =?utf-8?B?citSWUR4M3drdVo2b0tKSWJseFAycHorejBIL2NMMFdVZ0dwTlI3bnhRN2Fp?=
 =?utf-8?B?UlZvd0NheVN5RFhka3NzWHIzT1VsOGtpakNjdDUzQnIxKzZmTkRBWnA1eWo5?=
 =?utf-8?B?a3gvRVhvMjd2eFRvbHkwUDFaOFRkV3pVOFJtMUJWMkhmNjgva0tIYlQwaXE4?=
 =?utf-8?B?U1NOOHJSK29iZHBSQnhTQUR2bE9lVEsyQ01ONkx4dExxVDkyd0JJK2YrRGRN?=
 =?utf-8?B?d2UzYVduRS9LVWdmS0RyVExPU0NXcWh5N09NMmNxelk5blVibkhQeWQzQUIr?=
 =?utf-8?B?S001Qk94ZFplM2pScGpnekV2a1lVRUxWNFl4RDlXZTQ3bXIwckhhekIzNVVq?=
 =?utf-8?B?d2hHMmh1YlM0bEdOZENkNG56K0REMm5Eb2ZEeCtTSzRhOTJNcWlYUEJwbzcv?=
 =?utf-8?B?c2Q1Mkx3TDRCd2FaZ1ZJbzd3MG9YMkY1Wm91YTNxZFZNeTFoNThwWk40aSsx?=
 =?utf-8?B?NjVMT1NwSkE3NVg4VVoxTGJ3UTFkNTJSZ3FQcWJsSDdsdHJDL3hqWXVtSkVB?=
 =?utf-8?B?eko3N04zTGkxN1NxTWh1QUtVVlU0dzU5dFpQVm8yRkZ6QWxlSGhtMjVvK2Yy?=
 =?utf-8?B?RlF2VFIrK1dWMUpuTHVYbHdvTW92ekFqWkVUZ1g4U3BxeGdvOEZnbmZ3V0tp?=
 =?utf-8?B?NmpDZTRPWjQ3UFJZa1FNcGtTNTFaemYxajFMR0tadk4xV05xRXpSOFdsY3p5?=
 =?utf-8?B?azBDaEVBRGtBY3RFek05dmJHU0VENUxLM0hMSEVyc3NFak9OcWY0YWwyblBl?=
 =?utf-8?B?ZlZEQXlDNHNWZFMycytwaWs1MXFNaFNHZEVoTXUrMzE0d3ZWTE1lOEJSY1A0?=
 =?utf-8?B?SUIzVHJXSFBCd2NJTlBNVHkwZ1cvbkZONW9XbXhJWlFqcFY2NTU1RUwwUi91?=
 =?utf-8?B?Tlo2Q0E3ZU02SHUzMnNvWS9YTlBzeXZFMld2N2lVTHAzL3RreVdubjl0L3Iw?=
 =?utf-8?B?ay9IS3RDQTVSZDhlWS9lVHpEQVlXUkxGYjRDalpuYjNQV1JFUkVQMDlyKyth?=
 =?utf-8?B?MlBUdnltb1FkYUM4aVJqVzFJRjBONXhVeXpUbFRxbGdiamoySjRndFFmVEo3?=
 =?utf-8?B?U0ZGNDBIQkd0RXM1QW80ckdaTTV6NjIyOTBUMnM3OUQ5VE03cFllMS9FZlYz?=
 =?utf-8?B?RHpFZTI3UGtBUWZQYjQ3dE5xOERqelZFVVEvbEJsS050VjZ2d29BdmpsaFZ5?=
 =?utf-8?B?UGgwSndqMTFJbkJvcndOK1pNc3ZDYjBtZ1d3c0t0eGdtajJESlpoSXBWLzJ4?=
 =?utf-8?B?MEZHQXc2VjVEdjhEd3JxdlNWdXoyVGZ6L2VnaEhKR0I0UnNsbSsxbUppQlBM?=
 =?utf-8?B?eHJRbkF0bExsZmIyekhuK2c1Zm9oZjBRYjRvMGFhNkk5dG03VmszdmYrdzRH?=
 =?utf-8?B?a2xKQ21SZkl3YVFFRVRpclo1NXE2Vi9QNEZNT29PMmdXT1dwWVlEdFE4T0RY?=
 =?utf-8?B?aThDeHYwcGM2a2diN3U3LzJRZlZiR2JBQ0taazIrTGExaTQ3NGpWTUoyMWFu?=
 =?utf-8?B?S3Z5RmdFUU5lZTlnc09heE9nTW5kQ1ljUWdncTZQdEZYdEp0d25NWmF2N1hk?=
 =?utf-8?B?RFYrVlhjWVFueHFGcGxoNFJpMUdCYkJ6RzhqM1RyQXFBb3ovOHFwQUkya2xz?=
 =?utf-8?Q?TyPizRzO5iSCo8c+AP26rUeNu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FMmJ1gP9xRHNxY6UxnJmATDydpj4ZkLgE53W54HGkS4/Zs1GJwZXplFoXa+1lzTtlb0benh5+eoADwLI3ZjwRYUUENhr+lyvwvyR3mMcRmitDnSZT3sMhuQZMK9IbL6wL1CCYjLsIc2InHCq5LDqfmCaf+SZNqCChNKP38TezJFWa7IAmaowZPpr/AUzeA/FHeRjSsady39Cg14Ct4xlJztskodY+aV9DCTyE31FmCWMIzt0OgpTjYAXR19ceabHwvjAPoHbJNakSIxKH21AqZfKhhavlb20cqZQH0HGf3emYNVh/Meqzjl4QS3WaZEe4Q9I/deElYD2nqhVV1+ig2YV+RsRgSaQMTHYspVgVNGNold8lylw7rHqhm8wGH56jPen3a6YOf4LNiSOVjWmiLcCR/ZHtV1tk5LZGrTzIUdUmdRQ+thuNyKzA5CrIvAp7SVZHqG0wwQ/Pe9tDAfX6f20edBnqplKgQ5WMCWUJ0hK36d0taJVHIQ7wRfW6NnB3Q+GaEYEU9PjRydyadd7oPc0XVnj1+vOGsd5ui7ffEeqGQ6KIcQtDUOYX+6dHTXlgnhUYF4+dfZxqV7HL6KbijhWmu2Z+hUT7OwFDHWQCYY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e49960-00bf-401e-00ad-08dd91442a68
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 11:00:11.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bw9s+J/AUXflXqQRdEij0qR+vH/KfVrR1x9XCA+lQLXP+DCkJT+se0uvSk4d7OosjLAWJwJ7/Hjwj5ariEeW2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120115
X-Proofpoint-ORIG-GUID: NXpA9Sl6PQcuJROsatjOsxiPIpIKAnZI
X-Proofpoint-GUID: NXpA9Sl6PQcuJROsatjOsxiPIpIKAnZI
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=6821d4bf cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=nE6Grsiroox64J973sUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDExNSBTYWx0ZWRfXyauFsGrvHhQ3 q1o+pMGbhiwPQZz2Ukxd+vozCYHvGytYC7TIvlmIB4muBgsQNMd1Hxy/Vcc0pJ7Sah/m8vb/KWE ej0lXYbiyl7XScOurMYsEviRiK/xIiC31TD5Vzc95Y7a3SDft/o7yR1XP1VSJdZle+5jX3wwR8B
 0gGO7pem1BDneyEFm/fsSOD2ynhE8ViMkdiO27Z8FO7gY/gkanmOliYRcp+I7RjThGEyDJnmV1J aD5oLyA4VjJVN4GbrnBYs2PVsFlhj6cF4+fD7hoKV0h/tSI3xeg4i0UgQXlUo0XE4O+JKk63WhA GIFs9dT60JETmAf4hrgxvsOukf2tqSgn490DexfLs9ABhCaZxZZHG0qMxAVywj4rREVpxVks44+
 QM1ixGHnkhKrwuH6cQk9Z9OfCTRYlQ/7gjkkI9MJwfL3vdNhlqhLzRQ06GSrwWdQFOO0StNC

On Wed, Apr 30, 2025 at 09:49:02PM +0200, Mateusz Guzik wrote:
> On Fri, Apr 25, 2025 at 12:42 PM Pedro Falcato <pfalcato@suse.de> wrote:
> > With regards to "leaf locks", I still don't really understand what you/Mateusz
> > mean or how that's even enforceable from the get-go.
> >
> > So basically:
> > - ->ctor takes more args, can fail, can do fancier things (multiple allocations,
> >   lock holding, etc, can be hidden with a normal kmem_cache_alloc; certain
> >   caches become GFP_ATOMIC-incompatible)
> >
> > - ->dtor *will* do fancy things like recursing back onto the slab allocator and
> >   grabbing locks
> >
> > - a normal kmem_cache_free can suddenly attempt to grab !SLUB locks as it tries
> >   to dispose of slabs. It can also uncontrollably do $whatever.
> >
> > - a normal kmem_cache_alloc can call vast swaths of code, uncontrollably, due to
> >   ->ctor. It can also set off direct reclaim, and thus run into all sorts of kmem_
> >   cache_free/slab disposal issues
> >
> > - a normal, possibly-unrelated GFP_KERNEL allocation can also run into all of these
> >   issues by purely starting up shrinkers on direct reclaim as well.
> >
> > - the whole original "Slab object caching allocator" idea from 1992 is extremely
> >   confusing and works super poorly with various debugging features (like, e.g,
> >   KASAN). IMO it should really be reserved (in a limited capacity!) for stuff like
> >   TYPESAFE_BY_RCU, that we *really* need.
> >
> > These are basically my issues with the whole idea. I highly disagree that we should
> > open this pandora's box for problems in *other places*.
> 
> Now to business:
> I'm going to start with pointing out that dtors callable from any
> place are not an *inherent* requirement of the idea. Given that
> apparently sheaves don't do direct reclaim and that Christoph's idea
> does not do it either, I think there is some support for objs with
> unsafe dtors *not* being direct reclaimable (instead there can be a
> dedicated workqueue or some other mechanism sorting them out). I did
> not realize something like this would be considered fine. It is the
> easiest way out and is perfectly fine with me.

My concern is that this prevents reclaimable slabs from using a
destructure in the future. Probably doesn't matter now, but it
doesn't seem future-proof.

> However, suppose objs with dtors do need to be reclaimable the usual way.
> 
> I claim that writing dtors which are safe to use in that context is
> not a significant challenge. Moreover, it is also possible to extend
> lockdep to validate correct behavior. Finally, test code can trigger
> ctor and dtor calls for all slabs to execute all this code at least
> once with lockdep enabled. So while *honest* mistakes with locking are
> very much possible, they will be trivially caught and I don't believe
> the box which is being opened here belongs to Pandora.
> 
> So here is another attempt at explaning leaf spinlocks.
> 
> Suppose you have a global lock named "crapper". Further suppose the
> lock is only taken with _irqsave *and* no locks are taken while
> holding it.
> 
> Say this is the only consumer:
> void crapperbump(void) {
>     int flags;
>     spin_lock_irqsave(&crapper, flags);
>     mehvar++;
>     spin_unlock_irqsave(&crapper);
> }
> 
> Perhaps you can agree *anyone* can call here at any point and not risk
> deadlocking.
> 
> That's an example of a leaf lock.
> 
> Aight, so how does one combat cases where the code turns into:
> spin_lock_irqsave(&crapper, flags);
> spin_lock_irqsave(&meh, flags2);
> 
> In this case "crapper" is no longer a leaf lock and in principle there
> may be lock ordering involving "meh" which does deadlock.
> 
> Here is an example way out: when initializing the "crapper" lock, it
> gets marked as a leaf lock so that lockdep can check for it. Then on a
> lockdep-enabled kernel you get a splat when executing the routine when
> you get to locking "meh". This sorts out the ctor side of things.
> 
> How does one validate dtor? lockdep can have a "only leaf-locks
> allowed in this area" tunable around calls to dtors. Then should a
> dtor have ideas of acquiring a lock which is not a leaf lock you are
> once more going to get a splat.

Similar to the concern above, this would limit how users can use the
destructor feature (let's say percpu violated the rule, altough it
doesn't appear to, then we would have to modify percpu allocator to
conform to it).

So I think the most future-proof approach (as Vlastimil suggested
off-list) would be to reclaim slab memory and call dtors in a separate
context (e.g., dedicated workqueues as you mentioned)?

But before doing this I need to check if it's okay to increase the nr of
reclaimed pages by the current task, when we know it'll be reclaimed but
not reclaimed yet.

-- 
Cheers,
Harry / Hyeonggon


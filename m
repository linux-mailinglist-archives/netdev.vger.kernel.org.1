Return-Path: <netdev+bounces-186327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB11A9E5BE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 03:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8AD7ABDC6
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 01:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6416E6F53E;
	Mon, 28 Apr 2025 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q23x2mXc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W2jXfML6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F63208;
	Mon, 28 Apr 2025 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745803560; cv=fail; b=sqTj4QZUYkdoVv5unhQfqXzBhMStwGSWASZU48g2LpH1XN7aF/8TXB+avo+kWBVLsebgRZziKOvME/o874jFzD4CBTkSLIvNnwp9PXall0e31L6Ob8lOf7WebyqYgz9n3bFe1vAyfq9eLyy9U3CqekF+H5VW7pPUC1Z+YdV0pGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745803560; c=relaxed/simple;
	bh=HTW5jVm7XLWX+LPK9Y49BjiADLgg0muEtGXtHJZDMMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hi8geb5ssqpxzLcXEq824yAsZhPoQwLHtB700sNO7UfsG1dUl8XVw5cq+mEIQet4UR8yGtxfITJppo5fSYd2YzNSewwaY9utoQ3ZVk8fedYlm/+FCxrwlEYRueC1/lvP3UmWTAblMovba2Dq318GWHe8wNk1yvmZwhjX98mAW4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q23x2mXc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W2jXfML6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S1Gtp3026384;
	Mon, 28 Apr 2025 01:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AE5fN4qTLSaNmqvLdfe4ShrLZKGgRNyiBIIye1Wnq00=; b=
	Q23x2mXclRubwumP2b1c4UZ/j7dHQFpNH30g+67Ed4F9NImhCQkfUbC9ximzjx3X
	vcU15+qr5ALRbLCA7Bo2ZUCCFBsEjNRolUaSPqYDJ9l3qlqTIY6tXvwhsmwK5JiX
	A4JkiGO9nQ4smPMzWhqlXODzfJLRcm5gAK0P1jmy5b/oeP5pjuLLWNnhR3JXPJSV
	naWHySXfcQitQzohmrqnRSRb2+llcOs5yyFnVmq9Fzzdj+hfXAfqxXRP/Wxx8AjP
	z1PZ4LZfrwf+s4CmWOwLDBh0Sdai7FI1KmtPke0JLyMuTSM84raIdgnOx4UEYmeM
	g0yj3CL1Zr3l+J3BF79Aeg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 469yvd023t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 01:25:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53S0f5Rd016118;
	Mon, 28 Apr 2025 01:18:47 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8a1mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 01:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrN86aoHSE7Py8mSYG/6AROy6vjRDKy8FgMHfW4yFwVgTDG+vjz2Jk4dkokkyqR00AblZHdUUVxr+ELjnc7bHZOxLIkFDYHhRXN0sRi9hbFxrr1AAE1qo3E9eb4N6pfQcHn2umEoE8VNDVwbQyQPzZ9RC87ZL4XXD/SLs/DlbVBZzIPG/Anz630MjqyhlZv2Z3+eC1KMYHQeZ8UMieY/DXCTnYzjstZ9Yd/+xvXbPvU6I8TRyo/eVQFfI509+LIEvZ5l3r5FyWK1UZIeLZsWi/kLjVD5JshElU5OMsMeAVge5rHlvnKq3FKrFbD0dH9TM4e3kfX8lHVUevfbNwn1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AE5fN4qTLSaNmqvLdfe4ShrLZKGgRNyiBIIye1Wnq00=;
 b=cs4e4XEvNXFEmuUhK1OA89B5iIfiLxeDEEp4JDB+X+J8Sl/XXVh6CJ9bXTZqq9w3O+cawHD7C2zl0pcpLLC7h+NIcGZ3Nafshrl0prnuOJI0BbsxeIKBxPAKgaHcHvk/yJApkgD9F6gCjFBgDYNCxJShbH3xr5ILb3QkXioHwizKAl6skgIo4388hvF8wyWjBvDMR3s7kd0YxCysPU2IDWk+WICTbrn9TFflShLCyW9kj0diS9VG5dZjHqTGLfHnEFH5HoqVCvVggiBcl/xjx8TQhg7OP6Y80wPYBI4EDU7BdtyKIQbkRimAHyagRQ3DBqtj39AiOrb1UNKUVHBxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AE5fN4qTLSaNmqvLdfe4ShrLZKGgRNyiBIIye1Wnq00=;
 b=W2jXfML66YsOPozwuIJK7O3pcezIqsSxxKsBtCXumCvlnTMCy8TIFZFYST99ES98jenj88YU8UjcZGB0LGGw5GBSe7z+XkhMDDKS0En/3dLzFBvy7TenbwvU3LPZVOutaOPxGufsM4tVvnHr0OovFgy3K924KVohD7ykIJcOTnE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7433.namprd10.prod.outlook.com (2603:10b6:610:157::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 01:18:42 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 01:18:42 +0000
Date: Mon, 28 Apr 2025 10:18:34 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        Vlad Buslov <vladbu@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the
 percpu allocator scalability problem
Message-ID: <aA7XagXweCLdATTH@harry>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
 <lr2nridih62djx5ccdijiyacdz2hrubsh52tj6bivr6yfgajsj@mgziscqwlmtp>
 <aAtf8t4lNG2DhWMy@harry>
 <vd3k2bljkzow6ozzan2hkeiyytcqe2g6gavroej23457erucza@fknlr6cmzvo7>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vd3k2bljkzow6ozzan2hkeiyytcqe2g6gavroej23457erucza@fknlr6cmzvo7>
X-ClientProxiedBy: SEWP216CA0050.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d79f1ef-4c49-47b4-e2e0-08dd85f29ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUpzV1FPMG9WV2pPQWtWeXAvMCtGdS9ONTVPTG9YRm9ZVkt4UEJwYnh5OXcx?=
 =?utf-8?B?TUR2NGJ5czdmaEpWbEZjcDlwMXZha1E4bVBlaGc3Rk4zS1Rvblg2OEtOWC9M?=
 =?utf-8?B?akk4bktBeFdRWHJYMnlISWlLdnJDZEh6cmpLRVBTbmN5TzBwSjVpUXY5T08v?=
 =?utf-8?B?WEVONHJzNUhCNG9VVVlUcW1PQnlCR0xpZC9sU0N1RHUwd2R1dWZVQWtQWnJL?=
 =?utf-8?B?STFNb0dTcDJZbmcwMEVyTW9rNFhzS3RpNThNZEljeWZOYkl0MUp6cE5ZWCtE?=
 =?utf-8?B?bUJuZW5HK3pqQzdnQVg2MHNodzNYTzRUMXRtK29ZaXFNTUd0TFJKREprRnN4?=
 =?utf-8?B?MDJjTk4zLytIcDhNM0FEaTllSXA4SzFNYi9ScVJ6MFM2S3BDMHowR21LeHBT?=
 =?utf-8?B?U2F6eWJ1SDVGQzJZRXhEODhGc01JVVpmMEVjbGdoRDVRVmlLREd0elVjNmxh?=
 =?utf-8?B?WHk5OGVBQmp5bVFlZmRiUlNqWnVhQnFXZ25TOTRtbjExNVJWcVJXbVNocksv?=
 =?utf-8?B?bTk5SW4zQ1lIRXhNd1crY1piOVdCbXNTejlUK0pqUHBQeDBKNFFqZmpSWkpY?=
 =?utf-8?B?YUZ3V1BXNTlGNENSWlRuUlV0eS9DSmxQcHVPYS9nT3hmRjhyN3dwVU9HdFh2?=
 =?utf-8?B?M2RudTRyNU1OY2JlLzJJamRyVXRDMkRsd2ExcVF0dEhYcTMyeHp3djVjd3I0?=
 =?utf-8?B?QzZYZmQwK0JnaDBjdnJrR3c0Yys4a0Q4RjNja3lCVk1yUHF5MmFYeExaRVhL?=
 =?utf-8?B?RTl2aFh0cUpQeExQR3JxVlRJNU9HMlA2cHkwL0N6MUR5RkVRRFQ2NGpDaWg1?=
 =?utf-8?B?dzRGSGpleFRLZGJ6TEE5THBJaWFLSzVYR1paOXN6dTV2aVdPbjJsOTI5WFdn?=
 =?utf-8?B?RzdwaVFvOWRmYTRhLzR0WHNmVlh0OWdLcnpKQ0JDR3F5WnRQQ2hrOGVUak84?=
 =?utf-8?B?V000dS9wWjRRSHNEQlpicEpSd2EzbWg0amZGRDl3SG5ndmZJMFRPNmxHc2ZZ?=
 =?utf-8?B?MTRhU2RnNlRwSTRWOWtoM2VtbVN0SEdvVkpEUDgyK2pHQzZoTlY1UlF1UEtU?=
 =?utf-8?B?a1F1WFhWajk3QmFSeW82N0s0SGxIOUVOOVNQRHYyTUJ2S0JBSXRQZmoxbHY4?=
 =?utf-8?B?d1NDOTMrM25tQjVvTXE2TnRvbVY1TDg0QzlkUEw0N0VEWDhVUUNqNm4wcHdX?=
 =?utf-8?B?QVg2YldNaVVhSkNoeWY2c3MzTzE3aTBIakgvdkpXMTQvNlFGY1ovbHZNYSs4?=
 =?utf-8?B?WTBUV2RjUnVGQ0pjZDRqRXBpaVY2QWhKWWJIeTNvQzg2cWNKOHR5NXpNdFl6?=
 =?utf-8?B?TlpUUmx5em9CVWhTVUl4UVNYcnQvdFBOeXlsaXdhTFF2aWF5SXJYaVlGVmw0?=
 =?utf-8?B?TnZ1dXlxSnFaQmEva25OREpaT0JtM2VMalIyOHd2eW1rNmwrWmpOanB1NEtB?=
 =?utf-8?B?ZzlRd1NscFplcnRzcXZGcEdJUndLT0JIUWJ2VmdvZEZ6UzFZTTZYUFZLWFll?=
 =?utf-8?B?aVJndGJrb3l0UWdRcTRBNEZteWFPV0pTb3Z3N0hDNHFNd2pjb243VU11YlVH?=
 =?utf-8?B?NTF5SHVabXVFMnhaNWhUdHZLK2xOWlIyaElWOTZoK0ZCb1Bjd0YrKy9PMFBQ?=
 =?utf-8?B?bzFQMno3SlFOMGdxTUl0Y0dON2VyS3lvWXkrdjJ1dHM2djd5dGhNNzJOSVlu?=
 =?utf-8?B?eHY4RkV0RlY3ZGd6aHA1TmUrYmxBeHd0NnlsMTg3d3MxVmFnRGw5N2NwR010?=
 =?utf-8?B?cEdDbTVvQTdHV21lYnNJVHVWVk1BdWp3ZEtLTjVCa0w0Q1Uzb2dmNWJqaE5X?=
 =?utf-8?B?dE9WcEhkYSthTm1OOThKaklJZkxrY1lhK3IzMkJnUTI0YzhWaGhDek5Kemtu?=
 =?utf-8?B?V1dYNFlGd3RKY2FnelgyU1pJSHErOXpMdE4ydkZwUTlPWDA0dGxqcGZBWE5Z?=
 =?utf-8?Q?H/l0Zvnxhgs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCtoaWN5RzROL1NxNjNkQ3NHaGZCRStmTE51eVd4NnBOSjN3V296OGRZaXhX?=
 =?utf-8?B?bUFHZU41ZUpRSUlxQkxpSGt5U0RSQm1jQUhmaEFheVB2WUFPd1RTRVlNQ3Yx?=
 =?utf-8?B?c1dpN0Jzangya2lTRGt2eGNYUVZoT09INDdTWXQvQnNVYklDTW8zNXZUSHIx?=
 =?utf-8?B?bXp2Vml0VVhqSDY0TDRURG0zQ29DWnJyY0pOMFJnWFdXRDJEdVJPT3lDbGlI?=
 =?utf-8?B?VThNalk0OEhIRlRDR3JtSlcvUUdQazZPMm5OcVVDYXFhTUx6WTNjditPdGFO?=
 =?utf-8?B?SDhiQ2RQN3BxQ0NqaUtINlA1L2UrUW95UGMvemgvMjEwUlhKbTI5azlJSTFQ?=
 =?utf-8?B?UXpoclRjcm4wdGw3c1RPSTlBZFYyWDZDTTRTaUhIWkhyZjJmc3NFMnJ6UDBE?=
 =?utf-8?B?L3lFMVVpRlN4c09ZdHBqbEtQL0taQUgrbFhuc09aSlZ0VGRldWNkNTdBTXNN?=
 =?utf-8?B?WEF3SzhKL2xBWXJRSE1SWWRJRGNFZmFlazdNZFdvckY5b2xKLzVadERDYVE0?=
 =?utf-8?B?MmVVNU01MzRjbFFkb01qYmVJTktPNGw2TndSSUZzdnZGdDB4VXQ5L0xhZy9j?=
 =?utf-8?B?VEV3QlJ2UWZwZHhlYzRvN3BJck9vcU8vczVJVytTblNjU3FBZUdVcGtqT1lC?=
 =?utf-8?B?eitxNFlERjdGY2h4eDEzSm0vRGdMNkdWSUVUTFprSVZ6UkpKN25SNE4xOXBz?=
 =?utf-8?B?ako1K25veU44cmhaMW42R0JudmQ3TmJFc3hld3B4THJQQW9CcmQ1U2Yza2Ja?=
 =?utf-8?B?amZrN2l2aVNIRzhZNFBlOGJZT0tRRWdDWnczQ3Y3YnRINVk2VGJOeUlUWmwv?=
 =?utf-8?B?NG43MlNTMlJHMm4zekgrdHp3U1dPeWtvcGxhdHpJNXlLVlh5YWpDMUw0VDhB?=
 =?utf-8?B?ZVRZNkRRYy83c2F6bGordTdQcjR2cFNad3FYc1pHL21jcUUwMGNHeVBZOEpn?=
 =?utf-8?B?OWRXSjJTY0x3WEVpUHQwc0l1SW5kdWF1dXNCUWgvV2x2eWtBL0QxbHloTjNq?=
 =?utf-8?B?dXg4Y1dXT2JnU0NXUlEwODhhNHVxSXBqVGJlRTJwN1h0YzljdVRDQ3lSbDlX?=
 =?utf-8?B?SVZGNnRMNEt2djR1U1o3QjZkU1p0MHRpdFE1TElzR1hRRGI5aC9LS0VLVkFZ?=
 =?utf-8?B?emhKZ2NwMEhMYmVDSG5BVEdXMU43SU1Rc2RpZzBuTU9EeHZUd3duMzZKUTds?=
 =?utf-8?B?SmZNN0xnN0QvWm1qaHphaDJmY3pXeGphUk5zYVkvelVwNVV6Z2dyZkk1Zjdw?=
 =?utf-8?B?aGYwTG5OUHY0RktnRnBWVTJwbUl4UDQ3NjZEWmdsMVdGVzJnQjEreGRYbGFt?=
 =?utf-8?B?cDVjdkRXZ0JMaHZwaituTnZLYURPQ0NWMFZoUlZhRCtnLzBjUno1ZG4wY2t6?=
 =?utf-8?B?NWc3TGFqSWkwVThLM253enFNUzdnc2JzNjBWd3dDdGFKektoTDRacE80d2tj?=
 =?utf-8?B?L3lKZWVySEttVGdYYzFudG45Tzk3Q21LOEg2VXg5cVBSSXcwSXlyRUVtd0lR?=
 =?utf-8?B?S3l2SFdPcnU5TUMxR2duTWJIemJwWVVFZjV4a2dpcjNPN1RsVlp0TlVPVy9V?=
 =?utf-8?B?V1FGcFRxemVCWnhiTjlGZ3oyeWdoUm85T2dXM0lkakZRd2JDNjZTMnRiNGJt?=
 =?utf-8?B?cGgxVEF6MzhhVFJZT0ZweDlOaVdyYW13NFI0SjhmcitDQm5LNDh2QkRXMWNN?=
 =?utf-8?B?MXphUUp5UjBBaE51SHMyZ0dleXdrMUorSW5vY1I4RE1UR3ZtbTFnZFVrVjlQ?=
 =?utf-8?B?RDlYeldJcUI3WXZEWGwySnYvQ3dTcDFFZitORGljWWZSLzNjaXc4emc4d2xv?=
 =?utf-8?B?REhScXFnZWUvcVplQnlONFhzSHRMZUN2Z2xxVWxvTWpsRERST3A2L3B6YWhw?=
 =?utf-8?B?UEM5ZXg5ejFBeWNkd04yOTJlZTd3Wk9ET3lkNTBxVnJnUjFpeVJkNWdJNHBR?=
 =?utf-8?B?Tk5RVENITk5WSTcwOTFxWTNxOVNORXExdHlmVzZkeWlsSjhaaG1SSWVSanpR?=
 =?utf-8?B?TkM1SkNud3Z2ZjBFVUdjRzF1dU5NaWVxNEFJNDRxV1EwMHFxTVpRcU0rQmo0?=
 =?utf-8?B?RGp3ZUJJSmdaZ24rQjgzSExhaU12ZjVvVjVUZkg5b1hZMzVEeGovMDNWL1hm?=
 =?utf-8?Q?vpPrVSRFmV4L/QLafDeIUVsXo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L/syHWSts3MfrmmuV/Bw4Yj85qA0flKmk6lEZs3OBIPB7+l9SAaBXt34Zg7cGB8o3QeDx8oz8yUJi+4YLsc1Vn2887Rpgl6r+Pq1yXMe1lpwU3nsceUfAfutzjYJPMKZwpn9HFmNZrQexAFNHeRMo30+jIBhw+5XVIMKaYZ5G/mLPLnMXzB7hqU7XoaXzsJ+sibujxxGn4y/eRl2EBmqvzjo/Ia2tuf1ZmbynhzIZVPaReachCWbUEow+z6ggnDens0b1LfumMXhaUuB93OMYtpqsahGh+OlOGKkz+yOLAoJYowmgy8JZ19I4W2F1oCgXFKf1UmvdD3GoBLuEOqf4Z+7f5XJTcHXp4zYgHpnC74bxz5bYkD9A7w+Yb2ngK5adw6zIdqucxfmDzql2oTFMzc6i5KQl7azgVWFvlwqC9yvbF6e892alNCAm0LL5Q53XuiXOuUo0Ix6mMyz/UjLfe+xEjsxp3205K0aAshTB9lQTcMu71GTuyCaf1Etph7/ukHjx4gxCinp3oD/ETr4u7lmL6ZZMyBFDAYG95+8gqfFvZz0lZdVPCd+haUwraruNQcrcOMNk4tg7BoZ9Uj9sfOGSN9a4R6gVz0hqPcVyPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d79f1ef-4c49-47b4-e2e0-08dd85f29ce8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 01:18:41.9876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2j1B1b1bhiDNFkOrAqGwRNkJFRnE6Itxjp5vClu+D/tCLO0vcACTHgAi2rPm8Ebz4sdusPVO+EKNJM30mNj3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=893 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280009
X-Proofpoint-GUID: zgoO37x4iqizIFabFZvSG24PkmbWZrAt
X-Proofpoint-ORIG-GUID: zgoO37x4iqizIFabFZvSG24PkmbWZrAt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDAxMCBTYWx0ZWRfX5RBSyT+7q5x+ SthVBUf7fRRWmyonqlgMFWhlXiiie11DyskR0sq+brq+bW5pH+u6/tF64Xk2LKXdQ+LxI27petQ R6p6wOLARCFGhi16sB3ZW2oQ0yJTEIPnAA6VX8jaIfbWUhFge/pTBd7HZTdtVl6jM719G/R3AqJ
 mTaXr22xLyTcR5h3MutBhBIWdkXyLkMhgZYLbzPYVnKxzuTQqEZTR7gMA2vGl84UNMaUoqQmv3k Z2cWiwnEtgtFflbgj6b+88paHSyDdTrlKZ07ndzpRYzY8fBMvBUwoFJxBi9+HSxnQ9w4LhJ73UF rOKWqqHlHuKau3s1VvsL2V3dCU8g3itK3MKxhV+5QD+fUkoAaNWtBxBbAxAiL0cD9DTLypgFuPf xfEDYaip

On Fri, Apr 25, 2025 at 11:42:27AM +0100, Pedro Falcato wrote:
> On Fri, Apr 25, 2025 at 07:12:02PM +0900, Harry Yoo wrote:
> > On Thu, Apr 24, 2025 at 12:28:37PM +0100, Pedro Falcato wrote:
> > > On Thu, Apr 24, 2025 at 05:07:48PM +0900, Harry Yoo wrote:
> > > > Overview
> > > > ========
> > > > 
> > > > The slab destructor feature existed in early days of slab allocator(s).
> > > > It was removed by the commit c59def9f222d ("Slab allocators: Drop support
> > > > for destructors") in 2007 due to lack of serious use cases at that time.
> > > > 
> > > > Eighteen years later, Mateusz Guzik proposed [1] re-introducing a slab
> > > > constructor/destructor pair to mitigate the global serialization point
> > > > (pcpu_alloc_mutex) that occurs when each slab object allocates and frees
> > > > percpu memory during its lifetime.
> > > > 
> > > > Consider mm_struct: it allocates two percpu regions (mm_cid and rss_stat),
> > > > so each allocate–free cycle requires two expensive acquire/release on
> > > > that mutex.
> > > > 
> > > > We can mitigate this contention by retaining the percpu regions after
> > > > the object is freed and releasing them only when the backing slab pages
> > > > are freed.
> > > > 
> > > > How to do this with slab constructors and destructors: the constructor
> > > > allocates percpu memory, and the destructor frees it when the slab pages
> > > > are reclaimed; this slightly alters the constructor’s semantics,
> > > > as it can now fail.
> > > > 
> > > 
> > > I really really really really don't like this. We're opening a pandora's box
> > > of locking issues for slab deadlocks and other subtle issues. IMO the best
> > > solution there would be, what, failing dtors? which says a lot about the whole
> > > situation...
> > > 
> > > Case in point:
> > 
> > <...snip...>
> > 
> > > Then there are obviously other problems like: whatever you're calling must
> > > not ever require the slab allocator (directly or indirectly) and must not
> > > do direct reclaim (ever!), at the risk of a deadlock. The pcpu allocator
> > > is a no-go (AIUI!) already because of such issues.
> > 
> > Could you please elaborate more on this?
>
> Well, as discussed multiple-times both on-and-off-list, the pcpu allocator is
> not a problem here because the freeing path takes a spinlock, not a mutex.

Yes, and it seems to be a leaf spinlock (no code path in the kernel takes
any other locks while holding the lock).

> But obviously you can see the fun locking horror dependency chains
> we're creating with this patchset.
>
> ->ctor() needs to be super careful calling things, avoiding
> any sort of loop.

You mean recursion to avoid exhausting the kernel stack?

It'd be fine as long as ->ctor does not allocate objects from
the same cache (and of course it should not).

> ->dtor() needs to be super careful calling things, avoiding
> _any_ sort of direct reclaim possibilities.

Why would a dtor _ever_ need to perform direct reclamation?

>You also now need to pass a gfp_t  to both ->ctor and ->dtor.

Passing gfp_t to ->ctor agreed, but why to ->dtor?

Destructors should not allocate any memory and thus no need for
'Get Free Page' flags.

> So basically:
> - ->ctor takes more args, can fail, can do fancier things (multiple allocations,
>   lock holding, etc, can be hidden with a normal kmem_cache_alloc;

Speaking of deadlocks involving ->ctor, of course, you shouldn't allocate
mm_struct while holding pcpu_lock, or allocate a pgd while holding pgd_lock.
I don't think avoiding deadlocks caused by ->ctor is that difficult, and
lockdep can detect them even if someone makes a mistake.

> - ->dtor *will* do fancy things like recursing back onto the slab allocator and
>   grabbing locks

AIUI it can't recurse back onto the slab allocator.
'Taking only leaf spinlocks' is a very restrictive rule.

For example, slab takes list_lock, and it is not a leaf spinlock because
in some path slab can take other locks while holding it. And thus you can't
call kmem_cache_free() directly in ->dtor.

'Doing fancy things and grabbing locks' in dtor is safe as long as
you 1) disable interrupts and 2) take only leaf spinlocks.
 
> - a normal kmem_cache_free can suddenly attempt to grab !SLUB locks as it tries
>   to dispose of slabs. It can also uncontrollably do $whatever.

'Can uncontrollably do $whatever' is not true.
It's safe as long as ->dtor only takes leaf spinlocks.

> - a normal kmem_cache_alloc can call vast swaths of code, uncontrollably, due to
>   ->ctor. It can also set off direct reclaim, and thus run into all sorts of kmem_
>   cache_free/slab disposal issues
> 
> - a normal, possibly-unrelated GFP_KERNEL allocation can also run into all of these
>   issues by purely starting up shrinkers on direct reclaim as well.

I don't see that is a problem (as long as ->dtor only takes leaf spinlocks).

-- 
Cheers,
Harry / Hyeonggon


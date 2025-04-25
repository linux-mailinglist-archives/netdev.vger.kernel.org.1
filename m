Return-Path: <netdev+bounces-185888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422D0A9BFEB
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4314A7F96
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AEF22F75E;
	Fri, 25 Apr 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SwA1eVBW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RvAthsQW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D622F39B;
	Fri, 25 Apr 2025 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566873; cv=fail; b=irYMt4hQ2PHDlIK+vleD1tni2HppLxNYL/rU3ouzR7FZvlM63dVC+4ftN8SCO4/Dt67lJbjejFEgahYPVk0Rwji8HvdnP5syay47oBuCMlFwpCSCGFc/FsHbWaGy9+K0dcQxUI5KfYzdMs5mjBbSXjunDqdCNnfc6zl3eqh/pJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566873; c=relaxed/simple;
	bh=WTKyNjugBhn06URfJ3E76o4yoNRFgpzOMqWch1h7WxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=njhpF+6mpU+lmEURVe9bNnTzK3N+FtIjM88h6kY2JJQrc1GKlVduNtz73hUji1428maEabpKwk6gCbRr51d0d2H/Viuo4YzreD/Ow8O1FNcJV1tmW4NwH6kfmnVXPtOAeZVoEbTwVqO31fMIRXyyy18tuzu0uSHvKIbCD12IHwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SwA1eVBW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RvAthsQW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P7MdC5006462;
	Fri, 25 Apr 2025 07:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=U2iA6liHPCPRYHRm1zaBaFPUaaHi9CAreBzbExzcQG4=; b=
	SwA1eVBWMeftZMpa137ox2kaj/qGrIUtDo1zi8niwxKghucBGef54qgtCFMCAiSQ
	I7MOycgeTjk2+xPwdFpEvNwf9UDcLFL2IUJszyjvgpKT9j7wMsMFb1QT4oJIXtnV
	WuXt9R9APNvyOh5uj77JxdCEAOMBpeSM4Npo5oF+Q3AVT+UL8gP0igCWGMhRaOMX
	ynMhfer4Xz/RhJghyfY4gDK/Yq0xbEdnXxGyuQ16DPzVOQ0HowSlFgOPCHxhFfvk
	7qFXZGnPaY2IPW+xvqQwC1RjpuVgwLnbIwVHg6Fs9U41vXNByETClkxcR4+cpvnS
	e3xCJSsVaXxg76MKG9zEvg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46848kr645-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 07:40:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53P7bV2k017293;
	Fri, 25 Apr 2025 07:40:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvhj6t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 07:40:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITKPurFb4UIxB5nwTSedIzRkS0o3XzZbIsCj5riEMCfGpaTfI/jVOl1TM+3L+dhxONaci+TXAq9XVRsQ6t32GC8SL/00Rt+OxJEy4FWbKgw7knn47PDVnwap/nzAt8r+8Pv/5zSUzP/sndfCqnxkU3T64BfMmYzIXO2zQVSc6e+9EiQRv7YVobyUgAXU6rdLAhWSf9sf4OyIJTERW+Xtcg8n2dXBDH1evItmTcxvDIBmAlEE8K2Wk97jQ+YSt5a+4fZWHSDUT5tDiwhoI51gOEKP88sMaaLe4ZqcpLum3Q/LLHQhLM5Ulgo9HkOOji7ER8X1V8GsooDEa2c5Scl2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2iA6liHPCPRYHRm1zaBaFPUaaHi9CAreBzbExzcQG4=;
 b=lnArDFo/d0rl57/JBX9Z5lc/AYrjDKUiBsZeqhWZ8bCYUaOzdqo4gfNC7+LsvnTiZQveCT97+MCS867p8dsm1bMdH4fdEBpPAK0Q04C0ByT9wmGat0NytLiulwf/XCDSfvMK/4XrhtEZzfCp/Rz9krl1abT7u3dUzePsHjXhcmBWNxQ7rY6e+c79QqiQ6UzW4bRMazfZEQseZrUxTjdp9HzGx2wzDr9bZq8fAAW7GvWHXvJZUXVYtpULao/ISZtxC9kSueqYnuMHlNaPk80nJzyb1vxdU+poFYxdDz25DUxhmiEvPymDS1y5et77YjQFG8dezPL3/D395DCIJwz7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2iA6liHPCPRYHRm1zaBaFPUaaHi9CAreBzbExzcQG4=;
 b=RvAthsQW8A6gqg2UQGUsK0rZjUbmI54bB2J/H6lOAq8fjBNpRVaOVEEHFBjv80AMjOFHbNkC8u+j6wgfgv1Q/bgTJuapaZUa5fpvNzM9/edERHnsieEj/yE2dLpZS6kMgH0vjvRymf1xGQITbxTM6MXTXPx1ZrGb6ojBPOzIobU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7742.namprd10.prod.outlook.com (2603:10b6:610:1ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Fri, 25 Apr
 2025 07:40:49 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 07:40:49 +0000
Date: Fri, 25 Apr 2025 16:40:41 +0900
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
Message-ID: <aAs8eWHw5ELbmSZt@harry>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
 <lr2nridih62djx5ccdijiyacdz2hrubsh52tj6bivr6yfgajsj@mgziscqwlmtp>
 <CAGudoHF8-tpc3nJeJ3gF2_GZZGp_raMBu4GXC_5omWMc7LhN1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHF8-tpc3nJeJ3gF2_GZZGp_raMBu4GXC_5omWMc7LhN1w@mail.gmail.com>
X-ClientProxiedBy: SEWP216CA0027.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf0fb82-f7a9-4893-1038-08dd83cc7f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlZEc2hJU3JJekZRSksxN2o0NS9aaERaQkdRYkJRajRIMVdhUnUxZnY5blRz?=
 =?utf-8?B?RmlMVjlpeGRzMGpYQmxJaG5MUWFoWXJMUzkzd3NZb2pRdUhXZUhlbWlSMzN3?=
 =?utf-8?B?L2JpMTBrdlFEcDQxSFJZdWRObUU3WXRRNnhhTkl6Q2ZkZjk5NVF2ZXZBQU9l?=
 =?utf-8?B?TzVVZWRFa05RaEZZS0ZWcWloYUJvSzNGV043VHRrVUV5NUZhNGJNNSs1bnM0?=
 =?utf-8?B?Q1pBVHpjYy9ES1BRNHhSK2lhZytyemJNU0liN0UxNjZCWXZTR0g5NStrbWpE?=
 =?utf-8?B?cjZ2WGhwRlBDOHlRQW1JTlorV2pNRkxrZTAwMW9MM1ZlM0JwUVBRbHdhaXVO?=
 =?utf-8?B?YkdVakxhVFkzR1hZUUtra1RpNFdxNnMyMTdHRkJERkdEWEIvbTU5RUg4bDVV?=
 =?utf-8?B?OUdWc2hDd01UUE1CV09SRGxia25OMEhpT3dSVzBpMFJacm5hakhxSDJQYURk?=
 =?utf-8?B?TlI3dytvSHdIcUt0WDR0RGxWOU42UkhjT1lEQThUeGFYM0VPTUdSbWk4elRX?=
 =?utf-8?B?bDdGWVlFRlVzbHozVkRkM3dlRTYrTjdxTkNmMDZjSFd3VjY1ZXdtMTMrcHZM?=
 =?utf-8?B?aDdmbnEzVVNGYjZiZjdMM0Q4YXZiK00rNFhLakRub2VSRnpZUEpiSlJKNlcz?=
 =?utf-8?B?VHgxOUZIbndoa1p4ZEY5Z1BJRkdyRWc4UHgwY2hGVVZaTjZJcGZORjB0VVgw?=
 =?utf-8?B?ZEh0UlRIbS82Ykh1N0orbER0ak00R0FFVnBTQzFtMUtCN1FOMUJhUGl3MFZo?=
 =?utf-8?B?Umc5WUprOG90Y1NnT2FrbVhzenAwb0ZieDFHOTlIeHp1ZDdtUkthU0dBK3cr?=
 =?utf-8?B?QXF1aDY1MmxQcnloaC9IQjhTRzlrRWNGUitkOU1KbFJseVhPRy9BM2JzY2d1?=
 =?utf-8?B?TUpGd0h5bVZ1azIzNGsvWE50NEpaNTJEdVNiNWYzdStOK21jYVhFbXpNZklG?=
 =?utf-8?B?N2dYVWVzYWpXQWpRZEpBWmpETkF0TWpBVlVGWmpVcGpUQTRLQ2tZZm92eWZy?=
 =?utf-8?B?Mmp5OUxDTUZaVE5FTHRObEFpYUlCay9ra0d1dGZycmxSVUd0QWxJVmRJV01i?=
 =?utf-8?B?SFVqR3NGY3o0TDhZYWdZNzFqdTA4YUdqZXJNaVFQRWNhdm1BbjZQVnJKd0VL?=
 =?utf-8?B?N1diS0ZzVk9uNVJXYzA4eExOd2M4dEJuaWpGTE5IWXZOQVNBditPV0lBZGoz?=
 =?utf-8?B?WlFQR1Qxa3c5Mjd4TnloTjUxUkZzdVV2MEZZMjFKR0htcStxdE1xWkZIeTBh?=
 =?utf-8?B?TGJIeGhCTlpXSTg3ZHdoWERIQ3NLV042OTJSOGpZSUZJSzg2ZmFGaDJGSEMw?=
 =?utf-8?B?aGxJUkEvaUZXTVhucXNCRHV6TTBwK0R2T2JhMUF2eDQ3NE9NeVNCWE1UN3BT?=
 =?utf-8?B?V2xXVDlpbDR6Z3pWNDk4S0RFWHIwYW5JREtHTU5YdG95NXlHVmduRG1xSGpB?=
 =?utf-8?B?SUFORmR0L2hsUlZIc3F1SkZOK3I1Z29SSVYrUVJSQWh2TWxNSng0elhvY3RT?=
 =?utf-8?B?VUUzc2RvUjR3OUg5NGM1Wnc1Yk1VcFIwWkF5MFd1VjRmWmhEUWQ1SXVQZUhq?=
 =?utf-8?B?RlFJMHkrOXpMM2d0U0o0VFFUMDczR0FRZ1ZBLzJUbll4VE9odHFlTkdzaWZI?=
 =?utf-8?B?R2k2WlpNVDV3T2xJUUZCeC9sT3hQQXVGdU1PTW5sTEFzQjgvTzRHd0pTNmVn?=
 =?utf-8?B?QzlyQkQ2bXBRMHpQb2tDVlRtaktFMGNtV1NRcEdzUnpsTzllcndMcFRxVUta?=
 =?utf-8?B?dWJoalFlRTlNMm9wbXJEOHdFSU1abDhZUFoyNWJNelVneWhvdFU5a2t5R3A5?=
 =?utf-8?B?US9MRDhCZXQwdlMweU1aN1I2eU1FUUJjN3ZVejlqU3RldGlGanR1N2xXM1NI?=
 =?utf-8?B?UExQRXdwWC9NeStvcXpaMXdncGtUcUdDdkd1Q2F4NVUrYTdZNnRTRFo5dS9X?=
 =?utf-8?Q?NZgClCaUIDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEpaa1FwbkdCMnFteTdUR1RpTXNnckwrM2NHMXlaS0lLTG1ZQUlXeDhYSk1l?=
 =?utf-8?B?YkNWNVpLUytRMFhlWjl2TnB5dzB2MVpqUDFkekxxSVNCN25mVnZxb3FlL2pT?=
 =?utf-8?B?ek5LcDJKTUNFUUdON21laHJMcThrWTFQdkNnam5NcDArME9TM0ZnVlFGK3U5?=
 =?utf-8?B?YXVBOEl3S2pzd3ZLQ3crbXhVVHQybzZ4SU9HWTFBWExEaC8yYlVoc0JJenRq?=
 =?utf-8?B?TUpQYVBWckN4U1lheVFzWHVlL2RXUU5kd1JqYUI0czNHYVREREdKTGJPQUxB?=
 =?utf-8?B?dENUeWxLRUh5WFhyS0JsVVFxblNCTGZHbzdJbzA2L1pZRm1Udmdzdkk4N0xt?=
 =?utf-8?B?QWNPTE5uOVdRRStBYlBhY3J6MnVURVZYUnBZUGRUOXpXUGJLOFJ3L21wbzU3?=
 =?utf-8?B?U1RuV2N5bjZiaEdESFhIYy9vWVFuVlhPdVJmN0FOemFWMmdPeXJXaVU3RmQz?=
 =?utf-8?B?SHFkbDJRWVYyYjlvQlovQm1Fb3pGS0Z1SFJCNlVSdnlSKy9wc3hGbzRqcUlK?=
 =?utf-8?B?T1MzMnRueVp6cFh5emtadi9Vbmw1RUFmNVZJaDhzUWc0WWl6WUo0bEdXQWND?=
 =?utf-8?B?SG5TV2o4L2ZHOHhNOU9YSVZwRDVNTVcwQjZUQjNyUXlrMk5jME9OZlJETmwx?=
 =?utf-8?B?VzRpWmZUcENtN09vVzVaVXMxN2o5M1BiRExhbzhCaW1pbFJsb0RTRXlvZzAy?=
 =?utf-8?B?U1M4SXpFYnlTWkx5TDMzVXJsbHJ1dURHandyWEhDYzNyMzRNTi8wYklkMEVN?=
 =?utf-8?B?dzJHbWZyU3VEUUNrYXZPemFOZjQ1WVI5QXRSTlBYczBNSmZvQm5ibUIraVk3?=
 =?utf-8?B?dytyTFZzbVRSOG5MRWxxanQ1dWMramoxR0VsbExLdWsvRE1KWTlRMjJNRmtR?=
 =?utf-8?B?aUFIVkdLU09JaXlWeGdFY2R0L1J1c1NqbEpkWU9mYUVMS01yVGFHdmQ5ZFE4?=
 =?utf-8?B?Wk5kbU5abUkzVDNmellXL0FCb3Y5Z1VHbVpHNmJMNjdac3pZU09jb2V5RjRw?=
 =?utf-8?B?MVZDQStPOW1KdXgxSXB1VUQvbldNRVpodk9YRUVGYU9qOFNaMlIrTGR1a3ow?=
 =?utf-8?B?T29XQWZ4c0ZZMnNmZFYrQzZhSkk5OStCeStJelZzVU14TFkrK29SOWF6allR?=
 =?utf-8?B?STVra3d0STRRbVdZQXBEUkt3S2kxalluWHM2V3RhbElZbU52Ly9jM2RobkMx?=
 =?utf-8?B?L0txYmgyYzU4OWYva0V6NTNOLzFPaEdaWU1leUFkRUI0YmNyOXhyeGlSOG5Q?=
 =?utf-8?B?TUZWalJEdlk3NDlIZnhmamNjbkxCd3M3elFGLzUySGltaU1YdkVORCtWdnMz?=
 =?utf-8?B?NWp2S1kvaW00UVp5RDJjUUN6NjFJOTdGUkJmcllGaHVRR1dNaFhCRTd6eWdF?=
 =?utf-8?B?RDEyQ1pTSUcyRGtEVlVOZkwyQ3U5Z2xOUG8yNFdFSnYwb2YwV0pNYXFkUTIx?=
 =?utf-8?B?NHZpMjhBYmJNSUhjZjlzaTNxYjE5emo0WTFBdFVmZTFtdldKR3E3N3k4dlZm?=
 =?utf-8?B?VTF1bGg0elFjYkt5TzRZbWJxRzNPTHVYdzhlSjZLSWFRMUVMOFliYzRiSjAw?=
 =?utf-8?B?VWxRRW5ubzlHdDFmQytscThhMmF3bTl1cURIb0h5ZDVZaFljdG9lMmdHZ0M1?=
 =?utf-8?B?ZkFodnRQUlRKNlNyYlVmc1lBWmdIKzB2b1NFZnFNWGQxZGJ3RDR3RkFZcWtW?=
 =?utf-8?B?ajBYakVOcGRaNzBuUllhanBDY3hhbTh2dzJ4T3JQQmFoQ0VlZXlxYXJ6bWtZ?=
 =?utf-8?B?V3psQ0VyT3NVU2tWK2Q3Y21lS0JYZzBDWHJpMThzbG90YWJMVmZJc2pJSnpU?=
 =?utf-8?B?ZlFPRWtlNU5wVjVlTnA0M2craHFXdStJUHdXVlhjbEk0TnBvNGhXWFVUT0tx?=
 =?utf-8?B?RSt1VEVRRVd6bUFaeWFpcG12eWZMK1Y1NUllbTl4SlF6Q2dxckQ0RW5mUDY2?=
 =?utf-8?B?M2VTYmFuUEdIVVVGTDAzRTBZSFdXRjhDcnZmS0hCY1BPZ2tJdm4xVFo3UENu?=
 =?utf-8?B?emxNZTJmT3krY3NpbEdvNG80bWM1Z2lISTM1ZEpML3JpSEtsRk5BYUMwU1U5?=
 =?utf-8?B?cWE2MVpsamtsUzJJWHZzeEhTc295aGM0SjI0YlpUVUNIeVI2TCszWWJsNmxI?=
 =?utf-8?Q?zXuccEn0P7qBHRX7ZxqVLmpH5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LHNRa0+YCw/G+DPWRIq2h97fjqt1rRPsO3eltTDwJYZn2nJEi9JGc8DZGQnatXAzwCPoniFIaNog1cYtr6MdaFb7upak/OUBYWbDLcfpSthYDlKM8ktrqxHxem218Ilz9hGzgBFDpMuYxGKw7TOzSe43ZW9Eoui6+sWXYbdna17aOaQnHWnac7HMUQTPJOPhCEZks4onT6PU6WT8R7CQ5AnLtMqFMJjAMugTeOVx3ruPoLWA2TU5SpSkhvwAKzTPaojlDAks2C6SJK1eozxe+Uo9e2aINyx8vZYgdx+TVEI2LEvYdF3ep+50f+kRlogNt0TBu0BE+Crj9G5hbMiSJ8PRt0l7uoaQ2nw0Si1GtjPUUDeuQ3OMklecMT1i7EbY7AgGKYmS3rnENFxY2h++Lw2kk6H7jAmOvS0C9ZNGm7+sDDr+8G4+TtFsnrUgegOfB5Lypa0x0p0dkUw/nUmezzEPS+Hsrj0gTbCLUbHt88flKPesmmIMMNxoHWnbWTFhk1QLqCS0yoKNrkZ57IwpzrMP6Ee0a2MYFErgPVY11qKguAXf2++vrHUu7xvOVlirWZVZxxKn9J0IWkozhF/+UVuQrxbTXMRJuFzcMF05an8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf0fb82-f7a9-4893-1038-08dd83cc7f7e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 07:40:49.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOdppVGTvMHycC6p2Y5DZltjJox2ByvhGQSNz3nnC3FsT61tfu+fQNWQ/CBvTWtv1q58+zK/jLJgsRXBX8YCkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250055
X-Proofpoint-GUID: b3Z7yofTdD7ReV3aCGqKUMWclQnoo3Fa
X-Proofpoint-ORIG-GUID: b3Z7yofTdD7ReV3aCGqKUMWclQnoo3Fa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA1NSBTYWx0ZWRfX5fln6Wgo5VQd zMcTp7VWOdpQXnjGnPG9yRTt1eoeyiXuWYWJXjBSE3zrDZrcbOXCsTiaZPgDcxzmvyQHfN57Gft OQTdAvdF/SJSr0VCOL2DyXhh5sOuZqW9DLubGQJgPeppjx7maGJzDUUBiT0sPPV7h5OmqUOKgQM
 JL3UF9ceT9QE5dm+hAMB3Au1ItoqOFJCitHvodcTmHNwZ0wnvi7PQC6hCE8GYBCeFTMCdeZ465K dZy3oLx+0j14PdKkww9Lmqgh5ZHuHAB+alGiR6gEC/Myma0jKkPEOvz87s1kcQxBP+l80rfSA6u 3Iw2tV06AITIwpMS8mpHMQu/Bw1MLTd9TcAdn8AYbOpTwG8q4CQT5aPHzuYcW+m42rNurKKLHT8 vFwaHaGC

On Thu, Apr 24, 2025 at 05:20:59PM +0200, Mateusz Guzik wrote:
> On Thu, Apr 24, 2025 at 1:28 PM Pedro Falcato <pfalcato@suse.de> wrote:
> > > How to do this with slab constructors and destructors: the constructor
> > > allocates percpu memory, and the destructor frees it when the slab pages
> > > are reclaimed; this slightly alters the constructor’s semantics,
> > > as it can now fail.
> >
> > I really really really really don't like this. We're opening a pandora's box
> > of locking issues for slab deadlocks and other subtle issues. IMO the best
> > solution there would be, what, failing dtors? which says a lot about the whole
> > situation...
> >
> 
> I noted the need to use leaf spin locks in my IRC conversations with
> Harry and later in this very thread, it is a bummer this bit did not
> make into the cover letter -- hopefully it would have avoided this
> exchange.

My bad. Yes, I should have included it in the cover letter.
Will include in the future series.

> I'm going to summarize this again here:
> 
> By API contract the dtor can only take a leaf spinlock, in this case one which:
> 1. disables irqs

Alright, as interrupt handlers can also introduce lock dependency.

> 2. is the last lock in the dependency chain, as in no locks are taken
> while holding it

So if the destructor takes a lock, no users of the lock, in any
dependency chain, can hold any locks while holding it.
 
> That way there is no possibility of a deadlock.
> 
> This poses a question on how to enforce it and this bit is easy: for
> example one can add leaf-spinlock notion to lockdep. Then a misuse on
> allocation side is going to complain immediately even without
> triggering reclaim. Further, if one would feel so inclined, a test
> module can walk the list of all slab caches and do a populate/reclaim
> cycle on those with the ctor/dtor pair.
> 
> Then there is the matter of particular consumers being ready to do
> what they need to on the dtor side only with the spinlock. Does not
> sound like a fundamental problem.
> 
> > Case in point:
> > What happens if you allocate a slab and start ->ctor()-ing objects, and then
> > one of the ctors fails? We need to free the ctor, but not without ->dtor()-ing
> > everything back (AIUI this is not handled in this series, yet).

It is handled in __free_slab().

>> Besides this
> > complication, if failing dtors were added into the mix, we'd be left with a
> > half-initialized slab(!!) in the middle of the cache waiting to get freed,
> > without being able to.
> >
> 
> Per my previous paragraph failing dtors would be a self-induced problem.
> 
> I can agree one has to roll things back if ctors don't work out, but I
> don't think this poses a significant problem.

Agreed. it'd better to write destructors carefully avoiding deadlocks
rather than allowing it to fail.

-- 
Cheers,
Harry / Hyeonggon


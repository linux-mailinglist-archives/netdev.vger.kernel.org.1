Return-Path: <netdev+bounces-228839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B72EDBD501A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D39189C2F1
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C98E22157B;
	Mon, 13 Oct 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="roQejhXA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xg93canm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C077220E03F
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372777; cv=fail; b=KAXyk6omzwEVWWwt39athfA+zT9fqgvbpL85xArkiQtRdkStQrmvG4LXwy8Xa0Jrwo4Y1fmTLqQkcFhhZipncS8y6LV7IRh/g/OBhW8PMtRBEKnrrDAX92aZUHlPeqGulimHl6rGglKtyoGSTvN7Y3MCbD3eaa3YAyWQVkePbI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372777; c=relaxed/simple;
	bh=gWl1BO6FDYGQLu5zmoJiok8vNvlyrahFfcAVE+JUDjU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hgh3AdJoZv9OjJ8Sb45vg/scOZrdQTum73CQFle6bEHcFQcq5xC8z8Hu+WL0Nf6++sz1yH4arFYeDSiAfCDVRMGB/zhCJds6q8i7cmahbJzuYJlorZgXjfPZsIo7bDdRrnjqRdoDnXrQ5J4i7grb6nNw7K6UmzbDlwUsDOU8qwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=roQejhXA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xg93canm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DFu3tL026297;
	Mon, 13 Oct 2025 16:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1E965a3ApLvCQT27eXPLxtQLYpaD4YbAbPve6oB8a9s=; b=
	roQejhXA/MOBBYKHsV5FYcenuD3vbLWXbwK8tS4doNrqUIM55NVHD5Qv0lF1vIhy
	nxffI2qs3IYMISHQoB2etOmeoLuT2HtjyH8uqadSMzND+jh4cVlvSM72fLP/gy2s
	wyC75ktLfiVr9fsTr+qg3cZEjuji5q4pUDvdyTySv35HetmPrLXFjvr5kmpXMYwM
	VzIBbrl4ISa8xXa3nsCKYnAk0H7qPfpV1Nwxnaq03OtUIJvrtekosKXFgIeUt5ir
	VoLxB05iDaomeMMUumnZIxN5l/rrOkAJC3vPs1SK+p/+5KOFwUCsEUpjCQ3d1945
	LSxggbzbVb+oSvsN7i740g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtyjp18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 16:25:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DF1ZcN025658;
	Mon, 13 Oct 2025 16:25:39 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp7h4qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 16:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwSlX6SSQCzcijEfpTQTCOMxPMWL43o/qY+5jIojcpvDW49aB0+LqJ3RfoTuAVUTpd0MwnKdQSsIwk7wkKEt9NauVtYCkh9k/XBofTsreZk7asr2Z1ftda3l3tqR1rYZkBfAAdRDrxfe8DxcKBQVxZQ2rUyB8rYKMpJM99S0QFTofJz8vMmYPOD0lsddxKZmrNPKnnqBLG49hZr8pejX2S6+LeVX1hSR/iWX4o3NvEwpx8BGe0VGQFim8BBgcuDtmnqgjQZmWhGErU/cXdwLb5BWl9Mx4IJBe2k254blmmW3V6uJ7Zssu+5Ly250xqCd7BikLHdTyIhLkWV8aWyAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E965a3ApLvCQT27eXPLxtQLYpaD4YbAbPve6oB8a9s=;
 b=ByOz3oki9p5XrChCiIuHtJIm+wBZmDXDNf7d813GLPPcbMsR9Uc4ducgwlIIAMZFDjHwH8uRrNOxMGRlX7F4XH3awT97sH4RjciY4F4PcU8iVLrbgjEWDNn4PiJJPRXLhC4JwnEyLTUp3oBSMCfGA+vDpDTtRoAQsRu5knbmEYAiIt7xm+y6Tb4payjcraGooA2xOBICY1pHE4HFn3LhTLtoJzjtNAbBc51htVCjfpOw5a30sXIuI5jahZLOL+6HKjxzAarS1E7g+KmcNkocKDDhroaE7m7qNJfOWfacoTs8MkpdNwIkwK/d82oKQ939O0GWINXPTrbcilTv2siDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E965a3ApLvCQT27eXPLxtQLYpaD4YbAbPve6oB8a9s=;
 b=Xg93canmwRZGzNjMdfX0CTuU5pGxKVGLsnB3HG7a8MS09fDCb4OC/9/4txIceUK7czlx/ch4lpc+vfVACPX1ayRt4O/uuZ05GfqwyovDXb44LvhJ0//C6bAyTl7AeXU9cruHxiC81zO8BX2cyMhgvBliJIdbuE2FtlyGFhpLb5o=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB8174.namprd10.prod.outlook.com (2603:10b6:8:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 16:25:36 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 16:25:36 +0000
Message-ID: <b168c3da-ce5a-45c7-923f-9023bf5e9a6b@oracle.com>
Date: Mon, 13 Oct 2025 21:55:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v4 04/12] virtio: Expose object
 create and destroy API
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
        mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
        pabeni@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
        yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
        kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
        edumazet@google.com
References: <20251013152742.619423-1-danielj@nvidia.com>
 <20251013152742.619423-5-danielj@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251013152742.619423-5-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2724c8-5858-4913-35c8-08de0a75240f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVpHNjZXOWxPK00ybGlpUGo2NUJIQmU0NXVnbFprQVk1dldKU0J2bitYS00v?=
 =?utf-8?B?T21uNGlqcHlNWFBObnhqWTFPQVhpM1VlRWZuMWhsNXVWbU1Wc2pLRDhRU3U3?=
 =?utf-8?B?ajRTTFhRVk5KQmVKclEwUm1taDZ2QlVhZzVCYlNpdndvR0ZpS3dEaUtlMzZp?=
 =?utf-8?B?Uk5PeEI2T0tIMEJoVGtrcmpxWk1Na2JkVmlESWR3MmJwZ3VyVnVscnYvbGdw?=
 =?utf-8?B?dkRJQ2pleFN2a01oNHZMUndabmJkd2hEam9NdzJ6cmVQSmRhV0dVWmJ5WHBM?=
 =?utf-8?B?dDZWekVRcjNzYThlVThLZUhLOGhaTm5WdXFPQkZPbjA4WWlYdFVPTlVaaTZi?=
 =?utf-8?B?ejJXd296S292MGM3emZLdXVQcXA0cUdXcC9lZGlPRlowem82dlVnbGk3SzRq?=
 =?utf-8?B?dFcvY0lwWjB6cTZheldXamVHQ3ZBNnNOdjVRSzNTWFB1N3Znc0Q5QnpMTlM4?=
 =?utf-8?B?TTlKQ0c2akU4dlVWSk5aWjhnRHBtY09iZkI3L0hUeHlLZ0hWQ3NCSmg5M2Rm?=
 =?utf-8?B?Vk5JTE9Fc1FiU2FWR0FzUDhDQStUaUtoUGhhbVVJVXkydm8vUFkzQmNJZmdC?=
 =?utf-8?B?Z0JrSkQwVU8rR2Jmd1g1ZmEwM2RwWW5Ca0pBSEFJK0lXVlJ0dS9hanNYckRt?=
 =?utf-8?B?RW9qZ2RFNnJRVlpWcEU1THk0RjcreEdXam9qbGwxcTEybTdTNzRmRWNNS0t6?=
 =?utf-8?B?QlZZNGhJOU0yWDQ0YWdiTTVxR0xJNkRBdjlLNTdqRTQrS2tRU0ova3YzM3U1?=
 =?utf-8?B?eWF6LzhDUC9Cd1hzbjErQVk3eUYwT2ZaL1l5TGNjVkVRU2hZa0xzWHNEVDRP?=
 =?utf-8?B?eTZWTjZiNE9KSldjUUs4VEkxL3IyTm1MdVBRVkpqNkpaV1EycXRvbnlGKzJo?=
 =?utf-8?B?YUVIMGVrakErT3F6MjBrendYa2JZRFhYbFB5VTNHTHRoekVnU2ZaSWt6NmFS?=
 =?utf-8?B?c3NCNlorN2RwQnlvWjUvUERkR0hqV0YxZEFTVEVLODFVZk5qWUl4UG5ZRmxL?=
 =?utf-8?B?SXl1MDUwakR5R3RiaklpZmluUEhEUjRIazI3bkhaTHN3bllpMHgvaTAyUVVx?=
 =?utf-8?B?SExJL3BieGsrY21FWi9uTFlHYjlVZnVHYkl5SzNiNktuUTFSRFhuMXloK1Mz?=
 =?utf-8?B?RUpOYzNKYm9QbG5sNnNKRi9GWEx5c09MSlNtdC91dmlzdEJzMkpmQ2Y4RkFQ?=
 =?utf-8?B?b3VPZlNBeDBLSUo3cUFEN0ZpcHhJVFBnRDNXckxTcVVzVGJHWmo0TDIwSXdG?=
 =?utf-8?B?cmxmcnd4S1hTOU9XWEdIYVhKZkQzVlh5RURUaDNleVZKNWdjU1pWQzN1T3hQ?=
 =?utf-8?B?TjhVbFNBYmd3eFRlUnJubllVbW84THdVSWVIY3Q0RjV6VmROaDc4YWZKYlNM?=
 =?utf-8?B?Rkg0SXdQVFJpMTRGcVVINGRUalBhbWxvSUFUbTRRYng1U29wSTBrVWtvK3Vp?=
 =?utf-8?B?Vm1sTWoyUFhiVS9sTXVFbmg3b3YvM2RacThnTUZlWFE2QTBYM2Q5OUI4TVN4?=
 =?utf-8?B?dU9VaHBJVmg4QmFhaGxQSWVkcHYzZkxDY0ZWS1Q5VDhiWm1qQ3F2cVlWS0Np?=
 =?utf-8?B?d0VwM2JPcHVGNDhjVkJMdlFwZGx3RVl2SzBTOTFIbDNOcCtmTzBDNW12VHJy?=
 =?utf-8?B?dHg0cVRKVWhIQ09sMElXd0RBQW5HeitBdlVVLytsQjQrZmNORkM1OGdkNW1K?=
 =?utf-8?B?OGNMRmtER0l0RG4rMkJXSHA1VGYva0pqTHNob0Ezd1lDbzhoRy9RRDVqVVNW?=
 =?utf-8?B?ZXdISDNhbmFsQWFLbUNreGRYUGliaHFGQjFKWG1GS2NkK3pwb25KWlNCRlhF?=
 =?utf-8?B?bEw2bUdkOEd3QWRibUZIVVFBNEVTNFQwYXNjUkZ0a1ZZNzRRVUNwc0lsV0ZP?=
 =?utf-8?B?S1NERWNWa0x3cm4rd2t1TG9SNW9WbVJNcnhuVE9VcU5ESW5BSlVleVRETEJN?=
 =?utf-8?Q?9R1uRohbAHXS6vjSG8WYYEH85P2mulkJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L201MmxSUkpEbGZKYXFTOTNwd3VRcUU0V3hRM29WeG4xWUhRUnBwZmY5SGtI?=
 =?utf-8?B?RlQzVTIwb29BYVZ3bXplTDBEYVlFanYvZ1RvV2ZOZnlTK05nekpHbDNocERo?=
 =?utf-8?B?Y1ZObitZRTBmVmh3RVpldjk5K3BuWmFEWm5ETVlWTWdYaG0zNHZBUHpnS3Zq?=
 =?utf-8?B?d2pwdUxuTlhjbEg4RzZHNHFoSWFRcHZwbURlMURad1k5OEpremZmTGlSVExL?=
 =?utf-8?B?ZlFTUnNNMGRLOFhUbVVDNGhFZlpCY1M2OXZ2eG5rRXBSMWhTdFB1SEtJbjUw?=
 =?utf-8?B?WUpKRis5bWU0enJubG5LREtwUktzeHBYQTA0RkMrMEVaVld0VzVieHNPRDRN?=
 =?utf-8?B?RGVsek8xNGR1WDNFSTNRVzhRMXVnL04yNEZubUlLcjJMVTFFKzVLcE5RUURx?=
 =?utf-8?B?em5MeHhZeFcxQ2wrMFZITm5sTURDdjBlMWdoVjV3cFZ4YjdNTE81MDJvL3Rs?=
 =?utf-8?B?cVpoeVNUZXJhTVhQNm1SNGRoWTFrVm1uOSttSDRHbUd3TkVLTE5RblBoTkll?=
 =?utf-8?B?STlZWjVRRHF6RWl0RitOWDhZZjlBS1JQKzR1bkdjamZoWm9Qa3ArRXNnY0x4?=
 =?utf-8?B?bzg0b0t4VW9OOHEyZmdTaEtxQkI2Yk5qSHAxKys3alJZQllrTHlVTnAxa2tu?=
 =?utf-8?B?bDFRamRwL3VHSSt5cC91L0hMT1JjV2R1NDZoU3MvYk1PM0JnYjNyNkhWdVRy?=
 =?utf-8?B?aFFsRGdKdXBRcGgrcFdibWhKNEZlOHZpU1hSNE1UYlVDUzBGMk02QWFoUXlu?=
 =?utf-8?B?VEJGVzQ2eUtacXkxRjgrMkZ2K2pOeDF3dWpJMTFhN0JkMVVMbExuTnorZWVx?=
 =?utf-8?B?OTlZNER6OERuak9tbE5NVTF6c0c4THpUU0tDalIrenN4akhKbXozclVXMGJQ?=
 =?utf-8?B?L3R1S3locUNVS24vS2RDWm94NURQM2RySS8wckxjUzdVYjJ4Qm9DekRMSGox?=
 =?utf-8?B?di9SNHRLTDVzZU1CWWNSbmRLS0Z2bGQ3NURMWDh3RGVnYk5BVm56ZTltRGJQ?=
 =?utf-8?B?enBDNkppTGVqaUJNMlVybVhRbzNGblR6U2o4YktaN3ZvQkpBMWtXeGUyU0Yz?=
 =?utf-8?B?RDFrQUtjRUtINjU5SWl1UkVQb2ViejdBblpJWUNxaE94S1JmZ0VlZGRzRUtz?=
 =?utf-8?B?OXJyc0ZkNkt3cGx5a0VMZkFraWVDa1EvZ3Rwdm9hTElDblhZeVRSK01EQ1pZ?=
 =?utf-8?B?VUV6UUxDUFRFRmFveFNGT3NVTW1EcVI0eUZPYzRpM1dJakR3dnI3VWRSSDRE?=
 =?utf-8?B?QndrUG5tTXZHb3ZJMXFwOXNjWElSa0p0Uzg1MWNvUkZnd3dVcERiOGhlb0hu?=
 =?utf-8?B?QUFQMHJ0QXQwMm5QY1o0MEg5VzgzZ0FxNmVPSy9kdVdKeWNoMXhrNHg2MzBq?=
 =?utf-8?B?SVZ6MHd3T1Y0cEJCeE5vUEFPcXJ2YnNSNWJxdkd6VUJyNXh2UzN6V1lTc2h1?=
 =?utf-8?B?c2ZGTGR1UmFNTE9wL1VqbXQ3UDRDNDUzK2JEL0FlblBJbzBjM0piUGFDWFIy?=
 =?utf-8?B?RElCZXg0a0hTS2pITGRDSFYyVW9yaWliTHcwRENzRjVnc1RXL1VZUEgwK1Fu?=
 =?utf-8?B?eFBjMHNNSWtlN1JUV0pjU3o0enh0QmtwcmNKK0VDMFBma0FhUTVSSld1dE9I?=
 =?utf-8?B?ZU1hN1hvbVdUNnh4WEZWd1dtRnFDNGcwT2s1RWFXaVgxeFlpNlI0Q2NkL3Fx?=
 =?utf-8?B?ZUFzWkgzWUlmdXJwcis5SDkycUdHc285VFQvRlgwNXlpYmZFRVp4enlDNlA2?=
 =?utf-8?B?NGNXazgzQWppQjE3Z3pWdnNueTRVSHJqZ01xQjhnZktNOFR3d3g5WUV5c0gy?=
 =?utf-8?B?TGNUQnMyL3lLRFpqV2lwN0tFQVREV0djOTNEeWpXZVFxS1FDd1E4VlNERUY0?=
 =?utf-8?B?ZmQzQU94UFhLbDdudi9qRE9JMnVDY3ZFT1RlV00vaHRvVDAvUHI0dERHRW1o?=
 =?utf-8?B?WFo3QXI3RnpXVm1kMmFWa25ESHByeURhWUs0Q3NuZG44STI1SnZLSUpjN3I2?=
 =?utf-8?B?UWJUbTg2dVgwSEhjQmU0WkFENW1NMjR6djBzTUxaTXJ5R2FMQi9ma1hFQUNZ?=
 =?utf-8?B?SUNRR1JnN0FrZE94OTJCdG4xc3ZFMjBwSjE2OGZtVXVPL1lSUUowSWxnNUVP?=
 =?utf-8?B?ZkJ3Vm9lN2tnZjBseWRtb2lTak9ZU1JOcTJxNVlYOWFjUERHd1A4MTNZL3Yx?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	np6vp9gaOU/cSnXQeNjpBUGXMuFh3Nwsx1CONKhszbSK0QIZ9bTnxRx1dy60/LK1b5z00pKis17P5lCRnwo+jk93i1m3kRID/HNOcPAGn3G3jUUup8L6J+A1wdPhocSioibFmxzCX3g0ZuPJAUdotHLjMvPSnSsxpRg4ghzpbZZClHVk4cL4rwjjy/65EylPGW5WL47swuG87geouQrqJ9xWN7Wv2wVcCOgiZHMvoyFTKktC6wQitTygNYJvgGZkMaBuhT55F8I/RW0eQmlIwrJP9/1jL5sU3YgV9hNC1uZxYVwDQT4/I9rN620BZpV5+cy0HKla1/wlehA3N1AidKvw7dMApMeoIIEdNEpNDofbl/AxLvP0j1Qi8P0/62d4WAE5v8MPIIxp4xf/O9Vl6key5aTt64snv3WyZfeR+5eCAScx84mfro1iDqFE/6bUna7OP4b4jLzbfgOWvsSdfpmupZYnza31bJFOz1VzON4Kxds6LtvieyBUlWWtBS062VunrqVrXU3wjOFnMmdPZZX9Gym2BqpTv7jlhHvVE+De3wtD45OGtQtU8WrnlqPEhDl0CtrQRSWvRdwPsGUXxjOcW/a9Zf2t6JgxNglH5zA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2724c8-5858-4913-35c8-08de0a75240f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:25:36.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJlYiPCNnc8rUfFRCXux4mqLDTHDjETmEBfFWqH5scNoh3EypjDCV3Z6QC275DyT46DrX5wLR/epkdpeeo1N7WQo+8cmCv/ssZ2a5BBqBmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510130075
X-Proofpoint-GUID: _mwMg83E3jTi9YbbSRVRwfGFYgXa5Bb-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfXzpNOJKAP2BRA
 CDZLnS1vFFtAOCG1S5nNAg/b/f6hhDvMUM882VRZwrPxnspjNAvSTSIfxslADucjrKqC0/2pzg8
 7DjLHmRT886lYra6NMsqfMT/s4JON6HModY/1IcVqg/RKBIeYhRg38ZPLR/DVsFOi24iMr+GoUB
 7wcrEdZlYhZz+Nu46nmWl1qBVypSy6AJiz+DWYpLbv7XN+aDPSz1caVYpAHCGvitHb+5msVwtWl
 Tapld9IcJhXXD2EhQBllapZOLD9cSZqnGM8axjDf9ZWgZ6zzpkQEnSMu1VKPZXMdkzYlvM+4jfU
 D0ppBuQbCs0cOWzyVfKXDeB+Z9DPwlQmJcGvwQKJWtAfzkTzwEpa1xgai5PjML7sgik8IN5glua
 FfFqz7IMgzdK93xlFQ0T5zhO3nhVvjEAzOGdyi4jY5Ed+0crEzk=
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68ed2804 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=DjDeLTgXvVIlu0ffPEsA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: _mwMg83E3jTi9YbbSRVRwfGFYgXa5Bb-



On 10/13/2025 8:57 PM, Daniel Jurgens wrote:
> Object create and destroy were implemented specifically for dev parts
> device objects. Create general purpose APIs for use by upper layer
> drivers.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> v4: Moved this logic from virtio_pci_modern to new file
>      virtio_admin_commands.
> ---
>   drivers/virtio/virtio_admin_commands.c | 76 ++++++++++++++++++++++++++
>   include/linux/virtio_admin.h           | 40 ++++++++++++++
>   2 files changed, 116 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> index 94751d16b3c4..d3abb73354e8 100644
> --- a/drivers/virtio/virtio_admin_commands.c
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -88,3 +88,79 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
>   	return err;
>   }
>   EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
> +
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +			    u16 obj_type,
> +			    u32 obj_id,
> +			    u16 group_type,
> +			    u64 group_member_id,
> +			    const void *obj_specific_data,
> +			    size_t obj_specific_data_size)
> +{
> +	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
> +	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	void *data;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	data_size += (obj_specific_data_size);

are Parentheses needed here ?

> +	data = kzalloc(data_size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	obj_create_data = data;
> +	obj_create_data->hdr.type = cpu_to_le16(obj_type);
> +	obj_create_data->hdr.id = cpu_to_le32(obj_id);
> +	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
> +	       obj_specific_data_size);
> +	sg_init_one(&data_sg, data, data_size);
> +
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
> +	cmd.group_type = cpu_to_le16(group_type);
> +	cmd.group_member_id = cpu_to_le64(group_member_id);
> +	cmd.data_sg = &data_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +

remove this extra line

> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_create);
> +
> +int virtio_admin_obj_destroy(struct virtio_device *vdev,
> +			     u16 obj_type,
> +			     u32 obj_id,
> +			     u16 group_type,
> +			     u64 group_member_id)
> +{
> +	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->type = cpu_to_le16(obj_type);
> +	data->id = cpu_to_le32(obj_id);
> +	sg_init_one(&data_sg, data, sizeof(*data));
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
> +	cmd.group_type = cpu_to_le16(group_type);
> +	cmd.group_member_id = cpu_to_le64(group_member_id);
> +	cmd.data_sg = &data_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> index 36df97b6487a..99efe9e9dc17 100644
> --- a/include/linux/virtio_admin.h
> +++ b/include/linux/virtio_admin.h
> @@ -77,4 +77,44 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
>   			 const void *caps,
>   			 size_t cap_size);
>   
> +/**
> + * virtio_admin_obj_create - Create an object on a virtio device
> + * @vdev: the virtio device
> + * @obj_type: type of object to create
> + * @obj_id: ID for the new object
> + * @obj_specific_data: object-specific data for creation
> + * @obj_specific_data_size: size of the object-specific data in bytes
> + *
> + * Creates a new object on the virtio device with the specified type and ID.
> + * The object may require object-specific data for proper initialization.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or object creation, or a negative error code on other failures.
> + */
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +			    u16 obj_type,
> +			    u32 obj_id,
> +			    u16 group_type,
> +			    u64 group_member_id,
> +			    const void *obj_specific_data,
> +			    size_t obj_specific_data_size);
> +
> +/**
> + * virtio_admin_obj_destroy - Destroy an object on a virtio device
> + * @vdev: the virtio device
> + * @obj_type: type of object to destroy
> + * @obj_id: ID of the object to destroy

group_type, group_member_id missing

> + *
> + * Destroys an existing object on the virtio device with the specified type
> + * and ID.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or object destruction, or a negative error code on other failures.
> + */
> +int virtio_admin_obj_destroy(struct virtio_device *virtio_dev,

Function parameters name mismatch in header
virtio_dev and vdev , better to Use the same parameter name.

> +			     u16 obj_type,
> +			     u32 obj_id,
> +			     u16 group_type,
> +			     u64 group_member_id);
> +
>   #endif /* _LINUX_VIRTIO_ADMIN_H */


Thanks,
Alok


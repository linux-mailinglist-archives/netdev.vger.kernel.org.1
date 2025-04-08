Return-Path: <netdev+bounces-180373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0978CA811D5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD187B8FDA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99B122C35E;
	Tue,  8 Apr 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mMr7eE3E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qfglIapp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2D22D796;
	Tue,  8 Apr 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128724; cv=fail; b=Gsg/756uJGWKFtTHaYfyNJLCSxX3oDUb2k+BVXjMA3AK2L03X0CuGAJBrW1Uw0twLD1cfNmUdhgrki+L3i5oY2xryL7sAJdFzs67+s9Tkd483NDwoUG0fwpdYwJY7cUglm7DWexr/OBw84K487RDq6FN1M+958LqeT5pMl603ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128724; c=relaxed/simple;
	bh=A6dZ+sTVLvFLfFKSN5cxw7xzFwALq7rwDXqQyHVhxP0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gd4M+9n4ROOuhqnv4wEez6mrC098Tut/5QuKfVDKwumQSjsCDPn7uef/Ezq9P1i7js6YUmnc54htUbI6r4sTWLZVU9bn8YhNA54+rWGeUU/iizM1hnPomxdZsaRI6wM5enb04xUi3oAGWU3uKEgP1tcS5pMYX8bScNbSmpLfS8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mMr7eE3E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qfglIapp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538GBsow009885;
	Tue, 8 Apr 2025 16:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=A6dZ+sTVLvFLfFKSN5cxw7xzFwALq7rwDXqQyHVhxP0=; b=
	mMr7eE3EOXCsN0mUiU77nxFrYUYCyINjsNAcbHQdmlJ2H0NXV3cK9vtTdoq8lbH+
	1nHBCZycvl5gupcXLv/OCeipSJ0qK/gaYw/NKD0caZgVaEO26gcj2g12B0ZwO15S
	zAL6rkRdcppy05JIHo4RhbupyA5Qq8biM1Bs8kbyUWuKLt7sn2RCxioNsbCjvogp
	LhasPumg1Gj45C2U9/sMNwoyyj1fc8Wwvi2trbXC0PjdY9oRrU8d3WkKCOftURIZ
	ppoWC0vb5mSqAPizwct8fmLWrSnHgDgJMvKak6/rwDhR141rGqM0xs+EiC6K4mOa
	lASs8vAqBk+qQReDH1AvwQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvd9w45t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 16:11:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538FaWDo016123;
	Tue, 8 Apr 2025 16:11:54 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012051.outbound.protection.outlook.com [40.93.20.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty9guad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 16:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tX32G2dHHY/1DjdftJ1bGICJEhRvJsSgc9OUaxRuqiwS+S/HX+s+K+VV1amG7M/pjFZqn4nFcMM4oTABJ2vA6M8JZ9cS11afnsxq64tSkPHdgc42IUxvGDbLMazicAwWA7V2MQdJjcd9R1pMnHoYZ8qKW9P597Sj+6fyq+83Gxy9M2+kfufv8KatE5PjF4aEvydxpQP71fnua093L6veJRaJZEU1WwbHM5QVEPQ8c3uOB3YV1ed6LGyD7yvJ1v4ngROsPAFnR0TpG8rybI3G2Xp2IYdftJYJ7o9T+5SmJENcodu0Ktp2XJeEMQA0OgGn56KLJZ+X0F6YmWpu0wY/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6dZ+sTVLvFLfFKSN5cxw7xzFwALq7rwDXqQyHVhxP0=;
 b=XSp07C/iHSbHDgRp7lRthktuO1pwLdIUCr5rC0cyFakGCEAXkyeIHGVnB8MqtQsMXZtXbRZc+BVYvPSWdkGFSALrptRuYqtRKW3kaOWkrkex4PVSACfFei4cs9g4ZSymaIS+g+8aujODGWa2KxRihhp1v+xeosmwjNE724Yg8NhwQu9Blqfr1yw19n8WXwDHvUctmHZqbD+b3gm3Dbmi5EoXSWZnKpU4uONS/PpTyzHmyhy7posEBI68RUyQX0kA/dFRo0SXvSV+chfK92hS782bUt/AOtJdQQOJb1pcX9w2ABdwhPj+rodRMJn5ymFZEn0G4WveR7n842x2QpNaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6dZ+sTVLvFLfFKSN5cxw7xzFwALq7rwDXqQyHVhxP0=;
 b=qfglIapp0UWa6WyjrGMUxMVOPc7ar4dDUqjHLUuObbdjwJVftBQtkjm2yRodSCC3QsCqEFZI+k51ELFbhQ9Vs9IE+0+U8FNxZjiSQua7eN4Cqz90wJ8Fj5g/LE8nf/6eYxUBqHQzpgtvxHvCJzZZdbnH2imgEM5ZTDI2Pu9lX6g=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 16:11:51 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 16:11:51 +0000
Message-ID: <e32530ae-2f41-4472-a478-eb64bd92aa5f@oracle.com>
Date: Tue, 8 Apr 2025 11:11:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        sgarzare@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-5-lulu@redhat.com>
 <20250407041540-mutt-send-email-mst@kernel.org>
 <76a7e782-6a7c-4704-b7c1-2459254c1362@oracle.com>
 <CACLfguXfRvLLiCF7ysidPLcn7GftU1Jyuem2Q9xr_SMGnP_16A@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACLfguXfRvLLiCF7ysidPLcn7GftU1Jyuem2Q9xr_SMGnP_16A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:4:ad::23) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acc124e-70d1-4c3c-3d33-08dd76b8125e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0FtN3BUcmttbFhvSHFKWEdTT1lyOVNWc24yK2NmVUZ5TUtZaDlyU0p0MEE2?=
 =?utf-8?B?SDZTNThEZTE5YTMzRU9Ed2k2KytiaFFlcThhellIc29kZnpJUTAyTmJXM2NJ?=
 =?utf-8?B?MU1QTzNvZFoxYUYwVU9vZnl0TSthMC85c2FHV2RuZE92ZzZJZXFxSkNpQ3VK?=
 =?utf-8?B?R1dvRUxuMk5YQVJEOWk4eEY0WVZpQnl5UFlVRHorbG93clg1dFEzM3VzN2F2?=
 =?utf-8?B?NUpwczE2U2JZT0ZZZ095OXRPdzI0WHB5MnpWVmdIaVRVMjM4ek1mSTBmcG93?=
 =?utf-8?B?b1R6UG4vM3Z1NzRPRnJaTmVDNTVXZHBvc09WcFNtV005NEpqOWFSTUtLZG10?=
 =?utf-8?B?RjhLeFB4dVpaOE40K0RVcklJbVo3TFZEWUo2Z3VOZ1lrMldPd08rcFJCVERm?=
 =?utf-8?B?OVcwMGFYMU1oWWJna0ZrTGw4WUt6MmdsbGUvN1Jqd0tLa0NYUVN3K0pYVlVj?=
 =?utf-8?B?NGhRRDh1R2xjeG1nZy9hSm1BcXIxbVNOTWhXM0pDTXNZVTBuSFRQSHc2d2Jh?=
 =?utf-8?B?Wmp5KzZta0d5ZDNvbW54MG11QVB2dFpVcHZObGIwSWRRWCsyeHRMNTdxUnVY?=
 =?utf-8?B?SDZEM04xYjJVSFJ2VGJKK2NseVNmQ0I1WTdzMERPZEh0MENDMTJOdGx0UGZX?=
 =?utf-8?B?Y053WWFKYXVESmhaNCtzYVFHa2hKeXJaaVdoN29CM1VHaEhOT2E4QkpBTXlo?=
 =?utf-8?B?SktmVXdOVHRFWG42cWxEalBtMDhHdklrNDVjZmhCMmNlcWJKRWxlYW04b3FL?=
 =?utf-8?B?cDhvOW9ZcUZVeTd4NWltc21GR2JjdmtxcWdMenRvQ01ncUF5YVEzOFBUVHhw?=
 =?utf-8?B?NmV2YklkTTZqd1NDM2JGQTFVamllaVZWQk9lNWJMeEpDOEJqbElBTnBEc1hG?=
 =?utf-8?B?dHliTmVSc1dIaTJqSExEZFdsYTB5SU8vRmZjRjYzMGhTYzBSb1JldVh5VVVu?=
 =?utf-8?B?MGxHYmJoN1UwdTl6Mm5jTlQwRG5PUTdrSmZIZlJoWVdmSFB5enlud0RiVEd0?=
 =?utf-8?B?d0RYYjByOFRPeldidFcwYndkYU5CWEtuSE91Z1R6K2xnWXJqb3NKWXhtcm9h?=
 =?utf-8?B?Yy9vNERjeVQyTkEvL2s3UXZOWkRBOXJscDZBc1JXbFQxNE0yR2xlM01RZHdS?=
 =?utf-8?B?a2FpZzM3VmZiOGJtby9makpsVEJYMGI2TkNYbEgwcHJIV2dwY1lWZnZwaFU4?=
 =?utf-8?B?RlBNWjhFSzAyQzFBZ1JoUjJacXNqWG9RdHFYRTVvSXVZd3RtSVlqTTdkZTdM?=
 =?utf-8?B?VWNUaVUwbTJjUVdBWVNwZUlKdVFCd0lxeFlCeGlOaWhId1BvTWhraUtVazZW?=
 =?utf-8?B?TWR2dmV4c1FOb3NmdTgvZUhzTXJ6cEZTYlV2VnhKd3V1ZjYvMit1UkNSZGVQ?=
 =?utf-8?B?bFMrR2JmeHNjV2pER2dJL29HVGk4eHJESWowNGllSFFYbE9QZWQ0VXRyT0RK?=
 =?utf-8?B?QXdFODZYc0ZWNkYvZXhqRjRrVXcwMm0zTlZFNWFnSG9ENHNlZ3hZNGpudTBN?=
 =?utf-8?B?dEVpSWtkcHU2SWZJT2s0NTVKYTVNTzRPRXZDaUlaOHJXL05GSTFjVEM0SnJR?=
 =?utf-8?B?QU1OaEhScTI5aE1heWJVKzFLdUFyTXlYVjBEYkgrbDhtQXZ6SkxNQ2pzWjJ6?=
 =?utf-8?B?dkUvamd2UlZCbXBVb25BeTVpcW8xejl5R09lS05NWnRlSWRVNnM1OUd0Wkdr?=
 =?utf-8?B?dWV1NThWa01KRi9lMWtmYm5xYytJT3hnOVVCYnp3WW83bVRUcGQ1V25aYkEv?=
 =?utf-8?B?cE13UlZtbkpmK1U2WVNKVk1LRlp5T2lGOVlPeVUvU2FlWUUycmppWm1vNU9J?=
 =?utf-8?B?cG9RYjFRTTNNWmVYZkJoekg2dk9DMTVhbTZNTXRGMmJLSWVLME81VDBrNzhQ?=
 =?utf-8?Q?15719lRqilE9h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnFSeDdzcXpxNFhzNEh4WURvSlUyU1Nva1dCcWVRQ21JVGJ1ZURxVUoyUTlV?=
 =?utf-8?B?VmpnbXVSZkhBVFZrZWIyL0JFUWlMaFRaMjlzSUk0L0pjKzRGbDVxMXNuRW1w?=
 =?utf-8?B?N1BOZnhibHVaemx5OXNDckN6MndMVXd1NGh3bTdHSUcyME5nSTA3TTM0Z2kx?=
 =?utf-8?B?MWdBOHQ5TVlNQ0ZKNXpqYUc4aTdrZUp3RXJJL0VpdE9FbTFhemtHVEQ2eFpQ?=
 =?utf-8?B?RVJzU09UWURGcGtaRHB1R0VBYzBjR3BuMTZuYjRMOFJuajFhakJsQVN6Y0tF?=
 =?utf-8?B?TlFpeWJROU9YZ0FJQytXSHVzRjVUUGNQelhLR000NVFRaW9ucHFJRDZMTXpn?=
 =?utf-8?B?TTJIQ09nb2NxdXhxc1JxeitLa0FFQkFodDRBNE1XZmtmUEk5MXdkMU9sVkJv?=
 =?utf-8?B?S3ZNSkkySmNWYUhRNUtIZk5SbWNRc0tYK3F3WVVjSHhhakdWYmdabXVJMW9p?=
 =?utf-8?B?dGE2akRKTC90OVpOQmRkT1dqcjBQUFlFdXJmTG5taEZ3NDkyVVJablFoYkM4?=
 =?utf-8?B?eC9xSU4ySnFPd05xT3ROZ3k5Wmo3eWFxMHdxN0QyMmR4TVJnSmUwVUV0V0gr?=
 =?utf-8?B?S3J4MmxmdkdnQUozUE04dkZUbHFGTHQ5TUlrb3RHTVRkeGo4blZBOFFZZDgw?=
 =?utf-8?B?ZEgxZm8yRjZPcGhyV2U0ekNnRDRkOXM4TDE1bzBZa0V4aVYzc2ZERld1bTgv?=
 =?utf-8?B?NmRKWGFoZHdITHdLZVNZd0txZGZVdXV6eVlMeWJ0ZjNTQ1czNU1OalNzSlFn?=
 =?utf-8?B?L1F6eTZMdkpmYWo4eDVXOU1Lc3RmWm53VmJISUtiK3R4cGZBK3pSenBqdHRO?=
 =?utf-8?B?Qjh0VVBXcGt1cEM4MXlMYmRGTk1pcUVlZWQzV1RpbHJkbEVHbllBQUREb2dp?=
 =?utf-8?B?QWNZVG52Q3Y1Vkl6YkZCUzUzT0ZIZHdlNU9pTXEzOFVKNUxQeFVLQU1mcEhk?=
 =?utf-8?B?eXB5Z0VoaWRENHg5SkdkMkdNZHpEZGxFS1JiOWxaUkx0THN3VXVZRmZiWkRP?=
 =?utf-8?B?UnBtMzl6eFBEZ2VQMnZENDA0M0phZkIvUC82MHJqc3lUOHVyZG95OWR4VW40?=
 =?utf-8?B?cFJaMnovdC9WQUhRQU15UEdGMmMweEtaMzI5bU5QeHh2MDRuMCtFc2hJMFVp?=
 =?utf-8?B?RTZiYmYvM1hkY3loODUrbGhyalJUTng0MmpueTVYb2p0MnJRSkhRaFV0ZUVD?=
 =?utf-8?B?MGM2THhpcG51YmgrQW4zOHZ2U21KYW02R2ZJOTdjUEo4eC9pZUVkUCtrOXpa?=
 =?utf-8?B?YjBOVGFkdCtpWWRZMFVaSnViRjU0cmVQYy9PZUZOUlBFVkoxT0pBaENWTUV6?=
 =?utf-8?B?Sy9xck1jZDJLdHllZy9RV2dKZkFtUlUzNnZQVVNTeFFyM0lQbWdsQzEvcXd1?=
 =?utf-8?B?TUFuWmZVNk9DZ2EvbHVFZTNoUW1yRnp6VHhlaXlQZnIvRkwvS3JuOUlUaWUz?=
 =?utf-8?B?aXBsOG1WYWcrc20xeHgrYWdzT0RleWRTOHZnejdHNldJVTZkcFRRdDRROU13?=
 =?utf-8?B?Z3BsVHB3M3JkOUpMclBKcG9ITlhBRWtLMXc0WFRLb2Zoajg1YmFhK2RiVytj?=
 =?utf-8?B?RnZkZWtIMHFBdmRYUytEQU9MWG9OMlN2d2RhOVBmTXQzMEJGc0lwTHBpNGdN?=
 =?utf-8?B?QkMxQTI5RHRNVEVhbTF5RG9wMms0eWNLeEErbld6eGg1cUFidVlpL0VKUG1G?=
 =?utf-8?B?QXE4Zm1ya0tjNldaVXZoeFkvUzhGVnlQTDU0WXBuNUlnOVgyZDBHTkZpZE1X?=
 =?utf-8?B?VWV4c3IzM09PeVB2QXFYUVdkSHNQbmpjOE1adjVqTjBFMzhwNzZEOHZJU3pU?=
 =?utf-8?B?YlFwckk0S25MeXEydHlZakkyWnpDSFU5NXkwRk1tckM3TVE1OXQraXl4aHd5?=
 =?utf-8?B?YnZVMEZyU0M2VEFGcGUyVVd3REMvRFA5U29WNHZMbTNKYTh5UnRDZ3pPb01a?=
 =?utf-8?B?ZWkxTHJCamNCTm1xNkJreldqV043a1c4YWpQcHlQRWR1SWdvWHRic0ZxN1RB?=
 =?utf-8?B?d3VGYVd4NWxIYmRJTitNWkMvMStrc3VBSkhIQzFBTjI2cjB4QlVJcEs1dG1o?=
 =?utf-8?B?VFdvbHNlTG0rVkNwaTBOSU42RVhyWEkwS0t6OElkRS8wTkRZODZEb0h3djl4?=
 =?utf-8?B?MFY1NitvWktaUGxLM1JoSStaTGVQTlo5amVIT0swaUo3Tlpxb2RqVUk3SUZQ?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V3s3LP6HYG5glFbqlJqjX8ZJvA0lbsOZs4L0mYBtwxTT8cCqAeHvRdvpMXoZhlSgEGv95V0dU32Wc2R8ClDH7rI1u41CxuSQEo/9NMLx0gmIKuEvNXxb5z/kqI5b9976slhpLWektDyae0xyjiWB+NnE7ZqYrp26ISW0ZjuHiWSsz7xcCWOf2HQejt02gpmcYuUfAD5D01BY1Rwy6HWEOHCXCC0F3PEJli3ogN77d65R6HQHndh0wH7Gga81T4AEhuWNszqJmej8en7LXbQhRHX2dEb5SXu8tzVvMxvqGxOXrLtfVv1YOqxIaWciG2Gzdlfv+wnt3e8sTCRHlwjS6hh2CRUc6ND6XrhuYs76GGK/sXxGAab8JJyMZUUtgV4913wJtyzpsehZ49NUKp2YuE5IIVmcOA/jSTT+KnlBQSZeUpl91wwXn6iFY/zhaNv1i6BFJmz+0tA/XkbhAw/O9YZgmCO1ZEpVNNV/ctSE3eB/FqzXFU0/LN/Q/qNtJWUnX1sGD80VqX+JIeg2SHBr3/SIlpAXezG3s51L2NiVMP6f9VUwXi90lI7aF29bZMXebsU7Wd2h7srpjF/2n8p4dvcqO+ZX501UDCxiUYaUkqw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acc124e-70d1-4c3c-3d33-08dd76b8125e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:11:51.2441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUKjQSqxr9SGTyaci995APPasMyWVTiJ7/t/Ov7PZ7sxnj0pUyad0dh0sg/gLnhPsGy74Qr1tkzlWg5rDgk7PwnwvqpNUWNfTwWXesa/Hyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080112
X-Proofpoint-ORIG-GUID: zGSv1hr0V-77VDVDgv7cp9ckgroqOAep
X-Proofpoint-GUID: zGSv1hr0V-77VDVDgv7cp9ckgroqOAep

On 4/8/25 4:45 AM, Cindy Lu wrote:
> On Tue, Apr 8, 2025 at 12:06 AM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> On 4/7/25 3:17 AM, Michael S. Tsirkin wrote:
>>> On Fri, Mar 28, 2025 at 06:02:48PM +0800, Cindy Lu wrote:
>>>> Abstract vhost worker operations (create/stop/wakeup) into an ops
>>>> structure to prepare for kthread mode support.
>>>>
>>>> Signed-off-by: Cindy Lu <lulu@redhat.com>
>>>
>>> I worry about the overhead of indirect calls here.
>>>
>>> We have the wrappers, and only two options,
>>> why did you decide to add it like this,
>>> with ops?
>>>
>> That was from my review comment. Originally, I thought we
>> could share more code. For example I thought
>> vhost_run_work_kthread_list from patch 2 in this thread and
>> kernel/vhost_task.c:vhost_task_fn could be merged.
>>
> Hi Mike
> I guess you mean function vhost_run_work_list and vhost_run_work_kthread_list?
> sure, I will try to merge these two functions in next version

Oh no, I meant the opposite. I don't think it will work out
like how I thought it would originally.

I think Michael's concern about the extra indirect pointer
access in the IO path may cause issues with net. For scsi I
didn't see any issue but that's probably because we have
other perf issues.

So if Michael is saying to not do the ops then that's fine
with me.


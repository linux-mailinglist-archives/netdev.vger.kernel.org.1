Return-Path: <netdev+bounces-251606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIelIDvpb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:44:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F34BA76
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C91A668E01E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A944DB8F;
	Tue, 20 Jan 2026 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqfjbotU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D147B43E
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937831; cv=fail; b=u0p8gD/sY32ofF3oQHJs1FGNwCN6JRNGKbsZZUmGICF4Sm9qeweKG0eFWp6wd4FPYjGeCZmWmt9ROok5OxRsC5HIT4G0wZ26KZIM8AgEdQSweLqvMXT+w1jifZbsJAPqf9ofBnIVYBtlakY+oeoe2Z6SUtvGKaa05VIynGPBmKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937831; c=relaxed/simple;
	bh=y4whi49A4AbB6tTpsSoERceFVy9VhLfM8soL1ngtnpM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z3JLSmG4VGdN8AkJYzoXxPTJYkuC2SrqG46chA1DHzpgptcrDtB8C6JvD2MOr9Ze4bv1sjDNpygxsMNHUmFPRJn9OmfxchtRO88ZO0WBD6Nv63ShN7KfMWJI9WBCxh6EhpIUCGXNY8CvfS/uNmyCtcV4Mgv5hP0bGLNlo++V4kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqfjbotU; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768937829; x=1800473829;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y4whi49A4AbB6tTpsSoERceFVy9VhLfM8soL1ngtnpM=;
  b=AqfjbotUSSbMlx+1sTmOPOnuZGTpKVXkjOixc2O9IXMPV2gRoVi5CHoc
   /+Q1fuuB0KSG/zW5ubfa06JZ1w7MbtzLarABSHpwG0vG74DTeuv3vxOPf
   NXhTNpjuFbU++tnxAFNUpV3fm+uE0qj+QNOzFJUqKmyjd6bXBc4zcfgU8
   wdmaSBIHLZvyzrOv8OgxeYr6aEniqAa0nC20roKLnTVrSdxSN9JRDYe0+
   8Lf8r+4MIoaC2MzfLwTdEAubuCr7h4gpB2XIe3E3ttmpB8MNEznoJLPqH
   yFbAJlYiZpsMWihdyHcXiZa+0yD4yXcfunIMDBqJ3oiRhTHKKloywdKK7
   w==;
X-CSE-ConnectionGUID: 9qwhL+3FQmi9AccYH8Ac7Q==
X-CSE-MsgGUID: 37fmI0/NRQ69sBbAbwUr3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70063092"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="70063092"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:37:09 -0800
X-CSE-ConnectionGUID: QV12rDrwRgSKbhjuF4vlYQ==
X-CSE-MsgGUID: x1/h8+0LQryW6fdYl76tQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="206455528"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:37:03 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 11:37:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 11:37:02 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 11:37:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+1Dx9FJLQSaUYS76AOciljcCMxhObFCaF0yisq7JM0mkdRtyJ6sAgL5r4gxE1Od8r3LkryMQhfkIK1pGATBtnDtT9cSJPV/WzeaQ2jeJXvfQHTfJm2NECls9Ta8yhpcdlW/5tDXzaWhalO0yp7XSA8at/ZhCeGhEXSz4yFIvnHI/pmGme5MaWw1Ln8+r/0UPjlPO1Bf17BldU5oAp2EyurXVlo2PAFEYU3/WoghC+Bwiq/fBSgt/p6IdJcT2CLgZMqS/eau4l0whWiHThsuyNXc8C/VzX0yrVUJHq70gEvUck4gA6RBGa9CMznc1d8ggv5DeaRhoX/hcVGuDrLopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6OJg4B+EYySDd9ZnYHerKgZArD9hrVaYMGOh2OjOB4=;
 b=PvDk9OX0FTdYB84m3U+Grr5tIs5po68phOEFTCTguCpfvpF2zlRZz+vjfqopvxqtMdRKTC4/b59EUrCTmVn6F/9iFHPUgt3jh/NBhfhzs8BXjkw7iMAdOlleoV6+M/m/Zq+ROkDM08uOnTirY339xorhoIHlnhkxFIO6ZYze248Gt8SgFo2VeMHOp7nD5OWroU9f8tvRuDQwrbytYiT8C7cqiDIoMUzSDz8UJhSEkA7LfK8E8hFTBxB9M39blr6zL5GmezwgWrLIsBzpSF45eJZaCn2Ts8oYk0WxkD9mhlw5C9ZJGfPH2jcSUs/gu8bPklFAeh83n37ZEASZz9mJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB5190.namprd11.prod.outlook.com (2603:10b6:510:3c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 19:36:57 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 19:36:57 +0000
Message-ID: <52cc5ddb-cea3-4502-936e-4f8a6d45b09a@intel.com>
Date: Tue, 20 Jan 2026 11:36:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] idpf: introduce local idpf structure to
 store virtchnl queue chunks
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Madhu Chittim
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>, Milena Olech
	<milena.olech@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Samuel Salin <Samuel.salin@intel.com>
References: <20260115234749.2365504-1-anthony.l.nguyen@intel.com>
 <20260115234749.2365504-2-anthony.l.nguyen@intel.com>
 <20260117182523.6b6c91e7@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260117182523.6b6c91e7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3af8a3-85eb-4f16-ad25-08de585b45d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUdlamhGL2l1VjVBSjIwRGkwZzU1VjRwVGhoTDVjMllDbkpCY1lUYTBpSGxx?=
 =?utf-8?B?ZmFGWmVTMHZTVmVXdDRPMDZBeXlkcjNLRjZ1ZFEvT3RtcDN0TUlJc1YvcGZD?=
 =?utf-8?B?VUo1RnlVTWhWSUc0bStSUWlMUjRUQkdqWk1xWDh2MGgyUEpGcjBRY3Q1dnZX?=
 =?utf-8?B?ME1reHpqM0JLZEtxdGcya3RVWGxhdUNoekJVK1lJZEVZeUhpd04veHR3VlJk?=
 =?utf-8?B?L00xeGtnaXNST3k4RHZvQVRnVGIvL0JTN2Y4YTlCaUF2YU1pTTdzTzhXZzBk?=
 =?utf-8?B?UEhOTEtQVW5hUE54UFpDeFVrRElMaTUvSHdoMWE2WjkxMS9oQ2FpS2ZuWjRq?=
 =?utf-8?B?L1U1NVlvZkpOWmZUTHRzNGRpaUV3T21mekV6L2hKci9YZVZsYzRRZGVMaWNL?=
 =?utf-8?B?elBGdUE1aGxySzltQk9UZTFFSG1JVUlqNkkzcExjMlV4Z2dWY3R5TTNWbUtL?=
 =?utf-8?B?WnNhVlF1V0x3cXorUWZBS01VNzN2UmtFdTlpcmx3Z0p1QXVRSFpGd0RaMHpZ?=
 =?utf-8?B?bXhyZ0xVMDc1Q1c2NkFjekw2YUt6THk5U2dHRjY5ditJNnNXZTBaN01PbWhm?=
 =?utf-8?B?cjZhUHMvMGRuNGhFa3orZ3lPQnpxTFo3WXR0SlRKK0U1aXJjRmlQdWprVzIw?=
 =?utf-8?B?UlFrS3VnTm4vdUwzS3ZuVXhPcGxJMHRWUFFuVDJKM2NFWkNQL3pvTFp0OUNs?=
 =?utf-8?B?cG5JcTVGU29FdWRsWGlpRldnTEl3Rms1MzVKSVVxZDVSSEdyMm5ISDJjMzVz?=
 =?utf-8?B?aW91bGhlcWVYa2lvdjFBZXhFck93OVY3TEhNQUYwTk84dGNuWThXWThuTHA3?=
 =?utf-8?B?NEVGVGV5djI3ZTRkUkVOQXhKL1hHTm01bmVTVlFWempRQlhydWpOeHpheHFD?=
 =?utf-8?B?QWlaV0UwVWNXR1ZsZzRYbUk5NU1id0p5K3NrVTlraHNmWmowdU9tQ0xibVEv?=
 =?utf-8?B?bnI1Nlozb0hvcE1ER1pjQllMNEREdkNxZkJmQTUvbmJoRVRDUHNxb0dnR25N?=
 =?utf-8?B?YmVCNHhZcmlRQ2wvU2ZHa0VGN0t5enY4aE02WkpzY1YramJHNDNPZVl0RjE1?=
 =?utf-8?B?Rzh0OHhkNEVPRklqODF1dDV2TWpicll2bTE2VVROdmxhL2JCaTlhNktGVEVi?=
 =?utf-8?B?c1lvYmlTSVhLUWJKQlBtS0x6em5SMXZ4enF2dkpTR0VMcHBTMUVTNDlQMXBY?=
 =?utf-8?B?TkR6c200NkQ1S2J6ZkZIc1hrY09wQW45ZnovK2ZQbzQrKzFDN0ZyR3RzSmoy?=
 =?utf-8?B?S2lZU2VPQnN1SG54ZnN1NFVuc0Y4RTcwNHh2OUJnblNBWFBpYVRBU0hTR2hv?=
 =?utf-8?B?VjFoalJoNnREUGtYdjV6N2F1UDdYbXI1RWZKczVuU0kxS3RqUlppT2VhS01U?=
 =?utf-8?B?cE5tS0szNHRiaU9zNHZQSjdvOUsyMG5RV1U0SFBwVW1VU0ZCZkl3NnU5MjY3?=
 =?utf-8?B?VnAvemJUeEV6QkRkeG8rZzA2a2g0cDZMRTFJa3FYanRnd0M0dnIxQ3g5VU1S?=
 =?utf-8?B?TE1hNUdIM05zanhrUFd2UnVWYzdMZGx3ZWVtK01icXJrTGJLQzdOUTlha2pZ?=
 =?utf-8?B?bkJUTndldG11OGN3R3RWL2ptMUZGTkZZLzJid0VTc2VmREg2V0FQYVNoNnkw?=
 =?utf-8?B?dGoyMncyLzMzTm03UlNsaWhJU082Q0NUMnpTdU5EWnVEYktsVFNHNU1GMTQ4?=
 =?utf-8?B?N2hidGthVUZlNW9DNDQyMm9kSGVFV2txWmRmaXhFbFpOOUZDUXVzbDJjR1hh?=
 =?utf-8?B?UVBsSkljNml2NEdvaVBCdTUwaEI3Zml1OGsvSStjUFM1YmpxODYwOFpmcmFH?=
 =?utf-8?B?VTlSeFByaXROclFUeC9rU3RQQm5FWVY3QzlZRGlnSm5RMmo0L3lvbmM2MXhQ?=
 =?utf-8?B?aEV4cEU5dUxkTE5CUjdCczhjS0lmWWRFd0NodlBreU1lRGxjbkhXY1A2Wmdu?=
 =?utf-8?B?VjdtQVpLcklGRVZNK0E4eE8xM0JiQlZaaEJPSXI0RFRNYzhKSXNkWHcyelQ1?=
 =?utf-8?B?VXNtRkNYS1pqWlpHZkRqUFdxT2Q4VDlmWklQL245MHBjaGdxRldiSjUrUnZX?=
 =?utf-8?B?K0VtSUYrVjduckl2OS9xWGRiQWtxREJBdy9SWHcxQ3FvRGZYb3B5dkNMQk1S?=
 =?utf-8?Q?twX8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZWd241cjY2VHlwTVNMcmlsbGF5VlgrWXc3aFpFMFdWZncxblhBbmdxNFF1?=
 =?utf-8?B?NEh4TWs3M2c4QnVObFRLcVQzc1ZBRnNpTGE0NEhJN3JoRFY3MnBVa1FHZ2xi?=
 =?utf-8?B?WnZsbTI2VXVvWDlOZGNsT3N0ODMyUXFtc0E1VHJYYTcrTmxqNzl1R3ZRSlZV?=
 =?utf-8?B?WG1jNUtuMjNuSlRTM1hrczJ0VWFFMWhmMWg3U1BYRmh2Y1daeHNIeW5LQy9G?=
 =?utf-8?B?YVpQMmxBTEMycTcxOENNZjdSRVc3UW5sNXFSREc0b1QwUFhYTTFjVWgrT3FY?=
 =?utf-8?B?dVloNmI5d200VExmOWozVmJtd1UzTlpZaU90K2NtcW8xMThXQjU0d0hCNVlK?=
 =?utf-8?B?R25hSTY2YnlDVEFLam1YUERSWW94VlNkdUNScEw3YzlSSlpZSUNjVHVvcUVU?=
 =?utf-8?B?SFJpWlBEaEFRWEVsbmsxenhXbm92dzd4T3BCWFhab05QQWNvUnBtOXRMRU5B?=
 =?utf-8?B?RFM4NjdvMEZpSXZObTBLWWJ3UXJkQVlZTkR4dm5oVnBuSW52ZTNFa3NqU2hK?=
 =?utf-8?B?UFJNeis0dm90eDg3ZDdEMXdVMDUzU0MvMEp0Q1J0Q0YzV1hyNjEyWWRJT3Vm?=
 =?utf-8?B?Nk1wTGRlNW9NcGc3YzRoVDEyYjdoK25hTzhSeFBveVpucnFRM2tUckNXNGtW?=
 =?utf-8?B?UVl3WHdUR1VMSC9OU0lwYkNrd1hqNjlWRnM3K2Fpc0UxaXNNcm5LZzFtK0JC?=
 =?utf-8?B?a3FhZFN3SHFGV3ZvaUxNNzdpQWd1NDRlRzE3dzRpSnZRdUZLTWlLc2pmdnk4?=
 =?utf-8?B?NW1BKzF1bWJuak9pYkU3NldKT0paOXY1R0VISUFXYmxNYitlZUxHZDVGVDRo?=
 =?utf-8?B?T3BuQ1h2RVE2RW8zaVF4NHJaWk5HTFd6NUx4T3MxUC9OaE5rMldHb2d2b3VD?=
 =?utf-8?B?SXRtd0VabE5DS2NWREF4NDdoRTdRRVkyOTRQanVjZlZsNHN1b0xBNVdtREM1?=
 =?utf-8?B?SzlGaWd6Z3N3VGxSUUxoajNBUkI1blE0Tk9nUDd1d2MyYVZqQUdtVytyNEd2?=
 =?utf-8?B?azJHNGtESEV0YzFneEd1UVpFSmNibmh2Zi9zbnFxa1Bjd0x5UHUzQVc1OUZ1?=
 =?utf-8?B?VDNHU3FYMzlNTXZHV2d2Yk1nSlV4ZWZkcHhpMTZzMVFJdUxORmQ0NVJ0K0t3?=
 =?utf-8?B?RS84TFJFeENWWWFrdDdYT2VoZUZ1TFVZbFJya082NHhJbkUrTk5MYWplNWdE?=
 =?utf-8?B?Z0ZUUWFDS040anUzOFlTcVpxOEc2TlZZOElTUzlCSW1BZHYwcHQxNktHVUxj?=
 =?utf-8?B?M1gzWUVhNzlTVHhQNHJPa0ljQ3FBNDZ2dW9OOC91Rnl1d2o2UG1ZSFQwS0Ex?=
 =?utf-8?B?NkQ5aGJqc2lSNUNBL3EvbnlNZ21uRDZSRkNDeml5QkV0WldvNFUwRXFSRXBO?=
 =?utf-8?B?R0s5cHI4R3E2SVhqM3kzUlY0T2JGQTF3dVRLWSt5SzdPdSt3VU1RSHhTY3BU?=
 =?utf-8?B?R1kxdFNLMnpuNFB2dlVWSUE5U2RVNVBLbHJqdjRFRnRxZE54OGRCRlpyRnlO?=
 =?utf-8?B?SGRXV1ovakdicW1jM2hKcHV6cXVoRitzTXRUZmZzaFpVMXl4MzUvcWRMV3Nm?=
 =?utf-8?B?a3FURGlSNFo0VGJyRFF3cjUzanBSL3NiYVJqWmJ2MUl4aHhkVGU4VXpXZ1Yz?=
 =?utf-8?B?aHlEZ0lVVVhNR2xobjZlU1Jrbi9pVGM1d2tMSVFEWkNlM2tFaU0wSFRmWWxr?=
 =?utf-8?B?d2gzN2thVkpoVVpqRDlzeHFQa2c0ZVhDQWp3RkF6VWhqRDdqdm04UllyRHlK?=
 =?utf-8?B?ZzVKZk1xTjB4amltS0Z3UUpic2ZpaXBtL2lGUnc3bmdnL2VzbW1zcFJVWXRp?=
 =?utf-8?B?SmpzdngyWEIxdHRhMjhIOGxTditxQ3BUNXJHZkdUaTJRMTlibHVoeHVnTWlL?=
 =?utf-8?B?Q2dWU1h4YVgrVmllYnA2YVNPL0RqdUU4T2dva2ZzS1dURDExYkVnN3BwVW9x?=
 =?utf-8?B?eU11cTZnVnF4bTNpVkQ4RjV4Q1dId1BoUER2Rk9oQzVuL2IyNU54VDhCbkpU?=
 =?utf-8?B?WEc5bmI4bEs3K3hudk45aGpka0N3V2VhelNnL3N6VXZWNlU3VXNjdnFhc0pR?=
 =?utf-8?B?UUFFbTRUYVBENzVZSXB5NythbFBndFIxSnBJa1BDT01MUE9yMFJkNkdIVmxw?=
 =?utf-8?B?S3g3R2RscUtvRmEyKzZDU1pYeXE1cUFRQmkzeXk3L3FNaldraVZ5WFdqQzQz?=
 =?utf-8?B?WDNGTjJkVkxzR0FxeUZLZElta0tRRXZTNmx2SnRtcVpVWmNJY29XQndiRlND?=
 =?utf-8?B?NnlDbnE2OGhEZGJJWDlpVmc3b1hudXZyYVRYdmp2cG04VXphM2U3YVJnU1ll?=
 =?utf-8?B?VmZ3TlRLLzhmZUY0S1hTMXZzb1hCZS9aOWUvNlhqazh2Z01OSkVudXlkRTdM?=
 =?utf-8?Q?AdBx49aCC9YyjhJs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3af8a3-85eb-4f16-ad25-08de585b45d9
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 19:36:57.7015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsxUUDIxDC2HDoAQA9noxKx17E7x296IGGnNU+bsxJgEETmL5fFo8hbGNhqBzbmY3kv3PAAuDAqJ3x0jNyP9GZAhvU8FkOem4Bp+AEk6ka0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5190
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251606-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2A0F34BA76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/17/2026 6:25 PM, Jakub Kicinski wrote:
> On Thu, 15 Jan 2026 15:47:38 -0800 Tony Nguyen wrote:
>> +/**
>> + * idpf_queue_id_reg_chunk - individual queue ID and register chunk
> 
> missing the word struct

Oof, will fix this.

>> + * @qtail_reg_start: queue tail register offset
>> + * @qtail_reg_spacing: queue tail register spacing
>> + * @type: queue type of the queues in the chunk
>> + * @start_queue_id: starting queue ID in the chunk
>> + * @num_queues: number of queues in the chunk
>> + */
>> +struct idpf_queue_id_reg_chunk {
>> +	u64 qtail_reg_start;
>> +	u32 qtail_reg_spacing;
>> +	u32 type;
>> +	u32 start_queue_id;
>> +	u32 num_queues;
>> +};
>> +
>> +/**
>> + * idpf_queue_id_reg_info - struct to store the queue ID and register chunk
> 
> ditto

This as well.

> 
>> + *			    info received over the mailbox
>> + * @num_chunks: number of chunks
>> + * @queue_chunks: array of chunks
>> + */
>> +struct idpf_queue_id_reg_info {
>> +	u16 num_chunks;
>> +	struct idpf_queue_id_reg_chunk *queue_chunks;
>> +};
> 
>> +static int
>> +idpf_vport_init_queue_reg_chunks(struct idpf_vport_config *vport_config,
>> +				 struct virtchnl2_queue_reg_chunks *schunks)
>> +{
>> +	struct idpf_queue_id_reg_info *q_info = &vport_config->qid_reg_info;
>> +	u16 num_chunks = le16_to_cpu(schunks->num_chunks);
>> +
>> +	kfree(q_info->queue_chunks);
>> +
>> +	q_info->num_chunks = num_chunks;
> 
> AI review complains that this is set before the alloc, so if alloc
> fails the struct is in inconsistent state. I didn't check if this is
> defensive programming or the callers handle this error correctly.
> But seems easy to fix, so maybe let's?

Yep, will make the change.

Also, we'll adjust the other two in this series that the AI review 
commented on as well.

Thanks,
Tony

>> +	q_info->queue_chunks = kcalloc(num_chunks, sizeof(*q_info->queue_chunks),
>> +				       GFP_KERNEL);
>> +	if (!q_info->queue_chunks)
>> +		return -ENOMEM;
>> +
>> +	for (u16 i = 0; i < num_chunks; i++) {
>> +		struct idpf_queue_id_reg_chunk *dchunk = &q_info->queue_chunks[i];
>> +		struct virtchnl2_queue_reg_chunk *schunk = &schunks->chunks[i];
>> +
>> +		dchunk->qtail_reg_start = le64_to_cpu(schunk->qtail_reg_start);
>> +		dchunk->qtail_reg_spacing = le32_to_cpu(schunk->qtail_reg_spacing);
>> +		dchunk->type = le32_to_cpu(schunk->type);
>> +		dchunk->start_queue_id = le32_to_cpu(schunk->start_queue_id);
>> +		dchunk->num_queues = le32_to_cpu(schunk->num_queues);
>> +	}
>> +



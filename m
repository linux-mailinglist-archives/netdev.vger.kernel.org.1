Return-Path: <netdev+bounces-243148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E95AC9A0D5
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 06:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00033345B2B
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 05:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE41C29BDA9;
	Tue,  2 Dec 2025 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6rYzgnC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD21CD2C;
	Tue,  2 Dec 2025 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764652119; cv=fail; b=sualEpTfoqEJa1BFy/7dJk1+Jfxzj9CZlZ/q2EF0+0gs+JWT9jUuIL7aiXwIFkXAvIz4R5wevHvMe/LikEXt1lzMmggzjJZuin0AlcIiR8LuIsOVBklgjq99Uc4fpxEe+RWNShZf5Y1PurOj4KQDj1s0C4ly8uA1Eo+7yb1ODvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764652119; c=relaxed/simple;
	bh=XtDMF0wVcW8CqT2s154qj3cCgEzv+DF5/Rhu25RsVec=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nsw8JAOgb+aF/MIM4Q7jriWGef+W/CLTdMsLln0snDJb4fhErtx6onUH3aOI4BYKoyTTbu6I+zvaOFQaYEsdzfOS7vT5vwYh8RY5ZdWTKuukZHiDhoVDxzsA/82A1SaF+L8iSza9UY7SmoucUEQMv8Xj+sj1vztE/I2ES6TjUmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6rYzgnC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764652118; x=1796188118;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=XtDMF0wVcW8CqT2s154qj3cCgEzv+DF5/Rhu25RsVec=;
  b=d6rYzgnC1SPaMySslDEn6FMaN/PP4EyGkh866SodXvSfi+jH9dQ1sjVU
   rJ2dErVaH9nlI9/tLsgw4+qGdsV64leUe+l1w5eqEWaVjrv2eoFE+4hd9
   943SVeH4859ewptZHj8Bv/Mot5iBg0LG9ZZkLF6h0ug3RNclDbvaBn0Xt
   QrMFvdsfndZHIS4H3MnC/IeOo/pE4xkaaKXzBcpz0AqnAvZPXAyKjEecQ
   px42ujRVj7dAFl0x39pFJ5grYFFdnv83HcjJCF1jD08XgPI5HAXxxIRuR
   SNuTDWAvSNTQHuSWZgiUfqeuztnawlGOmE/DfF9QWBEpgc7mdGfR9bi3u
   A==;
X-CSE-ConnectionGUID: +UT8BIjhT+adZQXfG7cksQ==
X-CSE-MsgGUID: fs145hJSTO+kW4t0VsnjhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="65796371"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="65796371"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 21:08:37 -0800
X-CSE-ConnectionGUID: 7zEfNNdxToeksf+ngybZew==
X-CSE-MsgGUID: ekvGjk3zTJaHCUt1DM7/7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="194485501"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 21:08:37 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 21:08:36 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 21:08:36 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 21:08:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OudTjjRSz6OJYLXw5L9ggqmJC8s6PJSqxz5XWetjXJDPyn1jGfLS0USNvqpr8/m9I2T6ZHZRZI0yn5LmFvMesptL9QFTJCgyawAhQfqGde0/jxJJ/DVaO+oaZM0/rju4e7j5L6dGUtDU9GQmG83bVZxaA7VqaDsoLk4IiPVfe+inSYYSozBCP01RIaY1ZWxTZ37Z39bIjFrzQu/AV3JCXtwArznLAl/sgblTFgPdC7ZUUewBpNouBAgp8G692YMkq9SvP+/ya7xBpM/0HkC+gs/e3hmO2CgLnGQYuBAbwF6fk+E7tNlYB2Ljoo2L3q/mW8YNrL5ppzMI51tD1H8ZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmPTTVAK87u5ZRSWxVaj8YBY+RpJo2D7oIeFBDAxXW4=;
 b=JVfPpSbl95M+582Lsg1fq1X0KDre3Hgd/JRBwW7znp3vUDJhI66dGX9oJMne8D+crFKig1GPSjg9Pu24qFwX3pLDBytn1ezgCg+wzls1vYBF6Ixly4aZ598kEyxZ/hY/rTE37+Ezs+BeDr4B8ad9dV32Es91E4hV4FIoJMbIER5OmDzTZCjh03AlqHSWZFBi1AwqW0xQYsScEJMsc5kbU0+pgq+5LUpwLC7kzfACLhr0Wf+J3Pkjhs+HEOA6zzCsxTesf+DAkJOr+e5KfVjG8h5uEuwcFAkjnVSFEF5FDJ9dc4jfnlLaKP37sglewuyDg8NSg+VOjQF0d2xiMU+P3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 05:08:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 05:08:29 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 1 Dec 2025 21:08:27 -0800
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <692e744be5e1a_261c1100e9@dwillia2-mobl4.notmuch>
In-Reply-To: <20251119192236.2527305-4-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-4-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v21 03/23] cxl/port: Arrange for always synchronous
 endpoint attach
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:a03:80::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: f233a2ca-479d-4478-65b2-08de3160d4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWJUczRlTFdtR1hvNDdUZGdtVXhHVVB1UVAzdHpBZXByeUpvVUExWnoyWENV?=
 =?utf-8?B?NDRvZWl1R0QyWE5Da0JVVnR5cWJQY2JBWHVQams1S0NDMGNSN0tXV1pOempU?=
 =?utf-8?B?VjdaOTZNUm5VTTV6dTNvWUFvRTlvTENNQjhZVjZlR21vd0JWWXRJKytMRWFl?=
 =?utf-8?B?TXdKRjZVdWpUMjdQaHNXSWR5dmMxdnFBbzFka2RzcUZvUktwclZPUXAxa0hv?=
 =?utf-8?B?dUNqam53bkk3QUQ5Nk5mbGhuOXE5QmkwYVJtNkxOWDl5eWcrMThYdFVnVER0?=
 =?utf-8?B?enpYSWVKdlgzak1Gc2JUbXlkMmxhbXBZejZXYjV6WTlNQ1JrTUZRcWpVNURK?=
 =?utf-8?B?bG1pK2F5R0hSTEY2eHExeU9VUlgxSWxiY3k1S0xKNUxUK1draUhMUm9CRVU5?=
 =?utf-8?B?RjJBVlBaT0wveDZoaWFyVEdJeURMMk9DYkFJdTV3TTFONzVPYXUxdXhyVkdC?=
 =?utf-8?B?MkJiMXJaTmc2VDNjQlF3eU9XRVpLYkY4NlBtWnNWOEVpcG1BUW5YdmhkRTNL?=
 =?utf-8?B?QllpU1JxTjNPKzF0alUwakk4QTdmVjh6YjE0eUtaejdGQVhORisvSGtZU1dr?=
 =?utf-8?B?UEpNcDFnWUNqenYvRW5FYmhaSjRpL2xsemZWTGJMN1RTTStWTE5ISHU3aGZQ?=
 =?utf-8?B?VThBUGt6UjExMkx0WWNMMm1pUlJSUnVTRmczS3N4NHZoem9EaGNMTGlTVlhS?=
 =?utf-8?B?dEJHWmsyZ0I0cnhocW1Cc3c1aTJHYjYySGdSejl6SnBIdFR5UEd6NG5zMzZu?=
 =?utf-8?B?RDh6Z0MxaFYwNnU3a2J2eXBBUFF4L2FpNWFSeVNWVDRLMXAyd1BWd1B0aktl?=
 =?utf-8?B?N1V3WmtteE1TUnRoenhGdHRWeGNBYjBCZytnVEVvOWJmNHpGUkRGT0hoSmI1?=
 =?utf-8?B?VnJ2RXVLY1JDd0FldlJYY1ZldFNkUC9VaHBUSnhOWWlKeTVNQVhzR1R4cWV3?=
 =?utf-8?B?cjB3WlhjVUdrdDBOTUsyMFR2TUtuR1paYlRPN3B2eFhwaTFyajlydHlKeE1W?=
 =?utf-8?B?Yk1aM3RFZllrTWN0YmZqVmwvMExKNUZjSkt4SzkrRVFOZkplYWZDZmNJWWkz?=
 =?utf-8?B?NS9DU0pzUjNpYjB6TFJBRkd2Y0ZLcDVmajREMVhQeEYyTExFckpheDVhUVdt?=
 =?utf-8?B?SlFQZHI3SUJuRGJFKy91YTc0STVnR0VsNUYwZHh3b3RQZllDOFJzRTZkK3Nz?=
 =?utf-8?B?TUx4RXE1WXVCR1B6MW1leWtYSDJqZmRjMHVhS1ZmNmc4R1g1MEhxM3JyYjFl?=
 =?utf-8?B?bCtSQzFNUFJOTjRjb3c5bGZRRlBkWWVFWjJnM2ZyN213WVA0QVkvV3l5TStZ?=
 =?utf-8?B?M29tYm1MMSs5VGhYbFVRa3ZOekFyQkMrL2pDLy9UTFQzYTZKdFN2akhvdTRl?=
 =?utf-8?B?RVhXWUo2UnVZSzlKSkNzaEVUVk1iTEdSVlRVRk1ObHlPZEYxcTM2R2hLMkkz?=
 =?utf-8?B?ZzJBd2F3elZrcm5iR3dvUElUL0hzc2V0OTAyWTBLYktESGxab2hjMkQxWFVQ?=
 =?utf-8?B?ZlltTXRZcE5hbkMycm9SNzdLNXRoMlBuUkxrVjladGxqNjZKL3pzSFczOXE4?=
 =?utf-8?B?UGtLMGdVSDErc0N2RmViam1qS0RIV3VkM3dwbkREMEI2VldhcVR3TDVHK2hC?=
 =?utf-8?B?ekw4MVpoMG9zV2FlMlBkTExyYk5MUlF0eEdGY2NHbFNEZ21CWnRhbjh0cWN1?=
 =?utf-8?B?d3RLbHU4SC93UWZhV1BMVFVGZ2p5UERRTWIyelYvb3dSbFBsS2JRT0N0djFk?=
 =?utf-8?B?UDhJYjA4NkJBTlRMdFM2aUJSMTBDczZ6V3ZGWmtRdkVkdFM5MnFzT0lXL0Jr?=
 =?utf-8?B?Q1FBTGswTm1QL1h4Ui9kWFJTS21pbXB6blpQbm5mNnkwZG80eFVUQmhZYk5T?=
 =?utf-8?B?TThsR0NUT2xWcXZPaG0rd1FwRG9MaHlqbzR1c1pMZk9oUVRNVWo5MXQ2UUtG?=
 =?utf-8?B?elVmOUNMemk1U242bHovRnE5WmlNTEg5dDVuZm9CaHFZSHFCTGhsUTdza3J5?=
 =?utf-8?B?ZXFMMVlNeWMxb1A4aVhmYnNmNmtrME16YW9SZHVveGtTTy9CRjJBL2g1VnBJ?=
 =?utf-8?Q?0X+15L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmprT1FzVjQ4TTZLV0JtY1lWbFFKV1VWZllEMTRIME1zcEVodENBd0UreVhp?=
 =?utf-8?B?cXp2RDBDTVo0ekI2MXFEVFlOeVRHTk5mUXdJQmZYSE82d2V6eXE3R2l2UjZn?=
 =?utf-8?B?cmxMMUdPb1JsOFdQUDVoR0cwa3JyTVN5aFIvU2NoSjBNN0plRGxlYmJ4OENs?=
 =?utf-8?B?Q21xdDhHZmVOZUxHZlNvSkFnZTd2VUh5ZDV6Vk9pSjhJNnMrSWIzczN3OGw3?=
 =?utf-8?B?RHdVT3JpcEJQY3c2dHpqV1Q0UGIzbnhIMUgzWGx3QjNZc2VoWUhSMTJDUWVq?=
 =?utf-8?B?d0pQWWxKMHdLdzNtd3dkYWIrR2RLN0NMbUFzMDVpdXRWRW9UdzBCaExzMmVJ?=
 =?utf-8?B?K1ovN3FIOFJzMWhXcVZ0aWxkUVVXWGRJL1BtN05SVklBTUZmbGJWQWxiV2dk?=
 =?utf-8?B?Q2V4bThYU29tNEJ2Y3dBdnl2em5qL2gyK1RjRUhrYlBCRFRtN0xHcVhoTWtM?=
 =?utf-8?B?Q2FZYWcyd0pIOE5yampYWE5NZWhyOWNWYmRud1RrSk93QzJZSXdHNVZqY29Y?=
 =?utf-8?B?WjdIa2ZscVYwWVU1UVpXNExDTUVjZ1NPY1hxbk9FZ3Vnc0ppSXRLY3lFcy9G?=
 =?utf-8?B?bmZpSjI3ekxzWngzR0tHOGlERVZpSTh4aURmSFRnZmZSeXlZOWl1NTdtQWRa?=
 =?utf-8?B?RHRkME53eW1XcDV3dVd3dlZZNTY4UHVHT2V5MUVJTTlCaUEvS0d4azMzUExn?=
 =?utf-8?B?VTFSQlRjNER4YU5MVktWNk8zazZ4SU13YUFMRi9JR1dpSksrY2N0SnpOdEZ1?=
 =?utf-8?B?bFlBSG03aG56VU5FL3M2azlJU2phdXVBUFZOeVRKb0JlTTU5VFRqcGljWTVK?=
 =?utf-8?B?eE1Cc2E5QVVULzFhWnJuNytFaGJYalRNTXBaOExCZ1NQYW9LcVlteGk2ZElh?=
 =?utf-8?B?SzVGaUFJb1B2SDBRSEdYdnV2eEs0Vmx3eUVGLy9LOEJmODdwcFltK2VSYW5r?=
 =?utf-8?B?NFg2emtYaDI4bkVsTGFVKytQc2o1Z05qWEVzRVEyemgzU3dyQzY4VkVZRTFi?=
 =?utf-8?B?ZGhUZzJoRk4za256QWYwQ0dFb0phVzlhMjFDcjRuZU5kemhlcWRBNWpTRTR6?=
 =?utf-8?B?MFJERUJYeG5kSWIyZlZTNkhXUzhkT1VQcENzTHFPQkE0NXhCR1lFZm50L3NB?=
 =?utf-8?B?VC9VV3FrRVl0WEg1TWQwd04vZVgvaTJscFdRekE4TExpM0s4emY1NUtvOG5H?=
 =?utf-8?B?TXJBOTJ2ejQ2UDNwZ1hHWk9UYWE3TE5NZ2p6bnpSL0F6N0Q1bnJPb1JwbE14?=
 =?utf-8?B?LzUyRXdTN3lGd0dYN29Zb3J4M0ZNQTIrZ2FWTUdsRFBicUJOOFJKT2kzYTA2?=
 =?utf-8?B?VDJWQ01BcXhhN0RLVStscmRtVFVaRzV6QUEyVGFscWp6U1lxMDZOWW1La1Bk?=
 =?utf-8?B?VlNITFRzS2lET0k3TXRxM2tHQnRHaTZLMlQ3NFFOYVFVZUxuK1JzbTIzc0pj?=
 =?utf-8?B?VEtIWkpKZE5OL1dBN1lxNnROU29nR1RDTVkvbzQ2ZDVJVGVqdnNodWNQak5L?=
 =?utf-8?B?MDRZMnlDUE5mQVAxek1KejExZ2o0WTlKZ21XNVVkRUE0amJkNFJYTFkwU0ZI?=
 =?utf-8?B?V2Faa3psTFVVWlZNdThmRm9sa3ZxTFpITFlwYUZ4RGxGK1BvdUh5aUhKWGh3?=
 =?utf-8?B?b0V4WjNWd0d4eEVMVSsyK0Z1YjMwN2hIcXFGRmVDUWlFak1nNm80RkpyZjdB?=
 =?utf-8?B?cE53c3lGd3hYemhnbWJwTGlqL3crNEdDcTFkUWE2Um1aY2tZaWdsOHdScHda?=
 =?utf-8?B?WmFVL1ZDYml1Q2pCcUZZbHNZalVyajVqQUdyTlBHSmhYcmlKYmlHL3BNUkJa?=
 =?utf-8?B?eENGZG8zdG9jSHZ0eU8rcmM4SW9BYWk2c2FpOVhOdHpRM0dwT2dEV3AxUDJ5?=
 =?utf-8?B?QnIvUUtHYTcrSTNVNFU5bTI1bkFNSFJDK0ZrTUxoNWRMZERZbVUvbGZyLzJU?=
 =?utf-8?B?a05lcFV4bTRXa0NvZDB6MFppUnExTFZ0Nkpoak5wTVhiaXJidUhpMGthZzNs?=
 =?utf-8?B?R2lkS0lyTFNxbnE0VStjY0FOUEdxZ0dBQUJTeG5XczhEQ2luVGVCdW5IbEto?=
 =?utf-8?B?bm1zOC9pZmE3YVJrSS9tWDVaSjkranhnVmJtYnJBN3EwNk9tWWt6TzZIK0xa?=
 =?utf-8?B?VHA5WGgrZ0dhUHhXcE1ZK2lDR3RYTXB6bHNDc0M2QkswbmYvOGJ4UU83b0dn?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f233a2ca-479d-4478-65b2-08de3160d4f9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 05:08:29.4545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDBot4or0rwLiqGrRWWyJL93apetDLB1vj3Gq0ccb01hiJ9qOuCb58Qdp9AsIC2bATphOiKhmW2SmQbRx8N8ML2gKTN0l0hmdBG4a558JS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Make it so that upon return from devm_cxl_add_endpoint() that
> cxl_mem_probe() can assume that the endpoint has had a chance to complete
> cxl_port_probe().
> 
> I.e. cxl_port module loading has completed prior to device registration.
> 
> MODULE_SOFTDEP() is not sufficient for this purpose, but a hard link-time
> dependency is reliable.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

I am mostly keeping this patch the same, but removing private.h and
using EXPORT_SYMBOL_FOR_MODULES() to limit the visibility of the export.


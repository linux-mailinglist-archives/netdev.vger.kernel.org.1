Return-Path: <netdev+bounces-157868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02907A0C1D1
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F376E1886835
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF51C9B62;
	Mon, 13 Jan 2025 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KoFmt186"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F61C5F39
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797736; cv=fail; b=bsiptAo+acBcD7Tz0h8tfrO3bxXNQQtWMl3WXTIq5ALAhOz8nyEhjjnDUkx1ylPDbiAbTRbIHGuQ29tY3f4ZQFfqQonBYB535KI3Nxoz5bOF5yqMOr/5BG01HtJlZE3l5nEcS/slsMeY3FRZgbQTVBzASJTb2EfSnDQvNwazIss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797736; c=relaxed/simple;
	bh=y19ikuNObz4vYBYLzHaF30FfX/ASN0mCtcCWd86xN3M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eKQJ/DTHQ68qx3KoQ9WJd4n3RxZ6QuYHgwq0osrn9e3sPxOPSQnt62gQSok6jcFIJstvolcd3Qb2/H/rb0482a2aurrlC6RxE4Ds2rVDPeUv/07m9H3EEmCgUw3K3Z1kvFwa8y7R+63idHYpxZAqJd+8Ln9iBKUoIGLjUIvlmOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KoFmt186; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736797735; x=1768333735;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y19ikuNObz4vYBYLzHaF30FfX/ASN0mCtcCWd86xN3M=;
  b=KoFmt186SFWTp/Hu8/cmegZXlmQnEP2WJjdxQOlRadpXFEb3esAp4t3/
   yvhLDaPGXh/x5BDtkUT9nLSBdNGz3WlCHUVa3tOFDSb7IDZF6CyB+JHdO
   U6ugDlK4Hh8GmA/SccabExjcZdBK7/T3sZ5ipOrA6UFLWOoNKD92Hlq5q
   BEGLpwOZ3HiNyWrqNWeCK4cwLiUtiJt6nY41ensWp62WOgMXpFBc+0LEN
   /Lg/+Y20mTQbHnBN2W1aG+rAndPI2jduZ+QLT8PymZ6HUa8ygSV88Q0PY
   1ELyJBw5WbS+06kEd79qmQGXRuXNDo4ymzzGVrWzf3u+fAhSSgykUyNUA
   A==;
X-CSE-ConnectionGUID: o7/MeyQyTrSOh8bVlzTJjA==
X-CSE-MsgGUID: jybxo/KsRtquOBjXd26GxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36960988"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="36960988"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 11:48:54 -0800
X-CSE-ConnectionGUID: VweWz1rMSZe8uqbUbl4H+w==
X-CSE-MsgGUID: 5l8b/pykTq205rFqw5N0AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="105151147"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 11:48:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 11:48:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 11:48:52 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 11:48:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5cqaS5w2XhoNZGp9PBneNquEi1UJ/RI4rd0sKQOFgV3DglKyFRPqQXHDIDJrCm07+9k9Jrr5pbOBBtkgRPXlEX8k08ZrtfEiIKNbGqTo1R30yoTtQqZlA2e9VG8BIDYpWZ9WMS0Ep3ag5/KwSqGriuKLC/vrmb+zt85eIcL7t9NRa+/IDy6bCKqjXjHm9Co9W/VkFBoHWhWqV5N2sHraK+uIeHNSY7T4Ne43cj66lIG27+oB9z75tYzu+Y5yIj8vpjsfGRT8mpCHniT6sRGrq7GxfFJ1iswzx9sov01nOcex6H96dA0XggQ72nonUOJjSml/ZBwvPqKhuRB0xLO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUkLAEo1hWauczGhUvBjpuL5LfBGUlKNDsOj8uub0bI=;
 b=j2D8NHlhLaOokKRY/BRfsrBDEZfb666v0TBN41W4JHUWmb8YpK82qOsSiJmOHpIyo+84nnQjVWEGJhF2dRtw72AmjqG65yagLM7r0Pn1p2cA5Hgoi5gJi9VBaG2W8YWbsDhyODWdmjbv72yxH0SMaSga1TcUEC06sH2qji447aV+L5zh5Kia7WcZZ4lp/De3uNJpxP20QLI3MM3HTlDP3Kw96FrwtqgdJe/lNFv44q1VotPB8WVuXenZ5aXLIOBfx7RCCqNUfVDL3MX/qfzF5lMyES0eAK51GmlOERJ+Zc9aXcJW5y8OHDCoz1nhV8n8T6LvGsF2nYvhISf7IEptQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB4889.namprd11.prod.outlook.com (2603:10b6:806:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 19:48:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 19:48:22 +0000
Message-ID: <2d3628e6-5cb4-497d-a152-c6bbaac02259@intel.com>
Date: Mon, 13 Jan 2025 11:48:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/8] net/mlx5e: Properly match IPsec subnet addresses
To: Leon Romanovsky <leon@kernel.org>
CC: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
 <20250113154055.1927008-7-tariqt@nvidia.com>
 <ee18ca51-fe6a-456b-9466-39e81d484e66@intel.com>
 <20250113192321.GC3146852@unreal>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250113192321.GC3146852@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: 9006fe37-ca13-42bb-6bac-08dd340b3cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFRNYzdiTHpQSjR3WThSb1gxR3I2UGNSWkVBeUNKL2tLT0tHLzRjTlJJVlBp?=
 =?utf-8?B?anFWSGFVS1ZaOGtUdi9rZjE2WUN5L3JVcGJRMVpzTW5XMldMR2VwbllRMUlQ?=
 =?utf-8?B?aGpoK0haR2oxQnpDUGpzQkRmTDFuRW9hZloweWsrOTYzT2h6cTNDRnJqYmNK?=
 =?utf-8?B?OHNSdzZkY0Nqc3BBQTJBUHhPMnR3VXl1UEx5Tk5ad3hoR0FzQVdCK1NTOGlp?=
 =?utf-8?B?enlmc01IbFUwb1VuWWtmQTlTK1RibXhNWEhpVFlvVVhOZmEyZHozY1JQSTZk?=
 =?utf-8?B?MFZRM1Y3QnVQVFJQb056UDk5OFh1V0FCdElTbHM5ZUJRTWFGelRJZmVWOFl5?=
 =?utf-8?B?VWh3RndWdWdYWnAyTHRETlNvZGl0QjRlajNNdmU4VDN2YWI5VjVob2g4b0Y5?=
 =?utf-8?B?dDM5aU1ISmJhTXNEY0o0THNiSDhqKytHbHRJTm9IOXBKTTFUejcwWGM3OElt?=
 =?utf-8?B?UWZQNFBQUXNOOEtzNFJ1OGNpUWpleUhYSEJRa3Y1dE5IWS9pTzVQZDdPOWJo?=
 =?utf-8?B?bUZRLzU1akJLT1dGcDJtdkZIZC9vbDZmQmNDSW5oaVV0aXhKOXNWakJFdTc5?=
 =?utf-8?B?QlluZU1XbHNONGF0ellYbUxYVmtkVnphdVBoNWxlMEl0MVZXWktzdXRNVG55?=
 =?utf-8?B?elBqdDF6TUhOT0gzOEJjZ04zeEdpMFZjWkowMmh0K2lTNzlabnd0UEhRMmFG?=
 =?utf-8?B?RXBVWkQ1M1hJTis2N1l3YUE3SC9mL0lOUmNtMldkMDRrSDI5S21Lc09IMWRq?=
 =?utf-8?B?M1pMRTM3aXdyZmxmZCtpdGFvb2xVODlxc2hTUFRCMHNHSHpGOFgrVVpTTXgz?=
 =?utf-8?B?VU5PNUUxVnRuanRxK1RIU1pPZUVJY3JpNWh2VUtveld6bE1ES2s3a3ZJU3NG?=
 =?utf-8?B?eVg2QWtTTTV3RTNQYWNIU2FWZXRIQmlBc1JXNjVXOWx1eUY3bjhBQndKbjRj?=
 =?utf-8?B?VEp0YzloS1N0SG1zNVBnczYzWUptR29jcHk3K2ttOE8zNDcxMkhyUGVLQmU2?=
 =?utf-8?B?c2FiWTF1bUN4SUJ6bld0b0UySHo4MVpSTVRBU2tqMWNST0ZYSVBFUzdxTkQ5?=
 =?utf-8?B?TmVhWjd2L3I0b0lUV1JoS2Rtb3JUQXZZekxiaGwxUmVudTZmSExIditaMFV6?=
 =?utf-8?B?U3haVGVyYnQwSFZ1TjU0NUtHaVlNME9UbmpPQ1JnZ25UUWdQVjFvNGl1TDFL?=
 =?utf-8?B?cHIrOS96Q1did2NlbkVLZTMyWGdWZUVTcC8xRE5PQ2krMUtwaldpd2E3Y0Js?=
 =?utf-8?B?Z2dBeHhXMFBrYmM3eUJObWZ2Mm13Tm14bWtUMkhUMEhFVVMwTlptbVdRL0h0?=
 =?utf-8?B?aFpQN0dYMVZjNE5vbDA3cWJnSENESGNsY2kxQTFnQ0ovSVk4Vmt4Nzlhayt0?=
 =?utf-8?B?RWRacTlhTitWbkluOGs2NGYzYmp6TEZYK2xPUXFKMWs1TTc1c1dZY0dKT3di?=
 =?utf-8?B?WGg3T3l4MktXNHREOGZyaDNsTk8yanBXM2IrU3NxYk5oUE15SXhPMEt4MUZ0?=
 =?utf-8?B?b0loZUtmV2RXRHArUEFiRmJkRkJlWWJncmFvR0JqemlpYW9Panp6V08ranZX?=
 =?utf-8?B?OHBYc21Sc3J4YXdmeGlvVHVBeDcxeHd2aHArRHVpOTBKV0xwMis4QldDQnJn?=
 =?utf-8?B?bWJXT1ZMRXJWbVl3YUlXRVVER05QRU1ieGlHTXZPOG9oaFZDbmJ5RnkzbDZk?=
 =?utf-8?B?VUw1dEIzUzdVYmlMKzkwMTU5dlA1aDRQdnB0VVM4MmJUTjJwbTRSZEVLZ2d0?=
 =?utf-8?B?NmN3eHF6ZDFKT2RMY0M5aVhnSHNjMi83dlRpZys0OVd0ZUswc0duQ0tXdVdO?=
 =?utf-8?B?bXBVckpOSXJvZTJvTUJmWmdHWFZlV1IzRk55MTh1ME9NeEl0SWZYMjZKUHVL?=
 =?utf-8?Q?UOEhoiVXL+8Fb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1JxS1JtR1FiSEdGT013WW5hYXo4YzRlODRQb3JDWjdnRTdnbThSYnVBejdq?=
 =?utf-8?B?R0JDZGVwb29LczZ5dGFRMmlnODEzalJvQ0FUTjFEV095N2pzN3Zoc0Q2Y3RB?=
 =?utf-8?B?aVFhRlcyRFllb1Q4R2FHL2d6OWhqdllUL3doU0o2YWpRUXNZRWxrYVhBU2hr?=
 =?utf-8?B?bUpkRGNRZzQwQ2w3bDd6ZlNQRjA4L2ZpWUhYcEVHdVRHTmNUWGxyZ01uSWgr?=
 =?utf-8?B?dVNldVlMQ28zSUdwTGwwSDVBekxKbEM0Um9GSHB3OWNrVkh5Mmorb1RxNmpS?=
 =?utf-8?B?SnpMTDRrUGlGd3ozN1dnZ0NoeWMvS2JUc1JtbDFtemhaNFJPVlhnV1BrYTFO?=
 =?utf-8?B?NGU4S0Y4cTFOVDFJNnBFeUlUQ28ycW5JNVRRN0hyOHVIQlZaSytLQ2VKRVhV?=
 =?utf-8?B?bDJyemt6blpYQjJCY3JGUExKazhJVEFuQ2JXMGtmQzBGbFg5OUk5Tm84RnJX?=
 =?utf-8?B?NVh1Zis5K0VEeXlWVHpMQ25yeUloOEJhWk9OVEZyNGZmYWJ6dnlmQ2hDUjFD?=
 =?utf-8?B?cm41NHZGSkt6akwxZ0FrcFlHZlNmOFc5SUcwbHhUckRqNElOT3UvSzlWV1VQ?=
 =?utf-8?B?SHpCQk00U2FybGVyblpxdlNnQmJ5aVdZZitQc3NuU1pkYzFIQUl2QVdtVTJB?=
 =?utf-8?B?eDU1NTQxQWt1cFhmVk1GZ29XUThDemxOVkdmSDhhdytFNUVIdS9CQlo3Qmdn?=
 =?utf-8?B?aFN4VjBYcGx1VVpYQnQ1b1EweG1XRllBU20vTnk4ZUlpcEZOdUwrOU8xZVE3?=
 =?utf-8?B?RmQyOUUzL2ZJRUZsRVNGZ055bGhqVGRGRGh5NHRmeFVCL0RpUzk5OG5hTXQ0?=
 =?utf-8?B?aFlvK3RHMExFcjZrbzQ1Tlpqa2JsemVrdWV2ZEEwY2E4NlY2SGtZTDZRQit4?=
 =?utf-8?B?S2RNTDdXSnFKbzFtNGI5cHo5Q1hYMTd0OXUwbUdocDBIMURIYk1LTjNkY09x?=
 =?utf-8?B?YUd2dEdFVEI5Q2pyRGRtOURQN0NMZFQ0c0ZvWHNNRDZjMnZBSnNKYzBhTHh0?=
 =?utf-8?B?NzRRNjlzN0E5NlB6OGZUVjFFN1dGZWFUREd5c1JTQXN5Qzk0cksvNHJLRnVM?=
 =?utf-8?B?SFhHdzI2UVg0emhjNEd0SUdZUnRmWHlvdGRsRWdXcElMUkhYQ2dLMlpzblJY?=
 =?utf-8?B?aEZGUWVPbVdwM3R4Z25HS091WUZCa2VEY25QMjFJcGlDQkYrS1ptU2I1SkJp?=
 =?utf-8?B?MWQrQk85WFZRemxpbVc1TFNGUmx5c3RlbUR3K2NTT2dDTnI2Y0VXajdRcFpp?=
 =?utf-8?B?Sk54VkxiY0MwdUIrdnl0MlNINTZ1eEk3aGVRdlZPbHN3ZTdtK1JMU0NNTlZq?=
 =?utf-8?B?WVFNY2krdW12V1IzblQvSTNXbStiYmZwZk1jd0ptNThqbGhHSXRmbU80UTVh?=
 =?utf-8?B?ZElXMUYxZG5kUW8zM3dkWjdabmlVeE5va2lvdkFMQUg4bWlNM0p3UE45eDRo?=
 =?utf-8?B?OXQ4QmtCcU5HMWlLUWI3WDBXZFRrRFNWZ1d0SVo5ZkI4dGI1bXNvM1pnZWE1?=
 =?utf-8?B?S1VMVDl1SCtFUndRRmtiR25KRWsrdEFTREhzQitDQUFxcWFlYjFYRUlyMVVQ?=
 =?utf-8?B?emZ4aW5aeUM0cEprSm55bElUU21VVWZUTGd6N3RFanR4a0UydTQ3RFFUYzR4?=
 =?utf-8?B?VkdsRmxXcDlkZUV6RzlkQnBCSFFjUVdCVzZKem93YTNObXpZRUY1VWJYN3BN?=
 =?utf-8?B?TmVWVkw3NEFlejZ1czlMUmZMY2V5bDlURXRHaUZtRjRIRzJObFoyTmM5M2pJ?=
 =?utf-8?B?WVVwOGJNMWdwa2dsU3VrYlZXUStLRzFTMEdFY284L0E1M2MvK2h4aUNtdUJU?=
 =?utf-8?B?N0lsNUNZdG9ldldzWHEyRFJPVHBBYTA4Z1MvSFJEa3RLb2JTNzl1TTdMWml1?=
 =?utf-8?B?a1I0MktsV1BGWW1QbXlmV3RwQmJNUkJMSXlyRHdCcGoyd2tEOFBaQnhtdkcz?=
 =?utf-8?B?ZHNqSWVRWU5kNzFsOHVLd1YreGVlQ2txRFBFTEwyTkJVRGZBVmlpRUl0WmRM?=
 =?utf-8?B?ZmlDcDhHUjlmeHYva1A0NzZ5dWhIeFB5Nm9sTWxWaG1HbzZVSW0rdXJpSEo2?=
 =?utf-8?B?R2lmK0JiTkVKM00wa3Y3bmtZeUNFbUp6OXNDYlNKdXdHYkxuT2FxZm5JZ09E?=
 =?utf-8?Q?YJBWknO5fieRSyMDGHs6M0ozu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9006fe37-ca13-42bb-6bac-08dd340b3cea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:48:22.9111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfevWANYCweQ2BFURHUoMuuokDxI9oL22SJWoD8ypt8+lxDHh29DKbPXkFUlnTmYTnxMHbHboaIZBqyEaRMZLjlg2EhvC56gtDJQd99dJwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889
X-OriginatorOrg: intel.com



On 1/13/2025 11:23 AM, Leon Romanovsky wrote:
> On Mon, Jan 13, 2025 at 11:07:03AM -0800, Jacob Keller wrote:
>>
>>
>> On 1/13/2025 7:40 AM, Tariq Toukan wrote:
>>> +static void addr4_to_mask(__be32 *addr, __be32 *mask)
>>> +{
>>> +	int i;
>>> +
>>> +	*mask = 0;
>>> +	for (i = 0; i < 4; i++)
>>> +		*mask |= ((*addr >> 8 * i) & 0xFF) ? (0xFF << 8 * i) : 0;
>>> +}
>>> +
>>
>> I'm surprised this isn't already a common helper function.
> 
> I failed to find.
> 
> Thanks

To clarify, I didn't find one either, and I don't think its a blocker on
this fix. I'm just surprised that there hasn't been another user with
the same need before.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


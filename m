Return-Path: <netdev+bounces-127928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C851F977146
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B326B22C3B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EBF1C1ACA;
	Thu, 12 Sep 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iotg2ZUi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EA1C1AA4
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168239; cv=fail; b=ZSJxUBayI4aqWwgKRm33i09oxNJL4lpccS3UV5WJLUjc65401UGs2x+oz/hGskp8QYtDjWIx4jvs9h4kPz1ZmfKSVRhIzNbFuNLmn8hbpjLBqHkHsN31/LYlk/fgk9IbTE8v540nIiHpDjPadAd/wzvc+/R0P3B0tvIgpjAJ9r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168239; c=relaxed/simple;
	bh=fNcDPQiTpWtxl7BHyR5tV0ND7plq6Iam/ttjd81SWKY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PDxPle4bf28jEq2o7NwvMhNJtPMijqPtN4hASFjCwb7G6gDLDgZTUGXQZqg3eH2jk7n+4bDuMGR149JiTCkxhE5Xe2xANSYl+yvGJyxOjt83lJ2LiBAadMROVi+ANWq3r8M9f6XfnxKRtnydIp4l5NSpLSK/0U6nElPB8/abimI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iotg2ZUi; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726168238; x=1757704238;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fNcDPQiTpWtxl7BHyR5tV0ND7plq6Iam/ttjd81SWKY=;
  b=iotg2ZUiI80fzcXFFw01hF/sLM0FyXHax69lQReJmyWq1wibIhLndVf9
   WbwBqWplk5sjEExEkm0k4Ah7uF1ueM3rRIweLTcCtM/BFQq2kg8NncIFZ
   MODrXy6FCQGIGHKWxpZTO9BT4+nfyo3XaRjx4AQlGebQfDJSFEG/aWRPI
   TrMoHe8W2zFkydwPAMVtUdJsW/yJ4tdw/vzwqiGVJj9cNiCfVCr871EgI
   JVcf2V1U/LfFNMRZzwEiN2u/2H3VT4OUXBIEpt84LsBl5aw8FwDFZNu6/
   xkLobR85Ila5+Bwa8U9klVW2JTgKlT6t9bdzK7RoW6JIkh6SteuhC0MN8
   w==;
X-CSE-ConnectionGUID: OUp8SPtWTnqtvONISSdTEQ==
X-CSE-MsgGUID: E+m+gEZQT260tnEN0CqAMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36395426"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36395426"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:10:37 -0700
X-CSE-ConnectionGUID: lJQ5HINESIenw7SslHPoww==
X-CSE-MsgGUID: H89kWynHRVyfv0kRIC5mvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67515391"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:10:37 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:10:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:10:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMjpq04hAUFdwMjfQS79MX6BkfYTuJxTMw7fn5UoHl/wIJ8NhBqbZaAieFk97br9cwiocGjO/Y0rPjCCuO2Hx3NRPKTyPA1fI787vht/6UZZE3T0aCiV2UF7IOvPFr2nSIhtvQ6k5RVV7cyQpkNR6QzpjYA8rz3fEQaj3I5u6Jtbo7Ln5UXcKQfmXRfTZqr8K8NFHKe+AUfmLyj4gxdkmugdowSzNHGByACroG7XM4b+Ewo5jH/jp8QIl555ATnnoMxiTyhA0pZ3ijIDHXU/XvaL8PaLMlmeqft2uSyPC8pjWYkg6Np+SanU+1Co2MVVjBPQgbDDTUxFuD0sIAl/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TFNTiwO06rdR8cn1TZpaJOzWzn5v8WtQKJQgRYCAC8=;
 b=QLiSec5npWhm92/4ewgnK1KlBXL2ejSPS/u+rWV56YEr7Erd5jP5dT7nU8ixs284yM7gFYSXJXkPytpUdw4GqauTepH+ebnFjaJnu6+NILVe6jrR6jWk22fw5xLJ3XFi8UvwZsk+q1s1UP55EGJNHxOMII/j/ZtVV0+YNFJvRX0KZeHNuYf3dQfxhhXihTj7ZaTXhU+7Ui7i94c68xYASm7qkLseehL6+HQZ3Vwj2vFUecundSSqsbHFTVUMtSQxQ/fbiGxhM7zD1jYxEqMNw7hdECHtiRQrwzbFDQZdGnG1hyO99Tdvs906uDVTugD3JNlPs4caUSJ2n0N9gUYxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 19:10:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 19:10:27 +0000
Message-ID: <391d5ef7-c8fd-4b9f-b488-23203ae96751@intel.com>
Date: Thu, 12 Sep 2024 12:10:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 08/15] net/mlx5: fs, add support for no append at
 software level
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-9-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-9-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:303:8f::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b562d7-6e65-4465-b20d-08dcd35e8f9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXFudG5vckZ6RGQ2ajNFNkNJOEg0b0NuS1hwNWV4Vi9FdWRIelFLR0ZWTW5V?=
 =?utf-8?B?ZUI2YzVwR1d6YnlmVUlPTGh6UlA2ZFVwK240TVhtS3dzVUgyWllCblRSQzVT?=
 =?utf-8?B?ZmhyemR6TU1qTVVQTDVxeGlBd1dlZDNCNFUvMWVua1VYY3V0c0gvd3VBR1Nm?=
 =?utf-8?B?VnQvKzhWMkR6Y1Y3cUIwY1AzZ3R5b004Z2tCMElobEdRRnkrc1IwazdvbURy?=
 =?utf-8?B?bHJyeUowZXFyZ1Q2REtnZWFrZWVpMVUxbWlwRFpSTmNUakhpcVpRaG5Ldm1a?=
 =?utf-8?B?TVYzVDBQQ2kxcVNyNkYwU0FleVlheFZDZ1A3VXBQSzFYNVdyM1VlNnFjTFNR?=
 =?utf-8?B?dUZQb3kvVExTYmFGVk9wYkhhRDBpKzZtRDRETlpXdlNCc1k0RGdzV0UzSURy?=
 =?utf-8?B?OTdCQ0ZZREtvdzZKUy9hRm5oNnlQTDRTeHFGS0hKbmF2UmF5dFAzVW1Da0VT?=
 =?utf-8?B?RTR6aktwRTkvTWM5OVlVWkNxeWljbG1PVGhoTDgrL3luUzJ0MEhVOFdBdUx4?=
 =?utf-8?B?Uk15S3V1UUM2NWdFK3MxV3loSk1aQXc5NjFmWFZaSXVYdlo1WnBxR0k1OHpB?=
 =?utf-8?B?NlVMZCtFVHp6QmFWc0R2SXpUZExhekgwYmcwMjdJS0llQ1d4RjVleDZoRnc5?=
 =?utf-8?B?U2wyb2RvbUFIYWZkNkZncVFDM0ZnMzlEamJmbEdLbW1LRXYvSzNlNGw4bUFG?=
 =?utf-8?B?T0o0UjlvY3VNaUdWOFBQeUlEVmR5a3Q0SDg4cFErTWJaQXFjSnYxUnd3UE5M?=
 =?utf-8?B?Yy9CYTFaVEs1SGY1MFZFL09NaFdNalhtQXR3ZGYvRHJneVB0QTlxUlhuRlky?=
 =?utf-8?B?NGpVSWtlYzY4anhPTEpOQjU0dmt3a2tVbHZhRGh3RzV6N083SlZYeGJVTVk4?=
 =?utf-8?B?a1Z4eDJ4UmlvTUZOZUh1NEg1WWNTTWo5dVBmcWI2ZkV1emFZandOd0ZBVDlj?=
 =?utf-8?B?ZWc4Qm5yZlBoOTNRVzhvQ25kT1JRRnZKbzBZcThxYklyL0VaYXNreHVoRE5i?=
 =?utf-8?B?aGVnVHhYSUgrT0p6d1E3SHZkL04rem82OVA3ZHFVamFqaFpPT3h5MHVReXpl?=
 =?utf-8?B?U2hCN3JzOG5BTEcrMlZ4WmMzZDU0K1ZQbHY4bFBsTlZpcVA0cWdGMjNOSWZM?=
 =?utf-8?B?YmhTQm5EamtSQThnL2I3WmJoaC9ncHFUZmZlalhCZVVFUktEallONjh3WlU5?=
 =?utf-8?B?WTEvNzhuMi9PcGx0S1BzeFgzV1ZQdVJWZkNOelNpamFpd05sN01HeDhhU2ty?=
 =?utf-8?B?dUp1WXN4NDNRY1F2VlhvR1ZqOXoxdFQ0YUFlSUxtM2EzMldqeCsvOFd3TDFQ?=
 =?utf-8?B?T1EzSWVpUzAyOXYvOWpWdU5oNCtaV3NRUTZ2T0JCVmdIbG5JYXduVjgyUmNv?=
 =?utf-8?B?ZlpPbklBTTFPRnRXQUpwNXpJTkZPTStScGNvQzZWWWtyTUFhTDliUkhiVVZt?=
 =?utf-8?B?ak9HQjh2aUVzaGxJeDB4MjNubTZ6NFNoQWxyNVVaK1R1T1EzcTFNV2JSenUr?=
 =?utf-8?B?bkZiNzdEa2JNWnRvVUNpZHBvbmxXN21vOG15RGZPM3FoTzhEWmF0cGVCSEVT?=
 =?utf-8?B?NjJGSFIxQURtN3R1NTZEZnZVNklXTFc2YnpOZXIzWmkvMEFPUUt2dkp4T3ZV?=
 =?utf-8?B?c1A4ZDY4Uk5kdTdkZE95NFJ0bzlyanAxdENSMW9HR09LcWNWVnFtNG12cTBt?=
 =?utf-8?B?WGFtT1owclcwWDBCUmUxL0dQUlZvejZ6YjVid1lFeVNLSEh2YUllMzc5Vnph?=
 =?utf-8?B?Z3JjcDNMQmp2UWJJZVMvMTRSek5vWXBzU3FFTDdyczRnZFJ1MEtBaFpyVC96?=
 =?utf-8?B?eDZybFk2YnZSa0dBSStudz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjR1U0Z3dSszdUlMNWxzcjRmSE8zc3NGWGJSOXB5aVM1bXlrY2t1Sm1KNVZy?=
 =?utf-8?B?QU9GSENWM0J6bEl4SGpYMEJOVy80eWh1N1N0VXE5T0tkMlZTdzdGRVdaODkv?=
 =?utf-8?B?SHNrWE42QnJ4SnJjMTlBS3ZiNmFQRWhRQjRzMG9LWVk0R1pKTngyUnF6Nzcz?=
 =?utf-8?B?c1NtYkduVzF0a1hpM2ZMZER3L01CM1Zvdm9oNTVGZ3NIcXFMYlY0MFd2NThQ?=
 =?utf-8?B?c2RIaHZrdU5leGFRZWVCcUZ2TFhhRTRUa1BzSmFoL0ErazlzUldYNWdla1Ni?=
 =?utf-8?B?bzdOT3lhZmhFckhlRWpNekZKeUUycThmSGw5RGg3MUdhNElxaXM1ZEVXK1Bi?=
 =?utf-8?B?VEhMbVlzTlF0L0VzNFY2WnhCUHlndW5pcWoxL2tSUkpQUndNaEtMN0NWWU5n?=
 =?utf-8?B?YUo5UVJqWnNGZVdFV1ZSU0hIMCtBaFBVSFF6bTI5NzFrQnpCcG1pMW5SQkJO?=
 =?utf-8?B?NGlmbGVwdGNYY2tvMElVVnpSUTRMaTNhZkppbVFYYjk3R1RPcUlEcE5HejdX?=
 =?utf-8?B?TU0yTjhNQjc5K2FZOVJZUG5mNjdjUHFkbHVUN3ZRb2VPMW4xbndiUEtnTWJ4?=
 =?utf-8?B?azFhOE5USXc5TlBoUVA1RUNaRXcyeUVmTzk3cFNvRzhrZzQ1RTBjRlY5K1Bj?=
 =?utf-8?B?U3NRQTg4TURmU1hZSTJYZ1ZzQWQzb0lsTmh4YkVzYzVrVFdHUlFJYkErMktv?=
 =?utf-8?B?YWVtSnV2ZDBka0U2NWg4UlJDMEtBaU01L0I4ay9wcTgzVlNwZW9La28yYUFm?=
 =?utf-8?B?a1ZqOXRYUjdNLzFwSHlKeTc2c00ydloxY1ozQkhGYUxuMzZmcjNVdHBvT0dV?=
 =?utf-8?B?ZHpUaVVIOTdQQ0dRYjdFcGo2TmV4bWRnQzNUQkhBbzYxUk9MMXFRWU9PWGsy?=
 =?utf-8?B?VnNxZ3B4c1FvUmVVc0MzeGs3cldHMldNU1FzNE1PRnhHMXBiam9PRnUvaEhY?=
 =?utf-8?B?bFpjUWVCUGIrcDBlT2ZMa2tER09Edlo5dmRZUnBOa3pJbWxrTzc1eWRkZ3pB?=
 =?utf-8?B?aVpmaUM4eGwyZG1nWE5rQXFFcUo5bG55dmd3RlFhUVhTWFhFc0pPcW9ZUnlN?=
 =?utf-8?B?clk2bHRRcSsyUGEwZHRLRXNvc2lteHkyN0plZXY4QURDbkRhTnp5SGhkSWcr?=
 =?utf-8?B?SkFGWUV5KzM4bGRzWnROcFRhK3dXYjd0YlZDNXRFMzdNU0dUcFk4VVdHM1NS?=
 =?utf-8?B?ZjhwQUw4QTUrVHlWZDdGL20zVTR6Nit1RGJOZ1FnSzJjQlRzL0JscGxiTXo5?=
 =?utf-8?B?TUFZeHMwZUx3Yy9aeFVqelh3cmZVWERScHMwbWtVZ0JDZExlVGdDbWVyY0M2?=
 =?utf-8?B?dmltNUhYZ2QvT2FtNnEwS1J2L2d2R09uSFBUQlgvRXpLQzdHQWFQc0Jpc241?=
 =?utf-8?B?OS8zaU03Tkw1WVl3OGEydVhuKzlzVkdIa0U5STRIc2d6SURQK2d6VUpPa24y?=
 =?utf-8?B?YVBKRmFmZXpFZEpUZjRmY2V3azhDV0JOcUFtOE9tRjJNUzAvUGEyU0FTMWZp?=
 =?utf-8?B?MXcwbnVNTGg5M09qekpZd0JJWi9nQVdUL09BMHZ0REVQNWtoa2djM294TDFH?=
 =?utf-8?B?cWt4NVgrVGxlRC9sREJNdDB1OVY3ZmxRUVpBeDVxSnlya0ZGcCtQaVJaTDEz?=
 =?utf-8?B?M2NNWnhiZmo1TTlHNmVuTGpPZVpNOUQ0SmZJZWZFa0tRa1FSem5BZVg1WjNH?=
 =?utf-8?B?VTBmN3lnSEFKM29hWGRyTkJNZnR4N3duNmM3VFBkSytva2s2clRMMUN4b0xM?=
 =?utf-8?B?Y2tTeDV4SDltdDd4MDliUkVZaWtHN3J4ZkhzOEJKR3JRd1hnNmF6ZmtDUlF5?=
 =?utf-8?B?TmQwMDU4V0cvdFZCb3A5WlVFUEhyZTJuUXVKTnBKQjYwemM2YXIvdWdYY0tm?=
 =?utf-8?B?QTZFQ3hHT2k1ci9lWXdGb1F6SEQ0V1EyNElIbEhWUkhaQUREUFphQ3hlNlZ6?=
 =?utf-8?B?MElaWjZReHNKWU5IWFVPOCtMeUMvNWJPaEtsbjdHd2lCWHpJZCtPN3B5dWpB?=
 =?utf-8?B?ME5sNWpnQU8zWDF0eUZxcGc5U2YxckVVbURLSEszckZobXJRZ1BKMDVrVEJO?=
 =?utf-8?B?REsvWTltcUZPUmdhQ2oyL1IrTko4TWlLdHpuWGhGWmdUSUxMSDBaMEZWd3ZT?=
 =?utf-8?B?TEhkTUIyaDNmQStDdldMak9pNXVwS3AwY1pyaXZCWGlxaldRZm9SZ2kwR2ps?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b562d7-6e65-4465-b20d-08dcd35e8f9e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:10:27.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BtIx+vZH0k+t0FOarnbgjCwccq/NKVMlEHzfNil1yveI+LDuJAoFCokEQ6YEC9jD/kbBSoRT0CuyHyCS+ozQA0lsWC6Hv8GVaPwO5rPAu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> Native capability for some steering engines lacks support for adding an
> additional match with the same value to the same flow group. To accommodate
> the NO APPEND flag in these scenarios, we include the new rule in the
> existing flow table entry (fte) without immediate hardware commitment. When
> a request is made to delete the corresponding hardware rule, we then commit
> the pending rule to hardware.
> 
> Only one pending rule is supported because NO_APPEND is primarily used
> during replacement operations. In this scenario, a rule is initially added.
> When it needs replacement, the new rule is added with NO_APPEND set. Only
> after the insertion of the new rule is the original rule deleted.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


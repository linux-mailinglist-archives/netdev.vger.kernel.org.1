Return-Path: <netdev+bounces-166099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D78A34834
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A233AF9D2
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8EA156F41;
	Thu, 13 Feb 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JETkZGtg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D001632DD
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461050; cv=fail; b=sChlCL0+uygjHXk8CawFwIXwWS6wBM6I0TPamm80uUmApVJAZ6YG85kbv0T0zldLIncwe1IDmCX7K1I+OHo/gYz8Pue35renijJRrAHZtBHdSTnIHktwkc8cG3TwpVnYnPD6ms2z97/j95msyaZRi7KrndnYzPyMOofSZ96GO38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461050; c=relaxed/simple;
	bh=t9GvZFVy0wWhT7m8PDF6Ed4wa/haeX+CHAFVQ9AiTnM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b7Q9hs1E34rRs35Qm3l8q7c1eNqJ31rD2wjAtU2b7OW8mjuIG75Soc63XTs1zDB4kwSCuDCqWv+zmbw34dZqu2dG41Oa7w5VIAeQB++EUScenNDI0y+ct+s+/6kaJvmes09X4zTD6qJOD+RE+0LXwZrIi4Vg3Zr3BFKCoLYwClM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JETkZGtg; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739461048; x=1770997048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t9GvZFVy0wWhT7m8PDF6Ed4wa/haeX+CHAFVQ9AiTnM=;
  b=JETkZGtgs67ytwHf9azy71ona9crAhvDwFqO7zy7QRc6UdLbehIEN/2P
   qsqKVympIJjJw5KWoD9Jr22DpUj+jpxc0xvnmeHZray5PgCrwr0murvbM
   rjV7+KuNbU5GvMSEg+0HRhauz0Hf4FuHHNm+4SQDRkWMTHMMcIcGFRIur
   oNJZNs1S7dATEfvYvhpIk6vlVP9ipsLCqsccsFKNl4ybYuzl1Cjcz1+nW
   Zq1fLOqJVKYZNHefU8BI3wT3XTG3yREkk+AJTup3MR/Qf5H7XL4WjlTo6
   lxXFVFnFeLczneTcKtvoVRARIY/HRip02m5aLcAUdlXjsr0jl7bBUg0go
   Q==;
X-CSE-ConnectionGUID: soTuE/yjTOurmvnT4oZBrA==
X-CSE-MsgGUID: SvKBeBZkR3KNVycoJr6WkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="62638621"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="62638621"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 07:37:28 -0800
X-CSE-ConnectionGUID: yOCSOSoBT4yFMY8lRmdV6g==
X-CSE-MsgGUID: ieQ7FdDWTW2Tfy58fa5Sbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113043483"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 07:37:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 07:37:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 07:37:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 07:37:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pws49/K82x0oEwmhf6Nsqjoe/c6+5HfbskaaTyTFU16jgzmQdbrIHLtNW2EDtCGw87HfKDMnr4xf8fzxMr4EN3wGstCNJ8Dy39RVqjGL4VtkpDNBjLM36yIKuwaMuPaWUnvek1DtTrE2NGX+V6f+IeZ2g/4bWIOCTTP6En/lpypsXTQojjhcDsFNI5B1HZSwSkEqrOZlr3khUKdcBWbAX4evOj5c7p8jN2MovmybxSY4SOm+L4LDETiB3GBGVMpR4S99uLQBWOnduY+4XQZq2mzvq8uGQ5oY+WKYsEe/mO75LYCjMsFXABbrwIMVCWFCgauGhK2jQF57QoLqPEJCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDTj51Ls2pLCQPDiYQTjAhpPU1wpGsEtzedElhosqU8=;
 b=r/6nywqvXuuo57noPETc7GytvzdMMwtNWI5sWER4ZEfSakNvX+UrMrDhAjzn/Yse9FOIkOl+42Z+QiIvTz1PpZkANRwVsbZdxcqaTn0EZ5/QYTdRCzVUads1q7rgigctPhy3Q6QkGRrceikDlRTXzEkXxDV488OTeIXV/TkcK3RFxKwRVacZsi+teC5DRch2Z1rMffA1mTkpPGKvLrOlICKP+GErflPiSZfuBbO8heQFeY9gbCpRfGI4VEnPLG+UoL7D9PuEmYJJEpoX1XDHV9cGxf0V3kuvKJJQ9bye8Zf0fOQDnYcS4TwOQFw6MmFtPdS+gfFER3ZcWz61FglTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 15:37:24 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 15:37:24 +0000
Message-ID: <d19211a1-b092-499a-aea2-d5addb263508@intel.com>
Date: Thu, 13 Feb 2025 16:37:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 02/14] ixgbe: add initial
 devlink support
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, Jiri Pirko
	<jiri@resnulli.us>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, "Polchlopek,
 Mateusz" <mateusz.polchlopek@intel.com>
References: <20250212131413.91787-1-jedrzej.jagielski@intel.com>
 <20250212131413.91787-3-jedrzej.jagielski@intel.com>
 <cmywoei5shisdjbt7ipv6rmfxx6jgafu2ccb4xr3phq3ealx3n@kxsdwd6u5bgk>
 <DS0PR11MB7785E7F829BFD1A59AF16048F0FC2@DS0PR11MB7785.namprd11.prod.outlook.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <DS0PR11MB7785E7F829BFD1A59AF16048F0FC2@DS0PR11MB7785.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0010.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::22) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a0be69-069b-47ce-f954-08dd4c444fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXNMOTZnb2pRSElsTktkSGJpSWhRQUw2NXYzZmtHRFlwSkVob0haaVcrQWwy?=
 =?utf-8?B?K3RkN2ZhTnFHR3lnTkZScDNJT0xLdG85V2w3MVIyaU9SdHhwUzdLekYyTHBn?=
 =?utf-8?B?cGgvVmNmeWNJdVc3NS9SZ0pFQllxQ2ZkUlRaelUyZzBKdWEwckgyd2NLNml3?=
 =?utf-8?B?cHhRdDNybEdkU3Z3T25aeHJJOHdQMjkwbEpzcXhoMXdqd3pjVnlpRG9iVU9H?=
 =?utf-8?B?SlRXQW9zYnBvRGkvQU1ZOTM5YlRZeHVWWU1jRWRwTGJYcTBLbWlBY1NVcHls?=
 =?utf-8?B?b0szc0kwV25JZ3IrRlBFclFLbUtPUDV0NUdzMEYxUndvdmRnMS90S2ZKLy92?=
 =?utf-8?B?QVhHMHdFa1hhNWlHZTJKd1ZvSUg1K3RhdTZWYlhyTVJoSEJGQVFsYnNQNXBa?=
 =?utf-8?B?b3NtRWFNNTVtckx6TkQzSnFmYkZWek9hK1VrcTBZZEJ2cHh2Vk95Q1ZzbWZ1?=
 =?utf-8?B?bmZkZmRZUUVzeEtrNlVObUFEOVpxMW1zRUR6SmRrQkRRbWNydlF1SDRPUVBj?=
 =?utf-8?B?S2V5Mzg4TVFRVkI1ck03TUFrK2F6bkljdDhvWHVvOVhsSG5XbWJiWDhmOU1X?=
 =?utf-8?B?c0dERUs2SXZtWXFiMnU2YTYvVXJGQ0U3L0dTRDFUcTVMOWhMUXZ1NjlhdlZL?=
 =?utf-8?B?SnpmTCtxYTFLWEFPS3B4OGtTS3VZbkdiYnY2UlhXREI5L2ppUHgyeEszYUhk?=
 =?utf-8?B?Qk1LYjJpdWRzNUhUT0ErQm9iTWw0ZFFweDlLWmRYVmRzVzY0K3NhaXYvT0NE?=
 =?utf-8?B?WGRHMnBZTEFiVkxYUkJlbEtKS1lwVUY0UW0xbERleks3QktzZWlxY2hURWpR?=
 =?utf-8?B?Tjg5Wi9YdGZKYjRSOHovUmYwOVphV3dmbStEOGI1dnRFc3pwQzcyemc2N3Rs?=
 =?utf-8?B?RzgxZGpnRDhWYWtQbFhuNXdsUTgyYzBlVnZycHgwOGl6amRjVTVtMHkrdXNj?=
 =?utf-8?B?YVA0S3JQTlBxUmJPbDJIL0RZTjdObEw1TjBYSTlMRVAzeWxjUTNPeE1SNVNE?=
 =?utf-8?B?OHZQWFVTbjRxL0ZtcS84VVRqRTJiRThqUy84bmczaWJMTndKeEU4aTdYWGl5?=
 =?utf-8?B?Qm90WTdEMXRhYSt3dlcxaTJBTEFyY1FkaWdJRFh5dDhzV2w2UHVMdjJGZWlF?=
 =?utf-8?B?eTZsMm9nSUh3dkVUOFpyK0hubjM1ZkhXZDFsY0xCSEhwcWFNVXRMamxCV3Mv?=
 =?utf-8?B?cnZGcTV5dE1XUEZvQkpEdVhUQkJxUUhzZ2IzZ2JuOUVLRlFnSjFJVmxYZ3Q5?=
 =?utf-8?B?dStXTUJCWE9YMkY3d2lLbE04UjVtTmUzYUJVcDYwTFNPOCs2amVYRURLV0pT?=
 =?utf-8?B?akZCM2xVUzFGVTVMVWxZdUxjTXFEUkJ6SVdMMmd5WWhORTMydDdGQmhuSEJi?=
 =?utf-8?B?NDAvc3ZDNEZZdWZ3Vk9TSFZlY0xieW5NOUg2M1VyeFErelBKNWZ5eFV5Z09m?=
 =?utf-8?B?U0VuQWcrZEVqUlgwQmMzOGZpNldPVjViOEd2VUhvVW9TRDlYRkVDN3NwbDFl?=
 =?utf-8?B?WTVKOVM2WVR6UW1EY3JsdFl1cjlRRys4emVHNy9KN29TU1lzM0l0cjg0MXJR?=
 =?utf-8?B?NkxVVFpWR09IRnQ1bGE0akFLQVBpM204anUzcXdCUCtOZHF0RE1wUzRpWUVh?=
 =?utf-8?B?cVE5Y09KSDBrSVlMSEcvK2lOYkxtUUR4SVpVbE1YWUlaWm8xQlAvdlNFRkhm?=
 =?utf-8?B?b1Z6bGg3L3lZRW5lcG1hTnQweDFGUWdzOHptNTdxRGVtNk82dlVGYnhmcVc3?=
 =?utf-8?B?V2FLT2R3b0NQTkNuS3hYY0dNNVllMGpWNGlXSnJvM0xVTktHK1YwWkRadnpY?=
 =?utf-8?B?eUc5Q1g0UU1pR3FRL3pIMVZmV1VodTVwcFpKby8veGQzUG5QTmRtMlM0dklh?=
 =?utf-8?Q?WpG6XaptG6JlZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1lwd2pZTk1sQlhUWXFza0ZIbXYzUlFtdjQxNGNFcUY5a2hiYUNjTW9JNzA3?=
 =?utf-8?B?aC9FckNnZ3RYeDhvMWc1Mm5tUytkZWU3ZXNYTGhtM3pPZ2Fjb0dJekhPa1RT?=
 =?utf-8?B?ejlPNmJ0VWlSK3J1dGdOM2ljVEtJRSt2T0wwWXdaZ2l2S3BIdlN2cUM1cURN?=
 =?utf-8?B?MmM2dXlJYlUwRXdVSUhjc0twSENzVE9WNERSL2RMT0ZXQjQ3QzFpOGtnQjlO?=
 =?utf-8?B?cmg5WUR5V3JGbXc1UkNOWFcxaHVRdWxhN0J3cURTMHIvVm5SMTZNaW5pMjlS?=
 =?utf-8?B?U3Z1UzR6Tnh2czFlM25SaktTQVByL3R1UjRDSEV1Vmt2REtpNVdVV1BiTmJB?=
 =?utf-8?B?aEFRT0hBdXhwUHR5TTNubVdlUkdrYXhOTjBkdVJBYS85RVd2SWtvRkEwcDgv?=
 =?utf-8?B?c0trZnFreWtOeDBNc3NIYjRobDFlU3kzUEF0NzZGaDYrOHJKQWljZmRlZXla?=
 =?utf-8?B?OElycFc2UGNxQmQ2aUFFb2w5WTVHTXp6eC9GL015N2FXRS9vZjlYSEYrVnVO?=
 =?utf-8?B?Nzdua2t1K2JReWhYb1A2M3l0cWFNUmtpSFozWlNuOUx3a1BEVTNRaldKK2Ex?=
 =?utf-8?B?WDBXYTZPM0dvVHNmSXpvbUxCM2s4aVhmNE1zMTNPdVByTldlODZxd3VmY0x6?=
 =?utf-8?B?clVBck9lSER5amcrMmFiVkZQZkQ2NG1oempXNFByOXpYYUp0Z3ZzQVVVbWx1?=
 =?utf-8?B?ODZKNXZYcldwSkd1dndLWVR3OHlyckhvdk9JZW9TWXdaQ00rRkJBYXRiV0Fn?=
 =?utf-8?B?Y2NaRmJZaGNLL2RCWlBVV1NPQWhUeXBLOHNlUlRDSDM4NGRtcmRvSHNnb21a?=
 =?utf-8?B?TEdhRithdEdFQ0VZQUpqeGdPQWVJZDRzSVYyVWwyUVgvTUEyVy82UG82RGMv?=
 =?utf-8?B?V0Y4TVNMK1V5NzhOa3pOUDhHYk5TWCtST1FZTE5KQVU0anlMSEcyWm5yRlNW?=
 =?utf-8?B?YnM3bU5IaEFnald6ZXRLOTFtbjV1YUM5L3BJbU9UZVJmWEVwVkRjc09JcDYx?=
 =?utf-8?B?MlVRT0RGL1Qrczl0YllMMUx1ZHR0VFhaczdSNHdXandYQ3BQcWIxUzJiUzR2?=
 =?utf-8?B?UEtNWDRaR0ltV0JFd1VhMHZCaExEVlM5TFpUaDhqdm9zaWZKaW13VXNLeEJG?=
 =?utf-8?B?aDJNYzI3a3RPc0xqMGdjT0ZzTzRaUWhiSjFVSlY3M01KMHovdUw3SDBHRU1B?=
 =?utf-8?B?YXpwRFhmNDdXTnBkdS9NUWlwaFdPUld2N29xa1pReVluRWhjRGxKb1RYc2FZ?=
 =?utf-8?B?dnQwUjVSZUpiU1MrcEoyVlBpTDZKOHpUcHVUQWtaSVl2MkozMlVVM1NyVStY?=
 =?utf-8?B?K3NmRkp4b3ZsbkVWdmdlYmd2NzU4NXdhUWp1eUcvb0Mzalo5YkJxR3pUV0Ju?=
 =?utf-8?B?Yndybjd0RXdHZ0hZL2ZZcHhjbjJ2U1lsWFJYSTJIb0I0WXVaOXd0L1FCZStw?=
 =?utf-8?B?clEzaFk3NGg4Qkw4YTI1S2VUakEzRVk4Y3FXaDJYUEduTlBwT1VrTWM5azdO?=
 =?utf-8?B?RURzbW04TFl4N3BucUlFUHhiT0dEMnJWSDVzUjEwdjFSdTlONnh5b0N1Yk5L?=
 =?utf-8?B?QlhYaWdYdmUyYmpVdjIwKzExZkpxaG10SU9hNzVUK0s0T1RBTkJ2ZnBCUVhi?=
 =?utf-8?B?ZjI5U1R2cWZlaG01WnlOdTVnSWtNVUQ5UG9YajVnU1l4eU0wTzgrQ0c0cDNr?=
 =?utf-8?B?OWx6SGwxNDA3K2h5MTFiR2FJcXRncmIxalB2L3FmN2o4YXpWWklSU2F3VUQ1?=
 =?utf-8?B?K1NMaTF5UGJBb1MvMlpmT2s0UFpjby8zYzB5TUh4T08rV0k4VnZGV21YejhV?=
 =?utf-8?B?MzZUeTNQUWJpVVoxejRpajczclhhMmE0bHRPa0lQZ24vdFdwMmF3S0VKRmxK?=
 =?utf-8?B?Z214UThPSCtickJRam5hdjg4ZWlBWVQvbFJueDhvTk4rZXNLZ0FEUFNSNFF1?=
 =?utf-8?B?eW1HZzRLcjBCUTRiNTlLQ3hQV1ZRc2NGU3pLREdJaGx3TnZ1Rk9yUEVSelN3?=
 =?utf-8?B?c2pUWGhHU0VrWVdTMGdCUUdxaGNiV3RCcVgxUWtlWHgzOGtxUHJlWjBIemZL?=
 =?utf-8?B?cmJsZFRETzJTM0hRRlRkdm5sUlJuSXBuM2FqOW9kUEhxRVFaU2xuOXl3bnMz?=
 =?utf-8?B?ZlpJYk9BTkx5Y1Irb2QwWjd3R0c2SlJSSGxoL2FURnRBOTdrSWFTQ2QyZTJW?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a0be69-069b-47ce-f954-08dd4c444fe8
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:37:24.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvHQ5DPD1u/iwTnW4kRI94EjmN8oyt+ZudIjoU8lsg+hqHiT46RPOGLW5rRIoyLHsYxQwk/1L6/SMuFBfPoLFw3U3iigONZe3XDftwlpzC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7585
X-OriginatorOrg: intel.com

On 2/12/25 16:47, Jagielski, Jedrzej wrote:
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Wednesday, February 12, 2025 4:09 PM
>> Wed, Feb 12, 2025 at 02:14:01PM +0100, jedrzej.jagielski@intel.com wrote:
>>> Add an initial support for devlink interface to ixgbe driver.
>>>
>>> Similarly to i40e driver the implementation doesn't enable
>>> devlink to manage device-wide configuration. Devlink instance
>>> is created for each physical function of PCIe device.
>>>
>>> Create separate directory for devlink related ixgbe files
>>> and use naming scheme similar to the one used in the ice driver.
>>>
>>> Add a stub for Documentation, to be extended by further patches.
>>>
>>> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>


>>> +int ixgbe_allocate_devlink(struct ixgbe_adapter *adapter)
>>> +{
>>> +	struct ixgbe_devlink_priv *devlink_private;
>>> +	struct device *dev = &adapter->pdev->dev;
>>> +	struct devlink *devlink;
>>> +
>>> +	devlink = devlink_alloc(&ixgbe_devlink_ops,
>>> +				sizeof(*devlink_private), dev);
>>> +	if (!devlink)
>>> +		return -ENOMEM;
>>> +
>>> +	devlink_private = devlink_priv(devlink);
>>> +	devlink_private->adapter = adapter;
>>
>> struct ixgbe_adapter * should be returned by devlink_priv(), that is the
>> idea, to let devlink allocate the driver private for you.
> 
> Using ixgbe_devlink_priv here is a workaround which i decided to introduce
> to mitigate the fact that ixgbe_adapter is used to alloc netdev with
> alloc_etherdev_mq().
> This would require general ixgbe refactoring.
We will try to do that, pending a retest before for new submission ;)


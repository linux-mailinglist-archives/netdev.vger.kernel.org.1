Return-Path: <netdev+bounces-113613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB9193F4D6
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE6E1C20963
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C491145FF4;
	Mon, 29 Jul 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJju1SdE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940D143752
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254720; cv=fail; b=t4P7Mi3PMX3UJ6Q3zQjo6VNIVSKBAan9JcvJn6GprCpsKflub1lng2AbeBGT+HGqtQ9yQ4ROFN7bBVm4BS6f4BU6E72PEPiCvV7VNUsf2CkpzpZ+o8/cVRQO6Z912NA1kHDjoFrxQ6OJzBlICRd2v86eybHx0mn1P5CBxGx6jZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254720; c=relaxed/simple;
	bh=ROr5zZfQF4u68b1nK42mtXQFzWHPGZeG1+hzM0CO8pg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qu20Nt8NMDWLv/DiGEiatdPjQr50g6ApmKKOEjW7OPvlq/F39OfBp5t0rCp5O+2d+w9K4Ws0sZb34Fq9TSz8MNibAt6wOs6kCLpJU7XWTDHpDlgy3spR2fYkim6xc9ZwJLriVW3l+3PhySE086wU50EDZAHyZtQ3iwu4O5M9Z5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJju1SdE; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722254719; x=1753790719;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ROr5zZfQF4u68b1nK42mtXQFzWHPGZeG1+hzM0CO8pg=;
  b=IJju1SdEVnD7PkijTzpsuH64EI8lZMWALzy4rPSx+p6Z3ped1EW20xTh
   sXdBcIzKnbX1lWSPTU5KeoXdT/sXiiDBRuH3qjPWdvjn8RIK4aRfRU+Mh
   qtRB+aZZc4Y1TC2+RC/c+u1IvpRHsnIL7Gw+EDa4Xiz3sdu26OrpXb9Ur
   dmi+yfxJ17I1tDBAA6MtA4ilt4L11GJlw/yr4FLIsVvJok6sN3Yj9r2MZ
   u7+X+5jH8YPttgUF9qEohUQysvucrNeE9T/w9UcYEXpCnEC+2Pq+7DkIN
   Mg/uyzMFhH2T6B0kc2DzbZfTVwDd28CnyGzLz38FfUgI01TbzPNuOwnOX
   Q==;
X-CSE-ConnectionGUID: pfxPT2waTZmrnM/ZQjJYmA==
X-CSE-MsgGUID: Au6Ez0OEQjW/PC9zz0RLiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20182014"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="20182014"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 05:05:18 -0700
X-CSE-ConnectionGUID: UChIhtFGSq+wA5PRjY+LHg==
X-CSE-MsgGUID: CB57k1AeTeaFh2V61ekEMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="91445030"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 05:05:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 05:05:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 05:05:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 05:05:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 05:05:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdS2RCUMpadYlrcJ/ofhKcbvWte7paNsIP2NpX9g9oECh5xKY8cI4FLU2IEFg2ap1sBNF/aRF4KnzfoqKLgbo/Meaegf2Gsk8eh7It1Eyeb4o4yLoFgR3I0x6k1uO3JFsNQz3jMdPwFQBfmPYkHsNIHsbpE6IsFRs0GoY+BrYrbdCrFG3fuwDjtcWMBj2PFAjPPyVWbz3OtfOpGhKPW9rfuJCCVwAFC5dVfYabLbuMF7GGfd0Ba+2f3PvO7A0aRSnfD6RQGF8CCnY3UD+78+YcCyNwt+Daex3GnXX9iFplPqRT33H4OwJ9tKN2CTSPtDXR2UiyZC0Gd31u/CYMFrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N9ua25Q9addV4xk1hVY6fstETwpo+bRDuQKMFvwkKE=;
 b=Cqv9/xQPxpNxkQBXlCHUPuQ8w10L2IUMsZo77xy1nJjO/L1sAH5E1yadizlfVTm8FR+fNuT86FdG3xLvYOCCDMU+iKDbW8qmFc6iL/nOJHxxf81/P/1MsyI/OfdaKw4Rldhz4FXvtx5iMllsRff+/yCHu/nTvqZSYqNsJyrGCSlBfqkEg3bTNsLwS5PY8madm3jt00tYf7owo6C1oaEz91WSpUSuRRUUskZ0nf3P3EsyiRB7IZNJuMXVZZz4wUdmMl6OY52LG1rRCWU+qLoBafJEP3p2V2rkNedipKBVUlFohHeOBVlS5VrwXF7QnwjNgS8Sjiy8a5hWJW1hGQusAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by CY8PR11MB7730.namprd11.prod.outlook.com (2603:10b6:930:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 12:05:13 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 12:05:13 +0000
Message-ID: <844e2248-c842-40a0-b4f5-8e71f3d06c03@intel.com>
Date: Mon, 29 Jul 2024 14:04:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] i40e: Add support for fw
 health report
To: Kamal Heib <kheib@redhat.com>
CC: Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
	<intel-wired-lan@lists.osuosl.org>
References: <20240718181319.145884-1-kheib@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240718181319.145884-1-kheib@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|CY8PR11MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3301ec-ea08-484b-573f-08dcafc6ace6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjU3ZkExaGNFZWZqWk10RjhZTDdrdUYzMEpzTnoxUnEzSy85UDBpNElJMXJY?=
 =?utf-8?B?aVZJS2FKU2lhb1haWEhSK2ZPMjdIR3hJeDFsMUVnSzR6bDdmZFhaU0IxV3E3?=
 =?utf-8?B?am1mVjBZNHdRYlE3SHJpTk5xSkJ3UFRqQW5vcWJlelhkZnhnUVdxUmlXVkla?=
 =?utf-8?B?ZGVsamRYNHJHS2F4VWM4MXpDRVlWb2ZwMmYxcEkxeS8wNy9maG53dUM4ZVFO?=
 =?utf-8?B?ZlBYOWV6TEZ6Sk5yRWk5ZWFWUitmVnNkSmNQMVI4aXhXbjN2VkVWb1NOYjRN?=
 =?utf-8?B?UUpxT3J3aEVTM3VvZ2ovUlJDaC8vSzJlb2JVL0lQbWp1VFJTNzlPTGZNOVd2?=
 =?utf-8?B?TDJLSmxQY2tqNWpHRm5TejVIM0ZFMDE1bTBuamhscmpWUUFJc2NOM0hxSWVE?=
 =?utf-8?B?OVF2NHYxK2UxQURrSmZFK25iRGwweFFWRWRLc20rQ1ZvSVM3RmpIeUxScFBz?=
 =?utf-8?B?OHlnbERLcnhLTkRVOXRqMkxOaktHUUY3d2UwemExUm5lUWN6dDRqSFdKaDRH?=
 =?utf-8?B?QmFMWWJhb3Vid1RmYkFkK2h4S3UvM01Ha3JUMVkxZ0pXeThZS2YvMllNYk10?=
 =?utf-8?B?aEdyUSt1MjA5aTBENTE2MTRxOFZqMmdKNVVjblhKYzVQVzBzR0RVZHNJeXd1?=
 =?utf-8?B?Y0tmd0MyNTN6R3VZbmVKRWRjZEM1MDZoMVJYQ0p3S2d4VEJnbWRQRXB6SW5j?=
 =?utf-8?B?RE9nWmZ5ajJUaDVlMVlmVUpSOXRhaTBPZGpYRnd1V25GU0ViOVZBYndFRm42?=
 =?utf-8?B?UFJXcjdVSWcrcFZQcGtsS0Ftd1BlR0lUR24xSEcvNjhlY1RTLzZ4THZISFU4?=
 =?utf-8?B?WGtQRTAzbStYanQ1a2hneHlLM04rTmtGVXlCQ2FiYXUzUG9ZSnZwNDFMelFL?=
 =?utf-8?B?Q01Gd3dTalRWQnBzOUp0RHNPbU8zRlUvaHJQZ3NEZjVzdWpvOElnVTNqNVJW?=
 =?utf-8?B?dUI0eGZ6c3g2dm8wc1Y5RktvaHZTV090NFpObXR2OVNKMEFibDZ5K3JnVldS?=
 =?utf-8?B?aDAzZHBUUVorRysrRUZCSlRFbzBIVE9Qb3BpQlZ4S2krTEk1dmR6QVFjMmRs?=
 =?utf-8?B?VUlpQU1CdVMwRnhXMEgvSjFhUldjNTdCaGJCVkJGK3hWaElxT3B5ci9pNFo0?=
 =?utf-8?B?NVhpSVhQWjNJVkxCL0VsMlc0THlpVjVIVURtd2NzNURSM3R4MXM2WElUUEVl?=
 =?utf-8?B?Nlh6QXAyOGttQkR6MDRRTDRRa2kxR2s0MkhxMjFSMFVwSnBtQS9NSnkrb0cv?=
 =?utf-8?B?RXcvSXVSWDJUR3dUQWJRVndZSWdmQ2RNK0ZNcnRjeGExeTI1bEdNMmU1WnlT?=
 =?utf-8?B?T09Lc0FwUVgzZHpwMkhLT0tnQndkTDlKeFFadlFRNnp6ZnF4RVlNTkU2VVgy?=
 =?utf-8?B?R2JBTHpmR25BS0N0ZmV3VEhEVXJjYnJSeWF1eXNuOFgwUkgwZDZnbDJtTkF3?=
 =?utf-8?B?bCtFQ1N6WW1Gd0ZERUtSS0FLZVZBYkZmQysyS1UxUmozQzBjVzhrQVJpdVZ5?=
 =?utf-8?B?UmpScUpnMW5WdHEwWUY2VWZLOXN3aksyc2RmU3JITUJNeTJQR3hFVTFoVmJ5?=
 =?utf-8?B?REFOZ0lIa09Fczk5QWF2dSsxR21FSCtPcWhMVXhDZ2JhMmhvZUhlUEVkU282?=
 =?utf-8?B?a0JPMU0wU1NtaW51ZjMydS9vdjRjRTBVc01MaUpoMDkxZEdkV09rNjQwRmVj?=
 =?utf-8?B?TTBxcFJYSjBwSnZOME5vTTM3aDJyRUo2Q2krb09RVWNXZFl6MmlES3dDVzg4?=
 =?utf-8?B?OWlCTjAxeldGQkxPcjVvdXZlemhqVTBMZ0tlenRZMjhTMmt6VDNNeG5LbUNE?=
 =?utf-8?B?MFVNVjgrQy8vdnE2VmUrdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFRSnJiMU1iTDJPMEgxVElRLzI3bnZyd2NhQmVmR0tTMnZvUzU1ZVJKcUVh?=
 =?utf-8?B?eUVJdWRjVXRBQlUyUGpkck1jNTNKSk1KRStIQjBWQ1RWVENsQUN3Y2RMN1Z2?=
 =?utf-8?B?cFI0ZFVkOHFwM2tNZk9XQjRSNFNVMDdpcUk1bzhGUjNVc1EvWTRkYnNubjVU?=
 =?utf-8?B?dFNqczNTUmdnS1NZUzh3ajYxeSs1VWVQaWJKcEJPWFZCUTRrN0QrQXF3Qkg4?=
 =?utf-8?B?emQyZ0JMeWMzUXpVZTZFcHp0OHh1dXlwdFlLZytGeHJ6ZTBGYy9Jd3QwdEsr?=
 =?utf-8?B?bEtFb1dGamdHUWNBbWFuaHA4QTdJL2hOT0tGMVFKM3luY3pZSG51QVRFVWNm?=
 =?utf-8?B?MC9ZZC9RbVBMc1U4WUJNVXljQ3dmUUNVeVNZclN5ZFlZdytLQTRsS0xTdHAz?=
 =?utf-8?B?TEJ5SXE4ODEwRzdUejlvNUx3OFVzZGltL1B0UDJrS1NSYVdxVFdudHV4aXN0?=
 =?utf-8?B?TWtRSjdSUUh5UWF3U3ZZRStHaTh5Q0Vwckc4RlFINDlCYk5BTEQ4OHU2Tjcw?=
 =?utf-8?B?VHNRWWw0THJpc0U1cXpzWEFpZ0pyWEROaEZ6cldXZzY5QzN4M1NTbk1MbWlx?=
 =?utf-8?B?dW9PNlgxSWZiaGIxa2hDVjBCK3NESDNTcy9HQzBtOFFmNU9BQklXem56NFJu?=
 =?utf-8?B?bG12K2hlVWloaUZtRkYwVUF5elhrWWxnNDBJRjN3ZlVZNVRHY2N1MUZKTzlX?=
 =?utf-8?B?VEZaci9wcEdtWnpTa1lMQmhVV1R6RVFPUkt4Y0sxZ01lYVpvTGNENGJ5YVZl?=
 =?utf-8?B?NEZnTUd0Q3FhR0xxaFhMaHQ2OEZtM1hzOWUybmtscGFBOGNpcGZZOGp6ZjVp?=
 =?utf-8?B?N0plVWMvY2h5ZlMzOXlqN0dmL3NlcDE3NTBOejZpT21YMWRMRVBLWXF1d1Z0?=
 =?utf-8?B?V3pmOFRud3pZTk5CcERLdWp0WTBLRkRObE82T2NCdnRBaFdWVXE2VW01Vzhy?=
 =?utf-8?B?aVZHQUhkMElTd2ZxQXpUUC8yVkZxTm55bjlZaVhvMzg0eGhEdExOdTBOTUJr?=
 =?utf-8?B?N1ZSakE4YzFRdmNhSVdueUtzOVd6ZW1wNGNoQVF0NUNWYmQvRjBBd1hnSnhK?=
 =?utf-8?B?K3NoSWtjOXovaTFvSml1eUF2TWhKVnhoaUliWlp5YmZGcFpocGE2VHQ2d0p4?=
 =?utf-8?B?NE5ucnAvUjVWa2gwSGRWSGY0N2NnNUxOTEhtV3BEUkQrK1ZML0hjVVRrMDVK?=
 =?utf-8?B?aklONlgzU2wzbG1pSlFGaGc2MWlLNVFpSlhoNjcrVjF6cFNuRkI3dDU2Zm5O?=
 =?utf-8?B?YlVEZzBoWDY4dVFMcTQ0NHA5bFp2MTR5eFJXTUhVazZpOTNsOTQ4bVRYU1VU?=
 =?utf-8?B?dXdmUjlMWmVwRXVHSElzNzZtUFpzNnUxaVNIYXZkZ2M3clJlbjIrMm94Yzhu?=
 =?utf-8?B?Nng0L083bkp2NHRhdW8wK1o0bFBML1JWdThtVFpleXRYZVpXY2JWQnpERmJD?=
 =?utf-8?B?RVZ3SjVCRkZ0ZENSa3lucjV3UXJxUCs5Nm81NXBndGNId2dmQ1RPSkpxV1h1?=
 =?utf-8?B?NldudzlUQXRtdzcxaHdRTE9BSGF4aDkxYktKTU1yOXV1UjRjdzRpajBYYTZG?=
 =?utf-8?B?eXNZTy9mR3cvZ0t3clZmLzQrM1FQUFlaWEVuT0VNQVZkbXZSOXlBclRsZXlR?=
 =?utf-8?B?Z1ZxV0FvNUxRb2hqcVl1eko3N3ZiSXFKSVd5REszSTdzK054SFBoa0RLZ1R1?=
 =?utf-8?B?SmRDRTlBbWNlU25TcGIvS1lqRDhQWWhtdjdKWWlRUDlHaU43UmhSTUFOWmc3?=
 =?utf-8?B?M0R3aUpDOE9wLzJqNnZxckhidElJc1pKVW5wdW9LckRUVytZS095V3hKMDFM?=
 =?utf-8?B?TVZNRUZReU5VWkZvWWg3UTlQWVBoZjRSVmhpRU9PdUwxdmUxbjk5Zzc1V0R5?=
 =?utf-8?B?QWJ2NnJEVHpMUmN4Q3RIMVBGYlJWTmFyUm9VZUxEZkdlRTVUNjhPd0Y3YmFl?=
 =?utf-8?B?RXk1TzU2QXF3V09nR2V6K1ZyMjF1YzErZGFiak5NcmNObnNYYjQ3Z2NRTWZZ?=
 =?utf-8?B?bmVmaXQzdE00d3FaaFpRTkI1MWZNRG00QTNLV0Fwc2wwV08xVHp3c3lYVmt3?=
 =?utf-8?B?OUpxN2w4c0svY3hRRWJsKzJqUE1EbUltT2EraENhc2hHYzRRMkNSaFA4R2tZ?=
 =?utf-8?B?Z0tJY0ROdmxrRXJkQUlqYnBXTW94RzlFeDhvdWF3dFd3UHJHa3lsd2VzZ1Ja?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3301ec-ea08-484b-573f-08dcafc6ace6
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 12:05:13.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfbnKDkdtM47Vd2qJUDRN0Ng1RJNQdGW3M5StAIPNLDxtZA8bUDwFd8cP72QRvJ5Gdz/1rurA6Mh8M+LCpeB6Pl66B3jmLi9Ojs+Scj2K20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7730
X-OriginatorOrg: intel.com

On 7/18/24 20:13, Kamal Heib wrote:
> Add support for reporting fw status via the devlink health report.
> 
> Example:
>   # devlink health show pci/0000:02:00.0 reporter fw
>   pci/0000:02:00.0:
>     reporter fw
>       state healthy error 0 recover 0
>   # devlink health diagnose pci/0000:02:00.0 reporter fw
>   Mode: normal
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
> v2:
> - Address comments from Jiri.
> - Move the creation of the health report.
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>   .../net/ethernet/intel/i40e/i40e_devlink.c    | 57 +++++++++++++++++++
>   .../net/ethernet/intel/i40e/i40e_devlink.h    |  2 +
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 14 +++++
>   4 files changed, 74 insertions(+)
> 

[...]

> +int i40e_devlink_create_health_reporter(struct i40e_pf *pf)
> +{
> +	struct devlink *devlink = priv_to_devlink(pf);
> +	struct device *dev = &pf->pdev->dev;
> +	int rc = 0;
> +
> +	devl_lock(devlink);

if you are going to have just one health reporter, you could just use
devlink_health_reporter_create() and avoid lock+unlock calls here

> +	pf->fw_health_report =
> +		devl_health_reporter_create(devlink, &i40e_fw_reporter_ops, 0, pf);
> +	if (IS_ERR(pf->fw_health_report)) {
> +		rc = PTR_ERR(pf->fw_health_report);
> +		dev_err(dev, "Failed to create fw reporter, err = %d\n", rc);

you are not zeroing pf->fw_health_report here, so ...

> +	}
> +	devl_unlock(devlink);
> +
> +	return rc;
> +}

[snip]

> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -15370,6 +15370,9 @@ static bool i40e_check_recovery_mode(struct i40e_pf *pf)
>   		dev_crit(&pf->pdev->dev, "Firmware recovery mode detected. Limiting functionality.\n");
>   		dev_crit(&pf->pdev->dev, "Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
>   		set_bit(__I40E_RECOVERY_MODE, pf->state);
> +		if (pf->fw_health_report)
> +			devlink_health_report(pf->fw_health_report,

... you could possibly call devlink_health_report() with ERR_PTR as
the first argument

> +					      "recovery mode detected", pf);
>   
>   		return true;
>   	}



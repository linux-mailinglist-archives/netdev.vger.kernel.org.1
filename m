Return-Path: <netdev+bounces-129253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3118397E816
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27F31F21709
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A391581E5;
	Mon, 23 Sep 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHfARhTL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472B49649;
	Mon, 23 Sep 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082265; cv=fail; b=HqnQ1sjg+xKINGpeN3Eq1a1khq9fPfS4r4/sjPVxmuVAHM1JsokVV6otm7OW+JdP5tQISXfSowfviW01u2bK5WVV0pPdepFlHy4XcFTEfjcBaY+fQyXcjkskxezsap6rQdTDXY8kfKIhzGn00Pbru2NH/aVqqcXR7u+QY9zisPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082265; c=relaxed/simple;
	bh=NHp3bQh3L9w6lDeX5iUlNAB1rult4nxuY+/cz5OIyZg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PZbp2TWPd0wdKCoSvTs3+FhUvyOkBQ8kMjbhhpEHI/Ap32ByuiyUv473dzKFF84+PztUEEydPax1me8IYpcp51KIwrGgXO2iL9+MLEUjWSG0gEsyB0z2VJNUQl/i/hLkkerFDyPUiSEUsfp+mqa+sDWwiDEaOG00apYwKdM+bl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHfARhTL; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727082263; x=1758618263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NHp3bQh3L9w6lDeX5iUlNAB1rult4nxuY+/cz5OIyZg=;
  b=EHfARhTLwJD0fS1NGauldtAB18SDsLx7aSJYGDop+oBwDdYoj8US3T7B
   gxAmIFzfV57txNFiX1qvGJFCOkXj3q8rQUmEtoymj4lpw8ApcZo08xQCJ
   XMLN3gq2voSN24xDVpXRi2Bpx8fvEfgwkKwn8jAx3Il87OgV88gVrzHl1
   yvPoMEgJhCfXrdtqecUoK6wsSqv0urwyk1TXkQr0wgvgYCB2jtwfizI5P
   qwvIoH31PzJUSi0XdaJIJ8+gLxM2Nbrbkv5GMUUuKxeAn7h3/j8+0nOAt
   ALn5SuODFOO66VcMJiVVCcPI+joiifDNYolc2ElkpfIr7Upf/MZEn1+AM
   w==;
X-CSE-ConnectionGUID: 3qyGYzWxQgKqXUblptVPdw==
X-CSE-MsgGUID: A0jNM6cHRtCbSGp3yK8KIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36685378"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="36685378"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 02:03:05 -0700
X-CSE-ConnectionGUID: xxJD4nA4TyicC5/Ofp7veA==
X-CSE-MsgGUID: wLcI88iXS/m/5gBEgXphLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="75772396"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 02:03:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 02:03:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 02:03:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 02:03:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 02:03:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khNlNTiirFixrlDEcs1EyiFaDkdpIumK3Q4aeH435rL6UoJXTHVXH7TNNj75de/z3oPU5b+nJEK+kK/qsUTmBH9P3BRUY8H7BCWcp2UWnPJfIcGOIog+6i2zZNQgcUN+n1WmTGbsbRaTEcAnmfUIS7L1XcLFLre20mJjD6y4aNkeF7xSoGmVYD7LrcqEr9yx1l6Xbe4gRIM9CxzGIIxVwED3+ER3m9HQdsJzUPTOHsToEd0IllSgYhhE9aenIcFBIfYWTk+oomywUzadYVyG4+80dmLwvVW89HbBL5F95V6sDKvJH0dVCp+rhHX70QTL0zbZN9B7kK5pda6b0CyJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDj0i3niG0ri3AN0lR+jbSVz6tIxrtAXzucXmPvjMCs=;
 b=IUg6o/kq0gnErUCcUzpMAck4zfX+beMesZeygpX8seChMVD04/WIA65jG7BwmdHO09Fv4/7QV+yvFsh6c4Prwde0kgtZkLV8pomuDSQYbYUL10FhFd0z5ZHbacZ4vJszLp+KVG76KXBIksAsvtJomrFh5tsDCm+ODNa/8WKzdO0A1wBG8MGZYhSxxi+QSgyMXAph790x9Nk/yIuG7Lz5Gq7vtPR+J/We3kmAkpvYS5H1bOxegeh5wOVag75xA2n0oDuY5HDp8pmmsSbeVGiO0dStG2p0e42wZknViuMxZ3Z7WvzGT9UafiINarD3iEFxte/ZT3d+4aaDiVkDBJ/13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW5PR11MB5786.namprd11.prod.outlook.com (2603:10b6:303:191::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 09:03:01 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 09:03:01 +0000
Message-ID: <02076f9d-1158-4f3e-85cc-83ee4d41091e@intel.com>
Date: Mon, 23 Sep 2024 11:02:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 2/2] igbvf: remove unused spinlock
To: Paul Menzel <pmenzel@molgen.mpg.de>, Wander Lairson Costa
	<wander@redhat.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240920185918.616302-1-wander@redhat.com>
 <20240920185918.616302-3-wander@redhat.com>
 <7e2c75bf-3ec5-4202-8b69-04fce763e948@molgen.mpg.de>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <7e2c75bf-3ec5-4202-8b69-04fce763e948@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0044.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::20) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW5PR11MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3131b0-0276-4ca6-1b8f-08dcdbae86c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azBUcDZ3NVo3NmNyNkFLYkRMZEdEdUFrWC9qNW10SWlNbnRZb2pidUplRmFr?=
 =?utf-8?B?V3VnUDIxUWJ5S3hCMEZ2THBhOXhLMmtsNHlzQ1lWMzd3d1ZMS21aMzNhMmFL?=
 =?utf-8?B?cGxzOGcyWFpPdXE1a01QQXhIZDdsWnJMRkYyN2wyTVJ1VEVjZWpMSFdXdU1j?=
 =?utf-8?B?WitWMlN2a2x6TWlDY2oxUjM4UW15ZkVMRVJDcWRVMWVxL0Z4MkRWWHVpNURp?=
 =?utf-8?B?Q0lMNXA4b3lhU3E5MFpwZ21UL1ZTU21PNytBM2pNZHE1WEczN1ZXU3UvSkRJ?=
 =?utf-8?B?VUVIY0d6OUZSZlVENzdLZEdKa3lvbmZRWDVSdFk0aUREWEt0eHhVcEhVRDM1?=
 =?utf-8?B?T1JNOHZXK3BhS2ZWNGp4R3BRMjlmaHY1YjMzK0tpbnVKd3J1ZVNNdjBZSGp4?=
 =?utf-8?B?NHV5Q3k4encvVlZ0VXVzdEU5cjc4MFZ3OVVXekJYVmxVN3Q2MVdodmcwUmdZ?=
 =?utf-8?B?VVpkV2R2cGNMOURFMTV5TkdVdHY3NFlLUXZ0WDc1ZDlMQXpmZlVhekVyUjFP?=
 =?utf-8?B?bnJUbk5ZdmtzRThvaTdMc2F4bjlueDJwNDNmQjIyYnp2VzgwRGNOYnkwQTEv?=
 =?utf-8?B?WDVMa3Z0cTYvSDBDc28vVVFsR0pOVk9CN0MxNVBPTnVDSzVhUHhaTUZJMWhy?=
 =?utf-8?B?SVpIc0pqQnFFcUVIeFpSWnJsUmRHaWcvaDB1TmJCQTFjMXBUMndobVF5OTd3?=
 =?utf-8?B?SWtiV1dCc3dCNEZSZUJoWFJWQlFaUWhpSU5SOVhFUFBJaXFFMVdlMTlXNXow?=
 =?utf-8?B?Lzg0YUl1LzRNME40d0ExNVowdTBXQ3FaS2VQdEpNcERnR1BxS2ZWT3hwdnhY?=
 =?utf-8?B?MEJFU0QyVUM3VmhnS1V2bFJMWXBNenhTZDQ2WXNrbjc5RjUvNzFYR2wxZkdv?=
 =?utf-8?B?aVhkdU53QXpsRGlUUmNBVmVYQWVMeno1anhKRGJxa21uaS9BVEQ2RUFhYzJS?=
 =?utf-8?B?TnBiTW8zZWVPaGN6WVlWUnZnU1NQNnBEaVk2VkUwR2xaZmU5ZlpRR2tyYUhl?=
 =?utf-8?B?eGpvMG0wUThYTHI3MVd1TGpWYUFDMG9janA1NUdZdzVvRXhSVFBPTXJLVjFm?=
 =?utf-8?B?RFB2QTd4RzZ4akxod0RBS3N0dHZFTkUyZFd3b0lMb05OMkVpVjZYUTNTcjdI?=
 =?utf-8?B?UDJIeGg3aEhBOFRieFVLT1d6S3ViYzJYNDFGWnFnZ0wvbVhGbkRsOUVmU0ZT?=
 =?utf-8?B?Z3NtM2xNcUIzclo3WXBJaXF1TlpTVU91aEh0TXlLZkVKcG03Q0RNNGwySEV6?=
 =?utf-8?B?RDFEZHBpYWJ3eloySHZGdmNjWXBFRTN2V1VSY2pLR3AvUlVPMDV6YmpKTzRm?=
 =?utf-8?B?ZUkxeTB5bEk2cm5OckFBbG01TlV4Q2RTMWxEalhkbnhpZ1Izd3pCMGdMTldG?=
 =?utf-8?B?L3p5ZjdFNUloTVgyZjhkcXl0SzRXQmRNZEIrcmczOURwK1haRkZCeDVWWWlM?=
 =?utf-8?B?eFhsRndTZ2w5R1FtYTJnRlJ4R2U3Tk53bWI4Y2FRbmpTeUcrZFlWQVh1RWFp?=
 =?utf-8?B?Y2NRWSswdHlvSUhzNk5waldSdlVWVExGd1Y3VTBzZzZrTUNuUlhydVFQK3RC?=
 =?utf-8?B?Mkt1UTFUY0FUM0hNWEN2VzZCdjdjUXpsVHVkMGJkaW1pMVVOYm53SWJkaEZ4?=
 =?utf-8?B?N2VwczlVWFJtdmdZNnM1c0ZyR3JzbjJKRCtRcExxS3NyOXQ0MGE3TkNuaVIy?=
 =?utf-8?B?UDMzNHVRMnF5eGR2QThXN2hhblZ6alJBUDJKcjZaUjJRQXlPb1dOYjN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1A3aGZFVGI5QU5IeWtER0d0NHpMQjBoaHU5U25nQVd6Mm5QdGw0Z0ZpeEMz?=
 =?utf-8?B?UkZwZ3MxZXd4SG1WWVlON0tMampkUWlWaHJjZjVpSkZvSjJkT3lQcTJZZkU2?=
 =?utf-8?B?UnV5bG5IL2QwbEQzYXU5WXY5RHVYN09JZ0xYM0VURHJKc3htaHZJQmVxQS9F?=
 =?utf-8?B?UHBOQW5QcHNRQUdoS2ZhQTlXYnhuZWFOSk1HTTdqSDZPUWVvdmZFTW00SGpE?=
 =?utf-8?B?dWIrY3RVbGZibk53Umd2djdQNDh4SE80LzQzUXNrYlFscjZPcUJONk1qRmRs?=
 =?utf-8?B?OXQxTk9EdnVZcElIR3ZFWGtyelE3UVp1Rm0rQUlnSWh4SjFRQXF1aHBIMVZu?=
 =?utf-8?B?WlRHUkl0dW84UlJYVW04bXBUOFVmZURneWROcnNZdSs5QU0zaU5RL3RsT2o3?=
 =?utf-8?B?dVp4VGNVbGhMdzZzZitTK2hzTWNFSkNiN3dPOVFhcStJNGNTVkpmRUMzeXZq?=
 =?utf-8?B?N3dxMHRFcWNCTEYvTDdsZkxyQnY1d2RBMVU3NmZZVkVOMHZ0ZjlHWWZ5d0h3?=
 =?utf-8?B?dzF4c282dVg2RFFGYjFsb3plNGRieU9UUGYrZXJaTzJlYXJYRVpOWGp3WDc3?=
 =?utf-8?B?djRDSTBmSFBkTFhMRWZmYTB1QTdaMEJFWVdqVnFmQnI5V0k4em4vQXZFdXlV?=
 =?utf-8?B?cTNlVzNyc0VaeTBhditONU85QmlCZitZYTFJK3VIU2ZCVE92dTYvSld0d0pz?=
 =?utf-8?B?Snl1K1o0bTd6TmRWZmt0UzVvV25QTUJtaEpXTVk2VXhlbGwrRWo5VUFzRHMz?=
 =?utf-8?B?SDNYUDljSzlPcklxVklmRnV0d05CaUpqUDF6c28xenpDS2FDT0ZEaFpQYU1V?=
 =?utf-8?B?YlFOSFdNMkRNdjJ5aWNJOElRaXRZQ1J3azZBZGRUYVBqMStWeWcydnE4MXZB?=
 =?utf-8?B?TVZpK0Q2d3RlQnBDYkNtdVlrdmZEN2w4dnA0NkhUVEdSRTlaS1lXMTg4dzZv?=
 =?utf-8?B?bGpPMitvNGtFUHo2eE1lNG1lSU03WUtDTmt4S0xVZGNFNTBTL294cnBiaVpJ?=
 =?utf-8?B?eTcyMWNZS3Noc215Nnh1Sm9WcG1NVkhKUHY4cFUzZFd2cmVaeTNwUHFTMkRl?=
 =?utf-8?B?QzY0OGVGZkFvMUtoS1QxWE54cDJtL3MycUwwTU55VWhiTE5WWWtMNzJTNURn?=
 =?utf-8?B?bVA1MVN6MkZVeTdOSkxBY3ZpS1VYQ0RqSFNYZUFNN0JHcVd2RkRWT0ovNHor?=
 =?utf-8?B?VW9qOVVMeVlxampyMVZDRkZKZHdHZkcrMmEvVGZzSldKS09Qd1pFUTNYdVhh?=
 =?utf-8?B?K1hselBiUzZkdElTWXFIdUkzL1pSSDBWM3V5QVJQcnd5ZVpDMkhpTENxR1RC?=
 =?utf-8?B?UUYvcStOVTkwSFJqWEhWdFVkNDFXZjJrUGxpZzM1R00zM0xLN3dKRGV6NU1r?=
 =?utf-8?B?TkdYMy9vVkpVb0w4UllqR095UXFiUE1VTnc0aUFvVzJJbWkrWi82cXJxRU1G?=
 =?utf-8?B?L2dHTDRUdXRLUmJkd2kyTHVmK2pEbDF3VEMxVDkrT1hCTEZSV2x5STFJb1ZG?=
 =?utf-8?B?aXNUTGJCZk1aL2hvZ0NQTG5FWTU5K2IwVDc1dDhLMFJHNU9iNHliVDBIV3FG?=
 =?utf-8?B?QjJZNjFEcTQ1WWxWN1pOWE5nTnhQbGhIVXI1WVo1N2FUcmNucnFIb09ra0Jx?=
 =?utf-8?B?dERmZFY1SjBVUVpodE9EMkw2eWxqL2t1czY0TjN5b0hxMEpvSTRaQzFKRVBr?=
 =?utf-8?B?dVk1NkQ5akVONXBBUStKSW9NMkJXaHNwMEZHaC94U0t5MmtCN3lIWk5ZM0tr?=
 =?utf-8?B?TElZVDBVbWFPcmFjZUsvZWtlMFlQbWs1SHZYb2JYckFqWjE2QW5VTGJGZito?=
 =?utf-8?B?VU1JRCt5eldpT3ZkMXlQaDhSbWZXUXY2ZVBNd2lveHBENVE2WkVIQnY1RG5a?=
 =?utf-8?B?YXl5dEtnRks0QTBDZS9vejg4QitNR0grYmNkSU1ZWEIyMmxPYjJOQ1UzTkJx?=
 =?utf-8?B?TVkvUllyUDRlQzhQSmlVY3pDU0tqd05KZG82R1JNMmo4RUFONTk0cFBOVzRP?=
 =?utf-8?B?VGFOcUhiSFpxalI2eVlVeEFOYVRqa09Kc2UvdkRTQUZ3ZFFPSEIwNFk2RS92?=
 =?utf-8?B?YkVNd1E0RmFtZkpDaEFHOVpVMGNzKzFNc0VnbzF4RWt5eE5ZQlpoNERROWQ1?=
 =?utf-8?B?UUpCeWZHaXh2aTZVRS9pSkZ2VzJUdlJvTjlDcDVoR3pVSzJJKzFmaXRuS04r?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3131b0-0276-4ca6-1b8f-08dcdbae86c3
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 09:03:01.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRMsVGrNSwXiPIeZj2Oz4wQByx01fj/bzCTP3FBLxMOz55UL6ZSD3jXmnVcaMoBf6uSip/l/tbFMeu7FoGh5QXxGTuJOK0ZTNUHbY9RNr3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5786
X-OriginatorOrg: intel.com

On 9/21/24 14:52, Paul Menzel wrote:
> Dear Wander,
> 
> 
> Thank you for your patch.
> 
> Am 20.09.24 um 20:59 schrieb Wander Lairson Costa:
>> tx_queue_lock and stats_lock are declared and initialized, but never
>> used. Remove them.
>>
>> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> 
> It’d be great if you added a Fixes: tag.

Alternatively you could split this series into two, and send this patch
to iwl-next tree, without the fixes tag. For me this patch is just
a cleanup, not a fix.

> 

[...]

> 
> With that addressed:
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul



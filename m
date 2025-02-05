Return-Path: <netdev+bounces-163063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C837FA294C5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2168B3AD0D8
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6BA157465;
	Wed,  5 Feb 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QybpzJBj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567DB156C5E
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768857; cv=fail; b=IAQywuHHqCkQs79yXvOV8BKPCSlK46/8WNepO4eyAJg8+srtSixBftmqHYgWIUqim49a9yZAuNttRTMsc5RFl6o0uAZASjeDqYwg0sNHizO0l2Odaw+LRvTMho8Av4sS5mqWz7FT6cjMDs7f/XtYnlDV7sC+1ZgsdUub5GQ6Hac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768857; c=relaxed/simple;
	bh=dhRgdkIBb1MS1mWe/Nm2lAL12dQd/7OjydRgQhp8UTQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FCV1y3PKPU+a4jDqfZIJlvyXjWTA08239xrahl9h8P1CuEUpLJMXJ4fpv4DCHmvUwinZvMrruR203qApsHGZbpoJJDiIAf5zOub5PY8lZ122zV9RjQtd9SOP5iYmqd7UbnmxMusphpZzrwqtvNKYBbjqj0gSisK3Oaa1LZkN/Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QybpzJBj; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738768855; x=1770304855;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=dhRgdkIBb1MS1mWe/Nm2lAL12dQd/7OjydRgQhp8UTQ=;
  b=QybpzJBjQZfAzMFAm5B41aWi7BLB3IOkq6xF+1+MoMe0Od1L+iHpzOxR
   LjNZJ9MZfpcLgTF0+3JTjwH04aIoJprXCAHUKCyz4sazEd/TYb2LVN7e/
   +zMUG79WcshWfgrqDtQzKenJlMkt6LZNHtpZb+/qswIU0iX7L4Hz0DIE2
   r9b9RH4DkFb+OQjq+cLfzRxFQ/h7wSMjGLED3q0lr4EvqKwBCcC6CuLSU
   NXx9aG9kOtayXhBEAdLv5DhBcSEXrkbCqI65fi4E346zBJ9fYeo2Z4jmC
   6ZJljH/OB/4nDNP51dhtu12BP1Pjp5jLzc8If6Ahyqr6SM0fxHxzq4aCX
   w==;
X-CSE-ConnectionGUID: dE6wAubDT7WYaR8fOpAHfA==
X-CSE-MsgGUID: BZtQv9juSPOiWAZbIB+oNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49955828"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="49955828"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:20:53 -0800
X-CSE-ConnectionGUID: E3SITj9wTMSkMvGV9famJA==
X-CSE-MsgGUID: u9fWoR/ZRX2TOLUcXVocQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111374185"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 07:20:53 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 07:20:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 07:20:52 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 07:20:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/X+tE8z2yKotEDtIRvdAE5Nj08luMvgoLrwxsIEkeor2XB3C14cuO72eVbQsz6B0QDsvHL2FwT5WpkwX3IhCEB+zDjHQpC25H9UQewuNmgHYGPRMEYdZokN5W84vbXJFwe8QBusrVL5gKnb9r4e9I2tsHp/sJ0vik5prOm+PyGOx+fs6Q7OpxK0FJi4X6nCrlkNaJ4aDS2gWnTtbyLdnBmUCig2fD4fmoPGx2qP8WcpuBJWk8jA7tP/YZn8Rwdq2yyyYywIMbPZgACtPjNbv8gHjNVk4FBk+IBsoMMFuszxvUNoOPYOd/v4FOL/c8clZ80C4JEy+sY6X63FvgjNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXpCgQ6lQN8Sa13rYvB67vRA2zJnnJ3Hg/ysrP+hQmc=;
 b=kYT7xdR1bU7n8ZtxLjE5WRDYbZsI2kb4MBuWuEzFWjopQFrSnk+zO95B+ZMXuWhVjFPgtepJx5IgX94vOBuUv09pXT1b/h74f+nZn4BjMDeYO9AE5L78GV4TDglpbQQJyjaxthCnIdRJD0BbbTRVYwdfzuwJR77eBdxl++x8XoYpWd9Ds2wZgrZE2OYclVdySUojutE4RBtNxHZKWA0g6jlnPFR1mhoHn1u1SHDTnVtbboGAioh5FLMQ0dzjeY6QJ2Af+VGPEnQ+4S4BZZv/I1FwcB7g4KzCqd11ITK6rd+JW5OEPCEBVGymoZSKpJPhBe/TNXUO8pNz/AzupTmlig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by DM4PR11MB6263.namprd11.prod.outlook.com (2603:10b6:8:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 15:20:32 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 15:20:32 +0000
Message-ID: <8270a43c-61f8-446d-8701-4fbd13a72e32@intel.com>
Date: Wed, 5 Feb 2025 08:20:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/5] net: napi: add CPU affinity to
 napi_config
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <andrew+netdev@lunn.ch>,
	<edumazet@google.com>, <kuba@kernel.org>, <horms@kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <michael.chan@broadcom.com>,
	<tariqt@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <shayd@nvidia.com>,
	<akpm@linux-foundation.org>, <shayagr@amazon.com>,
	<kalesh-anakkur.purayil@broadcom.com>
References: <20250204220622.156061-1-ahmed.zaki@intel.com>
 <20250204220622.156061-3-ahmed.zaki@intel.com> <Z6KYDs0os_DizhMa@LQ3V64L9R2>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <Z6KYDs0os_DizhMa@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:303:8d::21) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|DM4PR11MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 720ce7e1-afca-4a94-28cb-08dd45f8a170
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWxLK2Y0VzBTL0J6NWxCdU9PL0hiRmk4a2Y2T3BSYi9oZEtBMEJJQTZoeG4v?=
 =?utf-8?B?VnBXcnQvVlR1TVlKVmtjVW5GR3ZYUFhtVTVWa1kycTNOQ0dSWW5wOWNNcUsx?=
 =?utf-8?B?WUV6UHBSbmNYZ2MxTU54TGplZlhGSTIxV1J3bkxVSUV5Zk1sdjRVS0R3SFd2?=
 =?utf-8?B?ZjF4aHVzdkwxQ29hYkRaV0l4VnNnNzl1ZklFdGlGRmZCUTRjU1Q3bGJVZEdF?=
 =?utf-8?B?cWRKcEtyN2lleTdkREg2bDhUTGtYY1h5UTRSUzR6ZzB3QU5rV0xFdzJ4V3RR?=
 =?utf-8?B?QVVGMVFhSTN0NThTMlpPNzFoM3NjcnBGUlJZTWZpV3RydmJ5YWMveVJwcUEx?=
 =?utf-8?B?aFRpbFFJMkoxZUx4UXVSenUzL0lHUENqWlM4NkF3eWpIZlFxWXBPZHo2MDk5?=
 =?utf-8?B?QTFScXM2cVdWQ1NPU1Z3Ym1ZVlowZ0VMWlFZY0taUWxWMHZRQk43VmhGQkFL?=
 =?utf-8?B?Mmk2YS9GYVoyM3JmN09wVkJOODNsVVRaZGZ4YUoxb0RCMnlVSzhaZGx6b1hY?=
 =?utf-8?B?STE5SnFGMWEwRUJpWWd6V1BYQzJDK0trWDVDdWdlZW1IbTZuT3UyK1dBWE96?=
 =?utf-8?B?TnZlais0bWtEZU9qaXNPY0VCenZEWTNNekdrenJxWFlvSVBFcmtBRExtSG1F?=
 =?utf-8?B?S2hnMlZFbDYrNEoydXBudG1FZ2xJVm5ERi9mcUJySkc1eUhYa0xzdEFENFVy?=
 =?utf-8?B?bEkzTHluZjZabGNHNWR0ZVRJNHRKZ0NtbWNLQkc5dkJsNk9ZUjA4K2ozK1F6?=
 =?utf-8?B?ejk1Y1dpYnJkcUtZaG4rcWdvOXRQQ2h3aE1zM2VCS0p6dlhHSWc2SXNveHcy?=
 =?utf-8?B?b1BTQXhmU0M5ZGVRNGtaSDAycWdZaVlKNlkwS2FBRTRDcGxvNlF4SEVFdmhE?=
 =?utf-8?B?cVo1bE84emswdXdjMlcvSDZKRmZQZXBXc01DQ0YxbTk4N1FXeTFwVml1ZENz?=
 =?utf-8?B?LzgwaGtZNEdmc3FTa1VFaU5ZS0R2cW1qcGVkSTB1aXo0ZFh0QU9DdUFRNElG?=
 =?utf-8?B?cUdTSGVYUTZqWXc4ZHNNR21FREpBNFQ5SmFkRCs2OHFESzJZajVuZnhBYUpE?=
 =?utf-8?B?ZVF4MVFjNm9OZE1iWnQ5ck9UUy9KU2QrWGRjWjFJNlhoMFhuMktRNi9ZbFhX?=
 =?utf-8?B?K0JyUlRCUEV0ZExFS1k1cVRtVzlqYm05VU1UalNJcTZ6bS9OZXJKZC8waVBq?=
 =?utf-8?B?Z1RNeHpqYVFnV3J1M3AvaXZDY2FkSmRYNm05TnRsWUM1WS9Mbm92bHdkeEVV?=
 =?utf-8?B?ODkxaHM0VVVETHJqN1BJM3lEdnRMeHZWQ2pNS2RjMUd1b2xoTTNMUjRFemF2?=
 =?utf-8?B?K2VOQXUyMVorMEorajNZdG8rQTNPTzRCZG9sbFIwZzFNRlRGTjVvQnNMb3RY?=
 =?utf-8?B?K0ZaUnVMMURvMUFEY2NVeWt4WGFuV2FHYUdsdE5lVmtDa1BvQjNqeEdUbkpi?=
 =?utf-8?B?c3N1M21yVGhPTWFkUTJOKzVUV0E3c05HRUZTT2ZRTUhHT2tyT1k4MGt1WUFU?=
 =?utf-8?B?UWlQOGFUTkkvbmRzSk5rSmtUeWJ4NFRsQU5DOGM5S3BwWEdLTmNTdm1IR0R0?=
 =?utf-8?B?SFRDOTJHZitjdXZ1Y2tBZlVoNWZnUmJrUncrQkFWZUdueFl4NlkxR0F5aVN5?=
 =?utf-8?B?NndRRERyVTlvTzZHNW5iYkhVTEVNT1ZUbC9COUZZUG9mN3A5YjRaUk1oK0Y3?=
 =?utf-8?B?ZEY1anJxaGY0ZDIvazdhOTB2blpaVFlESnMzcDRrVlFnKzNMQ3JMZTRGejkw?=
 =?utf-8?B?ZWtTN05LL24zM0dlOVE3TXgrZG01OFlTc0ZwZE13WC9ydWZuN2thek9KcFhC?=
 =?utf-8?B?UDVoeEZSdTFrUjBlRDRPMFM5Tk5DQkozanFHMmIzeEcxQlJJV3dvMEJmQ3dW?=
 =?utf-8?B?SnFmaWR5M0l2dHVJMFg0aXRFRnNDWjlldlF6WWZpTUd1QytUdGdxaU5UL0Nx?=
 =?utf-8?Q?yMO2a7yN++E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlhTT2hUODFqNE90RXpBRjUxbzZDYS9Pdnozb0ZZVW0zSnprSmR4Y2NyYy9H?=
 =?utf-8?B?YzFyekk2MWRaaEFETi9XZGlaZ2YzMGFieTVoRlA5WE50WjRyZ3hQdDkyTzh1?=
 =?utf-8?B?S2JuaDVOYW9scDZQSUYwQk9CNlVGQ0hFRkpmb0d1Qi8raFh2RVVnOTVwOU9x?=
 =?utf-8?B?cXNlMEFybWZRWVM5cGVuVlM0bFZPTEF2MStYdzBCQmVwaVJLNUl4N1dWUWp3?=
 =?utf-8?B?ckFJQmtJY0MvdWRSY241ejczZFAwZW5paDJlSjZoaTBQNU9KTHorWWljS3Np?=
 =?utf-8?B?dkdrdXQ4aXR4RUFaUTFpM3JRT0QxdklMTXZJUjNXSUFvWmVRSEdGUGwxZFd4?=
 =?utf-8?B?VXVwMUd6Qi9scWIraWRKLzJvWDlpL2NBRm1yT0Q2TDNXMVBNMG1wM1RPMFdW?=
 =?utf-8?B?c25xclEwT1haTjZQUnFBTlVRSFNZV1o2TG9wVzQxVkJacUt2dVVsWHNnZEpl?=
 =?utf-8?B?N0hxU1YreW9pV2g2MEVxTUZseUtqS1ZZVUd1OHFVRkFqT2tkYnBFYjJBS3ZZ?=
 =?utf-8?B?V2hBV1VlazIralBFQ1lIcFQ4YXlhVzU5c1dtZjdPeWVacnE4R0lsbG5Ucy9Q?=
 =?utf-8?B?NEJ1RFlVRVZvd1pkRjRXU2NsSnlINWQ4cTQvTEN1d0xyUjZMUkxYdnErYUtC?=
 =?utf-8?B?enZqZDRLNnZEckJmY0F6N0pmdnprbURwdzJ1WnpSbG9ub0lDakJPMkNESjdX?=
 =?utf-8?B?aXpjMDZ1T1JpUGRtcUpCWUxOakgwUWIrenJ4d3JQQ3puUlJ6cDh4RGJ5UUJD?=
 =?utf-8?B?WWdSa0syNFFxQmZzNzdSZTc0bnVsMlJ3OW9VS2RkRmZXTjRyQW9XLzBOL3RP?=
 =?utf-8?B?T0pMY010TmMwZHVVaW5oMlpFWnU4ZG8rNkJISkdpZG9mc1dFT2F1UFVKblhI?=
 =?utf-8?B?NHRPb1d6MmtFNTlnSS9TV3Q3SnlPSVROdEROSkZwNTNmSzBWbGk0M3lnc0t5?=
 =?utf-8?B?UDkvcjltTHM1RkFnMGg1SHlDTno2UEV1NjNHMlRoNkx4Ymk0VG5sajFYUlZp?=
 =?utf-8?B?V2hNb1d0eFZqRWt0YVBJNGd4TkpueDBmZnpCekNXeU5LMzR2T3JiM1hCRHpN?=
 =?utf-8?B?NUN5QmtwcytRUmwzOGNFdWxGYWVrcnRqcjJtTFhOR3YrMER0am1QMWZpWjQ3?=
 =?utf-8?B?U3JzQnp0Y0lONHhzaFdkNUNWRlduYjlMaWROT0NZZW9laTc2T3h5YW43L2lv?=
 =?utf-8?B?MU5IYzB1d2FUeEtVZVNFbG1NOUczVzc3Wi9ncmhXcTRCNzVNMXFDN0xLSjRx?=
 =?utf-8?B?aGdTelVnbGdUT2IvbXdNbWJnRGFtVytaUU5GVmlmY1BueWJhQXc4eG92TnBk?=
 =?utf-8?B?TnZxOTdlQWZqL29uVXpvdFZPUzdWZjU3a1hQQk5TcHNZTFlQdDI4VTdqNkUy?=
 =?utf-8?B?YTljMjVhdHV0SkxpU3dtYzF5M2pEaTVTS2pBVE5YWXZNUWlFOGU0NmlnTlMr?=
 =?utf-8?B?ZG5nbU52VGZxdmt4WHlLZ2hGbXAzc3pITE1ScVl1Q3VMT1NOZVJoeEZPTCtw?=
 =?utf-8?B?UXZIQmlqNVFza1d3MWFLOEZSZEIyeER5YzYxdGd1QTZ2OWhFQ2JtbkhiUTdn?=
 =?utf-8?B?Tmg5YWYyMTRGZVg4MXZqaEJmem9DdnA2azJBZDYxSjRSR3BaY0xDMENwWG9p?=
 =?utf-8?B?YzNoUzhUR2wwVGFOTkU0cmpXOG93MjhVV3RrOWk3UmNBV3V0YnZQK0JPU0hn?=
 =?utf-8?B?Z0hrMVlvaDFmZUFjVFlIUGgvMkFBOGdIUndJY2h1U0NSQ0twSDBkQjQ5bDk0?=
 =?utf-8?B?dm1Zb1p3ZWg5Ymdyd3E2aGVIRFFWTVh5OWhsWXhLRnUzMU96MlJtSVU0YkVw?=
 =?utf-8?B?OHdEMUIwdjY3bXh0V2NkdXhJdG9qS05YMXhCS0RQRDhORDRjUWFROGJFK3Na?=
 =?utf-8?B?VlE4QysrVWhLdTNnVWljNlgyNm9IY1R3T0pRajcyRzdldHIvM1poWlZ4RWk2?=
 =?utf-8?B?anVBQ1Z4RUZoWEw5Y3lPRGgydWJNanRVOVAycVBpZjh0L2FNNENDcG9DVlQ2?=
 =?utf-8?B?N2VQbmJIYzYvTlpCSUR2ZEFoZ1ZvVE0rWUZURjhyTE5aS3Z5SmJQZDJYNlV3?=
 =?utf-8?B?OTlOeWVIUURRUllGMWVxWWxzWTE5SVNDbFRRVkxzZ2wrUVNwQ2tLbjRPTFlQ?=
 =?utf-8?Q?iIaCu+iR7Hz+zZDYYv7qO8Zoj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 720ce7e1-afca-4a94-28cb-08dd45f8a170
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:32.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2HypZ2La3rd/jyd/VnBWNL5G6MqItVPQ1XYJFMUlP+SIGsyPVgREydT1+9d7j8z4VbGPeDdlYXhomfeVKpqlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6263
X-OriginatorOrg: intel.com



On 2025-02-04 3:43 p.m., Joe Damato wrote:
> On Tue, Feb 04, 2025 at 03:06:19PM -0700, Ahmed Zaki wrote:
>> A common task for most drivers is to remember the user-set CPU affinity
>> to its IRQs. On each netdev reset, the driver should re-assign the
>> user's settings to the IRQs.
>>
>> Add CPU affinity mask to napi_config. To delegate the CPU affinity
>> management to the core, drivers must:
>>   1 - set the new netdev flag "irq_affinity_auto":
>>                                         netif_enable_irq_affinity(netdev)
>>   2 - create the napi with persistent config:
>>                                         netif_napi_add_config()
>>   3 - bind an IRQ to the napi instance: netif_napi_set_irq()
>>
>> the core will then make sure to use re-assign affinity to the napi's
>> IRQ.
>>
>> The default IRQ mask is set to one cpu starting from the closest NUMA.
> 
> Not sure, but maybe the above should be documented somewhere like
> Documentation/networking/napi.rst or similar?
> 
> Maybe that's too nit-picky, though, since the per-NAPI config stuff
> never made it into the docs (I'll propose a patch to fix that).


Yeah, and not all API is there (like netif_napi_set_irq()).

> 
>> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
>> ---
>>   include/linux/netdevice.h | 14 +++++++--
>>   net/core/dev.c            | 62 +++++++++++++++++++++++++++++++--------
>>   2 files changed, 61 insertions(+), 15 deletions(-)
> 
> [...]
>   
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 33e84477c9c2..4cde7ac31e74 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
> 
> [...]
> 
>> @@ -6968,17 +6983,28 @@ void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
>>   {
>>   	int rc;
>>   
>> -	/* Remove existing rmap entries */
>> -	if (napi->dev->rx_cpu_rmap_auto &&
>> +	/* Remove existing resources */
>> +	if ((napi->dev->rx_cpu_rmap_auto || napi->dev->irq_affinity_auto) &&
>>   	    napi->irq != irq && napi->irq > 0)
>>   		irq_set_affinity_notifier(napi->irq, NULL);
>>   
>>   	napi->irq = irq;
>> -	if (irq > 0) {
>> +	if (irq < 0)
>> +		return;
>> +
>> +	if (napi->dev->rx_cpu_rmap_auto) {
>>   		rc = napi_irq_cpu_rmap_add(napi, irq);
>>   		if (rc)
>>   			netdev_warn(napi->dev, "Unable to update ARFS map (%d)\n",
>>   				    rc);
>> +	} else if (napi->config && napi->dev->irq_affinity_auto) {
>> +		napi->notify.notify = netif_napi_irq_notify;
>> +		napi->notify.release = netif_napi_affinity_release;
>> +
>> +		rc = irq_set_affinity_notifier(irq, &napi->notify);
>> +		if (rc)
>> +			netdev_warn(napi->dev, "Unable to set IRQ notifier (%d)\n",
>> +				    rc);
>>   	}
> 
> Should there be a WARN_ON or WARN_ON_ONCE in here somewhere if the
> driver calls netif_napi_set_irq_locked but did not link NAPI config
> with a call to netif_napi_add_config?
> 
> It seems like in that case the driver is buggy and a warning might
> be helpful.
> 

I think that is a good idea, if there is a new version I can add this in 
the second part of the if:


if (WARN_ON_ONCE(!napi->config))
	return;










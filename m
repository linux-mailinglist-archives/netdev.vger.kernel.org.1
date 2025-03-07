Return-Path: <netdev+bounces-173103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488EFA574A1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 23:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E894B189A9A2
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 22:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA38F23C8D9;
	Fri,  7 Mar 2025 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jx6bXTt9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206251A23B0
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385034; cv=fail; b=pZRIPeOPP3IzD6v0a4y2nFBLR8rwxgXa/EAQkQPsMiOnDFfnO6WP0UgVn650F8HuPKHc7X3M5gwrZD7+uinGZL0gV8qAsrmhJ2fBthrPydAP62i7caHiH7b/78yoOpEeE1mzm9QnqJx/qK9a9+1RQxuwbLoqL+q7g3VH7GdUn0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385034; c=relaxed/simple;
	bh=rOMGUiWe68jadybuPB/Ksmq+PuYDe4A2lyuMTCp7w+k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CBn7Y1tvIeDuyp0bxUjvnqqJz2WO865Xy2+RdJAeIpe7Nq7a2oqy8CTf/eyCKOjxJXlYNomKA1CzL3XwNCrObj2ixT1aZfeFfMGReDup1AA+ExmqSF3KWGGcgcNJiMmCdPs68YEq5YpysHcVmOzQkoyY0LwRc2mUnj0alYNsPtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jx6bXTt9; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741385033; x=1772921033;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rOMGUiWe68jadybuPB/Ksmq+PuYDe4A2lyuMTCp7w+k=;
  b=Jx6bXTt97/a8LfrnD5QgHrr4PgC5E8peDrMjnMFB3vHgNc5cc5tmp+V1
   8Qzsg7TyUgZjAD0NucKUMt8BNw/PkVxWLmUt1uF9nL5sd6lGKzt4QB/Q+
   pEe261L5o4IDi7ehVvMYOVwl2WPmLtNh/rTCbFu/cl6bRrjyBBf7mgghb
   TKbDeMNDNakGIA4HtuSeVVRHmIQeVq8uez8NpmcG3gMFKDwe+ZHnxBIqj
   6NsYhBQwYSsijmWmRVIKl7pDAH37YDAAeSlHIVhN4SXn5C58ZMuxJeLC9
   nLEmtoBUFLQ6dAzRa1INgTelMWGRFq5gOwLm7jV6uCx3VxH0xfi3M4pnv
   w==;
X-CSE-ConnectionGUID: xDr5SYJrQdK2umLEQmaX4Q==
X-CSE-MsgGUID: ccL6397XRfKOmkr34b3wJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42302074"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42302074"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:03:52 -0800
X-CSE-ConnectionGUID: KAixIBlCQty6TYOPr57WYQ==
X-CSE-MsgGUID: +Tkp0VjXTFuvyh5UgGOoVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="124452045"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:03:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 14:03:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 14:03:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 14:03:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI71utEFklJ/VGiochVJSShKNAaRvNx5Cc9yy2xHrA5HRkL+WI7Kcz41mtuWkkynuR9UmRfbBg5s3VD2uqwpaTuBTL/6hDNWkvj45p01ZLfL8SOHfraogWHRwGPcKHs24TREPaLZcyHbxXgzz9zSEiZB2KNNmhu0Sp+8JoMFXslFl9likpBX5XJEDWq0rjd3oIuSQbRH+FALO6xRrj05THJXXWMEiER7RpeizMGWUBQg3vGm+8jdYfxhujqDnhU8Ga8dzXscJgWfrl+kAs0PVcDMEouZ9pXa+JVdPPjy3TkiwCRUWyGOQUr1xjrrNT/f2eOwkKtf5zq/sSshK5I/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLCUKuxCn9Qyr3yHA9b17Ml+feVPyRpU5tv8hsvIhD0=;
 b=PX32rEt4gy1I6xZY8c5yxOJBZgNvtS9936JO0dzBlJsBzKy8vdjfhAPcfkiq6w+WeLQUUti2iMlPETht/TQ880+Ke8CrrYTLIa2n+3jXXgrfq9yL72n4XjAHyrf2AGab44rgJn4hqf1nDMFVBQxkUXp2MDDT2n40Juq2NHG1pb+1KxXJO3/17RFMHezrSu8jYNsGEZEDM1r18qYWY57Mz12PegqQjEjDplsP5wAI14AkdYRK92nRzmX2VxbHV2oa49mhseWVkw2DZbKELBnjKKexCJu6cha8BixX8Td/yNF2e+LVpeegPaYG14+5/8DovdIRBKhRKyCBDca/FVNzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH7PR11MB8552.namprd11.prod.outlook.com (2603:10b6:510:2fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 22:03:48 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 22:03:48 +0000
Message-ID: <f71d5cee-cafc-4ee0-89fc-35614eb06f94@intel.com>
Date: Fri, 7 Mar 2025 14:03:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 2/4] igb: Link queues to NAPI instances
To: Kurt Kanzenbach <kurt@linutronix.de>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Gerhard Engleder <gerhard@engleder-embedded.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <20250217-igb_irq-v2-2-4cb502049ac2@linutronix.de>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250217-igb_irq-v2-2-4cb502049ac2@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0070.namprd16.prod.outlook.com
 (2603:10b6:907:1::47) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH7PR11MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: eba57845-7da1-4418-fbbe-08dd5dc3ef9d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVEvaWlFUyt5NkNtK0NMdHo1SE15VVlqNmxtYzIva0VRZGJ4OWt6Znk2S2d0?=
 =?utf-8?B?akFwOHBsRzNWdTAzbnpHdWVvb1YwWTlQMnk0S2FLYktEd1pySXZia2UxVXRx?=
 =?utf-8?B?bjRaazVlbHNjYXpsV2xpZjFRYkMvek5jYUt3dTVueDJHbXJtbDV3ZWprMm5L?=
 =?utf-8?B?SVBlUU5yS29rajJzcjlIRnpXVmpyL2JMYmpNdU9jN1ZKSWZ4WTZVNzV3bGJh?=
 =?utf-8?B?ek9pSThpNDBLV09jK21Ec05ralgxUmZFdiswbHkwQ3VWZ1IvT253eGNzN2tX?=
 =?utf-8?B?VEpFYnorV0FBbDV2RU5LblJrMzhHT3A0a2RkdW9lZEw0TkxpM21ETWYyalZw?=
 =?utf-8?B?bkhlOUlYMjZTWHpXaFRyYlJzblhGbmpVY0NFRDR1Rkg5YVcyNzRjV3ZWUWpO?=
 =?utf-8?B?Qk4xVGl1NGlSL3AycWlOdnVtd1dtZ0o3UlZLT1pjQkJON254YXl2U0wwWVYy?=
 =?utf-8?B?NXlmbFNZcUFQcEdxTFBjK3c2bngwK2xKYklwVkdGYUV2dytJTlRlTmRjWEJl?=
 =?utf-8?B?aHhiZFlUK2xucitYZE4yUStiRk4xaTJydWo0RE9QM25DaFF4VWc1Qzk0QWVC?=
 =?utf-8?B?SUtzNm1KMENOZ0RlM1pTbUQ0Wkt2TjJYSmdWbGYvZWJlcGw2WmhRNjlUNXcx?=
 =?utf-8?B?d3BoTVBkditiTURHRWdrV1NDSmRhbjhPZGwybjZaa2RFUzBlWlRQM05WcU1O?=
 =?utf-8?B?Q1I0VXhqa0wxaUxWZmcwaWpYTS9aa3ViMm1EWGZJTXJCQmx5bW1EVXlYUzJn?=
 =?utf-8?B?S2FDaDNEVmxObStidmlldFFtWVhPbC8rU1FhNW5CcTZmYUxQaVVxQ0NQb21p?=
 =?utf-8?B?cE9WQmMyZndzMk9tZDJnb2lZTmJ4clJPN3BZYkhvd1JRb2Jwek0zSVkxSU5x?=
 =?utf-8?B?YUxFRnZ6TXpickNtMW5lWHQyS09FZFRvbXdmSzdmeXNVVGdYNElNTHc2SG9a?=
 =?utf-8?B?cEROb0hSeFREK0hqT2p5RjZJNFZxaUFaRTNoaDlYcWdKVzhET3JnQTlIMGtT?=
 =?utf-8?B?LzRWZktxc2pUWHJ0SzBnOTd0Vi8vK0NVK1RFdWE1TWVuWjZ5TVAvaWxraFc3?=
 =?utf-8?B?dXhEbGsvWU9ibVZwK24wMmdTS1prOXFYUjVBU1FndGxoZTJjeFBWZjdHaUt1?=
 =?utf-8?B?ekNTVldRWHYxTlZXcFNaOVEvOHZyM3B4YnZvSG1mcjgrMVhCd0FmYWNtSXFv?=
 =?utf-8?B?UCt6UHRrak4yUkU2MzFVM0h0OFZ3L1pHT3pHNXhYS3RJMFZZRERmbjh4S2lV?=
 =?utf-8?B?NzVZNDRNS1lzMUIxYVkyK29XN3dUWWlxUHA0cGJPck5KZS8zOWJVaU1LR1hr?=
 =?utf-8?B?dmd3SDVRQXUxV2FKM2N6WEZjOHVFRjNtWGVobnJaZzQ3bnk0TVQxdmhPeHZ5?=
 =?utf-8?B?MEtQeXNLOHpYbmxpaENUeklmaEdCbHVWSmsrQ1BsOWR4SXRwcGFmTlRhamdF?=
 =?utf-8?B?S0hhZVpFVmw4WWlzVWlEYVA0bk1jSHZ5cEFQaUxoQ09vZGFUWmI5OWh1eDg4?=
 =?utf-8?B?bXNUZTYxS1lwU2xiUThrczBxakRCclAwTldUUndFMllFdWpMY2FsangzeEJs?=
 =?utf-8?B?Y0dYblRZRGZqVWZzNjRFcStsZUI0ODVRZ2lCaHJnSkFkS3FqV1VHWFovb2tS?=
 =?utf-8?B?QWFTNFN5Ni84NFhuWFJ1eUt0bzczYVJGeFZGWUpkNjc3eGN3RFNjaUZvVnA2?=
 =?utf-8?B?UTVzRytvWGdWZG1LMVFMWSthYUtkSjFxT3k0RWVEeGhHTnJ5QTdmQjhFd3Fv?=
 =?utf-8?B?OFhPRCtSYkF6L1lMY3ZhemdpZXZBVkRjZ2dFa0JtLzVET09yTW4vZUVwUFFV?=
 =?utf-8?B?T1VndGJEdUhwYkJmY0daZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJUbllsTTI2OGIyOVhEdGZEWW9mRmhYSTQzNVZLdkxWS3llbFhMZTVZQW03?=
 =?utf-8?B?dWNEbFdDa3ZMTTdBYmxsWXoyajN1d2NuWG5DN2RCK1g1U3A5bnJZc0dQVEJU?=
 =?utf-8?B?UlM0bFE1dk03TWNPMm1jVmFlOVQxMC9iSm9hQnVNU2xINERYanJrZUh2MFVJ?=
 =?utf-8?B?dTREL1ZVckVzS0hjK2FkWFkybjBjOTFld2FpNGhxTmNRS1MzSXBHbHJmb05C?=
 =?utf-8?B?MUVYMmp5SjdTMWxNZ1ZKbmxraytMcXVDNGQ4dnBodFRWTllpc3BOYkx2Nmd4?=
 =?utf-8?B?VzFpQ2tIWW1jSUFOQ0tWMlFjYVlWaitGSzl4dExlK0lkSE56MFdicEVjTWZ3?=
 =?utf-8?B?YWxuZHcwWGFkSWRRZWMvZHdDekZwT001QXpzOWFDVFdFM0tHcnlKZVpZazUx?=
 =?utf-8?B?TDRzM0pzTzRvRk95OTVTMC9neGZ4SVMrUXl0TTFFU3JPejZjcHJ4ZzJGUHVH?=
 =?utf-8?B?ZU5lQ295MkFPSWlnMmkvNWtTWGwzL01NcXovdXA1Z0k4bzFXZDA5ZDRrblll?=
 =?utf-8?B?akVER1JjYkhyTlZjYWpuMVdod1RWWWpHZnNkY29Kemd1UkpDWFRySVh5bXcw?=
 =?utf-8?B?b0RBWFZDbUhIdXFwb2wybmpWMTFrTk9qc2pLanluQjlOVFJRT1RvS2hxaE1Z?=
 =?utf-8?B?R1Z5OURUSFd6L083ZE96VWNWNU9vMVE3cmRKQWdNekpNV1ZCY05HSnMweTNa?=
 =?utf-8?B?MlA2UDc4dHVOYUFaVEkwQ3FvOWhXL3EwNUFoQWpxQTVGSGhEeCtMYWdXZTdm?=
 =?utf-8?B?MHA3NXJ0Q0pSWml1WG9qOFFHRm9ubXM0NDgyOC9pcDBwZWIyQlZaZi9TYnNF?=
 =?utf-8?B?Mnh3UERaMW11bTd4YjFNWjh5YXdmZHMxTGFYaUNENGVNbjlNZDdNcTExVnRN?=
 =?utf-8?B?Y1Z3QTB3VGQ1cm96TXhPMkdjblJFaXp4VVhwU0VqcmdUaVc5Z29aZUJCQjE5?=
 =?utf-8?B?a2lISXFQc3dnRllOY2gwa1g3NnBHcU9JckFMRHE3VVdIVmoyMDU2UDVxZGFj?=
 =?utf-8?B?U0FMRUpjbkdKQkQ1dDZjR2hmaGZXbTVrTDBaa0dNRExUcXlvUnBqUW81cVgz?=
 =?utf-8?B?b2lsN3lncGNDbEgyOHJpWm15bVovV1pTTmI1UW9xN3BvdTUwTDJTa1czVGVD?=
 =?utf-8?B?Yko3TGh5TUNUaEFCMEJNUXNzT1VSdithcUV3aTR4djZ0SDRicWhvZ1FsNkh3?=
 =?utf-8?B?bXY5UVhWbFp1L3RNZy9RREo5SlpnOHBpdEtQYVl4OFYwbmtVckszOUxzQkQv?=
 =?utf-8?B?QlRvOTJOWVp2dTNHczY4Q3Y0aFE2K3RReVhFMnhHS295YUNEZ1R6MjdKSGZM?=
 =?utf-8?B?V1NYQnJpZmlma3oxN0ZXdFdoODBWQi9Ybkt3QXo4MDdleThoVXdxNGF3SUFR?=
 =?utf-8?B?QklnMGQvOTkyOG52Qmo2WWMyYXlSeWZEN1p6VmhjbTArNC8vRThYMWpvdkJr?=
 =?utf-8?B?bExjM2d6Mm1DZmszMFBhcFhTSVZhZGJpajBBQzI5N2J2blowM2dTR1UzbGFp?=
 =?utf-8?B?bVpEOEJ3aFZOYzlSMGxaY1l3a1l1Vnp2QXZhUWZORndCUmYwc3dUR3ZlVEJl?=
 =?utf-8?B?WUhBSTVENXY2cTBFaEg3eXBTRkY0bUVOdHdxOTY2em1PbDBMZXZCbjcwNWUw?=
 =?utf-8?B?R1BjZ0lrZVY2ZEJXbUp0bkRSamJNbmtXUTFtYVhjdnN0b0ZSdC9OVmNuRW5B?=
 =?utf-8?B?TjJPRERlV2ZMNEtDOFdUR1FmWlN6eThtZ05LeVBkMi9Ud0ZVTjBqZThDNzl1?=
 =?utf-8?B?SEt3K1kvN25waVY3dHdWK3RoZ3JUTXhqZTFpNGcvMFNvV2tERUxzQkZKTWNW?=
 =?utf-8?B?WUYwU2lNdGkvNHFqVWhJNW1naG9FVXJFV0lEc0VKZ3pJdFN6WUk4WWRjTTRk?=
 =?utf-8?B?TGRXVVFEUjd4MzJnUzllTHhTUnRyOVdNOVh4eUVyY0Q5ei9sWFpNN0E2dTcy?=
 =?utf-8?B?NDVncitTWWdYdTRzRWRRRkJTZm5TcGVvZHZOY0xmbUhsT3FoYjhQN0JydmpG?=
 =?utf-8?B?bWxsb2xkMEJvTGVtcXluTlo3Ukg3b3FucVBnL05UelJSNk9GZGlUMVo1MUFE?=
 =?utf-8?B?ZUUreTM4ZXJnYllMS3RJRFJ2SzFsZ1p5SEFwS2xHY3ZoK3p2NmpKQlJ1am1y?=
 =?utf-8?B?bVZFNVRWQTU2cmF5Tk5RVFZWNkI2UU8rUTZ4ZkViRGVSc0FQcTdOVG9EOVNF?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eba57845-7da1-4418-fbbe-08dd5dc3ef9d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 22:03:47.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CefBifpxlHCFOJq7eE5KifnH5DKVjP6HqHRn9a+UO5yMyhozLjJq2m1+4dAjj+c5LuaPYE9TnaufwZMmQYQImAzSpgKbR346QX+JSSk7pGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8552
X-OriginatorOrg: intel.com

On 2/17/2025 3:31 AM, Kurt Kanzenbach wrote:

...

> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index 157d43787fa0b55a74714f69e9e7903b695fcf0a..a5ad090dfe94b6afc8194fe39d28cdd51c7067b0 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -45,6 +45,7 @@ static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
>   	synchronize_net();
>   
>   	/* Rx/Tx share the same napi context. */
> +	igb_set_queue_napi(adapter, qid, NULL);
>   	napi_disable(&rx_ring->q_vector->napi);
>   
>   	igb_clean_tx_ring(tx_ring);
> @@ -78,6 +79,7 @@ static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
>   
>   	/* Rx/Tx share the same napi context. */
>   	napi_enable(&rx_ring->q_vector->napi);
> +	igb_set_queue_napi(adapter, qid, &rx_ring->q_vector->napi);
>   }
>   
>   struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,

I believe Joe's fix/changes [1] need to be done here as well?

Thanks,
Tony

[1] 
https://lore.kernel.org/intel-wired-lan/9ddf6293-6cb0-47ea-a0e7-cad7d33c2535@intel.com/T/#m863614df1fb3d1980ad09016b1c9ef4e2f0b074e


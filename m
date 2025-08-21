Return-Path: <netdev+bounces-215548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 472BBB2F2C7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C0E1882502
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C884B2EAB85;
	Thu, 21 Aug 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5o6I7qK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DC2E7F2A
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766003; cv=fail; b=uD4Ulr35ck1eOY7VIfhO2UVexsh8H03+KgEyOzzaJsZxKDZkgg4sPA0+KjZyS9mLdSwSa6jP4VYJa7I+Y4W+F7lP2pc5/mwCLA5HDB6CKprJz2IctlR8fUmtN7iHrAgKNgPHbV4Nv2Qn6+RbmFh8dH1TDqXAkNCM+7DRQYelbuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766003; c=relaxed/simple;
	bh=SDl7lzL9TTMA4a681YfFD+tJraMIVIfRWsk8cK+Ozsw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H0HNHQkRNpA8nvvhKmMFeQc1VvQ6vk+8IWQA46GSsUbyLqw2p6qIKldNDJbMJYGx5Ccu95GX0gNr2GTuA7hQNDdQateG8GptsBsfmdDvPPbUtFrv1pQbjp19mzO3SySBT+AvWyuyBbkxNxuGoTJMjkoSij/O79n1R+1WjUliWrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5o6I7qK; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755766002; x=1787302002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SDl7lzL9TTMA4a681YfFD+tJraMIVIfRWsk8cK+Ozsw=;
  b=H5o6I7qKH0mpKOiNEaVr1Rs5P8vx7kLUMP2LyEIcj/tDPQeR9vEPeaNM
   VozK6gX89tWHNa/jSfrDi/AiTLcjm8uqVPWeayq//6A24vgM7hCXqU4mG
   yKIRlxUEsuwS9xlFyvi+U2ih+hoUfvsTXHpas/Ezmm1UQ6OW9DetN4BQ5
   HnMb82tFbQ4XWhapTfUkRmyNcFlHR8RwF6Bjrt8NDKXNxY5MoiZHIFZ/q
   GOk4IoYj2EhG6IW/4UHPaJ6RbFaqiYzXveka7np3gM0r2BThMCrZSfR9b
   sXPNjOQ8ZZoBiIWIAuWR4DJIhW1S5QTqt8XHV2bv+OqYTOVtlfCewyJ43
   g==;
X-CSE-ConnectionGUID: 8fhRw0W+TWO2RG27tLBbOg==
X-CSE-MsgGUID: FRgy8jEoQC+VAQtXxFhhNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69150562"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69150562"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:46:41 -0700
X-CSE-ConnectionGUID: EmGLvXuHSJ6ijc4wB1pEtQ==
X-CSE-MsgGUID: 4rqPbYxCSAOykVAFleZ68A==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:46:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:46:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 01:46:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.84)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:46:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bc+F9PBKieVPoZqdYqJMTooNrO9Rqo9lRi1b+Z0C+mcbdy4YNISgOeaP9tJd28p4O+8rYv8fNlSUEVb+0SdGWP9+MCm/xTicU+gw1DB3Xk8HkldXNBWbOAsDL7dYfz6XEqWozkdxjvK8q30fiKfyANwRWC3bW79UdZYcHXmy94ToGGKL4L7y8FjOUv9fPEQb8KT4/o4LhWr4KJIsk+tEw1vh7XskTkeOdbk4R0yp/9eBeqJBL/SZQXkBix3E9hfLE0txBQK5UrIgiXIrVBzyQUpIfCYdQasaVo3NgPJ33dPXrRpSi1vySUn9VkX+OOtwL5QiRPkSkD7h9nfSWgcz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lR+yXICMywmKImNJYODpLjOTI6DPPb0eU2Q/Xb2sbY=;
 b=GSPVUv7SjT6ClVw6+wZ7UP1HeAP+FQD4A5TfNPVnY6q9mPquKFHOJ59vhMkVZIjmL6yFO7fi9IkZZF9aStpaboqW/HOPoA9zBz/uTjHHlbrHWXoBm5jp3dXxPVMYbAtXeV1ZjXhsCAaX7306ZUKKhv7Cj9a7AdejOYAfscyCVHlm8FPH+nVL5ssMuyjgSDuCplJcfciF9gFhDDRHzGI4wSYj0LIxpODteyfgr9OpcjSk9v6NRMpagW7hFjM6WtnL9p0Y0R2kxPDZ37gLYksiAdE+sxEW6BO7cWb9FWeJ+Q9KwLbF7ZL1b3ZXuhJELDgUdHKFzKV+EsRFIONcY9Ko/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN0PR11MB6279.namprd11.prod.outlook.com (2603:10b6:208:3c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 08:46:39 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 08:46:39 +0000
Message-ID: <c180694a-7841-4f72-9810-f5e6c959c33e@intel.com>
Date: Thu, 21 Aug 2025 10:46:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/5] ice: fix possible leak in ice_plug_aux_dev()
 error path
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Jerome Brunet <jbrunet@baylibre.com>, "Emil
 Tantilov" <emil.s.tantilov@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<david.m.ertman@intel.com>, <tatyana.e.nikolova@intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
References: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
 <20250819222000.3504873-3-anthony.l.nguyen@intel.com>
 <20250820184514.0cf9cbb5@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250820184514.0cf9cbb5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0316.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::21) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN0PR11MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: c417f61c-2c36-4413-138d-08dde08f3e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NndsaVprWlJqZDVzU0FZbkVzSjFDV1hMSlNDczhidVIvQUtkU0E0K2VBM05u?=
 =?utf-8?B?QWJTUE9JNk1KUGk4Z3phelozTjBsd09tUWRJUnR4WmRKdGl0Vkh2TUpQOHdt?=
 =?utf-8?B?QWt1UFpQSE55eUpRYnpKbWJ3VE9kU3R6cW9wUDJaNnd4Wk4zRXVDVSt3ZG11?=
 =?utf-8?B?OW56ZFlQSW5tR3BDTjYwc2J5ZHNQTkwwRFdjSytIM0lsenFhY3ZETGRvYnlh?=
 =?utf-8?B?cmswSmhLRGtOUUNmdlNDaW1Mc2lzZHM1TEVtdmlTR0pxMHdaRlBiZ1cvS05r?=
 =?utf-8?B?TE1vUEN0UEE0T3hDanJoTXlXUFpJb2lYc0FQRnlsODc2ZnRuazNaR1hYQ29W?=
 =?utf-8?B?K1dNaE5mQWZJWExMa0J4Ukluc2xaaGNEeGo4dktoZ1BOS09sN1lZWjZYRURH?=
 =?utf-8?B?UXBzYVdVYzhoTFh3ZWNhTnJhMFBZWThyMjJiS0pab1lPcVdUdklvLy83a3h4?=
 =?utf-8?B?UXp2OXJCZ0IyTmJGcXBLQzNXWmJKZFdHRmJQbzJrY1FSRTl0QjAwTDRjVGNL?=
 =?utf-8?B?NXRSL3lPZGgrT3FKMmlMQS9wNmFUNGV3QXN6T25DZ3FNY1JCeHFNb0E2eGpv?=
 =?utf-8?B?MzFlZUR4QTJRd1F2Qlh2OEtEU2xGZGhsdm80eENuL3NjYXZrUmdOdGdOSk83?=
 =?utf-8?B?NHVySlA0K3p5RlJiRUNzb1cwQ3drT2luOG9icmY2a1FUcWwrUzIwb1ZXekNI?=
 =?utf-8?B?WlNkbGpIZVVUWGpGS0J0QzR0MlNMNzl4RW9JWjJ1RXBXc2VHYWp4T1VPb0hL?=
 =?utf-8?B?RzJodnhWUVVYU0tMeW1xcGd5RE5KTGZmQU5zVndsSi9LS3NONENNMGIzSnJX?=
 =?utf-8?B?cE1mUGF6M0drT0FmWjAzWi9jRVJPVTBUYjd4SWxFazJjdUo3NjRvOENTdGNp?=
 =?utf-8?B?aUNWV3NPUTFKQyt3bXUvbGltTTJXTTFzK1owMmVlMUtLL24wWE9jS09OSzNo?=
 =?utf-8?B?ZjZBNldmTDBuTWxOc1p1WFlLRHViYWRDM1VGNG1Xd3hsc2xUNTJUTERJOFlp?=
 =?utf-8?B?OUVSWDAvVnQ3VHNKSTI1MU9EZWJVRWdkcC9JL1RVZUxxT2R6azhPQUpadURO?=
 =?utf-8?B?U0J3UzIxMWZPeWdoanpXL0drYUU3SjlYeEVua0dVVWQvT0ZSM2RMcDY1ajNw?=
 =?utf-8?B?NFJWeFUxT2hrTVEwOEJpUitDTzdmM1hYS3dmR3A2NE5VbVJFT0d2cFNET1lS?=
 =?utf-8?B?R0Q1ekhWVFdzQ0xoZmFxVjFqL0prc0lzUWNrem1RUU5HYmFhbUwwWGI4Ykwv?=
 =?utf-8?B?SzZBT3ZsMnFmOGdIT0QxMDNvVjZiaTJjQ3pmSXRTZHp5cjVFM3VpMm1BaHBM?=
 =?utf-8?B?Rm9sRXpqcmhkZG1Xay9HK1pvb2Y5M1d6Ujk2MlBiWUVEZmVRQmxSY3dJWVhX?=
 =?utf-8?B?aG50dHVwVVcxU3NsYzFLQ0JScWR2aWw0OXp3NnJEejlKaTRLWkpKSjhGYnYr?=
 =?utf-8?B?T202VUdrTEppZzRTdERMUkE4cEJzQjYvdGhBV3FoSGhRTWdxMXNML3l0N0th?=
 =?utf-8?B?dE4vYWI3V2liZ1Y3RElTSVV4QU5NZHhMYjh1RU01aVlUc0xrdlZpaGV2RXJ1?=
 =?utf-8?B?N1ZyQ3pIclhxVUN4dU9TOGJJa2gxMXhmdWoxTldmMm1UVUJWQXJzOWdicStI?=
 =?utf-8?B?WTR0Q21rVE5SVzdpWGFjU05vbnJ5M1pwSVpzVENkbWhQVGNxUm1ud3Ntd2Z0?=
 =?utf-8?B?V0xaWUtWK0R4ZzNDU1J1R3gzTVgwa3FLajhmZUtuZWlpcWNwRnRzdDdKK0lV?=
 =?utf-8?B?VDk3OWhIcVJxSXF1VlVGNyt5NnhkeWhBZFJYckw5Uzh5alo5Z0FZZFg0aGRU?=
 =?utf-8?B?aTFmVWRjelQwRVYxdzd0d0tOQzhOOVA5UnNMZHJ4SCtnRjFYU1gxWThQK0Nj?=
 =?utf-8?B?cjBNUVl6TkhtNGp5R1FYS1haUWcrcDl6RGxCeDFQdnBxVUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M054ajJXZGtZK2twcGJseitRWDJGT3N4NWNpeHdxV3hmN25XSFhHaCt5aDkw?=
 =?utf-8?B?am01SitqdUFud3dpQUZuazltTVZBYTVzWTRKalI5WE1kL04zdUp3c011TEtM?=
 =?utf-8?B?VldIemxrTEVwQ2pIZnk3eXRCc2JIelQ1UDBZME9VRUh1N2VzZWlGY3Y5QWU0?=
 =?utf-8?B?UlVqWFlERzA4WUFya29UVXJ1M202SC96aWM2RHRZaEh5cExGRzZwRWEvQkhZ?=
 =?utf-8?B?SmFhZ0c3WmJSV1diWHp0R0xhUERPM0w3djVYbkhpYUFjWEpNb09EL2l6TmRr?=
 =?utf-8?B?ZHdCdWdqYmhCRGdldk5iZ3FZUER4VzR0RGtTbXlLaHE1ZDFEWE9kSWpvSWFv?=
 =?utf-8?B?eittS0NlWnJBRUR6MWdCOU9xK0hBZnJ4dHpGSWhtU245czgrWTFoaFlzYnlH?=
 =?utf-8?B?VlZRSUtjV1hiUWlhWkVxN3JyYW16cVdmWlBxTlNnTFZySXBtdlZMVVluUGRz?=
 =?utf-8?B?NVJPeXdtWE1GQStLbko2ZkNMcGZBWUV2YVQ1eGFZT281U1A1NDVDeXVUZkxM?=
 =?utf-8?B?Tyt6WjllbHlQTnRaWDdpWUxkTS9lM09vVHJoWkhDMzlCd3lEOFBLQ0diZDVm?=
 =?utf-8?B?Sjh1eDBZeUJTVVJnYlVEQVlxdVFCNVpMblVaVXprZkJubnkrN1hLakpvc1Nj?=
 =?utf-8?B?YnJFdUwyOTRRYmhyNU50RFV3NmE4RHFCeEdnV1B0ckM5eCtqaXRVUnZqQ1pB?=
 =?utf-8?B?TS9rODRHRFBsMDZKa1gwSGJ0d2hRMnhQaE5vazIrUElLcGwzd25QclhzeXRE?=
 =?utf-8?B?MHlQdW42Rmt6dnJycURGTlYvVmd2bUtUaDByZUtrNWpJM3ZWSTlTZ0VFSG9l?=
 =?utf-8?B?R0ZPV2N4eUk4Y3h2dHJZN29RMWVjcWNSdFl6bTF0UUpKQ0I1SlBBOVU4dXhw?=
 =?utf-8?B?UGptT0VqS2pVTXJsOW1XeHdnODZPTTgrb0JLMVI4dHI3TmNTM0dHWWVGdnJu?=
 =?utf-8?B?d3BKMFFjdjNHSi81bzg0Y20yMko3UmEwNHhZMnNQaVRUTU5HNjJwRTVFVmJ5?=
 =?utf-8?B?bjAxdnh6YVkzaCt5ZHE1MFFQRFFOT3VzMDh6cWFkYnQ2MVp5SkphdzdKVFp4?=
 =?utf-8?B?bXUzd25uRU9NTkx4cUdVaEx1NGJjMmxscHFDcWV5QUNzVUNZUWFmKzk1SjVR?=
 =?utf-8?B?eFRFMlQ2WFRuSTVWVjNOditXbHJqblZNQmFRN21BdDM2ZW1aWXRicUN4ekV0?=
 =?utf-8?B?ZFZlZ3FsZXFUZUhWejAzc3dFZ3BzSjJ6Z2NPZ0daWlZrK2VFUTRpRi9qNG42?=
 =?utf-8?B?VElqOWxPUmdLZVRQUlZXTk9hYThDdTQzWVFPdFlPaENtQXNNVHBVQXlmWUg3?=
 =?utf-8?B?amZyQUZDb2JqcXRzeFc5eTF6cnUySHdmV0xKVlNXQ3M4ZmtlN2kzWS8yTzZu?=
 =?utf-8?B?VE5YZlMxTHY4Vi9qQjhtbHp0Y2dnTnJacVZpT2tkS0MzdFZyVEhicFRGYTV1?=
 =?utf-8?B?QkN6cXFlKzl3SERSbG92UkVDWGNveENxS3QxcHlpSnFpM2R2TmNJV0FTQkly?=
 =?utf-8?B?REJ0WTRnZDlMVW5PbnJZQTUrZWM3cHFkdWNUQkhSSVhkTjZRczZpWFNiVUJk?=
 =?utf-8?B?RGFQb0VNUVdvbGJaVGk5bGwvbHVEQ05mN2VtdW5ScEo3TzZUSG44QVltNlcy?=
 =?utf-8?B?bDR0SlJMSSszQksrM2UzUnJCN2tsSTBYVVJzK2hGbjNJS3lJUitidnBBRDEy?=
 =?utf-8?B?SFhRV0dicDJUYWU0TWdObGhQYnhEdzlyYVlOcUN2c3NyemErU3hIUnIyNnQ5?=
 =?utf-8?B?Q0IrM0Y0aG9QM2xnS3NnTEFJenFicGpPQTJwc21oNUYvZDh2NVRrZzlIS21P?=
 =?utf-8?B?dzBWVGRUeGd3Z0xJSHlaSHZ6citGd09SbE1jeXRjV3ZCN0trV2gxd1loY0hO?=
 =?utf-8?B?TWtNNGdKWEUzNW85d1lSR3dZaXB3dXlzNS8xVnlGT3NsY0hNV1dKcS93c1Zw?=
 =?utf-8?B?U3I5NFp2V0ZCaCt5YkhsS3A0VlBvY0pqblgyN3gwa1VkUEpHaEJMbHdjVlN1?=
 =?utf-8?B?aE1lbktZM2w0S0s3dnczZ1ZjeGtVOGZWUytjZm5XalF4VGx5SCtQajl3M1Vs?=
 =?utf-8?B?QXJzaktyU0dYVHlWdFpPUDVPZWQ5dzkrVHRicDdUdlJCdVFWa2NBTnZGU0Zj?=
 =?utf-8?B?TktsY0JNcTIvY1kzM0JOV1d5Q0ZhYnhuSmZyS0JtL0lIbjBzbTgxWFBQWFZ3?=
 =?utf-8?Q?07vW3s21EKQe9Hpy5LLZJm0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c417f61c-2c36-4413-138d-08dde08f3e7e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:46:39.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scE7g2NX4fIfZUReMuD/f6nKKpGUAU8H8T0+CIkwhrkUWQm+BEvQgqnlpDgn3pw91jPJ1BtOmcTa+lYKKHbt1drWw+MmMuVE50Ns7DP2i6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6279
X-OriginatorOrg: intel.com

On 8/21/25 03:45, Jakub Kicinski wrote:
> On Tue, 19 Aug 2025 15:19:56 -0700 Tony Nguyen wrote:
>>   	ret = auxiliary_device_init(adev);
>> -	if (ret) {
>> -		kfree(iadev);
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		goto free_iadev;
>>   
>>   	ret = auxiliary_device_add(adev);
>> -	if (ret) {
>> -		auxiliary_device_uninit(adev);
>> -		return ret;
> 
> I think the code is correct as is. Once auxiliary_device_init()
> returns the device is refcounted, auxiliary_device_uninit()
> will call release, which is ice_adev_release(), which in turn
> frees iadev.

you are right

It's nice, that a recent wrapper [1] added notes that exact bit of
wisdom as comment (what only proves such wrapper is a great abstraction,
thanks @Jerome Brunet):

drivers/base/auxiliary.c:
444│         ret = __auxiliary_device_add(auxdev, modname);
445│         if (ret) {
446│                 /*
447│                  * It may look odd but auxdev should not be freed here.
448│                  * auxiliary_device_uninit() calls device_put() 
which call
449│                  * the device release function, freeing auxdev.
450│                  */
451│                 auxiliary_device_uninit(auxdev);
452│                 return NULL;
453│         }

[1] eaa0d30216c1 ("driver core: auxiliary bus: add device creation helpers")

> 
>> -	}
>> +	if (ret)
>> +		goto aux_dev_uninit;
>>   
>>   	mutex_lock(&pf->adev_mutex);
>>   	cdev->adev = adev;
>> @@ -339,6 +335,13 @@ int ice_plug_aux_dev(struct ice_pf *pf)
>>   	set_bit(ICE_FLAG_AUX_DEV_CREATED, pf->flags);
>>   
>>   	return 0;
>> +
>> +aux_dev_uninit:
>> +	auxiliary_device_uninit(adev);
>> +free_iadev:
>> +	kfree(iadev);
>> +
>> +	return ret;



Return-Path: <netdev+bounces-174381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC960A5E6BD
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E1A7A83AC
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79AA1EEA3C;
	Wed, 12 Mar 2025 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nl3Ezvqd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6281ADC98;
	Wed, 12 Mar 2025 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815824; cv=fail; b=ZZIZqSy9iiPzQAUg8a4at0i42XMoHHxordr93sL+3wSKyvUmlB4hnF/cO66+Jsn7H3kfKTDXunVm+ASRCqlasOX+BAFlR46qO3OzxyXnnho7/aAgBOB1IRRPjwEBEW+OATA1lig9KXtGrYxrrRZcZA425L9Km0UqAiAxTkC1Prw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815824; c=relaxed/simple;
	bh=JkfLSx7KowLgmOAdSjiB7qhR86/7LYL/5cuaHYiiEV4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dqjgljP1JM3+CqP21fOhoNDozT7Z/VrtnAdlJPAA6e3+LmCYB+zuQBcq9enHzeMbcUddPOtiOE3SfLMdLHDUGhQy6lgzV1BHb6805Py/YaLwS7IYauRhGxMTCC/8NEgnBhPnND+WH/oPfX6S4YXd9A+c1yLF+aS5glTVqrN7z4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nl3Ezvqd; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741815821; x=1773351821;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JkfLSx7KowLgmOAdSjiB7qhR86/7LYL/5cuaHYiiEV4=;
  b=Nl3EzvqdWFqHxCDzrxMSBdHvd6Hl7jMutx5FFKNQYlTOutsxxadWCe8Z
   eeql18EdcXoyw9+lA1svlKuTke8nRzd2arbdcg1wwprGvpbiR+NEhbAuW
   oHyIeJRG8hQZHlFq3bYhhNHasfL8C3bHAO92dtlYXrEE0UA1/7kIyvQYS
   3t/PIMg/sdkjOBf7n/xDFa6+wAsk67J2JG2kSU5WFtW3Rcrn2n2YKndp+
   ejFlnDTxm2QB+pCR/QSPAiErbCnk/yVOuJodz41GfWfn6cDH+zOuwsn0k
   0i/s5o5b0riLXO6B4g1AD41609ho0L1Y+eNdZJkdkVOFEemYuqx89OypJ
   w==;
X-CSE-ConnectionGUID: aNEPKQycSl6V5B+Oe4+oWQ==
X-CSE-MsgGUID: 3OXHCMIiSmKfGCZHUDTt/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42776888"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42776888"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 14:43:40 -0700
X-CSE-ConnectionGUID: 2xlyftrWQP6nIEbjjtC+8Q==
X-CSE-MsgGUID: JgrOnJjmTGWKyMVIhYGMKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121257556"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 14:43:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 14:43:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 14:43:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 14:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCj1ODF6nwHSdWX+R8duzxMyvyGsfeR5eWSInL51vGIZFr1y7f0Eaq5iU5BGff2Pv+XYOlb3WXB16H/23HRin1NinsIKYKrImU8awwqZmpQgJ+s/El4RuaxDZwPCgoOZ+zYdidDpD+Wd9en9PPVg1FM89cLGRxQao+nt+mivZxvIASWQMSRFoM9ujG/bTWbvS2Kam/tJPPO8NAkDayGUTmBJ+ItQgIw6DNVs9LcwNrB5VsUVxVNqz4EY7e/5KDl5H3cHTFuTA86ZK0od1yP4jzmYf6VQkZJ5HGmtRI6yrFMXJMixWfjFSPxFV627+NinYufiAbXBXpNzgcc8DOxvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AptGHkP4g4J2qdS4OiWt/bN8EvSi9sPg9y5SG+sG1L4=;
 b=Sn4B+zJYzDWkVzej/wu30VhDFv40e7T4b2d2t5xm4G9Yefy7DTKMp6MTcXnf8f0uuwtzCmYDpWFJ8g6P3vicb3paAvsUtY8l9y68Rmc5x4a+V78r6GcGLdTbbpq5Ugw9o3K6w6Enfh9GcinW9ztJDUQhgvdYVcwvUOM/QuPDZDD8uySLCrcKgkdSUOCxFwIm+tyZluM2O6h6GNDnlfkw6tTfKE4WZl6FUsvwXXUiBOfmcJcNhQq4tine27C1SKRrAatrOvz2OIu7rGLY8MpqFtwWbRc1CUlT3hCmTrb7FkLC1P3h4ukFb187G8+8uJuWm4FM57VGnUaQAye7amFU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA2PR11MB4778.namprd11.prod.outlook.com (2603:10b6:806:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 21:43:38 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 21:43:38 +0000
Message-ID: <fe021b67-94f6-43e4-9130-7b9a58919b40@intel.com>
Date: Wed, 12 Mar 2025 14:43:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] igc: enable HW VLAN insertion/stripping by default
To: Rui Salvaterra <rsalvaterra@gmail.com>, Simon Horman <horms@kernel.org>
CC: <muhammad.husaini.zulkifli@intel.com>, <przemyslaw.kitszel@intel.com>,
	<edumazet@google.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250307110339.13788-1-rsalvaterra@gmail.com>
 <20250311135236.GO4159220@kernel.org>
 <CALjTZvaknxOK4SmyC3_rN5eaCPqd7uvx52ODmDuAp=OeG0wxAA@mail.gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CALjTZvaknxOK4SmyC3_rN5eaCPqd7uvx52ODmDuAp=OeG0wxAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:907:1::33) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA2PR11MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: 39dd0672-9fcd-4bb3-05c8-08dd61aef27e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTJuVVlEUXFNS3ZEQ2NIM3VoRE1aODREZkJ2MlFER2daTFBqZmo5VFRJWW9r?=
 =?utf-8?B?eU54SEVQVGs4aGsrRXhEcjNHckxIamdKem9ZTVBmSDBVT2h3UE9rL3B0RGNO?=
 =?utf-8?B?RmhQUnBQQU5XY0NaMkNIMGVJaHljYUxGeUFKU1BrWkxKU3lSRVBJYXZzMnhp?=
 =?utf-8?B?eE1HTXZEZ3JYYnAzL0lSVXRlMGRZQWpvSHdnV2JHUGJabFJreG9FbWwwdHJy?=
 =?utf-8?B?dnR2alcrb1RKcFRvc3M3WTRZNVVNNXZlakZtcC9IUXhyVnI0S3VkS0lxYk95?=
 =?utf-8?B?RjZSc3VzNncvdVNSZVFyRS9Mc0hyM2hpTFFSMlpsTk1KVm1XaUpqcXgxWTdn?=
 =?utf-8?B?UlR0eXR3NWZ1M1BDU3BSU0JBczRtaHh0MmdvZlJaZ1pmNGkvWmVVZEdteDBJ?=
 =?utf-8?B?NGRLYzM5Y1V5aXYvWFhTMkJaTDJYckEwemlEckU0clFHakszZzhSTWR6MUJ4?=
 =?utf-8?B?NTBta2ZrV0J1eVZnaDZMM0R1cnAvRnVMSmZQU3lZNkROQW1saHBjR0dPa1Vq?=
 =?utf-8?B?MzNNWHhYQkxsaThpSFcrcGdubDZkeFF0TGVtaW5WVUpyR2Z6blVDZko0dmJL?=
 =?utf-8?B?Z0JabTBZN1ExajRueTZsbHZNZ1AraTJnMjBxQ1FIR1k5dWw4UzZSeG9aVG94?=
 =?utf-8?B?RlMrNGNHeklkTmNXTStqQ2F1UUppa2tGN0dUaEp3RjlLeHFDSCtRVmI0YzZQ?=
 =?utf-8?B?NU9odVlyb01nRm4xR09QYmhzOXlKNVpRWDgweWpwUisyNGM5SGpWYTBGci9u?=
 =?utf-8?B?VUhDcG90M29KVk5Ud0RQVjZxWTBSazRjT1cwS3Y5bldKbWRjcFBXTy93dTdv?=
 =?utf-8?B?VktwNjdNd0h5Y0I2blJscXk1VVFvazJYb3QzQ1lGajBLWmx6WjBIRUlBMm1m?=
 =?utf-8?B?M2J2QzdsNnpGOFN4VTNDaDd0enJsQnBiaCtOWDJYUU5TaklvaG40SXM2NHBr?=
 =?utf-8?B?Ukg4WkZNWlhxZ05ueS9ZRXRGbFdweHJ4c0FyZHRKTnVzTzE4U2xMek1icmtv?=
 =?utf-8?B?aFduZmpHclVnQjVuY3hOK0FnQXpJcHZpT0FmOVlPOXoxWnhKajhJbnd4eC9W?=
 =?utf-8?B?RlR3QlFqNnViK1FYalkycG14Sm9qMzNiTWUxTGlqaDhxZUczRGt5SU9YVG5s?=
 =?utf-8?B?Q2dYdlFYY3FaSTM4ZVM2NUpHcXAvL0ZuTXB4bWpKaC9zSHJabFQxNFF0a1lk?=
 =?utf-8?B?NEVkTVdnMmN5cDdVYk5ua25wRWtWYzgzWjErdWxvVHVnZmF6MVBENGxxS0w0?=
 =?utf-8?B?Q01oYjJCQzlpMU9OSFh0bDBhOHB1RENWVGl1a1lSOTZGVElXSXZMVXkwSGRp?=
 =?utf-8?B?dU9ka1h2ZHFURGJEejlLR3RyQk9HUldUS3lZb0U4d2R0eGJEbFY4U2I5WS8v?=
 =?utf-8?B?NURORUtNTEhkYXhJK0plTUw4OTk4WDVuWTNVNDRLdlpPZWQ0WCs0WmRtTTlV?=
 =?utf-8?B?UWFEL1JTY3hmTlhnRUhBU2dBMlVna2Z3SFI3TFppaDc5UDc0WDZyRCs1a3cz?=
 =?utf-8?B?N2pHMDN1OWxEM0JONGVQUktGTERkMWNmK05PVW1XR3ZRd1NmTW5nOG83UHNw?=
 =?utf-8?B?M1ZxdVhHclJCNXlRY1o3ejFOY3lDbjdxREN2TXdsaSt5Q3ZwYUxKU0NYNUFJ?=
 =?utf-8?B?QVZnd3E2ejVLY0l3bzM2TmpvMWNjSzZRMFNudTNaQU0wdmdHUnN6bzlNVkVt?=
 =?utf-8?B?NFowU2ZtbzQ4d0x4VHlCNHEydmE1bDZHRVJMbllXTUdRSUs5RHVUaVVBaWxt?=
 =?utf-8?B?dXBCR2JXUWxDT1ZiTEFocXo0UkptZkxGZ3gvTUZ0Z2RLWkxoMFFwNnlNSzhm?=
 =?utf-8?B?cXNlRGpJK2JSbFR3Vzk2S285ekoxdzNkT2ZnWjFNV1Jkd0xFeFpyb2cwTUJh?=
 =?utf-8?Q?Io3YP2Ylz0qQ6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDAydlJWOXhsaWlwd0RFTWIzd20rSGhzbmYwaGJRRlNHdCt0OG5BUm54clVL?=
 =?utf-8?B?M2VJM05VbVVEZm1DYkhTWnBUOWJCeFhHdmRVK2pmaFdrNzVnWEpHekg0V3Yr?=
 =?utf-8?B?NGFYMXdObnlTR2cwZFlrN3ZoRW0rKzVZVEszWUxoVmMreDVZd1ZyLy9NdHl0?=
 =?utf-8?B?aUJOODUzMmw3b2ZXbEFGbWZId0FidWlIbTVvbE8yZyt1cTBua0MvRlk4Rlhk?=
 =?utf-8?B?eW1vUGVzSU0xM3VibDZBdXVIcVpxYVcrL2JwWkE1UnE3Rmd1ZWxzK052T21r?=
 =?utf-8?B?bXJPSTkrSnV3ZjJmbTNMcmljcTh4L3RmTVEzRHlPTlcrZm1zUmUrMnQ4YUpR?=
 =?utf-8?B?VFpadUdiN1FTd21QalFUUGV6ekRuWkRIcWY4OXo3bUI1dTU5RlcyYjBOSW9p?=
 =?utf-8?B?eldMNXhHbmxLRzg0ZmFNaW5OK3VGNklYdXB2L24ramR6Ly9EYklCbTFvS0tw?=
 =?utf-8?B?aVQ3MkFqV0g3c2JGY3F3WFJpczF5eEkzZFlGd3BOOUZ1OFVOMUtsbGlVVnpx?=
 =?utf-8?B?RmVCZU9DSTgwdU1CbFVQRW5aZzFLSEpneUVUclhHNUVkWkJEd3NHdU1US09q?=
 =?utf-8?B?c1MvQWVubXNTdFppV2hYeWhLMnNjdk1SREhLd3R4czFMbENJbVZ5MzJLU005?=
 =?utf-8?B?MjltYmYyNzNxV3ZZb09IWENoQVozcFZOZ240RWROOVpwNmM2azd5bE96aDFl?=
 =?utf-8?B?M055a2lpODFpOFdTQnFUVWNibldueE5CVUg4Myt4NlZId3RmTEVqWklDVFln?=
 =?utf-8?B?RC9KOCs3QnoxcWExSmt1ejZ3UmJ2YlR0WlFUZ1E0ZG01MlpOdTRlSThDZnh0?=
 =?utf-8?B?ZWV2WW1GTm1jM0d5VFlSQnMxbjlOaksvMk5VcVB5d0t1UHdyRXgyVHdRdnJL?=
 =?utf-8?B?a01idFdEMzFta1pUYVI1OHJrWXUzSUdaMHRxZG1lTGIrTHFRSGhUNGRud2Vi?=
 =?utf-8?B?YllBcm5vNmE5TmhlbkNFNnFWUmRydnYyaGVzYzA4MnFGbkZJL0J5NGRGcmZo?=
 =?utf-8?B?cG9KWkUwb3Q4Uk9UK2x1ZE50VDFyS2N5NUVDaFdvSktyb2tEMDJETUdYdmFY?=
 =?utf-8?B?WVA5QXFIaFd1bk56eGkydWtIcEdDVXZzQXQ2RVgxRllxSkpFa1J0NERrSGl4?=
 =?utf-8?B?MUJyVUs1YlUxYmMyWWJkclBSM29xV2JKRlRjU25vMFhYNnU1K1BHcWs5emJV?=
 =?utf-8?B?bEl6bTd6NmVjaEdQUEFYeEJLQkJ5aHByZlJkNFZPTlh2azF2bDMvckJ6aFlB?=
 =?utf-8?B?bXJMVHBKcHNtbnUreVlXUkdyNXc2QmRpRW5pelZ2aDVZaDQ3dzFOTVkrQldt?=
 =?utf-8?B?dUZ0WnZPcEpuRXEwNXJNdzcrMG9PaWpwWllWZ3pvZVBNNVFlaEFyQW1rSEVZ?=
 =?utf-8?B?Q3FSSk1aU05IbE9FVkNmNDd1QVZwUVNWUDhWb1g5eldnRm5vZkNKMDBkN21N?=
 =?utf-8?B?NEdrNy9JUHF4TmJBeUdENnhSemd1TGNMT09VRU5NV09jZnk3dlNoTnEweFNt?=
 =?utf-8?B?K2cwNnc2SnBUTHpsc3BmMU9vb3lIMzY2UjhiZjdDQzB6VkVhSGZ6dURmNmtC?=
 =?utf-8?B?L3NBQnNiRmc1MC9vU3lUdXpXeTk2SCtiZnRvK29BS0RKOVB3UEdmTkhhQll3?=
 =?utf-8?B?OTZsUDF5ZTVPM1FwUWVFVitZQjlnM0I1dU1UZm8vTm8vRGNXSnRFaG1vbnhT?=
 =?utf-8?B?VlBsMkVZakNjaWhTRXJYWWdZMFc2c3JjN0kzNk9GQXVmemsxK0xkWXlPa1o4?=
 =?utf-8?B?RVJVQUJvVUVUblJEbUcxMnpvS1oxTGowSFpKNDdkQWtxQ2czQ3FySHM5Z3NV?=
 =?utf-8?B?YUhRS0VNZGtVcmhLLzkwNUdZREFteHgvM1NCY1Vqa2dkVmxBZnJFdGE5YXRD?=
 =?utf-8?B?RnJCNlloVUVOazIwdXpBWEI4M29oSTIwNkpQUnYvZDNjTkxRY096ZkMvMG5w?=
 =?utf-8?B?cUdsNVJDL2hQUlpTd2t2ZThjeDJGTVdtWG5DaHRwZ2Nhbm9CY1VSM1hrbDh1?=
 =?utf-8?B?TCtibmpBcEVsQys4Vk5KY1FzemtTMFFYcDN3Q3lVZVp0TEt0TkNzWnBXeXJi?=
 =?utf-8?B?WXRveDFGejd0bUVHV3JKOGFzQkZYY3pqejRzdXpZK0xreU4xOEUzRERxNHZ1?=
 =?utf-8?B?M3ZSSGhNRkg4QVFRV21IZlBsaGZFbkl5YjdyUEZDTlJJVmU2OHZtNXRzQlJW?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dd0672-9fcd-4bb3-05c8-08dd61aef27e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 21:43:37.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe/hWhDeGBXUXMSKDRwxmalPjbuZnNQ6sGhqa2MjfCLtnBDyIlMiSYjxOMN8VHRQBoaosMURFFxMFcoKXi4W7vjdw+K5sWKQ1oMt6vAseMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4778
X-OriginatorOrg: intel.com



On 3/11/2025 6:59 AM, Rui Salvaterra wrote:
> Hi, Simon,
> 
> On Tue, 11 Mar 2025 at 13:52, Simon Horman <horms@kernel.org> wrote:
>>
>> Having looked over this I am also curious to know the answer to that question.
>> This does seem to be the default for other Intel drivers (at least).

Unfortunately, I'm unable check with the original author or those 
involved at the time. From asking around it sounds like there may have 
been some initial issues when implementing this; my theory is this was 
off by default so that it would minimize the affects if additional 
issues were discovered.

I see that you missed Intel Wired LAN (intel-wired-lan@lists.osuosl.org) 
on the patch. Could you resend with the list included? Also, if you 
could make it 'PATCH iwl-next' to target the Intel -next tree as that 
seems the appropriate tree.

Thanks,
Tony

> Well, r8169 also enables it, and RealTek controllers are used everywhere. :)
> 
> Kind regards,
> Rui Salvaterra



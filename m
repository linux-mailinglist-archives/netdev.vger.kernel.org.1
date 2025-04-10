Return-Path: <netdev+bounces-181429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5E7A84F7E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DF39C2F4D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E3720E037;
	Thu, 10 Apr 2025 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZoAceKo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46F20C48A
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322695; cv=fail; b=ebww3LxoFpJJw6U8psMX6vb4trh8MxPzbcWSOTf007lxDFtWhAH95N9LcheI8uDtWrGPRLEbo1KJGfTzKmfHqedFwlX7vKJrLqXpWjoNuvt6C+dG+5+Ib1eXyz28A/DBpIwebtjX1surJJB4kMKvJgUr/TaIedZeP04BW1lfigg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322695; c=relaxed/simple;
	bh=1ot8JDh2wntJ1EXqPEHsc97DCQHfBdY95AJR7k+zOHk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GGHx2OKWCyprYfyU8PDCyxWVrDF+Z2bx/ZOezdmUnoYWsdwkaV/CFFISS3v5ngtpl9fzUFyCJTTF3G2qyeC0j4rSm5KDD92WImo63OBGWIiN9UJBVDZE+Oxu3tkiAzLWWQGieqWPflThnQnzbIxzqEG2bcJhAqv4lXZctWDBKpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZoAceKo; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744322693; x=1775858693;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ot8JDh2wntJ1EXqPEHsc97DCQHfBdY95AJR7k+zOHk=;
  b=dZoAceKoW0N4ujYSX/7abUV84VQhmd+Zfva/AoTRP9QcbmzdbqBuNy7o
   aIGEkcb10M3J0AMSM/NE5G6e1jSVQO03EYTTMbLsTr5O65NUAZicZ06Tl
   xHx9KT+O84+cDX+LeXyCPIQ11Bd/gP5pEHiP/032ZThWxI4J2oDgaz2WG
   fo/NuuytCdtVV/pJ0NwdElI9s+DDyWowbhi/M7HZphxJXCVmackaS05MD
   nQBsE5xQk/9nW/gi732W9XIUoraenZyheGgj8eHbFQw18u0w2Uz/kkykF
   rx//X6gMQc4HFWEqvHClVQ8KRNB2IbwqQ2lKdTzG8zet+OkWq3wRkayS8
   A==;
X-CSE-ConnectionGUID: DBcfmUudQ2m/2w1YtwmjrA==
X-CSE-MsgGUID: KBttrPopRDaAV557anmoIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="48574563"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="48574563"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:04:27 -0700
X-CSE-ConnectionGUID: hVDPLDavTfiXEeS2XunEqw==
X-CSE-MsgGUID: ydO/R0DHSQa56zmZApSnBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="133999682"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:04:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 15:04:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 15:04:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 15:04:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyYcsXDSAeqVJQ2UUb828iNZ/UU/hTRLjB/aZAruTL1EqIwoquGZNDr+hIYMhF495GkbFkRt12porR9NiiXFNk6QTIQBQB72rJvjLCh70T7KgUe0/GdrkB3wS5hT9+nuCAKx7nV1rC0Yh4SriU0SQUsIpV/uImowTUtR7/+4Dbl6W4Y0v2IjfsVf111J6RySo8iNw6lGH0vaT8L0AIqztoN123MslVX0fCR685ySjU77uz0x6OdwnloGpy1RIM+X4WNSglrjpytFk+5eInpF2mEx9/PyxSWUsxRz7tQdOMNlJeP1vxW1/7v89wSRVzGxlheClHWH9DlU/SXeDgZrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fy/cY/dYz242fSqWVNLbF5SZ+bNFKeqY0hcpfsPxWCI=;
 b=NRrk22MlW1L3nIZYkKlVJtFGSD6ca8tCs+JAnadGFErIJt5AFgotCuFosVFmCfQyfERCls525OVYd2RML0BfxMkZhigYrt3VyayQ67fnSAEi97BH7odey42mW9pmqFrHwvpHsNIvGHFjECfZXHx1AZULdvDmUXpB4SDEjC6hLWgBgPT3SmSYd24j9SKvBi1m/Hcc0tb6PKWJBegUSC1BLssd2VM0pGyROzQrlHqEUfMjtm0Zm1HKfQBjno/9vuZdNWaL1WIfQXXg2hTkyn3VkXTF/5gM8XC3k1WdVvO/he1xKU5UevwEw6WRsqATX5ZvGwraXBW6CW1Z4pcpI045oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by IA1PR11MB8246.namprd11.prod.outlook.com (2603:10b6:208:445::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 22:04:19 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%4]) with mapi id 15.20.8632.024; Thu, 10 Apr 2025
 22:04:19 +0000
Message-ID: <bcf8dcc5-527d-41ae-95e4-3c0b6439d959@intel.com>
Date: Thu, 10 Apr 2025 15:04:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] idpf: fix potential memory
 leak on kcalloc() failure
To: Simon Horman <horms@kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Pavan Kumar
 Linga" <pavan.kumar.linga@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20250404105421.1257835-1-michal.swiatkowski@linux.intel.com>
 <20250407104350.GA395307@horms.kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250407104350.GA395307@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:303:83::16) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|IA1PR11MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c64c31-0e8f-42a4-0fba-08dd787ba453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDdzL2hCNjl0dXFONzVJZFdQRWRsSmtHc3FYdmlpa3ErR0RpQW1GRnZqOEwy?=
 =?utf-8?B?UStUY2h2NjNrQ2RlUUw1WFZUbGdHc2VCQ2lwdWx2dEpsUzhqM0EwMnhjcjNZ?=
 =?utf-8?B?OTlwS3p5MCtxV1dJZTAxWm16aG02MlBtNm9MSG1WOVd3ckJBRWRmdmh6MURv?=
 =?utf-8?B?TndRNUtINkhJVlRzdEJlZTZqRXNnY0hTTFBWVDM1aVZiTTZUS2RkRGdzQlFl?=
 =?utf-8?B?UlpRdVZxMTk1cDYzaE9HbDQrbTkzbWoyWFFteXc0dFVaRGQ3TmdFbDk0Ykp3?=
 =?utf-8?B?NElUMzNML1o1cGNzRTR6Y2RTdVBUTS9GdGhSNkw4dCtjdzVnT3g1U2xGYVdH?=
 =?utf-8?B?N01qMHREVlZXM3ZZN1YvYnljRDZLaEdveFJSdVg5MlVXUE9admJCa3JRQ1U0?=
 =?utf-8?B?Mmo1UU1wUUp4M0cyeGFJeFJYb3drLytVcXdmVmViWmlvaVJSbFNMZUFWbmMr?=
 =?utf-8?B?a01VMzFaZlEvMWQ5aUd0aGlmZ21aQ3lBVTZTRkNiUDhqYU12dHJTVDFhL0M1?=
 =?utf-8?B?ZWovaEF1Kzd6ZjFvazhNRFR0MENPQUhNZVhvS1RJdGxKK2poZSszRC9xaFFO?=
 =?utf-8?B?ZXdValB1ZFRsVEJ3YnZWVGhKbnJjNmMva292ckxvY2w2TzBKaC9Ra01rWm5U?=
 =?utf-8?B?QnpDZkJmdkxrSldpMkdFY0V0TUlJek0xRHhBMTk3bDRadEsvRFdvNEpnTjhX?=
 =?utf-8?B?WmhVQXBrY2VkWEQ0aUJsVWNScnRiSFV4dTVTblE1KzdwellxQ3pkV3hERURD?=
 =?utf-8?B?OE1kZWNxd2VuN2VvODZjNmF4ZkZ4S0dFMkg1Z05EMmlHUnpZaU5xZmVUaE9J?=
 =?utf-8?B?YzhnVzlQcDBPVXhIdXdqb29FSG5JWmM4U3VNVFJ3ZDBveTZSTFhMK21OSXdh?=
 =?utf-8?B?dDA1OVBQWFFZZnM1YUFJRUd6VGJHdDNrZG5kQWRqekNCTlEyMW1jUXFnVzhi?=
 =?utf-8?B?ZG5nMExJdlpPMHk3SXZvU0dUOHJxcjFMMjBCQnl1U1Nkd2VLdjBoZHRDWWZX?=
 =?utf-8?B?dTB4dkttRVFMTTVCMGxZSHJhY3Y4WVFlcnRLaStJNjRDVFRDZW5rSEZqZEVm?=
 =?utf-8?B?cHFRMHFySnJIeVU4QUJFc1crN2hzOUJXMlB0RHNtNjczeVppWWFqQzA0cFkw?=
 =?utf-8?B?UjZuNjVXQ3F4MElEMFB6U0hzN0ZhYVJXb0c4S0R3TTU2d05RSjVYM1Uyc2dE?=
 =?utf-8?B?eXJwN3lUT1NZYnhySWFFWkxqdStzQ1JtK2dQeFMvVnJoZDBYVW1LZnlVZXJD?=
 =?utf-8?B?Y1RIamtoYkZ2d1I5UFhxWUIrdk5wejIwMFdxTVBFUTF5Yk1lUkw2RFZRMzdE?=
 =?utf-8?B?MkdFa0lHMTJpNjQ5ZFlQYzE4VnU2YkhJN1hOOFNMelQ5UXBuK3dxMlk2WG9R?=
 =?utf-8?B?SlR3NkZUVmpZbHVtQ2k3WHNJWVhUR2ZtaUxmYkY2ZzJvcTVTU3orb0hKQll6?=
 =?utf-8?B?L0pyT1h5Y2M1Q1ZlbFFkNE5RakI2MjE5dTdndjI5SVQ4YWZodVNZM1NZdG5Q?=
 =?utf-8?B?UURtT0R4YlNad2tDRE0vbEFrM2o2VDEvVXJkaVdjZ1g2Ui9wbUFoZlg3SlZH?=
 =?utf-8?B?b1dqOW5UR2t1MFo4bEFBUnFTV1VZcE1mMlExcFpabEUxUUJtZTlpcGliQkNp?=
 =?utf-8?B?T3h3dm55c200cnNmTlNuU1hSQzhQeWJ2c1hoVDZ3cThpQkkwQS84bXY3a3Mr?=
 =?utf-8?B?RnhYTExkVDJmUC84YVkwR0dPUGZ4VmdiUHhMVnFRM2hRYUlhb0FZYUJZRlha?=
 =?utf-8?B?dnNpY3QzQ3VXSFZjRmdkS1pNczE4STliRmtiWTFYUnpQUnIvbEhabStTcnBp?=
 =?utf-8?B?SXJLSmpKMURpbVkwV2srWW5aUFI3TUM0K1ZZeTIvamkrRGxoU2RCci9qRWta?=
 =?utf-8?Q?/OHDe4k3ekoJ/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlZSU8yZmFYZi9LNTNsdTZFZWNLaUp2ZDlhVEQ3cDEvV1RyVzJvdCtwdjRY?=
 =?utf-8?B?Z2p3RUhwL2YwVzhCWUt4YlVhOTQyallvbUVyS2F1cTdOWlMrSGwvYUJjTEFH?=
 =?utf-8?B?ZGd6ajgzYit1dmlTVm01VEFOWVU3UlYvT3ordmdSQTVSRnROckpzNEl6aGdH?=
 =?utf-8?B?MDlaOFBCeW5ibFJSSzE1ZXZVUFVPSUhPK210dm02TkhtWGx2VkhETEhiQmhw?=
 =?utf-8?B?MmVubTl0MDd0VVRKZXpkOGlPU0JXb2xUVVBXdGovR0FTQWUrZmo0Z0N3ZzlX?=
 =?utf-8?B?VVNJMXNlN0MrOWtaeFVOR216S0VuYWRONGJrZ2pzVTEyV0VCKy9RdUk3ZTRz?=
 =?utf-8?B?SEJtVFpndkZWZTFZcGIwY28xNDhSVzRkdkJ1bncrc1dNTGVDVkVtS204a0F6?=
 =?utf-8?B?eXAxUHovTFdhQTZKTE5wVitHTjZmUlJYTFA0QUxFQ3l6VWg4N016cENLUjc5?=
 =?utf-8?B?TmN4Sjh0V0RYNzFUbnBvcnVnSEJaNkllVFBBeGlnNmh4emkvU3dUWGhlWDVv?=
 =?utf-8?B?akhyYmVBc2UwMEdrd00yaUZuNk8ybWdudE9USS83bHNLMyt2dmQ3b1BnVUpM?=
 =?utf-8?B?cmR2UnRsdlhUVHkxZDk2TTdTUEl1VHNtTnptNVBrZXlJWDJsWGNLOHJVOEQ1?=
 =?utf-8?B?WHhwQlhqL0JhaVRRbTJIc095cURIb0l2UVZLSTZyZjcyc3dsWDlGQ3hsQ1B1?=
 =?utf-8?B?WHd2anU2ZXBObmQzNm1BWWNueVEyR3RoV2NmZ1RJbk9PaGRmNUw5Wk1BSFo2?=
 =?utf-8?B?Z0FaYnB0MDh1a0laajNQVWxDaEo3RTc2bFZrUE9BSFBVR3dQYlVTYTVVc0do?=
 =?utf-8?B?M2NJdWhhcXljL2VwT1RlRTFmNE1ZWVhCUCtSWFB3Z240anljSXRnOEl4YzhW?=
 =?utf-8?B?RjBmZlJBZDA4SXBsVHpmTCtJV2RzZTFQYk9PblpBdnBNQ0srVkRjVUlXTmJx?=
 =?utf-8?B?VFJOMU9NcDJvRGVVZmcrNUt0MGoxRzhva29HT2dkTDhtaFBXeDFPanlqdVZn?=
 =?utf-8?B?VDhhTW9uMzNtSGRMbnBxanNiTDg2dElETVdDTTJrN1dWdHd2dTZlUnoydk90?=
 =?utf-8?B?aGNRejNPdDhuRElTc3Q0Ly9ISkFjdHRRc1EwcnoxUmh1SGphdkd1VkJDQ0VE?=
 =?utf-8?B?UjdPaUx4ZVo4eWtnY2NVWWNBRnNWaUZnWFdHYW5pZWlsTE0rVG9JelNxNUpy?=
 =?utf-8?B?by9FUFVXY1grNW1XaVhxZkFjRWkwVFIyUTlSTS9HQU4rc0c4cS8rN28rZVIz?=
 =?utf-8?B?anlhRlQ5RHJ1NjRQTmNwMTdoSFlwMWlnMFQ2MlRwZ0twWHdqbWFMczVFSXNC?=
 =?utf-8?B?ZWhsZHgzaTZOMTBXNnJBSnRTamdpQktKcldzTWZNT2oyRUhzb2RabER6aHIy?=
 =?utf-8?B?ekw4UE9VRjdoMXpLK3JweTRpcHVYY1ozL3NGRjQ5ZnZ0TGc5SVYxZGRnUk5X?=
 =?utf-8?B?SDJsMjhHSmFhWGlNT2doK1lLWC9lM21ndm1hcExKNkRxaHdkb2ZVTnNEYWJm?=
 =?utf-8?B?NGhucWhwczFDaEhUVGwzL0JWUy9Mekp3cXdtUC9BQmVsWFNUQ1dCbUdIK3J3?=
 =?utf-8?B?YWJXdzU4RXNMaHRFOXgxV3Z6d1cwbVdsNXhRcXpQOWhoUjRyRUxLdmJNd1VK?=
 =?utf-8?B?bjlTSTMwS1VxU0VsU2lTU1ZUTTErSjNXQUdMdkhYMkNMdFNSZG9iT0RlZkpS?=
 =?utf-8?B?WXhuZEdMNTJtZlNSd3BQdGk0dE1aaWYxZTh4MXl0TllCVndhU1RlQk5aVDF6?=
 =?utf-8?B?Y2REMnd6Ukw5eVZ4MFpJQU96MzJFUnh1NjBqSytRSzVyaytVRXl3eDhKRWhi?=
 =?utf-8?B?UFhHYzdTbDFvdFRVbFBsMUUxRGRtZXIxcHIwdFpWVHNlV3cxQ0hiaHRaNFRl?=
 =?utf-8?B?NkpDdlBPcHdCNzdzM2VrZk0vQmkydFlZbytQakJzQ3lGR0FWYmdPcmF3dkVY?=
 =?utf-8?B?UmY2KzlVU25vZGtzb1d5cnB3ZThYWWhlTjlLR2VUVi8vaVJLZHdFamhBeTM1?=
 =?utf-8?B?VndlemNwSXlvbFU2eVFMcU8waWlRQlB5cFp6SGNSdHdQZWVaTm11RTVpR0s3?=
 =?utf-8?B?YXV5MWZnc3loQUJiZFlzSXVtdVltd0pSK0VSbTFPdHoyelZ1OU16V0dFWEQv?=
 =?utf-8?B?SEFWQlBNWVRKbEJkYU5UZVVBbkRhaThLQUVZMnNRSmxGaXRyNXYvd1R5V2ZX?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c64c31-0e8f-42a4-0fba-08dd787ba453
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 22:04:19.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEL+GFAP7i+bnglw35kpe6wbWwfDJtIKeShEbktb1iUvRyB6NkZ6m4Uv+086bAhlv7+tmuxLPZnCYsUuepyL9XSN30c0uXw+dPtk9m46QlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8246
X-OriginatorOrg: intel.com

On 4/7/2025 3:43 AM, Simon Horman wrote:
> On Fri, Apr 04, 2025 at 12:54:21PM +0200, Michal Swiatkowski wrote:
>> In case of failing on rss_data->rss_key allocation the function is
>> freeing vport without freeing earlier allocated q_vector_idxs. Fix it.
>>
>> Move from freeing in error branch to goto scheme.
>>
>> Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
> 
> Hi Michal,
> 
> WRT leaking q_vector_indxs, that allocation is not present at
> the commit cited above, so I think the correct Fixes tag for
> that problem is the following, where that allocation was added:
> 
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")

Patch applied. I do agree with Simon's assessment so plan to use this fixes.

Thanks,
Tony



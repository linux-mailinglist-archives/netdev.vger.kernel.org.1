Return-Path: <netdev+bounces-208266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBD3B0AC37
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1CEAA38C6
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 22:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504BF21CC5A;
	Fri, 18 Jul 2025 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgDQyE9z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E110957
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878254; cv=fail; b=Tp+SeMyhmhLkrDtdD7yYbvE0spmPupYXKqb+H+ECrQoqUmj+WgeXMtb3mCqbdjxJeQ8lJPjuKjtU78uj48VeLXFOve4r3uo2GbRPraeGvbxmLP6eV/WEGZ9ugWdUbhSwyoDhO3dlhu8JwlhnXZyAJkPQHLnYRtVdFqjwytDbFss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878254; c=relaxed/simple;
	bh=kWyhcM2OLQBCSGzexhoIdr/CXkHxjg1bUUBKlkzQpoE=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/63O1nwT4O6sudyo9QNmzFOZLvvBoTLvgtJjn3f+h22vJ0VocqszJv9kxAqjYYx4be7ZPjUV6TZKAiqctl23PRlE/cBoemdAMa4jAzXzvYvHOcvgIHSBrSFYuzy6ulYRCtSpbcXI3rZrCR0t1vqLF7n5ZnjGmD9D2yirzsUVWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgDQyE9z; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752878252; x=1784414252;
  h=message-id:date:subject:from:to:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=kWyhcM2OLQBCSGzexhoIdr/CXkHxjg1bUUBKlkzQpoE=;
  b=RgDQyE9zkBn/6Uv4WYaWM+94g2GYmSRglLKcfY+GOrxvbgMtYj0CdH2X
   XAbYEWM5J6rA4uzsMc6XXc7caeRUF7UfEch64IIX/aYqpIQfS/FO40g6u
   IWnDwp/zZiHhwywOlbiRQylbjg5fd9ZjXk5PEam+iNFMyVABrVnIjGAj5
   x6E6ghX+qgGTQI/Ekhtr4CkKMP5EFfOZgyIKBM9TF5axe5Q7QqJh1hLt8
   Bu6201TJ/B/p0KkKUmLFhFETtdif3FeQxLfWKuGO69ktA45WzdBKP5YkN
   rOsScDe25gzSXZrpK58nRTXXxG7R9I+8pzNentOfjVYWtv3U4SHt1QqyH
   g==;
X-CSE-ConnectionGUID: JDUN/nxmTweJWnSzhhWkbQ==
X-CSE-MsgGUID: l7exm9oGT7WjafdIJgOvHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="58843918"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="58843918"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 15:37:25 -0700
X-CSE-ConnectionGUID: fTDJBVpNSNqV6PXqLFldNg==
X-CSE-MsgGUID: lFtU/MUJTYK9jlCTGJwBwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="162597219"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 15:37:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 15:36:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 15:36:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 15:36:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3IPVHGHU1IP1auYo+guDJcX0prCQpiIeISoyAiVl9se4EwTT27AJtHoq7sKluizWuP777GboZJpQKa1HRzQDRJ42jslf2JPPD42gugMg3g/BdMec2MX4DP0aqEW51UrXFe7dfvA2lOKb2BsCPQfs53RCNb+P3V0w0590ISxx6fuvBqX2Lteziw7tTmPpUtLLK08l4NKuGfDUUmtaGYx+QtrppTuVl2QLWxvtFDvefZz2P6js+YvsaR55iK54z1Eu0pOFN4dePuGcKh8+tLlZYL7wNTKXEqP0sxpLCGovYmhZo9EJ9+HAzJMzkoQStbMSzVBu86OjKBRZoV01BoqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTs9RmcQOC0ViM/1UAwgdHEcUDc8LPrqioU7JpF4z+0=;
 b=iS1nGtkkIRDij5SSdK0F8t6yMaxnM8pPKoLOSRbDXI5QXow2XB5q7hpL5yPwVPDl6i6txBg/vHPdcme4SgorSOKMI31/8ZMTZOsBpnWXbXGy+wOxKl4NW0Ktg2Q/iVX6nuUlSsT+zUyHAOWmv6RwMBrnQYkrCQoJNQdugQhdeQzlmsS3UMRT2e/Ai5DeuGpiPQmE6kaVISlLgQ31b3xuFmZXOdzgch5ZTdtpFeWR29VM2t9i2tgW9piqA2E9Vunl/ZqfImuTDbP8SjXsvkk2bJpes5AO0QqF6TMVg36TAjsEbbfj9UjGL4jWR4/4XHOycqVpDliOwd2CUB3X/fB2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 22:36:40 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%4]) with mapi id 15.20.8857.026; Fri, 18 Jul 2025
 22:36:40 +0000
Message-ID: <842e0cbe-57cf-42e0-8659-81f96e29d7bd@intel.com>
Date: Fri, 18 Jul 2025 15:36:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/13][pull request] Intel Wired LAN Driver
 Updates 2025-07-18 (idpf, ice, igc, igbvf, ixgbevf)
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
 <9d2817f0-5ee8-4133-a139-80e894f32c9f@intel.com>
Content-Language: en-US
In-Reply-To: <9d2817f0-5ee8-4133-a139-80e894f32c9f@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:303:b9::23) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA0PR11MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: d41060d5-151a-4ddb-6bbc-08ddc64b9059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlJLdksxWWorSFpLRDExdGgwclJiVDhNMjl3Qko1VloreUJrOHlZUEJaSFNN?=
 =?utf-8?B?RnpKTERESWM1eU5oMVhUcDZjNURnTzJtRndTWGhRcjc5Z1paSTN5R1FlQTg2?=
 =?utf-8?B?V1NCdGRLYmFYQXhtRkxNRXRHazE5RzlLQkVpT3Y5b1RBWk90WkhMZDBIMG9E?=
 =?utf-8?B?Y00xN1lpUjMvRGZPRC9aRWxqZnp3Z2cwRTQvR3ZhdFk1MlFyYm5CRlQyYUF3?=
 =?utf-8?B?RU1BZi9DalpDci85MUo3clFPMnZWRUFXalBHcmlEOG9SWkNPSDZJQ1I4U1dS?=
 =?utf-8?B?eHg0YmpKaUVtM0loUitwb0k1V1lsMEgzTVR1U01mM21lTkdrTmFQNGZBeEg5?=
 =?utf-8?B?MHAzYzVoSkpNaEVRdEFjWno3SldPNi8xcGtZeU9SWXpONVBWdG1kUVUrV2Zh?=
 =?utf-8?B?Q3pxcnhKZVg4dE1OVlIwenBLMUJyQ2ZDREZSMkprU1lpNmV1TXErSlplNDgz?=
 =?utf-8?B?aThnSXkvdUI3aVQvTTVITFhHSDlTNTU1QnBlUWJnM2NoMlFCelE3MEZaR1Ft?=
 =?utf-8?B?amdKT0M3dytlSmpxZ2haRGhPNTFCbU11L1RXbWpDQ0Z6dmI5S0l0Sk9WVnl6?=
 =?utf-8?B?M2RnR01GdzM4SUppRjFkR09COTVPTjl5SGdLS0ljdkgwalVnaEgrY3FUNkpB?=
 =?utf-8?B?eXB2ekgwS0thdnNwZnQ5Q29RUkc5bmJ2WVZna3VqV0pmcGVhYnBxcWxVSy9k?=
 =?utf-8?B?Y1NzQ29mdzBTSnJvdTg4NE51K0hleXhsUUlxOFd0SHhlbzZDdGVNNGtjckNY?=
 =?utf-8?B?aDcvMkFpQmh6ekJSRWV3VDhwbXRvZmlReERkYmdldXIySmcxWW1tU2xwYi92?=
 =?utf-8?B?UFg1eXFCTEtwWUZ6cjVvd0pmV2JwTWpWZ1VuTVJXVWtTdEEyQ2cvcEZwR2R4?=
 =?utf-8?B?VVRjNU9rcGxBaVVIMW9tMXNvdkczclQxdUVRMXVDV0VVSXdaYllhWHpVcmtW?=
 =?utf-8?B?RkRsaWszYW1kbkNxM3dZUmg1MDlPUEtDRkVLcUNQbzdIR2MzNmQ0UmFYQkJR?=
 =?utf-8?B?N0hhZFpjWFd6aDF6ZWdmOEh2K0ljcXFLWDFaWDRsY2FGUDZpMmtvVUtOeldp?=
 =?utf-8?B?WUhEcHhJSzBscTB5eFNSZDhKQVpHOW1HOURHSjl2VnNrNVN0SVAxV0N6akIz?=
 =?utf-8?B?ektQSUNFYU8zVFVYVFMwamgrR3hacFdVY1pZTDg2OEZzcTA2Q0U4Z2ozcnY0?=
 =?utf-8?B?SlRwTHJ4K2lqQ3BRNDBGMmU0REo1SlNjdVVzczlFNnNnY3JUVUVDL0t3L2dm?=
 =?utf-8?B?WHB0QVBtMlJrSS9NYXQzQkRNSjVrM2t2RVVrckFDc0s5M1VMQ3ZUYzBNYXNZ?=
 =?utf-8?B?OGV5TkIrRGp5VVp3Y3V6MkNYaFN1Q2d6TlFWbFk3STlrczc5dVM5Z2hMdmNI?=
 =?utf-8?B?SXZxbSt2UUo2SGV1My9zRlJvZHJwOHpLZkEwMGJJUTNteXhvT3k2dk52bHUy?=
 =?utf-8?B?bitVWTdsa2RFNHJmTVVIZ0drNGhRblY5Q3VnK2F4Q1pUVHZhMDhHakxYWlBX?=
 =?utf-8?B?OXJlUTJyaWx3WTVnNEpEOUl1M2dBOSswUEJ2dVlEaG4wMnpydDlacDlGc2ph?=
 =?utf-8?B?b3pONEsvZ0UyU3hoNWUxbDNJdk1iYlNtajNRWHVKN2lKQ05XenFrWDdxbktO?=
 =?utf-8?B?Z09STVpmSGdoQlpFMWU2YUp4UGFqQ2phR1dDc0YrUmNQdGZqc0RiUE9JNFhV?=
 =?utf-8?B?R01NOFVxLys1dzNJelZneFk0RFNLeDZwZVFjYnN3UEE2K0k2a0dUR0crcG9U?=
 =?utf-8?B?NU9sakFqQ2ZxQllUL2kza0I0cWpBZkNnUWE5a2VJWm5vd0NxbFpJbmRxMkYz?=
 =?utf-8?B?ZXRUWno3a2hGK3VhbzlnMjFBTms2cm9xem5FWGZ5cDEvZHl2QW9VN3JFcVIr?=
 =?utf-8?B?RjBITkl4OTVSQW1DZ1hVamxZNEN5VHAyNnZNUVBwcnRQbmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEtnaHQ0OHJpaStxOXlQOHRMS3hUOS9qRkszN2l2eTJldE53SURadjlnbXlh?=
 =?utf-8?B?cEI5QXhXOERFWFhYbzMwbFJMb1FpRXJHcytGVlJMQzlYdGwzSFNVTGdtQlNI?=
 =?utf-8?B?VlQ3ejBrQkdyQWVCNVphU3dBL3pMbjgvNVlta1d5c29rUFpXd1NOLytDK3d4?=
 =?utf-8?B?a0tEdTJlT0Rxa0Yyazh0OWlPRHZwWDMzRlEveW9uNWRsUVBVVEFEWVNnSnRR?=
 =?utf-8?B?ZHVMQXY0QTdwZk9TOUp4dG9ab2FmSFRzZkF6Uk5id25FN3VoY3lRUlk0dFA4?=
 =?utf-8?B?eGxDazREa3VkRDZsMWlBUmJ0S1RWSmczSkZCSWFEZHJIYzJQTFAyQk03aWIv?=
 =?utf-8?B?aENjbHRyZDM2YUp3bVM1WUQxVzNHSkJDMHhBZHRGK2l0YzFwcGdEK093QXRx?=
 =?utf-8?B?Z0VjNWhWTXFvWVZwdzVQU1R1ZHFFU3VMQzZqSGU2MUcrdnBFVDZDZjRFZ2VD?=
 =?utf-8?B?dVQ4aTJYQno5L0k0aWFDSU0vMlRSaW82VytsSWRwZUNDVllKVDhIeGk2K252?=
 =?utf-8?B?ZUd2Ymc0NE9ZM1lsdDYwQ1ZuTEMzZFRYd3ZlQjB3UTl6bTI3Y2I2RVhuYnlO?=
 =?utf-8?B?SFpDbndUN0xYc3N1RUxmSWdubzBKbW56L2tVQXdjS0E0bjBlK0oxaElsK1NM?=
 =?utf-8?B?V2JPVjdwbjhJTUowc08wOTY4aGdUb1pmVldXSFZvNHJlYUd4QU1lN1FWR2Rn?=
 =?utf-8?B?eURtSFZxY2JrOUkweFJZaDBVNUsyaWxGSG9PbzFVOG1HTnNxVlVJSU0rSy80?=
 =?utf-8?B?WnJta0U2MUEzdERBcWFvcnlEcU0ySzNYUzRleWtsTkhrbHdkcFpNWEZhcnFN?=
 =?utf-8?B?U2ZSdldNMm9UZGMxVmkrT25semdkUWZGN2hGUy9wRndwcEhPOXhTVXFYN084?=
 =?utf-8?B?WDFxRUx3b2QvMmoyQmRmV1llMUlaUXg3WHh5bmowVkxUYjhpT09JV2ZtYTVB?=
 =?utf-8?B?WDIxU2JGVllsQUN6UFowdEs3UzgrdHVmeGRhM1FMR0ZrUVphUDhkUGU0cTkr?=
 =?utf-8?B?eVZhaFpqMTBGN1JIT1RPVUJVd3JCT3RWcUxIcnVwd2hrVXVvaHc3Znc4UW5B?=
 =?utf-8?B?MG1ienA2dVhkR3hORFZWOFc5UTVQQlo3Y2JheC8zdTgvbDc3bTBSdDBEVitP?=
 =?utf-8?B?ZlFkQTNuVTNSb3VncHJ5VnNQaEZ1VjRXbWllT1U1dTUxbkJqSkVtZlk1V2tJ?=
 =?utf-8?B?WUh5Qm8xRjBWMHFCK3JxNXo2MFN2eEhQZjhBckhQMmRnc2tHcGZzZzFiQ1dU?=
 =?utf-8?B?MnV6SUlDVjYyVHVzSGFtVW1PNERzc2dIajBoR2dQZ1JWQU1ldHhuQ29Kb3Jt?=
 =?utf-8?B?VDJzbVhjdDRDaWFackZJaUhIN2NEaFBSM0xoRllSRUg5VU9PQkhlNDI3S1ZL?=
 =?utf-8?B?UnJKdWJhWkJDdXdpMHhod3JibUpzVEtqUHMxNzlJVVhPQ1hNcWVvUHB6Q2xh?=
 =?utf-8?B?ajN5ZUJGa1JRRUw4ZkhrV3EzUTJzeTJhRTlBYUtSV2docU5DUTEzbjFjNUd2?=
 =?utf-8?B?NlVoT1UyMWQxVCsxbW9sZWRXQ2VJTjJmbHpoOUtiUkp6Q0R1UnNScVZxeVYw?=
 =?utf-8?B?aEpDcFQyam53ZHVKTG5HaUtXcHBQRFRPaHhGNW9TbjNFMmJDVkQ1cktuOEFT?=
 =?utf-8?B?SHV3di9tSW1UWklaRzhJL0xkRlh1WDhOTm9KSkNlSTdYTm5lTlRPVk5pRHRx?=
 =?utf-8?B?Uk5HbllpaU9ZNmRDb0VPbk43TjlrVHBlM2ZOV0Zac2lvNUZ0MEVQOXVuSUEr?=
 =?utf-8?B?WnhUbDVYeWkzY0RXWEtwZjJzMUh1VGhoYUxySHJuWUdRazdIZ1VsUllCNkJ5?=
 =?utf-8?B?Z1NXUmhtOTd3L0VqRjlBSjZWZ3hJSU03Vk91Z2ZZRXFjOWxFWjFibEVLWjdl?=
 =?utf-8?B?MHAvV1UwOG5BR2NnZUllVGtBUjhkVFh3NWx3TzNvUDZyQktWVGZlTEFGdDY2?=
 =?utf-8?B?YU12eFE2NVJDTlBjWm5NNFBJYUV1STc2MSt1TE96a1lwQXhhdkJoMmI2cjRk?=
 =?utf-8?B?enVYZVRmL2tPdVdCNmJnTVIySlhpWlVsdWtkK3VUODkyaWdyMjI4SXh6dzkw?=
 =?utf-8?B?aGRQMkQzYXJnR2ZRaE1tME9HLy9BYmtudFcwdmZpNHRKZ1NTSVB6blRLWHNz?=
 =?utf-8?B?b01vZlFVWFRmbEpOUzhEYzV4Rm5ZQUJTU2hPbFVteit5bDQvb0pvL0hOQkw2?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d41060d5-151a-4ddb-6bbc-08ddc64b9059
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 22:36:40.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8IpkQTQNMaZ1S/tkiHYXxagoNxDJcNuTietwFoonlqS8FAt51LFK5fLqQtWZcA/yFJ3yYEP2aFPh8x58dFF+GpQu1niLakHolbwOAzbMaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
X-OriginatorOrg: intel.com



On 7/18/2025 2:37 PM, Tony Nguyen wrote:
> On 7/18/2025 11:51 AM, Tony Nguyen wrote:
>> For idpf:
>> Ahmed and Sudheer add support for flow steering via ntuple filters.
>> Current support is for IPv4 and TCP/UDP only.
> 
> I blanked on the .get_rxfh_fields and .set_rxfh_fields ethtool 
> callbacks; we'll need to adjust for that.

Sorry, long week :( Looks like this functionality stayed in this call so 
we don't need adjust this after all.

Did you want me to resubmit this one later or did you want to change the 
status back?

Sorry for the thrash,
Tony


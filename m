Return-Path: <netdev+bounces-161133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E96A1D8EF
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 16:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46401886DB3
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62CD2D7BF;
	Mon, 27 Jan 2025 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPghGI+J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03868F510
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990119; cv=fail; b=u/31Ar1m4/Zq0lniw92IxKyphWpFWHd0RrEzVPAJLbY5txzaRvCVbxU+8FNhkv5DhnmPZh0PiCfPu+CB1S3RHfT5luME14J+AOBVQGKXZKTnyW8FI/B6MOMuzYlO2gi24CDveBEiUkNwGJ1BgedUjVNxz+t6G0dGqR8YTkzZBdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990119; c=relaxed/simple;
	bh=pcKZlOsY0Skt2wnkaoQZDu+c1p4mg20I9m+GU4SA+uY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kSId74rSZB4B6P0BdhTNBQbWivRmg+nhjMNDWH9dbbu+A8AP+OJMsUXkH/h72Uwm4ohwUzlTqTcKWkMjlL1wxDMTzRmU9PlTJqNK+veAxY7MlSiQxlvGLQdny5CdcA0J8vddS5iqFs0zg63kXTu2gP09ZGr/HeuVNrOSOWtjW1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPghGI+J; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737990118; x=1769526118;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pcKZlOsY0Skt2wnkaoQZDu+c1p4mg20I9m+GU4SA+uY=;
  b=nPghGI+JzCoK2EBFNsUc6I1may0F5M3Vnzuuui/MkUZzdusdmvryJ1N6
   kAG6sVN8uhyByD6ZguBgixaT1mSiTx+6yYF8CgGEUOl92tiNS52fLsXgG
   Br4/7jaPbI7PYFc+/RfHLTGd8P+037yvXbj77vvmE8ltzYr1tgd/QA1Ii
   RrN1IDNKEU2gEa3znAWf8mkI758cVtprmKooiI2vaBk1mob8CMFdMBRoy
   MN8gACgwVCcvCLz/9AUIYqy+9Q/gmKEMzOLAJYbFIm/kSJQi/TuXUT8+X
   LQuIkcXJHi8HjcQcHYva1sP6VJXv3wVb1eDXOpVZuNL9Ujv/YMfDXAP3T
   g==;
X-CSE-ConnectionGUID: RvZ356i1TT6/b6BFIJTKBg==
X-CSE-MsgGUID: kPUVRVD+R+a7fRxTlM1k9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="55878799"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="55878799"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:01:57 -0800
X-CSE-ConnectionGUID: zljGnGThTqCKzTYV+jcd8w==
X-CSE-MsgGUID: txVFC7PQTtqScHb142J1rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="108983761"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 07:01:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 07:01:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 07:01:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 07:01:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovFnjbWH7/jlaNzpAjxAMqYxlvt+Vl1Tr1s3otzkVJ2O4wo7DG7uMfFTRuCtmu86Oriw+49EkXCXfqpUOU7Cl3AQ193QWIXZD+cJ0+PJfhWNS5Q0/9YD2ZL5pOT/8q62NxFTshXvn4ljA8qRNS6Uel5mInZbNiYn/q5AtcGLjNDj5fv0e2XpegyazBYIqXNz8NtuuJuR3vkU9xjkfg1Ajv1HZSkjmtbmOuUH+tFpVuYn6D2/pZpmP3iAZjd6H1CDPPV7RyGAHUt51QHq7JoPFtIl/oLfVpcB8D+ijHPIq0z8ZiCqlTHFJNNlrdS0BbfUlWNho27Z4sSs6x85ObnbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5rK/omynYfreCXWLv+/VDsEDFOukat3scCtD+bpTZc=;
 b=v54D5M4bAlanTdcp+ZTXWwD0/XWCOXPbmEjXNt4L4yDoUVg3jEORJBcrFKZxkAoESYkw+Ke4bez8TBVkIY5TzbLcnCcppvce9ziGGU1fid8iffMw28eImQbKTarzW3/P2lsa53j+OdlSlLRjFZTzS8W8v/UgMpsG/bE+juQQnWOeIcc73lmazvrGL5MqGWEmZPVBgm4ZqZq3za/GnSZ9knPxIkPxDKjO9VA4iTEhYufRClK3e1i+DwJJw1dtO31U2SWuZKEUOLbT4Bmw51z9CDtwCxVm2UbIFO8AWrzb5/9M9fJK5rpq0SKb+qSEdEchlu51CZZRJb1YBbJlPopHOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by SJ2PR11MB8323.namprd11.prod.outlook.com (2603:10b6:a03:53f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 15:01:22 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 15:01:22 +0000
Message-ID: <476d7068-f740-466f-b8b0-7092a3541761@intel.com>
Date: Mon, 27 Jan 2025 08:01:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethtool: Fix set RXNFC command with symmetric RSS
 hash
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
CC: Simon Horman <horms@kernel.org>, Edward Cree <ecree.xilinx@gmail.com>,
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20250126191845.316589-1-gal@nvidia.com>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20250126191845.316589-1-gal@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:303:b5::7) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|SJ2PR11MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: f12493ea-f6b5-41c9-0bd9-08dd3ee37646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REc1L09GU2pobnhMSVdtMDFaVVlDc3ljaEdWNTR4Vm9INXhrd3BxdTJrVmxk?=
 =?utf-8?B?ZHNwa0F3ckJVbTJ6empxREJQL1JodDFSUUNDb0htamkrMXhUS3JNNlk4by9h?=
 =?utf-8?B?MTVSb0VWNEV2aFBpUmFQcmZXVDU5dDg3UUs4VE5XNjVPT2RsNzFTM1ViejFU?=
 =?utf-8?B?ZjJleW13bGFKVXJxSG9ZSFN6YVBIejkzS1dnQmNUOC9neTJCWjJQMC9jZGln?=
 =?utf-8?B?Ujc0ZWZJbWNVZDZlTVI4bFVPZXhzdkRYZ2ZIY1ZHWEY2dGdwbjZCY3k0VjFw?=
 =?utf-8?B?bmF1azdWZHlTLzlYK2dtNGZFQ09zeTlzTWpQaERWMjEvcXFQdG93dDltYmFN?=
 =?utf-8?B?MnpybTJyU2hERXkyRzliUG1DdiszL2NxQi95ajd2eWt3UXlhNU9HTkFNbGlq?=
 =?utf-8?B?SGt6bU83QVBrQXhsbGhWT0JGVlQxalpkNVQ4VmtZeFpSMlNPRXJsTVFoRWhQ?=
 =?utf-8?B?b0diNEdwTmhvdHJoV0Y5cU5aekYwbHFKeGdWNU95LzFGL28rcnhJWmJLZTdQ?=
 =?utf-8?B?cEV3QWFJaTVnenhDR2l6WVh2Wjl1WXZ3ZkpHTk8vTXJoWFVFU0dEY0w2UndW?=
 =?utf-8?B?OFZ2TzhUcUoxMUl5NWwzOWtaOXRXT0xSNEttMEg4ZHEwNkM5MDA3aUtoS3BN?=
 =?utf-8?B?ZWF6NnF3dkxYNGVJaEZmN1F1Kys1OW40VURtb3N4MWV5SkQySEJrTmVyMXFU?=
 =?utf-8?B?Rmt4N0dwektoM2tROTg5NmdmdnRXWHpNem8yT25YWFZUSndVQW5hdHFzeC9y?=
 =?utf-8?B?YWRVK1puc2V1RFN1WVFNNERSN0o3WFFqWVdlTUx2RWFrNFVUNXBnUlBYazJZ?=
 =?utf-8?B?d3FOdTNQSWdQZmluZm1nMDRUWEdnamYraVdaVUErZFV4STRERk5yVTFybVZ5?=
 =?utf-8?B?QklNN2FQUXhnN1RsUmdWNVBpa28vWXlSVVBTb1JMNXRDekFZM25YSmpEeEMr?=
 =?utf-8?B?K3JFNnQ5RmNLWXF1RkVEbUthdGZlcWQwNnhkdDFTaldmZDJhVkJDWk0wcTM2?=
 =?utf-8?B?RnBab3Q0Wm5mOE5iRFhzRzE1TVZSNnUxaGZJdjNPd2xHRTdmM1dwbjdnQnlD?=
 =?utf-8?B?cllEU3BqOVI1OGdENldGMFJTaHljcDgvN09mWkdES2ZqU28xV1EyWDkyYWFM?=
 =?utf-8?B?QmVlbytsK05xSWdLU2YranN6UUxpbVVtS0dteWtpTkR5K040RWNyYjdFQitu?=
 =?utf-8?B?d3JqQUtxTXMra3dSWkdIdFV4eTc2Q3JHMXU2ZEJPSk9PSjJQV084ZFk1Q1kr?=
 =?utf-8?B?MFJUQkRBOHpjS0FJYVUyVG85YTFyRERaaEQ5UGxLdGpBVGF6eHF0citTYklU?=
 =?utf-8?B?cWNwdlZYeEdGb0tOYkJGNkVKY1piR1FVTEt5cEN5NHN6Q2J6QUg2UHJTeXFE?=
 =?utf-8?B?TXZnMVBXOWNyZndxcURxQXhrZEJWOFVlOGNGTkNQNStCSmtrak84Vlc2cEZH?=
 =?utf-8?B?ZEJmZXdOOWpFVGpGSlNFUzZvMTVYU1VrY1Vwa3hybURvaUEzekNTdFUvOG9j?=
 =?utf-8?B?aTl6dWdRc3Ftdm53bUZuMHo0dTNnWmRWeFJzRWdVRjJkVVRGZkNhVEdlbTcz?=
 =?utf-8?B?SVVxdkR2U01xejJPamZVd3hCS2plVFplaXdpQ09SVWh1N2kxK3BaeXBUQWRY?=
 =?utf-8?B?aDlXcmRQTjA3V0lXK2NtRDdWblVKSUFxUENJaEpBUGZLV2l0WTRLVWdReG1P?=
 =?utf-8?B?RW5yKytWVUVzVDhoaW1DNi9zNUhJckVUK2FiL2pjSVdlTGJjTnRibmMyc0Vk?=
 =?utf-8?B?WkM1Q0tPMEViL1JPejdINGdMV2lnN0JzZXJ0TXByb3AyVWNNeStsZnRJeUpH?=
 =?utf-8?B?ZVhjTElBUG1Qd093Vmt6ajNENlg1Z1ZOdTN0RmloNXBxaDJkSmZQb2l2VExz?=
 =?utf-8?Q?qDpNTLkhwDWfe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxjODJuL0k0WFk0KzYzQ0pTSWdIVHdmRWhZaStXZU45V1J1RE0xaWVxVWcy?=
 =?utf-8?B?ZXVaZ3MxT3J4OXlLMEdLd0djcVdKb3pEU3F2bW5zbGRIa2VweGI5dDFnczk0?=
 =?utf-8?B?eEgvS3N3YWJ0ekJEV1UySW9BQmp3QTlsUGppOUYybnBCaUdLZ3JZU0w4VW9s?=
 =?utf-8?B?c05iZU8yT01YMC82OHB3Y1dqYVBRc0NuRTROUm9hV2FRZ1lxYzhxalp6NVhL?=
 =?utf-8?B?QUdMd2F4R2pOSnJFQVBCamg4RjRKcG9jOGlpTWRPaU9QMlBuRU9UWXBWQTlL?=
 =?utf-8?B?MXhhTitubDRNeVRaNlVaNFEvS29iUHBrOWM4ZEJpdkFmV0U1MUYxOVpzN3FV?=
 =?utf-8?B?VnpWMkMvSnlvcXEzQTE0RmxMU3YyK1FGM0NEWnpOZXo4ZEtYUEsvT1hQYkpj?=
 =?utf-8?B?YXBQeXlacjlJZVNZYTRpM2d1VTF6Wk43Q0dpczB5UGZ3R1VRMlI0NzQ4OS9y?=
 =?utf-8?B?L3FMcyt6VEkxeFVGRmJaWXVESSs4cGxKUlRWWWFJUU1xSFNYVDN4NWtvclp6?=
 =?utf-8?B?NmlPWUhVblV0ZWczSnFHUm5wbHlHRVl1VE9hejZTd1hXcFZVREhRVzZjVGIx?=
 =?utf-8?B?dDYyMjVZVWpSLy9DWFM3eWIzZzJDZGdFMDFueFlBcVpuYjhXZysrRW1OSjh4?=
 =?utf-8?B?c2V5UG9IRG5OcEZQUDIxTXM3Mm5BUHNoa2hrbEkzUUNWU3pIVmZuVDlEcjB4?=
 =?utf-8?B?SThWTERpRjlBbzJGMzROcEluRkx4VkVJVkwwT2hPa3JiUFBIb0lmSVZ4Vy8w?=
 =?utf-8?B?Snoyc0FxVUNCTkdodmZDSkhPK0hyUndHTVgreDFjSU9qM2tuRjJXdmtFSWdG?=
 =?utf-8?B?RXduQjl6RDRhMUJMVDdONFYvZVo0a3hKU3NZdUZnajNMa3RtUW9QNFQ2K3J2?=
 =?utf-8?B?Qkp5UUlyc0VKd3kwYnJla1VVOFhlckhhYzFVdUxRM3VPSFRQWld3R1ljZE5K?=
 =?utf-8?B?aWF1V2NmMUxvVlNPSFdLQ25nc2xBZWxraTBibWJUR25Wck9tbC93Q25JRTB4?=
 =?utf-8?B?WXFITkNTOU1tVFNISy9IelBqQXRUc2Y4RmwrSGlMcVJ6MEpwRDR1Sjc4eWty?=
 =?utf-8?B?SVNYVjM2RUpyTjg4d3l1QUNlY3lXSXE5K3VXU3BDTFp6akVCYi82K2x0ZE1D?=
 =?utf-8?B?Z3QxVXpsWkh3ejhrS1JKR0xTV2xhMFlMam5jZXp0bndKUWpMUGNIWS9LcnZU?=
 =?utf-8?B?aEk3bHRRRmNMbk50ZTAxLzVKeTVBMnhlSEpqbnhpQmVZQXZRaXBBelpDdjVD?=
 =?utf-8?B?WUlVdTNxNVBsQkY4ZmI1RXN2eDlZbDRXbE51OTdDRjBsdkxFZW1RbkkvZm1I?=
 =?utf-8?B?MmM3S2sxNldwWHBEYlBwd1kyQWxnMDNaL3RUZmxNb1FWcUFyeDljd2pRTkJB?=
 =?utf-8?B?cWlKdW1sSkpUWSs1YTJDRFhlM2NuNWVDTTFzTHJ5cE52KzJmemxlS2FYMzFZ?=
 =?utf-8?B?THVyV01NUVN0N1I5ajJwSGhFQTJnS3lFM2ZHT1lQREN2NXljOHAwSDdxdXN2?=
 =?utf-8?B?Wm9ha0Jac0dKMHExSTl5R014dVBVUE80OUg4cmxVTW0rNGJBTmVWcmJSOXpw?=
 =?utf-8?B?V1AxR2MxSExZOGJsVXJSa29iQzdlVUpWNnB2Rjl3YWk1T204M3kzZzAxbXJ6?=
 =?utf-8?B?NUFxanlQdE1JTnVQSHIxVVJlUlY0dEhtL3hUb0xvZ2FGN1BOeXFVMm9WM2xk?=
 =?utf-8?B?V3JZbkhJT2ZIV0YzNWtuSy9Rd3pEWDhDU0VPRFZrajl2dmc3NmlndThoV2xi?=
 =?utf-8?B?ZFJCMmwra1pOS0xvRjlOd3BYNnVRc1I4ZVFnL1BBMFUwQ1J5RitselREWkNr?=
 =?utf-8?B?bHpXTXVmWCtDR21JQmVMYll5RkpqVHNRTmpSREdSMzJUQmVsRTAvWjN5UlAw?=
 =?utf-8?B?aGxmVVdGWnltNldYbFVrc1Z2ckt0djJQb1pzREdROG9EcGdnWjBXU0lUQmE0?=
 =?utf-8?B?S1orQlJXRGt0ODMzaTJnVEh1K0lCbmR4eVhPeFkybVdpaFN0TGJrWHVvV0RH?=
 =?utf-8?B?eGtlQkY4RlVHYmdvcFRSUlhub3Rwa01UeFJKaGdxb0E3U0wxT3BTVUZ4elhu?=
 =?utf-8?B?MFpOSVJIUEJSbE91NmhzZ1dtNFo3UmN5MFRPak9OSExqWW8zelVkeE1tMEt3?=
 =?utf-8?Q?o7wijORDGxmNQ/bPrvdeS2fD3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f12493ea-f6b5-41c9-0bd9-08dd3ee37646
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 15:01:22.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uD5OAeSLTbq4JMG3Qb+ZLbus4/ToYTr8+Bc+LTTxEk1DfYmKs+SlIctwiMx9azpJoLsMs7+/WMD7l4FT6xRkJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8323
X-OriginatorOrg: intel.com



On 2025-01-26 12:18 p.m., Gal Pressman wrote:
> The sanity check that both source and destination are set when symmetric
> RSS hash is requested is only relevant for ETHTOOL_SRXFH (rx-flow-hash),
> it should not be performed on any other commands (e.g.
> ETHTOOL_SRXCLSRLINS/ETHTOOL_SRXCLSRLDEL).
> 
> This resolves accessing uninitialized 'info.data' field, and fixes false
> errors in rule insertion:
>    # ethtool --config-ntuple eth2 flow-type ip4 dst-ip 255.255.255.255 action -1 loc 0
>    rmgr: Cannot insert RX class rule: Invalid argument
>    Cannot insert classification rule
> 
> Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---

Thanks for fixing this.

Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>


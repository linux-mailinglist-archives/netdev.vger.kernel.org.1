Return-Path: <netdev+bounces-129399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0008983A8C
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 02:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB58283D1A
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 00:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C25629;
	Tue, 24 Sep 2024 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdJYkocS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A518D;
	Tue, 24 Sep 2024 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727136647; cv=fail; b=CdA15MKr55JF5R1lCDgmbZP9p7N8ONR+Bllbc/L/UaU22+v8Sq+pngPAj2dpAUZdcmqgTAe9hoLSPcg2UXbHOGw+JSoVu94uBNqBiSegM/qBjxKCrWZmeEo0gz/YQ4vwhP4w4VRIlx5qXm78hWHr+J0ooogPqEcaoYRZPefjZys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727136647; c=relaxed/simple;
	bh=DKUYXzf5IYIakG6jOoZ7NOB1u19K7e8giTYBFvLWmns=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uk5HeC0sUxL1MqMaS0LgvD2/dpAgN/Nbf2dyIRQm3zpikB/SQTHXESNMAGcac7yiizF0OqEx7v1Vr+bmJ5vqegkSY6ZUdH42mDjxO/hq8S7wpwvmghA3rjQRpDFxHrZWaCWGAUGQ9RfBgArolwo1Ajq3fjFRRRR3hr6O4nylAJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdJYkocS; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727136646; x=1758672646;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DKUYXzf5IYIakG6jOoZ7NOB1u19K7e8giTYBFvLWmns=;
  b=MdJYkocS83dCOdu5KHmDuusBwFDRUSMOfoO9p1pqMbYou9frxf05zVq+
   th1LckgOutNLU2qUtuA5hnOoJc5aXGq8UZMgQ06Hy7dR6U14hqdnVtCn1
   qvS8f8Xk/9WoOAt8Zl6fYy4UZE953BiNa0H7EOIhBhtSEsVcyv533LVaI
   vUgHuiKHIOfiVRw5J0rYPl18ETIZ/K0Ac9wfFpK24Tt0ihsFxZPbfF6F3
   7LCFEw+VNOB1OdKFKMgtiozpUnhjd3CxOI8RoPoZB383ZMKSlgu8DoepN
   RWgTevqUoraxlmHgGoYMAMUQO08Eh4R4z3/7iFJVU/DKSH4/OPgTQeMan
   Q==;
X-CSE-ConnectionGUID: p8e+YgJoTrmLL6Jj7Qmi9A==
X-CSE-MsgGUID: iLg/WArqQjSJ/aZScxVUjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26204902"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="26204902"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 17:10:45 -0700
X-CSE-ConnectionGUID: kFFKF7MsRkmtRXpI+NDsGA==
X-CSE-MsgGUID: VHSjiLtNQf+VtovFirW1Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="75625266"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 17:10:44 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 17:10:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 17:10:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 17:10:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 17:10:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 17:10:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjKwcW44hDQ/vjCxYWfvOXZlesYibqJ4h2sLjtFZcoaN8CYxcRk30G8s6/ZJfD+asOjQKzY01EBbe+9S6QD1R1fZx3SPpXw3ICc3meOWSL7nR6m2fnJh7LXYnHTXlmlBo8IAppu4svBpVjf8Qn5HodCxSJk+VdTd6aveBsDYLoOgk4T65kRVKq1BJwyhxKmT/xOkbAskMJC98ppYuB1waUMJbjhX1mRv6qbS9cGlxDpL38P8Vvos4UFdd27EJdh56II6Bfe9/Fy82Lzlf6N2GfyvU6ruGOUPgfA2zOWad+Dztxj6vjqGT/NRrhfNWDBevgM8RAV0k4qXoBZSnE4T4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnlwznuxA7rsBOxnV+wL2OcVMos2K9iu41YLcGGVtXA=;
 b=BYfaXZMPsnv4Tu1IH7Frg1I2gM/CywxMdXUUC8Bo9mekghkAj+SbcEjlroWzKvw+Ujpu87zKcBGb+rVhwAHTv9XyNHxfKZXy4MOiz5rRVzJNy7bUxhL1EUexxitu8oliDdah5213rnok/CQ9pKDLFR15Dhb4nEsFSwUlwBk4lt+STD39qZplzzt8oPLIVEe/Hq1ityozjL2wtn8pT9Li6psUqn8xfjpklHqaSZr9hNCBj2Gw56Fhbjz80nMCIyP5w4LZhSlCFrn6LF5t4lILAS2U2HY7XdjEqWImpnzpM/tPhO9zGPOA8A9rXwwO1floHbbu7OSjTsYDPg4yAQEtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM6PR11MB4756.namprd11.prod.outlook.com (2603:10b6:5:2a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 00:10:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 00:10:39 +0000
Message-ID: <847a2c45-782d-4cac-9a53-83557393af80@intel.com>
Date: Mon, 23 Sep 2024 17:10:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] igb: Do not bring the device up after non-fatal error
From: Jacob Keller <jacob.e.keller@intel.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Yuanyuan
 Zhong" <yzhong@purestorage.com>, Jeff Garzik <jgarzik@redhat.com>, Auke Kok
	<auke-jan.h.kok@intel.com>, Simon Horman <horms@kernel.org>, Ying Hsu
	<yinghsu@chromium.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240923212218.116979-1-mkhalfella@purestorage.com>
 <2c272599-6b25-4c93-86fa-ecfd8df024c1@intel.com>
Content-Language: en-US
In-Reply-To: <2c272599-6b25-4c93-86fa-ecfd8df024c1@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0203.namprd05.prod.outlook.com
 (2603:10b6:a03:330::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM6PR11MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: 18958e47-818c-488d-27b3-08dcdc2d5251
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXN6VTd5UytyNlBpNS9lWURkNHNNRHdBMW1jLzBRbmVzUThHdXA2TU5aNUY2?=
 =?utf-8?B?eHd6Z3RtK2ZPYk5CODBoYWFJeHY1YmhDL0VFdXdRZVI5eDJ0MUxMUjNDdyta?=
 =?utf-8?B?KzB3KzRmZkQvb2o0dXJGV0Z3RkJHc2Q3QVJTc0ZBNUlwTnBKTXB0aVVvS3Aw?=
 =?utf-8?B?T0c0MEpNOUJHemF3UkNCNTdveVdmNmM1aDBSY1M3aUg5TXVWSlNlU2w3RFVj?=
 =?utf-8?B?NERNTU9SK1EyNENxOFV2Ry9HeHdjOHdGaXd3M3RxU3VkYmE1WTRXdHIwSVhI?=
 =?utf-8?B?L2cwdnA5dmZkOHZaWWNjVDNORVJsdmtVMHQ1a21uUWdTbktrbC9DcFVGZFhJ?=
 =?utf-8?B?QUFycEUyWGJ4Z3A1dmtKQ0F1ZWNwMU14TWQ2d2Q0ZkhNa2ZFN04wWHk0bndx?=
 =?utf-8?B?Y1VTcVZ0N24yYVVJcDlPNGlhczRTYkJPUFBuc09LbEVkamRLSDc0L2xWRmVO?=
 =?utf-8?B?cFVSQ1RhcStwQWJZaDZ0OGt1ZWx1VjVLMFZVa0tBZ3JDeHBtclBaek90TkFi?=
 =?utf-8?B?K0ZnVU9hSTExaXdVc0d1TDF0MWRHaGUwcWZubEIwUytDWkx4VitMUXp2S2Q5?=
 =?utf-8?B?aUh0WW44bkVyRVhDTTB3bG1jYjJGVmVVQi9BdFNEVFlHUnA3UnVFbStUbXIy?=
 =?utf-8?B?NHRFdTluSUcwQyt1c05XV2RpQmdmK25Cai9wcktPL20zak9jQk1QMGdWUXhr?=
 =?utf-8?B?cFhZcU03WFdXVDlRU2Fia0Z6NkhJWWpRL2NoeXl0OHkrVzJFTWVCSUZNT2xF?=
 =?utf-8?B?dkwyb3RoVCtkTHBwTUt5RUYvc3FrQ25vUWJtT0lTQW84N2tyZTNjVENwNW1O?=
 =?utf-8?B?bFJycHNmMERYZ3FQeHU4eGluVC9KY1FOc1FHaTdJUE1hb3V2dU9Ea1pYM2dQ?=
 =?utf-8?B?ME12aGo2a1dWSmZjdjZiTityM1VWRGFtaG9hQytlbDJvYmdwd2tFdzJ0b0Fi?=
 =?utf-8?B?clpkeEVTZWd3dXJmejJadlo2NUFKN0RaS1llS00xdm1hRHViTG9YVnRMV1Vm?=
 =?utf-8?B?OW03dUhleDlGTGhmWWt3TE9tbkJJcmxYOUxVWFQ5c3lkQ1BNMk90eGlnZWlr?=
 =?utf-8?B?Ym8zS1Y1K01ZZ1J4NFFOenVXcEhheTRjdWEwblZucEtQeXhJRzhZQWFOY2Nw?=
 =?utf-8?B?cVg0L2E1WURaUTh6MWFpWHljdHlPbnU1Wi9pL05rYVhkTGF4L29JRHB0N3Ra?=
 =?utf-8?B?QmVKamVlekhuNG1Pb1pCUVJqL3pHMGNJUnJJR2ZnWHFyblZ5VUFBL2ZHNjl2?=
 =?utf-8?B?UW9FQ1kwL3kxM2RSaDZOdXZZWGU5cjRiaVR2d2U4NDFla1hlZHFDZVpOaEhO?=
 =?utf-8?B?Ukc1TVQyc0xlbXU4K1lZV2pYTzFWR0NVLzUyZlZyUUZqSEhXaVRMaThQdTJa?=
 =?utf-8?B?Yzc0L3pNcjM4UW1DcXhlN0hSNjY0Zy9FMFZJU21wblNsQkp3VFR4SjRhdk15?=
 =?utf-8?B?OGRkaURiZVdvakYrYUFoYnhiRGZJUEJ3VXdIaldkK0tGdlA0cTB5MDIzNXhp?=
 =?utf-8?B?enZrSmxrUXkvWEJyendnMlU3bW1KaEVxQVRWR0h0Y1d4eFRWa3VvRjArdjFr?=
 =?utf-8?B?cktycWZxaFpKODYrb3grS09ncm14Qkg4cTNDRkl2WmdkdHlQNGh0alZBdkM2?=
 =?utf-8?B?S0FuZE5rVnZNOTNoSjVGRm51UnZzNU1rVWUra2tWdUdtc3pSLzY0b3ZEdnlm?=
 =?utf-8?B?a2JJWllLWDlqMkVCQ2t0WFJiajdiRXBTZGtaRFA4alpkTTdmMThOV003dDdw?=
 =?utf-8?B?S3VQWG1JL1pSSjBITHA2aGVCcDVOVllVU00rUkFzMjl4bkNNSmVnTUIvM0N6?=
 =?utf-8?B?d0hFVU43bjdzOE15MUlQLzdsSm1oZFo3cTkreEhyb1I4cUJ5UHdJWFZteUJM?=
 =?utf-8?Q?emAuhIhbjSYWz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUZlaDdiWXNGWWw1Y3kvUFFwdUE5SFF5bENoM0ptQjRmQy9ubHI2dVo3RU16?=
 =?utf-8?B?RHJpOTU2R2NJVDlQMjhNSmQvWnl5eHBiWUxPbjY2SGF2V0xjZk1xcWVjVUp1?=
 =?utf-8?B?d0h0YnhLVmZveFlGZDdMNHFCQTNPek43RlZhSE5JUmFWMzJWQjdDbStNUFRk?=
 =?utf-8?B?QTdLeEtHenVDQUtoQ0JqejZHc3pPVXpsWlJyTFp2a0pVdDF4dEI4U1d5dWl6?=
 =?utf-8?B?VzBlOGh5V1ExTXNXYmg2THQ0bzlpZnFPZXhvQnBJcmk5OWxMdEVXa0tUdjBp?=
 =?utf-8?B?VWF5cVc1QkdJSlZNd21HQVdMU2dsc1VRZVZ4bGQ1WU5vOXVRbmRCK2cvbHU5?=
 =?utf-8?B?V0tjVFpwL1Q5Q1lFM3dnelgwd1Vab1pCU085eEJSbHFtLzFSR1cwRDB3aDdY?=
 =?utf-8?B?ZFNvZ1B5NlBhWlNOQ2poYkFhM3hhSHdXaWowczQzNldmQndFVnlXdTVkclQ1?=
 =?utf-8?B?WnFzekhsalZZbmlrSFdLdm9QVHV4U1QxVXRCd1djcWJqZmpjUGtUR0t1MWFr?=
 =?utf-8?B?QzNvVy9IanlFVjhxWGVIdTBQdlpHY3RlRmROc0tJY3FuUFhlTGZyeWdzR1dK?=
 =?utf-8?B?OGtBVDlIM01JSFNmOUlHd2I4cXN0VXpEbzVweDlLNHdSNTNMd1VEYmsyYW9X?=
 =?utf-8?B?aWtudi84aVhLZnRBOWI3TkxQd3VUNGtOTm03VmNFL3FYV0Zad1VTZFRucjRU?=
 =?utf-8?B?N2poWDVJL3NGYnYvL0hIN3VaRTJFTWNJVmxRcVNsZFYrTzNERXFCN2ZmS1p3?=
 =?utf-8?B?STlsdnJRWmRBNENocUhySDltTzhPdFZXU1VOaWxZRXVoUlRtcjNGY1Y1a2xZ?=
 =?utf-8?B?Uk1aclVqa0xPL0hIMzE3OEVLSU5WRk9JaUh3WGlkL1RXRU1jRHNSQlhab0tM?=
 =?utf-8?B?UEJ0dUdiVE1uSWVLdVFIZ01DcUFhNjRjMVN2blZmZEdsSkpMaUd3NlFQZHpV?=
 =?utf-8?B?Zi9za2hkTWU4YVVvZVhRU0cyUXE4SHBneW9CK3lUTGFpUGZSZ1lBMmlMQzhY?=
 =?utf-8?B?Z2NBV244NG42WHlRRnhDbURXb1JZUGFwMlA3TUFDVDY3WUR5bU9Da2srNFh5?=
 =?utf-8?B?anQ5SGZreFV3a2VJTGxKOFZkZlZZbCtUSjdvbEFNWEZ2UWVJQi9ObHF2eG9Y?=
 =?utf-8?B?OTcxZlN4N3hCeUt6bmdHNnp6R1BFUEhtRFoybHExZjJZT1RHK1VvYmN1Tm5Y?=
 =?utf-8?B?RlhuY1JidndzdDUvQ1RKVlBsYzVESXBVdDNYcFhqdDN3VHFHU0FhTkpBcXM3?=
 =?utf-8?B?TWtCRytSTHFXdEoyRkRaQTV5V20wdGpJUXJiTFVkQVd3Rk9ZU052Wlo2bVV5?=
 =?utf-8?B?RWlaaEltcVlOMElSWkgxYy84TzBhVFFOUkVZNWUxa21nOXJaSk9Xb2NQZTJ0?=
 =?utf-8?B?blh6eHpWR01CUVZiZytVTEVLMmxBNDVlcVdja2NwS1NBOUdpTDNyS29HSHBU?=
 =?utf-8?B?VXBmTmREVjI4bVU4U2R1SGJVZEdOSlQ4UnhXN0NzMGl5bGZoQ081VEljYktC?=
 =?utf-8?B?cWxyYlBtMW5Sbkh5RlUyVGdrVkpNZVpzc1IrNjRYaHhvRlR3Q2lNd0p0NDQ2?=
 =?utf-8?B?MXFqcVhMNVZtek5CNzkvUUZ2cmJNSUhtaWdMUkd6QllISWt0b21LVHFQQUJB?=
 =?utf-8?B?U2ZKdWhvZ0tUc0FONEN6VU9nZGppNXRLWmx1TFBOalpPVWIvQk5MK1FNZFNP?=
 =?utf-8?B?WGpJZ2U0T1poeUpTcUpYRElKVlhSSERjN1RRRWMvQzdXMTVzenoram5JdWlQ?=
 =?utf-8?B?Z0RqZXFxY0Y3YkRPdGU2eFJWZ215WFdNNzFwNEJIY05kcWYyV2pqdHMwaEFy?=
 =?utf-8?B?Z2pyMzBOcDBJbDc4aUgwQlFlbW0rTk5Sd1doQTArSWVpTU0vcmN6cXI5S2Fx?=
 =?utf-8?B?eXU3VUhSSlVSdUloakNVMEVpZ085a20zZmd4aDdGZkhzbUtuN0xBL2pVajN6?=
 =?utf-8?B?Q0Z2OUxEVGZZY1ZMRHpJMm83SHh1Mm1SSlBSbTFwS040eVBaVEk1S3A3cFVy?=
 =?utf-8?B?VmQwWXE3Q1BBQ3hERXNpbHhoMDBWLzhFeXdPQU54MDc0Q2lpRmIyZm41dzIv?=
 =?utf-8?B?b0dRdUxoMjdWRi92RmJ3eml5REErVW9LK0ZaQThzRnNoeHJVbndqZW92OThP?=
 =?utf-8?B?U0d1V3JwSGVYOXFEbmp6Rnc2NmZWdDVmRVA3aEp5STlVMkRkQzlCZDdnNWxp?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18958e47-818c-488d-27b3-08dcdc2d5251
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 00:10:39.3842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QUM0KJKAfXQsNPC9y6q5DaXQW/xg8pWO2bN3gvbc+3SaCF5h7NehlFKSpNg/KI2JvFBd1HNVP/ynkhKl5lNTQj06x0Ua23b5HjbhSZ89f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4756
X-OriginatorOrg: intel.com



On 9/23/2024 4:11 PM, Jacob Keller wrote:
> 
> 
> On 9/23/2024 2:22 PM, Mohamed Khalfella wrote:
>> Commit 004d25060c78 ("igb: Fix igb_down hung on surprise removal")
>> changed igb_io_error_detected() to ignore non-fatal pcie errors in order
>> to avoid hung task that can happen when igb_down() is called multiple
>> times. This caused an issue when processing transient non-fatal errors.
>> igb_io_resume(), which is called after igb_io_error_detected(), assumes
>> that device is brought down by igb_io_error_detected() if the interface
>> is up. This resulted in panic with stacktrace below.
>>
>> [ T3256] igb 0000:09:00.0 haeth0: igb: haeth0 NIC Link is Down
>> [  T292] pcieport 0000:00:1c.5: AER: Uncorrected (Non-Fatal) error received: 0000:09:00.0
>> [  T292] igb 0000:09:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
>> [  T292] igb 0000:09:00.0:   device [8086:1537] error status/mask=00004000/00000000
>> [  T292] igb 0000:09:00.0:    [14] CmpltTO [  200.105524,009][  T292] igb 0000:09:00.0: AER:   TLP Header: 00000000 00000000 00000000 00000000
>> [  T292] pcieport 0000:00:1c.5: AER: broadcast error_detected message
>> [  T292] igb 0000:09:00.0: Non-correctable non-fatal error reported.
>> [  T292] pcieport 0000:00:1c.5: AER: broadcast mmio_enabled message
>> [  T292] pcieport 0000:00:1c.5: AER: broadcast resume message
>> [  T292] ------------[ cut here ]------------
>> [  T292] kernel BUG at net/core/dev.c:6539!
>> [  T292] invalid opcode: 0000 [#1] PREEMPT SMP
>> [  T292] RIP: 0010:napi_enable+0x37/0x40
>> [  T292] Call Trace:
>> [  T292]  <TASK>
>> [  T292]  ? die+0x33/0x90
>> [  T292]  ? do_trap+0xdc/0x110
>> [  T292]  ? napi_enable+0x37/0x40
>> [  T292]  ? do_error_trap+0x70/0xb0
>> [  T292]  ? napi_enable+0x37/0x40
>> [  T292]  ? napi_enable+0x37/0x40
>> [  T292]  ? exc_invalid_op+0x4e/0x70
>> [  T292]  ? napi_enable+0x37/0x40
>> [  T292]  ? asm_exc_invalid_op+0x16/0x20
>> [  T292]  ? napi_enable+0x37/0x40
>> [  T292]  igb_up+0x41/0x150
>> [  T292]  igb_io_resume+0x25/0x70
>> [  T292]  report_resume+0x54/0x70
>> [  T292]  ? report_frozen_detected+0x20/0x20
>> [  T292]  pci_walk_bus+0x6c/0x90
>> [  T292]  ? aer_print_port_info+0xa0/0xa0
>> [  T292]  pcie_do_recovery+0x22f/0x380
>> [  T292]  aer_process_err_devices+0x110/0x160
>> [  T292]  aer_isr+0x1c1/0x1e0
>> [  T292]  ? disable_irq_nosync+0x10/0x10
>> [  T292]  irq_thread_fn+0x1a/0x60
>> [  T292]  irq_thread+0xe3/0x1a0
>> [  T292]  ? irq_set_affinity_notifier+0x120/0x120
>> [  T292]  ? irq_affinity_notify+0x100/0x100
>> [  T292]  kthread+0xe2/0x110
>> [  T292]  ? kthread_complete_and_exit+0x20/0x20
>> [  T292]  ret_from_fork+0x2d/0x50
>> [  T292]  ? kthread_complete_and_exit+0x20/0x20
>> [  T292]  ret_from_fork_asm+0x11/0x20
>> [  T292]  </TASK>
>>
>> To fix this issue igb_io_resume() checks if the interface is running and
>> the device is not down this means igb_io_error_detected() did not bring
>> the device down and there is no need to bring it up.
>>
>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>> Reviewed-by: Yuanyuan Zhong<yzhong@purestorage.com>
>> Fixes: 004d25060c78 ("igb: Fix igb_down hung on surprise removal")
>> ---
>>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>> index 1ef4cb871452..8c6bc3db9a3d 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -9651,6 +9651,10 @@ static void igb_io_resume(struct pci_dev *pdev)
>>  	struct igb_adapter *adapter = netdev_priv(netdev);
>>  
>>  	if (netif_running(netdev)) {
>> +		if (!test_bit(__IGB_DOWN, &adapter->state)) {
>> +			dev_info(&pdev->dev, "Resuming from non-fatal error, do nothing.\n");
>> +			return;
> 
> I'm not sure this needs to be a dev_info.
> 

I was thinking dev_dbg, because I don't really see why its relevant to
inform the user we did nothing. Seems like its log spam to me.

> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 



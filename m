Return-Path: <netdev+bounces-217684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1255BB398B2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC691C828E9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADC82ECD3A;
	Thu, 28 Aug 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhOh9q4I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F40F2ECEA6;
	Thu, 28 Aug 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374431; cv=fail; b=aPID/XWGhZYd41ZQTpYh1wROy1Uhzqg5Z/BZpUScGjY54N1Z3ZC9d1+uwJJ8bpEOh6i59eHan4xb2LHQdaDyirr62vIWNEE8bLGiv1GlxOfU5ZvD0Q3fXjfBtIhLJBwyzB4q01w3VamnZumgjcHDSlRlxqM5u5pNnKHLogAVhrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374431; c=relaxed/simple;
	bh=6phb6ApcFtscGWltEhIs1e9nltCKu0rKHxjssfvA7xA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gpSAlymGtSplymr/BhaCmj6LmSuuyMspKOPaTWOdbVf1LIXpZ0eHrdZakBLt73rEs2/nAlB+Hgghz7wIS+hMXEYBt/r+n0/Imf2lE1HuhjWq6/MM0yeoW6mqAnDlin9jcza1K6zSpbs5IwkI63uSEcwV748VCG4T8w8zGKYLVSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhOh9q4I; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756374431; x=1787910431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6phb6ApcFtscGWltEhIs1e9nltCKu0rKHxjssfvA7xA=;
  b=hhOh9q4I/8FGGtARDP1OG6kaN/6EL0+ANZkd1yH48S1U6mydMxqLeDeA
   SMJ9hS3ck8qsRM3TZTUaDjgvpOQAO4htnwLy6rbctK/pjAwxhL20feuRr
   Q5I2EEKRZjivcvY2romiiKz9nBHZLQsMcNLjwJibh5nTM7C5Hdluxk673
   DEoNZkXyxa1jDqqh2tGNxXl/M8d5rg+2a0noZZFNDyuISyIxBEJDWHs3K
   HO9lQk026stHRfJnk7DHR7EMiuKEkzOzh6UjlNP5RBwjrQ2b9kQE8jQar
   F8Gch4h0BepZt73edsThOyaEt6o+C8zARlH6wdDSUVKvaxB9hEjeUlYM1
   w==;
X-CSE-ConnectionGUID: vGZ7bj8sTK2BlxexsGt4GQ==
X-CSE-MsgGUID: WzToC8GHTnOxx72mBhpMuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81231916"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81231916"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 02:47:10 -0700
X-CSE-ConnectionGUID: slCVMdXTSqqKzd+bBF6qEg==
X-CSE-MsgGUID: CiMELWWpRfW189aoQ7mBCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="200980507"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 02:47:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 02:47:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 02:47:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 02:47:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoE8xZNrdLhtDA+hTJHAAlol3aM/Fqls58RCDGejL0VXB8NEjWrWbYfEXo09VRZo0YnTa/+iEFhL+SpKkSLsNsC7Qkm5CM+zrFqpWLXiVwuELUDd4/rDpgadxnZAuwL4Kk05/VO94ovcler+xGxMWYmZ75rAIIHFHMC6rFUQEXiHEnHdNW4q9FgvDG8428MjmBhcWLlvR3tlKCvzAhTOj+6jN+8tLPrI3+FK2uq3w9vaicuNA+d26fCxQhnIONQDVTXzzBlOjhChZbp5eFD40o8KxDYLpiHDCHqX3665FtoSbcNfOTnDs7yIfUOkychlM9shNjWzKwSrt3ukO9rXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6VC12gkXjTC3BzxfaZ/VrT6NwOfA4yv3nzjYTSkKHs=;
 b=ZPac2xvyfYskcF9qNKY4hxgpJ/++7ebuUHwO7h+5WJupCqRoIZPAxpnaSfdOiv/uRbfFXrgR+d56tJPJtGc1laeBh75j/BY6dWy8Jkkris7Ud7lPL0JplZIY+Gn8lrdiOp7UKxnwFH9R5RUWArOUuLyHRL8ocj9SfnLlcgsYRajUItP5Bx0bswU+Ouu0eOBLhAkP/34NZPVz6OQ3aoCOKFaMiLVEnmEi87kBZMzjTT4EftAd8TMrMeEl39MJOcMgQmg6/oj/3drkBOhdbS9yGKbQYAXTbO7tYf9oLrb89gzbaozKB5i0kKmgZnaqXYUn0bCQhTUIsmUSKF/SErrRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16)
 by DM3PPFAB693A2AC.namprd11.prod.outlook.com (2603:10b6:f:fc00::f43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 09:47:03 +0000
Received: from IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10]) by IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10%7]) with mapi id 15.20.9052.014; Thu, 28 Aug 2025
 09:47:03 +0000
Message-ID: <4fc29d26-14a0-4295-b82f-48e21b376f49@intel.com>
Date: Thu, 28 Aug 2025 11:46:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] net: stmmac: add TC flower filter support
 for IP EtherType
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rojewski,
 Cezary" <cezary.rojewski@intel.com>, "Basierski, Sebastian"
	<sebastian.basierski@intel.com>, "Jurczenia, Karol"
	<Karol.Jurczenia@intel.com>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
 <20250826113247.3481273-8-konrad.leszczynski@intel.com>
 <20250827193710.GT10519@horms.kernel.org>
Content-Language: en-US
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
In-Reply-To: <20250827193710.GT10519@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0027.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::18) To IA1PR11MB6443.namprd11.prod.outlook.com
 (2603:10b6:208:3a8::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6443:EE_|DM3PPFAB693A2AC:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd91c8d-857e-43a5-17bf-08dde617d767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|42112799006|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rkl5eURVSE50Qk92ejR3L2FGYStQZGhtbVhxQk9sSlY0ZEtnRi9tMnA1Znp1?=
 =?utf-8?B?d2ZQaDh0cVhXYmIzcTlnMW1FQXR4UXk1dmlJVWpZL1NvSEp3UllUQ0NGWjB5?=
 =?utf-8?B?VXMxM1M4QVNqQjNMS1JIOEgzMFlzQ0VsdkU2Y2xyOTVzNXA4b3dyRU5xN0F0?=
 =?utf-8?B?OW1KalNjWVRVcW1BK211SHY3OUU1U2RyWUxqWldDZmVYV0ptbUNEdHhZdjlN?=
 =?utf-8?B?R3dhUzlWeWJjNHUyMlRWNFdjNndYQzBkS3JUQWhXWlNvTWF1QWVGV1pVOGlN?=
 =?utf-8?B?OHp5djcybkQ2cE9jaTM4YzRWV2hubTZBb3pjRzJYczBtOWkwelhIZ0FhYmZJ?=
 =?utf-8?B?QkNJdDlZOWxORDFQaG9SWkEvU1hvSC9YU3JiaGtBY1Yzei95SkxhZTRSVm1O?=
 =?utf-8?B?ZUZ4Y0Q1dlBKYklGVzl3UXFUY3JhVkFVenRkU2tubHczU3BkYzBNSDhWdjQx?=
 =?utf-8?B?a2JXYXRJdFptWDI4am5nb0d0bzdrdWhyWUFkUVJlNnVDWHV6dUs3TkJ3MjJD?=
 =?utf-8?B?RTZMTG80dUYrTnd4eHlCckV4am9NR2J0VXZiMUthd1FyVjhyQkNPNEd4d1lU?=
 =?utf-8?B?SUxCd3F5OHo0M21wQWlPMXRUaWd4Wk5rWEVFa1RvNGxmL0hIT2RVODFkOFhp?=
 =?utf-8?B?MWJreDNzV2owSTd6OEhqR3FjeEFTSjc4WXVKQ3V3L2F2Q0VGbjl0T3JIbmhY?=
 =?utf-8?B?cE5JOHc3QmJXa3B2Qk9hK3lIeWNyOXVpb0JwbW1KQWIzSHpRZnVGRG52cFJR?=
 =?utf-8?B?MTVuZVh4Zm9RRllsOVBvaGR6T1k5dEFLOVRlcEZXQTk1dHcxRkl6ZnluQkdZ?=
 =?utf-8?B?MXE2ZUxWSG1DVWtVSnNRRGJldUJpblZyTFdtUmdYUlFMeVFRemVsa3FKVWdR?=
 =?utf-8?B?QnRLVUJiQjZhYWM0TTBPNnMzeTNYazhmd3ZPeG9QMU9zaTJrdzNmS2IyZjJO?=
 =?utf-8?B?R3lIbTByRk9qVkJpSWczVHJZNWo5Mmp2MDBzSThyVktybFI1MVl6UHpVdXFJ?=
 =?utf-8?B?SnFxT0paY2RBR3ROWFhZRWgzYlN6ZEJQd1NCV1pZR0puZHR0RENFSWJDbWtl?=
 =?utf-8?B?VDE0eDRkZXppTUVxelhHWEZVOTJoZ3FYZEp5VDIvVlk3TTd4QjhKWHhkRHRh?=
 =?utf-8?B?VkdNc1pZWUZYZExjN0xSR242WFF6WTlsTjYzN0FWaEt4VzMxUFhCc2sydDds?=
 =?utf-8?B?clRoYVpKMHZUbWovbDBqUWtmdzhDYllydy8zb2hmOWVRV0k0bjRYcndZbFJJ?=
 =?utf-8?B?WFBRcHp3bllxVjdydzEybTlkaTBpQnVoWTdJTFZpSmhnaFY1ZzFlM09DUGNK?=
 =?utf-8?B?Qy8zMjR1L2lCU2RSTGdSeXpZbUF5a0F0UUxzaUl1cUJhWVAzaE9KWWpSdTlH?=
 =?utf-8?B?Y3lDOEx1NWVXWER6OFJWay9ESGJwblB4ckhjcmRucHZrZGRtdUtRTHh2R2ZO?=
 =?utf-8?B?aFZxU1FOYWZpU0U5YVNJdXJSaDRsTEdKSHY1b0hYcDBpNkUzOThKeExLVTI5?=
 =?utf-8?B?NW5xMlJ4UFZPZHNUdEpjNXNhVW1Ga3VUcmMzclRCYTI4OTJsSE5ENTBqcGVw?=
 =?utf-8?B?Z0lFSERMbEh0YStyNEN5ODZHOHZlbFBsTHY5ODMwVmlXUzQyQlVESjZTRXRN?=
 =?utf-8?B?UEpqcWpIR0JvYjRkcHJZVTlLc05HU3pTSU1TZDVhRm9yamhsN1dvdVBacnp2?=
 =?utf-8?B?dlllNnNaMHNmS2NwSXgxMnN3akROSE5ucW54dE5Id21PREVzeWVwekJSdVl1?=
 =?utf-8?B?QXB5M0xXYU5QTGVZeWhyRGxlME5IWXd0V0k3Z0pZTFBGbktGdzdYR3Y1M3pw?=
 =?utf-8?B?ZU51SEFaME41NkVPTkVxQVV4V3lkc3M4M2ZPaDViU3prMFBHN1AyYnlzaTUv?=
 =?utf-8?B?UFpSTkgwa2VNQWhxRUI3ZGlNck5ieUZ5VTRvanIvcmEzckE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6443.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(42112799006)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXMvVy9ZYk1raDJDaWo0U2I1RHBkWVB2eDFxRFpKZUgwM1ZrWFZqMG5vK3Fu?=
 =?utf-8?B?SklTZUxhOUxxN3B2Y29zVUtZYjI3ZzZheHh4TzJNeE9WSTFCT08xMThlRG0v?=
 =?utf-8?B?R2NMemZqeGE0NzFHa0lJRkZyTVFWdXBxZ1QyTEl1MlRCN1B0b1lZRFAwbXhU?=
 =?utf-8?B?dWxvaWNsWmZMZ3lkb1NQQlUzNldCMXlRM01lNk1KaVEyN0lMODdIbnJ5SE02?=
 =?utf-8?B?QXAyQVoxZVpsVlR5TGpWdmVXNGhkMFB1dVJ0VWs3c2hSeFNzWjFWVUxUaDJD?=
 =?utf-8?B?Z1NLNjIraWtoV1IvL2Vrb2duaU9qa3BGTmZwc0ltYnBBR00rQWtjY3JFeXgy?=
 =?utf-8?B?MVpiRzIxSFc4YjcxOGx1dzVFTHFpa3dBV1E5TU1zWUV1ZlZPakhlcERTdSsv?=
 =?utf-8?B?T1FiZmhyZFN6ODRaaDR0bFdNMVpITGNTbnRkd3gxVmVUSFhrZERPUCtPdjVE?=
 =?utf-8?B?c3FRSkhmOVZXQVR5Mktkc1I1MU8zZHpDUXNQNVRYM0Q5R1djbXdQWkdtQlQ1?=
 =?utf-8?B?OVg4OU9hVnRsM0VibU5idjBETzVWeWkyYnhXLzY2eHZ3NnUwcU45Ty80b0d1?=
 =?utf-8?B?MEtqc21MRC9YSy83R2lDdFM4V29yWU1qN2ZyMFR4LzZxMktyU0NmY1dzZnkz?=
 =?utf-8?B?TldMMjhvTkN3L281Nm0yTEdYdXZoL0VhSTBBVG9YZ2VkY3dYQjNqWTVUb0Mw?=
 =?utf-8?B?cXhLVFJSVElldndGUnFPVGEvUC9VK2t1WnZtankxY0ZuWDU4dm1NeWxRSGNJ?=
 =?utf-8?B?UjJodFcvTjhQMzhDSlJlSzVqbkdZb2pYa2poZVhBRVJkbG5XVC9tZDdyU1VW?=
 =?utf-8?B?M2F3d3NnU1doUmYvQmVWR01yUlJLa2crRW1jaTRxY2p2QW10YmZHNmdGNWZa?=
 =?utf-8?B?bzM0NndDcXFscXBhSHYyMXdkVEhsQzdqdW9OaG1qd0pxUlBEY0VnSmh2L1I5?=
 =?utf-8?B?RFdQMExQMHJ4Mlg2NmI2MnNSbE1mcU80Y1MyOGU1NUg2bDJSTUZncmNaNlZv?=
 =?utf-8?B?ZG1Sa08rUEc2cytvMWRjOVJRY3JDNHZBMlRvRk40MWt6eEZPV3U5b0ZCL2pX?=
 =?utf-8?B?cEkwbmtoOFJxZS90Qmd1cXpzNTc5MjdzdzVvcEN2WnMxbWtOOXgybFV6djd4?=
 =?utf-8?B?VGhnNHRSTVVHN1lUSEIxeHhYdVhtVGpCanA2cjRzQkhGZTRpV1RsWHhBc3BG?=
 =?utf-8?B?MlU2THNkQXc2SnhuUDAya2xDYmRUKzZJNFRObU5ncDAyd2UyU3lpVElNczVp?=
 =?utf-8?B?WEc5Y2FsUEpaNndXN3hkeDl1ZlFQQ3ZleVZ3RDNCdVp5ODFjMXBncDhYNXYx?=
 =?utf-8?B?dXRuU0pvM1V1YXR5clNkWVI2eEExa2N4QUw4dHVPOEZPaGhIQzF5ODBBbTF4?=
 =?utf-8?B?U1NHMHVFc3dmTVcvZVZtYjJOeUJiYVJrN24wWU5qSFUwbEs2MThSbVd4dnZJ?=
 =?utf-8?B?ODMzTkU3UEJzM2xJSmlGWVd0bU9pRjE2M08wZUNCL0dRNmZoNjRNQy90MndT?=
 =?utf-8?B?TVFVY0JjM2h0TGlWd0ZhZmFmT3AyVnZvcnBkUHc2ZVI0Z25tVUxuUFdES0tj?=
 =?utf-8?B?WEFwbzV2QWhJQXZ5YTJTZGczTWR2NExEbjNGSVdaTlRPUXJjZGRPNlNiTG8r?=
 =?utf-8?B?VmRiak9NNFVWVHc4bGpndlQ5ZlZJMHNrRmxXSjZncS9JZTlaSTJBaHlpVWJo?=
 =?utf-8?B?ZHRxNGlya0xFdmJ3cHljOVNjbElQWlpkdW1LWXJ4VXJubUQxd2E5Q0JVTmtm?=
 =?utf-8?B?ODV0aEtGNnFVelJqUjhIcEtmckgyYy9wSGxhSDNDR0NBR3NVVGNjajdkdHBG?=
 =?utf-8?B?TE5DK3RRZ1MwL2dFS0d4elJpMkp0aGVYMENxK2xjWm9SV01rbEpTa3hHT0Fw?=
 =?utf-8?B?d3h6Q0FXYThkSzkxci8ybzVENFZWYTQvdG1oMVJDZW5uR0VRR0pXQiswTDIy?=
 =?utf-8?B?a0xGOUNmbDFlZnRNOFRSUlR2ZjE5TDB2aFlsVTY5d1RUYU1DS2FHVk1PT29Y?=
 =?utf-8?B?Zm9Lc1BuN3ZMdUw2NzBmKzQ4cDJTdkE4MzQxNi9jalloL2QrZFNranJrSlpH?=
 =?utf-8?B?M2h3SFJDclMzRE0wUGNTWHNSNkprOSt3UmFPTG1VU1RIS0N3MUk0U0w1QVZB?=
 =?utf-8?B?Ty9FVW1Jek9DczhVbjgzWlRxcnZvOGtYeVJ4T1pxOUg0THA3UGg0aTVRdUly?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd91c8d-857e-43a5-17bf-08dde617d767
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6443.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:47:03.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nah7fXKBEMivJowBp0YsJneKZwtxT9l1obc6VZNe0Umtz1MFPvGVEG6U5m0cBVuVl/Riyq4LbQK5x5FGykECuLhTZL+mJViwHqq1c0aIS2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFAB693A2AC
X-OriginatorOrg: intel.com


On 27-Aug-25 21:37, Simon Horman wrote:
> On Tue, Aug 26, 2025 at 01:32:47PM +0200, Konrad Leszczynski wrote:
>> From: Karol Jurczenia <karol.jurczenia@intel.com>
>>
>> Add missing Traffic Control (TC) offload for flower filters matching the
>> IP EtherType (ETH_P_IP).
>>
>> Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
>> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
>> Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
> Konrad,
>
> As per my comment on an earlier patch, your SoB line needs to go here.
>
> Otherwise, this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Simon, thanks for the review. I'll split the patchset into two to and 
address all your comments.



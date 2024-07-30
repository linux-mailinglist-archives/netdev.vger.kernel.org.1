Return-Path: <netdev+bounces-114145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18BF9412F4
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36553280AB5
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B1F19E83C;
	Tue, 30 Jul 2024 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9AvPQ5V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38581DFE1
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345585; cv=fail; b=LVh1F2AKZk4FMh47w2eiB+X+yHdJfjsNY/oguu/OzPOwRnE4aRJLqvmkTYSJ3mPt56zZtm53EnyBhjgRQZ30pPvi89aJsDpXJ2R6XQorts/ESfAujorVxNl9S1WrZnenGBLr3aMWiJBKBsHebzu12IVv/6X808N8lpp2Em8xT04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345585; c=relaxed/simple;
	bh=CDcVzleywhWHp2fudl5Ehv61T35MJyBqXr5vV36OngU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=boiWPwqxBH094mJuuc5z8PuxKgoQFSPIapOjg8Zyu7zrEa2z6WBT8rbJ3ToizIz+mJAVx5an84MIA97IjEbyr9Q05C5XEVBMYmWZOHvERHGKl4jImXe3B6+hibN4QkLw4nTaYLf0BL+ou3iHXHtkF8tgwrOpuV1WN7GMZkXnij0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9AvPQ5V; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722345580; x=1753881580;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CDcVzleywhWHp2fudl5Ehv61T35MJyBqXr5vV36OngU=;
  b=U9AvPQ5Vuomt9q2jk0ITQ7E1X9Ch4W1mzVXopFnUGnCgAN8+YTwUTZFg
   6urKQbo/g06ieQKDF0kY8vwaPvdTkK+ECqdTI31ON8NIMqTbRYIJ2/Lfl
   0lZgan42lHdIW+XIxNAh0jSathOskhhcoFObjx9KEwPqyS26kWtrDQ5eq
   WeSpYpgpfswF3OYJj6lvj5ogTpp2I8AaHwqi2TKA7vaC15Q3p8kiS2tSJ
   KjSFI0CX0clmEQsTjed1QxBnZdgNNVwUBmMg2fvfmHNS+mRbnIsvhIvna
   v061CNFivzy3znmKzGldQ8Z0XUIc9gtSgoQHGgdj5hx83LPiOmLD5k9w6
   Q==;
X-CSE-ConnectionGUID: kNGd5uJ+RCC4qt+1BnrAsA==
X-CSE-MsgGUID: DlUm512ZTp+o17MjD4WubA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="37670410"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="37670410"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 06:19:39 -0700
X-CSE-ConnectionGUID: Fc5BeFbDRzGjvVJ0ydaixw==
X-CSE-MsgGUID: tCpQa0n/TmOdjAdHt6rrRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="55132564"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 06:19:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 06:19:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 06:19:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 06:19:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGuy7deDGiT50EVHwIC3qFv7g5xE29WGWf9Yk2tXS24lnrfnvHxztbU36WAhFqWQevGvVCpdP+SKAO5ZGTgUSwmJL00BQXYFbjfjI80d9iOsNp1EgCtGzVeMbxTmD/PX8oJjdOCsMgFeZPgSIacr/3rf9v7uRiA9BDsGzvzh1IWXNBR8IS05kKPc1PjVpS49ZhDVqtId8kNCJjp9jptxLc9o58dcs7CgaMY+urGrWbKymvmsKCIE52klxCjwn+5XALlrmUVA49TvDDfhWHQnDV6r1yVzy2Y6Ap3/inyOnt1tzn5joKiNceVYFZkjf4Edx8vna8tQkMTnbU96lH5i1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/+ZtzQzGv0hmW1rCA85OV3bG0sUgd0Xh233N54+HoM=;
 b=iLa3A5FTfJ1QBmmHJsb9HVixGZ6q6c5Alyr1VpuztRMmfP82v6VvLFvAvKshOGyJ0LNED+HL0iY5iJ4nc6Q4dQdujS6r9lKffDgWAPW/KbOgYDCOxLJq/1Iq1vMT5kIiNo/x+aOVbnXgTjMZQ9RovbFmCq9tTA60Pj8E07uOvcRJyD+Y0bkTNTSVvuYZd5BXM6ZD8gjvW5cYw4igWBqe+9HHq+w+4DriBdXaJtKqq++JiyVokAo5F+rLfXmjyEGGHk4R/vpAHatbWtmLM2pZN8iYQUT9MFCDwrVKqTJmWywSS/BR9445ZM5L7Uh7W0mDr3VYcyzGyGYq6SWiXDKSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 13:19:35 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 13:19:34 +0000
Message-ID: <5cb7a09d-2e67-46b9-b5a7-4cc4cdfb6354@intel.com>
Date: Tue, 30 Jul 2024 15:19:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v8 04/14] iavf: add support for
 negotiating flexible RXDID format
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>
References: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
 <20240730091509.18846-5-mateusz.polchlopek@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240730091509.18846-5-mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe1cb82-9a2a-4c34-fc90-08dcb09a4106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjdxRnhkNVlUdEIrMm9HVzBEcmU5WTJrSFZRZmdHS2VweDlsUGpLcnlaaHp0?=
 =?utf-8?B?VmFqNXQrTko2UzVDMEdhM1R3VEhTSU5HZ1h0NnBpNFNBVEk5YW1uZ0F6Lzdm?=
 =?utf-8?B?RUJtZmcrWE50UkdkMjlYeVJ5TWRuOHVyTlJ1NCs0bCsySXduMDUzZkVkb0NF?=
 =?utf-8?B?VE9hSEo0aGpFNVNoeW5GN0E0WVlWYk1scFFVcnBCUmhjWjNheFdXdzE5RnBX?=
 =?utf-8?B?UGowSTljcy9jMEVhQjJoQXVkc3FwVUtPTFFJNWwxTVdIYzg0M2FSTld1MXFt?=
 =?utf-8?B?c2ZoK3UxTUhCMytEcEw4dGk2dEZRV0k5a2t1RjhUd20yU3VtbkxkR3djVEo0?=
 =?utf-8?B?S3gybEthcWdGN1NwSTZQb0hVditmdzI4bHVXODZVSE9pbEg3TWZ4NWZqY3Vh?=
 =?utf-8?B?WVZoK1UwMTNMU0wwZVAwWGM1WTBMcGpKWDJYYkZwaWYrRlgxcGc3K2ZlQjE0?=
 =?utf-8?B?My91MnhLcFNPRHpySG5ITHVzRGwrOFdDd1Uwb3RsRHEwYVJXN2R5Z25haDI1?=
 =?utf-8?B?YXYzcUFhdW5VWDN6QkFYZ0t2bFowdUcwOU9JdjVLQXhpZUQzUEpqa1BOVWRi?=
 =?utf-8?B?MldtUWpINHhLZml1THZJZ2JKSnl5eW5tTFhUM3pFbG9GZUNGQkdETXRPMW9j?=
 =?utf-8?B?aDg0VURLRmFoTnFWcitOWWszNERXT3l2T2dkQVJHZllVR1FCLzR1eHdCSmsr?=
 =?utf-8?B?Wi9URUFXNW53emlNUVUyYVAzb2hLUW5NcFdmcldjRGJnSk9tdkZIbUYyNld1?=
 =?utf-8?B?SklncTI4SVMvVEEvK3kveWNmb1lEd3JRMVlDVit1Zi95K2xoVllpU2NCckgz?=
 =?utf-8?B?ZGUvNzgwbU40L2VMZTcxaTRXdWtYVHducjkrRG1lYlJaOS9hNDlSUzd6NUp4?=
 =?utf-8?B?ZlRTTjFidFZ5UjN5WnpKeGZvN0EwTFp3dEJTQU9MbHhIUFJwR21KL2lsdFo3?=
 =?utf-8?B?eXdrUWpzNFpUUUhTaldUcmx5a0tjTFh0NDBoVVFvRlB5MUZYN0hzV1lHUjRw?=
 =?utf-8?B?QU4yRkhYQXNXTVpTbi9UU1ZMQW1jNjlMLzk4K2dRN2RnVmYxM2hpZ3ZJRDJY?=
 =?utf-8?B?UzdTdnNPSGdzVXdlM09WdXlvaE5qN1U0dEhFakFiWjVMWGFBL3BpRUQ1NzUy?=
 =?utf-8?B?Q2k3K0p6dmJxQ1Z6ZFljeVF6RVVZbk45bytLMU1MRmlMc3Z2aVRhazhPdFA1?=
 =?utf-8?B?YXY2U3FpaG92Si9kaVNDSjc0czZtRkhxTDNtRFVXUnRya1hldS9oZmo1dzVQ?=
 =?utf-8?B?Nms1UFJ5Z3k2eWVhMnBJMjd0aUpvUTVhaEwyQW5ObHJxQTExNUNSMmM4NllP?=
 =?utf-8?B?UjExTFk0bmJDWFNXdm5ERERpOTRsOVBPekc5RElhRmR4eWlNaWZOWjMyMzdC?=
 =?utf-8?B?UXhWczFISE5YdW1HZmhHZ1pFbStxNXFvclJ0MzEwdmYzYnJUTkU0dUIzQVRL?=
 =?utf-8?B?RHhkU1FINit5eWJ6Qko0bzVOZ3E0bTM1TnNsSm1UenFEaXEvcVluVENyOUl2?=
 =?utf-8?B?Wms0aDN4OFZWeHJKUEZwU3J1WVFyQW9vWS9KNmxxNlVvL3VxYjNuRGY5L2ts?=
 =?utf-8?B?dzhuaS96OGNzaEdGWVIySUxxSVd4OG9DOHNVVUpUckl1ZXQvQU54MFhZbHdB?=
 =?utf-8?B?dnI5eWRkV3Vhem1EZTZUeEtEZVF0cXJDYkJzeHZGZnVVZzBVWThEemxxTzZu?=
 =?utf-8?B?d0RpNElFbFU5M2VyVXR3blIvckhVNS9TczZNYVdDcEpUbUJMZVdlZXhkRlhp?=
 =?utf-8?B?a1RCRWRXVFYrbVdJZEhYYjFQR1JMNkFiWlZjUGE0RjkwN21QUHJ5NE1XR3hx?=
 =?utf-8?B?bTFLaVBUZlVXMWJlZ0ZHUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTB0dlZZeXVoNFQwdS84SDNORlpkL2swWXg4SXYrM0FSQU9vS3BoRlBPekVq?=
 =?utf-8?B?SE9FRS83NklMbHpSMXpVZXBMeEwvRmpLRnNGaW9hS0ZnTWtpMVhtN2xFZURm?=
 =?utf-8?B?QjZYVXJ4d0g0QlBWOXRGZTBLTmptTjF3OU05c2tQUXMxQkhTcDRTTTN2ZEdQ?=
 =?utf-8?B?djF4NGgzdktjTkU2V2pHYWZjTC9RNnRTb1ZpZFM2MWVCWWxWNFVDeWk4aE02?=
 =?utf-8?B?cXNhTXZrdVdPbThWeHh1N2NSSVNPZFJyZWcxdzNqY3cvbFJ6cDhkb2JDSmJJ?=
 =?utf-8?B?dVdPd29lV2MzRjRiNUJDdUE4NW55RCsyQjlZRlRCeXJ0a0huNjBQV1EycUNi?=
 =?utf-8?B?UUN6Rkp2RHhSRk8yVGt2bys0dXVmOEJwNFkrVXU2cUdVZGF0Zm5BSzVmQmlD?=
 =?utf-8?B?bkluNzIrSEtOdHNBWUIwNzc1Tnp4Yy9Ra3Q5dlVjZmtkN05WY1krdWxrYi9C?=
 =?utf-8?B?UDB3MkhkbDZ6dHYwRkx1b3h5MDNmTitoYVFwaEJ1MDdMaVZwRnpMeHFrQnJ4?=
 =?utf-8?B?T05oWnBiSkN4SFBwOVNrTHJZRGRuVWJpUWNsd09CMUJldjQrM2xLWUJuRkFr?=
 =?utf-8?B?b1YwaDBjVmxiM2tpdGxaWHA1L252bnB3SGFIWDVrV2pBRnhmb3d4bTlTc1ph?=
 =?utf-8?B?NHRDckVtelBWV2NObitweTlyOTE0NzBwSnZqSzIrdjBWU3RUSWtycmxtaFZU?=
 =?utf-8?B?dm1xSkJkclQrWFV6Sk9ibm5RZmQ4TnhMMUhUcWZRb29vQUNHMkxiN1gvb0R5?=
 =?utf-8?B?d25ZMTU4YVV6UFAxNUluVE1nRGNhNTJ3d1E1SEVNcG55TWxlRVBMYUVJZ21t?=
 =?utf-8?B?M2lxdTQxS3pGOWlYcGYwY0d3OFR1b2lGMXp6aXZReHluWDZqVkYrRHliZkQ1?=
 =?utf-8?B?cXdoRzdjdHd6emJCbkQrZTR5cTQ1RDVqeCtKc3QzZFZHS0dKTEpSY1Vvekxi?=
 =?utf-8?B?RmVsYnQyMkNOMHNwRjlMaEl2L05oVENzaU9WT1QwUVlId2U0d0U2Umh2ZHFy?=
 =?utf-8?B?b2pFOFgxejQ4dDhER0FQMUQ2YVpvRnZNZGlMR015alNmalAvWUNvbHVxRitV?=
 =?utf-8?B?Z2VRZ0c2QS9iYzZzamZERGtUZGJtOGdYMW9PUmc1MEMyTkxseENzRis4QmdL?=
 =?utf-8?B?a1R3ZWRVbENsRm9CMUVkd3BMYnhIR3lFWlhwMkk0MWpUMlRMRkxkQVlLdkhP?=
 =?utf-8?B?YW8vR3RoQTJsOGZoOFRLQWpYWXJpUkthaHRuRm1BZlMvR3phU1dMTUR5R1Ew?=
 =?utf-8?B?OUxhTjZzRTVwd3UrOEpZK0NjdFE1NHRWZ2hJQml3WEtSS3IvYkdNRFFtRmZO?=
 =?utf-8?B?b00wSHhhZFAxaFdmQWYrS2tmSGVyVGN3T2ZSM2xrMU85UEQ2SWlkcjZWQkVu?=
 =?utf-8?B?b0x3bVJIZ1doZmM3ekg3NzlkcGJxOUs4OHU3Y0U0Z2EwY1VrVFIwdGliaGRm?=
 =?utf-8?B?Mmw4ZDNFZ2p5RklnczRqRjJNSGhBYnFBTTVqZW1ZM0kxUC9DNlFmQy82VXJm?=
 =?utf-8?B?emhuUzN5SEpBZFNSaGVrOHl3Qzc0Q1NXTDdKUklMOUlGNkVJSzBuTm1vUFJO?=
 =?utf-8?B?M0dFQ0FQWkdNVUJPUFpCMzZOOUU1dkhpcHQ3RU5pOE44TGNSR2RKSFAxTW15?=
 =?utf-8?B?WTg5R3N1NTI4NmYwQTVESnp0MmpUbVI0V3lDZ3NxWXRLQkloY3g5U29uZEVK?=
 =?utf-8?B?MXdsTlJXUFJMdC9SQmJHT1BTQ2t1OUVYOXFZQ2xHWFlwUnJBT2tWMGNzakFq?=
 =?utf-8?B?SFhGM216dXlVcW9GZ3dTV3ZlSE9TOEt2eFk2RFpKaDFpdFpvNEtMYk5TOTAx?=
 =?utf-8?B?Z043U052VUdaclhZUXhGSWdGVXRGL0c0TWhZWTVwZG0zTVNISHpLejlPOFUz?=
 =?utf-8?B?dFBKS1FNWG5qcDZ6L29YUTdaTXhpRzdEK1BXcXMwMFB6MTBnYXdWYWZxNWJm?=
 =?utf-8?B?Tkt2WkFyNTVWeVRnOWtGNElzMUJIQmY1ZHlOTWlYY1pnOFYwN3lLOTZWdUFt?=
 =?utf-8?B?Rll0cExMSFA4cHN5NHBnczE4MVlibHNib2dSL1o4SmY0eEVvdmhxNWdMN0Va?=
 =?utf-8?B?MjVYMEhHMHNGZUVHMzhzQlEwUTRCczJtRmE0MVhVQThwZUdvVkZ2SnllckhN?=
 =?utf-8?B?aUtYZHVyVHoxd3RxaXdKeXZINmxxVi9zN2RTR0xqVGVvQ3gxQXBNeCtIaGdi?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe1cb82-9a2a-4c34-fc90-08dcb09a4106
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:19:34.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coAZu7Er3iwUZl2VUYqC1PTrprpy0EjyeE0qFVhqSDEmvqajEUIg4LkbXwixB5iDUHcPhjd/720gqVBWo6h2es1398UWLPhLlssdEwLNsu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4952
X-OriginatorOrg: intel.com

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Date: Tue, 30 Jul 2024 05:14:59 -0400

> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Enable support for VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC, to enable the VF
> driver the ability to determine what Rx descriptor formats are
> available. This requires sending an additional message during
> initialization and reset, the VIRTCHNL_OP_GET_SUPPORTED_RXDIDS. This
> operation requests the supported Rx descriptor IDs available from the
> PF.

[...]

>  #define ADV_RSS_SUPPORT(_a) ((_a)->vf_res->vf_cap_flags & \
>  			     VIRTCHNL_VF_OFFLOAD_ADV_RSS_PF)
> +#define RXDID_ALLOWED(_a) ((_a)->vf_res->vf_cap_flags & \
> +			   VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC)

1. You need an 'IAVF_' prefix here.
2. Very bad indentation, should be

#define IAVF_RXDID_ALLOWED(a)	((a)->vf_res->vf_cap_flags &
				 RX_FLEX_DESC)

Tabs + align RX_FLEX DESC as it should be.

[...]

(sorry I lost a piece of quote here)

> +	struct virtchnl_supported_rxdids supported_rxdids;

Does it make sense to add a struct with only 1 field here? Maybe just
add `u64 supp_rxdids`?

[...]

> +static u8 iavf_select_rx_desc_format(struct iavf_adapter *adapter)

Const @adapter.

> +{
> +	u64 supported_rxdids = adapter->supported_rxdids.supported_rxdids;

The variable name could be shorter :D Like just 'rxdids' or 'supp'.

> +
> +	/* If we did not negotiate VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC, we must
> +	 * stick with the default value of the legacy 32 byte format.
> +	 */
> +	if (!RXDID_ALLOWED(adapter))
> +		return VIRTCHNL_RXDID_1_32B_BASE;
> +
> +	/* Warn if the PF does not list support for the default legacy
> +	 * descriptor format. This shouldn't happen, as this is the format
> +	 * used if VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC is not supported. It is
> +	 * likely caused by a bug in the PF implementation failing to indicate
> +	 * support for the format.
> +	 */
> +	if (supported_rxdids & BIT(VIRTCHNL_RXDID_1_32B_BASE))

Isn't this BIT(1_32B_BASE) the same as 1_32B_BASE_M defined previously?

> +		dev_warn(&adapter->pdev->dev, "PF does not list support for default Rx descriptor format\n");

1.

> if (supp & BASE)
> "PF does *not* list support"

Is this condition correct?

> +
> +	return VIRTCHNL_RXDID_1_32B_BASE;

This function *always* return 1_32B_BASE, is it intended? Will you add
more in the subsequent patches?

[...]

> +static void iavf_init_send_supported_rxdids(struct iavf_adapter *adapter)
> +{
> +	int ret;
> +
> +	WARN_ON(!(adapter->extended_caps & IAVF_EXTENDED_CAP_SEND_RXDID));

Please no WARN()s in drivers unless absolutely needed. This looks like a
regular pci_warn() or pci_err().
Also, shouldn't this condition be handled somehow here?

> +
> +	ret = iavf_send_vf_supported_rxdids_msg(adapter);
> +	if (ret == -EOPNOTSUPP) {
> +		/* PF does not support VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC. In this
> +		 * case, we did not send the capability exchange message and
> +		 * do not expect a response.
> +		 */
> +		adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_RXDID;
> +	}
> +
> +	/* We sent the message, so move on to the next step */
> +	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_SEND_RXDID;

[...]

> +static void iavf_init_recv_supported_rxdids(struct iavf_adapter *adapter)
> +{
> +	int ret;
> +
> +	WARN_ON(!(adapter->extended_caps & IAVF_EXTENDED_CAP_RECV_RXDID));

Same here.

> +
> +	memset(&adapter->supported_rxdids, 0,
> +	       sizeof(adapter->supported_rxdids));
> +
> +	ret = iavf_get_vf_supported_rxdids(adapter);
> +	if (ret)
> +		goto err;
> +
> +	/* We've processed the PF response to the
> +	 * VIRTCHNL_OP_GET_SUPPORTED_RXDIDS message we sent previously.
> +	 */
> +	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_RXDID;
> +	return;

Pls empty newline here before `err`.

> +err:
> +	/* We didn't receive a reply. Make sure we try sending again when
> +	 * __IAVF_INIT_FAILED attempts to recover.
> +	 */
> +	adapter->extended_caps |= IAVF_EXTENDED_CAP_SEND_RXDID;
> +	iavf_change_state(adapter, __IAVF_INIT_FAILED);
> +}

[...]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
> index d7b5587aeb8e..17309d8625ac 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
> @@ -262,6 +262,8 @@ struct iavf_ring {
>  	u16 next_to_use;
>  	u16 next_to_clean;
>  
> +	u8 rxdid;		/* Rx descriptor format */

You're introducing a 1-byte hole here. But I guess there's no space to
fit this 1 byte.
Anyway, pls check with `pahole` that the layout is fine. I remember I
was packing this struct cacheline-friendly.
I guess ::rxdid will be used on hotpath. I'd make it at least u16 then.

> +
>  	u16 flags;
>  #define IAVF_TXR_FLAGS_WB_ON_ITR		BIT(0)
>  #define IAVF_TXR_FLAGS_ARM_WB			BIT(1)

[...]

> +int iavf_get_vf_supported_rxdids(struct iavf_adapter *adapter)
> +{
> +	struct iavf_hw *hw = &adapter->hw;
> +	struct iavf_arq_event_info event;
> +	enum virtchnl_ops op;
> +	enum iavf_status err;
> +	u16 len;

u32 is fine.

> +
> +	len =  sizeof(struct virtchnl_supported_rxdids);
> +	event.buf_len = len;
> +	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);

I think it would be better to declare a pointer on the stack with
__free(kfree) and then assign it to event.msg_buf only after the
allocation is done.

> +	if (!event.msg_buf) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	while (1) {
> +		/* When the AQ is empty, iavf_clean_arq_element will return
> +		 * nonzero and this loop will terminate.
> +		 */
> +		err = iavf_clean_arq_element(hw, &event, NULL);
> +		if (err != IAVF_SUCCESS)
> +			goto out_alloc;
> +		op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);

I think this cast is not needed here.

> +		if (op == VIRTCHNL_OP_GET_SUPPORTED_RXDIDS)
> +			break;
> +	}
> +
> +	err = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);

Same here.

> +	if (err)
> +		goto out_alloc;
> +
> +	memcpy(&adapter->supported_rxdids, event.msg_buf,
> +	       min(event.msg_len, len));

or

	if (!err)
		memcpy()

- 1 goto

> +out_alloc:
> +	kfree(event.msg_buf);
> +out:
> +	return err;
> +}

[...]

Thanks,
Olek


Return-Path: <netdev+bounces-169944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC6EA46990
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C7A171944
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BDA2343C9;
	Wed, 26 Feb 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdCNygkN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2622A4EE
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593822; cv=fail; b=OnYNF7tMGNLqHCjCDjpi8SItlyqK/yxbJ69fA0Fs6z5u0Jbq04gNFTliXrfXTZce6+4n9j+LKEYl6vkU+G0kPFi2RmhglNFcFTyrKO32zDQaqWLySy6CrLMMSazLDhoi+QJKGsqDhX6q7QxpTCAgaoxTQlXjIpldIYICgVBvAL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593822; c=relaxed/simple;
	bh=xb5eMs5U8wgDAWbTOBEri0au1LavDUz/JnA6VYja10k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nsyeo2qHpFbjLi9fPyaMYrmTw7pSc5aQy0nugqjUGLcnDnlmreGVK311ixt8LuWciyAXbYZbZdgmkQ+9hYrRfwuejnInEkBQArkwgghb+WErn1Xs61CL+wU7YqhNYXD+TxN2Qk2o1puGjVG/rdeyxaQLMW/tJ/DbnJT7vO2hkfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdCNygkN; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740593821; x=1772129821;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xb5eMs5U8wgDAWbTOBEri0au1LavDUz/JnA6VYja10k=;
  b=ZdCNygkNQ1Et/P2chJbbplrNhKkrVnLkiDTk332Ehk323AO7OBivMhP6
   XfSQ7zVUvisttjbl9ds63wsbLrlTwoBpyTslsBjQbrQufS5YMTiyXtDwg
   uWjdaM2N2kS8zvK4uGVuKgF3MlQ7DY/5fDUPqAaR+arQAlZRsGxcBrxJt
   CSLS4P/1mZ3wnAVt+LNyYVyb4S96SHDUn2EC0BhwOZOaEJKYli+nqgNr/
   p8+WsJvRfOCwlHfPXDOB2fDzUCFMXWRGgOZtepPx4wFhAYDeMTUX7U8ed
   9rZTDrhurHvHY5EMgyRJT32B/bdQh7yXJ/VJKmP3m4KzYbdQOCEAKBhIt
   Q==;
X-CSE-ConnectionGUID: jVKCQEoTQk6CEVrD/pBLeg==
X-CSE-MsgGUID: hsjld4QKT1qHdOtxoGlDTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41159707"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="41159707"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 10:17:01 -0800
X-CSE-ConnectionGUID: ukTvNoacQLKFVFvGhXv95w==
X-CSE-MsgGUID: rXICOnKHRB2BQSXeU8uAhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116786506"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 10:16:59 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 10:16:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 10:16:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 10:16:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u88itQPITjZwLHRnzDknhHNPGZmyUPob51zcxHo7mjB2RwdJMlrJGMnrKak4Iriy2bURmfsRhPbZOl+2LMvu/TkjV0dSongMfv2iMVXRfexUhFVC+YYnWIRObCbBBoiaUNiLYS0PygTKgAp0GTGNc3yoKsmoaSkA1FYGNFcwhv38qudPnSJo4mmmYNwUQ82hgPbnBWhxuw44RLIoBLxnnhWGAk9BO9nbZalWOLKNZJ1vJ6xZgTW0IPC289seO3ekSOlI58vkFTSmsxaXSlen/Fj3fnFtr5coRk1BiWA7NjPlMVvuOJoE/wme0xscm4EeULDQzS+MJn3fgZ6xjZZYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3ecAFnEf5K59G7eOzkZCTFY8ePa3MFC38R9a540Un8=;
 b=e42wEzDClSwK4DqOYQYbVBYPO+RIbVY01kxWkrYXqiaSMn0QTNpoNPtzD4W1/KBVA3UtmCo0c3a1KIfR+Qy2KYOrDO2/6H2SXT7TD6zLZB4iD67S32Otx+zJCAZbV0XT9sQJQ8EPZ+tr/qKLApfoGx3tNuILRjePNl7pS7CY2aZL3vxHXfxbrCSaVj8sVVf9qhVUzgB3WMaOnjaTnhixsZi6UJa7J0/R53eAQD7Tj/o7et9W85yidzV9I2i0D+YBln8Ucqo2PlGeuurRAO8F1VJ3bqfmusqOT2qYDxaf0denn5o82XTaUQHJ3GCjxCkv8qmoRvdf8ucmRpZ6VA5ufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by LV2PR11MB6021.namprd11.prod.outlook.com (2603:10b6:408:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 26 Feb
 2025 18:16:41 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 18:16:41 +0000
Message-ID: <13975120-24a3-43c5-84f2-a1de515704ef@intel.com>
Date: Wed, 26 Feb 2025 10:16:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/5] idpf: synchronize pending IRQs after disable
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <willemb@google.com>, Madhu Chittim
	<madhu.chittim@intel.com>, Simon Horman <horms@kernel.org>, Samuel Salin
	<Samuel.salin@intel.com>
References: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
 <20250224190647.3601930-4-anthony.l.nguyen@intel.com>
 <20250225183844.44f9eb66@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250225183844.44f9eb66@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|LV2PR11MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 889e6008-2c67-4e20-c755-08dd5691b81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0xXVm4vR1RJZkVCenQ1RmNaZzFCWEtPeUhHRXRoMmhvb0hVY0tnZFhFc0cv?=
 =?utf-8?B?SlYyVlN6Wi93TCtpQzN2TlBqaSszWmhSLy9GZittRFhaNzV1QkhhRkh2M2Jw?=
 =?utf-8?B?NHFNOGExUXg5R2pnYnE2V2txUGkvRWtXR0xhR0pjTXB3aUhWaDJIdEM2VFR4?=
 =?utf-8?B?bWRPMjJlOFVvQm1GeXdLOTk3aUg2YndlcHhObS91N252c1JzL2k4djB1S3BM?=
 =?utf-8?B?eFZaeDNTak5VTFowQlhPTnZRYVlPWTBkaUNxOXkzdXE3dkp0d3pZSXIzTDBS?=
 =?utf-8?B?enA5TmJGTXdKTExzUk44TzEwOERTQmNOb3JXc2hIaUJPK24xYVJlTy9wS2NS?=
 =?utf-8?B?WHRiVWF4bXBlQWVDWWZjN1lsTmErWWNuQnlyUnV0eE5tVW1EbDNSSXRaUzNt?=
 =?utf-8?B?and2M0JqZVkyc0FaaG9IVXFRTlNPVWhMSktrUEdDVnovbVVQSXAzeFBsV1Z5?=
 =?utf-8?B?NXorU0RXdjJyeG1JVFpPWHRMVlZQVEtuNk9MT2RzTllvOTZWQWdLcVFoSzlC?=
 =?utf-8?B?WGlLR2tIS0FseGRzdENiOWc0Um1FRVhia0VaMWQ5R3lsVDlqUlZacDd3dkcw?=
 =?utf-8?B?TkpnVVlFNkFZOTB5TEpEWDYyUXdKUkcyMGdwQkNoWnFTZENHMTVzQUxCcUJq?=
 =?utf-8?B?cTBONUc1S0lqaDFvdkh5UE5rMFlOTGd0aVdHbS9ZTWo1a2J2Tkl6cGE3czBQ?=
 =?utf-8?B?WCtvS2lsaTZYLzFHQ1RDRE1mREpvUTRObWdRR2d5aW04SWlwbFRma2cyRlM1?=
 =?utf-8?B?R1ZoVGQzb3o3K3hHdWtVQVpnT0hJWGoxMDRDd3RTN253dHdrUzRqSmI1c2hK?=
 =?utf-8?B?WGhWY0VnQ2h0VHVQVHdUVFF4NEZGbEQ1aWpzL0dFWFBlTElwdXZvTk0xTHZE?=
 =?utf-8?B?V0k1cFhQdGQxK3VQdlUxSjNFN2xEU2EzTXNVdlk5cC9jZ0dSemdqK2FHWXVp?=
 =?utf-8?B?V2ZlMjVRekJpbzY1ZTh1aEh6QWNEZERCR2JkcENETUIwekF5VFZIVGFUdVFD?=
 =?utf-8?B?elArK29ZelR1YmRHZ0JTQlgrZkREK0lkRXRCaktVb1V1cUV0QXp4ckVUNktQ?=
 =?utf-8?B?dGZBREUrSWJRVkVoR0dTMjNvZVplbzcvMTVnWmJyNGcxS01DbnUrclI4U21n?=
 =?utf-8?B?dVlodTlmT1FTOTk2SC9GZXgzUUMyZ3FNUjFYRzVUa0ovbW1wbldFUUpVam5E?=
 =?utf-8?B?Nks3dzA2eWNTT21vbys3NVVpRFZMSGR0V3lxNGRqMXNUeEdJOFpVUHBrQnFa?=
 =?utf-8?B?Rm9sRm56VzVKbXBaTVFaRHZHcmlHSHRjbEhCRzdMUW0rRVd1bmFWUmNITmhz?=
 =?utf-8?B?V1BrTHVmUC9nVXF3NUVRMUpSWGRqcUZ4UnB6d1A3cVFnbzMyZXpMWERIWm9K?=
 =?utf-8?B?aWN5TDc5cTJwbDI3b0FyQ1k5b2kzbVJpWUtnN0EzM0hCZ0dBWVNqaGRkR1ds?=
 =?utf-8?B?WGI5WG9wRWZBRUdROU94VVVVNnpCdHd5bEh0bHkvRFdxWE85a08veUI3NDJJ?=
 =?utf-8?B?NDRycHBwOTlMQzRpai96NGpVa0V3L3VoeTBjL0NzbUczVURvaENsaThjSThr?=
 =?utf-8?B?TWUxRm0zU05BZXZNRktmeEdPMEFIZmx4WENXSjUwMm1UQkI1TExmb2VkQ1Yw?=
 =?utf-8?B?VDlDcmlnNHJOMXFtU0NiUTdCUnRJTmJYNWt2RkU2b3pEVUEyaTBpd2xsVXBr?=
 =?utf-8?B?dHplOTRHcTdMRHB2bVVYWkN6K1dCbjh0d1FhUkZsbmEycVpobzlUN0FsRjVk?=
 =?utf-8?B?d3F6bUxwbUhvUWkrOUtFb3FjOWJYOTNpanJpd29zcWs2cXlJQUlkRCtiVDg5?=
 =?utf-8?B?VE84UDk3dnJtNDJiM1ZvMTNnb1dwTHMzS25MZGxVYmlEbFFtY1lHNVNZQlpz?=
 =?utf-8?Q?USc4zGfzccZR2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S295NUc3am9aVUlmVDZFRnFpK2RpR2YybUpJaUtVTTNqYVpjekZ3bWNJNmVu?=
 =?utf-8?B?SklMV2JrMmNnczZtMjVOaEZSTXpOSGltSXlVRURJUEhxU21HcDUxUHM1RmRi?=
 =?utf-8?B?eG9TTU1vTVVmT2x3UTdTVXhnZmpsQ3dzNldhajdiQU9TM1U5ZTF3bEZNODlx?=
 =?utf-8?B?L0RISzJ5WFhxeXI1MHdrc2dqWDBmQk94UjhYNkJONW9jSVZ1UzF5a2FtT3ZF?=
 =?utf-8?B?YUN4T2UyOG05MnV4SHlIZ0FsM0tCb25FcVFyMXhpb2NxRVJVSUE3dkNjVFFy?=
 =?utf-8?B?NU0xRXZ2MFpnVjNXd2hNamFBR1VBclBKOVFQanN4Q3MrMENESkhQQ0hKRnhX?=
 =?utf-8?B?NFBzMUdHQmp2NlVVRUd1a2xaK0x3L21QV3pKbVAwajNFeG0rbVA0K1dCdnZL?=
 =?utf-8?B?by95K3psUkJEbW1hV21jZUYrcDk1aFpGb3dhSnRVOE1DelVvbW9CMEkzemZQ?=
 =?utf-8?B?aXF3dE1MdEsyOVltbmR3c0tvNzV4ejc5QVB4dzI4eDJHM1dhWjRhaXE4N3JT?=
 =?utf-8?B?dWxGZGV0UzQvengzNERxTCtyZFF2WG1OMGRUWWJ1UUlvWnY2ZE9GSHpMemQy?=
 =?utf-8?B?cmhGcHBMcVA5RnFtOVNmaExyVHBkNVdjL1Z5THlrN2cwM0lDRG1OVjVFWmdW?=
 =?utf-8?B?SFhqcDU0SXdvTzMySUZaOEVOMDBwMjJmNzlINTNETlhzZkVtWmNXb0VvZDFH?=
 =?utf-8?B?RlNJaHFMYzJrVUQySkJMM2ltbkNuWkdNeXk0VVdjRE9oWDNmWHRBNEJUbDA2?=
 =?utf-8?B?bkg4MzFsRlV0OEg1eVNZaUhjSEo4UlUzR016K1VvSDFycTd0UDh2d3EvSUcr?=
 =?utf-8?B?cEZNUUkzRDhVSjM1eVNRbitnc2FLeHNhOTgya3ZXWkdYWlJVUTdaV1FJeDlF?=
 =?utf-8?B?bHVyYWNLb2RNVVJQYlhaeHVIZnlHejdnN094eWxpbkoyVlp6MGJpekhYaTgy?=
 =?utf-8?B?TW1iUUNzZStycjh5eXV4bWlXeTUwWXZKdzFvWm1JN2piK2M0ekVHS2k1WVFn?=
 =?utf-8?B?dnZqUjdZZXJSMnVDVFNBUFZ3RHRrVjZVZ3VQTTJRZ3BPYVJZRDVwcUlja2lm?=
 =?utf-8?B?a0lJRXFvRHkrUUU3YXVVL1lSRHZIck5sakUwSlZFcmNqUGVaeGlkNjJrZFhz?=
 =?utf-8?B?MnpZVkpNWVNEMnlDR3BVMi85Vkc1TnBUWkpZU3lDNjcxYm9NRTBPNDRQeGxP?=
 =?utf-8?B?WU5tRnN4WVBWZXZJUWE0alNDYzdZNTBMNlVkdUFzaGUwK3REN3lqMnhSRmha?=
 =?utf-8?B?ay9PLzduOTc2VGUvZ25oMVNmeXlEbWhNQmh0Q05TSDdLbXI5akI3dnBhSmRz?=
 =?utf-8?B?Ym5idEQ0VGVycDN2OVZUTGU1ZzRGZmJGOGN0b0ZhT0YrbUtNWk5ycnFNVkd1?=
 =?utf-8?B?MTBFdGNCb1FuTUNyOUZVMFhPbzBYTEJlZjhGVWN5MkNZVFJDOFYraW5jMkdL?=
 =?utf-8?B?UU50dDNVYU0vejBpcGdLQjkrUkhVdTB0Z0g5U0cxRTFoYzRvT0NPUnFtR3Vl?=
 =?utf-8?B?bngwRXVmOEpFRmNwT2tmRndJSGtPSFJJTjUxVkhJckN5OVlaMG5qSHhYeWdv?=
 =?utf-8?B?UmxYSjlOelhJMGN2bmlDK2I4Q2ZJNlpYUnEyRnU4VEJqT1BuMG1TUzZTZjA4?=
 =?utf-8?B?NzJ0bmNJT2JnS0lNNnZjMWZTaEladnExWTJmMGtiNDVZSjJ6Vkd4MER2QkY4?=
 =?utf-8?B?ZlEvMGtQN1cyckpoblF0TFB6WjNTSlp1WmdILzMwekxGYmlvZWRLTFVhdW1M?=
 =?utf-8?B?cS9sOTR0aWtySWsxN0kzR0tMNGJzNDhOVzY3RlJJM0RtZEtQT3Z1RUFqTUVY?=
 =?utf-8?B?Uy9HbXAyVnp5L1dsS3dCODNxdnBaWjF6U2ZyUWgvb2NGeTl0citSUmlHVkc3?=
 =?utf-8?B?b1Y3VlRkVWhXZ3Y5REl5VjRiQnVTd0JydkxGVEJELzFMZXcvMXRydjRHUnVx?=
 =?utf-8?B?S1lKNllrc3ZpT0I1dE0wVVpiVDJudXd5YysrL0pHR0g4VTRZVmlncExHb3dk?=
 =?utf-8?B?QUl1K3MwV1JzSWoxM1E2bDZQaXF5SkZsRDNYMVZKTDB3eGhkZlhLNG5aUy9F?=
 =?utf-8?B?WC9DY3hYTU10MFdnN1NVQlJRNDVHWXZyUld4ZEtVRkhBUjlzWVZTQ29tWVho?=
 =?utf-8?B?VWh2RURFaUZMYWt4eW5CemNWeXpEOHg5TEY0RzF6bFFPY2RpZ2Q2WjdWVkdX?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 889e6008-2c67-4e20-c755-08dd5691b81c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 18:16:41.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 899mpYhDnUTPaMioBkvLlB1/j+fpZ3j9NzwWgYd2CncYs4nKTSL1rWkplNNp0u3kVoB5+X6eIS3O5b8Q5y03Yk268c7VRiCc7Gbs00j4lGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6021
X-OriginatorOrg: intel.com

On 2/25/2025 6:38 PM, Jakub Kicinski wrote:
> On Mon, 24 Feb 2025 11:06:43 -0800 Tony Nguyen wrote:
>> From: Ahmed Zaki <ahmed.zaki@intel.com>
>>
>> Wait for pending IRQ handler after it is disabled. This will ensure the IRQ
>> is cleanly freed afterwards.
> 
> No real explanation of the race in the commit message, no comment
> in the code. More info needed here.

We'll rework this. I saw the other patches in the series were taken so 
will resubmit this appropriately.

Thanks,
Tony


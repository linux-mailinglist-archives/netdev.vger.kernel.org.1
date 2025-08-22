Return-Path: <netdev+bounces-216088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45060B32018
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9A41890130
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D253525BEFD;
	Fri, 22 Aug 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAAoOCvl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CF255F3C
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878553; cv=fail; b=eZ3/j0sBMrNEMc4ZAl7ca/APd9o9CB6Tt4yRG1PUOg6gPSV5WvOUFFL7P4RIhX4r2HOs+pjDjbH9sOvZnExkSwEYUedzcMRrrxAot+1Mcsy3JHfJKbJfWBWns3CxQMOiBzmkxrD6akJjJ2udFT5Q3ngzunNAp4E7XlgMs/LE48c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878553; c=relaxed/simple;
	bh=TvWyke8A/Fmn6LSm2caJOAHU+ojiPc9PYFfNHL5pZUA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lmQLB/oagSOIqS2WarU0dFAkt78TDQDGySWdKRj9wC77mlo9zTpLmkKhDQbKO+lZo/XFf8funfKw0dLghuJv1Eqvi8rj66uwO1Bj6UzBAMJdkHUMilSVX2m41kDX5X8Swh2qLKuiKvOVAYFFfeoVn6ccRdLCGKdNrKVmgJRVAUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAAoOCvl; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755878552; x=1787414552;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TvWyke8A/Fmn6LSm2caJOAHU+ojiPc9PYFfNHL5pZUA=;
  b=aAAoOCvlcZcnak+0lzJdHPIzUl0w9EFQHWSxyKnoR3FCh8pg/JKdCYsu
   ASYGWj+Ey9m5rLZmYFwg62HIIMUHI37m6JvacNmzloXI0KcqFbPfucmPf
   PZw/5jiL+ze30jhZuvb2mm4yW8iUWGTo4qyHRningv7cCx34+FQ8uqDFC
   AUX03kgt+Z05QNjJ8b+S2hiqEO4G2OtR25BWf93m6h0Nq9/lG+ONPAIst
   eWi4GzT/BTr7QC7dAS3PwWmf3NPJUnVNYSB68n22fc4PiPyUFbgBDljbI
   Jfa6bqa7qc1Micj4g/eLmjoUeVR+7tebIrdZKInXjh/+XMm8fQj7ShV4h
   Q==;
X-CSE-ConnectionGUID: 6aeMOsGeSA+NJ5f1zkeyMw==
X-CSE-MsgGUID: 8prpM13XT3KeyqlPwIyOdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58050683"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58050683"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 09:02:30 -0700
X-CSE-ConnectionGUID: EM3S2FKUTd6yTsrsdwotHQ==
X-CSE-MsgGUID: FlMukCa8TxaZXwWxAdpVWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168250413"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 09:02:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 09:02:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 09:02:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.47)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 09:02:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S03bP3rl5ednzO+MEEBUG9oX6swWauRHQIdSwRajG+nBVVrHn0lvXmKiQjyNHG/hSuTvPTXk4Rrhs8hq3wY7g75ZzwD/7WKgF9zjcmC5jc3GkSRLbQ45NhyS6XMj8EcAb8T+lQsorST8uNuo4W3Iog2N3dpyCa5RfdrK5/3TM8IPrfBF+a8Lc56PqqU0SyMkK1d8H8qsel1fWh3T3PK8Nz0P7g7ihyggbZ0ZRxN8TnfahnRm19oXXyXTncIcG3+HTT/QOWczheM9hEfdHKM6GRysD0/gyVdLVFKV+DZc7Q6/1KsfGpXL+8uEuoC9JYg1ujg/VyOmyMEz2Xlgde212Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/CY74h6BsgxGwTt/cs8BcQO4lNMQ1crbLAmWvy/VWk=;
 b=ryd6XrLjmpf9ae5FiZKtj3Rvy2II6qu+/P93gIBcYwRpsv1GPDMx/oZaHFwZCzVynS5oxkjAzFhUuOGUtLjtGm6xjIb4+NetBLlmyXt680wPN+SfTUPlYqOsF05tI/53dSXk0B2cU4G/46Lv87PehP6cJ5KCr77gTyPoTdUl2YcwvXNp1jpp7h0i+K2cVVMqMqwAaZ3Q4uIKi49BzDw1DpgUegcEdd6s0Wf4h22hXKLskiiU3gPC+e3LH79P5RUmWEEPZ4PYHbvxuPZAOF+pmxAccJ0jWlZtDa0Q8hyG3FTwzhckoEGPU7C4jbVPsFFQg+1VOg+HcCemtVvCqsL6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH7PR11MB7025.namprd11.prod.outlook.com (2603:10b6:510:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 22 Aug
 2025 16:02:26 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%5]) with mapi id 15.20.9009.013; Fri, 22 Aug 2025
 16:02:25 +0000
Message-ID: <46ae0b27-c9cd-45ea-a58f-a91238e8bf0b@intel.com>
Date: Fri, 22 Aug 2025 09:02:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] idpf: do not linearize big TSO packets
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<eric.dumazet@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Madhu Chittim
	<madhu.chittim@intel.com>, Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>, Brian Vazquez <brianvv@google.com>,
	Willem de Bruijn <willemb@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250818195934.757936-1-edumazet@google.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250818195934.757936-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0311.namprd04.prod.outlook.com
 (2603:10b6:303:82::16) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH7PR11MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a6683d-e747-4866-cc16-08dde195495e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NysyN0V4cGVycUxjdUhCQ2ZCSnNiUUh0S25DRkFyMGZIUzhOd0VMVjVsQkdO?=
 =?utf-8?B?VGRrcGpZcytaanJtQzIyNVA3R0txcEs1UUNRWWI4R3owaEtlbUU2TWoxNG5T?=
 =?utf-8?B?ZVM4M1F4eXNGTVlPM3ZXTjdZWnl6TEVGQ0o3Zm92bUcrTEtCOTM0dXFrWkMw?=
 =?utf-8?B?SUN3dUx5L1BheDJ5SC96eTBJY2tVWDhGT0RqbHBSMmxaMkNZTkMyWXZiVmkw?=
 =?utf-8?B?S09CNUJpU1pMaWdzUmVoYklWd1hpakVHSi8wUFBha3FRelVkd3hDTG52dFAx?=
 =?utf-8?B?dmtjYXo3VTRyRVBNeEl6M0JBeU0xbjdtbllTbWw2SDd6Y0hxMklrR3pNNGtK?=
 =?utf-8?B?VE9QdlVOSGE5WEUxZkJ1SjRqTlR3SWNTR2xDNlg0dWUrcklpOUVaVEVOOUNN?=
 =?utf-8?B?TTM2MXhFS3JJKzQ2R3JvaG4zZDZrV0FRQnZ5TzljZi9TK09nNkt3VTBTcUlv?=
 =?utf-8?B?QkNhMitENGNhWVBNaWMveHFmbndtTi9qdmExV0NiWEtJempOUG9PcEgyUG1Z?=
 =?utf-8?B?cTQ3M2VQLzJ0RUdKSHlFcncweFptclc2V0l4VmRiYzk5M1F3dktVWjJkS051?=
 =?utf-8?B?ZnBXMVVTMmZ2R1NYYUVoM2t2Z3VudENkZXE1bGxHN3REVTNlT0llM2ZFQnhZ?=
 =?utf-8?B?MUJGdmVhVkl4dGRvS0cxRGk0SStudjU2NDNFLzgyeVRuSFJCTGtXUTZoVUlG?=
 =?utf-8?B?b20rS3ZyREtldG9rY1hNQlVNUGR2Vms4WjYvaWczbGNrRTdJZWF1THhzOFdi?=
 =?utf-8?B?M25sN0tWUWpYOXpnT3ZUT2pMS0RoWlJJclBQT3kxSHlFS3FFejBIcHpsSTBU?=
 =?utf-8?B?Umg3dEZsQXpJbExhMEcwNy9JYUt4NG1aejJxdlB1elRIODhZVUc4azRvVTJL?=
 =?utf-8?B?YkZIS3FhWVQ3ZnpjZER2UmNVQTNMdWtHN3JLMkhRaFdLMjBOU0dMOEZoa2s1?=
 =?utf-8?B?U3g3KzVlN1I0SFpoSWlzU1R4a3pZNmdNMU1heHR2R1BpTmhCbUx2N1NCb2U0?=
 =?utf-8?B?K0U4L0d2c0FKazliaXlIM0J0RUlYRnM5UERLdENyQTRqTitWc3RIZXM2WnBs?=
 =?utf-8?B?c0VpSVYxNDcrNWtqNzZ5YzBMNFZHSUtRalJqYVFHdU9kL0ltV0RLVEhPOHVu?=
 =?utf-8?B?bEZ2VWo1cDM4czloRzVoRTZmSmdVaGxDbndoRGl1SUJOZmU0TXFCSStnNnlB?=
 =?utf-8?B?UWZBSUhLTWIxeVUwdC82NS9sb040U2RXSlhQZ1ZJdWFHNVJqTWo0N0R2cWJR?=
 =?utf-8?B?b21yeUlyNUtCeERvaDBweUQ4RXFXWjFLZjQyWjlPaGVpQlRMRnBLVWpBWDV5?=
 =?utf-8?B?aWFydmNtU3N1cm5ZMExZRDJCak9rbVkzai9sNllOU3JGQStWeEt6SzdVYUs5?=
 =?utf-8?B?UGJTam1GbzYxSjdnYVhGVWNrbnFCVmRNRk1sampUQlhobU1QZi9wdWZtek82?=
 =?utf-8?B?MmdFSHNEeXp3dC9VbWNUc3JNd1MvTDRLTy9rTHk4c0J6eXJvTEdXK080YzVX?=
 =?utf-8?B?RGhtcDZYSzZXb0JqVXcwaWx0U1hFVUViSVNEVkVrS2R3MFNqVkpTZ280U0FF?=
 =?utf-8?B?aTBqRUIvMUxZNXBYZ0gzd281SmlPWENxYVArd3FuQnhUVzEwYXNXdHlvcnFF?=
 =?utf-8?B?cXdva2dCM0xqNkdjZlozbGorVnpNdXBVSDFjVVFUaE9rUlRpWkhrTG9Nalpy?=
 =?utf-8?B?eDlqWTNYOGs3Y2VhcWlqNXRtVE0yMzRQVnhQQ1VQd3RGa0Zxd05McXd3akxD?=
 =?utf-8?B?U0F5YVA1QXU5NFNsMjNDbHhpaUlXWlM4RS91Z2JxSHJTc3lLNVNXaWxRWHRa?=
 =?utf-8?B?NzhpSVZmTnlQeHFhOUp1K3NzYzJ0Z1I2TzNjTkdTUzBLWU5jT2lWL1A0QzAr?=
 =?utf-8?B?K3VMQmxqeTJpamRsVERFUU5SNng1QS9Qb0M3NjlFVGpVMzFZZ2VUL0IzcVJD?=
 =?utf-8?Q?lqCtlHL156s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ri9Vc3JWUTVWa0IyZ1BrT1VtcnQrR2RGRVVPcGxCVldiTkpCTFVtY3FNZzhI?=
 =?utf-8?B?M0VaR1ljQ1pLc3hnOHVtampKZVB6MEkvY29YL09lUXp6cVFJdTZhWlRyWEpR?=
 =?utf-8?B?akdlK040ZnlpZURxWXlTTGJidUcvdWNPRlJibWNjMkZ4cnJWN29zOCtXcVRY?=
 =?utf-8?B?Sk1tdE5uR25qSWk3aXFCaFk1MmZXcHZCZEpUK2ZsczY1ZHp2NVpMWWZMb3N1?=
 =?utf-8?B?aGZpUGtINHBneHNyUk90aHhhdzAxM2NSU0F4R3dSYUtQRi9ldCtURUlyZWVm?=
 =?utf-8?B?OE1VRWtyVFp1dE96OUV4R1NjbzBXQ1N3ODV3bWNNVHowZzR1WkZLekhzc0pK?=
 =?utf-8?B?UnYwNmc4Wkc4MWYxZGxHeDlIWUFFTEViVWkvSDZDcnBBQnl3UGJiTGxtdkhi?=
 =?utf-8?B?ampEajJqSkI1N1l6QUJ2dW9PL2xiMXRyUUFrbmxYRytRY0hhaVdXWmwvLzQ3?=
 =?utf-8?B?d2hVbk4xaUc2QkYyTDJpbzgxU0Y0SVRRcTBWeDk5em05YUphUnhPSmRiV25B?=
 =?utf-8?B?VUNWbkxlTUFPZGM3ZCtoNlA3cWNPOGVUM3lZcCtobHRHYTVKYmJORWJZaTdv?=
 =?utf-8?B?blZOcVdpMFUzcTBySHRMampOV3BIQmp2THk5S1Z3UWk1bCttR3ZXbGN6Wk5o?=
 =?utf-8?B?UUF0M0U3N0JVcWZDSEtoMnB6dkhZdzQwazlqeE5GT1Bucmc4bi91YUhpZ3hO?=
 =?utf-8?B?aUNTZ2JrajNmTEVaOUZleEUzcWF3a3R6NktSQUlENzIwOW52Nm9OTmNGaFJ0?=
 =?utf-8?B?c204bm8yWWtHdTJIMnBTOUp1TVVrcEFqMVJzemRZUEVqbEpZZ1RCU3lXb2lu?=
 =?utf-8?B?SG1OWmkwMzBNVHd6U1V3a1U0NzZQbUZlT0FCcTlGNUZOSE5sWHBXREJTVGxv?=
 =?utf-8?B?ejBuekxCVWo0T05URWZBN3dnUHRTUDBCODZSU2FxbDJlYkRkbjIydGo0RHJS?=
 =?utf-8?B?WWlqbTJjZE91QnV5em9Ndi9NUEcvYkVsK1o2bnoyaS9PNWVGQ0FlWE5qemdC?=
 =?utf-8?B?VzlFMHkzcXVBUU9LZkVoaWF1QllacHRkdlY2cEN0QjJic3Zud200NVk3ekdy?=
 =?utf-8?B?KytEb0FxTS91YlZiemlDdGNoOTllZU5nQmRSenRjaXNMOWxXMHVZeDhtYnRz?=
 =?utf-8?B?RzdleWFiRENFU1JRb0t4b0swZ0VxMmo3d1dQVUMxUWdPendYQ3dRNE9JQUdq?=
 =?utf-8?B?UFRVdXNuN0h3Tk5kT0JQa28zZFBhTUpYUTA5enY4aXUzR0V2TTRLYmVvaXQz?=
 =?utf-8?B?UUZvT3JQSi9hdGRVbit2UXJmNHE5bUpzSUQrWVZzQVN2WEpmbCtWRWZNMkNE?=
 =?utf-8?B?WXBUekJjZno0T0xnL3JwOXhHUlBzMUJEeWhLTGxxL01GVGl4S0FVRFRDWGh1?=
 =?utf-8?B?d2RpclZSam82ZFhWWkxtZjRJcUVtUityT05ZL3d4dW5EUGtXRG5qZnVzMW9r?=
 =?utf-8?B?UHk3V0JiWFBkMUp4WjU4eVRlSDRsVGZsc3VvYzJXYms0QjdlcmJ2cENzZm13?=
 =?utf-8?B?WldrbEh1VXNRVWw1Vk5XZFRMZHFSMzZ3ZEhhcHg5eSsxejhmVDFGYms2bXB5?=
 =?utf-8?B?TnZYemFlck93ZDYyOTVFdThMUEFLZ2MwdUovT0szdnZaaUZTb0tIc2pZa0F6?=
 =?utf-8?B?VDY3Q21WWk0ramRRZ0hFU3ErN3JWR0tyQWU1eXRVSUJPKzFrc0NaL3VkbkZW?=
 =?utf-8?B?Z3R2SVlVQ3ZmYUsxbVJpRlZhSFJtL3B1clY3OEl1cXBqelU0T0g4STJpMHZL?=
 =?utf-8?B?cFh6WFFVdkJ6bHBPeHBBL2xyZ1piOUV4LzI5RkE5UStwWkwvYldza2IzOFg2?=
 =?utf-8?B?WEJVV1BDaHc4Q2h4V3lSbU0rRWlrSUpwaTJReXhTZkNGa3YybFBQOHloRGlr?=
 =?utf-8?B?WERhY2MxNEtEZnFVS1hnMzIvQ3J6clJRbCtRa2Fwb0RsQjl1R0hYeExGOEl0?=
 =?utf-8?B?SkFvMEZXUnRQMnJNeHJDYjFES09Xc0FtUVcrQXNDVHNicDZxeEdmRGR6MVJ3?=
 =?utf-8?B?NkxHMFlBSXZVaFFKK2xEUmtqa0RVZEVVaUEyQm9DQ0Vlc2F4ODRGeGpuL29j?=
 =?utf-8?B?dm5FcXZvcXlnbUtNT3loUTgrSmdDMVR3Vi9kaGdBdGM0ZjBiK0duR1NBZ2Vm?=
 =?utf-8?B?enpsOGxPcmtUL2dYOVh2V2p0eW1QRXNqOVgrT3dsVkJ3MFlhdTZ5U3pBWnNl?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a6683d-e747-4866-cc16-08dde195495e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 16:02:25.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8o6kAcnDEgPjaWS6C0oKkOdWS02iTe59thKgN2qRB7Yl7TfTFIRyTOu4EJB6BIZTII/zzgkx8yqf4+V0+9gb3kN21M1/3bE5mef0LlM+ZEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7025
X-OriginatorOrg: intel.com



On 8/18/2025 12:59 PM, Eric Dumazet wrote:
> idpf has a limit on number of scatter-gather frags
> that can be used per segment.
> 
> Currently, idpf_tx_start() checks if the limit is hit
> and forces a linearization of the whole packet.
> 
> This requires high order allocations that can fail
> under memory pressure. A full size BIG-TCP packet
> would require order-7 alocation on x86_64 :/
> 
> We can move the check earlier from idpf_features_check()
> for TSO packets, to force GSO in this case, removing the
> cost of a big copy.
> 
> This means that a linearization will eventually happen
> with sizes smaller than one MSS.
> 
> __idpf_chk_linearize() is renamed to idpf_chk_tso_segment()
> and moved to idpf_lib.c
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>

Acked-by: Tony Nguyen <anthony.l.nguyen@intel.com>

> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Madhu Chittim <madhu.chittim@intel.com>
> Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Cc: Joshua Hay <joshua.a.hay@intel.com>
> Cc: Brian Vazquez <brianvv@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>




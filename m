Return-Path: <netdev+bounces-152660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E542A9F516D
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A227A1113
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD81F6661;
	Tue, 17 Dec 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/rrSQWU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3414A0A3;
	Tue, 17 Dec 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454510; cv=fail; b=XgbB4avxzOJHwusQkC71xXYdBBw0ANRal7jNVIYmAqyweVa+IJbARk5/gpGS3B+4FGcxDCjNO/jP8VbZZU43Bcwp+EodV+8Q0UqBoAk/YkdLCbWWnj2WR8xyklu6LFjbvvZC/k5Bhi0qg9ITCzg9T8Tc4naopP5rR64/w+g/IZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454510; c=relaxed/simple;
	bh=vhz3c12yi7PE/7VvwxowXlSIin+sOqMKignPH/YWQS8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HM/afsY6r6aNW6WG9buNM/IGKgvZyyzPgX2MvePrMgWShokKtrxYiFBDm4DxBDha050/D36RzntkVn2f8RcN2v3kW3VzkQyEU4uhMKmQZ9sc/78iLbgrK/I5PBBZpunACtpNsIlDB97QJt0BEMplr3YiauHpkb9XQhu15DBCGaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/rrSQWU; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734454508; x=1765990508;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vhz3c12yi7PE/7VvwxowXlSIin+sOqMKignPH/YWQS8=;
  b=a/rrSQWUR2E7oMmcZeAJhilqdGuhR1uuhUsLqwtJ1MwXPlU6yAstZt62
   kfiWhmTNRSU676kvPM3keHCHYTg0Nl/WsLIbsUaHmf6tu65txJq7LnuE3
   1p14JmBYSHS6vqoNslY2j8iFA8yO/e/QRyehVI86vH3n5OrfnhtYEpZMx
   /ot1HK01bODHhTw42UVMfErlz4HCr1sUnnemrxw1eUV1Chxqc/brFUaSI
   pVrKk402AUrJX8Ma26g/2gxW5OIAy8z1ObD9FqOMW1K8edR4s+Poi6exd
   CTES5UNy39HwB7GrNJnbdZLADS2x6yr/3kvNmUEPZLWb5Gu5dHh720Dvk
   g==;
X-CSE-ConnectionGUID: 6xyroxInQkaggWIyg/iJsA==
X-CSE-MsgGUID: S4XcziFURoa49Kzei+L8wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34180775"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34180775"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 08:55:06 -0800
X-CSE-ConnectionGUID: FknD6V+GREqoO9iPfdADfw==
X-CSE-MsgGUID: yXZ+Eys4Smm6QKLo5epbwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97436799"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 08:55:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 08:55:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 08:55:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 08:55:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNnpnyPJ6WHoj7pZ4AcQtx2t8hIoXE7Li9+7SnlJcx+FPcUKm/rezjgWHnhQy5SzFnHbSe5eMQVeZbr/kLeXtbghPZPQH7gja+c5OEHltFX8N8u7O/jT40OfwstSJOcZJqAddn2Yp+Tqk//yrGIiXe9QppjAwV2AwbvlSdlPOAmvXOwtdfhsj9zm9JZ5OaW2M5yOMKxN+ma3bRNuwWROWfFXFxnw5GAMDmEhEp0Cms1HRCGoYLl23q7YeySbUMJ75g/NVIJBpOneGuOhZsafEqJKwAICMP0beEM6wxGd/gVTCnUlNiuAfYW27n1WnApJmhfx6jEx3kLLOlJw5YHmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWpzj0p/PFHu/HnNcWM+jmdI8k/TgUIda6+0xA2v0HA=;
 b=yBHifWTkz6qAF34jUdEZXXeblafTR1oR1UHbsoKuMSKBs4/mDtFw6Ac1DKlQnvRJZ4nYHPELqVCzEwDWO3f7HLGP+Vl5RMsHKiWzcWrFcmmyguyFGTS6DLUCQZ7wD3NavDuI69ghIhWVm3Z5nPFL687dd0iREAumj23FfEM6o1qcLyMadlCclFW+RNGirZ0l8TsyDlAoVBvQ0sCv3IYXVE7rfXi66m1FaGAFLuXTFttfghELEQXiRcQYaVcOtQYgd2KY1brFst7oEv9VcwTECzpHeZbJrF/3iCKuN816GQsESCC5ZJlkUBe55ZoQNxTXNU2zttMJ1k/Oi/pixUbfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 16:54:57 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 16:54:57 +0000
Message-ID: <b9a20b9e-c871-451d-8b16-0704eec27329@intel.com>
Date: Tue, 17 Dec 2024 17:54:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] UAPI: net/sched: Open-code __struct_group() in flex
 struct tc_u32_sel
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	<cferris@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20241217025950.work.601-kees@kernel.org>
 <f4947447-aa66-470c-a48d-06ed77be58da@intel.com>
 <bbed49c7-56c0-4642-afec-e47b14425f76@embeddedor.com>
 <c49d316d-ce8f-43d4-8116-80c760e38a6b@intel.com>
 <ff680866-b81f-48c1-8a59-1107b4ce14ff@embeddedor.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ff680866-b81f-48c1-8a59-1107b4ce14ff@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0155.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf6792e-1ec8-4e94-342a-08dd1ebb894b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTIwcURtOTYwOHBwZmNCSW9tNTQrQmRSZi80c3hyT0hVQ0JQdHRCVVBnRHh5?=
 =?utf-8?B?cmdDNVBlU3haSG1seVVHQ3FVNVMrSHVHa0hBcnRYU3dHc3plYVYycFhHQjJ3?=
 =?utf-8?B?YjkwVWwrclVldUNNNzJQNUtXVFY0UmNuUW1NNyt2dFdhb2FMZHlyVS9sL0tJ?=
 =?utf-8?B?VEcyaHU4MUJYQTZLVGhBWXpXSjgvMjZnLzBQNEdUaVBva0NpSUVwd2lDVm1D?=
 =?utf-8?B?OC9BK1NiaUpvOUlWN0dzVkUxay9jQzZ2VkREc2YyaTlPaFVIQ0FWZERiZVVi?=
 =?utf-8?B?d24wZFFMNnpDbmRpMHozeFRkOGtjdEREY3RoYnVTaGt1NGRzdE1LTndZa0FP?=
 =?utf-8?B?bDBUbEhDNnZ0djJ6aGpFNSthdE1iTFhkTlNTOU1KYVB2M2NIcndRWHROU1R1?=
 =?utf-8?B?UWdOQmVENHcrSWZUSHppekJTaUtKdnI3TXc2TFAxSUZLL3czait5M3p3MUpG?=
 =?utf-8?B?cStvRHZJVlpDc05wU3VwVk83elRnaXFFcWRoR25ZU3FDUXVoMzVkREZKRDFY?=
 =?utf-8?B?OXFINVR6eVpGeENkSmlRd3ZNengxRFlvbXNhN1orbEtRVVRYZ3VDamVNYnNt?=
 =?utf-8?B?Unk1S2M0MXVMSWdPNHlweDV2bmU0NHowbHA3THFmMlhHWWp5a1l6UDZzbGx5?=
 =?utf-8?B?VTZEUm43VHpvTnV1WkErUG83Q3dwQ3dNOTdLK2s5RnFaY2FmZ3hiS2w0ZFVn?=
 =?utf-8?B?bmo3WUZFTVExOUpHVnV5S2JkclhVcnEwVHFaQTk4UnQwOS9kSEtvNnhqQlFq?=
 =?utf-8?B?SkNrZ0xIV24yYTN3UHRMRWVza0YxT3FTdTMrazVHRlJmZWE3K3pFaHlzWEdt?=
 =?utf-8?B?QkJ5QlZ4aitSY3ltVjF2eDM3NGZYRDE4MjJ0N0M4ck5kdExuaHUvZ2NqeDlB?=
 =?utf-8?B?VDdjMzBkUjNBSEtlY2l0aGZVQTJWU2k5anlHR1pGOFVjSDNSRERwKzloay9n?=
 =?utf-8?B?L3VhTXBXcmpGd2FiNk5pdTA2dW1aTXBYVDZ4L2tNS0VnZHhXMUZhbzF0VDNN?=
 =?utf-8?B?WUpCS0M5YTN5MUtCazFBOEtZUndZMXVsWnpjWEMwUGpRRFFvaW1hSStyNnhj?=
 =?utf-8?B?UkN2T01INjRpeElXL3lOSm1UNWQwdzhZajNuVkJ1VENFWW5RRU8yNHJJN2R3?=
 =?utf-8?B?WnJBWHdxWnV1ZzVjbE80cFV2M0NVcXVFRDZRTG11bW5kZEZ3bWphQmxORWFO?=
 =?utf-8?B?a0pEbkxzbzNsak8vUW1CUFlacUIrd3M4STFzTWJVTzFEaE5WNTNUVTBBdFRP?=
 =?utf-8?B?UkZ3Mk1hUlcwTHhsMkZJcHFoeEpxQVhLZVlsSk5UYWZseVh3L1dLV1RjU213?=
 =?utf-8?B?Nm5FZVJWeFlxQmgydkIxZitHZC9NVWhKYWZUUU9WU2k3Z1MycDFkZVZxWk9I?=
 =?utf-8?B?UFFXUi9INHRXV202QVBHQnA4aVhqQXozRis2NGFDMjlkZDVCcC9vNmx1bnF2?=
 =?utf-8?B?OGdORi9GeEFDSW8zYjYxbWFOeWw4bFVUWU1FcHJqWkh1aDBFdXVpOXBqR055?=
 =?utf-8?B?T2VMU3NTdzNwN2lJa1ZFbDNRODdiZFVlc3dsS1Bpa3ZzRzhoNEUxSGZFRGxP?=
 =?utf-8?B?eEIrQUFuK2lrTk1tYThwUjBHNlBUeXUrMm1wUGtXS0VNdzh2enlqczl4L0k1?=
 =?utf-8?B?VzJMY2FTbnFzNC9tTC9jdXV0cjZLUmxWaGFkMHRramlDM3B5RHpjclU3YkZo?=
 =?utf-8?B?blVwQWkrbGY0bjNLMzRwbmUyenlkNXVCd2EwZVU3Qkd0b3V6MHpoUkt4aDlV?=
 =?utf-8?B?SnNHVzJzbWgyM2lKR2xyVlhndEorL3NtOGRBNU43VHhFdnQ0ZDdIRTcyVGZr?=
 =?utf-8?B?bTVvWmRaUjJYUzEvL0RidTF5UTgwdWlERHZrQmhFcDJwcTRsUHlRRDlSdnZl?=
 =?utf-8?Q?5X9W7wZ6An4RC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzhGeVQyWWx0UUxZV0xNTVQraVhDTTBIVzZmemlFRElnbGorS3FWdkhjS3FM?=
 =?utf-8?B?ZWtJTUxlTi95OTlxSE9NK0U5NHY2d2dhM0JvVTVmMWJOWkhjSmZ2bDlzMEpt?=
 =?utf-8?B?UXI5ZTg2UDlKM2xEekNmYzFnWUxmRDVyRGJZT3E0bGY0bENqUmdWTXZjSCtk?=
 =?utf-8?B?Q2t0amU5QjZOY2NKWCtxeTFUMmVnejhTT3FKT29adDF1UTNlUERmSm5KbWl5?=
 =?utf-8?B?Z3dHTU8wTHMzNmtlQUlvdmtQUHcyRm1sOERMK2pqVXg5dWZjRGZtRDVZUjdR?=
 =?utf-8?B?em85cno2bktpZE5TS2RWM090SzA0YnhNMHJLV2hWQklGT0N5K2lId044M1c0?=
 =?utf-8?B?TURLWmlsUXN5ZGZSSDcrTXpRNWR0UWVZR1J5VnAwMFVLMjdtMkUvUkxKOVJ1?=
 =?utf-8?B?MzFsd0FuSytOMitPRVhYRUNsdFgwN1FDdzhqdm9sdzA3NzFzK2tBQTNDcTY3?=
 =?utf-8?B?ajAxUjRvaUg3VzAvZUJrYlA4Ui9iOWtNRHk1aFZOL3lDOWZOOGZZbHhhd3RZ?=
 =?utf-8?B?WlhYZyt4TGJjdWgxMHF3Qkw2RDZhSjdKMlc5b2xTVnNVODNxcWdWTllhNnpV?=
 =?utf-8?B?b0MxZUZSZ0NZTWtFT0ZaanY0dERjVDVmY29qMXdvb0JiN1lmemdLU2s0Z2p6?=
 =?utf-8?B?NlpwL1MvdmhsN3lUK09uc05QS3NtSXBCTzh2TlVaRFVLbk1DbnhOR294VHVC?=
 =?utf-8?B?WG1ZaktzczdkVm5HZTJNQXFjcDF4dWFQbzBoWVAyWXhVQWZsUkt3VTNldlZk?=
 =?utf-8?B?WmFxUFdLSldaWllJb3ZLcWp3ckRrUVFDZjk0aisxVHJjb0J3TXBFdEJpMy9y?=
 =?utf-8?B?Ni9LV1pDSDNreUtCTkJ3MU13M3BPT211UGpIcDVlOUhqb2dRbHJ5SzUxTXR6?=
 =?utf-8?B?SHlYSFR1cm9UVmJoMFhUb0R1d2lnYWgwSC9FNklaSkJrOTZydmkxZjRoL0hx?=
 =?utf-8?B?KytZenZRUjhoSTVpZUh2TnVxVitnb0FkWXJ1dHBHQ1JrZmZWUnhDV05sNm1I?=
 =?utf-8?B?NzE4OGZGbExlOVRwM0NRUCtVenlwSExCR2E1c3huZVBoWUhROHdZZWtaWmtM?=
 =?utf-8?B?NFhiOTZONU5xY2pLSjFML2RoekV2WGpvbzFKY0NmTnlnbDNhNFo2WlRuMmFS?=
 =?utf-8?B?RDNTVmNTRWhTcnVCSzZ2YXA5YnZCZ3BOSzZPTUJESlVIZktVbEc0d3habDlB?=
 =?utf-8?B?MitTSUs1N2RReFpHZG5QZzE0VldMYkFpWXUvMGFmZHJLR2ZNVkNRekN6R3BG?=
 =?utf-8?B?Q051V1JDU1U3TzdMSWNUV3lKTWsyVjg4amkvc2xYVEc5ejJZYTUvUFcrbGgw?=
 =?utf-8?B?T0lOM0dEN1hVOTBnMStpQVZ3U3hVblBoS1pTSEZUMnNlbC94Mk56aWNjcHVx?=
 =?utf-8?B?aUd2dFl2aWVjeGdTQkEvZU5UcXMxcklnN1lOTVNvY1FGUUlpYlJCNjgwOVRD?=
 =?utf-8?B?Yjhnb0pzbUxoR20wT2duN1dDOEVBVGxualZveFdKeCtoUzlWRVFhRlZGMTg2?=
 =?utf-8?B?aGxxdElybzY0Q2NGZGV2cHBIbnBLU2xpMlZpZE5vdmVDUnBqbmEyaFpKeSsr?=
 =?utf-8?B?NkZnRjBaelRzcTJMeTFMZUF0UDliTGw0Y1NiZzZVZDc3aG8zTnM4Yi96ZGFw?=
 =?utf-8?B?YThTUHg5SGRleUpKWWcxWi9ZWjhKWmYzL3cxbzRad0RFdk0zQTZBVGN5WXRK?=
 =?utf-8?B?ZUFNOGd2eXNCTFF1a2ZiQk83Yjh4QU5ESEREWDdVd2ZLZDlzODBINFl4bk8y?=
 =?utf-8?B?R0Z0N09kMWMxVm10eVJuTzBOdzJBcUVXeGhzSnRleDdCZURqOEFtWDBrTm9i?=
 =?utf-8?B?R1NMemNKamIrd3orQ0xHTFh1eXFwNTBDUGlnZjZycmgzUlFKMEpLYmxVazJZ?=
 =?utf-8?B?VDJqc3RaakVWWHMrQ1plbEdZVzVLRWJLWWswQUk2czhjTUJsVjdDS2VDRFN4?=
 =?utf-8?B?Rkx5dzlwTUU3MDVYcDhwNmN2M3NVMVFYbDRxRk5qa2FvamZsUkpYdngyNnBU?=
 =?utf-8?B?aHQyTmxKd3NBVXo4MXpGblE3Sm5ucDlSV3BTQUJ3ZnhqZHJDTU4zOVVsaHE5?=
 =?utf-8?B?TFJuK0lienc1dEFjK2paYjZiMzZuc3c2TllvRUw2V29Xam15SkYrd2FGdzhF?=
 =?utf-8?B?RmFhVlNzQXpYZGYxUVNPZWI1SHBOOWNjR1lEUVF2dENaditLcnhzMENMcjR2?=
 =?utf-8?Q?5qB9Ikq9zUx40wLRNNjMfE4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf6792e-1ec8-4e94-342a-08dd1ebb894b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 16:54:57.1610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +36SFuJsuBWPDO4rFq3kNWkCvTVGxtZj2cEYWGrCIO/bHd3VqolyPQi+j16ZUKPA8qexN6JZeH2XVzkfsWb/pDD6ghTMQfaP+hT2OYCLRQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com

From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Tue, 17 Dec 2024 10:25:29 -0600

> 
> 
> On 17/12/24 10:04, Alexander Lobakin wrote:
>> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> Date: Tue, 17 Dec 2024 09:58:28 -0600
>>
>>>
>>>
>>> On 17/12/24 08:55, Alexander Lobakin wrote:
>>>> From: Kees Cook <kees@kernel.org>
>>>> Date: Mon, 16 Dec 2024 18:59:55 -0800
>>>>
>>>>> This switches to using a manually constructed form of struct tagging
>>>>> to avoid issues with C++ being unable to parse tagged structs within
>>>>> anonymous unions, even under 'extern "C"':
>>>>>
>>>>>     ../linux/include/uapi/linux/pkt_cls.h:25124: error: ‘struct
>>>>> tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,’ invalid; an anonymous
>>>>> union may only have public non-static data members [-fpermissive]
>>>>
>>>> I worked around that like this in the past: [0]
>>>> As I'm not sure it would be fine to fix every such occurrence manually
>>>> by open-coding.
>>>> What do you think?
>>>
>>> The thing is that, in this particular case, we need a struct tag to
>>> change
>>> the type of an object in another struct. See:
>>
>> But the fix I mentioned still allows you to specify a tag in C code...
>> cxgb4 is for sure not C++.
> 
> 
> Oh yes, I see what you mean. If it works, then you should probably
> submit that
> patch upstream. :)

I added it to my CI tree and will wait for a report (24-36 hrs) before
sending. In the meantime, feel free to test whether it solves your issue
and give a Tested-by (or an error report :)).

BTW, I mentioned in the commit message back in 2022 that some C++
standards support tagged structs with anonymous unions (I don't remember
that already). Would it make sense to use a separate #define not for the
whole __cplusplus, but only for certain standards?

> 
> Thanks
> -- 
> Gustavo

Thanks,
Olek


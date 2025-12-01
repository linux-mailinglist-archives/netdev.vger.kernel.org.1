Return-Path: <netdev+bounces-243087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1290CC99675
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00A044E0EFA
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52124E4C3;
	Mon,  1 Dec 2025 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KX9fajb9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4179CF
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764628852; cv=fail; b=rYFA0XvVMZoTQ0KmX/vkS6uR1gMkBbdbvJQImFO4YjhUpQQ+43QY/EcOU0ydD+vQWu7MhSWPsMLjfCj60us7zkIPChpUx6RSfQ+3YKZyRd0zzuTUjTl4KKeCXzvRWA0z30v0KPAgFSN8FHpudGYpRm7uGXRLaMTnxk9xnXJUDV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764628852; c=relaxed/simple;
	bh=n2h2nHNbArUQnN6O4gpZ/A3O+obiglnZ35ylT1+3ZBg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rL4uUX5fv5fkF8JAwuyRwDZypRcXkkP9dQtcWaL7NZrK/aSfY0x0nUQHP245pK6tJkQ9eF7W53NtcKIsOM4qR0tDe//LEzLUZ/I3cXtuxbpV+gHRXFOMtOIQIutZuRxnozWBW9GH0j3I7vbtYqWPtU9rP6z5dp4y+E/ZVlOg0hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KX9fajb9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764628851; x=1796164851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n2h2nHNbArUQnN6O4gpZ/A3O+obiglnZ35ylT1+3ZBg=;
  b=KX9fajb9HiZSoSaH5nvhuD85OlEjJOEW2PwCTdXOJ63kzfxD6WVTKQLh
   Nc4z0VdbiJoiQqGt8nTiElrfjrPQlh2YB9KCgd35z+nZBxS6wNWbyJK7U
   w0VWntC5pJpiCkQYNwYZZzuPIRZqTA+a5P9dw6YB92bjEVuX+4xY3NVJf
   oq5Yg19qK3ni2l2AkRr7Crmuv/zwzycMGp6oHvAVIY0n57gOO7//medVQ
   8pqmWGTkZJptSFDF1LznpnrAIhwM6TjfzlkwRUkfDhtralPOKbnsU8NHH
   067Tn7d23QE7JOyd9TVyYQKKEz7Ws7i4ox9lWZeNQObpmY11mBR297d6e
   w==;
X-CSE-ConnectionGUID: QpKNPS5qRbWRjgHji3I66g==
X-CSE-MsgGUID: sCn5O4G9SY+94rgrYgkzOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="77684025"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="77684025"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 14:40:51 -0800
X-CSE-ConnectionGUID: FQq+BHJHQuGJYChKDrFoow==
X-CSE-MsgGUID: iBLicjFtQoOAjKYNCUI7UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="199130620"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 14:40:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 14:40:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 14:40:49 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 14:40:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNK1B/odARoEL39rt2XTmqg8V3dmY4yQwMsP5i4AGB6zSznLFJRmgEq9cNP5wcpJhP09IUG/7VWHfAfCVFO5/Mcu5CyOCYkfrVLzicjRk79i24lUQsTQoTnsjt8k9rxNuRkP+Hb0ndpWkaX3LZwtB0U4Ki1QxeDAD5y5OYL9HbBH8/SeYBlJUDQuEZIIMFDJdMdZ4DBMsfykhrQBL5WCE8F7HbnECtTbBVeL+PBGjm+f90Sm9njIfIJC48lQHTemkpR8LYUuXq7kdpcQasLYMzJ5q5/eqBRMi8Cc/Vp8m+uEsPxRsPCHcI4F0JGTC4zx1jg/l9oOOkDGhu4Q+RQR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeXgpX5q24UX71YeSTJ3w9n9JiO5iR8RUIfDXO0iwPo=;
 b=ob6VdcGO9rMALMR5JLDh/RmqSSOBYcG597+0OAnIQXFKFgEePr82slpJa+AOa5zVoui2Fx4vetiaC9CJBgQn7SZ550fRNQuidVeAvO9XylRCh9YSy+Nqz/EcG8qoHJpRi6QlnQLp2yTP07M+8CEXfgFgCJ1DFw/mtC5C6SSFPPaHzF8I80dpNOwIXOUMD6AAN9LTTI9GJnu3KupFNhMDrlLEjNDqKU+96Bin7SVMryrnJUOKpnvK+1dmaTM+jvmrgl7nsgEsgGNHrBvY9CbZAexMeUIgmAtTbjlOVPJpsMrV+Gi0UvksIzUS1MWJOGD8bcTuuza+iIfsXWZXdAWERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Mon, 1 Dec 2025 22:40:46 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 22:40:46 +0000
Message-ID: <fcca2ea0-b0d9-4332-91f1-153be2063788@intel.com>
Date: Mon, 1 Dec 2025 14:40:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/11] ixgbe: Add 10G-BX support
To: Birger Koblitz <mail@birger-koblitz.de>, Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Paul Menzel <pmenzel@molgen.mpg.de>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Rinitha S <sx.rinitha@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
 <20251125223632.1857532-4-anthony.l.nguyen@intel.com>
 <20251126153245.66281590@kernel.org>
 <93508e7f-cf7e-40f6-bf28-fb9e70ea3184@birger-koblitz.de>
 <20251127080748.423605a3@kernel.org>
 <49020773-43bc-4c46-8f95-a5436ca78891@birger-koblitz.de>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <49020773-43bc-4c46-8f95-a5436ca78891@birger-koblitz.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DS7PR11MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 97df3055-7c92-44a2-b797-08de312aab1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2dEbXdHUkw0RzFWMjZ3TDI5ZUJhQlF0SUxSakJaa0NDWUNxVWx2UHk2elJV?=
 =?utf-8?B?azJ0dzlKdjRYSUhMMHhXOEsvZFBFUnZON0RNSUVtQTRHczFmOFk5RS9Qa2c3?=
 =?utf-8?B?S3FzOTBOS1pMaFJRQWVIaVJvN0dmdGNaeWdyczNqZUpIMUlPNXNpcksxa2xB?=
 =?utf-8?B?d3dza2p3R1VkK2FCcENuRjN5ejNsNy94YnQrRjlMYktzbEZNVll1NmthVDln?=
 =?utf-8?B?bjdqMUN4TUVKOE5IdGdXMGJUc0xHc2pXclliSzdnSmthTjdyYngwbGlwNzl4?=
 =?utf-8?B?OFd3aDE5cm85clZjTVlIa3hBaGZWanRWdjJTQzErblAvdU5LRnJxV3B1QmZl?=
 =?utf-8?B?RUhnb3NHamZZQVpKRXVzRCtjRU1PZmJYLzJmOFpYUjZ2a1gzc2ZSbVNqM2pt?=
 =?utf-8?B?UUl2eDUvVGpsUkx5dDkxZEFMelB0MXB4TjdKMW9sWE9rb0xtTTlVQ3RjUDM5?=
 =?utf-8?B?cVRrdXVwYXJjSENSc0I3ZTdjd3ZmbkZUckEwVTllOHF3SnJjYVhVK1hHc2VB?=
 =?utf-8?B?WFNuQ2pUa1B2eitHLzIrTm5wTWhBUGdkZm1aOGUxVXJEN2twT2M3RVZZZDlB?=
 =?utf-8?B?OVBTWWd0MDBBQmhvcFJQRWUxNS9hL3pJNDdCM0NqeUd6bDVvSCtrdTcvVkpl?=
 =?utf-8?B?WXZWZ0I0bStlNGVCQ2pNRXp3cjAxRVhod29rd05WMW0rczBaYWhHV0ltV3gv?=
 =?utf-8?B?U0UwQzQ2WFVRc0JGd1NmRmhoUzhYOFQ1SnFzeE9laG53YXRlS1hHcDlad1hE?=
 =?utf-8?B?aTBrMjN2OThRSTVaNWlCSU4xMjQrTHBwWG1LZVpEVWEvcnB2NnVpQU1adzdm?=
 =?utf-8?B?bCtYOHZxMjFCN3ZVTmk0bGdDR1h0MjExSmQzU3luMEpOQ2d4SVFmVHJyYVFL?=
 =?utf-8?B?QVNrNVVxQjkvcm51R0ViZkg4VVM2VitBcmZzNnVzTmxFRmFlVjFXYk5DUkNS?=
 =?utf-8?B?aUNROVVtM0l6dmduMFRuTU5SYUVkSEZ2V09KOWRnQTdZcVhrR2NCWU9iTVRB?=
 =?utf-8?B?a01EN2w2RWtSSDZzMlpDZi9pdjNBQmpCSmpRRStlcnIzMGx0bmlLYkhPdVJ1?=
 =?utf-8?B?cHVnak05WTdxdzJUZVlkR0tHZTlmNlU1V2NXUnVibzJpN1h6Z2ZBNXhmREVa?=
 =?utf-8?B?Q2xPWjE5SDZsUGpZN3VkMUNTbXdub0lMdmlCbkp4dDNudDVnUHBHRWNqNmds?=
 =?utf-8?B?Z1p3bktNUFNNa25lcFZZZW40L0xJSFo5SU1uYndjK0FDSmVXN1VyemY3Qkh2?=
 =?utf-8?B?d3ZzZXRWanR5eUpmYjZuUlVDN2VJUUJLZzExYUJXTEdsb1RkSzRWZXRYeUpC?=
 =?utf-8?B?QVZCa2FtRGFLYVlkME83NTZISm85SEVhZzRuVUZUWVR3cElhNUg3ZUhsL1BN?=
 =?utf-8?B?MmdReUpGbU5xN3hFYnp6aVNmYjFCcnFoWjdYWnlUeG14eHkwLzV4NnFqV1Bx?=
 =?utf-8?B?aUlkOWxMVERLMnRCL3IrQWlIS2JxZXkzcTdHaWlGemxLb09QU3ZWbHoxZThv?=
 =?utf-8?B?MnBxU2JKYkFpUXZJUm5ueEhhdTZvY2Q3SUk4eDVIZU9jUXZ5d1d3bWlzU3Rs?=
 =?utf-8?B?QTZpejB3VFZ6Nk5EM2hVYmg4UVRkeDFZTFhvQ3FuQ2FlbUJTMWlwbG1mQ0Zw?=
 =?utf-8?B?dUJoaUZoem56NHFTdDdDK09TREZtOUNMQU5vWGlhS1dETFEvYjBNcVg4NGt6?=
 =?utf-8?B?ZTBtNkpkTG5TWXJDR2hja1liOHRZcEhBZk9XdFFkMEs5eHJEOVg3SXpzS25j?=
 =?utf-8?B?T3hPSnNjcE84M3ZIT2JZOHRuekZPamFLWG94V29WdmhCR2VkdXFkNG5Weloz?=
 =?utf-8?B?WHVQVnVYNTZ2WmVzQnhxWWdsdHJGNWF2V2xteGxZSlJINWdBUDRyb1VlWHhs?=
 =?utf-8?B?djFLOTZBUUlNdVZEOEtVbVpaTXRQc1QvNWpETFF3WTRqZnhNN0NQNytwcHRK?=
 =?utf-8?Q?8nFPQAKZ8qejbSKLDs44ziaYrmkbqeOC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFQ3YVlwSVRud1V4UVh1Q1o0a1grQ0hwUTgzR0s3TWNOVVJYaXJ5WWZ4Rklt?=
 =?utf-8?B?UGxWYUd1ekY1cTQ5dUI1R3FTWFBibEl4a1I4WlVaclhUa1MzanJZR3VMRm9n?=
 =?utf-8?B?V1I0ZlBDMU82eHI1ajdWaENDZ1hqR29NQWdjc1h3RWpCeWNvQS96SG51QkZj?=
 =?utf-8?B?MnNRQzMwQU9NQnBNTmFoZEY0c2NHTkJOSFMyZHA5M2pGVkF4MEkrZWV5TmUx?=
 =?utf-8?B?Y2JLNjJHMUgzNDBJcXNubzF0emlXUzV5TmhoUE1ITUgvdXNmaXdzdjZoTzRs?=
 =?utf-8?B?TVZ3TmtRekpPdnU0dk1IWUttSWlJcGRsVTU4V1dqRVc2TU5uS2tiQ2o3VVFP?=
 =?utf-8?B?a2ZCZzJKN2k3T01RUm1KNVpHbWM2L2dRVkNXL3pnSXlJOEo5SDh2aTFxMFVO?=
 =?utf-8?B?WlVXczZJQ0VzTkRoZnM3V0hJbDJlZVBUb1VId0c1RTZ1WGpHMGdJOGx4SVJs?=
 =?utf-8?B?WkJ5NUlLQmFpdzhyQ2RqN3pwdk5DaVFFd0hwNlBPVVdwWUVWcVdVSUowUVBk?=
 =?utf-8?B?bFAwc3lVSzU1VWlTYkdpa00weTJsSHBFbDFPVUprNlljMlV3OXRNaFBBM0hT?=
 =?utf-8?B?Mnh4YzBHV0M4WXV4emtWWUx4Y3dlS3FvRUloalNXbG52MENzZlF3N1VHUVZB?=
 =?utf-8?B?M0ZpcTFxdFI2dHVRTUt0WWphY0d3NldPbzk4aXh2SVozSTV3eDM4Z0hFa1A1?=
 =?utf-8?B?Wi9SUjZpV2czMDI4TzAxOWdWYzJBeVdvT0NoY0ZmeHEyQzRCWWJJVUtwTm5J?=
 =?utf-8?B?Ly9TNWlhRFRaMU5EL0QzeXRKTlducnkzeTlRUE92clpndDdwa3JXNDMremFq?=
 =?utf-8?B?cnlRR1dEa3Faekg0RUNUZm1oTVB6Qi9sd1NyZ2g2S3VUM3phUkEwVVlHdWJ1?=
 =?utf-8?B?THlGN1lJbWUwaG1zbndCS1BTTXZVdjFqNjFQUkovRU9xbTdJODk1RnhHbHJB?=
 =?utf-8?B?YnM4UWJkb0hrSlFFZ3VIRkpSdVVuT0tjTnAxU2FNR3NxbUhvSmZXdUw5SlA5?=
 =?utf-8?B?MU9vbGQzSXM1TG5Ic3BJOVR0SVlOYjYyTEJsaWpBSlNlVnpZbzdMckVoUmQ1?=
 =?utf-8?B?UEZKTmxBRFVyRUVnVVM5QjhOeThBbUdaeElqUERUNENpTThGZk00YXJqSHB1?=
 =?utf-8?B?R2NTNHpkRzVnMlF1eEU3aCtEYi91MHZvM2NzR3RSeFhjeEwzU1p2ZjlaK1Nh?=
 =?utf-8?B?UUo3STJMV0EwQU9hcVB1KzhTcVAzaHpyQ0FzdDRuWE80ZytwWlFDR3o0ajVz?=
 =?utf-8?B?TE5RNWdDRm9GRDBubkVGK3FIVG92R1NxYnRnaGFZTmZKR1k3RlpHcE5iRE4x?=
 =?utf-8?B?VHlYeTBCL2RIZGpva1VxNnNRWHR0bDc2RExpZXQxUE92bW9zd1hCbytZZ3NB?=
 =?utf-8?B?ZDdKTFlLUWZZL01ZdVlDVFBWRW1pQTZLOWxpZWEyMGpaNTZIZFpNVmZmVDI3?=
 =?utf-8?B?NmVkNUJscW94enJza1lRN2JDaG5ZZFdQdWZoT01nRkdCN0l6SXhuZUFHb2lV?=
 =?utf-8?B?Z1l0SXZWeHR0U1Y3KzVVYzdIcWkrdDJLaUIwQzVEYjdpOFg3TkZNd09jRFdl?=
 =?utf-8?B?dWNOVkN0OUJONm5Rb3libTkyRm5LVU9KaFAyQzU0eHRNVVlKdXc2M2RJSnJK?=
 =?utf-8?B?T1VNb0x1Z2hud2x0T2MwMmIrV002SkFLeE9LVU1jUmppM2lGOUwwVDJCRnJz?=
 =?utf-8?B?Y1RXemVXTnRhQ3RRSXhrZ1RQdzRMamNHV3NDdHc0OUJPU09IY3pta0FmdG5h?=
 =?utf-8?B?czRQcU4zaUNuSmk0OGI4YTZaTTFMajBWYzk1cGhWL2RGNTd6VkpFclpnVTZv?=
 =?utf-8?B?cnhhNkNVTFVaa0VaTEZmaWhLdzl4aHJhbm1rWmxWV0JaMThwZmZRVnBPU29l?=
 =?utf-8?B?UFpVdnJtejJVUTNBSEJFY1BWNE1JRkNOb1EwbEp2T2pUclhsZS90QWtoUVZF?=
 =?utf-8?B?Ry9zMkFaMDhwWThHaXhuU1daR1V4Q0YxMGlUdEptUHZ2aEtERHZhWnlSYkQw?=
 =?utf-8?B?Ui9rUUZmUTROZE5zY1M1YWhLZkQ2cGwybnlJOUMreG10NnBhb3Q5cmN5L2Rw?=
 =?utf-8?B?eTVaRlVTY2dubHRpdU82Vk9MRXhaNmVCbE5uSUhLN3FtblVDZWhpb1pRL3Yw?=
 =?utf-8?B?YURJSjhiRDAxQllJODhOMkJIcGVGMGJrajdxdzU0Z3Jpci9PdXE5MXdUQUN1?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97df3055-7c92-44a2-b797-08de312aab1d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 22:40:46.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0UPcbi2vqjYDinmc+ZsBZJFEI5SpVfxF+sjrUwc7K956KTHyv5F6lzU/tFfN5gmBlY4OmbEiZ5iBCmLg61k8N8S1nN7gbwJP2amFaoJap8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807
X-OriginatorOrg: intel.com



On 11/27/2025 10:48 AM, Birger Koblitz wrote:
> 
> On 27/11/2025 5:07 pm, Jakub Kicinski wrote:
>>>> link length requirement isn't met?
>>> The ixgbe_identify_sfp_module_generic detects SFP modules that it knows
>>> how to initialize in a positive manner, that is all the conditions have
>>> to be fulfilled. If this is not the case, then the default from
>>> ixgbe_main.c:ixgbe_probe() kicks in, which sets
>>>     hw->phy.sfp_type = ixgbe_sfp_type_unknown;
>>> before probing the SFP. The else is unnecessary.
>>>
>>> If the SFP module cannot be positively identified, then that functions
>>> logs an error:
>>>     e_dev_err("failed to load because an unsupported SFP+ or QSFP module
>>> type was detected.\n");
>>>     e_dev_err("Reload the driver after installing a supported module. 
>>> \n");
>>
>> Got it! perhaps add a note to the commit msg or a comment somewhere to
>> avoid AI flagging this again?
> On second thought, and while thinking how to formulate such a message, 
> maybe it is cleaner to set hw->phy.sfp_type = ixgbe_sfp_type_unknown
> explicitly in an additional else. Otherwise, if the context of how 
> ixgbe_identify_sfp_module_generic is called could change in the future 
> and then something unexpected might happen.
> 
> I tested adding the else and it works as expected by not doing anything, 
> the variable is already set to ixgbe_sfp_type_unknown. And I also 
> verified again that the current patch is also correct: I made only the 
> length-check fail and indeed the default kicks in with the correct 
> outcome, that the module is unsupported.
> 
> Since the patch is now submitted in a series from Tony, I guess the 
> decision is with him. I also am unsure who would submit a fixed patch or 
> added comment and where it would need to be sent to at this stage.

Hi Birger,

If you could send/treat it as a new version of the previous patch, and 
send it like before, I'll handle it from there.

Thanks,
Tony



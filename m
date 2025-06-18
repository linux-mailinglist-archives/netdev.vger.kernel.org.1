Return-Path: <netdev+bounces-199147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A59ADF2B0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6193A2EE3
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CD62F2720;
	Wed, 18 Jun 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LolPXpn/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439942F003A;
	Wed, 18 Jun 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264187; cv=fail; b=ed+Zgw+o9z14LcV9Ygg0khu31nBCORUj+byFQkHAsPoEvYgjp6bT80GUSnbCcyrPuiT3XGLgebUlF3U6/slmLGdxDD2anqoblQ1ztQHt8HMrWt5RQpJiR+11hUiDvpixV4AsCNu3hwn1NLqroWEY9kW9IOFpcojt9BRNy9tf9dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264187; c=relaxed/simple;
	bh=1opF8qMWcPBUUUBGsQbwNTZCr22dlcyVh1pjw2r6p30=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PiwnELRxLtXE5h9ZFESpLU/+niymu+iUYxgU8uWPkmX9W4z4cFuhr9PWBgtYW6qKzsx0Pu+nIBsFAzfd3QafWMr66y/gZ0+ZjxdXO9OR1WG816Gmy66R4FpHBysIVy+G9dROqaMWBd3KhWmwj2OJmNQ529cEjqZ/X8+3cnsdMjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LolPXpn/; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750264186; x=1781800186;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1opF8qMWcPBUUUBGsQbwNTZCr22dlcyVh1pjw2r6p30=;
  b=LolPXpn/BL9p94+7LfVuCMzFJi7Tp6UJAcjCeuSxolm/CVkK8uYEFYcU
   7PaRYb+V7lKqX8OfJSJ3awU/VobMfWEJ+H4KikwQgL6+b9qTDnAgCVLzO
   I0+KXWH1cZympoFC6HBTdyVRfoCkk3LyVzxjkRG+K0n4yAiAYTnjqswEr
   1YZPNv+T1DJ3Gnyx4B7FPWNtmAwU1jk73Q/emXiWGzlBgStNugzAjXNLA
   eRvAR3TeTZQ+aEBQ5/E+digep+Esufgz7dx+TlXfWp50VyiWiZZgnnS48
   /M+FhIcsnVzfr6pUCInowvnxnu0ACIlucUdEPkLd0mZu0Xudk7qJnm911
   g==;
X-CSE-ConnectionGUID: UsZm9K4rQ/69dqQJJ0HcEw==
X-CSE-MsgGUID: rkr0C+p0QjqW1hnxR7+CHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="51719794"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="51719794"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:29:45 -0700
X-CSE-ConnectionGUID: H40ILIZPTH+31t7fPsls2g==
X-CSE-MsgGUID: n5AAFaSmSVeOwG8xE4omGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="153784575"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:29:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 09:29:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 09:29:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 09:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghSDLPciDTTn8WflHwNhmHOhOOVyfsTmSGpshFwg8RRXdSAq6V30Etf+Otew07q2w/NvZ260iSIih0/bFvZmBfbpLS5qiCc565hQIzj8aZTDKdKURJL+1G5CapVeC3FnYZxr0243u2nb/UsBwoNWJ6Er3F/Iw23qvCsKESAGjxxqrqlkoUKDcsAOOdgGKrt55Hz+XklnzqrIfkHgphqLnVGxBa0M1W0bUIzBZTDDO2P1OzEnf+ju6718wC/CtiUDU7+wXhUFt4fLOHHzpvXIZNSZVmuSKsWi9tFNfynHwKIFDjtxraZDtCF3CaUihmp5fYZ71Ep7vzAye0bH/YgKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYclRk96W8Z6YxpKXdKSfGzS+UZqrnnomEl60wIgEfE=;
 b=f0S1STLZqpzFetInHGMPxRJ+GdMYCKyE+RVqUf5GWuibshmMKR9iWm+d4rmnneNf0STrXbeeo+8Tt3TpkdBnnB4W1265x3OF0F01whxbMb7VqHKc+NBh8gCS6PBunpecHKGxthyCorjPYpic90khqWZiWwze7HLPLn8mPF7z1lVCJeJqRVOyDYjY+VR+kWynY4BjmzRO+5obj1pC5L4j7AbV2tFpLndkh3YnPI9kEapd6qQ/CO0jFGB/vgjVgjdoN5BAdjg/GRHq6bueGK5QmMVY9/wq9fdxIATy0UlBSiacGTw5iHNblMzSXfJ4im8zaVIrwflJKyUfJ9Ku3M6eXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV3PR11MB8726.namprd11.prod.outlook.com (2603:10b6:408:21a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 16:29:41 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:29:41 +0000
Message-ID: <eaed1854-ec73-43e1-b5c9-5a2be8268ffc@intel.com>
Date: Wed, 18 Jun 2025 18:29:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] igc: Make the const read-only array
 supported_sizes static
To: Colin Ian King <colin.i.king@gmail.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250618135408.1784120-1-colin.i.king@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250618135408.1784120-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0004.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::35) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV3PR11MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 007bcf10-bca4-4858-05d3-08ddae85535a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXlCc3RLSlYvc3FrMkNxZmJycjlBRnBLZzAzN1Ria1BBSmpFdVFSN2p5MXhy?=
 =?utf-8?B?ZzJjK0F4SHdCUEVjc0VmK2VxeU1Jd3V0REg4Zms1RUsrN0JSN2RHYm5xc284?=
 =?utf-8?B?dXYyUFRmaWZjWGVOSWZuNkRGWU1QR0h6cGRyaTBUSUhmdjIzaU55QUI3cVBw?=
 =?utf-8?B?YWs5bE5DZ1pRY3g2Vlp1bHd5NUZnT29lVk1jUkFnT1dZWTlWRGFGRDNoREd1?=
 =?utf-8?B?WlY0WHdqM2lwOHNLNzh0V3B3Ykt6VnlSSXZydEJOcWxvTXd5bVhlZU0ySHpK?=
 =?utf-8?B?UFBGdE15WG9Bdnk1a2F6TW96ZUpGbHVUclFnWUV4OFJPZy9ldExMZG1oVkVG?=
 =?utf-8?B?dncyd1I3dHh1UmtNVFFtaVN5Z25XVGczL0V2Z2lISGRrRjkrNjJpcG5GeS9E?=
 =?utf-8?B?RldCM25PUjBGcGZlNE5WL3JSTUdNK1crZkhnb1RJc0pxRmtSaDV3VkJ0UWU0?=
 =?utf-8?B?K1gyZzNQVSt3elZqMElYendjSnRQNm5lZy9vRjcxb1JXa0s4WHQ5NEZNdDZ1?=
 =?utf-8?B?d1VRRzRUVU1YbkE5Y1RmMG1pVjQ5elBSZWdxMWtDZ2hKWVR6RHdOR2FnY3dq?=
 =?utf-8?B?eDZRV0U5b3F5ZjNSQ1dCSTBjU0pGUE1rL3FlSUFTQjdGNUtCL1BFeGErL0lu?=
 =?utf-8?B?Y2JDeVhnOEpwTDVVck5tMVdsQUc5UVQxRWtpN0k2VWx5SUdyMEJhMmxvM040?=
 =?utf-8?B?NWpqZGFTZk5yUUtTdkxIL1d1OG1WZXZVQVBJUkJLTFVMUmRrUEtwMUtsTURE?=
 =?utf-8?B?WUhCcUxLc0VFMUpTNG12OHpPLzhtV3JTektFRGxOMGNHUVRlb3BsNWNEblZ6?=
 =?utf-8?B?aVp2YUY5Z3pIS3Y4eE5CTmQrN1Rta3Y2aCtnb0IxSVZtUGdhaEhnWXcxWHFo?=
 =?utf-8?B?U0RDeC8zOGs4QldpSTJqckNRMXo5Y21ZVlRWMFZvSFFmVjZwZkp0NzFIeCsw?=
 =?utf-8?B?cmJoRVFSdFhMVVBMalAxTndieWsrekU3cTdCaU94aW9KOWYxUmU2c0FPdldy?=
 =?utf-8?B?UGlvRGZCSXhlbVJJRW53bjlHSW9SODhqQzk5RGJkT0hLOHdBRmVtYW5hd3VF?=
 =?utf-8?B?TUE2OVFZb3dENjRPa2Roa3d6bFpDWHVoY0hKTjYyQ2MrMzBmMnladnBDNTQy?=
 =?utf-8?B?RUZ5QjJUUzI5WjVscXZJNVBEVkRCaDBhM1ByZ3hMT0VHQ2cyVWNpdVFMTUhw?=
 =?utf-8?B?Tm4zdmlwRkpESy91R1pSU28vaFVaTWRoUnRTQUhmSFdpeHhMc0toZ0RsQkFv?=
 =?utf-8?B?ZEczZHc5OWZ4WWMxZSt3UWI0dmN0TVFJbHJ2cGs4SWZKOXFJTHdXcW8rbVJ5?=
 =?utf-8?B?c01yQTJPc0JTd2RUbXJsRnFzeEtoMnZjUll2d1JpVVNhKzhTUmtDTWd5bzlR?=
 =?utf-8?B?eHd6bXAzdi9sb3VkVTQ2bzRNNnNxanY2bExvVGRSU2FtTGUxN1BZbllFUThz?=
 =?utf-8?B?bkRVOU93N29GNVJNVnoxRkhIU1NKTCt1SHo3Z0VrcjFqeHlXTnZOZWt1S0tH?=
 =?utf-8?B?YnFZdW5qbHF4QThLbk5UbEh6OXhVV2ZDUjJYcVdmL0pMaXg3S1B1Q2EyaUt2?=
 =?utf-8?B?WU1ERmFzVURmQ3RmUjNjcEQvckN6SUdBRXJjUzljYzF1bWNIQ1VOMU9sTERu?=
 =?utf-8?B?ZnZXQm9WWC83UnJxQmVsTEpsNE11SmlzaWw5My82SlRCTWZBUUJvbVhoaGJR?=
 =?utf-8?B?VHFnZmllcnltd3ltQWpmTG4wa25SK1dKQjc0L3ZHZkdRSE9vV1pkbndIZXlq?=
 =?utf-8?B?UVBuRG9RT3ZUNW9qMFpvajkxTk9rUXE0dnJxT01OcjFSYVBiRUNDNThXaVEz?=
 =?utf-8?B?MkIxUVlaMXNIUDVwbFdvZzM1RDVxcHVhQjVzY01qOHl3aEVXMnhGcjdaTE1V?=
 =?utf-8?B?Zk9ub01WSFFQQTZabFM2VTFtcW9IbHdPVFNHbEtueHNJdG42cXZWVzU5TDBu?=
 =?utf-8?Q?aa45+TT/p1U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2dFSmR2eHJNY1R1RCtFZVZKNWpnYUtwenh2dW9yUEpwaC9mWUFQTy9DaG5x?=
 =?utf-8?B?UUJxMFJZSzFLWkV6MGF0c1ZLR3hvbXJWTDJMK21iTWFaTmxXQ0xIM0FiSjRN?=
 =?utf-8?B?djVXTG8xb0R1N2JmR3Y5ckp2WVlDZzJHMVZrTUpJQlFlN3NEb3BETmhQV3lq?=
 =?utf-8?B?ZWZhYzZjN0sxQk84NzN0dVd4clBiNkFzaWhYc1E0cWhHZTE4Qno2L2ZETE8x?=
 =?utf-8?B?UkxwU2hTS2toM2VCZjZ1TlhyS2JjcUs2Qk9qT056ODNVbXkrNis3Q2MwaU9O?=
 =?utf-8?B?SXB6Q0ZIVWE4RjJSUXpxQVNSUmF3TUJUcUYvS29temxDWm9XTjc2ZXAzRkR5?=
 =?utf-8?B?WFc4TmZ5NnZBaXRuaTVva1llVW4vVmM1TXRWM0NQZElqWTZsS3FjK0pFZUhJ?=
 =?utf-8?B?ZWVKc01lV0ZIZ3RTMTFacUxqVklvTU9CdUpSaXc3OElCeDlDQzlubFBuTUNm?=
 =?utf-8?B?WEJ5bWZGWUFFY0I4OGlLVjJPNm9zUFFXbzRtdGxsNGIxVVVmUE9Gd1lwYlh3?=
 =?utf-8?B?THlvN29NaVVXK0NCdm1SZHd5V2YyUzZZRlo5bHk3ajY4NHhBTE9GYUxsckVt?=
 =?utf-8?B?OHgzeXdNa0l4ckQxaXJvbVFJdHJWWmJXN3krVll5RHNIZ2VzOGk4WU5JQnRa?=
 =?utf-8?B?RE5MN1FrQ2tkLzIyZDRMWFVDenJkMkNzMEJMNC8ycTFSY3Z0OG81eXNIanB6?=
 =?utf-8?B?RVFMKzBWdVJEbzI1cEhQRHNFMnRvL0pzczlCcG5DS09saTZHZWVCWmtaYlFG?=
 =?utf-8?B?dzA3M0hUdzFXYjFZMHhyZFBuR05nbmlkUjhzSkRFZjJaeHE5OUpZYTFzY01a?=
 =?utf-8?B?N2YrTDJQSTVwTi84U2lySlMxcUZWVDFWUXZ4Vk5MUGoranY3bzJ0QWFhNEFB?=
 =?utf-8?B?eTB4QXBPZWpjenRKMndYeWRmRUNwMFhjMjN3YnlzakhCUXZSWHZCWmwwNTBs?=
 =?utf-8?B?NFo1WWxnSzlUTWF6NWwzeTA1RGdHNG4vWU5QNjU1UnpXRG14KzFlbzI2OUpn?=
 =?utf-8?B?MVcvUkFqVGc4dnFuaEpUR0w3MkJxT281ZzNQQ0J6MUo4VERjTDVTbUFVdVBY?=
 =?utf-8?B?dnF5NEV3bUw1ZHF6SmQyQi9HbXFzd2dBd3RuNTZRU25nWlAvVjNKVmdOYWZo?=
 =?utf-8?B?cExUcitDOGVINDR2eTNxUGpFS3ZydWR4bE9YNHM2VHdPNXlIVmtHYk5VV3lS?=
 =?utf-8?B?eGZGdDZ0OUV4Mm5WR3pZSkY3VU5pcmNVR2M4ZGhNM09IcUlsT29VZTdHWEEw?=
 =?utf-8?B?UlVNWjN5TzFKZHd2My9vcFl1WURSRzRkSG5zYldlYlVxV1lHUU9JRElidWsv?=
 =?utf-8?B?VVFtMzVGa0lpTlhoWHg4Ti8xdUdZbVZCV0J4R2V3U3N6aWk0aUk0cC9qNVZp?=
 =?utf-8?B?c2N5L1F4S3hZNDdlMmFkcnNwVVY2UWUvSE5oMWZMaG93aU9mK3lZRlFuMFlZ?=
 =?utf-8?B?V1piajI5ZGVaOEh4cFhHNUxqR1lTR2Q4TXc2Y2FlcU4wRGFIQnUvSXJwSjZW?=
 =?utf-8?B?LzJ5bXNaSFd0N2o1UlN3T0taZVJGM1h1UnJ3dXVzQ1dzdkY4eVdScVd5enBB?=
 =?utf-8?B?akxkbWE0YVNYSDV6MWRLdTltdmx3M01QYmNJN3pPSStBazhZNEpNbDF0ZWxQ?=
 =?utf-8?B?ODJOZzZHZkU0NEhRTy9naUYySnpKc0RjQ0dVVEpwNG5XaHNjK3JtUklwaHlr?=
 =?utf-8?B?WFl5SWY1emRJMU51M1MrRkcyb3YwYkNDbGlRcnJDbkhFL29UanN5bUQ0ZjNY?=
 =?utf-8?B?eVJnL0tHTTY1WGpJSk5PVExxb0dhazUvYmpJdThlTGR4NUx6NHNwYnhBOTln?=
 =?utf-8?B?cVZ2UFZRbTBVVlk1YThlRGJNNWRKZ1R5M0tHWERBVmI1Mmg5cGR4NDBHM0p2?=
 =?utf-8?B?WjdwaDduUEllcCt4MHkxTm9aM2l1ejhIQXFUY0pnekc0ZXZqN09PTytsNVNh?=
 =?utf-8?B?dzk5OXlNdDdSejJYQWhvRkY3aVVkL1lqOUc0UWNCSkdnemIxSDhCM2UrZmRC?=
 =?utf-8?B?MUV3UWc0QkVOWE0vRmx4OVhleWFMQVVwNmZuVlRTYTFlTzZIU2kwMjVSM0tl?=
 =?utf-8?B?UUFock1NU0xJWXV2NXJVTDBCeG5aUEtNVGVtdXl2ZUtLKzc0bkNUaGlPSU9H?=
 =?utf-8?B?QWVxL1NVY0hSd0FQSWs2QkpleFp2NHFqeTdoN3BZNmV4YmlwMms2QjI0UlhE?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 007bcf10-bca4-4858-05d3-08ddae85535a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 16:29:41.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f5gbe2W4WNKJnHfhpAX5kUMrQ/IlysDc6vFYLPwT12JSEUqBa+prK3sQCgQH9OdzTbyYXLRHZv3NT+M4T7WkJri+LCvHAHuMOol6AyWPM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8726
X-OriginatorOrg: intel.com

From: Colin Ian King <colin.i.king@gmail.com>
Date: Wed, 18 Jun 2025 14:54:08 +0100

> Don't populate the const read-only array supported_sizes on the
> stack at run time, instead make it static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index b23b9ca451a7..8a110145bfee 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -431,7 +431,7 @@ static u8 igc_fpe_get_frag_size_mult(const struct igc_fpe_t *fpe)
>  
>  u32 igc_fpe_get_supported_frag_size(u32 frag_size)
>  {
> -	const u32 supported_sizes[] = {64, 128, 192, 256};
> +	static const u32 supported_sizes[] = { 64, 128, 192, 256 };
>  
>  	/* Find the smallest supported size that is >= frag_size */
>  	for (int i = 0; i < ARRAY_SIZE(supported_sizes); i++) {

Thanks,
Olek


Return-Path: <netdev+bounces-162934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB62FA287CE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CF3169876
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B738E22A81F;
	Wed,  5 Feb 2025 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hORXWUw7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC5218E81;
	Wed,  5 Feb 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738750855; cv=fail; b=LahrOukcqA8MQZ7ipGumEU6dx8YCENpmVrsZl4MNmcjvyvyCg5NnBtss+UOhnw3aKP6NcdomZ+t/bohwsHaWKcUoj3uorLy6005vM+OIGSmUQSuYMg3Jp+pyqEfIjW3avVp0jlW4NKIGCNWcP6FV1NHBM+JAPee1FMWkSZT5DbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738750855; c=relaxed/simple;
	bh=ptZMFCK6n9SH/y6tvPUJjC6Ori0gAJfr+S1tVE9U//c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EH8T9lOLOtR4h8RQpfpEYEcF3B2sBrD31idivk9Gsniy7ubnpEf7TV41NOx/p6GARWM15QOJYaurlxBbh6LX6qNEkL7N2IDEiEH0LgIFDWnONu8ObA6YPDnSuwTk8Xk5uy1MFlub7C/He3Q3jMKTq1usohgyvOCt045uXBDz4/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hORXWUw7; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738750854; x=1770286854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ptZMFCK6n9SH/y6tvPUJjC6Ori0gAJfr+S1tVE9U//c=;
  b=hORXWUw7CnbtCSj9qIl3icQqN/uoIoai9FE+ISq0Dpayl1mTVvlIJum0
   lBPYxiVMUI4Rzw9KE1q1K6pC6GHMW6dNMxr6tjFyK6mhREKUFS/b0pmhM
   Nddjlcjhuo5VgnK9fd87iftTu/d6CySy9uhvv9l+BiGZHQqvGCNKGFZjp
   ZW7ZuCamEsxh2x72sVEaRxLlXHENMmnZL1thB6Nx1mNgs2mjiz42VGHoA
   SaGoHyy77LX2kmzOcsi1OC82Xp41skFumyl8xelT9WHQBrKnATVkl9s46
   NOHJAQw8m9PMjezKII393upnasQy1OYbl3CWcoKfKJjDcmym78TuIt4oO
   Q==;
X-CSE-ConnectionGUID: rDaSa70NT9u6dThxDt8bFQ==
X-CSE-MsgGUID: 4RzQ/EsMRlOO7jSGf4BHAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39337297"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39337297"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 02:20:42 -0800
X-CSE-ConnectionGUID: skBA0Ow9RmCBOpmUsrMyQA==
X-CSE-MsgGUID: l0EuVYpSTXCgQESK2uVyAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="141721850"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 02:20:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 02:20:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 02:20:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 02:20:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecKJM9DZ9el3SExOhaDPEQ2OLMTfTKQnbtlB4Nzi1aVE+F3qJKQzg4uyRDj2XCdWGYnl2+fdclKy6pmoDV1SmOXLItw+RYgbrkRddeNGI+5TcqTcmUYYURuxKF4SZRi29l3vfy05O3pxbMsqI2H/QntimC4UlY9/L9prT+14LoloYf4SHvKFD0SFUJuliRwzc4nY+jqifHztgjoxuHxwo/7Oho0yezUAIx6hbbZDi2XnC9bk5biE4q11tUWTUy59vhk4mdNEK6dZkukHabS4eCTVfRBRUCZT2wYgqdqG6rMdjWf5sjRvogNbuEflr23T9W8sQm/s6jm+Mley7HyzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpxmfV7p7n9Cw1NCbyjmapo4MqpifHLuBfW89K3qAlM=;
 b=KnkU9Ps3U9VY25jtMswR0LKwIsSykh8wpcrIV05vGddBXskRXKEejO2Ii3/Ch7FcL8L8MhU0gNTWrLocPOsDDiy6zMY0eHGJ7AF9p8+Kc2I7hcTnAK8BdZOp4FPQJF1FO77aAwINqVEo2na0nhoInBYnPny4M1B0lCkLPm/ifWtuMI3MtsAa30V40gAalBGQk7hR7jUGryk/Do/ExnQK8zyNmIfIhTAMMKcdM9hg8/f6U4N6uTJuuFb7ocbrJxsi2mMK7SQsDUGF/TtC/Xj9fJrXEGP+9RkVCu0FpJbkul9D/VZXNYOOICDsAh1qspcmsAeg8bCL+ssUJxawCzySGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:20:40 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:20:39 +0000
Message-ID: <d54f0d4f-67bf-4a9c-883a-e94dc379fd2a@intel.com>
Date: Wed, 5 Feb 2025 11:20:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Build error on
 "drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer
 element is not constant"
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Knitter, Konrad"
	<konrad.knitter@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CY8PR11MB7134BF7A46D71E50D25FA7A989F72@CY8PR11MB7134.namprd11.prod.outlook.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CY8PR11MB7134BF7A46D71E50D25FA7A989F72@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0153.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::46) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL3PR11MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 41dbf335-0cd1-4037-9852-08dd45cebd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUFqd3FtT0JCQjEzRHhsVzZ2bUtVSFlMYmZvRFhyV1J1eGNMUm5uZmFVU1ZX?=
 =?utf-8?B?RWNLMVd6eXdSK0FWaXFWMWFZdUgyQUEwUE44d3FpMGVRL1hPTlA0eXdqOSt4?=
 =?utf-8?B?VzFWMG55OHFOOWFnTjg0NGN4STlHTGROVWxMcDlFekxJYVdOSUJCODJkWTdW?=
 =?utf-8?B?bUNKalZhc25LbnNCVkpzbkY3N2RYenQ3SkdtU3luSDVlYmdnY2VGU2oyb0Uz?=
 =?utf-8?B?M3BhbzdTWm0yOU9IVW5tRnNwSTFtS2laM0I3VDVQZW4vR2hvK1NkVU1WME1t?=
 =?utf-8?B?dDZzWnF5WGdaaVo1SVR1QXBxMkJmK3g2cUQreVBVNkErZmpCNHJuZkJDaWFG?=
 =?utf-8?B?RnNyOHZxL2RvL3RFSWxRRTdmbE1pd1dCZkxWMjZZMjJnSG1Ya2N3eHQrdDUz?=
 =?utf-8?B?enROKzByWG9TRndLd1NvSzlRbzFTSzFyVkxUT0taT2E0STlmOW5mMGZxRlJH?=
 =?utf-8?B?SitqdWxRQ0NJcU15UDI4Tjh6cXkrOCtqcGpqZlFFMDY2dU96bVg5UmVrN3BN?=
 =?utf-8?B?YzFYREVzYVBid0tvNytaRmVCNDZaUGk1M3BKajAzNWE3eElSZmNZVG9oRnR2?=
 =?utf-8?B?SG5kMzFsbFhENDJiODAwOERndFdNczJGVXUwVUdxc1NKV2dtcHIwL1FiOUcx?=
 =?utf-8?B?WTdoU3dKZ2ptdjdqVFpISFZhakZyU1l3cDExVGVzRVZ6QnFISWhzcmp3Y2lF?=
 =?utf-8?B?S0NSWEV4Mkd2ZmZaSmxQYkRUWk5OQmYyRzdkZ2lDcDhZQ2YzOEVOUnIrQ1RX?=
 =?utf-8?B?b1FudHJ6USszQlZ3Wi9xdUxSRWZUSlhrK29kT29HRytNbUJJeCtMRmpNSGJa?=
 =?utf-8?B?cGNuUllDck0yWHlMdWlCRDJ1eDVpYzdrbXZoTWtFbDJWcFlPZnJYNUlFNmc5?=
 =?utf-8?B?Y2FFQytGcjNuUjJJc2pnUDVUNXFXS3Jzc0cvRmU5SVM4Z25HTVJubndIL245?=
 =?utf-8?B?TjJWUDYzTThRWVZVbUdGWnNCclhlMHE0WS9VdFlBenhXN2lyemYzTWJ5eW0r?=
 =?utf-8?B?SFRGOS84ZWNGL0R2T2FQOFdzZW5WUEZPazhaQ3BLQXF6THVuTlB4SlRRQXJ1?=
 =?utf-8?B?Q1krME1DSzRlRTRyTkh3Njc1NjAwRklyR0FVZ3ZyblZjNDFNQmVaYmRBQmIz?=
 =?utf-8?B?OFNpMmV1Z3JWaUt1N0t5Skpya1AxMVpZNFZXZlY0dWtyTW0yNjlHTWtUQTd2?=
 =?utf-8?B?dVI0WG5XZUg0aGpTUkdSbHVuYkVlVDFrU29kNGkzejlSRC81TXNvVXNqOEY5?=
 =?utf-8?B?ZWtFSXF5SHJ2U2lnZzRUcG5XR0c3WkkreDdnV2lqQzdaVnMvc0ZkOEY4ZFNo?=
 =?utf-8?B?a1NXOWp0YnVPSng2ZEFWM2dnWFVXUTQzZHNXb3MwNHdZYS9vR3BURGhLRGpF?=
 =?utf-8?B?cGhORWFselFxb0VUTTdrZm5wbmJ1REZQWUc0NnhPcTdsdEp3L1FOREhTSENC?=
 =?utf-8?B?SWRTNzgrKzZhTW9QNjlTdHMvNVRKa2FHQWpUMmEvVDdyNlJiZkliaE4reFlQ?=
 =?utf-8?B?NFVRVnlpZm5FbVZJVXJUNXkxS0dLeFBvWHB4SUliVlBJYnA0c25VWVR1SmZp?=
 =?utf-8?B?Y0o1cWtGOGgreDNkQmRuM3hYcmhBZCtTRTRXQUVoY2dGU0RHVXBDdTVCYVlr?=
 =?utf-8?B?L3RUUGoyOURyWnFIT2FqOGR5VmFicktlcjk1Tm5WdTdRem1LekdvQTkxRTNW?=
 =?utf-8?B?UGRSa1pvUmVIL3RmL0NiQjFEcTNwSU02VlIwZHNIVURCVFhpdzJmRFVyMW8w?=
 =?utf-8?B?SmlyVlhiNTZ4UmVwa2lXbDZnSjhNUWxtTnR0SFdVZS9za2dBdUFEejh5ZVFv?=
 =?utf-8?B?VmM2c1lvOTdaSER1M28rZGR5U2RmV1FmcEZFV0w2V3pRT09JMUd3T1d6QnBC?=
 =?utf-8?B?azRabFBTQ0ExQ0ZuVkhzSFcyWjUyc0szdXY0NWZoSGwzb2VPbjk2WWlBaTFz?=
 =?utf-8?Q?9L2WdCgMeNs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRIYTFUamdzbytTTWFGazVwcWRYcWdZdUxLWVNkOHFET2pGUy8zNnE1czha?=
 =?utf-8?B?a3l5ZHEvWksrRHBrQ0l3OFk3OHA5K0R3Nm1qTlVKSWsvYXpLTkRwSXRGNU5G?=
 =?utf-8?B?UUdpazRzZnYzNldpUVZ2RUoxSTU3UVpKQjVEUkFES1ZDaTdpbkRqdkt4RTRH?=
 =?utf-8?B?Zm9pWUxCNlQ4MGpQdWh3enFYS0t2dkg5aUUyZ2dVSjAwRWdSUDBzMHgzbGlj?=
 =?utf-8?B?a2VqYmVWdFJvR2l5aWhXNlZIajhza29wQ2tlM1dFTG1qQ3cyaVJzeU1sY29I?=
 =?utf-8?B?UEVLWlkzemJVYXJLTWJGalRFd0NnaVhjYlJTTXNTTlRRWHVFOVFoQmJQV09Q?=
 =?utf-8?B?YWgxZUZlQzRublhlNHIyQWRtb3dpSVo5L0w1b0ExZmRWYXJCOExmVXVtY096?=
 =?utf-8?B?WXdoM05aNjYxVEVyU0cva0UxT3pYbE1rQlV4Mkk2YWU2UzlVUGs3UlNyQkN5?=
 =?utf-8?B?V0F6eDVGNFdxK3lubWJML3ZMNnVGWDQ3OHhsMFBOdTZ0YVhyekJKUDVmdGpT?=
 =?utf-8?B?b1lGOHRFSHNTbEt0S2l1YTRjK2R5MUV6TlduNFVUa2FpdkhBRHF1L09xbWpa?=
 =?utf-8?B?ZEJyTm56aGc5TDdzSFlyZ0YvUXJVbkxPdFFqZ1RrWVJMbVhJeTNNek1jL3U3?=
 =?utf-8?B?MDlZUmUrOTh0SEp0d2tLcEwxMlFBUHdLdi8rdjFJTmxHYUxHK1lBNDdFa3Zv?=
 =?utf-8?B?TEtOWWV4N1Q5RHJra3J5RG82MzNQRzZJL2VCWG9GTmI2bWFaY0N6VjEyYy9O?=
 =?utf-8?B?WDZxQU8zUVBsVzZLQTkwSXdxeW1aZXVkOXpWQ3Jic1N3dXdXMW5HRmQvY0lZ?=
 =?utf-8?B?VGNEUjlvZzBoL1lUaWM3Nm9FaWJhZ21hODZ3UDB3aEU3QUQwVVFkaFJQdG15?=
 =?utf-8?B?M2d3THZHeEVyUFBtZTBWeDlKbzVQcSs0YUpyL1I4eGJabU5vbUdMYXV0RzVL?=
 =?utf-8?B?aFEzclo4QTAyd3p1eHFhYzdDV3FmTUJ4ekJkcHRmRWtoWnNscVA0WDFZSVE4?=
 =?utf-8?B?aFlTZExsSW1SeDRGNVZrVEJzdmh0L3ZyRG5zdGp2bnR2THlzSXFTOVZyclJR?=
 =?utf-8?B?ai9oVGp5YUgySUJ2N3diblN6L3FRUUVibTVGd05ObXA2VnRqMVRCMzBPNHJ3?=
 =?utf-8?B?bEZTUEYzNlNuMFFMVzRFaS9EWXJCako1NTFvWGU4bmFnOU1WMVppYk5TWTc4?=
 =?utf-8?B?ZTR5YTd0SnJ6NldJaTJGU2YxYWVoMllWMkJVaEtYckI3QkMwc3lyRE5HamEy?=
 =?utf-8?B?cllwb3NiZDFpUitlK0VuQUtoc21KYjlObGt0Y0lvbUgxb3JzUXNUL1Nia2M3?=
 =?utf-8?B?RnpCYmlRWld6Q0xyRE92dW5XZW5oNHE4bzE0Z0dxenpWb0xYOE5pWHk4VFY3?=
 =?utf-8?B?SGFOaldJaHphZHFJamN0QnZOODNVK1dmSG5Jbi8ycllSSUxtd0p3OEFjS3o4?=
 =?utf-8?B?Y2lPMmhaczJQU2xUTEZQVU81QTFwTXJqbFlIRXR3ZCtVb056Um5IcVhwREFh?=
 =?utf-8?B?Yll5T1B4TG1SeFdhWFhvbzluOWtTZlhWbFZwWW5zaW41aFJENWE1SU84RzJ5?=
 =?utf-8?B?cWFGdkllOWVQVVIveGk0QkVrSk81K1BlOWdDdkxmV1lvaEtUVzJuRU84eUYr?=
 =?utf-8?B?bklyTlBRK1ZQcVYwZ0FSaUorTkpSZkQwdVlxTjYybnZiYnp4Z0pFZDBpck14?=
 =?utf-8?B?U1ZRSUE4endjMzJBL3JWSHQ0YXFkYi9pNTFYR0MvWTFMYWVrdFhIdnlDU3pu?=
 =?utf-8?B?TWIxVU44dTdGUVhEaWp4YkJHWHlUazNlYk5teE1LRWxaSVRDY2Z6VnA0Y1NL?=
 =?utf-8?B?Wk82cXpSZHdxazlHQW9WamtMemcwSU1MQ0VXUThEK1FwZjhoVnp5MVlxQk9S?=
 =?utf-8?B?VlJOSmhPVkdMQS9HMzV5c1ZMR1pCbHlVd05aOWt1c0UxVkR5NU0wTG5BZjY0?=
 =?utf-8?B?SGRRcHZ5bHNPa0pPVDJGdzBNaU9oRks2cVlacmpaVytaM280ZGd6Z0pHUFFH?=
 =?utf-8?B?MStudUkzZUdOQTRZQTl6NlMrRDdsUE5zeDN5RDBlUnRuVHVCR21RcjZNOWhX?=
 =?utf-8?B?V3JrVThlbmY2VWlCVEJGK0hUUFBiV251K1E5cUljbWk4T0VobW0yVlNGTG9s?=
 =?utf-8?B?N2VLYUkvMzExbWhtemZSWXRMVmk5TWMvWkI4Tm00ZkUzUWxGU1ZTRWpwMzVC?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dbf335-0cd1-4037-9852-08dd45cebd54
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:20:39.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpZyQtaAud8vhHaPiPVrcHjyillWUtYP3uJqr+fu8hMSyUvV4K23mtj6np7XlKvq0BJRFyEJ8J7+v9V7O9umcuyK6JnvrTOYcHS/hZOlmcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com

On 2/5/25 04:18, Zhuo, Qiuxu wrote:
> Hi,
> 
> I got the build error messages as below:
> My GCC is: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0.

Thank you for the report, FTR this is the same GCC version as used by
SLES 15, even the current ones :(

I will send a fix.

I would love to bump minimal gcc version to 8.5 (RHEL 8 family) some day

> 
> 
>    CC [M]  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o
> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer element is not constant
>     ice_common_port_solutions, {ice_port_number_label}},
>     ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: note: (near initialization for 'ice_health_status_lookup[0].solution')
> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: error: initializer element is not constant
>     ice_common_port_solutions, {ice_port_number_label}},
>                                 ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: note: (near initialization for 'ice_health_status_lookup[0].data_label[0]')
> drivers/net/ethernet/intel/ice/devlink/health.c:37:46: error: initializer element is not constant
>     "Change or replace the module or cable.", {ice_port_number_label}},


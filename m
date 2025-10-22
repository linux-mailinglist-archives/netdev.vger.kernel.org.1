Return-Path: <netdev+bounces-231915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F77CBFE9C0
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0073A75D4
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 23:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2FF29ACF7;
	Wed, 22 Oct 2025 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEMKLGks"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEFB26F292;
	Wed, 22 Oct 2025 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177158; cv=fail; b=KqNKwfMAfKCi4RQDipf7sc/U+GLm0bp45CJq3b9ojciFUxGGY8wqXbCHkqc4qpatUh0fjvnpthvgyAthXgIDw3TzambeBHr5j8gFiVXUIo0sZWbXVO3h6iyFEHUcYUfEJ+LCNTipIZOLFEra1PaZ6MEWMV5Bm35Mv7Q3FxtEmpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177158; c=relaxed/simple;
	bh=j+OgYCsmJVuujLRIHzq55xQW99ECcjC9+w5dH7gfIow=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ARh9z2ZLwbbjo2VAHZ28DIvGvlqwR0Z9BsY6nl9cFLRSauwX0r+XsHQD1iuvT45XqfJGbqyqHPw44xirYEESuaqdMJZE4KikfqJkFvXcIKhj5xFCOLblVj01t7dQKHoN+U9BPYgHoEBbQr5QBVG4JU3uoR7cpkckQvn0pCJyYvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEMKLGks; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761177156; x=1792713156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=j+OgYCsmJVuujLRIHzq55xQW99ECcjC9+w5dH7gfIow=;
  b=aEMKLGksUyxRGjmOXnBh9/4V1KY8NqVPmDI8cKMiuUbShY6u0Sm7y9tD
   XVkwFLjAavYn/7AUMhGDhYor1xyQUD2mgBYZ+1U0+yojvptigdd4Xll4e
   F/EEaTtgFK6H3AaLWsoYhVArg+MzK/AHPKzQhjWmagznA9YvyrCKQqIJM
   dbuTCJ/d1zrCqVIiEvSUO4oMxW4Ji5PkwMhunVxJ9K9HMkGPF2F1B96vO
   gcJ32tn/eeo/a4/EpyKH/KKCGAkyu50YO1eUN6vIP9MlAApCGqybYcUOC
   mAWspwGEwInimfMfUuiJmfwG2wTgnK+be+d0Jxu/w592L2Trnmav6/2TL
   g==;
X-CSE-ConnectionGUID: pnd0AT3CSziu2Bj2TPtXww==
X-CSE-MsgGUID: 2OrpQy7tSHu1NlyGZjrJJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74455792"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="asc'?scan'208";a="74455792"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 16:52:36 -0700
X-CSE-ConnectionGUID: T8XkELAfRtGJwO+5nUHrfQ==
X-CSE-MsgGUID: exlFSDpGTMOJCNvbhrX+2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="asc'?scan'208";a="207667383"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 16:52:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 16:52:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 16:52:34 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 16:52:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqMIf3yHyv17mH94mUbFaB/8osB5qqp5Rc8wWwN0ZsrRQjN/0+emsHheK71lOHBQXz/72lBMFnXhcmWPXVRozw5H8sAVVj40H+We3+EmdtMRbi/1ZkkApx81MBDPlCx11DUk/qeHlK2FwZUtytJLOwqrkrHYpSoEjsifV5DGFUGHrE1lm1TOYRd9Vxc4jXOuLmmThQ5vbHfZGQFKcmA0GzaqOmIjjJWBJuo1q/YIzNjkswd6u9R1W/Fd65oJc2reSqu/pYStQU5O5WwIaSH2/JjELknHOK1u9JXKXLpdGplPhW8ZPgM0/wr3W6uSxg1grdqIi4nbVfHLKE6/5Zj2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+OgYCsmJVuujLRIHzq55xQW99ECcjC9+w5dH7gfIow=;
 b=KFdl5wUqlTZn7kAxhM1WM2Z80q34oByNIPHd4AHDTcJkDvtcEwGwwIWexJMZzJozBDp/73TgAzOvOXHkJRvDIjO9vWAWkDAI3FQMiQYKbky5jwXw/N8m+oYfkNpFN/iL9muYomlw87A/09RGz/r66AVb6LnozJ8HaysMG8v6DuqOaSDyTL+VrIL6liSb3zkGugHicI4WThjYoi6I+NFfDWvRZZRp8s4IRAGAeqw3Mp+LA2Vj3ERk0fnlKx+sWpABfUyBD5XvtzJ7A8foSH5hz36GUkyhpnol+gN9PxiF28bUzIa4lKzu+AupekKcJNfESYr3aio8Iig+fASFMroi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7793.namprd11.prod.outlook.com (2603:10b6:610:129::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 23:52:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 23:52:27 +0000
Message-ID: <89daafd3-5234-4a61-8b4b-044e6e2d0c3e@intel.com>
Date: Wed, 22 Oct 2025 16:52:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: alteon: migrate to dma_map_phys instead of map_page
To: Chu Guangqing <chuguangqing@inspur.com>, <jes@trained-monkey.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.xn--org-o16s>, <pabeni@redhat.com>
CC: <linux-acenic@sunsite.dk>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251021020939.1121-1-chuguangqing@inspur.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251021020939.1121-1-chuguangqing@inspur.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------DFRiZFy2aqzxpn0IgPQnFBL0"
X-ClientProxiedBy: MW4PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:303:6a::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 21257983-3ecf-4831-3108-08de11c60e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azVxOGJ6M2o4dDNEbFB6ck5JSHJ6VW1GclY2eWF5VFc1L2tveEtrUWgzRGRJ?=
 =?utf-8?B?aXEzOCtXaXlNeUZvcTROME51NncrUm5EYzRKU3pZZjh1NjZIblVMYXlPbmFv?=
 =?utf-8?B?MnRxRDZIYjJFMUpzUko4b1ZCbzRRN3AvWkxRaFNQZWhMWjNEMkRrK3ZuSTM5?=
 =?utf-8?B?djZ2UkxCRTlHK1pzMlNBNzR3ZnVXdGU5SkNUZXpqR2QwTGFQY0syQkcwaGx0?=
 =?utf-8?B?RnhJTzNXMkFlQWVlYmdabnA0NnNqOUtaczFVcDlBbC9vY2k1SVBGZ0cwZm5K?=
 =?utf-8?B?eEZCZUFjSmxWSHVwalJZZGIvWXNJKzVid1RCMFk1dERtcWc5clkrOWdycFVV?=
 =?utf-8?B?SVVpUldFZGFIUlE2anM5K1FYUk1HUWlROWJvbW1Wam5NbFVkTjAwNDFIY3hT?=
 =?utf-8?B?bjlHOWQ3dmwzSXcra2RScytDZlNFWjVXV1ZGQUltdVcwQWovRnk5MmdDR25E?=
 =?utf-8?B?RU5DSjJMSDNoQURPNnRhRld4OENuREZ5Qm5pcXZLUGRiRzJhOWNnMnRrNUdZ?=
 =?utf-8?B?TnViSlRZTkFkMU9nci9hbC8wTEdEeW51c2xoKzRwSCtqTHo2eXMrOFYwRmdM?=
 =?utf-8?B?RTVlOFovdHN1UWxMM3pRRW52M2kyV2xmd1poMHM3S3ZXOFRSOVFrTmdLQmJ4?=
 =?utf-8?B?aGwzaHU2M1FRNC9IYk95cjJwdUtzcXR1SzVFemJtU3NydjJzZlI0ajFsZVU1?=
 =?utf-8?B?RFhjcy9Tc3JpZXQwTEVNNm16Q3NGWFQxekxsRXBFWkNRM2gyY1BlTGhubnlF?=
 =?utf-8?B?d1hCM2ZkVFhKM0d6ZzVyUEwzT01XZm52UURNOTBDeWhiYmtETVMyVjMzOS8x?=
 =?utf-8?B?di9qQ3NORmxzcVFUQ2lJeGNjVE5SekV6aS9VNXdaSHNrc05XTkY1TU9abWZS?=
 =?utf-8?B?WmtMYlhLZm9MRmJKYnJSTXFkM05uRnZmUForaVVQcmlkQTltOEUxYTFxSTFN?=
 =?utf-8?B?K2xod0NjbDFxNUJLZVZ0c1Q0OHVLWlVRNlgwbklJOEVjeloxTlY1YWNEdFVv?=
 =?utf-8?B?RnFIUG55Yk1YbmdRYlB6WDc1bTNoUXYwdEtoUjNOTkM4YW9VMzZlczdRSHU5?=
 =?utf-8?B?KzNkcU01Z2lJVHlXYXFQNG5EV3ZtNjFiL01DNXZnQ3FFZUpxb1pqSnlFQ1hC?=
 =?utf-8?B?Mnh4ZUwyTFJOQ281OWFsbytETFkvWnY4blRtdzgvSXRFQldwQTZ5ajRZcTBY?=
 =?utf-8?B?bDk2d00wbHpwaGZsend4M2llSEZsK0o4QTEzUkhMdUt1RHlhQ1gwa1hBSHB4?=
 =?utf-8?B?dGV4d2F5cTVlT3VLdG5aek9rOG0xTUxCcXo1Z2xsNCtRMlVHejZrYjBkTk9J?=
 =?utf-8?B?RnVBWmg4M3g4YjRHMlFxc1BJeVRvQ3RHVHJFU25ZSytrcmFqTTFlQlhITXlR?=
 =?utf-8?B?Q2VBQkwxRXRtc0krTTM4VjM2S3IwUFRlczdmVkJ4VDZBalMwd1N0cmFhZitr?=
 =?utf-8?B?czhKR2FOd3dTRjJ3ZkJtVmxUd1lYeHdRQjVPWVlRZ2hDQitZTnRFbUk4MFpU?=
 =?utf-8?B?S1cyTXdEU0dXRkxtQW8xMlpQUVdjZk5GMDVNcDQ3SndjY2t0MVhEMjAwNkJ5?=
 =?utf-8?B?S0p5VlNaSXVvVDc0KzVzOUJ0YmwybWV5QzI4U2NNVEE2V25HSXUvRS9LZmpH?=
 =?utf-8?B?d3Z6L29BODNpaWo2bDFuNVNpU21iNzNlMjI1UDdYdlRheWRIa1loWENLWldS?=
 =?utf-8?B?dGxqNmlVek94T2FuNldvLyt5aGdDT01SN2Z1OW9vMmF2MFZIbXMvT3lQOWxp?=
 =?utf-8?B?T1F4NTVkWUprVG0ySTlaNzJ5aXJObVRYOGpPN2dTYXgxVVpHR01KVlladGU2?=
 =?utf-8?B?S1NTdEhXMUFOOXVDeHB5M0RidlpXMVhxWTJoc3ZGZWxLMm9hbWxNYWtXUk1s?=
 =?utf-8?B?WlRnRjFGZVViclh3VGhjcFRhQW1zLzRvYVNnVHByaE1pNEFhdVpFaWpoeFlk?=
 =?utf-8?Q?XhJDXjVMBkKyerEKH+9sr1fpV7Xn9Kgx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm9Mb2ZtbWI0eTFJSzFCM3VpVXNEZ0RQMXRZNUhEL0N0ZnlSTE5yajNYNG5Y?=
 =?utf-8?B?VkNZN1czU1lEamdhVjFEUTdUdlFlVElLeHE2VXpvNjNlZmdDa2dUdEhyUmpi?=
 =?utf-8?B?cEZPNjBlaHJvTVAyK0phY2YvaTdhOG83QW83R1ZFQXFFdFEvSFZVV0FPSlRj?=
 =?utf-8?B?bGxPMVRqa2txUDRnWWlaQXIvMyt2SGQrbTNuMW5iZWtqVFNFbkJuODYxWHdJ?=
 =?utf-8?B?WU9zUEwrSEdHeFVrM1VCVTE4Z2ZHK0s0OVU5d1AwWi93OTc5SUVWV2JTT2pB?=
 =?utf-8?B?NzJOUSs4cVZPMU5hLzAxTUlIaFdJb1dMdTA1RDZPQmtnMGs5Q2NMR01HL0ZN?=
 =?utf-8?B?bWFaRzNlTUp4ME1NUnJUbkt4STZ1SUU5dW5BRjFEUUpWdTV3YXB0RjdNWml6?=
 =?utf-8?B?WTdUVzlvdEd4MzFYU1lDOVRLYk5wMHErdmVERXF2clBRTG5sby9hYkNzbktJ?=
 =?utf-8?B?M2RJZkxaSXYvbjZOd3Y5d1pOVkhLemFwRzd1bFlaRmVSbGdmZyt4enhDendC?=
 =?utf-8?B?Z2RUampRUlhFdGNyTUVkaXJSWDRkS0JaWnB6RTBJb1BySTJOSVZwWC9vWGZE?=
 =?utf-8?B?cGV0ZFRKbWhuaGt6SllEczZYMERxRU96V1ZPQUJhMXhXVHVKUHQ1NFFRSGhM?=
 =?utf-8?B?MExKYkhweE40T3JDUC9RU3lkTmU5SHArenVVdVg2N0NXVllkbk8rVk9WbW5u?=
 =?utf-8?B?c3htYnFWeWp0Nmdhbitjd0JsSXlrc1llTk1GOWtrWjFHTEg1NkNrTVZVYjhZ?=
 =?utf-8?B?RWdOc1lKa2dzREFRVU1wTGVrUVRvR3FJRm4yOHFZSk1VTEgzcEVkSkpiNG5H?=
 =?utf-8?B?dTRNdzA5RDdYZzFYbHQ0bStOdG5zbTk4RVBRb1FFVUlNbDE0ZldtQ0JRUHpy?=
 =?utf-8?B?aFQxTUIza3loUDhGd1prNVVvVGVRQW9sWHpEVC9uOFE4VnViamMvRGVHeGds?=
 =?utf-8?B?QkM5eVRNSHJobTFjLzVuc1FaZzVjK3g5R2Vvd00ydGJSQ0thTGxZVWxaYVZn?=
 =?utf-8?B?UTcwSUpHNEJ1NGxOSUhrQ2J0Z04yUy9IV2xoMUUxS2NLUWVSNG9pWE1wbU1q?=
 =?utf-8?B?TjB1Q2g0ZEd1bjZGbHQrdGFSSU5PMTIvTk55QzE2bWZORXdob213ckx5ZTND?=
 =?utf-8?B?eFZPMTViZkFaSGt4SjFMQ3FIakFkT0NXaWR4WVFDTnNxM0prREVIdVhFSlhq?=
 =?utf-8?B?SnRJd0R3MlNQZEhmQnc0QTQ4YVMrekRHUFVlY2VqY1FpS1VVR1J1WVVET0c3?=
 =?utf-8?B?SE81b3JyMFgwWWFXSElSbDFEUkVjbHRkS2lmYVVDY3FaNGhpRnB6dWJiMUhQ?=
 =?utf-8?B?WlpBSDN0cE1wK3Myd3A5cjFUSDJ4VlN0RUJScHB4OSsyOFNzOWxnMkN4R3li?=
 =?utf-8?B?ZFBJTk45Um9Ic2tUOFdPRDFRc0pkMFVZVjJYQklhaUUreTcxMDRjUlpieEZN?=
 =?utf-8?B?WkJ4TEhsclJVdGRZUDdPSzRvSFY5UHROaHNCdTFHcm5hMEY1OTkzbEZEOWMy?=
 =?utf-8?B?d05tWVo3TEJpWmsyUE9UT2ZTUCtPZ3BodDkwY1VUMHhBcGRiZ1pUT1MrNEJa?=
 =?utf-8?B?MDAxcXhxS1dnTzYvakFncDBubFZCYVBTcFAvWTVaQ1BhcXhROHQrSDhzZmJo?=
 =?utf-8?B?ZnFETER6R0Yvd0FGcGVRVS9ycnlLcEFFNHJRdXM4Q1JnODJ2N3BRK2xMUFBO?=
 =?utf-8?B?Tnh1dEFSNGFCSnRtRHBmYXJCKzZFcjFTYzRObUJRbUZHNGZhVCtFemJkYnNq?=
 =?utf-8?B?RzNHSEtleTZiRStMQk9aS0JYbXBDRklLSHJkSzRlbVl3S2VkaDZBODd5MHNF?=
 =?utf-8?B?OFNaaWNzcjBrQTh4OUJlczhhN3BZZGFXZDR3MVBENlpuNEhvby9FK0lkNHls?=
 =?utf-8?B?ZmJHeTRvSWFlS01vNXFVSGo5eXNOS1RPT2J2NmE5Q2ZzQTMyUCt1all6MnpM?=
 =?utf-8?B?L285UHppYXQzNk5mWVJKN3lYQXZQaHZWTElGUzBuRVNNT0RBemh6OHRLbHk2?=
 =?utf-8?B?aUpLcmYwdDhKNkxDbTF6VWxZU092ME1tNlF6blFVbjduRDZPNHU3QkN6YUl4?=
 =?utf-8?B?VFhnVVBHTlA5clJkK29CeUprL2dzOWJrR09NWkVJYktRdjZjWTJmRTEyYnVK?=
 =?utf-8?B?Uytvb3gxZE5PSjQ0TnNjUFEwOUxpRVlCaVJnZHM1UzlpOW81VUppbDEybFBp?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21257983-3ecf-4831-3108-08de11c60e2c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 23:52:27.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Wy4BThmAc9DpUnk3wtbWrC7lwgQSLbOEd0J62hWxTyXEvdWLbIXq27kdNu/J7NwYs8FU8S0FWRc+D61wSSrWz+NXkQlAfcGzNP3oyMr28k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7793
X-OriginatorOrg: intel.com

--------------DFRiZFy2aqzxpn0IgPQnFBL0
Content-Type: multipart/mixed; boundary="------------jvyM0ydzY5EuONefSwQbpz4q";
 protected-headers="v1"
Message-ID: <89daafd3-5234-4a61-8b4b-044e6e2d0c3e@intel.com>
Date: Wed, 22 Oct 2025 16:52:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: alteon: migrate to dma_map_phys instead of map_page
To: Chu Guangqing <chuguangqing@inspur.com>, jes@trained-monkey.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.xn--org-o16s, pabeni@redhat.com
Cc: linux-acenic@sunsite.dk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251021020939.1121-1-chuguangqing@inspur.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251021020939.1121-1-chuguangqing@inspur.com>

--------------jvyM0ydzY5EuONefSwQbpz4q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/20/2025 7:09 PM, Chu Guangqing wrote:
> After introduction of dma_map_phys(), there is no need to convert
> from physical address to struct page in order to map page. So let's
> use it directly.
>=20
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---

Subject should include the tree tag to help automation when determining
where to apply the patch. Since this isn't a fix, this should target the
next tree with [PATCH net-next]. In the future try to remember to
include the tree in your tags for the subject.

The change itself looks reasonable. This converts the chain of
virt_to_page and offset_in_page of the driver followed by page_to_phys
in the core dma_map_page code into just virt_to_phys in the driver.
Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------jvyM0ydzY5EuONefSwQbpz4q--

--------------DFRiZFy2aqzxpn0IgPQnFBL0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPluOQUDAAAAAAAKCRBqll0+bw8o6BFC
AP0TcOqxjWDXkp9ZWtgruP8pCtf5dl0XjI/FTlgq1b1fEwEA7ZNJDP1UdLa4uZcaiNmEU6xS3TVK
SvpaxoGvbeVg4Qg=
=pFXV
-----END PGP SIGNATURE-----

--------------DFRiZFy2aqzxpn0IgPQnFBL0--


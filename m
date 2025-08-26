Return-Path: <netdev+bounces-217096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C47FB37596
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC0137B0D68
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E83074BC;
	Tue, 26 Aug 2025 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7cUvQVX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32539306D47
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251366; cv=fail; b=QFh5i0yajLIic258ILAHo3/LuckOliv58Prw48SUOmrUrMdh5/JaUE6cef6lLjKfSBrWVuVUQQDSYQprU07UFhiz7ecdvoXNIvjpJwbZPJN7iBtFsxkVK4akMrQTb+nC+/y15Px+MjAcQI6u2PfOuMS7K5T/xt3LpCrJyx4OsEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251366; c=relaxed/simple;
	bh=d/LX8WIrvK9iv+q9Ude5teJ2ESPBzj2r6a+SMN347lY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2jMWBoYJZdNUAjaJbnOmNt6bFQugHAjSWRAD0ANqURcrN0JOfNAkjbuvZ4jCahNBfVYUgTQLfo+MYULQvZOWZLoqUIsWj2ixF4tO7zc/1/P71VfcAleby91szYrbiDsNY/PtyhfJa9aqcHJQtdGT7bldYxB+eiHrwLZ/88vDYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7cUvQVX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756251363; x=1787787363;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=d/LX8WIrvK9iv+q9Ude5teJ2ESPBzj2r6a+SMN347lY=;
  b=i7cUvQVX1G/dvryhGTWnihDXsTNsoy7nG+u34p8pD6QmKXsi3xztpvro
   SHvsgulMNXQywzF1QFZsYsbdEn7YLLGJcPCgF6Z2rRDEZJK/jAVxHWq8f
   RSeYfc4Ou6Tmf/X+1m/073xS9KBrdi0TRFPIfUXZwmHfoiwaDOR1xqQFv
   1fNFpgqczdz0JawjjNHdLjPskrn3rpJ178f0oBuFIKRLb7DMvoMnb85hT
   n/WsyzW7/GI8/tKV/4KGOZvu378ADYvFtGJAVCV8WAZjsg14Raz56C+cZ
   oZuwbRcEh6mUall8dDuBWWQuD41Av3We0es4C1ARyEirkaVcTVvS5WlfF
   Q==;
X-CSE-ConnectionGUID: NyqKs4BLTrqE0rX73HioVA==
X-CSE-MsgGUID: KHILe0OMRp6fZ4vGDUa7CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58211234"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="58211234"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:36:03 -0700
X-CSE-ConnectionGUID: bvLFo341Tcm5TCbWf793WA==
X-CSE-MsgGUID: kDkQD9JyTM+KIWtlrQCohg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="174107731"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:36:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:36:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 16:36:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.78)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoKrktGOH0NgZ7c8FSykg93B57XujsmzYNm8gvmiEv3V3h1dwagyDXveCuCzF72gYtN6WN9bJGedaSb6gMGvF1WoH/exjLt4A7mAylUzbGR14Emq7auipABysCymZoRchECcTajKNWFlGxHE3VrefikdnknnfFHwc8KzzYQqulQewGCYrjR61zmdnJ1mPTX9QeAkEbaKgwKPgWxp+7paYVzyHrTXWnq6EYT2aMWsD544zZZPUbxxaznbwvG0+XGkdfSCQ7VUWqVgi7ltpyAJZtZrocNht9MJn+xBlVAly3wFnO9bJ3Gg9bhFZmtPfZfiamfhKRRM86VynMrOrHjZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJrKRYfnYarHQWYzvPojcfxbPdmwnQCzOSZZPyrexEA=;
 b=JmlJAsqnFYkt3Sp6zpSWc3HqcooxtAQRJ1n/Rxl0D6wDvufVBppsQDAvxi3StS8YcvS/wJTBzqRSCbUmx4FVylxZMdT9ek0lmrSJhbt9sIYbQcZZEVT4hMCyf5gK3KepDFxpgoq6s1jeR+kPLLA5kwr62Lc+DHennBjWzbwe6Of2Z5pQP//UBUvLKAW2/UdyZe4FhM50dlei4AHfTKJQTZkTCkKEF34E9ULXlGyOOaTJ/IML3CbbgY/78fViTjmI90nrsHME+yc14YwUPNnlTUnK1qQhjrqpq9O7Ihxx0CdIMV1o7Ax5m7Tmo8dPVDr1a3Oq4/CX1oQk//Y9U4osWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6128.namprd11.prod.outlook.com (2603:10b6:8:9c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Tue, 26 Aug 2025 23:35:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 23:35:59 +0000
Message-ID: <bd17585d-adc4-4577-9338-a3b4aa0e4fd6@intel.com>
Date: Tue, 26 Aug 2025 16:35:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/6] eth: fbnic: Read PHY stats via the
 ethtool API
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <mohsin.bashr@gmail.com>,
	<vadim.fedorenko@linux.dev>
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-6-kuba@kernel.org>
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
In-Reply-To: <20250825200206.2357713-6-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------7VEKSqgORZkfl25Bx7bp0QFz"
X-ClientProxiedBy: MW3PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:303:2a::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e293625-5b6f-4610-2fa4-08dde4f94f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmVzbDFJTXhWTzJXNzFQdmhndHhBcFVnUjJFTFFoLzZGM2p0REdSNkdaWnR6?=
 =?utf-8?B?M2piVTlNNEwwb0dEUWVyV2JWMUlEMUZOQzMxblBlak9JSURPc0xkNllGdEM3?=
 =?utf-8?B?Y1UwSi95YWl2MWpYbS9FdjY3bnVLeXM4T1NmdjltbFVRQjJpT0VvdzZBYkc5?=
 =?utf-8?B?M3JLM0xWYlE2UU5tekJnYkRDRTBwMldvTU1nR2cxeWl6T0J3ODN4ZzZiZnph?=
 =?utf-8?B?NWxUTjZQZm9scFdrM05aSGNJSXRid29KbVhtRWtLQlpHbWtZK2J1MTFtR2R6?=
 =?utf-8?B?Q1NDMGI1eXZ1QVI3OGM4REszbFdMZlN2Ymtxbm5uZUxDV2dVMnNEaTBPdTNG?=
 =?utf-8?B?dUhjNmNjd0NZMEpLZHhGWkNWUFp5OGlSVFNIcjZKamZXbkpiZGlXT3ZWVUVS?=
 =?utf-8?B?bnRvdGszQmh4cnBNMEwrY1d4czhhTDM2cGI3eTBlQkhXb2x6SnB0dlQ1L3B1?=
 =?utf-8?B?OFhiTDBzTFYvRXZTN1V3OHhwd21RbEF6SmFsYkwvQk1WT1cyOGpKenVTRCto?=
 =?utf-8?B?czhKS1dzaWxPOG42c0QxL2xkTWJ4dktERldqTyt5RmlLajUzcGhhTGRmWjEw?=
 =?utf-8?B?R010SDdtQmllRDIvOWs2cHl4aWRlNUlVUjNHWDFMZjBseVNDaDBqWVJWa0lx?=
 =?utf-8?B?UzZ5T0pMU2pBSE1DZEY3UVh0RlY3QVYzMzFtZjJ5LzZuelBBZVl2UDhlb2Rs?=
 =?utf-8?B?M1FjNkdWMHlURW1yVzBab1pKMG8rOVJBak5TT1ZjYkc5RU9ZTlRzRmJ6KzBR?=
 =?utf-8?B?K1JkcnBZUGNxejFQdGU4TnJSdGJCdkZMdjlCQTRsWmRiWkE2cmoza2dQbVB5?=
 =?utf-8?B?UytSeGw3NjhNTnY3NmdKeHM4MjN4dk0rbEpkcGhHNWdTTE0vU0ZWZ05pRE1I?=
 =?utf-8?B?dVdwTmJJTHk1WC9FN2puM21MZlFERTJHVjQrTnF3RDlzaFZpTE5tdGsvK09z?=
 =?utf-8?B?RXF0dWRNSk9URnRZd3g2Q2hPbGxtVDA4dm03WFh1cm9XM1JvRk50WWZvUmR2?=
 =?utf-8?B?K1FPZDdTOUFaaElDclJnTGFUaWdmR3VDSGR4c0FDTWJIZDRRa1hUU0FEYUtV?=
 =?utf-8?B?THRzZVlDcDNQTVhKM3ppRUNCaGY2NHI2WnFablh4OTlRMEkyU2hTU2t6MmVV?=
 =?utf-8?B?RU1oTGtLbFhNc3NYalFrQWc4RC8rWkh5SU5pdjBZOGRnTm5uSVdVNzRaTmRw?=
 =?utf-8?B?K2dnOHNkbFRSVWhkNEpzUXJzQ2FWRVZZL09HZ2U1Z2JGUDg1L3NHWUFKVlpN?=
 =?utf-8?B?TllkMC9GRlJ0S09WSGQ0Q1JObm9LamlEakpXNW1Wcm1ubUNoMmkwbDNVN0dT?=
 =?utf-8?B?QnlOVkVSZGFyaGdQaDdEK2lWQ3NxMUJPNE9DbVZwWFhiR3V6ZDlmdXZDN2xw?=
 =?utf-8?B?VW1tWDJLQUhEZDdCOXZYZWxsMGF5MjZXRElNcE5UT3NKbUR5R1E5eHdmL1Jp?=
 =?utf-8?B?MkxtZ3FBbTRKM1Z4cWN2TzQvbURPeDRITnVxUlRMWGZzYUYrazJhWFFQa0RE?=
 =?utf-8?B?ZWtmVmlxaDE0VGdRbmp4SUR6YkUwbkoxU0kyMnhSM3A3dzBUa0V4TENnampp?=
 =?utf-8?B?ZHd4bkZzUVU4L2RmTUpPVHY5UkZWL08wQ2lnc0EwVUFVeEoyLzduNDdxL1N1?=
 =?utf-8?B?MW1oOEttdm80b1c4SjVHVEFFZXlKUTFSeWpMOEcyakFJaDV2R1Z0U011UUpx?=
 =?utf-8?B?a0dGOE5HVXZIUVNMZFRFYzZLYnBOYURpWnpUZVdoSzVlTGZWaXpwMlA1QVZS?=
 =?utf-8?B?OW9JR1pRWUowcWVMY1RRcVJhcEJHMUFXcmpXS3UzMHRBR2svYmFZUGJlTFpC?=
 =?utf-8?B?L1d1cnIzaWpOS1Z1WDFWNEllNHZ3My8xU1NRa1EyaEdERnAzZkUzNHhZckU3?=
 =?utf-8?B?NXpVTmhRMlRZUnZmc0ExM002cjdzUkpCSHZ2ZDdhTkE3bXdCUFlHNTVaQUVl?=
 =?utf-8?Q?0yCvduVCFtU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cno0NC9vK1oxTDdiYjJ0Um1kV0xqYy9JY1Z4OXhuUWx3Ni9tbGFKK2NyUUtm?=
 =?utf-8?B?TXVPQzY5SU1tNmM3a0ZZbU5NV0YwemYwME5wSmNScVlCOEZ0MEZENnhFYkx2?=
 =?utf-8?B?V29ZTW1EeWd6WmZySFU0YTdGZHpWcm9xK2FLSWFxQmxCaEcySnlZbFRKV1V5?=
 =?utf-8?B?ZThuOFAvSTFnaktpMFhLL3Bva0tNb0hwWG9TUDlSMXBPTFU3aHVCcXM2SmND?=
 =?utf-8?B?NXRSL1RSZEdObUVJSVJoVnhIcHdOeHBWcUN2WGhYR25IR0U4WWZZV3ZVNVBP?=
 =?utf-8?B?UjJJVTFqNkNNNHY3ZVR1Ylh5c1FoYzJ3eU1MYm9YM3BJNDRJaUJUeXJmZXVo?=
 =?utf-8?B?U21MWmdEUXNMTkhmc2h4SUVJT28vQnlzdTlocG0wZjdNY21mazFaMEhRenRF?=
 =?utf-8?B?RURSQms0N1JOaXZCejUzSzQ2b0k3M055Si8vU0p0TlJEclZxZWFmeU1KMDRS?=
 =?utf-8?B?YmR6TlJScjROeFBWUkN4ZTVZdC9ObEN1WHB5UkJOK3hTZlk3T2pVUFlaOFUr?=
 =?utf-8?B?N1pIS0M4aGIvSS92VzRIN3lBK2diaWk2bEkvV3o5SFhvejF3aUtjQ0VDRGtm?=
 =?utf-8?B?Q3ozVE1MbXl6SFNaSWhpRUtaRi83dFdTUmhVYkJQRXlWNDA2UEUrT2pwUmZm?=
 =?utf-8?B?Y0hxU3FLaDFVL1dSc1JyUUdYemp4bDM3MkV2Qy9CN2Q3WFJWTmtUTFZ4MzA5?=
 =?utf-8?B?RC9JRzBIcjJmcVVaN2lXOFc2bWVDdjk3ZFhzRnVTR0ZZeEJuM0E5TVA5TWZ1?=
 =?utf-8?B?d1JYYWFrSy90V1ZvM2ROU3ZrUGU2OGRoQTM1cGtOTWI5RnYwb0cxUStERW1Y?=
 =?utf-8?B?UmszSTAyM0RDSGI5MnJ4aTZmUW5RWU9GU1p0TEVydVJIVnFBM05vcDQrK0Zo?=
 =?utf-8?B?UlJYLzFrb0x6S1dlemhwOHorRVlyamVXVXRudUpCTWVDWjJaMG03YlB4U2VK?=
 =?utf-8?B?N040Z25VVTlud1BDSmJlRENRWThUWUQ4aVBRNGdMSWlIQUIrWHcrbHdUS2xs?=
 =?utf-8?B?Y3J4YVFGbU5nTnJTZDBjYS9yNlgrSER6ZlRxb28vdnEwUUZ0dUVzTDlTMDI4?=
 =?utf-8?B?c0dlLzJTRjZEWXlOQmxyMzNNT3pNVDNCSXMxZzJLYWdEeUVjSkFxS0YreEpz?=
 =?utf-8?B?eDJHWkR6dXRjTEUyWGdXQ2VUUGpZcmpyV2MvbUFBSVgweGRDQnRnRGdKQ0Qv?=
 =?utf-8?B?cUZWMTkvYnpGTnhpb2lRaFJLUStmSlZiWnVIUHVHL3A2cWlSajdvajJFUE9J?=
 =?utf-8?B?QTJ6OFhFdW52VmUrS2o4amFiS3pleUlVajNld1hjUlBxa09YM05WVXFNTUxH?=
 =?utf-8?B?NnY5L05tTSs3RTZLQUowaHhIQ09qdmYxbmlLVmZHZlpTN3ZPcUZVNmVVTmsv?=
 =?utf-8?B?N3F5b3RZYmhxS21qdGxMRUl2RXBnT08rMUdBT0x5UVA0L3RheTdKN0lvUEZO?=
 =?utf-8?B?UlJMTG96MFRLSUdjMElnZ0dVYStTR0oreVpabVdGTmdnR21wa0w1bCtsQ3BV?=
 =?utf-8?B?N2dCd3M4SU5vTFJmYno0cTN2a3Y1R0JQdnRhdVAwd1pwU0tuM2ZwU1VTM28z?=
 =?utf-8?B?R3VjcG1ZRkZYK29OUUJvQ0JJMklyMDFIdHRNN2djdHkva1VRWlZuWG10a0hv?=
 =?utf-8?B?TUxzam5Odm5KbEpvbVA2V1lQUUlDaFVrUkwxWjZ3UXdNT040T3NKeGxXZ2Fm?=
 =?utf-8?B?eTJXT1ZEdUNzUTRnaHpPdzhCbzNnWVRFMkNUSnNpaWVyLy9LM09iUTBrM0hq?=
 =?utf-8?B?THRobHYzbm53bWx4VzUwZlhIMmZpdjc0OE9IWHAzNGp3MCtRSDRpVkVaKzVk?=
 =?utf-8?B?MG9nZjdxUHNBL1p0R3piUHZtUW1iNGlVa2Zmd21ya09oQy9qREJqbXEwbVNW?=
 =?utf-8?B?cGRxUWtvMytTdEFKK0x6ei9YcU5wS2ZkNXVUQTdBQWlLdDNwTVpIdlVoOTNU?=
 =?utf-8?B?c1N3dUpyMkYxc09aUUxKWFBvaUV6a2FXdWszZ3lMM2hKZmxZeTQyWlhSaHVD?=
 =?utf-8?B?OFVJaU50cGNxdmljdzF0QzQ5TDNhMGJqN0JPSTc4UkZCdDA4c2lIWjMvaVor?=
 =?utf-8?B?UmNEaENLMmxWYXE2SGRyVG95UTU4MERLYjVJSXBoM29FeHlJQ2dGQkh3M2t4?=
 =?utf-8?B?RHo5Y3JUb1BaUXpsbnRiSlhvYjBoSk1MUjFGNmlzeEhuQmZEQmp3dFNhc1pk?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e293625-5b6f-4610-2fa4-08dde4f94f78
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:35:58.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1fbI/MLRQqFBZ5tBz7De0cyFNnx/EiTF2k4j4sQsCV2BG6R4xoNOH7NbtY4xnxZZ3OSRaRYY00qTvJ4IMf5m+vmqwni2Hh8eY7K/pU4l+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6128
X-OriginatorOrg: intel.com

--------------7VEKSqgORZkfl25Bx7bp0QFz
Content-Type: multipart/mixed; boundary="------------UBDCucU0jj6A8DKX20WSoDO0";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, mohsin.bashr@gmail.com,
 vadim.fedorenko@linux.dev
Message-ID: <bd17585d-adc4-4577-9338-a3b4aa0e4fd6@intel.com>
Subject: Re: [PATCH net-next v2 5/6] eth: fbnic: Read PHY stats via the
 ethtool API
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-6-kuba@kernel.org>
In-Reply-To: <20250825200206.2357713-6-kuba@kernel.org>

--------------UBDCucU0jj6A8DKX20WSoDO0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/25/2025 1:02 PM, Jakub Kicinski wrote:
> From: Mohsin Bashir <mohsin.bashr@gmail.com>
>=20
> Provide support to read PHY stats (FEC and PCS) via the ethtool API.
>=20
> ]# ethtool -I --show-fec eth0
> FEC parameters for eth0:
> Supported/Configured FEC encodings: RS
> Active FEC encoding: RS
> Statistics:
>   corrected_blocks: 0
>   uncorrectable_blocks: 0
>=20
> ]# ethtool -S eth0 --groups eth-phy
> Standard stats for eth0:
> eth-phy-SymbolErrorDuringCarrier: 0
>=20
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------UBDCucU0jj6A8DKX20WSoDO0--

--------------7VEKSqgORZkfl25Bx7bp0QFz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaK5E3QUDAAAAAAAKCRBqll0+bw8o6NDd
AP9LAadC3QpCUeN4SRFzNMWgiCmTX8B1KgE3nAgpcFb4xQEAiT+gGxC5abfss4CtuyjRHuozZwQG
bugHsqmHWzU/Vwk=
=OGee
-----END PGP SIGNATURE-----

--------------7VEKSqgORZkfl25Bx7bp0QFz--


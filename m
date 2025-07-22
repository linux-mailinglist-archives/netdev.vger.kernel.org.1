Return-Path: <netdev+bounces-209113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A77B0E5B9
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 23:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906941C22578
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 21:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A354D1B808;
	Tue, 22 Jul 2025 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cig+MoUR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203502E371F
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220809; cv=fail; b=jdm/Lg/bztXbAkU7jGvYJijUIAX+4/T0H4BimEs6DCrp408ilFqRNRpqZTqqiN3XjebSPZPNwxDQOY25SsOgs+n1ALYuy5QUOmHoQyI/Kb93ka6JVL6eAjMzSmuMZurEYl0CvNU4P4DBaBA5HHOhPE/RZ0G69TLDXb1jQydzsUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220809; c=relaxed/simple;
	bh=3epxG2T/8HnUq5ByryvRSBwoM3gCEnuV/FJ6WI+4H0o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qmMyPVKkWUgsOKH+9lFgmire1gj0GX64a9lR86Tj/Ih4c8wSJ9EkynKjhBESe4ydpN6QuxVWc2vf030q5AAfcuomS0IjUxs0Biif1M5/Zuk1KS6LwTg9T0Wspnc221ku8LqnaJP/bHKm5qCSerfo1bM5vHMdg8tMQj+CGXRK4fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cig+MoUR; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753220809; x=1784756809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=3epxG2T/8HnUq5ByryvRSBwoM3gCEnuV/FJ6WI+4H0o=;
  b=Cig+MoURIezECYRkBfxo5/StJPkq0IYmnyLyD8AgXRVbCDz+eJY9AvQr
   zvk8oImPEuOAkd3ASnvmhOGquFG4bf29EQdu+Qg6kz3Hq2M3p8RGnHQ4+
   7lM31fUp/Ns4yGtVEgGfUAkbuwpPffvxErDrrXPjLl6as0Zonav9ht4Sf
   L/b7uYdgtE+VlgA7jHB/LMyOK9fLveElFd5XgFHHA2DBcOjpuROsRaO7z
   A6kDk9ss6kDjZm+5j4TtOnNeDOUEDnnYD5+VVYbIhfUqf8oMtlZjbQQ9H
   ZRedGx9SoslTjmj5/fR9BTeC7CYf6zFuoIilC3kmaPbEyX57WeO59JAZ5
   w==;
X-CSE-ConnectionGUID: sXb69q6WTP+5+mW2C0fpBA==
X-CSE-MsgGUID: PYXPhaqIRUKkR3TEOLoRHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55193455"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="asc'?scan'208";a="55193455"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 14:46:48 -0700
X-CSE-ConnectionGUID: 4bUxVNwLSgu6VE5mny9Vmw==
X-CSE-MsgGUID: KIOB/vbMSPGZfRgcse2llA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="asc'?scan'208";a="158560315"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 14:46:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 14:46:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 14:46:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.73)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 14:46:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xajSNEZHLVYNWWJvxDddvyfWh1l0o5Phbmpdteua1VVy26I6ZVamJ+l1PhBxgP9nxOH9UEVxju2D3rkcxXevl4HslzIQgsR3eYeuR/D4Q3lCG9pgSB7ZE2cVdbBtfqGEV4cMbH4izC7A/Dr63OSb5hVuPVQzp0bdRfne5i75AOftLPxseTS6QYAMJYCex1CHWIfRqMUnsN7sKZ5TV2+R6lLhadxZbVA15mx/B1oHBlQkB8QJW2RKVlElBEiXgZUWatjQJtnw0ljRW4i752v/g86+d5c1KFT1ailFpN3UPAe3zVpe5a0K26KNYvaTnO1B9YeI3DW+DbjohEtCY9Uh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3epxG2T/8HnUq5ByryvRSBwoM3gCEnuV/FJ6WI+4H0o=;
 b=NGr6sLrYdqIsurDi2AxqHEpTzQCTIOEShGApnQ4vq2V+ZAvKJWshCQZz2QuaaXEZSWd6uUxNAJptUaVw4WvAxC6CHm6WvbX0/V0Nc0GkmuerpFYv7JyDAGic9O1sH2mHtrPDM+hHtYQ6ptIp5CI9X0XbyWCNiQOq/EW2hcMpMAnlBV6X3SvjdO9axZuE22icAJ25jj/qUfrtFruz9xSI0h34fgwLEaiBm4Wlm5MqV+9EmxrXwAELJnmc1L6TOpX/vG1Xiqw9Ei+3bMjk24XD/oK0cFkQkvCMf1FKMg+XUVwPREoft6jQeshipJy/IE6cM48iwBwn1qdumUzPSL/B9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 21:46:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 21:46:18 +0000
Message-ID: <c6ae72a2-76fe-4032-8705-821c2280f9f3@intel.com>
Date: Tue, 22 Jul 2025 14:46:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: wangxun: change the default ITR
 setting
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>, "'Andrew
 Lunn'" <andrew+netdev@lunn.ch>, "'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>, 'Jakub Kicinski' <kuba@kernel.org>,
	'Paolo Abeni' <pabeni@redhat.com>, 'Simon Horman' <horms@kernel.org>
CC: 'Mengyuan Lou' <mengyuanlou@net-swift.com>
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
 <20250721080103.30964-2-jiawenwu@trustnetic.com>
 <d45910fb-f479-4991-85c8-7dd5e2642ff0@intel.com>
 <02ae01dbfab1$f30618a0$d91249e0$@trustnetic.com>
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
In-Reply-To: <02ae01dbfab1$f30618a0$d91249e0$@trustnetic.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------4L34syQgzw7fTDOvLKKhsIn0"
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8ff08f-7856-4995-d366-08ddc96930a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXAwWmhDcVNjRWZ4RGFBdTNaWUpmVytQMTh5SzBVVDBraW1DQXg2cjdrWEc4?=
 =?utf-8?B?V2RuQVA4SFZTSUNxdmxOS0tiOHlwVG5TTUsrTEwxWmxLVXMyU2NXR3FxaVpn?=
 =?utf-8?B?bThjblQ5Um5PVnJVc2xOVTd4V2s5a0g5eGhmaXRLeXh2OHhuY1R0SUZYd0hL?=
 =?utf-8?B?NGJyYkhoOUs3eDI5TG0rSWxCaFdHU1U3N2RudTR6SFVabWtiTFJVTld6dUMw?=
 =?utf-8?B?SitJQnJtbGE2d3gwZU1XVXd5S1hGeDVqMTVXakRUVVYxdGgxOXpiMUJMN2No?=
 =?utf-8?B?VlBYT1ZCQnlmRk1rRW1FK3ZUQ3p3U0R5UkhGSHUwQ21vQmo4WjlBOHR4S3FY?=
 =?utf-8?B?ekx2MkRoSDJXblI3dm5ZbHdFczNRQ21kT1dCajh3ZW1raGdZMVpYcktFdnRI?=
 =?utf-8?B?Y3RpV2NHeStGdHU4MGNYKytGMXhJcnJNSU1kb0pweUZmOVcyM3J4SlQ1eC91?=
 =?utf-8?B?LzE5VjlUbGNLc1dsVjEwNkZsemJRUENJQnA3d1RoVVU0TUNuSkxFWWFCMnB0?=
 =?utf-8?B?Tndyc2svR1dYWEFITXhzMi9zWWV3TVAvQWZYUTFaQ0tyYmJyUi9qUmZIcFZK?=
 =?utf-8?B?U2gxMFZZalR2VG5URXdYZWlab3ArOStDaXo5c3J4VHVlMWFmRUIwTC9oZ3ZO?=
 =?utf-8?B?M0M3TDV0NldNWHozby9lZVdnajViamxVRzJhcWpvOUpTbmZaWXhVT29XQlV4?=
 =?utf-8?B?WS81eDdaUFdsMDhwVFRxNHFGOVJDWnhpcWJ5MEdwbFk0VWZGZmhNT1BiaXBm?=
 =?utf-8?B?RXFvOGhJL1UyaTByQ2RnaXM4bm5neFRtajMwTUFoalhuak91cjNzQkJBYmJq?=
 =?utf-8?B?TXd5cWUrY2lNcFdiNTFqdHV3UFl4b2Y1dFY2NXNJcWR3c0NkMWRSRW5mUWYv?=
 =?utf-8?B?a2JkdWxTeEZ0VnNEQ0o3eTNWcDZJTzZwUnBrWHRYRnMyeGlOaEt2Rk9EcDBD?=
 =?utf-8?B?VUlmSUliODBHblVsYjdDNGlmNFZFZ2Qrc3JnZ09xL0hyV0xYY2xySjJNUERw?=
 =?utf-8?B?a1l1QTF4bHA2RnRJVjRYWmJTWnkxbEZCUDluSy9MMlJFVmVpeXFzWkhXQ3pH?=
 =?utf-8?B?Y3c1MUp4K0U1RWJxVXZyQlMxdU1HYkU1eGdGbWFVZDlRakc1QWMveE1VaTZ5?=
 =?utf-8?B?aW5leU05Qk5makJocllwRXNEMmxWSWw0QVJHakNjd2pOK2c4L3REZ3Y1Skx5?=
 =?utf-8?B?Z1BEclNFNVBGV3VNYW1GejV1VnRWU2RGeEQwa2Q2NmhnSzJPbm9VVjFvUXRa?=
 =?utf-8?B?QXE5Zys2NmRheGFqdHE1VldqSHcwNVNLcmdhVjltYW1NOTN2NVhkVGdnTFFk?=
 =?utf-8?B?UGdaekVOcEdob0tsRUFDekRYM21JVzc0U0M3ckNibkJWalVtNHZhQitJcmUv?=
 =?utf-8?B?WDhFUi9DcGdBcmt5ZVNLZ1crOThidjViK3hhbk1IN1cvb24zajZ1Kzh6bG1E?=
 =?utf-8?B?czFiMDVXQTUyTnJId0NmaWdzdnliRFQ3REZzRjJxZjdZZjJObktXVkJBM3dF?=
 =?utf-8?B?T0RhdzNjemVrd0VnUkRaR2NPMmtuV1pwR3BjMVdRRGNWTUdFTlZ3QjZrT3Fn?=
 =?utf-8?B?V1ZleEJBVURwU0VkMFhKQm1uWTFrYlpSMGZseGtrcC9oWkFwY1UzbW9naFd2?=
 =?utf-8?B?TzVvaGhuNE9MTitHWE5UNzBrYjRxTUpOd1Q0REJtVU90WkVVYnpDQi84ZTJ4?=
 =?utf-8?B?T2FCcVA0a0VjTW1ITjFMMkcvdy9XcjJhY3RHdkVSSjFEbmYzVnhkNU5OWkV2?=
 =?utf-8?B?bi96MFZieVkweXZ3QzlMdzZFeWExK0FtcS9icE9LY1BmTWNOaGhheFc4YjFa?=
 =?utf-8?B?TkdPZlZPT2F1cWRkaTc0aWlMc2NPTmlyVnFYMlJBL3F4eFJpY2kzZXJOUEVO?=
 =?utf-8?B?Rmt3a3hVSldlVlVOSmxjUVRxTm93aC9VWTIxMjdqdURZQlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWowTTBTYTlKZG1NVlh0czFQNHllWGNCVFVwelBjcDB1OWVBK3NuS0NjUjB2?=
 =?utf-8?B?TEJDZmZWbXh2UGJHazJDQmlkMEZrc2liQmpNRzFjQlJnZ3A5K0FCZ24vZHpR?=
 =?utf-8?B?WTlGM1hoZlV6Q3ZNOU5Rc2hPQUxOYkxEZHJCR0cyaWNSd211UzJBazVyL2RM?=
 =?utf-8?B?N3gxLzJlM2g3cGhLKzl3ZStxbTZQTHoySWhsSVpEMDgzd3FQKzVMSE1adWJ4?=
 =?utf-8?B?c0g3MjBPQk04YUUrUWNhc2RDU3UxK0ozbm1GN2V1WkJwTmE3SzA5ckd2Vjg2?=
 =?utf-8?B?SHJjSVpaWFE3ZW1ma01udHphSk1hMmd0WTVxbVFGeDd6eG83QldTY295SWFB?=
 =?utf-8?B?dzdYSjhBWjBLYWhQSzA2S080bHU4S3BScmViY0J6RDZkbUVUOVdxS1FjN2N1?=
 =?utf-8?B?Y1QwaURLMmZPWTgvNG5QMlFCQXRMSVdtZXdaWm9MRnJNNmVRUll5QnE3Y3h1?=
 =?utf-8?B?Y0YxVXkvNGJudUVRejVPczZRejUyaDc5VjF5cHFidkVXSG9NaEN2K00xZGxp?=
 =?utf-8?B?STNVc3NnQ0J5RTRsS1Nhd1RvSFZwYnBTVUtqU2RsOHBnVU5LaktmNXZ5R3R1?=
 =?utf-8?B?dEhnY1RsV28xeTRRT2ttMlhkYnR4eFg5TTNkVUw1YTlCOTEzRGtrUDlVdnRD?=
 =?utf-8?B?ZXN0blV3VEZRQTlxbURUbEhzRGN6MTVHSUpha040WFFNM1JwdGRLWndoVFZG?=
 =?utf-8?B?bG5Vd1lrK3dOTWg5aDZnd0ZGVHJUVXdNaWFKcUEwSWtBZGNBcnFJcFBCNy9q?=
 =?utf-8?B?QjJCamgzSDl3N0hWTk1VRHlGNktoUjVkQUY5a3lpWU9Qa1ovNjVEemwxMDhB?=
 =?utf-8?B?dDNtWFBrWUpwYVJtM0lyQy8zTTIzcDZWOEdRb1NTTWQwQ3FMRStiTElwd0V0?=
 =?utf-8?B?YnhTRXBBdXRoVU5abUJ1cUNkWUxleXdXVnpLY2RhdU5qZXhxZWNkN2JIS05S?=
 =?utf-8?B?YWM4MEdscjZFbzlkZ0J0c1BSdzgwSFozQlNrUVhidTFGMXdsQitDVit4L2ww?=
 =?utf-8?B?RnhqT05uQ3FHTXZpb2FtUDQwc09wVWgwRjROT1hZUFF0a0xpTzZsOUxXQ01P?=
 =?utf-8?B?RVdIK2NEV0N1UkMxbDBlU2F4L2NHWk9nMldTdDd4UHJudFJSdDJjVjJhbEdB?=
 =?utf-8?B?Z3JmTXRQeHdBQks2eUR3ZVBLa2psWmZyZVh6OS9sL0xGWGphb1ViNGMva2Rh?=
 =?utf-8?B?RmZSbVJ0cUZoaUNNYllnS3E2bU5TQndCS0JFT1Y4Ui9ZRnI3WUpJRTZQUWxO?=
 =?utf-8?B?QklIblgyV3BwazhjMXlCSkQ0MEVHSU5STnE3RCtkQ2x3TEdWU1RpVjdxNWVv?=
 =?utf-8?B?MkEwMDJHa2E4cE53YVlpdjlKWjhuUlJJa05kY3BqRGxXaXlaUEx5SXdOR1lQ?=
 =?utf-8?B?eEJUMnFNa2I5dGNyVU9BL3hQdDk5YklsRDhlNytlOTM2SUtOd2NiNEtMYWli?=
 =?utf-8?B?MXd1SWxYdmxGMW96eTRhem1ENTlIVkdXRnlHZFZVZkNQdjI1Vml0WDcrcjBL?=
 =?utf-8?B?ZVpJeWR2ZlN2T1RURlNKbkFaMDVEa2k5dVkyWU1BdUxJY2hqeEhCYWdPZjNy?=
 =?utf-8?B?dnhzbVNEVFdIVWhzbmN5TllWWDc4bEw2MnBsaEcyYWFPZThwK3kxN3cxWERF?=
 =?utf-8?B?Tm9MYkt4aXFGcWtreVU1WUk5S1lqNE9VQkR6TzNqcnpqY3RBQjRGM1lmZU94?=
 =?utf-8?B?Q0F2QThqMmFoRG5yOStCNU91MEpYQnJuRjQ3MzBzR2JCSmpFejlYKytyRUZK?=
 =?utf-8?B?Y2xCa3lxT3YwdzVSQkhUem03UEE3WXZHckdTT3BXU2w1Z1VLc1g2TDY0Y2Yw?=
 =?utf-8?B?SlBVa29MMGRDR2JTVU16VW5JcTFiRWxCa1V2ZDdnOFV5WW9RK24zd3RjMTEz?=
 =?utf-8?B?UFZ3TC96Q1VxUEVqUVlqZ1d0RENubng3TnhtOHpVbVkycUNZYTRaWCtsQ0wr?=
 =?utf-8?B?YlhSVVJ4WStKblFkYnhXRGI1YXhmb2NXTE9Fd29BRCtTUmVGbjZhcHBCZzc2?=
 =?utf-8?B?UGNxUGtVWjJDZnFpSG5aOGlrOXkyV0NxZzU4YlJVS1E4TmkyNWJiOUtHOEV6?=
 =?utf-8?B?eEgvdGpTZWZ6bm9xZjZQdEszZXc2ZGdyMU9teVZxVGoyaFIvSERkTlh1SjQz?=
 =?utf-8?B?VlNYd1JNUDUyTVZKU1FvRllEVFZXcXgxSkx4cDYrS0FhZ01Vb2FVTXFzSEZD?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8ff08f-7856-4995-d366-08ddc96930a8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:46:18.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93aEFWtTKi6JY1olKOc6BKSmzICJRl1V5n/BxrA1hLt7+OlJ8hIrCHI4c9wRpVmJX5FQn1hyGS2cb7ZBmaVhJuyo67oyMEYVYLn3o6dDSpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

--------------4L34syQgzw7fTDOvLKKhsIn0
Content-Type: multipart/mixed; boundary="------------QRdSEJzy0e10BQdmwUVA9q6O";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 'Andrew Lunn' <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>,
 'Eric Dumazet' <edumazet@google.com>, 'Jakub Kicinski' <kuba@kernel.org>,
 'Paolo Abeni' <pabeni@redhat.com>, 'Simon Horman' <horms@kernel.org>
Cc: 'Mengyuan Lou' <mengyuanlou@net-swift.com>
Message-ID: <c6ae72a2-76fe-4032-8705-821c2280f9f3@intel.com>
Subject: Re: [PATCH net-next v2 1/3] net: wangxun: change the default ITR
 setting
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
 <20250721080103.30964-2-jiawenwu@trustnetic.com>
 <d45910fb-f479-4991-85c8-7dd5e2642ff0@intel.com>
 <02ae01dbfab1$f30618a0$d91249e0$@trustnetic.com>
In-Reply-To: <02ae01dbfab1$f30618a0$d91249e0$@trustnetic.com>

--------------QRdSEJzy0e10BQdmwUVA9q6O
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/2025 7:40 PM, Jiawen Wu wrote:
> On Tue, Jul 22, 2025 7:56 AM, Jacob Keller wrote:
>> On 7/21/2025 1:01 AM, Jiawen Wu wrote:
>>
>> It looks like you previously set some of these values here, but now yo=
u
>> set them higher up in the function.
>>
>> Its a bit hard to tell whats actually being changed here because of th=
at.
>=20
> In fact, here it's just a change of default rx/tx itr for wx_mac_em fro=
m
> 20k to 7k. It's an experience value from out-of-tree ngbe driver, to ge=
t
> higher performance on various platforms.
>=20
> As for the other changes, just cleanup the code for the next patches.
>=20
>=20

It would be helpful for the rational to be explained in the commit messag=
e.

The code seems fine, but I think its just the nature of this diff which
made it hard for me to track what happened.

Thanks,
Jake

--------------QRdSEJzy0e10BQdmwUVA9q6O--

--------------4L34syQgzw7fTDOvLKKhsIn0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaIAGqQUDAAAAAAAKCRBqll0+bw8o6IAB
AQCAHhIV4JKCcnHEpH6a9QB7siZbqMl4OBOlh3LtDjPFlgD/UnuKTEcqa/lotamQ0p9GLFhv1J6C
VW/XiQ4dtVbd0Qs=
=yetG
-----END PGP SIGNATURE-----

--------------4L34syQgzw7fTDOvLKKhsIn0--


Return-Path: <netdev+bounces-180778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69FA82774
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24AEA3B1D99
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577DB26156D;
	Wed,  9 Apr 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mh+v3pDc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8C265616;
	Wed,  9 Apr 2025 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208073; cv=fail; b=YSzhbxlDYSkFodS2IOy8a4aLyRvriOt929o4srDJnjrqxRhZhm5y4yzRifApb6GpCVG+mtAe4lN+oItdrcSGgbfSmcBouSEY2w4l6zzqQ2DEl4rEWrkpNlNytSnwDccdMftdDNVON5fXywuS8VloasgocpSXY3LglyC+KdozOh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208073; c=relaxed/simple;
	bh=FH18Dcn/1+E4F6lQm4ilaMm7V3POAvmE/P/AR+XNhZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTvrRn6X2WhvO9KCQRF0Qv/th40ZmhlyuAzJu5k1eUr4PZKgRI4bOmI94hgLo2k3VDPvbEPWeoKvWeQMtKAP00Gy/xI4GjG368Fs4yVnWYEBszKZmj0V29xaQ+djGm46fRaTNsfZg4rNvZL7XiYxbqpO4EQVX9YpKEr+3oEsxUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mh+v3pDc; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744208071; x=1775744071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FH18Dcn/1+E4F6lQm4ilaMm7V3POAvmE/P/AR+XNhZM=;
  b=Mh+v3pDc0k0nLQctWotPP+5X/z/YNkFmCubr92/2Q4NBWeYS6r2ivSK4
   dTDLNoruYw/mXtIhpimR0B2VF17ForzbFTCEsjTkkCPVRpqZ0lKJ0euRK
   vRoKqmIwoWsVC2Ili5DSIr9/81cbSD03dvABZkVPLmQNR6+CTO59gzfkh
   wJ5XnJbWTN/rTmS0aBv67keDGYsWQcQlPVhIC2kkWMQGx84iR1MGFdY7o
   xa3S4ViRP2J8ZROzafWcPFRikVIIl9NitxHC1WJ/D+Kjjpel418pDM2C8
   UAbhsSWj1y6006WBcAfvuOorLOvSg4XAadPfZp5VuUaIz8V1SEoMj69x4
   g==;
X-CSE-ConnectionGUID: ED8QZYoXSIqA7BVXPQHlvQ==
X-CSE-MsgGUID: BrVOX/giSc+5V+JgWnYjrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="68164734"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="68164734"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 07:14:26 -0700
X-CSE-ConnectionGUID: Qg53W+NYShqRYqneidBzXg==
X-CSE-MsgGUID: /SmIiKwWQBWFL+1DS+RLJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="128516635"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 07:14:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 07:14:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 07:14:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 07:14:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+puUrolw4tPzLQ7JBoscz5fb8dvFXL9aMrlqWYqcZGpTyDF70zzHc5fpDtty1Ew6Ym8UrrARcmeM2TMWf4aKq08pUdHKfNDxHNNJia0zUrwhrvYGok5oHC66kHu3rPMLM+X6kWYd8oIr+X6dhUcsXt3oc7zVBPNvZXVtYygaNg/Rkr0SpNqRCh1kdFSKIx/lPJdq50ISSd2UYE0RHRgljOhLqwXak5Y2vcs4GjXSEvJoB8hLrz87fzwOVQZzRcIvCo8fozYr9mVH4VV5GZd3dus2446zOvE7TFQkIhzc9CneqBipRxq5XXus2fB2iloUKjBNFNO835TFa1IIZk5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH18Dcn/1+E4F6lQm4ilaMm7V3POAvmE/P/AR+XNhZM=;
 b=d5iVJlpdi1RBPnFSZbVEb6KQVw/M1m7wfRlKPxJnF/8c1+sKOdXwkHu5TERwn5pByrlv5cTxX7LCNJM4DBMYj2y8prA24qHKgdcAW6SirGi1Yg76VVDJJRDT8/WIYBzNnVwzrpo2zm5vmsUsBLvnnlphPbATmIpVRO+5AB0cnynMGaGbAdYWqTNEzL9pkn5zEel85shaqXEiggduHp5E6vIE4we0VWLJ9JQ3QcKjXm5KW1VuXnI9jmU9RqxxeYI8/z/edr438wqG5I5+zLfLh+g1MELUDp2UCBQzgWABmp5AtMc60xIFyvlU+QS+rAzsyWKc8DBBIqpEtKrixvZO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) by
 PH8PR11MB6952.namprd11.prod.outlook.com (2603:10b6:510:224::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 14:14:23 +0000
Received: from DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18]) by DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18%5]) with mapi id 15.20.8583.045; Wed, 9 Apr 2025
 14:14:23 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Dumazet, Eric" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, "R, Bharath"
	<bharath.r@intel.com>
Subject: RE: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
Thread-Topic: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
Thread-Index: AQHbqAc+IOPKqVTF60C3pQTjerY+GrOY6wcAgACuWmCAAFvcAIABbcTg
Date: Wed, 9 Apr 2025 14:14:23 +0000
Message-ID: <DS0PR11MB7785945F6C0A9907A4E51AD6F0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
 <20250407215122.609521-2-anthony.l.nguyen@intel.com>
 <d9638476-1778-4e34-96ac-448d12877702@amd.com>
 <DS0PR11MB7785C2BC22AE770A31D7427AF0B52@DS0PR11MB7785.namprd11.prod.outlook.com>
 <7e5aecb4-cb28-4f55-9970-406ec35a5ae7@amd.com>
In-Reply-To: <7e5aecb4-cb28-4f55-9970-406ec35a5ae7@amd.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7785:EE_|PH8PR11MB6952:EE_
x-ms-office365-filtering-correlation-id: 8a32667d-d278-49de-3a88-08dd7770d3ed
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?ak1CbEFicitLa0hmbTRGRDQzWXRLUHNzRklKem1GVVFIK0dmbGpscmUyaDFH?=
 =?utf-8?B?MEZWTkt5YWdNNmlpKzRzckM4RGVHNk0vTVFnOUpWWTJSYno2T3FLSHlhcmpP?=
 =?utf-8?B?VDgzbTNoaDJWZjREY2g4UHRTcENPSk1VNmpmRXFrS25EQXlSR21sSlN1dkgv?=
 =?utf-8?B?VmsxaXh6dTB6d0RLdEJRRGI0MXgxbjBEM0VWdHAxQWdEM0lqRCs3dm55MXpq?=
 =?utf-8?B?ZjV3Ym5KODJ5dktIay9XSWdOOGhBVHNINFhuUTcvUSszbHJUVFVSc0xYNnc5?=
 =?utf-8?B?c1JvTmdrWEpxbWhidUQyV240RmFNYlV5WnNNUTRyRXdiV2FUK2NFV2dqQUlK?=
 =?utf-8?B?TVpnSFpxT3dNZ0tuOUVJMFZUSjNYVFFIT3ZHbjlvOEdmMDZyaHcvU3pjeVk5?=
 =?utf-8?B?bU9yVHlYQXcvQ2pCcnRTd09CaXNqcDJnbDRZVUJSU1BqRG1WRzJESi9DeUNP?=
 =?utf-8?B?MW5TZlo5dEhhVTBndDE1NG1XdXhYTnBjWDNQQ28wQ3gwZmVQNmJmSVVrR25i?=
 =?utf-8?B?OFB6RW5CeFF5RzEzbzNvNWtNeVp0TDI1SnRtdkdyQUlyaTBEZFA1Nzd5Nmwx?=
 =?utf-8?B?SUtwN213ckt1U3JHdW53a1B4NW1uRHF1TlhlcG5lRC9wd2NjKzRuOTZjVDlU?=
 =?utf-8?B?MXBKVkZMajZESmFIekJnVzBrRXdlLzRsVjZaTzhjTVFzRTIwcWQ4MGJGM0hV?=
 =?utf-8?B?c2w1NXR3QVF1OFJvZGFTNlh0OC9aZzFwNS9PVzNtVk9ndm9iYWM1NDBBRlIv?=
 =?utf-8?B?RXlaYWp2bHlzWGFkOW03Wnk2SnZBWFByUEJ3Z3pKdEpyeXBPMDFMb1N6TkJt?=
 =?utf-8?B?VG5ROS9udXlRMS9qOUpNeEgwR0xZWVBxVGdvSS9EaGxOS2F0aFErZC9pQnl3?=
 =?utf-8?B?TE1oZVRkWWtobUxzUGRQek1CTHhKWnJPVldwZ05Cci9KMHFzbndDdmZyYzl2?=
 =?utf-8?B?YXY0cTBIb0RVR3VnbXVRN2VaRlZGZUpWRDhieTMyUS9UQmMyRkZmQWZNOU53?=
 =?utf-8?B?STVERmVpdXdScVhUWEZQOUFHZlAyUTJvTWVNWFpZK2UrdXVKcnF3NnhONTZB?=
 =?utf-8?B?Q3NFRTF4WVBIWVlXMGh1a0ZkaS8yU3RuRlpUL3BOZzVRZnZieUJ3WWlMT2N0?=
 =?utf-8?B?ZWtYOEdDcVZSYnRENkR5ZVZoVHhhazQvVE5SbmpWM1R0N0dreWRaWWh1amNm?=
 =?utf-8?B?a2JiRFp0UUdic1ZsS2FQWlA5aXU0TTdnZEsyRU5oY0dHcGxQWXpza1V5bzgv?=
 =?utf-8?B?cUtFMUJNa3ZXdkIvNmc2U3pKR21aSmU2dUJHU0d4bzNIMDRBZ1VVUkJZYWV6?=
 =?utf-8?B?azh4M1dmRy9PUjNtM2RITXRqa2FrcWlnU2dlc0VXSm1yN2VsRS9sbEVRSHpt?=
 =?utf-8?B?YlJkekw5K3YzS1pMblhja1RPbHozaEE2dDVyOWZDSEkwQVhWcU9qSDJSc1N3?=
 =?utf-8?B?TVJxazBjSWpFUVJJUWRJSThWU2EyMXVhdWdDUHBXUVluRWc2OENUaGh0TFdZ?=
 =?utf-8?B?MkNhNk1SdkJadzdHcHk4RjlIR290VlovTDJtcXdGclU0Tk9yb1pkKzZmNkgv?=
 =?utf-8?B?NDk4WGRDaTc0YWp6dkZLbkl3T2FjVC85d3JGUGR5dHNsK2YrZ251dmZiMUkw?=
 =?utf-8?B?cXVwa2ZJa215SlJxbGxCR2JNR2d6Qkt0UWZRUzBlTnFNaEh3RmtzaTBJSjlC?=
 =?utf-8?B?NThFdk5ZWVZCMHpvQUhURG1zWWVsemdWajRwL0swK1hSeGVPcytBNnViczQr?=
 =?utf-8?B?TW04VXVpRk84azNCaHpGRzRndG9SQ1FMYytPSi9ZMzlKK1E3bkdZMkYxMGM2?=
 =?utf-8?B?U01iM212QlZBTzRKYmtHZ3F4bUdSeER3ZUVKT2J0ZFR2NFB2K1hTbElPWXUv?=
 =?utf-8?B?a04yc3lzTkR1eFIxNmNHQWg5OVFsNExKNUphMWNMWjhpM1FaYmh1ZnZwK2Jh?=
 =?utf-8?B?eHFmMWVSUGlEWUl6U3RhbE1PRmJveXlYOE5SeUlEZHRIbHM1Q1UyNS9CaFZ1?=
 =?utf-8?Q?ir6nAtjy2k3CqWqc5fJPMZ2pQSBinI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7785.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2I2S2tTNGlnLy9sc0k0czhkMC8rTWE1MHc0ejFiWGtTeXFxWExBNkxyYWkz?=
 =?utf-8?B?VitJODg5UEhpbmtNdjBqNk9xTHR3MS9FWnBUTmVsbVI1TWZwNy8zQStYWllo?=
 =?utf-8?B?UFRqM1lwbVRkcnhGV1ZTa2xWSG9KVVl2amk5TjUzU0ZONHgvWi9TeXV3T1ha?=
 =?utf-8?B?Wk5iUnJIUGd2RHVFUDZueTJYYzZ1MDJsVEtjeUdYd1Z1U05QUVZqYnU3MFU2?=
 =?utf-8?B?cVMzYXBTcTI1amRGdnl0Vnk0MmVLVGxvMlBWZ3ZHZ2lzVVpXQmNBQ0h6NUZz?=
 =?utf-8?B?c2tBL1NwT2FXMHZtS0lZRW5TcGN2S1JGbTgxSmluNHhiQ1U0N3JJd1pRYXEy?=
 =?utf-8?B?eERWbmx1UWQ4V0MySW43ODVJSXB5RjNPajdmOGgvVmVsdFhKUVRHOGREU0Zs?=
 =?utf-8?B?anNIU25qOFoybHZVQ0RFd2NpWk1sYVpmTllUcEdnZTlGeTFLUENwcVJFc2hG?=
 =?utf-8?B?cDJYQUN2N3BaYmlHZjB3cTZEWDcxNC90U0FuODdwVlRRZkxCdHNRQjhjUCtC?=
 =?utf-8?B?TytjbmxUVlhaa0V6U2kwWlpSclhLN2tZOHRNaGljZlJUbVZ1V3ZFTFpuM2Fw?=
 =?utf-8?B?SHplY3NyWEgxQjh5b2VMWGV4WWpWcmpLV2tHT0kyclV4MTlTbWdmYnJyRkRT?=
 =?utf-8?B?Q0pDOEpNdy90Q0l1NExGR3I2ZzB1ZGNBRU5pR2dGVFh5RDlHb244QzR3R00z?=
 =?utf-8?B?eWxJTGdoWTAxaG9OUm9jSktJVy93aGpVdVVkYjZXNnZ4dFRVbWZxTkFyZGV2?=
 =?utf-8?B?K0FqN2ZhaS9ha04yTitINHpGOEt4QlM3dXBWeVNXZWJTaUl4SGFqb285UE9N?=
 =?utf-8?B?M0pjcE9MZFZjNklKNm5UcElieVpQcFVrOCtiYkVQVllQWXJyWHFvMnhXdWNI?=
 =?utf-8?B?cXduSUVGMWgrNk9xRWlWMi9zc0F6cWF4T00yUkRNbHprRTdQQWNaZnFVRU1a?=
 =?utf-8?B?SmVHZzZsNXM4L3cwZDdmUWFXNFpmQ2MrNzMxcTJnOTd5aDdkS0NUdS9wS2N6?=
 =?utf-8?B?K09HNDBnaDJvckgzOWdHbDFoY1BqVitaNlJKUlVFNEMvZW5SMThLRG0wRlp2?=
 =?utf-8?B?NFVLL21mVUYxRHdMQmNuc2xiMTQ3UWlBbUhheDdLbUkwdzNIU0E0Q0pPOU5z?=
 =?utf-8?B?amt6bmd2YU05dXlkTk1CbDNvdFVxMk5FbGVLRDlsOUNlWjdWRFlEVHh1b3Rv?=
 =?utf-8?B?WGczNEFoaFNhbkc0SjNJZHRwMnRweDZMdmlyVit5UUVwWGVHK3k2VlFOK1o4?=
 =?utf-8?B?RFB2Z01YS0kxL1dYS2tUdlBqdzlUbHVHOHIva1g5QUM1VlRjRXdWTGR2NXpT?=
 =?utf-8?B?dVJjajZVUWw5dlVtMzdYN0J4SG5Bak9TUndIT3YrdjA0MW45YXRyb1JReVZs?=
 =?utf-8?B?WThFYTg3dGhLSXVVUmlTYlVsaURPZmd3SEJQeERiZWxQeUVMZG5sMTNXbHB6?=
 =?utf-8?B?dTBBYjRWTEwxQmhLMVFLd0cvT25UZUYvWHBBQTdIREF1K29vOGtaMHBXR3Fo?=
 =?utf-8?B?enBhNG01NEp6ZTAvOTB2THpHU2VIOVFQVEtpOWI2Y3VRWGJNME9PblR1cDRV?=
 =?utf-8?B?TTIzM1N2b0dvUldQeER2VkZuRTdqNzBNOWRCSnlRMDFLQ0tsTDQ3OTNNdFhp?=
 =?utf-8?B?blhpZWluZnV6RXBSSERwd3JsN3A1RHlZT0tFZzFvM0UraEZXdm1KWFlkVVRn?=
 =?utf-8?B?S3Q1QW05Mk9OTThMN0V5ckd0c3daUnJVS0FnYkVWQ2VBK2psRTVjTno4VkdB?=
 =?utf-8?B?WEZtcHVlNmtEUS96QVp5OFFoQW0xakxyc0ZOdVF3dVg5bUlzRXRtSDY3SVYw?=
 =?utf-8?B?ZGpaSlNFbjc0Q1E1d0Z1OS9Pd1BEMnY1NmMwY3ZXdkNTRkIxNVRJcXhWTnpD?=
 =?utf-8?B?cU5aZDlpOXBpRlQ5NktQK2d0YXVNdXBVYkFFejR2SDl5M3g0aWpsT3FWR0ZB?=
 =?utf-8?B?UGpDUys1a0VqakJpUTM4allIaUlJNGRqenRENVVDeFhKQ2dZY3BJZXdZL3JU?=
 =?utf-8?B?OFNoWlVKSHVYRW93RFZva3FseERhYUcvMi9jN2MvVEhaYVVFdUVjQTl1b0Rm?=
 =?utf-8?B?LzVPcnJoQ1dKeDJEV2J6M1ZTazkyUjFDVjc3citkUUZ0Um5JVktCbE9icXhh?=
 =?utf-8?Q?tSy6/HK6KGLKJB6RPPwQvVXJi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7785.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a32667d-d278-49de-3a88-08dd7770d3ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 14:14:23.1573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWExGBk1981eqVT0bM30SES5obLK/grC6FM9DDw7exbmJPABfCu8rlobOaV+lgNrP7/HPC9pGWO29xuvTxhnHqPakEux9qdh/O3yzIAc6qM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6952
X-OriginatorOrg: intel.com

RnJvbTogTmVsc29uLCBTaGFubm9uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPiANClNlbnQ6IFR1
ZXNkYXksIEFwcmlsIDgsIDIwMjUgNjoyNCBQTQ0KDQo+T24gNC84LzIwMjUgNDowMCBBTSwgSmFn
aWVsc2tpLCBKZWRyemVqIHdyb3RlOg0KPj4gDQo+PiBGcm9tOiBOZWxzb24sIFNoYW5ub24gPHNo
YW5ub24ubmVsc29uQGFtZC5jb20+DQo+PiBTZW50OiBUdWVzZGF5LCBBcHJpbCA4LCAyMDI1IDI6
MzEgQU0NCj4+IA0KPj4+IE9uIDQvNy8yMDI1IDI6NTEgUE0sIFRvbnkgTmd1eWVuIHdyb3RlOg0K
Pj4+PiBGcm9tOiBKZWRyemVqIEphZ2llbHNraSA8amVkcnplai5qYWdpZWxza2lAaW50ZWwuY29t
Pg0KPj4+Pg0KPj4+PiBQcmV2ZW50IGZyb20gcHJvY2VlZGluZyBpZiB0aGVyZSdzIG5vdGhpbmcg
dG8gcHJpbnQuDQo+Pj4+DQo+Pj4+IFN1Z2dlc3RlZC1ieTogUHJ6ZW1layBLaXRzemVsIDxwcnpl
bXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPj4+PiBSZXZpZXdlZC1ieTogSmlyaSBQaXJrbyA8
amlyaUBudmlkaWEuY29tPg0KPj4+PiBSZXZpZXdlZC1ieTogS2FsZXNoIEFQIDxrYWxlc2gtYW5h
a2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbT4NCj4+Pj4gVGVzdGVkLWJ5OiBCaGFyYXRoIFIgPGJo
YXJhdGguckBpbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEplZHJ6ZWogSmFnaWVsc2tp
IDxqZWRyemVqLmphZ2llbHNraUBpbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFRvbnkg
Tmd1eWVuIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIG5l
dC9kZXZsaW5rL2Rldi5jIHwgMiArLQ0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL25ldC9kZXZsaW5r
L2Rldi5jIGIvbmV0L2RldmxpbmsvZGV2LmMNCj4+Pj4gaW5kZXggZDZlM2RiMzAwYWNiLi4wMjYw
MjcwNGJkZWEgMTAwNjQ0DQo+Pj4+IC0tLSBhL25ldC9kZXZsaW5rL2Rldi5jDQo+Pj4+ICsrKyBi
L25ldC9kZXZsaW5rL2Rldi5jDQo+Pj4+IEBAIC03NzUsNyArNzc1LDcgQEAgc3RhdGljIGludCBk
ZXZsaW5rX2luZm9fdmVyc2lvbl9wdXQoc3RydWN0IGRldmxpbmtfaW5mb19yZXEgKnJlcSwgaW50
IGF0dHIsDQo+Pj4+ICAgICAgICAgICAgICAgICAgIHJlcS0+dmVyc2lvbl9jYih2ZXJzaW9uX25h
bWUsIHZlcnNpb25fdHlwZSwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJlcS0+dmVyc2lvbl9jYl9wcml2KTsNCj4+Pj4NCj4+Pj4gLSAgICAgICBpZiAoIXJlcS0+bXNn
KQ0KPj4+PiArICAgICAgIGlmICghcmVxLT5tc2cgfHwgISp2ZXJzaW9uX3ZhbHVlKQ0KPj4+DQo+
Pj4gUGVyc29uYWxseSwgSSdkIGxpa2UgdG8ga25vdyB0aGF0IHRoZSB2YWx1ZSB3YXMgYmxhbmsg
aWYgdGhlcmUgd2FzDQo+Pj4gbm9ybWFsbHkgYSB2YWx1ZSB0byBiZSBwcmludGVkLiAgVGhpcyBp
cyByZW1vdmluZyBhIHVzZWZ1bCBpbmRpY2F0b3Igb2YNCj4+PiBzb21ldGhpbmcgdGhhdCBtaWdo
dCBiZSB3cm9uZy4NCj4+Pg0KPj4+IHNsbg0KPj4gDQo+PiANCj4+IEFjdHVhbGx5IHRoaXMgc3Rp
bGwgd29ya3MgdGhlIHNhbWUgLSB3aGVuIHRoZXJlIGlzIG5vIGVudHJ5IHRoYXQgbWVhbnMNCj4+
IHRoYXQgdGhlIGlucHV0IHdhcyBibGFuaywgc28gaXQgc3RpbGwgZ2l2ZXMgeW91IHNvbWUgbWVz
c2FnZS4NCj4+ICBGcm9tIG15IHN0YW5kcG9pbnQgdGhhdCdzIHNvbWUgc29ydCBvZiBuaWNlLXRv
LWhhdmUgcHJldmVudGluZyBmcm9tIHByaW50aW5nDQo+PiB0aGUgZGF0YSB3aGljaCBoYXMgbm90
IGJlZW4gaW5pdGVkIHdoaWNoIG1vc3QgbGlrZWx5IGlzIG5vdCBpbnRlbnRpb25hbCBhbmQNCj4+
IGRvZXNuJ3QgbG9vayBnb29kIGltaG8uDQo+DQo+QSBsYWJlbCB3aXRoIG5vIGFjY29tcGFueWlu
ZyB2YWx1ZSBnaXZlcyBkaWZmZXJlbnQgbWVzc2FnZSB0aGFuIG5vIGxhYmVsIA0KPmF0IGFsbC4g
IElmIHRoZSBsYWJlbCBkb2Vzbid0IGFwcGVhciBhdCBhbGwsIHRoZSB1c2VyIGlzbid0IGdpdmVu
IHRoZSANCj5vYnZpb3VzIGNsdWUgdGhhdCBkYXRhIGlzIG1pc3NpbmcsIGFuZCBtYXkgbm90IGV2
ZW4gbm90aWNlIHRoZXJlIGlzIGEgDQo+bGluZSBtaXNzaW5nLiAgUHJpbnRpbmcgdGhlIGxhYmVs
IHdpdGhvdXQgdGhlIHZhbHVlIGNsZWFybHkgc2hvd3MgdGhhdCANCj50aGVyZSB3YXMgYW4gZXhw
ZWN0YXRpb24gb2YgZGF0YSB0byBiZSBwcmludGVkLg0KPg0KPklmIHRoZSBwYXJ0aWN1bGFyIGRy
aXZlciB3YW50cyB0byB1c2UgdGhlIGJsYW5rIHZhbHVlIGFzIGEgZGVjaXNpb24gDQo+cG9pbnQg
Zm9yIHByaW50aW5nIHRoZSBsaW5lLCB0aGVuIHRoZSBkcml2ZXIgaXRzZWxmIHNob3VsZCBkZWNp
ZGUgdG8gbm90IA0KPmNhbGwgb24gdGhpcyByb3V0aW5lLCByYXRoZXIgdGhhbiB0aGlzIHJvdXRp
bmUgdHJ5aW5nIHRvIG1ha2UgdGhhdCBkYXRhIA0KPmZpbHRlcmluZyBkZWNpc2lvbiBmb3IgYWxs
IG90aGVyIGRyaXZlcnMuDQo+DQo+SWYgdGhlcmUgaXMgYSBjYWxsIGludG8gZGV2bGluayByb3V0
aW5lIHRvIHByaW50IGEgbGFiZWwgYW5kIGEgdmFsdWUsIA0KPkknZCBwcmVmZXIgZGV2bGluayB0
byBwcmludCB0aGF0IGxhYmVsIGFzIGl0IHdhcyBhc2tlZCB0bywgd2hldGhlciB0aGVyZSANCj5p
cyBhIHZhbHVlIG9yIG5vdC4NCj4NCj5zbG4NCg0KVGhhbmtzIGZvciB5b3VyIG9waW5pb24uDQoN
Ck5vIGluc2lzdGluZyBvbiB0aGF0IGJ1dCBzaG91bGQgZW1wdHkgZW50cnkgYmUgcmVhbGx5IHBy
ZXNlbnRlZCB0byB0aGUgdXNlcj8NCkVzcGVjaWFsbHkgdW5pbnRlbnRpb25hbGx5PyBBY3R1YWxs
eSBpdCdzIGV4cG9zaW5nIHNvbWUgZHJpdmVyJ3Mgc2hvcnRjb21pbmdzLg0KVGhhdCBtZWFucyB0
aGUgb3V0cHV0IHdhcyBub3QgcHJvcGVybHkgdmFsaWRhdGVkIHNvIGltaG8gdGhlcmUncyBubyBw
b2ludCBpbg0KcHJpbnRpbmcgaXQuDQoNCkV2ZW4gd2l0aCB0aGF0IGNoYW5nZSB0aGVyZSBpcyBw
b3NzaWJpbGl0eSB0byBnaXZlIHRvIHVzZXIgc29tZSBpbmZvIHRoYXQNCmdldHRpbmcgZGF0YSBm
YWlsZWQgYnkgcHJpbnRpbmcgc29tZSBpbnRlbnRpb25hbCBtZ3MgbGlrZSAnTlVMTCcgb3IgYW55
dGhpbmcNCmxpa2UgdGhhdC4gVGhhdCBzaG93cyBzb21lIGhhbmRsaW5nIGhhcHBlbmVkLCB0aGVy
ZSdzIG5vIGFueXRoaW5nIHVuZXhwZWN0ZWQNCmFuZCBkcml2ZXIgaXMgbW9yZSBlcnJvcnByb29m
Lg0KDQo+DQo+DQo+PiANCj4+Pg0KPj4+PiAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+
Pj4NCj4+Pj4gICAgICAgICAgIG5lc3QgPSBubGFfbmVzdF9zdGFydF9ub2ZsYWcocmVxLT5tc2cs
IGF0dHIpOw0KPj4+PiAtLQ0KPj4+PiAyLjQ3LjENCj4+Pj4NCj4+Pj4NCj4+IA0KDQo=


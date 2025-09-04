Return-Path: <netdev+bounces-219814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2089B431F1
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580C77C1D34
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9B0242D62;
	Thu,  4 Sep 2025 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mz0e4I97"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390B23B605
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965869; cv=fail; b=Qa+jR1hMFXpINXOLHImEm7Lmhrkj+Kv7afeq7gpNTS5hlOSRO96D0jOwsEe7c+J11yBUmblO9KoHi/8q7GrMUFNNFveKhb4shT4UHZpo3Czap+1ajQE/0JVERyXJTRBcZHwaT4s6lHGGS4+ToRNsxIV5x0KuPzBI1Dsi8OlaiXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965869; c=relaxed/simple;
	bh=4cinuLYtQpqwWQiiF3KlDebUzgx01XtG7pUuchrxk58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rMVRdS4RF572/NdxeWgkWsqROfni6wq2PyNElnsHP3Lxurd2xc9cBKDfPa1/jIHYPegcHrKX/uT+Np7S5UKQe0bq2T/W7HeYeIr3nuWgeBfJaSeUqCXwJb33R0LM4AzBBelq9sBakYJt0Pt9WWagg7Gso7754uHMAo0UyHjULyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mz0e4I97; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756965867; x=1788501867;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4cinuLYtQpqwWQiiF3KlDebUzgx01XtG7pUuchrxk58=;
  b=mz0e4I97ecajV5oPCy/56hM12ypVJAZN/tR9wQx6ojR0gzdNiikPAf0v
   6F208B7soERSy0aBWwo+ebQQI8YfRmZzGwNH2KVbepE0GUu1+QpzqlJGV
   R/18tk69f5RNjqPEExA/UHhnyynYpnzgXP0ga191GPkKZES2OVxSvDNmt
   L4I93E7A7gn3JjA8C8s3BuBZ1uoadkluEMILaDozR1ACLEWXn/MQlb8gp
   xYaNahOt99bUql5Qkn+ELoPA3cHkU7pegau53H3xo8iH17yR6XMNhWNVp
   U5l15FmthT8BTdeg+JvWAlQAl9JqcfqCR+fYjmpaeAyeQQGxhHrEPSoIC
   g==;
X-CSE-ConnectionGUID: 4Ojz/bwcTC+Yu+NaklpUBw==
X-CSE-MsgGUID: 9Ew+L9vfSS2h6kFUrk39VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59148252"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="59148252"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 23:04:26 -0700
X-CSE-ConnectionGUID: mUsWjbQvSm+7WB9gny2DEQ==
X-CSE-MsgGUID: 7UB7yVrSQCeSwNeRp6DtSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="172250950"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 23:04:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 23:04:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 23:04:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.78) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 23:04:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ffbj0vIibJ5xn0amdYOhUGMJCocEZN2K7lSG6IhroSPO4meFhOgXYDX248xE6ECQthWEDPEPQ5pI8SI95IGWDYKUXWn9JcjhRJ+H7Ty/qFNoDgIH9FmHydhK6vKwpBHsIK++47iFmz3d2q9l400c7d872pzJrn1NIBFDo+wNzd/QjNXHvBn/+Fx5pxJyjHtLD3uNhQqeeX6GRegyvaWC6xYU8/5+kzSOVGPY3avI9l5c2gMFCrQNuDnAyCmsqs13KY8Wi5JNcCFKQzf0hoVoEuv5XSNpKG1bsWagVxW/prt4VLBVINEroE5jWcBYCG5pTUSR7rCA48wbIo1WbpRs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULAzhQBesnlpYaMVhmQoUeZ99KffthWF+HBLCK4/meo=;
 b=rk9qbJPCp3tOxjmDcKpl+4m6/Kt/4Vh47jHRoNKy7ABsoAs8oq5vGIo/SPP+q7kS5WMPHQ9jEB9RsARuMfP2mzJaeZtZ7E4yVVgeN15/rWUHv+sgsN7GCfzrr/YKNcgmEUtkfIeBbSHWH5gOwF1sFIvOPqzeltp4HpnrS/GOm8icqjAB58cz43q4t08NJLWR1StJwGBEzxJPmdvkkCwLDBH7s+baCdZ+hmAEUphdMhQtbjazeqLsbo8NtpEqZzpA6uhZgyhkN28Lv+ZdETDU2F7cayFUEugGb7h5Rko0Qrx2lHg+M3XMXbsnrfBSDUakSm2IoFRR2WoTxZ+NryAR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6384.namprd11.prod.outlook.com (2603:10b6:8:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 06:04:23 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 06:04:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "przemyslawx.patynowski@intel.com" <przemyslawx.patynowski@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, "Keller,
 Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH net-next,v3,2/2] i40e: support generic devlink param
 "max_mac_per_vf"
Thread-Topic: [PATCH net-next,v3,2/2] i40e: support generic devlink param
 "max_mac_per_vf"
Thread-Index: AQHcHRvN60J8PVKri0KmI0GAbd0jGLSCiSdA
Date: Thu, 4 Sep 2025 06:04:22 +0000
Message-ID: <IA3PR11MB89862C0CB04BF30C66C7333CE500A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250903214305.57724-1-mheib@redhat.com>
 <20250903214305.57724-2-mheib@redhat.com>
In-Reply-To: <20250903214305.57724-2-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6384:EE_
x-ms-office365-filtering-correlation-id: f35b12f3-12cf-49a4-8f97-08ddeb78e517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CH92fix5VRiXcVi/oQr4NZ6oLqxRyqJHjrzHF3QMWxQKRRFeWJXjU5jIhAhE?=
 =?us-ascii?Q?s0Lc5BvjZDjNHcGBc3gHwhlDxrOLPh2yg/LeBNq1Ffi08ZUzOK3oTrLRErqk?=
 =?us-ascii?Q?es9e1xRSebuf0N9YvzrR9Zq8p+B4Q5DqXSwjOEbediAiHVNaz9kI5VwtjEYE?=
 =?us-ascii?Q?JGb3a0XY9bO/c2gD9lKbWKpInTjOFMYpTAUPydXVjmdhZQwuGnF5tG8NmDRv?=
 =?us-ascii?Q?uZzS5ZSx4oSnx26zyXXa8Qc7T6h4Ib3L5m8tyVQ0ey/5cciJmS63Q+Oei2n5?=
 =?us-ascii?Q?BY+qUnrQFa3Civ8PF2UXlOPmJ3aDRkUeZmROLur7PLdFLdx7ypS/N1LnAtCl?=
 =?us-ascii?Q?ISpJxu4tOvAfys1UvRd+s2sJYwJnWqkQ7X4nhuInJ5KTdrgJGTejmYl+RO2y?=
 =?us-ascii?Q?Rck+J9bjyRbhBXMF6wbbV6abVI36XnsPFa9zJMD+dyOfpQe3AxXF8CdjPxZg?=
 =?us-ascii?Q?MJ3wM/gcyzjrxlL/kJe+lB4pZpJG+6epOGCdaSt5p5t9CMmKcqJORRWFWw7/?=
 =?us-ascii?Q?pVniT76SJWDSQaZkhgTXcX556lJxbqZGBu8jA+a/U2WZbj40hDPLXkDIQ1fh?=
 =?us-ascii?Q?/Wtysw+vKC5lZRrf4LdNl0U8FRIKO38kwqr6LsvBZZBjZ0zw8F3LuZSgTRYO?=
 =?us-ascii?Q?aTd+8j4MgnfQKnYXy1ZmEOZgldDRfnBYbd0otxDjR85DM8N1nl1oPKFxYhj8?=
 =?us-ascii?Q?/udw1bZdje6UnRP4MnhbBoY9lZiW/00hL//McoWiEWwyZhXH/h8OayAT57lS?=
 =?us-ascii?Q?Vm8DCG7FDyQaRpKyxoP/FSdCASkE7gupsn3yOEO/x77W7eQkeYxDZ+g3KTM+?=
 =?us-ascii?Q?W2FkpHOD5uYc9iLQCwTZuUOkGaSn6zYb6R5w7yVhbHNX9Bc/4uSutBknkMeg?=
 =?us-ascii?Q?h7YoFn+zo3LN6ME6MgKoRxyUA+WpGvJ7sTkH6vuJZHK6hvZmWBAOpWttQllw?=
 =?us-ascii?Q?bxov4nah9IrcNZKdEC/1kiwhEuAR+jHCQhgqv72ECPjM1ROY+8WmGR4OOk6Y?=
 =?us-ascii?Q?3t4+XADsvBcA3WdbvuXVO+Fu7EcXLLs23Ig20oDmDIa5TmaVtasWe8Ii3Hbo?=
 =?us-ascii?Q?QDaKZSQyOng1IHnRRkNn+K0w/T3O6A4YU8Zz7yHFXWO5WeZeZcLDNCtxu0fp?=
 =?us-ascii?Q?h1fJUjtEWJ+Inj8IJnp9OhLUmn4wlYUcRKZgn/iMpIE2TFiQNPFVVGJcmQRc?=
 =?us-ascii?Q?YiChn+aDymKSMR27JmvkLa4nvQiredZaABdcM765hHSV4li/ojU1mcWq+wbi?=
 =?us-ascii?Q?m++CNqP6u+QSbOXSusC9TkmBqJB37K59ALhStYbywBruVQKQdfxJ0WHDuB8R?=
 =?us-ascii?Q?swpFqWqn9FLKGhEaZ3d5SohJDz83RsDZO+pZ2PWnFpneJCwh0CsRJpH7kF3o?=
 =?us-ascii?Q?cRi4ZgvjjMpQD6DHxMJhmG0e7TSMyhi41AF5gcP1NUEvIa8+vMeczn7BPcIY?=
 =?us-ascii?Q?fKun/IjpJBdIEhAJM7XI0tzy9FR9jsHNcdk4hCSnnnG+zfXjYQ3BQGAjVte4?=
 =?us-ascii?Q?gqzO8EA3aiv9B98=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/4t9wMVVqVeoEJXbD/pR3bSousHKn6lEVa884SZJVoPmLGy2kY3VWqGJVOao?=
 =?us-ascii?Q?Fu5I5tTzL8tLgMaJhqKmWTRLj3HdSZmi+zMkzVR3agaVFu29c7irTu6e6psE?=
 =?us-ascii?Q?iVKoQuYBh8Pw3AwOLfTbmssDeIxAf3StuKRxV+LJWhjgr+eJ1WvVgjnonsBh?=
 =?us-ascii?Q?v00ZEciQnpv3y/LBjTwIz9re0L2p2KKUEDstByMhJpEcAW7Gtj1JVw7lOrUM?=
 =?us-ascii?Q?tS9OsA4lyRkTr0o7TSCSrzO7e1RMgW+CyOonuP1u0glMk8t3tTHyxjihRSfD?=
 =?us-ascii?Q?beL1Cb2B1urNTW18xcUHDZAEAZgraKPtzAdSnlRNvWXAlgIp07wViPi+XAxl?=
 =?us-ascii?Q?jXq8NaFrKwuoLsE9UAM+72rcwMaJ2TwLZqATQyaFqaiKFr8ynm2OJ7cbkRNZ?=
 =?us-ascii?Q?FdLYfxV4eCsJNYefO+F4BrgjHC4oCS7SmzyVD/6ZpJUXFQtkMsRIA85oCeFH?=
 =?us-ascii?Q?MXQkWFso8FzzYDEn7K+HrkktB4hkdy5Vs0u8DrRMYz+MdAgWajWqGoyC7LT4?=
 =?us-ascii?Q?0FKO9iYaV+akOh1on3iRYsn+8bcsjwSQhA+YJFL/OkltYzluhjszrnhPQaZq?=
 =?us-ascii?Q?hELGDOmBvmTnhy0jQ6Jtd+HMUWc91BX0zwXqSUIaHmFDcnUlfY+koFTtSmrD?=
 =?us-ascii?Q?6rO28N3Pv+rdTuX9/O3lXOcKTHUl0VOlLeRq2bUXGHEUIGLGOGYUQtwffiay?=
 =?us-ascii?Q?T6sgaV3zPT1jukD8vitbrtwTdLaAoOCX7pQM9FibgJ3GueOwN00PPVr858To?=
 =?us-ascii?Q?LzDyi7jjWAqpUokHK8I46dfx92QXwW6dEwLZ7BloulZzSPszSiwvOpDdPxlJ?=
 =?us-ascii?Q?c2TtDCrqSp7gjKVglhHI6Cu/ZaSSQXREDKr9nxzYFMyhdM23eqQRuB2WaxrC?=
 =?us-ascii?Q?TKAKktMptAAnfgNT4pCA8CL6QtJEWISQe1WKxcqOorIIOFfspOSO4qSg2z/r?=
 =?us-ascii?Q?KmGRNIOviLHF5yqhI0hb8J9nWdV88IWPdZrQSLGfwRMmtEwa78S5Nj99YZU1?=
 =?us-ascii?Q?7WuPCcd4kbqO5nufRjrhKbpXKDPNzAjs0nofsxmEfsdsYgRj3bePI+NqWriM?=
 =?us-ascii?Q?xgnw22HMn2Wi+MGVXwRmADi4mTEPC+Hgr0ojUhES4urhkheWO5UxGowDxDF0?=
 =?us-ascii?Q?wUlpaR0UwCfyDVNBqULHyV42ab1Eh1N2+m8eui9ZNuzcJ6FlreCbP+hj8fv+?=
 =?us-ascii?Q?QzDrZG4uWCNkEORLQU51SfxRPkD1FYJEAyEem/dYw6J5lajVitRRnJRF8TQe?=
 =?us-ascii?Q?9yAJntZ9SgJzsgLnzyuFVweHv/+gqBiarhbBoKaM/IlwGJmM7j/NMp+DkZhC?=
 =?us-ascii?Q?el7LV7bOpUppgjc4rO96I1vi4DOIpNrA2VQFhnug1roEtKKKUULtvCt+xkAL?=
 =?us-ascii?Q?rjGvgfNb2ylpk8VR8oHW+P4Jg88bhegUS6Fo0tcNcMSuQ31TxzW1RY2kU9PF?=
 =?us-ascii?Q?KPbsxBu/kjPRqfUH0ZkfO+/t6IDDkPLc/Gyy7XhGp8Xi4Q25xFjB4DdLKWf/?=
 =?us-ascii?Q?nMv86zfO2KN1MShWfwXQ2SovQGjFtvtMOmJEEdPKYXS/VJndQr05DMwERLhb?=
 =?us-ascii?Q?PljGjIwhCyQix0aXK9JFkr0MxMfCqZgVCKfcJP/Otgxp0EB4xqEjnbByq09B?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35b12f3-12cf-49a4-8f97-08ddeb78e517
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 06:04:22.8029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptB+gYYeHs7VpNJjelfPkvGoMd4mObiJP7AR7wkdbXiLsx/rlV/GBTk6wb6XWbSPjSVQEW7VOOXy7vdqsTojX9ai/6wqLXruZNzmLpULj4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6384
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: mheib@redhat.com <mheib@redhat.com>
> Sent: Wednesday, September 3, 2025 11:43 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: przemyslawx.patynowski@intel.com; jiri@resnulli.us;
> netdev@vger.kernel.org; horms@kernel.org; Keller, Jacob E
> <jacob.e.keller@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Mohammad Heib <mheib@redhat.com>
> Subject: [PATCH net-next,v3,2/2] i40e: support generic devlink param
> "max_mac_per_vf"
>=20
> From: Mohammad Heib <mheib@redhat.com>
>=20
> Currently the i40e driver enforces its own internally calculated per-
> VF MAC filter limit, derived from the number of allocated VFs and
> available hardware resources. This limit is not configurable by the
> administrator, which makes it difficult to control how many MAC
> addresses each VF may use.
>=20
> This patch adds support for the new generic devlink runtime parameter
> "max_mac_per_vf" which provides administrators with a way to cap the
> number of MAC addresses a VF can use:
>=20
> - When the parameter is set to 0 (default), the driver continues to
> use
>   its internally calculated limit.
>=20
> - When set to a non-zero value, the driver applies this value as a
> strict
>   cap for VFs, overriding the internal calculation.
>=20
> Important notes:
>=20
> - The configured value is a theoretical maximum. Hardware limits may
>   still prevent additional MAC addresses from being added, even if the
>   parameter allows it.
>=20
> - Since MAC filters are a shared hardware resource across all VFs,
>   setting a high value may cause resource contention and starve other
>   VFs.
>=20
> - This change gives administrators predictable and flexible control
> over
>   VF resource allocation, while still respecting hardware limitations.
>=20
> - Previous discussion about this change:
>   https://lore.kernel.org/netdev/20250805134042.2604897-2-
> dhill@redhat.com
>   https://lore.kernel.org/netdev/20250823094952.182181-1-
> mheib@redhat.com
>=20
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


> ---
...
> --
> 2.50.1



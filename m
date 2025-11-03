Return-Path: <netdev+bounces-235161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58584C2CDCC
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67021188E70A
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2254261B70;
	Mon,  3 Nov 2025 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEB335b9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573082AF1D
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183670; cv=fail; b=dEGxE4ww04BdEEPyaZiHv58AzHNS+NhKq2lcUsZcvbGpQDFZP1y8RSjB6O9wshLlw3uZT6M3mMQbCevkF9cYMtFc5FsBVVhsaNquJJgrg9x6B6igmlW9fJnk4tnCh5xBNL3p2J8cOQiMJasdOCsi2nZAETFgUbo44zmeXwG6O0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183670; c=relaxed/simple;
	bh=2Qlg5mvVMp9G64J+34CjNOQRvWNmyNYy35vrvVxt540=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KP8ZYT1n7SIRhDem7zXYClpQ5Dm+MaNydqFoozVEv2er8EmtGFKsIcIhxMvBupXxua4qciElgFpvERwa3TwnM108dCIue3E06XEAq1RjGyJomK6SEdsqZM3aF7d8s+cmZ4gUTPy9WJY2tEm9GwuCje40bY+EZ4UHZzbcQWuutJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEB335b9; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762183669; x=1793719669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Qlg5mvVMp9G64J+34CjNOQRvWNmyNYy35vrvVxt540=;
  b=JEB335b9aIq6VEfnrkXB9QvJbefgVeDNU+XuHB+vdRBHtt9FB6RVGk+g
   Y3hmnP+liqclQMyCVYsllWDP30UqHuMXh4yuuBihFB+BYL3uPqPiTXpFH
   zXZHB+mJ1ME04kZygowtgUYdddqkIb2XGfOAsXixg1kz/fFRu1FBliPD1
   JvpVZ3NbEAvW7ql0BRXs+DbO6HMHNDAaWHEknxDKVPH2A/b8X6YLrBkZ6
   8Zw32kPXVbB4R52wg+Ubs8mbLofVQoK9xOOTcb/ihKptotjtJETqkJlk3
   ULRaZCkxElh7GTwj+dXXxCk8i6a4IdMmo9FKfcg6i2iqyf8vtP1RAyiPq
   Q==;
X-CSE-ConnectionGUID: OsAT7AQuS0iNY/7N6FYwKw==
X-CSE-MsgGUID: a+u/3iBhREaM4WhRkJkhHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="74938333"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="74938333"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:27:49 -0800
X-CSE-ConnectionGUID: M3MQLhZQQi62CMjUk8cNVA==
X-CSE-MsgGUID: pqrXdiRUTFClpr6HvHBAMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="187040186"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:27:49 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:27:48 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 07:27:48 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:27:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIXTO1w0ak1HIMup+5YwhiiCKPYl+QlS0gXjPUfbNAoYDaeR88Q/m8Qp/DqiLjYxjuR2iEAwMC2WnyX31UUEX4mvuwrgoPj3qEkx0xug0TOFoHzRb7L517SZCidcKjjNvBW9jUgY1VtrNhyxW3+BLxilpix45862DWMD9g3m18k27kDXH7KNgYnKJpb/iKq1aaHC9cS0CQh8YsQhiBnmE1C0PikZj+aw17PVI5+ss5hwFr12i+6ZPMrbU+d9C9Im+mLiSRWON+3DkreXt5GPReVTTrukZ1z68c80oN6PBP7SdoSeotDN2kCdb0dw+Y2Mn6mz89j4ROedXXd4yJyGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Qlg5mvVMp9G64J+34CjNOQRvWNmyNYy35vrvVxt540=;
 b=Me24tyJsxC0EpUIUkRaseuyF/Ye5lfcHlYTyn68jgh7BH402w8Cw4yIg0i2FzY9MZ0X4C7lYBFzrY9uJU7PbywlCbRbMST6VUH7ZsYzcTZj6MkWjbg6+DpvvgdYZJdDQNFD7H4FNTSIcwtvcE09TQdDES/h5/kUAyQN1mc+4qymfTffA0U6NDGcKV3FSmmGc6abGU0nTc7hHGxif1/P898BzlvoiEkFlVwe9OT0twoS3eBrvSGRmMG4BJvW/fvGNAOaNAsvLfN6Q6Eqp9M9DkV+quuUn02KiNDwodXJ41xXTXst47jghUzBI/J+mzQAq1DIn275XAcLQjnwj0D9N7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SN7PR11MB7114.namprd11.prod.outlook.com (2603:10b6:806:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:27:41 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:27:41 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 03/10] idpf: move queue
 resources to idpf_q_vec_rsrc structure
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 03/10] idpf: move queue
 resources to idpf_q_vec_rsrc structure
Thread-Index: AQHcQ2uhhIaZzFdQlEyf/aKE1HpU17ThJLNQ
Date: Mon, 3 Nov 2025 15:27:41 +0000
Message-ID: <SJ1PR11MB62972E736640D800C60CE1499BC7A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251021233056.1320108-1-joshua.a.hay@intel.com>
 <20251021233056.1320108-4-joshua.a.hay@intel.com>
In-Reply-To: <20251021233056.1320108-4-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SN7PR11MB7114:EE_
x-ms-office365-filtering-correlation-id: 99f1c630-ec2e-45a2-6240-08de1aed877f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?To24FMtfX5lFCckRPOzHqeS6haKA3lrecyGcFOYdfcngCDkv+fb/axZjth7X?=
 =?us-ascii?Q?O9+Gqhn1VJj9zRKqtsCAquz9Nti7yDWLa6u2It98qbtBa7uyjd7ONh+i8lfN?=
 =?us-ascii?Q?dRxWHslA4L6RWlK6ZiI9bCJI+hagJSouNBHxNy4XVJaJr2pbvuKwpm9deUiI?=
 =?us-ascii?Q?tXWdUOK7i30xFQqgPxxujnL7D9pgqpYHmxbIwnuF+m+VQfuBclQNxsLQ/rlY?=
 =?us-ascii?Q?mb4yxdOC4Op4AwznSvd1hO4IKXktDG0k4D1y5Qud7ML2WgghjQabE+VkjhnC?=
 =?us-ascii?Q?cgW9WU7ZVcV1nRJJTLTCeKOZNczKq85LBkjh58B40NYoDS3LiH7XhKrY3k1r?=
 =?us-ascii?Q?d+5lMMEsZBQ5Jp3U65YASI7a0FH4bXchAoakp8m6i4lBBPd9q6gvss8WLO07?=
 =?us-ascii?Q?Xm9VrKcZC7c1GIy9ndsIOL6eeT1GBU1OnrCEdzKwGDPnCD5WuEKZjOKgNKtQ?=
 =?us-ascii?Q?6NLLYmtNUNsKZI0xxgjW4JGpGE4BW1v11pxDMUQTKaGL3WJvzYA3wwDFzyNn?=
 =?us-ascii?Q?qQFocbzKmkojRiK42GYHV8zn0JIjDC1UtgUh0SGW4khf/N57RRvMVzLz4no0?=
 =?us-ascii?Q?kmxc6Hwl0RfwEULIvNiY522Zzwjl/akwaqqAA7jd+6zCFA26yIpu5GpwIJmI?=
 =?us-ascii?Q?+6CZtPSSizGu7uFXAtIptTfGH2gVET8u9Ro2I7q74qhP+14DVrxErBdMPQZI?=
 =?us-ascii?Q?/X5lmpO3godSGNQgrxvCo7tycD5mdJOwhku1+z9eXJoXODvCNkWwXr91ygdo?=
 =?us-ascii?Q?YkZAiYb87VVcdqxNh8iq2s9FPrLh6xSDHXWnrL5iT9PYTTC5zXRKaO8rkIGT?=
 =?us-ascii?Q?UaGflSYMFYcfOJW2ls4JAjFtKDpJyWsTh5V5jl6ZJJ2XRbhKMWmNPnVxSlgg?=
 =?us-ascii?Q?uKZ1zKEeV/mRUnIOETmcDxTNDIauVHVXEhZSVkdLXaTu60wkXRcggldf/BCr?=
 =?us-ascii?Q?dk5qrimQqjmrLO0VRI9Wx2CiUtDM80cyRJ6OCeJyzduZ70pI7yTFupWLfXP5?=
 =?us-ascii?Q?hun8dudVgpQwSRoazxc8ncpGFTfawqxuFCh7+9n/l5T1W4sN9N+UI7XAirK/?=
 =?us-ascii?Q?iRz2YKVOQhG+K5cszMJwf6F84F5+iMVUBF4uFJhezag9Ei/4QqyT4y42lHcL?=
 =?us-ascii?Q?trKHxkGXptc25+vX/4bwKqk2Cs9QpwVbw+DPeC93LzxaZdD9JvPWVRlB+86u?=
 =?us-ascii?Q?y3IO4KOqTvh9V0OaVUyeHEWjy8MMJoeASjO+pwDAhQJgQ1Tbub+Z05Z9lM8P?=
 =?us-ascii?Q?l4eeunepEtq1JTpJizbwVQHA2XWqgjwmHk8GdYOpF4yGGOzobvTP1lr2oV+X?=
 =?us-ascii?Q?IkhVt1L9UugL7oWe5yx6KT3BKjbYrWjriMWRuogtIcpPvAb9olcXSp5Sb5eC?=
 =?us-ascii?Q?1HRMBaFpniCx2NvPMrjlrv5X6HOZBPgQtm6acgmfnG+Oah7Q0ymfkcZ/+erJ?=
 =?us-ascii?Q?2pBjH7MA0Eg1ZO7VUnzF4qGuXnp+qQmwi6wawhjUJbfrHUkn4rLzU9gRBHwu?=
 =?us-ascii?Q?iDkgSwq3U8LX4WMBwWE6xqAQfrEpk2DI6Ual?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZG07OoHuvyJCPeg+yVE1Wny/LwXBQ1dMl+4F/bYY57LIkpkX1cZ3Bpe2rAVM?=
 =?us-ascii?Q?lvLHHLbGE4euwxoGuQQ82qC+2hUjQVDSJEXTWtFq2l9NXZ5Od6Bl9YbKmt8L?=
 =?us-ascii?Q?qTPzKLgI+0bh6fa6bj7kJXuS4Kl+bFlnSuNeXyAA6bGJWwT4uBbyZCunsAS5?=
 =?us-ascii?Q?ABOygujX7SUigRRX8rPTOqlzhDFiY39M5AdPPvtciTeLZp9VzEqF2mQVTSuR?=
 =?us-ascii?Q?sFz6f7pAt2P+EFso5U17ZBkPNfZlxLe1pvUd+Rh/IOofpnU8yi6pVTbapXdi?=
 =?us-ascii?Q?8NFxlJXXwPf4L4ORtcsmpRHI9L6wC5pyXMNenLcHcoKYE+raWGRiim92IzSV?=
 =?us-ascii?Q?wxGM2zV4c1oO7sQeHHEIsTfolVjuTcGgjV15ULEbzzXAlPtXdE/nv4MtexjJ?=
 =?us-ascii?Q?DE9zv1yqHiWfvyjvq2Avw7G/rv1dm1p/lz1LA3KNjAtDFZVaQRrCqzDhscpn?=
 =?us-ascii?Q?LRo66gFfOfuM0Lofegqf+0PPuiiJvDbOkHvBqTa61SMtW3WblpNUwOPg/W9S?=
 =?us-ascii?Q?gKzwsBk6MBDTk5U1z2iWAlxRYGVZWfkLwM1VPGHOmh5iEmst8+qutcrl+HZi?=
 =?us-ascii?Q?fj4XxrbB9J761lVvdy1U0U4jHRoW5fu+EsoIM1dhxAWzc8D38SEg3sKR5Q5j?=
 =?us-ascii?Q?KjyIQHWTuV0aaKf6Azdpz4nMUcL27JeiwUEcM1LKgM5nuRxJmrqq1AuvYPg0?=
 =?us-ascii?Q?wmzqWa60LPfyLEOZMZQxuueEG0OggRePBhgdqI+Jj87uVjPZBl/DWQX3ujos?=
 =?us-ascii?Q?If1Xs+DUneV32e9U/VRcfTgMCXO0A5MwwwaiB8dDzeG1xO/bq5H1rSRL87FL?=
 =?us-ascii?Q?yH+gJ/As3pLXZl8ogKPVnjCw176ovvZEFfANDICay5q9qYuM5JKV3f3IFLeE?=
 =?us-ascii?Q?VlWm2vB5cddH3jMFP1a26lh+otgK7uVsvi4CnwjFuxZtrwtutspZgdq0LBsj?=
 =?us-ascii?Q?5DTKO4XqtOps9pPGnsOjrzeiY/BXCetKEDMJxYgStoAdnItTwTA77GXn5MOS?=
 =?us-ascii?Q?zSklyeAUzdqvw6D9tTfXRQoQJTEnwM5zV502KZJrMA2sXW5UtfQkjFjmnKlU?=
 =?us-ascii?Q?Wt5DCgJWpZulDAZz+4R1qKl9aVfxWo4V3fbA+hVtKz1FeH4GFpppMBjhfE3P?=
 =?us-ascii?Q?mb/g6QsggGf+oezFtX9ZqqZRdHIaAS4xqgRQNEQFOJhAGAK6/ANEH1bCKtU9?=
 =?us-ascii?Q?qJASVou1BoP2isdG5klju38cs84qge0OG0gxY6WoyFar50wx9lxo9gVLCbpU?=
 =?us-ascii?Q?m4y4Z8LCgmUEwEG1g1kuqYpOnKTyqy8ZtgXfX2lFjtOb0pGGVChwOp2YRb5Q?=
 =?us-ascii?Q?0bV3HSw+4F/lqlzf6AwYNqrDBpcSCFYZ/Hhw+gfHc1OD8yFMCSnqstp8KeWF?=
 =?us-ascii?Q?W6nCl1HjG+yERrFQt1uAu2NMS4/7zDyEwHazTUSMFLwNb+LotLgjOtVqH707?=
 =?us-ascii?Q?7JJTC40NvE/Qfv3sC+rKcSBuYjjPBSr2xTOVLCHzIAD4QupqApjljR+6bzKX?=
 =?us-ascii?Q?u7z8419yRiy9Atd1ed6WUCHqH5nIPkYtcjUqWoviMmfnPDGdUPDtrW/ezTgC?=
 =?us-ascii?Q?xEGojs7t2+sOpkQXek5Uocf61g4LBFkbmMUQFRkQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f1c630-ec2e-45a2-6240-08de1aed877f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:27:41.5497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JJODphyY4Sw6tAS/Oq4YQRjnQQSfitO3Bl6WAJoR7ScgU7Jru/lUiNtcW3/NoPZ3XK/BkXefbZwzOL1o+pfFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7114
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Joshua Hay
> Sent: Tuesday, October 21, 2025 4:31 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v9 03/10] idpf: move queue
> resources to idpf_q_vec_rsrc structure
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> Move both TX and RX queue resources to the newly introduced
> idpf_q_vec_rsrc structure.
>=20
> Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
> v9: move iterator declaration changes to commit after this
> v8:
> - rebase on AF_XDP series
> - remove dev param from_rx_desc_rel and access through q_vector
> - introduce per queue rsc flag to avoid vport check
> ---
> 2.39.2

Tested-by: Samuel Salin <Samuel.salin@intel.com>



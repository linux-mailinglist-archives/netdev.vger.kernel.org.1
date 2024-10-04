Return-Path: <netdev+bounces-132106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C4990719
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DD728C7C7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5321AA791;
	Fri,  4 Oct 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDH+X82V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA791487F6
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054310; cv=fail; b=RJhIaVho3sTSsBHJup7ox6j8rDQdnF2ahoEWRPuD9ap7ak8Vf020SxP+dLQ4bU1t5JA7Av8o/V50vod8zW4/VMa7C87XiQqGjRAmrAUrIymEwVXbZaiTli2gHL30vZPrXdao3epdrFe2efEbC944ehczt2zvCCl3derLxUNql4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054310; c=relaxed/simple;
	bh=FMMG2rzMQmHYqA9LFLTtIqLgHLMq7J8Jtm48M9DjNUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bbo3snF/z94zqg8lrvtAkO2Q0doZVhoJnFkOZL/JXcwu6Pbgq8a1kAoCiXt+dgW6S2s2Ph8bPVs+zyLl0fgYB0SxLS4zS/l9n/00d2R4W1o74kXDICgRfE+y4Q4f/PVufVXPZUrLoTgBqujLBpfopBfqnbVNgwr2cNWKoQMPi0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDH+X82V; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728054309; x=1759590309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FMMG2rzMQmHYqA9LFLTtIqLgHLMq7J8Jtm48M9DjNUs=;
  b=XDH+X82VKzA2DA8De0ThJdKcQw5UKwfCZE2iXBjEGWiGSw0ZjSuB1QVm
   yj+vmCz5mg8Hg21Mcbk0MdtlpFAGVdVvHEBIhGLYzpTNFPBmTG3IxWVOk
   pXXkYl/bO2NSGUJZ43aFwJNvBxDz3ikY1WmR2Ell2HEdpCQ0tp91RN+5D
   lJTQwZD92aBmZSjNOUY99GgP6QWy6cY/K+cuLQD1IUPmO7l23R0kLKLpe
   9sZumqpc2UXnT1Lxd8BtEtjG7kF8eiqmzlxvvT/d6hCNCUO0uIKI6hp3/
   5W20xxRrzgWbdITnugb6pPJRUAqqYR2JkkvCrfSPaDyWtdCAwlX7PazAa
   g==;
X-CSE-ConnectionGUID: MRuMl3/VTYiWdn70RsTBLg==
X-CSE-MsgGUID: cgmjl4+eT8iTqsbjdqowBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="26747757"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="26747757"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 08:05:08 -0700
X-CSE-ConnectionGUID: ZMFGSsquSSernZfnVvCLpw==
X-CSE-MsgGUID: Gret1uuRRBGebCRu8zLiUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74722410"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 08:05:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 08:05:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 08:05:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 08:05:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 08:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoFZ8hn7BEKKzWzkaWLXeOBC8FFmNGBT3N3BZUD8reKxKArd/TvKQ/3FgEFXqfhHAuRmqD/bIHY0/MRw8tSV3bX3MALpRnwPlPGIeox00WWXY+yKIj+SyMbHVUrtwU50HdtHItMPJZQ/SeNpnFCMuCmvzDqqq9qEHu87fn4T6Pwwe6uIm5Xd/nZAp7sKmgchKa9zrP529nxDZNwBqqXe+T2lPWiF2MwmdlroQOlDv6NlJ087Qhxhy7iFn75awxB5hEQ1q1PQgdX09WWJdpEgPAj+QIQmJWGbhDEEyZK0v5MA5Y5trea3lOzFB+P2ovW4aLZMHhGucUeNwQ1Sq+5X9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb0GzUZecrbGy9zLJMUNZpqAInVtyQfyTIpIDWHwmFc=;
 b=YsayasYu8zds61plZcQYO/KW//hfM0KJwarKjIZHBR+jGMgSdJGNMnYaAmgYpc7aNZJhv7HjGqisI4Q4c5jcIppdiiO17PynHJbIVbbdDnq6oaMZrGoU1I4IK/w8b5+LA26bbmtC5LdKchCGktpzW2StYpPOPebNnHd9rxm05+gbKxTJiZMaNBuWHfHN9XyeavN/QV0jNplf7Het9g0dlgExFzZ3J9fLXuKgl9Kel6+hxzK4nlsOaStctcU7GMwZIXMT/+q4sOLaY/i7QCNz7PfTa3gj6/cpTWDOqU0wOWHGGIdrTZnRhOnSY/7nDa03k8o8Xhk362OYFsNvSVDLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:05:03 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 15:05:03 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v12 iwl-next 4/7] ice: Process TSYN IRQ
 in a separate function
Thread-Topic: [Intel-wired-lan] [PATCH v12 iwl-next 4/7] ice: Process TSYN IRQ
 in a separate function
Thread-Index: AQHbEzKl+c/ldO00E06ccNmGidMipLJ2tQkg
Date: Fri, 4 Oct 2024 15:05:03 +0000
Message-ID: <CYYPR11MB8429BA6726B0EA1DCD8BC23DBD722@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240930121610.679430-9-karol.kolacinski@intel.com>
 <20240930121610.679430-13-karol.kolacinski@intel.com>
In-Reply-To: <20240930121610.679430-13-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|LV8PR11MB8771:EE_
x-ms-office365-filtering-correlation-id: 818a87a4-69e3-4566-1408-08dce485ed01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OM9U2fvGtuVuZIHCKws+O0mkWihgN0RYYZy4IeWaTgA2yEKR8Q+dn3WzZFOX?=
 =?us-ascii?Q?UidYTXfC4P322CqKLdLPbzVgHtT924rutHt4nppCKPO/ls5k4RvPx/odDajo?=
 =?us-ascii?Q?g/CrBbfbTyXFCpwVbJALJynQiRlCZB/WZ1rhmxdLQ/u1ZF8l34cmNAdb3w8D?=
 =?us-ascii?Q?4Su4rJ7pYaEMfWQqyTcIHO7ntIvlcmhX3sNGHDHSzPUGpG2eB9SODJyFYfbQ?=
 =?us-ascii?Q?eeHQmNWiFdqkEQRDkhQLuNAZ8PNbykdkqPW7E1hfi5zV605RXx8EDm9tOMDt?=
 =?us-ascii?Q?7mfO2ao6Mz1oiS2Z+77S1Jm4b+kqSFB0Qbt8tJKdmyrfMvdntMRzIaZcRU3G?=
 =?us-ascii?Q?rbaZKfJorP4YuPiDWchGqhlsgSY5L+NLaXKMNI1BFP9dwqhyQKrjHnNaaFAp?=
 =?us-ascii?Q?8OHIsb97lDeKGAKz1FVaz8bnB2bjus9YaRwmmIkGvots8VOvUAa0wRk5gOaK?=
 =?us-ascii?Q?MaE87Ya6hGPiVJ0g4JpdokImRxqcwoBibU7opjQvwr0QWzi+m3v3HIoOLVbK?=
 =?us-ascii?Q?VHKsOScJkSGaKKwVj+pHbxg0Vng1xuExJKDim2OU0jKDm/Kwe81Ngc9q0eoB?=
 =?us-ascii?Q?pTTWjepwN/7ft56W4pgqExWZ4pFdQCrRZKijF68v0nd/TyRosAq66RKipeqS?=
 =?us-ascii?Q?lDdwH4p62YzsPr4UJDIO69vo1xEetgkRz9tgdo1+0iaa1yy6T9HcrhX8A7dv?=
 =?us-ascii?Q?Wr4gsCi+0mFBTGeciSDaffgwWTo0Ta+Ebzn+voQqOKilhRsky3RUDMgWxIeH?=
 =?us-ascii?Q?w4jc5hyfN5poqdK5z/Nsc686Jy+5sfN57wUsQ/yM7JPbToYXYTmLXwpiDGgE?=
 =?us-ascii?Q?Hq83HtxGfsqA5uAiNv4u3HNH2q/YJfRt8waY/d1MHreA0UfBKIunFpo1zhhX?=
 =?us-ascii?Q?rll443RHl2NwWH559AWzctJ/PF59pM9MpMbxOQG6m6Z3Aypv1HfajtjGmnTU?=
 =?us-ascii?Q?CUnqOq54VfoJboDYWGSzQqFrD18jCF98WRuM++GLOKeQEj9R0edesiYLhZ2X?=
 =?us-ascii?Q?eNqfXw77yL8KcLz3F5gvmAL8NlM+r0qtOONH7/fFJElceFR0qdiMxfHXoCCz?=
 =?us-ascii?Q?4ykXuW3cOjRa8MEsoH/ihC1wWpomI5wTMk4otftefPeonGElJRlxlzOcXFlP?=
 =?us-ascii?Q?/jwMfB8Q4H98zGbIUk2XBjkdkhnfABrEuNw6noHC+VET86ZIy9XRO/E7B4jW?=
 =?us-ascii?Q?8O0f2mfo0sE5JTy3Xwkfw0fUzpwdleqfe92JT3LDWsWCSXIxBt6QTYVC57nY?=
 =?us-ascii?Q?cYEPi9c/GAjOy6kxEact3qkZRcMsCNoaSUrbDxBZyITDS5Rg0o2+flUY1rPj?=
 =?us-ascii?Q?6WCL8TxnjAD8I6fMeRbFS2VgddHNJ7mpejgOovuxRkeR1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uEV5MM2KXtcpSynS0IARYZrHY0oRtOcmHaP4dOJskjQyqlL/oVHApWhZ8Yk/?=
 =?us-ascii?Q?EE6jnAZBWfM5Bec5XK5UCI88k0fgxbfvcfv0hvxXalIWIRxoPbHY58SlLzOa?=
 =?us-ascii?Q?FlOqxGoS2jAxTVqTrKjMOZeMs1iGinnHtUp1okOJ+psUeknLarfypN7mxsQz?=
 =?us-ascii?Q?ncFTCTYdMYWsIoRy0QXR3iGV8MH5tbPXfxtehxCdHRz/ngQiyLojSey56HpE?=
 =?us-ascii?Q?5Z9iLYsNoKVMfAErT4V6/Nf2e7Hl8m6Cr/MQunOYqyCoernLqBlOV+pgSrLD?=
 =?us-ascii?Q?xuR6sAeFVXxV2glmWLQgxGN27pO4WEJnFoMWIMCnHW9623jcqGdt2lnVseZC?=
 =?us-ascii?Q?4qxreJ1/5F+dUg4qjYoeHYtd0pOjGCCopsqtiX0u076WWg1RKtoZ25jkkEXs?=
 =?us-ascii?Q?A9LyRt7pxL//DERB5LxhX6PehmGIfbG5MaJmV1mpFRyQ6vTBiBvMCgdw5Ull?=
 =?us-ascii?Q?GpuffZnEY/OcQplm00YOJxnEVIiglJuHrAZPkyPpiVSSEspQkD3M0ZjIrkCR?=
 =?us-ascii?Q?KVGK2eAdRzC7/ylljA3x+1IpS+Rnqe8hREn/RZGOMoj18IsmvswRv6/pIhN+?=
 =?us-ascii?Q?P176IZgdPqXtKQZ3s3QIbd7w48OuXH1SLTuaUVpNypk1sMqSG8JPuwQNHdK+?=
 =?us-ascii?Q?9VY+AhHIe711fUiXa9rDb9MBAG6trNbtqH/+TGn5g0VBAD+zKwHidiXUoPr+?=
 =?us-ascii?Q?CYWmNVeat/Fs91Ec/CtE99RtZEPnijwFFxUlhkFFiPeor5VhfQrueHZL0psE?=
 =?us-ascii?Q?UmftK4uFGhDa0hOuIv7BT74dq5TkS3KOjhGNHjo5lC9REk3fBaca6NGqgFBx?=
 =?us-ascii?Q?2NG0CFOuBsNaDG+vryZ7c0EPT2MN7thmyCS99vcPaHv0y0oqrS3BpAKVqVHX?=
 =?us-ascii?Q?7KVuvu7NYICJ+STvjQw9XLItyi43IS6+48UV0NiTD7312eqv2F+rTYEr5htC?=
 =?us-ascii?Q?Cp0qwcirIWkph1delkq3tEvLfNtvRivD2UlpE3jap85Qio/nGlgvmapZ0/0f?=
 =?us-ascii?Q?omt3wy0KxkqrLcmAOlPTH9dzmSeNsEaGrN+7vuC0G7Z1y0ErwG/TN5Acmi7T?=
 =?us-ascii?Q?uTTVKnxLGRFGF41ocVjKd77Fb7DPkhwGD93o7OixWYZPGpCBEswJp3uA9Efy?=
 =?us-ascii?Q?Shct+yakY7fdYfJdypzoynH4BYZZX65nFIeuIbH9J7oiMc+hC5A2JrHUT1SA?=
 =?us-ascii?Q?deI4EZRGezX6bsPEikV2hi/dzbTupLiNhKtfwWRn1fNv4OmBBfFSSMAUKbdz?=
 =?us-ascii?Q?5RNGsAfOHjc+wFpJo70Bp40GYWjlIh/fganFZTjqHeToqdhY5YZTEBxuDExF?=
 =?us-ascii?Q?GuCY+Ge8Jvje121oj7z3ssNbU+Yoc0ItQc1lFwP/9vNLP+HXNSnEXbak/F4k?=
 =?us-ascii?Q?SYjgvC+DKWkjtH1HxJ1Tqd9G/Pkls+or9bUuY1HAVwj+FQq9K86oWjnWUPPp?=
 =?us-ascii?Q?+oaxrsz5uvjUBn/VlgsjoEsQ/LCfuy51fHP0zznEQ6u0eSLMHDLBo9+y6nyO?=
 =?us-ascii?Q?7rxrbtKBUxFH/TPEzBPvvjUXghAp8WMYv52iYD3wAQnMpXhM6xRBLe94Oq4L?=
 =?us-ascii?Q?7gq25RAHyEZ5jiKlT48mEaAIoWY/pZOt3N92mqYDBPU5DP5uoqYFUgRXWeyc?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818a87a4-69e3-4566-1408-08dce485ed01
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 15:05:03.7421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ds4nyPFJhK4osibLXfRkcKXMKJ8ZdPaGgTCZ/xUSQUMnkiCU/pYlqqHG1ht29ezOXV11UpxGboo4BBYgoom9toMvjg4HjRO25TNmZ+xokk6jujHMAxmY2YrDF2LqLYsv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Monday, September 30, 2024 5:43 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kolacinski, Karol <karol.kolacinski@intel.com=
>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <prz=
emyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH v12 iwl-next 4/7] ice: Process TSYN IRQ=
 in a separate function
>
> Simplify TSYN IRQ processing by moving it to a separate function and havi=
ng appropriate behavior per PHY model, instead of multiple conditions not r=
elated to HW, but to specific timestamping modes.
>
> When PTP is not enabled in the kernel, don't process timestamps and retur=
n IRQ_HANDLED.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V7 -> V8: Moved E830 timestamp handling to "ice: Implement PTP support fo=
r E830
>          devices"
>
>  drivers/net/ethernet/intel/ice/ice_main.c | 18 +--------  drivers/net/et=
hernet/intel/ice/ice_ptp.c  | 49 +++++++++++++++++++++++  drivers/net/ether=
net/intel/ice/ice_ptp.h  |  6 +++
>  3 files changed, 57 insertions(+), 16 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


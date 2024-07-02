Return-Path: <netdev+bounces-108421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AFC923C20
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B528128235F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5120715A849;
	Tue,  2 Jul 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMYjOV5W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E725D15956E;
	Tue,  2 Jul 2024 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918657; cv=fail; b=I7hrunJkF0bIxqMDn99ElCiRd5iVtuTGWMlNGg8zsOGe7cztihuVpw9Klu5ks1ws9xFm1MswUVxwpue1AFZ2B68TY8l+VLqUHLylH6vKcRZ4lVPPfvXLjL3dnofKJb8nYU13pbBWDhV/GVk8C6wmcq/naC3sHQemGiSeKGuD1mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918657; c=relaxed/simple;
	bh=Nk438hS1iRKgRD3Y2ZKU3Z01pcHfz3uMznqymxP5eV4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jth20YRWFXIN9JE7YSeRhoeosFap21XaATisa80LrcGqT6W7xTIxoKOxw3Sf/vMKeLl/+BoCiDFlItJYcAToIxNKykVzZULxyNKwHiMfAwxxgrRgi22sZ2xuIRGiBIxIdaYqZJ+u0PzvT2h711i8RuWxB8UAVvxbQQQmYFlyI+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMYjOV5W; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719918655; x=1751454655;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Nk438hS1iRKgRD3Y2ZKU3Z01pcHfz3uMznqymxP5eV4=;
  b=ZMYjOV5WDj1Ek6h6VFxO83Mhp3qZs6qXZWGr/JsO5sPOmmuMlXUhGbjo
   qZVRJuaA0UVKlS7Q4N+2YUHD+L1PEUYij6qMEWyTs7pktdM20B/kNW8rM
   TVm4yT1kURSe1YDS/tbYp/8b+vViiLYGYijhp+PEs5XuxTzCTDLGfkDAM
   L5qgJ6PJrUdXVJjJGyV7p4Ln2QdFG6HqkvN1UZkSYijvyPpcGf1YzvLyG
   0aiADbEnDqgDjyr2zPkOQR0+164JJx/TBV0uNhgHais+9/h1CKWhjp2ad
   mFVXEvvO2WBTt8rhaOxrsDbsZk3QSPi+atWNIOqkA5/DEJMFkDmEKvjrP
   w==;
X-CSE-ConnectionGUID: N+jJ9CYgSnK0WN0BbCeSQg==
X-CSE-MsgGUID: yffUu8daRuuaHikVNgdK1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16964599"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16964599"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 04:10:54 -0700
X-CSE-ConnectionGUID: OGriWzz9R8u4tKG1bcPHJw==
X-CSE-MsgGUID: DMBuMDa8RfGV63bFgfd6pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45843660"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 04:10:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 04:10:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 04:10:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 04:10:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjfAm41jm8s/l32ydfWl6G55PyKfmQWlfVvnTDJgSC5CIWnbQq9kJM3n5KYZ6gJBRCg7g5t5uYyZFMoTaoYrOq8UygzGCxHyXSWukkHICYdlSehX395mqfvPT4pMNwJePtODIn9wkPGlzWmzrzcMXY3vquTv5n3ouZVkgdeDml3+tZgaI9SmLfwflOYeir39Vx7Lr/CoYAdWNUG4zOxDuhxeo7Cnu4Ow0VkjglAxyOoNAc1mBWE3eI9su3MuWVcfyCayik8N4Sw84JZOKHwpawJ3Qwx2fwRMJmoJ7/VNZc0Phwj5NYPBSuJMwIbzsbXOH94VsYoAfMjvn4MHtRbQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9LQ87xfn9QauM3pyX4al0NmAecNhf0Q7LYnQ4wRoBo=;
 b=TRcs+eyzXJbDncUopy1HL9fnEvOOWhOY2uVfhkO5T6aW3iHePY6Qpu8IfThGc5H8PxFWPR4gTpCRDPp/XX7D5o+o3dKu8glLPwvnoeqZFTEXCeAney34bVgwUw6a0He5Nqa77FOFDD33yyuIvI6BRngbKCH+DJvDX7DnaeYffmszTfYeCPZDwV0JSx3qeJZJ692NApu3dA+8O0j7KqZfUL+CSyWaIVazB6bqlPDbXemMAgdque3jYX/ZZRL268M/Gpb4glmRXP1cRgH0czuTnj4eiVfMKUlgZ6N64CcKBSxHZAfjiCodNM54lowwIsGgZr0io9qIrp0I09zVgUdliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 11:10:50 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Tue, 2 Jul 2024
 11:10:50 +0000
Date: Tue, 2 Jul 2024 13:10:37 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: =?iso-8859-1?Q?Adri=E1n?= Moreno <amorenoz@redhat.com>
CC: <netdev@vger.kernel.org>, <aconole@redhat.com>, <echaudro@redhat.com>,
	<horms@kernel.org>, <i.maximets@ovn.org>, <dev@openvswitch.org>, "Donald
 Hunter" <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 05/10] net: openvswitch: add psample action
Message-ID: <ZoPgLfosO5e160nO@localhost.localdomain>
References: <20240630195740.1469727-1-amorenoz@redhat.com>
 <20240630195740.1469727-6-amorenoz@redhat.com>
 <ZoKVtygkVYfaqjRI@localhost.localdomain>
 <CAG=2xmMgJcir=mfQuybosg9C8j3Sx1V=Du0ObH1eT_SnBZ7nMg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=2xmMgJcir=mfQuybosg9C8j3Sx1V=Du0ObH1eT_SnBZ7nMg@mail.gmail.com>
X-ClientProxiedBy: DB9PR06CA0013.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::18) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|IA1PR11MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 355ae514-7706-496a-5dc9-08dc9a87a1aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?i9KTaJQsWmBG26HR9myJ2V0IGotZiF84G62S+EG7UsiUMwXxl0qssrwOuF?=
 =?iso-8859-1?Q?+yv8h5SiQDeUxw0FNhPddoibEc3Btu/wx94av2sbr92c+iSdomznAHGLST?=
 =?iso-8859-1?Q?5ikP+1oFSHpPg6K7voLMlOMH1rfA6q0/aAeDKbCPz4K8CPQwhBbNMDbl00?=
 =?iso-8859-1?Q?Xj1GCpw7DhUXW9R6yqCVu2VX451AupwYOff2M7mm446+J34iVZ5dDwoTfM?=
 =?iso-8859-1?Q?pfuVsHJtCoWviU+g8PeleUsKHvbvVV2+xk+kJ6DI6Jio+/Qd1ucTDwzsPC?=
 =?iso-8859-1?Q?kFlmV6K7C8W+6Oq2sT2chIyR/IaRJFrQkzJOUTfLwROgdE5DUQTZffE4s8?=
 =?iso-8859-1?Q?QSMBVBt0shShhIYYFNkJUtpj/3r3ECtUS8n/icvfcl3PjL4u7KnLZ5bT5K?=
 =?iso-8859-1?Q?p/YfZCTI3cyS7IsInFb5SuBIo8FdXPZk7yDRxyQudaeoD7Chr6k67qSbDH?=
 =?iso-8859-1?Q?H32TKRmvUZ0AVWdFO9iz74RQmtC4PDaadp4RgnY562v5ZdZYwgLCxH5V8n?=
 =?iso-8859-1?Q?FW60j9rmBvjFCogdfWzPXpPiI4kNyuPGSH0fxAMnZ6qN3/xGLH4+dZitER?=
 =?iso-8859-1?Q?CdmOgzUDO0n+SXa5/eyEOuBqwMjHhEQhV+kxgZa8PNJ05kiJNwkRlMliYp?=
 =?iso-8859-1?Q?4uo/+c8QJPTi3rJnzi7Z37YOOfLmOHnBiP3jG4PaX0cgcfeyWoBjh5aJMO?=
 =?iso-8859-1?Q?kGBNL/MYAi1va/0A0IffRQlVj2rDbVdbYmUVpfjUCfSogydBK7d117ArfU?=
 =?iso-8859-1?Q?H3dKbMfk2jfJQygZUojT1L03RB0FbAQ2hAfKprebpmeERXBpuUNhG3xp+H?=
 =?iso-8859-1?Q?TO82RTLV5lsnTNGuFHtc1/Yp0Q1CR4v7ha3tX4pmBlCaVoT1aqhGx7l6qS?=
 =?iso-8859-1?Q?fbLZMBUmflKhJwHpCya3cp4wkjyIWo4JgUspPCEFUjP58BxoH25r/Q6V21?=
 =?iso-8859-1?Q?cg23MfyP2pRTBggCE2qLT2/+4TCxBm/gvrPvVaiOgGsYpCgyKfwiUnEFS7?=
 =?iso-8859-1?Q?KMppTyaJNXDMedV+VGg3aWbVYi1A5C7RWF554QxuZABV83WTCRGNDGBetU?=
 =?iso-8859-1?Q?ihSJxGQrYxKh4GajMNUtsInvNeEZCCGa5QonTuMdZLV9SGZgzSeqbGor/V?=
 =?iso-8859-1?Q?e91cQOXR4+BHdxpUhXC5NoHcTOx0pBH+LhXzsB9NZP8Ln2e2n7DlcX78Tc?=
 =?iso-8859-1?Q?O1KzxDK+rj2yKI+wbr4WeUD37L4aDKKHDteXxhHYKDwA/a2lsweoqVszfd?=
 =?iso-8859-1?Q?Kg6kByHpXCn6+EeHgP20fnPIW4Y0wLxVBfLVuzI9NiRQJmbYUIKgraFok0?=
 =?iso-8859-1?Q?GsdB11t3/RciEv/mJUXAfORyBwivJGfbq8dOcFCGacaGn1g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Uje3G/CPnNaAjVlUhYJxdIng6K/A4+CSAfYSaV0HmuE7+BPOKZCduS1HN2?=
 =?iso-8859-1?Q?hfcwPwWCeQZXv2ONgzGGBbkOnm7DnQ8JhxSSYBe6B95lCZGH4MyQzRj/zh?=
 =?iso-8859-1?Q?BjTPnEypTzY+21sZzEajsGebz1sb1b3cT2KFBWnQH2HdPDSd2QdvMit0aH?=
 =?iso-8859-1?Q?cphD5FlVDvRpB+E/rxSepQ4avivQPIM5zQxdEyfO8aXG4W1xC+LOuwLGXe?=
 =?iso-8859-1?Q?habqUMH15pJvE0M2iRQes0nzD7O8H0uqCbON3Xw0HcatCsM5yecxI67QB0?=
 =?iso-8859-1?Q?JFpr2q/25cLSphtR6cyN92FSwKkst9wh+Hy7k8inARhxhWfsmR+uSPcCRL?=
 =?iso-8859-1?Q?3Cmbofk/cscSap+azvPZ6FjcqR/NewZ222Gpsp0hdtxelGfsZAAE4tWKNb?=
 =?iso-8859-1?Q?rLTP9Gk3BHXn5ltjOW/ibFCBW/Z72kUcfVZF2XzjP0+4seD5aFwPhSsTjT?=
 =?iso-8859-1?Q?ApJbKU+ceW54Xv/zwsHalP0WWFPgclcokDAQsQ/p8grSce4l7eE1TAU0zf?=
 =?iso-8859-1?Q?PXY25bjiGLzEQ640pWTaJGl4SZfeWH6Lfms28B+9GN6S+vJeZHnUHXokND?=
 =?iso-8859-1?Q?JvVxcrom9jcUlM2OEyE+SA0aq8Tq806yFwszu+KgQ1J8EdV/eEaQem2Dxm?=
 =?iso-8859-1?Q?LYPPD1exiPcITHPQwN9oqjdmUffIu3VnOmeykIAMhPmGB81uL0nM2dc8Pp?=
 =?iso-8859-1?Q?q2Y8KhMuwNu5Ko2ZtLWgbArE9N5QBWXCa5DV/PRkfJCYFYkUbQPke25MQ2?=
 =?iso-8859-1?Q?bAzaxxMx2wpTCoxOr0HsOxjlhzO3Ti9fUjvlSdHk7nAZAKkLYuqvcucW7B?=
 =?iso-8859-1?Q?DlXsEPbCKSWtagYohZZVJKy7Cwvx0XoFiQMRAuj0qaYAABrEXutXESzFiK?=
 =?iso-8859-1?Q?s7sVAoakmIeg8yLFVaJXMEZIsaP+QLVrUAs0I4+HFHJROGXkNVhC0+0Oj/?=
 =?iso-8859-1?Q?18t37CpQu59mLEZ2Y9JW9baoNA0kiYu/i1b50iZDTg2mgXSYG4fEhv5cQ3?=
 =?iso-8859-1?Q?UOGeb3BTpa29lRY3kPpdsqGeqLJmUqMHQJPrpiyoZzduw5scmlYVVzhsGQ?=
 =?iso-8859-1?Q?RAGJb7cEElBt0IhYjwkhajM8rCpL+gol30XbEZc//mASvWeS128GCQDMPQ?=
 =?iso-8859-1?Q?aVRcY+mUCPQKN+1cyQgWYF/DMz3U1fKiNl0Z15ta0oiQwpikM1gMSU3GLK?=
 =?iso-8859-1?Q?qLJA/Sel2ytVvDw9ohbWdzjWUwRlwJf7zBeCwTzWR5mRojAG4qel6Z5ozm?=
 =?iso-8859-1?Q?VXF8HjEfFRiG9OHYUj4ZT2g49hhb5w6TLfQj8zlM9qBoA4yXfMSkeF/UYI?=
 =?iso-8859-1?Q?jTDu5RkOZZd7n7+zKK/tUIo61i4eRPWjUIyOJq88lIxUe7dmlijnGSQcLF?=
 =?iso-8859-1?Q?L5o3gD+PaaU7BYESBoZ0D/sWU4of1tk2i3cF18zQgKMQZhx9sN8WK/2DL2?=
 =?iso-8859-1?Q?yHKDkOT6SRl9P7J09606tbldQeM9q5LlQ/+3IKVNFGHa8JRvhbRX/5mQ2N?=
 =?iso-8859-1?Q?yj+IBFX6LXR2n1HL0B3fEO7OOvMSGsEWJ7s3OuEvvXpkT+RtQZuHxeN1Ys?=
 =?iso-8859-1?Q?SgCC8yQZ9DpCdJU5DgNUaoZaL9YXP4+1RBP5+cKOleF3bZj/y+AmPCzhk+?=
 =?iso-8859-1?Q?rOJO09bq+k5zOkhcMsyQeAYZCb2sMbidKvot84yyr84dUiiHpcxGNwoA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 355ae514-7706-496a-5dc9-08dc9a87a1aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 11:10:50.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20TSx3zRhqpD8yd+4sy1iDv1IHlewwnLnfsLsGUvBEIFhwKUd3Mf0NNnjwh++Ys1A4isQEKHD5LRbU6oN2ThQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com

On Mon, Jul 01, 2024 at 12:56:43PM +0000, Adrián Moreno wrote:
> On Mon, Jul 01, 2024 at 01:40:39PM GMT, Michal Kubiak wrote:
> > On Sun, Jun 30, 2024 at 09:57:26PM +0200, Adrian Moreno wrote:
> > > Add support for a new action: psample.
> > >
> > > This action accepts a u32 group id and a variable-length cookie and uses
> > > the psample multicast group to make the packet available for
> > > observability.
> > >
> > > The maximum length of the user-defined cookie is set to 16, same as
> > > tc_cookie, to discourage using cookies that will not be offloadable.
> > >
> > > Acked-by: Eelco Chaudron <echaudro@redhat.com>
> > > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > > ---
> > >  Documentation/netlink/specs/ovs_flow.yaml | 17 ++++++++
> > >  include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
> > >  net/openvswitch/Kconfig                   |  1 +
> > >  net/openvswitch/actions.c                 | 47 +++++++++++++++++++++++
> > >  net/openvswitch/flow_netlink.c            | 32 ++++++++++++++-
> > >  5 files changed, 124 insertions(+), 1 deletion(-)
> > >

[...]

> > > @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
> > >  };
> > >  #endif
> > >
> > > +#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
> >
> > In your patch #2 you use "TC_COOKIE_MAX_SIZE" as an array size for your
> > cookie. I know that now OVS_PSAMPLE_COOKIE_MAX_SIZE == TC_COOKIE_MAX_SIZE,
> > so this size will be validated correctly.
> > But how likely is that those 2 constants will have different values in the
> > future?
> > Would it be reasonable to create more strict dependency between those
> > macros, e.g.:
> >
> > #define OVS_PSAMPLE_COOKIE_MAX_SIZE TC_COOKIE_MAX_SIZE
> >
> > or, at least, add a comment that the size shouldn't be bigger than
> > TC_COOKIE_MAX_SIZE?
> > I'm just considering the risk of exceeding the array from the patch #2 when
> > somebody increases OVS_PSAMPLE_COOKIE_MAX_SIZE in the future.
> >
> > Thanks,
> > Michal
> >
> 
> Hi Michal,
> 
> Thanks for sharing your thoughts.
> 
> I tried to keep the dependency between both cookie sizes loose.
> 
> I don't want a change in TC_COOKIE_MAX_SIZE to inadvertently modify
> OVS_PSAMPLE_COOKIE_MAX_SIZE because OVS might not need a bigger cookie
> and even if it does, backwards compatibility needs to be guaranteed:
> meaning OVS userspace will have to detect the new size and use it or
> fall back to a smaller cookie for older kernels. All this needs to be
> known and worked on in userspace.
> 
> On the other hand, I intentionally made OVS's "psample" action as
> similar as possible to act_psample, including setting the same cookie
> size to begin with. The reason is that I think we should try to implement
> tc-flower offloading of this action using act_sample, plus 16 seemed a
> very reasonable max value.
> 
> When we decide to support offloading the "psample" action, this must
> be done entirely in userspace. OVS must create a act_sample action
> (instead of the OVS "psample" one) via netlink. In no circumstances the
> openvswitch kmod interacts with tc directly.
> 
> Now, back to your concern. If OVS_PSAMPLE_COOKIE_MAX_SIZE grows and
> TC_COOKIE_MAX_SIZE does not *and* we already support offloading this
> action to tc, the only consequence is that OVS userspace has a
> problem because the tc's netlink interface will reject cookies larger
> than TC_COOKIE_MAX_SIZE [1].
> This guarantees that the array in patch #2 is never overflown.
> 
> OVS will have to deal with the different sizes and try to squeeze the
> data into TC_COOKIE_MAX_SIZE or fail to offload the action altogether.
> 
> Psample does not have a size limit so different parts of the kernel can
> use psample with different internal max-sizes without any restriction.
> 
> I hope this clears your concerns.
> 
> [1] https://github.com/torvalds/linux/blob/master/net/sched/act_api.c#L1299
> 
> Thanks.
> Adrián
> 

Thank you, Adrian, for your detailed explanation. I wasn't aware of the
internal validation of that parameter using the mechanism from [1].
Sorry for asking the questions I should have answered by studying the
code more carefully.

I have no concerns about it now.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>



Return-Path: <netdev+bounces-158575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A40A128C8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E821612A6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAC6156C70;
	Wed, 15 Jan 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uc8kOsWe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A533DB;
	Wed, 15 Jan 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958972; cv=fail; b=rXq1inyn8IdYk0F+DKCoCO/4yO/YywfJCXtEYhahtxxzCxX5QVo3WPRGzEuBqzzybuk0/o32nsk+jxyRTv3sZFFBiyi3jkQnUvwpeOxwSf9NZTKrc9oJCAGP2quoRIVuYaRIoPHb9VEMkR7DlIE0obfps4osyk7C1GjV6TtsKCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958972; c=relaxed/simple;
	bh=3AgF40wcEtLn/dBZQt5Y6/vHU40DCeeaAAIcVf/H80o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MDArypAYhQecyfXGIHcBwOHQ05mpE6dN6CUHv1t9vZuuWi4TVdorwkUVzvO+7Fxen4DaTg/RTbWjLFQo1aHd1QJZDyePoHL3es2wAnFkmJ/lmWO4bkk9nnip9hwduDm537H22OFA2+swfKlpeUN381H3hW3UaqqPU7D1ei/Te7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uc8kOsWe; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736958971; x=1768494971;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3AgF40wcEtLn/dBZQt5Y6/vHU40DCeeaAAIcVf/H80o=;
  b=Uc8kOsWelSPdSfygDeMoLrWMmkjICv9cBpdqrkG023rKzF04ANDikjDv
   1VeSdbEWO5FQxJFjsI7MiBQ+b1zBnIFRpDMb/+y3183VAUcDD+YIhRKMl
   4u9KVgWp6TRHEgvlsLXX/gfZHBAyYIAIdkkckybFPcQEm2lqqhhnzgMfO
   /TF1Vv5Q3QDqkFA/6saGEKO1bNxW1AfqlNxctUeJltDtD+R59Z3bLmfe5
   mtuNlsKuRXN8pjBTUj1gxRdaw2gGLN+WE0ty1kIwFL+Yr7cRLt4mJQ/Jk
   trQ9iEZO5dwp49dziSyLlISfe60S+EzezmFBeKRyso93OaNrF/ZuwfTqe
   Q==;
X-CSE-ConnectionGUID: kFYkfvYnR9ak1VKeC2TY/Q==
X-CSE-MsgGUID: Wcc3p99URIKW0DHqPBttXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="40983101"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="40983101"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:36:10 -0800
X-CSE-ConnectionGUID: InnPVWujRdaEj+cZZ4C4kw==
X-CSE-MsgGUID: 5+qIwZ0sRyiLdxdJsAkpfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="105373560"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 08:36:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 08:36:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 08:36:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 08:36:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks9FUfLhBPOt3SNGCkG23pJOehlDUbY60uIu/D3byiAgn95Td7Ri2URGwhTboz6MZbhXRoFWMByR+V948KUokXPGNDWA8KoABcyna2mzW3eKeGTqGdZDWrh3K0QC3xe0U8XYZcSgPFzbA0Cd5KjWIxQmnfCku2CIEbinOgNWGR54eGutNOglTUnBzYeZXq+pkF+MyzmXGD78GG1brey9/YMM8zX2rrBmhhUVQsMSp7hFAbNznPyt9pL5KJelEegDXE8NMVtIewLmHzRDixihxRqr0zL6WMfvkYAiJ2gsyoa0gV3K1xi9Vow6ZLnHAE1p3ZVD1/C3q2PmWdt8l258TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=App9HB/DcoPlCvuZe2ftYdvgBnCwBxEomxzkCxAPxjw=;
 b=CwYYuaMU7wziiMbBtXJHkgJTiK1dEMpZcsJPQgwIckR+RCnebYZe5MfUptU3ePQP5Qezwrb7o03Ov60iDjvNX78/7Dy1ex/0PPh+Pm348b7Kh5lRRfh5DcMu1O9/KaWDryB96QSwS0pP59jVc0vcPBKOFUBmsnX9VIhQMobwiBpAqPMEvm53vFRUQcKX97vH+oLI9lG6vTtmwgLlY26UmF9eZtAD2lWC7TjYgFWOKnLYScm7iNOz8+seD+dNLfQQ+hL6EWzuOuWPTI+dBeU2cuI/+JcquQckO4j+phAfDnr66sF1gVMVY/S4DeAy/1EQ94zw6O4VSBUIfb94Y+8EwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH8PR11MB6778.namprd11.prod.outlook.com (2603:10b6:510:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 16:35:35 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 16:35:35 +0000
Date: Wed, 15 Jan 2025 17:35:27 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Furong Xu <0x1207@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Joe Damato
	<jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <xfr@outlook.com>
Subject: Re: [PATCH net-next v3 4/4] net: stmmac: Convert prefetch() to
 net_prefetch() for received frames
Message-ID: <Z4fjz2QSXDhmM+4b@lzaremba-mobl.ger.corp.intel.com>
References: <cover.1736910454.git.0x1207@gmail.com>
 <909631f38edfac07244ea62d94dc76953d52035e.1736910454.git.0x1207@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <909631f38edfac07244ea62d94dc76953d52035e.1736910454.git.0x1207@gmail.com>
X-ClientProxiedBy: VI1PR07CA0258.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::25) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH8PR11MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: b1646d90-e3ef-45eb-05d8-08dd3582a308
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YnovmKnG0c3Xncj1TvAkYyuH8qLvny5wvHLbH9y/lj/hBUuc7JUg6p3wYvYS?=
 =?us-ascii?Q?IEXk45v5Sa1kDLc76Z6c43xfkViqwfYVk7GPkXCSvUE48CYrf77IY3cGRj5I?=
 =?us-ascii?Q?/dm6Bq0FbLyYQx83KwrR6EzIAJ0+ULPUr7EDn06MRBsfAferrb4LWPmaCMuO?=
 =?us-ascii?Q?nF1pQaixy9azwylfQpGsAk68XB2UWhlb4Hkuvq/T05zjR5SeiwpjszMxu0EY?=
 =?us-ascii?Q?TWLJCh5TXQQpu97MzhQN07yDVAlkbN/zILhcMW43C5OLZuKZEfxkZaD27UP4?=
 =?us-ascii?Q?HYGEvh0ugG3aBkyjnmHkH/Sned60BhIK0PufJXM7kwOhl0wYn1HMFI2N/7QP?=
 =?us-ascii?Q?quEHwiud0yUCw9GA4/ACLZ827Rh+1IejA7EqCMUJPtpKwqtv/GraBS3h6+3n?=
 =?us-ascii?Q?bHz2Lfk32hp2gHfd7o4eUXYmIlaGgAbjpwzoCdMDsy4cxhKeOXZXkt0lV+Of?=
 =?us-ascii?Q?syIe1+PsvqaOiemPGns+HhqEhFb2p3ZhT/JQXpGwLwHFwejlKbyeqaU5cq/L?=
 =?us-ascii?Q?2TW8xu3eaIu6w4thWgmgYHGSaQUA6zhxbR3CFJVm9jsstfLYAqM7LYGOXI7G?=
 =?us-ascii?Q?iZS1s8+u/iCsWBcwtYICFn0kTc410j4BY4Vu0S5tFRs+IdXfaIb35ihTlTx4?=
 =?us-ascii?Q?/CAgaBzpEsHqwkyQFS6yb8RKXhyLqLK5zl1sA4KgE57DT+qaiE3dVHEVJHzx?=
 =?us-ascii?Q?cc3JT5J2xVHg8naw8O76tx/iWJbuMRISJYTzUEK5RaLuu8wi1C11D186Vy0R?=
 =?us-ascii?Q?9WRLeb5jXT+ohWk05z36MvkLrNsljVQPfZLqhAWwTZ9MZGI6lXMDlpWAvpqI?=
 =?us-ascii?Q?aCmklSkBmnfxlsbHQJX8PIvCavE+DyjlhxFudtActhpcMUsVCwTL7QXozNIv?=
 =?us-ascii?Q?4NqShDS3+AoL+8m9uVMwOUaO67g75ta4ZYt5S2J2MrlRz2Z3wHP41qLCTj5E?=
 =?us-ascii?Q?WmsSNpKaUaAWDq4KWDP4DuVHJVQ3HUkQrIYaW7X1MkfGQSFt2Vyn9spPDGrW?=
 =?us-ascii?Q?6d49FhlGTarrN+NTrH40OLYSgSQXgN32nWxBvaQSGxpGTpvq6n8sVP8n1/MP?=
 =?us-ascii?Q?+czsMJZFbxkIoHG/qWBVwLWp7dokVAL+vzDGkoAn7zLkbzdDCuVMrGEOKj1k?=
 =?us-ascii?Q?BuLjEM7HE4SoaS0tgLyH4ukLwt0yXrhfBQpHnFFJi6XSy2cxll5cBg6oLAlQ?=
 =?us-ascii?Q?WYy5abh1QQ1dMIwSg97GYvCozl/MPMulCuN/m2zeARsod8rsWpT2ds/vdsw5?=
 =?us-ascii?Q?eEl/lBiqzZQlc0v3RlaAeYy14CuVMLLuePUSZi8gstW7WLb4tnysvyE4xDoZ?=
 =?us-ascii?Q?S7l03W119a7PCNJuaWJYH516qEdMVZ3JTf9YY8/IpSZL+eV4eNAs5aMvW9YD?=
 =?us-ascii?Q?89DRiFhkPKuQyawv9IoMrY20myNi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FeV373R12No2SurA+xIaxvH1sXhukYT3do0tJ6VJj+MKHHfKZdbNj3sz+Deo?=
 =?us-ascii?Q?BKRt+1rUV6LttDA4bvKLHFI4NBUMnhIiUCnNZxmVdrXANm+uFdzg9JlVdIwD?=
 =?us-ascii?Q?0HHLm1/kGrMB6dfVSuNaOdtKcfhw07a7oDa6vnAxhkYbFyaZd1hJvrIwU/AJ?=
 =?us-ascii?Q?Ug6RZb1lWMZAmAUVEVEzucvyebnYRlXQR1D6mnORlcNCLNpBH89WLWFRw8SR?=
 =?us-ascii?Q?M0M9+RrHhNBU03M4FTYrbrv56fsXFzRi1BAw1lOHN/Qv0xgaSmB57xWLUdy3?=
 =?us-ascii?Q?52wrLkscY86S8PDGaVWL81a76zU8mm0D7QTdXBsrEGTZFmX9QZ6o+aCQBr2P?=
 =?us-ascii?Q?uEZmQvdvigFQCnooLs0vv0qaa4NVIwbnSA62bPNLOcv3HvdNYeSzE4HtffTD?=
 =?us-ascii?Q?WZUBml1o/Cv8g5wJLSwOLSSna13DuZo60H8sePUXovlMjf8xI153CGSzu++t?=
 =?us-ascii?Q?rEBr1GqJoavZp9wpFlo7WeuGd3z/Kd7JN+xOE8ryMXf0h6XStwuLJetUfpHh?=
 =?us-ascii?Q?sIl59nEFqZQ0hZ/m1iIq24Qt3EjspHxqdqNu6Vd53MG1/BmYsUPERsP5g0mY?=
 =?us-ascii?Q?jJR/4EUe2OtRFP5bkbVuxu0iMknrDet4LzzglV/C3VID57fq3xR6K3JE6vyF?=
 =?us-ascii?Q?yguBdZzCKqFMx6bWpf3kd7rAhi3GGM81UrAIOW/WoDSJQeqn77ZjuruSvuQ9?=
 =?us-ascii?Q?5X2XCRFfoFkNrzhdKcmF3/7aen+Ngm227BTAIEd/xs6fSSBRWLYXv+sLQHRX?=
 =?us-ascii?Q?Bm7MlnmuUrXx77J+OrUeL3+BCA4c6K9L7beX3dOlQStj2D9aId1K7aszWqfJ?=
 =?us-ascii?Q?e/Fe+5wt+tRJ8UtfRkKX0JC8N7gmS7hfnl8hpUPpbodVPfN2JREZs0r3IorQ?=
 =?us-ascii?Q?/PEQPxI+ZwIbbOb9O/uAGhpNMDUfkzKMG4Uwe2pJhr4D88yv6AezIioaVHAq?=
 =?us-ascii?Q?CCuOBRUt+xvIvf7B4bbYnSeg8zCRuwJtcgErLLP9sT/Tk11IazV2Bmey3sPe?=
 =?us-ascii?Q?mL+juB86N6/WU+8fbeDjsPsN2Df4dEOWo1JW09uQUdbDRoB/6WmhZiu57JB4?=
 =?us-ascii?Q?F4hBx12RghIgxb1BGq/sako/nysMW+NSppfz8PyUBXcTa3DRu27Te2dUoNiT?=
 =?us-ascii?Q?MFa3OIaq1ac7vQ1R1J6PEHFXQhQVd6rFDK7YoxukNs1MYIoDRh3ZwR1oJg8D?=
 =?us-ascii?Q?SrcCVkaUTcztLef2ZVYqeO3TLs87zSbgveLTMSpPbKAj824o2V4EiSQlnLdO?=
 =?us-ascii?Q?E06+MgmZKtBfzUXRcM7r3t/yAB3Wx2oVgQdyAebZZICAg8auAIEOGGilxMzq?=
 =?us-ascii?Q?HBX4+tBQPsqmW1jR3w8mH2Odxz4fN0dknEqV03AIdwauEncXebQiVzk3Rxgu?=
 =?us-ascii?Q?nm7QviIeX3cleBnhSraOsanBSo9zJEM40gEkLQWnG8eT7bynzgZExGsdOadY?=
 =?us-ascii?Q?N9//ehDJ6i6epyPHin7lwyOEIviA3/ZvB+aRPSHB943qkmhMyfr0QLEn2Umk?=
 =?us-ascii?Q?zI8OtXUsK1S9tXpFb/de6fVMiOxXu522pgi1rVrH77R3qP8B6hH8vIyyGj6p?=
 =?us-ascii?Q?xA707b4lIOI4daQm2wqkSix/TOaMiGDaokzkf+fbXBZKFJ/7KNrw2v3K5qVH?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1646d90-e3ef-45eb-05d8-08dd3582a308
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:35:35.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FePPNKYOv9GHJH/vnwrX0N/zVaBPGdG7m+wgWlsifQVk0deK0EivBaUujVWI5HfQo1nop1P0YcgMPagmYbCFiwhQ/+V3STniIQcXInEBDlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6778
X-OriginatorOrg: intel.com

On Wed, Jan 15, 2025 at 11:27:05AM +0800, Furong Xu wrote:
> The size of DMA descriptors is 32 bytes at most.
> net_prefetch() for received frames, and keep prefetch() for descriptors.
> 
> This patch brings ~4.8% driver performance improvement in a TCP RX
> throughput test with iPerf tool on a single isolated Cortex-A65 CPU
> core, 2.92 Gbits/sec increased to 3.06 Gbits/sec.
> 
> Suggested-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ad928e8e21a9..49b41148d594 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5529,7 +5529,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  			dma_sync_single_for_cpu(priv->device, buf->addr,
>  						buf1_len, dma_dir);
> -			prefetch(page_address(buf->page) + buf->page_offset);
> +			net_prefetch(page_address(buf->page) +
> +				     buf->page_offset);
>  
>  			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
>  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
> -- 
> 2.34.1
> 
> 


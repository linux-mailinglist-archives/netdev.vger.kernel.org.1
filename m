Return-Path: <netdev+bounces-294134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNzMAUuwHmr7JAAAu9opvQ
	(envelope-from <netdev+bounces-294134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:28:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BF162C8CD
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E707318A41D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1624E3D75AD;
	Tue,  2 Jun 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCG01NVj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76F3DD50F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395229; cv=fail; b=Zbm1YdHYJGZWW5PbIa5p4e6qQCJ/Veudl79M8jarVMaxj3viQcQ667LtLrBboxxC6a/Tp+bC1XmpNEvP7ni2h9zxTtIrRbCHOv16M3aIdOFEGlTLB4hlVTbXUEyqi7ilpHH2Vcv1nxgf9d9vVFSE71maM0B6Lu3K5lioHZTWXPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395229; c=relaxed/simple;
	bh=1hUqaLT2UXfwVKmZByLUefcOA1unxlBrgjoGWrECkhg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bo/ZAFwsuiWw9Ok7o9WdWUyaY6nkqQ774WWOHnnmHE+4r8U8zleEfjV4GkQM2xG+piov0mvIWF4EQeiAggHA4a/TZ5QphdR3K11XIXbPd72rVlKGlB+3MsCbszvwCYJCL7uQ2xOUIPDvVzn2v7Grt1IGSX7baoBuZn3Gy12cSLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCG01NVj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780395227; x=1811931227;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1hUqaLT2UXfwVKmZByLUefcOA1unxlBrgjoGWrECkhg=;
  b=aCG01NVjUuPW4JOeFNI0oO6BBURQFgyUXeOKjeF11W6htABPVeDML5J4
   V5jCUd8KNM0+6n7wbemnMdzPRCpLnTIrVXtRLIj/52Ez3YqQZDxknKo9F
   NCbODrrXhANg6STeWQb6uiUEOBTMibacl4P5kfxWDBdrw99bbAQGQ2FBZ
   q4lSI/MNfKFPcjPEd4lJZjiJyD9WUtOx1ZLpilJXcslaYI+ISBBDehYSU
   y0Q7aDs9OZeBk4YOq7ZlHI80zpfA2n8jwy9F/fIzLl//RzQyk+z1toh4u
   jPkdB1qyBbBVMTgsQEG4IQHLi7uQjs/qOD2RFnQjpeEl64aqtxYWArBh6
   w==;
X-CSE-ConnectionGUID: cG3RZhNnQ6iQ46HPqUD75w==
X-CSE-MsgGUID: q1DVgQQ2Q52rP4gLOtHqzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98595304"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="98595304"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:13:47 -0700
X-CSE-ConnectionGUID: 24FLrfP/SUWdhjPhuNaEtA==
X-CSE-MsgGUID: 1qA2rpMJTCKoojTmIVhPmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="240863413"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:13:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 03:13:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 03:13:46 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 03:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFpE2+Ers6PjcaWYXoxEC3owieAOYDfAFM4IZSubHneO4r6uwvYNnZiIeSQSOnq5BhjDX9kpINNOXaBSBrZpFHFdGlaJyRn+DIbPiadwM+lYdkh56e+PEyOgFEkr4t/OWyGjFWrC/3ATOC5sfxWEAhoT+31ekxiclDAHiNrkKXfGxF6V7G/MrraF4Hzo1/PCQTkUFemM/H3tiMUnd181NDGzvdRF/Krsqu7gHqftdIw56HYsnOmel6UetQ30aVVi5DMFiJGID3ahkah7Mkv/M3YOjYXOTUFtJijSc1CE1Ky5Va6Ka9VAqPchGeeGpAv7ud3kmx9qvq3r28EYyIxzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3qF5HctU5L+q4pqzWBS/bKCk12KlLatA3h45dHLc2I=;
 b=YtoqsCMlu+NnUZ0Ng0hdiqvjZRlsUiKWq5icogLyopVdeoXBm5x6BTFcgANkBu25UtivY27aLyckH6wj5Mm0kKqtiRQheuJi/Xrx/HUZ9jfKTWVYc2nbyx6xW/w1UQWopIrdCUceagrwiC8+z4Opl7rU8xjAKMHT3OyDpssbY466sYFWzz0pS1uhDblG+YT3eXiXmk7S++Lxmb4U57bDkR4uReIW95BNaZdF0S3VDnWIgAE+OeFW5wQ26HhWVpOxsS5UvhPgdjUFanRIo4DrWpDxE4OPyYEsjlK1y49AmQNyd0hLkT8Hb/kvDqXQnufepGpsPbPPHDmyHn0ef317VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CH3PR11MB7819.namprd11.prod.outlook.com (2603:10b6:610:125::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 10:13:43 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 10:13:43 +0000
Date: Tue, 2 Jun 2026 12:13:31 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, Mengyuan Lou <mengyuanlou@net-swift.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>, Jacob
 Keller <jacob.e.keller@intel.com>, "Michal Swiatkowski"
	<michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>, Kees
 Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>, Joe Damato
	<joe@dama.to>, Breno Leitao <leitao@debian.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Uwe
 =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Johannes Berg <johannes@sipsolutions.net>,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v4 1/5] net: ngbe: implement libwx reset ops
Message-ID: <ah6syzYPP7a_Bcul@soc-5CG4396X81.clients.intel.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com>
 <20260601072221.2952-2-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601072221.2952-2-jiawenwu@trustnetic.com>
X-ClientProxiedBy: VI1PR08CA0219.eurprd08.prod.outlook.com
 (2603:10a6:802:15::28) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CH3PR11MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c193be-d1d5-438a-6e68-08dec08f9fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|7416014|366016|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: kl0+fthQ2HW9x9QCx5ZUV5iNHMiDdZ3Lbsw8G1gv3wq+suosuJeN0ANNlOONsI5u6MJI8ReZr5gt3LeKX4pk/P3EBINxSWBdtStbDXIE5np6C1jQvYCCrOfFePf5OsqOlNcWm2y1oAxgUga5bUJl0xQslil++QPopH0LIYN/6XHsYApNTg6XMH0ARyn30YQhqBKegg0EC7yNkO+W7inA3ZXm2fktYymP4ZNZlZQg7NM2f2ZXpYDXm5/MnA1uYt9sVdzKjPkIcmLpqzGyQaGW9xPlLJ4tS8bxhF1y0EWiBBEj00L9W7iw/kSHOzYVlfsVb3yBKI5G0iSgsiDv7dbPfQv3CLNJIb/RiEaUpgvSU0phhedYOlk9+tom2M0rvSU7sCTOWsXZBfVV6hvPl+U7L79Y/jB+EwvSfUjr+vxLqr61K5odAi1waFsjITCPxlMuTvcy87jIOivJ56spg/n9P5dwdGaOt2iM+3e7RideiBLQYTxNQlOcUhkTdRqAVLg06iKJp0tnTzDMazo4StmAqxFpSRQwlbYr2+znibtARs56fWOrBd83iMWmMq2qyJDqchQQBl6tSkputp6p1y00Q3xLiuivlO051QAvlqxGhqqH+uGDk7XIfZhMerIGODFaBgJW6UY2Hmg36ZSo7z7a+WMJVhtVlN9ktRDhbpQzLMAneZoeAMLC7r4I6nb1gsrH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MZK6kbK6Y6B321QMS/6bRGob/32NCRfxw6IaXmIY1/JNEOHM1hZ6KpYAaQxd?=
 =?us-ascii?Q?Y1IwFbtGcolRx4ByN62O3HN/koRIBuy3OgrBRySatNr80c64WXYdWofHRgsl?=
 =?us-ascii?Q?G6f4ZPxLJ4f86lHQAXTe4+rbCUa9eK7HewTOyOcV/dcj/JxgkHJCuDeXgEnX?=
 =?us-ascii?Q?r1x0knbGoBM6cHKY+AZpnWREfKMxZvENHeS4BU+KzhmZzsHLjGyGZfHnuzje?=
 =?us-ascii?Q?XHbC4G7LM5dnT1xFLzPCj+bnojzySG0n++9U9W/AZARTXg0CRseTdim+NLq+?=
 =?us-ascii?Q?t8T2Zb+U3vfDSrTN9P5TyMep9mXi7xj9a7UsNBjsaPNSDL5J+fVCzRiB53gF?=
 =?us-ascii?Q?FCjNi7soF891Qo2F0OHLEjKL54I2LZiKAIAUzeSyg7aaptSq6AlaYHkh+b3R?=
 =?us-ascii?Q?hUT71NeH6qV2qXR2pzCXsXrOjGM3Ix9ag37L/VSabPOONU2IZLKlWjSexcHJ?=
 =?us-ascii?Q?3kWNbhOf0BEm6iM82Hsfhn/6ttsSTUeUWCqHnb/daBETSxrhwaH6IBmUGQ3U?=
 =?us-ascii?Q?dEy3D6YfVl+J/DdgFa3UV+Rpe240RunhAnHf5LkN4Thy03S+H2o6kZWlLdWq?=
 =?us-ascii?Q?9ObK/sSF2GnY8xxmxLXil98Cx7lAvH7SLoDBog3nWtW8uBjKhMW+WGDNo8mk?=
 =?us-ascii?Q?/FZ2izrga2TSsTNSahr3a2vaN69BxAeRiK4SOndAlv+/Z63KlnD2O8AwdcNd?=
 =?us-ascii?Q?AaAidkr8RBqy6qYkWIUemsLiPS9BkOC4q74/cQfRiUKVNoKF7ks2Ap6t8QuW?=
 =?us-ascii?Q?aN7HvlOV0TESD4N+QyRjgBuM0cmsG8mWM5FsOBhC8N0pIvjYtowDTlflBCTQ?=
 =?us-ascii?Q?i7OqNSDTANQyx04DEcz53ky0RT3CbMoZG5KBffGfYcURePNR/bmlOd8BJVBf?=
 =?us-ascii?Q?HE2qSg2fnUzCN0Eh8b5l9tUX3eVeYeF8IdGnC4fs1eZGaaARLEg0Zod459Sx?=
 =?us-ascii?Q?9FEtF7l0CFLLYizn5LwvVXgQE+O/liFqPT/NydYWCpq6d8o9cwmh4x4aXxEx?=
 =?us-ascii?Q?gCWVcHBFyd0do2JpOzk6Qj4Gx5n3jgyLj14FJlTq+h+MzmrFTUnMSoHQFSlC?=
 =?us-ascii?Q?vaTM9S1EfKbqpi6Z+Lss0pAXUKxFZoUq9wo1KQHB0Ai6PcmV4E3YnOxCnUxe?=
 =?us-ascii?Q?VZoMA9W99bGjM1TnIAjvr7v3sYmhVsfEttRP4dtUTnBsqbDkgZPTzJu0VI3H?=
 =?us-ascii?Q?+KKWojgbxW0Mf7Ok4pU51vunUOiOch1xL7baj1RSHskzVyqOr7yyFxxCeznl?=
 =?us-ascii?Q?INotrB08w7b8NnIcBDGwQ1Udjegs2voJu71d4S4qM0yyVX9Kagz6mqgolDEp?=
 =?us-ascii?Q?dXPNx/cO2yzOS9Yw+17j8Ts3jj4+Q7swkAKSpxbcw+ueGWiPnMnFi7aILuqD?=
 =?us-ascii?Q?FUrLSpkwitEpvmuKzEoMNNQFOn5biuP9goV2Iwq3zBFAJS4Mn4riHjYmnMSb?=
 =?us-ascii?Q?XpaAsQUsjNbCCzBp5VRD2Ue2quQNOLBMDsNSLQXjJT5+WstsaKF8TkGqt+0S?=
 =?us-ascii?Q?10ikkistwsnXYd4iD7RZ0ix9G8HvYrHL7daLU56h3HJYggP0DdEY+EAKSQP6?=
 =?us-ascii?Q?isQ6H/sgL9R86LUgTpvqQ5ZhQSB6qpqKbDqMm94+qA+vx9mEv25v8CHKwmuh?=
 =?us-ascii?Q?yRgUAChq4qqxPW7lBVkUuVvsDhA6aoaDnbC0aXkBbFVXKh+OSW+9S/IgXRn8?=
 =?us-ascii?Q?SCzhpYtZeZVO2LjgMLHavZprqGoQ0Cyquw9I5wEtZCTucNq/vzupL4HM0Q/q?=
 =?us-ascii?Q?OYzGUTJLmdXkY4LK7siqv2rZh57Cg+U+UBhXiPdjzmwZVAFOHWWHUT0AGWTf?=
X-MS-Exchange-AntiSpam-MessageData-1: 1TZVw71ntNsfhu9pdniwgqLexaJ+f7STVc8=
X-Exchange-RoutingPolicyChecked: j9yPvXxHMNz3wM5YUSB+jlikLF5DnNKoqVluFHPPbt7uhi2gLKdXrp0SXQhFw/sT6Qtpuah4OmKGYBmXFoABoiq431evHYx2IYVRI3u22FCcT+v8rPWO/3XZRHabWtTjGA0lUWzXEfkQQwORzakvseYUpXpXxkfD/+1Wm0KRxKjBzxvAS/5RNo7Ce4yeJZIDaeVVFAbv13gMfAN3aX6gRETFudiK9VMapG8wWg/uyvwRoh1N3HZ2OMX38cSPpNvh7BVjKDC8nFGXThLWGnG84aUfGIwpiE2EBcOiNiPKOF8g9ay2NibPUrky08ikbmEYp8ZYoO/7aM/68QmERwZHYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c193be-d1d5-438a-6e68-08dec08f9fce
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:13:43.0123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0pmfUWcBAdWqfpgzm8W957/YJnBm2LwFlOQb42yLzgLW0m/8WjzWGe5vJr3zOeIdXDD0Vh9BRY0VXkzQnN0mbdUSapdgrlV4POpZBVsHIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7819
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 55BF162C8CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-294134-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Mon, Jun 01, 2026 at 03:22:17PM +0800, Jiawen Wu wrote:
> Implement wx->do_reset() for library module calling.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 -
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 37 ++++++++++++++++++-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
>  3 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> index b2e191982803..1960f7154151 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> @@ -59,7 +59,6 @@ static int ngbe_set_ringparam(struct net_device *netdev,
>  	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
>  	kvfree(temp_ring);
>  
> -	wx_configure(wx);
>  	ngbe_up(wx);
>  
>  clear_reset:
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 8678c49b892a..dea6dfb043f3 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -133,6 +133,7 @@ static int ngbe_sw_init(struct wx *wx)
>  
>  	wx->mbx.size = WX_VXMAILBOX_SIZE;
>  	wx->setup_tc = ngbe_setup_tc;
> +	wx->do_reset = ngbe_do_reset;
>  	set_bit(0, &wx->fwd_bitmask);
>  
>  	return 0;
> @@ -423,7 +424,7 @@ void ngbe_down(struct wx *wx)
>  	wx_clean_all_rx_rings(wx);
>  }
>  
> -void ngbe_up(struct wx *wx)
> +static void ngbe_up_complete(struct wx *wx)
>  {
>  	wx_configure_vectors(wx);
>  
> @@ -490,7 +491,7 @@ static int ngbe_open(struct net_device *netdev)
>  
>  	wx_ptp_init(wx);
>  
> -	ngbe_up(wx);
> +	ngbe_up_complete(wx);
>  
>  	return 0;
>  err_dis_phy:
> @@ -503,6 +504,12 @@ static int ngbe_open(struct net_device *netdev)
>  	return err;
>  }
>  
> +void ngbe_up(struct wx *wx)
> +{
> +	wx_configure(wx);
> +	ngbe_up_complete(wx);
> +}
> +
>  /**
>   * ngbe_close - Disables a network interface
>   * @netdev: network interface device structure
> @@ -590,6 +597,8 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
>  	 */
>  	if (netif_running(dev))
>  		ngbe_close(dev);
> +	else
> +		ngbe_reset(wx);
>  
>  	wx_clear_interrupt_scheme(wx);
>  
> @@ -606,6 +615,30 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
>  	return 0;
>  }
>  
> +static void ngbe_reinit_locked(struct wx *wx)
> +{
> +	netif_trans_update(wx->netdev);
> +
> +	mutex_lock(&wx->reset_lock);
> +	set_bit(WX_STATE_RESETTING, wx->state);
> +
> +	ngbe_down(wx);
> +	ngbe_up(wx);
> +
> +	clear_bit(WX_STATE_RESETTING, wx->state);
> +	mutex_unlock(&wx->reset_lock);
> +}
> +
> +void ngbe_do_reset(struct net_device *netdev)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +
> +	if (netif_running(netdev))
> +		ngbe_reinit_locked(wx);
> +	else
> +		ngbe_reset(wx);
> +}
> +
>  static const struct net_device_ops ngbe_netdev_ops = {
>  	.ndo_open               = ngbe_open,
>  	.ndo_stop               = ngbe_close,
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> index 7077a0da4c98..4f648f272c08 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> @@ -125,5 +125,6 @@ extern char ngbe_driver_name[];
>  void ngbe_down(struct wx *wx);
>  void ngbe_up(struct wx *wx);
>  int ngbe_setup_tc(struct net_device *dev, u8 tc);
> +void ngbe_do_reset(struct net_device *netdev);
>  
>  #endif /* _NGBE_TYPE_H_ */
> -- 
> 2.51.0
> 


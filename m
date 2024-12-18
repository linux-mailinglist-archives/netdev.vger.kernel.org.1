Return-Path: <netdev+bounces-152964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F569F673C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1597A1D81
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24171A7249;
	Wed, 18 Dec 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGy8p62Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9711ACEBB;
	Wed, 18 Dec 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528341; cv=fail; b=mOnV4DeizpI3aGdu2HiGukbOOoYrqBflW3I9rsRFZM+DkEU7R36boqXST0HA6fH1Xgn8DCaXt0marm0cvxzI9k4LYPZ0mQCCfEJ2N7BQBRMEHE640QPp3jJzbgsitLdYsJx3WEZXyLWdXoVjq9bphMcBPQA2Mub3TKoHvI2XNZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528341; c=relaxed/simple;
	bh=+8tTD+vjnytxp3uzVxr/LM4Jebv5Jpsi2SgFXRXkGkw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KA9j+FazpTxg4jA6e2Np3QdESqR0Qe9ZoSl+172yLIive5IF999OfmTfjYwMuH+G+2B8KNTY10XUj72gK6mY+9wPedV9K0bbWdBekBwUJcUkDa4+XoHbXLhdjB5oFuLn5OnBgGFAyBuLMs/Ppb8dPe2ZYs4hvp9x4R5C/74j8E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGy8p62Z; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734528340; x=1766064340;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+8tTD+vjnytxp3uzVxr/LM4Jebv5Jpsi2SgFXRXkGkw=;
  b=LGy8p62ZB95H9T6eFgRtDSw5GlmN7qRcih0aorCmcSxIyr1w24D6g2xZ
   gjEdIHHRaEutAAv5blU5CnP1MaodtIYoWPWzq9QRb4JpbLQbLx3LnS7Gm
   +5aF/U3Gz3R+n0UyWn23UkmgAuyqHQ6lNACTdQTqhADgUTuLSouDTgQQJ
   m4quJcElPVvxu5tMoxBV9HJ4FMzGF5s2tuvAMy8fOzqkfwDPsWB+dA9CJ
   U+eB3sIaVVlgJLEz4rgqzOmyPvKDtEw9p9H3yC1L0jorg0tbO6TPDx3dt
   2Ry6ecnQ8M+9Pamn9ahINwsbxr7FWYAtj353WOk120S7f+QGfeul2yqZf
   w==;
X-CSE-ConnectionGUID: glnHUxTJRb6q66su0I1dLw==
X-CSE-MsgGUID: doFbWJ23QS6ba5pYOVTXuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22590695"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="22590695"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 05:25:39 -0800
X-CSE-ConnectionGUID: lkfV7dKvQ1a0fCNP8I5lZg==
X-CSE-MsgGUID: OWoVDty6Sdeb9/QaVm62mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102475853"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 05:25:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 05:25:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 05:25:37 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 05:25:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOiesSuN1/g8D6PcKJJGPxyTjFLrxhiJSy4yl1oScTPjlnBY4lzJaYfA70MmGowimyFOiXARzbm5yiImpARVqe+vvvdylRNu60TZKaIZAiAuUw0xgVXT/XnuJaVm4AV8AtmmiGmbUGX1akytRfSLaDXjkLtko6P1ve+z9sMocEI2g9BUdubDLdy25j3icgLvCwNSup+q4EPgVK3D9kddE4YwXZwNgA89mYBT7YO0CjgbTp7FWS8TsYSmB4uv/qMSnLMRd+TIXDesyOtb0o9jm5pFyiNtsrNFKbVg5U1RBkhqEIA+xViKC8FUxHHNcb1XBcQqk8J7efn2+ouI5+y2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iET/IY5Y00cQmYH4bMjCY1X2eWZwBM/H5CnOIy38WkE=;
 b=MXozSZSkgK3C6zCpM0jaE8BvRGXKcHzFHll2TIFzaZ2urOsu+6w4bw2AKVT9Awx+kc33Xiyu7urRwhb9QpkR2f+gXgPVxxu4ZJVepjPialdqaPZwv8DomR4PdTbGCl92nYLxGGG51TgJY3IH1DJeCgIjYHfTU3NXdwkxFe3jSl2VZZVek2appU9bt97yEZz15on/Rj9DLwkeMgUf00MpO04XMCMEpXLndimQLxMD0/slHeoZeWuV0BwgHhQaRqLcFXKM+b8KeTicrkbNdf2TjFSa++deTHOiB2RtSYNWoz4bUPiqZrE39nLCS1mPISLfMdg8F7YJO/+yKeQEym8hGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ1PR11MB6299.namprd11.prod.outlook.com (2603:10b6:a03:456::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 13:25:21 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 13:25:21 +0000
Date: Wed, 18 Dec 2024 14:25:12 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Shinas Rasheed <srasheed@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>, Vimlesh Kumar
	<vimleshk@marvell.com>, "thaller@redhat.com" <thaller@redhat.com>,
	"wizhao@redhat.com" <wizhao@redhat.com>, "kheib@redhat.com"
	<kheib@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>, Veerasenareddy Burru <vburru@marvell.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Abhijit Ayarekar <aayarekar@marvell.com>, "Satananda
 Burla" <sburla@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Message-ID: <Z2LNOLxy0H1JoTnd@lzaremba-mobl.ger.corp.intel.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com>
 <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
 <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com>
 <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
 <Z2GvpzRDSTjkzFxO@lzaremba-mobl.ger.corp.intel.com>
 <CO1PR18MB472973A60723E9417FE1BB87C7042@CO1PR18MB4729.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CO1PR18MB472973A60723E9417FE1BB87C7042@CO1PR18MB4729.namprd18.prod.outlook.com>
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ1PR11MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: f5759368-893a-481d-f414-08dd1f676c2e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80Ky1/b50nq0lKAHbsElQqdunGOXx9FgZ6yzUmhwAGYDQ+X+ofK7j1jg6pzs?=
 =?us-ascii?Q?G3E1HVRLn7mYzgrIf6Bv5QEhqddHT8j/augHBy4Oa7qCX0+L0P11QE/BGxli?=
 =?us-ascii?Q?6Nd3HkHQB+2EWlEV6caeMBtEO0wIKkOtNoRMLEm1i3jNuAqvTPwKklxrcl9u?=
 =?us-ascii?Q?2E0flW1d5Uzc9g2aA+QgUpN9bSGede+UoFV4W79fkm2PpnPiYFo+AW0nmVi0?=
 =?us-ascii?Q?IkA5P7Rlr99pQFoyuDlZFaRIjqaN6GzT7eUPh2l77ZdIKDiAXDg/Fy7lwX7Y?=
 =?us-ascii?Q?9PCuL+JSSlO6JgrpZielUIQyj33gl69LLXegV8miFUdnhqElPoY9CsMmYNen?=
 =?us-ascii?Q?1eFrn4RJArnHoj6XJI/4Mmpdi6Da+DIvrOQAze3nMU35OVgvRjPwtaLQVkxI?=
 =?us-ascii?Q?/Gw2cuVTO9OtsIYBrQeDNmnIpJ0I+iKofu6rYkipWoGbjmeEUr89ZBjp5+Jv?=
 =?us-ascii?Q?JpyXho5BK8ugU5zu5KFl2+5m9konlNwgr3y5vz1NGcYdV31mESoEd9aA1cG4?=
 =?us-ascii?Q?9uCyyG5AU6Sbtnnr+JOjIw1JK931SDMvOUp3ANMBpNY454q3q29zlU0ld6CL?=
 =?us-ascii?Q?xdF9ZOBxn+L5Da+GGjdVQExJ/HKRyW1kLE+Pyge94+gUc3Kw6pf6xOmhkQEN?=
 =?us-ascii?Q?7aS+Bxbpd/huWdNU7d1k72WJVui7bqffV/zEsKW00x5L7WmIscttgR/DXStn?=
 =?us-ascii?Q?WoGVVRst385IzkMnulu0uJCQbEmHBYiEhdl4IkFuNoYJDay52+hmtR/Aqj9R?=
 =?us-ascii?Q?O5TKZZVxnJtVitGyw9NdeCYX+7uIKYeZSXhKwu9Url+4/XEJ7UTYA7w5J6TH?=
 =?us-ascii?Q?1hZOqFq3zhr8Fc9FUdaScWtdUakbsTk817Xf0rzv3J+qq3NkhuM+J06tLuv1?=
 =?us-ascii?Q?JBnDD/zMmqPsYE2xFmpKNMu/ZHwT/Rp9gmhwrvc8e5+6nyZCNOJkhnckCv30?=
 =?us-ascii?Q?G38b2clQDNEVRIGsN9Ju7fP0QCKhA4nLIovNfjCwmKN1oeDOwkEmzk4WGZ4Y?=
 =?us-ascii?Q?84Ptk7itM6w9txlIqo22YRErKaDUiTUi9TtEfizATLoOMZeqa59cY8p5iiWQ?=
 =?us-ascii?Q?Ll7zN3dOXHFtHo2W+jkUyUzPanN7wLtHR+g5sdLl4o+t1pC6e1eSk75rY9v4?=
 =?us-ascii?Q?RxMxj1LlUmJ34TyBpZk2dbBvi9yEhsc9NqsCaA7fpx6AHHOJXxF3IPvJGAqQ?=
 =?us-ascii?Q?pbGugfbT4D2GFmjjodWc2KULeyhxBIl0Yb8B8bM0CNyl13yR1zwUZyzDnXLq?=
 =?us-ascii?Q?b3obT2000ym2alcltruCTw0koShQQfG4s0y6XYYm88iUZR+l975TOM0q5PiT?=
 =?us-ascii?Q?eHiKT1RJp0zo7tiRjUl74ytMRtDGoHn/BWsJ2YPF3M2Wug=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lz9f1Ly2obihyiqelQZc31o7vA7jugY8nHwr2PvxXShbzk59RMoMN8zx7N77?=
 =?us-ascii?Q?BKtlhFPNfs7m1ufvP/cR5DNHX4YYkFj7Wy6N0Zch8ccKmHZxEglz8pybb0t8?=
 =?us-ascii?Q?EGVYBdHFStzmjzwZShRSn03FoWNSRJRXe8Judc602+5V0ZJRQQZOlYBGLBMl?=
 =?us-ascii?Q?/0rMxS/gw8FiA26NAeGKNFhTyhEvGRDZq/fpGV+wRuRmjWlzhlAWRUhf+mvV?=
 =?us-ascii?Q?R54i7TazBks4zUSzcwmwvKlOB1orwNrHHSEkwxAaSx0CjDcBB1ct70P4Xafa?=
 =?us-ascii?Q?M9H9RCoc9hRTzONfIw7A+2YI8BqsdSDxn5oysJudjkHINyRCRk6NEE+e8q6R?=
 =?us-ascii?Q?5O1KoJCkB4nGaedIQzgbR7vBZT4geuqszK2MRNmqZQBpDZ7RTU7mebCmAcBf?=
 =?us-ascii?Q?VGMPLXJlxDC+r4yLSfEOxRE2mUfyHNoFxzQ2yaCEIDEwrBkBNnqCMCN5EYR+?=
 =?us-ascii?Q?hLyksXCWqtKI6AuBaCY6cLUr2N6TA/uWDifB5xTvUcBHHZJLg8AXsaGE+CMw?=
 =?us-ascii?Q?gUjpcSt6J23+I9YNpQxdshOy2aAhV4eiNlv+itlndcw7o2BlcBTeeQ77EZQa?=
 =?us-ascii?Q?HH+d5s3JgUv6js2N4dWQnf5N+7AFnrVVLorw2EpIwBpwq3EU/VIeAf1dTDhy?=
 =?us-ascii?Q?lM/DIHo1/P3ZatOnGcgQgUdZLYTPdfjYp7hjWBGbOyrsdFP2KELNVMyzu5CH?=
 =?us-ascii?Q?m0zzi9seAlq/Xr+LYGZPEyxRRP21gWd0h9E6PZisxnJotmPtypR3bZpCCdPl?=
 =?us-ascii?Q?UNbcL5/Q5YMzBILhfZubkmsuK5CcSpPF0LfsA4imFcRxAJ6v5VGCRS3KD6iZ?=
 =?us-ascii?Q?bt2Id1LwFdEtahYFUA/YWAghpZd85PfkyaBNzJ3DInC1Ok9vnSaP1xBKYyuN?=
 =?us-ascii?Q?b/MoaEwAnEnG6owvOAVo3yo7N3xuf7NGJwgRhjM4XHYt/wY2LAOT8QY/UF1v?=
 =?us-ascii?Q?ePPqPJYW5QyaidAIWswks6hvsq5RAqyAmFEdLYBx5A0dZjYz5xnqMJfyT7bg?=
 =?us-ascii?Q?4sJm2iBuXIvVr8Lsuo5a3dK89O91nF77TDMU68syRPKYy1l98krsyUz8x1HI?=
 =?us-ascii?Q?dma//a2R+0pj5+5OzqaQJP1a4f5eN1KnNVyKR8+8gj4O+ouio9H1tMPjxBpt?=
 =?us-ascii?Q?UTDIUCeda+OK1kxmzZRVOcGpDWXfCyCCyVOhClFuGgbY60FZkvAt1KktUYaM?=
 =?us-ascii?Q?EKc7nAqAD0XXXMq6L27o+j0Reosya148bFOvonNBEhap22gnbl6XooHj5Y6A?=
 =?us-ascii?Q?nTj+KB4XsRLyVEbF4qfWaFkjJte+HnP8/M/aSZr1nCYN19054MOCVb323sDj?=
 =?us-ascii?Q?LO6zqDnIL3ZAT0o25O7HlmpZcDKDmLotWgba0AVgGYlh479nmhgXQI/3Inqr?=
 =?us-ascii?Q?3C3NEMAHbs+pKoIDVKlou3FT0TiVmTifBuftAjBNjDTYzHb2TSw2kEz99YqS?=
 =?us-ascii?Q?/7eCoO/NaazxBuwbCmmj029aWlabl6RWBDloq1zZUGqpiaNVazH5sWDxTG6p?=
 =?us-ascii?Q?Y2EP61FEa0lAfewiLaq/i66D38Ocr799kV1yEQgpTyzLRotA+fwNKNVnleB9?=
 =?us-ascii?Q?NgLj57P+YilVzyCoMpXb8CUSUV7Dkmi+AIVJuIe6OmYSBMNhHW1911u+5X+x?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5759368-893a-481d-f414-08dd1f676c2e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:25:21.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASP6My4+ciMREcY+cwsXaUoXsKp192VdX6+/50WVxdEyy+FVA+tPwOiGZyZI1XR1OTAJ/YYG7x4UpiWBnIMC1G8tghmrG/70gaZ2gWQgzF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6299
X-OriginatorOrg: intel.com

On Tue, Dec 17, 2024 at 05:49:13PM +0000, Shinas Rasheed wrote:
> 
> 
> > > > On Mon, Dec 16, 2024 at 03:30:12PM +0100, Larysa Zaremba wrote:
> > > > > On Sun, Dec 15, 2024 at 11:58:39PM -0800, Shinas Rasheed wrote:
> > > > > > ndo_get_stats64() can race with ndo_stop(), which frees input and
> > > > > > output queue resources. Call synchronize_net() to avoid such races.
> > > > > >
> > > > > > Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
> > > > > > Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> > > > > > ---
> > > > > > V2:
> > > > > >   - Changed sync mechanism to fix race conditions from using an
> > atomic
> > > > > >     set_bit ops to a much simpler synchronize_net()
> > > > > >
> > > > > >  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > > > b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > > > > > index 549436efc204..941bbaaa67b5 100644
> > > > > > --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > > > > > +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > > > > > @@ -757,6 +757,7 @@ static int octep_stop(struct net_device
> > *netdev)
> > > > > >  {
> > > > > >  	struct octep_device *oct = netdev_priv(netdev);
> > > > > >
> > > > > > +	synchronize_net();
> > > > >
> > > > > You should have elaborated on the fact that this synchronize_net() is for
> > > > > __LINK_STATE_START flag in the commit message, this is not obvious.
> > Also,
> > > > is
> > > > > octep_get_stats64() called from RCU-safe context?
> > > > >
> > > >
> > > > Now I see that in case !netif_running(), you do not bail out of
> > > > octep_get_stats64() fully (or at all after the second patch). So, could you
> > > > explain, how are you utilizing RCU here?
> > > >
> > >
> > > The understanding is that octep_get_stats64() (.ndo_get_stats64() in turn) is
> > called from RCU safe contexts, and
> > > that the netdev op is never called after the ndo_stop().
> > 
> > As I now see, in net/core/net-sysfs.c, yes there is an rcu read lock around the
> > thing, but there are a lot more callers and for example veth_get_stats64()
> > explicitly calls rcu_read_lock().
> > 
> > Also, even with RCU-protected section, I am not sure prevents the
> > octep_get_stats64() to be called after synchronize_net() finishes. Again, the
> > callers seem too diverse to definitely say that we can rely on built-in flags
> > for this to not happen :/
> 
> Usually, the understanding is that ndo_get_stats won't be called by the network stack after the interface is put down. As long as that is the case, I don't think we should keep adding checks until there is a strong reason to do so. What do you think?
>

It is hard to know without testing (but testing should not be hard). I think the 
phrase "Statistics must persist across routine operations like bringing the 
interface down and up." [0] implies that bringing the interface down may not 
necessarily prevent stats calls.

[0] https://docs.kernel.org/networking/statistics.html
 
> > > Thanks for the comments


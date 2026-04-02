Return-Path: <netdev+bounces-274480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENaYCAtRzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:20:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374C3883C7
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34B0930A02B1
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164153BE637;
	Thu,  2 Apr 2026 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fm+8TFVu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF1C3BD22C;
	Thu,  2 Apr 2026 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128377; cv=fail; b=PNuXC07wKpa/Q4aMCzrigKBPOh3SN49QgmsfMvcXfSjf1VpeITSaLZxcU4vozzuP3fqyoyBkGDCsCFv2g2tmMEk8+BHsT4MN7rmfrrRCUA5yt3yJDgU2POvwqwqlC1jjcNvvntGxYVbIwX81c/lEYz2G0s/7dxmSUgMATlib9Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128377; c=relaxed/simple;
	bh=tEzyAi/0oyE47kmddIYgJJzA4UCX9RTVzg0J6XB5vIQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kc50tQCHh8azI+lxu1LuSwx5XXJ8+N+iERow0OIGFmaFhSTVdn/ZRTCyx6SkzJv+rPBWhj/3s7+PKayHpp97/V40TFdIhVfFZjJl370P9ZkA7RFLVYidpYhOi6ngg0RhoQzG7so0GV5w3cFBlgfFQEcaNlZkNZ8pYZcUyb6ljOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fm+8TFVu; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775128374; x=1806664374;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tEzyAi/0oyE47kmddIYgJJzA4UCX9RTVzg0J6XB5vIQ=;
  b=fm+8TFVuzMHpNaVVfG7suaURFkxPue9z9r/t0in/e8pPu8P3WVC9xehH
   /Qq/d6ODwkqk7AwCIzcoYLQpq9jjG888o6Hk+i30Wss8QtYK6i3jbBRMm
   L2C3oX/Mhjyy0NxRxPqKCQ7LiFcbnnHn/crYD0lK/XbAJx+tnZbcROOwo
   zt/tzO86VA5s/JaG6+E23wkqgEQQ7ldvYhFpPBTwICCScbJfw/XJ1bXz9
   ZwrXGWEuwSHgmcZwfZIjSBCi7aOMNtyRPdKGEQcZscUGadvyDI8/+OeTm
   2rwjqADWjhVtsYHzssSe9+a1P2mP+ouY+jpl6vReGofCGlSmLHmAyOp8n
   A==;
X-CSE-ConnectionGUID: VjqzmIDnTQ6/KmXuasGI5w==
X-CSE-MsgGUID: zMiJRCkQSzCCqDeT8ME1ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="63735229"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="63735229"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 04:12:54 -0700
X-CSE-ConnectionGUID: L2ZDNXS+SimsvPkLr/0hEg==
X-CSE-MsgGUID: imDpeQiWTXCySPXsqRQ5eA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 04:12:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 04:12:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 04:12:53 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 04:12:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keLqs1zaf7wNbxEnCgcX52yxODsf4LtIbOc4GqmX0KQKYLA300A/7pleWaQeHUhHibB7zhVSfT6zYNnWMV9ncCkXTMaqzq+qe091qh2bhbXh3VaA8+FQT33awUoY13n9YnNsbEuDpte4HwMd/NYfYwa2ibA6JIJnIHm85GlgysLy34fpj78g2oKes800m+dAFccpOOUs8tPQXcylFp5W4t4PSzHnLWf3pVCy2C6xEoUjbv4Y5R3ic/fzzeDSuZfAZgAE1C0P9ku1SWam9piceXvrDt2TCK9e911ByCIpxyCsnxYfaWw/ZlEX/c4Grnhx8hBIoNXWCuJ0IG+Wjv7oJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC2/PmtGCQdQpzYXKkhz9pJqRPPj3O64QgwKBHOt6dQ=;
 b=bAk27fQQHqwuUVVovWxcQqFqk2cjYy6k9if/xz2fzq35ccC7/TAPM/IXhEFzL4FUk3nxngYXjKQODaeCOSly/qy45eQ6NHdzKGORqld210Pe79L9qYkdXU8bmWRRBKviR3jsDPdnpgQW8Y5kE8DMJdfTRvoET1Ex8niUZIbyuWZ+nD7VNOIKoAd62oenZ/sZMbiG99U42XIMZ4g9iqXa2qug9Aau/tc6KjZ4bwneEy+QjE+hbWJxoA4ut7F31XqjhDPAtAUq/Egs+ZLMTW4u4b67ZfzGaKR1957n5NRuh3ZgE+PKF8GLbxf0ejDbCXLZwBtavFhFVNsoXX5puuZFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DSVPR11MB9555.namprd11.prod.outlook.com (2603:10b6:8:388::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.18; Thu, 2 Apr 2026 11:12:48 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 11:12:48 +0000
Date: Thu, 2 Apr 2026 13:12:42 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev@vger.kernel.org>
CC: <bpf@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <larysa.zaremba@intel.com>,
	<aleksander.lobakin@intel.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v5 net 00/11] xsk: tailroom reservation and MTU validation
Message-ID: <ac5PKvH7ZGZTT5s6@boxer>
References: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
X-ClientProxiedBy: VI1PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:803:1::26) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DSVPR11MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f3b688-b398-4fa1-624d-08de90a8c605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8JLq6+h5iShLbRVNQt0KhShfzwwFBE+cgdS8h+O0XOaw4HRgNDyrlAur1hTNXiyIdc5ZY8Tzhf6vun6S34LJCGj0NhxMd3ya2JlMK6P7OWVwdNMp1tg2CyqCs3N0tiwj3cWHW0FK/i7yuW6oDwIcX8ZNbKlcpMrgMvzQfCnibGj6fyh6orFytqlbIpfMKnZh3B5XIbUlLZBDbjZ6td5ZtB6mQYKyrqruhw0MTwePG/XAb8BWGsAIP/D6fn7gmbRyVYEbye02kEuyU1ganirWnQ3immol/6QT/M/RyewIOXRzoe6DDxTIo1IDOLSOTaDiNdFuIZLuUcPrkaHI2taSlKti4OkMlj3rp1QgdHRwHV4OBze7h1DB0RMBH05cT99vNPdMRsJgJ1IvxUCx0Db1F0yY805KXojlT3EG8r176XaIkhmNqb2I6ya1VPNBK/D2LVk2vI1+BeJKeGzSngli+IyaHMLu9xdiAvQqoIq8izeda7cwQ7HVxtqqindVSnQILjKkJiFOzkZbhhEBQhvcu1zjuVmo66O7u9bSy8hhiYxcJMWJQn6Yf3vuA2ftI9NXcL/FlsN8BX1116tUIuuHY4X1fqjHi+LLVB/tCRwJrPWqydmpCQgrZ5Mhp/P4SNMW0dEfX99yGI13cOxTlQGcOi6NX3dQp6FX0RrlTAKxTUUc2Uk+FaXOC/I8e0jc2DXOYu4CjXspxdetV1xKpBEUe7WIYuYNu0lHHVQBqZcNZ1UB9yq4Tu0GJqZt6O1IN1ON
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BQ6PqoFC1UQy/KD+BLNaigs7A0R/EVmR4b6lQt8+Af1sDbqchgCdmYsNvDrC?=
 =?us-ascii?Q?KWnRaEVmism/btBCAlXzqaq6vQOjQ65uTvjj7c2thHLLs5oCDHCif9BvRq81?=
 =?us-ascii?Q?Xfr/qH2gt2yR+EsrI9JF1q9Tb2jFtiE364PFKl91P/luYQygv1KNTTq4BWpT?=
 =?us-ascii?Q?cI4SEORQolre2VOjDTGrhC5YNU8SurkgFmv7T536kdo6b3PI1J7dCHOVlbOy?=
 =?us-ascii?Q?A7nhaYVqIRPW39B9ZMT4r5gqdQ8rPl5ETE0JF1W7JnDDL0U0TcKgZ29TNZti?=
 =?us-ascii?Q?fzINF4/cBM+43V/aWEHlDMnRygrBJuQUJFmqbx9UoEr6La50uuTloN5BSmB6?=
 =?us-ascii?Q?32PNXbdd1RK6kYJht2+d8AzUucoxGH3ICJNmhqbO4kXByFH38RU7n7BW5uaw?=
 =?us-ascii?Q?iW4AETKDB1pUgSOtFIV2nxVFgf+qhOyju7RDzXcGzvIm1ONK0244L47S7mBx?=
 =?us-ascii?Q?mx9FnnkdOnAlIxlrZkvfct+TElyzD+D1cSk+j5CicmywP132DNS5ctMWPn4z?=
 =?us-ascii?Q?eQ48Omju5v/9xqFTepddnTHAVGlwUbYSlH+F/iYrXTnz8Xr5DIqe9S1Y8kHI?=
 =?us-ascii?Q?1c+SuQjyEMTCCM5kIz13ZoR4P1izUt2qBzlaYIAme4BC+OVzvVYOtvzAl70E?=
 =?us-ascii?Q?QUWRyiU01gIP7NFnqtP36lBIMEODAxvxsyV1xOOK6fbKYRy4TcKhqbILk3Ud?=
 =?us-ascii?Q?O2Zp/7U67dl3MWbmLhdeQNECdnxBLz800hiyZkOYxhyErIXY1kLFlQymx0nf?=
 =?us-ascii?Q?0jFJFB+K47nPmM2qVEDeE58ovEDRBonYsuWzAieRcUmZPYkyYksVwAVrGGaS?=
 =?us-ascii?Q?wEJcOEyijRWi9F2pUr4OApVFJhYguyCJtvVHxQcGyiEhdpLkgP6yiu3cxb6G?=
 =?us-ascii?Q?SNhT6bA03QMOsniyKpRxsBXf/xiAbi+Gtt8/G/LTHGl6RRvGnq2VaJWqO6rs?=
 =?us-ascii?Q?SjOD/DcgGsQinXpC4lNsnsHQTzUq6ScYVEdkdXDYmiV6IFkkQB00oWG4EHb0?=
 =?us-ascii?Q?w5dM7Cl0atRXobmBordUVI3gEld3ZpKB0idQZJsSUml2kwArJA8UENRVhbnS?=
 =?us-ascii?Q?KRv/UhgGK3phoH3rx7eUJadGkGzWA/cLzKTNHKF4QNlwO4LVWBMgctv9zazA?=
 =?us-ascii?Q?lEPkjd35gHB9awenLdJnEXTsGrXdGNWElghzKZdNIC/ZrZHboUKOuDkppIkW?=
 =?us-ascii?Q?/TXsUT1Ahjax11hPtNHD4MPKxUktruf+MkEjHU7oFCBWTXY0PC9Y/57jR0MB?=
 =?us-ascii?Q?jmKzELMbt7sQf1zGApdsptHu4Hkkt6zqgt62MCcDmbHjPrhMAEBjVwW7fTtf?=
 =?us-ascii?Q?zu53BBCPTex6l9woLZr41kpwtZ8QIiOkHmNjlgq4F6LCz2EGON64wzwS6wRn?=
 =?us-ascii?Q?eO+rwNaEH7LP3PoZKWmCqFGQweL2xJPQ6RW3lQBgKoqEVMf6fsJ2VJtySU5P?=
 =?us-ascii?Q?dYwtFZWWh5pWbEDtfyjmuza5ITV3UUcotALxpSGGijxHZUCDOymCjZfxiyv+?=
 =?us-ascii?Q?ZErDR32w8NFXh3cJFDOXfldVdSy1W8jW9IPkl55nkAzf9zYUrnF/Frke5jjc?=
 =?us-ascii?Q?zvnRMauT/TYHL8lSFY3pVCulpKOE8e36SbOsSLqthggwkrOkiUicgMzWKxpL?=
 =?us-ascii?Q?2CFpBm/XWoiAkzfKM6SXzGdRhdVIpFs5PhkC6jxgmFx5zGfRD+uYpiYnC99a?=
 =?us-ascii?Q?HIPwr0r/x2DMVt+U29vVMOYcac1oWFU+rz9iGDGpRLPGbn/IyUf+NrugLOkD?=
 =?us-ascii?Q?qx9qXISASAqB2xUXRHy7PAtHf7TlKR0=3D?=
X-Exchange-RoutingPolicyChecked: ieX3iX1BuHM1SZjcPv3ADB/2wpjpiCfw41hea2t5fRPyRKDOrEogiz/TLptUH2ib5B85KLsD7rHfqQethOm9befmkk9BUtNeZywzgpFTJrGBIDRLB3rhxGvj7EKSzbs7tXO4wgIeN68p5SnzgV5J8Wf/JFE03HxUNe2w8jO9PlshyK0OS8xedfwgVztlSpWfNhYocNyUmjrcJJQnz0x840PPNIANswr1bm8sNFPrDKfsP5S6Rs0i4cWlTmctVkVRdktCRUz5yBNJt7y3Bhhybrz5eVjKQIipZYmXavppvg1N/99mAd3biacwQorOPG3HwlM3lzqNPbhzGzP5oIoXXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f3b688-b398-4fa1-624d-08de90a8c605
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:12:48.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HECgIa7qlvl9wgaxrX9HYf8u9i4gVS0ahI3kdvMmxbFeRAuiJ/lFnJpw9pMvu9h8SxgsHvsWTd3wO+W1OV1PmO7xG3i6JYL8q/f4kRcu4D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9555
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274480-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7374C3883C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 05:02:02PM +0200, Maciej Fijalkowski wrote:

FWIW I'll be sending v6 as I messed up refcounting scheme on error path
for shared umem. I'm gonna also put on shelf driver cleanups as I got fed
up with issues reported by Sashiko. I plan to get back to it if I get to
work on forbidding mtu change feature on interfaces loaded with xsk
sockets.

> v4->v5:
> - add further review tags from Bjorn
> - fix ./test_progs -t xsk
>  * do so by making the procfs reading common so test_xsk.c can use it
> - get back to idea of relying on pool->umem->zc in
>   xsk_pool_get_tailroom(); that is because we now call its caller
>   (xsk_pool_get_rx_frame_size()) before getting down to driver via
>   ndo_bpf - we do it to rule out invalid setups in terms of MTU vs xsk
>   frame size/number of exposed segments by driver
> - bring back explicit rejection of mbuf && segs == 1 combo
> 
> v3->v4:
> - allow exact 128 bytes of space when user defined headroom is deducted
>   from total frame size
> - provide a routine for reading procfs entries within xskxceiver
>   * use it to fetch cache line size and calculate skb_shared_info size
>     on our own
> - clean up gve and igc xsk pool enablement routines
> - include mtu vs frame size * max zc segments validation in
>   xp_assign_dev()
> 
> v2->v3:
> - add tags from Bjorn/Stan
> - provide at least 128 bytes instead ETH_ZLEN when validating frame
>   headroom
>   * this way we can get rid of i40e/ice changes
>   * make sure xsk_pool_get_rx_frame_size() returns value 128b-aligned
>   * and remove pre-check from idpf
> - separate XDP_UMEM_SG_FLAG fixes from MTU validation in xsk_bind()
> - make drop_idx a local variable in xsk's xdp drop prog
> - adjust rx_dropped to new 128b related values
> - move ugly placed define (Bjorn)
> - remove READ_ONCE when fetching netdev->mtu (Bjorn)
> 
> v1->v2:
> - remove xsk_pool_get_tailroom() definition for !CONFIG_XDP_SOCKETS
>   (Stan)
> - do not rely on pool->umem->zc when configuring tailroom (Stan, Bjorn)
> - simplify dbuff setting in ZC drivers (Bjorn)
> - use defines for {head,tail}room in tests (Bjorn)
> - return EINVAL instead of EOPNOTSUPP when mtu setting is wrong (Bjorn)
> - include vlan headers and fcs length when validating mtu (Olek)
> - tighten umem headroom validation when registering umem (Sashiko AI)
> - set XDP_USE_SG in xp_assign_dev_shared() (Sashiko AI)
> - adjust rx dropped xskxceiver test
> 
> Hi,
> 
> here we fix a long-standing issue regarding multi-buffer scenario in ZC
> mode - we have not been providing space at the end of the buffer where
> multi-buffer XDP works on skb_shared_info. This has been brought to our
> attention via [0].
> 
> Unaligned mode does not get any specific treatment, it is user's
> responsibility to properly handle XSK addresses in queues.
> 
> With adjustments included here in this set against xskxceiver I have
> been able to pass the full test suite on ice.
> 
> Thanks,
> Maciej
> 
> [0]: https://community.intel.com/t5/Ethernet-Products/X710-XDP-Packet-Corruption-Issue-DRV-MODE-Zero-Copy-Multi-Buffer/m-p/1724208
> 
> 
> Maciej Fijalkowski (11):
>   xsk: tighten UMEM headroom validation to account for tailroom and min
>     frame
>   xsk: respect tailroom for ZC setups
>   xsk: fix XDP_UMEM_SG_FLAG issues
>   xsk: validate MTU against usable frame size on bind
>   selftests: bpf: introduce a common routine for reading procfs
>   selftests: bpf: fix pkt grow tests
>   selftests: bpf: have a separate variable for drop test
>   selftests: bpf: adjust rx_dropped xskxceiver's test to respect
>     tailroom
>   idpf: remove xsk frame size check against alignment
>   igc: remove home-grown xsk's frame size validation
>   gve: remove home-grown xsk's frame size validation
> 
>  drivers/net/ethernet/google/gve/gve_main.c    |  5 --
>  drivers/net/ethernet/intel/idpf/xsk.c         | 10 ----
>  drivers/net/ethernet/intel/igc/igc_xdp.c      | 11 ----
>  include/net/xdp_sock.h                        |  2 +-
>  include/net/xdp_sock_drv.h                    | 17 +++++-
>  net/xdp/xdp_umem.c                            |  3 +-
>  net/xdp/xsk_buff_pool.c                       | 25 ++++++++-
>  .../selftests/bpf/prog_tests/test_xsk.c       | 55 +++++++++----------
>  .../selftests/bpf/prog_tests/test_xsk.h       | 23 ++++++++
>  tools/testing/selftests/bpf/prog_tests/xsk.c  | 19 +++++++
>  .../selftests/bpf/progs/xsk_xdp_progs.c       |  4 +-
>  tools/testing/selftests/bpf/xskxceiver.c      | 23 ++++++++
>  12 files changed, 135 insertions(+), 62 deletions(-)
> 
> -- 
> 2.43.0
> 


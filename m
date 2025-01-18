Return-Path: <netdev+bounces-159511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D6CA15AE5
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00266188BFFB
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377681C6BE;
	Sat, 18 Jan 2025 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOBoJ4mr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D368768FD;
	Sat, 18 Jan 2025 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737164256; cv=fail; b=gFvAgakPdiZb8h3n41mQscCix6DQ2cwlsGSJiVnyJbqj4scwje36zcSaOhQx6MluKwJ9XARPHokyul1hv61N5ZvRjWKrsIwe39q1phNelidE6+qxxuHnI5+dPOyNNxgIjS0mZ0VgvzxDh4jP3zaHZMQ8wIjSnHrVxeYMfSQKUvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737164256; c=relaxed/simple;
	bh=lRUxEaCK1Qp38LXDHSVTq6bonxZMd5+oxHvVpDTgg7c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YUKBq5rsRJkkzVAORjo0/g/T2WHIORva38ZN7RsYRWwfcNi7gUelqg86TtcRfQFqJBUa+LmnrZz7RgrTXfwZOAYeuQvIInCu84Wjvbf+3h9ANxGLRAm7EF+vwwA3HHwVpazPoLqt7yEWH+n+Vr064HUQJ11evTf0+VB4jLRzyHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOBoJ4mr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737164254; x=1768700254;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lRUxEaCK1Qp38LXDHSVTq6bonxZMd5+oxHvVpDTgg7c=;
  b=mOBoJ4mrKxLmL2HZ3imovsmE1H1NzVmeny+zStnsWkiv4sYQJ489fiV2
   VO8T5g06WvfPGvOcnU1zvpKxkipf/XNTHVz6hiPZ73Gwmp7qJfyUkHMZD
   KynAva5nE6CzbWTQDC4F8qTyn9Y9WskECx9nNul8xr8qF3Lirh36d/1qc
   6NtzstdxuU7ERELEuDJmyMxR47jf+ucYldUguLc+SyPShzH1xfSUI5fab
   j1oOYFRsqI9Ksivh8Ap5oK/dgPcj+oV4Oe2+qKAu5PpDF1lt3TXY/CKfi
   FJHQXMpu50GG6FYG1fAtQX6V6K4/oVSyvIjMcuM9LafjQ1XcWo7hwkEuJ
   A==;
X-CSE-ConnectionGUID: 7RLR19mHQLCrqPGmrEI6/w==
X-CSE-MsgGUID: Y6cy7q4+QwGjF1mARuYuKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="40421451"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="40421451"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 17:37:34 -0800
X-CSE-ConnectionGUID: s3WGGWh5RruoUNe5Ha+NgQ==
X-CSE-MsgGUID: e5HQsq4FQvug64OPEK4/Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110953695"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 17:37:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 17:37:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 17:37:33 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 17:37:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUyTUnnde2E57PFezmCVBThRjo5rKbs2/Cc8r0W3lluHNVEZiEcAVm4ne8qIBm8a/sBIEKGd5Bu9cIrgD7eW/N1ie6DOU0pl9hQtb6LgKKL2mUJ0u9Obzna4byjHYG3eg6Cbk4ZyjQyO0YrOv3xj9Ul4W5j028HtY0s2MK6jm2O6aYFzg8Zb2EU/K1RGDlJ9FyNnPTJHpSapfMqkYdrGxujAVieJviuQthb4JAiwCPifaKeBMRRaNS2LL9WHoAFIhfrFpjl9YKqaounu3oLjmPR+1IRHVCX8uOk+FkoORdZPsTKi+mbKe6WgJPHkjTw/V3WV4EH2u9lMKFa9Y2M+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiKVPIBTpmUtJfnmOGZp1GKXaYX7xj1Xbq+tFzHvnNE=;
 b=q9/gI1dwRwhF9Q20Bh03QRnIC1A/RIS9CI/FysFjAeuSWjerUHHOBJpWzzVYz6KM5Liak3t5aiOFubmtTtWDUmPMjQWBQDG8LhZEvAJqF7t/yuzjjybD4X0W/H/VEpXKWWDvuFfnpkXwjQfhg9qfFFs79WgIbFfH+TYndTaVOhZWL9yQes/RELajZGiHDevt+uUOOK5EE7I5XlorLcgvlVN+FaL6mUhRv7pVSf+cIU8LhJ+WFLjr6/WJrju8A7xZRwdkII7VXbLHnO42AvDyoK6NYNlxL1cS6lavOngrsWHky0L61pVCixcEEpMZhPTB7rhooUrXTKe9HmM8AKLAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Sat, 18 Jan
 2025 01:37:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 01:37:25 +0000
Date: Fri, 17 Jan 2025 17:37:23 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 03/27] cxl: add capabilities field to cxl_dev_state
 and cxl_port
Message-ID: <678b05d3419d8_20fa2943@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241230214445.27602-4-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 14beb944-4c73-4ca7-ddc6-08dd3760a958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w2kLad3tJutiOLtutC3lyMccxD4HmOmKhAQSy1+GGBj4Qs1Q508e04uNvuQb?=
 =?us-ascii?Q?N5EtK1jacTE4GNy3LhMLzrhXXUPHkSWfvT1XzAiXjUJdWtoe3k2+kgl3P2JN?=
 =?us-ascii?Q?9fQ+LQwC5O9uRe0XlQ3PKUMqRjPLWGZqiuh3WtSTr7YyjAm+6T5mFeNjH+vy?=
 =?us-ascii?Q?xPXKmofFNQEglsBVZp+rxObX8f0J5VEXbT0REsVyWhRb2ObPeGGvyEVygisJ?=
 =?us-ascii?Q?jZ6cCTQsx8msK38W6ZM2tro7gpwMvflNhqZKpJlRlBT+bT3SCpoh/7hpSBzC?=
 =?us-ascii?Q?N/k5RlzmGOGIMWf21i53HxW7+8e0C2DJ+p3aPRiCk2lyjqFkTwJun3i4yI/n?=
 =?us-ascii?Q?k2RKrWO4tfTBzL/xz9BOGfpsVcVlwcfTsmYQ0jhiUwFjUkxlEwAb3gZJPJgP?=
 =?us-ascii?Q?I+Kqm4Gw3Zj8HKBtLHEo8QwvU/QY44LFnWKiPpKVIx/k/MkBP1R+JrGI9EvB?=
 =?us-ascii?Q?HWsUHdRjaYA93VUuP7Z/PwtkuYP6L3aQ1LobxwES2qKtr82QGuc1iFbFgc4P?=
 =?us-ascii?Q?xD4VUtcwHbZaq5bviLcx0Jc5LcE/98wtR+K1Cf9qRKDXf2N9DG7PmnGZdYcc?=
 =?us-ascii?Q?ymywHFhvEH/JbJLyY6pDq+KGvOIYHqqs5jHlad4rKKHKL+7OLSanJqBkKoc8?=
 =?us-ascii?Q?tdj9DQ8reTuyDG1icR9DX+viQ6F+VPz4eFqQbGFr2pihDROq7Z61g+hP51po?=
 =?us-ascii?Q?BpaSOX6qZCSy2GXWQBpxzDdFoBYXOQ3PtNilQiGHwT9YgnDjLvRQnn2NaBR8?=
 =?us-ascii?Q?lfEXarkHp0iB//bU92Uyxe3MbPGSE8+CKsg/KvdrdhS00O7td6+/q+3VGws9?=
 =?us-ascii?Q?pROeLUeKRRE7GqEaxOvkyVfgCP94JAEu/NBVziJxzP1muwqV30fERWA36V1g?=
 =?us-ascii?Q?xXuJjpXD64VbRUPIkGZHJwEtUOJ+OgXPFwkfUUow5DEcrhx51kThkOS61yFz?=
 =?us-ascii?Q?g2Q38+a9fj33yCUjvbA7c7Ryk5RaO7hHVgK4jAk7a3/8Rp2gPLstROkuFheh?=
 =?us-ascii?Q?hkNYKoSE6Vcmc85qaimH+ikVVyBUQmE8cTXZ0o7L9IZrAbU+MC5RCGxDGRPE?=
 =?us-ascii?Q?Ihh364ZMg/hfJBS1Bm0VgRYpnESjl8f0LqJH3GIik/gxqrm+FDMTNEomONUj?=
 =?us-ascii?Q?7PlwVJfc83jQUYRN1zSSTpGXYeYr834rGjLwn9XKViyy92E94ruy4IC0HaVI?=
 =?us-ascii?Q?dabNFuVsPyTLxVAjWVlmoW13lX4PJLVH3Mzmy/WAHExsNwyFv838vZA0EHVE?=
 =?us-ascii?Q?OGvEqJXaVHF54TgPFmYSA5D84yD82c4GEAVTs41L19sJNDWYmVlTAHv42tdK?=
 =?us-ascii?Q?uz2i11gsfrYtFAVx0ASomcZ/MZpuJQsECJYdWbtkxda9MKEy/bUIUd/cRnIm?=
 =?us-ascii?Q?LmgOqRiLQB5mMEPe7+5HMrdw6Zjg2uXC7t7wT8+P7/ySWSkxxMJM3pYHMI1n?=
 =?us-ascii?Q?J9kRhLCBtOk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dip2X0fb1Yn8Vh9Fqw7OEsp1/AcPgV+7hNj3Uf86SQUnp5He14yxp1A3CPuZ?=
 =?us-ascii?Q?4eBWMwyJAiB+cTyyoIzp518zzTUEuKgJQvd9qTkArdp4LOYXT1fK6pCqmoav?=
 =?us-ascii?Q?MdZSiJ1YJ9RKeNeF8wBWZeLHBCoBErvCUEBjb0W9YobS4L79ozCqOjMHeuYO?=
 =?us-ascii?Q?dvPgRH/oPqWjVE4wrjZe9YxRix6km74ZHMiLx12d/oaoF/qc3+QMaAC2R2/5?=
 =?us-ascii?Q?MQtmdXj313GCxeC6qJw/aQkjgi2MyhuqAEMw+ETFrTooYgLrv55LGhY20b6b?=
 =?us-ascii?Q?CTpUDFZj1aGxJtgDCcMnbnnhI11jPuEAgHLT8+Tfub+BA9Jy/F2k9dMPnMIC?=
 =?us-ascii?Q?mZuPFAGgGT8XNK1gruhAaYUEZiTz0QdFg9GEy5eby5G5d35rZSkJK8orijPX?=
 =?us-ascii?Q?0iBkpM2BHFwBCsmiX4x6NnUctVPXIVdPvWy3IwyCjihG4JdWWXCbAAsbGrTz?=
 =?us-ascii?Q?KAB1/Ucutjd/iHNO/be0lxxWR+C7w5QB75WI1bn5vrMIOu37yCUG/4VbTSti?=
 =?us-ascii?Q?vHa8pXSqJcwohDyB096HfJcYV+vkE2p2Xicn/wqovL+b1bR1FGb/BZR08gFk?=
 =?us-ascii?Q?2YVB8K52HwyEp6qwZKYsVJytBDSxN7ZFrCu8GfMghiSKmkXxGWFYLglYbvfq?=
 =?us-ascii?Q?OtoqK0vLU0ufQpCE5e5JkLq1limNxIx8NS6Z1FZrTxQFB3WXKaT2aH607FdM?=
 =?us-ascii?Q?+Kxckgf0pDJ8b+NjKiitC76jkvNRFXavqxyfsc54VQ2mUXWE1KqG1losWry3?=
 =?us-ascii?Q?F1z8bmzUYOvfSH9mlCMNkWVuG92n0e8s1vNwROpCLNKElV6if8c9R6xpngr3?=
 =?us-ascii?Q?/AxYVKpCExmpIBWy3CNNRk2lp1nHWz9fwUXTeZ9hH2O9131+cwUDemjYVAQs?=
 =?us-ascii?Q?gYV2crbQvyang02Qb1gUEk1cvV852Q2ME3fS0z5m288g1aC2/KjGFuqVc6fj?=
 =?us-ascii?Q?G8BLC4d8ZJdPPsKlo0dXK1Y/qBceYD9YtCzoKc3qofDGQr683KksFpnRtdP+?=
 =?us-ascii?Q?w0yZypWED/9e4bZPzue2Iy+iKKynryRc3YpxqBtMb41wBc/VuVIw8vNfJGlP?=
 =?us-ascii?Q?WjBSoHcP45iAIyWvZrvJQTUy5/9AhUmfoWq/eIkhFFrB5vFZ9+iY2o/Oh9Fg?=
 =?us-ascii?Q?lGTh25AKUK/YQB3and3x5OYk9jUdAfxAxvWDcSoDJwSmm1V5MBXCYxYkl1KQ?=
 =?us-ascii?Q?gleTCwppjaH0HJB70SHTbCef0kogD9eiyDWQs/QVRuNOEzbp6rrhbnyrcPM6?=
 =?us-ascii?Q?TsnNl+/52JnyHHZvy1u2shGY7dAfxiJrRDGTP+FRrf40oq3hOU+pkHcZmdJJ?=
 =?us-ascii?Q?TVBxk22NfbXpSZSrN/vwXwPwtFUA1iEENF4Iho2LdQpdRG04GbbSkm+dW3iP?=
 =?us-ascii?Q?BtsPpEi/D27xHTva/9Tp7HMNNymGx5o2z6kouxWK58IiNJL/h+LbUyNjzRGt?=
 =?us-ascii?Q?R8ChyVb2V4y3cFPQi72h8Pmwio/w5D1fVUfitbDSMDI6SXeHp6VAuC78WkDk?=
 =?us-ascii?Q?jdrgEaeoMkiRXf7csQGujJ0iXMG2V0uGETe96i89ESgyq53omkJHq9tLQGaM?=
 =?us-ascii?Q?37gBmVC9cX1h6IeB4VAtxGMKbsKtVn/bb112rtzlR3G9cKAylelAdTBI2nci?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14beb944-4c73-4ca7-ddc6-08dd3760a958
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 01:37:25.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyQA9s6wVKj7g4DZeJlHM9JsG+AFrrBGKlNoJdAiYwgiPXNpQKlN5Gb5NhVbYgAX+Iw6WNIyK2qPQD6HBL9QXCz/RqkCw67W4gu3UwcC6k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type2 devices have some Type3 functionalities as optional like an mbox
> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
> implements.
> 
> Add a new field to cxl_dev_state for keeping device capabilities as
> discovered during initialization. Add same field to cxl_port as registers
> discovery is also used during port initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> ---
>  drivers/cxl/core/port.c | 11 +++++++----
>  drivers/cxl/core/regs.c | 23 ++++++++++++++++-------
>  drivers/cxl/cxl.h       |  9 ++++++---
>  drivers/cxl/cxlmem.h    |  2 ++
>  drivers/cxl/pci.c       | 10 ++++++----
>  include/cxl/cxl.h       | 19 +++++++++++++++++++
>  6 files changed, 56 insertions(+), 18 deletions(-)
> 
[..]
> @@ -113,11 +118,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
>   * @dev: Host device of the @base mapping
>   * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
>   * @map: Map object describing the register block information found
> + * @caps: capabilities to be set when discovered
>   *
>   * Probe for device register information and return it in map object.
>   */
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_reg_map *map)
> +			   struct cxl_device_reg_map *map, unsigned long *caps)
>  {
>  	int cap, cap_count;
>  	u64 cap_array;
> @@ -146,10 +152,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>  			rmap = &map->status;
> +			set_bit(CXL_DEV_CAP_DEV_STATUS, caps);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>  			rmap = &map->mbox;
> +			set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, caps);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> @@ -157,6 +165,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_MEMDEV:
>  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>  			rmap = &map->memdev;
> +			set_bit(CXL_DEV_CAP_MEMDEV, caps);

I do not understand the rationale for a capability bitmap. There is
already a 'valid' flag in 'struct cxl_reg_map' for all register blocks.
Any optional core functionality should key off those existing flags.


Return-Path: <netdev+bounces-293043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG7YLtpJGWrzuQgAu9opvQ
	(envelope-from <netdev+bounces-293043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:10:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AF35FEFDA
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EED4C30930E5
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276473AFCF2;
	Fri, 29 May 2026 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2w0g4XP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7D36D9F6
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041942; cv=fail; b=CzjxIsDUkqORIdIFx0hxoOU/FjZMAYUMGLl2bcD7sZCp6NM/Qs1iKTvFmrZKAr2am1T2eRD8BLFUEt2WZQcTDWZc2qrswHgpvUkaAFCl9FNIND+j0ieoTMY/ngaNjfuukmqaVkWQX9U0afFmELbk9d6Pr/Yuer+1QzrZBO72q94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041942; c=relaxed/simple;
	bh=0MO9vxPmsZGJgiZE3LmZGrsrqo4gnWpzLkLolkmgGOM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jjlCO9uyjiNVF21maKQbyWMARhWUh64/KRd/7pRbmepaNX/BY/0EhWGjLDhxNJrlCuGwwCWiGNhvQAeyIE1XqycDuPn9ysTTybtXG0mZN873r/qbzJDqCXERB+zU9vHThB9wrDd3S3QIlLZODwMCEuELoGNfn9XoSiDGbXN+2Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2w0g4XP; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041940; x=1811577940;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0MO9vxPmsZGJgiZE3LmZGrsrqo4gnWpzLkLolkmgGOM=;
  b=X2w0g4XPcg4DmmN68Qniizm/YvhcKRy5W4K9y5SLkQ5aviHsBvxvLZgR
   5IiVvZL0dp0M1kcNsFE+f1aJx+tkMaRaKhWaEgdsGFcpZhnU2g44lP/sh
   LIwk8TaeE3llUYEnimbOvnXNF4Sfu+UxuuWyj0NgZpUGLLWYthJPHb59X
   Md6V4jz9RFliwQ1MUZ7v0Ql7mALmXXmQOavEMjjqEqqpxtSFR5CXvOUn6
   B9FU9g5LDT+aD3VYroC5yoOqs/PU0C2PkDhN5TPt3ff+Xw6uC5lsIHpBA
   RtDUSMQ8JZSX4iSdMTEb6IGkEm7ShnERtLEDc3JuttZNpvcHFFa3Siyba
   w==;
X-CSE-ConnectionGUID: Cp63WvbrQeKYsTV+/PFviQ==
X-CSE-MsgGUID: 0ckpScb1QjyKeD1eY+3nkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="68427037"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="68427037"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:05:39 -0700
X-CSE-ConnectionGUID: La5QFs3MTQivHk7h4yN9Xg==
X-CSE-MsgGUID: AMHrokjxSK+0x0Br1d8lZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="247065597"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:05:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 01:05:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 01:05:38 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 01:05:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upkf4efaM9RPVy+aqY6q5pUB+Kw0pyT0QPWjNb658yXx8b0v6kTRa7blxN6OFzCzN4xmfvYf7b/gvPl+haVF31fWaEEgygImA7A7x9QKmW//QsjhyBfLNo1L8WJGkpIT1MvpVALOXnqBxBBPS3ciEJ/KYnD8hxvus8ZLYh9acwyM3kDRU4TuU4pHzrITfMAQOmtpoLU3gS6CT25Tb82/D2r+MWvyy8cRM301G2LidEUBLLLUfndyE+LmY4TRth2GhsPTcBNwX3G1xhGJdYY5wootQuU7o1aSW49W6iBsPKDaMbUMKBcWrKVQQWBgW762tOruwiZCSK5kKMyXsDGs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWLTLbYXgjgY9BjH428ZcKv1sKDSkDynN7GOprdOoEY=;
 b=udC1gA4qByrblzuUlDyXmV8waqD6hvlEhShHDNlwTYaw7g6X9vBuxJocH49vWnf81F6L5fAb835F81s9rMS5B8gSPUQWoC+JozX5uTN+HuI18RVmQOXnS3cgUinCMLdDuqpaMRd9/LylUN8+GJTExjZlvIF93FSdpIoZN2TeI8v8xSG+GprK/rIWCmw+AQtluA4t3CKqt0Xgzvf7wwc83wxCQamljd5V1+PUQjmjWUDSR4LFyV1f3s8N6J6etoYdyo1ymvMl+XSDzKyA52VUJlPV2J5qR4iB5lrk+Hs78Ri9TA7vLw94qGENI4c7oN06YMeqwJ62PTc+Hf4Avi3LyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA4PR11MB9009.namprd11.prod.outlook.com (2603:10b6:208:56f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 08:05:34 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 08:05:34 +0000
Date: Fri, 29 May 2026 10:05:22 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, <vinschen@redhat.com>,
	<alexander.nowlin@intel.com>
Subject: Re: [PATCH net 1/8] ice: fix UAF/NULL deref when VSI rebuild and XDP
 attach race
Message-ID: <ahlIwmIHiPsB50Zn@soc-5CG4396X81.clients.intel.com>
References: <20260520183501.3360810-2-anthony.l.nguyen@intel.com>
 <20260523001616.1757210-1-kuba@kernel.org>
 <ahgHZ8NNWPeFVsXr@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ahgHZ8NNWPeFVsXr@boxer>
X-ClientProxiedBy: VI1PR07CA0293.eurprd07.prod.outlook.com
 (2603:10a6:800:130::21) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA4PR11MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7d2ce7-071a-4559-d5c2-08debd590f66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|6133799003|3023799007|4143699003|5023799004|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SaaVXzvJVJ2ejAJYxYCc76iuJC1lDkc/0u/YzFJY3+2Iy661DGNNRXvr0p2Nod4XPELPqSOXRrTWiLdE1xi1ArWgY7OKjUnuw19OKj/DPnqFTVA9NGV+6GM3sKg9RVGK9qE/80eatE3BjXkcMAiodJXoDakLnBXpsCc7O0F1oTmgnSE90heeLw2Ca+7HJMlDty69U/Xl2I40eRmgFU9AHAGV/J5wbJoIpGfYE9jvnvmvYEmL39Z/a2VW6VXY39CPFdgY2l/ylIX2ilh9NlN9cBLuXiM/pEG5pbNtZfcdrEvyYBUW5Wp+wB+4N8Tc0LzrAKRNrilmRQg/0pagbMYYUegqfAkFrabGSc2PiSvVTxCOi/FIuaZXa3qjVXL8IvLpL3neJAaWuNEftpOwGBJwuiPhPAcEoKSwGjJXb4ColImSimEUsGPh2FAJxTPWVrIVnXDwWG4LjJW33tt8rEGf1SYv+MXfHnv9rHv4E6IUVVaY+hTZpRulhpw0TuuH02uRyMd54ByfIOlnqLh72S2D4tuBj+6ovvZVF5cjiuBqYmCeWtW6tfDsybsBcMuVSPMx/wydnDfdNo0V1zJmk9J1BlVTKSY+VAo2uFlsLfZ134AbenhNa75QzV/WaHBOvEHDppGC1rTBbQx2P3xCs2wim/az5cPacOY9OuVpGFXRVQmKbDecct600C4wP1jYkepAgEvGeoShvs9fmJ50t35ckA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(6133799003)(3023799007)(4143699003)(5023799004)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OutgDVM+BjRNGeF/y5EnoMLonzn6pDMtIwCG9/HOr85NGabClW/MGeKeS+46?=
 =?us-ascii?Q?eKQ2nCoWGqYz+BZDydXDaEMBGCy/7jxmYOMHCntalCRWNdJ7HRhqJURuyi5U?=
 =?us-ascii?Q?i7z/TNyED9cu5/Q9BSLYEjVH/lfSQF94XwNd349U/ImPWp2+VskI6FGd8Lfk?=
 =?us-ascii?Q?rPmFLMlssPGDnyfjxnkDwNpCPDMqUrA6Ev73KUK3sJ8Qts8Y/g+Wq09hVBZb?=
 =?us-ascii?Q?fW0a3FKzu5pl9RO7M4WE3NpK3NY7miOXYxhNHFMLkZDuYIyTZ7p/OuUDdKiG?=
 =?us-ascii?Q?Lyoaflq3ov2I7jWBuRdz2P9tItYlldYfsC96CS2f1IiPhshAYi11MnoQwqSO?=
 =?us-ascii?Q?QfPnd8uLcXHGatcLlJtjEh5sLwsN/yG8+S6nyCAKhzm06RkPwtpnfKpWqPM7?=
 =?us-ascii?Q?c8x7XL9hVquVHqISNAHXpXuYmGUDmGrXtK9TWv0ioG2uZgVEBpnBSJYLi9Fd?=
 =?us-ascii?Q?1o95esvQzy8joJF1EIThZ9IKo0blqchn8chEeH699bJwnoCH7ugo9IhVCZMg?=
 =?us-ascii?Q?DISQj5WkQbnRgSIDidHc2teccNkUUCvM6A0PtMFSXaNe1PuJe3j2v+3xMKeE?=
 =?us-ascii?Q?2mFIwoy/37IMxcmUNUjGAw/Oe3sDwUdm1hsX8dE573V/AzTPrdDm3F5Lql9W?=
 =?us-ascii?Q?BwEHabJZxPVJAF95AlrABEXd+FWoZ7I4W4PIQu8G4wfst+LlAAZFNMNTQWw0?=
 =?us-ascii?Q?jmIbXQBFxvgAT9NVCuGDdpAHZEP0HVeiELRnG8oSjd9QhVbvmeVHcE2whyAX?=
 =?us-ascii?Q?nWQhPPotwrnphse6vVYLnNnEDHRNEwmkjHQ97H8oIFlcyfBlFS2GE/EMXwZz?=
 =?us-ascii?Q?TtIEzN8xHl+q/3MZSuey5YZFFCxlpi8mcjOrJ7hsRXT1bL2uXijQgAxL1TwY?=
 =?us-ascii?Q?p5TrUkEjc1i5VXtRhZnG+Rie6Z6scUyq9i5J6ZpxTNU2LknrfvewrNdxPTht?=
 =?us-ascii?Q?C7cUidSlEF8aOGzy6FAFhkDgseS1yI3EJlPMiK9nP4EoxGcxtPRx48fgI1g8?=
 =?us-ascii?Q?3cVlyMFn7pehPXjgH9eum7N033eexqUEtLlvSU4jkgg5WDYFSrzGISFbllIF?=
 =?us-ascii?Q?xym4felVjpsxB79HOAOlO//Ou6v+S+OFeCdsLJOjwf9WDKXLgMn/t+d18a+S?=
 =?us-ascii?Q?q8gQgI/6dDjBmzFsr8iFoYnJEnYMZ0piBtdOmQWNepW2FbA23fZabhgGNxAM?=
 =?us-ascii?Q?04ERKgOkJuLErf4FtOEHGyWlnuTwRmDai4ASdummyngpeTi6vcpJTWPkjZ4y?=
 =?us-ascii?Q?G1brvQixySRG5Ioe4TfnbpvmNXfuCsz3EIr4wqLVZYoG1ySe5pETjxd+4MKV?=
 =?us-ascii?Q?Jh91KTIkwekYHlTIYuHmTC0kH9IjRwBv9wA0kmd1JNEfJA32+CD/8gNzUbRk?=
 =?us-ascii?Q?gDQJzQA52XtjOWdA8yMBSas6T2XYXa2BEhX+m8J7fsiDYN0cVnPIBi66izS8?=
 =?us-ascii?Q?fsqWWjJoF/fMm8uFsFeu8MXuF5sgtaSjwAum4WSbrehNR4Kt3hXs+0AMABsq?=
 =?us-ascii?Q?6x9SD77rECsMM23R+J0GEgX1pHCQIh9vFSU5uqSJJUjMWQSWzXnF+osbjZjK?=
 =?us-ascii?Q?a9fCpgX7q5sYi4IMtY9F8gGNww20GT0ibujJCs52tTbZLDjSzxqg16ICaDQZ?=
 =?us-ascii?Q?2R9QArNj1Vf8/kO1g0Wo6qX/P7CbsqTUB6Do/3asqKxQ92MLSlSRkwvQvqFb?=
 =?us-ascii?Q?NneoUGkD6FelrfWZKehBPGX4dE5T0iY4tIiBCXn/JgFa9ZAT8RAdgO1SCxW4?=
 =?us-ascii?Q?gmbWb9WRyVtHexuiYWUV/QFfxtZ+0mi8Xd8pCVTilR/9/7UCEbZcMwkMvfFx?=
X-MS-Exchange-AntiSpam-MessageData-1: HsQGQpIJPbLfhhlomzgw/zHtRLi+xU8Y/wg=
X-Exchange-RoutingPolicyChecked: CwiPQgXkz33XCmO+J8csrZ663b5anlzY/K1fH7kqRA2yKMmug81Xjdls3WKonMOZWYfIbY6P0DRQkdpSH8oBP++j10USAFFTHWE2VnWsAnttwZsprJkr+xftvPg5KY+6ziceKCnWZph29+1OchY3RGheH/WVY/HSOtX0j2tAW3VE9X3WGrj3S4irV/9VK1dHsz0BZCJsn3ZZoxFSRNeroznGO9a3K445R1LOfXyZiSVEnT2rxF7mYZh9X4SUTSJUA9rhATtzuGPG/RWSahULPRIsvduyW+4cR9MYi988HYMjpdLKKzOmEHLuTKpECV5U5d9ffgbawPaLrP7PsUBSGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7d2ce7-071a-4559-d5c2-08debd590f66
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 08:05:34.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zt2vs0uog3FNmALDZ88ouKCVvp/qSCPuWNO1bc7lWLaSk/mbB9SLQUC0nfuD5j88b2FkbMdcBoK8+KJg6WoMn6vEBRROtSOH2zSL71flrgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9009
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-293043-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 56AF35FEFDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 11:14:15AM +0200, Maciej Fijalkowski wrote:
> On Fri, May 22, 2026 at 05:16:16PM -0700, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > ice: fix UAF/NULL deref when VSI rebuild and XDP attach race
> > 
> > This commit addresses a race condition between a VSI rebuild and an XDP
> > attach operation. It prevents rx_ring->xdp_prog from being populated before
> > rx_ring->xdp_ring is valid by rejecting the XDP attach when a VSI rebuild
> > is pending. XDP detachment is still permitted during this window to clear
> > the existing program.
> > 
> > Fixes: 2504b8405768 ("ice: protect XDP configuration with a mutex")
> > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > [ ... ]
> > > @@ -2912,12 +2912,21 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
> > >  	}
> > >  
> > >  	/* hot swap progs and avoid toggling link */
> > > -	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
> > > -	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
> > > +	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
> > >  		ice_vsi_assign_bpf_prog(vsi, prog);
> > >  		return 0;
> > >  	}
> > >  
> > > +	if (test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
> > 
> > [Severity: High]
> > This is a pre-existing issue, but is the check for ICE_VSI_REBUILD_PENDING
> > prone to a TOCTOU race because it relies on ad-hoc flag synchronization
> > instead of proper locking with the device reset path?
> > 
> > The asynchronous reset path (ice_prepare_for_reset()) sets
> > ICE_VSI_REBUILD_PENDING without holding vsi->xdp_state_lock or rtnl_lock().
> > 
> > If ice_xdp_setup_prog() (which holds both locks) checks the bit before it
> > is set, it proceeds to configure XDP and sets ICE_VSI_DOWN. If the reset
> > path then sets the bit and calls ice_pf_dis_all_vsi(), it will skip this
> > VSI because ICE_VSI_DOWN is already set.
> >

Here is ice_dis_vsi()

void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
{
	bool already_down = test_bit(ICE_VSI_DOWN, vsi->state);

	set_bit(ICE_VSI_NEEDS_RESTART, vsi->state);

	if (vsi->netdev && (vsi->type == ICE_VSI_PF ||
			    vsi->type == ICE_VSI_SF)) {
		if (netif_running(vsi->netdev)) {
			if (!locked)
				rtnl_lock();
			already_down = test_bit(ICE_VSI_DOWN, vsi->state);
			if (!already_down)
				ice_vsi_close(vsi);

			if (!locked)
				rtnl_unlock();
		} else if (!already_down) {
			ice_vsi_close(vsi);
		}
	} else if (vsi->type == ICE_VSI_CTRL && !already_down) {
		ice_vsi_close(vsi);
	}
}

For __LINK_STATE_START netdevs, DOWN state is rechecked under rtnl_lock() 
before closing VSI, so we do not have to worry about XDP and other configuration 
functions tempering with it.

For !netif_running() netdevs, the only situation, when there could be such 
problem is if the whole .ndo_open() finishes and another rebuilding 
(rtnl-locked) callback starts and sets ICE_VSI_DOWN in between

`if (netif_running(vsi->netdev))` and `ice_vsi_close(vsi)`

Which is already unlikely.
But I think this is not possible at all since ndo_open() will not succeed while 
we are in a reset path, so no rtnl-locked callback will see !ICE_VSI_DOWN state.

It would be more robust to check for netif_running(vsi->netdev) under rtnl_lock 
too, but the code should work as-is.

> > When ice_xdp_setup_prog() finishes, it calls ice_up() which clears
> > ICE_VSI_DOWN and starts enabling hardware queues while the device is
> > actively undergoing a hardware reset (ice_do_reset()).
> > 
> > Can writing to hardware registers during an active reset cause hardware
> > hangs or PCI master aborts?
> > 
> > > +		if (prog) {
> > > +			NL_SET_ERR_MSG_MOD(extack, "VSI rebuild is pending");
> > > +			return -EAGAIN;
> > > +		}
> > > +
> > > +		ice_vsi_assign_bpf_prog(vsi, NULL);
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does detaching an XDP program while a VSI
> > rebuild has failed lead to a NULL pointer dereference here?
> > 
> > If a VSI rebuild fails, ice_vsi_decfg() frees vsi->rx_rings and sets the
> > pointer to NULL via ice_vsi_free_arrays(), but leaves vsi->num_rxq
> > non-zero. The ICE_VSI_REBUILD_PENDING bit remains set because it is only
> > cleared on the success path in ice_vsi_rebuild().
> > 
> > If a user subsequently detaches XDP, ice_xdp_setup_prog() intercepts it
> > because ICE_VSI_REBUILD_PENDING is set, and it calls
> > ice_vsi_assign_bpf_prog(vsi, NULL).
> > 
> > This function loops up to vsi->num_rxq:
> > 
> > ice_vsi_assign_bpf_prog() {
> >     ...
> >     ice_for_each_rxq(vsi, i)
> >         WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
> >     ...
> > }
> > 
> > Since vsi->rx_rings is NULL, does this cause a guaranteed NULL pointer
> > dereference panic?
> 
> CC: Larysa
> 
> Seems we should check if vsi->rx_rings != NULL plus
> ICE_VSI_REBUILD_PENDING should be cleared on error path in
> ice_vsi_rebuild().

I think checking (vsi->rx_rings != NULL) should be sufficient. Not sure about 
clearing ICE_VSI_REBUILD_PENDING, if a rebuild has failed and the device is 
disfunctional, rebuild is still to be expected at some point, and XPD changes 
should not have any effect before then.

> 
> Do you have any comment on TOCTOU issue mentioned above?
> 
> > 
> > > +		return 0;
> > > +	}
> > > +
> > >  	if_running = netif_running(vsi->netdev) &&
> > >  		     !test_and_set_bit(ICE_VSI_DOWN, vsi->state);
> > -- 
> > pw-bot: cr
> > 


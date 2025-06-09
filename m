Return-Path: <netdev+bounces-195838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A17AD26EF
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F352918895E2
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12321E0AA;
	Mon,  9 Jun 2025 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktVHEGlA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A4155A25;
	Mon,  9 Jun 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749498136; cv=fail; b=VRF9tL9Qe4131/ZAj/jSfFsHlB448fegBtaCkIH3OvI6NkcMgrvGZVvUZVhgtOREF62u38gjp0LvL7y8SxtH/aXz3TZQZEW0RkPVTL3tk9/NIoTs0+U+Gen+KGkhoWwHf0B49BFJ4CQ4c4l2iwVtDQkCfZ2291xPoAh202esKBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749498136; c=relaxed/simple;
	bh=s7XoIAMOkBhMaSHCqtTUtQ2RWDG1BUcl/sobWvCCRrM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mKct+aKWhUSukJUzgxfXXjliLTyqbuUOG88WT9Zu1amj2PJUpl9jZmOeXNRluGuBKCnNo7Wwu8nqGayQGBN7rvnYn/KSTb6bQMb+cr4HT09oiAX1bXmHyM4/FHP7dcSofqelDbUAM99ome4gJdpbc6KXto8VsDOXDCeQh9+EvJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktVHEGlA; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749498134; x=1781034134;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=s7XoIAMOkBhMaSHCqtTUtQ2RWDG1BUcl/sobWvCCRrM=;
  b=ktVHEGlAiWg4cFmdcSz3N7Djhkfbhus5VcoB7uY0uU4TSZZ0sPRAhNu/
   aOvPpcXGqoDNbPNPi2/Zszn12bwMq1hW0l/Y+qhYjmZ96tlqp17UMqq5D
   DXLJxhR6RGC2KXKTfqsRSAageKjTUNIsKBwqoJQwGbFNZWrhc76O/36lE
   a45V/B/wajD7bkwXePWLCI63ipiaY8MaAjiTkbTgpIk9ZSqvP7VC4F4v6
   RuyYFeh2pW3x3RLFbE6WOBGTqTS7R0LQmb4miOaT0QtRv6PcozNe6L/ze
   CjvSybXSgZuvMaalWvQi3zEdPtgMW01kRRgutpwlyCt0RGQr0z9h3bMRI
   A==;
X-CSE-ConnectionGUID: xi7zvsIDSDKUZK/JKmtQHA==
X-CSE-MsgGUID: fEeMKMPaSUmWu899Gy7BgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="50697423"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="50697423"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 12:42:13 -0700
X-CSE-ConnectionGUID: LWqi37i8QcGIKOAaUR3HSw==
X-CSE-MsgGUID: Kd39HX0gRuGQNjL33ADAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151859725"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 12:42:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 12:42:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 12:42:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.73)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 12:42:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkyzEOXYgw7eXDrRg9fJqIvTlJ/MDwBFi6aDKhg8GQjkKWPjZ3PaE9NCVY8AmM9wgRvDFfzngXuE5Bcs9iRtk2qOIECWtC3ncpXl5oRLBUwP5BPQg1ARSPZqWCGYorEbCmYsk01zmfHEhdb3PRMkmtCE/Axr6lXihH2g3zXEEKk2mHNMKgc0ymQriMsmiJASJfDv/BKS4200q8lMSn3nddFYVPZHSwKJLbdubt3ESMiSDuTl3pZg7HzqrP4EP97YzpOSCj03wukBq7K+xBCwARtSqwVnexLAYwpsGuq41Rn2bSFTGsBvU54SoZCOUaGKuq+FaQMYaOXbldOay7ZIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K443UxllDneiPLBJLmI/HZcdsD5J4Isk9k6bOjOxd0=;
 b=tTeoyQwtVpp4IoRGakJ2Pel7I/0woCmw3AcQXjEzBGqtk4ky1CD7dYaSyeWG0VSMxl4H2YlN6yrKXKJyI/6c83LMT/eu5rToukYPu/chzhNb0E6uHf7Dxzeb9zKxU4nAMiyUr7O9Zms2VoAu9TMOKc95h5FSvGQ7B8A9QNY3VO9eOC8to6e2ZEtUc96e1vCxx3LLP6goVFZzU6q7Xzv39m0xLyxXd3IEskPG49mvlIAscpzq8Pxx/EOD6eKk58RHGRgWVRS5Fj254wenQAy65y9nUrD2+dddpcdB5jri5NPrtpnC5qVvKdiBvNd8glzldFPk5me8KJrb+OhZIYNbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA3PR11MB9133.namprd11.prod.outlook.com (2603:10b6:208:572::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Mon, 9 Jun
 2025 19:42:10 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 19:42:09 +0000
Date: Mon, 9 Jun 2025 21:41:57 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Eryk Kubanski <e.kubanski@partner.samsung.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>
Subject: Re: Re: Re: Re: [PATCH bpf v2] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Message-ID: <aEc5BVcUJyb+qlg7@boxer>
References: <aEBPF5wkOqYIUhOl@boxer>
 <aD3LNcG0qHHwPbiw@boxer>
 <aDnX3FVPZ3AIZDGg@mini-arch>
 <20250530103456.53564-1-e.kubanski@partner.samsung.com>
 <20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>
 <aD3DM4elo_Xt82LE@mini-arch>
 <20250602161857eucms1p2fb159a3058fd7bf2b668282529226830@eucms1p2>
 <CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p2>
 <20250604141521eucms1p26b794744fb73f84f223927c36ade7239@eucms1p2>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250604141521eucms1p26b794744fb73f84f223927c36ade7239@eucms1p2>
X-ClientProxiedBy: VI1PR07CA0269.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::36) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA3PR11MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: f498e36f-d038-4807-7007-08dda78db909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?PhbMo050BzXKd4HLbROxGolU+UK7XoWYj8yQP2e2dCRL7ypPkxoFpILoBf?=
 =?iso-8859-1?Q?vLF+4bVkdQdFT5WOuwKcraZfKRUjujduViF3olkamVIuWH4w6xFAa7u77V?=
 =?iso-8859-1?Q?YwYcvce7qANFVGbXMRYVRGHijtPW94om7S+lP1oPJNN0C9aaGETE1zq2sb?=
 =?iso-8859-1?Q?Dcc9t58DCTvslQLCH7S8KHQyU2V+JaFCyGpN4QMSvQ4ThQTd+E6H/lbJ6U?=
 =?iso-8859-1?Q?6ZWIBnFQ7bEBKnOfeA+p7O/nc4JGI1DfZ0NHsSIlnWQLgD6No+53aWmpBn?=
 =?iso-8859-1?Q?XzjWIuZL0eo4hWXBQyZH3b8nZKOyD9GWxUKC0hyERBN7rjXxKnodb4hr8S?=
 =?iso-8859-1?Q?ezyNwUY8akEJzuLJxaK+payzH58B4fitOQe3nZ1ahETkYvaAouMxtY50ZD?=
 =?iso-8859-1?Q?tD+i5Q4+c1RctZscVm5xZ5KqHNy8QNuu9nsWW2x/seI1JDrRvzfZJBxMiO?=
 =?iso-8859-1?Q?5kkf/EgS/uFKghdGAKyWMNtSrLPWQ2e5Y2MyXsp7YiXsC+N7kTA2pczKSF?=
 =?iso-8859-1?Q?zbqB30W+yHiETGyUqiW1A+B5+SvFnSHouTPbMdsaW0nasuAMv0Cu6hNwWl?=
 =?iso-8859-1?Q?Ww/dPGUQQD+9e5LVltP+W37Qc/ZoEqNkJML0+KiPQmR0jdkE4M/Nx2pZuA?=
 =?iso-8859-1?Q?efmBafVHJNxkg5WD8zI5blJKlQjXU+Ltqvp5LhZNo85Uc9w5q4R1HBjJ1p?=
 =?iso-8859-1?Q?3OSv8ADydFSkls6Ia6N/GYMwR8Xm/IL9iW1X8W+svlopIIP+PyOMM/QlBz?=
 =?iso-8859-1?Q?rm50136pn5K9DjoXG46zHwtjNPtClMAV1hClHgAGHm8cNk0L66HlPYh3Ky?=
 =?iso-8859-1?Q?X/Uzje0bEUmzJMQjfN6Gf3sOPVmx0NCeDwyhCRXJBBvNMtztlAkptYY1aS?=
 =?iso-8859-1?Q?jgmxpNdE4QZzBKhgkFt5PoSmi7/xyTjMgmkVS6TjCGC+udUjdB391owDGo?=
 =?iso-8859-1?Q?AxGU0D621StMcl9eudgX4mYyNbECw2nWKLPH6eko3+3pwpt44tHOA2lUVx?=
 =?iso-8859-1?Q?HQdDiRwn2jLg2GbIlr+NrrPZRIfvilk4GswUakck5Z+cWuXPljq3egsJYu?=
 =?iso-8859-1?Q?zgvZ5uO3GjpC05Uji8ohpHPXo16QB3KwvNnSp8Bydh9+TOOtjXavqlQtb0?=
 =?iso-8859-1?Q?59QbE4pD/FxsCgICZUG9KijjlzmuYBJoGgHoIUkISVP35w4ZtayO2NHgYj?=
 =?iso-8859-1?Q?5MtrnIh/49ckpXvnezudrg8hn0XpKI31yjENe+KtSXHMBcU6/u2LUDKthN?=
 =?iso-8859-1?Q?srYf2nBbVoXWSIdfnzM7da7ZoKklEwb6TVCPWDfa6PZMg4WVw5Z4lo9HJO?=
 =?iso-8859-1?Q?E4qgCkdIXwPErScFU9cDu+CacXYt0RvlT/2hYoH38heHxF7/7Y3a7gZ4dM?=
 =?iso-8859-1?Q?zeR+gMOCxdUBcBv1N5BoU0ZRFGKJlOIfLC4UZ24/ttGyZFcSMySmPU0vcI?=
 =?iso-8859-1?Q?YdPSG+ULjsw0txXSGngrZSxPu9887Lv4WFbkA5IZKYwzRYoXa0eWbBm/LF?=
 =?iso-8859-1?Q?w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gGep2vibgtx+7xUjwet9uRWkrU5Q5ZfCk1aDjRQpoiSNA01CuNLo/5hoWQ?=
 =?iso-8859-1?Q?oxUpXYnkcJa9ep3jsqBEZVykiyte8iOkuLiVd0zc6gM7Q0LHHmv/Rl0FUP?=
 =?iso-8859-1?Q?UYuIOU77CCXh/SWswzOVmXaB7Ri0a2ouJInlV+lBBF/xnvEvoisTbD7qwW?=
 =?iso-8859-1?Q?nj9o5aJOFmb7EhDDaO1INwNOOna889LS0AuVGx/pBI0P4hv2p74px2xhCo?=
 =?iso-8859-1?Q?OPn1JkgL/aUpx1HPTNsSaPmFQgMG8XRLWRLyRPa1prFdQ0vokc0ESjr+s6?=
 =?iso-8859-1?Q?uXhNxZEO6+nJ/zSq1nA/+xpDwIxTGdQoahYzyFAaIhz+UOoZeTRrqBp8Ja?=
 =?iso-8859-1?Q?LfLFboDJoGGOMNrEgLZJTVJm7GDkF75PBODRXNeyLyUgGvkYHqEIvrvxe/?=
 =?iso-8859-1?Q?fJB6ZS6IYL0wQXgmoewxjuLgb/eKeiXsFHWQhXTMMTrtCwnG/rKAW6TtlD?=
 =?iso-8859-1?Q?LetnDuVIKE9Sa/WnlSp3R4BHUxeuxFdr42AKRzg2omPpS535czo0jbj8KP?=
 =?iso-8859-1?Q?cV+yOh/JPk4nxCu2I4TZRU9azvm+MeEMPLcaJYJAZInAo82GmJcjHx1tOY?=
 =?iso-8859-1?Q?OxQ97fGZ9nvegr/aKohj+NowUCEmzOsvuWkmdkmVwiGk2AkYWWEFnX1eTQ?=
 =?iso-8859-1?Q?DyUqabTqYXrSE6MF/opWt3+0n/QzeRN1uh8KJ+s2/47EOzWlH4CQ28Bn+K?=
 =?iso-8859-1?Q?7ErhoQUL8/0gmOXrnk1RTjOWFzbGxhMHNdaQbO+EFcwpwhCkoz6oRNhIhn?=
 =?iso-8859-1?Q?ghTopcPwtzVUAyLLxwOc4oTKCVWtoDTL+aMfHN3Cw18BBR67Uk7rQei0MA?=
 =?iso-8859-1?Q?E6tR+NtvQCExjTs5as0sqFpDPFRH8ASiIVDqVU9Cs38b8aefwc//NdC6NH?=
 =?iso-8859-1?Q?LTizwyM0a9z4LnFCw4VHH/TEdD+FcjdvDsMlRp1Nkh6dRJylh766BflQUB?=
 =?iso-8859-1?Q?MTbP7lm6+CyolKe4Zy5Yy8hafu9WsbC3Epc9RzOaQ/YMQug6AfUjOBnJEY?=
 =?iso-8859-1?Q?BWkB+qobgHyCD8VjAishNyqMEhMVipmI0WDTpyimlSyANIE0D9HYQucNHn?=
 =?iso-8859-1?Q?JIKufN9c0giBArWLqUwqq/gz63M0Rq+xvS49EeoIQd6iPBjlv6yabVk9ub?=
 =?iso-8859-1?Q?10b2Q7tIjfksRiu/o0f+/Ypx+a1hJEeXaKe39LsrQSyp6n/mejBA+sW6Gr?=
 =?iso-8859-1?Q?Quoks0uRR6XwQ8kDYeI/QYejH/YPq4vu3xdgfLk8hnSIwABM7c2t6TFod2?=
 =?iso-8859-1?Q?9TOjsxvC9zvccVWJzhgl3xs0Utm36TpqKZrll7nurnJBJ/fsa4KSncuS1e?=
 =?iso-8859-1?Q?khE5xNzX/58ujrDiCpEi73+3qqTH2KqQ1J1YB/crCHpjZGSG253skAhgBs?=
 =?iso-8859-1?Q?aVJy2doJX9O4QVnzhbFnvFkxjfgburIVh/67AdyWUQU2hHJU1WCkmcX6uX?=
 =?iso-8859-1?Q?fKVSbk/XfI83Azfk+VN9JOM06OAAGnDRyVN042D2t48rIOERZgmGrNneJ5?=
 =?iso-8859-1?Q?DrfSGDEI/MfpFJHqDAfGulN2kQkIoBNLh6jWxn7x+2DNRf0mMivwOtE0tN?=
 =?iso-8859-1?Q?y0bwIWcmqaQEJ1eSWJ1xgl9qODThXWKYJMAs9JehI7wPYW6hR7fzHwsdln?=
 =?iso-8859-1?Q?U5ZHZ5Za0egNV8S/dGxC9BW9hPE/IiIn1bFg3nacmMB3ph8QAFjRPtsA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f498e36f-d038-4807-7007-08dda78db909
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:42:09.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEtRM5Fe+ZzCKxb/z5MgUOWbmy0tioPN29UftGeaCWtopMOYb/WbSoj2kk9HNGIF0rzrzRRB3zSOTLNDFEc0VjQ78n9HmlYIiOSdlCP6f7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9133
X-OriginatorOrg: intel.com

On Wed, Jun 04, 2025 at 04:15:21PM +0200, Eryk Kubanski wrote:
> > Thanks for shedding a bit more light on it. In the future it would be nice
> > if you would be able to come up with a reproducer of a bug that others
> > could use on their side. Plus the overview of your deployment from the
> > beginning would also help with people understanding the issue :)
> 
> Sure, sorry for not giving that in advance, I found this issue
> during code analysis, not during deployment.
> It's not that simple to catch.
> I thought that in finite time we will agree :D.
> Next patchsets from me will have more information up-front.
> 
> > I'm looking into it, bottom line is that we discussed it with Magnus and
> > agree that issue you're reporting needs to be addressed.
> > I'll get back to you to discuss potential way of attacking it.
> > Thanks!
> 
> Thank you.
> Will this be discussed in the same mailing chain?

I've come with something as below. Idea is to embed addr at the end of
linear part of skb/at the end of page frag. For first case we account 8
more bytes when calling sock_alloc_send_skb(), for the latter we alloc
whole page anyways so we can just use the last 8 bytes. then in destructor
we have access to addrs used during xmit descriptor production. This
solution is free of additional struct members so performance-wise it
should not be as impactful as previous approach.

---
 net/xdp/xsk.c       | 37 ++++++++++++++++++++++++++++++-------
 net/xdp/xsk_queue.h |  8 ++++++++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..22f314ea9dc2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -528,24 +528,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
+static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	ret = xskq_prod_reserve_addr(pool->cq, addr);
+	ret = xskq_prod_reserve(pool->cq);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 
 	return ret;
 }
 
-static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
+static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, struct sk_buff *skb)
 {
+	size_t addr_sz = sizeof(((struct xdp_desc *)0)->addr);
 	unsigned long flags;
+	int nr_frags, i;
+	u64 addr;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	xskq_prod_submit_n(pool->cq, n);
+
+	addr = *(u64 *)(skb->head + skb->end - addr_sz);
+	xskq_prod_write_addr(pool->cq, addr);
+
+	nr_frags = skb_shinfo(skb)->nr_frags;
+
+	for (i = 0; i < nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		addr = *(u64 *)(skb_frag_address(frag) + PAGE_SIZE - addr_sz);
+		xskq_prod_write_addr(pool->cq, addr);
+	}
+
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
@@ -572,7 +587,7 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
 	}
 
-	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
+	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, skb);
 	sock_wfree(skb);
 }
 
@@ -656,6 +671,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				     struct xdp_desc *desc)
 {
+	size_t addr_sz = sizeof(desc->addr);
 	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
@@ -671,6 +687,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	} else {
 		u32 hr, tr, len;
 		void *buffer;
+		u8 *trailer;
 
 		buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
 		len = desc->len;
@@ -680,7 +697,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
 			tr = dev->needed_tailroom;
-			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			skb = sock_alloc_send_skb(&xs->sk,
+						  hr + len + tr + addr_sz,
+						  1, &err);
 			if (unlikely(!skb))
 				goto free_err;
 
@@ -690,6 +709,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			err = skb_store_bits(skb, 0, buffer, len);
 			if (unlikely(err))
 				goto free_err;
+			trailer = skb->head + skb->end - addr_sz;
+			memcpy(trailer, &desc->addr, addr_sz);
+
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct page *page;
@@ -708,6 +730,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			vaddr = kmap_local_page(page);
 			memcpy(vaddr, buffer, len);
+			memcpy(vaddr + PAGE_SIZE - addr_sz, &desc->addr, addr_sz);
 			kunmap_local(vaddr);
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
@@ -807,7 +830,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		err = xsk_cq_reserve_locked(xs->pool);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 46d87e961ad6..9cd65d1bc81b 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -390,6 +390,14 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
 	return 0;
 }
 
+static inline void xskq_prod_write_addr(struct xsk_queue *q, u64 addr)
+{
+	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
+
+	/* A, matches D */
+	ring->desc[q->ring->producer++ & q->ring_mask] = addr;
+}
+
 static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
 					      u32 nb_entries)
 {


> 
> Technically we need to tie descriptor write-back
> with skb lifetime.
> xsk_build_skb() function builds skb for TX,
> if i understand correctly this can work both ways
> either we perform zero-copy, so specific buffer
> page is attached to skb with given offset and size.
> OR perform the copy.
> 
> If there was no zerocopy case, we could store it
> on stack array and simply recycle descriptor back
> right away without waiting for SKB completion.
> 
> This zero-copy case makes it impossible right?
> We need to store these descriptors somewhere else
> and tie it to SKB destruction :(.


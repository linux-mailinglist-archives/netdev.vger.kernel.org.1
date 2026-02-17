Return-Path: <netdev+bounces-259011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNxEGPNMlGkNCQIAu9opvQ
	(envelope-from <netdev+bounces-259011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:11:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EA214B33E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF096300404D
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A232F77B;
	Tue, 17 Feb 2026 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6+ezFaj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB431A800
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326700; cv=fail; b=kiGvbspoux7bpHpI8ILNZa6J3ZWwDLxBzKp4cgUqttJ4WPgJJhuSOG2PgFuW3j4Lwr+rMSlg+4/ZTnNl9mE5Y0gbnre0D9XC03d5Wk8cHa+/7x/kIPZhLSQVvbV0xirnyoiTUnBwFcGKcZHl+oJ2YY6DhzxvLk8qjw1uCWtIITk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326700; c=relaxed/simple;
	bh=FrRcAMsqM2gfWUaAxHo99+4fMk3nuN+ThBNcxrg4SPo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qHW8oUdloB2btg2lpIYFfA5rV6qMrHQF4JDIxmMGR3v22dJCScPC0dmcf0m9KL4V3W5Hch/M1CUCIimZ7QkQA3GYtXCQvjr1JOllXTTRFLEMO/3hDTXvUoxYpZ7SzWlj56JbrO/5k9gPW6OujlvMNqi9aF06CbNW/KIRcLx3NtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6+ezFaj; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771326698; x=1802862698;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FrRcAMsqM2gfWUaAxHo99+4fMk3nuN+ThBNcxrg4SPo=;
  b=P6+ezFajVUly3bmnMSgunWYHvDQDLsBGHmro5PX1XUY7IZulAhdNe71a
   Ph9/eBS64A79Fbf8wppwnCRu88dxPbO/mKmjWwAz0xjuZVvbqc7oN0log
   yFqoKVjYM8liDyogcibeoQgCW0wpely+TQsVri5lEcVCZdN111hnCRo5A
   PGxF8vjcu9cEmxkn1Ifo4Ac3T+t5n/I7sI0roTsKvBvRe+xTSdBti2VTn
   0xtNxY51U+PNzoXfyKr5O/uVlyvkrs2WgA8KAyMfikUZcvBPiKkJnrIdZ
   q4XdFUKsWcevUUiCTeC9qk2qZe9V5rPgO+PGGeT5yVM86kXJyeXeA6Gzt
   g==;
X-CSE-ConnectionGUID: HHPefZSWQk2ehYyJezfJMg==
X-CSE-MsgGUID: O0deKUncTa6A5bEt8I46dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="59959748"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="59959748"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:11:37 -0800
X-CSE-ConnectionGUID: pTtGZz9vTzatpbAvSHhgaQ==
X-CSE-MsgGUID: 5+N7TmieQm2LOr2sAEFc6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="218385943"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:11:36 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 03:11:36 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 03:11:36 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 03:11:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSXkY1opdMstL5DOWEz+UfIqJIHWgAu7JQZxPvcWsh4+yK0uIKVHCEiYCxKzEA1sfh3OkwaWd3BZAeUSc/G+MdaABl0NqeyupJaXq/x3e+3hoyywU0S03rmDowCvKUl/rzPFRA50OAzR183nY275IdoVLeoIq/+X1tLHA8pPCRBmXBZg9soQp6IF8Zx+Ek4fcIxiCg3F2Oo8IKsD/+19wJAnj7b3T6WWsIVGG36GZ5cjI2M+FCOyERWkhU5oKY3KfrhFMPkMS0zl9zslqtPOSX5EM9g7KhkkKJctGhDw+e7nGyio9kcUjYOVKeSLH8MlfIY69k54a1IGXO9zchaEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFVp77mQnycd9+JM3mx4joHmd2s1r2MhmAS9Bo9Fwrg=;
 b=d11aP46Oq5xpleh4Z5qEWQiA7+GLSeQuaNxAcg6vuhIGstuTS9YUpvzUBwR6qtmPavdYAt4g6I6t89rVLO3O9mmGQaU8+6ozSn7mSpdJuux4bAMCWUE3QVPXYAC2PjRT1EaJs4qgrwZckSt9mODTQemGp/oj2ogIXgLi3Y/XIwtIBWrwKyNtJr6AjdvBA/64t1AMByUokLJJFSc2f9yGSzsATv1Is95B1NGBe7z2zOV4DsseHmuYSziX3WeBccR+FI8WdTLLMVWnzG9+8f1tgxWQ0zq2ie9YzS6MqLLzolC7jhSHI4gKVqlpGJhYsArUeQYX/mwp5T0LcfE4AeyfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB7253.namprd11.prod.outlook.com (2603:10b6:8:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 11:11:28 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 11:11:28 +0000
Date: Tue, 17 Feb 2026 12:11:12 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <sdf@fomichev.me>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v3 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Message-ID: <aZRM0JbD0ndIpqdT@boxer>
References: <20260217012346.22468-1-nikhil.rao@amd.com>
 <20260217012346.22468-3-nikhil.rao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260217012346.22468-3-nikhil.rao@amd.com>
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bffb08b-78a5-4f67-22b7-08de6e154c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5HbszOptSNqXNKsmTy3EgwRCGH3b3U0TA2Reugquf37TKX1IIGGY56KpMxm2?=
 =?us-ascii?Q?Odrqg6d8h+FqP0d2H66ar/z61jzVjnoGJpPDdXQtGM4njOgbRIBX+b1jj5+y?=
 =?us-ascii?Q?0p85vRRuKFzI0jgXEPDaPW5JBdv3ZpP932rIizrseU8NWyxgurO7eE/jJ23d?=
 =?us-ascii?Q?B0xZQzl9v9bRC3Gfxqxhxza/jYVL1sxMLEjdaKDdYl/jhBdQwsaqpiNacBm1?=
 =?us-ascii?Q?YjSCy23ialXfBsbavPzMHma7safIymOxZ8LRUzECk5O0NVByAy9tGw1u/fBV?=
 =?us-ascii?Q?htplm478z29OE8opzlhr/sKi03dM3Pj4fBrJBriidpnEtnnCdOgl7YHNFmq7?=
 =?us-ascii?Q?r/AD64Pc15UoOlBlgssKBCCzHWn1PJYoHis9ZwZngEzEJI7aCEkIT2i3fg94?=
 =?us-ascii?Q?rtLk5j16fsrUefvEiVsdpN9itGSGmEtFnMS2ht9hX2SQzAK+yIGlHt/Uqh8b?=
 =?us-ascii?Q?8FV5licFxTtQlF3WWHxDPKFkx8bFW7aDlCGQznnOnR7PKkCVmjWOksX+fSIP?=
 =?us-ascii?Q?+fyfdNyVj4BFcTgzLr2io7/10yj5+z/8eA5eYfNeLZ8df6hbssqbb2Owo3d0?=
 =?us-ascii?Q?rOank7XEHLAtPgbCGdMeM8W4v5FADiGwypOqtOQCKL4faPj8STThf8mZ0gT5?=
 =?us-ascii?Q?f4g1aSy8zJ2jmA+irMcmtuP/D9OXKC/7Pq85Yo40Ly5XxrycI/3SR9KyaqAM?=
 =?us-ascii?Q?hZUUgsVTdTAnS1nhWsLp5u6MACbuT6BUrhZegHp85glTxuVpgNxejRORB/yH?=
 =?us-ascii?Q?87kzxnEkoJqtfsG/sCTlaEzLARf3xlupahxhFujCRZHHq4GWfqhY2/ZYyEJv?=
 =?us-ascii?Q?al3a6F1wFm6hrcQZQT1doEe5nji+kbYzP97pukOGlAx0akFfS/RvRzv/KD/O?=
 =?us-ascii?Q?IGOMQl7/RoTX5vWZfbnAGWFKKP7f0q6bcfTSZX1S3MPKsHQLoG5Ma/E73Guv?=
 =?us-ascii?Q?LrdxQsHHB4FypK774Qih1WB0GbT8IY1VV+VwUzvy4krZ4jQzxkJh/6kf1wzp?=
 =?us-ascii?Q?OZs5fjEGKUQfn3gHzcfcehjcmFBvf2AKbYfLadueWdhl152gps+hjRSY8BsA?=
 =?us-ascii?Q?4W27wqRq91BpYpj8aodvSg+99kNkUyRUE0DdsWDtL5ASephmjy9nHznauzdb?=
 =?us-ascii?Q?9j4KF4jCYQ26VtiwhjvYWDVHdWExv+qlwjOIcjgZdVJwZ4mcqkWI7S2P+BKc?=
 =?us-ascii?Q?YKSlTOJLELizP2Lq9wD7x41c9iaPdUheJytSjo/iIVTXIVRJY3KK31sgVE6L?=
 =?us-ascii?Q?rw/UzXmwwn/V5eVxXe+9WCFQ0lTsYcZqgWkAp5gkK0NYLyo65+J7L2DKKV5n?=
 =?us-ascii?Q?+pAEQqHGdUPQZTISIb6TmkKfMOBqewT/9TFAEvbQl4d4JmWBZhj3bN7dyphz?=
 =?us-ascii?Q?hE0JgdU6cbN+xk45E5JL9mDbsL1ZOpI7hswchg0WrO+KTcvx+euFJQ/sgO1t?=
 =?us-ascii?Q?FIoZbktkZTNDN8Mc0+JHQBkZ7h1Y5/oBv47AEbIAWwnHHDlgO1uYl2pxIRNv?=
 =?us-ascii?Q?5mAlYybKrzy0J1PjOndJHWnvL8g24O4CYTaBHXSz0gY7G9h9scNxqrWY7R53?=
 =?us-ascii?Q?19GPAJTSNfHJEPaL9Po=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o/ORtRQYM71I01RhtPaMieuPlOCKl2ZlzG7EqaCBhoR+LuLMs+9PkVCE10vR?=
 =?us-ascii?Q?iqINDqGR8gS6/8w020hcNW37AWm8iLSXnC7qk4zJ9hIZCrjHo9amub+6nM8/?=
 =?us-ascii?Q?Vtm106sIaQVoGYn+7D91N2kfZSxGH+oNk7zSKImJb18VPWLk6F0y6GIuU1RP?=
 =?us-ascii?Q?mCSQR4pKMKm8BEeGLPgmnhrxt+VExe0xGq3l8zjuHZk8iD4MhNzMCiP7U3r+?=
 =?us-ascii?Q?dP2cTkYML39Qun0qnhiwX377OsdRBCCYjjk22CIc1ufZL+lvueUGKihVanqp?=
 =?us-ascii?Q?kjI8fA6mepc8jJlYuupIR0CxLZypIU4+E9O1fisYzoy1MhEHUp6y09480TRf?=
 =?us-ascii?Q?YWBrWVVSiPj3qg5jbIhMcyQoQhwvKavC5aCZjXVcJPs9cpHQfbLHCyCFLxh9?=
 =?us-ascii?Q?v5q5FPTvmPTCgL1sQC0XAwZeKL3n76c8qpeGOyr6kbtWnqZyfGtiruxww673?=
 =?us-ascii?Q?XQSwYGi9zp7HQTXpWOfHkDyzL2e1ycMYzcq3P0weRl9lZayBF2Zbl5JemztP?=
 =?us-ascii?Q?mQU8rIyqfIUvW2uYwR8MRTrYQ9WrFeW1lFOxA73XQwisrvQPF4BFkvG0AWzv?=
 =?us-ascii?Q?QEyI2i8I4KO/K+mZJVe3ZQ4t1V84m2j4jFFRIu8h6rtsqPFOSA3iNjSGEe4v?=
 =?us-ascii?Q?EriaVzscMlCme45BEPscnu/LmNsIgyrS8fSAKyqKrJnLGUF+Mc9LzYF3KuIn?=
 =?us-ascii?Q?xm/b3O6RDBdG1ywPbzr3UqFqVReyRuUsG0RL1YOpaqnbnq98fsvXanjt8cxg?=
 =?us-ascii?Q?sPsFhKtr85dQkJ+Q3vdulyZJVdLagkvZVB/lCmODzJKU+DDsRX++9iqtfWEo?=
 =?us-ascii?Q?cxuBwYSLSuJKIfEnBJY+XwzkfkW7ec0PfkOjXAAx1te+rTywuOxYZnY6Kc93?=
 =?us-ascii?Q?e4kBvn+bm5SHq3jLah7NIDJh1I21kbIqVdDqBuKj1jqTSYZ7tluLozabbkfa?=
 =?us-ascii?Q?W/Qkm3LjAm01wAFSycAAzVXHq29MH3gDdCNuezMVjcml/ycXw1XtqGB6EUrD?=
 =?us-ascii?Q?pL/rr7T5bYd9pEidYK1gVG6WlRpCtC5OuJABY99wIsg41oCGpmlCNEWICM8v?=
 =?us-ascii?Q?vA2t7C+00rHkG3FsNFA2ORE5w+clXEqnlMLlR91HqV6hahzpHfT+OuWe1Vn6?=
 =?us-ascii?Q?CB4a4CaECrrl3Wqy4cFMKyfXR78SlS79V4/YoG673o2rZdpPVpCSwFxQNo/g?=
 =?us-ascii?Q?lztEMeqLsTXXj77lZfZLSKVsnir4sGLt9HkMutKWC2c4QtPyi0wad2TH0iuf?=
 =?us-ascii?Q?JogUmHYyKYQ0B/KQCC/cXUR5yq3lYfOeQKhTYf6faATQkE2VgCGnMp424mGD?=
 =?us-ascii?Q?8XDkHqsAz+g0+q/npwmF+WeVpW72P+gDzmVbmKYXpP9ltbnCXs3k7ihIJrzh?=
 =?us-ascii?Q?y1wx38D3fst9YTTyjGSR02tRb5QOSwqzOLoGmpkKGIqWl8bTSUW/NwpxZY0J?=
 =?us-ascii?Q?ANCAXc0GRT2GljQt/s9yyfUHn5wz95RTZ5xZo6a5Kj6/WTIAZ6v0i9mIN7sK?=
 =?us-ascii?Q?8+ulyq+P4julqB9zJpAx9JuVt3iij4hJTW9dIaiD+JBM69zS/JfHH8DDnfbN?=
 =?us-ascii?Q?fk4TIGF31lQ/vlAmj4T7CCeIF8qrngHbREGhX/n/HUD5PYbyfzbScPjMX0eE?=
 =?us-ascii?Q?HhaWpNXChA+EqYewLtHxyaJIVWQVhb6WaWIxucA/x//hSC6gXsSj+tUWEG8u?=
 =?us-ascii?Q?L9LkOZ/2C0XvuuWOsG9NXIHexsdpfvv+BnaEqc33edrWecdnAb/wSLcjJ/Zx?=
 =?us-ascii?Q?Q0Sof/b0KNY/yntWlCCH9bNgkOaD+38=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bffb08b-78a5-4f67-22b7-08de6e154c47
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:11:28.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMLFsqt7KKwnOksIpF3PZTRrdiEqasooZwPYANmPYbY2dy/tcRLMlXEWJLdBZoZRiq9z6nVviQ37qtGcBTt1RCwLqmDx513yVuYrrGF+e2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7253
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259011-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,amd.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 75EA214B33E
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 01:22:14AM +0000, Nikhil P. Rao wrote:
> AF_XDP should ensure that only a complete packet is sent to application.
> In the zero-copy case, if the Rx queue gets full as fragments are being
> enqueued, the remaining fragments are dropped.
> 
> For the multi-buffer case, add a check to ensure that the Rx queue has
> enough space for all fragments of a packet before starting to enqueue
> them.
> 
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Thanks!

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  net/xdp/xsk.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f2ec4f78bbb6..78ca343de080 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -167,25 +167,31 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	struct xdp_buff_xsk *pos, *tmp;
>  	struct list_head *xskb_list;
>  	u32 contd = 0;
> +	u32 num_desc;
>  	int err;
>  
> -	if (frags)
> +	if (frags) {
> +		num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
>  		contd = XDP_PKT_CONTD;
> +	} else {
> +		err = __xsk_rcv_zc(xs, xskb, len, contd);
> +		if (err)
> +			goto err;
> +		return 0;
> +	}
>  
> -	err = __xsk_rcv_zc(xs, xskb, len, contd);
> -	if (err)
> +	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
> +		xs->rx_queue_full++;
>  		goto err;
> -	if (likely(!frags))
> -		return 0;
> +	}
>  
> +	__xsk_rcv_zc(xs, xskb, len, contd);
>  	xskb_list = &xskb->pool->xskb_list;
>  	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
>  		if (list_is_singular(xskb_list))
>  			contd = 0;
>  		len = pos->xdp.data_end - pos->xdp.data;
> -		err = __xsk_rcv_zc(xs, pos, len, contd);
> -		if (err)
> -			goto err;
> +		__xsk_rcv_zc(xs, pos, len, contd);
>  		list_del_init(&pos->list_node);
>  	}
>  
> -- 
> 2.43.0
> 


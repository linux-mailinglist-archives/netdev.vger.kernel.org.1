Return-Path: <netdev+bounces-273351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFApJ5L8ymn7CQYAu9opvQ
	(envelope-from <netdev+bounces-273351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:43:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E93620EE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3282B30179E1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC2C3EAC9F;
	Mon, 30 Mar 2026 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLSGhzRn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750F3EAC6C;
	Mon, 30 Mar 2026 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910192; cv=fail; b=FHgvEVua0qFMyTrZPw1H/X4i6iW06NM25I0YKgDBqCnt0fwuRNHI3qankJ0egt04TV5vtuQyfFm6cp8AU7Z6xXlqobr/3GoUjHRD3PK/hMbf45Pe8TrjBYgT/xdqraE4Qz7IYEQOYkeCLpurfUQxFejzC66PbtmfK2SAyEUG/0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910192; c=relaxed/simple;
	bh=Z/7CqTzPskF6186dyTpcHEXEItrRJCtNrfPd1+mAGL8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YAbVZdNsul4xlZDOjgfmspNjh7xrggunfsZVOyJetrEQm96zv50IXXQ6RVEV4AT+YCH0sH3fY/xLndc92v06H7INTbqt98whuvBM424wfGHxGfZbyOhGLlOSM3E3amlBTxqPtIbJe77QaNn5CB4NNO5FASX2+ZOIn/DWpqbTLJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLSGhzRn; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774910184; x=1806446184;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z/7CqTzPskF6186dyTpcHEXEItrRJCtNrfPd1+mAGL8=;
  b=SLSGhzRnm/De+fRqGCEerHkewdUWM0pKHRaKfA9Z8K7BHhDAueoTvnlJ
   38owGBezMsP5GnZl/ei4qQBIt66iLHQ9WHvA5/3TpWhfp309qetyAnUTH
   r6SSEuYmBRltI036tJFbc47M//+vZNJFP53DncMRC59mx380FEfO2cUEQ
   BGiSec5GJJmarJNx8075I00VIORUld4XVn7IO4tsowPTq4BVC/UeZKq2K
   bZd7iL+tqXL2IfBU/rE+QOpNifmx1u2xGBK22iO2w+AJTX1Bm2KT66oC+
   aLet8xFjGOuKQzMC8kGtp671umIyb9PVcDuE0hD84CRqWYgLa1tyOoP+u
   Q==;
X-CSE-ConnectionGUID: 8qVxalvCQ+uvJlPIF9J6ZQ==
X-CSE-MsgGUID: fb/4URB8SIiUAEUTCMqlJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87307232"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="87307232"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 15:36:22 -0700
X-CSE-ConnectionGUID: iiWmUiSASV29l1JejkwNfQ==
X-CSE-MsgGUID: zFQelKPmQ++AKiIsRwMRqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="264118052"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 15:36:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 15:36:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 15:36:20 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 15:36:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NguS3HAQZVoRvhQ7BFbSgIjVhn+DlwpyO7ei1MvJZ1n0ykCNGF69UciNU4kRPMEN/MrRkwKfTo1kd02DC/zl3krwH+jSWxWVzD3uAh/27Z2GpfiqIAknQ8GuevF+sAF9EANy2AbwquXmfRAJo4fhI6D0shFUCLnIxwARU8Yk60Z77f0Xa9iQdyMgeym8b+Z690WniENxpcb3iRNpphUHFeffo0l9NdzOXOwgV4Zkj2K7D+sQYGQcLIwTtnfkA5tPYOmzkxosGwL98zHLJpsuYdeeTRYkqcYektvvwmneG1f/+Uq1uRf/joVH1TSS0+NuvQkHyYkemu2AdzcOkAgLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pT1rDMcYXVs43GmgtsC2u2xEf1JmifXg7jSmzyNR81s=;
 b=lT1dHtckg5568+Ypr/CaPNyAcMeyJjjGa/XVorhu7ChRW+HpzXMH5JpoXK0qYevdpSoDxtd846Ryy30nfTbgKoDfucdWQRLZruR+rOmL7EwB2+zA7PcCDnjVwwbkz69qXZLPbI+gBegUFToEZJEPqHmUOTNyd+wSFU+8sPjiVAK1mBrnv/YUmwFcCG0nDxSn8wtK3LDzS+NfQCK7ntJQKc1VB/TfExuNV6S9+2Fg7nRZMvsHsNhLWCqOI4t2Aa0TS8hzor2K4AhZASfBkz5W2h32RaGuT52nNMvznzYbfzyvPR0SD2IZVUQ8FEnro0kF1b6Ud9ocpLlwxkpQCpnOSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 22:36:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 22:36:16 +0000
Date: Mon, 30 Mar 2026 15:36:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v24 10/11] cxl: Avoid dax creation for accelerators
Message-ID: <acr61ze9Zj2xTaDv@aschofie-mobl2.lan>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-11-alejandro.lucero-palau@amd.com>
 <acNPnzDryNIQlTFS@aschofie-mobl2.lan>
 <8737035f-07e9-4c14-93a9-bb542197d7f7@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8737035f-07e9-4c14-93a9-bb542197d7f7@amd.com>
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW3PR11MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: ba18c84b-b503-493c-aaed-08de8eacc153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: mYWNQTTdmKDrsHurPRyZUZUEBQNwsamjjbv5aewRS+e3sucrYhtFdcFzBtZfRVWoYK+2fhCNB6bICwjIdNVIHA3haxC5HRPwpyHsszu20t6drw9lFnkDx7z2J03yI6BIwQZb9WipNE6gs9UjgjocRenp1js5WvO6xromaIMBC4wsVxjDovml65hkDw3ubNJzSomBGVfGalCB7ysQMFWtt/d0yjIwlY1i9kF8evkJM4D58vTBUCpdtwlSLRM80XgzV0oqnfe0qAfiW8mVTuae1ggmaicgeGSPkr/mTIMTpg5rRAVup9a2lXEK/9YyqtucI9Tv+/fK4Mn4/KA/xVWq2nzTEz+uBa+7IEYVR+hJUGni5aNEKuHyDCWGZqkJkbjymZbTuLyF4Z787bySYc89WzaXKP18+fRA0/423tLUl6mvIvoyy0lFbFINJrKmjzc00hK494wERirsmWzBLoc1uoj9OHmTZ5mwmEgELq2tTXIkmR3k7yxeNNaIdVVIsgWANmt5DyyjUpm0KnuWctkXcWrzT4SkSA6ntHpug8sxqFc/qKK0i51JnybMvtUCLYGcKlDwYEqgpyACOWOns1QrlUOoQm1BpC0vlhxZSyOrjfg1mNzVLYY3BTLXdYXYshBJTXD4tjU0HCmDYzyxulVapDzOtTrR+8wlOJxmYr6PPXeAfhuBI6iozYtObepxR4SAdSydM/bEHXTgHOlDkSxWIbO3uBuOEvHV/ITelEkkh8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kiQJF7Kk8N6HjKjcu4i2TjQbRK5o/V2tD/TcAmK4rB9dywx3/DOopceRIIG+?=
 =?us-ascii?Q?2bP+k3sncASzRyUSFkLUtBbUK/jFVjcv85AL5z29g8MRvdGkHdJ2Wl8iLX7J?=
 =?us-ascii?Q?80OcNAnth5EdqU8eQQIrGe46lGyCta0lrga1Ot22Tl+uSAW6qCFhwhNwgVPJ?=
 =?us-ascii?Q?F9hR9xObb2kyIIcIOtIgfMxtOOm2LromX+1K50Qm6//ef/sass/2aFCrYDtD?=
 =?us-ascii?Q?T1Y9AouqWKey2/XCc75HDhjrEO3w/tH5CNWurmiUyvyhD5CLd8mDWiV5pcBs?=
 =?us-ascii?Q?y+oOtQVrGhO+h7Oc8UBDRnpIsTciQhxn/ZHYzVT4lrNErZv2LI1o1PbKrSC5?=
 =?us-ascii?Q?x2BVbTOZjwj/VHg8o4Mmlndz2esBfN0PxsLC5S0Fp5WhxUkt8Gyw2WYZPfUI?=
 =?us-ascii?Q?pkqlxiWthPnmMYHuyQNnqioxAMCz5cY3ILoTjBoiRe1E9rn48GpDY8YQ7ZAw?=
 =?us-ascii?Q?tcRSW2aitvWzmkrNaMN+N9WHHZLJMOxC8O6Tjqw7qLPGYLRWRYYD1vtbaY66?=
 =?us-ascii?Q?T10P0GFkbgvjgOaUJWUaqcXmCUx4r+uJsBXuNdzArYJLXDrEP3Z1/yA1wm27?=
 =?us-ascii?Q?BXdvkcjk5Dd6FPndFVvxMQZQbHwtXlqTxu7aOJ/+kVG2vV7XZg/Qd8tUthd7?=
 =?us-ascii?Q?+S2aZhlUfsQ2wBrMvsD7Tde50zqdp7fkyAjTOVOpEa/9eG4R7Ki7Ojjoyd7d?=
 =?us-ascii?Q?hkre+rYnlf4yA4jbxnZjHAabQPmitmKjDIFICP0N6gBnvGYVpf3B62jr0DCd?=
 =?us-ascii?Q?ZagttccKJjcyi7tOiKKxTaG4+Hpe9acVRHdYtiHpwKp2dpJbBmH42fkIXgZt?=
 =?us-ascii?Q?SfKnxR+tQQjSDOiULCXn61peRcZGfLk4zbjS34Js3hJ8Jlm1iMjgZgHGrt20?=
 =?us-ascii?Q?j0PQTjeDhv+jfihM11xRsYAwxQw1XeVy8VWeuZqkr/Mr5EuMa47Yzdxi84nE?=
 =?us-ascii?Q?nHtcQNwL6UrJhbadwkZAs6t3G2sJsylxyHAi9+a9GIy0IQoWJx2npqD0KIVm?=
 =?us-ascii?Q?yDaGijd/m5Ha/B6dXgXkgNAxxIE3CHDtitC3k697mQ7A3pd8hVZSRFGc+reg?=
 =?us-ascii?Q?5HbSMMSmj/aFrWPAq4Vls1VuM4wMFEM3l6uVZTsnbaxVJDw0GLCQjMnFNun3?=
 =?us-ascii?Q?uO1cX5nrPsho3YGPqW12znGNSHVI4cYJYlVpqxM/QQXbrBUV1rdHJ/b/EE3H?=
 =?us-ascii?Q?VYSCqBIBbtLdb+dhd2u1tUxQZzpNzL2lHRm1H9ZhJD9Ta3zSrn91Uy9F12f+?=
 =?us-ascii?Q?Jnp+tXeaAEWwKA0GdJqOEYM1yt7YFr/aZo9D0x4MVUH7vxwmYZ0J5XPilQHs?=
 =?us-ascii?Q?KUluGZoH6ONTcWe+BsJfZD1sExPvEtGXXdfQZkcW+DUrxcQQm1teakWbUXnX?=
 =?us-ascii?Q?6d1YdvBIUME7pDpwZYQkuDrvLLq23YYcxrSwyflS7rsxhB6wih6hX6yaSnt6?=
 =?us-ascii?Q?1vXCr665lQNB+bwXZERFVBkURq/Spmdsj58edEo7/G2EkSlj/tMl/xwrP5kV?=
 =?us-ascii?Q?4n434s4L6aK6wmF8Kgx9WAhpfdzwuDybd8HUbHwk4pYBgGOj2JKt+pcxENjl?=
 =?us-ascii?Q?IFBqiSZYoYLz+ytWJGc6H7su9Yx5AS2+brGrCFSzt/fQFXnFr/3TK3qvHxkv?=
 =?us-ascii?Q?ZJa8dgJJpxf8Jv80n7k41WP7UtTwQf3ndvyP9aMAk/6oQnHzBK5vDfZa95YA?=
 =?us-ascii?Q?1Gcf8fonhTHvZR+dEdGlxj7hNkTAyaY7GuZIv6pt1cV2UGygEbnT9nUm/hsd?=
 =?us-ascii?Q?GNVQdEsE5YhSSAHtR8Jc/rBNyBpHkqM=3D?=
X-Exchange-RoutingPolicyChecked: PZXDdkb4kE2dCMcmUeHiRKF21shZmFoZtkLcF43if408eZOOh0jzAG4A6l9EwpD4iQXQcBGiRSNWnOyR/OkoN8uIHQDQAB7bbdXU1dKi4VvvxZh2yalM573F02M1mLiI42oTifoiWRItqgUM+rwvsP0ewo4Xbd7xlt7OpqE9UJUZsv/zzjik8EBMZLuFPvMAj59aRi80HhIUeFgOvnBb9FsEZyX/pMvB4M5eBh4BQCiD1F4F9zAgeJgAsrmC6lXlAQxkamXT3xOGAa2Q++9tyTjyJWLwHbhIzltt7yb5647AMrLSgICSLAnbvKmVsQqTDC7xLKMTYk8StzAE61VSoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ba18c84b-b503-493c-aaed-08de8eacc153
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 22:36:16.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzCreCLTOdcxfiAeSQbO71Ag2/m+EJ+wiOMDn9KWWqZmeS5OoIIJy60DkcZeFXk/OOYeBfuFEXCihCKYE07q01IPQC8+JIJxc0kjcRUsHZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4523
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273351-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,intel.com:dkim,intel.com:email,huawei.com:email,stgolabs.net:email,aschofie-mobl2.lan:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MSBL_EBL_FAIL(0.00)[daves@stgolabs.net:query timed out];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4A1E93620EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 03:26:41PM +0100, Alejandro Lucero Palau wrote:
> 
> On 3/25/26 02:59, Alison Schofield wrote:
> > On Mon, Mar 23, 2026 at 11:31:16AM +0000, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > By definition a type2 cxl device will use the host managed memory for
> > > specific functionality, therefore it should not be available to other
> > > uses.
> > Hi Alejandro,
> > 
> > I'm wondering if we're skipping too much, or perhaps just needs
> > a clarifying comment?
> > 
> > Commit message says 'Avoid dax creation...', that's specific.
> > 
> > Commit log says 'should not be available to other uses', that's less specific
> 
> 
> Hi Allison,
> 
> 
> Would you prefer something like "should not be available to other uses like
> DAX".?

The point really is that this skips 3 things, not just DAX creation.
So, address each of those things in the commit message, or narrow
what is skipped to be only the DAX creation.

see below...

> 
> 
> > follow me ...
> > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > > ---
> > >   drivers/cxl/core/region.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 8bb53a095290..2f9bdb4f1f4f 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -4263,6 +4263,13 @@ static int cxl_region_probe(struct device *dev)
> > >   	if (rc)
> > >   		return rc;
> > > +	/*
> > > +	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
> > > +	 * Skip device-dax registration.
> > > +	 */
> > > +	if (cxlr->type == CXL_DECODER_DEVMEM)
> > > +		return 0;
> > > +
> > And above says 'Skip device-dax' specific again, and is indeed skipped.
> > 
> > This escape is not surgically placed at the point where dax is added.
> > We are skipping a few other things before dax registration actually
> > happens. Why skip memory notifiers, shutdown_notifiers, poison setup?
> 
> 
> posion setup crashes with a type2 and I'm not sure if the memory notifiers
> make sense for Type2.
> 

wrt - poison set crashes with a type2:

Let's not leave a known crash to be tripped upon in the future.

The crash is probably on a dereference on cxl_memdev_state, mds, which
you guarded against in Patch 4/11 in other paths. I think this needs
similar check added to cxl_memdev_has_poison_cmd(). With that, I expect 
the cxl_region_setup_poison() in this path here. Success meaning it looked
to see if it's member devices supported poison, they do not, so no poison
set up.

I'm not familiar w the notifiers.

> 
> If it is really needed, I would prefer to support it as a follow up.
> 
> 
> Thank you
> 
> 
> > 
> > >   	/*
> > >   	 * From this point on any path that changes the region's state away from
> > >   	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> > > -- 
> > > 2.34.1
> > > 
> > > 


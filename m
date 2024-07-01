Return-Path: <netdev+bounces-108111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FD491DE3B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47FCAB2206D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95D1422D6;
	Mon,  1 Jul 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkFm3ltt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD603BBED;
	Mon,  1 Jul 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834059; cv=fail; b=eBgTjLzaNvQpRpWMzwUZkog+CzllSmvFTTOARvwV7plcuO5HY1YiEbFGrgi64S2dyV49QUKDtchwmWijMk0LJfSBhDw4jCgeI6Paaj+5WwogP7ajlN3SVsVn8Q+cNMkmuEUWG6Pfk64NmX7B08rfA1jXYGLxw2+qVZNkhkuXgSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834059; c=relaxed/simple;
	bh=aHCL6K2NYvNNq4Yt7sfNnDD4TCxLF04A702qEIVoZ8c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JM9B1UPihL7xCOMzdGr3QDRHnhlHKl1JjopVAddhtCkG7p93av6SNd4x9T7WE0OBPsj0g7AaBHzz9gZckxJ1fSlIvHqyn9KdKDaQm0WFGW7X2bT+lwBVkLK5R6N1fNz0opRzpedbpmJyiut+BJUtxae6pnFyaWNzsUiouiZutnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkFm3ltt; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719834058; x=1751370058;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aHCL6K2NYvNNq4Yt7sfNnDD4TCxLF04A702qEIVoZ8c=;
  b=mkFm3lttmrllijec9T6DlWYed0GrrX/sxp2H7gl60b4S1hdk853Ee3Tx
   XbKlKSJZQkbFHzC1pc0mQxgCRTl/G1xWklsQHenbWeogllMNqwoQz3hbV
   A0bHpfNPVzYpoiW8D+mYJyPn2yXSIahdgu3t2D+on16z/m3Q1xF3pH20Z
   JnGv2OxAbv/pMAk9oOWAq+hdiYv1fGYS1YZdNUI/cnH3g+oEPsvd3AkYf
   j0B8A9QWicXkTz4M0IG2jnotAlblc8lyQ/RLbdafKv5+e1nzFq/vlq7au
   4txQ7g1rmqI2aUhMGnSbELN7TE0tkIlxOwaW9wObQFduRcvEW1Ih7l/HM
   A==;
X-CSE-ConnectionGUID: J/4UhsB5S5mdIW7Gdf+CDw==
X-CSE-MsgGUID: VOMLPkeFT927Nu6ovAJcqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="16792608"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="16792608"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 04:40:57 -0700
X-CSE-ConnectionGUID: 4p3thiV6SMW/cr88VLVhKw==
X-CSE-MsgGUID: 1ILASUdmQV+kEgLRRi7HNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="50097795"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 04:40:57 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 04:40:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 04:40:56 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 04:40:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7n+V79vybooy55Uz1ARrli1sAfaDsipPvXZ2VoLts6m0O34Id7La42E8MfOFogk0KdjX6q/oitQKF2MO1Sus54kd/Sdb5gN+YqkuL6TdIPz7UfkWh7BGMrel/VohWNx6UIDUr9AZJpr1410LEo7ZEu/Q/OIS/kpIsQeJfX4V51jshJLbLKgnekzTPPEk7XqCpLmvxelKm/89850bQqnjUhvO2ngks6txPzYyPXwooiEU3K7ak4pdIAkegdP37IDk6usk9g690WwXFU3bYNEn8Q4Ez62XKcScjK8OFDo52D9XODnDV0WZBmySU8vpY82ubIrhgt1pCniPYs8BKZcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUHtq/b2H7CSJy/MERYF7M+o6ZWXUCWC/mJFywUIBuM=;
 b=JWO3MuNXrRKeLp0Dwki/F4vwbkRRcVW5uXy+XGTy55OlKJ70hTSYt+uZjLEYGLLgsrLnD45R+bI42+kqJKNcjSYtDGpqDsNvIEAkF0FwhRg4YGSvh83L66HjRjPMYiRL/5lGr+TQRvkutoHmjsuyM5V6Q/RNfhZicbX13LSg3RtpuNmr2SaeB+okxOUDlohCaTi1PzBoGwqgHsx4el9AX4C69/hnHQL+uzZuRPL7RbNdXxbn4vqgOrXO8mHzKviU8DBubPyjX01kPkv090vcme95Pc1GdvygpAYVN8aDYaLVsp8bi/J6nvshrXmxvaxwbNyh1VIqi72aJwqXwGsfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by MW3PR11MB4762.namprd11.prod.outlook.com (2603:10b6:303:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 11:40:53 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Mon, 1 Jul 2024
 11:40:53 +0000
Date: Mon, 1 Jul 2024 13:40:39 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Adrian Moreno <amorenoz@redhat.com>
CC: <netdev@vger.kernel.org>, <aconole@redhat.com>, <echaudro@redhat.com>,
	<horms@kernel.org>, <i.maximets@ovn.org>, <dev@openvswitch.org>, "Donald
 Hunter" <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 05/10] net: openvswitch: add psample action
Message-ID: <ZoKVtygkVYfaqjRI@localhost.localdomain>
References: <20240630195740.1469727-1-amorenoz@redhat.com>
 <20240630195740.1469727-6-amorenoz@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240630195740.1469727-6-amorenoz@redhat.com>
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|MW3PR11MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d97b828-8276-4a56-6054-08dc99c2a99d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4LgL28m1IKKErBx0IHtgAGBNf0FGMRSqWrHHZulW8y0WO6X14Li/C9MUHeG6?=
 =?us-ascii?Q?hsx2jUNcM476F2QTOCledUhUp2aF7j8ykvRoQIt6jNCGxi+H9iqUeRgtUeJp?=
 =?us-ascii?Q?Z0lSzqn0a6/7T/vzzb7ud6ZALATBIP7kmcr364/r0G2loUXGS7c0kzFifUnD?=
 =?us-ascii?Q?FlYqQujvjfNLD1iWbUGWT+3ISa92tKFFTpStsr5bHc4177UH+ih/KI9sFme5?=
 =?us-ascii?Q?H0TI/DvzqzCAUMiBZ4wT1hec8vZVwO5gL8S6Svn0+hh06b5VFocoKNaFKkfG?=
 =?us-ascii?Q?4uzfNJXghjY7DhwVFG8H3G7ftD8lDdnqH8VCbv+VmuW6Y+mMwL+tHVfrTRXh?=
 =?us-ascii?Q?HwbGXKREG5ie5vaMQvKnDxVh2GGqKFDZaXXtyhsVxXkbDyRnRSlR6ZwxV0M6?=
 =?us-ascii?Q?MEB8Z5sVJ0iZ+xFZsiLjMXvH6hNi7YmTzM51AiVQTVIzK5Ahnsxlqw6YHdgz?=
 =?us-ascii?Q?/+VdhSi1HitufYcK1SndMGeMTTYHa3GQ6Q0QbtJS8HprBHArXTgOo3sACp3w?=
 =?us-ascii?Q?mSd/TU2fY7MQG4t5ALV4Fwnu0WH3cxu9KJ01XPXXNGh+q1h34+JDcRJ+qcVr?=
 =?us-ascii?Q?w6ofaZXxfZbDRkUMuUBy6MqibbS+pA+9pCwFKiDJgZRfmqmVY8cfxBaeoddm?=
 =?us-ascii?Q?8EtsMjJgfyLLqk9neMmV58qD1x6ue3u4Wqvy2ZOqqljO5YLtVJ64gNSSMZnB?=
 =?us-ascii?Q?/IRRIzzlmRzFZvPQHnyrIgRyQxznCJRPuVzyPxOW49fVmrlb8MN+mt+ghgHv?=
 =?us-ascii?Q?XxqdMp0iW0OhUT/I9c1gzKVGOTP77fQhyZiyKnI4fyiuyunmAyTRKK0uSG8a?=
 =?us-ascii?Q?C68MuLvi/ZjNdtfY2Qh4DMsTFv6sxgZogVI0RzntUbvf2/2mr3JWE1lUzVLC?=
 =?us-ascii?Q?JEWAeWun1G/5hzib5zA8WRKlcJWJa3MggNTWGoj9s/CU/YUbwVwNAsY+jOis?=
 =?us-ascii?Q?Jc7iZyDUuBeZvt+Tko3TN4Ges3c+JLKDfyPuA1CXfHPSpY2bSpol9vtpCz+y?=
 =?us-ascii?Q?3B1kaLfb02T+6C6xhO1hdALlHkylb7HnT3iOsgMw1XHwon2a/RFfhMYy1f6e?=
 =?us-ascii?Q?Wsll+yslyxOekcz1Z3TGdlCMpM2Oh9l5k++5R5vO6VhDBSeeot8+KJ9qRrrc?=
 =?us-ascii?Q?cVWW4/WwShpApMJTnPPW6LIb0oJmzb95kmSZmM82hs97yI3JCJnhXYA+oOYi?=
 =?us-ascii?Q?vLfInj5OrahgpRlVeRhoI3zz914th56qHvKCKyYAla29ygWkLe1huBUzpwFG?=
 =?us-ascii?Q?1t7V/AMYu3jTXeC+YBvJlNlO8pTNW6a/dw/ZtMWdF4IEurJsiWu3IlEhFuAr?=
 =?us-ascii?Q?j/cN0lySj5J7HdOt8pAsJTRuoBFamDQp7F06YLcGb0799A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UmTlWB504bzd7AS2BDENzb+U3NKZrmJZOxqYAiEl4y6ee5h5kv/aZpYlzObW?=
 =?us-ascii?Q?qyBREeDj9lQ8L1WauUzg8w5EgwPcXsKQQGz/JR0ZQMupjHAxGjiih8ARUHze?=
 =?us-ascii?Q?QFz9aslHidutzmN3hVPdYVDoMUsDCHDw2X4mks7LltTJqdOEXr1RaZhgqH31?=
 =?us-ascii?Q?FK3gvaneXJsbverAJJZeKTKaOLBKIw3NZ68k8PD/3w5qEOrI89WXk9ApYBpV?=
 =?us-ascii?Q?ipWMwW6zkBODRfaevsMKrVs//PpJuIQEvQvJ9fWW9i0txeR5ob0BTfjdH4Nb?=
 =?us-ascii?Q?wSQuIVC7m9txV05tYxL5umms7c1ieVV+Ag7H9D2iJ11y8ymeZv6Hx4yAV5xL?=
 =?us-ascii?Q?oGDC3SEuXJWolyCDywEIOf7LSBVWy6VgjWzHLJi/k6/ARZ4EiH97IALuWvd5?=
 =?us-ascii?Q?fKxEqP4aXOfu4FsiukGfpdFqTQNtFlbznGuixka4JZeNKqzYwPfBlarfm5PG?=
 =?us-ascii?Q?9C2kYKQKdK4gMoWrlPZ+6dtShLjtsYqYR/Q5kZqDnod2uJje+Yn+j4zp937h?=
 =?us-ascii?Q?JsGjoXh3VcrC7yv24V9iwaHkgZvMZsuY+RhnHj+ZrYEgXGfZ8HIz1Oyk5wXd?=
 =?us-ascii?Q?MzA3KHLNwy/9ZJVmi4RVRzlPVYl0UlJkVWjFUneqTmpo44qag4HsrdbNFzqi?=
 =?us-ascii?Q?HydhqhSLZJOHVGiLFBZOeWHh8wlLZRHNSDngD6Jz5i2Ax4+p/v5c6DYlE7dx?=
 =?us-ascii?Q?1MLx6h6m+kkFDwS16pMnqMcBjASKSeT/HXMVS0bc8FFugbPjczwt85JYfUz0?=
 =?us-ascii?Q?wBW6lD60NXfv2nZde2KBF7MDwuASkzLqkiTHWr6v4OdBz43VJpwnsts2KAZS?=
 =?us-ascii?Q?JwFmbpaSQ+Zu6DmITbA4H0u0VJTNl6Tv8/WBWkC9oqdEqovPv8tkBRCd2sKf?=
 =?us-ascii?Q?1epY55dbaCo3zhLduuaSWcbMy9tv8G24onBFfsJNJOVbfO0Xtoc6ljZlNXt4?=
 =?us-ascii?Q?6TwREwVPe5c7qDLvLMKczHvI/zLESUTEU2VT7Q2T2U9mDK8tqU5c9OSx++Xg?=
 =?us-ascii?Q?/gRSMokrlZADavGgjM1r+ZanbfAkvhP2MO4mJKwoEHMJ1FCnY883ggJwt0WO?=
 =?us-ascii?Q?g49IRYEp5oX0Pjkw7wRpb2hftjH3vJIzTKshr9FlM/4QCJEe6CUQGrVe6EDh?=
 =?us-ascii?Q?hyLI86Ytwd1HkoWBUWNEZMMLurRs0n3kVdMocLV74Y23O5avgkMxti6B0U55?=
 =?us-ascii?Q?TD8V2q8bnSLg95+oxxyApp/lKjSttKzQhdycU9QCSq5ZFhP8/N4tq6lsFqex?=
 =?us-ascii?Q?/nqwF24AH5if+z0TDmefK3bnjDt2EsxDkjr4MwSVWd77UBt8x5EPoU8ctHl/?=
 =?us-ascii?Q?R0wcf+BDm7I7TtlJS1njjeP+ogUXvEStp3CTpKvntw7peRHnZdC+/TdWonU+?=
 =?us-ascii?Q?KO2a+xw/Mltzdf9jwc917e3jJm/DJ9MgiGWIsJUgKN4asgFywGCVaNOyOM4w?=
 =?us-ascii?Q?YA2Kzs0P2j2eMGYivfVjw2ufP4RwAvX0VPS1DodwU8PZ3kkcqvvAhL79bet9?=
 =?us-ascii?Q?QSsFHKs90hAwMpWbiMgah5fsgvVoIePHe3UOkoULfOeHbJ8aM50J6Tzg6ckP?=
 =?us-ascii?Q?OvKZvJOKMGT1fnT7M9uqsWMSskOmmJ1dLyCmtCy7I5myI6QfTGE2TqpVGxdN?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d97b828-8276-4a56-6054-08dc99c2a99d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 11:40:52.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAXj+bK+3HUpadNguXboUreHpvhE0uIAFemj1sx6SsiLuFelij2DKFL6d3xnVW7fC/2hFkJoxLm4fz+dFcRyfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4762
X-OriginatorOrg: intel.com

On Sun, Jun 30, 2024 at 09:57:26PM +0200, Adrian Moreno wrote:
> Add support for a new action: psample.
> 
> This action accepts a u32 group id and a variable-length cookie and uses
> the psample multicast group to make the packet available for
> observability.
> 
> The maximum length of the user-defined cookie is set to 16, same as
> tc_cookie, to discourage using cookies that will not be offloadable.
> 
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  Documentation/netlink/specs/ovs_flow.yaml | 17 ++++++++
>  include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
>  net/openvswitch/Kconfig                   |  1 +
>  net/openvswitch/actions.c                 | 47 +++++++++++++++++++++++
>  net/openvswitch/flow_netlink.c            | 32 ++++++++++++++-
>  5 files changed, 124 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
> index 4fdfc6b5cae9..46f5d1cd8a5f 100644
> --- a/Documentation/netlink/specs/ovs_flow.yaml
> +++ b/Documentation/netlink/specs/ovs_flow.yaml
> @@ -727,6 +727,12 @@ attribute-sets:
>          name: dec-ttl
>          type: nest
>          nested-attributes: dec-ttl-attrs
> +      -
> +        name: psample
> +        type: nest
> +        nested-attributes: psample-attrs
> +        doc: |
> +          Sends a packet sample to psample for external observation.
>    -
>      name: tunnel-key-attrs
>      enum-name: ovs-tunnel-key-attr
> @@ -938,6 +944,17 @@ attribute-sets:
>        -
>          name: gbp
>          type: u32
> +  -
> +    name: psample-attrs
> +    enum-name: ovs-psample-attr
> +    name-prefix: ovs-psample-attr-
> +    attributes:
> +      -
> +        name: group
> +        type: u32
> +      -
> +        name: cookie
> +        type: binary
>  
>  operations:
>    name-prefix: ovs-flow-cmd-
> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> index efc82c318fa2..3dd653748725 100644
> --- a/include/uapi/linux/openvswitch.h
> +++ b/include/uapi/linux/openvswitch.h
> @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
>  };
>  #endif
>  
> +#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16

In your patch #2 you use "TC_COOKIE_MAX_SIZE" as an array size for your
cookie. I know that now OVS_PSAMPLE_COOKIE_MAX_SIZE == TC_COOKIE_MAX_SIZE,
so this size will be validated correctly.
But how likely is that those 2 constants will have different values in the
future?
Would it be reasonable to create more strict dependency between those
macros, e.g.:

#define OVS_PSAMPLE_COOKIE_MAX_SIZE TC_COOKIE_MAX_SIZE

or, at least, add a comment that the size shouldn't be bigger than
TC_COOKIE_MAX_SIZE?
I'm just considering the risk of exceeding the array from the patch #2 when
somebody increases OVS_PSAMPLE_COOKIE_MAX_SIZE in the future.

Thanks,
Michal



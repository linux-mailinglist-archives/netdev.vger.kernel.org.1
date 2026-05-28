Return-Path: <netdev+bounces-292693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFivLDtDGGoEiAgAu9opvQ
	(envelope-from <netdev+bounces-292693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:29:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1767D5F2B92
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67869305091E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADFA3F39E7;
	Thu, 28 May 2026 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iH69V7Jl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5F3F164F;
	Thu, 28 May 2026 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974670; cv=fail; b=LUXEw5QxxtSuCOd4H0cmZmpw2o65+/pKUeye/LUYuP5S5ip0LxaIPXC+j7nTp7Ft0KPiLcxDg/oH3bkgK/W2AtRGVWKVCt3ub1MJr/CJZ/CX8PTSVtgfhocio15Nu6OjLXmib+afRjTViiJfLmvpj610002LUHlbi/cOxPXoUQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974670; c=relaxed/simple;
	bh=yugKi8naSwvcvyjghhkXmwGymwtV99G1jPdrIgyVboY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V/EEyEXmYezIwivlcRTmfXELH28mZNGLSye1ueFHYP8BukWB1KAmnzhPsRNonbZMwGZnk7cOUdlLocD1C6Bu6djQZewa8fhSPaON3MUwgx3VGrp0tjOCuLowCLtSs2jvhdnOO4GcfU4vTSFzqhQL47qZevVSehf9Z8TEVAce1g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iH69V7Jl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779974669; x=1811510669;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yugKi8naSwvcvyjghhkXmwGymwtV99G1jPdrIgyVboY=;
  b=iH69V7JlzrYOg/hp0NbZTylTCaYNK9D7iT0jsWtgmr2eWVgYPoIsWlU7
   1+pDD3JLTRD2bbRH3eXGEaiXmZVC7FNj7IcCW6ALCfZGCu1zByNSt22ZV
   mRtKKZcsWXFkqGNaU/JdhlFrf2UIWE2V4VB6OTdXvjaT4ZO+QqAsQf+ds
   kjaAq1D8acWJmY8mRIRVodkzOUc/pi+I3FhzBd4glfcZFmxragG4V054b
   WfGlTiKSDtl7kv7hDvBgLHk8QAaeF0j1b7FVa/FY/WK988P4yARO5jF2T
   OudfDC3WIVQQod2+uFnJNGBkjV3zwkZJMCcrq7MCwee5WO30POCrE7FJH
   g==;
X-CSE-ConnectionGUID: Dfd6cahdTe21iBcOUOjXcw==
X-CSE-MsgGUID: R+ZaK3MIRr2PhjReIzmm2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91925963"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="91925963"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 06:24:27 -0700
X-CSE-ConnectionGUID: K2rbCxTgQSe02w4H5HsgQg==
X-CSE-MsgGUID: 1ePqlPRtSuiDedl57THf6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="242707918"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 06:24:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 06:24:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 06:24:25 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 06:24:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhRGYJXKcCyRJlG7wm1NXkE2/6wgm3ckse4Su3R926UXGSk2rN6Jbs4er+OrP9IWpon401DZ+Kgysq9emarc9p9S0RTSh29WmGVTkT8Tmy+c/k9SjVBENIlgMQtPnGZTKu8EmshMCAFEh94Tt4SjfB/zf8/9eXqP8dEhJlx7ZSxnF+Bh1dCbH9ZY5thGwdh3f5GFLhlFMA7UHAQ1mNjF2yP1lF2boMRldYHHjlqCH/gTeTei7ECLhvR9qwVxbqtwxmz+8qc2p3ucejhiZaYO2NdaTI/Pdsuv2LZhhnpSM1Vp/ADRGmj1dXcPecJ4Xna8O7B8FgXrl87Yzq+Rr/lRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TznqUSPJoyCd21a1OkgJCCn52ag0kie6PImicq+pdEs=;
 b=SSkpAG5DSgYCfY1Z3Y69NQy+k731wnf3uAponalVYSplJaUkfdkNak8DZb+0cL4YrQYKopE/syqjdJf43cpqdzPytsXempZoFvVEoiMHePQiQ8pX3qedLJ5RQIcon03mbG4RcT5FJ9IjTC5JBv1ffHakfloOLHCHR2mFtfXcovbSqupjXjnTqI2YZOLA6W6EGar1qBFekXwYOgQEuixGshlJwrS7YNzE0BJco0q80gkMgttd337o1L9xNA7Id86GCcTQJDEASP3ygExtUs7KS2xNv9PPV6/PbjrWfHm4KLV/oDe5pabqR9yRLvFbCryYGC1MqeIkFH/OOHHx9kqwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ1PR11MB6177.namprd11.prod.outlook.com (2603:10b6:a03:45c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 13:24:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:24:20 +0000
Date: Thu, 28 May 2026 15:24:06 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <bjorn@kernel.org>,
	<lorenzo@kernel.org>, <toke@redhat.com>, Liang Chen
	<liangchen.linux@gmail.com>, Yunsheng Lin <linyunsheng@huawei.com>,
	huangjie.albert <huangjie.albert@bytedance.com>
Subject: Re: [PATCH RFC net-next 0/4] xdp: reuse generic skb XDP handling for
 veth
Message-ID: <ahhB9ufMk2tIlaoc@boxer>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
 <d784e8d3-e6af-4437-93f2-3103720b8454@kernel.org>
 <agdjjtlXxlzy6Mx5@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <agdjjtlXxlzy6Mx5@boxer>
X-ClientProxiedBy: VI1PR06CA0193.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ1PR11MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c74cf7-33d9-4f36-2100-08debcbc6d0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|13003099007|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 9WFQjGWiQ7WsXYvTUz/1nkSkK9tXDr7N17gQARig104pSU0L7hm7KtfWBiUNAQxBqtVqyFW1Q92TrzO2NAkob4HpyF3nMZdQgao7LSlFXsB3y36IODd1hsnT0b3xQ/arnnw81R9DMQ9CSoLeNJu1Lcp4oRLbP7sI4laNIkpPBDLOlNHs1CqUv2U3Unq3rj645ZBlpXZkKXxAM3sdjxSmG0bi1jS/ZQHo0lD0uuu0swUnEf5ULk4tgge1zdg1aOHonfD8LSUhsgt1Igtwi7XGSQxsr6tBZC2Z1vDQzK231nNwcsL31o/CCshIyBGwVzIoWgl+Ll0zU6E7yKDJfCWYQWcT/26TJmfdRLbVIl0LHOsCZuTk4SkaJ8ODtOBAhOXV0dH3D/6rRDu/XJo+kkzMiqa87syGAmcXqOMCOmCtTfdxgm+NRV8jTuSMZzSMF2yZ7r1ZZN2V09ep1j6xmDbBO9Y4DgMuzBr5b121CAJ8h7oXGjz18wheeS9ZyvgJ6pJ86s/JaTZQrb6pzhRbkR131+cnKHiGqf9W4BIsVCsVyv0CUdnzbG3uWaMI3v+Umj1u0WrQ6Da8KWHk/R/wc03T7xGly295CX1NEpm8dekXJBYq8oqMPlaoiQlOLbYRXohH4sKTlDlLk01j5KGzGXWfyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(13003099007)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UjTl9OVTjqv62gJtKRqIf8XEV5a+Pj47c4y8tYVF18N06gF3ppEXiiIfbBcA?=
 =?us-ascii?Q?CTFxlKDACAI7HCcwxl0VbwpC5l8dhCbpcUBSthwwrV9picR4x6JkFs2La/0D?=
 =?us-ascii?Q?cbJYoWUyzsxSjSpavQXBNNyVskydgTe14VUjwEYO2uSUUYiH4h4fBJmLRNwY?=
 =?us-ascii?Q?jrTfZ4HXTXG804WXOYOkUEZbB7/GXNEJ2HfCXQ0H7SxO4nObuZVBkKMWPFIB?=
 =?us-ascii?Q?aqCpRavx/3eVM1wBQsU3g1S2A0D6VX1jvUyu1XH9z85ndzuq9KikdlWMv1cl?=
 =?us-ascii?Q?dzqmfBiZiXHhHQ4GeVFB0ZdKq3aKCD8cq1mq97fFTupdd7CoOetWaeYMmU/G?=
 =?us-ascii?Q?v1Y7g9e5zSFXkY9LFCX2SRkpASqI2FLlKZ075IF/UuMLXp7cmc9ylonmMu+i?=
 =?us-ascii?Q?kqN1oHiatJcoeps6QKv9gWdiImDBrBQFVk+NEWsVFnvKY8BpQa7ZTDjsBrn/?=
 =?us-ascii?Q?FcSHDLozW+9sEdlBKILb1JSrIV9TFcefqzTnkCEFcpvo5gwaFNKfo2nHk0dC?=
 =?us-ascii?Q?LMVEV3arNBmDlbD/Wa8if6to7jF+IbJMDqxV62vQMnAw7pCGXRlPkQ6/3fFu?=
 =?us-ascii?Q?NpSa4KJa7lZ1mzus+Pi6AVFrG7g86l/s9W/7lhU+P92uFQdGQAmfcwg63IT1?=
 =?us-ascii?Q?nN/wKb7UcUepQEazRbwgmNcfzfO1IFZcW2NhmRRUIFZEn8yzig7mALonIN5B?=
 =?us-ascii?Q?jXO4MVRbWfO0/G/eZ7UlcU1BlU5bZOaHoV8IoNUY6OVEgIT4X2SAwwQ5Ipdk?=
 =?us-ascii?Q?bZQ7CTTZVe1gm4ol9l48U2Q0gqha4AMLnpTttsczNc1fqpRgqWVT6/YYFVW6?=
 =?us-ascii?Q?cH0vjsIxtlenXbOSX+lei5Lm4WB/3R3zW6i+GQbOk1qmGS6szVz3x4ktlrbS?=
 =?us-ascii?Q?6CISFIr13zqVxuxJeTYJa7wLhB1OvU6yvFAoHU8UolgX7J502X17TTkZeD2E?=
 =?us-ascii?Q?1bq/VB5GwJGsW1sRVeEwfGQ4u1b4a72DQXVoSXotKmFmE3h1nKOy9MzmSytb?=
 =?us-ascii?Q?cLgHTcoRmccofi9W7K7q4Hn7o/Z+MIcHQ6sE8g3B3HizkK32VSrEp9M/CPeK?=
 =?us-ascii?Q?86aLPi1itbWgxZMaidd0g/zVArXGZsGSm0JU+mGEzuCPmNQ4sijbftj00Wnn?=
 =?us-ascii?Q?eP103AHbXuwE4Z732ulOwMpe0l5HL/8NV+9FLafj7TBMBSMtNa/jACVJugtd?=
 =?us-ascii?Q?oMHeCEsBEi1outpfTjsQLnqo7+Jq4ZMVrPMmtzRNnNDWsz3hvf+8gX7kVMHD?=
 =?us-ascii?Q?spsPSPS8u4vDOxPs1EJ+5T1lfCFyIMag6sLQjcREsOLfirWer7T+BtLpFXbn?=
 =?us-ascii?Q?pMBa2bccUa/SefcbaS+wPpAuyL2n7OgMTShBTSewONIa/0b3NOzslTO3HkmH?=
 =?us-ascii?Q?Vg/bKjKG2zAhzpu3cKB4m6fEAE/N/mvqrEO2WEjN8xCzH6hG71aHJlUsP9kc?=
 =?us-ascii?Q?GJXx40nCS9vcHWBkUXX1Fd1AdXiUjUQJ5uvMpFDgDcHkzMF+K6Z+wC03rPU8?=
 =?us-ascii?Q?Q1eC41lsvwpxQHcJrNP4OcFB8GImcu3FX/atX2wcfN62LysLtmZt3/MAp61Q?=
 =?us-ascii?Q?JjmLlywgXz0ir/5FEorREBUhoh7GbzQt4QJRq0ktAIiE8mU5uixnmwGW1Hcf?=
 =?us-ascii?Q?8q8GOKOjH+Y5wpffU9bjsBzuUYcWz6hubTN17jFfxryGZsIBscfaNHPunTrr?=
 =?us-ascii?Q?akP02yXQLCjBnRcJe4VjzjzGeLIgJ04ksKoga7RwsXlRff1Nf7iSS/6Awa6G?=
 =?us-ascii?Q?7aqyprV8wNxH+FN5+cz/WYZJVcdkUog=3D?=
X-Exchange-RoutingPolicyChecked: RtU0KgP050463HN9bTHF1NFR86iGpFtUW3uw2wvkwLW7xp9biHiKtVKrct4CjP5yYqIJVOZbrlI0equ6bA1WejFT+fRnqPIFgtZJ8QqlhOSa6XWZAC+p8gqp7bYLFQ/31G7afyRH/yVl75LXP6Y7UfMvgPQt/TZ5E5K0PP3pewWgNcCzOJQUaPW5IGdu3QqdKoK2v+Hy07KObNmGxTBVbue9AE2PVW1cIUixmxefBx3NQONHqHoyIqLqhujb8et7iqt9BqMJk6yVtPmuxfvlxnmE0A1Tv1KzO3E4Mvefqp76nDljj0ehehsGIseM8lxxaMqFjc76vmi107BZWfxIOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c74cf7-33d9-4f36-2100-08debcbc6d0c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:24:20.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYUkNQ3QhUN46B47kp9c4Jv/eteLoDxnFZ1FrYwcpGAQ0cdep6N4lq/T2xGIshIgD6hInVbVSwEi+sTa4QywQ3kSuHCbODhW1iaoGRxFUZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6177
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292693-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,huawei.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com,huawei.com,bytedance.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1767D5F2B92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 08:18:54PM +0200, Maciej Fijalkowski wrote:
> On Thu, May 14, 2026 at 07:13:07AM +0200, Jesper Dangaard Brouer wrote:
> > 
> > 
> > On 09/05/2026 10.48, Maciej Fijalkowski wrote:
> > > Hi,
> > > 
> > > this series is an attempt to make skb-backed XDP handling in veth use
> > > the generic skb XDP machinery instead of converting skb-backed packets
> > > into xdp_frames for XDP_TX and XDP_REDIRECT.
> > 
> > I support this idea.  Thanks for working on this Maciej.
> 
> Hi Jesper, good to read!
> 
> > 
> > I basically proposed the same back in Aug 2023 [1].  My patchset[2] was
> > motivated by a performance improvement 23.5% see [3], that comes from
> > avoiding to reallocate most veth packets when XDP is loaded.

Hi again,

see below.

> > 
> > Please read veth_benchmark04.org[4] as it documents a number of
> > pitfalls, and highlight that the main trick to avoid reallocation is
> > changing net_device needed_headroom (when XDP is loaded).
> 
> Thanks, will do
> 
> > 
> > [1] https://lore.kernel.org/all/169272715407.1975370.3989385869434330916.stgit@firesoul/
> > [2] https://lore.kernel.org/all/169272709850.1975370.16698220879817216294.stgit@firesoul/
> > [3] https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark03.org
> > [4] https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark04.org
> > 
> > 
> > > This was brought up by
> > > Jakub during review of previous work, which was focused on addressing
> > > splats from AF_XDP selftests shrinking multi-buffer packet:
> > > 
> > >    https://lore.kernel.org/bpf/20251029221315.2694841-1-maciej.fijalkowski@intel.com/
> > > 
> > > veth currently has two different XDP input paths:
> > >    - xdp_frame input, coming through ndo_xdp_xmit(), for example from
> > >      devmap redirects; and
> > >    - skb input, coming through ndo_start_xmit(), for example from the
> > >      regular networking stack, pktgen, or other skb producers.
> > > 
> > > The xdp_frame path is naturally frame-based and this series keeps it on
> > > the existing veth xdp_frame handling path. The skb path, however, is
> > > still fundamentally skb-backed, but today veth converts it into an
> > > xdp_frame for XDP_TX/XDP_REDIRECT. That conversion is awkward and has
> > > been pointed out as undesirable before, because veth has to pin skb data,
> > > construct an xdp_frame view of it, and then restore/massage XDP memory
> > > metadata around that conversion.
> > > 
> > 
> > Yes, I really dislike the veth approach of stealing the SKB "head"/data
> > page by bumping the page refcnt directly.  If is awkward as you say.
> > I would be happy to see that code improved.
> > 
> > > This series takes a different approach: skb-backed veth XDP now reuses
> > > the generic skb XDP execution path. veth provides its own xdp_buff,
> > > xdp_rxq_info and page_pool to the generic XDP helper, so the generic code
> > > can still perform the required skb COW using veth's page_pool when the
> > > skb head/frags cannot be used directly. XDP_TX then uses generic_xdp_tx()
> > > and XDP_REDIRECT uses xdp_do_generic_redirect(), while the xdp_frame
> > > input path keeps using the existing veth xdp_frame TX/redirect handling.
> > 
> > I also used this approach in my patchset, so I like it.
> > 
> > https://lore.kernel.org/all/169272715407.1975370.3989385869434330916.stgit@firesoul/
> > 
> > > The problem this series tries to address more generally is that
> > > skb-backed generic XDP can end up with memory whose provenance is not
> > > described correctly by a single queue-level MEM_TYPE_PAGE_SHARED value.
> > > When skb is COWed the underlying memory is page_pool backed but current
> > > logic does not respect it.
> > > 
> > > For that reason the series introduces MEM_TYPE_PAGE_POOL_OR_SHARED. This
> > > type is not bound to a single registered page_pool allocator. Instead,
> > > the return path inspects the individual netmem and dispatches either to
> > > the page_pool return path or to page_frag_free(). This lets generic
> > > skb-backed XDP handle mixed page_pool/page-shared memory without
> > > mutating rxq->mem.type per packet.
> > 
> > I'm unsure about the introduction of MEM_TYPE_PAGE_POOL_OR_SHARED an
> > ambiguous memory type.  In [5] I considered adding two new memory types
> > MEM_TYPE_KMALLOC_SKB and MEM_TYPE_SKB_SMALL_HEAD_CACHE that __xdp_return
> > would handle, but I labeled is as an "uncertain approach" myself.

Further thoughts on your concerns I have a feeling that your mem types
would not be needed once we start to treat skb properly from veth's POV.
__do_xdp_generic() will kfree/consume skb. we will no longer return the
underlying skb via xdp_return_frame so __xdp_return() does not have
to be taught about mem source of skbs that now live in xdp_frame.

Plus, Jakub's point still stands, in XDP generic hook __xdp_return() is
only about releasing frags as in case of skb being non-linear we will hit
skb_pp_cow_data() and get back with page_pool-backed skb.

> 
> I assume your hacks were done on top of veth without page_pool being used
> for reallocations? Otherwise I have to understand your reasoning. I had a
> bit shattered week so expect response on monday.
> 
> Just as a reminder, I need this to be fixed as currently AF_XDP test suite
> splats heavily when we encounter skb_pp_cow_data() calls and
> __xdp_return() still sees MEM_TYPE_PAGE_SHARED when packet is shrunk via
> bpf_xdp_adjust_tail().
> 
> Also seems all parties agree (Jakub's response) we should come up with
> common conditions for taking the conversion path (and bump veth hroom).
> 
> To be fully transparent I assume we have to include Toke to discussion as
> you guys had discussion back on your RFC.
> 
> Thanks,
> Maciej
> > 
> > [5] https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark04.org#uncertain-approach
> > 
> > 
> > > The veth part also removes the old rq->xdp_mem juggling. For incoming
> > > xdp_frames, veth now uses a local rxq view whose mem.type is taken from
> > > frame->mem_type. This preserves the frame's original memory type for
> > > XDP_TX/XDP_REDIRECT without overwriting the persistent rq->xdp_rxq memory
> > > model used by skb-backed generic XDP.
> > > 
> > > One visible datapath change is that skb-backed veth XDP_TX no longer
> > > uses veth's xdp_frame bulk queue. It now follows the generic skb XDP_TX
> > > path. The xdp_frame-originated path is unchanged and still uses the
> > > existing veth bulk path. The old skb-backed path had batching, but it
> > > also paid the cost of converting skb-backed packets into xdp_frames. The
> > > new path removes that conversion and keeps skb-backed packets on the
> > > generic skb XDP path. From my local tests that consisted of
> > > pktgen + xdp_bench I did not notice any major performance regressions,
> > > however Lorenzo and Jesper might disagree here, hence the RFC status. I
> > > am fed up of internal wars with Sashiko so I would be pleased to get
> > > some human feedback.
> > > 
> > 
> > My benchmarking in above documents, showed that needed_headroom change was a
> > bigger performance boost than loosing the batching.
> > 
> > For a long time, I have considered adding batching to the generic-XDP code
> > path, simply via SKB-list trick.  I did an experiment doing this in the past
> > and my benchmarking showed 30% TX performance boost, because xmit_more takes
> > effect.  Given people are not suppose to use generic-XDP if they care about
> > performance, I never followed up.  If veth start to use this generic
> > redirect code path, then it makes sense to do this. In production we have
> > code that does XDP redirect of SKBs into veth (I have recommended to
> > redirect native xdp_frame's instead, but because traffic first need to
> > travel through some DDoS filters in iptables, it cannot be done without
> > first moving those filters into XDP).

If I provide sufficient headroom on veth side and lift
skb_head_is_locked() check at netif_receive_generic_xdp() (that is now
called from veth via __do_xdp_generic()) I do see a similiar improvement
on my side.

The counter-intuitive news is that skb batching via list does not yield
any better numbers on my side, I believe that you referred to a case where
you used real hw with xdp generic hook which had implemented skb-list
batching. I'll look a bit more onto this but feel free to share your
changes, plus I think that could be implemented as a follow-up if we agree
to move further with these changes. Just wanted to clear out the new
mem-type approach.

Thanks,
Maciej

> > 
> > 
> > > In particular, let's discuss:
> > > 
> > >    - whether MEM_TYPE_PAGE_POOL_OR_SHARED is an acceptable way to describe
> > >      skb-backed generic XDP memory that may be page_pool-backed after COW
> > >      or ordinary page-shared memory otherwise;
> > > 
> > >    - whether passing caller-provided xdp_buff/rxq/page_pool context into
> > >      the generic skb XDP helper is the right API shape;
> > > 
> > >    - whether letting veth provide its own page_pool to generic XDP is
> > >      acceptable for avoiding the old skb->xdp_frame conversion; could
> > >      veth just piggy-back on system's page_pool? even though it could,
> > >      we still need xdp_buff being passed (metadata) and other refactors
> > >      that allow veth to bump stats and do the redirect flush;
> > > 
> > >    - whether skb-backed veth XDP_TX using generic_xdp_tx(), while keeping
> > >      xdp_frame-originated traffic on the existing veth bulk path, is an
> > >      acceptable split;
> > > 
> > >    - the INDIRECT_CALL for taking the COW path; I wanted to preserve
> > >      existing behavior, but is it really needed or maybe it would be
> > >      possible to come up with conditions that would cover both generic
> > >      XDP path and veth?
> > > 
> > > FWIW I do like the end result on veth side. If I missed CCing someone,
> > > mea culpa.
> > 
> > Added Cc
> > - Liang Chen <liangchen.linux@gmail.com>
> > - Yunsheng Lin <linyunsheng@huawei.com>
> > - huangjie.albert@bytedance.com
> > 
> > > 
> > > Thanks,
> > > Maciej
> > > 
> > > Maciej Fijalkowski (4):
> > >    xdp: add mixed page_pool/page_shared memory type
> > >    xdp: return status from generic_xdp_tx()
> > >    xdp: split generic XDP skb handling
> > >    veth: use generic skb XDP handling
> > > 
> > >   drivers/net/veth.c        | 179 ++++++++------------------------------
> > >   include/linux/netdevice.h |  33 ++++++-
> > >   include/net/xdp.h         |   1 +
> > >   kernel/bpf/devmap.c       |   2 +-
> > >   net/core/dev.c            | 124 ++++++++++++++++++++------
> > >   net/core/filter.c         |   2 +-
> > >   net/core/xdp.c            |  54 ++++++++++--
> > >   7 files changed, 216 insertions(+), 179 deletions(-)
> > > 
> > 


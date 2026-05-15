Return-Path: <netdev+bounces-288410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD4uFKhjB2q90wIAu9opvQ
	(envelope-from <netdev+bounces-288410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:19:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01F5560DE
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58D1C3001043
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83C403143;
	Fri, 15 May 2026 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZaQCEUE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DD3D75AF;
	Fri, 15 May 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869155; cv=fail; b=uH0tQHLT32WDE6Lcd20dpFrBrMXuKNWcoqZf4U4bkLt78vqmLimz1mxyBGInyP+whPnYZwARhOkKxX0pbBL5E8d+kmiMIR7PNzQ2Ue1WEUoPPyeSqKpXjHxc4GVsIFaimunQLcr1mccqceWApMetcsoRWpiRycFQx9c0LeCuHio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869155; c=relaxed/simple;
	bh=ixg80JKyVlkGBdlPLeGDm9y1b3WY3p7rsWMIiMFH2Ok=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=poQ2gYonwv1XhtFIC0vMaAVvCJvZtTJItbqMHsPykwaIVVDw9Gnh9SZsdqTE/JpAYUAiqu0oCsZxy4c8jrSGH2Ip0A3yqSKgnDDm4Z9L1cFGMTNF/810C4FnjSjJEuMpb8ugswCch3lbXh2vDWOy1OA0ddJUiFq0eui4oONZFpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZaQCEUE; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778869154; x=1810405154;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ixg80JKyVlkGBdlPLeGDm9y1b3WY3p7rsWMIiMFH2Ok=;
  b=VZaQCEUE0eXcd+2BYAFULKuKmfbtKWiUM0/2QYbLG0HG3pa+UsNRI9c3
   r00bXFzHpfPaXVLRdVeRDru7e+sA8EDzO+APtYSIXGciyw2DeTljJhBL/
   t1Yjb15Y9H8yNP7GztCWAUQewGwrJ4hL97aajaX0CrcHFkE7YuEauvcrS
   6Gq5TID7+0eqZMxTETGIH4Dgqsco95FJRAD/I1jYoS6LinGHkeJ+aJatY
   d7lqI8HSu/Lq+73xVQKLY808MST7FPSfGaBHMQShAyyF2vSNMGa3nTkgD
   aV6WAdiHM5vF29ON8DIVhBJQiZvT0Ed/5siC7oJUR6Sirk2EJLWsP0E72
   w==;
X-CSE-ConnectionGUID: ZqKV/L4TQZGbfKq7ixQquw==
X-CSE-MsgGUID: RazPQPrYQNmynV5XVFHvjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79722160"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79722160"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:19:13 -0700
X-CSE-ConnectionGUID: cxytWu0rSxq+++/RHXAf+w==
X-CSE-MsgGUID: XCIh7EECQGWNikT1jSo2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="234316338"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:19:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 11:19:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 15 May 2026 11:19:11 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 11:19:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNvgMV+aAi7meXJ4tqqbb7g1mirWLTgMq1FNHAuZZz74f8VbmpTZeqbFQqpNjB9IaOCpb+ERXjI6V0W8Vyn10jftEQrrf6++GStRnYFdeEm9ncummNSOXIjqde2LiVzCv7hca+rdjk/dC2D4YwsmKRXFh57093LSvD8WeK95kWUCyaMj5/JesSvrIjNYw/EaYIV3NHo8P/3QSaEw5UdbCdQtLhsIqC9oCmE58aQ+14EjlZeOBYz+4L6dTZuTcF8utGS2PFHvkuIHAPeNfieBbkgoz6azeLRSljo0zZg/4MmQJpH20N7i34/InBlpeMJPMc0vhpN9IrOqhaEyC79Zqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsYXWbxxA/TFnNastMuOlh4qkOGo7kBtgjjMZGmfavU=;
 b=c1P3IrVQKqCKbywsLgIpjFKRyLoImkVue2vBszkQDFiP27v36J109MKbVcOU4EHSB45XVEUzb/Wlgsnwc9hZBbRkvYSo6trcH85agwaGyq/c9PYmlTOGYEAvhd9iE2cNZbBa841b6UIGEd/lJ8wGKdUQ+lsZIt+SqI+xfGjWVf4DiMfAL9Ph/buT9YFbfKMeElU+osZTaGGWVXI24Whe58TsaO7QQh63xi5CIDnKbhkcbVFKI2TiQIy9rkqxTlHZeAXxBoUNlqhvhwbiJOoZVUcRmQ2yRPp2TfJzrYyvfjpbYsTWRITYSuYORV+6tCQIgwuJs8eV+xD+DK+425LCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7928.namprd11.prod.outlook.com (2603:10b6:8:fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.14; Fri, 15 May 2026 18:19:09 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 18:19:09 +0000
Date: Fri, 15 May 2026 20:18:54 +0200
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
Message-ID: <agdjjtlXxlzy6Mx5@boxer>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
 <d784e8d3-e6af-4437-93f2-3103720b8454@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d784e8d3-e6af-4437-93f2-3103720b8454@kernel.org>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: b77a890f-4981-4821-bc54-08deb2ae74dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|13003099007|11063799003|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: mxrEuMU4evkNcdEscVnW9u/RWOcKKVDEfNDTA/o+uc+kkk8ep3TpEJWtHUqha5V4oyAaWoH1LE/SsRHiIsO5PzVEz29E+1QtC6TbkLLYFoSmAwGOcq7EVpzMVAA0wN1SOSD9hAXNECJWQL0JkbjSsQxXSdhhnlzfyEFu1NOFNX0O0Qoq22CvpieGmNtokYtzvFe3mLC5/x9kfGfW015AUt9Yb9rK2KxvpMZwnmaZoxWrgnFzwYzMk1Xq1Is/c3Ubfszh5DTSErbeQev3NlRT5zix0zHsL18s16IwANNHAy1GOnL5Uydmsa45ijNX6zcySkvGex9h+TndIdG80jDR/UDxhRaHkSbB8qH5sYr5pQDPeeX4mJ+rPKAVMdIEAdhRSY+wVKlxO3CO+seC5SbXuFU/v/aOGy28LhCs/nRAkz6jfc5xH20neu67dupUvXrKt0DDilomSmJUDf0oR4xQZPpRdq6LVP0dXRih0zP+vxlYsa/Oq+2Yxw/qPrH/ZaGAMTxjjlP+Gsm75fp9DNtsewcSDWBMoHJLAYlY6+eMaK473KD4awMuWRebS/INEZO0Zo2KvUJzYVJMMg+ePIl293TpZeIbCtfnXhyfQ/adyrJk3xDIrRBglKVuJcyDfxpt0GI+kDdKHL6BUW9ox8nxew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(13003099007)(11063799003)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJUpWbUu+Jp4HzB8d5p10nMv/t/uUIISUyUh1ErN6ovDTE6ssGuJ+LsB+zd2?=
 =?us-ascii?Q?yAjK4BI8PqBfOYKe4U3RCQPD4llKmuPbRHoxLG5Y+TSalec3rx9l6FTGntlP?=
 =?us-ascii?Q?RPZi2R0h+4so/7Z08yr2Q9YD7+9rfe4dVCnzuo8rW/ngPz2ahzftGMC9ZSrZ?=
 =?us-ascii?Q?wTk++rV5G8+zbPCljaxdHDExIsfjffMPM2+LhBLtUBfceU7Y1MquYMrB5eFN?=
 =?us-ascii?Q?tlcKDZ4SnvUqAOfAJLYQmX6X2ClHxyW7xdrbi90DlK6TtnAFE1eNunhflQl/?=
 =?us-ascii?Q?hCiJx7NDRqS+ez51yXmuxlapPsGF5ANbL3jFZy8WjbE9hRDClSYu/gVk2THq?=
 =?us-ascii?Q?Nk9aH++lt5xOR7B7S1yhhWSzoiXwDeccmBpOWjEqT1s1CatzWcaULgMJUTFM?=
 =?us-ascii?Q?mntIFOrrMAN4CFgLl6nzYEbhyKT99O+GhSZ+aUBw0BIkiDqjj/QHaHrENnGQ?=
 =?us-ascii?Q?y0lsxSUqpcamcFpuf1T+imFQUb8XDHkW6rSEVVENNEPP/z3KnJGaY8hAqHDK?=
 =?us-ascii?Q?keRB2QrxBOsuNR/dbyBW4vQLRGUZg36SQG/FFCbICsOSGFRvIfhkueOUyjzm?=
 =?us-ascii?Q?VSz7c2tfvoxxWiU2QWG0A9+Ojo1xRzd/rsqtPKEmTYvAibFT1qrVVDBZZBKl?=
 =?us-ascii?Q?CVuwRuYtimSHtfyGZ3yRct8D1BkiLjgLNFqR7n0ZjVZyLBLb6l4c8fHt9Ux/?=
 =?us-ascii?Q?uKdW6n1npe84Gwvu09y03gIViHlXq3o8eED8KpJlBZrACDnXWFtBEk0q4Ykd?=
 =?us-ascii?Q?+EKDphYxx0x6doGHhcaKDzFP3MIfUQ85KBur5pAXXWvW1c0mwI+FBq5tLNMX?=
 =?us-ascii?Q?zDED/splMqW0Zx/yIau8BWos837727AVBm7o1kt+pLkdB2nEtmvqTGLJZo9o?=
 =?us-ascii?Q?GPFJB8YvvnPS/5YBWZLPIGfOYAOpvG+81A258QZ+6vL8V6nGXFyQYK/5kxcF?=
 =?us-ascii?Q?nPWFnzd+i6W9twRkqTDpezYaWdVsmKOKmJ0h5Lii3TJT7HV4ZaPdJ9DkAGgF?=
 =?us-ascii?Q?8CTrQSHq4LBHIEjvRb3QJynhjnXyj8nyUnTt0WmTw/4qsW30FxMaveTJjhzw?=
 =?us-ascii?Q?sn+MePcUxZbQ0znjg2ZpRBrbmzUo7gf7zXnxTfCEnlyJkHFRBL1Ge2cQw4+2?=
 =?us-ascii?Q?TsMgaghprh5E3HEB7YTCbg3+b5SSyHwOLBX3AS3pINxCrqaPkqFwnbO33jwj?=
 =?us-ascii?Q?a7EcmtpUSug0rpOuk9N0nqH90ZGfxsnrE/71b1bDOcaLtdjGhe30IsqE1aEX?=
 =?us-ascii?Q?DgnCuKMEYl+u8xfU8ykC7LjfLdjDIwo4LvnY+WZ+EH/Uk5t2FYbLG7NR67sX?=
 =?us-ascii?Q?czY5keGrg/yotkB+OPyD9DADIVfYZTd7E94nrCZq7IN03J03h9aN1uleHtgI?=
 =?us-ascii?Q?JaCwe5OgLBpUcOtFlO9VM51m3TIdkZitBGqeqRD64Yqnhza32gW6u0/v0Mvh?=
 =?us-ascii?Q?Ti46uD2PVpGssGyI3R0apU8h9VDyCmhTwQrOQqt7TDSYqNvoKugCgawxxyGW?=
 =?us-ascii?Q?B0ALhEIwntGorHuqrwKmMrvMKKFm+xLD25rUK1ZvI+jSTqrM+e6d8ywKEyb7?=
 =?us-ascii?Q?NOPbBGu+st02jrDM183DvT+OucA+74AfGsKSy9q1oziTrGjLOr7H6a+uspt6?=
 =?us-ascii?Q?XC7BCMPt9zgTm6WQzWGMxW+XEKY6zlGNEtPvQZ7Pbke1x20lQGlSXcLezPLG?=
 =?us-ascii?Q?aZ+jPCnt9ca2atnT8j6G8AALg4+AIb0cpb6ClNbhaD1Ol0E/SiSctyWbqCui?=
 =?us-ascii?Q?X9AT5XdHAwLI1p2IP1HFC/CcY+Anu+o=3D?=
X-Exchange-RoutingPolicyChecked: oZqv3lSVejEXgyO6kSpBHvP9HRX//7Cs9eH6HR4Ylso+gZKmCN+efEUYD3etGO8fEGLceOc6hAMnmdPh2UJXw2yz3UAEZCgnBNeaCp620sf7LdP9iO5rwR4CXtyhRVKJM7UPSwUxSspCjJZereDKIle+UBu61UxvsPMBhGzP8urAmQPzzYdUhvi7cxdub7XjjTY4qgJy0AsLgShO9jcRyGEaUjqEoand4kkLXOVUdZREOMhBOLrjWkItWUq25+PNbXdZC0QygBlZYDibPNwXLOZ9j4Plpyea9Pc0JI6cFNSCOVHZyVDDQShBpi5OxcPlCfY1Y3G3ueT/ClkDZNPAYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b77a890f-4981-4821-bc54-08deb2ae74dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 18:19:09.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUSIpsMoMYQNbdhmhYlCxdAnJ4nsAseYcC65rl4CbIMgFQsO8iIrYbmDTliFZDyIEOamlLFAsIT58trdMf/8fqwZzxF3+pDafdQT0xNNsrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7928
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4F01F5560DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bytedance.com:email,huawei.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 07:13:07AM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 09/05/2026 10.48, Maciej Fijalkowski wrote:
> > Hi,
> > 
> > this series is an attempt to make skb-backed XDP handling in veth use
> > the generic skb XDP machinery instead of converting skb-backed packets
> > into xdp_frames for XDP_TX and XDP_REDIRECT.
> 
> I support this idea.  Thanks for working on this Maciej.

Hi Jesper, good to read!

> 
> I basically proposed the same back in Aug 2023 [1].  My patchset[2] was
> motivated by a performance improvement 23.5% see [3], that comes from
> avoiding to reallocate most veth packets when XDP is loaded.
> 
> Please read veth_benchmark04.org[4] as it documents a number of
> pitfalls, and highlight that the main trick to avoid reallocation is
> changing net_device needed_headroom (when XDP is loaded).

Thanks, will do

> 
> [1] https://lore.kernel.org/all/169272715407.1975370.3989385869434330916.stgit@firesoul/
> [2] https://lore.kernel.org/all/169272709850.1975370.16698220879817216294.stgit@firesoul/
> [3] https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark03.org
> [4] https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark04.org
> 
> 
> > This was brought up by
> > Jakub during review of previous work, which was focused on addressing
> > splats from AF_XDP selftests shrinking multi-buffer packet:
> > 
> >    https://lore.kernel.org/bpf/20251029221315.2694841-1-maciej.fijalkowski@intel.com/
> > 
> > veth currently has two different XDP input paths:
> >    - xdp_frame input, coming through ndo_xdp_xmit(), for example from
> >      devmap redirects; and
> >    - skb input, coming through ndo_start_xmit(), for example from the
> >      regular networking stack, pktgen, or other skb producers.
> > 
> > The xdp_frame path is naturally frame-based and this series keeps it on
> > the existing veth xdp_frame handling path. The skb path, however, is
> > still fundamentally skb-backed, but today veth converts it into an
> > xdp_frame for XDP_TX/XDP_REDIRECT. That conversion is awkward and has
> > been pointed out as undesirable before, because veth has to pin skb data,
> > construct an xdp_frame view of it, and then restore/massage XDP memory
> > metadata around that conversion.
> > 
> 
> Yes, I really dislike the veth approach of stealing the SKB "head"/data
> page by bumping the page refcnt directly.  If is awkward as you say.
> I would be happy to see that code improved.
> 
> > This series takes a different approach: skb-backed veth XDP now reuses
> > the generic skb XDP execution path. veth provides its own xdp_buff,
> > xdp_rxq_info and page_pool to the generic XDP helper, so the generic code
> > can still perform the required skb COW using veth's page_pool when the
> > skb head/frags cannot be used directly. XDP_TX then uses generic_xdp_tx()
> > and XDP_REDIRECT uses xdp_do_generic_redirect(), while the xdp_frame
> > input path keeps using the existing veth xdp_frame TX/redirect handling.
> 
> I also used this approach in my patchset, so I like it.
> 
> https://lore.kernel.org/all/169272715407.1975370.3989385869434330916.stgit@firesoul/
> 
> > The problem this series tries to address more generally is that
> > skb-backed generic XDP can end up with memory whose provenance is not
> > described correctly by a single queue-level MEM_TYPE_PAGE_SHARED value.
> > When skb is COWed the underlying memory is page_pool backed but current
> > logic does not respect it.
> > 
> > For that reason the series introduces MEM_TYPE_PAGE_POOL_OR_SHARED. This
> > type is not bound to a single registered page_pool allocator. Instead,
> > the return path inspects the individual netmem and dispatches either to
> > the page_pool return path or to page_frag_free(). This lets generic
> > skb-backed XDP handle mixed page_pool/page-shared memory without
> > mutating rxq->mem.type per packet.
> 
> I'm unsure about the introduction of MEM_TYPE_PAGE_POOL_OR_SHARED an
> ambiguous memory type.  In [5] I considered adding two new memory types
> MEM_TYPE_KMALLOC_SKB and MEM_TYPE_SKB_SMALL_HEAD_CACHE that __xdp_return
> would handle, but I labeled is as an "uncertain approach" myself.

I assume your hacks were done on top of veth without page_pool being used
for reallocations? Otherwise I have to understand your reasoning. I had a
bit shattered week so expect response on monday.

Just as a reminder, I need this to be fixed as currently AF_XDP test suite
splats heavily when we encounter skb_pp_cow_data() calls and
__xdp_return() still sees MEM_TYPE_PAGE_SHARED when packet is shrunk via
bpf_xdp_adjust_tail().

Also seems all parties agree (Jakub's response) we should come up with
common conditions for taking the conversion path (and bump veth hroom).

To be fully transparent I assume we have to include Toke to discussion as
you guys had discussion back on your RFC.

Thanks,
Maciej
> 
> [5] https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark04.org#uncertain-approach
> 
> 
> > The veth part also removes the old rq->xdp_mem juggling. For incoming
> > xdp_frames, veth now uses a local rxq view whose mem.type is taken from
> > frame->mem_type. This preserves the frame's original memory type for
> > XDP_TX/XDP_REDIRECT without overwriting the persistent rq->xdp_rxq memory
> > model used by skb-backed generic XDP.
> > 
> > One visible datapath change is that skb-backed veth XDP_TX no longer
> > uses veth's xdp_frame bulk queue. It now follows the generic skb XDP_TX
> > path. The xdp_frame-originated path is unchanged and still uses the
> > existing veth bulk path. The old skb-backed path had batching, but it
> > also paid the cost of converting skb-backed packets into xdp_frames. The
> > new path removes that conversion and keeps skb-backed packets on the
> > generic skb XDP path. From my local tests that consisted of
> > pktgen + xdp_bench I did not notice any major performance regressions,
> > however Lorenzo and Jesper might disagree here, hence the RFC status. I
> > am fed up of internal wars with Sashiko so I would be pleased to get
> > some human feedback.
> > 
> 
> My benchmarking in above documents, showed that needed_headroom change was a
> bigger performance boost than loosing the batching.
> 
> For a long time, I have considered adding batching to the generic-XDP code
> path, simply via SKB-list trick.  I did an experiment doing this in the past
> and my benchmarking showed 30% TX performance boost, because xmit_more takes
> effect.  Given people are not suppose to use generic-XDP if they care about
> performance, I never followed up.  If veth start to use this generic
> redirect code path, then it makes sense to do this. In production we have
> code that does XDP redirect of SKBs into veth (I have recommended to
> redirect native xdp_frame's instead, but because traffic first need to
> travel through some DDoS filters in iptables, it cannot be done without
> first moving those filters into XDP).
> 
> 
> > In particular, let's discuss:
> > 
> >    - whether MEM_TYPE_PAGE_POOL_OR_SHARED is an acceptable way to describe
> >      skb-backed generic XDP memory that may be page_pool-backed after COW
> >      or ordinary page-shared memory otherwise;
> > 
> >    - whether passing caller-provided xdp_buff/rxq/page_pool context into
> >      the generic skb XDP helper is the right API shape;
> > 
> >    - whether letting veth provide its own page_pool to generic XDP is
> >      acceptable for avoiding the old skb->xdp_frame conversion; could
> >      veth just piggy-back on system's page_pool? even though it could,
> >      we still need xdp_buff being passed (metadata) and other refactors
> >      that allow veth to bump stats and do the redirect flush;
> > 
> >    - whether skb-backed veth XDP_TX using generic_xdp_tx(), while keeping
> >      xdp_frame-originated traffic on the existing veth bulk path, is an
> >      acceptable split;
> > 
> >    - the INDIRECT_CALL for taking the COW path; I wanted to preserve
> >      existing behavior, but is it really needed or maybe it would be
> >      possible to come up with conditions that would cover both generic
> >      XDP path and veth?
> > 
> > FWIW I do like the end result on veth side. If I missed CCing someone,
> > mea culpa.
> 
> Added Cc
> - Liang Chen <liangchen.linux@gmail.com>
> - Yunsheng Lin <linyunsheng@huawei.com>
> - huangjie.albert@bytedance.com
> 
> > 
> > Thanks,
> > Maciej
> > 
> > Maciej Fijalkowski (4):
> >    xdp: add mixed page_pool/page_shared memory type
> >    xdp: return status from generic_xdp_tx()
> >    xdp: split generic XDP skb handling
> >    veth: use generic skb XDP handling
> > 
> >   drivers/net/veth.c        | 179 ++++++++------------------------------
> >   include/linux/netdevice.h |  33 ++++++-
> >   include/net/xdp.h         |   1 +
> >   kernel/bpf/devmap.c       |   2 +-
> >   net/core/dev.c            | 124 ++++++++++++++++++++------
> >   net/core/filter.c         |   2 +-
> >   net/core/xdp.c            |  54 ++++++++++--
> >   7 files changed, 216 insertions(+), 179 deletions(-)
> > 
> 


Return-Path: <netdev+bounces-302147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e6WLGplePmrFEgkAu9opvQ
	(envelope-from <netdev+bounces-302147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:12:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325586CC4D8
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:12:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=oDLIlMk8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302147-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302147-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 167C4301751C
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63BD3F0A9B;
	Fri, 26 Jun 2026 11:12:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0C3F0760;
	Fri, 26 Jun 2026 11:12:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472340; cv=fail; b=e7C1NI9crTVEgiDP8AcOTJyGwasUZuJFlsQ1JqZivOCLX766vMc0a4QKwZkXIDIwAujVNvIhi3l1AkAn8qDEQtdPpiZkuitkVL0uYR03hBG+gURVVtDlJPsllqzyYlVmiBYaO7wQsl/W3eK1wB/v1pix2VHO9VI+D4Fvfh9rzBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472340; c=relaxed/simple;
	bh=mcJh4+sWuy0PzqTkOfjLmmCMNpeguH7xzvfjMMhq8RM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fTU63LRLbQXbasgXe5hEolEWICA3ySg6Woc1rFVzB6c9Y2B/cxUyQr2u1ADM6Pb/epQFLVXfjWqHTyg5Oy7WTB9qJ7VzYFIDmumT/tUikeU3Bb6mcSbEyu7tkd0unv4ma6HmLKx1EglPfvs+9eAEasIleWlvmlN8E+8f7gmwd9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDLIlMk8; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782472337; x=1814008337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mcJh4+sWuy0PzqTkOfjLmmCMNpeguH7xzvfjMMhq8RM=;
  b=oDLIlMk8DCTD991uPVfaAry9D7VB9O4p1plex4+Zt5sMqUdjpEFgotCD
   YdZcmae087BC2NV1M8W/gQpH8bLVAHO9hONXARYm3uvqbezICxRmKmokR
   C0oEqfLuOfC+gHyt8ppj9quQJ62QjJaLoe01LW+NLkHPfdfwDEK2zzH7K
   8NQ453eOf619VwxicJGAOLekk+kj4pIBqYByBWlL5YSk8Vz9K8yOTVyRh
   lIpgbdWs+RSX6+2uHvjOQVS1sP6q2Yf5xthm37j7L0f4j05ohtI26IFXA
   T/VGoEuAvMkGeMF1xa0ynHD5H3TQbNg1r7JAbvv17PMmz3z3XFMTSIw6e
   w==;
X-CSE-ConnectionGUID: 5c/gIP5aTaqxmCgzQSkU2Q==
X-CSE-MsgGUID: xsnfc2wPTmOyszNva86hrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="106059175"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="106059175"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 04:12:16 -0700
X-CSE-ConnectionGUID: dvXXVkF9SKyf1lnMLHCggQ==
X-CSE-MsgGUID: WSyD3xQmS1mefTkX18jR+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="251460001"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 04:12:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 04:12:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 04:12:15 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 04:12:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2CPvP/CKw+NQZz+QPTzS0TGPjUIaksAA5fcHwIQCJ41lWLJbDW0dMne5aQWTaDC8/xgWG4RqsWO3Epa2eAKRgpDT3+IYle5SpuUN7FTPlWmdJ6+VodloCBVaNayEeWwqpuuM7omxv17dLxqtQYE0j6FUbQEtJvBjy7sMt/uXvRuYssuQSQ1hnMPwOXgzpvF2g7wCYqKUdbqLhNji+Gjr5y/Q3vrvPt6gpFKnP3PID7PDHPP0prYAUITYfGrmt138pYOxXLiDjEWpNHS7pLFu4Oa4Ml5/EyqvwJZX7eCKoCoypEcne5wMS1n9roDrbeoEu25AdUHI6+sd5dTAp3uTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzqQ2J3C3J4Hjph8H8G6ne1gC1yAGRNJ6wu2T60S9rc=;
 b=Vi4IGxZ2W9xq5BD6JVvPDxz7BGSa7oKlPNW+8sS29i6D4IDEZ57Q74WKGtbsiw+R4QLNEvSiHexivt1Lzl6UJaWSNuFP4+Am5DKsPRIttJhveuv7fShHAFsRIFcnaDsLqU905SCESnk/9d2XRiAFcIrobU/8FwaCDebTTCEjssPYTS0tN9KPTHNd1dCVZK6x8Zycd+ujE+Xo0b3wbJxS63X8PcPTWkE0AHq8JFTk91Su1mXxmlrtoub+Rp8HNMrO3GKJj9V96uPpm/PDWMFLjuAO5Nbo/Nk7DdxgXyMCkU2fGQfSwRhaY67urM+bn4oucmmSS16vzSJ1aZzy1fr+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2556.namprd11.prod.outlook.com (2603:10b6:5:c6::10) by
 SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 11:12:13 +0000
Received: from DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac]) by DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 11:12:12 +0000
Date: Fri, 26 Jun 2026 13:12:01 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kerneljasonxing@gmail.com>,
	<bjorn@kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/7] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
Message-ID: <aj5egH5eDwfsY30-@soc-5CG4396X81.clients.intel.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-2-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260623133240.1048434-2-maciej.fijalkowski@intel.com>
X-ClientProxiedBy: VI1PR0102CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::45) To DM6PR11MB2556.namprd11.prod.outlook.com
 (2603:10b6:5:c6::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2556:EE_|SJ2PR11MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d18352-cd3d-42c4-a609-08ded373c5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: mQplUFeJBvSBYNOgix7y4XVbcbGqs/Rl/1d6fTrxuAb3iqkb7yatrt+G3GQphuLG+KOA9JDbMmRKVTpGDgeQuL+en/mtBeo42OtEVKEDVGff8O9BMhSaOpdHjx9qFzg/Y3wYkPsKE+dZsSFFzznLek1jXpQicbaU420fOTcA+fNRePdwMJMhZmkPgFGyW0wGmAYvfrx72G8LWqKTmlO1A97T6WGCqqJCK1mncWTn1AO4ZS21o2Agx4n61gHzmE3aPxk0vSSExCNcoRns53H6C4N2LTi9Vj9Bg4PL0buikA/x1xKiK/CzjPfExhXnjxrJNWQJ0YNtWdwyW+4gaE9741F4gmNkgncX5tBdjhRUHVhGxXmIc1r6DPl4Ab7a0PgkSzWqrDtPCc30OOghtY0EsyNdk/K/YlZvk5y1fjNwh+xWR+7Ju9IefSU/bBrumE7ZG/KU51O3ylfMqtlxY/+m0Of4INBqV07TonrMVZCpOvqhon82ej+dig5orcjF20BLGk8yToJdShyxf/0Z41TXbsScWcASwI5GUS8uehPU/YvVtwAcNWYv5x29KBPtSpGgI2lwQK7L3/XdIUWBZrvzMvS33K+9tAcpC0QYGSYmLPXS3yfJtLmCNx3+WjCopYpX+Jag4XbUR8Eoak1F0fF89m7XQOxVPD6Km6jcvGLQc5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?66sWxujSVQQrQ/MNJsJz06jG19WjRXP+6cuZwj0VWNAQdIeHtwPARxupgn8P?=
 =?us-ascii?Q?5cPN8aJSVFkQAZjRNm65zDPlQNjIJ7cikl8EIdeX+FePLcWSkCc+uaCQowtY?=
 =?us-ascii?Q?CaQab5lTRSmI1XxJRJb4nPJSo6LNm09UkY6siBTVw43/KhuNLQHCkKt8ByXj?=
 =?us-ascii?Q?W8eJs/Dd6guyC59nyPI6EUbXoaINOxioBxP98gR6617aU8sbwQkAXRprzcCl?=
 =?us-ascii?Q?PB6KtLyHb2wmoK+/yM56vtWB9b/izSZYoJJtsjSa1g+u1HIIy8Cr/161gAYH?=
 =?us-ascii?Q?rkyraeBYe1Wg7vm8R/Cld0Q9wq55qnVLOeBNQ0KffCECQR8dUEhspNghaU/Q?=
 =?us-ascii?Q?EfX/Bwlg6cJKB3diJAFwpIY3HoVW4pGSGSwCGVR8nrxMRqQ3M/YH13pQje7n?=
 =?us-ascii?Q?kqPs5EW5fi5yreLhY8aZOR5y+WsOdl+nAkGfMp5drJ3Q7jxNrPCcK0Yq2B8j?=
 =?us-ascii?Q?A1NcXJ6IxWHRnAnQ/g45t1d8WwOgbRATK9K+vX87E3V0mZfah0HypqqJzBCu?=
 =?us-ascii?Q?001pAx24S05BnxbeCXLl2K4GXixI0cN5TJgpzIQQkIDxfd/ud8Q8iypTNf9v?=
 =?us-ascii?Q?LbjsORkGS7DmMdTmJSxFzxPuHLWl2zWrjHOdXPmmG2OtAUF0KdN7y7v9FE0k?=
 =?us-ascii?Q?eHTz9voYn6GmccGmUsUe2oktepnopgt3UY2RvXPBHEl6JWSkl2gO1XSdADC4?=
 =?us-ascii?Q?6zgrC+TFwf6/RQUxPOtkFj8eIkLyqQt+qogxOu09N7K2Tl2MwNd7UDvVKPCM?=
 =?us-ascii?Q?+dl5HfyUW4N0F3Er3SDOkA8RGBQX31yETIML+id+kKyWmlAdYc3IoF/3UmhA?=
 =?us-ascii?Q?WUUbiJcCg8hgvrWDQD2PQq1/tUWVAhBgeMsGcRB3K8wTskVhkOcES2qCuWs8?=
 =?us-ascii?Q?xQ2sYVn4gx7GwWfdrPTV6Hw2z8KkBC8ZUhyKRnBWewDrWV98EkrbNkw/hrjq?=
 =?us-ascii?Q?6gsKnV1DgBHq90keMw8QjttUabW20xDDgG2Ev9QLxKDDB5j2OzvOkIX+qBrq?=
 =?us-ascii?Q?ZsqAhT/evDl/DHjfJLlKElUUuLqwRvrOj9bnyB1+g7xwlSH61S+pYCLTdDT4?=
 =?us-ascii?Q?6IiKgc6d73hientkaBlGNDs2VcXV4RClT8eCTLwVG1iVIfupPLJRa9nNbyZn?=
 =?us-ascii?Q?NqOboOc2e4ODjKN65k1tRhiGz7gdjYTP+s/7Y1/IQNyLC+j6YhVZAlLpavkA?=
 =?us-ascii?Q?8tbU0pvEi/oy8Agyo8IrQwnzobjuKIB50FcXkM2zfeoVN8Ee/y6EEZLSZ1xF?=
 =?us-ascii?Q?Vxf2sTCqYVC86mf4GiI/d/M02X2ReZhbgV1qZfr8L0T9LITu3R7vaMhpOtGZ?=
 =?us-ascii?Q?D3qhzUv7BHjVULvfbyl7AKimPsjXJoB/egMwk+6coXBpVGhysf4cmbE7f+Dv?=
 =?us-ascii?Q?DjLgWiAIC0X1bLXfeD3rW4AMCL+X9JX3SOnXPf2sSsI6tcgRClbL6FL6mGRz?=
 =?us-ascii?Q?m1Fy72z/y2jwDFasSD0eI3BZ8/OSV6nSJ2zcq7xj/nEQCnBxn6D7/AnoNZQe?=
 =?us-ascii?Q?2jHmuzuycCADMJV7dOKP6sLFzYLpnSKXaRzgiBgogZgRze74iKpDKvcCVIl6?=
 =?us-ascii?Q?IXFr/Z8eT0t7vnDJFGVGCe0GX5kxS0utLN/OR2LQgIswZt6jXb3ufV7xV0s/?=
 =?us-ascii?Q?NmuBPf3CHNvBTfp6dFpAXzW+BcWa0r5qK7uTzk+cJsEImLEG59TN52oT7azs?=
 =?us-ascii?Q?9t4xSJjVSYbG2/6tJ2M7xW2adhj3WLR4QipC5w5Wd6aAoHIJNkEFrtHNcyGV?=
 =?us-ascii?Q?thZsWb1kaqwHW60H5OFpcks7weAgJJ5PTm/J0Ntx3LrxwWSHKy4rX1JCVeXR?=
X-MS-Exchange-AntiSpam-MessageData-1: nsMNj1Lo1ZrOYdYIi1ajraVZzy3SNS0JKBc=
X-Exchange-RoutingPolicyChecked: ZgbNlTm/oYrXI9yw1vsMeorB6oIJdqHLNUdKj7pmQOrJhvnWWwunUboLmQqPBc2Q8cRAhKErFVZ0avReuGLm3sVVpO+LxGD3tcjjSo+61F4x0Gw0Jb2c6J/i7fyUKoZi3xo/tDXzMRthzIqaYaFR5UPlFDT9cvz2/h8dTXbn81kybz+I9hzWVVOLKl5P97tKHgkEZNoM3rnR+AEUpnHnwc7TmooufsBG+D7x13ReNZ/jDwpO859iYveR8LnoQ//7bSKlG79ldVG9IK/feAZ1xcvJX1eSiqL+fXnVdQw8oqSknakbFFD7st29L32VyY1kGtpP/M2AGQdNCzIKJhQEmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d18352-cd3d-42c4-a609-08ded373c5a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:12:12.7730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbr3u9mQ8cH/wNkoNsoIALIxb+wvDqFPtKpGJRqeLwUFN7RiOSmxab+cPjQYwpyEv3BdZROYLctAQswynzmwmfKQfXOG9eaSM4X12ByoF6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302147-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com,tencent.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:from_mime,tencent.com:email,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:bjorn@kernel.org,m:kernelxing@tencent.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 325586CC4D8

On Tue, Jun 23, 2026 at 03:32:34PM +0200, Maciej Fijalkowski wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch is inspired by the check[1] from sashiko. It says when
> overflow happens, the address of cq to be published is invalid.
> Actually the severer thing is the whole process of publishing the
> address of cq in this particular case is not right: it should truely
> publish the address and advance the cached_prod in cq as long as it
> reads descriptors from txq.
> 
> The following is the full analysis.
> xsk_drop_skb() is called in three places, which all discard a partially
> built multi-buffer skb:
> 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
> 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
>    the TX ring prevents the partial packet from completing
> 3) xsk_release(): socket close while xs->skb holds an incomplete packet
> 
> In all three cases, the TX descriptors for the already-processed frags
> have been consumed from the TX ring (xskq_cons_release), and CQ slots
> have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> the buffer addresses never appear in the completion queue, userspace
> permanently loses track of these buffers.
> 
> Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
> destructor, which already submits buffer addresses to the CQ via
> xsk_cq_submit_addr_locked().
> 
> Note that cancelling the descriptors back to the TX ring (via
> xskq_cons_cancel_n) is not a appropriate option because an oversized
> packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
> which is an obviously deadlock bug in the TX path.
> 
> Also move the desc->addr assignment in xsk_build_skb() above the
> overflow check so that the current descriptor's address is recorded
> before a potential -EOVERFLOW jump to free_err, consistent with the
> zerocopy path in xsk_build_skb_zerocopy().
> 
> [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/

This change looks good, but overflow case with only 1 descriptor worries me.
In such cases, once we get to following code, kfree_skb() has already happened:

	if (err == -EOVERFLOW) {
		if (xs->skb) {
			/* Drop the packet */
			xsk_inc_num_desc(xs->skb);
			xsk_drop_skb(xs->skb);
		} else {
			xsk_cq_cancel_locked(xs->pool, 1);
			xs->tx->invalid_descs++;
		}
		xskq_cons_release(xs->tx);
	}

kfree_skb() should have resulted in submission of the single fat descriptor to 
xsk_cq_submit_addr_locked() via xsk_destruct_skb(), so far consistent with the
multi-descriptor bevaior you are proposing here.

But what happens when we cancel a submitted CQ slot via 
xsk_cq_cancel_locked(xs->pool, 1) in the above code?

> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index b970f30ea9b9..a7a83dc4546a 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -794,8 +794,11 @@ static void xsk_consume_skb(struct sk_buff *skb)
>  
>  static void xsk_drop_skb(struct sk_buff *skb)
>  {
> -	xdp_sk(skb->sk)->tx->invalid_descs += xsk_get_num_desc(skb);
> -	xsk_consume_skb(skb);
> +	struct xdp_sock *xs = xdp_sk(skb->sk);
> +
> +	xs->tx->invalid_descs += xsk_get_num_desc(skb);
> +	consume_skb(skb);
> +	xs->skb = NULL;
>  }
>  
>  static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> @@ -877,7 +880,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  			return ERR_PTR(-ENOMEM);
>  
>  		/* in case of -EOVERFLOW that could happen below,
> -		 * xsk_consume_skb() will release this node as whole skb
> +		 * xsk_drop_skb() will release this node as whole skb
>  		 * would be dropped, which implies freeing all list elements
>  		 */
>  		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> @@ -969,6 +972,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  				goto free_err;
>  			}
>  
> +			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> +
>  			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
>  				err = -EOVERFLOW;
>  				goto free_err;
> @@ -986,8 +991,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
>  			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
> -
> -			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
>  		}
>  	}
>  
> -- 
> 2.43.0
> 
> 


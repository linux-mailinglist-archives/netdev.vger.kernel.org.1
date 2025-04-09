Return-Path: <netdev+bounces-180720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F487A82413
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425054A58E3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9117D25DCE9;
	Wed,  9 Apr 2025 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0LqjkUa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77C2253E4
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199951; cv=fail; b=sV6ol2bf0TANg3pWOFLBKgIRaRBaDumuRcJPmxMub9Eb3nq32K44tXBXna4IfZosyVXUjaSgBahULaqIgJHQXUcFajm1fdIESgQOFNyPqhocCl/qQ+hcYv+W3sTC6HkSi9zsNB3Zntll1gSjuNnRpFDc2EfUX7TD8X7wtYqmLic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199951; c=relaxed/simple;
	bh=OA63Amg+328TQH21Odb1E1k+KNewPeYETTf0Iq5NMeY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UkS3tjkQqfOfju8ZNDPbB69APos2Rms9Xo509jwZ2z7SyuxxrsB5sykkrN8Z3RUAptaorIQ6eBn+zZkfRAtfAan4WdMKk9zlAE84gjVBspQYixoxSsPsLUlp5ZsDgkhibXPejAnJheBNl3cRXUYcwlj+3xMGewUwtTwD+J6RCOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0LqjkUa; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744199950; x=1775735950;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OA63Amg+328TQH21Odb1E1k+KNewPeYETTf0Iq5NMeY=;
  b=j0LqjkUaVM5hS3BvdHRdachuMpQoHy8tXcuQ33Gux7gRjQGNYvBdkvXG
   UofCFUl4XUyjoO57ZVp3JntraJHw56uWh7LqVY7Xq7vEm9k1kqHqCE8gv
   V8aFJOjzKd0OuVoGG6YOIsVCd2s8Tlkd5wV+JY27awoV7WnTt4slPkmbs
   fd1o6oZ+/EFUFSeIZNoL4X5WDgqa/fAC6ejtGjkNpky3E8hYPo9vt/dcy
   YEOF31yE1IRaQkbXrfx1lywsxRCjWLpMAwsPYzwWDMAr8ANopVDNS59OC
   vjfcQoz/xFZwbdWBqbJjWDPHpte5mXV4NdwCE4U7g5Z1Tm4FsV2ImG2rx
   Q==;
X-CSE-ConnectionGUID: eNV6WrhvS/iqlkJEkKFIsw==
X-CSE-MsgGUID: EjO3NZpjTaKap7joO4XLUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45562428"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45562428"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 04:59:09 -0700
X-CSE-ConnectionGUID: NWsj7yn8SNO5+FfDtnRTRQ==
X-CSE-MsgGUID: zQ0s9X8WSQOp9CKuWw7irQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="128430336"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 04:59:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 04:59:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 04:59:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 04:59:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXx9BoUsX3sPd1NDuPC6SQjyUozI4qLgSwf2ybsBtlde+mkmNymSFQsZVsJxUHjHMA3ZF3kw96WchwMTDvYlvB1JyLK0FIlePrqqKtT0tEpI773nqZM5MglFzJiBFTGy1w+X71LYK3l4oqnOEP8s2xD2MsaKj+e1wt6QHkoIGgrQs1DUxmtDITTPHll+IQQZWWxZe96HnXIUteHKRBXpQLhQlZnDMmh8dUaz45j3d9UManZmZVd7l19ccLjcj4CkE7ljjUezFNB6+uAdrLRZmXwZUIZuyCFX1TEDySrJM8MoYJf+JxhIfZDXwOkxE8BCbtSBp/zQvMNJcV1ozJfnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noRcURbmHgSUQKo84R3HGLkH06UwpyYAqimoNcy3Q7I=;
 b=a08C7wn/p9tHx6BS9/N2l6Pomp3TR+eHHAPxiXSlW58HmbRsERcNIQS2eKQbuNzbLKlWcwah8rrxeW0DSh0hXMOREl7droDRt0jr+DQnzP8ENufRpxs74k0QNUPA7bhGBQvmmVhAfnQHgmtpeYtJtORCApDM8/8fLQF54wJSBj1BgBzRhDw5FanW+rJ4TI46bU+h25OWIzjA2IeSjq0HmllT8Gw092zNvV2J4STzg+9GCjX13/HWHFzsVwDd4XnR7NO4UZlRbWuGlYr9g/O9ehb3n/5pwxshmjQPDq84cr4zFE/Y49YYwSx5/4yrq1qJzIzdr5qruT+kCZNyxhB1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SA2PR11MB5033.namprd11.prod.outlook.com (2603:10b6:806:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Wed, 9 Apr
 2025 11:58:51 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 11:58:51 +0000
Date: Wed, 9 Apr 2025 13:58:45 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] Add L2 hw acceleration for airoha_eth
 driver
Message-ID: <Z/Zg9XXuU0hpmGeO@localhost.localdomain>
References: <20250409-airoha-flowtable-l2b-v2-0-4a1e3935ea92@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250409-airoha-flowtable-l2b-v2-0-4a1e3935ea92@kernel.org>
X-ClientProxiedBy: ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::14) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SA2PR11MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2bfa07-6d0b-4767-abea-08dd775de502
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?raejYIeSO7Vftmeiqr0vObJuGjoDlhDYnMBme1xDmsk2PRWSqYRQoCInbxoC?=
 =?us-ascii?Q?3xz//a+AI7TcCVWo+WT+MYzZt+YSnBiBRFucptJOJzI08QC0kmLwH0MfM059?=
 =?us-ascii?Q?2uMSkBGMCWAUF9oACN0nHQ0Ot6HCiaQpgVxim1LimPvW9VM6mBL3Z4QogyDN?=
 =?us-ascii?Q?79w3WbCgG4AKCIKUvZGfXmv7OdxHSPd01xNqcOWn6qnPp4McyrVsF8qp+5E0?=
 =?us-ascii?Q?P53ZcKoxkb5AVoMnk62Wdyb50FWPnXl6WZizRLSo1EhoaqB854uNMg9s8Y5a?=
 =?us-ascii?Q?PhGbUUNUUg2fmRBCmuCRwi5bc0gfHwr2j5S6kXVsgkaHmGlQPUlU2KC6/rhG?=
 =?us-ascii?Q?d+edN/6yqyHF/4d58DB+v0ckWO3pSAh0ubR6IR+SNH7flrEi4N35eBmNM75w?=
 =?us-ascii?Q?zSH6Y+N/wYlLcfzRrtOq/WzDQv15UTDLU9bb1lMJ5ZwZalCr9bOSdkYt086I?=
 =?us-ascii?Q?PmjMG3FK6pfIQwgxxQ+KxaawkhrfJKezZVvuY6TaI+M2iFKj4KkLAFiN4/BB?=
 =?us-ascii?Q?57EEaHanHmcqRbTJtg7MHmLw1YJCvvqDxR07JLMJwsZQXclac+KlDob2TloW?=
 =?us-ascii?Q?ufLmI+oWimuQUndwwF1TKrNTpgGvKIaStTimXv94V/BaiAA6cQomn5Vmock5?=
 =?us-ascii?Q?PBgb/xa0zs/bKzMuLM7KV5SERyTmnJddb48hh1AY7p1sEUW05BF+38J0iwe7?=
 =?us-ascii?Q?pBPfyEd8fiK8p0gxjYQmHhamgPB94eIZ35ODjR5if6FA8LVyo3AtG0Jydqf8?=
 =?us-ascii?Q?A3mEiTPUDvpdXbO9yh7ZIb8clynjNrSIDu0Sxu5WLq+fn6gvQXhjXNWHK4ff?=
 =?us-ascii?Q?hMcpQ9/Ji9oZW1RoKBtfWDu8lG4fLOKXlTufpR/8H5meRXaBwZHwZqY4aajQ?=
 =?us-ascii?Q?BJvpgglu5HBrQm3syO3h+auzo9Qf01VG7hAc/fO9JuWRh+YQo/IBH6qamG0U?=
 =?us-ascii?Q?1IHa3St/0WS7+q5BwM+FYwEEOb0NE5rokyNYj97bsttx0thWjITAD4muwdSs?=
 =?us-ascii?Q?wrAquQifRM4gqqKt7OqTLfivsm8S/hxItVM4X5jQHpQsOYHH6lveSTdQNWPU?=
 =?us-ascii?Q?nw4f4ocsSCfndM9VijqE6XALCDgm3r9dnlsS0CdpR4t+gV+IbOQ9tLM636Wm?=
 =?us-ascii?Q?u8qRJlzdZU7xAnH2lT33aPYbREJuTVKa3YO4YrSNHB8OEeLl03oHzcHVIXdA?=
 =?us-ascii?Q?EoKPO6QIxrTL7X3Cuv2jgBJ9G7Sibq9TsMWn7B9ufvbjlE69OLKhieWSE+Oh?=
 =?us-ascii?Q?J7MUjEJSTVRisdBaa4c1m+KTHrIBPnkiTWo1v1DjXocemLIl4bNTz3EgSqLZ?=
 =?us-ascii?Q?GOHmPtp9FTZJ9vD33qrkrssDJ6lV7G0xPjYJoPdhRxf8P/xQ2JcVgamWvTjo?=
 =?us-ascii?Q?Z72BoRD3Qyu9o1tvCwP47o6rqB0mV07NB4cUCaJuUl3uzHISxytHjUk+Gve6?=
 =?us-ascii?Q?Ax1UVNZ5k1k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0YKm6a98uFu3/1V3GS7PeSX/H6el3d19epz9VKx7UOIk0rhTNUGkJIKf442/?=
 =?us-ascii?Q?PXLmj53CyKElKgf4Or4L4GM+Fsg98DgUFw+y1IIl4evJYs2KZZfP1yhbo5BX?=
 =?us-ascii?Q?2La0sI8DpAMc2VUQ317QdEUGk6ErtQmkTjH76gThu4kc7PzHAQh6ww5WNu8a?=
 =?us-ascii?Q?aJIQVJ7PNilbM83bJhlu8gcjg5PUCBjfW77bfFaJJp4/4PotoacPg5YnKw8t?=
 =?us-ascii?Q?/5zVipL7QjHxK2rDKw1kK54inr8pHwe/JF3O1nkN0Ac/62HOybWcvPqfJrFL?=
 =?us-ascii?Q?J+LhTlj32C6PpBnCAsHohNdnkDj8z0ce/olkmUvg0i3lS6l1Wj4q//2Pvb65?=
 =?us-ascii?Q?K8QHc91VjHyf1TtGOXqVrJubQq/eb0Otgi3T/P7rKy6au0U5mzfeKg6euEkO?=
 =?us-ascii?Q?6spX9QdflwqbbgP/RRKC/mndETiRZ3wOTz7QIF2Xr9fXjLvr48RV6G/HhKsn?=
 =?us-ascii?Q?rAvApBqTzSA01TSu2jJ2b0KNDi1DK84v/wiV5y7ZVgiS7UwYD4zF+wmcMAkO?=
 =?us-ascii?Q?1iWl2Qq/rkibdwT4WjvWnD81TvIgW7HULTsMEJPN65C+elS+/a5fOmHqvwVw?=
 =?us-ascii?Q?7m1ztu+aEac/gN+68PSNrnxP7szI0Zwi1RcikVopCwSEagkid+eh27SPlfT/?=
 =?us-ascii?Q?hNe3BKIzjQQyU2qKXTzmsIB/ONZ4sPk7HlnzdYDifrCH/PoqUPn1qwAOGO5z?=
 =?us-ascii?Q?Mlt99VXiyFX3ZsIY601a0ksl21Fueay7swGqpeQGRnPGudITgyxcnrjb9nzy?=
 =?us-ascii?Q?hGAZWPdW+rTnI9uN7Xkq1wQMDBFgOwsKwTwzpwAAu936OvLwVcqprTseYI2o?=
 =?us-ascii?Q?ZWv/ddgS4YD9aVOqnZGlseqsFNw/ty88tG/gXWmbmPaGNw5uwR1xGvsydAYM?=
 =?us-ascii?Q?HIqyZAPckLLNRWb7genIYEUPXdaEUZFPtFm00puPRPsKJSVM+668vwAOtTpP?=
 =?us-ascii?Q?wDebQ/IA2XnhfiOTIFLm4jkRxfGvf5JD0b0lffKhmxmKvC9P+ZsUywDUrhe0?=
 =?us-ascii?Q?4AbOS8n3kRzdn/WyvI+fgr2hAUyp68RjceV9+wzd9qxvH3d5RJToMSxw4xEM?=
 =?us-ascii?Q?hrYr3mfM3NPn5Ta6R6hOt1hT+bv6x33+lcuPGbILMpJLuJuZQZIsMbY4LJCa?=
 =?us-ascii?Q?WXL6Ke3Deb6L4w4mDkWAZ1PR3MI0AsEW7uEhzx1TWtCjd8L4wYv8dAs0plTg?=
 =?us-ascii?Q?JxFpbpAvBUpQryHRxut4xwDIc8/ABxgKeDS/l3S+5huG0HQRbNdbgBNyYNh2?=
 =?us-ascii?Q?Us9vG0vYUswd0Wdl4j2LbJodlnKz5JofnQ0yaivL3zJLVtA1OCg5MJ9TtVwv?=
 =?us-ascii?Q?CCNixdPMeaXvZ9MdUM8+UOriLSETEstul+jUK0WiIOzyPzP6dQhyp6YmZf7R?=
 =?us-ascii?Q?P5Tju5RqSSs743zoD/1JQatJ9Q/Pl0w6qqfxIsQdtXham5n11mZp/GJMcyQ4?=
 =?us-ascii?Q?jjp8WizSOJ5TtGfe6ir2uSOwHgwWllH7pLZw8h0MaDZb/i5DGKseCt4K9HVC?=
 =?us-ascii?Q?8t+bB9kJwvbsGoJmlLAqGrRnjp8ofsloX1P6e2ZfCQvyb3DgWBicvSmwGECe?=
 =?us-ascii?Q?OkweIcfGTdWb6TekOpK0PxLqItypGrDCqA5ZMyOXT2fPku5m50u/jyNdvQqw?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2bfa07-6d0b-4767-abea-08dd775de502
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 11:58:51.5642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4KgsQDSJNDIOti6MJs9eoU4TZ/9I/3vvss29WVeDlEysTrbcFt2/76iWRmS6g/Hk7uBoKZav33tdKk7ePkCIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5033
X-OriginatorOrg: intel.com

On Wed, Apr 09, 2025 at 11:47:13AM +0200, Lorenzo Bianconi wrote:
> Introduce the capability to offload L2 traffic defining flower rules in
> the PSE/PPE engine available on EN7581 SoC.
> Since the hw always reports L2/L3/L4 flower rules, link all L2 rules
> sharing the same L2 info (with different L3/L4 info) in the L2 subflows
> list of a given L2 PPE entry.
> 
> ---
> Changes in v2:
> - squash patch 1/3 and 2/3
> - explicitly initialize airoha_flow_table_entry type for
>   FLOW_TYPE_L4 entry
> - get rid of airoha_ppe_foe_flow_remove_entry_locked() and just rely on
>   airoha_ppe_foe_flow_remove_entry()
> - Link to v1: https://lore.kernel.org/r/20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org
> 
> ---
> Lorenzo Bianconi (2):
>       net: airoha: Add l2_flows rhashtable
>       net: airoha: Add L2 hw acceleration support
> 
>  drivers/net/ethernet/airoha/airoha_eth.c |   2 +-
>  drivers/net/ethernet/airoha/airoha_eth.h |  22 ++-
>  drivers/net/ethernet/airoha/airoha_ppe.c | 224 ++++++++++++++++++++++++++-----
>  3 files changed, 212 insertions(+), 36 deletions(-)
> ---
> base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
> change-id: 20250313-airoha-flowtable-l2b-e0b50d4a3215
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo@kernel.org>
> 

The v2 addresses all the comments I had for the v1. Thank you!
It looks fine to me.

For the series:
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

Thanks,
Michal


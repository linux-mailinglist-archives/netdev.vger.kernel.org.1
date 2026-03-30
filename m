Return-Path: <netdev+bounces-273200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIugHiqDymkW9gUAu9opvQ
	(envelope-from <netdev+bounces-273200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:05:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E735C8AA
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 498863033CC3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113543A3806;
	Mon, 30 Mar 2026 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FoJ0LNQy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C23A3E66;
	Mon, 30 Mar 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878631; cv=fail; b=RTclo3QI0JL+wq71TpYUfFX4mRsKImcUfVpBrTDMzhyU30L/RDMUvHt+fsClGy75nQ7lZudtlTg/fdZJ90Ny/WDAIucnul0OoFzSo3sQnDEGAPw6FeSJ6/xH+1pIByzBiDvXCekqNeEc7wL3von/R8yKhO2/YrBv6NFAYCFlwSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878631; c=relaxed/simple;
	bh=o36+VqCVKcBp0nQlRHPWo3HkGizsuKX0RqhY3Uba2Do=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gpVnyDpGjrzAN5fiVi8pN6oeH8kWJRa0P9KV5efOP6qyIyqAs4wYX6sjvWuUrvmpIYpRWgss4jmYH5LiW2zqU8sdkNl0X37Kgf3jGqkwCRcOO1RB++pEGdnGmmxHFUSo0oqnHdOjbS0J+KhWPR+3jWHn30YRMeeP/frh2GwAKNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FoJ0LNQy; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774878627; x=1806414627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o36+VqCVKcBp0nQlRHPWo3HkGizsuKX0RqhY3Uba2Do=;
  b=FoJ0LNQyiIUG2/UZ5mi61k9e668UK8dFHt2U7kOt5LfRCJyqtXC9kT+B
   LJs0ycP7CiAg51s1PjCwDjEBglQUFu9mHihD4Wro5YIhZ8wliNlAOi6kQ
   6pT5Cd1HrKIoateW1ulvd9fHVsNPRbiRpE6VwEN8xrjUsFiPRcTOvRpWb
   iv8VCvbUOpL16zdB8hvkL/Jf0z4Dr7RIOPOds6FZSM8EWCMXHTsB1hGzd
   Adl9Ey+5SRBGnPu8/rll8U7Pme86rXXaygmr3HAFbnrXmtEHcSjg2ST+/
   ltg9LJlZIMRnhgZbHw8A66ynk9L5TulOo/HM/J/m+YJ9H4rs7bpGdfW3w
   Q==;
X-CSE-ConnectionGUID: SI1Be+MRQoutxdC1acrH5w==
X-CSE-MsgGUID: CEP4yU5OQ9Gi87pOt4AC9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79771900"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="79771900"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:50:25 -0700
X-CSE-ConnectionGUID: MNvhPDkATiearA6N5/gnQw==
X-CSE-MsgGUID: EmI6TvUfQR274cBTJ63WUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="221191982"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:50:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:50:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 06:50:25 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:50:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1rRVMv6d+DxCE5GSclmQbKOSUmhZXjM56iic36Z92Vls3/4uX35Lvf9jvV+PJLYaXp+J/wK2sM+qVPHQjI62BXgOOooHzb2cYcY9OD+FMIkXUF0zruZys13zZR+evYS7vqqux2HLgMJ1i2Eea1/6znoAp/7iqUgJ45M/lruQ9/Ms82W9fPbdgAkd4jfLXNCwdlErGyRn8//qxHFLvwORfzaomQb/5C62BKMqld6cIirjk5l6UozpUswlHYcIACzFND9O9TerEjtBp98olLzAhUN+nJwNlE3M1Rl1hJiTuOIsmGyWEm+y3/fNdJqagBZba84yD2o3GnylY17yZqBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDvWESxs0BY6kPkhzqXuE/Fy6c2UH1tJ4bBgfbLF1Bw=;
 b=n19zwjlJH1xgGuvWRQIoWODzDAdHLia7t1yTbFhgyv9LvMY6gDwjNliuqXi7EAYApLtDTVqYtb/3APqDmP2YLwc7MtXVF2RJ2MrpAvtPkuG+r/+Nt18GSVP7LzG5FBPP+LxOpF47GBLK5fbcVeXrqYWIHS3tE13XtadGAWdKrg0ME4UYHcdTIUZqNiFb7NZDNGf5panhQAfqHs8rVgUk8Z/qGUiNpybOf1ExhMj+f/Hzcor0kesW1ofDoBsOHJVALDGdWwu6N/BT1/UyE/too8MkIy6INwft8V8X98YBGfaQPDYHh1zAWIvZSO2TVhvW2EaLKzNtmYGzQJcAjjxfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Mon, 30 Mar
 2026 13:50:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:50:16 +0000
Date: Mon, 30 Mar 2026 15:50:03 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Linpu Yu <linpu5433@gmail.com>
CC: <magnus.karlsson@intel.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <bjorn@kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuantan098@gmail.com>, <yifanwucs@gmail.com>
Subject: Re: [PATCH 1/1] xskmap: reject TX-only AF_XDP sockets
Message-ID: <acp/i88sNzKrI3n2@boxer>
References: <cover.1774701288.git.linpu5433@gmail.com>
 <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
X-ClientProxiedBy: VI1PR06CA0104.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::33) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f116b3-5a8a-4315-6844-08de8e6345e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ivm6hRTe9DBO5Vt1y9q96+BTTTVzkkuiSAVdSDoVHIV8KA3unAPhKkANexc3kcZhdxKbY68Xu8g58irjJN+DRc7rVtbykxKfBodur2NDqTiIKlwJ3XzdWxcjECO49amRoaQjfqqDHuzpHkBZsKN0Uk/yYbJVDQ/mKKThWxRwCd0+ORHLFUJKTgvHA2CwRIiy/9yYR0l6SolIXe00GI8b8OO+eHNiOdqS/y2868/WZVR1cOwwWuWpCkgTA72YwNW8o79MkPgHBLGtVj3zxi7WCyg9XLBJRULlEUbKP2g8dBEjqlGIGLIwiQtP37E+ogWAMv1NwYCbi17Hd2sGusDHx5qSUSkIclxQKNgy8utlAZKVgY7NUqaO46DM1qI1fARf9jBjSzhyqMp7GrmqvgLweDkfVLztDq+nwtsfijtmQlV7Lr/mNoipv85xQvLv5Ujh9uCRGHVui2HUT6vj2gLgq4Kt2c6RK0tMMBh1lFEbB7YIfiVHcKJ7jDyuA8GHqyO4UokVC/3huiZVlDiam87XpLSndsDYmY2MHS3I+Jkg+imJzAVePKvsGT7ZnhBx6dnt1zLp4wOAeqkvKrUaywZqChcYxST+EzJkbqL/WcwYuJifQseGHDOgltdCBHTjAlNbg3eNyf35P6YpFgGdQ1SH+dwKrq7E3Q1WoqnjOH4ZNs+lqwNrgQafUkf/xwIO0bngTgY2kfjBgedYGkkDOXwHO/s2btzx0nRoCXNj4l3Jvi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pLbGvA8Ea2HSR/X9Tz0MfbInlJBguHPWT6nhNZ441/8+RoknAhIN9CUkghBF?=
 =?us-ascii?Q?FqWCVWcjQAURC2yBjVojlyXNNLwWCtlwR8FExhnrbCNrlrmfeP2XwnMap4Dq?=
 =?us-ascii?Q?EPg2XAJzFWWD/fgH2X7niT/I6xw3tIeOxQXWOrppHSzLbzfcdb8lhk7caqd1?=
 =?us-ascii?Q?pBmsU8oJuZU7QwK+sLC0FY3PtUoCeiv0xSkXmFaC3HeeJH/ZaKIuu+wetJqB?=
 =?us-ascii?Q?PvWOB+esdNjcM+NqOo/Q+jcgdSz8SneswbWa+KVvwsmBBmGftKthhLpk/9P1?=
 =?us-ascii?Q?qTyVjAmp5jjUVOfn8NEuFyQsm63rK4dVXlqfkxedPiTmco9uDahVIe3l4NjY?=
 =?us-ascii?Q?XvyQZs/q5Tvx9tS993e73VxmIWiUaxUtHd2IG7Nrf0aO5ZzhX40EycqFa6Qf?=
 =?us-ascii?Q?dg22AS2ZmTlkxVKP5Pl43hN0AKqjM+fH6mKSYalO796Cnqy0P0yMOdwFqxA5?=
 =?us-ascii?Q?vuYVB16BaOGYvbRQCgmofCNhAKgcPf8429wAmS5p0P38+0AI5/Np9MZkqCIf?=
 =?us-ascii?Q?qWbUL2qTCOIf6YaKRD2kelA0OiRJV9+SHvMIqUHEeHzpz5wyMpY84zN1qQdo?=
 =?us-ascii?Q?t6bnYcwCvBGi62UIkrKN8lykwUtZCaCM9GPpURyknThi42mF7om9//3EFIKi?=
 =?us-ascii?Q?a+zgEU5C5JP6UJAlI8+LlZCbjikA4ssE1W8o9H7732dGi7hV9A4Ba5n9VYh4?=
 =?us-ascii?Q?SjbCwnXixHSwKnw0ets9RlaGgw2/yGVvzxXoitXIzYNhCvvde7656LFe/jxH?=
 =?us-ascii?Q?S/0urBrz/8w6ViQi5bYGNNxI3hVffV/rFdkFwQ/5BrnNj2G1PFZtYaWapx56?=
 =?us-ascii?Q?Rsl3hN/qsfeb02g4O3y3xu66LEccsq53xLA7ITuA+5S/4Ic2oMfd1qDz5b87?=
 =?us-ascii?Q?/xD6XwyX1ExtbEawWC1WpumhvZ9jEMdnRIXgZqtBXCdQBCFrKEa6M7X/qwlZ?=
 =?us-ascii?Q?Ylabb+d0lYSf71fS6l2McZ90aWuL7SfkQs5LQZ8RmTeKNaNAO8l8blnKzw//?=
 =?us-ascii?Q?dOPWZA642gsZDrf3hnD8LoB5UNwy2fX8jVpZIpDqG6wHI0Wc0GKm/cPBTVPq?=
 =?us-ascii?Q?7gNkRT6Khq3A8ydksIQgGvv6/eXiGSiiYBNqHx+Dd/Masp4bu3DRzujlzjqo?=
 =?us-ascii?Q?TPHHyVOPlAn+s6uTuNHG7NWFFn3PUZX8jfM6Dn789VuTKh/AwEOGsAei7dUH?=
 =?us-ascii?Q?lHUVi/sniRNERttKBy48kPAu6ol+J4OZXeFpiXnXRWndMAxMZarAc5qCgy2k?=
 =?us-ascii?Q?wAzlD1taxCc9LB3ZZKDxSySKXfnqI4KI8d8psisOuNDhLUQg1+7jsTSXmEe6?=
 =?us-ascii?Q?E44rmHI0b3BB96Iv05UxUwoaDAVi8a71mA9qjeIxuCOTqBLUPa/sMqwU5qfT?=
 =?us-ascii?Q?X6tiWgJVlpeS1H8N3kCGji0+SKJztRZvxEK/UDk2q01OuCfvW8njgrbcZ4wh?=
 =?us-ascii?Q?bRuBi/rcfZ2W+91n+AUX5VwGgXs5NEpwNYO9R5XApwo/Ipj+pefGed+jpslF?=
 =?us-ascii?Q?NneJpAnQfSt4It6MedXEl+fhPDjK+qVczdscZc12CKctNFEgZseolLtha9mw?=
 =?us-ascii?Q?+g2mv0YsAAUwAp749CptWCoaR24TalToymqk+HVSRyPiYPeEWnPK/3l4S4pF?=
 =?us-ascii?Q?Qh/2OZPAZtXUjuuQNblp+KqkeliXpXKdgQcdZQ023xR9h2dFSZqqmC5H8hFe?=
 =?us-ascii?Q?44sqzs83ZrrYEpzXymWIsHNcbeQbH80c1nUa0kFj0qpjj3e2hk1GCCmTi2nL?=
 =?us-ascii?Q?CLse/0fK+aLUeFDqzKILJp1lZeJyYdA=3D?=
X-Exchange-RoutingPolicyChecked: pEM9fHvj3A6LVRVWG2E7yteszkuSHkQKc0JDT4ZF74ZM8MzNioSdB2XuDUGxR7Mvd2lHxY8lPu3XkwCnhXLK8IsttMRqJHPxsZkR4fkp137FAkrebmxE7ibJl/JsJecV3kRre0pv0m6bbMHEPnc7awYgL06yXm21EiljNkt7HMG+MRJChlpXLzM2IqXAs3noKX7oBa8kniPidB/+ncRg/IipTMO/y8U585gD9E0pFCW9nFVuQTwYFi5N11JgJaWwgnhvLRAvH0Da4DoFXIlOq5qXv/j566NGvVfas+FACI+ICxfJcnXoUB+2MIf8b9EU3OVAbW+2ktmswaJPtLxwcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f116b3-5a8a-4315-6844-08de8e6345e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:50:15.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vj68oTM7ti3HU2ETqvU3RaTFOSQYXGMydANlcSJk9ywPVO2A2C9N0EAOZKKKZHn7ayGX2lqm34YhqbTiQ2fKvmKiTSlS2aKkeIoI+8pn4ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273200-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5C8E735C8AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 03:29:42AM +0800, Linpu Yu wrote:
> Reject TX-only AF_XDP sockets from XSKMAP updates. Redirected
> packets always enter the Rx path, where the kernel expects the
> selected socket to have an Rx ring. A TX-only socket can
> currently be inserted into an XSKMAP, and redirecting a packet
> to it crashes the kernel in xsk_generic_rcv().

This paragraph seems to be strictly related to veth nature. While the fix
makes sense to me, it should be stated that it is not a default behavior
but rather how veth works.

> 
> Keep TX-only AF_XDP sockets valid for pure Tx use, but prevent
> them from being published through XSKMAP.
> 
> Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE_XSKMAP")
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
> Signed-off-by: Linpu Yu <linpu5433@gmail.com>
> ---
>  net/xdp/xskmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> index afa457506274c..6dac59ebb5cf0 100644
> --- a/net/xdp/xskmap.c
> +++ b/net/xdp/xskmap.c
> @@ -184,6 +184,10 @@ static long xsk_map_update_elem(struct bpf_map *map, void *key, void *value,
>  	}
>  
>  	xs = (struct xdp_sock *)sock->sk;
> +	if (!READ_ONCE(xs->rx)) {
> +		sockfd_put(sock);
> +		return -EINVAL;
> +	}
>  
>  	map_entry = &m->xsk_map[i];
>  	node = xsk_map_node_alloc(m, map_entry);
> -- 
> 2.53.0
> 


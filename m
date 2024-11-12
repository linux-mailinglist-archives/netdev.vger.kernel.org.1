Return-Path: <netdev+bounces-144135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E9D9C5B2F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F331F23009
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26625201267;
	Tue, 12 Nov 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqHXZKhF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4986201262
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423512; cv=fail; b=LL8rPLQwpfZTYN5XYvx1PbOdp8yZF1C052nVGQz52jK/X7sCTO2HaTCmH79PzVfE3LFoFPxbAzBUi+deJYfVT3/73XRztQEnhMRrHAPC9AGXzKErxdvzs1WcJrbXnLT7P64idzvdcmuo8gMg9JlvBKXiwcrw0dFdN92ETyIqVVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423512; c=relaxed/simple;
	bh=J39tRtyGbXrWO9yNH8YNnY+caA8dtuUgLjkf1TrYxEw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QQsAu2ikkXkJokhO/VlkjckesV5ejSUEnYorUuiLSMPxni+nBfnOhcxQS81XBbE60t5QG8nkbJcrKZHvk6W7reOrRzf7BN651SDgIB3E9WmbyIRnutBTzNNzUevZyX01lG2+bhIeE0iBboQQrXEq4bnCbzO2ID2eO1tCM5qldPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqHXZKhF; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731423510; x=1762959510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J39tRtyGbXrWO9yNH8YNnY+caA8dtuUgLjkf1TrYxEw=;
  b=RqHXZKhF0nnz5E/03fIFcimyT8vzUwi8WOhkRHkarpPePlSFDrcrOhG1
   0FQMvqFe2xDBvf0IWAQL6xBfVyaQ+hNzD4vJprqKPVctB4pFA+9/lw39D
   MaZyTWFMYMtWnLiOWTxUXcs44Pe0JMU4Br6AOksBTQvNraldA1cCh20BK
   HJ0J2Vc3eGQuc4f88Ba9rhnwYkS64DO+LUEHjPlI7nHJOol/xIAN3Vsf+
   1BK6VlxHIqWsGB8Slevr2Wu/6jv4GixmYT9gekTKiSvNzkiezoHpE/laZ
   nDvBSqGAq06RQh57m7iKHBoDzd65pYQiIILSsURiq6mIH5LF7n81dUkre
   Q==;
X-CSE-ConnectionGUID: fbPSjuZMTTmocXo+0hwqXg==
X-CSE-MsgGUID: UhMzo+zHRSyaplln16zMMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48717063"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48717063"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 06:58:29 -0800
X-CSE-ConnectionGUID: UZ2eFKOPT06wnEkVwbbs/g==
X-CSE-MsgGUID: CYs1BKrmQH++Vgk63285QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="92467274"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 06:58:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 06:58:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 06:58:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 06:58:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyyj2yUUTd9+m4lVfjBLdVqbwuDW+Q6egQHBQcgYKG1MK49eYLq+33Egr2lWGxmQ5IraRQfOU8GhMU5jmOT7zUWJ5Zh/CpbBHnu5M+M70h3FFEh9eQjK6SdgX1AqWDbLAkRWLBc19qGAAzNpsCC+gyjAD2NiU9au5MPEbiPd/pPJgWBndibkj3SP3hnHb4Fm4TxF4rkWoak4CdaFGgvDFAKEUhwbXFX2fzzyanuNeF+XQXcSzOgFiwBc1OQfP/TaCYu+jc6z4vKWhbH9IXuAlexFPme6dQ0Hs3Zm7sJSVe5vuYDiJI8MVqyo+RezUX1pAxSnJ0sXXoEX4QYL5I3CpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO+ZHQEhfX8ah+IOqtNiOgjDweNl8BIjfKIqF4ebORo=;
 b=PLeGRzHgd4nek6nWPP8Pog3gIzIX7Iy7h518Szf0cEWPfKMs7KzOfkThHdQtGob17RtDkSwUs9zaGRvWYuJXAUinu9iASK3ywDgBvftU0v5+AmX11XQxGF8PN9wybIQArX90wAv6VqWKQjLtRLmBX1Q12ePyT7JR+M1xiBPVhl62pKCiynA6V4vt1ZDytthtRrLl/HL0zcCHb1c8PZSpG7QDPOdLKDy6yQEWWWmRCgV8mJaetLxJI6Dbcv2BuH7MDDFabP+dU9uD66lUj7OTLolaDOlbFP9pvv9GpfKiVgquYVVopPaHBAGOVwrsdnZrAFCyaCUBW1fG967Mn4kckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 14:58:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 14:58:24 +0000
Date: Tue, 12 Nov 2024 22:58:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Daniel Golle <daniel@makrotopia.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [net]  1758af47b9:
 WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk
Message-ID: <202411122234.64f169e3-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bcd6b7-11da-4d82-ae7b-08dd032a7503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3SPN31ko6zu4U/AqN4NPQIzoxOwjO7AK9Fhx4X0SmewxMIEI6xriouPCLK5F?=
 =?us-ascii?Q?pj5kc0zWXg7TuXor+Qy/Ta5StLfxKQK0/h8dTdUbXoS5H6yZMSLllpxEc3N6?=
 =?us-ascii?Q?OPR5fr2Mnc/zaaddulzAbCrHIHTeWSt8CzU7D4ApscV6TwEXT/3fCPLueVDn?=
 =?us-ascii?Q?QdT3+46uRXCqcee0GULy5+IKnPXVL5uYxMUIM9/tYGlAVNZxmf7t/7V/pXUJ?=
 =?us-ascii?Q?UgKRUgW0cyzCpesRZ2Zn6+2+mz4+XK83ZeAZwsRxBxo2nUgxQc50j9fe8jNF?=
 =?us-ascii?Q?kW7YlSzyQ+3tWQCe2dZ61TDYdK/NRLukiAczd33Qj30skP454cXx8Br6jHqm?=
 =?us-ascii?Q?btRjdYqpskqT7Zf2eFEYRj3N5qVrzV8DBFmdxisVqPr6TDJD51LhHHh/nK2i?=
 =?us-ascii?Q?0S+LSo6jebHu4ejDqllgadTmr1eB0NG685+LdpxN8QL7oV2KfPyOmIUg2zdu?=
 =?us-ascii?Q?3A64VWnfjsTfatM6wbcNxUMHYsPT6H3kuvzFNSMocuNJKe0MgXfbO5WTu4Jb?=
 =?us-ascii?Q?FQJP8a0tFteserUzBeY/xtIX1CJYjMz7HiqYLrakTQM58sPZ2yefp7gpCeTB?=
 =?us-ascii?Q?nCoBOWRym0fSH29hx0o828n2FuGkvbDQZ934g6gTOvGtOXEG4kQ1UGFsNHaE?=
 =?us-ascii?Q?Yblm0FbXNMmWXyRPcNwGYsoKHArsABzun+7gMhJgAD9k80VyekTo9kZj4S32?=
 =?us-ascii?Q?L7mGrZI/jWBqdH+tNL5ECEqaXL6tZBl7sKM5VrAKtEw1BHhuSan60INKx3/T?=
 =?us-ascii?Q?iKCxU6RaM5OUJWbpH00NDvNKqc/mOG7UT0QMFGsQsQ3cPeSISdAdLKqMBzbp?=
 =?us-ascii?Q?iMpXwS37bqjbnOJKEA5ii4pkE3RSEtpSOiInuqEQ9IMsCWVkHunHxCxWrsrD?=
 =?us-ascii?Q?El9UBT4wGUckQd7zHBJV+uGlZGGWKtTCL95aqyAjj89HwhRA7Km7bjm8RnlN?=
 =?us-ascii?Q?KqDTR+rmdoOBCFTotnYKg78G4+fJ86xZmtYTYtN9HRGGPs0QwHqZcf9Cm43w?=
 =?us-ascii?Q?jq+4WihVsfSE1i+71UwcJhJOv+ZdX+Rwu4Y3jZifY99Zh+0wYewv/uSxSwue?=
 =?us-ascii?Q?m44N/xK50eW1TV259aEh/7IFCzRROVjaCcH5b5qfjY4EXmzRurr2I3mRXKEG?=
 =?us-ascii?Q?PRdd78/i6qFfN2hl3lK5FysmpRt+1Qxlb+dPwUt1ecamEVMQbHBFTKV4kpYW?=
 =?us-ascii?Q?vTvMQZ1lL+g2XowegPUD167IqBpmrA5XtZ6RoFESBOs9YynP9OyeDF5uavE/?=
 =?us-ascii?Q?32WdGp/CDpaUHGPLveug83kDd4cgleN+kesEGCCPZp96gbVOiP67mHuO1S76?=
 =?us-ascii?Q?sVcl+EJKX88xYNYtSfAiu/BB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c07n2EP+WKWB4LlOymbYvaxOearkYgoO+gbnAce+Ep4wQcLyHKuqVWDj9I7I?=
 =?us-ascii?Q?e5/GvTkB1wR+A87bvGJR+Mfut89GjJ5qN6rFTMEp1OfhCVLAw2CHKF/NcvKy?=
 =?us-ascii?Q?ujjK/zwr48LSG2uPTAMYhkzxcXtFvVJBEqb3/VA9sXDTVdpBpvMhRuFnMjG1?=
 =?us-ascii?Q?4i5KAOB1puYTPTp93oBGkYZMloGSCYoS0uKNyBYJc59CCXqEgZdX0uUpTPld?=
 =?us-ascii?Q?sKMhjifzHnBwdafFzvkBOtU3iacs9Y/kJAMSIdB/d/FETwTWWp2nyerKPT8q?=
 =?us-ascii?Q?XuvcD1FUj2gXu7M7RlMrok/gNAjMP32uTOLmwJmH7oauO7oZisFD5LArnsJW?=
 =?us-ascii?Q?f8qlsQfeQvuxP0nUR+PqFlUlLPVDbLrLSInhLKxxO+oS3UJnXJZGmmIAZYIU?=
 =?us-ascii?Q?5v5vPSu2B7dCogPL+WpydudLSCYSPTRgV511Ut8FNu4adM0uP0WZLgPakH57?=
 =?us-ascii?Q?C+hhQRcaBi/cxu8a7OjzIU3Lu9+1TA6h83p6w28oXBS599KvkQBW9kVp+w2n?=
 =?us-ascii?Q?z3D3CdwMeV9rr53ty7HD/y/v51gUjDyTd64Vtpd3yi8nu76jb6AcscZ5O30k?=
 =?us-ascii?Q?9qSyGnEz3RadNR7FfquoE2DKwX0pLvb5G2u5vWZcLXAxqfWjrYUAuKNgzqFu?=
 =?us-ascii?Q?RyJzwyqCftvnxJzpFHNASwaF2bHi2AfeUOLFsdL1mKWVM28NgAqDaSnmOa50?=
 =?us-ascii?Q?moQPwzuypiF39f7pigvUlsU3PwTOzNAnxiKz7T+cKqxVFFnDl/+R7olKAJ0d?=
 =?us-ascii?Q?orVkeoGHHnq1cgZ2tXkcZGxtecsGZ36cwFHuK+vMydXYbH0EyB+ynFns4BJ8?=
 =?us-ascii?Q?TsfHyq7ksYDeQFszxMzHkONjIyu/xhvslZT5IbmpO3Z9wuXLU6w5xM+m0hl6?=
 =?us-ascii?Q?Fz2gknPML211SR0KToS99jTUlMTZYpOojm4EX067EO7u7Lio5geF6t3T8md/?=
 =?us-ascii?Q?Qs/WbLZdHpSwmrEY53whIA3eKVYq7NE36m+8nbQOSSbQ6ub9QUd55MkWVQUR?=
 =?us-ascii?Q?8wH4ZvT6z6ZlwoRwbXDehVufNc2PQ8hHzLeiffgkWsabLa8u5JSLopE+y5p3?=
 =?us-ascii?Q?M799+6aVccY03hCnV9hN+EEXhzV0t82Ni0JRwnmgwVG0UmlZhRkzDJDylGdf?=
 =?us-ascii?Q?iBrGBBnwE9cRC2aK5J3OVeE5wwJtf/qHS1EHCdMvCZWuFJ30G2zl3wpnHEzH?=
 =?us-ascii?Q?pyCSjEPsOkvv6fj7fM6X64yaGV06KjJNp+uMRz0VJKi+4rp08sPoKMk8ZOaa?=
 =?us-ascii?Q?afHC0/C+YBYqqIrqE+IsVjjt+f9/R4oSemFgv4Ygof+Zg5K2d1rlpILZ1ClT?=
 =?us-ascii?Q?y/Oegses+ibQbtN7KGPJKIAF+Yb/6AyqECKnIlxWtwdXVs97poSXpt+OP6o7?=
 =?us-ascii?Q?OxZJcHZRtX05DSBnufgdJ9uvkLBBJFUc2LQV+obxR7n5tj5REbmTkgrNKjPH?=
 =?us-ascii?Q?YVkWdFNtU0o0vLoPgGUnMl99tDzfQRpvV3weqN3FBJ+RRDnOcMV/LRbVBcn0?=
 =?us-ascii?Q?x8FdER70w2FOZ4GkFAml8h5L7uz2KQBv2iiKVj55EkglW+RCfvzwa9J5M4Yz?=
 =?us-ascii?Q?ewPVlEt5BbnVpHj+JIn56tYKlrrDWRZPmkrun9GY+D5qtDQj33eW8gFGruPb?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bcd6b7-11da-4d82-ae7b-08dd032a7503
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:58:24.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFI4wOlh4ukRY0f7WONu/mRSlcpQvO8cHNwmGn+2FHxgIpHnbPhGQcjy7ldkC0tCRLQEicnM5+QfXd5hrVf+JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk" on:

commit: 1758af47b98c17da464cb45f476875150955dd48 ("net: phy: intel-xway: add support for PHY LEDs")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 74741a050b79d31d8d2eeee12c77736596d0a6b2]

in testcase: boot

config: x86_64-randconfig-076-20241107
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------------------+------------+------------+
|                                                                              | eb89c79c1b | 1758af47b9 |
+------------------------------------------------------------------------------+------------+------------+
| WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk                          | 0          | 24         |
| RIP:__warn_thunk                                                             | 0          | 24         |
+------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411122234.64f169e3-oliver.sang@intel.com


[    3.216697][    T1] ------------[ cut here ]------------
[    3.217114][    T1] Unpatched return thunk in use. This should not happen!
[ 3.217622][ T1] WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:3031 __warn_thunk (arch/x86/kernel/cpu/bugs.c:3031) 
[    3.218287][    T1] Modules linked in:
[    3.218572][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.12.0-rc2-00578-g1758af47b98c #1
[    3.219355][    T1] Tainted: [T]=RANDSTRUCT
[    3.219665][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 3.220404][ T1] RIP: 0010:__warn_thunk (arch/x86/kernel/cpu/bugs.c:3031) 
[ 3.220772][ T1] Code: 90 0f 1f 44 00 00 80 3d 73 2b d4 04 00 74 06 c3 cc cc cc cc cc c6 05 64 2b d4 04 01 90 48 c7 c7 40 c4 a1 91 e8 d8 67 0a 00 90 <0f> 0b 90 90 c3 cc cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
All code
========
   0:	90                   	nop
   1:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   6:	80 3d 73 2b d4 04 00 	cmpb   $0x0,0x4d42b73(%rip)        # 0x4d42b80
   d:	74 06                	je     0x15
   f:	c3                   	retq   
  10:	cc                   	int3   
  11:	cc                   	int3   
  12:	cc                   	int3   
  13:	cc                   	int3   
  14:	cc                   	int3   
  15:	c6 05 64 2b d4 04 01 	movb   $0x1,0x4d42b64(%rip)        # 0x4d42b80
  1c:	90                   	nop
  1d:	48 c7 c7 40 c4 a1 91 	mov    $0xffffffff91a1c440,%rdi
  24:	e8 d8 67 0a 00       	callq  0xa6801
  29:	90                   	nop
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	c3                   	retq   
  2f:	cc                   	int3   
  30:	cc                   	int3   
  31:	cc                   	int3   
  32:	cc                   	int3   
  33:	cc                   	int3   
  34:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  3b:	00 00 00 
  3e:	0f                   	.byte 0xf
  3f:	1f                   	(bad)  

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	90                   	nop
   3:	90                   	nop
   4:	c3                   	retq   
   5:	cc                   	int3   
   6:	cc                   	int3   
   7:	cc                   	int3   
   8:	cc                   	int3   
   9:	cc                   	int3   
   a:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  11:	00 00 00 
  14:	0f                   	.byte 0xf
  15:	1f                   	(bad)  
[    3.222164][    T1] RSP: 0000:ffffc9000001fe88 EFLAGS: 00010246
[    3.222603][    T1] RAX: 74186e1ad2fd4400 RBX: ffffffff9456fee0 RCX: 0000000000000000
[    3.222824][    T1] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
[    3.223395][    T1] RBP: ffffc9000001fed8 R08: 0000000000000003 R09: 0000000000000004
[    3.223962][    T1] R10: dffffc0000000000 R11: fffffbfff259d7f8 R12: 0000000000000000
[    3.224528][    T1] R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff9456fee0
[    3.225094][    T1] FS:  0000000000000000(0000) GS:ffff8883aee00000(0000) knlGS:0000000000000000
[    3.225728][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.226196][    T1] CR2: ffff88843ffff000 CR3: 00000003ab498000 CR4: 00000000000406b0
[    3.226772][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.227340][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.227911][    T1] Call Trace:
[    3.228147][    T1]  <TASK>
[ 3.228360][ T1] ? __warn (kernel/panic.c:748) 
[ 3.228710][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3031) 
[ 3.229129][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3031) 
[ 3.229545][ T1] ? report_bug (lib/bug.c:? lib/bug.c:219) 
[ 3.229942][ T1] ? console_unlock (kernel/printk/printk.c:3258 kernel/printk/printk.c:3279) 
[ 3.230293][ T1] ? handle_bug (arch/x86/kernel/traps.c:285) 
[ 3.230607][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:309) 
[ 3.230944][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 3.231315][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3031) 
[ 3.231641][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3031) 
[ 3.231964][ T1] warn_thunk_thunk (arch/x86/entry/entry.S:48) 
[ 3.232302][ T1] ? __cfi_asan.module_ctor (main.c:?) 
[ 3.232693][ T1] do_basic_setup (init/main.c:1129 init/main.c:1365) 
[ 3.232829][ T1] kernel_init_freeable (init/main.c:1582) 
[ 3.233203][ T1] ? __cfi_kernel_init (init/main.c:1461) 
[ 3.233556][ T1] kernel_init (init/main.c:1471) 
[ 3.233867][ T1] ? __cfi_kernel_init (init/main.c:1461) 
[ 3.234224][ T1] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 3.234543][ T1] ? __cfi_kernel_init (init/main.c:1461) 
[ 3.234896][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[    3.235249][    T1]  </TASK>
[    3.235466][    T1] irq event stamp: 3707
[ 3.235763][ T1] hardirqs last enabled at (3715): __console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 kernel/printk/printk.c:344 kernel/printk/printk.c:2844) 
[ 3.236428][ T1] hardirqs last disabled at (3722): __console_unlock (kernel/printk/printk.c:342 kernel/printk/printk.c:2844) 
[ 3.237092][ T1] softirqs last enabled at (3640): handle_softirqs (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 kernel/softirq.c:582) 
[ 3.237762][ T1] softirqs last disabled at (3631): __irq_exit_rcu (kernel/softirq.c:617 kernel/softirq.c:639) 
[    3.238433][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241112/202411122234.64f169e3-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



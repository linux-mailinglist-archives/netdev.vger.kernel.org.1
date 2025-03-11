Return-Path: <netdev+bounces-173975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642D2A5CBBF
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD413B7B05
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B74C262804;
	Tue, 11 Mar 2025 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daiAMqmy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD92620FE;
	Tue, 11 Mar 2025 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712941; cv=fail; b=rLxQ1YcNQPmw4CEy8fM+EkspvaqZmlCCefMztdcSf+vpZJ5EquIigDiavE8z5XVHeAmUkaSI2U+7pZmak9Gwo/ghHurJM0w9UHsJiT1exsiO3QAtuzwKloZL2oSmHLtgQRaHQcox/sSZHPT94xROR80lLgk0izXEHtiVZ6b1/Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712941; c=relaxed/simple;
	bh=8pdjm5QtF2rf11iL0I4Y9ubbBdqTMWYb0t9WhN6XxNY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mAruetumI5VZjX8QFtYOhqlDZNtME7wQXr+fD1TQbjsA/45FG9Ygm86LKv0t6HNPxuTcChp4DhfIIZ4KBMvLVpFVV8Rp+Uo6fB1pM5X4nPY0HNchBOar52G6UxbDr993BSmrGZFEn8dcE/CPbwIf2SWspjqBFrepuP9loOKfAqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daiAMqmy; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741712939; x=1773248939;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8pdjm5QtF2rf11iL0I4Y9ubbBdqTMWYb0t9WhN6XxNY=;
  b=daiAMqmync3HmdsBpXZKZmJRAT+MOZ+S37iwDj/mU1rHMcZHawT7Zz+I
   l7D6NkGFemVjjgZdtbObBZMlMgqLHCdCnsoAv+NcMYt4GNzmi1h6y4PDf
   K4aLqb5g0sBwbKMXbArVEkLjMphO9SCVojkZuQwg3asYOhXqJecl0UMWL
   14vDirmnz7iZ1c29w0qCcz3nOlDvey6DlqMfZcc94UbmzsvhUHESerDF0
   DVbMxMGXQBcRlNgmVGNW4Ju5Mz+hO6RqR+woL4QAU6Dukd1FefeJ2rMVg
   qmnFYtSgDxZ+oEGL34o63av0Qi3CqrQYKZ3PTeS6OFw3H9Q8Vqcetc00Q
   w==;
X-CSE-ConnectionGUID: 3HJX/CGkRbG+AxJjsN8Gvw==
X-CSE-MsgGUID: uUd8ukv/TqazseJq0/EphA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46677284"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="46677284"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:08:56 -0700
X-CSE-ConnectionGUID: YPf0/D/gR8a1L++AGH0oYg==
X-CSE-MsgGUID: H6vNO9RXSKC/7lw/METTVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="121277546"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:08:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 10:08:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 10:08:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 10:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFVy6yK8XEh4W8vnJrPjf99bWKg2X+gApEYHrQyFBT7sKQSqQ6vrjkzA3tbDS79+NaQhqoPl+Cp76RyDA2gVCoJ+rkmOjJEKeijxo/wHSorXzGZAsaeUtwklmH9M41F/IhnoFlm1MQqTeB3IFLPrt0NqEIQ0vMG8lSkZeYEJqd2oJgeZclcIuFCkyAUTqHDsy6BovnCphbpq+TMV1Oz1hM8D+jVBVfhViIjJ7FK/8QIUkTpGsA5TjP8NhOeFxk1GOjtKNGgX1m+op+sx70Y17/oTJevZNKSCV7mmbLpa5KxY6bNBroxmW0NVzRnE6MUWNCmGbimlcVEL3YduhgIEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/0IxeoGSUJsDtghSCcHAc7G6pDrEXccf51CR9FqARg=;
 b=jsK6hIYmTSPx/8ixki0QSiCul8hNQCJVXDlbH+pYiEPIuH1MNM+IkrwQQ5beNOfwz1R4JWDyjA05bfUgQBCkI7wZsZAagzIX6H8co4mp1XfBy34ay1hCgf4w9TjZp4OYDAahwyDec8D/FccNRbS17SY7ml0z52ms0tt98W/Z+t/zdibgEhs2SjNm7i9s5EJg55XG8kwbYZGN5LxVTvTOAUEyg8yzfBVCwzKLEojgB85qEKi3cRQ+ZrWORoeik6OV8Jra1ZIgFbp1nH6N8B/Kup3KrBB6rdeNyLwg4WDENjyJC8oZ70R6AXd7yf6PuusK3TD1PA89Sc0wZiWkrassGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 17:08:36 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 17:08:36 +0000
Date: Tue, 11 Mar 2025 18:08:24 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Chen Ni <nichen@iscas.ac.cn>
CC: <manishc@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] qed: remove cast to pointers passed to kfree
Message-ID: <Z9BuCIqxg5CRzD8w@localhost.localdomain>
References: <20250311070624.1037787-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311070624.1037787-1-nichen@iscas.ac.cn>
X-ClientProxiedBy: MI2P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::16) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|IA0PR11MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aefa5e9-23f7-48c8-fcb9-08dd60bf5c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tsia+3zUnHdnsA11BtaXjTdE+Jc72CTb6RXBywj/FMAJgJJRDHCxUcLq/5C2?=
 =?us-ascii?Q?xNDiGMmLgWNztnflNeUYD94gzevTY7E5SyxVEcPNf2DxAvIbw9QT/A3T5ZM0?=
 =?us-ascii?Q?AgBA6fVrMp3Qru3mfAa2Cc8NEo6COgN1wTLpvN0t8Q5igsqnFA6h80wSgshD?=
 =?us-ascii?Q?2hLUfWcQq23zt+HE+AmpF2P+53UcGipyTmakLPZRrioKB9PeN+jdwBgjiRzu?=
 =?us-ascii?Q?B3Mp5vi6/rh9uOwaPEwTrM5GBB/dJ6XcS5QRNfn40OwbPNY7ho2sdxFb8tJW?=
 =?us-ascii?Q?UXVCBnYyPcv+kBqbfib4tyugW3Jm2vJn2dyou0fka806LTDxT0hMpsoEcqnA?=
 =?us-ascii?Q?I9YBfMYxChgkc4ACvl9MqPvZS2sIPLTcTsNQF6zD2E9DMxwP6IrEOuJa4EvI?=
 =?us-ascii?Q?pZY2P2Q+SHHZWn6j1OhDE8B75bxM+h6FOI+AtCdXOL3naOgaY08SiVJN2iha?=
 =?us-ascii?Q?hk2MjhVeuXFoGsbRpTJ9J4/+CVZMlH/bYs2ArtJhwyjYqsQLUF797u2JmmVr?=
 =?us-ascii?Q?X/+Z66wN/b9y9TAiZ/x4wFlixjpVVZVRX0HvEMHzvowFdZ5bJ7eIA3XqOOj0?=
 =?us-ascii?Q?/wPfOky1CPzdq3GvbGmzrrjP8xbinbQjcj01ugwSFmBGrlGGU/DMw/aEuHJt?=
 =?us-ascii?Q?nrsFpAt4VgD3KQCC7WRK0z8XqcCpCpMRMXc87ZMXJi8geHSvKsGyeCrM7zmp?=
 =?us-ascii?Q?9i8A4G7ppE5oKZanHvahubam9kB5robq/dbPOnfo5Stb6bBXZRykgJQSHtN0?=
 =?us-ascii?Q?hLNbAlVQtR96PJ5zrGJVpx5HI1Wb1ipNFSmVi3u/g8pp2rvZwqyUv7kqEwjk?=
 =?us-ascii?Q?6yyHlBH/EqSBn6aTnar2GSL6Y5AqHTwJaZbQ3+pQKug/fC63/A+CZBuLOmKw?=
 =?us-ascii?Q?VL3ZatszZhlcTfl7IqWGhZMOWBIps7Zb3iPtnbU2s0DflNgVIwI27ZIxOWlV?=
 =?us-ascii?Q?i+HNnyDQ/opl5wYifR7RvHFUVJ1XH2nzY26pNs/ZjiVLpzpt8K5B+LiLM28r?=
 =?us-ascii?Q?urYSZyntPfT7ct5HY2kwLClwKTLUFkXE1F/Pu/GCIbh09RQdmnSKw/PFyzQB?=
 =?us-ascii?Q?bGOoxJm2uLwtdpf8ZWg/otLYC3DuvikaFfi3MBbXxwDDUySyDAPSyjdfUym7?=
 =?us-ascii?Q?jbaZnb6uc/QRDSteftQLUJpIWMFBSzK0bPl91thTbCN/IUtu9b56E+xO1cVO?=
 =?us-ascii?Q?kq1iA/OvWSHf18kzR7V5JTEvATEHQUvNN++RxvemRWd/+bjA2MLsZQvBUWOO?=
 =?us-ascii?Q?nsKzZWDAnSYLEn71pmKfpmyxIcFpUdo76NeX/8K3o15x+TYBg6fY/0vVBcyj?=
 =?us-ascii?Q?b6dQgPBRyX72rt2X9FIycdK+RUM6MTqBicdUZpm27XiGCqRPUONO3+hiteuU?=
 =?us-ascii?Q?sJuPn3huyGzxmL/RywKc+wtrntdp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0R59mVKzApHheGYjVYi9sfb082yNT8QHXikGI0Eo+sAnJhteBm9mCziTvK6B?=
 =?us-ascii?Q?mhK/PLK9+Ntc5hNKSpY0XpZJvRdl4Eehqsm8BDWiCrkGC7XQ8jnnckDL+WJY?=
 =?us-ascii?Q?F21EVCmRVo8UqKa9NeDrXfIU4SwBRQ7cr+J85ixGQq9yK7dOSoo3bcKfr7Fq?=
 =?us-ascii?Q?EPRCnu1UJKy3nNr4yXuMlNTSYZtux2kzpDqNcvBadmwh4PLhLrxdSyJa6ONo?=
 =?us-ascii?Q?SboAYgQ27QXiXKMZ7B1R9JjKKOuyCHJd4yBeJ1nlwOVPK2AvwK5tLUhJbBYS?=
 =?us-ascii?Q?nnGa7liDQAp5JqUufwD5TNLo+Ekg+Cxy8sHmIB8Wq7/itg85UNF3a7tIVB1E?=
 =?us-ascii?Q?QN6fQxR+4XdpS2b5zBEoyhtXTA1Mpa41vCzUlAGopJFNgUXuUi0LwHJeRRYn?=
 =?us-ascii?Q?RRZYdwDDHdv1OxBv3X05rD5q5IZj2AAbKreZnQfWuYMbdH4XBoCRF2n6kYGQ?=
 =?us-ascii?Q?vyaMNCsd2HK996IEStXTdrduMTPfI//K9dk1Xvr8BSHOWo2FNlzxCSAKsS/4?=
 =?us-ascii?Q?Wy4Bkt5ZkFqNU9E0/pFcg4+Y+0E3W6UedbDynTS7DgMN6i881QPM99RfRQkC?=
 =?us-ascii?Q?R/PnRkDmw7r0jPls7QIGmsdlZX0R6HFfQBXiefYikpzToTKXOhvq49NckUFv?=
 =?us-ascii?Q?2u3G4iL5p+4EEJiYWia63eWCqXiTV0t4wqA1oeJVRfP9+OGG31vHdTwbkhtL?=
 =?us-ascii?Q?vTytrd/xsjjd84pLqYjlgksTTj33KEBNY/rGau8/d6FChLkAhLM+43k7RqB6?=
 =?us-ascii?Q?ZS843DhX+G0VYZ92AJWkoXk45ch6mCCDzdU9p6W38UeGrNWk1eAm6sflWh3v?=
 =?us-ascii?Q?OHvoIwoDFFAcSCFYu53h2O5n0AEnZd9HqS6APqRpM8N5viaLQq9pk39GRUNo?=
 =?us-ascii?Q?02o4Rr8Wc54YeIwqorUthB1cluSHpGqUDZ2aUk7v2dfdVMckhio/YNdY1FbC?=
 =?us-ascii?Q?UhwrrhUQUNkuw28svVswzc7fk7PKuCN+JBF4qaFfMGPlrVBChl4qMxgG1+2A?=
 =?us-ascii?Q?Walb5lrfL76XKUeDFpoK5GU8b+mGAPKIglQd/XFHnBxRsZzVuNK4iySyci7A?=
 =?us-ascii?Q?z8Y9YUXAgj0K7YwAVZ3pjV+ibuwN3mVRzFk1BO9pmRkFJPbA5GWVQ8q1Vgop?=
 =?us-ascii?Q?OG7kNuzSb+vPzkyCUkNYQguryIO1MkCpPXgFTuobcV63JOZQezF2tI2TN174?=
 =?us-ascii?Q?E8WCUu9mbrqMBOvMVWBqwbZJ/xD0kE5r1KGJcaWFuK07y4QvhHGYBFJnqPnX?=
 =?us-ascii?Q?dz6ddH9dWJaisdzfipYY5+V+PHcG0RiyGshn7jkenDuRlZx9XbMf/nmp1NJC?=
 =?us-ascii?Q?R7/yUak9NAfiJJiEFy/rOjGWa6vphypqGBhgHZyGue3ZawvPj4phN3hXRLR0?=
 =?us-ascii?Q?cjYF/aNUMty+l1ZYQiBwaAOa3GpzkuFeWJUUqZyL/rn1p57IAsy7QYCYaUvU?=
 =?us-ascii?Q?76wgH1KVLna5oOjyGYbEPQWFvspIleYrITslUTe4EZZAxccTV4bkrrxHIB6D?=
 =?us-ascii?Q?tBRyh5ZfSdAiIE7+IgHeuQxffL33jYL+d4PvTICV4H3d0RvDssFUs/2+X09H?=
 =?us-ascii?Q?cA45WdqYBqmVhUZsMiFZKNaV28yjw7Ch7qmsoM6Xr7J1b30Z05EOVFOl7g6t?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aefa5e9-23f7-48c8-fcb9-08dd60bf5c54
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 17:08:36.2264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1TwNvp8OmmzQnSJYsPCqIE1XpxJLm/YPG3dETSUq7c+v1QNgQSSr3qDJRuKBxoJooAWltAZ1QSv7NjZ7T4C8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
X-OriginatorOrg: intel.com

On Tue, Mar 11, 2025 at 03:06:24PM +0800, Chen Ni wrote:
> Remove unnecessary casts to pointer types passed to kfree.
> Issue detected by coccinelle:
> @@
> type t1;
> expression *e;
> @@
> 
> -kfree((t1 *)e);
> +kfree(e);
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
> index f915c423fe70..886061d7351a 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_main.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
> @@ -454,7 +454,7 @@ int qed_fill_dev_info(struct qed_dev *cdev,
>  
>  static void qed_free_cdev(struct qed_dev *cdev)
>  {
> -	kfree((void *)cdev);
> +	kfree(cdev);
>  }
>  
>  static struct qed_dev *qed_alloc_cdev(struct pci_dev *pdev)
> -- 
> 2.25.1
> 
> 


LGTM.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


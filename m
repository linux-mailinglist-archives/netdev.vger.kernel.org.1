Return-Path: <netdev+bounces-145810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD99D1047
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30BB1F21972
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8611A198E77;
	Mon, 18 Nov 2024 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faq7fO5q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDE2CCC0;
	Mon, 18 Nov 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931193; cv=fail; b=RwbblhBSlA+5CrV+cMl1MN1RCfXi9n6ITLmIkk6Rd050WjznyaFFzqfx+rxoxAWR9blVhHNRg/FBIG27ccMLt6sCx3Mom+kykm4kQ5a4moE4qdTjz18+TmuX0C+wFyyEELRbonTssJ36+8BtxYBUO5bznjzQwoOLDHXdyEbifUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931193; c=relaxed/simple;
	bh=P1CU1L/uVDeht95IJlbJHorXwxsL5go3mddJdVwbo38=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QJ4S5FafOYzrLYZxURonStzDXeoVDgjACUHrhAdH4YcsFVtts1JGnYkd8E7+jtwu4pG34zWO1/E3SRY80v+cCtgYLDHizd+VGQevKXFHmdinXlu2W0lWUFz5ui/Q7ytsQcLLciKD6kP2xE957lwazVnEHNhH8RFfBMA34yexngU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faq7fO5q; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731931192; x=1763467192;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P1CU1L/uVDeht95IJlbJHorXwxsL5go3mddJdVwbo38=;
  b=faq7fO5qmLk9ZmmQj+vZyGXiSw2BgaQoOQPeaUaUXFvOkFaV0Ptfy2aS
   Ln+uNOYvpYi9rpOBXrv7tuGMcLjIrz2CEl+1plo5aFdw5GGkb2uoRl8F0
   y4ejzYBtE6z5ZcygjZTGF4clhAydNuyV7098Uzwb0Mlhrk4M11DAyRGNr
   bvQVLrCpnGc+2cpt050yg0h728eaLjK9qUt7GACNaezIhpg+1lHTCstp6
   msEaGHVq4rnlUFH3/YawcuopL1ZkhVUnzGXHN6MfGj4NrQQbOYB9ZnLzf
   m26HMebSpw7IQxdXCfkslrj9HBmBwngF/F42YSOBbHgo/AZM1//zycESn
   w==;
X-CSE-ConnectionGUID: vGUK5uyySU+kl7kRzqCWlQ==
X-CSE-MsgGUID: 2k7cgqj+TkCOJFFya9gOkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31808380"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="31808380"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 03:59:50 -0800
X-CSE-ConnectionGUID: gLJ7mZiFSYKN1Hb8Z4W/Dg==
X-CSE-MsgGUID: iydOZsPqT8yMEppIeJ+b6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="126745094"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 03:59:49 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 03:59:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 03:59:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 03:59:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krTGK6lZSvn+k1D3E6kF/0XJQsgB7DLIhtXnPO9KwGQ1xDBlgxmailSjlUL1JO2zmjVaGAVfc58Wf7whRIskDE0ooMSae91jHHPFWpxoABqCg8AbFLsLzMR7AMvD3DzK+6m7Cqfr4pjfbXLhXQIQb7hmnt1veJLYlsVQaLmmlHPAX3PttizyG3Crd2SiRdpNpoTF0lXHzYYZun/sV4G1yBJURVrv2YxkqD7bCTHW8zllxBF6lmViG/hAQkXSl4o8ZVEPlX5PCkoZuHqqkG9O46hrWEy/Mh7Jf5ef8cfo7OCDU7L3X4c+in+0YpLdk+GoIb52iS3tCAgbLtEUyJ5BGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSMYgGUBPlIDCiG5UzBmohyqt1lBS/WYcPDjLCh/KY8=;
 b=k/a4CRYiInLq3ZRqtGfm2ReJOftF2pULjUWsKn8D8GcRiSpa++wqGwU7+m4kr2YaiTt/b4UTpPNqED61P/4YLueFCx+18RJUBKwXc+fR+jf7ZyYKu0D7ITyPAlH+3ldIhAu/kTCIe1Gxtjo+ywKSxzzpeONBJC4CrvqYNnxxYbf672F6Croe13QKEF6MVsN7brkH9zxSwuoBTS/X4jIXuEtN5lZVgJjO3ivV/ugg1oj3wkwIP0f2BJPO4/Fhw2LkhNWjUTtlGJ+oZdQFae3R2kkcOk82HSb3jxFhDvjG6s8BDScxo0i0w1gOHKMghrcamdONcxC6KIOwP2IdZ90/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SA2PR11MB4811.namprd11.prod.outlook.com (2603:10b6:806:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 11:59:45 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 11:59:45 +0000
Date: Mon, 18 Nov 2024 12:59:32 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Justin Lai <justinlai0215@realtek.com>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>
Subject: Re: [PATCH net v3 1/4] rtase: Refactor the
 rtase_check_mac_version_valid() function
Message-ID: <ZzssJBOcb807PYSP@localhost.localdomain>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
 <20241118040828.454861-2-justinlai0215@realtek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241118040828.454861-2-justinlai0215@realtek.com>
X-ClientProxiedBy: DB6PR0301CA0090.eurprd03.prod.outlook.com
 (2603:10a6:6:30::37) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SA2PR11MB4811:EE_
X-MS-Office365-Filtering-Correlation-Id: c0837b2c-e995-4bea-9609-08dd07c87e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EkS4DrpiAqg6BFkTD1FtoCc3IDocsTQafSxLQmgv9HH/hR31zI807tDbSQcq?=
 =?us-ascii?Q?bdDHgqqX2AVu0CYD+AVXXgpQesSUo6HjBY+OdxDuvTUiJ70ku0/pr/IhIC5L?=
 =?us-ascii?Q?nxg3iODGAFxlxwj4OJoQWK6rKqp8T4SsM35GIQgauVparccnTbCDniRTfEi0?=
 =?us-ascii?Q?YOZ4GsFtYZxEsiZYBwxjFcMB2llY/yq1j3u6/TfFch73S+QxvfVUYctBfpv3?=
 =?us-ascii?Q?JR9u6SZtNGnNd79AhWph+Kr4+UAt5HUex+AM0S9AqLi0LfsiMsbXsvS6RPpb?=
 =?us-ascii?Q?WoxkRSXlodQdjSqje/5hKlqldi9h2PqpC9R4EPNU+bi1S1trPxdxTO0hItJA?=
 =?us-ascii?Q?XDTBA7JD05tIoqPpiAV4lEAWC4myIC7xJ1xmgT290D2dzy4Hlbw+XYxQoPJS?=
 =?us-ascii?Q?dR/rkZS0vQYrBElk+O2EuLzYJA4Dr3UQ2pk725ezgSK22vfURhpc0R9QJ7K8?=
 =?us-ascii?Q?oxhfI0mP3kVSbF4zAVuSao3rOR81YwiCDnLDndFvVVNp1rszvJ3qAG3ZORX5?=
 =?us-ascii?Q?NIYA+kVltr0pRgjLofP7Vblk7mPYp56g2QgM+Ay7m0/05Z6MWGVaIptewXar?=
 =?us-ascii?Q?AA+PCGheIBpQ85uP0m7Ny9dSlI/yONMrB17OAXlKJUT6tl/U4KLFhcGtjIaZ?=
 =?us-ascii?Q?QKd0BqlWDkzt+SeJVUCLKFJzEcEBEO8EBrkct/kL8/IW5IzWSkcIl/KNbhwi?=
 =?us-ascii?Q?COgUesuoNpJbIBC9n+WcB+SO2ByAhGN26hUBpnkNJU4Y8vzAKQtgoujV5z6W?=
 =?us-ascii?Q?yzo9bxfwGx8f2Sm3Kn3cY4EUczOl1s7BXTFAy1h8gz3xxZEpscuY28JyZdX5?=
 =?us-ascii?Q?cia4f6D2EAGUCp9ZFbxX71HoIWE27YWcia5X9HkYoK+LVtTLz1UPilCioJgu?=
 =?us-ascii?Q?tm1SmJp3cMpHweTkFu/IDEaHRQiQTvP0nql/KrqOZfFgVTbb+ENehXqkdTR3?=
 =?us-ascii?Q?5JzRMmG7Ibd9Ym+5Awya5Mokkq0gF5LRyip3ATss6GnCxyNWMMe4XmhYkpAa?=
 =?us-ascii?Q?JP8rsyrlm5uFH5XLGHcCRuO5MPxp2jFX9s6KPWt/dIBY9IuruL6GXY0vaDwY?=
 =?us-ascii?Q?KjFeiLK5Lb3J2YNa1C+IvhJ4+vzzORIitCWOyfUrE/14QEA2GgJVzkStsDRJ?=
 =?us-ascii?Q?FrGaI0uz50WLyXXuk7Ps9AbuAMkf/zqXTuPWQXDflMxnBGOEEKkB2ltRxwIC?=
 =?us-ascii?Q?aTfSvl3yhRpQrgDvhwKjMVIbpK/FIjYgWPiAMUjUneFgSnq13zSoRaeG3xpu?=
 =?us-ascii?Q?uHVcJtAxRHwbxGLDfR0t18+1hD8jIpL+CR+hmkTPmdlxkHSQLuzIrJspcxu5?=
 =?us-ascii?Q?8l40rXhwVJzhZVutSA/7Gdgc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sSE2NLKYZV0gbU7wGmNVrTfAwrRBNTNCJxpV/nP0AUI8QfsxCs7mZB6c2U6B?=
 =?us-ascii?Q?NdXy+zGyDGsNp2tMn+1N3PyRQ1ZgZwZ9xF/mfV948r/ulfxa3lAzhRInkytO?=
 =?us-ascii?Q?Nn3Mga0caQqtYivlcMWNDRWJaZeAm7qgsivAEFa5CyThXIsCPgOposWryRiu?=
 =?us-ascii?Q?ec0B6ix/EeOVZhVmI+dLTIdriPYLWY1lxqDKI+KQKpUfrn9kYVDXCudaibe7?=
 =?us-ascii?Q?lOhR1r5VmZM0RrzngQX1evnTbZSdS914MhnX7V/vc+pKEAiyaaMagZbhJyNd?=
 =?us-ascii?Q?BhH5miu6Qf5ObXsBby2r2hKPc6UR3C8E68wlMT8wMJ77RKOWorwnk/KyPyWS?=
 =?us-ascii?Q?yOCFRmaFEQMFHDEKixNNglzd+t90irqoiRfZktPakZTAZCgqxnk5YZgkCqnd?=
 =?us-ascii?Q?KOEaaW6JXKSqpu7/rJwcVjxLnJ5pcBtn9SLR5JcwjJ5MUrSw05vL5LCJZ/W4?=
 =?us-ascii?Q?XSscITPsJBBFQ5JmDBaEXIzaHvxhxVGCXVVeF1W6SxmzoCM0yLvjm7zMms5L?=
 =?us-ascii?Q?ygWZ6hyryRv9UVuj2xzEvZeYH6ys4ialszKbrxGdqsgW5NdOrb3w4deDlEsf?=
 =?us-ascii?Q?kHtQ1mCkCkeEmj+oUNLW+n0o6yEA5dYU9LEXCcrv/au7HnfnXRhuqjvGk2tm?=
 =?us-ascii?Q?NZqV4/aA6ySacFN1W9BOaGIaPF2+n42NU1PjPANx5eVtrI4luRj4lqQHWBWE?=
 =?us-ascii?Q?QIu9SaNoNfV06IAL0UUhnPkdm3jKlM5/5W0V0wZffELlPBIGag5uSIOrSCTd?=
 =?us-ascii?Q?JQun6rEaoQHPpQn2LpHOzQ5V8rBDRuxWiPSgtGCv9+XEztDS9bzE+/ZngtDC?=
 =?us-ascii?Q?RmvTqCxr04kWcNz8TUJpBlw1eSbUQ0y3zy7cpsJWbKYoziq0DK3rZVAYTPMZ?=
 =?us-ascii?Q?f6JU2Y4ImUX+1ixUDdWzmUnsMAWZ2H11ZmRzgLC5sZNi+ZyWDZ7x5cK7+RtX?=
 =?us-ascii?Q?z6nHnOWfh57hFEIVlOqkT3W0SoAT5Nzt8sJNH4DsKAJojGb4bjF5CopFrWvo?=
 =?us-ascii?Q?bYirSxsuro4rSgX424EC4HreCPfz/LQRu1aTtiaZBa8JcNAt9XargnriDog/?=
 =?us-ascii?Q?W7kE6GpYZhfa5kQgYwHlgZRfHTR0Ixr81dqBT/dYC3s17HoRx8N3KmHNDKxS?=
 =?us-ascii?Q?u8mU36eP4rtsaQF5LyJhoF40YxgNnHmCk4/uxdPnZf1aVQ+EIFNTW/mx6QQf?=
 =?us-ascii?Q?pjzZGJIBBTQJC8TLbhgtDDL4fNbxWNFmr+ABXy2/nN+jIhxbp35/ySmM6GEt?=
 =?us-ascii?Q?BI/msFpVG9dmtkJ8UxZChsh4OYCr+QtNOe1fPSVGod4CnQcZGvSO7/F5igqX?=
 =?us-ascii?Q?64UqFGfOt9gpBa7Qn3EcHxdoHv9b9Ic5Tb391jMeyC6xl64gAv17tww4LpOb?=
 =?us-ascii?Q?unvlPZzIRE9AWt9wOqj4X0+Xfisd5aeLkGkDq9p8oyR+JDO5C3AXOUPqB/ep?=
 =?us-ascii?Q?hVNmhbZpEE+q7jgPJjCEilMk84RRmESV9W/KEULr+obE1kvcoSeHg0EUOxgw?=
 =?us-ascii?Q?kX1gbQ4DABGeIOS3Q/FEOwBhQ4cuoVsU7CDVH4Qo6H5Icjy9TW2cyLdTl5U5?=
 =?us-ascii?Q?ADgHcVA1PHCPgsHm91IW+tw2GKxRPAZJxOG6ciP5wtlvQZgreNSK2cjDN+1t?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0837b2c-e995-4bea-9609-08dd07c87e76
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 11:59:45.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PeTjSCO+FzkYa7nVmtS6Y+Js0UPapcV6zGka0zPG1WjewXQJwFvoh6eZGblJj05J+lkyfzwtKGzmPJvTAHWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4811
X-OriginatorOrg: intel.com

On Mon, Nov 18, 2024 at 12:08:25PM +0800, Justin Lai wrote:
> 1. Sets tp->hw_ver.
> 2. Changes the return type from bool to int.
> 3. Modify the error message for an invalid hardware version id.

The commit message contains too many implementation details (that are
quite obvious after studying the code), but there is no information
about the actual problem the patch is fixing.

> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase.h    |  2 ++
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 22 +++++++++++--------
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
> index 583c33930f88..547c71937b01 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase.h
> +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> @@ -327,6 +327,8 @@ struct rtase_private {
>  	u16 int_nums;
>  	u16 tx_int_mit;
>  	u16 rx_int_mit;
> +
> +	u32 hw_ver;
>  };
>  
>  #define RTASE_LSO_64K 64000
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index f8777b7663d3..0c19c5645d53 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1972,20 +1972,21 @@ static void rtase_init_software_variable(struct pci_dev *pdev,
>  	tp->dev->max_mtu = RTASE_MAX_JUMBO_SIZE;
>  }
>  
> -static bool rtase_check_mac_version_valid(struct rtase_private *tp)
> +static int rtase_check_mac_version_valid(struct rtase_private *tp)
>  {
> -	u32 hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
> -	bool known_ver = false;
> +	int ret = -ENODEV;
>  
> -	switch (hw_ver) {
> +	tp->hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
> +
> +	switch (tp->hw_ver) {
>  	case 0x00800000:
>  	case 0x04000000:
>  	case 0x04800000:
> -		known_ver = true;
> +		ret = 0;
>  		break;
>  	}
>  
> -	return known_ver;
> +	return ret;
>  }
>  
>  static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
> @@ -2105,9 +2106,12 @@ static int rtase_init_one(struct pci_dev *pdev,
>  	tp->pdev = pdev;
>  
>  	/* identify chip attached to board */
> -	if (!rtase_check_mac_version_valid(tp))
> -		return dev_err_probe(&pdev->dev, -ENODEV,
> -				     "unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
> +	ret = rtase_check_mac_version_valid(tp);
> +	if (ret != 0) {

Maybe "if (!ret)" would be more readable?

> +		dev_err(&pdev->dev,
> +			"unknown chip version: 0x%08x, contact rtase maintainers (see MAINTAINERS file)\n",
> +			tp->hw_ver);
> +	}

Also, is it OK to perform further initialization steps although we're
getting an error here? Could you please provide more details in the
commit message?
>  
>  	rtase_init_software_variable(pdev, tp);
>  	rtase_init_hardware(tp);
> -- 
> 2.34.1
> 
> 

Thanks,
Michal


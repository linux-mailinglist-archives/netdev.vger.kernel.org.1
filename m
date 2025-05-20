Return-Path: <netdev+bounces-191707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1763DABCD4C
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17EB16F087
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737919EEBF;
	Tue, 20 May 2025 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7QOv0B9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36381E492;
	Tue, 20 May 2025 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708810; cv=fail; b=rPT2mqHemcx88CdL7Z36YSI8i7NWejhb7HKtFJ+9qIdd3sBmrgxWIhcRAO0LyWwy2pvODaSN+wWRjcxCLD2qfwTkwksTR1slXLe4kg8SawSYslNTSo6bK+LPHRLTUn8T5ABU3fquM7gwdtLfg7GKfQFQJdwI9uYJaK5Hpc4ZFPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708810; c=relaxed/simple;
	bh=nDVCMhJuavfRWeMMaTtY8h3C3MD5sAqfR184tjWmnZw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qyzp+dErYua/WcAJG9cN3ehVxKTfccU7l5ODMClTVg+zf/O01SxiLv8byBrsISs9Fde9RHICuYSk02wxlAsmZngI8COC3lSv93wQ6b3ZX1XS4ys0lk3yMdsuQXWMgaWRzZv7j24HzkYGxL2cJsIIKh9zciiOQYT2755+/eqAsAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7QOv0B9; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708808; x=1779244808;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nDVCMhJuavfRWeMMaTtY8h3C3MD5sAqfR184tjWmnZw=;
  b=K7QOv0B9waPsdJti8FmATUKP3XFrM8Tqg3rwFF2tNxJ5ZDrrasMZoeJB
   NNZU0w/gi6o4AcqfH9PvWqlz2vp0Xfur8vt1OPZ14H3P3cHKlNr9BeRe2
   j2OrIZKoiCfmCV6gRyjCo7nSlH5w16pCXSexUE/bVWKEeDk0MnjdPoybE
   WGnDaKPGA+JLD7Yygrc9CkHE2JfzqPfMgp0HSNHFvUIXAbOKCxezHjzBZ
   lxJ0+kORhUyztB8DuqRL6M+p8EcyGMXSJRmCi11icm8yLTDanfVI0nHXb
   rjHozfarsEIPyidI44chqf/X5mKKKi22/jGQizvAUi0w/QmrlbT73S/Q6
   w==;
X-CSE-ConnectionGUID: 6jPatLXLRy2So5tLVA0a0Q==
X-CSE-MsgGUID: 7dRTk6FTQfGNygM6wfra9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49324065"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49324065"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:40:08 -0700
X-CSE-ConnectionGUID: OjgoZ9F4RKyQUQw/cXVt3A==
X-CSE-MsgGUID: i4pRQcF4QEmLX5xvg2d08A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144302224"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:40:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:40:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:40:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:40:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2ezLDddKuI06u3LMGjw9+PsSozU17MUOyQJ9o5lTGdYmIOtc73G4U51ht7mpKJlEbdEkUgBjN12A3bTnySKJ9EWoshfXHap3HeT0WQ1da491SsJUDxTn4IVBeCOjFN4/Ez77SZqa8tmEobLRz7MsmsteXlpfw19+aXoP53EUBLIXI28YiZZ+3PWPRCTY8FEZo5ggtXj9uPwPEBuC+DBBr3dP8lCMuQC+5KAr2b17IoeLCUfV8W8yae92lvanE5gVlDr+6VsE3Go8rpuhK6HqdOHD+DnNIC5egQrpyTbqAkSQIZkSLpavu8XM03U5/ccefSIQiRrInLxJ7x4fKsQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiRaglA0U8QLDYhvAykLeKPhbknrnSuJwwNoVSuoL8I=;
 b=OvU5StacvZw9YrOunvhQnTsovp8wNlo3kee21pnrk0XVblI+NhQIaxnGoi0ScvGpw1n/TKG+Q9aW7eXhnNLuLhipGshJybNCOjMg7HLwdNqtDAcwNeWQscJdUYu+eAkq1PRVAJ31fJ1R+hJYih1A9YfRq3bgwaWQ+4qCjSYBR+3i79HzXgubNZAqOC3AEdanv8ICbHeiMaH52xfRyrRYjVc+1ZR+wVm43U2ru3FqdRuZZ89twtajxNNEHeBTE0QeeoLyjIKP9hjNG9zEe7KT7Xw+JS1Tu/cL6hlirCZ1cgP9oDkdkhxyvWWg+pCieJgfyj8KVimyf1fDSTyBOcyIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 02:40:00 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:39:59 +0000
Date: Mon, 19 May 2025 19:39:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 13/22] cxl: Define a driver interface for DPA
 allocation
Message-ID: <aCvre-lJHV8eYVyg@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-14-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BYAPR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::20) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ac229c-0553-4219-3293-08dd97479d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X+i4Z7gfv6iSmUOBR02xfZNLd8PV8KE0E/Qo5LM82SewX4lbzAZcXucoRygH?=
 =?us-ascii?Q?vwLST9ePPvHx58AWl+WmNYfzBRuPUEFbSh7FlxVA/0/ULEEUBx8Sc4JsChv0?=
 =?us-ascii?Q?o9LMEOIyC5TrmJ/K/g9Cg+EGc7d2Nnpp3DPR1fkBwUGy1FYAuwC0+/pAnc04?=
 =?us-ascii?Q?mdKBxSo43/67i6+tSg3eajX9mgHic5I5tUltruK4IICtMDHisixIr4cWj/BC?=
 =?us-ascii?Q?C5bGx6dAxPl2tFRF/nVHo18s+oRLQX6JblaRCA9xSc6sfHvup0V3C/x7DVk9?=
 =?us-ascii?Q?s2nGAhpjhaUL4dta7B/Xm8PruhnH5c5SLNx/hNUkceP4p4gU3bUYGOBnaCyC?=
 =?us-ascii?Q?ZHW5xq7UtwacQcsvphagXye1uii5cE5iSXR8gAK4lY9Uo90a+q8vYV0hIbSJ?=
 =?us-ascii?Q?iPu1cMWXR0p464Z5rMJF/z/x97ZEUq86DVB9IKaisx622Dy4VilimLxLeSmu?=
 =?us-ascii?Q?hfqv9ebUGsJGQ7KNOZPcO8mpL7/x66uwszOtUGqIdCq0CFjcQ+0P2HL9Bbht?=
 =?us-ascii?Q?8SOIszKQ0eXnKvFKf0o6+6q8wq0osv8PpO/dtWtV/gQt87AeSOAMUFyMdAR0?=
 =?us-ascii?Q?FfW0ceGwfBGMa8n7e71VDp4tgsYiHbaUWNi710mSRC4GWxu8bxkeyUGaBszE?=
 =?us-ascii?Q?w2j7dTpsOvc6qYZb1YSL4avFqzEEVO/y46bRzQWIR2uo46dRXuoDK3gZZaAG?=
 =?us-ascii?Q?sJHkYXswjtA9VzKoh8EFF0ytb7jdUA83w91H5YWIvCCNj9bRhIzM0VrBJcv3?=
 =?us-ascii?Q?axly+ypgw3Ef72DpsksNnR43AA5mLfPWAbxyvm/yaB3dEMBDXFHeRhDkcEW0?=
 =?us-ascii?Q?7O4ecuAaH3ypj+k7ocUqBbzEI/sjHXRikx2oErnnvDeuv7b4Zoj035lNUcky?=
 =?us-ascii?Q?p5vOh2Rf1qPy6U1Jet98aikICZ91tPwNAl/a6p/2GZz+THDpKKLzLRMJD+ap?=
 =?us-ascii?Q?5FGiWxOo1XpuYU37OgyOnEsgCq9fyGQFmroLQdjdcSda0JgrupSWAPUuUyoT?=
 =?us-ascii?Q?w7QK/xYVv0P8V4ALb0eWx3GpYIRwEy4j2CSg73bufOQuJ6csogBgYT5Q8B6Z?=
 =?us-ascii?Q?574vkfonIt8j+mIoCkj94lGpZ4NKaa4ysdRn3uIdyxaNdjQEcXWtgWhWIrcv?=
 =?us-ascii?Q?3oQcQhhpkLhKPHrqtsukjZps2Pu7i//W1LnGCU2jFrgJqTOAsH66arlaUtN+?=
 =?us-ascii?Q?ulcynrRwMoumx1DlDJemnOLJEFL7Rrj1jMBHNGi6awXPxyKgqfwxxLEkpVyD?=
 =?us-ascii?Q?CgCeMDEEkmkeJe+NVEeL/HoH80QB3+OoF3Gw7YUKlFIjNZbXvTe7hafp2Jc9?=
 =?us-ascii?Q?09s1JjbN7sVfte+Sc/qMnJmFAPLiHS61f0QeOwmzvm/m5aBLT0V/HA9E7h8P?=
 =?us-ascii?Q?yILWBGQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eHxAUQtnnQX5aBWUCc8t1nrXkK4P8WpWfY4YCJsLsIOOBKC+kZzQuFHyeIF0?=
 =?us-ascii?Q?6aoY0TgwsnRBRx3b9hfKdE9hNJkrjDUscpPME6z26IMga+J9bZ5rvDG1G72k?=
 =?us-ascii?Q?Tz61zwBk0wIpiHcZpUfTDhvf87dn/iULCAA1ADtldTrPQaROfD4CFPmP3Mvz?=
 =?us-ascii?Q?4mGlXDO32bTeDXJGsyfib3XRApLcWq118nZArsZuAhUdqMV359mK3McllXI4?=
 =?us-ascii?Q?3Ohw5nYQGc/qZfGdom+NYh133maBq3r2Jfr/9HIARogPBkl36omGSbVk7yna?=
 =?us-ascii?Q?hXxgAVOkGBieI2rwCst5G5Rqv2/haGKEtr8clT3WPmJa/yMxJvKb9RSUh9a8?=
 =?us-ascii?Q?W+aLwS0NN8BsxusVqFU6p3UTRjWRCFa+6wZoe7sZnOtGo7BZjaohBVNcctql?=
 =?us-ascii?Q?4rCIbvP7T9QoqpfOPhg3skIqfYz+FLzyw5FFYk56SZQx8VtzEfQtOV2kbbCa?=
 =?us-ascii?Q?CLj5EFUPagb/a2rp8HxbDFqX2brIsKjbsMCD2Rw+ikRWhOjoebdBH80bPPe0?=
 =?us-ascii?Q?BeWw3CgPXclRByxRwu89vi0mqpkDvNS01IthBN0Td963DqKMw/1vIUKAVJaA?=
 =?us-ascii?Q?05oMatbYlS1nZaRRFHAQoHsE9DpIdlFle6PsRRgRgZNwrg8cm/cD+1pUltJ7?=
 =?us-ascii?Q?2JhqfK9mqYkq0dk6hto8MxDTBvGxSJ1/4cONdbNrBfcA1cpd3UQku1yk0vAg?=
 =?us-ascii?Q?48viyxe3H2Gn1mWkdaSWwLbimFHzeWJf36hBfEEf5kr13oas0DduJ9vNedaT?=
 =?us-ascii?Q?zYMJR1ZFK63p3zMen5aT52Ck1ny7+sP7CXgjmoIsJpyPWUHCSfv9YNjbnPXa?=
 =?us-ascii?Q?GXP3pzLb4ZQ4HfbptAw2yrPznSdpMIVUnlogcgSIuccN/F7CiuKepAdh4BzF?=
 =?us-ascii?Q?QL3qz+eMYfwfQm1IO0rTcVzP7sOEdLIcBrZGKUkjXUtH5BwCV7BUw1j/dWDA?=
 =?us-ascii?Q?YKG3gU1PROuj65cpAbDkOleLz+sVQOMfs9ym6vn967jpovEW9b8DajwjzvSY?=
 =?us-ascii?Q?d4qVRnfxpt2pgApC4kZ+lSWcJq69XmT47/Gn/Ev8l/E9U846HLNj2Qqqkct+?=
 =?us-ascii?Q?RiFYAulRMRBnuxLtiL4mHfIQtbAVi6ZxrT+VXdVFqkANpRz9M+pu7JuwuTAa?=
 =?us-ascii?Q?Kwun3jxZnGz/RdNq+ZmtGb1KIwuMf2FWKPOrjUVyvDdA3kU3f5s7m9404Lx/?=
 =?us-ascii?Q?4jksXO22d0Wk8BwvKcZp52yrcZJ39QsPrvaR8u00XjD7hThOYJl6XPucLRaq?=
 =?us-ascii?Q?4vkXJ3cqQahpCJNnnGKEidbThgtJc3kZnLjX9D3Ld8DjYGhLlfL5rS9v2Z/I?=
 =?us-ascii?Q?w6870+/F3/paoFU4EQlsD3plvRI92DDQ1ft7oDSx9dqU/ppGUHiLI3TfNuWk?=
 =?us-ascii?Q?mapu4xdvdJmRq9HtlYwJAyO2ULADmUFlmpq8kJtYiF2gbSjDE2CxjQz6zXKZ?=
 =?us-ascii?Q?01FvFVHO5WAKKx96Ca6sQG6NlBz/mc10JcEdnvDfB7/yH0U8dNtrQwN3rNng?=
 =?us-ascii?Q?DDhGiUF06XSiLzsBVwsMHjk3Lx2c+R55K7Z09zQpUI0th1h3/i+hE/MDHXIm?=
 =?us-ascii?Q?8FJeM2QOWIjS8hOdOek9UANrJuBrVWEfMMgMx76rZ047Jfzlud6A8Vx5g6ZL?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ac229c-0553-4219-3293-08dd97479d4f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:39:59.6453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMR62edFhou4yY3KgciMldc4DHy0INzJvRkoWyq76p5qPwP824GEVG6givdDnkw7X8GMSSVUIEvsXhTPjkWvWVgPVf2yLas5sUZExOVKOSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:34PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space.
> 
> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
> that tries to allocate the DPA memory the driver requires to operate.The
> memory requested should not be bigger than the max available HPA obtained
> previously with cxl_get_hpa_freespace.
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip


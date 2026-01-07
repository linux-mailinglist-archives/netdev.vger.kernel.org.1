Return-Path: <netdev+bounces-247872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A95D6D0013A
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 21:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A97063014A2A
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 20:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178333164B8;
	Wed,  7 Jan 2026 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erIua0eZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D023C8A0
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819570; cv=fail; b=CyOqUALkg3RTS5hk7vH99KtBTyE4avmsar6xgSkzW00Pfwzpp/dNQUtzek7MVOtJLiBr7iYuwtuAgVdSSfCr6sPneydSXK9Se8yXP3iJKZPXs1PjwlKXJ+3hwCLcIhM3G/nLrbRk4Gi7LJVHTVAXXnBoWqvhF3oPAjvl+tKHUCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819570; c=relaxed/simple;
	bh=hvxhftzfrVjbNimzsraATQA0NUqVD65SXB5/kEs1C8s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iTpimW6QPVvzVI3XfT3nkhYJF9cI1lSe+JAUSRlkABweJHzw7E0T7VMWmp+qNd4u178iqCzYP2VzHI4LHBgcc5/9MKtDt3P9y04CFjVEefuiRsVnt6slWw9iAuq7IKUwTmewVVUsRT7KE3snd0ICk15mmrlGF2xKpp70YHLLhAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erIua0eZ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767819568; x=1799355568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hvxhftzfrVjbNimzsraATQA0NUqVD65SXB5/kEs1C8s=;
  b=erIua0eZKjUZhf3EsRx+gHTa0KKIgsOkzxW6u8Yxw16tm/blpbLPhp1N
   tKOktt78J+jK2qQW3N8eyj4g/H15INtsXRFF80Pjk3llaLI8H56y6MpHM
   sfstfUKjev8tzkKPIvZTqUGDil1Txs+b1aXc2cMZPrzGtCxFGepz3XtX6
   8236bENYX6Nja9Kd+12lInU7fS0Id/vsAOEfW7lyNpNLaAewCmbFD0Cmg
   xYhB6ppqi3y1BL2b3zRM+O8f8emg0nw4hUoH28Nkeg1IszyNfl5+JEeXe
   AJ7uVPwURuAizfkjSZuYPB3yrIX1stXF3uQLpDkSfn5sltolHcpecHPKa
   g==;
X-CSE-ConnectionGUID: p43hYS6vQR2xlMFHvkGYtQ==
X-CSE-MsgGUID: oYknahg2TsSBDX4hRdCJZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80557951"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="80557951"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 12:59:27 -0800
X-CSE-ConnectionGUID: d2LQrLYbS0OEU7n8ySddRA==
X-CSE-MsgGUID: w78i5/hJSui7LTKTSS8S+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="240501864"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 12:59:27 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 12:59:26 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 12:59:26 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 12:59:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1BtU/7jAQG1pPeNhswaR94FVTcVxR537psoDFsoKqoYj8xaccMQU4RlH/zIS/0gUAWXxJtUECCZfHacsmWRegNwzVFYQANYWAXI00hnjiySxDWT6JTxY4AMbQdzE6vFRzf9u7xfErbmDNzRx8iFca061d2NxWN9gxnTGPSCqOQ0tFR5EHxrLI28HmpJZpd8IOef+NZAJu5FZRnD3TEtAUlsaL/KSZJx1IzMq/GyNg4AlkEkk6JPzVtlxxF7Hg0zQJDeviuSVxnl+mEyWI+9molCXK71J1H9bPzgqDoy+DLLqct9OfPXfvsBhzRf9Zff7SZbxnSo1bI7Fnki/9U/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=311ZZ4l0yKcNmLJbY5qCRrE2RMOZrF9Dvdc103v/KBQ=;
 b=V1Dkss1TwrZaCTS+quxl/TwD0FDIdgr0B3bwUimHWt8lknAgw9AWgB2jb+X1zEyCJSnF/rstmd7SUmieJ2pDhpplcRagSpXCNW9xCm/J/j6pcYXjlVGDp0w5ThdswJ0Hs9KUF0i7CtTyvMBrspb2RgtcXXG9ZzBe0bGll4Wzl9W4KL30y1GV3yNz7kx5jfUVSenTt3l24XxLE7tPT9RqbtPeKHDOHLJcFuPPO/UmL9n8yZE37T9iu04wKFirGWoTROjDIEMocEiTibf7YgTGCxrGq2g03mmr3eIrxDO9FUdope83qVHkwhnZ7F4O7HkO8uDLyYsGxo6xbXoB6jsH+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6607.namprd11.prod.outlook.com (2603:10b6:510:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 20:59:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 20:59:24 +0000
Date: Wed, 7 Jan 2026 12:59:22 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Christophe
 Leroy" <christophe.leroy@csgroup.eu>, Willy Tarreau <w@1wt.eu>, "Reinette
 Chatre" <reinette.chatre@intel.com>
Subject: Re: [PATCH net-next] once: add DO_ONCE_SLOW() for sleepable contexts
Message-ID: <aV7JKsNpsmnf5oQL@agluck-desk3>
References: <20221001205102.2319658-1-eric.dumazet@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221001205102.2319658-1-eric.dumazet@gmail.com>
X-ClientProxiedBy: BYAPR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::31) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b99042-b893-47cc-6a9b-08de4e2fa31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sajs2CCiiGOiLhzpOsz4yUHXWFMK1ajjSQIuy38YsF6GdeN+94NkLbFDTNjn?=
 =?us-ascii?Q?i3jKpJ4OkcMBz2OtyZTvNAzg5GYqQT4HOJWgiNhKCs8gu0vxK+d6TZCMCZXg?=
 =?us-ascii?Q?dkHGDBQs8oEh8cg9J8gqunqhd0DGR0FzsAy38J2MhLR1nf0AkW7XtVUUS+vf?=
 =?us-ascii?Q?ZqmMlxWgsgZUwzAMA6jxQGMNMRshyJ+vu+dd0+DLipNtjhuPLuWCzqG6zcpS?=
 =?us-ascii?Q?EYCgnQYu7Wuze7X5SF5DxYSeZ/kWHeCJHb4p4r2o9VXp9ArX75kYpsx0EmA0?=
 =?us-ascii?Q?8TefwMxS4MzwetGqJp72EIwm0GXzsnN81Ji5dSP09BVYXECS3I5/Ks8fCt92?=
 =?us-ascii?Q?AzOTyWwqQiWbhpEuor1UT16PkRknle7Qm87+3i10EuqjaHdaQ7i0yNDS4i6C?=
 =?us-ascii?Q?KAVPxuYA1eTj4TOc/2UbU0B+hdmk70Fx9EUtDZIJo0JuXEmZGnQh1z3MvckB?=
 =?us-ascii?Q?x7SBKoEAVjqZd5o940ObvQE7MD2KY33ILW3p67GDt+XTBNAb+Mtciq5qNBn1?=
 =?us-ascii?Q?zJG+ZdS/5q/5FD5GY3ULg2c+lLZxJlc0sy4TkI5Xsk5YIzf7rHuKiONgEG1I?=
 =?us-ascii?Q?/ZTNbp9mrvjwm5En8SsdpMOA96bbh6LLIejLLRa0muEOFnr/AHMYfJz/AQLY?=
 =?us-ascii?Q?eRVgOkHbmVV7ysDzHBb83wgYFpTl2cRgTqVrzjSnOc0Zc9on8tOcZv1wDKUX?=
 =?us-ascii?Q?4N7jhCamwTSwNKG+MUgBQ9hX+koG43uqP5ZKtEfde0QHK+VxjxlQIcFDXHps?=
 =?us-ascii?Q?mbzrKYc9xTwqhEOzZZEFD65KgyrSrtqvmkOgYgtMeiNIEccpgXKbmeKSHjq1?=
 =?us-ascii?Q?SVCh6zdNaORjg1P5eRANAWYOdGxd+hWXCNA5AGMCwVjkreuiqktmW2LRFgkv?=
 =?us-ascii?Q?hTgJLievzMBlY3jS+X2LqHWB73mxGLX4h6Dr5swRptjfN0gufrZEvUj6Zlt7?=
 =?us-ascii?Q?cLp4LpHdyTjg7C/5Z/2vnxcK9QYaPualOvNhzRMuoxwsx6y0Ji6Jo92Px8xB?=
 =?us-ascii?Q?AzRjNYXu5GjAeRPrQL29MZeaZjYlEA2BAjSZxuRp1uptz+0o0HO26LHxZ21y?=
 =?us-ascii?Q?bekzKx3TDeDvjLvTzN+tmg3XTesdRebIxcYWA3G9kik7PbWXkp7nFOPunclS?=
 =?us-ascii?Q?UjzKIjJ2mCkiEISoTnMkE4qKZ3H7H+Y6xx05QFc+Q18avH7H99Q4RGjZgFH5?=
 =?us-ascii?Q?xca6UEbGVhuAvGU2dSi9PkCgPbj6R5m3bQ4vBHDgDh7zFESLHlWcjNdbY/iN?=
 =?us-ascii?Q?m4OrjbnR0lwBIQqY0RieO2NWv7Mw9SNs2MWYOLbUWZRAsflYawNXFDFmgZF3?=
 =?us-ascii?Q?OA+QJ6MY+YwThJF1Pyr5TDm/+hBBzxgJvr3BGdy6+6XbKDhEF5odyDTUfSwH?=
 =?us-ascii?Q?wKdZcKbAHMet5l3CnouZXFCm0DcF+UCjvUwziAH80dSvvIDDUagHXG6teTsm?=
 =?us-ascii?Q?azDMgTBCBha8YIWHA82ed/jPAa3xKsmS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clPbYLA05gO4qXUCWxCgjwqJOARjDmDEDa5XpICKSj4l84V6OsT5yp9f/zgQ?=
 =?us-ascii?Q?Nmon0LNSN6KEvXzD4bBg5aaJEvBJQkZp0ll9BCq4nusJRvOAdeXkS98PmNTZ?=
 =?us-ascii?Q?JhpPHrShPDIk0OIrqwbwIn1oxkGujbvf8T3Q7qUpEFobD5uIlXz6ntzv+wcy?=
 =?us-ascii?Q?80zs5V9otji7XZ+37Gv6Fs5zNcSPtfK5oljOwI/QlLxjFJrCjHp2N/KiMUKL?=
 =?us-ascii?Q?4G8LfQ4JBfgIUAcmVSrRVx1Jika4PUdVcziNuaJYHY+q+pmAPXfGldyf4rBU?=
 =?us-ascii?Q?ekQs85OdA8a/tVHYKh70X03AXJCRw/7RtTud1aQIiNiM6zczJzlnWkd7/Ktq?=
 =?us-ascii?Q?ePOr0BR/rKKCMYgNpo96iv8eEMW+SBLfor4Eqa9FoEGDv7qncqCzHXjMPYkC?=
 =?us-ascii?Q?LzrQUY1e3EUXO6q5WQZJyGmvy4uGiZAecQ4wJhEdzHP5aSfEPP/6D7ndNqX4?=
 =?us-ascii?Q?ErkV+77WOjzWRT9AZz/W7mBYB81QBQq9I3/Wv/zLx65TR0izucXzJmgcT4GA?=
 =?us-ascii?Q?YNz2KtgJO0aPKE+sm23bfPXsHkEdz1dMSZY2XGHR27ckUtIGVar52+1f8jz7?=
 =?us-ascii?Q?+ej44wSgyxc7VxVG6A0Ize6PpJqlFhQYHZgJ+hDo1SCx9e1Kx4rWaBupcR6b?=
 =?us-ascii?Q?fLLqj9tG9aiei4wRcVmqVs+nHkX3CQfkWk6O3i/xSLXPtd9dwbgdrRqomdCA?=
 =?us-ascii?Q?vRGihMiAezfp28aqmNjwtj2/VuvBnLNo4w1UzpcfUVSByXBSxalI0o6wUiyZ?=
 =?us-ascii?Q?xnBmTb/prAy6Ah8owCMOFpwDvocNjWdM26l6XU8BqsXBUgPf6udr89uUMjeF?=
 =?us-ascii?Q?9AtpVvBFzjszXKbgQEz+EWIOsGanvkSuDeuuvyItSPGjTwvzToXvfVwqOymd?=
 =?us-ascii?Q?eCV8kbBHskPJkmdE4aA3pH0BSKTmGmu+GSeZmUCC/qO5vt83e3ur8hjj4kpc?=
 =?us-ascii?Q?6JuJ6ojghqkTc8l55yURg6Os09xBTOYl3X9NdIIel+SV81Ty9k4Cp6g8RcW7?=
 =?us-ascii?Q?Qle3aKqIQiyOx3iYMMjRnm06No5WZKjM2JcgIHavS8Kv1U0ZvyWmxSmRYhQP?=
 =?us-ascii?Q?R9syPpY27K/Qd0gf895sOcTz+QCNEWHc8giN114lN6lA+xahlXHSeNm86PVg?=
 =?us-ascii?Q?VxGfAUmePaCGc3FRkzb+8Ul02low2QFL9wqP0KV4DdeR1Rn+ioW10sx/yY9m?=
 =?us-ascii?Q?7wXa0jNSVcc6uKz38dtSehPKY+MvWfSBazV6kMijx2QqtOR1WSHwhrnj13Rq?=
 =?us-ascii?Q?h3HNstqkkXdHdc+DKuG3LejhtaZV4U4a/ecPRolPP4wG/CSggkEdledfJZHR?=
 =?us-ascii?Q?oRefnblTtnRP8JCaB1Syn2rGkysa/XPp/ZReIr3yw3Ie2EC40jwwF7ryCwZf?=
 =?us-ascii?Q?TzLpWVoQHHFe4cd+WshBgTi3TxxqxTWg4sMiWysBeGQfUSbsdb5xDED4s+8v?=
 =?us-ascii?Q?rF3Zp7RsMrAPBC3LhvMzz0DEWLYEZNRvvCDPltTYPwD1ApiKiELifnoHbeQB?=
 =?us-ascii?Q?WbOyYPLEgecMhrFekLCBu0Y8zi2ve1b8F3RB/XNiiSpx56Gyj8TddZh1nPSx?=
 =?us-ascii?Q?nuapfzQGAyoyNfTKCaWAFtEtMMg343sQlR1uY5MFFYuCy5pdoOGujHD3LjNC?=
 =?us-ascii?Q?dmrDXP7xSckVKcJkthZ1C5gAtmVuIq1akJes/5DbcLxiPnYupK9T4ot+uMR0?=
 =?us-ascii?Q?IOjWUDH0ffEEw+y0tT8fa7YiFvwA2J0dWCCvKtkG5UudUUZTI3ZhcmQ9flg6?=
 =?us-ascii?Q?Sslsnq6fGg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b99042-b893-47cc-6a9b-08de4e2fa31b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 20:59:24.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QXoXHXvHOc/N35Z7NwcRP+Z+vJAHanjp/T53nk18hD3IQmsP4K0Z1kjFQhC5iAfcHBESQjvIQdTvLqfsWhWOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6607
X-OriginatorOrg: intel.com

On Sat, Oct 01, 2022 at 01:51:02PM -0700, Eric Dumazet wrote:
> +void __do_once_slow_done(bool *done, struct static_key_true *once_key,
> +			 struct module *mod)
> +	__releases(once_mutex)
> +{
> +	*done = true;
> +	mutex_unlock(&once_mutex);
> +	once_disable_jump(once_key, mod);

This seems to have been cut & pasted from __do_once_done(). But is there
a reason for the "sleepable" version to defer resetting the static key
in a work queue? Can't we just inline do:

	BUG_ON(!static_key_enabled(once_key));
	static_branch_disable(once_key);

> +}

-Tony

Credit to Reinette for raising this question. Blame me if I didn't spot
why a work queue is needed.


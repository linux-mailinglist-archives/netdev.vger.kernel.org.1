Return-Path: <netdev+bounces-237468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B1C4C252
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 08:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04EE3B5C09
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 07:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F4A332EC6;
	Tue, 11 Nov 2025 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRUBbKO/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B628731BC80;
	Tue, 11 Nov 2025 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846869; cv=fail; b=duAGgDcH4yTqufIH6OhASOnen9jX5acXabgFcY0qqcksXudi5rkfgEJcIueXE08l9wuQrMekbTf9QW9S+7E/h+aodMG0nep+e2dMC+LY3N8O24iJg9mdcclZ7woYHEONFkvfLFBTmllpHrFzC9NeOfhxExd8uF5C01lHiRSE1/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846869; c=relaxed/simple;
	bh=vQD/34pgMVFdlIWlASpbfJTuxwD7fYjXXrSHW7GuRzU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AOzOaZZSHzS3BjS4XTwGLkLk0zj+XmQ5YfVAwL1BiuNbQosMx41bLr7f7bhhupEqw5l42JQq1MADu+uNxdMdduDWASfzZTVfD0r/+Vb5QVg6qRj3U9M5Zm7XZUNUiT2X8VKifC2eQe2WTGancvhPoy1eWPPJNu42gHcl2aZ/VcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRUBbKO/; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762846866; x=1794382866;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=vQD/34pgMVFdlIWlASpbfJTuxwD7fYjXXrSHW7GuRzU=;
  b=CRUBbKO/fr40N1tq+OzbjgGKZP9WiPkGavX51UZSn6TrP70t43VYgtTN
   FLxJ+9snD9l4F6ELrHaGeYBM2uPA96mzgU7gC3BvyF7/rmkxGEJlgB/IZ
   UptEhjuaTZtCHl0jvfuqGgGlDh94T8JxUk+GnVFHAaFTPiddb6ps7Dg3Q
   dptI14CoMiv8eB61LKPYaY/hXAPmvh1QbdqV3hDgzQsOCItIoUCLrZgYz
   Lw24qAE5GjqxXCVzhzKwgBa1zMPAGgbJF38t6NPo6W2yVa9UbzHQvmPR4
   DAbOhRsGni8vXpxxYJi48m2i8kZiaZA/fEsPsdXUvW++0Ge0rYuAC2v+8
   g==;
X-CSE-ConnectionGUID: j10r211ERt63pdlGBLUyIg==
X-CSE-MsgGUID: jhrcF0LWT1ODV33q75k3yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82534276"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="82534276"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 23:41:03 -0800
X-CSE-ConnectionGUID: jNZJ6chwSwCAEDAArBaDDw==
X-CSE-MsgGUID: pelMVQzQTu2UvL95tgz19A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189331153"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 23:41:03 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 23:41:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 23:41:02 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 23:41:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohIvN/TplgPQOV3B68+SVGds/BJ3O6RBFU3pFdUQnDVvy856VRSsU4gK7GadPCr/eaE4puYvVw6iB3aJ7QLjBbSAVqRuQ65tLfXEeuNCffTnfPlD0FKA/ftC77cq0cQ5dzgDTJyq8BtQq1T6xyCPEDeZJKAz5tiijOP9aOAn7fI2tj02RS/QzcjSJM1AZGMG4cdsHVOIlDKO//kMjnvyKqnAef8Vf0b+XHlprlZDs2D11n+t8tK5W43PmzGdXpzyZYgkaUgSG9L5wcSkvrhdrMFv1BLgTfHgOS9fsr4irHC4HoBay5isYBtbtQHkwJTLrmR0yEh07jU7Jy4FtruLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzLVAy5Y681vY4fZtVGlP7nvAeyTD1JdbHmgk4tcSm0=;
 b=xn0G3+i8VD7kbiB+sj30DK/W0KzGPz/4uONDfScuLahPdPLBiZmqnYYM/QkWa64/4V+Iy2CFRa5QLolg2BEhk17O3mEpWDE31C+UX35oZd5FCZAnEpr5FufHP9hGaezd6I3O8aWoNhK8BaNV0pS1gbUjIQ10FDSPwoqwuSslBRoI+ysfaFm7CSq0PWc6c7vCRRy1CMjRkJWeTagNHgemDLRAX90MujUE7KsEWOuwskMghVnp62awES1sf735J7NKRwTL39Jrz0L87hdPI8m3ajyMmp76I5nh++ZmZPCafFhNwUI4AscItFI7o+mHhwTYrG/+HJCPWlHkHNSz1rImsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8586.namprd11.prod.outlook.com (2603:10b6:a03:56e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:41:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:41:00 +0000
Date: Tue, 11 Nov 2025 15:40:47 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Prithvi Tambewagh <activprithvi@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <alexanderduyck@fb.com>,
	<chuck.lever@oracle.com>, <linyunsheng@huawei.com>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<david.hunter.linux@gmail.com>, <khalid@kernel.org>,
	<linux-kernel-mentees@lists.linux.dev>, Prithvi Tambewagh
	<activprithvi@gmail.com>,
	<syzbot+4b8a1e4690e64b018227@syzkaller.appspotmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] net: core: Initialize new header to zero in
 pskb_expand_head
Message-ID: <202511111518.ae430160-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106192423.412977-1-activprithvi@gmail.com>
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8241f0-4e6c-4c69-46f8-08de20f5a857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c3kU5aGb0s5JWE4JFt8XC1AMrb2XiMdcQFMSlQYcA4jHdBpYt6sZKIttZVcp?=
 =?us-ascii?Q?2wEs39EERDwXUHNDkEMlQoNc7dQtcw67cYgmkxGnGXcb0KsIPH0hQpHxOAug?=
 =?us-ascii?Q?8kV+TKhoUFLXzkZNoxRTGVmSRA5TyJrACE8veThjMTtXC8jG2WqbjJJilv3E?=
 =?us-ascii?Q?VAoDI1snURkl+GeC3ztaAVEQfq/FgmiicXUYN1xctTW9T0vtkCWCfZiCj1YU?=
 =?us-ascii?Q?Vypz+UhUw9xxveL/JYLOezz2rfkZo/aKYnKR/661rTIDLLKqo1wq5+EfgkLc?=
 =?us-ascii?Q?Fg6rxXM9fJZDeXKifDkF9G2cF/JTX+0975F1KJwue6lwCP9gLjxEK5J/+4/8?=
 =?us-ascii?Q?5R1cn9NKqEWBCYLatsOpE1uEQyFFDbMboeOeVPauMAJxaSEiYkUxOYyfHoRw?=
 =?us-ascii?Q?Ea7YBCxJfU67dalXh1vxZOSr1vDE72Dvrf0I4Y7dFM+5eSNhQVofjQAy7PzU?=
 =?us-ascii?Q?rSW2r7QvEPYLovHCqfkHRrLaUFFWCk1uTbLuEqQNr5ovfYQxM+6pZfrnX4ct?=
 =?us-ascii?Q?PDGhyqiTefAYbIOG5sTlBEwhpg3uzlqSu8pbZLmQ1YcMFnmLahso2NZlZDCB?=
 =?us-ascii?Q?RLcKqFNQOMBUh9bOx5GWh+DaXG1t0xG/UwRGEm2XQf/t57fo/gFIFFT7tthQ?=
 =?us-ascii?Q?Gp8mP08ol6+3Ko+nbXKKjbFRXiJ+s+mUK1lfv28RofrJU1ckgeiB75SDm6/0?=
 =?us-ascii?Q?sp8/mxe8o5Y9Y15qar4FIFg4PAAnERuVcvYiyIOmOcEL4mL7r01UQkb/95Jv?=
 =?us-ascii?Q?2U7D3YgJjCxSty1vX6p7xHipFTaAszrxyO9ZYG0ixdLoEwNzENpYCWhQxMWA?=
 =?us-ascii?Q?Hz1JU57kPCnlnOCjnHAum8IoPrnx9P6njE3ei23TdxkfXxrsZMWnlLnGBEd5?=
 =?us-ascii?Q?xNIY6E7dlGDB4Zf4Y+L/LeO9SJU5yKLbMa45QqWzQSjKKlohFJEGNxcbEVpa?=
 =?us-ascii?Q?LgdRlWZRADRIvJAPe9IApxTm9maEz5T7P1x3xS3xie5cDkAtHGQ58xFGiH+h?=
 =?us-ascii?Q?m0nQa81Go8DSI6ml5HrBJ1OQQtL1kUWaNkkaC4qPAbEGTszn67eCiN/ncmtJ?=
 =?us-ascii?Q?Uxc6leaiEZZMX8Ln7mZZry2JFIT8AiyldPNKgKPUgtnqKCl6+5uAP4PPEtCB?=
 =?us-ascii?Q?NQeHQJBG2HJHuApQ8s6YhpPS2yefvBc37/BMiJwvKIMT2ZIp+My6Qm1rEi/K?=
 =?us-ascii?Q?cLZFiYnRM/t6nGdaY+6xXj8lWDA3FRB9uAJvm5Cg1KfKQfYfIjQSwDR1r4gA?=
 =?us-ascii?Q?CN3xXU89fSobZbxom2DWjsmIM9ov0xbjZUc+ua3iHI5EW6Aamo4Jrk72uCbN?=
 =?us-ascii?Q?Z8CEjE2VhZWKv4jRqjk6GKFvGUGEB9fl9LRhD+sFexgbOG//gKH1lN504/Bc?=
 =?us-ascii?Q?R2WAYkdJWbhJwDwB2EHJLHumMmm/y7tqVy3Q2ZN6CrN/om0QgKwtA5Z/S3Qw?=
 =?us-ascii?Q?jYV3Zx4zutT4THtuTvopDdYyLgwT60oyVx60EJFyW0qe2/Mz9O5P+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o0TZuSof203KF4He7RWGas3R+MAa9ry79y9HIWl3yNzvUw6oi8cZrWDvnNE2?=
 =?us-ascii?Q?FliJMs775zmITO+C5w1LmlxFMof3yqR/qmrBQT2fgSqyAFeQ9XAc0GVw3j7d?=
 =?us-ascii?Q?ldWzTqOyF0tAtICNZR6rQb9Ls4tqdiDrJfCfrJsMBZB2vSTxnRinwhGSEVSK?=
 =?us-ascii?Q?w1GJNl34VLkubUSfiE2n4+YrR7t4GSnjPzlDBwVX80YhW/wGIKGhB8NGj2fE?=
 =?us-ascii?Q?DG0lMHh9qK3sJ9GEoxp4TJBOChf6aPbbKYrSKbSOCmSsLAjuLaU1427Hkr58?=
 =?us-ascii?Q?JSXWXS+mLC9QRk/AO71iXvTHWDZfNGnoGwC21ER3eksyTIjcrxUuw2fTYHR1?=
 =?us-ascii?Q?0JEOqWMtBr+JC2RV9yREr/lHbMOnSeRupKfvkFK6GAGhOGMqHkby1MVvqbq0?=
 =?us-ascii?Q?CK0LcK7co2E7kpp0Lea1gAC3lk0lcyyI195OUYlr+pn6+34lscUdAzDdHl1c?=
 =?us-ascii?Q?+Z/GbDr4J4r5LTN/uyJafvs2xM72Feco3/RuVt8wKoNnmWrkR9Ww3YCE0HJg?=
 =?us-ascii?Q?wofNgRI9OSx/lYXf20p1O3cZzD1YRTjFo4+sTYg4uZ+EYDLIIi038VtoXICj?=
 =?us-ascii?Q?egP5uA1D6/6iO4jIxSMwT2RAjH/TRRDLXfCaaUgk8FiNP7Igr7zvvlmLqvKF?=
 =?us-ascii?Q?z1Ovgm5W4Ib1Q9/KcyezbCaFYJAw9OIsXOgz/w8B+A+0kA2E+0BaugIdi7RJ?=
 =?us-ascii?Q?s2FT3xmFKjiWPrRTqn4/507BXqLuFQld4+nqJn7eaXXOG8ogKGk/zRdti3u4?=
 =?us-ascii?Q?2QYPjSwAgAeKs7bbtUHeec+fSmQFJejyY/7AiqeLJwiH6sgRKHh+/b6+gMqm?=
 =?us-ascii?Q?f/6LuhsWTYBa5FxwPQETLbustzIvrOqK9Zg4Q9yh41FpRY2uomj5HqOhgemr?=
 =?us-ascii?Q?R4+DMiEldVO5BRjCg3WHkGu1JReSKmXoDKKazVMo3xHR4x+AZVNqByQnvGWP?=
 =?us-ascii?Q?03r4X43R9slMMglpZ2/E3wpmcvSRmi7YyTtv3Q+wZ39XpYlI8SMGLNi7f0Am?=
 =?us-ascii?Q?bUCXXT2Js3e8oCYtYu4uRQ1MDrhi8WjJNkH3a5yUYLTYkCCfyB7Wc4hbV8PV?=
 =?us-ascii?Q?8sTz5hHB0bk1Fzn+5IR1iubFhP1pF0HylfxFAAmCht7CtI1wFAp79RFKKuB9?=
 =?us-ascii?Q?xfbiVjN6M3hltb717nLGwCAu5NWAnvbuUX3muVNzSUk3z6f+/snODhEasxYw?=
 =?us-ascii?Q?mPWJs0kVrWLgW5bmbqyUC/dLdzVQaOg981Z/6cnpPa9RJFxukt+pdTgKUt4r?=
 =?us-ascii?Q?3fgLYXBZIyStpdaPOyTJOpUXuPPVNVtaT5Wowystb3uatX5us+HAM+5Z4A7X?=
 =?us-ascii?Q?Z2kC059MhklEg62elnXRvS7DYKlRx1zKfNVlVYbo0JpoUvUfGMR/ngiJuGbe?=
 =?us-ascii?Q?2wpLFx6qo9oKHyOdTeS4eqttG3hhV8mVDG2CCerZrVHNeG63BpSr/8CKKK5+?=
 =?us-ascii?Q?RQDeaA+EzSjdI3kZXtRL5l2TyAe/lFsQWdCj83AivF6rE3mZF1nWkwitdCqY?=
 =?us-ascii?Q?OK4Kyj9+wzq93/Yt+8/fysWUyGBuliHr7WpAhLuLLarp7q/15OMLiZg2NcZy?=
 =?us-ascii?Q?92Y+qUCVrDi0twGKxrS+Q0l2pGoJUIvPHhbGXIW7KGnm8sqGnVXKY51lpG7E?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8241f0-4e6c-4c69-46f8-08de20f5a857
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:41:00.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bb55W40gew+X9zW0Zi8gRopOJSufN4JuyJthcL1PF77z8xjXjRkecntHe/A9P9as0Po1PPWi4Ox/beOC1R+14Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8586
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "stress-ng.netlink-task.fail" on:

commit: 929eaa699941b1b7ba6b008c27ea9c60a45b645b ("[PATCH] net: core: Initialize new header to zero in pskb_expand_head")
url: https://github.com/intel-lab-lkp/linux/commits/Prithvi-Tambewagh/net-core-Initialize-new-header-to-zero-in-pskb_expand_head/20251107-032744
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git 1ec9871fbb80ba7db84f868f6aa40d38bc43f0e0
patch link: https://lore.kernel.org/all/20251106192423.412977-1-activprithvi@gmail.com/
patch subject: [PATCH] net: core: Initialize new header to zero in pskb_expand_head

in testcase: stress-ng
version: stress-ng-x86_64-f38a0b09a-1_20251013
with following parameters:

	nr_threads: 100%
	testtime: 60s
	test: netlink-task
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 256 threads 2 sockets Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz (Granite Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511111518.ae430160-lkp@intel.com

2025-11-10 01:30:35 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --netlink-task 256
stress-ng: info:  [9592] setting to a 1 min run per stressor
stress-ng: info:  [9592] dispatching hogs: 256 netlink-task
stress-ng: info:  [9592] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
stress-ng: fail:  [9617] netlink-task: recv NLMSG error
stress-ng: fail:  [9618] netlink-task: recv NLMSG error
stress-ng: fail:  [9619] netlink-task: recv NLMSG error
stress-ng: fail:  [9620] netlink-task: recv NLMSG error
stress-ng: fail:  [9621] netlink-task: recv NLMSG error
stress-ng: fail:  [9622] netlink-task: recv NLMSG error
stress-ng: fail:  [9623] netlink-task: recv NLMSG error
stress-ng: fail:  [9624] netlink-task: recv NLMSG error
stress-ng: fail:  [9625] netlink-task: recv NLMSG error
stress-ng: fail:  [9626] netlink-task: recv NLMSG error
stress-ng: fail:  [9627] netlink-task: recv NLMSG error
stress-ng: fail:  [9628] netlink-task: recv NLMSG error
stress-ng: fail:  [9629] netlink-task: recv NLMSG error
stress-ng: fail:  [9630] netlink-task: recv NLMSG error
stress-ng: fail:  [9631] netlink-task: recv NLMSG error
stress-ng: fail:  [9632] netlink-task: recv NLMSG error
stress-ng: fail:  [9633] netlink-task: recv NLMSG error
stress-ng: fail:  [9634] netlink-task: recv NLMSG error
stress-ng: fail:  [9635] netlink-task: recv NLMSG error
stress-ng: fail:  [9636] netlink-task: recv NLMSG error
stress-ng: fail:  [9637] netlink-task: recv NLMSG error
stress-ng: fail:  [9638] netlink-task: recv NLMSG error
stress-ng: fail:  [9639] netlink-task: recv NLMSG error
stress-ng: fail:  [9640] netlink-task: recv NLMSG error
stress-ng: fail:  [9641] netlink-task: recv NLMSG error
stress-ng: fail:  [9642] netlink-task: recv NLMSG error
stress-ng: fail:  [9643] netlink-task: recv NLMSG error
stress-ng: fail:  [9644] netlink-task: recv NLMSG error
stress-ng: fail:  [9645] netlink-task: recv NLMSG error
stress-ng: fail:  [9646] netlink-task: recv NLMSG error
stress-ng: fail:  [9647] netlink-task: recv NLMSG error
stress-ng: fail:  [9648] netlink-task: recv NLMSG error
stress-ng: fail:  [9649] netlink-task: recv NLMSG error
stress-ng: fail:  [9650] netlink-task: recv NLMSG error
stress-ng: fail:  [9651] netlink-task: recv NLMSG error
stress-ng: fail:  [9652] netlink-task: recv NLMSG error
stress-ng: fail:  [9653] netlink-task: recv NLMSG error
stress-ng: fail:  [9654] netlink-task: recv NLMSG error
stress-ng: fail:  [9655] netlink-task: recv NLMSG error
stress-ng: fail:  [9656] netlink-task: recv NLMSG error
stress-ng: fail:  [9657] netlink-task: recv NLMSG error
stress-ng: fail:  [9658] netlink-task: recv NLMSG error
stress-ng: fail:  [9659] netlink-task: recv NLMSG error
stress-ng: fail:  [9660] netlink-task: recv NLMSG error
stress-ng: fail:  [9661] netlink-task: recv NLMSG error
stress-ng: fail:  [9662] netlink-task: recv NLMSG error
stress-ng: fail:  [9663] netlink-task: recv NLMSG error
stress-ng: fail:  [9664] netlink-task: recv NLMSG error
stress-ng: fail:  [9665] netlink-task: recv NLMSG error
stress-ng: fail:  [9666] netlink-task: recv NLMSG error
stress-ng: fail:  [9667] netlink-task: recv NLMSG error
stress-ng: fail:  [9668] netlink-task: recv NLMSG error
stress-ng: fail:  [9669] netlink-task: recv NLMSG error
stress-ng: fail:  [9670] netlink-task: recv NLMSG error
stress-ng: fail:  [9671] netlink-task: recv NLMSG error
stress-ng: fail:  [9672] netlink-task: recv NLMSG error
stress-ng: fail:  [9673] netlink-task: recv NLMSG error
stress-ng: fail:  [9674] netlink-task: recv NLMSG error
stress-ng: fail:  [9675] netlink-task: recv NLMSG error
stress-ng: fail:  [9676] netlink-task: recv NLMSG error
stress-ng: fail:  [9677] netlink-task: recv NLMSG error
stress-ng: fail:  [9678] netlink-task: recv NLMSG error
stress-ng: fail:  [9679] netlink-task: recv NLMSG error
stress-ng: fail:  [9680] netlink-task: recv NLMSG error
stress-ng: fail:  [9681] netlink-task: recv NLMSG error
stress-ng: fail:  [9682] netlink-task: recv NLMSG error
stress-ng: fail:  [9683] netlink-task: recv NLMSG error
stress-ng: fail:  [9684] netlink-task: recv NLMSG error
stress-ng: fail:  [9685] netlink-task: recv NLMSG error
stress-ng: fail:  [9686] netlink-task: recv NLMSG error
stress-ng: fail:  [9687] netlink-task: recv NLMSG error
stress-ng: fail:  [9688] netlink-task: recv NLMSG error
stress-ng: fail:  [9689] netlink-task: recv NLMSG error
stress-ng: fail:  [9690] netlink-task: recv NLMSG error
stress-ng: fail:  [9691] netlink-task: recv NLMSG error
stress-ng: fail:  [9692] netlink-task: recv NLMSG error
stress-ng: fail:  [9693] netlink-task: recv NLMSG error
stress-ng: fail:  [9694] netlink-task: recv NLMSG error
stress-ng: fail:  [9695] netlink-task: recv NLMSG error
stress-ng: fail:  [9696] netlink-task: recv NLMSG error
stress-ng: fail:  [9697] netlink-task: recv NLMSG error
stress-ng: fail:  [9698] netlink-task: recv NLMSG error
stress-ng: fail:  [9699] netlink-task: recv NLMSG error
stress-ng: fail:  [9700] netlink-task: recv NLMSG error
stress-ng: fail:  [9701] netlink-task: recv NLMSG error
stress-ng: fail:  [9702] netlink-task: recv NLMSG error
stress-ng: fail:  [9703] netlink-task: recv NLMSG error
stress-ng: fail:  [9704] netlink-task: recv NLMSG error
stress-ng: fail:  [9705] netlink-task: recv NLMSG error
stress-ng: fail:  [9706] netlink-task: recv NLMSG error
stress-ng: fail:  [9707] netlink-task: recv NLMSG error
stress-ng: fail:  [9708] netlink-task: recv NLMSG error
stress-ng: fail:  [9709] netlink-task: recv NLMSG error
stress-ng: fail:  [9710] netlink-task: recv NLMSG error
stress-ng: fail:  [9711] netlink-task: recv NLMSG error
stress-ng: fail:  [9712] netlink-task: recv NLMSG error
stress-ng: fail:  [9713] netlink-task: recv NLMSG error
stress-ng: fail:  [9714] netlink-task: recv NLMSG error
stress-ng: fail:  [9715] netlink-task: recv NLMSG error
stress-ng: fail:  [9716] netlink-task: recv NLMSG error
stress-ng: fail:  [9717] netlink-task: recv NLMSG error
stress-ng: fail:  [9718] netlink-task: recv NLMSG error
stress-ng: fail:  [9719] netlink-task: recv NLMSG error
stress-ng: fail:  [9720] netlink-task: recv NLMSG error
stress-ng: fail:  [9721] netlink-task: recv NLMSG error
stress-ng: fail:  [9722] netlink-task: recv NLMSG error
stress-ng: fail:  [9723] netlink-task: recv NLMSG error
stress-ng: fail:  [9724] netlink-task: recv NLMSG error
stress-ng: fail:  [9725] netlink-task: recv NLMSG error
stress-ng: fail:  [9726] netlink-task: recv NLMSG error
stress-ng: fail:  [9727] netlink-task: recv NLMSG error
stress-ng: fail:  [9728] netlink-task: recv NLMSG error
stress-ng: fail:  [9729] netlink-task: recv NLMSG error
stress-ng: fail:  [9730] netlink-task: recv NLMSG error
stress-ng: fail:  [9731] netlink-task: recv NLMSG error
stress-ng: fail:  [9732] netlink-task: recv NLMSG error
stress-ng: fail:  [9733] netlink-task: recv NLMSG error
stress-ng: fail:  [9734] netlink-task: recv NLMSG error
stress-ng: fail:  [9735] netlink-task: recv NLMSG error
stress-ng: fail:  [9736] netlink-task: recv NLMSG error
stress-ng: fail:  [9737] netlink-task: recv NLMSG error
stress-ng: fail:  [9738] netlink-task: recv NLMSG error
stress-ng: fail:  [9739] netlink-task: recv NLMSG error
stress-ng: fail:  [9740] netlink-task: recv NLMSG error
stress-ng: fail:  [9741] netlink-task: recv NLMSG error
stress-ng: fail:  [9742] netlink-task: recv NLMSG error
stress-ng: fail:  [9743] netlink-task: recv NLMSG error
stress-ng: fail:  [9744] netlink-task: recv NLMSG error
stress-ng: fail:  [9745] netlink-task: recv NLMSG error
stress-ng: fail:  [9746] netlink-task: recv NLMSG error
stress-ng: fail:  [9747] netlink-task: recv NLMSG error
stress-ng: fail:  [9748] netlink-task: recv NLMSG error
stress-ng: fail:  [9749] netlink-task: recv NLMSG error
stress-ng: fail:  [9750] netlink-task: recv NLMSG error
stress-ng: fail:  [9751] netlink-task: recv NLMSG error
stress-ng: fail:  [9752] netlink-task: recv NLMSG error
stress-ng: fail:  [9753] netlink-task: recv NLMSG error
stress-ng: fail:  [9754] netlink-task: recv NLMSG error
stress-ng: fail:  [9755] netlink-task: recv NLMSG error
stress-ng: fail:  [9756] netlink-task: recv NLMSG error
stress-ng: fail:  [9757] netlink-task: recv NLMSG error
stress-ng: fail:  [9758] netlink-task: recv NLMSG error
stress-ng: fail:  [9759] netlink-task: recv NLMSG error
stress-ng: fail:  [9760] netlink-task: recv NLMSG error
stress-ng: fail:  [9761] netlink-task: recv NLMSG error
stress-ng: fail:  [9762] netlink-task: recv NLMSG error
stress-ng: fail:  [9763] netlink-task: recv NLMSG error
stress-ng: fail:  [9764] netlink-task: recv NLMSG error
stress-ng: fail:  [9765] netlink-task: recv NLMSG error
stress-ng: fail:  [9766] netlink-task: recv NLMSG error
stress-ng: fail:  [9767] netlink-task: recv NLMSG error
stress-ng: fail:  [9768] netlink-task: recv NLMSG error
stress-ng: fail:  [9769] netlink-task: recv NLMSG error
stress-ng: fail:  [9770] netlink-task: recv NLMSG error
stress-ng: fail:  [9771] netlink-task: recv NLMSG error
stress-ng: fail:  [9772] netlink-task: recv NLMSG error
stress-ng: fail:  [9773] netlink-task: recv NLMSG error
stress-ng: fail:  [9774] netlink-task: recv NLMSG error
stress-ng: fail:  [9775] netlink-task: recv NLMSG error
stress-ng: fail:  [9776] netlink-task: recv NLMSG error
stress-ng: fail:  [9777] netlink-task: recv NLMSG error
stress-ng: fail:  [9778] netlink-task: recv NLMSG error
stress-ng: fail:  [9779] netlink-task: recv NLMSG error
stress-ng: fail:  [9780] netlink-task: recv NLMSG error
stress-ng: fail:  [9781] netlink-task: recv NLMSG error
stress-ng: fail:  [9782] netlink-task: recv NLMSG error
stress-ng: fail:  [9783] netlink-task: recv NLMSG error
stress-ng: fail:  [9784] netlink-task: recv NLMSG error
stress-ng: fail:  [9785] netlink-task: recv NLMSG error
stress-ng: fail:  [9786] netlink-task: recv NLMSG error
stress-ng: fail:  [9787] netlink-task: recv NLMSG error
stress-ng: fail:  [9788] netlink-task: recv NLMSG error
stress-ng: fail:  [9789] netlink-task: recv NLMSG error
stress-ng: fail:  [9790] netlink-task: recv NLMSG error
stress-ng: fail:  [9791] netlink-task: recv NLMSG error
stress-ng: fail:  [9792] netlink-task: recv NLMSG error
stress-ng: fail:  [9793] netlink-task: recv NLMSG error
stress-ng: fail:  [9794] netlink-task: recv NLMSG error
stress-ng: fail:  [9795] netlink-task: recv NLMSG error
stress-ng: fail:  [9796] netlink-task: recv NLMSG error
stress-ng: fail:  [9797] netlink-task: recv NLMSG error
stress-ng: fail:  [9798] netlink-task: recv NLMSG error
stress-ng: fail:  [9799] netlink-task: recv NLMSG error
stress-ng: fail:  [9800] netlink-task: recv NLMSG error
stress-ng: fail:  [9801] netlink-task: recv NLMSG error
stress-ng: fail:  [9802] netlink-task: recv NLMSG error
stress-ng: fail:  [9803] netlink-task: recv NLMSG error
stress-ng: fail:  [9804] netlink-task: recv NLMSG error
stress-ng: fail:  [9805] netlink-task: recv NLMSG error
stress-ng: fail:  [9806] netlink-task: recv NLMSG error
stress-ng: fail:  [9807] netlink-task: recv NLMSG error
stress-ng: fail:  [9808] netlink-task: recv NLMSG error
stress-ng: fail:  [9809] netlink-task: recv NLMSG error
stress-ng: fail:  [9810] netlink-task: recv NLMSG error
stress-ng: fail:  [9811] netlink-task: recv NLMSG error
stress-ng: fail:  [9812] netlink-task: recv NLMSG error
stress-ng: fail:  [9813] netlink-task: recv NLMSG error
stress-ng: fail:  [9814] netlink-task: recv NLMSG error
stress-ng: fail:  [9815] netlink-task: recv NLMSG error
stress-ng: fail:  [9816] netlink-task: recv NLMSG error
stress-ng: fail:  [9817] netlink-task: recv NLMSG error
stress-ng: fail:  [9818] netlink-task: recv NLMSG error
stress-ng: fail:  [9819] netlink-task: recv NLMSG error
stress-ng: fail:  [9820] netlink-task: recv NLMSG error
stress-ng: fail:  [9821] netlink-task: recv NLMSG error
stress-ng: fail:  [9822] netlink-task: recv NLMSG error
stress-ng: fail:  [9823] netlink-task: recv NLMSG error
stress-ng: fail:  [9824] netlink-task: recv NLMSG error
stress-ng: fail:  [9825] netlink-task: recv NLMSG error
stress-ng: fail:  [9826] netlink-task: recv NLMSG error
stress-ng: fail:  [9827] netlink-task: recv NLMSG error
stress-ng: fail:  [9828] netlink-task: recv NLMSG error
stress-ng: fail:  [9829] netlink-task: recv NLMSG error
stress-ng: fail:  [9830] netlink-task: recv NLMSG error
stress-ng: fail:  [9831] netlink-task: recv NLMSG error
stress-ng: fail:  [9832] netlink-task: recv NLMSG error
stress-ng: fail:  [9833] netlink-task: recv NLMSG error
stress-ng: fail:  [9834] netlink-task: recv NLMSG error
stress-ng: fail:  [9835] netlink-task: recv NLMSG error
stress-ng: fail:  [9836] netlink-task: recv NLMSG error
stress-ng: fail:  [9837] netlink-task: recv NLMSG error
stress-ng: fail:  [9838] netlink-task: recv NLMSG error
stress-ng: fail:  [9839] netlink-task: recv NLMSG error
stress-ng: fail:  [9840] netlink-task: recv NLMSG error
stress-ng: fail:  [9841] netlink-task: recv NLMSG error
stress-ng: fail:  [9842] netlink-task: recv NLMSG error
stress-ng: fail:  [9843] netlink-task: recv NLMSG error
stress-ng: fail:  [9844] netlink-task: recv NLMSG error
stress-ng: fail:  [9845] netlink-task: recv NLMSG error
stress-ng: fail:  [9846] netlink-task: recv NLMSG error
stress-ng: fail:  [9847] netlink-task: recv NLMSG error
stress-ng: fail:  [9848] netlink-task: recv NLMSG error
stress-ng: fail:  [9849] netlink-task: recv NLMSG error
stress-ng: fail:  [9850] netlink-task: recv NLMSG error
stress-ng: fail:  [9851] netlink-task: recv NLMSG error
stress-ng: fail:  [9852] netlink-task: recv NLMSG error
stress-ng: fail:  [9853] netlink-task: recv NLMSG error
stress-ng: fail:  [9854] netlink-task: recv NLMSG error
stress-ng: fail:  [9855] netlink-task: recv NLMSG error
stress-ng: fail:  [9856] netlink-task: recv NLMSG error
stress-ng: fail:  [9857] netlink-task: recv NLMSG error
stress-ng: fail:  [9858] netlink-task: recv NLMSG error
stress-ng: fail:  [9859] netlink-task: recv NLMSG error
stress-ng: fail:  [9860] netlink-task: recv NLMSG error
stress-ng: fail:  [9861] netlink-task: recv NLMSG error
stress-ng: fail:  [9862] netlink-task: recv NLMSG error
stress-ng: fail:  [9863] netlink-task: recv NLMSG error
stress-ng: fail:  [9864] netlink-task: recv NLMSG error
stress-ng: fail:  [9865] netlink-task: recv NLMSG error
stress-ng: fail:  [9866] netlink-task: recv NLMSG error
stress-ng: fail:  [9867] netlink-task: recv NLMSG error
stress-ng: error: [9592] netlink-task: [9617] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9618] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9619] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9620] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9621] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9622] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9623] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9624] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9625] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9626] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9627] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9628] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9629] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9630] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9631] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9632] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9633] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9634] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9635] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9636] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9637] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9638] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9639] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9640] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9641] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9642] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9643] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9644] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9645] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9646] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9647] terminated with an error, exit status=2 (stressor failed)
stress-ng: fail:  [9868] netlink-task: recv NLMSG error
stress-ng: error: [9592] netlink-task: [9648] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9649] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9650] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9651] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9652] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9653] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9654] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9655] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9656] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9657] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9658] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9659] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9660] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9661] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9662] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9663] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9664] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9665] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9666] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9667] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9668] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9669] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9670] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9671] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9672] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9673] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9674] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9675] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9676] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9677] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9678] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9679] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9680] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9681] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9682] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9683] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9684] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9685] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9686] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9687] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9688] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9689] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9690] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9691] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9692] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9693] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9694] terminated with an error, exit status=2 (stressor failed)
stress-ng: fail:  [9869] netlink-task: recv NLMSG error
stress-ng: error: [9592] netlink-task: [9695] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9696] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9697] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9698] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9699] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9700] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9701] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9702] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9703] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9704] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9705] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9706] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9707] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9708] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9709] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9710] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9711] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9712] terminated with an error, exit status=2 (stressor failed)
stress-ng: fail:  [9870] netlink-task: recv NLMSG error
stress-ng: error: [9592] netlink-task: [9713] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9714] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9715] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9716] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9717] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9718] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9719] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9720] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9721] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9722] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9723] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9724] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9725] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9726] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9727] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9728] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9729] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9730] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9731] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9732] terminated with an error, exit status=2 (stressor failed)
stress-ng: fail:  [9871] netlink-task: recv NLMSG error
stress-ng: error: [9592] netlink-task: [9733] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9734] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9735] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9736] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9737] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9738] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9739] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9740] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9741] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9742] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9743] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9744] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9745] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9746] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9747] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9748] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9749] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9750] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9751] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9752] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9753] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9754] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9755] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9756] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9757] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9758] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9759] terminated with an error, exit status=2 (stressor failed)
stress-ng: fail:  [9872] netlink-task: recv NLMSG error
stress-ng: error: [9592] netlink-task: [9760] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9761] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9762] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9763] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9764] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9765] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9766] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9767] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9768] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9769] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9770] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9771] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9772] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9773] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9774] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9775] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9776] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9777] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9778] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9779] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9780] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9781] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9782] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9783] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9784] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9785] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9786] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9787] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9788] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9789] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9790] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9791] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9792] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9793] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9794] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9795] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9796] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9797] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9798] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9799] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9800] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9801] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9802] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9803] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9804] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9805] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9806] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9807] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9808] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9809] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9810] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9811] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9812] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9813] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9814] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9815] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9816] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9817] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9818] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9819] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9820] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9821] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9822] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9823] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9824] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9825] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9826] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9827] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9828] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9829] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9830] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9831] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9832] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9833] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9834] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9835] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9836] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9837] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9838] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9839] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9840] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9841] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9842] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9843] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9844] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9845] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9846] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9847] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9848] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9849] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9850] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9851] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9852] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9853] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9854] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9855] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9856] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9857] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9858] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9859] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9860] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9861] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9862] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9863] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9864] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9865] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9866] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9867] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9868] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9869] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9870] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9871] terminated with an error, exit status=2 (stressor failed)
stress-ng: error: [9592] netlink-task: [9872] terminated with an error, exit status=2 (stressor failed)
stress-ng: metrc: [9592] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [9592]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [9592] netlink-task          0      0.00      0.05      0.01         0.00           0.00       721.68          2092
stress-ng: info:  [9592] for a 0.07s run time:
stress-ng: info:  [9592]      18.83s available CPU time
stress-ng: info:  [9592]       0.08s user time   (  0.42%)
stress-ng: info:  [9592]       0.06s system time (  0.32%)
stress-ng: info:  [9592]       0.14s total time  (  0.74%)
stress-ng: info:  [9592] load average: 0.56 0.32 0.14
stress-ng: info:  [9592] skipped: 0
stress-ng: info:  [9592] passed: 0
stress-ng: info:  [9592] failed: 256: netlink-task (256)
stress-ng: info:  [9592] metrics untrustworthy: 0
stress-ng: info:  [9592] unsuccessful run completed in 0 secs



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251111/202511111518.ae430160-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



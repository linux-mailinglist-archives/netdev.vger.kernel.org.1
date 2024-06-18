Return-Path: <netdev+bounces-104645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC9C90DB67
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 20:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC6428323C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5AB15ECCD;
	Tue, 18 Jun 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWfotDve"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35E15E5CC;
	Tue, 18 Jun 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734550; cv=fail; b=WiTPDYSJO2R0feU+p+gRRE3KxL4xP/6rdnzJUVF8fg3tI+yV6N7Zr5ijgZR7BM72G+2kEwIqxSspYhLPF1nVcPgLHfi0129GDI9FMEQlYRficRCN+O5qmI+KjADU8336RQTLGmBcPaS0l0weyQKsBHXF9PaBdDr8g1v3h97JyKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734550; c=relaxed/simple;
	bh=XiC6B0/WOG7c3q4uKGrm8i0x2xPSz/pmcU/nHfBx9Ws=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PaQu6Td0lPhhrDruv9ljfJxzFMDJsWiNsj4Ncut+VI4dgaHlW1e5sORRdcHLrTNp/fLSnN8No4KLYlAvmQuad+DU2W2Ai9Awnpn3fjRW4xbts2cwPPNiYBTYDOplFZsh7axb3SYCFYB6MXQ8B+l8zqNYefRUceQzFTIaTduqoIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWfotDve; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718734549; x=1750270549;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XiC6B0/WOG7c3q4uKGrm8i0x2xPSz/pmcU/nHfBx9Ws=;
  b=SWfotDvey8D+ttYwxeEB4dlwEZMG7c+eGAY6fLZ9STZkW9h4ANGqqUu0
   c2jP67BASVD3O3GjkhCa48/SuQd0grvpT/ufbLIUmeVUq7HoPEqzSimAq
   c8Xans5uj6CeJBpdypzhkt22Wpypkm9wqGsvqaVlDw6zW+aHykXkzuVJ7
   kv27+iLx5/FxFsY8/+E/REusWOTE1vX82CHcvQxAN4R8ost5BmCiEPXUm
   BXkw4XYybz9EZWgE6dzYYppxJlKKkVLDJ+/qd1diYay4TN6gsyfS3eZ69
   jcZbCe+RfmVWjFuU/2uWX+BZORCfmT8G6bIStAA0jhUqaNMI4EWMy9VdS
   Q==;
X-CSE-ConnectionGUID: 5nQRJ/v7SZCxQRE40Bx/zw==
X-CSE-MsgGUID: mlRwqxu4RbOGCBab8hJXZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15511324"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15511324"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 11:15:48 -0700
X-CSE-ConnectionGUID: Y+6LMB84TXeBtQ8+UI4D1w==
X-CSE-MsgGUID: m0g//NYMT82ZtdlYZz5HgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46202250"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 11:15:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 11:15:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 11:15:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 11:15:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 11:15:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf7RW3XmhvWl+qUnPLjPRHiQaptGCadGS+49+q5D/FkkTHHp/mu1STzLNBmqXyEnYRM1X/Nu0Rfotum49CpPPKXQz2c1pp511BhPtZ94LRCw91sK57HESv8IzaIla6ftG3Rv87ETejRV+lVgrk0foj274SbezD6O0y3vQFFJWYqjngvcK1kKRI3B9AeQtlzFcLnqi2f5hdysTT3dCqdEkskOsgtx417Z0iyJhgH9NAtuqiwiO+CsXFF143+6NggzoxYjw8ALaC9IxSfN7zH4kWs42HXye+59cnHNDBxZvm21ysnguTImmuAyJSXcZ6ePwddWt4BiNL9mclyBdY9PwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfYO3HHQGPug4PJqJds0GIJOP/Uc9ZGFZN0Z1c38axI=;
 b=A1oVZUC984jlfv7n0dgXfoQ0nwZ49CNN1OkAxsi/6E6pgkn+D478RG46DVEmYIpEQ4q9TuAqPZG4fQKTDqg7FCpmwZFZOFSH2H48TXzHEfGMxLRV0oN7oHMkMIHuFQqqOnm4rUtHq8RSTQNbMwUoSOKTkM7fuNdZRlH3XFgsZ0/3jicN82Mc2qQ1Jxcv8ck7uz87P8BVebpW3CyupQv6dvYwlr3eJlpZsjlKuexvrxu5xZtGaT15UK3ZA6HbBOw7JiEmrXQAmG6J7BYjccJXzhbhFd3yZNEukXBXRJa21/+M8f+kT4sWqPsigtwNcSjj/7GH0jp9dpUhqRfxLkaabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Tue, 18 Jun 2024 18:15:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Tue, 18 Jun 2024
 18:15:29 +0000
Date: Tue, 18 Jun 2024 11:15:26 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Jonathan Corbet
	<corbet@lwn.net>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, "Konstantin
 Ryabitsev" <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 1/2] Documentation: fix links to mailing list services
Message-ID: <6671cebe6d4fb_310129467@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
 <20240618-docs-patch-msgid-link-v1-1-30555f3f5ad4@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618-docs-patch-msgid-link-v1-1-30555f3f5ad4@linuxfoundation.org>
X-ClientProxiedBy: MW4PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:303:dc::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: e1565d75-88c0-416f-ec67-08dc8fc2a28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QdM1OgJ+sOr2kkIx4rAOP/VVWSEOXspzNWBBy69zjYQTnTiSNwPvqP6aXMJA?=
 =?us-ascii?Q?tGb5xu876HYDWpNSYOyenZsJhjO9Hm1Cwk+VR1DCEL88DHtJ/c5hJDx+RRsO?=
 =?us-ascii?Q?v+qc1+xHtHZBDrfawdHoluttF+SX/aaBV0AA7n74dIhwP15zJY1UVT26ZByC?=
 =?us-ascii?Q?o3apZZaBUv3STf08B5cDDZojWRssGroCkW/yp9Qp+usQVp24DEREgX4nS2vz?=
 =?us-ascii?Q?3o96e2fR09TjSW6FGwvHMQWxZBxM0LikKvIQHNjHox5H92yWv56VfVFWnGIJ?=
 =?us-ascii?Q?WQrWRIqpNlEEc3wEd91BDux/Czwfd/PrCD8OSdlp/TggfpSsXo0cFi8cULlK?=
 =?us-ascii?Q?sSjNpUKGC0cSR5RwDMA+y/XatSzrT+38lvK8KfJihx5npV2Rre95jK1jowKf?=
 =?us-ascii?Q?Y/cohxWeUidmSc0ssL8t8Y1D9a2y50klwctkDpR3wtxDex7LgGWhSAOahfZt?=
 =?us-ascii?Q?ZaLbNuAhJwHwVxwKqcKFfZHoCkD1doqH5V2eP3mCyhWvCwpIRDIo8DHKhKBM?=
 =?us-ascii?Q?E28E/qWNdPuUNuPdSwO4BiKSC2GFHvbVLmuKk9YGQjDDPEMYdMSevuFYxdFD?=
 =?us-ascii?Q?y+yOvWj5fV+Ou5jvXJ9dkkxZu3y0uh61SIXvxgZJdqAYHntgkxpC1mIP7ORw?=
 =?us-ascii?Q?3bSUoug+6f6hbj0RLeSTRJqHFWzy0FkgYOUu/nzLgtbDEkDStr8XxcfydxRT?=
 =?us-ascii?Q?tkW1mNEoiDVk7r5Q1pFVBoUghn85pXWDShTNi5tO2oiy9Qsegi9wSbZ3C/xu?=
 =?us-ascii?Q?itnz9itPLOpDYng0ZsLe+0H4xfGlhT2J1N3NFyhgQQGbYpSl25FoNGsXlEpp?=
 =?us-ascii?Q?8/5OIlCxkEvk0nbuiSaIClQE0jc5ic6SrqFSHfUKbfA5s6glD/5Jw+xmpzZ7?=
 =?us-ascii?Q?e1LVcddOGKVUC7W5crT1dFbCAHMMCvmccHOHsitvMWPN7Eh+qOc0a3fwPwuD?=
 =?us-ascii?Q?WP0zLsHttiJc60ADPJyqTKcyzMfE7yveTFMLAAWrlnQVicKe7nnf3Tqkm55G?=
 =?us-ascii?Q?SxeFUccA4uNvkps41IBOjAYN/sJglqqDy3s+Mx46xSkRu0H70MoTKwt0LcGb?=
 =?us-ascii?Q?gsEyCeItzK7K36SbKAdf74Jwol3uIsORbUl33/ZFq0G5QMUQggRvPDaQrFTE?=
 =?us-ascii?Q?i5S0CDmkAZmPNQvMNe0swqrQWuPJhW59eP2Jm6CpjfBCXxpVkIUgxuct/ZeY?=
 =?us-ascii?Q?BXrCQlPYxeXH0riZr+qJiNjz8apEjz6B8w6MwolgIKu6SQqJP+jffqNQEh3Y?=
 =?us-ascii?Q?1V65iEPeVuRJRx9snM4i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H6dr2wYA16Muyhe3ZnemIbhT+oTRmSgRqT4gDimnwJeRINOUWJ26tmzcU7VN?=
 =?us-ascii?Q?7aYsWLqZOXsdsVP5FhW98IWe9NyZZm5SzVjDP447kOOKXw53C72mORkYc7iK?=
 =?us-ascii?Q?6/JUf8u/T978Lsxk8DSB3qHaBCed7/NXqxz7zMdymasMlN7Rg99IPCR6cHZX?=
 =?us-ascii?Q?qS6m2y4OqZdi5YewI8dT7VL29Q2oqCEh8yofs3mXhGrJ/fOlQwH8pvsWjRlS?=
 =?us-ascii?Q?z78iYQB2k8G39KsciUYicMBPzMo8jeSOjsDKPYQqcxZxAaoiFMhXilVHjY5c?=
 =?us-ascii?Q?FrAnWTmgZ5jCYlUVIk+pRkjuESG/Gkv0K8xJ3pi/HKMpNNyWKMnU9iNpY7Fg?=
 =?us-ascii?Q?jirRR8l6BtfG5zMWhZLkh/FeL9IB+VCeK6VriZgZEIIYCssRMbywKeDdMqF5?=
 =?us-ascii?Q?GfRhhtfSETEc6Ek5CL5iVc1zj5mXYUN3Q9/S8sCFKA5K17ErzvCkNkmzBXyg?=
 =?us-ascii?Q?uDrl7U1nu/H01lyEGhDMnTNBt68MfH6G5RdvKynNx15XNmVaedyA7t6grxs3?=
 =?us-ascii?Q?WuarMVv0FQvRIfJm4hYn8DK4jZOjW4pf900eQqHztQptyvrkFKjYtCrLfryd?=
 =?us-ascii?Q?pJnrVTPQfAG+89l4i47s4bD25+ONTbz5SV4nV5ZQWz1UPGG0LknyqdJ/wFSZ?=
 =?us-ascii?Q?s+CocKyt5Y6uw4PjVJEdQxylQEA3aWq2mcxKT0mExQLcUWJ7CSoCIjztfZ1s?=
 =?us-ascii?Q?Zsjw5gEgNwGOSOJ7BRzlgsVHmIsdh0Wm13x89yZRhGEeFQgI+jPm1rCz1ub7?=
 =?us-ascii?Q?Z82Gyxq7GR4kY7hb1I5TsnvtKzHVJ8XEt4/m5/MHV/fobR6ksXZ5I/hFr80l?=
 =?us-ascii?Q?EnOEXfUkgAGENcyu4DuwXYo4RXa5xzEYjfF4bFUzLaObuUXS0cDJmdxCcZgF?=
 =?us-ascii?Q?dgF1t5+4M2N1C3n713EgCvCakBaFYgHx9/ZWWxfK0BJFVM3KI62JwkoIOgsC?=
 =?us-ascii?Q?oS3Iedwq/SRMT0tSiSadOsl1w1ePKACEe1WO360y+GL0cvzkYA3x+QwKFW5l?=
 =?us-ascii?Q?reoyi6aY7/hIPuFz+Yg8CrynVRVx5xMgG9KUWVmG6+ILnBw7CB2tCa05OQaY?=
 =?us-ascii?Q?3ctByySJs+riKVINzuypUgVLo+UkN6j3Hd2+xnMpz+jgmWjZ9V3o03yJGR6J?=
 =?us-ascii?Q?AYGG6HwIs7qH2jY51bBsPrhSuI9OW4WpgDKFkK9cl8O7MKOP/0gud36B7XuM?=
 =?us-ascii?Q?CisCYg0VVECKm0NtbwfjRIuUBg5Ugg5Fftx2Py0tQfIKpMfWky091i4UAInn?=
 =?us-ascii?Q?Omy0neQruNqae/f/6a+/CsjN1SRKQzMfn1UA1B0HgQ08zUB/EsUxweENVWxs?=
 =?us-ascii?Q?mm3yU0xmv6/bkWsiPbzZ9Ikbb4uGoxg2rBxa+COsOQKGRh8grnUOrliR2K4z?=
 =?us-ascii?Q?poaX5ZUXyBqtmk7rn3wliuNEWUlwWSHvIA1sW0Zafr4wifExtcfPA43/nto7?=
 =?us-ascii?Q?ce1H/Rz3qUmUzQ7pt13dOoQrzkYfwvhIx0Cz1Vo9iEG+dlSVQODUI2TEvJoQ?=
 =?us-ascii?Q?uAHBG3bt4aYrH/vEhMMryHSsXyb0qsucjx6Zz1nLuss3oD2gRBSJhZlAaKTl?=
 =?us-ascii?Q?l6kLUbkjqyQMcrYIGwORzJvV972vGYS4LAA6BfEd7D8ZKoczDsAzn3A8WeHa?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1565d75-88c0-416f-ec67-08dc8fc2a28c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 18:15:29.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yMOfVJWSNl5GQErdIzjJvTeDQJFdgE6ZY50dYV9T8RmeU2/xVrI2vA0b3HVdXVna6TBMzsgodR2EavzZI21yny8ZfwujVp/PKkro4JJNHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6502
X-OriginatorOrg: intel.com

Konstantin Ryabitsev wrote:
> There have been some changes to the way mailing lists are hosted at
> kernel.org, so fix the links that are pointing at the outdated
> resources.

The change to the documented policy about patch-bombs probably deserves
a mention here even though it has been effectively ignored for a while.

Otherwise,

Acked-by: Dan Williams <dan.j.williams@intel.com>

[..]
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index 5e1fcfad1c4c..fe8616397d63 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
[..]
> @@ -243,11 +243,9 @@ linux-kernel@vger.kernel.org should be used by default for all patches, but the
>  volume on that list has caused a number of developers to tune it out.  Please
>  do not spam unrelated lists and unrelated people, though.
>  
> -Many kernel-related lists are hosted on vger.kernel.org; you can find a
> -list of them at http://vger.kernel.org/vger-lists.html.  There are
> -kernel-related lists hosted elsewhere as well, though.
> -
> -Do not send more than 15 patches at once to the vger mailing lists!!!
> +Many kernel-related lists are hosted at kernel.org; you can find a list
> +of them at https://subspace.kernel.org.  There are kernel-related lists
> +hosted elsewhere as well, though.
>  
>  Linus Torvalds is the final arbiter of all changes accepted into the
>  Linux kernel.  His e-mail address is <torvalds@linux-foundation.org>.
> @@ -866,9 +864,6 @@ Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
>  
>    <http://www.kroah.com/log/linux/maintainer-06.html>
>  
> -NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
> -  <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
> -
>  Kernel Documentation/process/coding-style.rst
>  
>  Linus Torvalds's mail on the canonical patch format:
> 
> -- 
> 2.45.2
> 
> 




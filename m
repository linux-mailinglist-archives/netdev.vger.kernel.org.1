Return-Path: <netdev+bounces-191700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD26ABCD42
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D921B63864
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96CF2185AA;
	Tue, 20 May 2025 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7MARnjx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB21E492;
	Tue, 20 May 2025 02:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708532; cv=fail; b=nepj76Cv+D+IkKN9f5APAAw6c3hxFSKtkTzrUKyF1bjmVQPmjx97QOK389suRJMMuY3QVzTK2Y9Es+jM7n1oV740iRas56JhA0fprreTXlD5ONO4ZR6eWRKhFxWKQ+8sY+89cJIzq/Y85fDfcW5wgWfz9MKZ1YCkMqAVkoF5aXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708532; c=relaxed/simple;
	bh=Azito7CDxBtIlrO7BpAAmZ2po1IBN3CQb/MDpt0i5sk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q6xXd2xyNRYeZKIYJioyq8SywJaSMlgEPhYElgocb0HSqNEx9bijmsP+LiKiusELf2ZSrzZZ7e9HqDawMmjJ9AO8+VvZpCJnaRAzViG3uxHmFHCDluXZUdpBQ7jrPWUBTOBX6FVIevy7I60uBACJ2ECCWuU7BBAbgAv0GuFvr/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7MARnjx; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708531; x=1779244531;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Azito7CDxBtIlrO7BpAAmZ2po1IBN3CQb/MDpt0i5sk=;
  b=X7MARnjx722Mo1l+SJOL8JmiHq1D4H4LxtVfmYaJ60+BZnHp/rUHd+LH
   9O6xs9yDM7U4evKkrBCtkHhvNwvh9CM1cBRCYTnF190KWz1GCnV/RWyJr
   PZUsblPAD+K0rpHkdcOFb9DVArxoQ4SmwxgtO8MdCNOjSWVoZ+YuVU/Nx
   D5d2Z236oc3T+2e5Y6x/jlmBduw9dbem62EWjXtR34V37+FH/Gj1HA0h5
   7rZET5swkxjWq/SD+lqK8KfGfONDg/347CCSPAxb/ED6+HQh7OoCei2oQ
   rOjobwwE9jJm36AZtzBWvXhcHVA8rYFgR6CpDKmCzeBnJr2wlF6AmbGMD
   Q==;
X-CSE-ConnectionGUID: m1w89+06TS6ncM9HYiWQjg==
X-CSE-MsgGUID: CSn+IGrOQLe6sJLg0K7kFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49608687"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49608687"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:35:30 -0700
X-CSE-ConnectionGUID: BweamMfiRdqPzGVBfEmyQg==
X-CSE-MsgGUID: 6zMmuR1tRsiTAb3Q0D+euA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144668165"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:35:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:35:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:35:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:35:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xu53Cj2q0cq3I2joOjyD1rINuYSZg7cUenxcH4SnjjEB2vq5/NDF8K1GaEGBrpxzEiJJlmQRbaoTHHXRFTIuXbLmHGxwvkwjfF5ZZ+blfe8K3ygx4roee3Ziy7u136iyaXOE8PEyK+5bOJhFwgC8Q0w//pP3LJ8jOQaQRdjoPeHAG9iM9FbPdGJI5O6eAnIaeWLTPZrtkkcBJHDyEx1MTxwjzKaJbye0Kyv4wvz3zFxAQ6pu+ib7gg1c1BbAjeLPn7f879p/4tRXTu7MkPdQm/A07jSwa1LcFKqasCFAk4DyTUrnaGRNLVKR8kB1LuYhWoVda6XjN33aGx4pzTZ25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar4pWkot+PFeWNFXwy9KR+JOaBq79qH5R33NsuVmlac=;
 b=paE7lLhrS7VyWN/xJJ8E7gPLe1Ym7qvPrghiJ1ZfSXoCSE16j4BN6EEDD/A0pPtIsVe0HATsTTRvTN1gVcRDLps0FC2UddNRwebdzanzG1Camgzs751uwYM8GV9eTC9laF888TXW16IlTxTBONGiocopCSKIo01TxuRxuDyBMfdd84+1tpPyeQ5m1/x91l3pLcXrT+d98mnLjsa5RAXLraD3bsMUcEJGCQfCoO3aYiGDbQdWsN3v192P+lp+t19Egt0gLAsLDBUuW7rfCQTOQR8Cj0cjXYxCxqULdZEIHfb0pmneao90HITC0xICA6ZfWj32cqN2a58JN0RzwDnDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Tue, 20 May 2025 02:35:24 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:35:24 +0000
Date: Mon, 19 May 2025 19:35:20 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Zhi Wang
	<zhiw@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 21/22] cxl: Add function for obtaining region range
Message-ID: <aCvqaODg8iK64eeV@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-22-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-22-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: ef36f79b-c653-443f-a44b-08dd9746f95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LRdIPm9cTW906acQ5dPIdKwortgE2unXlqVjA1/V3K10snkVyL1m1nwvy+LG?=
 =?us-ascii?Q?zrZahk02h1jfAwiR5bwDZI7Oa9BxWzK1i/8GRZNMQ4qChQo8n0xJslTwwix5?=
 =?us-ascii?Q?CIxbQF3B4jHMu/GKfPK6GeoA/pCPfeI5eHkmVb0VG98UsMdu7U6k5EE0/TJj?=
 =?us-ascii?Q?hKktzXcHeENLq63Unyn77fXUh/dpUo1zjCPNCr9omkIt4eEN9gGCDKFeCC11?=
 =?us-ascii?Q?Wq4J1eLJtgrAox5axNnK+u7seb7y3K09xnAI/w6vl7b5RMMXRzpdh3qlvHlg?=
 =?us-ascii?Q?nv3XspaDMGQP/DkBpwjKwC4URjlr2O43Wp0ofQ8HMOZa4DbiUYhBVSvQDh3W?=
 =?us-ascii?Q?XMoV8cOCJPkqOTuUADX9gzqqF2geVy3NDiyaKVRh6X/QC45xnw3BMxp+3gal?=
 =?us-ascii?Q?qnk3w3tk1uzpjBV6DD7zqTFVYU51pHRxBpvxiDAbkGtqHgljb40G9/kFQkTM?=
 =?us-ascii?Q?Ny6EKohL9HxiQ3KpeAhl9HP9Bb2uBdGgufVxXkAc/6ZssS33IrC+rlwKthCt?=
 =?us-ascii?Q?/VK6IhuQ9GSpldcUys4AF8d+2iEj14x9rSbt1m83cjPOU1xL68Mk/Ey1u1Y1?=
 =?us-ascii?Q?4kU2WybJoqmfAgWowCr34JrerGNv61MK6PfGLBEX6bttcRDPxbg7Su0VbPys?=
 =?us-ascii?Q?gpA73PkMJZnPy8TpqIwbeLgvynNPqhlAmcHwluQb+pvL7vZlBopd3e7tNXR2?=
 =?us-ascii?Q?qTaIjx6nLcT31JR/mRBGUDhuXexZOk1nC+tgevrKxuPt1SGWhp/tBegJMWkb?=
 =?us-ascii?Q?oncEQqdE7VFqtProbrRvccJtv9Uc0alnEfSbSNmqogx2tOmwxikAeBttDKEA?=
 =?us-ascii?Q?cC8nL0wG1FtXHAXXdQJYxE5DYonSTF9pmLIN3PxqUDwKpk7hrrBqJQx1s7Yt?=
 =?us-ascii?Q?WVGvqYz58j5H0Y28p1YAtqr6OIN8wPOmff3McWKjPs6CXX5wI/fNrrvkOWli?=
 =?us-ascii?Q?SLNKLgmJ+LnwS+Rv9iVyPWsv2rAMg+H+SirF0BpuZL9IUHazf9G66DyFEC1c?=
 =?us-ascii?Q?2TkNwhK8oAsFN2fPFMbiW6bAHNuXz4o+rRXu5pwTS6HLhrazVpnOSKVdyNPF?=
 =?us-ascii?Q?RvosYTU3Kv5vQLxP7qW6E7qjzWZNg8EkVpXi98p+eyGhlUuUbBsT5/gk2JC/?=
 =?us-ascii?Q?9DMgu5jCuSMHpFRxv8K9bjKZNB3x81P4ceq7DJApvnEu1+Aor/eq5/ddL04n?=
 =?us-ascii?Q?n0syqJDuzfssKOWbWEw3xg7JxL27sCtIL7jjVZrug/hBbwd6SuDKHWkYAfj6?=
 =?us-ascii?Q?MrloUND96fCUKUpsRND/7rIn3xAQ9LXaXlaFytzo49SLb+lBq8TKW8pFdne3?=
 =?us-ascii?Q?cjDwb5XJ57w9Bzronagsblf4o+5/et+hZJEh9uo4xTajkTx+iTwFHtV9RvXE?=
 =?us-ascii?Q?JDjehBS5PPgt3mi384A1Zr3AqktkgobsUCYDYKaSaEI26x3suQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U3vAWnX+HWcx1HkUKmYRe5/N3ZX0wL2P8BBtqvkybgkq/Wi38zhf2R9o/0iz?=
 =?us-ascii?Q?bdseBi5h8gxPhJxFRTCYQMYg96zvD/H3Ify00RcDWMbP/El0Dosazj0kY7Oi?=
 =?us-ascii?Q?doZ852Qh9StQ5x0oKTg9pxTzGMr0/jmwO0GM2mfnYxTBK7tkZOz9Co9/PGdn?=
 =?us-ascii?Q?1lXphAIAinIO4JFRH6WNuyssXwVK1RIfd1pMjJsCvlqi9sNRWtjG8YELRLrS?=
 =?us-ascii?Q?d20GRiKk9UcuGZOqGKa0wF2nSt8D3qRjmAh57cxnZ0At+qybYJVOlAwBV7mr?=
 =?us-ascii?Q?8YGsWg44Fij03DApkpF0hocrhD9bSDXkab3vysli5g5taIeMloNq4No10TBV?=
 =?us-ascii?Q?jisYWkjfG0FaoqVHTv+FWGVOi3gV8uu0Km2IGULLZIovxM5JeqIgBOaXnVsP?=
 =?us-ascii?Q?9Ls69RuFzb4dG4Mwzp4w1HLeIAyMGEZV3jxgrqr3kE3VTHfA4gGMo03dNMZD?=
 =?us-ascii?Q?ndE4AsnNdyCiSXmn3G9RxEHBn0VlWjNJRGJMSQEFzls0Je63wtEEIwOJm+xa?=
 =?us-ascii?Q?spVjs5HaQe5B4aWdthe4QypCu3lQAOkA+LET+Zc/GSzF1dN8H7O0k4jI8kLy?=
 =?us-ascii?Q?KvK45WNCgeam6H8tZ0aEMpgxEStK07qxBakstxAT4YqqsUChlOA9bsCh0W8B?=
 =?us-ascii?Q?J2bkCWmk7a7jvnA6iAQ1w5Pdz30OoPjmqaIa2Qyh31fckxnFwHoxiwYAPwYl?=
 =?us-ascii?Q?Tm4iqFmBLjiDETB1C2vQIiKb3g2KGNBOr//ySpbvfwIglk20MKmNmmt66Ooj?=
 =?us-ascii?Q?H4WmauTHtYQDBNXxu4Fms6JHizXBOreyJ6h98X2Hq7rzpt58P1pV1fF1vcpI?=
 =?us-ascii?Q?ROKXiltIuazflAeRTch1TPx+vIazsfDNy7WjJ7qig0Ep9j3E4mZg81B8O8sl?=
 =?us-ascii?Q?JGRYsyVsgeRivgzqSTCsrstPZ2VKzt12B+gTy8/FneaSyVVxTDaBwBA8X1TH?=
 =?us-ascii?Q?uCRD/K8Z/BPx72h9CjP3tj6aoGGe20v0rXvcQyipzZ0rV5mXoUB2eQWJvjQV?=
 =?us-ascii?Q?w3hrR2iU7XTKylo36tjKHnR9kl6WxfvypgcZGpDbjOd9oYQaagTcHb3nAo0h?=
 =?us-ascii?Q?PyEEcHgkFt+zoZs9QesMTMW38eDP/ZEdjKC4lquoQCOSfsVk6+ANLd9SqNep?=
 =?us-ascii?Q?4bel2ZldTKyZ1PrknxNX8ZOmsD9QUAWlvlDi08+efn1ux4a5ERmKtW1peX3o?=
 =?us-ascii?Q?qloFEG1Ww9mNdDVYV82kedE3PyWhXETaScT0sCeQdn6cdHAI9dkTqyc4FBoz?=
 =?us-ascii?Q?nUCP6C/7vTVYF96mdpI42UM381QmIfLFKhTC/2kMlWwVgMHcO1JpPmGBKnjX?=
 =?us-ascii?Q?gFnN72B3dtMOl8Br6eBoSfNs3AShUoLO6d4IN4/shZ+6vOIDWAlAjabstvYX?=
 =?us-ascii?Q?+q2oRwFgkFLrLryAUhAqFsp7DxuC8R7gGucSuf1L56M4z59/Ilupy3+Vxj7i?=
 =?us-ascii?Q?T2rp5WR9KIzomlc8iSNxzloTx4Mp9odScmlMtNk3r2Yc4ZyrA9zULgZZUPdl?=
 =?us-ascii?Q?4roiBOheiDTrhnPwurNLIslSjwKFFyZfbJwKj3Piq8pqBC3rodsd0pM8Tagb?=
 =?us-ascii?Q?Sx0tNfTE0Ns3NRQUTcWArFP3IQNaTqT9yWuO9pf4kMPUvOZwfshnN3ILdAnH?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef36f79b-c653-443f-a44b-08dd9746f95a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:35:24.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L54ZRMQpBr0Vb2FOw6z4ncS/JzI4AHGB14mYfjFZgJNtScTCUWH5DM4MWoTX1p2sIy7saIviixP4aQKXFVaJkNjpULNSBCYRQxzcvjcvzuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:42PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Type2 drivers can create a CXL region but have not access to the
> related struct as it is defined as private by the kernel CXL core.
> Add a function for getting the cxl region range to be used for mapping
> such memory range by a Type2 driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip


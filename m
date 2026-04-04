Return-Path: <netdev+bounces-275348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF6DI83h0GmIBgcAu9opvQ
	(envelope-from <netdev+bounces-275348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:02:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1133839AB16
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C14053010B82
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3292DC789;
	Sat,  4 Apr 2026 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qh/gPBt1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD20275AF5;
	Sat,  4 Apr 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296969; cv=fail; b=N4GRQpG4B1fsWS7EWxp//P1ucEQvJW0SNSs/c4K/msr7/5ecc0WXShuAbzW47QzqCQvN3EGu28IxmBwLqREKaN3ZVmZ/FS7P5Kk43TAWaWLs1BRt3Ar8mzjMdqHlBxAVTGIALhEMvc5OuFfBn7BSEjBaJipQBhGYyK6kV15+49k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296969; c=relaxed/simple;
	bh=R5QeYZ28fJq8IOIpn6SGZLzM9UX8wffVUKiGggpH6es=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aZiPdTCBt4q3BQipRbV13GvUGVPWF5U9fc9BZ09uRFtcCxIP7vUHALBWTyvBI3cyPjHs5AyhFkRmVnrAr6ju/TL7ipvs1GvXwBe3PUe/bsJMbcB/wg0iSTr4V/30oaoEBlzcr5gsHboCoHSVWWnApesrmOlcsqKZL8jI5X3wrK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qh/gPBt1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775296968; x=1806832968;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R5QeYZ28fJq8IOIpn6SGZLzM9UX8wffVUKiGggpH6es=;
  b=Qh/gPBt1ErZFErb6zl68uS3jsYmznjXJxtRdYNf2laHLqL/sOuIUkfYR
   Z/NYlWaJ6CuHIOXWnV6eIc+IPXBrxCKUseqUDVCJP4khzFQJPB8bovklQ
   sxCqwmiwcTBarN4oSV2N5435yBeYP9Br/rCc9GipaH3L2Y39G1xP/zMiR
   /JEtnUY9T2ATO0cIn/EiKILY0YbyQpCcQExlfyCHnTvc2IPGPbCAVJANT
   pvFH0GWzunAXkUBJhBCy8gh4CSKrX1gW583t8deIoM2xXjoa9GlubgnbZ
   4E+XfJsojrTyG+yP/KlcttHWymCLsCTNurtL3Gruol0QBOSz3l5Tv7YzP
   w==;
X-CSE-ConnectionGUID: NTACmnpMR5CkblR4LKUwaQ==
X-CSE-MsgGUID: 7WXd/ytcTou+7EgjRLCwTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="79937583"
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="79937583"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2026 03:02:48 -0700
X-CSE-ConnectionGUID: xwU0lQE7R+ynjiyrmm+mvw==
X-CSE-MsgGUID: xr2KqrGgSTKbEXw0+rlaKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="224636454"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2026 03:02:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 4 Apr 2026 03:02:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 4 Apr 2026 03:02:45 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 4 Apr 2026 03:02:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFpFW1uBNUoXlVqWY3mrHVMV2URia3gIop6xjENDYeuFHkxeuyK4Yc+6ba+fLyymU+4FZ7pB7VUO+Kgg6f8U4QrX8x56vjBeJrRsW+MqxBgiey4IhUG1Q0pNji2cec1BW8xw7BkGbPCio7HOJuEytHZWW9V9SFZF6ODSuZh0aRLhSY7fN6rarJGeSnuE8d0e08sNgu+wR4Hu12718FS0yIxJs+IG+8w9X+T2WT640f3JikrwXlT+hy6KdfNDptxHdBpoCZE7BJt+wls2bKQOw4Gx+WYOWMjZkJw+YvHo1V3HeSNA6UC9L8ikXORjRcbnShW+miGgDbRSpb8EAYDhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97YW0l+rI+OUr4YWATyGBTMBFLob5jclY8HMnSUwgu4=;
 b=SxlpzKZEaZQ6TTotCy2eiElxJiLU+RE0YnRim+TLV4mnM57rFww/dXD1qT3FqMGOYIBHYO1fuZdO95ZVRQZ0AtUiEhHB8uyQp9zZ3YkLY1svQisJt8kZhHwGrqqjgOxGvlx22O+eQ/W1jtH/0bu3WHrb7H1+cCJzVUWzFuGhMh/D0uE57E9va2nooxjqlblodKzH01LvehJE+iSsvYNWG/x1pawZF5a3vFvMNwS4IgbG7IdqDs5+vTy/Wz9xyr1yfQaWO5HDTXcj03owNkhbyAcrRmLaY4Zr+EmU5tzf3o2fZob49vf0InVTl8wdgAQZKT+BRHP4XPg54hjPPcM/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS4PPF900531A26.namprd11.prod.outlook.com (2603:10b6:f:fc02::3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Sat, 4 Apr
 2026 10:02:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9769.017; Sat, 4 Apr 2026
 10:02:35 +0000
Date: Sat, 4 Apr 2026 12:02:28 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <larysa.zaremba@intel.com>,
	<aleksander.lobakin@intel.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v6 net 4/8] xsk: validate MTU against usable frame size
 on bind
Message-ID: <adDhtBR9aairuaJr@boxer>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
 <20260402154958.562179-5-maciej.fijalkowski@intel.com>
 <20260403170357.14cb166a@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260403170357.14cb166a@kernel.org>
X-ClientProxiedBy: VI1PR0902CA0028.eurprd09.prod.outlook.com
 (2603:10a6:802:1::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS4PPF900531A26:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b6acb8-2697-41c6-8882-08de92314b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: WSwDxEOWOiVYrt9GAvMvLk3KylgQk5Y717QixF5rTFAnmS/sx/E8FLVp5SGL74XcLvdvvv5a9BG2mnJDKbC4Yp6n0a2CasY7DPBnEwE//gbikn1P6nASynN90K9yLvBe/qAX8N9DimFQW1+3pb8JXi1UC23DyGcQ4B8ZdwzUs0JYgsn8rc1HRzaGdDzDaz9oLLZnGuVg1AuBY+swuAzxVhvlXHoXM+MVrY+PwjBNId7nhSYmvGdWhgg4qqTQJ1+7vQOoQyNPhLhsQsQMlDMPQdq2pSHuAftjjpL4+K5DecOj4tcUYxwxj+aLqA16totkvwqiJg9uOKrh6gLsJeYQ0NzY/JY3b2ep9qH6JU1mOpN9Ut2EJK0K01/ZtRwEVynSRPnGyN3sp0xN6yqazxoryUdQpRpDpBOU/MlZZvgsOWrBpGFIxPTcfxAnhW9jjvO+ISx9KehjlRKVorfbTaUT0+SpI9xXlTkc2SEIUY2SjuaqI+nPzleEZ4msF3ZTwUkSelzFiHGN3/hZPkA++5kPMMKqqNVSLVSdfb9D7jjxd/2xDB08RyenS9U3m2ZCUxSS1K3TTyOt51ojJPN0nnFcXwYIkP2gbzzq+62fRN57pySiFcGQfADCPwNFE6fbCVKwLHOku0MGNNIeJymlxDoQgNZR2I/Wom3aoLSkhP4/ICKGEqilaHfdBspGGwYkSn2LArH0IZSYpTegQoNzFM/j2EgA/pUkT0EShUSxGwrASEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EAawWjl4jNd65/VsxOpwD3s7qsh7U2xPIpGYObQRd/rbp7QSuWu+tBFbNs+x?=
 =?us-ascii?Q?c9dMpxdM/pau5+9i2icszvmCOonszhPJMnt+YePeeVTT/0JCZgD+hhvtVfKZ?=
 =?us-ascii?Q?29WCk4HH3kr/VnsEhB7PXWcPV/c6EtpYDHuIDFVH6yL2YJwVsH8976EG/LMc?=
 =?us-ascii?Q?cjMpXUJ1qT237KmZDQGFsMN7FoeQF40CJtSVxTzD36olQdbksysJLp6RmuVk?=
 =?us-ascii?Q?0MTxtO2o0yBwNMvERTANcEik8TRnsLWXbOK6Kfq5tlbtGJCPl7qqrdy/88iz?=
 =?us-ascii?Q?fYONS3ncULkGVCkFI8ZU9XpwrAGOKJdfCOWn4xNzDMgw6x6pbSoI9SnumiF7?=
 =?us-ascii?Q?mA1gxVWPF21DV1wTOP7/U6R9WI+KCob4k9fUhQdxtfCCGn8qevCxq0B1C4E7?=
 =?us-ascii?Q?3VOrsShvyAEBaOUo6oOT4Dt6Fw1qwOLyNRTw/BrXFcd1NvhTNqnXDDoRwriu?=
 =?us-ascii?Q?pkpX0VTKjmkBJ65T8TYdsEBxqew7HJVcnAXOtMKGenRhz4bcNFYp1CnuVT2l?=
 =?us-ascii?Q?Pv9Pk4k/ysMjiY+jzY0A6tE/xULZLZZGPyY0kgxRsPEFroMsVA/RXzXYEdYp?=
 =?us-ascii?Q?dZsooMHlbUjNwVT5z1zPD9dFQmBVuoJUUQie16G4gNU9VX4PSvd9kgsnYi1D?=
 =?us-ascii?Q?GRbC54c3s7CIKrS8Dk0Ur8BLb5Agme8mtfDSRfdPkPQcCvLl1qn/2ILq/EnT?=
 =?us-ascii?Q?YoSiSsgJMY2pgC6W0KiUtuNaL/x1MDPfNQwcjqwjUihqg5dbJbuxKstIrd9U?=
 =?us-ascii?Q?1dRyGO1azEPwTFDGgaCG/sA9zTK8ZowMUmRrD1eSUe/mfGFDtRmNvAE9OjlA?=
 =?us-ascii?Q?rA7Je9QJzRMc3InUb4YDddn1YHPDr6k4Fui9oDKrEG00sRhZWW9K/aDDgamK?=
 =?us-ascii?Q?Q2TP2pgATxdn8bb5yjjdhF0vobWaQFAw7Tnyob/XkAb8ivigkxlDwCEmNQVq?=
 =?us-ascii?Q?ONiNqYjuuYG/xpUnDZPcWUbxVwbRzwH9Da8dGWhC5rc3e/vgcw5nNvRWu7vV?=
 =?us-ascii?Q?6Ce1kmDWiFWH5L5EXiiimmJVwUd5Zn1lPr0TILrrt6FnXG98aYY3VCMPA+7O?=
 =?us-ascii?Q?4gPGI+kxfF0HSrlageh/WC95LdopQA/j0GjYaxKNO6JXwX7aGdeCc4vI+gEY?=
 =?us-ascii?Q?U5dQbjzaxOwaSZwG+uushIkHFKtIDuP7g2U7iEb+D4obDHB6+A3a+4Ru06XZ?=
 =?us-ascii?Q?hWlBiqQm+oKGQFVM6PUn2S8Dg+55T55KRb/lLxHnAlyw3Y5CPkpe2dULmlAw?=
 =?us-ascii?Q?vVcpEdVGSlE5VHquyrWuaeOir5Eyf1lFdWqEpGE0rijA4r8cHSCG5FlRi+J+?=
 =?us-ascii?Q?wSszxId0+fXh+ZUwDMJID1kp4h4NGsZU3f7LZZ13RGOMZ66riw/bVLMn9PLT?=
 =?us-ascii?Q?3gLmeb0ryyPdzV9LFYmZMAf0D7VKGMQEcJEP5QDH6zsvZa8IBlJwYdZfDA7h?=
 =?us-ascii?Q?9h2U1Cz63psnFjPRih4nGScgPnRGaCkg2NeSCssVDXm0zpNcwRvrZjGAFIjk?=
 =?us-ascii?Q?vCTgD2UNugeRKkmEkLC3aQP0FnVMCXgvNxO6CTLk32vaYp3TkeAy/goOrfgH?=
 =?us-ascii?Q?MDPe2O1Cy/Gl1NE/5ddn8b5e0RzWz/XsvdGvDbreDbBVzaboyDqPEkU4AShq?=
 =?us-ascii?Q?tN9ZV7h9VPdQWodnZ3I71GeXafvdzsC41wN7YXLjmGWbD25QE+nzjnZelrPr?=
 =?us-ascii?Q?IBzsj4Rf6HuVRoWad3JHF3v/VdMInz2Yb4yP79bGQ4kEmUX85FVzcibBbyd3?=
 =?us-ascii?Q?oK34Zn4LNfa47I1MTuOq0OJnS6DsUhk=3D?=
X-Exchange-RoutingPolicyChecked: FIIpAHqLMbDXsSrFdyT8DoHGVLvREx2tt+93nRkrWnnxKisTwdXs1uTDBvrySIlJ8pNnd4QFMkp6xEGGHh8iPT0QNSKrEW1vwCKIJoLETxiE0+rQQqlGrcbig++77qssVrXh7rGVb7PAWqZkMkpYFMTbk190Q7oHtkyQwVFGUDwqbDpG6lVlAp34Fn+NtRdE5ICCbiXdk0HjlWC3cJeLWmYpqKMvIJ6yEiToPQ+ks9zPxMi3lgUcxLkxIEkRQSU+Nk3QhKXGVm4a3zvZGa3pJ4vOeswt5bxFwDFkpjrJaIHa5Pkx3M2Uuio0SjAGsXX8jyPvvqp4dA9jeKVfgDqHiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b6acb8-2697-41c6-8882-08de92314b8a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 10:02:35.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sdtyTyh27VZ9iiIxx69EpEeoORVj/r+B9yhvFYM1ZhNPAdZ/qoFpZhcpBFJqb79KcxlWJrN9YorlZ63n7XIWjeOK0owiRuj8cmASM6amME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF900531A26
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-275348-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1133839AB16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 05:03:57PM -0700, Jakub Kicinski wrote:
> On Thu,  2 Apr 2026 17:49:54 +0200 Maciej Fijalkowski wrote:
> > AF_XDP bind currently accepts zero-copy pool configurations without
> > verifying that the device MTU fits into the usable frame space provided
> > by the UMEM chunk.
> > 
> > This becomes a problem since we started to respect tailroom which is
> > subtracted from chunk_size (among with headroom). 2k chunk size might
> > not provide enough space for standard 1500 MTU, so let us catch such
> > settings at bind time. Furthermore, validate whether underlying HW will
> > be able to satisfy configured MTU wrt XSK's frame size multiplied by
> > supported Rx buffer chain length (that is exposed via
> > net_device::xdp_zc_max_segs).
> 
> For multi-buf - I suppose it's fine, but wouldn't this be potentially
> a regression for setups which use single buf? Suddenly we expect the
> user to provide space for shinfo which was not part of the initial
> AF_XDP design?

For single buf xsk_pool_get_tailroom() gives you 0 so it is not taken into
account when we do comparison of mtu vs xsk frame size (in this case frame
size is defined as chunk size minus headrooms (xdp and user provided
one)).


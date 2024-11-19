Return-Path: <netdev+bounces-146222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0929D9D2515
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E251F248B7
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A0B1C9DE5;
	Tue, 19 Nov 2024 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZ/eAV49"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314D1C4A24;
	Tue, 19 Nov 2024 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016584; cv=fail; b=pGFfzwsaJcT5n8A/wBdZja6Rl9RZWqjXzbWjzo/tk0N67CobeQV8FM6FkREDnWd7WAWp0YUMHzmQOsx/WyyGVLVao8H72p12G5ETUeMiaVAv7qv3qRXPEf2Gl6E8k/MyRI22eNvBpx1Be4uFu47UvwfL6wjwbM0KTU69PSHQJvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016584; c=relaxed/simple;
	bh=EYDb2eSEZcAcsSNaECkhDKfp82kWgcALT1nTovLrc0U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cbsZr1QAdhQmuAkDY42gVy8yqOo6u4JdsPwErPiWkdNrbVAgxz9wt9AofYiBUtGWdtyKreXEPBbTsp6Jn9Y7h5oyrLJHq4iP7ZYQkmS7nVX/TzWE982QRFt5XUJ0g+2H1e+/UMCtn3BP3zYMm6ou0ftaIX6/xnu/A+/TtyOhXho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZ/eAV49; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732016582; x=1763552582;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EYDb2eSEZcAcsSNaECkhDKfp82kWgcALT1nTovLrc0U=;
  b=VZ/eAV49v6Zvoie62jZJ21wxRyWUBHE+y3qtpguMazV/cwAU4RG9rl6k
   kmPNQdd4OEMeBeb/zcNLM1/bse/rGsG5tkAkUyYLuPr8blllF+c0qLBHN
   w1tfJzerZjX3RWObWexODGr6PiK/FpjpyMSwiGHH9m/HnplayVYQR5rpJ
   KoWPrmvjJIeIO4DrJMrc7FmjDK1fgi5RtY6Z4f3RWyTHTfBR6XDT7TqXi
   FZWZ9sXupKRxXGYfo6wy+y8tUWBgPrYrW/perCzFH1HqnCJ1IwwkIDHYQ
   /MCYQHKE/PqAax+SHe+tzfc27+LmMOqvQASPKKnRIKp5ephLf5VR1+45A
   A==;
X-CSE-ConnectionGUID: WJtILNrTTeedcWhKvSGBug==
X-CSE-MsgGUID: fvacqZKgSLWLeyB2D8MhQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31934656"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="31934656"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 03:43:02 -0800
X-CSE-ConnectionGUID: Xik8Z08DRyClyVDXt+zyfQ==
X-CSE-MsgGUID: AlzwrLdNSgyxVbHBU4QWnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="90334601"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 03:43:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 03:43:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 03:43:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 03:43:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X//860UxqMXxkr1VTY2dYSZzmrRySoqxHjpnRMvpESZCIwqetld933Ml47LTby3idReWCmXLGrI7I4kxYfpXwnUo0p0z1NFc7ZO/x485YV7fTWNXxHt4tRlMLvWdPY5wIZa8rVwCDIxZb+bSR3iBHAfHcl5GwwfHj7bw04hRvNkZ3yQ+iorT/1hVPzgC4z/u8QzCq8DC3Hs8L4aDiR1r9yxhHrUUKSMjiQSGhcV9F8of5tVyZ8C2Ke3k4sxgbkCOAI7VPb6f+1cFSR/lcPF6zxcwJZzfurkfdHmzwgw0yEPH05u2KjiMTyaiGDPeVkCEvVHyMuCmwlZgkph8JD1FfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS2BvynWU+01t59ByMz5Lh/LG//M53ipkU9G/fJntl8=;
 b=s3eL/E3wGlFfg3JNTEMK8vjUNuT8gfm2v9nnTxACFTFiqmwGe3XDg+pQfk46jTdSB66ELPoqrEQ/SmS6C900HjO0Oyx2EA5uw+YEH599U1q/9jQq3+pdkip2I6xisJkojRsDKVEljsl9SDPps8tzLMZIClybosBpKxthGFWmZpPUm7VomJ6nF4BYjMkvPfYxqe9tKAakn2OElJB6G/Q/al3O9PhBQUZM8IPjPzZ5G8m8C62Kk+p7CDxeoNiQ+VBix9RcU3oFIPWpliufdqETc7pI2ztPzfcCmopCtc4LvQcZ0HARb0rgvMz+Ti1jndhV8DbBenUsXiuShpPsLHOO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 11:42:59 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%7]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 11:42:59 +0000
Date: Tue, 19 Nov 2024 12:42:47 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Justin Lai <justinlai0215@realtek.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, Ping-Ke Shih
	<pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net v3 2/4] rtase: Correct the speed for RTL907XD-V1
Message-ID: <Zzx5t24M0DG0yUrt@localhost.localdomain>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
 <20241118040828.454861-3-justinlai0215@realtek.com>
 <ZzsugTPBgp9a70/F@localhost.localdomain>
 <5011ae11bd9b48c5bf8e1bf400aa5d13@realtek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5011ae11bd9b48c5bf8e1bf400aa5d13@realtek.com>
X-ClientProxiedBy: DBBPR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::34) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SN7PR11MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd751eb-b5e6-4218-ff5a-08dd088f50f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NY5cCglH9OL5ALJeJjGV4bBpnxDZQVLHPBNm7MUzVJfpkGbVFnBN67YlxwPX?=
 =?us-ascii?Q?I9DKLh+lhNlXf/K5Y7+Hhx0rm2hRTD/RBOGLrxTe8+4uttsTop64tauhByup?=
 =?us-ascii?Q?vh0fcNHW++BpEAwP6AIk7NTmpYCFm7AuBfLCtKNI2guPVnAMLxK2SisBC8vq?=
 =?us-ascii?Q?3sMQcwwRKiiTh0MaDxGYlRdogczyg1cYHz1cc6Rsx1n8IBao8S4ww+Qrzlkx?=
 =?us-ascii?Q?F4pVKHJkXOhyacdTajSQvEFrg+ORGu8M7hzH/0Xusfw90Yqz7D2MJQ3dPtGD?=
 =?us-ascii?Q?ljqwR7I7Ata7mvwdya05PuMi4XgnIV/ywS4uQEEKKXZx73ylRS9lK95nGF/G?=
 =?us-ascii?Q?Ls5suQ+s/a0us3XskZfDucm9sKZGioOITFL3uC0kHysujHve5XDKh7BIk/F0?=
 =?us-ascii?Q?qeSRUHr5MX1QZGzwMAGlpS9SgP+D7x6CG3N0L90PuDxYQTnGfKSzUoKO7LgX?=
 =?us-ascii?Q?BN/Uay4BFlxc6H22wUmK+DupzTEuaFwNkRnCfaUW/3nWPbyu+P4JD22WJdxa?=
 =?us-ascii?Q?FZQJBLCA7LXd5hRC8f1qn/e7CGOnwuElCUiBD/ZZFiz8RDUH92M/DOK/3g+Z?=
 =?us-ascii?Q?cK7tScyicIipUh6/raNTbxX4xfLMjdRv6UMLDNhOYtOFYkiZhd5Cr8PWg4++?=
 =?us-ascii?Q?mNssFXrsO7K+d3alKQkhq4TC9SUTFDBV3tN9HhHyMcIzbx/gcO5CSO0aIF6m?=
 =?us-ascii?Q?+cDekuwInVNrnntjQDg5SqWi+jtVzy8CJjy9h+XCxOBqSYlTPOijyC+w5nhP?=
 =?us-ascii?Q?9SLeRtyJhVEPncpp8Nlk5esIrxneoU+sq7FbVWfSyeREPVrIicq/IvoLQt2A?=
 =?us-ascii?Q?u4YPDCKLkqc8TYCuHnVqQRmz8i+FGS/xYTyDKnKSDdPct7gEH9lFBwnCTbpV?=
 =?us-ascii?Q?k+NKu4WtjpqrfecSKtfRvwmg2D/qIAg7To/66hzm7q8vBrs9KKyQR7CKIc6r?=
 =?us-ascii?Q?zEoDhW17wARkMxFXfjP5gzlW2qlSNWP4khK9iBUoDeOW+I+hu4+H8LOYjV4M?=
 =?us-ascii?Q?EiAJiU2MqehvzYn/qJ3vXABRuxCiRBk1oed+YSaHqtZuh9YlvwjWYLvF9YN4?=
 =?us-ascii?Q?eTfeUBYREYuiwyd7qssm8d5HywED9f3HwIuYt+jeTq1ChScd8tPRpe71Vln0?=
 =?us-ascii?Q?whEN1go9p9pUJIrS423yBImYNqgglTADWe2kZ7qIqLDOqeoMyTCS9ZdYifg6?=
 =?us-ascii?Q?cDTZ8wL1+6WNBtn5t8wXalJuTOlvjXfJVGVzGB0AuuEPVV5sD50buLfF0IRz?=
 =?us-ascii?Q?bIxIcJHNcGG3Y4qhENbBgnyPp/pinuzj6IPtbvT2HL1cm2kyvorf/1HH49fp?=
 =?us-ascii?Q?lxEvUQgztc2amkhUpGsC8nqS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C5Bu+rOavT+2ornymPnQlNcB4ni1lqA42MflaraXU3mYMI8sNt2/wfWQ0D5G?=
 =?us-ascii?Q?43NLozhhovYNKj4X/jgQx4J4nrgm6Tdl6iKaxKDp7U0QSPxurO6Ls2c5xiSg?=
 =?us-ascii?Q?JQtkMk1GXFA02dVARgXlXs6IYBt9A91vAhtWsSkU+7najBsI/8RRqWBtAz4q?=
 =?us-ascii?Q?p36cyvKiKWjvzqqSOvbGqqLe9VcrqL3b9vEM5S6nuZcuhY9iV21FRNx0VDLp?=
 =?us-ascii?Q?u3kGWB0/MZspxEbj7iwJxsfk7EpgTC8KU3UCre0O/Tg4EdK3WDaS1Gh4MIog?=
 =?us-ascii?Q?ibq8bf6Y+NzhAmIscxm2SjKVqfD0jVE7QhFOkrx4StDpxCNSYMrIpJWQES9J?=
 =?us-ascii?Q?shmaSwYFw62yFxPq1r3UZYjq6BJ42YFklAHqtoobnkutO1/sbjIQOIaVDVOb?=
 =?us-ascii?Q?OVMCuhVKZ/qGUKJRVUjGlwuKK15FKDDpaNwoUrEuCfka/4OR9hLv19O/quQT?=
 =?us-ascii?Q?2fGYKJ/f1mqUQX9RBK7LA/NZza2xqsJ4Fe4VyPc+fGlSKAgADgfY3Gg1CTv7?=
 =?us-ascii?Q?QvpCkXT2rbTOUTuMs270xUaNkMzmCkzeqX2Rl7RCe4qdIoKt6LLZX5OGLjBC?=
 =?us-ascii?Q?MdXDZu+PC7AhJjPCG83IIhX8wMLMC8Id6+wMwPlqpBAVAlz2svWpZEoVIv3M?=
 =?us-ascii?Q?IIiN33kSJxMgFtvx6PFbfylPYE9xlRstb6k0xOKK3adG1g5L3MUlM1bwG/DE?=
 =?us-ascii?Q?t2seGNOsagEEemZ9957efiypsv+GEiak2uzH4WqQKxIkWXmFMTq2xk5W73E3?=
 =?us-ascii?Q?6bamcm35VJhuGeECY/H9BmSW3NqVBpX151V+5zhDna03k37ViNqjwd2Tk0sE?=
 =?us-ascii?Q?kACbjpLqJVh5dnLipFwkUphS9P5MkaLEmf9vMg1s9uXOQZY/YBXQUiiApaI3?=
 =?us-ascii?Q?8eQjXg89KtHIg5vTRmMtFCyr18dkvUoBs3J3LKRZt7yzKIRxbmzD2U42VG5e?=
 =?us-ascii?Q?dLMnANP0zqJStogN6PxdD1bLSRPdAlFVICjXj++efQf2CiAo0njCZKV2LGeB?=
 =?us-ascii?Q?+NdGjPLpY12MEz+iHCihvFRNe77eVJYJ3c5r36cSwofQni4OG+oQCVhoLYMu?=
 =?us-ascii?Q?AHgDWgu2A4SpQZIhROSAQHGuwBLPxxUiznosD7RTZj0vqV32k/RM736Qcc3J?=
 =?us-ascii?Q?GE8v6ZVARJV/4JzEkvhUTXZhIpd70Tf8QCt0j//NkwP1KN7wSeG6UPFSqrPW?=
 =?us-ascii?Q?izUOwnTS4MKU1is9rFgo9aBmESIbBKyK7p3huL21qZloK6XW4TKq7oA6Da+K?=
 =?us-ascii?Q?KrDyS/UnQqIwX7QeOvBFM8rDo/yu7lq4IRmK1SSumkwx0ySREsymcVmQDAbC?=
 =?us-ascii?Q?vnJ1p9J7YeNSKdailvDnycmKUxDQKGUP2ykhKaDD78JZh8fVk1R5vTX8O6IP?=
 =?us-ascii?Q?bLrt4w5vrW80gKiUKt0RiAgKZ7U9lxDOLmb2crZwo/mR4VAyzLLpcdpEEgKu?=
 =?us-ascii?Q?14gQor/4C1ST5n0tsppDcBdyzNA/nSGJvmMfjCBpxOwy3RNZpRVBMAyzEOdR?=
 =?us-ascii?Q?dmWinc3cAVdWkuGtHCQz07sm5HOKiSXMfcFFrQEAMmLpYjfHDK8OClcWC3oR?=
 =?us-ascii?Q?1+ZI/RB/fvb9UMLagv8f4h0SPDYQg+GnH9A1BXB1KkLb/yLCcOXQvV+JyEJ9?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd751eb-b5e6-4218-ff5a-08dd088f50f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 11:42:58.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ET10pEZ7qltP01/iwk7X6baCaEyJq82u/yW232Io5kIJG3rT/L5xPFu3cFxwgujcimJY+eNbmTS0r2Ejp40VLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
X-OriginatorOrg: intel.com

On Tue, Nov 19, 2024 at 07:23:12AM +0000, Justin Lai wrote:
> > 
> > On Mon, Nov 18, 2024 at 12:08:26PM +0800, Justin Lai wrote:

[...]

> > >
> > >
> > ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
> > >                                               supported);
> > > -     cmd->base.speed = SPEED_5000;
> > > +
> > > +     switch (tp->hw_ver) {
> > > +     case 0x00800000:
> > > +     case 0x04000000:
> > > +             cmd->base.speed = SPEED_5000;
> > > +             break;
> > > +     case 0x04800000:
> > > +             cmd->base.speed = SPEED_10000;
> > > +             break;
> > > +     }
> > > +
> > 
> > Above you are adding the code introducing some magic numbers and in your
> > last patch you are refactoring that newly added code.
> > Would it be possible to avoid those intermediate results and prepare the final
> > version of the fix in the series?
> 
> We would still prefer to follow the "single patch, single purpose"
> approach for this part. Other reviewers have also provided similar
> feedback, so we would like to maintain the current approach.
> 

I understand other reviewers' feedback because it's simply hard to
review the series with many intermediate changes in the same code.
Moreover, in this case, those intermediate changes can be easily avoided
by moving the patch #4 to the beginning of the series.
But still - I have doubts if the patch #4 can go into the "net" tree
since it doesn't have any functional fixes.

Thanks,
Michal


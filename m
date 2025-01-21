Return-Path: <netdev+bounces-160147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BA8A18830
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934041887D65
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AAE1F8915;
	Tue, 21 Jan 2025 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1vlHjXQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661DF54764;
	Tue, 21 Jan 2025 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737501129; cv=fail; b=uiMSmQ+scjLuZfDyZYGIetpb/XeLZ4NHKGnRMvSogrvEcu1Wq2VD7ylFXJXK4QHLdpP7HpIK4mINX3NrYQ5zru85b5VrKxwhA4pCCAGDXO6nH318fXaLEw/Ls/HqSbLoDtnOmojBjLgnxA17h6OaxEo98CMUjaafiQAn1bl7ByQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737501129; c=relaxed/simple;
	bh=uM7+UbJBcjqvWs48A6mlBsvqC6uZ7zVe6uwGC3uS4vc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Opo6c4zKrWXmE744bxt7pgnOA5o1Oor+li9+GuGfUHL5OSqV3H+nAyMEpjhhh52nDOu3nVXZi0cjmNY943MC2SJmn/HeEr2Y6l+xUghnSs5tkjGDttApdvCAjwIy3MZ16htlbYb1vIb1mWoLR8pkdHUJO/79cQq2UHTxjU1MolM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1vlHjXQ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737501128; x=1769037128;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=uM7+UbJBcjqvWs48A6mlBsvqC6uZ7zVe6uwGC3uS4vc=;
  b=h1vlHjXQ17dXk7ZWYxOqVsqU+7I52UtlNNQc0P1a7K6kQalDnkmUtaCF
   53B6CnIRMyb7PNcewkmOg4xVOAsoTnG3Dx8V6wmiZgP9Kwk6/F868B0up
   yVvPSI3HRgq+kJ0QOnqm8n6w5FahNSAsel8z1g8a7USHQocAO3JA9ja43
   wbSuNNDJXmeX3BNgN6PBZNkxVsI/pghVQaFmwPweIeCJFtAekFAMbRi65
   8lDcnPhiC8TGScy0KHR6McvfDD524ptU0kYlSa+oNf61ZA+b79WLNj28C
   nrvz1WBqOTPhu6hDr2WU7EoM0R/YGeU+KRtJnC80ZFDXbHL6Ks18sWGtC
   Q==;
X-CSE-ConnectionGUID: Gfb7AYrERFutIxQM0L1s0A==
X-CSE-MsgGUID: BHNpz5kQTc+SRvEClTw1Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38042289"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38042289"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 15:12:07 -0800
X-CSE-ConnectionGUID: EsNDVE9EQRyf9/beqsW2lA==
X-CSE-MsgGUID: rCMwzIddR2OEU3rs672WPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137821583"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 15:12:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 15:12:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 15:12:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 15:12:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqwK0zj2SabPW9LkXT994wkkF3oOnPA1E1mbqqRn/wYB8J/f450CMWvgAHLvNkUtNR7CN1vvlvEoYiSWrx+481FEdZDkUs7VJtaMTHloLBTpehbd6n03p9uMlAcx1SOHw0JTW8iu95qFrk2LSlJT9GLcElw78C1dy1+6bMTn5lCi1RJzp4/qTGUjJU2tQM0om1oF2lx+oxAesP6SEIddRzkM42B6TTtGvGaXJuCnoKP+GXdm4aTlpZpsc7vJCcEEQkBagLGvQ0mGo/ffb5CjcLwo/H8RuJ++G+KSgC38hHKJ30ka8vrF3up68avFzdUluSnNPR9PHMWMu6iGkryqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGiqbTUOgjtGnAP4UqwRnMQG0yVJ6PUCxOWpGIutdPg=;
 b=h6bntbKw6uW2mqFm4UzKL5wJVRpCvyw7Va+pzfyBub5iVb2RxgVMco0MQfAdEx29SiSPqUM0FjsYArIxwm6I9OM0Mvl/svtJs4ApJAV/f6f0RZgDBvlDhsoQ2Xsiw1bUbsbk0wAtQoVMk7JAYBRCRnuhTCYFx/1OyEtJfDQIS7vnSXsIJ5w3A2jTAcHDQmHG6K2dUYc1ZQWoHPKjep1N3ZjozWP6IQXa45gVeIULPCb7NrbY/6nGvRHR5sS3C8baZ5+gRZa7lvGvTJF1LhEgjFnPXKiCw2i2iS+mqmNfJGdsgvFRnmtshQ5Xlw9uQkrDH+FQN4qJXCN2fXEMZysb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4699.namprd11.prod.outlook.com (2603:10b6:303:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 23:11:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 23:11:49 +0000
Date: Tue, 21 Jan 2025 15:11:46 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v9 13/27] cxl: prepare memdev creation for type2
Message-ID: <679029b29571d_20fa294be@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-14-alejandro.lucero-palau@amd.com>
 <678b11ada467d_20fa2949b@dwillia2-xfh.jf.intel.com.notmuch>
 <9a18b887-dbff-d2d4-1446-8f327fd9777f@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9a18b887-dbff-d2d4-1446-8f327fd9777f@amd.com>
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bac4ff-8e36-4569-2135-08dd3a70fbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rrFVPCGOeIELQthWVTM96oq2sQXF6pTnF236s2k55jkwi5XW2/v5LzuhmTd3?=
 =?us-ascii?Q?wNBXaO874rPH1jjIKFfxDCjMkIH8PVQYhRsU16YipV38903lFeiK6R/aoCEM?=
 =?us-ascii?Q?rEbfuPupRtPanbfjd1EU9FFVM1gjP2yCIsr2o8Jbsil5DO6hJ59sbQKQcRMg?=
 =?us-ascii?Q?xdbG0oQ6lNZPdBfKoii0zXeKo+xfFDZ8SHbMPJDmGaYARMt4+1ign3jx7Hqh?=
 =?us-ascii?Q?fTAvadue6P0Qv/6ecBnkMP+4Ygo4jOqh4J8hmHw2+NzW+w7z2twxx53VHeCs?=
 =?us-ascii?Q?Dhiylijx/sL9+htIc6GV1KaxU+kJsiUBucV7fd0IhzKFbxQjRRolQ87a9wuH?=
 =?us-ascii?Q?4CCzAKqBeVUHPbL930a2/35877PVRcgUimL3apjszN6f5mSgRb+jNun7lH4Q?=
 =?us-ascii?Q?rfIC4w+8p2L6Nk0JLUZZpRaidpZvJ4COFxLLJTKlw1DfaxDaWd7zedKiVviF?=
 =?us-ascii?Q?wKdMTPWiASC1MQyb+ndIusTZDp8JambnemDcdkUIe/gKHE3GYBt2WmJgqgYA?=
 =?us-ascii?Q?Z/pk2CaujqdUZ9/wkIkoQY5axV9gEoV8YOfrvFRCG2jJMZKrJ8qWfctnRKuB?=
 =?us-ascii?Q?jSOwZFS1zutSjb4/FHurx2TnH1fed/NsxmfUCjR/CtDl/Qw14u4iOHy4KK9q?=
 =?us-ascii?Q?LYeBqzYxdqFLIeww3NOTTHP9lLFDR5UtWt2iv8dd+PCZ2esTcUVEUSeX0ait?=
 =?us-ascii?Q?5f8rHSrFRxsQiOXtfjy471TNhMz2VFuK3ojrHC41BUWM4qEuc7eBrCDdGJFl?=
 =?us-ascii?Q?Qf/YwEO2szrvE+FmrR1TrCAJk5d4Q2P06wDjaz4gbCsgjqCNxhKJuRVO4+Dl?=
 =?us-ascii?Q?eu+svEj6YgRjSnEow1c8oKGlWzRIOR9TpNxyg4FRaeHVsK30X6MHIR/sPOeE?=
 =?us-ascii?Q?HlYW37mFIdTntdLW6NcQyiTAF9LcZ4pohcdnl2I5j4ZmniapyaRaV9J+tAX/?=
 =?us-ascii?Q?1BNdRFE2WQIy20dO4VntfntKOY6LOOKxM8BjDcP7WeAShL3LfZmmrnqL1O2r?=
 =?us-ascii?Q?ogGNoTPJQYCfUvOWjex+IuMQP0xezLdmrKgHie4UOsOfuyoGAL+vAHb93Ty9?=
 =?us-ascii?Q?z/fRoi7jOmGTZcgUZrrE8fHLuM6Rzhkobgj9nQS4KNl80Po9JToHXGPwywI2?=
 =?us-ascii?Q?q1COAaRWR/k83joQY895x5xvzUKs377PJb530jwb3lTC18K6Hz429NUgUsUY?=
 =?us-ascii?Q?vsWUsXrCK9/6B2t5e0akqCGO+BosVomFidgEF6NNhxrjktSpxXiJLv1EbADB?=
 =?us-ascii?Q?BkaMo722qB+NrUZMh5vetgihDRchoaPIWIdiYgO0zQxCq2QrW0M9vs9/WOln?=
 =?us-ascii?Q?PixiAT4Fj7sadWzNS9rLSi8qsnoVkmARidmtllivEUr/JxpvqnRsOAfGPkU7?=
 =?us-ascii?Q?MJ7/NuXi9bMGscGQBxRjGLA5Fmgn9LS0QlENH2W2Vz0NsnJ/OTlSKc+aPnPh?=
 =?us-ascii?Q?6TRpFpR+gtg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cTRtzYHjZZPwd0fGOL5BRelElB9KntlpZGOxUe2HufPcM9P/tcEskqAQcPwL?=
 =?us-ascii?Q?MBCwTkJ+h/VIQYIe464lu/AByaWVay3OtZZ1pHLXBEJX7Icep84Y8OhhBLNo?=
 =?us-ascii?Q?ZCveUC+AfE1XYR5t2e1uh9dNLjD8JLVCuM18NLc7dVTBD0lCwGqsx3XYXg8f?=
 =?us-ascii?Q?xWAlUOFRga4Z3INTjc4Jds+Zbu0mmsMt0sIlQAQCSDeg94i3dUa/LS+fAsXv?=
 =?us-ascii?Q?Q5ENzIo12jcrfJKCxn56xjmwujbSZ0lcpMT3Iq+D463B/Mo43yLUbK1AfgUV?=
 =?us-ascii?Q?RinSYFVJbW4jv62/oIesplcYZ4ZGm4MHk7wi/rc5Wr4A4Qune6B2h8vkn+E9?=
 =?us-ascii?Q?nJrdRGnvUb0canrkg/bpt6WO0OwJZRzqrTPaCn0MOeuziaSMOTZFukjokT2S?=
 =?us-ascii?Q?cn3emN3waNRpggFvngAYmcRlNMcxEviCKZPX6RWQKgGssXrgPLcbtLeuxiVn?=
 =?us-ascii?Q?L0Jt2YJz5r1assKsR0+QSp7pvnspwzN9bI0oC30K1i2U9EUZmJtvf7vKfuuZ?=
 =?us-ascii?Q?BuicvkrgSntVvm/dbhDtmrvpbopABglReJma/05AGcMJBRqDJUUb7uPLsyeM?=
 =?us-ascii?Q?qowt4L0iq+ELI5a47rxN2Fmp1SxV8MhVsn6oWeEFfZREaVABmE2l73hvONHk?=
 =?us-ascii?Q?ZmBvYZiP4+xHIbdhnBXova8teM+1cKqqD+8z7YEIZq+8MHSR9fca4PCZznkj?=
 =?us-ascii?Q?b0UNJSONU0Ckj0tARxGUZjp9t3Q3HkdSWYPUvbVZ7+GnNZVnxd/d/Gqa9B5S?=
 =?us-ascii?Q?/9K9w+u3pLm3QY5aRwPhos21ZaJ/J8FR3wozjbMSzC2XKEDlevQ6TTw9Tliu?=
 =?us-ascii?Q?6pbA+VgKaK9br6bu1WN2OvsuGJaZn8RPQGmGJtBVwq09tOkuIYFUo2HAn5LU?=
 =?us-ascii?Q?voyL+Y+ih77cudOTBuFHHqDtbWr4wNom9qytBuqDgXDnabiop94VHavXVnju?=
 =?us-ascii?Q?oxVZ8tR+Xv5uGxdxRHA+jofHw8b4ApFu5VByxw/blLnvbzHe2PjhwYHrnREm?=
 =?us-ascii?Q?M5nSjnju3xLxrgLirnOl9oCP4OxTkHub5Fp4/YZs9FeQU7LacZooiMI5dcgD?=
 =?us-ascii?Q?aAbgltGTBGhpJeB7cgiiwNo4lxVxvm4TI8qWJ2O1C8NKglSINui8cKg3GLzH?=
 =?us-ascii?Q?YG1TS6GafIRpKWScnKaoRBR+wgqebL6Wsz7tGWf0Ez5R5vQ33gCO3jv0mtzz?=
 =?us-ascii?Q?vW099DnyBcIpQaxO+qyAvwPgbgr9GbVJ9SQcYKK7D+vWffFeWsQ5TPTGJoP5?=
 =?us-ascii?Q?Qlw9IGerQAQZrHNzKV2JHQWt6Uk1CKawj+KLvWAtCk1YSSZYDIEPdlWNPGq5?=
 =?us-ascii?Q?GdQSlxxcYCo/vFXR2q1Yb2VhPU7Sk/xPKlvZnAgh0y90M6xlGn8nukp907dp?=
 =?us-ascii?Q?3iHFYpbtMGAx+duedzqQW1Q/21c3U7Mbs/uB+GDHStMr8kZL0KKG/OgpiAGn?=
 =?us-ascii?Q?WlIPG7rcks7JMObst95rSCjQ6pzNE89YpIUWOT+0U8fFXStrWN03c3KJZyr/?=
 =?us-ascii?Q?tV/MEcNW2rUaQ3iEu+iuu5lEX4MHg2s/F4H0OIZ4gUbKWvjSapsK5Se5wmTD?=
 =?us-ascii?Q?0zYvAbPUXOdojmvGPpJQxpd7dwViiI3fTxh4LRE9wfdv8s4bdMYBNphyqx0y?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bac4ff-8e36-4569-2135-08dd3a70fbbc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 23:11:49.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rI9S232Evs7IGqxkB+siaLO2PWx0ngf8sP63oy5acmsqX7GdIkfTCzzKjKFdg4MU6SP/rkHil7uOExu0+rDAyxl/mlVg6J38VnqCfO2aCkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4699
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> > If an accelerator has a CDAT it will get qos_class information for free.
> > If it does not have a CDAT then I wonder how it is telling the BIOS the
> > memory type for its CXL.mem?
> 
> AFAIK, this is not mandatory, and the BIOS will look at CXL DVSEC for 
> finding out. So no perf data is mandatory.

Right.

> FWIW, our device will export a CDAT via PCI option rom since we have to 
> avoid the BIOS doing things we do not want to like testing the memory as 
> some BIOS seem to do in some debug/test mode, and to advertise this flag 
> we discussed in v1/RFC for the kernel doing nothing with that memory 
> when found in the HMAT table.

As long as devices that put standard things in standard places get
standard Linux enabling, I am satisfied.

As for the comment about HMAT, I am not sure what that is referring?

The kernel should not need any other consideration for CXL accelerators.
Either accelerator memory is properly marked Reserved in the EFI map, or
it is not. It is a BIOS bug if it maps accelerator memory as EFI
Conventional Memory (with or without the EFI_MEMORY_SP) and per the EFI
spec the kernel has no responsibility to fix that up.


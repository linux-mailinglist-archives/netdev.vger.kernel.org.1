Return-Path: <netdev+bounces-301924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0vswAIL/PGoZvggAu9opvQ
	(envelope-from <netdev+bounces-301924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:14:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C16C4865
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:14:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=TAXXDOXl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301924-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301924-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 123F33014BD5
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711438655C;
	Thu, 25 Jun 2026 10:14:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C51DA57
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 10:14:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382463; cv=fail; b=Pjte0oVfJoVEXBEi/FFZtZutsadRQJjj3i2+YeWWHIo5RiOPUfSq3aWnhgB3T6qGk0kus0xHBa0hsy1AsV0UeN1l2BMaYVUDK8ZLiPUkxIQUf8EQGUU8zdRWHqajOoDqw7zd1kUBIWmoIp2CjW7U1cmYfgtsZHKyfcsigXPf8fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382463; c=relaxed/simple;
	bh=lHvItihr7t2p2dnL/tq+4uA75J1PYhcbUiHWMwfDMxE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BeaTAdL0GHV/8FcFJ7rfqIcJhyyLZbTdECB7gH25CzxbqUXJWnCw9YqbuHZtENJsqr4hfrZjQjqdKMUb74GkiXYWk9ueRcDmLbmtwXUKRD621wJxkFeu9hWXcxamTUVy2yjC9VTsrfgf0dQnGE8IEz2flanHu/1MIkPQRYHXI+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAXXDOXl; arc=fail smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782382462; x=1813918462;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lHvItihr7t2p2dnL/tq+4uA75J1PYhcbUiHWMwfDMxE=;
  b=TAXXDOXlkn4/m4yTD6zU38IeerQKkDoN3o0Ly0IPD7OZ/nGND2/RCX8n
   a4nPcMXZbXr21+9qkmB6L3NolRkQ6Mc7MWIXR3ca+oix5ol2bGIewYSXJ
   BSX5QQapM6kRbtP5B5qo6JNyh4OgfYZGP5pKxLdVrZfKz77VQVDUx3dDD
   fu/rQtTlBAaMjkYbj2H4hd/wBqZ1KRp+FpXz+oUYyjklb7jfY3Njhwzhd
   3a66JGzHmHf7o+a2x5aVGsx18vAWR+7ob99Bw76rGrB3pb1z94btjkOwM
   ttoeGsMXwMH/y7Z38qiL0Aq8eWouxi1sKcJ/NPzuy3L32NHYa+vo6M+He
   w==;
X-CSE-ConnectionGUID: 9wPgwNyWTZat2UwqMUiD1w==
X-CSE-MsgGUID: eg4guIBESeWi7mWFkamy1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94551758"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="94551758"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:14:21 -0700
X-CSE-ConnectionGUID: u8DWUlwiRPKPlRHmxK2ENQ==
X-CSE-MsgGUID: DYgC4j+SRqmJD2ScELPrIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="274803139"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:14:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:14:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 03:14:20 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:14:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxSe5kstkwlUHH5VtrT8aNz30ehXUDf3znQn3uf6+KMv15EvUP5S50XGbnSDuTh0CVR+x6+MN9N/SFG/i4QcZdrfafLZAq2SP8XGN4guIX/AMazxt+GGZL8DxmheQZrec2dDpgr2rphtAgLr6TznwxEPq1fFykIKXVvxcnh27UHJjgF8JSX6H/nOFveFQxWbMm/lzF5uW+NiaButGB8a6SlX3b3XhLlOKyqNuPe5fwMEcQ5KmXtS2kZ7OwwtSI0syKsx2RgoUTr2SuxCDwCkmhxdUzdtqc4isn47vBtQqm6LWg81qM9xhOjh22TMCAbYTqLq/NvjgGh5V9nx7zS3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk6zd9fwDoIeG8enxhfWmOAwrFmlnHI/Dpz4/UnXfOs=;
 b=e8q7XM7956DjkQnXiJfZcLnsDaaHW1XpUqsaP+tGrsVExJFaTIoxDll0BMue9E6sGOKiEBrFdYGNppj2CMWWd8pZRDdYr1C6WP11Pmi9+mO33WCTk67IIDReS+NEIZw065VvvZyMcSgEVKpR4+gfHZlC05d1uLLWhCiqO5DTuT3vi8TMhp39Aa4flFsSSDld8+a18yNLODmy9y45VzSQTu0YiwGsOh3SpZfGzJGLoe4imdumbSjqni7K0X5CsmEweFYuVFEM9gCAQ0YxdXvQrsT+2N2VSJXWKSh7Eq05VQ1yNCrPBKfKzA71clA6aj+LAhG8rUu4C8xAdctVT3IlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2556.namprd11.prod.outlook.com (2603:10b6:5:c6::10) by
 PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.17; Thu, 25 Jun 2026 10:14:18 +0000
Received: from DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac]) by DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac%5]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 10:14:18 +0000
Date: Thu, 25 Jun 2026 12:14:12 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, 'Mengyuan Lou' <mengyuanlou@net-swift.com>,
	'Andrew Lunn' <andrew+netdev@lunn.ch>, "'David S. Miller'"
	<davem@davemloft.net>, 'Eric Dumazet' <edumazet@google.com>, 'Jakub Kicinski'
	<kuba@kernel.org>, 'Paolo Abeni' <pabeni@redhat.com>, 'Simon Horman'
	<horms@kernel.org>, 'Kees Cook' <kees@kernel.org>
Subject: Re: [PATCH net] net: libwx: fix VMDQ mask for 1-queue mode
Message-ID: <ajz_dBRcXLsSn5AL@soc-5CG4396X81.clients.intel.com>
References: <60D88ADD3E295420+20260625090851.539640-1-jiawenwu@trustnetic.com>
 <ajz3QK96wKoLD4n4@soc-5CG4396X81.clients.intel.com>
 <062401dd0487$3a3152f0$ae93f8d0$@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <062401dd0487$3a3152f0$ae93f8d0$@trustnetic.com>
X-ClientProxiedBy: WA1PEPF00005B9D.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::635) To DM6PR11MB2556.namprd11.prod.outlook.com
 (2603:10b6:5:c6::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2556:EE_|PH0PR11MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: a060df6f-948a-466a-5d5e-08ded2a284c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|7416014|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qWVJJC7oseuALY0JxRvrZYk8zNyROZurMkq/UwCUODebQ6PQa1dW3uqgqW2swlYuFjn1GPhkNjzlQlzoiiEL8NT4+XGUWZ7QLDF7hS913q5EcmD+xF82yzkSTf1uwijuO+rftSuGXxjrAsuxgRlYhZrNR6EVW782ICmE0axLxg2pv9lg3Ui5/s3YjwOi2Dfgkb3WRwxhMFa7o1C7mFnSc/JwvwxfCUDvbX6Pod0uQYyheX1xQGuhDI+rLhmxeh9RYMIsRCJjEqZ7cvH+yqs6PNCv4AXNYXVyJ4hIfcmicnaJAgr0/B7YntBujIVBQlNTrBpccBDiK+LIENT27ct4M82YfU5dp1ncUv3JAxYL2z40vUS0QQz/p4Kuv6KgIlTl4gA5jFejCR2pJbCWreHhstJCg+/tvjbpfSqPVq5vqj3pWO7GUR/EI/kq3sSKO9ulisxPihVvXFOWH9PV49xJspJ0WlnOtmkSOZcD+CY8IZZ8o/OMAWlNS9bmBn0I4Zbf+GMn02m8EaFdnc/1jz3vqKXAMh3cbNjqgJL3NK+hl89s4OUrj1LtfCpm2F+wld70/tLZHV/8uQOT6wzESYIrUfcb+RhKIe1eIJLUgVeHRtA09C/a27piVOc3u6aadWvZUw+SBr5lGoxDHLXXiJ7v8sPBZgOq4FZiP8bnhnkxcMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GG9AI44uqqR/t7yOu5cuSFIlbhDGnV7amb4QwFWKHRX5SRZWRScLfS/wEFHA?=
 =?us-ascii?Q?igpu0fF1ykG7RObCs+EKT3YyfQmKJ8lqWPuzFOdcTpAUvB2lhZ11NSdTFkzG?=
 =?us-ascii?Q?9scXJTu7nj3Y23+MyaAg7TAF7vfnfQUGaGX0Z7ZUMtv6TuSCnUoUdMNTwouK?=
 =?us-ascii?Q?t33Z6YTD5P6BLOWw9Ed9KQbfxJt5ivla3QTGeSZAr1MyMYdQEE+F2cjlr5g/?=
 =?us-ascii?Q?hRd/dCPqW6oSr0P1wlmCw2CnM5K0lFALAPDJiEQ3Zf82TYCxvWhQ/UCm22wa?=
 =?us-ascii?Q?OObG8m2XKKtL52HSunDHr1BOI+BgIJ4Qk5005+pUS+blO98/cUmgHHet7ICf?=
 =?us-ascii?Q?Z6/70XF1ZBpLEO0BrFbcZFPFwVeBLUZMapc6cZB5z7cQJ/8Pylb2vBY46n3f?=
 =?us-ascii?Q?/KhVtFD0zkylQkn5+SYinvK9mHJNGUh50oECJpEMRdyn5LRV4gA6LB/eRBLv?=
 =?us-ascii?Q?PuCEOl7oblpvsbx2o0U6vJ4VXhSiAh3tzes86osWow7f9ZP3t7ufASRHVvZA?=
 =?us-ascii?Q?zgFLG88Fq+vQJm3HdlgmJTM+GQCSeBl3Kra+/VA9ml/G6PoP3ReK4zXJkgYV?=
 =?us-ascii?Q?q/3IUQxa5TM65pbbeeHOA7pGBuexQjGuD+AZGny15pQCe2DbwKKAbrZDIeDL?=
 =?us-ascii?Q?3a8bzu/VkNVWrgS8hHP9Dyusm+lu9J7kgEbjK2Mpflp+8AWIf60pGSRAa6zo?=
 =?us-ascii?Q?omwtemXiH9PZdcaONS275M4+IFuli2jXW7DJga0udUguDu19X7W5XRZIQAPi?=
 =?us-ascii?Q?9Frxnb8IxsUs/dYzTzzRhy2/tjbqGuA47/eKR1T0Lmos3n7axX4NW616umuJ?=
 =?us-ascii?Q?FHvu+Gmfnnq1vUJzzoczCnKSdsfLMV9puifQcJaYHu5ORyNTGimInVuFY8vn?=
 =?us-ascii?Q?BJDHEzI63ouKOnwpwpfFzBMHqxOG+SFVIUtuOBDxlM0ZWuvYF3d2tvhFoq+6?=
 =?us-ascii?Q?ebK+1GUw2mmk4HTdhE5i1JfGjIu6ZJFzh+P2CedIF0uWxHdslgKT//Qj6w2U?=
 =?us-ascii?Q?AMeQHMVQj1sEavGvnXav7yhewnVhHhfjwkoGhTEizDsaOgB+5Ww8wVTnNpHF?=
 =?us-ascii?Q?GlDrMGc6fkTD+XEme6L9NW/VHLmfLfDoeqsv5dRyWPZJoJ5Oa47KZQ7LGyw4?=
 =?us-ascii?Q?Q0DYdfXLVZUQmybX1HnpLqZWpOx3+HgXf+El2r+kFzrn9x+cYKa1xGb/j/Ki?=
 =?us-ascii?Q?vl8klBkLnQKf8iyCEf6ssotiDaYPoBfncIh7nawifscvDKAx6YUR+IG7iT/8?=
 =?us-ascii?Q?76VqSMLL6f0baCT/eWlY257YAHRURJC9zNhsYZJDF7thRRbZfnxQaLMkX+eD?=
 =?us-ascii?Q?Vuw+Gc99mUoAvIqv4/D5mXs+AK/kU0JMzN4K4XXe9FWe2OyqJe+jxNwS3yhp?=
 =?us-ascii?Q?IiEL+8lZeF44gKkCh8GjdwZMrix8B4zddFO4yMSDaFKA3g7/RwytDZEjsBdZ?=
 =?us-ascii?Q?Z/95EQgdvvZhYjj6qXQ9MZnLoHM3yQBzBOVUmBxoxrnWQb1cD7PbW9t4vVDn?=
 =?us-ascii?Q?wpZzFOzjQYe1j1Bc2NstDjJ94wcAiVmoh2rSNHIqm9LAUfM8kfbYuw7OrVOK?=
 =?us-ascii?Q?/LjszRXYNGicoclPzmoxcG1PSqLtrL8JogKV6BKFbbRuxXnmG0XLkwhtDaqC?=
 =?us-ascii?Q?auom/Q9SP+WVjsgFy323nsHSmZE9RYZtCzNbdXxQ6iM0/1d82OnyKKz2LV+I?=
 =?us-ascii?Q?d01D7CIz7huYsenGjpjPGJ//yb2RaRaRTGGtSORr5m/t1L3A11A5eTTEJgfI?=
 =?us-ascii?Q?9rO1twoam7R3RY+hFN/4L5OmuoJXly2//xZUkQKLmVpDc09UDjW7rtlBK8Fw?=
X-MS-Exchange-AntiSpam-MessageData-1: qWUek7tFUUBtNPh5U1ZU6p3UfI1UfDRw6Fg=
X-Exchange-RoutingPolicyChecked: Z+Mu9btsUz5DnUFeBpN/eqCKPZ5aemhbqpC7BVm7HuHt+fIou/EuiHDjtvoHIQehVEp3E3CCTRwRkfc9q+4B4elW/0q1TbHlbPJbF0sdOOAPCKCWSd3N//nC6SWkT1VIMz12oH/x3jUSWr2ARIkhfdUIZ/thIHZZjNznLZttcBITbdzdZ1K/4h1Uh/Q50cle9Tfs0J4s2rvmmktuogXUx9aUeIJeJmtupJ1hako5Zhowqg3HacXSMsi9kvgUfZ53PWQDYVoH8cPXrgJD0lShu597tASRxLSWD5oWLR7UocbmZCMaGa/lNgUzLbQZSj0jQjJOHHLQLvvySOoBlWwWgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a060df6f-948a-466a-5d5e-08ded2a284c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:14:18.8396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn2umRndu0/pdqX5s6DmsVas0Y/yT8GZOButED9wWHAyyT7ESSwrzRIi1tpPG6+HADEsMAdSC+fPa67E3KJHXTsmoLN7AcYHQYp7MzgsC14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:from_mime,soc-5CG4396X81.clients.intel.com:mid,trustnetic.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_FROM(0.00)[bounces-301924-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 487C16C4865

On Thu, Jun 25, 2026 at 05:44:33PM +0800, Jiawen Wu wrote:
> On Thu, Jun 25, 2026 5:39 PM, Larysa Zaremba wrote:
> > On Thu, Jun 25, 2026 at 05:08:51PM +0800, Jiawen Wu wrote:
> > > In wx_set_vmdq_queues(), the VMDQ mask was not set for the devices not
> > > support WX_FLAG_MULTI_64_FUNC, i.e., NGBE devices. A mask of 0 causes
> > > __ALIGN_MASK(1, ~vmdq->mask) to return 0, which incorrectly sets
> > > q_per_pool to 0 in wx_write_qde().
> > >
> > > Fix the VMDQ 1-queue mask to 0x7F then ensures that __ALIGN_MASK(1,
> > > 0x7F) correctly evaluates to 1.
> > 
> > __ALIGN_MASK(1, 0x7F) evaulates to 0x80 (128), not to 1. __ALIGN_MASK(1, 0x7E)
> > evaluates to 1. Maybe you need 0x7D for 2 queues and 0x7E for 1 queue?
> 
> Sorry, the commit log is so wrong for that '~' is missing...
> I want to describe that __ALIGN_MASK(1, ~0x7F) evaluates to 1.
>

Then I do not have any further concerns. Given you fix the lack of "~" in the 
commit message and change "not support" to "not supporting" above, I approve 
this patch.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
 
> > 
> > >
> > > Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
> > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > > ---
> > >  drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 1 +
> > >  drivers/net/ethernet/wangxun/libwx/wx_type.h | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > > index d042567b8128..814d88d2aee4 100644
> > > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > > @@ -1802,6 +1802,7 @@ static bool wx_set_vmdq_queues(struct wx *wx)
> > >  			rss_i = 4;
> > >  		}
> > >  	} else {
> > > +		vmdq_m = WX_VMDQ_1Q_MASK;
> > >  		/* double check we are limited to maximum pools */
> > >  		vmdq_i = min_t(u16, 8, vmdq_i);
> > >
> > > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > > index c7befe4cdfe9..65e3e55db1cf 100644
> > > --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > > +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > > @@ -486,6 +486,7 @@ enum WX_MSCA_CMD_value {
> > >
> > >  #define WX_VMDQ_4Q_MASK              0x7C
> > >  #define WX_VMDQ_2Q_MASK              0x7E
> > > +#define WX_VMDQ_1Q_MASK              0x7F
> > >
> > >  /****************** Manageablility Host Interface defines ********************/
> > >  #define WX_HI_MAX_BLOCK_BYTE_LENGTH  256 /* Num of bytes in range */
> > > --
> > > 2.51.0
> > >
> > 
> 


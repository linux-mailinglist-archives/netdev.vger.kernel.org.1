Return-Path: <netdev+bounces-279278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDN8NbH54Wn50AAAu9opvQ
	(envelope-from <netdev+bounces-279278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:13:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769D419213
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EBC43013A69
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7EC3A7F58;
	Fri, 17 Apr 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3gQ2Eav"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38B1D61B7;
	Fri, 17 Apr 2026 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416873; cv=fail; b=SnPIQhl9cL/xOjQawWOTY4L0wDWREQWqaOHiX7emB0WutNupwHuewbPh07FuVTQIQ5BfAUfFnAr5e7vLHsRPW5zv+j2MNS4rd+r4Fxzd1n7BDSvmDllkjoUK6ifHj2TUOQ2kDE/AQLiP8HdwxO5gMMoz5khLUGZsB3Ni02MSlGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416873; c=relaxed/simple;
	bh=YxnB/IU0HUGchLP9KR2r16B2Ju/gxmTYphdfObWGEqk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YBl++IaY7Mh2AuOdP3/T1AFNEZxfkzyhY6g08K5vdYt4J58QgfZ8/WZFuDDWs9rnW6o1XZzlPChv0JTgdi4OqOBjkMkVv3DJknrO+eFhdnp+Sd+mHaT2NasGu3jc19RVFuxMBn13G51iSy+Uqe2lp5T5MIL804K/0KZZwG7RuEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3gQ2Eav; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776416872; x=1807952872;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YxnB/IU0HUGchLP9KR2r16B2Ju/gxmTYphdfObWGEqk=;
  b=d3gQ2EavBkWF4wEC40WqOY5k11z3NBQCk/YpLJa7q2tqXV1eocelGLB1
   uSRCrjvKY74E6nEh6x9FeBfFOWGgBI8qZNIa9SS6l4SJx6QgIZHFM+zOF
   72nlW8EqFjJm637hrIFVP+I1LHYg7QgvQ0yVKIWtVLTMymli7jx5sHZfJ
   Ptsf17U+40ZFLiGLmu8BOE0Iv0n758uspbu7ncmqXCfFinHxQX5Vnxffl
   sgUXNBerXXn+uYT8li+tdYFmtZDgtCtrGPoF4IBsJhcXYQWRltoCyQSIP
   SibR/FiyYfkaFMRtnlvVIC6qDoeEDJ5EMo8gEgeJeF1GpTdPPzK0SW96g
   A==;
X-CSE-ConnectionGUID: PwgS1x+4TQGETLPR9JZx8g==
X-CSE-MsgGUID: 02HYW9r0Tq+T7rCxK35iDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81027830"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="81027830"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 02:07:52 -0700
X-CSE-ConnectionGUID: W0HlhNbiTz67Tis97SbEig==
X-CSE-MsgGUID: NyWS5tmNTiup4dmWQGCwSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="229974010"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 02:07:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 02:07:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 02:07:50 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 02:07:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4aUONX7NVnK4oGQn+m392lGrZcwB/9BHTdHYlNh9N2A91llNCH7aa0hOB4mRonqrA+7/KmskGLqv8IkBDRXSkQ85TgZvUFt3FRpmhbWAC61iKSXNt45y4GrgBI2ljXN0zAg/52An9CI0evxeKfaYOjKech+expWsDVR/bNSfLm+usZ8PJ8aN/eWhxjFYH23VhalmTjwCAWYzQsGlw7dHpkFVKpce0Po1kQmAJPuVvibwlBPgLB8Yf3Wy/DVYd2s8M0Zx+ZRVoDsnXYn+Z3UpOjhCF3i+GkZlfNykMAMutZLcPPHgnAjdnAkoiLOOynb6OZjqIU/kz2aXqnN0B2+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeftmVsMctPx+oomXT1oolN/X3PP/QmoBTB0prWmryI=;
 b=EzC6WLtGig36/c0NF2ahyjpAMUf0hlt06qESwqDoI8ZoaQkD6VuPE7/VaCrSV6E76xNDiRZECpM05mlYQShJkBlfxKJjnhcFPelaC9NODPmbO6jYYFpSr2qqoTE2q4X+CeuL4nLp6ecpxGFvhWcpLsaBs0qcgrEGbGC2XZ938G2t46RYZlovTPWsQAyizha2QH3iMkEYK1XM13JaxvvIiJa0j0qap596/DdL4M4/4ENIvC3h2KLztohnLx6YzXQQNTr+JTo+7gVqWs6OAW/88pCEalMQ0qhq6dEZ4x9H49aktbHN7qepMDKe66TVozBAvQ7CnOHgwxmtW2unX/pU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SA1PR11MB8593.namprd11.prod.outlook.com (2603:10b6:806:3ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 09:07:42 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 09:07:42 +0000
Date: Fri, 17 Apr 2026 17:07:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Keita Morisaki <kmta1236@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [tcp]  8ca8eb0576:
 kernel-selftests-bpf.net/mptcp.mptcp_join.sh.mptcp_join_userspace_pm_send_RM_ADDR_for_ID_0.fail
Message-ID: <202604171618.f261a864-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SA1PR11MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 486ebade-8ed9-405e-0e6a-08de9c60c81a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: VFgmG7URBa1z/7EwsvwWUkbQ0Zbq4ta7hrvkWj6Hy2Zvhw0cbtm6AK9122l3E58xz4KXLChnhr7bOD88rTS8XO9hnnPhKxkMn45PfwNyVpDPblFZ5z6b7VZkCRQPlZINDFY1cDvJ4Q2imvE/vRev8EdGbksiKNOATzT5nQ1CDIcgWDJYt+4DMhq/tMdvuD9ngBsEyLbwg1KgRkXvR8KGQ1dZFIiWGE3JH773Ep6jtpaTF3gZC03+j/Jzl//FuHVyORyJZ0lK22PsK64NSHYBUrGG2uXl4ZB18FYGPUCTJfV98ILKDTHWkYduzh1Rh7yFZ+pJBRckx9b/U47rr8CJOMhUBBHJW36BQLYDmSyJtWV2Cv1aX4krU1wj8bM8pu0At1xD+hOBuVNpBxZAjSvTIlPdsCsWn6y3pS/U8Na4FZd0UUeNvUJz7MhqAbLsJDchthjO4sxgM4Hvq4iFvj8gcYm1WpNTezPQVvRVKJ/HC3/mAN0Wod4Gf8hoSjsEBhqM6lbwuqnGjtueOx86tss5x1soYJcVV/OQqUSpQtzuh7oev2LQfGfGIJiINQ5otlAfdFiSqHWrRCvMWS3zlggor1oo4tPY/GPzI4otFbvGMGHXiEFYNpMXs3Iz3/B4d2IgPu1jzSYBZoREftfrxtt38f7do72/en3cRDr8KkLKS4xGjCi+6oVqEFD+wLinlJBZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqojk9bIeZczhZAyUavjC0zuj/nx2xrklT3+AdlToNsE/1ugIYWGowwdV7af?=
 =?us-ascii?Q?CB4d6hAYF0/RmEVeklc7f0HcBiT2RPf7eRsxHskDNmZs5LNVQC/GiCaPlfu9?=
 =?us-ascii?Q?n+xTUEB608FiacqoWBpOq/BJ1nCMUPqH1CIZTMa1y2yLmrPjiMVzO+WzyGzP?=
 =?us-ascii?Q?MEhOoJxKYKDeF3t09a01RMfkvdUDq3ZFOG1WKeuuYUzNhH6Bl8jA7MF6HVKV?=
 =?us-ascii?Q?jBw6UkNOTqLNVNaxfnrhWrIm4iDL5FstIL3ilSMAmn0xJ1CKMR3zNBnTjbfU?=
 =?us-ascii?Q?48pSYMPJE0S9099n6Tbbo7FG3rOj4JYMtAyzHNo0eiRVUdLTr9Dktax3jc51?=
 =?us-ascii?Q?SKlWFDsBFfnax2DL/ALgpUwNC/pUByeF97LMYQ6MINHXKayOF6w8jO7aNmHn?=
 =?us-ascii?Q?9KOdbx7ZbZev7rt3c4KGR0lwkfQe0DeJHcgcNC/bUijuxqIcw1qlzFI+Ni46?=
 =?us-ascii?Q?HlvoKc8CiuL763jeTqoLfUsyiL+GDFF46/HUdyusJ/cMxQXBoI+9cDEvvrf4?=
 =?us-ascii?Q?L5Ke9RMEr/PZsbHoq8kF3r9QcTjAs04Ze3SGQvOjLyelqQLYHyEJSxfFwCl7?=
 =?us-ascii?Q?LFF4iebYCIs580LS4wZiSZNbeurS6WlJ7HRvHy88bph/fpb3StmQkuxpsEi8?=
 =?us-ascii?Q?L0IdVSwW7OZpdx/BldPCsDB1oosl2ZYANRJSn10k2X60Uv/L0KTi8yCo9y8+?=
 =?us-ascii?Q?Ovgrko/2yhHWiZPQxJEhGudXcahMpfaX0PqMLxiALIUkQ876oGoJkTX2vfw7?=
 =?us-ascii?Q?+KblCtm3ayzrGTGfbQ+2rch6lDoQ0HPFuw198HDKny+dgSXr/dBelQ4PWA8J?=
 =?us-ascii?Q?ejEzZ2vV39McLfIrjW33lP77pEO3uDLzoSHEnC98WjeudKhghPH/zzsfg3yj?=
 =?us-ascii?Q?K6weFH86Rxmf7zUWp2BHu6Gy0JCCSwv4iRNMwNM0+empVLARhpAIQpsRsgIN?=
 =?us-ascii?Q?D/DuSUBnMhQtfmebgDRfyd+d2z2tguK5Z4y225VnlfaeKzJXEX0P8LIoB4T/?=
 =?us-ascii?Q?g2vq3c8hewVc+HkOflSbkwKQvlePxa3FGrXKVExT5/INk0EqdW1SkAQpi0GY?=
 =?us-ascii?Q?sTJa30MZCfnER5sUIR2nE3BeFtgaX5hPJhI8AeDSTANMMlxkJlJ03bCqUXkl?=
 =?us-ascii?Q?cfNn5sIZ70/LM76AnRDJfPlq/JyywBOQA9daGb1kKh9lqbTwvhz/HKFGxGQB?=
 =?us-ascii?Q?CaPiKReYwuWNia5ENFRkUVV2um2PbP5YcDAwEu1JZpQUyBOhkm0smUJSOsei?=
 =?us-ascii?Q?f/L04/k6+JeUn5xiFsk+EXlSj2p/LulcdJBvawh6QPr5ch/3VxC8aKkBdi8R?=
 =?us-ascii?Q?e23zTHuSjUJl1/I/ChJQcDc9ODIXt10yHHloPbMFxCGM9ruYkDUjs2yDIMKe?=
 =?us-ascii?Q?DSOdYvhBswgAwgYFGgKPkS+HRnY32ZiM5jtM6mwjUn2XrzqlUOvVvMDx0Lq7?=
 =?us-ascii?Q?PUQ0n16VkPgUwq0c64dBEYJqpduxhd2121Nl4kByMA2OfGdO5WLdj9M3YBRH?=
 =?us-ascii?Q?GnJCu+592gAEIDDfwzPPq5ZvJrXNsAfYyG8WDgZFmaYCoJH5kiyt3dloPrqF?=
 =?us-ascii?Q?+uMLSUEzcT7GgobxyNBOhIYCJ6nvod3p0L1G1hCn4yR4OyUUVOFsZT8mgX4d?=
 =?us-ascii?Q?hazKUsoNqXjQheNYQyZkwxzVtg1WeqQPYhUqT9e/3RYuyH2mksi3bewas6Qj?=
 =?us-ascii?Q?jHhyihkYUV0V95Wy2+5638Wi8hoKReA+B7tW9JcxlANF2ZJ9cz7hZrn7Qm8F?=
 =?us-ascii?Q?R2Ju4hk67w=3D=3D?=
X-Exchange-RoutingPolicyChecked: LqIKA9bwihRfI9R5SiizOVWS+amBpQ9VOqsbEcrbe6bjtWIMTAUWWgzH1dF3vIGDJXs0Opbrg2FCwTXLpNH9YqAyS4sUsMRJufjGznh8aAct0upsCxfk7wkBx9bb1DwLV09xxlsbG8Zh2oQ94SUTok/EbbZ1wZIJAIv3veyJbECqG9NIsR5+2+4F1PUPu0ymBXnh5gYwLktW6geNovpxT1CB6d8JJIGQv8d0U5OldwpvGMmAN9h8DynfMpCBPWuToLaTDwviS50jRIputUIaRpal8V8tWynEnVtmuBR14xyNEDSSoiFCaxGnwAgV0sFiDoOQUdtwtKvlAKqqw09qnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 486ebade-8ed9-405e-0e6a-08de9c60c81a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 09:07:42.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1RkndgcsSUiFYwKLwVixRDB2TAGW2aDqripby/6sFHya8Elje9xvyIg4MInAIVGwUoTk/MCZMgRhIGJNNuKPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8593
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279278-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mptcp_join.sh:url,01.org:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6769D419213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Hello,

kernel test robot noticed "kernel-selftests-bpf.net/mptcp.mptcp_join.sh.mptcp_join_userspace_pm_send_RM_ADDR_for_ID_0.fail" on:

commit: 8ca8eb05767395cd2fd0db12e052ca0bc5d1597c ("tcp: remove unused hash_size from struct tcp_out_options")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: kernel-selftests-bpf
version: 
with following parameters:

	group: net/mptcp



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202604171618.f261a864-lkp@intel.com


# 132 userspace pm send RM_ADDR for ID 0
#       Info: Test file (size 128 KB) for client
#       Info: Test file (size 128 KB) for server
#       syn rx                              [FAIL] got 0 JOIN[s] syn rx expected 1
# Server ns stats (ns2-mQDnh0)
# TcpPassiveOpens                 1                  0.0
# TcpInSegs                       120                0.0
# TcpOutSegs                      100                0.0
# TcpExtDelayedACKs               24                 0.0
# TcpExtTCPPureAcks               56                 0.0
# TcpExtTCPOrigDataSent           63                 0.0
# TcpExtTCPDelivered              63                 0.0
# MPTcpExtMPCapableSYNRX          1                  0.0
# MPTcpExtMPCapableACKRX          1                  0.0
# MPTcpExtAddAddrTx               1                  0.0
# MPTcpExtMPCurrEstab             1                  0.0
# MPTcpExtDssFallback             1                  0.0
# 
# Client ns stats (ns2-mQDnh0)
# TcpActiveOpens                  1                  0.0
# TcpInSegs                       100                0.0
# TcpOutSegs                      120                0.0
# TcpExtDelayedACKs               41                 0.0
# TcpExtTCPPureAcks               36                 0.0
# TcpExtTCPOrigDataSent           63                 0.0
# TcpExtTCPDelivered              64                 0.0
# MPTcpExtMPCapableSYNTX          1                  0.0
# MPTcpExtMPCapableSYNACKRX       1                  0.0
# MPTcpExtMPCurrEstab             1                  0.0
# MPTcpExtMPCapableDataFallback   1                  0.0
# 
#       synack rx                           [FAIL] got 0 JOIN[s] synack rx expected 1
#       ack rx                              [FAIL] got 0 JOIN[s] ack rx expected 1
#       join Rx                             [FAIL] see above
#       syn tx                              [FAIL] got 0 JOIN[s] syn tx expected 1
#       join Tx                             [FAIL] see above
#       ns1 dss fallback                    [FAIL] got 1 dss fallback[s] in ns1 expected 0
#       ns2 mpc data fallback               [FAIL] got 1 mpc data fallback[s] in ns2 expected 0
#       fallback                            [FAIL] see above
#       add addr rx                         [FAIL] got 0 ADD_ADDR[s] expected 1
#       add addr echo rx                    [FAIL] got 0 ADD_ADDR echo[s] expected 1
#       mptcp_info subflows=1:1             [FAIL] got 0:0 subflows:subflows expected 1:1
# ESTAB 0      0      [::ffff:10.0.1.1]:10131 [::ffff:10.0.1.2]:44220
# 	 skmem:(r0,rb131072,t0,tb20480,f2014,w0,o56,bl0,d0) add_addr_signal:1 fallback remote_key token:16a2fd8b write_seq:17048891511713788648 snd_una:17048891511713788648 rcv_nxt:787573327139392450 local_addr_used:1 bytes_sent:350 bytes_received:350 bytes_acked:350 subflows_total:1 last_data_sent:71 last_data_recv:71 last_ack_recv:13893
# ESTAB 965    0      10.0.1.2:44220 10.0.1.1:10131
# 	 skmem:(r965,rb131072,t0,tb91136,f1049,w0,o0,bl0,d0) subflows_max:1 add_addr_accepted_max:1 fallback remote_key token:412ba7d write_seq:787573327139392450 snd_una:787573327139392450 rcv_nxt:17048891511713788648 bytes_sent:350 bytes_received:350 bytes_acked:350 subflows_total:1 last_data_sent:97 last_data_recv:97 last_ack_recv:13921
#       mptcp_info subflows_total=2:2       [FAIL] got 1:1 subflows_total:subflows_total expected 2:2
# ESTAB 0      0      [::ffff:10.0.1.1]:10131 [::ffff:10.0.1.2]:44220
# 	 skmem:(r0,rb131072,t0,tb20480,f2979,w0,o56,bl0,d0) add_addr_signal:1 fallback remote_key token:16a2fd8b write_seq:17048891511713788653 snd_una:17048891511713788653 rcv_nxt:787573327139392455 local_addr_used:1 bytes_sent:355 bytes_received:355 bytes_acked:355 subflows_total:1 last_data_sent:42 last_data_recv:43 last_ack_recv:14065
# ESTAB 965    0      10.0.1.2:44220 10.0.1.1:10131
# 	 skmem:(r965,rb131072,t0,tb91136,f2014,w0,o0,bl0,d0) subflows_max:1 add_addr_accepted_max:1 fallback remote_key token:412ba7d write_seq:787573327139392455 snd_una:787573327139392455 rcv_nxt:17048891511713788653 bytes_sent:355 bytes_received:355 bytes_acked:355 subflows_total:1 last_data_sent:70 last_data_recv:69 last_ack_recv:14094
#       mptcp_info add_addr_signal=1:1      [FAIL] got 1:0 add_addr_signal:add_addr_accepted expected 1:1
# ESTAB 0      0      [::ffff:10.0.1.1]:10131 [::ffff:10.0.1.2]:44220
# 	 skmem:(r0,rb131072,t0,tb20480,f2979,w0,o56,bl0,d0) add_addr_signal:1 fallback remote_key token:16a2fd8b write_seq:17048891511713788653 snd_una:17048891511713788653 rcv_nxt:787573327139392455 local_addr_used:1 bytes_sent:355 bytes_received:355 bytes_acked:355 subflows_total:1 last_data_sent:181 last_data_recv:182 last_ack_recv:14204
# ESTAB 965    0      10.0.1.2:44220 10.0.1.1:10131
# 	 skmem:(r965,rb131072,t0,tb91136,f2979,w0,o0,bl0,d0) subflows_max:1 add_addr_accepted_max:1 fallback remote_key token:412ba7d write_seq:787573327139392460 snd_una:787573327139392460 rcv_nxt:17048891511713788658 bytes_sent:360 bytes_received:360 bytes_acked:360 subflows_total:1 last_data_sent:7 last_data_recv:7 last_ack_recv:14232
#       rm addr rx client                   [FAIL] got 0 RM_ADDR[s] expected 1
#       rm subflow server                   [ OK ]
#       reset tx client                     [ OK ]
#       reset rx server                     [ OK ]
#       mptcp_info subflows=1:1             [FAIL] got 0:0 subflows:subflows expected 1:1
# ESTAB 0      0      [::ffff:10.0.1.1]:10131 [::ffff:10.0.1.2]:44220
# 	 skmem:(r0,rb131072,t0,tb20480,f341,w0,o56,bl0,d0) add_addr_signal:1 fallback remote_key token:16a2fd8b write_seq:17048891511713788703 snd_una:17048891511713788703 rcv_nxt:787573327139392505 local_addr_used:1 bytes_sent:405 bytes_received:405 bytes_acked:405 subflows_total:1 last_data_sent:131 last_data_recv:132 last_ack_recv:16157
# ESTAB 965    0      10.0.1.2:44220 10.0.1.1:10131
# 	 skmem:(r965,rb131072,t0,tb91136,f3472,w0,o0,bl0,d0) subflows_max:1 add_addr_accepted_max:1 fallback remote_key token:412ba7d write_seq:787573327139392505 snd_una:787573327139392505 rcv_nxt:17048891511713788703 bytes_sent:405 bytes_received:405 bytes_acked:405 subflows_total:1 last_data_sent:154 last_data_recv:153 last_ack_recv:16181
#       mptcp_info subflows_total=1:1       [ OK ]

.....

# 66 failure(s) has(ve) been detected:

...

# 	- 132: userspace pm send RM_ADDR for ID 0

...


# 
# TAP version 13
# 1..137

...

# not ok 132 - mptcp_join: userspace pm send RM_ADDR for ID 0 # time=18457ms

...

not ok 7 selftests: net/mptcp: mptcp_join.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260417/202604171618.f261a864-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



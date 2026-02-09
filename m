Return-Path: <netdev+bounces-257990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FDFvD9pXimmqJgAAu9opvQ
	(envelope-from <netdev+bounces-257990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 22:55:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F0F114F07
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 22:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F57E3018D56
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 21:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE230E84A;
	Mon,  9 Feb 2026 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+jCJn+L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273742049
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674134; cv=fail; b=CuagjTF4HT7gy/KaA4UB7vS0s9mnwgqGfmtEf4fV0850e4Z6QVbTl4LUwLQeNgJwKucXNmrtvUzqLUlfPmyEslCemcvbO4xtJMCsfc4nc4PkyW8Eo8Wi4QXjzhpSbmOvcgBjGRdexc1XGMl6QXr8HbyTxrxIt+HvafgXm6Axnys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674134; c=relaxed/simple;
	bh=s0Z970YGRmh/TeStQfOJa3KL8Y6th8HpOKu2nooh62o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sl/FMNhEcISYdVdhAO7l6+zOWz+gyZ9Rzq4wwBdtbiOVPbuAofDjT8EQ+W8x7cihab8blE+xgP0NHnprq0mug4HVAPhZZ3/6PMynl7VucBoeEnWnq9HxhW8+lcBj+qqDPmdSqI459ufQoZHtR8H+XGzMecsSxZMPiAsoxxzskGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+jCJn+L; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770674133; x=1802210133;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s0Z970YGRmh/TeStQfOJa3KL8Y6th8HpOKu2nooh62o=;
  b=N+jCJn+Liy+PcBc6EHf6thyq/U5NGQBHVyR1FTEAU7SxrGk4WByl6KYV
   8yi0TYH00hR9kiZXn5GqCdzW1LHKjMikhNaA4Di3T56JwNcANORfNyLHI
   EnOcejkaosUEhAozLAD3AWbhbKV4zdOOwdtOBI1152vfjKMeWocWWhuR4
   ucgc2Pg4CiFOaQZzgePsVOa9ESiJVW6bg3uqPLghhC1wpIIvNsU9ZuuyU
   GG5PA9diuKN6+ubIn616Xqsxo5siJgagsOoxYPCW3o4FeORzbDwJw5zhi
   XxoUJBuH7lE5e+l9hB7RXGclQgJzEeRPsAD+5tZPDyemDZbSkfHIqMTQP
   Q==;
X-CSE-ConnectionGUID: qFQG0MJ/S1mkdjYMrjbYzQ==
X-CSE-MsgGUID: xUTWwvsESDue1PaeHA6cWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="83167308"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="83167308"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 13:55:33 -0800
X-CSE-ConnectionGUID: 4br5JhVyS3ySDz2SbS1Dvw==
X-CSE-MsgGUID: Vv2+beBWTWiCm4zQcBC2/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="215883030"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 13:55:32 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 13:55:32 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 13:55:32 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 13:55:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOH5A5tok97gbiSM8FOc7x+lcvDCxmvFMwE3O4XQL3tGknPPWnQUqXVxcUjDtCo0iqWdcUf9ruRjhVTS+SCJ77ZKc/C6F5TtfObRQavU+5bCR0isxpy8KVRF9ayq24kJkWE/udfn1frBCekO0LGeP+X2CtSZhkWYhp80Ve97eo9qvb9SGpE7yJD70BFp7B4incqTzwONF//qRWmbhsOj48BSGPlqlX7EFRAxRjBqpioUOEcc6gYNHwyge62YF7k2q0lAyYIHuUlcOioFVLsvNM35nl95wIbB9iaAsCqoELAoDMIyNj9YCtf02GNCyzMuGiNi//dOgTf0s180NnX23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owxfN2LpQ2A/88dhJacyS6QGxmD7d2HRGWGGi+uBUiE=;
 b=g2/nBZE+K2KvL37+wBeqhc9MToZJe5n1U+5HOrezyNj65N1uPlc899hiCrUMCZkSv230QiHPGiIK+PCtyFVAGbwf20kHfFL6hIpGKq1Vcpdvasuq4Fwzli649yUb9Cl+bXWYQPDU4vxuvrh+teankZFccxkmKR8H3+vOWhX+jEvhmyV+u1bDe75mCVvJR8gRxS3KauT16gvXL1jWghD/XrkO5U+EEXpFvCKsyYonb+hJw2DrbDoPH/5Znu8UvBg39/OLqkCCKSJ/SyyTcs4Bbifg0wPBetX6IrexTnCfi4CDn9qZxpQdhvReEHWYudSUrIdeaxLlUQMn7qFykR64MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Mon, 9 Feb 2026 21:55:29 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 21:55:29 +0000
Date: Mon, 9 Feb 2026 22:55:16 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <sdf@fomichev.me>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Message-ID: <aYpXxAowNQe99cEm@boxer>
References: <20260209182642.237904-1-nikhil.rao@amd.com>
 <20260209182642.237904-3-nikhil.rao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260209182642.237904-3-nikhil.rao@amd.com>
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 3839f01f-d14b-44b8-ef17-08de6825f09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?alvXBBiKB8x9uF9c6+mmOpkC/ziQUX8Gov9emTBc9z/gDPwcdP6YxEvGmhJ/?=
 =?us-ascii?Q?CnxHiXlhTivA6dwcqRkQQ9zCwzIChcRdOVQAsg4JmXrXKgGjFehOKgwg32bd?=
 =?us-ascii?Q?RQCEt9P/ew0+t33+dd8YET1OVMFfwD3Lbrep9VXFVmlWZnv/Jghf+3NJgaKS?=
 =?us-ascii?Q?EC08ed54GKn0gXS+bgxIhG/fWGLgIGT152zRBlQmAfQR0rLBeXwOmmxNx6dW?=
 =?us-ascii?Q?8Rt1rF9xNM2d4zti+9MUCBXhXHIofbV4dBcpYTwNuWb6nYQEdgUHNsQHEilz?=
 =?us-ascii?Q?YgKXE6T89lpeiaDqCF5QO7XbCNDdInVYRutwN7LnwVeNI3iXHtTldueSwWnA?=
 =?us-ascii?Q?fQ1b2Xqv/Ww92JJuG4e9+/DgQBuap64NSdY3jDhT4wVcpp52VYLQQmkqZfX7?=
 =?us-ascii?Q?5DYGGwnOKimdO4pxzzSJx1zrnXA+giyuf5wy7V7dIy+ER0yqZE9enAg5Bpa7?=
 =?us-ascii?Q?XaDqpoTEvMPseBXvy1zJt6cj0lUL40QN8LvzjOM8aQisFQmmgSLPFe507Fs4?=
 =?us-ascii?Q?VloldVgEA0rh7wdnlDrPG1h1Za/jrp5qCtyyiGcX83C6Oly2IcQLrtcc4Mqz?=
 =?us-ascii?Q?XIsIvIGOqbEh08mf+MJdfk4ERxakDjk37BuDKaU6RYtUISso+P7MAEKApkDK?=
 =?us-ascii?Q?felz/UgAfzQRI8AKLvNKhsa34aOyG2lipDcOtj58DmU76Xn2mTQQdWJrI7vk?=
 =?us-ascii?Q?WKV/CKwb9Bal8Iqk/6mShGrz6dmZOTiYw4lCQkYazmYQvjws61J1UEPv5aje?=
 =?us-ascii?Q?4kMdREQ08bW2oYnCSVR6KaacoVNdTI8mc0Aqcplk68rBv0wuCp3wc9GuYLUl?=
 =?us-ascii?Q?+9XxgEX/K9wkL3ybUEPmYTXaeWsiA/kjP7+7gVC2uezh4w36/kNTUZeVOwXN?=
 =?us-ascii?Q?QdCUXYxHqmwQ4LBFfgFm1oqyuJzCoOCgLEDT+roPE6X7DzdTbA9sEbkvqXn8?=
 =?us-ascii?Q?p8cY0LHNN562v4SQktcY2Isrq/CSirl0aAvJ2tXobSoIMdikWrkT6cSiwlQc?=
 =?us-ascii?Q?1+ZfwSb58Aygvpmt86S8bR07Jttf/bnltADWsJMq4WDtvNh8VWiJxuxSdaUD?=
 =?us-ascii?Q?FpuEg++Rr8namA0V5NBHOxGhUm+MhU1Etybx61f20WVELh/S79gTTogHrbdz?=
 =?us-ascii?Q?a9nYV/+tI8dp/co71i4kLCGIr6oAjan2z9zyiUj7qOQNfKgFumMLijP5T5C7?=
 =?us-ascii?Q?LNqyLi4knDYVnmCFkq7/P2niqEoETlDAj8F2uzBCFEpVR5XWezeMoWRC8l4c?=
 =?us-ascii?Q?uHxwhkcfkgIGx+6t0sj5fKQKTsCCjtO31c32xu9G9nZ6E9QnZuG1uVMUg4yS?=
 =?us-ascii?Q?JkDmoHfBeZbOSKaAUleeZ9XS4J6+5U4PNUH36XZ/VjENqjIu/YVQ458ouyhw?=
 =?us-ascii?Q?SBF0KD8xKGaslIxEn2JYaZUTnWCWjgkxXZYIQci9WyCFHnNP/gfG7z7EEDZJ?=
 =?us-ascii?Q?U6Chgg0JxQd0OEfzYuGmHCQOfEh6GllsN/NywfCmAPBJ/pz0HUeaLNRclxpV?=
 =?us-ascii?Q?jbs0mynL6RcInZAh++47HmFjxSdTtfcjGCWFkhiM60stCdq1xfBiVX+XWOJc?=
 =?us-ascii?Q?r3u3m+KqaA5FR6ETqU0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C9KlDFK2Fh2r7UG1J+IBgPu+OnWyOtuxfiZ6jEiP0IWAUt9+0BGOmYzemcIL?=
 =?us-ascii?Q?wMBtez/9ZXig9l9A6bbuIj65cJHMWOyOedKx+rbkuiX9L0cp179gGSw5sIkB?=
 =?us-ascii?Q?0kMGWlKBtDxmBebsdkm+VkPhz67ptIM7IA8l2EbZVyT849Fzzsq3r//YdLvM?=
 =?us-ascii?Q?1QBOlPOtCuI3MqZJCY/WwSCBxN1EsVO47SXaXjzk85McXSSFOgAY7nYA68wK?=
 =?us-ascii?Q?aCVy3s6Own4DOARVt7Jz4Vf+bfVncb4ejEEAsRlpvaYM5onzmPCQ/Qs9gPNi?=
 =?us-ascii?Q?368RwkvfGWJPSBlvXZV1LuUP9pVxkal5Cg1yA1UYKnzvVeBDDpTV5iXmtwhV?=
 =?us-ascii?Q?c2Y9Tv5RUfU4qvwbdp30qeQXfvGUQmVB4ZVXfooPwcpHsmpfGWUpOj/NcGFH?=
 =?us-ascii?Q?1/wJXL78pSMgicO7uZlNa+aiAiyo1Usd0LHyvYtWTBrv64BJUYcGsPnTUKlQ?=
 =?us-ascii?Q?2BAINwq1PgiwKSP8lTdqTyqmnWO77HJ/Ug8ngsOZ/3kq/iebNR52OJWW4dyQ?=
 =?us-ascii?Q?S6AhTR/A1v/p5X6vncFhrR9ih5rqSC0oNCI4vHLfEGue5kuE6q39eY0bmgLE?=
 =?us-ascii?Q?aZcXqjsoYEc2CORMNr59DwvNooJR5kKvZqmhhFJwJ0rr+8praaTJAKFmOGCP?=
 =?us-ascii?Q?5eLN09PgC46DzhMBoWVjUvXSbYfLNxHOMFpcOB3jQCY0BZj+Va7tQmllqWGL?=
 =?us-ascii?Q?3X1p+C8LB4PSHHSnLhLGXjMnP1YjEW+PnAsKHEm0LS2pwZ4Vcp8JPf3eYBAw?=
 =?us-ascii?Q?zMqUFU4bNdFmlrRfo7XDpGbFUIWMHOrM9uhSLG31H7gQ1x3KsALYib4ZEuBe?=
 =?us-ascii?Q?ozZbmt4JmALYEADmGYUfHt+B/xPGZE+cNaSq9/aYNgb9JSxT7qYYXBBwlX0N?=
 =?us-ascii?Q?Kw7Vu1AeXg2Ses9s3UkskZUnqu0tHaSHr5UEztNFXVM7H74bpLWxVg4VqwCr?=
 =?us-ascii?Q?04TO2zS9bkqIPGnJcRfFIx12y9OSA3mBQrrcTwa/YiIiNIyOjNYemYVz9Z5c?=
 =?us-ascii?Q?2+gUDYC9AJjRQqXxQEUy+bEc5kaUYWHTmPyhw+hkage2NY4grV/AtGRKUBhT?=
 =?us-ascii?Q?OXfBYjzLwnWhK/J9XqMGgTNcbnGA/BiyXJasONGLRbtxDlPEdcsHu2bT4E45?=
 =?us-ascii?Q?kg1RpTX8AH6TUdj06noFqwbDHNjWHXmv3PEzVo1d7pYR3GDWQUr77Pvp/n9A?=
 =?us-ascii?Q?9gcj9MsG3JUkJHDaZpFm29k2P0v4EP/I3txS00eBecsho2vN34WZhLMLklyl?=
 =?us-ascii?Q?CSpLuD65H2YqLm3VkR49W53KU80k9MNGVdOrz06N+SMFEfIpql+8eQjk/VCv?=
 =?us-ascii?Q?kq2MrgNTTqdaWrADrH1gSqEt5KY7449BjCG9kwx0OizazXiZUP1872/iN3IE?=
 =?us-ascii?Q?OgM47ajcXTYI/RjAKVG0ja6rk2WN1Cu3yu47TcqHgNrAVwhdVKtwmMnecM/c?=
 =?us-ascii?Q?TdYZxUnwdRxc5Q0nGfcgdfusVpl3BdHdkh7SIvZ918maD0lmBjzs05pZHWZg?=
 =?us-ascii?Q?L+almcuTprOgt71V7+yRJNy4pdJq3eDOIZNzyN+3FTBRQU+K8jhM5WXP4sHH?=
 =?us-ascii?Q?xolR+jBmkNp70RzWuI+dnxIO43N9iTNFLF5r2bdZhtKvczq/T3wqYl+aTa6U?=
 =?us-ascii?Q?dVUX92OGQAZtzQ6cNy4vvAfXjIUwFQ5eyQEJuTdhS8P/BSLQA+YzhoEImn/Q?=
 =?us-ascii?Q?o3rEw6F6L0KggwyVwrcO0Rpx2ttOdQe0bCGcv9U03byG3tW2tvRU1OAgZteU?=
 =?us-ascii?Q?+A6fdjPC1SBtR56NyILl4/c9rKnFYqA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3839f01f-d14b-44b8-ef17-08de6825f09e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 21:55:29.4475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftTwHIufc+rgSJApKbDY8VUjC5jtOKOJh3bRT7lSUYBEwSi/OOizOwIircIpSLao8g+t3McaB+jljC+p6SKEr2Bcq7tnR0oEKrZNTXPi4PQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257990-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,amd.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 23F0F114F07
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 06:24:51PM +0000, Nikhil P. Rao wrote:
> AF_XDP should ensure that only a complete packet is sent to application.
> In the zero-copy case, if the Rx queue gets full as fragments are being
> enqueued, the remaining fragments are dropped.

All of the descs that current xdp_buff was carrying will be dropped which
is incorrect as some of them have been exposed to Rx queue already and I
don't see the error path that would rewind them. So that's my
understanding of this issue.

However, we were trying to keep the single-buf case as fast as we can, see
below.

> 
> Add a check to ensure that the Rx queue has enough space for all
> fragments of a packet before starting to enqueue them.
> 
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> ---
>  net/xdp/xsk.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f2ec4f78bbb6..b65be95abcdc 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -166,15 +166,20 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	u32 frags = xdp_buff_has_frags(xdp);
>  	struct xdp_buff_xsk *pos, *tmp;
>  	struct list_head *xskb_list;
> +	u32 num_desc = 1;
>  	u32 contd = 0;
> -	int err;
>  
> -	if (frags)
> +	if (frags) {
> +		num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
>  		contd = XDP_PKT_CONTD;
> +	}
>  
> -	err = __xsk_rcv_zc(xs, xskb, len, contd);
> -	if (err)
> -		goto err;
> +	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {

this will hurt single buf performance unfortunately, I'd rather have frag
part still executed separately. Did you measure what impact on throughput
this patch has?

Further thought here is once we are sure about sufficient space in xsk
queue then we could skip sanity check that xskq_prod_reserve_desc()
contains. Look at batching that is done on Tx side.

Please see what works best here. Whether keeping linear part execution
separate from frags + producing frags in a 'batched' way or including
linear part with this 'batched' production of descriptors.

> +		xs->rx_queue_full++;
> +		return -ENOBUFS;
> +	}
> +
> +	__xsk_rcv_zc(xs, xskb, len, contd);
>  	if (likely(!frags))
>  		return 0;
>  
> @@ -183,16 +188,11 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  		if (list_is_singular(xskb_list))
>  			contd = 0;
>  		len = pos->xdp.data_end - pos->xdp.data;
> -		err = __xsk_rcv_zc(xs, pos, len, contd);
> -		if (err)
> -			goto err;
> +		__xsk_rcv_zc(xs, pos, len, contd);
>  		list_del_init(&pos->list_node);
>  	}
>  
>  	return 0;
> -err:
> -	xsk_buff_free(xdp);
> -	return err;
>  }
>  
>  static void *xsk_copy_xdp_start(struct xdp_buff *from)
> -- 
> 2.43.0
> 


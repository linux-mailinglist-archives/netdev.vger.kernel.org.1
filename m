Return-Path: <netdev+bounces-168683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDD6A40299
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAFE3B8811
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18160253F3E;
	Fri, 21 Feb 2025 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5v2LttN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E33253358;
	Fri, 21 Feb 2025 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176582; cv=fail; b=l88z56CEMRDoHHU9uqZqtHbOwglQ4EbDrv7DDTZALjSjkq9Q2q1D7hAskzdwG020ZubwleeklVY/QQbFwvl6Jw7jKXPcjdfgVhs2G3O4O4BIn24ZsbdihFwvKK3Tg0thKofNE5spnjO3JlPjaGXD8DGk0kq/K+eksblaodhQ74o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176582; c=relaxed/simple;
	bh=pje060e43ZWi8kvbw2ZtdBNwQjkyGMglQj9n8rKn8sA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o81yYoCwLLv9PQmpZoGRe64DwArEqxsg1sOhCZ8S7pP/a3L51j2k8KFAKRjrZdqeuvpOieQQ/qQ3M7UmN027/JlS0qB/cDFW9Kdvmqm7GH8oBTp5gIrcSalnovTF1yA9I/qNipR2cZy/kyI02MVuzRrZkDMLF0QpyhJOxFzfugk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5v2LttN; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740176580; x=1771712580;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pje060e43ZWi8kvbw2ZtdBNwQjkyGMglQj9n8rKn8sA=;
  b=M5v2LttNwtNXAWfme1AB8TyPfFIXBem5wyUs8qZOVS9ljGmGNpL6OkEp
   qEwZJ8tbnLL3pziU8KEXzwkDM3yl3Jml9EkejGK2z7r7m6N4pWiw1CRfg
   OYzu1Stqym/t0PUEwDBZOib+o8m2LQalWHjH94XjtBidqkOwBEKzjrqz/
   dbiUfx6ReueI/pJuRk3x54ViR1SC6+XPi7+/mGrWoU1YYXzBpdEr3vAHe
   QLzoYXhrIm9AbHDskDtZqQ3JppmYJHx1R/H6M9izJ73BAdHXYkyC8pbXC
   MGV0zuE2gMrS/UlE9z8AuUMxGWch7jUHUoeYfc+D8Sl5ZKeas7QG1NyvM
   A==;
X-CSE-ConnectionGUID: sAAQNdvmT5eb67XNnpsDHw==
X-CSE-MsgGUID: /1mwDZdTS++ErZsH3akqHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="28606898"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="28606898"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:22:59 -0800
X-CSE-ConnectionGUID: WWj3lycxTcyNNJUmwLr2lA==
X-CSE-MsgGUID: XPfET5XoTIy0fpYSjuQ8Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146381841"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:22:58 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 14:22:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 14:22:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 14:22:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brQhmWkE15Jxmfn+o1VB/n2wcbJc2dm1vREbW9yZ/EoX5XaW+gFO1vJsb+HYagHxaebV73/zMimmD2/0LYNDt/2Mr+mqROJ9zBEYPp7xff9Arkwk4OZQhntdqHo5INv+Fmv3BkI8sfR+6BZ4fSoZyl0M1WNx33Lhyz3/sY9wNpb0Pcj1l5g+sRUyvfVYPb3Kh1UWdNudelXfIklSACNFxIftzYXnNcbeDNq3IfRbaYRliv/1AZYrxYmVf+bvfqeXcd4uvLJ/7T2KXE+YbbxiiWXI/HqjrRrxux+plb2QuldSj744tHcvlWnbEUQIRfI3L/LF7QY8O5Vvnv8zLeVgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iof7+zPLC4l68j8HAVnMxNHkCFnqbYpbounMTIrgYj0=;
 b=hsStcCyE+NGQ5m4+yiwYEri8OFy7h4HT0wjvc8cSeJzJWqa8hwirocaZhsplloLXriO7FFendVmBG3x2dmD9kIbqmRvDV8T62hLyCkQJyrmzrHHj9/GrBWFlZ9afFP8Lb/OnpySKsgyutxZwUrRj/GRYFzg8fVhSiuV0whyt3PjMwZKqFJxT5pPV4UiuTeOZMZuXmPb2kmieW6yVdJkNomf8JgZCTOiaiOD/0MEptP2NXeXFbXM7QMRu4SD2oWdObAgsO65o/GXxXJRssqCrl04sUsHD8a7mjMcDPep3y5YAK9Z8q6fSgvskqTVHbtUzoKTizXb0q5WnnfiVk+FdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 22:22:53 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 22:22:53 +0000
Message-ID: <a7e434a5-b5f6-4736-98e4-e671f88d1873@intel.com>
Date: Fri, 21 Feb 2025 14:22:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] Fixes for perout configuration in IEP driver
To: Jakub Kicinski <kuba@kernel.org>, Meghana Malladi <m-malladi@ti.com>
CC: <lokeshvutla@ti.com>, <vigneshr@ti.com>, <javier.carrasco.cruz@gmail.com>,
	<diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250219062701.995955-1-m-malladi@ti.com>
 <415f755d-18a6-4c81-a1a7-b75d54a5886a@intel.com>
 <20250220172410.025b96d6@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250220172410.025b96d6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:303:87::11) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|MW3PR11MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: 1031bd46-2edb-4f53-1110-08dd52c64890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mlg4TmQ5VUc1bTR1OG82aFYvb1B5TWhpcnJadEphdEtrWk83bHNkdUdUSmlo?=
 =?utf-8?B?eG9tRkk3dTh4Y0pzU3BCYk5JeXJDKzlaZ0FablNKOHlaM2lucUR6NUlrblJ5?=
 =?utf-8?B?bW9GNHJmb2tPdHd6bGdodWVPc0FicTh4c0pZL21UcW1RNm1RQzY2OXdJa2Qw?=
 =?utf-8?B?L2VGbjJtYi9tTUJOTmo5OVBZVmF6YUU4bTdDcGhQU004akpiWk96L2M5ZkdB?=
 =?utf-8?B?QlQweldoTHFqaUh3UUpyR1VWa0VscVFIV1hFdEU5bE9DSmd1cCtWZXlsNWlB?=
 =?utf-8?B?WmhCcGQ4UmtXUlRpeFpiUC9yY3VBTC91Umx3SVQzeVdMY0dlVEczcG9yV0pO?=
 =?utf-8?B?QTZsd3JrZ2taUjY2VGR5RHBMaExmeU1SYWFFOVFqUmZjT0czdTF1dnBIZkg3?=
 =?utf-8?B?ZUVoK2NvTmJneVFNUDUrZm4yR2NZYzIrOHJVSC9IQTc3ei94YWFIRGkzaGJL?=
 =?utf-8?B?YzQ1TnVoZ2t1SHV4RCthYmpBSGFkR0RRMzg1SU1MNkNpbS91N0ExWHh0bENr?=
 =?utf-8?B?a01NVE9ISDBZWVJreEk3eXFvOTFtd2hxZUFJSUZNVXZtTGV1c2FqVkhONjVw?=
 =?utf-8?B?MWFLNXMyNjlCbHdiN0ZlSFYrVHlNbHlEcHZ0eCtrdjNCT0I2TVhEQXppRjl3?=
 =?utf-8?B?U3oxRGZDUklmR0lTNUF1WU9ET3R1Y01td1hmaXdXTTZDRTdmVjBMelkwTDlm?=
 =?utf-8?B?ZURqUkxSVEdsbFhlcXBFQjVwS2hvcFNhRmEza3RSOWM3TXFvZXFxS0pqWjdD?=
 =?utf-8?B?VkVsVXV4UGVXeXJIREVsVWpZYTFNckNOQk0zYUZRK0pKVFZzaGVCTG4vNkx5?=
 =?utf-8?B?Si9JeElVc1FDQWgwalNWbmtyMHRxTnZWT0VBRCtTMlFlNHN5azQ0QmVuTU1h?=
 =?utf-8?B?NTc0NmFXS3Z4NEg4R2tUR3U2Z3BKOHBJME81a3VYclBsem4xVDFsUUI0cmJW?=
 =?utf-8?B?dHplWS9FYzNwN3pwSVVzUmdTaFlwTGhTclNTWU5DdzlpOStKWVl5MjliT21v?=
 =?utf-8?B?ZzVXUlBhb3JSaitFMHlqU0xvS1o4S05DZFQwMEVhYnpwVXpFSnNxTFhMVTNI?=
 =?utf-8?B?MmJ4ZkRYSGp1bG9ONVlnQmVqd0g2UDJSVnBxbVQ3R3I2VTVNSXNUNVVoL0Rk?=
 =?utf-8?B?NmpMS2pxSDhXTG5OeUEvYjdCNGlvVmt5bWpZM21tSHF6a2t6c1RHMXFtN09X?=
 =?utf-8?B?OWxtNWNnajhsV1VRYUtvc3hBQ0YzdEkxSG1sdVo3QlpiSTJvZmtIQVV4cTcr?=
 =?utf-8?B?QzdZLy9GV1JSeXdOd0FvckNVN2RJdG5xUGR6dEt4Q3BtVnltckYzU2wxVGRJ?=
 =?utf-8?B?M3VEVGRVRGY1cUtqZzNsU3NLZUtyWktHZVA5NmFkWmordTNIREVhZmFCbFBG?=
 =?utf-8?B?eWZOblNjM0VKL09hbGh3OWhPSmlQZEgrYnpEZndtcGlBcEgzS2dlbHJzVFNl?=
 =?utf-8?B?WGIxSm8zOUJMdVgycnU4SUQ2SEdmTyswZFNYQ3FBWmhpV1JHS25zRnE4T0hj?=
 =?utf-8?B?NDg2ci9ieXlLcjd1cmxPRktCWExreGZnRE5XUUFFR25MMXFmYy85VDB2YklU?=
 =?utf-8?B?NXdjdU0zZ0FTMG5PaFpZckJuSkovdktWOTlXRVZjRUQxTkpiaDJvV05ITHQ1?=
 =?utf-8?B?NmRXMzhIMTc1NVRrMGgyYWQwOTN3TDd1ams4UEltQVhTRFhiWlYrOUEwSFJI?=
 =?utf-8?B?OFZQV1pQYyt4NWRvUmlpdzVDVTd3ZVE0MG9MazJLeFFvNnJxNTBBQlRzbDFr?=
 =?utf-8?B?N0pLOGE2WkNsN2xwdGcxTWJKZWEzWHMvRnJ5TGVkY1NBbDFWQjA4TVNwUWN5?=
 =?utf-8?B?OTd5ZUQyQUNoMDFJQ2xMbHRyc0x6Ymsya3h2RVFSeDZ1eXpJTEJ6VkFrcFgw?=
 =?utf-8?Q?vrUB5cNdypyJr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUIyV3VHS2FPcjk0aUswQWltQVh0SHN6QUhEMlcyZzE1UFBUZE9MUTFwZit5?=
 =?utf-8?B?cTdOYXEyTnN4eFhhV0tPL05XNHRoczN0dXJTUHZ3YUJzaGsxUXpZSE1BZWYy?=
 =?utf-8?B?L3Jta0pad0Q1bzkrekRDcCtCak5YdUpXcXlTWG9XL2hBSDYrbDFBZ3VKZytO?=
 =?utf-8?B?cjFEdEdYNnFTeXhtblhqRmxtUXNSL3BYak0yWVZLODF0Q2JORVVhT2dUOXI3?=
 =?utf-8?B?SjlRdkFTYTZTN0laeHI3Um9XamRDc3dtV0hBQ01MVGoveWx5bVBsVnpMWU4x?=
 =?utf-8?B?OE1TaDV2OHlUYjE1QmRxYXFYQlBVbGwvd29uQXhjcnZ6OUlaQnFzVFVHZkFa?=
 =?utf-8?B?V1VVNzVIVy9YOHB6NktCWHNaN1JZanhVUnBYTVVwSm5FQjg1WGR0YVN2ZlY2?=
 =?utf-8?B?dGphenV5c2ZKMWFFb3Z5OThKN1Q5V2VGWXFvTVhZUWsvUGpNN1VQL2k5U1hQ?=
 =?utf-8?B?Q1poYWFDZFdwZVZZVTV6cmRtNHh0KzdNa0VXWDNMVGpxWWl5bEdBVG5iYUU4?=
 =?utf-8?B?dFd2Vnh2VEFXTVFWUFZ0TWpGZlBHNWRoVG5tcnE4c2xqaVhhczVpc0tnOTZ2?=
 =?utf-8?B?eVc4V3N0dDBRTGtIRHdEanJoYUpPb0RvSVF3MkZrVFVLZ1BPTFV2S1JraHhq?=
 =?utf-8?B?TFJqUnVvVXljQ3BqSDd1ZUNXQ3hEdXhKZlNBWVJuS29hYjZKYks4WXJyV2Ra?=
 =?utf-8?B?VnhTTHlvcUNFcHloZ25OUjJGb1ZtZDZnVWprc1MvanAzUGt6MVl3cUtHVnU4?=
 =?utf-8?B?VUk3cEJQaXpSSG1UbUgxMng5ZGRaNjFNb0t5VXkzdHdMWkZuWmhlcldJNjQy?=
 =?utf-8?B?YnYxYkVBUTlxd1R0b1ZNZjljbGNadDQ5WVhtQlRYdk5EbHB5TFVRQTROQUJF?=
 =?utf-8?B?cWRma2J4bFdUSmxTN0NNL0Z4M0xJWWZObVFUK093SGpWMlJLZDh6Nk1KcTRh?=
 =?utf-8?B?Y0ZQcnprVUJtc1p6bDczaUtkdnB5SlozdCtkNWNyeVovYXdNQnU3ckFWZE1K?=
 =?utf-8?B?alVSQWJjV2p1dzRYS1lOTzlHdVE0RE9rM2pqZmNhUUU0c1NBcEJoVitQNG1h?=
 =?utf-8?B?S1pWUzhCN0hMUWZsT3AybEhxRks0QUVCdFJDRVBkSDFTcXRyMTZVaHFxelhY?=
 =?utf-8?B?Nk03ckNkeEpZZWJaQU5yaHFOUTZXRHFaQUxJYUNrSmtqSFlnSXJnU0wxeDk2?=
 =?utf-8?B?dTJuMjZNWWk5Z1l5dkZHS2kxRyt2WW9kTGpqVXdtNlZsRzBsWE14a2o2MEI4?=
 =?utf-8?B?eU5yLzJpcjdWZFlqa08zbm5qT0FhUzNZQW0rcFVGL3hsZC9SVnBGTXFJUElR?=
 =?utf-8?B?LzhNcDg0N3FvaUFGL1dMT1pLVFU1VWlMdjN1eCt3YnVCVzlTQlFuKzZhcmc2?=
 =?utf-8?B?VlJnQlpPWURmcEJCQWV4K1BKM2xZcWNVRGFHVkJ3QURyc3lCMVdNQ3doZ2ZH?=
 =?utf-8?B?aVF2K1RJY25LSW1KK0twK0ZhRlJlb2MwN0s2QUZaV242OGVDWG5IYXBCeDI1?=
 =?utf-8?B?bDV1THlKOCtKbnN3eGxSaHg1S1NDcmNLUTh2WkUwaUgwK3JKclpzSk9FQnJs?=
 =?utf-8?B?SmZTQU80SEhKWUs3UElldFRPRTNDUnNtaVBWL3BxUFllb2Q3UlhZUXljSW1P?=
 =?utf-8?B?R3dqbGJIQ29iMW5WNHhwK09mOWFOSDh0c284aHFNdUIxNXJQVm1JS2lmWEhm?=
 =?utf-8?B?cW81aElHbHBPeG5vUjhoa00vMGFLcWVxTWtqMlNBd0t1ZkMvei9TSVpWbEJy?=
 =?utf-8?B?K0JqRWdub2wveU1lL0l3Z1VLMXVZTDBwODk1Y0xlUnFPNjNhajlwcTRyZTFG?=
 =?utf-8?B?THphaXRjYlhwTzVSOU1iQno5NUNxMkg0citTOEM4WmdKamF4TzU5RE9xaGtS?=
 =?utf-8?B?RUJOWmgxMHkzUGM0eUJTT0lzMFNtenhsai9LWkJEdm5oTFEycjl4TFNqcTQv?=
 =?utf-8?B?SStBaUpGd3BRNDUzb3JrdzhTYXdGc2lrTXJKZmV5T1YxaGJPZGVtalBvZXk0?=
 =?utf-8?B?T3dnMkJoUUt2aFJseUpNS0crSllIZDBtaGZiMG02ZTB1MTRwUVVJbVRpQWw0?=
 =?utf-8?B?Q2dpYnVha2QyM3Izem03YjlWOUJueGNwSHFhVG4vUGpZNGlmOUxSb0VGQWxY?=
 =?utf-8?B?b1k0UTNFbVp4bDVRNUxtUllydWRjQU9zTlBIaC9VYlhKZEVTVEJNVW1ibFBj?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1031bd46-2edb-4f53-1110-08dd52c64890
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 22:22:53.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pv/VSnsMt4e822xt7lp8ft3QvuKB6xZOyeZ/cPywwSPToNTwL26a9cZgytY5Py1Zmki7qWjoDH3Z7DndVKIyBB56p3jaTtDlrrJEXS46cI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com



On 2/20/2025 5:24 PM, Jakub Kicinski wrote:
> On Wed, 19 Feb 2025 15:37:16 -0800 Jacob Keller wrote:
>> On 2/18/2025 10:26 PM, Meghana Malladi wrote:
>>> IEP driver supports both pps and perout signal generation using testptp
>>> application. Currently the driver is missing to incorporate the perout
>>> signal configuration. This series introduces fixes in the driver to
>>> configure perout signal based on the arguments passed by the perout
>>> request.
>>>   
>>
>> This could be interpreted as a feature implementation rather than a fix.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Agreed, ideally we should get a patch for net which rejects
> all currently (as in - in Linus's tree) unsupported settings.
> That would be a fix.
> 
> Then once that's merged add support for the new settings in net-next.
> 
> Hope that makes sense?

+1 on this direction, its important that the driver does not accept
configuration which is incorrect.

Reminds me of my backlog to refactor this whole mess into a
supported_flags field in the PTP ops structure. Maybe it is again time
to revive that.

Thanks,
Jake


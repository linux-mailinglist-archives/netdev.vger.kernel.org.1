Return-Path: <netdev+bounces-265383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJTlNAFsrmkvEAIAu9opvQ
	(envelope-from <netdev+bounces-265383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 07:43:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D23E234500
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 07:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EC6F303457D
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 06:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE413612E7;
	Mon,  9 Mar 2026 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdRIRwK7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767B31077A
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038563; cv=fail; b=nRc2AoZl8ReLLNkTcQ3N9eNjeXoFKdiwp9pqFDfYEyGHjGs8XMQrYgZhiSnxAQmPZ0k7e+FJdU7kVunv7nhIiscFPFNe+xuSpgCpZbmtz7pYbQqEh7ulw7UiJxngTX6B44idPXI6tJjcfvAF5p2sMFS/hfpa6Z/LmgF+LNI/WKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038563; c=relaxed/simple;
	bh=t9NAqrSbAr6oahz9nZkuqhW0OnLsUPQ/hEci4MxMi9Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lIhrE8kPSV/H/gaUdNLZda7z43lBFXsEgqcVRO7JuQmBrH3VtvSI5kVdUP3d8pGY5WAXrT97NMbAMNtOOUXm7grNW5zaW1y6+V3bVCwQ6ip3zMd/2Emkm4q148coDjHg/lipJflpjy3kWkpjSLXbm5GSud2XmX+ZRMc0m9bpK1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdRIRwK7; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773038561; x=1804574561;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=t9NAqrSbAr6oahz9nZkuqhW0OnLsUPQ/hEci4MxMi9Y=;
  b=NdRIRwK7fN13VPb8iPo6bSBkfenOHz9UjBeeB2vWNZxwZ6xhrgaVhtL4
   z+BW1JLwN1+oiCRNEH7hvuy6bVbLffbkKe0Dv9yvRs7a2qCk+MjJPgdq3
   xbNqhSYlxVMZxuYR4RkyaCuuZHp1CHZeoUbfRr4+huWUCmFbzTem/eJN8
   R5Sy+DRf0YSogrsUwk21BJyOWr/9i3Z44dkBUl0bdLQVujxPfrWntE9Pc
   +9tHPhFhpnqDTmzNhzq0Z8Ewo0Jp/C3VwuQEbkWzGZrTuTEuUwSfKSwfD
   L30ctVnp8/BOU1KEEyHit1cmUHM1Kk0Ei+H+XCCSIrpc3O27jyEfao56j
   Q==;
X-CSE-ConnectionGUID: CmjfJs7ZS06q86iSlJaiGA==
X-CSE-MsgGUID: 1TbqZDezSdS3WGOI0GYmYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74100045"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74100045"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 23:42:41 -0700
X-CSE-ConnectionGUID: 5eRp7UQlSwGs4mXGTIxenQ==
X-CSE-MsgGUID: L1VjxK6oRCiT3Bi6VqJsBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="217733486"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 23:42:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 8 Mar 2026 23:42:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 8 Mar 2026 23:42:39 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 8 Mar 2026 23:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCuzjS0zX11/sSz8q/x5xNoGi2i4/Kj0DT5pUXNKKg42tV7tlpYIdISmiyWTeWtgIwvpqkdU/S8D9ZkLLoOLJ4HgiIxnDE5187HZ+3eGGipfLTiDJPPrwv81GDLUGxD7qeWBZUL96coGzGqL2LVYIlD5RmxQcD9bH9WpBNVirTK+errMA4gKzPdWKXsJgPRLhedjNBSrgP8uRzG9z4FL4Ye3k/rTpq6IJbK26vGNPI7v0/wEa02nRoetCoBOzz9Iyt+WwNp2FJcdfXxRowVfIBMlzUh4YIl0lainEF6jdW4rkgkq1W5Ul3TUw2CNsPMHauNNbjM3XxkNZNMOnu8VGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+3rAgdwY10R2//wMFoylB0hCAfDsTJ0n6lBBvlf+N8=;
 b=lLOjlFS7dVtdRxD2Ogj3Bf6PcfMaVE8rRF3wuqyZrNkG3a3Z9UhKDqY2m6deAE+I/ENKo2Y+FDu2VTmkA4WQNJZeyPrqPEOSB2m2NH86AHZpmnhrF3uASwcLaxOKsnBHfgTUBecELb+JeoP70eNwKcq8m/hSKcMU/MwjGqQPicClhhGYkxHR1FSAegv6PIwsIvLPRAbsQgVa2GSNp8UPCXn4jUO1dO6F7HBdBp/mvIfpB2LcDcTdXr96CQDwQATgYaK68jThNOA2VXxSKu78pSwbnk6xG8roeDpA41nFaaMIMeYsqUwz0yVHhZd67MEbEr4SyP+LUasH7fp0/mxaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4033.namprd11.prod.outlook.com (2603:10b6:405:78::25)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Mon, 9 Mar
 2026 06:42:37 +0000
Received: from BN6PR11MB4033.namprd11.prod.outlook.com
 ([fe80::2c28:2983:2947:24b1]) by BN6PR11MB4033.namprd11.prod.outlook.com
 ([fe80::2c28:2983:2947:24b1%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 06:42:37 +0000
Date: Mon, 9 Mar 2026 14:42:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [linux-next:master] [icmp]  64db5933c7: ltp.cve-2020-25705.fail
Message-ID: <202603091409.866c520c-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TPYP295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::19) To DM6PR11MB4044.namprd11.prod.outlook.com
 (2603:10b6:5:6::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB4033:EE_|PH0PR11MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: eba506fb-39fc-4fe6-9355-08de7da70ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: f+r8SpFUaddnDiZtjIof3E5cqfwJorDKWHqy6oMBccMGveV6ipqcIVnZ7KQRg+dDyRdaAFrcuucpTuvRwNPEJBoMtxvMMstr7hRnSsmYuJ8WqOWJL2Bvn+9MwlJLmbR25a4uEM4Rb5xsnBuf2ZeQmcyKuPJAH3spYjoL1Uvw9WlKkRXH+V7Xw0vgQzXgGBqbXuNDgznBYv9bOmoQGQ3mrzTMLrvYwpDQxqSo720xsZrpOp0s9SQ18P0ukR/la30O/qe0+umGbc11wc8gk40szbScNAaOm3zxKM6g7YvU3+BzQC9CGzQgw7UCdUsGBqHpoTdCscdnYsTsekp/dg04bgygslww1oiNMoNN9gNmdlRFQ6xSEWtLA23Nk4OsdPee1wjNd3mXUsv99knVyAjkmfB/Lz+EKshFKkXJL6tKowfwRWfyqol6YisCbN0Os48zfgxwYmpJ7cJv2kwSTAXdP9FYMsWOK+5bjuDAaRXcsQQoYXMEGAr7GDDqUm7pjrGI3HGfn3uew2qv/3PewnkjA7Mfsik0MtG8JykWeCXarBCG7xuJh0GFg7O1p8ssB53y7UIT9aBXIiyUyAtwl3871orltiV2vI2bZYDECH9fNvIBno7ugTP0bCEwQq8z9Qzv3HpWMZNdJGbT6P5f5Chfz6Jo8scGgc7tTj9SUlRQRDj+A9eBUxDru2dEejgTEeKJlOBchIUVT3D1cBHOhqbwRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bERGYmJWaGFEQVhVQzZhMksyUHpVVFczNzRDSFdrQWs2TW1XWTc4M3dla1U5?=
 =?utf-8?B?L0UyM0ZJOTFrMzA1VnFrMUpaUVZMZktTdG1QdVVrN1VMbkQrdGRqdmRuVDlX?=
 =?utf-8?B?T3hxQ3hLYWZDUy9jOWl3dngzS1hkaVZiRFhQYUlZVHVLUHJMRmI1dS92K1l6?=
 =?utf-8?B?eWswRzFwK3BiT1JzZkphN1Nncm4vNU03R3h1K1ZybTlUTVo3K1FIcE1kR2Fo?=
 =?utf-8?B?U01hTkVNODFxZlRWRXdpUkszeGJRN01vVlJNYlU2VmFuWDRiR2FxMmpocDNi?=
 =?utf-8?B?YmVQRUxxM1BXWGFJRW5YTWdPTjRkbk5OOXExaHYwbW5Yd0d3ZFp4NXJKajJx?=
 =?utf-8?B?ZVNqcVk3MEZEbFVXYXBHWEVDNkR1UHMxSHMyTEFpWVNHR3Faenp3QVdrM1Za?=
 =?utf-8?B?Zk1jbW03SDVWZVYrVHRSSEh3bFQrRy9Md29EekJXcGI4UHJuSUdaK2lhM21X?=
 =?utf-8?B?OERiUGJGSDFmYUxjeGVKTGdERXVvVEtYWUdzOEZsMDBwTWpra2hJa3VORmNX?=
 =?utf-8?B?R3ZLaFl3eUVUVTltaC9jUURMN1E4N2syRnovVlpYL3NIaDZ5NFJmY1ptMnI2?=
 =?utf-8?B?MExQU016WTBmcCtWb1Yzc3ZqWlB3aDVDUTl3eFYrN2s5WGVYMmdtMDNZZktD?=
 =?utf-8?B?TFYwd0cyT2xtK21IMWtOcTkxTEN0V0pVeWpGbnM2Ui9QdW81a2dLKzBDdlVS?=
 =?utf-8?B?MlhGbHFlL1hrQUdIL0pJMUh5eGw1UWVrTWxOQUZWMzMrZG5XbjVoTC9YL0gz?=
 =?utf-8?B?M3YzZmczMGlINnE1TVB5S2xveVR1ekI5dmFPdzQ4Rkw1Uk1mNEtDR2ZETXdn?=
 =?utf-8?B?SzdhZS9obWdkcmlsUDRyZkZ3YmFnbEkzdXR2S290UkZzNm9ZZkw5SW91MmRG?=
 =?utf-8?B?bmhxcnlSMmFaY0pKYWZGZjd4T2QxYUV5YlVXRHE2UjdWY0tqVHFWbllFU04z?=
 =?utf-8?B?TGk5NlBMcmZsYlNtWXluZHZiMnhvc3N6Rld0RjBVbzR3ZnR5SHlvZEVycVdx?=
 =?utf-8?B?bERoN0xxYTBiUGJMZFJYVTVEQTZEaGx5b3pJcHRYMlRWc1daZThIcjBpR0R1?=
 =?utf-8?B?M1FoV25TZ3RVNTlSZ0wrclRwK0RYNjZnSEpJdnY3cDBaMjFXS1Zzc3BsNko4?=
 =?utf-8?B?MkxUK01WZzlJdlZZSHM3Y2o0UEtOaE9pVWI4RFQrNHVXN0VYM1FyQmdza25q?=
 =?utf-8?B?OFg3NGJEQW9HQmJobzJtUmY2QXNvRkpTVkt2Q3c3MnBVOVZxRFh1cHlpVkY5?=
 =?utf-8?B?ZkNYRmJqUnVWbkJIU3BVaEVGN2llcFEzL05GVDkxNWplOThJZGVjdnNRNVZi?=
 =?utf-8?B?ZzdYMEd2RUkrUGFHZDJlbS9hckJpZm9ueHhxMDhZNkQrR25ZQWxmQmVpeEFL?=
 =?utf-8?B?Mm9Yb29wUVAvU2tnc2lkS2l5TVZJQUVTT0ZiOGFxSjM2T1BiZXdZdVMxSUZ4?=
 =?utf-8?B?MW50bWdhMDZ2bXlpakF0NWxPOUNQSng2eC9rVGRZTmRGMDBzdC8zZlRPajcz?=
 =?utf-8?B?L3JocE13WlN3U1JOalg0YzRtY3BqTGZ4ajk3ZHVHeU0waWZINmMzbHcySWdJ?=
 =?utf-8?B?SWdZM0pjNTlHSXUyM0hNRy9Fdm1QczFtY3ZOVVVhbXplai8xdzZLTWZKUU1m?=
 =?utf-8?B?VWlSYktCNVBhNmk4L3FDb0ZpSndHZDZDNTAvdEh3QnU4ME91NDRydUNwZzhB?=
 =?utf-8?B?dFl4TkJtbWMzbXZQeHdCL0p6S21NS3pIZGZ4U0Nqc2VUaVh4NFJoUFlPeXFW?=
 =?utf-8?B?RDVXaTl2VkJZUUVyNVJhdUx0ZVExNitDVjZCVkxuSkRHajVBQ1hoeExPK21I?=
 =?utf-8?B?YVhVUlRXRm1tVExvd3dpR0RaTHBvYWxrVFJiQU95N0phUWRtR2pBTG5MTmE0?=
 =?utf-8?B?czM1RVhGbmQ2Y2JvMnJGQnpMeTR2aERTbE5vOFgyZDZ2Mm1ocjQrNXlpd0VL?=
 =?utf-8?B?R1JvbUpEbW90N2VMbENsUU1jRUFYemFoTEdnckZNRHowYjVkb3IrRXhJVFN3?=
 =?utf-8?B?YnQ4N3JkNGU0d09aZUFvZlkxZGxJZFRtWnZpMHdreUJBbWdYNWRldmJSZEJN?=
 =?utf-8?B?bFBmZHRYMVZSOFBkS2sxSld5d0xackNPc2YvSHhkWVFuS211T1lIRlZDb0lO?=
 =?utf-8?B?ZmU2Q0hlUnFmaEZMRWlWckl2aDhZWE5aYUFrejdFeHoxT3JHNitNN3FUVDh6?=
 =?utf-8?B?MUVIUm9ZYlozQTMyeWY4YmZiU0pPTDdxZFJYWXVmMEJ4N3MvS1ZtYTBFWDlU?=
 =?utf-8?B?TUdQNy9DVHRDRCtXS0ZZc2JXcGQ3YzlROXNJM0FOQzlyME5uT0dtZXZGT1VD?=
 =?utf-8?B?NjdXQ2QvZjdwb1UrRWd3OUZBUnhncHdjZHlRWlBnR3pRMkg1cU1Mdz09?=
X-Exchange-RoutingPolicyChecked: TMiJ3dMNZul+Af2RF7FQQto/onAgltDbJK7nq+FQ4E0U0OYaWnueGXScTMEQmw8vmOzy7GwHYK5ENU0fX7n/hBwec1jgK2EpHw4aAKcs/5p4H2Uj3zK4E/9jB9Cr3S/sie9i6JLMkFv7TC/Q7f7mSNxupFW/Xo4cwYmAIEuvRwhc/92QaqerBJjCPe45iqCySf15tWdkrfF+pGOVIuDX4JoxpiJdPGZjfbU71xje1GJ+hS84gZ1MejcfXRt3SQi0YTehz05txuKj1Jdj6kNuuiQ01NJvTpG4sIGKvYcK/MPffcQGvLkGc/H+LDm7XgfBBK3dlO2aftkFjSzA25sKWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: eba506fb-39fc-4fe6-9355-08de7da70ce6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4044.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 06:42:36.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/MUWZUKBWQm5ezkGLzxRmLIJYprUatcoAWd3BsIbWGNaV9keb3H1T89trRUHiNlqJW+LNNhvp/a44rOtNzXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7421
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 3D23E234500
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265383-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.974];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "ltp.cve-2020-25705.fail" on:

commit: 64db5933c7adcdc4dd8f5ef6506cc998ecbe63ac ("icmp: increase net.ipv4.=
icmp_msgs_{per_sec,burst}")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master a0ae2a256046c0c5d3778d1a194ff2e171f16e5f]

in testcase: ltp
version:=20
with following parameters:

	test: cve-06/cve-2020-25705



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz =
(Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603091409.866c520c-lkp@intel.co=
m


PATH=3D/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bi=
n:/lkp/lkp/src/bin
2026-03-06 06:12:16 cd /lkp/benchmarks/ltp
2026-03-06 06:12:16 export LTP_RUNTIME_MUL=3D2
2026-03-06 06:12:16 export LTPROOT=3D/lkp/benchmarks/ltp
2026-03-06 06:12:16 kirk -f temp_single_test
Host information
	Hostname:   lkp-hsw-d05
	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
	Directory:  /tmp/kirk.root/tmpyus4a2ag

Connecting to SUT: default

Suite: temp_single_test
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=1B[1;37mcve-2020-25705: =1B[0m=1B[1;31mfail=1B[0m | =1B[1;33mtainted=1B[0m=
  (16.104s)

Execution time: 16.158s

Disconnecting from SUT: default

Target information
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80
Kernel:   Linux 6.19.0-11801-g64db5933c7ad #1 SMP PREEMPT_DYNAMIC Fri Mar  =
6 13:49:07 CST 2026
Cmdline:  ip=3D::::lkp-hsw-d05::dhcp
          root=3D/dev/ram0
          RESULT_ROOT=3D/result/ltp/cve-06_cve-2020-25705/lkp-hsw-d05/debia=
n-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/64db5933c7adcdc4dd8f5ef=
6506cc998ecbe63ac/0
          BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-ltp/gcc-14/64db5933c7adcd=
c4dd8f5ef6506cc998ecbe63ac/vmlinuz-6.19.0-11801-g64db5933c7ad
          branch=3Dlinux-devel/devel-hourly-20260302-003818
          job=3D/lkp/jobs/scheduled/lkp-hsw-d05/ltp-cve-06_cve-2020-25705-d=
ebian-13-x86_64-20250902.cgz-64db5933c7ad-20260306-21371-13x9t7k-1.yaml
          user=3Dlkp
          ARCH=3Dx86_64
          kconfig=3Dx86_64-rhel-9.4-ltp
          commit=3D64db5933c7adcdc4dd8f5ef6506cc998ecbe63ac
          intremap=3Dposted_msi
          max_uptime=3D14400
          LKP_SERVER=3Dinternal-lkp-server
          nokaslr
          selinux=3D0
          debug
          apic=3Ddebug
          sysrq_always_enabled
          rcupdate.rcu_cpu_stall_timeout=3D100
          net.ifnames=3D0
          printk.devkmsg=3Don
          panic=3D-1
          softlockup_panic=3D1
          nmi_watchdog=3Dpanic
          oops=3Dpanic
          load_ramdisk=3D2
          prompt_ramdisk=3D0
          drbd.minor_count=3D8
          systemd.log_level=3Derr
          ignore_loglevel
          console=3Dtty0
          earlyprintk=3DttyS0,115200
          console=3DttyS0,115200
          vga=3Dnormal
          rw
          keep_initrds=3D/osimage/pkg/debian-13-x86_64-20250902.cgz/ltp-x86=
_64-92ea0639e-1_20260301.cgz
Machine:  unknown
Arch:     x86_64
RAM:      14040916 kB
Swap:     0 kB
Distro:   debian 13

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
      TEST SUMMARY
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
Suite:   temp_single_test
Runtime: 16.104s
Runs:    1

Results:
    Passed:   0
    Failed:   1
    Broken:   0
    Skipped:  0
    Warnings: 0

=1B[1;31mFailures:=1B[0m
    =E2=80=A2 cve-2020-25705

Session stopped



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260309/202603091409.866c520c-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



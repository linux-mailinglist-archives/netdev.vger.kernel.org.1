Return-Path: <netdev+bounces-300269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ycmoLI0rM2p8+AUAu9opvQ
	(envelope-from <netdev+bounces-300269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:19:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF669CCA0
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:19:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=lIjXvoNL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300269-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300269-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BADF03028B31
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C4037C11C;
	Wed, 17 Jun 2026 23:19:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1685B316190
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 23:19:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781738378; cv=fail; b=mSERwm4/yasziKDNrpFOaPTbNJXXBBhCskCtoMkKy+5/nWEy1BplLitr57PTQl5iSyABp57y36oXOZDT8DbS8WyYrs5Zb76LVZWUa4lUGjfH4VUt7G3b4TyjTki/Wha4MuYGDdXMug0zEQZ5xLoXJnJ1YBFoHIV1XCs5duqavtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781738378; c=relaxed/simple;
	bh=T+MlTUo8+vjwNb8obhMnjEkTg8Hp4BAypkb8Ctck4Jw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hcESnQxm0TkXdUznkNTdrnuFGjEPqQuhFFF5jkzmRT8BLnN5m/aZSkS0q9SRAbnFpsfkwiTkuIJsdr7YdN42qMqad1lW+2rVDoercHM0kgY07pYm8qGxotbDpE73i9eskw/NkXR8tWuf4iHk0SNEsZjZcHRS2m+r2G3CnzCKck4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIjXvoNL; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781738377; x=1813274377;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=T+MlTUo8+vjwNb8obhMnjEkTg8Hp4BAypkb8Ctck4Jw=;
  b=lIjXvoNLEJ6SGEOGNwqs7p8yLLyzxqMzOZ4oyHuYmkUustEvenHI5GLl
   VEyl7x3wtuqDhAD6xsqihDAr8GWRrMdHW1Ux94slMmrAG2Wl4bRu1ImvF
   f8GqH3byquC9fO2CxLAvmTmd7/tdrnFaGb/B/qMHm1LlOPEuf2MuIB//2
   3s1DFz9cvkfNI99zjqpWcR0d50PSvOVKxh8Yer5qpJhP1oEoDNQSzID4P
   eCpFBp/yeQrnxM06O0Nl5nv/UjyGvo1PPxBVuhtH7+EoYp0/LXeA3X7Wv
   UlbvnGfQtH7s4Qngsrvp2w7Zh/CDbAdwdf1xSJ5tT3eI5Ol7IqH+qhR78
   Q==;
X-CSE-ConnectionGUID: JjInDSZ+SUarOu650I/V+g==
X-CSE-MsgGUID: 3M0J9ZUTTCGF1KrPNV0hlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="108088857"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="108088857"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 16:19:36 -0700
X-CSE-ConnectionGUID: 4HYsGDktRjm5ejM1ih8kEQ==
X-CSE-MsgGUID: rnzKP9iKQzqnG2nK+wCXCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="248264124"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 16:19:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 16:19:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 16:19:35 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 16:19:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAJi5wfh8CZFedKLqHX5HMwWkDleaOhnzsPrn+ojzEQiuk2ANXo/47mXmS+1em0HoUZVfbb+dfsisqZy7vLXZSPPzSje20TMbmNpmY6Y7PlfL/fGwTrqYiAg9o0b/V7eZduLvK3tGBPE/u//c3I0BIeJBBGqMMRx6nERRe2KmGQhKOvQUj5xcaQUCwbYmJjoAZYD0DKAFW6Et0HzckXdPf2ap7EL9o8DRVYLyDaYY2L1bBxz1VWCvSMMRA8Iw0v88quyBM/C/vheIOSetYT4iHgn22ZcTbQIFx8CSFZjLazD6VM52yGopGe8o5ToJl4fSIN2UCe5lQ0hKm7KX2aEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9UTE9QuvS3EJzgSJa6c4leggAAUP3XhpEphl5Ac2t4=;
 b=NahX2g7h0OEiAVuRnecJ71ymJE3ITwQE+DDdlS47PaQaEBmQKHFMwyarbYDxkBAUPOex4p8Ish2hJA9e6tdrS7ttDe+ckK+u8ZXpsrHHQlPAO3ef6qDKyiEyzyM61ZeRr/dmBFB6N1FIeWEpSnvS2YObWJPSdo0k0aVpBkg+krHAFZ12UQOBo7gTlnCZoYq9wZt/4Ruo63xJVX2gJP5rewmlHUGFAKKnXpulp42MOm9KXnyvpe+bpZE4b6/AX5k6EBVC2C15w+1uJe/+okAcoWtABDfhx+CqGXUaLvbb6VGa3dlFNP/TZLJiL+HMYv2HXBT0M0X6Esrv+HW3joBnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA6PR11MB797045.namprd11.prod.outlook.com (2603:10b6:208:5eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 23:19:29 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 23:19:28 +0000
Message-ID: <b2af9d40-92f7-4943-9af0-e3f59c69e6e6@intel.com>
Date: Wed, 17 Jun 2026 16:19:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] netdev development stats for 7.2
To: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>
References: <20260617115319.43a5942d@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260617115319.43a5942d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:303:b9::6) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA6PR11MB797045:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d179c1-1cd2-460e-ffa1-08deccc6e134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1aRCjej7K59hcfcvF3njbUxiMohD0O396T/H64NJFIQ5Y94vRTln9G/9Pwwjj8KI1p/lmv2sw9FiZuURa1RxEk5Gps/o+OwYLCNw25ZxQq0jiwQ2VEg1wdhwuz1nytadWumFXt9KJqQyzAE2uAoXJzUawklNdZY1AKbVBVDhfqTx6BEpoqXEwbJ3RPnIH5Xqh4mkErdRKBO7PBmpw4fG0EFxZrLJ8DWIa5Jxn3q/sbGj7k27FD+q5m0FA690h4eewuZM2WnkP9DcJw8W1C//+PqyqFI+d1j5vzntmw70SL6+XcD4p8E6Fpu7Smw9O9fBL7c4tS7yxyVhf6PGiSfaCOucRal8hxE+mofqNNRmnzevxgPY/qTQMY9SvlSjFeoLDyZ7EBZofKh15Iuv87B0w09A2UleBDugAvFCsWu7miC2w5vbNJGohCmUUJjNnraWw0ILkb41EbYn9Lng/gfe2x4OjxWGGJJsWyKpDnNoqGFcpFWCGRK056U5x/pn9hfXGVOkoJ8w73ivd/GVdltax33ygwedgoS5DvVvPuKN0NF6R8o/cdNsyMKdE0U0B9+lGD+2gcbIqbh34WpoaOifVKnud0tJbMFkPzBfCDoB8fB42eooxWQU6DGyMGITgEeEMVtczuCC+UdUQhFN7gq1L1mxshLX3JN9X4vKVQvrcziHYvjyYDxG2t+HhFxhBmB+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1hmMm9QUkxGaG1uRmM2bTkvcjdhKzBPbnlGWUdjUnRQOEtRUkVoOTFqdnJv?=
 =?utf-8?B?S011cUM3eDIvME5wT1o3c3NGekNBSC9QeTZXM29POHBIUkw2a3FwMWtDWmRu?=
 =?utf-8?B?encvQ1UzeHRUanNWQzhQOXpXRDlRUWdIL2FiYk1uTDNuOUlqWk13VDJNY1l2?=
 =?utf-8?B?d3FmaUxiNE1kUVpmK3UzMmdsbmRleHhuWUFVQWYzUzBZZllOZ09QUThObGpH?=
 =?utf-8?B?OWNmQ2FoanBLQURNKzlOVURTQk51K0ZSYU1JdmxDWjNzdVhZaU53SlovTjlH?=
 =?utf-8?B?QjVSd29wYk1kT1RMSHJnNTZXRlJneEVDbFY2UEM1SFltVlJaMTRSaGRQRnM2?=
 =?utf-8?B?RmNCdzk2b05vTXpCeWkrL0pSSGhMQ1RGMkQ1MVNkZUd6b0dSNnVNTlA1TVF0?=
 =?utf-8?B?WWxYRzloRDRZRTFZSSs1SUNXNTdQZURHTmVmbWJOT1FjNUsyUVNnYm5iVzht?=
 =?utf-8?B?UTlrK2cvdG56RGR4MjRkN3FYVk9FMy9rdnpMZlpJUHVZY000bTl1SHpQZE1C?=
 =?utf-8?B?dDhSbHE5N0ZYMFZpak9XUVlLSUFEKzVvUUZuSTNmR3hMMXN1LzMyb2J5Zk54?=
 =?utf-8?B?aGxLT29OOHJSU1VucG9KZ2o3Nm1TMmIyczh5UmtOQjFXODhJUkFQNzBDYUNp?=
 =?utf-8?B?eTBGa1FSOVhrUU8yMnYzTUJNMXBxTmF6TGRMSHBFUk5jeGRucnBtYUpOUE51?=
 =?utf-8?B?WjNvRnA2cjJ0cThHcS8yQXFIb2F4bkExNjJzZkQ4R3pTb21SM0dIcWNhNnNn?=
 =?utf-8?B?U2swTVVSNkYvbzNCZVMxd0NTT2pUN2hPM0M5U0huTGY1czg2VlI5a1F6UnhC?=
 =?utf-8?B?dzQ0eklUT01xRTZ3UEpOZ080d1IxVkp0T3RoS3VUZ3lqcThZMCtiY000bVA3?=
 =?utf-8?B?RGlxcG16ZE8xUVA2dC9rWlhjVUdqaWs2c08wNUZKOGhvazArZWg2dkkzRnFF?=
 =?utf-8?B?U1dXem8xUC8rZU1MKzhaOUNjRG1meWJGMS9tOVlmamw2cXJ3TzRNSFZwMDkr?=
 =?utf-8?B?ODNmY2FEWmRlRThQRGFJZ2NsaHZreTViMU5DQnI5Z3BhV1RsQVRlWW04dks0?=
 =?utf-8?B?MXRha3VOYzJQUDRJRGxpRmk3TDdBbURWckl4TFI0K1JXK2ZPeTVMNmFNanpz?=
 =?utf-8?B?enJUV2dkQi9CQ1o2enl0aFVtRGgvZ21UdTBxemVBZG8wNllYaVljSkpJZkw2?=
 =?utf-8?B?QlN2Y1lmL3Vlc1F5U3JUbDg0U1Q1NmpBVk1IaS9STU9QdnF6cXNtQXpTSU9i?=
 =?utf-8?B?TEkrZTZneC9TU2JsK251bUpoeWhGR2hCNW13Z1dweU9tMFRrQlkvR2VTejJR?=
 =?utf-8?B?SEpSYlRUS2QxVWdJQk1BSlZTQlVJL2FxbGlxVGFEYWtpcFM5Ulh0SUNIcUts?=
 =?utf-8?B?ckQ5VlVEemIzdStpbG84WFg5YlkvemduM3ZNVW56M21vbHltR1BMeFhncWFQ?=
 =?utf-8?B?ekEyZk5nYmIxZmVDL21sRldheUxwWGs5MjlKRGh3VlBVM0JicXN0V0pIaFFR?=
 =?utf-8?B?bWVkbi8xMmovT0plTkN4UmR6OTlRYnZ0QkZYTDUzcTFKN2Q2ZHI2bGd1bHRS?=
 =?utf-8?B?YURRalRsZENma2NLNUN2eGJaS3FPMHg5YUdNWVhsQWxVYXVVS3pwdi9nWWpT?=
 =?utf-8?B?dzFRL2N1U00zN1FyT0s4MGN4SEZKaXJVVk90dm9aRmQ0UThJTHdUUldlMWVp?=
 =?utf-8?B?VDgrRGxZOTgvdFNadkxmWHV0VVl0eTVFY1VQRWVhMTcyRmVZcmlhcVNJZ1pF?=
 =?utf-8?B?MlUxQTFWTUZkKzVUcHdMYk40dUdzVjVLU3gwTmt4L2dQeURWNmozTXM1MVZW?=
 =?utf-8?B?MFdQdDV6WnFsbEFMdTM3ZDAvNHppMVBvWlIybWVYRzF3M1Z1U0FFNWdVNEho?=
 =?utf-8?B?MjBnOXliU2lsMitUaEJJdFVxNC9zWk4yTER6MDg1NGo0NlMvMmtkc1pmMy9k?=
 =?utf-8?B?djlFbnBOUTZDYkN2RVhaUUI4NnU3Zk5ZKzBWeVhrOFBOZkNROXBJT2duMWJY?=
 =?utf-8?B?bGdVUmFFbmdiUWtOSnJSWldNaDM2Y25qcEt2dVI1eUVjb0hGNWh0VzNQM3hS?=
 =?utf-8?B?RkVZZk01aStsdCtIMTczRkRrd0JkZmQ2M05CVjFCY0gzazRzanFQUGtuUFhS?=
 =?utf-8?B?SURaUjExZU9Edm1RWVZ3MWg2R0dDdmR1aG8xN3BjYVlyckczaFY4OEJuSUpw?=
 =?utf-8?B?VVRaRE5EbTBhSWsxNzNibnU4cmoyYjVWeVBSRFdyamhTR05uMmFsMk5obGVw?=
 =?utf-8?B?U2pqOUxLWFo2SWhFaDFEbER2OUVsTFA1YjlGL2Y0bG8rYUphc2E1NzgyR1la?=
 =?utf-8?B?OGNtMllMVkdtank3a2NodUphaE5WQmd0RWx3UElwQXp1dTM1Q2MrVEdDcXVE?=
 =?utf-8?Q?6bgaHCUbE5bmRL8Q=3D?=
X-Exchange-RoutingPolicyChecked: eR+oqP7B1/gZMntvng3N/clVMhy500nRpKIonWiCH7jToIQ8D3er+i5X7hd7pq+jikthK2AUKHe8GCxxOzRYf1EGAKRjRkaUa9Dx5LxzFsAYq/gQBHh+mRX3QoLDODM4RnLq91nGCW4IH9MZzk3z/gC7Bs+TD/Iz7mjkqhLSpLDX2wxDfoNOcExtEnDI3gYUXCrbcYIjH6NNLJCGPydg+YtJ+SzEg5i533GadwoG6tSsnumDd9LKOxIDEhIIhKJ+dC24woFB/Srw0tHwoapyWzb1KF14MTAAkrt7f03ftYLGRr3ybQNHYJU36WxajOiKCcETxU/wyN7aqFfiWm3dyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d179c1-1cd2-460e-ffa1-08deccc6e134
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 23:19:28.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PW3KLDbuvS+UyW9vrPGvkuC+nvnX5L882vvihSDAMclVPmu8xlnvjOJrA4TVgDRnPawiG5/ptjKEss/R+2D55DXOoS7lIvCUJVVTavVAKEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR11MB797045
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300269-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:mid,intel.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11AF669CCA0

On 6/17/2026 11:53 AM, Jakub Kicinski wrote:
> Top scores (positive):               Top scores (negative):              
>    1 (   ) [768] Jakub Kicinski         1 ( +1) [91] Tariq Toukan        
>    2 (   ) [376] Simon Horman           2 ( +8) [86] Wei Fang            
>    3 (   ) [346] Andrew Lunn            3 ( +4) [67] Ratheesh Kannoth    
>    4 (   ) [265] Paolo Abeni            4 (***) [54] javen               
>    5 ( +4) [ 91] Ido Schimmel           5 ( +6) [49] Lorenzo Bianconi    
>    6 (+14) [ 74] David Laight           6 (***) [48] Luiz Angelo Daros de Luca
>    7 (   ) [ 62] Krzysztof Kozlowski    7 (***) [43] Simon Wunderlich    
>    8 ( +2) [ 57] Aleksandr Loktionov    8 (***) [38] Chuck Lever         
>    9 (+12) [ 50] Nikolay Aleksandrov    9 (+18) [38] Grzegorz Nitka      
>   10 ( -4) [ 49] Willem de Bruijn      10 (***) [35] Pablo Neira Ayuso   
>   11 ( +3) [ 49] Sabrina Dubroca       11 (***) [35] Markus Stockhausen  
>   12 (+41) [ 47] Alexander Lobakin     12 (***) [34] Selvamani Rajagopal 
>   13 (+24) [ 47] Maxime Chevallier     13 (***) [34] Jason Xing          
>   14 ( -6) [ 46] David Ahern           14 ( -8) [33] Illusion Wang       
>   15 (***) [ 43] Jiayuan Chen          15 (***) [30] Minxi Hou       
>  
> One process note on the reviewer score. Tariq tops the negative list. 
> I've been returning to the question of whether it's fair since 
> he has to handle submissions of most of nVidia's patches.
> Still, I don't understand why reading thru the list and reviewing
> one patchset from another company a day is too much to ask.
> 

This is a difficult question. When I've covered for Tony in a similar
position, I've felt like it is hard enough to keep an eye on our own
list let alone also finding time to review other places.

A positive note here is that nVidia is now green overall, so at least
there is some participation from the company as a whole. On the other
hand, Tony isn't in the top negatives despite performing a somewhat
similar role.

I know I was lacking myself in the last cycle due to a bunch of
unrelated work and issues. I've been working to get review back into my
daily flow.


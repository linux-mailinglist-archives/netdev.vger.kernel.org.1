Return-Path: <netdev+bounces-199802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDBAE1D4C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C286C16F7FF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29F128F528;
	Fri, 20 Jun 2025 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBEZgSAO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14E291864;
	Fri, 20 Jun 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429615; cv=fail; b=WVaR09Us0z3Kfo3IZcaGyc5FtymRHJ3IvSz6Sa8clq6J5iEheTrCwykxxRJGD8rSNJj/A7Tepqi1nDbd/JZeAPS66zqDq+gkGBvRRF6FTGeLYyOdsTnCtfWRRYI0cUfBtIFCzsjTNdjmYnNqFy+Bwavcrx88IlDa5kjiIUzn+28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429615; c=relaxed/simple;
	bh=HxVrumi7W8ItT5Sa5jnNEqQZSWqIJPsuK6bYitz5X30=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rKWUmt2LSHQXDJhbxYqEnKfdhdXo2VOu80nB5dNCYQw9pAIFcJNAcuv1ESdVKCSIyqr6fYLB5SKHRdtLyre798iPUhlgeO+b7DiuL7R69AIlHHrnT9O0cPN4rvR4IelOQTrm/+mAavnM5TzuCXdKhHBmOIYdlfQRSnlrOlNvICY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBEZgSAO; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750429614; x=1781965614;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HxVrumi7W8ItT5Sa5jnNEqQZSWqIJPsuK6bYitz5X30=;
  b=PBEZgSAOLIhAsWsCGyyR8V7cJhFnKapib4wD1U/nRJFxPeQYJUqB+fWS
   0+G2luPWvPsnz2XuNYDMAe4vi+Ab5mYs2SIF/4uNU40B6CfY/Sdi7Bvxu
   eViiJw8Pph1zNerJFUxZJ1ypLov9Ha7vqHkIx6mWGo3IeyPCFF30LRReZ
   VSuJPvKgM7cmPXMrCiyv1Q6avvBDlH20tfakVdNk00/0MDRZEAiNhs2ex
   QsrIh3pmQxngyCZgRQepcBwrgbm/u+1bl1/CKZwULdzyTORtyWDnLvuMB
   XUC8kdhZNlFxwEbgSmNa19azqtHfbAODyAjCJtBPIqpYAKPgpApgqSDZo
   w==;
X-CSE-ConnectionGUID: ikTUlOAJRuecQrn12g3ZFA==
X-CSE-MsgGUID: +HsgJ8G2RA22pFIHc0lxwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63747482"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="63747482"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 07:26:53 -0700
X-CSE-ConnectionGUID: 13XofRcORqSf+alMLIrwJg==
X-CSE-MsgGUID: XzIGcX5kR3afdu+QI7IgiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="150520305"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 07:26:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 07:26:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 07:26:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 07:26:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEYEUYaMhcqr8DIg3Vr5+7cgHys+ND0PCi1nhAJjjeA3cONtmesHrsr1GV4tS9iQM8CWkPBykMRnoNABJCVQi06xZgKXakmD7Bo+cYBu5iddMHkg4q6rQlDHR8KQX9/KiZ2A9rpYO6PJCMGDiWZRiu3iBFi01bQyHd8eh3YZ1D/k7vOamcjw0t0usJESdgln+uJ5D6GmcSM6B1RC+/cKJpzk8KCrJC1jK0q1fym6jOOGDVXqrEwzy79+sBmfVU5uWyBUsPFZv6tsRLg733GTgmYbc9o7YnvUnVfqVYqe9C6ObL+uq5IDJVR7/7z5/rjLqNbPNNaPhoVMG6I4Xa74gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jbW1hxlsBfVb031X4/DxVQ+dRzTUHrkWnyocxLoqDY=;
 b=kHzikUfy/OeEIDRvl3m0RKfGFGlEVwg5/NZ4p6LYfje88nyz/7q2njXChmhj3lYPu3+mnG5KgRBiVKTKCCqi3t5F8/IDapRz0vfPJFwmdlPyKKSsyUIEY+dy3+TQshKKv2C/hHufccZ6zaxqIuUHszlzSz4aO4i5C6n8WMZQz2y7PQFLfBMPUs4FXGsbYs8kAlKErwJnGv5+L1YfD4Yi9DmBCCaomZq1nKdry7C7nvsIGyMPVLxF4gIfrstQ8dbAZiy+GfU48SpoM2J/E6uPUGNStby5x+vV17kmWPgS75cTnp8ynMAU7d0W/7N7WUhUR6otZ/5yktX8JG2MimQufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM6PR11MB4644.namprd11.prod.outlook.com (2603:10b6:5:28f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 14:26:34 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 14:26:34 +0000
Message-ID: <80e0d302-7c43-4435-9d74-f1950878216d@intel.com>
Date: Fri, 20 Jun 2025 16:26:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ethernet: atl1: Add missing DMA mapping error
 checks
To: Thomas Fourier <fourier.thomas@gmail.com>
CC: Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Ingo
 Molnar" <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jeff Garzik
	<jeff@garzik.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250618142220.75936-2-fourier.thomas@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250618142220.75936-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0244.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM6PR11MB4644:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f9e8d8-6d53-4a7f-e0c2-08ddb0067509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eCt5d1NIWlpmU3kxQkZ4N3hVM2JLS0tmbXVsMVdJdGVtL1U5ZEJjR1lzdlY3?=
 =?utf-8?B?WGR0Umk0b2FkdDA3RU14ZUgrMmt3ZDlFaWxhbTM1anRBbVNUZlBIRGVpT2NG?=
 =?utf-8?B?c2xpbkhROFR1QzRUNTdyeEVkWDB3VkVrSlhvZG1sNTBUUWFVUm01bURySjhK?=
 =?utf-8?B?c1dZMmRHazdaZEh3d0cyZzFxc2RPNkZKSVRDTUowdkZzSlorRlNtNTErYThG?=
 =?utf-8?B?TE9Sc1pZKzNWcHhSUnBYMTdYeTh0ZXh4YURXcTEvdzFzNForSmtQbVkybUdi?=
 =?utf-8?B?OVFYQ2RNVlZhWU43ZjExRTZBbjNzN2IwWHJtdmp1dWpIb2p0eUpDRXVOQlhy?=
 =?utf-8?B?clBxc2h6anhodjB0Rzh5LzZZMmpnZ3lUZnROdGFSSHNVVzJ5Um53Q2VTYnd4?=
 =?utf-8?B?MXJad2d2YUlUeGQzYUhOOWxXL3o3SEphSTdIclRWMVZsWEcyMk00ZDhiZGxT?=
 =?utf-8?B?NnRsczhyR3lxM2M4Y0xRbGVwdWFvdWlDZWlOa0R3WkVqSVIxM1phb1JoSTcx?=
 =?utf-8?B?UGYwMkhKeXVnVGFCQVAxSFB4ek1PTFlPb1N1Snk0UWdDRHJOMGJYM0I3WnhJ?=
 =?utf-8?B?b1FldkkzM3AwUGNGc0hZZ2ZnRktBWlV3aVgzeUhoL1VMT2VFNUxQSmUreUVP?=
 =?utf-8?B?cm9rMmNqKzNldDduUUFyN2lBYUFEMGtnc2dCRHc3aDdwQXRPVlUxbVJQbzQ0?=
 =?utf-8?B?c2hFQU9zczBsV2hKSE53c3d1dFpHTlhRS25TU0RtbDlLYzBjUUJZVU8ydFZa?=
 =?utf-8?B?REJtK2tGR3RpVytvcGN1UVBQUzRZUzBxbkFRWTVBczBKVk9oZklwd1VIWGF0?=
 =?utf-8?B?RXlwTVo1enl0Rkh3bVByZmJ0SkFVZkZranl3dXZRa0pjVFQzS1F2TUNUTG5I?=
 =?utf-8?B?a0poYmdBbVBPVzh1ZDhvNkRqMkZDT0dnMGtlRVk5V09iYmdQSnh6MTlIa0dF?=
 =?utf-8?B?cDB2M0FZTFl0TkNxVWdEYXdadlRRcHZEOW9aU2dEd0dlcWd3aGVqMERWV0xM?=
 =?utf-8?B?OG03WWVTZXVKTnI2UVNTeUtOKzF4OU1odHNqWk5lNTZrZTNVV2VmNjdZSXFn?=
 =?utf-8?B?M1plS0RJSVBJa292cC9IRFJyMzF5YitlK3R3U0lib3Y2aVM2ejc3NkRGa1ph?=
 =?utf-8?B?TzJLV0N6em90NFVvZzdOSVAvYlBjenZQeVhnQmV5cjlUT004YzF5QytJcFA4?=
 =?utf-8?B?bzhnbkxPRERuTUVzSkdCbzRxcEQ3bkZtYXNjN2YvWlFhNWJURkxSaWpFMGNH?=
 =?utf-8?B?blJqaUlzSVhrekx2T2RCeVppbE9xWTdlbFVySmNwM1JueEFoUk43eVFueWxK?=
 =?utf-8?B?ZTE5R21TSTZVbzJIdU1zbHJ3VWJvL0V0NEZVSWVBTVI0blFSOGwvYlZrUW1a?=
 =?utf-8?B?YUpWaUxLU1kxb2hSaGFGc0h3S2dBTnJLRDA0WS9xNDJwS3M2YjB1RTlITTdQ?=
 =?utf-8?B?QVN0T1ZvK2VLUmlmamxncVI1SDJJeWMrSVdXOHFkWkNrSWtoTDBDbUF5MHN3?=
 =?utf-8?B?NHhUeE9XZzYwUHlXdG9qUkJIYTNiOWhLUGt6azlFejQwK3pENzhjazR6V0pZ?=
 =?utf-8?B?TC9VdVk3VUUxUWFqalF4Z2VPY09MWGMwYk9iR1NzZlRZVkJGN245N3h5UXY0?=
 =?utf-8?B?bUd0Tm5LZ3h6K0NuLyt0b2djYWhaNnZ0S1E4MjhwNkhEN0ZoVittVGhZUWd4?=
 =?utf-8?B?ODBTdVhjVmdrQjhBVTZnRlB0bUZ3WlBIN0ppUlFzL1Y0WExsNFJkazcwcG5B?=
 =?utf-8?B?eWhRd3E5TWdyejI4dFJ2K0pBOElCcXVacmxqOExvSjBkSm9NZXM4K2wxV1c5?=
 =?utf-8?B?YUt0MHg5Z0wzUkJFU3lOZVJ5ZjNMd3I3blF3am9EK0FyNGU5cnRoRGJQdkZu?=
 =?utf-8?B?M0RlTWNhWkRIMGlQQUtrMFZuTnFqRzBKVjBpcUdJQVdFamprSUZiMW5MdFkz?=
 =?utf-8?Q?gvbGkUIIJb8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1RBMmo4OVJPQVRqM1N2bXBDN2VLdmVldFZ3QThhb1NrbG9ZcUk2NWxmYjVq?=
 =?utf-8?B?NG5xQlBpYnEweDZCY0RBTWszb3BTU3VLTHpCa0dtRTVMZVlralBQNVdHK0Jk?=
 =?utf-8?B?RTFtc0tvWmg0THh1TG4yYTRacjVrTXdRQzMxUHhBU2xPRHBlTTh5b1VjRU5k?=
 =?utf-8?B?RXJGNWRyWWxxTVlEUVJiSEovZHRvZDNlQnBZNWNzTExUc202WlRmZDlPQ0Mr?=
 =?utf-8?B?cmMrMjVLeVR5ZEM5a25uWVZBYmllMG85NkYrdXVSNUtrZ3p6ampYVzM1NFRE?=
 =?utf-8?B?TnpQOERscWRiUWtyYXQ1Qk1wRDhVRkg2dXpVYUNIbDZUNk1qb29RbGdOZWNL?=
 =?utf-8?B?cXZZRkN6VE11cktZQm5LYnQrRUEydHhwazI5aVlqWEhuZTR1Mi9mSVU5WHBx?=
 =?utf-8?B?MXlqeERJTVF0RUpsOHhTZzRaQnpicThtb0dwb28zZGowNTVmdzZGVkkxRE01?=
 =?utf-8?B?bWNQQXpZMzg3NFZLbmVKYkEvaUlhTVI5Z21JTzZOSXRsdXNucUYxSDh6ODVN?=
 =?utf-8?B?bHVKd0JWdjZ2ZFhmNmRuMmRoUWdWckhteUp2SXdqeXNTZ0IwTnhHYzkrYWxJ?=
 =?utf-8?B?S2Q2bWYvSjVWbDRoQmxCM1U3SnppcTQvaEJNSWtvcUNKRUFIclZ4Ni85RnV0?=
 =?utf-8?B?OGM2dVUyZTd5RWYyeFl1TEQzVGY2K2N3UElNa3F6a2ZaOUFpQWRNd1BTc3JJ?=
 =?utf-8?B?Y2VYSmRxUDRDSEFMUXg5bHk3SUZMUFp6RWlQeGpzVnh3bzJIcC9sZEtjaDM2?=
 =?utf-8?B?TkJFOVZWSk0raCtlQUg2MTlXdFlFQmpUeUdGQmoxU1U2VUJWV2JiK2hocy9i?=
 =?utf-8?B?aVVQTHNRdTRPYlFOS0FRcSsydWtqTkd4aDJVTll5VlBZUWNVMWRWVUN5aENS?=
 =?utf-8?B?UWFQYUJIaXpkWGdmbmtDUnhYSWRCSUtHak9HSVFnS244VXB5MkZOQUR3V1lo?=
 =?utf-8?B?RXhsQ09iSVp4QVlZY0EyZS84ZFRhRDNsMEE0TGdlL25hblRyMTZ6Y3FPT2dv?=
 =?utf-8?B?VDc2ZnIvY2pXRFFGejdlbVlWUUdxSStOUHVWbDFiMmM1aEhzMFlvQWRSYTNB?=
 =?utf-8?B?RXRZOFB6WmZnN2pMVEZwWVlGdFRHNkRBemRCTlA0QTRsT0l0TE9nOGJIeWh4?=
 =?utf-8?B?WDBRWFdwTmg2S2daTGh2eVRPYXhBekFLTmp1bGV0TjFFc2tteDBrMWZjbkpn?=
 =?utf-8?B?V3hnTXhxZmdacGNYMmdqcXp5OGd0Sk9zZisrK1VXVm8vN3NXbzl2Y2NFSmdD?=
 =?utf-8?B?ZE96VWczYmdwTHpaaUFCZnphRkxSVXFQQlAyb3NKakNObWlwbWVIM2VTZ3lC?=
 =?utf-8?B?TndNbzZlN2hHQUhXc1VlWFVWa3B2UVBzdDFHcDBoVUx6UzZNR2oyMWRiTWdT?=
 =?utf-8?B?U1kyZm42NWpZKzNCV3RkeE9CeDhUb0x6NjE5REMvUXZvRTN1VFZ4YncyOURj?=
 =?utf-8?B?dkFDOWpIOTFkR0pKc0VMZkU4Z052WG1YRmtlU2RGY1JrbWVpaUI1UzhDODdP?=
 =?utf-8?B?U08wdys5Q3pmaGJ1bUZKRmxLRlBtdW5DNTBKUEZUTlE0cit3ejNvL0lqZWY1?=
 =?utf-8?B?K0swajI0VWlVQVI1TE1KSkczZWRoNFRCQ0F2MXgyZ3VzMmozcm5vQk1BSnJo?=
 =?utf-8?B?alhsM1VXZ0NDK0RpakRlOU1yYWp2ZS9pb0w5aTgvUlA0NTR5MjE2bkFCWWdk?=
 =?utf-8?B?TlkxM0pkd2N2M3ZUTVBNYmt3K1NJa25MV1l0ZWhFS0x0SVdXNUh5dXY5V0N1?=
 =?utf-8?B?THhsZU1SQnNVZFlwd01oUURVVUtEeU92TWk4bExBRE9va0sxUkowcC9RVm1U?=
 =?utf-8?B?KzFLM0FJQ1pqdkpuTTNUVXVLRGtZWEFRMUxGSWFkOW9jbkVGcGxiVkJySkx3?=
 =?utf-8?B?eXdnZkhCVGgwWUQ0NjBoZm5XUHNRWlpTOE1qdUxITlo4R1FMTDBCUlVPTTNQ?=
 =?utf-8?B?WmQ5S2ZvYUxwOCtKVXA0ZWR2ZWFOTVNxcHJzZlEzM2Q0ZHBuT044Qm1MTlZH?=
 =?utf-8?B?allxUHh5cWFheEQvUzF1bXpsTzhmZWwzeEFEckJVaUwzWlM5QWEvYk1VQnFi?=
 =?utf-8?B?SzBMN2VtQWgzL3QrQi9hb010a1cyRW9ENURIbUt0OTFYVWtLYmROQ2dZUEdE?=
 =?utf-8?B?aXRsM2xkY0JoR0kzMVJ5TXpqTFlsMm1UWndDVyt0L2tnUGIxV1IySmd2c1Rw?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f9e8d8-6d53-4a7f-e0c2-08ddb0067509
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 14:26:34.0609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40sTjH+bxLMqw1pMYtl5hqoqmSb6+aA9Q4I588NbsNy0UUw97PodIB0gXCYYjv8m/ShMqKX/Mkic9rOmqgT/SD6HEeI9zORwvIMpwRtk9Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4644
X-OriginatorOrg: intel.com

From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Wed, 18 Jun 2025 16:22:16 +0200

> The `dma_map_XXX()` functions can fail and must be checked using
> `dma_mapping_error()`.  This patch adds proper error handling for all
> DMA mapping calls.
> 
> In `atl1_alloc_rx_buffers()`, if DMA mapping fails, the buffer is
> deallocated and marked accordingly.
> 
> In `atl1_tx_map()`, previously mapped buffers are unmapped and the
> packet is dropped on failure.
> 
> Fixes: f3cc28c79760 ("Add Attansic L1 ethernet driver.")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/ethernet/atheros/atlx/atl1.c | 50 +++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
> index cfdb546a09e7..9b53d87bf6ab 100644
> --- a/drivers/net/ethernet/atheros/atlx/atl1.c
> +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
> @@ -1861,14 +1861,21 @@ static u16 atl1_alloc_rx_buffers(struct atl1_adapter *adapter)
>  			break;
>  		}
>  
> -		buffer_info->alloced = 1;
> -		buffer_info->skb = skb;
> -		buffer_info->length = (u16) adapter->rx_buffer_len;
>  		page = virt_to_page(skb->data);
>  		offset = offset_in_page(skb->data);
>  		buffer_info->dma = dma_map_page(&pdev->dev, page, offset,
>  						adapter->rx_buffer_len,
>  						DMA_FROM_DEVICE);
> +		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
> +			kfree_skb(skb);
> +			adapter->soft_stats.rx_dropped++;
> +			break;
> +		}
> +
> +		buffer_info->alloced = 1;
> +		buffer_info->skb = skb;
> +		buffer_info->length = (u16)adapter->rx_buffer_len;
> +
>  		rfd_desc->buffer_addr = cpu_to_le64(buffer_info->dma);
>  		rfd_desc->buf_len = cpu_to_le16(adapter->rx_buffer_len);
>  		rfd_desc->coalese = 0;
> @@ -2183,8 +2190,8 @@ static int atl1_tx_csum(struct atl1_adapter *adapter, struct sk_buff *skb,
>  	return 0;
>  }
>  
> -static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
> -	struct tx_packet_desc *ptpd)
> +static int atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
> +		       struct tx_packet_desc *ptpd)

Since it only returns either 0 or -ENOMEM, it can be boolean instead
(true for success, false for mapping fail).

Thanks,
Olek


Return-Path: <netdev+bounces-176113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B20CA68DA2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 14:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDBC17BF3A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51E2561CD;
	Wed, 19 Mar 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfBvOcKU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F82255250
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390474; cv=fail; b=Ruudi0Efz9rYJcnB598506wF7M2l3DcUBcsN+Ba8Ij9aitbZz/7lejsG15d/QeCZF/8XSEwC5+l1eEITUCbzPpJ1Lzay9q7Hc0XeBYqUEyTsHu42n3CO9nNV/UTxkicHZ1kl4QanU2dStFjfMqRbf7eAx1c4VSJlJg2OJYB8kms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390474; c=relaxed/simple;
	bh=ZJz2J+sHbsqd+WioRrmeOjFgK6yRPtRmJr8RDUEB3E4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8K+rkD6S1DqWjRKpLZ6ugBIbZUjanw0+kwojzUQuJ4iznyTApzB5i+Nd371GUejP5jfkoc/Gw6gObhpzIfdUlN7Rb9emvHr7JH6dsqUlXax+Mo2vjUI4sdXtE4wLqHOaY51lKwzD7N9tTd3UVGVamY03gVV7vzHm2P4awmz3BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfBvOcKU; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742390472; x=1773926472;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZJz2J+sHbsqd+WioRrmeOjFgK6yRPtRmJr8RDUEB3E4=;
  b=bfBvOcKU+4xLc2B8lwBtue+A+95GF+UWYCLVCxmMXRBjLkqmDMmFmLL7
   NJkA8nUk3XoBaa0LSEnUVCGYO9gF/G6l8Z0zIbJ6u4MPKpDaTEJ+jQ05k
   VHXwPIYxLdheGv5TFoo37d2UyKBqk+n2ORe6re4WGfiUcNZP4Wonn69oK
   sl++ujYVadPk4va+bzv29jZdQh5oQdw+rRYHria7uKOgbcSi0rxZVSHz0
   fNY05YeaMXEC5LFN5cYG/y6mq3P8twVmIHULx9UxeDMqKElHXoMgSU1l7
   IB+0LdAGOB5ZgTfei0Cxj+/ereFgDs5TFzSaTEjyFNaVBj7fqOSBA0oXR
   Q==;
X-CSE-ConnectionGUID: sZbNZssNQAyWlUKYNrZx8w==
X-CSE-MsgGUID: UG0TL2lkTjaecSkbyz1HJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43764255"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43764255"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 06:21:10 -0700
X-CSE-ConnectionGUID: /A5qbFwrSPm40ZGHKiTakw==
X-CSE-MsgGUID: I0AsRCkEQBqMtrbWhIkp8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123109134"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 06:21:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 06:21:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 06:21:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 06:21:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlFr4xQL/ad5R7E0ZbPrtsxkwFDqQo2RVJX07XhGqdqlcepBgl3Jt4pgXu+BALVbWg155g0Z0Y8S2DlAGCpiKM8KG5Sf+ljRp1P6l1ofY2seKMM9ixThvDT+GI7ZmEhwewJh1I0VlMxcJvFPbvCvyIHLn0v3SqSt895EMEj9cO+BQ5zZqcdW/HH9Q0x0rX+iH4leI/Kz/z/oMIdsew9UAOCUCnl+VAjHEFt97R78HCkl+rXuq7tsVhbMjIgYBS+jxGrV7uL83HBt+k0I0DlwUS6OLcWz07elbrai///VcN1qeIhEmEPxF5Fq+UXzyzvXkMS40xAPO6sfWKgSnFk+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUCYdw6AN3Kxcrtp1rVS6FrHup9GHI2j4foMRfn/FTc=;
 b=bzjh2jlqJNjfYzv+dB+1VJ28+3hFIjY8WC2LIldaVFEbRdGgOeCkRZkBPnwmlRBCXYA9DrGlKhx/3O3O2UJQlzFxjyLkGP/QwRV8dUBU2G7Nc5d7HPpD9luqt5XBs+QUEhZ95HM87T5Ef+nEovYjPogrmHVQod/hgLxedLD6kNOAlbXE8U/dWVElzCuZW3eCTQfgPZJp6xjnMtQMlgNKJ3JwnANKHVQz6uISv22MnRmQd1MM7onaQPuzqHRZP9jMwWKfrkzlqE3TUAr2FEOU0ZS1VeShwq6vUlR6n9wgOPJtxfi4EkFbcJy7B+O2SETb2oERmsRjYNXQSYW061xL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB5777.namprd11.prod.outlook.com (2603:10b6:806:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 19 Mar
 2025 13:21:05 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 13:21:04 +0000
Message-ID: <23f21648-d788-40fd-a148-49766b078a4c@intel.com>
Date: Wed, 19 Mar 2025 14:20:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink
 instance for PFs on same chip
To: Jiri Pirko <jiri@resnulli.us>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Dumazet, Eric"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "saeedm@nvidia.com"
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"dakr@kernel.org" <dakr@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "cratiu@nvidia.com"
	<cratiu@nvidia.com>, "Knitter, Konrad" <konrad.knitter@intel.com>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-3-jiri@resnulli.us>
 <CO1PR11MB5089BDFAF1B498FE9FDDA3FCD6DE2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <3be26dca-3230-4fd6-8421-652f95c72163@intel.com>
 <emj5f7xfdcnkemdairmpyiqmq5aoj2uqr7bxhfiezqm4zeuchu@wuplknrtviud>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <emj5f7xfdcnkemdairmpyiqmq5aoj2uqr7bxhfiezqm4zeuchu@wuplknrtviud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0049.eurprd03.prod.outlook.com
 (2603:10a6:803:50::20) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 0736455f-8bd5-49c1-a4db-08dd66e8e6ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1NNVG9QSlpDOWNXWWxxSlJoaUdKK045SGIydDExeHJHYmMzT1ZjL1ZzUzBX?=
 =?utf-8?B?RlZtcDZjR3R6Vlpxb2UvTm1YNzkybGdVL2sycnQ1Tmh6TVBjWVF1ZjhGbitB?=
 =?utf-8?B?TVJBZnAxaWIxWlhsZmZqUEZyNjFoSDVxZGxJM0VvdERRdk9WRzFyVEFOeXJ6?=
 =?utf-8?B?WjVsdGxQUzVCdWNNeWplYm5Ud0NTazhTa2hTdncyVGZZWGIrRExSbFlqMjhO?=
 =?utf-8?B?REw1Yjl2M25YWkorV2dMbDFmOUZBaCtqdGxQZElpNVhPZHF6V0tUWFNGYU45?=
 =?utf-8?B?RG11b01OOGJRSzQ2T3MxY0NCYUdZakF4SkVrYVBCZ2pvVmlOdjA0UEtXMlBQ?=
 =?utf-8?B?d3c0NmxOaVpuQysyQWdOQUdvY0g5VTIweklHUlozdTlZT2pCUkM4cElVQ2FQ?=
 =?utf-8?B?aEhkZzJBbUs3ZUV6NzhTTW5OdXBSNElwNTFud0RQQi80U3Rxa3ZyRzlGamJn?=
 =?utf-8?B?T3MwVkVKQ1hhVW9ZV25EdmJCS3lXaWZHcDVINXlFNzdGVEhRdmFJSFJwQU9F?=
 =?utf-8?B?bm91NlRydnUwWXJqaXZjWG5MNWdUU1RqcGtUZ2F0d0xhNEVVVmErWEpnbEFi?=
 =?utf-8?B?ZHRZTnM1eUIxbnQ0K2lLRTE4VzRRakdPRE9PbVV1UzVCTG9BT1pjL0hrTHI3?=
 =?utf-8?B?QXp0YU96Zjd1aFlNVlp0NWgxNjlTbDM3OXBBby93YmJ1ZmNLWWYrUXFZY1Zh?=
 =?utf-8?B?Y1lUMDVMcy9YVHZ3NW5qb2tnZ28vUFowcnV5ZUcvT1RMSElTQlNWUE5oV1pX?=
 =?utf-8?B?TkRzbGhGUitzY0JWUHJVcEVvdWNCM3Rtc0FaM1h2RlZzbnRUaFRXWkpPZTRC?=
 =?utf-8?B?Umg5elB2Mi9ucC9GRytiazVBbjdManhtZlVhVzNaTkxPOUg2dTBoc25hcmpP?=
 =?utf-8?B?V0tuWjNXUnFUNWljbjh6MGhuWlNURjVHMzE0K1NEaHBFVUx3cmpVQVJKSDlE?=
 =?utf-8?B?bnpiOVpWbWliNHVra0pHNVh6aVpsd243b2pmaFFtZ2NycnV0T3hlRXZ0cmRy?=
 =?utf-8?B?TG5idUZIRks2YWVKTXB0OUJqdEpKUU1nb004cEo5alAwRnlpaVVlMXdPNy9O?=
 =?utf-8?B?a0lCRDVGSDJjOU85d0EyZG55Wk9nQUtFTWphY2VHQTlPWVd0cVY0UnZzUTM3?=
 =?utf-8?B?Z0xVdmdpNFVvbjZoUS9BT0VTbGZiOE1ZeW14VE00QzhrZWU4Qm5NeCtKOWZo?=
 =?utf-8?B?QUV6RGhIQ2tQb3h6WUZYM2lpREd2cy9SOW53b2dIRnU3NEFRcmYxM2hPR0Uz?=
 =?utf-8?B?VzZ3Z0owT2tSTTlTaXFockdhamNmQVBQa2IxcFZOREc4U1dDc1NraVpKR2RM?=
 =?utf-8?B?NGszeXhEeVdhaDRaYVJnQ0c1aGtjQWFaSzVuUW54YmlwWWhQWUJnN0RWQnNn?=
 =?utf-8?B?TnpabU9leHFMWHZYZUpNWVBGTXFFSEZUVzg3OUI5dVlJL1lvb2krd1JGR2Fj?=
 =?utf-8?B?NWRDSnBkMjJPc3BlY3NBeGdtQzFlR3RjU3NWbjh3d3BWYVlISjVockdUV0g5?=
 =?utf-8?B?TGdsNFZxa3lnbktWSUpNbjB5ZldzQzQxR0FERDZSME0xNy9VOCthVEdZbity?=
 =?utf-8?B?MENWWVloK3Y3aEhLRHBzU0Mzd0g1NTVLbUM5UnBYRXh1NDJPamZJMm5lN1JU?=
 =?utf-8?B?b2JrUEtUQ3hoclBoRVpGNHJnK0UxTFZQWWd3V2RBK2huM0dFalRlM250YjRi?=
 =?utf-8?B?SE1jZ1ZzdkNrNW4rUTNXbjR2SEJjLzFPY3pqYWFHdXpMOWE4MS9XVHAveEtD?=
 =?utf-8?B?SzN2WHFyOWxKaDh6QUgyNVdkZ1NCQ2VWSVFjN0pQeTNRVzZpNG9jRTVhdnBX?=
 =?utf-8?B?em1tY0FSZ0x3WFZzYnExWFltL1pVTEgxWFo2RVNEQkNGZmpuNWV2bzhnWkN0?=
 =?utf-8?Q?3hKwPRwknPA2C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5pL3FkYlU3NzcvMUhhVDdUSkp4Unc3M0VuSnRzMGFtOU9pUE4yZlBlb3U2?=
 =?utf-8?B?MnB6c25QekR1VTNpOW9COWk4WFl1V29vN2dkcWZvVEJIWXlKdTI1OTl2ajY4?=
 =?utf-8?B?TFRjMFB0djNlclpxVkU1VWhqOEkxRUtFbXlFZVZWL0lTSCtiZ250VFdxQlQv?=
 =?utf-8?B?UklHRzhXL3J6cjJlVStaNXl6MkpqamRwRzdad3AyZElydUUremlZc1puUDd6?=
 =?utf-8?B?RUNpTHBJenFUc0ZrUXhENUZNbTFTRWIzeHVzaGVWYnd2SythNCtXZG9kQ00v?=
 =?utf-8?B?NUpCZzJPQVRMa3Z1NGhjQ2Y1KzlqTVNGc2hOb0RTVFI2bGEwQmhLY3RUZDJP?=
 =?utf-8?B?UXJrYlY2TzZxV3hFWVVveUtOS2xPT0hpdWpiOFhudHh4R2U2VElKVGY1aEFO?=
 =?utf-8?B?QUVJQjJ0U1Y0NHhFWGNDblZlb201Y3p4S2kyT2xDaUVTa0Ztbnkvbjl3NmNy?=
 =?utf-8?B?bzF4V0tZWmxRZDY0dmlITU83NTVGNDVrS1dqYmF0U0RIK0RGNkpBQ2xzdW1p?=
 =?utf-8?B?aVNHd2JjUWlOc1NRNEd1YVpOZ0UyWlBrZlBsQ1Y4NDMrU2s1NW5xMTF1eEk3?=
 =?utf-8?B?QTlCbTRCVDd6ZzM3aG5rZUdET2Zjc3BtUzhaTjd4QzlmMElxRTU2N0JBSGRV?=
 =?utf-8?B?SVN4SENvZVBmWU1pdU9tM2RDYmpaSElRZTFVN3JJR2ZvVEpnNDdpTEtMcDAz?=
 =?utf-8?B?Rm1TUWZMVDkxajJ6YlFIZVdPTmNVZlVmeWFPMlJHQ2FlbzFhMDkzNndPZDMw?=
 =?utf-8?B?QWZXU2ZWdlVZUElmemQ1azA0by9ablAvRkt0SDhyRU9qMFRGdXF5V3BnZmpZ?=
 =?utf-8?B?MmtYT245ZWlIVmtJdWs4dHZKWlhwRXZVL1pBOXJEcmlhZVpOLzZJS0htUHM1?=
 =?utf-8?B?dnR6Ni95VDJJeWhnRUM5aFdFdmxMb3FoYXQ2ZDYwUjZjME1FMDNKMHVxbGVB?=
 =?utf-8?B?ZnIwZTZ6VVRrSXh0bjZDM3E1b1FrUTJpN0Z1c1A0Tmtsb1ZtMUd6aUI2RlRT?=
 =?utf-8?B?ZlFCL0dQT3JVUWE4QVUyQ2pIQ0hnMUFPQ1FOMk9aOVNoWVp4V3RjdSsxYnRh?=
 =?utf-8?B?Sk9PckF1M2RnNG9kbjduR24wZjl0ancwSlp4dUJ0VTVlRkYvVlplZk9WRzFJ?=
 =?utf-8?B?Uy9KRExZNU5wZWM2M3dkRWN0TlFvQ2VSbkxoZWZsRVpoR1NDY1JBNFlsbDdS?=
 =?utf-8?B?RnRqRGlmNjMxb3pHQXFOaGpMUTc3dFZwa1kwSFdiazQ1Qi9ucms5dE9ZRmkw?=
 =?utf-8?B?MnFvaStRN2JoNEk4NkNnS2VzSTZJT2E4ODR0UFkzMTJBSXpQVjMvQjNyYTBM?=
 =?utf-8?B?RTdJYlRDZExHcTNKbCtYMHdqOUJibCtZTFIvQm9jbklxZTRnMG1ianR1Z1Nm?=
 =?utf-8?B?OEtYMG5QeHN5Zjhla1lsekRKd0ljOFVHbnNlSnAvSDJmbjh2UnI5UEo5aWV5?=
 =?utf-8?B?K01xMCtwdENDUSt5YmMwS2RkWmVDeVlMQlhDRFdtUE85d0VyMUNCMEYrWk1I?=
 =?utf-8?B?NytJamxrZ1FTWDlHbUEwMHFvQy9CS0pQeVg4dEFkKzZKOGxidDFaU0hYdkdr?=
 =?utf-8?B?S2w2ZGVzVUJ0RWtBV01vQnRZOSs3cGYzb0hVa2pxOVErQjR6OHdJR2VCVUxM?=
 =?utf-8?B?TTc2NDEzUHRwbThvUWUzdmlxZVZnbGRNMzBoRFdiVm5qekFaWXdCdkZkOFp1?=
 =?utf-8?B?MTZ4U3hKS1hoZkxrVjZsd1pCdUVTSmMxSTNOSmRxeEdCRXhNNTNQcFFhNDhC?=
 =?utf-8?B?cXpici9ZTWlHWWtGOU43Mllad1pCVmJnbmo5RXFwVk5hWTNCUG9xTTNCNVhi?=
 =?utf-8?B?VU1lWXd5K09oZVFSdm03NlVnWG5BaHo2Vjg3SEo3RHZINmllMXZnbjg5bHJB?=
 =?utf-8?B?bEUxWXRqTWM4T2VhdHVuS0c1azA0d3JyYUd4QnFUMnBOTGpBTE1JeHhUMG9Q?=
 =?utf-8?B?dlhwZXU4RUlrV3Z4eUZWWXp3bWFLMUM1Nk5WN1A5b2d1TVNCVjNTVVV3LzZQ?=
 =?utf-8?B?ZWpDbFFFVzlhUGRKSVpPUk9OMnp1M3VBakVrWXpEZmxheHZjd2N3Nkcyako2?=
 =?utf-8?B?Q29oaXFIWjg2RytYL08rbmc5aWpWK1ZDQ01NSmFjZVlIZXNzNjdWRjg0Q1ZI?=
 =?utf-8?B?VGN5SmhMVWU5OStQY2JNaVZIU1dUU0x6NnVYbGp3Rmp2a0dRUXgwdVYxRmow?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0736455f-8bd5-49c1-a4db-08dd66e8e6ad
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 13:21:04.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeluaK+Fxa0DtEYjj1/6TdQPRMuVTnHPon6vd/ca/wnekBZS9RmobgWtZWBko9whgENJELr3o+by1B8CHDzMUtt8kc5kIVXgquhvpjzzWbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5777
X-OriginatorOrg: intel.com

On 3/19/25 12:56, Jiri Pirko wrote:
> Wed, Mar 19, 2025 at 09:21:52AM +0100, przemyslaw.kitszel@intel.com wrote:
>> On 3/18/25 23:05, Keller, Jacob E wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jiri Pirko <jiri@resnulli.us>
>>
>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>>> @@ -0,0 +1,150 @@
>>>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>>> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
>>>> +
>>>> +#include <linux/device/faux.h>
>>>> +#include <linux/mlx5/driver.h>
>>>> +#include <linux/mlx5/vport.h>
>>>> +
>>>> +#include "sh_devlink.h"
>>>> +
>>>> +static LIST_HEAD(shd_list);
>>>> +static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
>>
>> I essentially agree that faux_device could be used as-is, without any
>> devlink changes, works for me.
>> That does not remove the need to invent the name at some point ;)
> 
> What name? Name of faux device? Sure. In case of ice it's probably PCI DSN

yes x2

> 
>>
>> we have resolved this in similar manner, that's fine, given my
>> understanding that you cannot let faux to dispatch for you, like:
>> faux_get_instance(serial_number_equivalent)
> 
> Not sure what you are asking TBH.

not asking, just noticing, with the hope that Greg will notice
inconvenience for drivers and perhaps think of something even better

anyway faux dev let's us resolve problems in rather elegant way,
compared to what we have to do before (like this series is not even
touching devlink/)

> 
> 
>>
>>>> +
>>>> +/* This structure represents a shared devlink instance,
>>>> + * there is one created for PF group of the same chip.
>>>> + */
>>>> +struct mlx5_shd {
>>>> +	/* Node in shd list */
>>>> +	struct list_head list;
>>>> +	/* Serial number of the chip */
>>>> +	const char *sn;
>>>> +	/* List of per-PF dev instances. */
>>>> +	struct list_head dev_list;
>>>> +	/* Related faux device */
>>>> +	struct faux_device *faux_dev;
>>>> +};
>>>> +
>>>
>>> For ice, the equivalent of this would essentially replace ice_adapter I imagine.
>>
>> or "ice_adapter will be the ice equivalent"
> 
> Oh yes, that makes sense.
> 
> 
>>
>>>
>>>> +static const struct devlink_ops mlx5_shd_ops = {
>>
>> please double check if there is no crash for:
>> $ devlink dev info the/faux/thing
> 
> Will do, but why do you think so?

My local version of the ice equivalent crashes here, due to null ops
pointers, despite all the checks in devlink core trying to prevent that.

[...]

>>>> +	char *end;
>>>> +	int start;
>>>> +	int err;
>>>> +
>>>> +	if (!mlx5_core_is_pf(dev))
>>>> +		return 0;
>>>> +
>>>> +	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
>>>> +	if (IS_ERR(vpd_data)) {
>>>> +		err = PTR_ERR(vpd_data);
>>>> +		return err == -ENODEV ? 0 : err;
>>
>> what? that means the shared devlink instance is something you will
>> work properly without?
> 
> Not sure. This is something that should not happen for any existing
> device.

then failing is a best option to notice that :)

> 
> 
>>
>>>> +	}
>>>> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3",
>>>> &kw_len);
>>>> +	if (start < 0) {
>>>> +		/* Fall-back to SN for older devices. */
>>>> +		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>>>> +
>>>> PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>>>> +		if (start < 0)
>>>> +			return -ENOENT;
>>>> +	}
>>>> +	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>>>> +	if (!sn)
>>>> +		return -ENOMEM;
>>>> +	end = strchrnul(sn, ' ');
>>>> +	*end = '\0';
>>>> +
>>>> +	guard(mutex)(&shd_mutex);
>>
>> guard()() is a no-no too, per "discouraged by netdev maintainers",
>> and here I'm on board with discouraging ;)
> 
> That's a fight with windmills. It will happen sooner than later anyway.
> It is just too conventient. I don't understand why netdev has to have
> special treat comparing to the rest of the kernel all the time...
> 
> 
>>
>>>> +	list_for_each_entry(shd, &shd_list, list) {
>>>> +		if (!strcmp(shd->sn, sn)) {
>>>> +			kfree(sn);
>>>> +			goto found;
>>>> +		}
>>>> +	}
>>>> +	shd = mlx5_shd_create(sn);
>>>> +	if (!shd) {
>>>> +		kfree(sn);
>>>> +		return -ENOMEM;
>>>> +	}
>>>
>>> How is the faux device kept in memory? I guess its reference counted
>>> somewhere?
>>
>> get_device()/put_device() with faxu_dev->dev as argument
>>
>> But I don't see that reference being incremented in the list_for_each.
>>
>> Jiri keeps "the counter" as the implicit observation of shd list size :)
>> which is protected by mutex
> 
> Yep. Why isn't that enough? I need the list anyway. Plus, I'm using the
> list to reference count shd, not the fauxdev. Fauxdev is explicitly
> create/destroyed by calling appropriate function. I belive that is the
> correct way (maybe the only way?) to instantiate/deinstantiate faux.

I've just explained my reasoning why your code is correct :)

The other correct design would be to have it in the faux/ to
dispatch/de-duplicate given a string or numeric ID



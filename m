Return-Path: <netdev+bounces-165441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E530A320D0
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 09:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A84164EE2
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 08:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4CB204F90;
	Wed, 12 Feb 2025 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltdF2Zia"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614011E9B3B
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348459; cv=fail; b=Yvi8/VzejUDEInDxZlXlSQdro2PbWPwKnYIFlXHzUB8r+CIYITpfNMYNjHaAO26BFTDC5Ri+ZPNSN7E8mWw6FoIeNMT98ELkcEj1fLhJil9+dVz0Lh04++f5FwMxDjkf7N0xPwm5fCt0tkepmpfvhQbFNgCsKzuRVbCQQoyolGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348459; c=relaxed/simple;
	bh=oczY7H8t4Wbo1d8A4muWqNckXgrzOEFlnMLxFG0+qKI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oWI/HbYGkoGMQ98B5LtCQVbH80kAXe9tA1N/9I1+JT7G+JUdyj7bV5Nv6V1V1liiVTMedkb0exSWOFWizUgZBiKwhhEMJcNs3cl8Eiqni64dKD8gSGxpuEiQ1XGI2rOYrWx2mlwRzsjIIm+2Jkf6pM8FWHDKB56dEXIkRAOKhXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltdF2Zia; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739348457; x=1770884457;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oczY7H8t4Wbo1d8A4muWqNckXgrzOEFlnMLxFG0+qKI=;
  b=ltdF2ZiairlKo6sJq78AIWE64YFRs4mM7zVnE5b4IXtlUxZ8hpCoTW5t
   +kgYPKPl/Evch7GSCird/J07gZ1wcFldKutoiCF5jAu/RHXFUPrlO1rU7
   Hv6DF7mzNgqcBoE/DTdvOHkw951brAIy0mvoPNKkFmJEATj57Y/GGzwQ4
   NpTKno5LcpbVm6f21er4PJONzz/rrO5eM67UrxoF32mgcHr19zU6q8GpZ
   iXZTr4y+Ik4nI0/SBKbPCHwmZNg9TOivswRP/Omag0KShn3UaW9zv+3CI
   e4m/PhuE1Nvz31ZTB7Q5dg7t1or8p/m/Q130RH4ZzusOKhTbqcqyidb34
   A==;
X-CSE-ConnectionGUID: wHRKPBBsTK2LKFPScyaZCA==
X-CSE-MsgGUID: 3tOwNRaxSa+15nIjRELY7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51386513"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="51386513"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:20:57 -0800
X-CSE-ConnectionGUID: vR+V4OCJT7qvoFEy5f1djg==
X-CSE-MsgGUID: m8ugTB4xTkyck5flu1r5HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149945165"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 00:20:57 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 00:20:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 00:20:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 00:20:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlmzUMexiPPv2CtmyymUvuT1mkdvjp40s/WGG320vWDsoMihdFH5P+Sx+xQA0ShDcHXBiOhAmldqWz+OERp6Twp9LI4V5XgjhciE4XhHuFqUl4LTBwy0Pvu+HljbceJ5LvjC4aymyUQmw6BkMbZ8taGUFuUEy4g50kU5vJ+E4pCx7K0XIyi5GjjpbA3bYHmQGSFUZCEqTYbAoA6HSD9LcuE/06GMSm0CU0AGCF5RiW89tpshRpxmMInkzwPlJI5LGWQUc/QMXYQOqOFq3JLN2+ee6fkn+JwhCQETzyvTmEEuqk0Xg2l73onF2yaZWenRjc4ndN5ePj4h6fSWSqm9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ5wPFr4ho2LOTHCACfUSDlgmdVKKbV4srT9NkPwtOg=;
 b=tax6hFefehHBJ/xUOnnaXdkv+LKSatk42+JPgbr2eoSKvkxeZAhmQm8fE2ojyI3mU2iUGHOG4UhKADHB7eR4lsSvsjdvagrcOw8Jg2f4xqAYAaGVquA4XREHoJV+7+8/mrfh7jlk/MzBNxSFfzfMH2eVq2shXOL2KTidJY3eZL4jTf5CeYNBMnTmlXgh611i0vtI/XDPCrt+ObiDDCvlS7lTjYDGFRLBaJjaTgHyxo+acXa/NUmvVJ3+z87M2U8Mn3+TUojZ/IvEVM0w3iKt71pqUsogSeC2NMnffUbYGOhenIows/TiAC/XUolZEWeFTEsdyOtsQLYMh3PrszPJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by PH8PR11MB6564.namprd11.prod.outlook.com (2603:10b6:510:1c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 08:20:54 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 08:20:54 +0000
Message-ID: <9a908472-fac1-406e-b354-4eb4cb38247b@intel.com>
Date: Wed, 12 Feb 2025 09:20:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: airoha: Fix TSO support for header
 cloned skbs
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, "Sean
 Wang" <sean.wang@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>
References: <20250212-airoha-fix-tso-v1-0-1652558a79b4@kernel.org>
 <20250212-airoha-fix-tso-v1-1-1652558a79b4@kernel.org>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250212-airoha-fix-tso-v1-1-1652558a79b4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0113.eurprd09.prod.outlook.com
 (2603:10a6:803:78::36) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|PH8PR11MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: b471a6da-656a-42de-5350-08dd4b3e2b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnFjcmhVVU5XMDh6K3lZbHN3bFgwTWpGUkNrdlNZQUg0aEtoM09DMWZhaVd1?=
 =?utf-8?B?R0dpSmt5RE1CZ0F6NVh3SXBxWitHUFRrdnFZMElRV0ZYYjR3VzdSa2lrQUJi?=
 =?utf-8?B?OXdWMmJQL1lYR2c2V2ZRMzY0L1Ard3MrUDZ5YjErek1PaXN5VzRHUWlyd3V4?=
 =?utf-8?B?WmRRTGxDR09BcUpoN3pWbno4cUZxbUJENTF1aktXczdlekdVUlRKblRPL2hy?=
 =?utf-8?B?NTUyQkU4MXBBTWhBelRxL2tKaHR1enY1YW1VSGhLeEozbXJUNVZBWGJGZ21j?=
 =?utf-8?B?S0tPbktLTEJVL0YvRzA4RWJWTVdFMGduQmpQVVB1OFRMZEVnMjZRZjM0Rk9w?=
 =?utf-8?B?THplY0dSN2dpSXlJQ0x1RDc5RGp5dkpad3Q5eS9RMk5KRDJFaFZUT2kxQlFw?=
 =?utf-8?B?QVVDMmFZZ2tWQVNITnd4RXk3aURQNXBuaVA4cUtaZ0N0KzNMQkJRaVk5WnA2?=
 =?utf-8?B?OVcvTysrSUJNaFpVYzhyZnVueHJBeC92MlpTQTY4SEthQVRGRUdJMDE3cE9D?=
 =?utf-8?B?c0t5T0lzZnlrZmw4akV4L2JGYjZmODdUbm5kSXQycG54Y0NPL21QSlBuMW5x?=
 =?utf-8?B?SDd5NXUrcUlQbGdkWHhEZGZDTHFaMXdCNElDYnJxakx3RkZFbnNsTFZtUnkw?=
 =?utf-8?B?UDdXdUc3ckJ5eE8ra0dQa2VtWFJBTGJVSEdDNkFVMzI5dnN3aUJuaEM5NGZO?=
 =?utf-8?B?OGFweUtQYlk5R2kydDJ6L1V1NHNyVEVtNS8yTGt5azhjZlh1SzBnU3FYSzYz?=
 =?utf-8?B?clh6Qmk5MzVKRkF2RHdvOXlCeFlNVHdWZVFhYm1UbE1Idy92bTlkdWV3emEr?=
 =?utf-8?B?eGZXV1d3anBHNzVkR3IvZXhhSk8yaEtmNWF1Sjg5NnBacktVQ3JIVzhDYnRx?=
 =?utf-8?B?ZFZhbFl1SEVKUXJUNHFmbzc1WmFMWGtqdWRJRzNjSUVoc1J1VTFpeU1FZUs1?=
 =?utf-8?B?VkFVU21Xc2lqaHQ5dmdmempCcUg2cTBZeVlZUFJDY0FsZ2RXTTJQK0tINFl4?=
 =?utf-8?B?M3I3aXdMS2xqWVpiVi95TVJRbWFuL1JhcDJHcXNBTjliMGo5cElndnI5enc2?=
 =?utf-8?B?Z3dCYkl3SFRDbSthQURRYTlHODdKV05BcWZMdVpmN3NPam4xcjYvU2dsN1Ri?=
 =?utf-8?B?OHdZeGpaVzYrOVQwK0FHL2dkakhERWFzZU1FUkhHMC9ob0NuUFBsTDF5bHMz?=
 =?utf-8?B?Si9IN2VSaHlDaU9GeUp3bmhZYVV3SUsweDF5QnNWdkRmYzJsdEpKZ3dqMjh6?=
 =?utf-8?B?dHV3Um5keEFGMmtSSXhXYlB4YkRQRWhxbVo1Mk1CVFJ0QUYwMTVkT1VxSHpm?=
 =?utf-8?B?d2lhTXZuZGNCdm1reXhKZmFwa1BaREdhb25WQUg4eWxSSkw1c3krMzNZYUVa?=
 =?utf-8?B?MGZPMnZYcjJSVlVURktLWGFVR1JORzlMd2tCRmhkRER5NCsxWlIvcHQrd1dZ?=
 =?utf-8?B?UVlzbSt3clBIbC9XT0l2WldYYUhiMkU0bjRXa1kvdm9QTE9FUjdsNVhmUjhK?=
 =?utf-8?B?VW9PRndvWGlxTWNMamVSZGpucmNvN2ZOUnExaHpYc3FaTEZtbi9rbVdnZ0dt?=
 =?utf-8?B?aktOc3VxdnFNTmw5WU1vR2VTYzQ0ZnJqc3ZGSjZPclQ1ODU0dEhhMDA5em05?=
 =?utf-8?B?L1pzTTVCS1Jtd2x1QnNiYllTRmhOL001cGxZc3Yvd292ZzQ3L0RWUHZhMllV?=
 =?utf-8?B?WkVJc1loNW5lMlF6ZDF1KzR5ZEt4eVJlY3BuUXhjUUtoMEE1R25GUlgzdnVG?=
 =?utf-8?B?OHRzYzhwd0UxV2orSTJ4ckNXekVTYUpUejBwdFNoTGpTdEtKMW54WjZmZ25x?=
 =?utf-8?B?elloNkp3d2NLemM3MHlRNTlaMmpxSUlxQk55U0xqNlFrOTVGek8xVkI1Q1dw?=
 =?utf-8?B?aXlab2xOcFhDZlI4ajNQK0xEUVpwVUwwQk9xS0R1Zzlsb3NkdzBBTFBjWjly?=
 =?utf-8?Q?vV+roOuk8tI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHQzQml2d3ZhdEI1dnUraDRPSnk5by9qU3hhZXluM3B1cEhqTkl0bUdsYXl4?=
 =?utf-8?B?MUF6Wklna0ZhUEtwMzZRRTNWWXBFeUUxM1FBM2Q0Z2xMTEJROTVYWmRMR25C?=
 =?utf-8?B?RVpSQlQ0ZkxVSFFHdWxhQXU3K3N4ME1MK1F4eVJiS3ZldXMzUXI0Q3MxL0dw?=
 =?utf-8?B?SXo3cHpORGxsVEJwY3J6M3I4a1g5dW1PbTlFcURmWENvemtFQkNLVk9FUVlU?=
 =?utf-8?B?SlV0cDg0QlMvVXNsYUdvc1lwWUlhMEtwdkZtS1VjcFZiWW5EZ0pnSUtUbWNV?=
 =?utf-8?B?Yi9pNXpHbmtwbWZYenBZOVNqc1o4VFY4dHpCYjI0MWhtWVFSVGl0elEwSUFu?=
 =?utf-8?B?MXZHL1hNZW9EMlFCZEZBeERXelErYnp0UFNsYVMrYTN2SnJGVHJRNHA2dUd0?=
 =?utf-8?B?VWk5THEzY3owcExUQUROSXF4aEZTMXdFRHJ6SnA5cTMrL0NveXFHSlk0cGFU?=
 =?utf-8?B?a0IvbGoxT2FSUFQwM25JaVZMakxYRVVLVkVpbU5lSGNBZk85bkJSeEh3bVk2?=
 =?utf-8?B?UzFzMlNtWUk1UW1ramcwRUdOQUdYQ0NNQVdaTlFyQW9KYlZqZjZBQ3pueHRZ?=
 =?utf-8?B?NE5sNkRSZXZkSTJRYmZkSWlxQTkyUVZDL0RkeFZjS2luTHVWa3ZZU0ZKdEky?=
 =?utf-8?B?REQwZml6VHZNNklGdkpleitPRTJKTTZScml2Q2EveC9IVkNsYVB1V0FVRm9L?=
 =?utf-8?B?S2J1MkZtd28xSmxodHdLYlprVXpHTGNTWS8zelVPOHFYWnVwWDJqNkVWSmdS?=
 =?utf-8?B?R3FzaDByL3dQUVUxVUdrU3lna1BVamhBYXp6TUQ2SENHRUg0VWZ0TG9XajNy?=
 =?utf-8?B?a0UyeUx4bGlqeVZJQURnT2UvL0lLbWRocjRQSExWWWdrbVpXVFpWNjczejd1?=
 =?utf-8?B?SFpWOEI1QllReDVOdzV6VWlGMVNBdUQ2OXNSQ0ROS24vNUlqazlWWnRGZ2VR?=
 =?utf-8?B?bjQ5aTd5NkducythRmtVSkNvb1NrdHZvQjRRREJNblkybGRValZYVXdZd0k5?=
 =?utf-8?B?R0Faa0V4MXJEbElEeDlYempSNU1YZVJpLzZjVDdiV1BuVDNGZC9kR1ZWUGZm?=
 =?utf-8?B?elJPaVA4dnRNWGNjM2I3TURYbmkrNnZHTWRBaWUwUllENFdscHdUbGFGZUdl?=
 =?utf-8?B?RkdBalBTeWpVcXViOHZBeURSN0VSRVZCbGhBZHlkUm8rQ2FmS21GWXN2Q3pI?=
 =?utf-8?B?eFhvQUxTb1RVM2FRaHBDbkNoV1VDZmJvZ2pQTGIzdEpoc0ZpcUk3WFBySE5y?=
 =?utf-8?B?Y1FlUDRqSTE5U0xJNmpnNWVDK08rUndhb2FsakdpSVBEY2ZxY2VGeXJSUTVK?=
 =?utf-8?B?YVVQd3NvanRIS1Z5ZVNJVG5BZjdMTklITWgvZEtSN2xwR1MvY2xwaTZQaGJk?=
 =?utf-8?B?cUVlQjhsdFRsb1YrcFJ3QlpuNzZ2YVVoakNWSU1XOXdoV1FOM1ppMUgrbDlk?=
 =?utf-8?B?OVJtZkxLcm5RU0pEM1huTmJ6dWMzK25GeDB1WWg4MExNVE1rTUVNbHRFMEZx?=
 =?utf-8?B?STRvc1kvTUNLb3U2OTRIUnNHTEdUTEF4NU4wUldESzVkZWdUcndETU1Tb2lp?=
 =?utf-8?B?NjEzSU5GTnZHMnNrZkl1N3lpeVN6ZnZvZ1RlT0VqVVhXcnZLUTRweDk0ZlZS?=
 =?utf-8?B?ZWUvYmM3VHNqdHNldmV1cHYyY0RML2pJU2hhREd3TVdtSEc1eFRvZG4yWTJF?=
 =?utf-8?B?L1RVWEhObjhzbFpqd0dLb0ZSQ2FVNFAra0hNOWdsMmJCSzEvdk9qdmVvKzhk?=
 =?utf-8?B?QUtBL3VyaEp0SGYzVHJrdWQxeTAxeFplVk1pR2xoTGtRWGJCTDM1SllIY3NZ?=
 =?utf-8?B?SzBaQm82cktNS2VZNU5DUkl0SkJUeXltL2s0SytXSk9lcmFGU0NmRXRLQ0pq?=
 =?utf-8?B?UGx6dmw0WXRUSGZBaW1NQ0RyY3E2OW1ENEdPMUo2YzJpdnVnakt4Qy9JbUpJ?=
 =?utf-8?B?R2dMYytPZGVOZEEvYktlVEt3VC8yMVpXZmVlYVM3aTI3dk4weXFkUURPU1p5?=
 =?utf-8?B?S3N3NG44a0F4R2tXeUlhRC92TG95WDNpOURUQ2Q3dXZqSyt2VGFiL1U4L0Q2?=
 =?utf-8?B?WlZLbGxTQUk5MXpyT3hKWXYyWmp0ZHExOS9LMVorYlNUSzRuN0JLdjVlNEs0?=
 =?utf-8?B?TDhpNFppMktEcS90UU9XeUxnMlVjdDd4QS93RE9oVWR2YzdHQjFQZHpPd3or?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b471a6da-656a-42de-5350-08dd4b3e2b51
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:20:54.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDt9hljHXbiE0eZat2tQufCNvhqN22lCzA1frPw8w75gZ8SONUPxiwTUU++Dt35HeOomogPRYDMYfAjeKdOlzBYgZgRATSg22nrp2N8KGxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6564
X-OriginatorOrg: intel.com



On 2/12/2025 7:51 AM, Lorenzo Bianconi wrote:
> For GSO packets, skb_cow_head() will reallocate the skb for TSO header
> cloned skbs in airoha_dev_xmit(). For this reason, sinfo pointer can be
> no more valid. Fix the issue relying on skb_shinfo() macro directly in
> airoha_dev_xmit().
> This is not a user visible issue since we can't currently enable TSO for
> DSA user ports since we are missing to initialize net_device
> vlan_features field.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/net/ethernet/mediatek/airoha_eth.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
> index 09f448f291240257c5748725848ede231c502fbd..aa5f220ddbcf9ca5bee1173114294cb3aec701c9 100644
> --- a/drivers/net/ethernet/mediatek/airoha_eth.c
> +++ b/drivers/net/ethernet/mediatek/airoha_eth.c
> @@ -2556,11 +2556,10 @@ static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
>   static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
>   				   struct net_device *dev)
>   {
> -	struct skb_shared_info *sinfo = skb_shinfo(skb);
>   	struct airoha_gdm_port *port = netdev_priv(dev);
> +	u32 nr_frags = 1 + skb_shinfo(skb)->nr_frags;
>   	u32 msg0, msg1, len = skb_headlen(skb);
>   	struct airoha_qdma *qdma = port->qdma;
> -	u32 nr_frags = 1 + sinfo->nr_frags;
>   	struct netdev_queue *txq;
>   	struct airoha_queue *q;
>   	void *data = skb->data;
> @@ -2583,8 +2582,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
>   		if (skb_cow_head(skb, 0))
>   			goto error;
>   
> -		if (sinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
> -			__be16 csum = cpu_to_be16(sinfo->gso_size);
> +		if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 |
> +						 SKB_GSO_TCPV6)) {
> +			__be16 csum = cpu_to_be16(skb_shinfo(skb)->gso_size);
>   
>   			tcp_hdr(skb)->check = (__force __sum16)csum;
>   			msg0 |= FIELD_PREP(QDMA_ETH_TXMSG_TSO_MASK, 1);
> @@ -2613,7 +2613,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
>   	for (i = 0; i < nr_frags; i++) {
>   		struct airoha_qdma_desc *desc = &q->desc[index];
>   		struct airoha_queue_entry *e = &q->entry[index];
> -		skb_frag_t *frag = &sinfo->frags[i];
> +		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
>   		dma_addr_t addr;
>   		u32 val;
>   
> 

Thanks for this change:
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


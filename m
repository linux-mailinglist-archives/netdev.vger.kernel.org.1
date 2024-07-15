Return-Path: <netdev+bounces-111626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E341931DA1
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8371F22705
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844213F42A;
	Mon, 15 Jul 2024 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnABAj26"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AF6BFA6;
	Mon, 15 Jul 2024 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086222; cv=fail; b=q5NGXZnibYjH3DjXb9+O6uh9M/EGa/zdpvGz3cNuVrjeIMu2hm3euukJ6EKQAMwLWx7IwaO5m4l4yBA/nqXtQSIk2gcWS8XAbNRwN/CQvl2x2bAb5Jmm1ulthcychK2ODviCFzU0yTOxXREYcPFjPc1sfdEs/2YLBeo+EYwBEAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086222; c=relaxed/simple;
	bh=gfsRN6ASOacJdchOp67/seXmH5fVDOVBN9m/NPINrXc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SmQoAzETi0U2mjg0OIoH4dDMKaw6CjNR1BPlp1gSHhUiZS7HVVaEIRrmOHVHhB+VEr7kq+GMBRhM1CIl6qg/oyssJfC1lH2XvCpWyjqblngTI2T7PgLWPngCm/XV7ggCO+LlNLVBstygSprjuIdK/r3DjlKxYLM6ASfj/6UF2IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnABAj26; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721086220; x=1752622220;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gfsRN6ASOacJdchOp67/seXmH5fVDOVBN9m/NPINrXc=;
  b=RnABAj26+FtixnqYUlnDbz/WwVXs9jUe1822OiHmlMhxMo+zDpqYiKJu
   khBlmgK7jR8c6WSrWEM3y+040+3cbPLvnq1u39o3bsUNGGOASJTD7H0b4
   wluUo9olcKNkSW4ABeftwLNp+ni/9JBLriyen53Y3IXQlvu0xTlIBwJIL
   EZclta3tRTPStQRVADckB77iXQ2q2das9cDMgEH+XR3T6zlgu3123BSVN
   9zs7eQlHfdHV5c6L8OzUy6kV14b4rrA0uV3LGG49gimvXnsfBDXWoYWBg
   J66ns+9R/rZMswfUpeyxH5aEdOjhUAgc32XvyaJpL3ENg4PCGTqS/ru7e
   Q==;
X-CSE-ConnectionGUID: u7n2+JgLSHiVh09dcXJzlQ==
X-CSE-MsgGUID: v5tU4hNaTJWvgqXATvMVVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18633475"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18633475"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 16:30:19 -0700
X-CSE-ConnectionGUID: munv+jUtR0O53tpuMOgWjQ==
X-CSE-MsgGUID: QOxCNuDrQx21ZS0YG8PloQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="80871666"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 16:30:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 16:30:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 16:30:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 16:30:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 16:30:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx48AgtEwRJjcKFLBNnzGngakXfAVrMKY+Wm/gmFpBUngPlBCuVPpHXxUQ2vZSbd7Cj5scKLnDvgQ41OxmAXMd/jfB1CRNZdZMUMv2n6fAU0ZQmB9siPCU1SMav0v6ScN8RuCORHGicvUshVDPKJj6j1IcATP5b/gIgJgf/6ow+tm/uBCg3jlechw4Trekr+3BD/4jViUWI4+wTgc0GMRNqoH2I07IskvT945nFOGqPoYuaRlSwDeY3P64Wr071i/J8JdpIC3qn1GPwCnR1OnyvMPysylKMYf59n0FccDFaCmvKbOFM1D2RkZpvGs4eykR61pVhQ059T16/ew7a2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uafe0FHOP0FgfrUS9jqmJ5fGfbo5jyc9puSTRqG5opI=;
 b=fd+Pn91O5UhVKzwDJHGzS4HoyCRySpXpqs5BtooqoRHMw/+0oEbx/WSHq2W8Ych+T/fnpv78Q9etqEYgkkLPFoSovhTF7wvBoeHN3aIiyJigOnTKJGq7tmAaagkq+DECsmUPF4UErnCazZNGB8CyZxzBQVsPmJCf3jt/V1I5CuQfWkR27iZQlrAxOfrNmbe2B3ABki/a6cQF2avwGb7+Yi/qZZSvGm4HdsRzSn/BVE5tGdkMYa/6leIelxPr3MZ+S6Sa70K/CLuXcctxhGbL0RM8h77cjSnNFW0Rdge45s0LZgqkzsCR1dF0YDCDNoNtA8czGxAKngEZsmtKyIMLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 23:30:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:30:17 +0000
Message-ID: <8d5aed1c-5a85-4e61-a04f-659010ca246d@intel.com>
Date: Mon, 15 Jul 2024 16:30:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 03/14] net: Make net_hwtstamp_validate
 accessible
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, "Radu Pirea"
	<radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>, Simon
 Horman <horms@kernel.org>, "Vladimir Oltean" <vladimir.oltean@nxp.com>,
	<donald.hunter@gmail.com>, <danieller@nvidia.com>, <ecree.xilinx@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-3-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-3-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee451e1-b1a7-4bd7-b9fb-08dca52615aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z05vZlBmektrTVRGc2pNdzdMa0dJTEs1bmt4UjBmY0d5ZlcyNFBqb0s4Y0ZK?=
 =?utf-8?B?Z09sMVlJTlFNNExwVGxZM3BQR1R4N0NDRlBHQXhmY3VSTG5ZcHcwRkcyVmN5?=
 =?utf-8?B?Yi90K24rWHZQUFdzcFpNSVZTb1UwN3JaM2h4eEQ1bUtkQ1pZcTVGeUt6VUwy?=
 =?utf-8?B?K2g4dzFDZWdmNWtzaUFyck9RR0p2WmNaek52UmF0VEhhUWRYM283TE82T2tG?=
 =?utf-8?B?UHc3NWIvMjN0czJXcEhhUmNNVEJISUNXOE1YWG01QVRNUjlFWDJlYWFqaE5J?=
 =?utf-8?B?TnhqWUhpbndMWU5TZjdSUURhdEk1NXhuSm5tNmdRZGhHVDBEdlV4aU1oNWMz?=
 =?utf-8?B?K0tGUFdTZGt4Q1dXR2hIeStRUjZ2ZFdtVXBSQmZQTXczTVRYS2dYQU5WV0RX?=
 =?utf-8?B?Y3AwV1dmaUtMaEdub1NBaHRiUS9sYjJXOWZqbEZ0UzZMdVY2VVA2eEFHVEY1?=
 =?utf-8?B?akZ2SXpEdHZiaEwyRDh6dnhxVHFXelllVktWcnIySEhlWHBDc2hDOE80WDh6?=
 =?utf-8?B?TTFtZkhyV0drdmozZFJqUXpGbHJuT1pVU0ZveHNvQjdGaEhmUm8wbUxEOWdy?=
 =?utf-8?B?VjV3TTYrSWthWkxBR3M2TlpqZVlHSDlUS2o5MkRiM1lqL29nZUJhcGJlRlJa?=
 =?utf-8?B?MFBIS1ljRjY5ZC9HbXo3UkJpL3p5VFR6RmFlQUhmVVl3YXBZeWovZWp3Ukky?=
 =?utf-8?B?dmt2UC9LcWdLS2dLcU83TVZpdWpJMFlybVJkcGVRLzRVcGpsM2tLMXh0MUhE?=
 =?utf-8?B?QVdaTG9NTlp5S2x0T0t4SUF5c1Zoek43d2h3M2tORjMzeGxRenVJaTVsNjgy?=
 =?utf-8?B?SVVNdXpTWDJXQTR0Y3dIVVY0RzZBc1lMTmVlM3dvdG9vYi9Ec0tvSnRja0lN?=
 =?utf-8?B?cFNneU8vMk10QUpJZ1VSeTNYTkRCZkd0TndLMzZtOC9adUppRUt0V3dwUkJQ?=
 =?utf-8?B?eFZGd3ZUNENpVnVCT2RuZGRqanFtQ1o2N29HWmYyL1VTYWtTS1Z3b1BpbXNC?=
 =?utf-8?B?WmdDem9aamVTMjJRTlFtUEdxdys0ZmdnYzdCV1U2T0E4SElpd0F1Q0RrRUNx?=
 =?utf-8?B?Z0IwTGdoajFVN1puVHBUa1FKMDBNYlREckg0VytUWjFrK2hjeEdqV3hIU1Bw?=
 =?utf-8?B?RVJEdTN0ZUJUckJYQnFKdURubGNyQnZ1ODRISnlLWUVYZVFKQURhcENuYmJU?=
 =?utf-8?B?VGdnM003UlJ2eGFUTGJIakhMQVhVcXNiMlF1eEhZWStQSlAySlEvTDJ5VWJH?=
 =?utf-8?B?RytBQkJXRzl6SVNTOG9kakowSGg1ZkhtOENIaGVyb3prVlorbjdMdkFmeXg2?=
 =?utf-8?B?WmM3dzNMTUxaZXVTZCthNWd5NjZndXVlNk5qQklOcm1GQ0QvZ3dpRHE5YmFW?=
 =?utf-8?B?bVo0eUNuUzZacDdMb3U4VUFYU1BpT1hIakhqZEJUTW9QUXhLTk11RXdMVm5T?=
 =?utf-8?B?ZWxMKzFXNENXaWVWTHgyVjVwaWVHSXcvYkFmQnBxSThyQlJMaXpCWUJtUDJ5?=
 =?utf-8?B?THo1MkZjSk1rUUdNMlFQS2hUTnpEVzF1dkh6aGJlTUc4WWhYY0IyWG5ZcFJm?=
 =?utf-8?B?bHY3MVFHTll4QlRWMFBEZ29aSjJrWTV4aEZiY1RaZ01lc0xMWlF4TEYwblRY?=
 =?utf-8?B?UWg4Z3NzajlaVDdmMEZ3WTNBU1ZKaW1hQU9NQ012M01YYW5IMyszMHlvOExF?=
 =?utf-8?B?dVl3WFRXTndwQnJRVXlYOU01RTFqcXdDazhyNTlTN01yOHlBM08xOTJ5RzVl?=
 =?utf-8?B?N3VTWU13MzZGVHFyaUJDZVRveEVLclMzY2xyd3lQL1hWcW9mSFkxNzNNaFI5?=
 =?utf-8?B?ZDBnRjFQZm45Ri9QUE1NTVZydXNsRCs4OUdHRldqNS9ZQXFlQW1CYXlOdUJR?=
 =?utf-8?Q?+EeHf/joRuapL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZllMcUJoczBRVGpvUEdEc1QydFZ3VHdKQ2xYZFhTdXB1dnNialhGa2ZCeWN4?=
 =?utf-8?B?K2R2VmRYeVc3T0t4cXVJSXNsenFpNklOS1RuWDV0TnArT1RkNnRDdkMrVlN2?=
 =?utf-8?B?QkRwT2Y4TlpVamgwMTdkbXhjd05VMGJ0dWRQdDNqbWZJeTZRR29PSmJqZ2Jq?=
 =?utf-8?B?em9Vb0dBQ3RlSnMwTVlKOVpVOU91U2QrekhINkVFU1NzcmQ4bFZpZkl6d1NT?=
 =?utf-8?B?L2g5UzFBaVNXUjd1eFc5THBuUnYyUFhsVzJ1V2F4d1plS1YzTnhGcjFLVnpw?=
 =?utf-8?B?K0RPMkhVWWFmVDB4d0hjaDFxK09hR3d2L3gzQ05veENNR2QyQnZzMkMzbXZX?=
 =?utf-8?B?a2JpVVg4cFNxUXNtc1pyTmw0RlV0WXFjZDlUakgraGxlRXpscENPdW5zQVhB?=
 =?utf-8?B?cS9ZUCtpMzE0NVpSNkRHZXRRZVllY21BbDRGbjJndExldEJWbWNCWGpoK2N1?=
 =?utf-8?B?cWJacWJEcWxkNkgvL2pFeVZvVUFsaktsQWROT01VcUlSdDlqZjNWcjBkNitv?=
 =?utf-8?B?NmJCUzdTTk95c0h3R0JCM3NsdmtzSittZVBNdVFMTnBkSklsZUdpYjZTM1R4?=
 =?utf-8?B?TysyNjlsdnA5Nk85eDlMaUJ5dDhyTFVaUmdWTkNIQ0U4T09wMnVLUG9ybHBw?=
 =?utf-8?B?aEdCNVNjZTJnRGcyb1JnU20rUDY3R2xJUkdCdllwTkYxQ09WQkNoVWVHYXJi?=
 =?utf-8?B?VS8vNGNLUnYrQmd5SjdoN0FtWlNoODQ5MWJEbFJ6YitLbDlzS1d1REVkYmFQ?=
 =?utf-8?B?ak1saE9qdjEvNVdpc3d1U255VDliamZ3N0t2a3I4eVZIMGU5WFVpZVZheGV0?=
 =?utf-8?B?d1JMdEV3SUpTMjd1eUZkVGpkY2xzQXRSaWI0UlMrdE5CN1J6ZVNWMEkxYjJm?=
 =?utf-8?B?UEwrdmFSK0czMThnZXpkSFlzZWhQYVZBSDRyNXUyVnUvcmhERkhRWk16TzZi?=
 =?utf-8?B?N0pzOWhZS0VzUzcyWUV1dkNnM2pSQTJRMVBDQVRZcEtiMk5zSWNLZ2QrYjd6?=
 =?utf-8?B?M3Z4MU4xN0x1WTgzSjZObVV0Y2xjYk5hcndEeHFzNHdKM211eVNTeEZybnRs?=
 =?utf-8?B?TTBaa0d3NC9rKzIrUzR1d0FVR3dGeTE1NkNFVm51SmhYMFdLTFhNMys3ZU1L?=
 =?utf-8?B?K2twbFpVNFArck42bkVkSGRIbVgrK3VVREVZRjZtMGxSaTFDckxnRGFUZVJ5?=
 =?utf-8?B?T2ttcG5QUXJvUjNGZkFpYzdEeWNnbDJ0UnR5bC9vYWZSQkZKYk9WTlVOTjhu?=
 =?utf-8?B?TzBDZjFiRElNL1FTTWpBNVBNclNvM0dXbUo3SWdZUlB2WjFuSVhzUFJiRVBx?=
 =?utf-8?B?UUhkK3VZV0lIY1RiYUxCbTVuQXgzUldrcTB4RmcyZ2xLYmlyMyt5alFKeGVF?=
 =?utf-8?B?Lys5ZHE4NDNNRWNUaUdscEJjNG5MaE5URXN6cm1xT0JzWGJIMlhIdS9OTXpw?=
 =?utf-8?B?azVicW5ycjlYY3d3QllTTEU0L0V1NUhlKzYvMlJxaFg3YS8zbVBNcGlnblhl?=
 =?utf-8?B?L0FlencxNC92OGszZmduR1ZWVnNleDBEajNpMXRIQVVyRlBmb2pveUNVYVJF?=
 =?utf-8?B?a2RjUU1SZHd5c1g0OG5pelQwaFBEbjBtMlVWWUp1OG5TOFc4bW9Ibyt3VmMz?=
 =?utf-8?B?dG50dVBQNnFwQmZBRjgzMEFYTUdNaEVkRVZNSmVueTJESlh2aU13VFVBZ3NC?=
 =?utf-8?B?WjlVSlcvOTdMUWZyY01jT0NtamhzLy9pdG9Vd1dBME4yY0VTSktFMWZPTGM0?=
 =?utf-8?B?ZS9JZmdyL0lORHFMS0dhWWdWMHp3Zm12NjBOM1VEejAxMkdaR0RGTFZJeG0r?=
 =?utf-8?B?NkFOYWs2TUUvYURiME9wUXVrcWovd0dxd2lVNUdHUkR5eE1KckF3cUNoOFhv?=
 =?utf-8?B?OXloTzJMV2p4b1AvUG5GeFdqRzUzQmdZNUh6YjBicHZSdlp3UEVwc0ZyM283?=
 =?utf-8?B?a2s4VTBIb2tPTzlJYkN3R0RWQjF6VmtCOVBobG9hQWJKZ0dFM3lNZXVmME82?=
 =?utf-8?B?eWNwOHhNK1hyQlF5QU1uL1hzUW5pcUlyeThnYkFTOXYxdm1hRWpQSVRhZlM4?=
 =?utf-8?B?ZE9oUEVBVUlOZW0vYU1pcWdDZVhvT1p4UzlRV0srKzBUemE5dmFVQVdNeE91?=
 =?utf-8?B?M01zUXVGMjBIOVV2eUYwVk55WTNYVENOWHBad2xvWWZadHRqWEhCRWNnZ1FC?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee451e1-b1a7-4bd7-b9fb-08dca52615aa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:30:17.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyviPiolZ8mZW1fhMu8lGUZceax5kJEAijfaw8M537qMYpaEGFCe61q89mOtik0N9uz6yaIehqj805GjGh4a9GkFzaKXajXoSZA3rwpWG10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> Make the net_hwtstamp_validate function accessible in prevision to use
> it from ethtool to validate the hwtstamp configuration before setting it.
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v8:
> - New patch
> 
> Change in v10:
> - Remove export symbol as ethtool can't be built as a module.
> - Move the declaration to net/core/dev.h instead of netdevice.h
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  net/core/dev.h       | 1 +
>  net/core/dev_ioctl.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.h b/net/core/dev.h
> index 9d4ceaf9bdc0..df085c3e510c 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -189,5 +189,6 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
>  			    struct netlink_ext_ack *extack);
>  int dev_get_hwtstamp_phylib(struct net_device *dev,
>  			    struct kernel_hwtstamp_config *cfg);
> +int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg);
>  
>  #endif
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index b8cf8c55fa2d..6aaa8326bf8f 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -184,7 +184,7 @@ static int dev_ifsioc_locked(struct net *net, struct ifreq *ifr, unsigned int cm
>  	return err;
>  }
>  
> -static int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg)
> +int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg)
>  {
>  	enum hwtstamp_tx_types tx_type;
>  	enum hwtstamp_rx_filters rx_filter;
> 


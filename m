Return-Path: <netdev+bounces-294930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ys+9K0ulIGr36AAAu9opvQ
	(envelope-from <netdev+bounces-294930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:06:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B416B63B7F6
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:06:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=FS+OL67b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294930-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294930-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2218301CF89
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FF53D5C26;
	Wed,  3 Jun 2026 22:02:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A9384CF5;
	Wed,  3 Jun 2026 22:02:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524152; cv=fail; b=WTAwU7LvN5otTzC0Za1PtCg2FHZHGxKVcusqa6I49EluMccg2ZjWARq93qI/LzQBZGgEk3FolGGOfe1ve/nnXbiLJ46edcw0H/ZK65kCRhMv9O3Wowhrw/95TJhCj7YMQamACPv4RiWYVDGMjseiqhew5raPxUQaWINnOsuw7t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524152; c=relaxed/simple;
	bh=1uir/V1PD/sIRdGqSlt5ldKcEDM9EuTxHKYWicJecGE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cAW6sUNRRidRAlvZAVoPh1GyGFf3RLDzr67eccLO/2njRvEVEApkAmCfxY9hUbYHoi+MajNJkAC9MDXxpvWmqXyyZgPGpV9a4VKM0Hd9xeQgixYRnH2ib/BSm+Tz1MqYPZqjIrxfGWSVvY9BzJROfKNnKThh0Hs6z+9ovhPBQJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FS+OL67b; arc=fail smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780524151; x=1812060151;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1uir/V1PD/sIRdGqSlt5ldKcEDM9EuTxHKYWicJecGE=;
  b=FS+OL67bF0PF6mCKD9NUX0uj/XDqzeOm/BXvT/PIGV9C7BQmIgu9WIsG
   W3M+WrPWTkfpltAN3N263VWGR5OoZ5XVd34tnAa2TVT52kTvRd4+hTbOr
   7rURz/nsL9E5wmr21oXBwIMcTrk55FlJe+zkSZVLja44cS5ZOvXUtlw0O
   jQTb4w5UvtTxlvR7KiGnTXbDIarq7YmyhV09LH3oC007j+hnPbYkKbFSu
   +Fc8YlLG5uGBo8I4off56d35JYyiEICLzL1t2rH8Y6WopQfOCUOn3ocle
   O3JTdBz0ncpEqrYUxVbRLziL15Bwbqj0/7SGfFz9XMzbJiDqZAf1K6CGq
   Q==;
X-CSE-ConnectionGUID: 4EU7dYCIQxGyxsIyQeGnfQ==
X-CSE-MsgGUID: eTbVL5ogToOK8gxI/WkFyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81324281"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81324281"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:02:27 -0700
X-CSE-ConnectionGUID: tWJd9qNvRiy9GTi+dNmKMA==
X-CSE-MsgGUID: w6AxMuaoSLCtdlKm8KGhGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="268268923"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:02:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 15:02:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 15:02:26 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 15:02:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0rNYegl19wqCUflscb9zGUTQH3RdFzzYIvAjKvFF6KieKRCCsTvrOw7OF+IOsI4FLVSS0iQj86HohdVu3bhEsXlp9dlheLG2IGZfo/u9X1L605QGbrY1OnqJKgIjeW9i4ZPjmP9LDm3GIWmU9OZFJ7RLfsC1vt/Y0U2FeMFqVxJuVxDqndOXVBafT8VbNjkgUZBXw48omJ2PEqdSDORGMRC93qCqF4lN/ErJKEIv8HuNla1KIC7T+06esq4jYmIC4627XIjhXxUHlgypqwdK4HJqAGpixqkrNL1kimKfBC+z2XvsxmbU9iR8BmtfIKQ2sCPYSiFMldvo31RkF4tgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo7zKdiVOAJYhtqSZP04bD0izo8tVND92N94TbY9xmg=;
 b=hikFXn6cJLWxVpfCu8Nbldu7GrKuWY95FUgKAvM3H4OHcKZz3V+skgSVCmRFGw+xI9pm7/FcI0v5C0m1b3ep4/OEZ+Feoj1cJIm2iyTzN3qEPN6joM4XAc6thplfvF88rnRMAZqSjyMPS+mWRSXnOB6cmlV5HSOBcPPAbcU93uoByePEwo2W1QfjNdS/YcR2lqcL+CxDdbGGup0FB/X6aEpTR5+C+jEoKaIl3GoJUkXxf4sED69wQMv3pCQp4RvMhUe+u/kbXC+L+3GoP1xUOcjFhYc7MVtI5S5KAfp9DwQ8BeJb1ce8kCcjZQSUfXyR7GVtUaraFZVH3yVMFbw6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MN2PR11MB4552.namprd11.prod.outlook.com (2603:10b6:208:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 22:02:16 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 22:02:16 +0000
Message-ID: <a46235bb-e935-4a2b-b638-6e9621640a30@intel.com>
Date: Wed, 3 Jun 2026 15:02:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net next] net: axienet: Use dedicated ethtool_ops for the
 dmaengine path
To: Suraj Gupta <suraj.gupta2@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <sean.anderson@linux.dev>,
	<radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
References: <20260601124454.3384601-1-suraj.gupta2@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260601124454.3384601-1-suraj.gupta2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:303:8f::32) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MN2PR11MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6001a3-2826-4413-ffc4-08dec1bbc5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: R7Crle3gSn9rQ8UqFhjqbiinQ4JQffWuruKaUOIE3j3/PGWRwBU2SkL4g5BUk1UxnQ/ZyGQz216mmrKDyji5+o3P4pFTPreRxFdRouaRgL50KxSS1leCKX6Aiq+NIx9YAXHLoIpMwh1i206XwD9OzBz13AybW+2KFH35PkyNgpCec7yUlFN/E+aQ0Q2uZUj9fT1kbZdfDmz4m69qD1wjxrd8qrSLUW11ggcZnmsSeRM7HyYRP7J4JaY4cu36b6Olih/K2V3UgTsK7OsDpI8OPp7loodtKVh/WFhrNTymKWDZYUdnzl3eXuobgzrpzSPIn182aK4wYFTz1bmf0Mzaoz1NqWn7eyZJvAbA0gGBJZXfpfWEW4ghgTZ+BYFBgRQvBh7LtEx0Uf59CysH+oA1HzRYXtRuBXSDFAzWLeiP4JHadgGLlpD7GvPcv3Zb0n6fGz2XDt1guk0vBzBkoqT9vKJvA0mhGfRHotukZFGGym56yy3sBrd1GXrVlp0bmlfZgXT/qN4wAb57ytNvyf8rUzKNzZYP2J2boSmNSjRQp0vcUinkrTINWMjKvbJ2Eeblv+lvKm2CO7Or4KNVleKp87kHKkh1MESVI4GVbOjnZGyUhRoUe/v9dFighnWWIO73tFL7nJWYuDNdhZANSpcqoPLZ49Gd6sumtkACWw55NBpTs6pekSNYajMPp8sTXdnN16X6YCH9RbfpkvLtGGfQI16hlx1wKRK3xA4dad5OitU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STBocFVMMXNPc3RDcnlMWHF2cG8zZkF5RDA1dEhLMElycXhKWXBUUklSZ1ly?=
 =?utf-8?B?Sy95VlBJdStieTRHbEZxNmNTS3RldE5wWFRkMkFzcENiVmRsNDJNK3l5cWdl?=
 =?utf-8?B?UDB0ZEs4bHd2SGIxbFJGM2cvSFBHTENxTlB3ejN0UGtjZnh4QWJtRGY1M3dL?=
 =?utf-8?B?c3VIbnl3WDBFYXpNZzFpdllNZXlDTFM2ZUcySElzZXM1NHNBQTNLZVJGQ1BP?=
 =?utf-8?B?dFBWR25BemVnTzk0S0lMWDBhV2JSL2ZwNkduUGxHTUVMajNreVhJZmlueUtO?=
 =?utf-8?B?bG5hTE5GTHVsODBpb3FSditJY0I1cmN0NUhYTDFCdUNXdExIeVJpaHJpT3A1?=
 =?utf-8?B?TURhOXd2SUh1VDZkSElTbTRlc3E3RStwMDlTYWsxQ01GbEx0SExVTGw3UXdO?=
 =?utf-8?B?NjZCQVEzVGM3OVlzbnUzcWVGSGVVaERHRElPaUpXc0pzK1lFOW4xYkkzMnhG?=
 =?utf-8?B?YmNEQW1nMGtMeTNoMU1hbHh5aTJjaGl4cWMyc1BmZ0lESHF3Q29iOEVOOU9H?=
 =?utf-8?B?eDlDNHQxeHgzTFFuY2Q3b3VOVjMxL2FhUEh0STZtUHVkMEJ4WTI5Wnh5bmto?=
 =?utf-8?B?dklvY1FZZDRuY0JqK2wxblE4Mzg2UU9LelVwSzVmQW94ZytxWUJoMkhRcEQ4?=
 =?utf-8?B?bi9JM2s5VUw0QzI2Z215NGgxbU9IeE1OVDZqNFZQTmdzbHF3VW00cms2UmNO?=
 =?utf-8?B?Z0JKVyszeURRWUhVUkRkZFRPTUNkZ0VFbjUzNDlsRGtSbXdpd1NkKzI2VnJL?=
 =?utf-8?B?aXlJb2JyK0EvZFV0aWo2NEc5ekN5anVBT2JVRngxRGZ6anA4KzRoRmdZVGpS?=
 =?utf-8?B?Z2ZidEJiZzViRWdFem5yWFFlNy9PRGJpN3YyREZOTGphbUNSN2VtNFcyV3pp?=
 =?utf-8?B?bTBhTkFmcXpjK2pURGY3SldtRk9abk5vQjFQOVhmNk8rQ2NOa3p1R3lqWk1w?=
 =?utf-8?B?bC9YejdsVG9JcmE2cWpUUG12NHVhREdnN3Q3TFc3ZFc4MmRUQ3FocjVtaC8v?=
 =?utf-8?B?NDhlTEh2djlic1pmKzk3WTNYdTRCR1BUNEV2VjFGSTZaY1lQTi9CZXFRd2lC?=
 =?utf-8?B?eXNraDhyZy8vNGJwZnN6aHVmL2xTNGNsYUF1UFhJOXEwUkxYWVRJOWZQcllp?=
 =?utf-8?B?dGUrWGo2a0ltMjlmOGxRNXlTbDBMNUgrTzBKRGMwVEp0diswWEVjSDdzdWM1?=
 =?utf-8?B?dWhIc0RKL0k2SHlQMEFnREJxZHpCOXRVdldXLzFkMThqVWRaaCtMaTliZkxq?=
 =?utf-8?B?My92L0VRZlZ4Q0VCVmJkaGtnRlJydjcvQ2RUem9zY1NtSTZsaGxZS01BTStz?=
 =?utf-8?B?YVN4U1BZcWhCZHZHUVE2cmlJVGZrRzJtNGIzSUQ3aWJlMDdqZFJVNjY2UnRB?=
 =?utf-8?B?cHUrMHBZUFpxYjhqKzNBV0Z2OEl4NVc2WWdRZFVOeFNvS0EvL0VHSDE0OUg3?=
 =?utf-8?B?Z2VSY3ZiMjk2U2Y1eW1kMmRuc29ZcXA0cVo2NUYxakpxR2FBVDFpQ1R1R3dB?=
 =?utf-8?B?eE1JMkNGSFNrbmtvQ2NMdGZzSHpoRG96TVRibzdtMFBmbXROM0ZBTmhiRFVP?=
 =?utf-8?B?V3ZvQ1RSRCtrRFd5TC9ORGNIV2U1WWNVOEdONTEwbHdFN3BkWUVUYmQxQlA3?=
 =?utf-8?B?WFZYdkFTZVdPVDRPYTFyVUpkcFdMaitvVi9JVzBvSjBUeXZobFpSY3lsekkv?=
 =?utf-8?B?THpCelNibUZJVlVjb1c4blFXNUVsMlZxaW9XVzJMZEFNbzY5bEVzS1BCUDR1?=
 =?utf-8?B?aUVIWm10enFMOEwxNk1PNXZSWWJjWFNGaHhoY1dyTkM4TlRkRzMvMHlRWTUr?=
 =?utf-8?B?L004WGRnbmlhcCt2MkV4MGRSaFJDeHNUUXR1RmJoUzNwZ0tBMzhmVlFqY0ln?=
 =?utf-8?B?VitzOXVXSHM5ditkeDNNS1FFYXhzOWp0a1NKSE1JdTZGT3ZCQjNYOTRNYjFN?=
 =?utf-8?B?bFpYNy9KN2FvTGdETVhueUNFa044TGpiQVlUV2RSeDFFSDVsV2xiT0g2aXpU?=
 =?utf-8?B?UDE5NmVSQkZnNXZxRlpnNFJ2VDBqak1ZR2NBbzMzZTYyWWtuNnhaRVpKQzJv?=
 =?utf-8?B?Vlk2VkVvTTlMWTZycEhtb1FWeXVNdzd1RncvV21LNzdIeHBKOUJ2bld5SzdU?=
 =?utf-8?B?VjgvWU9QN1QzaTJxNHg0UU0xMTI3QlhVOHRtTkN6YjZrMVRqdUx0eG1nNDNU?=
 =?utf-8?B?cHJ5Znk2WTcyd215WHJxblZBZzM1ZGlBNmVPV0dKQ01nVjVXYmMybkZLWFZX?=
 =?utf-8?B?NkFzV05iR3NCSmJwL0JnVTFJeERrRXphN2JFZUh2cWtIYlVvdTc4Q0VnODF3?=
 =?utf-8?B?cFFLTTZVa1BCMno0eTFqMEZueVhMczk4UG5XYmNPbDcrYWZGTFFBcUV3QmRD?=
 =?utf-8?Q?a2WcMNcTcx2GivO4=3D?=
X-Exchange-RoutingPolicyChecked: YPuJ154eXZSjS8kDr9zcU7JeFJJHL0FA62fJ/02Z8GVNYhiLGeromY8lof3YaLiW+gwyIMs56UH7a/qm2BmoBavhqj9lgO9gYf7nkBmWDyYabruxbw9LEs0LYHFI4+SjdQk4kxXfnkdYbXvinpzljdxIBT7SWM02tQbR+RWJE8ctrqX7FrkuxcvqWoaexCeJjVFJ7o2vGWSQmRYGKIOLgavOWE1k/GMd9KRG2bm5sV492sEsoiZe+72X+CcszW+dr4j4JTkP8OIaDIk5Gh0l0A8C2ka/YyqDbzAjU+3FcBzZ545dLHAHEM4lvow7rcg254AfPAhB/w3JS6qvz5VrwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6001a3-2826-4413-ffc4-08dec1bbc5ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 22:02:15.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVV+Ioxw6ImWM9yhvgw/X1sinOWQkMhheiKHkiCtM3ck+6wf2uq1clVmlzWYEF1XvNAGLX0uxaig1l6KzUV0otcIhqgQzoXP1CzX+MHrQto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4552
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-294930-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:suraj.gupta2@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michal.simek@amd.com,m:sean.anderson@linux.dev,m:radhey.shyam.pandey@amd.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:harini.katakam@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email];
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
X-Rspamd-Queue-Id: B416B63B7F6

On 6/1/2026 5:44 AM, Suraj Gupta wrote:
> The dmaengine path shares ethtool_ops with the legacy AXI DMA path,
> including .get_coalesce/.set_coalesce that poke XAXIDMA_*_CR_OFFSET
> directly. In dmaengine mode lp->dma_regs is not mapped by axienet, so
> those ethtool calls touch unmapped/unrelated memory and report values
> unrelated to the channel actually in use.
> 
> .get_ringparam/.set_ringparam only touch lp->rx_bd_num/lp->tx_bd_num,
> fields used only by the legacy path for BD ring sizing. In dmaengine
> mode the descriptor ring is owned by the dmaengine provider and these
> fields are not consulted, so reporting them is misleading.
> 
> No dmaengine API exists today to query or program either coalescing
> or ring size on behalf of the client, so neither can be exposed
> meaningfully in dmaengine mode.
> 
> Add axienet_ethtool_dmaengine_ops without the coalesce and ringparam
> hooks. Also move the ethtool_ops assignment from early probe into the
> if/else alongside netdev_ops, so the legacy and dmaengine paths pick
> their respective ops in one place. No functional change for the
> legacy DMA path.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 263c4b67fd5a..fcf517069d16 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2536,6 +2536,25 @@ static const struct ethtool_ops axienet_ethtool_ops = {
>  	.get_rmon_stats = axienet_ethtool_get_rmon_stats,
>  };
>  
> +static const struct ethtool_ops axienet_ethtool_dmaengine_ops = {
> +	.get_drvinfo    = axienet_ethtools_get_drvinfo,
> +	.get_regs_len   = axienet_ethtools_get_regs_len,
> +	.get_regs       = axienet_ethtools_get_regs,
> +	.get_link       = ethtool_op_get_link,
> +	.get_pauseparam = axienet_ethtools_get_pauseparam,
> +	.set_pauseparam = axienet_ethtools_set_pauseparam,
> +	.get_link_ksettings = axienet_ethtools_get_link_ksettings,
> +	.set_link_ksettings = axienet_ethtools_set_link_ksettings,
> +	.nway_reset	= axienet_ethtools_nway_reset,
> +	.get_ethtool_stats = axienet_ethtools_get_ethtool_stats,
> +	.get_strings    = axienet_ethtools_get_strings,
> +	.get_sset_count = axienet_ethtools_get_sset_count,
> +	.get_pause_stats = axienet_ethtools_get_pause_stats,
> +	.get_eth_mac_stats = axienet_ethtool_get_eth_mac_stats,
> +	.get_eth_ctrl_stats = axienet_ethtool_get_eth_ctrl_stats,
> +	.get_rmon_stats = axienet_ethtool_get_rmon_stats,
> +};
> +
>  static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs)
>  {
>  	return container_of(pcs, struct axienet_local, pcs);
> @@ -2792,7 +2811,6 @@ static int axienet_probe(struct platform_device *pdev)
>  
>  	SET_NETDEV_DEV(ndev, &pdev->dev);
>  	ndev->features = NETIF_F_SG;
> -	ndev->ethtool_ops = &axienet_ethtool_ops;
>  
>  	/* MTU range: 64 - 9000 */
>  	ndev->min_mtu = 64;
> @@ -3021,10 +3039,13 @@ static int axienet_probe(struct platform_device *pdev)
>  		lp->use_dmaengine = 1;
>  	}
>  
> -	if (lp->use_dmaengine)
> +	if (lp->use_dmaengine) {
>  		ndev->netdev_ops = &axienet_netdev_dmaengine_ops;
> -	else
> +		ndev->ethtool_ops = &axienet_ethtool_dmaengine_ops;
> +	} else {
>  		ndev->netdev_ops = &axienet_netdev_ops;
> +		ndev->ethtool_ops = &axienet_ethtool_ops;
> +	}
>  	/* Check for Ethernet core IRQ (optional) */
>  	if (lp->eth_irq <= 0)
>  		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");



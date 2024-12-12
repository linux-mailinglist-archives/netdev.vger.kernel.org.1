Return-Path: <netdev+bounces-151568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5985D9F003C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 00:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947301885077
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1C1DDA37;
	Thu, 12 Dec 2024 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReR1n/1R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD81DE4F0
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046499; cv=fail; b=A8dMZnIeG12jdB7nEjW1QXaOHWQEuydsIwQtjS0yDaQaJPyikOaY8cICGnXZSgu9YSVrWEbJcpNeVyuX2XO7G1NDI1IDWWSDhqpzdgygMyA38x/wc7Mk7p5Qo7LLNMN+Zi6aG0J3RxUjyWxjbfvnn+cy/ay804/oQH+WYhzWqGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046499; c=relaxed/simple;
	bh=cHq7Md0SDKwOYViwYCFWHdeMeiGwcNk43RiEx+CHItw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k5tGMH7F8vrZZV1cmIE9eDRfywkLfEz0yyqCYF/mqx+UzP9q7TPI4mZUSbLH5htvdqhh8nccwgNakZFjj1TpQTu2dzlrCqPVTxD3ZSxG2HOIMh6+5dcM5fSEoJCzqGpSES0Vvrn9enpMkjbLRJqkZQ2Od9QhEtpogq06HHRoB/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ReR1n/1R; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734046497; x=1765582497;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cHq7Md0SDKwOYViwYCFWHdeMeiGwcNk43RiEx+CHItw=;
  b=ReR1n/1RRv9IaTuKQV5OFWLXmU8s4/eAjqv9i0OBWcr5QqbE59Wf4pcR
   Q9PaR9vp0qPpuh6QFYQFAfCe06h76f7WBPp3DjiGXZSoAXSE3+Y62uem1
   24tZE37H/wo0GpcwK94uVpPnTsi4sIq+jCnAk8YQ53NO5FwUVO++ywnse
   fQJpf1VRYMCLuv4cIHNohnMsjHbZyjSZBdvGIGb6HrpVEkxQMnIy2iQgq
   6fspfb6aaKW12Gp3Gpjat/Xn0gO4IyAQjDgBCuyMuKM7NWe+4n7IZWLgd
   b/RXNmglFvaIPiuOqra+BvBtFK5F4GKJDkQ4EX/ZJC6fPMUTaorVbhiPb
   Q==;
X-CSE-ConnectionGUID: mmztU6ZjRpiNavpmh1N7BQ==
X-CSE-MsgGUID: GO18PkPdTPqVtvwt1mv52g==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34620453"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="34620453"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 15:34:53 -0800
X-CSE-ConnectionGUID: XsLJtHBcSkGbi4UpnlStdw==
X-CSE-MsgGUID: Tqg2a+Y7Q/+hOIn67ZFiSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101330936"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 15:34:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 15:34:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 15:34:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 15:34:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAZSr5stx8IVSEmkJqjFiqGA4z22W/zmgtc9KnEjU1gNiCPnwnHhfoaewBemN3/XymBlbbM4tdvX8DWrxkcAFo4gcveS6nIXpFNodJf3jY6/EftWQj3b+Hgo0+DWMIeQAq2Z9ncuE6YZIQWJD7/+Bs+07F2/0mLfbPiYXYPTgqqHbYZ7wmvgM8Mq5hc2IKUVhTh/zdgc0irx/xsSorvlhpRUNs93tofVvkbA+swy8lFV8dR9JOdGJXx1A6U/lVtvvyodqJQuyMtz+8hqD3q1UcsrMgWmw5/3scvnEVSaxyhpPW/u/1OAOpM9SB0zOcNKS7RLd9+XO5hLwKo/7ftRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPfuJdayOHBEQLU0kVhUWKQ1KyytLeifReoyVsFPbdA=;
 b=qAcvxeuGzZOLvig+cx/wAglzwH5Y68IzvMRmqyNJw8iMInDfCwF9xic7p72aMsp1gX6dQQmjoILJLBUkAly71X/Ua5BHxu6Yq1KOJ3jPW2xMFkt2igbvHbGLZvqPfC0/9e+hbcSvliDAct2lU/wReB26ugHpaUu0Tn8V1GEFdHwOi1uiujlCNZkKiM0yX7Bc2WknU5DlxOycPbbpxJIDsZfK2Z4DsEV9ff7x0Feu53HXYzWaugbWBNna18VkFCL9oWu/L2V/MDnpMFe1jYVrS4WcSOzyjUtz7KgRlZUDgl+4WKVUEZGCmXc/rlGqQui9J3MMRVD/kMxOgjFv1qgfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6177.namprd11.prod.outlook.com (2603:10b6:a03:45c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 23:34:08 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 23:34:08 +0000
Message-ID: <2beac161-115a-4ca5-b40c-228c50cf8651@intel.com>
Date: Thu, 12 Dec 2024 15:34:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 0/3] ionic: minor code fixes
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <brett.creeley@amd.com>
References: <20241212213157.12212-1-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241212213157.12212-1-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c509508-c6bf-4b2a-7c1c-08dd1b05797a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDAvVVBxdmx4UjAwcGliTDIxUEFnc3VKS05JVjFoQWd6a3BMN3hZS3BQQ2c0?=
 =?utf-8?B?YXpITW5TMzNrd2Q3SUVSTjArZzBMa3NHMjRUaEdBWVEzTzJpMGZzckVRR2hR?=
 =?utf-8?B?KzRTNWhmaGthYnBrdlpDNTMzWXFZMW0xeDBSRWUzSzhZSkJERllWRHREMVdH?=
 =?utf-8?B?T0ZXWmhLRE15bzRHMjJBSXpLYlZEU29oTTlscWVQYUdNYXhiU1ZlWlBQb0xs?=
 =?utf-8?B?cXhxRUxwRi9vVmN1VnZIdmVLMG54SlZjOWNpQ3B1ZDRwd2pCOVQzbS9aTUtY?=
 =?utf-8?B?OVlIbmJia3JTSGR1NEw4OGZyZWs5M2szMHVMQm5pUDh3eXJLMnE3d2w2YUZE?=
 =?utf-8?B?SGVzczlRNkdHSUJUaXVOWnJiWmxDN1FWZDJuNFJPakJKYWtSaEFvNitFQkV1?=
 =?utf-8?B?N0syVktRUWpEVmw0YXI5eXVWQ3VxRFdIRDNQTUpaTDNCUEJSUjVjZU5BaEx4?=
 =?utf-8?B?bEt4STc4b1k2MXlHMnhvRS81S0R5a2s0L011cDY1Rlg4Vm9rdXZ0OU9QMDNC?=
 =?utf-8?B?TllPWG9NeWQxKzVyTlVMNUxxR2srYVlsT3pSd25MVk9xQ2ZLTFNKQm94VGN3?=
 =?utf-8?B?U0QwU1ZwSkVlVG1Nb1o1WDFIVEpNOEdCb2xieDJuUi9LeDlJNHVRZU15Slgy?=
 =?utf-8?B?bmIwQXEvOHpHaDdRamdSd01TZWhNSGZNT0c5OVFLWk5zQklFcEdnaUlvRytl?=
 =?utf-8?B?aHh4emZMNldQUTExQ3ZZN3NHZ09OMW5KYWZOTzEwcEUySnRKVU5ROFkvVnhP?=
 =?utf-8?B?M1ZYKzNpeWgzOHQzcThLR1NEaWRLVE9mbEFtR0FaaGJQNCs3aXFrYzdQOUI2?=
 =?utf-8?B?V0tRM0VmUWRKcDIzOVpsSXNvdXlLRytHdnB3TjJFRTdzc3ZmaFNMNThna0Fl?=
 =?utf-8?B?MVRvWGx0NDNxdmtLRy9NeGlFSXhvN3FnbHVlRnh5YXRDbjBZZ0J1K2RGa0pR?=
 =?utf-8?B?L1NqK1BSU2hQU2pDWXM4ZjNlN2pIcHlJem1aRktudThzYnBnQUN5aXMvUTBw?=
 =?utf-8?B?UU5MVlBtU1pVWndlUHVkNjNselJnMDJhMys0cUd3KzY3WWtRRGlvQ0phWmJs?=
 =?utf-8?B?TVo3Q2JnMjlpNitSNXhsZEVWYVg2ZWVNTVFFYTI4UUNDZml6bytFWUphd1FX?=
 =?utf-8?B?UUM0NEE4d1oyNWQyamZaWkMzaTFFaFg1d2FqL1BQb2xrYjBKaEpNZ3djSzlR?=
 =?utf-8?B?OGtiaG1TdzBtdndkM2xuWXdQcHZ4T0RWR2tYdlo5OFVEbGtNOXNjU3pDNU9m?=
 =?utf-8?B?WENiVEpHajg3UTlzWElkbU1qWVBHQW1pM3VHUFRiY09LcE05Zk5kM1Y5MU54?=
 =?utf-8?B?UUFxeGg0WTRvUWUxc1BTVEYxQ1NnY3UzRmFyYVVEakUrWVRMbm90bjR5cVlZ?=
 =?utf-8?B?SGZlaGc0QUF2TDhFQVBubTF2NVM1bTY2dk1hVnljNzRYa1V4dUFCWjlwdnQ3?=
 =?utf-8?B?b0ladUk0eFp1b3RLVEJ6Q2M2dG9TS3NiL2g2eWM2ak9yTU0wTjhJQTByMU5Z?=
 =?utf-8?B?N1pTK1dLenJ0eVZOM1hkT1pNTEVrMFVLMmNrMThCdlFGaG5NV2JiMjBRVE5o?=
 =?utf-8?B?bzhGWk5sTC95Wjd4K2xxK0JWMGxLSTFlTDJwM0doSFZWeGU0YWkybTZIMFhx?=
 =?utf-8?B?UGJXeWJvN0dFZkdCUHJQdEpid0l5bFE5MWhFb1d3b01Eb1pwb0U2SmYxS2gv?=
 =?utf-8?B?MW5NOXJsbHYxN0IydUtRSWZHdW56ZEhJRnVjSGg3aEhTM3NjTVExVlhaVVF0?=
 =?utf-8?B?d0pEN2xzdjNhLzBZRTlFVnB4QlFvNGs4R08xNWt4ekFyY2k2akY2Nyt1V3ZC?=
 =?utf-8?B?bW12YmR0NmwwcTNXUzZGUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2gwZGNGdlZyRmdPcTg5Y2lVQ1dDcXRzRGJocDRTbjdMck00NlZ0OVRYZ0dS?=
 =?utf-8?B?V0Y1MjFaTmlteGZscHNvNmRhVUZqblQrNy9lM3g2QkpnalZlOTZTVlhFUHNm?=
 =?utf-8?B?YW5nc3ZIcDBtTmNrOWluYkMyM2hyYTBDSzV2cTNFYitoaUNwZTNNZHFWSmZB?=
 =?utf-8?B?TUhTTks5ZHkxK2QzbUFFWHZTbTdDcEZsM0NHZVBZTHBiRml4N2NDa1J2NXdK?=
 =?utf-8?B?SDROM3B0dWw0MVZVWHlpVStrOE1uWnVXc1VaWjlBTWV4aDFmamZBbStBd0la?=
 =?utf-8?B?WW5BRTZwbzlXWCsyZ1BHbmNiRkg3RFdtZmtIUHE0ZU5ka1dkZVp2RE5NeXJs?=
 =?utf-8?B?NVdkSVR1ZnlJSFFaL0VKMlNiY1QwTk16cC9lN1F1YnBaa3pMaGVha2xQbXZm?=
 =?utf-8?B?MmM3SDRoRTUyWmppWUt6TlEybmF5RlZQb1FFSy9sVVVWTm02UERaOFVLTWNW?=
 =?utf-8?B?OE84ZXUweHlJME1NVWRlSEFEQUxocFZ4SXA5QmtWSjZnUjZtQklrRXQ5L2Ni?=
 =?utf-8?B?M0NISTRZM1VhZTJGSHlWSFVkVE82Ni9DNHZqOVRHR3ZnVGVrYXpNWmtpVGFS?=
 =?utf-8?B?MlB4bmJocnZxanpMTk53VzNMcENOSWJvTlFHb1RZRWQ4b0w5STE1SjladGRr?=
 =?utf-8?B?eGxZYnF5RWdBOElhZlJiR0F6K2FwM2Q4bFA2THM1OVluSk1CalBlMW1mRGFP?=
 =?utf-8?B?ZUtrQ2xZbUQrYTErSVg0Mk8wY1pKN1FjUFRxMVViSUt4c3hXOUJsS2FKYTF2?=
 =?utf-8?B?dUVaU2I3RHhsY25DamRPZjFSRWxWZWUxTU5kdnF5WmQ5ZTJUN3hYeXhRZThs?=
 =?utf-8?B?cFJKdWtKakNJL1dyZTkrNUpqSElpcWRKa2NnSXhveHVBZE5sWXNQNHhrRHJy?=
 =?utf-8?B?NmJnTTBKS0xNbDhra3VqYmpPb0Z4NWgvSnp0SE5JcnNBcDdRWGdQU1Q4V29a?=
 =?utf-8?B?Mm1zZjFNS0gza0dGaDc4QkNIV1dtTC8vMDFXbk5vTFdjbjROWko0eHRmL252?=
 =?utf-8?B?aDMvNkxLTHRIVjkzUkNJZDZEYnkvb1ZqR0VkQVhLbGVsNTlUb3dvMnV3eUdE?=
 =?utf-8?B?b2tqMUdKd2xFVkpqV0NKWHF5cVFrVUNpVEtTb3Z4VVJTZGpMKzNhZmxLZFVu?=
 =?utf-8?B?UGVBaTZFUWh6Ti95SEVvcFp5aGkyRytKK1o4c0JVMzJkRXhIa1RaQzZEZVFa?=
 =?utf-8?B?TVF1NlpMZm9mWXJtRGJKaURZU1VQTnRCU1FtTEZINllNL0hrWnJTS3ZtNVMv?=
 =?utf-8?B?cDBOeCtxVU5ZbTU2Y0pvU2ZVRk9xTjNiOC92TnArRlBZQU1jcmNUdzE1MGs1?=
 =?utf-8?B?QjBQY0srcUZPZExlU1FrN1o1Zy9jSDFpSVpTLzd2Y1U2UE5zTE9ORkR5MnpY?=
 =?utf-8?B?d294NFBWSTFONnhWTWdVU3lYZmJuWXorSkpuaWRtbkY4Tml0UDRETkp5MVJm?=
 =?utf-8?B?VkdVR3dWMW1PWVp5Y1M1VG12VFFkQ1dFT1dkdjFCQW5lbTdLQ2JzMVlESXZZ?=
 =?utf-8?B?OStvQ0ozTy9DWVVVRUZTbzVTYmc1cGFYeGVjRmtMRm50cXRkbllraXVhRXhn?=
 =?utf-8?B?MmVCc1k2Z1h1bEJONVhBbWYwRGVWNUZ6eHVMOVRBRVF1cHFMU0J4QVdyUzhR?=
 =?utf-8?B?TGxTWjRPSnRGb21NWjBmYUJocHJYdXZKTlRsL0pqLzlKc0Y0SDlaK3YzaEd1?=
 =?utf-8?B?YmZQeE4vbFBzNS9FZFpvREZ4N2VoOUtnTnZLVC9xN3RKMlkyY2xuM0dBUXJE?=
 =?utf-8?B?VXU5ck94cUFPWDlYS1RscFlEczFEbllCV21UMlJ0UFE0dTk1TnY4dUFiNTRj?=
 =?utf-8?B?QU5hN29hK016SUdOdVFXWXZKUW1GaVMwcXRCT3JUZGNPcFgvbjdJYWZ2cExu?=
 =?utf-8?B?bzh1TWNXaVBvTXA2ZEl4enlPTVFQbld1VTd4M1RaYkVsSnBQQ0pvL0oycEFl?=
 =?utf-8?B?WERNVHdKVHpBZGZMQ0FLWWN6anN0THg3KzlQQWs4RTU4SlFzQkZlamJjQXAv?=
 =?utf-8?B?dERMVG9PanJSK2UvdmY5SCtGMlphQ0RtUmRIaUwvc3RsYUdlQlNycytaYXZG?=
 =?utf-8?B?d0dtRm9HRnZMcG1aeVBKQXcvQXk0dTlpYnc5TEtVZ3RjZG9peGVWbjBmTTdi?=
 =?utf-8?B?ZXRnUU91andTVHNZUlRhY0pzQmJ2SXJYTDlhMFJBQVJXRU02SXMxc3R2Z3pB?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c509508-c6bf-4b2a-7c1c-08dd1b05797a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 23:34:08.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AR0SDAoyorb4qVmQtNVbWOMKcyTxW5b13hmYjhe2PGBFsu/0a5BUYuHeb+BdEO7ePJsrAS3ppssBMEf3OgtDs019eRiyyV9jgQnvaKMtoE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6177
X-OriginatorOrg: intel.com



On 12/12/2024 1:31 PM, Shannon Nelson wrote:
> These are a couple of code fixes for the ionic driver.
> 
> Brett Creeley (1):
>   ionic: Fix netdev notifier unregister on failure
> 
> Shannon Nelson (2):
>   ionic: no double destroy workqueue
>   ionic: use ee->offset when returning sprom data
> 
> v2: dropped nb_work removal from first patch
> 

Thanks for splitting that out. Everything still looks good to me.


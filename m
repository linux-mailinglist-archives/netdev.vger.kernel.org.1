Return-Path: <netdev+bounces-157766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A752A0B979
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419DE1668B6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F018E23ED78;
	Mon, 13 Jan 2025 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObUN+KfK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951422A4C7;
	Mon, 13 Jan 2025 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778468; cv=fail; b=P8hUbfi4B233gR/axX9Y+xw/04hyAgkfY6skz9n7ghIXtXofbPCxP+UjUl0GKfgg7J7PNVoIxI3QS9PCpEEpiAmDuZhXIbReb+s9Uv/fbWfYKpRXzQww/KHKg5eEPRNyYUmTO4tJOu81P7rwrUAF5fMD+pNNyfwT49jXm9rw7Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778468; c=relaxed/simple;
	bh=oShO+mzax4rjpmoppawMJwgmjxNy6dJeMrtr7q5UOcE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mTtJiMYlOJXmNuMu5cV2IJ/4MusB+QCu+FYoqUJcEQNLqhhTMsKIv1chkyGUlLroXn7hTZHW5pB67++XIelC+doTaeEts8KzY+oXWAoFDN058liPrs4GMiEFbfa8hJ34Ya77nzliM0PmfeHiTNcifW99OSurGzKkRisoxF5kvho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObUN+KfK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736778467; x=1768314467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oShO+mzax4rjpmoppawMJwgmjxNy6dJeMrtr7q5UOcE=;
  b=ObUN+KfKV+HOe6Q0LkzSIJ+2Ez7p9f7D1YiEo+ozYFhhoV/9fDAsMl/f
   BVFtzj8jxh+Pn4beHfvPxaoQuv5axqoM7iyNbFiCQCTAbw8HMqfJJFwLf
   GWFrkXb2Z8K05CmzlOgFHP82TTRvWOanE1GaHsrdPK9CS+eNq690HtmJk
   /oJE7TN5nBiZD7ZxTBwYi1zl5YNpozfBbZUZEkTn+kqKOetT8hs449gQw
   lFDYIIgUzAjFRH8XCAdHIQniPSY0vnVxlGKHnwCI1JtCw4Lu4dVEk0dxj
   QetLh8Oh0T0hm0OxwhF/HQn65/yK68ybgWIg+tmIg3EktTh3rnOnhMeEp
   g==;
X-CSE-ConnectionGUID: Dz2InFJQTr6w6dUseZfotg==
X-CSE-MsgGUID: Afqrz9GoQZ+v9nA2anX9dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47708654"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="47708654"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 06:27:46 -0800
X-CSE-ConnectionGUID: zpCPqE/fRpmi8ZirIZJGoA==
X-CSE-MsgGUID: g70PIJAgTZS/+9WcQC2Swg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104373335"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 06:27:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 06:27:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 06:27:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 06:27:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/JC7f0HAuzRP6wui0JO+rWZxEOllmG++TXl1PFKBH/i8QCOhod9iHpBgkw3Qwqo391rRtVhnT16iIKoDG82zL9DvUYsMga/TbPtQhXflP7e9HOe/FsCiGygEqlbTNitRZSURJCLqlWJx/6rVSDtcX3FSDslJifeTdNQG2qn628sMZ4f2fzyx0eSYWuSYEi3Lf5c+1qItYd43nTFT3/+sOdmVCic9aEg3PswMyP4yTbjHT8zga8z0VMHfADy+f1Bjq4CE0X5GZB0QGx9PFSEtnfzFV1cl2p+ID4IoAYxBhLYVkPRiS6i+NvwBG+raH1UqIQ09vXXmz3gfHA99M6G+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oShO+mzax4rjpmoppawMJwgmjxNy6dJeMrtr7q5UOcE=;
 b=NvBRmJtRrb7RZgajgCyF6QZQFsKC28Up4d7P/gXpSPpU8d/xylTHp21Y43SwOaLayA/32NGkThVRycsGp3wbzS8K/IErN+ISXk4B9/J1JTUSZBg+/sUJEwn+PoB3xdHpc433PILp2vXg9fxPIJgQhM8sWLTgMK3StlnUrSgu0Ihm+h8xSUCNF7qYKqkCnY6+r1rsWk57s86hprr0h9/CWbmJ0aaDw/+FV3kKacTlZ3j9kg0WDB0F0ncyq+9iSVOzP8dvOrJgtj9QcXRmr7rz9RGE5bGUFS/c7wYxrF56Ai7u55CCQoWCNMmQTrHOouaAJrK77lU4k9kdY2GnLEfhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6950.namprd11.prod.outlook.com (2603:10b6:510:226::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Mon, 13 Jan
 2025 14:27:43 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 14:27:43 +0000
Message-ID: <eedd9556-05e3-4386-b0e8-96fb3afde014@intel.com>
Date: Mon, 13 Jan 2025 15:27:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] net: stmmac: RX performance improvement
To: Furong Xu <0x1207@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	<xfr@outlook.com>
References: <cover.1736777576.git.0x1207@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1736777576.git.0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0061.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: e4060c22-4052-4841-f70b-08dd33de7149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zy9ObUUrSUhwemZIZ0duUThqeEd1bkNNeXZ4MWZtMEhvZk0vRzYxRGdiTGpR?=
 =?utf-8?B?ZnBwT2pvZE9PSm5lQkh0bGIzamhEQ3IxTWRVVkIzMHJ2V1RVckRCSHZmZUlR?=
 =?utf-8?B?NVFxeDR0TXJuc2U3ajhPUHJ1UlJDSEs4RnJTellYUk9hVHJkWU82WWJ2TzJL?=
 =?utf-8?B?eGd0dis0MjlrcVVHa0lwT3lIRlVlUmxXL3g4UDdGcWV0MXdYV1RObjNVSHhE?=
 =?utf-8?B?KzFxUWYyckRzYUl2ODUzazFYM0VwcU11ZW9xcXpKYS9Ua3VsaTRRc2hpaWx3?=
 =?utf-8?B?UzR3UTNDWDNjbmhOblI4UWo2TGdtYzNzNitGVHRGVCtnZ1J6WmlIWkZjZjNp?=
 =?utf-8?B?TCtWaXMrNk12eW01ei9pejJDekdOTWc2eEFzN0NrblF2RDVQdFhUOG5zRFdj?=
 =?utf-8?B?WW11Y1Back5vd1RBc0lGZ0tGWXk0alZ6S2F4TXI1aFpTQitEbThDRXJ3elZX?=
 =?utf-8?B?ZlBISkRsSVIvV285VkV5NWVpeWg2aWxoblZNNXhUTU5oZXVYSXRVZXd5RkZK?=
 =?utf-8?B?NkZId1lRVU9VYVNINk82VHdNOGNKZzBGTGRNd3p0azRMTnE2T1NkNWtPTHVj?=
 =?utf-8?B?dWtQVkdoMnNTSUM1MGhUZmhVaW5xeVZzRisvRkdlVkk3ZldibDFkWjFlZTBh?=
 =?utf-8?B?bm5XQ3d3dXlralR5Ukw4Y0N2dis5OVMxWkJPV1lzaFlYbWs3U3J6Z2RMeHF5?=
 =?utf-8?B?QVo4c0xnSDFyVmhjbDhmcFJiZXhZSmZKQUdXdFAzak51UGVyQ0dIdUJyZXhh?=
 =?utf-8?B?b3lwKzd0RXFsb2tOa3BwTzBGbTRMOURiNVU3ZndCVTZvbXBQdFJyOU41blFa?=
 =?utf-8?B?NXZVRXhrRHo4UkJpRzBKeDhCS3NVd2RGMWJjcWdXaVFKamZqWm4raS9QNFRZ?=
 =?utf-8?B?aVdEK2p3TTFxbGNMUzVrSGFOcjhzUk04dWpNYWRjWU85a1ZxNFM3NUQzRFBp?=
 =?utf-8?B?ZmZZdi9hSnZVTkJYUnQ4SFpLTXNPQk5ZK0hMZkxyTmpod2poQTA0WHRpTnNI?=
 =?utf-8?B?M0FxZHpnVGRpK1Rjdy8rQnFtNHFNR1dOTlVoN0hybnZPNUJTR0VqMHc5R2d1?=
 =?utf-8?B?bFZQbFBWMFlPemRuRlBlcEVzTlg3S3ExTzgzeHUvQysvNFkzK0NheDVtVjJj?=
 =?utf-8?B?V2kweUxSQ2Nka3hoVUtVTEdqRDRGVFZVbFdFVmJSS0hYYnRvTkMrSGxyaUpu?=
 =?utf-8?B?UDF1VVhWN0s3YUgzNW56SVpBOFVHTXVjbTNkTHB3aGxpZ0Y2SHk2Z3c3N09X?=
 =?utf-8?B?YXB1MzdtRDhPbVZEUmJMbGd0bnQzQlBPSHMyakl0dFMrZFpRN0k4YUp1bGRl?=
 =?utf-8?B?Q0F0c2tZSFdmVytVNlZ4bTd6MDFaTzZvSmRBdWV4cWpZeVIzdkl0MDJmdmpI?=
 =?utf-8?B?TFNsNUpiNGtiY1RTRk1McWhLWE1KTzhoMmJ4NzU4QTlaSXdrY2xCM0kremp0?=
 =?utf-8?B?TlJmRmx2VTZqT3VMZGliSHdOb1cxbTNMcFkwcitpQmsrcXA4a0VoVC9neW1z?=
 =?utf-8?B?SXF0UzhpWnhPN25DV25VZlBMOFhYSFFhdDBSZlVoL0Q1d2ZvNEp6OUxEVXJC?=
 =?utf-8?B?RXBXWkdUVzh2SGREMk43TldLV0VEZDBiV0lnSkN1SmlFZ1BickIva1FPMmh0?=
 =?utf-8?B?cTNLQ0JqTzdHNSttb1RZemxMc2dpbnFrVk1CUnFHU1M5d3k3WWFHTG52OEZZ?=
 =?utf-8?B?UzlqWWxUTEVTdXZpZXFTQ2VCeGxkbVEvb0JhVTNFNUp0VC9VaXZRRzFFSWg1?=
 =?utf-8?B?K2RGdExEOThnQkNLcmJuQVNwaDlRNHdUVi9iUU1nRDNlRHd1aVF0aExnTHlt?=
 =?utf-8?B?ZC90RFZaY2lBMGVSVnlMV2VlRW9mL1RuYzZXcWNTWU9OZVAzdEV6MjRNZDNS?=
 =?utf-8?Q?k9SOIQXGOpFsa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVVYYmoyRGVWcUV6eG1mZnZwOFA1eHR4Z0J3eHBON2ppT0tvQ09LMVdTMDI3?=
 =?utf-8?B?ZmVidzZsUGJ6cUNCdXhMRVI1aHYvZktpY1E5NmxTZS9LZDBUeEFqSElqR1o4?=
 =?utf-8?B?WWlKQUQrTXZGNXZFS0tWTmpDYzM3ZEhMRVFQUVViTXlkWC9RQnZUaDhNYjNL?=
 =?utf-8?B?R3o3N2JSOHA1SE1VZWtVWVJIS0k2MGhJT2RLZWVwT3NReDg1cFVHNTV5dThE?=
 =?utf-8?B?aUc5dThiRllwYjJIRjhhenZsQUNHL2kyN0ZnSC9OSGhTSFhHU0hIY1NmL2wz?=
 =?utf-8?B?RlRYY2JWMDBBWW1SbmVNZURaZUlITithNmdjTEx3WlNMcm5Od3V3VkNDRTJj?=
 =?utf-8?B?ZU8zbXJSdFlqYkI5SVUwWkgrWWhDN0tNNExzSklUamtaL21LNERLL2E5NENB?=
 =?utf-8?B?L3ZNVW4xTnN1RzVYS2IzNytzSTZoT0JydnlUaGtRUytCNWs5VTdnYlppREx0?=
 =?utf-8?B?L0NOR1BYb3NkNytGcWtEdkU2NHhmVkFOeGlhQlBIMkJUNGVWMVUwR053b2U4?=
 =?utf-8?B?MGd6OXlnUTNDTDhxbURwbE9QdUErMlZKdHlkMVEya2xISnVFVEtkbUpkY2Uy?=
 =?utf-8?B?QVhOUGpta3BCS2dZejdFa2xseGNXTHVxc3JlVmZXYU93VVFGZzhtbGoxcUpK?=
 =?utf-8?B?dHZGekFkbEtzVHNxTE1zVDl0NWcrQXBHVG9wTlZvZUNNbVNrSVhwWVZseTVF?=
 =?utf-8?B?bjJkYVd2b3FPSzllNXBZczdEK0ZhTXZKRkRyQWo2cU5ETVIyeVFRVnV0c2Nz?=
 =?utf-8?B?R2pNaWhvaklPTzMzOUV0b0xsSG1XTDJ6SktIWUNZU1lyRE1kU0lTTGR1U1BZ?=
 =?utf-8?B?SjVoMmlwMVNMdGpZdllrdTdaalBBMDh1b2JaT0dpSEZ4LzBMZHhoSDF1Mk9J?=
 =?utf-8?B?WUFRY1V6SVN6Qk45aU9mV2JwS1IyWmpaWkE3c3JQZWx1MnlmdG1NL0xVREdv?=
 =?utf-8?B?N0RzQURPeThSc0hRL3prZ0pzQW04bDZqVkswWXNtN2dRRGVZbC82bnJEeFFZ?=
 =?utf-8?B?blBlR1pUa0JNZVNIYTRQQXp0NVpCbTladCtMZWtHckg2OG1Gai9KNzZuQ0Ns?=
 =?utf-8?B?Z1A4VVVpSlJ0WDRTaVhpblZwdFphMzhQYzV0K0IvRFhFVXdmeGVVK1o1WGVJ?=
 =?utf-8?B?WldMVVVMRXU0QzMzK2tkenNrWVJQYmRSZlZtWGxlREF3emt3RG45OWdybTNI?=
 =?utf-8?B?b0hrVlpjQVFYd1crUWJXa2hKTlU0SmpkM3cycGs5MEdtTmFIZmNZNnV5TjVo?=
 =?utf-8?B?b3hGQXRXei9WTFJMak9lc0ZDTlp1bXI2VkhKeGt0Rzhaa0Ztb0psODF3N004?=
 =?utf-8?B?UGsvK2ZaWDZHZy9iamIxMUpRL3ZXaXZkalFoRVFtUG03NmZPNllLL1FFQ20w?=
 =?utf-8?B?Y3VlMHNtRFBmUTljVlZPd2ZHV084WDRhVnZWZjU3Tjk5NUJBNnV3VE4zR29D?=
 =?utf-8?B?NUYyRXd0NkxKVjRFTk82blNSbG1VTXJ2MEJpa2N0Mjc1cFd1dHgwWCswV2I4?=
 =?utf-8?B?LzdCQlF5M3JyMEZ4K3lCNTNGeGYydnJRYmNpZk1oVE9kM1NMc3p5aEZpWlo2?=
 =?utf-8?B?SEFJZ2ZBbkdvRjZKa28yV2RqK3VJNGU1andXL00ySmxqaCtzNm1QaXdSUmN4?=
 =?utf-8?B?N2tBZ1F4MVdXdmVoLzhEOXVrQUJ6UVg5R2FTS3FiOWNHazJjTFkvVGNNMDJR?=
 =?utf-8?B?UnR3Q0RzZTNqMjJuczdKRlhGdEMxOGxmRlYwUEJJSFI1ZlNqQ2ZRNloxc3Ru?=
 =?utf-8?B?ZDMyMUNZVCtManhHQnViWWFEeTN0UmF3RlZTNHFYdHQvRnpBRjV5c2pLUnVi?=
 =?utf-8?B?ZFlna3pWdFpZQ1NXK1BrRWd4S1p6MnR5MFp2VS9iZy9TbER4djY2WW1RT0pT?=
 =?utf-8?B?TFFmdmFubndCQ2lzUEp6dUhwbE1rRWQ2N1FvWU9IY1ZoRVpraGs4WGRHTGNy?=
 =?utf-8?B?N3V6Nk1sSlZHdElvNXhtclVzUS9CdWRKY3FMOU54QkpoWGJpMFFKQmx0Y0N1?=
 =?utf-8?B?dkZEcitQcTdXUVRoaFdnRUltb21aM1N4dkZqaUx2aGRTYVZhR3VkRklTL0Vq?=
 =?utf-8?B?U2E2bXY2MkdWQ3JQL1ZzbVBwRnRaVHAxNHg4cXdNS1RZb0VKRTdqbW4wTlBh?=
 =?utf-8?B?aWZXZDhjOXllSy9kYVlLT0FhZ01mZEduVmdKVjM5aXFzMm9LYUdjWStRL2RI?=
 =?utf-8?Q?FO0PnFMv5k+b6bsA8f4OYX4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4060c22-4052-4841-f70b-08dd33de7149
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 14:27:43.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYZYqfj5lENq4LRvh1yc2CTIDLBAz/U2Rvv5ZWHqcUcx0l6gYDS0GFmXFi6+/NeYUJKb0fkQyoBU8GDGbGPWloAbtDc/UUUPRt9V/+K/bDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6950
X-OriginatorOrg: intel.com

From: Furong Xu <0x1207@gmail.com>
Date: Mon, 13 Jan 2025 22:20:28 +0800

> This series improves RX performance a lot, ~34% TCP RX throughput boost
> has been observed with DWXGMAC CORE 3.20a running on Cortex-A65 CPUs:
> from 2.18 Gbits/sec increased to 2.92 Gbits/sec.

Series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek


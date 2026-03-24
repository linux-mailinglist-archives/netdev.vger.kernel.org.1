Return-Path: <netdev+bounces-271213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHORFr3SwmllmgQAu9opvQ
	(envelope-from <netdev+bounces-271213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:06:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E4E31A798
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3755F301961B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A207346E6D;
	Tue, 24 Mar 2026 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L75MmM43"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B343264F2
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375479; cv=fail; b=i5lA7X0+97S00SzFE3fKxUyfEyIIQkuMrw3wZWXDKe05JfEDtQnPleLAWHe1QTWcQunJisYZVPdR5VZKlvaNfk24rQp55ayAuwpSuCAODfUGQh0ozdFnD0Gw5MJsGGMPcpn8uoRsejhBd5tRZxgE/d7wD2EtSwLVxZnrO7qr5RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375479; c=relaxed/simple;
	bh=/rXlChP8uNKDCH+9KwaiMyqDLzkPcYnKfKsFDlUxou8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2zL2MMCbLRIT4g++A2PxRI0uLpomsKhni4jokWQRnz+1SQq2RJEtrqq+PtnZYAP42FBdrsVk6YzSjTfaXHW/hURSOG3Dl11l6L/Rpao+9lHNuEuyiIRO5e2Ai/1dAV8Gx3pCWe8aa3OaHpdNlxjGlZMPx7khlavYYH8hOJzBwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L75MmM43; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774375478; x=1805911478;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/rXlChP8uNKDCH+9KwaiMyqDLzkPcYnKfKsFDlUxou8=;
  b=L75MmM43zRcVKgpOPV+fFZCuCZsIZz5YlzI0dm+Nual8VAjbO+1kXlVe
   +5a9N5S3LIQKeDdKDJZ/kPUPeVC9X1UN6cKARtScM8bW7SoxfrXnggYbC
   /PLmGHK+7ksCDU/l5hZXyzVGFy7NNMaOWcoUxXRy9d1+Ncq4e4NHrR3J3
   3Ha57IBIGM5mWiRk8413aWCGOIX0TWXLZXkp7E3U0IRRXmA2oCn85sqHP
   Zy5pG0WHK7VV/eXRKWCAyGCOr5lsLUMYHdR1rxf5V11DLTpv42YoXOznT
   1C4OlfauY57yVSoXn2Nd1hjeDagQF8YYKOPhEfumzC687ceF9LRnQIMo/
   w==;
X-CSE-ConnectionGUID: OFLGdqmxQKaICERJmaK7SA==
X-CSE-MsgGUID: HBfMmac+TD6vwADA/x26lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="74584913"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="74584913"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:04:38 -0700
X-CSE-ConnectionGUID: 6PZtUc5QQbSAFC46kP0R1g==
X-CSE-MsgGUID: PaDdUnm8R8++jY/bSS3Ypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="229201793"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:04:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 11:04:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 11:04:37 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 11:04:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nn2E+GTc9A8oyRCSqDWQ+Fh/kX6fpLb43PkeD8tpW7re3fiIb+sALhNTQHYUi0Xkyc0Rm+IRFGnnZNzy53B+I1NisfVqCl/il7K+76caSv1dhzEFLzHoFN18FQgwrGlcS+zSCza40iMKKzjZ/CG6uIF4I7YsPYGqwGTnyQ3lOYrmhIcTn3o+/6rAFmUfLCj+SJ1mTRp72GS6hrifs3RCjCXUHhe2K/EapBTSiviJzXcP8OcfwEs6jwcWL0KSBWl8h7Nv5lwmm8tw59QP5hbEWh7EUYHppTdXk2AhkEhLzt+O57UE+HO5py4W61WmVLhNwOM0oQblJEWRrSspBTgTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAeWPF3BdeXmJV1IdGB7WQofww0Hq7L+gbZUjCLdvns=;
 b=i1S7eVkOxxJTJOIs87tjQjQKby2Mlvga1C0pHFOCMMT2H+fCpCj872zlE1SBTuQ4i3Mgi4CU+CRlWni3oKP/GjRNm6YlvhDToDNTd8jCU4a8St5cFVo9O8WGwgjz9Al4YFOSxdjcmOena9V75KZEcdhDYE7PL7G46qvERWwTgebi4XMiA2ASuijQOqlaxrB21Ce7ud1ycNml6+gfA/Z8Z07mv1Th/SNFk1kI38cbFZm3C8e+y+GsPd8C1bO70+LyN/h3HJ3FFow833eXH4+mCdTDXbV/k1My4lGQXVfOuxGTFyqXsl/guOu8FR6+hj6FSoXdIfv+q0SI9Hg+QBwoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB6101.namprd11.prod.outlook.com (2603:10b6:8:86::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 18:04:34 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 18:04:34 +0000
Message-ID: <b616efc3-267f-461c-b5c4-b74e9647f3eb@intel.com>
Date: Tue, 24 Mar 2026 19:02:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] ice: add missing reset of the mac
 header
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, Katarzyna Wieczerzycka
	<katarzyna.wieczerzycka@intel.com>
References: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 48906915-83c0-45ea-8d8c-08de89cfcde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: lOWIVwr1jTcMTrgXAykE2Yk5dEw3MXFgNyVkrcWG+Q7xfAXwgt7SCJZfjvKtGOejQWSUIJVulefy7K7SqNh0FFz2IyTABImADDXnD6DfWXIpbX8Stm0+YDTIordv79bbezLaU7g1A6V0s6aAIw8sDJX4/gtcjfTvJQbNf8X8GPyKc8YP95UGgXmJ6XuPUX6NxERPFjMORvkelr6U6L2zLUoZpRwHqIWkI8ZbiXotNVLORGoPDEr5Nk2ke1ycamsliBzLPjFSbHxx0vEuQWZySjDZgdfOMPWK8rR0pCclsoiRvoqnKvt5aV6P7M0A7+bV2bA1sA4OCXE8h6EDPtK1xBmBFRVtAV3xW+X1OQXRfmtNqYdeSBkHVVf4vvCAZZ4vYHZBcWtdDvNa55lWDzpuswj9Bbkt5hPlwV9YoYdYzJfty8O4sxOmhr6AEIOd0nfc4CyXzWdawPMst9ngPh2YZt9iVbow5IaUdAM+gsBwhTvklaW5BVU+Nfvust9fPVX2EGolSbS9kqNUTkWeMI2SmaC101OOVDjGBubaDGQw+ubpvhXEk7Lho0ibyGVp2fdHMvFaxdkMHmEfO496z5vAzIbTE/Qg7l/iuMuIKwBVlE5lTw3lotGah02GAS82jjp84+S1ZTDLiUtWYOpRo4KEH+SYZoWV8roQSEc2hNmjR2aWCNLfZJ+AnWcEDHrdHN7f6uwxLMePPCOR87bs1SR2LMgTsbbdMDvkc9Atga4bueg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVM4RzhPR242QVl3NHY4dXQvakxGamZIYVp4SFl1bEdETTRmRVhtNUdNNVFi?=
 =?utf-8?B?VGJwSGJGb1dYVGplYXZpc0RMU1hkMldycS8yTGZUNmRMVHNJdmdUbzV3eFAv?=
 =?utf-8?B?ZEZqVHhYQ0JocnAxeWdxUkJqMGowMWw5TFkxNzhMTXV3Y1BiWURSM20yUjhD?=
 =?utf-8?B?eFRrcGFuV1QzWThoZE50TTg2a08wR3N3QWJsZDdpeG84N1dSSCtnclJad2di?=
 =?utf-8?B?a2ZCdmR2dXpTb0VMNzhGQWVOOHdNQzliSk5VZUphUk8wTUx1cU84NUZOM0dm?=
 =?utf-8?B?Z3V0Mmw5d2FUak5HV21kY2Zzb0ZpbW9FbDFmbi9CZTNKMm8vdTR3Mk1rSzMr?=
 =?utf-8?B?cERzcEtGcG9nbWxGeHlNS3RySXZvNGI2eHdSYzR0YmNSdEZtRTFuNUJ0bDdr?=
 =?utf-8?B?ekpjV05wSm1rU01HSER2MWhtcmNZcGo3Rjgrd0MyWmNaV3lsUkcwWEx6Z2hF?=
 =?utf-8?B?T0NMM1gwaHd3alh2Sk00M3JyZ294bk5rUWFsUWV2aEdkUDJGRkNNSmRQSVZS?=
 =?utf-8?B?dTlVMEZFbEc4L2dQL0RXL0pPRzhMQ3NWZ1o2ZGZYMVN3YlBJekRKYjZ5Q1Jt?=
 =?utf-8?B?Q25YWGpPbEJCMDJ2S3ZWa1FSRkEwaE5nbGQ2SEpOQW9QN3d1L0xQRStWVytx?=
 =?utf-8?B?S3BncXhRRnYzTlNNWDF0aXNOSHlIdUJUTmdFY3FlazZwMzlkZWtFVk5EUUNs?=
 =?utf-8?B?Q1lPVm5HdmRmSFRjaERVVGR3cER3UzcvQ0ZKMzgydlBSQTRNYlR5WXpYaUdZ?=
 =?utf-8?B?UjhxT0tPV0pWTi8rMmhsV1dhM0JyTmhqbTBUZVBUc2JyUFRhejQrbkFRZWZa?=
 =?utf-8?B?ZnZ2dEFPckF5cWQ4MU9yS3A2OFJQYkJ6d2hqakJDWUIxei9peXZhb2o5R3VH?=
 =?utf-8?B?a25HSmVuTStmWEl1WTRCMU9YUDBmVHlMYlZKWW5wNXdYOUFDaTBTcnJOUk9n?=
 =?utf-8?B?T0JkdjhtYUxUeEJkK29NYXZLYzMyajBsL0JoelhyUkJncE5wNWR2S2xrM21B?=
 =?utf-8?B?cURjM1ZnR1ZYTnZJVkVZTkFJSG1zV2kzd0prS1VOemNCTUtaYm95OG5uVEdt?=
 =?utf-8?B?RlVuY0d0ZllQL3VPMzk3NGZCRmpENVZXNi9QeHdEZjAvdWxBc2RDYkZoZzUy?=
 =?utf-8?B?UC9BdURqckdubU9Za0U5elBxTDVGNEZJR0g2dW0rTjAyRy9JNnBBTkpmZUdP?=
 =?utf-8?B?TUdXbDRnRVFsT0VWOUNyYlBTaTN3NkYwelNnQWZHeWdBa2tVOFdvVFg2NmJE?=
 =?utf-8?B?dkMxN0NGMlJybnVzNWJiRzQxd1hLQjFmZ2ZCS2F0L3dIVnFDU3pQRmRKcnVO?=
 =?utf-8?B?Y1ZkM0xaVGRLVzdUUmZ2dGVPZ2N6d1Y1ZnNXckRlNGN4NCtXU1dnNXdaZmFO?=
 =?utf-8?B?NWs4NlROd2t0eGI1anVLRlZSZCtENjZncmpFbkRxQTNXSzN5L3MxZDA3R0E4?=
 =?utf-8?B?NVRPTlcyWlZua2NGa25scFFGNnoyVlpPa2RNeE5EcmRwVUhPdk9jVzB6REZV?=
 =?utf-8?B?aHZYUGwyQ0hya1Q4aExJcWxIbGZZU2tuRVQ1U21qZDV0Sk02KzNTeklKUWVR?=
 =?utf-8?B?UlVRNUpnRDNjK0xVSE9UL2dHMXMyOC9YdGp2ajRPbGYxVThEMUZEdVdWdkor?=
 =?utf-8?B?WmFHTXJkU284S2d1SFF6ZWpMZWtRRTE0cGx1b0JVNFdEbnE2eUQxSjhuQkpG?=
 =?utf-8?B?UTFSQnRiaTlVTXRmd29nMXpnQjVlY1JaY2FQR0Z0UnRVUDM5aG1lUWI1NW1H?=
 =?utf-8?B?VmFYRjFMcWRGTm5HU3hVS24xQzl0YW56bzVRRVpsUjJnUHczVFZ4aXdpSk1a?=
 =?utf-8?B?S0tEWlRMamRRSkN5N253Nk9PeVhCZlYrWDQxVm4wQXV4SXVTN1A4eldrMHY5?=
 =?utf-8?B?bjJYTU1YWWRybjR0ZUEyQzVPdTk3VG1lMDJJVDFQeklUdzd6MGZuSHZqSGFL?=
 =?utf-8?B?L3pyUk5XNkJ4L0d5dVliaXRrMmlqeUVsZ01qTENURGUyWEZhVWNVblFZcmV2?=
 =?utf-8?B?VjJsZVhPWWxlTW53N091RGZvTTg0SHNYT0hraWRnVVJ0eWNRYUhsVWVkSXlO?=
 =?utf-8?B?L04rZDI5NnZSTXNUTUEzTzBjWlI2OXM2eG05ZU9mWG13WVVmVWY5N3VYY1lq?=
 =?utf-8?B?a1Rld0N3eHNNSGw5SmVkQnRyL1pVbVJDOEZEdXNQbDREcXl1VnhiL2F3WFhk?=
 =?utf-8?B?SFNlU3VMV05lQnkrSzJVZG1iNTlhK0VUT09oTGlZQTdlS2ZKNUFOQk9UNWhX?=
 =?utf-8?B?dHZKUXRMOHdjczJjRE9aVGt5SkNOSHV4a1hhbDNNaytTMVkzeVdITldneEg4?=
 =?utf-8?B?WDZTK2hRbUxic0VVczFJY0FzQWdjTjdMcFR4KzJpQVJudXFmYUFkUmxqY2Zj?=
 =?utf-8?Q?S5uSTBuIy/U2ojyU=3D?=
X-Exchange-RoutingPolicyChecked: d8YaDVzRWoHd0qGxdM+m7kWMT5dqlNkKnVfDurLmjsOcOU4v/kxU+j04MuL/bSlKf5j/2FWx+oGjzHW5kCazcTlmog/+LDQr9ORxxGtfGLpLZqNttQl8+SzEa30qQ6gOyW4D2yAmQKcD8Su8l3I97GdjqlhZo5iR50ZU0s+q97gm9MCCaqhhUcST8Yj3wbkBhgFHtEdcmOEWOdBMi3cIHuzICewwYNsi4IUs/xASuD1ppENriNe85NMmWrC4EEuaYKJFp5zpR/vxz2lwaF4Wr7B5tx/Ru8uaNrJH7Z9FuPsxpLD/E6RyBVFEnNMgAfkecyJ1mDp3NlU1Lt0jbwQWPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48906915-83c0-45ea-8d8c-08de89cfcde6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 18:04:34.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYgAWS54NPQktzqw/ccmWWawDMP/GSO5KAPWEwfdJ7L+z+FU7vW7dwagqRoKrhRZQQR6fVhxEZPo9JL9zrZJ/cEAD/5VaG+3+tlKZqRMuxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6101
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271213-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 57E4E31A798
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Date: Fri, 20 Mar 2026 06:05:18 +0100

> From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> 
> By default skb->mac_header is not set, so reset prevents access to an
> invalid pointer.
> 
> Call skb_reset_mac_header() before accessing the mac header from skb.
> 
> Signed-off-by: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index a2cd4cf..374b17f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -2211,6 +2211,8 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
>  		goto out_drop;
>  
>  	/* allow CONTROL frames egress from main VSI if FW LLDP disabled */
> +	if (likely(!skb_mac_header_was_set(skb)))
> +		skb_reset_mac_header(skb);
>  	eth = (struct ethhdr *)skb_mac_header(skb);
>  
>  	if ((ice_is_switchdev_running(vsi->back) ||

Did you read my internal review? I've never faced a situation when the
kernel queues an skb to .ndo_start_xmit() without the header pointers
set up correctly.

I need a good repro to agree this is needed. `likely()` also doesn't fit
here (you basically slow down almost 100% of the traffic).

Thanks,
Olek


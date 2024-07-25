Return-Path: <netdev+bounces-112911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F7493BC35
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 07:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D0D1F22439
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 05:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74831CFB9;
	Thu, 25 Jul 2024 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCLrhDsg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861771CD32;
	Thu, 25 Jul 2024 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886702; cv=fail; b=nptaD6wmmcA8v6XElxA87wkiRvNgWXL6SVlQ2xsuRuOxKs+0Dy49tryWoFkorula2NqiPw1p1GE/tiabsOKghkmF4kQVSIj/gmDDKsukM8mm3EcsZYRyT+UwqOzK04u8jo2nHbFRRZFMe6U8qQZn4FTsyn2H/lUsExKSQuQN9Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886702; c=relaxed/simple;
	bh=C1SLK+Hkk9aARkyg/dh3sCtS+R8Xjwr5/WUtFrTkVfc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CbDjq13F8aKkwyv0X0lJ8hTGyeHv7H/wJN4S+bggPwOxEz/dN+XCN+Dk2gqPWwEYEuD2tRT9+AU9NQnhl1gFSF614JPb+r0lo2N2ncWncc5XDE5I4BAwKXHM66zLDuivXceDAyu0W1PbqT3bgXAf188M+PI7heDSnT1VPJFeKP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCLrhDsg; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721886700; x=1753422700;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=C1SLK+Hkk9aARkyg/dh3sCtS+R8Xjwr5/WUtFrTkVfc=;
  b=SCLrhDsgEH2qw/RpHSO7XJ12BHa8jifDBJ5DASmdhdVLGAQ4IhAQsgkw
   6iFtADwsvy0giNPP6jlpTPzljYhUghqgjt/r5kHXnPY2P6FwEa4Hx2iqP
   +dU+tiqmusxzVKgg5FnsYon1ZmUDTVrM8QIA6U4AfiPooXjftqvl2uXaZ
   XzHWnWcNOuROm0nWhUFElsuKdvLHPC303XPmlUuTkJg7sdAE06f6k7oan
   o+7+9a8pqyX5xgkeWlbhPUyZES/5bVFszLjo/sZHr755/+Ws7pAAHcVvP
   wXe5ynmBeTCEYPgj8XVui7UPXfkuR8thjE7jjzOfmwxt/ujtWZVZBYf1T
   w==;
X-CSE-ConnectionGUID: fZIgxXj/SZOCL91BadltRA==
X-CSE-MsgGUID: aozJ//jHTV+vQMVz/DOqyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="31018885"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="31018885"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 22:51:39 -0700
X-CSE-ConnectionGUID: QFsqd8ZXRcSNB20RPH5ZOQ==
X-CSE-MsgGUID: zJmKcRS1TC+t5gt70kyTig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="52505485"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 22:51:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 22:51:38 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 22:51:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 22:51:37 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 22:51:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6PWGt25aRNbvHRjA/6ve9QNo/DvvkMOPfBRHp72q5swT/XvQLlJQP/OdfqaiPdDdULRJtqAhD4OqUOORb7DodhzLMBqYOhYxkEtnRsPU2MaIJ9HlY0r0VE+bGQA3dBa4rkWcpylbnBbOoDrp9rnsuA1LgPAj+dfT9T33/gy7IlNWWX3VQhaYNq2A3natKsaKwDMIwMnoKIOoRpm7cCyrQwSykyb4ftUBVAdN4qBU67Xh6Ep7n1EX6bmyu7QYyDnvRGySRBAJcnSklwxCxhVwpzTrIo8AHURLBVgyr6PXKF4UBMURCR2sX2/48wW9UuD+jjXqfIXkhatbIdcqnR//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1SLK+Hkk9aARkyg/dh3sCtS+R8Xjwr5/WUtFrTkVfc=;
 b=uUVCvX82OzcGyCtrSSaLIBQUkkvYNtdxtnOTlab/wahX+2HbHdAMwWDFesQ8ZO/IlToDQixJdxbmCIyqf/iFcN6jww2QlTI2yiRaxtbzNyZsjZ/bkzYHnCt7i8FKPzU8q30S5MOmZlQuP/PfC3d1K5nQWYcpWGxvYcZ1WvaaW8XpcdCAgAMq1nuwjkhrXC4L3684zGFQmon4HjcGAyEM6jF/owAFmKHMcnKTV6CDy5fG/dkFThnX5JpTxFVvPz6+SPnWu1ILosv1Yw1+hgZnIUqV06d9sN6PKdRxdDt3DYI/o6slU0hY3hYTVfGqFjLdx2gBHBNLIc5nnPOfVqWseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DM4PR11MB7280.namprd11.prod.outlook.com (2603:10b6:8:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 05:51:34 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 05:51:34 +0000
Message-ID: <85432fe0-b9be-4892-89b6-3e986838c5d2@intel.com>
Date: Thu, 25 Jul 2024 13:51:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
To: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
 <73311003-6b8e-4140-935a-55bd63a723e6@intel.com>
 <f40312b1-8ac7-973b-5519-ee185eec8560@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <f40312b1-8ac7-973b-5519-ee185eec8560@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DM4PR11MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 833af959-bbda-4cc4-76fa-08dcac6dd73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czVyVFZBdlMvNXU0eThSd0VLa2tydmhIZVlVVU81R0E2R25HWDZKTmZlQXlr?=
 =?utf-8?B?UHhQL3lWTjNiZ3ZuNmxHRU9NcDVZeG83SG1ZOHlvcnVJS0RxUDhpR1E4c24z?=
 =?utf-8?B?bm1XNUMyS2pCZm5UaUNaMlVCYjAyZU9vVTRZc0xsSGZsQmhLVndsOC85QkQ1?=
 =?utf-8?B?Uy9IZmc0UlE5QnZGdi9CQWRTNEhBcW9yN0djNHBQdE00djUyOFZvL2xLOHFZ?=
 =?utf-8?B?MWgxMXFWbHV5WGRvQ3RiUThJZDZOVjhOc0g5OWpKM1lVd093QzVoKzhPenBU?=
 =?utf-8?B?cXRYcEpwQ1R4RlNiaXc1YjNudm9WWEIxMmRaKzBBak9EbjlmeVNCSy9aNFlC?=
 =?utf-8?B?RjhQYjBkR0ZaN0VGOUlNL0x0L1Y0YXI0bnpSTkc1TmhQSVZZZXA4NEs0a0Fo?=
 =?utf-8?B?VW1wenBiYitVSkcvTy9WL204K2g0NTlrMTdOQXhPRndxUldqQmRCQUUvck5o?=
 =?utf-8?B?N2FpdlJBSXBLLzh2RXB1K0tJUkhpTGRrVFVhNUtZS2owNjg2RHFHaWZtOHZE?=
 =?utf-8?B?THNRKzhpYXROaUhhSFkwSm8rYitqV0theHVqOXRQZWs3ZERLUCtvc3ZWN0Jw?=
 =?utf-8?B?SjU3MGFoMlBoWG5uS2QwQnpXVVRKNXhacU5KVWYyVzkyYlRqYitFZkFOWi9H?=
 =?utf-8?B?K2I1ckVXUEVKdlZMUnNMWndzaTlneUR6ZGYxM0hDa2lvZ2ZnY0VobHRuNGFM?=
 =?utf-8?B?RG1JaVo2WFV2MVY4eXR5L0RHanlDRVQvUC80RFVDQVRSTWpQeTJ4SzJDczg5?=
 =?utf-8?B?a2haVVdVYVlCT1ViZ0FEY3ptajFxZnFLbDloOU1nQU5qdDRuL0RoYXNxOFEr?=
 =?utf-8?B?cE9HdlFoOFNDV3JEWTNuU0VrejBIV2dsUzI5N1RYNjNqSVQwWWh4V0tJNHBi?=
 =?utf-8?B?cmZmVlFCZXRoRzRpLzYwZTV4bUI3Z2VpTGVqSzhoSDhxWkNWenpvOUFpNWQ2?=
 =?utf-8?B?eVJSYW5WNTlISXVyZUhHeHA1cHBvK3puQ0QwMUJValVoOTBXaWE2LzFaSXJ2?=
 =?utf-8?B?Zi8xc2xsUnd6UjI5YVB0ZmFuL0QycUZpb2Z3OUFhdWtLcGlYTlVVbWJ5bkFF?=
 =?utf-8?B?ZTkzRVZmQ0U4aGIyRmY0dTEwU1h5cTRoVDdnblFwSHdvd0REa3BQRkVtazdZ?=
 =?utf-8?B?NGYzRDFVU0RISlZ5YjJ0azZZelNaeUQxbFJwQWNUWTlrNTRWcm4rR0ZzQm5p?=
 =?utf-8?B?S1M2QkZkQTZnSGxDeEM1Vm1RSURNc0FkUU1kbGxub0ZmeXcrMTJ6WjQ0TmJ3?=
 =?utf-8?B?ZjJsSGpkTnlvNDdNVEhOLzhwdnQyTHJIR2RBL1dTUG1uSnlpQWN5bm1pR295?=
 =?utf-8?B?ZEluTWZzakFkcHY1NEtEWi9KcXAxL05vSTdHWVI4K3piQkM5OFBOMURHM3Ax?=
 =?utf-8?B?VzVkc1h0YWJOeWRMTWduRWZqSFBXZkpnRVN5b1NmS21nTitDckZ1b1RjVTRk?=
 =?utf-8?B?emthdG5CdDJ2a1ZoVyszVUsxd1lDK2lpT2JzN2s0VEY5QXlla2NMZTNLejdX?=
 =?utf-8?B?WW1XT1BNR2JNUXgweWd2Y1ZZK2thN2pQNkhOZmV2ZzFhbHhETC85b1BLSENM?=
 =?utf-8?B?QUhXODBCUUI2SW1HYXJJL2t4czd3am42djdUSHNFS29QRC9lZjYxUk14OWNx?=
 =?utf-8?B?dWF1WDNwVVVBQTlmU0orNnVFT1pGT2Z6TDB3RFFUZm9wMVgzNjdQMmNBN3VJ?=
 =?utf-8?B?MGhTOUhIT3M4dlczelF0alZ2Rmo3MEZWaVpBSWhtU3RRSlRPZzRhRGV4QXZN?=
 =?utf-8?B?Q2Q1azVWUGhMQk8yTzhKR1NCUjBSRDhESVg1ZUpFRUR6SXZUdE1DeUZ2T3lu?=
 =?utf-8?Q?wrE7r33Rv/jjVByINlmq0iQ4F0sAqfOHd+SYQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hzcHQzL1BVYnRnZk5HMkkzUi9qcUlmZC9JMDF2MW9SVjhCeUw5a1dwcFoz?=
 =?utf-8?B?Y2lrV3BmajVUb1FidE9GNDl6S3Jsay84Lzc4L3RVUWNoOGg0bW11NjB3KzFi?=
 =?utf-8?B?UmJDakwwelliRTl0SmdJK1l2Q0JIcVM3MTVjeGZ2U2NZcTI4QnZzWXhsczF0?=
 =?utf-8?B?QkZ4UlNGWXl0VXJnWG9sV0gxSmsxQ2huL1h0dUFrZ0xUY3l3dWdtUlZkandE?=
 =?utf-8?B?ZDJHbnJmeXJxWlEvUkU1UHZxd3psaGszcWtqSk8xZ0l3bVltNmNmcWRabHp6?=
 =?utf-8?B?alpQRUZSU1N4V3Bsd3hVaW92eE9xWXdFMmxzTUNMYVc0cjQrK21WR0o0Qi9I?=
 =?utf-8?B?bWkyOTBESUx3TEVjekZ2Ym1PWDl0b25obHZLWDJlVC90c1hHYUllcU5iT0pn?=
 =?utf-8?B?THZMN2ZaV204clQ2Q0VhVjNvQ0dDbHpwK3RaTFpTZktyc1RQVWM1L1JIMlBq?=
 =?utf-8?B?LzVsVkxxNGdwSUxqMytUT0lVbTJndG5OcEVFZXVwVVhjUWU3M0FWMTFjM0d6?=
 =?utf-8?B?L3ZyeFNKRzZIK2p4YjV1WXgrYjhtR2NjSWRQZitsRUttV0lxZmF0V3N1TUJY?=
 =?utf-8?B?RGYvRmN4V01LY2xuZ0FFd2hkSGNqb2RWSnBPdVVPMDVtTzh2NWRQQmFNbXpt?=
 =?utf-8?B?bDdLSUY1Q0tDc0lWcjU5dS9zWVcxb2RzVjRJK2pZTFgrcGJhUU45VVhOQ2s5?=
 =?utf-8?B?aTRETG9TblpVMDdmSjZFUzBhR09nUHV6bDlNWFMvTTlrMkp5UXFaZEVyaGFL?=
 =?utf-8?B?c0YzNXFDTHNNaWZtYVdnRzlwTW81RFBKd2tiR0h3UzF0V1d1RzJjRjZVV1h0?=
 =?utf-8?B?c3V3ZklSRGUxcEd5R09kSGozUTNEakR2MTFoaWVEd0htZXEvWnBRWWdzOUZv?=
 =?utf-8?B?SlNBTlpUOWxUaFlLQjdBUWJiQmI0Q3ZMSUZHSjRNbzFWMGZINHNYT2tRamFP?=
 =?utf-8?B?UkJSS1ZZK3paM3ZSbUUzSC9QNEFubW9wOGNBRFRCUzYxTUtCNXZPV29iVkRC?=
 =?utf-8?B?UXBCMldRNzViR0g2U1N0bUprMzYvMTBIU0RuN0dkN3NvbEVPb0d3dGJxanc2?=
 =?utf-8?B?QllBaC9lTmhoUGtYTEdZVUthR3FxcUxaejVTdjJ5TURDMGxVMzRzVVYzMTd3?=
 =?utf-8?B?V1ppVDZwOGQwNFJ6TUNFNG9VeU9ncVAwRllmY282QzlISUY0REp5Sy9nN242?=
 =?utf-8?B?cVdCMFMxZm0rMDJndE9PU0dKVmx6NnEwemNDNStSYjNIb2RCRkJqSGVIZDI3?=
 =?utf-8?B?WVArK2x0ajBhRGo0V3gwUUlTV3VHSm1iRGN6YVE4a3RIRE95UUhkSE1TSUtJ?=
 =?utf-8?B?c3BIdy9VT3lRS0lubjFNTUJhb202VnV2NXVUSUh2L2JZNHBJSGVKWUlIdVp2?=
 =?utf-8?B?Ukl6dzdZNTFVUmNtMGI5cUpYL0xjcU83TUNQM0hrRHNWTU1qT0tJbE13TEFI?=
 =?utf-8?B?b0ZkVlpJVis1Y1pOWE9keFNneVBXNEUvL2ErYkFGV0szQ0dncE1Udm1LY0po?=
 =?utf-8?B?RzAzbzVURjNUUnRvbTBtT1I3VGhHREtQTUlGc0t0cml4ajM0NEZ4ajN5N2Rh?=
 =?utf-8?B?QzIxRVljMEkzR25MY1VPb0piWm9zTGwzTEZ1NVRWTklzMVpFcGRnUEo3M3Fu?=
 =?utf-8?B?SUdIVFQ1TFgwNDJ5Z2xjYVQ3bWhFaGpaUytyRUxSRE16VmZpM1A5NFFVMnVh?=
 =?utf-8?B?MkZPS3FSdW13ZmJ5czl5SFhSdkNmTEhrNDN5bVNFR3pEam5rU3BMTXhyaitM?=
 =?utf-8?B?NWE3ZXVXSzkyejJBY2ZtcEhsUytpSUNMQUFadTVpNnptTjZGcDl3VjAzN3kz?=
 =?utf-8?B?Rjl3Q3BmeWl4WG04VzRBM3JDWmpYNDNHeDR4U2lpcGdBTElNNDBuOVF4c1hz?=
 =?utf-8?B?RE81eXI1cGorSWVSNHNmalh3SHp4U2tKWDRXZzE4K0lyTUYzcmZEUUZ6NVgw?=
 =?utf-8?B?eGpLa2ZJajUrRkVTOGw3enZxdHE0YUlFendya1I3ZkYrZ1dPYWVFczB0ZlJG?=
 =?utf-8?B?MWIvZ3BXQXpCNURFZU94eFNERHhuUm4vZ053ZXBUOE4vNHJ2M0l4dDZ5eE5s?=
 =?utf-8?B?dGVNeSswZHpRL3U5TnpBdFlzZWx0TGgxN1B2L2ZXczFRTVJWc0FFN0pvSTdU?=
 =?utf-8?Q?EFEtY/iw//o5ny1MSgbjDeCJL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 833af959-bbda-4cc4-76fa-08dcac6dd73a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 05:51:34.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/QZSiaGRm3OsVfBbObbBslL/Eb6m3CWP54cBYSOvoPf32K4MCBgdxoexBqfUgl7+R8bp5Nsa9/cYAwra6PcDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7280
X-OriginatorOrg: intel.com

On 7/24/2024 4:24 PM, Alejandro Lucero Palau wrote:
>
> On 7/16/24 07:06, Li, Ming4 wrote:
>> On 7/16/2024 1:28 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> CXL region creation involves allocating capacity from device DPA
>>> (device-physical-address space) and assigning it to decode a given HPA
>>> (host-physical-address space). Before determining how much DPA to
>>> allocate the amount of available HPA must be determined. Also, not all
>>> HPA is create equal, some specifically targets RAM, some target PMEM,
>>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>>> is host-only (HDM-H).
>>>
>>> Wrap all of those concerns into an API that retrieves a root decoder
>>> (platform CXL window) that fits the specified constraints and the
>>> capacity available for a new region.
>>>
>>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m6fbe775541da3cd477d65fa95c8acdc347345b4f
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>   drivers/cxl/core/region.c          | 161 +++++++++++++++++++++++++++++
>>>   drivers/cxl/cxl.h                  |   3 +
>>>   drivers/cxl/cxlmem.h               |   5 +
>>>   drivers/net/ethernet/sfc/efx_cxl.c |  14 +++
>>>   include/linux/cxl_accel_mem.h      |   9 ++
>>>   5 files changed, 192 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 538ebd5a64fd..ca464bfef77b 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -702,6 +702,167 @@ static int free_hpa(struct cxl_region *cxlr)
>>>       return 0;
>>>   }
>>>   +
>>> +struct cxlrd_max_context {
>>> +    struct device * const *host_bridges;
>>> +    int interleave_ways;
>>> +    unsigned long flags;
>>> +    resource_size_t max_hpa;
>>> +    struct cxl_root_decoder *cxlrd;
>>> +};
>>> +
>>> +static int find_max_hpa(struct device *dev, void *data)
>>> +{
>>> +    struct cxlrd_max_context *ctx = data;
>>> +    struct cxl_switch_decoder *cxlsd;
>>> +    struct cxl_root_decoder *cxlrd;
>>> +    struct resource *res, *prev;
>>> +    struct cxl_decoder *cxld;
>>> +    resource_size_t max;
>>> +    int found;
>>> +
>>> +    if (!is_root_decoder(dev))
>>> +        return 0;
>>> +
>>> +    cxlrd = to_cxl_root_decoder(dev);
>>> +    cxld = &cxlrd->cxlsd.cxld;
>>> +    if ((cxld->flags & ctx->flags) != ctx->flags) {
>>> +        dev_dbg(dev, "find_max_hpa, flags not matching: %08lx vs %08lx\n",
>>> +                  cxld->flags, ctx->flags);
>>> +        return 0;
>>> +    }
>>> +
>>> +    /* A Host bridge could have more interleave ways than an
>>> +     * endpoint, couldn´t it?
>>> +     *
>>> +     * What does interleave ways mean here in terms of the requestor?
>>> +     * Why the FFMWS has 0 interleave ways but root port has 1?
>>> +     */
>>> +    if (cxld->interleave_ways != ctx->interleave_ways) {
>>> +        dev_dbg(dev, "find_max_hpa, interleave_ways  not matching\n");
>>> +        return 0;
>>> +    }
>>> +
>>> +    cxlsd = &cxlrd->cxlsd;
>>> +
>>> +    guard(rwsem_read)(&cxl_region_rwsem);
>>> +    found = 0;
>>> +    for (int i = 0; i < ctx->interleave_ways; i++)
>>> +        for (int j = 0; j < ctx->interleave_ways; j++)
>>> +            if (ctx->host_bridges[i] ==
>>> +                    cxlsd->target[j]->dport_dev) {
>>> +                found++;
>>> +                break;
>>> +            }
>>> +
>>> +    if (found != ctx->interleave_ways) {
>>> +        dev_dbg(dev, "find_max_hpa, no interleave_ways found\n");
>>> +        return 0;
>>> +    }
>>> +
>>> +    /*
>>> +     * Walk the root decoder resource range relying on cxl_region_rwsem to
>>> +     * preclude sibling arrival/departure and find the largest free space
>>> +     * gap.
>>> +     */
>>> +    lockdep_assert_held_read(&cxl_region_rwsem);
>>> +    max = 0;
>>> +    res = cxlrd->res->child;
>>> +    if (!res)
>>> +        max = resource_size(cxlrd->res);
>>> +    else
>>> +        max = 0;
>>> +
>>> +    for (prev = NULL; res; prev = res, res = res->sibling) {
>>> +        struct resource *next = res->sibling;
>>> +        resource_size_t free = 0;
>>> +
>>> +        if (!prev && res->start > cxlrd->res->start) {
>>> +            free = res->start - cxlrd->res->start;
>>> +            max = max(free, max);
>>> +        }
>>> +        if (prev && res->start > prev->end + 1) {
>>> +            free = res->start - prev->end + 1;
>>> +            max = max(free, max);
>>> +        }
>>> +        if (next && res->end + 1 < next->start) {
>>> +            free = next->start - res->end + 1;
>>> +            max = max(free, max);
>>> +        }
>>> +        if (!next && res->end + 1 < cxlrd->res->end + 1) {
>>> +            free = cxlrd->res->end + 1 - res->end + 1;
>>> +            max = max(free, max);
>>> +        }
>>> +    }
>>> +
>>> +    if (max > ctx->max_hpa) {
>>> +        if (ctx->cxlrd)
>>> +            put_device(CXLRD_DEV(ctx->cxlrd));
>>> +        get_device(CXLRD_DEV(cxlrd));
>>> +        ctx->cxlrd = cxlrd;
>>> +        ctx->max_hpa = max;
>>> +        dev_info(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>>> + * @endpoint: an endpoint that is mapped by the returned decoder
>>> + * @interleave_ways: number of entries in @host_bridges
>>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
>>> + * @max: output parameter of bytes available in the returned decoder
>>> + *
>>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
>>> + * is a point in time snapshot. If by the time the caller goes to use this root
>>> + * decoder's capacity the capacity is reduced then caller needs to loop and
>>> + * retry.
>>> + *
>>> + * The returned root decoder has an elevated reference count that needs to be
>>> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
>>> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
>>> + * does not race.
>>> + */
>>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>>> +                           int interleave_ways,
>>> +                           unsigned long flags,
>>> +                           resource_size_t *max)
>>> +{
>>> +
>>> +    struct cxlrd_max_context ctx = {
>>> +        .host_bridges = &endpoint->host_bridge,
>>> +        .interleave_ways = interleave_ways,
>>> +        .flags = flags,
>>> +    };
>>> +    struct cxl_port *root_port;
>>> +    struct cxl_root *root;
>>> +
>>> +    if (!is_cxl_endpoint(endpoint)) {
>>> +        dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>>> +        return ERR_PTR(-EINVAL);
>>> +    }
>>> +
>>> +    root = find_cxl_root(endpoint);
>> Could use scope-based resource management  __free() here to drop below put_device(&root_port->dev);
>>
>> e.g. struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(endpoint);
>>
>
> I need to admit not familiar yet with scope-based macros, but I think these are different things. The scope of the pointer is inside this function, but the data referenced is likely to persist.
>
>
>  get_device, inside find_cxl_root, is needed to avoid the device-related data disappearing while referenced by the code inside this function, and at the time of put_device, the data will be freed if ref counter reaches 0. Am I missing something?
>
Yes, get_device() is to avoid the device-related data disappearing, __free(put_cxl_root) will help to release the reference of cxl_root->port.dev when cxl_get_hpa_freespace() finished, so that you don't need a put_device(&root_port->dev) in the function.

I think that your case is similar to this patch

https://lore.kernel.org/all/170449247353.3779673.5963704495491343135.stgit@djiang5-mobl3/


>
>>> +    if (!root) {
>>> +        dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>>> +        return ERR_PTR(-ENXIO);
>>> +    }
>>> +
>>> +    root_port = &root->port;
>>> +    down_read(&cxl_region_rwsem);
>>> +    device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>>> +    up_read(&cxl_region_rwsem);
>>> +    put_device(&root_port->dev);
>>> +
>>> +    if (!ctx.cxlrd)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    *max = ctx.max_hpa;
>>> +    return ctx.cxlrd;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
>>> +
>>> +
>>>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>>>                 const char *buf, size_t len)
>>>   {
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 9973430d975f..d3fdd2c1e066 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -770,6 +770,9 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
>>>   struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>>> +
>>> +#define CXLRD_DEV(cxlrd) &cxlrd->cxlsd.cxld.dev
>>> +
>>>   bool is_root_decoder(struct device *dev);
>>>   bool is_switch_decoder(struct device *dev);
>>>   bool is_endpoint_decoder(struct device *dev);
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>> index 8f2a820bd92d..a0e0795ec064 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -877,4 +877,9 @@ struct cxl_hdm {
>>>   struct seq_file;
>>>   struct dentry *cxl_debugfs_create_dir(const char *dir);
>>>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>>> +                           int interleave_ways,
>>> +                           unsigned long flags,
>>> +                           resource_size_t *max);
>>> +
>>>   #endif /* __CXL_MEM_H__ */
>>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>>> index 2cf4837ddfc1..6d49571ccff7 100644
>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>> @@ -22,6 +22,7 @@ void efx_cxl_init(struct efx_nic *efx)
>>>   {
>>>       struct pci_dev *pci_dev = efx->pci_dev;
>>>       struct efx_cxl *cxl = efx->cxl;
>>> +    resource_size_t max = 0;
>>>       struct resource res;
>>>       u16 dvsec;
>>>   @@ -74,6 +75,19 @@ void efx_cxl_init(struct efx_nic *efx)
>>>       if (IS_ERR(cxl->endpoint))
>>>           pci_info(pci_dev, "CXL accel acquire endpoint failed");
>>>   +    cxl->cxlrd = cxl_get_hpa_freespace(cxl->endpoint, 1,
>>> +                        CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
>>> +                        &max);
>>> +
>>> +    if (IS_ERR(cxl->cxlrd)) {
>>> +        pci_info(pci_dev, "CXL accel get HPA failed");
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (max < EFX_CTPIO_BUFFER_SIZE)
>>> +        pci_info(pci_dev, "CXL accel not enough free HPA space %llu < %u\n",
>>> +                  max, EFX_CTPIO_BUFFER_SIZE);
>>> +out:
>>>       cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>>>   }
>>>   diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>>> index 701910021df8..f3e77688ffe0 100644
>>> --- a/include/linux/cxl_accel_mem.h
>>> +++ b/include/linux/cxl_accel_mem.h
>>> @@ -6,6 +6,10 @@
>>>   #ifndef __CXL_ACCEL_MEM_H
>>>   #define __CXL_ACCEL_MEM_H
>>>   +#define CXL_DECODER_F_RAM   BIT(0)
>>> +#define CXL_DECODER_F_PMEM  BIT(1)
>>> +#define CXL_DECODER_F_TYPE2 BIT(2)
>>> +
>>>   enum accel_resource{
>>>       CXL_ACCEL_RES_DPA,
>>>       CXL_ACCEL_RES_RAM,
>>> @@ -32,4 +36,9 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>>     struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>>>   void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>>> +
>>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>>> +                           int interleave_ways,
>>> +                           unsigned long flags,
>>> +                           resource_size_t *max);
>>>   #endif
>>
>



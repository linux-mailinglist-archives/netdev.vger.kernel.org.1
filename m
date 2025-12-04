Return-Path: <netdev+bounces-243486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E905ACA20EA
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 01:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A52943012268
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 00:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CB91D90DD;
	Thu,  4 Dec 2025 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEDu5hde"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4A1C3C18
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764809095; cv=fail; b=EDUvtXbz0xfiAAM84RH95mXbaqQEmh+7HoPDJDZJjDECDcuULbUc7nvg7PH2gBJFfCZuk58n8JTe05qQ8zOaup4mbS2DFF5JYbRWUYgzoK8l7To33pvyTLMMOpYBeIDpbp1WMOAsokQRUEoftTxiyiLCM0Ss/jGxssgeuzVJJZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764809095; c=relaxed/simple;
	bh=d3VjyIB38CA5yKc/vkGcAIAZ03X9WEdwDv9Qc5BQ9oQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I+8w6iHtcln7rn9i9Bu+km7nso9Y5P4bt/aci7tT2V6rf0/LErILCMUGxkTfELkD2nPzV44r9fPUXomaxnaPePZolr6KSpbIzTo8J0ruMO6gWnxGioG5Cg5SO//sxiMPqzuOZSFDjowJGABC+/4bAgXDxSjzDHnVQX5dshtqKK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEDu5hde; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764809094; x=1796345094;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=d3VjyIB38CA5yKc/vkGcAIAZ03X9WEdwDv9Qc5BQ9oQ=;
  b=hEDu5hdeTIRIsMypAfSNu52yXGXQ4S+K7UXvAjihjwr8YrW8TZjnUSlq
   zlePUJcw29NbPoRvt0VHbWJioYZfpMjYsZiqlyxZoY0nyr1AYENvTP76w
   6CaaMIdc1F8LKltohtvlhJ0r6+QgbgD2Url2edVOjmfChlfVqHavj9VIB
   dPtTmdlWTw3fHuQOKNPQttDi0R8KXqQ+ZmpivsXrLX83Ug8P/EKn5XUv4
   UzZDhuX8gryttU5X11n/ikoyQMdIsx7v3sgg/Lick18rcA7JBrZKOu3a6
   SEqEiV8onGnmsUcUWr0o/aKFzqQleQQ1ZVyANGf4YnDwCDd5RazgPNyHV
   Q==;
X-CSE-ConnectionGUID: Qmt2zkdeRtWd3s32kYgi7g==
X-CSE-MsgGUID: 5hAo0gBPRre/auIcVp5leQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84421660"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="84421660"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:44:38 -0800
X-CSE-ConnectionGUID: FMkbtjR8QcGb67HLPLq+CQ==
X-CSE-MsgGUID: p57/PLsoQuqHodhA/CiLoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="199264425"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:44:32 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:44:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 16:44:32 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:44:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKNM5n4brHVvvOqGh+LgUj2jD6iWgl3MQAImt8qPEi+NQWa/MFyNDQioWuRvsG/el/A7wSAAyVUx1xOvDkCGNd6KpDHmZ5jZpSl4d7YfMLUXlJTVzbGZEAUnAeoXbVxWW8ZQZuk+k3IBSQZapVhHIKv/bpRnHJ2hAg2lwt/UFZlDN0bPZV1UPzhI8IZLkEjLqe0GjcMn+tdXCSRkiU22dq7kUAgNhZcB2N9ZTgPEOyHMHL1E0FtiZ8jkTxriNXShflagXnTFBaHlqFnUDs7TpCtG/vdnQmFJD6OSNCxDeudLcAFlnHC00ADc0pHby9iVpJBgjt/5qrRBhFzbXJsJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNAHYuhLXSyLuftsmqJAiVPnhPlGSCma15C99+gjdsM=;
 b=VgJB7aFH9BEuJGPnLZMUgRPTbh6E2QOd9SDla4NzAXtAOM2JNzZi799dcruE4aPpe6FgpMxc3oYdvYhVdlM4Yc8wxXIR3jz+ilKSDlJvm1BBG7xKoyP8JNnaccMz4FMcKik49JUMOnZuSE9bsq0l9CX9PhklMfMIRqBC8m7ftlR/pTZhYfb16+Viys+QaFwjnpqowUPdZea9kLyiTDLv3hThMwZQy1wUlESbq/PR9YvE9snparEZKIbrZpZNXn7fXKluKYqjBnJRGOguaslwxKosNzF2dULPLyPP3S9h5n9ECb+vggB8mWbKMh8zHQLCZBOKQdjn0XbSAzWGi4Ggeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 00:44:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 00:44:30 +0000
Message-ID: <7f8aca3d-192e-4471-8403-31c9811fa02e@intel.com>
Date: Wed, 3 Dec 2025 16:44:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] bnxt_en: Add PTP .getcrosststamp() interface
 to get device/host times
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Michael Chan
	<michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
 <20251126215648.1885936-8-michael.chan@broadcom.com>
 <15501b84-2c35-466c-8347-c9ca406affb9@linux.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <15501b84-2c35-466c-8347-c9ca406affb9@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Nwy5yd7cfV8pXtOSQf26L9m4"
X-ClientProxiedBy: MW4PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:303:dd::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e39dec-ee48-4f8b-3b53-08de32ce492a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnFQM203WUNNdjh5QjJEN3dkdzFxMzZZcnh0TzZreDd0emVGR1h4OFFldzgv?=
 =?utf-8?B?VWtmNHlxcmQwdStQMkV3eVJDVTRFZmFCYWVqSk02NHdVZzJRYWhHeXhMazhB?=
 =?utf-8?B?a3ZsZmU5eDBJK1NhcS9ESjlQR2VLTWVxMExEa0xoQnE1V3N4VENkY21yTy9O?=
 =?utf-8?B?UHB3MFltOFEzaEoyMWdJT1VZK1duUVI2cElPdjQ0dXIyZUJ4WjI5aUdXRFll?=
 =?utf-8?B?S2E2a2JFbExGUUZCdDJtWHo4MllqSkdLWTQyakZmaWJXSVZkZXpGRGVZME1S?=
 =?utf-8?B?LzFQMHdDV0lNM0VLQjV1emVhTndhR0IvZDVQUnFqa2duWWczNEkxQUlKUlZZ?=
 =?utf-8?B?UE01RDdxTkN3aG1ncTBNdjc5WjZqY0VKOFlHTVRSeUJXaEY5OE9DYURqdGZu?=
 =?utf-8?B?SzRZVTlaRWlsd3pZeGxNaTdMSnpTTDlDNlM1M0Q4VUdxN1hpcGtKSUxCVEJ6?=
 =?utf-8?B?NmEvaVlUTnhiTDZwL2R4SVRwMzJUNDhwcjF3aEV5VGlieWFsWVJiSWlieE5S?=
 =?utf-8?B?a1FTTWVCOHk0eEJDMGM1S0p0UVRCWGYyWGpRV2Z6TUJXaWR4N1VkSUtNR0JJ?=
 =?utf-8?B?R3UrR3dMeS9oWEJXRitlZlV1MndodXpsVFk1SE1oQVc0QXk4enVtZ0IyS1Rp?=
 =?utf-8?B?ZFdJUGxjbDB6TzI0T3YyL0pZQXErYXQyWHN4cUY1QlltMmI0bXBiWXk0NU9v?=
 =?utf-8?B?U0Q1c1BwNmdyaUREYUhRYWZ4YWdsdkREZlkzL2hUT1h4ak9PQ0R4bmpJK05E?=
 =?utf-8?B?WW82a3FweWdUUTJ2Myt0dzRzR1VnVHZkVDAvUVdFRjFnQk1tMjZrZnBlVVFI?=
 =?utf-8?B?emtuQnRjbW9nREIyQ2JwdzNxSUlmdjhOc3NtV0UvekxLbGJ4dy9CN0ZwQ3Rl?=
 =?utf-8?B?VkQ3YWVxTjF6SnQ0cCtoWHNZWE5BQXB0K2h3TVNrWGhQZmRKeTJndnpHNG9O?=
 =?utf-8?B?QWdURkkvNU9pdldnTVlSMFFtL0dUSk5tT1ZWYWl1RjBHS0JpQnZsVGJpa2pE?=
 =?utf-8?B?MmwyVG0yNXVjNlpnK2R4YVVsU0lvSEl5K0lSYlhPQ0Y0V1hIQ0ZScEZhWWNG?=
 =?utf-8?B?RGFSMFd6aFZRT1hUR0w5RlpCcTNvTXhYMW1DVE1IMk1tWGhRQ2R3VjVUVllF?=
 =?utf-8?B?a3QrVm4wZ01aK1UwN3B4QUlxcnZIdm1RYjMrUFBWQk0zVS9wUEtrclZ0YWUx?=
 =?utf-8?B?SVhPU05LbDVFMzU0djZUaWJDbjNrYXNqOFpCMkNTTkJzams1T05rV0pDTHp1?=
 =?utf-8?B?RlkydW5qb1Z3T1IyaXl5dEpaQ09idXk4eS9ZWXlXOGFqZmlRMm05L0VBdy9j?=
 =?utf-8?B?WXpTUWJ4TG5hRGN0U1FaOXVGVVlHaU9hMEhGb1NpZGtsalg5SWYrUFBZMFZB?=
 =?utf-8?B?cnJ1a3NydUtjcUZpSXBPUzcvN3VsMEpNdGdGaUVXa0wxajZrUlFoZHJpYTBu?=
 =?utf-8?B?SGhnT3VzZk5ZNHgyMzlZTkNGc0ZGYzNmR2JHQXU4ZUhUbVFHODBwZlpqS2hM?=
 =?utf-8?B?dDhZaGhtN2E1WlJhQzlJSTk2ZXdnQ3RORVowNW9jZDB6ZCtKTDR1cERiQ1BP?=
 =?utf-8?B?SDhXQ0FIUjBjMTV1SFdvY0dQRVVhZmY5dUw1TGJRVTJEMUtmK0FFc1FxaTls?=
 =?utf-8?B?NXRoNS9yQ3VpSHFXc3JENHVoRDNoaDFTelBRYVpWYUJNUXFLM05zSkg4VkY3?=
 =?utf-8?B?OXR3bWZ6SmhYQWRINFdxd01VVkRRUUVYamlkdWliRFRRS3cyVjlDMG1HeGVt?=
 =?utf-8?B?QnlGL05uc3VqOTZSQlRCL1VrdUxodlRWejdRelJqRitGcHJQcTNJOVltSDF1?=
 =?utf-8?B?SHpyRGk2SmRUYW95WFVGT3htMTdDUENDekdhcTZTaG8yQmpyMWV1VmJjZW10?=
 =?utf-8?B?L0xPVnBhdTV2dGcvRlJoM2pCZnhWTzFuUVBnQzNCYUxzd0g5ZHdGamVUeVA0?=
 =?utf-8?Q?Ejh7yOJedT2nQlEzP+6g6SuHLwB7yh08?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFQ3NG9vZEZiaWtGelAzK013ei9kaFk1NEFzQXczWHE2NHdTNDNQaGtRb0l3?=
 =?utf-8?B?c3ZhTGRnK1pnbWY2L2NMOENzalNUUkhGYWR4OHp6cXhyV3RCajR5a3JxbTJt?=
 =?utf-8?B?WFZYSjVJU2k1ZW9Zb1pWdFo1UFJudERqclJCb2RGS3FRVzk1VlVJMHdnQ2ZP?=
 =?utf-8?B?RFZ1bkFPYkVrYnU0Y0lPaEQvZzk2Tk9ORiswOEtkWGNwWWVVWTQwMFpuaElQ?=
 =?utf-8?B?YWNic0pLSTRXNTQ5Vk9KT3kvWllNTUJGZTJ1bUhqOUxxNFdJV01lMlFVcjZP?=
 =?utf-8?B?N0VaUThpTDhLbkJhVENtakcxeTBzTjN5ZytocXd3RitFdWZYcm01SnlMbnBj?=
 =?utf-8?B?YmgwcGpVUkI1dzRENHRrdWxPaDd2aDFEbkRUZk1mSmhDdXJjYjBiZFlkTmN5?=
 =?utf-8?B?bENtd0prdlByY0M2N3E2eDdCcXpYK3pFSVpURnhkMG9lWkZrVFZBV1NyaDM2?=
 =?utf-8?B?MlhuQ3FMOUxrQjNrWWk5eDJSOU5rQ0MxbzNFVW5WSHh2VnA3YUhxRDc1M0Rp?=
 =?utf-8?B?aVRxZDBUMUhpVVFadDRtY3JmaDArNzZVNmcwNU94YUNhSzJhMTlZd0RVMUpi?=
 =?utf-8?B?Q0t5WU81WEk5MWlvVTh6cnE0NXNONytESzJ1WHBtTmcvY1p2QnY4cHlJOFpt?=
 =?utf-8?B?dmlEaWg1ZklqSXQ2TXRMOWhkM3pmcVZ3andHSXRibFFTanN2VzhiS0JBdHpP?=
 =?utf-8?B?K2E3K0hCcXdGdFZETFhydmU4N3UwVUtScVJ3Tk95ZXp6WitDYUZxRjQ4N1lX?=
 =?utf-8?B?SmVjeXdkUnMwWGVjVkJDYWJaSzEvQU9zNHpaS1A0S0xsZWkwOTRpaVg5OCts?=
 =?utf-8?B?RS9KQU9ETTUzTWNTa2t6RWRVTHFBMXNrTHFLWGhiQlo1S2hYMGt2aVJvVmVU?=
 =?utf-8?B?bmwzV0NFZ2R3b2pBenVoUUJJWnlzcmZFNlpjTTVvaHRPTEVaL0QyYVRncHBv?=
 =?utf-8?B?VWdBUEc3TW9rSk4yRncxZFk1SFRoazBvTHl1b0oybElZRUZydTZGUFFRRVBF?=
 =?utf-8?B?Wk14QjRhYnJnZEtIUEZYaVMwOTNxNEEyRVpFL09LL2MvSHl3U05zYm9nTlpw?=
 =?utf-8?B?MWxKc05PMDRRK2U5OWdkVWpFMkdlcHlhOUZOYkFPbk9xVHJjTncvSlh3ZmVl?=
 =?utf-8?B?RWhiN2JjdERvcVZlbDNYYmRwZDdTUTIwV1ptTXhkanAycm8vUHhNZ1hiRVZF?=
 =?utf-8?B?dVVFdldWeERPdHhjQXJ4OXZkVFpPZ3ExRDNoTjNHQjJvQnNEYldDcU9mcU9V?=
 =?utf-8?B?M2dMTnpkUStrRTBjR0o2c1VWNnA2NzZXMXNsbFhDdk8zNjJkSkNiUFUxTEJY?=
 =?utf-8?B?VHNjcEROOHJFeWJxY1M4aDB2T3I0ZXVwc0VwNVhPMy9DekRxeElyWDBMZXR5?=
 =?utf-8?B?MXFnVHdBT2N4YWpBVGtITXhHS0FVd0F5RVEwejZjQTRueWJRbGExb2hPMFdZ?=
 =?utf-8?B?SG9RVkJiUWR4Vnh3Sy81TmtYeCtkSVl2K3h6WDNRY2Nzd1VrbXd4TmkxY3Zw?=
 =?utf-8?B?UlN2Wi9sY1VCQjFBN1Y0WVhvb0ZoV3RpbE5oNUh1RFN1MEg4U0kzQU9qT1ll?=
 =?utf-8?B?NlVTZjd5S2hDejNWMGZPOWVmZUlyZUpYQ0d6aGNXS3NIckF3RlNWV1lROHdk?=
 =?utf-8?B?Yk80Vm54S0w3Y1BBazdKd0t6a3ZjVjJ4K0IzWUNwNTZETTJnUnlyaDk1ZTN1?=
 =?utf-8?B?aE8xcWM4V3p4cE5oVmlnYUthVkZUTWdBRjIwUEZIaFJENzVKYkFReXBUaERo?=
 =?utf-8?B?WHE5ZFNwOEI5TGxQUWJ4QlpzM1hxYTM4Rzh4YkNqejV5WmtYdHZ4c05Ia0hs?=
 =?utf-8?B?elZZRitIRGJONVZuZVdjbmQxR1BROGdPb2JwMm1tMGJBM25WeVZIaGdPcjk2?=
 =?utf-8?B?WG1DczN0TWd3bG9JMXc1R2RCM3dZRHVFUVFxSkErTzYrV2VHSmIyMjZtUHph?=
 =?utf-8?B?WEZzNEp2WjhGOFNvOXFrWWZUQWdaUk8yLzFBK0YzVFBRZGRRbGROWm82TjNw?=
 =?utf-8?B?Z0JlcnZGaHRUc2J0Mmh2ZTNZZmVZMStHS0N1Q2VTSkZZMGZjejVhZmdWc28r?=
 =?utf-8?B?aEhVQ3kybGJyc0NNbm9aalJMdEFRNXFXMzc4RzFGSFNROWVJNU5ZNGcxSUhs?=
 =?utf-8?B?WWFSZzIvdFlWdkluMmxVbGsyOHFvSVZZR1c5dGorNlJaYitIdE1BbXdaK05i?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e39dec-ee48-4f8b-3b53-08de32ce492a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 00:44:30.6590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEnGA5mDGwSU44B2rcEl5AwaHWEISbl8ovzO5bW36Lr/O4TlIof7JQlXMA059jJNBqh9noUIF4wIdUmcQZyxwW82n4D3l/7jJB7//p8yq+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
X-OriginatorOrg: intel.com

--------------Nwy5yd7cfV8pXtOSQf26L9m4
Content-Type: multipart/mixed; boundary="------------Wd0J07Ps0XSqlWjKaO2ZTqwE";
 protected-headers="v1"
Message-ID: <7f8aca3d-192e-4471-8403-31c9811fa02e@intel.com>
Date: Wed, 3 Dec 2025 16:44:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] bnxt_en: Add PTP .getcrosststamp() interface
 to get device/host times
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Somnath Kotur <somnath.kotur@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
 <20251126215648.1885936-8-michael.chan@broadcom.com>
 <15501b84-2c35-466c-8347-c9ca406affb9@linux.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <15501b84-2c35-466c-8347-c9ca406affb9@linux.dev>

--------------Wd0J07Ps0XSqlWjKaO2ZTqwE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 12/2/2025 2:21 PM, Vadim Fedorenko wrote:
> On 26/11/2025 21:56, Michael Chan wrote:
>=20
> [...]
>=20
>> +static int bnxt_ptp_getcrosststamp(struct ptp_clock_info *ptp_info,
>> +				   struct system_device_crosststamp *xtstamp)
>> +{
>> +	struct bnxt_ptp_cfg *ptp =3D container_of(ptp_info, struct bnxt_ptp_=
cfg,
>> +						ptp_info);
>> +
>> +	if (!(ptp->bp->fw_cap & BNXT_FW_CAP_PTP_PTM))
>> +		return -EOPNOTSUPP;
>=20
> to have it enabled for x86-only (as the only supported platform as of
> now), additional check is needed:
>=20
> if (pcie_ptm_enabled(ptp->bp->pdev) && boot_cpu_has(X86_FEATURE_ART))
> 	return -EOPNOTSUPP;
>=20

Yep. This is the right way to check for the support, assuming its
standard PCIe PTM and not a custom implementation (as happened on a few
Intel LOMs in the past before standardization of PTM). You definitely
need to check for X86_FEATURE_ART since you're using the ART conversions.=


Thanks,
Jake

--------------Wd0J07Ps0XSqlWjKaO2ZTqwE--

--------------Nwy5yd7cfV8pXtOSQf26L9m4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaTDZbAUDAAAAAAAKCRBqll0+bw8o6EfK
AP9QgJLfqx6SASjTwlgc7qNr2PhldRwmYr5TQJmeQm0A4wEArmHshFoq1N5XBtqTjeSCz7Htxwkz
DZ5VSZOJXM4mfgI=
=n2Iz
-----END PGP SIGNATURE-----

--------------Nwy5yd7cfV8pXtOSQf26L9m4--


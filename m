Return-Path: <netdev+bounces-218000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A51B3AC9A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 23:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA38188D66E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD812BF3C5;
	Thu, 28 Aug 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y75t8Mw1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC72C08A1
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415652; cv=fail; b=DBpwfiS9hS4sXtCzBR0CwqOkaS+/aa4wRLLeb2DMYh71b1w9Okzk0E70KFTeMW11F5XKQH7OCu1YMogWllH6rI8O4uIcCAAYT4EHsP0vvVnAO4fCBmyEn7k8oUOxFZgWKbp4o1A8u6CNK0QVIRl/DNASHxj6zr2lPDUh3NZTl50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415652; c=relaxed/simple;
	bh=jy7mY+TZPDRQJsKBmcfOD8OI577UuGskfo7ORjatPic=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PWSkCeSkZ8eg/b5QICYyqX4fq07FxPV7GZdhYxTY/tOCPc4yqL90fn0TcTIXlZodUqCdx3EqaSkCzmlbT2NL52ss227TX+q9UiB1GZcwaVfFeyu6JQma5xr4MCZCT6TqpXTIMUyUEqJOIyikxbE99zxkNEaHNv/Dz1MkcZgfmLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y75t8Mw1; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756415650; x=1787951650;
  h=message-id:date:subject:to:references:from:in-reply-to:
   mime-version;
  bh=jy7mY+TZPDRQJsKBmcfOD8OI577UuGskfo7ORjatPic=;
  b=Y75t8Mw1/QlTEs9nudehXI36y7JgD9Q1x6JpET2c7lrjWkXMQbnV6J/Z
   T4eo2GLKuyOEtotkYSb5ZoxXo0+QXHLVfodgB8ktzSCvLe1z8QbIxkJc9
   TshjA7Zqr2sYadWhxCQ9eRzrnf5sm30fkDq0Q/eO4hDTKhxFrKkY68Z/7
   VJ+a/04+3PePKNnGJLsFYEuDS04wlt6u7tQl7N0A0dLWYET/1qIGHDTQa
   vb82WtmFiNtuC36XfipY2v125b/F6HCYTPbDwI5VwmfUzZGSSqQF3Ra1o
   jTUEAERYuJbxhAlcaYuKVL0Pm64nszZ233AgrBrm0nysT1hQk6joW7bB4
   g==;
X-CSE-ConnectionGUID: naodeNmXTI+qxkoLWoHhIg==
X-CSE-MsgGUID: d2lhFyzRSRWKC44UZH34Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76148597"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="76148597"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:14:09 -0700
X-CSE-ConnectionGUID: xwoqbnF/RhygtwMcxNqADQ==
X-CSE-MsgGUID: 8XsBozHlTB+BItGZeXd0AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="169468603"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:14:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:14:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 14:14:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.58)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:14:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s30r3G47c/x9Lkm2nv8qtKaMTGJZUZmoMFOUNxV2F+ZoI/Ohu1xDe0JeHyWCwfsItWQjCOpZdH9SyrwRfIMXKhPPVPHfr1YOaYMEAeyYERFnqEQM91MTDPn0HP6gLdYivILCDwNjaTD5hQ8v6RUIZL6aGMakxg4iihObtL4jpV9v+QkF2/TACbrpMUBeQ5HULJ10Ymq/KVPhU1r5xuOxMnPGw5eXzR8kiGe1q02J18CKUpbZf3MKH+OfAmXtJC75zZo+G9gs5lsY7qZGePvHt/m1xPjVUKAav/CIlj9asvIsggew00JqZ8je42yL4MHIrlvbyxGt4J5gniADvW0siA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzPK6+Ds/hvEdZ4LCrIdllEPDlhG1vcLBvsFjztwSEY=;
 b=HS1ppkGyJqqzXF3Md8I+p447pTcAl0iZFQjSiIJ9VAdoFkhROJtQLGthjs3BSoD1P54b1kTviTZ5Qxnx93UYLGZT8C83mKGd6JChgoxRzxX/6b42uWCr3QZetXnl0Ij/Zjn/+GmNkxp/Q/S5CmSu/Mrco2fwxxTsdw6z0YA/eekNyEyPCGbvJg7wCnanxadW2JDwsL9HhY35BFjVu7ZLHIncRHpWSRq3xxqM4GBQ/97Fue7qk0afdeBU9V7GPGKJbrkDKEkkdm3bdiTmtrXciA9jrnTNB8MrKgcBaFs5kUaLkFK6yKEiydozzZjSEKWX5kHYHez/hcOFKpqooATDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB6277.namprd11.prod.outlook.com (2603:10b6:208:3c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 21:14:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 21:14:01 +0000
Message-ID: <888030bd-437e-4a40-8205-41417a8df7b6@intel.com>
Date: Thu, 28 Aug 2025 14:14:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] i40e: fix Jumbo Frame
 support after iPXE boot
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
References: <20250827-jk-fix-i40e-ice-pxe-9k-mtu-v3-1-14341728e572@intel.com>
 <IA3PR11MB8986CC2D4EF48CA3678C668AE53BA@IA3PR11MB8986.namprd11.prod.outlook.com>
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
In-Reply-To: <IA3PR11MB8986CC2D4EF48CA3678C668AE53BA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Olo7UYT390tC3hBf7pkA0xtJ"
X-ClientProxiedBy: MW4P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN0PR11MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 27dbb695-ae60-4c32-eeed-08dde677cfbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEhkZnRVWG5PME5XS28zNnNkYkZVVFc5MU5iN0FCMlBXc3pIb2Nka2FheHAr?=
 =?utf-8?B?OVp4bENuMDRxWEMwLzA0VU5xQlcrKytKL0xvU0p5cHNFb1lTSE8rWThwc0JJ?=
 =?utf-8?B?TWZLTExER3JmTXcycVRSTnE4eHVKL05QMTlQbUR3N0Z0UXBxY3VvaDJtREth?=
 =?utf-8?B?WmZEUjduTUV2cEpjU3RHcUxzeU04TUFuSWIzTjZLdDJCK1FhdjhXbktmSlBn?=
 =?utf-8?B?VC9JYW9YamgyR0ltVHAwbDVxcTgwWnF6ZmJoZGxwL2dvUCtQMm02Z29NemZM?=
 =?utf-8?B?L1RxQmZpYlE2dStSK2p2K3FGRXpmQzVCUnNYRStHcjVZTE1WUDFrUEZTRndG?=
 =?utf-8?B?R0wxSlA2WUlINDdscENpWlJVOUV6WW1lV3hydkZOeVk4MUR0Ly9VVEpUaGh6?=
 =?utf-8?B?MmVZUlQ0VmlvZ0VRZFhCREdPak1WekMveHJ6cm1WY3FYakN0WGFMc2ZMTTdO?=
 =?utf-8?B?OSt3Nmp0cnlHeXRldmVUUDZVcHpUVWVPMXdMdjZrbEkwQWZDZFpReUR4bWM2?=
 =?utf-8?B?QlFxOFNqblVLdWdnZklaMnZzZ2c3RnZDSVVJSjFoWTNnWWJWVlBDMzJoY3pm?=
 =?utf-8?B?cDZkN3pZUURYdzVLcmE3cXJrMHJ2ajE0Rlg4a2xLNmdPK1JQNVVKZlJxTTNw?=
 =?utf-8?B?K0ozTEZ4M3FYU3NHUHBGOE9uYm9ncVAzMitoc01ZSWFCYjFlSzlPekF0RFpZ?=
 =?utf-8?B?NlVOb29USXpHLzVFYkQ4YXMveFBsN1BqN3FDMnFHY1dDb2hFcElKbTd2NnBX?=
 =?utf-8?B?b0VZRVVudHNYY0Q0TGhDVzV4VjB4UERzNzAvRm0xQjlxRFcxdnJycng4YlFa?=
 =?utf-8?B?RzhUbDluemNDRVZDa1NuaWVCc0hYMGVvUE8ybW8rQjcvbWcvN1RoVEJQZ3Az?=
 =?utf-8?B?dU03dG9sajZlWkVQM04wMkZUNFpvVkhaZHlSUDZBMHlvOEFHZitqdytWTVlK?=
 =?utf-8?B?MUxWenhBTkRpQWR1Z2NBOTN5TWliYWFzWlh5ZFIyNU1kOFJQVk54RG1UZFBx?=
 =?utf-8?B?VVFaNTBjVHB2ejdTZWJXVzhsbXI2dko2R2t1WXlaK1QrS09XclVRZStsbXph?=
 =?utf-8?B?cDdOb0NTa0NYVkpZbzVHVDFTZXFwd01reVdWa25iMC91OWtzUUlZNlZNODVS?=
 =?utf-8?B?QXJyUnNYTzA1YUIzdi9QWGhCajNtOXJFYW9wazNIV1lXdk1zWVBkK01kaDZ1?=
 =?utf-8?B?ZmFLRUZpbmtuRkprK2pFcU9Ma3ZGWWNrS1ZTMlU2ZU12RlVyM2c5WnB3MkpH?=
 =?utf-8?B?RWprSFNFSUU1bkZmWTJSWlBrek5TbXY2N09yTW5IcmNOZFVpNXNNR0FOTEhJ?=
 =?utf-8?B?MW5semMreGZoOXpzeGNTL2hST3FOTThMOHdSYlAydG1hbG9jZUdoYmRUNUZC?=
 =?utf-8?B?ajZYWEVMWkdzUTZVc3prSXQxOUhYakY4a2tmUTFLYlo1QWxrcFYwcTZrYzU2?=
 =?utf-8?B?Q09HaFRNV1RkT1ZRNk9ZWTJhaWdCOGg5TVRuMWowRG1oL3dZOFdPbkJtWU1V?=
 =?utf-8?B?ZEVnWTIzUmJ1LzZDL0ZWNGNTQWw1dXN0VDRDVlRiOE9oWnVaRi9tNGYxVjRp?=
 =?utf-8?B?MFp5SVp6V0JkdFI5dVIrVlpObVM4dmdPMmlhQjIzSHhPbkNjcmNiMXk1dXNE?=
 =?utf-8?B?N2M0M1dxbmRzN09ycWpWMHhkNUcxTnpPTUJQSGMzdFlxQUh1SmhsL1BXWS9h?=
 =?utf-8?B?RHZ2RUhIVmNvaVA3UDNubUJ5RjMyYzJoUWJUSC8wRS9xdFdjMnNwdWg5VTNw?=
 =?utf-8?B?a1EwaWhFNGdvek10UDUrZzZseXdUOFZ1OC9HblBQamxPYmo4K21VclVETWFZ?=
 =?utf-8?B?c1F4bFVYa05uaUpxN0trc3B3ejhmbHJjUkk5U04zcThaL1JORGQwSTUxbDVu?=
 =?utf-8?B?cGlHd3VQTWhMWUZaM1M5UE4ySVFsaVZZY0J3TldTVWorR1lyNUdreGpIclNN?=
 =?utf-8?Q?sfujzsicdZ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1sTVVWR3RNWXJiemhmU2FuVGZLUSs0VXdvTWFJT2JWaXFzU3BVTmV0L2RH?=
 =?utf-8?B?VXNtRlAxSm90N1d2ZlFuSTh1VHRoNWxCSDJaQUlpdzRlMTZ4U29zRFo3MHFG?=
 =?utf-8?B?S0V3cW1DMUF3bjFDbjFKTXVpZkY3azZVUTI2OCtrZG5aR3RadGxLMEZzaWYr?=
 =?utf-8?B?bmJ3M0E4cnRPNnA4bm1uTDZsQVZSdmFPY2ZlY2trZUhMc1hpU3lORTd1U0Yz?=
 =?utf-8?B?V0h5dWNObVVuRjFLc3MzWHVFdVlYQjdMSXE4RFFxdUNPQU5pbExNeW1jR00z?=
 =?utf-8?B?aS96czYyd1hRdjM4WXRaOUFReGpaa2ExRVdqUkRYcnZ4bVpFOVN4QXhyU0Q0?=
 =?utf-8?B?b3IrZGxDQyt3Vk40WW9HOEFPR1k3NUJNNzVYMnhoSjJGUVB1Z2owM24wOTFx?=
 =?utf-8?B?dmFIblVySTZKajRpMWxzUkFaMWxWaHlwQzF1UGJyRmg4Yk9JdHFTQXRRSnpN?=
 =?utf-8?B?TmdZVGg1WVcxUm1SZXBZRHpXNVdJaDM1ZmNQd2NMZGcyanh1OGpQTkV2b3Jv?=
 =?utf-8?B?cCswVEI0czR1cDRnODlWVzQyb29sa1NsbE9mYXdyZHIvTDNjeDArUVdkZ1Ev?=
 =?utf-8?B?ZExna0lndnRhdGhPZ2ZLcG5zUGRqcXhzMWdjUHUzMHFnRjhkTXBxWDkxb1I4?=
 =?utf-8?B?SWRhSzBkTnp6bjI0ZjdCdkFDV2lCOU9QTlBmZ3N2TkJxOXZ2YnNPeEs5RHVC?=
 =?utf-8?B?UUlzQkpuNGJTWGlnMnF4TmhxaXhHKzJIVThwNnlYNk1JZ2dVSzVkR0swdEVv?=
 =?utf-8?B?b0FhbjZQYjJTdHQ3SFhRdjkzZHFTN1BPUTdZbk0xV3FSWHJUU3hibm9uZDA3?=
 =?utf-8?B?QSt4SXdOQ01DalNqVm4wWW5FdVM1dEJpVTVWRmxJOFh6U2dyYi9FN2F4MzZN?=
 =?utf-8?B?dTIzUExsQTJTdTZJeXl4T1lzcGs3VmNZUjlkcW1oKzNUUnpwc0ovN0ExY3ov?=
 =?utf-8?B?TzRGczFrTWR6RUpVb21kMnZXeGZOWDlpZ1BtV2p1bVpLajBTMEkvTEpaVmVC?=
 =?utf-8?B?alhlY3ZxL0QyTG85YmhZSzVyNWpOTStIYXlabHYxU2tYM0xrOW0zWXZpeE51?=
 =?utf-8?B?a3V2RFdFY3BJTmpKNlFGcFRPQ1RaRFF2OHQyU1hxU3NaWHZ4amlFNWI0eVp4?=
 =?utf-8?B?blVrN2E5ZHdVdGxQMkt5UG9Dc0VlemRBdlFVSVNIWENzeFhJaGdaMEZxeG4w?=
 =?utf-8?B?M0NyREJYei9UUm5FMXAxRmJSd01jV0diQ1haOWtHVmtqUmMxSVRRejhlVzJz?=
 =?utf-8?B?dW4ra2lmYnZQc2ZCd2liTTl0M0pGNUxYSGxlclBXdjQyNkFkWENZYmw5Y0hY?=
 =?utf-8?B?SUhxaTQwQnhrNEhPaEN4dmhaSUp5bmsxV1BIenRFYmRNWVo2dkFaMlRBcC9K?=
 =?utf-8?B?WmtMaC94V2Q2WGN0bmJnWUJmblF2dTJISms3dGhwZjh6K3R6enpRNVpnSWx0?=
 =?utf-8?B?dERHenhlM01HVzJmbm9WYStYS0VkQXV4b1JNcWE1aXNjNmxXVzJpS2t1MHBt?=
 =?utf-8?B?SHBhRXBBVlpHbG0yY1puVEs5WFo4QldiblFiRURRdDZvN1hzdmlMR1VVcGVV?=
 =?utf-8?B?T2JCb2JydCswQXNQRVlCdkdmRU1ueEhQVzlzNDhBYlp0U1J0bkxoK1BhamlZ?=
 =?utf-8?B?SzR4ZnJtVXY5b3Uzb0NqVDdwWDFSZnQyZXo4NW9td294OEJxYWgvTDkzblJI?=
 =?utf-8?B?b1U1Z21VcHc2Uk1SOTFkTDRtTmd4Z2pYOGJDZkhnR29zUXJLOVhFbXhVUG5q?=
 =?utf-8?B?TE9JMG1MeVVLak5KYkNHSHJvd2lMVmhjRjJaNnM5Mm1kOHhCYXZWbFRoT2tz?=
 =?utf-8?B?NTExVml0SGVTTEViT3VBMUdvaDIwR2JDU0xwcVZxVTlxSExJVVpVM0thRDZy?=
 =?utf-8?B?TUtxU29JNHliakZ4cHl1c0tJemlEclV4K1NtUmdiVXhwejRMNy9ERVBUV0l1?=
 =?utf-8?B?dkFjd1dyclRjcFRhSDV1cmlHbW41T0c0eW9HOWlYZ3FCVkE0QStRVVpmeDFF?=
 =?utf-8?B?VXB0d0pla0hQMXNsZGMrS0VYMDVvNk1PT2Zjczlrb3psNEVLQ3Z2OEs1NVhE?=
 =?utf-8?B?TmQ4akpBeDVnMkw4VGVUNGdEK0xUcm5KZ1ZvTjF4bldTamZhclYxeEV1b0Ix?=
 =?utf-8?B?Nml6c0ZiTHdUZThCdVZzODlMY3ZTaWZWWWM5bjdydVZadm5nM29XK1pTSnJr?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dbb695-ae60-4c32-eeed-08dde677cfbc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 21:14:01.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8hdvEhtyxJ+lHGObRA9lt0tyElDC/6GYapjJ1uOpKNLK6VcvXteC7qZkPeN6XrjoOzNVwazJFl+sabAa4dLbelWu3Be+DYcXD43qY6pD+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6277
X-OriginatorOrg: intel.com

--------------Olo7UYT390tC3hBf7pkA0xtJ
Content-Type: multipart/mixed; boundary="------------YWy1v6FW5xmUhSAvTl71YFIl";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <888030bd-437e-4a40-8205-41417a8df7b6@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] i40e: fix Jumbo Frame
 support after iPXE boot
References: <20250827-jk-fix-i40e-ice-pxe-9k-mtu-v3-1-14341728e572@intel.com>
 <IA3PR11MB8986CC2D4EF48CA3678C668AE53BA@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986CC2D4EF48CA3678C668AE53BA@IA3PR11MB8986.namprd11.prod.outlook.com>

--------------YWy1v6FW5xmUhSAvTl71YFIl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/28/2025 5:22 AM, Loktionov, Aleksandr wrote:
>=20
>=20
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Jacob Keller
>> Sent: Wednesday, August 27, 2025 11:18 PM
>> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; Nguyen,
>> Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org
>> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
>> Subject: [Intel-wired-lan] [PATCH iwl-net v3] i40e: fix Jumbo Frame
>> support after iPXE boot
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index b83f823e4917..4796fdd0b966 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> @@ -16045,13 +16045,18 @@ static int i40e_probe(struct pci_dev
>> *pdev, const struct pci_device_id *ent)
>>  		dev_dbg(&pf->pdev->dev, "get supported phy types ret =3D
>> %pe last_status =3D  %s\n",
>>  			ERR_PTR(err), libie_aq_str(pf-
>>> hw.aq.asq_last_status));
>>
>> -	/* make sure the MFS hasn't been set lower than the default
>> */
>>  #define MAX_FRAME_SIZE_DEFAULT 0x2600
> Can you consider re-name MAX_FRAME_SIZE_DEFAULT into I40E_MAX_FRAME_SIZ=
E_DEFAULT ?
>=20

We could. Its not in a header file so shouldn't pollute other files
which is why I originally opted to keep the name as-is.

>> -	val =3D FIELD_GET(I40E_PRTGL_SAH_MFS_MASK,
>> -			rd32(&pf->hw, I40E_PRTGL_SAH));
>> -	if (val < MAX_FRAME_SIZE_DEFAULT)
>> -		dev_warn(&pdev->dev, "MFS for port %x (%d) has been set
>> below the default (%d)\n",
>> -			 pf->hw.port, val, MAX_FRAME_SIZE_DEFAULT);
>> +
>> +	err =3D i40e_aq_set_mac_config(hw, MAX_FRAME_SIZE_DEFAULT,
>> NULL);
> Are you sure it's safe to use hw var here? Because old code used pf->hw=
=2E
>=20

Yes. I don't know why the original code used pf->hw, but we have a local
hw variable which points to the proper address already in this function.

>> +	if (err) {
>> +		dev_warn(&pdev->dev, "set mac config ret =3D  %pe
>> last_status =3D  %s\n",
>> +			 ERR_PTR(err), libie_aq_str(pf-
>>> hw.aq.asq_last_status));
>> +	}
>> +
>> +	/* Make sure the MFS is set to the expected value */
>> +	val =3D rd32(hw, I40E_PRTGL_SAH);
>> +	FIELD_MODIFY(I40E_PRTGL_SAH_MFS_MASK, &val,
>> MAX_FRAME_SIZE_DEFAULT);
>> +	wr32(hw, I40E_PRTGL_SAH, val);
>>
>>  	/* Add a filter to drop all Flow control frames from any VSI
>> from being
>>  	 * transmitted. By doing so we stop a malicious VF from
>> sending out
>>
>> ---
>> base-commit: ceb9515524046252c522b16f38881e8837ec0d91
>> change-id: 20250813-jk-fix-i40e-ice-pxe-9k-mtu-2b6d03621cd9
>>
>> Best regards,
>> --
>> Jacob Keller <jacob.e.keller@intel.com>
>=20
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
>=20


--------------YWy1v6FW5xmUhSAvTl71YFIl--

--------------Olo7UYT390tC3hBf7pkA0xtJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLDGmAUDAAAAAAAKCRBqll0+bw8o6O2r
APwLzhkhnKEEeY9FzL0nuyv3h0OiyuAnzWNOOXNzMgUZBwD/f9nO2liKZDRHTp4kBorVMM4EmSlB
/3tlyNhwKLSZYwc=
=acIg
-----END PGP SIGNATURE-----

--------------Olo7UYT390tC3hBf7pkA0xtJ--


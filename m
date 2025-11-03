Return-Path: <netdev+bounces-235268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 290C0C2E676
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42443B9E15
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C3B663;
	Mon,  3 Nov 2025 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZzNXORo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5834D380
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212756; cv=fail; b=n5Ib+YwoS5QnjRQ3h7nDB0/azmDQslWmDnkMPQIogj4qraPE3kXtoO8/YIwESNUPZvMGrM5pmvK9QskuRIc8ihOTUVbkutTqvZYFseZCdRZtW19q9v1jRi0I03tewDPL/QhNfG/NxIOqiUobO9VoSANWAjCu9EB+CSmH5KYVm4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212756; c=relaxed/simple;
	bh=BCxxIiBRaFsXibCmJu8/kzsC3kWZ83Sbs2YEUOqysJU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1kQNF939c2Oh48SqUbCP7nA6nxVm6FddjhHmCmaw8Czg+G9vnO0ufBcUneAPQadYUhO+2XxK27ac3TDdaTVyStLhA70lFPpYOt8s7OelNqy9RGHMOgNtLeFP/DskYTV3HLKMDj20yK59JORQ5i3YEscQlQTnhA44oSapyWIJ/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZzNXORo; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762212755; x=1793748755;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=BCxxIiBRaFsXibCmJu8/kzsC3kWZ83Sbs2YEUOqysJU=;
  b=eZzNXORocMm1GgmLufv8Vx328tlVN5dZjg04hD0WtwnhBb5m42u8OiEg
   GAGJB/FTTnaFLNHLXyW3dZE6LoCTqY9m27aFS0leCJb3+tAW3pqLjPYsE
   EFaCy8D0FQkeINE3UDdUvyd1qKseMcFKZFSmhx9Maa3b6KSeeR73/u0Ej
   jgzxt49omFcn4sXlA3UuVutZDL//sAXlRhF05O2c45E7VmJS5+D39wq7R
   twQXDSMvww0i02e9s6sbq7hWefq+0PfqrjCU4q5/7DFUDuVT6ClBgUoma
   LU+czLZ7RlVlkOXvi6G9jzpWvM3jvMfKDEh5Ndn+045R1aAzAdXqQDKzc
   g==;
X-CSE-ConnectionGUID: PzZcsjqPTQycPJkuhp7zeQ==
X-CSE-MsgGUID: AO1n/CLUT8m+84Pfw8KLCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="81928671"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="81928671"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:32:34 -0800
X-CSE-ConnectionGUID: DLO2J/eNQSaB3uskbz8K1A==
X-CSE-MsgGUID: tvFgPqvJQ9O6DZy3BX8hDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="186683726"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:32:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:32:33 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 15:32:33 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:32:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oamXQ/VnJ3sbyHyQxYTJaIdvid+/n3c51qhFIjEaa3ORt8UwL6ioHPiz/KcFwO5AnfWZMbUz+XQqHEvoDiqg2IoQBwHL0IenmB8GtsxbW57YxvE+6cfddGJxe5D8ICyjEVAlC+E7o6zEj9Pqw2d6NMeqJPBBTK+uNh7UQ5QBO1j8+LH2GKB5lHpeLEkcrS6kd/LhYm35DKPrKVOeWHGn/3RGl+Zdunx8reDvZzoDmpWSZhiRfLFQGJJi5+zEDa5o3Y/C2lY5YzpEJJ4ft0BG1kGXSfCn3hBgJz3ppwEfeW5JxhPzMOH+TqkhUkEawAmcUfcavYK2iRMsmUPs8CMw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/hzPGJs1zyVYdOuMHOHhWjXGXeAqBL8aJ8K8Lda0Yo=;
 b=aUVCrPflBTMnTtqU7BF3uM28mswmrrnoej7v1krBDTwQubJ8fCI596DyiOW/y2H0zuM5vCH2GyIhADNqE6bewON7JzFiRHUdqxnRP9m/4jlcQZr8jc//fhmg46UEYT+EJ4PjUlB/4XEgjaSQgEYuDHswi7n6vFZ0h+h/wHuLJaikt09cFQ3FjQuu0ozrMJu51YtFp6hJEeznfKBebEhIAlSKXHF0C25xEMls7yT7WeTjQ4a34LY54p2iqPRVmoTxwnDJR3+IGAeWfV0nt2RT77cqgCuutveEuI3hr+PBJ+y4jn1XOL7cAYV31hBgrqSVMnY7g0046XdmUI2YXZU20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:32:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 23:32:21 +0000
Message-ID: <e1aa32e9-a545-4ef8-bc23-367243f0835d@intel.com>
Date: Mon, 3 Nov 2025 15:32:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: airoha: Add the capability to consume
 out-of-order DMA tx descriptors
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>, Xuegang Lu
	<xuegang.lu@airoha.com>
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
 <20251103-airoha-tx-linked-list-v1-1-baa07982cc30@kernel.org>
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
In-Reply-To: <20251103-airoha-tx-linked-list-v1-1-baa07982cc30@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------0Jc0pvLER03aff7eydhv80EE"
X-ClientProxiedBy: MW4PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:303:dc::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW5PR11MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8756bd-57ca-4a0a-f566-08de1b313c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDFQY055Um1hS1RxUGFFYUJBcmZhM2pHWWZDL1FJMkEvTzgybzR5cHFCU2c1?=
 =?utf-8?B?alg0VnRhM0xvWjBIanRkS3A1Q2pEQnNFZDBNVTZVd1VRdHVza0pOODFxdnBT?=
 =?utf-8?B?dEZodHlvZFdGeDBPRlBNQXpheWwzK3FQRjYzK3JaQ2xLdUIvTUJqQnQ0NkNo?=
 =?utf-8?B?SmV3K3paVDlGQkI3Qi9ySVZvN0JDWlJEWjl6eVVPeGVkQmNILzhBTGRpR042?=
 =?utf-8?B?cVdpVFBzZjFlbjdVSTFGOTF1c3VTNGJVaXM2NUVscUtrb0M0clB4cEpuQ0Ni?=
 =?utf-8?B?eUp0MDNPOHk5am1qa2w2bWVvWmhYK1B6QTFQalVWdU82TjFHNm53bzJoVWZa?=
 =?utf-8?B?VjVERlRHc29hMUhZTWN3ZzZCMXRDY3dZaXpWVVJ5Qk9QOXEvcXRWU2E0SGI4?=
 =?utf-8?B?MEVkR1lWcGx4ajd5RkFWZWJ2dUtaWnV1RlRkT3J6by9ZVUN4aXVVU0dwT1k5?=
 =?utf-8?B?TjFpTEI4ZDR5UWZ0UndZOFhoNDhycG5zTEJlNHRXK1FBbTlRTExsdFNLUEJp?=
 =?utf-8?B?N3c2cTVKYnZoSzNCaGlZdEkvMkg2cjYyZE5HKzRKRmg1Lzd0a3l0bnlnR3g2?=
 =?utf-8?B?RWgyMmhMTlFtVnJ3SUtLa2NRRmxqb21VSGFqV2J2U3F2ZEdZa3hNelNCMlcz?=
 =?utf-8?B?TnBKYmJFamZxOGx5VVZkWDlzNlpxeDZBK3RPSUhMN2t3UUs3bUViaWROMTV0?=
 =?utf-8?B?dEVzSlB0aDdrbUJlWk4zY09nZUtqaUtPL09mcTRiWFA3TEVLRzdlNGY5V2xW?=
 =?utf-8?B?UWQzT1dTMDRoNDgyTWo0cGQzaGRGVEdiYmUrbXZoN3VKZkxBTnRRVEhSMWox?=
 =?utf-8?B?MndrRDBzN04zN3R2VCszM0wrSW9SNnU2VE5sd0FKd2ZpUjI1dThRMGFqWlRp?=
 =?utf-8?B?Y0JiMU1iakFkQzRPTE9weTk0SWJlcmlnOE8xR3JlSDBRN1pZNm4zUzJnNzlo?=
 =?utf-8?B?cFhmbXlSbXRqSXVqa2l0K1B6TDUvZEZtQW92VDd0TnpHTE4xT1ZPWUlQMSti?=
 =?utf-8?B?bHBER21kWXMvMnJQbGlzNnNBdytITUp3OHdrZytJa0VmR282TXBhcFZ4UkND?=
 =?utf-8?B?aVM2QXhVclJHMThqNmJUbFRWM05CMVJwbFJmWHkvNm0rd1p2UWpUdldlSjd4?=
 =?utf-8?B?UkRkK1ZDZW4vKzhZVU56aXFMT1F3VGhjR3dXVTlIV2JWa0VkRFVSL1YzYTJa?=
 =?utf-8?B?VEdPNkpNVUtqVzNNRTBSbUpJZmNnb1p0MUpHbzcvWmgxRDFIeDM2alZtVU4z?=
 =?utf-8?B?UmszMUEySzdwUVZvcjRYMFc1U29FU0NiZWFNbmdQTnAzOU1CUzVGQmg0amh1?=
 =?utf-8?B?Y3g1Q1NUQjVsN213VUZkaHByK3BTcTRnczJWSlR5TFY1b2FabXcwMmdWVGVX?=
 =?utf-8?B?NTJoMGwyOWcxWVlFUU9uSnNJL0YzTUZRTUtKaCtzTlJwY0VjT3dGM2diV0sw?=
 =?utf-8?B?Q3diT3JLZHA3WERHZVhiQ0l5a2padDhWa29RV01ydWhMWXlrbFpWempTdERq?=
 =?utf-8?B?NzZEOWxEK0VWemp1bzFBUXFGdEJySFhLYnNzUFJPTmszVGdybEMvbFUxSXhI?=
 =?utf-8?B?akxSSEcwUlNDVXRjajdmUnRRZFFxUzlTLytMMDlZUmpVeGJob212dk9OWnRu?=
 =?utf-8?B?TUd1V1lDbnFTSFlhZ1Y1eFgrS3I2dWNwTW9kMjVBMjVXLzRNUm13Y24vRHla?=
 =?utf-8?B?elJ0bFUycERLTkdQbXpwUkQ5Y2tIQ3BMWGpsOVQweC9RMFAxQzZKakpkYjhh?=
 =?utf-8?B?cVUyeE9RY3NIc2Z6SjVMNmRFc0hMZWNLZm02ejJ2UGwzUkxDYW5qSmhDS2xp?=
 =?utf-8?B?cUhkbXVLMzJ0YUkyLzVIeXMzdnh5amZ5Q2luVWlpc2doRDZ6SVdtcUpvYWFV?=
 =?utf-8?B?MzdTdzVWREkyWEpyM0pBd3d2cmQ0V3pibkFINHhRdmtqOGFHYlNId2RLRlFD?=
 =?utf-8?Q?cejnx8U1rCu+E4MGNr/6T27ctSlaTbsF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDZ2WXdBTDJiUDc1dmxCN2pzMVFWL1E1ZGUxaXhrRjlqK2RCcTFFRFZmWlhp?=
 =?utf-8?B?VTYwVFovUGpPRUxnMlVwTGw0Z0dLY25iMkZmVk9hUGJKM0Qxb0hYcDVnYkxn?=
 =?utf-8?B?N0VUeGJ5eVc4Q2lIYzNHbnRYSVQwT1hXNHJ0V0tNL3R4M0UwWHNQZ29CYWx4?=
 =?utf-8?B?RndmK2VvVE95R2w1bS9ya3dFQ3Y1VElPdVVzT2x4bFZNRWsvZkFsZ1dFZnR0?=
 =?utf-8?B?dXBKbmJFNnlEK3RxZnpwWEQ4Z3I5Y1h6anVmaTJrY1hDb2FZZ0xZRk5yODNB?=
 =?utf-8?B?TmNPRXArZG1JVDRyUHp3Sld4L2lldkQ2bXRKSmJEb0svbjdXQi9kWHFVblY1?=
 =?utf-8?B?dlNQNlZNdmZoWWp2djFTK1AvNzByQk0yKzZ5dDdiT1daK01vUHRQU2tyYWgv?=
 =?utf-8?B?ZDZ3dHF6VElrc1FYNm1sbTE3SlRJWjY2Ymorc3ZOaEc4RE1USWlOU280UDFV?=
 =?utf-8?B?WUh1Z1hDalZjaUh2a0JIdyt3ZUhXSThkWWo0eDAza3FKalB1VTYzZDlVcGZY?=
 =?utf-8?B?NlVtVlhQK3MyR3Qxa0pkalViVDAwbHhnbU5Qc2pzOVFXU0JGb1FDQVFoMWxR?=
 =?utf-8?B?MTN5eFFKWWJnTCtBY3p2djljSjN4SHZsMkRCVnRHNSt5a1RWRWJRZnFieVBk?=
 =?utf-8?B?RFlwWUdsQkFBajl4a21MMG9vUGxEcmxpTmRja2dXQm8wUkJFNEwxUWdoUEZR?=
 =?utf-8?B?UmliS2M5T1RrS2RWTXNKMmF5cTVOdHNkMlJ4OXJKN2Evb1E0TmJTZU5UbDU0?=
 =?utf-8?B?QXluZlVMTjMvbjN0QmJNMjZydGhzQ0R3ZUJZM0dGdnczZ2QvVWtSMUhFeWl1?=
 =?utf-8?B?a0V3WlhzNWhmbkVaWjArMFU5SEJXV0hPWnQzSFBUT1Y4amZBamF6NmxKdnZB?=
 =?utf-8?B?WktQc29lMkhLTEltdjVrQnczc0FXb1cycXYxWkVGc3hjeVFRL2UwSkhQSGxt?=
 =?utf-8?B?VXZ3cTAyQWdWVDdERmpqY1ZnRklzMHhPV0RoVVNLOUhoeW1Gd1RjeW54K2Ji?=
 =?utf-8?B?azNicVMrNUtjNVlHU1A0NStLKzh4eUx5enp6dGpjNjdaNFpzVmdzT1A5RmFD?=
 =?utf-8?B?QjZ1Q3pzVm5LNDV0eEZjN1o3MW45cXFKMm1yQ096dlEwYTl0SGNqMXFyYkZq?=
 =?utf-8?B?RGk0NzlOcmJtMkZUTUdONjRLUWJWSlAvNWcxZUhmK0cyckxvZy90RHNzcE5j?=
 =?utf-8?B?WkNMN0FRMGVRTGVmOXFGSGkzWFNYZFliQkJwZkJTeGs1dG14QlR5MWRwejZL?=
 =?utf-8?B?TnVDY3ZQK3V3SnlXODBvRDJIYWE5WmNWWHFpMHI3NFJsbnJYcHdoUkVVZ1RE?=
 =?utf-8?B?dnRDVUU4amtFbGEvZmhrUVZFQ0IrT1BUS2hQeDFYOXBsRnplUWMwejJJRnRL?=
 =?utf-8?B?Q255SEFTQk9nSkoxOW1QWHlUNUhLU2hnMDZCVm50L2ExWmF3QnhXTEwrek9l?=
 =?utf-8?B?WlBEOWY5SncyYzhEZkhScFR1YTgyeFNBMmRxQ053UnJrSVdaVVlybm1tYk1Q?=
 =?utf-8?B?ck9ucDFYUnVEa3FXcFExeDJKR0trd05uek4yc0lVUHhkTGsyWVFaZkVyb0N1?=
 =?utf-8?B?Qi9GcndXNm9LNjRtcm42ZENDUk1lVys2LzBKTERJWWowajUvVE5hd0RHMXpC?=
 =?utf-8?B?VGRKZ0J1N0RFOGlnbWNkcjFBaVR5S2RIeHFDTEhObzJsdGdJZFF0SDNBcjhR?=
 =?utf-8?B?TUtxcmJ5RHBFT2xpQW16VkVMRkZDMXFnZTFUTHpTNFpBTjZqd29yTHRKTVU3?=
 =?utf-8?B?dzB1bElKVEVyOG92VHB6bytzanJkdWFVcDV6SXlYK2xNQWcwajR5UlNCWWNJ?=
 =?utf-8?B?ZkpCbklKd2cxZHM2NWxHTjBkRWlSSjdLRFoxcHlnZ0dMc1l2RG1DSUdpM0Zn?=
 =?utf-8?B?TUZGZU95OTZ1UVZPWGpKTDRhR2Y3MHI0clRmS05FalZmNzh4TGNYMGM2Z3Zy?=
 =?utf-8?B?eUdBelltOE5UQmlOZzI4cE1HK2E2YzhEM0V2UTRIM1BFK0phN3pmb1dzbHVw?=
 =?utf-8?B?a0dzVXZQa1hCUVh3RjQyQkVtZlY4WldCeC8zam56TjZJamJLdUhVcGV6UURl?=
 =?utf-8?B?eTl4RjV1akFsNUxWTW4ybkFDcklaNVYxYmVWYkZnYmY3QjhSM2VZU2lTZ2hk?=
 =?utf-8?B?RExCcWxLcGY4TzN2dGpYbzBuTzc4YzdFaUtOSHUwWTBsN2RsQlZTRGJLcERj?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8756bd-57ca-4a0a-f566-08de1b313c89
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:32:21.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJIHYsWhXVjCbHSmJsLEFbioOrFKGhS9pv4aPNqUzPvFUGOU6cr80yG+7PJE/MBRcAy2DGBkSzB/2INENXbGWJUCOR2vKmNWI3MnOBn7NVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-OriginatorOrg: intel.com

--------------0Jc0pvLER03aff7eydhv80EE
Content-Type: multipart/mixed; boundary="------------q5SGgI4Uq7Z98Xa0j0k2lrUy";
 protected-headers="v1"
Message-ID: <e1aa32e9-a545-4ef8-bc23-367243f0835d@intel.com>
Date: Mon, 3 Nov 2025 15:32:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: airoha: Add the capability to consume
 out-of-order DMA tx descriptors
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Xuegang Lu <xuegang.lu@airoha.com>
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
 <20251103-airoha-tx-linked-list-v1-1-baa07982cc30@kernel.org>
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
In-Reply-To: <20251103-airoha-tx-linked-list-v1-1-baa07982cc30@kernel.org>

--------------q5SGgI4Uq7Z98Xa0j0k2lrUy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/3/2025 2:27 AM, Lorenzo Bianconi wrote:
> EN7581 and AN7583 SoCs are capable of DMA mapping non-linear tx skbs on=

> non-consecutive DMA descriptors. This feature is useful when multiple
> flows are queued on the same hw tx queue since it allows to fully utili=
ze
> the available tx DMA descriptors and to avoid the starvation of
> high-priority flow we have in the current codebase due to head-of-line
> blocking introduced by low-priority flows.
>=20
> Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 87 +++++++++++++++---------=
--------
>  drivers/net/ethernet/airoha/airoha_eth.h |  7 ++-
>  2 files changed, 47 insertions(+), 47 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> index 688faf999e4c0a30d53a25877b4a81a33ec7fca2..b717e3efe53cc9c86be8a39=
e7f9b03cc592e7281 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -892,19 +892,13 @@ static int airoha_qdma_tx_napi_poll(struct napi_s=
truct *napi, int budget)
> =20

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------q5SGgI4Uq7Z98Xa0j0k2lrUy--

--------------0Jc0pvLER03aff7eydhv80EE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQk7gwUDAAAAAAAKCRBqll0+bw8o6HX5
AQD3y70WO2CZ5ylfi8p6cu6eFCeoKi8dZ9O9EDf0e2Mv+AEAuTPzCA099F8dwNNAIzEx13bUoDeu
2SYDnIQoiZYWRgY=
=+Sl0
-----END PGP SIGNATURE-----

--------------0Jc0pvLER03aff7eydhv80EE--


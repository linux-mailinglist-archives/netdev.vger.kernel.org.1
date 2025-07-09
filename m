Return-Path: <netdev+bounces-205205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F98AFDC7D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C126542B9D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40DB80BEC;
	Wed,  9 Jul 2025 00:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mf0cKEBk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F0502BE
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021811; cv=fail; b=ZoOZpzs2Zx4k6mJUFNwNuKWUuKJ4yvI0wsY9/v8Gbl5N0aEuQY+7f8Xf3MoFwXUFKx3szrjpfkDcXsVfqGRnDVQe+vmUFbEsaS5CUcCC/xo9OLVJHNEEMon7g4M7TT9Qjq3TdewKLKsQy7y8HhYJ66hbIR/lKZKLAZ/0GjOO3nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021811; c=relaxed/simple;
	bh=oT8/4WBjljeu0GkLjgfVwuIbh134/yerpJ9WElExt+o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OP4DnCEQt/ipFxsypTHZYqF4AJCmyX63Lx74eVicQUKvj/Hgvo3POPlw7H7bARTyS6NTtvHjkW1u781dp9p09nNS9Vcpmg14fwJbyOuAku3CQz8WyTVrsJpbogOssy+wr/fDIzyOPmy/+lE3yaxcFnmdvI3PYIycvyt61vkNpuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mf0cKEBk; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752021810; x=1783557810;
  h=message-id:date:subject:to:references:from:in-reply-to:
   mime-version;
  bh=oT8/4WBjljeu0GkLjgfVwuIbh134/yerpJ9WElExt+o=;
  b=Mf0cKEBkal32d4sZSnDHB2dLxhTXEUXaHTw08ahMmTTtTQOyZJ1XLEx9
   jgOS2q6Cg6GPi2u8mJXTFIMQhgmzoUZOxCAR6+SKyfpAruwxcGkcREJw9
   g0CgM61oQERvx7NuyyncZhUmaT/ORsyY55XcCwN7e+KB05qG02vcJt7NA
   7KrXRTHzP/Ifb2ztfkod1tIUdkv8lj2Ev8PNE/N+1yL+t8P5krdUNlW3C
   Vq0ppYe9wj/8zj/aZB8SWXGDp0OYNH1a5kbrrLAWF0SMB4wrTBODhUzWr
   F+uUO1N6xoIKyZ9TQgaC+AySkg/Ak0thMMrVZ0No9BJcuZFJBLO8+fB3T
   Q==;
X-CSE-ConnectionGUID: QJP54U+lQkC3rKghAHNReg==
X-CSE-MsgGUID: cjUJQbGDSgaEycvamRVVEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54416112"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="asc'?scan'208";a="54416112"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 17:43:29 -0700
X-CSE-ConnectionGUID: jdwaC1eVRiCQH7tWwdVz3A==
X-CSE-MsgGUID: fJfFB0ALTp++5D9Q9wjAAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="asc'?scan'208";a="186639239"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 17:43:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 17:43:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 17:43:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 17:43:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkadcOLLBX7DszZ374DbLv0efPrGMCrKI8phbKMaBI9zbbh3hj1O/NLEfboRd/HVuxqpaOXs2MwMnHSKu27DryzB9/obhIV5fruP6inwbQX09XzJUTL6mIGD83Ns3zRR+FTdwVUZ2qcB5Pkcck8HIrvdsy/0AvR1XoO6aCNR0OoqW8zNW8qmP31/ft/iAkrOJkFNkqZml/jNZX6ZiYZGS3xonoKVahoqjK9v7YQ9AKCBNsmjQN12bElKfFJoaBu7BNIFOZ/DkxjU/eHH0WDZA09fW2y6bl1m50CsxOgg1LGfmFIpm0zhELYv7+fm8FBmtqV5J/AFN0d6PwunMvvwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT8/4WBjljeu0GkLjgfVwuIbh134/yerpJ9WElExt+o=;
 b=cBuId7czfBHBVyhX8CVBmo8nMVDTjkig0V49vHyjV7hwt+B7NsCPh7I7IBox++q4cV8SwNROM5nV7Uq8pYk6KSvGy+H5Gbgddr7t1kJMeEohTy2zHvc40b3R1L5nyQky+7emN84F0CqSTL3W1mE9w1P7WkkXZBBE9brQoi1rvrCyHvCX+aDxSwdNmzY0dWBf0PV77V1xGYB6O6KduZ9tA6y81fVQ8rG9Kum7etTEnNZHoZ8PBu1kAnjf30WkCAKyRPnRA9YWNL+D29D9mh/xjHVZJTmXmxyaK8vrQKAKXZoOmF9mcbYsz1mZgYsAvbRDTCwVNM8A38Lvg3eS669nKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 00:42:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 00:42:39 +0000
Message-ID: <8407689d-8a6a-4a94-8aba-a8ca134838fc@intel.com>
Date: Tue, 8 Jul 2025 17:42:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Possible Memory tracking bug with Intel ICE driver and jumbo
 frames
To: Christoph Petrausch <christoph.petrausch@deepl.com>,
	<netdev@vger.kernel.org>
References: <06415c07-5f29-4e1d-99c3-29e76cc2f1ae@deepl.com>
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
In-Reply-To: <06415c07-5f29-4e1d-99c3-29e76cc2f1ae@deepl.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------LkgoV9O5HbVSHISpDoKhPk4T"
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 4109ae95-a579-45fc-7f3f-08ddbe8181da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVN3VzRXNUhIOS9nbTJHY25CWWJMS0JkMnZMM2JRMkgrb0tSbnVtaUZ4TUp3?=
 =?utf-8?B?cDJvdGNUM1U5L2lXYnExTW8xTXMvMmtPTUo3OFZzK2dCdkxpQ001WXYyUzdy?=
 =?utf-8?B?UFZ6MzZKUjV1bkZKblZSditIL2V0YzVwUlBPOHVDVnNTcko5NDNvbkNCRDQw?=
 =?utf-8?B?T1llNGw0QkJZR0dVWWdzcjVYR0VERHZNOWtyY1lzMWlML1BaTnJBUmkyT3JD?=
 =?utf-8?B?WmVlYjkrRjlKMENzaUxaZ0dXMTQ5R1c0QVZqeFBWQ0ltTU1lcXdQa1A1KzlE?=
 =?utf-8?B?WFRlMWhqNmpZUjNkRHg2M2tsZzZ6enhoK2xtL1hyWWJaMi9WTmsycmRCUVBF?=
 =?utf-8?B?WEtFb0p6V0NTSUtnTUFQRU9PTG1EYTdiV2hHdFUrTUZDQ0F2ZWhNNzM1cFRI?=
 =?utf-8?B?UzdSL3FJalUvTTlieTdKaEduUlRaUzFBempnQmk2Wmp3ZUVUd1FhMTV2Yktz?=
 =?utf-8?B?R2ZMbDl2NWIwKzhmUElRemVucmN6M2JFTjd3OGxlZnF1VjVDZDNabXdkMzFq?=
 =?utf-8?B?UkM2aFlPenFzSVkreklwYXk2WjkzeDdvMXFwREtJczBOd0xZRW9TcURKS2hN?=
 =?utf-8?B?b0tMK0NpN0pUc0JydXgzTERVRmZXZWxnREI1NXFmblpzTWxMWVlHakRxNG1v?=
 =?utf-8?B?VVBoTUFCNGVBMjZ3VVV2T2hNWGttem50YjlxMGMxWURRbktZTVh5aFFXQ2NT?=
 =?utf-8?B?UUxkZkcrUThPK0RUZ1YxYmdwRnprV3l4cU1pVXRvRW44OGZ2MFNLYTY4aEYz?=
 =?utf-8?B?TmpqT3hLWTR4NkZEeHMwak05UDNPbXB5UnB6eHpNNjBDSEp0NEFCdHA2YTFC?=
 =?utf-8?B?dHdhK3hBa01BMTd3RDMxdmRaeXBwTHhYOU00WTQwbnhZY2xmOUt2NEJQWWpM?=
 =?utf-8?B?RVJqOUR1ZEoxK3F2SmR2TmozaDVkd2pldVhCQVh3MUozclVSVk9VUVpNeW9D?=
 =?utf-8?B?Rm01UDNqSTk0bDdZTmU2V21jRkZINjN0OW1qRU1JRUZsbXBBRWoyZGcvcE4y?=
 =?utf-8?B?RDRaUTNIQytlRmorbXcxMGZ4Ui9KWHF5T3RPcFhYLzFHdEVNelhpWWJtWVgw?=
 =?utf-8?B?NzBwR0dIZnBYdUVCWkpPay9XbCtjTlZSN05ubVZoK0t0TFNxTzVmRjU3Mmx3?=
 =?utf-8?B?SnRrVlhSNlIyRzcvelBxQ0k3Ly94MllpRnc2R295MlR4c2poNVJYRjc1dzl1?=
 =?utf-8?B?dTJqR2x5bWpJLzNxV2xaQWJqTExDM3lROW9FcGVqdVpsTHRpcU5PT3dEalBE?=
 =?utf-8?B?dmx6YTRCVXE2d3pMbXM4MmxVbERIKzJSSGU4UndDMFNxN3R3dkg0c3FWT1Br?=
 =?utf-8?B?UmFaV1N5RURIQUppVzh3V0g5N0szVW9ZU0lDZ0dHSEhOZ0lTMndmL0cxcW5v?=
 =?utf-8?B?bDBFUHA0WTE4TVNSZStiS05vVzdDQ1hjV0NZM0FwMk9scWFhRnl6TGwxRTIx?=
 =?utf-8?B?ODBoenllOEY1cmhNM08yQjlhdUl3eldrMDBzUjZjUk9vUVNmTlR1Vkt3RE9B?=
 =?utf-8?B?bDNua29oNk81SmJFenhJYXB5VjN4YTVxYWxRbE84TTBUSVprRnJVYWVjZEM5?=
 =?utf-8?B?MjlCSUxIREtYRXFDSytJdXg2a2pVMkRjUWNac1AxajhHeHdRUVlDSDZoRFpu?=
 =?utf-8?B?S2Q1UzFEYmtpbGZ1OUVVbUhYZW1lWjdUVmcycU5tcStia1Ura1ZTSzk4WkRn?=
 =?utf-8?B?YUtFbU04a0VDOFYxdnQwcDRNS21QUmFUb3RjTzNwQWdoZzZjSFd5VFN1M2hP?=
 =?utf-8?B?WGpiRG1kaGRub2FObHJVVjRNRzZRR1R4R2VpZUJuSzFFTnNTQXBsSGpBcmFp?=
 =?utf-8?B?a09SL0hEdS9sQmtZR0MxSmdhSDZPTm5wME1wRXRUMlloVmp6L0pMSEc1amJp?=
 =?utf-8?B?SDVqai9OTlArWEhBRVM3aUV4cHlsbC9DY2RpMEE5M1hxODhBZ2d0eWN5SWMz?=
 =?utf-8?Q?NnY6aMrJCCs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjFINGZuNlg3cG9NUG9qOERvYXRkOXVEZ002T0E2UE9MWmVRUkZZUVI5VnVX?=
 =?utf-8?B?cTdZalhrNDdWdjM5bEhwMUpXSXovTERYZGNWVVovdUNLalZMNlMvOFB3TTBu?=
 =?utf-8?B?Umk1eDZjNndjT1BYMUcyZ3RKL2ZVTTdMY1V1aWx0UUh3WkYvNmJoQWRDNWZw?=
 =?utf-8?B?YnVTREoxbzZxdGVqTFdUUWV1VlNMdU9ad1JvL3d1QnZ2UXhIQXR3aUF1RG1t?=
 =?utf-8?B?cWxZTlpEY0xPSXVHSGpNaFRURFpSQnNmWUFaTDRhT083bEVLanplOUlYRk1L?=
 =?utf-8?B?Q1NHWEJxTWFCWXRYTE5yRW8vaXpVV2dlZmxobko1QlVKMk9Kd0VDV0gzaGlM?=
 =?utf-8?B?MFkzMnRYVnhUV3M0RXNvRDJaK3BKVDFqK0dkZTV2bGh6eko1K2c4bzVjTU11?=
 =?utf-8?B?cmF6Y1BNZy9DRklWaGN0S0tsNUoxVzUvK0Jja2t4RHg1ZDczVEw5YTVjSzdl?=
 =?utf-8?B?cGFLNFAra0dNWTBsK0cvT2xEN2Y0bUJmMnlCOFNTdTFXVklheXlVaVZ3UmZW?=
 =?utf-8?B?dGdPbXIxSktLSGhDTEpmOHBxSXBGU3pXVlRLRGtqaUU5ak5BVk5YMkh3Qjhj?=
 =?utf-8?B?a0d3b016VFdyazduZm5FN2dkSG9BdVhKYnUvTnpWcFdYQUI0Z25TbXBCcFRp?=
 =?utf-8?B?QjI1U2Q2RFZ6V0F4NTF2UkxVWHRyZW95NHJNY0tQQ2h0Qll4MkxnZ0p0WkJn?=
 =?utf-8?B?MnZPL0t5NDlRYnN1SG4zSUkwWGpvYWxnTU9XS0w5dVdaa1NEcGhSUTdNV3RI?=
 =?utf-8?B?NGRxeW5hYzBraTBRSm5LYzBnT2NvekdTTEVlYVVnZXFDT1lERC9MdkhpTk1J?=
 =?utf-8?B?Q05FcU1OcC8yWm1adWlHV1hTa1IzY0tHU0NPRFJWWTU5ajNseE5mbmNQR1Vz?=
 =?utf-8?B?cEx2SzRwQWw1K3JGaUdIUTRRMEVsWmlQaWZFaU5MVjVTWXdyT2hEY3FxeW1S?=
 =?utf-8?B?UWd6ayt0UGNZOW1yTlI3cTBhWUZHT1pVMHNSWXJyQ2FsT0JiNUhpZXRlOTVo?=
 =?utf-8?B?bnM1aFl0Rnp3bnpGS0VyL0JlMm00emcwaTMrRHZhTnRTbnRyRUQvMzlsWUdK?=
 =?utf-8?B?cEZMUWRVTzJrV3V6V1NZaDBNSmphMGRCMVN6cG9uUUZLc0ljME02RFBoUlVB?=
 =?utf-8?B?NXRKa3B0RE4veDN6WTZkbXJLb1BTQW5YbWdjeGY0NjIvUmNXc0ZYVUoxbm1m?=
 =?utf-8?B?QzZRYUUvNmdiSmlBQ2VmZWIvcWgzT3BlT0lUL2hoTnBpaThxQS94VmVTaDFi?=
 =?utf-8?B?dHpITW9wbktFd1pFaWQxQ213K1V2Qm4zYU1kblBVRkw2cHhxdjhBd05qdTVl?=
 =?utf-8?B?ZGc3aWk2dmZXdEdITWNMWE81NkxIMlVxV3ErdkZOSkRwbE1uN2IwZ0MwODhl?=
 =?utf-8?B?aGRWdUdiQjNtZVFwSWlMbGk3UFo1UGk5NDJ0c1lFZlVnLzJ0bGczd0xZbGYx?=
 =?utf-8?B?MjcwRGwvL21DWjlodmdBRnBTOVFmOFp0aHd5SXE5ZklORkUzV3VZWVBqaHFz?=
 =?utf-8?B?cVZjaW1FK1MvRWc1eGpPRHd4eVZzYzY0bzB5R1lCYTYvaDNqenNZajZZOGVQ?=
 =?utf-8?B?Tm0xOHBWWlZTZis4NDVDNUQ1QkJUUEZRSDJhdWxPeVpXdFN6NGovTWdNbVgx?=
 =?utf-8?B?Y21GeG9WRFdZNDY2S3RWdEgreVpJenh4SzJrM0ZYT3dqZkVsZzRUQmxZMnQ3?=
 =?utf-8?B?dzZSb1V3ZllrdisyeUN6OC9ueWUweVVKSE9xRTYzdytnMEtxU2c5N2ltdzVQ?=
 =?utf-8?B?ZFNYRDdxTXNTWXp4NXpRSk9rS08wT2FRS1lWZjBwSWYzdHlQaFhVN1dqNU04?=
 =?utf-8?B?ZEFmM3VMdFVsbVZ0TWc2RzBVZ0ZJdnVhbm1PL0lWZzZzQ0c1b3RnRUcyQ3o4?=
 =?utf-8?B?c3pBamRWSXlHcFUrUjdxd3ZKbFc5Zytwc1c5MWl5QzF6OVVCeTl1MU1adkg3?=
 =?utf-8?B?dWx0S0Y3V3dPUGFMZDNuNmd0VUdSYlBuQXV0WGxjamtvaGVPNjNyYVVqc1Ft?=
 =?utf-8?B?ZkRFdG80Q2J5cUdDU253eUdraWNuSlczNXBXN3cxWVhaMGF0U2NCWDhEeXVz?=
 =?utf-8?B?akVrcXRTT2d0VlhIYTJKMUlOcEROYTR6VkkxaGk4TUVSOGVHTWdaVm5TcW8v?=
 =?utf-8?B?eThlWk4xVk5wOGxlMDJuajk1OTkyTmtSakRrSHpjSjNrQ2t2a1craHZVd2Qz?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4109ae95-a579-45fc-7f3f-08ddbe8181da
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 00:42:39.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+lcqpTR0dc/1C2/9sl84cYYJ8Cq+EB/zuvqKKMLz/2r6DcIfvH/F+ESZZNIJhfZ4M1XW1Z3V3zEQ4YnyKX/AJjsJI7Rt5rTu2z3tVfCtoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

--------------LkgoV9O5HbVSHISpDoKhPk4T
Content-Type: multipart/mixed; boundary="------------o0PYj4EKgaB6zi9wEA3DRwMz";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Christoph Petrausch <christoph.petrausch@deepl.com>,
 netdev@vger.kernel.org
Message-ID: <8407689d-8a6a-4a94-8aba-a8ca134838fc@intel.com>
Subject: Re: Possible Memory tracking bug with Intel ICE driver and jumbo
 frames
References: <06415c07-5f29-4e1d-99c3-29e76cc2f1ae@deepl.com>
In-Reply-To: <06415c07-5f29-4e1d-99c3-29e76cc2f1ae@deepl.com>

--------------o0PYj4EKgaB6zi9wEA3DRwMz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 4/30/2025 1:59 AM, Christoph Petrausch wrote:
> **
>=20
> *Hello everyone,*
>=20
> *
>=20
> We have noticed that when a node is under memory pressure and receiving=
=20
> a lot of traffic, the PFMemallocDrop counter increases. This is to be=20
> expected as the kernel tries to protect important services with the=20
> pfmemalloc mechanism. However, once the memory pressure is gone and we =

> have many gigabytes of free memory again, we still see the=20
> PFMemallocDrop counter increasing. We also see incoming jumbo frames=20
> from new TCP connections being dropped, existing TCP connections seem t=
o=20
> be unaffected. Packets with a packet size below 1500 are received=20
> without any problems. If we reduce the interface's MTU to 1500 or below=
,=20
> we can't reproduce the problem. Also, if a node is in a broken state,=20
> setting the MTU to 1500 will fix the node. We can even increase the MTU=
=20
> back to 9086 and don't see any dropped packets. We have observed this=20
> behaviour with both the in kernel ICE driver and the third party Intel =

> driver [1].
>=20
>=20
> We can't reproduce the problem on kernel 5.15, but have seen it on=20
> v5.17,v5,18 and v6.1, v6.2, v6.6.85, v6.8 and=20
> v6.15-rc4-42-gb6ea1680d0ac. I'm in the process of git bisecting to find=
=20
> the commit that introduced this broken behaviour.
>=20
> On kernel 5.15, jumbo frames are received normally after the memory=20
> pressure is gone.
>=20

Sorry for the late reply. I might have a possible change that may impact
this as we found a memory leak in the way we handle multi-buffer frames
at 9K MTU

It may not be a complete fix, and I haven't yet reproduced your setup
with PFMemallocDrop, but I thought you might be interested in this
thread, and the resulting fix which I'll be posting soon. I will CC you
in the thread when I post it.

[1]:
https://lore.kernel.org/netdev/CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYo=
E44caRbgw@mail.gmail.com/

>=20
>=20
> To reproduce, we currently use 2 servers (server-rx, server-tx)with an =

> Intel E810-XXV NIC. To generate network traffic, we run 2 iperf3=20
> processes with 100 threads each on the load generating server server-tx=
=20
> iperf3 -c server-rx -P 100 -t 3000 -p 5201iperf3 -c server-rx -P 100 -t=
=20
> 3000 -p 5202On the receiving server server-rx, we setup two iperf3=20
> servers:iperf3 -s -p 5201iperf3 -s -p 5202
>=20
> To generate memory pressure, we start stress-ng on the=20
> server-rx:stress-ng --vm 1000 --vm-bytes $(free -g -L | awk '{ print $8=
=20
> }')G --vm-keep --timeout 1200sThis consumes all the currently free=20
> memory. As soon as the PFMemallocDrop counter increases, we stop=20
> stress-ng. Now we see plenty of free memory again, but the counter is=20
> still increasing and we have seen problems with new TCP sessions, as=20
> soon as their packet size is above 1500 bytes.[1]=20
> https://github.com/intel/ethernet-linux-ice Best regards, Christoph=20
> Petrausch*
>=20
>=20


--------------o0PYj4EKgaB6zi9wEA3DRwMz--

--------------LkgoV9O5HbVSHISpDoKhPk4T
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaG26/AUDAAAAAAAKCRBqll0+bw8o6GzF
AP0duzkAG2GJfrF+4bATptb2uBM5w8bsdJeobiBq2YoqJgD/bvmb9vsvWRsA5utWGkUtWMKwX7GH
wOzQJuVZiQTCqAU=
=3Tz5
-----END PGP SIGNATURE-----

--------------LkgoV9O5HbVSHISpDoKhPk4T--


Return-Path: <netdev+bounces-243470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0B6CA1CF7
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 23:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C594830084F9
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 22:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26984284B25;
	Wed,  3 Dec 2025 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUEqNiZh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65B2135CE
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800593; cv=fail; b=i+DMbNb71+9MaoneLrV++GN735Pe9qRNlXZuJWlPjjjt4hdbKdHKhTnpyJLtwcBZ2oncxu+E+sTApo28iruNRD+lEDcouIcpROy1i0a9Mjtz+OZsdCsRuFLjPct6e1wc3wsETromAhwrFF8SHVMA8jAMg44jb4wIs0Wmm4MzJx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800593; c=relaxed/simple;
	bh=PkKLHdQQJo56WqLMR97nQ3FEXTD1Fi1l6dEp3DZatdg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c0wIFM6JV4IFCJ9WOYstCmphAicazmOtTG3LG81ApXpKu8ythyPZXjd20NepboJcAR1L/5aC+yflLDkr1zhWmqXIyyfyc/6ZE9EA+SvubShtkjOwXP7ydqPE1o5zSqXbXIoP5WJeUsHzZejMbmXqvWERy98xmofhztXEQbroeIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUEqNiZh; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764800592; x=1796336592;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=PkKLHdQQJo56WqLMR97nQ3FEXTD1Fi1l6dEp3DZatdg=;
  b=FUEqNiZh/iKqNPGdMQKL+h/7VfOwiMV3WFBmzn8QMrZXi6Z64CghgKXU
   pID00QKxpUwwrhglKbHGBUXON5KJ7godkaU5c6xZIpmRsFn9TA1cHcQ3m
   tZBMoAhyhbpFC7anUYp2SRE3ZlBYl/OAClhPvGi6kFeenrM+JiY6hAvBv
   GvxMedCXS5YZ6TYdYJWVMYmXwx9sMMjEAs2evfg9KnaYk5h1QUoOZMLKr
   m+xcMYx4lPYQ96glfGzfLyFNnot/qYsXcakDonnSjwJydOPuiofMHJ8Fs
   z5RfDZ8jc0tQKdhjg6VU4PNWoaGMGs7gCOFGAFDueCSSv5uLS1ii1sFpj
   Q==;
X-CSE-ConnectionGUID: jFRe/zAjQeWkBeuTL21dUg==
X-CSE-MsgGUID: zY+3jrt1S9iLdJ7kdQ72wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="89461554"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="89461554"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 14:23:11 -0800
X-CSE-ConnectionGUID: gE/dO97ITzuYouRea6FpCw==
X-CSE-MsgGUID: z6IWji1eQWq+itUUzPhQhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="194904814"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 14:23:11 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 14:23:10 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 14:23:10 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 14:23:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFnwUGpbdoji3+6eJ/snGqAsxRwH2d2NLKVraHva9HFSWteJZOtlkI378798BZA4B10H8+sH0C/8hwony9NJxz/A61AdAQ8mKGcMu2K7+LfrvnZyMjAVMGGCigdKGbpMb8FRYgmsuyWiUT91kfPkwivlriA/HMPA/vn24FQ62tAMP4uHRbI30UO33OHzlWVxYerez+ATsD3Xo8+FZLGumhram4d5kTqzTIaUHTzwjuHkhHM7UpJ6Rv3Tts1EVooW0Gi55zl0HUCraSjUQfCw0IOqB83vGbCF1KLfdgNDLUzoc5IqseShmRkHVY0Tid2h8HWppZztuk5W7QgI5Vq1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avcHFGQdhGIfb44zlbjY/hPQ99nXhOA1+VMurTmcg9Q=;
 b=Z54tpII+6miRfAsee1pdsP854HvhXFO2tpNSk9v3to1NyPyovZScZR2FpSkUoMEHoPdhucQKHTCczzAr+HpNTE7FIScfYi/XumvGeYta/yg5+IsP3/Jy2c1mxNRocCgBR1689O6HnrkEcB6VOtw2S+67tib6X0dlc2JBtXvhkxyoDSD+NnqW44DF8Gw1Hph8Ty/quUvU7wTgBQ4HvPxHM5sfLz4qc0UT0lxGnZlL86l0VHY273KxjFqHDTvICaqJTFBUJ6/MZTBFEYHQiu2jJDhXSjg4/OyHpWKracH7MFhMHCcZ7nQnXSMxQeQNuC7vA/kOWNZPIldPxQbJ3Z0ljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5104.namprd11.prod.outlook.com (2603:10b6:a03:2db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 22:23:08 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 22:23:08 +0000
Message-ID: <16579efc-97b0-4a0a-b70c-7362904ddfee@intel.com>
Date: Wed, 3 Dec 2025 14:23:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 1/6] ice: initialize ring_stats->syncp
To: Simon Horman <horms@kernel.org>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-1-6e8b0cea75cc@intel.com>
 <aSWB3gsh4KpDZae9@horms.kernel.org>
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
In-Reply-To: <aSWB3gsh4KpDZae9@horms.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------CyjOFiHBYRsmWLNJC60nQeVN"
X-ClientProxiedBy: MW4PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:303:6a::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7a75d2-9a66-4a33-322f-08de32ba894d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG8yUEpHUkRqWjIvcVZidTBMQVdPUWJUakZaRldRdzBlNWZxeGFuT05UTXdO?=
 =?utf-8?B?NnFqalIrNVlWVmtYRDBHYlVURVgwNWdxdUJNMXhWR21JOUttRzl5YVMxR0hq?=
 =?utf-8?B?QnU5NDMwTW03SzM4cXMwQmkzWEZTSWdNL2oyWWFxNkRjVitqcVFLK3EreDgz?=
 =?utf-8?B?QVp0TXVEbWdCaTBaQXNOODdjS2pNVUdYR2krQy83eDJxT0NObE1rTnRGZ3pj?=
 =?utf-8?B?UUk3ZHAzaHZFeGh4b0pnMDVQMExLN2RlSWttOHViZU1UWnJod2ZWWXNFQ1ps?=
 =?utf-8?B?aHNNR3U3cFkxWGN6cGtMWnpRR3k3bXlCRmU0ZmIwTkxxMEowRFhvNnc3Z3dQ?=
 =?utf-8?B?L1dqUVdtd1h5bmgvRkNwWkh2RDNlUFcxcmdYUVpUaGxhek1RU1ZZUkVHUGdq?=
 =?utf-8?B?NjF2d2MvSk9CeEt0dERNeFY4L0FRME9ZYkVBVnpXdkpXeG1JUnZ3aHBldzlx?=
 =?utf-8?B?SzNCMUR2S3dDZEtreXZYN1pWbnJ0T2pzRVl5TWxvK2MrS21QVGlPaGxRdGhY?=
 =?utf-8?B?VmxuSWpwT0NMK0JBQkd3YTBXSU9tWGhsSjlJSVd4d2p0bk4relRTTFdNTmRU?=
 =?utf-8?B?blpDQldtU1E0SjFiR0tYaHZXMDFxRmFoYVdITjQxMHhOSmZzcEJtM210Vi80?=
 =?utf-8?B?aVVZNDNZWWc4K3FPcjl1TFlvYWR3ajNIRzRtRkhiNWF3cVZ2VVpyNlRFcUZz?=
 =?utf-8?B?RytzTjRWUFRDL3JpN01NMEx4WmpTMVJKelg5b0dnYnFBUkFmc0NQQ1ZXQk9Q?=
 =?utf-8?B?SHBwbjZLOUtWTzZrOUxUa2dmekcyeW9HNlZiS3U0a1R1WVV4MXdFaGk3UWla?=
 =?utf-8?B?TjFGUXFsenllcXdwQ1FKWGU1VkJWcTQ5c3FoejFGeG5IOHlwN3Jla3pDV1U2?=
 =?utf-8?B?R3BrY29tZnRSdzNUZ2FRUjVzUVkxQzQvRk1yMFB3Sy84akZZc1lERUhmOWgx?=
 =?utf-8?B?aXF0eW50S1BzanZKZzcxNDd1OSs3ZXdWNXkrS1E4cDZUbDYrTHpKRWcwYVBt?=
 =?utf-8?B?QWJ1a2RhcG1rMnJVTnoyRmdRYUVtcnBsZi8xTVRMdGJrOFlJdys2eGdUM1F3?=
 =?utf-8?B?S1l4VTMyeE1QNFdzSEg5cmd1dW11V3V4cE5vRFlNSW9NOVUzSnhtamx1V1Qw?=
 =?utf-8?B?NFZGK1ZQZWxzTHlXMnJmbnFObGxmQ3NWbkNTRVdRM3lhbWVGNnpLakNTTE4x?=
 =?utf-8?B?OVhqMDk5Z0h2MTFjOHRFTWhOdzJzNjBZM2RLMDVUc2V0OXlnd05pVUdidGM3?=
 =?utf-8?B?RlNpRkNZbDg4aDhXMElhbm81ZzBickptUlNFZHRVM2h3NGVsSUNKZGNWby9C?=
 =?utf-8?B?N0I0eGo2K3RLbmdJdkR3cGtEejVMTldlZTVMMGg5SEtya2puZFozc2pHZGVT?=
 =?utf-8?B?YnlnYXNOZW54bXJoVjlaQkI3bWkyNWV1b2QxNk1XM2phT2V3VmtPNE5NeUF2?=
 =?utf-8?B?NUpQUEhlcmhuLzkxbUN0NUZyNTlad3krNmRWUnZGaVRiZWw1RkcxZWwzTXNj?=
 =?utf-8?B?dWtLUzYyT2luZjYzbDBZTnQ4RndWL0xqZmdLU2tuTzhJRWVTUEZEYzhGR1hM?=
 =?utf-8?B?TDBkNnZoRU5JcldqM0srR2dobnVpQzI0SUlNK1lDRE1IU2RENGdLNzhQTVlS?=
 =?utf-8?B?U3A5SHV5UmFQcXhCdE9VYXJiY21SZk53NDUvNlZBdzkwcGpKd3FmN2RIdTZQ?=
 =?utf-8?B?SnNSVEh0NXpOMUhUU1UwMGNsaEVpc2tKczROR1pkZ2ZIbkpJSGk4RDJZTDh0?=
 =?utf-8?B?VDB4YU9SQ2J4b1FXVW12RUtpZy9pMjNpTjR5TCtUekVUWjJBb3VJV3pETDBa?=
 =?utf-8?B?MDZscUs4cWFGTkZPU3p5MzZ6UnNWbzNhdnNMUzhXQm5xT25WR1JRTGNlKytu?=
 =?utf-8?B?Mk1OTWs5V2txc3piWjVDMTB1eHRsSnRKZHFtb01hcFdqVmhyUzRhbndDS3pu?=
 =?utf-8?Q?NeZbnbwxrw2Rhhghrz9m7obomR9UcDav?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE9FaFlrTlZuZVE0RjZhNnBPakFtWDFSNktPUUlaS095SHpsaE1HdFh5UGJB?=
 =?utf-8?B?czBFTWNrdUtaTzNIMW9SUmhGSDgrcENqZ3dqM3JWc1VDVHhKenl2c0M1UkFo?=
 =?utf-8?B?ajdlWW16VklCLzJURGlTVnlsSHVwSURwbkIxUGVYT2x2ZjJ0cm1qdG4xNkxl?=
 =?utf-8?B?cDZyM3VLYXV2WGtDUnVpbFJUZHNVUmc4Y01ZTk5GM2ZDbnpHK1IzMzRIVzVL?=
 =?utf-8?B?WWxlSE1wN2ZRM3RrdWR0QVpGWHdZOFlEWTBSaDZyZ1k1M3p3RkgxdThXNVFE?=
 =?utf-8?B?TlVxcGFEd1habWk2bVZla3RsMmZudGlBTG5hK2I0a01ZbzlxcnNZbC9KYkdF?=
 =?utf-8?B?M3pER29aQThFZ2VBZWN1RUF4MXZXeEhWdDJ4UU1qRm5vZUw5UDVmRFBSY0ll?=
 =?utf-8?B?RnBha3ZnZVZFSzlZRXMyUktMdkx5SFlqa21BM2tiR2FjM1RiOFBRalFYdWpK?=
 =?utf-8?B?YVdCQmwxR2JFT3grVjRPV2FvdllnYUQ1Yy9jUG0vTUFuRnZFc0tLeFBkWVlM?=
 =?utf-8?B?cjNxayt5Z05BcURwRHN4eXg1Z0xSdWhGbUI5VEpJRDVjRnI2NHE4Ky9xU1Av?=
 =?utf-8?B?WVU1THl4NGZRbXIvRlNPenZGY0FZVU5kc0oxNnVHanI2REEyaVU1V0tJQUl1?=
 =?utf-8?B?emh4OXYwSVFzMXg2elh3YlZURnBad1lwMUhuUlNDbWJjdldVeGtIckM1NmNR?=
 =?utf-8?B?c1JsNXZQcmptYVdzYkg4ejJ2dlRFNmJ6UGJua0w2RTl1aC9FaktwVzJjZlpY?=
 =?utf-8?B?OVpMMlhWZldvcno1dlc2RDl3QlJjaHhPbjRCVFVIU3J5aWNyejk2YlN3OUFu?=
 =?utf-8?B?a2FBamdHa2RrS2RQOVJIUGpxYXZZVTFTRXlUdExxaHNvMERwZ2I3eTlmV2Zx?=
 =?utf-8?B?V05CSnFYYTF3TlY0clg3dTV4V3A0Yk1xdVRMblViVUpGSlFPV2xVQ2ZvNkVS?=
 =?utf-8?B?T09WVkE4blV6ZVpQbU5hRHNiNVpWdWFSS3o0VnlJeWhBRHhJUXVUdWtDNmND?=
 =?utf-8?B?M1JpUHk4SWpFc2ovTGhoNmxsTWszNVZLc2ZiQUdFYTI1NTFON3o1MnB5TURq?=
 =?utf-8?B?NWREZUtyVGFjanp6bzBkUXhTQjZvU1pGNnRJSk5NZmJkcm1ORlBsai9DdWZm?=
 =?utf-8?B?azlDWVYzSXFuVjVCNTd0T1NybW50RE56QVIzUDJWbGtXM2F1TDBLSUtZeGo3?=
 =?utf-8?B?aG9BNHR1OGJDSWhXL0FFZiszWWtDcnMwSTNURUljUFhBbTBFTkJ2YjNHTytP?=
 =?utf-8?B?YTNRTTFFVVh0YlUxNnFRVndkV0FSazBIMUlIbUdjTERSVU1CbXEyWEprWlVQ?=
 =?utf-8?B?WFo1LzFKMHlaUEpNeElsZThlQTJraW9jVWNLeVEyVWJUQ2tzSzZsUnMvOXZ2?=
 =?utf-8?B?b3o5Wm5GSTNKd1BOSkQ1Q3QzQ1phZVRzT2REU0xQUU5MbXA3RlhzNnVxZmhu?=
 =?utf-8?B?ZC9vV1NXYjRrS3NRZmU2YU9TOS9kWnRYK2J2TStoY2FmOGRFaEpGeFUwQW15?=
 =?utf-8?B?d29RTUdreUJyaXRJQk1SeHFMMWcyRlhnSlovUzdjakphbzJYVHVmZUU4djhx?=
 =?utf-8?B?VzlWbGV4em42NkQ3MFVZclJLVzh0SDAxM1lUMEJRZXcvZisvbElYeXk1ZFJt?=
 =?utf-8?B?eHZtMVgzMjIxT3VrdkZFbjN0MWovUlRXZHdmNHFwNlJIZ040NThjb1dUZmFZ?=
 =?utf-8?B?NUkzbGc3UlVUWEMxOElrM2NVeU4wWnZ3amhqSFdHamVkbU5ueWFDaU9SK3Vp?=
 =?utf-8?B?QUhPS1g2VWlsNmp4TE1RSTEycnAvTjlzeGF3UmpvOU85eFZhYWJPZFZtVjUw?=
 =?utf-8?B?cUZjU3FySVBIY3lNb1BGRnUvSGcrWGZkaThaY2ZXZEpHY2xFK2FobFBxQ0Vm?=
 =?utf-8?B?a0ZsbGlRSW9pdTd0MDdWdHJIM3ZPMDZxMXBSR2dlTklQMHljVFFYRlJxOEph?=
 =?utf-8?B?UTZmWXJpbkVSMmhnd0RaMkY1VnF3YXc1N2p0M25ueVRIN1RGOTBoUFNzOFlu?=
 =?utf-8?B?T0JIY1RCMnNrV2Z6SXBSQ0t0VzA3cmE2T1dRbmtJNVQ4amV2WHVDK2ZMRXI2?=
 =?utf-8?B?bFJEdzVtZG1HTmR3YWJnR2orUUVsMmpiLzR4SlllUlpCSlpCRUxzcU5wb29S?=
 =?utf-8?B?OXluS0hkZTZ4UU5ZcnJiMnB2TS9qVXVsUVNvaUYxT3l1ZEZqODk0UkdXSXZH?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7a75d2-9a66-4a33-322f-08de32ba894d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 22:23:08.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbbMICo1LtJ2LjCrDzLZdljfQyK4nlBvwj/GHuj4hR57nwcEkGMtOtEI8dYYfJrsOLxCzCwNdwYRYl+UT0JH9E0wopDHBqPf7k8N7uVe4to=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5104
X-OriginatorOrg: intel.com

--------------CyjOFiHBYRsmWLNJC60nQeVN
Content-Type: multipart/mixed; boundary="------------502fddB62yPwCPT8VftMjPIG";
 protected-headers="v1"
Message-ID: <16579efc-97b0-4a0a-b70c-7362904ddfee@intel.com>
Date: Wed, 3 Dec 2025 14:23:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 1/6] ice: initialize ring_stats->syncp
To: Simon Horman <horms@kernel.org>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-1-6e8b0cea75cc@intel.com>
 <aSWB3gsh4KpDZae9@horms.kernel.org>
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
In-Reply-To: <aSWB3gsh4KpDZae9@horms.kernel.org>

--------------502fddB62yPwCPT8VftMjPIG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/25/2025 2:15 AM, Simon Horman wrote:
> On Thu, Nov 20, 2025 at 12:20:41PM -0800, Jacob Keller wrote:
>> The u64_stats_sync structure is empty on 64-bit systems. However, on 3=
2-bit
>> systems it contains a seqcount_t which needs to be initialized. While =
the
>> memory is zero-initialized, a lack of u64_stats_init means that lockde=
p
>> won't get initialized properly. Fix this by adding u64_stats_init() ca=
lls
>> to the rings just after allocation.
>>
>> Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
>=20
> I think that either this patch should be routed via net.  Or the Fixes =
tag
> should be removed, and optionally something about commit 2b245cb29421
> ("ice: Implement transmit and NAPI support") included in the commit mes=
sage
> above the tags.
>=20
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_lib.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/et=
hernet/intel/ice/ice_lib.c
>> index 44f3c2bab308..116a4f4ef91d 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>> @@ -400,7 +400,10 @@ static int ice_vsi_alloc_ring_stats(struct ice_vs=
i *vsi)
>>  			if (!ring_stats)
>>  				goto err_out;
>> =20
>> +			u64_stats_init(&ring_stats->syncp);
>> +
>>  			WRITE_ONCE(tx_ring_stats[i], ring_stats);
>> +
>=20
> nit: perhaps adding this blank line is unintentional.
>=20

Indeed it was. I believe its a result of the rebasing I did to split the
changes into separate patches, and this mistake slipped through.

>>  		}
>> =20
>>  		ring->ring_stats =3D ring_stats;
>> @@ -419,6 +422,8 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi=
 *vsi)
>>  			if (!ring_stats)
>>  				goto err_out;
>> =20
>> +			u64_stats_init(&ring_stats->syncp);
>> +
>>  			WRITE_ONCE(rx_ring_stats[i], ring_stats);
>>  		}
>=20
> The above comments not withstanding, this looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20

Tony is going to help work with me to separate this lone patch from the
series and prepare it for submission through net separate from the rest
of the series. Unless there's other review that requires it, I likely
won't post a v5 to Intel Wired LAN, but wanted to confirm that we'll
submit this fix through net.

Thanks,
Jake

--------------502fddB62yPwCPT8VftMjPIG--

--------------CyjOFiHBYRsmWLNJC60nQeVN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaTC4SwUDAAAAAAAKCRBqll0+bw8o6Mpm
AP40GFA/G+GP0gZyMnYsJCfOSCsD5j0nqfc16WfJ64xq1wD/S3W1jC/2KMQfwi28yXyw7SdKNbae
LA7lmhqoTMeuigA=
=lEHf
-----END PGP SIGNATURE-----

--------------CyjOFiHBYRsmWLNJC60nQeVN--


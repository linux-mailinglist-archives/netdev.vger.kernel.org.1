Return-Path: <netdev+bounces-243469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 456F2CA1CE8
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 23:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B255530028A8
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 22:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1192DD5E2;
	Wed,  3 Dec 2025 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgcphGNB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8BB2D7D47
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800473; cv=fail; b=HTET8GcKhmHjfL1vYulDYZxRP2b+89P5JTLINweDkcU07e6Lf70SHTHwcPbak8nfwtsHLx02l8RQibDTjK8uJdV/LgK3Rw7RN4VVQSUOE+0G9JErx72sajmDiX4Jlqt3f1xg+Du90WExs1foY25Q5e1Or0ZHPdwW2I1oXQcbRZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800473; c=relaxed/simple;
	bh=4UXMHmuEc3l8UANVVRsCnmQZbaamEKc7Vz0K1W+Wh0U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MIkzE5EJLVUQghQPPMRnCEsHCam5/iIgJd0sHturzutQtlzXVoNZWW93w1cYaokZgObPg3RGX+vdnUdckI0ptDA6EiT7ri9Yft7w/lhTdj0q/eEv+w+BS8NBZ4mdHIqSJac2/Y+n4EZjzyJfbBEsnFjSGqCupzwHpan/mvIzjSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgcphGNB; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764800471; x=1796336471;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=4UXMHmuEc3l8UANVVRsCnmQZbaamEKc7Vz0K1W+Wh0U=;
  b=cgcphGNBNYMzZo0chuC7ZG+1UlHoCfpnGaVqfGy1K7ZyNr7PyuARJ6OJ
   YUA+Rnzb8D84qQ/3W9kEfATszjzhNXJmtbadX3ZVhDzEqj4Usy0GKUtZE
   cpEQRnTuATtZ+7YB3Y135fRdGE1wTpX1NdbGXQ+PClHE4MIRw15UOesHP
   Jru8EvsPO66L/GGUeUy8ps6n3TqkJ5QxYMzQZ8I4VTe2bYPFbi3ttS9IY
   KD4LxGhRNNq2kcTFspLitDWHWqzb9yyV0wj/swi8VMWzLRD2IF/+Nxxwv
   miPw6AVTa1T9oh7kO7iLHBUVy9uYOGHkb8GAoVfR8stvYVF1FtpjUWrgh
   g==;
X-CSE-ConnectionGUID: +7JaudatScKuapSrCSPW6g==
X-CSE-MsgGUID: z+NHW3tjQPO5fQyRj6830Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="92288472"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="92288472"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 14:21:11 -0800
X-CSE-ConnectionGUID: Dn9jYty/SwiGUvyXKULJAA==
X-CSE-MsgGUID: mGuvQPrdSgCey6yFp4PUxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="194723202"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 14:21:11 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 14:21:10 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 14:21:10 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 14:21:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITZnH/KbiVatn7MA4P1RFDIeGt9M+nO4UO3spnCH9lCOSEcIzhfNU/m/Mmy75f7ec5NZTQzGunEvS1lLEiwTQC/lnKAWmeHiol4LPNl8eBc7JJfOJzKqYNyMtHkMyxBzDwESSu0EU0LMh9I//fqZW5jcy0jwuZER7J173DfZQ2sy3eD/WAE3YhF12SQrLMx8ak8AcDB/FZmo2SoZM7YIYg/52I+nrf+9iX/SXwyyS3R0T63ESvU2/icI6dK57Kgpz3AhoHZNNkl1qpjAhDfpCyzWI/KEGs8MaN2A9QsaaYpHb7V/+8PBDkuYcg/t8e80Vu+0sKQ4T15N18UK78SYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UXMHmuEc3l8UANVVRsCnmQZbaamEKc7Vz0K1W+Wh0U=;
 b=AQiQXIaGNUH18DW6uVeUqRQmNBlM2F5JkrPTLqgpQVsBrgvm3KkyJ3ASRkwMFc2l0K/HdVHOmXO4j+pb4gkxLUgTa+sR4hJC3jfRxHBeHgwx/AUkU/ZP6BL1FEy6W4z4xkJ4g8EoY8YjzbPmfH6U0+LYxKdYWWtKgKz5v2sNocaruHAEFE+uwRWj0bBnR27iO4UCmLFBebXjJKBiwq9wIne28dLjhk3p7mHENh7lma57/xLydhPdMCx+Lx20m1ZMT4l5nEHeItF1hZiXPQTu8RLMdyRo5owszfUa6t6wvZArYAamVOJoVp0GKlOzSYhZjX66W5sw/iAsLx2dAizXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5104.namprd11.prod.outlook.com (2603:10b6:a03:2db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 22:21:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 22:21:05 +0000
Message-ID: <d2a14965-3ce6-466e-86ab-70c96a51992d@intel.com>
Date: Wed, 3 Dec 2025 14:21:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 6/6] ice: convert all ring stats to
 u64_stats_t
To: Simon Horman <horms@kernel.org>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-6-6e8b0cea75cc@intel.com>
 <aSWCT0eB79P6h18F@horms.kernel.org>
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
In-Reply-To: <aSWCT0eB79P6h18F@horms.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------wetsYBxoANwdfT2gFKMYUdAW"
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e087c1-8758-4cc2-0855-08de32ba403f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzYxNmJDRzhRTExOVmk1QTA2dDJnTjRiMjByZTZYWXJGRkNtNXduMlFxRUNO?=
 =?utf-8?B?eUlIaWZHYWxPeTdNbDYvdjAyemhmeFNjMVA0dVY3cDZpQzFxS1BCSEZQNUhO?=
 =?utf-8?B?dGVJTkxjUGVYKzR5SFpTTzBINVVxWHA4aUtXaXIvS0ZWd1NrOVRYQ1FWVGY0?=
 =?utf-8?B?QmJvMW9NSzNxdmpWdXF0dVZ2UkxLdmNvYnp6T0hmL0E0TGp0RVVCRnJyMGJx?=
 =?utf-8?B?QUpSUTBjU3c4UVppbzZCVWxwNjhZditUSjltL2RwK09aYXR3VVpIeFJzV3pH?=
 =?utf-8?B?d04yNCtyZEc2RGJwQkE5U1dLbUgyaGpEYURMQXZQcVRaSDJMUDBCcTh3RDFz?=
 =?utf-8?B?NUF3Mjg1bWsrUkVNUFJkMFRJQy9yS0dTQklpVU9UMHhXV0VSZlNBS3lCVmxk?=
 =?utf-8?B?dGRHcFZJWHVMcE1lcmVEcUx2M0M3UDJFSzYwaG1VMEFEV05YT015MWhNS01V?=
 =?utf-8?B?c0hTSnRGc3I1RlN0eHNXYTFyOUJZZ3pFMkppa1kxSzMrSWMxd25uS2EzbXJu?=
 =?utf-8?B?ZHVQYlJxMTU2Wi80SjlnYlVsRUpWZDJYaHVRc2Q0NFZVdkFGbG12WGtUcGsr?=
 =?utf-8?B?eXQ0S05zWEpHRkxjZjdLVC94SWo3UVlxUFdNSi8vaFAwSTQvbEUvVU9RdnlV?=
 =?utf-8?B?QnIzVXBUVDF0RG9qQ1k3MUdncEtsZjRvLzB6SjViaitOLzBWK1VNa0ZITFRn?=
 =?utf-8?B?UDhYei9yZlpSMjVMWWt3U1dIa3JPYjcvblJ3eGE5N2hhZVJQOWZiYWJEQjcw?=
 =?utf-8?B?bWRmd0RtQXEwU2JmdFpqcktlYU96R0dIc0lFK0pLanI5dzBGU3ZRZU1xMGw4?=
 =?utf-8?B?T1J5RUtZaHJvOFhST2ExeSt0WUh3ZllrOFBxL2ZyTmxRZ2ZKWjdZNVVpa0JU?=
 =?utf-8?B?blIyOS94dXZVQ0NwenBTbmE0endtcDlaalFSQSt0c2hlOEVqenN2Vjg4UlNM?=
 =?utf-8?B?cFZxN3dLNitIUU10NW01T052Z1VtaS9pWFc2aDJ6TzJ2NElSa2tUVk5mSXo4?=
 =?utf-8?B?eEZaRERmUGdKUjFGMjYwbkN4OXdxMWRtYzhnSElVcUNES2l4S0FtOTA1YXJU?=
 =?utf-8?B?WmN0UU5rMnZLUlAxZW5MbGl6WTZqVStOd0RjS1pLV2diaW8rS0xJUFhlNDlR?=
 =?utf-8?B?MWR0VWRRSG1oeUdtZmdoK2VFQUduTzB0Y0NjRkdJNE9hY1lEbTB0OFBtaFdM?=
 =?utf-8?B?eklyN2xlUVA2MmorQkVWYTBMemt4cFpXUFIzdStDdEo5ZXoxRWtBaU43VkJr?=
 =?utf-8?B?anFKOG1hK0sxNVdBNWQ4QlBBdFZXMzNPSDltM01aQm5Rd0lNZzJlSElRSWJC?=
 =?utf-8?B?RDRtT3hIUk5VaWhsL1kzMjdzUnEwL3ZMU3hjVkhqcmdtdkhmUHJJQ2pieC9I?=
 =?utf-8?B?bE9TUlVhL2M3WVlwUzlIMUFkakJVTkF0cFplODNzb3d5SzhDUUlTSW8xb2lZ?=
 =?utf-8?B?NTNUSkM5ZDBSQk5KMFB0ODZLVUY3WXdPSW5HNlhGVGZDTWpFZW4xS2xqWVk1?=
 =?utf-8?B?TnV0Z012ekJIOFJ1ZzZkaTBDdHRFYUV5MWJOOGhzdy80SkZ0SEg5WDZ5N1JV?=
 =?utf-8?B?bXRndXdLYlBkVGJVVDl0N3RVTEhEdXpNWEtIZjlRblM3QzZEam1FVThmRHMx?=
 =?utf-8?B?V0piNEtXNG5qaGlFd2tFVWdFa3FHdmFiREFpY1Vrc0VCdE9tQWZnUGJKUjE0?=
 =?utf-8?B?TWVwQ2p3K0ROM0I4ZFNaV0xIcTUyVXIranhlYjRDZktPQzZHOEtxR01GUWh3?=
 =?utf-8?B?Qk0rSU1TblYva3pLNEdyUlNveXJxU2d1WmQveUdVeWFvRzBRUGVrOUZjSmxT?=
 =?utf-8?B?ZjRMQ2o4WG9QQVU1akZHUHB3TnFkOURsRUFTaml6a2hMaXMrenlMNmRhN3Yz?=
 =?utf-8?B?bjA3VUZPM3hXeUhUTTZETU9MNDlhNVZSSkxOZmxsUzV6VXp0UWVXenNvRjJw?=
 =?utf-8?Q?0WM3LFCmZ82G4cL6Tkd6W8l5ob5psjBi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk4xZ1QwUTkzVVpHTTJkYlBHOGNGc1dmUHNjOXVLWjZNMWJpU0tuaXFlZTYv?=
 =?utf-8?B?VHoyNnJyM3Z1VDJHNWFCMnZMUk5DNTFmdE00dS9KanNJTWp1WkE4QVR2djJW?=
 =?utf-8?B?eE4xd0xraFdRNzVGaU4wcEk3cUswbytQSmFKakRtMmRvMFR6RWdlUk95NWVN?=
 =?utf-8?B?bWFqUDg5NFFNMzArM25FR0s3b3ZabWhRSm1CSFZyelBTWHF5WEFTQWEwMzhV?=
 =?utf-8?B?ZHo3bytzTkl6aDdzRm5JZ1A0Q2FNUHBhTVNqdjVXdTIwS2JMa0lMZXVSaFBt?=
 =?utf-8?B?WTNnS010MG9ET3MvRnA4cGNEV3BwQVl4VDVVbEpaUTcwMWRFNzVTWWtQdFJP?=
 =?utf-8?B?S2h6cFBFelQzM0MzMnJ1RC9CLzVQd2lPb1lLcjgzUjl2cU9nNTdxQkcvWkNi?=
 =?utf-8?B?c3czZGVtZVFsQUJqc3J4YVlmWmFybjBFWm15azlyTXR3SUQrdU1ZWlJ3ZGk3?=
 =?utf-8?B?amI2TkFBRUNqOGU2WVNXTWo3VWRUdnRkMlZvcERvQ0lpdFdIYWorNld2NjNP?=
 =?utf-8?B?QndBaHIvNW9FRmVkd20xbnlNRDZGYy9xb0txdTFqd2RSYnZCN0RHYVhieGZ1?=
 =?utf-8?B?eG9RMjF4QXlMVDNRNS9DaWhobnljVW9ma2IzdXNCSlFHRE5PemxqWllvWmww?=
 =?utf-8?B?cGU2QlQ0Wkl2VFlKcG5qUGlIcnJCWHhJYnd4S3ZVbW1zVWY0K1VqYVJLbGor?=
 =?utf-8?B?TGV1SGpmTDlEalBIRTkvbGRjSm1YblQ2NzFncGVSZ2NpdExqNDRxZ2orUHU0?=
 =?utf-8?B?ZUxKVG1temVLZzIwaTlQUGFWeWxwbWVmVmFRdm5WOVpXNktMdG1CT1lwVVlG?=
 =?utf-8?B?a3RrdUtIbHlyRmhqUm0vQjBDOUxzRUtoc2JQZGpmT3lZRGdOR1lNcEtqbFNB?=
 =?utf-8?B?dDhhei9vOENzanlTeGxqSEJhaHFpNHZyelpHMFdQVVdNci93ZDV5MVVpWTZJ?=
 =?utf-8?B?R1BOaFZtOWcxUjViRDlzOXFnd2dTalR5cUg2ZVp4OVlyM1NMaGRGaHdBRU9M?=
 =?utf-8?B?NVZSQXorUWNlb0g1SG5Kblc4WEQ3RUdMcjJlQ3VOWHRJN29UalBTVC8wbjZS?=
 =?utf-8?B?a3hQTElQb2l2akR6ODZqdkZ4cmJybkVLQ3hHVTI3QXp2Snc2NWZhcEc2YlZV?=
 =?utf-8?B?R2tBWkROSURFZzdud1ovOTVkelNuK0YrRDdGWWwvZlhBc0p0MXVuUFY4U0dR?=
 =?utf-8?B?NUh1RnM4Y2JjbmRyV3JSVzc5YUdrNWl4aVJaYUZYc0U4KzFVNEFnNXhTOFF1?=
 =?utf-8?B?a3UwaU5XZGNtdEVEK3lrb1ZoU05YYmJvT1lLQllTTndOYzJ6eHJVOGorTUFZ?=
 =?utf-8?B?R1ZyMHV6TVAyb21OcENHb1NLbWN2V1MwQ25kUnYycVZYbkoyM3RlYkdRTy9t?=
 =?utf-8?B?YjZEZG5ST3FNckRHM29YT28wZDlyR1F3ZUd0SEpnSXdxYk5pbVNUOHVwd3Jw?=
 =?utf-8?B?REh6ZXVPbktTVXJmMy9janpaZ2Q2RlJSYzFTMFRxa0ZTOFJwSTU2aVV6QVl4?=
 =?utf-8?B?NDFyTG1XOXVjdFN4aDd2VXlBQ29QdEhUTloyaDFMOUdSTkJ0RkJQUC9ya2Nz?=
 =?utf-8?B?dTd1Lyt6d2xubWUzYk0wNTNmejJ3MjNBZWlQTXdab3hpNjhtalcxZkZhTGt5?=
 =?utf-8?B?WkdqbXB0eDlNRkhSNmdBUHJpcEFRbEJPZlNhSk5ya0VOMjFRemUyOVM1RC8r?=
 =?utf-8?B?aDcxd213b1JQVUw4cUs0ZTFIamx5bmowMm9rZU1qQnE0T0dkLzlMMWtjWWo5?=
 =?utf-8?B?Wlllc2hVTS9zOGRmVWx2UjErb2REdW0vYmQ2UGFoQzE0MFRRZVJiaWtqSjJj?=
 =?utf-8?B?S09KQU9PaklXakFaZ1RKZDZPNTVxTGhCekNScGR0SXpZZzZOTkpVSGMxZWZ0?=
 =?utf-8?B?ZkppUmxUTjdpREVDU3ZUYkUxcVh1dHZLc2tqL2N1T29YdFVnVzVSUHpnRUlU?=
 =?utf-8?B?a092MUIyQ09HWmdoRDNtTnpjOEFYdFh5U0hWcCt4dXozQ2dQbCtlcGdnUXY5?=
 =?utf-8?B?Sy9OVDhPM3BhQjRXcEk3T3lRL0w2dW5BYjJtejl3OVg2V2hXOGdKeGx0dUZD?=
 =?utf-8?B?VVRDamk3NSswNVhZaFgxNEg4VDluUHRCa3lodjNCSmxGTnZnNWp1aHZoQnJo?=
 =?utf-8?B?V0dtbkRzYmdwemUxczBPNVZ6MG5mL3k1cFliak9zS2lkeWQ2T0oyc2k3bG9H?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e087c1-8758-4cc2-0855-08de32ba403f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 22:21:05.8318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xF8rR8KCk6SlvdYxPXkSfQNIx2CQJ6T3AUXtSlQLBva0ajSZZIt+0z/9NzFk7N3SZgFQnMcWIasFxYzcWYhiJTDcu5Pbst08vBJ9e63cv8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5104
X-OriginatorOrg: intel.com

--------------wetsYBxoANwdfT2gFKMYUdAW
Content-Type: multipart/mixed; boundary="------------scRYU5IPi9KONDlGrmRPRL2h";
 protected-headers="v1"
Message-ID: <d2a14965-3ce6-466e-86ab-70c96a51992d@intel.com>
Date: Wed, 3 Dec 2025 14:21:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 6/6] ice: convert all ring stats to
 u64_stats_t
To: Simon Horman <horms@kernel.org>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-6-6e8b0cea75cc@intel.com>
 <aSWCT0eB79P6h18F@horms.kernel.org>
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
In-Reply-To: <aSWCT0eB79P6h18F@horms.kernel.org>

--------------scRYU5IPi9KONDlGrmRPRL2h
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/25/2025 2:17 AM, Simon Horman wrote:
> On Thu, Nov 20, 2025 at 12:20:46PM -0800, Jacob Keller wrote:
>> After several cleanups, the ice driver is now finally ready to convert=
 all
>> Tx and Rx ring stats to the u64_stats_t and proper use of the u64 stat=
s
>> APIs.
>>
>> The final remaining part to cleanup is the VSI stats accumulation logi=
c in
>> ice_update_vsi_ring_stats().
>>
>> Refactor the function and its helpers so that all stat values (and not=

>> just pkts and bytes) use the u64_stats APIs. The
>> ice_fetch_u64_(tx|rx)_stats functions read the stat values using
>> u64_stats_read and then copy them into local ice_vsi_(tx|rx)_stats
>> structures. This does require making a new struct with the stat fields=
 as
>> u64.
>>
>> The ice_update_vsi_(tx|rx)_ring_stats functions call the fetch functio=
ns
>> per ring and accumulate the result into one copy of the struct. This
>> accumulated total is then used to update the relevant VSI fields.
>>
>> Since these are relatively small, the contents are all stored on the s=
tack
>> rather than allocating and freeing memory.
>>
>> Once the accumulator side is updated, the helper ice_stats_read and
>> ice_stats_inc and other related helper functions all easily translate =
to
>> use of u64_stats_read and u64_stats_inc. This completes the refactor a=
nd
>> ensures that all stats accesses now make proper use of the API.
>>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>=20
> Thanks.
>=20
> I do notice in the cover that you solicit alternate approaches to
> lead to a yet cleaner solution. But I think that the approach you have
> taken does significantly improve both the cleanliness and correctness
> of the code. So even if we think of something better later, I think
> this is a good step to take now.
>=20

Thanks. In particular, I was wondering if there is a way to help improve
or extend the overall u64_stats API to make some of this non-driver
specific.

It does seem like quite a lot of boilerplate code is needed to make
correct use of the APIs, especially with the u64_stat_t type existing
now which is necessary even on some 64-bit arch.

Perhaps some of the macro wrappers could migrate into u64_stats.h header
somehow. Though I'm not sure we can keep them quite as short without
being in the driver.

> Thanks for breaking out the series into bite-sized chunks, especially
> the last few patches. It really helped me in my review.
>=20

Yep. I originally had this all munged together but it became impossible
to follow the logic of how I got to this point, and also obscured
several of the outright fixes.

> Reviewed-by: Simon Horman <horms@kernel.org>
>=20


--------------scRYU5IPi9KONDlGrmRPRL2h--

--------------wetsYBxoANwdfT2gFKMYUdAW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaTC30AUDAAAAAAAKCRBqll0+bw8o6Do6
AP4naTuAQP1qcq88g9fum+Lp7Ac/i65ky1bNdNZfWHNKDQD/a0CS9QYNDRQa6qwK6PkF6TafuClj
dqRKytOigbJ9Ugk=
=5R8k
-----END PGP SIGNATURE-----

--------------wetsYBxoANwdfT2gFKMYUdAW--


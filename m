Return-Path: <netdev+bounces-208725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6AAB0CE74
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31517A770F
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D5248896;
	Mon, 21 Jul 2025 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nb1WpVVE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794B19D082
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142158; cv=fail; b=aFwNVk6KDd0rG37N6fKzZkKR+VP5Lhvbw8Z2C9DgbNsNx86pq6hPCGGKKm1cHFK9W9AjeL3aye/bdYO2Fbdmx64hYvBOfryqnz7/QRca2wkN0WKHAGJ7PrNgRQGYm/jL4cdOBxmAr5+4Trygb2kHI4ppVNswI/AJUxXUgq67bOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142158; c=relaxed/simple;
	bh=OIMIHdCH3o+Nc08T6K9EMVfqq26hU/g/Lxu2oXpCe64=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eBlvBExg4bHTi5if9/YnIN+nrTfWzA6VaizS8+JEqv9pI9Q1AkYB4R/i7MZDyy2hzdtNJS6CmMZUAYm0zzt1QbQOSzAaKSq/P1D0ZIYHl92ZHaYCKrRWCaM+mga2R2yyflAqUAHLeQrdmZkOfLTE4eas26kpEr3rNV0N3aVQPRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nb1WpVVE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753142156; x=1784678156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=OIMIHdCH3o+Nc08T6K9EMVfqq26hU/g/Lxu2oXpCe64=;
  b=nb1WpVVEzVvw+uti9ualOYgsnBiPHtZ+hDYRfeR0gnnyLqbaoJ7UtE8R
   TIT/2dWOwWT709TJQxM3kG5nau369IW8OIAQhz734tmJrP+jEGcmm5GDj
   /vNp9KVul1cPAcW1tvyofuNlqY7LiSa4VZhFpCnH8kQFV7JdJVLzkUcUi
   PKxt7ZW0gsgVPVlKlXdCaWlXoZssz5WFX/RsWtwWEZhmqZoK9MjqIeCG0
   W1jbuHDhri3NEpg5rwOf/APPPKFj1nYS7FMxT9i38kP2rxtwdT4/q5/JI
   nmR+TsphPuh67wA+bAM9kEUELwbH8pSemzZghzHLcnk2vmNXFneHs04ow
   g==;
X-CSE-ConnectionGUID: lCdbAHvpTUaNN+SKKWJfbw==
X-CSE-MsgGUID: iGbVMhEQRBKptV5eqlTjHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="66719777"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="66719777"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:55:50 -0700
X-CSE-ConnectionGUID: crRUwDC5S/GxeKtnZnl4yw==
X-CSE-MsgGUID: KdfybG1FQqGApR8TaeBP2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="159023898"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:55:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:55:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:55:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.73)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 21 Jul 2025 16:55:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wClZJ44HzsP8G4UUBDW6VAFKH6xnws6rnU+0uoOS5gU/Gdr7Mve4M4dRxj3HHp1t1/4EyUMiRug7rE7T/3IKOCFZCCm6YoT59+B+Bo8KW21vy8i4fUz0WqSJO2xQflkLRbQ4NwTOvBFw8D76ysRsgWXkK8u1SBZ/Ha4nwlgGErkovWuuvTYhquMTXNMlVBo9tHGBQYQ4u0LteDhAPNKaHT/RYUnVhNo8MUVJV+/QmOa0IINFXSSOezgncRluPM7OyJsLhp/afn+Io/tPBgcZMGAR/Ec7AVC+22ZNqdsr7Fh2qlsi3SEHHCn9TMBFIISN2vVnWsTp6Vfhk3gFxtJZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tChOhaPVJgIAKAGGtgGZGIQ3egymvVyIZRDC1GlnX5E=;
 b=NENlq/NrPgRRm0TbjsgAe7bH7gKiE5yI9utTGND/ymiZI+nxoysoBBjv1MeRn25+npSUbbGlkOJqOUczuiHWBLYEikvJt4ogG6DKwUOEMnoTw0um6ySkkn9MCLA+RImtt1GGWgNy45Ui4Cmio6N3m39a3jeOW6n+mmMltE+KJ8fnY+9MvZUw7ey40guC2/qv+ekByBduI/EntAfp5NDl8Sd+WjzWkhedUUimHd8YBq78C9OpMYGI7o2AD5bzIeZce+20OKAnYWSrO3V0o8UsnkM+UaDhA5MPmSBYa07TJ6iRLYrjMOVODhtj/TRE2kDwvNkFp0MyjK6r+4Le1PcEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Mon, 21 Jul 2025 23:55:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 23:55:47 +0000
Message-ID: <d45910fb-f479-4991-85c8-7dd5e2642ff0@intel.com>
Date: Mon, 21 Jul 2025 16:55:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: wangxun: change the default ITR
 setting
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
 <20250721080103.30964-2-jiawenwu@trustnetic.com>
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
In-Reply-To: <20250721080103.30964-2-jiawenwu@trustnetic.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------zGgJpCXj2bjQHEtmYZrZEhCt"
X-ClientProxiedBy: MW4PR04CA0310.namprd04.prod.outlook.com
 (2603:10b6:303:82::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: e96c379f-943c-48d4-c92d-08ddc8b21cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGpqNGdXN1JvV2VYd1B2YXAzd0hmb1pqMjNpa1VCNWMvWW5aMVk2NXNVRDd1?=
 =?utf-8?B?dWMwSUQ2WnJZK0pQVElhdkZ4SmFCbklTam5jZTl0MFFJb0F5czhmNE5xRWVt?=
 =?utf-8?B?MVFjNnB0UzZXbTBzNUNMTjlGeTE1V2RBQnBUSlVZbjFDVGMvZUIrd1ZIRFJX?=
 =?utf-8?B?aFhyRWhqSTRVWlhnYTRXa0V4Vy9JVDF4aVJ4c0VzUHNmOVFuWERROUtBSE5H?=
 =?utf-8?B?MjlpdzJEcEN2VGx2emt6OUhqZlpvek5kWXgzbCtSVk5iTjBYbmlkRVVtK0x3?=
 =?utf-8?B?M0JaZkNFb042ME1OeFI1QWVsclZyZm5SMEVzd053ZUI1djZuTnY0TkFOTC9J?=
 =?utf-8?B?M25MRVJCOW5YSDJBQXVObE0raVZEdndNUTFZaHZzSHJOb0tVelpTQ1NWKzhs?=
 =?utf-8?B?L1pXSjcrOFoxZmFzMC96LzhpR2ZZVmpjTkdzSndBUkdsUmlQczdYOE5rdVRu?=
 =?utf-8?B?SHJjNFpOQjF1ZnJRY3BFU3kyRjBPRGZoVkthK25vcTljKzQ4REtaQXB1NjdR?=
 =?utf-8?B?ZjJuYXJZVnZpZ0plRXVYL01pcHJPaVZPR3F4T09iemdRMFI0QkdCT2JFbFpu?=
 =?utf-8?B?QzJpdnByelJQRzBOMnBFMGhEcFZTT1RiS2RON0tSbmdDRjBjWjM1WGMvWE8v?=
 =?utf-8?B?UkhTMGRhQit6WklCNWtNN0Ivd01TNmZSSTVYOGxiZjJQVFdXMzVRT2lpWFZx?=
 =?utf-8?B?dGN4NGNOODg2dHNPMXBNY3JoTy9ia1NwOXFzUXlQdVN3Q3BaMXFnY1dTWmty?=
 =?utf-8?B?Y0lrTXhSTkV4MGVCSWNDcTdvSmVKaHJLRUo2NVNnVEF0T1ZUaWJaWG45ejJr?=
 =?utf-8?B?emxkVnlHTUtpblRxQ0NpcTBVaE1hdVRPSUl6Ry9YN3p5SWh5WnYzSjNDTDUy?=
 =?utf-8?B?dlRBRDZ6YnJZSzJmMWR5aXVQdGxrQ2FIMWFPZndLSEJ5VnQyb3hMcnN2UGNo?=
 =?utf-8?B?NGxGY2ZZei9Ub1NyVVVKQ283WW9rWXl3T0dUSDZVaUJSUzFNN3g1SlVRcEdH?=
 =?utf-8?B?TmZxOUhGL09FalFoL3BTSFM0cUVoeUZ2SzVkQlhLQXBOZEdMLzZqSWVOa0l0?=
 =?utf-8?B?R1djQlFqVjk2UjlnNTR2dUsyZXA4ODRYWEZsUmFucjcyN1krK2U5cSt4ZlNK?=
 =?utf-8?B?RnlFOG9Fa1RPeFB5STc3KzN0RVJMNXYzZThjWUhqK1JpeWRqNG1VQ3kwU3U2?=
 =?utf-8?B?aWJ5RjB0Y0RwRmRSZlZKWHdaTnhhWVBpYjU3MWt4aHhXbDN0QVI1VG9XQkpF?=
 =?utf-8?B?M2RnZW5kSzE4VzBtQlBKT3ZPZWhmem55dUdXRERnTlAzUE9mdXJVaDRBamhF?=
 =?utf-8?B?UjI1SFpYbjRNVnd6TnJCRjZsaUJ6Sm94WVRBT0JQa045bHNUcW8wRjFGV25q?=
 =?utf-8?B?SjgvbFdhZmZuZDR2Wi85ZEp0alRIcjAxMEd0a0xDNmRQemNna2dZK0dXNS9l?=
 =?utf-8?B?Ymo4em84VWsvelAyc3lwdjc2bC9Pd1F1bXZLUU5pQ3VlYmJVUFprV2xJc1dU?=
 =?utf-8?B?K1d4L0xOU0tMbkFlUzBDUnNRRm9UQndHeXhEWkxsWjBZZkJHMTFnckoreitN?=
 =?utf-8?B?akRLYmZiVkpPdWl5WURVL1QyWlQ1RGIzU0hBbXlyT3ZJTk5EZmZyZHVHYmhp?=
 =?utf-8?B?dDUzajl0ZWxHLzJSY0lzSjZaTndMV1E1RXpuRytuL3MxNW56eElzS1JEcEJn?=
 =?utf-8?B?RTc0Ulk0Z1I3aHNWRGdFTDU4MXJ0OXNjc3lMbHdBYlNmR1kvOFQzTXQ1MHRi?=
 =?utf-8?B?OTFmR0NTR3NBbTIvbHlkeDBhQk00S3kvMDNxTW9nZDVZdHl4RzBjYWtjS1Nu?=
 =?utf-8?B?VzlNWkxPMzBqeHlJYW5xRFhVcXRuV0RQdndjL3NRUGM4Ylc0VDFOakk4LzZa?=
 =?utf-8?B?ZE8rUFJadkhWbktzMURkVXdLSFE3T3dYZ210MnViMjQ1eU01Z0VOaGVCZHZB?=
 =?utf-8?Q?1LH5UeNYvBk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUFDY2k3cW5Xc2o4RXo1dHZaVG55T0M5N1RKdi9MOENTd1p0ekc4SjFkdTZV?=
 =?utf-8?B?eTBjenRGblpkY3V5KzFBd2JDKzJndk9zMTg2VzFXRW1INS8ybUtkemtzT05H?=
 =?utf-8?B?ZjVWaUpHaFEwdlIrdU9pcUZHY0lJeS96SC9LWFZYUGxEbkJ0TlA0MWpSS3FK?=
 =?utf-8?B?NXlYRFJKZ0o1OTMvOTBuenMxMzlyTFd2eVllWG5ydEQ4T3YxNGx1YXBMYlFT?=
 =?utf-8?B?ZVNSeFdDQi90MXBjQVpIODhaOTN3ODRCUWR1SEhnaEx2b1VRNE80M1IyMFU2?=
 =?utf-8?B?Q1VRVlVPcHJJRDhwVTdxamdJQlkrL1VMODhRV21XL2hEN0Z6MUNxbzJBK3lE?=
 =?utf-8?B?M3lad0hjNEZYWGZkbDBIYTRIL3VuMkFrZGg1dklIbnlWV2FsQlNuOWdIMFRL?=
 =?utf-8?B?Vm1zdUFlYUhBVk95SWFHREhSVXpjUlJDTjN6MmlHSGo4OFBhT0RzenppSFZ3?=
 =?utf-8?B?L0N4UDZjeVlVZEhMYUlTdFpMRWU3blFSV2ZZQzFreDlrbktVbHNPTVZuSlFx?=
 =?utf-8?B?SkpZY2FSaVZkRDFPNElkQ215bzExcytrMjJ5dGxEM2VDV21tTlVseXBLZ1Bm?=
 =?utf-8?B?Y0p0VklpRUFtMkdTUEZFbW51em1FL2MrUzJMak40R1QvWVh1SUNJQ0tEdEx3?=
 =?utf-8?B?dldrUE95NjlDOHBUbVlUVVYycHZqQWZFUDVFNmttTlY4OWs5bEszYWVBeW85?=
 =?utf-8?B?bGtpa1g3SEg5MTd6ckpIQVhzRUIwWlpQZDBzYkd3UVZDTlQ0QnBkRGJ4dEJQ?=
 =?utf-8?B?UVI0ejJIZmV0ak1UQnpOYVM5YS9YS0F6aEhqNFVkZUIxU1FpejllSGZRTWYx?=
 =?utf-8?B?Q0F1OTUrSXYrOEIxckJhYWVkVjNFZFphRS9QbWhFZE14S3dweklCOFFWcGhC?=
 =?utf-8?B?VWtLWHY5NkVVUE1KeE1pTDhGWGVYdVJTSVZQUzdVNWdFTE9jSmVRU0k0OFR3?=
 =?utf-8?B?OW9KZFlVeGMxbVYrcHduVFYvZElpaUc1eUpKVXUxM1h6dzNIYTVTLzNpY1Iv?=
 =?utf-8?B?UEZOcTlmcitiN3A3a2RuYTBNNGFpT0VqYzB4V25rVTZKSWJhVFl3OU51MGhi?=
 =?utf-8?B?VFFNTldMeWt4UHYxbkRmTC9KR0E4VHdRT3Z2SkNxQTI1MnMreXFlajc5dXRl?=
 =?utf-8?B?OC95RHhxMXEzNFFlV1ZuNmwraEltak4vdFRxTGI2MWluM0RTZ1JuNStnc2JD?=
 =?utf-8?B?bktINGlvOWZCV1lsc2doY0FXNUR4R3ZzM01rZWtLbHprNnJra01CeDh5cEEy?=
 =?utf-8?B?TERjdXBFWkpTUEErTmd5T1ZlT3dOK1hKSjU4S2RjVGpLa0t5aHZaVy9ZR2Mr?=
 =?utf-8?B?Vk9iZWNxMVlRblBseVNEdVhYZkRDdzdnellYUVMreFhlTDJPOFVtSUJ5N3pv?=
 =?utf-8?B?MzlSR0ZuWTZNUkNxcndHWXVscEJMMW1jVTcxY2JYWkIwS25DREtXVHhHTXFY?=
 =?utf-8?B?cSswbEg0RnBXdVFIeDVJajJEdFZLd0FmNE4rTEd2ZCtaK3QvOWxUR1lBWmhi?=
 =?utf-8?B?S0gyMCtNVWVTUlduKzczajBVYzlwVDdaZkJLZVRadUNQZGZsbG9tT3NNRGRK?=
 =?utf-8?B?eFd5WUFEbWloUllZQWN6QnNpZEFwZC93OEVQNy9tQnpGUmdRK1U2OXJVOGU3?=
 =?utf-8?B?Q3NkUUlJNWNCc3lMbkcxTW9PQXVJSmdIenVhOUN1MW5UdTVDcVZQbGgxL2N6?=
 =?utf-8?B?RG5uc0xrRUM2bGNiWEVKZG9qUnZIRjhUWWR1eHQ3N1ZmL1NSNkFhNTJHOVZx?=
 =?utf-8?B?RmZGNHAzdG5ta1FWM0NNUEdpRWlUbjZZMlEzZDRzWW5qQThUalEvVDJLVUJD?=
 =?utf-8?B?WlFSL0gvZE5xcFdocm5sUGUzMVA1RVY2M2xIS2NSUnZZdjQ2SXgxQWtqRS9W?=
 =?utf-8?B?Mzd0SzBCZUE5bG9xR3Fxcnc2VG9qYk5IVTRDWGhKY0IrMjI5TEJHYXI2anc5?=
 =?utf-8?B?RnFsMzR4dWhjcDlZZjRpb3V6WG9pcEtYbDFybTRDVHZvVjFmdklkMTJZYlU4?=
 =?utf-8?B?ZDYwRlEyVWdDa3l2SXBDRm1jcmdEVUZBdVpkSFNNZEUzY0RmRENPZFZsK2Yv?=
 =?utf-8?B?cDNtTXRYYVpXV2o3TUN4dzI5aWlGY0FaeG5MQk0rMjRvWEgyS0pZTkJ0TjNR?=
 =?utf-8?B?NVVzb1ZFTUd3Qk9TY2VtNGJtaUFCbG9pUmZTV0FlMVQ0Z1JBek1oTzBEZlJQ?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e96c379f-943c-48d4-c92d-08ddc8b21cbc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:55:46.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehDmsPe4KKXdH2lFXGmL5ci1PJ4WdLoZLJNFSDB/KhoVaLcvHX6AJjLdKUcgZmiSIQLMHOd27MX5a3OmVGRLfY4S14XsmZMCzNvqQC0EfoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
X-OriginatorOrg: intel.com

--------------zGgJpCXj2bjQHEtmYZrZEhCt
Content-Type: multipart/mixed; boundary="------------FYdpcBQT1LmxZvCBU72wIRyF";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Message-ID: <d45910fb-f479-4991-85c8-7dd5e2642ff0@intel.com>
Subject: Re: [PATCH net-next v2 1/3] net: wangxun: change the default ITR
 setting
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
 <20250721080103.30964-2-jiawenwu@trustnetic.com>
In-Reply-To: <20250721080103.30964-2-jiawenwu@trustnetic.com>

--------------FYdpcBQT1LmxZvCBU72wIRyF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/2025 1:01 AM, Jiawen Wu wrote:
> For various types of devices, change their default ITR settings
> according to their hardware design.
>=20

I would generally expect a change like this to have a commit message
explaining the logic or reasoning behind the change from the old values
to the new values. Do you see benefit? Is this cleanup for the other 2
patches in the series to make more sense? Is there a good reason the new
values make sense?

> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 24 +++++++------------=

>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  5 ++--
>  2 files changed, 10 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/=
net/ethernet/wangxun/libwx/wx_ethtool.c
> index c12a4cb951f6..85fb23b238d1 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -340,13 +340,19 @@ int wx_set_coalesce(struct net_device *netdev,
>  	switch (wx->mac.type) {
>  	case wx_mac_sp:
>  		max_eitr =3D WX_SP_MAX_EITR;
> +		rx_itr_param =3D WX_20K_ITR;
> +		tx_itr_param =3D WX_12K_ITR;
>  		break;
>  	case wx_mac_aml:
>  	case wx_mac_aml40:
>  		max_eitr =3D WX_AML_MAX_EITR;
> +		rx_itr_param =3D WX_20K_ITR;
> +		tx_itr_param =3D WX_12K_ITR;
>  		break;
>  	default:
>  		max_eitr =3D WX_EM_MAX_EITR;
> +		rx_itr_param =3D WX_7K_ITR;
> +		tx_itr_param =3D WX_7K_ITR;
>  		break;
>  	}
> =20
> @@ -359,9 +365,7 @@ int wx_set_coalesce(struct net_device *netdev,
>  	else
>  		wx->rx_itr_setting =3D ec->rx_coalesce_usecs;
> =20
> -	if (wx->rx_itr_setting =3D=3D 1)
> -		rx_itr_param =3D WX_20K_ITR;
> -	else
> +	if (wx->rx_itr_setting !=3D 1)
>  		rx_itr_param =3D wx->rx_itr_setting;
> =20
>  	if (ec->tx_coalesce_usecs > 1)
> @@ -369,20 +373,8 @@ int wx_set_coalesce(struct net_device *netdev,
>  	else
>  		wx->tx_itr_setting =3D ec->tx_coalesce_usecs;
> =20
> -	if (wx->tx_itr_setting =3D=3D 1) {
> -		switch (wx->mac.type) {
> -		case wx_mac_sp:
> -		case wx_mac_aml:
> -		case wx_mac_aml40:
> -			tx_itr_param =3D WX_12K_ITR;
> -			break;
> -		default:
> -			tx_itr_param =3D WX_20K_ITR;
> -			break;

It looks like you previously set some of these values here, but now you
set them higher up in the function.

Its a bit hard to tell whats actually being changed here because of that.=



--------------FYdpcBQT1LmxZvCBU72wIRyF--

--------------zGgJpCXj2bjQHEtmYZrZEhCt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaH7TgQUDAAAAAAAKCRBqll0+bw8o6Cnw
AP4uPbH8mmC8oLxWEJ19oi4konAxZtsqAp2bFdlBKhMZ8gD9GrbyiOesdYFtY4Jb+NbZe8IXf8EB
c0tqtj/h2g1/mgk=
=2hdy
-----END PGP SIGNATURE-----

--------------zGgJpCXj2bjQHEtmYZrZEhCt--


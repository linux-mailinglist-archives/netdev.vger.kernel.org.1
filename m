Return-Path: <netdev+bounces-227518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21965BB1E14
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 23:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC96B7A5171
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85330E85F;
	Wed,  1 Oct 2025 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKvZuvUk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD002877EE;
	Wed,  1 Oct 2025 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759355648; cv=fail; b=kITNpX9N/fN6VfpiGWgawictE8raY/dYysF0jUCeOECpuEyEzregcIAj6IzHApEN/A3JwjMW0CH+QERHpRLKuL75vfNaosIVa0AyuECAzp9IMGKkDYBb9MEKynqdwymzL5o1aj48YfvLM5HwRoJIYIy/lNyxxosU5E6zFaef+ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759355648; c=relaxed/simple;
	bh=xhiQrS1B5xaWB1FyWmRTv1EwqdH6Z3roErGsUrVVh1k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOnQL3oq4h9akRRNaDs6+fCQ4FzS5GK1BHsrdNgGscUjtGYq7sANkziuHRwmdIMlBaL+mxoC4OGCUP+rC6JsRzN4xdb0wLK2WvMGq6+uy2UlxucFl/UrKDcEqDJogRoUVyxunl/qLZ+yrzYbWoliRPFY8P8aoTOgw6pEp55fNII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKvZuvUk; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759355647; x=1790891647;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=xhiQrS1B5xaWB1FyWmRTv1EwqdH6Z3roErGsUrVVh1k=;
  b=OKvZuvUkUzlctplSZY1MB3unOdTAeDWGsyMARwF6vH/mGgHEL2iNoKG4
   DXGD8koyjCjd88uK38XqnfQYqrmnL9ax9sar1p1/EoGNu9NLw3bPMmd8a
   fcmcFT2Cpy4XNCTj6BLnezSRu5aMLYRGkPg5Pbxdb5sFByHWDpH2nya+2
   v5Ra6Cs1l77mDXjiTTvq+LR3pj6wKzWwmSpIBJTfYn+RWP0ulGXaaZCdN
   A5vCmJvnEAQgFKV6DcKgk2DXuH8FMkVLBO/h7iR6wh2DnNE7/f/afzx75
   I7ap3xZOwowepnKVblPvOi0sTpMcSAvY/GnoYRKKkufOoK0n91IkiBanm
   w==;
X-CSE-ConnectionGUID: nRx94jSWTGyAUnbfsk0PNw==
X-CSE-MsgGUID: 7yMTk99+QFKT50UxqDHaWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61686029"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="asc'?scan'208";a="61686029"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 14:54:04 -0700
X-CSE-ConnectionGUID: lvnEK95ZQjKJ1kG1p+ja1Q==
X-CSE-MsgGUID: BHM9OSvVSi6xKbIuA1mY/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="asc'?scan'208";a="183190738"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 14:54:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 14:54:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 14:54:02 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 14:53:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvCltPfIRURl5AzNeobrenQsUFnjt8bWU3pPCFOPeEeLLZISIZfq3PfdGqsxnk/56aMXU6sbxxNHF7F6blr+veu3aoHuNZJp55EB2o6tZUoWziantAEDyYBHgY47qWQhGWvg/lD170DgJJMvxNrJo7pgRtRYmgLZe18a+jH2DPjDhvrHFkZnJXRUenEXzeKQiyLbb+HLsGHmWLylGiH1hLCSDsu0+OLcOWQesMypLyASJVQVmPGl725AzGELSLnh5QSHNPbwj3PMyZI2gZ8Mu9+vWZjmFnJYgDi+jwLdwc+gKxYNznXxqYFGz6miBOV5ebyYAPYNQO5Koqm3xdFAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhiQrS1B5xaWB1FyWmRTv1EwqdH6Z3roErGsUrVVh1k=;
 b=Nup2bKSlH9ndhBr06mSOnfeogtW1MI8U+XVd3POjGdjjmz5rY5vKuCbbtAASXJCdO2wmT7McjwcAaRTACdSgMyu8SLIAF5hFWJwJ3NvA7vPx1HBCJFfw0+CyuvhaaZCROS1ErAhPgvskxZSCourK8zbtEqjMu8jgQQOhO2elKiKvauX9TIrwBCvGhLwzuvwvdCn/K7Ob53xtDa94QTioVlH5E5gd0UxttdFu/c43kEzOicXKp9Tyo8ffP6RbfV3FNKIH2tuwO329/qhloDkuKZC0PpL+zRFee3QW7N2gpe11OSbCB1SAUvn9FM1fWvwkyafwrjDYrVi/EQb80xsVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 21:53:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 21:53:52 +0000
Message-ID: <3a97a4f3-8eb8-4f0e-a5c5-44a07b0c8bd6@intel.com>
Date: Wed, 1 Oct 2025 14:53:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] net: ethernet: ti: Remove IS_ERR_OR_NULL checks
 for knav_dma_open_channel
To: Nishanth Menon <nm@ti.com>, Simon Horman <horms@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Santosh Shilimkar <ssantosh@kernel.org>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20250930121609.158419-1-nm@ti.com>
 <20250930121609.158419-4-nm@ti.com>
 <0cae855b-e842-47a1-9aaf-b2a297ec32d6@intel.com>
 <20251001105416.frbebh5ws2rnxquu@quality> <aN1Pwh3B8xhEoQmh@horms.kernel.org>
 <20251001165808.lnatvc224dpewpe7@unscathed>
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
In-Reply-To: <20251001165808.lnatvc224dpewpe7@unscathed>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------ZAKtOXDJ3qqew9OWseOBuL71"
X-ClientProxiedBy: MW4PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:303:b5::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 58534e38-5ccf-45c4-f2b8-08de0135027d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEdOelB2VGQwamFiTTBxdXFibjdESjhmR21zanBCeWtiL2pycWZ1SDdwTUNU?=
 =?utf-8?B?RjhtOWxncmdyUW5pUDAvUnNGZHRUeERyT3JOMTZuT0dmN2x4andRczF3cjkw?=
 =?utf-8?B?TjlxQUxLcTRzZzE2b2hNdXNGZUNsMGRWVWZMS1ZCM3B3RHRjRGM0NStXaVU4?=
 =?utf-8?B?TzhOMm8zVHQvTEw0ZmZYRzMwUmozQmM2dVNGS0JlRmw5dGl5eHN1OTBTbnF5?=
 =?utf-8?B?emlTNE1Vc2x1YW9uWUZ1TFJ4bDZVeFZrS3BwOU4yZHQrTURPWkZlZUFPeDRo?=
 =?utf-8?B?Ukx5Wjh6SG9ldnhRbnhpVitpY0k0K1lGa0hraUlnUjMwTmZ6WUliT05GT1V6?=
 =?utf-8?B?eFVGYmxSa0k3Y2hYNXZncno2dmNLMVNUSURCUW1RbmUwSlc2QVFDR1RUM2NM?=
 =?utf-8?B?a0VBaCtXcUlyMUl2Nlp6OHVweVhEYm85N2cvRzBrczFES0xEUU5ra2tVcXAw?=
 =?utf-8?B?T080cVMxK3NJSVQwcDlFYzJFKzJrdGJwQzk0bWJCRStKTlBMcFA1NHdIMjFW?=
 =?utf-8?B?TDk2eHUrZ3ZlemJuM1hYY0pZaE0zTDVEcmhPVm8vK0tMVlVObmRmdVFNdVZp?=
 =?utf-8?B?TlhJOVZmNi94TTNPNFFIemVGTGUxdlFsZGFVUkxPMFBEbDdNQ0JsUTNsOVpi?=
 =?utf-8?B?K3NGY1dIOGEvTkpOeE11Y0ZjMkZjMmhFVVdiR1g4SXVPREgxTVRORFcxRU1o?=
 =?utf-8?B?K2dvc1pEdy90OVliczUrak41N2N3Q3p2Y0RnVjhrb2J4eFErUU10SFRrNk1j?=
 =?utf-8?B?NDYrSW5BbGY3c3JRNk5Ea2oya2J3Q3ZvYmhNY1ViYXBycGVtWTIrVSt1aEpn?=
 =?utf-8?B?ajBUOGlaQTBZWUFaSWFJbGtGSXN2R1c2OU54TXAyWEFxbjhqZEZ6bE5zMC9E?=
 =?utf-8?B?d1ZSY2Zkbk9hS1ovRmNLL0VtWlVjWUY4d2tXTUU5ak8zUXlkRmxlR2k5Lzdr?=
 =?utf-8?B?UWlXV3hqS09QeXg5QlNibzhraTdsakNyZHZGSWxKcUl0SHJWRWw5c09yTkJv?=
 =?utf-8?B?UUliV1pUVkdLZzYyYWk3NStkc1VlaHcxNHV4Y0tCWnRkdTlBcGIwdWhLTE5N?=
 =?utf-8?B?MWh6MFpwMHRwUmQxUitTUWhWMjY5a3BlSlRYMFdBdDRab3puenpESlF1aUdG?=
 =?utf-8?B?dHl2dE0vTjg0Vkt5NlA1STRwQkplbDIvTC9rYndnLzJteEplL3pIZm5mSWUv?=
 =?utf-8?B?NUhiYXdvL1BtaGVrVDlkUDROVHNBMDhxSkI2VzJ5RjFrKytxc3lqOFM5aXBq?=
 =?utf-8?B?YnlqQTU4d3I2OGczcnJGYWFIckR2bWlpeVlrN2NncnJjdGcwdnhIcWFHcGR3?=
 =?utf-8?B?SjlFT1BwL25iTG5YWVNuOFlrTXRKaFU5QnU3ZE1kbEdzbERKSjd2aVhKb0x2?=
 =?utf-8?B?ekZiQkFOSlN4SDNPOHhVMlNCNzc1b2NqNVo2UUZqSWJIME9wRGt4WGF3ZWtk?=
 =?utf-8?B?TWxWTlcrK0VoTzFaYm1ZYlJTRVVmVTdaWWxSeTFRN3craktEWnZuU3ROTDVV?=
 =?utf-8?B?UTRVWVRGR0dyYWhYUldNK2p6MFFYRGlWY20ybEoyQ3E2dTdmeGs1ay9mSzRy?=
 =?utf-8?B?ZEk4YVhHN1dhZGtmQ3kvSEE1aytudWlXd2wwWE9HaEhxYW9GWE9IWktKdjRz?=
 =?utf-8?B?QklyOTlZcUVHY25xOXI4SXM5M2tUWkhxQzFwRG9hRjNydFJDeStMR2x0TXBo?=
 =?utf-8?B?bXpUa3IrandBWW42MzRQQmhvTkJBc1RRVXFZRFU5SUxyMFVaTE9CdEIyYU0y?=
 =?utf-8?B?L05rZEtaaEZENCtORHZ0b0JxVHpLYVdHeXIya2doRkp5YnZZZEdFaVB4b2ls?=
 =?utf-8?B?YUI3Vm82Zjh1eDluM0F5NjlwS1Q4YjFrRXVDU0M1WjBBOS9JVStFS3ZDSTJK?=
 =?utf-8?B?S2dXYjJLRkNiaE43R3hURmpCcnRmbXpEcGQ0d0pmNDBCeWdBRjhiREhwYUx1?=
 =?utf-8?Q?+bE8iSqAKuVmDKLc5LgVhERGlZbstPX6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElEYUI1UTRqY3MrbFZ6UmNwVjlqV0hxeTZPQUFoTDJIZ2JFaDA2Y2RiUXps?=
 =?utf-8?B?eEFTTGNySmlVZEVLQXVrTGF5dG9WeElTUFZaMEFaRXcxOGUxZE5WcU5SeVNF?=
 =?utf-8?B?eW5TckVxZXlEUnFBckZCSDJnWWo0V3VkU3Bndmk5K2hraDJiR2pwUVc3K0lX?=
 =?utf-8?B?NjVrbU51aHYzdjJ4Tmd5VkhobHhUNzVkZVc1V3loRVh0M2tET3NBL1BQL3Jq?=
 =?utf-8?B?dDRHdWRubmo5K01PaDZyblhJT1ErOUlEZHBlNU1TcUc3emE1MGEwUHJFWE1Z?=
 =?utf-8?B?YnhNU2h4WkNJS0kyVk05Rnh3V3Z0VDRwQnZ2WUliajczR3orVCszTFNvYWtE?=
 =?utf-8?B?SW5ENFN2QUFla3o2bmpKc0NDWUN6VlBrRFlOYVhOZFdSR0drQmxMbFRWSWNQ?=
 =?utf-8?B?ajB0cXZDQVZiNUZ2RzllT1dnQ2JoMHVZaFpJckhXbnYzS0Z0Y1NIejlYYkt5?=
 =?utf-8?B?OHROV2FyNVZxTzI2dUJ5aGNhM0RUdktHSlFBeS9GSUI4MEhIZDM3cnlLRUJv?=
 =?utf-8?B?RExob3NrY2lvYkZ2YVNXZHcxdENjS0s5NGZ5a3ZQbXRNZG9KZXZ6b2M0YzhY?=
 =?utf-8?B?TTlUVmpCdkRlV1h1QmdYSURaajBDR2FiZWhUbGRZVXMrb3ljcHZ6Q3NjY1Bx?=
 =?utf-8?B?bFEwTW1CVHZlSW1pakxscndodDBRNzB3THR3UXJmVEdONzRkUnRsVjRua1Va?=
 =?utf-8?B?aE42U3BxaUtCSmQ1NzI2aFpOSUhIVE1XNGQ4YzMxTURuclUySnlqQUZWaHh2?=
 =?utf-8?B?c0F3d3Z5QnBkYWVrNGhMa0ROZkNGbVVYNGxnUFMxTzM2RDdBc0E5eURPV0d6?=
 =?utf-8?B?aDYxeWczdFpHeFdkRThOVUxyanh6emlzMHFLcjhZVW1PMjFhOWw5Q2dyTTVv?=
 =?utf-8?B?dDNYN0xkd0hEekxna1h4VEt3aWRPaWNMeXBoQ0VlcTA1d3cySGxvYkZ5djZ3?=
 =?utf-8?B?TUxDaExQOHdpeE5CM3NQeWMzU1QvdmhsSHZUZE9ZNjJodWNOZlBCQzFkZW5M?=
 =?utf-8?B?MmJ3cEo0b3pwRDBpS2FpbnFHN1A4TWM2b0l0MXFuNDRBbWJrUUJhc1BWbGh3?=
 =?utf-8?B?L1ZpK2RtdjdSZEM0WU5UN25FQ2YxWUhPUUtTNWhLd2tENGVLVWVPalg5MGMx?=
 =?utf-8?B?RnNGZ2lzYU5McDRwSUVJRGp1bWZBYWNYdnJSQ0R2eGtGUjBFdnl5RXVQWUc4?=
 =?utf-8?B?NzF1SG16aHBQaytBanc2anBSNURDbU4vQWpyanAxSmdyNjc3cWZOcmVrTHcw?=
 =?utf-8?B?bkNVLzhFY1h4YWdLRGhlSVZLcWZFRW13cHM4WjlzakdTRHhtM1RJWndmWWdo?=
 =?utf-8?B?aHViUzZiU0Q1a1ZEd0w0YVNjQ1pvd0tBQjFyMCs0ZjhObzJVaHBTL3pxczU4?=
 =?utf-8?B?RWxNVThyQlZaQlljQnVsV0ZNdm1YVkRBWmFxOFRCQTBrT1h3ZkRrNGd1OEt3?=
 =?utf-8?B?bkZHSFMxSEUvbmxYZ0tZQzg1S0tHZVpzT3EzbE96RVQyRDMrbHgwT0RVa2w5?=
 =?utf-8?B?WW8yMmRuQzZNUE5tSnhvTWhlM3owaWlORW5QVTBQSlpUc0pFV2VqQTFENnJo?=
 =?utf-8?B?UlhNTmVCQ05KRzAyVElkajcrV0RqckJ5cTFHalduOTBqMWsvQ2pUOVg2WS9W?=
 =?utf-8?B?MUNtaXlRTVhQSFJlSVFpOEJ5VENKd0djRUl2V2ZqbzNKRXI0VU1IL3QvWHFa?=
 =?utf-8?B?dEpFeTEvSGc2OXo0R1ExYVl0V3VFQ0ExRG1IdEVOb3VWaXd5MkRKb0lKVmY1?=
 =?utf-8?B?dUVrRVVQQVRGZ3VNMGZJQndaU2pDSDRZdG5DU3lqRlIxK0pyWmdNcW5tUzhX?=
 =?utf-8?B?VjV2WFpkc1ROcXhRd085U05ob205MlBuZUVaOVcwbnRtWHQ4RW1FMjJZZzdv?=
 =?utf-8?B?S3IzU3VxQnNpQlFYejVEU3NjYSt6VVRRbDRmWk1yR09BRmNQNEIyejZkOHFm?=
 =?utf-8?B?UVZLc3pWL2VXQUZSeVRkN3lWRlN5R1ZoQ2I5S1QxRm1IbUFETXZIVHVCbkJJ?=
 =?utf-8?B?RlRKWkQrM1pHbDR3UXdoTzJhWEhhQkNXVjRDUjNTcTZHTitNdldnRHloV296?=
 =?utf-8?B?Q01weERvSlh2MzUrbldHaWpqak1ITXg1ZUdPV2xqVThEYmMwdGFQS1pRWmts?=
 =?utf-8?B?RG1NeDQvZEJTN21OcS9FQ3RjNWZaWklRbnlaVVQxRVNBSFNaQjBrdHRma21R?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58534e38-5ccf-45c4-f2b8-08de0135027d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 21:53:52.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuFAKT0JnjYS+lxrp9B8kLGnTSYUF3xI+xvbusdnza61bEc6r3IcvNno7q8Der5zBm2RTKvWxk5SzkofhMTdI/OyYWHA8UvfMdaXwcZC4LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com

--------------ZAKtOXDJ3qqew9OWseOBuL71
Content-Type: multipart/mixed; boundary="------------k2GgYDdo3RRTF4nQpqihCOUd";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Nishanth Menon <nm@ti.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Santosh Shilimkar
 <ssantosh@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Message-ID: <3a97a4f3-8eb8-4f0e-a5c5-44a07b0c8bd6@intel.com>
Subject: Re: [PATCH V2 3/3] net: ethernet: ti: Remove IS_ERR_OR_NULL checks
 for knav_dma_open_channel
References: <20250930121609.158419-1-nm@ti.com>
 <20250930121609.158419-4-nm@ti.com>
 <0cae855b-e842-47a1-9aaf-b2a297ec32d6@intel.com>
 <20251001105416.frbebh5ws2rnxquu@quality> <aN1Pwh3B8xhEoQmh@horms.kernel.org>
 <20251001165808.lnatvc224dpewpe7@unscathed>
In-Reply-To: <20251001165808.lnatvc224dpewpe7@unscathed>

--------------k2GgYDdo3RRTF4nQpqihCOUd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/1/2025 9:58 AM, Nishanth Menon wrote:
> On 16:58-20251001, Simon Horman wrote:
>> On Wed, Oct 01, 2025 at 05:54:16AM -0500, Nishanth Menon wrote:
>>> On 16:59-20250930, Jacob Keller wrote:
>>>>
>>>>
>>>> On 9/30/2025 5:16 AM, Nishanth Menon wrote:
>>>>> knav_dma_open_channel now only returns NULL on failure instead of e=
rror
>>>>> pointers. Replace IS_ERR_OR_NULL checks with simple NULL checks.
>>>>>
>>>>> Suggested-by: Simon Horman <horms@kernel.org>
>>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>>> ---
>>>>> Changes in V2:
>>>>> * renewed version
>>>>> * Dropped the fixes since code refactoring was involved.
>>>>>
>>>>
>>>> Whats the justification for splitting this apart from patch 1 of 3?
>>>>
>>>> It seems like we ought to just do all this in a single patch. I don'=
t
>>>> see the value in splitting this apart into 3 patches, unless someone=

>>>> else on the list thinks it is valuable.
>>>
>>> The only reason I have done that is to ensure the patches are
>>> bisectable. at patch #1, we are still returning -EINVAL, the driver
>>> should still function when we switch the return over to NULL.
>>
>> Maybe we can simplify things and squash all three patches into one.
>> They seem inter-related.
>=20
> I have no issues as the SoC driver maintainer.. just need direction on
> logistics: I will need either the network maintainers to agree to take
> it in OR with their ack, I can queue it up.
>=20

I think it makes the most sense to squash everything together into one
patch.

The change looks small enough to me that I don't think it would cause
much conflict regardless of which tree it goes through. Hopefully one of
the maintainers can chime in their opinion here?

--------------k2GgYDdo3RRTF4nQpqihCOUd--

--------------ZAKtOXDJ3qqew9OWseOBuL71
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaN2i7gUDAAAAAAAKCRBqll0+bw8o6E/V
AQDVCAG9QPSSzB208ChJ29d18DpdRovht7BBwY89g9/HSgEAj7TlH181vjRxr70N2LeB10Iulnxo
ul61ClLytyzUXgo=
=venD
-----END PGP SIGNATURE-----

--------------ZAKtOXDJ3qqew9OWseOBuL71--


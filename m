Return-Path: <netdev+bounces-219301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB6FB40EF5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B6D1B65057
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FFF2E8B92;
	Tue,  2 Sep 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Alwp51ap"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD102BEFEB;
	Tue,  2 Sep 2025 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846971; cv=fail; b=Tqfom+6Ek7JxsWT7BF4zrR8Ql7yEKIjuPEzjT+aTYovCCTsOVkqqeRucZnXmLf2ZKIvimpFcPC8P6pCNVJLFfziFyvTgmNa07hhgDhDgc02DauHFi955/Oog+H0BwVjpky6dxhlVbMJ1cDwqdHJBRYoMyNO8YdsQ+gaf2pK9ZY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846971; c=relaxed/simple;
	bh=q/pxEE1X+p0pBDUKJ9PQagyXqmtGkTIL9xMo/qXUzIc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NwBpp83z2ZLfnQ3RQQlP5Ya1DK2pYYPqM+PS0X0fVv4VBXVL+fgz/D3YZ9tQWCvN72VUqBVmhouwh5BW9wZ5b+Ck88rU6omCIQYqffXrdOa3kenF5iJMIzMkc6YtqrJj6U9UAy0822T00LlY7tvx4Om3k+6X4pF/IEkDdxqrZcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Alwp51ap; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756846966; x=1788382966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=q/pxEE1X+p0pBDUKJ9PQagyXqmtGkTIL9xMo/qXUzIc=;
  b=Alwp51apjvH4+hMq99Mb8KtQQXAyc5wn6CHqY3+rwmcoLQgVfzi4V0+y
   I0nn1QMjP9oE8mqcVACBYGAlz76K7oPjlATN2tSHnsY3e6VFVnz2qPnCM
   4MYNwfbe/tWbgLEyCq00Ebnr//iPBfOSfAWpKCivhXxBgI/fu+vcs4mJG
   f/412XhZZl5TnItv49KnGTME1GUVpxKckJ+Z6qECPK/iKbH9FQg23kEMN
   LcMeDk/R4qNYI9acgeb9dNs27zjxvJ/wlZbBiitPeOZpbelzAyJXXL1Vi
   tGTIsYn4Y35KJ53JHex01mdATrg+/XE31OjpE8t2ZtuOWhtLHvypqKWbA
   Q==;
X-CSE-ConnectionGUID: a/o45EPUQSi77+zRjzt6tA==
X-CSE-MsgGUID: zfgJbN1iSsO8v/15Ah6+VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69846885"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="asc'?scan'208";a="69846885"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 14:02:45 -0700
X-CSE-ConnectionGUID: dVHHo2UmQWywZTboXi64dw==
X-CSE-MsgGUID: ca3hs0qqSZmeVCSZIII+8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="asc'?scan'208";a="202289098"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 14:02:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 14:02:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 14:02:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.50)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 14:02:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jna3UwoN3vcI/4YNXdyIQVOxU9bO/ex3BRXCXnGkm7JkVxXQiurV79zDdMmA1zo4I1bpsQihDRmxUxoGkAOFirbQwoi4AZHT0hOo9z/lyPTY1jGPcJJ/h7QXm/mSOVBzbxRYEpnNtd7wzbqvSVxot/eCJlvRiqnd8fOb49UtM5oNxDpygqREZ5vf8j1w2sJaMn+zjfYUehOpButNiZjvyzT6TYgoxZTa+se4pDTP6bU4YdWb8I+6Rvacdfed0KQt59vKArNrV2uN3sDINn5uWtBZgsdOtZeUSwGWja4gahqMnyH4fAQQkjpqoOWoY3+vhMt4uOQ1z2lr6Gg4eNOHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc7WIMVFQK2UBN6ffIYtRM2bg/CdxY5pAlOPPJCUQIM=;
 b=tXhcyx1OlFv+d5MC1mUvb2g/0PLFwGgYKrz03IGHkFAwL4qwF3VnmCwfy5V4KJfizZNjw4l8iRFNZL1dXBmvHI2lFi8zKbzAOg5Tn5/FueT0fAZ+tRYm8Sv/fATsEvKBtcy7ryICeiV++Un+kOZZEtWN8ISmuHULmUUtNzJn11BnqNn3V1UXgt4cgsYmCJBVeYVhqkxPkwmGR3GaIq/NXB11TyGP+Uh06zigwbQTjYnEVkRZTcmiHWT+Fh1ELs0efIh74NGKd2w6eek7NZ7VoY+ILsobPz7pze+fpFFH4eRPu0dXulv+Koaw2DmOJquRUGruirPxNILFSiELrRWtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB8295.namprd11.prod.outlook.com (2603:10b6:a03:479::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Tue, 2 Sep
 2025 21:02:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 21:02:34 +0000
Message-ID: <26ca1ef9-2587-43cd-9a5c-171cbc8f6080@intel.com>
Date: Tue, 2 Sep 2025 14:02:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: stmmac: new features
To: Joseph Steel <recv.jo@gmail.com>, Konrad Leszczynski
	<konrad.leszczynski@intel.com>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cezary.rojewski@intel.com>,
	<sebastian.basierski@intel.com>
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
 <40c3e341-1203-41cd-be3f-ff5cc9b4b89b@intel.com>
 <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>
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
In-Reply-To: <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------5pQdFmpzlca7XqziCI4EiWYU"
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c4960c-74ef-41cf-9208-08ddea64098d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2Z4Ry93cVRHSjJBTE5IUXFQdHZXTDh5dW5ZbW9qV1NNMUZjU2xNeEh3c2I3?=
 =?utf-8?B?eG9QNlQ5VUtlbjZYOE9EdUoyQjdDcmJxZnFkM01pNWFNbTNoSWpDSFZOUUhP?=
 =?utf-8?B?cXdRTU8yYkJNTWkxWVFPZHI1WDkxdkhSWUdQRklZU2lyMXR1R05pYk9yZXp1?=
 =?utf-8?B?RlUwL04rKzA5Zm9WaEwrdE8vR2N3YUtzMEFrSUU2R29xMmJzazJPalZQK2Vx?=
 =?utf-8?B?ZS84VE5HTXhKUlhvakcrWHhjVlV5dzhBSlZvQllmNmRiSXNxRlhYZ0doWnJp?=
 =?utf-8?B?TnVyVHdPTnBtaEtab3BKRG9sODFlM2N4K3VnbDczUmdieHlFeDFFeUhmdmpB?=
 =?utf-8?B?T1g4cDZjNW10Z3YxWThFd211S1hLaXQvVTc4T25jUUt6cmRtSG5tdnVEY2g4?=
 =?utf-8?B?ZFJKNVI4NDB1SGd0ZmIydWtnTm55eWtoRCtGbjFHanVGVWZVcTBsQVFJNXRU?=
 =?utf-8?B?QTQ1bEJHNkZHRnlWMDc5K1RaSkhQSTZQRmx2RTlaSk51YTdhTVFTdEh0aGtK?=
 =?utf-8?B?NTV6RFh3S2l0cVF2QnFtYjdORjEzWmQ5YVd4MVl4VjFNMGRudU9XRE1MRE5N?=
 =?utf-8?B?S1NRZzN3R1Vlampta1Naa3FTRjRFRlRrNHduZ2lQanMrdWUyNWhSTFJYQ1o0?=
 =?utf-8?B?OHlvRm5Xd1ZNblJFT1JmSEQ3OHNkYmVOT1A0NUhDdUJXa1hNTWk0K2R3OUtH?=
 =?utf-8?B?aFNnMjU0S3duOGF6dXhkTG9Sb2dxQWltM0xucEFoN3dpZW5KQThXYlpoeXA2?=
 =?utf-8?B?YU1jL3pUb0RzN1dwVktXN2YzTWl5dktXeXkybW5wY2JqSVFwUnhxVWtGVlVN?=
 =?utf-8?B?UVg2SjRwa3hkZ01jTjM4bDhGSlF4MWF5QmhZUGlhdC9rbWZhQlNKTTl1ZGlp?=
 =?utf-8?B?M29ZcnpwSUxoQXJqQ1Y4VU4wK2pCSUNwamhtM2tldkU5SEJaY21wUms2VUl5?=
 =?utf-8?B?Vm1GN2lLaS9wTHRsMUhyMzl5Y1lrSVZWNGlPOEJyaFo3cG4yTVRpVER2WmpQ?=
 =?utf-8?B?Q29jdHpoMjJnRkpXYVg4YVY3emV0MVd3MWt2RjFaTU1QRnovMVpVL1ZQU21Q?=
 =?utf-8?B?VmxFK0VrM0NoMm5BbDBtTXQwbStwYnAwZktQczhQSEhQbEFnTG9uNmc3eXM2?=
 =?utf-8?B?VTJ6c1FhZnJCbmNoV0lMQU90NW55WlFoUmVzdjNCbnoxbkVwL2lvQVcxc2s1?=
 =?utf-8?B?MHBLdE1LUS9zS3dwWlk5cGpkb3d6L0hhVEp0Y1RWTUY2TWFWNXJwcHpLbnVU?=
 =?utf-8?B?MnozR3JuckVrRm1tejZrbm90ZnZiYUlNQmZQeVh6am5QU1JiRldEWWQ3d05l?=
 =?utf-8?B?YWZkazJYUVZqS01rMnltWlV4WXFPZzkxN0VQbjUwQjFoK1FzTlgxSTUrL09T?=
 =?utf-8?B?Y0MveWNmRnhrcTd4ZDZYZmFMdTd3WlVVVWtlNGhldjBHVzdoVXdGLy8wMUY1?=
 =?utf-8?B?YXBOZDFqKzBBd0k0YmJ0dE5uVTVEWDhJZitHbENGdFY0TkJBZ1RubDczclcy?=
 =?utf-8?B?eTRiY0U3OVBVT3J3d3B4WmMxY3ZtTSsrNjdWMXNEMVBtTllJVksrd1k2M2tZ?=
 =?utf-8?B?dFZtYlZMcTZ2cUpTWUpUNGh1aUtGR2EzeDh6S3lnVDhNb0wrL2loMys0a2tm?=
 =?utf-8?B?Tk94QWdUeXVGd2oxQXowRUpRdnBuLzk2VkZNV2p6WVdaVktIaTJ4aVJweUhz?=
 =?utf-8?B?aWZSUXB4RGM1anZvQkxEdnpzZU1lZi8vdGxkdDlWdTgxN0JvNlo4Z0c1THBO?=
 =?utf-8?B?eGNVbFRTajVhV1gwNDNEcFNNaGJGQlZNbXZlK1NlMGhNUWNTV1E1WUM0Q2JX?=
 =?utf-8?B?eE02SEhiMUFDdnllSzhpUnl0ZHdpTjd3dHZ2OW1tajhnamNqL3lmSWx5VmxR?=
 =?utf-8?B?VnhzRTFidEdQNGdFV3AzOXlYRjhRcDdrc2ZPN2ltV25MVVhxaUxtU2UyWCt1?=
 =?utf-8?Q?VFM++epWXgE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEFQR0FvNCtIYWQ2c2RqZFpmTTc1WGdPWGVod29kcnNZM2Q2NFI1TVRlNzZP?=
 =?utf-8?B?K0dndjlhbkF4SjJHTUxPV3dwQWJ1U2ZmVFdnYy9nbEdSbSsyeStPOFZNM0JV?=
 =?utf-8?B?U2RhT3doNWpIVnp6VURxa2RDRmxncGFtK1VHd2VuWUU5eGVxOUJjVnRGbWd4?=
 =?utf-8?B?SzZmbU5GQUU4OFVLQUdhTWVWTVlhTXFaTzFMbExwMk1mYUs5YjVPbU0zRzRE?=
 =?utf-8?B?VWdvSFBwR0pxSnJKdndNWTNzdzFobzRhdk13cnpwK25zT0RMQzYwcGt3TFVn?=
 =?utf-8?B?YmozRGtnUlByakVXMFUraHRKRzBhcW9PZm10NWNBbjQ3bkpsZFMxdGFJMEty?=
 =?utf-8?B?SC9ZZHQxRm16d1M2QlhYajNoMFRRdktwKzdsaG5MOHZiVkNBYWZJbUlBeEIr?=
 =?utf-8?B?NE5WbmpPZWFOaVBRMVprRkNaZnBMZWt4dmRXZGpRd1ZpT2w2WGh4NTB2dDNP?=
 =?utf-8?B?MzVhZWJ0MkY3K3NrN2FJRTVzSWU4OUtXL2R2OTFzVGtYZGxlNVVsRmZqSWhG?=
 =?utf-8?B?cHdyS21rVTRhNmRyc0p0aGhTQXBGMnFBWEh4cDVPbjVOTVBxdXRFK3FERzRI?=
 =?utf-8?B?ZG93WVI1SWIxQXRBaWF3S0hzZllqYUhIQVZlN1FrakN2eHd4S0xKRlRzNE5n?=
 =?utf-8?B?TmZPK0pnWCtBOGtjc3VucDNlbHU4bUtaNHpWNE8wdzVRd2JTdWJsSVdsUmpM?=
 =?utf-8?B?UFpsNFp1d3BUM1QxaHN5d3NOdkVBZUFUTm5EMnpyMWd3SGJDZEkzeDExck9N?=
 =?utf-8?B?U2dIYXFKK0tUTGNndHNmMSt3OCtuV0lscjZLbzRJUXhjQnZ0NGpmVlRreVNF?=
 =?utf-8?B?cWhKeEdiS0VFK1lPbFJmcCt3QkxYNE9jU0lCWDA5ek9weGtmbGc5R1gxS1Ro?=
 =?utf-8?B?QjRnSjNVU1Nja25XZVg5MEJObFBkYjVKSlhhc20zOUQyNTIzQXpNV2RvSFFt?=
 =?utf-8?B?MXhyQ2x6OVR1aTJDTU5Yb3RHMHVGb2dBYS9DRjR5Z0Zta0pqVEw0bXJQeXQr?=
 =?utf-8?B?TkNkbFdtU3JNM3Z6ak5BQlg2ZjdpV2tqRWpFci85U0J4R3lVTkRWeDM3RGt6?=
 =?utf-8?B?MG8vNjl0TjFETGRFYVNudXptWHFmL1ZvSEdhRUtGcDZhNGdYNVJkcjRQZ205?=
 =?utf-8?B?dTRtaXhva1dQSjlNMU5GdGRiNFpCY3A1ak80bnVySnZVYTNZNTViNTBoWEk3?=
 =?utf-8?B?ZTA3NXRrR1NzMU5mRWM2bE9VRlNtdkFJRy85SVYxSmF5b3M0WGVsYnorbEVm?=
 =?utf-8?B?T3Uyd2M3NmZaOWJ4TFQrKzB6UU1hVFdSNGVnQ28yam94YW5YTWJURGNiMHV3?=
 =?utf-8?B?OFlyU3dIWWlsaGs4b1Z0Q0ZwOU5DTnBKOHJWNzAxR3Y4WitYUkFkYkwxLzZC?=
 =?utf-8?B?dE1UWmJyVzErdGdSUVNJZUFtcWUyZjRtQkdBRXVDMWxGdis5RE0zNmFRcHNK?=
 =?utf-8?B?RytsVnNSeHlxeC9nOUtmYm9rYVA2bWZXTFhQYlR0SUFmRjkzclF0MWpwa0d3?=
 =?utf-8?B?UzlxVzRHa1BwWDl2dkdCN3ZRUFlaSXpKaXg4TXdoa0tyZUg2bTIrNEYwM1hB?=
 =?utf-8?B?UUQzU3NGOWNxMTBlNWxCU2FlRitCSmFlQTN6bGNnd1ZBcTFXWFZTZWlPQWk4?=
 =?utf-8?B?aHZkSnk0dzduYml5dmtyV0FLQkQ5Q2lCS1lJZzZ6bkllM3VERmRrM2htdHhp?=
 =?utf-8?B?T2Z3cDV1NnJBRGZmblpTMGVnQ25QQ0J2L2dBaTA1NVVHSW5yOW51SzcvdFJj?=
 =?utf-8?B?dEQ4eHBna2ROa2EvdHZIZy91T1dXOWVrYjh6RzVSUFYvaGRmZTJPN251VTNU?=
 =?utf-8?B?cUdUaG80b1ZsWmNWeTFFblRCOGlJdzJwbFJTU1VLQVRlUVhKNFpxUkFzVVFy?=
 =?utf-8?B?UUNWbzFmWGVEVS9NTlJZTTB2MlJZbldNdVhNbGs5WkQwdWFXMWFyeTE3YUtY?=
 =?utf-8?B?K1VmSVIvY1lFNlM3aWVuSGtYYjNIT1N6bExpd0FQbE5YbWRpS3NWbmx1VWJ3?=
 =?utf-8?B?dktPYWJGMkl5eFpVNGdCT1U1dmM2cG1DNEdVS0Iyelg3Tk4xMHJiUktQTnk0?=
 =?utf-8?B?WEJMRVpIMTRjRE05cGdEQ2dUK0dEN0FvZmdBbUlSZnhLaUtscHB5d1RWNHdh?=
 =?utf-8?B?Tyt4MXBoTTVEbEF2WGZWMGluM1d2S2VxcU9SSHpCMHM3Ykp3L2RSeE80UU1D?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c4960c-74ef-41cf-9208-08ddea64098d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 21:02:34.2691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyHnWpzoK8K6VJr8PzgJ8MVs2GFDnyoFpr6u5LlgHZHtYUb7atnx6jEvZMWZCTDFIZLlznENTEdmOfudmEqNcdsTcmYHXDLAU2NLydAGiVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8295
X-OriginatorOrg: intel.com

--------------5pQdFmpzlca7XqziCI4EiWYU
Content-Type: multipart/mixed; boundary="------------ybB3S4IRETzFI3fVd3ctxqB6";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Joseph Steel <recv.jo@gmail.com>,
 Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
 sebastian.basierski@intel.com
Message-ID: <26ca1ef9-2587-43cd-9a5c-171cbc8f6080@intel.com>
Subject: Re: [PATCH net-next 0/4] net: stmmac: new features
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
 <40c3e341-1203-41cd-be3f-ff5cc9b4b89b@intel.com>
 <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>
In-Reply-To: <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>

--------------ybB3S4IRETzFI3fVd3ctxqB6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/29/2025 7:46 PM, Joseph Steel wrote:
> On Fri, Aug 29, 2025 at 02:23:24PM -0700, Jacob Keller wrote:
>>
>>
>> On 8/28/2025 7:45 AM, Konrad Leszczynski wrote:
>>> This series adds four new patches which introduce features such as AR=
P
>>> Offload support, VLAN protocol detection and TC flower filter support=
=2E
>>>
>>> Patchset has been created as a result of discussion at [1].
>>>
>>> [1] https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.le=
szczynski@intel.com/
>>>
>>> v1 -> v2:
>>> - add missing SoB lines
>>> - place ifa_list under RCU protection
>>>
>>> Karol Jurczenia (3):
>>>   net: stmmac: enable ARP Offload on mac_link_up()
>>>   net: stmmac: set TE/RE bits for ARP Offload when interface down
>>>   net: stmmac: add TC flower filter support for IP EtherType
>>>
>>> Piotr Warpechowski (1):
>>>   net: stmmac: enhance VLAN protocol detection for GRO
>>>
>>>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
>>>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++++++-=
--
>>>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 +++++++++-
>>>  include/linux/stmmac.h                        |  1 +
>>>  4 files changed, 50 insertions(+), 6 deletions(-)
>>>
>>
>> The series looks good to me.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>=20
> Not a single comment? Really? Three Rb and three Sb tags from Intel
> staff and nobody found even a tiny problem? Sigh...
>=20

Not everyone will find every issue. I'm certainly no expert in this
driver. This is why it is good to have many reviewers.
> Let's start with an easiest one. What about introducing an unused
> platform flag for ARP-offload?
>=20
> Next is more serious one. What about considering a case that
> IP-address can be changed or removed while MAC link is being up?
>=20
> Why does Intel want to have ARP requests being silently handled even
> when a link is completely set down by the host, when PHY-link is
> stopped and PHY is disconnected, after net_device::ndo_stop() is
> called?=20
>=20
> Finally did anyone test out the functionality of the patches 1 and
> 2? What does arping show for instance for just three ARP requests?
> Nothing strange?
>=20
> So to speak at this stage I'd give NAK at least for the patches 1 and
> 2.


--------------ybB3S4IRETzFI3fVd3ctxqB6--

--------------5pQdFmpzlca7XqziCI4EiWYU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLdbaAUDAAAAAAAKCRBqll0+bw8o6K3a
AQCHfLmrCYKYPZZKijfZP9MwLIpZ7w1vaP9S7Ed6FFUosgEA8xslS+lMtY61l13gtpdmtUEWpgWp
xnAmhlmlGzjglwk=
=0Gkx
-----END PGP SIGNATURE-----

--------------5pQdFmpzlca7XqziCI4EiWYU--


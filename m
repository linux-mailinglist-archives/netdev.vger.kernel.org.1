Return-Path: <netdev+bounces-217490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0171B38E51
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015D468117F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 22:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C20313E3D;
	Wed, 27 Aug 2025 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfM6PYh8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88620313E37;
	Wed, 27 Aug 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333211; cv=fail; b=fhNRWJ+yoW70C3d7RPPb8tvJNkPYbi0GHY1ii4CgPUssOTmBm9PHtAtyiXcuU6FNDcsLylqpEUstaAZjdRCYmHkmnY1MJIRQwfRTlGeiIPbZej6vw6zToNDfXZFyJH2/EDTHazs1Ke6v0/zDazQf7EhtpG5EbUIDMXQlvWOZW7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333211; c=relaxed/simple;
	bh=qZW7VKcO2Yob4yhD4avKBftJJtH0cRnq9QAxINj61RM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gnAYaT9ra+GAA9Od96C5HfvIPwPJhS23rUYiNoMDng0a/9POg9PWPRX1/Ccuxc+t7U2nqdvy0farFH5/QnbksntW7hcwJKpb/8v04+i5z+jhL3k4WFj8nMSKUbROfdQAPrd+/BRShKVddv42h+jGGwxv5HVdW19bxrlfaeN5Wdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfM6PYh8; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756333210; x=1787869210;
  h=message-id:date:subject:to:references:from:in-reply-to:
   mime-version;
  bh=qZW7VKcO2Yob4yhD4avKBftJJtH0cRnq9QAxINj61RM=;
  b=gfM6PYh8CiOxd2yLlFF7HlBx0EIANaSFMUCrR9EhOx2Mpi9NHqgr8YCX
   Xg17m6YtnMrrVojXeGCtqiQ6y36ULnON9Oam3tBuuu2whtU5lg0zF/ki+
   CxuNMZXNZ9zG2DsBXm+Vpb6ipSFt3Z0z+V9Y6r1uElW4v2txG5zBuelan
   MZTiYt+q6JUk+iCsa7ErJ4YEutayHTxQdondCV8jF2aXUgr7YvUJ5hhL8
   wX92wo23TL3W5rf2tNsRZQMMzhMU0u0E0NfKzqNKl4YKl1ecbsVx4Gsae
   Wo7Z/nDlq05cD9gHKKF9QOU8iFAPhnCqsdf04jMjfLddhZyPolRf7OTAk
   A==;
X-CSE-ConnectionGUID: W2puStLuRSaiPspib7LlPA==
X-CSE-MsgGUID: xKjmJcFARN+9qbaaXC4Sug==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="62238242"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="asc'?scan'208";a="62238242"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:20:09 -0700
X-CSE-ConnectionGUID: zWHg5RdzS66to42tomTqFQ==
X-CSE-MsgGUID: CY/mOJ7rTrmv01EsHP3F4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="asc'?scan'208";a="169468186"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:20:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 15:20:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 15:20:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.68)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 15:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mN35R/z0tLq64+4YMOMMyw4VpZqpD6SdlYaML9CQzdLJdgYaFphuqbq92hhkQNN9R7ACTG+nQ1cIcaMNDlP3K5wGiXqrN+nnRHh1xRu48ia5rKQl8tI3yFZUVvf7nVF+FTdzhjR2hSprtuY/SdjJa58TG78Zhu4EIdAJBcNqvk9Ga6Byr2BRnbX07pRDDy9W0po99b6fNNIVTOd1+aWbMVQc//V6FVuEyCuz3W6jwpRAkiUiUYW+dI3JYrJek91lFP7nzUByDYpoCIDFKDFFG4GCXKm/+PtZK+AaWxPCrNYmuj9sf299lJm8zqscA55++kBsTYHnGELoAK1QGJBP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A+YrdYADtZ3Mx0tk01s+KA4lwufg3FaLHFInAZqveI=;
 b=ykbyyMJF5l7RPf97eyZr+2ZRY526LG/YjzvNW/QwOGugX1nXXsEmJ8AhiFdmuA+/sECyH/IVxYc2ctcAVTHc0TQLHi00s560dVJlLVko7dvel9yhl2WITfTeGyGoW8sbRYa+jOrLNo5BAIzYKtoH2+jthdTXCAATzwfO3k7h6pO2nVUZkg+EWB9RJx7RZGxCmjNBiArKzUlHgfZuGY3WV6UTX3vw0UBun5B5WggIHOcrlTLB5KOdJ3wp/hXFhZEYLIbpanZk7YzXAlMImZiofKkPdNBswHPKSY4AIO8SRO/M7uHlVPnebI9yT2rErUsJn36jiA+lLIB1YICL0iBnsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5021.namprd11.prod.outlook.com (2603:10b6:a03:2dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 22:20:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 22:20:05 +0000
Message-ID: <47ed10fc-4445-44ba-be79-dc90b7e7d0e3@intel.com>
Date: Wed, 27 Aug 2025 15:20:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd-xgbe: Use int type to store negative error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250826142159.525059-1-rongqianfeng@vivo.com>
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
In-Reply-To: <20250826142159.525059-1-rongqianfeng@vivo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------PSgSFcDMtighMmt3o16V00W2"
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1539c6-ce64-4da5-57ef-08dde5b7e01c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzNTSmQ3ZjlEV05tck1wWGo3V2lMc2t0M0hqcHZ4aDBteEJORVZBM1hScGVN?=
 =?utf-8?B?SFY5MnZOUms4UDRBSzF3czF1Yng0b0FPV3FBTCtlMHRITGxuY084K0RpSjcx?=
 =?utf-8?B?S2QzS0VFT01EendPZUJubjFXTjBobytnb0xLREx4WUdGc2JZV2RwY0dQNVpm?=
 =?utf-8?B?M3ppelJDMmtMdmpFeHhCZTZrWDFwVUNrK3hLeWdleDFJZGh5b1hQTnJZbnJm?=
 =?utf-8?B?dXdmTWNXRFlNUGpaMVp5K3UxVXVQSG5Bd3ZiL1lwWkFhS2JsWkZ6N2ZJNjV0?=
 =?utf-8?B?cGl2Q2VRdkdoSk5MTStKYUpCMUVkTXAvZWhIVW5US0ZHaTBETmU4L2JxakhX?=
 =?utf-8?B?WUJSMGkzV25nd1pMRG1hMy9rOEVFc0RtUFlMb0RVemN2NmQveTRsVHJ4T21C?=
 =?utf-8?B?VUhLMnE2dzNrZ2JnUUFSL2Q3Q1ZnOTZnMFFxbm5UUkF6UmJ5bjZVTjFmTlZW?=
 =?utf-8?B?S2REQjEzY3YyNGdUalg5ekpHZVErWmZWalAvWkpseVh1anpxN2w4bStNNDdL?=
 =?utf-8?B?NkFPeSt1ZmhhSWg2MTFoekN1ektWd3RzdDFKK2pQeHdGOFBPc21sTHYrQUlv?=
 =?utf-8?B?NFJoNDl6ek9mei9NUTNQeC9YT3Z2bUtha0EvWVpFWEx6Rk8wVnM5bzBXYmdT?=
 =?utf-8?B?Mnkxd2FaZ0FyM0NScUY5R0g2TG5Iem44UFpWOGhneTQ5WWxkVGg4NGRxK1Vj?=
 =?utf-8?B?RXRIbEk4Q2t1NEkzbXByS1pHTVc1SHgxRTRUdWRKOTh5N29yVEtVMit4bXZT?=
 =?utf-8?B?UjBMWUxkWThaeng2UXk0Uk1CQlhoNHpNRXYvb2tjRWRXUy9wWnNHM1o5anFj?=
 =?utf-8?B?cjlxTmQwSGZaU3VJSTIwWmI0V0RzZmJtbG8xamtaTEpNTnpkU1JTamErRmF5?=
 =?utf-8?B?Nzh2Q1IreXJGR2NCd212ekJQM3Q2b3NDK1VxVk5NdDRNRWFHeC8zS3JtRWMw?=
 =?utf-8?B?U2hla2hxNWZlVHVhWEVsNzlGMThqa0wzck1vY1hTbnd0TDBWTFp5SHpHVnZv?=
 =?utf-8?B?VDhvaEhDaEg2N0QxOVBraVhXM1NzdlJPWGJFOEw0T29wQ2hicEhkb3Bpcllj?=
 =?utf-8?B?WitNRmhISkN5b1FiZUluYlFvVm0yZlBFZ1d0RGxia0hWWkNteXB1S0xid0ZQ?=
 =?utf-8?B?VCt6YTUyN1pwSnZOTDJWRkFiNHhLcC9GVGxicWRsMERZUlVZK3BQZGJ0RDdH?=
 =?utf-8?B?VUpZVWJSL2w2azY0V1VBOHNBRjBodE10RHFscnNxSklDSGtyY3FYZThXbm81?=
 =?utf-8?B?SHpRdzFDWlZDZS9nbHVxY2NYYkdwdlRyZUFyVnZYM0ZWb0RFZ3QxVXZXOUxj?=
 =?utf-8?B?RGdJdXFhMVpaZ2NHYVZONTdmTjlqNzQ3Rkw4ZEpsVFpTdHpyRHV1OWIyUkEz?=
 =?utf-8?B?Z2F3TldFcjJGWjVnMzc3TDNSMURmczhJVFhISkRhT1RsVlJVaVluN3U2UFZw?=
 =?utf-8?B?L0dVRXpQdkRSbmhQOFZ4bWJtNHBYMTU0eWtpYW83b2FIaG1GOVRjdkl5ejEx?=
 =?utf-8?B?OHQyUUFQd0RBUys0YmEvQzBLZGVLdUhydmdUaGRESlFxWEJMRmpvaWtubDNW?=
 =?utf-8?B?bkhReHBSWVpzSy9CMnh1aFZuUjNocFpST1R2WjlIczFNZ3RUNGxZcUI3c0hl?=
 =?utf-8?B?bjI3eEhkNFRpbTRaMDZ4T2F1anBvL3liTFNXTytmQUZaS0NJSE9weGRyci8v?=
 =?utf-8?B?cU1BMFBjTXBFa0V4MGhsSVFGN0VONnlHSkdEakhOVHc4Q2xqTUJFemhTRVps?=
 =?utf-8?B?RG0wZTZuWEtodHpTUGZpREY1bDRUNkVrK3dxUVNsNUxLVDhnZlBhSUVaSFdr?=
 =?utf-8?B?MGgzRGpEZTlWMXlvbUFjNi9YUUt6eGN2UldDdXZNRFFKTVF5cjVDajVkd1NF?=
 =?utf-8?B?SE9WcEtwNWxYNWF3a3pjcXRkdEtLS2hOdzJFUmVqaTltNEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkxDd2VLMHRodzZvMVlyN0JFdmNoblkwWXFDQ2MzeDF0NlQ4RGRiM2dXK3Q3?=
 =?utf-8?B?K1A1Zm8wdnBtUUtqNDRPSm1vRHNqd0x6dTM0azk5aDV5eXZTMk4zaHI5cXZp?=
 =?utf-8?B?YjJHbWYzcm1QaVhmc1FDQlBWTXdUZmpFbkRrTnUwd1MrdG1NNzBjMHBrbkhz?=
 =?utf-8?B?OEZoVWxUREVwNTlFQ1RPb1hiTEp3Qjd3eGd2OGlLRnpqc3hwWm1oU0RiYzFS?=
 =?utf-8?B?Ny8wR1h5eURyMmgrT2lVYm9jY0RjTlhKNjhFMHdMampBNDhxbFkwWUtyRDg2?=
 =?utf-8?B?MUI3SkVJL2JIcHFLeHJZQzd5S1pxN2lrS0V0Wm5mS0NNamVLaGgyWVk2TzZP?=
 =?utf-8?B?L01pYndlamJnaVVLYXV0eUdmQzRHZ3VXWFh1UktWcnF6T3JqbitLL250OUdt?=
 =?utf-8?B?K0hpZjBBZ255U2dKYWNuSTJzT3FyOS9ZMVFabS9tNlNtTU12SkhUbmpNUE5E?=
 =?utf-8?B?aitOVDdhbGttSUxEWktsaVpQcG1BbHZaMXY0NmJnZ3hKWXZmWG02ZHpaSlMz?=
 =?utf-8?B?RzZBL0J3TDhlNS84OGoxTzRZMTB4ZlN2OWpDSytGRHFDZ3ZZRXV5WkZQSmVh?=
 =?utf-8?B?TFdkVmc1dVJIN09FakVlaEI3VE45anRBSFVEdW0vMkhkdTBVejU2UHZjaWht?=
 =?utf-8?B?WXlmaVM0Kythd3pmcmxpTDVDaTBkU0xnSGxZanExWmt5aWFENjNYa3E4bjds?=
 =?utf-8?B?NlVIUnpYaFlMcnByL2srM2hBbXdKYk1qUnhIbzlUbFlZa01lNFBWTEVaY1FR?=
 =?utf-8?B?RFh2YUVOSVExdVFqVm1JaWx2WTFKQVgzK2hUZUluWUtGblAzSTExNHZvcXRJ?=
 =?utf-8?B?TllhaG5lYTBBK3BRd2hsdVJJbTF5VWtQOWxzYW8zVnR2OUQwbGRvZXhCc3NE?=
 =?utf-8?B?Kzh4UmtFNUFEUUQ2ZzUrWklOdEhyMkVOSTVpWVRnTGdiMnUxWUV0b2YzNGtH?=
 =?utf-8?B?S2VrREN5ODJlaGYwNWczTzZCRlhFWGRUejJWMk9DNFlZaE02eDRUM1ozWCtW?=
 =?utf-8?B?NVJUQU5KSEFMYlVTZDdvdXF0THc3dTJQVG5FYlNSb20reUFnU1Z1MERWTnVQ?=
 =?utf-8?B?OFdHQTdIa3lvWHZBNDVaNnpXVC95YnBZa3dyQXcycGVnZUpjMTZYdnpuS2dY?=
 =?utf-8?B?UHlPQWtKdC95Y2JjcUpRRXhXdHZHcUpKbzFSdzdNTk1FdU9LblRnVWVaa3la?=
 =?utf-8?B?MU01K2lXVVlDVm1UUXVJT1A4L0dIVHVhNzBOMjJQMUlnelBraFNocWlLU0V5?=
 =?utf-8?B?eThwZmNRNHpWK2UrTkp6YmE1YW5tdEx6NEZKYnk5NC9pWDN6a2VnQytnQ0gv?=
 =?utf-8?B?cU9tQTJzY2tvOXBKUTQ3anhLQ2xSUzZWdXd6M2hFd2FDWm43aXZPcXhmTU9Z?=
 =?utf-8?B?eW41bjc4c3k0VkhIQlZLbC9YVm9WWExRNE9JU2Ivc1B5bDAxU2N1RmNxdHRx?=
 =?utf-8?B?bHZPRHZ0UTdiRGZRZHgvUk95N1FTYWtvRjVSb0RqWWVBSTMzenJwK3UxR2FR?=
 =?utf-8?B?ckRnUGUyTlFrdW1Ed0NwNHBsRERIUWdZZWk5bHdOekxoVUtQUHE2WGZPbWFX?=
 =?utf-8?B?QlVLT1ZQdXB0a1JqWEU5UVQ0NW5JUEFTN2drbXdkNk5YU25SVUNkZDQxNXNx?=
 =?utf-8?B?TzdzN0ppT1gwMEk4MjFsN096aFNTcml2dDZseG9YN3p1dUozZ21BY3ZUanpp?=
 =?utf-8?B?b3NnNHY5Zm55blpML3ZsTTJHMHA0TzZFOHVQQnkvOGtWdUpaRkRaSzB3c1ov?=
 =?utf-8?B?TnNwRHFGMFNHY1JTRFdKQmJaUEVITDR6b05jempXVnd4VnIvT3RCd3k5N0Ro?=
 =?utf-8?B?SmQ1ZXJrUncyczNTOWFDa01YWGluVUFTanRkbmRwR2JzK0E2SlJtWUxncWgv?=
 =?utf-8?B?MnVobXovNG5GN0t6endQTmw1MEt4SXVKUDI1b2EvM0JPVWt6V0ZnR1JpMlgz?=
 =?utf-8?B?c2k0a1dQbXYrZTZCb3ZNM01walk2czRGRzhIS0FWaGt2aEh2L0RDY2ZVUGpu?=
 =?utf-8?B?WE5HdVR0QUVTc0FrbjdNMjFJaUxVTVNqWm9ySmo5eTF4WXV4WHpzTk1ZQ20z?=
 =?utf-8?B?SUdxV2p0aTcrTDBWbDBsVGxaQ3IzZ3Z4aEEwNnpzbFVickowZ3gvYW5ySVhI?=
 =?utf-8?B?Q1NIZ2JDblg2ejA4bGpVbmdNbkF1TVBqTDEvOEtFZUEzTWI1T1ZiVTdLZkhU?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1539c6-ce64-4da5-57ef-08dde5b7e01c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 22:20:05.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tn48kZYWe0xh+zPQc2pLLDx7DzH8tmYBfUqWdX4GXYsMKFW2VGl1IIDRLExJrtDrFNh2NYo0iDvqlDjKBWeZpwoh0eQ5gSbhjO3EeLn6uU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5021
X-OriginatorOrg: intel.com

--------------PSgSFcDMtighMmt3o16V00W2
Content-Type: multipart/mixed; boundary="------------0CctkyZl6gcZL2AdlE6kDI1V";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <47ed10fc-4445-44ba-be79-dc90b7e7d0e3@intel.com>
Subject: Re: [PATCH] amd-xgbe: Use int type to store negative error codes
References: <20250826142159.525059-1-rongqianfeng@vivo.com>
In-Reply-To: <20250826142159.525059-1-rongqianfeng@vivo.com>

--------------0CctkyZl6gcZL2AdlE6kDI1V
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/26/2025 7:21 AM, Qianfeng Rong wrote:
> Use int instead of unsigned int for the 'ret' variable to store return
> values from functions that either return zero on success or negative er=
ror
> codes on failure.  Storing negative error codes in an unsigned int caus=
es
> no runtime issues, but it's ugly as pants,  Change 'ret' from unsigned =
int
> to int type - this change has no runtime impact.
>=20

Right, unless you have some sort of signed/unsigned comparison of the
value where you check for ret < 0 for example. Since you just assign to
the local unsigned ret, then return the value as a signed int, this
indeed has no functional change.

> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 2 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-i2c.c     | 2 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net=
/ethernet/amd/xgbe/xgbe-ethtool.c
> index 35d73306a2d6..b6e1b67a2d0e 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> @@ -464,7 +464,7 @@ static int xgbe_set_rxfh(struct net_device *netdev,=

>  {
>  	struct xgbe_prv_data *pdata =3D netdev_priv(netdev);
>  	struct xgbe_hw_if *hw_if =3D &pdata->hw_if;
> -	unsigned int ret;
> +	int ret;
> =20

Looks like this was there from when this was first introduced.
Interestingly, that very same commit f6ac862845bb ("amd-xgbe: Add
receive side scaling ethtool support") used signed integers for the
called functions that assign into ret.

Good to clean this mistake up.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------0CctkyZl6gcZL2AdlE6kDI1V--

--------------PSgSFcDMtighMmt3o16V00W2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaK+ElAUDAAAAAAAKCRBqll0+bw8o6KGu
AQDif/EtQJgsjUxUCzHjHYa1QgyG6MKm4bEB35K0WL/E/gEAnvgMqbkaSb6c2Oj21bOraeI5IvSl
JWn4yhboC2gGeAg=
=U9Ji
-----END PGP SIGNATURE-----

--------------PSgSFcDMtighMmt3o16V00W2--


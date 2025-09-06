Return-Path: <netdev+bounces-220513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E20B46772
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30ABD188AA4D
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF78C79EA;
	Sat,  6 Sep 2025 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQm4gKXb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393605661;
	Sat,  6 Sep 2025 00:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757117762; cv=fail; b=Ql6fO5vAeOHPsWOuywbBDaFvQyA+IZ0cIloLHWSh/DHkn9wg++okmebfEnyvns4hk3YKdCULppvHXZy4cZq8MJTG+oOMAA1oltDIaJ44eXFAT59SQagj5kh+YpqY3Ui8VXH9sCaw2HRhy++7o+8ZgpAIcYxBMR/wpHtkm/A80+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757117762; c=relaxed/simple;
	bh=8PR24WKKAMrXaRF5X19BivhMBmFB4feBleqXhrA4XTQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U4MXpTiJGs8936doklsdhsW/8ip8VlrDfWVpzQ+lnKWIS4Y2FjRUXywVKlFPbQ2USbLI18rkfzny9euPHIO6ZLHlybDw9qS6qMdUvBxHRszyxXFeXrz1TZPH6g3v5SkTv2iooLcHjUk7pJjJfRKV9lU+UJ6KMfgP126U/3Sr3NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQm4gKXb; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757117761; x=1788653761;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=8PR24WKKAMrXaRF5X19BivhMBmFB4feBleqXhrA4XTQ=;
  b=NQm4gKXb8kE8ye5iSFHOnMj/X76M5c6yLBn9FjbdqS0qoG0TAmLwDRjU
   Yy6bAoWTaC+UewLI9EiG+4XBLvpILt70Xy8R3gsHCd5+tLBkbrCR7uUKL
   JBswn/hezBgDHWeUjAUjD+UUPdjDiGtwYK9CKJYTAOORTKgs1UvEbPRPF
   ftl8heFGdGR/dqcZYlgwV0fIZ8ViENQ6JZ6Bq/eHE3W9t6toY8W+xPi6K
   vi/HT5DZbZEKUyXA6bzF0GsYhg0Iy03eFO8QUnxDAni2dOFl+QPTEt2bV
   ZN78cI2UVKrY64OYDM3POxwPPnkq9AWd/aTnlg9CUeAwrx40x/OVm6iXt
   Q==;
X-CSE-ConnectionGUID: qNGyYIt8Sm+6GP0LQz0qdA==
X-CSE-MsgGUID: MSp0aS9pRbutFVJJNOZWag==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59618765"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="asc'?scan'208";a="59618765"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:16:01 -0700
X-CSE-ConnectionGUID: 7vwBjxyHTq6f/H7h+7zFPQ==
X-CSE-MsgGUID: Xd36cnAVS+OHS7juuCzFug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="asc'?scan'208";a="173096319"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:15:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:15:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 17:15:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:15:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgeCjaimIVrP95PO8hpLV6B+UMtJgXRoXEh24MMklnTvGlN5abZ02zqxhyqok3/E8/d8WlJiyBh0pMTOYBe97UOaTOzLnDVnDhEgDIrc9WK3xlIwJJxRPN2G7KEDTj4/8xABvoDQMPEu6iq8P9tGOKT3usHqI92rmf38iCslDuOMzrMDzwxfFs0sl9p34xAhzSTqmpgWF2GF/DhY+wUwcJy8FNXPNr1sY8NIyGG04x1XrHaZvuTb8LV2tzI+8NwLuKyuxiYSfqJiQXJe/nvlhwRoY+VkE1aZFWPAljKXpMu4JY3JultMsIccoPF/sCogdTxENECB0kFqzoLG1YrmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7CyyAilrcrG9N+BM/r20++qdVd6R7xw8axfM1nGm+E=;
 b=pTvL8hADTINDwZu1sFr9kt7CYsIDj4b7hPGZGEsNvIOGR3zJ11lTR4jO5G9KjthisRaSValPnfVAHg1mur6pMXqIrLb/Xn6qJATn8c0GqEsLZX79enXz16EColYzIMEv5KY8sG/3w9fm+J2D7UCDVbPmmgbJrb7FRAcvhpEmPosyCuioDeNs66VmtlUgtIAY1fqe/KGUPkd8sUDeK401R/MyHkrZNK+KbW2URWUoi8P/v9OEZQz/cndVqSylzz1WTHhYrUPbyS3YpVSLuert1o1mkWduPg4f4Q82fx2LTruHN9lZcUTgpT0lc+3q2yZiA+sqxoaZ2Z134EH/QeO5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6372.namprd11.prod.outlook.com (2603:10b6:208:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Sat, 6 Sep
 2025 00:15:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 00:15:56 +0000
Message-ID: <ce56614a-28c8-4536-8a93-7e5c08e72e13@intel.com>
Date: Fri, 5 Sep 2025 17:15:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/11] tools: ynl-gen: allow overriding
 name-prefix for constants
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, <wireguard@lists.zx2c4.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-1-ast@fiberby.net>
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
In-Reply-To: <20250904220156.1006541-1-ast@fiberby.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------pw5mSewBd5eOfzClay3vr4ev"
X-ClientProxiedBy: MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2387e7-bc21-4255-8ddf-08ddecda8c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3RtQUVMbitZaFF0Y2Zzc2QrK2ptRmdaazNiNFdYbVYzWms3eWFVM2dCOEd1?=
 =?utf-8?B?b0FFRUpwOEVxV1E2a2xCVnRZTWdhazVFYnBuaUxKajZCQjQ2Z2NPQWxFWWNw?=
 =?utf-8?B?dTBsYVVBL0VkYUZUa2JYY1Q3Wk9aL0JUNXhPU3J3WHhoK1BWRWd6cW1KdXlo?=
 =?utf-8?B?bTBiTVI0enlZOXVLclV5ZGFaeU13dUVxbWVGYTVjOXpjaTRmQ0pONmQ5UVhX?=
 =?utf-8?B?bExiSllQSXVaM1kyM3ZGSTRXdjNaUzEvUGV2WnBoeWRoL2g5Vnp2akwwRDhh?=
 =?utf-8?B?S09zaTBGb296Q0NsM1l4UnRZN29pNGpNWHJBN1IrQnVwaGpteCtFellsNTNw?=
 =?utf-8?B?QVRENUtGS2cwWWtsclpJbkpQZ1Byc1hlOUwxcFR5RmR1OUtoUDZoKzhraHFw?=
 =?utf-8?B?SkJFUDY5UDM5bGlSeXJWb2h2UFpnTU1rbno4OGxEZ3hRb3QxbzNEYjJVRG8v?=
 =?utf-8?B?bGhrM1BIeUJ6a012M2Y2elNzbE1Od0ozUmEzMlpsK2J1UUVBbjhYS0lZaGZ5?=
 =?utf-8?B?SVZFaVVhVkJxeUc2V1FOUWhkZHYwRDdBblNicUNwQnhyaXI5alNnYlhqVVAz?=
 =?utf-8?B?d2lHbkNsWEFOak9IZXBRQUl2K1paVmk1R25GVmNNVUtac0NOcEhxZ2hjaUNU?=
 =?utf-8?B?eHZkdm1OTk50OVk1cGlpZXlZRzBQblUxWlV6VVQ5VXk0STYxMnAzdTJmL0Mw?=
 =?utf-8?B?UnB3QUl2RitvQXZUbWtNSHVvMURvWkd6U2Rjc2wycHBSWjAwYmNQS1dYdVJ2?=
 =?utf-8?B?b3A1S3gzc0t1YkU5Qm05NDNaOHdnemRLQUdiQWNxcStyeTVvZGpuZGV6aDFr?=
 =?utf-8?B?Z0JlU0p1cFNPUy9FTU53aFo4YUVtYzAxZ2tNWEhQaDNHUXBnTGRaT3d1NlZn?=
 =?utf-8?B?MCtZZWtlVzcvZGUxVnU4VTFSdktUMG1GdXpQcm8wbzdMa05ZWlp0WmhoUUc2?=
 =?utf-8?B?d0gzQWJnUlRyMkl1alpMVWMvSXl5eThNR3d2RHdiRm1tVjlMR2wwYU9vTWxi?=
 =?utf-8?B?U3VTUlRLOXMxdEZuSVc5SmxDNGlsQW1kTk9iS1gyMWhYbXdkVWlRVHI4OGFM?=
 =?utf-8?B?NnRlbENWR0Z4U2JYemxuVG9DOUVFOUNQYXpRUy9nSmJsOVBhVjBOaXZQa0Jh?=
 =?utf-8?B?VXRoZ1FqQ216UGZzS3dUQWFvcjJ1WjNnVUx5UzYxSDFWT3BScXJwc1ZmblF4?=
 =?utf-8?B?K3EwdkxDcG9CNDNvN3ZFeVNLaS9UWHF6dnRuSmhtUUNnMmV4VktMUFo0cjVq?=
 =?utf-8?B?MTBhRUlZUU80U1VnT254ZTREa2tOcnRoQkZpdW9CcTdqdlNDL2NhdW54Nzh1?=
 =?utf-8?B?b0ZNMHk1MXdGa3ZsdWJHQlUxNld6V3hraE9Vc3FTT1hVdk5hc0M4U2ZVNWNo?=
 =?utf-8?B?T3hYM3hTblNkeGwzZkhTZVlQRnpTNEFqQ0VyRFBCem5lY2dxSTNabnhXR2Ry?=
 =?utf-8?B?ZGNQV24rUldPSm9EZ1dNQ0ZUTlludEFTUGFrYkg0VEQyek1ZdElocklCRDhE?=
 =?utf-8?B?SzlGMmNRaGZmWU9saU5aemdEQjVpTzUrbXl2NTBMQlp4UWVTNi91VFA5T2Uv?=
 =?utf-8?B?cFZqcStHNFNvd0w3YzU4Z2RzMnFJbFB5bWdLOGxlenk4eEJ1WGNMWkdCNG5R?=
 =?utf-8?B?cEdBWldLWDVzd1plTzJJa0RsbXFsMzVEbGdTME1lSG1KejdXTGEwNk1NN3hq?=
 =?utf-8?B?ZVo2V2dWVVNVNDRhN3hKeWtiV0dKVDVVTFZVUnkrYjNBbE8ybytYejV1SFVE?=
 =?utf-8?B?YXcvdytzdXBQWHcxb3AxaWRMdjFZM1ZTT0VBeG8xdUlzUUpTZTd5ZmNYMDRk?=
 =?utf-8?B?V20zMDNYR0hKbE5YVTZ3RlBKdnBrR1dLemNORzZDejg5Z3QrbFo4blZsa1ln?=
 =?utf-8?B?RDA0WkNQNG10SjZGQmtvS2dmVW9laTdUdWZ6VHdIZXRPZlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eThxR2xwQWJOY05QSHNsQXllNVBuN2xySHZ5bEtzZ1FxYWQyQzc5ck9yTUlS?=
 =?utf-8?B?ZWdQNG0zODZaZTJLQmNNTFhyRElNajU1ZnpCakZRZ0NZL3F3Uk5OWUdxOFBt?=
 =?utf-8?B?bFYxcXM1b3M0TE04elNORysralA0bllZR1RPdU5lTThibC9HQzczZ29sL0h3?=
 =?utf-8?B?eUd6bUVvZ1JlK2tONStlQjJWS0dQSGMwcU1ZNjh4T1hWSDRxYlI1dUR4WG9i?=
 =?utf-8?B?NWQ2R3RyVkpRV25sYUhrNGVqK0kxNmxLbDJqQ2FwV3lzSDhxNExqanZhajgx?=
 =?utf-8?B?ZWkxK0E0ZWtQRjB3Qlo2MmU4Sjk5cHRvS3NyTFlLejZGR2ppY2xSWDl6bTls?=
 =?utf-8?B?WnRzdzRxS2tSalRLMkpEd3JxVjZIL1l2NTdnMFRxZUNLeFV0N09BdlZ1R2Fp?=
 =?utf-8?B?aDQ4NlZqMUJBSlk1U3NhQXIvNVBkemVPQ0FHbTlqOGxiNGdUWjhBWVRyQ1dR?=
 =?utf-8?B?VGpyLys3b2tMT3ZETTd2dldwdWhneEYvVjFVZExRZ2NVcVlLT1FHV0hTR2lO?=
 =?utf-8?B?ZldvdFVkUHhXYmxlSlh2ZG1ZZnViNDhNTnhMbVVLN2hZbU9SSmhRU0FQcVdp?=
 =?utf-8?B?Wk9QZ1dJZ1VkUDRjS3dWNGphZGQrTW03K1ZlTjJ6OURrNzVnQm1CYlRSMFV2?=
 =?utf-8?B?NUU0N2c0SjVIbkI2Q3pIUzVBbGZBSlJCYnJ5N2JkaGJVb01rSE1UN2N1eU1l?=
 =?utf-8?B?Qkc3MEcrSlpkd3diSzR1SGNEVWc2TUdXT0hoYnRYTCt2OGNUSGhLNzFXeGts?=
 =?utf-8?B?TjFFdG82V1Yrelo3QzJJTGoyZkVFVkpkTDJaY0lBdEd2My8rZnl0OStWNWF3?=
 =?utf-8?B?RXQ0TnVYaTdDcXYxUnI5WjFFN2hvbXhCdkxLa1lWOFo2MG9PNkJpL1I2Q1ZS?=
 =?utf-8?B?OERYK1kvMVFWUEJ0Yy9tTFpMeW5rV3Ywa3ZJZVZ0ak1FMmxTN3AvejdWZ01P?=
 =?utf-8?B?RDVISHk4N1AvMlZpSmFvUlQ1SWdHbjVJS3R0MGlia2tqeFY3TlFwRy9TMHkz?=
 =?utf-8?B?RnFZd0d1YWl1a2JTdVd0cVB3UFFGbXRDOVFVMHpBN2xEYWI0KzY5TDUrMlVL?=
 =?utf-8?B?OWpiMmtWdHRFNHlYZ0hUbWVMYkQzZWZyWmE1OStPM01qQ2IvaS9IQ1hzVEor?=
 =?utf-8?B?TEc4dlg5TkI5OTRtSGVHbTQzaVExS1hhR25JKzBDaTdzVGlWa3Bka0JncFpl?=
 =?utf-8?B?ODVXUEt1ODRsNG1wUGhyanljOFA2SGtySStQRWoxSHd3QjFhQWhGTHpLenU2?=
 =?utf-8?B?TS9xODRMZEd6akp3UXFlTERudEdkcm5ta1ROZm5MUmpsbEE1eUUvbGdXYTQ1?=
 =?utf-8?B?Si9oQUgrMlVWaDFCeVFaMHRmY2xSOVQyUFFVUHVpbWFmUUQ1dndtRGkzUURU?=
 =?utf-8?B?QUhLWVJQeWtNdGNOeVdzcE5sRzNJWDE3dnlxTzRCb2ZRNlBsQlM1eXU4aE5m?=
 =?utf-8?B?NSswSE1RdS9rSG9lbmlvc2dVcVZUL0V2dmt2aDlac0RzWlMySDRnYnU1V3FH?=
 =?utf-8?B?NmV3bC8xQ214Z3UyZm5QZHlLMTlRWllVbjl6NlJqTkdsTHpxdUhRcC9hR2pp?=
 =?utf-8?B?K0lWcGs3Uk9lN3VjOFFlck5jbWlTZWRwaGJidVJuVTRnWmZ1V2ovTGZDaGg2?=
 =?utf-8?B?STh2MVZIV0VJZU1sWjdwZEppQmZqZmhKalY0TjhoY0xVSytaaE9FL0dSZHg0?=
 =?utf-8?B?TDNydFROdE1MOU5ad1BFdU1lRWRsdFNMTmI0ZVZobU50UjVKeHI2WElHRkVz?=
 =?utf-8?B?OXRlSDNOUEtnMjA1QUdDV2hWMktqQmwzYVh2b3pBT084OG41dVNQcWxVck0y?=
 =?utf-8?B?dTkvb05QWWsxRmsvYzMrT2xNWFJtckNkckpZdWwveVdsV2ZRSGVnUEl1KzRT?=
 =?utf-8?B?cjI0MlFGRzZlWGlGVzRXUmlua1lkZ2NIT0RiSDVvNGtweWNZRmZRbUh3aWJx?=
 =?utf-8?B?SlhVTXpIbkRPYVFLL09zaHFsK1Z2RHdtR25tNTJKamJ4NkpDK1BHL3dCaGcy?=
 =?utf-8?B?VS9JTjBZRWlacFBRck9rd2JFTit5MEFDMmlaNG4wbFhtaWNTQUh1c3M2VzNJ?=
 =?utf-8?B?QmpmdzN1cGt5S2hDZUs5ZUduVXNLVHY3OFJlMWpTR2pZOGttU0RhUjNoZnJU?=
 =?utf-8?B?dHhrZk9pOW1HMW9HYmUvQ0dDR0xxTm9ZNVhNUHVYOGhQUGZhRzBDSWhZcEtT?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2387e7-bc21-4255-8ddf-08ddecda8c6f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 00:15:56.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wO6lW1KoKk5zH5rK8KCn13I8rv5UvewUcmRVHEd1k4pxmK+5Oga1TleuNqi+g2gymRRNEhg3J1WaDmhXAnGqoTBEZaD7PoFVwh/o9KKYM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6372
X-OriginatorOrg: intel.com

--------------pw5mSewBd5eOfzClay3vr4ev
Content-Type: multipart/mixed; boundary="------------QwagqNu0QhW01SmBCvWmrThI";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <ce56614a-28c8-4536-8a93-7e5c08e72e13@intel.com>
Subject: Re: [PATCH net-next 01/11] tools: ynl-gen: allow overriding
 name-prefix for constants
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-1-ast@fiberby.net>
In-Reply-To: <20250904220156.1006541-1-ast@fiberby.net>

--------------QwagqNu0QhW01SmBCvWmrThI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/4/2025 3:01 PM, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Allow using custom name-prefix with constants,
> just like it is for enum and flags declarations.
>=20
> This is needed for generating WG_KEY_LEN in
> include/uapi/linux/wireguard.h from a spec.
>=20
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl=
_gen_c.py
> index fb7e03805a11..1543d4911bf5 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -3211,8 +3211,9 @@ def render_uapi(family, cw):
>              cw.block_end(line=3D';')
>              cw.nl()
>          elif const['type'] =3D=3D 'const':
> +            name_pfx =3D const.get('name-prefix', f"{family.ident_name=
}-")

Previously we always used "{family.ident_name}-", but now we get the
name-prefix and use that, falling back to the default if it doesn't
exist. Good.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>              defines.append([c_upper(family.get('c-define-name',
> -                                               f"{family.ident_name}-{=
const['name']}")),
> +                                               f"{name_pfx}{const['nam=
e']}")),
>                              const['value']])
> =20
>      if defines:


--------------QwagqNu0QhW01SmBCvWmrThI--

--------------pw5mSewBd5eOfzClay3vr4ev
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLt9OgUDAAAAAAAKCRBqll0+bw8o6EtO
AP4kRMLoZ9IsZ9gNTJJCmsVfLXG88fr3WBJQ3v85bbvXrQD/ecmtR5X7YggvGUmcPt0nG+fCw8Ud
ECiZxKu9f4gZEgo=
=0Fcv
-----END PGP SIGNATURE-----

--------------pw5mSewBd5eOfzClay3vr4ev--


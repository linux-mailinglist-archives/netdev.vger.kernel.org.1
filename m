Return-Path: <netdev+bounces-218380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FAB3C418
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 23:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF2DA02EC8
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64B92877ED;
	Fri, 29 Aug 2025 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrrkLhRQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD520B7F4;
	Fri, 29 Aug 2025 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501828; cv=fail; b=ZQllq+f/D8IYgriTyYqdh8DgxdBAKx8Rmj/hKzBJU63hGbNAFt/p4LPCVopq3A7v4ATySaXl32ILyKZRvN5UzVvOeRUlQllnzW/V8NrC0JCor17OIruHuYGTQKkp2uNUPs2E2T7ipzqu3ztA6Qr8v9CRKzpe6LL5Cz5PUnQQeT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501828; c=relaxed/simple;
	bh=g6zHeCKBRXJ4EjvwrceDtHW/e5JO97yJtuWXeGG5oqk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PO2pt2kwwoheaSQsy7uNQNprvnhMv7l7Fdn1l7l85sq8aTNrlDu4ficVR7qriShw750f49XQy8KGTISp/tsot8XH5TVZmpKaKFWruHt7J06mqNI4TqdtzXMDUtN9lPpsGuzS5/xeWblA8sXEtYvCqbxz0b75VpnMbyBXM7Q5nw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrrkLhRQ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756501827; x=1788037827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=g6zHeCKBRXJ4EjvwrceDtHW/e5JO97yJtuWXeGG5oqk=;
  b=BrrkLhRQ2DVI0+nC18ltNRi4H6CHPZ1fTUesB7zyFij5OMol7YWCd5t/
   04cMUOvL/Z0PrBbfC3CnPosmPHwrD/KceG0P78HjXD8aaSAywM5dodcFT
   LpgrhjTrMl5LdYVRngmrwCR4bPt9SdpQa//wm9fm0xVg60D3kTwuEzAS5
   liHyVC/gHCz5+sNGKHatg8ESfPk1rZXlrqNXresgi95PGfVDHNRdPYEhB
   RLUJvKlvWHq07zvGRrFybdnYpq2IEgPhivJUpMirgW/PnFB5itsve1J+m
   Rr6TBfWJOxQKmJB2LVvjLTudtD5hr8uvv3ep3eYO3slMWgePyNpZU70Jr
   w==;
X-CSE-ConnectionGUID: kuyQJETtQPeLEM5pWijoqg==
X-CSE-MsgGUID: rBfVPGweQvWuvzP73ptwcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="46366285"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="46366285"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:10:26 -0700
X-CSE-ConnectionGUID: JIrfwdLXRGu+kJUnIWLWDQ==
X-CSE-MsgGUID: Oc43JlZ1QfeM0vOjErtrTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="174643815"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:10:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:10:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 14:10:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.85) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:10:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnYKjdhC6d0OR1NsZ2RLy5qGNJGK/LpVfbGvSZ18fJEfNHbLJMgjFU9s4Kw1M9KLDLL+J+0MNCCvGS27+5AXt3Ko4j0VSEWfSsGD2A4vFODry7CsW8OQEegleOVrKuSXKaw9QQhziA7mBfraoY0RLbjDXZJcmxPMVLUcz1VraksRkUGuPauHyTP/adC8+BUJ893wkU7oPzzknM0fs3u8YLvlD5seffspxyYNfFhbu+y/gr7UsSwL3zo1f/kLEvC1kh/7BXI5TKPtOl3vDrCpPfMAOFP+C8dzerGOOGDBhbaoBWnqp0k82YIjt/h0sahXBrOdqcV5x8y9DFQg6A4Z8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cql/4EpC1O6q0rAHDKk8tDBDUN/VHlTKvksl6r5/h4I=;
 b=vT9pcjUrOVCniE6i/MWfs1PXevGO6cTJLveg+mzrsWq4p80daDPi1Su2TN3BFEIgm+RPLSRV389pGQEgr2typp/JL7k9eFIDgMF5parkixydiPQfytpptP4TH9Xq2ffH8VSTQALB1yngTNUAAXqZmrFyT7mGBbiM+yxlYsqxZFGph4luF05C89cCTyvdfK4Q5qxSl99ye+TAbwLGKwvsHe7zUxNsHAkhzYMfNvdg7mb91tdIpoABkK5YtXHG583stjqrPFNexsa0BpCWgFEVUvIVewNiq/vzuoQamwhO8CaNNv9rRiOIcBtAaE0Ly2MEmibIHp/CwdjMroLBB0h3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6903.namprd11.prod.outlook.com (2603:10b6:510:228::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Fri, 29 Aug
 2025 21:10:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 21:10:16 +0000
Message-ID: <bcc152df-a63e-4a65-aa39-a17b2d6abe2f@intel.com>
Date: Fri, 29 Aug 2025 14:10:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Convert apm,xgene-enet to
 DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>, Iyappan Subramanian
	<iyappan@os.amperecomputing.com>, Keyur Chudgar
	<keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250829202817.1271907-1-robh@kernel.org>
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
In-Reply-To: <20250829202817.1271907-1-robh@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------gQH9j6yvjQl0EUrWsEAVNCdu"
X-ClientProxiedBy: MW4PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:303:84::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: b39cc2a3-ab2c-4bf1-1e13-08dde74073ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEFoSC82WFpZSUdvZlM2WE5rYllHcHJLUzE1VlBGK0Y5cXdYYTlNVE13Z21i?=
 =?utf-8?B?N1FYbWhtWUVXa3RtV0F0ZjYvQ08vS3RlZllGMTh2VXEzTE92Wks4R0NqODV2?=
 =?utf-8?B?ajRDMmVhY0lPYTZveTl1SGlGRUs0SHR5Y0R0OFJRcHVtb2g1enZPeTl3Smtp?=
 =?utf-8?B?cUw2b1VxNFAyOG0rTzRVeXEwTnBvZVN4NEZiNzBONUx4aFZEcmZleW1tSytG?=
 =?utf-8?B?R0tERG1oNHQxandmWGVxNWltTitsWnhPdmtJYXFwTHVsN2hZSklwV3RaRU80?=
 =?utf-8?B?TkJldVlIbWRXdjNERnEzRGtWeTQyc081bmpienRDb0JkcGhRcXFDZmk4T21H?=
 =?utf-8?B?SEVHektQYWVYbEhibHRyc0JSUUdibFpoUGIzME5pVUNKSEVMR3duKzVPQmRz?=
 =?utf-8?B?b3Q0Y1NiRHVUcy82bktwYi95VUJ4emFhOWlMYzB1Z2Rrc2VZc2Z0Q204UElQ?=
 =?utf-8?B?UG0xcGhrdlFEazFiWnlld09aV2ZkRTZOTkZFRVFqVUw0MDYxdlJ6MVZuUlNh?=
 =?utf-8?B?K1daQ0FhTCtMM09jcDB4ZFNtVVZWR3ZsQVRYNWtXOWMzRnBBN0x6YnoyZW9E?=
 =?utf-8?B?Z1ZUVUl5VXdFRGx0OHVxN0YzOFBteGxZZ0s3NnBuR3FOZGNvWXZtVHZDcXJ1?=
 =?utf-8?B?VXdVV2treS9HTGFtSUJGY1pyVXpsS05nNmphRWVnQlFLcjhzRzljTDdlRHF5?=
 =?utf-8?B?dTl1ZWRzVVhFTDdjZFBpTXVDaHY2QlEvK1VmczI3c2FFcG9ZNnl6Zkt0SHZa?=
 =?utf-8?B?cnRsb25SVXRpcHdOTDBxcVdkUVJ6QzBCUzNpZnMxbml2Q0xlQitWU2o1em5k?=
 =?utf-8?B?Mnk5SEs2ZXFSU005NWVGNGszcHVVUERUZS90WkNkK05vK285SFZZYW9kWnc5?=
 =?utf-8?B?WStWK25hTkhiV0tIMDE4enFtby8vaUcwUXJpOHRuSlQwNC9TUWdkenB0bHNY?=
 =?utf-8?B?dmM0Q1RpVGNoMjNnTk1ESHVKdHNjYm00UGYwZE9FbXR3QWVvcFZ4dm55Wjdn?=
 =?utf-8?B?a21uUW1DSE45RlZGMFQ2L21obEk1L08zNjZSYi9CME9NaHFkait5Zit6WmRH?=
 =?utf-8?B?ZlA2c05mSFFqakxrVVZLVFZhczJiWDl5LzA0TGRyKzFJUDROaHZuZUlXck8v?=
 =?utf-8?B?dHpTNkNoaVhrMTkrczlDaVNGektkYTRGcjlaM2pGWWlKVGxtZ3BUUk9RNWJK?=
 =?utf-8?B?eGJqVDFob1NRcU5heTlqeE0zemhKanp1a1Y1T3dCTGZXZkMzb0NPbjBLZlFQ?=
 =?utf-8?B?Z0NSK0kraGd6bVNlUlRkOXQ4bVByUzFoRUNkUWlNVllvWVA2cks5ck5JQUxN?=
 =?utf-8?B?b3BBZUJPSkhrR1l6UFlVUzJIa3VIZldwVnpJM1oyT2ZQdWhaaXdPUnJmNWI3?=
 =?utf-8?B?QXZraEpWRmF3MlA5c05OajNjYzNGRlFiZC9xNnFJOHljbHVJcENvZko3REYv?=
 =?utf-8?B?cmtWYVQ1T2tocVMrUFRHVmRwa3FQMkNzMi9ySmhGbERsdXpvSktQZ3JPRGs0?=
 =?utf-8?B?M1Zqa3Q2S3Ixa21hSHdrQUkvd00wbUFsN052QjZEZit6SXBpNDh1UzQ5Zk1L?=
 =?utf-8?B?aktGMDhCd2Myb2J3eHNCTm5tZUYxUVZ2dThocDJoU0dQMnhLUmg0M3h3WWFs?=
 =?utf-8?B?RVJSaEg5QjM4eXUyNDQ4Z1B2cjcxNDhOZnB1dDdtYmVMcGNJVVgxeHhybGdJ?=
 =?utf-8?B?elR0ZDdZM1JsUVJOTUxGQ0p0d3BGZWo4ME5Ld3FHSHpLMDhpcFNyaDA2ZE5a?=
 =?utf-8?B?cTJuSXp4MWxjWHhjNEdGb0owZk10dVl5TTM2enR2QmFQM0syWkxTZFpPeFk4?=
 =?utf-8?B?cjNEU2RSb1FZaUMxbm1JdFhiWnR3M01hRC9JVzBPWnBCSHdTSTRBTW1RR1hJ?=
 =?utf-8?B?SlF0VkVOYnJnQm8zbnY4UVczMkIxeEJjdU1Kejl4ZURrR0dzb3Ntb3BiS3c4?=
 =?utf-8?B?V2pxT1drdWphbXI5OEZBRmVmcVUwOUJGQVNPMUhWL0Fxb1krMVl5c2RIOFkv?=
 =?utf-8?B?WTl5TTcyd1lnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmdoaTZvS0VBalJteTFKd29RdGlxb0wwVER4ZEpVWVV5VXRpWVg4bE1Kdms2?=
 =?utf-8?B?aUJnQlNNaFFxWDREL25oek1VZGF2Y3ZYcTJpMXFXeEpQMXl6dU51SlA5ZnJu?=
 =?utf-8?B?SWxFS0ZtVkcyaVBNeVE5eWVZWE03b3VMS05CbjNBbStrMUNCankxL2Q1UGtj?=
 =?utf-8?B?cnBaSlZsd2pDVndqeFc1UmlZU0U0c0gyRzFDOERkNTlIY0pOTStMOWhkUFZK?=
 =?utf-8?B?NXFlZU9iSEtOeU8wa2RnZUtVVzNSZGZlbTBhbXNTaldvSUVkOTQ1alI2UVo2?=
 =?utf-8?B?M0Nxd3ZiYkVQWnBsaDdOb2pncEN5WUlSNzVqeTJIbnFKYmxLYnM1UUlNeEkw?=
 =?utf-8?B?VTVoSkkvbWNkQWZ4dTYyeXBxTEQ4YUlxeHFrdmhLQlRnS2pJYzFvZW50bXVG?=
 =?utf-8?B?aVVTY1pQVisydUFTNGhBU3V1L2hhekJnRWVRUnhMQWJJRUFTNjFnR25aR1JC?=
 =?utf-8?B?OUtaN2pQeXBuV0duZ1dTMy9VdE5HcFdyMmtuVHZZUXc1RTRTc0ZZMHJUSzEr?=
 =?utf-8?B?dDMyWVNCNmE5SVIzK1RIaWQyVFNKdDRhdFR2b21HcytjVXhPWjczeEVBNk1N?=
 =?utf-8?B?UDlMM0l2WWx2TEJCbUNSdS9EWVdsdFVPYTVlSFBwei82clFHQ2FzQzVKRjVW?=
 =?utf-8?B?UjVzM1VBakVoNXpENjRvcTJIZ1ZxZEZUQXVXV3BKZy9DSnJkQXBVRjJuNFFB?=
 =?utf-8?B?Smo4cWUwQmg0Uy81RXA0Q3c3UTNhN1B1ckpzZk8zVC9BZnU4TVpYVkpjUTlK?=
 =?utf-8?B?Tm1BMmR5ZWtEVFRkMlRHeHgyYmZVMUh5Ty94YlhXcm55S25CQWlKZFYzRlNE?=
 =?utf-8?B?d3B2YWhJMTRHQkdIUkRRc2JWdDhJV1A3REsyeHFhYkN5WGRMMEU1OE5ZaTh3?=
 =?utf-8?B?SUJJWnFRamJtR0QyWkJiZUw4Mlc0cXovSm5BbDRLSWczL1JCaGNLaDJyNTNn?=
 =?utf-8?B?aGRkWDNMeSszRys0MU1FMVlobHhKNzA5QTFGeTAzN1ZBVUFRNWZEd215dG4z?=
 =?utf-8?B?M3IvSElRZUUvalo0ZDNPWGhEMUdIK3Q3SXN3cnNudTZET3VUNzV2L1d2cXFp?=
 =?utf-8?B?R3BBL1pUVzd1NXRWWHRJWVBGblExZnE1MFA1UC91TFM5dXFncjJ0dHpOM3RW?=
 =?utf-8?B?eVF3Q0NSaHZBWkszbWEyVEwwQVNrUVFEOXV3ZUw0dTdWZ05RUGEySnlQRjVq?=
 =?utf-8?B?UnpaaW1tVFNkRnpGMzRPb3BqZ2p3UitVVnpaNmNsa2RBRmo2TnZNQkVzT1RS?=
 =?utf-8?B?SFlVdkRZQ2lLY1hENmowNEJ0TWFnZSt5SEVickJoSnhzZVZ3cW41dUYreFhC?=
 =?utf-8?B?QWhvV0NGcS9KbzhmRHFkU3pJRkkyQ0RNTS9yR3VFQW1zcEpQenR0cjlLQWJR?=
 =?utf-8?B?U1hRWHJ2UEl2UklzdWxGVXY2cFczL3NFQUQ5bHlJdE55Vm5TOEtVYUxkcjNj?=
 =?utf-8?B?aTVwaVgzWElub25MVi85bmxRcmVwQnBIUmxIZjh1c09Ja0lsVXBmRkZGVUVi?=
 =?utf-8?B?T1l4d0o3SlRJVmsvN3ZVbG5qM3pvMWdWQThNcHd3TnZLaUIveXRacWkyRTdE?=
 =?utf-8?B?MmhCeHpGRSsxT1ErUXdkalZVS0FJdGc1TTBHdXI5KzV6bndnUE5hL0FQTUdl?=
 =?utf-8?B?b3FMZTRHd25rQjNWQmJjcWE3TndkL3FKU29tWllkKzBIaEFUSTRoTzRlSmpa?=
 =?utf-8?B?cmRPZE9SUnRURzVvUE0ySUJZeVVOZUpPNGE3UFhBRnpGeFQ3RFR6aWFLR2k5?=
 =?utf-8?B?aFJSTkVNTnhxTW1UYXVtSGp3UWJnODFyT1g2MVBaaS9PMmtoQVhNM3lHN3ZE?=
 =?utf-8?B?aDFySWZEdXNGR0E2dkhaS0MyVjhCMDVqWFM4RkdpV2JpZ0lERkRzWTNTTU9s?=
 =?utf-8?B?NzJCU2t6V3ZkSHRDQXF4QWdkTEZidUQ3TXl5RmdBVXd2bzJ1SkdIb3VPMWk4?=
 =?utf-8?B?TE1zTUpPdEhaby96MlZ3MWhtQTBJVlFmK2JFL0cyZU03cFc5Ui9rRVEwU3hS?=
 =?utf-8?B?d0ZlNEtGNjdDRFNKNWwwSzNtMU5wMFNwWDlyemN2YUxMdEdkaGpjWDVWRnBN?=
 =?utf-8?B?Ujd0ZllHVnRSdzI4SFJwbEpBQzA5Qm8yeTYwNTlSS1NOSUhWTDlaRnFJRFlm?=
 =?utf-8?B?L1Z0K0ppQjR6cXRnb01mR3hKY3p4ZmZTcDF3cWpmWWk5MWJhUkE4anVsTGhK?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b39cc2a3-ab2c-4bf1-1e13-08dde74073ed
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 21:10:16.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3xZYKCF94AVCHa3N+73ixrsYdifN6FJMWgSPrh2xj9tifQzgBpvXqToKGq84tExVAwdDXsnZwgnLqv2YSPlwen5AuO4tvrP40i5nOONZMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6903
X-OriginatorOrg: intel.com

--------------gQH9j6yvjQl0EUrWsEAVNCdu
Content-Type: multipart/mixed; boundary="------------0QUncWpKRbpI70WK2Dywd0pU";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <bcc152df-a63e-4a65-aa39-a17b2d6abe2f@intel.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Convert apm,xgene-enet to
 DT schema
References: <20250829202817.1271907-1-robh@kernel.org>
In-Reply-To: <20250829202817.1271907-1-robh@kernel.org>

--------------0QUncWpKRbpI70WK2Dywd0pU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/29/2025 1:28 PM, Rob Herring (Arm) wrote:
> Convert the APM XGene Ethernet binding to DT schema format.
>=20
> Add the missing apm,xgene2-sgenet and apm,xgene2-xgenet compatibles.
> Drop "reg-names" as required. Add support for up to 16 interrupts.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/net/apm,xgene-enet.yaml          | 114 ++++++++++++++++++=

>  .../bindings/net/apm-xgene-enet.txt           |  91 --------------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 115 insertions(+), 92 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/apm,xgene-ene=
t.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/apm-xgene-ene=
t.txt
>=20


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------0QUncWpKRbpI70WK2Dywd0pU--

--------------gQH9j6yvjQl0EUrWsEAVNCdu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLIXNAUDAAAAAAAKCRBqll0+bw8o6Kt+
AQCAVmo2VDCYhxunKHBzwneyQSpCjtIAyXBBfxgUIEFyKgD/W4Irtre/6eiRSBoagdnjyaKttdRP
aeGzJ0FXTRRCHAo=
=ehxo
-----END PGP SIGNATURE-----

--------------gQH9j6yvjQl0EUrWsEAVNCdu--


Return-Path: <netdev+bounces-234144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F066C1D240
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A43F189F0F1
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60E93587A1;
	Wed, 29 Oct 2025 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMtctcTL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1685E3546F4;
	Wed, 29 Oct 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768482; cv=fail; b=YfgqJQcDfW9V43Vt6o56tPumB3h/w1ZJvBm8Vmc4bb+Lsum0TXFzX20p1pK9czMhHRECUDZ2CFm2793NNeLofIf8835RUmQ6pVvJLa9Q62lvg2w6kdoaPl7IMFTgTY/ZtPGjEHxkLIu1LlsTV6U6nJVADq/ttM3GU1gUbl8wWOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768482; c=relaxed/simple;
	bh=zkjTliTw5Gkyuu/y2+IVqkYaUdy5jmVGkM5+wyEqdto=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ddJoQgUI58ON4vwgybe4PBmotd5O7nmAeE2SfMLHL8wQfV+22gquW+WhQ45YAD3JjxbZXL2N0WNgfRHSyECTpaS9IVMOZbvW9KPxRCqZjtvWAcGPwrTvRuPxQsK/Ti6U6uXIFfacXxkFmUYXmtVVFMZryOTlviWYin+7vEZu3LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMtctcTL; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761768481; x=1793304481;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=zkjTliTw5Gkyuu/y2+IVqkYaUdy5jmVGkM5+wyEqdto=;
  b=CMtctcTLTulQnY5IvbRLv4X7YSa2VlSTN94fhqTkhqcl2ytnxxfyxFR0
   wsLxYERAaFE9uBZ1D47pivG4ySq4tIVI5gxFr/XJHtzSt/SG9/MfQrBVU
   iPSMxYltIaSahguYy090ja43zEhC14IPMSjUIUdgY1C3uahd8Lz7d/ldo
   ssw73UW2D/Fz+oJyLO4t6NZ8OyX2eLYK6pPG0ot8oAJhqIpRSiDi9FTck
   Lka8qeshh7/4TjIg8yZZhRqfwjE6t0gWrS0D7tpugH3lGihp1D2GFdrZe
   SwXC2QE/7wWG/o9KaWaMONkUZJQMV+UrdKcZ4E4N1r80Oa4jl22QKQhgO
   A==;
X-CSE-ConnectionGUID: baHPTG1pTOaBZAKaBvNr2Q==
X-CSE-MsgGUID: OcNINHVMTZWtt//32y30dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63940073"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="asc'?scan'208";a="63940073"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:08:00 -0700
X-CSE-ConnectionGUID: kf6VsBLDTFGDbZxacYEo3A==
X-CSE-MsgGUID: jLByVT8SQJm34kQUHm/cNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="asc'?scan'208";a="190120052"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:08:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 13:07:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 13:07:59 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 13:07:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGfM3b4pWnEPhdk1muoQtGlxcMOP41zNOsn8XND9vi58HwPCzJIDsy8i9kQ0g9h3T4e4RHqr5pYHlTxFmRMiEuusXJvmIeI8h1QSl2Y5Ly5muuxoUvjxYEwZhIlAsmgYixY/S0obV/zu52a4QGSBMkzJ8VuL8feAbAlYezrruZtvFp7B/a5bvts2nFUcgWF612TY0a8w6StfBvSJl6OqZLsZAbM4/nMA0Kn6Ufe/DgfaS/CJagX+zN4qvDGk15q22f2M84WnXwi/R/44VV2jowMFxi0gFZsJliD3J24FEZAoTs33tqLoqvG289e/ZlTo30Mb00Ji3DtKaHPX7Cbvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrnJzhLgobT5Os0aXgjYZxFZ0xekf9NRM5cQa5zn4Xw=;
 b=N63WSB6n/z/SwokUYMi73erc69ipTsIl1EFcCzHV+7L2HvjPrlokmhquFe4XSdtwBru8mKZxJzjjgXSwnO/dkPKeGBgfk8qQleuzspGaHfDhZvt582/DDtPLqmePQ19heIemWxVvsEWmRPlM8V2cz/2kvVBm1vaKI7mfjshg4e1UwmST43dg3XWYVrIJCCl0IEafbEiOLV90tO6u27AVmVLfRh21LvsSxP+ztD00fozyv+GLZU34SClLark2r/GCoKIfOa5Vg7DXTrVWFJJ5Doyw8fZrGuO6/27Y0e5OhzF6YvgU+dJOCI68s+ICDAna/1ajPWk+IElfeiGszplE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 20:07:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 20:07:56 +0000
Message-ID: <68a4b852-4eeb-4f97-af2a-58714b59be97@intel.com>
Date: Wed, 29 Oct 2025 13:07:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] net: ethernet: ti: netcp: Standardize
 knav_dma_open_channel to return NULL on error
To: Nishanth Menon <nm@ti.com>, Jakub Kicinski <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Santosh Shilimkar <ssantosh@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20251029132310.3087247-1-nm@ti.com>
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
In-Reply-To: <20251029132310.3087247-1-nm@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------E3pF8tRUX0G0W28bhprvxcH6"
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 49de2d8d-a2c1-4adb-64e0-08de1726d9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mjhqeno5cjFTVTdzWUoyWTk0YnFFSDFKeFUyUzhWL0VFemRZSW9QTWhPQTlG?=
 =?utf-8?B?UHRwRWVPcWJOWmlOb05icVhya0J1UXlrVmtRU2dqdkJlenRXY283S1ZnUVl3?=
 =?utf-8?B?SFlialBOeUZvV1hJSmpmTUFMTDV5cklQQW40V0ZwVGE5SkRNQTZlMjlRODl1?=
 =?utf-8?B?ZzQrN0lOWk1KalJuQ0lydWRkRU9zQ2ZIdEoyYUdIYzRwcW44WGtoTVowSkhD?=
 =?utf-8?B?SEtzMURsVmVrWUdVblEvVmJHT2ZXWFJRdE16ZXZELzN0cndMemRqb1hQNjdE?=
 =?utf-8?B?WmFONkcrdXdTK0FySUs4VnRGYVhmcC95UFhZRWlyNzNXT0FISmcwaDRLL2hv?=
 =?utf-8?B?djI4MUVGN2RQSDExcy9PbXdSb01nZ2RvZHU5WmJ2YWhIcFRCS0ZMTXZuQkxN?=
 =?utf-8?B?cHM5ald3MTBsWlVJdkIvYmpyVUY0eXBSUEtudTN0V1VZQWpTdTllNFZlakhN?=
 =?utf-8?B?bktTVGFyWWhWWisyTTRCQmx6T2ZTU3gyTUtScE5WTldTQ213ZDZ6WUt2Mmt3?=
 =?utf-8?B?cks1Q2JtYnJYVFYvdVVPVzVlLzl2SHllZUJjVVpSMlRzNFhiTlVwc050bkhY?=
 =?utf-8?B?OFBkUkJHNGdZUG9kekpSSHVFQ09Ma2h2NGRnQ1k0MnU0a0RNaStVMnlFSmNJ?=
 =?utf-8?B?WndRdFFVZjE1ZytidEZjK2F0NTJjbFNRV3ExKzQ5aVVNWW5pbFo5ZGdvME5p?=
 =?utf-8?B?OW0yNkZNR2UrbnROcnZWMmg1emdzREtKRWJBbUZYemxvdldDUEJzMks1NTdN?=
 =?utf-8?B?czVLRVJ2UHJySFhnbmFmemovRW5TYzA1bnFaelZpOUQ2RXN5bU82S0lCSkd0?=
 =?utf-8?B?QldEaWxFS0tTR2s4MG5Bb1p3ZXdvNlNSTkQ1SSs2ZFhjZU9xT3pFNzd5dC94?=
 =?utf-8?B?RGVBU085UVFRdWcrVTlqeVppQ05tc0ZZRjYwaUxEcWlnNU0yckYwQkxHd0pr?=
 =?utf-8?B?WHB3RTU1YXoyVkVXS2ZBUnN3UTZZYjJGSDRmVU92ajRjRjFPbXp4Z1hjUW0w?=
 =?utf-8?B?SUVkejE5RTZxSTlNTk9seVpwQ1EvT25tSVYwQWJmZFJiSUEvaVJ6ejFMb0N5?=
 =?utf-8?B?cXVvV1hTdlpjVHlQZHpxbUFtVlRER3EwaWxPMSs0RjBnZlR0TWFBVTRUZ0xT?=
 =?utf-8?B?OVlaQnlOdnM2ZC9XOTJDclcyU0E4USs0ZGo2K0daQm9FdlFTNy95eU5KeHd4?=
 =?utf-8?B?bWt4bi85M2xOMG4zbzhBZFZpRzEwdGJkdDd0N2Nqbmk4SjRiRkRPTTYxUzVa?=
 =?utf-8?B?VVZXWGtpekZ2QmhsSGsyNVRHZlNLd3ZESGNRZmYvTHNCRFhRcEk1d29FY3Fs?=
 =?utf-8?B?MW9HV2ZrUFlaQmFRbFA4K2lBSldkRDdneFlwRlZrRWdhWXFiWlJVdGJVUjFP?=
 =?utf-8?B?Q3ZocGlyV1hoMTliZEw4TGtPeVJISjU2enVoYng1WUhScjlGbkNrRjBYRUx2?=
 =?utf-8?B?SUMxNDczRjhEUDFxdXB3QXRGTG9pbE9VbTVDREg4dEJYd2RUZW1JZWhGa0NS?=
 =?utf-8?B?Y0VEV0o5TmlOZ2Fya08rWjEydElGWXpvdmlIK2xvUXQ1aklvQUU5OFhGZy85?=
 =?utf-8?B?OUdTR3FvK2lZckUxZHZnakswNDY3V2U5R0t1TXpyZ3I5Q0d5anBNK0RsOGVQ?=
 =?utf-8?B?M3V6dll3RW5lcHFRdk1vRkFWR3ZTSk5hY2tFQ2JwelVzVkIyb2xXd3RZRXhi?=
 =?utf-8?B?MjBpNnFlM3NIL2wrc3FaWmEzVUNPaXZBa0N6Z0IzV1BOU1loVFAwM0hSTTFH?=
 =?utf-8?B?aE5Vd3dpTy9CaDYzd0NBMjFqRE55VzR2V3ZyMk1BdWNHSFR6SWRmanNsSk5n?=
 =?utf-8?B?cjQ3dzMyNlBaVGx6Uk1DQTFaa1FZM0RiZEhMaTdRYTVpSlltS2dCOHFUMW0z?=
 =?utf-8?B?UU13N1BCMmxQSHlsd2FEVXNmN2d4bUJyQXgvUG4yTmg5bG1IYTlVZWJ0b2kx?=
 =?utf-8?Q?i4BVDKjB21a4mwJR5DTspaLKAcRQZiCj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VSsvcDFHcnlyTWV4bDhtU3l4WmptSW5qeUM2SlpEaGNqZmN5TnhQQ2dzMDQv?=
 =?utf-8?B?RFNYdkpFTUJiR3kxaHhoK29QdERoek5GKzZjUkw5emlidTkrM0xLa0dPMTQy?=
 =?utf-8?B?OXhWQWhPbGpYU3l0N0l5WTBuQ1pGVUpIRkFoSXRzQzNQTFliWmtSbW1IVk5j?=
 =?utf-8?B?SHdMb3Zjay8ybXZUc2tQS2tGUURVREthTUw0NFErWFljTjR5UDFpUTQ4Z09G?=
 =?utf-8?B?SGdOTHlrR0NGOURPR0E2R0Y1MmRHR1pXWHJoZVZsMitIMTBwaysvcHNlMkZs?=
 =?utf-8?B?SllIMUJDRDA2b1hjNmZ3SDJOWFV6dGNmMmJCcDZWaTE0bkhPQllhYmw1NThS?=
 =?utf-8?B?MzR1cXl5Qm45Qng5T0t3NkZEWXovTnNTMFhTcWRZNjd2N2IvWHdpeTBwVjFj?=
 =?utf-8?B?aS9EN2JXS1FJZFAvVjdOL1U3d0NYYTh6Y2l6UWFsRFpHL2p1N0dvUmQzdWx3?=
 =?utf-8?B?b3gzWHN4NlJMZWg0ejhXTWNWM2Z6b09jYys4cHZKUFRDci9XRXJNc0ZLWndU?=
 =?utf-8?B?RzBseGhqRUdMUEpLOURBYXVJQW1RVXhrUGF2S1FJSDdqcEZnNHhTblYxaVBo?=
 =?utf-8?B?emJpNGdPcnNrUzNoRkVxMWdHcXhadURoMUVpUjlRTG40SGlSMjZpVDIvUDhr?=
 =?utf-8?B?Vkk5QnNuUnl2ZldUSmVDaWIvQnVZVlNieU9JcHJGcXVjQ1BtbzU4SjRJNHhD?=
 =?utf-8?B?a3I2eUFkUGJQS3dzMERuaC8wdklKaHlkQzJQZ0VPSHRLWUZMQWt0VEM3RXA2?=
 =?utf-8?B?VTVUOG1WMytaSDk3UnBwdXZtK0RSY1MvT3VTOWZGcnVJOHE5eGZnaDR2Q2VJ?=
 =?utf-8?B?OFN4T2trS1l4bVQvYW05c1FXYkdnbFlRTVhFYlFRT205SW51NEhUQ2RmMTdX?=
 =?utf-8?B?RFpOam43TnpQRWxFcWVmWE12SHd2dGNJUXpOb3p1czBZaGRKQlI4TlZFWmhm?=
 =?utf-8?B?UVBXRFJCSHRUQUloMHRkVGlYZ0JzU2dPQzl1MVduVEtiUFlIa3hpYUw5QUY0?=
 =?utf-8?B?SW05TTg2dlBGMGxVVkFuakpDMy96OXUyMWkrZXc1aC9tbjdvMGoxVGxEdklk?=
 =?utf-8?B?RTNPMmNiWFZXU0FXS2FJeEh2SXpvUEQzcWZ5OVkxUUVlMHRpMXBFZXlvQUlS?=
 =?utf-8?B?anUvQTJ4RXBiM3hqL1FMdjB0K0pENmQrYTNYSUZjMGZqelljTXp5RXVnSGcy?=
 =?utf-8?B?UGZjQWErUVM5NUdhci8xZDdoaDd0eWFQc1Q5M3ZhMHJNR0ZtVzE3amFKNDFn?=
 =?utf-8?B?alR2bTd1UTNnRmpOZjM4bDd1UHUxN3NDSUUwUzIxbmRaRXVPeHFhUEFhZU56?=
 =?utf-8?B?K2w5bWFRQW1jUzBMTDRBM0p1ZVE2OVFWb1JFdnB1U1FPRExKcFdXTXZWalhQ?=
 =?utf-8?B?ZTZTNHA1ZWsxZG1aVUZlOXVMN2pnem44NURnOXFMSFdib0NtRXgrRFAwVFhu?=
 =?utf-8?B?NkttZklwYUxqNXhjUG80WUptU1ZSa1VxK05xSmJuRTRxNnFHQUxxeWdEdlly?=
 =?utf-8?B?S1U0SFcxMWQzd01vWjNsLzNjVkc1RFVwQTdUa2xOZ0FkR1NFZUlvVVVLY3Rh?=
 =?utf-8?B?MjFQaVZJdWN0U3dkOUhDdFdpQUVLN2FORE5zQmtuTDdPMCs3OGY2TTI0bUFN?=
 =?utf-8?B?M3NVc0Y3bXB3UkowUGhaUno3RkJUY3RWTDdqWHNkbVlNcEJnRkVTbmNQbUpx?=
 =?utf-8?B?QlM3dXlFWmlrTDk1VXNsbjJEWFdyVWdzd1BmRE42ZnhheXpBamhnU0pJOVZk?=
 =?utf-8?B?ekNoVUxtSkI5aGhJV2ZDSFNJdnlNbzZYV0JCMmd0WDI5bDkycVlXaVBQc0FC?=
 =?utf-8?B?Q2hyTU9CYXB0bk93VnVOQm1LNDUyU0dUaE90cXpIbHcvRXFjYnFBRnBLSmw3?=
 =?utf-8?B?Q21RcEFpTTVsdStIdkQrMUU4UXpVYVFWWWd3ZERwUFB5OFdxNkpza1gwYVJS?=
 =?utf-8?B?bld3d2NrUk8yeGpQWlY1UlN5MXU3aUx1dUJnWGdhaVZvYmh6YWVxNzRNK0Yw?=
 =?utf-8?B?MnZXWVViSHhocTl4eWNOTUp1SDBzZTBkNGUyaHE5VWU5b1hZMlJMWFdwU2NL?=
 =?utf-8?B?NE1qOXNJYXpQckJaK2gxMmJOOUQ4bHV6Y3RzWE56TTIxRitlbVE4TWJ2RFc4?=
 =?utf-8?B?UCs3UUYwaG83N2gyeC9yc1N1REYvRUpKSE91Rlg5cnhUYkNKcmY4Q2tlUDU3?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49de2d8d-a2c1-4adb-64e0-08de1726d9c6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 20:07:56.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTowS4Qf4nu4DfgcpXbkEHC98Nq0wv4FnZ195fjRTtoU0W35/TkQrgyLR7+FmyOWMzyjrBij9DH0Lhteka7revLX0591aSYzjDImXBOJ8Lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
X-OriginatorOrg: intel.com

--------------E3pF8tRUX0G0W28bhprvxcH6
Content-Type: multipart/mixed; boundary="------------Zkbr1zKtlw104y1YSrIu0Grw";
 protected-headers="v1"
Message-ID: <68a4b852-4eeb-4f97-af2a-58714b59be97@intel.com>
Date: Wed, 29 Oct 2025 13:07:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] net: ethernet: ti: netcp: Standardize
 knav_dma_open_channel to return NULL on error
To: Nishanth Menon <nm@ti.com>, Jakub Kicinski <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251029132310.3087247-1-nm@ti.com>
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
In-Reply-To: <20251029132310.3087247-1-nm@ti.com>

--------------Zkbr1zKtlw104y1YSrIu0Grw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/29/2025 6:23 AM, Nishanth Menon wrote:
> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
> index a25ebe6cd503..e69f0946de29 100644
> --- a/drivers/soc/ti/knav_dma.c
> +++ b/drivers/soc/ti/knav_dma.c
> @@ -402,7 +402,7 @@ static int of_channel_match_helper(struct device_no=
de *np, const char *name,
>   * @name:	slave channel name
>   * @config:	dma configuration parameters
>   *
> - * Returns pointer to appropriate DMA channel on success or error.
> + * Returns pointer to appropriate DMA channel on success or NULL on er=
ror.
>   */

Minor nit: you could make this a proper kdoc returns by using "Return:"
or "Returns:" here to introduce this as a section instead of just a comme=
nt.

That would fix a kdoc warning too.

--------------Zkbr1zKtlw104y1YSrIu0Grw--

--------------E3pF8tRUX0G0W28bhprvxcH6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQJ0GgUDAAAAAAAKCRBqll0+bw8o6M+A
AQDKfWPccZsR2hCXn4NOzWK3cOn/dbUim0Wc3GUy5U9QlgEAuBYXuE0rWSfSnPOHrjY+sb0A23qu
1G6THFKUt7jBbQA=
=qOBU
-----END PGP SIGNATURE-----

--------------E3pF8tRUX0G0W28bhprvxcH6--


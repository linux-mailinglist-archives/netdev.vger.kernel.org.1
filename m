Return-Path: <netdev+bounces-213397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5C1B24D83
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4741AA7C94
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDC7245003;
	Wed, 13 Aug 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0hVKW2c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF52417C5;
	Wed, 13 Aug 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099007; cv=fail; b=a6MM5C8s1JjAv2q7QTd9iYExogrI78u0zNIrBWUBNrup3Ca4WIelg90L9HK9yOiN2gDj5PmFGdcoARkVXBKQG52pMqmRaKpWsEzJdHXdwag9JtVQsSfA5VDidhcXye0obfXqoa7JEFgtYuIc6E2xmfMnCtgx3DsPtApaoOt8LBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099007; c=relaxed/simple;
	bh=5zlmvILjiyhmTBBu2Jjc7sEaKRqHSh/y7ygX1SHq8yo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jTuBsRUcTLt5AUeaA/ryoOWu7PsVipjPCoH9ikPyWDl4KOg3opFPbN3DTmpO/KHdduX2NdYFPZxkKWIJE7lCUaQKvOeVti8eo5/ox8dweKz0maPSAC7YA8Hi9SJkWmZf4jgJJXw3/k8S0r3VlCRcdm8J3T7ZY6falt17adbAm7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0hVKW2c; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755099006; x=1786635006;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=5zlmvILjiyhmTBBu2Jjc7sEaKRqHSh/y7ygX1SHq8yo=;
  b=n0hVKW2c9ALrnVVaCqP+oUC06N5Mh9H68jqYUoSQEzWn6dWP3iRIoMkM
   XT6L5pJvTWF8o2z7hdcf88SoCA6Ickc2puVdiWzObCbBQD1Fg5JFD2efn
   Tx5PuiJ62w/cf6SWoLTA7mH3b2ZlfWvP6vWMkyUBJbYChPpeFua5PbrGs
   mVKyq447krx8mjqLLT6bBIhLNcftALcQRlh+s0JVg/Lgc4RbFlAMuPXLq
   warRcgZ59/MNX7+CVxEZOr6OVHK7MpqKQur6knp++V/gMjlMWnV1AgYtM
   0djyYELhrHtsof2YnPMI4G/tN75gyptQc02oiu1+U/rjq2Xi2nIx1Ze+A
   Q==;
X-CSE-ConnectionGUID: +0DPvZhYRACcMaNIaDmGRQ==
X-CSE-MsgGUID: wUKY/wQZRzO2mJ+6Cx8pag==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57354223"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="asc'?scan'208";a="57354223"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 08:30:05 -0700
X-CSE-ConnectionGUID: vc+Vrb40TF2CbTXFkq926A==
X-CSE-MsgGUID: iScsm/u4Sb+n0IEdDAiM/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="asc'?scan'208";a="197493999"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 08:30:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 08:30:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 08:30:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 08:30:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Px2wZKZqqjIX3BoPmFRQfWtI6qEnZ5i6Qibw664qXRWb3Mlpey1kAwtv39ewAJURkbpCX+8a7JgfTUk8lqpc+cn3mLr5cM5BkUDRUTYKs0GwZJM77QcXCbrpqdPlmpcTSOX+nVvDpKm3WnfFp0rr23f0V53Dyy7QmZkSLHAXpAQu/Im54LHv8AyZaLrBi2ux+Pv0gqZhLac3BVJCbEF6K0l4RxrPunlfvseZnz/t9rzzvD5Makvdsy3TeX4b2yNiZHEIBPz1GX2guOviztcFOHrv0LDgdMwaDyu9ylkw4LB8m+CQHNbazTxRyeE4YAcfGGNNZ37oNVh5W5c2nZ3enA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IK596bsTAEVMKd4B4C25qSJd3opSD+fXNhw7HlBKis=;
 b=fNsRmmMzFLUU/uLCnqvxMAckijnJrLmiE/5Ydbsu2Yk/a0ChmoUZSVInCk27Y6s2wUsctgTR0Y0wgQtD3Onf2iN75igAKyycPtLpwjchmN3QB53QFhGV6AjzyVl4ew5d/xwPoO72ZwdF4PzBHw05+7wukqmrw9g28gFtkBdqqlYB2NC3oKasXlQ+K7Q3ccLmnOVBw663C+QAyNB1y66bWsq/hh98SLnezH2PF3f5SEWcIW7QnsHLJQd6MGqUHdtGq0I/NGnfRa1GC4eQP58KdlHE+GVTBriDvVBVPVySe+hPMf5DNZYv2uw/6VhJZMGcAnYtzewcOJzS3IRuZotgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ5PPF0DADD6EFE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 15:30:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 15:30:01 +0000
Message-ID: <b8eddc78-f9dd-491f-8c4e-98406ad6f8db@intel.com>
Date: Wed, 13 Aug 2025 08:29:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: cadence: macb: convert from round_rate() to
 determine_rate()
To: Brian Masney <bmasney@redhat.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, "Samuel
 Holland" <samuel.holland@sifive.com>, Maxime Ripard <mripard@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
CC: <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20250810-net-round-rate-v1-1-dbb237c9fe5c@redhat.com>
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
In-Reply-To: <20250810-net-round-rate-v1-1-dbb237c9fe5c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Olu5p2Ey10CTaf2d10fiGV3U"
X-ClientProxiedBy: MW4PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:303:8d::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ5PPF0DADD6EFE:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bcb215-5122-467f-506c-08ddda7e451b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3RIVks3b2hselpWck1kM1ZSdzNqbWtYL3BDZXV4ejM3QUdsUFVMODBydm5y?=
 =?utf-8?B?c3RKRVZiRStsMUxWNUFSeGpyeEpuV2huSG8rY3BMaGt1bEcyTlgvN2I5bk1x?=
 =?utf-8?B?NXBCd0Q3RjZWUysvaHV6VVZteVRjSXFkcGZ6OXdXcE55blQ1Sk1nVlgzWjQz?=
 =?utf-8?B?Sm01NjRJcXlYTUJzb05HNnMxWEYyRkVDZ0g2M1EyNTdweVRIZjNGQXZJK0Jv?=
 =?utf-8?B?anVabHpRNjhDb2IwM3FJb1E1NmxmaFNHbjhZZ05palBmVVZ4akhYa1pzbHJD?=
 =?utf-8?B?OGxXUmZCOEN3ME13UXFxa3EwN0lid2lNUTFOSURWRVp0QnNhRFI4NmhneVQr?=
 =?utf-8?B?R0YvM09ZZnVqSnI4Z3lNcHRYWDhqdnFFYzc1b1Y3OUVWNlBzckpCUGlWb0Uw?=
 =?utf-8?B?bThOZFBFYk5NRXRNZkliUjV1ZEJlY0lncmUxL0phQVVzMENJcjZGT1p6cHBW?=
 =?utf-8?B?aXpVSjRTWEsrYXVURi96QTNOL1pKWUM1aHlUcGJpczhkeGkvSUhHUUV1eEFi?=
 =?utf-8?B?VTJJeGNVa2FuNk5HWnp2UUtieVZnZTVGNk5jQVV0NnNpQ3piWC9BSkhCQndW?=
 =?utf-8?B?Tm1BZU9zTm9wdDgwcjkwWm95M1JjMXdScERiNHFPSWw4RllaTDBveFIrTjE1?=
 =?utf-8?B?Y21UVHpUdWJnLzk1dUlvNER5eEszT3ZhNjdsSlkzelBScGsyL3lwQTF0RUpl?=
 =?utf-8?B?ZkVFeWEvTCtyZDJPek5tOGdWQXhrbTF5dTlqM1BjYnVqa2ZDRDhqczBrMnQ3?=
 =?utf-8?B?d1J0Q2FhS0JqWXViTWs0dW85UDBPcTR4NFNlZjd5OGxTOHk2bnRCb1Bkcmds?=
 =?utf-8?B?T3hjZHA5WEdJTkFqSjFFaDRkTDBzMEFXQ1M5K3RyTGVUZlY5OGZSdWx6dGZ0?=
 =?utf-8?B?WVVSZHp5YkxMNHhvWDRYSFk0K21SUDNob0JXQ0d6T2xnQVlZM0xoRlc3N0tr?=
 =?utf-8?B?eTAyV0pYaHFxNm5yeEo0c1MrYTdHb0NQYTgxWEVaaXZmbFlqeDM4aUpxTERh?=
 =?utf-8?B?dVNVVEJrU0w2Y3hTUzY0R2k5bUFWeWt6S3MxcG1mTUlmbS9wMUlROEkvN05J?=
 =?utf-8?B?TUlVSk9OZGZJamJtejdVUmdPVDQzc2Rob3JpWi9yZDZ5KzI0aXVPWWZmbVZG?=
 =?utf-8?B?aEhNeUFoWWovdU9GTTlxckprNURReFRQbEhPTnYwQWhiUndJN3FIbUdCYzRG?=
 =?utf-8?B?QUMrMGQ3M3pxTVUzd3NSZE9FVUt6Y2pIK25KVWlLZ1ZNcmZDZTB3clZRSHgz?=
 =?utf-8?B?QWRsTjY0WFlMM3Z6WUhwM3d1MTVsK0RIcW1tR21MYjU1WllFSk9pbFQ0ZG9J?=
 =?utf-8?B?UURJNTY0bHFuQWdoTmxOb1dPYVhtaFBoaURwc3I0VUxvcys2UHQ5SEJ4Z1BZ?=
 =?utf-8?B?L241dzVYUDM3MmJvSlFab0N3U1ljdFFaRkVMN0t5V0hlUGV5ZDNMOXFOSGwy?=
 =?utf-8?B?aG8zbm42SEVQc004alJzV2IybmhDTVZldERDd1ZiUktjeVgyTVNITnUvYUNw?=
 =?utf-8?B?dXM3czBVa1d3aXRNOW50SGhjaUtiYXIxaUNmUjdnZDZ4VmdoZzNhQ2lnaGZD?=
 =?utf-8?B?d2Q4cWw1VmhTeXNzTXNTS3o0Szd2Q0VsaVkvZ1l2eHVMQWdkL0VqME1Cai9U?=
 =?utf-8?B?ZEpIVC9teEN6ajV5ejZSb2tTOHpwRXVlUmxnaHpKbW51UGJXekJKY05UeE9N?=
 =?utf-8?B?ZHpTaE5HUlhhc25teCtrNm1FVDhjaE9ERERTamhwY2h5VllKN3ZoVHlJT09a?=
 =?utf-8?B?QklMOVRlZXc3ZnI1OEhBRnJUcUR4dWU3eEpEYVJqc0tnVk1IcEV5MkdKZWNN?=
 =?utf-8?B?djNuOUp5OGUvQXRJclR2MEFUWWNuZ212cUdCYytSNWljT1phY3FITmpWOHM3?=
 =?utf-8?B?M01rM1RQVXJ3WWJGVGZaUjRNbnl4R29aUVN0dnBLbjBKb3dqWXVUK1V4N0Z6?=
 =?utf-8?B?d2hlTm1sOFlEL2tjbm5iMGJzbVZCWTNibDRKYUhOZVhIR0svanhJZStoSklD?=
 =?utf-8?B?bkp4M0wwRXFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzY2UGQrRm5TTmVadHo4QXArNDFodit0cTl5S2V0Y1B3d0FabTZuS09ERSs0?=
 =?utf-8?B?VDRTMGVUVEwwbXU1RTZnblRWSS95SHJBVVM5dG11VzJoV3FXK1B6ZklseDdR?=
 =?utf-8?B?dmU4cm9lR01YbWQ2QTd3MEFvNnJvbnRONmxUSzdBQ21QRnA2dkxuOStvdzgr?=
 =?utf-8?B?UGdZQlhzb3NZQlB4ckVZQUVZQUlBU1ZBNlM4TzQ2S2dubU9nMXQ2SXhZS0hQ?=
 =?utf-8?B?SS85eWVlMjYvK1ZqVkhNaTlTWTRubGgxMW5wU2pBVWxiTXJ2eGRZVStNMUJj?=
 =?utf-8?B?c2txMC9LbTU0NFFhMmd5cS9DMk9xMHNpVENUU2dPNkRzanJPU29qa2NhVVda?=
 =?utf-8?B?cW84L2NnMm92SXRWL1JRSWtkdG1jTVJOb0d2U3YzbGp1VHN5TTVDZVlCcFUy?=
 =?utf-8?B?Y25wUkxDR2ptdmRsWTJXZ3gxa09qRVpIVjJMZ0phQUs5akg0Q0RnWXM1RkpV?=
 =?utf-8?B?ZzlMelBVME40RTFwTzN6cVAyK1VWN21zN0FkMnNscCs2WVh6YnFWYStod3Y2?=
 =?utf-8?B?NnhOMkgrY0pKMnNIWTEvRVlENmxOUkZIRUpMUkszaEZwYmpocnVjekQyays3?=
 =?utf-8?B?amRwZENabHNObjg2dVdOZUNNMWpxZnJFdFdLdXJkTXdaTDZueTIrNmFUaDQ1?=
 =?utf-8?B?LzZUMTFrR1dBNnJxKytlYVJScnZXU2ZiQ0toTy9NNkVXWXB4RytqZXVBR0tR?=
 =?utf-8?B?eGxXajVyRHZtbHQrcEthWGhPMnRLVWl5VjUyZFR3anRmdzFWYWRyMi9vVlBU?=
 =?utf-8?B?NjhxVnhmZXFjZG52bWpSVm1oVVpUZmNUMU1wWnVVU09HK3BIVWM4TmdHRHdS?=
 =?utf-8?B?WXJKeGxxTkFLdHpTOERWNExCYncycHNPYlBOZnNLNWNiWU11MDY3dTI0M2Zu?=
 =?utf-8?B?dHV6RVRvNG5aVUNJZXVBeUF6ZG1ZRUU2L3daNk05UDZJcDlwN1kwTjN2c21r?=
 =?utf-8?B?TTBtSlJKb0FLbTZIZkVEQmJjaktKbkt2YXNnbjhDczBtemJOcHZzY28ybzF6?=
 =?utf-8?B?OUl3RHhZT1ZaMkIvVG0yNnA4SHp3M3lyRmdNNTkyeW1KcVRQbGVEVC9BVDFY?=
 =?utf-8?B?MGdWaGJFcERVelMzeGk5NHJZYitMSHNxNk9QOGJFdzg0WWJtYnFMb2FNQk5O?=
 =?utf-8?B?TWZsTFBpYnY5NlNWa3V3d0xhVzQ3YVZqZUYraXQ4MTNwYjg1TmhaTit6MUE0?=
 =?utf-8?B?R1ZtRUhkd3V4RFZ5eHpYdnNubWYxbndQUzh3L0ljM2hoellaOHF3UHp1R2h3?=
 =?utf-8?B?aUd1cmV3NEk0STRXNVk5ckViUFBDMFovTGJ3TXpKdFlnZG1YbFU5TnQ0Z25p?=
 =?utf-8?B?c2VUV3YwRXpyQUNYUEw0U3J6bXIrYm1NSEdPR2hkbVlXdUxTbHRkQUJPYkFM?=
 =?utf-8?B?ODAwYkNTUHlpNkxNL1ZOc0VrN0E2c1BsZTdYbXEzU0k3ZWFEYWluaXhHcnVN?=
 =?utf-8?B?U01DZ3kzRW9UR2l3bExBVlFuZ1JDVm1DR1BEd0ZNSHd0T3R4RldpMjA2NmlL?=
 =?utf-8?B?elNvcXRzUlgyWXJ3bmhTWFJWZVZGYTJTQnY4dVBJUUhEOHZ2Nm5ZMjZ5eTFJ?=
 =?utf-8?B?OUVYUGJhVURSc0wrdTVhc3J1Q3VLbXh4czhhV09aUjY1M3R3TTQyRmg4SlI2?=
 =?utf-8?B?V25NWTVWMVNqN3hvZE1EQjlrcXFUYi9nZFlGK1p5M3VtSHhUWStsTkNoQlBZ?=
 =?utf-8?B?MlUrbWFNZ0FNRUtrOWpkQmxwZEV4eXBtNi9Ud2VXcWQ3M3ZBeW5kK2dHajZ2?=
 =?utf-8?B?RHA0MkVOczZmWVNtNWxRVFZ1cGtZKzFhYjBJTGhZYU14cnZnZ0ErYlBHcWpQ?=
 =?utf-8?B?U0g5d0ZDOUptVFk4TWUvTWtPM3JtN1ZHd3Q2UHJDTTVXb0VPYVdvK3ZLemtK?=
 =?utf-8?B?ZC9ZZm1JTnpwbCs3dTU2Uk9ETitoYk9GS0o5MXJ4cHRuN292alkzU3pML1M5?=
 =?utf-8?B?MkgwVG1GL2k3YXNSNG1Fb1JqRjUySXhGaFJlbTRVaytVb0duMjZCdDd5WThl?=
 =?utf-8?B?c3JZRHBsRE1Qa2NkUE5oYlFjaUtGTEwxT0RVOXV4V0xVNFQwZm1TUm5iblhR?=
 =?utf-8?B?aXdwMTlYNWQ0THYrT2IrcTQ4ZHdLdTIwV20rMzYwQ1ZzaElOSW16SmFSY3p2?=
 =?utf-8?B?Ty91NjRERmtQMU1rSDFkcHYySGh5Y0FtbFc1RFdyRFRoUmZ5YldHbXVvemxH?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bcb215-5122-467f-506c-08ddda7e451b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 15:30:01.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyOffHf+x/ww4OFX6ALcZ60k8qm3X4F8a+lixGT/mCctLzWkxKj06t1qmZK8letNI1swLo8ibOOyqxPqaK1XyK7H7uiSXNk9wI9rQprNXkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0DADD6EFE
X-OriginatorOrg: intel.com

--------------Olu5p2Ey10CTaf2d10fiGV3U
Content-Type: multipart/mixed; boundary="------------pypCuRN8OcftUZfJ6tZkfYHN";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Brian Masney <bmasney@redhat.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Message-ID: <b8eddc78-f9dd-491f-8c4e-98406ad6f8db@intel.com>
Subject: Re: [PATCH] net: cadence: macb: convert from round_rate() to
 determine_rate()
References: <20250810-net-round-rate-v1-1-dbb237c9fe5c@redhat.com>
In-Reply-To: <20250810-net-round-rate-v1-1-dbb237c9fe5c@redhat.com>

--------------pypCuRN8OcftUZfJ6tZkfYHN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/10/2025 3:24 PM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate().
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 61 ++++++++++++++++++------=
--------
>  1 file changed, 35 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> index ce95fad8cedd7331d4818ba9f73fb6970249e85c..ce55a1f59b50dd85fa92bf1=
39d06e6120d109e89 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4822,36 +4822,45 @@ static unsigned long fu540_macb_tx_recalc_rate(=
struct clk_hw *hw,
>  	return mgmt->rate;
>  }
> =20
> -static long fu540_macb_tx_round_rate(struct clk_hw *hw, unsigned long =
rate,
> -				     unsigned long *parent_rate)
> -{
> -	if (WARN_ON(rate < 2500000))
> -		return 2500000;
> -	else if (rate =3D=3D 2500000)
> -		return 2500000;
> -	else if (WARN_ON(rate < 13750000))
> -		return 2500000;
> -	else if (WARN_ON(rate < 25000000))
> -		return 25000000;
> -	else if (rate =3D=3D 25000000)
> -		return 25000000;
> -	else if (WARN_ON(rate < 75000000))
> -		return 25000000;
> -	else if (WARN_ON(rate < 125000000))
> -		return 125000000;
> -	else if (rate =3D=3D 125000000)
> -		return 125000000;
> -
> -	WARN_ON(rate > 125000000);
> -
> -	return 125000000;
> +static int fu540_macb_tx_determine_rate(struct clk_hw *hw,
> +					struct clk_rate_request *req)
> +{
> +	if (WARN_ON(req->rate < 2500000))
> +		req->rate =3D 2500000;
> +	else if (req->rate =3D=3D 2500000)
> +		req->rate =3D 2500000;
> +	else if (WARN_ON(req->rate < 13750000))
> +		req->rate =3D 2500000;
> +	else if (WARN_ON(req->rate < 25000000))
> +		req->rate =3D 25000000;
> +	else if (req->rate =3D=3D 25000000)
> +		req->rate =3D 25000000;
> +	else if (WARN_ON(req->rate < 75000000))
> +		req->rate =3D 25000000;
> +	else if (WARN_ON(req->rate < 125000000))
> +		req->rate =3D 125000000;
> +	else if (req->rate =3D=3D 125000000)
> +		req->rate =3D 125000000;
> +	else if (WARN_ON(req->rate > 125000000))
> +		req->rate =3D 125000000;
> +	else
> +		req->rate =3D 125000000;
> +
> +	return 0;
>  }

Quite a big diff for the minimal amount of actual changes. This looks a
bit nicer with --word-diff to show that there's no real functional change=
s.

> =20
>  static int fu540_macb_tx_set_rate(struct clk_hw *hw, unsigned long rat=
e,
>  				  unsigned long parent_rate)
>  {
> -	rate =3D fu540_macb_tx_round_rate(hw, rate, &parent_rate);
> -	if (rate !=3D 125000000)
> +	struct clk_rate_request req;
> +	int ret;
> +
> +	clk_hw_init_rate_request(hw, &req, rate);
> +	ret =3D fu540_macb_tx_determine_rate(hw, &req);
> +	if (ret !=3D 0)
> +		return ret;
> +
> +	if (req.rate !=3D 125000000)
>  		iowrite32(1, mgmt->reg);
>  	else
>  		iowrite32(0, mgmt->reg);
> @@ -4862,7 +4871,7 @@ static int fu540_macb_tx_set_rate(struct clk_hw *=
hw, unsigned long rate,
> =20
>  static const struct clk_ops fu540_c000_ops =3D {
>  	.recalc_rate =3D fu540_macb_tx_recalc_rate,
> -	.round_rate =3D fu540_macb_tx_round_rate,
> +	.determine_rate =3D fu540_macb_tx_determine_rate,
>  	.set_rate =3D fu540_macb_tx_set_rate,
>  };
> =20
>=20

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250729-net-round-rate-01147feda9af
>=20
> Best regards,


--------------pypCuRN8OcftUZfJ6tZkfYHN--

--------------Olu5p2Ey10CTaf2d10fiGV3U
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaJyvcAUDAAAAAAAKCRBqll0+bw8o6Ksr
AQCkXL82ForIpWTFKdL+6FhPfZRw/VM9XuuNCuQ8qDi/1gEAtbVWDbSEkAQQSlYc6aL2Xiw4zThE
ym/azgmOsIrAlwE=
=DC0p
-----END PGP SIGNATURE-----

--------------Olu5p2Ey10CTaf2d10fiGV3U--


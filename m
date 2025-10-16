Return-Path: <netdev+bounces-230230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018EABE5955
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BB41894D85
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD142D374A;
	Thu, 16 Oct 2025 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOKfL782"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A1A155326
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760650731; cv=fail; b=GH2aXrJjpG4hnW2c0RPMG998/qK60MI+RWnAgJOYlSocli2hmZlFqVnAz+yLJ1nG1mwjfEPF4Q+6W296O1YK0ksmirN9g5krgFSoUiwuIsHZ0R5hcI5dMGndXfxKAsVGfgoVm6uw2HJ6YU3UVZ9vO2dEHmY0sScFU/WM2oljEOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760650731; c=relaxed/simple;
	bh=Yer/+aa/Y/ep6dNi4Vv5l8pg3GlTElbfmY3y2Za86q0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=afqPN8qtL3VdpvE3RYS/KZSFqqwCxnexTLMjC2PJQ/QpduxFJe7a5Gb0fJ8391fCN9/o8g+1Wp0ixeY4kQ7MnVSnDz1wiSD2DXIJMWN2KAzHZXExLpjHLsrhqVThtEz9uQQPMMU8dM3sxDTEXaoyV8pngsQPjo/sA26egIkc0tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOKfL782; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760650728; x=1792186728;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=Yer/+aa/Y/ep6dNi4Vv5l8pg3GlTElbfmY3y2Za86q0=;
  b=YOKfL782Y154xM2jAhwmem0NHJHOy1WpL8/5UWGpc2l26227zCjkO1Dj
   KTxgfNSBZLfk302QzBdqcXgsjltDcfDZBoN9iCzrtwGJrbTZ+iKDvUjPV
   6/GWzeR+dxl7QITzWIvOiuEEDBhe90JJ7EonvPr1vaFi1CWLEJzG0q1sY
   B/J2i/zU76sNrGnMUGWlcqS2x5DHbvVVGDY+LYibZ2vYr33AAeLZeUqA4
   xUg7ebS9xDqm0rHvLR2/I+Sjjg7Hn14oIUuIII9RmRH5RaV/NaEDN8AgF
   RCL6LFDSTgp0SmLLxCPu498jkAn1h6S6xMUaHZLS82t+D3TDd7Wtzfb3q
   w==;
X-CSE-ConnectionGUID: LlFwNXgeS1qi1cJyar0LEg==
X-CSE-MsgGUID: pVw+BrnqRYyNTPLFGqsz7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="88326676"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="88326676"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 14:38:47 -0700
X-CSE-ConnectionGUID: Mzx69m3GRziUorLg3oz9kw==
X-CSE-MsgGUID: zYZLfU3aQASZTSMG5jGvzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="183365290"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 14:38:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 14:38:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 14:38:46 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 14:38:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzAqnbsABYGX++4NUueUtTwjBAUuCC9AKZ3pUGJ8zW/6NZatS56mbjKpF21f9i9/W7PvR54IJRy+3EguU5Gk8KaR5ATq06kJ63HG1h36re6Amm/R/YXhz/XmghoD5FlQKFrq7sUpkzowWw3oTUOwUuWSCs+Xa0oguYHVmEcXQVv2Q1OXLxLso/WOQKJHYGNqisf3rsrqM0a0CsNGnLuQV1BPjZJS9nKZ5eDT90ZHCDQU/mtO7wQlXix9qPdw4W82sfVefk088+uYkfZAoJy/iICAx8ovejEjJj93QqBrYnucLf6T+cSqMvxbUwDdIv+D6Snl1wwU9imbGa8uBJnDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGIKffGAIupKSpTO68C7xeYrfX0c1eO7amll2NxqUK8=;
 b=rKrUwheAy3SkeDxdyhi8CZZ7kU5ITAWZ8qStDKwA9w1EQGblnDO21J6n9CwlMkTIb/EKuNJzrv2kP4xSp+YgMXgLKJirmQVgabxYexUCZklHXEg75wsBpg+5ofYO3eeTS7xA//PbD9eCTiSneqreBBVpOc8Vaq9vCM0VeRSwm16+Kz+RR+I1r+sCuDMRbg6JmLCkPL8wL4tQvEqi1QPKoJUQ67TPZnKWWosqB/vQ0PJ0/1p3pIKptq+VkwnO3f5RyI73sdyzrLE9hFSVFeLZh5HUroJowbnUYE5itbfP5j3I20CGCezaNtlfAQQvVfk3GjwZfkCmER6ZBwd0r73FQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 21:38:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 21:38:45 +0000
Message-ID: <48edb201-3c6f-4a94-92dc-bd0d8c0a55b5@intel.com>
Date: Thu, 16 Oct 2025 14:38:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: shrink napi_skb_cache_{put,get}() and
 napi_skb_cache_get_bulk()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
References: <20251016182911.1132792-1-edumazet@google.com>
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
In-Reply-To: <20251016182911.1132792-1-edumazet@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------2LnONaN5f780kCSkabk5GT4D"
X-ClientProxiedBy: MW4PR04CA0142.namprd04.prod.outlook.com
 (2603:10b6:303:84::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CYYPR11MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 04251b4b-9a48-4701-b22e-08de0cfc6237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU0rQllsZ0NwSHVQMlF0QlRyZXh0QUNhbXRuMVdSeG5jWUJJa3lMelJiT1Y4?=
 =?utf-8?B?Rnp1N3hVRytHc1NCaVlIME1vLzZpd3cvUzRZNFd5b0tOeXRHa1BzN2lsTnB2?=
 =?utf-8?B?TGZKWUZuc0lLYzkwbG14aWhtd1Y1V09HaERiMVE4d2xrV0hwWENvSnUwZUds?=
 =?utf-8?B?ZENrMVZQeUNsei9vbzRtNXZ2T0diakk0Z1NOSGRJUjFlem5jZVRGeW4vTmQx?=
 =?utf-8?B?ZHJhZ0VDNzBqZ01yRmdIb3NEd0dXZFZnK0NHMzA2TU0rbyt1VHgyMFpVNk5k?=
 =?utf-8?B?NVhKdFdFVXhmellWdW43aXdzU3ZXOFZpMFlZbzBBTFVjOHMxdEVtc25zZlFx?=
 =?utf-8?B?dnFCbzJNYWhzaWFySGJ5T29LSXl2TlRBcHJ6R3htcVJRQlhocHhRRTBXOG9M?=
 =?utf-8?B?amZ1RUFTWHdTUmdZV0Z4UWo1MzJVSlBiYTJOaUpsNUJYazQ2ZDhHKy90dElV?=
 =?utf-8?B?L1IzY2RGSlV1dTZCaTg4WVY4UklMb0pqd0xCYVdyNEhPNDhHOW1JcjgwR05t?=
 =?utf-8?B?U2JlNnE1dUlhREFEeUxkYjdEWElvb1R4T013NDREeVVpZm9DeWpJT3p0emtW?=
 =?utf-8?B?YkZmU1JuU2toS2U3bmFmc01vOHRlbDFPbU1YVElMTk5XS0FNT2thUXNJLzg3?=
 =?utf-8?B?V2tqVnRQdGZrSlVuTTBrQUxZN1hzN3hLanZPUlMzMkIrYXdCaXdzeDROaUpP?=
 =?utf-8?B?eTBZM0x6ZmwxUExKenAzZXFUTTZUYUZqOC95TENXVmdLNHhlQ21DRzB6YzFQ?=
 =?utf-8?B?QVVGODQ3ZHFQSGM1bURiaXdLTXJhSC8yZDVZS0ZlS1dKcndPeWl6RzQrNlls?=
 =?utf-8?B?anNHQlVFbXRES2ZnN3VvQTVJQk1xTjY2b2t5UjVXYjRCL2FSZHh5YVpCc3FI?=
 =?utf-8?B?MG03dTR6ZmlCYk80Q0NhSkdqMTdTOVdua1FxVm5oT0dZNWxHTjl6Y2tIRVNZ?=
 =?utf-8?B?V21CdXJLanFpYk9MeUx4WjZaeVl6QU9lQ3VPd1B5RzB3RUl5OXFsK1Z2aWJ0?=
 =?utf-8?B?NXVXTTVVZWxhdUlVN20yNHVsN1F5YWpROThnRTBHUUh2U3l3YnQ2TU8xTTZR?=
 =?utf-8?B?M1NnejBFeWlSZ1ZPSVVXdjdNdlgzVkI0OHlDNWJvUXB2MnFYZjErbUsrUWkr?=
 =?utf-8?B?UEM2ci9OeU5xbzdSNXowZS9CYVZYZUdmdlQ0anR5YjBpNkkzOVdzZkpJalNW?=
 =?utf-8?B?Z3F0aUV5RGNZOGMrandFalNSZjNLTTNvdGhCZUxMVTFMYnhkbmt4bnpIQkZq?=
 =?utf-8?B?YUxJdXdCUklpbWhxUXRtWTZYS1VxNHp0MU1HVWVVQXJ1OVVPT3QzTStzOTUv?=
 =?utf-8?B?RlltYVI2TGhlaEZmVkF2ODJTdlZZb0ZGUjBUYVFRZEY1UGQzZS9TQ1AxODFC?=
 =?utf-8?B?MmUwcUtvTEdOWk4xaTR5OVZMQk9iTDI1UG56UlN5RjNNT0VadVR1d3ZMVTJi?=
 =?utf-8?B?WWJ1dm4yWEJEU1dUN2wwR2YxV0RmNXZGV2ZmT29DYWd5MFRHY0tuMFpFcXAz?=
 =?utf-8?B?c2c1R2dYK0F5QWhuaDBxUzl6cFNIL2M1VWZFamVKY3RZY2I0eTRuRlhpb0Nh?=
 =?utf-8?B?RVBPTjdpRkkrbGY2MGo4MzBGN1RNQ01KdlY4WitMY2lPaHJ6cXJLUnRvOUs5?=
 =?utf-8?B?WTlLSXZQdU5TMjVpMHdwWm9SU1U3TExVbDlSUGFLWVd2aEd4QnorUDhMRkhC?=
 =?utf-8?B?SGY5WnRMOVMvWDQzeDhlQUhBdzQvd3lKSEIzcmUyNEtIM1lRRlROMDgrUFBK?=
 =?utf-8?B?VytmVGRNejk1SHVvTjlxWHNWUHludklXaWpHRjZCbEcrWHRDK0hndnNhRTZU?=
 =?utf-8?B?UG5SUTlocHZwb3dXK3VqeGRWQTlOOEhmWk8vOG1Ra0VJR3g1ZjBhdmJGY3g4?=
 =?utf-8?B?RlVxU3FRWmM5LzNhN2NiZm5yNjBHR0dDSFBIWTlCVjBTTEhhL2hveGpQenRY?=
 =?utf-8?Q?OCOcYzJf81lhEZdxofIK2azhbO16xnGU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZllEcDhkNWU2MGMzQksyNUk3aFJHVHMzdUFrTnQvK05wcGVYRHRvaUZtK2Nt?=
 =?utf-8?B?WnV0ZlNaNnJKVmNqVjE2c2h2THdnU1hjdEFvc3JFaTFDUDMxNXVOTDRaRXF1?=
 =?utf-8?B?NHh1RVRPeDR1dnR4ZUlZbHZFSkxQL0oybExKcm16T3grZThPVDU4VDRDek9o?=
 =?utf-8?B?cFl5SVVnZmhqMDZIWXIxUTlGZlBhVEh6RkpPZnlaampLWDF6aTNtUmNRT2cx?=
 =?utf-8?B?bUxPbnR0eC9XNkxxSFVhTVlubEY3TG12amwxYjBVdjZncmNuRHQ2Y3hFd0ZF?=
 =?utf-8?B?dzFwNTNJeERqQXNFYlhka1BVaWJ5Q2ROUCtraitRQzdvbUhuMUY2bms5bDVv?=
 =?utf-8?B?eG51Z0dycmdNR3dzZTVtbkJnWGlpd0o3ZFRLNWVvWHRZcCt2WTVSWmEySVVL?=
 =?utf-8?B?eTd5NXdHd1YzejkvNFU0QzBVblhoNWhuQ1AwSHRKS3g0dlNVOTNTVk5jYVhO?=
 =?utf-8?B?QjcwVWppT0tOV2hXV01VOVgzRXhBd3VNcGN1T2g5QS9UQ29pNEV0UUNoSnpB?=
 =?utf-8?B?NnRqcXpjTWVhdTZaNGdZdzVGR3ZDNmdjMWFrQURaS25OUGxrOGFkUHFNRStr?=
 =?utf-8?B?Y3h0d3o1MjlnNUhJWjhkN1krWlRHNHRzUXI4dCtXQnRXekdsLy9teGsxTkRq?=
 =?utf-8?B?UUc4QVJHdTVSMDJTbHFDbDRoWG5IeExFajJBWlhhWnJiN083NUtRV3BtVjJH?=
 =?utf-8?B?anY1YWVsVi9nUzhNZmZ3WW1sUDVnVHFVL2JodjRYQVVtOTNsMktTZ2hHcnkv?=
 =?utf-8?B?QytsUjhUNy9uRXJUeHBsRmpPZ2FLNzk4THlZc1V0UVAxRGxEVk9EdFMxSlpj?=
 =?utf-8?B?MmZldkhmMUxRQ1gyWWgyMkxXdWo5OG5CUGJFMlA4eXpjclR5MFZNSGwyWW5z?=
 =?utf-8?B?WGNpcWVCbGVabFJLM1Z4Y2kxQ2FwQjdJalV6TjhGL012Q2ZGY3ZaWVo1aEZk?=
 =?utf-8?B?WVpzSFIvcTN6NXRGYktkZkU1azFSM2RaTWZoSXhJVFFtclBJRldGYm5SMXls?=
 =?utf-8?B?MmQrd1U2Tk9kWnZhcWJ4WEhRUHFZcWxIYWFENmI3MXFrejhTc0JsS2c1VmVV?=
 =?utf-8?B?ZzZSYkl1Q0RiNjdFdStkRlEreDViZzg3MGpoYzdpSGZYSEtpMSs1cUlvT2lB?=
 =?utf-8?B?cDE5REM1NHVqYTQzMU8rZHNUd2F6QU5RNHY3S3QvVzN1Ulo1WGcyMWtLSS9C?=
 =?utf-8?B?MWtjTUg4VVlIdm5UdzZ1ejRGZU5vdmhhSU9iZENlUXBvdUhiYnFROXExbVBh?=
 =?utf-8?B?T1g3aGE3Wk9LdWo2a2RJa2RKU0dqbTVwek43U2l6MTZDc3dDL2dZaEhiTldy?=
 =?utf-8?B?NWZxVzQ5Z3MzbVVYQ05IZnNMZVlyeG5sdGRqWXozdVB5aWFScm9iRDczRjFS?=
 =?utf-8?B?Vm1UUjEzMEY0RzZzbW43UnpYMFFMdi9ydGhJaFNPZ1hTUi9UTGVBR1QrUXpO?=
 =?utf-8?B?eVhoOU4xWGJ0ZzlzKzZNZ2M5SmN1RVFJamRsZ3Fwd1lGS1B0Ukh6NWpEK21Y?=
 =?utf-8?B?enpZT3FWU3lSUXhnODhGei81TDAweXhOcDNQMzQ2MDF4WFpUbjRCaXRwQ01v?=
 =?utf-8?B?NVZ4VENnQTFYVmUyTjllYlJiWFFTaHdhZ08zR0liSkRTZDlRV2hpRW9JSy8r?=
 =?utf-8?B?U3dMb3JoYVVuaUZlWWRSRWllWXFZYUUraVI2dDVBcWpQSVU4cElYNmpua3ZD?=
 =?utf-8?B?UVA3cUNWeVcyUVYralBJbmNEZTArN2pXM2RzK0pVQkpQS3FiQm1XVFVBMlBT?=
 =?utf-8?B?WDR6KzRBUGtJMVMvamhDeFU3MXVZb3ZwK0VUYmMrVG4zMElEYzhEcTh3YzNz?=
 =?utf-8?B?dlZ2VGh1YTFXY3BrNU4rZDJmSDA1ejhOV2R0TklwS054SkRSS3JsdU9VV1Jh?=
 =?utf-8?B?cGoxUUNITnVVUnBmNXRxQXdwQ2dUNVBaR3VOeVpVUUkyTTlENWJpUFNoT3FX?=
 =?utf-8?B?L1NYNU4wZkZRZVJvUmNhSWE0Mm9Bdk1BQ0VJcWdJbThWUmNDbHpvQ0pXZWJr?=
 =?utf-8?B?LzNxankrU0xWNVVkcnhuRVNxN2ZKdWJ2eng2YWFvNWVwQ3g3KzZob0FwYXpy?=
 =?utf-8?B?MU1FeG83Yys4QTNNZnA2b1A0WjA0dU5Zc3JERmtZdXphOHFLUFgyR0c2YnBy?=
 =?utf-8?B?OGNuQkxvUW9zc0pub1d4R2Y3RmpVUnA2Y1lkaXJ1WXR4Z0VCNU45R29CeDV0?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04251b4b-9a48-4701-b22e-08de0cfc6237
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:38:45.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWJxsL23O1PNpiyGE17+Y1UFiU5SlpReK/aZnDy23hCIPRbOqLt7Y0K792uWkwryUhBVXg1G3bN7xIB+RhwSTHwWWo9ONONh21Hy5qPGjXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8430
X-OriginatorOrg: intel.com

--------------2LnONaN5f780kCSkabk5GT4D
Content-Type: multipart/mixed; boundary="------------QNYkbQSINphxtgTYEjjNeFn4";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <48edb201-3c6f-4a94-92dc-bd0d8c0a55b5@intel.com>
Subject: Re: [PATCH v2 net-next] net: shrink napi_skb_cache_{put,get}() and
 napi_skb_cache_get_bulk()
References: <20251016182911.1132792-1-edumazet@google.com>
In-Reply-To: <20251016182911.1132792-1-edumazet@google.com>

--------------QNYkbQSINphxtgTYEjjNeFn4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/16/2025 11:29 AM, Eric Dumazet wrote:
> Following loop in napi_skb_cache_put() is unrolled by the compiler
> even if CONFIG_KASAN is not enabled:
>=20
> for (i =3D NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
> 	kasan_mempool_unpoison_object(nc->skb_cache[i],
> 				kmem_cache_size(net_hotdata.skbuff_cache));
>=20
> We have 32 times this sequence, for a total of 384 bytes.
>=20
> 	48 8b 3d 00 00 00 00 	net_hotdata.skbuff_cache,%rdi
> 	e8 00 00 00 00       	call   kmem_cache_size
>=20
> This is because kmem_cache_size() is not an inline and not const,
> and kasan_unpoison_object_data() is an inline function.
>=20
> Cache kmem_cache_size() result in a variable, so that
> the compiler can remove dead code (and variable) when/if
> CONFIG_KASAN is unset.
>=20
> After this patch, napi_skb_cache_put() is inlined in its callers,
> and we avoid one kmem_cache_size() call in napi_skb_cache_get()
> and napi_skb_cache_get_bulk().

Looks like a reasonable way to fix this to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  net/core/skbuff.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..143a2ddf0d56ed8037bd46b=
ddc1d7aeac296085c 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -274,6 +274,11 @@ void *__netdev_alloc_frag_align(unsigned int frags=
z, unsigned int align_mask)
>  }
>  EXPORT_SYMBOL(__netdev_alloc_frag_align);
> =20
> +/* Cache kmem_cache_size(net_hotdata.skbuff_cache) to help the compile=
r
> + * remove dead code (and skbuff_cache_size) when CONFIG_KASAN is unset=
=2E
> + */
> +static u32 skbuff_cache_size __read_mostly;
> +
>  static struct sk_buff *napi_skb_cache_get(void)
>  {
>  	struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
> @@ -293,7 +298,7 @@ static struct sk_buff *napi_skb_cache_get(void)
> =20
>  	skb =3D nc->skb_cache[--nc->skb_count];
>  	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
> -	kasan_mempool_unpoison_object(skb, kmem_cache_size(net_hotdata.skbuff=
_cache));
> +	kasan_mempool_unpoison_object(skb, skbuff_cache_size);
> =20
>  	return skb;
>  }
> @@ -345,11 +350,9 @@ u32 napi_skb_cache_get_bulk(void **skbs, u32 n)
> =20
>  get:
>  	for (u32 base =3D nc->skb_count - n, i =3D 0; i < n; i++) {
> -		u32 cache_size =3D kmem_cache_size(net_hotdata.skbuff_cache);
> -
>  		skbs[i] =3D nc->skb_cache[base + i];
> =20
> -		kasan_mempool_unpoison_object(skbs[i], cache_size);
> +		kasan_mempool_unpoison_object(skbs[i], skbuff_cache_size);

This look already looked up cache_size separately and then call this. I
guess that would be another way to avoid this. However, using the global
__read_mostly makes sense. It is initialized once instead of every call,
so its cheaper.

>  		memset(skbs[i], 0, offsetof(struct sk_buff, tail));
>  	}
> =20
> @@ -1428,7 +1431,7 @@ static void napi_skb_cache_put(struct sk_buff *sk=
b)
>  	if (unlikely(nc->skb_count =3D=3D NAPI_SKB_CACHE_SIZE)) {
>  		for (i =3D NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
>  			kasan_mempool_unpoison_object(nc->skb_cache[i],
> -						kmem_cache_size(net_hotdata.skbuff_cache));
> +						skbuff_cache_size);

Previously, this inlines to a bunch of calls that check
kasan_enabled().. but the compiler can't reason about it because
kmem_cache_size could have side effects. Now, it sees skbuff_cache_size.
Even though that variable isn't constant, it can still realize that
kasan_enabled() is false, so it properly elides the entire block.

Makes sense.

> =20
>  		kmem_cache_free_bulk(net_hotdata.skbuff_cache, NAPI_SKB_CACHE_HALF,
>  				     nc->skb_cache + NAPI_SKB_CACHE_HALF);
> @@ -5116,6 +5119,8 @@ void __init skb_init(void)
>  					      offsetof(struct sk_buff, cb),
>  					      sizeof_field(struct sk_buff, cb),
>  					      NULL);
> +	skbuff_cache_size =3D kmem_cache_size(net_hotdata.skbuff_cache);
> +
>  	net_hotdata.skbuff_fclone_cache =3D kmem_cache_create("skbuff_fclone_=
cache",
>  						sizeof(struct sk_buff_fclones),
>  						0,


--------------QNYkbQSINphxtgTYEjjNeFn4--

--------------2LnONaN5f780kCSkabk5GT4D
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPFl5AUDAAAAAAAKCRBqll0+bw8o6HZg
AQCs+gohbxo5cC6Hv4bXBRH7SWb/t/gdErijgTTWTa8VaAEAnMGOUBfqukd1rWDXpJg5F6Fv8PpT
2BZ8uOaqRiA7RQM=
=xf8G
-----END PGP SIGNATURE-----

--------------2LnONaN5f780kCSkabk5GT4D--


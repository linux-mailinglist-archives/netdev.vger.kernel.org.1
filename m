Return-Path: <netdev+bounces-243485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E8ACA20CC
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 01:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25500300A868
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 00:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3DE19D092;
	Thu,  4 Dec 2025 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCEYOi0c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0495FDA7
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 00:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764808783; cv=fail; b=gR1+AZvefvGnPofLgYDg5ukaLofBOBwAxdQfsEJ1aObVn1W1uE0TL0aCBpXlrZrsb3Vb/rfVmx+CBOe12iiohUuvcSRJrLWA5KQAPyb08VHoNFG450lkejbPB3Biu26MEqQD1Y3gbzbCWJWTNVguUdFEoib0dhSrgadi37+/+Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764808783; c=relaxed/simple;
	bh=vQQNN+GbnOMCRKjqyx57QFWSiPCXi2saeiXKvr5dy2E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CB+NCTUMYo1cn7QYF0QXhgFgbQ2ocpq4eMXFg8CoEKWUnmvEG5EF6fPrRtIzP2XIrA2dOAn0rQy7G5cGygmUDTd5Lf3mOvqO7B94JYIOrSC56MDCp64JtZXoAIu20n3m9BVc0cnOEYmhcA5eFYQEkuBp2lh8raFxuwwDTEi9kAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCEYOi0c; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764808781; x=1796344781;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=vQQNN+GbnOMCRKjqyx57QFWSiPCXi2saeiXKvr5dy2E=;
  b=cCEYOi0cej/77ZPRIOAiiE2Tll/Nj3l0hd9o2wrntW3XCCcVYfZhKDtv
   6L2X3/QxnGhtcx0Jk2/civ4lK/KBqDvKXKGHkWAR+IZ4FjqCYc/pg1P/l
   6gisYZ+dbY/l+mVLj680rdX0zby+x4YhxV5WtwgJADUlt0LmyNftiNgQ0
   aBJ1H3zie+eaCfjCQgKwq5KMCqWjfxS/4uupePIArA9sTjSxz1EGGAINo
   bugWM4R0/Pxo7tpvGrNINkAvQtDEQT0xgjIM8zHaLlLQsvDDuD5oVxe/s
   CgMKhvoIQgVAUQrNevtgYe57RO2ZQi8KvNr3Go+pVdWZ4r7xBf6sClKAd
   w==;
X-CSE-ConnectionGUID: m+nO9r6BQ9yeOonFIMVp3g==
X-CSE-MsgGUID: 4+ySgb0IRwSfuQJQfzaNQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70669733"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="70669733"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:39:41 -0800
X-CSE-ConnectionGUID: 3z9O9iQZQEOmr9X0Kt8jDg==
X-CSE-MsgGUID: 6d6lJ7ZbSrS833z9HeZUSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="218188476"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:39:41 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:39:40 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 16:39:40 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:39:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XStotH22tVmy/KSN/fmnVQoC7UZrngttb8zi2QQb6ANnWphjdWbJtFyVlrD4dMaRh2+JPWkg7cCIJuLHXZPwkrpqpZuI6zD0JGLyNaAsYS15m2knm6aDFeOTN+YFb085Q1JtJMP6aOANjQAt0m7EAXnBSqhOZVSM+TT3GBKHGDi3l7vasG8E8Gm3s3sW+5rrVY5jqWWqB0sWbBMkd5ckotIOIebw3opoA4qOxoZqbNoLQZp3aJRqFVvJLqgP7GntHzOkjJlZTVjRKgQaL/TDxleupnP03HqgSpR9nrn0RxulVF7ID/9oyV5WvmgwbxRpA/jeUNs9xNGXQjAGxI9EJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds6VMPSddBkrObmZJ6fsauMguDJPD3j3+hASVR1hPX8=;
 b=ZyPqsqX0EavdgE4cMavlX4qylP4M35UDj1BSjU8UI9J3LloBG2kFMMPqJaoYEkZdrDx6nKTfZOwOf4csPwvXmmb4qdO489guWD2lXM/dJar5NzFN9/eTWtbuE1118W6PeHxWcy3jjDfZOdwjMR6glleYbkFgiXz/aPEOHcK9q8EAwKSLeyFqp9XYe0BwKgIvaCJaQO9tqaFuyP8Kr6NnA0StnHXZi6SV5858RrheKP6RhXaEyjBdVWPG7De23JpbtydZWMIptRnc7V0YzDHr44ETBw8C0ZIAvup7nXk6iwFJlcLHBHu6z5jxn4WQ8iEDosGhQyQouxoN0e78SFpB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7241.namprd11.prod.outlook.com (2603:10b6:930:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 00:39:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 00:39:38 +0000
Message-ID: <f1041c3e-5962-44a0-92c1-021b2466f7a3@intel.com>
Date: Wed, 3 Dec 2025 16:39:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnxt_en: Fix XDP_TX path
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <pdubovitsky@meta.com>, Kalesh AP
	<kalesh-anakkur.purayil@broadcom.com>
References: <20251203003024.2246699-1-michael.chan@broadcom.com>
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
In-Reply-To: <20251203003024.2246699-1-michael.chan@broadcom.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------GsxJUlTUkNwxsY409vIcBlvb"
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: d52e30a1-2a58-44e8-0857-08de32cd9aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzdqSjFpZWlKZHoremUvck55UnpPUFVQMmN4R0twU2dPakhFeWRVUUw4a2tI?=
 =?utf-8?B?VWpBeXdnQjFMc2VPVE5qSytLM2JjalBEVktVR2RMdzJSd2xOR3lhL2QwM3hj?=
 =?utf-8?B?VjlkUUh4cG1vWlA5TzdLK1d6bGY1Q3JVU0hCejNsRGR4VnBkTEZhZUMyTGpr?=
 =?utf-8?B?NkhYNDloRTBaNmJrRi9lSzNJQ2VuZWJBMXRENFhHSjZpSzVLK0hVWmVnQktU?=
 =?utf-8?B?UHpFRjlSVzBCbEo0WndZVTBiTmc2ZnZtNXNLZ3RkRHd2Z1UrM2wrVHM4ZnBB?=
 =?utf-8?B?NEdHR09mTEZQemNwZk5VZmVVVHczdEtNdW91UHlSMU4vRGRENWtpWlpkQTN0?=
 =?utf-8?B?WFFJMFhnNytheFl2T2U2SDk2NlVkd0dscVB0YnFOYkk2SHhmc1BrRFAxVVZT?=
 =?utf-8?B?dHA3WUZyM2tCT2hQM3o1NDJYZFE0blovaFU3aWV0RDEvTzZVZTFTWkJPVXFG?=
 =?utf-8?B?b2w1Vm5MNVpucTYyY1ROZ25MQlRBNkxjem9GMy95c2wrMVhtZ3FsMWtYNXpZ?=
 =?utf-8?B?UkN1cjJ2UjZEaTZRaG5lczBBK29FWk9aZ3BoeXRKdE1ucmhoWW1NWWRnREZU?=
 =?utf-8?B?VHExR2hqeUhobC9LZHE3SnM0eStGcUpTVERTT1VCYnFTUTVrSmRZMnVPOWx2?=
 =?utf-8?B?RWsveWVzMytxSzN0ZTF3RzltczhLZDNQallHelV4SFcrRUFwWGI4cWZ0TGxJ?=
 =?utf-8?B?OG9BdE53NElRbFNWa0p0WXZuMkkyelVuK0JDM0ZIVG5LYUNRb01hRml0QlR4?=
 =?utf-8?B?Mno3ZXBDZW5OZldmZ1EyZVJncWN5Z0VFU0tObXMwN2xQSnhEbjFBcEJrcDl3?=
 =?utf-8?B?bDVVeVEzU1F4UVRpUllwMWpLMWppNUsrZitiZTVFSi96VWtSZWk5dlZLSU9i?=
 =?utf-8?B?b1gwZU04bjAwejFaSjNvRm1ud2NFL3dGZCtXRittOHVWeHFIY3JPWjR6blVH?=
 =?utf-8?B?bUMvQlB2OVBBdHVsR3I2bnNET0hhdllkcWhYb1JXOUlrWUUrR0ZOeERrSmlG?=
 =?utf-8?B?ZXFWQmx6c0JieU1rWXhuYXd4dzNBWE54VzNtRUg2VlQzbUdRZmRtV0xxRmdz?=
 =?utf-8?B?dU1CSFRqRTR4TzVkL01XSm9nSzVXVmk5eDZveG1tcjhLVmo0SUovQ2p6Wkpw?=
 =?utf-8?B?bnhvQVE3YTJ2U2J6MkJQY0JFaGFnVzBCMUZGWDdXR3dGMzlHUzZ0cjRFVHZH?=
 =?utf-8?B?aTNlam1OeGluMUlEVGVKa1ZSYnRRb1NyZlJ4bWYvVWdtNE93aEZ2T1RLanJu?=
 =?utf-8?B?S2d2V09DUjVYTGJQUmJPNmY4SzFYOGVkNDJzRUV0U2k1SGlPaVk3MGZOWWVh?=
 =?utf-8?B?MkdxK1FjWm1nSG81YllhY3RjTWFsVUdEc0xuOUlZVzVOS3E4LzF0MmErdTB2?=
 =?utf-8?B?VWdrU29SOXJNTXBzK2JGZGFQbmxPZnhDSVB5Wi9aeVZrWUJBWnMzRHNUaEpk?=
 =?utf-8?B?eUlpcTFGYUNSdmNybjcwUEN4aGM2QlZFUk4yaVdOajlqRVlhTVBNYmhueXo3?=
 =?utf-8?B?VStGZGkzU2hOeGJ3bEpGYzU3NlkzdXZxbjUxZThIRUtPVGpFL2czTjhIMExD?=
 =?utf-8?B?QUVDODdONWZKa21BWXprTjVKZzhweEFudjRIUUc1U3U0QXlCY1IyVXhyOTVB?=
 =?utf-8?B?OXJ1Tm42NG4zYmx1VmZPMVhiZmNrMWRQL1M0eHdpd09PMU9Hc0pGOHdTY241?=
 =?utf-8?B?VTAyWFdkS2ova0RkZDRKbVc0THZHemtQa0JUZTk1RzRtUDdwU1dGRXBDRDU0?=
 =?utf-8?B?dnY0QmRjWGhkdXV6d2NXRTBKV3R0dDhKUFF0RW5xRUthSkNGYmZDMFRac3VI?=
 =?utf-8?B?T3AxMzQ3RlJTRzZPcWV0MitiWW4wQ2ZhdjBIdXBHa1U0N3JzTU5Ic0MrclEr?=
 =?utf-8?B?eGREY3VkbnBmVGNrb2RxT1RZMWUwbktSY0xhb0lqb2l1SDVKa2hWNlM4blc5?=
 =?utf-8?Q?ytnLrkGFZAmni4F1ldUvENYRPipsy9ll?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW5mL1IwYkNtR3NRMUNFMVEyVm4yR2YrUHY0VTk5UTRkSmlCaDVkMEEzMDVj?=
 =?utf-8?B?ekZaaFNZR2JpSWdmZGtneldDY1kySTFGZmt1Y2JicWtrZENEL1lWellTTVI0?=
 =?utf-8?B?SFlyRjFtOFVFQyt6dHExeSt2Qk9QL1Q3dVZTalB2RDJkY1BZemVhWFhpVmxE?=
 =?utf-8?B?a1lpN0ptcy9MaXl2R2V3TWtvZWVKQWVOSnB2Y0s4UWJRYmFGT2plY21xNmpz?=
 =?utf-8?B?cjE4emZxRjdmL2RudUljaTJpSDAxYzlaWEJWcTZCQnFFOVFQNDNNNjhGVThH?=
 =?utf-8?B?TE8vVDFTWVA0NmpkN0ZTaDhsNGNFSEs0cWFkQmwxd0VIblNWMW9iWklhVXJn?=
 =?utf-8?B?VVJTMVYwcENZUWdzd2VzNlJMdzBHVUR4TFN0KzdEWitiK3FWUmp3QWlkQTQr?=
 =?utf-8?B?ZUVFT2ZNb1hNK0puaE9EV1J4NVlZZC9LNUxsMEZRMXpOSUJtcVNkQWFOV1p6?=
 =?utf-8?B?cHZpRThUS2dJd29tVkM4Zlc0TWR5QW12Q3d5U3RZYitwUEs0NDVkdUtGVmMw?=
 =?utf-8?B?Wm5IR3NBTnNLNWdZU25pNE8rbnFFdUV4UXdxbWtwZEU2MWJBanVaL09ITFJN?=
 =?utf-8?B?emUvMFU2NkZyUHpiNVFsdW96VHJ1TStKZGdSZ051bmhnWDNIMGovQ2dDWitG?=
 =?utf-8?B?bWlvVitzSWd0ZmZMWE5kb2tMS29kQ09QK2NPbmRpRGtzRG5LU053SmY4Si81?=
 =?utf-8?B?Tmp1UDJDRFhqQ2M2Z1FJRGozTVRMVWVaN3VRblRqOFZNZ25pTGNLMHExTk9o?=
 =?utf-8?B?VTVxQWFnTHJGYU5qQW9LVWN1dFVUY1Q3UHlJQS9HQnd3d1d3TkRSZDN3eC9l?=
 =?utf-8?B?UUxDcXB6ZTVramxHNkRURllmTWZpTVEySGRxeTFuSE9HaTJLcWplTWdZTVRB?=
 =?utf-8?B?a09nbStvdzlJNjMvVGpUVUROUVBCRitBcEJUSUtIVDYvRFp1LzdUMlpsa0xj?=
 =?utf-8?B?cmw0eHo3d2l6UGJqbFZoNk9PczlwRDBGRmhycW04M2NVc0Z6aDFBcGlRdjNx?=
 =?utf-8?B?eEVCeGFodTVRellkbUd4dDNZbldHbzJYUHV5QXRPdE9HTUduUmRYNjZwenk3?=
 =?utf-8?B?V1ZSSUdEQjh2eitBSE9hYXJBeHFZWUw1VFpydXg1Qk9iUUtsVGFxMlBpQzYw?=
 =?utf-8?B?Z2MwZzNqNG8wbStLSThDSFFtK1ArQUV5ZHUyVnEwYk5HWEVyTXg4bEpSMmF4?=
 =?utf-8?B?VXFnWTNldlhDcms3bm1NVVVhczdLSlJWWWJDd0J5TUlCcU9JUGxlekJBb1o4?=
 =?utf-8?B?TS9qVWJtbEd5dWpJeWFtUkkvVU5rMDV5aHVEWWY1ck5HNFZHaG5qZmNiYkQ1?=
 =?utf-8?B?cFoxbHc5VEYyK2FwK3lLOTNTeCtOZGp3VEZpQzQzNFB5ZE5MYUlJek1JaGZz?=
 =?utf-8?B?L1N0ek9ndlpQKzIzSE9JVlM2eDhTeC85WTZTdWJKckpmTmRuRHVuOXZER3hP?=
 =?utf-8?B?bG9TUDFjSXl0RHpYZmc4OVdNWWE2L0NoazFuQlphQTcvdDVXcmEvU0pKUzBy?=
 =?utf-8?B?emVVdVhDcFU1VTFIbzFwOG9NOUJZbkxTNWZwM0pDM09sTFRMVzRRbndXNG9J?=
 =?utf-8?B?WXNEWkltV3VlSkc2bjlQZUFkMzZYWER3c29pbXNYZ3RuTlRhMUFTMTZrVmJJ?=
 =?utf-8?B?d2d1c0VrZ0ZSbE84TU93UVpsdGovK2tvNzFiTjRqWk1jaDF4c01YWE5qZTIy?=
 =?utf-8?B?N3NEbVRNZkZyMlk2akRTVEtwSTlTSHhmRDZtcWVGZnBndTllWXB4U2pPVEtp?=
 =?utf-8?B?ZmVJWDYwcTBpaUlyWkZrQm5jajh5WFdIL0VyZ3RzMFNyck0xaDlWYzN0ajdu?=
 =?utf-8?B?V1BtNmd2bHN2amFjSUY0NUYyL0x6VDlCVEZZTlU5Vk5qTWpYc3NEbUY4QzBU?=
 =?utf-8?B?c1poN0QrZHMxbjhBQ29LUkc4Uk1UZHkvQXBveXBoS3JiMCtYK1FUcm5uVnI3?=
 =?utf-8?B?WWo5dDNmZWhJZjY4eGUxM2xaSkZyTFRzZit3Y3lBQzZyZlo4TWZvQmN5cHE5?=
 =?utf-8?B?UEVBaFk3SC9HaWprMGppblhTaGl6TVVTVFNpRXRtc1hJK1k0R3A5bU9IcU55?=
 =?utf-8?B?OVVhaEVkNWM2bi95YVdzbkhtRDVHSXczZ2gwRWwwVldDaE9CZFBPMnpaVmVX?=
 =?utf-8?B?K004bDUxaWZGN2pQZHlFWTNiNE9BR0ZrK1lrektyZ3MxcDFENERrcWtVRnRz?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d52e30a1-2a58-44e8-0857-08de32cd9aeb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 00:39:38.5701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1MarE3AxZ6LQ/PqPSkxZr9ExRtc58gEdrVLa8dvz0QUmNQr7Y9+rhMQn1LZN8XBldpwU0TfWNeDCfX+7bqZDaSGEFKHC6CU1HRctMhheHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7241
X-OriginatorOrg: intel.com

--------------GsxJUlTUkNwxsY409vIcBlvb
Content-Type: multipart/mixed; boundary="------------UVvN2509IEfAPnVrVnvVN9Ug";
 protected-headers="v1"
Message-ID: <f1041c3e-5962-44a0-92c1-021b2466f7a3@intel.com>
Date: Wed, 3 Dec 2025 16:39:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnxt_en: Fix XDP_TX path
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, pdubovitsky@meta.com,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
References: <20251203003024.2246699-1-michael.chan@broadcom.com>
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
In-Reply-To: <20251203003024.2246699-1-michael.chan@broadcom.com>

--------------UVvN2509IEfAPnVrVnvVN9Ug
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 12/2/2025 4:30 PM, Michael Chan wrote:
> For XDP_TX action in bnxt_rx_xdp(), clearing of the event flags is not
> correct.  __bnxt_poll_work() -> bnxt_rx_pkt() -> bnxt_rx_xdp() may be
> looping within NAPI and some event flags may be set in earlier
> iterations.  In particular, if BNXT_TX_EVENT is set earlier indicating
> some XDP_TX packets are ready and pending, it will be cleared if it is
> XDP_TX action again.  Normally, we will set BNXT_TX_EVENT again when we=

> successfully call __bnxt_xmit_xdp().  But if the TX ring has no more
> room, the flag will not be set.  This will cause the TX producer to be
> ahead but the driver will not hit the TX doorbell.
>=20
> For multi-buf XDP_TX, there is no need to clear the event flags and set=

> BNXT_AGG_EVENT.  The BNXT_AGG_EVENT flag should have been set earlier i=
n
> bnxt_rx_pkt().
>=20
> The visible symptom of this is that the RX ring associated with the
> TX XDP ring will eventually become empty and all packets will be droppe=
d.
> Because this condition will cause the driver to not refill the RX ring
> seeing that the TX ring has forever pending XDP_TX packets.
>=20
> The fix is to only clear BNXT_RX_EVENT when we have successfully
> called __bnxt_xmit_xdp().
>=20
> Fixes: 7f0a168b0441 ("bnxt_en: Add completion ring pointer in TX and RX=
 ring structures")
> Reported-by: Pavel Dubovitsky <pdubovitsky@meta.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------UVvN2509IEfAPnVrVnvVN9Ug--

--------------GsxJUlTUkNwxsY409vIcBlvb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaTDYSAUDAAAAAAAKCRBqll0+bw8o6CT5
APwKJrR1YibJHqHPFknEdOiOkJ1U0Z9opud+Kzq4BbzzwwEA55Awn0LaAziDspSuhN+z7HkuyPaI
Gcs6I6kqbAG6Jgg=
=mfdw
-----END PGP SIGNATURE-----

--------------GsxJUlTUkNwxsY409vIcBlvb--


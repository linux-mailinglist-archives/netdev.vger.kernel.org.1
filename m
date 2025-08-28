Return-Path: <netdev+bounces-218031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C612B3AD9C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C52658321A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FEA2727F4;
	Thu, 28 Aug 2025 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkAN9HmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4A26AAAB;
	Thu, 28 Aug 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756420729; cv=fail; b=C57NPLnzFTbXhlUUPTlTxsipO54agFO34dkrpklqv9cRLWimF9iyC3loVALka8QYZP9/00zKQrjr+5jeI51iWgBsFfntaR5gwKh6e7zae+e/polg4h0jOJaH4XNSRFlt7xHw59P7E3elkkThCJWxdPGYPxKbNYo08cRjm+A2r0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756420729; c=relaxed/simple;
	bh=DswYudx8KmvtGvO5ET8+vfYZ+Yuo1X5RFNsn//M510s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6KLrnXjaeyYgIxqfyJoS8U4w8M/e8JTGH0pHYXLBdwUTSKLsRrOE1pz+43+Diokk2r0G5G10b2ZyRLOVgJCpJ+ywgO5A0YYfggcPdZpcGhN1+oZyHCVH0hR0jhhYiPeLXBU/DmDTAAeCFwZTnIxrJ4vltPAlHLXOiP0IP9xIMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkAN9HmZ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756420728; x=1787956728;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=DswYudx8KmvtGvO5ET8+vfYZ+Yuo1X5RFNsn//M510s=;
  b=fkAN9HmZGuUc+z5j5hZ5aLybGfePsEPaLiJTk7GEqpAFRc0FZmrlekVi
   27r3VMK3GijwBjOG2nZOF3HdwWU3ap34S26YI3/jaDxkeaGL8V0s/daA0
   iWjsityQL4Cz4twvJBFYrDX2NQt+A+73S25t2l0Xo/3jc21ulIpLh7W0x
   ycBbPn4C/10nvDs4KqAsAlDpsPYFh3kogu7/ddE6tAosrPF3L2Jk0w2rR
   F2ACwA4S9B7V37FS+heX642RjSHKBA7wqTMMDIMzqibGOrSiMMJT+a3Py
   m23Z4iesgmP5KQa39F3eDYO6BwiQS/PsNQpHMAaq+0Nq+6fYqr+vXS3P4
   Q==;
X-CSE-ConnectionGUID: fZdcW2/vSDOpUsVJYuePKg==
X-CSE-MsgGUID: xn4+6wXtT2iEh+qJdx37tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="46277036"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="46277036"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:38:47 -0700
X-CSE-ConnectionGUID: F7Nb8/1vRGyJUm2jPhQxCw==
X-CSE-MsgGUID: TDkwted5SGO9hms2Y4hp2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="193893760"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:38:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 15:38:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 15:38:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.65)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 15:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=El4F6olp9fybf6JcGIsVf3cRvC1su4MVlsNGLnRsvl0RNejdaWaxbVwVmAIP6IJVXTCuWTehb/WhWqrICQ4Z6Dq9ObreubR8AL/pFbTjveWvHqDDaBEHNhig6XisQ4fQBj8dLm3F174kDHG6V7tZya7d9i24Bp4WTOtBGjvQjc9T8jTWee/9vMAWy1GEveFS/X8TO5M3t6tkZFvf+EO9yR849NRJxzV8kY7i+qK29t0Frmx0aneJcVkK8Gss/mUGXPeqnJgkovQfZbPvkIKXVlZ5ehpROHEhXiR4Fw8E/Q0BJEKbRK/gKEV3q5cUu4gypODU6JLBxi03WzFirrPK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1F1NBiOYxv9SlvQWwqS6Qh+wCoeVgkD1+46N2rsMJ8=;
 b=wQFpgpGdB6bqRg16dW89UvZ1AiwmlU8PkkPE65gWXaL9bjJYS2vDopOYUZVPdMkjcMm09wqi05LW6DclEEgOQvFHpOM/X3B/7y7lC0vGk25/IyhwacbWF+pDVpgWuatzcYKZJnggzVvBfQpb8rOV3ndOL4qxnaKFfyIg+qA3Ql1iIAyaNmS4z6YN70COM2hSy9xiPwvCBwT/Kx87OMnye+cTDhNU4rr2s+GKR77s8r+MUWvD0DcMknI/5NqhpcaZwUTqEoF7JIL2j2744A0KC9x5R41gHH06UMxx3vXS7h01X0RWHe+PDZgkOqYYvoBj0wRR9Sq9uKlK7Yp8liq25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7726.namprd11.prod.outlook.com (2603:10b6:208:3f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 22:38:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 22:38:39 +0000
Message-ID: <a929cf9c-dc65-48aa-bff4-7622d72c983d@intel.com>
Date: Thu, 28 Aug 2025 15:38:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] RFS Capability Bypass Vulnerability in Linux bnxt_en
 Driver
To: <qianjiaru77@gmail.com>, <michael.chan@broadcom.com>,
	<pavan.chebbi@broadcom.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250826162609.35108-1-qianjiaru77@gmail.com>
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
In-Reply-To: <20250826162609.35108-1-qianjiaru77@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Glk3bc1xbvacfGk4duhYT5cB"
X-ClientProxiedBy: MW4PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:303:dd::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 91053678-e2ec-4819-18fa-08dde683a250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTI1SVhMSnV5YXFpOHlYbkRqaXdrRFlod0dVUWJ3bkU4bDI5cTN5NElOQnlL?=
 =?utf-8?B?VDJ5bzM1bnZXK2pGQmRKVExva29WUjI4ZkRxd2k5R25WUTJNUWI0Z1MvY2Vq?=
 =?utf-8?B?QW1nTjNaZmE2dXF0NWNBK1pPVXNrdnEyWE1YZFc1TGxHVzBrTmo0aWhhcklr?=
 =?utf-8?B?Mk5Bend3M0U0WGtNaU1QVmNvZUl6U2F6c09GelU2VFRtRFNHSGwxMk8zKzkr?=
 =?utf-8?B?aFpiTXZtWm5JbUYxQ1F4VUtPaEJzRDlkUVhTQXpnbXlrYVBhTUZSd0daZTdF?=
 =?utf-8?B?WDZqbmg5S2d2dVNsRDg0V1FaVGllUm9wWmk4R1FndnBTZGpTY05YQTlSRWg3?=
 =?utf-8?B?NVp5bEtZSXJFQ1RCQmpaZ3grYWtTV2c0VHFrOUc0ZnM1WFZ2Z3R3eWx6RU15?=
 =?utf-8?B?OHdLbjF3OXpvMmdzY3FaSUp0cmVrQWJsa0twbWZjb2FnaVZRRnJTWXFJUXgw?=
 =?utf-8?B?M3FTU2cySGljSFRjc2JkZHh6N3dZN3VmeFF1bTRyRjdaS05lY1pPZEQ5STdQ?=
 =?utf-8?B?d3ltWGI5cDhmdFNQY01ibUtnc2VydmViSGJESHRxMXJ6WlQvVjF2ZlNKMlN2?=
 =?utf-8?B?SENRdXEwVldnWU9XUGJRc0VqYllDVDVacWl4VUtCajRJUXpRTGx0TEdzcm5G?=
 =?utf-8?B?Mkh6Q1IzZm9mUWJzSlpKZk16cWlJK3BRMkRydGdnVVNybllUd1JjLzZUMnU2?=
 =?utf-8?B?NnBHVlBDQjl0aHo5MmFhVlpnMG5nQ3BSUXQ5TjZBNkl1aHA5a3F0Q3pMaWNo?=
 =?utf-8?B?SXlHS3QwcWcrYW4rS2s2SEZxcHNHUnlETDFOYU5EQ01kN3NqRGRWbFRsenZ3?=
 =?utf-8?B?dmwvYUV1cHdRa1EraXh1OXRUY1FKWGp1aUNtQ21oMnVGMUtaZmRLYlo5ZXFu?=
 =?utf-8?B?bTNXcVByemVsZkNFM08rZVFXbWUrODVkYmJRR0FuRis4YkRnQncvSGRpbUlE?=
 =?utf-8?B?eTYyWnVRRUdsTjVoTlo5SCtyMmNXUUhGVE53YnZTdXNlS3pnRHp2QjhnOU9i?=
 =?utf-8?B?QU9VOXZ6YnpLbFQwK1BEYVNQRWFQOVp6MmhIK0wvTllDc3NqcXdINjRBNHM3?=
 =?utf-8?B?QXBENlFmbWIyU2ZXaE5Sb2t4amlWdWRIY1ZGNklWZ1psVE9zYUovcm4zVGcz?=
 =?utf-8?B?NjdSMXVKSlo3eHZ3RUZPM25nZU5hUGNVeUpUWHl6R2ZNMndRbjdWN21jTVJO?=
 =?utf-8?B?Yk1vSENpNXMwVUdBczFMKzJ6OWtxSE9sYVRHdU0yZHY4TGN6WXpGVVlBVGla?=
 =?utf-8?B?VkFQbkZjVnNnV2ZiMHdNVCtxQlVvd25EbTlndUxXMHNROWFvSXVsenZXdlVz?=
 =?utf-8?B?L1hiN0V6dWVNWmxISGp2MWF6RTIxSDVkVm5VZ2hmWHNOUEROV2hVYWQyeG1J?=
 =?utf-8?B?Q3JiZVFxS0dYdTFHQmh5UkNIVkR1OUtuNWxRS0hlc0p6cHl0V2I4T1k0NVR5?=
 =?utf-8?B?TE9ZQ3lxbkdKU1VtcWo0empRSTJXVmt6eWU3MmltMHVqek9SNTkzaHdzWEk4?=
 =?utf-8?B?Q1hWclpORmlaSWthVmYwVkJreXVRTWN4TFozUVdCUnp2dGo1OG9FclZGS2hD?=
 =?utf-8?B?NWxNZUdnRURzNmpFWkRFVTZnN3BnQ0l4emRneE4rOWxvWFlKUmZ4ZVBpbUZn?=
 =?utf-8?B?UkwrRWc4a0FwcHNEend0MlpvQnlRck1EbTZxa3pKc1MyQ2FSdkRudytpQ2Zu?=
 =?utf-8?B?M3Q1MDZDVHNGZCtqUDFDWlkyVG5XZXg3a0J6dkFoajhMb0xXdytsa2Z6N2Vh?=
 =?utf-8?B?bGEvc3dnL3BZdG5WMjlyaFNjUDVGVHRkUHlJdlZZVXplQ2V3SEFSU3hsZlpV?=
 =?utf-8?B?REpZQ0twUjdOalBGQktYd0lxK1dtakJWZmtBdmVVelVMVVNDN2F1VFRWaFFm?=
 =?utf-8?B?aEhOcnhUODY5aHZFSThYOFdHNUVydTA3ZU81eFBuOXZ3V0lRenYyaDRQcDly?=
 =?utf-8?Q?BDPOP8dZHzg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFXUzAycDBQWlJpOVFOTkdiTWJPd1l2Yk9hNnhCWGs4OXFRa3FPaU8xMUN6?=
 =?utf-8?B?T1V3RG91ODNMeHZXNjV6OFhNckNYYmc1TzhPNXB2bUFKK2xqRk9rOXVVem1Q?=
 =?utf-8?B?T3R6M0R3MmN4dEhhNlorMHlUYWdGL1dmcmMvU21TNGU0aXN2d3RrUmJzdHFr?=
 =?utf-8?B?T01SMTlFcEZkbEhxV3VuaXU0TjY2eUg3bk9sMFpFdHhGSHhyTVlmSjZtQXlm?=
 =?utf-8?B?ZTZpL080NVczQTl6a0FDOGJUb3V3alVHWFViRXArSEhCOWEydnhsMEN0Qmc5?=
 =?utf-8?B?NStoR0FlRW1ZT0VNbk5WWjVxOUNMeVY5d05ZdFg5VUs5ZHBBVm0wZkR0YzRZ?=
 =?utf-8?B?M1RlSGFhbzEwTUh6MGxpaTVxVCtpV3ZjOGE4TU1YQkVMMndtK0h1QVBiRStH?=
 =?utf-8?B?Z2VsZkpwZm9Wb21KWXVLMFkxQWRlYytBaW4xVjI1ZVIxT25sTm84WWU0a0RP?=
 =?utf-8?B?Zi9FVWxBTTQrNFZNMVJ6ZjQrOW1UNXlHak11MEVRR1Mxc0FmbndRa1U4eEE1?=
 =?utf-8?B?NG9Kb1BSRFlHQ2VJQ1p6UndYZEY3dkxienlLZUFMNVVDMlNDVTlqQVZlaW1I?=
 =?utf-8?B?VGNXaURqcXVVMWVmZ2tma25mZTE4ZVlmNlBnK3BxMmdHcWpMMXFOZFhkTVBl?=
 =?utf-8?B?b0Q5dzFsV3JlTWdlVm9QQjIwSlpIZW5hVmx4dDIvaGpnMDdxVmc2YXFGalR2?=
 =?utf-8?B?SXczL2pjbGFnb2R5RnMvc3EzWkRjQlJRaHhrQy9SczhQZXBEUW5sYnVJbFZR?=
 =?utf-8?B?WXRnbjhzV2pPOEd6blAzOFJ5NEZ4Ty9RNFlXREdLeW1oVUR1Q3hjaFE0SWpH?=
 =?utf-8?B?OXpzZHMvY3N2ZXJjUEE4c0ozZFZtdWQzODZnckliaktCTlptR3BtelRWb2Jh?=
 =?utf-8?B?NUFyaGxwQmo2TGc2QjZ1ZHlvQ0paOWd5QW5JSkJ6WU1Yc1p4azh5RFBSSEp0?=
 =?utf-8?B?QkpxL3pKWFg0QmlvMkp0eDQ0VmRyMCszSnMySkRXTk9LWnN5TVRLZ2Z3YVB4?=
 =?utf-8?B?MDhPYUFxYk1nei85ODRoRDVZUStXTjE4OC9odFAxTFdNaFVIeWZBUjhzeEhm?=
 =?utf-8?B?b2FOaVJ3L21kS1IrN0YrNVdLcyt0NlZRUWtqcmpKYUpXdnhiQ2tubzFyUlFz?=
 =?utf-8?B?N0VQcWxyZ3NtTnkxNjZ3NnVYeWQwcjFxYmpqVXo1ZUxVUGErajhYdkVxWDhk?=
 =?utf-8?B?RXBneXNObWwyTmlGNzlWZTROV1liSHEycnpjUnZFeEhRUWFIdXBGQTlMRU9F?=
 =?utf-8?B?N1JIV0VKUFZkWUVIOTFVNFZmOGNjTTdsNnErK2RTU2ppMXA0OXIyaVA5RXo2?=
 =?utf-8?B?UnJNd0Jnd1lzNkVCWDd6b0I2cHVnRDh0V0lyMWVpUG9ZamE2alRvNmVIV09z?=
 =?utf-8?B?QkFYK3hLUDlxNGs3MTgxbmJUdFhjTFVPSXdEd1R6bjhJTTRuSXR0SXQ3ekZk?=
 =?utf-8?B?SUxmNy9OSllFM0ZnRlBMZmRHVVk3dEtnU1cwT2lqMm1la3N5Ni84ZWh6TTBQ?=
 =?utf-8?B?ai85MCs5OVYvMnZJZHE4OTh3Wm1rYVdRQ0s3R3AzaVIxbDhzcHVlQjh5NG1u?=
 =?utf-8?B?OXJ1dU9yZ1lLOElsaE9YMkVzUmFlQXE3aE05MHFYQ1hTZGNaN203dWthV3dr?=
 =?utf-8?B?N05DeVAwbEsvQU92dEE4UzdPWmNqeGgyL3ljUUY2SERLaW5YS3ZBZm8wdi9i?=
 =?utf-8?B?QmFVemRlSG9CNzNyckFERmRoOGI0QjU4NXQzRFo0YjluYU9qWDhmU2lac3VL?=
 =?utf-8?B?Z2xsNjZPWlk3NURDZFlSZngvRWhHWFR2K2R4R1ViSFM3VC95cWplUmZtTVpq?=
 =?utf-8?B?cmhYOTEzZzhCQVM1SmlEbE52UlNPd3VPbVFXNUVqS3BIUmxQNHpOUVI0S3JC?=
 =?utf-8?B?bjhkMTdHMlhYeGxaejBWRWVBQmVEd0lJOW1Xc2xEa1RuTFNxNG1KNE1nendp?=
 =?utf-8?B?NDZwVmZ0RkZuQlNhZ0s4R3N0YzA3UGh2akNRS3pwRk8zNnd3VVJXd2lEbnhR?=
 =?utf-8?B?NEg1dFczNmFRUTBwMG1zdGFnMWdTVE5scTVkVFhjZkE0OU5KTGhZd0dJbzd2?=
 =?utf-8?B?ZExPSXhzSDB1bzZaYnh0UTVtL29WT3FpazduV3VEN1UweFJWU3FPejBybTdi?=
 =?utf-8?B?RG1vMUNFRWwxbGdDbXBGcExqd2gyQWd2R3plbkU1R3ZGNE42K1ltVS85WnBP?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91053678-e2ec-4819-18fa-08dde683a250
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 22:38:39.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7cb1sEmZ1z9OXcuYOn5+2vUllDWbt2vHRL5Lu5sKLigytPCz4fL/C8Gl0ejruL19WFZi0oZ3fvR4c+uBcvAHc7D2cxQlVahfE2eOTpQans=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7726
X-OriginatorOrg: intel.com

--------------Glk3bc1xbvacfGk4duhYT5cB
Content-Type: multipart/mixed; boundary="------------rXlvuT3fK8d123jKr7ZyhtD1";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: qianjiaru77@gmail.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <a929cf9c-dc65-48aa-bff4-7622d72c983d@intel.com>
Subject: Re: [PATCH 1/1] RFS Capability Bypass Vulnerability in Linux bnxt_en
 Driver
References: <20250826162609.35108-1-qianjiaru77@gmail.com>
In-Reply-To: <20250826162609.35108-1-qianjiaru77@gmail.com>

--------------rXlvuT3fK8d123jKr7ZyhtD1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/26/2025 9:26 AM, qianjiaru77@gmail.com wrote:
> From: qianjiaru <qianjiaru77@gmail.com>
>=20
> A logic vulnerability exists in the `bnxt_rfs_capable()` function of th=
e=20
> Linux kernel's bnxt_en network driver. The vulnerability allows the dri=
ver
> to incorrectly report RFS (Receive Flow Steering) capability on older=20
> firmware versions without performing necessary resource validation,=20
> potentially leading to system crashes when RFS features are enabled.
> The vulnerability exists in the RFS capability check logic where older =

> firmware versions bypass essential resource validation.=20
>=20

Do you have an actual crash report?

> The problematic code is:
> ```c
> // Lines 13594-13595 in drivers/net/ethernet/broadcom/bnxt/bnxt.c
> if (!BNXT_NEW_RM(bp))
>     return true;  // VULNERABLE: Unconditional success for old firmware=

> ```
>=20
> ##Vulnerability Mechanism:
>=20
> 1. **Bypassed Validation**:=20
> Old firmware path completely skips resource availability checks
> 2. **False Capability Report**:=20
> Function reports RFS as available when resources may be insufficient =20
> 3. **Subsequent Failure**:=20
> When RFS is actually enabled, insufficient resources
> cause driver/system crashes
> 4. **State Inconsistency**:=20
> Driver state doesn't match hardware capabilities
>=20
> ##Attack Scenario
>=20
> 1. Administrator configures RFS/NTUPLE filtering=20
> on device with old firmware
> 2. `bnxt_rfs_capable()` incorrectly returns `true`=20
> without resource validation
> 3. Driver attempts to allocate hardware resources=20
> that don't exist
> 4. System crash or memory corruption occurs during=20
> resource allocation
> 5. Network service disruption affects the entire system
>=20
> ## Comparison with Similar Vulnerabilities
>=20
> This vulnerability is a **direct variant** of CVE-2024-44933,
> which involved similar firmware version handling issues:
>=20
> - **CVE-2024-44933**:=20
> RSS table size mismatches due to firmware version differences
> - **This vulnerability**:=20
> RFS capability reporting bypasses validation for old firmware
>=20
> Both share the same anti-pattern:=20
> firmware version-specific code paths=20
> with reduced validation for older versions.
>=20
> The root cause pattern appears throughout the bnxt driver codebase
> where legacy firmware support introduces security vulnerabilities.
>=20
> ##Proposed Fix
>=20
> The vulnerability should be fixed by ensuring=20
> consistent validation across all firmware versions:
>=20
> ```c
> // Current vulnerable code:
> if (!BNXT_NEW_RM(bp))
>     return true;
>=20
> // Proposed secure fix:
> if (!BNXT_NEW_RM(bp)) {
>     // Even on old firmware, validate basic resource constraints
>     return (hwr.vnic <=3D max_vnics && hwr.rss_ctx <=3D max_rss_ctxs);
> }
> ```
>=20
> ## Additional Variant Risks
>=20
> This analysis revealed another related vulnerability in the same driver=
:
>=20
> **`bnxt_hwrm_reserve_vf_rings()` function (lines 7782-7785)**=20
> contains a similar pattern:
> ```c
> if (!BNXT_NEW_RM(bp)) {
>     bp->hw_resc.resv_tx_rings =3D hwr->tx;  // Partial state update onl=
y
>     return 0;
> }
> ```
>=20
> This should also be addressed to maintain state consistency.
>=20
> ## References
>=20
> - **Related CVE**:=20
> CVE-2024-44933 (bnxt RSS out-of-bounds)
> - **Linux Kernel Source**:=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> - **Broadcom bnxt Driver**:=20
> `drivers/net/ethernet/broadcom/bnxt/`
> - **Original Fix**:=20
> https://lore.kernel.org/netdev/

This link doesn't provide any value. Its just pointing to the lore list
archive...

The CVE linked *is* a related fix, but actually has valid data and a
crash dump backing it up:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
id=3Dabd573e9ad2ba64eaa6418a5f4eec819de28f205

https://lore.kernel.org/netdev/20240806053742.140304-1-michael.chan@broad=
com.com/

>=20
> Signed-off-by: qianjiaru <qianjiaru77@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> index 207a8bb36..b59ce7f45 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -13610,8 +13610,11 @@ bool bnxt_rfs_capable(struct bnxt *bp, bool ne=
w_rss_ctx)
>  		return false;
>  	}
> =20
> -	if (!BNXT_NEW_RM(bp))
> -		return true;
> +    // FIXED: Apply consistent validation for all firmware versions
> +    if (!BNXT_NEW_RM(bp)) {
> +        // Basic validation even for old firmware
> +        return (hwr.vnic <=3D max_vnics && hwr.rss_ctx <=3D max_rss_ct=
xs);

Literally 4 lines above this,  just outside the context, we already
check these exact things:

>         if (hwr.vnic > max_vnics || hwr.rss_ctx > max_rss_ctxs) {
>                 if (bp->rx_nr_rings > 1)
>                         netdev_warn(bp->dev,
>                                     "Not enough resources to support NT=
UPLE filters, enough resources for up to %d rx rings\n",
>                                     min(max_rss_ctxs - 1, max_vnics - 1=
));
>                 return false;
>         }

To me, this smells like an AI-generated "fix" which lacks substance. It
appears as if some scanning tool found similar looking code and flagged
it, without understanding the context and realizing that the validation
is already taken care of.

Whether this change was actually generated or not, it clearly doesn't
fix any real issue or provide value. Please don't waste reviewers time.

--------------rXlvuT3fK8d123jKr7ZyhtD1--

--------------Glk3bc1xbvacfGk4duhYT5cB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLDabgUDAAAAAAAKCRBqll0+bw8o6IW4
AP9OJC5SWjnz7P8fELHX6BCdO/OxIv1hxVfiBQEtf8/n5gD+KHNtmZmOh439NBEKAd1wdw/6OwxS
xZ2vIva5gXDtlww=
=wtZ7
-----END PGP SIGNATURE-----

--------------Glk3bc1xbvacfGk4duhYT5cB--


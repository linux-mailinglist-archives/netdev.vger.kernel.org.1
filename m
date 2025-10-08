Return-Path: <netdev+bounces-228295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC864BC6B35
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 23:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6B919E36E9
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF82C0F89;
	Wed,  8 Oct 2025 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/1/Q51B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8027055E;
	Wed,  8 Oct 2025 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959714; cv=fail; b=j7dTkUkG0+J/HNLd7kR412zqSyUNJ4Kk4yYf9yCc6d2PI5kqQUfe8xxhWdFWfc0BhauANWo+miEiEw5h9cydFnI0I5Z2APmhnUOqXxzKwkm+8VY+1yi3JDubsHN/DG0LEsTdgv/sVOcD4SNSP8C7aSZSGMJdW9Ena/XR9GjnwgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959714; c=relaxed/simple;
	bh=+cbH02yNj+vETcHln1p0QXcMo7VcG4yJU5EpL2V9taY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QMgVDhHHN8vD01aIMKPP3svH+fmFLJeouCBASvZbKrxS2rA+0ysSzKyhbr5xOkHWu0Aa5WNFzy4JGCBe2YNdXqp0N9Lv+gE19O6sR0FXlkg7N1U/6uC4Nn/rHCogSaG1v43O6bfBzgw+GKr0HZ4rmKdFjPatLTu/TRu/ULr6SCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/1/Q51B; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759959713; x=1791495713;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=+cbH02yNj+vETcHln1p0QXcMo7VcG4yJU5EpL2V9taY=;
  b=E/1/Q51BFJ70BRX7/dV730OCqHpepVolZxEPlLoqD2zKdnZNSh62gnVO
   YzSm1dWPC3FOM5WJ9Y2mO1Rztp5E+XQtnugthddTasnmqDQDcpGlPVbMh
   8Nig2dJnsQaXoFBgavoJDEdHCJO2xhnRVcPClcf3LmPdHSdvQF2+bfPi/
   JIwrTyrAgPf/RFuqgSdS2SCaX4kTh5OotEZtHg3hwe/s7hfyzZ9D4ZVdX
   rgHsbm7r9My7nNIeGgLtPpqvXp3aXdILypeniXJ6pz9bjtTonYMt3LEID
   EwoWtFo/APn6jE7mOnG+gN37wpfUqsYqmNA8lqvjatemHZXNUgfKAig+c
   A==;
X-CSE-ConnectionGUID: 6hm2XfXZQQWjNUgCDiMgWg==
X-CSE-MsgGUID: 1ZvYtNKURSqcTaf/ACHJJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="49726403"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="49726403"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 14:41:51 -0700
X-CSE-ConnectionGUID: VeUGuIu9QFawwPubE4PQtA==
X-CSE-MsgGUID: Lf3pUxiMSQ+6DmSrdgb9Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="179665237"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 14:41:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 14:41:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 14:41:49 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 14:41:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr4Ubbwhf70A2mkoo905CiO5Ia1Cr20x4MN2zEPzO+Q3lISYsw5ufR1BjpAuGmaOsXVVkrdftlfDQ4EI8oIB4/GCJccBfdLPBAEeg6p+WVWizIzl3dv8Wv0DNBKV8+FqjCF9A0rsXAIidac5B0YMjgLA9owNbaF5Pddy+SJ1INPCQ+c5kpri7Ie7MowX0RjQvSGlq8q/D4h1hDaYpn/e2EyA+QcO9u87hO62hYWHzGU/SQDmAPNe4W4lVFKVVUdPQS2viZrHuRd4KXmDjnEmMizZYyRxWnEXWynbUe0i/C8hM8im/vlG48bkrk/SEtuwGEeJyAT2Rua7JZzKnf5DIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsZTP8omrSQ63bNIeGNIROQLJKRkK0K9E0WTRIRB404=;
 b=HR35aXHDq6GPGymeeJw58FIJbHRPIXzVBIbUUlpPPHow55igk0Hc8/z8B7JKHt9nDr/5ac7GHSrNHohjdvCYmUwbJB1eLBZe7A1l60VgLxT+b/PcmJ5EGNVifPnEcWWF1I84qKe+xajwWvgtrHBXOANXMwDGlYn95NKy52fJBenP/xmbE848muobCFJVimGhnh5HOmZ1BwUJL5RG8EXIbFTjUyziTDFawT56OoydO8EikGOvFb+bs+DEIlyYpeePTJFUiPf0Aju2CMuzNNOSsSib1fEBMNw/kLCChynyFW3rsfa0tOnhk/LcBnmjz9cDzHsWelkv8KTiTY2AHcurDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6894.namprd11.prod.outlook.com (2603:10b6:806:2b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 21:41:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 21:41:43 +0000
Message-ID: <ae493f48-ae07-4091-98dd-db254f2ee12f@intel.com>
Date: Wed, 8 Oct 2025 14:41:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/8] idpf: fix possible race in idpf_vport_stop()
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Pavan Kumar
 Linga" <pavan.kumar.linga@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Phani Burra
	<phani.r.burra@intel.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Konstantin Ilichev <konstantin.ilichev@intel.com>, Milena Olech
	<milena.olech@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Joshua Hay <joshua.a.hay@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Chittim Madhu
	<madhu.chittim@intel.com>, Samuel Salin <Samuel.salin@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
 <20251001-jk-iwl-net-2025-10-01-v1-3-49fa99e86600@intel.com>
 <20251003104332.40581946@kernel.org>
 <4a128348-48f9-40d7-b5bf-c3f1af27679c@intel.com>
 <20251006102659.595825fe@kernel.org>
 <048833d9-01f5-438d-a3fa-354a008ebbd3@intel.com>
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
In-Reply-To: <048833d9-01f5-438d-a3fa-354a008ebbd3@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------QIqlPG5WBpJ0Po19oeiyfZ3M"
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dd01ea-dfb2-4a51-2b4d-08de06b378a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azh6NW14ZHpKY3ZiOW5saTdLYURJaVdHTW4rb0RQTkhyYmNUVTZodXpMdDEr?=
 =?utf-8?B?a3hDQndoQUc2MGRpcUlMTm5LcEJVL0dLcUs2RGVBSWVQbjhXVno0dTFER2JM?=
 =?utf-8?B?OUZGOEpqSEJTK29KU053VFlNbVFRalczNTA1YmY3KzdHRGpvSXZBREZRREJu?=
 =?utf-8?B?eTd2OUlrNjJ0V2NrM1JVclpHSEthOHYyeEZlWEl6VFFjSlRoTW82WkJEWDdp?=
 =?utf-8?B?d2c3aUdnQ2xuUEFJb1Q5bUFad3NhUkt5Rk1BQ3JQWGFzR3hjVTc4Vkw4aW15?=
 =?utf-8?B?TmRMTmlTUk55dzkwRmQwVkpkbDV0Z0hpNm1vdnAvVlFUVFM2d3dPYUVOellC?=
 =?utf-8?B?WTM2L1UxNzdrMVFPR0JUUm5jeG1FTXdySkF3blo2d0lhZXAweVV6Y1J3cGEv?=
 =?utf-8?B?TU5RT2dzNmZFK0cvUHpJYmFuaVRid3BCd0N0N0pkUkduTTBTRW8xVnhoZld3?=
 =?utf-8?B?L3pKbTJ5ZVAxL2FRWkVsTVhXWWlhQ2ZHc1QwS2pCMXRFbmVkdDZOcnJzL0Uv?=
 =?utf-8?B?eVliM3Nhd3ZkMWtXWmk1NU5udGk5d3lJZXEvUFlLb2t2TTNlaDUwZjJ5MTdp?=
 =?utf-8?B?NWJ4cWJlL21USTRIRk4zZ0xUWjlzODY5bmthOVJwZ2Y2WDhBalVTdHpwc0tX?=
 =?utf-8?B?ZVRJVDBVZ1BITzdrdFp6RkFIUWhLY3dVY1ByTm5ReUpNU3ZkSndQQU9yZTg5?=
 =?utf-8?B?WnRHMk14aUpUK0k1WlA0ZHJ1RS9mMWlDQmJ6d2lMWG5nQ0o1Njd1V1A4empE?=
 =?utf-8?B?c0JOazlPVk10dXAvQUR0QWdXbU1kTG1xdjY2UGxJamplWldyd0QvQ2JHVXdh?=
 =?utf-8?B?VXc5cTZDN3RkQ2RzZUQrYW5RK2h5dDhOSmp3YVRUMUsySlF3YnhFekc3cDJF?=
 =?utf-8?B?ZXV1djRvUlZZZzBLZG5LYlAwb3dXMXg3U1Jyb1E4anA0RnBmMXdrZ0ZSVVlR?=
 =?utf-8?B?WDBKZXVuSUtuRkpsRm9oSko3a0JrTlIzaFN5WCtjY2pod2NIVE92cDR4ZWJU?=
 =?utf-8?B?b3VjUHhaM2E2U1lYM0FDYzRzemwyNElYQmV6alZQVzRFWDJFUTdmZVN6R2t2?=
 =?utf-8?B?MmFNaHJRWWNHMXJmQXJxMWRXVUFrYmZIaG1XRXdmTVI0SVQyY08xOHYvUitQ?=
 =?utf-8?B?MEs3MDlGUUkvTDNBbzcyeFJSMEtLUzRRdjRLcldWSnBubWlEZlBHMUVLcUtR?=
 =?utf-8?B?NHdGRW9Qa1VCRWNUYS9wVmRsMjFaRXMzVzJ3OFFWUVhRek5TRXRza21PY1Fz?=
 =?utf-8?B?TlpNc2ZlbGtabWhkUTdSVlBTUzhHQjhYdTFnS3JyYm1CdGFSQmM0bXYwYXJG?=
 =?utf-8?B?MkNSS0JKOXUwY3VWT1V4NG5CcnMwOGd3K0Q5aTNmYW9XOGxVUkpkVFJUZXFS?=
 =?utf-8?B?S2R2YWVzL2tDenNOb3hISGEwZVJSOXc2c2M3L1FHOVE5VktkbHRpdnEyTHYw?=
 =?utf-8?B?ODhkRUIyVzMzWnloeG9yUVVzb05kbjRCbjIwQXZpVlBoVFVmR3g1dTZVcktL?=
 =?utf-8?B?R2FlNEdyT2dONzBHUmI0Nk9Pek05YldJbWNYTmUyY0EwTU5BYjJiUDlza0J1?=
 =?utf-8?B?cm1vVmszemFZbUFlRkw0aCtSUjFBd0FVVm5hNTRmNVpIekdDbWx4Z2czOW5z?=
 =?utf-8?B?WlorQVM2TTlkYk13S04rWW1wMis4dC8vVmM5OTI0RnVBMzRPSEtIcHdyKzly?=
 =?utf-8?B?bmYwNjhJeU5JREF0NlAyeGorNVJXMjlnZDZabkFyNmd5citOd2JmVU92akFq?=
 =?utf-8?B?M1p6K0hJSTFYMFNaYkU1MEhQOXduUnNqZlI3cXVsTkMzSjEram5GM3lWTVN4?=
 =?utf-8?B?M1h3YzBmVXNrTUNDL2YvOEh1bTY3bVZwNzVLYkFVR0tPOVpHKzY2QVF0K1k1?=
 =?utf-8?B?TmMxa2trMTRiMjhxOTQyV3lickVkUjdBSXozSW5aWmYwajFOYWoxTkthWEZm?=
 =?utf-8?Q?fi+y5SgI1Hbwyfm8EPXukOONLIKj1lOj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXEyOWJadk5pVjNVcEJZREhPTXJRdmZUQXFoME0vSFo2UE5ZR25RWEJsbGQr?=
 =?utf-8?B?a2RKcDFnTCtMZjhBK0NTMS82dnFyVlN6OVhNdmVJQ1NBdUdQS1ByK2pSRzE2?=
 =?utf-8?B?dFozK0RvUnlnUnExWG5rZk84MFV0RFRRNWZyNXlZOFhJeGZJVHY4Vk1BZzdl?=
 =?utf-8?B?M2Q2anR4OUdlQldZV25OYzBVWjkzcWRBMWduczE5Q1FOUnMxT0pGNm1lc2wz?=
 =?utf-8?B?bHVPVjRlMDJvWjJvbE1aV3E1N0ZjdkhONE9zNytOZjJ2YjlOZTByV1laY1pE?=
 =?utf-8?B?VTJxcHFwWktXRGJXaG9lbVVPSk80cEkvRFJIK0w1amtBZEpzTlJ6QllHMjNj?=
 =?utf-8?B?alFEMHQ4UkZCVDArQXM4dGY4Y0pRaTZBejY2elo4UHZpVTRjMUpmekxBUkN6?=
 =?utf-8?B?Vk54b1VyOFczL3FEUnlHU1pSU0l1d3ltTVc0ZzFRZlVMY3luRkMySjBOVUZr?=
 =?utf-8?B?MUZhaVF3b1JLcDVRWGlwbVRhY2haVGdmWHUvb2lsR3pFc1I3bktJWFN0cnJE?=
 =?utf-8?B?cVNaT2pxNmtBNEtxRDVDUmZnam5jT0NWM0N1TmxDTkdKM3FacTMxbzFCQndY?=
 =?utf-8?B?Z1VXRWNsdytsQ0lHTjRGZ21PMTh0SjRqTkJuVTdHeXh3UENicktRNkc5SkxT?=
 =?utf-8?B?UkE1S0Y2dXZFbFduUnFjR1FhbytHZk1VMk5jU3l2d0FkWmZ4dnB6S3c3UnpY?=
 =?utf-8?B?QVhFUW1VWFZRRmViMVQwSkl0djZrSW5MdGlNTXNYcElITGE5a3FxcVFXM01j?=
 =?utf-8?B?NHFwVjViRFFKQ2V0VHE2OFpjMGRZWDk4UDE0MXcvaXVLWjZNaFVTRWxwUElH?=
 =?utf-8?B?VUZzdVBZWTRiYzRrRDQ2dFlReDlTZVFLK2tCRWVybmhBZ2V0S3lvYUQ1RFpp?=
 =?utf-8?B?dzZyU0tkaXhRU2ZFSGM4S2J1SHV5bmZreUJGbmRId2NrWDJmTDdwbFNsNkNu?=
 =?utf-8?B?V2YwdTVrOExKdEdKWUlveWNUZXQxclVyZ1NtbmRhQktVMm5Va1NLbXdmckN1?=
 =?utf-8?B?L0FHWU1YazA2dldGN1kwQU5CYldaR0d6QlZBbUFHcEdnUU5MNUFZaWp0Uy9n?=
 =?utf-8?B?R1RwdnNYUlUwcTFWaFZxUnFIamlCZlc2ajNQMVQ0YmxpbDlpalBUQ1pOelcr?=
 =?utf-8?B?d2VtRnpqUDE4aTFWV2c0U1JvcnFiZ1RVOThteXMxaE9mZHlGOU4xbTltWFRF?=
 =?utf-8?B?UlRZM0I2R0p2NC96dndYczlBRVVKaGFMbG8xWWkyMTVPdHBBeDBzUDRrZkJk?=
 =?utf-8?B?MDBDRWRxVGtrM1Zaczl1ano4ZURSUjFWc1dVbUxEOUVPN2txVG4xa0lmMGJk?=
 =?utf-8?B?S2NrNHRqMklJb21lUHhlZ1NFRklINzB3Y1pkVWZzdGxwUHBjNG0xQUl6QnRH?=
 =?utf-8?B?ZE45ZHBNbGplRXRLTXVGNzhXZy9JOFhWMHNJdEdPaUg0eERKR2IvWDlaTmF0?=
 =?utf-8?B?WjFFekJTSmZvbFlCOG1OUTZ6dkZTYlR2WDJVN1pzQzVUSlJkakRDVzRsSHBW?=
 =?utf-8?B?RUIvU2srdTZkelJ0elJzM1dJakM3TTdwSTkzWUFYOWgzOFBpL0VvbTloOGc2?=
 =?utf-8?B?MkhSZmNLc1JLWnR6aDljbUsrTXF1QzhYdXlkR1lncTVLUDYzVGcvVHR3VHpQ?=
 =?utf-8?B?a1grbWRzdzExSEFTTDhZZ29QYkJQY2IvNTAvT0F5QUNQZGtrbndTTkhJMzlX?=
 =?utf-8?B?NkYxRjEwNlN1cEZWVkFSSi9waStTM1lrOXpnRWlDVytyTTE0ZGxveCtPYWFV?=
 =?utf-8?B?NVRLY2w0NUZhWEZRRWsxS2F6WkxWRlMvckxmaEJNSVczOFd1Q1BLcW9HdkV6?=
 =?utf-8?B?S3pQUkU3OE81VXhqcVhMc1lIaENRUWtzSmFpdWpoRWgxeW9qT21ZYlhpNngx?=
 =?utf-8?B?TDFseGQ5dzlQMzdDWDVtRWdpSGJxZnR0MDdyK0pWdEp4MExRR2lmeTNySjZt?=
 =?utf-8?B?L0puR20rM04yTndsNmFIaFNjbWovKzJvSXNYMlBSZGRFanNBSmtmVHRrQWpn?=
 =?utf-8?B?bXBtNG5nNS92enFJTHJzVGZaYjFFQ0c4UThlc3phcllPdFBSS2lqMEpyZU1l?=
 =?utf-8?B?d2JoV0xEZ3VoYTM1Q3lJWFRDTFV1Y3Z5dnlReVY5MXhPeVkyMkFERHhNSTZy?=
 =?utf-8?B?KzhJNFlUei9JdC9FZmtVdTA2Qi9hdUNLTk4rVmc0MVdVVlRtaFNCWUZMcCt2?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dd01ea-dfb2-4a51-2b4d-08de06b378a1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 21:41:42.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnIk9hoTTtaVO1UfmYT6lTQT121QGGsXp2bb+FNmV7GR7+u1gneZ1/baCCYQcUQ3dWIxtYEaI6ukVo4Oo3DywLXIzQdhNYswL9Lm8DJMzwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6894
X-OriginatorOrg: intel.com

--------------QIqlPG5WBpJ0Po19oeiyfZ3M
Content-Type: multipart/mixed; boundary="------------tzGNokCTVRmE3Dx0ck6JSCnc";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Willem de Bruijn <willemb@google.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Phani Burra <phani.r.burra@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Anton Nadezhdin <anton.nadezhdin@intel.com>,
 Konstantin Ilichev <konstantin.ilichev@intel.com>,
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joshua Hay <joshua.a.hay@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Chittim Madhu <madhu.chittim@intel.com>,
 Samuel Salin <Samuel.salin@intel.com>
Message-ID: <ae493f48-ae07-4091-98dd-db254f2ee12f@intel.com>
Subject: Re: [PATCH net 3/8] idpf: fix possible race in idpf_vport_stop()
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
 <20251001-jk-iwl-net-2025-10-01-v1-3-49fa99e86600@intel.com>
 <20251003104332.40581946@kernel.org>
 <4a128348-48f9-40d7-b5bf-c3f1af27679c@intel.com>
 <20251006102659.595825fe@kernel.org>
 <048833d9-01f5-438d-a3fa-354a008ebbd3@intel.com>
In-Reply-To: <048833d9-01f5-438d-a3fa-354a008ebbd3@intel.com>

--------------tzGNokCTVRmE3Dx0ck6JSCnc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/6/2025 5:07 PM, Tantilov, Emil S wrote:
>=20
>=20
> On 10/6/2025 10:26 AM, Jakub Kicinski wrote:
>> On Mon, 6 Oct 2025 07:49:32 -0700 Tantilov, Emil S wrote:
>>>> Argh, please stop using the flag based state machines. They CANNOT
>>>> replace locking. If there was proper locking in place it wouldn't
>>>> have mattered when we clear the flag.
>>>
>>> This patch is resolving a bug in the current logic of how the flag is=

>>> used (not being atomic and not being cleared properly). I don't think=

>>> there is an existing lock in place to address this issue, though we a=
re
>>> looking to refactor the code over time to remove and/or limit how the=
se
>>> flags are used.
>>
>> Can you share more details about the race? If there is no lock in plac=
e
>> there's always the risk that:
>>
>>    CPU 0                         CPU 1
>>   idpf_vport_stop()             whatever()
>>                                   if (test_bit(UP))
>>                                    # sees true
>>                                  # !< long IRQ arrives
>>   test_and_clear(UP)
>>     ...
>>     all the rest
>>     ...
>>                                  # > long IRQ ends
>>                                  proceed but UP isn't really set any m=
ore
>>
>=20
> The specific case I was targeting with this patch is for when both
> idpf_vport_stop() and idpf_addr_unsync(), called via set_rx_mode attemp=
t
> to delete the MAC filters. At least in my testing I have not seen a cas=
e
> where the set_rx_mode callback will happen before idpf_vport_stop(). I
> am assuming due to userspace reacting to the removal of the netdevs.
>=20
>             rmmod-6089    [021] .....  3521.291596: idpf_remove=20
> <-pci_device_remove
>             rmmod-6089    [021] .....  3521.292686: idpf_vport_stop=20
> <-idpf_vport_dealloc
>   systemd-resolve-1633    [022] b..1.  3521.295320: idpf_set_rx_mode=20
> <-dev_mc_del
>   systemd-resolve-1633    [022] b..1.  3521.295338: idpf_addr_unsync=20
> <-__hw_addr_sync_dev
>   systemd-resolve-1633    [022] b..1.  3521.295339: idpf_del_mac_filter=
=20
> <-idpf_addr_unsync
>   systemd-resolve-1633    [022] b..1.  3521.295450: idpf_set_rx_mode=20
> <-dev_mc_del
>   systemd-resolve-1633    [022] b..1.  3521.295451: idpf_addr_unsync=20
> <-__hw_addr_sync_dev
>   systemd-resolve-1633    [022] b..1.  3521.295451: idpf_del_mac_filter=
=20
> <-idpf_addr_unsync
>             rmmod-6089    [002] .....  3521.934980: idpf_vport_stop=20
> <-idpf_vport_dealloc
>   systemd-resolve-1633    [022] b..1.  3522.297299: idpf_set_rx_mode=20
> <-dev_mc_del
>   systemd-resolve-1633    [022] b..1.  3522.297316: idpf_addr_unsync=20
> <-__hw_addr_sync_dev
>   systemd-resolve-1633    [022] b..1.  3522.297317: idpf_del_mac_filter=
=20
> <-idpf_addr_unsync
>    kworker/u261:2-3157    [037] ...1.  3522.297931:=20
> idpf_mac_filter_async_handler: Received invalid MAC filter payload (op =

> 536) (len 0)
>             rmmod-6089    [020] .....  3522.573251: idpf_vport_stop=20
> <-idpf_vport_dealloc
>             rmmod-6089    [002] .....  3523.229936: idpf_vport_stop=20
> <-idpf_vport_dealloc
>   systemd-resolve-1633    [022] b..1.  3523.311435: idpf_set_rx_mode=20
> <-dev_mc_del
>   systemd-resolve-1633    [022] b..1.  3523.311452: idpf_addr_unsync=20
> <-__hw_addr_sync_dev
>   systemd-resolve-1633    [022] b..1.  3523.311453: idpf_del_mac_filter=
=20
> <-idpf_addr_unsync
>=20
>

Jakub, from this thread it still seems like you won't accept this patch
as-is?

I'm working on a v3 of this series resolving the other issues Simon
pointed out, and want to know if I should continue excluding Emil's
patches for now.

Thanks,
Jake



--------------tzGNokCTVRmE3Dx0ck6JSCnc--

--------------QIqlPG5WBpJ0Po19oeiyfZ3M
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaObalAUDAAAAAAAKCRBqll0+bw8o6D3t
AQCOMUOxx3e8ynnKspYfB46QoLQ+8HcQMk0MFt7eYqgkLwEAtu+qQSAZ3pUGeLcWLnd339kQN+ZI
p21H5x2x0omNOg4=
=G3o0
-----END PGP SIGNATURE-----

--------------QIqlPG5WBpJ0Po19oeiyfZ3M--


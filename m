Return-Path: <netdev+bounces-234142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7CC1D201
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1023A74CB
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AA8311C11;
	Wed, 29 Oct 2025 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtvgErs7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022092877F4;
	Wed, 29 Oct 2025 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768307; cv=fail; b=hMGW/9sYkzrglCcLTvCDkga13Om/yGkJ6Cp2gXjXVs7gEW3/1NnQxvJlO0KSFb7Ah2To0pCbdyIHW6EmWxGH7ZjDCNmwoGpUtulUUJLWXd2hkXl4AsgGmfQteWiFSTXZ2XoZPDXm6izyQdjZaHgacyZpjPhvYtFajNk0XEywH7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768307; c=relaxed/simple;
	bh=CCY8mXCpkP5+Cl3AgqI5XyGA7nrgXdq40zgl6cmsAAA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K9m2ykWfdPw9gVaKaRL98pJ603inOIhqUUOZadJ6Jt0VXu4F+aDhiDDGulv4YQzVL+dfTc1zOHMXor7BEjmuoz+S6Hi3CNw7d5yaPvmQegyLT6PlJRyKeOcKNTV8ZUir2h8usYhLrFhrqwI224UXIosroXOF9yByZ5ZY6+16IFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UtvgErs7; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761768302; x=1793304302;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=CCY8mXCpkP5+Cl3AgqI5XyGA7nrgXdq40zgl6cmsAAA=;
  b=UtvgErs77gJjOQJQfJn/Wb/tn05eqRMdJ8/xNXrqJpoSZrQvw801UOTe
   1JuT8ZytXWPu2Qaw/bYprLSk2zWuKiATjHjKtmVa/KZ2aYTNE0wQbq+jS
   RG6F/o6z3c+UZL/U1pQJjzH+ISrLfd56kv+YYBd8nRPHkwAR+G7ymuuqe
   hzFr31IpvwZb6cU2ysPeX3XSuXE+RnnccrLIZn8O/tZ0uWpHC8KLowmGr
   q6xLECDxr4dltUkI8o8Ajekd3gczwsmmD5IV4Mez5aomHXMtLOInWtrIs
   vkHs6zSx8LLmMmzRYNLSmB8kFIZFddjL7ILj7/5DJZKeUFg88jxTgqAQi
   g==;
X-CSE-ConnectionGUID: KvbAsfioQIajfjhnO9b+Eg==
X-CSE-MsgGUID: efZxz7B1SWuD5DfbcGXNcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="89370832"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="asc'?scan'208";a="89370832"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:05:01 -0700
X-CSE-ConnectionGUID: ZuvomYhtTb+G7YJ4JlNidg==
X-CSE-MsgGUID: jGeYBZpMTkO5yIS5dVbg5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="asc'?scan'208";a="222977058"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:05:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 13:05:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 13:05:00 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 13:05:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdQFmaLyodlyQbIroTPuJOQ+uXPFW7l5Fy7DrhMDPxofdg2GZpJyfL1L876lEktvLzU4qVrPW9ssCnhjXTipoY7UqV70kDT9nUZAOc8Jmif8/xAROXMr1uUxxEnsIb+lfMHIxZt3kdU+uN2YhfQGIYmCRWx2+zek2enbZWlhCpGCtMKwvJPPGUbWc2nprTjvNpxxOSoNP38AaTyZzDy6fbLC0CaKVO21+dSo5dWgNDsfFpGUzq7BGaR7xl4YSk82nPj+tWEpQSyhlJPPwKlwRS9jvK/IMC/k0cpZzBi0GwZ9zYogQBuAUtx+9g6nXTrtnorD/YFIDUBMK5nYfDuIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BPaLdJln7BtpWlVPwybnUPzTzgUtjZJa97+/1Fs+LM=;
 b=TGOPdAC5gZUcQdw0btriNQXXd59ncVSc5bwAdufMkF+muesAVW/DLHq8QrsMPenDlkcK86zsWjMsPYB7tTQXJGWSzTvFb9HTkXOmwaSGp5empcuq6/GPiCJ/6LyEHImRuuT4DZ5I6BZ+bIUvi+vWP9iShuow9KidNKKJ1Y5rZw/RLNJq/7OTopQN78XTqzIqMpFTuz36s528VTiYUmLNWvBt78lLCXqAsKTga1DWcfFAoZE1+X+2Vn/knwvSkr5qtu7ujkdGo9490KnnWrF3baKhvLDWTCr9vQebWPEYM27WZN7EiAZ+DGPtfw7IYXExQwIZBFvY+aAnVuHbNEYZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5204.namprd11.prod.outlook.com (2603:10b6:303:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 20:04:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 20:04:58 +0000
Message-ID: <e8e0cc0d-3f71-42a9-b549-39840952ef0c@intel.com>
Date: Wed, 29 Oct 2025 13:04:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kdoc: fix duplicate section warning message
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
 <94b517b7-ff20-463b-a748-12e080840985@infradead.org>
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
In-Reply-To: <94b517b7-ff20-463b-a748-12e080840985@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------U7Ge50Nsv4HXbt0v610hRh6P"
X-ClientProxiedBy: MW4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:303:8f::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5204:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d95c2ee-dd63-465f-1efa-08de17266f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGpULzVINXVaTDQ3T0Fqb3dYMi9pZHlJTVhFMFA3eDd6RjNUTTB0bnFxUy9Y?=
 =?utf-8?B?UEdHSVhoTldVeHRndDhyLzk4OFNqNGV6OGdteWl6cHl2bjRrSk5aY3JoWnVw?=
 =?utf-8?B?RlNUcnora1NaRk1CUkdYZUtrOElIc2lpNnV5OTd0amNURTVNYTJyTFhyZEFl?=
 =?utf-8?B?Q3V6TGxqVTNTZTlrVlhwQW8ybEhxSEJjMC9CVy9QVFA5U3kyQ3VvcjFCbXVT?=
 =?utf-8?B?K3dyZ3NiMDc1S21lUzd2VTRKak41YThpYlVhQ3gzMEE4c2ZCenN6YVVWNDRO?=
 =?utf-8?B?bE1zaEhwTG83VVlNaThBdHdxcXowWUhCTVpvQTJKaG42SUVOMThlVklqQ3pY?=
 =?utf-8?B?ZzJWSUcycHlLZzNpa0RBTjVOdHdBU2VCVVFSQzFudXkxd2l4KzVwZVpIUW1i?=
 =?utf-8?B?YWlxVmlrQ0IrL3pZM0diblBwU3lJS2dKNWtqRHpKR0FkVm92YzBZYXE0OG9K?=
 =?utf-8?B?Y3dSckh0Qmp2Y2pjWnRyREZaZG9rT3JPcVdyT2VjUU1mT2h0REdYLzdVUFk2?=
 =?utf-8?B?T2RwaUVPaFNab0kzNUdiKzc3Y1EwdCtvZXViT04wU0pCVkZCY0VSZXNzVnN6?=
 =?utf-8?B?Yi9rY3BRZzJxOWU2L01XSHZNRlc2R0xyaXN4aTNLNHV1UyszSjYxcG5taEZY?=
 =?utf-8?B?T1Y1S0haRVNNQmdsS2pXMW1HbEhYbmlEVE9yTnI1YzRLcFZZVURyZUtnR093?=
 =?utf-8?B?MUxLWTNRQW5lS1pIUC9qU0E4RWtGS3FESEdKT3ZtVGFRRngwNlVSNmsxOXlE?=
 =?utf-8?B?MUZXUzNjZDdDb2dMZGNmZDluaDR5bmxQWlhkRTY0eVBNZXZWdW9FS1dPN1hG?=
 =?utf-8?B?dkZJYXFublk3MDRNRFJLN0laV2E3Y2s4K3BZbHdsZm9reUh6NzQ1YlR1cHN5?=
 =?utf-8?B?NHh0OC9Oa2h6RTNpakNEM3U0V1pXZ2g5NnZ3ZzEvMVFxL2c4dTY4cHZ4SFA2?=
 =?utf-8?B?bjJYbHJjT05UVEh3bmt0VVVFKy8zZUR0WEpTMGZNY2pLWGw4TGh3T3NCSzhN?=
 =?utf-8?B?eGFtY1Q5blAzZnlpUGNySGFldFhwTUY0K3YyMENtSjNuNDE0WEI1bkUyME1D?=
 =?utf-8?B?R1lnWW1yKzFiWmpIWWloSlZZdE5vc25oN1hSbUoydE5OSXdNRmIzcnVCNzhZ?=
 =?utf-8?B?M3pXdmo3VTQzSlQ1ZWFjenQ2SmQ1cTgzc1QvWGlFMjNxNWlOYzlwN1g0NmpS?=
 =?utf-8?B?VWZiNE9WdVgrOTQ1TStOcUZ4UWl2MW4xTnhRUSt0WncrcFZpZ1ZNd1hlRjBW?=
 =?utf-8?B?UUwxSC9PV0FoSXdtQjBqbTZlVmYwODB0cmp3RzFZVkN6dkRaTFE3L1IyUmpy?=
 =?utf-8?B?YmRjb0MvdmJWS05ybUR2UVdXeHN6WGg4b0s3VkRIWXNUQ2lkekpMWHc1OGxr?=
 =?utf-8?B?YlpIVmNIVUpkNFRTbkxMT3A1T3J6Yy9ENHByWnJHWTBudit6Z280Z3FPQnlD?=
 =?utf-8?B?L3VHVi9ZTVI3aklOVHh0bVg4SVE3ckFROUNSOFNwL2xrSW8vR3U3TnF1TWl6?=
 =?utf-8?B?b2VvMzA0SzkzYWR0RG1SSFFHdDJlQkJ4R2NwMzc2Mnk1Y2syRWdLUTA3dXhy?=
 =?utf-8?B?TFZ2YWFOVlRxOER3UTNlTERuNFZjTWZieGFqL01EVGZuQko4TnkwRUUrbTBO?=
 =?utf-8?B?MmpYSGpNUkZtTEdnR1NsQUI2MW9IYkNVYmF5dzBZdFIvQ1BwMmNaVlVZRGVu?=
 =?utf-8?B?RTZVMU4wOXl1cHpwQzd0RUxjbTc0OUxtaFVDUjZkTDVVV2k0YkFpODJwdko5?=
 =?utf-8?B?b2FFR1VwRTNsUWFIL29jYjFUMEkwMmNhaERjb0tBQ2ZXZlljOG5aRmdvc3NY?=
 =?utf-8?B?L0hZT3Fvam8xMlMxMXNsNzlmUW44aUVyWWY1Rk5jamxaRTFzWjFaQ3lORHAx?=
 =?utf-8?B?U2xmdjI0M3VrbksyREhRbmVsVjhBVnNic3Y4SmVoS2pqTThLMUFjc3EyVnZi?=
 =?utf-8?Q?dhS2vVnlYJs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE1tci9SVFpJdmFtTWpiN0FBRmNTTytDcFkyWUlOMGVwMng3ODBoMythSXpB?=
 =?utf-8?B?aGJTTkJ6OENScXZrL2xjODRhd1hiSi90Vm8vcDhvVE55Z1hQU3g3NDAxNzVW?=
 =?utf-8?B?aWM3WTRSNUN3THVyYXFkTGxQeEtqVWZWaXB1L0FSYlBydC9MZ3ZoYmwrQmE1?=
 =?utf-8?B?VWJGL1FLdnhPU0ZLTzNDSHd3bW9CRTgrMjd4UEl4VGRMci9NS2NGZW1Gd3Yz?=
 =?utf-8?B?aE10c2JNT2NaTnFPaVl0dkplUXRPeXl5cS9meC9RL3l6VjFySE5UYjV4Vkll?=
 =?utf-8?B?Z1UxelBkOW1DUGpRcjRDUHZ0VFlTNW51TjJVQzl2NFJaZ3EzWXg3cmx6U1lk?=
 =?utf-8?B?QlEralBTNFhvd2VnZ2xWcEV6UlE2SVNFMlFrd2czejQ0RE1qNDg0Z1lhelgr?=
 =?utf-8?B?NzFNRkJJM3JFMGREeUhPSlFzL0E5M0xDcmthQUpBc3JjYVZOZHk1aDArQWx0?=
 =?utf-8?B?WFUrUldFVGduOGczTlBwQXJzMHRJSUhkbGw0WUtWeVA4TGhNKzRxWmowV0V0?=
 =?utf-8?B?U3NqWEdEeVBlTTkweGpoSWQ3dXFQbDVuVW5ieGhtQUlYYUFmM01qaUJRNUJz?=
 =?utf-8?B?TnpsSnVaUWJHTU1QeUdUckJEWCs3U2RTdm5peGpMWE14bk9ZL1NQZEZmWkVw?=
 =?utf-8?B?emFBcGFVa21UejVqUUE4dFNldkpJQ2lxUzNiV3BlazJwaUdsRHB6b2ZBQldv?=
 =?utf-8?B?S0NhcE9QZHowY1EvVjNpeXRrVXQwVG1MZE92RjYzaTFZYTcwTXpheTBONXgv?=
 =?utf-8?B?ZVZHalh0LzZsbGQ0MUlLbTdGMVp3ckNtRVowc0tVV2dHT3BKT0ZTd1Z6cFhj?=
 =?utf-8?B?MFdwemRwa0RBT2VnS2ZEdkdWcjVwWDJlbmZGeUJXZ2hCMXVVVllobUJXQXVn?=
 =?utf-8?B?SkNRM0RGRlFpWXNnWFZQZlZNTzJBZ0UwVVZnS2loTVN2bXFJN2J2Z1ZTRWRY?=
 =?utf-8?B?Tlo5cHFJSzIxeUs4N1VUUUVGSmJnRVNWZ2lINjdZbm1RL1FBcklSVWg0SFRT?=
 =?utf-8?B?M1IxdEF0dXVwNWhOb0llUkplQk5iRGN4cVdWT0ZXd3Q5bnRaVWQ5VHRrS0M2?=
 =?utf-8?B?STE5RGdRWXV4SnAzRC9YcnRMdkpvQlRlSElvbTlJSFp1S3N0WVJ0NXRIRElh?=
 =?utf-8?B?aGJicXl2L0syUklFcTBHQW1RRlZVTmRXT3BUa0tsOFVPZ203akZ1cGNVTjNj?=
 =?utf-8?B?SkgxcU5kSkVXampsemV6aS9Gd20zd09tMWwzZlFMU01yNktnazNqTXMvMW1n?=
 =?utf-8?B?cTBqRGpmUzQrMHVRY3UwMndUUFlxMERJMW1tUG9oVVNwTWY2cUR1bHhsWEFm?=
 =?utf-8?B?M2diWHE5dDBEQzV4eGVEVVJDQlZNSnJDM2JQdjF3ZCt4RU96a0t2QjhBbFhp?=
 =?utf-8?B?Y0J5elNwN2JDa2JyZzJ1ZWFqdUNoWlFXN1JjWU9samM3WDlOSjVJcVkydFdx?=
 =?utf-8?B?ZmpXQ3E0S1JnSWx2aVhoS2J5TkVBK3dINS9wK2hkNHZpbFVGbVcxRWRsWWFj?=
 =?utf-8?B?RjlJMklGOVRUM2tIa25RRmtyQml2cy9TUDB1WnFnOGRpSzNPMVIwNlQ0TzZ4?=
 =?utf-8?B?K2NOUWZ5ZktYUmhacDd1THBIQlBtdnozVUh5dFhGbE16TUhrZzdwM1p3NXN6?=
 =?utf-8?B?cnJzZkJONGt4cDBURFpWWGFVZ1JQVkFiTjY4VURUVm9ZczUxcmRWbmE5anpq?=
 =?utf-8?B?NDkzSm1hUGlVZDF4V2x6d0hPUENtSUJlaGRFc2JmL3BOenp6SjJEZ3Bwd1Jr?=
 =?utf-8?B?dzdoRndkZ1lwK2dRTENOcmd2elJnQlZsVkt2b0QxeHBBN1l2T1BzeUtrUmlF?=
 =?utf-8?B?dWJYOFZSd0JlV0lqV0lLVlc2bGhJT0VxRUpwa0pFUWF2ZUxOSC9ueEJSL2Vx?=
 =?utf-8?B?eFR2cVZ0aEtuMWYrVTBMQnFZRGlGbnlpY1dHK2hITE5nTVd4TExyenlTQThp?=
 =?utf-8?B?NUJ6c0VEV2FJWDdWWXFGbElTL2FSN3ZybFdwNDNpUWoxanZ2dFhLK0YvQThB?=
 =?utf-8?B?MjY3U2FvbkRleXY5a3JwclA2QkFFNFdnUW9LSVYrS2JXSjZXeGIrTi96eEVZ?=
 =?utf-8?B?OUY2YUprb3VQT08zdjE0Y3l2amR5cG9XSXBMM3h4cXpiV3lGc2ZIcjJTYmNM?=
 =?utf-8?B?RHZycGtIdGMycHhCcDVuZFdFTDlqdUxDcTd0MzdONU5STGtWaDlBQXdqampC?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d95c2ee-dd63-465f-1efa-08de17266f7f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 20:04:58.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GrwbfEBw5MSj7iCoPXCj/O0NXMJvb/T94zSoaoMzwJoMmLm38FCllNPHojOmYGeByVQ/AvMTQ128mBDo4nVpRsqLOcdFky4z1Musu8VFJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5204
X-OriginatorOrg: intel.com

--------------U7Ge50Nsv4HXbt0v610hRh6P
Content-Type: multipart/mixed; boundary="------------Ng07k0i2XNOneymMr9R0HMxI";
 protected-headers="v1"
Message-ID: <e8e0cc0d-3f71-42a9-b549-39840952ef0c@intel.com>
Date: Wed, 29 Oct 2025 13:04:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kdoc: fix duplicate section warning message
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
 <94b517b7-ff20-463b-a748-12e080840985@infradead.org>
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
In-Reply-To: <94b517b7-ff20-463b-a748-12e080840985@infradead.org>

--------------Ng07k0i2XNOneymMr9R0HMxI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/29/2025 12:45 PM, Randy Dunlap wrote:
> Hi Jacob,
>=20
> On 10/29/25 11:30 AM, Jacob Keller wrote:
>> The python version of the kernel-doc parser emits some strange warning=
s
>> with just a line number in certain cases:
>>
>> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
>> Warning: 174
>> Warning: 184
>> Warning: 190
>> Warning: include/linux/virtio_config.h:226 No description found for re=
turn value of '__virtio_test_bit'
>> Warning: include/linux/virtio_config.h:259 No description found for re=
turn value of 'virtio_has_feature'
>> Warning: include/linux/virtio_config.h:283 No description found for re=
turn value of 'virtio_has_dma_quirk'
>> Warning: include/linux/virtio_config.h:392 No description found for re=
turn value of 'virtqueue_set_affinity'
>>
>> I eventually tracked this down to the lone call of emit_msg() in the
>> KernelEntry class, which looks like:
>>
>>   self.emit_msg(self.new_start_line, f"duplicate section name '{name}'=
\n")
>>
>> This looks like all the other emit_msg calls. Unfortunately, the defin=
ition
>> within the KernelEntry class takes only a message parameter and not a =
line
>> number. The intended message is passed as the warning!
>>
>> Pass the filename to the KernelEntry class, and use this to build the =
log
>> message in the same way as the KernelDoc class does.
>>
>> To avoid future errors, mark the warning parameter for both emit_msg
>> definitions as a keyword-only argument. This will prevent accidentally=

>> passing a string as the warning parameter in the future.
>>
>> Also fix the call in dump_section to avoid an unnecessary additional
>> newline.
>>
>> Fixes: e3b42e94cf10 ("scripts/lib/kdoc/kdoc_parser.py: move kernel ent=
ry to a class")
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>> We recently discovered this while working on some netdev text
>> infrastructure. All of the duplicate section warnings are not being lo=
gged
>> properly, which was confusing the warning comparison logic we have for=

>> testing patches in NIPA.
>>
>> This appears to have been caused by the optimizations in:
>> https://lore.kernel.org/all/cover.1745564565.git.mchehab+huawei@kernel=
=2Eorg/
>>
>> Before this fix:
>> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
>> Warning: 174
>> Warning: 184
>> Warning: 190
>> Warning: include/linux/virtio_config.h:226 No description found for re=
turn value of '__virtio_test_bit'
>> Warning: include/linux/virtio_config.h:259 No description found for re=
turn value of 'virtio_has_feature'
>> Warning: include/linux/virtio_config.h:283 No description found for re=
turn value of 'virtio_has_dma_quirk'
>> Warning: include/linux/virtio_config.h:392 No description found for re=
turn value of 'virtqueue_set_affinity'
>>
>> After this fix:
>> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
>> Warning: include/linux/virtio_config.h:174 duplicate section name 'Ret=
urn'
>> Warning: include/linux/virtio_config.h:184 duplicate section name 'Ret=
urn'
>> Warning: include/linux/virtio_config.h:190 duplicate section name 'Ret=
urn'
>> Warning: include/linux/virtio_config.h:226 No description found for re=
turn value of '__virtio_test_bit'
>> Warning: include/linux/virtio_config.h:259 No description found for re=
turn value of 'virtio_has_feature'
>> Warning: include/linux/virtio_config.h:283 No description found for re=
turn value of 'virtio_has_dma_quirk'
>> Warning: include/linux/virtio_config.h:392 No description found for re=
turn value of 'virtqueue_set_affinity'
>> ---
>>  scripts/lib/kdoc/kdoc_parser.py | 20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>
>=20
>> ---
>> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
>> change-id: 20251029-jk-fix-kernel-doc-duplicate-return-warning-bd57ea3=
9c628
>=20
> What is that base-commit? I don't have it.
> It doesn't apply to linux-next (I didn't check docs-next).
> It does apply cleanly to kernel v6.18-rc3.
>=20

Hm. Its e53642b87a4f ("Merge tag 'v6.18-rc3-smb-server-fixes' of
git://git.samba.org/ksmbd") which was the top of
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git as of
when I made the commit. I wasn't sure which tree to base on since I'm
not a regular contributor to the docs stuff, so I just based on Linus's
tree instead of linux-next.

> and it does fix the Warning messages to be something useful. Thanks.
>=20
> We'll have to see if Mauro already has a fix for this. (I reported
> it a couple of weeks ago.)

I searched mail archives but didn't find a report, so hence the patch.
If this already has a proper fix thats fine.

> If not, then this will need to apply to docs-next AFAIK.
> =20

Ok, I can rebase if it is necessary. I'll check that out, and can send a
v2 if Mauro hasn't already fixed it somehow else.

> And not a problem with this patch, but those Returns: lines for
> each callback function shouldn't be there as Returns:. This is a
> struct declaration, not a function (or macro) declaration/definition.
>=20

Yep, thats an issue with the header. They're doing something weird by
doing some sort of sub-documentation for each method of an ops struct. I
don't really know what the best fix is for this doc file, nor do I
particularly care. I just used it as an example because its the one that
we ran into while looking at output from the netdev testing infrastructur=
e.

> Thanks.


--------------Ng07k0i2XNOneymMr9R0HMxI--

--------------U7Ge50Nsv4HXbt0v610hRh6P
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQJzaAUDAAAAAAAKCRBqll0+bw8o6MiS
AP9p0R7BfIKxnh1wfHDM5ysqjv/m5REWD6xDSWbkO2+c1wEApL6T5l7Q8zUmKP7ycFHSOG2q3HGe
GTsryU56uf4UJg4=
=VDXj
-----END PGP SIGNATURE-----

--------------U7Ge50Nsv4HXbt0v610hRh6P--


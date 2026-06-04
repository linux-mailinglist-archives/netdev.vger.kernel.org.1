Return-Path: <netdev+bounces-295369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5iguGUO4IWrdMQEAu9opvQ
	(envelope-from <netdev+bounces-295369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:39:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D85FE6425A3
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:39:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="Lkwn//Je";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295369-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295369-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C90F300E5E5
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00993438BF;
	Thu,  4 Jun 2026 17:38:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1B36F8FF
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 17:38:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594728; cv=fail; b=NGP4WXGJNu5YpICUVq+fP7qVSBIEUOtSJDmq1kwWjY7YFn1Hl4KAz5FB3ebePsJTBcG3PVuMf96rbhM6AFTQzk4V+87Z6n8srR3Dt+x+zahaaUcrfnGK1Z6mti3KSNYb4mc8QZCm95sfD2BDfOSBl9NIBYtUTtR4ljg1IcF4Bbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594728; c=relaxed/simple;
	bh=10kqgNwJP1Viy6M515oW44vnTYc14tf/WxWhMuWphRs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KRMVOmyR22a+Qwc4AFXa8kIRIUJ/yUsCuVAyr/e3cy9c8Alv24eTv//oDM33BJgojF4w05ILy93Cwd5WjKsPfJ6c1Tjunoo+s9n2vbGLCvuCqSKRo43K0Y8TzJdfFxipvC+pEAFWcx5Ol559Dj5b+O2yDOUuQVXTvDEiJ1Jkrq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lkwn//Je; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780594726; x=1812130726;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=10kqgNwJP1Viy6M515oW44vnTYc14tf/WxWhMuWphRs=;
  b=Lkwn//Je2498kkKtczApApB7GiY0Ye9n2K2Ce5z+xCrIZoyzZyB/cP72
   04OV3YyuB2QdSf+vX93J7gRt10dynR3kkPwakkvyLiPPYj+sY9jTy2OAd
   z3jEj+NKvGRBA4dXoj/uILyCN+AefY2wy+basVkkO3F9faX+WbtFcO+Ih
   VWtlkp+ukc5/XDHahJEjNzQdMegf7lb2AdGZeef5IZNW7eziAI8Fx3YWk
   P0Io+bjh5V3xTzs+eun1fYvUOSTFyqk/lcdvEGqwdJx9I/94nxsRwUvu5
   vyYBXKoXw4mpx2hEBxhSdRWNbvGfEtB0UlAh3gOKLafn5ZzrEwFUiiECp
   Q==;
X-CSE-ConnectionGUID: ZYICqRxqRcWZ9lTq6V32Cg==
X-CSE-MsgGUID: xyBFtaXjTueXLwSqGH2ShA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="68964485"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="68964485"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 10:38:45 -0700
X-CSE-ConnectionGUID: 4OIMuSD4TCScx1zSQaShVQ==
X-CSE-MsgGUID: dkewWaIKSCaqwVHrapfbvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="282703291"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 10:38:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 10:38:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 10:38:44 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 10:38:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReVKXF5B7k0mJ9vk/79IRLpV/QScivsR2978fORt7XUisVL7tLgQwHWbKubUXl4A5/5RSD886HBBPH5NgeVS+f8Qjk3FjxWgP+PXydzKcSk3+1gcNsT6Qkh3E3gxNH+r2xBpIbbjkR08KF+rkL0b1PuFLqaHxotw5G63TvH8BmOxm4b6V/vEEsuH54ZBQe8FmIdWXIRzuZ0+xj3IDzHYKH+5QniS03nkV0p8De8phH5K5MeXts6bi5SMjYLF9hx2dqCXCbbEyxyVV3wQpY1Kp+ChW8i+ZGTcnTRmQlqajaa0t4y+Xa8uJtoOZM4naFGM1oIYc6lDrWVCBrad0+fnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv2y6zM3XEt92EoJZfiI2PBskhLmbb3yQxDrFnw92Hc=;
 b=S2k/p1Xs/KMbaTaBhfVop0B7bs7ghs+Hk1sY8rRG5muH4xz/DrncaM/r5RkO3Bkved9mS0f6aql0qVvhRyXpHDDHRVgfCILTd6JOmQOMa/3m2nPogHTWMPMuUNJyKqlvCcz/dx4VDz1QN4+Hx05kLjeK/NB41ICTfVuRGZfLR3TqmneDvG7G4xzDG2KOa5LJp7+spkJvsi0j74QxEO1B+05XTF+vdC343h6i4DWznhsaldC+Z8qJRQ0tkdYCD5Y1AMZx9DnSHHOSQGqAxBhjF+KTyW9Wx3X/oRnpcBOSM+cxM1VRn9hKnBQOV7//xDwMIzl0WBz44PEOl2IRqbRZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CH3PR11MB7937.namprd11.prod.outlook.com (2603:10b6:610:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 17:38:37 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 17:38:37 +0000
Message-ID: <21810a20-abe6-4490-969c-cfd62c4c082a@intel.com>
Date: Thu, 4 Jun 2026 10:38:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: airoha: Fix use-after-free in metadata dst
 teardown
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Florian Westphal <fw@strlen.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>
References: <20260602-airoha-mtk-metadata-uaf-fix-v1-0-3aaa99d83351@kernel.org>
 <20260602-airoha-mtk-metadata-uaf-fix-v1-1-3aaa99d83351@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260602-airoha-mtk-metadata-uaf-fix-v1-1-3aaa99d83351@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:303:b5::26) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CH3PR11MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 10157a8e-1f94-4806-74bb-08dec2601b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ID5ETZEIeDXSb3VJyBY4tzF8woF3jfGp3ggRG/5VMdeut+EDkYfYjqfbPQWFIETMJYkKEO1tBLrt4payHax+64dAfKlkP+tBFFIDbNxxpRYwu6S0E+cE7od9CMaHFgmtuC9SQIUZKbw84UYzW0H1gmFJyN17Zj1hohGwbmulITPOBzWjWDvg4nWksSCZmM5EcxNV0zI1I8kQd4T4fyl4gCSJ9fhPhuWzrEB8MjwklxuiZmTfQOOgR7G0RzxkoPEhYpdHD3gzhrgh6q9eLUkK4GS5smZk5JGJG/UyoUdNp/5qcs0JgU9H0krOWrvTTnzB9znfR5bL+xHfqHfKcL6uUjtgnft+S8ouJoRAMyzKVOxHD6BhJtyxEYEXf2f3agFRxga2UaTztHdkeDv+AeQutqR+ZW462r/wOvqix21rfwRKa79NGPPPJrlO2SvsNrNQ9koXsUeE4zAYwD9y6qXIwpfleMVjMI3AbLuP7xO4hQWdv2gInE9TexaDlL9vi/e2gyiogQrxuS+6IHP9Hc9j1c7G7iittil5jLB77gYiz5QIH4ZUoQUR4G7202FotUbGHzVFOglOmgZOV9ARMQdWOEbA+qGsiPF2v50VBC0PM6MPv/eQyhmpnblCHYXwDtFb+SDK0eSOCPVmZMafrr535y5lDrU3sOhd3oSTJC4KzSW+uog/RWDmOyQbg2f1pKxd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2JtMkFVYjFzQzB5MXd1SGhjRXdubUJOcEg2Q0lFQlh2T3JiekcxcVdiQTNN?=
 =?utf-8?B?T1NjZXhYeDBOU2Npc0NMK1QvSmZGRGQ0QS9yOXEvOEswTFZGQVpiTVQ2L0pV?=
 =?utf-8?B?WEZHc3I4LzU2TlVFZmpWR2tiNysvbm9UUFRzcWhVaXV3aDZaYTNRa2orT3gz?=
 =?utf-8?B?WHNNSnptU25hYkZsRFREeVlKQlBRNUl6dlhaN3o5eTErMXBhTkszNEJpeXRX?=
 =?utf-8?B?STlqNUdoeXlUUmlVQkljak5BZ1V6U3FwaGJ1MnZQQk5QeXFtN01xbFhybkMy?=
 =?utf-8?B?Z1ptNS8vRHo4NUhLbEJ3UFVsallvUFM2bm5mWWw0M0pNb3lrMnV3K1pTNzBL?=
 =?utf-8?B?d2RCN1pjRUFVOEhMY1hjbVpZTjJzRFhUOTVDYVphVUtGTmpsM21BUWk2c0tM?=
 =?utf-8?B?MzNZY1N6R3paRHJzdnhHMDhhV0YzMGxCMVVjaWZ2UHIxSTJoRmJoRmlXUENK?=
 =?utf-8?B?Y1gyZ1JXczR6NEZhU05IY1ZzQXNQQmpWVE1nMkdFZWdmSmt0b0dOOHRFdWwx?=
 =?utf-8?B?bFZCdEl6dGEya0p4MHB5ejlaVnBVN3pMRjFkTCtoNXBWSHNWTWorc3NIWk1m?=
 =?utf-8?B?SnNmamZiZSs1SHhnSnROVWdBTmVzNXd2SmtHZTRtbndpK2hUN0pNNHlQMWh4?=
 =?utf-8?B?d09JMEhLajFnU0I0OGNid0t5KzN3dEQ5OHB1eWcwWU9HSUFFemJIc0ZYYjZF?=
 =?utf-8?B?M3pJV1VVNm1kTkI5ZTVUWGszWUxHTjR4ZUYrNXNCYUdGZUNuRWtRVjJXVjRL?=
 =?utf-8?B?SEpsTHpPU20xc01LZnphL2JpZUs4OXUyZ09NVEg4dUR0QlE1WGRVNlg4dVYw?=
 =?utf-8?B?OWZCWWtadDcxUUNnL3NYUlo2b25MNnI4RjgzQnBsdmVTbHcvMG1oRlNTRnZT?=
 =?utf-8?B?R3dVeEhsNTRXbmJQYzZLbjhIY0JMTmQ4TW0zbjl1QS90OFZXdnF6WFBHREdW?=
 =?utf-8?B?VUVHVVdyeHNuNjl6SklyeDVkdmVtVFBVS3ZkejhveGo5ZDZ5dEo3NGpFdWhL?=
 =?utf-8?B?TGszRGpZbkUwdmhSeTZ3aE9FSGRhb2svaFlEK0trdC92UjJ2VllTZGNkZjJM?=
 =?utf-8?B?TW4raGRBNHZNdjZObVVpdG4zRmFEWm42bU5qUlVkOEtRYmRsck5MY0dSNHF0?=
 =?utf-8?B?MVlIa3BrZ1ljK2NzeXYvWkdyRGorckFMWlcxT1ZnVEd1UlM1MnBqb0pmZjVr?=
 =?utf-8?B?OW9Fb2tQSzlheEM2OGZ0WGNNcG8vSlppZDBNZWZkem0rcjFFN1J4Vk5uZUVn?=
 =?utf-8?B?L1phY2w5S2s1c1pHZkx0SnVkSzA2TlNHUEpHVENjbHlZMjJXaDZNaTR3K21a?=
 =?utf-8?B?dzc2QnpLNFdINkEwSWZpN0c1NUx3N2I5OUJwSDJXcjk1czNJTmNyRTlNUUxM?=
 =?utf-8?B?c3lHVlorUEkxWHdZTVdsNFMzNTR5NlkzTmZ2MGh4Z2hZOGllNTBXRlRXNHR2?=
 =?utf-8?B?UitMUmdUWkhNMjltZis1M2RsMHVIZVZ1TXB4cWhIcEdhbTc3N1d2NG5wN2VW?=
 =?utf-8?B?NGtiODNpdWpWNjd5MTFyc2hWOGV5cy9zM1d1UjB6Qmptd2ZuN0l1RThxeGI0?=
 =?utf-8?B?YVFjMk16QlFaME9EWXpSM2N2bDZLNVVqenNZZEZ2RGNUZkV2eWR6SGNtU1RN?=
 =?utf-8?B?bFJ6bU5QcitSRmU2UlR0dlFOUnVIR2o2NVViRVNnMThYOXRhTWo5UGVJckhZ?=
 =?utf-8?B?QjcyS0tFeUpsSDhlNk9PMTNGU0xSS2dVdjhJNkRxYXdxSHN1ZU45ZkEzZERt?=
 =?utf-8?B?clY5L0hEL0dPWEEwTWQvcE42UXE5ejR3SVpRRVpSd2JBUW5qTXdvZjNubmtN?=
 =?utf-8?B?L2p2QnVRYjZqL0JOYVZSb0Z5Sk5Jc0FwMVFGRlhyaU1UM0kxaStQK0U1VWE1?=
 =?utf-8?B?ZW5JM1lPYmlqUmc1K2tNUTQ1VW55QllURzA4ZXJIR1VIaEpzcnEwQU90TEJz?=
 =?utf-8?B?dHFIWHRQR1lzS24yQitlcU5XZUJRbVRSUGlpbUVScWVhanlZVDA4NmFIRXB0?=
 =?utf-8?B?TE5TTnpFK0RsdVgydkdCTXBEY2V2T3orZDdLekxwbWlpc2dUbjVXY2U2ajdZ?=
 =?utf-8?B?bDVMRFZLS01nOC9TU1pXUWhvcDY4MXdhQmRUOVpEaEcrVCtpd3hpVDNsOS9J?=
 =?utf-8?B?MHNVZHR0d0dSVTlydStQVmFRWmFDNlRYR2R3SkxRbGFhRUdtcm9ldW1qaUM3?=
 =?utf-8?B?TzBLekk1OUJBMkMwYmFNRTV2WHpqTzEvcGNnelMyNVJLQ0ZjRlJuZFpDdjdn?=
 =?utf-8?B?SUk4bmNRWVdZbkV5eHgwTGxLRlhHaTladG1YUmpKV1k3K3F0YkhzdzV6RlRT?=
 =?utf-8?B?L2VVdVRvb01oSFBGTmIrRXlJd1hFM3dPNzJPTzhxZzBiNTZnQkNyTU15N20r?=
 =?utf-8?Q?HKtBPmcA0Lvoj+Pw=3D?=
X-Exchange-RoutingPolicyChecked: CY+PCxMWMGTbXaus/HB2noN1bQsGp8QzTSCQd99p73ESnG1bDtwE6ZfS+u2uosXzUgHksnQj/Qd8SRO4rO+gpoXZOOOxgL9twQRpS3GqIfbj3Drbimy/h2vc/8CcEZFogCwDlniTU9lMbbkEr3iSKsqeeSlz6ZPUWXE1cE6x3z0OjKOD9vKfEVAtblho4uHo43ISvWWNqIBPUsvNQkpaKBanMyzZ9KkK/SDGOXxLiOviWUtjnPyM6ZZm8g+xXTPpoCLOxuq2L8WulErVHxiF1EjfgK+DfP9DVqlAK3Vvom5nFEGyh800Rb5Hz6mzi3TBzv6c4IvlaOuUOBnrTMnG9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 10157a8e-1f94-4806-74bb-08dec2601b8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 17:38:36.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9mlcfJVxkDyZ3OwbWlfu8bvbcGw/1UtPLvS8g1S9IL/in+4Qp1Vsvkxt2pW9bDu5achyBmokKgt7RA3gfttegN5gGqnnW7k3w9UEF8U/tM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7937
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295369-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nbd.name,gmail.com,collabora.com];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:nbd@nbd.name,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:fw@strlen.de,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:from_mime,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D85FE6425A3

On 6/2/2026 2:21 AM, Lorenzo Bianconi wrote:
> airoha_metadata_dst_free() runs metadata_dst_free() which frees the
> metadata_dst with kfree() immediately, bypassing the RCU grace period.
> In the RX path, skb_dst_set_noref() sets a non-refcounted pointer from
> the skb to the metadata_dst. This function requires RCU read-side
> protection and the dst must remain valid until all RCU readers complete.
> Since metadata_dst_free() calls kfree() directly, an use-after-free can
> occur if any skb still holds a noref pointer to the dst when the driver
> tears it down.
> Replace metadata_dst_free() with dst_release() which properly goes
> through the refcount path: when the refcount drops to zero, it schedules
> the actual free via call_rcu_hurry(), ensuring all RCU readers have
> completed before the memory is freed.
> 
> Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index cecd66251dba..eab6a98d62b9 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2936,7 +2936,7 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
>  		if (!port->dsa_meta[i])
>  			continue;
>  
> -		metadata_dst_free(port->dsa_meta[i]);
> +		dst_release(&port->dsa_meta[i]->dst);
>  	}
>  }
>  
> 

the port->dsa_meta is allocated using metadata_dst_alloc().. how is it
safe to use dst_release here? Seems like we should be calling dst_alloc
instead of metadata_dst_alloc in order to use dst_release??

metadata_dst_alloc does call __metadata_dst_init which calls dst_init..

I guess the start of the metadata_dst structure is also the same address
as the internal dst_entry struct...

But dst_destroy does a whole lot more than metadata_dst_release so I
don't feel confident in this actually being a drop-in replacement... It
calls netdev_put, it calls the dst->ops->destroy, it releases child
refs.. Or for metadata dst entries is that all basically a no-op??

I feel like I'm missing something here.. The driver also calls
metadata_dst_free in the remove path and that wasn't changed by this
patch either.

Generally it seems like we should be using the same API to allocate as
to release the object... This is confusing. What am I missing?


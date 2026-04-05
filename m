Return-Path: <netdev+bounces-275456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I2CSK48b0mnvTQcAu9opvQ
	(envelope-from <netdev+bounces-275456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 10:21:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1718739DD52
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 10:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 173C330022D6
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52135B639;
	Sun,  5 Apr 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqCjyQvm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65240DFAD;
	Sun,  5 Apr 2026 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775377292; cv=fail; b=aLgaihqVf/QLVml+Bs7OHASeQDzIAsiN98zkX6GxFP8RdiZGJe36QEIDdSrCpJE/aGWSkMAvuRg2VcryDETduOJkoIz3ikasqq1LurH5vJHclRUDVT3LqjYq2xh0Ea/mSO1ScEyao8+GPz3F+t9az1Yz39usCnr2NeQqzyuwMFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775377292; c=relaxed/simple;
	bh=9H/HRH8gkrB+wl6518UbFm/bHZKo5B+caYo+rC3fA/Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kete1ACJ2j7/2I9E2Zh36LBrfpPYiyAoagAcVeK+r2815CCI8a6waUGqZuorb36CCxKIPSvay57BNBMZw6jzUDnQJ5jXYDAi5EteH+YWBZgbmgY/Iiz2brrlOx0Rq4EWuZkOZUqZhkNXb9dn9yBGlYRztIQ0gHgdSxDsDuTiVLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqCjyQvm; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775377291; x=1806913291;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9H/HRH8gkrB+wl6518UbFm/bHZKo5B+caYo+rC3fA/Q=;
  b=GqCjyQvme6+rBd7TcyDAtv5e3l9/o/zaeYy1AccXvuZ+G5cXHLzO57zY
   h0Qir/5uEkgS9U6ND4APDkKq5Vuor2LnI6LJ2bP55mE0jsiA28KIYaxoB
   WhnzHcxp03CnwbcC0rgZ4mqR/TX5ez+E9/bAgC3KLYriIdk+YYsup5pc8
   TxgpDIvBf8zDt0qwKE6npKDQ06FkJc0MZbiX58oxKlDGcWdcUJcWDewNc
   6WK5w/5zQzmK/hfdqHw5+8Aa720CbRpQZyT/I+OlavsshshfDUUCmbMw1
   ZLs/C3hZmgbATZRMs7JCFLsAG8ifmAHaJpGlFTNMyj7EuV9zvYL7Vs3qp
   Q==;
X-CSE-ConnectionGUID: DCKcvQlmRA2j1gtymuqGxw==
X-CSE-MsgGUID: dMYaFaWNRpOGU63QVSGMfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11749"; a="98991647"
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; 
   d="scan'208";a="98991647"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2026 01:21:30 -0700
X-CSE-ConnectionGUID: Bb54i1z7SpOPtlKuwP3NYA==
X-CSE-MsgGUID: RLeMdPMRShiN5DUon0Pd+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; 
   d="scan'208";a="226788684"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2026 01:21:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 5 Apr 2026 01:21:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 5 Apr 2026 01:21:29 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 5 Apr 2026 01:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnqfTLLbRKbSZNNwzNu8twggwHPlZ/C/59bcI5vCLfkaEwew693b5PyguSXGN8ugYW4A6FZsXyRtA8Ua6tgFk6rm7oWw12yG9x+MKFLsOtwp/hNWwdRhuVbwvU3fHOr0m1Ef/6pS+OvK4hvMN8hJMVJJnEGwGK2kV90R5dGXU0fq3PdmiDgQrwOyQivm53bTdGqf39l9IwRKcMfHoKrUK8qB6q8ld8k2rLaGsQLwddjTNbtEYdfOpqXh1yKi+havKzdu5M4NHfFyjilzufBCeDaZx49/9tCoK/13vY4rK+UvWkJMCXXdXn9fmi7FC6mlIrTLxT6x/nJzqmQ5JP2xkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/SJXgdslmii/D3YJRcyQ1Ffs0dh+1bbUJiJKCbH6nA=;
 b=gFidLjQypRclMuM+obGpq/TNSNv24bNi1QJV19emaVsDzqAgqJSXilgHyAQuGJ1h7O9tkruDphuVM8ZK0RcQF/6w6cB7U1kZAO/jMgEOF+KuW+tyYy1sj4tjn93OO7Is6fyK3xPLu3Z4/DAsK8knaiflncE+3sv6aUj9zVItqqZyrCofYpkvNdX9YCxy85FC76QAzweqSSg5ny7umbxfKsnFvlqDlpYkw4BjZQZvt3+5QaSzo44bcalCuQmLwIskNEWYqldeRKGY+1gVZevL4Miqc1K3OtJcLCqPLOQxYd1qGqk4UF49kIDqGUVrDqi8WGB+oA14hxmzyKRcIaNKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB9498.namprd11.prod.outlook.com (2603:10b6:8:261::10)
 by IA0PR11MB8397.namprd11.prod.outlook.com (2603:10b6:208:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sun, 5 Apr
 2026 08:21:26 +0000
Received: from DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925]) by DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925%4]) with mapi id 15.20.9769.017; Sun, 5 Apr 2026
 08:21:26 +0000
Message-ID: <8607e5ca-9224-4803-91ac-fc0964f79e2f@intel.com>
Date: Sun, 5 Apr 2026 11:21:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 2/2] igc: use
 napi_schedule_irqoff() instead of napi_schedule()
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Daiki Harada
	<daiky0325@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kohei Enju
	<kohei@enjuk.jp>
References: <20260331103924.36422-1-daiky0325@gmail.com>
 <20260331103924.36422-3-daiky0325@gmail.com>
 <IA3PR11MB89865406A4D4891BF48F2D47E550A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <IA3PR11MB89865406A4D4891BF48F2D47E550A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To DS7PR11MB9498.namprd11.prod.outlook.com
 (2603:10b6:8:261::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB9498:EE_|IA0PR11MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: 06da8cf6-3258-4d6b-a3b8-08de92ec54be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JBlw32H9l7JERgYUVDgarF2zKzGFY7z+xX352Q01Q0Z2SVcLAJwDL9TXLTV+9fEgBz5LimaoU3rw1g7jN939gFrr73I7Dmvji/72toLD5c/AV11IgzJ2xNPvxmkvgq6Y5V0OChW0MuQqMOPxMfioHEx2Ia822xUROoAga8jRvmsXFxDQz/ml8rBGp767y1WjddNGuUoKAmySCKdxfzD+hZ81dCjNZ3vd4XYROT4K1dE9SIWFyed21w1YY8zyYUQaiaSz7atRRfoYx8QfXS41rwqbOn1tORPNWLo4Wz5/KAw1+qD8oD5kMldgRBoPWemKTPg9sH9J57ynGUEBEiL3/U+89ex2lLQ0AlGfWLG+22DtAYFPPk+ETgpt9LzrDPgDio8jk8NqZ+U/N8HIJUb8vs5StKbl5PmaWbBXoajOFIIxOrxa9jW2lZ4PP8Iux48AC7eKC/Fx3qY4kD+aNDZckY207hsCkviEad9FCXyZWFwKLbT8OjpkAUjLswKg3wqYtXyutEhrqV77HiWQu2sFOfUGDVzeUnzh83ZxxXuhERs910/k98OVW/HuIkGhguhIiYcLeUAXfiGTLMVekg/Z4oggTnr4EEwwm/bW0Mlutr3kpX6phyUfXcXskZtSs2ilcJYX3Yd2bQGF/9o3e/kA5CvEQJSm01WUqh66ZxD3tBWNeou1ui0JpiPLPbWb6yXSODCj5C0du/Qrn6VuB6oB7k7EezvQEk3sRMijbTow0cw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB9498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE1qZGZZSlByYTJEWElma0thUEFXSzNYbndIek9wVng4ckZSSTZqOFlvakdJ?=
 =?utf-8?B?QkE5cWJObU5BbkRhYTE0dVNtVGFjRFVLWEJ1R1JGZHNpVDVYamxLd2FWK3FK?=
 =?utf-8?B?Nmx2eUI2VnlBZmJCQ29SQ0lHbWg3eUhDYUtkS200MG9QSzhIbnZ0bnc5ZzV1?=
 =?utf-8?B?eXZGQllGQk0xWmt6TVpyRDFOd3F3bW95b2RzZjRMSVRFQ1BSS3BHdFdpMzQz?=
 =?utf-8?B?L3l2b3BZMHJ6dVdTUHFaa2ZHRUEvS29yby9FSk5UdloxY3FUSXRUZUN3NGNX?=
 =?utf-8?B?TzNUcit6OG1jeXVYTlQ1MDRqTy93TzBBb1EzRmVSbzZ2eUtialpRRDRMclFt?=
 =?utf-8?B?N051aXFrYW9nQTBrbEdlNFRxUzlPeW5yMUFBNGdUTUlEeld5aGplcU1vT2px?=
 =?utf-8?B?U2poeE95dEs2cDVkRTlBZUM3SDBWUE82MUYrMVpYb0w4aWpSUlNPekcrbjBJ?=
 =?utf-8?B?OEttOHZsL2txdHkyYkJrMHNiWi9jRTNRdk00QkxvRXV5dlovTnVnaHVSZkxj?=
 =?utf-8?B?anY1SkNmaVRteFFHNVd4YUlGa2tBb3lXSDZOSndvUWU2Z2JaVm9qN0htekkz?=
 =?utf-8?B?ZEJqSEd2dVhCNVdlNVZMbjQxY0gvMSthaXZ6UEZxNUlJMGNzbUN4VER1d2xw?=
 =?utf-8?B?TUtpQTdMUVNwY2VhQS9nbWVwdUdma1grYU8wRXVSSlk0Kzc2WFNmS0xvS3U2?=
 =?utf-8?B?Y0JhejZaOW5URDV3czc0R2JTUG43Smh1RmJnUUU3Z2t5bnFCQm02TlVwZXox?=
 =?utf-8?B?OFdzaHNYMkZRM0tIOFdMNVpQOTBraHNEQkh4MzVtVkJEbm9OcXhPY0dnWFpm?=
 =?utf-8?B?cnlWZEEzM2psdnNvbkEvTkJKa2VUSWVUcXpMdmFPb1NVMTU2dG5VZ2ZxWity?=
 =?utf-8?B?bzBkOW5sbDFEVnlPRmRUalpoUDlzZi9NdjI0eStQUkJGekdMM2Zab20rTEJl?=
 =?utf-8?B?NVVPYjdFT29DbGRQTUVyNlZZWm1qbUlDOFkxc2hJV2QxZmEzZzNsZEZBUHJX?=
 =?utf-8?B?YjFyNUpkUktJRlkvTGQ3ZitieVR4d1pQTDJjZW1TTWpaMjh6TEpkb3hXaCth?=
 =?utf-8?B?NWJHWjg4cUV1bmFHNmY1V1BBYzVvLy9EbkE3V29pTDJTMHNPTk1xY2QySUdn?=
 =?utf-8?B?N0hQeTNMK0h5M2NVOGJTcGw1VDVHSGd5WnNwSTJDd09veVdhZjRGTTU4emF0?=
 =?utf-8?B?N0ZzZG8xTWJ5a01HanNOZFM3b3hGRkt6V1dZUGZPMjJoUW1IVzdibG82Y09G?=
 =?utf-8?B?MHplMkduVGJyelN6ZSs2elo2WkhCMDFzai8xdFdNZGRzb0crMFcrUkxVcjVQ?=
 =?utf-8?B?RVdYQ0c2ZDJLem9YZitTR3hNcVpRMTNleGEvRjRIc3JnbGpjVUFSTy80S3Ar?=
 =?utf-8?B?U2Z0U0FxQ2gwSWxpMUl1bHFGN044QVUyWjRZVEx5ancyMU9hMUpGT0k3Kzgy?=
 =?utf-8?B?Q0lTbFcxajh6ZnpTRkRMbDE4WTBDRUFsRGxZdW9sMFp4RDVZZnBLVm03K3Az?=
 =?utf-8?B?YUJ1aWZwRkhhOVhtTzJkZjFiOTh1b2QzTU05TzJxcDNVaUh0UitJYU5vWTZu?=
 =?utf-8?B?dWZVUy9uWkRMRGsvdlNXVU04QjV0c00zTm9VNWwvSmRzdS9ZUXFJa0V3S2hX?=
 =?utf-8?B?UXJQck41S3BhazZDUjh3dkszL0Y5WlFEMjYxb3R0dXFQelNTTnR1STJxa3Jo?=
 =?utf-8?B?Z2dSVzJNMStRckNqUlVDQVdSa2RpaFE5dmJkbE8zcVdPakVHWmc4NVJ6STRt?=
 =?utf-8?B?OWM3WDllbFZFT2JEeVM1T1FUZ3daMkRlc1BETTZLVEFXSXduYVo2WGlocWRu?=
 =?utf-8?B?T1REQ2NZREhLVGwxSW5UeUhWQUlvdDRoRk5OZUFKRVdScjNnRU00MFFCWmtn?=
 =?utf-8?B?b3FLOUVua1hCNUthaDRDTG9ST3pienc5VVl3K3h0RmhPeFdmdElsS3NaYUpw?=
 =?utf-8?B?anBCRVVNeUtGdy9oZVowSE00RTRtTkVvVllFaXR6cVgwVmlOWjVnZmt2Y3pj?=
 =?utf-8?B?amFlQW5DbG9DeFhqNjVMZ1R1cjlxY3lRb0thVE5PeVl3UVpQWXdWKzNabTlW?=
 =?utf-8?B?TndjZmFJbkY4UDh5UFFEdDhTSHRjblE1SXkrN0pDQWhyZTFpdFVUYXlkVWt2?=
 =?utf-8?B?cmNyREVXT0hUYm9VcXg4WjRmY2luU1l2Sk5xNXEwdDlZbkdzUWV5NHNKTEY3?=
 =?utf-8?B?OFdzZERFQXhjQXdXczU4dHB3OGFZRjdaZjhJcEVPWnh5SlpDRmoxd1BkZk96?=
 =?utf-8?B?YlVVb1N3Qlo5Y1FjMFZ4R1RYcm80bjFXeW8yQ1R4OERJOG5XZExJeTVVamRU?=
 =?utf-8?B?c0ZWcUlyOFEvS1owVWZGUGpoN3NDMkxyY3QvdDV5L3pYRzA2VXJLaCtYNGtH?=
 =?utf-8?Q?3WXFXBao2Lmdh+78=3D?=
X-Exchange-RoutingPolicyChecked: pG27tjp6aUmL50rY6XO5MJvI+Ep/6eAPiaYw1wOkw+n1g/xALiyqizKe+y4LxwisHwGNyzGO//ynZdD4m3eb6fL+mD1ZxJDx3Qz8rNXRzIVaTlcG5jfgAH0tmKjV60vFIWawjdtUFEuCIe3Tkfh82HbgX0WA/TXolVAB3VrFqSXqrJzWOf59s8y6OzKArkX5vKqQt7jXXPyKW6STGIG4KcGZbi9/xcVesb3/LqsUBbjS3SNv0udGw9uE0huGcb2OsoyRyQH/Z2VD6zd/pRWdosu1ygD18ZL5JHA2WHPMBhgbz7Rj09TxlUpC+FPobwyDAGFz/k+JBwHqvHjnQ/TefQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06da8cf6-3258-4d6b-a3b8-08de92ec54be
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB9498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 08:21:26.7170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08vfXWlOt8tcUfc4qQvsMarbF2mVvHuxOQzWtEDt6CFSsj+63QIMyTxNHhHzuqzXoT8DaX3Q33/hgGvShpVfsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8397
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-275456-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,gmail.com,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,enjuk.jp:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima.ruinskiy@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1718739DD52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01/04/2026 10:53, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Daiki Harada
>> Sent: Tuesday, March 31, 2026 12:39 PM
>> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
>> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>> Abeni <pabeni@redhat.com>; Daiki Harada <daiky0325@gmail.com>; Kohei
>> Enju <kohei@enjuk.jp>
>> Subject: [Intel-wired-lan] [PATCH iwl-next v1 2/2] igc: use
>> napi_schedule_irqoff() instead of napi_schedule()
>>
>> Replace napi_schedule() with napi_schedule_irqoff() in the interrupt
>> handler path in igc driver Tested on Intel Corporation Ethernet
>> Controller I226-V.
>>
>> Suggested-by: Kohei Enju <kohei@enjuk.jp>
>> Signed-off-by: Daiki Harada <daiky0325@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_main.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 72bc5128d8b8..712605886104 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -5688,7 +5688,7 @@ static irqreturn_t igc_msix_ring(int irq, void
>> *data)
>>   	/* Write the ITR value calculated from the previous interrupt.
>> */
>>   	igc_write_itr(q_vector);
>>
>> -	napi_schedule(&q_vector->napi);
>> +	napi_schedule_irqoff(&q_vector->napi);
>>
>>   	return IRQ_HANDLED;
>>   }
>> @@ -6059,7 +6059,7 @@ static irqreturn_t igc_intr_msi(int irq, void
>> *data)
>>   	if (icr & IGC_ICR_TS)
>>   		igc_tsync_interrupt(adapter);
>>
>> -	napi_schedule(&q_vector->napi);
>> +	napi_schedule_irqoff(&q_vector->napi);
>>
>>   	return IRQ_HANDLED;
>>   }
>> @@ -6105,7 +6105,7 @@ static irqreturn_t igc_intr(int irq, void *data)
>>   	if (icr & IGC_ICR_TS)
>>   		igc_tsync_interrupt(adapter);
>>
>> -	napi_schedule(&q_vector->napi);
>> +	napi_schedule_irqoff(&q_vector->napi);
>>
>>   	return IRQ_HANDLED;
>>   }
>> --
>> 2.53.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>


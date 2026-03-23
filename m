Return-Path: <netdev+bounces-270631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOX2LGh6wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:37:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A50C2FA18E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57B7A3008C17
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058F13C5DDC;
	Mon, 23 Mar 2026 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lh1hAbIa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EBE3C141E
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286595; cv=fail; b=NFK2oG47auaQfJlwNHYA1FL2yA7qx2Bi6EnDdDpAYltH3gzMLg2ynq92O75JC2RmwtcBy0P6Olv0OENa2BNFxlI0SDN7BAAOtNxHDT8JhewD423/7TkXknfLqgbH2cNBSLL9Wes0gUFRTNTx4zvBRbZonIyrtXhNfhjLNk25uF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286595; c=relaxed/simple;
	bh=IaSXsapbFD9kSq5JAZKj+SZ//HWZXHQkzFzCKhz7S9Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sVt+rg4jr/dhTMddeDWJp0yxOj+VKuYKcpGRtdFKLJykDatRtTMDYTtbvqXxaRE0B+g9UDNgLKF6aJISUcagp67xOQaX9KWYt9whtKYV8MbEd20xO7Qd6zth1yPXugKsOZnRvUWPNE/0LIZYJWoXXshE9hACzx20QKX1Tpo5VeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lh1hAbIa; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774286595; x=1805822595;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IaSXsapbFD9kSq5JAZKj+SZ//HWZXHQkzFzCKhz7S9Q=;
  b=lh1hAbIaemeMQzxT+UwT+QeIXgANX9VjsgJz0VMrbDxVplpO9UQcEWqC
   l1h3Gh9O5au9xsazxxK+2ZqYFHd/sZ8yD/m2QP42mYSdft3pZskxh0xkx
   KUmBfzOwfG39qJgD+ndGxqGS6CmH6EGByjEkB/p4SHbaE0ZYBzkzssqh+
   4G1qCsCcgascTJ/K+IHtKZ7qIrflsjlQw1WuJ6q+uMyEti9VyFYEW+A7i
   ChlvKIFMNmbI3vK5HmTIwDvDDbpuvI5tAIwUIpuEdymAUetVwnkA5t92m
   JEVUh2rcDTBGomm/t00dXXmmiVvG9/EyWRHke4r0qT2TxOBGtr6TBOX+l
   Q==;
X-CSE-ConnectionGUID: rHvXreL8S2O8G9owpmu/qw==
X-CSE-MsgGUID: ROonCkfkR7+bzy1g7SBBYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="78887970"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="78887970"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:23:14 -0700
X-CSE-ConnectionGUID: vWp/in3dTqWzPOP7/F+kdg==
X-CSE-MsgGUID: c0WtfwkWRVyokbIlfknh1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224061526"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:23:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:23:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 10:23:13 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:23:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI/R5KwYv3hau3d+3LCQV64d2IceS2gnUi2DGod1jKNiikYCdliR0IbAcgCHA1wQlCw7f5WhWo/ZMSlRni7XRk/hzPCD9Q8e58ISmy+wpTF4P9sGJ9hiYkiAZx+Vd7ajY9uB9vkFW/78As4fiZmiaRX6H2Xk+9ES6OsGb/XlMuD3dhhRqsxl8JLLuRvrGpnxaF0HxFNdH8SalqidKJ9HVfCNUJtagU2b6ZwxXalVMu+nA9Sqln1rdkPB2dM/l8oaYjUmln5gPbh5FIPVZGp17MwAHNyNCX56VvSTcjJzRZo4h9XLNVq6c7zU393TLBsWJK1pG28Nnp/OMzlNklTbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pi0rBe3mnezgHnnVP6Rhk/ILePAxMgfX6uO3iurMCoo=;
 b=kR2be1gA7ni5PIYCF2PG+jfWPp0sS81lkfLHSt2HxG7LQjHrokxr8bqQjV58jjPQCsOQzpK8tuwtDjJXy7I+Vxj6VvaLTm0BvW8bKyoNBEHDbCy/ebHCL/wrOCUehM2Tk1thoCkjfrGSvi/EdjpixhYluQwHxGuFUcuNWjh5zuCCb3U4mMWRrQmuT28WbTZrIR0hS50XU4r8Po/0v9cjw0QQYJxRXhycjkUYw1vPGXUT6vgtKgM+vkhYUJaB48QlpZAEnPZ/jOViFdefw9zdujMdyufJHWbQoKg/AGswwkAd2I1RhWm+twE306mTEcS9MS2mhErtOwxcy6VvRSzi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Mon, 23 Mar
 2026 17:23:09 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 17:23:09 +0000
Message-ID: <dff25505-29f8-49e9-a625-f65bbe5576a8@intel.com>
Date: Mon, 23 Mar 2026 19:23:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 2/2] igc: enable build_skb
 on the non-XDP small-frame RX path
To: Kohei Enju <kohei@enjuk.jp>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<dima.ruinskiy@intel.com>, <kohei.enju@gmail.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20260317062205.39406-1-kohei@enjuk.jp>
 <20260317062205.39406-3-kohei@enjuk.jp>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260317062205.39406-3-kohei@enjuk.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|IA1PR11MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe8bd8e-9e95-440c-5843-08de8900da8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|7053199007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: VPLt0Mq/f1g9I8DgpiWaSyaDFYW3WPgIOYnVrf/DEQv9icFjCvSfWW9vYvbsAA6cNcFeIbOR/GT13n+zDkZm0NIASHejLQ7z5Fcalgf3I/ziogi4qHIm+Uwlm0aI0Y29WFhDlmgHmdveLb4C6SbBA/7EeS/e+koO75f1vZ53jNGmEc2sZmqX+vIMRaSgLeB1g1XOd+j/TuBvMV4Nq/mcbuquozYUoE7Cn1f7p4aE55wHRk4DuF6hY+El6dbM6OKnu+KQYSTJYqutCFs1i3tDQ2XSDNNR4vTK+jmgHBxO5EDFp4qrZWyrGtNk9Ta3IitcvRfJhhhnUwT0tdxPPhxXhkis/ZNqvr1ntehqT/LLlqhc8t8WMsQtfa+a/lrUoKPNAe5Tv+khtv1S/+t+rx07uGiZtUy0MvJFoC7S9d8X2QToHoraonnIprkUD9utCLOGhQvl0yO2FQSTsrn/08eAv4/+eMS8FyYD6tG02oMhkjRaCayoZH/G1zbhWqPOdLYvGssjpruNUEIXdzEjXOJ/c1230GcN5REPwu5wtyAB1qm3iMoStnp32Dk1MVs+pF3D6YSTSvNWfn6o66E9sR5vL7vLyAIXPjooAWUuMI4qyLD0/Xpbn1k3zGMC8An8kSX0rYAaFynslUhnX4xKYTt5KS+VPDpTPhXTDAodIbyCxtBIkUrLDLb/9jcyIF6paKBmMmlKXVKfHHmaIIInlhru9TWDht2+B9FLmtWWHsoCtZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(7053199007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUU4T2FsaGFpTDd6WDhndGpLYVpTNDBZM2VFSWkxdmhqTkJ5WEdhaXNkZDA0?=
 =?utf-8?B?T3RHajdwdGZSL3YvVEp1cnhHWVFibFA3Y1RxOVFydXlrRzNRemhST1A1aUJW?=
 =?utf-8?B?UWlvTSsxTFA3SVIwQmV3anZab3F4OGdLKzgrSG8yWWR2TndIVGhUTkJTOW5H?=
 =?utf-8?B?VDFDNzJnMW9hMUFxakhWYndiQ1BLZFVzeHZwVVpOcVYxWkUwQmRHTkpSVUVM?=
 =?utf-8?B?TkpMMXBhY0FHbXhhVEJCOXdWYlVHbTN3RlpVcGowY1BxVWJPdlE0TmJaTG1a?=
 =?utf-8?B?MzJCb1RhUG1wVzNVV0UvYkFsbFJ4Q0VMZXJxdFovMndsaHF4V044NFJkdGhT?=
 =?utf-8?B?R282QmNxSEk0VXpXbjE0bmowSkRrdVR6T3BOMytHU0F0eUdBOTZ4bXVhZVMw?=
 =?utf-8?B?SG5OZ2xOdDFNamR4VTFjdkozblRBMVB3d0VWUk1yWkxpZ0JsbWRvUHA5K1px?=
 =?utf-8?B?Z25aaDZvU1hGK29ac0NwQVlSbjBjd2RKRnBod1k3dWhiK2xpRmtpMWZNdTRl?=
 =?utf-8?B?ZWxzZTZrTFA3MENBOVRSYXpmQm55YTZqSEdBQ010d2V5Ti8vNW5QZ0xzNFVu?=
 =?utf-8?B?WEJ2MWV1RG9hOTBnYTc0TzBGbkNvTmtJSmROVFdYenBTNS8rOHRZdkx0OVc4?=
 =?utf-8?B?WHl4d1FmdldCT1pnc282MG5qdWV5clQxTE54b3NjVGZRYXJVYTNBb1hGLzhE?=
 =?utf-8?B?WFVWQkllWHBPRlVzZE83dVdodXpObW9YWVoyWThWQTl1NWhBSDZVMXhscjFW?=
 =?utf-8?B?Z3Fpejk5U05SL3AyNlZSYUtBWmNVN3owVlh6eGJtOHBIcTBQcmtyUWRRdnQ2?=
 =?utf-8?B?OS9zSnhpd2RiZUNMdnlsTThIVHk4dkxLRXBmSWg0ZFNyb2VIWEFvd3pqVUps?=
 =?utf-8?B?QTcwMGRqWm5mNC9pbG5LTnh1ajdpRXozeUNWRWdMZklOWE1iTkk0b002K0lo?=
 =?utf-8?B?bC9ZeVUxaWc0VFc3M204VDRhVHhTQlFPYzdmM1RLTUxubHRZNWNNR2h6NUxr?=
 =?utf-8?B?QTJzUWlUMDBUdDJJcGJrcXhXWWZ3b3ZucFR5ZEhpWUUxODM0ZER1VXhFamdE?=
 =?utf-8?B?ZnVCTU0yUGxCNkhJWTJsbGpiVVN5QU1CQWsvUlo5ZjdyYThSaDRyL1ZqaUFw?=
 =?utf-8?B?WWt6R3ZjaFpvMytjWHJZbmRXK1d1TFB2M0tPN1VmTU9HeGlhdURhNFRkLzcx?=
 =?utf-8?B?VW9vS2NSaXVoWGQvVSs5ZS9MTHM3djJHeGlDVEt5UzlRZ3lOdEJnUnZ2ZUxD?=
 =?utf-8?B?SENUNW0rRFFzb2xVT3Q5dDBBdW5ZMktpdzhxZTUvYndTYW4wREdQNk53RzNs?=
 =?utf-8?B?RzFuTjU3MU1kcnhIMDBuNERrYUNodXB6ZjdUWjlIWDVNWWlKK1ZSTllmeHp0?=
 =?utf-8?B?MS9kRytjS3pyMG83RjhRZGZKdWVDTzdJT1JSTGhjUkhVbDZYQzRSamoxNE1J?=
 =?utf-8?B?RTh2NDZTNnpWZVM2MHo4RDNlOWZPQkpqVDd4MVJxOGwwN0VxTlFoVHVxM1lU?=
 =?utf-8?B?Y29ScVhtN3dBeWFYZi9GK2x6cWhxdnUwUHVsMEUrczBQYll1M1Z3VWhtMi9j?=
 =?utf-8?B?ZmpnSEE5aFBOSlFJSXY1V1YzcVp5T2pVbE90WFROSFgwSnVuSnVvR2FQT2Jx?=
 =?utf-8?B?d2lUZFhpZEZUa0duVzE3K1VzSFRxZGVieVJRSUs3dnVTSXJvNWhQTmZmL1FD?=
 =?utf-8?B?bTRRVlMyaEhUMThEYWYzUkE5K0R0QVVUeDFGQnlQdUJDNFZ3RThuZEZtUlZr?=
 =?utf-8?B?N3FGWUlhM2xzajFkWVFmVWk2MllrT1NpRm41RVJWQjZwQXZJNE55Z0JuZmJ1?=
 =?utf-8?B?blo3aTdEcExaSU8wZFNqUGtwRy9OYmQrTnd1T2V0R0UwZHVaQWxJZ3ZVYVJ3?=
 =?utf-8?B?Y3N5SEhEZ0hucXNNdVRyRG45REZjRUp5djMwM3RaTy9MbHVJcmhRRXhZK09E?=
 =?utf-8?B?RkFOR3pKZnZnM0dqaFpDSElQSzdUYnNEaTkydU9seDVJd1lxeDcvRXcxVWYy?=
 =?utf-8?B?Qkc4MWJQdDYrdEFJZmozbVRoMVI5enRRSG9uVGl5ZXMycDZnNURlRlVjNldS?=
 =?utf-8?B?bXRMQXorNkpuSXZKUnppMzArVTRERmZiZ0hOejM3eVdCbWdYSWIxSWg2L2NX?=
 =?utf-8?B?U2ovdWo1NHNRNmFDcmRwSzE4czQycit3eEI1OUdlYXhXVjcwMDlrTEExSzQw?=
 =?utf-8?B?SEU3TjJib2ozRG1ZTXlHT01UcmhnVVRmc1FsZXRHV3pMdkIzS21QaHlEYXBI?=
 =?utf-8?B?TUhiRHZZQ0NQY3ppQk1CYWVUck9IWHM1MWZXb1ZKQWR3K0RRdisvck5tL21V?=
 =?utf-8?B?U1EvZmRnVW9Na0U5cmxWTkJoM3NUOElka1NWbHFnYU5TWml1ZVF6bS9sZzlG?=
 =?utf-8?Q?KzEQEaVxOKK38VhI=3D?=
X-Exchange-RoutingPolicyChecked: MvJDYrB8ppCJn5Ljk0as3c7Eg00aWZr/JovbJqeY1DsJ49rdD/YZSxLQ1JQnlAvORUU6dng7EwEG50k/3CaymK1SIYEAH2FiJCzP/5njCTcXLYXrJixQoLEU84//xargXbv/Lce1OU+z0SzWPr3+eT2FMG9q87H+RyYIrVe5hyaHDP0m/9+TuDa0ug4xu7urmH0QfXbxXVQH5g9MxwK0d4eyfzApsihjwsSDD8fE66v8qFtB/Gi+LeoVfEUFNwYoySmr7Ctwoci6Op69i6BFRLLEbpgWGimrqUOulOz5hwobMGmtZJDzJ1wab/6igfPKSHu+r3pvjHio+gRXxRdLuA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe8bd8e-9e95-440c-5843-08de8900da8e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:23:09.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owoigi46cXIaylWkFwAFznQdAHRSVdK3oT5LOS+hoVOhvchwnpEaR8mZDXHSqn9ee6grbwm2VUS7kvCYrBZzkSqbV9ITSsbxKksu/Migv00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8152
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270631-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,enjuk.jp:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avigailx.dahan@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8A50C2FA18E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 17/03/2026 8:21, Kohei Enju wrote:
> igc implements igc_build_skb(), but it is currently unused because the
> IGC_RING_FLAG_RX_BUILD_SKB_ENABLED bit is never set. Enable the
> build_skb path when XDP is not active and the configured maximum frame
> size fits within IGC_MAX_FRAME_BUILD_SKB.
> 
> In a single-queue small-packet (64-byte) RX microbenchmark on my setup,
> enabling build_skb improved the receive rate from about 3.11 Mpps to
> about 3.30 Mpps, while reducing missed packets from about 484 kpps to
> about 300 kpps.
> 
> Keep the XDP path unchanged for now, since it uses a different RX buffer
> layout based on XDP_PACKET_HEADROOM, and enabling it there would need
> separate validation and buffer layout adjustments.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      | 4 ++++
>   drivers/net/ethernet/intel/igc/igc_main.c | 4 ++++
>   2 files changed, 8 insertions(+)
> 

Tested-by: Avigail Dahan <avigailx.dahan@intel.com>


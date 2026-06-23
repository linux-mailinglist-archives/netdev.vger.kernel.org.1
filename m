Return-Path: <netdev+bounces-301379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TWd+OomPOmpMAAgAu9opvQ
	(envelope-from <netdev+bounces-301379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:52:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B16B79C4
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:52:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=FBPgidT5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301379-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301379-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B0C3040A8E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6387D37E2EC;
	Tue, 23 Jun 2026 13:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022119.outbound.protection.outlook.com [52.101.96.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A43672A9;
	Tue, 23 Jun 2026 13:51:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222719; cv=fail; b=iNvFoahjdgPs+gIMSY8CQVomT5OOVxX4RlDV8PSua4z3wsAlwBdGcqQBD4LXfC7OG0YDWWYHFXCMLuagEmQpHS+5RQPGkPF6Az3NJqixOuEFFnrCiR6KBntWJmBHfWQsQS//Bi/VMODygml0J75mn3mFY6HQMWfnEKXVFGFPMNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222719; c=relaxed/simple;
	bh=j/Qvls+Fob01JKSrAWbBNv3XYjANbgdMksA73/zxFPA=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=rCdH9IA6blB9593Z/Xqr1u1te3SNTJzj7FzevxZHsvhu4KMax9cWw1Ni4ceS8hA4C7N+xakfBjy2qjWzCS8Ye2fbcb90a6HntRsXB6bUuhwv8Yfp/ot83sXCe23Hd/p6FdwJbZk0hq0a7dYpHd1kaEzza0bXpYB3yqL5XC+oOek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FBPgidT5; arc=fail smtp.client-ip=52.101.96.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHQQNLNFzUlSrlxa4Rf4uwQU7sksg/RsZdKz8ttfrT5qkRa0vDaNUtBE/6DI8f82m9GSvHpLm0a9dhYs386XV/K1dS6tZIUaxSKtdoKQVE8v72m0d+mxNEEmEKG3Y/+txV936JfaBFQVMZs+wKaRVEBUybPjUPB8abJY/2hPKa889uSkqVB3UK2sQEuvHaI/YYSMXEHvnmiPl2MeAIbI0whrJteKLD7XhhZrc93b2a0wp4B/h24tuUuPogT+oxiqoSr7aOK/IBuTtQQaloqdUktV4uSTzapLImcnmPA2QuOuzhE0JFYFQT2u8u7Avm1hqfuynwgi/CznHKnqYagcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwTg0/+1BwwC3z5FkuN2/w7tUDgn5MPpqzo5VjzCLuM=;
 b=n1RNIMnpPtpl+LK4XMmD4DSFNaeLXLRGMPDb1/4+k2chzgrgpBptXYPaFgRL7qbvqnEujTjbxvwE2yC5hFvichfC1mLbqkYlI2RQd28J4z5anU7GLOa75/nypOerPqyEC3CEnp13+ofMfNQbdDJYgsD3yq1ezgScMunpXfz7oarmvGKWgBiUv/t63rS+reaklXbBFwD9+9CGz9YFK8ZIZIQscigxs1nQAjd+z9FKdBqUV5V1Egk9IJw2gE6GXpAogTaaGYqJW94cv0hbfqBRsxTtJ6Zggd/wjyXOmX30bIXPyITEcuUuJEIMaG2cYuZ5rIVRGaInOana9HzqgqcVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwTg0/+1BwwC3z5FkuN2/w7tUDgn5MPpqzo5VjzCLuM=;
 b=FBPgidT5atFKoDH5y/vR47R/9mNXen4StbTy+KZkZChfGZi4TcenaiqKCvxkd3CWUecc18Unz8HI3NrK5WqxqifaTvZ2V+o3h4VmB/pewQW2PYTdbmClLv8rqxoV/X/r0/1ph55mtea0/jvLis2D3F4kIPB3uXem09IygHtwETo=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB5847.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 13:51:53 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.020; Tue, 23 Jun 2026
 13:51:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 14:51:53 +0100
Message-Id: <DJGH83JG4TX3.310JKL68SXL5W@garyguo.net>
To: "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <david@davidgow.net>, "Rae Moar" <raemoar63@gmail.com>, "Breno
 Leitao" <leitao@debian.org>, "Jens Axboe" <axboe@kernel.dk>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Igor Korotin" <igor.korotin@linux.dev>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 6/9] rust: miscdevice: set fops.owner from driver
 module pointer
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
 <20260623-fix-fops-owner-v4-6-0daf5f077d5c@linux.dev>
In-Reply-To: <20260623-fix-fops-owner-v4-6-0daf5f077d5c@linux.dev>
X-ClientProxiedBy: LO4P123CA0499.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: b1248eb7-68ab-4e42-e9da-08ded12e955b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10070799003|4143699003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ccarzkv3mufCuI5xCnHDoegMqnKwIyTh0FcL8TcQQGw5BvUWKkjIUJfXrMCzM9FXA8GVzdl3mDUuAGcwUlN587hOXM4uM/lDqFXx9Qb1FKs7xvvVUPW2Qe9y/RxaAfXB0D+2k4qGk+UmasLSWCFnhAHPBF178IvZE2EATq14w6QV+VKbHOynGvLiO56AeYd4SFywfxpy6ZrjK5JK2jCHwVL7gbuYLmPlzIg3hAxeRQVqjFsBx3NsIBV2FfMvmsjQQtYoYUkRXD/l9aMW7dNwArruR6zBtKe8wUmUmQ1LROl5FO4DogeCYGIQylCFwpfGuVRlSqR5c3xs1pyXYtUjzFbV5yivsvQteKFH+At0Ibmki63hcmau/XED/ySbBXox1c0E0RcgcRoN1StkllSOxYhfbSN7V5f07A1+mqN/uKYuR9IK2GnjOvaBLVXh6dnGz+nkQrU8THSQ4e/JLjDY7zxBgoigJU7OKUqmXsR5efNIHonvjBYlf29wA4mrhpZWXnAA/a31fkzhEZ4BVGoEg48+8E2evijNq9b5z1Vf6HLvEtzoFI9DxS4SOmgWH1ctnLTrD8zKwOfOb7w03QhNLBJedKZDsKEM5ywGWds+2UGfVFKi1IWFMyHkwwlo4zpmZfb6FlnabjSmAag0EWqmaa2OCrn6j5NvbMQbU/F9yVfvW2ZROcOEvXqB2yX8VKHBcn2rIBiQnsC9UusCMIG7aA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10070799003)(4143699003)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0JtTFdxN201N1U3NjNtRnRXNEpPeTVrVmpDZ3ZrVnR1ZzVOUkUvZkVsRlov?=
 =?utf-8?B?UUhDb2NSNGhHTWhLU3REU1JQZVdVeElvNnVxZ2ZKVHNtRnMrUVl3eUM3R0pW?=
 =?utf-8?B?ZC9Fd1V2dFNBcGRXcEtZVjJYRWpudWd5elZFbzVndXl4d3BCdmpIclBGdHly?=
 =?utf-8?B?YVJ6QURiaGtDanRXT1RHMmdUWjRUY0FrNWtkczlhRXZobzdxbDd5SFhkeGxM?=
 =?utf-8?B?azJ3NkxIeTRXUmRQeFdRbVNnbERaNndwVVFEb3ZrUkVnK1lBZVUxMFVURXVV?=
 =?utf-8?B?anNSTE9sZTRKYytZNmdmZURWR1NyVzJFTTV6Tnd6Y3ZiVTkvT0ZuaEZJV2JF?=
 =?utf-8?B?Z2NCR0ltSG9xa3QvSG0yU2xNZVV4YjEzNU1DdVZXa09GY0FhcWIwT1ZOZTg4?=
 =?utf-8?B?ZzlMRktnaEJPOXlkcE4zUmRkSGdmUzRPaUtHSk1YZUxKMUk1dXZNbEtIOTE2?=
 =?utf-8?B?V284UHg1eTgxMXovNjE0Z0JoZk1TOXZvMVErR3Jjd2tQWWxGR1NxTStnWlR2?=
 =?utf-8?B?R0hNaG1HZUpNdVFwTlFhMnJVWElHQ2JKdVBlRVYxODFpVG5ORUc1WlNoZlpF?=
 =?utf-8?B?cFZEMHVBYjE1Ryt3RFpJaUVYSTJDaHRKTWtLUXdBbjJOYTNVdW5aNzdqOEt0?=
 =?utf-8?B?QWtjVHFoZzFQSTc2a3hFTUxycUpLcWR2ODUxd21KZWcvaHFwMFNXVWdjTDRG?=
 =?utf-8?B?YW5EejJwbVJ0OFpqaVJFV0pUdVYvM1NYZmxrZndZT3lBY1hsYyt0TVFEcnVv?=
 =?utf-8?B?SzlRVy90bmlWVnF3WTNmdUY5NzRWbmdCMW9kTUZweWxURUdVYzFZaS9RcHpP?=
 =?utf-8?B?TGY0WEk1Y2ZuOWo5OUlkY2p0Y2JIVnZxKzd3RndETGgzMGhuUXloUVA0OHZW?=
 =?utf-8?B?TU9oLzllM2h4ZnNOOUJCQUs2M0pZdjhabGtKankxdGpvNXhUZUViajRMbGVj?=
 =?utf-8?B?Y1RFUXhjaThBMFdqN3RsZUYrKzdpbmE3QktzaE9sM2dURllobHJYZ0xKSWl4?=
 =?utf-8?B?UHlXVVJ5bFU0aVhnQ05yZWpMQW13T1RKLzNDY296UkN3akN1VXpkQ2xhTE5y?=
 =?utf-8?B?NDdKdldIaVJhcGZ1NENnUkRGV1J2Z1Rhc09WSUwvRmp0clM0Z2t6QlNGL3hY?=
 =?utf-8?B?V0g4bitWRnQvN25TV2NTN3lCU3cvejQ4ZjNJak10V1Rtc08rVVBOc29LTFA4?=
 =?utf-8?B?dkM0WDI3czBkMG43aURWb1Fxb0EvUm1JRjhzdTd1TlN1amhJTE10KzY3UHJr?=
 =?utf-8?B?VFlxWmhWdHgzUUpIZ09zOUczVlVwNzNINkY2dDJyb3B5Z3NWaGpFWHN1VnFQ?=
 =?utf-8?B?bFluSTUzV0VGS0xaeGZhWldvb3QvU2hLSEpSTWRROU5UcVFxcjFvQUphWjI2?=
 =?utf-8?B?c1FHTnc2Si91Y3hkeTJBRFBSM1ZtcDVyMkpDakRGVlVPZ0cwcGF0bFpFbzZ4?=
 =?utf-8?B?bEQ0dG9KbnUyendSZUZrYnp1M3Z5TGdLejhwRnArd2VQbjY3bkh4ZzRmeHhL?=
 =?utf-8?B?c1ZaNnhGL1FQZFdZdVE1YzhwWkE5RzZQVmNybWorQTAxNk9rSXJWQVZvaS80?=
 =?utf-8?B?dmN3UlZzZW5IRUJHaEV3S3NyU281dXVSdmtjMGh5UTJiWTVqVzdCVWdEbzJV?=
 =?utf-8?B?Zzdxd0xPOHhFK25qd3dPWTBOV3RHK1RVRnRvY3lUcUMwaGRteElUVFdiUTda?=
 =?utf-8?B?Y29mWlJiOHVvME82d3RYSXRNMGhtMmpTZHZyTGxzNDc2cHhwOG9lN3l4V1kz?=
 =?utf-8?B?bTBMSG5ZQ2FuR0Z2Yyt0ZlBya1JoRFFwSzZzMHRFdnJPamZsaVN5dUJueDRr?=
 =?utf-8?B?S3ZqcHkzR2RaUzB6VGlYNWVHNzZzdUczVktFSmZDemhFY2VqS29tNjl6T0ow?=
 =?utf-8?B?Yit0Z3FONTFKbVlpWnVMWWI3ay9ObVo2d21kMm1VemFmRFdsdTgrejNzNnUx?=
 =?utf-8?B?VC8zeXFlMW1IUkZoUDNBL05Lc3NaSURrMXk0MHZhdTFNY2ZQdXI1UTJsYk41?=
 =?utf-8?B?T0h0NmlOL0JMZ0tLZUJseGc4TVAzV0xmelRTY0dFTzRCUDVIKzlmajBDSnNs?=
 =?utf-8?B?ZnJyb3pDQjJkZmVSWnY4ZFZ3YXY5TE9ObU5vVlVSMG9Ib2UwYzNvam9CTjBu?=
 =?utf-8?B?WG81TENpTkJTYmkzdWsrR3lmaCs0eUl1dWpRN0pBQTVSNmhnZ2JCSHFMRlBC?=
 =?utf-8?B?RzhWZktvK0tiV2c4M3FHSGljdkZSWnFFV2JQQmdtWVVURlJpQW9zRWFvUkZa?=
 =?utf-8?B?aUJzZEdPczNyeTY0bUVZcm9vdUIyMHp1UWJ1aVpyQmlkT3pjYVdxcWJUTVB0?=
 =?utf-8?B?aXRJT0xieC9nZzUwdVRyVDhJN0RUUndKM1ZUdVNmb3kvR3ZWcTJLQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b1248eb7-68ab-4e42-e9da-08ded12e955b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:51:53.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2ygldpbuOVHMEyOnSPF3gQ3lkNmw7M87AtSwrjKezAUMMI3v0qAAptD+ao8rT2A/y11tCvhC66jZXUwdjqlEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5847
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[48];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301379-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,suse.com,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,davidgow.net,debian.org,kernel.dk,intel.com,android.com];
	FORGED_RECIPIENTS(0.00)[m:alvin.sun@linux.dev,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:igor.korotin@linux.dev,m:fujita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:
 linux-kselftest@vger.kernel.org,m:kunit-dev@googlegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 055B16B79C4

On Tue Jun 23, 2026 at 7:29 AM BST, Alvin Sun wrote:
> Set the miscdevice fops owner field from the driver module pointer
> via the `this_module::<T::OwnerModule>()` helper, instead of
> defaulting to null.
>=20
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/miscdevice.rs | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)



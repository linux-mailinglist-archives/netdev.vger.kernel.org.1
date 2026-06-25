Return-Path: <netdev+bounces-301987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bHnlGbs+PWpS0AgAu9opvQ
	(envelope-from <netdev+bounces-301987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:44:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C246C6C6A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:44:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=XjxEuVsv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301987-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301987-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84B11301DE9F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D93E63B6;
	Thu, 25 Jun 2026 14:39:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020117.outbound.protection.outlook.com [52.101.195.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80557367B62;
	Thu, 25 Jun 2026 14:39:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398387; cv=fail; b=lPPJ4QSv+eCv0E5sZrXC7usXR2YguOYk9hoeQheWuAgBf0NLDhiRb60P0c5OYACzmTMtsC8Eik1LoAWxi9CqXZDLRXnlUCi/gwhG9sU0gU/snckdYkW08VejbpjHhrs/lnokOkRSiQi1LkwnjBOEv6/Vu5bH56GaI6W9RAWGgT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398387; c=relaxed/simple;
	bh=QWWR/RUluVYTBM/me7ZF290rL79XWVFmSjotw3q9q7E=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WLytF2smascVNiw+N2g/qUDAxWA+za1G4stDbwF54yqGe3m5HQsq0H6zx4Bi1av/PCbuzoruC9lv67grdxeQw294IOTA5ttgob8KfRBUKEhWkfHLynKuZ2njkh7iWiXeuvxZJJHso7sA4jxjaTiEjYX3FS7OZt7IOM2ghQUrImg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XjxEuVsv; arc=fail smtp.client-ip=52.101.195.117
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBZWvftVgCV8lN8n14QnSusNjWwWng8sMCNUvfUwPYENJyitC60opEVlSqrAtMRXx0ISGv645YnIhfhOPSOEZHwlma7HyFbD/PSRRBVv7OpeGPuA0v1pRcssTsSjHxYXD/5ZRL+r5ISLzCLbN8QTZEWaTzQgWvi/3zp0iXa1zs3KTs2GDhoyN0vCtRhRxbuDi02IBgWra1tRF+a4b9x72uEzgYF5kG1y+ZTsBZSo9JNRKRRht5fXF96E/8pairXbEup/1Hryj2YqIBTjXgu64ijtBScyO2kppripPqUbEOMQHFHOegQ1t/3HRrsMsh3vbH20J0uVZ+qpCpS/sElAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdbEGq3OIAsv6JGj6MdkLkPuUwThq8X6jTKVsWEaGN8=;
 b=VtMkgRMqBSzUWu3TTmKN/iZ2Gan8JaHZSbCv8jrmKEthu8hsVXBMJ6D865b6yqSzYTj5GLc2ElXpQeARprPF4pbwhmNdISsFV3onTpu08SYXjTOBuQJpZyH7RT3jlqMyEL+Jtp2r2q9aiFn35CnQRsKgTYHBJ4sMXFxwLNud6AmijOQCYrxU3OeriYSeSDSWOzJjsuQHKbUF5VB5UQb+wxXjNC5ejnxJqkUOPlcsnPk2PuR/8jXOVHsRhZwpBQNpjFXMmDoWP02VdyQkm4BWBpid89qkByOwbFbsVxnEr/oXWq0jP6X4+YXFtqysHtj6FNyWFK0olL48vmViWbFuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdbEGq3OIAsv6JGj6MdkLkPuUwThq8X6jTKVsWEaGN8=;
 b=XjxEuVsvc7I6ESoWWSLgGMQ8oLxME8u7RVpnHktXo2urpkYkVXxtZQrUIcdE42+IAanMiOCgk5CXx1XN4d7lRoDjxcR49eVJNglZVoWT/9dHZ3y2cPA0Eo/jvUDhs9QdfEgYH8uDGD/h2RyqhsCPlkeWzN9r4un7Pw8YcYosGVM=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2445.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:12b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 14:39:41 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 14:39:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 15:39:38 +0100
Message-Id: <DJI7HR91X68U.3BVK3U4OJC18B@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 10/10] rust: module: update MAINTAINERS to cover
 module.rs
From: "Gary Guo" <gary@garyguo.net>
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
 <david.m.ertman@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Igor
 Korotin" <igor.korotin@linux.dev>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>
X-Mailer: aerc 0.21.0
References: <20260624-fix-fops-owner-v6-0-5295e333cb3e@linux.dev>
 <20260624-fix-fops-owner-v6-10-5295e333cb3e@linux.dev>
In-Reply-To: <20260624-fix-fops-owner-v6-10-5295e333cb3e@linux.dev>
X-ClientProxiedBy: LO4P123CA0263.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2445:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eaca837-b8e0-4b83-a030-08ded2c79654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|10070799003|921020|6133799003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	bjXGEbulb9VXmGOxdh8ZSs0uLEPgYrGygGXgM6UIW7QCr/G27UPEYoip6c7FjVCjweg7IZUyzsuEaH7/MINX1rQoGvGBPfSbuU6n2yE0glNoxAXYEyIKD8c5GjaIJ0A3QEw3v9a6S1bthHBLRvuGnYS+FfeCHWWAgX9/xF9xwMi7WqZIvczCpUvp/KvobFBEfl+9Iyr6sv5qYdUQXnrwVL71QZK9RJpj6vhG0fp1qP5DXjee/3F0zNBXnFLRA+xfDMfguoKsE04UEcNG0toedOjC0qD6yPujG1rVMSD8SiDG470ee5MS9MM11AljwK1xm5CbDYiFPMZ4pHCohVP/NB1ig3wL64QxJS7nRySbeL+3Xzm2QaCFc7rEOvHiMyMWdd3d5nr2JHW0ToPkRn7ZJghXG0fG6miDyiS+U9SLqle/rxQGeZgFBeh6p8oGJk1FR+YR8NKC8YLI1tqBO36mP1X4Df4/XEv1+eSS/RRC9On9zOactGR9wnyQsWjOs3n9bfkvnqq8JyYPacow0W35jtJNahqDCdAcqD6uE/j0Td6qCDUJG0937b/nJuYqFb5kg289yrmCcGgNawyKLrM+HI/Hrx3i72uS7TkImdi7JjPn5il6fJMQJMW1C0umMXNSg9eUX3q9maR+9uKeWTEz7fDcKl1XQA9EDFJ4JXCqgqKxt0q4lvzXzYVWTZYrwyorCDzb7MQRtTG32Zm2kb0XGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(10070799003)(921020)(6133799003)(56012099006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sy9PMThRNGdmUzEweTBhcVNESW0vOGVjTHdsQnlzTUdQQkZrQXZtRTRrVkVv?=
 =?utf-8?B?eE8vTXUvam1Fa1R0blZVWmlxeFgrVXp1akJjM0dCMWxsaGF5Z2x5OGs0TExa?=
 =?utf-8?B?c0h2U0IrYlY0TVg1eENTV3NINjRCYmZlWVBVQ0xrZXpuR2ZSalVXcndZdEMv?=
 =?utf-8?B?UHVzanhXN0dSbEZJY0VuQmN4ZnpLTHBEMkFEMWgxaWdSamJhUzBvUEZBKzgx?=
 =?utf-8?B?WHduY1lIN05CUjV5TmFFTXFrNVJsOFZhSHRpU1I3VHVRZyt4NHI0NVI5dzQ4?=
 =?utf-8?B?cHJ6YWNZQmcxRjY3RmZpU09CelJFZzltMVNxckRCS2lDWm9rV2NlN2tFQUVz?=
 =?utf-8?B?NlFNMUtkNVJhRUQ0RWg3REdnT0F0Nnowc0YrSFNOckJzeTYxN2JYYkFsQy9K?=
 =?utf-8?B?c0x0SUd6TlVhMnUvRWJISXRsWC9Td2NHeVVtZ09HdURxc2ZQaFBCNk5YRThQ?=
 =?utf-8?B?QkIydkFRNUdOL0dKUmc3Vjg1YjJlZWpCVk8rK1BJMUhSSGJQMi9ob1ZrTmZu?=
 =?utf-8?B?azUzR3pJVmRScTlWS3JlZWI4RWZ4dDNVMFNPNFdzSEZzanduVmRpcjJrSnQx?=
 =?utf-8?B?Z1ZxODdzMlRjSDd4ZmdYamh1bnMraGIyeXNaczFPOGhiM2I4YzFKczlHQkdn?=
 =?utf-8?B?c0dqSDdPQ0cvTWhvWCt4Q2hoTzdwYmo5OGh2dXNVQzQ4dkMvdWVkSzFpSUo0?=
 =?utf-8?B?OEhWQ0c2bWs5QW5UOGM4OEE2bldsem4vTUpPWm5BQWZvell0cmNoakxLZTAw?=
 =?utf-8?B?WXVBclp6VjNTazRkZDd3WnlKVE01VU45T2hYNUthSFdTbE9WVENpQ2ZVVjk5?=
 =?utf-8?B?U24xQkIwbmNNQ21CVnZnV3A0WFVIQ2ordVRRZW54aDQvM0M4M2UzK2FhVDhx?=
 =?utf-8?B?NXhSTGZYL3NCZE5uWXdxR0lYUm1uYndXMmVLRWh4U0hnOVFzeHNXSng2QlM2?=
 =?utf-8?B?a0VTUzZuYllIckpkTVlaNWxzaW1SbTEyZ0tYWk1odkoxdEtnQnQwcmJmU0Jz?=
 =?utf-8?B?WFlacWFTUzJ2YWxGcHFIVzBZWkNqOWxEWHhFQXRPY0tkOTEvbmdnRnBIU3J0?=
 =?utf-8?B?ZWtWcmtGSFJ6bTlZVks0UHovb2I3RngxYmtZUkUyQVA3azh2dFFtdksvY3hP?=
 =?utf-8?B?dE5lazhMVkQ3VDdxMTJtTFNFZkFjcnhCYXRQRlBGK0ROV2gzTXhjUWVQek1Y?=
 =?utf-8?B?SVdobS9Ic3M1d3BvUDBaU0h6RUxZcVFXWmZrb3hIZWNBUHlCUDBmbW5aSnZs?=
 =?utf-8?B?YnQ1engrUTcyZWRhOTl1dzA0aGVTU3orYXNIenVPUnVOZmZRYnB2Mm1qMG9v?=
 =?utf-8?B?OVdvTGFYTkpMSW16MWRFTHVaYWxrTkxrRzZNRngwVUUrRHUzRGxVTjlzdjFG?=
 =?utf-8?B?QzJVR1NmOGxEZU8wbnlQbmViV0JvTEM4Y2hFeGttRS9YTWgwb2VOUVpNRUtq?=
 =?utf-8?B?eTFvTk5EYTkvN1g0azRqU1pkZU9UUlVjWi8vQUlSQkZJQk94eXMrTUsxdU5z?=
 =?utf-8?B?TGxYeTU2bUltTGJZWDJvRlRTNkdya0JJSVU4TW04TTQzZE1rSWJTS2svTlFR?=
 =?utf-8?B?a1ZoTWxLYTU0b3ZXQ1JlM0FYbUJ0ZlNlTS9PRy9KRDdWandKTDlJMFByQzdi?=
 =?utf-8?B?TStWRnJnZURtc1h6MDRIVWxIYVhjM25vMG1aUHBqaUI5MTREbDVoWGdycDRl?=
 =?utf-8?B?Z3hpTmVFMHgxbzhKNTY4ZzlSTStvTStzNDkvR0twT3JCTzNmTDNQVzU3L3p5?=
 =?utf-8?B?UDczdmk5a1Jwanp5YkgzNGQ3WC9WcGV5SENUNlNtQmNkNkJnRTNzbVMydUU0?=
 =?utf-8?B?RFUvQmhLcXRVYVErQW5FQlBjZ0pNY3FEdlhxVUQzRHpoeU5Fdlh5K1E1T2dp?=
 =?utf-8?B?WFIzdG1zR041ZlNLQTRwNGRFZkt3bXBJbDZNUlQ2NEJKYXhjMUFCajYyMTFx?=
 =?utf-8?B?ODRQc2I0dGo2RWVnRUxOVkYyVWMzWENCcmhxU1ljQmRwM05Mb3pPK1YwbUlm?=
 =?utf-8?B?VlBXSVl4dkZXdDkxWVpFR05vbUtaQ2R2RmV3WU43RkMxaHpqMStMWVh1cnUx?=
 =?utf-8?B?TURpVFNmbkhodzVVajRWMDVubnhwcE14YjZENDd0TFVNU3NVOE4xb2FBc0xB?=
 =?utf-8?B?b0xjc0dDMDV5SGhqbWlEUkFpck9OSDRaWXRwTVBrSnE1cHVwUnlqR25KK0l5?=
 =?utf-8?B?cDFZYmpVNUZvaHpBbWxHQ0dKaVlZYXB4cmRnTU5VOVhJOUhXM2dRMmlmN2Nu?=
 =?utf-8?B?RHpoZTUxRmV1bTZrMWFOaWRtZDVlM1NQUG1ycUJtNDNRNkdxLzQ2Nm1zOXZI?=
 =?utf-8?B?YkU5RDlnb2Qwcm1ScVdtc0ZFTmZZa0RlQWJ3V1RUejd4QnhqbmVVZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eaca837-b8e0-4b83-a030-08ded2c79654
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:39:39.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RL08jX0Y3ILoz3Ahz3CH6mm+Zv3xrhlS448shUidmcRhyC5VcUSSjHuO1qehfKJ9hXoOrB6rzpG1rWqqmQHYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2445
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301987-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,suse.com,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,davidgow.net,debian.org,kernel.dk,intel.com,android.com];
	FORGED_RECIPIENTS(0.00)[m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@googlegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:alvin.sun@linux.dev,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:leon@kernel.org,m:igor.korotin@linux.dev,m:fu
 jita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:mid,garyguo.net:from_mime,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90C246C6C6A

On Wed Jun 24, 2026 at 4:00 PM BST, Alvin Sun wrote:
> Module types now live in `rust/kernel/module.rs` alongside
> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
> files are covered.
>
> Assisted-by: opencode:glm-5.2

Did you actually use a LLM for this patch even? :)

> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7d21=
c5a1a1b8@suse.com
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

This patch should probably be squashed into the actual move, i.e. patch 1.

Best,
Gary

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e035a3be797c4..74733de3e41ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17984,7 +17984,7 @@ F:	include/linux/module*.h
>  F:	kernel/module/
>  F:	lib/test_kmod.c
>  F:	lib/tests/module/
> -F:	rust/kernel/module_param.rs
> +F:	rust/kernel/module*.rs
>  F:	rust/macros/module.rs
>  F:	scripts/module*
>  F:	tools/testing/selftests/kmod/




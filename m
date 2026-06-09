Return-Path: <netdev+bounces-297227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cEeMMMpaKGqQCgMAu9opvQ
	(envelope-from <netdev+bounces-297227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:26:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDB6634DC
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:26:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=oo75oP0G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297227-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297227-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA1A53008636
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316048B367;
	Tue,  9 Jun 2026 18:19:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775943CF1FD;
	Tue,  9 Jun 2026 18:19:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029189; cv=fail; b=V4UbbZLSI1g/asr6vDTvv3WFAbvaY0RhoKuoKV4VBeSFlqEIHdBMsh5kfngdy7oK7WD80eDHIfQWC23Zq7Vm1zE2KzhCG5jQfaYuIRwsORf44CxJDaoqOx9bKJ98/JOX5OUSn4pkCGoVNziw09uWukR9t6tJ662icHvj/9987M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029189; c=relaxed/simple;
	bh=KhgbSElSJGHvS1a6h+cBNuu4nv/4yU6mcrpIOO0KIEo=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=oES/4rLh4Y2/LhtmUpOu4lgjQ9ECtknJ+RnoSUXke4lYfGQUjuvRaYPJRbAE4HyUGNFSGb+D/oNmeAyD46QM0/OgXRTCJlAA0rxpQbwDWJiGCqm3jxJMhaXjGAMxnmpxr9SyKAwwDszblghMDEXnWlbs9hmr+noXgz1+g5MgYos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oo75oP0G; arc=fail smtp.client-ip=52.101.196.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxs0v1NzPZlKgoI2EwsfZZNuAbwdtB9+iML7b+dCYFurlNOSI3Y0vgV+QdSqFZFifeeSlrBWm9Gh+Q3TD0cLkDFLTg08EvDT4K/314v62yoZ9obT5BO3N83MV5c+kV+XsPJIUFyvrBiZV+LA0XuXclHXP3d5eHtBaZVBI6DU5ywVTWehpkiDphNEnLQcCUYcv8QM4iP3xd5aG8YqXo6KXzKaa7D6l97dnba5VNz5LHsqcrvRgUGrlRHL6L2FNC2RDWBEHFt8CBp2mLaxqvLy39oQWLR7pNkSIRNhGSDJrhbGejPPrvDlJSnlqzjS7DBmkUV6kKF1FWvDqScAMJrABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2gYKZ8GWdsGTjtfLAtRtiXYRqSSVfBVhYeSRypP/Fs=;
 b=NCJ3Qye4SMpfgDQSYokouTbAYap8dXkptQbutE9oarIvfZYRi1GCy+05PQIP8aFi0EHBDUcqVWVGzcBpkxPSbtN8JFEqAM8zMcNjgXt6xOjomjZwpUoBrhHknOG2mB5Ymc6qJD50Ye9n5UencbxtMwsY7uNoRrvj5E0kTZ8C8HNOp8P3zjWX2URhuZDL3N34Hn/wrAnhVRwCdDMtDCknILMm0u+/PgTpyC+2VoQJWESURrhTWfp0I25bkHp8TINU8eY60gRKan+sH6x9PVIuQ4IbYWs2FheuS3UapTQi1BPZ/pb1pwzOGEV2ptQsVhuXJlzYDHKMlhbGSEWi5RXfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2gYKZ8GWdsGTjtfLAtRtiXYRqSSVfBVhYeSRypP/Fs=;
 b=oo75oP0G18yyqG7WPsTsWvx3X+8e3OIkIVi/tRLeCc4WTgBxikmXv7WF4FZ6ukb0BaHq4LtERcOr0BPScgT8KRA5hqtSqaicdd9s19NUYj8GKxFYybrwiIxcyA3li8yguaRfxbelMX6urdHSzUIckLjE8GFRMp23Y5trAXDBR+o=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2811.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Tue, 9 Jun 2026
 18:19:45 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 18:19:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 19:19:42 +0100
Message-Id: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Will
 Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Ingo Molnar" <mingo@redhat.com>, "Waiman
 Long" <longman@redhat.com>, "Tamir Duberstein" <tamird@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related
 macros
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260609142637.373347-1-gary@kernel.org>
 <CANiq72miJLmc2EadxUa+yVZ5T72QuTES4Gz=YVUsNivYvR=wDQ@mail.gmail.com>
In-Reply-To: <CANiq72miJLmc2EadxUa+yVZ5T72QuTES4Gz=YVUsNivYvR=wDQ@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0252.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2811:EE_
X-MS-Office365-Filtering-Correlation-Id: da1e3b0c-814f-49a4-9944-08dec653ae98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	rKhIjfadBpCntIDyI1/1PRTQBmw3etHObGGkLum8sMnRayyngXUBabk9DpYulFh/lm7AmrCEGJrhRO/ZYRC65yQW5LhYFhNMl4iagpbURZXg7zO7st1YJKf5R9VEnw/wA/iqx6vcVKNsv4EzZhgVDAr1JpUwIO6gcfL2oFspLT9hEl1NaCJyoIl5WOUi/PNA6zTD0pkOOr8v5216xyGNyfQmJyIBzTsIKBOENDjEwRS9GcUy+VUdnabj/Fw0NgyJRfG/NWTd3zowex3xtCKi7hKmEFOUdgQ7AmrzNqW4mcCD+ojuCc2fKmhWvSv4P112TP6wk1Qq4kHSaakReoLUNxzsrHf1FETtbQH2ZV3ZX07YeZ33cGRchaavKKbPsJQCX/32kjEk4tyir++dsuh9EyDO+WK7mmU/prTh2sFEIsOZK8YSvvu+fxf7wKYWdtWh27w9ob2UgyOQIPY+ThPhVWLWgmO+dOA7M6jj29JA9epIX4zG1NkL6oVoONHunfw+1iNc6t/FAMv5wug3ywsxIvjfLQphamldOebykD+ZJx8YtQFF+KRRuMZKTI0+als6NioQqHUmS1TCSZOUPf9ZNHo2lvJjiEPC8cbZusn9tszkypgd2XimRy9f+8WZrGVFgo32mYkqupPHEiSxdnplEPOF+kfBitBbXMRc4caknDuiBIL6sVEvNOeqf6DTLLi3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3lGNzd1WWozUG1Bd01lbERXcUFrK2g1bjNXeUU2MFM2Tm9BS0lwaENyWHB2?=
 =?utf-8?B?VTBpK0dYRnhmeU1LSDZCN2I1MVlKaUVZdmFidExRb3YzL2UydEJqYk9aQmNj?=
 =?utf-8?B?OXZMWVk2eExFanJwR2FMSm1tSWVxbGd4UHBjM0xTZ0FoMTRHS3UwZzg1czVm?=
 =?utf-8?B?T2JyNGtBT2x1blNjamxSNDhZZmhJVklLZVU0K3JKTFcxK0FQOG5mRWZQWlRB?=
 =?utf-8?B?REV0Y2dkRzZMaTJsbFl4UnNlODJMalNLbnFYZDNoV1ZPWjZ6SkZBOG9lSXlW?=
 =?utf-8?B?ZWJTbndIOHVaZkpraUZhb2JxQmtXcHFTSzRIYXllQWVnK05VL2ZyT3lZY2J5?=
 =?utf-8?B?ZWRHSUVNaTlCZEx5N2FnNlBTZmFrNXFLNTNsSkJaTGpzbWRZV2EzVmlNclho?=
 =?utf-8?B?cDZ0TzBBRElWZVlkT0didzM0T2owUW4yd0QvRUNISElRdXBBSENzNENxWVJp?=
 =?utf-8?B?REtsYkF0cFIyc1dmQ0VBUjVFbUF3a2x6RGhQdktjRThPZXZJc3dLVmRUbUto?=
 =?utf-8?B?RjRIWm9kd0R1empjaWxvM1hTSjMxVjZMYzlxdkVjLzFSWUxrOW02b0tBNy9w?=
 =?utf-8?B?dU9WUUxSTU5LVDNzYjM0N090QVRZaHFjMVNWQWc3SDYwMlRnK2t6NG1oWEFx?=
 =?utf-8?B?V0dUOHFhZFZCdU83VW5DVmQ4bnB2UUovNTdPczlxVlRUYjdnUkJkb0txSXR6?=
 =?utf-8?B?T2dmU0pGQjVSc3lwczBSbVFhUXJwNkNMYXdOcWhkb0UwVmVaMkp0U1p1TWVl?=
 =?utf-8?B?azVIbG9vS05hNmVZbnMvWlBJaFZvN01ycWRheGpKbTE1T0ZMZTkwMmNaZ2Q1?=
 =?utf-8?B?QmdpS2c3QzJnM2RZV3pOWXBUYjlSRGQwQnN6NkpIU0lKNzZwN3pDYzAzaUFx?=
 =?utf-8?B?QzlZRTBDVTN2Z293TDFlQWFEdHlMM0F2eVI3SFpvTGo0aHZQNVptQUtsN04z?=
 =?utf-8?B?ajRrRk8zMU1PbytWR1FHdW9vdmpwc1IvbTBPbWxjSWE4RW9hMmwrL2Zqams1?=
 =?utf-8?B?ZG9ncDhVV3NCYnFxbkZyNXh4OW9HNVFBTWVwUDZwZTF4ZjczbC9JQWloVzY4?=
 =?utf-8?B?ei9HUXNia0o5aHJ3aGNwWFlWSVFSc3AwMnhQNFJmWFgyRlhtQVJOeXFidFUz?=
 =?utf-8?B?bUl6RWFNSGt6enBKd2hBeU5CSUdKZ05JNHYvTmZxNDBzQ0YvNFBXa2swSktn?=
 =?utf-8?B?OWdaQkJxUzcxK1hiUzF1MTJMVU9MOXhIc3B2bGRDMlNqSzByNW1aY0k5amRv?=
 =?utf-8?B?Q3J6cGFWY0pPWHBBT0I5YmdVVDVwSDRmVW9vdkFLdkpDR1l0bmF3R25ZVy9w?=
 =?utf-8?B?ZVRLYUlYTUg3YXp5Tmg0YTFFRWtDdE9vTjQrc1pZdjBXc1hnUzd5bGVjTTlH?=
 =?utf-8?B?YisrdUN5dUt2OFc1TTFBUlNGYWM5VmdQUThCaHc1YVlVM0NTUHJZbnV5TXF2?=
 =?utf-8?B?b0Q2N0lUQzNiTUJEQzFlRkJsdGdqL2hHSWkxNmxuVGRFS3FBOFFlRTJxaVpG?=
 =?utf-8?B?dGZNVTBOU2xZMW4vUFF0bk5PUEFYYldZR2VrbUtGeXoySUJIUzd3SGtMdUJa?=
 =?utf-8?B?ck91Qm1TV0VJTWRaVk9CbjV1K25xMk1xWjBEVGtabHdkSFJoSG51ZGNFLzRw?=
 =?utf-8?B?NHBHR2NuMFptTytYNXNaQ28zOEJFMm9NOFl0NlgrUFlFbzdjU0w1N3NFK1Fi?=
 =?utf-8?B?aEJuUlprdlRRRDh4aEs3VXYwYmFMRG1NQ1o1dDhiT0tYcDR1a2lSTitBYUpS?=
 =?utf-8?B?SzNBZjREcGJNQTUxakpybkFzK1U4U21vQkxzMHBJNndGUmluOGNBL0xEazR0?=
 =?utf-8?B?MjVYaVhBNnBnNFlHeUtKdXdodG14bXEzQUZFNFQ3cmZzM0ZLbDh4SGE0azQ5?=
 =?utf-8?B?ZlVhWTdMN1Ewd1k2aUhpZnR6UDJNNkFJNTJnRXR0WVFQVmJ5YWVrT2IyVDA1?=
 =?utf-8?B?MFF4eDBTc21yS21ZOHpsbUE0Rk9zUFdOWm1rM3d0ZG4xSFUrems2UU5SS1JI?=
 =?utf-8?B?VTdiZDZPWklFK0RqRytwbi9FaEF4UU9wak4vNCtyR2R2RWhHWExPMFJtMWFQ?=
 =?utf-8?B?TFNScVltc2xyTGh0UFFTcEZlMjFYZWlhcmFNRmlWZ3ZXWkRHMENpVnBLc0ps?=
 =?utf-8?B?cWpsNnI5Q3phcFhsRlJXZnZDYUhlcDQrSGdWY2pXSGxVai9nV3EzSEFzcWIx?=
 =?utf-8?B?U1NIWjFkN003Q2ZUMUFyRkVoMlRhaWZZNzNaM3BsVUE3Ry9HM1MyK2xMTm9E?=
 =?utf-8?B?RW1kOExHaGZsODhodTFsb3hSTVcveEZVMWtLSFlvbzFIK1p4UHVFWVo4Zjhi?=
 =?utf-8?Q?BDJFF2sI2pq0jeV0jC?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: da1e3b0c-814f-49a4-9944-08dec653ae98
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:19:44.7927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqA2cKWpP78/+W1Pu5YS/HA8JnrMVXbM7xuaucXMISA12Lo5+sEQHvDPjfBK/wAv3PXnKE6gE/4epR1/fHIZ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2811
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297227-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,garyguo.net];
	FORGED_RECIPIENTS(0.00)[m:miguel.ojeda.sandonis@gmail.com,m:gary@garyguo.net,m:dakr@kernel.org,m:acourbot@nvidia.com,m:aliceryhl@google.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:fujita.tomonori@gmail.com,m:yury.norov@gmail.com,m:will@kernel.org,m:peterz@infradead.org,m:mark.rutland@arm.com,m:mingo@redhat.com,m:longman@redhat.com,m:tamird@kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:driver-core@lists.linux.dev,m:netdev@vger.kernel.org,m:miguelojedasandonis@gmail.com,m:fujitatomonori@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,gmail.com,ffwll.ch,protonmail.com,umich.edu,collabora.com,infradead.org,arm.com,redhat.com,lists.linux.dev,lists.freedesktop.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8DDB6634DC

On Tue Jun 9, 2026 at 6:19 PM BST, Miguel Ojeda wrote:
> On Tue, Jun 9, 2026 at 4:27=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>>
>> This is the remaining unapplied patch from
>> https://lore.kernel.org/rust-for-linux/20260319121653.2975748-1-gary@ker=
nel.org/.
>
> Thanks for rebasing! I had it as "Waiting for apply" in the
> spreadsheet, but this saved me a bit of work.
>
> Quick question below about the prelude...
>
>> +#[doc(no_inline)]
>> +pub use crate::build_assert::{
>> +    build_assert,
>> +    build_error,
>> +    const_assert,
>> +    static_assert, //
>> +};
>
> Did you split this for some reason? I moved the file to a single group
> per crate when I moved the file to the new formatting style, so I was
> wondering if we could keep it non-split. I mean, it may be nicer for
> macros since it allows us to group them, but I hope we don't end up
> with many `use`s again if we go down that road again...

I think I just kept it as is when rebasing. It's file to have them grouped =
in
the crate to.

>
> Or perhaps you did it for the attribute, i.e. it may behave
> differently, but I doubt that is the case? i.e. if `no_inline` somehow
> behaves differently this way.
>
>> rust/kernel/sync/atomic/predefine.rs
>
> In this one you used the prelude, but in the others not -- which is
> fine, we should be using the prelude more (though perhaps it is a
> separate change), but I wonder if there was a reason.

This one is using size_of, align_of, c_void which are all in prelude. Howev=
er it
looks like I forgot to actually remove these imports in the last version, a=
nd I
didn't change it during rebase.

Are you okay with fixing during applying, or do you want me to send a new v=
ersion?

Best,
Gary


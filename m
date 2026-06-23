Return-Path: <netdev+bounces-301381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ea9ALBqQOmqpAAgAu9opvQ
	(envelope-from <netdev+bounces-301381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE31C6B7A55
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:54:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ZNIj7703;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301381-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301381-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B25F9302CF33
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70C37F74C;
	Tue, 23 Jun 2026 13:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021134.outbound.protection.outlook.com [52.101.95.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EB37EFFF;
	Tue, 23 Jun 2026 13:53:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222805; cv=fail; b=W+g5QGqhTbD8YreQXGkIK2PGUgBBjNrUlPHHJJxzVcu3tZ/I9gd14WsteYWuZIBXkFW66WPS2TByUFzZVazY8dNrYqdo3JDUsCEzHX1I5VXsK7PxFho5ipP7VjHqK8ECk3S293BtDqGQVNnvz06wqcQGNO/2waeXK1Wk3PCmNvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222805; c=relaxed/simple;
	bh=DDVxW3E/yVHNC3Xxjo4cvE5YZWIcfmltC8K9w2/Fu+Q=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=LnGZZ+VVHcvrtSJHv5DGHa9YTRoyLOZKmUh69yDw/o5Rq05fdyWgpZfYMaEZ9DSdpf6mHFh87tzxtxC5Dzy6oWb3w9oPXkDAm0u5i8oIDlyb1K+1mgO/XV2T2m1F5O1AXDdddtT3D7nc0g5dleyjGMeR0+LEmc1iyIQTYuWSk5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZNIj7703; arc=fail smtp.client-ip=52.101.95.134
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndt/0ZuuuzslfJZs1vBs72d+jfYRPWXu47+jBPN/H0lB8bTxZ3JLT5U1EZB5s3RjZbrjH1Ac0+ZS67dM9mTs76v1/6NIkB5b9nVxESBvup37Y0tweQ2CYrIG0CkuwiXITFqAey73aS8oSXrQ/MZi43uPOO6p0QtXQGg2+6xkrMTAGLg0MxFTaUYI1Z+H71UC/2xIAwXE+mBMy/YDTW8G/rOYh66S9l8fjUe+vuKWn4eaOfYqciiciGUGbQGQmOi4hpbZZPakrgzahKdM8rEGRmHnnd+PBfzFZ9pc4H6eAOIUASqagR6hwme1F3zUSUCKztwT8V6JlMvfYRuX82kW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFoSqKCd2TF+JeZQhClJR+BPk4GkY4l3cnslvhK8K4s=;
 b=NDiqIESp1MvN7re/5beZ9Oi2o0FTuf76l/0eMU528+tQQ9I/nU6Lmm6MO6XRwYV5Wfc6nNSGWUwj28QH5EElSCg2lFoF5C17G8DIsZjMuExaHXyL0lz5XJ5mr+V+igo1YeUzu7ARCv5HfMwzt0P6y1FwbEFJceJD4SZHj59VW29tP6+9IOW5PbCJob6mzBVHOeBwIhDQOwZPnCgszeJMH4sahJAsTV6FPDTaHMNlpwJuDEMVDcmZ3vxuIe81TZAMD2XLxzTZaSJUp+3Cerp74VqjKfq/RNqDCjEbwNr0xGnrjXyTMkZFZjg2ThQcp0MaAs8/m7p/NyFsKQBZSE/K/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFoSqKCd2TF+JeZQhClJR+BPk4GkY4l3cnslvhK8K4s=;
 b=ZNIj7703Sh6VqgFwoOLCk4vpIj+s1jXbrAd70OeDL8G1UbpQT6wthCaM8qwYxkhKoQoBQFkLrYHMijQE3/KG1sMeooDf07D9RK9IdWQ4svAqUxx5uLJNGR2mRy06z7Mv5+OMMVZkrMIcXWuk1uoXDzndU8GOm5uUZgOI89QFEsY=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB5847.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 13:53:19 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.020; Tue, 23 Jun 2026
 13:53:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 14:53:18 +0100
Message-Id: <DJGH96VZ6JZZ.23U7HOBY65Y8X@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 8/9] rust: binder: use `LocalModule` for
 `THIS_MODULE`
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
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Igor Korotin" <igor.korotin@linux.dev>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>
X-Mailer: aerc 0.21.0
References: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
 <20260623-fix-fops-owner-v4-8-0daf5f077d5c@linux.dev>
In-Reply-To: <20260623-fix-fops-owner-v4-8-0daf5f077d5c@linux.dev>
X-ClientProxiedBy: LO3P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a080d92-39e4-4cb9-788c-08ded12ec877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10070799003|4143699003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8nO+BBmlYq0vqc0ANDUx3RZOiFOxr126F2RS8Hw9lhNIICrBzKGWf4wXWonwyAm0L3cf+rcZVaYT/U9PLklNVpdzS4pnnjMy9hWnO/fcxvOdcuSmemxT2oAbAVNmR1Bgo5qVJAsAO1Wx9jYBX71oSsTJqP6z3eQhKQ9SomidEKupSKvy5caWWXYm/yAOEiicQeBif7cpI1WSkm73X0XuhJjwz+Eh7Vn0hlKY48pnPWvRRWXnLj+4Po3SDt5r/Xmwl8uZ8HPXd7p+U9ThLuxhF62juO9AErM5efQCcF221D7pdWzUs0ck48XQV7Kj1syi4LHNGkc/eU0d/9ijc9TKaGMntEjZ3gltSSzvmQRuQ1jO15+lB58R9l4VzFYuoBS6ic7zpvnyNLO0UNaX6nsl6IOqYL5hMpsGdBki9Poyvv6qX5vjewpS5aA9LzrhVPAaQCjqk1Z+9HeMR0ZfVaaUbb3LeBNXPvK2LqDotkQ1vdgyjm555MnpBQvgVTFas7ELLwHqm9xcxKN5+xljNlMGy5jNHv1Rm/1d6eGSM8WaFPkFncwPcNGRbL8S+Qjpt5CGsWi1XaNLGiqSKtpFEYKRNCtVfXpixa42+hk8GAUQaLJ+aCrCaqR56i9iETp4KXJgFCxVYngx+BBAYdWggsQYm+Wu7sw5YBqzkm1B//8+OF1bZxX9/RKqmGHHZcIeXyN9g0/jrq5uZkl+GkW3apEjgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10070799003)(4143699003)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3lmdzFmSTF4RVBESmRFS3lvWEFFU2ljc3VXcllhK3ZXMHJEVHJKby9kd3Ru?=
 =?utf-8?B?NUE1b0VZU3lFd3owZ0g4cFRHcHpnY2NrNjU5MmcrMmtoU1VPdXVZWmxRTWRH?=
 =?utf-8?B?UzFsQkx6dkUzb1ZxTFA5dEVRSE1UNHNQMENTNnBlSmwxMUdwMVY5WS91K1dW?=
 =?utf-8?B?a0RIcXlRNjBvVDloNUk3TWxvOXQ3czR6WnQ5b0lVNVFsKzlxZUdjY3lIMGQz?=
 =?utf-8?B?TzNyblo3N2VTSVRGUWVSWk1CVnZTOHdYUG4yS2xjWU8rZkV3MWlwNURRd2xs?=
 =?utf-8?B?eXpDbENUcUhwTEdhZ2NUM24yM1NWVWM0ek9TTTNpOHlidmwvMlV3RlZoWW9Z?=
 =?utf-8?B?azJiejB3ZG9TNWJpREp5c1M3NTIwTFBlajFIallHa2lMaVB3YlRMc1F0OTVG?=
 =?utf-8?B?ekRxbjcvWDJ0NkNYWmhrT20xVTdtdjlDVHB2djRrQUxsMzdPazJ0LzFORXlG?=
 =?utf-8?B?aXd1KzhCQ01sR0tNMjZXWDZKTjA0enFHS2V5SDd5aDJRM3FOVDB1bmZaaUFi?=
 =?utf-8?B?MlRBVENtVVE3Q3lranZJNHFpdDdibE14TkVQSjVIUGVVWk5CUDUzUzFzNG9y?=
 =?utf-8?B?TmNhUzlBU0N0RkN4ZmVzZUxFUHJqMzAwQmh3aEVPYWpGU2NoaFV2QWJPaXlx?=
 =?utf-8?B?OEltcUcvNlY1RElWVzREZ2Q3RE1ibGxKU1FGTHE4YVRZNi9Ua2dZdjFCdG5Z?=
 =?utf-8?B?dGUzeUZQV3J2QTlheklXMDgySmVuSG1FN0lVL0czL1JianZ2dVhNaGY3M2NK?=
 =?utf-8?B?Nm4reVQyTlBEU0hRUHAzaGlwazRDMlo3VlN5UmEvTVJxajhtY0gyME1XSW5X?=
 =?utf-8?B?TUNkUUlsVXNMc2o4Y0NWdUw1dU04UUIzaUVVOXdFbVBOeGh5b3ZCdkg1cDYr?=
 =?utf-8?B?NTduemlaUUF3aXBIaTZQVTB6YWxTWXhlN2xlaTBjWG5VZzZkRXp5Uk9HcG9Y?=
 =?utf-8?B?ZTNmRVZTYU1oRzBOU1J5NmJXM09BTXYvNVFOQm42dTZqU0lVelN4RXZNWHVZ?=
 =?utf-8?B?Y1YwaDdmWi9MT29rNHNFSmE0VTJxcm5FNmpqZzNzaTZTdmRTQXJ5b2Uvdmlt?=
 =?utf-8?B?aG84UURmZURLdEVFTHVkSjE5NWZCVGl2TThwYUJMbCtNOGZMQi9OM3gxaGR2?=
 =?utf-8?B?M000UVFxZ2loRG41VzYwR0ZhTUczNzBrUWxhWlozUTBROERMeWRnYnlZalI0?=
 =?utf-8?B?U0txN1ZVMnk5WFFxOHIyTW1yY3J5RjVJYitacTdSYnYyYmdmSHEyQ0c3aTZN?=
 =?utf-8?B?YVdkZTdhQ0RnWWZJaStGcUg3aGxSNkFONHZ1NWpZVnlxOWYxUkNMTXZmTnFx?=
 =?utf-8?B?S1FFYjh4TVBSd1pRMnpKUnF1QmhlYnBqbnNsUkpZUFRqTGdWNm9WdzdteStL?=
 =?utf-8?B?TnVnazVmWWs3WlJ4elE2N3RIMjB1QzdOTktXK2NDR0Z3WkNJV0UvTE1zTzRZ?=
 =?utf-8?B?ZnI4bitQTFlWWjdsUTBkNUpVOFVDVHdPMVRzdW5ZRWFSZ29SSGdtVkhTM0Y2?=
 =?utf-8?B?a2xXRHh5dWlyd25MV1J5eWduby9JZ09GU1V6aE5HRlNZN1VDWVFDeFFnS25O?=
 =?utf-8?B?VmhjenluNGtheEVTcytvR2tydFNmYUxFZVdXRHlkRDhheFI4SGFoMWZvZG1Z?=
 =?utf-8?B?bHhHMm14V0N3RHZLVzlSTzg4YkJvSDhibFBLd1J4L045R2VMckR0MlJjZGR3?=
 =?utf-8?B?TnErK3VUS0xZY3paUlRoejlDNHBueHQwUUd6OFlBckpXbGJuQ3lreS90MzVl?=
 =?utf-8?B?OE1QZllUZ3lxRUZLRzBjZzMrQUlrMktOQVUxcnd1RU5wR2hrRmpTV3ZnTjFF?=
 =?utf-8?B?bW1lTnZCemgveFBBL3gvOFdjWWZtcldiWEkxMnptbWNPY2xsclgrZDlsbE43?=
 =?utf-8?B?RXRWWGJVejhjQmZRd3JxSGxYZGdUSElWbHhuc2pmQStwRkZDL2VYQVFidlVq?=
 =?utf-8?B?eEdUOXQ1QVdodEdWWlZHYjViYUk0eGdYVWVjYUVKcnI1RnhlVEZyODUvNElJ?=
 =?utf-8?B?azBpTmROMTdTNzRpbW40K3NUR2RiVm5CQzIrbGtkUk9KK0RCNzZnTzU4NUpr?=
 =?utf-8?B?U241R095M0lNZE9SNmx5Tlg1KzhpcEF1OXlvb2tRaWxxRzFodU5jb1pBK2Rh?=
 =?utf-8?B?TkF0cFlPSFlWMGJTcmJEMlUyejg4V2c1MThuU0NVbFgrVS9NSTkzcmNPd2Js?=
 =?utf-8?B?SU44Mjl2TVBRaVV6eHdQanoxNGVUUTREQ0NqbUZEODZJWndaVGo5aDNjNVVD?=
 =?utf-8?B?M3VTczk5NzNBZmtZQm5HbGlrMFF4OTd4YjFMYUFWWkg4aVl3S2pjL2Q2M1I5?=
 =?utf-8?B?UE4zb2hYWUlaZHU5V0s1RlN0TEpxZlp1allDMk5VbUxlK2k5U01DZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a080d92-39e4-4cb9-788c-08ded12ec877
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:53:19.5895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4XyBDvH4AfNOMVdsWiVq7kKnrxa8VEumBfb5B3NDViNQ5j3y6gHWkeTThUYbDnacYicZGrZgsu21arFxXzOVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5847
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
	RCPT_COUNT_TWELVE(0.00)[48];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301381-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,suse.com,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,davidgow.net,debian.org,kernel.dk,intel.com,android.com];
	FORGED_RECIPIENTS(0.00)[m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@googlegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:alvin.sun@linux.dev,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:igor.
 korotin@linux.dev,m:fujita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE31C6B7A55

On Tue Jun 23, 2026 at 7:29 AM BST, Alvin Sun wrote:
> Replace the `THIS_MODULE` static reference in the binder fops with
> `this_module::<LocalModule>()`, consistent with the move of
> `THIS_MODULE` into the `ModuleMetadata` trait.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/android/binder/rust_binder_main.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)



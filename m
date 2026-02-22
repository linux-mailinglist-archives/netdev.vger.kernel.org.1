Return-Path: <netdev+bounces-259890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EnMDIVI/m2ldwwMAu9opvQ
	(envelope-from <netdev+bounces-259890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 18:39:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A0E16FF60
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 18:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D985300BCB2
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B223AB8D;
	Sun, 22 Feb 2026 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XtHn7CTf"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D079CD
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771781967; cv=fail; b=ubP4lCtbNNXfj1MX10jK0fsAxHLdhmLVuvvXHComz1L3jFa8OayPF6aqW6+EU+ialMy7ozxNriPxqxYsXHcdfNRY+7/12UgTQBi3aQfR+/ppfkLxfuH3bFb+ClaDSqoKRqFwG7c7EPni7CxZ0Lqg8Ioj9xqBRMwkA8tULXYCIck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771781967; c=relaxed/simple;
	bh=VqHf5YCK5sk5IyzgplRL3PIbMKAHV5q6gZqLn5nl+NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I3VGkhm+6HXDaI14XhKnbIjow4HteW/dbpiGVESWBF69tVsko43xOMBz386U6IhS5Nl1akMRIfZolDWs/HS23gcAPJvnYNF8/AQrPI2vdhuaCvmxFzLnpf+iE6z08fmKRkBC7gVvtiwZuEmZ+AOyoJw1WkBXzDjn0jby8Tog2vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XtHn7CTf; arc=fail smtp.client-ip=52.101.61.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/CVGFi7X0+yLtEK3GTvXxurIjdz5GI/sfSf4TIc9R7vhGUGTjUSdv/JXlHEUwjQEUujdF+1t0dfDMwqtX4IdUxZ/Ja67s1x4APm+P3x5QUsmDQt1q47s9a/tIqsOCZdVR7NRaHIHEIes8IRV0AGEwFOTLmtqP/oA+n462E9dH0sfPmnLOOGWPnBgmx/aUyhC4HvfuCXj0HRa/z6LX8mO/WQqJltFqMuOre1ql+cERkiEK0Q1q9VyLAlZqtR7Y5JVV+x3YPK63d03aBGPKtswMXQRFwI/GdzMK0l1lHOrJus6lNJt/JQm68xCLJbL56LvFmX6vRus4pFY7eI87cmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uduRLSMITNTODTe9u/FFClGQ0HMIZv8igbsCG4jDIY=;
 b=WxRwnffJMZK3l8kEDzRiyWqIAq4r+5Lo0ro5I22C+/h+LxasSJY3bGt3PesiDgXP1KO/zgCjMWjDN2yD4la9DLa0AxGJwk2mH+szAswnSCCy+oOGkxIxcGIqkIWl4fM65f7ALDWE4Rn9xGSTZ0mDJhpnC/v4xcUop1dJT7JseFeuARZCZL5FBcL7akC0g4vDbfzeAxODqqsokXsAenZHgpP35hZYlYBsB96e4ISvFXSCLNBnvwuICwB9/kZ4v9/kEntjmvbuE3elYK+y9T56I8rcpTUzF1IF4hgRbDH8/YrZWJlEJCZnhwSuRDRFBvoPfxkXEsYTHnIz58q5GvhP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uduRLSMITNTODTe9u/FFClGQ0HMIZv8igbsCG4jDIY=;
 b=XtHn7CTf4cHEEYZuWy6RtIgAgtzLFtsADnv5n/GLqOATFNf7ovHcCih9C6IgniK/WBoJe7wCBLSlMk4NyuocQTfWaobdsK9l0YL6jQ8buXiCxjtyyhRTMZcXSm14V2GpCNXqFhtPh0R9dfA2DFj2x1KQ+uIS8zJ6bqnO4CMLCO1qCsHaLkQ3RBGl0RBPm8CZvN8lROv+8fsaDE2f1bPpdMWhdNP8+DcttYbbpboVXquHHrYwNpldvh5uhy4H7NRyVM55xtrqc2EsqLOavr0hZzcBsJqHmk3q9+5P9dwTZz4WidkiKeDYAbbbAH1lzzk0x+8ZEo9GJa9aNPSA07ZL5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Sun, 22 Feb
 2026 17:39:21 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Sun, 22 Feb 2026
 17:39:20 +0000
Date: Sun, 22 Feb 2026 19:39:12 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Network Development <netdev@vger.kernel.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v2] selftests/net: team: add team unregister test
Message-ID: <20260222173912.GA118740@shredder>
References: <4d69abe1-ca8d-4f0b-bcf8-13899b211e57@I-love.SAKURA.ne.jp>
 <aXl_MwhS9AJXTYi4@mini-arch>
 <20260129191243.767e3005@kernel.org>
 <14ed1845-370f-4b28-83e2-d8424db3ab36@I-love.SAKURA.ne.jp>
 <20260222093413.GA30085@shredder>
 <43ab8835-83af-43b5-8317-37fd2b25e1c1@I-love.SAKURA.ne.jp>
 <8ea7a69f-e5cf-4330-b911-7f49d8ff2aa8@I-love.SAKURA.ne.jp>
 <20260222153209.GA68096@shredder>
 <d5d77517-abc0-4678-92f6-146c684a200e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d77517-abc0-4678-92f6-146c684a200e@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9bb4ee-0bd5-449f-f8fd-08de72394fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gKkbIJy16TMKp50kGQVEGWowHjHr1UUGtcJ4YyLRbEGAxIXUePXonZ01LII/?=
 =?us-ascii?Q?XaoIF6rPzBTGTgPUm31gWUZv11KCeJcDg27a3E7ODykblzwvpiDJAfNJbtSn?=
 =?us-ascii?Q?q58kFSi240ofnEXZAETiSCvU8T8MNQ4UIs7JrSLSQq8J79RlPeBP9DAbJra2?=
 =?us-ascii?Q?LBup7WznFlIoge6joxGJ3zOAjwSqCWzEXc0QQkMHYQEwQF9Rtr2ucPM5bpI8?=
 =?us-ascii?Q?uTtxDe1gMrgqZSpn2xa7dp1weRlbkdKQ5XXBdRgB2X7VZjeHwM7LBt/NkDTa?=
 =?us-ascii?Q?yXXcfL0GpXLQ7ehRezwWZNSAV9gOCt4VjRJRz6GY3QrvO3BgkJ/VsTT+ZVyU?=
 =?us-ascii?Q?IRxpuqhaIf+C/Lu3rrjwFsMgeKto2cDy3rYmFipVjor7EK9iS4uiBNAZzd1v?=
 =?us-ascii?Q?mfQ1oEmZJMfNG3bHmhLqaer1KnGKOuPK0swWaRwKhhgPLIDSliGSHgILeXp3?=
 =?us-ascii?Q?ad0/KquoSxu5z9TJpdC57UDdRgfqHDqAnQCEqQTeo2BZqxsWQ3SiVSYYVN37?=
 =?us-ascii?Q?htXQ/KrgWpDQYQtJIv1NbfJULJGSDH0U9oYSkzxp3hZuLEwIGTJajB5eDSRQ?=
 =?us-ascii?Q?NyoLn2YC8bB1Xikrr9s/c8vIf81AB9+m6lSmKbS9TsEVdewX8A6lw7ASM2HO?=
 =?us-ascii?Q?m1oY/TDVRIDM7IzhPA1tRtRGDAi9fv4QCbvw4VZsdbMdPgs82oAPV5TSXCu3?=
 =?us-ascii?Q?KUjn/kJdDLmi1/1t+LkDOp3KyBxicIw+LxlYjumMQfw86Tzf9htAR+Qu/nrK?=
 =?us-ascii?Q?BX9p9Z3kMLzC5eT4L3BiR6yP4zZ7r8A7UytUvAC8Jr0SksuOf0G960caphH2?=
 =?us-ascii?Q?dhY3hl7dSrPCAi1z06wDUJZZn5DBJzKiUjq/Yv/liVqXvztbEiOeYmFAoxRQ?=
 =?us-ascii?Q?utkLHjiXeXTBuJtDE6ZfneA9E6cz9prksOAtu/P1Or5u6CSDny4jQhfvFmQC?=
 =?us-ascii?Q?GpIJaSTx8oBgb6kkYW6ujz6bj+Bg24X6CcVFgDxa3MnHJlg9upkHh1Qb9MWu?=
 =?us-ascii?Q?2f3qfedNMzfsms7SnkWZMs2E2I4Idl7dhzbJYR1vJhW/MgFyjYmFOP2p6Jgv?=
 =?us-ascii?Q?6uyzB3pONMa66E6OvGSSSg/PEr+MDFe1yOjkzMfLXKGOs+AxFBygAyUF7aB3?=
 =?us-ascii?Q?azXnf8+O0ZGdflIpLGjv17Gd+oJcWoJWv5RwJFRElIVcazrTjQWHDjlXGqyw?=
 =?us-ascii?Q?auXwUFtzZA9S6M1OXmwJD3HnpNmwgHs324g9dDJzm/Yb3koDtHknzy9gep4K?=
 =?us-ascii?Q?UG894PZ4eE70tgYEfFYrl9rV5bEDUuZlsgFDt7PuKXecBdcI1SW9hhPwQzvo?=
 =?us-ascii?Q?Q5fs3UKvVqoK960LeoZF3MNrR4TC8OOVSSSKigCjuF5JzRXP+nDT8m2/5ykm?=
 =?us-ascii?Q?vL6r+XeT+HbOhgl/EmtyGpgD0GLRbdBaECijcxaSSmyarALxYXrCqJMG0tt9?=
 =?us-ascii?Q?Izaf6O92ocTSpuh/reO9B/XENyQBOiPNgOEdkksQ1KO9Ja23zzsUjm2eH6nk?=
 =?us-ascii?Q?dom0wkdollcRjy/NlBVxwovfQbk1CI5igaMxwMGQ+qI/ztu96ULaMEACMiyS?=
 =?us-ascii?Q?4FlybirWGeUU9zIEUYo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ozOwov6OkcOU/XjuvLAGg+/Onc0wOzlFLJmVGCtzFKBVOoLnyq94c+5w3/or?=
 =?us-ascii?Q?CnfPBj8igtJfp1uJEId3LL/acmBv0stBb9NaAT50hZ0i2BaoZrOEMBhjF/Wi?=
 =?us-ascii?Q?P5UsDg95I7C/ONC1lhb7Tm+dxHFVaSFK5/QLB+SZCEnbaazfoWnvfwPMmoua?=
 =?us-ascii?Q?8oS8LLAGxF/GgK8Cwip2RhTN59Q5/NNtygrXTLuI22T6KbUzWx2dfVmv3mO4?=
 =?us-ascii?Q?4cQXThSuTDVE4k9p+zVjDQ2ByM7cgn1s2vxWs5x58dBJz15x8r0ZDh4YUQwL?=
 =?us-ascii?Q?gKBx5YZRb69GvZkV+xQdIXK/1IFKVu35TJ+7vfY1nExS8aLwopVe79iTYsxN?=
 =?us-ascii?Q?kUIehkkF5q/jWqQpvaIaXD/LmEn1tbQIobhkFv8tmYYFh8tbZFIW/MKFfEmF?=
 =?us-ascii?Q?04gYZAVYjH011gCxX2icP1LbsfA4F/FcqsBZ1tssjVQgwsoJOldEKljeavfp?=
 =?us-ascii?Q?+kbTnK+GN+enuhKN3UZOhdhm1anHKULVOd70ijv9d6zS1ndAcKaDznk8mtpV?=
 =?us-ascii?Q?NMGKWe76NxvpVjbhmw17EUxy99wXifFm2+zAwJHMQ9/pa6ikw4TGfWNlvwNd?=
 =?us-ascii?Q?1v7jXJNubJ3rJNXr1o8ZQ42eu8neAXPNkhQpYkcb1nMjxucVSMMIKwSZHHZ/?=
 =?us-ascii?Q?bGOublgE9QheMgxFokDJqQeQ8jHRnJdGqNzTO8EdIApL8L6FPO02zJ5snp8G?=
 =?us-ascii?Q?nVgTgtfGG9xJzKWYtOCW+126rYPu7/gUA2I36Iqa4A/Y450O90BKDzbr4pR7?=
 =?us-ascii?Q?aM6qbmUkLNlobGH1K2DLAEsC0LnLKTm+SU7QBWSHcEJqeZbluwiM39rXKI6W?=
 =?us-ascii?Q?JdkTVc3nY+C8mwaenYaovXI2C4d1XEtP8dm9yKXasL04KqfmsgF5Pvf5RO2p?=
 =?us-ascii?Q?+Hj+jE6O6Ie9JTlLx6cinGg3yQ0b+70rpZ+t46Nqx16vQOFwy1vjQcQr8xUO?=
 =?us-ascii?Q?QjlIDhpfAOg4ejw962A67i54exQxlskVE6g9sexJRXrAnDPI269Az+ZdxpIJ?=
 =?us-ascii?Q?FFnwar2Y9n5sgww6QF7rC1Ig3dOrDN6qBoobZcv9HNB0Fi3eEX/rIr22EvIw?=
 =?us-ascii?Q?N6cfDoSt41MFfK6ZyC99X/cOILIGwVadA7LVKlsFsVyv99mYYS9V74RofhUf?=
 =?us-ascii?Q?EITpSxSJQp4NqXGaAUKmwn98ygGPTH9KwI5DZ9cKdj4NEq1eIiBxnxk6iovH?=
 =?us-ascii?Q?36JOcFgsE+Bq+Yl1L4jncHIWl7/lX+maj9s/Coa3YGwFjhVultgm/htsTZqi?=
 =?us-ascii?Q?kHB7B8MTtB67SCl1pciT2/ATXieHCniy8DMZMjQDkoaS/bYp6nP6vUgKQTRx?=
 =?us-ascii?Q?SgmcAJeNftIUObRtY8JMceXW1vVN6lJOPcsXRxfNRPX1OfbAaJkNP2rImJnp?=
 =?us-ascii?Q?Ag9pWYY1MyozLym+YVwvOpfVIREzrDgM0kxjLWZKtHO6Ifjuyk+Nfknrg1GG?=
 =?us-ascii?Q?NDgw8/SquZZfxcOx7/Fttbqpg7ggSLia99Ih/2OOSv678T8HTVs+m/GTGu2/?=
 =?us-ascii?Q?Ny9zSjcAAu72tz73W/Fz80d94+zsQmY4wvPklx2B6eLsU+yixttgmwOW0hHc?=
 =?us-ascii?Q?yh5+ycRYlxGWfpngFZkmZBbu9pHTkG3zNOtgI645i3fjcvjhThW3CcoliRWn?=
 =?us-ascii?Q?BjDPOJoPUVR0zyTDDX3DnSarGMhgWcJ4CNbyxIp+JUYsYYaKE/stIiEQ0bIk?=
 =?us-ascii?Q?fFYowOLCGNFyoX/0ycstjoi3FXImTKsQshMPW5c0blUDy/xo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9bb4ee-0bd5-449f-f8fd-08de72394fa2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 17:39:20.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lH8n++N9Zoo3L1pYS99l2DAoBaYiTRlAXj6m24DHC1RgeAcKcXK6JgWTMXf6gyEKMHSLsqFw7Ae9qtNleHXZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259890-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,nvidia.com];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: D5A0E16FF60
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:40:33AM +0900, Tetsuo Handa wrote:
> On 2026/02/23 0:32, Ido Schimmel wrote:
> > This patch [1] works for me (hangs without the fix):
> 
> OK. Please go with your version. :-)

I will submit v3 (fix + test) tomorrow


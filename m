Return-Path: <netdev+bounces-46491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A907E4910
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 20:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006072812F7
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 19:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0041358BB;
	Tue,  7 Nov 2023 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="TO7CAqrT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0F3158C
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 19:18:44 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2014.outbound.protection.outlook.com [40.92.48.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2D4183;
	Tue,  7 Nov 2023 11:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqEFrHDWv0jJhA6GHIJQ8T0zx3rM1f2tn4o1McGYzJd4/DtxegJ2gWssI34enS4kGY3LbbLKIhABEQQQn7FH4j2ZI15xEnUGFDHRc0M4IkY6VR2wBIWjwYS2F89hVo40t+gL8PYpNsZjFQD4EbDJMeLs1AjOdItntbIiwFeSfnYkoXgaSdUUSX8FTL6AwCdJiKq7iCC6y3Ee/zYfQ7+ANAFUQx6zYep5F6ClOFU9zH2+1weAQ3XL+6vPfgfykpJJbCnkR23VzgcYcZrfVKE5qvb4WSSBjQTKIDRfvIGVfUqEeUgkyQnNYkP1IDYORZcL99axWEIy5IjuzN8i+RWT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ3RtWK4aQcY54Io0JlYoCU9P/vvs/n5goS0WLeAFjM=;
 b=U42hNxuLpI3VlGSc6t3IDJCzIBisOyBG+b7yOHmD1b/y6O5GDp3JGKjldtKJrwyrttR++At1HFbc7Ao4EYJtZQG7d84zK43ZMuw3mB8Zbmhi/6AvvjC4dx9JDoEzjXdCC8ABmQFToNdTxS+GxM8Svplq+RPaKMRa73k1K8hAjKl08h9ofY29ADlvVP5mgLfTDl1GLmPFgz9CHJazO4gEdRx81690FO+/hoPt7t9g86C1XsnN5TyQK75SLJ3bMbbxoO4EFUicS6vJ93BJlvTm6zu1f5BfYiQvrjceztegqXnFvNPafmJ0RWq+VbqLPvRuEyBpXFoeLjt0RhKVfUNSmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ3RtWK4aQcY54Io0JlYoCU9P/vvs/n5goS0WLeAFjM=;
 b=TO7CAqrTP/YCgC9STlIVRRDk5KSMxWZ55MtXA+RIeu/zdLRTevO2Yb3bC8AUeHaED3R8QholxC3DFg4kJwZxOohX2/jPSp6Yg/reqSJS+PmJH1wFz2ynPU9DBri4e5BGKmcPNLAGtkr+1mcsktV9aqAHB6K/RWpW1GgUxpWfQ/UQI/xYPMqDB1M2+KV8u619gfUFCtfnw6m3rTfBUWLi1l2kXFhsSJt5dSTiKZbKvjgACzhGBhPnFggbBwliOyaI+8Tfj5jaTAenmifz4a79+3ZcssB5dHggaAWdYEQ8ydpn/VKtk7oGMuQQhtBgEE9HvzV0/d2+6C+6cKqJv4jCfA==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AS2PR10MB6687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 19:18:42 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 19:18:41 +0000
Date: Wed, 8 Nov 2023 00:48:26 +0530
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fixes a null pointer dereference in ptp_ioctl
Message-ID:
 <DB3PR10MB683592085FA903B0D1B552A9E8A9A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB683554F488A562C8A89286C2E8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <20231107100034.09786df1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107100034.09786df1@kernel.org>
X-TMN: [/YNK5m88Z7nqeYWIUiQxoRM6psd636C6]
X-ClientProxiedBy: JN2P275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::25)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231107191826.GA1844302@nmj-network>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AS2PR10MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: a7841366-3eb7-4a82-cf8b-08dbdfc65a52
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	io4gnCDNkd1D/ViarpgX9yLS8vBEGWEnzUrGjwUvOL6mxaSVMHy6jzOESazBNTKW5wfQFilbb5JTRQJwsRLYmymxO3e7sG/FHS0dKsvTSlBrqfb4YSw+pZEc1vwi+UOxaKh1bEx73ZjMQeF0AfNfqrfNSRd78ICQOMhT9x+/qpgibrwGDglIZpBtkQmDBSnn2kAM5Zg2NarH/SAR8cLsnvOiYk4NWbX8i0OY6gkGXEKCtGuXDC+MWqhBz9bvg769lbjnuBrlrQDgk/BSbZOl7YRRxQiHJD5s3n9ti3auAUV8n6aByVjp/1Wol6oNXGfuINCiQhalCzBysYIUTzLRde9/zYXNrjC2qGBZ2EpfArPe+mfSMMPpT+IK+5y5r0Y9LTwQKIKHtKD7/TLQr2zfXczsncby/PFWzuheVXq0YUs3UMIknQnZZyXK/wXoBbyse8cI9FQur9PnKsypYfKR4f2A3XWB/PcNBTvl0yMSKfCH9NaRWEH2o5zBiOD6ZvIVOBppB0ufnF2H51LHQOQpiWeov3HHoZdbCw4Nb6VirVAsv02TiUts5f9E5Us9jZkz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jdHBEWvNvqbykZgqCnd/u8Lu6WLZs9sxBbJXNO0OIao7eAthlSI38nFjaOev?=
 =?us-ascii?Q?fcVx5V0HbDW9zK2ICQoNRYRlMrIqNauhFG6ETYq05WpqsMX96QWed4+vZ0vP?=
 =?us-ascii?Q?u4Ysv/MgD5nEHyIUf4V4YHFf3Gsq5AZXSXlDg+PWbjVhxv6L7309i2yo7xv7?=
 =?us-ascii?Q?c34FY4PxSkvHQ7/xIEtN/Vr+xUbH7BhlAnDmcDGNxM0pdM/9q4Sd2RRY2qTv?=
 =?us-ascii?Q?iHgDWxbn8zbq0wNjNZ4tXZSBGii7pUxQeeemSvL/cjiYqy93EJxberHNVgj7?=
 =?us-ascii?Q?BKDrSjkU2ZEB8OZvGiH2mDVeQVgYS6NRAkgP8AwFBAYdbYOGnAvWStccllu0?=
 =?us-ascii?Q?aXT4xhdSVNJhuKE5iztq7epAbLJ5m6WKViJyDZQ4OS+yIDI/fAUzQrJkBSFN?=
 =?us-ascii?Q?0nO2YNkgA6DttbnuXtHmC5Meom58u7WEJDEH3H6vWzawWvKSLAG0kmBqtrvr?=
 =?us-ascii?Q?KT3PKpNx6ZLX+dNWPdi3WVmAhHhEOBH8/xP9BEfA1a1T7gNpQUGDoP/0746K?=
 =?us-ascii?Q?ZXuQK2ZXzczcAZMRuLaJLiMeTVDy6NaNjeL8QvcvZo6ZMB1C3E0s2rXXye9H?=
 =?us-ascii?Q?Qz7TsGw43hQr1FZdqF+nX7ZDBKgVFgWSod1wkTRrJm8G3AnmcEPCmZ4rrjaD?=
 =?us-ascii?Q?dEm/PAeLgMKsi9iGiXFc0r7jYc9D5l5WgiZy/Emp6kqfqtqDMRPYG9sGORlT?=
 =?us-ascii?Q?MXFCgqq6vx7MjxPRHDT1/uwy0v+lWewNaYIl61Utgc87xJ4EjTlkhtWOw7Q3?=
 =?us-ascii?Q?Gu+nv44T62poGJ5XY7DdoJJnT7ZQsL4lDc3W9+71RzXz9yUQheoLfuukSSgZ?=
 =?us-ascii?Q?ohoFN4SaMPgfJA8Xm+XiW+IkGeNgreqejXbNzEqtfnjqiPh+eCYbNWlJ1fSZ?=
 =?us-ascii?Q?Do4xjF2GuqjsQgmtn2zbWyvcpxgUIzW14GPz3FDxk1mTBkmcOVo18k3w9QXC?=
 =?us-ascii?Q?mjBplLDWpqNbKvrgZ75h+87R4/LCtm/zHQv2lWehv3eGZETb8GXcJ0Zh58d7?=
 =?us-ascii?Q?WrnLI4/OfUSrTKwCgHM3JuJ4KuUPDbQEOlg0VGqSJ8qFJmKiT1aJU9ZIpuki?=
 =?us-ascii?Q?jeGwxiIOWd7Z6OX9CApLgZ/wdEOVHoY+9E+kiUTYjr1PddPqvDuEccB5TWEJ?=
 =?us-ascii?Q?YiL/eXfVnmO0cxoYj+JOm8/QZbohdBqJfyP/tqJ2dMZi0yMTrmwSR8cRDQqo?=
 =?us-ascii?Q?MHY/f/Tai34gGK+MEc74PGl85gKgMiT8UB5XDlWfhqAQG98cKlX6MF67RoE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a7841366-3eb7-4a82-cf8b-08dbdfc65a52
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 19:18:41.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6687

Hey Jakub,
On Tue, Nov 07, 2023 at 10:00:34AM -0800, Jakub Kicinski wrote:
> 
> Just Link:
> 
> > Reported-by: syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
> > Fixes: c5a445b1e934 ("ptp: support event queue reader channel masks")
> > 
> 
> No empty lines between tags.
> 
Rookie mistake from me. I will pay better attention next time.

> 
> When you repost please make sure you CC everyone get_maintainer 
> (run on  the patch file, not the paths) points out.
Interesting, I always run get_maintainer on the modified file
will do it on the patch file too from now on.

> And CC Edward Adam Davis <eadavis@qq.com> since his fixing similar
> issues.
Alright, I'll do that.

Thank you for the feedback.

Yuran


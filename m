Return-Path: <netdev+bounces-60006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 432CB81D0FB
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 02:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971EA1F22F0B
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 01:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51697EE;
	Sat, 23 Dec 2023 01:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PYIowqnO"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2141.outbound.protection.outlook.com [40.92.63.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAD7FD
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTefhAokJg+b+dJJmIm+9+FC9ci+w6K2N5j7bQ8rlFkamGX98fk8hC7Uz2Wz/xfX79oxvkv0T1u7OrUXuGzAEQhpA+q2SnrnT7zSTQ1TnV88VcNShAsHf3Plu+pRq9NOuHVPlnwscYMaL9+VW8/pwwLtKolB+POrS7xUqpBzmtBKiGQL/JTJ33x/TmEARP4jbAXJp/daHJ0OuXUoxzJWP6mEr9WhSfmRt1prpSU+3H1EvtddHk0j/YlHZ2BdltUjGoX6fhRtPYwcVJlcBJz84QJGf9tuMPn5q5i9yaMK/RTtgDpxyNF7/UlGZj6d2TrXOmuldKvALvAMJGB6u+ZmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDrJUcnJcfQNR4f+jcUs3DWOeO6DlN3CxXhNbSRY3RU=;
 b=Vg0Jw1aqRjx/6qQZIxR8iPKMi3fvRro6AYE6pzZIYY5+AsUVdYd3OPK21/RDhTnLeSqSkvZcLwrFF/pjIktwtZQ/GGL/z4G/Bj4Qp3vx3ZhzlVsW3OQW1np7XiQZtF1UAlpLcqCw9mKF3BWW4XQhLDqfQ+jW6wdxnjZcxmpyXfsuk/sBUMdNUJZnp6Ea+s8+jRhvgz4KUtzjCDdZiX7ssL5QKi4vbDlEJND1lJIpPvWlWluA4Mu2Q1Ayb3Y2beakt+9tXmItoKqxnkVjoE7g2lLnMzfOMblHObF1IVbMcEJ7usVm1nTty5fjnaaSQUA24kCP1J3gUaBptjOl04Vudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDrJUcnJcfQNR4f+jcUs3DWOeO6DlN3CxXhNbSRY3RU=;
 b=PYIowqnOo+CxmB+DorcLUqooIPxFwjCg3sS97JAXNEnvB073m8ihrK1utEvj/PQYvHOwrlu4y0SbTM9ovdKaUNtX0/o2EKtlh26oORjqhEa4uZr7rvZFlpLShZ5a+eN8IFcWgtCYuoXhNj+EU0t7VUmcx+sltCFcYzKt+ODzkFI15STrZuCivMtPubTn1Lea1OdC3yY7SeIO/wAXYOyHB4okLUig7J3upUO96uHI7+JmK2B52k1522BJZMUcgKcW9nJMpwNvTssAQsYK4T6gfRzwjaenYsQo7OYlUkcw2pM9q31zB7yd9xZljHKA8bIvfRDE2jltP7pJ1EgT6650Fw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SYYP282MB0736.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.22; Sat, 23 Dec
 2023 01:50:52 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6867:103:3120:36a9]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6867:103:3120:36a9%4]) with mapi id 15.20.7113.022; Sat, 23 Dec 2023
 01:50:51 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: horms@kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	felix.yan@fibocom.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	joey.zhao@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.com,
	liuqf@fibocom.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org,
	nmarupaka@google.com,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	songjinjian@hotmail.com,
	vsankar@lenovo.com
Subject: Re: [PATCH v1] net: wwan: t7xx: Add fastboot interface
Date: Sat, 23 Dec 2023 09:50:06 +0800
Message-ID:
 <MEYP282MB2697C981F3370FF2C15491F2BB9BA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221175332.GD1202958@kernel.org>
References: <20231221175332.GD1202958@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [jX+5w9SNZQDjZqGpwXYJv1B03hc9GELp]
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20231223015006.67233-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SYYP282MB0736:EE_
X-MS-Office365-Filtering-Correlation-Id: 18881824-dcc5-4c30-580e-08dc035997a2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y46JvOlskgcN4KJoM050RqnXd2lNZ71b5D79/HvdwsTRpCq7gKuaE3zI6CCr+7/T39FbzcoFSXy7dREeGNeOTm84h9bWpq3jU9Hh9kCbgJkNTEqkZR3Kq4+7OzqLq0kh+hkS4x8qgXalaoc5U2rzEUOY2pfkZd4d2EQPRYGk+Hrs+LSK0H+ErR8PRa4lRmyQ5E5GIZV906WmNpOvTPmIM5av9sa9Akh2RMm4swXtXHz39thmjq5K9v9LpK5kg6fcOFvJIXObEDVtA1hPG1sCmEnqAghALdRVpRIZ5WVfy1ej6FDMqlh9Kd6NyiCzk5T6dMILRDxZ9TIRN7PvXe+KmuDm0WqpN5xwWgwoYqnc+xu0WFsDxmjC1h5sel1O4s93pMC6LnAt9E/4UsSI32HNBof6SqxXLmRaYA37wHCctvRoT7iCUGoCgu74DEDy+RW3fQu5phqx1kM+TZL698XR4Tc6FwmqbJTAFnPPUDuY4oD3CWoT6G8C6z9PDZvDdhm9D+YkwIeJ75LnT3zgIXcHWbNbdeQNvBymuh8WgWrZ1WDF9vKXa75vgL4Svl8isFIsMupxcFML7wWSF5oQYODx8q3d398b2kOXWmgIEQq9UZU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cs91EGYht9JNzT19LOGvrWnZ5cDBz7hN0QdIrQpN+VR4ppkBkTlqBMl+NJAr?=
 =?us-ascii?Q?teKoUu5DS0kFxkpRdI/KrEbpxg3tD8bScW2Lsf2+pB7zBZaNt+Nh5IQuk/6N?=
 =?us-ascii?Q?MuhM+aYCQ+GPV5Cq9L+da7IHzfA05wWNLFOS08QWJsZ/WZmed8NC0GXBjLTW?=
 =?us-ascii?Q?Fgr4ZyA2V/aDcs4C+1gYJGeNrmnmOlpOecvv5xqEkPYV6eVwkRr3VdqIQ/ou?=
 =?us-ascii?Q?/WF/9ZHiBYYi3zGj8L+7h7l1B5rBVoTNaU4rrT9Jg+uJXcmtECLpefapGGoI?=
 =?us-ascii?Q?pCyG4q0RvBr/PPMrnM4aevHYzWjdrmBsrSWkfBBpXuJGbHBWS4vnfOSN3AJP?=
 =?us-ascii?Q?XtgazDuyxOrBEkD0TyclZXO6Bx7bfZIZ4fpl99M4v+t0x1MoEjH31Koy3gen?=
 =?us-ascii?Q?I4gj+Rwht5p6g7qAA7lCGRRpiInwPxomRzPMrbGh/hEuB1j2vD8dCU3y7Y7x?=
 =?us-ascii?Q?+iSit+Qr+8hbTXGOChjNs9Rm8Uvh+ih1IhlAg9PebXJWZMJ56nh4w+wbNzEa?=
 =?us-ascii?Q?XsilRiK3zcPlmPMJTz/cNEnBmzAV+9n7+UVMzpAFwzjmbl93BM0SLCZCf+eL?=
 =?us-ascii?Q?fAyxl0+a8LMqArBGsnXCne4mVVz3MjKpGJ2z4dlsV47yPKw/v0MRTIKqoMkb?=
 =?us-ascii?Q?KzHoOjnolhJum+kplREqIaoYmXae7izR55bOgC0A7esOoZRdI7zE3newzWMX?=
 =?us-ascii?Q?0ygPfBeka3xdEl9rj9dGnrNsMpvaV3MWB5j+3ZNgo1rnVHH0XYksxxUkomcn?=
 =?us-ascii?Q?c2cp0tcFLzuWKe7/VnspknPYQ1WGJAUJnqWkvD/T3WxDdJxfaF5SRKaXCSiI?=
 =?us-ascii?Q?sg4Q/E5/c7hazWH40njZG8MDw3Hc+ISBlUAkaZuweMlYNjtwKB5yiDsKMLwt?=
 =?us-ascii?Q?U7sXUTVAJ5OJjF0R6NDDkVwBaP06D3/Ffmt32Ze7si9W1vhtwH194wRZePoX?=
 =?us-ascii?Q?N0jbEV7z+zMPX9V/Pwo41gPlOFCXav5LDHcZvHlLK3cBLpeaIpH3RKI9Xk/z?=
 =?us-ascii?Q?+Q3WLoupechc3p2eWDOrQuL2q/z3I7FzEV70hPwqH/vzQY8VJ8AfcI97H0QC?=
 =?us-ascii?Q?kgtXvRD4uZIGSgpd6WQCPaOw5yU1iaeAYWSPVZ0jHNgFkDRJjzqnz+gRRQIX?=
 =?us-ascii?Q?I8xAUo+QOaDhphFBbHgdDd6kNg40eg0LWBBw+dRo/1QxD7mX7BNzd3UvVzoD?=
 =?us-ascii?Q?1nW3P2y+CcPjMmSd43OXv0VweVEDEyrvODgzfK7BOS8nKCsHraXtIe2y7jY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 18881824-dcc5-4c30-580e-08dc035997a2
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 01:50:51.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB0736

Message-ID: <20231221175332.GD1202958@kernel.org>
References: <MEYP282MB26975911A05EB464E9548BA8BB95A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB26975911A05EB464E9548BA8BB95A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>

On Thu, Dec 21, 2023 at 03:09:51PM +0800, Jinjian Song wrote:

>Hi Jinjian,
>
>Please consider using goto labels for unwind on error in this function.
>Something like this (completely untested!):
>
>	if (ret)
>		goto err_md_exit;
>
>	...
>	if (ret)
>		goto err_remove_group;
>
>	...
>	return 0;
>
>err_remove_group:
>	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
>			   &t7xx_mode_attribute_group);
>err_md_exit:
>	t7xx_md_exit(t7xx_dev);
>	return ret;
>
>The reason that I as for this more idiomatic form is that,
>in my experience, it is less error prone and easier
>to maintain.
>

Hi Simon,

Thanks for your review, I will do that.

Best Regards,
Jinjian


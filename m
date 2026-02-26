Return-Path: <netdev+bounces-261218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIO+Hvf9n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:01:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B88F1A234D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D801F301286A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0DB392C28;
	Thu, 26 Feb 2026 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lRDcaW06"
X-Original-To: netdev@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021081.outbound.protection.outlook.com [52.101.125.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88AC392809;
	Thu, 26 Feb 2026 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092911; cv=fail; b=AuKHHwkwXFYJ+nldeBcroCI0i8XJ4i9UdO6jOQSQl3Oo1ytQVkPD5vDJGvNFpr5Vs3WgFTtmtBHCgPMfhWm7CPfILzoGV6P8U0d7AO4z/S5gHzZecc5yj6yzV1Qr54IX+kRgPQk4kzJ2J2uazUazUiMGQnYNXruW8w5wMI6zlJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092911; c=relaxed/simple;
	bh=1DXqElUjtuC6ho5Cw6gIs0KUXlKmL/btuGBuVjbEPyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rL+f8GJA6iZPexbvyQibofeSKZyYIUEt0YH6CkTClc/hkJv6pMzxb5yMFvTIkhsvtxp0v58umFqvVNcp5lqg3gtCgeCe2KmcmCdM0FWRwHHcRHeqIuIyG1NLxtfHtZdamwT7zx+onI3XHO6Ukc0O3xNPCkuT3NeV6SXMXVH+djQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lRDcaW06; arc=fail smtp.client-ip=52.101.125.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+LKIni5H4HBNv+lcLyc+Xp40u1gXB6YxYZq+vVUGK8DLrZn0YSzEE1LuZmvIkuq2hpKuFLqFqa8VTD5a64IoRRzmx3MTLKTAyPrLQwbszK7WLGItftq7tgTA7lAa3/4YUJXEoxpafCnfBVYycFEqlPei2tR49MSa00zXYC5MLBGNeD3gfgsaFrKY+7PoeXDcuxYELxdTnGlN99DTORf4M7z98Wk6Z/JX32yOvqUNaf5SodNtimFx5HMis/ioNku3FbQxbgWeslMU5RCFLH7eRrnbzxZ18DsAJRp+JfDI8qsXAQrWG8431SXbXEZhMZ7z7kwib4mdoPmmwUVkvMJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=908cDv0zbKf3Iaz1S1bXtK6TnT5sRud/qogdUOL98ZA=;
 b=Mb+JWooZMDzs0+wSxknV7PObFdDQP7a9j93nkWv+VYZWyHoR5LYw8SEXk4SipJTECSiIbVKxRgHqAS6KxoKL1T4VoQvyKx35mYYYbZ6CVMd7Q+yjFZv9iHdzYfv74hZSzrjSjjC5AOUWNhfp3EaYjwl+1RxWdmsNkAtQt9pkgjIYiMm64HMyzio6WRuS2t6d2sGOfC3+diUp/qv+KCSFkCIKFv3l56sDAPD6uAxcXnKhYy0dWu4cI+alxSH5KzaKnoPRLBy9GXmAzCSLJW8MFuVGnMPE4RMI6+BaLeTVgVuVhWUx83t9CTdTTyTQnI3xf2x/IpVnnkQXbi2iT15IOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=908cDv0zbKf3Iaz1S1bXtK6TnT5sRud/qogdUOL98ZA=;
 b=lRDcaW06Nd4jmpzFxOy+HKfYR6EwkS6o3j6+qURMOG7a8veA5QK0YWAm0Pmq7hzDJPmDpcbZ7lRSHTNTQtxJVZU+O+JKa3iHI/9eABYfjcyFX3KWA2t+QW7Eu2OAtcN/AnkOgIY6Arm+DHg37AUYB+lrffOqt+yxEmlOUX29sYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2482.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:22d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 08:01:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 08:01:46 +0000
Date: Thu, 26 Feb 2026 17:01:44 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: ntb_netdev: Add Multi-queue support
Message-ID: <u6k7xyjkqdn5xsgderrxi5yw6mhwtl3srfeefagp44jco7jc44@c7f4tzlaem2l>
References: <20260224152809.1799199-1-den@valinux.co.jp>
 <20260225195004.7e9c8b3a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225195004.7e9c8b3a@kernel.org>
X-ClientProxiedBy: TYCPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2482:EE_
X-MS-Office365-Filtering-Correlation-Id: daa2933d-9f3e-4c6e-7427-08de750d4972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	wAUxhlJN21y5qjD7puWXK20/qne4v1kJHsRGJHEMb9A/shHoEJ+A0SKBh30QOu4RCo6dGTF93mbEgGzljpuVucEEfGIs05firWKjp/GuelwZx0/v2Ai5rPqQ3gou58rSDpj3e01Ci8knfZcnfRe6+nx3cf+Plq3a8f4iZ1h6uguE6TxHoZr7yTde26wlFs2zfiy7WNU0CcuvuN+g7ohKkTsLI4zid6z1QkBmnA+Q7g4xaJgGMnaBTFHpe/WWsSLFeUHcl7oEJ0M1hVL6uBlQHRAeAJSGujwDCAfLs7/TbRCU9ZeU2Att3D4a6TLSeYomJiCSdCmwlAVTLTsnFhBc47xzmn+n4rVGhLJb3LTbQlSIjJY1FoQbU6p3hnhN4F1EEtJd2rmdX8Q2Di1ZlXbrWKONI7BoM+9Ux1HdnTZPka3uf5rAbOxKgVcNYMnP7Lv3OK8rUANkq6Q+vcaFWoRNmWHbQFhqzsCI9BsGbA9CjxNufZSgW4dUP49SYS0eq9ciH6339E8/x+txf5QXh+IOMnswp2uRBvROS/ERcYbFJtonb/d2tkQQSVfxc4ESJLkfh4XAcxvEyxG/aRdsvX7uLrVPxk8YZ0cqL2DX/n12mjIedymYasHgtSrhIy0VW0YCvL/MKfydYH6Vtbm3rlZnW1GU9yao6WjSYpkEXbh/NLSs7ppr/v/LIxC6AJt24bK6P1u2yIaY+d4Qw1IlJYJoS4kVO6JGrkaw7jU6looJudw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMhps8OvvgsgF2uzwEpjIfiEC/+u0+I8wDBHxHLkW0rEjllx6qPiEjOHbyk6?=
 =?us-ascii?Q?Lvfge+ZKQmFTzrMlF8zJjVmPX4FPEoNXmHB+T2yoPh9YBzlzETyKJUFNQo20?=
 =?us-ascii?Q?8Yjj+Q33WNZTy+n22ABsaLV6Vwv4lxuWt+chCPjXda8Wza371ZtNHaKEh2EJ?=
 =?us-ascii?Q?YfT4ojMNZl5TFTNQc4z1SnJSAhwQlByy8e4HJ8WeXDQwoZhZAFNQla8zgMQD?=
 =?us-ascii?Q?ef8RytyqducAFEtTCZtqBSDH6nVPNnk7hwURoAseHfLr19FFitWGVaOk4r3/?=
 =?us-ascii?Q?xgdA7srVgejGj9+MKyX8VcLwhrehDIvwJdRK2MoEEHecrNLtk6boaMrmcCEW?=
 =?us-ascii?Q?zooSlaBzNmZjDQU74aeIlnoSVHV+FSe5jTvboZxIkvVwhnqt2ZgUxPcAeSrt?=
 =?us-ascii?Q?bsSUJq0ySl57HTDQPeciHFdnEXeT9vFJDLDIDF1WKss6Cq5jGsThkMiXB1rs?=
 =?us-ascii?Q?3Djow/W6m0ZGJhqj9fsV546S9tWcGB9AouUvh+7LHr2RnUSMJSouTj98ZAIQ?=
 =?us-ascii?Q?PipvEKOYtgg6v/1SAaj+lFopUzHPvfrH6AywZCm84pD2gRYfOMAptytHhVyR?=
 =?us-ascii?Q?Fn0Ae6ghA4z7/uuSkHCprZ5gBX9vjhe9KQefc2+XjpA5ts5t+KvV+O+lUaOA?=
 =?us-ascii?Q?oE3z2KYK3ASz/TZcN+PglavSv5dje2EEsn/ujydyh11J4AYPScBMqDzFoxJ4?=
 =?us-ascii?Q?5jDveOfdPdNVopCav7gSTf/4Uv0qvxin8EiGXRoUqsQdtkIQsowKvPSdcx++?=
 =?us-ascii?Q?b1IocmqL63CXqCLqFpN0JuheLmADUqgPJKQfUafYbhJX21HzDeOlYiAQVE3+?=
 =?us-ascii?Q?UadZ/f84qMXz7CDE75DizLvgtdnSujuVKnV8EwTe3/UKQUhX28FjcS0Ae0uA?=
 =?us-ascii?Q?dKBHsJg3P97bMVWE/IaeLiCVe1Dbl0efChgsjvEhq/Spjx0BnTg9FZJ8Oqtk?=
 =?us-ascii?Q?AIUeMxNJLZykkqKI8R3W6Ej/yed3fCDtXKiW+OvHcaiyVY7U67w2Au8sQ7D3?=
 =?us-ascii?Q?gk4IuHkDCp9yoUCZBy3nY4lIAmcGd6axVLOinpes7RqN3qDIK0unuv4n64WL?=
 =?us-ascii?Q?K943Pjck0HmGIlyowgIkCjIJd3GPmuX428jGmo51iOtdfgHHxmvnFs3Pl9/K?=
 =?us-ascii?Q?6tukcFTdBHa5nS4zPNQ2OVJ8GWhgk3HLL1+RcJMGy471qtQ+H9VgprnjAw+l?=
 =?us-ascii?Q?6sBiVgIHI3r3T4Rk4L6Wo+/22i7zYQO3BdWzcWx3P+wXZziIHWZM4i6Xra+C?=
 =?us-ascii?Q?hVUxOH5d1/G7A/zW/8jHfzCcQibLQ0s5jmapGoXrRaCWaFgyzvmitI6rwpDz?=
 =?us-ascii?Q?GH7CmEg3usp0ElJdsqlcVvDdnRCsc/lC2ZdM6C5OA3gz0hU1CoxsP0kdEXQ1?=
 =?us-ascii?Q?N90803OA89+Kyb38Ikp6rq9tDorGvMw95jSPgB63lzBeO1QFgxJKa1JPbXlH?=
 =?us-ascii?Q?251PX/8tlALgm8UfMGf7uWKUFiVHYTydJj7Dzwek2JI53q/frKSfHAu44MNj?=
 =?us-ascii?Q?mwCvjEYGUlHmgzY97t9Y9euTq8IaORq/v9N2KnHa59NCkcLPIlNGLRl2jtgI?=
 =?us-ascii?Q?seE8TZqkUq0BvEXGdjMyvnkvU8ul2q6xylekI7FM4fA4oXadYllV5ZnJvRZc?=
 =?us-ascii?Q?Ju3JMmDNAKctc08gP9gfxt6LhyqQybHRv5CgSAcGQFof6Ijv72K+8vOpvsjM?=
 =?us-ascii?Q?cq3EFmkotlbvA7iARKqwJ+gVDOCmML9riyCk8r1ABX1Dq3IKQAFMJrL31xsO?=
 =?us-ascii?Q?4S8yACSwaWt6oveBIY69dOx6Bmxn2GNTNY+kDJG6NF868ZcxCYsk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: daa2933d-9f3e-4c6e-7427-08de750d4972
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:01:46.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+Uh406kiSFeXFmibCmJVyUUCjTRxU3nPEB998JTqBRpHZSVbMqzCrJpWibG9zjDB097U9BS1Wec9btReAUWHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2482
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261218-lists,netdev=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[valinux.co.jp:query timed out];
	FREEMAIL_CC(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B88F1A234D
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 07:50:04PM -0800, Jakub Kicinski wrote:
> On Wed, 25 Feb 2026 00:28:06 +0900 Koichiro Den wrote:
> > Usage (example):
> >   - modprobe ntb_netdev ntb_num_queues=<N> # Patch 2 takes care of it
> >   - ethtool -l <ifname> # Patch 3 takes care of it
> 
> Module parameters are not a very user friendly choice for uAPI.
> You use ethtool -l for GET, what's the challenge with implementing SET
> via ethtool -L?

Thanks for the comment, Jakub.

There is no technical limitation. I didn't include SET support simply to keep
the initial series minimal as possible.

However, you're right, adding such a module parameter would also make it part of
the uAPI and unnecesarily hard to remove later. It's better to implement SET
from the beggining.

Dave, let me respin the series with SET support and drop the module parameter.
Please let me know if you have any objections.

Best regards,
Koichiro


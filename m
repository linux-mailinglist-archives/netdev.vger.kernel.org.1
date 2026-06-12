Return-Path: <netdev+bounces-298741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IIEID/06LGpBOAQAu9opvQ
	(envelope-from <netdev+bounces-298741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:59:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD7D67B256
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:59:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=jGQSdCZJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298741-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298741-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24B24301C5A4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4C407587;
	Fri, 12 Jun 2026 16:57:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021127.outbound.protection.outlook.com [52.101.65.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A9406291;
	Fri, 12 Jun 2026 16:57:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283459; cv=fail; b=eWhnbXzxkecqfRW8+gfVJ3qIX5dx917CbCw66vPdcqt/jRAKbVZIWq6VtsJW5x0aUOXMnKjH77+zrK0SSuz8VZICBbAJsNtI1j7wAPLRTQnCdQ0Ae5W7b3I2L/LF4mVVEzV27VW+WhfaVFYEIlixpoW7MGmWOjgArMP9114J+u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283459; c=relaxed/simple;
	bh=W9UtCCNUYaDVMt/7zIAWM69LxV1XPcVeYrQCp4Xd25Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WANnE1E/L4PWsU8V3dFEGX5MgcL78nTtC6oPIPbzv1t7BHfaC2USD57HK/MPMGDkLp+LQkwpFTdpHEdYYANYdhBwoBe7u21q5p6aq7+JOtsm2IfFwh/DfZqS8BpXqWCYuMYxZ3lm4ea30F9nWWuUeiBAEDAciVawYfW7pCdD5F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=jGQSdCZJ; arc=fail smtp.client-ip=52.101.65.127
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLS9aZi3jCL0VJeAyl0j3VeEb0MeZM5eqC8t9aWRQKt8HSW9U2z+5Mj1axFnciBcS2lFXjrSR2fbarxIfcDVnaj+49OT5zcyt62NlFcZD6c2o7SNHWFomqVgjZNHlaveR+2SkALDV2Wegpp7R1A+dKg0t2VlBNky8dmOmA1oaEyN2JI1RjU4zqecLs3Qvz6NYSD1eud00lWXP/ZsO51ABokAGCq7RtyIu0MGvdGBYeNWinOEoaOVTqkxpKp6nSMgJyO1GEBEG7aTvaahHOgxPkbr/HIs/WRQDWAWYTuKVnhp4ObX52hiAjFTyNP4Ly4KGmEi4IzLe1g80v8yAy78aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQlNocsD2MjKBuiSzYdgKTt9d2kIH+AIU2CfcjbhLl4=;
 b=l269R9kfAeCs5u18t7V94ISWar6FfH9upssFpUYFY3eHLdN1b6ibi5dwkiKZh+Xbg6gEKyi3ySrpUi1RqlSB8xypmrrr74SJpF/P6DnytaTOdDTp+QTEy1YkP8NkiWKa+kplBLp69eWt9vxyD2UEv44fB24989JQ2Gx5pycshJM8IsSQ9I7Y9dyS1KNgZhvDD6MRinnXZv9TA1HXriccEQ6UO8Kkj39H+JoFevkJIO+utoVw82UzzXkkDWHCijoS6Ds58kvubEB6Q6xITA3zj5ebQWG6D16UW/MAujB/T3Q1e4lFyiU4dhfQ+TrCMVKz3Z7s6OSF/zWgRoJRqyAFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQlNocsD2MjKBuiSzYdgKTt9d2kIH+AIU2CfcjbhLl4=;
 b=jGQSdCZJNz+1vbpxvcqrPpcM/ZEhR0MAY//ZYH9xOLyvvUTs9mYQNenknIyfrAnVGxtjY6Z+iYU2cnuUeQyT0K5Qu/pAxxv6kdzpKdQDflU7AxQCQlEsMGF7RI1K2OUYg4lW+N5efLC8BQrQSQLdoDG5l8UyIO/7xEhPBBgOSpzDQVidInFI8FgHmD44nqsQcIZ1dQjbdRKewYr+FBshd3jP6y+Q8jQ9Q0xpjm1iYuO2ohryO8vN9G+LCu72j30RYZn69e5jTnn25QwK+dC2zRm9L/WydqebI9jkoX+mDoDJ9cQXRP3glYubf22U63OutqVmeUPW2B8JQslX2XJmPg==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9416.eurprd08.prod.outlook.com
 (2603:10a6:20b:594::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 16:57:30 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 16:57:30 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH 3/4] vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
Date: Fri, 12 Jun 2026 19:57:17 +0300
Message-ID: <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::34) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: e64d94b8-f7b7-4b8f-4db9-08dec8a3af04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|23010399003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	zferuNIBJcxejlOVPp2MnpukmD3MnCVN1R5LyjSkcGiqXDyvcZH5f+R0IfyZ4u+IDx3QxlV1q8xlR23vuxmW6CLpwD9fUU2Yw1LT3/EQ3WthGDIlrO9tw9Y52vW7VWe3ZnO2t4szwT1x5A3XuobpycuOJWn9bgQHooVCMbyE1IJ+7ADXc+5EjeAFbX1hGGgPztKXHxaSVHbgkjBJV6WcNOyJsiJPzYhh9WLG9ozRNx5i7iKymHP8wTHPFp+FKXndu08OjDc7/RL9CjSWr8MTWquHSd4ymmcnE/L9ssxr5LjIv14VMaYOgWqf9MvD1+8CPXmCBIyqyxxbLlDmQSqy2m4Sz+ls06uQEYYna8wWX6lYBXMpyqR0QJFe48f9Ansoxng5Ix3uUz69NWmfzWaTs9FLh545wRZjzBK/aHB5lu6GCbR2BEluHrNqQrDqaYfthyV+sGVFuWVirnOJVz4qKMouDioUpDmtMuPv/KmdoxxCcufM3NFqPbds32yf3zlqg1MYA630rTjsb+FE0lOEXs877RniQIa1I/ThQiI7LxvEJyEC6Ri5aOSce5O+GgGaHt+8huwoSSIcosDQgNG9OdSuTc1ZLAbKwU5xVoeicgmsU4q5etR6Y8Hrun240iPOKnVuR+B3qf6y8FKLWak3C/pGVQcUg7hbrMHjTaO9gSJoHX0OtO9s/Fv5uk9SUigPBW87AcdyhbmSQrJq4ImeDcKGBxa6UpI8EvgcLBoi5qllzzbDARVKp3o+qclc9OnJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VECDJA8bpigK65XZ2pNlZD0no31LgICHGZ0IDHiNYjiWqffYngKu/06Wk+Lx?=
 =?us-ascii?Q?6y3yg8r2GdUwgHeMLQ5V2+u4nT2xT3ZtfIAVNOldb4GHJ9g+gjfTnEbv+IzP?=
 =?us-ascii?Q?n/sLULsRwGamL6jXzkd/nuoIWsXig5f1d1hx1vkVr0zdR3gI9wc9ozZfv18G?=
 =?us-ascii?Q?NJPaAXSCmJcp7XNkvuwi5o6KtQieSRc3ZOp0CevOPETOYYGXAqgkWT8cH+dA?=
 =?us-ascii?Q?Rvikfb31Rlv/l2eeCAKjEUbnlxArsPGsgelb/w+BKPWcudEi/2mLnhI5ZdMq?=
 =?us-ascii?Q?Nagy4K5pOJJu0swvKR9k5+CyvzDhvCV43Fgy2ZGibShJU7VD+my7Y2baY5C/?=
 =?us-ascii?Q?fptZGzJdHpHOcj+2RNSfiZIeufbFWh7L06cXMPLxvlR9JKvm+mIEqFrXzOaH?=
 =?us-ascii?Q?XrVg84PBhAi6wD1kFxsFK0vPIP0nDqxtJwvUeoQI0y2p8XGFGwdFWFfTRSgZ?=
 =?us-ascii?Q?1xwqFR0JmvbdaufBqoZKc+KRU8KiPTLgp0skEJibfBKPrdkDkZjerqmPm0At?=
 =?us-ascii?Q?SlJL/Q69v4p6TsXRFa902Rk0l2i743WDKpV2Fc3gHby2bqBhG603CX+bnfhL?=
 =?us-ascii?Q?hlQdh+HkCVCqOb2ZuBOfWk4gPNJQnxjUnfp/dIasjiIDgqF7idvykrC82v6a?=
 =?us-ascii?Q?q+iAzk92/BhBMJgmx7XzZ0Hu+xWAQ1mpbbWOTCD+TLRCzJc8voAXh0JpwcuH?=
 =?us-ascii?Q?rSaYwN7/CS9c+rPX8Myg3gDWmgoeE0wysx0U4uwt7tI0z095lrE/y3P1pRZV?=
 =?us-ascii?Q?k+P2hqYODLetDi6ZGb/9K8H85dGJZJYKRfy90mJNutmZCFFuVkCb1M4dma+l?=
 =?us-ascii?Q?Ix5l9i/UXsE2XkcmCJ/vDlqpxD6lY8H52uphaMTjlzEUf1kK04GVofC5fQX0?=
 =?us-ascii?Q?KFssvZ4WTkvBZ86owiaJ6AmZ6VvfKWIv202Z7QRfwmVznpQEWWj45xptE4aZ?=
 =?us-ascii?Q?bpMX785JLH3kj1zcD6S4aOjGkNWo5db/HpIAkNq7DI7mqfnR1MROv8AWIvAz?=
 =?us-ascii?Q?+3Xi+sXEJNou9te38PONhxNLTFvJ0s+BrRTwfPVM4OrzjPzZgdAxXtngEu7q?=
 =?us-ascii?Q?Q6l79/0AgWILL3n/R3zU4C7D54J8IKKYiVwfVeE5EuuMr2sog1M2EZR8WwyQ?=
 =?us-ascii?Q?6Bj5wlCCM+UW/0rgzBzGPF2cUB+r9Sey3OE+uNwzhusb1DWDiubZIK8kk5L2?=
 =?us-ascii?Q?Ta2q9E1k24r5cTfXbcCs74/+D54FmaNiBF5d7N2Yu2msT3W/ry2F3a40fypw?=
 =?us-ascii?Q?GUGDxsucpi+uuklQc5kc99mdkG0xMy+BOvMzUcPUTe4pHvoo9V6lisixs6LM?=
 =?us-ascii?Q?ueRaAMR0kvDbdC8IclUU06Eqg3nsnoFUVg/4O2RwJBj8lG3yvKFKW9UgxrQh?=
 =?us-ascii?Q?1YTepT5EuO4H3nh/9LUi8EGfXjSnt1iJ3pWHNS11F2ma63Uq9Q4poIAgmf3J?=
 =?us-ascii?Q?Ak6SDfGxo/WhckBp3ObQ4dCt0Nwt1J2FnC9F2QESdb11tX8kgtN35h/ca2hC?=
 =?us-ascii?Q?WuFUZ53tzDXVbfzooj4XPKNQn+lI3bRis1L4eaJ84ts5IAjJa1z/8nnygma0?=
 =?us-ascii?Q?RPh8+q+f2pJ1cAlMlothSaGFqybCNRKWBxopV2vgwBUjEhhXijJcwyqL3wlD?=
 =?us-ascii?Q?pKWIZmw/cUgvCeZyPnU5wAMu5qaXkFw3fhO2lQvaVpWH/UelejINSHtHKWP2?=
 =?us-ascii?Q?wRSEHaNGfV6ap1ZmWZxKQEEYm5x7J+xIdF/JiAKYN8ndh1AxTxypz4QW/XlM?=
 =?us-ascii?Q?V9I/iIxklOo3bZ637baqSybm+lKAhtA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64d94b8-f7b7-4b8f-4db9-08dec8a3af04
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:57:27.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXNVLYzI/o44BI/XXyRHkpzzr2PcxQ6UZN/64U9jQkasMAovX96AMQ+DNkLQAZVmLyoZhw4g7GpE5w+imd8J5PP5ICGbiptOy3yUaEDSHHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9416
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298741-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,virtuozzo.com:dkim,virtuozzo.com:mid,virtuozzo.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BD7D67B256

From: "Denis V. Lunev" <den@openvz.org>

Earlier commit ("ms/vhost/vsock: Refuse the connection immediately when
guest isn't ready") added a fast-fail in vhost_transport_send_pkt().  It
rejects every host send with -EHOSTUNREACH until the destination calls
SET_RUNNING(1).  The fast-fail condition checks whether device's backends
are dropped, and if they're, the guest is considered to be not ready.

However, there might be other reasons for backends to be nulled.  In
particular, when QEMU is performing CPR (checkpoint-restore) migration,
device ownership is being RESET and SET again, which leads to backends
drop and reattach.  If we end up connecting during this window, an
AF_VSOCK client gets -EHOSTUNREACH, which is wrong.

Add a cpr_paused flag set inside vhost_vsock_drop_backends() when the
backend was previously live, cleared by vhost_vsock_start(). When set,
vhost_transport_send_pkt() queues the skb instead of fast-failing; the
existing kick of send_pkt_work in vhost_vsock_start() drains it on
resume. A device that has never run keeps cpr_paused == false and the
boot-time fast-fail behaviour is preserved.

Pair the cpr_paused store with the backend store using an
smp_wmb()/smp_rmb() pair so a concurrent sender on a weakly-ordered
architecture never observes (NULL backend, !paused):

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/vhost/vsock.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index e629886e5cf8..bcaba36becd7 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -61,6 +61,7 @@ struct vhost_vsock {
 
 	u32 guest_cid;
 	bool seqpacket_allow;
+	bool cpr_paused;	/* between stop and next start */
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -311,11 +312,17 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
 	 * the mutex would be too expensive in this hot path, and we already have
 	 * all the outcomes covered: if the backend becomes NULL right after the check,
 	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
+	 *
+	 * Don't fast-fail if cpr_paused is set, keep queueing skbs instead.
+	 * The kick in vhost_vsock_start() will drain them on resume.
 	 */
 	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
-		rcu_read_unlock();
-		kfree_skb(skb);
-		return -EHOSTUNREACH;
+		smp_rmb();	/* pairs with smp_wmb() in start/drop_backends */
+		if (!READ_ONCE(vsock->cpr_paused)) {
+			rcu_read_unlock();
+			kfree_skb(skb);
+			return -EHOSTUNREACH;
+		}
 	}
 
 	if (virtio_vsock_skb_reply(skb))
@@ -640,6 +647,9 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 		mutex_unlock(&vq->mutex);
 	}
 
+	smp_wmb();	/* pairs with smp_rmb() in send_pkt */
+	WRITE_ONCE(vsock->cpr_paused, false);
+
 	/* Some packets may have been queued before the device was started,
 	 * let's kick the send worker to send them.
 	 */
@@ -671,6 +681,11 @@ static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
 
 	lockdep_assert_held(&vsock->dev.mutex);
 
+	if (vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])) {
+		WRITE_ONCE(vsock->cpr_paused, true);
+		smp_wmb();	/* pairs with smp_rmb() in send_pkt */
+	}
+
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];
 
@@ -728,6 +743,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
+	vsock->cpr_paused = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
-- 
2.47.1



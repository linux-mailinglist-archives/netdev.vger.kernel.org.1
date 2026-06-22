Return-Path: <netdev+bounces-301185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MMZQKmV4OWq3twcAu9opvQ
	(envelope-from <netdev+bounces-301185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:01:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6666B6B1A62
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:01:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=DqQ0d+wk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301185-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301185-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31923305FC2C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B303438B1;
	Mon, 22 Jun 2026 17:58:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021137.outbound.protection.outlook.com [52.101.65.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E123438B2;
	Mon, 22 Jun 2026 17:58:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151122; cv=fail; b=SH5oHmPr4abMpK6r8ERjz7ZpDvjdJIO2pVBPivOhRcN8VuYZvxMMEk858y2ERZUbVd/aTkJXp2AB/MYeLkyeIWb+5rp7ZAoOVkctJ8owst2Hdu67wH9kUKrWZ7pQQXn8LKCYrx0mQ676sMyywhITfwyari/q395esAO7XnHDWQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151122; c=relaxed/simple;
	bh=snJJqHJwcydMeKr+3WZpIFx45R32tPi5LnxJ8xlhFeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JYxi0EcwsFYwYy1XYviseA8qcO6Ry3pwP9RuiMKmwN8FD9Df1CWxanAWy7K2mN2AOiQU/P6Fh78SzZ2B12vdvQzXYoji9UCPybKaui+Xl/BEGlSCYIeiBfuMdjeN+X3iCmwE9WCT9BQcFmrxMdQAMKeMofjCWwPBrgFeIs5Uv90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=DqQ0d+wk; arc=fail smtp.client-ip=52.101.65.137
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEPjsTfCQrJAnD5eSs0vrAQ+jnAlsTCOzq0fWc1b7DCorwyZ5v+dXu9akTP54yimika0TR1WNkdBJmnFD3Q2SMjn0CKS5PabSxeJv+gnqCDX3oK09d1W010i2O3Rw67hACqgGIrp3lxefd7QwqxQhzqynfzlweVCGPdXjxOc5DOxZrVXY+MkOzAqskQalB7AuolaUTK4GcU4EXOGsAOkuvdrQzrrykVIpm889S8SI9doVbZjwmqGLFCfiD6qHohwSlCjOyqm9AriovUmYVRHnrqUuXLeWjxstJkxoaodK4NUyj04rMNy0j3cNoHPFH/9IegOfaZEx7ccZGQP4d1S4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pPjFWkOnkdvMy/PCeITGgv3dlh6FUoacqP72ESTAPs=;
 b=nHVdF4Y0onhsMAFMqRpH1aifntkhh5aMTFjz72q0dwKiEjPf+rgfF3w2ortXnoWNUbRgt8ilQjaCgc7tz433U1OsCf2wsIj1S9yTVF0YkixEApkOnSz992Re/cupuSyoRoNyE+9rkdLu3103K+SxwjW4ftLVUVHsnWz6nisgd0xxth6ev4XnwgmnbtA4qNWDhiAarzwvkU/2LO9i5Y9HX4Ren7wxbZj+Yj4sIrFWIzrdrkQun3rCSRGf8QZpMahQC2q91BG7fM7HGXYeOmlu9kh6mtghQL9ksbPF/AHHXE9E+GJOxScjmXtkBSKX74DMv/yI+y+sAu+TLQPmTbWRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pPjFWkOnkdvMy/PCeITGgv3dlh6FUoacqP72ESTAPs=;
 b=DqQ0d+wklovdWTwjpOyVzcOQfpxf5OnZuHO8td87wpk6i7nuU+6p1bV5qh1tEZm5GH3dS+IueZ9V3dNtmMm5Vqb/4TvGWhMHadBuV90tXpsV3k64vaFAlFhwc+D01d5TheT5vp+GnWbr9O/3kfAiweZPHUt5VuJ3gPNIjTWjyQXCt0YTFxoFMvjJQepIJ9TR2NZHGhpClxJx9K9Y6PEdGi2waGvL/otnQy2sqSGJM3YVgVLv5P3PVsmP0KfSjnrtfaseqKAy3u6ijPCowpd5cVN3X0JDCCDBhzGkfdi8WCVM+H7vqvLwvTTYnanGwIRVCzQWWzY3aeodNYbPKLN7Og==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU2PR08MB7375.eurprd08.prod.outlook.com
 (2603:10a6:10:2f3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Mon, 22 Jun
 2026 17:58:20 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 17:58:19 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 3/4] vhost/vsock: re-scan TX virtqueue on device start
Date: Mon, 22 Jun 2026 20:58:07 +0300
Message-ID: <20260622175808.508084-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
References: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34f::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU2PR08MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7caaa3-988f-4019-8fed-08ded087d816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|7416014|376014|1800799024|18002099003|22082099003|38350700014|56012099006;
X-Microsoft-Antispam-Message-Info:
	9SkHhAIcasBl4HOeDtoEtORa5moORdQQy0LnP6CQnJi/GZJClkGNdh+FboApngcQKYqgC+mcy7oFylChg+ZoCKiTpwH53xWf3nZoQ87zD1PKHgXRTKLUse2rHl3v7+HGmreZER80AdtjkM34PF2PcnpePR983mE8XQwMCL3HP0RiaJnJkel8nD6oE9AjrGm9x7qzb/HPhtwYbVfpNenmaNEeXndDAOXpq3RKg2zymYD7/+bzsEy4vG1EJh3LcOPuL85E9X7NBZoFDs2Tq3AvcARUvQhO9X6qAS1bRdklr18t2Z2U3TEKrAE/n0e56nbtUMF0EYgP88YGFs6s3lJeVtPud6EZ/1dfRwGSaeFm4ZiF0FIMv+AO1HaCqMJeWZfPOExYl48h0nRHhmMtqSuP4BdA+Y/OOWGtNZEIk9uE4CPN1JjR7pWDbBxrD799XuEBEycESwQdp5gZsjJZuizCfNLqulYAaUUZ837Tvol7+IXuQwmKs8tU7sihTDM0IyoDGsgZHp8SZFaM+8XLfiSvIAa5R+lpBSjlt1altelIR1Tn3J7ItgRLYvXX32EhLIiVGYUAm51LalrJZXcxikD9RsZrU4Q3HBjSidooO8gjk/ql/ztbp2cGkh9lUvatH1MJL3ODknqdOxZIT9aEUuZ56B3Ot02/8vWBumx/l0DwnG9NLWcvyA5xBrlBcYaOANyOo5VkmBvkW8AC1dQEFtszNaxs2bRZRGLSginkoPX1WD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38350700014)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lxyQp7K0MPJF/r2ogh+vQbv0OqtK+OFMAkPujZ3I2bQf5zTEu4vzRWfSlyOV?=
 =?us-ascii?Q?7lQkhqhAPZcxRheyF7FPw1uwXdqnPQXHBuSwdHaS6xYFpfLGmlNoScBUFy30?=
 =?us-ascii?Q?pv89exaXPw8wc3PxgZ8J9MKPsjGemD7ETc5bfauqSGuyYWVSPDbW10UzVaVk?=
 =?us-ascii?Q?Zj261ad/UND5KGlAvDa0b47jHWa5cYNDBEZKL3bGuwGtzboxqZZfVRM8sSSQ?=
 =?us-ascii?Q?ozCG4m2kUkfanzZTHvib70ZrMV+llbiZAIq5dfrXEuUwAiZLeo5nWQqyV1U3?=
 =?us-ascii?Q?iqyEzEYNe4erTcOp56ywzvYiVkECYqWQbbN+mOvlMhi4dPq3u/aimQ42gx7o?=
 =?us-ascii?Q?ug+lsZNt5Egtmsnl/XYmt2JSLpmz64+nPr7TXBNDyQlpTn3MFgBHpNE05iTc?=
 =?us-ascii?Q?WjFDWNcM8m/IsirfOdUyYw5EQUe+qlaEME+1IfIM3ebE7o1PBSFZxFgHfPPV?=
 =?us-ascii?Q?ndxOPaMhRws+m3VRbRxHKVrlqOq7G7eyD2z7CEDMS0M8D9VScp832jjNk6wN?=
 =?us-ascii?Q?K6+3onefs6YNHJ8kI3ei7/C4cH37YiEE9hlZ7rz68kIZMe2LPugKvHz1Ijv9?=
 =?us-ascii?Q?sKX7eojIhr56tqRIPvMtgos/gcAsQ8F2F0FAfuNagrlPlwC3ZOfn6yFV7g7z?=
 =?us-ascii?Q?aE8wRIsFswnihfLwe6NgUKcZrDqERP0pBfmZnWNBW29Zz5pW8qRphj3PzTqk?=
 =?us-ascii?Q?yGKGVbJcRw6+Vq2KsnEM71AU0BDJIhLwGmuuHjzmfEHE1fhP1vwyxgmcdCPh?=
 =?us-ascii?Q?wWGA8AmooMibZ4SSmXh65McwJgtRKGZIa5ibINbxs+CcsUflpjV4RREt83fE?=
 =?us-ascii?Q?+3r4erHlBE2gVoiy6ChC5re/tv+RUnNfwZJkPH4AYpWUlP6k+Tl89/q+wbWF?=
 =?us-ascii?Q?7GMfW9G2NspAB5r0cG262gNSmmrglS8xwSjSLUHuALCZ6EOMFk1DJkzt04hx?=
 =?us-ascii?Q?caVpGV+7DnzvONa8RXqqy4Rr3p6K7gWbEBCUYvMCvAiGL7GEFZ0FilHbjxgp?=
 =?us-ascii?Q?D0dcTtDk/MiCyvPWzNyrNOT7sBtPiTV3F0qEF4F5K6BP2d/FhovJjZWQq+J8?=
 =?us-ascii?Q?NhBfi+axoY1ZsF7GHEgQ+ByoHmXeY5ThFRYtGBdX77haifeJ8Q3w5S8Seydj?=
 =?us-ascii?Q?x83JI7wLpXHa7uC3uW3Xod8pTICjiR/fUmwqobFtk0ZK8aJPC4PcjDyxDOY/?=
 =?us-ascii?Q?dyUgIVBZhFWgiF8s7FAZKDf9FfUVJc/eoGXYFTICfzhY//67RcAKlOE54g9j?=
 =?us-ascii?Q?RwnRoFVv/0zBMFDufffpws6NIH/f5kcMlX7ou7ABdi4sCXNU12jIx2rybOqq?=
 =?us-ascii?Q?uMokfKjgKMF3faqdwRD8ph2P/8h9JW1BcKigJvVxgH6bi6LRblxTyYmkxIkk?=
 =?us-ascii?Q?x29ZpfAsvditiT6UCULO9Y+sMcYkBsNInR3FKafSyaDsnzV7OeTge2UgcoMG?=
 =?us-ascii?Q?JT4Pheppi65ZN5I2iQs1qu3umo1AyoGq1s9ohXDE5qSd/I9iwzCqxsRaaUQt?=
 =?us-ascii?Q?ZNcaYOcYTlwNsNi7nI+CeuiI3nVU4U86P4kd8bP2+MUX0or6OkMTfpVQDXw7?=
 =?us-ascii?Q?t9TFUrZbrleAROlii+pMFmxBSNB6bPVQC/XxUpeYZM3Q8TmkNisAFvRmyPdD?=
 =?us-ascii?Q?HMKe3BhUnyPTfcg1XzKNidFvWRWTilGKfq4xVr4ryjpau+NG63NdNQTrrVOe?=
 =?us-ascii?Q?Lw/webmyi7ZOmsEYpiIK7txg9gVHCb9+fncbkidC6tOlCWV9u2aMWZXkmg9S?=
 =?us-ascii?Q?dLc/8s6GVa+tSsSsM1kE5OpBHtJQckg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7caaa3-988f-4019-8fed-08ded087d816
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:58:19.9165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJcvPTwftr1Qot4s2/qko9WsMWIqkEA+IcZTKn3F2BYntriJQUDM2+rZPiItlgW5J0joDZtgBFOufcJ2t2bZv3bQcYf354GO4R5DQMWZwII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7375
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301185-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6666B6B1A62

During QEMU CPR live-update (and VHOST_RESET_OWNER in general) the guest
keeps running while the host drops and later re-attaches vhost backends.
If the guest adds a buffer to the TX virtqueue (guest->host) and kicks
while the backend is temporarily NULL (between vhost_vsock_drop_backends()
and the next vhost_vsock_start()), then the kick is delivered to the
vhost worker, handle_tx_kick() sees a NULL backend and returns, and the
kick signal is consumed.  The buffer is then left in the ring.

Then upon device start vhost_vsock_start() only re-kicks the RX send
worker, never the TX VQ, so the buffer is processed only if the guest
happens to kick again.  But if the guest itself is now waiting for data
from the host, it will never kick TX VQ again, and we end up in a
deadlock.

The issue itself is pre-existing, but it only manifests during a brief
pause caused by VHOST_RESET_OWNER.  Namely, the deadlock is reproduced
during active host->guest socat data transfer under multiple consecutive
CPR live-update's.

To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
queue the TX vq poll so any buffers the guest enqueued while we were paused
get scanned.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 drivers/vhost/vsock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index bec6bcfd885f..81d4f7209719 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -646,6 +646,13 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	 */
 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
 
+	/*
+	 * Some packets might've also been queued in TX VQ.  That is the case
+	 * during the brief device pause caused by VHOST_RESET_OWNER.  Re-scan
+	 * the TX VQ here, mirroring the RX send-worker kick above.
+	 */
+	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
+
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
 
-- 
2.47.1



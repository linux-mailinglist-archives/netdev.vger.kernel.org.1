Return-Path: <netdev+bounces-307514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NdjhOBBWVmp03gAAu9opvQ
	(envelope-from <netdev+bounces-307514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:30:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF41A756738
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:30:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=fCRvQcvh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307514-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307514-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B4CE309C6B5
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A917A4BC02C;
	Tue, 14 Jul 2026 15:17:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023087.outbound.protection.outlook.com [52.101.72.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E449691D;
	Tue, 14 Jul 2026 15:17:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042222; cv=fail; b=OECJy9ONyqo5CBU5vMr0VtbKzCSvCgEPW4ZvgZuMsrr6diXof4jiZZxvgCOxuulqcw5ct+r9VZJs52pxXoXNJunDMCuCxyc+P4f5i5K045uB95zyBogj9Hc2mC3nqfIA74Es28+4Z/ZtAjiw6LFyMyQ7AZELXeDr/ZbEyOLR0tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042222; c=relaxed/simple;
	bh=6rO/7WqPgzlXUMnwdowW4RIM0whx2ltrpQnlzVdiMwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=doeyK38pE1Oy3KyUgnzt165iLKGd1EHwET7oE3O+TWxqukGSarXm8Jkq34wNe9u+yjUDWNsNl7Xa1B15LO6pRs9xhPgCYxbm/c7pQf18WZUt+cGCNRdUUzPtScCWJoj/iDrVn7ZAMKILrMyTfc+XRcF4zPXdABPQV4ISKVywjfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=fCRvQcvh; arc=fail smtp.client-ip=52.101.72.87
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dm0dWH6cXjFWO5KzeuBbU2OlC4JM404jo14MzFHYeSJZ6a/V1U4MJ0YIuRJo3uksv5MrNe4iRleCt+M7e9pa4LntAZE3yTKCsfjnaV2y21yYEcHQWs7gVAZrm1av2vqWG8/C0hSvtBLfBAIMgvufXv/d3cvJsYlRJDJQNbS+mnc1L236esN19kd4+Qnn3CfrCrx7Uwv2wp2x9G4GVezvq2c/nNx2xc+0jMs5tAOPPsJiBfeu/wh7Mg9NKj3/XwxLf78Jq7K0jSR6XxVszbYRnAxLEYpcgdRrUo86V3ARf485CjPh0iuucWNOOw8idwGny75/WtYX1F2Ih+siMj3aTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLgTRBUraKkLVxmcpFv2IykrvQA4L39JGAqUdHj23+k=;
 b=X+dnP6eIgvR30sAtlpdmltPzFinfnou5UIGOC66CpPaUQrCXzMV/NRoDSVCO0sxd5Nn5zlpyFfectk9x910lqRpVSY+Ki/71Ce0JMnErDMk0Un1VSMjzyc9qAS+D793zyjTH4Up96kvKcZMxA9jxDP8vTpIojUHpQ7xtJlmzp4aNqv5F6gO/zdc9VsfBtyVV7r+zUw5l0bAznp+zvmKEYgoSbtCWknLlJirnqfkPhNk39MoPTzNgxKeed1XKU1HhQEdVPwBIh9DHR1f6tCKnh+ACl9SWTiv72aGFLbM3DNUhFrtF24j9Kby6ChLAk0TE3Q/AorGoog2Zh9EwmGw1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLgTRBUraKkLVxmcpFv2IykrvQA4L39JGAqUdHj23+k=;
 b=fCRvQcvhSWrXP1fqCzjpv1dNaCZ+Pc2otDuLI6QMW5f6gnJQL/Lo+h3qfoQLEQOeadSiN3C3Gh11EOZa0SmDb3rDXWZblVKCRTSYYkvf2z/zJA3lzTepxGwIkXj3bApziC1vdAL7rgbEXoJUivfxrB5MM1V6wQj+9ejImaTg+q4a0ceK/ESW745Px+cvhXIA+Gj7D/GpyT+2/xVh7YkT/5/inq0sS8QQMc5hNAlk2CKHc9QpIQTPs96JEnSkP8OtcJ9UKENGuuxhkCIEvXfO8kY/brtXNZ/fu8+/sC630cFI8IL+y0a1U0e7YBh5FVVOe3IDEPGu4SJpGk8POLHH2w==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB7692.eurprd08.prod.outlook.com
 (2603:10a6:10:3a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:16:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 15:16:52 +0000
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
Subject: [PATCH v4 4/5] vhost: synchronize with RCU readers when freeing workers
Date: Tue, 14 Jul 2026 18:16:37 +0300
Message-ID: <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0107.eurprd09.prod.outlook.com
 (2603:10a6:803:78::30) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: b31ab7d4-b3d3-4996-82c3-08dee1baee1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|52116014|7416014|1800799024|5023799004|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PizfyyIVhw6ghDBS1fkLjGv5lpkABLi2ecJjWGeomk5eGD6Ars2NOmLlaK29gOLEeogJENgtqvAgxKHWDL1NQxMHNzFK55XN6n5mq34xGHJDfUMapEwOc203u9GnG5luy/H3l77XdJKhvcsWk4UlLGPVnXoW5yJBjsOmHz6X20ggxJzzsT2fpVDlQjMvhClNL2jz+8GKv9PcjVfKO8e62JTCEpFLKw1j4A8/zmkgjAC/BzmajtCDHaa0B6PDDHurbRGDt8vGrttY+7YsbAA+SsVPUoLqOenAzGyrbksbL+2rpj4iCDswZQTQCZNEMEgMTX/rIagh7HuXwTtWzq4yPFH0q7njoFXkmV2RaswHXZTtqHe01tB8/TGxZyhDWdJBIpHQW4EEhZ4+ZGU8gJAPFfxZ01sJHgRpr9eo7kZF1tV2SmFkv3BxenR48fjdqLbZR0zQr+2Txwd+FCBYMaQi2B5Uh919sRAeturyxwEU00R33NhBB94rlDPMKrilmJr0qBhZvFg/SS3R18s2UlDY7ir9O5wTUWy4lMCFiPvpAiWUzpZImDoiISM/nsjsZ1Cwcp1YNzNSNQRiy0sy2Gj5oUkK41IylIgMus5hHYtp/ko9mWlCuzQ01KYzKSP7QPa3V0jwWpsQxjhG6/DMqy4uNPlZs4dCo6UuZCv6MWl2i9kIHBdTyXGytNul7DB8kHtF7igVFgNEMfuREx+SzrMAE5zKfDlI0o2EYXhP1TUQbcs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(52116014)(7416014)(1800799024)(5023799004)(56012099006)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bC30A8zE2Ghg7DOdtvZqDE/vmY4pRsccMhc9zEEeeuVCP0No/gkylu374ZGl?=
 =?us-ascii?Q?7t/cfALMZFF85I2McvKkg4QkU94AiEEUOKb3YbmrGzrvcleQE0zcUrgnvICr?=
 =?us-ascii?Q?rMl9ceZNOslAjqKwMoYnbOnqLHs8YwSOlxe1buDVkTeHphoplyhrbczZ7w/s?=
 =?us-ascii?Q?zz1fIqCwhLrHzdCUhLJrxXpjbXv+d8Q8ED9s3Hcd6hyfYS/9kPzrhmC9Wb02?=
 =?us-ascii?Q?jgF1mfQGRjBRxGEm9zb99KLvLhMqx+Bew9DpT0FB1nLcwFE6XdCkJ3KKS2q0?=
 =?us-ascii?Q?aULjmzuc3hltKYbYnqpe36Sir+iiUFWWSZbZ+ZpcIYtbubjOG9v1S4UFVaJQ?=
 =?us-ascii?Q?9hdZufv0OYYVHa/36gA2i5fudcUr2zc2oIceliu1DjrYSqe1rIAPrgJ1wJVq?=
 =?us-ascii?Q?kFcCXzOg4+C5Y11JFSypVkE2tFo5R9qlCXE7rZf1PWE33ND+iK2LG19uwB5O?=
 =?us-ascii?Q?AyZytZ5PQHB88JYI9C0cij4wJcnO7AXf4PNigVCuMDII4TGY1KRGLsZE1MQm?=
 =?us-ascii?Q?XeRbw9d9/ZkKzZySakFy0gFl6hO0KyU6QRRJBkrPUFMdcNdjfrwHQf2KhMDj?=
 =?us-ascii?Q?HTOot/sjgYsFxtyidbrUDpuLNLo9/my/f0s1IUiy0IHbmtUKJ+FjzPnw2oty?=
 =?us-ascii?Q?Gi99LxL1X+mMZQ2wgmaG2VNS2PSBkhvjBWPJjRGyxnPC9pCmkSsr9oZOGBz1?=
 =?us-ascii?Q?B/DH43VYzndbZXge80vJxu968Oc6gSlTEkIVZB9kXQl471DKog72dddpqCt1?=
 =?us-ascii?Q?Ht6tFnsZqw77nXXkeBv6o9LKjwl2EPAkYPO5CMtOOTfR0OahVZ4rEJQAP+FI?=
 =?us-ascii?Q?GAT9hHGHQcFaRSTyWZ3CZafxhH1G77AGF4tYg3qbnRSWUS28JKdTRZXNVzqI?=
 =?us-ascii?Q?QLd0IHKn/pD7WGsP0S9g53+fvADKiPakG2Rw5MvIBC4b5nsDPSk1OHc4wUYR?=
 =?us-ascii?Q?NKI8/sHacIKgjKmMFAt2pEMzWLtwltDUJPNmriUG9NLguwiUdD01I2FMHRtZ?=
 =?us-ascii?Q?T1dfyFU8zbSFizVfQQkuDbpdW4V6688DrFmfdBJDRYJjvB8ZjiBWE7o/nEwr?=
 =?us-ascii?Q?jhTMElluIdt3U8I0X6RAklLIywJT0uyZFMqD/0G/Y66dEwDFqsErsKlzR7e7?=
 =?us-ascii?Q?EfElVZfwVUUuBGgbUKdz3ycfLaD6C+gOGOPnm4h0exnSEQK+jDug91WLkWzc?=
 =?us-ascii?Q?lx26WwKDgJrITSMeAEu7CDOPg9Prx+woqCOpDi/c9rK1iEZxMvSJR1iGIUHU?=
 =?us-ascii?Q?tk3r2cnzR+gaWE2DoBeW/McWhRYBGBAjPVrSjF17XCmm+FOYKPLx9R077yOZ?=
 =?us-ascii?Q?ZI6Zrc0U8d8ffS2vgcxqnOdyQoi+6xAlLsHFmVL+Dbld2Trwf82lA3XQBvNK?=
 =?us-ascii?Q?IQ7/Q/9bUdhuSIkWllvVKbkx0vyFJICpSqdyj5yeHmtjFa+XHNFcRAr1GSbQ?=
 =?us-ascii?Q?fRcdNFu6p/LNW+rb2XMOxzYaaeb/hWSNp0rEw8Q1RGECKQMFg1WGJGf5Qdlw?=
 =?us-ascii?Q?qIrm0JMY1tNc5aelKxmFnke4fHXW5Y/1y4OtAlrBRzo+QdtfS//AvMH4ebQH?=
 =?us-ascii?Q?2486CRwlPbtosFnliZmQIGpvp7Vl2Hie0Sle9Gk19FEcGS39++3u9v6wFbaS?=
 =?us-ascii?Q?f5CpmWo032LuTgAxtwFVbvWOl4fBOwzdQvmNbB7rDJX86T9Mn4MTHFzdt4Go?=
 =?us-ascii?Q?WeJRF5h8gYV1sOi7tI8aU2RyvSEhok7F7QbO8cpd41NA025+8683bGewVIWP?=
 =?us-ascii?Q?TE+4L5OT8xoltJRzTEcCCUw4ZsqPJdM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31ab7d4-b3d3-4996-82c3-08dee1baee1b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:16:50.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FLLbHWEKfkbF0yeJHGhnlOK6bW/qhqozQdC/KcKJEVJtcRbCULEIycW+Iu11eq1KX7LEynWG7yU2B+W8y+zcN60lZ3LY7MH5KHKTNls5D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7692
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:from_mime,virtuozzo.com:mid,virtuozzo.com:email,virtuozzo.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF41A756738

vhost_vq_work_queue() only holds the RCU read lock while it dereferences
vq->worker and queues work on it.  vhost_workers_free() however clears
the vq->worker pointers and immediately frees the workers, without
waiting for a grace period.  A caller that fetched the worker right
before the pointer was cleared can therefore still be queueing work on
it while it is freed.  And even when the queueing itself wins the race,
the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
future attempts to queue it are silently skipped.

None of the current callers can actually hit this: net and scsi stop
their virtqueues before the workers are freed, and vsock unhashes the
device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
before the workers go away.  But the upcoming VHOST_RESET_OWNER support
in vhost-vsock keeps the device hashed while its workers are freed, so
the lockless send/cancel paths become able to race with the teardown.

Close this the way vhost_worker_killed() already does: clear the
vq->worker pointers, wait for a grace period, run whatever the last
readers may have queued, and only then free the workers.  The
synchronize_rcu() is skipped if the device has no workers, so cleanup of
devices which never got an owner stays cheap.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 drivers/vhost/vhost.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e16ea..0d1414d40f4e 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
 
 	for (i = 0; i < dev->nvqs; i++)
 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
+
+	/*
+	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
+	 * caller that fetched a worker before we cleared the pointers above
+	 * may still be about to queue work on it.  Wait for those RCU readers
+	 * to finish before freeing the worker, then run whatever they queued
+	 * so nothing is left with VHOST_WORK_QUEUED set.  Mirrors
+	 * vhost_worker_killed().
+	 */
+	if (!xa_empty(&dev->worker_xa)) {
+		synchronize_rcu();
+		xa_for_each(&dev->worker_xa, i, worker)
+			vhost_run_work_list(worker);
+	}
+
 	/*
 	 * Free the default worker we created and cleanup workers userspace
 	 * created but couldn't clean up (it forgot or crashed).
-- 
2.47.1



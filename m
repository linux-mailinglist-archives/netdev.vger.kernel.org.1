Return-Path: <netdev+bounces-307513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wS5xM9JUVmok3gAAu9opvQ
	(envelope-from <netdev+bounces-307513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:25:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E39F756660
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:25:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=pXA39zg1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307513-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307513-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FFC130764A6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF514ADD8C;
	Tue, 14 Jul 2026 15:17:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023087.outbound.protection.outlook.com [52.101.72.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FB4A33F0;
	Tue, 14 Jul 2026 15:16:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042220; cv=fail; b=UDb81GNX1wwMKmTqjlMQVy8ccfQeK/AOpqWsIpBHsiNg+n+DAcFJud1+3cGfdbA7gUCXfGciUkd9muU635AGpogsagH9XL0JofUHqQFjNd51HSnTPNNV0Ntn6syx3YGNw4H3QT78dlMLxDRXESFCofa+O3wdxwIcQ08YXb8ZQRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042220; c=relaxed/simple;
	bh=clVkNMWQu/An3QoFFOUF/P6axkRskmAfUM+Ff5KcnYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rRz+zG/5FoTzRzoSGm2fGDHWFYAkmmFD/bTzILqaf6nSpH8vmsxdDhLI87XYoMo3Xh6np+X8mCLq1zulmn1ZB/iWwoOzIEEMY18p2p9SsiEVoI7l0cupzixm6df14aszHTB4ZMC5LIOt3+DruK74VLVWlnkXe4say9IC7R5qH8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=pXA39zg1; arc=fail smtp.client-ip=52.101.72.87
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1lSKFDngXimOqvkroJZxe1KeymrD+Fje1Bel3jXGPwRVw25ldu7oRrRn00AtcXKP8W+Pe6QG08Qpxjz5dqOrN4izY+/5Nml7fXKm3JXJA+iyVtN+RrEc2J1j0XD4UK/gU4NBWIfCpYJ/CfsTh9f9GMHRQ0EmrgDedICQxxwfzNGZGIPNeCfWhQXLCRlDm7LX5O/97g9RoFKD9VH6nHeJqEqyXtSGB7Y+pyPdwseTH3hr1pxdCh6rhZO9V6QFdEkQBWcwGAa5UbWZDJte6jbIXebtuAsA0kD3t/KRrBx4ZUDoDNQkLyLbXRQuQoNF9hSNh8uRyWYUVfqN5vixAFIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lFori+rJNvuLSDAetygN/oDBgfCbIYaQ+gXkzGPvFw=;
 b=tKdiUGgL4PKlpuLnptaklNYhYJcSNipCJ22c7pkYZrIWmH0Ldzwx6tiUKHihoLgubFw/ZxTUaUULKGdADXqI6t0mhdhN3qTzkCpWaqiZ4cTrZxayPdVp6z+oeyas+RIjOIJluC8jX2pXhsduIpyuddd/XNOrl/XOai9+isfR1bb4QI/Gn5Cg15qaAyypsZYQTye0JPZjiOL+9oa/BdSEX0n7HoeikpUF637v4I9MFAevp9H6QR54w29f6rJ/mUt2ULw7Ixnzj+qBI0frZmAmLMn0ElPbuMP6Pk1fxEJ2dNzcaNT7YQtsOStA9QVc0GGh42qIBMF4tn86gGAeaoHKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lFori+rJNvuLSDAetygN/oDBgfCbIYaQ+gXkzGPvFw=;
 b=pXA39zg16uBSCxNk+dhJdTuW92hJojagDSmRcGgxhgo8xW+r254snCEuknFVW+e8o1IyIASYnlIHzkmW/HsixhI8h4dYkVH5kjAA4sVhXy71dPIDymBVgcZr/b1+KbQZEt8hmQNuJZAdkySWYSpCMeUUgCav9T9vvpCP1Mb3bt6nV75joBhC79S/8zVBVbFAwELVOfS6yjZW04RICps3W6bCku2n6fz2B/LazHsN1XsAsYFObKuir2ZQkmMzU5WYgTymgFaEi3WP3IZucEa2gXy1w2S6U2AwOczNaRsSi1cKeJaX+ciM/EkZvAo+FIPadBwDAJss0zqhrAnRDuw0vA==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB7692.eurprd08.prod.outlook.com
 (2603:10a6:10:3a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:16:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 15:16:50 +0000
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
Subject: [PATCH v4 3/5] vhost/vsock: re-scan TX virtqueue on device start
Date: Tue, 14 Jul 2026 18:16:36 +0300
Message-ID: <20260714151638.143019-4-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d85ba1da-1040-4eef-a7d4-08dee1baedb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|52116014|7416014|1800799024|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y2HwvhZjaJRxV/8wMU+95dl4M3Lz99A/UQGVj9I8esvHrYuvKucXAhVEuivEChL6kKv4vtWjpCp8bHw5pqPGMRFhHTkvEu8j0clqPeuMvrz50YghpeTa7XiyRC9dndDjWfSCkllZNLylRB+ypDR4lnW5CQn5DylSlz7TiQH7soZBVLGzAzcWinOEDs+hKPgcLEsZqXMXGLhHL1JxVzZKrthrQOsGCACsNs+muP4Ml6At/IID/7qjEkZPkvmXBn89KgaInHQegxgWPmix7YKuutvAOrSebaxyDtIxQo/prE/Ub65Dc0UbMyrCAWygcMUoT+msBMHaTepxTuNQ8sNoVfYJye/fqoADy1595tx6u+1LlvLY692TSxm9RS5vWa3Q5pYf0Cb2tllVQpzNiNr1Wx8uPdM0lPxd6Tbg32BtB/oxUMieC5o0/lOQ4an9fL50dHhrlMFJUz7n1tSXQH2lGPJL3iKh3lPs7jsHV5kwzHtAPmiDrwqG9kfosFjsjTAHdeDYU2GNvhzri1TXWRP5NU+G4gZuiCCCZwgGaHwiv3Tw0nx0IVIXii6XtoCB1q+bNcg/dTOZarBzhMLmLHLhn6BumXSxWZcJFAWoCLZGcB4AMCT/jw+OisOYAjtD7B8CILC+nP4eUgWg45srs9u7AC3g0iJY1Tcc/93EmLMT/HcoL8+qYdFaXsJL1mF5Wgru2B1ahll1Uu1PVhu50MwoKVlGlIXVX3BmzzhQ5Nw3BSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(52116014)(7416014)(1800799024)(56012099006)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7lECJwZBlCsPtyAxbzRZL05hkFzRlORwuNimqrY8sxNUepW6TM+295djXnGN?=
 =?us-ascii?Q?lkvsVldHSdIQ1Jm463lWJ8aNOhAQqjxKIOSXfDiuVMvHgXty7WpuUIMpWGG3?=
 =?us-ascii?Q?MrphXwZSModsQua8Wsq6VAl4ZGjWfqhLmYSWC/I5V/P+S8EAkg7JlNsihzFR?=
 =?us-ascii?Q?CIN2PCmFzCIFLssbXKJgpe9MfmwUKy4vop37jQCPZTMbn16tiHn7x+uJSjtH?=
 =?us-ascii?Q?z9sVsBBySUEQdz6BTlLi3bFbX9xvQS1dhVgLEh0AghVz4Vz1UVJiWAkZlhbG?=
 =?us-ascii?Q?aZO9d1GRwo0rZ9E4XSPMRPA0RAJD/3BYZPF2wdTONi3jBRtMDyy2MXWPtizc?=
 =?us-ascii?Q?6A2ti/G2HWz4OBmPyrr0ethHQ/Jwev13QVc4X/23SjRm7oK5BFM4gSfqAfwH?=
 =?us-ascii?Q?E7GSbgVz2Mwol5oX8IDO+JXM2ceqwbGDeVObhEZVzsqtFwgy/PyX1E9u2ePh?=
 =?us-ascii?Q?jEOvciriEGFm7dy0+lxfEq6FNsN04HeB7/Y4cK4FSMb563r6Au0mpnCINoS2?=
 =?us-ascii?Q?2jRvkZ2SvZlm/yo9dM/ES38ZPgy27Vp132A7BVO7JWbSpo+z5yjVM3rMr0BL?=
 =?us-ascii?Q?Vl6QkOmT0YN08gEmpQr2eyodiLyXZqkmq66T81Gnk07qk7JSdz/opUG4YWyh?=
 =?us-ascii?Q?uvonfryfLsV0YVFFFxwT74Y0FaBJJoU6LT5teRCnkKaYFXHYtL+E0LFii3Kv?=
 =?us-ascii?Q?EpoZ4A3kYQpTC2DLIT6081KwhdYUvF2zro4ssDoEGo4Z/uEE9oSBNrwAuEpu?=
 =?us-ascii?Q?tDeUzcgBpanfw4feGsdbQt8FcqBR7c78kZpWeIG9sZMHnvU56GIdkMDvohoC?=
 =?us-ascii?Q?IHA3yhykge8ku5IBQCBXw+5crO/IT/xza61JeyLy6EnNaTAr82c9s9QtDvxf?=
 =?us-ascii?Q?bAKjBwZKhzZM2QH0x2a5LrPrwF6di8z6jW/F2zvsaLvBo6UDEd4zvwxu85Kp?=
 =?us-ascii?Q?hsXw3f2oemf6JTz8+bR5C6bLVFppx/ORodFGwP+rVSJFbGBUfhk4chST58Jj?=
 =?us-ascii?Q?sX0OVYOMNcjAvofFC3uDKGxeL4jvOrVAXcmI2ahlVV1vSwoVjS8iUvK5bhx3?=
 =?us-ascii?Q?ezpEX4UhTkNig8wTe/cuN1LBkJsDUGW3yRJphhs+Fx6XrUXzJ5mJYDilstNv?=
 =?us-ascii?Q?wuNqIjmsa6ieUNE8DB9yCu8EIeCLJDWN9QMTnPYyiR/eb+BzxwVDR+T0yCxM?=
 =?us-ascii?Q?Z7KrOPlN6PL1+Vre5g/tEJ8ia5oaiaQwfK7XdP+8jhR8HVnkmSXAz0jIW68E?=
 =?us-ascii?Q?E59M35Xh5xPu5qn9Owro1ku3UXLFGrbdLw86XJoNTRBiKABNA/spjwJ2E64L?=
 =?us-ascii?Q?yhLmBFOnV25bOHioEDN2ckjlSlOawpRuqoc+dA4tXZhPMcII5q66oKwxZdpv?=
 =?us-ascii?Q?myyZh/lMAYZMbaUXWOJ0tEHSSE+uRGvbNVYLT/DuS5c67UnhyYhmDF59oCP9?=
 =?us-ascii?Q?HOHBlAdOkhgO9L8lKOGYbAJ4DUPvKDcam0GcpllG31VPNmoCeWGf87uZXUgz?=
 =?us-ascii?Q?HNQa/sBQyQRc4jb10j5lprHHyLH/pWcewYca9YZndmH44LxpkAl/gZmug3w1?=
 =?us-ascii?Q?4dgDFlbWKi66wKbamVNoDHYE6jNUL2/KWhESbeBoHAMaUUlxYxRQCXNZNXl7?=
 =?us-ascii?Q?kmMds8be9SD4GRkG2WoFdkmWEIa92d9ZAMH1SfOEnD7XlIPTJKfvnYdX1F/Z?=
 =?us-ascii?Q?CHJsR5YjGj3lQPmjFZRJcL8yrK/w89qy3sawBMfXAZcf+gFb1eEkHXnDZnHr?=
 =?us-ascii?Q?0mDyaSWPWe4wWqz95YxLOov78UnB/MQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85ba1da-1040-4eef-a7d4-08dee1baedb5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:16:50.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVdtE3S3HD3gwKHLrTcY6okOIyrdvL2PBtNiIkAQJZiEzu3oKZNTRfr/cvR0xy729HxIgR2XxrIV7xfKWY9XJ3n5TtL8SH+QfhHbvBv71Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7692
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307513-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:from_mime,virtuozzo.com:mid,virtuozzo.com:email,virtuozzo.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E39F756660

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

The issue itself is pre-existing, but it only manifests during a device
pause caused by VHOST_RESET_OWNER.  Namely, the deadlock is reproduced
during active host->guest socat data transfer under multiple consecutive
CPR live-update's.

To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
queue the TX vq poll so any buffers the guest enqueued while we were paused
get scanned.

The VHOST_RESET_OWNER ioctl itself is implemented in the following
patch, thus this patch is a preparation to support VHOST_RESET_OWNER.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 drivers/vhost/vsock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 27169a09e87e..d5022d21120b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -646,6 +646,13 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	 */
 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
 
+	/* The guest may have added TX buffers while the device was stopped
+	 * (e.g. across VHOST_RESET_OWNER) and their kicks got consumed by
+	 * the NULL-backend window.  Re-scan the TX VQ, mirroring the RX
+	 * send-worker kick above.
+	 */
+	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
+
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
 
-- 
2.47.1



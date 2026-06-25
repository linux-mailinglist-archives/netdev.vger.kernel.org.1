Return-Path: <netdev+bounces-302014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RuPTIz1PPWpX1AgAu9opvQ
	(envelope-from <netdev+bounces-302014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:54:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03B66C730E
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:54:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=euxRyDjw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302014-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302014-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBE1E305129F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D86309EE2;
	Thu, 25 Jun 2026 15:54:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021117.outbound.protection.outlook.com [52.101.65.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34F2E6116;
	Thu, 25 Jun 2026 15:54:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402875; cv=fail; b=SOCpcSLpx6vz0ceNNTeYTW0DJLH3ZWvhUOxQ6+4CFQscbrnuADmXxBl90YIFfMZNatx/qB+n5XmjWI2uKnffBh90k2cTNTCe6CJl/PxkDTTpYGOaeJUsbBUewl1cf0yURHdO4DY6T1L2DtzbZksRAEIBSsLtuJxCUifzRfsd21I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402875; c=relaxed/simple;
	bh=QUUo5LdoJC3/+9LejyhzEuy9Db4qM7GyIsMW4+lSXX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRwyPQ5BpoJpYKZDK3do/cHpPXAo/0HBoN4uLTddsK00ncXrI5l6yu0jqY+9gTq0N0ZGO+qcEpUG6SqLzJerypo++9FTXZe1/PH0sFqKo9V5Azjs5XyE9Cp95r4s/QIv4A7Gd+r79ZWCSiSclawnBvhl708fp4p6UYDW6FPObd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=euxRyDjw; arc=fail smtp.client-ip=52.101.65.117
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqZVvoKYyhatJPgj380Atst3zoL5ptJynjcRYfUuPtZ+bnGOTO9oH95hUIptg7r1VdiiISFoG6vjFUv5j0ZZvVh8U6SCkkuEWyurNbFcfCf7xBUytsnxKoHhXqwg/rsZwzAGfmxlvU9kZKxUzcvMrE2pgCgn8vK/3lJCiE4HpFgiTeubJ+UW+Zsi6uf48ursPdH0bB4pjDcPiNsQSlrQuriRCN19y8WZvBm6KNC9e5+sTTQRE6Zm8r4yI7fleqsyG43SpAAZeMVW3bOI3SmMVFMB4wLSMlTsjkTLx0LRzGfqvlhyyrIUgMCNUr8m4+EUOdcv1UYXQxf82+dfo8oBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+vb3H7ga1/zO8JIhDlu/cn9DNQ0Sk/VBwY/dIrZDik=;
 b=MbCplMJWB9udZRomRP2WTJYD39EanUcXzxloNnCk8rmvPnmB/WoIvHInrsAo2JGhCXtH2VEL8Opg2kmXE/kIgCVNor5z4eDFP3VWK412xkE/3l8FoqretekqUUtw6efdRPSSSgNjshpW8cRM+HcEgZEg0kmVVjB61BDkUztvxAjPYJmXU/0piBdmHmHwW3K1vjwMl4VE87HELLSeMTy2323Hs7ZyxMAniQ+2cjCkwikiyTKOhGqxdipSEcFcCmu8jaJ9cNVKnS2z1Mf6XdorLvHSkF7kNh+V0n+4MwzLTA2YFnwV4BQVWLXnWyZNs5qrjjrH3dVNQuvZ8DEFnQqvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+vb3H7ga1/zO8JIhDlu/cn9DNQ0Sk/VBwY/dIrZDik=;
 b=euxRyDjwSlZSr7krRW/pD44W5PlLaSczvhMPdnxwlRZkV0c3VG+L9e7dD/GF/wGqclx2dUT1P4jZ6nmAucfDpbZAnjwW4bk45UXjrkiMjWqaH88YIu9eLktP+bw0Rj1DfMi66W/KdLYtZMYumt7BAiJ0lgsh9f2zLytGjjhTye7YHriQQrwAgKSECXSrTlJdBgUK6vehS9oOAvrPzryz0YXxoZAG2hm83pPZ4D8PmvgiUoimFxuGqZs638TYDd+iPIOpJPg4B2rgzJv8VNqgx3UgHiKMyna2EClJ3X2wreHmDJf+eq0mXmAYe1UvhA6vKb+C4pkSvJA2vOfCbZKThQ==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8043.eurprd08.prod.outlook.com
 (2603:10a6:10:3e7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Thu, 25 Jun
 2026 15:54:30 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 15:54:30 +0000
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
Subject: [PATCH v3 1/4] vhost/vsock: split out vhost_vsock_drop_backends helper
Date: Thu, 25 Jun 2026 18:54:13 +0300
Message-ID: <20260625155416.480669-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIYP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: f7495631-bdc1-4bfb-e75b-08ded2d20b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	tASAo1IKMzSMQ3En7PbOU1kdMCj2YJpL5qxeodK3gQMDV7CW2tdbCNNSPzDcBtuBvwhpNSjx59qOKuObDEw8Rk2JxYArNJSeEZdUgyhlBJ1ikLsmRook5skKleyxpaw0wCjKQfFsTdpWjOPTbhseLRIqPsksCpSOL3EjZGexAUk3cPQUEVpzcu+2YJoSqUw93W1etUG2npJ2B8oKOVF7cnohkuhOuw/bYnqjZ8Yuw/K1wfV+KQAbJaL6ETBsPY4dinrwscMIspB7SvwNopB+MUsrbYCvM2K5ucUlfYAvUy/YBK7deHZLm11cMq7ai7lQfT+f/TQ89XV2uCnWETpCsEhR7iCFU6XtB5TbIbFVGTzGAtSx3OcZWtPalPwf8rE0OS5m1Ro0PxCFh5AmprPRR+5PPy7vNF/GI5ra4jhYLOdk1BPdQAJyJ+U9x4bUTiN5OQshyYkAxrDgV8tCLH/tRMNzgBS1cu5t8cJZLsN2ItvCoG2DPR4VGqAm7TC8g3/kYSTLudTP9+3hdkRGJsTIrMYRwRPKmf+167vOd8UwwvwFiKSPYR7ONx7V3hoWAS2yY+1lbRtHGZeL1P3D1YiCdg4lKs4Vtxqj8CJ7dhyUI/RG5bZ4vcKZy0D4DRX3eS7AQJA6RByv0yGmC7LhdMVLGN5T+AksuHPhxIMCdTbbuKumlFrFyJ04CF1aAaAdvCO7hGk2fYCWbpri0T3E41K4A0iU4AqXBF8weq0JduZi46A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(18002099003)(22082099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5EoOmT8wr0smkm8jNr7m8xJMbqca9d3l8fbHIDpNzRMYeRFJaEXJNPS2qHse?=
 =?us-ascii?Q?JKXyww6C95lrqq87AiwFYiAXgwUYAE3uIcUIde22hVBCzafhFpe1yjBa9c5S?=
 =?us-ascii?Q?58D4bVmsngdjmkGQdbxGgxzXGozt2j7XtA4NsmektPRwjLUuW0F1vq/+Ynl5?=
 =?us-ascii?Q?5oE1cRwgn8xB4KvDlj2645HZVibtGhvsxQ0ht9aj+E4twUEyV+uIi9Rm1KOi?=
 =?us-ascii?Q?Rl+AQLi7Qqkts02Z2wT4Ic9aNiVXJzVCcwCE2GypgHEgqtvE4UXWbWOqqFcH?=
 =?us-ascii?Q?yKvzE+la6856604crwXil5taVdH3ORR0o93Ins+vQ6F3HuME7YUP7Zp515jq?=
 =?us-ascii?Q?zHsqwgBi6tNj8ajZXEX5NYHcq6oBNgE0zUwULGhC+7MlScIYZF5iIeZ4q5PY?=
 =?us-ascii?Q?1FRP0y55J0NY+BrdB2VkH1x+4xd6Nh+/lILv50jbb8uSOqsw15YXlVVaij4w?=
 =?us-ascii?Q?ItKIvaiHP2xvJsDbO91TMmBuNK0LdHu/wrbuWOdc+OOAN9Ut7zW0U/4ehb4z?=
 =?us-ascii?Q?uWHGBL0zBF5P5fN9UCQY6PyKQf+Mx7r51sriF+WBYYqPLZ+96ocuEzh7pQom?=
 =?us-ascii?Q?dNUVI3XUCVjJ54fdyPFJCSsiojbN57yKTu6Rur0HChRXoy/ah8+hAfcghKN1?=
 =?us-ascii?Q?0ieV6QDc0Yv7aXCeYc/g9dk4hyUxOZ0a4PXRAgoIRI2YuIMYlEvSHJ0FsNeQ?=
 =?us-ascii?Q?m6o+D+13578nvARo4X502jiusDibRV9uEPIGNSvcWqFAdUASHBMVm+r3/4LJ?=
 =?us-ascii?Q?sJjKTaw7b8aEadTvZmU32fmXxoJtTQBaP4m+4nzl/cgbioLXXPzJZteuILuq?=
 =?us-ascii?Q?MEw6MY4b3q7bPyy/Md6EaYVknAhfhKlc2KPe6nABDHoRG6HZE44ldoBXDqMM?=
 =?us-ascii?Q?m9UZ/Tnl80bvbljwokcicT3h5HaYX7AKR9Vie+Lc2gn+I3v+r4C1pfEy3SET?=
 =?us-ascii?Q?U0tm9f0ODzYcYuhGHwHRKdGrOJoF2iPpxq6FKj9GMNl/3uxO9D/YCU3J+yiH?=
 =?us-ascii?Q?1DwaYkmzt5Bm6gkt/EtxzN0s784+DalTcDxSTSVvA0jRMBQVsM2Rj/hlHlFi?=
 =?us-ascii?Q?N4wSAIEKummmuqDMQcXdWMzYtIiQLOdnA0Ae7n33PMKCJH+5ZA42KL2z2An3?=
 =?us-ascii?Q?c+n5RLOZrCfjKFq3Hu0FJJz7gtAcaj5yhFPOUM+nsXghoCw2CadzgD87z3vy?=
 =?us-ascii?Q?15ZEoaQHiENA6gIbTLs1MFXUsHfPa8u3C6U1eXJ//3DRY/vwZWPkL6OJ2Orz?=
 =?us-ascii?Q?BDu9OaHo5Gb12cIi6wNRmESCAnoUt1jdKrBVTuycfmAuwh9WYgkHJ3ywi7DS?=
 =?us-ascii?Q?cL5VWIr4fgnhN4FQs284jm0kM7BawSP5PjCp7lpbX0N/HZD5fBOUqVYdU3ub?=
 =?us-ascii?Q?DAELcMzyME3AyIh/Mxs3BQZLgng41oUeIcUTEHzi3BudGkqo5N3e5OwZ5Qnh?=
 =?us-ascii?Q?Hzdeivc1AuimNa2hPzkHNdfJvKdn3Yg/PWgGkIxSw23kzPPJPsZ5IJIVrVZJ?=
 =?us-ascii?Q?g7MBXe1CctwKxAqEmCa3Tj01oWkqvJDiOW7zJRLm0Xzu7qTtua3Tj8iiatm9?=
 =?us-ascii?Q?700PPozDkLDzwmSQnZsr8RZyu3fFDfqFs7niJ6/KdydmF1j9GQx2H07u4mFs?=
 =?us-ascii?Q?SVVNCOBeW9OUl+yo8HZOiBGMh74+oX/KK0RmC0YJBrtOY3o7V7CGgqitK1tU?=
 =?us-ascii?Q?rfMMpBKI6WZg8IlNrTFU6GJvJ9y70hPRb5luNLJeAYmhNCZbPPJQlXeSkHne?=
 =?us-ascii?Q?9OkRbhhPP2IMy2JFoTayVPibGX1hs/o=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7495631-bdc1-4bfb-e75b-08ded2d20b05
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:54:30.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDjNne9Z6ieD02V4G1kEB047bI2TWX4KdP1e419GsOj9aVRuhyFtQLh0195bX8v3IEUP/CkrX/v0RPHX8HO6WxGqv1ZVUYNMqKJlraqv4RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302014-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F03B66C730E

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Split the actual backend dropping part from vhost_vsock_stop.  We're
going to need it for the VHOST_RESET_OWNER implementation in the
following patch, when vsock->dev.mutex is already taken and owner is
checked.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..b12221ce6faf 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -664,9 +664,24 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	return ret;
 }
 
-static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
+static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
 {
+	struct vhost_virtqueue *vq;
 	size_t i;
+
+	lockdep_assert_held(&vsock->dev.mutex);
+
+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
+		vq = &vsock->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vhost_vq_set_backend(vq, NULL);
+		mutex_unlock(&vq->mutex);
+	}
+}
+
+static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
+{
 	int ret = 0;
 
 	mutex_lock(&vsock->dev.mutex);
@@ -677,14 +692,7 @@ static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
 			goto err;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
-		struct vhost_virtqueue *vq = &vsock->vqs[i];
-
-		mutex_lock(&vq->mutex);
-		vhost_vq_set_backend(vq, NULL);
-		mutex_unlock(&vq->mutex);
-	}
-
+	vhost_vsock_drop_backends(vsock);
 err:
 	mutex_unlock(&vsock->dev.mutex);
 	return ret;
-- 
2.47.1



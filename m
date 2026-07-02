Return-Path: <netdev+bounces-303929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bt1YOrjXRWruFwsAu9opvQ
	(envelope-from <netdev+bounces-303929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:15:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BAF6F32D4
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:15:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="aToge2/7";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303929-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303929-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 744E2303EC14
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B932312831;
	Thu,  2 Jul 2026 03:14:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72830F534;
	Thu,  2 Jul 2026 03:14:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962059; cv=none; b=LbO0RpSUl1gAoPHnhfv6gXS1lVBv7M8w8uxNEw08VczN50HQe5iEq0AoQJgpJMx906VBSzUGFSnScF4Wk5G7rRX2DunF1q4FqVOiQlV7mBbvy/J1ZtdBBDXE5DgAS2HGZcF+YAoYikYk00/r46Gl7v7JRRo9mN6jpynQtt58+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962059; c=relaxed/simple;
	bh=JednrzXnDxkafOhtty2lkU/oY2wK64ws0iG8VhUIDOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulUCE5F0qTJ4vR50Zu17o4zj4KnBj7Go/e84yWanWPm5C39LPR9NzRt4Vpia5Dz5Qdi6TW0D5D5PUo+0fkALGJ2IpW1aIkHvYN0jh3+9u0v9GSdes+BNTWIFwVKRyMW/pb5bx/Nr6WsGyDVnUfIYFLirWx+YlUs3oHLbtzFnjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aToge2/7; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621Mhma601497;
	Wed, 1 Jul 2026 20:14:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=7
	AvdgVr3QRDIWeldWDM0dtGdNKHEk1MnEyC3CdIAFNM=; b=aToge2/7hMwrOj/kP
	LSN8U1k6juKZUvijgjUSLwP2RdkP79hV2r6YbCxY8xgz34oyfzsASHMg6w1Avo9f
	MKaALYCpFUvuZnjxfnrbnGECKdvtJEWAX94n4s5UdOU1l9NrXnXeU5e7j+NhhLLb
	ETNKVQGUsJvaLj/vbYTQ0zCMSdT6DA5FPFbvPzAwqJE/edXHvSs8ySI73JtS5wnM
	pKepM85m68vHx0KVmLJ28amhefvHLRxsZ/IykGvX0on8zZY10sR7JImymSQCKC1W
	b07JwOydWeyVYIQWj11mTV7x/9xFc0JLA4Uu6BhrE0KeLRBqywmMhDLYrU8e6fhO
	soP6w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f50g3kjq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 20:14:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 20:14:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 20:14:09 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id ED9C53F708A;
	Wed,  1 Jul 2026 20:14:05 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <stephen@networkplumber.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <rkannoth@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>
Subject: [PATCH iproute2-next v4 1/2] devlink: use DEVLINK_VAR_ATTR_TYPE_* in param show/set
Date: Thu, 2 Jul 2026 08:43:58 +0530
Message-ID: <20260702031359.2392868-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702031359.2392868-1-rkannoth@marvell.com>
References: <20260702031359.2392868-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Gf4nWwXL c=1 sm=1 tr=0 ts=6a45d782 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=GRCvF58QQ8dbGe4S3LoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyOSBTYWx0ZWRfX4D6uCjLKaKbR
 lnGy9mO3BehsWBKgXn73lq1oIATKjOcS17mKa11LfPTU/mLaMVZ0MjFBeAc6hERp0iiRDTAdVPi
 2TTx0bRJfE/xb2h7iQ2jccEAO57Qz7dQVXqN+0aextbKWmdvpAm/rGpO5Z6JD4JVrOBGxWLzvhq
 POxQ+p2x0KidEzGpVH/JLKv7Uja7GdExB7FFpB0uptlTOIJ7GAszT6bcSWfFXlKwgl1GSlyPBLg
 ttm4w3I64SfL+gVjMpNe5XpXNVWpwcck0UCbYgXCvod4x4/l9BPn0GvbcseozebGXVta0SYMFYh
 Mep5XvYuO97xxV9pPVrt3ZjBAXr/6yUz+fnTm/KevjRsVq2EE1Kece63L80CEN0GgKs5lnTKYxy
 HKdzOiig/ZsrgdAp667wl4qtC0c78eXFdAu+nig1yrAZ84Fy26mL2lrFfb/lxrZBSNb+rqDgPBf
 Tqwoc3sneH8rR1EOalA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyOSBTYWx0ZWRfX3NKuBH19AiiJ
 aElEidJRfEqoi4GhXehmpECAUIuU4bl9RvL8W28zu8GYca5E7A7S3YeCdYTlgWFvPCcI8JpFCpe
 499Wxy7bpeBIa8m2JG8Y5x3dw/k7fug=
X-Proofpoint-GUID: XFcRslLvGSaWkW5cZO4DpgmJOepqd1Cu
X-Proofpoint-ORIG-GUID: XFcRslLvGSaWkW5cZO4DpgmJOepqd1Cu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303929-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:dsahern@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:rkannoth@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64BAF6F32D4

Replace MNL_TYPE_* constants with DEVLINK_VAR_ATTR_TYPE_* when
handling DEVLINK_ATTR_PARAM_TYPE in param value display and set
paths. The kernel uAPI now exposes these values directly via
devlink_var_attr_type.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 devlink/devlink.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 434a91fe..803ea5d7 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3526,7 +3526,7 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 	print_string(PRINT_FP, NULL, " %s ", label);
 
 	switch (nla_type) {
-	case MNL_TYPE_U8:
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3541,7 +3541,7 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				   mnl_attr_get_u8(val_attr));
 		}
 		break;
-	case MNL_TYPE_U16:
+	case DEVLINK_VAR_ATTR_TYPE_U16:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3556,7 +3556,7 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				   mnl_attr_get_u16(val_attr));
 		}
 		break;
-	case MNL_TYPE_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3571,11 +3571,11 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				   mnl_attr_get_u32(val_attr));
 		}
 		break;
-	case MNL_TYPE_STRING:
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
 		print_string(PRINT_ANY, label, "%s",
 			     mnl_attr_get_str(val_attr));
 		break;
-	case MNL_TYPE_FLAG:
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		if (flag_as_u8)
 			print_bool(PRINT_ANY, label, "%s",
 				   mnl_attr_get_u8(val_attr));
@@ -3753,22 +3753,22 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 			ctx->cmode_found = true;
 			val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
 			switch (nla_type) {
-			case MNL_TYPE_U8:
+			case DEVLINK_VAR_ATTR_TYPE_U8:
 				ctx->value.vu8 = mnl_attr_get_u8(val_attr);
 				break;
-			case MNL_TYPE_U16:
+			case DEVLINK_VAR_ATTR_TYPE_U16:
 				ctx->value.vu16 = mnl_attr_get_u16(val_attr);
 				break;
-			case MNL_TYPE_U32:
+			case DEVLINK_VAR_ATTR_TYPE_U32:
 				ctx->value.vu32 = mnl_attr_get_u32(val_attr);
 				break;
-			case MNL_TYPE_U64:
+			case DEVLINK_VAR_ATTR_TYPE_U64:
 				ctx->value.vu64 = mnl_attr_get_u64(val_attr);
 				break;
-			case MNL_TYPE_STRING:
+			case DEVLINK_VAR_ATTR_TYPE_STRING:
 				ctx->value.vstr = mnl_attr_get_str(val_attr);
 				break;
-			case MNL_TYPE_FLAG:
+			case DEVLINK_VAR_ATTR_TYPE_FLAG:
 				ctx->value.vbool = val_attr ? true : false;
 				break;
 			}
@@ -3841,7 +3841,7 @@ static int cmd_dev_param_set(struct dl *dl)
 
 	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.nla_type);
 	switch (ctx.nla_type) {
-	case MNL_TYPE_U8:
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3858,7 +3858,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
 		break;
-	case MNL_TYPE_U16:
+	case DEVLINK_VAR_ATTR_TYPE_U16:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3875,7 +3875,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
 		break;
-	case MNL_TYPE_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3892,7 +3892,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
-	case MNL_TYPE_U64:
+	case DEVLINK_VAR_ATTR_TYPE_U64:
 		if (conv_exists)
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3907,7 +3907,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u64);
 		break;
-	case MNL_TYPE_FLAG:
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		err = str_to_bool(dl->opts.param_value, &val_bool);
 		if (err)
 			goto err_param_value_parse;
@@ -3917,7 +3917,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
 		break;
-	case MNL_TYPE_STRING:
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				  dl->opts.param_value);
 		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
-- 
2.43.0



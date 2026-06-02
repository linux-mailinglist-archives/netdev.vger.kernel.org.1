Return-Path: <netdev+bounces-294034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEc6KJhyHmoKjQkAu9opvQ
	(envelope-from <netdev+bounces-294034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:05:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCA2628D4C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99F4A301603B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722939989D;
	Tue,  2 Jun 2026 06:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="S9e/BuLg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059543A75B8;
	Tue,  2 Jun 2026 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380284; cv=none; b=kqa1Q0zam0VG2khSYJtdn++tiS2bKymrQCPUF97qyW+g6DN+2Dw3CVZYEVLnl8SMu2K8NiPqt4UJvKvkaZpj9roqZNabv7gi2CRd0809u+QCNKUHNTQs3rvt2kXRd+IfGxcQzvxomx1oJQ7dReZIcpJMLhj0uZ0jUnRC8UTXeyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380284; c=relaxed/simple;
	bh=tH3gpipaaf6zuzf8TbSjpYAS5YH8WLfKDKVYxfRj0us=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTYqS0ER10iEndPxI2bgA+X39qYZLwiOgwqpiAoFmkeW0gd1o/D+dFkz/1ssDR1nU/qOPqgKyi+ebglcvN5BUya8uWuowRalsibLkawKWoy1yitdf8MKvwYbBr2Jp7rk3B+J6hreATFuDEWFSsBm+A/qZtCi276qXawqaP+KeuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=S9e/BuLg; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651KS6TE1231225;
	Mon, 1 Jun 2026 23:04:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	kDUHU6kRBibHWT4gD5lvpI1GvEbstr+RjZ4RIUDcvY=; b=S9e/BuLg4oUDUZLF/
	cjv8GGzX3xoO4rsHa/vAl43rB57TYVcqc3ycvj8MnqHXU9YV3cABP23iOhfU7ERQ
	B/zENVt3JfQ+/SVsa255qo9prH8exO524GDYzDnc8zwTlwEbAeSR8JfJTA8UlyZW
	x0mKS7JOvnNM7FHy+tYVPNx9yEiFFD6PM/JnqvtDjcUFUXoyO4DGP4KbroZxWcBc
	DQwB6xjog+CBpasLW9zhvLwLfl3dDzZkATQ7dRyKXFbfo77nT5fYTS8eIt77EzPJ
	1m7A1PI8wrZrVxJWMU2iBND69wy/Z9U2E1jgKE9h7E8FxWn72e6LJaHch0NGIBld
	1tj8w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3b7a7h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 23:04:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 23:04:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 23:04:33 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B6F0A3F707F;
	Mon,  1 Jun 2026 23:04:29 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v18 net-next 2/8] devlink: heap-allocate param fill buffers in devlink_nl_param_fill
Date: Tue, 2 Jun 2026 11:33:53 +0530
Message-ID: <20260602060359.1894952-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602060359.1894952-1-rkannoth@marvell.com>
References: <20260602060359.1894952-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1NCBTYWx0ZWRfX0T1KqJLnYxPp
 dMZxopE9CBtSMF6/TfB0IUvCnY6X5FzHvaxCqzq3+Lrn/fE/486Fz2Ox0Mx6H997Q/iGLoAM+GM
 yrC1fHGbJepgIxJmCBdvImSRZwrV1QT4qGP6A5pwVHPIefd8VPOQ6vx01OMNmLqgAiTW1rsH1d4
 riV9cYd9t5ZOFYzh4hgsuEk//JwKEu8SPcLGi31IXpXn4mlf6hlcVHayDLx/z7xL/o03kCrtfPE
 XQ8Rb3EWy+q41YPo2KixrUF2QlBP5Q1gJQgIDiQxrrCzb/PeNcie2WEyk9/L0Os47d7WrltB7c/
 skyLOFZ6Y3AnmFGwgv+rnGWFeoFz4hsWjl+8n5Ra018I4ZLAi7idsQScOeG4jqVCHwFcOWEmvca
 Y601E/242+UYCQyqYieA76+/A3BRSADQax279dF2b7AfgyQsaYKxe59DdRGnZRcFxv1kCnz6Jd7
 72OvilpVIyL+6O1BC6A==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1e7272 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=QAS8UgIW8qh4FKEizQ4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: UfIg6WXy9hlWIwpZEI3eMe4uqq9WCF9K
X-Proofpoint-GUID: UfIg6WXy9hlWIwpZEI3eMe4uqq9WCF9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294034-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3BCA2628D4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

devlink_nl_param_fill() kept two per-configuration-mode copies of
union devlink_param_value plus a struct devlink_param_gset_ctx on the
stack while building the Netlink reply. Allocate those with kcalloc()
and kzalloc_obj() instead, and route failures through a single cleanup
path so temporary buffers are always freed.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 net/devlink/param.c | 62 +++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index 1a196d3a843d..bd3881349c60 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -304,56 +304,79 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				 u32 portid, u32 seq, int flags,
 				 struct netlink_ext_ack *extack)
 {
-	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
-	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
 	bool default_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	const struct devlink_param *param = param_item->param;
-	struct devlink_param_gset_ctx ctx;
+	union devlink_param_value *default_value;
+	union devlink_param_value *param_value;
+	struct devlink_param_gset_ctx *ctx;
 	struct nlattr *param_values_list;
 	struct nlattr *param_attr;
 	void *hdr;
 	int err;
 	int i;
 
+	default_value = kcalloc(DEVLINK_PARAM_CMODE_MAX + 1,
+				sizeof(*default_value), GFP_KERNEL);
+	if (!default_value)
+		return -ENOMEM;
+
+	param_value = kcalloc(DEVLINK_PARAM_CMODE_MAX + 1,
+			      sizeof(*param_value), GFP_KERNEL);
+	if (!param_value) {
+		kfree(default_value);
+		return -ENOMEM;
+	}
+
+	ctx = kzalloc_obj(*ctx);
+	if (!ctx) {
+		kfree(param_value);
+		kfree(default_value);
+		return -ENOMEM;
+	}
+
 	/* Get value from driver part to driverinit configuration mode */
 	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
 		if (!devlink_param_cmode_is_supported(param, i))
 			continue;
 		if (i == DEVLINK_PARAM_CMODE_DRIVERINIT) {
-			if (param_item->driverinit_value_new_valid)
+			if (param_item->driverinit_value_new_valid) {
 				param_value[i] = param_item->driverinit_value_new;
-			else if (param_item->driverinit_value_valid)
+			} else if (param_item->driverinit_value_valid) {
 				param_value[i] = param_item->driverinit_value;
-			else
-				return -EOPNOTSUPP;
+			} else {
+				err = -EOPNOTSUPP;
+				goto get_put_fail;
+			}
 
 			if (param_item->driverinit_value_valid) {
 				default_value[i] = param_item->driverinit_default;
 				default_value_set[i] = true;
 			}
 		} else {
-			ctx.cmode = i;
-			err = devlink_param_get(devlink, param, &ctx, extack);
+			ctx->cmode = i;
+			err = devlink_param_get(devlink, param, ctx, extack);
 			if (err)
-				return err;
-			param_value[i] = ctx.val;
+				goto get_put_fail;
 
-			err = devlink_param_get_default(devlink, param, &ctx,
+			param_value[i] = ctx->val;
+
+			err = devlink_param_get_default(devlink, param, ctx,
 							extack);
 			if (!err) {
-				default_value[i] = ctx.val;
+				default_value[i] = ctx->val;
 				default_value_set[i] = true;
 			} else if (err != -EOPNOTSUPP) {
-				return err;
+				goto get_put_fail;
 			}
 		}
 		param_value_set[i] = true;
 	}
 
+	err = -EMSGSIZE;
 	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
 	if (!hdr)
-		return -EMSGSIZE;
+		goto get_put_fail;
 
 	if (devlink_nl_put_handle(msg, devlink))
 		goto genlmsg_cancel;
@@ -393,6 +416,9 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	nla_nest_end(msg, param_values_list);
 	nla_nest_end(msg, param_attr);
 	genlmsg_end(msg, hdr);
+	kfree(default_value);
+	kfree(param_value);
+	kfree(ctx);
 	return 0;
 
 values_list_nest_cancel:
@@ -401,7 +427,11 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	nla_nest_cancel(msg, param_attr);
 genlmsg_cancel:
 	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
+get_put_fail:
+	kfree(default_value);
+	kfree(param_value);
+	kfree(ctx);
+	return err;
 }
 
 static void devlink_param_notify(struct devlink *devlink,
-- 
2.43.0



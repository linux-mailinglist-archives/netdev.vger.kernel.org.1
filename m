Return-Path: <netdev+bounces-265364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCpAN401rmkuAgIAu9opvQ
	(envelope-from <netdev+bounces-265364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:50:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D45233624
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80EE930579DA
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 02:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299D126E709;
	Mon,  9 Mar 2026 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="a8cphnkC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916853368B2;
	Mon,  9 Mar 2026 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773024425; cv=none; b=nIFwnlDl57MqaBNOqgSCozTy+rICYlArqLXbhNlyIV5X9IdNg3g+8rkG3nv6uaHB+lvnfrjfLNllEehj5bHRMbzsBhqed8ibot/mB6xKcCbpkoqK86jmG1J/nGOCWHpHXQeGEBmL8E6y3OSJw8usqohrg2/cAf+8K2Kl0ONWxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773024425; c=relaxed/simple;
	bh=Ffp+wtWi5+OCKbJ1fuXyo42JIu61X8jT6ao6c2/J6uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IP1y3AdyUSuxE8IL5rl066dEYuQ5bfnt1FI4FhQ6tZnZ9xCGJXX8eXsaMznOkKYgk0oFmTWGF3kE9/1KPKzLGQMqcs3TKiE6jNkqA8X5GUSePjI3IVyNsBgGrYfIlRb6xjSh5my3yNqWi7lN80eEiWry8fstqO4Q5xLjv0/KwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=a8cphnkC; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628Mm70A1725605;
	Sun, 8 Mar 2026 19:46:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
	ghhLV0ixXAX9QRM5rrNpGoB4V4NHyh2lfCs8120ukI=; b=a8cphnkCb3aLeCk/p
	FqiDpVlUgDQSPLADYJDNlcpRR1GCiS0jMT95A+RmbMGb1pszxyHMo1jIAsQuLrzr
	QIEpzdOYhza0li9BA3tLFichuKLkgm5Jmv7CzvwqN/33P/D2sgjEo/mvedc8lBR7
	VGhccqzSs6wlBBjreDsrLM1oWqqkeSTDQg6oitvnxwcKsZHhWlNootWPRN7N/uPl
	2KIyofvSTu4pg44TJ44v7F2Kz6Ck4yx87S0A6Ma1ptn3Yvrp353RG7OEqXUhydh/
	Gq7FhFdVH5ftGFHgXRCIO+qYXrWWioB0aCJwZAi0qHudlOkY+B4h4xRzuplfITIN
	nS99A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cs5nc92u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Mar 2026 19:46:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 8 Mar 2026 19:46:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 8 Mar 2026 19:46:42 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B383E3F707D;
	Sun,  8 Mar 2026 19:46:37 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v3 net-next 2/5] devlink: Implement devlink param multi attribute nested data values
Date: Mon, 9 Mar 2026 08:16:16 +0530
Message-ID: <20260309024619.898211-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309024619.898211-1-rkannoth@marvell.com>
References: <20260309024619.898211-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: q424x7Y00h3TlNqwkmtluuiG4-1iDIl5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAyNCBTYWx0ZWRfX7S2o1PQm8LP/
 01m/wgg/KyeuVw0ZAAU5E6dp5DHa0R0cwScnhD5aOUgbWvn/euRm4GBnmcf25F8uXkhEZOWoLMF
 /aiOueglX4NpLw6r4bPrPSizBukejBquNbcIFNSt/Xn2H4qoT1Ku/FARqpSduutGKuiEQM8bKqN
 x4dk/5oGX/QfQPRowVY8kwV112q4BBGnYGXsiBtb4C1mui2C1F8zsIQ+VY4E2lbgSnnq17Puwt2
 oi6jyYxtkC1QGuxHSiceHM+TCHrHSyCiFKJsNLuEQ8qReiyqwL7p4BhZPU8ljeszosWwyeytU7p
 /9YUw/+b/yu7FV91RWABg0rZXW9gLHQcn7eXX2QW6AzgSUc5DTVlAzFUu96stAfEiMFMhQMPQ2B
 z3xjRFqMTaLssJj8ViJcCSpkyZSJSNi9heCmKRZ0/YJnc/+dG/XNbxXpFVf7QI6QNyLNLvdQtxw
 mBFJbBywCBDs1UZyT0w==
X-Authority-Analysis: v=2.4 cv=V8twEOni c=1 sm=1 tr=0 ts=69ae3493 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=sSlqG2hmm6If27J4_lgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: q424x7Y00h3TlNqwkmtluuiG4-1iDIl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_01,2026-03-06_02,2025-10-01_01
X-Rspamd-Queue-Id: 07D45233624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-265364-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Saeed Mahameed <saeedm@nvidia.com>

Devlink param value attribute is not defined since devlink is handling
the value validating and parsing internally, this allows us to implement
multi attribute values without breaking any policies.

Devlink param multi-attribute values are considered to be dynamically
sized arrays of u32 values, by introducing a new devlink param type
DEVLINK_PARAM_TYPE_U32_ARRAY, driver and user space can set a variable
count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.

Implement get/set parsing and add to the internal value structure passed
to drivers.

This is useful for devices that need to configure a list of values for
a specific configuration.

example:
$ devlink dev param show pci/... name multi-value-param
name multi-value-param type driver-specific
values:
cmode permanent value: 0,1,2,3,4,5,6,7

$ devlink dev param set pci/... name multi-value-param \
		value 4,5,6,7,0,1,2,3 cmode permanent

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 Documentation/netlink/specs/devlink.yaml |  4 ++
 include/net/devlink.h                    |  8 +++
 include/uapi/linux/devlink.h             |  1 +
 net/devlink/netlink_gen.c                |  2 +
 net/devlink/param.c                      | 81 ++++++++++++++++++------
 5 files changed, 78 insertions(+), 18 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..e8a8287c4f19 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -226,6 +226,10 @@ definitions:
         value: 10
       -
         name: binary
+      -
+        name: u32-array
+        value: 129
+
   -
     name: rate-tc-index-max
     type: const
diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..0a496715da99 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -432,6 +432,13 @@ enum devlink_param_type {
 	DEVLINK_PARAM_TYPE_U64 = DEVLINK_VAR_ATTR_TYPE_U64,
 	DEVLINK_PARAM_TYPE_STRING = DEVLINK_VAR_ATTR_TYPE_STRING,
 	DEVLINK_PARAM_TYPE_BOOL = DEVLINK_VAR_ATTR_TYPE_FLAG,
+	DEVLINK_PARAM_TYPE_U32_ARRAY = DEVLINK_VAR_ATTR_TYPE_U32_ARRAY,
+};
+
+#define __DEVLINK_PARAM_MAX_ARRAY_SIZE 32
+struct devlink_param_u32_array {
+	u32 size;
+	u32 val[__DEVLINK_PARAM_MAX_ARRAY_SIZE];
 };
 
 union devlink_param_value {
@@ -441,6 +448,7 @@ union devlink_param_value {
 	u64 vu64;
 	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
 	bool vbool;
+	struct devlink_param_u32_array u32arr;
 };
 
 struct devlink_param_gset_ctx {
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..768d0d88710f 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -404,6 +404,7 @@ enum devlink_var_attr_type {
 	DEVLINK_VAR_ATTR_TYPE_BINARY,
 	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
 	/* Any possible custom types, unrelated to NLA_* values go below */
+	DEVLINK_VAR_ATTR_TYPE_U32_ARRAY,
 };
 
 enum devlink_attr {
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f4c61c2b4f22..e5a80eb467b8 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -32,6 +32,8 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING:
 		fallthrough;
 	case DEVLINK_VAR_ATTR_TYPE_BINARY:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_U32_ARRAY:
 		return 0;
 	}
 	NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");
diff --git a/net/devlink/param.c b/net/devlink/param.c
index cf95268da5b0..519cfa1ce459 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -252,6 +252,14 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
 				return -EMSGSIZE;
 		}
 		break;
+	case DEVLINK_PARAM_TYPE_U32_ARRAY:
+		if (val.u32arr.size > __DEVLINK_PARAM_MAX_ARRAY_SIZE)
+			return -EMSGSIZE;
+
+		for (int i = 0; i < val.u32arr.size; i++)
+			if (nla_put_u32(msg, nla_type, val.u32arr.val[i]))
+				return -EMSGSIZE;
+		break;
 	}
 	return 0;
 }
@@ -304,8 +312,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				 u32 portid, u32 seq, int flags,
 				 struct netlink_ext_ack *extack)
 {
-	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
-	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
+	union devlink_param_value (*default_value)[DEVLINK_PARAM_CMODE_MAX + 1];
+	union devlink_param_value (*param_value)[DEVLINK_PARAM_CMODE_MAX + 1];
 	bool default_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	const struct devlink_param *param = param_item->param;
@@ -316,44 +324,57 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	int err;
 	int i;
 
+	default_value = kmalloc_obj(*default_value);
+	if (!default_value)
+		return -ENOMEM;
+
+	param_value = kmalloc_obj(*param_value);
+	if (!param_value) {
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
-				param_value[i] = param_item->driverinit_value_new;
-			else if (param_item->driverinit_value_valid)
-				param_value[i] = param_item->driverinit_value;
-			else
-				return -EOPNOTSUPP;
+			if (param_item->driverinit_value_new_valid) {
+				(*param_value)[i] = param_item->driverinit_value_new;
+			} else if (param_item->driverinit_value_valid) {
+				(*param_value)[i] = param_item->driverinit_value;
+			} else {
+				err = -EOPNOTSUPP;
+				goto get_put_fail;
+			}
 
 			if (param_item->driverinit_value_valid) {
-				default_value[i] = param_item->driverinit_default;
+				(*default_value)[i] = param_item->driverinit_default;
 				default_value_set[i] = true;
 			}
 		} else {
 			ctx.cmode = i;
 			err = devlink_param_get(devlink, param, &ctx, extack);
 			if (err)
-				return err;
-			param_value[i] = ctx.val;
+				goto get_put_fail;
+			(*param_value)[i] = ctx.val;
 
 			err = devlink_param_get_default(devlink, param, &ctx,
 							extack);
 			if (!err) {
-				default_value[i] = ctx.val;
+				(*default_value)[i] = ctx.val;
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
@@ -383,8 +404,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 		if (!param_value_set[i])
 			continue;
 		err = devlink_nl_param_value_fill_one(msg, param->type,
-						      i, param_value[i],
-						      default_value[i],
+						      i, (*param_value)[i],
+						      (*default_value)[i],
 						      default_value_set[i]);
 		if (err)
 			goto values_list_nest_cancel;
@@ -393,6 +414,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	nla_nest_end(msg, param_values_list);
 	nla_nest_end(msg, param_attr);
 	genlmsg_end(msg, hdr);
+	kfree(default_value);
+	kfree(param_value);
 	return 0;
 
 values_list_nest_cancel:
@@ -401,7 +424,10 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	nla_nest_cancel(msg, param_attr);
 genlmsg_cancel:
 	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
+get_put_fail:
+	kfree(default_value);
+	kfree(param_value);
+	return err;
 }
 
 static void devlink_param_notify(struct devlink *devlink,
@@ -507,7 +533,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
-	int len;
+	int len, cnt, rem;
 
 	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
 
@@ -547,6 +573,25 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 			return -EINVAL;
 		value->vbool = nla_get_flag(param_data);
 		break;
+
+	case DEVLINK_PARAM_TYPE_U32_ARRAY:
+		cnt = 0;
+		nla_for_each_attr_type(param_data,
+				       DEVLINK_ATTR_PARAM_VALUE_DATA,
+				       genlmsg_data(info->genlhdr),
+				       genlmsg_len(info->genlhdr), rem) {
+			if (cnt >= __DEVLINK_PARAM_MAX_ARRAY_SIZE)
+				return -EMSGSIZE;
+
+			if (nla_len(param_data) != sizeof(u32))
+				return -EINVAL;
+
+			value->u32arr.val[cnt] = nla_get_u32(param_data);
+			cnt++;
+		}
+
+		value->u32arr.size = cnt;
+		break;
 	}
 	return 0;
 }
-- 
2.43.0



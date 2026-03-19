Return-Path: <netdev+bounces-269315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBP+MjSQu2lmlgIAu9opvQ
	(envelope-from <netdev+bounces-269315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:57:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1482C6668
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62BC83042D77
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8EB39D6F3;
	Thu, 19 Mar 2026 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="S2Sjy+q0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252239B488;
	Thu, 19 Mar 2026 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899780; cv=none; b=QROrKBapvh3/mzllLlMwg/lrAENZEmKmcnntwxpH3fW4CbwiHCgXxsPv6IvgLVWy6EhhwB9UOneI8IilUWRCnP84ndfXtlrIaWhdvevglSMpsA8TC3cPlk/i8KQuXH8ZsFvcIJRnl+Iv2309PfOKjkVzstKKDsb8ZI+aEO2G9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899780; c=relaxed/simple;
	bh=75ygrKzJT79/gnwS/HPgiliasrZ/Z9XAUNV9AZHXllI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5mcS1UmY0KlA9PFzc4HCfGyOm7ocGanlgbpwAv6cgJAvEm/i9HdPR8o0zzTVhz0U0wjB4lzwenwwv+gJoungEiIbciQkvazvy0Li6aNf7T1t5RFYJGVCnlwykNO8YxMehVAYgmMKwilhFo2/msKcGk6pE8GwmtJNxS9oLBeCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=S2Sjy+q0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J4wGk1080192;
	Wed, 18 Mar 2026 22:55:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
	qckGFHqYBk116EOFpECILZVRjliI55rseXgSon8rgQ=; b=S2Sjy+q0xvg67H4Ko
	eJGZK/k3vdEvksBIayktQsA3vEEUaMmy5vsyBmhS59csTltKTnFQAjXpylBTeFnP
	0DfXO5Cq5exCda0djYWdFZ+ac9jQ6acrz5I8GaSNHUSjag+OAzlHQQSD+RCkWSt7
	Np93tQSl3TiXSsOZPJIs8sdf01ghT9n7yjQMGrw5aFLPmIAL7y/n2AkOBtqQ4vIE
	MjRQe53vktT7DUc5VgWu2nCX3w11zmgwLtePbcK66FJNTDSkdQ3iMJ8YGuKgVdzp
	WDv2dVlJyQ8OmsZxeoQYAEbXzfAZh8LXCxLEv1pWLCPpHEWQVTS5zOlRg399Jr7E
	ryndw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cyxmh1t88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 22:55:52 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Mar 2026 22:55:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 18 Mar 2026 22:55:51 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3C8963F7052;
	Wed, 18 Mar 2026 22:55:45 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v6 net-next 2/5] devlink: Implement devlink param multi attribute nested data values
Date: Thu, 19 Mar 2026 11:25:30 +0530
Message-ID: <20260319055533.1720093-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319055533.1720093-1-rkannoth@marvell.com>
References: <20260319055533.1720093-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EnH_mSp9vmicTkcapxthJRbd3kUWSZsX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0MyBTYWx0ZWRfX9F617rjhvKJ5
 9nr8bP7RGToQhVVxgRTNm3rjTNGvfMKHb56MzxEbPdsSbe90k5I8hi0tUDOxbS5btiYAwbihZnr
 TLDw1FC3HwxYSp4dltKxsQp/YeC2avaCQos7qE4zxDVCdN/z/4oNBnZrLuF+gutj/c8iNAj5740
 IlJEd50c6mxIedhsHPxQDsvhZbH9sXBXHyQyOf1JYMT4ZAUihhswJa3rrsfvnmXkpzk8X/XSfc8
 /tw9s3PxPEvix0sRnmb2vqUn019CSLcbsRM7xHB91hsX7mBF6FlIbP7hdW4EmuUxSjFt/SkVs++
 Xtz00lzwZKtHsEd/DHWEDmWg/llX5iQ3nqQqgKQHbkcLwwu9OTor1v2SI+JbmSzFQPGSAZqa6DN
 9g2OlkR9oWCzDaDFrqNhGdzQBszjPBIomZH5lFUTzapydzKYBtEItenPqvpku2opFEMsY3mdX4H
 7G8JThxXWnze03CeiWA==
X-Authority-Analysis: v=2.4 cv=KvNAGGWN c=1 sm=1 tr=0 ts=69bb8fe8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=fjkij7JY_VKj8B3xdwgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: EnH_mSp9vmicTkcapxthJRbd3kUWSZsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269315-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,marvell.com:dkim,marvell.com:email,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.951];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8D1482C6668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saeed Mahameed <saeedm@nvidia.com>

Devlink param value attribute is not defined since devlink is handling
the value validating and parsing internally, this allows us to implement
multi attribute values without breaking any policies.

Devlink param multi-attribute values are considered to be dynamically
sized arrays of u64 values, by introducing a new devlink param type
DEVLINK_PARAM_TYPE_U64_ARRAY, driver and user space can set a variable
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
 net/devlink/param.c                      | 70 ++++++++++++++++++++----
 5 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index b495d56b9137..b619de4fe08a 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -226,6 +226,10 @@ definitions:
         value: 10
       -
         name: binary
+      -
+        name: u64-array
+        value: 129
+
   -
     name: rate-tc-index-max
     type: const
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 3038af6ec017..3a355fea8189 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -432,6 +432,13 @@ enum devlink_param_type {
 	DEVLINK_PARAM_TYPE_U64 = DEVLINK_VAR_ATTR_TYPE_U64,
 	DEVLINK_PARAM_TYPE_STRING = DEVLINK_VAR_ATTR_TYPE_STRING,
 	DEVLINK_PARAM_TYPE_BOOL = DEVLINK_VAR_ATTR_TYPE_FLAG,
+	DEVLINK_PARAM_TYPE_U64_ARRAY = DEVLINK_VAR_ATTR_TYPE_U64_ARRAY,
+};
+
+#define __DEVLINK_PARAM_MAX_ARRAY_SIZE 32
+struct devlink_param_u64_array {
+	u64 size;
+	u64 val[__DEVLINK_PARAM_MAX_ARRAY_SIZE];
 };
 
 union devlink_param_value {
@@ -441,6 +448,7 @@ union devlink_param_value {
 	u64 vu64;
 	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
 	bool vbool;
+	struct devlink_param_u64_array u64arr;
 };
 
 struct devlink_param_gset_ctx {
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 7de2d8cc862f..5332223dd6d0 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -406,6 +406,7 @@ enum devlink_var_attr_type {
 	DEVLINK_VAR_ATTR_TYPE_BINARY,
 	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
 	/* Any possible custom types, unrelated to NLA_* values go below */
+	DEVLINK_VAR_ATTR_TYPE_U64_ARRAY,
 };
 
 enum devlink_attr {
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index eb35e80e01d1..7aaf462f27ee 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -37,6 +37,8 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING:
 		fallthrough;
 	case DEVLINK_VAR_ATTR_TYPE_BINARY:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
 		return 0;
 	}
 	NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");
diff --git a/net/devlink/param.c b/net/devlink/param.c
index cf95268da5b0..0342697fd231 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -252,6 +252,14 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
 				return -EMSGSIZE;
 		}
 		break;
+	case DEVLINK_PARAM_TYPE_U64_ARRAY:
+		if (val.u64arr.size > __DEVLINK_PARAM_MAX_ARRAY_SIZE)
+			return -EMSGSIZE;
+
+		for (int i = 0; i < val.u64arr.size; i++)
+			if (nla_put_uint(msg, nla_type, val.u64arr.val[i]))
+				return -EMSGSIZE;
+		break;
 	}
 	return 0;
 }
@@ -304,11 +312,11 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				 u32 portid, u32 seq, int flags,
 				 struct netlink_ext_ack *extack)
 {
-	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
-	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
 	bool default_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	const struct devlink_param *param = param_item->param;
+	union devlink_param_value *default_value;
+	union devlink_param_value *param_value;
 	struct devlink_param_gset_ctx ctx;
 	struct nlattr *param_values_list;
 	struct nlattr *param_attr;
@@ -316,17 +324,31 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
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
@@ -336,7 +358,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 			ctx.cmode = i;
 			err = devlink_param_get(devlink, param, &ctx, extack);
 			if (err)
-				return err;
+				goto get_put_fail;
 			param_value[i] = ctx.val;
 
 			err = devlink_param_get_default(devlink, param, &ctx,
@@ -345,15 +367,16 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				default_value[i] = ctx.val;
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
@@ -393,6 +416,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	nla_nest_end(msg, param_values_list);
 	nla_nest_end(msg, param_attr);
 	genlmsg_end(msg, hdr);
+	kfree(default_value);
+	kfree(param_value);
 	return 0;
 
 values_list_nest_cancel:
@@ -401,7 +426,10 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
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
@@ -507,7 +535,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
-	int len;
+	int len, cnt, rem;
 
 	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
 
@@ -547,6 +575,26 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 			return -EINVAL;
 		value->vbool = nla_get_flag(param_data);
 		break;
+
+	case DEVLINK_PARAM_TYPE_U64_ARRAY:
+		cnt = 0;
+		nla_for_each_attr_type(param_data,
+				       DEVLINK_ATTR_PARAM_VALUE_DATA,
+				       genlmsg_data(info->genlhdr),
+				       genlmsg_len(info->genlhdr), rem) {
+			if (cnt >= __DEVLINK_PARAM_MAX_ARRAY_SIZE)
+				return -EMSGSIZE;
+
+			if ((nla_len(param_data) != sizeof(u64)) &&
+			    (nla_len(param_data) != sizeof(u32)))
+				return -EINVAL;
+
+			value->u64arr.val[cnt] = (u64)nla_get_uint(param_data);
+			cnt++;
+		}
+
+		value->u64arr.size = cnt;
+		break;
 	}
 	return 0;
 }
-- 
2.43.0



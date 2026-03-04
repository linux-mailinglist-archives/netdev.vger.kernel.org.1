Return-Path: <netdev+bounces-263583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEf7E9S1p2l0jQAAu9opvQ
	(envelope-from <netdev+bounces-263583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:32:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C041FAB18
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34050304007E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 04:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C933C37F8A6;
	Wed,  4 Mar 2026 04:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="d9smaYML"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5645E37F753;
	Wed,  4 Mar 2026 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772598718; cv=none; b=LeMRly54GTGST2X+oWQs4rko+36tnbSgdY9Wbj1B5eBziqqe94lAdwKt/R9nmYotKdI3U73U/iWcGlcmRFn8btoCPszTe7L9I0Rlu+zQxnOJxErtLCx1oQ5kzjhJbzi3WwOyQXb0iojAiJZWAk1bEaALGfohnOzXZTnz5a9W/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772598718; c=relaxed/simple;
	bh=Ffp+wtWi5+OCKbJ1fuXyo42JIu61X8jT6ao6c2/J6uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9tO7pTF+920279XrLe/uNVgFp4kQoduzsCuYMsF6IqT/6cs+2dOk4ip1VxK7TRp/F6lTf/1NgApmWvuwv9Z6r3Ex5jZ+Ib59cl4jif47IvIG2VHz+8/kFFz75PkMq4IxCbqcAr0jeek6TGNxmI4KAtaGYs+jsCPbARfpSGXZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=d9smaYML; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623KRPei2340495;
	Tue, 3 Mar 2026 20:31:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
	ghhLV0ixXAX9QRM5rrNpGoB4V4NHyh2lfCs8120ukI=; b=d9smaYML+/STk1DHB
	geyrRSq+dcRYOpIqMP+Uep7a5n8j6TmWj02dFD/Ha0IEUn9WP/jU8nleDe6NKETc
	FxsJW48MxjgBMRF8mzJF8hULTlONQfI8oL77R2yUkXzcI/hVjo5wW87wr1G/taPz
	3c6Oy872IbFRC7lr2mhMCQTwLCFeQSUxKURLNSKK8LhSZswYNJ+FQr2ANOWzMDwG
	RA65y4oPL9rGCfhS2QuGgg5sznlsy+XqTg+0phNcjyds7NTv9U7mNlNISaLPu7No
	Xx5bhTIJVC8Rl7GfaoRRkLjn+r1c+Oo2yz5y0JNZr3S5Qje+Qox0McCDQbedWh9b
	wnyuw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cp6pg8ynv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 20:31:42 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Mar 2026 20:31:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 3 Mar 2026 20:31:40 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id AE90E3F706A;
	Tue,  3 Mar 2026 20:31:35 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net-next 2/5] devlink: Implement devlink param multi attribute nested data values
Date: Wed, 4 Mar 2026 10:00:29 +0530
Message-ID: <20260304043032.3661647-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304043032.3661647-1-rkannoth@marvell.com>
References: <20260304043032.3661647-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: D9eKH1JDoz0P8L_sFObJIv4ITbMBO6Gj
X-Proofpoint-ORIG-GUID: D9eKH1JDoz0P8L_sFObJIv4ITbMBO6Gj
X-Authority-Analysis: v=2.4 cv=O8c0fR9W c=1 sm=1 tr=0 ts=69a7b5ae cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=sSlqG2hmm6If27J4_lgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAzNSBTYWx0ZWRfX43ZTgD5dCTZ3
 vTs2ncuL4O9AJ27d6tYAClTgGBi3l1uqUz26iuf39+sPD9v6xYS62DxeSLf69iSQ7ablzgfnwnI
 asXUsy+g+TUQsfCAcEF5OywPpxGwVxICoi01JEnFdgm3snJKpow83Jcbz49EpxX7P+OXyUTLZ00
 qxBXtQV+PKrbWlnntWQYIAdlsHE7KPCnpgTcN6tzQAMZMpp3F8ZaRBIyNzGWxM4VSlsQvMSXb4J
 VCMN0oFcC/MwZT7vqXAyuVfJ/dsAonbq4v6x/2ZF3yYXnDeWkZYmN1FjeHnJyTcncN0WRpyh2AX
 H/UlQ5y8flIW1IZ1cGAhfvpCvFq2f5mntwyXMkalmbXm1Vo2N8P1d9u5xMOMXSIG1IiX+61wt8Z
 0NJM3slgkb9ri/DpvQMBa7OmiHjmA4ZrLjjSh47rvJL2gJ5zEI1fM2NNE7fax4F+9Yu67oPGVeZ
 AP8jKczASlsSeyii+RQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Rspamd-Queue-Id: D8C041FAB18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263583-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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



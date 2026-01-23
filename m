Return-Path: <netdev+bounces-252648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCdLFiwbc2mwsAAAu9opvQ
	(envelope-from <netdev+bounces-252648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:54:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A401B713B3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6984F302DA33
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AADD33290B;
	Fri, 23 Jan 2026 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jbPqBNTX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6333890A;
	Fri, 23 Jan 2026 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151199; cv=none; b=J9hfe5DVUeU0VpZNLde0VaP1XJG5E/gG3GkzlE0/gST0YUUiv6grRlXSaFJfIsbQW8B2C8nN9jQgrSPTN4C0lHG8plG0ivsQtPGKwBiDmnHsdTIIC6tN2DEpLQm3FptQzUTwyH++smb9aCRgDv3KeeHzwi/4Qu7DT0afl+6YaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151199; c=relaxed/simple;
	bh=ZFzmWzjoLThr4+DzN7YmOV0Iu/cb4VMHplNefYT/PQo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BwsMp4m9VmWscg7eABvAJVqJF0nD3C6IEI4XwYRBC9AtRq68iBiF96lCP/NW9M1vAKcKMz3RuvekG6WTUvdiy8EzSdTTa5Bd40hnMM0RTJFJRunre2pBxpMO1HZUtdSEkQXth0ogT07LUtXAjClwUiZ5BDXM1VmLZ10pqC7WaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jbPqBNTX; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MNSVQV3718392;
	Thu, 22 Jan 2026 22:53:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=7EzWX+JfsswAs6Xk/XQa2dq
	cvDBLl72m3sadmR3GyPw=; b=jbPqBNTXFJgZvhsi5ZAFVCuU0AAaVb6yotOBYlC
	NSe+fuqS16HIJY8l1VSjzUQiZR3hS/3Po79hD8GN7x/EWRPsOSTkmr7Ux4eAdgH2
	TjmVdDixTv17Ki6zoAyKblzJWMZEqYiw/Vu0JrbXSsUh/pB+tOv7HNICmgyQIkfu
	cGD6MSaJjjQF9EoSAfm80+NllYDLIKovycVKXpMfYhWeh5f+cr0vbNHkaty6rPk0
	m03PQG0vvMMvu8mkKE5D4Oom4dGiCv5D06JqC7Kxvc7vNdXS1m9+JFyNgTp7JTSq
	/3JiYiNm57uZNL9AJiXWvOt0qIChye59NE5j1S918KBiHPA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4buwkh8pn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 22:53:06 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 Jan 2026 22:53:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 22 Jan 2026 22:53:21 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 11CE85B695F;
	Thu, 22 Jan 2026 22:53:01 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Saeed
 Mahameed" <saeedm@nvidia.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next] devlink: Implement devlink param multi attribute nested data values
Date: Fri, 23 Jan 2026 12:22:57 +0530
Message-ID: <20260123065257.2993735-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F7dat6hN c=1 sm=1 tr=0 ts=69731ad2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=cytzpGnjpnkeWZElj0gA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: DvObko-hmIbQOroWns7dMnfwMfuGc1Eh
X-Proofpoint-ORIG-GUID: DvObko-hmIbQOroWns7dMnfwMfuGc1Eh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1MSBTYWx0ZWRfX3n9yHmQSrFim
 sHX4kecmCAsi85BaoqB53aPePNTl+sDa8xjP6yKwMUQ+vcROeJwI2qJ7K0/oUwfb909lykgr5Vv
 doc6AZTnz9aRYfZkwdGs7Co6ITB9pjQOjySQCKC30ZzQu55XkXAMTyOYw7Ni+bBNrsh7Gh3UKsu
 0WMI7UZyZDiXrX5UoKmnA4G3RQdv1BKu/O2t8MByPI7CDNBcKGmcU4d6qzquoxMELCDNavinNav
 BuCjU3nq+xIOmQB+Pr+UQXzCaHYpQA4yxHPb0rrFFhHW8oAG+8dgk/iNdbY0DoV6VJ2DOthwNno
 ZoKetbAzqI8pw+8dSjR/5pWpQCHV5ZA4G/LOyURcSB0vVzZYoOGTcn78UeaC0W5tnoBvyxpucCj
 xXqsf9CY4PkJVRQxzULeooMSNlbclQ77n2PBiucMFbtQIicuLSrmyBp6qvyYOKGBVxtbC/c3hkh
 hVu0+dGSOTniSsz0Stw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252648-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A401B713B3
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
 Documentation/netlink/specs/devlink.yaml |  4 ++++
 include/net/devlink.h                    |  8 ++++++++
 include/uapi/linux/devlink.h             |  1 +
 net/devlink/netlink_gen.c                |  2 ++
 net/devlink/param.c                      | 18 +++++++++++++++++-
 5 files changed, 32 insertions(+), 1 deletion(-)

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
index e0ea93eded43..2d0ef13b562f 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -252,6 +252,11 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
 				return -EMSGSIZE;
 		}
 		break;
+	case DEVLINK_PARAM_TYPE_U32_ARRAY:
+		for (int i = 0; i < val.u32arr.size; i++)
+			if (nla_put_u32(msg, nla_type, val.u32arr.val[i]))
+				return -EMSGSIZE;
+		break;
 	}
 	return 0;
 }
@@ -507,7 +512,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
-	int len;
+	int len, cnt, rem;
 
 	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
 
@@ -547,6 +552,17 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 			return -EINVAL;
 		value->vbool = nla_get_flag(param_data);
 		break;
+
+	case DEVLINK_PARAM_TYPE_U32_ARRAY:
+		cnt = 0;
+		nla_for_each_attr_type(param_data,
+				       DEVLINK_ATTR_PARAM_VALUE_DATA,
+				       genlmsg_data(info->genlhdr),
+				       genlmsg_len(info->genlhdr), rem)
+			value->u32arr.val[cnt++] = nla_get_u32(param_data);
+
+		value->u32arr.size = cnt;
+		break;
 	}
 	return 0;
 }
-- 
2.43.0



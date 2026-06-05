Return-Path: <netdev+bounces-295652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VYRTGbtwImo/XQEAu9opvQ
	(envelope-from <netdev+bounces-295652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:46:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8084645A12
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:46:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=GjyfbjFh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295652-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295652-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C74307EA29
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F740963F;
	Fri,  5 Jun 2026 06:33:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09737409627;
	Fri,  5 Jun 2026 06:33:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641209; cv=none; b=hHrtX0tYKMaZmt3ShnqCZ0YCa/vavuqkL/Z8dvsL7zxE/wvzQEuxIBbUydchLq75U7wLCXgW2Ow1p7XPQc5uWUcIp+hy/XXCFA3kVxwUv6oYhQJb5kzDOEtRqByy4RzNwGEmp2IBqXeU4jWfmkmmOrkjIBUHpNWe8YxxoaxyvHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641209; c=relaxed/simple;
	bh=GZdS2QUjakgYotPC3ba+HveGsz2JyY7CGy5ir1LoI/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4Bap+mr99ef1JG1QASxnltaeVzF1rgXr/P7C96LwrlJYzIlrA6o29fZl8LTAntJhoSRwpzXw6O9pXjULGYh5s1j8f+J1MysVPWnWUL1ukM4yQ+mKc7QP2xHDqY/NxY6e1zVrH57oREoFVzofg29NqnK7jjRDMs4lPrO/lyttIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GjyfbjFh; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654LPXva3891046;
	Thu, 4 Jun 2026 23:33:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
	UMGw1wARK2aeNfvc9AWyb50o++H2+0dJcA2ALBV1ws=; b=GjyfbjFhtcIypwZAM
	m7tEeK+D4JFWFtF/8/S7oFUHDZ8hoswPFcwXm2IG/Cy7jtHvl9u7YRrd36Nirkur
	SHJ2XW3hfY6KI/Y2GVOqhQEZNSZrohVKUyV7wtfH0qPUMf5J7DpRG2OE6TI1YacV
	BWVzQnFGdZoMrkMSYAxJ6caoUuvyc8GQt2OMwhQtJt6PWMQXYTAEIsMhwcSF8X5Z
	hbkdMByI6U2D4rcG7BhJSieIz8Y9iLSgBfNzbWPDnf7ZvrE14VoaOBEfzjtc572c
	VAHJYq9mVIOKX6n0g2BEt0cL95jsOX5+0CauqFrSFgtANIYPEoDrAgDyjxINYFeV
	gRj8g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ekh8x9b5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 23:33:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 23:33:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Jun 2026 23:33:16 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 422D23F7074;
	Thu,  4 Jun 2026 23:33:11 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Saeed
 Mahameed" <saeedm@nvidia.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v19 net-next 4/9] devlink: Implement devlink param multi attribute nested data values
Date: Fri, 5 Jun 2026 12:02:40 +0530
Message-ID: <20260605063245.3553861-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605063245.3553861-1-rkannoth@marvell.com>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jAUTPjAzjDQqK9dSTlFzER1CTeOClhlY
X-Authority-Analysis: v=2.4 cv=DqNmPm/+ c=1 sm=1 tr=0 ts=6a226dad cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=poRX95JG0-uQvCm-gVcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA2MSBTYWx0ZWRfXxowGPRK0p2gk
 VXfATM2qoLT/sUUnc5vX9Xs9FfFWtyvuyJG6So7JqpqyQ0M9s+DC+eW9wCft4yihNrdOJf8/kIX
 Tp8jtjprbwcbdwneooytk6h+PyXaIedtBKg0doZk72WaBFL4iM7I9ai/ywTwzSm/raSg2udPScY
 Vp9/aYRldwpGt0oNGlG5Wm9j4fw2GEmXGKMIsqFlMq+TTD/WAE0PfSGe8ZDp5YTlIZLeDWXK+Qr
 WShUnle5sLoCFx7Y1+NlAhrVS8O+iGQjchJk9eB20yVeCk7ESBUEyH7l4gU0o39I9TyTFrzI35t
 Nf2W2W7DN2JE4Ao7RpVnrg1slVrc8ECS5X5woAJm+3Rsr98X+VHQW/mE5RWglUhdTvxXEa4qRKu
 47cyPWvrpfY3zNpOM0fo3a5Cg0tAOseskEe2UJGCmFS5YZtoSFiNEfjakqgDU6p/dkWN/l55O5R
 0CDJGXqcaKAK1W3Fdlg==
X-Proofpoint-GUID: jAUTPjAzjDQqK9dSTlFzER1CTeOClhlY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295652-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:saeedm@nvidia.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,vger.kernel.org:from_smtp,marvell.com:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8084645A12

From: Saeed Mahameed <saeedm@nvidia.com>

Devlink param value attribute is not defined since devlink is handling
the value validating and parsing internally, this allows us to implement
multi attribute values without breaking any policies.

Devlink param multi-attribute values are considered to be dynamically
sized arrays of u64 values, by introducing a new devlink param type
DEVLINK_PARAM_TYPE_U64_ARRAY, driver and user space can set a variable
count of u64 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.

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
 Documentation/netlink/specs/devlink.yaml |  4 +++
 include/net/devlink.h                    |  8 ++++++
 include/uapi/linux/devlink.h             |  1 +
 net/devlink/netlink_gen.c                |  2 ++
 net/devlink/param.c                      | 33 +++++++++++++++++++++++-
 5 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 247b147d689f..52ad1e7805d1 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -234,6 +234,10 @@ definitions:
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
index 5f4083dc4345..dd546dbd57cf 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -433,6 +433,13 @@ enum devlink_param_type {
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
@@ -442,6 +449,7 @@ union devlink_param_value {
 	u64 vu64;
 	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
 	bool vbool;
+	struct devlink_param_u64_array u64arr;
 };
 
 struct devlink_param_gset_ctx {
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 0b165eac7619..ca713bcc47b9 100644
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
index 81899786fd98..f52b0c2b19ed 100644
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
index bd3881349c60..3e9d2e5750c2 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -252,6 +252,15 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
 				return -EMSGSIZE;
 		}
 		break;
+	case DEVLINK_PARAM_TYPE_U64_ARRAY:
+		if (val->u64arr.size > __DEVLINK_PARAM_MAX_ARRAY_SIZE)
+			return -EMSGSIZE;
+
+		for (int i = 0; i < val->u64arr.size; i++) {
+			if (nla_put_uint(msg, nla_type, val->u64arr.val[i]))
+				return -EMSGSIZE;
+		}
+		break;
 	}
 	return 0;
 }
@@ -537,7 +546,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
-	int len;
+	int len, cnt, rem;
 
 	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
 
@@ -577,6 +586,28 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
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
+			    (nla_len(param_data) != sizeof(u32))) {
+				NL_SET_BAD_ATTR(info->extack, param_data);
+				return -EINVAL;
+			}
+
+			value->u64arr.val[cnt] = nla_get_uint(param_data);
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



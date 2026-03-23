Return-Path: <netdev+bounces-270356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBt2A+64wGmpKQQAu9opvQ
	(envelope-from <netdev+bounces-270356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 04:52:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF982EC480
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 04:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDF343002F42
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 03:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461B029BD8C;
	Mon, 23 Mar 2026 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZcYYMHql"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B22523D7DC;
	Mon, 23 Mar 2026 03:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774237917; cv=none; b=Bw+G7fQxKZDfWx2RhWXaH8WnyG3PQkw8MZNXQozW27G9HGt/krjR4Q2TWkVLY6OXLxX7m3SFNTeVAZjFNUpvAU67/SN+UIxHhT3ciuIyoOQmeDIGGdYljZEeVZwt8SA1DL56xWT/4zztTPGbObnbWOCymsT7Wlwp0rXIuMVp27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774237917; c=relaxed/simple;
	bh=XMvLFaRJBbDNtGPcxRaIpBGbtGp47NdM7HMPt/kCgFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8hN4VQazpxa629+hXHePll0ynOcxSphFWU4av2mBMgu44UljIn4ixC2AF9N/510yMjghTcMeKCN4TiluLH9qvg1orQ3L6V3tlAiuu+JB621TD7LrmXAiT++NSX+bAoNuFtrUVqfhKiIQZGWsbXU/DAc1jGP8yXDHJU71bjeamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZcYYMHql; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNsSWK2809804;
	Sun, 22 Mar 2026 20:51:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
	irflPn1NQejpF1CnzQmfQRoaUOwJwZYlraPVMp1/1I=; b=ZcYYMHql4mz8V+U/K
	bpYwJpCvDPOrD0g1Ymd7tqNKv6WoaMhXiv6sbdAZPTBg6xE6j36oyG2Gb0VSN2YK
	xf+E2vxim+3PqbpyWB/mDNMR4RCHlG2mxzCEQmJhcHUsnPHCijqQdCErm7QjC8jq
	OUM+5eE4hQcrRD0M8bGTVW91wMoYVQs+qliuO3yq5V36n42WHj45FOZalvKGY2dh
	ZSSLygUjyfa001Ec+CisYjH8rzv1nEkr5F5t5UzZflGX6vNQQnpt8jYLbmC4ciSf
	5BRp5ORQr6m+bG0l4L74ZfEaJjkU/g12PHptBZpJWBFKfSxfsZBhVc/uzprtNQic
	F/Prg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d1rpjjebs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 20:51:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Mar 2026 20:51:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 22 Mar 2026 20:51:29 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 6F4FE3F70A1;
	Sun, 22 Mar 2026 20:51:24 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, <dtatulea@nvidia.com>, <tariqt@nvidia.com>,
        Saeed Mahameed
	<saeedm@nvidia.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v7 net-next 2/5] devlink: Implement devlink param multi attribute nested data values
Date: Mon, 23 Mar 2026 09:21:07 +0530
Message-ID: <20260323035110.3908741-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323035110.3908741-1-rkannoth@marvell.com>
References: <20260323035110.3908741-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IBFb2Kasu7hReay9EsWn3vPMkvdvMuiq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyNSBTYWx0ZWRfXxTTCc62W1BMy
 lvT0nIWSGHNyu/2RmWXJ5bVEqE59HgJJxOTundL7khnTJOpZYkVz4ZEtJVDl3Qai2N5XpNd0S+n
 OlYOlzrXRBpsYhj+GuDgoMyQDkY61PQDHTR++S+EBRJTm6I4mMWbbNopq/i0xcKTtLpWDgYu8IJ
 c9ykUKN9n0WZ4nNhIYo0ezrJE65roV4mRWCxmxo+OAXX4YBKnrJkRrSW7/8MR6Q5Wquv9OU8E/+
 LhHS2+gwgcJ+ugL7GPBy8d9LUBDgzz9e7qI/2FO8qont6N1uRTk90GiCJCIGDGOmvv0zrAU6P++
 EiE2H5rvtapJHMIEiPkCAI01O9YXeeILqNr365FpFq81I6wIxUb0ffvbpxe+WBR8c9PiKHrZLvS
 6tM2sZ8diniDb7Zdu4P8nnW2htBDeRNfy+dfpQP7392edLh4JWlL3DbY+MAoNwh8ggLAtCsvwaA
 RU4VKutzx5Af8r8N3Pw==
X-Authority-Analysis: v=2.4 cv=Ed7FgfmC c=1 sm=1 tr=0 ts=69c0b8c3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=30srUtFeTE1TfWv-SDQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: IBFb2Kasu7hReay9EsWn3vPMkvdvMuiq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270356-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2EF982EC480
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
 Documentation/netlink/specs/devlink.yaml      |  4 +
 .../mellanox/mlx5/core/en/pcie_cong_event.c   |  8 +-
 include/net/devlink.h                         |  8 ++
 include/uapi/linux/devlink.h                  |  1 +
 net/devlink/netlink_gen.c                     |  2 +
 net/devlink/param.c                           | 91 +++++++++++++++----
 6 files changed, 95 insertions(+), 19 deletions(-)

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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
index 2eb666a46f39..e96dfe322c14 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -43,7 +43,6 @@ struct mlx5e_pcie_cong_event {
 	struct mlx5e_pcie_cong_stats stats;
 };
 
-
 static const struct counter_desc mlx5e_pcie_cong_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_pcie_cong_stats,
 			     pci_bw_inbound_high) },
@@ -259,7 +258,11 @@ mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
 		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
 	};
 	struct devlink *devlink = priv_to_devlink(dev);
-	union devlink_param_value val[4];
+	union devlink_param_value *val;
+
+	val = kcalloc(4, sizeof(*val), GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
 
 	for (int i = 0; i < 4; i++) {
 		u32 id = ids[i];
@@ -275,6 +278,7 @@ mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
 	config->outbound_low = val[2].vu16;
 	config->outbound_high = val[3].vu16;
 
+	kfree(val);
 	return 0;
 }
 
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
index cf95268da5b0..2ec85dffd8ac 100644
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
@@ -304,56 +312,78 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
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
+	ctx = kmalloc_obj(*ctx);
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
+			param_value[i] = ctx->val;
 
-			err = devlink_param_get_default(devlink, param, &ctx,
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
@@ -393,6 +423,9 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	nla_nest_end(msg, param_values_list);
 	nla_nest_end(msg, param_attr);
 	genlmsg_end(msg, hdr);
+	kfree(default_value);
+	kfree(param_value);
+	kfree(ctx);
 	return 0;
 
 values_list_nest_cancel:
@@ -401,7 +434,11 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
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
@@ -507,7 +544,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
-	int len;
+	int len, cnt, rem;
 
 	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
 
@@ -547,6 +584,26 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
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



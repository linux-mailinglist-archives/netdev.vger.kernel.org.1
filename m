Return-Path: <netdev+bounces-306033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +FjuEJsaT2p+agIAu9opvQ
	(envelope-from <netdev+bounces-306033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 05:50:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C91EF72C703
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 05:50:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=klqsvoPo;
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306033-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306033-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 324B1300A30C
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 03:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53665391E7B;
	Thu,  9 Jul 2026 03:50:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D83603D7;
	Thu,  9 Jul 2026 03:50:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569047; cv=none; b=OMtvAGwt+2qnyz1CbsnlWk644Vapz8Z8Db9moANgm0Aok1OGxs+rKzTe9NyVtHGXXSxQXXGwFPH1BSstA8+qLWG3rXUEX/CS8aSSluG7l7MOFd/gFMbjzo6tHEMZkg4xkiwr6isuHdZxdoedqOTyskd4K203SlZdIlXIwPKIKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569047; c=relaxed/simple;
	bh=XmDMtujibtm9FIs5xJqlK6HoDiNXUzxysRbiFdgNdSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tY633+s0sCkOWDceBUkKiwiGC9NuV/xUB5/D+i+hIEvoSSoqUa5F0f4I6qjjNC8HNwvjs0itmdClbkek62XUQaNcmIjpduOtFvTtVMZigZylKoE+gHI9rE8cwTErzutOV+o0htfKqZhuFMC5xxpRF+9YA4siOk4ukHtI43L5Yy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=klqsvoPo; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N8Dem1377871;
	Wed, 8 Jul 2026 20:50:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
	1vYCrvyPChV1EbBSJbQUK2x/GzqkdA05haOpm0X/Sk=; b=klqsvoPoKduOQHj8w
	iBBk2SS8f2qCLp7fAH6Myj7tpmge0IsvZxqRBB2tew2V5U4Nh0X0vMwnz8e7PcH4
	Y2CDNQaaIuTjaihYiPbjFz8q18wBF1Rdxb/TrMIu4kSbrW5lR6uUR9ghi8l2Z6Df
	dEkbOJXGZTwW6j9/mcOEipBQ9wASCi05TvI2XF1reI59ewsfrZLB+eYnvu/qX+9U
	jmuMyLpAeY4OuCkP85LA+l1igu6u/mZksKeP79X0o1ozKql6k67oF33Z7UbppgbD
	StfmJIXoR5UcyA9zBMYcStehrtKr1AvIeygCEBhLAVUqNgMLXcbC2iV8sw7hrlob
	5USbw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f9n39aw92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 20:50:31 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Jul 2026 20:50:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Jul 2026 20:50:30 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 011D13F708F;
	Wed,  8 Jul 2026 20:50:26 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <stephen@networkplumber.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <rkannoth@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>
Subject: [PATCH v5 iproute2-next 2/2] devlink: support u64-array values in devlink param show/set
Date: Thu, 9 Jul 2026 09:20:16 +0530
Message-ID: <20260709035016.911607-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709035016.911607-1-rkannoth@marvell.com>
References: <20260709035016.911607-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rxRKhF8a42kKS4nbyvG0fAd0cBtWt513
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAzMiBTYWx0ZWRfXyhRF8Wrgwt4P
 eUwfwISFXO2YtmCENsXpN281j75aMjRPFbei24e130HbOuHn/8mdf35wzn6a+ZcKL5fB8uDyEIm
 ADboRN4mDag7ToDoDZ12JJZg4z3kG2tbybyuAQ2DOFAIyHHfCUrw7c8mx5S5MR2lJaQHJutCqnt
 97CKuHriHeWPurM8ZgH6Qc8oMghWMPqG3MZ8LmuQhCfQ+x3y23Zt8NmLLmZV+th4Ni+77a2OGfg
 Xa99Ye8QvxxINBBWDZdjgNumNYo3ppVBAh3Ct3gS2ZThB9wmHN2SkxZ5DR8GSkJLAezdzer6Oh4
 9UJSBsQvj9qeFW+bnBDcL/vV5/3e59oKLcwzBxylSLFaoFizVEEHAxxeN3jmnl7MkpUlJXWM0K4
 PuehBvOrToUKhddiEeuHw0jiC1gSDfoYaykDg2IlzyWWgMSaUchRvnXovo/FYobl0BPCiAigMYF
 BpkP4SwzubO7fNbX0Gg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAzMiBTYWx0ZWRfX1RBQiWOJpPtZ
 IVDa2d1LUVc92SLCmxovxs/wl3dtbPMNnO1NUKWY6q5+gc/qXDHJdzafNWRF2pbalZ3w0Q1EHuS
 uhFESsPP2sncRhKYa3k5yDtSohjpXbA=
X-Authority-Analysis: v=2.4 cv=eLYjSnp1 c=1 sm=1 tr=0 ts=6a4f1a87 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=vs2Y_zNTtb1SDWicX50A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: rxRKhF8a42kKS4nbyvG0fAd0cBtWt513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306033-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:from_mime,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C91EF72C703

Add support for DEVLINK_VAR_ATTR_TYPE_U64_ARRAY parameters that carry
multiple DEVLINK_ATTR_PARAM_VALUE_DATA attributes. Parse and display
u64 array values in param show, and accept space- or comma-separated
u64 values in devlink and port param set commands.

- Show search order

devlink -jp dev param show pci/0002:01:00.0 name npc_srch_order
{
    "param": {
        "pci/0002:01:00.0": [ {
                "name": "npc_srch_order",
                "type": "driver-specific",
                "values": [ {
                        "cmode": "runtime",
                        "value": [ 15,17,14,18,13,19,12,20,11,21,10,22,9,23,8,24,7,25,6,26,5,27,4,28,3,29,2,30,1,31,0,16 ]
                    } ]
            } ]
    }
}

devlink dev param show pci/0002:01:00.0 name npc_srch_order
pci/0002:01:00.0:
  name npc_srch_order type driver-specific
    values:
      cmode runtime value 15 17 14 18 13 19 12 20 11 21 10 22 9 23 8 24 7 25 6 26 5 27 4 28 3 29 2 30 1 31 0 16

- Set search order

devlink dev param set pci/0002:01:00.0 name npc_srch_order value 31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,\
                22,23,24,25,26,27,28,29,30 cmode runtime

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 devlink/devlink.c | 246 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 223 insertions(+), 23 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 803ea5d7..b6b24b49 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3516,11 +3516,145 @@ static const struct param_val_conv param_val_conv[] = {
 
 #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
 
+struct devlink_param_u64_array {
+	uint64_t size;
+	uint64_t *val;
+};
+
+static void param_value_u64_array_free(struct devlink_param_u64_array *arr)
+{
+	free(arr->val);
+	arr->val = NULL;
+	arr->size = 0;
+}
+
+static int param_value_nested_u64_attr_cb(const struct nlattr *attr, void *data)
+{
+	struct devlink_param_u64_array *arr = data;
+	uint64_t *new_val;
+	unsigned int len;
+	uint64_t val;
+
+	if (mnl_attr_get_type(attr) != DEVLINK_ATTR_PARAM_VALUE_DATA)
+		return MNL_CB_OK;
+
+	len = mnl_attr_get_payload_len(attr);
+	if (len == sizeof(uint32_t))
+		val = mnl_attr_get_u32(attr);
+	else if (len == sizeof(uint64_t))
+		val = mnl_attr_get_u64(attr);
+	else
+		return MNL_CB_ERROR;
+
+	new_val = realloc(arr->val, (arr->size + 1) * sizeof(uint64_t));
+	if (!new_val)
+		return MNL_CB_ERROR;
+	arr->val = new_val;
+
+	arr->val[arr->size] = val;
+	arr->size++;
+
+	return MNL_CB_OK;
+}
+
+static int param_value_u64_array_fill(struct nlattr *nl,
+				      struct devlink_param_u64_array *arr)
+{
+	int err;
+
+	param_value_u64_array_free(arr);
+	err = mnl_attr_parse_nested(nl, param_value_nested_u64_attr_cb, arr);
+	if (err != MNL_CB_OK) {
+		param_value_u64_array_free(arr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool param_value_u64_array_equal(const struct devlink_param_u64_array *a,
+					const struct devlink_param_u64_array *b)
+{
+	uint64_t i;
+
+	if (a->size != b->size)
+		return false;
+
+	for (i = 0; i < a->size; i++) {
+		if (a->val[i] != b->val[i])
+			return false;
+	}
+
+	return true;
+}
+
+static int param_value_u64_array_put_from_str(struct nlmsghdr *nlh,
+					      const char *param_value,
+					      const struct devlink_param_u64_array *cur)
+{
+	struct devlink_param_u64_array new_arr = {};
+	char *copy, *token, *saveptr = NULL;
+	uint64_t val, *new_val;
+	char delim[] = " ,";
+	uint64_t i;
+	int err;
+
+	copy = strdup(param_value);
+	if (!copy)
+		return -ENOMEM;
+
+	token = strtok_r(copy, delim, &saveptr);
+	while (token) {
+		err = get_u64((__u64 *)&val, token, 10);
+		if (err) {
+			free(copy);
+			param_value_u64_array_free(&new_arr);
+			pr_err("Value \"%s\" is not a number or not within range\n",
+			       token);
+			return err;
+		}
+
+		new_val = realloc(new_arr.val, (new_arr.size + 1) * sizeof(uint64_t));
+		if (!new_val) {
+			free(copy);
+			param_value_u64_array_free(&new_arr);
+			return -ENOMEM;
+		}
+		new_arr.val = new_val;
+
+		new_arr.val[new_arr.size] = val;
+		new_arr.size++;
+		token = strtok_r(NULL, delim, &saveptr);
+	}
+	free(copy);
+
+	if (!new_arr.size) {
+		param_value_u64_array_free(&new_arr);
+		pr_err("Value must contain at least one element\n");
+		return -EINVAL;
+	}
+
+	/* Check current and new values. If both are equal, bail out */
+	if (cur && param_value_u64_array_equal(&new_arr, cur)) {
+		param_value_u64_array_free(&new_arr);
+		return 1;
+	}
+
+	for (i = 0; i < new_arr.size; i++)
+		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, new_arr.val[i]);
+
+	param_value_u64_array_free(&new_arr);
+	return 0;
+}
+
 static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				     struct nlattr *val_attr, bool conv_exists,
-				     const char *label, bool flag_as_u8)
+				     const char *label, bool flag_as_u8,
+				     struct nlattr *u64_arr_nl)
 {
+	struct devlink_param_u64_array u64_arr = { };
 	const char *vstr;
+	uint64_t i;
 	int err;
 
 	print_string(PRINT_FP, NULL, " %s ", label);
@@ -3582,6 +3716,23 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 		else
 			print_bool(PRINT_ANY, label, "%s", val_attr);
 		break;
+	case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
+		err = param_value_u64_array_fill(u64_arr_nl, &u64_arr);
+		if (err)
+			return err;
+
+		if (is_json_context()) {
+			open_json_array(PRINT_JSON, label);
+			for (i = 0; i < u64_arr.size; i++)
+				print_u64(PRINT_JSON, NULL, NULL, u64_arr.val[i]);
+			close_json_array(PRINT_JSON, NULL);
+		} else {
+			for (i = 0; i < u64_arr.size; i++)
+				print_u64(PRINT_FP, NULL, "%llu ", u64_arr.val[i]);
+		}
+
+		param_value_u64_array_free(&u64_arr);
+		break;
 	}
 
 	return 0;
@@ -3601,6 +3752,7 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 
 	if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
 	    (nla_type != MNL_TYPE_FLAG &&
+	     nla_type != DEVLINK_VAR_ATTR_TYPE_U64_ARRAY &&
 	     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
 		return;
 
@@ -3614,14 +3766,15 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 					    nla_name);
 
 	err = pr_out_param_value_print(nla_name, nla_type, val_attr,
-				       conv_exists, "value", false);
+				       conv_exists, "value", false, nl);
 	if (err)
 		return;
 
 	val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DEFAULT];
 	if (val_attr) {
 		err = pr_out_param_value_print(nla_name, nla_type, val_attr,
-					       conv_exists, "default", true);
+					       conv_exists, "default", true,
+					       val_attr);
 		if (err)
 			return;
 	}
@@ -3704,6 +3857,7 @@ struct param_ctx {
 		uint64_t vu64;
 		const char *vstr;
 		bool vbool;
+		struct devlink_param_u64_array u64arr;
 	} value;
 };
 
@@ -3745,6 +3899,7 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 
 		if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
 		    (nla_type != MNL_TYPE_FLAG &&
+		     nla_type != DEVLINK_VAR_ATTR_TYPE_U64_ARRAY &&
 		     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
 			return MNL_CB_ERROR;
 
@@ -3771,6 +3926,12 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 			case DEVLINK_VAR_ATTR_TYPE_FLAG:
 				ctx->value.vbool = val_attr ? true : false;
 				break;
+			case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
+				err = param_value_u64_array_fill(param_value_attr,
+								 &ctx->value.u64arr);
+				if (err)
+					return MNL_CB_ERROR;
+				break;
 			}
 			break;
 		}
@@ -3818,10 +3979,11 @@ static int cmd_dev_param_set(struct dl *dl)
 	ctx.dl = dl;
 	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_dev_param_set_cb, &ctx);
 	if (err)
-		return err;
+		goto out;
 	if (!ctx.cmode_found) {
 		pr_err("Configuration mode not supported\n");
-		return -ENOTSUP;
+		err = -ENOTSUP;
+		goto out;
 	}
 
 	if (dl->opts.present & DL_OPT_PARAM_SET_DEFAULT) {
@@ -3829,7 +3991,8 @@ static int cmd_dev_param_set(struct dl *dl)
 				       NLM_F_REQUEST | NLM_F_ACK);
 		dl_opts_put(nlh, dl);
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.nla_type);
-		return mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
+		err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
+		goto out;
 	}
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_PARAM_SET,
@@ -3855,7 +4018,7 @@ static int cmd_dev_param_set(struct dl *dl)
 		if (err)
 			goto err_param_value_parse;
 		if (val_u8 == ctx.value.vu8)
-			return 0;
+			goto out;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
 		break;
 	case DEVLINK_VAR_ATTR_TYPE_U16:
@@ -3872,7 +4035,7 @@ static int cmd_dev_param_set(struct dl *dl)
 		if (err)
 			goto err_param_value_parse;
 		if (val_u16 == ctx.value.vu16)
-			return 0;
+			goto out;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
 		break;
 	case DEVLINK_VAR_ATTR_TYPE_U32:
@@ -3889,7 +4052,7 @@ static int cmd_dev_param_set(struct dl *dl)
 		if (err)
 			goto err_param_value_parse;
 		if (val_u32 == ctx.value.vu32)
-			return 0;
+			goto out;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
 	case DEVLINK_VAR_ATTR_TYPE_U64:
@@ -3904,7 +4067,7 @@ static int cmd_dev_param_set(struct dl *dl)
 		if (err)
 			goto err_param_value_parse;
 		if (val_u64 == ctx.value.vu64)
-			return 0;
+			goto out;
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u64);
 		break;
 	case DEVLINK_VAR_ATTR_TYPE_FLAG:
@@ -3912,7 +4075,7 @@ static int cmd_dev_param_set(struct dl *dl)
 		if (err)
 			goto err_param_value_parse;
 		if (val_bool == ctx.value.vbool)
-			return 0;
+			goto out;
 		if (val_bool)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
@@ -3921,17 +4084,32 @@ static int cmd_dev_param_set(struct dl *dl)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				  dl->opts.param_value);
 		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
-			return 0;
+			goto out;
+		break;
+	case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
+		err = param_value_u64_array_put_from_str(nlh, dl->opts.param_value,
+							 &ctx.value.u64arr);
+		if (err == 1) {
+			err = 0;
+			goto out;
+		}
+		if (err)
+			goto out;
 		break;
 	default:
 		printf("Value type not supported\n");
-		return -ENOTSUP;
+		err = -ENOTSUP;
+		goto out;
 	}
-	return mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
+	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
+	goto out;
 
 err_param_value_parse:
 	pr_err("Value \"%s\" is not a number or not within range\n",
 	       dl->opts.param_value);
+
+out:
+	param_value_u64_array_free(&ctx.value.u64arr);
 	return err;
 }
 
@@ -5369,6 +5547,7 @@ static int cmd_port_param_set_cb(const struct nlmsghdr *nlh, void *data)
 
 		if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
 		    (nla_type != MNL_TYPE_FLAG &&
+		     nla_type != DEVLINK_VAR_ATTR_TYPE_U64_ARRAY &&
 		     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
 			return MNL_CB_ERROR;
 
@@ -5391,6 +5570,12 @@ static int cmd_port_param_set_cb(const struct nlmsghdr *nlh, void *data)
 			case MNL_TYPE_FLAG:
 				ctx->value.vbool = val_attr ? true : false;
 				break;
+			case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
+				err = param_value_u64_array_fill(param_value_attr,
+								 &ctx->value.u64arr);
+				if (err)
+					return MNL_CB_ERROR;
+				break;
 			}
 			break;
 		}
@@ -5426,7 +5611,7 @@ static int cmd_port_param_set(struct dl *dl)
 	ctx.dl = dl;
 	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_port_param_set_cb, &ctx);
 	if (err)
-		return err;
+		goto out;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_PORT_PARAM_SET,
 					  NLM_F_REQUEST | NLM_F_ACK);
@@ -5451,7 +5636,7 @@ static int cmd_port_param_set(struct dl *dl)
 		if (err)
 			goto err_param_value_parse;
 		if (val_u8 == ctx.value.vu8)
-			return 0;
+			goto out;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
 		break;
 	case MNL_TYPE_U16:
@@ -5468,7 +5653,7 @@ static int cmd_port_param_set(struct dl *dl)
 		if (err)
 			goto err_param_value_parse;
 		if (val_u16 == ctx.value.vu16)
-			return 0;
+			goto out;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
 		break;
 	case MNL_TYPE_U32:
@@ -5485,7 +5670,7 @@ static int cmd_port_param_set(struct dl *dl)
 		if (err)
 			goto err_param_value_parse;
 		if (val_u32 == ctx.value.vu32)
-			return 0;
+			goto out;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
 	case MNL_TYPE_U64:
@@ -5500,7 +5685,7 @@ static int cmd_port_param_set(struct dl *dl)
 		if (err)
 			goto err_param_value_parse;
 		if (val_u64 == ctx.value.vu64)
-			return 0;
+			goto out;
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u64);
 		break;
 	case MNL_TYPE_FLAG:
@@ -5508,7 +5693,7 @@ static int cmd_port_param_set(struct dl *dl)
 		if (err)
 			goto err_param_value_parse;
 		if (val_bool == ctx.value.vbool)
-			return 0;
+			goto out;
 		if (val_bool)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
@@ -5517,17 +5702,32 @@ static int cmd_port_param_set(struct dl *dl)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				  dl->opts.param_value);
 		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
-			return 0;
+			goto out;
+		break;
+	case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
+		err = param_value_u64_array_put_from_str(nlh, dl->opts.param_value,
+							 &ctx.value.u64arr);
+		if (err == 1) {
+			err = 0;
+			goto out;
+		}
+		if (err)
+			goto out;
 		break;
 	default:
 		printf("Value type not supported\n");
-		return -ENOTSUP;
+		err = -ENOTSUP;
+		goto out;
 	}
-	return mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
+	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
+	goto out;
 
 err_param_value_parse:
 	pr_err("Value \"%s\" is not a number or not within range\n",
 	       dl->opts.param_value);
+
+out:
+	param_value_u64_array_free(&ctx.value.u64arr);
 	return err;
 }
 
-- 
2.43.0



Return-Path: <netdev+bounces-170524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B113EA48E74
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A675188E109
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7119E17A5BE;
	Fri, 28 Feb 2025 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL9UBE+G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B98D17A308
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709141; cv=none; b=YCO8bZE2hTEP7qi6aOJl16dxQJqtiqZ5yTCc5casX5fG5R6GR73l4KdcI3zQo1VX17zkqotBC+hjN03H1lOnGAjDbFes2MCom53mt0yt+uAMdCxgPQaVieHQNQqhbuH3WSu7cS/voVphOjSCvlOYGFzcYTrumO2Y1PU4G3cC4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709141; c=relaxed/simple;
	bh=Y97xMQGYdT8MMIV/cw/xozW+d8GQVXSy7LJeVAJ+Eos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuzjIorK7uUA7ybbEn/iTs0A8WOHJCmieLPHVKgxCF/P7aWhlurPo31RP6AM4Fp9cK8+SQ1aAC8T8TIRmOkMquVQqyzElTwIMxv3mp7P5g0LYezErikiLg8nN3GYXb1j88JrbSxrO/iSA2k2vz3v39XwXkDrbAHnEQBMYPFnlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL9UBE+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48CEC4CEE6;
	Fri, 28 Feb 2025 02:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709140;
	bh=Y97xMQGYdT8MMIV/cw/xozW+d8GQVXSy7LJeVAJ+Eos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bL9UBE+G6+oDBUT31JO+Jg0UUQhRi3PORcTlXbeEVy9sNLDeSxnqwl5uxcgD39VWI
	 Nwv3B+MPPujO9cMDzrz+h3/lrmPkmkIIm3yF8skrhQr9b0av8ZeXtJWMwEkx7u/wn5
	 y5C/LowaypdAZtUoWlbt6LRFpiO7EFo5+2uGJ+In/afhy1GymJ60Pk/EOctBgHxYbE
	 XExoER1yFljYMXHmHHDFZXVkiEollq9cp67N6tAJbDctlRIqIHULgECDh2xfy1X4ad
	 3wib67yufBBnLAZeO4JA5vFa59f5RW6vsriNsSfcYaon1Gw6x8eqnJTOjCIhZQU33t
	 yNn56HBDzFlAQ==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 05/10] devlink: rename param_ctx to dl_param
Date: Thu, 27 Feb 2025 18:18:32 -0800
Message-ID: <20250228021837.880041-6-saeed@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228021837.880041-1-saeed@kernel.org>
References: <20250228021837.880041-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

dl_param structure will be used in down stream patches to store and help
process devlink param values that are read from user input and kernel.

Rename it to reflect a more suitable name for it's purpose.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c | 62 +++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 09afc300..b41b06f9 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3627,7 +3627,7 @@ static int cmd_dev_param_show_cb(const struct nlmsghdr *nlh, void *data)
 	return MNL_CB_OK;
 }
 
-struct param_ctx {
+struct dl_param {
 	struct dl *dl;
 	enum devlink_dyn_attr_type type;
 	bool cmode_found;
@@ -3648,8 +3648,8 @@ static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 	struct nlattr *param_value_attr;
 	enum devlink_dyn_attr_type type;
 	enum devlink_param_cmode cmode;
-	struct param_ctx *ctx = data;
-	struct dl *dl = ctx->dl;
+	struct dl_param *param = data;
+	struct dl *dl = param->dl;
 	int err;
 
 	mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
@@ -3686,23 +3686,23 @@ static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 
 		cmode = mnl_attr_get_u8(nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE]);
 		if (cmode == dl->opts.cmode) {
-			ctx->cmode_found = true;
+			param->cmode_found = true;
 			val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
 			switch (type) {
 			case DEVLINK_DYN_ATTR_TYPE_U8:
-				ctx->value.vu8 = mnl_attr_get_u8(val_attr);
+				param->value.vu8 = mnl_attr_get_u8(val_attr);
 				break;
 			case DEVLINK_DYN_ATTR_TYPE_U16:
-				ctx->value.vu16 = mnl_attr_get_u16(val_attr);
+				param->value.vu16 = mnl_attr_get_u16(val_attr);
 				break;
 			case DEVLINK_DYN_ATTR_TYPE_U32:
-				ctx->value.vu32 = mnl_attr_get_u32(val_attr);
+				param->value.vu32 = mnl_attr_get_u32(val_attr);
 				break;
 			case DEVLINK_DYN_ATTR_TYPE_STRING:
-				ctx->value.vstr = mnl_attr_get_str(val_attr);
+				param->value.vstr = mnl_attr_get_str(val_attr);
 				break;
 			case DEVLINK_DYN_ATTR_TYPE_FLAG:
-				ctx->value.vbool = val_attr ? true : false;
+				param->value.vbool = val_attr ? true : false;
 				break;
 			default:
 				break;
@@ -3710,13 +3710,13 @@ static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 			break;
 		}
 	}
-	ctx->type = type;
+	param->type = type;
 	return MNL_CB_OK;
 }
 
 static int cmd_dev_param_set(struct dl *dl)
 {
-	struct param_ctx ctx = {};
+	struct dl_param kparam = {}; /* kernel param */
 	struct nlmsghdr *nlh;
 	bool conv_exists;
 	uint32_t val_u32 = 0;
@@ -3737,11 +3737,11 @@ static int cmd_dev_param_set(struct dl *dl)
 			       NLM_F_REQUEST | NLM_F_ACK);
 	dl_opts_put(nlh, dl);
 
-	ctx.dl = dl;
-	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_param_set_cb, &ctx);
+	kparam.dl = dl;
+	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_param_set_cb, &kparam);
 	if (err)
 		return err;
-	if (!ctx.cmode_found) {
+	if (!kparam.cmode_found) {
 		pr_err("Configuration mode not supported\n");
 		return -ENOTSUP;
 	}
@@ -3753,8 +3753,8 @@ static int cmd_dev_param_set(struct dl *dl)
 	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
 					    dl->opts.param_name);
 
-	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.type);
-	switch (ctx.type) {
+	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, kparam.type);
+	switch (kparam.type) {
 	case DEVLINK_DYN_ATTR_TYPE_U8:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
@@ -3768,7 +3768,7 @@ static int cmd_dev_param_set(struct dl *dl)
 		}
 		if (err)
 			goto err_param_value_parse;
-		if (val_u8 == ctx.value.vu8)
+		if (val_u8 == kparam.value.vu8)
 			return 0;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
 		break;
@@ -3785,7 +3785,7 @@ static int cmd_dev_param_set(struct dl *dl)
 		}
 		if (err)
 			goto err_param_value_parse;
-		if (val_u16 == ctx.value.vu16)
+		if (val_u16 == kparam.value.vu16)
 			return 0;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
 		break;
@@ -3800,7 +3800,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			err = get_u32(&val_u32, dl->opts.param_value, 10);
 		if (err)
 			goto err_param_value_parse;
-		if (val_u32 == ctx.value.vu32)
+		if (val_u32 == kparam.value.vu32)
 			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
@@ -3808,7 +3808,7 @@ static int cmd_dev_param_set(struct dl *dl)
 		err = strtobool(dl->opts.param_value, &val_bool);
 		if (err)
 			goto err_param_value_parse;
-		if (val_bool == ctx.value.vbool)
+		if (val_bool == kparam.value.vbool)
 			return 0;
 		if (val_bool)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
@@ -3817,7 +3817,7 @@ static int cmd_dev_param_set(struct dl *dl)
 	case DEVLINK_DYN_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				  dl->opts.param_value);
-		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
+		if (!strcmp(dl->opts.param_value, kparam.value.vstr))
 			return 0;
 		break;
 	default:
@@ -5224,7 +5224,7 @@ static int cmd_port_function_set(struct dl *dl)
 
 static int cmd_port_param_set(struct dl *dl)
 {
-	struct param_ctx ctx = {};
+	struct dl_param kparam = {}; /* kernel param */
 	struct nlmsghdr *nlh;
 	bool conv_exists;
 	uint32_t val_u32 = 0;
@@ -5245,8 +5245,8 @@ static int cmd_port_param_set(struct dl *dl)
 					  NLM_F_REQUEST | NLM_F_ACK);
 	dl_opts_put(nlh, dl);
 
-	ctx.dl = dl;
-	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_param_set_cb, &ctx);
+	kparam.dl = dl;
+	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_param_set_cb, &kparam);
 	if (err)
 		return err;
 
@@ -5257,8 +5257,8 @@ static int cmd_port_param_set(struct dl *dl)
 	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
 					    dl->opts.param_name);
 
-	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.type);
-	switch (ctx.type) {
+	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, kparam.type);
+	switch (kparam.type) {
 	case DEVLINK_DYN_ATTR_TYPE_U8:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
@@ -5272,7 +5272,7 @@ static int cmd_port_param_set(struct dl *dl)
 		}
 		if (err)
 			goto err_param_value_parse;
-		if (val_u8 == ctx.value.vu8)
+		if (val_u8 == kparam.value.vu8)
 			return 0;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
 		break;
@@ -5289,7 +5289,7 @@ static int cmd_port_param_set(struct dl *dl)
 		}
 		if (err)
 			goto err_param_value_parse;
-		if (val_u16 == ctx.value.vu16)
+		if (val_u16 == kparam.value.vu16)
 			return 0;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
 		break;
@@ -5304,7 +5304,7 @@ static int cmd_port_param_set(struct dl *dl)
 			err = get_u32(&val_u32, dl->opts.param_value, 10);
 		if (err)
 			goto err_param_value_parse;
-		if (val_u32 == ctx.value.vu32)
+		if (val_u32 == kparam.value.vu32)
 			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
@@ -5312,7 +5312,7 @@ static int cmd_port_param_set(struct dl *dl)
 		err = strtobool(dl->opts.param_value, &val_bool);
 		if (err)
 			goto err_param_value_parse;
-		if (val_bool == ctx.value.vbool)
+		if (val_bool == kparam.value.vbool)
 			return 0;
 		if (val_bool)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
@@ -5321,7 +5321,7 @@ static int cmd_port_param_set(struct dl *dl)
 	case DEVLINK_DYN_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				  dl->opts.param_value);
-		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
+		if (!strcmp(dl->opts.param_value, kparam.value.vstr))
 			return 0;
 		break;
 	default:
-- 
2.48.1



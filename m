Return-Path: <netdev+bounces-74200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ABE860732
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF991C20AF0
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F86140E35;
	Thu, 22 Feb 2024 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHxegNRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76378140E31
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646189; cv=none; b=VlYY+1Bda2O5TAihTmYZum3wK4dHMlm0TMdmBl3TLP6EQS5FEnqFn3DEMpUNrCtruHAffcgfFMXQp/RDusbqMNH/MuCqnFxzxvXAboSzde8xKE0XAtracdDCEuVvEEEdCaerP0CccehFYol/LbhjnJzrb26ZYBW9s9VAJQaV1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646189; c=relaxed/simple;
	bh=nOQUf7SLSS30ISLOkTJLNcjDW3Vopav8yrhefX5fUqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ0Kp0IaDK3kGdNH7x+fmzmoOUVIVnBUQbxhfRrMSQC1ip8EAqpkHywwj/zN+SQkE9SragcnTH4/qbO4hZRrO2UjK8yhn60sG5vxi0b1UCv19kmqL6LZ6nf1a7/keIVhmPuoy5fdFbawcCSmRRIUxKMQnWp3pMAjzwqGB6dG2bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHxegNRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7E1C433F1;
	Thu, 22 Feb 2024 23:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646189;
	bh=nOQUf7SLSS30ISLOkTJLNcjDW3Vopav8yrhefX5fUqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHxegNRq9wZFlRUMM7KAaO7HebRS9KRKTQTBq71OPrB6dWifKcHj8u/KIbe+K9t7u
	 /TnHAuDnndBCMP6tDzXtcWe/w6+fOMg7lqJYb0uKYryTHzH05fVocjYsCqLovpexiG
	 qo+CcmL+m5aGBYYWQ9ZgQ1LXthz1FveJFnxbdFVLf/R014TJB9ELMh1qzozAZokuIc
	 U204q6zYNXQYLmRnDSM02BYNnCTjyWZylkt0IxRIg0GY+uKOG1Z+fdSoAZZq5FVaRs
	 9W4NJ8/dcWy/uad27Vv1hJSYkq3pZ5ZF/h0uU9myKdbSAL4sn3/PK8zcwa57j7opmF
	 iSqFL9FBYAAAQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	sdf@google.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 07/15] tools: ynl-gen: remove unused parse code
Date: Thu, 22 Feb 2024 15:56:06 -0800
Message-ID: <20240222235614.180876-8-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235614.180876-1-kuba@kernel.org>
References: <20240222235614.180876-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f2ba1e5e2208 ("tools: ynl-gen: stop generating common notification handlers")
removed the last caller of the parse_cb_run() helper.
We no longer need to export ynl_cb_array.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 2 --
 tools/net/ynl/lib/ynl.c      | 2 +-
 tools/net/ynl/ynl-gen-c.py   | 8 --------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index eb109170102d..653119c9f47c 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -83,8 +83,6 @@ struct ynl_ntf_base_type {
 	unsigned char data[] __attribute__((aligned(8)));
 };
 
-extern mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE];
-
 struct nlmsghdr *
 ynl_gemsg_start_req(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version);
 struct nlmsghdr *
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index ec3bc7baadd1..c9790257189c 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -297,7 +297,7 @@ static int ynl_cb_noop(const struct nlmsghdr *nlh, void *data)
 	return MNL_CB_OK;
 }
 
-mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE] = {
+static mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE] = {
 	[NLMSG_NOOP]	= ynl_cb_noop,
 	[NLMSG_ERROR]	= ynl_cb_error,
 	[NLMSG_DONE]	= ynl_cb_done,
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 5d174ce67dbc..87f8b9d28734 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -40,14 +40,6 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def get_family_id(self):
         return 'ys->family_id'
 
-    def parse_cb_run(self, cb, data, is_dump=False, indent=1):
-        ind = '\n\t\t' + '\t' * indent + ' '
-        if is_dump:
-            return f"mnl_cb_run2(ys->rx_buf, len, 0, 0, {cb}, {data},{ind}ynl_cb_array, NLMSG_MIN_TYPE)"
-        else:
-            return f"mnl_cb_run2(ys->rx_buf, len, ys->seq, ys->portid,{ind}{cb}, {data},{ind}" + \
-                   "ynl_cb_array, NLMSG_MIN_TYPE)"
-
 
 class Type(SpecAttr):
     def __init__(self, family, attr_set, attr, value):
-- 
2.43.2



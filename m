Return-Path: <netdev+bounces-75493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC986A280
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D991F26E60
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4125555E4E;
	Tue, 27 Feb 2024 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNmVIdnl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3E55E45
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073048; cv=none; b=HK/UJaCCjuJovwIuIYw2IF9nzYjkCZIIXaPYRoZ0rDEHsB8TYDHCZlGD/tkBUAkUdzfWAacBLpg5wHs4VYoVugMx/5Sj0m+cV3B0EvsN1UvmvECWIZo0uvnXm8paXFMugSN4+uRzwZAWIjFWAMi39tSipNsBulcdO+epJjcjlsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073048; c=relaxed/simple;
	bh=l0Q9NEChseZtmyLEn+GN3xpowNfAxEpxcVLAimENsWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhV76pCBDHe45NIUHdTfF8Tri0RkmB1mBObs/a04nmTWahxOtNY7Xv9U7UkDWC4f3zVn4t3xAaLp2oljRQv4I1KWij30nMtBNM4OUnQF5Ynq9nnDBk/7Jog7cJBQO2/Pm2beO8+j418J7H86Lv8vEmtZQZkWcAZYNqjJm8JHw3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNmVIdnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91212C433C7;
	Tue, 27 Feb 2024 22:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073048;
	bh=l0Q9NEChseZtmyLEn+GN3xpowNfAxEpxcVLAimENsWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNmVIdnlqADMBDu3dVHmb6t73S5HdinTC7uiYjqcMPg7gKKY94FDDxfQrQHRFX/ZZ
	 rWSMcGGw3lk0ygZ4+/KvFdJsiIglwL0+rbfegSDL/5iCoHJ6af8PKASjUEWnCL/R8K
	 woZgE5OS8IU80cSWM/IKsZ6rEMaOnLfldwrFDK3Mxdm6fKs9xx8YiLAB0GqhizFIa7
	 CdZEb79n82UOe2Lu0RstM9lYdHUesybV6hOjnhAugvA0viaT5SL9PQTEILcSt9uBwQ
	 HjQCdpnIxL/6uuT9vuWIjcl7xSQZFuxMam0Lry7ai8OuEMGWsOntBSCqDUYx1s1Hxk
	 5aXy5C/ejZITA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 07/15] tools: ynl-gen: remove unused parse code
Date: Tue, 27 Feb 2024 14:30:24 -0800
Message-ID: <20240227223032.1835527-8-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227223032.1835527-1-kuba@kernel.org>
References: <20240227223032.1835527-1-kuba@kernel.org>
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

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 2 --
 tools/net/ynl/lib/ynl.c      | 2 +-
 tools/net/ynl/ynl-gen-c.py   | 8 --------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index c44b53c8d084..ef16fcbd9f68 100644
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
index 88456c7bb1ec..ad77ce6a1128 100644
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
index 6f57c9f00e7a..289a04f2cfaa 100755
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



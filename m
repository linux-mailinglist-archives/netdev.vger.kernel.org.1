Return-Path: <netdev+bounces-63245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF37D82BF51
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CBC1C2381D
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CA267E90;
	Fri, 12 Jan 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tyc0yTqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAD35FEEB
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e63bc90f2so7730595e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 03:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705059573; x=1705664373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pr+wVtpNQzo7DKyFyGNpOna1QBhhCMboD+RrhK1Mnyk=;
        b=tyc0yTqyL+SXJRfB3/NXaCSvYctMty8ovpe15SdIL4rjpk35mu/tY4mJEgY1d9Ed2U
         Se5GCy7a+5J6V86eZdVGf91EhzbKzfQKgHn++mPCUFGnU5hUdFASxQ69hHhhomxZ16Kz
         tSwisOB1Gd/CwiD2dfGa5uUh1vwDg2z/U62DoHBPzdvbPjmv+uLI7wPj8sTARNBpjq1K
         0WFvZ1mEfAChsAYgGHf2hIeVCr6NhsfRFSchaXlJJTaSzjNPziOP8t9jbkYYhy1mwxLN
         N0Cl1gxSDocdc3Mla3wKGPEpmi+kPt5J/Xb28JjBbMD2vX+BLBD4aZTJ2JRcUj6oBOd4
         jD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705059573; x=1705664373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr+wVtpNQzo7DKyFyGNpOna1QBhhCMboD+RrhK1Mnyk=;
        b=QB1KVewRvI5hrQi751RcPw34FlL7sCfmkgB7rpE+JbUbYK/HsglOLh3HMakf/mmOfx
         AhBgRTSpjWiFwgbqdEA02z465UwIhHLSCVo+3A2/HL4du4QzTdlk1c7dL2+EZebBqxuY
         DNLBgL+kzE72Oo7lnnGwlTEL08WaouQla3BFfZVT73ulP3B29APYfCPGC0cMyn++T1z1
         6GNEUV2mXmHhmZapXlA8irrpI/AaRdfP+B6ScwfjBguoD0b9H+yZ/WJv9vu6YeZ5sdAl
         D6qKKZ0Mxs7KjcezmyAUqK9fYbhxpsRDm0jYFfYjJWlyNv/QuC3nejHvhUwWCz7qhYw+
         j6EA==
X-Gm-Message-State: AOJu0Yw+LRco6WZBTlZzT73etYa/gJimxrHcRg3zONRGyK+xRclUzaRb
	MPtSfpR7Hw8mMYJarsFyyEaWjShsI1KqPfxd3hEs4s31ssE=
X-Google-Smtp-Source: AGHT+IFKd7rrAug3kjA4WMk8VVbAimPCkSgrh1jGG0y0/xWSvESfd8D+8R6KIXu9kD/ZYipB2PfXmA==
X-Received: by 2002:a05:600c:46d4:b0:40c:4904:bb72 with SMTP id q20-20020a05600c46d400b0040c4904bb72mr695956wmo.18.1705059573025;
        Fri, 12 Jan 2024 03:39:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040e5951f199sm5342622wmq.34.2024.01.12.03.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 03:39:32 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	idosch@idosch.org,
	mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com
Subject: [patch net] net: sched: track device in tcf_block_get/put_ext() only for clsact binder types
Date: Fri, 12 Jan 2024 12:39:30 +0100
Message-ID: <20240112113930.1647666-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Clsact/ingress qdisc is not the only one using shared block,
red is also using it. The device tracking was originally introduced
by commit 913b47d3424e ("net/sched: Introduce tc block netdev
tracking infra") for clsact/ingress only. Commit 94e2557d086a ("net:
sched: move block device tracking into tcf_block_get/put_ext()")
mistakenly enabled that for red as well.

Fix that by adding a check for the binder type being clsact when adding
device to the block->ports xarray.

Reported-by: Ido Schimmel <idosch@idosch.org>
Closes: https://lore.kernel.org/all/ZZ6JE0odnu1lLPtu@shredder/
Fixes: 94e2557d086a ("net: sched: move block device tracking into tcf_block_get/put_ext()")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/sched/cls_api.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index e3236a3169c3..92a12e3d0fe6 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1424,6 +1424,14 @@ static void tcf_block_owner_del(struct tcf_block *block,
 	WARN_ON(1);
 }
 
+static bool tcf_block_tracks_dev(struct tcf_block *block,
+				 struct tcf_block_ext_info *ei)
+{
+	return tcf_block_shared(block) &&
+	       (ei->binder_type == FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS ||
+		ei->binder_type == FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRESS);
+}
+
 int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
 		      struct tcf_block_ext_info *ei,
 		      struct netlink_ext_ack *extack)
@@ -1462,7 +1470,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
 	if (err)
 		goto err_block_offload_bind;
 
-	if (tcf_block_shared(block)) {
+	if (tcf_block_tracks_dev(block, ei)) {
 		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
 		if (err) {
 			NL_SET_ERR_MSG(extack, "block dev insert failed");
@@ -1516,7 +1524,7 @@ void tcf_block_put_ext(struct tcf_block *block, struct Qdisc *q,
 
 	if (!block)
 		return;
-	if (tcf_block_shared(block))
+	if (tcf_block_tracks_dev(block, ei))
 		xa_erase(&block->ports, dev->ifindex);
 	tcf_chain0_head_change_cb_del(block, ei);
 	tcf_block_owner_del(block, q, ei->binder_type);
-- 
2.43.0



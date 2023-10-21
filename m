Return-Path: <netdev+bounces-43222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 211467D1CCC
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DCEB214A4
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03CDF45;
	Sat, 21 Oct 2023 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="K43z4ofH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B831C38
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:27:17 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A321A4
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso249555866b.0
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697887634; x=1698492434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xboRRVpu5R7RrRzW/yXOf5BKGVSXwe/0d1S4FFJYQDE=;
        b=K43z4ofHDFHnMBykTDfHbhobeU5JFmTH8Bbbji6ntR67OZCidp6xs2NM0ubeuKHT6/
         /iESRW4L4GwMfM8TVZOPY5OT13sew7Eo0jCx1AJQB5izOFugYg5oE47t5DbXPbo7+nAd
         G9ACIqR2wASzZMEC3KgDJ9NUfRI/gsseu2/Ccd9DOabLNT2Kw//4jX0/uS93iXLiCSjt
         D3Ed5GoclYchSOqlgqYm0ZeWvLWwnNTaLM18hr+DtnlEV54x21AmwVaNE+H8By3iMSNF
         LaBZoRTHBiA68uPjvkabJW9ylLF16HPUlKejTypcJTuTcx9S5zhJOF5yJkFmXx8xk3Zr
         /Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697887634; x=1698492434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xboRRVpu5R7RrRzW/yXOf5BKGVSXwe/0d1S4FFJYQDE=;
        b=XPbxoHXH8w7qkNEJBuoJMNyYXK4D8GWoranULAXJ4FRdPmRJihylvMi0NDQP9TFlpn
         hL9+cxgMXjTj/l51BWR6I3W4B51v4h/bNnKSgM2KfIfWEsqo/QX+ypbE5V2d5KaokWR9
         pxooUbDyOWjOFi7wQc/eHNX4O5Ex+tg/qSOL63FGZxCpDFEcHxRh3yZgPPEZ8mWTKYqi
         /s6go5Zi28ebR6d7IytN/a+Rmb64AnlwXMMOwkIPb/QFZztdwmRkWP9p7XSIolWgoPE5
         LbOY64yXG+nK8Pm2X46sDOj/iomQR2lbXNg7KOMvZr8vGicZCBlYpRJbJ9O6bnbtVcA1
         dmYA==
X-Gm-Message-State: AOJu0Yx6BJZ9fEJ+qr9YGdVtQ/zjljT+xtsQoSVLsPDPN3s5W0ql9X0M
	3HPaRhEaNnssez0ZTP1EX9/eUr2CAnuMP5BgkKo=
X-Google-Smtp-Source: AGHT+IENxEYkq57RYKhPUvUl9N/4sv+TQsN5z4YvLtaZDKdkiOVxgv8EyG8EHGw3mTLHouKkdJYfMQ==
X-Received: by 2002:a17:907:9286:b0:9be:4bb0:64f with SMTP id bw6-20020a170907928600b009be4bb0064fmr3079893ejc.54.1697887634571;
        Sat, 21 Oct 2023 04:27:14 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c22-20020a170906529600b009b285351817sm3408802ejm.116.2023.10.21.04.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:27:14 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v3 01/10] genetlink: don't merge dumpit split op for different cmds into single iter
Date: Sat, 21 Oct 2023 13:27:02 +0200
Message-ID: <20231021112711.660606-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021112711.660606-1-jiri@resnulli.us>
References: <20231021112711.660606-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently, split ops of doit and dumpit are merged into a single iter
item when they are subsequent. However, there is no guarantee that the
dumpit op is for the same cmd as doit op.

Fix this by checking if cmd is the same for both.

Fixes: b8fd60c36a44 ("genetlink: allow families to use split ops directly")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- removed redundant cnt check
---
 net/netlink/genetlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 8315d31b53db..92ef5ed2e7b0 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -225,7 +225,8 @@ static void genl_op_from_split(struct genl_op_iter *iter)
 	}
 
 	if (i + cnt < family->n_split_ops &&
-	    family->split_ops[i + cnt].flags & GENL_CMD_CAP_DUMP) {
+	    family->split_ops[i + cnt].flags & GENL_CMD_CAP_DUMP &&
+	    (!cnt || family->split_ops[i + cnt].cmd == iter->doit.cmd)) {
 		iter->dumpit = family->split_ops[i + cnt];
 		genl_op_fill_in_reject_policy_split(family, &iter->dumpit);
 		cnt++;
-- 
2.41.0



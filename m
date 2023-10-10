Return-Path: <netdev+bounces-39516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88D77BF937
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074A91C20B80
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8C3182A7;
	Tue, 10 Oct 2023 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JIdCX7TI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0653B2
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:08:35 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23368AF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so9326220a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696936112; x=1697540912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMPO8QGrU2clD8qpwh42xgVy7XuArce2N7v69BQuK1k=;
        b=JIdCX7TIp9Hbexc3V9tCnXMJcvkHzm3qCRP6YOoSqTUq/Q9GPdTQvrxVwBK931VM+x
         ccLMx0iJPGhl3c6+FUl6SA4+Yqhkm3nKVIJcCcyYFmI3OarbBf1wGfFrN4yzVtrE/9ET
         k1G8KJISZpaIUhm1xTZPX9JXAlKS3nSWtXNH+zsI4j1eOO7PwHxvEo6K9+dm2g1TYzd1
         QD283V2K2rqGbaGbdKKZXxUY1TWx63e2MtDybEw8qLJyyqnX0y/MjL2W5FSuOIb6yV5K
         +xGW4FWECd+UPSHNCikd9r/7+zHduMk4rVdKIihvT/24mLIM3kAu2YYiN0enR6hrir1B
         Cqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936112; x=1697540912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMPO8QGrU2clD8qpwh42xgVy7XuArce2N7v69BQuK1k=;
        b=cMpa3syQFtGE2t1oEZqzwTr4IdOr7GLMei7jUCqpywXO6Mqu/uGPTA/9aWfLrDfy14
         F4RoJ6TJMIuRHEbfd+9Lmhu4Pyn9dgEagU+K9aVlxrl275UGcoSYnxXhlGco0S83OGmn
         eRgZIV0APh3x7n35VqLwUnCajSvDs28Ovo2ieDT0YDx7jtjBQn2j3DA9uB+GjKo6wzFR
         /DIMQ80EHvOYfYO15QWwbxhKVqpckXk5G1ufth7YrK7zbKvboHApcQKRyminlselQsId
         QuVN7ecY3Ahcg/F+rbf5mXJ92S/RKZeE8PFxmAdB2U1xd8NO60ZFRyI43AM4ISbAHus6
         OIig==
X-Gm-Message-State: AOJu0YyqlqaVyqNov1h9bR/Heooy+qXUcTB5ExUBqhrKluRr8o1ETLSv
	IN2FJzfi0O8OWheeet63Rmbe0yGKQWhPjvFdwyg=
X-Google-Smtp-Source: AGHT+IGNAQ8OryN2eCj9a9IdXqrXSp8xlj67KgXxcAHwaZ84lBNZyHCQwetFLU7MrImOKm7rgo0rXw==
X-Received: by 2002:aa7:d64b:0:b0:530:a19b:175 with SMTP id v11-20020aa7d64b000000b00530a19b0175mr16270554edr.2.1696936112454;
        Tue, 10 Oct 2023 04:08:32 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i18-20020a50fc12000000b005386541f612sm7460898edr.3.2023.10.10.04.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:08:31 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next 01/10] genetlink: don't merge dumpit split op for different cmds into single iter
Date: Tue, 10 Oct 2023 13:08:20 +0200
Message-ID: <20231010110828.200709-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010110828.200709-1-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Currently, split ops of doit and dumpit are merged into a single iter
item when they are subsequent. However, there is no guarantee that the
dumpit op is for the same cmd as doit op.

Fix this by checking if cmd is the same for both.

Fixes: b8fd60c36a44 ("genetlink: allow families to use split ops directly")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/netlink/genetlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 8315d31b53db..34346a73a0d6 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -225,7 +225,9 @@ static void genl_op_from_split(struct genl_op_iter *iter)
 	}
 
 	if (i + cnt < family->n_split_ops &&
-	    family->split_ops[i + cnt].flags & GENL_CMD_CAP_DUMP) {
+	    family->split_ops[i + cnt].flags & GENL_CMD_CAP_DUMP &&
+	    (!cnt ||
+	     (cnt && family->split_ops[i + cnt].cmd == iter->doit.cmd))) {
 		iter->dumpit = family->split_ops[i + cnt];
 		genl_op_fill_in_reject_policy_split(family, &iter->dumpit);
 		cnt++;
-- 
2.41.0



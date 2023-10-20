Return-Path: <netdev+bounces-42931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2D7D0B74
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529911C20E61
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D250611C99;
	Fri, 20 Oct 2023 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EmdRDMf0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04547111B1
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:21:40 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D291739
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a6190af24aso97300666b.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697793681; x=1698398481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xboRRVpu5R7RrRzW/yXOf5BKGVSXwe/0d1S4FFJYQDE=;
        b=EmdRDMf0WR0B0VU3qlZu66+ErJrelmkqI4hK0XpiJKadra+zePaPaYiuqsYbof0rmW
         XMqht0wvnE9n+NvjEQkJ+R1cvExQ4wxQ3e6lEnm5eQ9kEZxpDg4/Cshg6s/jMeG6APBD
         6RobXQYafAAB1nXYzhUmyLM4AYQVA/8FCdLT9DmsTX6CIUC4/i63dSxV7WMmAtIGI/Y4
         +64v5lmlMwLcZ8V4VtCx0Mf/9zqGj8cHxW7j4ybTVL+OhbGaTfU/8sEsel7YTDNl9i62
         g8+BCXu6/FI66AyaVXgtGWf+ZIqZ/RXDaoWHvCVt2XeLsbnQKzrjLjspCM7xwJgBtG9U
         HEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793681; x=1698398481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xboRRVpu5R7RrRzW/yXOf5BKGVSXwe/0d1S4FFJYQDE=;
        b=WRUdp38/3Oxi8HUtcbLm0t66+OMIZxCzM3jmSQr3s7RN6pfldZM1z0dPhM/jUPdvDn
         kjvTewBhiQoXr3o+Kd4paEaKw9SzlwWCpb/DGmDcUcJHZiDB18OtUpyRIfHHno4GhHZa
         h3Cwd2xOCpW3FKHXMVERPhcE64Urifpfbjlu5V2FMSY8yRO2bNi/IwjQJhh41WUP6fjX
         YvVUtnrYA8npb/zv/MoZ2VlBFACas+jaczaiVX69MK5iNiRwqhrDrxavtsW/Cx9eEcS+
         QOcM1A1OTykDsufNlhCrUSjipFO3K6++TQjMG/C42C56mAUiokXDmbzbxxJ4kYkYeq0X
         oKVg==
X-Gm-Message-State: AOJu0YzqYYvVR/CzhlDwbJadd/vemovwt6TLBJxsOxBIpbOj+xAJmq6Q
	KjwJMwBmi4mIJEy0TRqyXreeYJ0M89lvBoLU2RY=
X-Google-Smtp-Source: AGHT+IE/kutNPcu5r476ooVRJWkgSaDypfu31lMYbxtAiieMZxxUHhDyrsK3skYbWvDMltwKR5QGRw==
X-Received: by 2002:a17:907:60cb:b0:9be:1dbd:552e with SMTP id hv11-20020a17090760cb00b009be1dbd552emr793713ejc.68.1697793681218;
        Fri, 20 Oct 2023 02:21:21 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709063b0100b0099b8234a9fesm1097499ejf.1.2023.10.20.02.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:21:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v2 01/10] genetlink: don't merge dumpit split op for different cmds into single iter
Date: Fri, 20 Oct 2023 11:21:08 +0200
Message-ID: <20231020092117.622431-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020092117.622431-1-jiri@resnulli.us>
References: <20231020092117.622431-1-jiri@resnulli.us>
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



Return-Path: <netdev+bounces-19467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B4275AC9C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037821C20E02
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BC617739;
	Thu, 20 Jul 2023 11:14:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A297C174EB
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:14:00 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D20BE
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:13:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-992acf67388so107314466b.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689851636; x=1690456436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HFayAkK3ZGNt+PHGBSqJcT4IrarmvetwbqO2i9Q0l+s=;
        b=fJBxCPO8e2ZkRwuazlDWxi77pgoryBOB0bhfsemIsUZnE01nzMbNVkV7PyC4OSoEdW
         W09Kq0aDMs+Mll4CNvmbGsMul4yjnWo1iO6SAOEF4fKmDGzAUZfi9McxUJoOgl6b/Bxv
         9PP40sSIZjC0Chn7DZrD1kXWfAg5birX9oNas1vgjvWJUVDF9zhqdkIjOimbLcC+3K8Z
         VnHQSK9D+Nr8TDrXzROOIzA2/AUfhkTpITN2gyVMCdAR8L01EaYSJlaLu63G+v2CYHKK
         xhReIu8zIgwaTK3NrDLbxcBeizT0yVmOE7yVcuCXYG4cWrzHBNtkIiGbit3ta+TjhzYa
         MU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689851636; x=1690456436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFayAkK3ZGNt+PHGBSqJcT4IrarmvetwbqO2i9Q0l+s=;
        b=leIfBqhD/OcFKw4byo49v7xqSc+pYTLRWh+N9Wlgm1Y5oS2xUzzEQWIi96iL2N09xr
         DBYOaO84ofYO9t5ENEYcET3mrT5MfzsrvsL1l6yD/Mk59WYKZU9hP/3u72N3H6QTV03A
         io25pjNjpbeIyGwCcWHLGpbVlNnl7oJoSihKVl2Lr++GJVGV1uAU5j2pHXl3ffvEwlgW
         n75m+cBTRJmDMs/3OtP2X78iw0IhV9I4ofR9OuOmOvi1HfAm2pRZa84yvYmE8UdJdFI9
         WqXe0Yaow16Svo5PX9ph5L+PO8WZUj1CPldnDkgMMgFdbEPDmZu649I9NHNolmNnGeHX
         rdXQ==
X-Gm-Message-State: ABy/qLZWlbjbMQZbN9ev6DCKGfbvV9GB9U9VnFCz00rNNkBCH++8FPSW
	emZ7X2ymta3GhtOIxxZEiiDePO3YdumvzYUy4Nk=
X-Google-Smtp-Source: APBJJlEfdRmswU0FprNl1D2wPgdo2uk3cur8POaXP+poeZQc25upYIvyreeOJ/JCHkb92cXZd2uFSA==
X-Received: by 2002:a17:906:218:b0:993:6382:6e34 with SMTP id 24-20020a170906021800b0099363826e34mr4663547ejd.72.1689851636454;
        Thu, 20 Jul 2023 04:13:56 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h12-20020a170906854c00b0099315454e76sm542149ejy.211.2023.07.20.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:13:55 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com
Subject: [patch net-next] genetlink: add explicit ordering break check for split ops
Date: Thu, 20 Jul 2023 13:13:54 +0200
Message-ID: <20230720111354.562242-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Currently, if cmd in the split ops array is of lower value than the
previous one, genl_validate_ops() continues to do the checks as if
the values are equal. This may result in non-obvious WARN_ON() hit in
these check.

Instead, check the incorrect ordering explicitly and put a WARN_ON()
in case it is broken.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/netlink/genetlink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index a157247a1e45..6bd2ce51271f 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -593,8 +593,12 @@ static int genl_validate_ops(const struct genl_family *family)
 			return -EINVAL;
 
 		/* Check sort order */
-		if (a->cmd < b->cmd)
+		if (a->cmd < b->cmd) {
 			continue;
+		} else if (a->cmd > b->cmd) {
+			WARN_ON(1);
+			return -EINVAL;
+		}
 
 		if (a->internal_flags != b->internal_flags ||
 		    ((a->flags ^ b->flags) & ~(GENL_CMD_CAP_DO |
-- 
2.41.0



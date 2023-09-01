Return-Path: <netdev+bounces-31692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702E078F976
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 10:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CFC2817CF
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 08:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD358BEA;
	Fri,  1 Sep 2023 08:02:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF7881F
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 08:02:36 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BF810D7
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 01:02:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c09673b006so11881605ad.1
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 01:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693555354; x=1694160154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4Bz79owOPrIJb8engDIRsK8iKJM7DfpcYPFo3/4e2I=;
        b=XHRFZWDlbNSYVbme1olkeug9xypO8Ea+DTCRC7Tl0uc7/Z/TM9MKZ/ytnkiJq8g8Cm
         apL15MvNojjfhfDWf9WfdxS9L3ROfyPpI7vfTZqQh/E4kFQ72IOPxZH6CA+rG0umroBL
         k9yQvq64AKUtGytTPafTw8xgtWKLFa1kdX4kEUJdmmB694tYP20ecE8Fj4a180BGp11i
         x3lXGrWgPSbWUq1p6Of9lqWMhzoe2DDhn9XxxeQO+qhuo3q2FIgpRXE+jlC/4ih23fli
         qqwbzISHXQVJy2NZNtjMkzsbrY4uuncUt8dCTM4WaH2HsE3bQviZTGWlflFmjzqGuNNC
         5Aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693555354; x=1694160154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4Bz79owOPrIJb8engDIRsK8iKJM7DfpcYPFo3/4e2I=;
        b=IrOhkImnyWhte1T2zsAqbA89uBklnennMjpfelM8DejMfROfpDah8n1AZGgTyzeCnc
         HGOQbXEJDVxRFwibscCkMuDnAwikfuvb9ivAiMXtRmGIPLfg/TiahdF8GegAmbvOafWz
         zyty8yiIyic2sVAu7P/6FcchEHJP9ZKQ1yEsbZqbtNnB3+rK24TU+70p/9i+OZcv0Bc1
         JqU9+u9v2GU72TCR5iF8WaboZHLiJNu3jnucaX1u7A5FiCFRI5tK2bKAH4I5RL2FZA42
         vYPJw5f7689u9CA0RaKNpNrD1mPx8gq8JvO+cy8lnaSTSy+FphZj6wdiIlnZ9fe7gahn
         FnFw==
X-Gm-Message-State: AOJu0YxLI/UCmtmpPVPVU6Ue1Jpi4BDGQmWrEj6RgnkZqK01BEvcLWvn
	548viQIKNkGvO8l+5RuTta694qJ/N9pQm+jZ
X-Google-Smtp-Source: AGHT+IEU09v9ufXZKqg+Hipa+Nc1n0Qrh/GUBR8bFos9g2cvIsffoyPCNixwlOt0CfB/Aga8B+LfyA==
X-Received: by 2002:a17:902:ab15:b0:1bf:148b:58ff with SMTP id ik21-20020a170902ab1500b001bf148b58ffmr1827866plb.69.1693555354095;
        Fri, 01 Sep 2023 01:02:34 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902b40600b001bf10059251sm2408012plr.239.2023.09.01.01.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 01:02:31 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH iproute2] iplink_bridge: fix incorrect root id dump
Date: Fri,  1 Sep 2023 16:02:26 +0800
Message-ID: <20230901080226.424931-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix the typo when dump root_id.

Fixes: 70dfb0b8836d ("iplink: bridge: export bridge_id and designated_root")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 ip/iplink_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 7e4e62c81c0c..462075295308 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -499,7 +499,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_BR_ROOT_ID]) {
 		char root_id[32];
 
-		br_dump_bridge_id(RTA_DATA(tb[IFLA_BR_BRIDGE_ID]), root_id,
+		br_dump_bridge_id(RTA_DATA(tb[IFLA_BR_ROOT_ID]), root_id,
 				  sizeof(root_id));
 		print_string(PRINT_ANY,
 			     "root_id",
-- 
2.41.0



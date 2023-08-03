Return-Path: <netdev+bounces-23912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE876E219
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C928B1C21496
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 07:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5710113AE1;
	Thu,  3 Aug 2023 07:53:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B018125A7
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:53:37 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241BC30FA
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 00:53:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d13e11bb9ecso807185276.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 00:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691049215; x=1691654015;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/gVyBjjwCgArTjju3DiOXpFoM9IcmuTSEzVFwUclwEE=;
        b=Xt4mxg6/SkCTPJYnERcSwExJhfhUU19g5ACqV2pZHHUrM6giP4U880jv78IH0W5gB4
         eg5yMZv1s+vacTS18sKX+EnAPaRyBNkYF9A8kEn1Oa2B0LKflzC7V5cqs+WJ+9ZeRVPH
         OIqJ3RUhIQHWqh2Ion3Watdnzxj+6Qb4QnB9rEBWGcWRMbe19k5ncJDQt74j2hWMX4E0
         miXgmepn7ZIkTNsrx4WzrrIhhd+4QaX7tA9GBTdl8P3hD6IZw5iqaLwy6t+aznGgo4Hc
         iiSQWiYIv0tzUO7lt9ze5inuQy0nVmfe4e2qDs4tni1XRvMQZYsxByJC2RzjrK0XWnKN
         4lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691049215; x=1691654015;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gVyBjjwCgArTjju3DiOXpFoM9IcmuTSEzVFwUclwEE=;
        b=lw3IBdy0kIE7HiLvJdygINWyVBnG0o8Yrqd/Vu4C8wpav7HbVqdnEzh/XrAD4aET/p
         EZttqCWofZfdH/jN2zWrzpCOr0za8Pof9Fa5q55+hvanIADl1JhmFGDLnvNd79tSV6FQ
         LgL2HCqBYyE00jEhXQR/CpwGT3SzuvP9mZq32iXUzYHnQbeEJkCC3VN+t2kPNAagAMzU
         RcZ0HW7wQdWMahnB21Umrek1QRYDwpkLpWOmbV/jJ8sD1FaOGAbSBQq9Ekv5FXUnbUTW
         8UJAsVLJVQI9NFimSDWmuCYNQrWywAJwutI8dHsBloJekEqyFOiwRBIPW9ca/S56AsAW
         0AvQ==
X-Gm-Message-State: ABy/qLbenw49dg2saMlseduNsUIY/UZuT3f8sy2uitx+zK+JDTgs+c1d
	2ZLdp+uZBHO9pvR9iQ6TBp/r2SS3tm84TA==
X-Google-Smtp-Source: APBJJlFmibGB312r44Hu/NJRdNaggwOBq9e+a1rCUrW81XIrxCrttLHuIjpSx26S5f9e8MhumDlOtFUaLFLBcg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1616:b0:d12:d6e4:a08e with SMTP
 id bw22-20020a056902161600b00d12d6e4a08emr157059ybb.5.1691049215428; Thu, 03
 Aug 2023 00:53:35 -0700 (PDT)
Date: Thu,  3 Aug 2023 07:53:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230803075334.2321561-1-edumazet@google.com>
Subject: [PATCH net-next] tcp/dccp: cache line align inet_hashinfo
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I have seen tcp_hashinfo starting at a non optimal location,
forcing input handlers to pull two cache lines instead of one,
and sharing a cache line that was dirtied more than necessary:

ffffffff83680600 b tcp_orphan_timer
ffffffff83680628 b tcp_orphan_cache
ffffffff8368062c b tcp_enable_tx_delay.__tcp_tx_delay_enabled
ffffffff83680630 B tcp_hashinfo
ffffffff83680680 b tcp_cong_list_lock

After this patch, ehash, ehash_locks, ehash_mask and ehash_locks_mask
are located in a read-only cache line.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_hashtables.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 99bd823e97f624e37cf3abb8ac0ec7eef4552b61..74399d20b2184945f2b39bf3dfedb3ae63b500f7 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -177,7 +177,7 @@ struct inet_hashinfo {
 	struct inet_listen_hashbucket	*lhash2;
 
 	bool				pernet;
-};
+} ____cacheline_aligned_in_smp;
 
 static inline struct inet_hashinfo *tcp_or_dccp_get_hashinfo(const struct sock *sk)
 {
-- 
2.41.0.640.ga95def55d0-goog



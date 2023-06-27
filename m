Return-Path: <netdev+bounces-14139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A073F307
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 05:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016A91C20A61
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 03:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B9EBF;
	Tue, 27 Jun 2023 03:54:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B9EA1
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 03:54:45 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5E5D7
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 20:54:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bfebb1beeccso5371373276.2
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 20:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687838083; x=1690430083;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5NqrAkYOF+2uej9g+BU5AkfiRofe8bvnAoQiVDzakG0=;
        b=acNF5eHJmSD2rWvo55kLK3rZLqlsySWJ6JkHGjVyaV7fghuBl1OPaQbY4HR9D2+8Mq
         UfoVojnIXmyySmWRLvsUNnzxbDMyDJ03ClmaZJs+IFgPi5qx7+PVi5BAjaPx2+Lh519R
         3MU39QC3j5favwzdoPprVPhau2EIiUnJriz7qQpudBYX+skKF2UhtFsgJ08UlpGWeV/2
         m6u0IF05vd5Ei8E8Nqc/FcxueBs8kbylMdcvxRdHSmrqemYCUUSVgiB86RhNugRyMQm4
         XgBqFN63+2yyJMZ5VZPn96q5kJFBgDohA4GmDE3c+oIePhqEO+IU/KAJ7N9rD6t95Y8K
         oR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687838083; x=1690430083;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NqrAkYOF+2uej9g+BU5AkfiRofe8bvnAoQiVDzakG0=;
        b=Mg/LQo6jg2j9iIcSO7TSM2zVG0fEocP3x3WRJ3VK5jzKaQwUcB4DzUHO2kWK4zD36z
         IIKwhcrC+zdzjFAnLyZuV8QW7zVCzPZTaY3NtjV2E7djbskJ8lD4B6ZMTG7DqsMBeNYp
         f6Ucbgs5F0hY5+xlGLKqI4HRAyeiIhPg/VtfRZuqAx1vE4NjulpUyo4EGUpOo/oC0EKG
         hrSvGok8YMIug0W+3/B7lJp82kUfIdhzFt9OiYvZ4jQdDnj+KxNg39sB8orb+iYDoxoi
         uE2OF5TX5LnHPKw5cIeG8hvi+H0MBf7W9x87+Zl8ccdMcnXLHp1gGZ5InPIlYIzS+8B3
         tGTw==
X-Gm-Message-State: AC+VfDxJgTdT5svzzPUwkoBVxXd/2zTKS+RsOKEK2RoE24eaoSXMQuf5
	FOFPVSYidcyHG/YIuAJiajThZsDLMNYHdfVboNwA+canJ6swOUVGlx1dgCaAYcgQN3gfB1XdzI+
	1b2vKqiR1y1+1huzd8s6xB1KJAl/9xc9IU4Bl5PBUO8OLIunQuC3qV6D7sBBk5WcR
X-Google-Smtp-Source: ACHHUZ5hGoGT9Z8792Ziu826jx/RJUM4kY2IMM0W3m/uqcPkbNdf6WmDXhCS3QEMEwZdHa8MStwNnrRorkjn
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a25:34cf:0:b0:bcf:7f0b:e1d0 with SMTP id
 b198-20020a2534cf000000b00bcf7f0be1d0mr6854277yba.0.1687838083386; Mon, 26
 Jun 2023 20:54:43 -0700 (PDT)
Date: Tue, 27 Jun 2023 03:54:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230627035432.1296760-1-moritzf@google.com>
Subject: [PATCH net-next] net: lan743x: Simplify comparison
From: Moritz Fischer <moritzf@google.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net, bryan.whitehead@microchip.com, 
	UNGLinuxDriver@microchip.com, mdf@kernel.org, 
	Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simplify comparison, no functional changes.

Cc: Bryan Whitehead <bryan.whitehead@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 61eadc0bca8b..a36f6369f132 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -164,7 +164,7 @@ static int lan743x_csr_wait_for_bit(struct lan743x_adapter *adapter,
 	u32 data;
 
 	return readx_poll_timeout(LAN743X_CSR_READ_OP, offset, data,
-				  target_value == ((data & bit_mask) ? 1 : 0),
+				  target_value == !!(data & bit_mask),
 				  usleep_max, usleep_min * count);
 }
 
-- 
2.41.0.178.g377b9f9a00-goog



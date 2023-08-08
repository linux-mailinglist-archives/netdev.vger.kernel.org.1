Return-Path: <netdev+bounces-25579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2BB774D3F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9751C20F9B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AE2174D4;
	Tue,  8 Aug 2023 21:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725C174C5
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:44:36 +0000 (UTC)
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 14:44:32 PDT
Received: from authsmtp.register.it (authsmtp19.register.it [81.88.48.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EAEE72
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:44:32 -0700 (PDT)
Received: from localhost.localdomain ([213.230.62.249])
	by cmsmtp with ESMTPSA
	id TUUDqYXukCJCaTUUEqEu4t; Tue, 08 Aug 2023 23:43:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schroetersa.ch;
	s=key_mmumrc8kf9; t=1691531010;
	bh=zV4X3zC1bPRXds5czW6LbbWAuj9Sc1c0deqWSTzZD9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eJhyAy428t3TQGeRi1vKhItIb//ayvjItKTIGNhRcrpwhWb7OlKNV5KMqGXSUS9sP
	 vrx+mw27nxvcXUoWeqp7RK3rXdauhlg6m970+iuEyaSovSO3oCQmJWTgZiJKMLl3FK
	 J/aiyYV1F/AHWn//AvxUcUAZg4ePmXPEyLHPHi7zPuqR80t6XYPudZdSmLFwGNRN5K
	 Sdmxe2Jxn9xLxcT/2oc+uIJpBAf+wcVF+mteDWn38sv0dYttIX+vlFjWMsn6LjmRrp
	 qkUFa4EAkWC+RObsCdrjXUV1Qys7qiXdroxMkEh7989FS/u3z9VTnSo9rm/U9+YyvD
	 HMXL8hWqfMBeg==
X-Rid: mathieu@schroetersa.ch@213.230.62.249
From: Mathieu Schroeter <mathieu@schroetersa.ch>
To: netdev@vger.kernel.org
Cc: Mathieu Schroeter <mathieu@schroetersa.ch>
Subject: [PATCH iproute2-next 4/4] ss: print unix socket "ports" as unsigned int (inode)
Date: Tue,  8 Aug 2023 23:42:58 +0200
Message-Id: <20230808214258.975440-4-mathieu@schroetersa.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808214258.975440-1-mathieu@schroetersa.ch>
References: <20230808214258.975440-1-mathieu@schroetersa.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIeu2yRNlD6HCRfYz+sUir1zNW5O61EciCMSD8red2oD4n7rVPf5VsQAwCWV8Nhlg50/Dus8SP4EjaEEsBxih9GP6zB/IMlEwSOVvsJYGDjfKDxn1s/H
 qS+XJmjJesFiUDpl3YBINhzGsexTGCKAqz7K8YEUz6/MgOAVYvb1nO25Me8DdnF+MDd0LHhOwfPdav2WTl276KHNLSHkje7+xAxBH2YL7+OlDiEuHqW6YYal
 wWx2WDA5b/RdM+PXOzX/ZQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Mathieu Schroeter <mathieu@schroetersa.ch>
---
 misc/ss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index baa83514..13b2523f 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -4073,9 +4073,9 @@ static void unix_stats_print(struct sockstat *s, struct filter *f)
 	sock_state_print(s);
 
 	sock_addr_print(s->name ?: "*", " ",
-			int_to_str(s->lport, port_name), NULL);
+			uint_to_str(s->lport, port_name), NULL);
 	sock_addr_print(s->peer_name ?: "*", " ",
-			int_to_str(s->rport, port_name), NULL);
+			uint_to_str(s->rport, port_name), NULL);
 
 	proc_ctx_print(s);
 }
-- 
2.39.2



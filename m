Return-Path: <netdev+bounces-19173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019C7759E15
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4871C21197
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BDA22EE3;
	Wed, 19 Jul 2023 19:00:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645521D28
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:03 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A4171E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 8184FD8FFE;
	Wed, 19 Jul 2023 20:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792736; bh=QHdF6nFR5QavdbDq1j5d+201CzoUT2/4yDKf18hdYG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HfgOO2owIBdaUm9H2HnMaA6mnbkDPU010wIY4G+PI/sIaFbi8PbNEl7+lkbDRn6pd
	 uAKp6Eh2rGxAFnA/axPt6yjnwz7r3mUP0IbO5ZFyJdTJj4l9YYuvUKod4CADXoKQqk
	 +HbBrSwaKMjZwMvQN0ZhG5MEpOF8HxvX0Ffjhy23RMHfm2IOrr/K4vodLwAP635g8c
	 FwhjDp/eHHn8YcwYw3URuqMZP0aHlHbXjXvTn378CCbvJT5NKEj6cAN9Pnw6YqF/MC
	 2rwJq9xCrdoVanR5Hp09mwq6YuzIfA53bCua00x2jNjG1vOQKLvqVZDfR/+76MRQ4f
	 8EAbkl6rOr26w==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 03/22] include/utils.h: Use /usr/lib/iproute2 as default CONF_USR_DIR
Date: Wed, 19 Jul 2023 20:50:47 +0200
Message-Id: <20230719185106.17614-4-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719185106.17614-1-gioele@svario.it>
References: <20230719185106.17614-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Gioele Barabucci <gioele@svario.it>
---
 include/utils.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/utils.h b/include/utils.h
index d3bf49bf..3159dbab 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -38,6 +38,9 @@ extern int numeric;
 extern bool do_all;
 extern int echo_request;
 
+#ifndef CONF_USR_DIR
+#define CONF_USR_DIR "/usr/lib/iproute2"
+#endif
 #ifndef CONF_ETC_DIR
 #define CONF_ETC_DIR "/etc/iproute2"
 #endif
-- 
2.39.2



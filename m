Return-Path: <netdev+bounces-47647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AA47EAE31
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85531F242DA
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8B168D1;
	Tue, 14 Nov 2023 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6670154A8
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:42:11 +0000 (UTC)
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16303130;
	Tue, 14 Nov 2023 02:42:09 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4SV2t41ycwzvjkp; Tue, 14 Nov 2023 11:42:03 +0100 (CET)
From: Tobias Klauser <tklauser@distanz.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] indirect_call_wrapper: Fix typo in INDIRECT_CALL_$NR kerneldoc
Date: Tue, 14 Nov 2023 11:42:02 +0100
Message-Id: <20231114104202.4680-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Fix a small typo in the kerneldoc comment of the INDIRECT_CALL_$NR
macro.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/linux/indirect_call_wrapper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index c1c76a70a6ce..adb83a42a6b9 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -11,7 +11,7 @@
  *  @__VA_ARGS__: arguments for @f
  *
  * Avoid retpoline overhead for known builtin, checking @f vs each of them and
- * eventually invoking directly the builtin function. The functions are check
+ * eventually invoking directly the builtin function. The functions are checked
  * in the given order. Fallback to the indirect call.
  */
 #define INDIRECT_CALL_1(f, f1, ...)					\
-- 
2.42.0



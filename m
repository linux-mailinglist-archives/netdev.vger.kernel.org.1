Return-Path: <netdev+bounces-43320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F33DE7D25DC
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 22:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4BDB20DEC
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE500134DF;
	Sun, 22 Oct 2023 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A301094D
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 20:25:53 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C947F7
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 13:25:51 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: osmocom-net-gprs@lists.osmocom.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	laforge@osmocom.org,
	laforge@gnumonks.org
Subject: [PATCH net 1/2] gtp: uapi: fix GTPA_MAX
Date: Sun, 22 Oct 2023 22:25:17 +0200
Message-Id: <20231022202519.659526-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231022202519.659526-1-pablo@netfilter.org>
References: <20231022202519.659526-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subtract one to __GTPA_MAX, otherwise GTPA_MAX is off by 2.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/uapi/linux/gtp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/gtp.h b/include/uapi/linux/gtp.h
index 2f61298a7b77..3dcdb9e33cba 100644
--- a/include/uapi/linux/gtp.h
+++ b/include/uapi/linux/gtp.h
@@ -33,6 +33,6 @@ enum gtp_attrs {
 	GTPA_PAD,
 	__GTPA_MAX,
 };
-#define GTPA_MAX (__GTPA_MAX + 1)
+#define GTPA_MAX (__GTPA_MAX - 1)
 
 #endif /* _UAPI_LINUX_GTP_H_ */
-- 
2.30.2



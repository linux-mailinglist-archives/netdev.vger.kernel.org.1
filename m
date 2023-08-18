Return-Path: <netdev+bounces-28969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3182E781479
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8263282088
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9226C1AA90;
	Fri, 18 Aug 2023 20:58:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312918B01
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:58:01 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8CB3ABA
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:57:58 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D032D1C0004;
	Fri, 18 Aug 2023 20:57:56 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: add entry for macsec
Date: Fri, 18 Aug 2023 22:57:49 +0200
Message-Id: <7824cdb3ca9162719d3869390de45a2fc7a3c73d.1692391971.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub asked if I'd be willing to be the maintainer of the macsec code
and review the driver code adding macsec offload, so let's add the
corresponding entry.

The keyword lines are meant to catch selftests and patches adding HW
offload support to other drivers.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4227aac551f6..4171d3a102a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14802,6 +14802,16 @@ F:	net/netfilter/xt_CONNSECMARK.c
 F:	net/netfilter/xt_SECMARK.c
 F:	net/netlabel/
 
+NETWORKING [MACSEC]
+M:	Sabrina Dubroca <sd@queasysnail.net>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/macsec.c
+F:	include/net/macsec.h
+F:	include/uapi/linux/if_macsec.h
+K:	macsec
+K:	\bmdo_
+
 NETWORKING [MPTCP]
 M:	Matthieu Baerts <matthieu.baerts@tessares.net>
 M:	Mat Martineau <martineau@kernel.org>
-- 
2.40.1



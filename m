Return-Path: <netdev+bounces-44095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D493F7D6181
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114951C20C91
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D675014AA4;
	Wed, 25 Oct 2023 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC3125B3
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 06:17:05 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0791DA;
	Tue, 24 Oct 2023 23:17:03 -0700 (PDT)
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id UGP00158;
        Wed, 25 Oct 2023 14:16:58 +0800
Received: from localhost.localdomain.com (10.73.46.69) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 14:16:57 +0800
From: Deming Wang <wangdeming@inspur.com>
To: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Deming Wang
	<wangdeming@inspur.com>
Subject: [PATCH] net: ipv6: fix typo in comments
Date: Wed, 25 Oct 2023 02:16:56 -0400
Message-ID: <20231025061656.2149-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.73.46.69]
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201619.home.langchao.com (10.100.2.19)
tUid: 20231025141658230116b21a149a2be55e935bab62d149
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The word "advertize" should be replaced by "advertise".

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 net/ipv6/esp6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index e023d29e919c..2cc1a45742d8 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -833,7 +833,7 @@ int esp6_input_done2(struct sk_buff *skb, int err)
 
 		/*
 		 * 1) if the NAT-T peer's IP or port changed then
-		 *    advertize the change to the keying daemon.
+		 *    advertise the change to the keying daemon.
 		 *    This is an inbound SA, so just compare
 		 *    SRC ports.
 		 */
-- 
2.31.1



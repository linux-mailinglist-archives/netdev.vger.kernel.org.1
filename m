Return-Path: <netdev+bounces-44094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657B97D617F
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5FE9B20BCB
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 06:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC4515486;
	Wed, 25 Oct 2023 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A0C8C0
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 06:15:49 +0000 (UTC)
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 23:15:45 PDT
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2631A6;
	Tue, 24 Oct 2023 23:15:45 -0700 (PDT)
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id UGN00136;
        Wed, 25 Oct 2023 14:14:36 +0800
Received: from localhost.localdomain.com (10.73.46.69) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 14:14:35 +0800
From: Deming Wang <wangdeming@inspur.com>
To: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Deming Wang
	<wangdeming@inspur.com>
Subject: [PATCH] net: ipv4: fix typo in comments
Date: Wed, 25 Oct 2023 02:14:34 -0400
Message-ID: <20231025061434.2039-1-wangdeming@inspur.com>
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
tUid: 202310251414369e24748a32205f9d3c1998e258a66a8f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The word "advertize" should be replaced by "advertise".

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 net/ipv4/esp4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d18f0f092fe7..4ccfc104f13a 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -786,7 +786,7 @@ int esp_input_done2(struct sk_buff *skb, int err)
 
 		/*
 		 * 1) if the NAT-T peer's IP or port changed then
-		 *    advertize the change to the keying daemon.
+		 *    advertise the change to the keying daemon.
 		 *    This is an inbound SA, so just compare
 		 *    SRC ports.
 		 */
-- 
2.31.1



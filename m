Return-Path: <netdev+bounces-24293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20F76FA77
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 08:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8142824C6
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B58746B;
	Fri,  4 Aug 2023 06:51:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93636ADF
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 06:51:03 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673FD49C6;
	Thu,  3 Aug 2023 23:50:43 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4RHGKZ4Gt0z9t1S;
	Fri,  4 Aug 2023 08:39:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TG1kAdhxpPBG; Fri,  4 Aug 2023 08:39:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4RHGKX6rxgz9t1C;
	Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E36A58B77A;
	Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ttKQWALnJBz9; Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8498B8B776;
	Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
	by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3746daip629331
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 4 Aug 2023 08:39:36 +0200
Received: (from chleroy@localhost)
	by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3746da8c629330;
	Fri, 4 Aug 2023 08:39:36 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v1 01/10] net: fs_enet: Remove set but not used variable
Date: Fri,  4 Aug 2023 08:39:25 +0200
Message-ID: <90b72c1708bb8ba2b7a1a688e8259e428968364d.1691130766.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691130766.git.christophe.leroy@csgroup.eu>
References: <cover.1691130766.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691131163; l=1161; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=1XAaJLMONzSd2iIwcw4mWmUDcjud5RsErtzfQSfgx6Y=; b=kaB3ePERc6JGTsox6b3cCCsFm5RyY72Hu3sJlf2kb8fLg5vkYR01jBOmHZ3n96B1n3+XX37+L ulz+sjS4IVVBPYXqO7MVQZ82QprxSTWHslsN8wlizoc7H/B7jQ8fbHd
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

  CC      drivers/net/ethernet/freescale/fs_enet/fs_enet-main.o
drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c: In function 'fs_enet_interrupt':
drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c:321:40: warning: variable 'fpi' set but not used [-Wunused-but-set-variable]

Remove that variable.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index f9f5b28cc72e..a6dfc8807d3d 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -318,14 +318,12 @@ fs_enet_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct fs_enet_private *fep;
-	const struct fs_platform_info *fpi;
 	u32 int_events;
 	u32 int_clr_events;
 	int nr, napi_ok;
 	int handled;
 
 	fep = netdev_priv(dev);
-	fpi = fep->fpi;
 
 	nr = 0;
 	while ((int_events = (*fep->ops->get_int_events)(dev)) != 0) {
-- 
2.41.0



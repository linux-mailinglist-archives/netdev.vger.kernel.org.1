Return-Path: <netdev+bounces-14389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7CC74088B
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 04:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A891C281212
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 02:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF1E15B6;
	Wed, 28 Jun 2023 02:44:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FFA7E1
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 02:44:17 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 8CF7726B3;
	Tue, 27 Jun 2023 19:44:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 513456032EB52;
	Wed, 28 Jun 2023 10:44:11 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: wuych <yunchuan@nfschina.com>
To: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ansuelsmth@gmail.com,
	yunchuan@nfschina.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next 02/10] net: dsa: qca8k: remove unnecessary (void*) conversions
Date: Wed, 28 Jun 2023 10:44:09 +0800
Message-Id: <20230628024409.1440022-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pointer variables of void * type do not require type cast.

Signed-off-by: wuych <yunchuan@nfschina.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c   | 2 +-
 drivers/net/dsa/qca/qca8k-common.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 6d5ac7588a69..dee7b6579916 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1756,7 +1756,7 @@ static int qca8k_connect_tag_protocol(struct dsa_switch *ds,
 static int
 qca8k_setup(struct dsa_switch *ds)
 {
-	struct qca8k_priv *priv = (struct qca8k_priv *)ds->priv;
+	struct qca8k_priv *priv = ds->priv;
 	int cpu_port, ret, i;
 	u32 mask;
 
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 96773e432558..8c2dc0e48ff4 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -760,7 +760,7 @@ int qca8k_port_fdb_add(struct dsa_switch *ds, int port,
 		       const unsigned char *addr, u16 vid,
 		       struct dsa_db db)
 {
-	struct qca8k_priv *priv = (struct qca8k_priv *)ds->priv;
+	struct qca8k_priv *priv = ds->priv;
 	u16 port_mask = BIT(port);
 
 	return qca8k_port_fdb_insert(priv, addr, port_mask, vid);
@@ -770,7 +770,7 @@ int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
 		       const unsigned char *addr, u16 vid,
 		       struct dsa_db db)
 {
-	struct qca8k_priv *priv = (struct qca8k_priv *)ds->priv;
+	struct qca8k_priv *priv = ds->priv;
 	u16 port_mask = BIT(port);
 
 	if (!vid)
@@ -782,7 +782,7 @@ int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
 int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
 			dsa_fdb_dump_cb_t *cb, void *data)
 {
-	struct qca8k_priv *priv = (struct qca8k_priv *)ds->priv;
+	struct qca8k_priv *priv = ds->priv;
 	struct qca8k_fdb _fdb = { 0 };
 	int cnt = QCA8K_NUM_FDB_RECORDS;
 	bool is_static;
-- 
2.30.2



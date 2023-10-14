Return-Path: <netdev+bounces-40957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA67C92F9
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 08:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D69282C6A
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 06:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA315B3;
	Sat, 14 Oct 2023 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ILrQ4XJb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8E5221
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 06:35:07 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F42CBF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 23:35:03 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id rYEiqpnupvhM3rYEiqYMnU; Sat, 14 Oct 2023 08:35:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1697265301;
	bh=CxADXXhhxjM3tj/eg2DX7kLfA3AdAqKP4iJHaVmLDhs=;
	h=From:To:Cc:Subject:Date;
	b=ILrQ4XJbS8aVq6H2ZU6HW0E5LFiW+PZDIamMUNxW2ttR9mqFi48qE2Kkzf2egfDsQ
	 l+RoM4OHVWa9Lv7u5o/qSMUVL4Romq48Z9BfW43m0SczUedDrNW1bXX2kwEOUnRK9P
	 0r3hrsp/tYGbCn3ekbTAXnyu40mqE2oEBNLiPsfa3MANvqrrNiHJfSNRidlNvfFEoc
	 4U1X+13yFgBcoWJNIg07jP5b6/d/xLQRTRCmX0B8xNj+gfKYa9dtsg0jK3mdFm0lu3
	 GfPjdxZ4jMTs+PQBozZx/Zg7GhCmnshc9xkBcSl73W/DfkR2zYNnR/1HE7zleI6WNb
	 yjVWG1rGushcA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Oct 2023 08:35:01 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org,
	dev@openvswitch.org
Subject: [PATCH v2 1/2] net: openvswitch: Use struct_size()
Date: Sat, 14 Oct 2023 08:34:52 +0200
Message-Id: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use struct_size() instead of hand writing it.
This is less verbose and more robust.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: No change

v1: https://lore.kernel.org/all/8be59c9e06fca8eff2f264abb4c2f74db0b19a9e.1696156198.git.christophe.jaillet@wanadoo.fr/


This is IMHO more readable, even if not perfect.

However (untested):
+	new = kzalloc(size_add(struct_size(new, masks, size),
			       size_mul(sizeof(u64), size)), GFP_KERNEL);
looks completely unreadable to me.
---
 net/openvswitch/flow_table.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 4f3b1798e0b2..d108ae0bd0ee 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -220,16 +220,13 @@ static struct mask_array *tbl_mask_array_alloc(int size)
 	struct mask_array *new;
 
 	size = max(MASK_ARRAY_SIZE_MIN, size);
-	new = kzalloc(sizeof(struct mask_array) +
-		      sizeof(struct sw_flow_mask *) * size +
+	new = kzalloc(struct_size(new, masks, size) +
 		      sizeof(u64) * size, GFP_KERNEL);
 	if (!new)
 		return NULL;
 
 	new->masks_usage_zero_cntr = (u64 *)((u8 *)new +
-					     sizeof(struct mask_array) +
-					     sizeof(struct sw_flow_mask *) *
-					     size);
+					     struct_size(new, masks, size));
 
 	new->masks_usage_stats = __alloc_percpu(sizeof(struct mask_array_stats) +
 						sizeof(u64) * size,
-- 
2.34.1



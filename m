Return-Path: <netdev+bounces-42948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C7A7D0BC5
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F2BB214F4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A192612E63;
	Fri, 20 Oct 2023 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B89125BE
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:32:24 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8C1AE;
	Fri, 20 Oct 2023 02:32:21 -0700 (PDT)
X-UUID: 7372c2f1efc747649b42c9706fd9883d-20231020
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:5f69af12-227d-4215-97fe-4405c40a8111,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.32,REQID:5f69af12-227d-4215-97fe-4405c40a8111,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5f78ec9,CLOUDID:b0a61dd7-04a0-4e50-8742-3543eab8cb8e,B
	ulkID:231020172356YAPC1UE8,BulkQuantity:2,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 7372c2f1efc747649b42c9706fd9883d-20231020
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.171)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 785927246; Fri, 20 Oct 2023 17:32:07 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	mokuno@sm.sony.co.jp,
	linville@tuxdriver.com,
	dcbw@redhat.com,
	jeff@garzik.org
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kunwu.chan@hotmail.com,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] treewide: Spelling fix in comment
Date: Fri, 20 Oct 2023 17:31:56 +0800
Message-Id: <20231020093156.538856-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reques -> request

Fixes: 09dde54c6a69 ("PS3: gelic: Add wireless support for PS3")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
index dc14a66583ff..44488c153ea2 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
@@ -1217,7 +1217,7 @@ static int gelic_wl_set_encodeext(struct net_device *netdev,
 		key_index = wl->current_key;
 
 	if (!enc->length && (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)) {
-		/* reques to change default key index */
+		/* request to change default key index */
 		pr_debug("%s: request to change default key to %d\n",
 			 __func__, key_index);
 		wl->current_key = key_index;
-- 
2.34.1



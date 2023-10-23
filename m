Return-Path: <netdev+bounces-43347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DAA7D2A90
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C26E1C20846
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 06:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDDF63C0;
	Mon, 23 Oct 2023 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE473FE0
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 06:38:26 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9B8D68;
	Sun, 22 Oct 2023 23:38:24 -0700 (PDT)
X-UUID: 3ce18d765a4d4f1ba8999da3adbde13b-20231023
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e6e40306-f6ec-43f9-b451-b5bb02d8a100,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.32,REQID:e6e40306-f6ec-43f9-b451-b5bb02d8a100,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:5f78ec9,CLOUDID:75b3a6fb-4a48-46e2-b946-12f04f20af8c,B
	ulkID:231023143821WP6X8U6D,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 3ce18d765a4d4f1ba8999da3adbde13b-20231023
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.171)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1072203218; Mon, 23 Oct 2023 14:38:21 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: isdn@linux-pingi.de,
	kuba@kernel.org,
	yangyingliang@huawei.com,
	alexanderduyck@fb.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kunwu.chan@hotmail.com,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] isdn: mISDN: hfcsusb: Spelling fix in comment
Date: Mon, 23 Oct 2023 14:37:58 +0800
Message-Id: <20231023063758.719718-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

protocoll -> protocol

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/isdn/hardware/mISDN/hfcsusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index 1efd17979f24..b82b89888a5e 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -678,7 +678,7 @@ ph_state(struct dchannel *dch)
 }
 
 /*
- * disable/enable BChannel for desired protocoll
+ * disable/enable BChannel for desired protocol
  */
 static int
 hfcsusb_setup_bch(struct bchannel *bch, int protocol)
-- 
2.34.1



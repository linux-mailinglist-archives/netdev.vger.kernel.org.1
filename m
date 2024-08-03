Return-Path: <netdev+bounces-115492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE123946998
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 14:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B52CB211F2
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 12:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2696914EC40;
	Sat,  3 Aug 2024 12:19:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC1847B;
	Sat,  3 Aug 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722687580; cv=none; b=R3zzjy57lDkeLHZNvceTcM5cTsNV/YnuSsGOcU5PhW+hSsxNp8e7lDiTBhJW1udIC72gfqgJYbBMXlwjFpkIPHPmV5/VUsZe1Q0Xa7KbC91gaJgr75QF4/3CcD+dfR9NH7Ti/7mEbs95iF+6yo/8UgynU22XsLUcNT1j+CzfvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722687580; c=relaxed/simple;
	bh=1uJVjt9ox1mq+Lb0esCmskltSgR6X5424vQCih3hGZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S4gRNN4L0qZlrWcouNqxHOd3fpldRSQUp3B4lvDrxXv27q88PX8xGLIUgT6VNcp0EUVgdLAO+g0HPgBLue3Ayy2xrtozrd996m1qyyAeZGqdQAajeRHX7wLwr0V55rvb3Nm6f9mdR27WYCXK3DBgQS5g8XHziKrsz2hdwq9Mdgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9d939956519211efa216b1d71e6e1362-20240803
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:1f96caaa-2d9d-4edf-ae7b-8bd34a2482b2,IP:10,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.1.38,REQID:1f96caaa-2d9d-4edf-ae7b-8bd34a2482b2,IP:10,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:82c5f88,CLOUDID:1166d7aa1000283c867092886f709c7a,BulkI
	D:2408032006396MYWMXW9,BulkQuantity:1,Recheck:0,SF:43|74|66|38|23|72|19|10
	2,TC:nil,Content:0,EDM:1,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 9d939956519211efa216b1d71e6e1362-20240803
X-User: zhanghao1@kylinos.cn
Received: from pve.sebastian [(118.250.1.11)] by mailgw.kylinos.cn
	(envelope-from <zhanghao1@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1779692581; Sat, 03 Aug 2024 20:19:22 +0800
From: zhanghao <zhanghao1@kylinos.cn>
To: bongsu.jeon@samsung.com,
	krzk@kernel.org
Cc: syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	zhanghao <zhanghao1@kylinos.cn>
Subject: [PATCH] nfc: nci: Fix uninit-value in nci_rx_work()
Date: Sat,  3 Aug 2024 20:18:17 +0800
Message-Id: <20240803121817.383567-1-zhanghao1@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e624e6c3e777 ("nfc: Add a virtual nci device driver")
calls alloc_skb() with GFP_KERNEL as the argument flags.The
allocated heap memory was not initialized.This causes KMSAN
to detect an uninitialized value.

Reported-by: syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3da70a0abd7f5765b6ea
Fixes: e624e6c3e777 ("nfc: Add a virtual nci device driver")
Link: https://lore.kernel.org/all/000000000000747dd6061a974686@google.com/T/
Signed-off-by: zhanghao <zhanghao1@kylinos.cn>
---
 drivers/nfc/virtual_ncidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index 6b89d596ba9a..ae1592db131e 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -117,7 +117,7 @@ static ssize_t virtual_ncidev_write(struct file *file,
 	struct virtual_nci_dev *vdev = file->private_data;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(count, GFP_KERNEL);
+	skb = alloc_skb(count, GFP_KERNEL|__GFP_ZERO);
 	if (!skb)
 		return -ENOMEM;
 

base-commit: 17712b7ea0756799635ba159cc773082230ed028
-- 
2.39.2



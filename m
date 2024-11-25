Return-Path: <netdev+bounces-147165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150469D7B73
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 07:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB32D281DF3
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 06:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEEF7868B;
	Mon, 25 Nov 2024 06:09:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BDF364D6
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732514973; cv=none; b=jUEHSFq/P3mmo+gkIbbNNBXQmLLfNAMmvoEOgx0FaOHxnqiUQkY/XjOuZm0gsHnrHv6CVjKWM3onYp5JxduWlf6mulVA8WpLldo2KJaU6Pfa43WaJGSCH2rhoI63tBF7qc6+0FXu3SPCrVl/4K2abevhkeK6zmTlhIbORgIrnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732514973; c=relaxed/simple;
	bh=1roafFstgRTcsPZzIy3YVauKEPJ6+J+MhxMfLyz1iqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IfL2UogT1SD0qM+IKf+dOpo8vcyFwPVbe14KHOEsGFN09kQiW6hBojw3NOxhu3KGzxFnx7B9vJVR5l3P96npkIIZkiJuvUM8fDfdnZ5iezXomb9qBo9tFxNEuveVT6ivT48M1qkFTUzvg+/V8X9Q2MGk7lkuwtQWN7IKGcoflGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cf63e976aaf311efa216b1d71e6e1362-20241125
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:058184b2-1cc7-4fe4-bb13-8b5a0cc21484,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:19
X-CID-INFO: VERSION:1.1.38,REQID:058184b2-1cc7-4fe4-bb13-8b5a0cc21484,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:19
X-CID-META: VersionHash:82c5f88,CLOUDID:cda0a13fd323241537df48793d1516d2,BulkI
	D:241125140921PPXFRDBC,BulkQuantity:0,Recheck:0,SF:19|25|38|44|66|72|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: cf63e976aaf311efa216b1d71e6e1362-20241125
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 447401940; Mon, 25 Nov 2024 14:09:20 +0800
From: Minhong He <heminhong@kylinos.cn>
To: stephen@networkplumber.org,
	netdev@vger.kernel.org
Cc: Minhong He <heminhong@kylinos.cn>
Subject: [PATCH] ip: fix memory leak in do_show()
Date: Mon, 25 Nov 2024 14:08:48 +0800
Message-Id: <20241125060848.56179-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Free the 'answer' obtained from 'rtnl_talk()'.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 ip/ipnetconf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ip/ipnetconf.c b/ip/ipnetconf.c
index cf27e7e3..020eff78 100644
--- a/ip/ipnetconf.c
+++ b/ip/ipnetconf.c
@@ -197,6 +197,7 @@ static int do_show(int argc, char **argv)
 			exit(2);
 
 		print_netconf2(answer, stdout);
+		free(answer);
 	} else {
 		rth.flags = RTNL_HANDLE_F_SUPPRESS_NLERR;
 dump:
-- 
2.25.1



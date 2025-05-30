Return-Path: <netdev+bounces-194298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC11AC865B
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 04:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095281BA5CB0
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 02:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E312CCC9;
	Fri, 30 May 2025 02:49:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E692DCBE6
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573355; cv=none; b=a/CnQ+wZLnI5b6zjrevsbRaJDjBacFrevH7AICcxdWB3NDoZXk280MYQZ72fys71GwujPThbogAj1IkRz9kMySMSUq2vfXBvlocXX69NSEmN88NMDUp5QQUg5w+RZ7YjSipwfoXZISlUfrCOa4eVM1fnjVgyD5bLdeZ0GdibXo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573355; c=relaxed/simple;
	bh=5W400MBZ1HThTvR3ckF00N8iEWaCB3X849eX1DGODzg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=c3JTvFP9/e7dsSbyEMhBssYRfLURtd2Oppmq8qliOCOfhepYxcMCstn+qwZq45p7QQsPoe9HssKee4B+TGvwyEo6ym/9QN5UMaaXGi0187W9KOClotkr33XSxjK9UNwPbYEe1jQJcyYTmOKdz04F3NRw2GKGDa3JkAo0XjO759E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a6489ad83d0011f0b29709d653e92f7d-20250530
X-CTIC-Tags:
	HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE
	HR_FROM_DIGIT_LEN, HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e749e42d-d3a6-43dd-8710-aea0136158b2,IP:10,
	URL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:e749e42d-d3a6-43dd-8710-aea0136158b2,IP:10,UR
	L:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GE969F26,AC
	TION:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:83699f22e4d7182ca7599630c796c4f1,BulkI
	D:2505291639197H8C8EDO,BulkQuantity:4,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: a6489ad83d0011f0b29709d653e92f7d-20250530
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 370220807; Fri, 30 May 2025 10:49:04 +0800
From: Li Jun <lijun01@kylinos.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	lijun01@kylinos.cn,
	netdev@vger.kernel.org
Subject: [PATCH] net: ppp: remove error variable
Date: Fri, 30 May 2025 10:48:50 +0800
Message-Id: <20250530024850.378749-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the error variable did not function as a variable.
so remove it.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/net/ppp/pptp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 5feaa70b5f47..67239476781e 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -501,7 +501,6 @@ static int pptp_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct pppox_sock *po;
-	int error = 0;
 
 	if (!sk)
 		return 0;
@@ -526,7 +525,7 @@ static int pptp_release(struct socket *sock)
 	release_sock(sk);
 	sock_put(sk);
 
-	return error;
+	return 0;
 }
 
 static void pptp_sock_destruct(struct sock *sk)
-- 
2.25.1



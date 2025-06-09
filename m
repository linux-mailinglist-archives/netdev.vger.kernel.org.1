Return-Path: <netdev+bounces-195605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB01AD1668
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 02:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E11188B7A6
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 00:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CE317597;
	Mon,  9 Jun 2025 00:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF9D27E
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749430319; cv=none; b=UiV4SIoxdoFqDOn5pWOaNnQxIpKt6/hbBu3uuP7akevSlskaO1NyH+kpR5bd75fKrueL5fsRUKiPxtEF+u5WqMVV0S3/Iv1x79gO/hllGkn0emKP1dsAYKWK5A18iD1mkm6YskmWKCWnqa+XcneaRftZZpe/GtcLN3QCi2uC1K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749430319; c=relaxed/simple;
	bh=5W400MBZ1HThTvR3ckF00N8iEWaCB3X849eX1DGODzg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=JFHvFYBqzpJrhNLd3L4ltiCgWqBCa5BZwANw+4cJdYsX8PjQkt58bnCoyvTJ1JxQ94ukUYeZ28evBvN274PzqDBJalzwGMNQrfDhKaSz7VqZCNI+vPygFRGa2G53oyDcygoZoN+gzgVoq6PX3m3rfxjnbbtB16mqzr73zCmv4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ebb5e06244cb11f0b29709d653e92f7d-20250609
X-CTIC-Tags:
	HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE
	HR_FROM_DIGIT_LEN, HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR
	SRC_UNFAMILIAR, DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:80593579-f7f5-4755-804e-6f0ed166e9fb,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:30
X-CID-INFO: VERSION:1.1.45,REQID:80593579-f7f5-4755-804e-6f0ed166e9fb,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:b738c3e427067e9a80146e62d80b1091,BulkI
	D:2505291639197H8C8EDO,BulkQuantity:7,Recheck:0,SF:17|19|23|38|43|66|74|78
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:41,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-UUID: ebb5e06244cb11f0b29709d653e92f7d-20250609
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(106.121.165.173)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1359928400; Mon, 09 Jun 2025 08:51:47 +0800
From: Li Jun <lijun01@kylinos.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	lijun01@kylinos.cn,
	netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	horms@kernel.org
Subject: [PATCH net-next] net: ppp: remove error variable
Date: Mon,  9 Jun 2025 08:51:43 +0800
Message-Id: <20250609005143.23946-1-lijun01@kylinos.cn>
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



Return-Path: <netdev+bounces-195604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E7DAD1659
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 02:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876423AB19A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A61F11185;
	Mon,  9 Jun 2025 00:42:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB7BE5E
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749429722; cv=none; b=qfq4YkM+U2w6lFCZH4m42enRG48vdehQXc6Tgq6U5qFDM5TC4sfV0OhexlWXjxNEWntaMH/7Xw6j5UNjb089j07xShGMHQii06Hk3fvVVTV9Xf76VlvqQrXuAXJS9fLXBtf9jl/Qh2QzSzphCjsiDdE0tYy4hDDJ/7/yn9BP4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749429722; c=relaxed/simple;
	bh=5W400MBZ1HThTvR3ckF00N8iEWaCB3X849eX1DGODzg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=TUwysyQO3zqpFrNuqEpAMg7BAC5bkWrTK18AoaoeCPEAG684DcuwHNVFeMhfTRQW9otReh00J1hgXWBLeMxlmtjTk4of+QLySeOOcOjoEjc3lf3m+3x2f/YgGZ6HJnUNwD5Sqx0qKxbrMJ3XlXCtRIub3OQxcCmBLOxvzrZvZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8766f09844ca11f0b29709d653e92f7d-20250609
X-CTIC-Tags:
	HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE
	HR_FROM_DIGIT_LEN, HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR
	SRC_UNFAMILIAR, DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0022efc3-ec52-4b13-9ef0-2cc7e3561edf,IP:15,
	URL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-25
X-CID-INFO: VERSION:1.1.45,REQID:0022efc3-ec52-4b13-9ef0-2cc7e3561edf,IP:15,UR
	L:0,TC:0,Content:-5,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:c34ce16f4b4570fe45b6fb0b9016900f,BulkI
	D:2505291639197H8C8EDO,BulkQuantity:6,Recheck:0,SF:17|19|23|38|43|66|74|78
	|102,TC:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:41,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 8766f09844ca11f0b29709d653e92f7d-20250609
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(106.121.165.173)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1932512021; Mon, 09 Jun 2025 08:41:49 +0800
From: Li Jun <lijun01@kylinos.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	lijun01@kylinos.cn,
	netdev@vger.kernel.org
Subject: [PATCH RESEND] net: ppp: remove error variable
Date: Mon,  9 Jun 2025 08:41:45 +0800
Message-Id: <20250609004145.18150-1-lijun01@kylinos.cn>
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



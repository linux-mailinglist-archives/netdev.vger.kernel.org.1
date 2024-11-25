Return-Path: <netdev+bounces-147140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F1E9D7A55
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 04:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CA6281CB3
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 03:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C41917BCA;
	Mon, 25 Nov 2024 03:25:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8815E97
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732505146; cv=none; b=CoRLL8ORlg8BSw9TayPWbFbWusd753yrbpM3AuJWfH5CnwBoWxJV3Uc+Uv5/uSApWlVwQL2RVu5RYiwwjs8Ez0BjanqskZQFkh7vi/AmNWwPRRVldcNgqwK8yuN5k2Fiv9z11gMvFHw6miqmwuYXMtMvPxx9+KhPwf+1H/AopgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732505146; c=relaxed/simple;
	bh=OnVmQUC90eIvuNGVkARZIwyty0P8fX/4vKc6xW+AIRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lKnLj44r/zX4ujtOeMkutvwZMfXNpu1Zcp3EXnryLtvwS6XAWbsXqi/rpCKopdlPKkg6P17hRJB0JJRB/ty5zY95sAkhOESCzjnw07byTmJYMSQc9aWrVKiGmU2AzXw9JoiNsUbB8XzwpOmoYy0HHZwQbBng+8r1baxR/pIb8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ed1ff9bcaadc11efa216b1d71e6e1362-20241125
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
X-CID-O-INFO: VERSION:1.1.38,REQID:db6d120e-68d6-441a-b812-7af1ab08a097,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:29
X-CID-INFO: VERSION:1.1.38,REQID:db6d120e-68d6-441a-b812-7af1ab08a097,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:29
X-CID-META: VersionHash:82c5f88,CLOUDID:3e2d04f7cb7225ccc4f7daf228f118e2,BulkI
	D:241125112534WIRJ8LKI,BulkQuantity:0,Recheck:0,SF:19|25|38|44|66|72|102,T
	C:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: ed1ff9bcaadc11efa216b1d71e6e1362-20241125
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 902229649; Mon, 25 Nov 2024 11:25:31 +0800
From: Minhong He <heminhong@kylinos.cn>
To: stephen@networkplumber.org,
	netdev@vger.kernel.org
Cc: Minhong He <heminhong@kylinos.cn>
Subject: [PATCH] devlink: fix memory leak in ifname_map_rtnl_init()
Date: Mon, 25 Nov 2024 11:24:54 +0800
Message-Id: <20241125032454.35392-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the return value of rtnl_talk() is greater than
or equal to 0, 'answer' will be allocated.
The 'answer' should be free after using,
otherwise it will cause memory leak.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 devlink/devlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 9907712e..abe96f34 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -846,7 +846,7 @@ static int ifname_map_rtnl_init(struct dl *dl, const char *ifname)
 	struct rtattr *tb[IFLA_MAX + 1];
 	struct rtnl_handle rth;
 	struct ifinfomsg *ifi;
-	struct nlmsghdr *n;
+	struct nlmsghdr *n = NULL;
 	int len;
 	int err;
 
@@ -887,6 +887,7 @@ static int ifname_map_rtnl_init(struct dl *dl, const char *ifname)
 	err = ifname_map_rtnl_port_parse(dl, ifname, tb[IFLA_DEVLINK_PORT]);
 
 out:
+	free(n);
 	rtnl_close(&rth);
 	return err;
 }
-- 
2.25.1



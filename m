Return-Path: <netdev+bounces-290338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLE2A37hDmqnCwYAu9opvQ
	(envelope-from <netdev+bounces-290338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:42:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB3F5A37AA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B94B30FC9A3
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6811C39DBD3;
	Thu, 21 May 2026 10:16:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47039394EA6
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358591; cv=none; b=tiONzsEtKiBO/m70dIFSVL8riVQMujMNJ9FxEoKzUFQnAc1dNWZrSQHdyEII9MfQ52oIQSlT3D/21M10qQGjkdCg1q6YfBXC0SIX+8l1Z8AlRU/N1CO4Ip+eV8mvy8NcqHCF2G8CD17esd9SfDnZh+XL+1KO3iwfkv6zVrq0uM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358591; c=relaxed/simple;
	bh=wOhu+edThwNMgOsH2+Bsn4MX2XGKKf59YAa1SmJ7bfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N32mSXeTUkbB0deNnsJYz6KoxNo9W4+hir5tSzjKklaNzXVckbkxaECfQopSfjYCr3EkU7zx72ePGwF1zu7xOV7OgYyJVrPBBmad1loK8QVTy4DCikfz+a+NVBG3uY3bx8WDjWmSkbqnaKU0AEYw8bfrgbd4QVxkDlnIHu/DKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1dbfd70054fe11f1aa26b74ffac11d73-20260521
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f3d17580-5a63-4338-a38c-c51b35a7994e,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:f3d17580-5a63-4338-a38c-c51b35a7994e,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:94f4e5be79ae350c88041e0986f71373,BulkI
	D:260521181623MKNWAPBC,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1dbfd70054fe11f1aa26b74ffac11d73-20260521
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1062538901; Thu, 21 May 2026 18:16:22 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	netdev@vger.kernel.org
Subject: [net-next] net: hwbm: fix buffer leak when construct callback is missing
Date: Thu, 21 May 2026 18:16:18 +0800
Message-Id: <20260521101618.1099537-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290338-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2CB3F5A37AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hwbm_pool_refill() could allocate a buffer and return success without
calling construct(), leaking the buffer and letting hwbm_pool_add()
incorrectly increment buf_num.

Free the buffer and return -EINVAL if construct is NULL.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/core/hwbm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/hwbm.c b/net/core/hwbm.c
index ac1a66df9adc..284b97c488dc 100644
--- a/net/core/hwbm.c
+++ b/net/core/hwbm.c
@@ -33,11 +33,15 @@ int hwbm_pool_refill(struct hwbm_pool *bm_pool, gfp_t gfp)
 	if (!buf)
 		return -ENOMEM;
 
-	if (bm_pool->construct)
-		if (bm_pool->construct(bm_pool, buf)) {
-			hwbm_buf_free(bm_pool, buf);
-			return -ENOMEM;
-		}
+	if (!bm_pool->construct) {
+		hwbm_buf_free(bm_pool, buf);
+		return -EINVAL;
+	}
+
+	if (bm_pool->construct(bm_pool, buf)) {
+		hwbm_buf_free(bm_pool, buf);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.25.1



Return-Path: <netdev+bounces-288165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id o1/MA0CSBmq6kwIAu9opvQ
	(envelope-from <netdev+bounces-288165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 05:25:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DE5548F3D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 05:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2871F3020C12
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79CF3CEB8F;
	Fri, 15 May 2026 03:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2D37104C;
	Fri, 15 May 2026 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778815548; cv=none; b=vFot8pJhZ+ys5cgDFHoskvrGnFlJS3OAS0yYMqKUa5FCejH4P10eNoDvHvsjld5A48mS8mr1AZ1VuU8K/sAFdSAPjALlPoTwguCiWOGDTJGAUHU+UcUfVHN/AUyZNWcMSz9upjqa/R7vz6yOxOLjcs9hIwlkT4fiVRqbvLPkMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778815548; c=relaxed/simple;
	bh=LQQ02nApfMFxTcRthuu7JjTO8utIcvBR1w+hwj6B2fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JKNyW/ZAsyKwa8KkfaR8mC3XhOMokFfToSUbrxadMpAc29x9wBNhbwdxmj3LzsW5WGX6dvZ/ryp0y1SPgeZwtH0n0gu2oSC0wwUYqgowlZxCb+2DBPFQ87Af+/ug/ZtMsHCGwExv9RTRLnvDvstxA0PSRoAKvCmKEnN9EcagHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bc0feae4500d11f1aa26b74ffac11d73-20260515
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:29ee8925-e7c1-4672-80ed-3e0f2a77b278,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-INFO: VERSION:1.3.12,REQID:29ee8925-e7c1-4672-80ed-3e0f2a77b278,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:5051c885a860ee1d3c2667d78b9fcec6,BulkI
	D:260515112535P9WIJ8D7,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bc0feae4500d11f1aa26b74ffac11d73-20260515
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1563457295; Fri, 15 May 2026 11:25:34 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next v2] net/ethtool: drop duplicate TSCONFIG HWTSTAMP BUILD_BUG_ON from SET handler
Date: Fri, 15 May 2026 11:25:50 +0800
Message-Id: <20260515032550.138572-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04DE5548F3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288165-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Action: no action

BUILD_BUG_ON() is evaluated at compile time. The same three checks
for __HWTSTAMP_TX_CNT, __HWTSTAMP_FILTER_CNT and __HWTSTAMP_FLAG_CNT
are already present earlier in this file (tsconfig_reply_size()).
Repeating them at the start of ethnl_set_tsconfig() does not
strengthen the guarantee; remove the redundant block there and
keep a single occurrence.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v2:
 - Drop redundant BUILD_BUG_ON checks as suggested by Paolo.
---
 net/ethtool/tsconfig.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index e4f518e49d4c..239bbf2d826c 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -302,10 +302,6 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 	struct nlattr **tb = info->attrs;
 	int ret;
 
-	BUILD_BUG_ON(__HWTSTAMP_TX_CNT >= 32);
-	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT >= 32);
-	BUILD_BUG_ON(__HWTSTAMP_FLAG_CNT > 32);
-
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-- 
2.25.1



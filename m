Return-Path: <netdev+bounces-203179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82972AF0B02
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21654E2114
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F311FBCAE;
	Wed,  2 Jul 2025 05:59:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADEC1F91D6;
	Wed,  2 Jul 2025 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751435942; cv=none; b=HXXE1v9KQufu+SRRmNnyGMJsX5WnPWvJXx2pstxkPPteS+HQzBodyZ6x9gOQwtaFTldMFOmfhaAa3FZOpx5Ej1fhhHfU+dipMPLOmUZSjY+10nobarFYWWoa87xLCdFMwRGLNmajQ1yYjhroB/6ZlhEvh28EAckiOcDHC0ZRGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751435942; c=relaxed/simple;
	bh=rOPJfFvYLMt2aMxdrfURBB3a2acHffrvMFqWCri8pCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jcxXBm15csfKJZogwyFYL0YW1K7L+lX6//aXbZrkp4AG3dzLoq73vtmqYhzaFPLgfGfGV34TXmut3MGIizvkjYV7lHzBpAZjAzUBd+I9OhAV9TylM7A/5AP6YHym6mEQ1T9g3wR95a39MUOhA6OOlFoqwuIaU+rIVYoKBLeKOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a03a0776570911f0b29709d653e92f7d-20250702
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d1a93923-6fd2-4d2a-8024-96123f6089dc,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:d1a93923-6fd2-4d2a-8024-96123f6089dc,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:08011c1b33491dbfe8e0cc537b249386,BulkI
	D:2507021358526PKVIA5B,BulkQuantity:0,Recheck:0,SF:19|24|38|44|66|72|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: a03a0776570911f0b29709d653e92f7d-20250702
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1140224877; Wed, 02 Jul 2025 13:58:50 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ipv6: Fix spelling mistake
Date: Wed,  2 Jul 2025 13:58:20 +0800
Message-Id: <20250702055820.112190-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

change 'Maximium' to 'Maximum'

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/ipv6/calipso.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index 62618a058b8f..39da428f632e 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -32,7 +32,7 @@
 #include <linux/unaligned.h>
 #include <linux/crc-ccitt.h>
 
-/* Maximium size of the calipso option including
+/* Maximum size of the calipso option including
  * the two-byte TLV header.
  */
 #define CALIPSO_OPT_LEN_MAX (2 + 252)
@@ -42,13 +42,13 @@
  */
 #define CALIPSO_HDR_LEN (2 + 8)
 
-/* Maximium size of the calipso option including
+/* Maximum size of the calipso option including
  * the two-byte TLV header and upto 3 bytes of
  * leading pad and 7 bytes of trailing pad.
  */
 #define CALIPSO_OPT_LEN_MAX_WITH_PAD (3 + CALIPSO_OPT_LEN_MAX + 7)
 
- /* Maximium size of u32 aligned buffer required to hold calipso
+ /* Maximum size of u32 aligned buffer required to hold calipso
   * option.  Max of 3 initial pad bytes starting from buffer + 3.
   * i.e. the worst case is when the previous tlv finishes on 4n + 3.
   */
-- 
2.25.1



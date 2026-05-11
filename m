Return-Path: <netdev+bounces-286415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJw/E2E0AWrPRwEAu9opvQ
	(envelope-from <netdev+bounces-286415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 03:44:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C13CD507077
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 03:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ADC330078AD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 01:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C64C21767D;
	Mon, 11 May 2026 01:43:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6220C00C
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778463817; cv=none; b=qdfh5jGQu+crsZlMW9w6BGoBI7a29nt1DEMf5k7tK0J5mEoo9xAYCkRn/lGpmqFnP67zvbLJ9i/UfB9asOklCbDghRvVfeJCd0y6vYvUMbdYTe1Lh2JycPsfvxSPv8o/IF87Cz9fVGItYRmphauC+573fPtsG5oR0rZcs+lF+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778463817; c=relaxed/simple;
	bh=kGtGQW4qg/Ujrij77J9YWBKcTfxuNBsYlCBw1kvoUdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UfIkCqIsOm3sa1Jfo1nL0g5wCyksm5fXqtvIIzuopLdOhUjf5F+GyzV2lFrENbaxCEiFQVXOw3uNsLcZ8MEj7MYuSXCkgUK3Fbambo12J4VHH5+GCGQLnJwRKUUX/s8uwPje+PRSN9n8QAQYPS9TB871BDr5mHKzxInEiVBZNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cf024d8a4cda11f1aa26b74ffac11d73-20260511
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
X-CID-O-INFO: VERSION:1.3.12,REQID:d116acaa-862a-446c-a752-b1f25a2a7391,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:d116acaa-862a-446c-a752-b1f25a2a7391,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:318fd5898780ea487a77d7f428b34ea4,BulkI
	D:260511094329LNZZXY8S,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cf024d8a4cda11f1aa26b74ffac11d73-20260511
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 662413778; Mon, 11 May 2026 09:43:28 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3] ethtool: fix ethnl_bitmap32_not_zero() bit interval semantics
Date: Mon, 11 May 2026 09:43:43 +0800
Message-Id: <20260511014343.133328-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C13CD507077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286415-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.846];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ethnl_bitmap32_not_zero() should return true if some bit in [start, end)
is set:

- Fix inverted memchr_inv() sense: return true when the scan finds a
  non-zero byte, not when the middle words are all zero.
- Return false for an empty interval (end <= start).
- When end is 32-bit aligned, indices in [start, end) do not include any
  bits from map[end_word]; return false after earlier checks found no
  non-zero data.

Fixes: 10b518d4e6dd ("ethtool: netlink bitset handling")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v3:
 - Adjust continuation line indentation as suggested by Kicinski.
---
 net/ethtool/bitset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
index 8bb98d3ea3db..2198407d9b89 100644
--- a/net/ethtool/bitset.c
+++ b/net/ethtool/bitset.c
@@ -92,7 +92,7 @@ static bool ethnl_bitmap32_not_zero(const u32 *map, unsigned int start,
 	u32 mask;
 
 	if (end <= start)
-		return true;
+		return false;
 
 	if (start % 32) {
 		mask = ethnl_upper_bits(start);
@@ -105,11 +105,11 @@ static bool ethnl_bitmap32_not_zero(const u32 *map, unsigned int start,
 		start_word++;
 	}
 
-	if (!memchr_inv(map + start_word, '\0',
-			(end_word - start_word) * sizeof(u32)))
+	if (memchr_inv(map + start_word, '\0',
+		       (end_word - start_word) * sizeof(u32)))
 		return true;
 	if (end % 32 == 0)
-		return true;
+		return false;
 	return map[end_word] & ethnl_lower_bits(end);
 }
 
-- 
2.25.1



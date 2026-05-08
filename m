Return-Path: <netdev+bounces-285749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIg6Kqe1/WkXhwAAu9opvQ
	(envelope-from <netdev+bounces-285749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:06:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 328424F4BCC
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 859223003BDE
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 10:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4E435F16B;
	Fri,  8 May 2026 10:04:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C2361667
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234699; cv=none; b=cbxr5sN1pqeYDsUvBlUKJnMRHHEkP60Jb1mEFEQHTUBxltWx/K1n0cBWmHsKep8B7LL8Oa8fHXkG3F3q3+H6IKpJvMmmo9perbNifCGqxIQIqSkpgTkfV+9eSp9DsfaiCDvvOoeLBJp940Q6zvijAlcprzJc+i0lDVRhl2pw49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234699; c=relaxed/simple;
	bh=wIRorCkWr0tAR/ZLsIsgAmM66meLaondgk5OY02a4Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbskbvoYBYdq2NUzm77di8rxipS1626eUjcVmxKwk19/5PP3gZ7RGjs2do+do4qjOBz+ZhPod+o/pqQhA2EnqJ2aB+g1/Fng3GA2BAsLaWaG7w3ccdN2xj1nRGUAGDuJ/cvrWuhe3E4hzKTmrFYydyWGRrGY2/wekwIU4b0Zbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 59a016884ac511f1aa26b74ffac11d73-20260508
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f802d46a-f80d-443b-a4d5-ec9f96edb8b0,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.12,REQID:f802d46a-f80d-443b-a4d5-ec9f96edb8b0,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:e7bac3a,CLOUDID:cdaede83d3ac431bd45cb5d61cef153c,BulkI
	D:260508180451HUA6S6OO,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 59a016884ac511f1aa26b74ffac11d73-20260508
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1562983643; Fri, 08 May 2026 18:04:49 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: leitao@debian.org,
	vadim.fedorenko@linux.dev
Cc: andrew@lunn.ch,
	cuitao@kylinos.cn,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v2] net: ethtool: fix missing closing paren in rings_reply_size()
Date: Fri,  8 May 2026 18:04:35 +0800
Message-ID: <20260508100435.186819-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <af2tj9AkacSUfsp9@gmail.com>
References: <af2tj9AkacSUfsp9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 328424F4BCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285749-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Action: no action

sizeof(u32) on the _RINGS_CQE_SIZE line is missing its closing
parenthesis, causing nla_total_size() to absorb the subsequent
_TX_PUSH and _RX_PUSH entries. The resulting size estimate
happens to be numerically identical due to NLA alignment, but
the nesting is wrong and misleading.

Fixes: 4dc84c06a343 ("net: ethtool: extend ringparam set/get APIs for tx_push")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
v2:
- Added Fixes: tag as suggested by Breno Leitao.
- Added Reviewed-by tags from Vadim Fedorenko and Breno Leitao.
---
 net/ethtool/rings.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 0fd5dcc3729f..9054c89c5d7b 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -63,9 +63,9 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_RX_BUF_LEN */
 	       nla_total_size(sizeof(u8))  +	/* _RINGS_TCP_DATA_SPLIT */
-	       nla_total_size(sizeof(u32)  +	/* _RINGS_CQE_SIZE */
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_CQE_SIZE */
 	       nla_total_size(sizeof(u8))  +	/* _RINGS_TX_PUSH */
-	       nla_total_size(sizeof(u8))) +	/* _RINGS_RX_PUSH */
+	       nla_total_size(sizeof(u8))  +	/* _RINGS_RX_PUSH */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_HDS_THRESH */
-- 
2.43.0



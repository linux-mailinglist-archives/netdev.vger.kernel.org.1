Return-Path: <netdev+bounces-292515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IM3O3mhF2qzLggAu9opvQ
	(envelope-from <netdev+bounces-292515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:59:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66A5EBA49
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6356030837FD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4742D9780;
	Thu, 28 May 2026 01:59:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B22D3A7B;
	Thu, 28 May 2026 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779933558; cv=none; b=Tj5W4TUNcKGELpt5/CDWqCov4PCiH1I621b3Pvn4GOdDWOrUHtxDtM2nV6iWUovO/uo6Mw/NwpOSmu81al/8KQFNcVYFhtMWat610VXWtclzt0KCsc+Cpenw0R1dyYKO90CNNCc3fiQfAQT7UXcqyjc4PeqiSdszfxFUlQV6JX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779933558; c=relaxed/simple;
	bh=We4bb5BqYPJYD/T+DwC2+AFyyBXduUFwhx3N+yQ4W4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQtxl+5YuKnZ9D+lPl+v3NJo+P+rPC5Zrgc9rFmJ9yJ501DhEu4LRiFmngzGYaw8sxQddTivWKqrc6eFznqc3ZxryTQ60T1LV0Q3Td9f9mhXbL+7BIDVnYPTSnSqFfYd+6aGmo55RZJOk/iz7LT16CmVoAdUD/WEUh/WI+89kto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d15136c65a3811f1aa26b74ffac11d73-20260528
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7c8715f3-45fc-4703-aae6-ebeaed92eee4,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-INFO: VERSION:1.3.12,REQID:7c8715f3-45fc-4703-aae6-ebeaed92eee4,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:1898d4141d1edd792a1bae13b934cb12,BulkI
	D:260528095913HGMTIMCZ,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|865|898|915,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,
	Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d15136c65a3811f1aa26b74ffac11d73-20260528
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1261235197; Thu, 28 May 2026 09:59:10 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH net v2] netlabel: validate unlabeled mask attribute length
Date: Thu, 28 May 2026 09:59:13 +0800
Message-Id: <20260528015913.190970-1-zhaochenguang@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292515-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E66A5EBA49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netlbl_unlabel_addrinfo_get() checked the address length
but allowed shorter mask attributes to pass through to
fixed-size address reads.

netlbl_unlabel_addrinfo_get() only rejected a mask
length mismatch when the address attribute length
was also invalid.  A crafted Generic Netlink request
could therefore provide a valid IPv4/IPv6 address
attribute with a shorter mask attribute.

NLA_BINARY policy lengths are maximum lengths,
not exact lengths, so the short mask can pass
policy validation.  The mask is later read as
a full struct in_addr or struct in6_addr.
Require both address and mask attributes to
have the exact expected size.

Fixes: 8cc44579d1bd ("NetLabel: Introduce static network labels for unlabeled connections")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v2:
 - Adjust commit message 
 - Add Fixes and 'net' subject prefix.
v1:
 https://lore.kernel.org/all/20260522054521.1169755-1-zhaochenguang@kylinos.cn/
---
 net/netlabel/netlabel_unlabeled.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index ca7a9e2a3de7..c1b7e0061886 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -762,8 +762,9 @@ static int netlbl_unlabel_addrinfo_get(struct genl_info *info,
 	if (info->attrs[NLBL_UNLABEL_A_IPV4ADDR] &&
 	    info->attrs[NLBL_UNLABEL_A_IPV4MASK]) {
 		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
-		if (addr_len != sizeof(struct in_addr) &&
-		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV4MASK]))
+		if (addr_len != sizeof(struct in_addr) ||
+		    nla_len(info->attrs[NLBL_UNLABEL_A_IPV4MASK]) !=
+		    sizeof(struct in_addr))
 			return -EINVAL;
 		*len = addr_len;
 		*addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
@@ -771,8 +772,9 @@ static int netlbl_unlabel_addrinfo_get(struct genl_info *info,
 		return 0;
 	} else if (info->attrs[NLBL_UNLABEL_A_IPV6ADDR]) {
 		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
-		if (addr_len != sizeof(struct in6_addr) &&
-		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV6MASK]))
+		if (addr_len != sizeof(struct in6_addr) ||
+		    nla_len(info->attrs[NLBL_UNLABEL_A_IPV6MASK]) !=
+		    sizeof(struct in6_addr))
 			return -EINVAL;
 		*len = addr_len;
 		*addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
-- 
2.25.1



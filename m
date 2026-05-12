Return-Path: <netdev+bounces-286970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGGuKYTNAmo+wwEAu9opvQ
	(envelope-from <netdev+bounces-286970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:49:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE30551B45C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A825307D702
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E1E4EA362;
	Tue, 12 May 2026 06:40:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF08225B0A4;
	Tue, 12 May 2026 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567997; cv=none; b=qtKu5LsH2JnnmxgLS/OoaSZSI5cDqQ5Olqr948r6bshGz4SkPr0VnecHb+k0YFbr7gj34CKGjk8P7cDvBV+pdhluCX0uDtaxcSpXjO/98Iib4/fmEEkZxfkrVht3IdJbBqyJM1ql+WCkF24xzBiLJSx2zeKMI9zRJ7WFPQcVxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567997; c=relaxed/simple;
	bh=D+wDvenW7MapQOXB7Paf6Xuudjsv1R7BQgOFXRK5LqQ=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=FDnbLVsN8x6pM4PO4ddCwIT9w6tdh+nSjGUrs9qw4HGRhBorMSmSuN+FdXLI99UpMlgOZynrWP3hPekLGXJv+ktCQE5Z/wWR8oDGvY8pm8My4WxCt1apcGpppv/VJEFoIz01IXdyvg/r9SBrwI3J3z+Oc+hKQuIL9j85rGDlkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gF6QH5CCWz4xPSs;
	Tue, 12 May 2026 14:39:35 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 64C6dTLu028700;
	Tue, 12 May 2026 14:39:29 +0800 (+08)
	(envelope-from qiu.yutan@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 12 May 2026 14:39:31 +0800 (CST)
X-Zmail-TransId: 2afb6a02cb236ea-be875
X-Mailer: Zmail v1.0
Message-ID: <20260512143931584Zv3UzxnMq14MaQPmsK3VX@zte.com.cn>
Date: Tue, 12 May 2026 14:39:31 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <qiu.yutan@zte.com.cn>
To: <davem@davemloft.net>, <kuba@kernel.org>
Cc: <dsahern@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
        <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.chuan1@zte.com.cn>,
        <huang.jian@zte.com.cn>, <zhou.shizhen@zte.com.cn>,
        <zhang.dongyu1@zte.com.cn>, <ye.guojin@zte.com.cn>,
        <yang.wei20@zte.com.cn>, <zhang.lin16@zte.com.cn>,
        <li.hao40@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0XSBuZXQ6IGFycDogRml4IHRoZSBjb2Rpbmcgc3R5bGUgaXNzdWUgcmVnYXJkaW5nIHNwYWNlcyBpbgogYXJwX3N0YXRlX3RvX2ZsYWdzKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 64C6dTLu028700
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: qiu.yutan@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 12 May 2026 14:39:35 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A02CB27.002/4gF6QH5CCWz4xPSs
X-Rspamd-Queue-Id: DE30551B45C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286970-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[qiu.yutan@zte.com.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Qiu Yutan <qiu.yutan@zte.com.cn>

According to the kernel's coding style, the binary operator & should
have a space on each side.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
---
 net/ipv4/arp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 601b98185cf5..18174459a9a9 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1155,9 +1155,9 @@ static int arp_req_set(struct net *net, struct arpreq *r)

 static unsigned int arp_state_to_flags(struct neighbour *neigh)
 {
-	if (neigh->nud_state&NUD_PERMANENT)
+	if (neigh->nud_state & NUD_PERMANENT)
 		return ATF_PERM | ATF_COM;
-	else if (neigh->nud_state&NUD_VALID)
+	else if (neigh->nud_state & NUD_VALID)
 		return ATF_COM;
 	else
 		return 0;
-- 
2.25.1


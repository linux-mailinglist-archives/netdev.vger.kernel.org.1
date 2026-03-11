Return-Path: <netdev+bounces-266502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOQDEtIdsWmOqwIAu9opvQ
	(envelope-from <netdev+bounces-266502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:46:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974BD25E263
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BC2033DDDDA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 07:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA93A6F1E;
	Wed, 11 Mar 2026 07:24:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6833AB279;
	Wed, 11 Mar 2026 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213839; cv=none; b=RAx3tEWzoMLxcjB8BE7dKMFhebIxZu3X+Qs5Tq8NJoC/NVE/GrPaU8zZbP6BDTb/eF3efFErcUDDardEw3XsZeXaD75H6fFmRmO3VnwKwkr6wPsicc7BN+n7ZgxJCl6c8w07hXyAC4rQhdhFJG7OFukinSA/BN+/Fd6wGTKWppM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213839; c=relaxed/simple;
	bh=Le4ziTymiOzp62xJ0hVlRSDbd5mAajWhUu65VgUkFLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YzNZIpDy0lTNtwSCPackKSn1zArqZs8fKxN+7MmVI7lxKea1sgoIUbTJCz+cEpZ9w5nTEHYTp2JZ2ZY8yqe/nnGAf7cRfvTWMzHivnS34/qmRuY1Wj+/XubRZiHsjd/sY96pw4zavpi0VWgWb5YnGGvLXU1qM6bQd6t1+nkp8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3b0ce3d61d1b11f1a21c59e7364eecb8-20260311
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:a251f3ab-8b1c-4a43-b8e7-a8c71cbc9894,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:89c9d04,CLOUDID:c196242fa8e833772f764fd8a49e5b49,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3b0ce3d61d1b11f1a21c59e7364eecb8-20260311
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 314001501; Wed, 11 Mar 2026 15:23:41 +0800
From: Minhong He <heminhong@kylinos.cn>
To: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	david.lebrun@uclouvain.be,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minhong He <heminhong@kylinos.cn>
Subject: [PATCH net] ipv6: sr: Add unlikely hint to idev NULL check in seg6_hmac_validate_skb
Date: Wed, 11 Mar 2026 15:23:30 +0800
Message-Id: <20260311072330.96491-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 974BD25E263
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266502-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[heminhong@kylinos.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Action: no action

In seg6_hmac_validate_skb(), the pointer returned by __in6_dev_get()
can theoretically be NULL if the network device lacks proper IPv6
initialization or is being torn down. However, this is an exceptional
error path; in normal operation, the device will always have a valid
inet6_dev structure.

Marking this NULL check with unlikely() helps the compiler optimize
branch prediction and code layout. It ensures that the common case
(valid idev) remains in the hot path, while the error handling code
is placed out of line, improving CPU pipeline efficiency for high-speed
SRv6 packet processing.

Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/ipv6/seg6_hmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index ee6bac0160ac..a8f279ffb678 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -184,6 +184,8 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	int require_hmac;
 
 	idev = __in6_dev_get(skb->dev);
+	if (unlikely(!idev))
+		return false;
 
 	srh = (struct ipv6_sr_hdr *)skb_transport_header(skb);
 
-- 
2.25.1



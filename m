Return-Path: <netdev+bounces-282130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMWiGro/8WmhfAEAu9opvQ
	(envelope-from <netdev+bounces-282130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:16:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB648CECC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B1C9301A5F9
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7338AC64;
	Tue, 28 Apr 2026 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Zpt4zZWL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59238838C
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418150; cv=none; b=i1r/IT4/ETeG/cUEdahfFg766zYYivIYPsOzNIscdfWC0rANKm61LBasPDCP7C6KBKv9IhPvGV7J7FhU+IRejfjx3VveXC4amaTjaIZZtix1kW4hDzgj8a53k0cFDwrCskwL6tYNNM2F0EWvABWZjKqzB1aNR88hiz8MJy7NN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418150; c=relaxed/simple;
	bh=p+ccvZ4v/Gp9Cd5Y/DfJpz1/HXOHjQ6IIwjXswzj35c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arVUKQJ9wsDrNRj4F4mT1GGNMno/3L7NYTenRXpDx9d0hEJJCRNW4u+G+gwr7sP5T1Pbg9CUGqCItD0pzun6E5HhsJLQoL8+fPNK7E2UOt51E00M/pb7jjU4iInKGtrMZFAb32mJJdHCGTpYUKqFlpGlvKwX4wUcnzuXklLA/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Zpt4zZWL; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OGckIoZFBZvh+x5XeT6oAdso/3/T3diolfY3+7bfdQw=; t=1777418149; x=1778282149; 
	b=Zpt4zZWLWNIuQ9dRXUI6dM3jS5FiiXayGZIpPZjNQkD6WuD5B3bHKZpMkmESw0qitNOtXeeJAyA
	UeXqxPAFMfwtYz+Ra+qMK93tOTP/6cVit6SMf2Oj9ohqXVmx2wSvP1g8OXzPwRB2qzJlibpKs9phz
	YHau0iqF5x24ElJ9N9nt1M1B1LLAEy/fYsglxXb9GEc4Wbw9wT1ArGLZK0bpbdCBJfFNIOfbLg5Vd
	wcYUfHZqre9f/G3H+z+6fGFGwFSRtZ7wh35GAFu9WEd5BcphhM8rYRKtqd/UawYRsS+US9PHluGPN
	L28Xlf7i/iCUeoVCtWcAoQ8XHsTC50FBEXFQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:54475 helo=ouster2022)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wHree-0005UM-45; Tue, 28 Apr 2026 16:15:48 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v19 11/15] net: homa: export skb_attempt_defer_free
Date: Tue, 28 Apr 2026 16:15:14 -0700
Message-ID: <20260428231520.1857-12-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428231520.1857-1-ouster@cs.stanford.edu>
References: <20260428231520.1857-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.8
X-Scan-Signature: 9dddbef7dbf47a29383c7a3c8e5dce6e
X-Rspamd-Queue-Id: F3AB648CECC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282130-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	NEURAL_HAM(-0.00)[-0.851];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanford.edu:email,cs.stanford.edu:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This function is now used by Homa.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e94c76e49974..a5b9550a6395 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7296,6 +7296,7 @@ nodefer:	kfree_skb_napi_cache(skb);
 	if (unlikely(kick))
 		kick_defer_list_purge(cpu);
 }
+EXPORT_SYMBOL(skb_attempt_defer_free);
 
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
 				 size_t offset, size_t len)
-- 
2.43.0



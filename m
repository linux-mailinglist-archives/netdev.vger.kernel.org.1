Return-Path: <netdev+bounces-277557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABrKKmFY2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:06:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 263B93DC567
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E12D3065587
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C7538C416;
	Fri, 10 Apr 2026 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="bU1tug6+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E441236C5BB
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851420; cv=none; b=Cwf0Vj0BOKE5j/iTEsmU0wWYBkjq2q4F6fJK6ZiBNm56DXg08/LJVqMlx+LG6h8Tg+3TBWm3rGUCDB43M74dsW0OxLLWonBvl3apu4mQy9o3dDCy0Agw5sttk5rz0k1Dbf6dG0Z8r+N3v+iHNrXOXL0YskKctFmgrNcVzdHwTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851420; c=relaxed/simple;
	bh=kLwAGzdnLwU7BhpcTHerDHEpLONZCiWVPt2kn4PovtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAw19p8Rn+sADwWEWY0qpbm9lfoPBKdXJIt7ix2Lar8uJQF72ya7IEhsxzYEljHpjdBHCWCQB5TMnlZQax371HCpLa3oxqjG1efM/L8HHOsyahWDF27j5I9dTlOV8j9toGcw61izilc95WtTjHRtsZ13kxTvBzzMEpxZkwyvvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=bU1tug6+; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jrLe7+SMjIPzFytFGWWvGZz8t4sgHoqeFGdIR+R/vTA=; t=1775851418; x=1776715418; 
	b=bU1tug6+8+JZ0hi6ESJmnNgX9aHjtuaMc2VTefo6qFVnlQG9b3gsw0k2wi1n3umSSIjqotG1fj7
	k+Tkx0UWnfCvurl/2etwJWmy3ZPEnR2+PoG78XGUE1qi/8gZOqKKSnv5Ef8EqLunHNwnFtta+O1H1
	pf9C+zRAGOxhyH99Y4q2CldG+Bg9zZ7D3hbgEqypZMjcTr9KheZJK7Gr4HWw4denYAGwqEPxHyU/B
	VtOombUJ9h+zSGLwYKMIlNihmI9TxLmcuXMGY3r8vZ+DI4mpCDsmvw995U0qkFpEq498kJVGHNEE/
	XF/2FVOv0V1XgfPcI2UnWtUWvXMaF9rYBmVg==;
Received: from ouster448.stanford.edu ([172.24.72.71]:51553 helo=ouster2022)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wBI4n-0003MV-Vf; Fri, 10 Apr 2026 13:03:38 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v18 11/15] net: homa: export skb_attempt_defer_free
Date: Fri, 10 Apr 2026 13:03:05 -0700
Message-ID: <20260410200310.1915-12-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260410200310.1915-1-ouster@cs.stanford.edu>
References: <20260410200310.1915-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.8
X-Scan-Signature: 9dddbef7dbf47a29383c7a3c8e5dce6e
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277557-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	NEURAL_HAM(-0.00)[-0.913];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanford.edu:email,cs.stanford.edu:mid]
X-Rspamd-Queue-Id: 263B93DC567
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This function is now used by Homa.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4657d0245a84..a66209647732 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7314,6 +7314,7 @@ nodefer:	kfree_skb_napi_cache(skb);
 	if (unlikely(kick))
 		kick_defer_list_purge(cpu);
 }
+EXPORT_SYMBOL(skb_attempt_defer_free);
 
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
 				 size_t offset, size_t len)
-- 
2.43.0



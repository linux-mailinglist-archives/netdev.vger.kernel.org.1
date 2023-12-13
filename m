Return-Path: <netdev+bounces-56711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03015810925
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 05:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300331C209CD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 04:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3F4180;
	Wed, 13 Dec 2023 04:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nx7COMzD"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3A8D3
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tzg5X0HaqLbD1P8hBgypQW7nl+TA9d+ifTESTRlzdZo=; b=nx7COMzDGo5OKa1J1dZa9phyaT
	btHEhxYD5EoDSjvH3tRi+qJeUP+TDDgtFxFvpGlys1YYjn7kDtzfToBcdMT/JWF5yj2glzOSU+iew
	lNWR75XFLuYpQdBIl22lRYcFLoTjMCcNipk+WTou+B+DK79wgw3H/bbWK3tRhBO34ymDWjIiTYOAD
	FrxXoBWIUywrdIv2VM8o812dMy48qRUK1H0WvsLbj2NHRmJIlWKqs8sjBTMNZMtXf0jgr8vDhtPiA
	sejYAnnsxhgXWb6hzW28nMxz/TCRmaeQfl1MToi8EXj/2+qz5dx6A+7RZ1KYzdV9+Epq49WGdcYv9
	vppxRrYQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDGxk-00DaXM-0l;
	Wed, 13 Dec 2023 04:35:12 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: skbuff: fix spelling errors
Date: Tue, 12 Dec 2023 20:35:11 -0800
Message-ID: <20231213043511.10357-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling as reported by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/skbuff.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1069,7 +1069,7 @@ struct sk_buff {
 	refcount_t		users;
 
 #ifdef CONFIG_SKB_EXTENSIONS
-	/* only useable after checking ->active_extensions != 0 */
+	/* only usable after checking ->active_extensions != 0 */
 	struct skb_ext		*extensions;
 #endif
 };
@@ -3311,7 +3311,7 @@ static inline struct page *__dev_alloc_p
 					     unsigned int order)
 {
 	/* This piece of code contains several assumptions.
-	 * 1.  This is for device Rx, therefor a cold page is preferred.
+	 * 1.  This is for device Rx, therefore a cold page is preferred.
 	 * 2.  The expectation is the user wants a compound page.
 	 * 3.  If requesting a order 0 page it will not be compound
 	 *     due to the check to see if order has a value in prep_new_page
@@ -4247,7 +4247,7 @@ static inline bool __skb_metadata_differ
 {
 	const void *a = skb_metadata_end(skb_a);
 	const void *b = skb_metadata_end(skb_b);
-	/* Using more efficient varaiant than plain call to memcmp(). */
+	/* Using more efficient variant than plain call to memcmp(). */
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
 	u64 diffs = 0;
 


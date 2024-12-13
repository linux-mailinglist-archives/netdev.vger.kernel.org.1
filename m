Return-Path: <netdev+bounces-151821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42909F1123
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 16:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5DE28237B
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CB61E2611;
	Fri, 13 Dec 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4WaCxJv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523C1DF988
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104294; cv=none; b=Iu8hL2VcetGMOIaGk8akKfO3WkuGhQgN3lt18URiJox3u1bhKKlhNlCntzB7RTU/k7o2M/5wWfEcpFH13HdfKAJaQmDY2bpU0MR9DeorfvY/TKNlM5I+C8xDsHFEW3mvZKvvn6G6cjCXPn4Oz7F/N7FE6R03MMm8mrJatTEW9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104294; c=relaxed/simple;
	bh=AxHMPXFnWxgqcqQtqjkefSU0iKGlZw7Rp+fgdlUwm0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T18RHmZfYAp2f8rBhH/J8B0o6Uh1LWx81QutoU5MyZtxMoPrratOYksLRQpXJwMuRnGl4MfQK8/XyNwUQrkZzfwZbFumkD8kTw2zOdgZbcRZ6UdW/TBdGpOnMe1XAwHSNh3d1rP7f2omJ8zeeIGwERruFKoEe3rgjzmmYw3Jkos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4WaCxJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E40C4CED0;
	Fri, 13 Dec 2024 15:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734104293;
	bh=AxHMPXFnWxgqcqQtqjkefSU0iKGlZw7Rp+fgdlUwm0c=;
	h=From:To:Cc:Subject:Date:From;
	b=B4WaCxJvh/5dQqs7ESwpZ5RizA9hyX+Jobs6eY/wOnFBdnx8F1AUVXaPKXe9CGohy
	 ya+WSPEphcWriuJdxRvHzg+zP78GiNBK6Ko6diicp41s8Z4WSJeuYTaOVGBMvD9huy
	 EeRuepjV/fhBza2lr7rNAS7050hrmdh5wZXG2ncExlwdqDOctlCMlOdLdwjSHHlno8
	 YXafizQfBiVDU3lDc34P8qptcpN3NqGqD8rmfzSS7qVk2xsBO8w0V3ziSQrIJsHATF
	 xxZiwZ/Tvm9yYA6jhHQiPTDEs3lBqs8yw4cfHAycpoCFEbkp6qmuG4uPjNxF6fAMbY
	 17H25TJmXvchg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	asml.silence@gmail.com,
	almasrymina@google.com
Subject: [PATCH net-next] net: page_pool: rename page_pool_is_last_ref()
Date: Fri, 13 Dec 2024 07:37:59 -0800
Message-ID: <20241213153759.3086474-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_pool_is_last_ref() releases a reference while the name,
to me at least, suggests it just checks if the refcount is 1.
The semantics of the function are the same as those of
atomic_dec_and_test() and refcount_dec_and_test(), so just
use the _and_test() suffix.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Hopefully this doesn't conflict with anyone's work, I've been
deferring sending this rename forever because I always look
at it while reviewing an in-flight series and then I'm worried
it will conflict.

CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
CC: aleksander.lobakin@intel.com
CC: asml.silence@gmail.com
CC: almasrymina@google.com
---
 include/net/page_pool/helpers.h | 4 ++--
 net/core/page_pool.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 26caa2c20912..ef0e496bcd93 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -299,7 +299,7 @@ static inline void page_pool_ref_page(struct page *page)
 	page_pool_ref_netmem(page_to_netmem(page));
 }
 
-static inline bool page_pool_is_last_ref(netmem_ref netmem)
+static inline bool page_pool_unref_and_test(netmem_ref netmem)
 {
 	/* If page_pool_unref_page() returns 0, we were the last user */
 	return page_pool_unref_netmem(netmem, 1) == 0;
@@ -314,7 +314,7 @@ static inline void page_pool_put_netmem(struct page_pool *pool,
 	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
 	 */
 #ifdef CONFIG_PAGE_POOL
-	if (!page_pool_is_last_ref(netmem))
+	if (!page_pool_unref_and_test(netmem))
 		return;
 
 	page_pool_put_unrefed_netmem(pool, netmem, dma_sync_size, allow_direct);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4c85b77cfdac..56efe3f8140b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -867,7 +867,7 @@ void page_pool_put_netmem_bulk(struct page_pool *pool, netmem_ref *data,
 		netmem_ref netmem = netmem_compound_head(data[i]);
 
 		/* It is not the last user for the page frag case */
-		if (!page_pool_is_last_ref(netmem))
+		if (!page_pool_unref_and_test(netmem))
 			continue;
 
 		netmem = __page_pool_put_page(pool, netmem, -1, allow_direct);
-- 
2.47.1



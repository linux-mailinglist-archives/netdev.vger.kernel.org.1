Return-Path: <netdev+bounces-291555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJsLORxDFWokUAcAu9opvQ
	(envelope-from <netdev+bounces-291555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:52:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BD95D155D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D5E8301FA88
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0FD3BD657;
	Tue, 26 May 2026 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="b1g8dqFC"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549713B6C1E
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778328; cv=none; b=G8t7+5h6OYGOqoTH/mdop23LrqJTsq4Vcgtp8IDj8nMHc9jJoSsv8/CxOH07Mj8nt9fI8RBDdriYxUMDBW6Tg9/XU6XG2DDQJUsVKysP+vuSrAZL5sTvwX0hKw9JLt5obDr6/3GGn6PgKdFpS5lUAHeQdovdCDhJJihY19lnpAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778328; c=relaxed/simple;
	bh=oahgMxLJyOHXuKFO9PUC+vLz4Z9d7nU2ufP3IRxjPJw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=e118pUWX3rODSKTRk0NnInZeaqq471n6Vh8lyVOh6DGHlIPaN3BMl+nx3j+qbp94kGrZA4o8AIepAYbQdIwd0qjZhb46MuxmIK/2QMETa2xEqIAS54onl9Gr2fJvnb15BqxFcCvWRWTaZbQGg3DMLFGI51cpTVnY2UDpGyRuIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=b1g8dqFC; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779778320;
	bh=g10TuWJdjGYcTTCVtlvAig11+k5fs4K2Y//Gpajvv7k=;
	h=From:To:Cc:Subject:Date;
	b=b1g8dqFC6gXQUaFJYjYu9XDq9OKIOfpfJ0Nd0leKjlNj9c9bjiP1oxXTmp4g7EdyG
	 85iGIsSBu3kMQSJohrEdT/nXEYEMzQa6vockqFsSywv5xfCYGnnuX+L3rLUsY0k+TV
	 yDXCdILQY3i7d6cM+LeQ/qh7E3ja4FXKL7mtWJ1k=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id CFA19AE1; Tue, 26 May 2026 14:51:58 +0800
X-QQ-mid: xmsmtpt1779778318t8rznogzx
Message-ID: <tencent_A82EBAB365A8B888B66FDCF115A3DCB8880A@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+yRe93fy6PhxbTwD2zSCgC7TKnb8rFT10ul6sAdBBCG12KfHnZC
	 maywOZf+09xX3T+8fUypfEZVJLOUC2HgcRuQKLYJtrSSWBEo9w/weoetFJofMZLJ+3QgPfe4TcuC
	 YgnXmUyJct7krM8O/PX02k/e+XFJtBwJWj6XvbnQdedtPgfhClBQ848G+Wjiyaa0XaMkL6BZ8sDK
	 axnwc5QYnZQPhOsaNk/cfga9hELI6p7ww7MINFPwUqe/XQlSnDlW70leAVBST5oWyMbN+tQZb63m
	 CFdbxor3yf2pznPs0UK2hW3A1XZVdyRTiYeIE5QSoLx7eNllZR+vQdLuAlGPo8BPfvLrJiAB8CgD
	 Jupjr9p3jJSRZXIA4y4CZJxJvGv5nsdtxYhGc//Q8+afGqPg9ajqHfxIHD3Rj3u54SWKuCMYK72b
	 6YV9rePHlktcccwXBQneopoIPc6pbqwvF9RaX6HqrSWtEIZEuwLwAqBCxQVsHBDZFmTftZzjFII8
	 COcmBgc2gdyNFsbHR2kF/A4hnTVGq7ylj7QqnVvoltOsm6EtKqwFQ/evrOElhW2nghRVqSbZ/KVu
	 66SRMO5qEXeq4mvWEIbBWFLPpX8VAn4b2ZbEXjIIS29D0CHdy3l8XgljFoyu9H1H3nhtIY9qWxei
	 4Gwa/Q+vXxgmKx2cy7xPL2IdEHi3iaUyzVd8dP7JlHYbEKgG56aV6RLeQnd0xwqCwj42JD7Kj6d7
	 vmya2ajxCbIaj0OIp+Bc7hf0DXsh9ryrsq8TVAgBEWroI8WR6fQr7F9s2NtL2M3xtWEXsunMxkXm
	 hw0a38JbuDcl6yMcr7qaqbAfM7HfXYK3cnJXT1m+V5i/TzKGKgcLnkumShKo6v4cqKugc8BIo/fU
	 oxePSq8QU9h8BWTKQ3QNq25E3MVfHfMtSCTydL0TuhZwzLXjvKgq8Lc8KudaBM5f7BAly6bwbjqV
	 6QK24PE9BzFkJ3AcOJIJGIniJ0U5gbmZlN6DYLN99AkIJ/5OCsKgf65/ssMsSMaKp9BjfK5i4lqH
	 HjRX8RFuJWuZWTUbDMrYVbeLRrOqtvJVjlEeOEDkpZS2T4zme/KNu2BFDulNE=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Zhao Dongdong <winter91@foxmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH] net: page_pool: check nla_nest_start() return value in page_pool_nl_stats_fill()
Date: Tue, 26 May 2026 14:51:56 +0800
X-OQ-MSGID: <20260526065156.349857-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-291555-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qq.com:mid,foxmail.com:dkim]
X-Rspamd-Queue-Id: 95BD95D155D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

nla_nest_start() can return NULL if the skb runs out of space.
page_pool_nl_stats_fill() does not check the return value before
calling nla_nest_end(), which can lead to a NULL pointer dereference.
Add a NULL check after nla_nest_start() and abort the message if it fails.

Fixes: d49010adae73 ("net: page_pool: expose page pool stats via netlink")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 net/core/page_pool_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index ee5060d8eec0..2e41691251e1 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -127,6 +127,8 @@ page_pool_nl_stats_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		return -EMSGSIZE;
 
 	nest = nla_nest_start(rsp, NETDEV_A_PAGE_POOL_STATS_INFO);
+	if (!nest)
+		goto err_cancel_msg;
 
 	if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ID, pool->user.id) ||
 	    (pool->slow.netdev->ifindex != LOOPBACK_IFINDEX &&
-- 
2.25.1



Return-Path: <netdev+bounces-293056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BkCBs1cGWoLvwgAu9opvQ
	(envelope-from <netdev+bounces-293056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:30:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEB25FFF62
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195AC301DCCD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E252B3B47D6;
	Fri, 29 May 2026 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="bAdBod3K"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412F83446DE
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046817; cv=none; b=jI+fRCB7sNpWveiOI7cTvVJjB5u4EYbEIiw0kA5I7ZQvdV8CFviesZSApHqJ/cAfY0dlBZ/gwnrRWy3rwFVg+PstkovZDcM779xPIOpWdck2hstBm8MH+Z7i015Hg2XY+4RpPOOYbbSWJyXFtpQHzLCc4M3CtKD44vo00kJdF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046817; c=relaxed/simple;
	bh=Lxa7piGJRpIt58wB4GOoBcG5z2Z6VBCpRWPakuE16xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLC/ZuGTBc4zIJGRut9qRZgFnQENlNA8OU9TUz4AwQRxFZlg5bC5JH8+Hv9iWqBOvCrc5IY8iieQYei5qPHe6/rU9+zPnnVvwUw/b+7rjxoJFef1+4Pj73Ufbad5fmzfInZhX+RjZhszJyXDixcrttYwLRCWRrdu0P1srFyfGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=bAdBod3K; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D5BED206D0;
	Fri, 29 May 2026 11:26:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IvTa74vjEdeq; Fri, 29 May 2026 11:26:53 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 3C0472019D;
	Fri, 29 May 2026 11:26:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 3C0472019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780046813;
	bh=ZAwIrpwKprGw0uaudJaQf5Wh/QCSbXX2h/P24ElQh38=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=bAdBod3KZWagFmcgQMNSgJNokZCifV+k6YuRfeSHbKZArfJsgIwlm0JdR9zweUlnk
	 BzEEJovIOUQ/KJDK8nG2q6htBuyk1dqHchJSCb+70wKHGbMwdjb0Ap1v4UvIo/EzVV
	 yL7HLfVVSYi4luzIVi8clEeshdlNJeoQVJdMoAqvSFXGLSXuHlX6vDzdNOZnvS7Gqx
	 upGDUS9or2hsq6ezX9xgeZfaFU4TDvgWHpM07L63LEUskgfOniD7VUoSByGJm//oJR
	 qCvpjp/8N3TvssHcz8JYTCXxS8UmDjoHWCmrFTlLCiroLldUz23ZQLofEktB7235xJ
	 m8RqKMo4eR6CA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 11:26:52 +0200
Received: (nullmailer pid 3879705 invoked by uid 1000);
	Fri, 29 May 2026 09:26:51 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/10] xfrm: esp: restore combined single-frag length gate
Date: Fri, 29 May 2026 11:26:08 +0200
Message-ID: <20260529092648.3878973-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529092648.3878973-1-steffen.klassert@secunet.com>
References: <20260529092648.3878973-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293056-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,secunet.com:mid,secunet.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,queasysnail.net:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6DEB25FFF62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jingguo Tan <tanjingguo@huawei.com>

The ESP out-of-place fast path appends the trailer in esp_output_head()
before esp_output_tail() allocates the destination page frag. The
head-side gate currently checks skb->data_len and tailen separately, but
the tail code allocates a single destination frag from the combined
post-trailer skb->data_len.

Reject the page-frag fast path when the combined aligned length exceeds a
page. Otherwise skb_page_frag_refill() may fall back to a single page while
the destination sg still spans the combined skb->data_len.

Restore this combined-length page gate for both IPv4 and IPv6.

Fixes: 5bd8baab087d ("esp: limit skb_page_frag_refill use to a single page")
Cc: stable@vger.kernel.org
Signed-off-by: Lin Ma <malin89@huawei.com>
Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>
Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/esp4.c | 4 ++--
 net/ipv6/esp6.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 8314d7bddcb7..5d3a8656687e 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -419,8 +419,8 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 			return err;
 	}
 
-	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
-	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
+	if (ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) >
+	    PAGE_SIZE)
 		goto cow;
 
 	if (!skb_cloned(skb)) {
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9d0c4957ac62..b963b8e72604 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -448,8 +448,8 @@ int esp6_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 			return err;
 	}
 
-	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
-	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
+	if (ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) >
+	    PAGE_SIZE)
 		goto cow;
 
 	if (!skb_cloned(skb)) {
-- 
2.43.0



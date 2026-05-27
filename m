Return-Path: <netdev+bounces-292190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHeDNH+uFmojogcAu9opvQ
	(envelope-from <netdev+bounces-292190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:42:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 375DF5E13F7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F3E730305C5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF0F3E0253;
	Wed, 27 May 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="HW0zY2lH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD03CFF53
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871334; cv=none; b=sx8lhRVQ6HSFivM67G9wesLt0D8M+36NFB2U2lv06aPPzWtHS4NeMwmS+VNXB2Hp+P6xodQjg2rJJ50oqLg4+C/aVxzWerjYvyzpTvl+PWD8MNnKAPK/hvUaMWIpdEBnSlDVxP6njL05wge5vIljLjpBBxIQsevf3y515F5Twe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871334; c=relaxed/simple;
	bh=Lxa7piGJRpIt58wB4GOoBcG5z2Z6VBCpRWPakuE16xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrntAn3Rj8UWoCj79pHZszP1EP/DgQz8h8Xm/rl+284x+4YuQ02ExluffNP+mPjJiECa0iV0rSDDxhcYp7Ncl63jMKsu/xoAuy6UkIIEgZGve9XkNDNoYpPOMqD4rTcabWtEw8BetRW2kNibRXLrIS9cAX3wZOhBYY2B99BwSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=HW0zY2lH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5A5BE20520;
	Wed, 27 May 2026 10:42:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lqDa2AZ30A99; Wed, 27 May 2026 10:42:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 416872069C;
	Wed, 27 May 2026 10:42:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 416872069C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779871325;
	bh=ZAwIrpwKprGw0uaudJaQf5Wh/QCSbXX2h/P24ElQh38=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=HW0zY2lH7bKWXTPzrp2JyYgu0WMBHwtox4JaDQFrrXyhJomurUjeoD8Wr6/fJ01lF
	 IKYQbVwhln9n9Z86F8bfpiibSQiMr0wLRiYKZqeaOKKWxclya/McyruEX5RQjFXO0L
	 6MBQVgvTjvFqGml1CtMB1qMEw6H9qUoQecSixNsDSu37QbrC/BXTN7gNOW4v4mru/i
	 6uVLpwuBnN38eg+WxKoKkru7rIgBrz+Zjg9Or1wFusQ6GecJxuTqtP9ph10DYmJlwT
	 CtW8CD3tTSRJ5ljNdoLagwSDBr/umoLLoH44z+9wqrc7ps2uvktiuOutVNCJPoYbl0
	 9qGtWoxbBEOvw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 10:42:04 +0200
Received: (nullmailer pid 3494003 invoked by uid 1000);
	Wed, 27 May 2026 08:42:01 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 6/9] xfrm: esp: restore combined single-frag length gate
Date: Wed, 27 May 2026 10:41:24 +0200
Message-ID: <20260527084148.3489759-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527084148.3489759-1-steffen.klassert@secunet.com>
References: <20260527084148.3489759-1-steffen.klassert@secunet.com>
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
	TAGGED_FROM(0.00)[bounces-292190-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:email,secunet.com:mid,secunet.com:dkim,queasysnail.net:email,huawei.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 375DF5E13F7
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



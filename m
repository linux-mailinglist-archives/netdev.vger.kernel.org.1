Return-Path: <netdev+bounces-286105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNViJFrI/ml5wQAAu9opvQ
	(envelope-from <netdev+bounces-286105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 07:38:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED2A4FE258
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 07:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C892E30093BB
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 05:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF78281503;
	Sat,  9 May 2026 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TuVOmt6j"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CF29B79B
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 05:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778305106; cv=none; b=Z8kFxDNYptfjhFC5Uf1ITF+f/xd9If0LtZt8aPjxCeTa17lpqwk0icZBwFObxK2IrpJqXXJf0J+YufNAlSkxyTJzaE0s2D5SQNRQSkwUXPXIWdZSRaAZcmU+qHJNqklnrxLkx3n5GUp/WNrr32+8tWOtjDIWhX74eBYfZyzkbCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778305106; c=relaxed/simple;
	bh=s3FIEeW8UUaHN3l/ZqapmL3VuaNw9xvXkKPPK2zklAA=;
	h=From:Message-Id:Mime-Version:Subject:Date:Content-Type:To:Cc; b=lbN5Zz6MUsWUY1ADsdG9y0OR/xEO9U/NNs5r36oBv9zMFZcVt0FZ9ef2/mx/JZNYyK7ZS4UjMKK/irQHbPJAn6GuC8Wz6a6ar1q1C3pcEdH6k46qU6JWwnHkYrQCJVdLXIXnViZpi9ttghOH8wkjf3IXRkPd71vXzhlgU+03/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TuVOmt6j; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778305093; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=jSc7LlSz/x0lQKhonWao64exX9IprUKxVC59jaARhcY=;
 b=TuVOmt6jkStq5jpp4J+cSvRsgiYNnIg6+Ffs13gv8NxWeBtEiUV3LRr2DxseRz3BfeqC34
 t42M4EmYQ74OBM+FS9ejjIVBm2cTeVhoZ/g0qzk5dlx4zGhJuA3VR+e+P4GZr47/hOhLGb
 M5B7SbYbVd+xJXMaOzRhxw80TDrNwuI6p9cbQryeNcuEKUvhHAd7VR+or3eNFl1czlhIcR
 Qpdt7mPj8nYpKK2Y5XmupIRQ8ckFN7WTW478KW2P04un3Sjx45yafhSjx2G1kXCK7XpkJh
 haF5J7NCVWT8ahrwiHFe16AORsfimiUyGMnOcUOQcdkaaBARM0pnaqkjJhjjlQ==
From: "Feng zhou" <zhoufeng.zf@bytedance.com>
Message-Id: <20260509053751.45007-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Feng zhou <zhoufeng.zf@bytedance.com>
Subject: [PATCH v5.15.205] ipv4: set SKBFL_SHARED_FRAG in the right skb field
Date: Sat,  9 May 2026 13:37:51 +0800
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <gregkh@linuxfoundation.org>, <imv4bel@gmail.com>, <h3xrabbit@gmail.com>, 
	<steffen.klassert@secunet.com>, <benh@debian.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yangzhenze@bytedance.com>, <wangdongdong.6@bytedance.com>, 
	<zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.50.1
X-Lms-Return-Path: <lba+269fec843+c621ba+vger.kernel.org+zhoufeng.zf@bytedance.com>
X-Rspamd-Queue-Id: 7ED2A4FE258
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286105-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com,secunet.com,debian.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoufeng.zf@bytedance.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:mid,bytedance.com:dkim]
X-Rspamd-Action: no action

From: Feng Zhou <zhoufeng.zf@bytedance.com>

commit ab8b995323e5237041472d07e5055f5f7dcdf15b
("xfrm: esp: avoid in-place decrypt on shared skb frags")
backported the shared frag marking to ip_append_page(), but it writes
SKBFL_SHARED_FRAG to skb_shinfo(skb)->tx_flags.

SKBFL_SHARED_FRAG is a skb_shared_info::flags bit, so storing it in
skb_shinfo(skb)->tx_flags does not mark the skb as carrying shared
frags for later consumers.

Set the bit in skb_shinfo(skb)->flags instead. This makes the
backport actually tag spliced UDP pages as shared and restores the
protection intended for the ESP-in-UDP path.

Fixes: ab8b995323e5237041472d07e5055f5f7dcdf15b ("xfrm: esp: avoid in-place decrypt on shared skb frags")
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 net/ipv4/ip_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 68509e1f89b5b..5d8f8a5901bc6 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1443,7 +1443,7 @@ ssize_t	ip_append_page(struct sock *sk, struct flowi4 *fl4, struct page *page,
 			goto error;
 		}
 
-		skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
+		skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 
 		if (skb->ip_summed == CHECKSUM_NONE) {
 			__wsum csum;
-- 
2.39.5


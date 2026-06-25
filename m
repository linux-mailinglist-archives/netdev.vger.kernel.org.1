Return-Path: <netdev+bounces-302021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R05pBCVSPWoj1QgAu9opvQ
	(envelope-from <netdev+bounces-302021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:07:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6296C7504
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:07:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="UpyAnn/g";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302021-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302021-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 668563091538
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAAC3264FF;
	Thu, 25 Jun 2026 16:05:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4E3C10A1
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:05:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403515; cv=none; b=iCTBYEeddNg/u4zptw6/AoluSl+nKV2zGRU7afbck2zOFlOa6CxNFGPNPed/5AxKvUguu6c6sP7GGC6hxZEweHsaH+6JkjrbI0rJhWjm4bIK6HLC2Vc1L8+4yQtzMbcSOF0AkUmmp1QLPzBxs215oExiMGSplj2LVfy9iYQDDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403515; c=relaxed/simple;
	bh=2zknjp4KEwoStsh3baAqtyrh88HafZb5I4gpP6cPQWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OnWP7MUf6vFSzgjBX5YUNH2j7jLiHIEvYKs4LwCblfUkBbWcaoYtEbhyQhXHhCUh3yttn1seWGvNoU3U/EoGDDJqV2wjXPeJSbno3jFg+L3dz3PeWVPsqkIn6ssoekR/9O4J6BCTfStUzoynD4iqTZNKVh1Zj2NOOgmdm4dbBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpyAnn/g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1C51F000E9;
	Thu, 25 Jun 2026 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782403512;
	bh=T1gW0Cc9o60Vp4qxG4NmhRcqrLFX/LrDP+KCQYtN4sA=;
	h=From:To:Cc:Subject:Date;
	b=UpyAnn/gpPHRBz3iN8cxSomyv8a1nOqASvPIb9195Nf+4KHvWDBfhZXXp14tcRF2S
	 GSYFVeNUg8T+BfNr+j9mzuGl2Lqv8jYjd5s2NFQBxgacrAzETisf7MVplZPnC+rJ2O
	 lVl8qdzUqo3tTpHvSkCsE0WAwNNCqKiCzlcveU56dQafRWSzucv5fc1ATM56ZuqJsu
	 O0gHbdfJupDiIwtX85/3fSo4oM4299Y46Mt0pjyN6rEeEuMcQZKw1tbTudo8qDXQtU
	 skLF8kDjSAl3+ZybfV2QnR8lPSXSgpClOoun8k7D5dL/hYJfCPpME/G/dB7jIGILoo
	 kDXLyZn/vgJTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net] eth: fbnic: don't cache shinfo across skb realloc
Date: Thu, 25 Jun 2026 09:05:08 -0700
Message-ID: <20260625160508.3327986-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302021-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:alexanderduyck@fb.com,m:kernel-team@meta.com,m:mohsin.bashr@gmail.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,fb.com,meta.com,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E6296C7504

fbnic_tx_lso() calls skb_cow_head() which may reallocate the skb
including the shared info. We can't use the pointer calculated
before the call.

    BUG: KASAN: slab-use-after-free in fbnic_tx_lso.isra.0+0x668/0x8e0
    Read of size 4 at addr ff110000262edd98 by task swapper/5/0
    Call Trace:
     fbnic_tx_lso.isra.0+0x668/0x8e0
     fbnic_xmit_frame+0x622/0xba0
     dev_hard_start_xmit+0xf4/0x620

    Allocated by task 8653:
     __alloc_skb+0x11e/0x5f0
     alloc_skb_with_frags+0xcc/0x6c0
     sock_alloc_send_pskb+0x327/0x3f0
     __ip_append_data+0x188b/0x47a0
     ip_make_skb+0x24a/0x300
     udp_sendmsg+0x14d2/0x21e0

    Freed by task 0:
     kfree+0x123/0x5a0
     pskb_expand_head+0x36c/0xfa0
     fbnic_tx_lso.isra.0+0x500/0x8e0
     fbnic_xmit_frame+0x622/0xba0
     dev_hard_start_xmit+0xf4/0x620
     sch_direct_xmit+0x25b/0x1100

    The buggy address belongs to the object at ff110000262edc40
     which belongs to the cache skbuff_small_head of size 640
    The buggy address is located 344 bytes inside of
     freed 640-byte region [ff110000262edc40, ff110000262ede

Link: https://netdev.bots.linux.dev/logs/vmksft/fbnic-qemu-dbg/results/705762/15-uso-py/stderr
Fixes: b0b0f52042ac ("eth: fbnic: support TCP segmentation offload")
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kernel-team@meta.com
CC: mohsin.bashr@gmail.com
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 9cd85a0d0c3a..401f8b8ae1ca 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -194,16 +194,18 @@ static bool fbnic_tx_tstamp(struct sk_buff *skb)
 
 static bool
 fbnic_tx_lso(struct fbnic_ring *ring, struct sk_buff *skb,
-	     struct skb_shared_info *shinfo, __le64 *meta,
-	     unsigned int *l2len, unsigned int *i3len)
+	     __le64 *meta, unsigned int *l2len, unsigned int *i3len)
 {
 	unsigned int l3_type, l4_type, l4len, hdrlen;
+	struct skb_shared_info *shinfo;
 	unsigned char *l4hdr;
 	__be16 payload_len;
 
 	if (unlikely(skb_cow_head(skb, 0)))
 		return true;
 
+	shinfo = skb_shinfo(skb);
+
 	if (shinfo->gso_type & SKB_GSO_PARTIAL) {
 		l3_type = FBNIC_TWD_L3_TYPE_OTHER;
 	} else if (!skb->encapsulation) {
@@ -258,7 +260,6 @@ fbnic_tx_lso(struct fbnic_ring *ring, struct sk_buff *skb,
 static bool
 fbnic_tx_offloads(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 {
-	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	unsigned int l2len, i3len;
 
 	if (fbnic_tx_tstamp(skb))
@@ -273,8 +274,8 @@ fbnic_tx_offloads(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 	*meta |= cpu_to_le64(FIELD_PREP(FBNIC_TWD_CSUM_OFFSET_MASK,
 					skb->csum_offset / 2));
 
-	if (shinfo->gso_size) {
-		if (fbnic_tx_lso(ring, skb, shinfo, meta, &l2len, &i3len))
+	if (skb_is_gso(skb)) {
+		if (fbnic_tx_lso(ring, skb, meta, &l2len, &i3len))
 			return true;
 	} else {
 		*meta |= cpu_to_le64(FBNIC_TWD_FLAG_REQ_CSO);
-- 
2.54.0



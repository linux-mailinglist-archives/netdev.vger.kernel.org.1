Return-Path: <netdev+bounces-247763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE2DCFE80E
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 16:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFE91307B810
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC6A340A69;
	Wed,  7 Jan 2026 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b="Ia/hipUu"
X-Original-To: netdev@vger.kernel.org
Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4631340A63
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795405; cv=pass; b=Mgq11xhxc/eZzuLDfGPa8K1wd42RJL9P+P8VwONZMP4677aab50QjbG9bBe7UZU06vLugN0IhP0xbXjnZbvPw6j7VpM+wYmpxtl+rA8oIDSwVEM16zDtIOVqaK4+dxNh1/xs9fFAHJFHSJLYKExM8e8ryW1xHHS+m8MJwnMcqPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795405; c=relaxed/simple;
	bh=5tWfp6lTjiR/sOdjnzTVc4X9rNUVtckGPL72yiDsgpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Knkmja0SZ106LshVFHMfPpV9OYzv0kAo0V3IGMOvb0e8BQ98wCY551JqrJx/vreR82dsZkRNnBZCJ6lqXKA0VOSKc5ONk2xJkyDW1WPDCFu60bPIXX3HYx4O2CtkDExtf0R7xuNBBFoFdt/67VN8VdymOAHZ1eAsOFSYWHhXhE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b=Ia/hipUu; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
ARC-Seal: i=1; a=rsa-sha256; t=1767795363; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=P965lIA2fVmbqVZHpwAbPCIoZj5H05jBrQ+DjXaEH+KRsxkokPEngtPm6B3z65OqY4x4ayLk4sIwJxEGE/DpJnznz1T+NLxMRRsbRmy9MY2r4ROQgwm9AyG2qvboKFFVXPZFOOCTAINHM/E8pgAvbovPM4dU9R1/JSjq6R7RV2s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1767795363; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8CnP4gzfUddA+inPqcTXFd8UiJ4Xselc0fuYBMujNS4=; 
	b=ASmQpBRWPyzJYu4vvRpPs3N+5kx2iqAS9fqYr+AO43FKltHRrMlgXUiY3zRlAgS8FIt3rAP0MmkgOgWP5t5O3HhKMIroa+poXkQASlxrbpbG2Yd2nZkCdLpmFOEJwjzNiksk8R1990E/JYUDlnywd+7/XSWYjB6STQhjvr6oBMw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=kshitiz.bartariya@zohomail.in;
	dmarc=pass header.from=<kshitiz.bartariya@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767795363;
	s=zoho; d=zohomail.in; i=kshitiz.bartariya@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8CnP4gzfUddA+inPqcTXFd8UiJ4Xselc0fuYBMujNS4=;
	b=Ia/hipUu8ywUJ2GqDWONHJFp5LwWQypxVIuLbrDtZwvmqGqx0MKOa7njNHBrWgul
	fVQGA2ntVyrBa24JSg0YkbyFNfneLGmwPGZKR7nL4Cfs/tfrvJZa64pku5d9qdSwNyX
	4NquohNBZ8Br2gqaPp5Z4I59SgiwJoaKotJgDRoA=
Received: by mx.zoho.in with SMTPS id 1767795355995620.6722509294242;
	Wed, 7 Jan 2026 19:45:55 +0530 (IST)
From: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
Subject: =?UTF-8?q?=5BPATCH=C2=A0net-next=5D=20=5F=5Fudp=5Fenqueue=5Fschedule=5Fskb=28=29=20drops=20packets=20when=20there=20is=20no=20buffer=20space=20available=2C=20but=20currently=20does=20not=20update=20UDP=20SNMP=20counters=2E?=
Date: Wed,  7 Jan 2026 19:45:36 +0530
Message-ID: <20260107141541.1985-1-kshitiz.bartariya@zohomail.in>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Update UDP_MIB_MEMERRORS and UDP_MIB_INERRORS when packets are dropped
due to memory pressure, for both UDP and UDPLite sockets.

This removes a long-standing TODO and makes UDP statistics consistent
with actual drop behavior.

Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
---
 net/ipv4/udp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9c87067c74bc..66c06f468240 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1794,11 +1794,16 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (unlikely(to_drop)) {
+		const bool is_udplite = IS_UDPLITE(sk);
+
 		for (nb = 0; to_drop != NULL; nb++) {
 			skb = to_drop;
 			to_drop = skb->next;
 			skb_mark_not_on_list(skb);
-			/* TODO: update SNMP values. */
+
+			UDP_INC_STATS(sock_net(sk), UDP_MIB_MEMERRORS, is_udplite);
+			UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
+
 			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		}
 		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
-- 
2.50.1 (Apple Git-155)



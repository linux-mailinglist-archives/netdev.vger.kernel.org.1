Return-Path: <netdev+bounces-277155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIbkEFwl2Gm9YggAu9opvQ
	(envelope-from <netdev+bounces-277155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:17:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B3D3D02FC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D68E3010BB0
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 22:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8EA3368B2;
	Thu,  9 Apr 2026 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dh3UIER3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cAVY36R2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dh3UIER3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cAVY36R2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB282F12AC
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773017; cv=none; b=rDGAEUs+4DtTdwXDfMoG6qvnSdN4n7J3lghP6enZQCpA9m7VT7RXnarjVgBlZxuaImKD78BC9BK4BAViu2LDEt4RuqwMHU19DU2O3xQOdpWE47pRp+shmbIWnfyeRtfBlWUNvK5T4gERVbLnWrBnA5mvuUryGQt43Op+CEuW55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773017; c=relaxed/simple;
	bh=aXGljwR8wxR+ivNAI7rAzHeJHd0uentiXbGo58KW+6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aA69kQlBUv+0cLXGUGtL2opL6/3ufhLREHGffhqP1gZe2I0VqE0rEZ61A4xR7AnFkhGrzFj0mPvUiJQ8PEEMmQpYEqOYJShqdgHKcqqdzZu2dYRu2lXZZKyESrVeOiRqh9cYoBOUmC35ebilibRdeTwhdVPi5SaMCnnR4QtJ4zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dh3UIER3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cAVY36R2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dh3UIER3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cAVY36R2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B7085BCEF;
	Thu,  9 Apr 2026 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775773014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=M317jivCkfvs0eEBD6JZyDGdl/WOEa3dpIHNc1mmByY=;
	b=Dh3UIER3obY/PMw0+GYs/ZP+4okhZgeI7fPyR+7n+XLFOUPAJ5j1HUXpSe5siq0y4IzFjP
	NDW4a935A/qUqjqv33nkCm2+PCbOvJH/GRSrt5B3BofDA1Ka/5Bx3iMwObV0Z8DbS+No7y
	4icrJe1OzOO1KfhUjVLXKw4xZ7cKj64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775773014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=M317jivCkfvs0eEBD6JZyDGdl/WOEa3dpIHNc1mmByY=;
	b=cAVY36R22tHdc6wQeEyo/XdlqTUWabIY9XVSOYuL8/jkMph1Q+iwELAnnYV/DIB7caU7sX
	XLDgQpmjIzKS4IAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dh3UIER3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cAVY36R2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775773014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=M317jivCkfvs0eEBD6JZyDGdl/WOEa3dpIHNc1mmByY=;
	b=Dh3UIER3obY/PMw0+GYs/ZP+4okhZgeI7fPyR+7n+XLFOUPAJ5j1HUXpSe5siq0y4IzFjP
	NDW4a935A/qUqjqv33nkCm2+PCbOvJH/GRSrt5B3BofDA1Ka/5Bx3iMwObV0Z8DbS+No7y
	4icrJe1OzOO1KfhUjVLXKw4xZ7cKj64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775773014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=M317jivCkfvs0eEBD6JZyDGdl/WOEa3dpIHNc1mmByY=;
	b=cAVY36R22tHdc6wQeEyo/XdlqTUWabIY9XVSOYuL8/jkMph1Q+iwELAnnYV/DIB7caU7sX
	XLDgQpmjIzKS4IAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A7D44A0B3;
	Thu,  9 Apr 2026 22:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jW12N1Ul2GmhPgAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 09 Apr 2026 22:16:53 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH] udp: Force compute_score to always inline
Date: Thu,  9 Apr 2026 18:15:32 -0400
Message-ID: <20260409221532.69090-1-krisman@suse.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-277155-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krisman@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 95B3D3D02FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Back in 2024 I reported a 7-12% regression on an iperf3 UDP loopback
thoughput test that we traced to the extra overhead of calling
compute_score on two places, introduced by commit f0ea27e7bfe1 ("udp:
re-score reuseport groups when connected sockets are present").  At the
time, I pointed out the overhead was caused by the multiple calls,
associated with cpu-specific mitigations, and merged commit
50aee97d1511 ("udp: Avoid call to compute_score on multiple sites") to
jump back explicitly, to force the rescore call in a single place.

Recently though, we got another regression report against a newer distro
version, which a team colleague traced back to the same root-cause.
Turns out that once we updated to gcc-13, the compiler got smart enough
to unroll the loop, undoing my previous mitigation.  Let's bite the
bullet and __always_inline compute_score on both ipv4 and ipv6 to
prevent gcc from de-optimizing it again in the future.  These functions
are only called in two places each, udpX_lib_lookup1 and
udpX_lib_lookup2, so the extra size shouldn't be a problem and it is hot
enough to be very visible in profilings.  In fact, with gcc13, forcing
the inline will prevent gcc from unrolling the fix from commit
50aee97d1511, so we don't end up increasing udpX_lib_lookup2 at all.

I haven't recollected the results myself, as I don't have access to the
machine at the moment.  But the same colleague reported 4.67%
inprovement with this patch in the loopback benchmark, solving the
regression report within noise margins.

Fixes: 50aee97d1511 ("udp: Avoid call to compute_score on multiple sites")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 net/ipv4/udp.c | 8 ++++----
 net/ipv6/udp.c | 9 +++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6c6b68a66dcd..e591e2ab0d7d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -365,10 +365,10 @@ int udp_v4_get_port(struct sock *sk, unsigned short snum)
 	return udp_lib_get_port(sk, snum, hash2_nulladdr);
 }
 
-static int compute_score(struct sock *sk, const struct net *net,
-			 __be32 saddr, __be16 sport,
-			 __be32 daddr, unsigned short hnum,
-			 int dif, int sdif)
+static __always_inline int
+compute_score(struct sock *sk, const struct net *net,
+	      __be32 saddr, __be16 sport, __be32 daddr,
+	      unsigned short hnum, int dif, int sdif)
 {
 	int score;
 	struct inet_sock *inet;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 010b909275dd..889d229aad61 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -127,10 +127,11 @@ void udp_v6_rehash(struct sock *sk)
 	udp_lib_rehash(sk, new_hash, new_hash4);
 }
 
-static int compute_score(struct sock *sk, const struct net *net,
-			 const struct in6_addr *saddr, __be16 sport,
-			 const struct in6_addr *daddr, unsigned short hnum,
-			 int dif, int sdif)
+static __always_inline int
+compute_score(struct sock *sk, const struct net *net,
+	      const struct in6_addr *saddr, __be16 sport,
+	      const struct in6_addr *daddr, unsigned short hnum,
+	      int dif, int sdif)
 {
 	int bound_dev_if, score;
 	struct inet_sock *inet;
-- 
2.52.0



Return-Path: <netdev+bounces-277470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFiAJJ8f2WkQmggAu9opvQ
	(envelope-from <netdev+bounces-277470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:04:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C27A3DA0A3
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69C513006159
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27E73DA5C8;
	Fri, 10 Apr 2026 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O1hVW7xU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5u8IoigD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O1hVW7xU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5u8IoigD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BDE3DA5C1
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836784; cv=none; b=sOI1Cu9WGUZJc1pvLeVCcUIv/mafwumzKaz4/KwQtXcW6qg0J5+I0NUP19fpdBC07jH4ibDY+2v5IccnpB1P5F4yql9mzAUtlOcMD1jBq1ekPwXqexvPuUerkpQ/oN8uyFQvYbrxvrx3V+ZRzGMqhgsHxhCCrKMytY7c7aQAD/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836784; c=relaxed/simple;
	bh=GBeemjr/vXE55b3FuUq6lxhDo65Pmeh+YlNphWxsbRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkKITkrWYSb0ke2KTNu0ciVp4u/ItsFLeuGrUd+2TuCnUnyITggodqjtovhnvUn/AHOjqshV63jJPn/DFfmJINS//HeaYLunK1qTdx3F+V6Jg8kI8K4gyYIsaKnz20qw+NKu7bZCOCMJ3+Pza5efJoemsPfQPLQ9qTpt9mOYPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O1hVW7xU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5u8IoigD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O1hVW7xU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5u8IoigD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EEA15BDE6;
	Fri, 10 Apr 2026 15:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775836781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lE8cNDdtfJhg6IFDH4Z3sGwF3+x6WzgYPoRNG5YPyfM=;
	b=O1hVW7xUmbaC0Ge9EiKPavmW4kwoym8jH6Ol4nEPyIQovdvyrsk96goBGOCTBoIok95dd8
	PVRptdFQ8wo7Xg/Ju+yKVbT0KtiH+o7bFLvsHDxf5IV8nNIfL3VdX1jJHWnz13/2DbN73U
	+ksWP2Qk9xmvCzyZS09JOGU1w1P17H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775836781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lE8cNDdtfJhg6IFDH4Z3sGwF3+x6WzgYPoRNG5YPyfM=;
	b=5u8IoigDP9t7aZ8YrHF938rXiuat6mf1Q+cWRRRvDBokUsLJT2EzF7hnpDurdF/YBTBkID
	7tP3edyaUI3iC6Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775836781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lE8cNDdtfJhg6IFDH4Z3sGwF3+x6WzgYPoRNG5YPyfM=;
	b=O1hVW7xUmbaC0Ge9EiKPavmW4kwoym8jH6Ol4nEPyIQovdvyrsk96goBGOCTBoIok95dd8
	PVRptdFQ8wo7Xg/Ju+yKVbT0KtiH+o7bFLvsHDxf5IV8nNIfL3VdX1jJHWnz13/2DbN73U
	+ksWP2Qk9xmvCzyZS09JOGU1w1P17H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775836781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lE8cNDdtfJhg6IFDH4Z3sGwF3+x6WzgYPoRNG5YPyfM=;
	b=5u8IoigDP9t7aZ8YrHF938rXiuat6mf1Q+cWRRRvDBokUsLJT2EzF7hnpDurdF/YBTBkID
	7tP3edyaUI3iC6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F26474A0B2;
	Fri, 10 Apr 2026 15:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3sL3Lmwe2WkqQgAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 10 Apr 2026 15:59:40 +0000
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
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH v2] udp: Force compute_score to always inline
Date: Fri, 10 Apr 2026 11:59:36 -0400
Message-ID: <20260410155936.654915-1-krisman@suse.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-277470-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krisman@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 3C27A3DA0A3
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

Eric Dumazet reported no size change to vmlinux when built with clang.
I report the same also with gcc-13:

scripts/bloat-o-meter vmlinux vmlinux-inline
add/remove: 0/2 grow/shrink: 4/0 up/down: 616/-416 (200)
Function                                     old     new   delta
udp6_lib_lookup2                             762     949    +187
__udp6_lib_lookup                            810     975    +165
udp4_lib_lookup2                             757     906    +149
__udp4_lib_lookup                            871     986    +115
__pfx_compute_score                           32       -     -32
compute_score                                384       -    -384
Total: Before=35011784, After=35011984, chg +0.00%

Fixes: 50aee97d1511 ("udp: Avoid call to compute_score on multiple sites")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
v2:
  - update comment in udpX_lib_lookup2(Willem)
  - add bloat-o-meter information (Eric)
---
 net/ipv4/udp.c | 12 ++++++------
 net/ipv6/udp.c | 13 +++++++------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6c6b68a66dcd..74b621b20e83 100644
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
@@ -508,8 +508,8 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
 				continue;
 
 			/* compute_score is too long of a function to be
-			 * inlined, and calling it again here yields
-			 * measurable overhead for some
+			 * inlined twice here, and calling it uninlined
+			 * here yields measurable overhead for some
 			 * workloads. Work around it by jumping
 			 * backwards to rescore 'result'.
 			 */
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 010b909275dd..301649a63e8a 100644
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
@@ -260,8 +261,8 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
 				continue;
 
 			/* compute_score is too long of a function to be
-			 * inlined, and calling it again here yields
-			 * measurable overhead for some
+			 * inlined twice here, and calling it uninlined
+			 * here yields measurable overhead for some
 			 * workloads. Work around it by jumping
 			 * backwards to rescore 'result'.
 			 */
-- 
2.52.0



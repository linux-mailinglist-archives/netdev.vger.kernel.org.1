Return-Path: <netdev+bounces-286637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK7aOhHQAWryjwEAu9opvQ
	(envelope-from <netdev+bounces-286637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:48:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF550E2BE
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 673CF3073D28
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2437D3D093C;
	Mon, 11 May 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vyyqbfFz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qx68NNtp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lo28DNyZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n5G/ykAc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF583B6BF4
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502452; cv=none; b=R50zvhDSBdKESAkn1+fnOEatUYudE9BLmxLwEWOl11i+/QDpdv5tyGXwBg1vdPQRtiMTK8VKNp4tMh2C/AiwzHtRIDJvTqMcbijvhdvdbq+clmhW88H3Qnj/i3jgMvVlQm7n0gL1EIeus5WsZHB0bo5S8dq9eIGr+/UW+fEzf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502452; c=relaxed/simple;
	bh=4Ou/XNRtk4tgOOCk2D/f+N5Hguh5Go/3XYIUSgk99OU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AhF+J5viq27JeJV0L2yFzWcBJr6I7ClU7BvxjWvPofcBx+W/BtGIjL7aj0/E1VekuKuOVSOzxtbBlYr5w36BdmiueMYIIa4/uhvBSVTMxJ8fE45sU9G3zM3L/xDNVcUhg2lVA2YP37+3SaXvvUdXv3PhyNGO+M9LQmyId5xptNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vyyqbfFz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qx68NNtp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lo28DNyZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n5G/ykAc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A21B6B830;
	Mon, 11 May 2026 12:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778502444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qU6l/+ER9t/PsjZjUYr1aPdEhYaTfE6GNZ3x1LGiPTw=;
	b=vyyqbfFz8jEd1vz0ItuOti5Tln+6gCW3bt5ux4QuPdxg+Glv+xCW0iLQ98mugU1xuVdx3u
	r/ysxmUforF8iTrzLTNLeVe1G4UUFmrcs2NgM/9S42N+aB+6TRMtczApTSFD3bU7cV1M6/
	Vh8sYgewqzVtUjx1cpWUI7npcBdLC80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778502444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qU6l/+ER9t/PsjZjUYr1aPdEhYaTfE6GNZ3x1LGiPTw=;
	b=Qx68NNtpxrMuPOidtBeRIRjw8zMhhSzbnyie21hPWZUJ6lvae08gohg+EgUdIXkA26ltxX
	6R8EojxbLeEHTWDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Lo28DNyZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="n5G/ykAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778502440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qU6l/+ER9t/PsjZjUYr1aPdEhYaTfE6GNZ3x1LGiPTw=;
	b=Lo28DNyZUQJAOk6SuKOFJCmm6zaQQZfK7PodQPCKYG3kKJJbWLFLz4k0LrbGXcQMkMXthi
	BbLHLMxu6tRDcmGqR5F2olqZ8Ca6J+6SmtaF+Zvu+rD03GFSFJcg+crD/mc6qvKq7VGXJP
	DnmXrXAww5COAhCoj8DUloOGlsoqiy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778502440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qU6l/+ER9t/PsjZjUYr1aPdEhYaTfE6GNZ3x1LGiPTw=;
	b=n5G/ykAcUxh6vBopD9gtHBI4kaHSdWnIKze5dg9lW+fL7F/psrRhvyYZTWc/y/wfgr7JjX
	ax0InhEyEgaxxPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60A36593A3;
	Mon, 11 May 2026 12:27:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BBe5FCfLAWosZgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 11 May 2026 12:27:19 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?=C5=81ukasz=20Stelmach?= <steelman@post.pl>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH 1/2 net v4] ipv6: addrconf: fix temp address generation after prefix deprecation
Date: Mon, 11 May 2026 14:26:45 +0200
Message-ID: <20260511122645.6233-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 6AEF550E2BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286637-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,post.pl:email]
X-Rspamd-Action: no action

When a router temporarily deprecates an IPv6 prefix (either by sending a
Router Advertisement with Preferred Lifetime = 0 or by letting the
lifetime expire) and later restores it, the kernel permanently loses its
ability to generate temporary privacy addresses (RFC 8981) for that
prefix.

This happens because the address worker attempts to generate a
replacement temporary address when the current one nears expiration. As
the base prefix is deprecated already, the generation fails after
marking the temporary address as already having spawned a replacement
(ifp->regen_count++).

When the router eventually restores the prefix, the temporary address
becomes active again. However, once it naturally expires, the address
worker sees this temporary address already tried to generate one and
skips the regeneration.

Fix this by checking if all temporary addresses for a given prefix have
already tried to spawn a replacement when processing a new RA. If so,
spawn a new temporary address.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Łukasz Stelmach <steelman@post.pl>
Closes: https://lore.kernel.org/netdev/87340td30q.fsf%25steelman@post.pl/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: adjusted commit message, adjusted the implementation to cover all
race conditions
v3: regen now if ipv6_create_tempaddr failed due to timer to avoid an
infinite loop as we restart the loop and we need to check now against
prefered_lft again.
v4: change the proposed fix completely, now we address the problem when
doing manage_tempaddrs().
---
 net/ipv6/addrconf.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5476b6536eb7..18a6f2de30ce 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2595,8 +2595,9 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 			     __u32 valid_lft, __u32 prefered_lft,
 			     bool create, unsigned long now)
 {
-	u32 flags;
 	struct inet6_ifaddr *ift;
+	bool all_regen = true;
+	u32 flags;
 
 	read_lock_bh(&idev->lock);
 	/* update all temporary addresses in the list */
@@ -2637,6 +2638,8 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 		ift->tstamp = now;
 		if (prefered_lft > 0)
 			ift->flags &= ~IFA_F_DEPRECATED;
+		if (!ift->regen_count)
+			all_regen = false;
 
 		spin_unlock(&ift->lock);
 		if (!(flags&IFA_F_TENTATIVE))
@@ -2644,12 +2647,14 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 	}
 
 	/* Also create a temporary address if it's enabled but no temporary
-	 * address currently exists.
+	 * address currently exists or if all temporary addresses already
+	 * generated an address.
 	 * However, we get called with valid_lft == 0, prefered_lft == 0, create == false
 	 * as part of cleanup (ie. deleting the mngtmpaddr).
 	 * We don't want that to result in creating a new temporary ip address.
 	 */
-	if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
+	if ((list_empty(&idev->tempaddr_list) || all_regen) &&
+	    (valid_lft || prefered_lft))
 		create = true;
 
 	if (create && READ_ONCE(idev->cnf.use_tempaddr) > 0) {
-- 
2.53.0



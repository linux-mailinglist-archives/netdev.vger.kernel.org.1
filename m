Return-Path: <netdev+bounces-156713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECDDA07928
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11443A5869
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08C521A44D;
	Thu,  9 Jan 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B0Bsn4W2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wr4jZuvo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B0Bsn4W2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wr4jZuvo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E22F290F;
	Thu,  9 Jan 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432852; cv=none; b=tVDEMoAUlQWkrxB4plYhpSO8ob231qSc6E9u33SnUEqqDqzcdBkUr/KMXu8x58tZ8MlWXO6R5BPEMS0AUAL/oMkl6uA6DKGiYZOTrvUzkVCrwhP1HBzpAefEdTijcoXMo6y3VY/XU592t/wNDwT2DSCArIRdQXmrSUZAlwjLvH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432852; c=relaxed/simple;
	bh=PUmb56I7KTJtKIdqMVsU3NMyRUD0ZjqTr3GWvqRSBlc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=JT4qZU58V+DCfVnQSSJoBirvP1TKRldZ9049zphN94YA1FZUXjhfoEZI77JakiDGTNhf3iPH0imPwi+sXJCevIBEEM/Z7spIUMAeOix6A1EZObaQI7BGKE1fqk63XvPgPHamseSpVXQ5j3PoQPKTjHaN7w3u7xOZCcF8qCMgesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B0Bsn4W2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wr4jZuvo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B0Bsn4W2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wr4jZuvo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 189AE1F394;
	Thu,  9 Jan 2025 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736432849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ipqhv2GD2EwRQw0OEk2Ebn3ox1nsvYbLwLp+WjGA3jE=;
	b=B0Bsn4W2J/SZ0Pg1OBQKQMsq9cASji2SC5Zcby4k0KovaeibzRbMyjZm/p9lIB6ZdcszDE
	5bpZHyx0wjFEDOlEa73z/5Ntq/qjf1CmYFsXCL61DPnB5wddaXTtbzAiGNdArD2Jj7AE0w
	LL2cFfBXNW2DEpy27lpymSNFyAMN7KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736432849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ipqhv2GD2EwRQw0OEk2Ebn3ox1nsvYbLwLp+WjGA3jE=;
	b=wr4jZuvoNYvg+QHCEbT7YGN84lczCzXHuIq+ZyliggH0mw5R6tm2qK8rBnC2Z+O9M6rVRi
	bSzKChc5CCkxZDCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=B0Bsn4W2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wr4jZuvo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736432849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ipqhv2GD2EwRQw0OEk2Ebn3ox1nsvYbLwLp+WjGA3jE=;
	b=B0Bsn4W2J/SZ0Pg1OBQKQMsq9cASji2SC5Zcby4k0KovaeibzRbMyjZm/p9lIB6ZdcszDE
	5bpZHyx0wjFEDOlEa73z/5Ntq/qjf1CmYFsXCL61DPnB5wddaXTtbzAiGNdArD2Jj7AE0w
	LL2cFfBXNW2DEpy27lpymSNFyAMN7KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736432849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ipqhv2GD2EwRQw0OEk2Ebn3ox1nsvYbLwLp+WjGA3jE=;
	b=wr4jZuvoNYvg+QHCEbT7YGN84lczCzXHuIq+ZyliggH0mw5R6tm2qK8rBnC2Z+O9M6rVRi
	bSzKChc5CCkxZDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0142D139AB;
	Thu,  9 Jan 2025 14:27:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uLcnANHcf2eLXwAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Thu, 09 Jan 2025 14:27:29 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] gro_cells: Avoid packet re-ordering for cloned skbs
Date: Thu,  9 Jan 2025 15:27:24 +0100
Message-Id: <20250109142724.29228-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 189AE1F394
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

gro_cells_receive() passes a cloned skb directly up the stack and
could cause re-ordering against segments still in GRO. To avoid
this copy the skb and let GRO do it's work.

Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 net/core/gro_cells.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index ff8e5b64bf6b..2f8d688f9d82 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -20,11 +20,20 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 	if (unlikely(!(dev->flags & IFF_UP)))
 		goto drop;
 
-	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
+	if (!gcells->cells || netif_elide_gro(dev)) {
+netif_rx:
 		res = netif_rx(skb);
 		goto unlock;
 	}
+	if (skb_cloned(skb)) {
+		struct sk_buff *n;
 
+		n = skb_copy(skb, GFP_KERNEL);
+		if (!n)
+			goto netif_rx;
+		kfree_skb(skb);
+		skb = n;
+	}
 	cell = this_cpu_ptr(gcells->cells);
 
 	if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_backlog)) {
-- 
2.35.3



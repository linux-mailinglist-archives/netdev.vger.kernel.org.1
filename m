Return-Path: <netdev+bounces-273980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNqqIHHYzGnnWwYAu9opvQ
	(envelope-from <netdev+bounces-273980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:33:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E1376DEF
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 845A530C17F4
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935733AA512;
	Wed,  1 Apr 2026 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OaBm4nOV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jz+sW3aT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OaBm4nOV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jz+sW3aT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D33A4F34
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031471; cv=none; b=GNqsgptd+TsVmrxJYwOkxN1yKvTSeG7Sjj7PPp+QMzcKXQDUImWxZTBKzZ+cO8kXkyhRlMeLEItV0ZEiRv4e8onEujrQTZQkN91icJpLhlmU60aBP9HQhIwtSH5LOpe4FdcEyuESoO9b5G4iDOXtYxnrjYOmbod2KhX4d/BdPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031471; c=relaxed/simple;
	bh=UIEa237z5KoVASskoiZkfFzSee0Icc3k/1v9+CFrHlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6URYadZfF7K2H7tD5jkTYHTmocM8cZPgepbq/qR2exkSGZeD8zi8lkOaEdslxrqMdFcclsRwNdbAwToMLvmCnBAEOouvHeoyDLdYd9ltPGEEqD3M+N4qsgf8vMA28DoA21G9Kg8V2SplafLS1Z7npIMq/1h8yMO4wImdpVG/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OaBm4nOV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jz+sW3aT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OaBm4nOV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jz+sW3aT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 845E05BCDD;
	Wed,  1 Apr 2026 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775031468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NP0egGP4n7z1T94grPTVDKDrodrCqJJR2SBJLmpNaRY=;
	b=OaBm4nOV31zBZh4+baTWg00oceJfaWqntA4vycx6VTggcHCkGFQxQ4BFRFlhyX6Rh+BfDG
	h1Uo9Gq66fHBueDPem9Bx00fW2jX/46zKaCqpgTMPRx/Pnlq+iUKzF58yJc1PDHb+gjULD
	eXlEps31sKxYnHHlwuAY71S2evLoa10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775031468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NP0egGP4n7z1T94grPTVDKDrodrCqJJR2SBJLmpNaRY=;
	b=Jz+sW3aToyJ+86KCxpl6gYirGIpYL9Syx3EtkDZRBsiKloVGJ0oOjcTlMMy4DMn3PO6HFX
	uU+cYddK9v31ZOAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775031468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NP0egGP4n7z1T94grPTVDKDrodrCqJJR2SBJLmpNaRY=;
	b=OaBm4nOV31zBZh4+baTWg00oceJfaWqntA4vycx6VTggcHCkGFQxQ4BFRFlhyX6Rh+BfDG
	h1Uo9Gq66fHBueDPem9Bx00fW2jX/46zKaCqpgTMPRx/Pnlq+iUKzF58yJc1PDHb+gjULD
	eXlEps31sKxYnHHlwuAY71S2evLoa10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775031468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NP0egGP4n7z1T94grPTVDKDrodrCqJJR2SBJLmpNaRY=;
	b=Jz+sW3aToyJ+86KCxpl6gYirGIpYL9Syx3EtkDZRBsiKloVGJ0oOjcTlMMy4DMn3PO6HFX
	uU+cYddK9v31ZOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF8B54A0B0;
	Wed,  1 Apr 2026 08:17:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uTSkL6vUzGlmegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 08:17:47 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	petrm@nvidia.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kees@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/2 net v2] ipv4: nexthop: avoid duplicate NHA_HW_STATS_ENABLE on nexthop group dump
Date: Wed,  1 Apr 2026 10:17:40 +0200
Message-ID: <20260401081741.4273-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273980-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 8B7E1376DEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently NHA_HW_STATS_ENABLE is included twice everytime a dump of
nexthop group is performed with NHA_OP_FLAG_DUMP_STATS. As all the stats
querying were moved to nla_put_nh_group_stats(), leave only that
instance of the attribute querying.

Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: patch added on this revision
---
 net/ipv4/nexthop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index c942f1282236..a0c694583299 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -902,8 +902,7 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 		goto nla_put_failure;
 
 	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
-	    (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats) ||
-	     nla_put_nh_group_stats(skb, nh, op_flags)))
+	    nla_put_nh_group_stats(skb, nh, op_flags))
 		goto nla_put_failure;
 
 	return 0;
-- 
2.53.0



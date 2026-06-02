Return-Path: <netdev+bounces-294336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tc0zO6QhH2rYhQAAu9opvQ
	(envelope-from <netdev+bounces-294336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:32:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D4863117C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:32:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1FU9Fyow;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eskRAaZ2;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1FU9Fyow;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eskRAaZ2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294336-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294336-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26D1D3004622
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F6C396585;
	Tue,  2 Jun 2026 18:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C331AA9B
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:31:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425105; cv=none; b=WNxKTY21arkSnoAj7Uo8oRXXfvPEzmUPM+xPmL3ERHijJcfTqOjImU1snPl53nWn0l+ZB7BCJ9A/ZJr+rDZdMJ6SYfx6Wsg3SrG/ggTvtx1Ouhz1eie6ToRGHrQ1ckfIFfQZXCEihWUyvNCkzrN+yNqNJRjFmryjIbbx7HNcMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425105; c=relaxed/simple;
	bh=Ew5vefU+mgSPol9Qvpg7eKF4q+ddAlHEO2sb1Wm3J/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYHuXMyVqFfG/Y6ix+Q8uLyZRph0/CdJ0yVSYk7j1dK1CkrpOPhwQXEZjHmFrIWEZskl1KwhR2cshVsmm4pzgw6u9gLjdCdeMsYhlzZ5pQ8ibCgBJUU24WNWdVELhQ5lObLDAOLy1n1PEZf2v0D8s+Nfpa4EfZ79pBD39fkbSLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1FU9Fyow; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eskRAaZ2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1FU9Fyow; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eskRAaZ2; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58A1D6AF08;
	Tue,  2 Jun 2026 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780425101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dVvmWIQsbYCW4qeWXvktTCWvRA7yElcuono/iggMNmw=;
	b=1FU9FyowV+cggrwzjroEuXqlmkeP4q4qYMFJEDhQEOwuxe8r/DLeWnkpnt1msN5EArfHHI
	c/cxAMoMF7s38+3qe7eJfwbips7Z8REt313jMuGHQoKMuqMfMEwZ9Wch9tKEPseTaf7/LA
	EysgQ23J9T3HL2i22cSSCUNnFMssEJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780425101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dVvmWIQsbYCW4qeWXvktTCWvRA7yElcuono/iggMNmw=;
	b=eskRAaZ2tu02jflI/8FBuZuunrCjZGM0TAO8XhauiG5Rr5z0v2Y8tWgCNXTGpNep0Yg+Lv
	T9ZVglW2dfgUCJCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780425101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dVvmWIQsbYCW4qeWXvktTCWvRA7yElcuono/iggMNmw=;
	b=1FU9FyowV+cggrwzjroEuXqlmkeP4q4qYMFJEDhQEOwuxe8r/DLeWnkpnt1msN5EArfHHI
	c/cxAMoMF7s38+3qe7eJfwbips7Z8REt313jMuGHQoKMuqMfMEwZ9Wch9tKEPseTaf7/LA
	EysgQ23J9T3HL2i22cSSCUNnFMssEJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780425101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dVvmWIQsbYCW4qeWXvktTCWvRA7yElcuono/iggMNmw=;
	b=eskRAaZ2tu02jflI/8FBuZuunrCjZGM0TAO8XhauiG5Rr5z0v2Y8tWgCNXTGpNep0Yg+Lv
	T9ZVglW2dfgUCJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1985779A7;
	Tue,  2 Jun 2026 18:31:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1X5bN4shH2owXQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 02 Jun 2026 18:31:39 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH 0/2] net: isolate SKB data area allocations
Date: Tue,  2 Jun 2026 19:31:20 +0100
Message-ID: <20260602183122.747759-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.54.0
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-294336-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux.dev,gentwo.org,google.com,kernel.org,gmail.com,suse.de];
	FORGED_SENDER(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:akpm@linux-foundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-hardening@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,m:pfalcato@suse.de,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0D4863117C

This is a rather simple series that attempts to address a possible
exploitation avenue - the allocation of skbs around the network stack, which
frequently get user-controlled contents. Found while doing some amateur
exploitation analysis for some other issue, elsewhere.

Patch 0 is a precursor patch that adds a slab allocation helper, patch 1
does the actual bucketing.
I don't know what tree should pick this up, so I just based this on linux-next.

Pedro Falcato (2):
  mm/slab: add a node-track-caller variant for kmem buckets allocation
  net: skb: isolate skb data area allocations into a separate bucket

 include/linux/slab.h | 7 +++++--
 net/core/skbuff.c    | 5 ++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.54.0



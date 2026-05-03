Return-Path: <netdev+bounces-283685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMsJOGXI92nQmAIAu9opvQ
	(envelope-from <netdev+bounces-283685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 00:12:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 597CB4B7A7B
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 00:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C7AC3005E98
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 22:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F973AC0EB;
	Sun,  3 May 2026 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R2R0tcP7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wc+UCacn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R2R0tcP7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wc+UCacn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE793A9D84
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777846371; cv=none; b=KzNjCMCCTbmG9AKt2E2kDOUTEco1hLI8AHhdCVcsI8GZUKRjf5FzywgMto3j4BUvPxZGxi0DnLtu9YkrjZHXdLXejPyMpwzznGZMmlD8tvGB3XH9rviV7TVTSLrboK7fvAGNvZpanLWQABXMUA4KHUIx/tHAT6ZRqCCx1OnE8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777846371; c=relaxed/simple;
	bh=amjNKDiByO8OXYXjgCXvacfURD9eqUFBCrcfV8+f06g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nvmXQBEH5PSKurW3y39D0zZOPko2+pjV9NNIXpTYFKqRYemEzR6kq8C2qj9JLtYpNlLOWRR/HTMTa8ZivGB6ebbXwhetIGyDMpFKhEu7LubhtUXo5/wg/lmyjReg2U/iok+sf2BkCUALAiuxcK+3BbNqW/ZOuz+y/0sUbpSfUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R2R0tcP7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wc+UCacn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R2R0tcP7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wc+UCacn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1D4D6AF5C;
	Sun,  3 May 2026 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777846368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fQutdRSJ/DzsQ0IV3KpvTBpuYwE1y3MNPWni6jO1YNk=;
	b=R2R0tcP7W6ubydvm2Dp/LNYFTEgZbU+0w4vxP3ojWOhbD0w0pP4lQydq3YiLo1TTrIKwI/
	D/QvDZllNreoS3CqnjbLgZ9LRnixcu806/WuXnOluCoVidB8o4NtypQyzJXP1ZPNHAm8pk
	nvaIFHkEBPxpMs7KrdspKTSu616CIoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777846368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fQutdRSJ/DzsQ0IV3KpvTBpuYwE1y3MNPWni6jO1YNk=;
	b=Wc+UCacn4ADSYn3hoMv7ITQRP5E7tIQ1oMptdBErq/liePbvw22BJQN6I/eU450NExrI3i
	Vt+i4yPo2lGjDJCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R2R0tcP7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Wc+UCacn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777846368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fQutdRSJ/DzsQ0IV3KpvTBpuYwE1y3MNPWni6jO1YNk=;
	b=R2R0tcP7W6ubydvm2Dp/LNYFTEgZbU+0w4vxP3ojWOhbD0w0pP4lQydq3YiLo1TTrIKwI/
	D/QvDZllNreoS3CqnjbLgZ9LRnixcu806/WuXnOluCoVidB8o4NtypQyzJXP1ZPNHAm8pk
	nvaIFHkEBPxpMs7KrdspKTSu616CIoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777846368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fQutdRSJ/DzsQ0IV3KpvTBpuYwE1y3MNPWni6jO1YNk=;
	b=Wc+UCacn4ADSYn3hoMv7ITQRP5E7tIQ1oMptdBErq/liePbvw22BJQN6I/eU450NExrI3i
	Vt+i4yPo2lGjDJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F368D593A3;
	Sun,  3 May 2026 22:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W5EXOF/I92kabwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 03 May 2026 22:12:47 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?=C5=81ukasz=20Stelmach?= <steelman@post.pl>
Subject: [PATCH 1/2 net] ipv6: addrconf: fix temp address generation after prefix deprecation
Date: Mon,  4 May 2026 00:11:40 +0200
Message-ID: <20260503221139.3742-3-fmancera@suse.de>
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
X-Rspamd-Queue-Id: 597CB4B7A7B
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-283685-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,post.pl:email]

When a router temporarily deprecates an IPv6 prefix (either by sending a
Router Advertisement with Preferred Lifetime = 0 or by letting the
lifetime expire) and later restores it, the kernel permanently loses its
ability to generate temporary privacy addresses (RFC 8981) for that
prefix.

This happens because the address worker attempts to generate a
replacement temporary address when the current one nears expiration. As
the base prefix is deprecated already, the generation fails, burning the
retry counter for temporary address generation of that prefix.

When the router eventually restores the prefix, the temporary address
becomes active again. However, once it naturally expires, the kernel
sees the exhausted retry limit and permanently stops generating new
privacy addresses.

Fix this by verifying that the base prefix has sufficient preferred
lifetime remaining before attempting to generate a new temporary
address. This prevents the worker from burning through its retry counter
during temporary network deprecation events like a router reboot.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Łukasz Stelmach <steelman@post.pl>
Closes: https://lore.kernel.org/netdev/87340td30q.fsf%25steelman@post.pl/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5476b6536eb7..f6a3d9da3cb1 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4654,9 +4654,11 @@ static void addrconf_verify_rtnl(struct net *net)
 			    !ifp->regen_count && ifp->ifpub) {
 				/* This is a non-regenerated temporary addr. */
 
+				unsigned long pub_age = (now - READ_ONCE(ifp->ifpub->tstamp)) / HZ;
 				unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);
 
-				if (age + regen_advance >= ifp->prefered_lft) {
+				if (age + regen_advance >= ifp->prefered_lft &&
+				    pub_age + regen_advance < READ_ONCE(ifp->ifpub->prefered_lft)) {
 					struct inet6_ifaddr *ifpub = ifp->ifpub;
 					if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
 						next = ifp->tstamp + ifp->prefered_lft * HZ;
-- 
2.53.0



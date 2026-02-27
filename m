Return-Path: <netdev+bounces-261826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIRoNWWAoWkUtgQAu9opvQ
	(envelope-from <netdev+bounces-261826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 12:30:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516AB1B6962
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 12:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FE3130E442C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815F3F0745;
	Fri, 27 Feb 2026 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yb7Pdeyp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iB/dJiTn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XQZtZktK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LSkEoNdt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7F3EF0DF
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191641; cv=none; b=mrbTkR1x6E5wP+ARP7ufBtpFWHOnv649NcRJdDQ9JveiMflUWkMoCww1eYqyDGqxI8mjRp1smdrUDLvqNO2uAoQ9KzBqTyyyg2jvTBRWGyQmVUn2QPTpuwntp0yhi845vpJ7od3YrmgtyVuZjIsLlaDAvY73xgpYdx3svkmSREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191641; c=relaxed/simple;
	bh=FWTkOpOyVHXLq6hOuoQKDx1XKlcBwpLcEWhtycxt1/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peRoBYSuLgK8V9TELfSlMViwDBNuCO0mGN3+jqU49SNJwhjipznNKXGUBI2HjmL3r6im8K9dYvwf4Uy8FSNi5tr5FHHU/OoXmgjMmvAGcTqlgdjYfUX4+d+Mdau3CV7FYQSvW/vsKPuNtRaZYHABPL8ajun+YnwgbI+Mj74S0WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yb7Pdeyp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iB/dJiTn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XQZtZktK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LSkEoNdt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6CC95BDF8;
	Fri, 27 Feb 2026 11:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772191637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pCpMaw2BDE3GKaeSkp4uQTr+35ecOkoLc48SGwcoUho=;
	b=yb7PdeypTDHJ19ut/FpdBg/DITNjYTzilKZMxTmxIfUWMTrj95mTuO6Jd7fvnGDKllAiIN
	UGHJ9NL5UhGh7XTvGLQTTB7CR1GTZ/WDxbb7O+rr7tBi58CZVurmILGluE2XfdvLzT1cF3
	Kqt3seJxk2+H+DvqZTWTqv7NNGmuV20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772191637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pCpMaw2BDE3GKaeSkp4uQTr+35ecOkoLc48SGwcoUho=;
	b=iB/dJiTnqM+QsPjhkUlewDvI1vs0jIL6iA2YQvQ4JEHyc2HkAK5+O4NeP9n+qLG1W03V1s
	xGAJfmtu/cOF/qAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772191636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pCpMaw2BDE3GKaeSkp4uQTr+35ecOkoLc48SGwcoUho=;
	b=XQZtZktK96jpWT8bxhHDMKokSjNeNGCZpLyUpLFfQn5kKYxYjx+4+tGu4+RdGCeOKWTwk3
	A7N3U3rzS4osMgYRUv6KjaNmp5QDDLm2/u2KNXcz7x23DC3axFy7EFMUPPmhHE0s0cW0xh
	sVh4tCGspO6NpWtwFJHTt2xTcBNludo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772191636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pCpMaw2BDE3GKaeSkp4uQTr+35ecOkoLc48SGwcoUho=;
	b=LSkEoNdtQD8jylDmGDw5LrESp8k2Fz8cW+LOjhYca37XPSlFEwn4yANDgxJPCM36OqnaEq
	+SAwD5LV1SvU2JDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D0B13EA69;
	Fri, 27 Feb 2026 11:27:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rp3zA5R/oWleJwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 27 Feb 2026 11:27:16 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: amwang@redhat.com,
	sdf@fomichev.me,
	petrm@nvidia.com,
	idosch@nvidia.com,
	razor@blackwall.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net] net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled
Date: Fri, 27 Feb 2026 12:27:01 +0100
Message-ID: <20260227112701.3990-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.26
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261826-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 516AB1B6962
X-Rspamd-Action: no action

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called
which initializes it. If an IPv6 packet is injected into the interface,
route_shortcircuit() is called and a NULL pointer dereference happens on
neigh_lookup().

 BUG: kernel NULL pointer dereference, address: 0000000000000380
 Oops: Oops: 0000 [#1] SMP NOPTI
 [...]
 RIP: 0010:neigh_lookup+0x20/0x270
 [...]
 Call Trace:
  <TASK>
  vxlan_xmit+0x638/0x1ef0 [vxlan]
  dev_hard_start_xmit+0x9e/0x2e0
  __dev_queue_xmit+0xbee/0x14e0
  packet_sendmsg+0x116f/0x1930
  __sys_sendto+0x1f5/0x200
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x12f/0x1590
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix this by adding an early check on route_shortcircuit() when protocol
is IPv6. If ipv6_stub->nd_tbl is NULL, return false.

Fixes: e15a00aafa4b ("vxlan: add ipv6 route short circuit support")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 drivers/net/vxlan/vxlan_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 05558b6afecd..cbb9d1a2d8f9 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2130,6 +2130,8 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 	{
 		struct ipv6hdr *pip6;
 
+		if (!ipv6_stub->nd_tbl)
+			return false;
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 			return false;
 		pip6 = ipv6_hdr(skb);
-- 
2.53.0



Return-Path: <netdev+bounces-291082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGfZBrCDEWrAmwYAu9opvQ
	(envelope-from <netdev+bounces-291082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:38:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A63485BE899
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE30230066AA
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C5384CE8;
	Sat, 23 May 2026 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xnlGqQUf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GRMhNQ1j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xnlGqQUf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GRMhNQ1j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B035B62F
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532717; cv=none; b=uyYaVtBpM6K9ul8urvSAPI/6nIPHrlB4sav2ctXPBA0FHtPOJCgrIL7n6YTntNo09B32tsi4AZzr/J7ZgemHivGwjJ3cMtuXw9AEMBmC66FNCutHCuJge7NAjlqYZDRsapf1F9cR1QpwC9NYHr2lVoBJf1MVVPDJrU4mf8qFIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532717; c=relaxed/simple;
	bh=r96JOp9R34HEUV22PZQUHKH7n3Vz+9m3zkZvWSSQcK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sZIcVzLBoiDet9OCnwiom2sd4LWrkTGOLwFyVJ6MfhexEjWLFs5OJzQ80OQ+uNeHEEQFshhheGvqIZnvuh8znfC5wjOO1pmY6fwSnH9OEDjdme8KY9aQHmCUqjBu7L6rdETJU7EGz7YV2OAB2NWxIRx33F41LMqOkkEShP3cUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xnlGqQUf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GRMhNQ1j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xnlGqQUf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GRMhNQ1j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 121296C4FC;
	Sat, 23 May 2026 10:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779532709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=INOb8p2qQ2j6UV7dIOHrRtti/e52Y7oFE/NTKHENeNU=;
	b=xnlGqQUfb0kpFq1Qrg/oyL5VxlmnRUC9UQhGQz+ghsiycJln1lYN1+K0CuXcS8M5Drhc3+
	CLXPtE8vQkish/z8OuwOjXN6Jr9GDCsMIWVsmQLEFcAcPOpcsAJwWHid8SMvVi+MT3zoT6
	Hx3F/fKFSd5osVdCfoV4y90UR2KCT+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779532709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=INOb8p2qQ2j6UV7dIOHrRtti/e52Y7oFE/NTKHENeNU=;
	b=GRMhNQ1jM9BRHBOLpmACbJNBwMlBlx0cl15bsERag1V2cKpIv5xe379fSYG7TU8TUBZ40o
	KrZAhnZkQ/JfoDAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779532709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=INOb8p2qQ2j6UV7dIOHrRtti/e52Y7oFE/NTKHENeNU=;
	b=xnlGqQUfb0kpFq1Qrg/oyL5VxlmnRUC9UQhGQz+ghsiycJln1lYN1+K0CuXcS8M5Drhc3+
	CLXPtE8vQkish/z8OuwOjXN6Jr9GDCsMIWVsmQLEFcAcPOpcsAJwWHid8SMvVi+MT3zoT6
	Hx3F/fKFSd5osVdCfoV4y90UR2KCT+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779532709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=INOb8p2qQ2j6UV7dIOHrRtti/e52Y7oFE/NTKHENeNU=;
	b=GRMhNQ1jM9BRHBOLpmACbJNBwMlBlx0cl15bsERag1V2cKpIv5xe379fSYG7TU8TUBZ40o
	KrZAhnZkQ/JfoDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69E9E593A8;
	Sat, 23 May 2026 10:38:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mKNjFqSDEWpGXAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 23 May 2026 10:38:28 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?=C5=81ukasz=20Stelmach?= <steelman@post.pl>
Subject: [PATCH 1/2 net-next v5] ipv6: addrconf: fix temp address generation after prefix deprecation
Date: Sat, 23 May 2026 12:38:10 +0200
Message-ID: <20260523103811.3790-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291082-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: A63485BE899
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Fix the issue by resetting the regen_count check of the latest temp
address generated for the prefix updated by the incoming RA.

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
v5: reset regen_count for the most recent temp address when a non
0-lft RA arrives.
---
 net/ipv6/addrconf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index da0f07e21e3f..d7b03196725f 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1174,6 +1174,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 	ipv6_link_dev_addr(idev, ifa);
 
 	if (ifa->flags&IFA_F_TEMPORARY) {
+		/* manage_tempaddrs() relies on addresses being added to the head */
 		list_add(&ifa->tmp_list, &idev->tempaddr_list);
 		in6_ifa_hold(ifa);
 	}
@@ -2602,8 +2603,10 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 			     __u32 valid_lft, __u32 prefered_lft,
 			     bool create, unsigned long now)
 {
-	u32 flags;
+	u32 orig_prefered_lft = prefered_lft;
 	struct inet6_ifaddr *ift;
+	bool reset_done = false;
+	u32 flags;
 
 	read_lock_bh(&idev->lock);
 	/* update all temporary addresses in the list */
@@ -2638,6 +2641,11 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 			prefered_lft = max_prefered;
 
 		spin_lock(&ift->lock);
+		/* the first match is the most recent temp address */
+		if (!reset_done && orig_prefered_lft > 0) {
+			ift->regen_count = 0;
+			reset_done = true;
+		}
 		flags = ift->flags;
 		ift->valid_lft = valid_lft;
 		ift->prefered_lft = prefered_lft;
-- 
2.53.0



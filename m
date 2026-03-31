Return-Path: <netdev+bounces-273601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNPiMli3y2mCKgYAu9opvQ
	(envelope-from <netdev+bounces-273601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:00:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBEA369385
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA38D30321EC
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649143E022B;
	Tue, 31 Mar 2026 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UO7nW114";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8fD/YgN1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JCIDS4sI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FicygYR2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F423DC4D0
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958404; cv=none; b=RDtnwY/En7IYvNWMktZQMu+4atgakjwCQmW+jCNqUpbr3RRrz0NS8e8CZxJyugIfEdXK+5rdp1P6S9HkWxJKc5QnspwrTraNfIuUDbfhjkNxABH/EYA5bg5koUVYiYC6TZEufmYTv1B+Y+eTagQQNsjFHbvbBaKt8pYYY3+nQNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958404; c=relaxed/simple;
	bh=TeW+WR4PTVnP9Pp/5/unSciFX21YayQUZJgukeIfeOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rakb22dDL5t0uQZgT2hPeVtbKpupGlpRicfrP8H7d7rMOl7BrZzkUV9CQm9u3Nm2z0PaZPc1Ad1VlhTc33Ds+G1RRCEeu0AROmEYDfWdY/q+JGXbbwKkl3qfJlH9lwRErAYRJVmXsyJNg4hr6MxVVDy2fH9U78eBJY9G4qswcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UO7nW114; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8fD/YgN1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JCIDS4sI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FicygYR2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB35C5BD0A;
	Tue, 31 Mar 2026 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774958401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ONP7w9VX6YgrpD+mtY5h+h3i5fpOqeRMgJNMWgV/TWU=;
	b=UO7nW1140Z8oJY7ZNQePo6rSit/Q/vN7QW6Vhc+kdl0I3s0ucaGlN2Ml1isIHrPW+OZOl5
	7kYt1MhjuOue8Lb1sfow9JK4WKJ/igIimXCfd/hk/NQyJK1Iv0M4qVmglurtS05/ZkbB4l
	DisFWEMWj5xt3ZFZTchbWlBHiHQoUpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774958401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ONP7w9VX6YgrpD+mtY5h+h3i5fpOqeRMgJNMWgV/TWU=;
	b=8fD/YgN1caz3XcKpqxStsHKuDP61R5wuRR15pcddABEWuFvlZ0o+Bh8WfAIXnC+FbMuNwR
	CT8IESg8clM5uRCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JCIDS4sI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FicygYR2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774958399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ONP7w9VX6YgrpD+mtY5h+h3i5fpOqeRMgJNMWgV/TWU=;
	b=JCIDS4sImH9x8SbXDZ8O605YxACYGelVYc8A6BnG6N1RQ1kiGnfsEucVDw9EKSmU6fRwAD
	VIZYH3JIWa5TXddACqP3g6ANZT1tBUxwyjLkF231XXmaQCmsdoAsBoB70ADdpxlp7gJHyG
	VpOetpZ7EXimClYWQ3s/KF6eyHeJLvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774958399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ONP7w9VX6YgrpD+mtY5h+h3i5fpOqeRMgJNMWgV/TWU=;
	b=FicygYR24PIBJQzsZXrJkSv6xEprxXZgFYIVmXtPHGkdORQL4hUbduHd7jciMg8vfVfSBV
	O+XXldCOOHe1NDCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 506494A0A2;
	Tue, 31 Mar 2026 11:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MmmtED+3y2nNeQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 31 Mar 2026 11:59:59 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Yiming Qian <yimingqian591@gmail.com>
Subject: [PATCH net] ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()
Date: Tue, 31 Mar 2026 13:59:43 +0200
Message-ID: <20260331115943.10404-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273601-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,suse.de,gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 2BBEA369385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When querying a nexthop object via RTM_GETNEXTHOP, the kernel currently
allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
single nexthops and small Equal-Cost Multi-Path groups, this fixed
allocation fails for large nexthop groups like 512+ nexthops.

This results in the following warning splat:

 WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0, CPU#19: rep/9282
 [...]
 RIP: 0010:rtm_get_nexthop+0x176/0x1c0
 [...]
 Call Trace:
  <TASK>
  rtnetlink_rcv_msg+0x168/0x670
  netlink_rcv_skb+0x5c/0x110
  netlink_unicast+0x203/0x2e0
  netlink_sendmsg+0x222/0x460
  ____sys_sendmsg+0x35a/0x380
  ___sys_sendmsg+0x99/0xe0
  __sys_sendmsg+0x8a/0xf0
  do_syscall_64+0x12f/0x1590
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>

Fix this by allocating the size dynamically using nh_nlmsg_size(), this
is consistent with nexthop_notify() behavior. In addition, replace
alloc_skb() with nlmsg_new().

This cannot be reproduced via iproute2 as the group size is currently
limited and the command fails as follows:

addattr_l ERROR: message exceeded bound of 1048

Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Closes: https://lore.kernel.org/netdev/CAL_bE8Li2h4KO+AQFXW4S6Yb_u5X4oSKnkywW+LPFjuErhqELA@mail.gmail.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: as this cannot be reproduced by iproute2 and a custom C script
is needed to trigger it, I do not think a selftest covering this corner
case is worth here.
---
 net/ipv4/nexthop.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index c942f1282236..b502c3ad41bf 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3377,15 +3377,15 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 
-	err = -ENOBUFS;
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		goto out;
-
 	err = -ENOENT;
 	nh = nexthop_find_by_id(net, id);
 	if (!nh)
-		goto errout_free;
+		goto out;
+
+	err = -ENOBUFS;
+	skb = nlmsg_new(nh_nlmsg_size(nh), GFP_KERNEL);
+	if (!skb)
+		goto out;
 
 	err = nh_fill_node(skb, nh, RTM_NEWNEXTHOP, NETLINK_CB(in_skb).portid,
 			   nlh->nlmsg_seq, 0, op_flags);
-- 
2.53.0



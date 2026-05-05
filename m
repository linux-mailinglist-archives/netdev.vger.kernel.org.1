Return-Path: <netdev+bounces-284589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OFtFhJv+mngOwMAu9opvQ
	(envelope-from <netdev+bounces-284589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 00:28:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C884D456F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 00:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE29B3020C06
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 22:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1EC494A1D;
	Tue,  5 May 2026 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YRy71u1/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8vOSimMt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M/jbFzuH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3xhVdMwU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7E48C8C1
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020110; cv=none; b=gZ9ulbZ/sBR1HURYdfHw7gPz/DVHo+CQZSLOcm6ARqIfzlTzLFIg1d/RVZmb4GxmlKy2KG/4ZILwnlLmdjNGQ0QO5TSR3IWW87kAJzu4LtmQokcPxdnVXxrefh9HBlcx2jwpP1LfVu+ES7bWQu3B6Lu24cZ4PIux826YRm4IwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020110; c=relaxed/simple;
	bh=a7PPmdbLjeur1nvNmm8lLlApRhWwWShPG0Ni7Y7T+6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JSTZ4WjB+JM+ZqOB5xuTNsdU3WBt+1K1jKW/G/hPTnHGLj9CfS9YJJ42Yp/9v9YPquz2OSlmV5o9bq4Bs8Cpk3y3B3F60dT0CRLgkGuZ01/eF8RImbl78p86fn9BTfJUmFIxxfkhbxAYvBIbA6SC6DDxO2Ni1HXoM73nrcp58Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YRy71u1/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8vOSimMt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M/jbFzuH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3xhVdMwU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0C3D5CDF5;
	Tue,  5 May 2026 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778020107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MkhlMQfZxuAFhsnXD2OkKJRpzuCEBhiOHML02bNUV2g=;
	b=YRy71u1/1dC+MoBoMP2uymeiLzmlL9s3maqo9toeMTXx55oDIFEdZ9JHCIzyjsu8SOd+Bg
	8/I6fKTy6GOpuKJ0sOOEp3hW+4170Wd6NjLzBctKH85oqePVer/ocDA7SYX8xyzjUQiDVD
	3huFGRGiwXK6HapdoRpoOQ/wMRPkrF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778020107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MkhlMQfZxuAFhsnXD2OkKJRpzuCEBhiOHML02bNUV2g=;
	b=8vOSimMtsBeSp/Ly1brceLKSdsK/2C0Oe3M/XUZsvCkkCkktBfXoMgqmzJnMkNSLSTkPke
	8DHDQXYCamGdx1Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778020106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MkhlMQfZxuAFhsnXD2OkKJRpzuCEBhiOHML02bNUV2g=;
	b=M/jbFzuHuySDUEcj1ZcwD8lHrLKT33MoIhm2Qnpvbv+TLk4OuoS8lmiDh8EP5Mjo0IjKkX
	fOkPgLcLNXnCMLY+6ADx/m+JjVvFY3CvL99GNA2Y6ZLg+yNDOjQSekfM3QCHpWg7k8e5Bl
	0/OFN2MyCdXlze7aXLA+anyg89yqqYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778020106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MkhlMQfZxuAFhsnXD2OkKJRpzuCEBhiOHML02bNUV2g=;
	b=3xhVdMwU2ApTHj7cDcjRrWmRcItTniAsz5K1nWNEBaTEmzAa9TOfZRqZ2fR3YFxca1Q5xp
	9yBQOqIZif4oKIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 535D5593A3;
	Tue,  5 May 2026 22:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jEjhEApv+mkbWgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 05 May 2026 22:28:26 +0000
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
Subject: [PATCH 1/2 net v2] ipv6: addrconf: fix temp address generation after prefix deprecation
Date: Wed,  6 May 2026 00:28:01 +0200
Message-ID: <20260505222802.4296-1-fmancera@suse.de>
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
X-Spam-Score: -3.30
X-Spam-Level: 
X-Rspamd-Queue-Id: F1C884D456F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284589-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

When a router temporarily deprecates an IPv6 prefix (either by sending a
Router Advertisement with Preferred Lifetime = 0 or by letting the
lifetime expire) and later restores it, the kernel permanently loses its
ability to generate temporary privacy addresses (RFC 8981) for that
prefix.

This happens because the address worker attempts to generate a
replacement temporary address when the current one nears expiration. As
the base prefix is deprecated already, the generation fails after
marking the temporary address already having spawned a replacement
(ifp->regen_count++).

When the router eventually restores the prefix, the temporary address
becomes active again. However, once it naturally expires, the address
worker sees this temporary address already tried to generate one and
skips the regeneration.

Fix this by verifying that the base prefix has sufficient preferred
lifetime remaining before attempting to generate a new temporary
address. In addition, make ipv6_create_tempaddr() return meaningful
error codes. This way, we can catch if a 0-lft RA arrived just after we
passed the verification mentioned above. If we don't have sufficient
preferred lifetime remaining, the worker will keep the next timer as it
is.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Łukasz Stelmach <steelman@post.pl>
Closes: https://lore.kernel.org/netdev/87340td30q.fsf%25steelman@post.pl/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: adjusted commit message, adjusted the implementation to cover all
race conditions
---
 net/ipv6/addrconf.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5476b6536eb7..23338747b429 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1379,7 +1379,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 		write_unlock_bh(&idev->lock);
 		pr_info("%s: use_tempaddr is disabled\n", __func__);
 		in6_dev_put(idev);
-		ret = -1;
+		ret = -EOPNOTSUPP;
 		goto out;
 	}
 	spin_lock_bh(&ifp->lock);
@@ -1390,7 +1390,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 		pr_warn("%s: regeneration time exceeded - disabled temporary address support\n",
 			__func__);
 		in6_dev_put(idev);
-		ret = -1;
+		ret = -EADDRNOTAVAIL;
 		goto out;
 	}
 	in6_ifa_hold(ifp);
@@ -1466,7 +1466,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 		    cfg.preferred_lft > if_public_preferred_lft) {
 			in6_ifa_put(ifp);
 			in6_dev_put(idev);
-			ret = -1;
+			ret = -EINVAL;
 			goto out;
 		}
 	}
@@ -4655,8 +4655,17 @@ static void addrconf_verify_rtnl(struct net *net)
 				/* This is a non-regenerated temporary addr. */
 
 				unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);
+				unsigned long pub_tstamp = READ_ONCE(ifp->ifpub->tstamp);
+				unsigned long pub_age = 0;
+				bool pub_expired = false;
+
+				if (time_after(now, pub_tstamp))
+					pub_age = (now - pub_tstamp) / HZ;
 
-				if (age + regen_advance >= ifp->prefered_lft) {
+				if (pub_age + regen_advance >= READ_ONCE(ifp->ifpub->prefered_lft))
+					pub_expired = true;
+
+				if (age + regen_advance >= ifp->prefered_lft && !pub_expired) {
 					struct inet6_ifaddr *ifpub = ifp->ifpub;
 					if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
 						next = ifp->tstamp + ifp->prefered_lft * HZ;
@@ -4670,12 +4679,18 @@ static void addrconf_verify_rtnl(struct net *net)
 					ifpub->regen_count = 0;
 					spin_unlock(&ifpub->lock);
 					rcu_read_unlock_bh();
-					ipv6_create_tempaddr(ifpub, true);
+
+					if (ipv6_create_tempaddr(ifpub, true) == -EINVAL) {
+						spin_lock_bh(&ifp->lock);
+						ifp->regen_count = 0;
+						spin_unlock_bh(&ifp->lock);
+					}
 					in6_ifa_put(ifpub);
 					in6_ifa_put(ifp);
 					rcu_read_lock_bh();
 					goto restart;
-				} else if (time_before(ifp->tstamp + ifp->prefered_lft * HZ - regen_advance * HZ, next))
+				} else if (time_before(ifp->tstamp + ifp->prefered_lft * HZ - regen_advance * HZ, next) &&
+					   !pub_expired)
 					next = ifp->tstamp + ifp->prefered_lft * HZ - regen_advance * HZ;
 			}
 
-- 
2.53.0



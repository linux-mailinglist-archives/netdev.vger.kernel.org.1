Return-Path: <netdev+bounces-285334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFtFFfiT/Gn3RQAAu9opvQ
	(envelope-from <netdev+bounces-285334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:30:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EA74E9469
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2944C300A653
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F83EB7E5;
	Thu,  7 May 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f1KAz6/B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nNm36Yuk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f1KAz6/B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nNm36Yuk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C643AB29D
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160520; cv=none; b=WMF0KpawnpLM482lhLzqdOyhmQuvF7glgPEu+5RmjTmOQCJcLuYv1fOGwlbTzML3/itd4J43oPIXU63OfgdykH0OVLw1daPzDvA3WojsU18Xxh4QkCjFxkqMRTYA4/mH3AWHcMRvAKoDiQ1zF6vUFLsVSMu/RfJZNPtWo5HcUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160520; c=relaxed/simple;
	bh=cwMc54ufcXVXOk/tW0pv6MkyqKI/SdktGjhz5NTy69s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZWc7FgsjePnqkd8Kr6Va+iaKKnruL+DoYuWBjUVk2s/1ktgxkDWB2WqW+65TWptFXAAJPxThzJU73Nwzqfh3JLXU3owSKxQa4laQ2G6DJ5f78dnVAqyfk6cRtcNnTeaYGPjUf7DJYi5CnWvTCJqid6H1k1qqy/xuFNk093jCHE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f1KAz6/B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nNm36Yuk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f1KAz6/B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nNm36Yuk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4CEB6C36C;
	Thu,  7 May 2026 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778160511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UDiHM9wKTQrjv/o67ZAcDUt1uVwWbZEaMH3sFEnFl0M=;
	b=f1KAz6/BqPXk4pL8v0P8Yjenl3prX0ukYY7IRXBLHn0OIcU+vx1sP7Og48XWsf/wWMoN+q
	aH6RT0aYBZaV3lDFqBqFGkw+AAMYxefSVliOTVFret5ie3QYdyxFE5PUNXjuVu6favVE+Y
	vnzgx7HDbfCTYO+TeOi1untz+c48DO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778160511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UDiHM9wKTQrjv/o67ZAcDUt1uVwWbZEaMH3sFEnFl0M=;
	b=nNm36YuknXpfw5eg58xV9ad/YLwZOA5AtMHzXAUguSdBrVxpE1kXavaXIghovPwK6fmB9I
	W+XWDYuE0pUKSxBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778160511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UDiHM9wKTQrjv/o67ZAcDUt1uVwWbZEaMH3sFEnFl0M=;
	b=f1KAz6/BqPXk4pL8v0P8Yjenl3prX0ukYY7IRXBLHn0OIcU+vx1sP7Og48XWsf/wWMoN+q
	aH6RT0aYBZaV3lDFqBqFGkw+AAMYxefSVliOTVFret5ie3QYdyxFE5PUNXjuVu6favVE+Y
	vnzgx7HDbfCTYO+TeOi1untz+c48DO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778160511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UDiHM9wKTQrjv/o67ZAcDUt1uVwWbZEaMH3sFEnFl0M=;
	b=nNm36YuknXpfw5eg58xV9ad/YLwZOA5AtMHzXAUguSdBrVxpE1kXavaXIghovPwK6fmB9I
	W+XWDYuE0pUKSxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2685A593A7;
	Thu,  7 May 2026 13:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KykBBn+T/GlAdgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 07 May 2026 13:28:31 +0000
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
Subject: [PATCH 1/2 net v3] ipv6: addrconf: fix temp address generation after prefix deprecation
Date: Thu,  7 May 2026 15:28:27 +0200
Message-ID: <20260507132828.3923-1-fmancera@suse.de>
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
X-Rspamd-Queue-Id: 56EA74E9469
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285334-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim,post.pl:email]
X-Rspamd-Action: no action

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
v3: regen now if ipv6_create_tempaddr failed due to timer to avoid an
infinite loop as we restart the loop and we need to check now against
prefered_lft again.
---
 net/ipv6/addrconf.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5476b6536eb7..d54737b5610d 100644
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
@@ -4670,12 +4679,19 @@ static void addrconf_verify_rtnl(struct net *net)
 					ifpub->regen_count = 0;
 					spin_unlock(&ifpub->lock);
 					rcu_read_unlock_bh();
-					ipv6_create_tempaddr(ifpub, true);
+
+					if (ipv6_create_tempaddr(ifpub, true) == -EINVAL) {
+						spin_lock_bh(&ifp->lock);
+						ifp->regen_count = 0;
+						spin_unlock_bh(&ifp->lock);
+						now = jiffies;
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



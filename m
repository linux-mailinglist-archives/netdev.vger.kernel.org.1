Return-Path: <netdev+bounces-262646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEi3C7WMpWmoDgYAu9opvQ
	(envelope-from <netdev+bounces-262646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:12:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A15701D98BF
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD54230247C9
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642363D902F;
	Mon,  2 Mar 2026 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VrjH/Lgo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rWNAB9cL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bdO0wX7M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9sd7DAM2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9220373BFB
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456951; cv=none; b=kxntxmc/er7okyad9iMKJ1l+l+I5XMCsKrJrUZqqGJonRmmxgso5qF7R80I5ICKv3Gy31sRNqwAXeKw54sCX6r08H4X+dN1rcavkh8xKPk4MKxR6gGmN3LkTg8C3LJeljHESu/x/aF8aeb1xicVZKQOsh9tx8GeyNU3OlVZPoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456951; c=relaxed/simple;
	bh=19vsqJiP6tSMHWbwIK5Pbd53NUdRR2ZRlbTNRZSCuTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGEROE7CmPW8O2WO6BnbcwjUPdOLpcB0QDuOakhc71jMLEsEVDDKNJ7I+fPMO2gjb3/E5LCUfKfsJkBifz1RUSc88R5dZ+ecKfTO6sJ3O7xwr/afYMdW8c7Btm5UgMZYmuQJxDlPNdkW2uFcKmPJZhUiM9CnuA81fL05KuPe10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VrjH/Lgo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rWNAB9cL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bdO0wX7M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9sd7DAM2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A63655BD32;
	Mon,  2 Mar 2026 13:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772456948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hdAuvsTrwkrt9aV4hOd2hwJoGui1Jz1LXy70/tW5dn8=;
	b=VrjH/LgockwzTjZmha5Vt7nFuhnEhaSGJoq1Q6UyyOKk24os1Wb3kGE3oBfWfPm37CUhA8
	mZNZ4tDwNH3qz/hd6QE33Ds9blmyH0YoWipFQQW/Pn1T6imGs7JBrJ43a6F+XeAFF5C73m
	MLbG36xcs2idH9lv1XWYONmq6JnQI6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772456948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hdAuvsTrwkrt9aV4hOd2hwJoGui1Jz1LXy70/tW5dn8=;
	b=rWNAB9cL5+dXsMf6dwGsf0kLeCuE78JchONee3NT8rhiTj+suFkyVkNVYyNDqB3UmyXnoJ
	x6Nf6b6PIPkXZCCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bdO0wX7M;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9sd7DAM2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772456947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hdAuvsTrwkrt9aV4hOd2hwJoGui1Jz1LXy70/tW5dn8=;
	b=bdO0wX7M/kgT2oOjjq3buk0T1ie+LAMDqdIWArlZct+fqBS82LNA6QT7hbfO02i2nQrkfH
	eYB87RsAk4o2cM+8aQfIhUoPEQwvbTngelFoHPlhq9BvR47gXpnCjYAo/o08c11We/RdvK
	vk5PkfYFpQe9IGbPQGIgKvCEwc+cz0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772456947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hdAuvsTrwkrt9aV4hOd2hwJoGui1Jz1LXy70/tW5dn8=;
	b=9sd7DAM2jpw+g6RKkvmRW1xEo3D/vEmxwjwTKTnOdSeKqlYtBYXsLUJ9xcec4yKdOx++rB
	bclE4MhYBXUlPHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E7EF3EA69;
	Mon,  2 Mar 2026 13:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bsCMBPOLpWkpYwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 02 Mar 2026 13:09:07 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: tgraf@infradead.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net v3] ipv4: bump rt_genid when a relevant devconf value changes through netlink
Date: Mon,  2 Mar 2026 14:08:57 +0100
Message-ID: <20260302130858.5197-1-fmancera@suse.de>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: A15701D98BF
X-Rspamd-Action: no action

When modifying IPv4 devconf values using netlink for some relevant
fields the rt_cache_flush() call was missing. In addition, if forwarding
is enabled on the interface then disable LRO.

This is needed to avoid possible connectivity issues and ease the
responsabilities of user space tools.

Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: use netif_disable_lro() as we already hold netdev_need_ops_lock()
and use net_device struct passed as argument instead of using in_dev->dev
v3: separate it from the series and sent it to net tree instead
---
 net/ipv4/devinet.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 537bb6c315d2..5205fbe99963 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2098,6 +2098,8 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 {
 	struct in_device *in_dev = __in_dev_get_rtnl(dev);
 	struct nlattr *a, *tb[IFLA_INET_MAX+1];
+	struct net *net = dev_net(dev);
+	bool flush_cache = false;
 	int rem;
 
 	if (!in_dev)
@@ -2107,8 +2109,27 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 		return -EINVAL;
 
 	if (tb[IFLA_INET_CONF]) {
-		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem)
+		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
 			ipv4_devconf_set(in_dev, nla_type(a), nla_get_u32(a));
+
+			switch (nla_type(a)) {
+			case IPV4_DEVCONF_FORWARDING:
+				if (nla_get_u32(a))
+					netif_disable_lro(dev);
+				fallthrough;
+			case IPV4_DEVCONF_NOXFRM:
+			case IPV4_DEVCONF_NOPOLICY:
+			case IPV4_DEVCONF_PROMOTE_SECONDARIES:
+			case IPV4_DEVCONF_ROUTE_LOCALNET:
+			case IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST:
+				flush_cache = true;
+				break;
+			default:
+				break;
+			}
+		}
+		if (flush_cache)
+			rt_cache_flush(net);
 	}
 
 	return 0;
-- 
2.53.0



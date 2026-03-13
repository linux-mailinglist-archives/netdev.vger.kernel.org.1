Return-Path: <netdev+bounces-267483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NMBAZ8jtGl7hwAAu9opvQ
	(envelope-from <netdev+bounces-267483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:47:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444428547B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D68BF3007649
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA33126D7;
	Fri, 13 Mar 2026 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fSQaG6R5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dxsruoD7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fSQaG6R5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dxsruoD7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A401DED42
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413175; cv=none; b=Kkf3NsUwdcPvfk8J7sRAj97UxOSRSXsZT8QP9wP9WVLba6OZwgxUswkD7HPsZw+ltWuwUhHwp6B788fyOurqSG+eEsm7ca2ka1OJeHS0/vQb6KLj7rgEO25B9y/q4YomE1giG69INHszdYL0PgVVI5r5vCzjogyqqhILVMDs8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413175; c=relaxed/simple;
	bh=W2fIbLtSGVeeJ+qVG+paECMg0HBvk86cHBfUIMKZqOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQqd77GHKocqetVuPe6jPS4tcvFWdx5G6qU9GyAQfVXmC+guioajd54xcz7quChF1+DDJaRFmr40WBwJBcWFgfV/ZRXfX62FVQmUmt50/vbUaaXeOLgLpCvKNMJFqObxQ/1AaReWs7KLqwxDu+LatFd9Z9lyO1EdslDAFgDjWKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fSQaG6R5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dxsruoD7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fSQaG6R5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dxsruoD7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DACF4D1EF;
	Fri, 13 Mar 2026 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773413172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bfdJo7EQhqvmTqQ2ZnDzzS1XLOK7sGcwEBl5I4GCqH8=;
	b=fSQaG6R55HjXAZ5hqWR6nBLVg0egxHKqKXjtXnF737y/Z/2F+YOT5Cq0xVtn51uAZ5nIsl
	SEA+RrxB/tyHWBho2VczvxbwPBh5Mm70UigRVoq0EkvAvFEFVSJZsa14irsB9picjVa4VP
	4eVB31BUn9YHjlt7axOR8xfi/Nijw9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773413172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bfdJo7EQhqvmTqQ2ZnDzzS1XLOK7sGcwEBl5I4GCqH8=;
	b=dxsruoD7Ef6cbr5UCieBg0iqjDyVt/OJ5+n++HVAoz4d/7gKuET+rKWugPiSXfErBN7fEA
	0bj3ahO9SHN2PsAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fSQaG6R5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dxsruoD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773413172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bfdJo7EQhqvmTqQ2ZnDzzS1XLOK7sGcwEBl5I4GCqH8=;
	b=fSQaG6R55HjXAZ5hqWR6nBLVg0egxHKqKXjtXnF737y/Z/2F+YOT5Cq0xVtn51uAZ5nIsl
	SEA+RrxB/tyHWBho2VczvxbwPBh5Mm70UigRVoq0EkvAvFEFVSJZsa14irsB9picjVa4VP
	4eVB31BUn9YHjlt7axOR8xfi/Nijw9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773413172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bfdJo7EQhqvmTqQ2ZnDzzS1XLOK7sGcwEBl5I4GCqH8=;
	b=dxsruoD7Ef6cbr5UCieBg0iqjDyVt/OJ5+n++HVAoz4d/7gKuET+rKWugPiSXfErBN7fEA
	0bj3ahO9SHN2PsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3E144059A;
	Fri, 13 Mar 2026 14:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vaCaNDMjtGnHVQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 13 Mar 2026 14:46:11 +0000
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
Subject: [PATCH net v4] ipv4: bump rt_genid when a relevant devconf value changes through netlink
Date: Fri, 13 Mar 2026 15:45:55 +0100
Message-ID: <20260313144555.4956-1-fmancera@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267483-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7444428547B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When modifying IPv4 devconf values using netlink for some relevant
fields, the rt_cache_flush() call was missing. In addition, disable LRO
if forwarding is enabled on the interface. The flushing and the
disabling of LRO only happens if the value changed. As the value is
converted to int when passing it to ipv4_devconf_set(), it is safe to
cast it earlier to compare it against the current value.

This is needed to avoid possible connectivity issues and ease the
responsibilities of user space tools. Note that this follows the
behavior for the sysctl function ipv4_doint_and_flush() and also
partially devinet_conf_proc() as the missing notification would be
handled in a follow-up patch.

Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: use netif_disable_lro() as we already hold netdev_need_ops_lock()
and use net_device struct passed as argument instead of using in_dev->dev
v3: separate it from the series and sent it to net tree instead
v4: handle BC_FORWARDING and ACCEPT_LOCAL too, modify logic to skip
useless calls to ipv4_devconf_set() due to value not modified. Finally,
ammend the commit message. 
---
 net/ipv4/devinet.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 537bb6c315d2..6dd8fd0a1323 100644
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
@@ -2107,8 +2109,33 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 		return -EINVAL;
 
 	if (tb[IFLA_INET_CONF]) {
-		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem)
-			ipv4_devconf_set(in_dev, nla_type(a), nla_get_u32(a));
+		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
+			int new_value = (int)nla_get_u32(a);
+
+			if (ipv4_devconf_get(in_dev, nla_type(a)) == new_value)
+				continue;
+
+			ipv4_devconf_set(in_dev, nla_type(a), new_value);
+			switch (nla_type(a)) {
+			case IPV4_DEVCONF_FORWARDING:
+				if (new_value)
+					netif_disable_lro(dev);
+				fallthrough;
+			case IPV4_DEVCONF_NOXFRM:
+			case IPV4_DEVCONF_NOPOLICY:
+			case IPV4_DEVCONF_PROMOTE_SECONDARIES:
+			case IPV4_DEVCONF_ROUTE_LOCALNET:
+			case IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST:
+			case IPV4_DEVCONF_BC_FORWARDING:
+			case IPV4_DEVCONF_ACCEPT_LOCAL:
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



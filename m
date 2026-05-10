Return-Path: <netdev+bounces-286254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADTHDtA+AGrLEwEAu9opvQ
	(envelope-from <netdev+bounces-286254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:16:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA895030FB
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04DA9300A4EA
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 08:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D729369224;
	Sun, 10 May 2026 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eILlLV/w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OtJhikpK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eILlLV/w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OtJhikpK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E3413A86C
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778400950; cv=none; b=Qn8dSC1TMmZfFzr3IyAao9FscN0ec3tjsLY1DxU1ConeCTEWIjtRpr3KBuGj5Ow2Sioc+YEdwrwgAgobu8EA7QzfYGYhXiZbmFKkljChL2f/PvkUsFYp/34eOnO+9SqzlboyO22UKJYW/qF6JkMQbAWvVUbZAUn8XCe+SjjliuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778400950; c=relaxed/simple;
	bh=rqdP1dVHU2d5Wwe1A02epIYY7UuprbmmmJ5IdRaVijk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OO0SZl/YcoK1dKi83Akc/QkqUVyfhAcNQvB9bnZMun4L7g52LY7xajA7AKihOlylLPPbhZjFSNctMjMnWbN9U2hhpMQnphqZBA1xfKSHRk6wLTftSd8JYcnm0Yn66faaRiBXI86mAsvtHKZV2pNEWoFy5CTOHKcE0q4DgtCacr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eILlLV/w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OtJhikpK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eILlLV/w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OtJhikpK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D47B6B4AB;
	Sun, 10 May 2026 08:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778400943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcSX08BpEo4UlsqWRJioDN4Re3zSnDtP4ShcRwE1jVA=;
	b=eILlLV/wqenzWpkvXX8AdEapFBmzYm4WUaquwdkORkvOyPXnOMHY9i+9r1C8si+A5UimYw
	DPZtETMU5Kz+JQeh7VHhc+45uQpp/KJmY20gJ5qX9ETADbqQnuk8VkkHcUGMmoiLavez6c
	c3Mi+j7+TDKUTRIWDZey4a/cr3h/uSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778400943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcSX08BpEo4UlsqWRJioDN4Re3zSnDtP4ShcRwE1jVA=;
	b=OtJhikpK1DajUfx0LGbBYDXokGgieFiu9X7r+zgTeCdPXB7G4DHBKpHWdF6icyUNS34xAc
	yh16Yf5oJgMJSCBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="eILlLV/w";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OtJhikpK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778400943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcSX08BpEo4UlsqWRJioDN4Re3zSnDtP4ShcRwE1jVA=;
	b=eILlLV/wqenzWpkvXX8AdEapFBmzYm4WUaquwdkORkvOyPXnOMHY9i+9r1C8si+A5UimYw
	DPZtETMU5Kz+JQeh7VHhc+45uQpp/KJmY20gJ5qX9ETADbqQnuk8VkkHcUGMmoiLavez6c
	c3Mi+j7+TDKUTRIWDZey4a/cr3h/uSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778400943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcSX08BpEo4UlsqWRJioDN4Re3zSnDtP4ShcRwE1jVA=;
	b=OtJhikpK1DajUfx0LGbBYDXokGgieFiu9X7r+zgTeCdPXB7G4DHBKpHWdF6icyUNS34xAc
	yh16Yf5oJgMJSCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD09A593A3;
	Sun, 10 May 2026 08:15:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wBJDK64+AGrIDgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 10 May 2026 08:15:42 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH 2/3 net-next v4] ipv4: handle devconf post-set actions on netlink updates
Date: Sun, 10 May 2026 10:15:27 +0200
Message-ID: <20260510081528.5257-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260510081528.5257-1-fmancera@suse.de>
References: <20260510081528.5257-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: CEA895030FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286254-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action

When IPv4 device configuration parameters are updated via netlink, the
kernel currently only updates the value. This bypasses several
post-modification actions that occur when these same parameters are
updated via sysctl, such as flushing the routing cache or emitting
RTM_NEWNETCONF notifications.

This patch addresses the inconsistency by calling the
devinet_conf_post_set() helper inside inet_set_link_af(). If a flush is
required, we defer it until the netlink attribute parsing loop
completes.

This ensures consistent behavior and side-effects for devconf changes,
regardless of whether they are initiated via sysctl or netlink.

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: handled forwarding notification and disabling LRO
v3: no changes
v4: no changes
---
 net/ipv4/devinet.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 8300516fb38f..a35b72662e43 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2161,6 +2161,20 @@ static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
 					    NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
 					    ifindex, cnf);
 		break;
+	case IPV4_DEVCONF_FORWARDING:
+		if (new == 1) {
+			/* it is safe to use container_of() because forwarding case
+			 * is only used by the netlink path
+			 */
+			struct in_device *idev = container_of(cnf, struct in_device, cnf);
+
+			netif_disable_lro(idev->dev);
+		}
+
+		inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
+					    NETCONFA_FORWARDING,
+					    ifindex, cnf);
+		return true;
 	default:
 		break;
 	}
@@ -2173,6 +2187,8 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 {
 	struct in_device *in_dev = __in_dev_get_rtnl(dev);
 	struct nlattr *a, *tb[IFLA_INET_MAX+1];
+	struct net *net = dev_net(dev);
+	bool flush_cache = false;
 	int rem;
 
 	if (!in_dev)
@@ -2182,8 +2198,17 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 		return -EINVAL;
 
 	if (tb[IFLA_INET_CONF]) {
-		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem)
-			ipv4_devconf_set(in_dev, nla_type(a), nla_get_u32(a));
+		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
+			int old_value = ipv4_devconf_get(in_dev, nla_type(a));
+			int new_value = nla_get_u32(a);
+
+			ipv4_devconf_set(in_dev, nla_type(a), new_value);
+			if (devinet_conf_post_set(net, &in_dev->cnf, nla_type(a), new_value,
+						  old_value, dev->ifindex))
+				flush_cache = true;
+		}
+		if (flush_cache)
+			rt_cache_flush(net);
 	}
 
 	return 0;
-- 
2.53.0



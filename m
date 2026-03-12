Return-Path: <netdev+bounces-267101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAIxGKrOsmmPPwAAu9opvQ
	(envelope-from <netdev+bounces-267101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:33:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB8827369C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88CED312B7FF
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3298523D281;
	Thu, 12 Mar 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O9jJUR+2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9nobV4KK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DqCBnTWg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ciOt7Qe+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD564225413
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325610; cv=none; b=mO2TPeJ/c9srcVdOfVUA/YouqG9Nh22UswaFlCBAsqxrFVkBBKOo4JUjxQ6oZJfLXvNfdMDP5hVx+i9geNF2x+LVVUpiR1qnXsKXnBrrrxz+spG/dKJkw9z4VwUYQEypAWGli36dQ4HNh+bCjaLpw4jQq8RoINh6vuODHT5rSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325610; c=relaxed/simple;
	bh=wAxIg+wcl0CGRaOcjjp+8nH16rUqh+2tYEn1JdYuCAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DT69TFSmAwoQLob5+yb6ARBY0KnfVslOz0Dt+pE0oFi3oJvSSOc7kmXJ1ajIj0HWg4DBroSpRbZKYDAzrZmnwfFpZX/BrngfrNuktNt4BSq+WGw0fKn/FpWG6rvsaRMN87u9Mg92JF5ZGHfKTzWMwW4fdvbT1eJWGq7aKjHzrEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O9jJUR+2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9nobV4KK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DqCBnTWg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ciOt7Qe+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBA6E4D1FA;
	Thu, 12 Mar 2026 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773325607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4ML6juhvu/Lrv9BlhPZh9r4PafO9TWb/C+RaJtduJ68=;
	b=O9jJUR+21mtTOpciPuiTuPxphcKRXmHMYauLemU8q4hlmR8GXVUuHylXgG/K9qCMuIbTJ6
	ee2rDBrKGfpbwctVC5UvQh1cCPJn/HGN4STyWVJRw/h2S8/ogT5B+q5UWaQHSt5QUGSYl1
	DRJpT9n9j7x+UyN8+MGtd2zOoyPQ6Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773325607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4ML6juhvu/Lrv9BlhPZh9r4PafO9TWb/C+RaJtduJ68=;
	b=9nobV4KK4OUXR/YKoL3N8ihwGUR6Ny1wxiO+swyqWXvNHnsATyCPj0ILh0zECcc82+gGzj
	eLAafqLLi5CXoyAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DqCBnTWg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ciOt7Qe+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773325606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4ML6juhvu/Lrv9BlhPZh9r4PafO9TWb/C+RaJtduJ68=;
	b=DqCBnTWgAHV1ng3maDMlV9DAEIVffVxbe/hU3lhI9OH7jRtzUeL90liXT0SaerQpd50zut
	16oVj0SS2BDpfsIwqvhBqoI9RcwctmzMuY0gvdUnx0PHJ4aPFGW76lkPwsniv5dxn+25aG
	envuhdYNxTfzHPf3ngLVsTYwooMDuAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773325606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4ML6juhvu/Lrv9BlhPZh9r4PafO9TWb/C+RaJtduJ68=;
	b=ciOt7Qe+8Z7zS3iKM5U4zoAcGTsPEt5HswUjN1tvOJURj30qVr6mjreUdCdu5fjjsyhbPe
	rUS9PLRWlWiBPsDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DB0D3FFF5;
	Thu, 12 Mar 2026 14:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1DnLFybNsmkUdAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 12 Mar 2026 14:26:46 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next v4] ipv4: validate IPV4_DEVCONF attributes properly
Date: Thu, 12 Mar 2026 15:26:37 +0100
Message-ID: <20260312142637.5704-1-fmancera@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267101-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAB8827369C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As the IPV4_DEVCONF netlink attributes are not being validated, it is
possible to use netlink to set read-only values like mc_forwarding. In
addition, valid ranges are not being validated neither but that is less
relevant as they aren't in sysctl.

To avoid similar situations in the future, define a NLA policy for
IPV4_DEVCONF attributes which are nested in IFLA_INET_CONF.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: no changes
v3: dropped the fixes tag and adjusted the indentation of the policy,
MEDIUM_ID is now NLA_S32
v4: used NLA_POLICY_MIN() for MEDIUM_ID so the min value takes effect
properly, make ARP_ACCEPT accept 2 as valid value and checked each
attribute again so they match the documentation. Tested with a custom
script using libnl
---
 net/ipv4/devinet.c | 55 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 537bb6c315d2..58fe7cb69545 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2063,12 +2063,50 @@ static const struct nla_policy inet_af_policy[IFLA_INET_MAX+1] = {
 	[IFLA_INET_CONF]	= { .type = NLA_NESTED },
 };
 
+static const struct nla_policy inet_devconf_policy[IPV4_DEVCONF_MAX + 1] = {
+	[IPV4_DEVCONF_FORWARDING]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_MC_FORWARDING]	= { .type = NLA_REJECT },
+	[IPV4_DEVCONF_PROXY_ARP]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_ACCEPT_REDIRECTS]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_SECURE_REDIRECTS]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_SEND_REDIRECTS]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_SHARED_MEDIA]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_RP_FILTER]	= NLA_POLICY_RANGE(NLA_U32, 0, 2),
+	[IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE] = NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_BOOTP_RELAY]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_LOG_MARTIANS]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_TAG]		= { .type = NLA_U32 },
+	[IPV4_DEVCONF_ARPFILTER]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_MEDIUM_ID]	= NLA_POLICY_MIN(NLA_S32, -1),
+	[IPV4_DEVCONF_NOXFRM]		= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_NOPOLICY]		= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_FORCE_IGMP_VERSION] = NLA_POLICY_RANGE(NLA_U32, 0, 3),
+	[IPV4_DEVCONF_ARP_ANNOUNCE]	= NLA_POLICY_RANGE(NLA_U32, 0, 2),
+	[IPV4_DEVCONF_ARP_IGNORE]	= NLA_POLICY_RANGE(NLA_U32, 0, 8),
+	[IPV4_DEVCONF_PROMOTE_SECONDARIES] = NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_ARP_ACCEPT]	= NLA_POLICY_RANGE(NLA_U32, 0, 2),
+	[IPV4_DEVCONF_ARP_NOTIFY]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_ACCEPT_LOCAL]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_SRC_VMARK]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_PROXY_ARP_PVLAN]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_ROUTE_LOCALNET]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_BC_FORWARDING]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL] = { .type = NLA_U32 },
+	[IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL] = { .type = NLA_U32 },
+	[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN] =
+		NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST] =
+		NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_DROP_GRATUITOUS_ARP] = NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_ARP_EVICT_NOCARRIER] = NLA_POLICY_RANGE(NLA_U32, 0, 1),
+};
+
 static int inet_validate_link_af(const struct net_device *dev,
 				 const struct nlattr *nla,
 				 struct netlink_ext_ack *extack)
 {
-	struct nlattr *a, *tb[IFLA_INET_MAX+1];
-	int err, rem;
+	struct nlattr *tb[IFLA_INET_MAX + 1], *nested_tb[IPV4_DEVCONF_MAX + 1];
+	int err;
 
 	if (dev && !__in_dev_get_rtnl(dev))
 		return -EAFNOSUPPORT;
@@ -2079,15 +2117,12 @@ static int inet_validate_link_af(const struct net_device *dev,
 		return err;
 
 	if (tb[IFLA_INET_CONF]) {
-		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
-			int cfgid = nla_type(a);
+		err = nla_parse_nested(nested_tb, IPV4_DEVCONF_MAX,
+				       tb[IFLA_INET_CONF], inet_devconf_policy,
+				       extack);
 
-			if (nla_len(a) < 4)
-				return -EINVAL;
-
-			if (cfgid <= 0 || cfgid > IPV4_DEVCONF_MAX)
-				return -EINVAL;
-		}
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
-- 
2.53.0



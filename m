Return-Path: <netdev+bounces-261350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNCpCrVOoGmIiAQAu9opvQ
	(envelope-from <netdev+bounces-261350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:46:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6E71A6E39
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1BA730480C4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634D627587D;
	Thu, 26 Feb 2026 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HZz5O2lT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0jtwE0fH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HZz5O2lT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0jtwE0fH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F472472A6
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113201; cv=none; b=KiIitZ1Wi46mH0JhWf752B8mmJwozmV/NQ7L5AIrG2Ge00gtIdX6hgF5R1AuNmUQrv6UmOQTkHW/ZDeSLxh24NsZ1V+OaR0EkjPS+SozujjUPxCBgvmkytlJuiIL5CIU4H9QzntDt7I8BoSyXRk81F5i/0PzLtrd4n6JfpXKaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113201; c=relaxed/simple;
	bh=OoAR2IUdPfUFDpfthAytr+7Vy8Nge9nY+Ri2mkl1RVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eL9Dsd246BQCApNROAJ94f1KjqFsmIrlYZ/0iaTXbssGXuZdxh5np0GKJSBI9GdsEqXeD0nBx2zmrSZUAfzC5BjMI/dFSnBzNulQn6uul9oCvXP/uK/UIwKloGkdpnkOuRtm/gM4oJVNRvG0Fajx3sWkwCOa6+Bb4BEzk161Zvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HZz5O2lT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0jtwE0fH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HZz5O2lT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0jtwE0fH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 247BE4D372;
	Thu, 26 Feb 2026 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772113198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cvDSo/Pj6gpV1QbypJ6eAriHqDylEig072dIyeJz0Yk=;
	b=HZz5O2lTX7Msoykuyf2J3xSVaOa8tr11H222P7uip6rXjajUUNXwQ4CMvOLwg+kb2x12xl
	Ch+5Y5n+VAJoR8SjEH4kgdgpvKAFMZgd5+HsmJW0OjQgAWyfeQcDn/8j+9ZjHl5hXcBHHL
	gPkF0hGBBJ4eFoylW6tvcXqynUhsJj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772113198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cvDSo/Pj6gpV1QbypJ6eAriHqDylEig072dIyeJz0Yk=;
	b=0jtwE0fHGnzwtLoGTaQ9trNntLJvJrdi/AEmvSQfsZs3J64PNRondRaqaqn4ISNCQ8/R8w
	+amQO2H299Ui6VAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HZz5O2lT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0jtwE0fH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772113198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cvDSo/Pj6gpV1QbypJ6eAriHqDylEig072dIyeJz0Yk=;
	b=HZz5O2lTX7Msoykuyf2J3xSVaOa8tr11H222P7uip6rXjajUUNXwQ4CMvOLwg+kb2x12xl
	Ch+5Y5n+VAJoR8SjEH4kgdgpvKAFMZgd5+HsmJW0OjQgAWyfeQcDn/8j+9ZjHl5hXcBHHL
	gPkF0hGBBJ4eFoylW6tvcXqynUhsJj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772113198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cvDSo/Pj6gpV1QbypJ6eAriHqDylEig072dIyeJz0Yk=;
	b=0jtwE0fHGnzwtLoGTaQ9trNntLJvJrdi/AEmvSQfsZs3J64PNRondRaqaqn4ISNCQ8/R8w
	+amQO2H299Ui6VAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 853F33EA62;
	Thu, 26 Feb 2026 13:39:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hA9fHS1NoGl/ZQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 26 Feb 2026 13:39:57 +0000
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
Subject: [PATCH 1/2 net-next v2] ipv4: validate IPV4_DEVCONF attributes properly
Date: Thu, 26 Feb 2026 14:39:48 +0100
Message-ID: <20260226133949.17070-1-fmancera@suse.de>
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
	TAGGED_FROM(0.00)[bounces-261350-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 8B6E71A6E39
X-Rspamd-Action: no action

As the IPV4_DEVCONF netlink attributes are not being validated, it is
possible to use netlink to set read-only values like mc_forwarding. In
addition, valid ranges are not being validated neither but that is less
relevant as they aren't in sysctl.

To avoid similar situations in the future, define a NLA policy for
IPV4_DEVCONF attributes which are nested in IFLA_INET_CONF.

Please note that MEDIUM_ID is defined as NLA_U32 too because currently
its usage through netlink is broken for its valid value -1. Modifying
the type to NLA_S32 would break existing users of set/get netlink
operation.

Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: no changes
---
 net/ipv4/devinet.c | 81 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 942a887bf089..590c68e979f5 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2063,12 +2063,76 @@ static const struct nla_policy inet_af_policy[IFLA_INET_MAX+1] = {
 	[IFLA_INET_CONF]	= { .type = NLA_NESTED },
 };
 
+static const struct nla_policy inet_devconf_policy[IPV4_DEVCONF_MAX + 1] = {
+	[IPV4_DEVCONF_FORWARDING]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_MC_FORWARDING]			  = { .type = NLA_REJECT },
+	[IPV4_DEVCONF_PROXY_ARP]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ACCEPT_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_SECURE_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_SEND_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_SHARED_MEDIA]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_RP_FILTER]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 2),
+	[IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE]		  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_BOOTP_RELAY]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_LOG_MARTIANS]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_TAG]				  = { .type = NLA_U32 },
+	[IPV4_DEVCONF_ARPFILTER]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_MEDIUM_ID]			  = { .type = NLA_U32 },
+	[IPV4_DEVCONF_NOXFRM]				  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_NOPOLICY]				  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_FORCE_IGMP_VERSION]		  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 3),
+	[IPV4_DEVCONF_ARP_ANNOUNCE]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 2),
+	[IPV4_DEVCONF_ARP_IGNORE]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 8),
+	[IPV4_DEVCONF_PROMOTE_SECONDARIES]		  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ARP_ACCEPT]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ARP_NOTIFY]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ACCEPT_LOCAL]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_SRC_VMARK]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_PROXY_ARP_PVLAN]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ROUTE_LOCALNET]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL] = { .type = NLA_U32 },
+	[IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL] = { .type = NLA_U32 },
+	[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN]	  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST]	  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_DROP_GRATUITOUS_ARP]		  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_BC_FORWARDING]			  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
+	[IPV4_DEVCONF_ARP_EVICT_NOCARRIER]		  = NLA_POLICY_RANGE(NLA_U32,
+									     0, 1),
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
@@ -2079,15 +2143,12 @@ static int inet_validate_link_af(const struct net_device *dev,
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



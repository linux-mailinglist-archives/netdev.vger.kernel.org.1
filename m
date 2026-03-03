Return-Path: <netdev+bounces-263191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPMtDOHWpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:41:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E744D1EF9AA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F2AA302E577
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13B031F993;
	Tue,  3 Mar 2026 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kqmfQtV7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iwzRjpzQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kqmfQtV7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iwzRjpzQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108E390998
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541657; cv=none; b=S1G9qYCpPq5jEPRQMSAY6cMDctqIbCiV06cLyW0JugN3/MCgAMhVAXWeGhoVRM3swY35NUNLcH64oFgT/njZYSGu5Hltg7L/+TOtY1DyebQuimXYUxlMvWLx3Nu2rdQAWToYG2lxaLfS1gJpFJbXSCw+QqfrQXOrT+XAiRHBOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541657; c=relaxed/simple;
	bh=vqQEk5n5/XrMOM0ruXiv01//5MyRyGXCKVbqB3skOsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiYNyEh9jyLKwkr1DtHv8FSkCvgE//Xjolhbx+3ayYOBxjo5ttzY48176Cj5wdlwwiTA5Pivx+dIP+C1sN2vLehAzGZD9J3vhm0yVLrjzdXcJOngaBf3OSyQ8H3z//q4ZdZtfHmxw0sluq3S54Zbd0kX+gvebwbplIA5kViWMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kqmfQtV7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iwzRjpzQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kqmfQtV7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iwzRjpzQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E1FD5BE0E;
	Tue,  3 Mar 2026 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772541654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fP9wHdHt+l9eAWWndKH89RzoyYuJioi49L3tx3l1fn4=;
	b=kqmfQtV7btEqRQqHCWXY5uhFdmoe9+VM0Qd57OyjGs+tOpvK62/giGTBZStVlzhJwCb96A
	QEJKlKKJe1e1AseilPm3dgWZTg2cOLZs07nVlSGXj2IROSTgEKLFGW6xf3YFJGIIsC9hyw
	bizw8vNKVZr68mS1yF+Lb3jT9M4UtQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772541654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fP9wHdHt+l9eAWWndKH89RzoyYuJioi49L3tx3l1fn4=;
	b=iwzRjpzQAghHX2nZZoqSIVHJC5x4ZpI4xQi1C9J6hCTdGMOmPHS2//jyX0zBvL9nBpUjiS
	R3Y26nvoSbA7CNBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kqmfQtV7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iwzRjpzQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772541654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fP9wHdHt+l9eAWWndKH89RzoyYuJioi49L3tx3l1fn4=;
	b=kqmfQtV7btEqRQqHCWXY5uhFdmoe9+VM0Qd57OyjGs+tOpvK62/giGTBZStVlzhJwCb96A
	QEJKlKKJe1e1AseilPm3dgWZTg2cOLZs07nVlSGXj2IROSTgEKLFGW6xf3YFJGIIsC9hyw
	bizw8vNKVZr68mS1yF+Lb3jT9M4UtQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772541654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fP9wHdHt+l9eAWWndKH89RzoyYuJioi49L3tx3l1fn4=;
	b=iwzRjpzQAghHX2nZZoqSIVHJC5x4ZpI4xQi1C9J6hCTdGMOmPHS2//jyX0zBvL9nBpUjiS
	R3Y26nvoSbA7CNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1AC93EA69;
	Tue,  3 Mar 2026 12:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qDZGLNXWpmmvHQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 03 Mar 2026 12:40:53 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next v3] ipv4: validate IPV4_DEVCONF attributes properly
Date: Tue,  3 Mar 2026 13:40:38 +0100
Message-ID: <20260303124038.5886-1-fmancera@suse.de>
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
X-Rspamd-Queue-Id: E744D1EF9AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263191-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

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
---
 net/ipv4/devinet.c | 55 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 537bb6c315d2..9309b761bb9a 100644
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
+	[IPV4_DEVCONF_MEDIUM_ID]	= { .type = NLA_S32, .min = -1 },
+	[IPV4_DEVCONF_NOXFRM]		= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_NOPOLICY]		= NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_FORCE_IGMP_VERSION] = NLA_POLICY_RANGE(NLA_U32, 0, 3),
+	[IPV4_DEVCONF_ARP_ANNOUNCE]	= NLA_POLICY_RANGE(NLA_U32, 0, 2),
+	[IPV4_DEVCONF_ARP_IGNORE]	= NLA_POLICY_RANGE(NLA_U32, 0, 8),
+	[IPV4_DEVCONF_PROMOTE_SECONDARIES] = NLA_POLICY_RANGE(NLA_U32, 0, 1),
+	[IPV4_DEVCONF_ARP_ACCEPT]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
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



Return-Path: <netdev+bounces-272521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ2aKtBxxmmkJwUAu9opvQ
	(envelope-from <netdev+bounces-272521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:02:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D8343EC7
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5446305022D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078236922F;
	Fri, 27 Mar 2026 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QJN6CQUZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9Setxi1P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="utTRGhbm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v8aISB3/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A12286AC
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612937; cv=none; b=YOSvkPtpO6JlleAI/F5Yg4p7Pd1i6L5Yv59EfX/6/wW6ut9aZLr4DaTp2BDVy6deYZXdBpugPR3pReYZvbu9LlTx5BT4wo9kwNEhQnpx9MaA/yMSlEalbzCI3D8mMInLAjmu3LoIGdQRape9zrPzPPpc3VSLetF/S3wCInXYsjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612937; c=relaxed/simple;
	bh=IUdbVU352B+WVnw3ik10sru14NF7e1Ub8sw2WMDktts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLiza4X38yrk6ABe9/ok0YY8w2bZcG+N1zCSuVqxw6u0clB6hNHwxaalkmRb71jKiMMO5yZJDOwDDLQt6LzDTnSU3+1SJEppmCheiup2PzgRoMaWsNmtHEIjmtz2RxhnIK53M/R/A3vmBCa51ky4UZUSVhgPVmjyaWjr3g9XePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QJN6CQUZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9Setxi1P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=utTRGhbm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v8aISB3/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E59A5BDD9;
	Fri, 27 Mar 2026 12:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774612934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RTKNO9yPR9+mP7795ZhKUjZQqSPJ5Ojrj1duhzBZs+I=;
	b=QJN6CQUZf6oyPCkQlVEQLf60Z6hXUaPiNqnID+Hx1MpqeiD3kuEU1EpKAMPeWidpXEKjuY
	zhVpIyP90jeQ0tuDvWU96XmW9VQCwrd5WrfiNjgUZEteeLU69PxzYL3Lcd4oip46dFGkZO
	UWenomOqq2uW1sJi4s2WdU7klVNMyH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774612934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RTKNO9yPR9+mP7795ZhKUjZQqSPJ5Ojrj1duhzBZs+I=;
	b=9Setxi1PtJy0IFbyIeJFZQ9Kx6LCva2kjhzFgrua1sgIoD2YdgHYnqAdKIyQG+sItf/LIU
	hW1VEsXY4jcGTMAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774612932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RTKNO9yPR9+mP7795ZhKUjZQqSPJ5Ojrj1duhzBZs+I=;
	b=utTRGhbmGRkGMxBvNy4x8IbMY0mZtY0qu5ZTrY2H5T4Gz5tnrjEh/D2I9x/AkBduMqRlmv
	+lVbO5dCFtXH9qrLjq59a1GMiu2ChwGGJP6mywcpG0aYede7vZFxdxxuAil5MJBcuTwQaq
	+4v/S4QE9tCkiPISdhq/sdspecl+OEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774612932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RTKNO9yPR9+mP7795ZhKUjZQqSPJ5Ojrj1duhzBZs+I=;
	b=v8aISB3/C3R75GdKtNPuoX9jDrlw81E99MELYxvC/aS5kFygnOPXeR2t2KDjyo1PVNL3CG
	WUeKS656vMitX9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6B794A0B1;
	Fri, 27 Mar 2026 12:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6NxgJcNxxmlfOwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 27 Mar 2026 12:02:11 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/2 net-next v2] ipv4: centralize devconf sysctl handling
Date: Fri, 27 Mar 2026 13:02:01 +0100
Message-ID: <20260327120202.4761-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272521-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 517D8343EC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The logic for handling IPv4 devconf sysctls is scattered. Notification
and cache flushes are managed in devinet_conf_proc(), while a separate
ipv4_doint_and_flush() function and DEVINET_SYSCTL_FLUSHING_ENTRY macro
is used for properties that solely require a cache flush.

This patch refactors the sysctl handling by introducing a centralized
helper, devinet_conf_post_set(). This new function evaluates the changed
attribute and handles all necessary operations like triggering netlink
notifications. It returns a boolean indicating whether a routing cache
flush is required.

Note that the boolean is necessary as this function will be re-used for
netlink IPv4 devconf handling where the cache flushing must wait until
all the attributes have been processed.

Finally, this is introducing a small change in behavior for
IPV4_DEVCONF_ROUTE_LOCALNET. As commit d0daebc3d622 ("ipv4: Add
interface option to enable routing of 127.0.0.0/8") intended, the cache
flush should only be performed when ROUTE_LOCALNET changes from 1 to 0.
Unfortunately, this was not true because while implementing it the
DEVINET_SYSCTL_FLUSHING_ENTRY was used for the attribute, making the
code related to it on devinet_conf_proc() dead.

IPV4_DEVCONF_FORWARDING is still being handled separately as it requires
more operations.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: no changes
---
 net/ipv4/devinet.c | 127 ++++++++++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 59 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 58fe7cb69545..8300516fb38f 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2128,6 +2128,46 @@ static int inet_validate_link_af(const struct net_device *dev,
 	return 0;
 }
 
+static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
+				  int attr, int new, int old, int ifindex)
+{
+	if (new == old)
+		return false;
+
+	switch (attr) {
+	case IPV4_DEVCONF_ROUTE_LOCALNET:
+	case IPV4_DEVCONF_ACCEPT_LOCAL:
+		if (new == 0)
+			return true;
+		break;
+	case IPV4_DEVCONF_NOXFRM:
+	case IPV4_DEVCONF_NOPOLICY:
+	case IPV4_DEVCONF_PROMOTE_SECONDARIES:
+	case IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST:
+	case IPV4_DEVCONF_BC_FORWARDING:
+		return true;
+	case IPV4_DEVCONF_RP_FILTER:
+		inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
+					    NETCONFA_RP_FILTER,
+					    ifindex, cnf);
+		break;
+	case IPV4_DEVCONF_PROXY_ARP:
+		inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
+					    NETCONFA_PROXY_NEIGH,
+					    ifindex, cnf);
+		break;
+	case IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN:
+		inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
+					    NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
+					    ifindex, cnf);
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 			    struct netlink_ext_ack *extack)
 {
@@ -2509,44 +2549,31 @@ static int devinet_conf_proc(const struct ctl_table *ctl, int write,
 
 	if (write) {
 		struct ipv4_devconf *cnf = ctl->extra1;
-		struct net *net = ctl->extra2;
 		int i = (int *)ctl->data - cnf->data;
+		struct net *net = ctl->extra2;
 		int ifindex;
 
-		set_bit(i, cnf->state);
-
-		if (cnf == net->ipv4.devconf_dflt)
-			devinet_copy_dflt_conf(net, i);
-		if (i == IPV4_DEVCONF_ACCEPT_LOCAL - 1 ||
-		    i == IPV4_DEVCONF_ROUTE_LOCALNET - 1)
-			if ((new_value == 0) && (old_value != 0))
-				rt_cache_flush(net);
+		/* These attributes are bypassing the tracking state,
+		 * for the rest track the state and propagate the changes
+		 * to default config
+		 */
+		switch (i + 1) {
+		case IPV4_DEVCONF_NOXFRM:
+		case IPV4_DEVCONF_NOPOLICY:
+		case IPV4_DEVCONF_PROMOTE_SECONDARIES:
+		case IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST:
+			break;
+		default:
+			set_bit(i, cnf->state);
+			if (cnf == net->ipv4.devconf_dflt)
+				devinet_copy_dflt_conf(net, i);
+			break;
+		}
 
-		if (i == IPV4_DEVCONF_BC_FORWARDING - 1 &&
-		    new_value != old_value)
+		ifindex = devinet_conf_ifindex(net, cnf);
+		if (devinet_conf_post_set(net, cnf, i + 1, new_value,
+					  old_value, ifindex))
 			rt_cache_flush(net);
-
-		if (i == IPV4_DEVCONF_RP_FILTER - 1 &&
-		    new_value != old_value) {
-			ifindex = devinet_conf_ifindex(net, cnf);
-			inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
-						    NETCONFA_RP_FILTER,
-						    ifindex, cnf);
-		}
-		if (i == IPV4_DEVCONF_PROXY_ARP - 1 &&
-		    new_value != old_value) {
-			ifindex = devinet_conf_ifindex(net, cnf);
-			inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
-						    NETCONFA_PROXY_NEIGH,
-						    ifindex, cnf);
-		}
-		if (i == IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN - 1 &&
-		    new_value != old_value) {
-			ifindex = devinet_conf_ifindex(net, cnf);
-			inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
-						    NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
-						    ifindex, cnf);
-		}
 	}
 
 	return ret;
@@ -2599,20 +2626,6 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int ipv4_doint_and_flush(const struct ctl_table *ctl, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
-{
-	int *valp = ctl->data;
-	int val = *valp;
-	int ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
-	struct net *net = ctl->extra2;
-
-	if (write && *valp != val)
-		rt_cache_flush(net);
-
-	return ret;
-}
-
 #define DEVINET_SYSCTL_ENTRY(attr, name, mval, proc) \
 	{ \
 		.procname	= name, \
@@ -2633,9 +2646,6 @@ static int ipv4_doint_and_flush(const struct ctl_table *ctl, int write,
 #define DEVINET_SYSCTL_COMPLEX_ENTRY(attr, name, proc) \
 	DEVINET_SYSCTL_ENTRY(attr, name, 0644, proc)
 
-#define DEVINET_SYSCTL_FLUSHING_ENTRY(attr, name) \
-	DEVINET_SYSCTL_COMPLEX_ENTRY(attr, name, ipv4_doint_and_flush)
-
 static struct devinet_sysctl_table {
 	struct ctl_table_header *sysctl_header;
 	struct ctl_table devinet_vars[IPV4_DEVCONF_MAX];
@@ -2678,15 +2688,14 @@ static struct devinet_sysctl_table {
 					"ignore_routes_with_linkdown"),
 		DEVINET_SYSCTL_RW_ENTRY(DROP_GRATUITOUS_ARP,
 					"drop_gratuitous_arp"),
-
-		DEVINET_SYSCTL_FLUSHING_ENTRY(NOXFRM, "disable_xfrm"),
-		DEVINET_SYSCTL_FLUSHING_ENTRY(NOPOLICY, "disable_policy"),
-		DEVINET_SYSCTL_FLUSHING_ENTRY(PROMOTE_SECONDARIES,
-					      "promote_secondaries"),
-		DEVINET_SYSCTL_FLUSHING_ENTRY(ROUTE_LOCALNET,
-					      "route_localnet"),
-		DEVINET_SYSCTL_FLUSHING_ENTRY(DROP_UNICAST_IN_L2_MULTICAST,
-					      "drop_unicast_in_l2_multicast"),
+		DEVINET_SYSCTL_RW_ENTRY(NOXFRM, "disable_xfrm"),
+		DEVINET_SYSCTL_RW_ENTRY(NOPOLICY, "disable_policy"),
+		DEVINET_SYSCTL_RW_ENTRY(PROMOTE_SECONDARIES,
+					"promote_secondaries"),
+		DEVINET_SYSCTL_RW_ENTRY(ROUTE_LOCALNET,
+					"route_localnet"),
+		DEVINET_SYSCTL_RW_ENTRY(DROP_UNICAST_IN_L2_MULTICAST,
+					"drop_unicast_in_l2_multicast"),
 	},
 };
 
-- 
2.53.0



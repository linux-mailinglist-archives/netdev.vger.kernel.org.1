Return-Path: <netdev+bounces-297280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ftm2DOR7KGpRFQMAu9opvQ
	(envelope-from <netdev+bounces-297280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:47:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A010664214
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:47:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vUcluIp1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cwGcjUL+;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pAB3RrIv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WBfTPZj7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297280-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297280-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 565E7308CA7B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032CD3D3CF4;
	Tue,  9 Jun 2026 20:45:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E53DB64E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 20:45:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037940; cv=none; b=k1Vh6W4ajAEhThGLV3lnQt32fFqjLUGge+7H9MjyFXhU4EyCfZ++sOgD5ZMsi2haUKoBhhNnu6P7TrVccYaqAsK9s143WnyDHcgMz3Jy+YzKQsHfmYXy34S3fH9KkmBtZAsVf/rNZmvHyPDsRhrqhgjZRWYehrC/2cNCWnvMerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037940; c=relaxed/simple;
	bh=UVizKLNAF3SvUaSRKUMFDluePoYDDX52CyKms0lr6eM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMqXVr2fmolk+b24QXHgsYbI0aBHXoltz2MZH+FPaUGYD53DUwBVKKhQYyev14kRoOlzofpcpC78CvNZMCsxWQfEvPMvd4N/X3mVwUQNeuGnHdToeeMdJTrU98AHuSvV5t7j5Uz9enBtJa+p/apTnz9ao3qJx2gEKCUfCXp4wnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vUcluIp1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cwGcjUL+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pAB3RrIv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WBfTPZj7; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB16975892;
	Tue,  9 Jun 2026 20:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781037937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AmMxiHFQb6vKjFusdncroCIZggtdtZPQUjjqoQz8obQ=;
	b=vUcluIp1z25y7jyicCunqz568jZNqUiL6ROoQojg1SPbv2G5kXNGrjSmAv/M+zVf7FwEV9
	XcdZWqpve09VfvQosPshUBXoeJnhg0iWJf+eOK5Vg9MnenlroBOVYiRYp7SGgZrAcs++lI
	8mu/DCZHQ/NLsaigEZmn39ije2r80xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781037937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AmMxiHFQb6vKjFusdncroCIZggtdtZPQUjjqoQz8obQ=;
	b=cwGcjUL+JyYVlZD9m/oE6pxgOoucUpDTBEzN6uWmUuO+WIk7pxObrCWI8i1osb/C/rHXhR
	eDyBihlwg83dttDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781037936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AmMxiHFQb6vKjFusdncroCIZggtdtZPQUjjqoQz8obQ=;
	b=pAB3RrIvNmxkzVQWHTElC3QjR0/Lw5lGO8ayFFq5Yz/po6ibNN9EzfaWXHxPAe9W46/o5L
	H1lsXuK7nvzaHZDuuOnIDlx768/2+NC4tZKoecHwlFFFwY7bdoZ/lXphmiPDmGk/hrIdTW
	6HotVDB2wsT0JBCntOERMHdo35LvC6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781037936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AmMxiHFQb6vKjFusdncroCIZggtdtZPQUjjqoQz8obQ=;
	b=WBfTPZj7mYrrCjms9EpoNkTPCKH/PCXEeFQbWuGPmAu1fVkYlTCX6s58EUsCVKk1XoHk7i
	tewXxbnzqaQZYaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 537D6779A7;
	Tue,  9 Jun 2026 20:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SxldEXB7KGq7PwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 09 Jun 2026 20:45:36 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH 1/3 net-next v6] ipv4: centralize devconf sysctl handling
Date: Tue,  9 Jun 2026 22:45:18 +0200
Message-ID: <20260609204520.4670-1-fmancera@suse.de>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297280-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:fmancera@suse.de,m:nicolas.dichtel@6wind.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A010664214

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

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: no changes
v3: no changes
v4: no changes
v5: no changes
v6: no changes
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
2.54.0



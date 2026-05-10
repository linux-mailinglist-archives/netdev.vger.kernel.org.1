Return-Path: <netdev+bounces-286252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BdXzIrQ+AGrLEwEAu9opvQ
	(envelope-from <netdev+bounces-286252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:15:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8425030D1
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58392300A12F
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 08:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74C35BDAA;
	Sun, 10 May 2026 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YBK1Monn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="itXjGzmp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YgvDZ1x2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p4R7HGRh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DE7E0FF
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778400944; cv=none; b=Erh/DX8ApMwawIU3S18hnhhFQsLocmLALtUZ+SFwDPv+pAmPEt/3GDKK0/WAOwdA6rsA/X5SCWQ71dNvFcbvh5SRFC5ZUcTTgR0pidZO/e7LO0G8lkIPDXPfshYcnz1tvyUDhFI4nGEUiln6bYbmzXQQbIdVt40RvAwCPGi2FPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778400944; c=relaxed/simple;
	bh=QKbeZQnTNT2+ixsxtrSX7WIxy3w1pw/1vwCw8npyY5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxX8P3HbLrwf+dOHU4ZBd8oKqaICzlst1P16akL1ycbdQQ0+PFMejCrHUgdDG+6TCJRlIE8hZqSKPrnnoNsZskPjsl03KvspZpVrALlj344IO7Ifk8xcpobqEKllAWsYnYI2BbtSlhg0X7z4OIQjLrlFNvYXDw6agnywB1zl130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YBK1Monn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=itXjGzmp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YgvDZ1x2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p4R7HGRh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A9166B366;
	Sun, 10 May 2026 08:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778400940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sxObztbhk40giDLEzUKLgFKG+24CAROXC+z7S4M3pgs=;
	b=YBK1MonnoxrNgEhpzO77eSzU9AwXevaqfOyJFsFXa8wFt+LW7ZKQhBHiMwKw4S5Oapoi9x
	YJKW/1s9iNnRLMJKl+ltDpJfemOIzKri3YG0XmDSAoOcFLPGPIuCHaatnbWG9o6wJfJQGG
	GJ46Z+4DXDb8h1+/Bs+kgpVkgexZjTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778400940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sxObztbhk40giDLEzUKLgFKG+24CAROXC+z7S4M3pgs=;
	b=itXjGzmpZg6+ilZOwh4zuXdeWWs5jaMDo4mSLgs/pIXFg4ijETgZeHXadGalwbjCBTcpyU
	2cMVzoQja+S0kDDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YgvDZ1x2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p4R7HGRh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778400939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sxObztbhk40giDLEzUKLgFKG+24CAROXC+z7S4M3pgs=;
	b=YgvDZ1x2pa79XSVZhJ3pDAo0A6ML2cN7AUyCRIJD1PRv9mrHWSOKYwQsi2IAjPc6EHqwDf
	hgEC+Q0aQfLLWKTB/GhucMVRG6TBeaqBicS3Kwws2xaFdB/n3Xk+y5cUJ34ivc5B6+JOGl
	6nNbm29Jj+xQLI8yVEpT1dnNPQMLXW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778400939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sxObztbhk40giDLEzUKLgFKG+24CAROXC+z7S4M3pgs=;
	b=p4R7HGRh1WBGcUSAtSrUlYrcnIMDtqTbJPWP8Khls8e6PbOYMp1xU5UXcXzm0buIOwErQ6
	AkKP7beMEf8pTGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8D66593A3;
	Sun, 10 May 2026 08:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vxsSLqo+AGrIDgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 10 May 2026 08:15:38 +0000
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
Subject: [PATCH 1/3 net-next v4] ipv4: centralize devconf sysctl handling
Date: Sun, 10 May 2026 10:15:26 +0200
Message-ID: <20260510081528.5257-1-fmancera@suse.de>
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
X-Rspamd-Queue-Id: EB8425030D1
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
	TAGGED_FROM(0.00)[bounces-286252-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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



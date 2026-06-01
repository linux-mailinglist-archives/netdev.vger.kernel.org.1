Return-Path: <netdev+bounces-293792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHiNNuqYHWpOcgkAu9opvQ
	(envelope-from <netdev+bounces-293792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:36:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED7D620F8F
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19E2E300CBF8
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C153BE620;
	Mon,  1 Jun 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dAoPReK7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9IT+GERC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dAoPReK7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9IT+GERC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2CD199FAB
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324373; cv=none; b=o4XMFtwYyR9RlPknU3gySlCJIuuww0hqit5S7xDbSgvhKupQJ+5bBa4ZRQybpasL4p9pqpH1Ki7tdI7YLF1mTbotFCQpxYVb/XHy284mwxZ/XF5GTaqPVAUP2Mq5rV8GtBUT2OBLZZ/dMwtvKgn68WjdW8r3x/1n6r6+CU7nV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324373; c=relaxed/simple;
	bh=wzuuoojLl57BYh+XxYTTNcmVRWmhCBU2yxmBmdj9lL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUyobWD8HmR7sTINiWV3z6mnmpzuKMbmV5ZD5y4Q6koBi2aPdzF/W1//BQigqbST8aLGkxRoenoZiZE/538QcOddB9a8EKBv9dSQy50s+qz1di1ZaOzZc7qNFyXKEacW0ws788IGYvcdP1Aua+NhirdoUahNSgcZ4djghwWMifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dAoPReK7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9IT+GERC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dAoPReK7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9IT+GERC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8E8667B7E;
	Mon,  1 Jun 2026 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780324369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZftoRg3SVoI8T5mwtkk9x2TgJuhlY51Vpu1wz6oOLGA=;
	b=dAoPReK7eVxqEt7aguc3eMUkge68ONKs5Gztvvf6VGyQNOkckTp6uz0xjLiWc9YLixyS8t
	QQx+lf7AmDgvRM/hkRu8geXq+S88gcjr/7rceLVCcgX5IGf7Pc4W1rtjQGKCxVQF+YJPAX
	N4GyljZaCs3r+zWuKLhEofhELf5G9w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780324369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZftoRg3SVoI8T5mwtkk9x2TgJuhlY51Vpu1wz6oOLGA=;
	b=9IT+GERC54sSD49BGWF1tr+nZn0G16SzTHZXedJWfzqfhKR14UzI5xPcEmFYUreGCJ8X/h
	tOITBJRoXb9PALBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dAoPReK7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9IT+GERC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780324369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZftoRg3SVoI8T5mwtkk9x2TgJuhlY51Vpu1wz6oOLGA=;
	b=dAoPReK7eVxqEt7aguc3eMUkge68ONKs5Gztvvf6VGyQNOkckTp6uz0xjLiWc9YLixyS8t
	QQx+lf7AmDgvRM/hkRu8geXq+S88gcjr/7rceLVCcgX5IGf7Pc4W1rtjQGKCxVQF+YJPAX
	N4GyljZaCs3r+zWuKLhEofhELf5G9w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780324369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZftoRg3SVoI8T5mwtkk9x2TgJuhlY51Vpu1wz6oOLGA=;
	b=9IT+GERC54sSD49BGWF1tr+nZn0G16SzTHZXedJWfzqfhKR14UzI5xPcEmFYUreGCJ8X/h
	tOITBJRoXb9PALBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FEEA779A7;
	Mon,  1 Jun 2026 14:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sx+BEBGYHWppBgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 01 Jun 2026 14:32:49 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH iproute2-next] iplink: add support for setting IPv4 devconf parameters
Date: Mon,  1 Jun 2026 16:32:42 +0200
Message-ID: <20260601143242.6729-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.01
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
	TAGGED_FROM(0.00)[bounces-293792-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 0ED7D620F8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, modifying IPv4 interface configuration parameters requires
interacting with sysctl (/proc/sys/net/ipv4/conf/*). While
ip-netconf exists for monitoring these values, there has been no native
way to set them directly through iproute2.

This patch introduces the support for that via 'inet' at the 'ip link
set'. It uses IFLA_INET_CONF netlink attribute to set the parameter.

Example to enable forwarding on an interface:

ip link set dev enp8s0 inet forwarding on

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 ip/iplink.c           | 354 ++++++++++++++++++++++++++++++++++++++++++
 man/man8/ip-link.8.in |  81 ++++++++++
 2 files changed, 435 insertions(+)

diff --git a/ip/iplink.c b/ip/iplink.c
index 2c052d29..38bdc71f 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -19,6 +19,7 @@
 #include <arpa/inet.h>
 #include <linux/if.h>
 #include <linux/if_ether.h>
+#include <linux/ip.h>
 
 #include "rt_names.h"
 #include "utils.h"
@@ -102,6 +103,23 @@ void iplink_usage(void)
 		"		[ master DEVICE ][ vrf NAME ]\n"
 		"		[ nomaster ]\n"
 		"		[ addrgenmode { eui64 | none | stable_secret | random } ]\n"
+		"		[ inet [ { forwarding | proxy_arp | accept_redirects |\n"
+		"			   secure_redirects | send_redirects | shared_media |\n"
+		"			   accept_source_route | bootp_relay | log_martians |\n"
+		"			   arp_filter | disable_xfrm | disable_policy |\n"
+		"			   promote_secondaries | arp_notify | accept_local |\n"
+		"			   src_vmark | proxy_arp_pvlan | route_localnet |\n"
+		"			   bc_forwarding | ignore_routes_with_linkdown |\n"
+		"			   drop_unicast_in_l2_multicast |\n"
+		"			   drop_gratuitous_arp | arp_evict_nocarrier } { on | off } ]\n"
+		"		       [ rp_filter { 0 | 1 | 2 } ]\n"
+		"		       [ arp_announce { 0 | 1 | 2 } ]\n"
+		"		       [ arp_ignore { 0 | 1 | ... | 8 } ]\n"
+		"		       [ arp_accept { 0 | 1 | 2 } ]\n"
+		"		       [ force_igmp_version { 0 | 1 | 2 | 3 } ]\n"
+		"		       [ tag TAG ] [ medium_id ID ]\n"
+		"		       [ igmpv2_unsolicited_report_interval INTERVAL ]\n"
+		"		       [ igmpv3_unsolicited_report_interval INTERVAL ] ]\n"
 		"		[ protodown { on | off } ]\n"
 		"		[ protodown_reason PREASON { on | off } ]\n"
 		"		[ gso_max_size BYTES ] [ gso_ipv4_max_size BYTES ] [ gso_max_segs PACKETS ]\n"
@@ -551,6 +569,339 @@ static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
 	return 0;
 }
 
+static int iplink_parse_inet(int *argcp, char ***argvp, struct iplink_req *req)
+{
+	struct rtattr *afs, *afinet, *inet_devconf;
+	char **argv = *argvp;
+	int argc = *argcp;
+	int ret;
+
+	afs = addattr_nest(&req->n, sizeof(*req), IFLA_AF_SPEC);
+	afinet = addattr_nest(&req->n, sizeof(*req), AF_INET);
+	inet_devconf = addattr_nest(&req->n, sizeof(*req), IFLA_INET_CONF);
+
+	while (NEXT_ARG_OK()) {
+		NEXT_ARG();
+		if (matches(*argv, "forwarding") == 0) {
+			int forwarding;
+
+			NEXT_ARG();
+			forwarding = parse_on_off("forwarding", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_FORWARDING, forwarding);
+		} else if (matches(*argv, "proxy_arp") == 0) {
+			int proxy_arp;
+
+			NEXT_ARG();
+			proxy_arp = parse_on_off("proxy_arp", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_PROXY_ARP, proxy_arp);
+		} else if (matches(*argv, "accept_redirects") == 0) {
+			int accept_redirects;
+
+			NEXT_ARG();
+			accept_redirects = parse_on_off("accept_redirects", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_ACCEPT_REDIRECTS, accept_redirects);
+		} else if (matches(*argv, "secure_redirects") == 0) {
+			int secure_redirects;
+
+			NEXT_ARG();
+			secure_redirects = parse_on_off("secure_redirects", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_SECURE_REDIRECTS, secure_redirects);
+		} else if (matches(*argv, "send_redirects") == 0) {
+			int send_redirects;
+
+			NEXT_ARG();
+			send_redirects = parse_on_off("send_redirects", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_SEND_REDIRECTS, send_redirects);
+		} else if (matches(*argv, "shared_media") == 0) {
+			int shared_media;
+
+			NEXT_ARG();
+			shared_media = parse_on_off("shared_media", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_SHARED_MEDIA, shared_media);
+		} else if (matches(*argv, "rp_filter") == 0) {
+			int rp_filter;
+
+			NEXT_ARG();
+			if (get_integer(&rp_filter, *argv, 0)) {
+				invarg("Invalid \"rp_filter\" value\n", *argv);
+				return -1;
+			}
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_RP_FILTER, rp_filter);
+		} else if (matches(*argv, "accept_source_route") == 0) {
+			int accept_source_route;
+
+			NEXT_ARG();
+			accept_source_route = parse_on_off("accept_source_route", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE, accept_source_route);
+		} else if (matches(*argv, "bootp_relay") == 0) {
+			int bootp_relay;
+
+			NEXT_ARG();
+			bootp_relay = parse_on_off("bootp_relay", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_BOOTP_RELAY, bootp_relay);
+		} else if (matches(*argv, "log_martians") == 0) {
+			int log_martians;
+
+			NEXT_ARG();
+			log_martians = parse_on_off("log_martians", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_LOG_MARTIANS, log_martians);
+		} else if (matches(*argv, "tag") == 0) {
+			int tag;
+
+			NEXT_ARG();
+			if (get_integer(&tag, *argv, 0)) {
+				invarg("Invalid \"tag\" value\n", *argv);
+				return -1;
+			}
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_TAG, tag);
+		} else if (matches(*argv, "arp_filter") == 0) {
+			int arp_filter;
+
+			NEXT_ARG();
+			arp_filter = parse_on_off("arp_filter", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_ARPFILTER, arp_filter);
+		} else if (matches(*argv, "medium_id") == 0) {
+			int medium_id;
+
+			NEXT_ARG();
+			if (get_integer(&medium_id, *argv, 0)) {
+				invarg("Invalid \"medium_id\" value\n", *argv);
+				return -1;
+			}
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_MEDIUM_ID, medium_id);
+		} else if (matches(*argv, "disable_xfrm") == 0) {
+			int disable_xfrm;
+
+			NEXT_ARG();
+			disable_xfrm = parse_on_off("disable_xfrm", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_NOXFRM, disable_xfrm);
+		} else if (matches(*argv, "disable_policy") == 0) {
+			int disable_policy;
+
+			NEXT_ARG();
+			disable_policy = parse_on_off("disable_policy", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_NOPOLICY, disable_policy);
+		} else if (matches(*argv, "force_igmp_version") == 0) {
+			int force_igmp_version;
+
+			NEXT_ARG();
+			if (get_integer(&force_igmp_version, *argv, 0)) {
+				invarg("Invalid \"force_igmp_version\" value\n", *argv);
+				return -1;
+			}
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_FORCE_IGMP_VERSION, force_igmp_version);
+		} else if (matches(*argv, "arp_announce") == 0) {
+			int arp_announce;
+
+			NEXT_ARG();
+			if (get_integer(&arp_announce, *argv, 0)) {
+				invarg("Invalid \"arp_announce\" value\n", *argv);
+				return -1;
+			}
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_ARP_ANNOUNCE, arp_announce);
+		} else if (matches(*argv, "arp_ignore") == 0) {
+			int arp_ignore;
+
+			NEXT_ARG();
+			if (get_integer(&arp_ignore, *argv, 0)) {
+				invarg("Invalid \"arp_ignore\" value\n", *argv);
+				return -1;
+			}
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_ARP_IGNORE, arp_ignore);
+		} else if (matches(*argv, "promote_secondaries") == 0) {
+			int promote_secondaries;
+
+			NEXT_ARG();
+			promote_secondaries = parse_on_off("promote_secondaries", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_PROMOTE_SECONDARIES, promote_secondaries);
+		} else if (matches(*argv, "arp_accept") == 0) {
+			int arp_accept;
+
+			NEXT_ARG();
+			if (get_integer(&arp_accept, *argv, 0)) {
+				invarg("Invalid \"arp_accept\" value\n", *argv);
+				return -1;
+			}
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_ARP_ACCEPT, arp_accept);
+		} else if (matches(*argv, "arp_notify") == 0) {
+			int arp_notify;
+
+			NEXT_ARG();
+			arp_notify = parse_on_off("arp_notify", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_ARP_NOTIFY, arp_notify);
+		} else if (matches(*argv, "accept_local") == 0) {
+			int accept_local;
+
+			NEXT_ARG();
+			accept_local = parse_on_off("accept_local", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_ACCEPT_LOCAL, accept_local);
+		} else if (matches(*argv, "src_vmark") == 0) {
+			int src_vmark;
+
+			NEXT_ARG();
+			src_vmark = parse_on_off("src_vmark", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_SRC_VMARK, src_vmark);
+		} else if (matches(*argv, "proxy_arp_pvlan") == 0) {
+			int proxy_arp_pvlan;
+
+			NEXT_ARG();
+			proxy_arp_pvlan = parse_on_off("proxy_arp_pvlan", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_PROXY_ARP_PVLAN, proxy_arp_pvlan);
+		} else if (matches(*argv, "route_localnet") == 0) {
+			int route_localnet;
+
+			NEXT_ARG();
+			route_localnet = parse_on_off("route_localnet", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_ROUTE_LOCALNET, route_localnet);
+		} else if (matches(*argv, "bc_forwarding") == 0) {
+			int bc_forwarding;
+
+			NEXT_ARG();
+			bc_forwarding = parse_on_off("bc_forwarding", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_BC_FORWARDING, bc_forwarding);
+		} else if (matches(*argv, "igmpv2_unsolicited_report_interval") == 0) {
+			int igmpv2_interval;
+
+			NEXT_ARG();
+			if (get_integer(&igmpv2_interval, *argv, 0)) {
+				invarg("Invalid \"igmpv2_unsolicited_report_interval\" value\n",
+				       *argv);
+				return -1;
+			}
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL, igmpv2_interval);
+		} else if (matches(*argv, "igmpv3_unsolicited_report_interval") == 0) {
+			int igmpv3_interval;
+
+			NEXT_ARG();
+			if (get_integer(&igmpv3_interval, *argv, 0)) {
+				invarg("Invalid \"igmpv3_unsolicited_report_interval\" value\n",
+				       *argv);
+				return -1;
+			}
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL, igmpv3_interval);
+		} else if (matches(*argv, "ignore_routes_with_linkdown") == 0) {
+			int ignore_routes_linkdown;
+
+			NEXT_ARG();
+			ignore_routes_linkdown = parse_on_off("ignore_routes_with_linkdown",
+							      *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN, ignore_routes_linkdown);
+		} else if (matches(*argv, "drop_unicast_in_l2_multicast") == 0) {
+			int drop_unicast_mcast;
+
+			NEXT_ARG();
+			drop_unicast_mcast = parse_on_off("drop_unicast_in_l2_multicast",
+							  *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST, drop_unicast_mcast);
+		} else if (matches(*argv, "drop_gratuitous_arp") == 0) {
+			int drop_gratuitous_arp;
+
+			NEXT_ARG();
+			drop_gratuitous_arp = parse_on_off("drop_gratuitous_arp", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_DROP_GRATUITOUS_ARP, drop_gratuitous_arp);
+		} else if (matches(*argv, "arp_evict_nocarrier") == 0) {
+			int arp_evict_nocarrier;
+
+			NEXT_ARG();
+			arp_evict_nocarrier = parse_on_off("arp_evict_nocarrier", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr32(&req->n, sizeof(*req),
+				  IPV4_DEVCONF_ARP_EVICT_NOCARRIER, arp_evict_nocarrier);
+		} else {
+			/* rewind arg */
+			PREV_ARG();
+			break;
+		}
+	}
+
+	if (argc == *argcp)
+		incomplete_command();
+
+	addattr_nest_end(&req->n, inet_devconf);
+	addattr_nest_end(&req->n, afinet);
+	addattr_nest_end(&req->n, afs);
+
+	*argcp = argc;
+	*argvp = argv;
+	return 0;
+}
+
 int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 {
 	bool move_netns = false;
@@ -634,6 +985,9 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			if (get_integer(&mtu, *argv, 0))
 				invarg("Invalid \"mtu\" value\n", *argv);
 			addattr_l(&req->n, sizeof(*req), IFLA_MTU, &mtu, 4);
+		} else if (strcmp(*argv, "inet") == 0) {
+			if (iplink_parse_inet(&argc, &argv, req) < 0)
+				return -1;
 		} else if (strcmp(*argv, "xdpgeneric") == 0 ||
 			   strcmp(*argv, "xdpdrv") == 0 ||
 			   strcmp(*argv, "xdpoffload") == 0 ||
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index e89b2db3..a55b09fc 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -179,6 +179,43 @@ ip-link \- network device configuration
 .br
 .RB "[ " addrgenmode " { " eui64 " | " none " | " stable_secret " | " random " } ]"
 .br
+.RB "[ " inet " [ { " forwarding " | " proxy_arp " | " accept_redirects " |"
+.br
+.in +8
+.BR secure_redirects " | " send_redirects " | " shared_media " |"
+.br
+.BR accept_source_route " | " bootp_relay " | " log_martians " |"
+.br
+.BR arp_filter " | " disable_xfrm " | " disable_policy " |"
+.br
+.BR promote_secondaries " | " arp_notify " | " accept_local " |"
+.br
+.BR src_vmark " | " proxy_arp_pvlan " | " route_localnet " |"
+.br
+.BR bc_forwarding " | " ignore_routes_with_linkdown " |"
+.br
+.BR drop_unicast_in_l2_multicast " |"
+.br
+.BR drop_gratuitous_arp " | " arp_evict_nocarrier " } { " on " | " off " } ]"
+.br
+.RB "[ " rp_filter " { " 0 " | " 1 " | " 2 " } ]"
+.br
+.RB "[ " arp_announce " { " 0 " | " 1 " | " 2 " } ]"
+.br
+.RB "[ " arp_ignore " { " 0 " | " 1 " | " ... " | " 8 " } ]"
+.br
+.RB "[ " arp_accept " { " 0 " | " 1 " | " 2 " } ]"
+.br
+.RB "[ " force_igmp_version " { " 0 " | " 1 " | " 2 " | " 3 " } ]"
+.br
+.RB "[ " tag " " TAG " ] [ " medium_id " " ID " ]"
+.br
+.RB "[ " igmpv2_unsolicited_report_interval " " INTERVAL " ]"
+.br
+.RB "[ " igmpv3_unsolicited_report_interval " " INTERVAL " ] ]"
+.br
+.in -10
+.br
 .RB "[ " macaddr
 .RI "[ " MACADDR " ]"
 .br
@@ -2617,6 +2654,50 @@ set the IPv6 address generation mode
 .I random
 - like stable_secret, but auto-generate a new random secret if none is set
 
+.TP
+.B inet
+set the IPv4 devconf network parameters for the specific device. These parameters map directly to the kernel's IPv4 interface sysctls.
+
+.in +8
+.BR forwarding " { " on " | " off " }"
+- enable or disable IPv4 forwarding on the device.
+
+.BR proxy_arp ", " accept_redirects ", " secure_redirects ", " send_redirects ", "
+.BR shared_media ", " accept_source_route ", " bootp_relay ", " log_martians ", "
+.BR arp_filter ", " disable_xfrm ", " disable_policy ", " promote_secondaries ", "
+.BR arp_notify ", " accept_local ", " src_vmark ", " proxy_arp_pvlan ", "
+.BR route_localnet ", " bc_forwarding ", " ignore_routes_with_linkdown ", "
+.BR drop_unicast_in_l2_multicast ", " drop_gratuitous_arp ", " arp_evict_nocarrier ", "
+.BR "{ " on " | " off " }"
+- toggle the corresponding boolean network parameter.
+
+.BR rp_filter " { " 0 " | " 1 " | " 2 " }"
+- set reverse path filtering.
+
+.BR arp_announce " { " 0 " | " 1 " | " 2 " }"
+- define different restriction levels for announcing the local source IP address from IP packets in ARP requests.
+
+.BR arp_ignore " { " 0 " | " 1 " | " ... " | " 8 " }"
+- define different modes for replying to ARP requests that resolve local target IP addresses.
+
+.BR arp_accept " { " 0 " | " 1 " | " 2 " }"
+- define behavior for gratuitous ARP frames.
+
+.BR force_igmp_version " { " 0 " | " 1 " | " 2 " | " 3 " }"
+- force IGMP version.
+
+.BI tag " TAG "
+- set the interface tag.
+
+.BI medium_id " ID "
+- set the interface medium ID.
+
+.BI igmpv2_unsolicited_report_interval " INTERVAL "
+.br
+.BI igmpv3_unsolicited_report_interval " INTERVAL "
+- set the IGMP unsolicited report interval in milliseconds.
+.in -8
+
 .TP
 .BR "link-netnsid "
 set peer netnsid for a cross-netns interface
-- 
2.54.0



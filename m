Return-Path: <netdev+bounces-262643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHOYBc+JpWmWDQYAu9opvQ
	(envelope-from <netdev+bounces-262643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:59:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 835861D9560
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F88630CFC19
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC2C3B3C08;
	Mon,  2 Mar 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZTNXiZvr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Uy7Z53B7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S/Eydo6r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w9/VP/hN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94383B3C1B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456011; cv=none; b=US7uijujs9n3s7QUReFKRhwg9KRbVWCZLGufJ4Aly+qrG/vRoqrMSdMq95kDfqt2zDmTC2xiRkZ/OjpJgL9FlZHdGc/UmZ3GSqWgNBIeuvzo8FpoQZheP3SaYFgIDYHGBuRuJCgdIZ09g2F+weSbSgshcibTq1jh/xYWy/CqyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456011; c=relaxed/simple;
	bh=ohdjKdnP8ZPXMj1YCkAVhnMHLe7CBhSYrH7faW7VhfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYgJAvKVfJZjwjUF9AzB2XdCc/s+J+drHGCw84imaJCHGR+kIspXrpleKagPSjL5KwQG2J57K+p0NTd908UmlFNVyT+7/MwhYuB8mLQNM9YGJt8FwhB2SeNSivaY0dg9geeUqLbRsTbG/XaJTtpH4UaU5aRVeeCEXrBw9i/NoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZTNXiZvr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Uy7Z53B7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S/Eydo6r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w9/VP/hN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E463D3E73E;
	Mon,  2 Mar 2026 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772456008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=P8wHGO3yDRyEUo1v/L1ei4WWHMaS2fiKVZ2XR7Sghoo=;
	b=ZTNXiZvrWJgtiHsRl4m24DCiz6GfFzacXytkpOUOOPtdqNcoMHDfg3SOfjKMCyt7Jlw0YT
	JxUrI2dOvvWTIkNrzVNSa0HCaZNBwK9kytQJuuhEDJHQ3WAe7qIzbI71NZZHI4QtT/d042
	C8VqpPiiDmNRJepVUQQ1vJJ0c6AMCGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772456008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=P8wHGO3yDRyEUo1v/L1ei4WWHMaS2fiKVZ2XR7Sghoo=;
	b=Uy7Z53B7IWEbVQGfcYxj5I0y/igiP/8TsjIcz+cBPGasVJNf4Z0D38p/2zALJ0HJ6cn4oG
	3eV5Z2FdNs36fRBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="S/Eydo6r";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="w9/VP/hN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772456007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=P8wHGO3yDRyEUo1v/L1ei4WWHMaS2fiKVZ2XR7Sghoo=;
	b=S/Eydo6rDdg5CPO0lejPV6QPoQwpoxk8HV/82ggSUfUImowmFa68vCaAkr5KtirH03/CcV
	vYgu14s8Axir2sIS2kQfmXGxcI/At6Q1rJb+NrsExj7zbnqAQQv1rdElEGwmbP0mSvJd3K
	uA/ywMGNARgimEid6x/E7LpC3BUlsUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772456007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=P8wHGO3yDRyEUo1v/L1ei4WWHMaS2fiKVZ2XR7Sghoo=;
	b=w9/VP/hNWd9ocqfQ5geuT28oexUQb6WH7SPZ78Bsd/2aIo+ZBHaLKWfZYvGROWG/R+JJ6f
	hpIrWMwK9iwo2uBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E63793EA69;
	Mon,  2 Mar 2026 12:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9JAkNUaIpWlFUgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 02 Mar 2026 12:53:26 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chia-yu.chang@nokia-bell-labs.com,
	idosch@nvidia.com,
	willemb@google.com,
	dsahern@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next v2] inet: add ip_local_port_step_width sysctl to improve port usage distribution
Date: Mon,  2 Mar 2026 13:53:03 +0100
Message-ID: <20260302125303.4553-1-fmancera@suse.de>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262643-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,0xffsoftware.com:url]
X-Rspamd-Queue-Id: 835861D9560
X-Rspamd-Action: no action

With the current port selection algorithm, ports after a reserved port
range or long time used port are used more often than others [1]. This
causes an uneven port usage distribution. This combines with cloud
environments blocking connections between the application server and the
database server if there was a previous connection with the same source
port, leading to connectivity problems between applications on cloud
environments.

The real issue here is that these firewalls cannot cope with
standards-compliant port reuse. This is a workaround for such situations
and an improvement on the distribution of ports selected.

The proposed solution is to implement a variant of RFC 6056 Algorithm 5.
The step size is selected randomly on every connect() call ensuring it
is a coprime with respect to the size of the range of ports we want to
scan. This way, we can ensure that all ports within the range are
scanned before returning an error. To enable this algorithm, the user
must configure the new sysctl option "net.ipv4.ip_local_port_step_width".

In addition, on graphs generated we can observe that the distribution of
source ports is more even with the proposed approach. [2]

[1] https://0xffsoftware.com/port_graph_current_alg.html

[2] https://0xffsoftware.com/port_graph_random_step_alg.html

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: used step to calculate remaining as (remaining / step) and avoid
calculating gcd when scan_step and range are both even
---
 Documentation/networking/ip-sysctl.rst        |  9 +++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
 include/net/netns/ipv4.h                      |  1 +
 net/ipv4/inet_hashtables.c                    | 25 ++++++++++++++++---
 net/ipv4/sysctl_net_ipv4.c                    |  7 ++++++
 5 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 265158534cda..da29806700e9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1630,6 +1630,15 @@ ip_local_reserved_ports - list of comma separated ranges
 
 	Default: Empty
 
+ip_local_port_step_width - INTEGER
+        Defines the numerical maximum increment between successive port
+        allocations within the ephemeral port range when an unavailable port is
+        reached. This can be used to mitigate accumulated nodes in port
+        distribution when reserved ports have been configured. Please note that
+        port collisions may be more frequent in a system with a very high load.
+
+        Default: 0 (disabled)
+
 ip_unprivileged_port_start - INTEGER
 	This is a per-namespace sysctl.  It defines the first
 	unprivileged port in the network namespace.  Privileged ports
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index beaf1880a19b..c0e194a6e4ee 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -47,6 +47,7 @@ u8                              sysctl_tcp_ecn
 u8                              sysctl_tcp_ecn_fallback
 u8                              sysctl_ip_default_ttl                                                                ip4_dst_hoplimit/ip_select_ttl
 u8                              sysctl_ip_no_pmtu_disc
+u32                             sysctl_ip_local_port_step_width
 u8                              sysctl_ip_fwd_use_pmtu                       read_mostly                             ip_dst_mtu_maybe_forward/ip_skb_dst_mtu
 u8                              sysctl_ip_fwd_update_priority                                                        ip_forward
 u8                              sysctl_ip_nonlocal_bind
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 8e971c7bf164..fb7c2235af21 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -166,6 +166,7 @@ struct netns_ipv4 {
 	u8 sysctl_ip_autobind_reuse;
 	/* Shall we try to damage output packets if routing dev changes? */
 	u8 sysctl_ip_dynaddr;
+	u32 sysctl_ip_local_port_step_width;
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	u8 sysctl_raw_l3mdev_accept;
 #endif
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index fca980772c81..27f29a9376ad 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/gcd.h>
 
 #include <net/addrconf.h>
 #include <net/inet_connection_sock.h>
@@ -1046,12 +1047,12 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	struct net *net = sock_net(sk);
 	struct inet_bind2_bucket *tb2;
 	struct inet_bind_bucket *tb;
+	int step, scan_step, l3mdev;
+	u32 index, max_rand_step;
 	bool tb_created = false;
 	u32 remaining, offset;
 	int ret, i, low, high;
 	bool local_ports;
-	int step, l3mdev;
-	u32 index;
 
 	if (port) {
 		local_bh_disable();
@@ -1065,6 +1066,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	local_ports = inet_sk_get_local_port_range(sk, &low, &high);
 	step = local_ports ? 1 : 2;
+	scan_step = step;
+	max_rand_step = READ_ONCE(net->ipv4.sysctl_ip_local_port_step_width);
 
 	high++; /* [32768, 60999] -> [32768, 61000[ */
 	remaining = high - low;
@@ -1083,9 +1086,25 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	 */
 	if (!local_ports)
 		offset &= ~1U;
+
+	if (max_rand_step && remaining > 1) {
+		u32 range = remaining / step;
+		u32 upper_bound = min(range, max_rand_step);
+
+		scan_step = get_random_u32_inclusive(1, upper_bound);
+		while (gcd(scan_step, range) != 1) {
+			scan_step++;
+			/* if both scan_step and range are even gcd won't be 1 */
+			if (!(scan_step & 1) && !(range & 1))
+				scan_step++;
+			if (unlikely(scan_step > upper_bound))
+				scan_step = 1;
+		}
+		scan_step *= step;
+	}
 other_parity_scan:
 	port = low + offset;
-	for (i = 0; i < remaining; i += step, port += step) {
+	for (i = 0; i < remaining; i += step, port += scan_step) {
 		if (unlikely(port >= high))
 			port -= remaining;
 		if (inet_is_local_reserved_port(net, port))
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 643763bc2142..c533374f656c 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -822,6 +822,13 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= ipv4_local_port_range,
 	},
+	{
+		.procname	= "ip_local_port_step_width",
+		.maxlen		= sizeof(u32),
+		.data		= &init_net.ipv4.sysctl_ip_local_port_step_width,
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec,
+	},
 	{
 		.procname	= "ip_local_reserved_ports",
 		.data		= &init_net.ipv4.sysctl_local_reserved_ports,
-- 
2.53.0



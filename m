Return-Path: <netdev+bounces-291209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKL/A24kE2oA8QYAu9opvQ
	(envelope-from <netdev+bounces-291209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:16:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 827AE5C3119
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35F123035D5F
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388F83AB267;
	Sun, 24 May 2026 16:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A103A9DA1
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639155; cv=none; b=TqZUC01JaToKtJi5Rljx7Bw5fjwd5AsNxVGZmlRl45srEJa0zMQXCuYYoBdyHvSikHcgqbCZ5nZ/U9TFTV7QhFsZJUqBmk1uYUZwzAPfPJNUfM8276OSjjWY+iaKDHZErFx4FBNN6earXKA5eHqaDjjudjC5kwL7yXfsHs/QwcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639155; c=relaxed/simple;
	bh=zPKT572Bg5B8ekJ3ya3g1bUmfBOQNpVNHzCjPrnHSPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kweF/WTEsWRjLHicYIV2r8hLUzNJQkwRy9H839dKO45Ip9SPbUlTN5kCy8e7dM91yvbM1GHlWRBHuJ6T6jjh+x3+JBq9/supqTTZpKweh4NztbZ+pR1fsOmRSYvJ1fnwC8GgrlqtW2dd+hHOhnoDq3vgbf0sO/ek4kYaXsFq0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43b7e186a0cso555312fac.0
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 09:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779639151; x=1780243951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EuoL79h2+LzWuVOrTETIcdrYDXVMqx2rDNgDGKX/rTs=;
        b=o940oqYdHHqi7kjBT9ZTBkoAMfnDmI/0bTWSj+iBu7EPE57xsJ6G7W6WDLY8pfsL3n
         yL+jS7yYUrmgluV3XYpZyn2x7UZBi8oo5E/BWDZkROykphOJtWQgvVSIZuxcXCqHziG8
         l4xYfZzm7Y+z2h5gtbBt+90dZfG8hv9uNqkoeAygYqAKtdaueHsvTazZ9vWZW6hQte+h
         8p27gNt+64eHbWgVGi1gG9pW4JmgJYGfH52ocgwkDOD7rseTaw+tAgn6zwQ55tEQRblS
         w6Ujr6Hp5QZIeOjBfjOPX9p4M8oK+DONXKF1Wu3ecAsEpZHmuSw0dn1wwHlmakv6HO4s
         Oi7Q==
X-Gm-Message-State: AOJu0Yy3IEz4NET0WGlLWcrD10kLwhhsmn9F6IAHijnspVKEkK2tnVVZ
	1mGXx4uGFeGIJb3Yx1NzyuhBO4t1QyiEIelzVdlXUVZxsZSZi+0xqVfl+ErhO/9h
X-Gm-Gg: Acq92OGRQ2KUbFzI4bN1iakc+zere1407RTJYriXS1+ubh6JPQOt5EyJ8aIGT9hzFvX
	Tcqbcn8yEZuWqHs9IcH5pdAUNPTsuXTghgUDx0Xl9NPpN30M6wI24htfDqyD73Hg4KvV9t0kgSj
	/cwM0W1o1YkMIBlQ8f9GJxzcqy4yTOnY7OALlYOI6OHqxNWKctmeQ4YTlBcNbAnh4H8JRk4BLNV
	aVxuKKXF25Vl6LxvJMxLIhRa+D0oKtNhg/5ae1YBc5FMFpY/nUo2IXEK6/TCfGQMYiuzWKKl5Td
	pWoJOYgq+r1PoWEQnOA6JXR1CsJmlVI28Z+PTgZJimjnWs76H4RkvWJxuoZWqHMqQ/3E64IVLEC
	MKNvuL3cfcAWlhpoWBDvzKnY7PmP/YoDxb6YGuTuzsJiVtzYx/uH3KqJgRHL8V112Np31rUuTXl
	6KLt4KwMKNKq7W
X-Received: by 2002:a05:6808:13c9:b0:482:c2f2:7bde with SMTP id 5614622812f47-48549d906demr7016668b6e.4.1779639151118;
        Sun, 24 May 2026 09:12:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b635e373fsm7697975fac.8.2026.05.24.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 09:12:30 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 09:12:23 -0700
Subject: [PATCH 7/9] netconsole: move local_port from struct netpoll to
 netconsole_target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-netconsole_move_more-v1-7-909d1ab398b4@debian.org>
References: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
In-Reply-To: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=6708; i=leitao@debian.org;
 h=from:subject:message-id; bh=zPKT572Bg5B8ekJ3ya3g1bUmfBOQNpVNHzCjPrnHSPc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEyNlEVGQaBxfbvha3NelN2OLsuODN17jS00q1
 jhZEfxB526JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMjZQAKCRA1o5Of/Hh3
 bQAqEACdMw+R2fweJxfJzJy07RAqLYMtv/6X5FU7FueWxUawwoh+mcIi+ypXls4lMp5OMW8AhTS
 80CxDKBJRxWvzL3Iam5w/NC97Ebg4xwWObtxvVd8a9E6PD5w0BdjAqkqw42Ndn6xOGDHyilope1
 +pPhudrUaZH+y+jhG2wXWYfz/gRQ0q0pN1WKVoB1SCO1JV+crPmSG83EPTktvNYBkJsc0GaQjKw
 WtFjYhgl3tg3rP03aAY/CN79ae9Sywuot1Rv+Mx+DPty4KxKuZLIuVk2c3JYUKZg+mQJ8ny7G1Q
 uZiQekIjq492iv+8J5GU8Xf2ybPfyPUY0Ds4MyQu4E97Nfgq+Sc34PfHakaMTIELkK6G8pY00vu
 Z/G76zP7DonNJtj0BEM9rRH7oGF1+kvJd3DqtQXaLNgsuOvF8MtctEgj60mYyVN5am0J6iwUW32
 muR8pHzW6nVLprynrJKKrsnkj4OHaf+P0dIVcPgno5+v/OkZzep706fjnZqxYGY1R9XFEs4zN8O
 8CcYO/HsTaHadJC4vibCkchWlqxmGr0nrH8B/SG8NN/FG+ehg/TtGI2BZ+F4Od/Z+r4j6DuhdD+
 /+ZoEv9hxbOJYL8d3Oy9Vvpgcl5UK2vi3seB4GIa5GUUv0j40tZNAcsA3JXpr/omRtLUsuDxVI5
 Bfws/zJYfvGErgw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291209-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.773];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 827AE5C3119
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The UDP source port used to build outgoing log packets is pure
netconsole configuration. net/core/netpoll.c never reads it, and
no other struct netpoll consumer (bonding, bridge, team, vlan,
macvlan, dsa) touches it either.

Add local_port to struct netconsole_target, drop it from struct
netpoll, and update alloc_and_init(), the local_port_show /
local_port_store configfs handlers, push_udp(),
netconsole_print_banner() and netconsole_parser_cmdline() to read
it from nt-> rather than np->.

netconsole_print_banner(), push_udp() and netconsole_parser_cmdline()
gain a struct netconsole_target * parameter so they can reach the
new home; subsequent patches that move remote_port and remote_mac
reuse the same plumbing.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 45 +++++++++++++++++++++++----------------------
 include/linux/netpoll.h  |  2 +-
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b8b1608d09e9..a4f34560cee5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -172,15 +172,11 @@ enum target_state {
  * @extended:	Denotes whether console is extended or not.
  * @release:	Denotes whether kernel release version should be prepended
  *		to the message. Depends on extended console.
- * @np:		The netpoll structure for this target.
- *		Contains the other userspace visible parameters:
- *		dev_name	(read-write)
- *		local_port	(read-write)
- *		remote_port	(read-write)
- *		local_ip	(read-write)
- *		remote_ip	(read-write)
- *		local_mac	(read-only)
- *		remote_mac	(read-write)
+ * @np:		The netpoll structure for this target. Holds the
+ *		underlying net_device handle and the addressing fields
+ *		that netpoll core still reads (local_ip, remote_ip, ipv6,
+ *		dev_name, dev_mac).
+ * @local_port:	UDP source port used to build outgoing log packets.
  * @buf:	The buffer used to send the full msg to the network stack
  * @resume_wq:	Workqueue to resume deactivated target
  * @skb_pool:	Per-target fallback skb pool consulted by find_skb() when
@@ -208,6 +204,7 @@ struct netconsole_target {
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
+	u16			local_port;
 	/* protected by target_list_lock */
 	char			buf[MAX_PRINT_CHUNK];
 	struct work_struct	resume_wq;
@@ -432,7 +429,7 @@ static struct netconsole_target *alloc_and_init(void)
 
 	nt->np.name = "netconsole";
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
-	nt->np.local_port = 6665;
+	nt->local_port = 6665;
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
 	nt->state = STATE_DISABLED;
@@ -471,9 +468,11 @@ static void netconsole_process_cleanups_core(void)
 	mutex_unlock(&target_cleanup_list_lock);
 }
 
-static void netconsole_print_banner(struct netpoll *np)
+static void netconsole_print_banner(struct netconsole_target *nt)
 {
-	np_info(np, "local port %d\n", np->local_port);
+	struct netpoll *np = &nt->np;
+
+	np_info(np, "local port %d\n", nt->local_port);
 	if (np->ipv6)
 		np_info(np, "local IPv6 address %pI6c\n", &np->local_ip.in6);
 	else
@@ -603,7 +602,7 @@ static ssize_t dev_name_show(struct config_item *item, char *buf)
 
 static ssize_t local_port_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", to_target(item)->np.local_port);
+	return sysfs_emit(buf, "%d\n", to_target(item)->local_port);
 }
 
 static ssize_t remote_port_show(struct config_item *item, char *buf)
@@ -798,7 +797,7 @@ static ssize_t enabled_store(struct config_item *item,
 		 * Skip netconsole_parser_cmdline() -- all the attributes are
 		 * already configured via configfs. Just print them out.
 		 */
-		netconsole_print_banner(&nt->np);
+		netconsole_print_banner(nt);
 
 		/* Initialise the skb pool before netpoll_setup() so the pool
 		 * is valid as soon as nt->np.dev becomes visible to
@@ -937,7 +936,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	ret = kstrtou16(buf, 10, &nt->np.local_port);
+	ret = kstrtou16(buf, 10, &nt->local_port);
 	if (ret < 0)
 		goto out_unlock;
 	ret = count;
@@ -1788,8 +1787,9 @@ static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
 		udph->check = CSUM_MANGLED_0;
 }
 
-static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
+static void push_udp(struct netconsole_target *nt, struct sk_buff *skb, int len)
 {
+	struct netpoll *np = &nt->np;
 	struct udphdr *udph;
 	int udp_len;
 
@@ -1799,7 +1799,7 @@ static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 	skb_reset_transport_header(skb);
 
 	udph = udp_hdr(skb);
-	udph->source = htons(np->local_port);
+	udph->source = htons(nt->local_port);
 	udph->dest = htons(np->remote_port);
 	udph->len = htons(udp_len);
 
@@ -1896,7 +1896,7 @@ static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
 	skb_copy_to_linear_data(skb, msg, len);
 	skb_put(skb, len);
 
-	push_udp(np, skb, len);
+	push_udp(nt, skb, len);
 	if (np->ipv6)
 		push_ipv6(np, skb, len);
 	else
@@ -2214,8 +2214,9 @@ __releases(&target_list_lock)
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
-static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
+static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 {
+	struct netpoll *np = &nt->np;
 	bool ipversion_set = false;
 	char *cur = opt;
 	char *delim;
@@ -2226,7 +2227,7 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 		if (!delim)
 			goto parse_failed;
 		*delim = 0;
-		if (kstrtou16(cur, 10, &np->local_port))
+		if (kstrtou16(cur, 10, &nt->local_port))
 			goto parse_failed;
 		cur = delim;
 	}
@@ -2299,7 +2300,7 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 			goto parse_failed;
 	}
 
-	netconsole_print_banner(np);
+	netconsole_print_banner(nt);
 
 	return 0;
 
@@ -2337,7 +2338,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	}
 
 	/* Parse parameters and setup netpoll */
-	err = netconsole_parser_cmdline(&nt->np, target_config);
+	err = netconsole_parser_cmdline(nt, target_config);
 	if (err)
 		goto fail;
 
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 8344454df05d..dcea36713720 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -33,7 +33,7 @@ struct netpoll {
 
 	union inet_addr local_ip, remote_ip;
 	bool ipv6;
-	u16 local_port, remote_port;
+	u16 remote_port;
 	u8 remote_mac[ETH_ALEN];
 };
 

-- 
2.54.0



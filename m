Return-Path: <netdev+bounces-306537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O7oNEkPeUGpS6gIAu9opvQ
	(envelope-from <netdev+bounces-306537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:57:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 010EB73A785
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:57:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=IjGKdqlL;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306537-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306537-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D68F8304220A
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475FE41611E;
	Fri, 10 Jul 2026 11:55:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97754423A87;
	Fri, 10 Jul 2026 11:54:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684507; cv=none; b=mfzeS2bce8cxeAuNnBsIH8019zoQyarW6hWLKj6vwqCB04dOOf9opCUbFAgS0ufmnQKHEoYN1KeJpTJvEnBRsXOHK+f2VFRp3WUjjlPS6um/xks000xQ72FBiZuR+QS0RvquxEq/Px3S93BOuiLS4YcVfut4AwIBAH2z7+FRc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684507; c=relaxed/simple;
	bh=E5Uuzy66c/XxxYyuV5fNIICuWCNoal1F8sjYMId5w8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUwIl3kwHuTVkw6i9fFNFC6kMJYw5QXxgzk6W+eiE5r73ee14SFCEx69EeU3chkVrcTR2OGOVerO69q63Fto3rUVApbywNRQLPNlFNFVSGcOPA2Pf16doeIRjfflwrWdh5LbpE99BojhA007Qr+vk7LMeMnU6/H6222EaQnK+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IjGKdqlL; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=S+TpG0rNAE1sZNwsOErTcUgZBEXxg+Ruc3JdPKcoyPw=; b=IjGKdqlLmjHPzVRPyL9o+7zsMt
	Qk77ykSUHDzwufP5tGZ6k3/km49Tea0uRcaRywZH7rL1ScnrFmlQ3IvA3VPV7fVBx/YdxRhTKWdaF
	6g/S+Fbk8xz/0L/pydNq0Z71Wh+x/+pDMB9BqFQkgkMmRP/QDKsm47mqdgwl4BKDZ4bNfBvzY8zkF
	sHm30bOFzWIzNXOEULmOKBEG74XkzjwrM3wCb9acqq4vfFNSem5x1jZ7+TLjrZ+8/aPRjwYxA7VAs
	kzH782xQpSvRe0wJucn/hvZSKZEBCeK+7C3cDcEwmKKKCL7xemOvPyug+2JKx+/Mh51lk/Ifr4San
	kT+LYREw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi9oj-004SZq-17;
	Fri, 10 Jul 2026 11:54:53 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Jul 2026 04:39:01 -0700
Subject: [PATCH net-next v3 9/9] netconsole: move remote_mac from struct
 netpoll to netconsole_target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-netconsole_move_more-v3-9-6f63f76b28bc@debian.org>
References: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
In-Reply-To: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4885; i=leitao@debian.org;
 h=from:subject:message-id; bh=E5Uuzy66c/XxxYyuV5fNIICuWCNoal1F8sjYMId5w8I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqUN1kdM6FUNFQORkoIdqo+Dm7iW8Od1vrcvCjq
 Ow9MGIhVqOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalDdZAAKCRA1o5Of/Hh3
 bR8WEACANFNG+dTXMlruSIwZlXyiwvtsYNal8SLKQ034uAOvQ6kIDrCBW+pB5VgUn5wkIKboJq0
 1K2TVVapgqxOZlc8NByaKHfJ0X8Q8gbhprpK8QOtj5CXXeHv2BrLkeZf9pNw57OYvTp+ckhBcSa
 7vJhbRekPFZuPuZUjIRYOeU3pquEHL0Lo/LNOTuVFaZij5eLO+VGtxkRdpn4rTQxgMZzdAMGiRY
 T99Sk1Ke9XeFVLV8ZEOvOvSW3CzhOI4waAX8/wdkTDuk1nXavEnvYEAI+BZcZU4Ss5pylJOoB6L
 4JR+reJ31u2L/1cNMkrdxF+/3/Xxojrzl8mzRACZEw4MLWYm+IEY82vc70JJFAhvmRaEtr+el4b
 T3FlYT/tJmjdYtt3AxC5QiiKH4ljZ40+X9mrFxCAYihRzctq8UqqRJOOo9tGYf/QUpPJWGeFwwB
 zW2x4N7R9X30RON8konkpfK9UKjBQXCWkCKOWE+YNtbafSuxrSh3YUQpdFRwViGm3QBzZAVWihF
 v8FYSoBv6+yei3DV+efKbvvjjxVDM284q/qjz/NTwqDo8mrc8gNqREFnriiQ/OAEWInbnS+K+1z
 MWxp98plg/qKzvzPbsVKsFYZEWf/Il9uQ4zdWk6UAsnonONqoAM+Fdl9ibNXvYDxvqGd/zKPPkc
 oi509+6JQhLMhkw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306537-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 010EB73A785

The destination ethernet address is netconsole configuration: no other
netpoll user (bonding, team, vlan, bridge, macvlan, dsa) references
np->remote_mac, only netconsole's ethernet framing and its
configfs/cmdline interface do.

Move it into struct netconsole_target and convert push_eth() to take the
netconsole_target; netconsole_print_banner() and
netconsole_parser_cmdline() already take it. The configfs show/store
handlers and alloc_and_init() reach the field directly.

No functional change; the remote_mac sysfs attribute is unchanged.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 20 +++++++++++---------
 include/linux/netpoll.h  |  1 -
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d0739b45f66e1..49b2243a20b2d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -178,9 +178,9 @@ enum target_state {
  *		local_ip	(read-write)
  *		remote_ip	(read-write)
  *		local_mac	(read-only)
- *		remote_mac	(read-write)
  * @local_port:	Source UDP port of the target (read-write).
  * @remote_port: Destination UDP port of the target (read-write).
+ * @remote_mac:	Destination ethernet address of the target (read-write).
  * @buf:	The buffer used to send the full msg to the network stack
  * @resume_wq:	Workqueue to resume deactivated target
  * @skb_pool:	Per-target fallback skb pool consulted by find_skb() when
@@ -209,6 +209,7 @@ struct netconsole_target {
 	bool			release;
 	struct netpoll		np;
 	u16			local_port, remote_port;
+	u8			remote_mac[ETH_ALEN];
 	/* protected by target_list_lock; +1 gives scnprintf() room for its
 	 * NUL terminator so a full MAX_PRINT_CHUNK payload is not truncated
 	 */
@@ -462,7 +463,7 @@ static struct netconsole_target *alloc_and_init(void)
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
 	nt->local_port = 6665;
 	nt->remote_port = 6666;
-	eth_broadcast_addr(nt->np.remote_mac);
+	eth_broadcast_addr(nt->remote_mac);
 	nt->state = STATE_DISABLED;
 	INIT_WORK(&nt->resume_wq, process_resume_target);
 	/* Set up the skb pool primitives once; enabling only refills it. */
@@ -516,7 +517,7 @@ static void netconsole_print_banner(struct netconsole_target *nt)
 		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
 	else
 		np_info(np, "remote IPv4 address %pI4\n", &np->remote_ip.ip);
-	np_info(np, "remote ethernet address %pM\n", np->remote_mac);
+	np_info(np, "remote ethernet address %pM\n", nt->remote_mac);
 }
 
 /* Parse the string and populate the `inet_addr` union. Return 0 if IPv4 is
@@ -672,7 +673,7 @@ static ssize_t local_mac_show(struct config_item *item, char *buf)
 
 static ssize_t remote_mac_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%pM\n", to_target(item)->np.remote_mac);
+	return sysfs_emit(buf, "%pM\n", to_target(item)->remote_mac);
 }
 
 static ssize_t transmit_errors_show(struct config_item *item, char *buf)
@@ -1077,7 +1078,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	if (buf[MAC_ADDR_STR_LEN] && buf[MAC_ADDR_STR_LEN] != '\n')
 		goto out_unlock;
-	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
+	memcpy(nt->remote_mac, remote_mac, ETH_ALEN);
 
 	ret = count;
 out_unlock:
@@ -1885,14 +1886,15 @@ static void push_udp(struct netconsole_target *nt, struct sk_buff *skb, int len)
 	netpoll_udp_checksum(np, skb, len);
 }
 
-static void push_eth(struct netpoll *np, struct sk_buff *skb)
+static void push_eth(struct netconsole_target *nt, struct sk_buff *skb)
 {
+	struct netpoll *np = &nt->np;
 	struct ethhdr *eth;
 
 	eth = skb_push(skb, ETH_HLEN);
 	skb_reset_mac_header(skb);
 	ether_addr_copy(eth->h_source, np->dev->dev_addr);
-	ether_addr_copy(eth->h_dest, np->remote_mac);
+	ether_addr_copy(eth->h_dest, nt->remote_mac);
 	if (np->ipv6)
 		eth->h_proto = htons(ETH_P_IPV6);
 	else
@@ -1980,7 +1982,7 @@ static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
 		push_ipv6(np, skb, len);
 	else
 		push_ipv4(np, skb, len);
-	push_eth(np, skb);
+	push_eth(nt, skb);
 	skb->dev = np->dev;
 
 	return (int)netpoll_send_skb(np, skb);
@@ -2375,7 +2377,7 @@ static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 
 	if (*cur != 0) {
 		/* MAC address */
-		if (!mac_pton(cur, np->remote_mac))
+		if (!mac_pton(cur, nt->remote_mac))
 			goto parse_failed;
 	}
 
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 5ca79fa7d9431..79315461a7b1e 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -35,7 +35,6 @@ struct netpoll {
 
 	union inet_addr local_ip, remote_ip;
 	bool ipv6;
-	u8 remote_mac[ETH_ALEN];
 };
 
 #define np_info(np, fmt, ...)				\

-- 
2.53.0-Meta



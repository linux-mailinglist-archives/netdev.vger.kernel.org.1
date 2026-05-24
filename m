Return-Path: <netdev+bounces-291211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC9wLtokE2pB8QYAu9opvQ
	(envelope-from <netdev+bounces-291211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:18:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 553D95C3155
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37FE7304148B
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9F23AA9E8;
	Sun, 24 May 2026 16:12:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97173AA4F8
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639157; cv=none; b=Auvn/9fiGRnPyqsPcCU1QxGT3v1RbuN9OwPvgkHl1LFSCrgfsRwLsgY5cO5rkNE7FubfaiK0j645dXZakFSI21KDA8K9zBCITElf9U0rTYkkehowY49/a2xYs0SBPEtgzZyADRY6r0w4h5jfyQdXlU+wVA2UHMtrT6DOJ0tnebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639157; c=relaxed/simple;
	bh=9Sqs1TK1Ksxaf+/Hq1IN8xHVOCo2tM1wmJ3tA/Tq28g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfNa+fWWNckiy624ukknQtdK/6c9kBXGMOwT0+HHGqFVyF1y40CkXcmQfGFGQ/FEB4ufKBsBgKFfQUJU6W9CgZJARK5QEbYFN/DHd7TteM3gsX/4dCenmdQ6nkkB7NH3XiiI7/1YdcDYdccVZaZ+MOVEkUSkP0JTJUS5dGvy9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43b7987a9d1so1594925fac.1
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 09:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779639153; x=1780243953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jWUyH1vJgjwR/lyt/ttGR7R2TxtiIcscs9RO38w3oMY=;
        b=S83iDg6eaJziSX5xJVyIu8apCaWId5dHjmKdaRhLOpiYJ+lBH0r5edovWKxEfTUZbT
         VjbdBHTPyeZXdg4zCtiRUACgxb7YgfjZKWa2jN2RoK947Ai622VSZc+4KoKeksL1pFr5
         I4XoE+OxAAI9nfkSsF+Svj1W6whEgIUCknG//pvM+xKYdFRD8lOyRGgGrnKTKG6G9fdd
         SWcNqqcgt+y5DsWkZ43HQcf0O4XY0BDQ4Clzujd+HnW5Ko8EP1nTjBDfnQo5veSvThiq
         RIGh0XxsCGIgF7fO+YOoyR0CZE4ZzpNSIEQmOKeXUJ8qmP6tWCt366MAHlmkFn5pOOZN
         Egfw==
X-Gm-Message-State: AOJu0YwOuKm6NhxqJHADukYiRoqaDzrj3T0L/7MhPR8u7TwaLeawON2+
	TeDF9stQcCAIhPv01uu0pAZNI6MOpkP2SoEQQ7eloG/zvU3ufwj8oHqRHWAi8oL9
X-Gm-Gg: Acq92OGyf3jpdY3GXwCeV8BBCDNnbYkpRJYy+XyKs52j7yTmbrHGBBmO8NdBoXfIaTV
	I/zDrEMGT7fLsQzDdKMkA/UbZzKmv/J0gd0vwqSMw3T9S20Fbqlemfk8/UE9ihG40/aRW4zZHAR
	hogb9bTl0pxGL4Nk3/jN/9j1G5br2BJLuw/8X8UMpipAeHBMElNqVujD6IA6LviqON8p87zbYRB
	u+rqtNgdAdDccG1H6oLDoD35reqEvISvVVxB+yobKJvXmCxYJMXi/p8UgEugirHGsOAZUTK7bFE
	+bKcYdmDEsq9fhT8/ler/ZMw64c+IFaJ90FU50kY7ajPBBGlJQaJ6A+HtdQtKl6nUOe+qf0YRcM
	FzBvZ2tSrZQbIxlmJAyOWtUY9pir4P+fPIGl38Jj2aU6WiOf0s4sx5cjiGFmmTlUs5YaFyxlM1n
	jrqwQAuDEAh4L68A==
X-Received: by 2002:a05:6871:c3c1:b0:41c:6bf0:677c with SMTP id 586e51a60fabf-43b5abcf07emr6678996fac.2.1779639153283;
        Sun, 24 May 2026 09:12:33 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4f::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b635e4f8bsm7855506fac.7.2026.05.24.09.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 09:12:33 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 09:12:25 -0700
Subject: [PATCH 9/9] netconsole: move remote_mac from struct netpoll to
 netconsole_target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-netconsole_move_more-v1-9-909d1ab398b4@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5022; i=leitao@debian.org;
 h=from:subject:message-id; bh=9Sqs1TK1Ksxaf+/Hq1IN8xHVOCo2tM1wmJ3tA/Tq28g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEyNlTE/yd2VYLMfSLEN43Tx0EAsOC208ck36X
 exGS+lSfB+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMjZQAKCRA1o5Of/Hh3
 bQx1D/9NeadADcrmO21T0J7fjWBLaVM1LM+kejoae6Up5lNnywFC8cQJwSZOtjfcp4s9q2HEH+Q
 EU5WdEX5oRs52t+eqZe9vD7hnJmzsWOmEx4axIM4OHEMomdYLaNYnjEyIvbczRUyrFXwgTCri7k
 43S6L2GCd1ESG2hKdYP9SLQBJ2A6zoaEUwv07IF+0L6YPdqmlCaoiYju793somD4kG3cleyTWGz
 CU7Azw3acCj6V6UvOr+Wwltr7YOgn7zyO5gTu2c6KUYsU09kByrZn7eRiZvI9H16nqy9RAxJ4If
 yi+kms2zXi6nWTH5IUtA2FP1nUVrfvTcewqVNVQZNo64qVqzivltvdtRwEHbLfBl7j8g9Rwh3Zd
 tX3KtD6jq+AR6OlHTxQSwcKRZA1TOHZllhhjmR0kT/NuSUFL5SMB1yUd3nl6vXBpAfE2jJFt9jz
 kBjJ0gClNeUaJzU/UTkTNEslfsN3RdhZFsRdRflPKE8jXEFgMRkcn1xeuskCiUIOs0x7Yw6yi2E
 cyXBM+rg7sppTSDyzrnq4X54DKU8Z2SQ+n3ArUouQTFI13/NpOcgkZ4HhgcihaUeEoLNkFr6Qna
 34OifeydfhdbNQ2yiZsz/YUl2PLILA/ovvhsecjCDyyb2v4wRXu8W34OKfY0/ILjocUQHEH+za0
 zqMXaYzzvI7EgQQ==
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
	TAGGED_FROM(0.00)[bounces-291211-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.771];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 553D95C3155
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The destination ethernet address used to build outgoing log packets
is pure netconsole configuration. net/core/netpoll.c never reads
it, and no other struct netpoll consumer touches it.

Add remote_mac to struct netconsole_target, drop it from struct
netpoll, and update alloc_and_init(), the remote_mac_show /
remote_mac_store configfs handlers, push_eth(),
netconsole_print_banner() and netconsole_parser_cmdline() to read
it from nt-> rather than np->. push_eth() gains a struct
netconsole_target * parameter to reach the new home; its only
caller in netpoll_send_udp() already has nt available.

After this patch struct netpoll keeps only what genuinely belongs
to the generic poll/transmit abstraction (dev, dev_tracker,
dev_name, dev_mac, name) plus the IP addressing fields that
netpoll_setup() and netpoll_take_ipv6() still read themselves
(local_ip, remote_ip, ipv6).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 19 +++++++++++--------
 include/linux/netpoll.h  |  1 -
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 32e2a925f915..29a6c13e9cfd 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -178,6 +178,7 @@ enum target_state {
  *		dev_name, dev_mac).
  * @local_port:	UDP source port used to build outgoing log packets.
  * @remote_port:	UDP destination port used to build outgoing log packets.
+ * @remote_mac:	Destination ethernet address used to build outgoing log packets.
  * @buf:	The buffer used to send the full msg to the network stack
  * @resume_wq:	Workqueue to resume deactivated target
  * @skb_pool:	Per-target fallback skb pool consulted by find_skb() when
@@ -207,6 +208,7 @@ struct netconsole_target {
 	struct netpoll		np;
 	u16			local_port;
 	u16			remote_port;
+	u8			remote_mac[ETH_ALEN];
 	/* protected by target_list_lock */
 	char			buf[MAX_PRINT_CHUNK];
 	struct work_struct	resume_wq;
@@ -433,7 +435,7 @@ static struct netconsole_target *alloc_and_init(void)
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
 	nt->local_port = 6665;
 	nt->remote_port = 6666;
-	eth_broadcast_addr(nt->np.remote_mac);
+	eth_broadcast_addr(nt->remote_mac);
 	nt->state = STATE_DISABLED;
 	INIT_WORK(&nt->resume_wq, process_resume_target);
 
@@ -486,7 +488,7 @@ static void netconsole_print_banner(struct netconsole_target *nt)
 		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
 	else
 		np_info(np, "remote IPv4 address %pI4\n", &np->remote_ip.ip);
-	np_info(np, "remote ethernet address %pM\n", np->remote_mac);
+	np_info(np, "remote ethernet address %pM\n", nt->remote_mac);
 }
 
 /* Parse the string and populate the `inet_addr` union. Return 0 if IPv4 is
@@ -642,7 +644,7 @@ static ssize_t local_mac_show(struct config_item *item, char *buf)
 
 static ssize_t remote_mac_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%pM\n", to_target(item)->np.remote_mac);
+	return sysfs_emit(buf, "%pM\n", to_target(item)->remote_mac);
 }
 
 static ssize_t transmit_errors_show(struct config_item *item, char *buf)
@@ -1047,7 +1049,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	if (buf[MAC_ADDR_STR_LEN] && buf[MAC_ADDR_STR_LEN] != '\n')
 		goto out_unlock;
-	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
+	memcpy(nt->remote_mac, remote_mac, ETH_ALEN);
 
 	ret = count;
 out_unlock:
@@ -1808,14 +1810,15 @@ static void push_udp(struct netconsole_target *nt, struct sk_buff *skb, int len)
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
@@ -1903,7 +1906,7 @@ static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
 		push_ipv6(np, skb, len);
 	else
 		push_ipv4(np, skb, len);
-	push_eth(np, skb);
+	push_eth(nt, skb);
 	skb->dev = np->dev;
 
 	return (int)netpoll_send_skb(np, skb);
@@ -2298,7 +2301,7 @@ static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 
 	if (*cur != 0) {
 		/* MAC address */
-		if (!mac_pton(cur, np->remote_mac))
+		if (!mac_pton(cur, nt->remote_mac))
 			goto parse_failed;
 	}
 
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 12467a45929e..9f4236557ffe 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -33,7 +33,6 @@ struct netpoll {
 
 	union inet_addr local_ip, remote_ip;
 	bool ipv6;
-	u8 remote_mac[ETH_ALEN];
 };
 
 #define np_info(np, fmt, ...)				\

-- 
2.54.0



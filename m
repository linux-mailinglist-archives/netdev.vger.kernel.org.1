Return-Path: <netdev+bounces-304175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s04/FAdZRmpFRQsAu9opvQ
	(envelope-from <netdev+bounces-304175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:26:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B13DD6F78CE
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:26:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=aU9uupa4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304175-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304175-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2844D30E6E70
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 12:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712148AE1B;
	Thu,  2 Jul 2026 12:21:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EDA480350;
	Thu,  2 Jul 2026 12:21:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994863; cv=none; b=QcM4h65A2wTC4SFT2gdEhGFjL1aKJDPNBOW27ZnsAyFDvxXaNk+qkIRUS5Py+Xtwf39E/+9lyG5PgmasT0hGjavbdt9TfGI+KUD47Ioyx2XTHexuLIGBmFK9M3QY0IE1zwVCqmk5zrzb+nQgPOEh69qCsBDBskM35TXCOTdytgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994863; c=relaxed/simple;
	bh=dis3GNvaesC6mmQi7Cd66hmcuL8tEn43sL7izalFI8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ycmn8hc/6MVICwj8ob+aHei+meIMjkSlQB7ILfRfbrEaVzjmqYI1wMjiOdE2fl7K9N+0+kdU918Wx04vQ6CnYIZ32GE2EJzTPMpTYIRCQs0zqiCh0CTkTI8y0VorpjwDTgKCrjjWUm9H+B+wJuLzd2uDI0Gkpj6hPZz6EXaz9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=aU9uupa4; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=p9sDaI8UFgT8Xj6eoOI8Spx5P1KUHvPktOGLhNV1wUw=; b=aU9uupa4JS9lgrgYrI2kl9C1BF
	bUtXmgLVehJvqM+kGd0pfw1ZF126Xf/0EZYO+LJ/qT5PpFKe1Ph86OR0vCsbTuStpraO1DTw35iQC
	+ZHHsRhQTctyhoqAimkAsnqfZudsrW2KhSMmPqMerJy303HrVOO0iBmdYMUs7PulDhGrkR+RyPyID
	7qe8XznMHsqxwf2gad5G2XIDjEQ1Hc8WLRKZ7JFuKy213sDn7V1/YNaZ/gp4JHwBflozH4LhOYwgu
	pKOoa1vbLtpLj+Oz1l2LIYgwqOa6Z3HLBEYHA6tNkpEObdLnF7jTfuRaKgnI2h3+jToAs4Nf4RjUb
	CS7QzHeQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfGPa-008cRh-13;
	Thu, 02 Jul 2026 12:20:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Jul 2026 05:19:52 -0700
Subject: [PATCH net-next v2 8/8] netconsole: move remote_mac from struct
 netpoll to netconsole_target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-netconsole_move_more-v2-8-1ebedd921dcb@debian.org>
References: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
In-Reply-To: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4816; i=leitao@debian.org;
 h=from:subject:message-id; bh=dis3GNvaesC6mmQi7Cd66hmcuL8tEn43sL7izalFI8U=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqRleFWwNDD+l9R+WHRr5ynkbCJqKNamaroHoVh
 hihJsXTXnOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakZXhQAKCRA1o5Of/Hh3
 beSfEACgiSmLvXtCIJ5fisuHcBbEjsJzBfs7xkY6KUzUnjKHQMPV7u4l9pPSIeFjfqrjfUbLgMl
 nTgk42Wntvo1W7sDMkLCx8KwQF30cj30P0X9SEJggCMO28OM0TDsAtmcJGf1FLe4F+pfzGiKijf
 WACQwhwJ1wEQpXeekNldAYCB/WslHRHqEfr90bnHxstw4Q53HkOcnVO0A1aQJkyJB5oOVvdz5Ls
 wMbckXTJtryFbtFtiWe/ozDzK3Dj7eIoe1vpmP3BYr3rYUMjKyrIMLTdqtFyhSfrTCRgmVHkkAj
 02xcprDzBeRj/w7CKvyf/6jky+WIQHgrINl41qzpAIR94gPHk8dTyaLnk9wXHCI8EBq/9Ii8WI/
 R3uaDn10Tn2gegzOggprnU1Fi1s0IbMGfveipQ7z1p+PKAnOfWU50+VKPUQzVL75DcvOuTOz1Hq
 FIkTohW56PRvpKMESQtIxRJD8Vib1XWDa+cnvOPWB8TTv2OGuC7bUMl+CR1ddzem8oUeQ1zELiB
 l0Ff992by+Jxdi7W50Sliac2CjwH58cZA9K7Nte3xc2oBPde6Ip7Kf3bbDfPVoVb6exR4q0BDXD
 dVx6YXeUdv7fjrUAUbsx3TJUXTzYYYRFA5JDd5odAGcn1PHMNrKhejfbxpjzSvqAa+ZAI+xxOaO
 NLd2bLl1Pp/GEfw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304175-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B13DD6F78CE

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
index 75d50630a31ab..e36b0998c8109 100644
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
@@ -464,7 +465,7 @@ static struct netconsole_target *alloc_and_init(void)
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
 	nt->local_port = 6665;
 	nt->remote_port = 6666;
-	eth_broadcast_addr(nt->np.remote_mac);
+	eth_broadcast_addr(nt->remote_mac);
 	nt->state = STATE_DISABLED;
 	INIT_WORK(&nt->resume_wq, process_resume_target);
 
@@ -515,7 +516,7 @@ static void netconsole_print_banner(struct netconsole_target *nt)
 		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
 	else
 		np_info(np, "remote IPv4 address %pI4\n", &np->remote_ip.ip);
-	np_info(np, "remote ethernet address %pM\n", np->remote_mac);
+	np_info(np, "remote ethernet address %pM\n", nt->remote_mac);
 }
 
 /* Parse the string and populate the `inet_addr` union. Return 0 if IPv4 is
@@ -671,7 +672,7 @@ static ssize_t local_mac_show(struct config_item *item, char *buf)
 
 static ssize_t remote_mac_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%pM\n", to_target(item)->np.remote_mac);
+	return sysfs_emit(buf, "%pM\n", to_target(item)->remote_mac);
 }
 
 static ssize_t transmit_errors_show(struct config_item *item, char *buf)
@@ -1076,7 +1077,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	if (buf[MAC_ADDR_STR_LEN] && buf[MAC_ADDR_STR_LEN] != '\n')
 		goto out_unlock;
-	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
+	memcpy(nt->remote_mac, remote_mac, ETH_ALEN);
 
 	ret = count;
 out_unlock:
@@ -1884,14 +1885,15 @@ static void push_udp(struct netconsole_target *nt, struct sk_buff *skb, int len)
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
@@ -1979,7 +1981,7 @@ static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
 		push_ipv6(np, skb, len);
 	else
 		push_ipv4(np, skb, len);
-	push_eth(np, skb);
+	push_eth(nt, skb);
 	skb->dev = np->dev;
 
 	return (int)netpoll_send_skb(np, skb);
@@ -2374,7 +2376,7 @@ static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 
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



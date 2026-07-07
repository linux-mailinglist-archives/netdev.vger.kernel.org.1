Return-Path: <netdev+bounces-305484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fXbMFgoLTWpruAEAu9opvQ
	(envelope-from <netdev+bounces-305484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:19:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC571C809
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:19:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fTOKbglF;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305484-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305484-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D75031B45A5
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B61642466E;
	Tue,  7 Jul 2026 13:59:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861F4229B0
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:59:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432786; cv=none; b=oTtIJ/i9pFqoDWt/6d9t6PoSLdR66rZ4y1aF5/DUToWvdbqMYDXmcDZeQyvG6mIF5ZuHnGGMgzu0m/BQUHlaPbMwYmqUwAfV8aNFZ/Gw2rkTRGjKjSpv0DBGua33yQH0FTdgbpQU7/fFRqGu5NFCWRLkL6GgZg5TlKCbw3IGK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432786; c=relaxed/simple;
	bh=/iYHcgFjrHFN0Scel/m+skKEgEDhSn5WTbycrew+/lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngwOjISTMcmZQML24PEz3yDH9VJrjNyYxynCIJsWFyI3ZdborHzG5mPr8MSlY/gwPLixoof1x/oVmkiiA3K9sdFjeYmTbpiQ2x4wyeBuINBcHifgbGcqddfsJvlBywCXkrvzLchPQqpx3fZB6sTTSo+se2VK4z7cOPzgu0MrbY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTOKbglF; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493bb0e2894so6534875e9.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783432783; x=1784037583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=53QZ5zs8hezIVpTlLOTxFGj4/3N8vgT5mhbb0VI64UI=;
        b=fTOKbglFcd/zJzHoxdnjQrAS4hU4AyUasBfGNPGAIO1lHyxNeE4QxhupZqVzCNciiM
         8r6bHsRZnF7Ezi21wOznYBrY53cv5AQMr9i2fFzUPD1KGJkkEOTZis4rWtfI2Yl0eidJ
         wVrK4yhVZc6b9p/qZ3DD4ODTCCpV5g4et63+K7LslWuMd0nfj8tAExUmGfRxWvfNTXGQ
         PUGLfPzXs/UVDmJXfxUPFjDeKuH4u2/85T3tO+LZKvvI1Bh7GD2U6OpI7YbG6EulRHfW
         +KU6lNhgvNqPwsNCjFf2MTmXLO2pqIVAul3GDvbtg6aoq3/mujB+6fS6gQr5NrS2MEbO
         iKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432783; x=1784037583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=53QZ5zs8hezIVpTlLOTxFGj4/3N8vgT5mhbb0VI64UI=;
        b=ofras+0Kxo4ij8YxTfH6kvcJT9u7u1/sG6XxDkfGe7zYMZkkpfBgSMRADNxnQqlrk6
         A3o6AREwE5flkcyw4SBfGob777wFE1J31BLdnIZSKU1BGg3lqxHu/X8JcHgcwEq6ON4a
         TUa6g1ntAnyI53w+JoI/+54KzkLgY9+Q+3EPPRXiV9oNuVqe6tP+vAK2vGdG5snFQEoc
         xgI+VSgO01a3v09BPrDog9Ij8IOc4T2omrYGvhZah2zT+6bK/FWJaoIJhIElZ7AQaKgs
         7ceM/S15tjg0M6V5cVeq06J7NWKd+N2qAysIQcasq+pqXMbnMAyM92LD41KPAZF5bprp
         T25Q==
X-Gm-Message-State: AOJu0Yy5oyyeGyFTLbni6wM74AYICyZRH+OMLNdQvPw/iLcP9YJjDEq1
	R5F8vuyCcI/tz0swsTIqfEdgMye57lVCX2q/Cf7H6As+zf5/BVunUOD9r+AdjNit
X-Gm-Gg: AfdE7clAvvBWCfuhWh/fJ9j862s5B7zsoqkiAHRDqbdoRlhkJW6qH0wAuxrp/Uli1he
	4R4lVulbz4HKUm0wdFDP+3BFpFxWHwt5Ve3vQYDhjn7wAtoM/Y2A9g/6iOLzgMDTMWJCbAl1hjL
	P1IqYSGQXZL5O7byRqMN84TxKHCbpF6T4rpHNyGayzOERMvMAzx+8Ti+99etdlIkl52g+pazoFg
	NWdst/9LaAwYfVgP74FM4nwpmCBMlRxg+2DmAsQqlXToUA6Z2W5YKq5PFf9F3kvtFMPh4QOQqBC
	euBT5DVYBKGv119WNw5zFJ07OuyAX4n3z7BaP5wo06FnTICVIN9DKWiLpIY+uESSHQdVX1qyB+G
	DU1h1YYE6vC8eQMI0Upjh0LspvELPzOyi6JJtUSmOx+0REoKCKgT0iG9A9eIgIvSIPcKksJ6ALE
	1+dO4VJTE8XM/UsXYpD1qWr1t96gP0tezturEsV+0M9PCR08K8cBeb0EuJa5Qk03eDpUilAxgIo
	n+az3mc8Ki+1PHBz1wIys/dSkXBIkucqL0OgmTf2C4Y9T5UhP0=
X-Received: by 2002:a05:600c:4e42:b0:490:ec79:3046 with SMTP id 5b1f17b1804b1-493d0de371amr99534635e9.0.1783432782525;
        Tue, 07 Jul 2026 06:59:42 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-189-165-250.77.189.pool.telefonica.de. [77.189.165.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f40d50sm67409615e9.5.2026.07.07.06.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:59:41 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Felix Maurer <fmaurer@redhat.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net-next v3 2/4] net: hsr: emit RedBox-MAC TLV in PRP RedBox supervision frames
Date: Tue,  7 Jul 2026 15:59:35 +0200
Message-ID: <20260707135937.18-3-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707135937.18-1-xiexinet@gmail.com>
References: <20260707135937.18-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linux.dev,suse.de,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305484-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:bigeasy@linutronix.de,m:fmaurer@redhat.com,m:luka.gejak@linux.dev,m:fmancera@suse.de,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiexinet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0CC571C809

A PRP RedBox must announce the SANs it proxies so peers populate their
proxy node tables. The proxy-announce machinery (hsr_proxy_announce(),
armed via hsr->redbox) already iterates proxy_node_db under RCU and calls
send_sv_frame() once per SAN, but the PRP sender emitted neither the
announced SAN MAC nor the RedBox-MAC TLV that IEC 62439-3 requires.

Extend send_prp_supervision_frame() so that, for a proxy-announce
(identified by the interlink port, an O(1) test), the frame carries the
proxied SAN MAC as MacAddressA followed by the RedBox-MAC TLV (Type 30)
and an explicit End-of-TLV marker before padding.

hsr_get_node() must also accept the reinjected proxy-announce: a PRP
supervision frame is an untagged ETH_P_PRP frame (mac_len == ETH_HLEN, the
RCT is appended only on egress) sourced from macaddress_redbox, which is
never learned from data. Exempt only PRP supervision frames from the
hsr_ethhdr length guard; HSR (ETH_P_HSR) supervision is front-tagged and
keeps the original guard, so HSR malformed-frame filtering is unchanged.

Also align macaddress_redbox so that ether_addr_copy() and
ether_addr_equal() on it are safe on architectures without efficient
unaligned access.

Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c   | 33 ++++++++++++++++++++++++++++++---
 net/hsr/hsr_framereg.c | 13 +++++++++++--
 net/hsr/hsr_main.h     |  2 +-
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5af491ed2b7..0973f9a94f4 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -372,10 +372,21 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 {
 	struct hsr_priv *hsr = master->hsr;
 	struct hsr_sup_payload *hsr_sp;
+	struct hsr_sup_tlv *hsr_stlv;
 	struct hsr_sup_tag *hsr_stag;
 	struct sk_buff *skb;
+	bool redbox_proxy;
+	int extra = 0;
+
+	redbox_proxy = hsr->redbox && master->type == HSR_PT_INTERLINK;
+
+	/* A proxy-announce carries a RedBox-MAC TLV and an EOT marker. */
+	if (redbox_proxy)
+		extra = sizeof(struct hsr_sup_tlv) +
+			sizeof(struct hsr_sup_payload) +
+			sizeof(struct hsr_sup_tlv);
 
-	skb = hsr_init_skb(master, 0);
+	skb = hsr_init_skb(master, extra);
 	if (!skb) {
 		netdev_warn_once(master->dev, "PRP: Could not send supervision frame\n");
 		return;
@@ -393,9 +404,25 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
 	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
 
-	/* Payload: MacAddressA */
+	/* Payload: MacAddressA, the announced node. */
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
-	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
+	ether_addr_copy(hsr_sp->macaddress_A, addr);
+
+	/* Proxy-announce: append the RedBox-MAC TLV (Type 30) and an explicit
+	 * EOT to terminate the TLV chain before zero padding.
+	 */
+	if (redbox_proxy) {
+		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
+		hsr_stlv->HSR_TLV_type = PRP_TLV_REDBOX_MAC;
+		hsr_stlv->HSR_TLV_length = sizeof(struct hsr_sup_payload);
+
+		hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
+		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
+
+		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
+		hsr_stlv->HSR_TLV_type = HSR_TLV_EOT;
+		hsr_stlv->HSR_TLV_length = 0;
+	}
 
 	if (skb_put_padto(skb, ETH_ZLEN)) {
 		spin_unlock_bh(&hsr->seqnr_lock);
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 8f708b6e6c3..b3b106be692 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -293,8 +293,17 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	 */
 	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
 	    ethhdr->h_proto == htons(ETH_P_HSR)) {
-		/* Check if skb contains hsr_ethhdr */
-		if (skb->mac_len < sizeof(struct hsr_ethhdr))
+		bool prp_sup;
+
+		/* A PRP supervision frame is an untagged ETH_P_PRP frame
+		 * (mac_len == ETH_HLEN); its RCT is appended only on egress.
+		 * HSR (ETH_P_HSR) supervision is front-tagged and still must
+		 * contain a struct hsr_ethhdr.
+		 */
+		prp_sup = hsr->prot_version == PRP_V1 &&
+			  ethhdr->h_proto == htons(ETH_P_PRP) && is_sup;
+
+		if (!prp_sup && skb->mac_len < sizeof(struct hsr_ethhdr))
 			return NULL;
 	} else {
 		rct = skb_get_PRP_rct(skb);
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 134e4f3fff6..c27cfdd9ca3 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -211,7 +211,7 @@ struct hsr_priv {
 				 */
 	bool fwd_offloaded;	/* Forwarding offloaded to HW */
 	bool redbox;            /* Device supports HSR RedBox */
-	unsigned char		macaddress_redbox[ETH_ALEN];
+	unsigned char	macaddress_redbox[ETH_ALEN] __aligned(sizeof(u16));
 	unsigned char		sup_multicast_addr[ETH_ALEN] __aligned(sizeof(u16));
 				/* Align to u16 boundary to avoid unaligned access
 				 * in ether_addr_equal
-- 
2.53.0



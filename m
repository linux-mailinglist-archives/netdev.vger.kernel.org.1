Return-Path: <netdev+bounces-275693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A0GNPH202k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:09:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9F3A6048
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66AB63080C88
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B1395DB9;
	Mon,  6 Apr 2026 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rd2JJwF5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B973921E3
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498750; cv=none; b=k5kxIZxTHZXEVfmTnUmqoZSl40MKB3GD4ohY0F2m9JJkNwJKAFZNIRBWXs7Vo751iXvuptMe8zw3HzPAdrZYw3Ud9ALddZL2+CrR2pKBM4mhKTd/I0kX8XuJOFa8jo6vf0PQaYGoMxJYaTqDduOTlJO3ewPIZyx6IdmZCPWTQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498750; c=relaxed/simple;
	bh=qk2jLxImllBMmDH5LNrKwwmLvzU9Lk+Bx2fnMPw+170=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbKEcJtPa9PQ1Pmda8hzTDL6ZGv/qnC+CgEAB2yKNhYD8LBYFuukP5lOPfUODH1KoBVfophGcyjV+0YTtk6YvxJtV+G0CRIIpJo/s1tiUEAs3M+qBs7PfGfqsQUgiY/7CBkl0hhr4xzqA3my5rbkt/fHs7St+e6i25P1xWq2its=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rd2JJwF5; arc=none smtp.client-ip=74.125.82.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-12713e56abdso1490140c88.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498748; x=1776103548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SS9FUW95ER649tGSy8V3qlQPbp/q9DaqfpLM8Bg25nE=;
        b=QYvYMVU/DiihdfsTfvO1X+ywWMHNE9MbZ4XhSAYKQpA8UH9ifI+f93oYT48+kIqLHP
         K4aIwDIRamLbkRRxU2J/WD7swlNUUqVupbU+Kn7F+vcAB6vaDIxiAgwFG9verAuYBQTH
         67qdy2PrI6v1RRneYctuqGB16+Y5SnQOoDerpydlEL69VPFew36Rbmy54Otd1yS8DjqM
         38INtSkkme6dbxSgnyHmD6yZhw3uk+6+lZ0iyAt4TH9zZA5W8W3FcgIhknyHicC6V0PN
         K74LoLEdw26xRUZGIakEP1sm6sn/Gtr89LZrBzkwVRs2Cq62w+NzUJTP/JN3wrHhZ2zC
         y6iw==
X-Gm-Message-State: AOJu0Yze+/vivxaKM4YTBd6YleF05hjT5euRhm8ol3dc5ZJyvOTehZrC
	Ggxn9WF/rivxOOoDF6G3YePTXB7xv8KWE3EOoF2ks8K/HX/rzpaJr0vZ5M7jU6rkZ7QABlaY3Zq
	lU92FsaijVo6h/JekwBwh1bYFr9ch2cAhv9a2p+9DDUYY625SW1QHcL+kpGkpc0LAUijtQgnaWk
	duj/imrCP1u3E9tng4GpIqWNPckdyisXZe6xHL1jbteZdWk9rPY8Las9fe5i0qnrGmuHmEN6KUC
	DhsdUugFvl+WTbOYQ==
X-Gm-Gg: AeBDieurQk451maplVgXlmLovk8VqutCMEcs4HlXgRAlWI6iljuqEY/JDQXowtfGD+0
	aCg68LgTJVbjdys47AoDa95RJ7WUxHgMdjrp2diEFJmebvoqb71fFXYe1am1OtPbH83a3KW3iZk
	gDPJVWAK8GHYaWzoo0B+VBxJiRvZVQp3UUSGCqpQxezJxPaCSsooVytbLefXzQwwO0r52DfRiOW
	nlaGnRXhDsFVOhezB7mzbx037zawtEeyX5/v67Lxnp3Igx1V6M/RAoBrzLW6XMpHsc1eTEOnlRV
	22OyfRUE3m1JRGtxTgUmmMuFuCwlHnBXGXw6nL67l6JRVSpIFuL8A+lvHKqab18ET0LXcntf3v9
	Zu9yL3KMR2/zoGsDJl2Y9/Vl9tqzNEE1J7Cg8OVdj0bSJp6rusnsmiOEODTj0v7RCzHSGa/ktdP
	RSFFK3zw4e3pPOTQ3XxZu/20F1w7cUi88PlsFkzItLqY0iV7xjUbV4F+SxSmhgBQI=
X-Received: by 2002:a05:7022:220b:b0:11e:3e9:3e92 with SMTP id a92af1059eb24-12bf08ba9f5mr6503149c88.23.1775498747926;
        Mon, 06 Apr 2026 11:05:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12c03576f99sm385356c88.4.2026.04.06.11.05.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:05:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2489af602so41265515ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775498746; x=1776103546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS9FUW95ER649tGSy8V3qlQPbp/q9DaqfpLM8Bg25nE=;
        b=Rd2JJwF5YNRB4pr1NImXoLcpzljgG1AJa04eQNDHmLNQh3ZvtZhRUKSTg0JuQmWqGF
         RhuNYy+MtphGmvZB3J2M9ZadOj5etoaEaIBLaSoxAEmw6TCbm4dPahKzUvXzXyXzh725
         FqAfFj/HQDVV+Bg5jw4hi1G5FS3h6/hRmIOYA=
X-Received: by 2002:a17:902:d2ca:b0:2b0:b557:6fe5 with SMTP id d9443c01a7336-2b277e88764mr145986375ad.30.1775498746052;
        Mon, 06 Apr 2026 11:05:46 -0700 (PDT)
X-Received: by 2002:a17:902:d2ca:b0:2b0:b557:6fe5 with SMTP id d9443c01a7336-2b277e88764mr145986015ad.30.1775498745481;
        Mon, 06 Apr 2026 11:05:45 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm140625145ad.61.2026.04.06.11.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:05:44 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v12 10/10] bng_en: add support for ethtool -S stats display
Date: Mon,  6 Apr 2026 23:34:20 +0530
Message-ID: <20260406180420.279470-11-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
References: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275693-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 52A9F3A6048
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the legacy ethtool statistics interface (get_sset_count,
get_strings, get_ethtool_stats) to expose hardware counters not
available through standard kernel stats APIs.

Ex:
a) Per-queue ring stats
     rxq0_ucast_packets: 2
     rxq0_mcast_packets: 0
     rxq0_bcast_packets: 15
     rxq0_ucast_bytes: 120
     rxq0_mcast_bytes: 0
     rxq0_bcast_bytes: 900
     txq0_ucast_packets: 0
     txq0_mcast_packets: 0
     txq0_bcast_packets: 0
     txq0_ucast_bytes: 0
     txq0_mcast_bytes: 0
     txq0_bcast_bytes: 0

b) Per-queue TPA(LRO/GRO) stats
     rxq4_tpa_eligible_pkt: 0
     rxq4_tpa_eligible_bytes: 0
     rxq4_tpa_pkt: 0
     rxq4_tpa_bytes: 0
     rxq4_tpa_errors: 0
     rxq4_tpa_events: 0

c) Port level stats
     rxp_good_vlan_frames: 0
     rxp_mtu_err_frames: 0
     rxp_tagged_frames: 0
     rxp_double_tagged_frames: 0
     rxp_pfc_ena_frames_pri0: 0
     rxp_pfc_ena_frames_pri1: 0
     rxp_pfc_ena_frames_pri2: 0
     rxp_pfc_ena_frames_pri3: 0
     rxp_pfc_ena_frames_pri4: 0
     rxp_pfc_ena_frames_pri5: 0
     rxp_pfc_ena_frames_pri6: 0
     rxp_pfc_ena_frames_pri7: 0
     rxp_eee_lpi_events: 0
     rxp_eee_lpi_duration: 0
     rxp_runt_bytes: 0
     rxp_runt_frames: 0
     txp_good_vlan_frames: 0
     txp_jabber_frames: 0
     txp_fcs_err_frames: 0
     txp_pfc_ena_frames_pri0: 0
     txp_pfc_ena_frames_pri1: 0
     txp_pfc_ena_frames_pri2: 0
     txp_pfc_ena_frames_pri3: 0
     txp_pfc_ena_frames_pri4: 0
     txp_pfc_ena_frames_pri5: 0
     txp_pfc_ena_frames_pri6: 0
     txp_pfc_ena_frames_pri7: 0
     txp_eee_lpi_events: 0
     txp_eee_lpi_duration: 0
     txp_xthol_frames: 0

d) Per-priority stats
     rx_bytes_pri0: 4182650
     rx_bytes_pri1: 4182650
     rx_bytes_pri2: 4182650
     rx_bytes_pri3: 4182650
     rx_bytes_pri4: 4182650
     rx_bytes_pri5: 4182650
     rx_bytes_pri6: 4182650
     rx_bytes_pri7: 4182650

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 481 ++++++++++++++++++
 1 file changed, 481 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 87226d5bf15c..2467e44de291 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -35,6 +35,271 @@ static int bnge_nway_reset(struct net_device *dev)
 	return rc;
 }
 
+static const char * const bnge_ring_q_stats_str[] = {
+	"ucast_packets",
+	"mcast_packets",
+	"bcast_packets",
+	"ucast_bytes",
+	"mcast_bytes",
+	"bcast_bytes",
+};
+
+static const char * const bnge_ring_tpa2_stats_str[] = {
+	"tpa_eligible_pkt",
+	"tpa_eligible_bytes",
+	"tpa_pkt",
+	"tpa_bytes",
+	"tpa_errors",
+	"tpa_events",
+};
+
+#define BNGE_RX_PORT_STATS_ENTRY(suffix)	\
+	{ BNGE_RX_STATS_OFFSET(rx_##suffix), "rxp_" __stringify(suffix) }
+
+#define BNGE_TX_PORT_STATS_ENTRY(suffix)	\
+	{ BNGE_TX_STATS_OFFSET(tx_##suffix), "txp_" __stringify(suffix) }
+
+#define BNGE_RX_STATS_EXT_ENTRY(counter)	\
+	{ BNGE_RX_STATS_EXT_OFFSET(counter), __stringify(counter) }
+
+#define BNGE_TX_STATS_EXT_ENTRY(counter)	\
+	{ BNGE_TX_STATS_EXT_OFFSET(counter), __stringify(counter) }
+
+#define BNGE_RX_STATS_EXT_PFC_ENTRY(n)				\
+	BNGE_RX_STATS_EXT_ENTRY(pfc_pri##n##_rx_duration_us),	\
+	BNGE_RX_STATS_EXT_ENTRY(pfc_pri##n##_rx_transitions)
+
+#define BNGE_TX_STATS_EXT_PFC_ENTRY(n)				\
+	BNGE_TX_STATS_EXT_ENTRY(pfc_pri##n##_tx_duration_us),	\
+	BNGE_TX_STATS_EXT_ENTRY(pfc_pri##n##_tx_transitions)
+
+#define BNGE_RX_STATS_EXT_PFC_ENTRIES				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(0),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(1),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(2),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(3),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(4),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(5),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(6),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(7)
+
+#define BNGE_TX_STATS_EXT_PFC_ENTRIES				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(0),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(1),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(2),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(3),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(4),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(5),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(6),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(7)
+
+#define BNGE_RX_STATS_EXT_COS_ENTRY(n)				\
+	BNGE_RX_STATS_EXT_ENTRY(rx_bytes_cos##n),		\
+	BNGE_RX_STATS_EXT_ENTRY(rx_packets_cos##n)
+
+#define BNGE_TX_STATS_EXT_COS_ENTRY(n)				\
+	BNGE_TX_STATS_EXT_ENTRY(tx_bytes_cos##n),		\
+	BNGE_TX_STATS_EXT_ENTRY(tx_packets_cos##n)
+
+#define BNGE_RX_STATS_EXT_COS_ENTRIES				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(0),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(1),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(2),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(3),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(4),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(5),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(6),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(7)				\
+
+#define BNGE_TX_STATS_EXT_COS_ENTRIES				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(0),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(1),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(2),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(3),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(4),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(5),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(6),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(7)				\
+
+#define BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(n)			\
+	BNGE_RX_STATS_EXT_ENTRY(rx_discard_bytes_cos##n),	\
+	BNGE_RX_STATS_EXT_ENTRY(rx_discard_packets_cos##n)
+
+#define BNGE_RX_STATS_EXT_DISCARD_COS_ENTRIES				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(0),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(1),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(2),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(3),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(4),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(5),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(6),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(7)
+
+#define BNGE_RX_STATS_PRI_ENTRY(counter, n)		\
+	{ BNGE_RX_STATS_EXT_OFFSET(counter##_cos0),	\
+	  __stringify(counter##_pri##n) }
+
+#define BNGE_TX_STATS_PRI_ENTRY(counter, n)		\
+	{ BNGE_TX_STATS_EXT_OFFSET(counter##_cos0),	\
+	  __stringify(counter##_pri##n) }
+
+#define BNGE_RX_STATS_PRI_ENTRIES(counter)		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 0),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 1),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 2),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 3),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 4),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 5),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 6),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 7)
+
+#define BNGE_TX_STATS_PRI_ENTRIES(counter)		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 0),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 1),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 2),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 3),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 4),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 5),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 6),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 7)
+
+#define NUM_RING_Q_HW_STATS		ARRAY_SIZE(bnge_ring_q_stats_str)
+
+static const struct {
+	long offset;
+	char string[ETH_GSTRING_LEN];
+} bnge_tx_port_stats_ext_arr[] = {
+	BNGE_TX_STATS_EXT_COS_ENTRIES,
+	BNGE_TX_STATS_EXT_PFC_ENTRIES,
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_rx_bytes_pri_arr[] = {
+	BNGE_RX_STATS_PRI_ENTRIES(rx_bytes),
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_rx_pkts_pri_arr[] = {
+	BNGE_RX_STATS_PRI_ENTRIES(rx_packets),
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_tx_bytes_pri_arr[] = {
+	BNGE_TX_STATS_PRI_ENTRIES(tx_bytes),
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_tx_pkts_pri_arr[] = {
+	BNGE_TX_STATS_PRI_ENTRIES(tx_packets),
+};
+
+static const struct {
+	long offset;
+	char string[ETH_GSTRING_LEN];
+} bnge_port_stats_arr[] = {
+	BNGE_RX_PORT_STATS_ENTRY(good_vlan_frames),
+	BNGE_RX_PORT_STATS_ENTRY(mtu_err_frames),
+	BNGE_RX_PORT_STATS_ENTRY(tagged_frames),
+	BNGE_RX_PORT_STATS_ENTRY(double_tagged_frames),
+	BNGE_RX_PORT_STATS_ENTRY(pfc_ena_frames_pri0),
+	BNGE_RX_PORT_STATS_ENTRY(pfc_ena_frames_pri1),
+	BNGE_RX_PORT_STATS_ENTRY(pfc_ena_frames_pri2),
+	BNGE_RX_PORT_STATS_ENTRY(pfc_ena_frames_pri3),
+	BNGE_RX_PORT_STATS_ENTRY(pfc_ena_frames_pri4),
+	BNGE_RX_PORT_STATS_ENTRY(pfc_ena_frames_pri5),
+	BNGE_RX_PORT_STATS_ENTRY(pfc_ena_frames_pri6),
+	BNGE_RX_PORT_STATS_ENTRY(pfc_ena_frames_pri7),
+	BNGE_RX_PORT_STATS_ENTRY(eee_lpi_events),
+	BNGE_RX_PORT_STATS_ENTRY(eee_lpi_duration),
+	BNGE_RX_PORT_STATS_ENTRY(runt_bytes),
+	BNGE_RX_PORT_STATS_ENTRY(runt_frames),
+
+	BNGE_TX_PORT_STATS_ENTRY(good_vlan_frames),
+	BNGE_TX_PORT_STATS_ENTRY(jabber_frames),
+	BNGE_TX_PORT_STATS_ENTRY(fcs_err_frames),
+	BNGE_TX_PORT_STATS_ENTRY(pfc_ena_frames_pri0),
+	BNGE_TX_PORT_STATS_ENTRY(pfc_ena_frames_pri1),
+	BNGE_TX_PORT_STATS_ENTRY(pfc_ena_frames_pri2),
+	BNGE_TX_PORT_STATS_ENTRY(pfc_ena_frames_pri3),
+	BNGE_TX_PORT_STATS_ENTRY(pfc_ena_frames_pri4),
+	BNGE_TX_PORT_STATS_ENTRY(pfc_ena_frames_pri5),
+	BNGE_TX_PORT_STATS_ENTRY(pfc_ena_frames_pri6),
+	BNGE_TX_PORT_STATS_ENTRY(pfc_ena_frames_pri7),
+	BNGE_TX_PORT_STATS_ENTRY(eee_lpi_events),
+	BNGE_TX_PORT_STATS_ENTRY(eee_lpi_duration),
+	BNGE_TX_PORT_STATS_ENTRY(xthol_frames),
+};
+
+static const struct {
+	long offset;
+	char string[ETH_GSTRING_LEN];
+} bnge_port_stats_ext_arr[] = {
+	BNGE_RX_STATS_EXT_ENTRY(continuous_pause_events),
+	BNGE_RX_STATS_EXT_ENTRY(resume_pause_events),
+	BNGE_RX_STATS_EXT_ENTRY(continuous_roce_pause_events),
+	BNGE_RX_STATS_EXT_ENTRY(resume_roce_pause_events),
+	BNGE_RX_STATS_EXT_COS_ENTRIES,
+	BNGE_RX_STATS_EXT_PFC_ENTRIES,
+	BNGE_RX_STATS_EXT_ENTRY(rx_bits),
+	BNGE_RX_STATS_EXT_ENTRY(rx_buffer_passed_threshold),
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRIES,
+	BNGE_RX_STATS_EXT_ENTRY(rx_filter_miss),
+};
+
+static int bnge_get_num_tpa_ring_stats(struct bnge_dev *bd)
+{
+	if (BNGE_SUPPORTS_TPA(bd))
+		return BNGE_NUM_TPA_RING_STATS;
+	return 0;
+}
+
+#define BNGE_NUM_PORT_STATS ARRAY_SIZE(bnge_port_stats_arr)
+#define BNGE_NUM_STATS_PRI			\
+	(ARRAY_SIZE(bnge_rx_bytes_pri_arr) +	\
+	 ARRAY_SIZE(bnge_rx_pkts_pri_arr) +	\
+	 ARRAY_SIZE(bnge_tx_bytes_pri_arr) +	\
+	 ARRAY_SIZE(bnge_tx_pkts_pri_arr))
+
+static int bnge_get_num_ring_stats(struct bnge_dev *bd)
+{
+	int rx, tx;
+
+	rx = NUM_RING_Q_HW_STATS + bnge_get_num_tpa_ring_stats(bd);
+	tx = NUM_RING_Q_HW_STATS;
+	return rx * bd->rx_nr_rings +
+	       tx * bd->tx_nr_rings_per_tc;
+}
+
+static u32 bnge_get_num_stats(struct bnge_net *bn)
+{
+	u32 num_stats = bnge_get_num_ring_stats(bn->bd);
+	u32 len;
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS)
+		num_stats += BNGE_NUM_PORT_STATS;
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		len = min_t(u32, bn->fw_rx_stats_ext_size,
+			    ARRAY_SIZE(bnge_port_stats_ext_arr));
+		num_stats += len;
+		len = min_t(u32, bn->fw_tx_stats_ext_size,
+			    ARRAY_SIZE(bnge_tx_port_stats_ext_arr));
+		num_stats += len;
+		if (bn->pri2cos_valid)
+			num_stats += BNGE_NUM_STATS_PRI;
+	}
+
+	return num_stats;
+}
+
 static void bnge_get_drvinfo(struct net_device *dev,
 			     struct ethtool_drvinfo *info)
 {
@@ -46,6 +311,219 @@ static void bnge_get_drvinfo(struct net_device *dev,
 	strscpy(info->bus_info, pci_name(bd->pdev), sizeof(info->bus_info));
 }
 
+static int bnge_get_sset_count(struct net_device *dev, int sset)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		return bnge_get_num_stats(bn);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static bool is_rx_ring(struct bnge_dev *bd, u16 ring_num)
+{
+	return ring_num < bd->rx_nr_rings;
+}
+
+static bool is_tx_ring(struct bnge_dev *bd, u16 ring_num)
+{
+	u16 tx_base = 0;
+
+	if (!(bd->flags & BNGE_EN_SHARED_CHNL))
+		tx_base = bd->rx_nr_rings;
+
+	return ring_num >= tx_base && ring_num < (tx_base + bd->tx_nr_rings_per_tc);
+}
+
+static void bnge_get_ethtool_stats(struct net_device *dev,
+				   struct ethtool_stats *stats, u64 *buf)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	u32 tpa_stats;
+	u32 i, j = 0;
+
+	if (!bn->bnapi) {
+		j += bnge_get_num_ring_stats(bd);
+		goto skip_ring_stats;
+	}
+
+	tpa_stats = bnge_get_num_tpa_ring_stats(bd);
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		u64 *sw_stats;
+		int k;
+
+		nqr = &bnapi->nq_ring;
+		sw_stats = nqr->stats.sw_stats;
+
+		if (is_rx_ring(bd, i)) {
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_ucast_pkts);
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_mcast_pkts);
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_bcast_pkts);
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_ucast_bytes);
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_mcast_bytes);
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_bcast_bytes);
+		}
+		if (is_tx_ring(bd, i)) {
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_ucast_pkts);
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_mcast_pkts);
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_bcast_pkts);
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_ucast_bytes);
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_mcast_bytes);
+			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_bcast_bytes);
+		}
+		if (!tpa_stats || !is_rx_ring(bd, i))
+			continue;
+
+		k = BNGE_NUM_RX_RING_STATS + BNGE_NUM_TX_RING_STATS;
+		for (; k < BNGE_NUM_RX_RING_STATS + BNGE_NUM_TX_RING_STATS +
+			   tpa_stats; j++, k++)
+			buf[j] = sw_stats[k];
+	}
+
+skip_ring_stats:
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		u64 *port_stats = bn->port_stats.sw_stats;
+
+		for (i = 0; i < BNGE_NUM_PORT_STATS; i++, j++)
+			buf[j] = *(port_stats + bnge_port_stats_arr[i].offset);
+	}
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		u64 *rx_port_stats_ext = bn->rx_port_stats_ext.sw_stats;
+		u64 *tx_port_stats_ext = bn->tx_port_stats_ext.sw_stats;
+		u32 len;
+
+		len = min_t(u32, bn->fw_rx_stats_ext_size,
+			    ARRAY_SIZE(bnge_port_stats_ext_arr));
+		for (i = 0; i < len; i++, j++) {
+			buf[j] = *(rx_port_stats_ext +
+				   bnge_port_stats_ext_arr[i].offset);
+		}
+		len = min_t(u32, bn->fw_tx_stats_ext_size,
+			    ARRAY_SIZE(bnge_tx_port_stats_ext_arr));
+		for (i = 0; i < len; i++, j++) {
+			buf[j] = *(tx_port_stats_ext +
+				   bnge_tx_port_stats_ext_arr[i].offset);
+		}
+		if (bn->pri2cos_valid) {
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_rx_bytes_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(rx_port_stats_ext + n);
+			}
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_rx_pkts_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(rx_port_stats_ext + n);
+			}
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_tx_bytes_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(tx_port_stats_ext + n);
+			}
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_tx_pkts_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(tx_port_stats_ext + n);
+			}
+		}
+	}
+}
+
+static void bnge_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	u32 i, j, num_str;
+	const char *str;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < bd->nq_nr_rings; i++) {
+			if (is_rx_ring(bd, i))
+				for (j = 0; j < NUM_RING_Q_HW_STATS; j++) {
+					str = bnge_ring_q_stats_str[j];
+					ethtool_sprintf(&buf, "rxq%d_%s", i,
+							str);
+				}
+			if (is_tx_ring(bd, i))
+				for (j = 0; j < NUM_RING_Q_HW_STATS; j++) {
+					str = bnge_ring_q_stats_str[j];
+					ethtool_sprintf(&buf, "txq%d_%s", i,
+							str);
+				}
+			num_str = bnge_get_num_tpa_ring_stats(bd);
+			if (!num_str || !is_rx_ring(bd, i))
+				continue;
+
+			for (j = 0; j < num_str; j++) {
+				str = bnge_ring_tpa2_stats_str[j];
+				ethtool_sprintf(&buf, "rxq%d_%s", i, str);
+			}
+		}
+
+		if (bn->flags & BNGE_FLAG_PORT_STATS)
+			for (i = 0; i < BNGE_NUM_PORT_STATS; i++) {
+				str = bnge_port_stats_arr[i].string;
+				ethtool_puts(&buf, str);
+			}
+
+		if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+			u32 len;
+
+			len = min_t(u32, bn->fw_rx_stats_ext_size,
+				    ARRAY_SIZE(bnge_port_stats_ext_arr));
+			for (i = 0; i < len; i++) {
+				str = bnge_port_stats_ext_arr[i].string;
+				ethtool_puts(&buf, str);
+			}
+
+			len = min_t(u32, bn->fw_tx_stats_ext_size,
+				    ARRAY_SIZE(bnge_tx_port_stats_ext_arr));
+			for (i = 0; i < len; i++) {
+				str = bnge_tx_port_stats_ext_arr[i].string;
+				ethtool_puts(&buf, str);
+			}
+
+			if (bn->pri2cos_valid) {
+				for (i = 0; i < 8; i++) {
+					str = bnge_rx_bytes_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+
+				for (i = 0; i < 8; i++) {
+					str = bnge_rx_pkts_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+
+				for (i = 0; i < 8; i++) {
+					str = bnge_tx_bytes_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+
+				for (i = 0; i < 8; i++) {
+					str = bnge_tx_pkts_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+			}
+		}
+		break;
+	default:
+		netdev_err(bd->netdev, "%s invalid request %x\n",
+			   __func__, stringset);
+		break;
+	}
+}
+
 static void bnge_get_eth_phy_stats(struct net_device *dev,
 				   struct ethtool_eth_phy_stats *phy_stats)
 {
@@ -271,6 +749,9 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.nway_reset		= bnge_nway_reset,
 	.get_pauseparam		= bnge_get_pauseparam,
 	.set_pauseparam		= bnge_set_pauseparam,
+	.get_sset_count		= bnge_get_sset_count,
+	.get_strings		= bnge_get_strings,
+	.get_ethtool_stats	= bnge_get_ethtool_stats,
 	.get_eth_phy_stats	= bnge_get_eth_phy_stats,
 	.get_eth_mac_stats	= bnge_get_eth_mac_stats,
 	.get_eth_ctrl_stats	= bnge_get_eth_ctrl_stats,
-- 
2.47.3



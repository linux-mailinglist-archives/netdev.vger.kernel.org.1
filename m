Return-Path: <netdev+bounces-272679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOBkJQfpxmloQAUAu9opvQ
	(envelope-from <netdev+bounces-272679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:31:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1457534AFDD
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9277630DC465
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F061839F181;
	Fri, 27 Mar 2026 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ODmM3GgB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46339EF2B
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642536; cv=none; b=G9Woe5w9txnhyx1MQWzhx2JmpXGJ0Zmzq3KhJmVR2xj2ohG7ok4sukGNe583sJi+Cb5K7kY4k0f6+wyhnjIY1k4IoUPGfB2YaUQpL0Yo8cifEyI1GaArXcGY56lCiziPdhn8gwx7OAJIklyoV5tBMzgZFvrtbh7nnQvv66U7lJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642536; c=relaxed/simple;
	bh=qk2jLxImllBMmDH5LNrKwwmLvzU9Lk+Bx2fnMPw+170=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hENe240uQMXHoavS0kfxaeuVW9d4J7xPyteykL5yleKlobxXWpZs/jXvaRxmIvzmQcFQUovWS6Skn7Cf9QztTM611gopTw+xbtV1foR7NmVu9GE+1737a0WkpxdLaiMC3pFldITsh6gG48TyxmI5oodDfj1AQmi40ViEi0HKzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ODmM3GgB; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-359fea895b5so1908318a91.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642535; x=1775247335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SS9FUW95ER649tGSy8V3qlQPbp/q9DaqfpLM8Bg25nE=;
        b=DLPdPC8hiwR6nzw94XTlMlknMOIFzgvTFe8Y/7RlzIExpv9OhOuzCNL4vfWqpDYgHi
         OBgCH9y+WlG7CYFYCjryV+tOC91GONoe9uF2bvFSX7J1alF0uYuIoJ6r7cl7hKorYLh+
         kLp1A58BhM7nBbQYm5SeU8pLLVfF6NlzuiUsniIjAGV6C3kVeHQCU0mdpNfnAD4j3awm
         tJR/TjTgUnOWc3GXen7svp4UypgQrAsk8/dqY2NOo1pCnkWADLXuh0PT5q2tXQzA5Taz
         ZXg9ZkawsZt2Ov3HXACcMIQBTVDj6zbOyhqlaCJRHe449A++FLH7BUsLidN2wmaNrRj/
         x1ug==
X-Gm-Message-State: AOJu0YyL7u4Ob5K4Sa2lddHNs3H46qrZem89q732XLjNqAuUJHOiihah
	jFEbGLR5qu3wEB4a2hnXWpfn8XSwXBAg2HcTsD1RLsbU6UaJwtUbmr30neJonVheQlDrs8MC5ZE
	8ERwP1+onc2prmPZGNFOKLcyY5DxxzceRZsPakAnTPafsv4I4EGLH/tG/Nd/SU+4hptt5ZTFMOD
	Xmj52je5HQ1haKbbzPcafIvU65DhzkBmYen9FSgWSkSTyWJ6EdwGJTafiJGxmxtbe4A2q3Xo2U7
	OHPjw729aalNrNBOf7z
X-Gm-Gg: ATEYQzykySd7VwmXaAc4OeXcKqClwGbHd2ptgHrGNGdklzLFVXoqe1/epMc/VhDROqz
	tsD5QsmjvxNCUQMxhOW4f1rGuwbS3y0lltryO5X5v5n3wsTvAU44jGuXMH0lN8NyhjMNxz4yZDq
	GfE9RjzWnCAwuJL1jhkdIrW/D5akBLREpB9UVSkWoGagPKc3LCjcINWYtmvuoeu2T4CbHhA1N/O
	trM3hroiWCTCgkyjR51VXJ0qCYqpDEFh+AMlkPfeRiubFsPgyZDmxVSHQNjDllDSzmf+5ILCChI
	/RKXmANpfZizrEGXE6v4VG/UGiEbd6WAlloQ4vIYdxns0mWQfOfwQYSzj9gdIS8SR4+BnvZo6hI
	IqAQgzE+U+WEZzexFyHIptNe/0tCe3t9OPHni5l0Uzj+u0eeASJ9o1CcC29PoCfjBzf0JLb2irX
	KBn5SGVDpgCPRvSe2RiIIy2eidtDxJ/09yJGV1JCdEVd5JVgiRVdALkgrCCnKLpJ8=
X-Received: by 2002:a17:90b:53c8:b0:35b:e4d7:9694 with SMTP id 98e67ed59e1d1-35c3005b938mr3760444a91.19.1774642534713;
        Fri, 27 Mar 2026 13:15:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35d9508bf40sm1951a91.8.2026.03.27.13.15.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:15:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-799001d77fcso55741727b3.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774642533; x=1775247333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS9FUW95ER649tGSy8V3qlQPbp/q9DaqfpLM8Bg25nE=;
        b=ODmM3GgBjo3XPmGH47kEM65+78OIGi76ziYtjXSX729WSaTEbMrvyfLSVr8FuweLRO
         ijnu7c9dpfMf73frjiFa4NBe6g6gOKBt8OQMRUSCNjYys6oEXGw7YnhdnBNPyLziMqaf
         jP41/gJS/8+ud23HhFA7fAe90OQSMC7bNye00=
X-Received: by 2002:a05:690c:38b:b0:79a:d32f:e4e5 with SMTP id 00721157ae682-79bde072979mr40376937b3.45.1774642533116;
        Fri, 27 Mar 2026 13:15:33 -0700 (PDT)
X-Received: by 2002:a05:690c:38b:b0:79a:d32f:e4e5 with SMTP id 00721157ae682-79bde072979mr40376627b3.45.1774642532553;
        Fri, 27 Mar 2026 13:15:32 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8f324sm119057b3.28.2026.03.27.13.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:15:31 -0700 (PDT)
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
Subject: [PATCH net-next v10 10/10] bng_en: add support for ethtool -S stats display
Date: Sat, 28 Mar 2026 01:43:43 +0530
Message-ID: <20260327201343.16146-11-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
References: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272679-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 1457534AFDD
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



Return-Path: <netdev+bounces-267918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKmvBGDBtmkWHwEAu9opvQ
	(envelope-from <netdev+bounces-267918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:25:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB78291022
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 822333070FDA
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9C1366DC6;
	Sun, 15 Mar 2026 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dLznKEpE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC57366064
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584330; cv=none; b=eipUkmU1seyNE+zicyQJuFBGbAgHhCN1gqF5nAlZGXTOG0jo3drAt7nUuBo4lrnzrPFH7CY5EqVXkNA2ozEy1BI2EtDJL8mpLgvsInCIt9N2rqqDXuRAEJBUjvgrObab6aluiL1uZAcOXU/zIHbR6EN4CY+AGOP/vZooR0vAkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584330; c=relaxed/simple;
	bh=GsqFZzi+npb1QMLyBt9yoLbdWZeaxHDfUeAnX4DgSs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBuhPbyZGrXgQw0QRLXCFG3EyPOwA5iIGcEVeBuetOEo02bFGS+PSpAzb5nr2Ym3i4MnLrkepk/JOsmiw9Ceu7+weHNsSxQSIhMDXPDrwg8gY4TTmR3bN3fh3b8FlLk045stWA2SHIFoPdkfjZsgiwGv5NGwS/kksJ1v0YS2jkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dLznKEpE; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-50335b926c2so33562371cf.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584326; x=1774189126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pG9zNK4k/bZPhez8UbAEtKwyOdVFNkPnmbPMLI2Lsbo=;
        b=nxQZdaD7qOfrVlDvk5Kr7Nf5hz2JX4SW43bHrWeNVRk8hq/l+WVu7c+AbZ1oF2xFnH
         FfKBJ5K0ARc3kX6zYlbFF8GNpMHD06qxIGu6MRq8vqxlPdPCVsfpZSlNXVDQ7gwTKLKe
         RL+5iRCtvGQaLK5v2IjjzU2+kXVV5Lamr657Fa7aw0LJFLErU2V1YNWkGhNhIEmbACza
         ebkixCo+47YFIm26HAuEnVFxQq4VXW/RELZL9F2tz1VRb6FyJv/sBMwaUSC1Qn8vHgI5
         NghUDVLvW+iygwIxcfrfCXgADYJ0qpuEVnmZJk1Q4rPBfFQH+egt2c9udSVQ2tuxFnS2
         ZUZA==
X-Gm-Message-State: AOJu0YyppHl5P0n244Z1hHzVYtzwnzCugXNWcPzJirPB+kNRmvK7nile
	5WixrM7rIcmKUvB3+SdgBeFmSSuv+xcYcPwm8CPea/CaCX/hmbPfzM0NuGOVhOMGK9Qci5RvTw2
	ItLNzrtN+1TxgUG9LPFL/YKGk2ih5+JL6UjqW6tl3VQYLzBG90tBHa5vKbSHpGkuzeKv+G5nqr0
	4STyHdbV4ckje5LgqwmJ0mmet+ZZ9ITVZlO+rQWUXB/Wq9Y32Tk6BXWP+ti6il9Vwh8wNmYOJno
	yeKC4MDpw==
X-Gm-Gg: ATEYQzwXrwLAfIfwl58j23DfMLpv8s+MYW+7pOpRmd1YmlqCYot/su9Jf45yt8riKSk
	ePG05L1OOwEJGzxkI+bdXFu1NJWp25zOx2SAZiwI5obzQ8LqBHVZguHwpINAufKoZ17ZOeEmZb/
	8hDiFIsP6vEWWhc93iBk+UIfLcXcgUYpfzN5NiHZm8YdYUxIidoWe9+2Vp/tvNYN1KrE/ZU2Xpb
	yqTIPmOPk3rOop8u9WajXW8EABr1ioBYOq/f+J0W4uV/37/jk4f1YmJbS2sgYa3lY25SzdCWVLQ
	XXyhsfPWMTqUAcr3iuFSj4FIrTPPUkpDv2au+bYfYDRbEP9L0+Z5p+biFioRuzbXn5Na9QuAoiK
	ZAOESL9woarIKGE+y9TcbJTXpYtkCBw3HjOnk4xwbHxST+N5VdcyelaFScSaBGlhOMcMUZ37aRb
	NtkbU2/PKT8DA1Nhu7SH8GlsG6UZoJvSv5/qe6RNqMJTZvskbvPvIy68vVUA==
X-Received: by 2002:a05:622a:199f:b0:509:2822:670d with SMTP id d75a77b69052e-50957d5b454mr128971921cf.27.1773584326461;
        Sun, 15 Mar 2026 07:18:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89a65d043a7sm13295476d6.16.2026.03.15.07.18.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2026 07:18:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adc527eaf5so29623735ad.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773584325; x=1774189125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG9zNK4k/bZPhez8UbAEtKwyOdVFNkPnmbPMLI2Lsbo=;
        b=dLznKEpEdri+t0VzqHVSfFqKMDJrTb4Ko8zkTor4JaZ88K1/Sb0d+U7K2Horuy8SVk
         6bS7HINtPu0N4ziqtHnS05igr3TmOXQbwA/R4864lXLBmbSp1yc9sriKDsGsOCGvMbEx
         cuXKPBpjbYvvqc3pb7zlAX8WM0ArkJFnkT6SQ=
X-Received: by 2002:a17:902:dac2:b0:2ae:7f55:90a3 with SMTP id d9443c01a7336-2aecab139d2mr99150585ad.37.1773584325081;
        Sun, 15 Mar 2026 07:18:45 -0700 (PDT)
X-Received: by 2002:a17:902:dac2:b0:2ae:7f55:90a3 with SMTP id d9443c01a7336-2aecab139d2mr99150335ad.37.1773584324533;
        Sun, 15 Mar 2026 07:18:44 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c393sm76185395ad.17.2026.03.15.07.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:18:44 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
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
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v7 10/10] bng_en: add support for ethtool -S stats display
Date: Sun, 15 Mar 2026 19:46:05 +0530
Message-ID: <20260315141605.410878-11-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260315141605.410878-1-vikas.gupta@broadcom.com>
References: <20260315141605.410878-1-vikas.gupta@broadcom.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267918-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7DB78291022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

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
index 2ae13f18e2d7..1a0eb987ef6f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -31,6 +31,271 @@ static int bnge_nway_reset(struct net_device *dev)
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
+		len = min_t(int, bn->fw_rx_stats_ext_size,
+			    ARRAY_SIZE(bnge_port_stats_ext_arr));
+		num_stats += len;
+		len = min_t(int, bn->fw_tx_stats_ext_size,
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
@@ -42,6 +307,219 @@ static void bnge_get_drvinfo(struct net_device *dev,
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
+	return ring_num >= tx_base && ring_num < (tx_base + bd->tx_nr_rings);
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
@@ -262,6 +740,9 @@ static const struct ethtool_ops bnge_ethtool_ops = {
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
2.47.1



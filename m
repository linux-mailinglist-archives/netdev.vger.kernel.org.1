Return-Path: <netdev+bounces-269312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKlVJZSPu2lmlgIAu9opvQ
	(envelope-from <netdev+bounces-269312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:54:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE2A2C65D0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70C4A303A4AC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27574397E99;
	Thu, 19 Mar 2026 05:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FmftB85z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C772E06EF
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899599; cv=none; b=fTQ6uBKCyVpBetRQMzv4JFVS3x1LlH01XvO/RJlUsdjeLl/0pzFlytKWv2iWLgHf2z4OnVF0Qn5QLlHyDGODhRQu6ORubckvSKN792IAIPyc0rOshHfJixl18CJG+KYIkaraDZTgaayRJ6jXT9vaM8qHpfRFc5Cc5DRXPABMMDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899599; c=relaxed/simple;
	bh=GsqFZzi+npb1QMLyBt9yoLbdWZeaxHDfUeAnX4DgSs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGW69yq6dRngNeae15OcHzGqCOwW/5NasfmPz6NzUOEbZ7xnoK4ZypuiSOf70RnWv4sfuhKxTGf5ExqQVJgxQPuXlRhsVdMbz02Mzz00wYOM7kzYQJFLmyOFd2DI6oYNCH3d2f19ylhjL0ErfD3T0G5BpRmTjITTxggDDkdE0RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FmftB85z; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-64c31ca77b4so792269d50.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773899596; x=1774504396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pG9zNK4k/bZPhez8UbAEtKwyOdVFNkPnmbPMLI2Lsbo=;
        b=CHxU/oaLed3LChwBEFl4t8vGVFApKipIOmHFxQ7oGoZGc8vmIM/nhRCwAxxR1Cfx4v
         EBp/HkxyDy1wv+q5zfHolcrPSJzc/i4opfvsXMLb+HbdTqlVtckc6FE2O7GorK8y8j9K
         kM+NJQQhgvTlG6/PXpZgFScUoChSp/4TNVSl8agjhdJCYqNCNP5YVyI0Tsj/vzbs01PO
         wdhURORA4n8KAkTyHTh9geanPi3MFA+NWAdizUPS9RjNUUj4sfppiDZPLA65JRQQ3jl6
         uedsg3CYLJkEE64Bg0sEHyDwNtC3ywrwI4XRqFDW0AdOMTIcafll2LfqOu8gnoDF3zpB
         BrbA==
X-Gm-Message-State: AOJu0Yxw2CDlHzK5eUwBXxxY9Y431WYMsQ1e05CgD0ue5I1NP75WzDg+
	mXw67/pzI7d/ZUgFOA5xliGu1HsnD/I8noDdx9itcp474PRrD825ypeFrL7PPtOVX4zAaSUMe5g
	uKbZRH+MPs6DCjLRrfUfQI6IVPqvL6KvsbqWzfBVjrL85fDU3n87pWIAAmnmH0/ySv8dk6o2tFp
	7nCka4VavPYcInj0OJFqEahtlZIn6xMCuAARDIOwhur6d9nNdMATPPbHyiwrG/iGYN+UjpDGtPE
	DsCKRpx/Q==
X-Gm-Gg: ATEYQzzEuMocL576rAEqHCzscDhHcZGA9dpDaJ3IIvXbuco8Pz9oCDIsomQciBE5B/Z
	HAbcz6plSkN1kFgXsFr/mRfJUwnUH1RwsbJ+FcK+AffU/8ZzzL6s7OZ+lbloIl+IuCtYQbbsNlu
	CkiOI8CGjhJXJMJTny3RxOw9+01WoJgUtU4MwjLb1QsDl0asp+hzIsxZ8xAxIxpTvOEKl39gi+C
	4HFZOD3KmCPOQw8YdJ1u5JlO1dvGLMFMXznJuWChVA0s/ATqSCh3qBCGLcYQXR6zcKgYY36DBvp
	unKRbk3kxOdutPu15p3juGCjrkVH2qpZ3urKxim7tCypO00AMtZw09E2RTHzzT14LH5t9u/YhC2
	v67jUAmkA7upYEi6JzKbnt5NB3fW0fcO3lgFI6ci/BuZRRtqVBaxWozcLZ02CUWqHl8PD+VLDqm
	mtycmc6ZPGVQ4JK5l4dVzsL5xXX3or+7C5a2CW1hrW7ETG7KPzgHoG+T0=
X-Received: by 2002:a05:690e:681:b0:64c:99d7:8d1e with SMTP id 956f58d0204a3-64e912ee02emr4760102d50.3.1773899596272;
        Wed, 18 Mar 2026 22:53:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64e915d8d38sm396695d50.0.2026.03.18.22.53.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:53:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7965223b026so23329377b3.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773899595; x=1774504395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG9zNK4k/bZPhez8UbAEtKwyOdVFNkPnmbPMLI2Lsbo=;
        b=FmftB85zl9va3ub2zv7oxqRF6WigCZB30dfKQnqw89l/tFF0RcNobz/1PAH1Rq72VK
         EKil8aQeoEGVntDbFtZSBR3cjoAvdHgLygSKkM8OstfaJlKByqjxudy2wYGEnSxALPL0
         PxZOvjjp6O0WaDhFfxM4RY/3Kf12I8J35GMIw=
X-Received: by 2002:a53:b7d2:0:b0:64c:985f:9d4e with SMTP id 956f58d0204a3-64e9157bf06mr4506992d50.41.1773899595461;
        Wed, 18 Mar 2026 22:53:15 -0700 (PDT)
X-Received: by 2002:a53:b7d2:0:b0:64c:985f:9d4e with SMTP id 956f58d0204a3-64e9157bf06mr4506978d50.41.1773899594962;
        Wed, 18 Mar 2026 22:53:14 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91a1cd32sm2918980d50.2.2026.03.18.22.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:53:14 -0700 (PDT)
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
Subject: [PATCH net-next v8 10/10] bng_en: add support for ethtool -S stats display
Date: Thu, 19 Mar 2026 11:21:24 +0530
Message-ID: <20260319055124.1350670-11-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
References: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269312-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0CE2A2C65D0
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



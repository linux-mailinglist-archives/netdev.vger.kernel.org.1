Return-Path: <netdev+bounces-252944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEByNTvOc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:38:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F32C7A390
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 656233053987
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86AA2D1911;
	Fri, 23 Jan 2026 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ekV8HnnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661762DA74C
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196956; cv=none; b=a36BWtIFZc5OwyS7H9YeKQ2fEU4h4367+JKAqP10sTDMG9sr8190MMWzXVPQsJezNOE8ceGqgqtojLoCRj1B0ywR3Po0H7x+jPIRve5++9of3kZSGq82BoasG1A83Us938q1p0KXhJY6N3q8eqiYobSvcb9q84o4l7Cbzr2zbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196956; c=relaxed/simple;
	bh=prPzBnxeeMUWdAKzGYCuyJ95STzszX1/WTbLT0a/WAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gmx28ffcOODMnDr3BEloeIWQymbrkBvuS+5r+agjtPHDc8m9YilbEqlhhVYqnkLhVS3xWt0pjpH4b+ozbNH4RzQOJ6XB27IyxOCpupTwNso/7jSVf+I74bbnO++o+dCJtIcekz2QuH7jqv8makJMtTCvhp9YaV3PlRiyxpOgaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ekV8HnnX; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-1233bb90317so3055976c88.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196953; x=1769801753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTcjSb6ZwansrR5rl4czcgB7EtYaLy+a0+IL3nt4vsg=;
        b=EYZkFFJFVLmXZ7+2cezJNtosZaKN/OOLkqtpXMqxBgOtz1Ipu2/ReeM/VsYokF5IR3
         JPohQbAJXie92dQ7A+yN2MXHOz9GMzaRWC8XlD8O4fhAY1jWwc9awItCHbtvBO+142AU
         wLMz8vZM3hcXUninX6vhZ3x4pi6Ui50jT8o6C4rE5ihc1+bUwnPQhvYQevQcrmRhvQS5
         O/eIoyIGgUbsHlLwQcwTv/1qMGnT2jHI1MyBWquYS9xYatC2PfxgV8rYWSal9I6QI1R1
         cjAnkQPQIqjqTzuQpai5NjPki6pls51od6Cj3QKT4S22rQMxyZZ+W3zAKTOwHwZJ0og0
         /3CA==
X-Gm-Message-State: AOJu0YyPIs8PvLefF0koElRQdfuy3VaDnXLfAhgvptMS9Dk2PQ4C0Jj9
	GmwysZzabQ06i20bQG0ZM2GrQ27pnU5mkD2eiX8/oUC6F7OzXFYRyfjBEBeCsMVaKVekFvsNpcS
	r3OKnpZYzbMGtGe4tBFz/oVZfB6isuH2qYiE54aIgvknN6UqFPLAuBmChSExkz/cHxAfkB42HMx
	sYU6idDwWnbYpbrbYoc8NZ6ebSoqlC+8gBe1OOeZlqnJxYTLNj9hHdyo4OQrG5/SLdsC80gsbFQ
	Q0KWknoTlhR1FfUmw==
X-Gm-Gg: AZuq6aIhAXZXNRBPt0Su3xFP0Jj9dkPteO+iy/REehfyapwrMuqrUgoqK11zXsiA9S2
	ez1FufygdjJECqW7N1WI3sWmYWckxJjyC++Mx45H3NlNcVwWYM2sxqhqoAnuzwAgzsZK8ezx+5+
	9zRjPfRbIoY/YsQtpnGF6zl4qzelk2HGV4wlrMPS/06fFLBTavlTIn22UVCuto09f37vOiIRL9G
	LV8C5mVkazwOc1ZFwxJsgTjTAlsg3mE+ei6QC5HKhYOtv2HHlpKriwzftMr2/zFAGJGo7o42L9r
	LQI1wgbVzceyFVeQH9gyELQToItaVKu3dvdGoWMqQwrnmP72CuC8VLoaYC0Qq7WlHG95zBlThw+
	VtDYgg+enl2mCnoQZ980wZGcutVGokUGpk9idmZah95IOvHZOfT/l6clMe4KFHazAhaGOaR4rzK
	Fx6R9rIbrsJpU2D5Dj/BngXjWHlm5M7GWWaTLtPUAPaJDOsrHqNYZv3w==
X-Received: by 2002:a05:7022:6182:b0:119:e569:f875 with SMTP id a92af1059eb24-1247d77f381mr2042530c88.18.1769196953380;
        Fri, 23 Jan 2026 11:35:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1247d9b2287sm588401c88.8.2026.01.23.11.35.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:35:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7fc82eff4adso2126896b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769196951; x=1769801751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTcjSb6ZwansrR5rl4czcgB7EtYaLy+a0+IL3nt4vsg=;
        b=ekV8HnnXjzcfzjNxPM14AqMWODm4+cPTpO9wgu7ViHzvM9fooUghZSfmlB+YeucVsk
         yhtpUeVK8I0M4YDQwQhklxqzhn6USSryppeuyV8EoqDv5otnSC34BnkLhumvujf4vlaQ
         rjZ8z2hQeugKQ5yiSPY4WE3Xm9k7icO1piwjA=
X-Received: by 2002:a05:6a00:138c:b0:81c:5bca:8104 with SMTP id d2e1a72fcca58-82317b3094amr3007032b3a.24.1769196951319;
        Fri, 23 Jan 2026 11:35:51 -0800 (PST)
X-Received: by 2002:a05:6a00:138c:b0:81c:5bca:8104 with SMTP id d2e1a72fcca58-82317b3094amr3007016b3a.24.1769196950782;
        Fri, 23 Jan 2026 11:35:50 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e519sm2843206b3a.49.2026.01.23.11.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:35:50 -0800 (PST)
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
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v6, net-next 8/8] bng_en: Add support for TPA events
Date: Sat, 24 Jan 2026 01:05:04 +0530
Message-ID: <20260123193504.285573-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123193504.285573-1-bhargava.marreddy@broadcom.com>
References: <20260123193504.285573-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252944-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6F32C7A390
X-Rspamd-Action: no action

Enable TPA functionality in the VNIC and add functions
to handle TPA events, which help in processing LRO/GRO.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  65 +++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  27 ++
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 436 +++++++++++++++++-
 4 files changed, 520 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 198f49b40dbf..d4b1c0d2c44c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -1183,3 +1183,68 @@ int bnge_hwrm_set_async_event_cr(struct bnge_dev *bd, int idx)
 	req->async_event_cr = cpu_to_le16(idx);
 	return bnge_hwrm_req_send(bd, req);
 }
+
+#define BNGE_DFLT_TUNL_TPA_BMAP				\
+	(VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_GRE |	\
+	 VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_IPV4 |	\
+	 VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_IPV6)
+
+static void bnge_hwrm_vnic_update_tunl_tpa(struct bnge_dev *bd,
+					   struct hwrm_vnic_tpa_cfg_input *req)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	u32 tunl_tpa_bmap = BNGE_DFLT_TUNL_TPA_BMAP;
+
+	if (!(bd->fw_cap & BNGE_FW_CAP_VNIC_TUNNEL_TPA))
+		return;
+
+	if (bn->vxlan_port)
+		tunl_tpa_bmap |= VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_VXLAN;
+	if (bn->vxlan_gpe_port)
+		tunl_tpa_bmap |= VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_VXLAN_GPE;
+	if (bn->nge_port)
+		tunl_tpa_bmap |= VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_GENEVE;
+
+	req->enables |= cpu_to_le32(VNIC_TPA_CFG_REQ_ENABLES_TNL_TPA_EN);
+	req->tnl_tpa_en_bitmap = cpu_to_le32(tunl_tpa_bmap);
+}
+
+int bnge_hwrm_vnic_set_tpa(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
+			   u32 tpa_flags)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct hwrm_vnic_tpa_cfg_input *req;
+	int rc;
+
+	if (vnic->fw_vnic_id == INVALID_HW_RING_ID)
+		return 0;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_VNIC_TPA_CFG);
+	if (rc)
+		return rc;
+
+	if (tpa_flags) {
+		u32 flags;
+
+		flags = VNIC_TPA_CFG_REQ_FLAGS_TPA |
+			VNIC_TPA_CFG_REQ_FLAGS_ENCAP_TPA |
+			VNIC_TPA_CFG_REQ_FLAGS_RSC_WND_UPDATE |
+			VNIC_TPA_CFG_REQ_FLAGS_AGG_WITH_ECN |
+			VNIC_TPA_CFG_REQ_FLAGS_AGG_WITH_SAME_GRE_SEQ;
+		if (tpa_flags & BNGE_NET_EN_GRO)
+			flags |= VNIC_TPA_CFG_REQ_FLAGS_GRO;
+
+		req->flags = cpu_to_le32(flags);
+		req->enables =
+			cpu_to_le32(VNIC_TPA_CFG_REQ_ENABLES_MAX_AGG_SEGS |
+				    VNIC_TPA_CFG_REQ_ENABLES_MAX_AGGS |
+				    VNIC_TPA_CFG_REQ_ENABLES_MIN_AGG_LEN);
+		req->max_agg_segs = cpu_to_le16(MAX_TPA_SEGS);
+		req->max_aggs = cpu_to_le16(bn->max_tpa);
+		req->min_agg_len = cpu_to_le32(512);
+		bnge_hwrm_vnic_update_tunl_tpa(bd, req);
+	}
+	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
+
+	return bnge_hwrm_req_send(bd, req);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 042f28e84a05..38b046237feb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -55,4 +55,6 @@ int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
 			     struct bnge_ring_struct *ring,
 			     u32 ring_type, u32 map_index);
 int bnge_hwrm_set_async_event_cr(struct bnge_dev *bd, int idx);
+int bnge_hwrm_vnic_set_tpa(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
+			   u32 tpa_flags);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 6e240f48d89b..abb9b6bc91e0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2279,6 +2279,27 @@ static int bnge_request_irq(struct bnge_net *bn)
 	return rc;
 }
 
+static int bnge_set_tpa(struct bnge_net *bn, bool set_tpa)
+{
+	u32 tpa_flags = 0;
+	int rc, i;
+
+	if (set_tpa)
+		tpa_flags = bn->priv_flags & BNGE_NET_EN_TPA;
+	else if (BNGE_NO_FW_ACCESS(bn->bd))
+		return 0;
+	for (i = 0; i < bn->nr_vnics; i++) {
+		rc = bnge_hwrm_vnic_set_tpa(bn->bd, &bn->vnic_info[i],
+					    tpa_flags);
+		if (rc) {
+			netdev_err(bn->netdev, "hwrm vnic set tpa failure rc for vnic %d: %x\n",
+				   i, rc);
+			return rc;
+		}
+	}
+	return 0;
+}
+
 static int bnge_init_chip(struct bnge_net *bn)
 {
 	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
@@ -2313,6 +2334,12 @@ static int bnge_init_chip(struct bnge_net *bn)
 	if (bd->rss_cap & BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA)
 		bnge_hwrm_update_rss_hash_cfg(bn);
 
+	if (bn->priv_flags & BNGE_NET_EN_TPA) {
+		rc = bnge_set_tpa(bn, true);
+		if (rc)
+			goto err_out;
+	}
+
 	/* Filter for default vnic 0 */
 	rc = bnge_hwrm_set_vnic_filter(bn, 0, 0, bn->netdev->dev_addr);
 	if (rc) {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 363f835438f4..3c41e439369d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -14,6 +14,7 @@
 #include <linux/if.h>
 #include <net/ip.h>
 #include <net/tcp.h>
+#include <net/gro.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
 #include <linux/if_vlan.h>
@@ -44,6 +45,15 @@ irqreturn_t bnge_msix(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+static struct rx_agg_cmp *bnge_get_tpa_agg(struct bnge_net *bn,
+					   struct bnge_rx_ring_info *rxr,
+					   u16 agg_id, u16 curr)
+{
+	struct bnge_tpa_info *tpa_info = &rxr->rx_tpa[agg_id];
+
+	return &tpa_info->agg_arr[curr];
+}
+
 static struct rx_agg_cmp *bnge_get_agg(struct bnge_net *bn,
 				       struct bnge_cp_ring_info *cpr,
 				       u16 cp_cons, u16 curr)
@@ -57,7 +67,7 @@ static struct rx_agg_cmp *bnge_get_agg(struct bnge_net *bn,
 }
 
 static void bnge_reuse_rx_agg_bufs(struct bnge_cp_ring_info *cpr, u16 idx,
-				   u16 start, u32 agg_bufs)
+				   u16 start, u32 agg_bufs, bool tpa)
 {
 	struct bnge_napi *bnapi = cpr->bnapi;
 	struct bnge_net *bn = bnapi->bn;
@@ -76,7 +86,10 @@ static void bnge_reuse_rx_agg_bufs(struct bnge_cp_ring_info *cpr, u16 idx,
 		netmem_ref netmem;
 		u16 cons;
 
-		agg = bnge_get_agg(bn, cpr, idx, start + i);
+		if (tpa)
+			agg = bnge_get_tpa_agg(bn, rxr, idx, start + i);
+		else
+			agg = bnge_get_agg(bn, cpr, idx, start + i);
 		cons = agg->rx_agg_cmp_opaque;
 		__clear_bit(cons, rxr->rx_agg_bmap);
 
@@ -137,6 +150,8 @@ static int bnge_discard_rx(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 		agg_bufs = (le32_to_cpu(rxcmp->rx_cmp_misc_v1) &
 			    RX_CMP_AGG_BUFS) >>
 			   RX_CMP_AGG_BUFS_SHIFT;
+	} else if (cmp_type == CMP_TYPE_RX_L2_TPA_END_CMP) {
+		return 0;
 	}
 
 	if (agg_bufs) {
@@ -149,7 +164,7 @@ static int bnge_discard_rx(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 
 static u32 __bnge_rx_agg_netmems(struct bnge_net *bn,
 				 struct bnge_cp_ring_info *cpr,
-				 u16 idx, u32 agg_bufs,
+				 u16 idx, u32 agg_bufs, bool tpa,
 				 struct sk_buff *skb)
 {
 	struct bnge_napi *bnapi = cpr->bnapi;
@@ -168,7 +183,10 @@ static u32 __bnge_rx_agg_netmems(struct bnge_net *bn,
 		u16 cons, frag_len;
 		netmem_ref netmem;
 
-		agg = bnge_get_agg(bn, cpr, idx, i);
+		if (tpa)
+			agg = bnge_get_tpa_agg(bn, rxr, idx, i);
+		else
+			agg = bnge_get_agg(bn, cpr, idx, i);
 		cons = agg->rx_agg_cmp_opaque;
 		frag_len = (le32_to_cpu(agg->rx_agg_cmp_len_flags_type) &
 			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
@@ -198,7 +216,7 @@ static u32 __bnge_rx_agg_netmems(struct bnge_net *bn,
 			 * allocated already.
 			 */
 			rxr->rx_agg_prod = prod;
-			bnge_reuse_rx_agg_bufs(cpr, idx, i, agg_bufs - i);
+			bnge_reuse_rx_agg_bufs(cpr, idx, i, agg_bufs - i, tpa);
 			return 0;
 		}
 
@@ -215,11 +233,12 @@ static u32 __bnge_rx_agg_netmems(struct bnge_net *bn,
 static struct sk_buff *bnge_rx_agg_netmems_skb(struct bnge_net *bn,
 					       struct bnge_cp_ring_info *cpr,
 					       struct sk_buff *skb, u16 idx,
-					       u32 agg_bufs)
+					       u32 agg_bufs, bool tpa)
 {
 	u32 total_frag_len;
 
-	total_frag_len = __bnge_rx_agg_netmems(bn, cpr, idx, agg_bufs, skb);
+	total_frag_len = __bnge_rx_agg_netmems(bn, cpr, idx, agg_bufs,
+					       tpa, skb);
 	if (!total_frag_len) {
 		skb_mark_for_recycle(skb);
 		dev_kfree_skb(skb);
@@ -253,6 +272,165 @@ static void bnge_sched_reset_txr(struct bnge_net *bn,
 	/* TODO: Initiate reset task */
 }
 
+static u16 bnge_tpa_alloc_agg_idx(struct bnge_rx_ring_info *rxr, u16 agg_id)
+{
+	struct bnge_tpa_idx_map *map = rxr->rx_tpa_idx_map;
+	u16 idx = agg_id & MAX_TPA_MASK;
+
+	if (test_bit(idx, map->agg_idx_bmap)) {
+		idx = find_first_zero_bit(map->agg_idx_bmap, MAX_TPA);
+		if (idx >= MAX_TPA)
+			return INVALID_HW_RING_ID;
+	}
+	__set_bit(idx, map->agg_idx_bmap);
+	map->agg_id_tbl[agg_id] = idx;
+	return idx;
+}
+
+static void bnge_free_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
+{
+	struct bnge_tpa_idx_map *map = rxr->rx_tpa_idx_map;
+
+	__clear_bit(idx, map->agg_idx_bmap);
+}
+
+static u16 bnge_lookup_agg_idx(struct bnge_rx_ring_info *rxr, u16 agg_id)
+{
+	struct bnge_tpa_idx_map *map = rxr->rx_tpa_idx_map;
+
+	return map->agg_id_tbl[agg_id];
+}
+
+static void bnge_tpa_metadata(struct bnge_tpa_info *tpa_info,
+			      struct rx_tpa_start_cmp *tpa_start,
+			      struct rx_tpa_start_cmp_ext *tpa_start1)
+{
+	tpa_info->cfa_code_valid = 1;
+	tpa_info->cfa_code = TPA_START_CFA_CODE(tpa_start1);
+	tpa_info->vlan_valid = 0;
+	if (tpa_info->flags2 & RX_CMP_FLAGS2_META_FORMAT_VLAN) {
+		tpa_info->vlan_valid = 1;
+		tpa_info->metadata =
+			le32_to_cpu(tpa_start1->rx_tpa_start_cmp_metadata);
+	}
+}
+
+static void bnge_tpa_metadata_v2(struct bnge_tpa_info *tpa_info,
+				 struct rx_tpa_start_cmp *tpa_start,
+				 struct rx_tpa_start_cmp_ext *tpa_start1)
+{
+	tpa_info->vlan_valid = 0;
+	if (TPA_START_VLAN_VALID(tpa_start)) {
+		u32 tpid_sel = TPA_START_VLAN_TPID_SEL(tpa_start);
+		u32 vlan_proto = ETH_P_8021Q;
+
+		tpa_info->vlan_valid = 1;
+		if (tpid_sel == RX_TPA_START_METADATA1_TPID_8021AD)
+			vlan_proto = ETH_P_8021AD;
+		tpa_info->metadata = vlan_proto << 16 |
+				     TPA_START_METADATA0_TCI(tpa_start1);
+	}
+}
+
+static void bnge_tpa_start(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
+			   u8 cmp_type, struct rx_tpa_start_cmp *tpa_start,
+			   struct rx_tpa_start_cmp_ext *tpa_start1)
+{
+	struct bnge_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
+	struct bnge_tpa_info *tpa_info;
+	u16 cons, prod, agg_id;
+	struct rx_bd *prod_bd;
+	dma_addr_t mapping;
+
+	agg_id = TPA_START_AGG_ID(tpa_start);
+	agg_id = bnge_tpa_alloc_agg_idx(rxr, agg_id);
+	if (unlikely(agg_id == INVALID_HW_RING_ID)) {
+		netdev_warn(bn->netdev, "Unable to allocate agg ID for ring %d, agg 0x%lx\n",
+			    rxr->bnapi->index, TPA_START_AGG_ID(tpa_start));
+		bnge_sched_reset_rxr(bn, rxr);
+		return;
+	}
+	cons = tpa_start->rx_tpa_start_cmp_opaque;
+	prod = rxr->rx_prod;
+	cons_rx_buf = &rxr->rx_buf_ring[cons];
+	prod_rx_buf = &rxr->rx_buf_ring[RING_RX(bn, prod)];
+	tpa_info = &rxr->rx_tpa[agg_id];
+
+	if (unlikely(cons != rxr->rx_next_cons ||
+		     TPA_START_ERROR(tpa_start))) {
+		netdev_warn(bn->netdev, "TPA cons %x, expected cons %x, error code %lx\n",
+			    cons, rxr->rx_next_cons,
+			    TPA_START_ERROR_CODE(tpa_start1));
+		bnge_sched_reset_rxr(bn, rxr);
+		return;
+	}
+	prod_rx_buf->data = tpa_info->data;
+	prod_rx_buf->data_ptr = tpa_info->data_ptr;
+
+	mapping = tpa_info->mapping;
+	prod_rx_buf->mapping = mapping;
+
+	prod_bd = &rxr->rx_desc_ring[RX_RING(bn, prod)][RX_IDX(prod)];
+
+	prod_bd->rx_bd_haddr = cpu_to_le64(mapping);
+
+	tpa_info->data = cons_rx_buf->data;
+	tpa_info->data_ptr = cons_rx_buf->data_ptr;
+	cons_rx_buf->data = NULL;
+	tpa_info->mapping = cons_rx_buf->mapping;
+
+	tpa_info->len =
+		le32_to_cpu(tpa_start->rx_tpa_start_cmp_len_flags_type) >>
+				RX_TPA_START_CMP_LEN_SHIFT;
+	if (likely(TPA_START_HASH_VALID(tpa_start))) {
+		tpa_info->hash_type = PKT_HASH_TYPE_L4;
+		if (TPA_START_IS_IPV6(tpa_start1))
+			tpa_info->gso_type = SKB_GSO_TCPV6;
+		else
+			tpa_info->gso_type = SKB_GSO_TCPV4;
+		tpa_info->rss_hash =
+			le32_to_cpu(tpa_start->rx_tpa_start_cmp_rss_hash);
+	} else {
+		tpa_info->hash_type = PKT_HASH_TYPE_NONE;
+		tpa_info->gso_type = 0;
+		netif_warn(bn, rx_err, bn->netdev, "TPA packet without valid hash\n");
+	}
+	tpa_info->flags2 = le32_to_cpu(tpa_start1->rx_tpa_start_cmp_flags2);
+	tpa_info->hdr_info = le32_to_cpu(tpa_start1->rx_tpa_start_cmp_hdr_info);
+	if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP)
+		bnge_tpa_metadata(tpa_info, tpa_start, tpa_start1);
+	else
+		bnge_tpa_metadata_v2(tpa_info, tpa_start, tpa_start1);
+	tpa_info->agg_count = 0;
+
+	rxr->rx_prod = NEXT_RX(prod);
+	cons = RING_RX(bn, NEXT_RX(cons));
+	rxr->rx_next_cons = RING_RX(bn, NEXT_RX(cons));
+	cons_rx_buf = &rxr->rx_buf_ring[cons];
+
+	bnge_reuse_rx_data(rxr, cons, cons_rx_buf->data);
+	rxr->rx_prod = NEXT_RX(rxr->rx_prod);
+	cons_rx_buf->data = NULL;
+}
+
+static void bnge_abort_tpa(struct bnge_cp_ring_info *cpr, u16 idx, u32 agg_bufs)
+{
+	if (agg_bufs)
+		bnge_reuse_rx_agg_bufs(cpr, idx, 0, agg_bufs, true);
+}
+
+static void bnge_tpa_agg(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
+			 struct rx_agg_cmp *rx_agg)
+{
+	u16 agg_id = TPA_AGG_AGG_ID(rx_agg);
+	struct bnge_tpa_info *tpa_info;
+
+	agg_id = bnge_lookup_agg_idx(rxr, agg_id);
+	tpa_info = &rxr->rx_tpa[agg_id];
+
+	tpa_info->agg_arr[tpa_info->agg_count++] = *rx_agg;
+}
+
 void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data)
 {
 	struct bnge_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
@@ -305,6 +483,208 @@ static struct sk_buff *bnge_copy_skb(struct bnge_napi *bnapi, u8 *data,
 	return skb;
 }
 
+#ifdef CONFIG_INET
+static void bnge_gro_tunnel(struct sk_buff *skb, __be16 ip_proto)
+{
+	struct udphdr *uh = NULL;
+
+	if (ip_proto == htons(ETH_P_IP)) {
+		struct iphdr *iph = (struct iphdr *)skb->data;
+
+		if (iph->protocol == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	} else {
+		struct ipv6hdr *iph = (struct ipv6hdr *)skb->data;
+
+		if (iph->nexthdr == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	}
+	if (uh) {
+		if (uh->check)
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
+		else
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
+	}
+}
+
+static struct sk_buff *bnge_gro_func(struct bnge_tpa_info *tpa_info,
+				     int payload_off, int tcp_ts,
+				     struct sk_buff *skb)
+{
+	u16 outer_ip_off, inner_ip_off, inner_mac_off;
+	u32 hdr_info = tpa_info->hdr_info;
+	int iphdr_len, nw_off;
+
+	inner_ip_off = BNGE_TPA_INNER_L3_OFF(hdr_info);
+	inner_mac_off = BNGE_TPA_INNER_L2_OFF(hdr_info);
+	outer_ip_off = BNGE_TPA_OUTER_L3_OFF(hdr_info);
+
+	nw_off = inner_ip_off - ETH_HLEN;
+	skb_set_network_header(skb, nw_off);
+	iphdr_len = (tpa_info->flags2 & RX_TPA_START_CMP_FLAGS2_IP_TYPE) ?
+		     sizeof(struct ipv6hdr) : sizeof(struct iphdr);
+	skb_set_transport_header(skb, nw_off + iphdr_len);
+
+	if (inner_mac_off) { /* tunnel */
+		__be16 proto = *((__be16 *)(skb->data + outer_ip_off -
+					    ETH_HLEN - 2));
+
+		bnge_gro_tunnel(skb, proto);
+	}
+
+	return skb;
+}
+
+static struct sk_buff *bnge_gro_skb(struct bnge_net *bn,
+				    struct bnge_tpa_info *tpa_info,
+				    struct rx_tpa_end_cmp *tpa_end,
+				    struct rx_tpa_end_cmp_ext *tpa_end1,
+				    struct sk_buff *skb)
+{
+	int payload_off;
+	u16 segs;
+
+	segs = TPA_END_TPA_SEGS(tpa_end);
+	if (segs == 1)
+		return skb;
+
+	NAPI_GRO_CB(skb)->count = segs;
+	skb_shinfo(skb)->gso_size =
+		le32_to_cpu(tpa_end1->rx_tpa_end_cmp_seg_len);
+	skb_shinfo(skb)->gso_type = tpa_info->gso_type;
+	payload_off = TPA_END_PAYLOAD_OFF(tpa_end1);
+	skb = bnge_gro_func(tpa_info, payload_off,
+			    TPA_END_GRO_TS(tpa_end), skb);
+	if (likely(skb))
+		tcp_gro_complete(skb);
+
+	return skb;
+}
+#endif
+
+static struct sk_buff *bnge_tpa_end(struct bnge_net *bn,
+				    struct bnge_cp_ring_info *cpr,
+				    u32 *raw_cons,
+				    struct rx_tpa_end_cmp *tpa_end,
+				    struct rx_tpa_end_cmp_ext *tpa_end1,
+				    u8 *event)
+{
+	struct bnge_napi *bnapi = cpr->bnapi;
+	struct net_device *dev = bn->netdev;
+	struct bnge_tpa_info *tpa_info;
+	struct bnge_rx_ring_info *rxr;
+	u8 *data_ptr, agg_bufs;
+	struct sk_buff *skb;
+	u16 idx = 0, agg_id;
+	dma_addr_t mapping;
+	unsigned int len;
+	void *data;
+
+	rxr = bnapi->rx_ring;
+	agg_id = TPA_END_AGG_ID(tpa_end);
+	agg_id = bnge_lookup_agg_idx(rxr, agg_id);
+	agg_bufs = TPA_END_AGG_BUFS(tpa_end1);
+	tpa_info = &rxr->rx_tpa[agg_id];
+	if (unlikely(agg_bufs != tpa_info->agg_count)) {
+		netdev_warn(bn->netdev, "TPA end agg_buf %d != expected agg_bufs %d\n",
+			    agg_bufs, tpa_info->agg_count);
+		agg_bufs = tpa_info->agg_count;
+	}
+	tpa_info->agg_count = 0;
+	*event |= BNGE_AGG_EVENT;
+	bnge_free_agg_idx(rxr, agg_id);
+	idx = agg_id;
+	data = tpa_info->data;
+	data_ptr = tpa_info->data_ptr;
+	prefetch(data_ptr);
+	len = tpa_info->len;
+	mapping = tpa_info->mapping;
+
+	if (unlikely(agg_bufs > MAX_SKB_FRAGS || TPA_END_ERRORS(tpa_end1))) {
+		bnge_abort_tpa(cpr, idx, agg_bufs);
+		if (agg_bufs > MAX_SKB_FRAGS)
+			netdev_warn(bn->netdev, "TPA frags %d exceeded MAX_SKB_FRAGS %d\n",
+				    agg_bufs, (int)MAX_SKB_FRAGS);
+		return NULL;
+	}
+
+	if (len <= bn->rx_copybreak) {
+		skb = bnge_copy_skb(bnapi, data_ptr, len, mapping);
+		if (!skb) {
+			bnge_abort_tpa(cpr, idx, agg_bufs);
+			return NULL;
+		}
+	} else {
+		dma_addr_t new_mapping;
+		u8 *new_data;
+
+		new_data = __bnge_alloc_rx_frag(bn, &new_mapping, rxr,
+						GFP_ATOMIC);
+		if (!new_data) {
+			bnge_abort_tpa(cpr, idx, agg_bufs);
+			return NULL;
+		}
+
+		tpa_info->data = new_data;
+		tpa_info->data_ptr = new_data + bn->rx_offset;
+		tpa_info->mapping = new_mapping;
+
+		skb = napi_build_skb(data, bn->rx_buf_size);
+		dma_sync_single_for_cpu(bn->bd->dev, mapping,
+					bn->rx_buf_use_size, bn->rx_dir);
+
+		if (!skb) {
+			page_pool_free_va(rxr->head_pool, data, true);
+			bnge_abort_tpa(cpr, idx, agg_bufs);
+			return NULL;
+		}
+		skb_mark_for_recycle(skb);
+		skb_reserve(skb, bn->rx_offset);
+		skb_put(skb, len);
+	}
+
+	if (agg_bufs) {
+		skb = bnge_rx_agg_netmems_skb(bn, cpr, skb, idx, agg_bufs,
+					      true);
+		/* Page reuse already handled by bnge_rx_agg_netmems_skb(). */
+		if (!skb)
+			return NULL;
+	}
+
+	skb->protocol = eth_type_trans(skb, dev);
+
+	if (tpa_info->hash_type != PKT_HASH_TYPE_NONE)
+		skb_set_hash(skb, tpa_info->rss_hash, tpa_info->hash_type);
+
+	if (tpa_info->vlan_valid &&
+	    (dev->features & BNGE_HW_FEATURE_VLAN_ALL_RX)) {
+		__be16 vlan_proto = htons(tpa_info->metadata >>
+					  RX_CMP_FLAGS2_METADATA_TPID_SFT);
+		u16 vtag = tpa_info->metadata & RX_CMP_FLAGS2_METADATA_TCI_MASK;
+
+		if (eth_type_vlan(vlan_proto)) {
+			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
+		} else {
+			dev_kfree_skb(skb);
+			return NULL;
+		}
+	}
+
+	skb_checksum_none_assert(skb);
+	if (likely(tpa_info->flags2 & RX_TPA_START_CMP_FLAGS2_L4_CS_CALC)) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level =
+			(tpa_info->flags2 & RX_CMP_FLAGS2_T_L4_CS_CALC) >> 3;
+	}
+
+#ifdef CONFIG_INET
+	if (bn->priv_flags & BNGE_NET_EN_GRO)
+		skb = bnge_gro_skb(bn, tpa_info, tpa_end, tpa_end1, skb);
+#endif
+
+	return skb;
+}
+
 static enum pkt_hash_types bnge_rss_ext_op(struct bnge_net *bn,
 					   struct rx_cmp *rxcmp)
 {
@@ -397,6 +777,7 @@ static struct sk_buff *bnge_rx_skb(struct bnge_net *bn,
 
 /* returns the following:
  * 1       - 1 packet successfully received
+ * 0       - successful TPA_START, packet not completed yet
  * -EBUSY  - completion ring does not have all the agg buffers yet
  * -ENOMEM - packet aborted due to out of memory
  * -EIO    - packet aborted due to hw error indicated in BD
@@ -429,6 +810,11 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 
 	cmp_type = RX_CMP_TYPE(rxcmp);
 
+	if (cmp_type == CMP_TYPE_RX_TPA_AGG_CMP) {
+		bnge_tpa_agg(bn, rxr, (struct rx_agg_cmp *)rxcmp);
+		goto next_rx_no_prod_no_len;
+	}
+
 	tmp_raw_cons = NEXT_RAW_CMP(tmp_raw_cons);
 	cp_cons = RING_CMP(bn, tmp_raw_cons);
 	rxcmp1 = (struct rx_cmp_ext *)
@@ -443,6 +829,28 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	dma_rmb();
 	prod = rxr->rx_prod;
 
+	if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP ||
+	    cmp_type == CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
+		bnge_tpa_start(bn, rxr, cmp_type,
+			       (struct rx_tpa_start_cmp *)rxcmp,
+			       (struct rx_tpa_start_cmp_ext *)rxcmp1);
+
+		*event |= BNGE_RX_EVENT;
+		goto next_rx_no_prod_no_len;
+
+	} else if (cmp_type == CMP_TYPE_RX_L2_TPA_END_CMP) {
+		skb = bnge_tpa_end(bn, cpr, &tmp_raw_cons,
+				   (struct rx_tpa_end_cmp *)rxcmp,
+				   (struct rx_tpa_end_cmp_ext *)rxcmp1, event);
+		rc = -ENOMEM;
+		if (likely(skb)) {
+			bnge_deliver_skb(bn, bnapi, skb);
+			rc = 1;
+		}
+		*event |= BNGE_RX_EVENT;
+		goto next_rx_no_prod_no_len;
+	}
+
 	cons = rxcmp->rx_cmp_opaque;
 	if (unlikely(cons != rxr->rx_next_cons)) {
 		int rc1 = bnge_discard_rx(bn, cpr, &tmp_raw_cons, rxcmp);
@@ -477,7 +885,8 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
 		bnge_reuse_rx_data(rxr, cons, data);
 		if (agg_bufs)
-			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs);
+			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs,
+					       false);
 		rc = -EIO;
 		goto next_rx_no_len;
 	}
@@ -495,13 +904,14 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 
 	if (!skb) {
 		if (agg_bufs)
-			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs);
+			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0,
+					       agg_bufs,false);
 		goto oom_next_rx;
 	}
 
 	if (agg_bufs) {
 		skb = bnge_rx_agg_netmems_skb(bn, cpr, skb, cp_cons,
-					      agg_bufs);
+					      agg_bufs, false);
 		if (!skb)
 			goto oom_next_rx;
 	}
@@ -592,6 +1002,12 @@ static int bnge_force_rx_discard(struct bnge_net *bn,
 	    cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
 		rxcmp1->rx_cmp_cfa_code_errors_v2 |=
 			cpu_to_le32(RX_CMPL_ERRORS_CRC_ERROR);
+	} else if (cmp_type == CMP_TYPE_RX_L2_TPA_END_CMP) {
+		struct rx_tpa_end_cmp_ext *tpa_end1;
+
+		tpa_end1 = (struct rx_tpa_end_cmp_ext *)rxcmp1;
+		tpa_end1->rx_tpa_end_cmp_errors_v2 |=
+			cpu_to_le32(RX_TPA_END_CMP_ERRORS);
 	}
 	rc = bnge_rx_pkt(bn, cpr, raw_cons, event);
 	return rc;
-- 
2.47.3



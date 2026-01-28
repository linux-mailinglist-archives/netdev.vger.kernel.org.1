Return-Path: <netdev+bounces-254417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHIVEBtcemm35QEAu9opvQ
	(envelope-from <netdev+bounces-254417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:57:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EBBA7F8D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81C853018756
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B836337417B;
	Wed, 28 Jan 2026 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DSb8LtrG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29375372B58
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626644; cv=none; b=jrLpsORBzpP5+Gx+ZTDLHyIQSosCpRYttCccpBQ9NPMgR3yIBJtBlJ8jvy13/8Iyo5Cv60MUa/XBFLNi7xF4nIxbSKXXlR9yrHWwfgYAPcSultCTp8lIq3+4G4amIcVANEKBGwSzF4O6U4TyhwV4BcSy13wLnmI1G2KFFIobOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626644; c=relaxed/simple;
	bh=mK2FMNivQRKgUq/yMhNB8Gkj0x70D5HHRcCjELHwKtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+XIxY3cDm404hcGEm1faV9ar+LtxV16xhtZwri/s0FldvlvnhJuHXbsL9nMCRj6zTfmZT91qqq2ilExGqxJuEZ2DBqjLCyTRrnJLHxR7sUV1gKmQHu/CLwM/dcYOOxZ1Yk5Ux4tLeRgZ+nqU8c0mNi+KS361BSx+tb5QWifp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DSb8LtrG; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-823081bb15fso69371b3a.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626641; x=1770231441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bY/8sfiCJgs8vKFouKLhV8muyspKbmjqdge49UT5PEs=;
        b=cJB45t2VyNB5UBe4b4l6Wg1CWN+Ul7uNNolgqiylFJtC7F5zIqOkXgrRXpfBVsIbhw
         gJN0DTtQ7TA2arrN40KZRZhzhq8uTfBreswHHu+rEnPSlzjmd1ngxYhzc4+ltcjbkkBK
         zc2j0L68s6d/UfNZyE1Al9nRcqpLkfhpXtWvBRhWDXdGDlJa2zF9tvu4Xd5xSWS7ORVx
         HWI9K3yGJY0I66gVYFv+0hOm0OncZWvCtI6Tt7dErv8mXRBpU/XukBTrRIuYLRQVu76D
         TXgITB0w6fbEKO5KBgYGo/whcYsfhBtxkh9Kk1xEg2t7m4nort4dn4fDfjQt1gdtM2wC
         OlCQ==
X-Gm-Message-State: AOJu0YxnJGRho+skxuoUWGaF3yUmejLHg6kBuDvtOY7suAzMcoQZf2j6
	E8iL5qKX/8WcZmVtwVRN3zh/x4jH8dcGayPsTLaeE7GC+E/MZLRHRITTY67mOD3PGkzK3WiQapH
	Y2qXX0aAtAipzMicKop47Twyr0eOPon5rskD5vzNUHX4jYMh8s7leQwcR1oFddlanCIyM6GGVZ7
	ThQO8+ihBvTdrua+3aqEYIaVIqvltnxsOIOSOpDy0rEGLdpdwpaOnMMwBgcoOb8fIYmXWk9aJ/e
	6HirNvazx4V1EMehg==
X-Gm-Gg: AZuq6aLCj1vWUWVZGsGDnpRZ/9Sq7UTh2tEjFFMVKaolE9S/Yc2rSpIeXhRlth9PlfI
	PZXG2+Ns5g+GYo5h6UfoPzs/PdjkIwOfQCk23kENji+Z+1DfWF2ECIu1sBDsb6C868wg0aQZyx4
	/rYLuSYbGNOzle0WApkgzqB0FkmsL4NPGujQ87/0RCIpTIXEen0S6WStn1V93GLtGca0yJgznnw
	M7WQwLu1HLW6FCovZipHuB5MBl1v6uyvzKSwlubjikeSzRiOmiTrSPhx/mVyt0iWqhpEh96uGx8
	38XX3oeib9jgFf3pwXpNpNAZy78pxsh/BxrVPnAqwusgm5D6BBYGHbr556CIeXmKX6Cie8Pn0WT
	E3HTKkJi5HECuSksUm44R+qFRQOUR8XnK7Rte4K9xRpPY39LxpD8xQoaT1I/Hq/wDHnQL4Bc2cY
	1dIom5P+h/WNlwG3hYZ33D1Pz7QdwaQOD2dSz9RQ65wc5dYwDn
X-Received: by 2002:a05:6a00:8f0c:b0:821:847e:371d with SMTP id d2e1a72fcca58-823692dca5dmr5058380b3a.58.1769626641497;
        Wed, 28 Jan 2026 10:57:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82379b46b08sm346574b3a.4.2026.01.28.10.57.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 10:57:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f42368322so85164b3a.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769626640; x=1770231440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY/8sfiCJgs8vKFouKLhV8muyspKbmjqdge49UT5PEs=;
        b=DSb8LtrGIEsspOm9MU/j8yZaq6jIgugXgOeYYasu+7NY7FpN0glafLpXC56s9pCQHH
         3dgxmE3ONPW7TIHYmkfG6jpyszVpodIwXMo06ukV3LgvKVDt6mRmCRD2ynZfX6IUI3Ur
         Pq0NMqxvzvJrailwLGtqc8CGUhC9tddHGh3uQ=
X-Received: by 2002:a05:6a00:3904:b0:81f:4999:ae46 with SMTP id d2e1a72fcca58-823692c0dc6mr6121649b3a.48.1769626639745;
        Wed, 28 Jan 2026 10:57:19 -0800 (PST)
X-Received: by 2002:a05:6a00:3904:b0:81f:4999:ae46 with SMTP id d2e1a72fcca58-823692c0dc6mr6121628b3a.48.1769626639306;
        Wed, 28 Jan 2026 10:57:19 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22466sm3263536b3a.50.2026.01.28.10.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:57:18 -0800 (PST)
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
Subject: [v7, net-next 3/8] bng_en: Handle an HWRM completion request
Date: Thu, 29 Jan 2026 00:26:18 +0530
Message-ID: <20260128185623.26559-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128185623.26559-1-bhargava.marreddy@broadcom.com>
References: <20260128185623.26559-1-bhargava.marreddy@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-254417-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 00EBBA7F8D
X-Rspamd-Action: no action

Since the HWRM completion for a sent request lands on the NQ,
add functions to handle the HWRM completion event.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  3 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 44 ++++++++++++++++++-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 70d2fbca2a95..500653f085e6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2305,8 +2305,7 @@ static int bnge_open(struct net_device *dev)
 
 static int bnge_shutdown_nic(struct bnge_net *bn)
 {
-	/* TODO: close_path = 0 until we make NAPI functional */
-	bnge_hwrm_resource_free(bn, 0);
+	bnge_hwrm_resource_free(bn, 1);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index ce5e93a50ad8..810b1046f794 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -77,6 +77,7 @@ struct tx_cmp {
 	#define CMPL_BASE_TYPE_HWRM_FWD_REQ			0x22UL
 	#define CMPL_BASE_TYPE_HWRM_FWD_RESP			0x24UL
 	#define CMPL_BASE_TYPE_HWRM_ASYNC_EVENT			0x2eUL
+	#define CMPL_BA_TY_HWRM_ASY_EVT	CMPL_BASE_TYPE_HWRM_ASYNC_EVENT
 	#define TX_CMP_FLAGS_ERROR				(1 << 6)
 	#define TX_CMP_FLAGS_PUSH				(1 << 7)
 	u32 tx_cmp_opaque;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index a8a55e166331..99d9ac80647a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -383,6 +383,43 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
 	}
 }
 
+static void
+bnge_hwrm_update_token(struct bnge_dev *bd, u16 seq_id,
+		       enum bnge_hwrm_wait_state state)
+{
+	struct bnge_hwrm_wait_token *token;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(token, &bd->hwrm_pending_list, node) {
+		if (token->seq_id == seq_id) {
+			WRITE_ONCE(token->state, state);
+			rcu_read_unlock();
+			return;
+		}
+	}
+	rcu_read_unlock();
+	dev_err(bd->dev, "Invalid hwrm seq id %d\n", seq_id);
+}
+
+static int bnge_hwrm_handler(struct bnge_dev *bd, struct tx_cmp *txcmp)
+{
+	struct hwrm_cmpl *h_cmpl = (struct hwrm_cmpl *)txcmp;
+	u16 cmpl_type = TX_CMP_TYPE(txcmp), seq_id;
+
+	switch (cmpl_type) {
+	case CMPL_BASE_TYPE_HWRM_DONE:
+		seq_id = le16_to_cpu(h_cmpl->sequence_id);
+		bnge_hwrm_update_token(bd, seq_id, BNGE_HWRM_COMPLETE);
+		break;
+
+	case CMPL_BASE_TYPE_HWRM_ASYNC_EVENT:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 			    int budget)
 {
@@ -433,8 +470,11 @@ static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 				rx_pkts++;
 			else if (rc == -EBUSY)	/* partial completion */
 				break;
+		} else if (unlikely(cmp_type == CMPL_BASE_TYPE_HWRM_DONE ||
+				    cmp_type == CMPL_BASE_TYPE_HWRM_FWD_REQ ||
+				    cmp_type == CMPL_BA_TY_HWRM_ASY_EVT)) {
+			bnge_hwrm_handler(bn->bd, txcmp);
 		}
-
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 
 		if (rx_pkts && rx_pkts == budget) {
@@ -552,6 +592,8 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
 			work_done += __bnge_poll_work(bn, cpr,
 						      budget - work_done);
 			nqr->has_more_work |= cpr->has_more_work;
+		} else {
+			bnge_hwrm_handler(bn->bd, (struct tx_cmp *)nqcmp);
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	}
-- 
2.47.3



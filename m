Return-Path: <netdev+bounces-252938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNDPNozNc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:35:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C694C7A2F5
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0CB630059B7
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401D29BDA2;
	Fri, 23 Jan 2026 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="del7r0ob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D76258CD0
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196934; cv=none; b=Msfvqw3wkJpaHI9x4/NncolzbGFoF6rkw7ZRsyxly9SVOLXfnEMI9k142drUjdfJ2l4Wt8AJk88IC6k4q3z2Q1qgXWgAOc1T4SX1A+pBrfo0DPwNGmShIgZEZ7yxDXLmxQno0PLCTryXNWm3QshnGHR6EFY679h5y84XBODLJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196934; c=relaxed/simple;
	bh=NSKp7+7796MkKBcTdo3o37PF7/jU1LGtASKoU0av4kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIy0SO+lFlnHm9cM7lVBN7+Uc1OvOqBHUsYvsE7dCztmlVv0bFR5wcSAYXeNUfCNyB5Dp5Bb6H4lTDssidqefZPKOCC2pUsRyre57Y97IINccjalAAujpf/2L4JiWJSpxbCWobBTOjmoXbLzUy28wJ4Z+icyZaX1U0zws+mUJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=del7r0ob; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-78fb5764382so27052557b3.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196931; x=1769801731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdSkCegsAvP47246YGZJCy4msn+ummvP4ChY2ZXTpKs=;
        b=jKu9nmFyZ7TtxKHwO/VB7OShR48TGKRmiUKZ3NKctCLdyK2IEHaNHFxdLaHvpUx0L0
         jr+RBJXS2K/F0qigXuVyjnOjEXgYCWlHiWMkg5FT2oFceWH+bjP8gyCZawOmoVx1OCs9
         k6VqdIggh0eXa6gZALZYYsTnIWX/PhvGcnlA/mv+cb5H3SL49KjdhCMJe7/LmTDPjHXf
         NQs+fG7ZTIgwSypXF32oLRUaJ7CEi2YIpGgucE0zKYuXTZxwW0rTQXD7lvuRHWpFK0So
         dHWbbFMCHpTriovAtS+VkmW1DO1gTbISUb43Q8sNSbW+D+cUhJ3r3CIFNxucnMphO/St
         SnJg==
X-Gm-Message-State: AOJu0YwTIwe5/exwlqavGnfDcRzR8TFJYiK747H9HtYU7QP02mZN48DH
	0zaXAmIOSXL04yxgwNPsrQLl6+2pHmdIwZjcAatCqw341MhyuVG+N5J2xjxp48M+u2rbXNl0lOR
	NEI+GuwvUyfkhaSzy1QPoRybdc1/D4mX9lH0Bazorvy7IQeXiI0DLHjfzyr4rcQs0YMG0pX0An0
	LfTIV3jmjD5tV5/k7IwubcXB0df09DWRMfTg0gtXc5mp97Z3aZvB5aRJ86cVtZCGG4u7IeDrOre
	mLJFYSZA/WKfimGmg==
X-Gm-Gg: AZuq6aIc6VDlAaPigCX0/GDOf9g/J6fGmbgavwEgjvXkvYRqkXVVf07/NHuZlUfq9iu
	jRiLAnWzjU3B4TYab/sHO45lv3rG5HJsdSKpAWJDnxiDlgH2skxmtsMp8ghtVom1FSNKIzehPpv
	U0MW77Qk9K7VamAvzMny8fDc8l/u0iOpX2UCmhPQ3EzwEYhwY2r0MUTzE+CNeQqkqhOYvPMSvYa
	pkjWxMFU9Crox3l8DxYEneOBtILO3oTkK4+pEj5I9hFWuCdFQq3kzlCWyLKIWJMuB9kXspiwnoc
	WfjDxOIL/Bi4E7xANFCb3n3Pi4UhEozBthOuGfMlTJWcl6YVneu2Ueg+42w36cd6AvbXTwJ8KTo
	8OvEuLWTZO4ae79j6Dws27zmKklEV1uk2weLRVJWReikEASRSjRkzDCJAjukQjGumq03uduFsPo
	7MPSwVJ0StvCxEs1/sxxz8bNzTRFadD8wd6UEYOZTDf0S1AQ3+oN4=
X-Received: by 2002:a05:690c:d96:b0:78f:a616:7ba8 with SMTP id 00721157ae682-79440b4d26bmr18944307b3.53.1769196931279;
        Fri, 23 Jan 2026 11:35:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7943b2c8457sm1760637b3.27.2026.01.23.11.35.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:35:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c38781efcso2554689a91.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769196929; x=1769801729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdSkCegsAvP47246YGZJCy4msn+ummvP4ChY2ZXTpKs=;
        b=del7r0obLi6G9P2sLpR54LTLK5E5hxx1igpBDN2CjOop++tgi9fwGnJ+C9j1hyYXQ/
         Lad4jXSbdCNVSU529qw/nFSnw2os4pEvPBiDB1iuR+Khud1GQb3OgOyF7bh1Jw8Z8WoW
         Y0w0lo9+4iJOFj0nIsc8w6J86hjtPxmlD8f8k=
X-Received: by 2002:a17:90b:5145:b0:352:d97d:4bf5 with SMTP id 98e67ed59e1d1-3537af94d91mr1794446a91.27.1769196929560;
        Fri, 23 Jan 2026 11:35:29 -0800 (PST)
X-Received: by 2002:a17:90b:5145:b0:352:d97d:4bf5 with SMTP id 98e67ed59e1d1-3537af94d91mr1794419a91.27.1769196929021;
        Fri, 23 Jan 2026 11:35:29 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e519sm2843206b3a.49.2026.01.23.11.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:35:28 -0800 (PST)
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
Subject: [v6, net-next 3/8] bng_en: Handle an HWRM completion request
Date: Sat, 24 Jan 2026 01:04:59 +0530
Message-ID: <20260123193504.285573-4-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252938-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C694C7A2F5
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
index aef22f77e583..594e83759802 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2303,8 +2303,7 @@ static int bnge_open(struct net_device *dev)
 
 static int bnge_shutdown_nic(struct bnge_net *bn)
 {
-	/* TODO: close_path = 0 until we make NAPI functional */
-	bnge_hwrm_resource_free(bn, 0);
+	bnge_hwrm_resource_free(bn, 1);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 9303305733b4..4cc69b6cf30c 100644
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
index e4312fcad756..5d16adf2315b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -379,6 +379,43 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
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
@@ -429,8 +466,11 @@ static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
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
@@ -548,6 +588,8 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
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



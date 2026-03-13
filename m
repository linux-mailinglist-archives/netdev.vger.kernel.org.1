Return-Path: <netdev+bounces-267489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODpQASEntGkQiQAAu9opvQ
	(envelope-from <netdev+bounces-267489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:02:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B81462857EC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43FCA3014616
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF793AF662;
	Fri, 13 Mar 2026 14:51:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEBE3ACA40
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413481; cv=none; b=sjBMOSV1DGb45j+RUEIbfBywSotWK1XnmcTIv3V8qpoNgoaje0Qc63Va3Cc5dCeo+gYmL0T7SVONipY5M+vvsSHmvdabrcvGSFdbkKeby87yecgXzRGzgucLk0viOsct0JgRWtcekavwDGHJX83/YI3JHvUNIWnZLWYIs9Cn7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413481; c=relaxed/simple;
	bh=M5gnEc11KDkqZuchks/Py1C6vXEkiKaFsRsBBNVZ/Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcupyrdcnARWG2VlJquvtxppugSA+v511vmTk4NfaYioOJfSVo1Q9t2nStQqCGWRwFqHzaHF9Z3Gr8WAgRBCdK4Um6axDGvAKQWPhypwbQW1BBNm6LKMlUGL5XgkBiNQWwNArKT3M9+LedAt652v9x+xhfgNlZ38qEpAO/tzwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2791015eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413479; x=1774018279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/N6mOi7xkb0zTWJlZWJy0zhM/WcNTYapi3I3y4p9TY=;
        b=fAUCRtnte0eu1rjDfqhhod9oxrwJEcsyfkTZoKmGHH35TWLiuBf0I1tO+4IPyOnWRe
         ZpyvM9YNFtqQsSb4I/wUhcnveJSTOmZOF65jdP+d35l+THMFtMUVi89XF/8BSqv5AGIi
         2G1SvIR7ruVxe92m0OXX3nNTnyKmoqHTLVZQdh9l7ZB05NlT1XLdUC8sUoNQxtKaEr/W
         7AFylnWgQCShUUTtmQh4xG1NababSXDEeW3ur90cZ1p5F/CqEK5k/vHd5ZG+JE0wpD11
         eKTPuR1dxmHplwKhkEpB1ESgY343o385MHx9qBtylIwphxJTiSG2bVi3Xv9tHm6wngx8
         1aXA==
X-Gm-Message-State: AOJu0Yz9giLKVGqvyYxELM4mzwf03Pe+DuEeT4cTgrEr1Isgz7ID5Xu2
	9yLlWm6fVbOMU0NFGv9/XwgoN7mB7r/rxu8MLHlcnbxtWepJzii/PlW+6phB
X-Gm-Gg: ATEYQzxiIfIMK3X/LlCYi2ghOSRo4QVpBVAM/sG0lIf1fVv1qq7+NMAelzSqr34jPPM
	OHe2x8QOVjXJrpryj3ZmNLgikc5550WToJbNsUbJgX1o2zPDexUxwlfMsihRIRBvaI+EzXoUy0f
	r3O35icCJBlo19tTTrEHV7lwHq/tnzO5Bpz/GN2hW3njPOK5v4d3nIoVN6hpgMXAfKj6Xl3LS9T
	jcUJ9nvmXRLHLV4gwUKSe3tdhyTdgvZX/6rG/StJ3GbHguTzj2m6EV2gxkMXyOJcz2x0zGyOUGi
	y7eIwJVSp08WurwG/U6mQ5r0/ceAp67YmvhAiFpskj6cTSss+M9A08Xn8KoxVbJquCDUIsgnGb6
	AuM9YHznhZ2l4z6zoIMl9p8PXR18zbjkGzPCVyBRdmE5NdI8WwfkZeSFs00nKMZXmpUamhGY5pi
	5y7tg0x/g/hi6Uh/zGNWgmmgaODupc6W2EaHgggnhwhZ8XiGTeM3avicVp840hOqyp9HhEazHEH
	zRVdQjEBpCu2SLdcw==
X-Received: by 2002:a05:701a:c94e:b0:128:d219:e169 with SMTP id a92af1059eb24-128f3d24bcfmr1692447c88.10.1773413479073;
        Fri, 13 Mar 2026 07:51:19 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63baa3dsm2626947c88.15.2026.03.13.07.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:51:18 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com
Subject: [PATCH net-next 04/11] fbnic: convert to ndo_set_rx_mode_async
Date: Fri, 13 Mar 2026 07:51:06 -0700
Message-ID: <20260313145113.1424442-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313145113.1424442-1-sdf@fomichev.me>
References: <20260313145113.1424442-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267489-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: B81462857EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert fbnic from ndo_set_rx_mode to ndo_set_rx_mode_async. The
driver's __fbnic_set_rx_mode() now takes explicit uc/mc list
parameters and uses __hw_addr_sync_dev() on the snapshots instead
of __dev_uc_sync/__dev_mc_sync on the netdev directly.

Update callers in fbnic_up, fbnic_fw_config_after_crash,
fbnic_bmc_rpc_check and fbnic_set_mac to pass the real address
lists calling __fbnic_set_rx_mode outside the async work path.

Cc: Alexander Duyck <alexanderduyck@fb.com>
Cc: kernel-team@meta.com
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 20 ++++++++++++-------
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  4 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  4 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  2 +-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index b4b396ca9bce..c406a3b56b37 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -183,7 +183,9 @@ static int fbnic_mc_unsync(struct net_device *netdev, const unsigned char *addr)
 	return ret;
 }
 
-void __fbnic_set_rx_mode(struct fbnic_dev *fbd)
+void __fbnic_set_rx_mode(struct fbnic_dev *fbd,
+			 struct netdev_hw_addr_list *uc,
+			 struct netdev_hw_addr_list *mc)
 {
 	bool uc_promisc = false, mc_promisc = false;
 	struct net_device *netdev = fbd->netdev;
@@ -213,10 +215,10 @@ void __fbnic_set_rx_mode(struct fbnic_dev *fbd)
 	}
 
 	/* Synchronize unicast and multicast address lists */
-	err = __dev_uc_sync(netdev, fbnic_uc_sync, fbnic_uc_unsync);
+	err = __hw_addr_sync_dev(uc, netdev, fbnic_uc_sync, fbnic_uc_unsync);
 	if (err == -ENOSPC)
 		uc_promisc = true;
-	err = __dev_mc_sync(netdev, fbnic_mc_sync, fbnic_mc_unsync);
+	err = __hw_addr_sync_dev(mc, netdev, fbnic_mc_sync, fbnic_mc_unsync);
 	if (err == -ENOSPC)
 		mc_promisc = true;
 
@@ -238,18 +240,21 @@ void __fbnic_set_rx_mode(struct fbnic_dev *fbd)
 	fbnic_write_tce_tcam(fbd);
 }
 
-static void fbnic_set_rx_mode(struct net_device *netdev)
+static void fbnic_set_rx_mode(struct net_device *netdev,
+			      struct netdev_hw_addr_list *uc,
+			      struct netdev_hw_addr_list *mc)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_dev *fbd = fbn->fbd;
 
 	/* No need to update the hardware if we are not running */
 	if (netif_running(netdev))
-		__fbnic_set_rx_mode(fbd);
+		__fbnic_set_rx_mode(fbd, uc, mc);
 }
 
 static int fbnic_set_mac(struct net_device *netdev, void *p)
 {
+	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct sockaddr *addr = p;
 
 	if (!is_valid_ether_addr(addr->sa_data))
@@ -257,7 +262,8 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
 
 	eth_hw_addr_set(netdev, addr->sa_data);
 
-	fbnic_set_rx_mode(netdev);
+	if (netif_running(netdev))
+		__fbnic_set_rx_mode(fbn->fbd, &netdev->uc, &netdev->mc);
 
 	return 0;
 }
@@ -551,7 +557,7 @@ static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_features_check	= fbnic_features_check,
 	.ndo_set_mac_address	= fbnic_set_mac,
 	.ndo_change_mtu		= fbnic_change_mtu,
-	.ndo_set_rx_mode	= fbnic_set_rx_mode,
+	.ndo_set_rx_mode_async	= fbnic_set_rx_mode,
 	.ndo_get_stats64	= fbnic_get_stats64,
 	.ndo_bpf		= fbnic_bpf,
 	.ndo_hwtstamp_get	= fbnic_hwtstamp_get,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 9129a658f8fa..eded20b0e9e4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -97,7 +97,9 @@ void fbnic_time_init(struct fbnic_net *fbn);
 int fbnic_time_start(struct fbnic_net *fbn);
 void fbnic_time_stop(struct fbnic_net *fbn);
 
-void __fbnic_set_rx_mode(struct fbnic_dev *fbd);
+void __fbnic_set_rx_mode(struct fbnic_dev *fbd,
+			 struct netdev_hw_addr_list *uc,
+			 struct netdev_hw_addr_list *mc);
 void fbnic_clear_rx_mode(struct fbnic_dev *fbd);
 
 void fbnic_phylink_get_pauseparam(struct net_device *netdev,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index e3aebbe3656d..6b139cf54256 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -135,7 +135,7 @@ void fbnic_up(struct fbnic_net *fbn)
 
 	fbnic_rss_reinit_hw(fbn->fbd, fbn);
 
-	__fbnic_set_rx_mode(fbn->fbd);
+	__fbnic_set_rx_mode(fbn->fbd, &fbn->netdev->uc, &fbn->netdev->mc);
 
 	/* Enable Tx/Rx processing */
 	fbnic_napi_enable(fbn);
@@ -180,7 +180,7 @@ static int fbnic_fw_config_after_crash(struct fbnic_dev *fbd)
 	}
 
 	fbnic_rpc_reset_valid_entries(fbd);
-	__fbnic_set_rx_mode(fbd);
+	__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index 42a186db43ea..fe95b6f69646 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -244,7 +244,7 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 
 	if (fbd->fw_cap.need_bmc_tcam_reinit) {
 		fbnic_bmc_rpc_init(fbd);
-		__fbnic_set_rx_mode(fbd);
+		__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
 		fbd->fw_cap.need_bmc_tcam_reinit = false;
 	}
 
-- 
2.53.0



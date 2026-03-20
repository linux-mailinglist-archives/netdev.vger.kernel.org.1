Return-Path: <netdev+bounces-269742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDe2K9qivGkI1wIAu9opvQ
	(envelope-from <netdev+bounces-269742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:28:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3842D4C1B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B39FF30D6575
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0F72EC562;
	Fri, 20 Mar 2026 01:25:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD52DECCB
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969913; cv=none; b=oDi2BpofjGDA4+uxHJaYj0t9/H77U1U4W3In56TCVZdNvSsRaTZRxVGZ6UJ5VKJf41kVFptgbZgYvUqNdKr7oiW0Y+1XJQQGlhgIu8Chmevyqm0dNl3IH+60d5U1APZ85kZmXTkHfu43e88CXvx2plfkg5MxatKzaWn+P7lpsHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969913; c=relaxed/simple;
	bh=tlKgbNIWgXjZ/slb5MPH0/mHqdsJA6vJ0LluTcLD1PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2MKgMMbY3PkqHzWcZpUPcGOEjUzPbrOqCQLKlMsxKSQNfJ65z7fbEumXFhCimBM05xTOz/GLR4Fd7j6bqo71dFJanQO1L3bM/V9PgsFxN5oarUrJVhU+pi5++cw//gYEIN5iUfwVDNbqWJOnYQUbSfEQXbMqjJ61whWFjJI970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128b9b7e3edso2688301c88.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969909; x=1774574709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IJxOxbLkNxTNWsN6hAmdg1mKxCY8QyUuCBIp5EpuSIA=;
        b=LfW99ygoHP+lzbAU9WB3Xa9atirZkATnKMBCMvvUCdWNRbnTruMTearN2bCbCoxEZK
         bHVXZFORrJggvZgdyXQiy1Haa/K5xjziI2uWGLIdBeS/Oo9NytuM6HYj7beSUcxJKaDK
         gNjgyrHwQ5B2OFtADNPTv0s0/o8wY1Ce31J/j05Rg4vdy/M78QqtQ3qGdICSZRPPpq9q
         Y2DqgCsPymNnZwlO+El1pL8Vj5dGeiSlfex9ViKp2aUwFIn1TTH0tuPJxgcBl/TdLU16
         aqvk1fB6m4F442vG0vB2lf1cEsD3tfUwcsDm8oQLyMlB4Etam/iiDXke/5vposBgnNIt
         M2GA==
X-Gm-Message-State: AOJu0Yze80HnNLHELWYod3W0iCk0OOO8Brm4oZiU6YSD9Y9nnt0PUdL4
	/e/ELLlmjLzdoZAOIRz95dH1u1wamNSe69OVK7Mzc6SPjjm2oDK8KZtXouOH
X-Gm-Gg: ATEYQzwReh5UMAjafIWw2QHYwIs2cB2GrgXTKZjcfx8nj2RSOUh5GFx06Oe9ROn5+wW
	lTuBqIXhk94BVbLuPKrkyLzoxIA4EAmz3XLBh1Wd46JjkSSLe4dxaVmuKLjCgdNBjn3U3AShbr2
	DNsN6I9l9iA1m6muiSItXX2M+XOtIF+Xspwp6qE7zNMfx4pPICV1kpzQwxUvAgJI+ng9kc3N4Ul
	9KExwG/QDduRQXn0M28vVEoSYWAxItZ3cFMiFzbP5REfFN3mZtwl5weSFOTHY7N/bp6JWFRFiwJ
	z8wuVVDIe19cEfU4drFLCX+VjYzeiiwzkIDzthtemifsSVaFtk4WdCDVi+GbYnvmuBnadQUo+JO
	0eRg1iGZvyugOx+AWtA+X3eJ6sarWq5AS8IVzogoGrYQwH8r1ZouQNjeGOxS2p+in2BWusaN7IE
	srr9vq6xfUMEWMOEOCaVhirJ4+XCMaKZLjMkoR2Tb+93AubiCnoQCRrCtB+xPUP0/r2GumVfbse
	N/BlrT4sXIJKw2LNg==
X-Received: by 2002:a05:7022:fa1:b0:123:2d38:929a with SMTP id a92af1059eb24-12a726f86c3mr611130c88.38.1773969909296;
        Thu, 19 Mar 2026 18:25:09 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17a7c1sm1191627eec.7.2026.03.19.18.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:08 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	aleksandr.loktionov@intel.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 05/13] fbnic: convert to ndo_set_rx_mode_async
Date: Thu, 19 Mar 2026 18:24:53 -0700
Message-ID: <20260320012501.2033548-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269742-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.122];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,fb.com:email,fomichev.me:email,fomichev.me:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 5A3842D4C1B
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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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



Return-Path: <netdev+bounces-254538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJzUK3TbemlE/AEAu9opvQ
	(envelope-from <netdev+bounces-254538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:00:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B14BAB8DE
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4751301D30B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAE1A3178;
	Thu, 29 Jan 2026 04:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="SiCR0GOu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594612E40B
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 04:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769659247; cv=none; b=SslfphTi7QwZOTmBpv0o1KNELXMya6m4EH4TgEPGWCyhM1FRZoSw2tdWR7Cb+NcNCYMVvzYpjm9V7JKELeLWixkGJl0gDjnthxtpwFwtj/k1HoKiAJqXHA+WNf1xTocARktnSfgJfGNu3k8nFH44xKbChhtuxtHMZzhMFWUkakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769659247; c=relaxed/simple;
	bh=rzaxSdtqzDXfWysjmOOD8rn5zx0atH7wn6hro0V9WpM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AlHgn8e5j3vi/b/mY4gejV0kwwlT4cfNwOhhcjpv40MRQP3KwEaWzCyt21zZA3g8GpwtDqsO3JRqiPqTa920FDAn1dvBqLYFjdDxx6IW0UbLKmIgnrOzjd5Yu1ZIg+kUUPkEzAfXotIqKhs+v9KUNJvvoA5sxdKH5qdVwjFrn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=SiCR0GOu; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 875CB3F7D8
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 04:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1769659242;
	bh=USqOveOYsJXn+ZSyuAuAAWc+4m7dnuwhvblWv/bFrO4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SiCR0GOue4EHCu9tX0T/alnJklK+LfYP7zBQFkYJRssflqagN32kfSyeSo3Hsgv4H
	 Ali/pgIlCLW/6MKZMgIVvLynLeaQ7yLw0u2Gzj9RChbNVA0PvB0b278qTFvsZredPa
	 eYdL73XLEddpV8YxaIIZPK8EIj1+YksLlBIpBVLhBAXTWdvOyLgaE5vSanISdnZWJE
	 CQks6Yfbg2HlUlJ1VuhS0pS/43y4q+bfJ0qLipB8KBy2sYmkhxjQeYfGehAXy9bXg6
	 k1xy6XrcuMQMRhscElJYCiK4jXk61jdlgTmVdQuZcf446OvbqyxfoQQ0jKPN9+rSPT
	 SY0MUbbrzJ2TXnjBa02wuZEKuqfL7XFForq5yCaWGWxWFrS72KonqGp0KE0uocgLWr
	 07CyRYa49otoMzC4H7ri1c8zJ748TLEoA7cidiNmuHB7vJnVbYCSsQ4Dbh0FIu2rzb
	 G3DYzNk94vO6vsQtY9FXuw536zXVzee4hgZYn7NNGznahlXZZ4yMV+0wr1PLIPnE6a
	 9NsXkkw2ECbspiH/wNxVNZxBSLjpkuckXYg9GOP7tB4HmtSQeUHh6I6MevrO+KLFCw
	 fYl9pwJI8prKHHZXvLHg3tMw6stNPd4mWYfRYXKuGBVqSD83y54HhBZubrj+/+cmPJ
	 fQMyvUaPaI5n2x0PIJfdraMM=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so726794a91.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 20:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769659241; x=1770264041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USqOveOYsJXn+ZSyuAuAAWc+4m7dnuwhvblWv/bFrO4=;
        b=YfXuc69CXmNOXh0E7M7iK84qXEnb/M7bxnepLTIOgnh9wcB9Nc1R64ZTMVrMhkNO9O
         6DZk1d6Iz9CfTOcL3Ipcwbd/K0lI9d4FviSupccecabpj2TTWfqe2H5jchSwjJC4Jsya
         CYMELVpgopyNKW96Pe9rSgxf42/w8DdWx2g54FBwLtrPPRGOEI5t6KVsnOZ9p5sn/F1h
         76XtWWo2YQ7DbIESOS1lxpCx6W4TucwLW3TtvmTkPmvXPZ9kycW5DdIOAIMT+DMczI7s
         f9bjSbDGQh27e4IzZn5rZcrMmOkAO7iJguv2y5FHSI1nUjFmN13zoT37m6MM5H+y8A8k
         xG4w==
X-Forwarded-Encrypted: i=1; AJvYcCVEKR77H0lCUv/kXsNIGeSJcYolaeAnBCSFVxmlKsXlGUSbn99GPU+jEJmqcZ9jBqRMKtb0n6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD6pjOMAfjgrHT6hTh5mieZVFUzJcymb7MdQrqe8d0QcLIhg3n
	SjtPpB5WshMi9waf/1+pVdUqMyVjNy3J4dSd0H/sVTZhkIJWae1CXsNpT0ewkbp4QkCMFTzFhbc
	1bu6SHQcAkgKDBYRXeXITJeHHBoSYjY59Uh1dhkQM03+HKKzeyOV+vLlGq0VnjrIgaoI15BwA5w
	==
X-Gm-Gg: AZuq6aJBhJItKrEO0J9GPoxun6RqGZIUreyMICIQ4JDQv8OxFOf0cVO82L5gRANKY6L
	56aKSqqXyAW5U8Gmlvex3B7hYyZ5v9XQTtdU3lGu6MxqYZ1wM2hMWfE0WGPFI7j/DsLJOfuZWFp
	vZUWM1oEALlrk5yoK53OlyyitvHnhYuMjiA0V9xBYH9IgvSnjtyhEZktHotoVVGFLhzW6n8RLVE
	G/9uqCj0Jbt52timNtU/MiGBRe3YyfVNezwr8m/yf87p7yuxS5Tn16QZgWZBXxnNRJlxFeDbf1o
	jdJ9VpFsVWLDZoyJPpWxiVZyNYvCZb87EPXopDNiVWQTD4A85b9qOJY8vwc+Vp4LqNY8hw0V8ED
	0en6MeYO7WADWFWa6j6tTgsv+
X-Received: by 2002:a17:90b:2892:b0:341:194:5e7d with SMTP id 98e67ed59e1d1-353fed74c1fmr6685202a91.24.1769659240755;
        Wed, 28 Jan 2026 20:00:40 -0800 (PST)
X-Received: by 2002:a17:90b:2892:b0:341:194:5e7d with SMTP id 98e67ed59e1d1-353fed74c1fmr6685177a91.24.1769659240343;
        Wed, 28 Jan 2026 20:00:40 -0800 (PST)
Received: from localhost.localdomain ([103.155.100.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6103e9fsm6709121a91.2.2026.01.28.20.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 20:00:39 -0800 (PST)
From: Aaron Ma <aaron.ma@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] ice: recap the VSI and QoS info after rebuild
Date: Thu, 29 Jan 2026 12:00:26 +0800
Message-ID: <20260129040026.832452-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254538-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron.ma@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,canonical.com:dkim,canonical.com:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B14BAB8DE
X-Rspamd-Action: no action

Fix IRDMA hardware initialization timeout (-110) after resume by
separating VSI-dependent configuration from RDMA resource allocation,
ensuring VSI is rebuilt before IRDMA accesses it.

After resume from suspend, IRDMA hardware initialization fails:
  ice: IRDMA hardware initialization FAILED init_state=4 status=-110

Separate RDMA initialization into two phases:
1. ice_init_rdma() - Allocate resources only (no VSI/QoS access, no plug)
2. ice_rdma_finalize_setup() - Assign VSI/QoS info and plug device

This allows:
- ice_init_rdma() to stay in ice_resume() (mirrors ice_deinit_rdma()
  in ice_suspend())
- VSI assignment deferred until after ice_vsi_rebuild() completes
- QoS info updated after ice_dcb_rebuild() completes
- Device plugged only when control queues, VSI, and DCB are all ready

Fixes: bc69ad74867db ("ice: avoid IRQ collision to fix init failure on ACPI S3 resume")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
V1 -> V2: no changes.
V2 -> V3:
- mirrors init_rdma in resume as Tony Nguyen suggested to fix
the memleak and move ice_plug_aux_dev/ice_unplug_aux_dev out of
init/deinit rdma.
- ensure the correct VSI/QoS info is loaded after rebuild.
V3 -> V4:
- Log warning when aux device plug fails.
- Remove incorrect xa_erase() call when xa_alloc() fails.
- Add pf->vsi NULL check.

 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_idc.c  | 44 +++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c |  7 +++-
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 00f75d87c73f9..15a7fcd888b26 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -990,6 +990,7 @@ int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset);
 void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
 int ice_plug_aux_dev(struct ice_pf *pf);
 void ice_unplug_aux_dev(struct ice_pf *pf);
+void ice_rdma_finalize_setup(struct ice_pf *pf);
 int ice_init_rdma(struct ice_pf *pf);
 void ice_deinit_rdma(struct ice_pf *pf);
 bool ice_is_wol_supported(struct ice_hw *hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 420d45c2558b6..d976cb85e4aa4 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -360,6 +360,39 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
 	auxiliary_device_uninit(adev);
 }
 
+/**
+ * ice_rdma_finalize_setup - Complete RDMA setup after VSI is ready
+ * @pf: ptr to ice_pf
+ *
+ * Sets VSI-dependent information and plugs aux device.
+ * Must be called after ice_init_rdma(), ice_vsi_rebuild(), and
+ * ice_dcb_rebuild() complete.
+ */
+void ice_rdma_finalize_setup(struct ice_pf *pf)
+{
+	struct iidc_rdma_priv_dev_info *privd;
+	struct device *dev = ice_pf_to_dev(pf);
+	int ret;
+
+	if (!ice_is_rdma_ena(pf) || !pf->cdev_info)
+		return;
+
+	privd = pf->cdev_info->iidc_priv;
+	if (!privd || !pf->vsi || !pf->vsi[0] || !pf->vsi[0]->netdev)
+		return;
+
+	/* Assign VSI info now that VSI is valid */
+	privd->netdev = pf->vsi[0]->netdev;
+	privd->vport_id = pf->vsi[0]->vsi_num;
+
+	/* Update QoS info after DCB has been rebuilt */
+	ice_setup_dcb_qos_info(pf, &privd->qos_info);
+
+	ret = ice_plug_aux_dev(pf);
+	if (ret)
+		dev_warn(dev, "Failed to plug RDMA aux device: %d\n", ret);
+}
+
 /**
  * ice_init_rdma - initializes PF for RDMA use
  * @pf: ptr to ice_pf
@@ -398,22 +431,14 @@ int ice_init_rdma(struct ice_pf *pf)
 	}
 
 	cdev->iidc_priv = privd;
-	privd->netdev = pf->vsi[0]->netdev;
 
 	privd->hw_addr = (u8 __iomem *)pf->hw.hw_addr;
 	cdev->pdev = pf->pdev;
-	privd->vport_id = pf->vsi[0]->vsi_num;
 
 	pf->cdev_info->rdma_protocol |= IIDC_RDMA_PROTOCOL_ROCEV2;
-	ice_setup_dcb_qos_info(pf, &privd->qos_info);
-	ret = ice_plug_aux_dev(pf);
-	if (ret)
-		goto err_plug_aux_dev;
+
 	return 0;
 
-err_plug_aux_dev:
-	pf->cdev_info->adev = NULL;
-	xa_erase(&ice_aux_id, pf->aux_idx);
 err_alloc_xa:
 	kfree(privd);
 err_privd_alloc:
@@ -432,7 +457,6 @@ void ice_deinit_rdma(struct ice_pf *pf)
 	if (!ice_is_rdma_ena(pf))
 		return;
 
-	ice_unplug_aux_dev(pf);
 	xa_erase(&ice_aux_id, pf->aux_idx);
 	kfree(pf->cdev_info->iidc_priv);
 	kfree(pf->cdev_info);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a511bc28be055..cfd1c3396d851 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5136,6 +5136,9 @@ int ice_load(struct ice_pf *pf)
 	if (err)
 		goto err_init_rdma;
 
+	/* Finalize RDMA: VSI already created, assign info and plug device */
+	ice_rdma_finalize_setup(pf);
+
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5167,6 +5170,7 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
+	ice_unplug_aux_dev(pf);
 	ice_deinit_rdma(pf);
 	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
@@ -5593,6 +5597,7 @@ static int ice_suspend(struct device *dev)
 	 */
 	disabled = ice_service_task_stop(pf);
 
+	ice_unplug_aux_dev(pf);
 	ice_deinit_rdma(pf);
 
 	/* Already suspended?, then there is nothing to do */
@@ -7802,7 +7807,7 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ice_health_clear(pf);
 
-	ice_plug_aux_dev(pf);
+	ice_rdma_finalize_setup(pf);
 	if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
 		ice_lag_rebuild(pf);
 
-- 
2.43.0



Return-Path: <netdev+bounces-272672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GbzJzPoxmloQAUAu9opvQ
	(envelope-from <netdev+bounces-272672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:27:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBBB34AF0B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC4F3088311
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B83BE159;
	Fri, 27 Mar 2026 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ns1Shg7K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32857396D07
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642499; cv=none; b=JFNCBmoHqqvmW+JQH77q21iReAvOngfyXsD029NY6FUZBSgE3xxqmVtXxFF94r7fy+0LRxtrSNxSw8mt6MPqFqDtK8wq2PT2AvcZVXnBEbS32jF98bGdvyuUwTHbBWWCobYipMN40mq+SaCMfvmzZV/E6Vadr1Y1rmKnmk+8vYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642499; c=relaxed/simple;
	bh=iJMMCJu0vxcJB9E3vnuWnrOblwqDeDb1Ka4962J/TfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMPSpXQzfpvByYyot6CT2wajneF/CcIWauChqLtn4urDZVZtjexXoMn4llcIlOPADOMz/jqi0Y3sxU4wXWAiKOkLSebR9xvyqXkNNSbT6cU5w5HXkDANy/NiXJeoCckgWFYYmz4dphMsYcJVNWju8ER2w1vquILBVQ5CnYxZTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ns1Shg7K; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2c160308a54so2538186eec.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642496; x=1775247296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOgjBzHzvs6SoQVE5M2R4r5AWb+xGH8AB/hCraqpUak=;
        b=rpnpmaXGwLVaj3SXrbx2ynlxo9AH3rpMH2HJCiCi/F8lwKKeLhgSfrh6QB/P+WomYY
         jN/hpGgC/Ike6e3Fb0g+BQUonRrmrOqd8ArKzOyfriNWf7mzovp6jxqfdg11ZRAqdU55
         gg0hB61wVHdSLTfAxSSYUaejs3hwvivBXVjBH90GXQZMx4gwcwyXv5KkKtbVHPLZFEtE
         MRa+hFX/YDmfti8LZSR9txc4dQIYvp9Yt5j/YUCOpOsZTSgU4462egYj3mkQQ3Mzdi6H
         YhYd7onLMa8mN42Y/BMt/0KmjLlShEbyAgM2B39dX/ALkBpO7f1dfSDVsIR/VOHqWP1B
         fm6Q==
X-Gm-Message-State: AOJu0YweMB7nnZpuadTUurlXcnecMVBif99B2KAW85lM8JhDo/Y26TcQ
	2kWETdJRVDZqcSVvhMZHiRP05nEhFyQtdenEYkJPO8yCRfD2vRaruSuHKnPH2HSL/kqI3O3yOda
	E4EplwaOBiN51wJuO8qHOTYkgRSSduQgqnIUKIgKYUAcm9WQ3rR5JC/Weq7ZjUu1wgaXzUk+Fp6
	elBLU59bargnJVd6p7C+eDUwiH5NghvTUOZaeUzULEV0RGdoXWkTTHfTMoJMRLucoTPHIQj/SQo
	2JDsrh6qltefbXYHz+5
X-Gm-Gg: ATEYQzzsTL2s/d4QhHKGDZ419p/rp0Ox/SfukMALPBFEBq8zldYMt+cTtgzhaYkfHgA
	KQJTqL1Qu/BImnglLGUSACmObU3u/1Kp1fzfUmprwdE1VTBM9LPd4R1IrSiW9gJ16Q2NREHn5T6
	6Ool54jzQA2nnbeZKGoKSJoFCIEFmIuwHY3HTN2g9yxrbWzDkOoJFv+KuPf4O03fb6k57bjvoYE
	pYhdsF4o7KV47vu49wuWAFoeWE+1CDDoRtL2Civn9w+DDCY8QQLcHLWiUPd21Lcmcw26kyaohjo
	6qVFuOf4yuI9rBd0713ASaAK6UkHuSgQRCmnq2NsVizsBsLPm0kU7OJ0Cj9kPXVZ46BdWcotCRe
	2mBmKLwICNQGPqTSxumvc4WxUg8J8VN6ssiS2LVR1OTui5GoPigM5om0WIZMVRnQJxSQRoMN2DL
	ckrsTkgmTgyoYORUZqL+j9k3r8PiHpzTYlN8vlPLk2/xmEEYdJoqRkVG5cTlxP/Vo=
X-Received: by 2002:a05:693c:630e:b0:2c3:3df3:9992 with SMTP id 5a478bee46e88-2c33df437edmr947580eec.20.1774642496038;
        Fri, 27 Mar 2026 13:14:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2c3c3bda34asm44235eec.2.2026.03.27.13.14.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:14:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79832285fa1so52204737b3.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774642495; x=1775247295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOgjBzHzvs6SoQVE5M2R4r5AWb+xGH8AB/hCraqpUak=;
        b=Ns1Shg7KH+JM/CqhSb1Wttr3bGkzjZBjQPKfg6jVnFiffm0Gbiot3rN8SJ9nDDh1yj
         asTjKNoC9pvmYZxmT9N0u5pXWwbBYklhkiCY2VsHcrihskd+rFlUhA55K/vpWeo1/NpP
         c0q/Y1p27i22ncYFUoNDxgo46vFhSNAb4YQT4=
X-Received: by 2002:a05:690c:6610:b0:79a:b245:f8c4 with SMTP id 00721157ae682-79bde0b42b1mr38630137b3.54.1774642494469;
        Fri, 27 Mar 2026 13:14:54 -0700 (PDT)
X-Received: by 2002:a05:690c:6610:b0:79a:b245:f8c4 with SMTP id 00721157ae682-79bde0b42b1mr38629797b3.54.1774642493923;
        Fri, 27 Mar 2026 13:14:53 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8f324sm119057b3.28.2026.03.27.13.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:14:53 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v10 03/10] bng_en: add ethtool link settings, get_link, and nway_reset
Date: Sat, 28 Mar 2026 01:43:36 +0530
Message-ID: <20260327201343.16146-4-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272672-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0FBBB34AF0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add get/set_link_ksettings, get_link, and nway_reset support.
Report supported, advertised, and link-partner speeds across NRZ,
PAM4, and PAM4-112 signaling modes. Enable lane count reporting.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   2 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   1 +
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  28 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 809 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |   7 +
 5 files changed, 847 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 83ee4749cc70..e9b83c0c64b6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -98,6 +98,8 @@ struct bnge_queue_info {
 #define BNGE_PHY_FL_NO_FCS		PORT_PHY_QCAPS_RESP_FLAGS_NO_FCS
 #define BNGE_PHY_FL_SPEEDS2		\
 	(PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED << 8)
+#define BNGE_PHY_FL_NO_PAUSE		\
+	(PORT_PHY_QCAPS_RESP_FLAGS2_PAUSE_UNSUPPORTED << 8)
 
 struct bnge_dev {
 	struct device	*dev;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index b4090283df0f..1c14c5fe8d61 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -10,6 +10,7 @@
 #include "bnge_devlink.h"
 #include "bnge_hwrm.h"
 #include "bnge_hwrm_lib.h"
+#include "bnge_link.h"
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION(DRV_SUMMARY);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 569371c1b4f2..6bb74a84ea03 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -11,6 +11,29 @@
 
 #include "bnge.h"
 #include "bnge_ethtool.h"
+#include "bnge_hwrm_lib.h"
+
+static int bnge_nway_reset(struct net_device *dev)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	bool set_pause = false;
+	int rc = 0;
+
+	if (!BNGE_PHY_CFG_ABLE(bd))
+		return -EOPNOTSUPP;
+
+	if (!(bn->eth_link_info.autoneg & BNGE_AUTONEG_SPEED))
+		return -EINVAL;
+
+	if (!(bd->phy_flags & BNGE_PHY_FL_NO_PAUSE))
+		set_pause = true;
+
+	if (netif_running(dev))
+		rc = bnge_hwrm_set_link_setting(bn, set_pause);
+
+	return rc;
+}
 
 static void bnge_get_drvinfo(struct net_device *dev,
 			     struct ethtool_drvinfo *info)
@@ -24,7 +47,12 @@ static void bnge_get_drvinfo(struct net_device *dev,
 }
 
 static const struct ethtool_ops bnge_ethtool_ops = {
+	.cap_link_lanes_supported	= 1,
+	.get_link_ksettings	= bnge_get_link_ksettings,
+	.set_link_ksettings	= bnge_set_link_ksettings,
 	.get_drvinfo		= bnge_get_drvinfo,
+	.get_link		= bnge_get_link,
+	.nway_reset		= bnge_nway_reset,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
index 80211697e3c3..af2f4466a199 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -7,6 +7,51 @@
 #include "bnge_link.h"
 #include "bnge_hwrm_lib.h"
 
+enum bnge_media_type {
+	BNGE_MEDIA_UNKNOWN = 0,
+	BNGE_MEDIA_CR,
+	BNGE_MEDIA_SR,
+	BNGE_MEDIA_LR_ER_FR,
+	BNGE_MEDIA_KR,
+	__BNGE_MEDIA_END,
+};
+
+static const enum bnge_media_type bnge_phy_types[] = {
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR4] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR4] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR4] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER4] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR10] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASECR4] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASESR4] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASELR4] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASEER4] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASECR] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASESR] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASELR] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASEER] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR2] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR2] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR2] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER2] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASECR2] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASESR2] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASELR2] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASEER2] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASECR8] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASESR8] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASELR8] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER8] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASECR4] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASESR4] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASELR4] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER4] = BNGE_MEDIA_LR_ER_FR,
+};
+
 static u32 bnge_fw_to_ethtool_speed(u16 fw_link_speed)
 {
 	switch (fw_link_speed) {
@@ -341,6 +386,19 @@ void bnge_get_port_module_status(struct bnge_net *bn)
 	}
 }
 
+static void bnge_set_default_adv_speeds(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info = &bn->bd->link_info;
+
+	if (bn->bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		elink_info->advertising = link_info->support_auto_speeds2;
+		return;
+	}
+	elink_info->advertising = link_info->support_auto_speeds;
+	elink_info->advertising_pam4 = link_info->support_pam4_auto_speeds;
+}
+
 static bool bnge_support_dropped(u16 advertising, u16 supported)
 {
 	return (advertising & ~supported) != 0;
@@ -464,3 +522,754 @@ void bnge_report_link(struct bnge_dev *bd)
 		netdev_info(bd->netdev, "NIC Link is Down\n");
 	}
 }
+
+static void bnge_get_ethtool_modes(struct bnge_net *bn,
+				   struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnge_ethtool_link_info *elink_info;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+
+	elink_info = &bn->eth_link_info;
+	link_info = &bd->link_info;
+
+	if (!(bd->phy_flags & BNGE_PHY_FL_NO_PAUSE)) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 lk_ksettings->link_modes.supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 lk_ksettings->link_modes.supported);
+	}
+
+	if (link_info->support_auto_speeds || link_info->support_auto_speeds2 ||
+	    link_info->support_pam4_auto_speeds)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 lk_ksettings->link_modes.supported);
+
+	if (~elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL)
+		return;
+
+	if (link_info->auto_pause_setting & BNGE_LINK_PAUSE_RX)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 lk_ksettings->link_modes.advertising);
+	if (hweight8(link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH) == 1)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 lk_ksettings->link_modes.advertising);
+	if (link_info->lp_pause & BNGE_LINK_PAUSE_RX)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 lk_ksettings->link_modes.lp_advertising);
+	if (hweight8(link_info->lp_pause & BNGE_LINK_PAUSE_BOTH) == 1)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 lk_ksettings->link_modes.lp_advertising);
+}
+
+u32 bnge_get_link(struct net_device *dev)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+
+	return BNGE_LINK_IS_UP(bn->bd);
+}
+
+static enum bnge_media_type
+bnge_get_media(struct bnge_link_info *link_info)
+{
+	switch (link_info->media_type) {
+	case PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC:
+		return BNGE_MEDIA_CR;
+	default:
+		if (link_info->phy_type < ARRAY_SIZE(bnge_phy_types))
+			return bnge_phy_types[link_info->phy_type];
+		return BNGE_MEDIA_UNKNOWN;
+	}
+}
+
+enum bnge_link_speed_indices {
+	BNGE_LINK_SPEED_UNKNOWN = 0,
+	BNGE_LINK_SPEED_50GB_IDX,
+	BNGE_LINK_SPEED_100GB_IDX,
+	BNGE_LINK_SPEED_200GB_IDX,
+	BNGE_LINK_SPEED_400GB_IDX,
+	BNGE_LINK_SPEED_800GB_IDX,
+	__BNGE_LINK_SPEED_END
+};
+
+static enum bnge_link_speed_indices bnge_fw_speed_idx(u16 speed)
+{
+	switch (speed) {
+	case BNGE_LINK_SPEED_50GB:
+	case BNGE_LINK_SPEED_50GB_PAM4:
+		return BNGE_LINK_SPEED_50GB_IDX;
+	case BNGE_LINK_SPEED_100GB:
+	case BNGE_LINK_SPEED_100GB_PAM4:
+	case BNGE_LINK_SPEED_100GB_PAM4_112:
+		return BNGE_LINK_SPEED_100GB_IDX;
+	case BNGE_LINK_SPEED_200GB:
+	case BNGE_LINK_SPEED_200GB_PAM4:
+	case BNGE_LINK_SPEED_200GB_PAM4_112:
+		return BNGE_LINK_SPEED_200GB_IDX;
+	case BNGE_LINK_SPEED_400GB:
+	case BNGE_LINK_SPEED_400GB_PAM4:
+	case BNGE_LINK_SPEED_400GB_PAM4_112:
+		return BNGE_LINK_SPEED_400GB_IDX;
+	case BNGE_LINK_SPEED_800GB:
+	case BNGE_LINK_SPEED_800GB_PAM4_112:
+		return BNGE_LINK_SPEED_800GB_IDX;
+	default:
+		return BNGE_LINK_SPEED_UNKNOWN;
+	}
+}
+
+/* Compile-time link mode mapping table.
+ * Indexed by [speed_idx][sig_mode][media].
+ */
+#define BNGE_LINK_M(speed, sig, media, lm)	\
+	[BNGE_LINK_SPEED_##speed##_IDX]	\
+	[BNGE_SIG_MODE_##sig]		\
+	[BNGE_MEDIA_##media] = ETHTOOL_LINK_MODE_##lm##_Full_BIT
+
+static const enum ethtool_link_mode_bit_indices
+bnge_link_modes[__BNGE_LINK_SPEED_END]
+	       [BNGE_SIG_MODE_MAX]
+	       [__BNGE_MEDIA_END] = {
+	/* 50GB PAM4 */
+	BNGE_LINK_M(50GB,  PAM4, CR,        50000baseCR),
+	BNGE_LINK_M(50GB,  PAM4, SR,        50000baseSR),
+	BNGE_LINK_M(50GB,  PAM4, LR_ER_FR,  50000baseLR_ER_FR),
+	BNGE_LINK_M(50GB,  PAM4, KR,        50000baseKR),
+
+	/* 100GB NRZ */
+	BNGE_LINK_M(100GB, NRZ,  CR,        100000baseCR4),
+	BNGE_LINK_M(100GB, NRZ,  SR,        100000baseSR4),
+	BNGE_LINK_M(100GB, NRZ,  LR_ER_FR,  100000baseLR4_ER4),
+	BNGE_LINK_M(100GB, NRZ,  KR,        100000baseKR4),
+
+	/* 100GB PAM4 */
+	BNGE_LINK_M(100GB, PAM4, CR,        100000baseCR2),
+	BNGE_LINK_M(100GB, PAM4, SR,        100000baseSR2),
+	BNGE_LINK_M(100GB, PAM4, LR_ER_FR,  100000baseLR2_ER2_FR2),
+	BNGE_LINK_M(100GB, PAM4, KR,        100000baseKR2),
+
+	/* 100GB PAM4_112 */
+	BNGE_LINK_M(100GB, PAM4_112, CR,        100000baseCR),
+	BNGE_LINK_M(100GB, PAM4_112, SR,        100000baseSR),
+	BNGE_LINK_M(100GB, PAM4_112, LR_ER_FR,  100000baseLR_ER_FR),
+	BNGE_LINK_M(100GB, PAM4_112, KR,        100000baseKR),
+
+	/* 200GB PAM4 */
+	BNGE_LINK_M(200GB, PAM4, CR,        200000baseCR4),
+	BNGE_LINK_M(200GB, PAM4, SR,        200000baseSR4),
+	BNGE_LINK_M(200GB, PAM4, LR_ER_FR,  200000baseLR4_ER4_FR4),
+	BNGE_LINK_M(200GB, PAM4, KR,        200000baseKR4),
+
+	/* 200GB PAM4_112 */
+	BNGE_LINK_M(200GB, PAM4_112, CR,        200000baseCR2),
+	BNGE_LINK_M(200GB, PAM4_112, SR,        200000baseSR2),
+	BNGE_LINK_M(200GB, PAM4_112, LR_ER_FR,  200000baseLR2_ER2_FR2),
+	BNGE_LINK_M(200GB, PAM4_112, KR,        200000baseKR2),
+
+	/* 400GB PAM4 */
+	BNGE_LINK_M(400GB, PAM4, CR,        400000baseCR8),
+	BNGE_LINK_M(400GB, PAM4, SR,        400000baseSR8),
+	BNGE_LINK_M(400GB, PAM4, LR_ER_FR,  400000baseLR8_ER8_FR8),
+	BNGE_LINK_M(400GB, PAM4, KR,        400000baseKR8),
+
+	/* 400GB PAM4_112 */
+	BNGE_LINK_M(400GB, PAM4_112, CR,        400000baseCR4),
+	BNGE_LINK_M(400GB, PAM4_112, SR,        400000baseSR4),
+	BNGE_LINK_M(400GB, PAM4_112, LR_ER_FR,  400000baseLR4_ER4_FR4),
+	BNGE_LINK_M(400GB, PAM4_112, KR,        400000baseKR4),
+
+	/* 800GB PAM4_112 */
+	BNGE_LINK_M(800GB, PAM4_112, CR,        800000baseCR8),
+	BNGE_LINK_M(800GB, PAM4_112, SR,        800000baseSR8),
+	BNGE_LINK_M(800GB, PAM4_112, KR,        800000baseKR8),
+};
+
+#define BNGE_LINK_MODE_UNKNOWN -1
+
+static enum ethtool_link_mode_bit_indices
+bnge_get_link_mode(struct bnge_net *bn)
+{
+	enum ethtool_link_mode_bit_indices link_mode;
+	struct bnge_ethtool_link_info *elink_info;
+	enum bnge_link_speed_indices speed;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+	enum bnge_media_type media;
+	u8 sig_mode;
+
+	elink_info = &bn->eth_link_info;
+	link_info = &bd->link_info;
+
+	if (link_info->phy_link_status != BNGE_LINK_LINK)
+		return BNGE_LINK_MODE_UNKNOWN;
+
+	media = bnge_get_media(link_info);
+	if (BNGE_AUTO_MODE(link_info->auto_mode)) {
+		speed = bnge_fw_speed_idx(link_info->link_speed);
+		sig_mode = link_info->active_fec_sig_mode &
+			PORT_PHY_QCFG_RESP_SIGNAL_MODE_MASK;
+	} else {
+		speed = bnge_fw_speed_idx(elink_info->req_link_speed);
+		sig_mode = elink_info->req_signal_mode;
+	}
+	if (sig_mode >= BNGE_SIG_MODE_MAX)
+		return BNGE_LINK_MODE_UNKNOWN;
+
+	/* Since ETHTOOL_LINK_MODE_10baseT_Half_BIT is defined as 0 and
+	 * not actually supported, the zeroes in this map can be safely
+	 * used to represent unknown link modes.
+	 */
+	link_mode = bnge_link_modes[speed][sig_mode][media];
+	if (!link_mode)
+		return BNGE_LINK_MODE_UNKNOWN;
+
+	return link_mode;
+}
+
+static const u16 bnge_nrz_speed_masks[__BNGE_LINK_SPEED_END] = {
+	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEED_MSK_100GB,
+};
+
+static const u16 bnge_pam4_speed_masks[__BNGE_LINK_SPEED_END] = {
+	[BNGE_LINK_SPEED_50GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_50GB,
+	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_100GB,
+	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_200GB,
+};
+
+static const u16 bnge_nrz_speeds2_masks[__BNGE_LINK_SPEED_END] = {
+	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB,
+};
+
+static const u16 bnge_pam4_speeds2_masks[__BNGE_LINK_SPEED_END] = {
+	[BNGE_LINK_SPEED_50GB_IDX] = BNGE_LINK_SPEEDS2_MSK_50GB_PAM4,
+	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB_PAM4,
+	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_SPEEDS2_MSK_200GB_PAM4,
+	[BNGE_LINK_SPEED_400GB_IDX] = BNGE_LINK_SPEEDS2_MSK_400GB_PAM4,
+};
+
+static const u16 bnge_pam4_112_speeds2_masks[__BNGE_LINK_SPEED_END] = {
+	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB_PAM4_112,
+	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_SPEEDS2_MSK_200GB_PAM4_112,
+	[BNGE_LINK_SPEED_400GB_IDX] = BNGE_LINK_SPEEDS2_MSK_400GB_PAM4_112,
+	[BNGE_LINK_SPEED_800GB_IDX] = BNGE_LINK_SPEEDS2_MSK_800GB_PAM4_112,
+};
+
+static enum bnge_link_speed_indices
+bnge_encoding_speed_idx(u8 sig_mode, u32 phy_flags, u16 speed_msk)
+{
+	const u16 *speeds;
+	int idx, len;
+
+	switch (sig_mode) {
+	case BNGE_SIG_MODE_NRZ:
+		if (phy_flags & BNGE_PHY_FL_SPEEDS2) {
+			speeds = bnge_nrz_speeds2_masks;
+			len = ARRAY_SIZE(bnge_nrz_speeds2_masks);
+		} else {
+			speeds = bnge_nrz_speed_masks;
+			len = ARRAY_SIZE(bnge_nrz_speed_masks);
+		}
+		break;
+	case BNGE_SIG_MODE_PAM4:
+		if (phy_flags & BNGE_PHY_FL_SPEEDS2) {
+			speeds = bnge_pam4_speeds2_masks;
+			len = ARRAY_SIZE(bnge_pam4_speeds2_masks);
+		} else {
+			speeds = bnge_pam4_speed_masks;
+			len = ARRAY_SIZE(bnge_pam4_speed_masks);
+		}
+		break;
+	case BNGE_SIG_MODE_PAM4_112:
+		speeds = bnge_pam4_112_speeds2_masks;
+		len = ARRAY_SIZE(bnge_pam4_112_speeds2_masks);
+		break;
+	default:
+		return BNGE_LINK_SPEED_UNKNOWN;
+	}
+
+	for (idx = 0; idx < len; idx++) {
+		if (speeds[idx] == speed_msk)
+			return idx;
+	}
+
+	return BNGE_LINK_SPEED_UNKNOWN;
+}
+
+#define BNGE_FW_SPEED_MSK_BITS 16
+
+static void
+__bnge_get_ethtool_speeds(unsigned long fw_mask, enum bnge_media_type media,
+			  u8 sig_mode, u32 phy_flags, unsigned long *et_mask)
+{
+	enum ethtool_link_mode_bit_indices link_mode;
+	enum bnge_link_speed_indices speed;
+	u8 bit;
+
+	for_each_set_bit(bit, &fw_mask, BNGE_FW_SPEED_MSK_BITS) {
+		speed = bnge_encoding_speed_idx(sig_mode, phy_flags, 1 << bit);
+		if (!speed)
+			continue;
+
+		link_mode = bnge_link_modes[speed][sig_mode][media];
+		if (!link_mode)
+			continue;
+
+		linkmode_set_bit(link_mode, et_mask);
+	}
+}
+
+static void
+bnge_get_ethtool_speeds(unsigned long fw_mask, enum bnge_media_type media,
+			u8 sig_mode, u32 phy_flags, unsigned long *et_mask)
+{
+	if (media) {
+		__bnge_get_ethtool_speeds(fw_mask, media, sig_mode, phy_flags,
+					  et_mask);
+		return;
+	}
+
+	/* list speeds for all media if unknown */
+	for (media = 1; media < __BNGE_MEDIA_END; media++)
+		__bnge_get_ethtool_speeds(fw_mask, media, sig_mode, phy_flags,
+					  et_mask);
+}
+
+static void
+bnge_get_all_ethtool_support_speeds(struct bnge_dev *bd,
+				    enum bnge_media_type media,
+				    struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnge_link_info *link_info = &bd->link_info;
+	u16 sp_nrz, sp_pam4, sp_pam4_112 = 0;
+	u32 phy_flags = bd->phy_flags;
+
+	if (phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		sp_nrz = link_info->support_speeds2;
+		sp_pam4 = link_info->support_speeds2;
+		sp_pam4_112 = link_info->support_speeds2;
+	} else {
+		sp_nrz = link_info->support_speeds;
+		sp_pam4 = link_info->support_pam4_speeds;
+	}
+	bnge_get_ethtool_speeds(sp_nrz, media, BNGE_SIG_MODE_NRZ, phy_flags,
+				lk_ksettings->link_modes.supported);
+	bnge_get_ethtool_speeds(sp_pam4, media, BNGE_SIG_MODE_PAM4, phy_flags,
+				lk_ksettings->link_modes.supported);
+	bnge_get_ethtool_speeds(sp_pam4_112, media, BNGE_SIG_MODE_PAM4_112,
+				phy_flags, lk_ksettings->link_modes.supported);
+}
+
+static void
+bnge_get_all_ethtool_adv_speeds(struct bnge_net *bn,
+				enum bnge_media_type media,
+				struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	u16 sp_nrz, sp_pam4, sp_pam4_112 = 0;
+	struct bnge_dev *bd = bn->bd;
+	u32 phy_flags;
+
+	phy_flags = bd->phy_flags;
+	sp_nrz = elink_info->advertising;
+
+	if (phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		sp_pam4 = elink_info->advertising;
+		sp_pam4_112 = elink_info->advertising;
+	} else {
+		sp_pam4 = elink_info->advertising_pam4;
+	}
+	bnge_get_ethtool_speeds(sp_nrz, media, BNGE_SIG_MODE_NRZ, phy_flags,
+				lk_ksettings->link_modes.advertising);
+	bnge_get_ethtool_speeds(sp_pam4, media, BNGE_SIG_MODE_PAM4, phy_flags,
+				lk_ksettings->link_modes.advertising);
+	bnge_get_ethtool_speeds(sp_pam4_112, media, BNGE_SIG_MODE_PAM4_112,
+				phy_flags,
+				lk_ksettings->link_modes.advertising);
+}
+
+static void
+bnge_get_all_ethtool_lp_speeds(struct bnge_dev *bd,
+			       enum bnge_media_type media,
+			       struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnge_link_info *link_info = &bd->link_info;
+	u16 sp_nrz, sp_pam4, sp_pam4_112 = 0;
+	u32 phy_flags = bd->phy_flags;
+
+	if (phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		sp_nrz = link_info->lp_auto_link_speeds;
+		sp_pam4 = link_info->lp_auto_link_speeds;
+		sp_pam4_112 = link_info->lp_auto_link_speeds;
+	} else {
+		sp_nrz = link_info->lp_auto_link_speeds;
+		sp_pam4 = link_info->lp_auto_pam4_link_speeds;
+	}
+
+	bnge_get_ethtool_speeds(sp_nrz, media, BNGE_SIG_MODE_NRZ, phy_flags,
+				lk_ksettings->link_modes.lp_advertising);
+	bnge_get_ethtool_speeds(sp_pam4, media, BNGE_SIG_MODE_PAM4, phy_flags,
+				lk_ksettings->link_modes.lp_advertising);
+	bnge_get_ethtool_speeds(sp_pam4_112, media, BNGE_SIG_MODE_PAM4_112,
+				phy_flags,
+				lk_ksettings->link_modes.lp_advertising);
+}
+
+static void bnge_update_speed(u32 *delta, bool installed_media, u16 *speeds,
+			      u16 speed_msk, const unsigned long *et_mask,
+			      enum ethtool_link_mode_bit_indices mode)
+{
+	bool mode_desired = linkmode_test_bit(mode, et_mask);
+
+	if (!mode || !mode_desired)
+		return;
+
+	/* installed media takes priority; for non-installed media, only allow
+	 * one change per fw_speed bit (many to one mapping).
+	 */
+	if (installed_media || !(*delta & speed_msk)) {
+		*speeds |= speed_msk;
+		*delta |= speed_msk;
+	}
+}
+
+static void bnge_set_ethtool_speeds(struct bnge_net *bn,
+				    const unsigned long *et_mask)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	u16 const *sp_msks, *sp_pam4_msks, *sp_pam4_112_msks = NULL;
+	u16 *adv, *adv_pam4, *adv_pam4_112 = NULL;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+	enum bnge_media_type media;
+	u32 delta_pam4_112 = 0;
+	u32 delta_pam4 = 0;
+	u32 delta_nrz = 0;
+	int i, m;
+
+	/* Zero out the masks before accumulating new bits */
+	elink_info->advertising = 0;
+	elink_info->advertising_pam4 = 0;
+
+	link_info = &bd->link_info;
+	media = bnge_get_media(link_info);
+	adv = &elink_info->advertising;
+
+	if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		adv_pam4 = &elink_info->advertising;
+		adv_pam4_112 = &elink_info->advertising;
+		sp_msks = bnge_nrz_speeds2_masks;
+		sp_pam4_msks = bnge_pam4_speeds2_masks;
+		sp_pam4_112_msks = bnge_pam4_112_speeds2_masks;
+	} else {
+		adv_pam4 = &elink_info->advertising_pam4;
+		sp_msks = bnge_nrz_speed_masks;
+		sp_pam4_msks = bnge_pam4_speed_masks;
+	}
+	for (i = 1; i < __BNGE_LINK_SPEED_END; i++) {
+		/* accept any legal media from user */
+		for (m = 1; m < __BNGE_MEDIA_END; m++) {
+			bnge_update_speed(&delta_nrz, m == media,
+					  adv, sp_msks[i], et_mask,
+					  bnge_link_modes[i][BNGE_SIG_MODE_NRZ][m]);
+			bnge_update_speed(&delta_pam4, m == media,
+					  adv_pam4, sp_pam4_msks[i], et_mask,
+					  bnge_link_modes[i][BNGE_SIG_MODE_PAM4][m]);
+			if (!adv_pam4_112)
+				continue;
+
+			bnge_update_speed(&delta_pam4_112, m == media,
+					  adv_pam4_112, sp_pam4_112_msks[i],
+					  et_mask,
+					  bnge_link_modes[i][BNGE_SIG_MODE_PAM4_112][m]);
+		}
+	}
+}
+
+static void
+bnge_fw_to_ethtool_advertised_fec(struct bnge_link_info *link_info,
+				  struct ethtool_link_ksettings *lk_ksettings)
+{
+	u16 fec_cfg = link_info->fec_cfg;
+
+	if ((fec_cfg & BNGE_FEC_NONE) || !(fec_cfg & BNGE_FEC_AUTONEG)) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_NONE_BIT,
+				 lk_ksettings->link_modes.advertising);
+		return;
+	}
+	if (fec_cfg & BNGE_FEC_ENC_BASE_R)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_BASER_BIT,
+				 lk_ksettings->link_modes.advertising);
+	if (fec_cfg & BNGE_FEC_ENC_RS)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_RS_BIT,
+				 lk_ksettings->link_modes.advertising);
+	if (fec_cfg & BNGE_FEC_ENC_LLRS)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_LLRS_BIT,
+				 lk_ksettings->link_modes.advertising);
+}
+
+static void
+bnge_fw_to_ethtool_support_fec(struct bnge_link_info *link_info,
+			       struct ethtool_link_ksettings *lk_ksettings)
+{
+	u16 fec_cfg = link_info->fec_cfg;
+
+	if (fec_cfg & BNGE_FEC_NONE) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_NONE_BIT,
+				 lk_ksettings->link_modes.supported);
+		return;
+	}
+	if (fec_cfg & BNGE_FEC_ENC_BASE_R_CAP)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_BASER_BIT,
+				 lk_ksettings->link_modes.supported);
+	if (fec_cfg & BNGE_FEC_ENC_RS_CAP)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_RS_BIT,
+				 lk_ksettings->link_modes.supported);
+	if (fec_cfg & BNGE_FEC_ENC_LLRS_CAP)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_LLRS_BIT,
+				 lk_ksettings->link_modes.supported);
+}
+
+static void bnge_get_default_speeds(struct bnge_net *bn,
+				    struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct ethtool_link_settings *base = &lk_ksettings->base;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+
+	link_info = &bd->link_info;
+
+	if (link_info->link_state == BNGE_LINK_STATE_UP) {
+		base->speed = bnge_fw_to_ethtool_speed(link_info->link_speed);
+		base->duplex = DUPLEX_HALF;
+		if (link_info->duplex & BNGE_LINK_DUPLEX_FULL)
+			base->duplex = DUPLEX_FULL;
+		lk_ksettings->lanes = link_info->active_lanes;
+	} else if (!elink_info->autoneg) {
+		base->speed =
+			bnge_fw_to_ethtool_speed(elink_info->req_link_speed);
+		base->duplex = DUPLEX_HALF;
+		if (elink_info->req_duplex == BNGE_LINK_DUPLEX_FULL)
+			base->duplex = DUPLEX_FULL;
+	}
+}
+
+int bnge_get_link_ksettings(struct net_device *dev,
+			    struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct ethtool_link_settings *base = &lk_ksettings->base;
+	enum ethtool_link_mode_bit_indices link_mode;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+	enum bnge_media_type media;
+
+	ethtool_link_ksettings_zero_link_mode(lk_ksettings, lp_advertising);
+	ethtool_link_ksettings_zero_link_mode(lk_ksettings, advertising);
+	ethtool_link_ksettings_zero_link_mode(lk_ksettings, supported);
+	base->duplex = DUPLEX_UNKNOWN;
+	base->speed = SPEED_UNKNOWN;
+	link_info = &bd->link_info;
+
+	bnge_get_ethtool_modes(bn, lk_ksettings);
+	media = bnge_get_media(link_info);
+	bnge_get_all_ethtool_support_speeds(bd, media, lk_ksettings);
+	bnge_fw_to_ethtool_support_fec(link_info, lk_ksettings);
+	link_mode = bnge_get_link_mode(bn);
+	if (link_mode != BNGE_LINK_MODE_UNKNOWN)
+		ethtool_params_from_link_mode(lk_ksettings, link_mode);
+	else
+		bnge_get_default_speeds(bn, lk_ksettings);
+
+	if (bn->eth_link_info.autoneg) {
+		bnge_fw_to_ethtool_advertised_fec(link_info, lk_ksettings);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 lk_ksettings->link_modes.advertising);
+		base->autoneg = AUTONEG_ENABLE;
+		bnge_get_all_ethtool_adv_speeds(bn, media, lk_ksettings);
+		if (link_info->phy_link_status == BNGE_LINK_LINK)
+			bnge_get_all_ethtool_lp_speeds(bd, media, lk_ksettings);
+	} else {
+		base->autoneg = AUTONEG_DISABLE;
+	}
+
+	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+			 lk_ksettings->link_modes.supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+			 lk_ksettings->link_modes.advertising);
+
+	if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC)
+		base->port = PORT_DA;
+	else
+		base->port = PORT_FIBRE;
+	base->phy_address = link_info->phy_addr;
+
+	return 0;
+}
+
+static bool bnge_lanes_match(u32 user_lanes, u32 supported_lanes)
+{
+	/* 0 means lanes unspecified (auto) */
+	return !user_lanes || user_lanes == supported_lanes;
+}
+
+static int
+bnge_force_link_speed(struct net_device *dev, u32 ethtool_speed, u32 user_lanes)
+{
+	u16 support_pam4_spds, support_spds2, support_spds;
+	struct bnge_ethtool_link_info *elink_info;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_link_info *link_info;
+	u8 sig_mode = BNGE_SIG_MODE_NRZ;
+	struct bnge_dev *bd = bn->bd;
+	u16 fw_speed = 0;
+
+	elink_info = &bn->eth_link_info;
+	link_info = &bd->link_info;
+	support_pam4_spds = link_info->support_pam4_speeds;
+	support_spds2 = link_info->support_speeds2;
+	support_spds = link_info->support_speeds;
+
+	switch (ethtool_speed) {
+	case SPEED_50000:
+		if (bnge_lanes_match(user_lanes, 1) &&
+		    (support_pam4_spds & BNGE_LINK_PAM4_SPEED_MSK_50GB)) {
+			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_50GB;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+		} else if (bnge_lanes_match(user_lanes, 1) &&
+			   (support_spds2 & BNGE_LINK_SPEEDS2_MSK_50GB_PAM4)) {
+			fw_speed = BNGE_LINK_SPEED_50GB_PAM4;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+		}
+		break;
+	case SPEED_100000:
+		if (bnge_lanes_match(user_lanes, 4) &&
+		    ((support_spds & BNGE_LINK_SPEED_MSK_100GB) ||
+		     (support_spds2 & BNGE_LINK_SPEEDS2_MSK_100GB))) {
+			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_100GB;
+		} else if (bnge_lanes_match(user_lanes, 2) &&
+			   (support_pam4_spds & BNGE_LINK_PAM4_SPEED_MSK_100GB)) {
+			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_100GB;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+		} else if (bnge_lanes_match(user_lanes, 2) &&
+			   (support_spds2 & BNGE_LINK_SPEEDS2_MSK_100GB_PAM4)) {
+			fw_speed = BNGE_LINK_SPEED_100GB_PAM4;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+		} else if (bnge_lanes_match(user_lanes, 1) &&
+			   (support_spds2 & BNGE_LINK_SPEEDS2_MSK_100GB_PAM4_112)) {
+			fw_speed = BNGE_LINK_SPEED_100GB_PAM4_112;
+			sig_mode = BNGE_SIG_MODE_PAM4_112;
+		}
+		break;
+	case SPEED_200000:
+		if (bnge_lanes_match(user_lanes, 4) &&
+		    (support_pam4_spds & BNGE_LINK_PAM4_SPEED_MSK_200GB)) {
+			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_200GB;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+		} else if (bnge_lanes_match(user_lanes, 4) &&
+			   (support_spds2 & BNGE_LINK_SPEEDS2_MSK_200GB_PAM4)) {
+			fw_speed = BNGE_LINK_SPEED_200GB_PAM4;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+		} else if (bnge_lanes_match(user_lanes, 2) &&
+			   (support_spds2 & BNGE_LINK_SPEEDS2_MSK_200GB_PAM4_112)) {
+			fw_speed = BNGE_LINK_SPEED_200GB_PAM4_112;
+			sig_mode = BNGE_SIG_MODE_PAM4_112;
+		}
+		break;
+	case SPEED_400000:
+		if (bnge_lanes_match(user_lanes, 8) &&
+		    (support_spds2 & BNGE_LINK_SPEEDS2_MSK_400GB_PAM4)) {
+			fw_speed = BNGE_LINK_SPEED_400GB_PAM4;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+		} else if (bnge_lanes_match(user_lanes, 4) &&
+			   (support_spds2 & BNGE_LINK_SPEEDS2_MSK_400GB_PAM4_112)) {
+			fw_speed = BNGE_LINK_SPEED_400GB_PAM4_112;
+			sig_mode = BNGE_SIG_MODE_PAM4_112;
+		}
+		break;
+	case SPEED_800000:
+		if (bnge_lanes_match(user_lanes, 8) &&
+		    (support_spds2 & BNGE_LINK_SPEEDS2_MSK_800GB_PAM4_112)) {
+			fw_speed = BNGE_LINK_SPEED_800GB_PAM4_112;
+			sig_mode = BNGE_SIG_MODE_PAM4_112;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (!fw_speed) {
+		if (user_lanes)
+			netdev_err(dev, "unsupported speed or number of lanes!\n");
+		else
+			netdev_err(dev, "unsupported speed!\n");
+		return -EINVAL;
+	}
+
+	if (elink_info->req_link_speed == fw_speed &&
+	    elink_info->req_signal_mode == sig_mode &&
+	    elink_info->autoneg == 0)
+		return -EALREADY;
+
+	elink_info->req_link_speed = fw_speed;
+	elink_info->req_signal_mode = sig_mode;
+	elink_info->req_duplex = BNGE_LINK_DUPLEX_FULL;
+	elink_info->autoneg = 0;
+	elink_info->advertising = 0;
+	elink_info->advertising_pam4 = 0;
+
+	return 0;
+}
+
+int bnge_set_link_ksettings(struct net_device *dev,
+			    const struct ethtool_link_ksettings *lk_ksettings)
+{
+	const struct ethtool_link_settings *base = &lk_ksettings->base;
+	struct bnge_ethtool_link_info old_elink_info;
+	struct bnge_ethtool_link_info *elink_info;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	bool set_pause = false;
+	int rc = 0;
+
+	if (!BNGE_PHY_CFG_ABLE(bd))
+		return -EOPNOTSUPP;
+
+	elink_info = &bn->eth_link_info;
+	old_elink_info = *elink_info;
+
+	if (base->autoneg == AUTONEG_ENABLE) {
+		bnge_set_ethtool_speeds(bn,
+					lk_ksettings->link_modes.advertising);
+		elink_info->autoneg |= BNGE_AUTONEG_SPEED;
+		if (!elink_info->advertising && !elink_info->advertising_pam4)
+			bnge_set_default_adv_speeds(bn);
+		/* any change to autoneg will cause link change, therefore the
+		 * driver should put back the original pause setting in autoneg
+		 */
+		if (!(bd->phy_flags & BNGE_PHY_FL_NO_PAUSE))
+			set_pause = true;
+	} else {
+		if (base->duplex == DUPLEX_HALF) {
+			netdev_err(dev, "HALF DUPLEX is not supported!\n");
+			rc = -EINVAL;
+			goto set_setting_exit;
+		}
+		rc = bnge_force_link_speed(dev, base->speed,
+					   lk_ksettings->lanes);
+		if (rc) {
+			if (rc == -EALREADY)
+				rc = 0;
+			goto set_setting_exit;
+		}
+	}
+
+	if (netif_running(dev)) {
+		rc = bnge_hwrm_set_link_setting(bn, set_pause);
+		if (rc)
+			*elink_info = old_elink_info;
+	}
+
+set_setting_exit:
+	return rc;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.h b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
index f22dec2899e3..70d0901b9a32 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
@@ -4,6 +4,8 @@
 #ifndef _BNGE_LINK_H_
 #define _BNGE_LINK_H_
 
+#include <linux/ethtool.h>
+
 #define BNGE_PHY_CFG_ABLE(bd)		\
 	((bd)->link_info.phy_enabled)
 
@@ -190,4 +192,9 @@ void bnge_report_link(struct bnge_dev *bd);
 bool bnge_support_speed_dropped(struct bnge_net *bn);
 void bnge_init_ethtool_link_settings(struct bnge_net *bn);
 int bnge_probe_phy(struct bnge_net *bn, bool fw_dflt);
+int bnge_set_link_ksettings(struct net_device *dev,
+			    const struct ethtool_link_ksettings *lk_ksettings);
+int bnge_get_link_ksettings(struct net_device *dev,
+			    struct ethtool_link_ksettings *lk_ksettings);
+u32 bnge_get_link(struct net_device *dev);
 #endif /* _BNGE_LINK_H_ */
-- 
2.47.3



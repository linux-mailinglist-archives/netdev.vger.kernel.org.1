Return-Path: <netdev+bounces-269067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIVbDh/Fumk8bwIAu9opvQ
	(envelope-from <netdev+bounces-269067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:30:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D3A2BE3BD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B2AF3279EEC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D513EB81C;
	Wed, 18 Mar 2026 15:03:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B003E5587
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846207; cv=none; b=I3dz7IWwtcMUtC6exswiOAzz14Acs0QNarSJDp+Ptoayv/0I9o+Hr9Wgvu/L/rzpi37PO9ABWg41RePuoqni12n3lPsDrJ+S4K7pNQ5Qr9WjvrEV2HPEAx5UCfP79XkmMH+EOGiC54DtD9fkUkYJKVUb6FJhPI2bOs7ID1MIpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846207; c=relaxed/simple;
	bh=tpq4CPEg4PF7xY4vX/qaHiEsjc2ICDqk3bHyi4H6/ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8l3a3AuSIjDsx8bRKGrhoMNbTB0e+XcMPlx9PdfE5ldJGF2HaD49xuT19wJ/QxNqZ9tCNvCVwJOiSON2kjha7IaHZTiBEIqQ1wyNNQMBmoWmghBGR9m4bw3k2yUXV9ipraosUt93xJf9DDOdhcW2x34bjERY+TKtnhnOVxQQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c0e3a2605fso12444eec.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846204; x=1774451004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZI1/cLnyDnVOs4qvF1/y00bhWF98dmH7Q3P7jVrTCz8=;
        b=R6lVTvD60zYS4vG0SqJhiCU1JA6/lXb4anDQHmg3ADb5FQ/4SzJGH806J11I8TpETw
         t9ap/XXkgg/OqRaPisFPASorloG+kIHRivbNV5OnNV+R5BZVGvta077IPM0uNqZLIPHg
         WbV+O2yvsZ9eLXvDSssja5pXcRUfGTFxpA+ZeP6Rga2qo7rykSCdVv31TY0UimKtBp5+
         vtK12280n7acvR6JpNY/JB/ZNcQumZkdGtCEpq+RPGZLwXy69mGX+b3jaK1uxNePcNIc
         Qiaiex7UlLkruVCKp9qTdO5VqgEoiZc4QZh4kpebI+CougWGhFAwq6kQHKe0sQ8Ik3cx
         wnGQ==
X-Gm-Message-State: AOJu0YzZnTUKER2GR7RWywsI86Q4pZN/fiGCZVRK+wezvrxEjORb8VZt
	7gzLZluvrgdhOobikvEjcS7bpzZ6bVzXwTuK9ixJfZWjZsOdS2mCjXKfS4/t
X-Gm-Gg: ATEYQzyv6y/zizhdfnt5C3//nwnNADdIORGkRUBpNDBOXzxjW2l//ZVqs2qfAxZAJVw
	XoU8o38XC6hgKa86Jt52cQBSPF0QeP9X3pSK0CYFVDx7YneU1O+9U7y9TpHRCnBQ0bpzQ5Jcj77
	WK4DuLUOvbn2e/W4dYA0fo6ZCXsqif4Mmghs2jg29Q62FNKIrp3hvIz2MGHwZfvrz/D35O9mZz0
	mcUqAHfhyZpP9gVUCDoH4mZD5JWg+e37AKtvqCulkd9PN77i6qGQClX+VeRPCyBoNv+Y5SZOOXY
	9rbdABH0pEY6gYhoeONPkJb9LJvMlCyNToCDTqIpJEISVf6Rm9aKyO+KzoNES0+8EPtil4XKJ9p
	f4PZm7gB2X95Y2UAPJbWPQUrmkpqaqPPJO+WGegKU6GbXPvOTFKLekmyVdhGuJvN4piaP47qAds
	SxCHYDcwJrve+XIU1NIAR+lNOAwtVY+nP8W4+x5sx5iJ3G6tq7xyUhl4KLk7NzcQOTAtg/ARGSZ
	nWy3aN9v+H2/lUK4A==
X-Received: by 2002:a05:7300:3724:b0:2be:126c:e335 with SMTP id 5a478bee46e88-2c0e5011ac8mr1873924eec.10.1773846202672;
        Wed, 18 Mar 2026 08:03:22 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e56062e4sm4123423eec.30.2026.03.18.08.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:22 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 09/13] iavf: convert to ndo_set_rx_mode_async
Date: Wed, 18 Mar 2026 08:03:01 -0700
Message-ID: <20260318150305.123900-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-269067-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.045];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 89D3A2BE3BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert iavf from ndo_set_rx_mode to ndo_set_rx_mode_async.
iavf_set_rx_mode now takes explicit uc/mc list parameters and
uses __hw_addr_sync_dev on the snapshots instead of __dev_uc_sync
and __dev_mc_sync.

The iavf_configure internal caller passes the real lists directly.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7925ee152c76..6632d35ad0fe 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1147,14 +1147,18 @@ bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter)
 /**
  * iavf_set_rx_mode - NDO callback to set the netdev filters
  * @netdev: network interface device structure
+ * @uc: snapshot of uc address list
+ * @mc: snapshot of mc address list
  **/
-static void iavf_set_rx_mode(struct net_device *netdev)
+static void iavf_set_rx_mode(struct net_device *netdev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
-	__dev_uc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
-	__dev_mc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(uc, netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(mc, netdev, iavf_addr_sync, iavf_addr_unsync);
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	spin_lock_bh(&adapter->current_netdev_promisc_flags_lock);
@@ -1207,7 +1211,7 @@ static void iavf_configure(struct iavf_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	iavf_set_rx_mode(netdev);
+	iavf_set_rx_mode(netdev, &netdev->uc, &netdev->mc);
 
 	iavf_configure_tx(adapter);
 	iavf_configure_rx(adapter);
@@ -5150,7 +5154,7 @@ static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_open		= iavf_open,
 	.ndo_stop		= iavf_close,
 	.ndo_start_xmit		= iavf_xmit_frame,
-	.ndo_set_rx_mode	= iavf_set_rx_mode,
+	.ndo_set_rx_mode_async	= iavf_set_rx_mode,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= iavf_set_mac,
 	.ndo_change_mtu		= iavf_change_mtu,
-- 
2.53.0



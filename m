Return-Path: <netdev+bounces-288055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eENXOPYEBmrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:23:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD485452F7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91C6C301930A
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B0390CA3;
	Thu, 14 May 2026 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWjQQI6V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44238F226
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779364; cv=none; b=qAalkqq9jSMeY2TQIRpxrADWCdUcyIhW6wsZfWqU1EqexeqEUH3Te8ULgBplvPqsWAWncHqjiM+751DhNVsywB9N/YPIfcw05QPH74GEnV4wPFRcivRPLA32rumQ/9UVSfBagDKDdpUDkcVsV4uYvl9dQtORD4seInw2qD6DAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779364; c=relaxed/simple;
	bh=Axn+PNJbdQIKENviBaH16X9CGQ2qXERThK3Y3nrH0mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2wo5cT9Io2Q1gO1zZj76dazPgzjJK2DgW9dzwGhhj3sQCy3GbQR6w9Udisb9PGDAyAbwyo30Gp+9I8zaN9pdIQDn/ViFqif/TZnk/kRTTcdkFpalGBcT/2Mgb7K/fCmuQdHPsfj0xmCS7dGpvDpusziKCG1Kn+z+aOYUwUnLls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWjQQI6V; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6587cee8b57so10215192d50.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779361; x=1779384161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYjurhmeiuV8Nqd+zpLe/ERTdzqtmQMlSYyDiJ3WcRE=;
        b=JWjQQI6V5hwGZZbg4VB9y1teFLjXB8IT/LPZ6fAsm8/kKChhRsLXEdZvKktEqUkUd7
         rdWd0G+8NlueDBPbL5CktiOrh1wOKGE/D4tcv9OfpBqZkFIFJ5tDL1YX5C0CTAy4f5m1
         3cWmtGgXzmY2CmGVG+3eEHtTeuAE0wfMBnZwWakP1U4WCl2K+V8D2GzUttOucAPiRCE/
         NZOBHtaWxuBMr1TguS4dH5PEGrylNJJAuYxe387xSJ+N4hIA0oyjKBklHGNosPMXtJpi
         8BSsXk6o6+4eCGj0VkH9GkuDBK9MIotx/oiA3LABouEMku6/FBGrabNkXcgcDRBkCQTn
         us0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779361; x=1779384161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eYjurhmeiuV8Nqd+zpLe/ERTdzqtmQMlSYyDiJ3WcRE=;
        b=nSV4y5O5JslCnY1OFpeiR/s26M1ULVjhqT0DzL3XQJZaixuAEp1xykbdXDFIkyYtgN
         hWbOVOZFqGz8rGSVUiVCZE6dNelutQgPBzTDyTrCOxqO8F4bppMfZYI8OylGVu02YBk0
         adfwZGNLyK1Ux8dvVGAjlXRvwqd/qwWK7CELCBD3RO0pUnNj0KTn2E83WUAKJikbLTnA
         pkauEGBOQQRgA6uLoEpiN0Bs79Sr2FbQlZkxw04F5UCQvfXhe7btqKnFgxXj1FxSOdKe
         wgU9ERfs0pY2ILbGpmH+DVxREzvng6BxaYfrRrTVum8wAn7T7rPUPWXLhu1nIR+FL+i2
         5aYw==
X-Forwarded-Encrypted: i=1; AFNElJ9mGcepuM5Fhns+j/qpn8wdfLCQevMXA54sO8KPockKmXceG78SERzKB27MjmMVlkDsgNH4d60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjm0V2xQjMQmBT/IsSU5Cpc3vudddk5tmGVg7G68/7KLWfk01H
	JhvBWLYS+ojyUZHvYwIL2b8t5TDmCSHCB0OuFHN1nGVgtTjOphIJ8chw
X-Gm-Gg: Acq92OFZ25k1j81TgBc+6dS6Vph31F239dscMp8h4UkpMgWSrreIdfRJzTTOFjFAdot
	fAA47frHGWnpVi+TRwJTmrNBQzXbRcRmk6eekGISAcgBoYw0Bui4XTjT+fZyIktSAmNeCrTww3T
	BmoZD7kJdB/mINa1WJoR5fmophVF7UJAojQTedCB1y+IAE11jCtLDgQh5T3uC0naIrKZmQWr6C0
	TZZl04HYIae8T6FXNeCkOmApS90rnK2xMQ/Mya+zk4s9Lf2z93fr5pFALMVmXii0wCPE8II6MrB
	VjIRy0a3QBreTYlIUkDi/GVp65zOa4evo78S+cADDdw3PNugNpTKdfabjGR6RHR4ODLjFFP0bZo
	QUgrstAJQqssaGQqUJ5cRHJ6LoSs7h8pEEcP4U/2OHnomF2N+7SjI5iZo1F1lgCpzPjckiP+yBT
	E/sYfWWy6XuH6VJ+FaFSI6YA==
X-Received: by 2002:a05:690c:6e86:b0:7bd:8d1b:b2d9 with SMTP id 00721157ae682-7c95c5ef58dmr2296487b3.47.1778779361418;
        Thu, 14 May 2026 10:22:41 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:3b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f2ba567csm16544767b3.18.2026.05.14.10.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:22:41 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 14 May 2026 10:22:28 -0700
Subject: [PATCH net-next v5 1/8] net: convert netmem_tx flag to enum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-tcp-dm-netkit-v5-1-408c59b91e66@meta.com>
References: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
In-Reply-To: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: CFD485452F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-288055-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Devices that support netmem TX previously set dev->netmem_tx = true.
This was checked in validate_xmit_unreadable_skb() to drop unreadable
skbs (skbs with dmabuf-backed frags) before they reach drivers that
would mishandle them or devices that would not have the iommu mappings
for them.

A subsequent patch will introduce a third state for virtual devices
that forward unreadable skbs without ever performing DMA on them. To
prepare for that, convert the boolean dev->netmem_tx into an enum:

NETMEM_TX_NONE   - no netmem TX support (drop unreadable skbs)
NETMEM_TX_DMA    - full support, device does DMA

Update the existing NIC drivers (bnxt, gve, mlx5, fbnic) and the
validators in net/core to use the new enum. No functional change.

Acked-by: Harshitha Ramamurthy <hramamurthy@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- netdevice.h: netmem_tx enum list -> only "device netmem TX mode" in
  comment (Stan)

Changes in v3:
- Split NO_DMA changes into subsequent commit (Jakub)
- Move !netdev->netmem_tx -> netdev->netmem_tx ==
  NETMEM_TX_NONE conversions to this patch (Jakub)

Changes in v2:
- Squash driver conversion patches (2-5) into patch 1 (Jakub)
---
 Documentation/networking/netmem.rst                    | 5 ++++-
 Documentation/translations/zh_CN/networking/netmem.rst | 4 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c              | 2 +-
 drivers/net/ethernet/google/gve/gve_main.c             | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      | 2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c         | 2 +-
 include/linux/netdevice.h                              | 7 ++++++-
 net/core/dev.c                                         | 2 +-
 net/core/netdev-genl.c                                 | 2 +-
 9 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index b63aded46337..5ccadba4f373 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -95,4 +95,7 @@ Driver TX Requirements
    netdev@, or reach out to the maintainers and/or almasrymina@google.com for
    help adding the netmem API.
 
-2. Driver should declare support by setting `netdev->netmem_tx = true`
+2. Driver should declare support by setting `netdev->netmem_tx` to the
+   appropriate mode:
+
+   - `NETMEM_TX_DMA`: for physical devices that perform DMA.
diff --git a/Documentation/translations/zh_CN/networking/netmem.rst b/Documentation/translations/zh_CN/networking/netmem.rst
index fe351a240f02..9c84423b7528 100644
--- a/Documentation/translations/zh_CN/networking/netmem.rst
+++ b/Documentation/translations/zh_CN/networking/netmem.rst
@@ -89,4 +89,6 @@ dma-mapping API 去处理。
 使用某个还不存在的 netmem API，你可以自行添加并提交到 netdev@，也可以联系维护
 人员或者发送邮件至 almasrymina@google.com 寻求帮助。
 
-2. 驱动程序应通过设置 netdev->netmem_tx = true 来表明自身支持 netmem 功能。
+2. 驱动程序应将 `netdev->netmem_tx` 设置为适当的模式：
+
+   - `NETMEM_TX_DMA`：适用于执行 DMA 的物理设备。
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 945a86696f2f..d4f93e62f583 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17123,7 +17123,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
-	dev->netmem_tx = true;
+	dev->netmem_tx = NETMEM_TX_DMA;
 
 	rc = register_netdev(dev);
 	if (rc)
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 00750643e614..e4d78ae52daf 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2894,7 +2894,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto abort_with_wq;
 
 	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
-		dev->netmem_tx = true;
+		dev->netmem_tx = NETMEM_TX_DMA;
 
 	err = register_netdev(dev);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 85b1ccbd351f..90d2979f1a4f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5966,7 +5966,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->priv_flags       |= IFF_UNICAST_FLT;
 
-	netdev->netmem_tx = true;
+	netdev->netmem_tx = NETMEM_TX_DMA;
 
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 	mlx5e_set_xdp_feature(priv);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 4dea2bb58d2f..f99ca551c1ce 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -752,7 +752,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->netdev_ops = &fbnic_netdev_ops;
 	netdev->stat_ops = &fbnic_stat_ops;
 	netdev->queue_mgmt_ops = &fbnic_queue_mgmt_ops;
-	netdev->netmem_tx = true;
+	netdev->netmem_tx = NETMEM_TX_DMA;
 
 	fbnic_set_ethtool_ops(netdev);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e7af71491a47..b7a4503f7cdb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1794,6 +1794,11 @@ enum netdev_stat_type {
 	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
 };
 
+enum netmem_tx_mode {
+	NETMEM_TX_NONE,		/* no netmem TX support */
+	NETMEM_TX_DMA,		/* DMA-capable netmem TX (real HW) */
+};
+
 enum netdev_reg_state {
 	NETREG_UNINITIALIZED = 0,
 	NETREG_REGISTERED,	/* completed register_netdevice */
@@ -1815,7 +1820,7 @@ enum netdev_reg_state {
  *	@lltx:		device supports lockless Tx. Deprecated for real HW
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
- *	@netmem_tx:	device support netmem_tx.
+ *	@netmem_tx:	device netmem TX mode
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
diff --git a/net/core/dev.c b/net/core/dev.c
index b0691e03dd6b..2da2688fe490 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3996,7 +3996,7 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	if (likely(skb_frags_readable(skb)))
 		goto out;
 
-	if (!dev->netmem_tx)
+	if (dev->netmem_tx == NETMEM_TX_NONE)
 		goto out_free;
 
 	shinfo = skb_shinfo(skb);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b8f6076d8007..4d2c49371cdb 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1164,7 +1164,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
 	}
 
-	if (!netdev->netmem_tx) {
+	if (netdev->netmem_tx == NETMEM_TX_NONE) {
 		err = -EOPNOTSUPP;
 		NL_SET_ERR_MSG(info->extack,
 			       "Driver does not support netmem TX");

-- 
2.53.0-Meta



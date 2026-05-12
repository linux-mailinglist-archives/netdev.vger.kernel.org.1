Return-Path: <netdev+bounces-286894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBATNvt/AmoZtwEAu9opvQ
	(envelope-from <netdev+bounces-286894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:18:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DECB5181D2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C70553028ECD
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5DF2773F7;
	Tue, 12 May 2026 01:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qbpa7H2W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621CC259CB2
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548696; cv=none; b=XIFGQn0t+zICLptDE1Xxgel+zWcXMGXkJ1vFr2kzzt02OFIo+XZZJU00jEyIViywq70IdNj0dFOO8S34OyeD5ra1Rn2kGN+kl74PVnMHz0Rb/ZWMwekpSKggJH1x8/K93i33Iz14zn//sRbwDQ7ZGnfw0KVPygaUUUzWGraNLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548696; c=relaxed/simple;
	bh=xHAWNIa6bT+COulf/2v7A98t6gXC0BLbleHAw2Yb5yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQ8wi5DUvH+iZifLBfqzx0gUumWuTSFsd1g5MEdq8B/Z/BokiJNLDBUcuL2ys3AtMqWd1rLyBoOpFf+7XDksiIhiXzVJB0n0IDi5DPRXXyS83YQdwEbJxJKa2JAQQl059JnKhStMQ/Ic2jtKR1tr9R3CvQywaLi8OtSk7949IIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qbpa7H2W; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-651c366f7efso5025263d50.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778548693; x=1779153493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhEXX2wI/j3jXP9rN7AH1RFGXiRqwHWcpmYOihpGEpk=;
        b=Qbpa7H2W+K5HOAuxjhfTlmImo0r2HhCdD+UDuFiBb/vT74mZcf/ff0GLqeQEV4r/yb
         wx1eaB2+0ywZWpwlJcETCgT8heMSrx1alqj8v02cjxMRwOJuxnYZX9cha7cR4psgQYv3
         m90fIvMIy937sZkDOeG8PQA/d46sY7NA9Sxcr6n0JDhhNy3l9NnYZotUA+vzqnFZs8jx
         RmZN1apH98siw355na/0rAbYmECBEvWKC4BJJJszyCCOi6O27f4jVf+baXRrBGDAnfIX
         LyoNS8SdMHBWM4CnwPzmWlzRXm554FG7jNsflL8OnYWagXT3aJ4Bzs7s3IMBCDrEEMr1
         /EYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778548693; x=1779153493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YhEXX2wI/j3jXP9rN7AH1RFGXiRqwHWcpmYOihpGEpk=;
        b=jMwWKwYPd/DODpTbFAn7Lw7d80gw9UWAazZteFoDuraymuTkIMokcNH7PzLf6PQg8p
         K8GTqAa57YhDl45LtlqxeFRm6jqL6xG3EdVIihwvOsGV+svxeQIx6MoWN20mRyGqxFU1
         3rhluXfVWsto/zHPQcHPz5vfcgYrYIj/nMaEsEO5IzaFQeqZg8RKxKSmnrLkpeVsmcEq
         5PBFFbEHx3vutMZIWQ4e3y3YHGB9FtXa9LvOOmtHbSUjN/QknhPRhy0Ns9gc9KRW1t6t
         E+JT7MoFSpNZjbskMD+JYHquY4yvbcbRD6tDn4oaiCJMsU0+LhhGhFjv5t6SwGWd2IXe
         ngvA==
X-Forwarded-Encrypted: i=1; AFNElJ+A3oIdFRtsO8jJtyWkr/WDvsEiSOZn8H2tO675+Xv0fTEcnUOtrC0L9wH0EjE8leutkyonOy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZghbV0667kkT4rgj67xJyzXdSZy/fw0gUkTV4E3OecgwzwRt
	LKqCax/qhCqQxj/byaJbkzPX4w2rM4/2d6Q5K8bX6pgiFPn3byAOKwu0
X-Gm-Gg: Acq92OHHdBzt1Jo6ICjIk3Drgl+qUod3nJjKj9CPM+JCPJh8HwjF7gFE6xG5LL9N+2+
	2lFvjbIHZH7deTLaqu8sQYeqm7nEYxDcwkGp/g304qlnGGMCk3q6gkh+SpqnM4A6D1CpOOKgwKF
	fW7W2q9DqztHh1dBISjgk3xND81mWijXq3dWUh3YEFeak3lC/AYjG4W72pOQd/plJuIyXVkeChV
	6dyHk+rinHmMD+WAt6gzJ23ZzWaakC0pyeQXQ90KQWcWeblbfIv/CBqBrEVFL8Tq7VGtrXuXaVL
	FB66wiUHu2IaUpPo66tVmpIgDkBK/psN935zw8UYuotdATOZnk8FRcD8cSJZEBEtF9Ma/EMEmgc
	ue78G24zD+v9tTbwnW4N/w14J/8+UcQxTmjChrhMunrxmlQGaQS9EHANhqpNa90h1LTIx12S9kF
	Gjs8GIzpHxRz7IyFtxNH17vw==
X-Received: by 2002:a05:690c:c4f1:b0:7bd:8752:cdbd with SMTP id 00721157ae682-7c105770e64mr120866067b3.41.1778548693125;
        Mon, 11 May 2026 18:18:13 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:3e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6683aa8asm156438147b3.26.2026.05.11.18.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:18:12 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 11 May 2026 18:17:55 -0700
Subject: [PATCH net-next v4 1/8] net: convert netmem_tx flag to enum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-tcp-dm-netkit-v4-1-841b78b99d74@meta.com>
References: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
In-Reply-To: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
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
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 3DECB5181D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-286894-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email]
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
index 8c55874f44ca..ed9c22dc4a5a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17120,7 +17120,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
-	dev->netmem_tx = true;
+	dev->netmem_tx = NETMEM_TX_DMA;
 
 	rc = register_netdev(dev);
 	if (rc)
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 424d973c97f2..dd2b8f087163 100644
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
index 5a46870c4b74..fc49aae38807 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5924,7 +5924,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->priv_flags       |= IFF_UNICAST_FLT;
 
-	netdev->netmem_tx = true;
+	netdev->netmem_tx = NETMEM_TX_DMA;
 
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 	mlx5e_set_xdp_feature(priv);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index c406a3b56b37..138e522ef9b9 100644
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
index 0e1e581efc5a..a54a37fab8d9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1788,6 +1788,11 @@ enum netdev_stat_type {
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
@@ -1809,7 +1814,7 @@ enum netdev_reg_state {
  *	@lltx:		device supports lockless Tx. Deprecated for real HW
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
- *	@netmem_tx:	device support netmem_tx.
+ *	@netmem_tx:	device netmem TX mode
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
diff --git a/net/core/dev.c b/net/core/dev.c
index 06c195906231..fbe4c328a367 100644
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



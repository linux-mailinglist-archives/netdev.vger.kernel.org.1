Return-Path: <netdev+bounces-170975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00899A4AE85
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 01:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002DE1893F39
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 00:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E58E8493;
	Sun,  2 Mar 2025 00:09:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0B23DE
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874147; cv=none; b=JVwVzcCkgjMJ5G7NmWnG7SHplX5IBcnmD5eEJAbOM45/FQdA7cLEAcPu2I/xbM7gDIWJBkWrOS4ETXwGqh1oOUz9in5H8UGVmCJx0wt7YFNtJvX7fzmQ6amK+q/dbvvztcTOKdVddk6LOQ4vQVfhN6JZ+9qrCqGpJDIr0Oi/drk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874147; c=relaxed/simple;
	bh=e2RZ1fL1R4XdvNXYg85YSmOE35mU8QxYvlx/e/l1skQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXbU4qY7uFS0cXb3uKuZ9GDzV4879NR4csWKPuq6KBzL+7qRaV5E5kyBl81bcjCQMV0LgXHN+dKXNUx/F876bbrPD9K91M0uiP3nntcG7Dp6LEmgZ/9RfsRIg1CDSYQ2aqA/nMNtlqSMlnTancjLE8NzV9AKvcI0qtSsw8QbOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2233622fdffso65099245ad.2
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 16:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740874145; x=1741478945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e4zo1Xp2Cp8gGu1NNmuAtE0p/IPgAsk9yzOPaYdj7A=;
        b=wGoJdtqeGM7K9ciGOgKETqs/k32eK9cbsYV4qDnxQjCJIICvk4cM2ZL5FWi7wGDBTi
         jpgHhrHfTN+gwFa240pAwx5GRrrSo2o+gRr6HCHj3CsAake1qc0D87INgdu18UByuoNj
         iX0frIY8npGfPbk+7XfysQleaxnDUsGvMYe0uYBd+q/OdpdZ6hkfPRjbIdz64b09kAtK
         6vflAyN9PlGSKpcuqoUAaKF0nsriXXBlXr8uPbwLq/jOcibUQAoZb84oM1+c1zrS3la8
         tC6Ms3Tys3wS/8ypXuw0R4vcuKh/RVoq/Iu7RLWpJcUwvRQo009T3EK/yRHlQn7ysD2w
         ksWw==
X-Gm-Message-State: AOJu0YwKGi7+E74MzJrWrrYhia7Q2NTnT6Dep/TTSFRxRtYdkyStc7go
	0gu4Q7lMtNN5xGHl+8emS2RzOHbPOKTH955hmfbZvo4mO53viaICHoTB
X-Gm-Gg: ASbGncuB34epaxUYefSN6EGSYl3izg26A2wvBUsR1Ac0XK9vwrt/kPbr6HOtacZ/3c7
	OBKM5zvnljRV107JTiiSnDOY7i/0r15riBryN0/vOuhxFwyWz+l0701w9Bg4aTvJrwSfzM09fVV
	dhKT42JOjhFb5qIskoj08GOwvAbvt0ocroCoH+TD7se81dh8Ih3MnO2QYA9WIesf/2doMC/jktU
	Ve8t3EIs/5E/U480SZohqBtxDeDoh9EpIV7Q0AwpxHleTAvlXFwgSWsVyFZ+KWnYaOr9Ew3P5ir
	w1Jfiipbbqj0eQiibnTx7Xvl2rYsbwLkb5DqaOHXx+hi
X-Google-Smtp-Source: AGHT+IGWDOIokJlfIw90ZVgq55gqoJQCXIc9ErgavokgK5ceMjPXAbQebw2+CSaub3yONTfx0g9UyQ==
X-Received: by 2002:a05:6a00:3e24:b0:736:4abf:2966 with SMTP id d2e1a72fcca58-7364abf2bf6mr153430b3a.22.1740874145207;
        Sat, 01 Mar 2025 16:09:05 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73609928f28sm3391471b3a.81.2025.03.01.16.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 16:09:04 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 02/14] net: hold netdev instance lock during nft ndo_setup_tc
Date: Sat,  1 Mar 2025 16:08:49 -0800
Message-ID: <20250302000901.2729164-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302000901.2729164-1-sdf@fomichev.me>
References: <20250302000901.2729164-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce new dev_setup_tc for nft ndo_setup_tc paths.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c |  2 --
 include/linux/netdevice.h                   |  2 ++
 net/core/dev.c                              | 18 ++++++++++++++++++
 net/netfilter/nf_flow_table_offload.c       |  2 +-
 net/netfilter/nf_tables_offload.c           |  2 +-
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 9f4d223dffcf..032e1a58af6f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3894,10 +3894,8 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
 	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
 		return 0;
 
-	netdev_lock(netdev);
 	netif_set_real_num_rx_queues(netdev, total_qps);
 	netif_set_real_num_tx_queues(netdev, total_qps);
-	netdev_unlock(netdev);
 
 	return ret;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 24d54c7e60c2..98c33ba5a460 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3353,6 +3353,8 @@ int dev_alloc_name(struct net_device *dev, const char *name);
 int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
 void dev_close(struct net_device *dev);
 void dev_close_many(struct list_head *head, bool unlink);
+int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		 void *type_data);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
diff --git a/net/core/dev.c b/net/core/dev.c
index 5b1b68cb4a25..6161a7a964ec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1786,6 +1786,24 @@ void dev_close(struct net_device *dev)
 }
 EXPORT_SYMBOL(dev_close);
 
+int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		 void *type_data)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (!ops->ndo_setup_tc)
+		return -EOPNOTSUPP;
+
+	netdev_lock_ops(dev);
+	ret = ops->ndo_setup_tc(dev, type, type_data);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_setup_tc);
 
 /**
  *	dev_disable_lro - disable Large Receive Offload on a device
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index e06bc36f49fe..0ec4abded10d 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1175,7 +1175,7 @@ static int nf_flow_table_offload_cmd(struct flow_block_offload *bo,
 	nf_flow_table_block_offload_init(bo, dev_net(dev), cmd, flowtable,
 					 extack);
 	down_write(&flowtable->flow_block_lock);
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_FT, bo);
+	err = dev_setup_tc(dev, TC_SETUP_FT, bo);
 	up_write(&flowtable->flow_block_lock);
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 64675f1c7f29..b761899c143c 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -390,7 +390,7 @@ static int nft_block_offload_cmd(struct nft_base_chain *chain,
 
 	nft_flow_block_offload_init(&bo, dev_net(dev), cmd, chain, &extack);
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
+	err = dev_setup_tc(dev, TC_SETUP_BLOCK, &bo);
 	if (err < 0)
 		return err;
 
-- 
2.48.1



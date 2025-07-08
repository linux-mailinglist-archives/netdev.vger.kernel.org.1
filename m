Return-Path: <netdev+bounces-205158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382F1AFDA06
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79545850CA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0956E24677A;
	Tue,  8 Jul 2025 21:38:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E21A8F84
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010719; cv=none; b=Gc3H1Fdpg0+2HvO5HXG/uw5ifDFZ9r1lZIX1hp+3OpT/P/d1ZXGT/wKZEymsyuNBxG/qJlVf1V73egpUFCiDImeOaxJD54DpGEk8/Cdb8XL+xa3qNb6AMwW63V5Hj++0B+cPiYQRiHpQsijEYWSpYL4dW62J+njbC04Go5uda2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010719; c=relaxed/simple;
	bh=jT0Y/7r7agYmEEVKBkSGm6le13BePximhUyB/DIaXG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuYjki1Yf9Up26wXTuNtZYQ+lXyXBLMsUEaxAQ3CtuJ/d/RWTkkLrLuxXobz8zqjutlvbBIhJ9LKHV0JwKCbp1TKjbzSw6g82sbV+sGhgHf2kyeclpqlCLOd8vJzZMF3NEl6s14nAdHhwzNsw6b/CYDjlNeENsPDr1swH5IyCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23694cec0feso43781675ad.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 14:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010717; x=1752615517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7r3o5kjPJgHd+ZDdWeuzehnkroPgFntKOfgM3lE/8U=;
        b=Nf+NVQMoQnP83jh3/2xWoQWvjdnVTGgPyN3C9fZnE35xBoOauaMNb5HHbDoIw2Jc5e
         /BlmRAZMGZuVMiYvJKWIoQFY4rGuZeufyTzKPYPUKdnD/7ls/IeSerbY8wxqdOyGUArO
         1YEKra/tm9iDVQbRPG5vC25AnfC4sTe3K2/pW/Fq9322APVCL7gR8qJklkJ8VPTPyG4A
         5T4zAf30EERAKEujLEiW5okbbpf5NhaTIO1XUCQeC/Y2YP8CjTr9ZILJJ1tEc575lDn5
         utbTBlXp81BQIIjqEIhSJHVEqTz6uUXOptETEAMM61SNKJSsIqQH1J8nm182TeN/BlxH
         axhQ==
X-Gm-Message-State: AOJu0Yw+u+HalvjJQ+ztccFRQazPhDBMr2idk+Ck+2OTS01UTN0rVL0J
	MtM3hUfsSn3gZvpEH3hvWeUiNL6maPLpMMtWA16U2Qr3zmQ/ObULAFKAtTWw
X-Gm-Gg: ASbGncuuDs0K/rJSNSPDxmF/1VBr2RGZ7JNLCCDN4mdMaTvpDUKoRqNUg56LO5prLFF
	c7whxThBhYFxFtVhwO5FF6C2dC7ukHTFCNxnuBh8Z7Oy/Lv4B0zqocWSzwwfMV5hP40tPVuKzxj
	Fb3H2mdIhisKSDRVnU482KL+MDrymPE/p3iFUEDH/NAmgOf2EK16T8DyOYeVGK+BR0We57O1DTC
	hrjY6BMtFThExR6lem6v4ekuYxQJ1sd6mkyjzONNeY1V8mCCBaVtdaMpU28V3AZ5oOfYbNf7GeI
	moTrcM1k49X+rBWmvBQkI57DkiPVIPzgNDXiZ30dnt5bC60OpS6G3FN7ZY9mKlbEi+Tp8IUNKWE
	DJzyfO7l/udbSm8H2h4azBlQ=
X-Google-Smtp-Source: AGHT+IGa2m13MTsJ0PX6PTxjpQetCOlsa1zGfifWL8ImxPLLEIv7n4JY4ePtz6QxZQLPyOUSMblx9w==
X-Received: by 2002:a17:902:e747:b0:235:779:ede0 with SMTP id d9443c01a7336-23ddb32d0damr532555ad.35.1752010717029;
        Tue, 08 Jul 2025 14:38:37 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8431a527sm117856375ad.26.2025.07.08.14.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:38:36 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 4/8] net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
Date: Tue,  8 Jul 2025 14:38:25 -0700
Message-ID: <20250708213829.875226-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708213829.875226-1-sdf@fomichev.me>
References: <20250708213829.875226-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cc34acd577f1 ("docs: net: document new locking reality")
introduced netif_ vs dev_ function semantics: the former expects locked
netdev, the latter takes care of the locking. We don't strictly
follow this semantics on either side, but there are more dev_xxx handlers
now that don't fit. Rename them to netif_xxx where appropriate.

netif_pre_changeaddr_notify is used only by ipvlan/bond, so move it into
NETDEV_INTERNAL namespace.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c  |  3 ++-
 drivers/net/ipvlan/ipvlan_main.c |  7 ++++---
 include/linux/netdevice.h        |  4 ++--
 net/bridge/br.c                  |  7 ++++---
 net/bridge/br_if.c               |  3 ++-
 net/core/dev.c                   | 16 ++++++++--------
 net/core/dev_addr_lists.c        |  2 +-
 7 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 69f9e8ff0101..03413570520d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1040,7 +1040,7 @@ static int bond_set_dev_addr(struct net_device *bond_dev,
 
 	slave_dbg(bond_dev, slave_dev, "bond_dev=%p slave_dev=%p slave_dev->addr_len=%d\n",
 		  bond_dev, slave_dev, slave_dev->addr_len);
-	err = dev_pre_changeaddr_notify(bond_dev, slave_dev->dev_addr, NULL);
+	err = netif_pre_changeaddr_notify(bond_dev, slave_dev->dev_addr, NULL);
 	if (err)
 		return err;
 
@@ -6743,3 +6743,4 @@ module_exit(bonding_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_AUTHOR("Thomas Davis, tadavis@lbl.gov and many others");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 0ed2fd833a5d..660f3db11766 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -784,9 +784,9 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	case NETDEV_PRE_CHANGEADDR:
 		prechaddr_info = ptr;
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
-			err = dev_pre_changeaddr_notify(ipvlan->dev,
-						    prechaddr_info->dev_addr,
-						    extack);
+			err = netif_pre_changeaddr_notify(ipvlan->dev,
+							  prechaddr_info->dev_addr,
+							  extack);
 			if (err)
 				return notifier_from_errno(err);
 		}
@@ -1094,3 +1094,4 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mahesh Bandewar <maheshb@google.com>");
 MODULE_DESCRIPTION("Driver for L3 (IPv6/IPv4) based VLANs");
 MODULE_ALIAS_RTNL_LINK("ipvlan");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2f3fba5c67c2..85c0dec0177e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4213,8 +4213,8 @@ int dev_change_net_namespace(struct net_device *dev, struct net *net,
 int __dev_set_mtu(struct net_device *, int);
 int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
-int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
-			      struct netlink_ext_ack *extack);
+int netif_pre_changeaddr_notify(struct net_device *dev, const char *addr,
+				struct netlink_ext_ack *extack);
 int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 0adeafe11a36..1885d0c315f0 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -74,9 +74,9 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 		if (br->dev->addr_assign_type == NET_ADDR_SET)
 			break;
 		prechaddr_info = ptr;
-		err = dev_pre_changeaddr_notify(br->dev,
-						prechaddr_info->dev_addr,
-						extack);
+		err = netif_pre_changeaddr_notify(br->dev,
+						  prechaddr_info->dev_addr,
+						  extack);
 		if (err)
 			return notifier_from_errno(err);
 		break;
@@ -484,3 +484,4 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(BR_VERSION);
 MODULE_ALIAS_RTNL_LINK("bridge");
 MODULE_DESCRIPTION("Ethernet bridge driver");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 2450690f98cf..98c5b9c3145f 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -668,7 +668,8 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 		/* Ask for permission to use this MAC address now, even if we
 		 * don't end up choosing it below.
 		 */
-		err = dev_pre_changeaddr_notify(br->dev, dev->dev_addr, extack);
+		err = netif_pre_changeaddr_notify(br->dev, dev->dev_addr,
+						  extack);
 		if (err)
 			goto err6;
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index 2c679d59a39c..3e2aec843645 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9689,13 +9689,13 @@ void netif_set_group(struct net_device *dev, int new_group)
 }
 
 /**
- *	dev_pre_changeaddr_notify - Call NETDEV_PRE_CHANGEADDR.
- *	@dev: device
- *	@addr: new address
- *	@extack: netlink extended ack
+ * netif_pre_changeaddr_notify() - Call NETDEV_PRE_CHANGEADDR.
+ * @dev: device
+ * @addr: new address
+ * @extack: netlink extended ack
  */
-int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
-			      struct netlink_ext_ack *extack)
+int netif_pre_changeaddr_notify(struct net_device *dev, const char *addr,
+				struct netlink_ext_ack *extack)
 {
 	struct netdev_notifier_pre_changeaddr_info info = {
 		.info.dev = dev,
@@ -9707,7 +9707,7 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 	rc = call_netdevice_notifiers_info(NETDEV_PRE_CHANGEADDR, &info.info);
 	return notifier_to_errno(rc);
 }
-EXPORT_SYMBOL(dev_pre_changeaddr_notify);
+EXPORT_SYMBOL_NS_GPL(netif_pre_changeaddr_notify, "NETDEV_INTERNAL");
 
 int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack)
@@ -9721,7 +9721,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 		return -EINVAL;
 	if (!netif_device_present(dev))
 		return -ENODEV;
-	err = dev_pre_changeaddr_notify(dev, ss->__data, extack);
+	err = netif_pre_changeaddr_notify(dev, ss->__data, extack);
 	if (err)
 		return err;
 	if (memcmp(dev->dev_addr, ss->__data, dev->addr_len)) {
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 90716bd736f3..76c91f224886 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -603,7 +603,7 @@ int dev_addr_add(struct net_device *dev, const unsigned char *addr,
 
 	ASSERT_RTNL();
 
-	err = dev_pre_changeaddr_notify(dev, addr, NULL);
+	err = netif_pre_changeaddr_notify(dev, addr, NULL);
 	if (err)
 		return err;
 	err = __hw_addr_add(&dev->dev_addrs, addr, dev->addr_len, addr_type);
-- 
2.50.0



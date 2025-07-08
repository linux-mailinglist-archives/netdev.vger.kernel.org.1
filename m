Return-Path: <netdev+bounces-205157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C512AFDA05
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42705827E3
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E0024729C;
	Tue,  8 Jul 2025 21:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2724677A
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010718; cv=none; b=ERoXR1eXI1CfI2NPDz4mf9PFQ/q3Ucbvp2Aqlluw3RzJEJ+T+3WVrQMYNh8cxgFibaOQvnYhGN3PGICzSUsi31rD+qmggy3cTu/L90onomhOFqc+1FVAwJY2UwDQ3SvMkvVK98XCR1Novk43RKocZm0oB9rfPoM4i/G1xXXJ5tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010718; c=relaxed/simple;
	bh=mHQVVVSrQ+cnLA6rwWld/5H+vek+3MEvjXANUsIMn2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed7fhwGa9VHMHU1SDaYpdpNqJuDY/W3HXt3tynzTGSLPoWrQPu4e25a2S9MCJXuBa3BvFazZpyzPMfCIS+K9cOhcn+Oecg5mjtCkrnxk60z8wFCLrVZzRKAXYnZVB4PzlTa8O3/atzQr8KbH7ontt+Kr8f+5c0N1PwbP0gP5cVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7490acf57b9so3347350b3a.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 14:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010715; x=1752615515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rD52AsXTUH6ghHNU47h2xltTlPVGl6ygVkjQ7lkK/Fs=;
        b=vGGHeiU/fT1e917Clepu39yuT8KGKiDL4z4qxbmvjJcTRO52VQqmpHwvkXFM88gYP3
         lhVK3Uuc23aFS/llpcdwPhnwq/YCcq1ovmQcO/sY/izJh8ayZGNcKbBzk8tbxi17deS3
         j8UfcmmJHpkJOvQaLJUiAJzimK66zGOeXhqeSdSfuwmL8xMwUkWxbZbHVtY7UG2HVuaB
         06/d1AfTbA1rCN30mvt6LdtNm/y/qwjfaKPRRitF/YyixTgVp/yRtuoMfQF2s773IO/H
         JkrLUpO2Yat3uj28rUCzNXa031TmY3ENZjuVfGBHKWZY8mEase4BiNjrO5DD5VOTUsPY
         0/kA==
X-Gm-Message-State: AOJu0Ywqhsxy2ZX/cgxQWU5vIZqdy2jnSSNH+DbVqtBe3IHoOflMwSQS
	RoquluPkkGM3X57V0d3pESDfvVr5HBc36uJ8KsNuSBcKOTqM5Yq2tUEuFFfv
X-Gm-Gg: ASbGnctMPfg7rwrrli75O6kWfPnNhhqSWGZgageF/lubWe3DyTFq11FQVIr9mJ/gcIZ
	AuWAjPTx/T4qGYlwdUFOBSXTTNPwm+wug2NSkFO59iYqE/5udmY2CpybrL7n/EUvFfyB51EcpBy
	jqVRwStOaHiBaMMoNH42d4Dpg1WqGLOmU1TLOxBXRMhgCt+D6azO3fdlSGG2AY+0IIVG4h8CWs0
	zf4SHdVwPr291oN0Nz7qH4WHAtOC69K4f1Z7fsdwp3D9ad6vzJxcN2MJWePk5TrIBiFACPfMu5M
	pQL7DvAV7a6M7nlhY36ZyRfON81ZU6iMKIzKUnPG8ZOA/upeDPlo0Vv5yzgce5AYBjEYtwebVpR
	Y8d8U5JDygF8Br6KTp2IigTk=
X-Google-Smtp-Source: AGHT+IFXlFbT/dcJY2CRNHlRBinTADVmQXtnd6gBHUyZFBheufIXkQZXseLQXYXeSgUqcGuXeLK+OQ==
X-Received: by 2002:a05:6a00:18a3:b0:736:4d05:2e2e with SMTP id d2e1a72fcca58-74ea643aea0mr246929b3a.6.1752010715529;
        Tue, 08 Jul 2025 14:38:35 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce35cc738sm13434920b3a.55.2025.07.08.14.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:38:35 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 3/8] net: s/dev_get_mac_address/netif_get_mac_address/
Date: Tue,  8 Jul 2025 14:38:24 -0700
Message-ID: <20250708213829.875226-4-sdf@fomichev.me>
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

netif_get_mac_address is used only by tun/tap, so move it into
NETDEV_INTERNAL namespace.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/tap.c         | 5 +++--
 drivers/net/tun.c         | 3 ++-
 include/linux/netdevice.h | 2 +-
 net/core/dev.c            | 4 ++--
 net/core/dev_ioctl.c      | 3 ++-
 net/core/net-sysfs.c      | 2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index d82eb7276a8b..1197f245e873 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1000,8 +1000,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 			return -ENOLINK;
 		}
 		ret = 0;
-		dev_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
-				    tap->dev->name);
+		netif_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
+				      tap->dev->name);
 		if (copy_to_user(&ifr->ifr_name, tap->dev->name, IFNAMSIZ) ||
 		    copy_to_user(&ifr->ifr_hwaddr, &ss, sizeof(ifr->ifr_hwaddr)))
 			ret = -EFAULT;
@@ -1282,3 +1282,4 @@ MODULE_DESCRIPTION("Common library for drivers implementing the TAP interface");
 MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
 MODULE_AUTHOR("Sainath Grandhi <sainath.grandhi@intel.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 447c37959504..b3a0264350e7 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3185,7 +3185,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 
 	case SIOCGIFHWADDR:
 		/* Get hw address */
-		dev_get_mac_address(&ifr.ifr_hwaddr, net, tun->dev->name);
+		netif_get_mac_address(&ifr.ifr_hwaddr, net, tun->dev->name);
 		if (copy_to_user(argp, &ifr, ifreq_len))
 			ret = -EFAULT;
 		break;
@@ -3694,3 +3694,4 @@ MODULE_AUTHOR(DRV_COPYRIGHT);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(TUN_MINOR);
 MODULE_ALIAS("devname:net/tun");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ac6b9e68e858..2f3fba5c67c2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4221,7 +4221,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			struct netlink_ext_ack *extack);
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr_storage *ss,
 			     struct netlink_ext_ack *extack);
-int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
+int netif_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int netif_get_port_parent_id(struct net_device *dev,
 			     struct netdev_phys_item_id *ppid, bool recurse);
 bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
diff --git a/net/core/dev.c b/net/core/dev.c
index 9ef790a9fce0..2c679d59a39c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9738,7 +9738,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 DECLARE_RWSEM(dev_addr_sem);
 
 /* "sa" is a true struct sockaddr with limited "sa_data" member. */
-int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
+int netif_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
 	size_t size = sizeof(sa->sa_data_min);
 	struct net_device *dev;
@@ -9764,7 +9764,7 @@ int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 	up_read(&dev_addr_sem);
 	return ret;
 }
-EXPORT_SYMBOL(dev_get_mac_address);
+EXPORT_SYMBOL_NS_GPL(netif_get_mac_address, "NETDEV_INTERNAL");
 
 int netif_change_carrier(struct net_device *dev, bool new_carrier)
 {
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 616479e71466..ceb2d63a818a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -728,7 +728,8 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 	switch (cmd) {
 	case SIOCGIFHWADDR:
 		dev_load(net, ifr->ifr_name);
-		ret = dev_get_mac_address(&ifr->ifr_hwaddr, net, ifr->ifr_name);
+		ret = netif_get_mac_address(&ifr->ifr_hwaddr, net,
+					    ifr->ifr_name);
 		if (colon)
 			*colon = ':';
 		return ret;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index b61cc04f1777..63c985086a9d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -256,7 +256,7 @@ static ssize_t name_assign_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(name_assign_type);
 
-/* use same locking rules as GIFHWADDR ioctl's (dev_get_mac_address()) */
+/* use same locking rules as GIFHWADDR ioctl's (netif_get_mac_address()) */
 static ssize_t address_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-- 
2.50.0



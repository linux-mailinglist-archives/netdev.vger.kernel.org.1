Return-Path: <netdev+bounces-167352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEAFA39DF4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C2216627B
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CAD269D02;
	Tue, 18 Feb 2025 13:49:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3526982E;
	Tue, 18 Feb 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886588; cv=none; b=aRo5EZxA4ghvPkyVbHuDOCIWQPZ865hqdZqRj3j1frtfRaclJy1bAHzRACpkSA+FjeYFTm8cB9dxsXCzMf4/gfz/F2HKOzTspRnXLf8t1blNJLyd6lqtbBdUpzhiCph5DIwwbxABJid1ByR+iLQnoJT9pw8+KMsAV8U1PeWelT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886588; c=relaxed/simple;
	bh=Wbew43uHoJdN5Ecry69yE2Yr3OKWVJVUUdE1jowGhoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q597uffcxNDVinMu9i9srtvVtVVUpq87xbNiEFzB7MkmhWRMU8ZDiQ8WBt+rF07MxlcVjQDVXOM8pfq+zPK1nx753+bTOQtnoAi3zzQcxRIHbQkOYa4ku19nfDS+LSDM5QEz4ogGQY0b6/YQrnHUFGag1bEx6Bn+M3XaQ/AVYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso459360466b.0;
        Tue, 18 Feb 2025 05:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739886585; x=1740491385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixuOoKIGdvMKLHJ1lQDkDlZJR6ZbqmWsSfr1BtRVrI4=;
        b=IVCCo2g4wanSMyEHh+9p6T17rL6qNoeWqxuFSTEnvSNXjyW4mhok6Jsnb/lqinj1X6
         ejnTdqQcAGjT4NcOq8Eg2IZyi2CBgliUdtZn3FsT5bjh/ePajCIULc6i2rTyWLaoHhwr
         1b/ZrZ4S7w6OwLzmYlpJI0fyLi/d/j227tsI16lIwNgOEt1pmXiIaBInbkH6KszH1AkA
         ikPth7ml4msPapSNabAdyAod/29aJt/5AUDTxwFyYIat9OMjhjcdjhAO6SlCQkwSEyhr
         jzdxe75p2Ot+SbiHAovEirJClDROaf1FLGENlNccfFj8sY34zqHZCAEVRStvaTcmeGIx
         2C+g==
X-Forwarded-Encrypted: i=1; AJvYcCWPDfBTWBMPCotduDcXuda4ZG75883OXDjkac9iTluXiNB/TXhXn5smRy8xxFk+J1uMNOU2LEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwc9bdeU7m5khRt2/t+9Cl0JuOmm0pPHjqp/xyQi4ZsT3e7GPQ
	c4lEsGnvXcfGs1MvCLEL7uKcR/MAZ27rbZ7b1OFXlIogx3rClRYZ
X-Gm-Gg: ASbGncv31lzmCLjXZyphB8QSja42BZlt0F5NXUnUb6orvZ4M7/3OJHSFJBae15p9mu9
	XN5zqnJVEPd2f0kMsirsPy8dX33M1hMzI9L1cwvZH6SvF2bhTId0oOKDx7g3NZwdTW5iFBYVbsD
	v+QfnEwCTT+7zlaouyQFWEvMhrDPI0BTWHwq9sh5+MikRgoDTfE+wm2M0nNwRA4VI6miduOLmSI
	G61m98a3wlgannUXd7va1Epwn8mbweE2PY3BK6BGYEqqmZNGmUb27olNTN43fa06YMxJaGbusXO
	9nE5rAA=
X-Google-Smtp-Source: AGHT+IEBH7XSCOHwzd0jbDg9D9BEm7FEABSoAiG0KuRgDMvRh7tj/p5sOFCyL0e20lrCBu4dzhHSRw==
X-Received: by 2002:a17:906:57cc:b0:abb:9a1e:47cb with SMTP id a640c23a62f3a-abb9a1e4826mr764723466b.55.1739886585140;
        Tue, 18 Feb 2025 05:49:45 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb96922d1dsm433057166b.50.2025.02.18.05.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:49:44 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 18 Feb 2025 05:49:30 -0800
Subject: [PATCH net v5 1/2] net: Add non-RCU dev_getbyhwaddr() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-arm_fix_selftest-v5-1-d3d6892db9e1@debian.org>
References: <20250218-arm_fix_selftest-v5-0-d3d6892db9e1@debian.org>
In-Reply-To: <20250218-arm_fix_selftest-v5-0-d3d6892db9e1@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, Breno Leitao <leitao@debian.org>, 
 kuniyu@amazon.com, ushankar@purestorage.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3663; i=leitao@debian.org;
 h=from:subject:message-id; bh=Wbew43uHoJdN5Ecry69yE2Yr3OKWVJVUUdE1jowGhoQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBntI/1tG7PVIi2fgVzSYANlpl791L/FX1TTg60+
 hL+bAsxnyaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7SP9QAKCRA1o5Of/Hh3
 bX5uD/wLWA4c5QtGcRYpGDcMuOVpzL2aVG9c4hX2jMO1+3KkF5NWyeLNsQBNSBCPwjEh22mL+yh
 guHQWpfdLH+rm8jBJ1dyNMORXfoA0dM79+eByp+Ws2+G+VyKVrDvwrgo+W5tVqpWRJWmZpEIYTa
 jsFbCdi8fAowI1yECLZ3MbZoEv1PjgXimxYL1C8jhgT7D2Bu9NdW2+osqdUMVFPYFASXwnq0Nct
 iQAhY4VAufaL3uMm0MpMUX071S35405cmHdkukK6T7Y7eiE6l3c+nmy8RecYKODwIWOS5Z3+D2N
 v0lJJ2Wdy5DV4nwmTWYmvi39uVChfd5xFBkovjN4dt8LNA5+ziqtBaA+eWU2BRIP92U8OUc8YOG
 rr6z7sIZ26rkroNI1Yhytk09VoAzZbpke4FYEnVdnsQWaUPaio/krq43qEX9MIGcZ51B27tyYC0
 v59YcReckRRxJuboyrPPidCi51dGFZHI1iNCiM/JKTlF9bx3wFBPbGQyhqD+azEW9aDZLa/S5d0
 Uq5aFT0dsQJb7cB1cx57fpgk9Cv9zSqbwKYOQB7uPvD3eWpgTecrx9JIE/6zBbx4ebPVtQpGKQ3
 BMs8TwywdoHP0ydFCgUeOyrwpEE1Gv3L8B2hCFoIb6oIH8L9GnMDD3Cv4WuQtT9WiU8lH8yjVJM
 hNrx8plvhgyhgSQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add dedicated helper for finding devices by hardware address when
holding rtnl_lock, similar to existing dev_getbyhwaddr_rcu(). This prevents
PROVE_LOCKING warnings when rtnl_lock is held but RCU read lock is not.

Extract common address comparison logic into dev_addr_cmp().

The context about this change could be found in the following
discussion:

Link: https://lore.kernel.org/all/20250206-scarlet-ermine-of-improvement-1fcac5@leitao/

Cc: kuniyu@amazon.com
Cc: ushankar@purestorage.com
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 365f0e2098d13f40ce6d8865962678b052b39a16..ab550a89b9bfaa5682e65f1dcc7f5f99ce90eb94 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3275,6 +3275,8 @@ static inline struct net_device *first_net_device_rcu(struct net *net)
 }
 
 int netdev_boot_setup_check(struct net_device *dev);
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *hwaddr);
 struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 				       const char *hwaddr);
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type);
diff --git a/net/core/dev.c b/net/core/dev.c
index 55e356a68db667982e7e62d09d07feecc14deebe..ec92fd2465c23de35187b2a9eeee0f49f98f0757 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1121,6 +1121,12 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
 	return ret;
 }
 
+static bool dev_addr_cmp(struct net_device *dev, unsigned short type,
+			 const char *ha)
+{
+	return dev->type == type && !memcmp(dev->dev_addr, ha, dev->addr_len);
+}
+
 /**
  *	dev_getbyhwaddr_rcu - find a device by its hardware address
  *	@net: the applicable net namespace
@@ -1129,7 +1135,7 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
  *
  *	Search for an interface by MAC address. Returns NULL if the device
  *	is not found or a pointer to the device.
- *	The caller must hold RCU or RTNL.
+ *	The caller must hold RCU.
  *	The returned device has not had its ref count increased
  *	and the caller must therefore be careful about locking
  *
@@ -1141,14 +1147,39 @@ struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 	struct net_device *dev;
 
 	for_each_netdev_rcu(net, dev)
-		if (dev->type == type &&
-		    !memcmp(dev->dev_addr, ha, dev->addr_len))
+		if (dev_addr_cmp(dev, type, ha))
 			return dev;
 
 	return NULL;
 }
 EXPORT_SYMBOL(dev_getbyhwaddr_rcu);
 
+/**
+ * dev_getbyhwaddr() - find a device by its hardware address
+ * @net: the applicable net namespace
+ * @type: media type of device
+ * @ha: hardware address
+ *
+ * Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
+ * rtnl_lock.
+ *
+ * Context: rtnl_lock() must be held.
+ * Return: pointer to the net_device, or NULL if not found
+ */
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *ha)
+{
+	struct net_device *dev;
+
+	ASSERT_RTNL();
+	for_each_netdev(net, dev)
+		if (dev_addr_cmp(dev, type, ha))
+			return dev;
+
+	return NULL;
+}
+EXPORT_SYMBOL(dev_getbyhwaddr);
+
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
 {
 	struct net_device *dev, *ret = NULL;

-- 
2.43.5



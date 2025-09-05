Return-Path: <netdev+bounces-220429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89712B45FA0
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1494C1CC62BB
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DAA35E4CB;
	Fri,  5 Sep 2025 17:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC6345743;
	Fri,  5 Sep 2025 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092063; cv=none; b=bYiOW8XHBIh1ecpX7nzUxksbLr0w7kjsGpvi9jrCopnNxwfXweFh30mgafxMDp7bGIi6NsbI2yXEs0y7XwlFex0jNdTYLse9o9+b7JGTzUot+IhlPKjFtP2HVtZEX3b0gtiLVtBVpyBYalbWYCCbsJd/ht4D69FKMp8T3CJt9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092063; c=relaxed/simple;
	bh=KVKSsW2WTK2b+YQKfMYkRtMIvYs5cvK6cLAuCNRNWUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q73bmMh6cUbKY93ZfxakQSC4+8C1rrpBNujkXrRYyzJFhtlU6ckG5Xi2KwBSDyswRHcUuN81GFdk+qyV5Ddg8ck6gAsL3XLwTAG8xs6mfxzgRK6CnzWn2BESUpSzloufNRIGE6Y3Iw4Or2X7ylJsW2p/hUUJzLDuVTbzr+6Hj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6229f5ed47fso509550a12.1;
        Fri, 05 Sep 2025 10:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092058; x=1757696858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkb3H3Hru4QFaSuS9oEviTp7IMbrnpNMLSXnPYRrEKg=;
        b=lVBeRSLnE3nPoo2W9x6/6pKa9kIndWonesWWmjmAyb5gK+gNOP+u+DnzemTpOJL5QN
         sm7I+Vellsrav2ohBTZ8BqSmf8nhAnkRhJMzEZt2JmJo7oxkqAWkt3lNsoCL6+ZqphPL
         fQK9GGSMZv/xR+Vz/Mof6zmYVZeawGOzCtUQYYa0N5/buSJM1n9ixTB0Henh2fuma97Z
         6BTYGFb7sapcakTjn3ZP98EEhxfe6ljDzogkbOgQuv13e3zApSFdPWS8p59LCU6897+r
         fR5F8169Fd4VSjGHaZm72h7EqEgHMwL2MzmLyU/ztuM235VXRj2kcmnWmRQC+vz5nD0v
         2MJw==
X-Forwarded-Encrypted: i=1; AJvYcCUevN2bdeA47Fxjt1n9AKVzsF650sTpnyIxAZaeAoUtSno1PVGt/Oo8RVEanynqMVWEuXXi/UtSoPA9+EE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2G23JUPhHfS6q+abzPY8JOmDfxOM4qZX+CuqZkOGPda54LoD2
	YgF3Xl47PbWHsgRMN+kTfdnyMtnM7q/Y+RF83enXj1YH24coFoRFBw5/
X-Gm-Gg: ASbGnctaZrjZBgmPbWSxKn/Fr8GuVGKpBUcC/IYyEKD0325FFZvdpVbOC36RT9FQoQ6
	kkSueHAGhpp7+wRxtV1HTIulLuGoOMl19G8SDWKsqNT04oLvO/UXj29N/j1EHzcINeLxuYGAlmW
	I2j04qeFcjMiVkUkNS9fAXulhMEKuBtPetM9pyIV5hm/DYnXG6q0cwcM84ywqcr6wSe596RAByC
	w6LlNa2HQrPt//dtgZLAwmHvnxprKLqV2gZH+kLySKhrDqSUKtQOQvymjhCdxceYP2cDLGXU0WK
	JpwIRAjSuE+8hIqJjmi7tHvhI/HvEN7dsiIbo7vOlXbRSZ8CfnYJn+4ggudPKEGEB+ZToOPh5Ff
	P2roJyezCBa9KcA==
X-Google-Smtp-Source: AGHT+IEW7PqC2/WUxYBi8+JOOLG0n7mbB0JHYUl3TfKSgMK9s6BabZvv4Lbp1/uO2+dfsZQbPoQRyg==
X-Received: by 2002:a05:6402:1e8a:b0:61c:7160:73b2 with SMTP id 4fb4d7f45d1cf-61d26ed35bbmr21799723a12.36.1757092058336;
        Fri, 05 Sep 2025 10:07:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ae40sm16609830a12.44.2025.09.05.10.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:07:37 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:07:23 -0700
Subject: [PATCH RFC net-next 4/7] net: ethtool: add get_rxrings callback to
 optimize RX ring queries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-gxrings-v1-4-984fc471f28f@debian.org>
References: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
In-Reply-To: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 jdamato@fastly.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2397; i=leitao@debian.org;
 h=from:subject:message-id; bh=KVKSsW2WTK2b+YQKfMYkRtMIvYs5cvK6cLAuCNRNWUQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBouxjS/M4wmNx9IaSekB2GdCq/oA1QNr1HRj7vF
 jpaMHABPYeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsY0gAKCRA1o5Of/Hh3
 bUo+D/wLtkI785qZ2WWIoHuckAJX+CwjwJiXB/E06jkg4U4q0K73svWKLBE5q77MDyLxZvlGKlz
 JIhUufDnHn3zg2rqZ+LxSTDE97wzmanDF6Jv7NYOqA5Q1tly2R9hyrWXFzvF+UPVPCHYNikNAJ2
 BQ7MKQE5nywYwNy51ChhT7SjELqA6Nj0qASCaoDLTT/ETjGyezrKKzN3bEMjRv8A4tyiJRIQxYF
 /a7/NQ2T+ImmCScmTsO+y8yr19n0kFJFOBN8M9fXPt0NAyNyhQCYJo0Hn7ifOEa66ahPuKxQlXv
 ATp1V4utt1u/1VdWZwmEKVAPlmfDXHQ83Njr1kZn+r/6Ek/MFJxXxjhh4/RSxu2Ty6SxxDRCoWR
 bUsYzUgZtQcvDd1mMD8cjdNeEa7cM/3oPImRwOUanFZDKAWL+F+Xz9tX6rsFdSoz8d+y+pekpYg
 9OMe/pvWYYEQ41Ym5Hh9Rq6b4JhnATH7OYDkuOyNGDuAb25Xq13PEf99J7L2EaTh5LPzHmigz22
 6Towg7bus7eOF+XwAXfjc4eB+dIi/HQt8Sw90njgY69vySsDKE8uRPTularT2vVeyV5/O78Ilde
 UcXS2kO6lcpEiMOV0vCZPL6cANjSoXxXQeJdy4TIbrLrn+eFDGA1m/BQBkGkNOecUPZtxML4yci
 0f2wXpuznziJEEw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new optional get_rxrings callback in ethtool_ops to allow drivers
to provide the number of RX rings directly without going through the
full get_rxnfc flow classification interface.

Modify ethtool_get_rxrings() to use get_rxrings() if available,
falling back to get_rxnfc() otherwise.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/ethtool.h |  1 +
 net/ethtool/ioctl.c     | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index de5bd76a400ca..4f6da35a77eb1 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1141,6 +1141,7 @@ struct ethtool_ops {
 				 struct ethtool_ringparam *,
 				 struct kernel_ethtool_ringparam *,
 				 struct netlink_ext_ack *);
+	int	(*get_rxrings)(struct net_device *dev);
 	void	(*get_pause_stats)(struct net_device *dev,
 				   struct ethtool_pause_stats *pause_stats);
 	void	(*get_pauseparam)(struct net_device *,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 1a9ad47f60313..2f3dbef9eb712 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,22 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
 }
 
+static int get_num_rxrings(struct net_device *dev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc rx_rings;
+	int ret;
+
+	if (ops->get_rxrings)
+		return ops->get_rxrings(dev);
+
+	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
+	if (ret < 0)
+		return ret;
+
+	return rx_rings.data;
+}
+
 static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 						  u32 cmd,
 						  void __user *useraddr)
@@ -1217,16 +1233,17 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int ret;
 
-	if (!ops->get_rxnfc)
+	if (!ops->get_rxnfc && !ops->get_rxrings)
 		return -EOPNOTSUPP;
 
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;
 
-	ret = ops->get_rxnfc(dev, &info, NULL);
-	if (ret < 0)
-		return ret;
+	if (WARN_ON_ONCE(info.cmd != ETHTOOL_GRXRINGS))
+		return -EOPNOTSUPP;
+
+	info.data = get_num_rxrings(dev);
 
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }

-- 
2.47.3



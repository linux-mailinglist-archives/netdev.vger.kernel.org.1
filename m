Return-Path: <netdev+bounces-222655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7509EB5544C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 18:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8AC5C711D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BE2320CC8;
	Fri, 12 Sep 2025 15:59:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4E3203B7
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692777; cv=none; b=fpNzx311OUTmyc+EcAeP7aeE5jmwkYD2Ilw9jQ2bwDbdvJ0lXpLfywTNel5cv7yKRM0TT+aGZ24jZkIw4S39KZS8RUn17u14BdWmmTp4C0ZadNl5TRpUyAq+VDLwMm63GwlUJp4Il8f0JZ9nFbE2vbyy9AKUt7ErFhoJhWsT0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692777; c=relaxed/simple;
	bh=E3RmOwFPZbM9DLJp1tUiPCsma8q5lL1T0OFqGO2M+Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XaTtVsJC2s530vCw7aBpJD7NTR7LUN0dR2kpKgAdEK1TiYakHgyeinw+DtwPMiKcbSAskDQ8pGVjpeAKWnvHxJqSZXjxUxsi020oIZHBWH9r4ON82XE5Uhs96M4Mwvjb1pVucUZqi59TqBKza0vGyuAqegKLBQksg8zY5oEY0mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b07c081660aso239058966b.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692774; x=1758297574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMV1Ua6hIXmpXxqV2akAPJgG5/fWAzzyW2yIh1KAAI8=;
        b=CM3527l+5xuihRn5Me/lCUlj24YtNFDo50Y0Z4Sby1ZTJ4cnMG4OLP9gkJo4WnwbeR
         IaX+wa/YB5ck1XGL5xOvythGUOzIN/1PgY7wPWrifKrfMluVzTUcVSxKOsHIeExESHS0
         ZhOcXTbt1lwkes1DELUUv/ne+9te/lwiBpnarmDUNgRYZOh6C6PMLxgzkJMcA/CL48HU
         nP+UYVydWKPt3D+i5CR3uK9KjdpCbjbAVTY8+NjEwBginCLjFTl4PfRx1H0xQ5j3o8l4
         IXrVg6ctHo0NIUzZOcjZlQxqj8RhE/I3a06yiQ8sJxN0SwWuo+2M+gAIWQHMEwjJdR1y
         Gkww==
X-Gm-Message-State: AOJu0Yy1IC8XHp7aJR41ziYEuNAbUfYeT/UVjnQ1oQRDwBbxWiy26TY6
	OAivgA19dDizJfArCW2Z29uIRqv2mYrEGPR6tkVfoB0hGeHiKuuoK98l
X-Gm-Gg: ASbGncsW4xpgkMtO6KMveuXHVv1DPasWe99x5ZwkwNu/7aeDqMsEfqLN1U1Fboyw7Xa
	ZJmbuP81KhkcF43dqqGfJtA3RJC16T5GE4S2TwnT5Cvp2u2BQcSLjAuOD3fi0ivD7yTL6u9HOaE
	VeYKwo6WBx9sH6ArMnKXvxCVacMxc3np3LlelW9pXZmvqPmAWpjSxJuRGx7ks6eiuCjU9NIIfXb
	yHDTcGAg7P6R4C40JLzCDymZ+ToxNDKuybWybDosFuiOjFm0CVhTxWEaIuJIS4noA5lBCjtCNGJ
	1qKpGksXFVCvcypN2xx2aKwbGK3VYzYsThm5IsvZcxWRiyMNQqp+T5J1/EVDJjzFv04lTEPBWir
	F8eXbI5yVp+cwLtBMITzIVII=
X-Google-Smtp-Source: AGHT+IHLENQM4ctxSWaRHzD35CXELlPF0xQ2QZDOg0GBNnfAUv8Rvir1NFkO+Ytu+hJ1BwFvMGZuOg==
X-Received: by 2002:a17:907:1c11:b0:b04:8420:b6ef with SMTP id a640c23a62f3a-b07c3a8c69cmr301778166b.61.1757692773973;
        Fri, 12 Sep 2025 08:59:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07ce4dbedbsm110856066b.9.2025.09.12.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:33 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:13 -0700
Subject: [PATCH net-next v2 4/7] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-4-3c7a60bbeebf@debian.org>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
In-Reply-To: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997; i=leitao@debian.org;
 h=from:subject:message-id; bh=E3RmOwFPZbM9DLJp1tUiPCsma8q5lL1T0OFqGO2M+Xs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENeWuZjr3Kfzb3cEIXrILv6NIOCvh1c54Fki
 o8uxIbHQhSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXgAKCRA1o5Of/Hh3
 bQraEACMjw2Is/lUdk7WXdz+Ghv59nuekcPDu3MUyW75gBMnC+0hByeAQz30gHvrfK0GUEqQbDn
 HWkVbyHfBFGvj752fpL+4mGnHXEqhVel4OlLMf+wGibcbV0EpsNEinN6+9lbwoX/85lTuhu8YIw
 nmER8s1WD4hddyrcio9zDZmN3auCNdunML5oOSdTd3Epqj+JaoGHV50/qHJGNi3xeGtkDvYfxOn
 93a8Ycez5vsA48m56NdP8o+2P4p3h4HwsW8cgQFBw2Wm6W3uXe/Yy3cyw2PmeqASJPtmcdHj+cV
 wTTMLS2AsfUiATRWuKrBybz8An7DXgQhgsVZ1VbRwiV3BZAYm19ltguTzrlj1SdLKD8dlNWONvE
 G013122HTafoyKx2lB6wPCjorB0ApAQFlBHo5s4uUE+BHuCS4tHG0KM8pORww3WAPt/jDZDAq6a
 h5bjZ0dJcTLSyUTNNACWvKFIKj4sQQjTO3C2H5HlnjaeiH5IEteC/T6gxEgjS2mYJf4wa/rrxEi
 sKM+CpN+B+nNWymHNsUDQxD97ahLq/m+U88Fgqs1A7RQH5ecC9kqa+WlZKaDnVxQiOcV7IZhJVZ
 BEM76fV/e81l9aDelB/2QFZJ/Ge5Pd3wghTs0ZAXm6HEh3+I12poDG5qjftSXRQWXB7iZdQv3sm
 T0+5CwRqBFEGDVw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new optional get_rx_ring_count callback in ethtool_ops to allow
drivers to provide the number of RX rings directly without going through
the full get_rxnfc flow classification interface.

Modify ethtool_get_rxrings() to use .get_rx_ring_count if available,
falling back to get_rxnfc() otherwise.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/ioctl.c     | 23 +++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index de5bd76a400ca..2d91fd3102c14 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -968,6 +968,7 @@ struct kernel_ethtool_ts_info {
  * @reset: Reset (part of) the device, as specified by a bitmask of
  *	flags from &enum ethtool_reset_flags.  Returns a negative
  *	error code or zero.
+ * @get_rx_ring_count: Return the number of RX rings
  * @get_rxfh_key_size: Get the size of the RX flow hash key.
  *	Returns zero if not supported for this specific device.
  * @get_rxfh_indir_size: Get the size of the RX flow hash indirection table.
@@ -1162,6 +1163,7 @@ struct ethtool_ops {
 	int	(*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *);
 	int	(*flash_device)(struct net_device *, struct ethtool_flash *);
 	int	(*reset)(struct net_device *, u32 *);
+	u32	(*get_rx_ring_count)(struct net_device *dev);
 	u32	(*get_rxfh_key_size)(struct net_device *);
 	u32	(*get_rxfh_indir_size)(struct net_device *);
 	int	(*get_rxfh)(struct net_device *, struct ethtool_rxfh_param *);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index a0f3de76cea03..4981db3e285d8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,23 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
 }
 
+static int ethtool_get_rx_ring_count(struct net_device *dev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc rx_rings = {};
+	int ret;
+
+	if (ops->get_rx_ring_count)
+		return ops->get_rx_ring_count(dev);
+
+	rx_rings.cmd = ETHTOOL_GRXRINGS;
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
@@ -1217,7 +1234,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	size_t info_size;
 	int ret;
 
-	if (!ops->get_rxnfc)
+	if (!ops->get_rxnfc && !ops->get_rx_ring_count)
 		return -EOPNOTSUPP;
 
 	info_size = sizeof(info);
@@ -1225,9 +1242,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	ret = ops->get_rxnfc(dev, &info, NULL);
-	if (ret < 0)
-		return ret;
+	info.data = ethtool_get_rx_ring_count(dev);
 
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }

-- 
2.47.3



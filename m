Return-Path: <netdev+bounces-222992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC2B5771C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2F23B6C32
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1B73002B6;
	Mon, 15 Sep 2025 10:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D32FF672
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933264; cv=none; b=lYhgDcB3cLOzGsc7puN6ZJCv6cI9wFOwxOR5qkmdk2c2efWX116AI9I3tBlNgDDDWR82Mor2GockixrHLt9umTAsVPJ5oc9sU6g3/GNnxJ5cysbHZsRAPn4rvkScPnw9fWB8dkgv1WNCPglfz3dQk/mrGzKatyafsZKg/2Atsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933264; c=relaxed/simple;
	bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WvfdoJgSy4G/JE5Ohq6Z5ERDhMp45rdzjzGdp0YOmFmL8NNH3oFr/8XqJmsqzNrYy6VX5e+9hQG9uw2y9ZS6ZRNY4454u2HdzCe76l8eTLJ+ujp2P2/9Vv9uVkn4HyWVOykBFqu1XONaNJ8byej/SY3mx9quwMtbPvBdvgEMAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b00a9989633so775504366b.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933261; x=1758538061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEyyDJEjHIGcptoyVMY30XDmajElEFVLCjxYGTHfuEc=;
        b=fN9SfU4ubAlxqQJbkfwKC5pM6FJtXpARk9CsL77MDU6DEQDP9a2EpesHJGRljv9SdA
         /2yYMeujywPghK4jPCc7TQt81Mt2LRGRVWMpscnR+H/FSh+jRnUHNTvE7ghvVsXOLaRF
         tA14ohcyrHmIYRywtfAap187POSMeTye+O9Ey1f4Ckt+3tGjMKYpEICh+eDsUfh6Pj/Z
         S6BTsbY/DIuF6rjQduRKlui/llLef0KdW9AZbzNUPKEZK+mM/z9S+izhjX1ZVyrS13V4
         xcLGvC1s9a6mBsBH0Ii+Iv8Ov5HClAU3b+crniF+GD+yB+ZL7YLuPeVfkyHtLvBN4qn/
         mdVQ==
X-Gm-Message-State: AOJu0YxCq3Yef6Lw3N0LaLghWDgWKxrANU+RNj13FW8TICjCyCpf5hBU
	nPWnR5o9361/aVny2keXvlaZ5tLogyxiNrevDXCipe0gMKdAb8AIZOor
X-Gm-Gg: ASbGnctgbbgQT7B7Bdz4S4KiV8/Tla14UdlpVIYFvagpjTQ74vh2OujcEXuvbZTJ9yY
	JG6ui6XQAkDDeM4uAk52oAnSI5k6enV0Tk69Bz+Bk9hzCx9U0iOpc0kBGYlkwzUroH2R+BnZN4X
	IixHrt2uEYvclh4KwdE2BfUS+kcPKXOGRkxzLr4En+HQZ140G7qSdisO70bp9cDr7zxOG9W0kDp
	gxgJyDWDjA5b+a9uFl8ABiQzeRJ/oC0Yq/H6zQGsMyo2J0WOpBq66vtbR0J96AND97REAVNx13b
	cxClIIEbjn7Pkz08UMlUbaO1Ugg2JiknfXfzvh7WP1XbEHof0rwiq5DSzh1l6PYS37la57IzjCo
	HURq6Qco1lbDWKSDSo98/Qp8=
X-Google-Smtp-Source: AGHT+IEzrAYV3e2uFiTM5MXBqo/NTJ3IVSDFCMfGVNjCDejj0OtCyUQ+mWpQqJvCtIu4AA/OwNmzVw==
X-Received: by 2002:a17:906:f58c:b0:b0b:f033:fe7 with SMTP id a640c23a62f3a-b0bf0334b15mr693100266b.31.1757933261176;
        Mon, 15 Sep 2025 03:47:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07de03d93csm533262866b.12.2025.09.15.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:27 -0700
Subject: [PATCH net-next v3 2/8] net: ethtool: add support for
 ETHTOOL_GRXRINGS ioctl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-2-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=leitao@debian.org;
 h=from:subject:message-id; bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7H8fXaiNOKNgmrDeSxkckmSM6xgV62vaFWD
 rIzghWru9iJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bULdD/415VaKUOR/BPAoiHKr1rMaIykRwiHqaJ71/dorVDr7COSHjdx3ROsO6bXUlJOENIcbVT4
 tsPHMoggNbogAspHh/sSEunFcrj9q7jqCvUZ71ez5bHLwXxRr0883cSTZINoefmTM6kL70+rLhL
 AdcTRF5Whqej4M+r1UuSOPMh5pzR5RQ9KiUgih9OdG3T4n5DMXrEBLEPhE+4DYvEPBO5GwPbQK6
 lD5+vQWWGC6z8+FeNrXyP0BigbKnr95TdRiEwca3OT+YNLRT8Fq4qGmfyvjZQSx2Sn4x7usbQ2E
 Q110qhyeAkIyvoV5iCJn9KKCdDiidJuhBO+DWWMjpcLhOv4StvpLDwRKcR2PubvitJpLBhcyBTM
 q6dxqD5Lx4YRoQ3tigHCBPYpQJyu7ZXQzIG4j+OM2O9dp7c4MzPkrsHI1wsr9azn9Ls4HwHyz0t
 Kylcz3BAMV0X42WJyyfHSJHmjAz2HEy0yl5EwjYgp4tws2VHRr1ZZ7O8LyDZ4d1fb9Hsp2ysB2v
 iKGQsGoEU8byxoLh9tDF54f5zYYKb1ppyHePkX582v8yxn3P3nBVRbJrUhYpyMg7zSpsBpWaR++
 a3YDBYh9zI/O+u9llkkmGZSSs76zBar8lHA8zcXoEnJpSFSc00WmQO2z4mnXH/WJdsD++ZbHNUH
 MBxU8fbUuOPs/Uw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch adds handling for the ETHTOOL_GRXRINGS ioctl command in the
ethtool ioctl dispatcher. It introduces a new helper function
ethtool_get_rxrings() that calls the driver's get_rxnfc() callback with
appropriate parameters to retrieve the number of RX rings supported
by the device.

By explicitly handling ETHTOOL_GRXRINGS, userspace queries through
ethtool can now obtain RX ring information in a structured manner.

In this patch, ethtool_get_rxrings() is a simply copy of
ethtool_get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 15627afa4424f..4214ab33c3c81 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,44 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
 }
 
+static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
+						  u32 cmd,
+						  void __user *useraddr)
+{
+	struct ethtool_rxnfc info;
+	size_t info_size = sizeof(info);
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	int ret;
+	void *rule_buf = NULL;
+
+	if (!ops->get_rxnfc)
+		return -EOPNOTSUPP;
+
+	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
+	if (ret)
+		return ret;
+
+	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
+		if (info.rule_cnt > 0) {
+			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
+				rule_buf = kcalloc(info.rule_cnt, sizeof(u32),
+						   GFP_USER);
+			if (!rule_buf)
+				return -ENOMEM;
+		}
+	}
+
+	ret = ops->get_rxnfc(dev, &info, rule_buf);
+	if (ret < 0)
+		goto err_out;
+
+	ret = ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, rule_buf);
+err_out:
+	kfree(rule_buf);
+
+	return ret;
+}
+
 static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
@@ -3377,6 +3415,8 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 		rc = ethtool_set_rxfh_fields(dev, ethcmd, useraddr);
 		break;
 	case ETHTOOL_GRXRINGS:
+		rc = ethtool_get_rxrings(dev, ethcmd, useraddr);
+		break;
 	case ETHTOOL_GRXCLSRLCNT:
 	case ETHTOOL_GRXCLSRULE:
 	case ETHTOOL_GRXCLSRLALL:

-- 
2.47.3



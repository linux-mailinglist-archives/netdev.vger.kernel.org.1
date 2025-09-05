Return-Path: <netdev+bounces-220426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C53B45F98
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF201CC6216
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D0231327A;
	Fri,  5 Sep 2025 17:07:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95A313269;
	Fri,  5 Sep 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092058; cv=none; b=R9sRejOxCcd2nWBvlpZ1zBDAtLznXgw8zoPTKIv1c7YpokZZerjLMKymzaBi42Kx3hSzzb/UxvHAxOyEH25nbVpbkhLFOU5y8fiS+wWNaRAY791YPhgFT0E8j6t/0FEKYduTJ+K4QzCth9dcGdqxxkek9k9BK3z0/iG2LIkSOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092058; c=relaxed/simple;
	bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jU151JupprhF44j1DMD7uEJiAbBJAVCkYMOgEng7okzf4Dvp1xvSZvt8tkmDQPnM31n1vwLRdBLMuJl0+VbOUImZI3TfjDc9VmdjsYXOc3XU5lhBzkyciIJvOSZdvFn5Xdw6Qljn8NWxfCowmgBEP6Z8yYW4trang8uULfh7YNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0475ce7f41so452415366b.1;
        Fri, 05 Sep 2025 10:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092053; x=1757696853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFEyEGuqdVSCAOxsi8hLG5VAzYgCXVIet3Kae4PlkA=;
        b=BIFd5W1NjWJis7GB+LiusMfRNmT5RC3/IbFuyDo75ym7AySHebhuYPKW343iAMAtQe
         CaFg0bqiszqZ5tvcpURMAmWZ7szsPgkiFfMJIEaf2CZ2q8HGEZQuiMQ8CL1hdkojiflt
         cdKqJfF6LDtrts+tfF98Bu0d8pNOEGUWS6K9LXS3qkQiVkkSLg/2TE2DK5v7dAuObmsw
         45KiNpT6F3dS7eQ4nVd9mMAZRfzxKeIZrhcYM6sFP+G+1/Q8b7D06PRTMKhLH1qbA4zZ
         9y7Jqm+EPOykA9F3vdIlDzQvLzuZuWmPqPcJT6txYaw2F+hO7N+0BEAI6/NBa2qz2oWE
         aADg==
X-Forwarded-Encrypted: i=1; AJvYcCVU5iCvItaML0bn21bzZKZU7zrk3j3NUlDX25eFdRYWYbzOUaqaHFbGwmq14lTEjIahhRtpJd61u42QwGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xKwAFWUqwsbCmmIPRCNT238RnSUTPxtWcrSOY+dW+dWGzuCg
	1IoBf9G4ZESj6fI9PfVj/rtz6jcEphTT8Q/j25ByLBIR0eKqopNMgAkY
X-Gm-Gg: ASbGncu6b/ZBl72Zhydo6sw15gaVU4PyZWAt9wI0W4H+HTpOzHz7Hh+QONqKFw35fLu
	sOLCc8K2xZrduTs8O3GMGEh5FS94Blhoo8rLZLJf/4LsrI57S6j/3nWFc2lkV9ivQeUqEfr1hqk
	s6igcaHpTJHc3u/c0dzZ3mcZ9fISv5QYaWcqgF2p7FyFC54flLVRIk+lV3V+kjfH/WuXxF7p+6A
	LIBgG9vKuf37jsna1jfvnsFhfa/jWKRXToXg/y6fCSjsVISzq8FN3L2D1HBrc0HWQRxfC7KfSEe
	sK2C4sZ/bgfEkrU63IxLL0KOhX8rF3Hunb34MaZmqRHKTX8epssR2siZVb2Iq3AdGrQTGiTBdOO
	3U+h8RyJp6c5t
X-Google-Smtp-Source: AGHT+IEtHKvrBZ1ElRKdXcbXiLKbzc+xq3O81Tx45cgrsAppwtCpGohC/I6pqK1UuZeX5Mbk4RqQvQ==
X-Received: by 2002:a17:906:e0d1:b0:b03:d5ca:b16 with SMTP id a640c23a62f3a-b03d5d9531cmr1967196466b.23.1757092053304;
        Fri, 05 Sep 2025 10:07:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c77d0sm17028439a12.11.2025.09.05.10.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:07:32 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:07:20 -0700
Subject: [PATCH RFC net-next 1/7] net: ethtool: pass the num of RX rings
 directly to ethtool_copy_validate_indir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-gxrings-v1-1-984fc471f28f@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=leitao@debian.org;
 h=from:subject:message-id; bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBouxjRF1LnGP+c+KeilYAqoifWv9nTDL85rRXV+
 FU+TohJLyiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsY0QAKCRA1o5Of/Hh3
 bYpRD/9Ks9DGMXwbRHetypyA0qlJPI+4Gq4Z19bsOMjk5f3rAybjEM10Km1XZ/OCXicFTz6SrxB
 XUkEf3yphmPyK7uz3Szfm9mif4zELXBPRjxhsWd5A6SoTna+KOPmSSGh3szbsRy1MdqUaub5pJQ
 /bYGkSP2g9PPsj0ccxvbOrqnf3u2IdkMmWr4q+7MIcPG+kWZx80S7ilTeFYX2beezGuKHphj94S
 +ZRmkX9lLIe5yncfw3dZJFoFeCn2MhfYYlV6Z1aFR4nCrWIHEaNjCmPDofDVlo9+1NCpAZHiDZA
 NOodn1CTbkLLikpgpVxfqX5xrUKkrKM0/tScrLjwkUGdhSCqLzqsezpHuEV0MwQzYvHpU3ea379
 /1vwOFqJBgoyeek5m6uGYT/1O2iHWDLFSy70WYoBwYnX+bw9YC6VCqQQs9FZBLFfLC2iccfSTmk
 oMOgWWYru63R2CO9gr2FR15mlw5W4P9xf7U3np790CQDj5bCRldPWtX0JTLoL04P07AICICDxa+
 y8RdB1QTT6ISmO4e8LpxtHbbO5EUjtATzIphHptGqFqXakskMUtUqhJvBDM+dHkWaGXr81xo2qu
 uXrAK+oF79crda5wqGUXEk/Et1ESIS2scZs4klqCKJ9jO1PnGL2z63c/Q3/YjAODbndYgo9dMBK
 rO0H6hvrps1tY9Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_copy_validate_indir() and callers to validate indirection
table entries against the number of RX rings as an integer instead of
accessing rx_rings->data.

This will be useful in the future, given that struct ethtool_rxnfc might
not exist for native GRXRINGS call.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b2a4d0573b38..15627afa4424f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1246,8 +1246,8 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 }
 
 static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
-					struct ethtool_rxnfc *rx_rings,
-					u32 size)
+				       int num_rx_rings,
+				       u32 size)
 {
 	int i;
 
@@ -1256,7 +1256,7 @@ static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
 
 	/* Validate ring indices */
 	for (i = 0; i < size; i++)
-		if (indir[i] >= rx_rings->data)
+		if (indir[i] >= num_rx_rings)
 			return -EINVAL;
 
 	return 0;
@@ -1366,7 +1366,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;
@@ -1587,7 +1587,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;

-- 
2.47.3



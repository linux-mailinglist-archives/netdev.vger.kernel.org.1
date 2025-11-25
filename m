Return-Path: <netdev+bounces-241493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CFBC8471A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 130DD4E9A80
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11A33019A4;
	Tue, 25 Nov 2025 10:20:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E12FE06F
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066006; cv=none; b=lDxNfwE+u5x0mnY1OTIWOSskvnFp/kgj1mTL9+GgVEY3Bjh3anfHZ5+4EAueMifzWA9uxPPJ6bGkECC87FEnCbyM/3u2Qfg5iHPSjP0vz1Tv5Y6kXaoQ2DjWNWbgkrrstbd655SAhJ3BxxazfU06Qr3hp6GfvaRto4KUYVrR4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066006; c=relaxed/simple;
	bh=dXV72bqndpkkvzq9o6QtXIzE69babSsUr1zwRzXjy7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PB3+Thnh3FbVXXyxR4aIYoSWKDpN0oNVvVKGy4NDuajGzM18xwl0NuvYYEk6qerFUk79zmVDSVkEqeyrMwCkcgG7nBPBWIRfjx74lf3Cp/eHSDCHA/FE6XbQYUjGwBFkwN8eTmlb31yoTVjzdygkbP1MQxeJKKLr4Kl+dR4040A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6574ace76dbso2137311eaf.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764066004; x=1764670804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tvbta4fVdZn9vAqQBg3FZCIOEShaAvkwCR4RcvEMvMU=;
        b=MLa5drNxNbUOl7RvX5kLoOqG6aWsGoRuqtmGtom7N9Tlvzz+eb9z0EHYYUwJlmjha5
         DGSklCgcAqmxDeMG8HBaZwQ4J1oGw6Ih3SvNaNbYHKlcg7b2v210qD4N0D+ch4bcO2QI
         +XTnZI4pBaAs7TRgRUHDp5Q9Y65QUphSQNcP2hALn9tDXlaJkcoXD8bJi/Mx/We5bczu
         ibvtTXwPM1lxeSH/xDCcUQbKeT2lAhlx9VT9Z6F7H0HKO3seqWvjaBPHHEVZJXb3gSaz
         683xjqEqYXkSKA79fVDAzJcyLcssUoIA9WOg/BSIPAT6k3wuLn00RsvsqqszQ3rFrGXJ
         iTdA==
X-Forwarded-Encrypted: i=1; AJvYcCV7A6UQ1DUkLuFLe0Kwipns77SutMFRaET1ChJaFqf1ttlqU/IVeT16/32kzj7/L4UxEwfkd2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN/49hU7345whvmlVPtuFUBO/82ZWXs/SOaSPGTbB9aeW9H7T0
	/Js0de7rB2C3yjeOFCo/2KH4ADz3p+dN4WBGVLcw7LluOYwnvLzXNygDojdWMw==
X-Gm-Gg: ASbGncun+h2fM3TWgALR9S9TbQBiuIh0OhQY4/LjTamHQSTLj4QEjKUjyzfqPkRFNI7
	KlgbkmT7ibprfV6ZOxsQ/3EOPdg75S8vLy8IE3bEwhcdiOXmbSJmw0ruU0wD73/QQIkYVQmxlwO
	a47Zju8ijknru3ppYBPtIgMkJff6pdBLToxljhrBlNOI8XrM4EI4kF1efPL1+y/clJwXEc52zIz
	gAQcULRSdShVTdXaDtx7kEZmp+el8eHOYIbJE+2Qq2fRLboiVc3F4XDnZre3otsTJNQkccNgFg9
	IvXFaQd6IpIHZH3yhgWXUMgA9RMZgR9h+5TXYf+gw1dUd5FfnKlDeLlrxfzTRPoqF4Bli5jiPUm
	V1uShVhZZT/fn4CPXy34F5Dvbi3Zob+WRf40DE7z7qDs10NkVzPOoYaQOoIiURLvJlGbPLCwtGH
	S0Tv7vbw+NN8XP67wGlezS
X-Google-Smtp-Source: AGHT+IG0n0J7rKRKrTWwDRtn+YiwdUe/ykWABXHXC6gNlvNKhYZ7bef0l5IiHuvPmD0px4kFdMhhrg==
X-Received: by 2002:a05:6830:2b0c:b0:7c7:6da2:6d6d with SMTP id 46e09a7af769-7c798c4acb9mr8363612a34.5.1764066003793;
        Tue, 25 Nov 2025 02:20:03 -0800 (PST)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d4280ddsm6145336a34.29.2025.11.25.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:20:03 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 25 Nov 2025 02:19:51 -0800
Subject: [PATCH net-next v2 8/8] fm10k: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-gxring_intel-v2-8-f55cd022d28b@debian.org>
References: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
In-Reply-To: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964; i=leitao@debian.org;
 h=from:subject:message-id; bh=dXV72bqndpkkvzq9o6QtXIzE69babSsUr1zwRzXjy7A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJYLIAMYpRybdfkoBMBylttuJo/I+zxk10WasV
 OHTbp/453GJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSWCyAAKCRA1o5Of/Hh3
 beq9D/sGrH7k8zyr42hndTHDhiu3C+5sa8ejE3PTLKXfz8VGFpSwkznKO3f7QGhI+fhLBP0aPN1
 FO/fj0bnQA55HE3/gO6mdw+Y6Y4LFlL41U3T6Z5pLty6QrgbpOKeRTVoXA7NJeNiGB1Mgyaa+O4
 2nqjhJsF93MHNuBOONOtiq1Hjz4QrbMqPLacFotgrEobYEqjR+HWYIIlrpaHcifg6Pf4J2Y6B4W
 UPV63dTdvs68k037miseUbQSqRfLa+RanPmZUby4C1TOWqfJCIjoP/XF59uWtuIhGat39Ri83oD
 sZLxizdb5iEVehz827agbw5CDq8i2E/xOveVYBGZNDNJxkgg3Dp7GFOu4dUoYJx1FqwGDSqtp+7
 T6QaUEiDadl57/vHgGTjTBLtsNRDgKfkpqeOVPAnxrILZ5mSVDiW/iFzFVT3Fik1TdvB11Cc4+X
 1U8w5+ISyAJx6jQ8Y7mO3fh10d0boHc+1EMJjY7reRm2cNvZ193tW46EaeDd72gmvUr0WYql0V+
 qMztuITVslcHA0JkDqJGoZ5ULWLF33SRDwjh/WtCnbjMlICzk5Qs4tWJ6GCj1N8cgrhJdYgRrAq
 n1oHTCrplBgL07N+ldMZpwJdZC24gl3MB2Q/jWiww8Sg64qRJA6oya4FYHqLfFH0nGQq31EMb+m
 x7CGTmvx2hs3cfw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns fm10k with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index bf2029144c1d..76e42abca965 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -734,22 +734,11 @@ static int fm10k_get_rssh_fields(struct net_device *dev,
 	return 0;
 }
 
-static int fm10k_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
-			   u32 __always_unused *rule_locs)
+static u32 fm10k_get_rx_ring_count(struct net_device *dev)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-	int ret = -EOPNOTSUPP;
 
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = interface->num_rx_queues;
-		ret = 0;
-		break;
-	default:
-		break;
-	}
-
-	return ret;
+	return interface->num_rx_queues;
 }
 
 static int fm10k_set_rssh_fields(struct net_device *dev,
@@ -1160,7 +1149,7 @@ static const struct ethtool_ops fm10k_ethtool_ops = {
 	.set_ringparam		= fm10k_set_ringparam,
 	.get_coalesce		= fm10k_get_coalesce,
 	.set_coalesce		= fm10k_set_coalesce,
-	.get_rxnfc		= fm10k_get_rxnfc,
+	.get_rx_ring_count	= fm10k_get_rx_ring_count,
 	.get_regs               = fm10k_get_regs,
 	.get_regs_len           = fm10k_get_regs_len,
 	.self_test		= fm10k_self_test,

-- 
2.47.3



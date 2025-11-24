Return-Path: <netdev+bounces-241268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B161C8211D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9954634A1F8
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C2131B837;
	Mon, 24 Nov 2025 18:19:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82FC31AF3E
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008359; cv=none; b=lr4crqaNADFqqnbIG2HLoP8bUThEfpnkoV92JLwCOVXu5bWsE/1b+wW7/CLx+eT8mgho7juT5aX3yIwO/Zjp100CqobJTO2NtoACDX5MNi/DBG+x0InOoqYN8vDb6b2pFYk5fkOrv31mFR1PrmGO7sOS4izMAYbV33YBfvLDNyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008359; c=relaxed/simple;
	bh=OgPWRRZOtLlIvXpnH4N2Q5x7CGVehFLkmP7HegABHlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQ+AJmQEUIbolNSAJwnMwUKP3zTkjOWiskUFDODZHDIGjLblF5K1pxXDyo6iuQ6AAtYkLsa9EsL7P12MhRIGTjElJv8/yOA2Beefg4oyCHFSjrMIKvs/p27+XOOG+Go6HovLo0ANTosAFetRMlqeuPJ7XbF+cfGeGIv/L0qxFRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-450b5338459so1953267b6e.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008357; x=1764613157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gjNV26TJAFnOjL0zQpnAU5UQK41rA5W+DqVt0zsSBLA=;
        b=oPuKgJWxuJUhWMHvIBtfZGh06FvHP2Bz0ZHBlVi+F4FkCqmgeegEotKaNKENQftTqr
         hhBWqnSgNK+xMfh7ZdGjKtV+HsAATSlkKdEFfcHu8+0jiKVgYJRozCGPt940fBh/cpOU
         SG8b6HYXsOT8kQ6sfWXRbB0uwTNczTWVum8Hyjer6bwzV3G5SpWyM5avArO3BWKWTJqu
         Vb7p4A7GCziLr87VCIniCKMZoEHdpXawnEMOwSQltOjWd9m1hBGGYxRUwm6Vv1vdYsXI
         h2+5S86my1ekRrOCQqksSDkDA45/WQMDljYVlAEg6DAbcSuSdIJzSaPSvmg5m4r9jgkH
         lvOg==
X-Forwarded-Encrypted: i=1; AJvYcCWbrH3iU1seN7lLSceoE/vlCGoLKi0BiigWAqChd0xARKVWRrsMfF4WZ942HBuGKmbSu+yqY0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb0wrM+TE0PzmcTuOE59p/eAungyB2nA6cqBwrOMwlQhAV6x3Y
	PM3e4ADXeLWCMvl8ZkwHsbCQ81DI6FSlpo6+6vfYa+LzDEJoDx3o4xPI
X-Gm-Gg: ASbGncvJq3erMGrqxyaEJ0tNjxDLNATIlI9pIftsz2s4sXk4DB9VrakRKpKJzujKg8E
	nbQxhFWuH4fH87ZAw+izFzTZAXq+eu81M7RLWRVKWCUTbdc5x4PhZlvs86pmvRQiFKbJlxKKcSP
	QJfahAoTNs02Nir91BgSFi5cIqUJFLbj+9Q8S0+Qls44E5KA/cmezMkvucrFqwQT7claUYTtRpI
	XY4BgzZ4XZtpAyhgffvuHAoQ+e2P1yW5W62TS+FPqnpy+L1d0itFJB2RZ0lCb3a/x98cQq/Xbt+
	x8uIrAFbokjdntDJnE1HkyAHs3BrZPESspf3iJOF2wfUquKOyYjGnAFaaHLN/c34rBd7DDbzJUD
	w8inVaeu9OYdRpbn4tEahlHjJ7vh3jaZ9iX/BWgTdUtIGoam79aDovY5bSXG2v2ra2L/6rgHL5Y
	xRWr/5h+7ZDtxp
X-Google-Smtp-Source: AGHT+IGeDs1bSrKcyEMR1LAWNGoD6UADmOpn9FxqxKFcwWK9IsLkIF4vrHt1pJ6fEsXB9A/emNN7Lw==
X-Received: by 2002:a05:6808:6f93:b0:450:c79d:92de with SMTP id 5614622812f47-45112b450c6mr5811607b6e.41.1764008356831;
        Mon, 24 Nov 2025 10:19:16 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9c2d0e96sm6447817fac.2.2025.11.24.10.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:19:16 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Nov 2025 10:19:09 -0800
Subject: [PATCH net-next 5/8] igb: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-gxring_intel-v1-5-89be18d2a744@debian.org>
References: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
In-Reply-To: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: michal.swiatkowski@linux.intel.com, michal.kubiak@intel.com, 
 maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=leitao@debian.org;
 h=from:subject:message-id; bh=OgPWRRZOtLlIvXpnH4N2Q5x7CGVehFLkmP7HegABHlM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJKGdk1P/ro4oqgHCLx8bpaolNi+8AH6vUG7RL
 FiDoNPbbwyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSShnQAKCRA1o5Of/Hh3
 bTpJD/9vLs9JgKf5MYB4HIFfvDAbTn13yYgo3usgPaeAT6+qx/GEG9fGYnkTEF2fxf8scfvcb7I
 Yp1aBgYZEqtVEs4Z2LoIVVYKSF/5XWgT/NJihnJur2xjdPykcUQWDVYvdgn063U5qfrHkq6Xgpz
 5lHxvoulLpkeYh1dOETlf5NtQrlL+A7qzW7WDIR1NBgI1T263ZRmzPZJ7RH0HyPeQI/1UGA3V+m
 FvU6opgv+GhdM1xfnpxHjDuxVXZ/Zmiipd60NA31Qa+iACTox+6tyqnhRNbKpZz3ushWvQrYE5o
 yvgZOrtm1cGiYibd+nr525ZQQLA6wK47y4vZqIBQbTIyy9IBrlxbwH+o0T0VILcG+uEpv6fhqhH
 qW7EEgG4om+xwn+gJNnYHW3CeGq6HAUe0VTx0xDKitcaj7ogLijxyAE3fOQhKcL93bT2kXQrNcr
 DXZ+qiqoiqRAffug0g1bhh+8R53cBAhZDz7ccdnsOUXA8Z5DlrjXIgp56JsqZntBi5/aVIoMLO4
 tItSuQSDDc5O4S9mUgqaSzZ7vaZVwJj+mmGEC9fxmjaQchRozK9yr+ZbkeDmjp2t3/cgBnI8A3r
 i8M/ZNpE5/a+hNq4BHxPo2ids5v+5SfCq5NHfVRduoU0Xwxq34XifHEaS5teEPlxZx1J3yQ37xN
 zrAM6wxMoEvZThw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns igb with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 10e2445e0ded..b507576b28b2 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2541,6 +2541,13 @@ static int igb_get_rxfh_fields(struct net_device *dev,
 	return 0;
 }
 
+static u32 igb_get_rx_ring_count(struct net_device *dev)
+{
+	struct igb_adapter *adapter = netdev_priv(dev);
+
+	return adapter->num_rx_queues;
+}
+
 static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			 u32 *rule_locs)
 {
@@ -2548,10 +2555,6 @@ static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_queues;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = adapter->nfc_filter_count;
 		ret = 0;
@@ -3473,6 +3476,7 @@ static const struct ethtool_ops igb_ethtool_ops = {
 	.get_ts_info		= igb_get_ts_info,
 	.get_rxnfc		= igb_get_rxnfc,
 	.set_rxnfc		= igb_set_rxnfc,
+	.get_rx_ring_count	= igb_get_rx_ring_count,
 	.get_eee		= igb_get_eee,
 	.set_eee		= igb_set_eee,
 	.get_module_info	= igb_get_module_info,

-- 
2.47.3


